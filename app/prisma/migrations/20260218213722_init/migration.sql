BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[AppConfig] (
    [keyName] NVARCHAR(200) NOT NULL,
    [value] NVARCHAR(max),
    [updatedAt] DATETIME2 NOT NULL,
    [updatedBy] NVARCHAR(256),
    CONSTRAINT [AppConfig_pkey] PRIMARY KEY CLUSTERED ([keyName])
);

-- CreateTable
CREATE TABLE [dbo].[AppConfigAudit] (
    [id] INT NOT NULL IDENTITY(1,1),
    [keyName] NVARCHAR(200) NOT NULL,
    [oldValue] NVARCHAR(max),
    [newValue] NVARCHAR(max),
    [changedBy] NVARCHAR(256),
    [changedAt] DATETIME2 NOT NULL CONSTRAINT [AppConfigAudit_changedAt_df] DEFAULT CURRENT_TIMESTAMP,
    [correlationId] NVARCHAR(100),
    CONSTRAINT [AppConfigAudit_pkey] PRIMARY KEY CLUSTERED ([id])
);

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
