const winston = require('winston');

const logger = winston.createLogger({
    level: process.env.NODE_ENV === 'production' ? 'info' : 'debug',
    format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.json() // JSON format mandatory for Azure
    ),
    defaultMeta: { service: 'runtime-governance-app' },
    transports: [
        new winston.transports.Console() // Everything goes to stdout (captured by Azure)
    ],
});

module.exports = logger;
