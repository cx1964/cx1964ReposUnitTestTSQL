-- filenaam: voorbeeld.sql
-- doc: https://www.sqlservercentral.com/articles/installing-tsqlt
-- Opmerking:  Om dit script te laten werken draai eerst het script Example.sql

USE tSQLt_Example;

-- Create code dat getest moet worden
IF OBJECT_ID('[dbo].[spDouble]', 'P') IS NOT NULL
  DROP PROCEDURE [dbo].[spDouble]
GO
CREATE PROCEDURE spDouble 
  @input int
AS
    BEGIN
        RETURN @input *2;
    END
GO



-- Create a TestClass
EXEC tSQLt.NewTestClass @ClassName = N'TestSample';


-- Writing a Test
IF OBJECT_ID('[TestSample].[test spDouble Calculation]', 'P') IS NOT NULL
  DROP PROCEDURE [TestSample].[test spDouble Calculation]
GO
CREATE PROCEDURE [TestSample].[test spDouble Calculation]
AS
    BEGIN
    -- assemble
        DECLARE
            @param INT
        ,   @expected INT
        ,   @actual INT;
        SET @param = 5;
        SET @expected = 10;

    -- Act
        EXEC @actual = spDouble @param;

    -- assert
        EXEC tSQLt.AssertEquals @Expected = @expected, @Actual = @actual,
            @Message = N'The calculation is incorrect.'; -- nvarchar(max)
    END;


-- Voer unit test uit
EXEC tSQLt.Run @TestName = N'[TestSample].[test spDouble Calculation]';