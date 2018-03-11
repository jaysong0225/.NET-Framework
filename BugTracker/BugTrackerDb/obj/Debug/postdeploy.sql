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
	INSERT INTO Applications (AppName, AppVersion, AppDesc)
			VALUES('Ability Office Spreadsheet', '1.0', 
				'Included with Ex-Lex Office Pro and many others from SSuite');
	INSERT INTO Applications (AppName, AppVersion, AppDesc)
			VALUES('Voice Search', '2.4.6', 
				'Voice Search makes it faster and easier than ever to search apps, web search, or image search for the content you want.');
	INSERT INTO Applications (AppName, AppVersion, AppDesc)
			VALUES('Pixel Art - Colour by Number Book', '1.5', 
				'Colouring by numbers with Pixel Art is an excellent way to pass the time. Calm down and enjoy hours of fun and relaxation, develop your concentration and accuracy.');
	INSERT INTO Applications (AppName, AppVersion, AppDesc)
			VALUES('AccuWeather: Weather Forecast', '3.1.1', 
				'minute by minute precipitation forecasts for the next two hours hyper-localized to your exact street address or GPS location.');
	INSERT INTO Applications (AppName, AppVersion, AppDesc)
			VALUES('TomTom GPS Navigation Traffic', '1.7.1', 
				'WELCOME TO PRIORITY DRIVING. Your red carpet for the road, no matter the destination. Whether you’re a commuter or a scenic driver TomTom GO Mobile makes you feel like you’re in the priority lane.');

	/* Seed Data for Bugs Table */
	INSERT INTO Bugs (AppID, UserID, BugDate, BugDesc, BugDetails, RepSteps) 
			VALUES(1, 2, '1/23/2018 8:13:11 PM', 'Incorrect Formatting1', 'The page 1 does not display the text in the correct format', 
				'Click File->New Item and click on the radio button');
	INSERT INTO Bugs (AppID, UserID, BugDate, BugDesc, BugDetails, RepSteps) 
			VALUES(2, 3, '12/23/2017 9:13:11 PM', 'Incorrect Formatting2', 'The page 2 does not display the text in the correct format', 
				'Click File->New Item and click on the radio button');
	INSERT INTO Bugs (AppID, UserID, BugDate, BugDesc, BugDetails, RepSteps) 
			VALUES(2, 4, '1/23/2018 8:13:11 PM', 'Incorrect Formatting3', 'The page 3 does not display the text in the correct format', 
				'Click File->New Item and click on the radio button');
	INSERT INTO Bugs (AppID, UserID, BugDate, BugDesc, BugDetails, RepSteps) 
			VALUES(4, 2, '1/23/2018 8:13:11 PM', 'Incorrect Formatting4', 'The page 4 does not display the text in the correct format', 
				'Click File->New Item and click on the radio button');
	INSERT INTO Bugs (AppID, UserID, BugDate, BugDesc, BugDetails, RepSteps) 
			VALUES(3, 5, '1/23/2018 8:13:11 PM', 'Incorrect Formatting5', 'The page 5 does not display the text in the correct format', 
				'Click File->New Item and click on the radio button');

	/* Seed Data for BugLog Table */
	INSERT INTO BugLog (BugLogDate, StatusCodeID, UserID, BugLogDesc, BugID) 
			VALUES('1/24/2018 8:13:11 PM', 1, 2, 'initial bug entered', 1);
	INSERT INTO BugLog (BugLogDate, StatusCodeID, UserID, BugLogDesc, BugID) 
			VALUES('1/25/2018 8:13:11 PM', 2, 2, 'Under investigation', 1);
	INSERT INTO BugLog (BugLogDate, StatusCodeID, UserID, BugLogDesc, BugID) 
			VALUES('1/26/2018 8:13:11 PM', 2, 3, 'soution found', 1);
	INSERT INTO BugLog (BugLogDate, StatusCodeID, UserID, BugLogDesc, BugID) 
			VALUES('12/27/2017 8:13:11 PM', 1, 3, 'initial bug entered', 2);
	INSERT INTO BugLog (BugLogDate, StatusCodeID, UserID, BugLogDesc, BugID) 
			VALUES(GetDate(), 4, 4, 'initial bug entered', 3);
	INSERT INTO BugLog (BugLogDate, StatusCodeID, UserID, BugLogDesc, BugID) 
			VALUES(GetDate(), 1, 2, 'initial bug entered', 4);
	INSERT INTO BugLog (BugLogDate, StatusCodeID, UserID, BugLogDesc, BugID) 
			VALUES(GetDate(), 1, 5, 'initial bug entered', 5);
	INSERT INTO BugLog (BugLogDate, StatusCodeID, UserID, BugLogDesc, BugID) 
			VALUES(GetDate(), 1, 4, 'fixed', 3);
	INSERT INTO BugLog (BugLogDate, StatusCodeID, UserID, BugLogDesc, BugID) 
			VALUES('1/03/2018 8:13:11 PM', 1, 3, 'Under investigation', 2);
END
GO
