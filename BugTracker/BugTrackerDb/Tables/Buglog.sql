CREATE TABLE [dbo].[BugLog]
(
	[BugLogID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [BugLogDate] DATETIME NOT NULL DEFAULT GetDate(), 
    [StatusCodeID] INT NOT NULL, 
    [UserID] INT NOT NULL, 
    [BugLogDesc] TEXT NOT NULL, 
    [BugID] INT NOT NULL, 
    CONSTRAINT [FK_BugLog_StatusCodes] FOREIGN KEY ([StatusCodeID]) REFERENCES [StatusCodes]([StatusCodeID]), 
    CONSTRAINT [FK_BugLog_Users] FOREIGN KEY ([UserID]) REFERENCES [Users]([UserID]), 
    CONSTRAINT [FK_BugLog_Bugs] FOREIGN KEY ([BugID]) REFERENCES [Bugs]([BugID])
)
