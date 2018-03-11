CREATE PROCEDURE [dbo].[ListAllStatusCodes]
AS
BEGIN

	SET NOCOUNT ON;

	SELECT StatusCodeId, StatusCodeDesc FROM StatusCodes;

END;	
