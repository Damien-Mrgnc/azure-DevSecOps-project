const logger = require('../config/logger');

// App Service decodes/passes info in X-MS-CLIENT-PRINCIPAL-... headers
// This middleware reads these headers to reconstruct identity.
// To be strict in LOCAL (without Azure), simulate via .vars or bypass.

function requireAuth(req, res, next) {
    if (process.env.NODE_ENV === 'development') {
        // Mock in dev to avoid local EasyAuth complexity
        req.user = {
            name: 'dev-admin',
            roles: ['AppAdmin']
        };
        return next();
    }

    const principalId = req.headers['x-ms-client-principal-id'];
    const principalName = req.headers['x-ms-client-principal-name'];
    const principalEncoded = req.headers['x-ms-client-principal'];

    if (!principalId && !principalName) {
        logger.warn('Unauthorized access attempt (missing x-ms-client headers)');
        return res.status(401).send('Unauthorized. Please ensure App Service Authentication is enabled.');
    }

    try {
        let userRoles = [];
        if (principalEncoded) {
            const buffer = Buffer.from(principalEncoded, 'base64');
            const decoded = JSON.parse(buffer.toString('utf-8'));
            // decoded.claims contains roles if configured in App Registration
            // But often with simple EasyAuth, we just have identity.
            // We assume here that any authenticated AAD user in the org is "User".
            userRoles = decoded.user_roles || []; // Depends on EasyAuth config
        }

        req.user = {
            id: principalId,
            name: principalName,
            roles: userRoles // Map according to real configuration
        };

        next();
    } catch (e) {
        logger.error('Error decoding principal', e);
        res.status(403).send('Forbidden (Invalid Token)');
    }
}

function requireAdmin(req, res, next) {
    // In this simple POC, just require authentication for admin.
    // To go further, verify req.user.roles.includes('AppAdmin').
    if (!req.user) {
        return res.status(401).send('Unauthorized');
    }
    // TODO: Implement real RBAC logic if needed
    next();
}

module.exports = { requireAuth, requireAdmin };
