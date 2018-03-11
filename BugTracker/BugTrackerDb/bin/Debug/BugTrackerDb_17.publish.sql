﻿/*
Deployment script for BugTrackerDb

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BugTrackerDb"
:setvar DefaultFilePrefix "BugTrackerDb"
:setvar DefaultDataPath "C:\Users\NSCCStudent\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB"
:setvar DefaultLogPath "C:\Users\NSCCStudent\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creating [dbo].[Applications]...';


GO
CREATE TABLE [dbo].[Applications] (
    [AppID]      INT           IDENTITY (1, 1) NOT NULL,
    [AppName]    VARCHAR (40)  NOT NULL,
    [AppVersion] VARCHAR (40)  NOT NULL,
    [AppDesc]    VARCHAR (255) NOT NULL,
    PRIMARY KEY CLUSTERED ([AppID] ASC)
);


GO
PRINT N'Creating [dbo].[BugLog]...';


GO
CREATE TABLE [dbo].[BugLog] (
    [BugLogID]     INT      IDENTITY (1, 1) NOT NULL,
    [BugLogDate]   DATETIME NOT NULL,
    [StatusCodeID] INT      NOT NULL,
    [UserID]       INT      NOT NULL,
    [BugLogDesc]   TEXT     NOT NULL,
    [BugID]        INT      NOT NULL,
    PRIMARY KEY CLUSTERED ([BugLogID] ASC)
);


GO
PRINT N'Creating [dbo].[Bugs]...';


GO
CREATE TABLE [dbo].[Bugs] (
    [BugID]      INT          IDENTITY (1, 1) NOT NULL,
    [AppID]      INT          NOT NULL,
    [UserID]     INT          NOT NULL,
    [BugSignOff] INT          NULL,
    [BugDate]    DATETIME     NOT NULL,
    [BugDesc]    VARCHAR (40) NOT NULL,
    [BugDetails] TEXT         NOT NULL,
    [RepSteps]   TEXT         NOT NULL,
    [FixDate]    DATETIME     NULL,
    PRIMARY KEY CLUSTERED ([BugID] ASC)
);


GO
PRINT N'Creating [dbo].[StatusCodes]...';


GO
CREATE TABLE [dbo].[StatusCodes] (
    [StatusCodeId]   INT          IDENTITY (1, 1) NOT NULL,
    [StatusCodeDesc] VARCHAR (40) NOT NULL,
    PRIMARY KEY CLUSTERED ([StatusCodeId] ASC)
);


GO
PRINT N'Creating [dbo].[Users]...';


GO
CREATE TABLE [dbo].[Users] (
    [UserID]    INT          IDENTITY (1, 1) NOT NULL,
    [UserName]  VARCHAR (80) NOT NULL,
    [UserEmail] VARCHAR (80) NOT NULL,
    [UserTel]   VARCHAR (40) NOT NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[BugLog]...';


GO
ALTER TABLE [dbo].[BugLog]
    ADD DEFAULT GetDate() FOR [BugLogDate];


GO
PRINT N'Creating [dbo].[FK_BugLog_StatusCodes]...';


GO
ALTER TABLE [dbo].[BugLog] WITH NOCHECK
    ADD CONSTRAINT [FK_BugLog_StatusCodes] FOREIGN KEY ([StatusCodeID]) REFERENCES [dbo].[StatusCodes] ([StatusCodeId]);


GO
PRINT N'Creating [dbo].[FK_BugLog_Users]...';


GO
ALTER TABLE [dbo].[BugLog] WITH NOCHECK
    ADD CONSTRAINT [FK_BugLog_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]);


GO
PRINT N'Creating [dbo].[FK_BugLog_Bugs]...';


GO
ALTER TABLE [dbo].[BugLog] WITH NOCHECK
    ADD CONSTRAINT [FK_BugLog_Bugs] FOREIGN KEY ([BugID]) REFERENCES [dbo].[Bugs] ([BugID]);


GO
PRINT N'Creating [dbo].[FK_Bugs_Applications]...';


GO
ALTER TABLE [dbo].[Bugs] WITH NOCHECK
    ADD CONSTRAINT [FK_Bugs_Applications] FOREIGN KEY ([AppID]) REFERENCES [dbo].[Applications] ([AppID]);


GO
PRINT N'Creating [dbo].[FK_Bugs_Users1]...';


GO
ALTER TABLE [dbo].[Bugs] WITH NOCHECK
    ADD CONSTRAINT [FK_Bugs_Users1] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]);


GO
PRINT N'Creating [dbo].[FK_Bugs_Users2]...';


GO
ALTER TABLE [dbo].[Bugs] WITH NOCHECK
    ADD CONSTRAINT [FK_Bugs_Users2] FOREIGN KEY ([BugSignOff]) REFERENCES [dbo].[Users] ([UserID]);


GO
PRINT N'Altering [dbo].[AddNewBug]...';


GO

ALTER PROCEDURE [dbo].[AddNewBug]
	@UserID int
	,@AppID int
	,@BugDate DATETIME
	,@BugDesc varchar(40)
	,@BugDetails text
	,@RepSteps text
AS
BEGIN 
	SET NOCOUNT ON;

	DECLARE @BugID AS int

	BEGIN TRY
		BEGIN TRANSACTION;
			INSERT INTO Bugs (AppID, UserID, BugDate, BugDesc, BugDetails, RepSteps) 
				VALUES(@AppID, @UserID, @BugDate, @BUgDesc, @BugDetails, @RepSteps);

			set @BugID = SCOPE_IDENTITY()

			INSERT INTO BugLog (BugLogDate, StatusCodeID, UserID, BugLogDesc, BugID) 
				VALUES(GetDate(), 1, @UserID, 'initial bug entered', @BugID);
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        -- Rollback any active or uncommittable transactions before
        -- inserting information in the ErrorLog
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
	END CATCH;
END;
GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

IF NOT EXISTS (SELECT 1 FROM StatusCodes WHERE statusCodeDesc = 'Unassigned')
BEGIN
	/* Seed Data for StatusCodes Table */
	INSERT INTO StatusCodes (statusCodeDesc) VALUES('Unassigned');
	INSERT INTO StatusCodes (statusCodeDesc) VALUES('In Progress');
	INSERT INTO StatusCodes (statusCodeDesc) VALUES('Ready for Review');
	INSERT INTO StatusCodes (statusCodeDesc) VALUES('Closed');

	/* Seed Data for Users Table */
	INSERT INTO Users (UserName, UserEmail, UserTel) 
				VALUES('administrator', 'admin@nscc.ca', '9024121234');
	INSERT INTO Users (UserName, UserEmail, UserTel) 
				VALUES('jay', 'jay@nscc.ca', '9024124567');
	INSERT INTO Users (UserName, UserEmail, UserTel) 
				VALUES('michael', 'michael@nscc.ca', '9024128926');
	INSERT INTO Users (UserName, UserEmail, UserTel) 
				VALUES('jacob', 'jacob@nscc.ca', '9024126382');
	INSERT INTO Users (UserName, UserEmail, UserTel) 
				VALUES('mary', 'mary@nscc.ca', '9024123529');

	/* Seed Data for Applications Table */
	INSERT INTO Applications ('Application1', '1.0', 'Desc of Application1')
			VALUES(@AppName, @AppVersion, @AppDesc);
	INSERT INTO Applications ('Application2', '1.0', 'Desc of Application2')
			VALUES(@AppName, @AppVersion, @AppDesc);

	/* Seed Data for Bugs Table */
	INSERT INTO Bugs (AppID, UserID, BugDate, BugDesc, BugDetails, RepSteps) 
			VALUES(1, 2, '1/23/2018 8:13:11 PM', 'Bug Description1', 'Bug Details1', 'Reproduction Step1');

	/* Seed Data for BugLog Table */
	INSERT INTO BugLog (BugLogDate, StatusCodeID, UserID, BugLogDesc, BugID) 
			VALUES(GetDate(), 1, 2, 'initial bug entered', 1);
END
GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[BugLog] WITH CHECK CHECK CONSTRAINT [FK_BugLog_StatusCodes];

ALTER TABLE [dbo].[BugLog] WITH CHECK CHECK CONSTRAINT [FK_BugLog_Users];

ALTER TABLE [dbo].[BugLog] WITH CHECK CHECK CONSTRAINT [FK_BugLog_Bugs];

ALTER TABLE [dbo].[Bugs] WITH CHECK CHECK CONSTRAINT [FK_Bugs_Applications];

ALTER TABLE [dbo].[Bugs] WITH CHECK CHECK CONSTRAINT [FK_Bugs_Users1];

ALTER TABLE [dbo].[Bugs] WITH CHECK CHECK CONSTRAINT [FK_Bugs_Users2];


GO
PRINT N'Update complete.';


GO