const logger = require('../config/logger');

const requestLogger = (req, res, next) => {
    // Generate a correlation ID
    req.correlationId = req.headers['x-correlation-id'] || require('crypto').randomUUID();

    // Log on arrival
    logger.info(`Incoming Request`, {
        method: req.method,
        url: req.url,
        correlationId: req.correlationId,
        userAgent: req.get('user-agent'),
        ip: req.ip
    });

    // Log on exit (optional)
    res.on('finish', () => {
        logger.info(`Response Sent`, {
            method: req.method,
            url: req.url,
            statusCode: res.statusCode,
            correlationId: req.correlationId
        });
    });

    next();
};

module.exports = requestLogger;
