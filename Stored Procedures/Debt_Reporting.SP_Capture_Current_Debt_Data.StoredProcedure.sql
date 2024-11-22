
USE M7_BI
GO

DROP PROCEDURE IF EXISTS Debt_Reporting.SP_Capture_Current_Debt_Data
GO

CREATE PROCEDURE Debt_Reporting.SP_Capture_Current_Debt_Data
    (
        @Allow_Replace_Today INT = 1   -- If this update process has been run today already, then this will delete any entries with today's date first. 0 to not do so. 
    )

AS

BEGIN

/*
Example Usage:

EXEC Debt_Reporting.SP_Capture_Current_Debt_Data  -- Default
EXEC Debt_Reporting.SP_Capture_Current_Debt_Data 1     -- Same as default; if run multiple times in a day, then 1 deletes any records where the date of the "DateTime_Record_Captured" value is today's date
EXEC Debt_Reporting.SP_Capture_Current_Debt_Data 0     -- New records will be added.


*/


-- /* DEV * 
--DECLARE @Allow_Replace_Today INT = 1      

-- Logging Parameters:
DECLARE @invoke_user    NVARCHAR(MAX) = SUSER_SNAME()   -- Username in format "M7IM\JeffDeveloper"
DECLARE @invoke_program NVARCHAR(MAX) = PROGRAM_NAME()  -- Eg. "azdata" when Azure Data Studio

DECLARE @process_section NVARCHAR(MAX) 
DECLARE @Table_Name NVARCHAR(100) = '[M7_BI].[Debt_Reporting].[Debt_Management_Data]'

DECLARE @ErrorMessage NVARCHAR(4000)
DECLARE @ErrorSeverity INT
DECLARE @ErrorState INT


DECLARE @Rolling_Delete INT = 1
DECLARE @Rolling_Days_Window INT = 120      -- How many of the last days to keep. Table will always keep data captured on a Month-End.


BEGIN TRY
BEGIN TRANSACTION

IF @Allow_Replace_Today = 1   -- If replacing is allowed, then delete any entries marked with today's date and re-run the insert.
    BEGIN
        SET @process_section = 'Delete captured data from today'
        DELETE FROM Debt_Reporting.Debt_Management_Data WHERE DateTime_Record_Captured = CAST(GETDATE() AS DATE)
    END


-- Set the current_record value to 0, ready for a new insert
SET @process_section = 'Set the current_record value to 0'

UPDATE [Debt_Reporting].[Debt_Management_Data]
SET current_record = 0
WHERE current_record <> 0


SET @process_section = 'Capture current data'

INSERT INTO [Debt_Reporting].[Debt_Management_Data]
(
		 [DateTime_Record_Captured]
        ,[current_record] 
        ,[Is_Month_End_Date]
		,[Tag]
		,[entity_id]
		,[Amortisation]
		,[Beneficiary]
		,[Borrowers]
		,[CAP]
		,[Country]
		,[CT_DSCR_(LF & B) ]
		,[CT_Historic_Debt_Yield]
		,[CT_Historic_DSCR]
		,[CT_Historic_ICR]
		,[CT_LTV]
		,[CT_NRI]
		,[CT_Projected_Debt_Yield]
		,[CT_Projected_DSCR]
		,[CT_Projected_ICR]
		,[Currency]
		,[Current_Loan_Amount]
		,[Current_LTV]
		,[Current_Valuation]
		,[D_DSCR_(LF & B) ]
		,[D_Historic_Debt_Yield]
		,[D_Historic_DSCR]
		,[D_Historic_ICR]
		,[D_LTV]
		,[D_NRI]
		,[D_Projected_Debt_Yield]
		,[D_Projected_DSCR]
		,[D_Projected_ICR]
		,[Debt_Type]
		,[Drawdown_LTV]
		,[Drawdown_Valuation]
		,[Extension_Options]
		,[Floating_Rate]
		,[Hard_Covenant]
		,[Hedge_Expiry_Date]
		,[Initial_Expiry_date]
		,[Interest_Payment_Date]
		,[IPD]
		,[Last_Valuation_Date]
		,[Lender]
		,[Likely_Required_Paydown]
		,[Likely_Valuation_Date]
		,[Loan_Start_Date]
		,[Margin]
		,[Next_Maturity_Date]
		,[Original_Loan_Amount]
		,[Portfolio]
		,[Prepayment_Fees]
		,[Principal_Hedged]
		,[R_DSCR_(LF & B) ]
		,[R_Historic_Debt_Yield]
		,[R_Historic_DSCR]
		,[R_Historic_ICR]
		,[R_LTV]
		,[R_NRI]
		,[R_Projected_Debt_Yield]
		,[R_Projected_DSCR]
		,[R_Projected_ICR]
		,[Release_Price_over_ALA]
		,[Soft_Covenant]
		,[SWAP]
		,[Total_Rate_As_At_IPD]
)
SELECT 
         [DateTime_Record_Captured] = GETDATE()
        , curent_record = 1
        , Is_Month_End_Date =  
            CASE
                WHEN EOMONTH(GETDATE()) = CAST(GETDATE() AS DATE) THEN 1 ELSE 0 END

		,[Tag]
		,[entity_id]
		,[Amortisation]
		,[Beneficiary]
		,[Borrowers]
		,[CAP]
		,[Country]
		,[CT_DSCR_(LF & B) ]
		,[CT_Historic_Debt_Yield]
		,[CT_Historic_DSCR]
		,[CT_Historic_ICR]
		,[CT_LTV]
		,[CT_NRI]
		,[CT_Projected_Debt_Yield]
		,[CT_Projected_DSCR]
		,[CT_Projected_ICR]
		,[Currency]
		,[Current_Loan_Amount]
		,[Current_LTV]
		,[Current_Valuation]
		,[D_DSCR_(LF & B) ]
		,[D_Historic_Debt_Yield]
		,[D_Historic_DSCR]
		,[D_Historic_ICR]
		,[D_LTV]
		,[D_NRI]
		,[D_Projected_Debt_Yield]
		,[D_Projected_DSCR]
		,[D_Projected_ICR]
		,[Debt_Type]
		,[Drawdown_LTV]
		,[Drawdown_Valuation]
		,[Extension_Options]
		,[Floating_Rate]
		,[Hard_Covenant]
		,[Hedge_Expiry_Date]
		,[Initial_Expiry_date]
		,[Interest_Payment_Date]
		,[IPD]
		,[Last_Valuation_Date]
		,[Lender]
		,[Likely_Required_Paydown]
		,[Likely_Valuation_Date]
		,[Loan_Start_Date]
		,[Margin]
		,[Next_Maturity_Date]
		,[Original_Loan_Amount]
		,[Portfolio]
		,[Prepayment_Fees]
		,[Principal_Hedged]
		,[R_DSCR_(LF & B) ]
		,[R_Historic_Debt_Yield]
		,[R_Historic_DSCR]
		,[R_Historic_ICR]
		,[R_LTV]
		,[R_NRI]
		,[R_Projected_Debt_Yield]
		,[R_Projected_DSCR]
		,[R_Projected_ICR]
		,[Release_Price_over_ALA]
		,[Soft_Covenant]
		,[SWAP]
		,[Total_Rate_As_At_IPD]

        FROM Debt_Reporting.V_Debt_Management_Data_Current


COMMIT TRANSACTION;
END TRY


-- IF ANY ERROR OCCURS, THIS WILL CAPTURE IT.
BEGIN CATCH

    -- Rollback if an error occurs
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;

    -- Log the error
    SET @ErrorMessage   = ERROR_MESSAGE();
    SET @ErrorSeverity  = ERROR_SEVERITY();
    SET @ErrorState     = ERROR_STATE();
    
    INSERT INTO Persistent.Persistent_Update_Log 
        (     [Run_Time]
            , [Invoke_User]
            , [Invoke_Program]
            , [Table_Name]
            , [Process_Section]
            , [Report_Date]
            , [Record_Count]
            , [Is_Month_End]
            , [IS_ERRORED_RUN]

            , Error_Message
            , Error_Severity
            , Error_State
            , Error_Occurred_At
        )
    VALUES 
        (     GETDATE() -- [Run_Time]
            , @invoke_user
            , @invoke_program  
            , @Table_Name  -- [Table_Name]
            , @process_section
            , CAST ( GETDATE() AS DATE) -- [Report_Date]
            , NULL   -- [Record_Count]
            , NULL -- [Is_Month_End]
            , 1 -- [IS_ERRORED_RUN]

            , @ErrorMessage
            , @ErrorSeverity
            , @ErrorState
            , GETDATE()
         );
    -- Rethrow the error
    THROW;
END CATCH;



-- ROLLING DELETIONS

-- Delete entries where the "DateTime_Record_Captured" is before the @Rolling_Days_Window number of days
IF 
    @Rolling_Delete = 1
AND @Rolling_Days_Window > 0

    BEGIN

        DELETE FROM Debt_Reporting.Debt_Management_Data
        WHERE DateTime_Record_Captured < DATEADD(day, @Rolling_Days_Window * -1, CAST(GETDATE() as DATE) )
        AND Is_Month_End_Date = 0

    END


END


