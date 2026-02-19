const { z } = require('zod');

// Schéma de Configuration :
// Clés autorisées : siteTitle, siteDescription, maintenanceMode, theme.
// Validation stricte.

const configUpdateSchema = z.object({
    siteTitle: z.string()
        .min(1, 'Title needed')
        .max(200, 'Title too long'),
    siteDescription: z.string()
        .min(1, 'Description needed')
        .max(500, 'Description too long'),
    maintenanceMode: z.boolean(),
    theme: z.enum(['light', 'dark'])
});

module.exports = { configUpdateSchema };
