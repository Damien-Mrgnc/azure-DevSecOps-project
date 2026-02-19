const express = require('express');
const router = express.Router();
const configService = require('../services/configService');
const { requireAuth, requireAdmin } = require('../middleware/auth');
const requestLogger = require('../middleware/requestLogger');

// Global Middleware
router.use(requestLogger);

// GET /config (Public)
router.get('/config', async (req, res) => {
    try {
        const config = await configService.getConfig();
        res.json(config);
    } catch (error) {
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

// Admin PUT /config (Protected)
router.put('/config', requireAuth, requireAdmin, async (req, res) => {
    try {
        const { config } = req.body;
        const updateResult = await configService.updateConfig(config, req.user.name, req.correlationId);
        res.json(updateResult);
    } catch (error) {
        if (error.code === 'P2002') res.status(409).json({ error: 'Unique constraint failed' }); // Prisma Error
        else res.status(400).json({ error: 'Invalid update' });
    }
});

module.exports = router;
