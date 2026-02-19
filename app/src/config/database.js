const { PrismaClient } = require('@prisma/client');
const logger = require('./logger');

// Prisma will default to DATABASE_URL from the environment.
// In Azure, this variable will be injected via App Settings (Terraform).
// Expected format for Managed Identity:
// sqlserver://server.database.windows.net:1433;database=db;authenticationType=azure-active-directory-msi;encrypt=true

const prisma = new PrismaClient({
    log: [
        { emit: 'event', level: 'query' },
        { emit: 'stdout', level: 'info' },
        { emit: 'stdout', level: 'warn' },
        { emit: 'stdout', level: 'error' },
    ],
});

prisma.$on('query', (e) => {
    if (process.env.NODE_ENV !== 'production') {
        logger.debug('Query: ' + e.query);
        logger.debug('Duration: ' + e.duration + 'ms');
    }
});


module.exports = prisma;
