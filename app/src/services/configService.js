const prisma = require('../config/database');
const logger = require('../config/logger');

// Get current config (with default values if empty)
async function getConfig() {
    // List of expected keys
    const keys = ['siteTitle', 'siteDescription', 'maintenanceMode', 'theme'];

    // Search in DB
    const configs = await prisma.appConfig.findMany({
        where: { keyName: { in: keys } },
    });

    // Map DB result to simple object
    const defaultConfig = {
        siteTitle: 'Default Title',
        siteDescription: 'Default Description',
        maintenanceMode: false,
        theme: 'light',
    };

    const result = { ...defaultConfig };

    configs.forEach((c) => {
        if (c.value === 'true' || c.value === 'false') {
            result[c.keyName] = c.value === 'true';
        } else {
            result[c.keyName] = c.value;
        }
    });

    return result;
}

// Update config (Transaction + Audit)
async function updateConfig(newConfig, changedBy = 'system', correlationId) {
    logger.info(`Updating config by ${changedBy}`, { newConfig, correlationId });

    // 1. Read existing state for Audit (oldValue)
    const existingRecords = await prisma.appConfig.findMany({
        where: { keyName: { in: Object.keys(newConfig) } }
    });

    const existingMap = new Map();
    existingRecords.forEach(r => existingMap.set(r.keyName, r.value));

    const operations = [];

    for (const [key, val] of Object.entries(newConfig)) {
        const stringVal = String(val);
        const oldVal = existingMap.get(key);

        // If no change, skip (optimization)
        if (oldVal === stringVal) continue;

        // Update/Upsert Config Operation
        operations.push(
            prisma.appConfig.upsert({
                where: { keyName: key },
                update: { value: stringVal, updatedBy: changedBy },
                create: { keyName: key, value: stringVal, updatedBy: changedBy }
            })
        );

        // Insert Audit Operation
        operations.push(
            prisma.appConfigAudit.create({
                data: {
                    keyName: key,
                    oldValue: oldVal,
                    newValue: stringVal,
                    changedBy: changedBy,
                    correlationId: correlationId || 'unknown'
                }
            })
        );
    }

    if (operations.length > 0) {
        // Atomic execution
        await prisma.$transaction(operations);
        logger.info(`Configuration updated successfully (${operations.length / 2} keys changed)`, { correlationId });
    } else {
        logger.info('No changes detected in configuration update', { correlationId });
    }

    return getConfig(); // Return fresh state
}

// Retrieve modification history
async function getAuditLogs() {
    return await prisma.appConfigAudit.findMany({
        orderBy: { changedAt: 'desc' },
        take: 50
    });
}

module.exports = {
    getConfig,
    updateConfig,
    getAuditLogs
};
