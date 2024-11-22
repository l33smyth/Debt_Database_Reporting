

USE [M7_BI]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Debt_Reporting].[Debt_Management_Data]') AND type in (N'U'))
DROP TABLE [Debt_Reporting].[Debt_Management_Data]
GO


CREATE TABLE [Debt_Reporting].[Debt_Management_Data]
    (
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [DateTime_Record_Captured] DATETIME2 NOT NULL,
    [current_record] INT,
    [Is_Month_End_Date] INT, 
	
    [Tag] [nvarchar](50) NULL,
	[entity_id] [int] NULL,
	[Amortisation] [nvarchar](max) NULL,
	[Beneficiary] [nvarchar](max) NULL,
	[Borrowers] [nvarchar](max) NULL,
	[CAP] [numeric](19, 6) NULL,
	[Country] [nvarchar](50) NULL,
	
    [CT_DSCR_(LF & B) ] [numeric](19, 4) NULL,
	[CT_Historic_Debt_Yield] [numeric](19, 4) NULL,
	[CT_Historic_DSCR] [numeric](19, 4) NULL,
	[CT_Historic_ICR] [numeric](19, 4) NULL,
	[CT_LTV] [numeric](19, 4) NULL,
	[CT_NRI] [numeric](19, 4) NULL,
	[CT_Projected_Debt_Yield] [numeric](19, 4) NULL,
	[CT_Projected_DSCR] [numeric](19, 4) NULL,
	[CT_Projected_ICR] [numeric](19, 4) NULL,
	
    [Currency] [nvarchar](5) NULL,
	[Current_Loan_Amount] [numeric](19, 4) NULL,
	[Current_LTV] [numeric](19, 4) NULL,
	[Current_Valuation] [numeric](19, 4) NULL,
	
    [D_DSCR_(LF & B) ] [numeric](19, 4) NULL,
	[D_Historic_Debt_Yield] [numeric](19, 4) NULL,
	[D_Historic_DSCR] [numeric](19, 4) NULL,
	[D_Historic_ICR] [numeric](19, 4) NULL,
	[D_LTV] [numeric](19, 4) NULL,
	[D_NRI] [numeric](19, 4) NULL,
	[D_Projected_Debt_Yield] [numeric](19, 4) NULL,
	[D_Projected_DSCR] [numeric](19, 4) NULL,
	[D_Projected_ICR] [numeric](19, 4) NULL,
	
    [Debt_Type] [nvarchar](40) NULL,
	[Drawdown_LTV] [numeric](19, 4) NULL,
	[Drawdown_Valuation] [bigint] NULL,
	[Extension_Options] [nvarchar](40) NULL,
	[Floating_Rate] [nvarchar](40) NULL,
	[Hard_Covenant] [nvarchar](40) NULL,
	[Hedge_Expiry_Date] [date] NULL,
	[Initial_Expiry_date] [date] NULL,
	[Interest_Payment_Date] [nvarchar](max) NULL,
	[IPD] [nvarchar](50) NULL,
	[Last_Valuation_Date] [date] NULL,
	[Lender] [nvarchar](max) NULL,
	[Likely_Required_Paydown] [numeric](19, 4) NULL,
	[Likely_Valuation_Date] [date] NULL,
	[Loan_Start_Date] [date] NULL,
	[Margin] [nvarchar](50) NULL,
	[Next_Maturity_Date] [date] NULL,
	[Original_Loan_Amount] [bigint] NULL,
	[Portfolio] [nvarchar](max) NULL,
	[Prepayment_Fees] [nvarchar](max) NULL,
	[Principal_Hedged] [bigint] NULL,
	
    [R_DSCR_(LF & B) ] [numeric](19, 4) NULL,
	[R_Historic_Debt_Yield] [numeric](19, 4) NULL,
	[R_Historic_DSCR] [numeric](19, 4) NULL,
	[R_Historic_ICR] [numeric](19, 4) NULL,
	[R_LTV] [numeric](19, 4) NULL,
	[R_NRI] [numeric](19, 4) NULL,
	[R_Projected_Debt_Yield] [numeric](19, 4) NULL,
	[R_Projected_DSCR] [numeric](19, 4) NULL,
	[R_Projected_ICR] [numeric](19, 4) NULL,
	
    [Release_Price_over_ALA] [nvarchar](max) NULL,
	[Soft_Covenant] [numeric](19, 4) NULL,
	[SWAP] [numeric](19, 4) NULL,
	[Total_Rate_As_At_IPD] [numeric](19, 4) NULL

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



-- INSERT INTO [M7_BI].[Debt_Reporting].[Debt_Management_Data]
-- (
		
-- 		 [DateTime_Record_Captured]
--         ,current_record
--         ,[Is_Month_End_Date]

-- 		,[Tag]
-- 		,[entity_id]
-- 		,[Amortisation]
-- 		,[Beneficiary]
-- 		,[Borrowers]
-- 		,[CAP]
-- 		,[Country]
-- 		,[CT_DSCR_(LF & B) ]
-- 		,[CT_Historic_Debt_Yield]
-- 		,[CT_Historic_DSCR]
-- 		,[CT_Historic_ICR]
-- 		,[CT_LTV]
-- 		,[CT_NRI]
-- 		,[CT_Projected_Debt_Yield]
-- 		,[CT_Projected_DSCR]
-- 		,[CT_Projected_ICR]
-- 		,[Currency]
-- 		,[Current_Loan_Amount]
-- 		,[Current_LTV]
-- 		,[Current_Valuation]
-- 		,[D_DSCR_(LF & B) ]
-- 		,[D_Historic_Debt_Yield]
-- 		,[D_Historic_DSCR]
-- 		,[D_Historic_ICR]
-- 		,[D_LTV]
-- 		,[D_NRI]
-- 		,[D_Projected_Debt_Yield]
-- 		,[D_Projected_DSCR]
-- 		,[D_Projected_ICR]
-- 		,[Debt_Type]
-- 		,[Drawdown_LTV]
-- 		,[Drawdown_Valuation]
-- 		,[Extension_Options]
-- 		,[Floating_Rate]
-- 		,[Hard_Covenant]
-- 		,[Hedge_Expiry_Date]
-- 		,[Initial_Expiry_date]
-- 		,[Interest_Payment_Date]
-- 		,[IPD]
-- 		,[Last_Valuation_Date]
-- 		,[Lender]
-- 		,[Likely_Required_Paydown]
-- 		,[Likely_Valuation_Date]
-- 		,[Loan_Start_Date]
-- 		,[Margin]
-- 		,[Next_Maturity_Date]
-- 		,[Original_Loan_Amount]
-- 		,[Portfolio]
-- 		,[Prepayment_Fees]
-- 		,[Principal_Hedged]
-- 		,[R_DSCR_(LF & B) ]
-- 		,[R_Historic_Debt_Yield]
-- 		,[R_Historic_DSCR]
-- 		,[R_Historic_ICR]
-- 		,[R_LTV]
-- 		,[R_NRI]
-- 		,[R_Projected_Debt_Yield]
-- 		,[R_Projected_DSCR]
-- 		,[R_Projected_ICR]
-- 		,[Release_Price_over_ALA]
-- 		,[Soft_Covenant]
-- 		,[SWAP]
-- 		,[Total_Rate_As_At_IPD]
-- )
-- SELECT 
--          [DateTime_Record_Captured] = GETDATE()
--         , 1
--         , 0 
-- 		,[Tag]
-- 		,[entity_id]
-- 		,[Amortisation]
-- 		,[Beneficiary]
-- 		,[Borrowers]
-- 		,[CAP]
-- 		,[Country]
-- 		,[CT_DSCR_(LF & B) ]
-- 		,[CT_Historic_Debt_Yield]
-- 		,[CT_Historic_DSCR]
-- 		,[CT_Historic_ICR]
-- 		,[CT_LTV]
-- 		,[CT_NRI]
-- 		,[CT_Projected_Debt_Yield]
-- 		,[CT_Projected_DSCR]
-- 		,[CT_Projected_ICR]
-- 		,[Currency]
-- 		,[Current_Loan_Amount]
-- 		,[Current_LTV]
-- 		,[Current_Valuation]
-- 		,[D_DSCR_(LF & B) ]
-- 		,[D_Historic_Debt_Yield]
-- 		,[D_Historic_DSCR]
-- 		,[D_Historic_ICR]
-- 		,[D_LTV]
-- 		,[D_NRI]
-- 		,[D_Projected_Debt_Yield]
-- 		,[D_Projected_DSCR]
-- 		,[D_Projected_ICR]
-- 		,[Debt_Type]
-- 		,[Drawdown_LTV]
-- 		,[Drawdown_Valuation]
-- 		,[Extension_Options]
-- 		,[Floating_Rate]
-- 		,[Hard_Covenant]
-- 		,[Hedge_Expiry_Date]
-- 		,[Initial_Expiry_date]
-- 		,[Interest_Payment_Date]
-- 		,[IPD]
-- 		,[Last_Valuation_Date]
-- 		,[Lender]
-- 		,[Likely_Required_Paydown]
-- 		,[Likely_Valuation_Date]
-- 		,[Loan_Start_Date]
-- 		,[Margin]
-- 		,[Next_Maturity_Date]
-- 		,[Original_Loan_Amount]
-- 		,[Portfolio]
-- 		,[Prepayment_Fees]
-- 		,[Principal_Hedged]
-- 		,[R_DSCR_(LF & B) ]
-- 		,[R_Historic_Debt_Yield]
-- 		,[R_Historic_DSCR]
-- 		,[R_Historic_ICR]
-- 		,[R_LTV]
-- 		,[R_NRI]
-- 		,[R_Projected_Debt_Yield]
-- 		,[R_Projected_DSCR]
-- 		,[R_Projected_ICR]
-- 		,[Release_Price_over_ALA]
-- 		,[Soft_Covenant]
-- 		,[SWAP]
-- 		,[Total_Rate_As_At_IPD]

--         FROM Debt_Reporting.V_Debt_Management_Data_Current



