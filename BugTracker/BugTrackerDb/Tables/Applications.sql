CREATE TABLE [dbo].[Applications]
(
	[AppID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [AppName] VARCHAR(40) NOT NULL, 
    [AppVersion] VARCHAR(40) NOT NULL, 
    [AppDesc] VARCHAR(255) NOT NULL
)
