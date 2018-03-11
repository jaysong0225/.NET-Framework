CREATE TABLE [dbo].[Bugs]
(
	[BugID] INT NOT NULL PRIMARY KEY IDENTITY, 
    [AppID] INT NOT NULL, 
    [UserID] INT NOT NULL, 
    [BugSignOff] INT NULL, 
    [BugDate] DATETIME NOT NULL, 
    [BugDesc] VARCHAR(40) NOT NULL, 
    [BugDetails] TEXT NOT NULL, 
    [RepSteps] TEXT NOT NULL, 
    [FixDate] DATETIME NULL, 
    CONSTRAINT [FK_Bugs_Applications] FOREIGN KEY ([AppID]) REFERENCES [Applications]([AppID]), 
    CONSTRAINT [FK_Bugs_Users1] FOREIGN KEY ([UserID]) REFERENCES [Users]([UserID]), 
    CONSTRAINT [FK_Bugs_Users2] FOREIGN KEY ([BugSignOff]) REFERENCES [Users]([UserID])
)
