-- ==========================================================
-- WBSDKERPDB Complete Database Script (Tables, Data & Stored Procedures)
-- Generated for Cloud / Render SQL Server deployment
-- ==========================================================
SET NOCOUNT ON;
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

-- ==========================================================
-- CREATE TABLES
-- ==========================================================
IF OBJECT_ID('[__MigrationHistory]', 'U') IS NULL
BEGIN
CREATE TABLE [__MigrationHistory] (
    [MigrationId] nvarchar(150)  NOT NULL,
    [ContextKey] nvarchar(300)  NOT NULL,
    [Model] varbinary  NOT NULL,
    [ProductVersion] nvarchar(32)  NOT NULL
);
END;
GO

IF OBJECT_ID('[AspNetRoles]', 'U') IS NULL
BEGIN
CREATE TABLE [AspNetRoles] (
    [Id] nvarchar(128)  NOT NULL,
    [Name] nvarchar(256)  NOT NULL
);
END;
GO

IF OBJECT_ID('[AspNetUserClaims]', 'U') IS NULL
BEGIN
CREATE TABLE [AspNetUserClaims] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [UserId] nvarchar(128)  NOT NULL,
    [ClaimType] nvarchar(MAX)  NULL,
    [ClaimValue] nvarchar(MAX)  NULL
);
END;
GO

IF OBJECT_ID('[AspNetUserLogins]', 'U') IS NULL
BEGIN
CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(128)  NOT NULL,
    [ProviderKey] nvarchar(128)  NOT NULL,
    [UserId] nvarchar(128)  NOT NULL
);
END;
GO

IF OBJECT_ID('[AspNetUserRoles]', 'U') IS NULL
BEGIN
CREATE TABLE [AspNetUserRoles] (
    [UserId] nvarchar(128)  NOT NULL,
    [RoleId] nvarchar(128)  NOT NULL
);
END;
GO

IF OBJECT_ID('[AspNetUsers]', 'U') IS NULL
BEGIN
CREATE TABLE [AspNetUsers] (
    [Id] nvarchar(128)  NOT NULL,
    [Role] nvarchar(MAX)  NULL,
    [EmployeeID] nvarchar(MAX)  NULL,
    [IsActive] bit  NOT NULL,
    [Email] nvarchar(256)  NULL,
    [EmailConfirmed] bit  NOT NULL,
    [PasswordHash] nvarchar(MAX)  NULL,
    [SecurityStamp] nvarchar(MAX)  NULL,
    [PhoneNumber] nvarchar(MAX)  NULL,
    [PhoneNumberConfirmed] bit  NOT NULL,
    [TwoFactorEnabled] bit  NOT NULL,
    [LockoutEndDateUtc] datetime  NULL,
    [LockoutEnabled] bit  NOT NULL,
    [AccessFailedCount] int  NOT NULL,
    [UserName] nvarchar(256)  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblChallanItems]', 'U') IS NULL
BEGIN
CREATE TABLE [utblChallanItems] (
    [CHItemID] nvarchar(128)  NOT NULL,
    [ChallanID] varchar(8)  NOT NULL,
    [ItemName] nvarchar(MAX)  NOT NULL,
    [Quantity] int  NOT NULL,
    [UnitID] bigint  NOT NULL,
    [SlNo] int  NULL
);
END;
GO

IF OBJECT_ID('[utblChallanKeys]', 'U') IS NULL
BEGIN
CREATE TABLE [utblChallanKeys] (
    [ChallanID] varchar(8)  NOT NULL,
    [VenderID] bigint  NOT NULL,
    [ProjectID] bigint  NULL,
    [CHRefNo] nvarchar(20)  NOT NULL,
    [CHDate] date  NOT NULL,
    [CHToName] nvarchar(100)  NOT NULL,
    [ClientAddress] nvarchar(MAX)  NOT NULL,
    [Remarks] nvarchar(MAX)  NOT NULL,
    [SlNo] int  NOT NULL,
    [FiscalYear] varchar(10)  NOT NULL,
    [IsCancel] bit  NOT NULL,
    [AddedBy] nvarchar(100)  NOT NULL,
    [AddedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblDirectPayments]', 'U') IS NULL
BEGIN
CREATE TABLE [utblDirectPayments] (
    [DirectPaymentID] bigint IDENTITY(1,1) NOT NULL,
    [ExpenseTypeID] bigint  NOT NULL,
    [ProjectID] bigint  NULL,
    [PaymentDate] date  NOT NULL,
    [PaymentAmt] money  NOT NULL,
    [IsDeclined] bit  NOT NULL,
    [Purpose] nvarchar(512)  NOT NULL,
    [Remarks] nvarchar(MAX)  NOT NULL,
    [Status] varchar(50)  NOT NULL,
    [AddedBy] varchar(128)  NOT NULL,
    [AddedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblEmpAttendanceMappings]', 'U') IS NULL
BEGIN
CREATE TABLE [utblEmpAttendanceMappings] (
    [EmpDeviceMappingID] bigint IDENTITY(1,1) NOT NULL,
    [EmployeeID] varchar(8)  NOT NULL,
    [EmpDeviceID] int  NOT NULL,
    [UserID] varchar(50)  NOT NULL,
    [LastModifiedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblEmpAttendances]', 'U') IS NULL
BEGIN
CREATE TABLE [utblEmpAttendances] (
    [AttendanceID] varchar(16)  NOT NULL,
    [EmployeeID] varchar(8)  NOT NULL,
    [AttendanceDate] date  NULL,
    [InTime] datetime  NULL,
    [OutTime] datetime  NULL,
    [AttendanceStatusID] tinyint  NULL,
    [Remarks] varchar(256)  NULL,
    [LogType] varchar(50)  NULL,
    [UserID] varchar(50)  NOT NULL,
    [LastModifiedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblEmpPersonalInfoKeys]', 'U') IS NULL
BEGIN
CREATE TABLE [utblEmpPersonalInfoKeys] (
    [EmployeeID] varchar(8)  NOT NULL,
    [FName] varchar(50)  NOT NULL,
    [MName] varchar(50)  NULL,
    [LName] varchar(50)  NOT NULL,
    [DateOfBirth] datetime  NOT NULL,
    [Gender] varchar(50)  NOT NULL,
    [Nationality] varchar(50)  NOT NULL,
    [MaritalStatus] varchar(50)  NOT NULL,
    [Religion] varchar(50)  NOT NULL,
    [BloodGroup] varchar(20)  NOT NULL,
    [PhoneNumber] varchar(10)  NOT NULL,
    [Email] varchar(50)  NOT NULL,
    [PanNo] varchar(10)  NULL,
    [AadharNo] varchar(12)  NULL,
    [PresentAddress] varchar(MAX)  NOT NULL,
    [EmgContactName] varchar(256)  NULL,
    [EmgContactNo] varchar(10)  NULL,
    [EmgContactAddress] varchar(MAX)  NULL,
    [PhotoNormal] varchar(MAX)  NULL,
    [PhotoThumb] varchar(MAX)  NULL,
    [UserID] varchar(50)  NOT NULL,
    [LastModifiedOn] datetime  NOT NULL,
    [JoinDate] datetime  NULL
);
END;
GO

IF OBJECT_ID('[utblExpenseDetails]', 'U') IS NULL
BEGIN
CREATE TABLE [utblExpenseDetails] (
    [ExpenseID] bigint IDENTITY(1,1) NOT NULL,
    [ExpenseDate] datetime  NOT NULL,
    [ExpenseType] varchar(50)  NOT NULL,
    [ExpenseAmount] decimal(18, 2)  NOT NULL,
    [AccountType] varchar(50)  NOT NULL,
    [Remarks] varchar(MAX)  NOT NULL,
    [UserID] varchar(100)  NOT NULL,
    [LastModifiedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblMstBanks]', 'U') IS NULL
BEGIN
CREATE TABLE [utblMstBanks] (
    [BankID] bigint IDENTITY(1,1) NOT NULL,
    [BankName] nvarchar(256)  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblMstClients]', 'U') IS NULL
BEGIN
CREATE TABLE [utblMstClients] (
    [ClientID] bigint IDENTITY(1,1) NOT NULL,
    [ClientName] varchar(256)  NOT NULL,
    [ClientAddress] varchar(MAX)  NOT NULL,
    [GSTNo] varchar(50)  NOT NULL,
    [ContactNo] varchar(15)  NULL,
    [UserID] varchar(100)  NOT NULL,
    [LastModifiedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblMstExpenseTypes]', 'U') IS NULL
BEGIN
CREATE TABLE [utblMstExpenseTypes] (
    [ExpenseTypeID] bigint IDENTITY(1,1) NOT NULL,
    [ExpenseType] nvarchar(MAX)  NOT NULL,
    [Description] nvarchar(MAX)  NOT NULL,
    [IsProjectRelated] bit  NOT NULL,
    [CanReceiveDirectPayment] bit  NOT NULL,
    [OpeningAmount] money  NULL,
    [OpeningDate] date  NULL,
    [UserID] nvarchar(256)  NOT NULL,
    [LastModifiedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[UtblMstFinancialYears]', 'U') IS NULL
BEGIN
CREATE TABLE [UtblMstFinancialYears] (
    [FiscalID] int IDENTITY(1,1) NOT NULL,
    [StartDate] date  NOT NULL,
    [EndDate] date  NOT NULL,
    [FiscalYearSymbol] varchar(7)  NOT NULL,
    [Active] bit  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblMstGenCodeSeeds]', 'U') IS NULL
BEGIN
CREATE TABLE [utblMstGenCodeSeeds] (
    [SLNO] bigint IDENTITY(1,1) NOT NULL,
    [Year] int  NOT NULL,
    [CharRange] char(1)  NOT NULL,
    [StartRange] int  NOT NULL,
    [TableName] varchar(50)  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblMstHolidays]', 'U') IS NULL
BEGIN
CREATE TABLE [utblMstHolidays] (
    [HolidayID] varchar(10)  NOT NULL,
    [HolidayName] varchar(128)  NOT NULL,
    [HolidayDesc] varchar(256)  NULL,
    [DateFrom] date  NOT NULL,
    [DateTo] date  NOT NULL,
    [NoofDays] int  NOT NULL,
    [UserID] varchar(50)  NOT NULL,
    [LastModifiedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblMstItems]', 'U') IS NULL
BEGIN
CREATE TABLE [utblMstItems] (
    [ItemID] bigint IDENTITY(1,1) NOT NULL,
    [ItemName] varchar(50)  NOT NULL,
    [ItemHSNCode] varchar(50)  NOT NULL,
    [GSTPercentage] int  NOT NULL,
    [ItemDescription] varchar(MAX)  NULL,
    [UserID] varchar(100)  NOT NULL,
    [LastModifiedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblMstProjects]', 'U') IS NULL
BEGIN
CREATE TABLE [utblMstProjects] (
    [ProjectID] bigint IDENTITY(1,1) NOT NULL,
    [ProjectName] nvarchar(MAX)  NOT NULL,
    [VendorID] bigint  NOT NULL,
    [ProjStartDate] date  NOT NULL,
    [ProjEndDate] date  NULL,
    [ProjStatus] nvarchar(50)  NOT NULL,
    [ProjValue] money  NOT NULL,
    [ProjDescription] nvarchar(MAX)  NOT NULL,
    [WODate] date  NULL,
    [WONo] nvarchar(200)  NULL,
    [WOPath] nvarchar(MAX)  NULL,
    [PCCPath] nvarchar(MAX)  NULL
);
END;
GO

IF OBJECT_ID('[utblMstReferenceNumbers]', 'U') IS NULL
BEGIN
CREATE TABLE [utblMstReferenceNumbers] (
    [RefID] int IDENTITY(1,1) NOT NULL,
    [FiscalYearSymbol] varchar(7)  NOT NULL,
    [Prefix] varchar(3)  NOT NULL,
    [Suffix] varchar(3)  NOT NULL,
    [StartNo] int  NOT NULL,
    [CurrentNo] int  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblMstUnits]', 'U') IS NULL
BEGIN
CREATE TABLE [utblMstUnits] (
    [UnitID] bigint IDENTITY(1,1) NOT NULL,
    [UnitName] varchar(100)  NOT NULL,
    [UnitDescription] varchar(MAX)  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblMstVendorDetails]', 'U') IS NULL
BEGIN
CREATE TABLE [utblMstVendorDetails] (
    [VenderID] bigint IDENTITY(1,1) NOT NULL,
    [VenderName] varchar(100)  NOT NULL,
    [VenderAddress] varchar(MAX)  NULL,
    [GSTNo] varchar(50)  NULL,
    [ContactName] varchar(100)  NULL,
    [Email] varchar(50)  NULL,
    [ContactNo] varchar(15)  NULL,
    [UserID] varchar(100)  NOT NULL,
    [LastModifiedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblOfficalLetterDocs]', 'U') IS NULL
BEGIN
CREATE TABLE [utblOfficalLetterDocs] (
    [DocID] bigint IDENTITY(1,1) NOT NULL,
    [DocName] nvarchar(256)  NOT NULL,
    [ReferenceID] bigint  NOT NULL,
    [DocPath] nvarchar(MAX)  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblPaymentDetails]', 'U') IS NULL
BEGIN
CREATE TABLE [utblPaymentDetails] (
    [PaymentID] varchar(8)  NOT NULL,
    [ExpenseTypeID] bigint  NOT NULL,
    [PaymentDate] date  NOT NULL,
    [PaymentAmt] money  NOT NULL,
    [PaymentMode] varchar(50)  NOT NULL,
    [BankID] bigint  NULL,
    [ChequeTransNo] nvarchar(256)  NULL,
    [PaymentFile] nvarchar(MAX)  NULL,
    [VendorID] bigint  NULL,
    [ProjectID] bigint  NULL,
    [PaymentType] nvarchar(50)  NOT NULL,
    [Remarks] nvarchar(MAX)  NOT NULL,
    [UserID] nvarchar(128)  NOT NULL,
    [LastModifiedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblPaymentReceivables]', 'U') IS NULL
BEGIN
CREATE TABLE [utblPaymentReceivables] (
    [ReceivedID] bigint IDENTITY(1,1) NOT NULL,
    [ExpenseTypeID] bigint  NOT NULL,
    [AmtReceived] money  NOT NULL,
    [ReceivedDate] date  NOT NULL,
    [ReceivedMode] varchar(50)  NOT NULL,
    [BankID] bigint  NULL,
    [TransactionNo] varchar(128)  NULL,
    [Remarks] nvarchar(MAX)  NOT NULL,
    [UploadedFile] nvarchar(MAX)  NULL,
    [AddedBy] varchar(128)  NOT NULL,
    [AddedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblPaymentReleasedTrans]', 'U') IS NULL
BEGIN
CREATE TABLE [utblPaymentReleasedTrans] (
    [PaymentID] bigint IDENTITY(1,1) NOT NULL,
    [PaymentDate] date  NOT NULL,
    [PaymentAmt] money  NOT NULL,
    [PaymentMode] nvarchar(100)  NOT NULL,
    [PurchaseInvoiceID] varchar(8)  NULL,
    [DirectPaymentID] bigint  NULL,
    [BankID] bigint  NULL,
    [PaymentTransNo] nvarchar(50)  NULL,
    [UploadedFile] nvarchar(MAX)  NULL,
    [Remarks] nvarchar(MAX)  NOT NULL,
    [AddedBy] nvarchar(126)  NOT NULL,
    [AddedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblPettyCashs]', 'U') IS NULL
BEGIN
CREATE TABLE [utblPettyCashs] (
    [PettyCashID] bigint IDENTITY(1,1) NOT NULL,
    [TransDate] date  NOT NULL,
    [ExpenseTypeID] bigint  NOT NULL,
    [ProjPaymentReceiveID] bigint  NULL,
    [ReceivedID] bigint  NULL,
    [PaymentID] bigint  NULL,
    [BankID] bigint  NULL,
    [CreditAmt] money  NULL,
    [DebitAmt] money  NULL,
    [Remarks] nvarchar(MAX)  NOT NULL,
    [IsClosed] bit  NOT NULL,
    [FilePath] varchar(128)  NULL
);
END;
GO

IF OBJECT_ID('[utblProjPaymentReceivables]', 'U') IS NULL
BEGIN
CREATE TABLE [utblProjPaymentReceivables] (
    [ProjPaymentReceiveID] bigint IDENTITY(1,1) NOT NULL,
    [ProjectID] bigint  NOT NULL,
    [BankID] bigint  NULL,
    [ReceivedDate] date  NOT NULL,
    [ReceivedMode] nvarchar(100)  NOT NULL,
    [Remarks] varchar(MAX)  NOT NULL,
    [NetAmtReceived] money  NOT NULL,
    [TDSDeductionAmt] money  NOT NULL,
    [GstDeductionAmt] money  NOT NULL,
    [SecurityDepositAmt] money  NOT NULL,
    [OtherDeductionAmt] money  NOT NULL,
    [IsAdvance] bit  NOT NULL,
    [UploadedFile] nvarchar(MAX)  NULL,
    [SaleInvoiceID] varchar(8)  NULL
);
END;
GO

IF OBJECT_ID('[utblPurchaseInvoiceItems]', 'U') IS NULL
BEGIN
CREATE TABLE [utblPurchaseInvoiceItems] (
    [ItemDtlID] nvarchar(128)  NOT NULL,
    [PurchaseInvoiceID] varchar(8)  NOT NULL,
    [ItemName] nvarchar(MAX)  NULL,
    [ItemHSNCode] nvarchar(50)  NOT NULL,
    [GSTPercentage] int  NOT NULL,
    [IGSTPercentage] float  NULL,
    [CGSTPercentage] float  NULL,
    [SGSTPercentage] float  NULL,
    [Qty] int  NOT NULL,
    [Rate] money  NOT NULL,
    [Amount] money  NOT NULL,
    [SlNo] varchar(10)  NULL
);
END;
GO

IF OBJECT_ID('[utblPurchaseInvoiceKeys]', 'U') IS NULL
BEGIN
CREATE TABLE [utblPurchaseInvoiceKeys] (
    [PurchaseInvoiceID] varchar(8)  NOT NULL,
    [PurchaseDate] datetime  NOT NULL,
    [PORefNo] nvarchar(50)  NULL,
    [BillNo] nvarchar(50)  NULL,
    [POType] nvarchar(50)  NOT NULL,
    [ProjectID] bigint  NULL,
    [VenderID] bigint  NOT NULL,
    [IGSTAmount] money  NULL,
    [CGSTAmount] money  NULL,
    [SGSTAmount] money  NULL,
    [ExcludingTaxAmt] money  NOT NULL,
    [IncludingTaxAmt] money  NOT NULL,
    [AmountPaid] money  NOT NULL,
    [BalanceAmount] money  NOT NULL,
    [Remarks] nvarchar(MAX)  NOT NULL,
    [UploadBill] nvarchar(MAX)  NULL,
    [ShipTo] nvarchar(MAX)  NULL,
    [TermsConditions] nvarchar(MAX)  NULL,
    [IsPOCancelled] bit  NOT NULL,
    [HasMarkForPayment] bit  NOT NULL,
    [IsPaymentDeclined] bit  NOT NULL,
    [UserID] nvarchar(100)  NOT NULL,
    [LastModifiedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblPurchaseSales]', 'U') IS NULL
BEGIN
CREATE TABLE [utblPurchaseSales] (
    [PurchaseSaleID] bigint IDENTITY(1,1) NOT NULL,
    [PurchaseSaleDate] datetime  NOT NULL,
    [PurchaseSaleInvoiceNo] varchar(50)  NOT NULL,
    [VenderID] bigint  NULL,
    [ClientID] bigint  NULL,
    [HSNSAC] varchar(20)  NULL,
    [IsIGST] bit  NOT NULL,
    [IGST] float  NULL,
    [SGST] float  NULL,
    [CGST] float  NULL,
    [TaxableAmount] float  NOT NULL,
    [PurchaseSaleType] varchar(50)  NOT NULL,
    [Description] varchar(MAX)  NULL,
    [UserID] varchar(100)  NOT NULL,
    [LastModifiedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblReceivedAmountDetails]', 'U') IS NULL
BEGIN
CREATE TABLE [utblReceivedAmountDetails] (
    [RecvDtlsID] nvarchar(128)  NOT NULL,
    [ReceivedID] varchar(8)  NOT NULL,
    [ReferenceNo] varchar(25)  NOT NULL,
    [ReceivedAmount] decimal(18, 2)  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblReceivedAmountKeys]', 'U') IS NULL
BEGIN
CREATE TABLE [utblReceivedAmountKeys] (
    [ReceivedID] varchar(8)  NOT NULL,
    [ReceivedDate] datetime  NOT NULL,
    [PaymentMode] varchar(50)  NOT NULL,
    [Amount] decimal(18, 2)  NOT NULL,
    [Description] varchar(MAX)  NOT NULL,
    [UserID] varchar(50)  NOT NULL,
    [LastModifiedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblReferenceDetails]', 'U') IS NULL
BEGIN
CREATE TABLE [utblReferenceDetails] (
    [ReferenceID] bigint IDENTITY(1,1) NOT NULL,
    [RefDate] datetime  NOT NULL,
    [RefType] varchar(100)  NOT NULL,
    [DescORSubject] varchar(MAX)  NOT NULL,
    [FiscalYear] varchar(10)  NOT NULL,
    [RefNumber] varchar(20)  NOT NULL,
    [LetterTO] varchar(256)  NOT NULL,
    [VendorID] bigint  NOT NULL,
    [SLNO] int  NULL,
    [IsCancelled] bit  NOT NULL,
    [UserID] varchar(100)  NOT NULL,
    [LastModifiedOn] datetime  NOT NULL
);
END;
GO

IF OBJECT_ID('[utblSaleInvoiceItems]', 'U') IS NULL
BEGIN
CREATE TABLE [utblSaleInvoiceItems] (
    [ItemDtlID] nvarchar(128)  NOT NULL,
    [SaleInvoiceID] varchar(8)  NOT NULL,
    [ItemName] nvarchar(MAX)  NOT NULL,
    [ItemHSNCode] varchar(50)  NOT NULL,
    [GSTPercentage] int  NOT NULL,
    [IGSTPercentage] float  NULL,
    [CGSTPercentage] float  NULL,
    [SGSTPercentage] float  NULL,
    [Qty] int  NOT NULL,
    [Rate] money  NOT NULL,
    [Amount] money  NOT NULL,
    [SequenceNo] varchar(5)  NULL
);
END;
GO

IF OBJECT_ID('[utblSaleInvoiceKeys]', 'U') IS NULL
BEGIN
CREATE TABLE [utblSaleInvoiceKeys] (
    [SaleInvoiceID] varchar(8)  NOT NULL,
    [OrderNo] nvarchar(200)  NULL,
    [OrderDate] date  NULL,
    [InvoiceTo] nvarchar(100)  NOT NULL,
    [InvoiceDate] date  NOT NULL,
    [ReferenceNo] varchar(25)  NOT NULL,
    [VenderID] bigint  NOT NULL,
    [ProjectID] bigint  NOT NULL,
    [IGSTAmount] money  NULL,
    [CGSTAmount] money  NULL,
    [SGSTAmount] money  NULL,
    [ExcludingTaxAmt] money  NOT NULL,
    [IncludingTaxAmt] money  NOT NULL,
    [AdvanceReceived] money  NULL,
    [ReceivedRemarks] nvarchar(MAX)  NULL,
    [BalanceAmount] money  NOT NULL,
    [Remarks] nvarchar(MAX)  NOT NULL,
    [IsCancelled] bit  NOT NULL,
    [UserID] nvarchar(200)  NOT NULL,
    [LastModifiedOn] datetime  NOT NULL
);
END;
GO

-- ==========================================================
-- STORED PROCEDURES
-- ==========================================================
IF OBJECT_ID('[udspApprovedPayment]', 'P') IS NOT NULL DROP PROCEDURE [udspApprovedPayment];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-06-21
-- Description:	Approved Direct Payment Details
-- =============================================
CREATE PROCEDURE [dbo].[udspApprovedPayment] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		Declare @Status varchar(50) 
		select @Status= Status from utblDirectPayments  where DirectPaymentID = @ID
		
		If(@Status='Pending')
		Begin
			Update utblDirectPayments set Status='Approved' where DirectPaymentID = @ID
			set @error_number = 0
			set @ErMessage = 'Success: Admin Approved direct payment.'
		End
		Else
		Begin
			Update utblDirectPayments set Status='Pending' where DirectPaymentID = @ID
			set @error_number = 0
			set @ErMessage = 'Success: Admin Undo direct payment approved.'
		End

	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error:'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END


GO

IF OBJECT_ID('[udspAttendanceEntry]', 'P') IS NOT NULL DROP PROCEDURE [udspAttendanceEntry];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-02-20
-- Description:	Insert Emp Attendance
-- =============================================
CREATE PROCEDURE [dbo].[udspAttendanceEntry]
	-- Add the parameters for the stored procedure here
	@AttendanceTable AttendanceType Readonly,
	@UserName varchar(50),
	@LastModified datetime
AS
BEGIN
	declare @enrollNo int, @veriMode varchar(50)
	declare @inTime datetime, @outTime datetime
	declare @EmpId varchar(10)=null
	declare @charRange varchar(1), @slno int,@year int,@CodeSeedsYear int
	select @CodeSeedsYear=Year from utblMstGenCodeSeeds where TableName='utblEmpAttendances'
	declare @attDate date
	begin try
		begin transaction
			declare curAttType cursor for
			select EnrollNo, VeriMode, InTime, OutTime from @AttendanceTable
			open curAttType
			Fetch next from curAttType into @enrollNo, @veriMode, @inTime, @OutTime
			while @@FETCH_STATUS=0
			begin
				declare @recordCount int = 0
				declare @attID varchar(16)=null, @currIn datetime=null, @currOut datetime=null
				select @EmpId=EmployeeID from utblEmpAttendanceMappings where EmpDeviceID=@enrollNo
				select @attDate= case when @inTime is null then @outTime else @inTime end
				/* Checking if a student is registered with unique DeviceRegID and if present carry out database operation*/
				if(@EmpId is not null)
				begin
					/* Checking if attendance record for a student for that date exists or not*/
					select @recordCount = count(*) from utblEmpAttendances where EmployeeID=@EmpId and AttendanceDate=@attDate
					if(@recordCount<>0)
					Begin
						/* Record exists so updating Attendance Record*/
						select @attID=AttendanceID, @currIn=InTime, @currOut=OutTime from utblEmpAttendances where EmployeeID=@EmpId and AttendanceDate=@attDate
						if(@inTime is not null)
						begin
							--Update record if existing InTime is not null and new InTime is less than existing InTime
							if(@currIn is not null and @inTime<@currIn)
							begin
								update utblEmpAttendances set
								InTime=@inTime, LogType=@veriMode, LastModifiedOn=@LastModified,
								UserID=@UserName where AttendanceID=@attID
							end
							else if(@currIn is null)
							--Update record if existing InTime is null
							begin
								update utblEmpAttendances set
								InTime=@inTime, AttendanceStatusID=1, LogType=@veriMode, LastModifiedOn=@LastModified,
								UserID=@UserName where AttendanceID=@attID
							end
						end
						if(@outTime is not null)
						begin
							--Update record if existing OutTime is not null and new OutTime is greater than existing InTime
							if(@currOut is not null and @outTime>@currOut)
							begin
								update utblEmpAttendances set
								OutTime=@outTime, LogType=@veriMode, LastModifiedOn=@LastModified,
								UserID=@UserName where AttendanceID=@attID
							end
							else if(@currOut is null)
							--Update record if existing OutTime is null
							begin
								update utblEmpAttendances set
								OutTime=@outTime,AttendanceStatusID=1, LogType=@veriMode, LastModifiedOn=@LastModified,
								UserID=@UserName where AttendanceID=@attID
							end
						end
					end
					else
					begin
						/* Record does not exists so insert new Attendance Record*/
						

						--Getting unique Attendance ID from sql function
						select @attID = MsgRcpID, @charRange = CharRange, @year = Year, @slno = SINo from dbo.udfGenerateAttendanceID('utblEmpAttendances')
						declare @attStatus bigint
						if(@inTime is not null)
						BEGIN
							select @attStatus=case when @inTime is not null then 1 else 2 end --1 Present, 2 absent
						END
						if(@outTime is not null)
						BEGIN
							select @attStatus=case when @outTime is not null then 1 else 2 end --1 Present, 2 absent
						END
						--Inserting new Attendance Record
						insert into utblEmpAttendances
						(AttendanceID, EmployeeID ,AttendanceDate, InTime, OutTime, AttendanceStatusID, LogType, LastModifiedOn, UserID)
						values
						(@attID, @EmpId, @attDate, @inTime,@outTime,@attStatus, @veriMode, @LastModified, @UserName)

						--Updating code seed table
						if(@slno-1=999999999 and @charRange='Z')
							update utblMstGenCodeSeeds set CharRange='A', StartRange=1 where TableName='utblEmpAttendances'
						else if(@slno-1=999999999)
							update utblMstGenCodeSeeds set CharRange=CHAR(ASCII(@charRange)+1), StartRange=1 where TableName='utblEmpAttendances'
						else if(@CodeSeedsYear<>@year)
							update utblMstGenCodeSeeds set CharRange='A', StartRange=@slno,Year=@year where TableName='utblEmpAttendances'
						else
							update utblMstGenCodeSeeds set StartRange=@slno where TableName='utblEmpAttendances'
					end
				end
				
				Fetch next from curAttType into @enrollNo, @veriMode, @inTime, @OutTime
			end
			close curAttType
			deallocate curAttType
			
			Declare @AbEmpID varchar(12), @AbAttndDate date
			Declare @AttndDateTable as table
			(AttendanceDate date)

			Declare @AbEmpTable as Table
			(EmpID varchar(256),AttendanceDate date)

			Declare @SundayDate as Table
			(SundayDate date)

			Declare @AttndYear as Table
			(AttndYear int)

			insert into @AttndDateTable select Distinct AttendanceDate from utblEmpAttendances where AttendanceDate is not null

			insert into @AttndYear
				select distinct YEAR(AttendanceDate) from @AttndDateTable where AttendanceDate is not null

				Declare @MaxYear int, @MinYear int 
				select @MinYear = MIN(AttndYear), @MaxYear = MAX(AttndYear) from @AttndYear

				declare @startDate date,@enddate date
				set @startDate=CONVERT(date,convert(varchar,@MinYear)+'-01-01')
				set @enddate=CONVERT(date,convert(varchar,@MaxYear)+'-12-31')

				while @startDate<=@enddate
				begin
				if(DATENAME(dw,@startDate)='Sunday')

				insert into @SundayDate values(convert(date,@startDate,103))
				set @startDate=DATEADD(DD,1,@startDate)
				end

			Declare @SundayDates date
			Declare curSunday cursor for
			select SundayDate from @SundayDate
			open curSunday
			fetch next from curSunday into @SundayDates
			while(@@FETCH_STATUS=0)
			BEGIN
				delete from @AttndDateTable where convert(date, AttendanceDate) = CONVERT(date, @SundayDates)
				fetch next from curSunday into @SundayDates
			END
			close curSunday
			deallocate curSunday



			Declare @HolidayDays as table(HolidayDates datetime)
			Declare @MinDate datetime, @MaxDate datetime
			Declare cur cursor for
			select DateFrom, DateTo from utblMstHolidays
			open cur
			fetch next from cur into @MinDate, @MaxDate
			while(@@FETCH_STATUS=0)
			BEGIN
				;WITH DateRange(DateData) AS 
				(
					SELECT @MinDate as Date
					UNION ALL
					SELECT DATEADD(d,1,DateData)
					FROM DateRange 
					WHERE DateData < @MaxDate
				)
				insert into @HolidayDays
				SELECT DateData
				FROM DateRange
				OPTION (MAXRECURSION 0)
				fetch next from cur into @MinDate, @MaxDate
			END

			close cur
			deallocate cur

			
			delete from @AttndDateTable where AttendanceDate in (select convert(date,HolidayDates) from @HolidayDays)
			

			Declare @AttndDate date, @AttndDate2 date

			Declare curAbEmp cursor for
			select AttendanceDate from @AttndDateTable
			open curAbEmp
			fetch next from curAbEmp into @AttndDate2
			while(@@FETCH_STATUS=0)
			BEGIN
				insert into @AbEmpTable 
				select p.EmployeeID, @AttndDate2 from utblEmpPersonalInfoKeys p 
				inner join AspNetUsers asp on asp.EmployeeID=p.EmployeeID
				where p.EmployeeID not in (select EmployeeID from utblEmpAttendances where convert(date,AttendanceDate) = convert(date,@AttndDate2)) and
				p.EmployeeID not in (select a.EmployeeID from utblEmpPersonalInfoKeys a where convert(date,JoinDate) <= convert(date,@AttndDate2)) and asp.IsActive=1 
				--EmployeeID not in (select a.EmployeeID from utblEmpOfficialInfoDetails a where convert(date,ServiceEndDate) < convert(date,@AttndDate2))
				fetch next from curAbEmp into @AttndDate2
			end
			close curAbEmp
			deallocate curAbEmp

			Declare curAbType cursor for
			select EmpID, AttendanceDate from @AbEmpTable
			open curAbType
			fetch next from curAbType into @AbEmpID, @AbAttndDate
			while(@@FETCH_STATUS=0)
			BEGIN
				select @attID = MsgRcpID, @charRange = CharRange, @year = Year, @slno = SINo from dbo.udfGenerateAttendanceID('utblEmpAttendances')
				insert into utblEmpAttendances
					values(@attID, @AbEmpID, convert(date,@AbAttndDate), null, null, 2, null, 'Fingerprint', @UserName, @LastModified)

				--Updating code seed table
						if(@slno-1=999999999 and @charRange='Z')
							update utblMstGenCodeSeeds set CharRange='A', StartRange=1 where TableName='utblEmpAttendances'
						else if(@slno-1=999999999)
							update utblMstGenCodeSeeds set CharRange=CHAR(ASCII(@charRange)+1), StartRange=1 where TableName='utblEmpAttendances'
						else if(@CodeSeedsYear<>@year)
							update utblMstGenCodeSeeds set CharRange='A', StartRange=@slno,Year=@year where TableName='utblEmpAttendances'

						else
							update utblMstGenCodeSeeds set StartRange=@slno where TableName='utblEmpAttendances'

				fetch next from curAbType into @AbEmpID, @AbAttndDate
			END
			close curAbType
			deallocate curAbType
			
		commit transaction
	end try
	begin catch
		rollback transaction;
		throw;
	end catch
END






GO

IF OBJECT_ID('[udspCancelledActivePO]', 'P') IS NOT NULL DROP PROCEDURE [udspCancelledActivePO];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-05-14
-- Description:	Cancel Or active PO.
-- =============================================
CREATE PROCEDURE [dbo].[udspCancelledActivePO] 
	-- Add the parameters for the stored procedure here
	@ID varchar(8)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		Declare @IsCancel bit 
		select @IsCancel= IsPOCancelled from utblPurchaseInvoiceKeys  where PurchaseInvoiceID=@ID
		
		If(@IsCancel=0)
		Begin
			Update utblPurchaseInvoiceKeys set IsPOCancelled=1 where PurchaseInvoiceID=@ID
			set @error_number = 0
			set @ErMessage = 'Success: PO Active Succesfully.'
		End
		Else
		Begin
			Update utblPurchaseInvoiceKeys set IsPOCancelled=0 where PurchaseInvoiceID=@ID
			set @error_number = 0
			set @ErMessage = 'Success: PO Cancelled Succesfully.'
		End

	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error:'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspCancelledActiveRefNo]', 'P') IS NOT NULL DROP PROCEDURE [udspCancelledActiveRefNo];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-05-14
-- Description:	Cancel Or active Ref No.
-- =============================================
CREATE PROCEDURE [dbo].[udspCancelledActiveRefNo] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		Declare @IsCancel bit 
		select @IsCancel= IsCancelled from utblReferenceDetails  where ReferenceID=@ID
		
		If(@IsCancel=0)
		Begin
			Update utblReferenceDetails set IsCancelled=1 where ReferenceID=@ID
			set @error_number = 0
			set @ErMessage = 'Success: Refrence Number Cancelled Succesfully.'
		End
		Else
		Begin
			Update utblReferenceDetails set IsCancelled=0 where ReferenceID=@ID
			set @error_number = 0
			set @ErMessage = 'Success: Refrence Number Active Succesfully.'
		End

	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error:'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspCancelledActiveSaleInvoice]', 'P') IS NOT NULL DROP PROCEDURE [udspCancelledActiveSaleInvoice];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-05-14
-- Description:	Cancel Or active Sale Invoice.
-- =============================================
CREATE PROCEDURE [dbo].[udspCancelledActiveSaleInvoice] 
	-- Add the parameters for the stored procedure here
	@ID varchar(8)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		Declare @IsCancel bit 
		select @IsCancel= IsCancelled from utblSaleInvoiceKeys  where SaleInvoiceID=@ID
		
		If(@IsCancel=0)
		Begin
			Update utblSaleInvoiceKeys set IsCancelled=1 where SaleInvoiceID=@ID
			set @error_number = 0
			set @ErMessage = 'Success: Sale Invoice Calncelled Succesfully.'
		End
		Else
		Begin
			Update utblSaleInvoiceKeys set IsCancelled=0 where SaleInvoiceID=@ID
			set @error_number = 0
			set @ErMessage = 'Success: Sale Invoice Actice Succesfully.'
		End

	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error:Operation Failed.'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END

GO

IF OBJECT_ID('[udspChallanCancelledActive]', 'P') IS NOT NULL DROP PROCEDURE [udspChallanCancelledActive];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2025-04-04
-- Description:	Cancel Or active Challan.
-- =============================================
Create PROCEDURE [dbo].[udspChallanCancelledActive] 
	-- Add the parameters for the stored procedure here
	@ID varchar(8)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		Declare @IsCancelCH bit 
		select @IsCancelCh= IsCancel from utblChallanKeys  where ChallanID=@ID
		
		If(@IsCancelCh=0)
		Begin
			Update utblChallanKeys set IsCancel=1 where ChallanID=@ID
			set @error_number = 0
			set @ErMessage = 'Success: Delivery Challan Cancelled Succesfully.'
		End
		Else
		Begin
			Update utblChallanKeys set IsCancel=0 where ChallanID=@ID
			set @error_number = 0
			set @ErMessage = 'Success: Delivery Challan Active Succesfully.'
		End

	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error:'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END

GO

IF OBJECT_ID('[udspDeclinedPayment]', 'P') IS NOT NULL DROP PROCEDURE [udspDeclinedPayment];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-06-21
-- Description:	Approved Direct Payment Details
-- =============================================
Create PROCEDURE [dbo].[udspDeclinedPayment] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		Declare @Status varchar(50) 
		select @Status= Status from utblDirectPayments  where DirectPaymentID = @ID
		
		If(@Status='Pending')
		Begin
			Update utblDirectPayments set Status='Declined',IsDeclined=1 where DirectPaymentID = @ID
			set @error_number = 0
			set @ErMessage = 'Success: Admin declined direct payment.'
		End
		Else
		Begin
			Update utblDirectPayments set Status='Pending',IsDeclined=0 where DirectPaymentID = @ID
			set @error_number = 0
			set @ErMessage = 'Success: Admin undo direct payment declined.'
		End

	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error:'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END


GO

IF OBJECT_ID('[udspDeleteDirectPaymentByID]', 'P') IS NOT NULL DROP PROCEDURE [udspDeleteDirectPaymentByID];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-05-15
-- Description:	Delete Direct Payment Release Dtls
-- =============================================
CREATE PROCEDURE [dbo].[udspDeleteDirectPaymentByID] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		begin transaction 
			Declare @Mode nvarchar(50),@PaymentAmt money=0.0 ,@DirectPaymentID varchar(8),@PaidAmt decimal=0.0,@DueAmt decimal=0.0,@TotalAmt decimal=0.0
			select @Mode=PaymentMode,@PaymentAmt=PaymentAmt, @DirectPaymentID=DirectPaymentID from utblPaymentReleasedTrans --where PaymentID = @ID
			--select @Mode,@PaymentAmt,@DirectPaymentID

			set @TotalAmt=(select PaymentAmt from utblDirectPayments where DirectPaymentID=@DirectPaymentID)-- Total Payable Value
			set @PaidAmt=(select isnull(sum(isnull(PaymentAmt,0)),0) from utblPaymentReleasedTrans where DirectPaymentID=@DirectPaymentID and PaymentID<>@ID)
			set @DueAmt=(@TotalAmt - @PaidAmt)
			
			if(@Mode='Cash')
			Begin
				delete from utblPettyCashs where PaymentID=@ID
			End 
			
			--Delete From utblPaymentReleasedTrans
			delete from utblPaymentReleasedTrans
			where PaymentID = @ID
			set @ErMessage = 'Success: Record Deleted Succesfully.'

			update utblDirectPayments set
			Status=Case When @PaidAmt=0 Then 'Approved' when (@PaidAmt>0 and @PaidAmt<@TotalAmt)then 'Partial Settled' Else 'Settled'End
			where  DirectPaymentID=@DirectPaymentID

			--delete from utblDirectPayments
			--where DirectPaymentID = @ID

	commit transaction
	END TRY 
	BEGIN CATCH 
		rollback transaction
		SELECT @error_number = ERROR_NUMBER(), @ErMessage ='Error: '+ ERROR_MESSAGE()
	END CATCH
	select @ErMessage
END

GO

IF OBJECT_ID('[udspDeletePODetails]', 'P') IS NOT NULL DROP PROCEDURE [udspDeletePODetails];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-05-15
-- Description:	Delete PO details
-- =============================================
Create PROCEDURE [dbo].[udspDeletePODetails] 
	-- Add the parameters for the stored procedure here
	@ID varchar(15)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		begin transaction 
			Delete from utblPurchaseInvoiceItems
			where PurchaseInvoiceID = @ID
			
			delete from utblPurchaseInvoiceKeys
			where PurchaseInvoiceID = @ID

			set @ErMessage = 'Success: Record Deleted Succesfully.'
	commit transaction
	END TRY 
	BEGIN CATCH 
		rollback transaction
		SELECT @error_number = ERROR_NUMBER(), @ErMessage ='Error: '+ ERROR_MESSAGE()
	END CATCH
	select @ErMessage
END


GO

IF OBJECT_ID('[udspDeletePoPaymentTransByID]', 'P') IS NOT NULL DROP PROCEDURE [udspDeletePoPaymentTransByID];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-05-15
-- Description:	Delete PO Payment Trans By ID
-- =============================================
CREATE PROCEDURE [dbo].[udspDeletePoPaymentTransByID] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		begin transaction  
			Declare @Mode nvarchar(50),@PaymentAmt money=0.0 ,@POID varchar(8)
			select @Mode=PaymentMode,@PaymentAmt=PaymentAmt, @POID=PurchaseInvoiceID from utblPaymentReleasedTrans where PaymentID = @ID
			
			if(@Mode='Cash')
			Begin
				delete from utblPettyCashs where PaymentID=@ID
			End 
			--Update into utblPurchaseInvoiceKeys
			update utblPurchaseInvoiceKeys set
			AmountPaid=ISNULL(AmountPaid,0)-@PaymentAmt,
			BalanceAmount=BalanceAmount+@PaymentAmt
			where PurchaseInvoiceID=@POID
			--Delete From utblPaymentReleasedTrans
			delete from utblPaymentReleasedTrans
			where PaymentID = @ID
			set @ErMessage = 'Success: Record Deleted Succesfully.'
		commit transaction
	end try
	begin catch
		rollback transaction
		select @ErMessage='Error: '+ERROR_MESSAGE()
	end catch
	select @ErMessage 
END


GO

IF OBJECT_ID('[udspDeleteProjPaymentReceive]', 'P') IS NOT NULL DROP PROCEDURE [udspDeleteProjPaymentReceive];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-05-15
-- Description:	Delete Projects Related Payment Received Dtls
-- =============================================
CREATE PROCEDURE [dbo].[udspDeleteProjPaymentReceive] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		begin transaction 
			Declare @Mode nvarchar(50) 
			select @Mode=ReceivedMode from utblProjPaymentReceivables where ProjPaymentReceiveID = @ID
			
			if(@Mode='Cash')
			Begin
				delete from utblPettyCashs where ProjPaymentReceiveID=@ID
			End 
			 
			delete from utblProjPaymentReceivables
			where ProjPaymentReceiveID = @ID
			set @ErMessage = 'Success: Record Deleted Succesfully.'
		commit transaction
	END TRY 
	BEGIN CATCH 
		rollback transaction
		SELECT @error_number = ERROR_NUMBER(), @ErMessage ='Error: '+ ERROR_MESSAGE()
	END CATCH
	select @ErMessage
END


GO

IF OBJECT_ID('[udspDeleteReceiveDirectPayment]', 'P') IS NOT NULL DROP PROCEDURE [udspDeleteReceiveDirectPayment];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-05-15
-- Description:	Delete Direct Payment Received Dtls
-- =============================================
CREATE PROCEDURE [dbo].[udspDeleteReceiveDirectPayment] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		begin transaction 
			Declare @Mode nvarchar(50) 
			select @Mode=ReceivedMode from utblPaymentReceivables where ReceivedID = @ID
			
			if(@Mode='Cash')
			Begin
				delete from utblPettyCashs where ReceivedID=@ID
			End

			delete from utblPaymentReceivables
			where ReceivedID = @ID

			set @ErMessage = 'Success: Record Deleted Succesfully.'
	commit transaction
	END TRY 
	BEGIN CATCH 
		rollback transaction
		SELECT @error_number = ERROR_NUMBER(), @ErMessage ='Error: '+ ERROR_MESSAGE()
	END CATCH
	select @ErMessage
END


GO

IF OBJECT_ID('[udspDeliveryChallanSave]', 'P') IS NOT NULL DROP PROCEDURE [udspDeliveryChallanSave];
GO

-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2025-04-04>
-- Description:	<Save Delivery Challan Details>
-- =============================================
CREATE  PROCEDURE [dbo].[udspDeliveryChallanSave]
	-- Add the parameters for the stored procedure here
	@ItemDtlsList AddChallanItemDtlsTVP ReadOnly,
	@ChallanID varchar(15),
	@ClientID bigint,
	@ProjectID bigint,
	@CHRefNo varchar(20),
	@CHDate datetime,
	@CHToName nvarchar(100),
	@ClientAddress nvarchar(max),
	@Remarks nvarchar(max),
	@AddedBy nvarchar(256)
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	Begin Try
	 BEGIN TRANSACTION
			declare @CHID varchar(10), @char char(1), @code int
			Declare @FiscalYear varchar(10),@SLNo int=0
			Set @FiscalYear=(select [dbo].[udsfGetFiscalYear](@CHDate))
			
		if(@ChallanID is Null)
		Begin
			----Get CH Ref Number
			select @SLNo=max(SLNO) from utblChallanKeys where FiscalYear=@FiscalYear
			if(@SLNo is null or @SLNo=0 or @SLNo='')
			Begin
				set @SLNo=0
			End 
			Set @CHRefNo=CONCAT('SDK/',@FiscalYear,'/',@SLNo+1,'/CH')
			----End CH Ref NO	
			select @CHID = UniqueCode, @char=CharRange, @code=UpdatedSlNo from dbo.udfUtilEightCharacterKey('utblChallanKeys')
			-------------------------------------Insert Into utblChallanKeys Table--------------------------------------------
				Insert Into utblChallanKeys(ChallanID,VenderID,ProjectID,CHRefNo,CHDate,
				CHToName,ClientAddress,Remarks,SlNo,FiscalYear,IsCancel,AddedBy,AddedOn)Values
				(@CHID,@ClientID,@ProjectID,@CHRefNo,@CHDate,@CHToName,@ClientAddress,@Remarks,@SLNo+1,@FiscalYear,0,@AddedBy,GetDate())
			--------------------------------------------------- End ------------------------------------------------------
			----------- Insert utblChallanItems Table-------------------------
				insert into utblChallanItems (CHItemID,ChallanID,ItemName,Quantity,UnitID,SlNo) 
				Select NewID(),@CHID,ItemName,Quantity,UnitID,ROW_NUMBER() over (order by (Select NULL)) from @ItemDtlsList
			
			set @ermessage='Success: Challan Details Added Succesfully & New Challan Ref. Number is: '+@CHRefNo
			----------------------End ---------------------------------------------
			---------------------------------Update Gen Code Seed--------------------------------------------
			if(@code=999 and @char='Z')
			update utblMstGenCodeSeeds set CharRange='A', StartRange=1 where TableName='utblChallanKeys'
			else if(@code=999)
			update utblMstGenCodeSeeds set CharRange=CHAR(ASCII(@char)+1), StartRange=1 where TableName='utblChallanKeys'
			else
			update utblMstGenCodeSeeds set StartRange=@code where TableName='utblChallanKeys'
			
			set @ErMessage= @ermessage
		End
		Else
		Begin
			if(@FiscalYear=(select FiscalYear from utblChallanKeys where ChallanID=@ChallanID))
			Begin
				----------------------------Delete Existing Data From utblChallanItems  -------------------------------------
				Delete From utblChallanItems Where ChallanID=@ChallanID
				----------------------------- End -------------------------------------
				---------------------------------Update Into utblChallanKeys Table--------------------------------------------
				Update utblChallanKeys Set 
				VenderID=@ClientID,
				ProjectID=@ProjectID,
				CHRefNo=@CHRefNo,
				CHDate=@CHDate,
				CHToName=@CHToName,
				ClientAddress=@ClientAddress,
				Remarks=@Remarks,
				AddedBy=@AddedBy,
				AddedOn=GetDate()
				Where ChallanID=@ChallanID
				--------------------------------------------------- End ------------------------------------------------------
				----------- Insert utblChallanItems Table-------------------------
				insert into utblChallanItems 
				(CHItemID,ChallanID,ItemName,Quantity,UnitID,SlNo) 
				Select NewID(),@ChallanID,ItemName,Quantity,UnitID,ROW_NUMBER() over (order by (Select NULL)) from @ItemDtlsList
				set @ermessage='Success: Update Record Successfully'
				----------------------End ---------------------------------------------
				set @ErMessage= @ermessage
			End
			Else
			Begin
				set @ErMessage='Error: Operation Failed, Please select a Challan date within the same fiscal year while performing the edit operation, as the Challan reference number remains the same as initially recorded.'
				----------------------End ---------------------------------------------
			End
		End
			
			

	 COMMIT TRANSACTION
	End Try

	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: please check the details.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage
END

GO

IF OBJECT_ID('[udspDirectPaymentSave]', 'P') IS NOT NULL DROP PROCEDURE [udspDirectPaymentSave];
GO

-- =============================================
-- Author:		Rakib Alam
-- Create date: 6 June 2023
-- Description:	Save Direct Payment payment Release
-- =============================================
Create PROCEDURE [dbo].[udspDirectPaymentSave]
	@DirectPaymentID bigint,
	@ExpenseTypeID bigint,
	@ProjectID bigint,
	@PaymentDate date,
	@PaymentAmt money,
	@Purpose nvarchar(max),
	@Remarks nvarchar(max),
	@UserName nvarchar(126)
AS
BEGIN
	declare @Msg nvarchar(max)
	begin try
		begin transaction
			if(@DirectPaymentID=0)
			Begin
				Insert into utblDirectPayments(ExpenseTypeID,ProjectID,PaymentDate,
				PaymentAmt,IsDeclined,Purpose,Remarks,Status,AddedBy,AddedOn)Values
				(@ExpenseTypeID,@ProjectID,@PaymentDate,@PaymentAmt,0,@Purpose,@Remarks,'Pending',@UserName,GetDate())
				
				set @Msg = 'Success: Direct  payment details added'
			End
			else
			Begin
				Declare @ExpHeadID bigint,@PaidAmt money=0.00,@Status nvarchar(50)
				Set @ExpHeadID=(select ExpenseTypeID from utblDirectPayments where DirectPaymentID=@DirectPaymentID)
				Set @PaidAmt=(select isnull(Sum(PaymentAmt),0) from utblPaymentReleasedTrans where DirectPaymentID=@DirectPaymentID)
				Set @Status=(Select Case When @PaidAmt=0 then 'Pending' when @PaymentAmt=@PaidAmt then 'Settled' Else 'Partial Settled' End)
				Update utblDirectPayments set
				ExpenseTypeID=@ExpenseTypeID,
				ProjectID=@ProjectID,
				PaymentDate=@PaymentDate,
				PaymentAmt=@PaymentAmt,
				Purpose=@Purpose,
				Remarks=@Remarks,
				Status= @Status,
				AddedBy=@UserName,
				AddedOn=GETDATE()
				where DirectPaymentID=@DirectPaymentID
				
				if(@PaidAmt>0)
				Begin
					Update utblPaymentReleasedTrans set 
					Remarks=@Remarks where DirectPaymentID=@DirectPaymentID
				End

				Update utblPettyCashs set 
				ExpenseTypeID=@ExpenseTypeID,
				Remarks=@Remarks
				Where PaymentID in (select PaymentID from utblPaymentReleasedTrans where DirectPaymentID=@DirectPaymentID)

				set @Msg = 'Success: Updated direct payment details'

			End
			

		commit transaction
	end try
	begin catch
		rollback transaction
		select @Msg='Error: '+ERROR_MESSAGE()
	end catch
	select @Msg
END


GO

IF OBJECT_ID('[udspEmpAttendanceUpdate]', 'P') IS NOT NULL DROP PROCEDURE [udspEmpAttendanceUpdate];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-01-20
-- Description:	Update Attendance
-- =============================================
CREATE PROCEDURE [dbo].[udspEmpAttendanceUpdate] 
	@AttendanceID varchar(16),
	 @EmpID varchar(12),
	 @AttndDate datetime,
	 @InTime varchar(20),
	 @OutTime varchar(20),
	 @Remarks nvarchar(max),
	 @UserID varchar(50),
	 @LogType varchar(50)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY 
		UPDATE utblEmpAttendances
		   SET [InTime]= @InTime
			  ,[OutTime]= @OutTime
			  ,[Remarks]=@Remarks
			  ,[LogType]=@LogType
			  ,[UserID] = @UserID
			  ,[LastModifiedOn] = GETDATE()
		 WHERE [AttendanceID] = @AttendanceID 
		set @error_number = 0
		set @ErMessage = 'Success: Record updated succesfully.'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627     
				set @ErMessage = 'Error: Duplicate record found: Unit already exists, please check Unit list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage
END




GO

IF OBJECT_ID('[udspEmpDeviceMappingInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspEmpDeviceMappingInsert];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-01-20
-- Description:	EmDevicMappin Insert
-- =============================================
CREATE PROCEDURE [dbo].[udspEmpDeviceMappingInsert] 
	-- Add the parameters for the stored procedure here
	@EmployeeID nvarchar(8),
	@EmpDeviceID bigint,
	@UserName varchar(50)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		INSERT INTO utblEmpAttendanceMappings(EmployeeID,EmpDeviceID,UserID,LastModifiedOn)VALUES(@EmployeeID,@EmpDeviceID,@UserName,GETDATE())
           set @error_number = 0
           set @ErMessage = 'Success: Data Added Succesfully !'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check Units list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspEmpDtlDelete]', 'P') IS NOT NULL DROP PROCEDURE [udspEmpDtlDelete];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-01-20
-- Description:	Delete Holiday
-- =============================================
Create PROCEDURE [dbo].[udspEmpDtlDelete]
	-- Add the parameters for the stored procedure here
	@EmployeeID varchar(8)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		delete from utblEmpPersonalInfoKeys
		where EmployeeID = @EmployeeID
		delete from AspNetUsers where EmployeeID = @EmployeeID
		set @error_number = 0
		set @ErMessage = 'Success: Record Deleted Succesfully.'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error: This record could not be deleted as reference for this record exist.'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END





GO

IF OBJECT_ID('[udspEmpPersonalDtlsEdit]', 'P') IS NOT NULL DROP PROCEDURE [udspEmpPersonalDtlsEdit];
GO
-- =============================================
-- Author:		<Author,,Siddharth Chettri>
-- Create date: <Create Date,21 jan 2020,>
-- Description:	<Description,Edit Registered Employee,>
-- =============================================
CREATE PROCEDURE [dbo].[udspEmpPersonalDtlsEdit] 
	-- Add the parameters for the stored procedure here
	@EmployeeID varchar(8),
	@FName varchar(50),
	@MName varchar(50),
	@LName varchar(50),
	@DOB datetime,
	@Gender varchar(50),
	@BloodGroup varchar(20),
	@MaritalStatus varchar(50),
	@Nationality varchar(50),
	@Religion varchar(50),
	@Email varchar(50),
	@PhoneNumber varchar(15),
	@PanNo varchar(10),
	@AadharNo varchar(12),
	@PresentAddress varchar(max),
	@EmgContactName varchar(256),
	@EmgContactNo varchar(15),
	@EmgContactAddress varchar(max),
	@PhotoNormal varchar(max),
	@PhotoThumb varchar(max),
	@UserName varchar(max) 
AS
BEGIN
	declare @ErrCode int, @ErrMsg nvarchar(MAX)
	begin try
	begin transaction

		Update utblEmpPersonalInfoKeys
		set
		FName=@FName,
		MName=@MName,
		LName=@LName,
		DateOfBirth=@DOB,
		Gender=@Gender,
		Nationality =@Nationality,
		MaritalStatus =@MaritalStatus,
		Religion =@Religion,
		BloodGroup =@BloodGroup,
		PhoneNumber =@PhoneNumber,
		Email =@Email,
		PanNo =@PanNo,
		AadharNo =@AadharNo,
		PresentAddress =@PresentAddress,
		EmgContactName =@EmgContactName,
		EmgContactNo =@EmgContactNo,
		EmgContactAddress =@EmgContactAddress,
		PhotoNormal =@PhotoNormal,
		PhotoThumb =@PhotoThumb,
		UserID =@UserName,
	    LastModifiedOn=getdate()
						  where EmployeeID = @EmployeeID

						set @ErrCode = 0
						set @ErrMsg = 'success'
	commit transaction
	end try
	begin catch
	rollback transaction
	set @ErrCode = ERROR_NUMBER()
	set @ErrMsg ='Error:'+ ERROR_MESSAGE()
	end catch
	
	select @ErrMsg
END




GO

IF OBJECT_ID('[udspEmpPersonalDtlsInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspEmpPersonalDtlsInsert];
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[udspEmpPersonalDtlsInsert] 
	-- Add the parameters for the stored procedure here
	@FName varchar(50),
	@MName varchar(50),
	@LName varchar(50),
	@DOB datetime,
	@Gender varchar(50),
	@BloodGroup varchar(20),
	@MaritalStatus varchar(50),
	@Nationality varchar(50),
	@Religion varchar(50),
	@Email varchar(50),
	@PhoneNumber varchar(15),
	@PanNo varchar(10),
	@AadharNo varchar(12),
	@PresentAddress varchar(max),
	@EmgContactName varchar(256),
	@EmgContactNo varchar(15),
	@EmgContactAddress varchar(max),
	@PhotoNormal varchar(max),
	@PhotoThumb varchar(max),
	@UserName varchar(max) ,
	@NewEmpID varchar(8) out
AS
BEGIN
	declare @ErrCode int, @ErrMsg nvarchar(MAX),@ID bigint
	declare @EmpID varchar(12), @charRange char(1), @SLNo int,@Yr int,@CodeSeedsYear int
	select @CodeSeedsYear=Year from utblMstGenCodeSeeds where TableName='utblEmpPersonalInfoKeys'
	begin try
	begin transaction

	select @EmpID = MsgRcpID, @charRange = CharRange, @slno = SINo,@Yr=Year from dbo.udfGenerateEmpID('utblEmpPersonalInfoKeys')
							INSERT INTO utblEmpPersonalInfoKeys
						   (EmployeeID,FName,MName,LName,DateOfBirth,Gender,Nationality,MaritalStatus,Religion,BloodGroup,PhoneNumber,Email,PanNo,
						   AadharNo,PresentAddress,EmgContactName,EmgContactNo,EmgContactAddress,PhotoNormal,PhotoThumb,UserID,LastModifiedOn,JoinDate)
					 VALUES
						   (@EmpID,@FName,@MName,@LName,@DOB,@Gender,@Nationality,@MaritalStatus,@Religion,@BloodGroup,@PhoneNumber,@Email,
						   @PanNo,@AadharNo,@PresentAddress,@EmgContactName,@EmgContactNo,@EmgContactAddress,@PhotoNormal,@PhotoThumb,
						   @UserName ,GETDATE(),GETDATE())

							if(@slno-1=9999 and @charRange='Z')
								update utblMstGenCodeSeeds set CharRange='A', StartRange=1 where TableName='utblEmpPersonalInfoKeys'
							else if(@slno-1=9999)
								update utblMstGenCodeSeeds set CharRange=CHAR(ASCII(@charRange)+1), StartRange=1 where TableName='utblEmpPersonalInfoKeys'
							else if(@CodeSeedsYear<>@Yr)
								update utblMstGenCodeSeeds set CharRange='A', StartRange=@slno,Year=@Yr where TableName='utblEmpPersonalInfoKeys'
							else
								update utblMstGenCodeSeeds set StartRange=@slno where TableName='utblEmpPersonalInfoKeys'
						set @NewEmpID = @EmpID
						
						set @ErrCode = 0
						set @ErrMsg = 'success'
	commit transaction
	end try
	begin catch
	rollback transaction
	set @ErrCode = ERROR_NUMBER()
	set @ErrMsg ='Error:'+ ERROR_MESSAGE()
	end catch
	
	select @ErrMsg
END




GO

IF OBJECT_ID('[udspExpensesInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspExpensesInsert];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-05-10
-- Description:	Add Expenses Details
-- =============================================
CREATE PROCEDURE [dbo].[udspExpensesInsert] 
	-- Add the parameters for the stored procedure here
	@ExpDate datetime,
	@ExpType varchar(50),
	@ExpAmt decimal(10,2),
	@ACType varchar(50),
	@Remarks varchar(max),
	@UserName varchar(150)
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		INSERT INTO utblExpenseDetails(ExpenseDate,ExpenseType,ExpenseAmount,AccountType,Remarks,UserID,LastModifiedOn)
			VALUES(@ExpDate,@ExpType,@ExpAmt,@ACType,@Remarks,@UserName,GETDATE())
           set @error_number = 0
           set @ErMessage = 'Success: Data Added Succesfully !'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Expenses already exists, please check Expenses list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspExpensesUpdate]', 'P') IS NOT NULL DROP PROCEDURE [udspExpensesUpdate];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-05-10
-- Description:	Update Expenses details
-- =============================================
CREATE PROCEDURE [dbo].[udspExpensesUpdate] 
	-- Add the parameters for the stored procedure here
	
	@ExpID bigint,
	@ExpDate datetime,
	@ExpType varchar(50),
	@ExpAmt decimal(10,2),
	@ACType varchar(50),
	@Remarks varchar(max),
	@UserName varchar(150)
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		Update utblExpenseDetails set
		 ExpenseDate=@ExpDate,
		 ExpenseType=@ExpType,
		 ExpenseAmount=@ExpAmt,
		 AccountType=@ACType,
		 Remarks=@Remarks,
		 UserID=@UserName,
		 LastModifiedOn=GETDATE()
		 where ExpenseID=@ExpID
           set @error_number = 0
           set @ErMessage = 'Success: Data Update Succesfully !'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Expense already exists, please check Expense list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspGetBankLedger]', 'P') IS NOT NULL DROP PROCEDURE [udspGetBankLedger];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 7 April 2021
-- Description:	Get Bank Ledger
-- =============================================
CREATE PROCEDURE [dbo].[udspGetBankLedger]
	@BankID bigint,
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN
	declare @TransTable table
	(
		TransType varchar(50),
		TransDate datetime,
		Debit money,
		Credit money,
		Remarks nvarchar(max),
		TransID varchar(20)
	)
	
	-- Debit against procurement for project
	insert into @TransTable
	select 'Procurement', PaymentDate, PaymentAmt, 0, a.Remarks, a.PurchaseInvoiceID from utblPaymentReleasedTrans   a 
	inner join utblPurchaseInvoiceKeys b on a.PurchaseInvoiceID=b.PurchaseInvoiceID
	where BankID=@BankID and IsPOCancelled=0
	

	-- Credit received for project invoice
	insert into @TransTable
	select 'Project Payment Received', ReceivedDate, 0, 
	(isnull(NetAmtReceived,0)+isnull(TDSDeductionAmt,0)+isnull(GstDeductionAmt,0)+isnull(SecurityDepositAmt,0)+isnull(OtherDeductionAmt,0)), Remarks, ProjPaymentReceiveID 
	from utblProjPaymentReceivables a
	where BankID=@BankID  

	-- Credit received for payment receivables
	insert into @TransTable
	select 'Direct Payment Received', ReceivedDate, 0, AmtReceived, Remarks, ReceivedID from utblPaymentReceivables a
	where BankID=@BankID  
	
	-- Debit against direct payments
	insert into @TransTable
	select 'Direct Payment Released', b.PaymentDate, b.PaymentAmt, 0, Purpose, cast(a.DirectPaymentID as varchar) from utblDirectPayments a
	inner Join utblPaymentReleasedTrans b on a.DirectPaymentID=b.DirectPaymentID
	where BankID=@BankID and IsDeclined=0

	-- Debit against petty cash
	insert into @TransTable
	select 'PettyCash', TransDate, CreditAmt, 0, Remarks, cast(PettyCashID as varchar) from utblPettyCashs
	where BankID=@BankID


	select RowID, TransType, TransID, TransDate, Debit, Credit, Remarks, sum(Balance) over (order by RowID) as Balance from
	(
		select RowID=ROW_NUMBER() over (order by TransDate), TransDate, Debit, Credit, Remarks, TransType, TransID,
		Credit-Debit as Balance from @TransTable
	)a
	where (TransDate>=@StartDate or @StartDate is null)
	and (TransDate<=@EndDate or @EndDate is null)
	order by RowID desc
END


GO

IF OBJECT_ID('[udspGetChallanFiscalYearDDList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetChallanFiscalYearDDList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2025-04-04
-- Description:	Get Delivery Challan Fiscal Year DD List
-- =============================================
Create PROCEDURE [dbo].[udspGetChallanFiscalYearDDList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	
	Select Distinct (FiscalYear) from utblChallanKeys Order By FiscalYear Desc

END

GO

IF OBJECT_ID('[udspGetChallanListWithPaged]', 'P') IS NOT NULL DROP PROCEDURE [udspGetChallanListWithPaged];
GO

-- =============================================
-- Author:		Rakib Alam
-- Create date: 2025-04-04
-- Description:	Delivery Challan Details List
-- =============================================
CREATE PROCEDURE [dbo].[udspGetChallanListWithPaged]
	-- Add the parameters for the stored procedure here
	@FiscalYear varchar(10),
	@Client bigint,
	@SearchTerm varchar(50),
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY CHDate Desc,SlNo Desc),ChallanID,a.VenderID,b.VenderName as VendorName,a.ProjectID,ProjectName,
				CHRefNo,CHDate,CHToName,ClientAddress,Remarks,SlNo,FiscalYear,IsCancel,AddedBy,AddedOn
				from utblChallanKeys a
				inner join utblMstVendorDetails b on a.VenderID=b.VenderID
				Left join utblMstProjects c on a.ProjectID=c.ProjectID
				where  (FiscalYear=@FiscalYear or @FiscalYear is Null) and (a.VenderID=@Client or @Client Is Null)
				and (CHRefNo like '%' + @SearchTerm + '%' or ProjectName like '%' + @SearchTerm + '%' or @SearchTerm is null)
			) 
			A WHERE A.RowID > (@Start) 
			select	@TotalCount = COUNT(*) from utblChallanKeys a
			Left join utblMstProjects c on a.ProjectID=c.ProjectID
			where  (FiscalYear=@FiscalYear or @FiscalYear is Null) and (a.VenderID=@Client or @Client Is Null)
				and (CHRefNo like '%' + @SearchTerm + '%' or ProjectName like '%' + @SearchTerm + '%' or @SearchTerm is null)
END

GO

IF OBJECT_ID('[udspGetClientDDList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetClientDDList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-29
-- Description:	Client DD List
-- =============================================
Create PROCEDURE [dbo].[udspGetClientDDList]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	Select ClientID,ClientName from utblMstClients
END




GO

IF OBJECT_ID('[udspgetClientList]', 'P') IS NOT NULL DROP PROCEDURE [udspgetClientList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-28
-- Description:	Client master List
-- =============================================
CREATE PROCEDURE [dbo].[udspgetClientList]
	-- Add the parameters for the stored procedure here
	@ClientName varchar(100)=null,
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
		select top(@PageSize) * from 
	(
		select RowID = ROW_NUMBER() over(order by ClientName),ClientID,ClientName,ClientAddress,GSTNo,ContactNo,UserID,LastModifiedOn	from utblMstClients a
		where (ClientName like '%' +@ClientName+'%' or @ClientName is null)
	)b where b.RowID >@Start

	select @TotalCount = count (*) from utblMstClients
	where (ClientName like '%' +@ClientName+'%' or @ClientName is null)
END




GO

IF OBJECT_ID('[udspgetDashboardProjList]', 'P') IS NOT NULL DROP PROCEDURE [udspgetDashboardProjList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2021-03-18
-- Description:	Project master List for dashboard
-- =============================================
CREATE PROCEDURE [dbo].[udspgetDashboardProjList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	
		select top(5) ProjectName,b.VenderName as VendorName,
		ProjStartDate as StartDate from utblMstProjects a
		inner join utblMstVendorDetails b on a.VendorID=b.VenderID Order By ProjStartDate Desc
		
END




GO

IF OBJECT_ID('[udspgetDatewiseAttendanceList]', 'P') IS NOT NULL DROP PROCEDURE [udspgetDatewiseAttendanceList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-02-21
-- Description:	Get Employee Attendance by Attendance date
-- =============================================
CREATE PROCEDURE [dbo].[udspgetDatewiseAttendanceList]
	-- Add the parameters for the stored procedure here
	@AttendanceDate datetime,
	@Start int,
	@PageSize int,
	@TotalCount int out
	
AS
BEGIN
	Declare @AttndTableEmp as table
	(
		AttendanceID varchar(30),
		EmployeeID varchar(12), 
		EmployeeName varchar(256),
		AttendanceDate date,
		InTime char(12),
		OutTime char(12),
		AttendanceStatus varchar(12),
		Remarks varchar(256),
		UserID varchar(256),
		LastModifiedOn datetime,
		IsActive bit	
	)
	insert into @AttndTableEmp
		select AttendanceID,b.EmployeeID,RTRIM(LTRIM(RTRIM(isnull(FName,'') + ' ' + isnull(MName,''))+ ' ' + isnull(LName,''))) as EmployeeName,
	  AttendanceDate,CONVERT(char(10), [InTime], 108) as InTime,CONVERT(char(10), [OutTime], 108) as OutTime, case AttendanceStatusID when 1 then 'Present' when 2 then 'Absent' else 'NR' end,Remarks, a.UserID, a.LastModifiedOn, asp.IsActive from utblEmpAttendances a
	 left outer join utblEmpPersonalInfoKeys b on b.EmployeeID= a.EmployeeID
	 left outer join AspNetUsers asp on asp.EmployeeID=a.EmployeeID
	 --select * from @AttndTableEmp
	 where CAST(AttendanceDate as DATE)=CAST(@AttendanceDate as DATE) and b.EmployeeID<>'E20A0000' order by AttendanceID

	  insert into @AttndTableEmp
	 select null, a.EmployeeID, RTRIM(LTRIM(RTRIM(isnull(FName,'') + ' ' + isnull(MName,''))+ ' ' + isnull(LName,''))) as EmployeeName,
	 convert(date, @AttendanceDate), null,null,'NR',null,null,convert(datetime, '9999-12-31'), IsActive from utblEmpPersonalInfoKeys a
	  left outer join AspNetUsers asp on asp.EmployeeID=a.EmployeeID
	 where a.EmployeeID not in (select EmployeeID from @AttndTableEmp) and a.EmployeeID<>'E20A0000'


	 SELECT TOP (@PageSize) * FROM
			(
				SELECT RowID = ROW_NUMBER() OVER (Order By AttendanceID), AttendanceID, a.EmployeeID, EmployeeName, AttendanceDate, InTime, OutTime, 
				AttendanceStatus, Remarks, a.UserID, a.LastModifiedOn from @AttndTableEmp a 
				inner join utblEmpPersonalInfoKeys b on a.EmployeeID=b.EmployeeID where CAST(b.JoinDate as date)<=CAST(@AttendanceDate as DATE) 
			)A
		 WHERE A.RowID > (@Start)
			SELECT @TotalCount = COUNT(*)
			from @AttndTableEmp a
			inner join utblEmpPersonalInfoKeys b on a.EmployeeID=b.EmployeeID where CAST(JoinDate as date)<=CAST(@AttendanceDate as DATE) 
	
END




GO

IF OBJECT_ID('[udspGetDeliveryChallanDetailsByID]', 'P') IS NOT NULL DROP PROCEDURE [udspGetDeliveryChallanDetailsByID];
GO

-- =============================================
-- Author:		Rakib Alam
-- Create date: 2025-04-04
-- Description:	Delivery Challan Details by ID
-- =============================================
CREATE PROCEDURE [dbo].[udspGetDeliveryChallanDetailsByID]
	-- Add the parameters for the stored procedure here
	
	@ID varchar(10)
	
AS
BEGIN
		
				Select ChallanID,a.VenderID,b.VenderName as VendorName,a.ProjectID,ProjectName,
				CHRefNo,CHDate,CHToName,ClientAddress,Remarks,SlNo,FiscalYear,IsCancel,AddedBy,AddedOn
				from utblChallanKeys a
				inner join utblMstVendorDetails b on a.VenderID=b.VenderID
				Left join utblMstProjects c on a.ProjectID=c.ProjectID
				where  ChallanID=@ID
END

GO

IF OBJECT_ID('[udspGetDeliveryChallanItemList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetDeliveryChallanItemList];
GO

-- =============================================
-- Author:		Rakib Alam
-- Create date: 2025-04-04
-- Description:	Delivery Challan Item List by ID
-- =============================================
CREATE PROCEDURE [dbo].[udspGetDeliveryChallanItemList]
	-- Add the parameters for the stored procedure here
	
	@ID varchar(10)
	
AS
BEGIN
		
				Select CHItemID,ChallanID,ItemName,Quantity,a.UnitID,UnitName,SlNo
				from utblChallanItems a
				inner join utblMstUnits b on a.UnitID=b.UnitID
				where  ChallanID=@ID order By SlNo
END

GO

IF OBJECT_ID('[udspGetDirectPaymentByProjID]', 'P') IS NOT NULL DROP PROCEDURE [udspGetDirectPaymentByProjID];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-05-18
-- Description:	Direct Payment Release Details List By Project ID
-- =============================================
CREATE PROCEDURE [dbo].[udspGetDirectPaymentByProjID]
	-- Add the parameters for the stored procedure here
	@ProjID bigint
AS
BEGIN
	
	
		Select DP.DirectPaymentID,ExpenseTypeID,ExpenseTypeName,PaymentDate,PaymentAmt,
		Purpose,Remarks,Status,isnull(PaidAmount,0) as PaidAmount,(PaymentAmt-ISNULL(PaidAmount,0)) as Balance from 
		(
			Select DirectPaymentID,a.ExpenseTypeID,c.ExpenseType as ExpenseTypeName,
			PaymentDate,PaymentAmt,Purpose,Remarks,Status from utblDirectPayments a
			inner join utblMstExpenseTypes c on a.ExpenseTypeID=c.ExpenseTypeID
			Where ProjectID=@ProjID and IsDeclined=0
			
		)DP
		Left Join
		(
			select DirectPaymentID,isnull(Sum(PaymentAmt),0) as PaidAmount from utblPaymentReleasedTrans  Group By DirectPaymentID
		)payment
		on DP.DirectPaymentID=payment.DirectPaymentID
		ORDER BY PaymentDate Desc
	
	
		
END

GO

IF OBJECT_ID('[udspGetDirectPaymentDtlsByID]', 'P') IS NOT NULL DROP PROCEDURE [udspGetDirectPaymentDtlsByID];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-05-18
-- Description:	Direct Payment  Details By ID
-- =============================================
CREATE PROCEDURE [dbo].[udspGetDirectPaymentDtlsByID]
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	
		Select DP.DirectPaymentID,ExpenseTypeID,
		ExpenseTypeName,ProjectID,ProjectName,PaymentDate,PaymentAmt,IsDeclined,Purpose,
		Remarks,Status,isnull(PaidAmount,0) as PaidAmount,(PaymentAmt-ISNULL(PaidAmount,0)) as Balance,AddedBy,AddedOn from 
		(
			Select DirectPaymentID,a.ExpenseTypeID,c.ExpenseType as ExpenseTypeName,
			a.ProjectID,ProjectName,PaymentDate,PaymentAmt,IsDeclined,Purpose,
			Remarks,Status,AddedBy,AddedOn from utblDirectPayments a
			Left join utblMstProjects b on a.ProjectID=b.ProjectID 
			inner join utblMstExpenseTypes c on a.ExpenseTypeID=c.ExpenseTypeID
			Where  DirectPaymentID=@ID
		)DP
		Left Join
		(
			select DirectPaymentID,isnull(Sum(PaymentAmt),0) as PaidAmount from utblPaymentReleasedTrans  Group By DirectPaymentID
			
		)payment
		on DP.DirectPaymentID=payment.DirectPaymentID
	
	
		
END


GO

IF OBJECT_ID('[udspGetDirectPaymentListPages]', 'P') IS NOT NULL DROP PROCEDURE [udspGetDirectPaymentListPages];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-05-18
-- Description:	Direct Payment Release Details List
-- =============================================
CREATE PROCEDURE [dbo].[udspGetDirectPaymentListPages]
	-- Add the parameters for the stored procedure here
	@ExpType bigint,
	@YearNo int,
	@MonNo int,
	@Status varchar(50),
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
	
	SELECT TOP(@PageSize) * FROM 
	(
		Select RowID = ROW_NUMBER() OVER (ORDER BY PaymentDate Desc),DP.DirectPaymentID,ExpenseTypeID,
		ExpenseTypeName,ProjectID,ProjectName,PaymentDate,PaymentAmt,IsDeclined,Purpose,
		Remarks,Status,isnull(PaidAmount,0) as PaidAmount,(PaymentAmt-ISNULL(PaidAmount,0)) as Balance,AddedBy,AddedOn from 
		(
			Select DirectPaymentID,a.ExpenseTypeID,c.ExpenseType as ExpenseTypeName,
			a.ProjectID,ProjectName,PaymentDate,PaymentAmt,IsDeclined,Purpose,
			Remarks,Status,AddedBy,AddedOn from utblDirectPayments a
			Left join utblMstProjects b on a.ProjectID=b.ProjectID 
			inner join utblMstExpenseTypes c on a.ExpenseTypeID=c.ExpenseTypeID
			Where  (Year(PaymentDate)=@YearNo or @YearNo is null) and (Month(PaymentDate)=@MonNo or @MonNo is null)
			and (Status =@Status or @Status is Null) and (a.ExpenseTypeID=@ExpType or @ExpType is nUll)
		)DP
		Left Join
		(
			select DirectPaymentID,isnull(Sum(PaymentAmt),0) as PaidAmount from utblPaymentReleasedTrans  Group By DirectPaymentID
		)payment
		on DP.DirectPaymentID=payment.DirectPaymentID
	) 
	A WHERE A.RowID > (@Start) 
	select	@TotalCount = COUNT(*) from utblDirectPayments a
	Where  (Year(PaymentDate)=@YearNo or @YearNo is null) and (Month(PaymentDate)=@MonNo or @MonNo is null)
	and (Status =@Status or @Status is Null) and (a.ExpenseTypeID=@ExpType or @ExpType is nUll)
	
		
END

GO

IF OBJECT_ID('[udspGetDirectPaymentReleaseByID]', 'P') IS NOT NULL DROP PROCEDURE [udspGetDirectPaymentReleaseByID];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-05-18
-- Description:	Direct Payment Trans List BY  ID
-- =============================================
CREATE PROCEDURE [dbo].[udspGetDirectPaymentReleaseByID]
	-- Add the parameters for the stored procedure here
	@ID bigint
	
AS
BEGIN

	
		select PaymentID,PaymentDate,PaymentAmt,PaymentMode,PurchaseInvoiceID,DirectPaymentID,
		a.BankID,BankName,PaymentTransNo,UploadedFile,Remarks,AddedBy,AddedOn FROM utblPaymentReleasedTrans a
		Left Join utblMstBanks b on a.BankID=b.BankID
		where DirectPaymentID =@ID 
	
	
		
END


GO

IF OBJECT_ID('[udspgetEmpAttMappList]', 'P') IS NOT NULL DROP PROCEDURE [udspgetEmpAttMappList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-01-20
-- Description:	Holiday master List
-- =============================================
Create PROCEDURE [dbo].[udspgetEmpAttMappList]
	-- Add the parameters for the stored procedure here
	@SearchTerm varchar(100),
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
	if(@SearchTerm = '')
	BEGIN
		SELECT TOP(@PageSize) * FROM 
			(
				SELECT RowID = ROW_NUMBER() OVER (Order By a.EmployeeID),EmpDeviceMappingID, a.EmployeeID,RTRIM(LTRIM(RTRIM(isnull(FName,'') + ' ' + isnull(MName,''))+ ' ' + isnull(LName,''))) as EmployeeName,
				EmpDeviceID from utblEmpAttendanceMappings a 
				inner join	utblEmpPersonalInfoKeys b on a.EmployeeID = b.EmployeeID
			) 
			A WHERE A.RowID > (@Start)
				SELECT @TotalCount = COUNT(a.EmployeeID)
				from utblEmpAttendanceMappings a 
				inner join	utblEmpPersonalInfoKeys b on a.EmployeeID = b.EmployeeID 
	END
END





GO

IF OBJECT_ID('[udspgetEmpDetails]', 'P') IS NOT NULL DROP PROCEDURE [udspgetEmpDetails];
GO
CREATE PROCEDURE [dbo].[udspgetEmpDetails]
@Username varchar(100)
	
AS
BEGIN
	Declare @EmpID varchar(8)
	select @EmpID= EmployeeID from AspNetUsers where UserName=@Username

	select a.EmployeeID, RTRIM(LTRIM(RTRIM(isnull(FName,'') + ' ' + isnull(MName,''))+ ' ' + isnull(LName,''))) as EmployeeName,PhotoNormal,PhotoThumb,b.Role as UserRole from utblEmpPersonalInfoKeys a
	left outer join AspNetUsers b	on (a.EmployeeID = b.EmployeeID)
	where a.EmployeeID =@EmpID
END




GO

IF OBJECT_ID('[udspgetEmpMonthlyAttendance]', 'P') IS NOT NULL DROP PROCEDURE [udspgetEmpMonthlyAttendance];
GO
-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2020-02-22>
-- Description:	<Get Emp Monthly Attendance >
-- =============================================
CREATE PROCEDURE [dbo].[udspgetEmpMonthlyAttendance]
	-- Add the parameters for the stored procedure here
	@Month int,
	@Year int
AS
BEGIN
	Declare @DaysTable Table(DayNo int)
	Declare @startdate datetime,@Noofdays int,@cnt int=1
	DECLARE @ColumnName AS NVARCHAR(MAX)
	DECLARE @DynamicPivotQuery AS NVARCHAR(MAX)
	
	SELECT @startdate=DATEADD(mm, (@Year - 1900) * 12 + @Month - 1 , 1 - 1)
			SELECT @Noofdays=Day(EOMONTH(@startdate))
	if(@Year<YEAR(getdate()))
			begin
				SELECT @startdate=DATEADD(mm, (@Year - 1900) * 12 + @Month - 1 , 1 - 1)
				SELECT @Noofdays=Day(EOMONTH(@startdate))
				WHILE @cnt <= @Noofdays
				BEGIN
					insert into @DaysTable values (@cnt)
					SET @cnt = @cnt + 1;
				END;
			--Get distinct values of the PIVOT Column 
				SELECT @ColumnName= ISNULL(@ColumnName + ',','') + QUOTENAME(DayNo)	FROM (SELECT DISTINCT DayNo FROM @DaysTable) AS s
			--select @ColumnName
				SET @DynamicPivotQuery = 
				N'
					Declare @HolidayDays as table(HolidayDates datetime)
					Declare @MinDate datetime, @MaxDate datetime
					Declare cur cursor for
						select DateFrom, DateTo from utblMstHolidays where (MONTH(DateFrom) = '+CONVERT(varchar,@Month)+' and Year(DateFrom) = '+CONVERT(varchar,@Year)+') or (MONTH(DateTo) = '+CONVERT(varchar,@Month)+' and YEAR(DateTo) = '+CONVERT(varchar,@Year)+')
						open cur
						fetch next from cur into @MinDate, @MaxDate
						while(@@FETCH_STATUS=0)
						BEGIN
						insert into @HolidayDays
							SELECT distinct TOP (DATEDIFF(DAY, @MinDate, @MaxDate) + 1)
									Date = DATEADD(DAY, ROW_NUMBER() OVER(ORDER BY a.object_id) - 1, @MinDate)
							FROM    sys.all_objects a
									CROSS JOIN sys.all_objects b;
							fetch next from cur into @MinDate, @MaxDate
						END
					close cur
					deallocate cur
					select * from
					(
						select distinct RTRIM(LTRIM(RTRIM(isnull(FName,'''') + '' '' + isnull(MName,'''')) + '' '' + isnull(LName,''''))) as EmpName, Day(AttendanceDate) as DayNo, 
						case 
							when DATENAME(dw,AttendanceDate)=''Sunday'' then ''SW''
							when AttendanceDate in (select HolidayDates from @HolidayDays) and AttendanceStatusID = 1 then ''Hw''
							when AttendanceStatusID = 2 then ''Ab''
							else ''P''
						end as Types
						from utblEmpAttendances a
						inner join utblEmpPersonalInfoKeys on a.EmployeeID = utblEmpPersonalInfoKeys.EmployeeID
						where Month(AttendanceDate)='+Convert(Varchar,@Month) +'and Year(AttendanceDate)='+CONVERT(varchar,@Year)+'
					)a
					pivot
					(max(Types) for DayNo in ('+@ColumnName+'))b'

				--Execute the Dynamic Pivot Query
				EXEC sp_executesql @DynamicPivotQuery
			END
			else if(@Year=YEAR(getdate()) and @Month<=MONTH(getdate()))
			begin
				SELECT @startdate=DATEADD(mm, (@Year - 1900) * 12 + @Month - 1 , 1 - 1)
				if(@Month<MONTH(getdate()))
				begin
					SELECT @Noofdays=Day(EOMONTH(@startdate))
				end
				else if(@Month = Month(getdate()))
				begin
					select @Noofdays = datediff(day, @startdate,GETDATE()+1)
				end
				WHILE @cnt <= @Noofdays
				BEGIN
					insert into @DaysTable values (@cnt)
					SET @cnt = @cnt + 1;
				END;

				--Get distinct values of the PIVOT Column 
				SELECT @ColumnName= ISNULL(@ColumnName + ',','') + QUOTENAME(DayNo)	FROM (SELECT DISTINCT DayNo FROM @DaysTable) AS s
				--select @ColumnName
				SET @DynamicPivotQuery = 
				N'
					Declare @HolidayDays as table(HolidayDates datetime)
					Declare @MinDate datetime, @MaxDate datetime
					Declare cur cursor for
						select DateFrom, DateTo from utblMstHolidays where (MONTH(DateFrom) = '+CONVERT(varchar,@Month)+' and Year(DateFrom) = '+CONVERT(varchar,@Year)+') or (MONTH(DateTo) = '+CONVERT(varchar,@Month)+' and YEAR(DateTo) = '+CONVERT(varchar,@Year)+')
						open cur
						fetch next from cur into @MinDate, @MaxDate
						while(@@FETCH_STATUS=0)
						BEGIN
						insert into @HolidayDays
							SELECT distinct TOP (DATEDIFF(DAY, @MinDate, @MaxDate) + 1)
									Date = DATEADD(DAY, ROW_NUMBER() OVER(ORDER BY a.object_id) - 1, @MinDate)
							FROM    sys.all_objects a
									CROSS JOIN sys.all_objects b;
							fetch next from cur into @MinDate, @MaxDate
						END
					close cur
					deallocate cur
					select * from
					(
						select distinct RTRIM(LTRIM(RTRIM(isnull(FName,'''') + '' '' + isnull(MName,'''')) + '' '' + isnull(LName,''''))) as EmpName, Day(AttendanceDate) as DayNo, 
							case 
							when DATENAME(dw,AttendanceDate)=''Sunday'' then ''Sw''
							when AttendanceDate in (select HolidayDates from @HolidayDays) and AttendanceStatusID = 1 then ''Hw''
							when AttendanceStatusID = 2 then ''Ab''
							else ''P''
						end as Types
						from utblEmpAttendances a
						inner join utblEmpPersonalInfoKeys on a.EmployeeID = utblEmpPersonalInfoKeys.EmployeeID
						where Month(AttendanceDate)='+Convert(Varchar,@Month) +'and Year(AttendanceDate)='+CONVERT(varchar,@Year)+'
					)a
					pivot
					(max(Types) for DayNo in ('+@ColumnName+'))b'
	--Execute the Dynamic Pivot Query
				EXEC sp_executesql @DynamicPivotQuery
			END
END




GO

IF OBJECT_ID('[udspGetExpenseLedger]', 'P') IS NOT NULL DROP PROCEDURE [udspGetExpenseLedger];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 7 April 2021
-- Description:	Get Expenses Ledger
-- =============================================
CREATE PROCEDURE [dbo].[udspGetExpenseLedger]
	@ExpHead bigint,
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN
	declare @TransTable table
	(
		TransType varchar(50),
		TransDate datetime,
		Debit money,
		Credit money,
		Remarks nvarchar(max),
		TransID varchar(20)
	)

	declare @openingamt money, @openingdate datetime
	select @openingamt=ISNULL(OpeningAmount,0), @openingdate = OpeningDate
	from utblMstExpenseTypes where ExpenseTypeID=@ExpHead
	if(@openingamt<>0)
	begin
		if(@openingamt>0)
		begin
			insert into @TransTable
			select 'Opening', @openingdate, 0, @openingamt, 'Opening Balance', '0' 
		end
		else
		begin
			insert into @TransTable
			select 'Opening', @openingdate, ABS(@openingamt), 0, 'Opening Balance', '0' 
		end
	end

	-- Credit Payment Received 
	insert into @TransTable
	select 'Payment Received', ReceivedDate, 0, AmtReceived, Remarks, ReceivedID from utblPaymentReceivables a
	where ExpenseTypeID=@ExpHead

	-- Debit Payment Released
	insert into @TransTable
	select 'Payment Released', PaymentDate, PaymentAmt, 0, Purpose, cast(DirectPaymentID as varchar) from utblDirectPayments 
	where ExpenseTypeID=@ExpHead and IsDeclined=0


	select RowID, TransType, TransID, TransDate, Debit, Credit, Remarks, sum(Balance) over (order by RowID) as Balance from
	(
		select RowID=ROW_NUMBER() over (order by TransDate), TransDate, Debit, Credit, Remarks, TransType, TransID,
		Credit-Debit as Balance from @TransTable
	)a
	where (TransDate>=@StartDate or @StartDate is null)
	and (TransDate<=@EndDate or @EndDate is null)
	order by RowID desc
END


GO

IF OBJECT_ID('[udspGetExpensesList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetExpensesList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-05-10
-- Description:	Expenses Details List
-- =============================================
Create PROCEDURE [dbo].[udspGetExpensesList]
	-- Add the parameters for the stored procedure here
	@Type varchar(50),
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
	if(@Type = '' or @Type is null)
	BEGIN
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY ExpenseDate Desc), ExpenseID,ExpenseDate,ExpenseAmount,ExpenseType,AccountType,Remarks,UserID,LastModifiedOn 
				from utblExpenseDetails a
			) 
			A WHERE A.RowID > (@Start)
			select	@TotalCount = COUNT(ExpenseID) from utblExpenseDetails
	END
	else
	BEGIN
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY ExpenseDate Desc), ExpenseID,ExpenseDate,ExpenseAmount,ExpenseType,AccountType,Remarks,UserID,LastModifiedOn 
				from utblExpenseDetails a
				where ExpenseType like '%' + @Type + '%' or AccountType like '%' + @Type + '%'
			) 
			A WHERE A.RowID > (@Start) 
			select	@TotalCount = COUNT(ExpenseID) from utblExpenseDetails
			where ExpenseType like '%' + @Type + '%' or AccountType like '%' + @Type + '%'
	END
END





GO

IF OBJECT_ID('[udspGetExpenseTypeDDList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetExpenseTypeDDList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-26
-- Description:	ExpenseType DD List
-- =============================================
Create PROCEDURE [dbo].[udspGetExpenseTypeDDList]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	Select ExpenseTypeID,ExpenseType from utblMstExpenseTypes order By ExpenseType
END




GO

IF OBJECT_ID('[udspgetExpenseTypeList]', 'P') IS NOT NULL DROP PROCEDURE [udspgetExpenseTypeList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-01-20
-- Description:	ExpenseType master List
-- =============================================
CREATE PROCEDURE [dbo].[udspgetExpenseTypeList]
	-- Add the parameters for the stored procedure here
	@ExpenseTypeName varchar(100),
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
	if(@ExpenseTypeName = '')
	BEGIN
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY ExpenseType), ExpenseTypeID, ExpenseType,Description,
				IsProjectRelated,CanReceiveDirectPayment,OpeningAmount,OpeningDate,UserID,LastModifiedOn
				from utblMstExpenseTypes 
			) 
			A WHERE A.RowID > (@Start)
			select	@TotalCount = COUNT(ExpenseTypeID) from utblMstExpenseTypes
	END
	else
	BEGIN
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY ExpenseType), ExpenseTypeID, ExpenseType,Description,
				IsProjectRelated,CanReceiveDirectPayment,OpeningAmount,OpeningDate,UserID,LastModifiedOn
				from utblMstExpenseTypes 
				where ExpenseType like '%' + @ExpenseTypeName + '%'
			) 
			A WHERE A.RowID > (@Start) 
			select	@TotalCount = COUNT(ExpenseTypeID) from utblMstExpenseTypes
			where ExpenseType like '%' + @ExpenseTypeName + '%'
	END
END

GO

IF OBJECT_ID('[udspgetFinancialYearList]', 'P') IS NOT NULL DROP PROCEDURE [udspgetFinancialYearList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-28
-- Description:	Get Financial Year List
-- =============================================
CREATE PROCEDURE [dbo].[udspgetFinancialYearList]
	-- Add the parameters for the stored procedure here
	@Symbol varchar(10)=null,
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
			select top(@PageSize) * from 
		(
			select RowID = ROW_NUMBER() over(order by FiscalYearSymbol Desc),* from UtblMstFinancialYears
			where (FiscalYearSymbol like '%' +@Symbol+'%' or @Symbol is null)
		)b where b.RowID >@Start

	select @TotalCount = count (*) from UtblMstFinancialYears
	where (FiscalYearSymbol like '%' +@Symbol+'%' or @Symbol is null)
END




GO

IF OBJECT_ID('[udspGetFiscalYearDDList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetFiscalYearDDList];
GO
-- =============================================
-- Author:		<Rakib Alam	>
-- Create date: <27-03-2020>
-- Description:	<Get Financial Year List>
-- =============================================
Create PROCEDURE [dbo].[udspGetFiscalYearDDList] 
	
AS
BEGIN
	select distinct (FiscalYear) as FiscalYear from utblReferenceDetails order by FiscalYear Desc
	--select Distinct cast(format(DateFrom,'yyyy') as int) from utblHolidays
END

GO

IF OBJECT_ID('[udspgetHolidayList]', 'P') IS NOT NULL DROP PROCEDURE [udspgetHolidayList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-01-20
-- Description:	Holiday master List
-- =============================================
CREATE PROCEDURE [dbo].[udspgetHolidayList]
	-- Add the parameters for the stored procedure here
	@HolidayName varchar(100),
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
	if(@HolidayName = '')
	BEGIN
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY DateFrom Desc), HolidayID, HolidayName,DateFrom,DateTo,HolidayDesc,NoofDays
				from utblMstHolidays 
			) 
			A WHERE A.RowID > (@Start)
			select	@TotalCount = COUNT(HolidayID) from utblMstHolidays
	END
	else
	BEGIN
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY DateFrom Desc), HolidayID, HolidayName,DateFrom,DateTo,HolidayDesc,NoofDays
				from utblMstHolidays
				where HolidayName like '%' + @HolidayName + '%'
			) 
			A WHERE A.RowID > (@Start) 
			select	@TotalCount = COUNT(HolidayID) from utblMstHolidays
			where HolidayName like '%' + @HolidayName + '%'
	END
END





GO

IF OBJECT_ID('[udspGetInvPurchaseGST]', 'P') IS NOT NULL DROP PROCEDURE [udspGetInvPurchaseGST];
GO
-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2020-03-26>
-- Description:	<Get Invoice, Purchase & GST Details for dashboard>
-- =============================================
CREATE PROCEDURE [dbo].[udspGetInvPurchaseGST]
@FiscalYear varchar(10),
@DtVal Date
	
AS
BEGIN
	Declare @StartDate date, @EndDate date--,@DtVal date=cast('2021-05-05' as date)
	set @StartDate = cast(convert(varchar,YEAR(@DtVal)-1)+'-04-01' as date)
	set @EndDate = cast(convert(varchar,YEAR(@DtVal))+'-03-31' as date)
	--select @StartDate,@EndDate
	--select * from utblSaleInvoiceKeys

	Declare @FYInv money,@MonInv money,@FYGstPay money,@MonGstPay money,@FYPur money,@MonPur money,@FYGstInput money,@MonGstInput money
	
	select @FYInv= sum(isnull(IncludingTaxAmt,0)),@FYGstPay=(sum(isnull(IGSTAmount,0))+sum(isnull(CGSTAmount,0))+sum(isnull(SGSTAmount,0))) 
	from utblSaleInvoiceKeys where InvoiceDate between @StartDate and @EndDate
	
	select @MonInv= sum(isnull(IncludingTaxAmt,0)),@MonGstPay=( sum(isnull(IGSTAmount,0))+sum(isnull(CGSTAmount,0))+sum(isnull(SGSTAmount,0)) ) 
	from utblSaleInvoiceKeys where YEAR(InvoiceDate)=YEAR(@DtVal) and Month(InvoiceDate)=Month(@DtVal)

	
	select @FYPur= sum(isnull(IncludingTaxAmt,0)),@FYGstInput=( sum(isnull(IGSTAmount,0))+sum(isnull(CGSTAmount,0))+sum(isnull(SGSTAmount,0)) ) 
	from utblPurchaseInvoiceKeys where cast(PurchaseDate as date) between @StartDate and @EndDate
	
	select @MonPur= sum(isnull(IncludingTaxAmt,0)),@MonGstInput=( sum(isnull(IGSTAmount,0))+sum(isnull(CGSTAmount,0))+sum(isnull(SGSTAmount,0)) ) 
	from utblPurchaseInvoiceKeys where YEAR(PurchaseDate)=YEAR(@DtVal) and Month(PurchaseDate)=Month(@DtVal)

	select isnull(@FYInv,0) as FiscalInvoiceAmt,isnull(@MonInv,0) as MonthInvoiceAmt,
	isnull(@FYGstPay,0) as FiscalGSTPaymentAmt,isnull(@MonGstPay,0) as MonthGSTPaymentAmt,
	isnull(@FYPur,0) as FiscalPurchaseAmt,	isnull(@MonPur,0) as MonthPurchaseAmt,
	isnull(@FYGstInput,0) as FiscalGSTInputAmt,isnull(@MonGstInput,0) as MonthGSTInputAmt

	--select (sum(isnull(IGSTAmount,0))+sum(isnull(CGSTAmount,0))+sum(isnull(SGSTAmount,0)) ) from utblSaleInvoiceKeys
END









GO

IF OBJECT_ID('[udspGetItemAutoSearch]', 'P') IS NOT NULL DROP PROCEDURE [udspGetItemAutoSearch];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-29
-- Description:	Item List For auto complete
-- =============================================
Create PROCEDURE [dbo].[udspGetItemAutoSearch]
	-- Add the parameters for the stored procedure here
	@Search varchar(20)
AS
BEGIN
	select ItemID as value,ItemName as text from utblMstItems a
	 where ItemName like '%'+LTRIM(RTRIM(@Search))+'%' order By ItemName
END




GO

IF OBJECT_ID('[udspgetItemList]', 'P') IS NOT NULL DROP PROCEDURE [udspgetItemList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-28
-- Description:	Item master List
-- =============================================
CREATE PROCEDURE [dbo].[udspgetItemList]
	-- Add the parameters for the stored procedure here
	@ItemName varchar(100)=null,
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
		select top(@PageSize) * from 
	(
		select RowID = ROW_NUMBER() over(order by ItemName),ItemID,ItemName,ItemHSNCode,GSTPercentage,ItemDescription,UserID,LastModifiedOn	from utblMstItems a
		where (ItemName like '%' +@ItemName+'%' or @ItemName is null)
	)b where b.RowID >@Start

	select @TotalCount = count (*) from utblMstItems
	where (ItemName like '%' +@ItemName+'%' or @ItemName is null)
END




GO

IF OBJECT_ID('[udspGetItemsListByID]', 'P') IS NOT NULL DROP PROCEDURE [udspGetItemsListByID];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-08-08
-- Description:	 Items Details List
-- =============================================
CREATE PROCEDURE [dbo].[udspGetItemsListByID]
	-- Add the parameters for the stored procedure here
	@ID varchar(8),
	@Type varchar(50)
	
AS
BEGIN
	if(@Type='Sale')
	Begin
		select convert(varchar(128),ItemDtlID) as ItemDtlID,SaleInvoiceID,ItemName,a.ItemHSNCode,a.GSTPercentage,Qty,Rate,Amount,
		cast(((IGSTPercentage*Qty*Rate)/100)as decimal(10,2)) as IGSTAmt,cast(((SGSTPercentage*Qty*Rate)/100)as decimal(10,2)) as SGSTAmt,
		cast(((CGSTPercentage*Qty*Rate)/100) as decimal(10,2)) as CGSTAmt,
		cast((Amount+((IGSTPercentage*Qty*Rate)/100)+((SGSTPercentage*Qty*Rate)/100) + ((CGSTPercentage*Qty*Rate)/100))as decimal(10,2)) as TotalAmt
		from utblSaleInvoiceItems a
		where SaleInvoiceID=@ID order By SequenceNo
	End
	Else
	Begin
		select convert(varchar(128),ItemDtlID) as ItemDtlID,PurchaseInvoiceID,ItemName,a.ItemHSNCode,a.GSTPercentage,Qty,Rate,Amount,
		cast(((IGSTPercentage*Qty*Rate)/100)as decimal(10,2)) as IGSTAmt,cast(((SGSTPercentage*Qty*Rate)/100)as decimal(10,2)) as SGSTAmt,
		cast(((CGSTPercentage*Qty*Rate)/100) as decimal(10,2)) as CGSTAmt,
		cast((Amount+((IGSTPercentage*Qty*Rate)/100)+((SGSTPercentage*Qty*Rate)/100) + ((CGSTPercentage*Qty*Rate)/100))as decimal(10,2)) as TotalAmt
		from utblPurchaseInvoiceItems a
		where PurchaseInvoiceID=@ID order By SlNo
	End
	
END





GO

IF OBJECT_ID('[udspgetMonHolidayDates]', 'P') IS NOT NULL DROP PROCEDURE [udspgetMonHolidayDates];
GO
-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2020-02-22>
-- Description:	<Get Holiday date in Month >
-- =============================================
CREATE PROCEDURE [dbo].[udspgetMonHolidayDates]
	-- Add the parameters for the stored procedure here
	@Month int,
	@Year int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Declare @HolidayDays as table(HolidayDates datetime)
					Declare @MinDate datetime, @MaxDate datetime
					Declare cur cursor for
						select DateFrom, DateTo from utblMstHolidays where (MONTH(DateFrom) = CONVERT(varchar,@Month) and Year(DateFrom) = CONVERT(varchar,@Year)) or (MONTH(DateTo) = CONVERT(varchar,@Month) and YEAR(DateTo) = CONVERT(varchar,@Year))
						open cur
						fetch next from cur into @MinDate, @MaxDate
						while(@@FETCH_STATUS=0)
						BEGIN
						insert into @HolidayDays
							SELECT distinct TOP (DATEDIFF(DAY, @MinDate, @MaxDate) + 1)
									Date = DATEADD(DAY, ROW_NUMBER() OVER(ORDER BY a.object_id) - 1, @MinDate)
							FROM    sys.all_objects a
									CROSS JOIN sys.all_objects b;
							fetch next from cur into @MinDate, @MaxDate
						END

					close cur
					deallocate cur

					select * from @HolidayDays
END




GO

IF OBJECT_ID('[udspGetMonthlyCalander]', 'P') IS NOT NULL DROP PROCEDURE [udspGetMonthlyCalander];
GO
CREATE PROCEDURE [dbo].[udspGetMonthlyCalander]
@YearNo int,
@MonthNo int
AS
BEGIN
		--Declare @Year int=2021,@MonthNo int= 7
	Declare @HolidayDays as table(HolidayDates date)
	Declare @MinDate datetime, @MaxDate datetime
	Declare cur cursor for
	select DateFrom, DateTo from utblMstHolidays where (MONTH(DateFrom) = @MonthNo and Year(DateFrom) = @YearNo) or (MONTH(DateTo) = @MonthNo and YEAR(DateTo) = @YearNo)  
	open cur
	fetch next from cur into @MinDate, @MaxDate
	while(@@FETCH_STATUS=0)
		BEGIN
			;WITH DateRange(DateData) AS 
			(
				SELECT @MinDate as Date
				UNION ALL
				SELECT DATEADD(d,1,DateData)
				FROM DateRange 
				WHERE DateData < @MaxDate
			)
			insert into @HolidayDays
			SELECT DateData
			FROM DateRange
			OPTION (MAXRECURSION 0)
			fetch next from cur into @MinDate, @MaxDate
		END
	close cur
	deallocate cur

	Declare @NoOfDay int,@FDay varchar(20),@i int=1,@DateTemp Date
	Declare @tempTable as Table(CalDay varchar(20),CalDate int,HolidayName varchar(128),IsHoliday bit)
	select @NoOfDay= Day(EOMONTH(convert(datetime,(convert(varchar,@YearNo)+'/'+(convert(varchar,@MonthNo)+'/'+convert(varchar,1))))))
	select @FDay= FORMAT(convert(datetime,(convert(datetime,(convert(varchar,@YearNo)+'/'+(convert(varchar,@MonthNo)+'/'+convert(varchar,1)))))),'dddd')
	while(@i<=@NoOfDay)
	BEGIN
		select @DateTemp=convert(datetime,(convert(varchar,@YearNo)+'/'+(convert(varchar,@MonthNo)+'/'+convert(varchar,@i))))
		Declare @HolidayName varchar(128)=Null,@IsHoliday bit=0
		if(cast(@DateTemp as date) in (select HolidayDates from @HolidayDays))
		BEGIN
			Set @HolidayName=(select HolidayName from utblMstHolidays where cast(@DateTemp as date) between cast(DateFrom as date) and cast(DateTo as date) )
			Set @IsHoliday=1
		End
		insert into @tempTable values(FORMAT(@DateTemp,'dddd'),DAY(@DateTemp),@HolidayName, @IsHoliday)
		set @i=@i+1
	End
	select * from @tempTable
END




GO

IF OBJECT_ID('[udspGetMonthlyPurchaseGSTList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetMonthlyPurchaseGSTList];
GO
-- =============================================
-- Author:		<Author,,Ujjwal Singh>
-- Create date: <Create Date,,15/03/2023>
-- Description:	<Description,, select monthly Purchase GST for the financial year>
-- =============================================
CREATE PROCEDURE [dbo].[udspGetMonthlyPurchaseGSTList]
	-- Add the parameters for the stored procedure here
	@DtVal Date
AS
BEGIN
	--Declare @StartDate date, @EndDate date--,@DtVal date=cast('2021-05-05' as date)
	--set @StartDate = cast(convert(varchar,YEAR(@DtVal)-1)+'-04-01' as date)
	--set @EndDate = cast(convert(varchar,YEAR(@DtVal))+'-03-31' as date)
	Declare @StartDate Date, @EndDate Date
	if (Month(GetDate())>= 4 and Month(GetDate()) >= 3)
	Begin
		Set @StartDate=cast(convert(varchar,YEAR(GetDate()))+'-04-01' as date) 
		Set @EndDate =cast(convert(varchar,YEAR(GetDate())+1)+'-03-31' as date)        
	End
	Else
	Begin
		Set @StartDate=cast(convert(varchar,YEAR(GetDate())-1)+'-04-01' as date) 
		Set @EndDate =cast(convert(varchar,YEAR(GetDate()))+'-03-31' as date)        
	End

	Declare @Apr money,@May money,@Jun money,@Jul money,@Aug money,@Sep money,@Oct money,@Nov money, @Dec money, @Jan money, @Feb money, @Mar money

		select  @Apr = ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblPurchaseInvoiceKeys where YEAR(PurchaseDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(PurchaseDate) = 4

		select @May= ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblPurchaseInvoiceKeys where YEAR(PurchaseDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(PurchaseDate) = 5

		select @Jun=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblPurchaseInvoiceKeys where YEAR(PurchaseDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(PurchaseDate) = 6

		select @Jul=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblPurchaseInvoiceKeys where YEAR(PurchaseDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(PurchaseDate) = 7

		select @Aug=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblPurchaseInvoiceKeys where YEAR(PurchaseDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(PurchaseDate) = 8

		select @Sep=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblPurchaseInvoiceKeys where YEAR(PurchaseDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(PurchaseDate) = 9

		select @Oct=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblPurchaseInvoiceKeys where YEAR(PurchaseDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(PurchaseDate) = 10

		select @Nov=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblPurchaseInvoiceKeys where YEAR(PurchaseDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(PurchaseDate) = 11

		select @Dec=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblPurchaseInvoiceKeys where YEAR(PurchaseDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(PurchaseDate) = 12

		select @Jan=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblPurchaseInvoiceKeys where YEAR(PurchaseDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(PurchaseDate) = 1

		select @Feb=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblPurchaseInvoiceKeys where YEAR(PurchaseDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(PurchaseDate) = 2

		select @Mar=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblPurchaseInvoiceKeys where YEAR(PurchaseDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(PurchaseDate) = 3



	select  Concat(@Apr,',' ,@May,',' ,@Jun,',' ,@Jul,',' ,@Aug,',' ,@Sep,',' ,@Oct,',' ,@Nov,',' , @Dec,',' , @Jan,',' , @Feb,',' , @Mar )as Amount
END


GO

IF OBJECT_ID('[udspGetMonthlySaleGSTList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetMonthlySaleGSTList];
GO
-- =============================================
-- Author:		<Author,,Ujjwal Singh>
-- Create date: <Create Date,,15/03/2023>
-- Description:	<Description,, select monthly Sale GST for the financial year>
-- =============================================
CREATE PROCEDURE [dbo].[udspGetMonthlySaleGSTList]
	-- Add the parameters for the stored procedure here
	@DtVal Date
AS
BEGIN
	--Declare @DtVal Date=GetDate()
	--Declare @StartDate date, @EndDate date--,@DtVal date=cast('2021-05-05' as date)
	--set @StartDate = cast(convert(varchar,YEAR(@DtVal)-1)+'-04-01' as date)
	--set @EndDate = cast(convert(varchar,YEAR(@DtVal))+'-03-31' as date)

	Declare @StartDate Date, @EndDate Date
	if (Month(GetDate())>= 4 and Month(GetDate()) >= 3)
	Begin
		Set @StartDate=cast(convert(varchar,YEAR(GetDate()))+'-04-01' as date) 
		Set @EndDate =cast(convert(varchar,YEAR(GetDate())+1)+'-03-31' as date)        
	End
	Else
	Begin
		Set @StartDate=cast(convert(varchar,YEAR(GetDate())-1)+'-04-01' as date) 
		Set @EndDate =cast(convert(varchar,YEAR(GetDate()))+'-03-31' as date)        
	End

	--select @StartDate,@EndDate
	Declare @Apr money,@May money,@Jun money,@Jul money,@Aug money,@Sep money,@Oct money,@Nov money, @Dec money, @Jan money, @Feb money, @Mar money

		select  @Apr = ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblSaleInvoiceKeys where YEAR(InvoiceDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(InvoiceDate) = 4

		select @May= ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblSaleInvoiceKeys where YEAR(InvoiceDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(InvoiceDate) = 5

		select @Jun=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblSaleInvoiceKeys where YEAR(InvoiceDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(InvoiceDate) = 6

		select @Jul=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblSaleInvoiceKeys where YEAR(InvoiceDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(InvoiceDate) = 7

		select @Aug=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblSaleInvoiceKeys where YEAR(InvoiceDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(InvoiceDate) = 8

		select @Sep=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblSaleInvoiceKeys where YEAR(InvoiceDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(InvoiceDate) = 9

		select @Oct=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblSaleInvoiceKeys where YEAR(InvoiceDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(InvoiceDate) = 10

		select @Nov=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblSaleInvoiceKeys where YEAR(InvoiceDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(InvoiceDate) = 11

		select @Dec=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblSaleInvoiceKeys where YEAR(InvoiceDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(InvoiceDate) = 12

		select @Jan=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblSaleInvoiceKeys where YEAR(InvoiceDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(InvoiceDate) = 1

		select @Feb=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblSaleInvoiceKeys where YEAR(InvoiceDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(InvoiceDate) = 2

		select @Mar=ISNULL(SUM(isnull(IGSTAmount,0)+isnull(CGSTAmount,0)+isnull(SGSTAmount,0)),0)
	from utblSaleInvoiceKeys where YEAR(InvoiceDate) between YEAR(@StartDate) and YEAR(@EndDate) and MONTH(InvoiceDate) = 3


	select  Concat(@Apr,',' ,@May,',' ,@Jun,',' ,@Jul,',' ,@Aug,',' ,@Sep,',' ,@Oct,',' ,@Nov,',' , @Dec,',' , @Jan,',' , @Feb,',' , @Mar )as Amount
END


GO

IF OBJECT_ID('[udspgetMstReferenceNumberList]', 'P') IS NOT NULL DROP PROCEDURE [udspgetMstReferenceNumberList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-28
-- Description:	Get mst Reference Number List
-- =============================================
CREATE PROCEDURE [dbo].[udspgetMstReferenceNumberList]
	-- Add the parameters for the stored procedure here
	@Symbol varchar(10)=null,
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
--select * from utblMstReferenceNumbers
			select top(@PageSize) * from 
		(
			select RowID = ROW_NUMBER() over(order by FiscalYearSymbol Desc),RefID,FiscalYearSymbol,Prefix,Suffix,StartNo,CurrentNo from utblMstReferenceNumbers
			where (FiscalYearSymbol like '%' +@Symbol+'%' or @Symbol is null)
		)b where b.RowID >@Start

	select @TotalCount = count (*) from utblMstReferenceNumbers
	where (FiscalYearSymbol like '%' +@Symbol+'%' or @Symbol is null)
END




GO

IF OBJECT_ID('[udspGetNewReferenceNumber]', 'P') IS NOT NULL DROP PROCEDURE [udspGetNewReferenceNumber];
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[udspGetNewReferenceNumber]
	-- Add the parameters for the stored procedure here
	@BillingDate date
AS
BEGIN
	Declare @FiscalSyb varchar(7),@RefNo varchar(25),@ErrorMsg varchar(256)
	Select @FiscalSyb= FiscalYearSymbol from UtblMstFinancialYears where cast(@BillingDate as date) between StartDate and EndDate and Active=1
	if(@FiscalSyb is null)
	Begin
		set @ErrorMsg ='Error: Financial Year Not Available/Active. Please check in Financial Year master and try it again'
		select null as InvoiceNo,null as FiscalYear,@ErrorMsg as OperationMsg
	End
	Else
	Begin
		Select @RefNo= CONCAT(Prefix,'/',@FiscalSyb,'/',CurrentNo+1,'/',Suffix) from utblMstReferenceNumbers where FiscalYearSymbol= @FiscalSyb
		select @RefNo as InvoiceNo,@FiscalSyb as FiscalYear,'Success' as OperationMsg
	End
END


GO

IF OBJECT_ID('[udspGetNotificationAlert]', 'P') IS NOT NULL DROP PROCEDURE [udspGetNotificationAlert];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 10-05-2023
-- Description:	Get Notification Alert Count
-- =============================================
CREATE PROCEDURE [dbo].[udspGetNotificationAlert]
	@Email varchar(256)
AS
BEGIN
	--Declare @Email varchar(100)='info@sdksolution.co.in'
	Declare @Role varchar(100)
	Set @Role=(select Role From AspNetusers Where UserName=@Email)
	Declare @TempAlertTable as Table(AlertName nvarchar(256),AlertCount int,AlertURL nvarchar(max) )
	if(@Role='Super Admin')
	Begin
		---------Insert Into @TempAlertTable
		Insert Into @TempAlertTable (AlertName,AlertCount,AlertURL)
		Select 'Direct Payment For Approval' as AlertName, Count(DirectPaymentID) as AlertCount,'/directpayment/index' as AlertURL 
		from  utblDirectPayments where Status='Pending'
		union All
		Select 'Direct Payment For Settlement' as AlertName, Count(DirectPaymentID) as AlertCount,'/directpayment/index' as AlertURL 
		from utblDirectPayments where Status='Approved'
		union All
		Select 'Mark for Payment for Procurement' as AlertName, Count(PurchaseInvoiceID) as AlertCount,'/invoice/purchaseinvoicelist' as AlertURL 
		from utblPurchaseInvoiceKeys where IsPOCancelled=0 and HasMarkForPayment=0 and Cast(PurchaseDate as date)>Cast('2023-09-01'as Date)
		union All
		Select 'Procurement For Settlement' as AlertName, Count(PurchaseInvoiceID) as AlertCount,'/popayment/index' as AlertURL 
		from utblPurchaseInvoiceKeys where IsPOCancelled=0 and HasMarkForPayment=1 and
		AmountPaid=0 and Cast(PurchaseDate as date)>Cast('2023-09-01'as Date)
		--union All
		--Select 'Payment Follow-Up for Invoice' as AlertName, Count(PurchaseInvoiceID) as AlertCount,'/popayment/index' as AlertURL 
		--from utblPurchaseInvoiceKeys where IsPOCancelled=0 and HasMarkForPayment=1 and
		--AmountPaid=0 and Cast(PurchaseDate as date)>Cast('2023-09-01'as Date)
		
	End
	else if(@Role='Accountant')
	Begin
		---------Insert Into @TempAlertTable
		Insert Into @TempAlertTable (AlertName,AlertCount,AlertURL)
		Select 'Direct Payment For Settlement' as AlertName, Count(DirectPaymentID) as AlertCount,'/directpayment/index' as AlertURL 
		from utblDirectPayments where Status='Approved'
		union All
		Select 'Procurement For Settlement' as AlertName, Count(PurchaseInvoiceID) as AlertCount,'/popayment/index' as AlertURL 
		from utblPurchaseInvoiceKeys where IsPOCancelled=0 and HasMarkForPayment=1 and
		AmountPaid=0 and Cast(PurchaseDate as date)>Cast('2023-09-01'as Date)
		--union All
		--Select 'Payment Follow-Up for Invoice' as AlertName, Count(PurchaseInvoiceID) as AlertCount,'/popayment/index' as AlertURL 
		--from utblPurchaseInvoiceKeys where IsPOCancelled=0 and HasMarkForPayment=1 and
		--AmountPaid=0 and Cast(PurchaseDate as date)>Cast('2023-09-01'as Date)
	End
	Else
	Begin
		Insert Into @TempAlertTable (AlertName,AlertCount,AlertURL)
		Select 'Marked for Payment for Procurement' as AlertName, Count(PurchaseInvoiceID) as AlertCount,'/invoice/purchaseinvoicelist' as AlertURL 
		from utblPurchaseInvoiceKeys where IsPOCancelled=0 and HasMarkForPayment=1 and Cast(PurchaseDate as date)>Cast('2023-09-01'as Date)
	End
	select AlertName,AlertCount,AlertURL from @TempAlertTable
END


GO

IF OBJECT_ID('[udspGetOfficalDocsList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetOfficalDocsList];
GO
-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2020-03-26>
-- Description:	<Upload Offical docs>
-- =============================================
Create PROCEDURE [dbo].[udspGetOfficalDocsList]
@RefID bigint
AS
BEGIN
	select DocID,DocName,ReferenceID,DocPath from utblOfficalLetterDocs Where ReferenceID=@RefID
END









GO

IF OBJECT_ID('[udspGetPaymentPages]', 'P') IS NOT NULL DROP PROCEDURE [udspGetPaymentPages];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-08-22
-- Description:	Get Payment Details list in pages 
-- =============================================
CREATE PROCEDURE [dbo].[udspGetPaymentPages]
	-- Add the parameters for the stored procedure here
	@SearchTerm varchar(50)=null,
	@PaymentType nvarchar(50),
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY a.PaymentDate Desc), PaymentID,a.ExpenseTypeID,ExpenseType,
				PaymentDate,PaymentAmt,PaymentMode,a.BankID,BankName,ChequeTransNo,PaymentFile,a.VendorID,
				isnull(VenderName,'N/A') as VendorName,	a.ProjectID,isnull(ProjectName,'N/A') as ProjectName,PaymentType,Remarks
				from utblPaymentDetails a
				inner join utblMstExpenseTypes e on a.ExpenseTypeID=e.ExpenseTypeID
				Left Outer Join utblMstVendorDetails v on a.VendorID=v.VenderID
				Left Outer Join utblMstBanks b on a.BankID=b.BankID
				Left Outer Join utblMstProjects p on a.ProjectID=p.ProjectID
				where PaymentType=@PaymentType and (ExpenseType like '%' + @SearchTerm + '%' or  @SearchTerm is null)
			) 
			A WHERE A.RowID > (@Start) 
			select	@TotalCount = COUNT(*) from utblPaymentDetails a
			inner join utblMstExpenseTypes e on a.ExpenseTypeID=e.ExpenseTypeID
			where PaymentType=@PaymentType and (ExpenseType like '%' + @SearchTerm + '%' or  @SearchTerm is null)
END





GO

IF OBJECT_ID('[udspGetPaymentReceivedListByProjID]', 'P') IS NOT NULL DROP PROCEDURE [udspGetPaymentReceivedListByProjID];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-08-22
-- Description:	Get Project Payment Receive Details list By Project ID
-- =============================================
Create PROCEDURE [dbo].[udspGetPaymentReceivedListByProjID]
	-- Add the parameters for the stored procedure here
	@ProjID bigint
AS
BEGIN
	select ProjPaymentReceiveID,a.ProjectID,ProjectName,a.BankID,BankName,ReceivedDate,ReceivedMode,
	Remarks,NetAmtReceived,TDSDeductionAmt,GstDeductionAmt,SecurityDepositAmt,OtherDeductionAmt,
	(Isnull(NetAmtReceived,0)+Isnull(TDSDeductionAmt,0)+Isnull(GstDeductionAmt,0)+Isnull(SecurityDepositAmt,0)+Isnull(OtherDeductionAmt,0)) as TotalAmt,
	IsAdvance,UploadedFile	from utblProjPaymentReceivables a
	Left Outer Join utblMstBanks b on a.BankID=b.BankID
	Inner Join utblMstProjects p on a.ProjectID=p.ProjectID
	where  (a.ProjectID=@ProjID) Order By ReceivedDate Desc
			
END


GO

IF OBJECT_ID('[udspGetpettyCashBook]', 'P') IS NOT NULL DROP PROCEDURE [udspGetpettyCashBook];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 6 May 2023
-- Description:	Get Petty Cash Book Dtls List By Month and Year
-- =============================================
CREATE PROCEDURE [dbo].[udspGetpettyCashBook]
	@MonthNo int,
	@YearNo int
AS
BEGIN
	
		select PettyCashID,TransDate,Case When ExpenseType='Bank' Then Concat(ExpenseType,'(Bank Name:',BankName,')')Else ExpenseType End as ExpenseType,
		isnull(CreditAmt,0) as CreditAmt,isnull(DebitAmt,0) as DebitAmt,Remarks,IsClosed from utblPettyCashs a
		inner Join utblMstExpenseTypes b on a.ExpenseTypeID=b.ExpenseTypeID
		left Join utblMstBanks c on a.BankID=c.BankID
		where Year(TransDate)=@YearNo and Month(TransDate)=@MonthNo order By TransDate
END




GO

IF OBJECT_ID('[udspGetPettyCashByID]', 'P') IS NOT NULL DROP PROCEDURE [udspGetPettyCashByID];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 6 May 2023
-- Description:	Petty Cash  Details By ID
-- =============================================
Create PROCEDURE [dbo].[udspGetPettyCashByID]
	-- Add the parameters for the stored procedure here
	@PettyCashID bigint
	
AS
BEGIN

			select PettyCashID,TransDate,ExpenseTypeID,ReceivedID,BankID,CreditAmt,DebitAmt,Remarks,IsClosed,FilePath 
			from  utblPettyCashs where PettyCashID=@PettyCashID
				
	
END

GO

IF OBJECT_ID('[udspGetPODetailsByProjID]', 'P') IS NOT NULL DROP PROCEDURE [udspGetPODetailsByProjID];
GO

-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-08-22
-- Description:	PO Details List By Project ID
-- =============================================
CREATE PROCEDURE [dbo].[udspGetPODetailsByProjID]
	-- Add the parameters for the stored procedure here
	@ProjID bigint
AS
BEGIN
		
	select PurchaseInvoiceID,cast(PurchaseDate as date) as PurchaseDate,Case When PORefNo Is not Null Then PORefNo When BillNo is not Null then BillNo Else Null End as BillNoRefNo,
	b.VenderName as VendorName, (Isnull(IGSTAmount,0)+ ISNULL(CGSTAmount,0)+ISNULL(SGSTAmount,0))as GSTAmt,Isnull(ExcludingTaxAmt,0) as NetAmt,Isnull(IncludingTaxAmt,0)as TotalAmt,
	isnull(AmountPaid,0)as PaymentReleased,isnull(BalanceAmount,0)as DueAmt,HasMarkForPayment
	from utblPurchaseInvoiceKeys a
	inner join utblMstVendorDetails b on a.VenderID=b.VenderID
	where   ProjectID=@ProjID and IsPOCancelled=0 Order By PurchaseDate Desc
				
END


GO

IF OBJECT_ID('[udspGetPOPaymentDtlsByID]', 'P') IS NOT NULL DROP PROCEDURE [udspGetPOPaymentDtlsByID];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-05-18
-- Description:	PO Payment Details BY PO ID
-- =============================================
Create PROCEDURE [dbo].[udspGetPOPaymentDtlsByID]
	-- Add the parameters for the stored procedure here
	@ID varchar(10)
	
AS
BEGIN

	Select PurchaseInvoiceID,PurchaseDate,
	PORefNo,BillNo,POType,a.ProjectID,ProjectName,a.VenderID,VenderName,
	IGSTAmount,CGSTAmount,SGSTAmount,(IGSTAmount+CGSTAmount+SGSTAmount)as TotalGSTInput,
	ExcludingTaxAmt,IncludingTaxAmt,AmountPaid,BalanceAmount,Remarks,UploadBill,ShipTo,TermsConditions,
	IsPOCancelled,HasMarkForPayment,IsPaymentDeclined from utblPurchaseInvoiceKeys a
	Left join utblMstProjects b on a.ProjectID=b.ProjectID 
	Left join utblMstVendorDetails c on a.VenderID=c.VenderID 
	where PurchaseInvoiceID =@ID

		
END

GO

IF OBJECT_ID('[udspGetPOPaymentListPages]', 'P') IS NOT NULL DROP PROCEDURE [udspGetPOPaymentListPages];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-05-18
-- Description:	PO Payment Details List
-- =============================================
CREATE PROCEDURE [dbo].[udspGetPOPaymentListPages]
	-- Add the parameters for the stored procedure here
	@Vendor bigint,
	@Status nvarchar(50),
	@SearchTerm nvarchar(50),
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
	if(@Status='Active')--UnSettle Payment
	Begin
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY PurchaseDate Desc), PurchaseInvoiceID,PurchaseDate,
				PORefNo,BillNo,POType,@Status as POStatus,a.ProjectID,ProjectName,a.VenderID,VenderName,
				IGSTAmount,CGSTAmount,SGSTAmount,(IGSTAmount+CGSTAmount+SGSTAmount)as TotalGSTInput,
				ExcludingTaxAmt,IncludingTaxAmt,AmountPaid,BalanceAmount,Remarks,UploadBill,ShipTo,TermsConditions,
				IsPOCancelled,HasMarkForPayment,IsPaymentDeclined from utblPurchaseInvoiceKeys a
				Left join utblMstProjects b on a.ProjectID=b.ProjectID 
				Left join utblMstVendorDetails c on a.VenderID=c.VenderID 
				where HasMarkForPayment=1 and IsPOCancelled=0 and AmountPaid=0 and BalanceAmount=IncludingTaxAmt
				and (a.VenderID=@Vendor or @Vendor Is Null) and	((PORefNo like '%'+@SearchTerm+'%') or (BillNo like '%'+@SearchTerm+'%') Or @SearchTerm Is NULL)
			) 
			A WHERE A.RowID > (@Start) 
			select	@TotalCount = COUNT(*) from utblPurchaseInvoiceKeys a
			where HasMarkForPayment=1 and IsPOCancelled=0 and AmountPaid=0 and BalanceAmount=IncludingTaxAmt
			and (a.VenderID=@Vendor or @Vendor Is Null) and	((PORefNo like '%'+@SearchTerm+'%') or (BillNo like '%'+@SearchTerm+'%') Or @SearchTerm Is NULL)
	End
	else if(@Status='Partial Settled')--Partial Settlement
	Begin
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY PurchaseDate Desc), PurchaseInvoiceID,PurchaseDate,
				PORefNo,BillNo,POType,@Status as POStatus,a.ProjectID,ProjectName,a.VenderID,VenderName,
				IGSTAmount,CGSTAmount,SGSTAmount,(IGSTAmount+CGSTAmount+SGSTAmount)as TotalGSTInput,
				ExcludingTaxAmt,IncludingTaxAmt,AmountPaid,BalanceAmount,Remarks,UploadBill,ShipTo,TermsConditions,
				IsPOCancelled,HasMarkForPayment,IsPaymentDeclined from utblPurchaseInvoiceKeys a
				Left join utblMstProjects b on a.ProjectID=b.ProjectID 
				Left join utblMstVendorDetails c on a.VenderID=c.VenderID 
				where HasMarkForPayment=1 and IsPOCancelled=0 and AmountPaid>0 and BalanceAmount>1
				and (a.VenderID=@Vendor or @Vendor Is Null) and		((PORefNo like '%'+@SearchTerm+'%') or (BillNo like '%'+@SearchTerm+'%') Or @SearchTerm Is NULL)
			) 
			A WHERE A.RowID > (@Start) 
			select	@TotalCount = COUNT(*) from utblPurchaseInvoiceKeys a
			where HasMarkForPayment=1 and IsPOCancelled=0 and AmountPaid>0 and BalanceAmount>1
			and (a.VenderID=@Vendor or @Vendor Is Null) and	((PORefNo like '%'+@SearchTerm+'%') or (BillNo like '%'+@SearchTerm+'%') Or @SearchTerm Is NULL)
	End
	else if(@Status='Fully Settled')--Fully Settlement
	Begin
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY PurchaseDate Desc), PurchaseInvoiceID,PurchaseDate,
				PORefNo,BillNo,POType,@Status as POStatus,a.ProjectID,ProjectName,a.VenderID,VenderName,
				IGSTAmount,CGSTAmount,SGSTAmount,(IGSTAmount+CGSTAmount+SGSTAmount)as TotalGSTInput,
				ExcludingTaxAmt,IncludingTaxAmt,AmountPaid,BalanceAmount,Remarks,UploadBill,ShipTo,TermsConditions,
				IsPOCancelled,HasMarkForPayment,IsPaymentDeclined from utblPurchaseInvoiceKeys a
				Left join utblMstProjects b on a.ProjectID=b.ProjectID 
				Left join utblMstVendorDetails c on a.VenderID=c.VenderID 
				where HasMarkForPayment=1 and IsPOCancelled=0 and AmountPaid>0 and BalanceAmount<=1
				and (a.VenderID=@Vendor or @Vendor Is Null) and		((PORefNo like '%'+@SearchTerm+'%') or (BillNo like '%'+@SearchTerm+'%') Or @SearchTerm Is NULL)
			) 
			A WHERE A.RowID > (@Start) 
			select	@TotalCount = COUNT(*) from utblPurchaseInvoiceKeys a
			where HasMarkForPayment=1 and IsPOCancelled=0 and AmountPaid>0 and BalanceAmount<=1
			and (a.VenderID=@Vendor or @Vendor Is Null) and		((PORefNo like '%'+@SearchTerm+'%') or (BillNo like '%'+@SearchTerm+'%') Or @SearchTerm Is NULL)
	End
	else --Declined Settlement
	Begin
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY PurchaseDate Desc), PurchaseInvoiceID,PurchaseDate,
				PORefNo,BillNo,POType,@Status as POStatus,a.ProjectID,ProjectName,a.VenderID,VenderName,
				IGSTAmount,CGSTAmount,SGSTAmount,(IGSTAmount+CGSTAmount+SGSTAmount)as TotalGSTInput,
				ExcludingTaxAmt,IncludingTaxAmt,AmountPaid,BalanceAmount,Remarks,UploadBill,ShipTo,TermsConditions,
				IsPOCancelled,HasMarkForPayment,IsPaymentDeclined from utblPurchaseInvoiceKeys a
				Left join utblMstProjects b on a.ProjectID=b.ProjectID 
				Left join utblMstVendorDetails c on a.VenderID=c.VenderID 
				where HasMarkForPayment=1 and IsPOCancelled=1 and AmountPaid>0
				and (a.VenderID=@Vendor or @Vendor Is Null) and		((PORefNo like '%'+@SearchTerm+'%') or (BillNo like '%'+@SearchTerm+'%') Or @SearchTerm Is NULL)
			) 
			A WHERE A.RowID > (@Start) 
			select	@TotalCount = COUNT(*) from utblPurchaseInvoiceKeys a
			where HasMarkForPayment=1 and IsPOCancelled=1 and AmountPaid>0
			and (a.VenderID=@Vendor or @Vendor Is Null) and	((PORefNo like '%'+@SearchTerm+'%') or (BillNo like '%'+@SearchTerm+'%') Or @SearchTerm Is NULL)
	End

		
END

GO

IF OBJECT_ID('[udspGetPOPaymentReleaseByID]', 'P') IS NOT NULL DROP PROCEDURE [udspGetPOPaymentReleaseByID];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-05-18
-- Description:	PO Payment Trans List BY PO ID
-- =============================================
CREATE PROCEDURE [dbo].[udspGetPOPaymentReleaseByID]
	-- Add the parameters for the stored procedure here
	@ID varchar(10)
	--@PaymentFor varchar(50)
	
AS
BEGIN

	
		select PaymentID,PaymentDate,PaymentAmt,PaymentMode,PurchaseInvoiceID,DirectPaymentID,
		a.BankID,BankName,PaymentTransNo,UploadedFile,Remarks,AddedBy,AddedOn FROM utblPaymentReleasedTrans a
		Left Join utblMstBanks b on a.BankID=b.BankID
		where PurchaseInvoiceID =@ID
	
	
		
END


GO

IF OBJECT_ID('[udspGetProjAmountTransByID]', 'P') IS NOT NULL DROP PROCEDURE [udspGetProjAmountTransByID];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2021-03-18
-- Description:	Project Amount Transaction Details By ID
-- =============================================
CREATE PROCEDURE [dbo].[udspGetProjAmountTransByID]
	-- Add the parameters for the stored procedure here
	@ProjID bigint
AS
BEGIN
	Declare @TProjVal decimal(10,2)=0.0,@TNetAmt decimal(10,2)=0.0,@TDeduction decimal(10,2)=0.0,
	@TTDS decimal(10,2)=0.0,@TGST decimal(10,2)=0.0,@TSD decimal(10,2)=0.0,@TOthers decimal(10,2)=0.0,
	@TAmtReceived decimal(10,2)=0.0,@Balance decimal(10,2)=0.0,@TGSTInput decimal(10,2)=0.0,@TGSTPayable decimal(10,2)=0.0
	
	Set  @TProjVal=(select isnull(ProjValue,0) from utblMstProjects where ProjectID=@ProjID)

	select @TTDS=Sum(isnull(TDSDeductionAmt,0)),@TGST=sum(isnull(GstDeductionAmt,0)),@TSD=sum(isnull(SecurityDepositAmt,0)),@TOthers=sum(isnull(OtherDeductionAmt,0))
	from utblProjPaymentReceivables where ProjectID=@ProjID

	--select @TTDS ,@TGST,@TSD,@TOthers
	Set  @TNetAmt=(select sum(ISNULL(NetAmtReceived,0)) from utblProjPaymentReceivables where ProjectID=@ProjID)
	
	Set  @TGSTInput=(select (sum(isnull(IGSTAmount,0))+sum(isnull(CGSTAmount,0))+sum(isnull(SGSTAmount,0))) from utblPurchaseInvoiceKeys where ProjectID=@ProjID and IsPOCancelled=0)
	Set  @TGSTPayable=(select (sum(isnull(IGSTAmount,0))+sum(isnull(CGSTAmount,0))+sum(isnull(SGSTAmount,0))) from utblSaleInvoiceKeys where ProjectID=@ProjID and IsCancelled=0)

	select isnull(@TProjVal,0) as TotalProjectValue,isnull(@TNetAmt,0) as TotalNetAmtReceived,(isnull(@TTDS,0)+isnull(@TGST,0)+isnull(@TSD,0)+isnull(@TOthers,0))as TotalTaxDeduction,
	(isnull(@TNetAmt,0)+isnull(@TTDS,0)+isnull(@TGST,0)+isnull(@TSD,0)+isnull(@TOthers,0))as TotalAmtReceived,
	((isnull(@TProjVal,0))-(isnull(@TNetAmt,0)+isnull(@TTDS,0)+isnull(@TGST,0)+isnull(@TSD,0)+isnull(@TOthers,0))) as ProjectBalance,
	isnull(@TGSTInput,0) as TotalGSTInput,isnull(@TGSTPayable,0) as TotalGSTPayable

		
END

GO

IF OBJECT_ID('[udspGetProjClientByID]', 'P') IS NOT NULL DROP PROCEDURE [udspGetProjClientByID];
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[udspGetProjClientByID]
	-- Add the parameters for the stored procedure here
	@ProjID bigint
AS
BEGIN

	Select ProjectID,ProjectName,ProjStartDate,ProjStatus,ProjValue,ProjDescription,convert(varchar, WODate, 106) as WODate,WONo,
	a.VendorID,VenderName,VenderAddress,GSTNo,ContactName,ContactNo from utblMstProjects a
	inner Join utblMstVendorDetails b on b.VenderID=a.VendorID Where ProjectID=@ProjID
     
	
END


GO

IF OBJECT_ID('[udspGetProjectDetailsByID]', 'P') IS NOT NULL DROP PROCEDURE [udspGetProjectDetailsByID];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2021-03-18
-- Description:	Project Details By ID
-- =============================================
Create PROCEDURE [dbo].[udspGetProjectDetailsByID]
	-- Add the parameters for the stored procedure here
	@ProjID bigint
AS
BEGIN
		select ProjectID,ProjectName,a.VendorID,b.VenderName as VendorName,	ProjStartDate,ProjEndDate,
		ProjStatus,ProjValue,ProjDescription,WODate,WONo,WOPath,PCCPath from utblMstProjects a
		inner join utblMstVendorDetails b on a.VendorID=b.VenderID
		where a.ProjectID=@ProjID
		
END




GO

IF OBJECT_ID('[udspGetProjectLedger]', 'P') IS NOT NULL DROP PROCEDURE [udspGetProjectLedger];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 7 April 2021
-- Description:	Get Project Ledger
-- =============================================
Create PROCEDURE [dbo].[udspGetProjectLedger]
	@ProjID bigint,
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN
	declare @TransTable table
	(
		TransType varchar(50),
		TransDate datetime,
		Debit money,
		Credit money,
		Remarks nvarchar(max),
		TransID varchar(20)
	)

	-- Credit for procurement
	insert into @TransTable
	select 'Project Payment Received', ReceivedDate, 0, 
	(isnull(NetAmtReceived,0)+isnull(TDSDeductionAmt,0)+isnull(GstDeductionAmt,0)+isnull(SecurityDepositAmt,0)+isnull(OtherDeductionAmt,0)), Remarks, ProjPaymentReceiveID 
	from utblProjPaymentReceivables a
	where a.ProjectID=@ProjID 

	-- Debit for procurement
	insert into @TransTable
	select 'Procurement Payment', PaymentDate, PaymentAmt, 0, a.Remarks, a.PurchaseInvoiceID from utblPaymentReleasedTrans   a 
	inner join utblPurchaseInvoiceKeys b on a.PurchaseInvoiceID=b.PurchaseInvoiceID
	where b.ProjectID=@ProjID and IsPOCancelled=0
	
	-- Debit for procurement
	insert into @TransTable
	select 'Payment Released', PaymentDate, PaymentAmt, 0, Purpose, cast(DirectPaymentID as varchar) from utblDirectPayments 
	where ProjectID=@ProjID and IsDeclined=0

	select RowID, TransType, TransID, TransDate, Debit, Credit, Remarks, sum(Balance) over (order by RowID) as Balance from
	(
		select RowID=ROW_NUMBER() over (order by TransDate), TransDate, Debit, Credit, Remarks, TransType, TransID,
		Credit-Debit as Balance from @TransTable
	)a
	where (TransDate>=@StartDate or @StartDate is null)
	and (TransDate<=@EndDate or @EndDate is null)
	order by RowID desc
END


GO

IF OBJECT_ID('[udspgetProjectList]', 'P') IS NOT NULL DROP PROCEDURE [udspgetProjectList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2021-03-18
-- Description:	Project master List
-- =============================================
CREATE PROCEDURE [dbo].[udspgetProjectList]
	-- Add the parameters for the stored procedure here
	@ProjName varchar(100)=null,
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
		select top(@PageSize) * from 
	(
		select RowID = ROW_NUMBER() over(order by ProjStartDate Desc,ProjectName),ProjectID,ProjectName,a.VendorID,b.VenderName as VendorName,
		ProjStartDate,ProjEndDate,ProjStatus,ProjValue,ProjDescription,WODate,WONo,WOPath,PCCPath from utblMstProjects a
		inner join utblMstVendorDetails b on a.VendorID=b.VenderID
		where (ProjectName like '%' +@ProjName+'%' or @ProjName is null)
	)b where b.RowID >@Start

	select @TotalCount = count (*) from utblMstProjects
	where (ProjectName like '%' +@ProjName+'%' or @ProjName is null)
END




GO

IF OBJECT_ID('[udspGetProjectListByNewFilter]', 'P') IS NOT NULL DROP PROCEDURE [udspGetProjectListByNewFilter];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2021-03-18
-- Description:	Project master List
-- =============================================
Create PROCEDURE [dbo].[udspGetProjectListByNewFilter]
	-- Add the parameters for the stored procedure here
	@ClientID bigint,
	@ProjID bigint,
	@Status varchar(50),
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
		select top(@PageSize) * from 
		(
			select RowID = ROW_NUMBER() over(order by ProjStartDate Desc,ProjectName),ProjectID,ProjectName,a.VendorID,b.VenderName as VendorName,
			ProjStartDate,ProjEndDate,ProjStatus,ProjValue,ProjDescription,WODate,WONo,WOPath,PCCPath from utblMstProjects a
			inner join utblMstVendorDetails b on a.VendorID=b.VenderID
			where (a.VendorID=@ClientID or @ClientID Is Null) and (a.ProjectID=@ProjID or @ProjID Is Null) and (ProjStatus=@Status or @Status is null)
		)b where b.RowID >@Start

	select @TotalCount = count (*) from utblMstProjects a
	where (a.VendorID=@ClientID or @ClientID Is Null) and (a.ProjectID=@ProjID or @ProjID Is Null) and (ProjStatus=@Status or @Status is null)
END




GO

IF OBJECT_ID('[udspGetProjPaymentReceivedPages]', 'P') IS NOT NULL DROP PROCEDURE [udspGetProjPaymentReceivedPages];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-08-22
-- Description:	Get Project Payment Receive Details list in pages 
-- =============================================
CREATE PROCEDURE [dbo].[udspGetProjPaymentReceivedPages]
	-- Add the parameters for the stored procedure here
	@Project bigint,
	@YearNo int,
	@MonNo int,
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY a.ReceivedDate Desc),ProjPaymentReceiveID,a.ProjectID,ProjectName,a.BankID,BankName,
				ReceivedDate,ReceivedMode,a.Remarks,NetAmtReceived,TDSDeductionAmt,GstDeductionAmt,SecurityDepositAmt,OtherDeductionAmt,
				 (Isnull(NetAmtReceived,0)+Isnull(TDSDeductionAmt,0)+Isnull(GstDeductionAmt,0)+Isnull(SecurityDepositAmt,0)+Isnull(OtherDeductionAmt,0)) as TotalAmt,
				 IsAdvance,UploadedFile,a.SaleInvoiceID,ReferenceNo as InvRefNo	from utblProjPaymentReceivables a
				Left Outer Join utblMstBanks b on a.BankID=b.BankID
				Inner Join utblMstProjects p on a.ProjectID=p.ProjectID
				left Join utblSaleInvoiceKeys inv on a.SaleInvoiceID=inv.SaleInvoiceID
				where (Year(ReceivedDate)=@YearNo or @YearNo Is Null) and (Month(ReceivedDate)=@MonNo or @MonNo Is Null)
				and (a.ProjectID=@Project or @Project is Null)
			) 
			A WHERE A.RowID > (@Start) 
			select	@TotalCount = COUNT(*) from utblProjPaymentReceivables a
			where (Year(ReceivedDate)=@YearNo or @YearNo Is Null) and (Month(ReceivedDate)=@MonNo or @MonNo Is Null)
				and (a.ProjectID=@Project or @Project is Null)
END

GO

IF OBJECT_ID('[udspGetPurchaseInvItemList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetPurchaseInvItemList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-08-22
-- Description:	Purchase Invoice Item Details List
-- =============================================
CREATE PROCEDURE [dbo].[udspGetPurchaseInvItemList]
	-- Add the parameters for the stored procedure here
	@PurchaseInvID varchar(8)
	
AS
BEGIN
	select convert(varchar(128),ItemDtlID),PurchaseInvoiceID as SaleInvoiceID,ItemName,a.ItemHSNCode,a.GSTPercentage,IGSTPercentage,CGSTPercentage,SGSTPercentage,Qty,Rate,Amount,ItemName as ItemName 
	from utblPurchaseInvoiceItems a
	
	where PurchaseInvoiceID=@PurchaseInvID Order By SlNo
END





GO

IF OBJECT_ID('[udspGetPurchaseInvoiceList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetPurchaseInvoiceList];
GO

-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-08-22
-- Description:	Purchase Invoice Details List
-- =============================================
CREATE PROCEDURE [dbo].[udspGetPurchaseInvoiceList]
	-- Add the parameters for the stored procedure here
	@YearNo int,
	@MonNo int,
	@Vendor bigint,
	@SearchTerm varchar(50)=null,
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY PurchaseDate Desc,PORefNo), PurchaseInvoiceID,BillNo,
				PORefNo,cast(PurchaseDate as date) as PurchaseDate,IncludingTaxAmt,AmountPaid,BalanceAmount,
				b.VenderName as VendorName,UploadBill as UploadBill,Remarks,IsPOCancelled,HasMarkForPayment
				from utblPurchaseInvoiceKeys a
				inner join utblMstVendorDetails b on a.VenderID=b.VenderID
				where  (Year(PurchaseDate)=@YearNo or @YearNo Is Null) and (Month(PurchaseDate)=@MonNo or @MonNo Is Null)
				and (a.VenderID=@Vendor or @Vendor Is Null)
				and (BillNo like '%' + @SearchTerm + '%' or VenderName like '%' + @SearchTerm + '%' or @SearchTerm is null)
			) 
			A WHERE A.RowID > (@Start) 
			select	@TotalCount = COUNT(*) from utblPurchaseInvoiceKeys a
			inner join utblMstVendorDetails b on a.VenderID=b.VenderID
			where  (Year(PurchaseDate)=@YearNo or @YearNo Is Null) and (Month(PurchaseDate)=@MonNo or @MonNo Is Null)
			and (a.VenderID=@Vendor or @Vendor Is Null)
			and (BillNo like '%' + @SearchTerm + '%' or VenderName like '%' + @SearchTerm + '%' or @SearchTerm is null)
END


GO

IF OBJECT_ID('[udspGetPurchaseSaleDetailsByID]', 'P') IS NOT NULL DROP PROCEDURE [udspGetPurchaseSaleDetailsByID];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-31
-- Description:	Purchase and Sale Details By ID
-- =============================================
CREATE PROCEDURE [dbo].[udspGetPurchaseSaleDetailsByID]
	-- Add the parameters for the stored procedure here
	@ID bigint
	
AS
BEGIN
	
	Select PurchaseSaleID,PurchaseSaleDate,PurchaseSaleInvoiceNo,PurchaseSaleType,isnull(VenderID,'') as VenderID ,isnull(ClientID,'') as ClientID, 
	HSNSAC,IsIGST,cast(IGST as decimal(10,2))as IGST,cast(SGST as decimal(10,2)) as SGST,cast(CGST as decimal(10,2)) as CGST,
	cast(TaxableAmount as decimal(10,2)) as TaxableAmount,Description,UserID,LastModifiedOn from utblPurchaseSales a where PurchaseSaleID=@ID
			
END





GO

IF OBJECT_ID('[udspGetPurchaseSaleList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetPurchaseSaleList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-31
-- Description:	Purchase and Sale List
-- =============================================
CREATE PROCEDURE [dbo].[udspGetPurchaseSaleList]
	-- Add the parameters for the stored procedure here
	@SearchTerm varchar(50)=null,
	@Type varchar(20),
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
	if(@Type='Purchase')
	Begin
	SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY PurchaseSaleDate Desc), PurchaseSaleID,PurchaseSaleDate,PurchaseSaleInvoiceNo,PurchaseSaleType,
				isnull(VenderName,'') as VenderName ,isnull(ClientName,'') as ClientName, HSNSAC,case When IsIGST=1 then 'Yes' Else 'No' End as IsIGST,c.GSTNo as ClientGSTNO,b.GSTNo as VendorGSTNO,
				cast(IGST as decimal(10,2))as IGST,cast(SGST as decimal(10,2)) as SGST,cast(CGST as decimal(10,2)) as CGST,cast(TaxableAmount as decimal(10,2)) as TaxableAmount,Description from utblPurchaseSales a
				Left join utblMstVendorDetails b on b.VenderID=a.VenderID
				Left join utblMstClients c on c.ClientID=a.ClientID
				where PurchaseSaleType=@Type and  (VenderName like '%' +@SearchTerm+'%' or @SearchTerm is null)
			) 
			A WHERE A.RowID > (@Start)
			select	@TotalCount = COUNT(PurchaseSaleID) from utblPurchaseSales a
			Left join utblMstVendorDetails b on b.VenderID=a.VenderID
			Left join utblMstClients c on c.ClientID=a.ClientID
			where PurchaseSaleType=@Type and (VenderName like '%' +@SearchTerm+'%' or @SearchTerm is null)
	End
	Else
	Begin
	SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY PurchaseSaleDate Desc), PurchaseSaleID,PurchaseSaleDate,PurchaseSaleInvoiceNo,PurchaseSaleType,
				isnull(VenderName,'') as VenderName ,isnull(ClientName,'') as ClientName, HSNSAC,case When IsIGST=1 then 'Yes' Else 'No' End as IsIGST,c.GSTNo as ClientGSTNO,b.GSTNo as VendorGSTNO,
				cast(IGST as decimal(10,2))as IGST,cast(SGST as decimal(10,2)) as SGST,cast(CGST as decimal(10,2)) as CGST,cast(TaxableAmount as decimal(10,2)) as TaxableAmount,Description from utblPurchaseSales a
				Left join utblMstVendorDetails b on b.VenderID=a.VenderID
				Left join utblMstClients c on c.ClientID=a.ClientID
				where PurchaseSaleType=@Type and (ClientName like '%' +@SearchTerm+'%' or @SearchTerm is null) 
			) 
			A WHERE A.RowID > (@Start)
			select	@TotalCount = COUNT(PurchaseSaleID) from utblPurchaseSales a
			Left join utblMstVendorDetails b on b.VenderID=a.VenderID
			Left join utblMstClients c on c.ClientID=a.ClientID
			where PurchaseSaleType=@Type and (ClientName like '%' +@SearchTerm+'%' or @SearchTerm is null)
	End
	
END





GO

IF OBJECT_ID('[udspGetPurchaseSaleReport]', 'P') IS NOT NULL DROP PROCEDURE [udspGetPurchaseSaleReport];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-31
-- Description:	Purchase and Sale List For Report By Month
-- =============================================
CREATE PROCEDURE [dbo].[udspGetPurchaseSaleReport]
	-- Add the parameters for the stored procedure here
		@Month int,
		@Year int
AS
BEGIN
	
		Select PurchaseSaleID,PurchaseSaleDate,PurchaseSaleInvoiceNo,PurchaseSaleType,isnull(VenderName,'') as VenderName ,isnull(ClientName,'') as ClientName, 
		HSNSAC,case When IsIGST=1 then 'Yes' Else 'No' End as IsIGST,cast(IGST as decimal(10,2))as IGST,cast(SGST as decimal(10,2)) as SGST,c.GSTNo as ClientGSTNO,b.GSTNo as VendorGSTNO,
		cast(CGST as decimal(10,2)) as CGST,cast(TaxableAmount as decimal(10,2)) as TaxableAmount,Description from utblPurchaseSales a
		Left join utblMstVendorDetails b on b.VenderID=a.VenderID
		Left join utblMstClients c on c.ClientID=a.ClientID
		where month(PurchaseSaleDate)=@Month and Year(PurchaseSaleDate)=@Year ORDER BY PurchaseSaleDate

		select * from utblMstVendorDetails
			
END





GO

IF OBJECT_ID('[udspGetPurchaseYearDDList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetPurchaseYearDDList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-03-10
-- Description:	Get Purchase Invoice Year DD List
-- =============================================
CREATE PROCEDURE [dbo].[udspGetPurchaseYearDDList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	
	Select Distinct year(PurchaseDate) as YearNo from utblPurchaseInvoiceKeys Order By YearNo Desc

END





GO

IF OBJECT_ID('[udspGetReceiveDirectPaymentPages]', 'P') IS NOT NULL DROP PROCEDURE [udspGetReceiveDirectPaymentPages];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-05-09
-- Description:	Receive Direct Payment Details List
-- =============================================
CREATE PROCEDURE [dbo].[udspGetReceiveDirectPaymentPages]
	-- Add the parameters for the stored procedure here
	@ExpType bigint,
	@YearNo int,
	@MonNo int,
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY ReceivedDate Desc),ReceivedID,a.ExpenseTypeID,
				ExpenseType,AmtReceived,ReceivedDate,ReceivedMode,a.BankID,BankName,TransactionNo,Remarks,
				UploadedFile,AddedBy,AddedOn from utblPaymentReceivables a
				inner join utblMstExpenseTypes b on a.ExpenseTypeID=b.ExpenseTypeID
				Left join utblMstBanks c on a.BankID=c.BankID
				where  (Year(ReceivedDate)=@YearNo or @YearNo Is Null) and (Month(ReceivedDate)=@MonNo or @MonNo Is Null)
				and (a.ExpenseTypeID=@ExpType or @ExpType Is Null)
				
			) 
			A WHERE A.RowID > (@Start) 
			select	@TotalCount = COUNT(*) from utblPaymentReceivables a
			where  (Year(ReceivedDate)=@YearNo or @YearNo Is Null) and (Month(ReceivedDate)=@MonNo or @MonNo Is Null)
			and (a.ExpenseTypeID=@ExpType or @ExpType Is Null)
END



GO

IF OBJECT_ID('[udspgetRefDashboardDetails]', 'P') IS NOT NULL DROP PROCEDURE [udspgetRefDashboardDetails];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2021-03-18
-- Description:	Project master List for dashboard
-- =============================================
CREATE PROCEDURE [dbo].[udspgetRefDashboardDetails]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	Declare @Temptable as table
	(
		RefNo varchar(50),RefType varchar(50),RefDate Date
	)
	Insert Into @Temptable
	select top(5) RefNumber as RefNo,RefType as RefType,RefDate as RefDate from utblReferenceDetails a Order By RefDate Desc,RefNumber Desc

	Insert Into @Temptable
	select top(5) ReferenceNo as RefNo,'Invoice' as RefType,InvoiceDate as RefDate from utblSaleInvoiceKeys a Order By InvoiceDate Desc,ReferenceNo Desc

	select top(5) RefNo as RefNumber,RefType as RefType,RefDate as RefDate from @Temptable a
	Order By RefDate Desc,RefNo Desc
	
END




GO

IF OBJECT_ID('[udspGetReferenceNoList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetReferenceNoList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-28
-- Description:	Reference Number List
-- =============================================
CREATE PROCEDURE [dbo].[udspGetReferenceNoList]
	-- Add the parameters for the stored procedure here
	@FYear varchar(10),
	@RefType varchar(50),
	@LetterTO varchar(100),
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
	if(@RefType = '' or @RefType is null)
	BEGIN
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY RefDate DESC,RefNumber Desc),ReferenceID,ISnull(RefDate,'') as RefDate ,RefType,DescORSubject,FiscalYear,RefNumber,
				LetterTO,b.VenderName as ClientName,Case When IsCancelled =1 then 'Yes' Else 'No'End as IsCancelled from utblReferenceDetails a
				inner join utblMstVendorDetails b on b.VenderID=a.VendorID where FiscalYear=@FYear
			) 
			A WHERE A.RowID > (@Start)
			select	@TotalCount = COUNT(ReferenceID) from utblReferenceDetails where FiscalYear=@FYear
	END
	else
	BEGIN
		SELECT TOP(@PageSize) * FROM 
			(
				Select RowID = ROW_NUMBER() OVER (ORDER BY RefDate DESC,RefNumber Desc),ReferenceID,ISnull(RefDate,'') as RefDate ,RefType,DescORSubject,FiscalYear,RefNumber,
				LetterTO,b.VenderName as ClientName,Case When IsCancelled =1 then 'Yes' Else 'No'End as IsCancelled from utblReferenceDetails a
				inner join utblMstVendorDetails b on b.VenderID=a.VendorID
				where FiscalYear=@FYear and RefType=@RefType and LetterTO like '%' + LetterTO + '%'
			) 
			A WHERE A.RowID > (@Start) 
			select	@TotalCount = COUNT(ReferenceID) from utblReferenceDetails
			where FiscalYear=@FYear and RefType=@RefType and LetterTO like '%' + LetterTO + '%'
	END
END





GO

IF OBJECT_ID('[udspGetSaleInvItemList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetSaleInvItemList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-08-08
-- Description:	Invoice Item Details List
-- =============================================
CREATE PROCEDURE [dbo].[udspGetSaleInvItemList]
	-- Add the parameters for the stored procedure here
	@SaleInvID varchar(8)
	
AS
BEGIN
	select convert(varchar(128),ItemDtlID),SaleInvoiceID,ItemName,a.ItemHSNCode,a.GSTPercentage,IGSTPercentage,CGSTPercentage,SGSTPercentage,Qty,Rate,Amount
	from utblSaleInvoiceItems a
	where SaleInvoiceID=@SaleInvID order By SequenceNo
END





GO

IF OBJECT_ID('[udspGetSaleInvoiceDetails]', 'P') IS NOT NULL DROP PROCEDURE [udspGetSaleInvoiceDetails];
GO


-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-08-08
-- Description:	Get Invoice Details By ID
-- =============================================
Create PROCEDURE [dbo].[udspGetSaleInvoiceDetails]
	-- Add the parameters for the stored procedure here
	@ID varchar(15)
AS
BEGIN
		
				Select SaleInvoiceID,OrderNo,convert(varchar, OrderDate, 106) as OrderDate ,
				InvoiceTo,InvoiceDate,ReferenceNo,a.VenderID,VenderName,a.ProjectID,ProjectName,IGSTAmount,CGSTAmount,
				SGSTAmount,ExcludingTaxAmt,IncludingTaxAmt,AdvanceReceived,ReceivedRemarks,BalanceAmount,Remarks,IsCancelled 
				from utblSaleInvoiceKeys a
				inner join utblMstVendorDetails b on a.VenderID=b.VenderID
				inner join utblMstProjects p on p.ProjectID=a.ProjectID
				where SaleInvoiceID=@ID
END

GO

IF OBJECT_ID('[udspGetSaleInvoiceList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetSaleInvoiceList];
GO

-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-08-08
-- Description:	Invoice Details List
-- =============================================
CREATE PROCEDURE [dbo].[udspGetSaleInvoiceList]
	-- Add the parameters for the stored procedure here
	@YearNo int,
	@MonNo int,
	@Client bigint,
	@SearchTerm varchar(50)=null,
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
		SELECT TOP(@PageSize) * FROM 
			(
			--select * from utblSaleInvoiceKeys
				Select RowID = ROW_NUMBER() OVER (ORDER BY InvoiceDate Desc, ReferenceNo Desc),SaleInvoiceID,OrderNo,convert(varchar, OrderDate, 106) as OrderDate ,
				InvoiceTo,InvoiceDate,ReferenceNo,a.VenderID,VenderName,a.ProjectID,ProjectName,IGSTAmount,CGSTAmount,
				SGSTAmount,ExcludingTaxAmt,IncludingTaxAmt,AdvanceReceived,ReceivedRemarks,BalanceAmount,Remarks,IsCancelled 
				from utblSaleInvoiceKeys a
				inner join utblMstVendorDetails b on a.VenderID=b.VenderID
				inner join utblMstProjects p on p.ProjectID=a.ProjectID
				where (Year(InvoiceDate)=@YearNo or @YearNo Is Null) and (Month(InvoiceDate)=@MonNo or @MonNo Is Null)
				and (a.VenderID=@Client or @Client Is Null) and
				 (ReferenceNo like '%' + @SearchTerm + '%' or VenderName like '%' + @SearchTerm + '%' or ProjectName like '%' + @SearchTerm + '%' or @SearchTerm is null)
			) 
			A WHERE A.RowID > (@Start) 
			select	@TotalCount = COUNT(*) from utblSaleInvoiceKeys a
			inner join utblMstVendorDetails b on a.VenderID=b.VenderID
			inner join utblMstProjects p on p.ProjectID=a.ProjectID
			where  (Year(InvoiceDate)=@YearNo or @YearNo Is Null) and (Month(InvoiceDate)=@MonNo or @MonNo Is Null)and (a.VenderID=@Client or @Client Is Null) and
			(ReferenceNo like '%' + @SearchTerm + '%' or VenderName like '%' + @SearchTerm + '%' or ProjectName like '%' + @SearchTerm + '%' or @SearchTerm is null)
END

GO

IF OBJECT_ID('[udspGetSaleYearDDList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetSaleYearDDList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-03-10
-- Description:	Get SALE Invoice Year DD List
-- =============================================
Create PROCEDURE [dbo].[udspGetSaleYearDDList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	
	Select Distinct year(InvoiceDate) as YearNo from utblSaleInvoiceKeys Order By YearNo Desc

END





GO

IF OBJECT_ID('[udspGetTaxInvoiceListByProjID]', 'P') IS NOT NULL DROP PROCEDURE [udspGetTaxInvoiceListByProjID];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-08-08
-- Description:	Get Tax Invoice List By Project ID
-- =============================================
CREATE PROCEDURE [dbo].[udspGetTaxInvoiceListByProjID]
	-- Add the parameters for the stored procedure here
	@ProjID bigint
AS
BEGIN
		
		Select SaleInvoiceID,InvoiceDate,ReferenceNo,IGSTAmount,CGSTAmount,
		SGSTAmount,ExcludingTaxAmt as NetAmount,IncludingTaxAmt as TotalAmount,IsCancelled 
		from utblSaleInvoiceKeys a
		where ProjectID=@ProjID and IsCancelled=0 order By InvoiceDate Desc,ReferenceNo Desc
			
END

GO

IF OBJECT_ID('[udspgetUnitList]', 'P') IS NOT NULL DROP PROCEDURE [udspgetUnitList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-01-23
-- Description:	Unit Master List
-- =============================================
Create PROCEDURE [dbo].[udspgetUnitList]
	-- Add the parameters for the stored procedure here
	@UnitName varchar(50),
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
	select top(@PageSize) * from 
	(
		select RowID = ROW_NUMBER() over(order by UnitName),UnitID,UnitName,UnitDescription	
		from utblMstUnits a
		where (UnitName like '%' +@UnitName+'%' or @UnitName is null)
	)b where b.RowID >@Start

	select @TotalCount = count (*) from utblMstUnits
	where (UnitName like '%' +@UnitName+'%' or @UnitName is null)
END




GO

IF OBJECT_ID('[udspGetUnMapingEmpList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetUnMapingEmpList];
GO
CREATE PROCEDURE [dbo].[udspGetUnMapingEmpList]
	
AS
BEGIN
	select a.EmployeeID, RTRIM(LTRIM(RTRIM(isnull(FName,'') + ' ' + isnull(MName,''))+ ' ' + isnull(LName,''))) as EmployeeName from utblEmpPersonalInfoKeys a
	left outer join utblEmpAttendanceMappings b	on (a.EmployeeID = b.EmployeeID)
	left outer join AspNetUsers c on a.employeeID=c.EmployeeID
	where b.EmployeeID is null and c.IsActive=1 and a.EmployeeID<>'E20A0000'
	order by a.EmployeeID
END



GO

IF OBJECT_ID('[udspGetVendorDDList]', 'P') IS NOT NULL DROP PROCEDURE [udspGetVendorDDList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-29
-- Description:	Vendor DD List
-- =============================================
Create PROCEDURE [dbo].[udspGetVendorDDList]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	Select VenderID,VenderName from utblMstVendorDetails
END




GO

IF OBJECT_ID('[udspGetVendorLedger]', 'P') IS NOT NULL DROP PROCEDURE [udspGetVendorLedger];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 7 April 2021
-- Description:	Get Vendor Ledger
-- =============================================
CREATE PROCEDURE [dbo].[udspGetVendorLedger]
	@VendorID bigint,
	@StartDate datetime,
	@EndDate datetime
AS
BEGIN
	declare @TransTable table
	(
		TransType varchar(50),
		TransDate datetime,
		Debit money,
		Credit money,
		Remarks nvarchar(max),
		TransID varchar(20)
	)

	-- Credit for procurement
	insert into @TransTable
	select 'Procurement', PurchaseDate, 0, IncludingTaxAmt, Remarks, PurchaseInvoiceID 
	from utblPurchaseInvoiceKeys a
	where a.VenderID=@VendorID and IsPOCancelled=0

	-- Debit for procurement
	insert into @TransTable
	select 'Procurement', PaymentDate, PaymentAmt, 0, a.Remarks, a.PurchaseInvoiceID from utblPaymentReleasedTrans   a 
	inner join utblPurchaseInvoiceKeys b on a.PurchaseInvoiceID=b.PurchaseInvoiceID
	where b.VenderID=@VendorID and IsPOCancelled=0

	select RowID, TransType, TransID, TransDate, Debit, Credit, Remarks, sum(Balance) over (order by RowID) as Balance from
	(
		select RowID=ROW_NUMBER() over (order by TransDate), TransDate, Debit, Credit, Remarks, TransType, TransID,
		Credit-Debit as Balance from @TransTable
	)a
	where (TransDate>=@StartDate or @StartDate is null)
	and (TransDate<=@EndDate or @EndDate is null)
	order by RowID desc
END


GO

IF OBJECT_ID('[udspgetVendorList]', 'P') IS NOT NULL DROP PROCEDURE [udspgetVendorList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-28
-- Description:	Vender master List
-- =============================================
CREATE PROCEDURE [dbo].[udspgetVendorList]
	-- Add the parameters for the stored procedure here
	@VenderName varchar(100)=null,
	@Start int,
	@PageSize int,
	@TotalCount INT OUTPUT
AS
BEGIN
		select top(@PageSize) * from 
	(
		select RowID = ROW_NUMBER() over(order by VenderName),VenderID,VenderName,VenderAddress,GSTNo,ContactName,ContactNo,Email,UserID,LastModifiedOn	from utblMstVendorDetails a
		where (VenderName like '%' +@VenderName+'%' or @VenderName is null)
	)b where b.RowID >@Start

	select @TotalCount = count (*) from utblMstVendorDetails
	where (VenderName like '%' +@VenderName+'%' or @VenderName is null)
END




GO

IF OBJECT_ID('[udspMarkForPaymentPO]', 'P') IS NOT NULL DROP PROCEDURE [udspMarkForPaymentPO];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-05-14
-- Description:	Mark For PaymentPO PO.
-- =============================================
Create PROCEDURE [dbo].[udspMarkForPaymentPO] 
	-- Add the parameters for the stored procedure here
	@ID varchar(8)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		Declare @HasMarkPayment bit 
		select @HasMarkPayment= HasMarkForPayment from utblPurchaseInvoiceKeys  where PurchaseInvoiceID=@ID
		
		If(@HasMarkPayment=0)
		Begin
			Update utblPurchaseInvoiceKeys set HasMarkForPayment=1 where PurchaseInvoiceID=@ID
			set @error_number = 0
			set @ErMessage = 'Success: Mark For Payment has Succesfully.'
		End
		Else
		Begin
			Update utblPurchaseInvoiceKeys set HasMarkForPayment=0 where PurchaseInvoiceID=@ID
			set @error_number = 0
			set @ErMessage = 'Success: Undo Mark For Payment has Succesfully.'
		End

	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error:'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstClientDelete]', 'P') IS NOT NULL DROP PROCEDURE [udspMstClientDelete];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-29
-- Description:	Delete Client
-- =============================================
Create PROCEDURE [dbo].[udspMstClientDelete] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		delete from utblMstClients
		where ClientID = @ID
		set @error_number = 0
		set @ErMessage = 'Success: Record Deleted Succesfully.'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error: This record could not be deleted as reference for this record exist.'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstClientInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspMstClientInsert];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-28
-- Description:	Add Client
-- =============================================
CREATE PROCEDURE [dbo].[udspMstClientInsert] 
	-- Add the parameters for the stored procedure here
	@ClientName varchar(100),
	@ClientAddress varchar(max),
	@GSTNo varchar(30),
	@ContactNo varchar(15),
	@UserName varchar(50)
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		INSERT INTO utblMstClients(ClientName,ClientAddress,GSTNo,ContactNo,UserID,LastModifiedOn)
			VALUES(@ClientName,@ClientAddress,@GSTNo,@ContactNo,@UserName,GETDATE())
           set @error_number = 0
           set @ErMessage = 'Success: Data Added Succesfully !'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check Units list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstClientUpdate]', 'P') IS NOT NULL DROP PROCEDURE [udspMstClientUpdate];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-28
-- Description:	Update Client
-- =============================================
CREATE PROCEDURE [dbo].[udspMstClientUpdate] 
	-- Add the parameters for the stored procedure here
	@ClientID bigint,
	@ClientName varchar(100),
	@ClientAddress varchar(max),
	@GSTNo varchar(30),
	@ContactNo varchar(15),
	@UserName varchar(50)
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		Update utblMstClients set
		 ClientName=@ClientName,
		 ClientAddress=@ClientAddress,
		 GSTNo=@GSTNo,
		 ContactNo=@ContactNo,
		 UserID=@UserName,
		 LastModifiedOn=GETDATE()
		 where ClientID=@ClientID
           set @error_number = 0
           set @ErMessage = 'Success: Data Update Succesfully !'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check Units list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstEmpList]', 'P') IS NOT NULL DROP PROCEDURE [udspMstEmpList];
GO
-- =============================================
-- Author:		Siddharth Chettri
-- Create date: 21 jan 2020
-- Description:	Get User List
-- =============================================
CREATE PROCEDURE [dbo].[udspMstEmpList]
	-- Add the parameters for the stored procedure here
	@Start int,
	@PageSize int,
	@SearchTerm varchar(100)=null,
	@TotalRecords INT OUTPUT
AS
BEGIN
		select top(@PageSize) * from 
	(
		select RowID = ROW_NUMBER() over(order by a.EmployeeID desc),a.EmployeeID,RTRIM(LTRIM(RTRIM(isnull(FName,'') + ' ' + isnull(MName,''))+ ' ' + isnull(LName,''))) as EmpName,Gender,a.Email,a.PhoneNumber,b.IsActive,role as RoleName,b.Id as UserID,PhotoThumb
		from utblEmpPersonalInfoKeys a inner join AspNetUsers b on a.EmployeeID =b.EmployeeID
		where (FName like '%' +@SearchTerm+'%' or @SearchTerm is null) and a.EmployeeID<>'E20A0000'
	)b where b.RowID >@Start

	select @TotalRecords = count (*) from utblEmpPersonalInfoKeys a
	 where(FName like '%'+@SearchTerm+'%' or @SearchTerm is null) and a.EmployeeID<>'E20A0000'
END




GO

IF OBJECT_ID('[udspMstExpenseTypeDelete]', 'P') IS NOT NULL DROP PROCEDURE [udspMstExpenseTypeDelete];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-01-20
-- Description:	Delete ExpenseType
-- =============================================
Create PROCEDURE [dbo].[udspMstExpenseTypeDelete] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		delete from utblMstExpenseTypes
		where ExpenseTypeID = @ID
		set @error_number = 0
		set @ErMessage = 'Success: Record Deleted Succesfully.'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error: This record could not be deleted as reference for this record exist.'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstExpenseTypeInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspMstExpenseTypeInsert];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-01-20
-- Description:	Add ExpenseType
-- =============================================
CREATE PROCEDURE [dbo].[udspMstExpenseTypeInsert] 
	-- Add the parameters for the stored procedure here
	@ExpenseType nvarchar(max),
	@Description nvarchar(max),
	@IsProjectRelated bit,
	@CanReceiveDirectPayment bit,
	@OpeningAmount money,
	@OpeningDate date,
	@UserName varchar(100)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		INSERT INTO utblMstExpenseTypes(ExpenseType,Description,IsProjectRelated,CanReceiveDirectPayment,OpeningAmount,OpeningDate,UserID,LastModifiedOn)
		VALUES(@ExpenseType,@Description,@IsProjectRelated,@CanReceiveDirectPayment,@OpeningAmount,@OpeningDate,@UserName,GETDATE())
           set @error_number = 0
           set @ErMessage = 'Success: Data Added Succesfully !'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstExpenseTypeUpdate]', 'P') IS NOT NULL DROP PROCEDURE [udspMstExpenseTypeUpdate];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-01-20
-- Description:	Update ExpenseType
-- =============================================
CREATE PROCEDURE [dbo].[udspMstExpenseTypeUpdate] 
	-- Add the parameters for the stored procedure here
	@ExpenseTypeID bigint,
	@ExpenseType nvarchar(max),
	@Description nvarchar(max),
	@IsProjectRelated bit,
	@CanReceiveDirectPayment bit,
	@OpeningAmount money,
	@OpeningDate date,
	@UserName varchar(100)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		update utblMstExpenseTypes
           set ExpenseType=@ExpenseType,
		   Description=@Description,
		   IsProjectRelated=@IsProjectRelated,
		   CanReceiveDirectPayment=@CanReceiveDirectPayment,
		   OpeningAmount=@OpeningAmount,
		   OpeningDate=@OpeningDate,
		   UserID=@UserName,
		   LastModifiedOn=Getdate()
		where ExpenseTypeID =@ExpenseTypeID 
		set @error_number = 0
		set @ErMessage = 'Success: Record updated succesfully.'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627     
				set @ErMessage = 'Error: Duplicate record found'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage
END




GO

IF OBJECT_ID('[udspMstFinancialYearInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspMstFinancialYearInsert];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-07-03
-- Description:	Add Financial Year
-- =============================================
CREATE PROCEDURE [dbo].[udspMstFinancialYearInsert] 
	-- Add the parameters for the stored procedure here
	@StartDate date,
	@Enddate date,
	@Symbol varchar(7),
	@Active bit
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		BEGIN TRANSACTION
			Update UtblMstFinancialYears set Active=0
			
			INSERT INTO UtblMstFinancialYears (StartDate,EndDate,FiscalYearSymbol,Active)
				VALUES(cast(@StartDate as date),cast(@Enddate as date),@Symbol,1)
           
		   set @error_number = 0
           set @ErMessage = 'Success: Data Added Succesfully !'
	COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstFinancialYearUpdate]', 'P') IS NOT NULL DROP PROCEDURE [udspMstFinancialYearUpdate];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-07-3
-- Description:	Update Financial Year
-- =============================================
CREATE PROCEDURE [dbo].[udspMstFinancialYearUpdate] 
	-- Add the parameters for the stored procedure here
	@ID int,
	@StartDate date,
	@Enddate date,
	@Symbol varchar(7),
	@Active bit
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY 
	BEGIN TRANSACTION
		Update UtblMstFinancialYears set Active=0

		Update UtblMstFinancialYears Set 
		StartDate=cast(@StartDate as date),
		EndDate=cast(@Enddate as date),
		FiscalYearSymbol=@Symbol,
		Active=1  where FiscalID=@ID
           set @error_number = 0
           set @ErMessage = 'Success: Data Update Succesfully !'
	COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstHolidayDelete]', 'P') IS NOT NULL DROP PROCEDURE [udspMstHolidayDelete];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-01-20
-- Description:	Delete Holiday
-- =============================================
CREATE PROCEDURE [dbo].[udspMstHolidayDelete] 
	-- Add the parameters for the stored procedure here
	@ID varchar(10)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		delete from utblMstHolidays
		where HolidayID = @ID
		set @error_number = 0
		set @ErMessage = 'Success: Record Deleted Succesfully.'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error: This record could not be deleted as reference for this record exist.'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END





GO

IF OBJECT_ID('[udspMstHolidayInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspMstHolidayInsert];
GO
-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2020-01-21>
-- Description:	<Insert Holiday>
-- =============================================
CREATE PROCEDURE [dbo].[udspMstHolidayInsert]
	@HolidayName varchar(50),
	@HolidayDesc varchar(256),
	@DateFrom datetime,
	@DateTo datetime,
	@NoofDays int,
	@UserName varchar(50)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		BEGIN TRANSACTION
		if exists(select * from utblMstHolidays where HolidayName=@HolidayName and cast(DateFrom as date) = cast(@DateFrom as date))
			BEGIN
				set @error_number = 2601
				set @ErMessage = 'Holiday dates have already been added. Try again with other dates. !'
			END
		Else
		BEGIN
			declare @charRange varchar(1), @slno int,@HolidayID varchar(10),@Yr int,@CodeSeedsYear int
			select @CodeSeedsYear=Year from utblMstGenCodeSeeds where TableName='utblMstHolidays'
		--------Getting unique Attendance ID from sql function-------
			select @HolidayID = MsgRcpID, @charRange = CharRange, @slno = SINo,@Yr=Year from dbo.udfGenerateHolidayCode('utblMstHolidays')
			INSERT INTO utblMstHolidays
           (HolidayID,HolidayName,HolidayDesc,DateFrom,DateTo,NoofDays,UserID,LastModifiedOn)VALUES
           (@HolidayID,@HolidayName,@HolidayDesc,@DateFrom,@DateTo,@NoofDays,@UserName ,GETDATE())
---------Update Code Sheeds----------------------------
			if(@slno-1=99999 and @charRange='Z')
			begin
				update utblMstGenCodeSeeds set CharRange='A', StartRange=1 where TableName='utblMstHolidays'
			end
			else if(@slno-1=99999)
			begin
				update utblMstGenCodeSeeds set CharRange=CHAR(ASCII(@charRange)+1), StartRange=1 where TableName='utblMstHolidays'
			end
			else if(@CodeSeedsYear<>@Yr)
			begin
				update utblMstGenCodeSeeds set CharRange='A', StartRange=@slno,Year=@Yr where TableName='utblMstHolidays'
			end
			else
			begin
				update utblMstGenCodeSeeds set StartRange=@slno where TableName='utblMstHolidays'
			end
---------End Updated Code Sheeds----------------------------
			set @error_number = 0
			set @ErMessage = 'Success: Record Added Succesfully !'
		END
		COMMIT TRANSACTION
	END TRY
		BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check Units list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END









GO

IF OBJECT_ID('[udspMstHolidayUpdate]', 'P') IS NOT NULL DROP PROCEDURE [udspMstHolidayUpdate];
GO
-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2020-01-21>
-- Description:	<Update Holiday>
-- =============================================
CREATE PROCEDURE [dbo].[udspMstHolidayUpdate]
	@HolidayID varchar(10),
	@HolidayName varchar(50),
	@HolidayDesc varchar(256),
	@DateFrom datetime,
	@DateTo datetime,
	@NoofDays int,
	@UserName varchar(50)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		BEGIN TRANSACTION
		if exists(select * from utblMstHolidays where HolidayName=@HolidayName and cast(DateFrom as date) = cast(@DateFrom as date) and HolidayID<>@HolidayID)
			BEGIN
				set @error_number = 2601
				set @ErMessage = 'Holiday dates have already been added. Try again with other dates. !'
			END
		Else
		BEGIN
			Update utblMstHolidays set
			   HolidayID=@HolidayID,
			   HolidayName=@HolidayName,
			   HolidayDesc=@HolidayDesc,
			   DateFrom=@DateFrom,
			   DateTo=@DateTo,
			   NoofDays=@NoofDays,
			   UserID=@UserName,
			   LastModifiedOn=GETDATE() where HolidayID=@HolidayID
			set @error_number = 0
			set @ErMessage = 'Success: Record Update Succesfully !'
		END
		COMMIT TRANSACTION
	END TRY
		BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check Units list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END









GO

IF OBJECT_ID('[udspMstItemDelete]', 'P') IS NOT NULL DROP PROCEDURE [udspMstItemDelete];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-07-3
-- Description:	Delete Item
-- =============================================
Create PROCEDURE [dbo].[udspMstItemDelete] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		delete from utblMstItems
		where ItemID = @ID
		set @error_number = 0
		set @ErMessage = 'Success: Record Deleted Succesfully.'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error: This record could not be deleted as reference for this record exist.'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstItemInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspMstItemInsert];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-07-03
-- Description:	Add Items
-- =============================================
Create PROCEDURE [dbo].[udspMstItemInsert] 
	-- Add the parameters for the stored procedure here
	@Name varchar(50),
	@Hsn varchar(50),
	@Gst int,
	@Desc varchar(max),
	@UserName varchar(50)
	
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		INSERT INTO utblMstItems (ItemName,ItemHSNCode,GSTPercentage,ItemDescription,UserID,LastModifiedOn)
			VALUES(@Name,@Hsn,@Gst,@Desc,@UserName,GETDATE())
           set @error_number = 0
           set @ErMessage = 'Success: Data Added Succesfully !'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check Item list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstItemUpdate]', 'P') IS NOT NULL DROP PROCEDURE [udspMstItemUpdate];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-07-3
-- Description:	Update Items
-- =============================================
Create PROCEDURE [dbo].[udspMstItemUpdate] 
	-- Add the parameters for the stored procedure here
	@ItemID bigint,
	@Name varchar(50),
	@Hsn varchar(50),
	@Gst int,
	@Desc varchar(max),
	@UserName varchar(50)
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		Update utblMstItems set
		 ItemName=@Name,
		 ItemHSNCode=@Hsn,
		 GSTPercentage=@Gst,
		 ItemDescription=@Desc,
		 UserID=@UserName,
		 LastModifiedOn=GETDATE()
		 where ItemID=@ItemID
           set @error_number = 0
           set @ErMessage = 'Success: Data Update Succesfully !'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check Items list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstMstReferenceNumberUpdate]', 'P') IS NOT NULL DROP PROCEDURE [udspMstMstReferenceNumberUpdate];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-07-3
-- Description:	Update Mst Reference No.
-- =============================================
CREATE PROCEDURE [dbo].[udspMstMstReferenceNumberUpdate] 
	-- Add the parameters for the stored procedure here
	@ID int,
	@Prefix varchar(3),
	@Suffix varchar(3),
	@Symbol varchar(7),
	@StartNo int,
	@CurrentNo int
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY 
	BEGIN TRANSACTION
		Update utblMstReferenceNumbers Set 
		Prefix=@Prefix,
		Suffix=@Suffix,
		FiscalYearSymbol=@Symbol,
		StartNo=@StartNo,
		CurrentNo=@CurrentNo  
		where RefID=@ID
        set @error_number = 0
        set @ErMessage = 'Success: Data Update Succesfully !'
	COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstProjectDDList]', 'P') IS NOT NULL DROP PROCEDURE [udspMstProjectDDList];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-29
-- Description:	Project DD List
-- =============================================
CREATE PROCEDURE [dbo].[udspMstProjectDDList]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	Select ProjectID,ProjectName from utblMstProjects Order By ProjectName
END




GO

IF OBJECT_ID('[udspMstProjectDelete]', 'P') IS NOT NULL DROP PROCEDURE [udspMstProjectDelete];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2021-03-18
-- Description:	Delete Project
-- =============================================
Create PROCEDURE [dbo].[udspMstProjectDelete] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		delete from utblMstProjects
		where ProjectID = @ID
		set @error_number = 0
		set @ErMessage = 'Success: Record Deleted Succesfully.'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error: This record could not be deleted as reference for this record exist.'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstProjectInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspMstProjectInsert];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2021-03-17
-- Description:	Add Project
-- =============================================
CREATE PROCEDURE [dbo].[udspMstProjectInsert] 
	-- Add the parameters for the stored procedure here
	@ProjectName nvarchar(max),
	@VendorID bigint,
	@ProjStartDate date,
	@ProjEndDate date,
	@ProjStatus nvarchar(50),
	@ProjValue money, 
	@ProjDescription nvarchar(max),
	@WODate date,
	@WONo nvarchar(200),
	@WOPath nvarchar(max), 
	@PCCPath nvarchar(max)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY 
		if(@ProjEndDate Is Null)
		Begin
		Set @ProjStatus='Open'
		End
		else
		Begin
		Set @ProjStatus='Closed'
		End
	 
		INSERT INTO utblMstProjects (ProjectName,VendorID,ProjStartDate,ProjEndDate,ProjStatus,ProjValue, ProjDescription,WODate,WONo,WOPath, PCCPath)
			VALUES(@ProjectName,@VendorID,@ProjStartDate,@ProjEndDate,@ProjStatus,@ProjValue, @ProjDescription,@WODate,@WONo,@WOPath, @PCCPath)
           set @error_number = 0
           set @ErMessage = 'Success: Data Added Succesfully !'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check Units list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstProjectUpdate]', 'P') IS NOT NULL DROP PROCEDURE [udspMstProjectUpdate];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2021-03-17
-- Description:	Update Project
-- =============================================
Create PROCEDURE [dbo].[udspMstProjectUpdate] 
	-- Add the parameters for the stored procedure here
	@ProjectID bigint,
	@ProjectName nvarchar(max),
	@VendorID bigint,
	@ProjStartDate date,
	@ProjEndDate date,
	@ProjStatus nvarchar(50),
	@ProjValue money, 
	@ProjDescription nvarchar(max),
	@WODate date,
	@WONo nvarchar(200),
	@WOPath nvarchar(max), 
	@PCCPath nvarchar(max)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY 
		if(@ProjEndDate Is Null)
		Begin
		Set @ProjStatus='Open'
		End
		else
		Begin
		Set @ProjStatus='Closed'
		End
		
		update utblMstProjects Set
		ProjectName=@ProjectName,
		VendorID=@VendorID,
		ProjStartDate=@ProjStartDate,
		ProjEndDate=@ProjEndDate,
		ProjStatus=@ProjStatus,
		ProjValue=@ProjValue, 
		ProjDescription=@ProjDescription,
		WODate=@WODate,
		WONo=@WONo,
		WOPath=@WOPath, 
		PCCPath=@PCCPath
		Where ProjectID=@ProjectID
        
		set @error_number = 0
        set @ErMessage = 'Success: Data Updated Succesfully !'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check Units list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstReferenceNumberInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspMstReferenceNumberInsert];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-07-03
-- Description:	Add Mst Reference No.
-- =============================================
CREATE PROCEDURE [dbo].[udspMstReferenceNumberInsert] 
	-- Add the parameters for the stored procedure here
	@Prefix varchar(3),
	@Suffix varchar(3),
	@Symbol varchar(7),
	@StartNo int,
	@CurrentNo int
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		INSERT INTO utblMstReferenceNumbers (Prefix,Suffix,FiscalYearSymbol,StartNo,CurrentNo)
			VALUES(@Prefix,@Suffix,@Symbol,@StartNo,@CurrentNo)
           set @error_number = 0
           set @ErMessage = 'Success: Data Added Succesfully !'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstUnitAddEdit]', 'P') IS NOT NULL DROP PROCEDURE [udspMstUnitAddEdit];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2023-01-23
-- Description:	Add Units
-- =============================================
CREATE PROCEDURE [dbo].[udspMstUnitAddEdit] 
	-- Add the parameters for the stored procedure here
	@ID bigint,
	@Name varchar(100),
	@Desc varchar(max)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		begin transaction
			if(@ID=0) 
			Begin
				INSERT INTO utblMstUnits (UnitName,UnitDescription)VALUES(@Name,@Desc)
				 set @ErMessage = 'Success: Data Added Succesfully !'
			End
			else
			Begin
				Update utblMstUnits set
				UnitName=@Name,
				UnitDescription=@Desc
				where UnitID=@ID
				set @ErMessage = 'Success: Data Updated Succesfully !'
			End
		
	commit transaction
	END TRY 
	BEGIN CATCH 
		rollback transaction
		SELECT @error_number = ERROR_NUMBER(), 
		@ErMessage ='Error: '+ ERROR_MESSAGE()
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstVendorDelete]', 'P') IS NOT NULL DROP PROCEDURE [udspMstVendorDelete];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-29
-- Description:	Delete Vendor
-- =============================================
Create PROCEDURE [dbo].[udspMstVendorDelete] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		delete from utblMstVendorDetails
		where VenderID = @ID
		set @error_number = 0
		set @ErMessage = 'Success: Record Deleted Succesfully.'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error: This record could not be deleted as reference for this record exist.'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstVendorInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspMstVendorInsert];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-28
-- Description:	Add Vendor
-- =============================================
CREATE PROCEDURE [dbo].[udspMstVendorInsert] 
	-- Add the parameters for the stored procedure here
	@VenderName varchar(100),
	@GSTNo varchar(30),
	@ContactName varchar(100),
	@ContactNo varchar(15),
	@Address varchar(max),
	@Email Varchar(50),
	@UserName varchar(50)
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	Declare @GstCheck varchar(50)
	 Select @GstCheck=GSTNo from utblMstVendorDetails where GSTNo= @GSTNo and GSTNo is not null
	BEGIN TRY 
		if(@GstCheck=@GSTNo)
		Begin
			 set @error_number = 2672
			set @ErMessage = 'Error: GST No Already Exist.. Please Check !'
		End
		Else
		Begin
			INSERT INTO utblMstVendorDetails (VenderName,VenderAddress,GSTNo,ContactName,ContactNo,Email,UserID,LastModifiedOn)
			VALUES(@VenderName,@Address,@GSTNo,@ContactName,@ContactNo,@Email,@UserName,GETDATE())
           set @error_number = 0
           set @ErMessage = 'Success: Data Added Succesfully !'
		End
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check Units list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspMstVendorUpdate]', 'P') IS NOT NULL DROP PROCEDURE [udspMstVendorUpdate];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-28
-- Description:	Add Vendor
-- =============================================
CREATE PROCEDURE [dbo].[udspMstVendorUpdate] 
	-- Add the parameters for the stored procedure here
	@VenderID bigint,
	@VenderName varchar(100),
	@GSTNo varchar(30),
	@ContactName varchar(100),
	@ContactNo varchar(20),
	@Address varchar(max),
	@Email Varchar(50),
	@UserName varchar(50)
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	Declare @GstCheck varchar(50)
	 Select @GstCheck=GSTNo from utblMstVendorDetails where GSTNo= @GSTNo and GSTNo is not null and VenderID<>@VenderID
	BEGIN TRY 
		if(@GstCheck=@GSTNo)
		Begin
			 set @error_number = 2672
			set @ErMessage = 'Error: GST No Already Exist.. Please Check !'
		End
		Else
		Begin
			Update utblMstVendorDetails set
			 VenderName=@VenderName,
			 VenderAddress=@Address,
			 GSTNo=@GSTNo,
			 ContactName=@ContactName,
			 ContactNo=@ContactNo,
			 Email=@Email,
			 UserID=@UserName,
			 LastModifiedOn=GETDATE()
			 where VenderID=@VenderID
			   set @error_number = 0
			   set @ErMessage = 'Success: Data Update Succesfully !'
		End
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check Units list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspOfficalDocsDelete]', 'P') IS NOT NULL DROP PROCEDURE [udspOfficalDocsDelete];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-07-3
-- Description:	Delete Offical Docs 
-- =============================================
Create PROCEDURE [dbo].[udspOfficalDocsDelete] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		delete from utblOfficalLetterDocs
		where DocID = @ID
		set @error_number = 0
		set @ErMessage = 'Success: Record Deleted Succesfully.'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error: This record could not be deleted as reference for this record exist.'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspOfficalLetterDocsInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspOfficalLetterDocsInsert];
GO
-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2020-03-26>
-- Description:	<Upload Offical docs>
-- =============================================
Create PROCEDURE [dbo].[udspOfficalLetterDocsInsert]
@DocName nvarchar(256),
@RefID bigint,
@DocPath nvarchar(max)
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		BEGIN TRANSACTION
			Insert into utblOfficalLetterDocs(DocName,ReferenceID,DocPath) Values
				(@DocName,@RefID,@DocPath)
		
			set @error_number = 0
			set @ErMessage = 'Success: Data Added Succesfully !'
		
		COMMIT TRANSACTION
	END TRY
		BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record...'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END









GO

IF OBJECT_ID('[udspPaymentReceivedSave]', 'P') IS NOT NULL DROP PROCEDURE [udspPaymentReceivedSave];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 6 May 2023
-- Description:	Save payment received details
-- =============================================
CREATE PROCEDURE [dbo].[udspPaymentReceivedSave]
	-- Add the parameters for the stored procedure here
	@ReceivedID bigint,
	@ExpTypeID bigint,
	@AmtReceived money,
	@ReceivedDate date,
	@ReceivedMode varchar(50),
	@BankID bigint,
	@TransactionNo varchar(128),
	@FilePath nvarchar(max),
	@Remarks nvarchar(max),
	@UserName varchar(128)
AS
BEGIN
	DECLARE   @error_number INT, @Msg NVARCHAR(2048)
	BEGIN TRY
		begin transaction
			declare @ID bigint

			if(@ReceivedID=0)
			begin
				insert into utblPaymentReceivables
				(ExpenseTypeID,AmtReceived, ReceivedDate, ReceivedMode, BankID, TransactionNo, Remarks, UploadedFile, AddedBy, AddedOn)
				values
				(@ExpTypeID,@AmtReceived,@ReceivedDate,@ReceivedMode,@BankID,@TransactionNo,@Remarks,@FilePath,@UserName, GETDATE())

				if(@ReceivedMode='Cash')
				begin
					select @ID=SCOPE_IDENTITY() from utblPaymentReceivables

					insert into utblPettyCashs (TransDate,ExpenseTypeID,ReceivedID,CreditAmt,Remarks,IsClosed)
					values
					(@ReceivedDate,@ExpTypeID,@ID,@AmtReceived,@Remarks,0)
				end

				set @Msg='Payment Received Record Added'
			end
			else
			begin
				if(@ReceivedMode='Cash')
				begin
					update utblPettyCashs set
					TransDate=@ReceivedDate,
					CreditAmt=@AmtReceived,
					Remarks=@Remarks,
					ExpenseTypeID=@ExpTypeID
					where ReceivedID=@ReceivedID
				end
				else
				begin
					delete from utblPettyCashs where ReceivedID=@ReceivedID
				end

				update utblPaymentReceivables set
				ExpenseTypeID=@ExpTypeID,
				AmtReceived=@AmtReceived,
				ReceivedDate=@ReceivedDate,
				ReceivedMode=@ReceivedMode,
				BankID=@BankID,
				TransactionNo=@TransactionNo,
				UploadedFile=@FilePath,
				Remarks=@Remarks,
				AddedBy=@UserName
				where ReceivedID=@ReceivedID

				set @Msg='Payment Received Details Updated'
			end

		commit transaction
	END TRY 
	BEGIN CATCH 
		rollback transaction
		SELECT @error_number = ERROR_NUMBER(), @Msg ='Error: '+ ERROR_MESSAGE()
	END CATCH
	select @Msg
END


GO

IF OBJECT_ID('[udspPaymentReleaseSave]', 'P') IS NOT NULL DROP PROCEDURE [udspPaymentReleaseSave];
GO

-- =============================================
-- Author:		Rakib Alam
-- Create date: 6 June 2023
-- Description:	Save payment for procurement
-- =============================================
CREATE PROCEDURE [dbo].[udspPaymentReleaseSave]
	--@PaymentID bigint, 
	@PaymentDate date,
	@PaymentAmt money,
	@PaymentMode nvarchar(50),
	@POID nvarchar(12),
	@DirectPaymentID bigint,
	@BankID bigint,
	@TransactionNo nvarchar(50),
	@FilePath nvarchar(max),
	@Remarks nvarchar(max),
	@UserName nvarchar(max),
	@ExpType bigint
	--@ExpHeadID bigint
AS
BEGIN
	declare @Msg nvarchar(max)
	begin try
		begin transaction
			declare @status varchar(50),@PaymentID bigint
			declare @PayableAmt money=0.0,@CashBalance money=0.0,@PaidAmt decimal=0.0,@dueamt decimal=0.0
			Declare @purpose varchar(max), @POExpHeadID bigint,@ExpHeadID bigint
			Declare @PayableAmtIsCorrect bit=0
			--Payable Amount 
			if(@POID Is Not  null)
			Begin 
				set @PayableAmt=(select ISNULL(BalanceAmount,0) from utblPurchaseInvoiceKeys where PurchaseInvoiceID=@POID)
			End
			Else
			Begin 
				set @PaidAmt=(select isnull(sum(isnull(PaymentAmt,0)),0) from utblPaymentReleasedTrans where DirectPaymentID=@DirectPaymentID)
				set @PayableAmt=(select (isnull(PaymentAmt,0)-isnull(@PaidAmt,0)) from utblDirectPayments where DirectPaymentID=@DirectPaymentID)
			End

			if(@PaymentAmt>@PayableAmt)
			Begin
				if((@PaymentAmt-@PayableAmt)>=1)
				Begin
					Set @PayableAmtIsCorrect=1
					Set @Msg = Concat('Error: Payment amount cannot be greater than balance amount (',cast(@PayableAmt as Varchar(10)),')')
				End
			End

			set @dueamt=(select @PayableAmt- @PaymentAmt)

			--Cash Balance In Hand	
			select @CashBalance=dbo.udfGetPettyCashBalance()

			if(@PayableAmtIsCorrect=0)
			Begin
				if(@PaymentMode = 'Cash')
				begin
					if(@CashBalance < @PaymentAmt)
					begin
						set @Msg = 'Error: Insufficient fund for settlement !'
					end
					else
					begin
						------ insert in procurement payments ------
						Insert Into utblPaymentReleasedTrans (PaymentDate,PaymentAmt,PaymentMode,PurchaseInvoiceID,
						DirectPaymentID,BankID,PaymentTransNo,UploadedFile,Remarks,AddedBy,AddedOn)
						values
						(@PaymentDate,@PaymentAmt,@PaymentMode,@POID,@DirectPaymentID,@BankID,@TransactionNo,@FilePath,@Remarks,@UserName, GETDATE())

						set @PaymentID=SCOPE_IDENTITY() 
						----------------------------------------------
						if(@POID Is Not  null)
						Begin 
							-------- update procurement details ---------
							update utblPurchaseInvoiceKeys set
							AmountPaid=ISNULL(AmountPaid,0)+@PaymentAmt,
							BalanceAmount=BalanceAmount-@PaymentAmt
							where PurchaseInvoiceID=@POID
						
							Set @purpose =(select 'Payment release for '+ case when PORefNo is not null then 'PO No. ' + PORefNo
							else 'Bill No. ' + BillNo end from utblPurchaseInvoiceKeys where PurchaseInvoiceID=@POID)
							select @POExpHeadID=ExpenseTypeID from utblMstExpenseTypes where ExpenseType='PROCUREMENT'
							Set @ExpHeadID=@POExpHeadID
						End
						Else
						Begin 
							update utblDirectPayments set
							Status=Case When (@dueamt=0 or @dueamt<=1) Then 'Settled' Else 'Partial Settled'End
							--Status=Case When @PayableAmt=@PaymentAmt Then 'Settled' Else 'Partial Settled'End
							where  DirectPaymentID=@DirectPaymentID

							set @purpose=@Remarks
							Set @ExpHeadID=@ExpType
						End	
					
						--- insert into petty cash payment ---
						Insert into utblPettyCashs 
						(TransDate,ExpenseTypeID,PaymentID,CreditAmt,DebitAmt,Remarks,IsClosed)
						Values
						(@PaymentDate,@ExpHeadID,@PaymentID,0,@PaymentAmt,@purpose,0)

						set @Msg = 'Success: Payment recored  details added'
					end
				end
				else
				begin
						------ insert in procurement payments ------
						Insert Into utblPaymentReleasedTrans (PaymentDate,PaymentAmt,PaymentMode,PurchaseInvoiceID,
						DirectPaymentID,BankID,PaymentTransNo,UploadedFile,Remarks,AddedBy,AddedOn)
						values
						(@PaymentDate,@PaymentAmt,@PaymentMode,@POID,@DirectPaymentID,@BankID,@TransactionNo,@FilePath,@Remarks,@UserName, GETDATE())
						----------------------------------------------
						if(@POID Is Not  null)
						Begin 
							-------- update procurement details ---------
							update utblPurchaseInvoiceKeys set
							AmountPaid=ISNULL(AmountPaid,0)+@PaymentAmt,
							BalanceAmount=BalanceAmount-@PaymentAmt
							where PurchaseInvoiceID=@POID
						End
						Else
						Begin 
							update utblDirectPayments set
							Status=Case When (@dueamt=0 or @dueamt<=1) Then 'Settled' Else 'Partial Settled'End
							--Status=Case When @PayableAmt=@PaymentAmt Then 'Settled' Else 'Partial Settled'End
							where  DirectPaymentID=@DirectPaymentID
						End	
					set @Msg = 'Success: Payment recored  details added'
				end
			End

		commit transaction
	end try
	begin catch
		rollback transaction
		select @Msg='Error: '+ERROR_MESSAGE()
	end catch
	select @Msg
END

GO

IF OBJECT_ID('[udspPaymentsInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspPaymentsInsert];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-05-10
-- Description:	Add Payment Details
-- =============================================
Create PROCEDURE [dbo].[udspPaymentsInsert] 
	-- Add the parameters for the stored procedure here
	@ExpTypeID bigint,
	@PaymentDate date,
	@PaymentAmt money,
	@PaymentMode nvarchar(50),
	@BankID bigint,
	@ChequeTransNo nvarchar(256),
	@FilePath nvarchar(max),
	@ProjectID bigint,
	@VendorID bigint,
	@PaymentType nvarchar(50),
	@Remarks nvarchar(max),
	@UserName nvarchar(128)
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
	BEGIN TRANSACTION
		declare @PayID varchar(8), @char char(1), @code int
		select @PayID = UniqueCode, @char=CharRange, @code=UpdatedSlNo from dbo.udfUtilEightCharacterKey('utblPaymentDetails')

		INSERT INTO utblPaymentDetails (PaymentID,ExpenseTypeID,PaymentDate,PaymentAmt,PaymentMode,BankID,
		ChequeTransNo,PaymentFile,VendorID,ProjectID,PaymentType,Remarks,UserID,LastModifiedOn) Values
		(@PayID,@ExpTypeID,@PaymentDate,@PaymentAmt,@PaymentMode,@BankID,@ChequeTransNo,@FilePath,
		@VendorID,@ProjectID,@PaymentType,@Remarks,@UserName,GETDATE())

		-------------------------Update Cood Seed Table	----------------------------------------------
		if(@code=999 and @char='Z')
			update utblMstGenCodeSeeds set CharRange='A', StartRange=1 where TableName='utblPaymentDetails'
		else if(@code=999)
			update utblMstGenCodeSeeds set CharRange=CHAR(ASCII(@char)+1), StartRange=1 where TableName='utblPaymentDetails'
		else
			update utblMstGenCodeSeeds set StartRange=@code where TableName='utblPaymentDetails'

         set @error_number = 0
         set @ErMessage = 'Success: Data Added Succesfully !'

	COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Payment already exists, please check Payment list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspPaymentsUpdate]', 'P') IS NOT NULL DROP PROCEDURE [udspPaymentsUpdate];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-05-10
-- Description:	Update Payment Details
-- =============================================
Create PROCEDURE [dbo].[udspPaymentsUpdate] 
	-- Add the parameters for the stored procedure here
	@PaymentID varchar(8),
	@ExpTypeID bigint,
	@PaymentDate date,
	@PaymentAmt money,
	@PaymentMode nvarchar(50),
	@BankID bigint,
	@ChequeTransNo nvarchar(256),
	@FilePath nvarchar(max),
	@ProjectID bigint,
	@VendorID bigint,
	@PaymentType nvarchar(50),
	@Remarks nvarchar(max),
	@UserName nvarchar(128)
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
	BEGIN TRANSACTION
		
		Update utblPaymentDetails set 
		ExpenseTypeID=@ExpTypeID,
		PaymentDate=@PaymentDate,
		PaymentAmt=@PaymentAmt,
		PaymentMode=@PaymentMode,
		BankID=@BankID,
		ChequeTransNo=@ChequeTransNo,
		PaymentFile=@FilePath,
		VendorID=@VendorID,
		ProjectID=@ProjectID,
		PaymentType=@PaymentType,
		Remarks=@Remarks,
		UserID=@UserName,
		LastModifiedOn=GETDATE()
		Where PaymentID=@PaymentID

         set @error_number = 0
         set @ErMessage = 'Success: Data Updated Succesfully !'

	COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Payment already exists, please check Payment list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspPettyCashSave]', 'P') IS NOT NULL DROP PROCEDURE [udspPettyCashSave];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 6 May 2023
-- Description:	Save Petty Cash Received Details
-- =============================================
CREATE PROCEDURE [dbo].[udspPettyCashSave]
	-- Add the parameters for the stored procedure here
	@PettyCashID bigint, 
	@ExpTypeID bigint,
	@TransDate date,
	@CreditAmt money,
	@BankID bigint,
	@Remarks nvarchar(max),
	@FilePath varchar(128)
AS
BEGIN
DECLARE   @error_number INT, @Msg NVARCHAR(2048)
	BEGIN TRY
		begin transaction
			declare @ID bigint

			if(@PettyCashID=0)
			begin
				insert into utblPettyCashs (TransDate,ExpenseTypeID,BankID,CreditAmt,Remarks,IsClosed,FilePath)
				values
				(@TransDate,@ExpTypeID,@BankID,@CreditAmt,@Remarks,0,@FilePath)
				set @Msg='Success: Petty Cash Received Details Added'
			end
			else
			begin
				update utblPettyCashs set
				TransDate=@TransDate,
				CreditAmt=@CreditAmt,
				Remarks=@Remarks,
				ExpenseTypeID=@ExpTypeID,
				BankID=@BankID,
				FilePath=@FilePath
				where PettyCashID=@PettyCashID
				set @Msg='Success: Petty Cash Received Details Updated'
			end

		commit transaction
	END TRY 
	BEGIN CATCH 
		rollback transaction
		SELECT @error_number = ERROR_NUMBER(), @Msg ='Error: '+ ERROR_MESSAGE()
	END CATCH
	select @Msg

	select PettyCashID,TransDate,ExpenseType,CreditAmt,DebitAmt,Remarks,IsClosed from utblPettyCashs a
	inner Join utblMstExpenseTypes b on a.ExpenseTypeID=b.ExpenseTypeID
	Order By TransDate
	
END

GO

IF OBJECT_ID('[udspProjPaymentReceivedSave]', 'P') IS NOT NULL DROP PROCEDURE [udspProjPaymentReceivedSave];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 13 May 2023
-- Description:	Save Project Related payment received details
-- =============================================
CREATE PROCEDURE [dbo].[udspProjPaymentReceivedSave]
	-- Add the parameters for the stored procedure here
	@ReceivedID bigint,
	@ProjectID bigint,
	@BankID bigint,
	@ReceivedDate Date,
	@ReceivedMode nvarchar(50),
	@Remarks nvarchar(max),
	@NetAmt money,
	@TDSAmt money,
	@GSTAmt money,
	@SDAmt money,
	@OtherAmt money,
	@IsAdvance bit,
	@FilePath nvarchar(max),
	@SalInv varchar(10)
AS
BEGIN
	DECLARE   @error_number INT, @Msg NVARCHAR(2048)
	BEGIN TRY
		begin transaction
			declare @ID bigint

			if(@ReceivedID=0)
			begin
				insert into utblProjPaymentReceivables(ProjectID,BankID,ReceivedDate,ReceivedMode,Remarks,
				NetAmtReceived,TDSDeductionAmt,GstDeductionAmt,SecurityDepositAmt,OtherDeductionAmt,IsAdvance,UploadedFile,SaleInvoiceID)
				values
				(@ProjectID,@BankID,@ReceivedDate,@ReceivedMode,@Remarks,@NetAmt,@TDSAmt,@GSTAmt,@SDAmt,@OtherAmt,@IsAdvance,@FilePath,@SalInv)

				if(@ReceivedMode='Cash')
				begin
					Declare @ExpID bigint
					Select @ExpID= ExpenseTypeID from utblMstExpenseTypes where ExpenseType='PROJECTS'
					select @ID=SCOPE_IDENTITY() from utblProjPaymentReceivables

					insert into utblPettyCashs (TransDate,ExpenseTypeID,ProjPaymentReceiveID,CreditAmt,Remarks,IsClosed)
					values
					(@ReceivedDate,@ExpID,@ID,@NetAmt,@Remarks,0)
				end
				set @Msg='Success: Payment Received Record Added'
			end
			else
			begin
				if(@ReceivedMode='Cash')
				begin
					update utblPettyCashs set
					TransDate=@ReceivedDate,
					CreditAmt=@NetAmt,
					Remarks=@Remarks
					where ProjPaymentReceiveID=@ReceivedID
				end
				else
				begin
					delete from utblPettyCashs where ProjPaymentReceiveID=@ReceivedID
				end

				update utblProjPaymentReceivables set
				ProjectID=@ProjectID,
				BankID=@BankID,
				ReceivedDate=@ReceivedDate,
				ReceivedMode=@ReceivedMode,
				Remarks=@Remarks,
				NetAmtReceived=@NetAmt,
				TDSDeductionAmt=@TDSAmt,
				GstDeductionAmt=@GSTAmt,
				SecurityDepositAmt=@SDAmt,
				OtherDeductionAmt=@OtherAmt,
				IsAdvance=@IsAdvance,
				UploadedFile=@FilePath,
				SaleInvoiceID=@SalInv
				where ProjPaymentReceiveID=@ReceivedID

				set @Msg='Success: Payment Received Details Updated'
			end

		commit transaction
	END TRY 
	BEGIN CATCH 
		rollback transaction
		SELECT @error_number = ERROR_NUMBER(), @Msg ='Error: '+ ERROR_MESSAGE()
	END CATCH
	select @Msg
END

GO

IF OBJECT_ID('[udspPurchaseInvoiceInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspPurchaseInvoiceInsert];
GO

-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2020-08-22>
-- Description:	<Insert Purchase Details>
-- =============================================
CREATE  PROCEDURE [dbo].[udspPurchaseInvoiceInsert]
	-- Add the parameters for the stored procedure here
	@ItemDtlsList AddItemDtlsTVP ReadOnly,
	@ProjectID bigint,
	@VenderID bigint,
	@PurchaseDate datetime,
	@BillNo nvarchar(50),
	@ExcludingTaxAmt decimal(10,2),
	@IGSTAmount decimal(10,2),
	@CGSTAmount decimal(10,2),
	@SGSTAmount decimal(10,2),
	@IncludingTaxAmt decimal(10,2),
	@AmountPaid decimal(10,2),
	@BalanceAmount decimal(10,2),
	@UploadBill nvarchar(max),
	@UserName nvarchar(100),
	@Remarks nvarchar(max),
	@PORefNo nvarchar(50),
	@POType nvarchar(50),
	@ShipTo nvarchar(max),
	@TermsConditions nvarchar(max)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	Begin Try
	 BEGIN TRANSACTION
			declare @PurchaseID varchar(10), @char char(1), @code int
			Declare @FiscalYear varchar(10),@SLNo int=0,@State varchar(50),@VendorName varchar(128)
			--select * from utblReferenceDetails
			----Get & Insert Po Ref Number 
			Set @VendorName=(select VenderName From utblMstVendorDetails where VenderID=@VenderID)
			Set @FiscalYear=(select [dbo].[udsfGetFiscalYear](@PurchaseDate))
			select @SLNo=max(SLNO) from utblReferenceDetails where FiscalYear=@FiscalYear and RefType='Purchase Order'
			if(@SLNo is null or @SLNo=0 or @SLNo='')
			Begin
				set @SLNo=0
			End 
			Set @PORefNo=CONCAT('SDK/',@FiscalYear,'/',@SLNo+1,'/PO')
			Insert into utblReferenceDetails(RefDate,RefType,DescORSubject,FiscalYear,RefNumber,LetterTO,VendorID,SLNO,IsCancelled,UserID,LastModifiedOn) Values
			(cast(@PurchaseDate as date),'Purchase Order',@Remarks,@FiscalYear,@PORefNo,@VendorName,@VenderID,@SLNo+1,0,@UserName,Getdate())
			----End PO Ref NO	
			select @PurchaseID = UniqueCode, @char=CharRange, @code=UpdatedSlNo from dbo.udfUtilEightCharacterKey('utblPurchaseInvoiceKeys')

			Set @BalanceAmount=@IncludingTaxAmt
			
			----------- Insert utblStkProcurementKeys Table-------------------------
			Insert into utblPurchaseInvoiceKeys 
				(PurchaseInvoiceID,ProjectID,VenderID,PurchaseDate,BillNo,ExcludingTaxAmt,IGSTAmount,
				CGSTAmount,SGSTAmount,IncludingTaxAmt,AmountPaid,BalanceAmount,UserID,LastModifiedOn,
				Remarks,UploadBill,PORefNo,POType,ShipTo,TermsConditions) 
				VAlues
				(@PurchaseID,@ProjectID,@VenderID,@PurchaseDate,@BillNo,@ExcludingTaxAmt,@IGSTAmount,
				@CGSTAmount,@SGSTAmount,@IncludingTaxAmt,@AmountPaid,@BalanceAmount,@UserName,GETDATE(),
				@Remarks,@UploadBill,@PORefNo,@POType,@ShipTo,@TermsConditions)
			
				insert into utblPurchaseInvoiceItems (ItemDtlID,PurchaseInvoiceID,ItemName,ItemHSNCode,GSTPercentage,IGSTPercentage ,CGSTPercentage,SGSTPercentage,Qty,Rate,Amount,SlNo)
				(Select NEWID(),@PurchaseID,ItemName,ItemHSNCode,GSTPercentage,IGSTPercentage,CGSTPercentage,SGSTPercentage,Qty,Rate,(Qty*Rate),ROW_NUMBER() over (order by (Select NULL)) from @ItemDtlsList)
			------------------------End ---------------------------------------------
				--insert into utblPurchaseInvoiceItems 
				--Select NEWID(),@PurchaseID,ItemID,ItemHSNCode,GSTPercentage,IGSTPercentage,CGSTPercentage,SGSTPercentage,Qty,Rate,(Qty*Rate) from @ItemDtlsList
			------------------------End ---------------------------------------------

		-------------------------Update Cood Seed Table	----------------------------------------------
		if(@code=999 and @char='Z')
			update utblMstGenCodeSeeds set CharRange='A', StartRange=1 where TableName='utblPurchaseInvoiceKeys'
		else if(@code=999)
			update utblMstGenCodeSeeds set CharRange=CHAR(ASCII(@char)+1), StartRange=1 where TableName='utblPurchaseInvoiceKeys'
		else
			update utblMstGenCodeSeeds set StartRange=@code where TableName='utblPurchaseInvoiceKeys'

		set @error_number = 0
        set @ErMessage = 'Success: Data Added Succesfully !'

	 COMMIT TRANSACTION
	End Try

	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage
END



GO

IF OBJECT_ID('[udspPurchaseInvoiceUpdate]', 'P') IS NOT NULL DROP PROCEDURE [udspPurchaseInvoiceUpdate];
GO

-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2020-08-22>
-- Description:	<Update Purchase Invoice Details>
-- =============================================
CREATE  PROCEDURE [dbo].[udspPurchaseInvoiceUpdate]
	-- Add the parameters for the stored procedure here
	--@PurchaseInvoiceID,@ItemDtlsList,@VenderID,@InvoiceDate,@BillNo,@ExcludingTaxAmt,@IGSTAmount,@CGSTAmount,@SGSTAmount,@IncludingTaxAmt,@AmountPaid,@BalanceAmount,@UserName

	@PurchaseInvoiceID varchar(8),
	@ItemDtlsList AddItemDtlsTVP ReadOnly,
	@ProjectID bigint,
	@VenderID bigint,
	@PurchaseDate datetime,
	@BillNo nvarchar(50),
	@ExcludingTaxAmt decimal(10,2),
	@IGSTAmount decimal(10,2),
	@CGSTAmount decimal(10,2),
	@SGSTAmount decimal(10,2),
	@IncludingTaxAmt decimal(10,2),
	@AmountPaid decimal(10,2),
	@BalanceAmount decimal(10,2),
	@UploadBill nvarchar(max),
	@UserName nvarchar(100),
	@Remarks nvarchar(max),
	@PORefNo nvarchar(50),
	@POType nvarchar(50),
	@ShipTo nvarchar(max),
	@TermsConditions nvarchar(max)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	Begin Try
	 BEGIN TRANSACTION

			----------- Delete utblSaleInvoiceItems Table-------------------------
			Delete from utblPurchaseInvoiceItems where PurchaseInvoiceID=@PurchaseInvoiceID

			declare @AmtPaid decimal(10,2)=0.0
				select @AmtPaid = AmountPaid from utblPurchaseInvoiceKeys where PurchaseInvoiceID=@PurchaseInvoiceID
				Set @BalanceAmount=@IncludingTaxAmt-@AmtPaid
				set @AmountPaid=@AmtPaid

			----------- Insert utblStkProcurementKeys Table-------------------------
			Update utblPurchaseInvoiceKeys Set
			VenderID=@VenderID,
			ProjectID=@ProjectID,
			PurchaseDate=@PurchaseDate,
			BillNo=@BillNo,
			ExcludingTaxAmt=@ExcludingTaxAmt,
			IGSTAmount=@IGSTAmount,
			CGSTAmount=@CGSTAmount,
			SGSTAmount=@SGSTAmount,
			IncludingTaxAmt=@IncludingTaxAmt,
			AmountPaid=@AmountPaid,
			BalanceAmount=@BalanceAmount,
			UserID=@UserName,
			Remarks=@Remarks,
			UploadBill=@UploadBill,
			LastModifiedOn=GETDATE(),
			PORefNo=@PORefNo,
			POType=@POType,
			ShipTo=@ShipTo,
			TermsConditions=@TermsConditions
			where PurchaseInvoiceID=@PurchaseInvoiceID
			
			insert into utblPurchaseInvoiceItems (ItemDtlID,PurchaseInvoiceID,ItemName,ItemHSNCode,GSTPercentage,IGSTPercentage ,CGSTPercentage,SGSTPercentage,Qty,Rate,Amount,SlNo)
				(Select NEWID(),@PurchaseInvoiceID,ItemName,ItemHSNCode,GSTPercentage,IGSTPercentage,CGSTPercentage,SGSTPercentage,Qty,Rate,(Qty*Rate),ROW_NUMBER() over (order by (Select NULL)) from @ItemDtlsList)

		set @error_number = 0
        set @ErMessage = 'Success: Data Update Succesfully !'

	 COMMIT TRANSACTION
	End Try

	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage
END



GO

IF OBJECT_ID('[udspPurchaseSaleDelete]', 'P') IS NOT NULL DROP PROCEDURE [udspPurchaseSaleDelete];
GO
-- =============================================
-- Author:		Rakib Alam
-- Create date: 2020-03-29
-- Description:	Delete Purchase Sale
-- =============================================
CREATE PROCEDURE [dbo].[udspPurchaseSaleDelete] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY  
		delete from utblPurchaseSales
		where PurchaseSaleID = @ID
		set @error_number = 0
		set @ErMessage = 'Success: Record Deleted Succesfully.'
	END TRY 
	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @error_number = 547 --- Referential integrity constraint
			BEGIN
				set @error_number = 5470     
				set @ErMessage = 'Error: This record could not be deleted as reference for this record exist.'
				
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState )
		END 
	END CATCH
	select @ErMessage 
END




GO

IF OBJECT_ID('[udspPurchaseSaleInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspPurchaseSaleInsert];
GO
-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2020-03-31>
-- Description:	<Insert Purchase and sale details>
-- =============================================
CREATE PROCEDURE [dbo].[udspPurchaseSaleInsert]
@PSDate datetime,
@InvoiceNo varchar(20),
@VenderID bigint,
@ClientID bigint,
@HSNSAC varchar(50),
@IGST float,
@CGST float,
@SGST float,
@Amount float,
@PSType varchar(20),
@Description varchar(max),
@IsIGST bit,
@UserName varchar(50)
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		BEGIN TRANSACTION
			Insert into utblPurchaseSales(PurchaseSaleDate,PurchaseSaleInvoiceNo,VenderID,ClientID,HSNSAC,IGST,CGST,SGST,TaxableAmount,PurchaseSaleType,Description,IsIGST,UserID,LastModifiedOn) Values
				(cast(@PSDate as date),@InvoiceNo,@VenderID,@ClientID,@HSNSAC,@IGST,@CGST,@SGST,@Amount,@PSType,@Description,@IsIGST, @UserName,Getdate())
		
			set @error_number = 0
			set @ErMessage = 'Success: Data Added Succesfully !'
		
		COMMIT TRANSACTION
	END TRY
		BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check Units list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END









GO

IF OBJECT_ID('[udspPurchaseSaleUpdate]', 'P') IS NOT NULL DROP PROCEDURE [udspPurchaseSaleUpdate];
GO
-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2020-03-31>
-- Description:	<Update Purchase and sale details>
-- =============================================
CREATE PROCEDURE [dbo].[udspPurchaseSaleUpdate]
@PurchaseSaleID bigint,
@PSDate datetime,
@InvoiceNo varchar(20),
@VenderID bigint,
@ClientID bigint,
@HSNSAC varchar(50),
@IGST float,
@CGST float,
@SGST float,
@Amount float,
@PSType varchar(20),
@Description varchar(max),
@IsIGST bit,
@UserName varchar(50)
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		BEGIN TRANSACTION
			update utblPurchaseSales set
			PurchaseSaleDate=cast(@PSDate as date),
			PurchaseSaleInvoiceNo=@InvoiceNo,
			VenderID=@VenderID,
			ClientID=@ClientID,
			HSNSAC=@HSNSAC,
			IGST=@IGST,
			CGST=@CGST,
			SGST=@SGST,
			TaxableAmount=@Amount,
			PurchaseSaleType=@PSType,
			Description=@Description,
			IsIGST=@IsIGST,
			UserID=@UserName,
			LastModifiedOn=Getdate()
				Where PurchaseSaleID=@PurchaseSaleID
		
			set @error_number = 0
			set @ErMessage = 'Success: Data Update Succesfully !'
		
		COMMIT TRANSACTION
	END TRY
		BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check Units list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END









GO

IF OBJECT_ID('[udspRefNumberInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspRefNumberInsert];
GO
-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2020-03-26>
-- Description:	<Insert Reference Number>
-- =============================================
CREATE PROCEDURE [dbo].[udspRefNumberInsert]
@RefType varchar(50),
@LetterTO varchar(256),
@RefDate datetime,
@DeptID bigint,
@DescORSubject varchar(max),
@UserName varchar(50)
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		BEGIN TRANSACTION
			Declare @StartDate date, @EndDate date,@FiscalYear varchar(10),@SNo int,@TypeAbb varchar(5)
			set @StartDate = cast(convert(varchar,YEAR(@RefDate))+'-04-01' as date)
			set @EndDate = cast(convert(varchar,YEAR(@RefDate)+1)+'-03-31' as date)
			if(cast(@RefDate as date) between @StartDate and @EndDate)
			BEGIN
				set @FiscalYear = CONCAT (YEAR(@StartDate),'-',Right(Year(@StartDate)+1,2))
			END
			else if(cast(@RefDate as date) < @StartDate)
			BEGIN
				set @FiscalYear =CONCAT(YEAR(@StartDate) - 1,'-',Right(Year(@StartDate),2))
			END
			else
			BEGIN
				set @error_number=2601;
				set @ermessage='@FiscalYear Not set.';
			END
			select @TypeAbb= CASE
				WHEN @RefType='Proforma Invoice' THEN '/PI'
				WHEN @RefType='Challan' THEN '/CH'
				WHEN @RefType='Purchase Order' THEN '/PO'
				ELSE ''
			END  
			select @SNo=max(SLNO) from utblReferenceDetails where FiscalYear=@FiscalYear and RefType=@RefType
				if(@SNo is null or @SNo=0 or @SNo='')
				Begin
					set @SNo=0
				End
			

			Insert into utblReferenceDetails(RefDate,RefType,DescORSubject,FiscalYear,RefNumber,VendorID,LetterTO,SLNO,UserID,LastModifiedOn,IsCancelled) Values
				(cast(@RefDate as date),@RefType,@DescORSubject,@FiscalYear,CONCAT('SDK/',@FiscalYear,'/',@SNo+1,@TypeAbb),@DeptID,@LetterTo,@SNo+1, @UserName,Getdate(),0)
		
			set @error_number = 0
			set @ErMessage = 'Success: Data Added Succesfully !'
		
		COMMIT TRANSACTION
	END TRY
		BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check Units list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END









GO

IF OBJECT_ID('[udspRefNumberUpdate]', 'P') IS NOT NULL DROP PROCEDURE [udspRefNumberUpdate];
GO
-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2020-03-26>
-- Description:	<Update Reference Number>
-- =============================================
CREATE PROCEDURE [dbo].[udspRefNumberUpdate]
@ReferenceID bigint,
@RefType varchar(50),
@LetterTO varchar(256),
@RefDate datetime,
@DeptID bigint,
@DescORSubject varchar(max),
@UserName varchar(50)
	
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	BEGIN TRY
		BEGIN TRANSACTION
			update utblReferenceDetails set
			RefDate=cast(@RefDate as date),
			RefType=@RefType,
			DescORSubject=@DescORSubject,
			VendorID=@DeptID,
			LetterTO=@LetterTo,
			UserID=@UserName,
			LastModifiedOn=Getdate() where ReferenceID=@ReferenceID
					
			set @error_number = 0
			set @ErMessage = 'Success: Data Update Succesfully !'
		
		COMMIT TRANSACTION
	END TRY
		BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check Units list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage 
END









GO

IF OBJECT_ID('[udspSaleInvoiceInsert]', 'P') IS NOT NULL DROP PROCEDURE [udspSaleInvoiceInsert];
GO

-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2020-07-25>
-- Description:	<Insert Invoice Details>
-- =============================================
CREATE  PROCEDURE [dbo].[udspSaleInvoiceInsert]
	-- Add the parameters for the stored procedure here
	@ItemDtlsList AddItemDtlsTVP ReadOnly,
	@InvoiceTo nvarchar(100),
	@ProjectID bigint,
	@VenderID bigint,
	@OrderNo nvarchar(200),
	@OrderDate datetime,
	@InvoiceDate datetime,
	@ReferenceNo varchar(25),
	@ExcludingTaxAmt decimal(10,2),
	@IGSTAmount decimal(10,2),
	@CGSTAmount decimal(10,2),
	@SGSTAmount decimal(10,2),
	@IncludingTaxAmt decimal(10,2),
	@AmountReceived decimal(10,2),
	@ReceivedRemarks nvarchar(max),
	@BalanceAmount decimal(10,2),
	@UserName nvarchar(150),
	@Remarks nvarchar(max)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	Begin Try
	 BEGIN TRANSACTION
			declare @SaleID varchar(10), @char char(1), @code int
				select @SaleID = UniqueCode, @char=CharRange, @code=UpdatedSlNo from dbo.udfUtilEightCharacterKey('utblSaleInvoiceKeys')

				Set @BalanceAmount=@IncludingTaxAmt-@AmountReceived
			
			----------- Insert utblStkProcurementKeys Table-------------------------
			Insert into utblSaleInvoiceKeys 
				(SaleInvoiceID,InvoiceTo,ProjectID,VenderID,OrderNo,OrderDate,InvoiceDate,ReferenceNo,ExcludingTaxAmt,IGSTAmount,CGSTAmount,SGSTAmount,IncludingTaxAmt,AdvanceReceived,ReceivedRemarks,BalanceAmount,Remarks,UserID,LastModifiedOn) 
				VAlues
				(@SaleID,@InvoiceTo,@ProjectID,@VenderID,@OrderNo,@OrderDate,@InvoiceDate,@ReferenceNo,@ExcludingTaxAmt,@IGSTAmount,@CGSTAmount,@SGSTAmount,@IncludingTaxAmt,@AmountReceived,@ReceivedRemarks,@BalanceAmount,@Remarks,@UserName,GETDATE())
			
				insert into utblSaleInvoiceItems (ItemDtlID,SaleInvoiceID,ItemName,ItemHSNCode,GSTPercentage,IGSTPercentage ,CGSTPercentage,SGSTPercentage,Qty,Rate,Amount,SequenceNo)
				(Select NEWID(),@SaleID,ItemName,ItemHSNCode,GSTPercentage,IGSTPercentage,CGSTPercentage,SGSTPercentage,Qty,Rate,(Qty*Rate),ROW_NUMBER() over (order by (Select NULL)) from @ItemDtlsList)
				
				update utblMstReferenceNumbers set StartNo+=1, CurrentNo+=1 where FiscalYearSymbol=SUBSTRING(@ReferenceNo,4,7)

				------------------------End ---------------------------------------------

		-------------------------Update Cood Seed Table	----------------------------------------------
		if(@code=999 and @char='Z')
			update utblMstGenCodeSeeds set CharRange='A', StartRange=1 where TableName='utblSaleInvoiceKeys'
		else if(@code=999)
			update utblMstGenCodeSeeds set CharRange=CHAR(ASCII(@char)+1), StartRange=1 where TableName='utblSaleInvoiceKeys'
		else
			update utblMstGenCodeSeeds set StartRange=@code where TableName='utblSaleInvoiceKeys'

		set @error_number = 0
        set @ErMessage = 'Success: Data Added Succesfully !'

	 COMMIT TRANSACTION
	End Try

	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage
END



GO

IF OBJECT_ID('[udspSaleInvoiceUpdate]', 'P') IS NOT NULL DROP PROCEDURE [udspSaleInvoiceUpdate];
GO

-- =============================================
-- Author:		<Rakib Alam>
-- Create date: <2020-07-25>
-- Description:	<Update Sale Invoice Details>
-- =============================================
CREATE  PROCEDURE [dbo].[udspSaleInvoiceUpdate]
	-- Add the parameters for the stored procedure here
	@SaleInvoiceID varchar(8),
	@ItemDtlsList AddItemDtlsTVP ReadOnly,
	@InvoiceTo nvarchar(100),
	@ProjectID bigint,
	@VenderID bigint,
	@OrderNo nvarchar(200),
	@OrderDate datetime,
	@InvoiceDate datetime,
	@ReferenceNo varchar(25),
	@ExcludingTaxAmt decimal(10,2),
	@IGSTAmount decimal(10,2),
	@CGSTAmount decimal(10,2),
	@SGSTAmount decimal(10,2),
	@IncludingTaxAmt decimal(10,2),
	@AmountReceived decimal(10,2),
	@ReceivedRemarks nvarchar(max),
	@BalanceAmount decimal(10,2),
	@UserName nvarchar(150),
	@Remarks nvarchar(max)
AS
BEGIN
	DECLARE   @error_number INT, @ErMessage NVARCHAR(2048), @ErSeverity INT, @ErState INT
	Begin Try
	 BEGIN TRANSACTION

			----------- Delete utblSaleInvoiceItems Table-------------------------
			Delete from utblSaleInvoiceItems where SaleInvoiceID=@SaleInvoiceID
			--declare @AmtRecv decimal(10,2)=0.0
			--	select @AmtRecv = AdvanceReceived from utblSaleInvoiceKeys where SaleInvoiceID=@SaleInvoiceID
			--	Set @BalanceAmount=@IncludingTaxAmt-@AmtRecv
			--	set @AmountReceived=@AmtRecv
			Set @BalanceAmount=@IncludingTaxAmt-@AmountReceived
			----------- Insert utblStkProcurementKeys Table-------------------------
			Update utblSaleInvoiceKeys Set
			InvoiceTo =@InvoiceTo,
			ProjectID=@ProjectID,
			VenderID=@VenderID,
			OrderNo=@OrderNo,
			OrderDate=@OrderDate,
			InvoiceDate=@InvoiceDate,
			ExcludingTaxAmt=@ExcludingTaxAmt,
			IGSTAmount=@IGSTAmount,
			CGSTAmount=@CGSTAmount,
			SGSTAmount=@SGSTAmount,
			IncludingTaxAmt=@IncludingTaxAmt,
			AdvanceReceived=@AmountReceived,
			ReceivedRemarks=@ReceivedRemarks,
			BalanceAmount=@BalanceAmount,
			UserID=@UserName,
			Remarks=@Remarks,
			LastModifiedOn=GETDATE() where SaleInvoiceID=@SaleInvoiceID
			
			insert into utblSaleInvoiceItems (ItemDtlID,SaleInvoiceID,ItemName,ItemHSNCode,GSTPercentage,IGSTPercentage ,CGSTPercentage,SGSTPercentage,Qty,Rate,Amount,SequenceNo)
				(Select NEWID(),@SaleInvoiceID,ItemName,ItemHSNCode,GSTPercentage,IGSTPercentage,CGSTPercentage,SGSTPercentage,Qty,Rate,(Qty*Rate),ROW_NUMBER() over (order by (Select NULL)) from @ItemDtlsList)
			------------------------End ---------------------------------------------

		set @error_number = 0
        set @ErMessage = 'Success: Data Update Succesfully !'

	 COMMIT TRANSACTION
	End Try

	BEGIN CATCH  
		SELECT @error_number = ERROR_NUMBER(), @ErMessage = ERROR_MESSAGE(),  @ErSeverity = ERROR_SEVERITY(), @ErState = ERROR_STATE()  
		IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION
		IF @error_number = 2627 -- check constraint violation   
			BEGIN
				set @error_number = 2627    
				set @ErMessage = 'Error: Cannot insert duplicate record: Unit already exists, please check list.'
			END  
		ELSE -- some other "untrapped" error has occured   
		BEGIN 
			RAISERROR (@ErMessage, @ErSeverity, @ErState)
		END 
	END CATCH
	select @ErMessage
END



GO

-- ==========================================================
-- TABLE DATA INSERTS
-- ==========================================================
-- Data for table: [AspNetRoles] (4 rows)
INSERT INTO [AspNetRoles] ([Id], [Name]) VALUES (N'aadb2212-53fb-4e12-808a-d91b3cb59adc', N'Accountant');
INSERT INTO [AspNetRoles] ([Id], [Name]) VALUES (N'92f941ac-698e-4b22-b980-a09a7f6521e8', N'Admin');
INSERT INTO [AspNetRoles] ([Id], [Name]) VALUES (N'ba62e855-7c2c-4141-9fb9-46a532b30dd9', N'Employee');
INSERT INTO [AspNetRoles] ([Id], [Name]) VALUES (N'a1a9c18a-e321-4a47-a139-a7e0fbbb525e', N'Super Admin');
GO

-- Data for table: [AspNetUserRoles] (4 rows)
INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'436B4CD4-2FDE-47C6-9C67-F4726BDCA980', N'a1a9c18a-e321-4a47-a139-a7e0fbbb525e');
INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'609e7abb-8e95-4d26-8785-30dec51837fa', N'ba62e855-7c2c-4141-9fb9-46a532b30dd9');
INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'b326e02b-fbb9-419f-8a9d-4965631549d1', N'aadb2212-53fb-4e12-808a-d91b3cb59adc');
INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'e863cff0-f303-4d22-85df-61a6b11e38c9', N'a1a9c18a-e321-4a47-a139-a7e0fbbb525e');
GO

-- Data for table: [AspNetUsers] (4 rows)
INSERT INTO [AspNetUsers] ([Id], [Role], [EmployeeID], [IsActive], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'436B4CD4-2FDE-47C6-9C67-F4726BDCA980', N'Super Admin', N'E00A0000', 1, N'admin@sdk.com', 1, N'AQAAAAIAAYagAAAAEFRp1KZYVMHgyCy8zhWeD1xe1Wyx5Lx/AdWQB69rK0hYsM9iDi8CiqbAvbk3cacn3w==', N'EWX7H5JUS2VK7Y4VTZL47J4ML5Z62MGD', NULL, 0, 0, NULL, 0, 0, N'admin');
INSERT INTO [AspNetUsers] ([Id], [Role], [EmployeeID], [IsActive], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'609e7abb-8e95-4d26-8785-30dec51837fa', N'Employee', N'E23A0001', 1, N'manoj@sdksolution.co.in', 1, N'ADnzKnb1OY6uzdLEEeee6GyMK/muUD8z3975ky7qZH6sE3fs68Povgi2UYDgUe3NJQ==', N'd787b57f-c99c-4b3b-a83f-caed970fefe0', NULL, 0, 0, NULL, 0, 0, N'manoj@sdksolution.co.in');
INSERT INTO [AspNetUsers] ([Id], [Role], [EmployeeID], [IsActive], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'b326e02b-fbb9-419f-8a9d-4965631549d1', N'Accountant', N'E23A0002', 1, N'kabita.tamang@netspeq.com', 1, N'ADnzKnb1OY6uzdLEEeee6GyMK/muUD8z3975ky7qZH6sE3fs68Povgi2UYDgUe3NJQ==', N'ee510af4-4cb5-46ac-b7bb-65f7bcf782b6', NULL, 0, 0, NULL, 0, 0, N'kabita.tamang@netspeq.com');
INSERT INTO [AspNetUsers] ([Id], [Role], [EmployeeID], [IsActive], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'e863cff0-f303-4d22-85df-61a6b11e38c9', N'Super Admin', N'E20A0000', 1, N'alikabir20@gmail.com', 1, N'ADnzKnb1OY6uzdLEEeee6GyMK/muUD8z3975ky7qZH6sE3fs68Povgi2UYDgUe3NJQ==', N'a04ffadd-1c99-4f16-8059-4ec2460e00a9', NULL, 0, 0, NULL, 0, 0, N'alikabir20@gmail.com');
GO

-- Data for table: [utblDirectPayments] (3 rows)
SET IDENTITY_INSERT [utblDirectPayments] ON;
INSERT INTO [utblDirectPayments] ([DirectPaymentID], [ExpenseTypeID], [ProjectID], [PaymentDate], [PaymentAmt], [IsDeclined], [Purpose], [Remarks], [Status], [AddedBy], [AddedOn]) VALUES (1, 6, 2, '2024-09-27 00:00:00.000', 100000.0000, 0, N'BD payment to STCS for Bio Toilet Project.', N'BD payment to STCS for Bio Toilet Project.', N'Settled', N'kabita.tamang@netspeq.com', '2024-10-03 15:39:39.873');
INSERT INTO [utblDirectPayments] ([DirectPaymentID], [ExpenseTypeID], [ProjectID], [PaymentDate], [PaymentAmt], [IsDeclined], [Purpose], [Remarks], [Status], [AddedBy], [AddedOn]) VALUES (2, 7, NULL, '2024-10-13 00:00:00.000', 20000.0000, 0, N'Salary payment to MD Raja.', N'Salary payment to MD Raja.', N'Approved', N'kabita.tamang@netspeq.com', '2024-10-17 11:03:53.463');
INSERT INTO [utblDirectPayments] ([DirectPaymentID], [ExpenseTypeID], [ProjectID], [PaymentDate], [PaymentAmt], [IsDeclined], [Purpose], [Remarks], [Status], [AddedBy], [AddedOn]) VALUES (3, 8, NULL, '2024-10-23 00:00:00.000', 50000.0000, 0, N'Being Fund transfer to Sabir Sir.', N'Being Fund transfer to Sabir Sir.', N'Approved', N'kabita.tamang@netspeq.com', '2024-11-06 12:17:00.813');
SET IDENTITY_INSERT [utblDirectPayments] OFF;
GO

-- Data for table: [utblEmpPersonalInfoKeys] (2 rows)
INSERT INTO [utblEmpPersonalInfoKeys] ([EmployeeID], [FName], [MName], [LName], [DateOfBirth], [Gender], [Nationality], [MaritalStatus], [Religion], [BloodGroup], [PhoneNumber], [Email], [PanNo], [AadharNo], [PresentAddress], [EmgContactName], [EmgContactNo], [EmgContactAddress], [PhotoNormal], [PhotoThumb], [UserID], [LastModifiedOn], [JoinDate]) VALUES (N'E23A0001', N'Mon', N'Bhadur', N'Chettri', '1994-10-09 00:00:00.000', N'Male', N'Indian', N'Married', N'Hinduism', N'O+(ve)', N'9064533893', N'manoj@sdksolution.co.in', N'', N'', N'Tadong Gangtok Sikkim 737102', N'', N'', N'Tadong Gangtok Sikkim 737102', N'', N'', N'alikabir20@gmail.com', '2023-07-07 10:53:07.560', '2023-07-07 10:53:07.560');
INSERT INTO [utblEmpPersonalInfoKeys] ([EmployeeID], [FName], [MName], [LName], [DateOfBirth], [Gender], [Nationality], [MaritalStatus], [Religion], [BloodGroup], [PhoneNumber], [Email], [PanNo], [AadharNo], [PresentAddress], [EmgContactName], [EmgContactNo], [EmgContactAddress], [PhotoNormal], [PhotoThumb], [UserID], [LastModifiedOn], [JoinDate]) VALUES (N'E23A0002', N'Kabita', N'', N'Tamang', '1998-12-13 00:00:00.000', N'Female', N'Indian', N'Single', N'Buddhism', N'O+(ve)', N'8617561934', N'kabita.tamang@netspeq.com', N'', N'', N'Middle Syari, Gangtok', N'', N'', N'', N'', N'', N'alikabir20@gmail.com', '2023-07-07 11:13:12.177', '2023-07-07 11:13:12.177');
GO

-- Data for table: [utblMstBanks] (33 rows)
SET IDENTITY_INSERT [utblMstBanks] ON;
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (1, N'State Bank of India
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (2, N'Central Bank of India
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (3, N'UCO Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (4, N'Canara Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (5, N'Vijaya Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (6, N'Bank of Baroda
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (7, N'Bank of India
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (8, N'Union Bank of India
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (9, N'Punjab National Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (10, N'Oriental Bank of Comm.
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (11, N'Corporation Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (12, N'IDBI Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (13, N'Allahabad Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (14, N'United Bank of India
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (15, N'Indian Overseas Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (16, N'Syndicate Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (17, N'Andhra Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (18, N'Indian Bank');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (19, N'Dena Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (20, N'Bank of Maharashtra
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (21, N'Punjab & Sind Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (22, N'AXIS Bank Ltd.
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (23, N'HDFC Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (24, N'IndusInd Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (25, N'ICICI Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (26, N'Yes Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (27, N'Kotak Mahindra Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (28, N'South Indian Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (29, N'Bandhan Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (30, N'Karnataka Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (31, N'SISCO Bank
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (32, N'State Bank of Sikkim
');
INSERT INTO [utblMstBanks] ([BankID], [BankName]) VALUES (33, N'IDFC Bank');
SET IDENTITY_INSERT [utblMstBanks] OFF;
GO

-- Data for table: [utblMstExpenseTypes] (8 rows)
SET IDENTITY_INSERT [utblMstExpenseTypes] ON;
INSERT INTO [utblMstExpenseTypes] ([ExpenseTypeID], [ExpenseType], [Description], [IsProjectRelated], [CanReceiveDirectPayment], [OpeningAmount], [OpeningDate], [UserID], [LastModifiedOn]) VALUES (1, N'OFFICE EXPENSES', N'All the expenses incurred for the office.', 0, 0, NULL, NULL, N'alikabir20@gmail.com', '2024-08-31 14:21:02.600');
INSERT INTO [utblMstExpenseTypes] ([ExpenseTypeID], [ExpenseType], [Description], [IsProjectRelated], [CanReceiveDirectPayment], [OpeningAmount], [OpeningDate], [UserID], [LastModifiedOn]) VALUES (2, N'PROJECT EXPESNES', N'EXPENSES RELATED TO PROJECT', 1, 0, NULL, NULL, N'alikabir20@gmail.com', '2024-08-31 14:22:03.417');
INSERT INTO [utblMstExpenseTypes] ([ExpenseTypeID], [ExpenseType], [Description], [IsProjectRelated], [CanReceiveDirectPayment], [OpeningAmount], [OpeningDate], [UserID], [LastModifiedOn]) VALUES (3, N'TAXES AND GST PAYMENT', N'ALL THE TAXES AND GST PAYMENT FOR THE COMPANY', 0, 0, NULL, NULL, N'alikabir20@gmail.com', '2024-08-31 14:21:52.477');
INSERT INTO [utblMstExpenseTypes] ([ExpenseTypeID], [ExpenseType], [Description], [IsProjectRelated], [CanReceiveDirectPayment], [OpeningAmount], [OpeningDate], [UserID], [LastModifiedOn]) VALUES (4, N'Transportation Charges.', N'Transportation Charges.', 0, 0, NULL, NULL, N'kabita.tamang@netspeq.com', '2024-09-04 15:07:14.950');
INSERT INTO [utblMstExpenseTypes] ([ExpenseTypeID], [ExpenseType], [Description], [IsProjectRelated], [CanReceiveDirectPayment], [OpeningAmount], [OpeningDate], [UserID], [LastModifiedOn]) VALUES (5, N'SDK Solution Gangtok Loan A/c.', N'SDK Solution Gangtok Loan A/c.', 0, 0, NULL, NULL, N'kabita.tamang@netspeq.com', '2024-10-03 15:03:09.677');
INSERT INTO [utblMstExpenseTypes] ([ExpenseTypeID], [ExpenseType], [Description], [IsProjectRelated], [CanReceiveDirectPayment], [OpeningAmount], [OpeningDate], [UserID], [LastModifiedOn]) VALUES (6, N'BUSINESS DEVELOPMENT (DEPARTMENTAL & PROJECT)', N'BUSINESS DEVELOPMENT (DEPARTMENTAL & PROJECT)', 0, 0, NULL, NULL, N'kabita.tamang@netspeq.com', '2024-10-03 15:38:05.793');
INSERT INTO [utblMstExpenseTypes] ([ExpenseTypeID], [ExpenseType], [Description], [IsProjectRelated], [CanReceiveDirectPayment], [OpeningAmount], [OpeningDate], [UserID], [LastModifiedOn]) VALUES (7, N'Salary & Allowance', N'Salary & Allowance', 0, 0, NULL, NULL, N'kabita.tamang@netspeq.com', '2024-10-17 11:02:50.003');
INSERT INTO [utblMstExpenseTypes] ([ExpenseTypeID], [ExpenseType], [Description], [IsProjectRelated], [CanReceiveDirectPayment], [OpeningAmount], [OpeningDate], [UserID], [LastModifiedOn]) VALUES (8, N'Proprietor Drawings A/c.', N'Proprietor Drawings A/c.', 0, 0, NULL, NULL, N'kabita.tamang@netspeq.com', '2024-11-06 12:15:34.163');
SET IDENTITY_INSERT [utblMstExpenseTypes] OFF;
GO

-- Data for table: [UtblMstFinancialYears] (3 rows)
SET IDENTITY_INSERT [UtblMstFinancialYears] ON;
INSERT INTO [UtblMstFinancialYears] ([FiscalID], [StartDate], [EndDate], [FiscalYearSymbol], [Active]) VALUES (2, '2023-03-01 00:00:00.000', '2024-03-31 00:00:00.000', N'2023-24', 0);
INSERT INTO [UtblMstFinancialYears] ([FiscalID], [StartDate], [EndDate], [FiscalYearSymbol], [Active]) VALUES (1, '2024-04-01 00:00:00.000', '2025-03-31 00:00:00.000', N'2024-25', 0);
INSERT INTO [UtblMstFinancialYears] ([FiscalID], [StartDate], [EndDate], [FiscalYearSymbol], [Active]) VALUES (3, '2025-04-01 00:00:00.000', '2026-03-31 00:00:00.000', N'2025-26', 1);
SET IDENTITY_INSERT [UtblMstFinancialYears] OFF;
GO

-- Data for table: [utblMstGenCodeSeeds] (3 rows)
SET IDENTITY_INSERT [utblMstGenCodeSeeds] ON;
INSERT INTO [utblMstGenCodeSeeds] ([SLNO], [Year], [CharRange], [StartRange], [TableName]) VALUES (2, 24, N'A', 106, N'utblSaleInvoiceKeys');
INSERT INTO [utblMstGenCodeSeeds] ([SLNO], [Year], [CharRange], [StartRange], [TableName]) VALUES (3, 24, N'A', 38, N'utblPurchaseInvoiceKeys');
INSERT INTO [utblMstGenCodeSeeds] ([SLNO], [Year], [CharRange], [StartRange], [TableName]) VALUES (4, 24, N'A', 1, N'utblPaymentDetails');
SET IDENTITY_INSERT [utblMstGenCodeSeeds] OFF;
GO

-- Data for table: [utblMstProjects] (15 rows)
SET IDENTITY_INSERT [utblMstProjects] ON;
INSERT INTO [utblMstProjects] ([ProjectID], [ProjectName], [VendorID], [ProjStartDate], [ProjEndDate], [ProjStatus], [ProjValue], [ProjDescription], [WODate], [WONo], [WOPath], [PCCPath]) VALUES (1, N'SUPPLY OF SAFETY AND SECURITY ITEMS', 2, '2024-03-29 00:00:00.000', NULL, N'Open', 3058973.0000, N'SUPPLY OF ITEMS TO DIFFERENT LOCATION. DELIVERY AS PER ACTUAL AND INSTALLATION IS ALSO AS PER ACTUAL', '2024-03-29 00:00:00.000', N'SDK/2023-24/114/PO', N'90c894ef-0eb6-4386-87a9-57dedce7a121.pdf', NULL);
INSERT INTO [utblMstProjects] ([ProjectID], [ProjectName], [VendorID], [ProjStartDate], [ProjEndDate], [ProjStatus], [ProjValue], [ProjDescription], [WODate], [WONo], [WOPath], [PCCPath]) VALUES (2, N'SUPPLY OF FRP BIO TOILET', 3, '2024-04-12 00:00:00.000', NULL, N'Open', 7611844.0000, N'SUPPLY OF FRP BIO TOILET WITH CHEMICAL AND PVC PIPE AND WATER TANK 1000 LTR', '2024-04-12 00:00:00.000', N'TE/2024-25/01', N'45eabb87-5945-4123-86e1-11d6f6140f09.pdf', NULL);
INSERT INTO [utblMstProjects] ([ProjectID], [ProjectName], [VendorID], [ProjStartDate], [ProjEndDate], [ProjStatus], [ProjValue], [ProjDescription], [WODate], [WONo], [WOPath], [PCCPath]) VALUES (3, N'PURCHASE OF WIN PRO FOR ICT', 6, '2024-04-11 00:00:00.000', NULL, N'Open', 70750.0000, N'PURCHASE OF WIN OS FOR NETSPEQ SOLUTION FOR ICT LABS', NULL, NULL, NULL, NULL);
INSERT INTO [utblMstProjects] ([ProjectID], [ProjectName], [VendorID], [ProjStartDate], [ProjEndDate], [ProjStatus], [ProjValue], [ProjDescription], [WODate], [WONo], [WOPath], [PCCPath]) VALUES (4, N'OFFICE ASSET/ OFFICE DEVELOPMENT SILIGURI', 2, '2024-03-30 00:00:00.000', NULL, N'Open', 0.0000, N'ITEMS PURCHASE FOR OFFICE DEVELOPMENT ', NULL, NULL, NULL, NULL);
INSERT INTO [utblMstProjects] ([ProjectID], [ProjectName], [VendorID], [ProjStartDate], [ProjEndDate], [ProjStatus], [ProjValue], [ProjDescription], [WODate], [WONo], [WOPath], [PCCPath]) VALUES (7, N'Supply of Laptops for PM Shri School (Atal Tinkering Lab 8 PM Shri School)', 9, '2024-10-01 00:00:00.000', '2025-03-19 00:00:00.000', N'Closed', 372880.0000, N'Purchase Order for 8 Laptops', '2024-10-01 00:00:00.000', N'RTI/2024-25/02', N'273d6d45-fc25-4401-a55b-09b1ace8e4c4.pdf', NULL);
INSERT INTO [utblMstProjects] ([ProjectID], [ProjectName], [VendorID], [ProjStartDate], [ProjEndDate], [ProjStatus], [ProjValue], [ProjDescription], [WODate], [WONo], [WOPath], [PCCPath]) VALUES (8, N'SUPPLY OF FRP WESTERN BIO TOILET PHASE (II) 35 SCHOOLS 2024-25', 3, '2024-12-21 00:00:00.000', NULL, N'Open', 8594461.0000, N'SUPPLY OF BIO TOILET FOR 35 SCHOOL UNDER SAMAGRA SHIKSHA FOR PHASE II', '2024-12-21 00:00:00.000', NULL, NULL, NULL);
INSERT INTO [utblMstProjects] ([ProjectID], [ProjectName], [VendorID], [ProjStartDate], [ProjEndDate], [ProjStatus], [ProjValue], [ProjDescription], [WODate], [WONo], [WOPath], [PCCPath]) VALUES (9, N'Supply of 494 600 VA UPS', 6, '2024-12-24 00:00:00.000', '2025-03-19 00:00:00.000', N'Closed', 846945.0000, N'Supply of 494 600 VA UPS', '2024-12-24 00:00:00.000', N'NS/PO/155/2024-25', N'bf3bcf60-ac9a-491a-9d52-75d62d71c43f.pdf', NULL);
INSERT INTO [utblMstProjects] ([ProjectID], [ProjectName], [VendorID], [ProjStartDate], [ProjEndDate], [ProjStatus], [ProjValue], [ProjDescription], [WODate], [WONo], [WOPath], [PCCPath]) VALUES (10009, N'Western Bio-Toilet 2024-25 (Purchase Return)', 5, '2025-02-08 00:00:00.000', NULL, N'Open', 34000.0000, N'1nos of damaged bio-toilet return.', NULL, NULL, NULL, NULL);
INSERT INTO [utblMstProjects] ([ProjectID], [ProjectName], [VendorID], [ProjStartDate], [ProjEndDate], [ProjStatus], [ProjValue], [ProjDescription], [WODate], [WONo], [WOPath], [PCCPath]) VALUES (10010, N'SUPPLY OF OPS HDD UPS AND ANTI VIRUS FOR PM SHRI', 6, '2025-03-17 00:00:00.000', NULL, N'Open', 1500000.0000, N'Supply OPS, HDDs, UPS systems, and antivirus software for PM Shri School', NULL, NULL, NULL, NULL);
INSERT INTO [utblMstProjects] ([ProjectID], [ProjectName], [VendorID], [ProjStartDate], [ProjEndDate], [ProjStatus], [ProjValue], [ProjDescription], [WODate], [WONo], [WOPath], [PCCPath]) VALUES (10011, N'Supply of Fire Extinguisher for Samagra Shiksha Education Department', 2, '2025-03-17 00:00:00.000', NULL, N'Open', 1300000.0000, N'Supply of 474 6 kg ABC MAP Powder-Based Fire Extinguisher for Schools', NULL, NULL, NULL, NULL);
INSERT INTO [utblMstProjects] ([ProjectID], [ProjectName], [VendorID], [ProjStartDate], [ProjEndDate], [ProjStatus], [ProjValue], [ProjDescription], [WODate], [WONo], [WOPath], [PCCPath]) VALUES (10012, N'Supply of Musical Instrument for 43 PM Shri Schools', 11, '2025-03-17 00:00:00.000', NULL, N'Open', 4000000.0000, N'Supply of Musical Instrument for 43 PM Shri Schools', NULL, NULL, NULL, NULL);
INSERT INTO [utblMstProjects] ([ProjectID], [ProjectName], [VendorID], [ProjStartDate], [ProjEndDate], [ProjStatus], [ProjValue], [ProjDescription], [WODate], [WONo], [WOPath], [PCCPath]) VALUES (10013, N'Software (Wi 10 ) SDK .', 2, '2025-03-24 00:00:00.000', NULL, N'Open', 531.0000, N'Software (Wi 10 ) SDK .', '2025-03-24 00:00:00.000', NULL, NULL, NULL);
INSERT INTO [utblMstProjects] ([ProjectID], [ProjectName], [VendorID], [ProjStartDate], [ProjEndDate], [ProjStatus], [ProjValue], [ProjDescription], [WODate], [WONo], [WOPath], [PCCPath]) VALUES (10014, N'Supply of Computer & Accesories (FOR SSLS)', 2, '2025-03-30 00:00:00.000', NULL, N'Open', 0.0000, N'Supply of Computer & Accesories to SDK Solution Gangtok.', '2025-03-30 00:00:00.000', NULL, NULL, NULL);
INSERT INTO [utblMstProjects] ([ProjectID], [ProjectName], [VendorID], [ProjStartDate], [ProjEndDate], [ProjStatus], [ProjValue], [ProjDescription], [WODate], [WONo], [WOPath], [PCCPath]) VALUES (10015, N'Supply of Laptops and Printer for Forest Project', 6, '2025-05-03 00:00:00.000', NULL, N'Open', 2229020.0000, N'Supply of Forest items for Netspeq Solution', NULL, NULL, NULL, NULL);
INSERT INTO [utblMstProjects] ([ProjectID], [ProjectName], [VendorID], [ProjStartDate], [ProjEndDate], [ProjStatus], [ProjValue], [ProjDescription], [WODate], [WONo], [WOPath], [PCCPath]) VALUES (10016, N'SUPPLY OF COMPUTER, PRINTER AND ITS PERIPHERALS FOR DIRECTOR EXAM EDUCATION DEPARTMENT', 2, '2025-04-01 00:00:00.000', NULL, N'Open', 205917.0000, N'SUPPLY OF COMPUTER, PRINTER AND ITS PERIPHERALS FOR DIRECTOR EXAM EDUCATION DEPARTMENT', NULL, NULL, NULL, NULL);
SET IDENTITY_INSERT [utblMstProjects] OFF;
GO

-- Data for table: [utblMstReferenceNumbers] (2 rows)
SET IDENTITY_INSERT [utblMstReferenceNumbers] ON;
INSERT INTO [utblMstReferenceNumbers] ([RefID], [FiscalYearSymbol], [Prefix], [Suffix], [StartNo], [CurrentNo]) VALUES (1, N'2024-25', N'SS', N'INV', 100, 100);
INSERT INTO [utblMstReferenceNumbers] ([RefID], [FiscalYearSymbol], [Prefix], [Suffix], [StartNo], [CurrentNo]) VALUES (2, N'2025-26', N'SS', N'INV', 5, 5);
SET IDENTITY_INSERT [utblMstReferenceNumbers] OFF;
GO

-- Data for table: [utblMstVendorDetails] (13 rows)
SET IDENTITY_INSERT [utblMstVendorDetails] ON;
INSERT INTO [utblMstVendorDetails] ([VenderID], [VenderName], [VenderAddress], [GSTNo], [ContactName], [Email], [ContactNo], [UserID], [LastModifiedOn]) VALUES (1, N'BUY4M', N'28/1 NAZRUL SARANI, ASHRAM PARA, SILIGURI-734001', N'19AKPPD3747E1Z1', N'Sameer Das', N'teambuy4m@gmail.com', N'8370997985', N'alikabir20@gmail.com', '2024-06-04 12:42:37.480');
INSERT INTO [utblMstVendorDetails] ([VenderID], [VenderName], [VenderAddress], [GSTNo], [ContactName], [Email], [ContactNo], [UserID], [LastModifiedOn]) VALUES (2, N'SDK Solution', N'DARAGAON, TADONG, GANGTOK SIKKIM-737102 ', N'11CPEPA3234H1ZN', N'Kabita Tamang', N'sdksolutiongtk@gmail.com', N'9641960590', N'alikabir20@gmail.com', '2024-06-04 12:44:03.573');
INSERT INTO [utblMstVendorDetails] ([VenderID], [VenderName], [VenderAddress], [GSTNo], [ContactName], [Email], [ContactNo], [UserID], [LastModifiedOn]) VALUES (3, N'TENPEL EMPORIUM', N'01, Near Umesh Agarwal Residence, Mahatma Gandhi Marg, Titan Eye Plus,
Vishal Gaon, Gangtok, Gangtok, Sikkim', N'11CVRPB3879C1ZO', N'TENZING PELBAR BHUTIA	', N'tenzingpelbar797@gmail.com', N'7432043682', N'alikabir20@gmail.com', '2024-06-04 12:52:07.993');
INSERT INTO [utblMstVendorDetails] ([VenderID], [VenderName], [VenderAddress], [GSTNo], [ContactName], [Email], [ContactNo], [UserID], [LastModifiedOn]) VALUES (4, N'Forever Poly Products', N'Bholanath Para, PS Bhaktinagar, 
Near Gas Godawan, PO Ghogomali, 
Jalpaiguri, Telipara, Siliguri, 
West Bengal, India, 734006
', N'19AAHFF0553E1ZN', N'Sandeep Agarwal', N'foreverpolyproducts@gmail.com', N'8918416475', N'alikabir20@gmail.com', '2024-06-04 12:48:37.910');
INSERT INTO [utblMstVendorDetails] ([VenderID], [VenderName], [VenderAddress], [GSTNo], [ContactName], [Email], [ContactNo], [UserID], [LastModifiedOn]) VALUES (5, N'JRMS Engineering Works', N'Nutanhat Kazi Para P.S Sonarpur, PO Bonhoogly Kolkata- 700103', N'19BJTPP9944F1Z9', N'Raja', N'info@jrmseng.com', N'9830090898', N'alikabir20@gmail.com', '2024-06-04 12:51:08.610');
INSERT INTO [utblMstVendorDetails] ([VenderID], [VenderName], [VenderAddress], [GSTNo], [ContactName], [Email], [ContactNo], [UserID], [LastModifiedOn]) VALUES (6, N'NETSPEQ SOLUTIONS', N'First Floor, SNOD Complex, Near SNOD Petrol Pump, NH 10, Deorali, Gangtok, Gangtok, Sikkim, 737102', N'11BCCPB6050L2Z2', N'Karma L Bhutia', N'admin@netspeq.com', N'9832034979', N'kabita.tamang@netspeq.com', '2024-09-05 14:54:38.797');
INSERT INTO [utblMstVendorDetails] ([VenderID], [VenderName], [VenderAddress], [GSTNo], [ContactName], [Email], [ContactNo], [UserID], [LastModifiedOn]) VALUES (7, N'Bimal Adhikari', N'2, HN 100, Adhikari Buidlin, Tareythang Busty, Tareythang Pakyong, Gangtok, Sikkim, 737106', N'11BOXPA1748F1Z4', N'Bimal Adhikari', N'adhibimalgtk@gmail.com', N'9382064281', N'alikabir20@gmail.com', '2024-06-04 12:59:15.393');
INSERT INTO [utblMstVendorDetails] ([VenderID], [VenderName], [VenderAddress], [GSTNo], [ContactName], [Email], [ContactNo], [UserID], [LastModifiedOn]) VALUES (8, N'SIGN INK', N'30A, Canal East Road
Kolkata - 700 011
Phone : 033 23600243
GSTIN/UIN: 19ABJFS9303C1Z4
State Name :  WestBengal
', N'19ABJFS9303C1Z4', N'Bhanu Da', N'signink.kolkata@gmail.com', N'03323600243', N'alikabir20@gmail.com', '2024-07-05 14:21:48.770');
INSERT INTO [utblMstVendorDetails] ([VenderID], [VenderName], [VenderAddress], [GSTNo], [ContactName], [Email], [ContactNo], [UserID], [LastModifiedOn]) VALUES (9, N'Rudra Trade Impex', N'DEVELOPMENT AREA MW, JEEWAN THEENG MARG, DEVELOPMENT AREA ROAD, GANGTOK, Gangtok, Sikkim, 737101', N'11BMFPC5256C1ZR', N'Rudra Chettri	', N'', N'9775968778', N'alikabir20@gmail.com', '2024-10-01 12:35:13.137');
INSERT INTO [utblMstVendorDetails] ([VenderID], [VenderName], [VenderAddress], [GSTNo], [ContactName], [Email], [ContactNo], [UserID], [LastModifiedOn]) VALUES (10, N'M/s Shree Balaji Furniture', N'First Floor, Building 145/1 opposit Post Office Ranipool Forest Block.', N'11BJCPB8473N1ZS', N'', N'', N'', N'kabita.tamang@netspeq.com', '2024-12-21 12:41:27.487');
INSERT INTO [utblMstVendorDetails] ([VenderID], [VenderName], [VenderAddress], [GSTNo], [ContactName], [Email], [ContactNo], [UserID], [LastModifiedOn]) VALUES (11, N'M/S Namcheybong', N'Floor No.: 3rd Floor, Building No./Flat No.: 217, IB Office Building, NH 10, Police Station, Ranipool Bazar, Gangtok, Sikkim-737135', N'11DKEPB3931E2Z', N'Karma Doma Bhutia', N'msnamcheybong@gmail.com', N'9434144007', N'alikabir20@gmail.com', '2025-03-17 20:02:55.097');
INSERT INTO [utblMstVendorDetails] ([VenderID], [VenderName], [VenderAddress], [GSTNo], [ContactName], [Email], [ContactNo], [UserID], [LastModifiedOn]) VALUES (12, N'Sandesh Travels', N'PAKYONG.', N'11AXXPR3863J1ZT', N'SANDESH RANA', N'', N'9647878373', N'kabita.tamang@netspeq.com', '2025-04-02 17:07:03.357');
INSERT INTO [utblMstVendorDetails] ([VenderID], [VenderName], [VenderAddress], [GSTNo], [ContactName], [Email], [ContactNo], [UserID], [LastModifiedOn]) VALUES (13, N'Balaji Transport Co.', N'Navin Sen Road, Siliguri.', N'19ADRPB3273G1ZF', N'-', N'', N'0353-2432029', N'kabita.tamang@netspeq.com', '2025-05-15 13:48:46.560');
SET IDENTITY_INSERT [utblMstVendorDetails] OFF;
GO

-- Data for table: [utblPaymentReceivables] (1 rows)
SET IDENTITY_INSERT [utblPaymentReceivables] ON;
INSERT INTO [utblPaymentReceivables] ([ReceivedID], [ExpenseTypeID], [AmtReceived], [ReceivedDate], [ReceivedMode], [BankID], [TransactionNo], [Remarks], [UploadedFile], [AddedBy], [AddedOn]) VALUES (1, 5, 100000.0000, '2024-09-27 00:00:00.000', N'Cash', NULL, NULL, N'Loan received from SDK Gangtok  (For Bio-toilet BD payment to STCS)', NULL, N'kabita.tamang@netspeq.com', '2024-10-03 15:36:22.150');
SET IDENTITY_INSERT [utblPaymentReceivables] OFF;
GO

-- Data for table: [utblPaymentReleasedTrans] (51 rows)
SET IDENTITY_INSERT [utblPaymentReleasedTrans] ON;
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (1, '2024-07-05 00:00:00.000', 83127.0000, N'Netbanking', N'PI24A021', NULL, 33, N'418714938054', N'39266a9b-092f-4d9c-9714-7b190d1f65d3.pdf', N'PAYMENT MADE FOR VINAL PRINTING FOR BIO TOILET ', N'alikabir20@gmail.com', '2024-07-05 15:00:35.783');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (2, '2024-05-20 00:00:00.000', 68000.0000, N'Netbanking', N'PI24A002', NULL, 33, N'414112807718', N'8b2daf77-1e0a-4aa9-a8cd-233418e992ca.pdf', N'1st Payment for Water Tank for ForEverPoly ', N'alikabir20@gmail.com', '2024-07-16 14:43:13.220');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (3, '2024-05-27 00:00:00.000', 101952.0000, N'Netbanking', N'PI24A002', NULL, 33, N'IDFBH24148363412', N'363f6bf0-69a2-41a5-b323-74e6e561fcca.pdf', N'Final Payment for Water Tank for Bio Toilet', N'alikabir20@gmail.com', '2024-07-16 14:45:01.010');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (4, '2024-05-06 00:00:00.000', 2073000.0000, N'Netbanking', N'PI24A001', NULL, 33, N'IDFBR52024050600653043', N'0e70b354-bc91-4248-99c0-e5982f09198e.pdf', N'30 PERCENT ADVANCE PAYMENT FOR BIO TOILET', N'alikabir20@gmail.com', '2024-07-16 14:53:52.067');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (5, '2024-05-17 00:00:00.000', 958930.0000, N'Netbanking', N'PI24A001', NULL, 33, N'IDFBH24138957850', N'0407b8df-3230-492b-acdf-cdfba6e5e816.pdf', N'2ND PART PAYMENT FOR BIO TOILET ', N'alikabir20@gmail.com', '2024-07-16 14:55:17.800');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (6, '2024-05-21 00:00:00.000', 996100.0000, N'Netbanking', N'PI24A001', NULL, 33, N'IDFBH24142541707', N'2e762e54-1fab-47e3-b4fb-86aed174b474.pdf', N'3RD PART PAYMENT FOR BIO TOILET INCLUDING TRANSPORTATION', N'alikabir20@gmail.com', '2024-07-16 14:58:12.457');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (7, '2024-05-27 00:00:00.000', 1353800.0000, N'Netbanking', N'PI24A001', NULL, 33, N'IDFBR52024052700479391', N'7bf3284b-c7f3-4147-9ed6-a26ba4d931c3.pdf', N'4th PART PAYMENT FOR BIO TOILET WITH TRANSPORTATION', N'alikabir20@gmail.com', '2024-07-16 15:00:09.343');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (8, '2024-06-01 00:00:00.000', 1307600.0000, N'Netbanking', N'PI24A001', NULL, 33, N'IDFBR52024060100565360', N'6b8beb70-0284-48ca-9c43-660443de3be3.pdf', N'5TH PART PAYMENT FOR BIO TOILET WITH TRANSPORTATION', N'alikabir20@gmail.com', '2024-07-16 15:01:41.670');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (9, '2024-06-07 00:00:00.000', 922670.0000, N'Netbanking', N'PI24A001', NULL, 33, N'IDFBR52024060700636787', N'eac0b781-ca22-4996-b707-1e18a429cf6b.pdf', N'FINAL PAYMENT MADE FOR BIO TOILET WITH TRANSPORTATION', N'alikabir20@gmail.com', '2024-07-16 15:03:11.000');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (10, '2024-04-09 00:00:00.000', 57537.0000, N'Netbanking', N'PI24A004', NULL, 33, N'IDFBH24100843415', N'35e56dc4-5129-4497-a9e2-cb1f8ecc63db.pdf', N'payment for purchase of Safety & security items to Buy4m.', N'kabita.tamang@netspeq.com', '2024-08-31 15:25:07.980');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (11, '2024-04-05 00:00:00.000', 1000000.0000, N'Netbanking', N'PI24A000', NULL, 33, N'IDFBH24096129662', N'65acda77-06e2-4fea-bebb-ffd4fbc6b3d8.pdf', N'Payment to Buy4m for purchase of safety & Security Items.', N'kabita.tamang@netspeq.com', '2024-08-31 15:41:32.133');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (12, '2024-04-09 00:00:00.000', 730000.0000, N'Netbanking', N'PI24A000', NULL, 33, N'IDFBR52024040900361737', N'f084b417-e133-4ed1-b35e-310a1a0aa825.pdf', N'Payment to Buy4m for purchase of safety & Security Items.', N'kabita.tamang@netspeq.com', '2024-08-31 15:44:55.300');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (13, '2024-06-07 00:00:00.000', 39128.0000, N'Netbanking', N'PI24A018', NULL, 33, N'415916747368', N'6c3cfc4a-ace2-44f4-b557-59d7f41d09da.pdf', N'Payment to Buy4M for purchase of Bio toilets items. (Bill. no: 24-25/127).', N'kabita.tamang@netspeq.com', '2024-08-31 16:57:34.827');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (14, '2024-06-07 00:00:00.000', 38891.0000, N'Netbanking', N'PI24A017', NULL, 33, N'415916747368', N'fa416780-3dcc-4c5c-a29e-ac5f938e21f4.pdf', N'Payment to Buy4M for purchase of Bio toilets items. (Bill no: 24-25/120).', N'kabita.tamang@netspeq.com', '2024-08-31 17:00:31.297');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (15, '2024-05-20 00:00:00.000', 34940.0000, N'Netbanking', N'PI24A012', NULL, 33, N'414117205100', NULL, N'payment for PVC PIPE PURCHASED FOR BIO TOILET.', N'kabita.tamang@netspeq.com', '2024-08-31 17:14:09.033');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (16, '2024-05-24 00:00:00.000', 41263.0000, N'Netbanking', N'PI24A015', NULL, 33, N'414510082764', N'713a01e5-1d1e-4786-a200-123b3342bf0b.pdf', N'Payment for purchase of BIO TOILET ITEMS ', N'kabita.tamang@netspeq.com', '2024-08-31 17:19:34.537');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (17, '2024-05-24 00:00:00.000', 3717.0000, N'Netbanking', N'PI24A014', NULL, 33, N'414510082764', N'3e77c5fc-6402-460f-9006-95b1b3d2b80b.pdf', N'Payment for JAR PURCHASED FOR BIO TOILET CHEMICAL.', N'kabita.tamang@netspeq.com', '2024-08-31 17:21:18.037');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (19, '2024-10-04 00:00:00.000', 277920.0000, N'Netbanking', N'PI24A022', NULL, 33, N'427810024627_041024102729', N'3eaa29e2-819d-4df6-931f-7d4b1445bbff.pdf', N'FULL PAYMENT FOR PURCHASE OF LAPTOP FOR RUDRA TRADE IMPLEX', N'alikabir20@gmail.com', '2024-10-05 18:44:02.137');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (20, '2024-09-27 00:00:00.000', 100000.0000, N'Cash', NULL, 1, NULL, NULL, NULL, N'BD payment to STCS for Bio Toilet Project.', N'kabita.tamang@netspeq.com', '2024-10-17 10:46:55.790');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (21, '2025-01-07 00:00:00.000', 1590000.0000, N'Netbanking', N'PI24A023', NULL, 33, N'IDFBH25007808952', N'a44bf839-e4e1-4ac1-bffc-51f2fed54892.jpeg', N'Being 30% advance payment for the Bio-Toilets as per our PO.', N'kabita.tamang@netspeq.com', '2025-01-09 11:28:19.850');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (22, '2025-01-13 00:00:00.000', 636720.0000, N'Netbanking', N'PI24A023', NULL, 33, N'IDFBR52025011300471618', N'a9bc75f4-5f49-4f33-a103-75edf87b8295.pdf', N'PART PAYMENT FOR BIO TOILET 1ST LOT', N'alikabir20@gmail.com', '2025-01-14 15:18:51.593');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (23, '2025-01-14 00:00:00.000', 64600.0000, N'Netbanking', N'PI25A025', NULL, 33, N'501415242923_140125152230', NULL, N'ADVANCE PAYMENT FOR PURCHASE OF WATER TANK FOR BIO TOILET', N'alikabir20@gmail.com', '2025-01-14 15:32:06.027');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (24, '2025-01-17 00:00:00.000', 675220.0000, N'Netbanking', N'PI24A023', NULL, 33, N'IDFBR52025011700525199', N'8c90351c-47d0-41ef-9d86-5caab27d1dae.pdf', N'PAYMENT FOR 2ND LOT OF BIO TOILET PHASE 2', N'alikabir20@gmail.com', '2025-01-17 11:24:14.753');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (25, '2025-01-17 00:00:00.000', 33040.0000, N'Netbanking', N'PI25A026', NULL, 33, N'501714820258', N'a72c50ba-0712-4ca6-9883-6bb06ff933c1.pdf', N'PAYMENT FOR PIPE FOR SD R 11 3 MTR FOR BIO TOILET INSTALLATION FOR 2 PHASE', N'alikabir20@gmail.com', '2025-01-17 14:42:00.197');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (26, '2025-01-21 00:00:00.000', 629020.0000, N'Netbanking', N'PI24A023', NULL, 33, N'IDFBR52025012100582415_210125182247', N'37874838-46c3-4155-827e-0aa2ea5da960.pdf', N'PAYMENT RELEASED FOR 3RD LOT ', N'alikabir20@gmail.com', '2025-01-21 18:29:06.430');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (27, '2025-01-22 00:00:00.000', 64600.0000, N'Netbanking', N'PI25A025', NULL, 33, N'502219852772', N'a3db0db4-7591-41ed-a0cb-bebd96397d79.jpeg', N'Final Payment made to Forever Poly Products for purchase of Water Tank for Bio-Toilet Phase II.', N'kabita.tamang@netspeq.com', '2025-01-23 11:09:59.887');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (28, '2025-01-28 00:00:00.000', 629020.0000, N'Netbanking', N'PI24A023', NULL, 33, N'IDFBR52025012800672749_280125213647', N'd036c17f-33eb-48b9-b16e-0c52ced650a5.pdf', N'PAYMENT FOR 4TH LOT OF BIO TOILET', N'alikabir20@gmail.com', '2025-01-28 21:38:51.607');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (29, '2025-01-29 00:00:00.000', 424328.0000, N'Netbanking', N'PI24A024', NULL, 33, N'502911033631_290125115656', N'a2a8ed79-62eb-4643-918b-2531b3be9cb3.pdf', N'ADVANCE PAYMENT FOR UPS ZEBRONIC PRE PRIMARY ', N'alikabir20@gmail.com', '2025-01-29 11:59:00.347');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (30, '2025-02-05 00:00:00.000', 362614.0000, N'Netbanking', N'PI24A024', NULL, 33, N'503611477881_050225115239', N'efa1ad1b-a924-4bd7-9334-a4006444e28e.pdf', N'FINAL PAYMENT MADE FOR PURCHASE OF UPS FROM BUY4M FOR NETSPEQ SOLUTION', N'alikabir20@gmail.com', '2025-02-05 11:55:46.870');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (31, '2025-02-05 00:00:00.000', 629020.0000, N'Netbanking', N'PI24A023', NULL, 33, N'IDFBR52025020500374764', N'3b0aebe7-93cb-4123-919a-3059965b11e9.pdf', N'PAYMENT FOR 5TH LOT OF BIO TOILET.', N'kabita.tamang@netspeq.com', '2025-02-05 12:00:31.440');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (32, '2025-02-12 00:00:00.000', 543600.0000, N'Netbanking', N'PI24A023', NULL, 33, N'IDFBH25043220264', N'28f145b2-3dc9-4a6c-bec7-1cf5a2290484.jpeg', N'Final payment for Bio-Toilet.', N'kabita.tamang@netspeq.com', '2025-02-12 15:11:05.557');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (33, '2025-03-04 00:00:00.000', 400000.0000, N'Netbanking', N'PI25A030', NULL, 33, N'IDFBH25063525743', N'a2919587-298a-48f7-8b45-1129128636aa.pdf', N'ADVANCE MADE FOR THE PAYMENT FOR FIRE EXTINGUISHER', N'alikabir20@gmail.com', '2025-03-17 21:04:49.560');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (34, '2025-03-10 00:00:00.000', 100000.0000, N'Netbanking', N'PI25A029', NULL, 33, N'IDFBH25069900880', N'46a062dd-4e99-41cf-a779-cc518ef8f154.pdf', N'Advance Notice Issued for Procurement of Operations and Antivirus', N'alikabir20@gmail.com', '2025-03-17 21:06:24.537');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (35, '2025-03-18 00:00:00.000', 600000.0000, N'Netbanking', N'PI25A029', NULL, 33, N'IDFBH25077747025_180325094722', N'fbaa90f0-c063-47cb-9e58-2992a0b9c232.pdf', N'The second installment was made to procure operations and other related items for the Nestpeq project.', N'alikabir20@gmail.com', '2025-03-18 09:47:13.060');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (37, '2025-03-17 00:00:00.000', 700000.0000, N'Netbanking', N'PI25A031', NULL, 33, N'IDFBH25076640996', N'35436dd3-358e-4de6-979e-77756255b987.pdf', N'ADVANCE TRANSFER FOR THE PROCUREMENT OF MUSICAL INSTRUMENT', N'alikabir20@gmail.com', '2025-03-18 10:10:13.037');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (38, '2025-03-20 00:00:00.000', 700000.0000, N'Netbanking', N'PI25A031', NULL, 33, N'IDFBH25079246712_200325144603', N'b5913a37-ca32-4eed-90ac-8cf469596271.pdf', N'2nd Part Payment transfer for Musical Items', N'alikabir20@gmail.com', '2025-03-20 14:51:14.533');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (39, '2025-03-25 00:00:00.000', 1586318.0000, N'Netbanking', N'PI25A031', NULL, 33, N'NEFT/IDFBH25084310055/BUY4M/SBIN0014549', N'1f064faa-117f-4f1d-81b5-1f84c85e105d.pdf', N'Final payment has been released for Buy4M for the musical instrument project, as per the purchase order.', N'alikabir20@gmail.com', '2025-04-07 19:12:09.680');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (40, '2025-03-25 00:00:00.000', 300000.0000, N'Netbanking', N'PI25A031', NULL, 33, N'NEFT/IDFBH25084290878/BUY4M/SBIN0014549', N'2d8a6cb7-7725-4ef2-b0dc-6ee38201cc86.pdf', N'Final payment has been released for Buy4M for the musical instrument project, as per the purchase order.', N'alikabir20@gmail.com', '2025-04-07 19:13:21.370');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (41, '2025-04-04 00:00:00.000', 181012.0000, N'Cheque', N'PI25A032', NULL, 33, N'000009', N'd0f6fe46-f35e-4391-a560-d807c75e9c1e.jpg', N'Payment for transportation charges for safety and security items fire extinguisher for 33 Block.', N'kabita.tamang@netspeq.com', '2025-05-03 11:32:51.540');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (42, '2025-04-04 00:00:00.000', 153164.0000, N'Cheque', N'PI25A033', NULL, 33, N'000009', N'd2c4ee2f-d010-4b4b-9b86-2278fb3f7aad.jpg', N'Payment for transportation charges for Musical instrument items for 43 PM Shri Schools.', N'kabita.tamang@netspeq.com', '2025-05-03 11:33:54.877');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (43, '2025-04-04 00:00:00.000', 41772.0000, N'Cheque', N'PI25A034', NULL, 33, N'000009', N'df2004d5-d81b-4260-8c28-d030cde84546.jpg', N'Payment for  transportation charges for providing logistics in different schools, BAC, AMC.', N'kabita.tamang@netspeq.com', '2025-05-03 11:35:06.103');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (44, '2025-03-31 00:00:00.000', 774572.0000, N'Netbanking', N'PI25A030', NULL, 33, N'IDFBH25090686829', N'f8c43003-370e-4060-86cf-6ac30fd5a206.jpeg', N'Final payment made for the Fire Extinguisher Project.', N'kabita.tamang@netspeq.com', '2025-05-03 12:02:21.117');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (45, '2025-03-31 00:00:00.000', 19205.0000, N'Netbanking', N'PI25A035', NULL, 33, N'IDFBH25090686829', N'599abd8f-c71a-48b6-b662-eb34bcb30923.jpeg', N'payment for Keyboard and mouse for OPS project.', N'kabita.tamang@netspeq.com', '2025-05-03 12:06:49.087');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (46, '2025-03-31 00:00:00.000', 6329.0000, N'Netbanking', N'PI24A000', NULL, 33, N'IDFBH25090686829', N'bd2075f5-a06e-4f61-b966-2cc75bc758eb.jpeg', N'Final Payment to Buy4m for purchase of safety & Security Items Phase I.', N'kabita.tamang@netspeq.com', '2025-05-03 12:19:06.157');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (48, '2025-05-01 00:00:00.000', 439242.0000, N'Netbanking', N'PI25A029', NULL, 33, N'IDFBH25121248553', N'744eaa5d-87f0-4cc5-b039-1f7125fe58f1.pdf', N'Final Payment for Procurement of Operations and Antivirus', N'alikabir20@gmail.com', '2025-05-03 12:49:50.360');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (49, '2025-05-01 00:00:00.000', 14160.0000, N'Netbanking', N'PI25A028', NULL, 33, N'IDFBH25121248553', NULL, N'Payment for  transportation bill of 495 UPS from Siliguri to Gangtok.', N'alikabir20@gmail.com', '2025-05-03 14:11:29.530');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (50, '2025-05-01 00:00:00.000', 34076.0000, N'Netbanking', N'PI25A027', NULL, 33, N'IDFBH25121248553', N'74072a88-0efc-45e4-a96e-e2909f59f941.pdf', N'Payment for purchase for Bio-toilets Phase II Project.', N'alikabir20@gmail.com', '2025-05-03 14:13:05.050');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (51, '2025-05-01 00:00:00.000', 9735.0000, N'Netbanking', N'PI24A019', NULL, 33, N'IDFBH25121248553', N'232cf11b-0fdc-444b-8c7a-3358e745a6b2.pdf', N'Payment for  ICT WORK WIN 10.', N'alikabir20@gmail.com', '2025-05-03 14:14:27.217');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (52, '2025-05-01 00:00:00.000', 2124.0000, N'Netbanking', N'PI24A020', NULL, 33, N'IDFBH25121248553', N'60051073-e3e3-48e3-b28a-564d191f27f1.pdf', N'Payment for PRINTED CHALLAN FOR BIO TOILET.', N'alikabir20@gmail.com', '2025-05-03 14:15:35.187');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (53, '2025-05-01 00:00:00.000', 649.0000, N'Netbanking', N'PI24A016', NULL, 33, N'IDFBH25121248553', N'34e375fd-5915-499b-90df-495f38c111fb.pdf', N'Payment for ICT AND CCTV CAMERA.', N'alikabir20@gmail.com', '2025-05-03 14:16:23.693');
INSERT INTO [utblPaymentReleasedTrans] ([PaymentID], [PaymentDate], [PaymentAmt], [PaymentMode], [PurchaseInvoiceID], [DirectPaymentID], [BankID], [PaymentTransNo], [UploadedFile], [Remarks], [AddedBy], [AddedOn]) VALUES (54, '2025-05-03 00:00:00.000', 900000.0000, N'Netbanking', N'PI25A036', NULL, 33, N'IDFBH25123809627', N'806625a5-8aa1-4aca-932d-a20a0830318f.jpeg', N'Being Advance payment for supply of laptop and printer', N'kabita.tamang@netspeq.com', '2025-05-05 14:04:58.990');
SET IDENTITY_INSERT [utblPaymentReleasedTrans] OFF;
GO

-- Data for table: [utblPettyCashs] (2 rows)
SET IDENTITY_INSERT [utblPettyCashs] ON;
INSERT INTO [utblPettyCashs] ([PettyCashID], [TransDate], [ExpenseTypeID], [ProjPaymentReceiveID], [ReceivedID], [PaymentID], [BankID], [CreditAmt], [DebitAmt], [Remarks], [IsClosed], [FilePath]) VALUES (1, '2024-09-27 00:00:00.000', 5, NULL, 1, NULL, NULL, 100000.0000, NULL, N'Loan received from SDK Gangtok  (For Bio-toilet BD payment to STCS)', 0, NULL);
INSERT INTO [utblPettyCashs] ([PettyCashID], [TransDate], [ExpenseTypeID], [ProjPaymentReceiveID], [ReceivedID], [PaymentID], [BankID], [CreditAmt], [DebitAmt], [Remarks], [IsClosed], [FilePath]) VALUES (2, '2024-09-27 00:00:00.000', 6, NULL, NULL, 20, NULL, 0.0000, 100000.0000, N'BD payment to STCS for Bio Toilet Project.', 0, NULL);
SET IDENTITY_INSERT [utblPettyCashs] OFF;
GO

-- Data for table: [utblProjPaymentReceivables] (18 rows)
SET IDENTITY_INSERT [utblProjPaymentReceivables] ON;
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (1, 2, 33, '2024-07-03 00:00:00.000', N'Cheque', N'Amount received for supply of Bio-Toilets items.', 7000000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (2, 1, 33, '2024-04-05 00:00:00.000', N'Netbanking', N'Payment received fro supply of Safety & Security items to SDK Solution Gangtok.', 3058973.0000, 0.0000, 0.0000, 0.0000, 0.0000, 1, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (3, 1, 33, '2024-05-06 00:00:00.000', N'Netbanking', N'Final payment received from SDK Solution Gangtok for supply of Safety & security Items.', 833705.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (4, 7, 33, '2024-11-29 00:00:00.000', N'Cheque', N'Being Final payment received for supply of Laptops for PM Shri Schools. (Atal Tinkering Lab Project).', 372880.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (5, 9, 33, '2025-03-29 00:00:00.000', N'Netbanking', N'Being advanced payment received from Netspeq Solutions for the supply of 494 600VA UPS.', 500000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (6, 8, 33, '2025-01-03 00:00:00.000', N'Netbanking', N'BEING PAYMENT RECEIVED FOR THE SUPPLY OF BIO TOILET PHASE II', 500000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (7, 8, 33, '2025-01-10 00:00:00.000', N'Netbanking', N'BEING PAYMENT RECEIVED FOR THE SUPPLY OF BIO TOIET PHASE II', 500000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (8, 8, 33, '2025-01-17 00:00:00.000', N'Netbanking', N'BEING PAYMENT RECEIVED FOR THE SUPPLY BIO TOILET PHASE II', 400000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (9, 8, 33, '2025-02-04 00:00:00.000', N'Netbanking', N'BEING PAYMENT RECEIVED FOR THE SUPPLY OF BIO TOILET PHASE II', 500000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (10, 8, 33, '2025-03-12 00:00:00.000', N'Netbanking', N'BEING PAYMENT RECEIVED FOR THE SUPPLY OF BIO TOILET PHASE II', 200000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (11, 8, 33, '2025-03-16 00:00:00.000', N'Netbanking', N'BEING PAYMENT RECEIVED FOR THE SUPPLY OF BIO TOIET PHASE II', 3000000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (12, 8, 33, '2025-03-30 00:00:00.000', N'Netbanking', N'BEING PAYMENT RECEIVED FOR THE SUPPLY OF BIO TOILET PHASE II', 3000000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (13, 10010, 33, '2025-05-30 00:00:00.000', N'Netbanking', N'bill part payment received from Netspeq solution for the supply of OPS HDD UPS and anti virus for PM SHRI', 1000000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 1, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (14, 10011, 33, '2025-05-03 00:00:00.000', N'Netbanking', N'Being payment received for the supply of Fire Extinguisher .', 1200000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (15, 2, 33, '2024-09-27 00:00:00.000', N'Netbanking', N'being payment received for the project of bio toilet phase I', 6100000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (16, 2, 33, '2024-10-27 00:00:00.000', N'Netbanking', N'Being payment received for the project of bio toilet phase I', 50000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (17, 8, 33, '2025-01-06 00:00:00.000', N'Netbanking', N'Being payment for the project of bio toilet phase II', 500000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
INSERT INTO [utblProjPaymentReceivables] ([ProjPaymentReceiveID], [ProjectID], [BankID], [ReceivedDate], [ReceivedMode], [Remarks], [NetAmtReceived], [TDSDeductionAmt], [GstDeductionAmt], [SecurityDepositAmt], [OtherDeductionAmt], [IsAdvance], [UploadedFile], [SaleInvoiceID]) VALUES (18, 8, 33, '2025-03-17 00:00:00.000', N'Netbanking', N'BEING PAYMENT FOR THE PROJECT OF BIO TOILET PHASE II', 1500000.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0, NULL, NULL);
SET IDENTITY_INSERT [utblProjPaymentReceivables] OFF;
GO

-- Data for table: [utblPurchaseInvoiceItems] (90 rows)
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'023BF326-8D7C-447A-8F2E-0409F9D0F706', N'PI25A032', N'Transportation charges for Safety and Security items Fire Extinguisher for 33 Block', N'996511', 18, 18, 0, 0, 1, 153400.0000, 153400.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'02E8B786-8D56-4A36-BE44-59C3B077DCB3', N'PI25A034', N'providing Logistics in different Schools, BAC, AMC  (For Safety and Security Measure at 33 Blocks).', N'996511', 18, 18, 0, 0, 1, 35400.0000, 35400.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'038151ED-51B3-447A-9158-DBDE86EE2D4B', N'PI25A035', N'KB+MOUSE ZEBRONIC W/L COMPANION 151', N'84716040', 18, 0, 9, 9, 31, 525.0000, 16275.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'0BC51312-EDE0-48A9-A7ED-4786019AEFD2', N'PI24A023', N'MICROBIAL SOLUTION (Bio Culture)', N'30029030', 12, 12, 0, 0, 140, 491.0700, 68749.8000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'0E6FD78B-6904-4443-AC88-11AAB70A1095', N'PI24A000', N'Fire Extinguisher ABC 4 Kg BIS 15683', N'8424', 18, 0, 9, 9, 66, 2150.0000, 141900.0000, N'11');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'15638AF7-1791-4207-B49F-F67523F9F26D', N'PI25A030', N'ABC MAP POWDER BASED ISI APPROVED FIRE EXT 6KG', N'84241000', 18, 0, 9, 9, 474, 2100.0000, 995400.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'1917C1BF-4CEC-424C-92ED-FF2E5A30FCFC', N'PI24A018', N'PVC POLY PIPE 20 BUNDLE', N'3917', 18, 0, 9, 9, 480, 67.0000, 32160.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'1E70312C-9F31-4693-813E-0EB20D4601FB', N'PI25A036', N'HP 255 G10 B1FW9PT
R3 7320U \8GB\ 512GB\Plastic\Silver\ WiFi 6\Win11 Pro+MSO21\ 15.6" HD\ 1
Year with a bag', N'84713010 ', 18, 0, 9, 9, 26, 23306.0000, 605956.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'2228FB1F-6A8E-4717-85E9-CDF7F3033AD9', N'PI24A003', N'PRINTER BROTHER T520W
E80722H3H234384', N'84433100 ', 18, 0, 9, 9, 1, 11864.4100, 11864.4100, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'2239D412-48BD-4B94-A58F-B0A14071DF25', N'PI25A027', N'5-W Heavy Jar', N'3924', 18, 0, 9, 9, 35, 70.0000, 2450.0000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'247FBDD2-123E-4213-AA0D-57FE65DD298F', N'PI24A015', N'FREIGHT', N'996791', 18, 0, 9, 9, 1, 1000.0000, 1000.0000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'24905CB2-80F9-467D-829D-42047091AE3B', N'PI24A017', N'PVC POLY PIPE', N'3917', 18, 0, 9, 9, 477, 67.0000, 31959.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'25415191-51D1-426C-884B-EFC4FE5B0A71', N'PI24A000', N'Voltaic DVR Rack 4U', N'84733099', 18, 0, 9, 9, 24, 1350.0000, 32400.0000, N'10');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'26975607-207B-4136-8486-B3819E6F9571', N'PI24A000', N'SECUREYE CAT6 CABLE (4 PAIR) 305M', N'85444999', 18, 0, 9, 9, 24, 5350.0000, 128400.0000, N'4');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'2798BBA6-3A91-4415-B1D5-E3DACE6216BB', N'PI24A000', N'Intex Trolly Speaker T-311', N'851822', 18, 0, 9, 9, 36, 5850.0000, 210600.0000, N'12');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'27CA177E-C609-4E7E-9172-C417FF56C113', N'PI25A031', N'Ahuja UBA 800 Amplifier', N'85184000', 18, 0, 9, 9, 43, 22649.1500, 973913.4500, N'3');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'2B9966D9-9AF8-45EC-97C0-7578080B8F3E', N'PI24A021', N'LAMINATION PESTING ', N'39204900', 18, 0, 9, 9, 1736, 10.0000, 17360.0000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'2EF317EC-C1D4-49AC-8979-960B566B6A4B', N'PI25A033', N'Transportation charges of Musical Instrument Items for 43 PM Shri Schools.', N'996511', 18, 18, 0, 0, 1, 129800.0000, 129800.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'30B895FA-0660-4BF1-AC0A-E9A2366C1F0B', N'PI24A011', N'VGA CABLE 10M', N'85441990', 18, 0, 9, 9, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'319B47E4-D275-4E67-9541-88EBC357D15F', N'PI24A000', N'ELISTA LED TV 32'''' NH32ECA60 F', N'85285200', 18, 0, 9, 9, 24, 7288.1400, 174915.3600, N'6');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'343C20F1-421B-4E89-9B87-4983004D4D90', N'PI25A035', N'ROUND OFF', N'-', 0, 0, 0, 0, 1, 0.5000, 0.5000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'39E88F70-8935-4601-8093-F35FCC7E31FF', N'PI25A027', N'HDP Pipe', N'39173100', 18, 0, 9, 9, 298, 86.0000, 25628.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'3DE88216-C7AC-41C5-9B78-9821CAC232DA', N'PI24A022', N'LENOVO LAPTOPBAG PACK', N'4202 ', 18, 0, 9, 9, 8, 847.4600, 6779.6800, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'3ECDB3EA-D9B8-4ADB-85EF-4BB64073525E', N'PI24A009', N'HDMI TO HDMI CABLE ZEBRONICS', N'85444999', 18, 0, 9, 9, 5, 295.0000, 1475.0000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'4564387E-5374-4EB3-A49C-F8C4E730F2A2', N'PI24A000', N'DIGISOL CAT6 RJ45 CONNECTOR PKT OF 100', N'85444992', 18, 0, 9, 9, 5, 250.0000, 1250.0000, N'8');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'4781B9CA-44FB-4684-A058-F0CC7BE44629', N'PI24A011', N'EIRA TEK HDMI TO VGA CONVERTOR', N'84733099', 18, 0, 9, 9, 1, 450.0000, 450.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'49A4C969-8530-4E77-94CB-F2B180233367', N'PI24A013', N'SOFTWARE (WI 10)', N'85238020', 18, 0, 9, 9, 20, 275.0000, 5500.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'49F703E0-2194-4B9F-B3D0-CC7D54B2777A', N'PI25A031', N'Tabla Metal Set', N'94032010', 18, 0, 9, 9, 43, 3813.5600, 163983.0800, N'6');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'4A300D20-BC05-4B1D-BAD7-FB98B99888D6', N'PI25A031', N'Cajon Clapbox CB50', N'92060000', 18, 0, 9, 9, 43, 3050.8500, 131186.5500, N'5');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'4EA5E7C5-5129-4248-B8C9-8315EB7814FB', N'PI24A001', N'FRP Western Bio Toilet
Model JBT-EWC-ST-03
FRP Western Bio Toilet
Door Size: 680*1830 mm
Thickness: 18mm
Floor Thickness: 5 mm
Side Wall Thickness: 3 mm, Front Frame: 5 mm
Commode: Ceramic
With Sanitation and Plumbing, ventilator, and electric Point, Bio Digester Tank 350 Liters', N'940600', 18, 0, 9, 9, 200, 28813.5600, 5762712.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'5494BD54-10A9-447C-9FA3-6FBB22BBFE66', N'PI25A029', N'OPS: I5 10TH GEN , 8GB RAM, 1TB SSD
Warrnty : 3yrs onsite', N'84713010', 18, 0, 9, 9, 30, 19500.0000, 585000.0000, N'4');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'572AFB5C-9FF1-416C-A78D-2548BA60ED8A', N'PI25A037', N'Ideapad Slim 5	Thin & Light	83BF0043IN	i5-12450H	16GB / 1TB 	WIN 11	OFFICE''21	Integrated	14" WUXGA  IPS 300nits	Cloud Grey	1.46Kg	NO Bag	1 Yr.	Backlit', N'84713010', 18, 0, 9, 9, 3, 50847.4600, 152542.3800, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'5B99594D-A88A-4985-A253-93A91FA68E10', N'PI24A014', N'5-W HEAVY JAR  ', N'3924', 18, 0, 9, 9, 45, 70.0000, 3150.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'5C04AC14-159A-48DF-A99A-DE428C771C1B', N'PI25A029', N'Quick Heal Antivirus Pro 10 user 1yr ', N'85238020', 18, 0, 9, 9, 30, 220.8600, 6625.8000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'60BCBD2B-9060-4DD1-A7C2-C0B206112A8B', N'PI24A005', N'Hi-Fi Double SS Combined 10amp', N'85363910 ', 18, 0, 9, 9, 24, 65.0000, 1560.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'620A82FC-7867-4F85-BEF8-2705637FDF6D', N'PI24A016', N'SATA POWER CABLE', N'85441990', 18, 0, 9, 9, 5, 60.0000, 300.0000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'652CB4F4-5354-463D-8A86-D9BBFAC834EE', N'PI25A027', N'Freight Charges', N'996511', 18, 0, 9, 9, 1, 800.0000, 800.0000, N'3');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'65BA9EAE-2CA2-4914-A8C0-55F7DD5B30A7', N'PI25A036', N'1.5 Wire', N'854419', 18, 0, 9, 9, 3, 1190.0000, 3570.0000, N'8');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'67C8779C-2F0B-492A-95A7-7932512229A8', N'PI24A018', N'FREIGHT AND LOADING', N'996791', 18, 0, 9, 9, 1, 1000.0000, 1000.0000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'68ECE58A-A66A-4252-AAEA-3F49CF228DBC', N'PI24A007', N'Software (Wi 10) ', N'85238020', 18, 0, 9, 9, 250, 275.0000, 68750.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'6D86A276-E207-4FB0-8307-B4023AE215D5', N'PI24A000', N'PVC BOX 5X5', N'39261011', 18, 0, 9, 9, 240, 25.0000, 6000.0000, N'7');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'71ADE060-83B1-46AD-B7E5-5569C0EF4D3D', N'PI25A031', N'Bamboo Flute', N'92059010', 18, 0, 9, 9, 43, 296.6100, 12754.2300, N'7');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'730A75A2-86A1-4C88-BA51-5485FCD8BB20', N'PI24A016', N'DIGISOL CAT6 RJ45 CONNECTOR PKT OF 100', N'85444992', 18, 0, 9, 9, 1, 250.0000, 250.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'776019D0-0DC7-4A70-95C1-FC5AAE5335D2', N'PI25A029', N'Quick Heal Antivirus Pro 3 user 1yr ', N'85238020', 18, 0, 9, 9, 10, 220.8600, 2208.6000, N'3');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'788981EB-E342-45D3-8F2C-1542269DFA57', N'PI24A019', N'SOFTWARE WIN 10', N'85238020', 18, 0, 9, 9, 30, 275.0000, 8250.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'7A05A7C7-A3D2-4F6F-AE47-971E98CB836C', N'PI24A012', N'FREIGHT LOADING ', N'996791', 18, 0, 9, 9, 1, 1000.0000, 1000.0000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'83CF766B-CC05-468A-8FB5-8984ED67DCFB', N'PI24A005', N'ESS SS COM WITH BOX', N'85371000 ', 18, 0, 9, 9, 14, 165.0000, 2310.0000, N'3');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'85CBBB9C-2128-40F9-BF2D-2068B4D959AE', N'PI24A002', N'1000L Two Layer LLDPE
Water Tank 
Storage Capacity: 1000 L 
Layer: 2
Shape: Round
Product Material: LLDPE
', N'39251000', 18, 0, 9, 9, 50, 2881.3600, 144068.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'867BFEDF-E936-4D91-A04C-46A599A8A8C0', N'PI24A012', N'PVC POLY PIPE', N'3917', 18, 0, 9, 9, 427, 67.0000, 28609.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'8AB1BFF9-F135-4867-96A5-0E4C15A1E93F', N'PI24A004', N'SECUREEYE 16CH 4K NVR (SCP-S-NVR-1)', N'85444999 ', 18, 0, 9, 9, 4, 4600.0000, 18400.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'8FC82119-359D-4FC9-BD2F-1B0DE0B4E8CC', N'PI24A008', N'ZB-ROCKER THUNDER XXL', N'ZB-ROCKER THUNDER XXL', 18, 0, 9, 9, 1, 1.0000, 1.0000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'919554D4-0B57-4F75-AF18-E592B033A78E', N'PI25A036', N'HP LASERJET P1108 PRINTER', N'84433240 ', 18, 0, 9, 9, 26, 11186.0000, 290836.0000, N'3');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'967C1C5B-27ED-4CB1-8F72-F350A5835F99', N'PI25A026', N'TF-CPVC PIPE SDR11-3MTR- 3/4'''' (20)', N'39172390 ', 18, 0, 9, 9, 140, 200.0000, 28000.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'9B5F75A2-F649-4045-8302-308FDFCD8E5D', N'PI24A001', N'Microbial Solution', N'30029030', 12, 0, 6, 6, 200, 491.0700, 98214.0000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'9E13C962-499C-4955-9008-A4A2113D8367', N'PI24A008', N'ZB-ROCKER THUNDER XXL', N'ZB-ROCKER THUNDER XXL', 18, 0, 9, 9, 3, 6949.1500, 20847.4500, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'A282E27F-C8D2-4341-9FE3-4C3A959343EE', N'PI24A010', N'Software (pp 21)', N'85238020 ', 18, 0, 9, 9, 1, 1184.4400, 1184.4400, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'A3F8D790-89F9-4001-AD77-3C9399BE96CD', N'PI25A029', N'1 KVA UPS ZEBRONIC', N'85044090', 18, 0, 9, 9, 71, 3375.0000, 239625.0000, N'5');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'A54865F1-0FEB-483A-BD73-90794FA35432', N'PI25A036', N'4 U Rack', N'84733099', 18, 0, 9, 9, 26, 1144.0000, 29744.0000, N'6');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'ABFAD9C1-96B2-4E38-8CB8-34BFE688AAFA', N'PI24A009', N'HDMI CABLE 5M', N'85444999', 18, 0, 9, 9, 19, 295.0000, 5605.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'AC62B0D5-40A1-48B0-9387-8178A9E8C6F6', N'PI25A036', N'ACER 20'''' MONITOR', N'85285200 ', 18, 0, 9, 9, 26, 4406.0000, 114556.0000, N'4');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'ACDCD9E3-B259-44D8-8EF6-89031E2014F4', N'PI25A036', N'CCTV
8 CH 5 MP LITE DVR HIKVISION + 3K 5MP WITH AUDIO FULL COLOR VU CAMERA HIKVISION (4
NOS.) + SMPS+MONITOR 22'''' ZEBRONICS
+ CABLE 3+1 90MTR + 5X5 PVC BOX 4
+2TB HDD + BNC+DC', N'85444299', 18, 0, 9, 9, 26, 23516.0000, 611416.0000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'AE929795-D863-4D73-BE23-35AB4B4C97BA', N'PI25A036', N'STATIONARY ITEMS
A4 10 RIM+ TONNER 88A COMPATIBLE 5
NOS.+STEPLER 2 NOS. + CARD BOARD 2
NOS. + FILE FOLDER 50 NOS.', N'4820', 18, 0, 9, 9, 26, 5624.0000, 146224.0000, N'5');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'B090357C-8F4D-4278-98DE-8FCF0319B4E0', N'PI24A000', N'SECUREYE 8 PORT POE S-8FE-2UE-LD', N'851769', 18, 0, 9, 9, 48, 1650.0000, 79200.0000, N'3');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'B2E8F9DE-1F9D-4406-AF8A-23969AD6FB46', N'PI25A036', N'Quick Heal Anti Virus (Pro) 1 User 1 Year', N'84713010', 18, 0, 9, 9, 26, 220.8600, 5742.3600, N'9');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'B56C01C8-5B13-49FD-BF05-366273552086', N'PI24A000', N'SIP DOME CAMERA 4MP COLOUR 3.6MM', N'85258900', 18, 0, 9, 9, 240, 1850.0000, 444000.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'C1A6FE42-8F5C-4F6B-ABF0-23552ECF356D', N'PI24A017', N'FREIGHT AND LOADING', N'996791', 18, 0, 9, 9, 1, 1000.0000, 1000.0000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'C745E4DA-AC8C-4F19-9A7F-4651F8890E82', N'PI24A022', N'Lenovo IdeaPad Slim 3 Intel Core i3
12th Gen 15.6 inch (39.62cm) FHD
Thin & Light Laptop (8GB/512GB
SSD/Windows 11/Office
2021/3months Game Pass/Arctic', N'8471 ', 18, 0, 9, 9, 8, 28593.2200, 228745.7600, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'C9603770-E735-49BA-9845-35854EA69A47', N'PI25A028', N'Freight Charges
   for 495 UPS Slg to Majitar', N'996511', 18, 0, 9, 9, 1, 12000.0000, 12000.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'CAFD1578-7248-421C-A2A3-2BCE9E0115B7', N'PI24A011', N'SERVICE CHARGE
OPTIMA PROJECTOR AND LAPTOP CARRY CASE', N'9987', 18, 0, 9, 9, 1, 11000.0000, 11000.0000, N'4');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'CC5CBA5A-6AE7-4EF1-8D14-A26627D8161E', N'PI24A011', N'POWER CABLE 10M', N'85444299', 1, 0, 9, 9, 1, 450.0000, 450.0000, N'3');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'D12FCDF7-2418-412F-8C55-50301862C857', N'PI24A005', N'ESS SS COM WITH BOX', N'85371000 ', 18, 0, 9, 9, 10, 95.0000, 950.0000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'D56B5310-85E4-4283-819F-00A55481A2EF', N'PI24A021', N'SELF-ADHESIVE VINYLE PRINTING ', N'39199090', 18, 0, 9, 9, 1736, 30.5800, 53086.8800, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'D6E4FE77-E444-40BB-9A67-E99C354E7D4F', N'PI24A023', N'Transport charges', N'996793', 18, 18, 0, 0, 12, 35000.0000, 420000.0000, N'3');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'DE94DC7D-AABA-43BE-B3F7-AC5D81F2D645', N'PI25A025', N'1000L Two Layer LLDPE
Water Tank
Storage Capacity: 1000L
Layer:2
Shape: Round
Product Material: LLDPE', N'39251000', 18, 0, 9, 9, 38, 2881.3600, 109491.6800, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'DEFF2E29-E79B-4D9D-8EDF-5E64BAA33775', N'PI25A036', N'SS Combine (4 Socket 4 Switch) 16 AMP', N'85366990', 18, 0, 9, 9, 52, 160.0000, 8320.0000, N'7');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'DF8124E1-9751-437E-8284-7558D3F46281', N'PI24A000', N'SECUREEYE 16CH 4K NVR (SCP-STN-16CA1LA)', N'85219090 ', 18, 0, 9, 9, 20, 4600.0000, 92000.0000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'E2B0D5EE-C3DB-480B-AB62-65844CE91782', N'PI24A024', N'ZEBRONICS UPS U735 ', N'85044029 ', 18, 0, 9, 9, 494, 1350.0000, 666900.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'E2F7CF72-C3A6-42A5-A9FD-B1AD634A8A78', N'PI24A000', N'AVERTEK HDD 2TB SURVEILLANCE', N'84717020', 18, 0, 9, 9, 24, 3150.0000, 75600.0000, N'5');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'E338E951-BC51-4DF3-9C2B-A8238213AF53', N'PI24A001', N'Transportation Charges from Kolkata to Siliguri', N'996793', 18, 0, 9, 9, 17, 35000.0000, 595000.0000, N'3');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'E86454D6-0B0F-4FC1-9634-0FC15C9547DE', N'PI25A031', N'Yamaha PSR-383 keyboard with Stand and Cover ', N'92030090', 18, 0, 9, 9, 43, 14237.2900, 612203.4700, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'E89E55CF-FCAA-4C18-9186-061F2D20A702', N'PI25A031', N'Maraca Pair', N'92060000', 18, 0, 9, 9, 43, 381.3600, 16398.4800, N'8');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'E9D0B415-0BEA-416F-B89F-B82A621BFF48', N'PI25A031', N'RockStar Octapad Advance', N'92079000', 18, 0, 9, 9, 43, 18220.3400, 783474.6200, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'EA7FE3D8-F83A-41DB-9F86-5D68C906357E', N'PI24A000', N'CYBER POWER UPS 1KVA BU100E', N'85044090', 18, 0, 9, 9, 24, 3550.0000, 85200.0000, N'9');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'EF04B589-F6FE-464D-9769-D1E4076A9AEA', N'PI24A020', N'PRINTED CHALLAN', N'4901', 18, 0, 9, 9, 6, 300.0000, 1800.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'F323DE1C-C7A4-4D9C-BF60-1686D169CC3F', N'PI24A006', N'FREIGHT', N'996791', 18, 0, 9, 9, 1, 14000.0000, 14000.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'F42AB3D8-8CC1-45D8-AD39-7B7D77D1D6DA', N'PI25A029', N'TOSHIBA 1TB EXTERNAL HDD', N'84717020', 18, 0, 9, 9, 30, 4400.0000, 132000.0000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'F499CAFC-F2E4-4DA3-BD78-58FAA4235C0D', N'PI25A031', N'Hobner Acoustic Guitar (Venus)', N'92029000', 18, 0, 9, 9, 43, 2118.6400, 91101.5200, N'4');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'FAEF856F-F5C4-4D18-8EC9-56B08E4C5604', N'PI24A023', N'FRP Western Bio Toilet
', N'940600', 18, 18, 0, 0, 140, 28813.5600, 4033898.4000, N'1');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'FE4FA185-CC10-45F2-AB78-5A282B05F1F5', N'PI24A004', N'White Board Rhino 3'' X 2''', N'9610', 18, 0, 9, 9, 60, 506.0000, 30360.0000, N'2');
INSERT INTO [utblPurchaseInvoiceItems] ([ItemDtlID], [PurchaseInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SlNo]) VALUES (N'FF04B0E9-89D7-4A13-92CF-C534AF5BDFE0', N'PI24A015', N'PVC POLY PIPE', N'3917', 18, 0, 9, 9, 507, 67.0000, 33969.0000, N'1');
GO

-- Data for table: [utblPurchaseInvoiceKeys] (38 rows)
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A000', '2024-03-30 00:00:00.000', N'SDK/2023-24/1/PO', N'23-24/682', N'Without Purchase Order', 1, 1, 0.0000, 132431.8800, 132431.8800, 1471465.3600, 1736329.1200, 1736329.0000, 0.1200, N'PURCHASE OF SAFETY AND SECURITY', N'5c40d5e5-98c7-4b07-b499-5d866ffcd8e9.pdf', N'M/s SDK SOLUTIONS
NEAR DON BOSCO SCHOOL ROAD
SEVOKE ROAD
SILIGURI-734001
Ph: 9733116514', N'Terms & Conditions:
1. All items must be new; refurbished items will be returned for a full refund.
2. The item should be delivered within 15 days from the date of issue of this PO. 
3. Please ensure that the materials provided adhere strictly to the specifications outlined in the Purchase Order.. 
4. "Prices are non-negotiable and will not be subject to change."
5. Rates are inclusive of all Applicable Taxes.
6. Payments will be released as per the schedule mentioned below:
6.1. Advance amount of ₹ 30% will be released with PO.
6.2. The remaining amount will be released at the time of delivery.
7. Warranty: The product principal warranty for all items should be a minimum of 1 year or longer, as per items.
8. Kindly acknowledge the PO for the release of advance.', 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 14:48:39.460');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A001', '2024-05-06 00:00:00.000', N'SDK/2024-25/1/PO', NULL, N'With Purchase Order', 2, 5, 0.0000, 578086.9200, 578086.9200, 6455926.0000, 7612099.8400, 7612100.0000, -0.1600, N'PURCHASE OF FRP BIO TOILET FOR TENPAL EMPORIUM ', N'', N'Ship To:
M/s SDK SOLUTIONS
NEAR DON BOSCO SCHOOL ROAD
SEVOKE ROAD
SILIGURI-734001
Ph: 9733116514', N'1.	Prices are firm and no escalation will be entertained
2.	Rates are inclusive of all applicable taxes
3.	Material should be delivered as the schedule which will be provided within seven days from delivery of this PO. 
4.	Delivery charge as per actual to be delivered at Siliguri West Bengal.
5.	Material should be delivered without any physical damage. In case any damage is found, JRMS will replace/repair the item to the satisfaction of the end client
6.	Payment Terms: 30% advance upon acceptance of this PO & 70% Pro rata Basis.
7.	Colour: Blue and Grey', 0, 1, 0, N'alikabir20@gmail.com', '2024-07-16 14:49:41.470');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A002', '2024-05-20 00:00:00.000', N'SDK/2024-25/2/PO', NULL, N'With Purchase Order', 2, 4, 0.0000, 12966.1200, 12966.1200, 144068.0000, 170000.2400, 169952.0000, 48.2400, N'PURCHASE OF WATER TANK 1000 LTRS FOR PROJECT BIO TOILET', N'', N'Bajla Logistics Co.Bangla Bazar, near Checkpost, Sevoke Road', N'1.	Prices are firm and no escalation will be entertained
2.	Rates are inclusive of all applicable taxes
3.	Material should be delivered to Bajla Logistics Co.Bangla Bazar, near Checkpost, Sevoke Road 2.5 mile, Siliguri, West Bengal 734001 (Contact Person: +91 98327 84535 Rahul Bajla). 
4.	Delivery charge included till above mention location.
5.	Material should be delivered without any physical damage. In case any damage is found, JRMS will replace/repair the item to the satisfaction of the end client
6.	Payment Terms: 30% advance upon acceptance of this PO & 70% after delivery. ', 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 15:54:29.700');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A003', '2024-04-30 00:00:00.000', N'SDK/2024-25/3/PO', N'23-24/683', N'Without Purchase Order', 4, 1, 0.0000, 1067.8000, 1067.8000, 11864.4100, 14000.0000, 0.0000, 14000.0000, N'PURCHASE FOR OFFICE ASSET FOR OFFICE PURCHASE', N'd292f4e4-b438-46bc-a149-58e00a55fac1.pdf', N'Sabir Alam (SDK Solutions)
Second Floor Akashatar Apartment
NEAR DON BOSCO SCHOOL ROAD
SILIGURI', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 16:00:38.260');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A004', '2024-04-06 00:00:00.000', N'SDK/2024-25/4/PO', N'24-25/10', N'Without Purchase Order', 1, 1, 0.0000, 4388.4000, 4388.4000, 48760.0000, 57536.8000, 57537.0000, -0.2000, N'ITEMS PURCHASE FOR SAFETY AND SECURITY (REMAINING ITEMS)', N'5b5227f4-1a25-4493-a12f-22d9deec9431.pdf', N'Sabir Alam (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116414 | Email: info@sdksolution.in', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 16:06:07.697');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A005', '2024-04-06 00:00:00.000', N'SDK/2024-25/5/PO', N'24-25/12', N'Without Purchase Order', 1, 1, 0.0000, 433.8000, 433.8000, 4820.0000, 5687.6000, 0.0000, 5687.6000, N'ITEMS PURCHASE FOR INSTALLATION OF SAFETY AND SECURITY ITEMS WHICH HAS BEEN PURCHASED NOW', N'49add398-44a5-48b8-b1f1-77c265b4306e.pdf', N'Sabir Alam (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116414 | Email: info@sdksolution.in', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 16:09:01.787');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A006', '2024-04-09 00:00:00.000', N'SDK/2024-25/6/PO', N'24-25/19', N'Without Purchase Order', NULL, 1, 0.0000, 1260.0000, 1260.0000, 14000.0000, 16520.0000, 0.0000, 16520.0000, N'TRANSPORTATION CHARGES FOR SUPPLY TO GANGTOK', N'5c18b80a-60f8-4dc9-9636-e6ac3344f15b.pdf', N'Sabir Alam (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116414 | Email: info@sdksolution.in', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 16:10:57.030');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A007', '2024-04-11 00:00:00.000', N'SDK/2024-25/7/PO', N'24-25/28', N'Without Purchase Order', NULL, 1, 0.0000, 6187.5000, 6187.5000, 68750.0000, 81125.0000, 0.0000, 81125.0000, N'ITEMS PURCHASED FOR NETSPEQ SOLUTION FOR THE ICT PROJECT', N'24051c29-3b81-4f35-9347-398f54afa45c.pdf', N'NETSPEQ SOLUTION 
NEAR SNOD PETROL PUMP 
DEORALI GANGTOK EAST SIKKIM', NULL, 0, 0, 0, N'alikabir20@gmail.com', '2024-06-04 16:13:16.790');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A008', '2024-04-15 00:00:00.000', N'SDK/2024-25/8/PO', N'24-25/33', N'Without Purchase Order', 1, 1, 0.0000, 1876.3600, 1876.3600, 20848.4500, 24601.1700, 0.0000, 24601.1700, N'ITEMS PURCHASED FOR SDK SOLUTION TADONG BACK UP SPEAKER', N'', N'Sabir Alam (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116414 | Email: info@sdksolution.in', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 16:15:22.280');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A009', '2024-04-18 00:00:00.000', N'SDK/2024-25/9/PO', N'24-25/43', N'Without Purchase Order', 1, 1, 0.0000, 637.2000, 637.2000, 7080.0000, 8354.4000, 0.0000, 8354.4000, N'Items purchase for SDK Solution Gangtok HDMI for CCTV Connection', N'', N'Manoj Basnet (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116414 | Email: info@sdksolution.in', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 16:18:26.467');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A010', '2024-04-24 00:00:00.000', N'SDK/2024-25/10/PO', N'24-25/61', N'Without Purchase Order', 1, 1, 0.0000, 106.6000, 106.6000, 1184.4400, 1397.6400, 0.0000, 1397.6400, N'MS OFFICE PURCHASE FOR ADDITIONAL SEC ADMIN (TASHI AGAYA)', N'4d7f6de1-e68a-4b96-958d-5696a81a9c77.pdf', N'Manoj Basnet (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116414 | Email: info@sdksolution.in', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 16:21:22.780');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A011', '2024-04-27 00:00:00.000', N'SDK/2024-25/11/PO', N'24-25/63', N'Without Purchase Order', NULL, 1, 0.0000, 1116.0000, 1116.0000, 12400.0000, 14632.0000, 0.0000, 14632.0000, N'A PROJECTOR HAS BEEN PURCHASED FOR BHIM THATTAL (UNDER BIMAL CHEMICAL PROJECT)', N'7e5febfb-5b9d-4ca3-9ccb-d298c95d5087.pdf', N'Bimal Adhikari 
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 16:29:16.267');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A012', '2024-05-20 00:00:00.000', N'SDK/2024-25/12/PO', N'24-25/103', N'Without Purchase Order', 2, 1, 0.0000, 2664.8100, 2664.8100, 29609.0000, 34938.6200, 34940.0000, -1.3800, N'PVC PIPE PURCHASED FOR BIO TOILET', N'890bf643-b4ab-4e37-b37f-0a95ef1be6d8.pdf', N'Bajla Logistics Co.Bangla Bazar, near Checkpost, Sevoke Road 2.5 mile, Siliguri, West Bengal 734001 (Contact Person: +91 98327 84535 Rahul Bajla). ', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 16:32:30.573');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A013', '2024-05-22 00:00:00.000', N'SDK/2024-25/13/PO', N'24-25/107', N'Without Purchase Order', 3, 1, 0.0000, 495.0000, 495.0000, 5500.0000, 6490.0000, 0.0000, 6490.0000, N'ITEMS PURCHASE FOR NETSPEQ SOLUTION FOR ICT PROJECT', N'', N'NETSPEQ SOLUTION
NEAR SNOD PETROL PUMP 
DEORALI GANGTOK EAST SIKKIM', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 16:34:25.237');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A014', '2024-05-22 00:00:00.000', N'SDK/2024-25/14/PO', N'24-25/108', N'Without Purchase Order', 2, 1, 0.0000, 283.5000, 283.5000, 3150.0000, 3717.0000, 3717.0000, 0.0000, N'JAR PURCHASED FOR BIO TOILET CHEMICAL', N'11a39cfb-a235-4ec1-bcfc-8c0421c5039f.pdf', N'Bajla Logistics Co.Bangla Bazar, near Checkpost, Sevoke Road 2.5 mile, Siliguri, West Bengal 734001 (Contact Person: +91 98327 84535 Rahul Bajla).', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 16:40:53.677');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A015', '2024-05-22 00:00:00.000', N'SDK/2024-25/15/PO', N'24-25/112', N'Without Purchase Order', 2, 1, 0.0000, 3147.2100, 3147.2100, 34969.0000, 41263.4200, 41263.0000, 0.4200, N'ITEMS PURCHASE FOR BIO TOILET', N'45e6f494-534c-49fc-849f-6822e286be45.pdf', N'Bajla Logistics Co.Bangla Bazar, near Checkpost, Sevoke Road 2.5 mile, Siliguri, West Bengal 734001 (Contact Person: +91 98327 84535 Rahul Bajla).', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 16:43:55.053');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A016', '2024-05-25 00:00:00.000', N'SDK/2024-25/16/PO', N'24-25/118', N'Without Purchase Order', 1, 1, 0.0000, 49.5000, 49.5000, 550.0000, 649.0000, 649.0000, 0.0000, N'FOR ICT AND CCTV CAMERA', N'8effab75-8ee3-4363-86cf-19aa0a61a1d7.pdf', N'Manoj Basnet,
SDK Solution
Daragoan Tadong Gangtok East Sikkim-737102', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 16:47:08.377');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A017', '2024-05-27 00:00:00.000', N'SDK/2024-25/17/PO', N'24-25/120', N'Without Purchase Order', NULL, 1, 0.0000, 2966.3100, 2966.3100, 32959.0000, 38891.6200, 38891.0000, 0.6200, N'FOR BIO TOILET', N'58f9c821-d690-4752-8bff-149bebb2bbd2.pdf', N'Bajla Logistics Co.Bangla Bazar,
Near Checkpost, Sevoke Road 2.5 mile, 
Siliguri, West Bengal 734001 
(Contact Person: +91 98327 84535 Rahul Bajla).', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-06 11:57:21.170');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A018', '2024-06-04 00:00:00.000', N'SDK/2024-25/18/PO', N'24-25/127', N'Without Purchase Order', 2, 1, 0.0000, 2984.4000, 2984.4000, 33160.0000, 39128.8000, 39128.0000, 0.8000, N'FOR BIO TOILET', N'3bb13c7b-9bcc-4373-afb2-7994c4c97f59.pdf', N'Bajla Logistics Co.Bangla Bazar, 
Near Checkpost, Sevoke Road 2.5 mile, 
Siliguri, West Bengal 734001 
(Contact Person: +91 98327 84535 Rahul Bajla).', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-06 11:56:26.830');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A019', '2024-06-04 00:00:00.000', N'SDK/2024-25/19/PO', N'24-25/128', N'Without Purchase Order', 3, 1, 0.0000, 742.5000, 742.5000, 8250.0000, 9735.0000, 9735.0000, 0.0000, N'FOR ICT WORK WIN 10', N'6086bb15-e904-4a35-b3dc-adc0c742ecfd.pdf', N'Netspeq Solution 
Near SNOD Petrol Pump 
Deorali Gangtok East Sikkim', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 16:55:19.413');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A020', '2024-06-04 00:00:00.000', N'SDK/2024-25/20/PO', N'24-25/128', N'Without Purchase Order', 2, 1, 0.0000, 162.0000, 162.0000, 1800.0000, 2124.0000, 2124.0000, 0.0000, N'FOR PRINTED CHALLAN FOR BIO TOILET', N'00be3d83-0072-449e-a34c-fda49345d5ad.pdf', N'Bajla Logistics Co.Bangla Bazar, near Checkpost, Sevoke Road 2.5 mile, Siliguri, West Bengal 734001 (Contact Person: +91 98327 84535 Rahul Bajla). ', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-06-04 16:56:42.783');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A021', '2024-06-05 00:00:00.000', N'SDK/2024-25/21/PO', N'GST/0452/24-25', N'Without Purchase Order', 2, 8, 0.0000, 6340.2200, 6340.2200, 70446.8800, 83127.3200, 83127.0000, 0.3200, N'Purchase of Vinal Printing Sticker for Bio Toilet', N'f7f90621-eda1-4ed3-9868-f4a981a2d9a9.PDF', N'Bajla Logistics Co.Bangla Bazar, Near Checkpost, Sevoke Road 2.5 mile, Siliguri, West Bengal 734001 
(Contact Person: +91 98327 84535 Rahul Bajla)', NULL, 0, 1, 0, N'alikabir20@gmail.com', '2024-07-05 14:28:33.373');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A022', '2024-10-01 00:00:00.000', N'SDK/2024-25/22/PO', NULL, N'With Purchase Order', 7, 1, 0.0000, 21197.2900, 21197.2900, 235525.4400, 277920.0200, 277920.0000, 0.0200, N'Purchase Laptops for Rudra Trade Impex', N'', N'Manoj Basnet (SDK Solution)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9064533893 | Email: info@sdksolution.co.in', N'o	The cost mentioned includes 18% GST. 
o	Delivery to the specified location is included. 
o	Warranty is valid for 1 year from the date of delivery.', 0, 1, 0, N'alikabir20@gmail.com', '2024-10-05 18:42:45.150');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A023', '2024-12-21 00:00:00.000', N'SDK/2024-25/23/PO', NULL, N'With Purchase Order', 8, 5, 809951.6900, 0.0000, 0.0000, 4522648.2000, 5332599.8900, 5332600.0000, -0.1100, N'-', N'', N'Ship To:
Ship To:
M/s SDK SOLUTIONS
NEAR DON BOSCO SCHOOL ROAD
SEVOKE ROAD
SILIGURI-734001
Ph: 9733116514', N'1.	Prices are firm and no escalation will be entertained
2.	Rates are inclusive of all applicable taxes
3.	Material should be delivered as the schedule which will be provided within seven days from 
         delivery of this PO. 
4.	Delivery charge as per actual to be delivered at Siliguri West Bengal.
5.	Material should be delivered without any physical damage. In case any damage is found, 
         JRMS will replace/repair the item to the satisfaction of the end client
6.	Payment Terms: 30% advance upon acceptance of this PO & 70%  after materials have 
         been shipped
', 0, 1, 0, N'kabita.tamang@netspeq.com', '2024-12-24 11:29:10.163');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI24A024', '2024-12-24 00:00:00.000', N'SDK/2024-25/24/PO', NULL, N'With Purchase Order', 9, 1, 0.0000, 60021.0000, 60021.0000, 666900.0000, 786942.0000, 786942.0000, 0.0000, N'Purchase of 494 600 VA UPS', N'', N'Sabir Alam (SDK Solutions)
3rd Floor Multi storied RCC Commercial Building,
Cintury Complex, Near V-Guard Industries Limited,
Unit-2 Majitar, Rangpo, Sikkim 737132
Phone: +91 9733116514 | Email: info@sdksolution.in', N'1. Warranty: 1-year onsite warranty.
2. Product Condition: All supplied items must be new. Refurbished items will not be accepted and must be returned to the supplier for a full refund, inclu
ding transportation costs.
3. Delivery Timeline: Within 30 days from the issue of this PO.
4. Product Insurance & Condition: All supplied items must be insured and delivered free of any physical damage. Any damaged items must be replaced
 with brand-new products.
5. Payment Terms: 100% advance payment at the time of material dispatch.
6. Pricing: Rates are fixed and inclusive of delivery charges; no price escalation will be accepted.', 0, 1, 0, N'alikabir20@gmail.com', '2024-12-24 11:38:22.703');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI25A025', '2025-01-14 00:00:00.000', N'SDK/2024-25/25/PO', NULL, N'With Purchase Order', 8, 4, 0.0000, 9854.2500, 9854.2500, 109491.6800, 129200.1800, 129200.0000, 0.1800, N'-', N'', N'Sabir Alam (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116414 | Email: info@sdksolution.in', NULL, 0, 1, 0, N'kabita.tamang@netspeq.com', '2025-01-14 14:07:57.520');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI25A026', '2025-01-17 00:00:00.000', N'SDK/2024-25/26/PO', NULL, N'With Purchase Order', 8, 1, 0.0000, 2520.0000, 2520.0000, 28000.0000, 33040.0000, 33040.0000, 0.0000, N'PURCHASE OF PIPE FOR SD R 11 3 MTR FOR BIO TOILET INSTALLATION FOR 2 PHASE', N'', N'Sabir Alam (SDK Solutions)
SDK SOLUTIONS (SABIR ALAM)                    
NEAR DON BOSCO SCHOOL ROAD
SEVOKE ROAD 
Phone: +91 97331-16514 | Email: info@sdksolution.in', N'Terms & Conditions:

o The cost mentioned includes 18% GST. 
o Delivery to the specified location is included. 
o Warranty is valid for 1 year from the date of delivery.', 0, 1, 0, N'alikabir20@gmail.com', '2025-01-17 14:36:20.823');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI25A027', '2025-01-17 00:00:00.000', N'SDK/2024-25/27/PO', N'24-25/523', N'Without Purchase Order', 8, 1, 0.0000, 2599.0200, 2599.0200, 28878.0000, 34076.0400, 34076.0000, 0.0400, N'Being purchase for Bio-toilets Phase II Project.', N'2b76961e-4e54-4b60-bba7-c68aeeaa1940.pdf', N'Sabir Alam (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116414 | Email: info@sdksolution.in', NULL, 0, 1, 0, N'kabita.tamang@netspeq.com', '2025-01-21 10:20:08.417');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI25A028', '2025-01-24 00:00:00.000', N'SDK/2024-25/28/PO', N'24-25/536', N'Without Purchase Order', 9, 1, 0.0000, 1080.0000, 1080.0000, 12000.0000, 14160.0000, 14160.0000, 0.0000, N'Being transportation bill of 495 UPS from Siliguri to Gangtok.', N'638018c5-a753-42b5-877a-b0c87629c08c.pdf', N'Sabir Alam (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116414 | Email: info@sdksolution.in', NULL, 0, 1, 0, N'kabita.tamang@netspeq.com', '2025-01-25 12:39:26.200');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI25A029', '2025-03-17 00:00:00.000', N'SDK/2024-25/29/PO', NULL, N'With Purchase Order', 10010, 1, 0.0000, 86891.3500, 86891.3500, 965459.4300, 1139242.1300, 1139242.0000, 0.1300, N'A purchase order has been raised to supply 30 sets of UPS, HDD, antivirus software, and UPS 1KVA.', N'', N'Sabir Alam (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116514 | Email: info@sdksolution.in', N'1. **Warranty:** Onsite warranty as per terms and conditions.

2. **Product Condition:** All items must be new; refurbished items are not accepted and must be returned for a full refund, including shipping costs.

3. **Delivery Timeline:** Delivery within 10 days of the purchase order.

4. **Insurance and Condition:** All items must be insured and free from damage; damaged items must be replaced with new ones.

5. **Payment Terms:** 100% payment is required at material dispatch.

6. **Pricing:** Rates are fixed and include delivery; no price increases will be accepted.', 0, 1, 0, N'alikabir20@gmail.com', '2025-03-17 20:45:09.817');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI25A030', '2025-03-17 00:00:00.000', N'SDK/2024-25/30/PO', NULL, N'With Purchase Order', 10011, 1, 0.0000, 89586.0000, 89586.0000, 995400.0000, 1174572.0000, 1174572.0000, 0.0000, N'A purchase order has been raised for the supply of 474 ABC fire extinguisher for the Samagra Shiksha Education Department.', N'', N'Sabir Alam (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116514 | Email: info@sdksolution.in', N'1. Warranty: As per terms and conditions (onsite warranty)
2. Product Condition: All supplied items must be new. Refurbished items will not be accepted and must be returned to the supplier for a full refund, including transportation costs.
3. Delivery Timeline: Within 10 days from the issue of this PO.
4. Product Insurance & Condition: All supplied items must be insured and delivered free of any physical damage. Any damaged items must be replaced
 with brand-new products.
5. Payment Terms: 100% advance payment at the time of material dispatch.
6. Pricing: Rates are fixed and inclusive of delivery charges; no price escalation will be accepted.', 0, 1, 0, N'alikabir20@gmail.com', '2025-03-17 20:50:28.790');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI25A031', '2025-03-18 00:00:00.000', N'SDK/2024-25/31/PO', NULL, N'With Purchase Order', 10012, 1, 0.0000, 250651.3900, 250651.3900, 2785015.4000, 3286318.1700, 3286318.0000, 0.1700, N'PO HAS BEEN RAISED FOR PURCHASE OF MUSICAL INSTRUMENT FOR 43 PM SHRI SCHOOLS', N'', N'Sabir Alam (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116514 | Email: info@sdksolution.in', N'1. Warranty: As per terms and conditions (onsite warranty)
2. Product Condition: All supplied items must be new. Refurbished items will not be accepted and must be returned to the supplier for a full refund, including transportation costs.
3. Delivery Timeline: Within 10 days from the issue of this PO.
4. Product Insurance & Condition: All supplied items must be insured and delivered free of any physical damage. Any damaged items must be replaced
 with brand-new products.
5. Payment Terms: 100% advance payment at the time of material dispatch.
6. Pricing: Rates are fixed and inclusive of delivery charges; no price escalation will be accepted.', 0, 1, 0, N'alikabir20@gmail.com', '2025-03-18 09:58:52.507');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI25A032', '2025-03-31 00:00:00.000', N'SDK/2024-25/32/PO', NULL, N'With Purchase Order', 10011, 12, 27612.0000, 0.0000, 0.0000, 153400.0000, 181012.0000, 181012.0000, 0.0000, N'Being transportation charges for safety and security items fire extinguisher for 33 Block.', N'', N'Sabir Alam (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116414 | Email: info@sdksolution.in', NULL, 0, 1, 0, N'kabita.tamang@netspeq.com', '2025-05-03 11:28:43.737');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI25A033', '2025-03-31 00:00:00.000', N'SDK/2024-25/33/PO', NULL, N'With Purchase Order', 10012, 12, 23364.0000, 0.0000, 0.0000, 129800.0000, 153164.0000, 153164.0000, 0.0000, N'Being transportation charges for Musical instrument items for 43 PM Shri Schools.', N'', N'Sabir Alam (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116414 | Email: info@sdksolution.in', NULL, 0, 1, 0, N'kabita.tamang@netspeq.com', '2025-05-03 11:29:00.710');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI25A034', '2025-03-31 00:00:00.000', N'SDK/2024-25/34/PO', NULL, N'With Purchase Order', 10011, 12, 6372.0000, 0.0000, 0.0000, 35400.0000, 41772.0000, 41772.0000, 0.0000, N'Being transportation charges for providing logistics in different schools, BAC, AMC.', N'', N'Sabir Alam (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116414 | Email: info@sdksolution.in', NULL, 0, 1, 0, N'kabita.tamang@netspeq.com', '2025-05-03 11:29:15.143');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI25A035', '2025-03-25 00:00:00.000', N'SDK/2025-26/1/PO', N'24-25/643', N'Without Purchase Order', 10010, 1, 0.0000, 1464.7500, 1464.7500, 16275.5000, 19205.0000, 19205.0000, 0.0000, N'PURCHASE OF KB+MOUSE FOR OPS PROJECT', N'c2d29576-001a-46b9-85d2-083c806bc1b6.jpeg', N'Sabir Alam (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116414 | Email: info@sdksolution.in', NULL, 0, 1, 0, N'kabita.tamang@netspeq.com', '2025-04-07 12:46:06.583');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI25A036', '2025-05-03 00:00:00.000', N'SDK/2025-26/2/PO', NULL, N'With Purchase Order', 10015, 1, 0.0000, 163472.7900, 163472.7900, 1816364.3600, 2143309.9400, 900000.0000, 1243309.9400, N'PO for Supply of Laptops and Printer for 26 Forest Check Post', N'', N'Sabir Alam (SDK Solutions)
SNOD Complex Deorali Gangtok,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116514 | Email: info@sdksolution.in', N'1. **Warranty**: The warranty for on-site laptops and CCTV cameras is provided under the specified terms and conditions.
2. **Product Condition**: All items must be brand new. Refurbished items are not accepted and must be returned for a full refund, including shipping costs.
3. **Delivery Timeline**: Delivery will occur within 7 days of the purchase order date.
4. **Payment Terms**: Full payment of 100% is required upon the dispatch of materials.
5. **Pricing**: Rates are fixed and include delivery; no price increases will be accepted.', 0, 1, 0, N'alikabir20@gmail.com', '2025-05-03 11:10:13.970');
INSERT INTO [utblPurchaseInvoiceKeys] ([PurchaseInvoiceID], [PurchaseDate], [PORefNo], [BillNo], [POType], [ProjectID], [VenderID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AmountPaid], [BalanceAmount], [Remarks], [UploadBill], [ShipTo], [TermsConditions], [IsPOCancelled], [HasMarkForPayment], [IsPaymentDeclined], [UserID], [LastModifiedOn]) VALUES (N'PI25A037', '2025-05-06 00:00:00.000', N'SDK/2025-26/3/PO', NULL, N'With Purchase Order', 4, 1, 0.0000, 13728.8100, 13728.8100, 152542.3800, 180000.0100, 0.0000, 180000.0100, N'being purchase of 3nos of laptop for office use ', N'', N'Sabir Alam (SDK Solutions)
Second Floor Deewan Building,
Daragoan,Tadong, Gangtok, East Sikkim - 737102
Phone: +91 9733116414 | Email: info@sdksolution.in', NULL, 0, 1, 0, N'kabita.tamang@netspeq.com', '2025-05-06 13:07:03.060');
GO

-- Data for table: [utblReferenceDetails] (38 rows)
SET IDENTITY_INSERT [utblReferenceDetails] ON;
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (2, '2024-03-30 00:00:00.000', N'Purchase Order', N'PURCHASE OF SAFETY AND SECURITY', N'2023-24', N'SDK/2023-24/1/PO', N'BUY4M', 1, 1, 0, N'alikabir20@gmail.com', '2024-06-04 14:48:39.460');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (3, '2024-05-06 00:00:00.000', N'Purchase Order', N'PURCHASE OF FRP BIO TOILET FOR TENPAL EMPORIUM ', N'2024-25', N'SDK/2024-25/1/PO', N'JRMS Engineering Works', 5, 1, 0, N'alikabir20@gmail.com', '2024-06-04 15:51:10.257');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (4, '2024-05-20 00:00:00.000', N'Purchase Order', N'PURCHASE OF WATER TANK 1000 LTRS FOR PROJECT BIO TOILET', N'2024-25', N'SDK/2024-25/2/PO', N'Forever Poly Products', 4, 2, 0, N'alikabir20@gmail.com', '2024-06-04 15:54:29.700');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (5, '2024-04-30 00:00:00.000', N'Purchase Order', N'PURCHASE FOR OFFICE ASSET FOR OFFICE PURCHASE', N'2024-25', N'SDK/2024-25/3/PO', N'BUY4M', 1, 3, 0, N'alikabir20@gmail.com', '2024-06-04 16:00:38.257');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (6, '2024-04-06 00:00:00.000', N'Purchase Order', N'ITEMS PURCHASE FOR SAFETY AND SECURITY (REMAINING ITEMS)', N'2024-25', N'SDK/2024-25/4/PO', N'BUY4M', 1, 4, 0, N'alikabir20@gmail.com', '2024-06-04 16:06:07.697');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (7, '2024-04-06 00:00:00.000', N'Purchase Order', N'ITEMS PURCHASE FOR INSTALLATION OF SAFETY AND SECURITY ITEMS WHICH HAS BEEN PURCHASED NOW', N'2024-25', N'SDK/2024-25/5/PO', N'BUY4M', 1, 5, 0, N'alikabir20@gmail.com', '2024-06-04 16:09:01.787');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (8, '2024-04-09 00:00:00.000', N'Purchase Order', N'TRANSPORTATION CHARGES FOR SUPPLY TO GANGTOK', N'2024-25', N'SDK/2024-25/6/PO', N'BUY4M', 1, 6, 0, N'alikabir20@gmail.com', '2024-06-04 16:10:57.030');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (9, '2024-04-11 00:00:00.000', N'Purchase Order', N'ITEMS PURCHASED FOR NETSPEQ SOLUTION FOR THE ICT PROJECT', N'2024-25', N'SDK/2024-25/7/PO', N'BUY4M', 1, 7, 0, N'alikabir20@gmail.com', '2024-06-04 16:13:16.790');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (10, '2024-04-15 00:00:00.000', N'Purchase Order', N'ITEMS PURCHASED FOR SDK SOLUTION TADONG BACK UP SPEAKER', N'2024-25', N'SDK/2024-25/8/PO', N'BUY4M', 1, 8, 0, N'alikabir20@gmail.com', '2024-06-04 16:15:22.280');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (11, '2024-04-18 00:00:00.000', N'Purchase Order', N'Items purchase for SDK Solution Gangtok HDMI for CCTV Connection', N'2024-25', N'SDK/2024-25/9/PO', N'BUY4M', 1, 9, 0, N'alikabir20@gmail.com', '2024-06-04 16:18:26.467');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (12, '2024-04-24 00:00:00.000', N'Purchase Order', N'MS OFFICE PURCHASE FOR ADDITIONAL SEC ADMIN (TASHI AGAYA)', N'2024-25', N'SDK/2024-25/10/PO', N'BUY4M', 1, 10, 0, N'alikabir20@gmail.com', '2024-06-04 16:20:52.190');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (13, '2024-04-27 00:00:00.000', N'Purchase Order', N'A PROJECTOR HAS BEEN PURCHASED FOR BHIM THATTAL (UNDER BIMAL CHEMICAL PROJECT)', N'2024-25', N'SDK/2024-25/11/PO', N'BUY4M', 1, 11, 0, N'alikabir20@gmail.com', '2024-06-04 16:29:16.267');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (14, '2024-05-20 00:00:00.000', N'Purchase Order', N'PVC PIPE PURCHASED FOR BIO TOILET', N'2024-25', N'SDK/2024-25/12/PO', N'BUY4M', 1, 12, 0, N'alikabir20@gmail.com', '2024-06-04 16:32:30.573');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (15, '2024-05-22 00:00:00.000', N'Purchase Order', N'ITEMS PURCHASE FOR NETSPEQ SOLUTION FOR ICT PROJECT', N'2024-25', N'SDK/2024-25/13/PO', N'BUY4M', 1, 13, 0, N'alikabir20@gmail.com', '2024-06-04 16:34:25.237');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (16, '2024-05-22 00:00:00.000', N'Purchase Order', N'JAR PURCHASED FOR BIO TOILET CHEMICAL', N'2024-25', N'SDK/2024-25/14/PO', N'BUY4M', 1, 14, 0, N'alikabir20@gmail.com', '2024-06-04 16:40:53.677');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (17, '2024-05-22 00:00:00.000', N'Purchase Order', N'ITEMS PURCHASE FOR BIO TOILET', N'2024-25', N'SDK/2024-25/15/PO', N'BUY4M', 1, 15, 0, N'alikabir20@gmail.com', '2024-06-04 16:43:17.930');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (18, '2024-05-25 00:00:00.000', N'Purchase Order', N'FOR ICT AND CCTV CAMERA', N'2024-25', N'SDK/2024-25/16/PO', N'BUY4M', 1, 16, 0, N'alikabir20@gmail.com', '2024-06-04 16:47:08.377');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (19, '2024-05-27 00:00:00.000', N'Purchase Order', N'FOR BIO TOILET', N'2024-25', N'SDK/2024-25/17/PO', N'BUY4M', 1, 17, 0, N'alikabir20@gmail.com', '2024-06-04 16:49:22.817');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (20, '2024-06-06 00:00:00.000', N'Purchase Order', N'FOR BIO TOILET', N'2024-25', N'SDK/2024-25/18/PO', N'BUY4M', 1, 18, 0, N'alikabir20@gmail.com', '2024-06-04 16:51:34.863');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (21, '2024-06-04 00:00:00.000', N'Purchase Order', N'FOR ICT WORK WIN 10', N'2024-25', N'SDK/2024-25/19/PO', N'BUY4M', 1, 19, 0, N'alikabir20@gmail.com', '2024-06-04 16:55:19.413');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (22, '2024-06-04 00:00:00.000', N'Purchase Order', N'FOR PRINTED CHALLAN FOR BIO TOILET', N'2024-25', N'SDK/2024-25/20/PO', N'BUY4M', 1, 20, 0, N'alikabir20@gmail.com', '2024-06-04 16:56:42.783');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (23, '2024-06-05 00:00:00.000', N'Purchase Order', N'Purchase of Vinal Printing Sticker for Bio Toilet', N'2024-25', N'SDK/2024-25/21/PO', N'SIGN INK', 8, 21, 0, N'alikabir20@gmail.com', '2024-07-05 14:28:33.370');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (24, '2024-10-01 00:00:00.000', N'Purchase Order', N'Purchase Laptops for Rudra Trade Impex', N'2024-25', N'SDK/2024-25/22/PO', N'BUY4M', 1, 22, 0, N'alikabir20@gmail.com', '2024-10-01 13:15:54.407');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (25, '2024-12-21 00:00:00.000', N'Purchase Order', N'-', N'2024-25', N'SDK/2024-25/23/PO', N'JRMS Engineering Works', 5, 23, 0, N'kabita.tamang@netspeq.com', '2024-12-21 12:51:29.567');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (26, '2024-12-24 00:00:00.000', N'Purchase Order', N'Purchase of 494 600 VA UPS', N'2024-25', N'SDK/2024-25/24/PO', N'BUY4M', 1, 24, 0, N'alikabir20@gmail.com', '2024-12-24 11:38:22.700');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (10026, '2025-01-14 00:00:00.000', N'Purchase Order', N'-', N'2024-25', N'SDK/2024-25/25/PO', N'Forever Poly Products', 4, 25, 0, N'kabita.tamang@netspeq.com', '2025-01-14 14:07:57.520');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (10027, '2025-01-17 00:00:00.000', N'Purchase Order', N'PURCHASE OF PIPE FOR SD R 11 3 MTR FOR BIO TOILET INSTALLATION FOR 2 PHASE', N'2024-25', N'SDK/2024-25/26/PO', N'BUY4M', 1, 26, 0, N'alikabir20@gmail.com', '2025-01-17 14:36:20.820');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (10028, '2025-01-17 00:00:00.000', N'Purchase Order', N'Being purchase for Bio-toilets Phase II Project.', N'2024-25', N'SDK/2024-25/27/PO', N'BUY4M', 1, 27, 0, N'kabita.tamang@netspeq.com', '2025-01-21 10:20:08.413');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (10029, '2025-01-24 00:00:00.000', N'Purchase Order', N'Being transportation bill of 495 UPS from Siliguri to Gangtok.', N'2024-25', N'SDK/2024-25/28/PO', N'BUY4M', 1, 28, 0, N'kabita.tamang@netspeq.com', '2025-01-25 12:39:26.200');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (10030, '2025-03-17 00:00:00.000', N'Purchase Order', N'A purchase order has been raised to supply 30 sets of UPS, HDD, antivirus software, and UPS 1KVA.', N'2024-25', N'SDK/2024-25/29/PO', N'BUY4M', 1, 29, 0, N'alikabir20@gmail.com', '2025-03-17 20:45:09.813');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (10031, '2025-03-17 00:00:00.000', N'Purchase Order', N'A purchase order has been raised for the supply of 474 ABC fire extinguisher for the Samagra Shiksha Education Department.', N'2024-25', N'SDK/2024-25/30/PO', N'BUY4M', 1, 30, 0, N'alikabir20@gmail.com', '2025-03-17 20:50:28.790');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (10032, '2025-03-18 00:00:00.000', N'Purchase Order', N'PO HAS BEEN RAISED FOR PURCHASE OF MUSICAL INSTRUMENT FOR 43 PM SHRI SCHOOLS', N'2024-25', N'SDK/2024-25/31/PO', N'BUY4M', 1, 31, 0, N'alikabir20@gmail.com', '2025-03-18 09:58:52.507');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (10033, '2025-03-31 00:00:00.000', N'Purchase Order', N'Being transportation charges for safety and security items fire extinguisher for 33 Block.', N'2024-25', N'SDK/2024-25/32/PO', N'Sandesh Travels', 12, 32, 0, N'kabita.tamang@netspeq.com', '2025-04-02 17:21:42.280');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (10034, '2025-03-31 00:00:00.000', N'Purchase Order', N'Being transportation charges for Musical instrument items for 43 PM Shri Schools.', N'2024-25', N'SDK/2024-25/33/PO', N'Sandesh Travels', 12, 33, 0, N'kabita.tamang@netspeq.com', '2025-04-02 17:45:50.497');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (10035, '2025-03-31 00:00:00.000', N'Purchase Order', N'Being transportation charges for providing logistics in different schools, BAC, AMC.', N'2024-25', N'SDK/2024-25/34/PO', N'Sandesh Travels', 12, 34, 0, N'kabita.tamang@netspeq.com', '2025-04-02 18:03:29.147');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (10036, '2025-04-25 00:00:00.000', N'Purchase Order', N'PURCHASE OF KB+MOUSE FOR OPS PROJECT', N'2025-26', N'SDK/2025-26/1/PO', N'BUY4M', 1, 1, 0, N'kabita.tamang@netspeq.com', '2025-04-07 12:24:59.150');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (10037, '2025-05-03 00:00:00.000', N'Purchase Order', N'PO for Supply of Laptops and Printer for 26 Forest Check Post', N'2025-26', N'SDK/2025-26/2/PO', N'BUY4M', 1, 2, 0, N'alikabir20@gmail.com', '2025-05-03 11:10:13.970');
INSERT INTO [utblReferenceDetails] ([ReferenceID], [RefDate], [RefType], [DescORSubject], [FiscalYear], [RefNumber], [LetterTO], [VendorID], [SLNO], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (10038, '2025-05-06 00:00:00.000', N'Purchase Order', N'being purchase of 3nos of laptop for office use ', N'2025-26', N'SDK/2025-26/3/PO', N'BUY4M', 1, 3, 0, N'kabita.tamang@netspeq.com', '2025-05-06 13:07:03.060');
SET IDENTITY_INSERT [utblReferenceDetails] OFF;
GO

-- Data for table: [utblSaleInvoiceItems] (375 rows)
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'01AB81CF-6C62-4B20-B47A-CD5BBA562B0A', N'SI25A087', N'KB+MOUSE ZEBRONICS W/L COMPANION 151', N'84716040', 18, 18, 0, 0, 31, 600.0000, 18600.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'023E3FCF-455F-4DA3-BEF6-28F3B33A52B2', N'SI25A089', N'KEYBOARD STAND DOLPHIN H / LEVER', N'92099900', 18, 18, 0, 0, 40, 800.0000, 32000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'030EFEBE-7A87-4E6F-A54C-0132C43EA9CD', N'SI24A034', N'PVC POLLY PIPE', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'046002FE-6C20-43B4-AD12-C3C6D65C7A35', N'SI24A010', N'INSTALLATION CHARGES (GST)', N'998736', 18, 18, 0, 0, 3, 25500.0000, 76500.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'0506C7A0-6EAE-4AD5-9F8A-9888E87C0CA3', N'SI25A053', N'HDP Pipe
   100 MTR Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'063B260F-8B8A-476D-9B19-ED4F02E86653', N'SI24A039', N'PVC Polly Pipe', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'068AE5B4-5653-43A4-90C2-3A63B7906DB9', N'SI25A074', N'1000 Ltr. layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'06FD146B-2943-4825-B2C5-87005667885F', N'SI25A096', N'HP Scanner SJ Pro 3000 S4', N'84716050', 18, 18, 0, 0, 6, 29500.0000, 177000.0000, N'6');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'070DB9CA-2F59-4090-901E-AA8CA59A9FE2', N'SI25A081', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'09BEAE3D-63E3-40D1-B53E-C7AA47432804', N'SI24A024', N'PVC POLLY PIPE', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'09F7638B-DEA6-4FFA-AB55-4F6E0674D55C', N'SI25A091', N'AHUJA PA POWER AMP.-UBA-800DP', N'85184000', 18, 18, 0, 0, 15, 25479.8100, 382197.1500, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'0AC0DC0A-2C7B-44B6-B6B8-EBF2658F2C71', N'SI25A104', N'HP PRINTER LJ P1108 PLUS', N'84433240', 18, 18, 0, 0, 26, 11633.0000, 302458.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'0B8C82D6-5791-4A6F-885A-2FAD602CCBF0', N'SI24A042', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'0BE2F7E5-C9BD-4D94-9A74-5FB31CFEA228', N'SI24A023', N'PVC POLLY PIPE ', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'0C3A353B-A402-4816-A5CE-23620FFFF7CA', N'SI25A094', N'DUGGI TABLA', N'92030090', 0, 0, 0, 0, 13, 5392.0000, 70096.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'0D0B9006-A249-4BEE-BE11-0A0FDF3AC151', N'SI25A069', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 4, 220.0000, 880.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'0D5CC92E-4355-4533-801B-B9F3A16F50A3', N'SI24A016', N'MICROBIAL SOLUTION ', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'0DBD8A4D-4727-4C6C-84AC-EF0B9F898E4E', N'SI25A070', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'0E7DD2D1-4E97-44A5-9F51-F579CAF77745', N'SI25A096', N'Lenovo DT 12JH002VIH', N'84715000', 18, 18, 0, 0, 5, 29237.2900, 146186.4500, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'0F8D348A-46AD-421E-828F-67C1E9AD1208', N'SI24A021', N'FRP WESTERN BIO TOILET ', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'0FB4DAD9-B5A8-4AD7-8F3F-7A24955A5B35', N'SI25A104', N'ZAPPLX FOLDABLE RACK 4U', N'84733099', 18, 18, 0, 0, 12, 1190.0000, 14280.0000, N'17');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'1010D88C-5B86-492E-90E2-A0A4B348B6B3', N'SI25A054', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'103603DA-699A-4813-A7F5-A3590DAFE19A', N'SI25A055', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'1095FDF4-5360-4A6E-8871-2EBC35A674EA', N'SI24A041', N'PVC Polly Pipe', N'3917', 18, 18, 0, 0, 50, 69.0000, 3450.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'1109F920-2E0A-4EC2-A330-4057DF79F82E', N'SI25A066', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'12D4B85A-ABDB-43D0-967F-A5CC9E413904', N'SI24A019', N'PVC POLLY PIPE ', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'13BF11F9-3756-481D-9A58-BCAD08CB5543', N'SI24A009', N'INSTALLION CHARGES ', N'998736', 18, 18, 0, 0, 5, 25500.0000, 127500.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'143AD085-36D6-4A33-B216-40A14F5A6A11', N'SI25A059', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'1506ABD4-03C0-44B4-918C-1C98B39FDCD1', N'SI25A056', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 2, 220.0000, 440.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'1545506A-A451-4799-A46F-C571733B5070', N'SI24A022', N'FRP WESTERN BIO TOILET ', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'159B2026-7399-4DDB-A229-CDE51509050F', N'SI25A080', N'HDP Pipe', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'161224BF-6BA0-4DCD-AE0A-B9DB212FAE8D', N'SI25A102', N'Desktop HP SLIM  so1-PF2888IN', N'8475000', 18, 18, 0, 0, 3, 31525.4200, 94576.2600, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'166B9CE9-EA1D-4CF4-B6A4-FBB80C339885', N'SI24A038', N'Microbial solution', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'18E42678-DB73-4776-806A-659A075D3469', N'SI25A089', N'YAHMAHA KEYBOARD PSR-E383/IN', N'92071000', 18, 18, 0, 0, 9, 18200.0000, 163800.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'19283D95-4450-46E2-8E11-A8F5B509C63F', N'SI24A001', N'AVERTEK HDD 2TB SURVEILLANCE', N'84717020', 18, 18, 0, 0, 24, 4150.0000, 99600.0000, N'10');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'197715EC-5EC8-4669-8804-5146C2DF82F8', N'SI24A015', N'HDMI TO HDMI CABLE ZEBRONICS', N'854442', 18, 18, 0, 0, 5, 795.0000, 3975.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'1C124C34-88A7-4976-AED1-BEC2F9105410', N'SI25A104', N'QUICK HEAL PRO 5 USER 1 YR', N'85238020', 18, 18, 0, 0, 1, 1150.0000, 1150.0000, N'7');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'1C86CD65-DE8D-4F10-9D21-4FB9BB5F028E', N'SI24A042', N'PVC Polly Pipe', N'3917', 18, 18, 0, 0, 50, 69.0000, 3450.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'1D7B185C-EF78-4756-8A67-17054ED38BC8', N'SI24A001', N'CYBER POWER UPS 1KVA BU100E', N'85044090', 18, 18, 0, 0, 6, 4150.0000, 24900.0000, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'2225E9F1-B9E1-4F09-A38C-B2D6E942DCD2', N'SI25A102', N'HP LASERJET PRO M126A', N'84433100', 18, 18, 0, 0, 3, 15847.4600, 47542.3800, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'2243EAF8-9B53-4A9C-83C7-58464C0BCBD3', N'SI25A098', N'Transportation Charges (Kolkata to Siliguri)', N'996511', 18, 18, 0, 0, 12, 36000.0000, 432000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'22A22A33-7C09-42BB-88E8-E8225F7427ED', N'SI25A082', N'1000 Ltr. Layer Colour Tank', N'3925100', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'22F882FB-ADD9-4775-8055-A2D979E3BFA4', N'SI24A003', N'INTEX TROLLY SPEAKER T-311', N'851822', 18, 18, 0, 0, 6, 5850.0000, 35100.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'2385F0B5-5212-42C8-8482-FCAF45182B8E', N'SI25A089', N'AHUJA AMPLIFIER UBA-800', N'85434000', 18, 18, 0, 0, 6, 25479.8100, 152878.8600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'244C951D-C98D-46FE-B7F2-FFF03BA37911', N'SI24A036', N'PVC Polly Pipe', N'3917', 18, 18, 0, 0, 50, 69.0000, 3450.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'246F7D62-5BC9-4501-BDC8-289382E7C2BE', N'SI25A062', N'TF-CPVC SDR33-3MTR- 3/4"(20)', N'39172390', 18, 18, 0, 0, 2, 220.0000, 440.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'24D18D9F-BBA5-432A-8698-5C241CD6DBFA', N'SI25A060', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'24D71916-BFEF-4E14-B305-04223C05D1CC', N'SI25A082', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'267AC545-27FF-4CE5-9900-0399D4BE4E9E', N'SI25A076', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'280F6F58-12E5-406F-B761-F89B8AB246C7', N'SI25A065', N'Zebronics UPS U735', N'85044029', 18, 18, 0, 0, 248, 1450.0000, 359600.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'292A1C2B-9369-4045-AA91-7A96C7BC5310', N'SI25A062', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'29F4E8E7-93A9-4FDA-9BB9-DE40F91FCBE4', N'SI24A037', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'2A53FC0E-9062-42D6-821A-4E441B484668', N'SI25A094', N'FLUTE', N'92030090', 0, 0, 0, 0, 129, 576.0000, 74304.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'2AEE73B1-9FCA-44B3-85E6-A512BDB2DF0D', N'SI24A001', N'ELISTA LED TV 32" NH32ECA60 F', N'85285200', 18, 18, 0, 0, 6, 8300.0000, 49800.0000, N'11');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'2D08313A-840B-4F96-B505-1C616737E93A', N'SI25A104', N'ELEXON 1.50 MMM STAND ', N'85446020', 18, 18, 0, 0, 3, 1238.0000, 3714.0000, N'26');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'2E325166-0B11-4D2D-935A-901975770884', N'SI25A053', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 4, 220.0000, 880.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'2EDF1CA0-D96B-49DD-9027-CBD4D929A61A', N'SI24A043', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'2F5114E4-A738-4A77-9D5C-5ADA23A9C5C5', N'SI24A030', N'FRP WESTERN BIO TOILET ', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'300883D5-6617-4612-BA77-6D12AAB2D500', N'SI25A082', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 4, 220.0000, 880.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'319C446E-9C11-40DA-AEA7-AE6CAEA2F032', N'SI25A053', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'31AEDF9B-B727-49DE-B128-322DEBE3AFDA', N'SI24A035', N'MICROBIAL SOLUTION  ', N'30029030 ', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'31D043BC-EF3B-45FC-94BD-6EC64673F74E', N'SI25A058', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'3243B4AC-8086-495F-8D3A-F8935D0A6E4C', N'SI25A054', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 4, 220.0000, 880.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'32F90B8B-D397-44CE-9435-A07F2503E611', N'SI25A060', N'HDP Pipe
   100 MTR 1 Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'331218AC-50B6-4ADE-AD17-A06BF3DEBAAA', N'SI24A001', N'SIP DOME CAMERA 4MP COLOUR 3.6MM', N'85258900', 18, 18, 0, 0, 240, 3950.0000, 948000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'33DCCFE5-EEAB-4D50-AA38-C7A328103677', N'SI25A071', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'34649E01-2BDB-45B8-AACC-1C6AFAD5B8F1', N'SI25A104', N'ZEB SURV . POWER SUPPLY PSS08CH PRO', N'85044090', 18, 18, 0, 0, 26, 650.0000, 16900.0000, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'34F26B8F-E191-4E44-B692-F1F94136902E', N'SI24A021', N'MICROBIAL SOLUTION ', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'3599E549-C3E2-499C-9159-52900E5CA440', N'SI24A029', N'MICROBIAL SOLUTION ', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'36D0326A-387D-4ED1-B621-5CA4651659C9', N'SI25A067', N'HDP Pipe
   100 MTR 1 Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'375BB7FB-CC52-45F5-BA36-8A82B215FBCD', N'SI25A066', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 4, 220.0000, 880.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'385D3B83-F9B1-49EA-A370-98B965855754', N'SI24A045', N'Transportation charges
Siliguri to Location', N'996511', 18, 18, 0, 0, 28, 27000.0000, 756000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'38772D25-F3B6-4166-B930-978F2BD8AF32', N'SI25A077', N'1000 Ltr. layer colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'3941D2F8-A773-4D36-967D-5285271286F0', N'SI24A028', N'1000 LTR. LAYER COLOUR TANK ', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'3A723778-1908-4852-95AC-F50D5F45FC1A', N'SI24A029', N'FRP WESTERN BIO TOILET ', N'9406000', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'3B371785-8219-4279-88F1-46EE6F3B6AF8', N'SI25A092', N'ROUND OFF', N'-', 0, 0, 0, 0, 1, -0.4000, -0.4000, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'3D474644-9BF4-47C6-A97C-C430A4173BA8', N'SI25A073', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'3DDAF4E0-2692-4557-9C4F-E3A8045DA792', N'SI25A061', N'HDP Pipe
  100 MTR 1 Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'3F0E174B-2947-4907-BCB0-06236CCA86CF', N'SI25A096', N'Lenovo Monitor 19.5" E20-30', N'85285200', 18, 18, 0, 0, 5, 27966.1000, 139830.5000, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'3F44B7C7-F483-4585-9E82-8A2C84102A2B', N'SI25A104', N'SEAGATE 2TB HDD SKYHAWK', N'84717020', 18, 18, 0, 0, 26, 4550.0000, 118300.0000, N'12');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'41C55AE1-6574-4959-9F57-93FAC2C442B6', N'SI25A076', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'41EC2CF8-344D-4653-A321-F2896E5B576D', N'SI25A080', N'FRP Western Bio-Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'42EB4BC8-84B4-4A98-B00E-052314A71CE5', N'SI25A062', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 2, 30000.0000, 60000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'43A091D5-17BF-47F6-954F-AFCCD83D0457', N'SI24A038', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'43C9DD16-6C1D-4373-92B1-28DCF37901B1', N'SI25A074', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'44E84264-C39D-4792-B94C-0A0B10458E69', N'SI24A035', N'1000 Ltr. Layer Colour Tank', N'39251000 ', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'4632E925-0C8D-4011-850D-392D47735E3A', N'SI25A102', N'HP WIRELESS COMBO KM200', N'84716060', 18, 18, 0, 0, 3, 1050.0000, 3150.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'477F7C87-6735-4C5D-9082-C521CEBEB5B9', N'SI24A020', N'FRP WESTERN BIO TOILET ', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'47E6C1F2-F7FC-432E-B966-DF315C2E41AC', N'SI25A085', N'QUICKHEAL ANTIVIRUS PRO 3USER 1YR', N'85238020', 18, 18, 0, 0, 10, 1150.0000, 11500.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'4891D773-F889-4EEE-88C8-F296EA5A03C4', N'SI24A032', N'FRP WESTERN BIO TOILET ', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'49AE64BC-08F9-4637-B85D-D414075BB65E', N'SI24A046', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 145, 500.0000, 72500.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'49CBAAC9-23FD-40B8-A52E-141D8249429F', N'SI25A104', N'HIKVISION DS-2CE10KFOT-PFS 5MP BULLET', N'85258900', 18, 18, 0, 0, 104, 2450.0000, 254800.0000, N'11');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'4AA3CAD3-73F1-4A30-AB29-4D7917293FB1', N'SI25A075', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'4AB8A5BE-374D-42C6-8AE1-DAA397B691CB', N'SI25A088', N'KB+MOUSE ZEBRONICS W/L COMPANION 151', N'84716040', 18, 18, 0, 0, 10, 600.0000, 6000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'4AFE5205-2460-411C-B33E-482674FFFBBC', N'SI25A081', N'HDP Pipe', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'4B0AAAA2-69FE-4108-A7CA-B5225A4A4230', N'SI25A104', N'BILT POWER 75 GSM A4 2.3 KG', N'48025610', 12, 12, 0, 0, 26, 2680.0000, 69680.0000, N'18');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'4BA3B15B-9A85-4F3F-BEF4-D0142ADF8BBA', N'SI24A040', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'4BCCC1B9-E6A5-4506-9C42-93889B26A5A4', N'SI25A055', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 2, 30000.0000, 60000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'4C343006-E57F-49F3-AC8B-828EE0FAC24A', N'SI25A073', N'TF-CPVC SDR11-3MTR-3/4" (20)', N'39172390', 18, 18, 0, 0, 8, 220.0000, 1760.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'4D1C6E88-EA96-4C8C-BF65-F01F59E9C966', N'SI25A074', N'HDP Pipe', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'4F4919A4-AB52-46CD-B992-099337E94C53', N'SI24A015', N'HDMI CABLE 5M', N'85444999', 18, 18, 0, 0, 19, 795.0000, 15105.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'50FAA246-224A-4D1F-B042-5B29C457BB69', N'SI24A001', N'SECUREYE 8 PORT S-8FE-2UE-LD', N'851769', 18, 18, 0, 0, 48, 1950.0000, 93600.0000, N'8');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'51767ECE-A331-4A27-801A-5249953F0D46', N'SI25A071', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'51895F56-D419-4ABA-8278-F94CAF828334', N'SI25A089', N'AHUJA PA POWER AMP.UBA-800DP', N'85184000', 18, 18, 0, 0, 3, 25479.8100, 76439.4300, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'51DC12D7-FA29-4DCD-873F-9C5E0A7B1694', N'SI24A022', N'MICROBIAL SOLUTION ', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'51F3BFA5-E535-473A-BDE7-A155E4BF70A6', N'SI25A069', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'52A910DF-85FA-4822-A881-6D3A1F2BE517', N'SI25A075', N'HDP Pipe', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'53395ECC-840F-47FF-9A04-085286283F71', N'SI24A032', N'1000 LTR. LAYR COLOUR TANK ', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'53D86A40-A1BC-4C7E-A393-BCF19E6F62CC', N'SI25A056', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 2, 30000.0000, 60000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'541E2BFE-4A25-43FF-82B0-AE462292ECB7', N'SI25A104', N'TAG FILE', N'48202000', 18, 18, 0, 0, 1300, 19.5000, 25350.0000, N'21');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'54732270-CF4D-4D76-BCFC-2A6C76B5D96B', N'SI24A040', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'54C9DDA8-CE74-4F28-A8A9-50C2BDD3A850', N'SI25A104', N'CONSU CAMERA  MOUNT BOX 4/4', N'39263090', 18, 18, 0, 0, 104, 30.0000, 3120.0000, N'16');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'5505C30D-79BA-44CD-9DA5-ABA49D099D00', N'SI25A093', N'DUGGI TABLA', N'92030090', 0, 0, 0, 0, 30, 5392.0000, 161760.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'5551ADAA-E7F1-43DB-8DDC-5B2F3A25B388', N'SI25A071', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 4, 220.0000, 880.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'55B82D1D-E01F-4F39-848E-E201F21D912B', N'SI24A026', N'MICROBILA SOLUTION ', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'55EE56E5-AB04-4187-AAAB-4C0EC9DE9E39', N'SI24A034', N'FRP WESTERN BIO-TOILET ', N'940600 ', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'578C4D95-1DD7-4D20-9D65-CC527B785FAD', N'SI24A038', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'585A1A89-F154-4DBF-8EA1-0CBC628B5923', N'SI24A028', N'FRP WESTERN BIO TOILET ', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'590BED28-24D3-4CB6-8EE9-3DDFD773FC1E', N'SI25A067', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 4, 220.0000, 880.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'59765D61-0D47-4690-96A1-8E7BBB2E911B', N'SI24A047', N'PVC Polly Pipe', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'5A03C70B-B946-454D-993E-2CD5089332C6', N'SI25A068', N'HDP Pipe
   100 MTR 1 Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'5A40C18A-A9F0-4047-8167-7EDFBB3BFCF8', N'SI24A028', N'PVC POLLY PIPE ', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'5AFBF0F6-34FC-4AA0-A114-06B3B83ED8F8', N'SI24A026', N'1000 LTR. LAYER COLOUR TANK ', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'5B722382-B4EC-450B-B5AE-A83D5FE066EA', N'SI24A032', N'MICROBIAL SOLUTION ', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'5B7F9C5A-3D46-42B7-BA67-8F7EB9477A84', N'SI25A070', N'1000 Ltr. layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'5BE865D8-6DAC-4826-8CDB-DA72FC242C2B', N'SI25A080', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'5C518662-26D5-4FE1-ABF7-36B65001F942', N'SI24A021', N'1000 LTR. LAYER COLOUR TANK ', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'5C5CC493-E943-414E-B515-E4BCBBCC433C', N'SI24A022', N'1000 LTR. LAYER COLOUR TANK ', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'5D4F5B25-088E-4BC9-964D-5EB196D63F4C', N'SI24A011', N'INSTALLATION CHARGES (GST)', N'998736', 18, 18, 0, 0, 1, 25500.0000, 25500.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'5E19E994-9864-4471-BD34-9FCC96EAA2F8', N'SI24A030', N'1000 LTR. LAYER COLOUR SOLUTION ', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'60142D9B-8283-48B5-80E8-315CD8FB1274', N'SI24A036', N'1000 Ltr. layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'602EF891-71CD-4E65-8E64-D6749C88C714', N'SI24A024', N'FRP WESTERN BIO TOILET ', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'60A909F0-4BBE-443B-8900-3F26E9535B86', N'SI25A104', N'QUICK HEAL ANTIVIRUS PRO 10 USER 1 YR', N'85238020', 18, 18, 0, 0, 2, 2250.0000, 4500.0000, N'6');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'617FBA99-EF36-4570-8082-B2B3EE07CEA9', N'SI24A001', N'SECUREYE 16CH 4K NVER (SCP-STN16CA1LA)', N'85251909', 18, 18, 0, 0, 24, 6200.0000, 148800.0000, N'7');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'61B60931-D3DB-4CCB-8CC5-FE8083B4ED3E', N'SI24A002', N'CYBER POWER UPS 1KVA BU100E', N'85044090', 18, 18, 0, 0, 18, 4150.0000, 74700.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'629523E0-B713-4FB6-983E-6ABEB362922B', N'SI25A104', N'QUICK HEAL ANTIVIRUS PRO 1 USER 1 YR', N'85238020', 18, 18, 0, 0, 1, 504.4600, 504.4600, N'8');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'632C74A9-AFC4-4278-AE36-565EE2E3E08E', N'SI25A073', N'HDP Pipe', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'63EEB957-2BA3-4C08-9E56-C246D633D8C5', N'SI24A037', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'64FA85FB-9424-4D79-BC84-FC1454B4EDA7', N'SI25A085', N'UPS ZEBRONICS U1205', N'85044090', 18, 18, 0, 0, 71, 3850.0000, 273350.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'65B57F06-AA9D-429D-9DA9-3E8F5732034D', N'SI24A047', N'Microbial solution', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'65D8B709-A4F8-4902-82A3-E3F4FFB2F434', N'SI24A026', N'FRP WESTERN BIO TOILET ', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'6652F96C-75C2-4A4F-8447-974367A878BA', N'SI25A056', N'1000 ltr. Layer Colour tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'67C2607F-AF06-4B74-8E65-01F44141C8BB', N'SI24A024', N'MICROBIAL SOLUTION ', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'68512E9F-E69A-496A-AF02-B2E24D34560C', N'SI24A002', N'VOLATIC DVR RACK 4U', N'84733099', 18, 18, 0, 0, 18, 2150.0000, 38700.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'69080F7F-238F-4026-A119-7D799093391F', N'SI24A012', N'INSTALLATION CHARGES (GST)', N'998736', 18, 18, 0, 0, 8, 25500.0000, 204000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'69E2073B-E762-4A41-B010-A821DD76C551', N'SI24A050', N'Lenovo Back Pack Everyday', N'42021290', 18, 18, 0, 0, 8, 1000.0000, 8000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'69E9D95B-BC10-4033-8BCA-0540C122F58E', N'SI25A063', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 2, 30000.0000, 60000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'6A3C732B-4EF6-44C2-948C-7F910795CB4C', N'SI24A018', N'MICROBIAL SOLUTION ', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'6AD7472E-F408-43E3-81AA-0F83A8650172', N'SI24A044', N'Transportation charges
Kolkata to Siliguri', N'996511', 18, 18, 0, 0, 17, 36000.0000, 612000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'6B760193-6CE0-492E-B7CC-D79EAEC886C3', N'SI25A052', N'FRP Western BIO Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'6C760077-0A5E-435B-A21F-012A3DE26C0F', N'SI25A061', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'6CAB8C0D-29D0-4B67-B5D9-8F1FDBBCEBD2', N'SI24A018', N'1000 LTR. LAYER COLOUR TANK ', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'6CEA3B2B-5AEE-43B9-B6F9-0D4EBDF95BC8', N'SI25A080', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'6D52561D-83BD-448B-B838-23F9C1BE8955', N'SI25A059', N'TF-CPVC SDR11- 3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 2, 220.0000, 440.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'6DFC65BD-7954-4FD8-BB23-0C1A12CFE00C', N'SI24A019', N'1000 LTR. LAYER COLOUR TANK ', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'6E96A5A5-3E90-4339-B7AF-5DCC87F9F936', N'SI25A104', N'KANGRARO STAPLR NO.10', N'84729010', 18, 18, 0, 0, 52, 45.0000, 2340.0000, N'22');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'713540B2-5014-4D78-A2F9-A816787C864E', N'SI25A066', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'728C1012-BD9F-45F6-8D8F-AAACE66E7657', N'SI25A081', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'72B4A3F1-215E-4B7A-BE24-31884C3973BD', N'SI25A068', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 6, 30000.0000, 180000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'744FD37C-2BD3-4780-B304-C4AA4C3466F0', N'SI25A072', N'FRP Western BIO Toilet', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'749EF180-B92B-4FF9-A151-FD6FD172786C', N'SI25A068', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'769B3206-4AA9-4ACC-86B5-15E80C7D8E88', N'SI25A085', N'OPS I5 10TH GEN, 8GB RAM, 1TB SSD', N'84733020', 18, 18, 0, 0, 30, 24500.0000, 735000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'7752F814-A5AE-407D-8365-0E0AFC9CCF85', N'SI25A070', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'779288E6-AE9D-4614-9830-7A7EEDC2693A', N'SI25A055', N'TF- CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 2, 220.0000, 440.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'789F4E7A-00CD-41DB-A3B8-A7782D969006', N'SI24A018', N'FRP WESTERN BIO TOILET ', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'7963FB36-2A78-4AA5-895F-91A5AB5DE76D', N'SI24A001', N'INTEX TROLLY SPEAKER T-311', N'851822', 18, 18, 0, 0, 6, 8500.0000, 51000.0000, N'6');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'79802E52-799F-4FAD-AB58-FFCCDDC9FDE0', N'SI25A052', N'HDP Pipe -Qty in Gram (g)
   100 Mtr 1 Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'79DCCF59-FEF9-4125-AAAC-E142C9BDF78E', N'SI25A077', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'79E4DDED-D57A-400B-8258-8893B453C9FC', N'SI25A079', N'FRP Western Bio-Toilet', N'940600', 18, 0, 9, 9, 1, 28813.5600, 28813.5600, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'7A19B8DD-15D5-4FF7-90A3-4A074DB195B3', N'SI25A058', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 2, 30000.0000, 60000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'7A636FE6-A5B1-40BD-B33A-4741173D8F4A', N'SI25A092', N'MARACUS', N'92059090', 0, 0, 0, 0, 43, 577.0000, 24811.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'7A6F28F7-D181-458E-BC23-5DD5FF994CAA', N'SI24A042', N'1000 Ltr. Layer colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'7AFFA6FF-A5EF-4C83-90AD-4E5CA7DDAE1C', N'SI25A059', N'HDP Pipe
    100 MTR 1 Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'7C026029-382E-4549-A81A-44AF5134B37A', N'SI24A029', N'1000 LTR. LAYER COLOUR TANK ', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'7CA602C2-9B99-4AE2-9450-CCFDDDC3FF65', N'SI25A104', N'ZEB ZURV . DC JACK', N'85366910', 18, 18, 0, 0, 130, 11.0000, 1430.0000, N'14');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'7DF44E8C-80A3-4E53-AB7D-03646A4EE27F', N'SI24A020', N'PVC POLLY PIPE ', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'7FC84407-94AC-455D-A82B-67390E95E45F', N'SI24A043', N'1000 Ltr. layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'808AD584-366D-4AEE-8FFE-27C4C64565ED', N'SI24A021', N'PVC POLLY PIPE', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'82EA7E03-3587-4D06-9A99-D35A5CC0C053', N'SI25A072', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'8300733D-A409-4C27-97D9-FF9365C02C1E', N'SI25A073', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'83168132-A8AA-412D-B933-C56EBFE9B084', N'SI25A101', N'Canon DSLR Eos 1500D 18-55 ISII', N'85258900', 18, 18, 0, 0, 1, 40254.2400, 40254.2400, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'84D39696-D96D-4EB4-85DB-4F95469AA1FF', N'SI25A078', N'HDP Pipe', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'84D635D6-56A3-45E1-8DBE-9B62A90B6862', N'SI25A051', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 14, 220.0000, 3080.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'84DB69F1-0C4F-4B5A-AFC6-CB04BF16631C', N'SI25A067', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'85852DB4-A14C-4007-ACF2-760F554A87F5', N'SI25A051', N'HDP Pipe
      (100 MTR 4 Roll)', N'39173100', 18, 18, 0, 0, 34, 98.0000, 3332.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'8694DDCC-C1F5-4525-A84C-9C68CDEBA787', N'SI25A077', N'HDP Pipe', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'87E63221-745C-4BB1-B8C6-D96C3CBF500E', N'SI25A062', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'8828FB18-FCDC-4468-B04C-6BBEA287BF86', N'SI25A051', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 4, 500.0000, 2000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'8830F5B1-1DAB-452E-AFA4-17D5B6D72DEC', N'SI24A043', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'8A829888-10D6-4170-9405-B51E1AA9D184', N'SI24A035', N'PVC POLLY PIPE', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'8C3E5C56-7DC9-4492-84B2-B024980F70B4', N'SI25A060', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'8D57F4D5-6A45-4D3E-A97B-53FF99AE2731', N'SI24A027', N'PVC POLLY PIPE ', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'8DC35A4D-7223-4C36-843A-1962F0D6D684', N'SI24A008', N'FREIGHT CHARGES', N'996791', 18, 18, 0, 0, 10, 350.0000, 3500.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'8E85AC25-9241-46B6-9DA0-8C296BBDB0B1', N'SI24A030', N'MICROBIAL SOLUTION ', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'8E8FFFA2-0212-4EE3-BC09-9C900A690B6B', N'SI24A025', N'FRP WESTERN BIO TOILET ', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'8EE6B1DA-2EF2-4FE5-8D91-F94EBEC3EC9D', N'SI25A075', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'90604820-FFBB-47B8-BC8E-6811DD948A4F', N'SI24A038', N'PVC Polly Pipe', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'90862BEC-B51C-44D6-8FF1-D1500A92D780', N'SI25A070', N'HDP Pipe
  100 MTR 1 Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'90D69500-FCB9-4E99-8A68-404382384F08', N'SI24A030', N'PVC POLLY PIPE', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'90EC3E98-C0E9-475F-AE31-668008859F4F', N'SI25A076', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 8, 220.0000, 1760.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'910BC418-820A-43F0-8700-80B80ED2281D', N'SI25A055', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'91E28386-6297-4E0D-B8CE-C3755B070F15', N'SI25A057', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 2, 30000.0000, 60000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'9221ABA3-BC34-4FC8-9914-145FE5E79D6A', N'SI24A047', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'92C735FB-34D1-4616-8096-2EA68F9CD5F8', N'SI25A052', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 4, 220.0000, 880.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'93AC4BBE-3EF9-4A49-BA74-197EA4BECA83', N'SI24A019', N'FRP WESTERN BIO TOILET ', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'93C6ABC2-A9A9-4723-A86D-780E131CCC4B', N'SI24A050', N'Lenovo Laptop 82RK00VWIN', N'84713010', 18, 18, 0, 0, 8, 38500.0000, 308000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'94397D27-50CC-4F5A-9F8E-5707424349F5', N'SI25A051', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 4, 3389.8300, 13559.3200, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'96A04B42-49F3-4ED9-8CE5-E95E88C2CDE7', N'SI24A014', N'INSTALLATION CHARGES (GST)', N'998736', 18, 18, 0, 0, 2, 25500.0000, 51000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'98FDFE22-080A-4165-854D-B8C3A9A0F69C', N'SI25A072', N'TF-CPVC SDR11-3MTR- 3/4"(20)', N'39172390', 18, 18, 0, 0, 8, 220.0000, 1760.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'991020D9-B04A-4487-915B-882A3AA734E8', N'SI25A057', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'993552DD-0469-4FFF-B7C6-500383E74EF3', N'SI24A022', N'PVC POLLY PIPE ', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'99AE723A-E2D4-40E7-89E2-A7B25D41454A', N'SI25A068', N'TF- CPVC SDR11- 3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 6, 220.0000, 1320.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'99C747D8-AAAB-422A-9CC4-1E9C7FE78831', N'SI25A078', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'9A981BD3-06A6-49FC-AEC7-6813D6CD805E', N'SI25A063', N'HDP Pipe
   100 MTR 1 Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'9B1B6C4A-4581-4942-B706-B783DF0E452C', N'SI24A041', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'9C23D3BD-636A-4204-AD56-94A234469053', N'SI25A090', N'YAHMAHA KEYBOARD PSR-E383/IN', N'92071000', 18, 18, 0, 0, 34, 18200.0000, 618800.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'9C255550-C42B-4849-A014-89D6E8115680', N'SI25A074', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 8, 220.0000, 1760.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'9C5E4B1C-F105-409C-BFD7-51288BF87DA6', N'SI25A104', N'ACER MONITOR 19.5" K202QBI', N'85285200', 18, 18, 0, 0, 26, 4582.0000, 119132.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'9D791583-B981-42AA-B755-399C71C4031E', N'SI24A048', N'Self- Adhesive Vinyle Printing', N'39199090', 18, 18, 0, 0, 1736, 35.0000, 60760.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'9F1E9C8A-B2CA-4A47-9B88-EA2EF6ABCE69', N'SI24A007', N'FREIGHT & FORWARDING CHARGES (GST)', N'996791', 18, 18, 0, 0, 10, 3500.0000, 35000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'9F27D97F-D8C0-4AB1-8A3A-D80FE0C2931F', N'SI24A029', N'PVC POLLY PIPE ', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'9F9B4675-2732-4406-946B-2B0C4A2386AC', N'SI25A104', N'ZEB SURV . BNC JACK', N'85366910', 18, 18, 0, 0, 234, 16.0000, 3744.0000, N'13');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A007D696-D0AC-451D-9E38-F153BFC62C43', N'SI25A104', N'AGNI 4G PEN', N'96081019', 18, 18, 0, 0, 260, 5.5000, 1430.0000, N'24');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A032C331-CA35-4684-AD06-7D86A1B8C3B0', N'SI25A061', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A09D03A4-F478-4590-95BF-FE27556D30F9', N'SI25A104', N'KANGARO STAPLE PIN NO.10', N'83052000', 18, 18, 0, 0, 52, 5.5000, 286.0000, N'23');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A0B275D4-2A72-4FC3-8475-F069A160AFCE', N'SI25A089', N'ROUND OFF', N'-', 0, 0, 0, 0, 1, 0.8400, 0.8400, N'6');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A0B87EDB-97EA-41BF-B977-E4C5E99BB7D2', N'SI24A001', N'VOILATIC DVR RACK 4U', N'84733099', 18, 18, 0, 0, 6, 2150.0000, 12900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A1631E4A-11F5-447C-8B68-BDF93CAC8CD0', N'SI25A072', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A19B5DB7-5B96-42C1-8EFA-4581F3833B69', N'SI24A001', N'WHITE BOARD RHINO 3'' X 2''', N'9610', 18, 18, 0, 0, 60, 2800.0000, 168000.0000, N'12');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A1B9A47A-E511-4E59-A615-9871D8568BE6', N'SI24A019', N'MICROBIAL SOLUTION ', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A1D67CE4-F4CC-4A00-8FAA-3D77FCEE5CAA', N'SI25A090', N'GUITAR', N'92029000', 18, 18, 0, 0, 43, 2800.0000, 120400.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A2021D7A-AC20-49AE-901A-9E6076C30DD3', N'SI25A052', N'1000 Ltr. layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A2109765-2173-4EA5-990A-11E21957DF43', N'SI24A017', N'FRO WESTERN BIO TOILET ', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A3BF7C2C-8F2E-402A-9AC1-A24C1A10246C', N'SI25A077', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A57AA07B-BE9F-4F54-B103-A73341032862', N'SI25A061', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A5F6C265-F8DE-4170-8237-747F7F9B9BB3', N'SI24A040', N'PVC Polly Pipe', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A6127C57-BC19-4525-A335-3751E3E239D8', N'SI25A081', N'TF-CPVC SDR11-3MTR-3/4" (20)', N'39172390', 18, 18, 0, 0, 4, 220.0000, 880.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A645132B-CA58-42C0-8DC4-841AA1E77586', N'SI25A068', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A6B30FAF-A523-4255-A28C-E59431F803E5', N'SI24A035', N'FRP WESTERN BIO TOILET', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A6B9EDB7-3ED9-40CD-9336-D405DE06D062', N'SI24A020', N'MICROBIAL SOLUTION ', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A6DE61ED-5731-4D27-BB8D-3146C16B7206', N'SI25A058', N'HDP Pipe
   100 NTR 1 Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A71EE172-69AB-4418-99A0-86C27D7E8213', N'SI24A025', N'PVC POLLY PIPE ', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A7D29535-5FFA-4F11-ACC8-8F9C6CED4C4D', N'SI24A001', N'PVC BOX 5X5', N'39261011', 18, 18, 0, 0, 240, 30.0000, 7200.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A8C7CB4A-1519-440D-AC0B-92395763D99C', N'SI25A073', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A928ABF7-CE2B-4464-8169-BFD75E56F2C6', N'SI25A070', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 4, 220.0000, 880.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A95611A2-23C5-451B-93F5-F17B3D2B137A', N'SI25A052', N'Microbial solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'A9D91506-A2C8-4A47-A604-FC3BF878253C', N'SI24A036', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'AA045D8D-77B8-4858-9B23-34E7F485E17B', N'SI25A080', N'TF-CPVC SDR11-3MTR-3/4" (20)', N'39172390', 18, 18, 0, 0, 4, 220.0000, 880.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'AB307332-B0C7-4DC6-978B-0F03F7CC2D85', N'SI25A100', N'Vinal Print sticker for 3 side
', N'391990', 18, 18, 0, 0, 140, 2199.6300, 307948.2000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'AB4007E9-996A-4867-B6D2-15B5C501CAF0', N'SI24A039', N'1000 Ltr. Layer Colour Tank', N'39051000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'AB92913F-DDAC-457B-96E3-C496FC0A5763', N'SI24A025', N'MICROBIAL SOLUTION ', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'AC147207-2303-4111-8A23-70A446F67259', N'SI24A037', N'Microbial solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'AC6519AB-B334-4DDA-B258-1183D96F5AF0', N'SI24A031', N'ELISTA LED TV 32" NH32ECA60 F ', N'85285200', 18, 18, 0, 0, 2, 8300.0000, 16600.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'AC982162-BA2E-4954-8407-3053EC7B5133', N'SI25A091', N'AHUJA AMPLIFIER UBA-800', N'85434000', 18, 18, 0, 0, 19, 25479.8100, 484116.3900, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'ACACB61A-53FB-4873-9D57-93CB532B06EB', N'SI25A095', N'ROUND OFF', N'-', 0, 0, 0, 0, 1, 0.0900, 0.0900, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'AD3B03B0-2C66-41C0-B7E4-581CDCBBCC31', N'SI25A104', N'MONITOR GV 122 LED 22"', N'85285200', 18, 18, 0, 0, 26, 2850.0000, 74100.0000, N'10');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'ADB7662C-03CB-427B-9B43-56C126CA522F', N'SI25A066', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'ADE1145A-D6A7-4298-8E7B-5BB1D76A2DB3', N'SI24A040', N'100 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'AE529A02-9CFF-45B6-8F64-1ABC8621C3FB', N'SI25A091', N'ROUND OFF', N'-', 0, 0, 0, 0, 1, 0.0200, 0.0200, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'AE7AF109-6988-4DBF-A628-DF9992046A0C', N'SI25A096', N'Lenovo Monitor 19.5" E20-30', N'85285200', 18, 18, 0, 0, 5, 5932.2000, 29661.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'AF59B256-7EA6-4DC0-AB96-43987AEC9F66', N'SI25A075', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 8, 220.0000, 1760.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'AFF2F4C0-2831-44AD-90DF-CDF2B1B9880D', N'SI25A104', N'HP CARRY CASE', N'2029200', 18, 18, 0, 0, 26, 847.4600, 22033.9600, N'9');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'B1232C31-0B5E-4C19-B6E9-89CFB63679C2', N'SI24A016', N'FRP WESTERN BIO TOILET ', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'B19E6A4A-F501-4FD6-A809-79533215CDB8', N'SI25A069', N'HDP Pipe
  100 MTR 1 Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'B274239B-10D5-4E1B-A5CA-20C295A748F9', N'SI24A032', N'PVC POLLY PIPE ', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'B520A6AA-A299-4F8E-B1CB-DF7B8B5DB38F', N'SI24A034', N'MICROBIAL SOLUTION ', N'30029030 ', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'B58D22FF-0C8F-4DCA-8EF3-2EB7C62E4D95', N'SI24A042', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'B64132D6-1184-4A8E-AFE6-89B350C4B233', N'SI24A016', N'PVC POLLY PIPE ', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'B6CB4587-38C9-4006-BFEA-2CFF2E60067D', N'SI25A060', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 4, 220.0000, 880.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'B7C36A12-B73A-426A-A3F6-9EF2D7C112D8', N'SI25A051', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 14, 30000.0000, 420000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'B821E47E-B3B7-4A47-8F1A-3A99D23A8655', N'SI25A076', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'B884F762-3596-4D45-B890-5948085C3ED9', N'SI24A001', N'FIRE EXTUINGUISHER ABC 4KG BIS 15683', N'8424', 18, 18, 0, 0, 66, 4950.0000, 326700.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'B8B1386C-0A74-425B-B3C3-9A24857534B1', N'SI25A081', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'BAC99E7D-9170-4F1E-8A25-1942F8460224', N'SI25A104', N'FTC-88A FOXIN TONER CARTRIDGE ', N'48025610', 18, 18, 0, 0, 130, 340.0000, 44200.0000, N'19');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'BBAF3704-08F6-425C-995A-94486059AEF3', N'SI25A059', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'BC344AFD-6260-4C02-AA77-6D1FE226B8FA', N'SI25A071', N'HDP Pipe
  100 MTR 1 Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'BD17078A-C571-4FB0-8C22-92EC00D4332D', N'SI24A041', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'BD93C142-13B3-4C31-AE95-CC28F8168DDD', N'SI25A056', N'HDP Pipe
    100 MTR 1 Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'BDA855D9-95B6-4E27-9E2C-DD6C55055776', N'SI24A023', N'1000 LTR. LAYER COLOUR TANK ', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'BDCEF92D-9301-4EE9-80BE-C2392D6FD16C', N'SI25A057', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 2, 220.0000, 440.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'BE73C78C-D6AF-418C-8241-F3D450DA80DB', N'SI24A047', N'FRP Western BIO Toilet', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'BE73DD1E-1146-460C-A019-D0BF5EB6BD67', N'SI25A089', N'ROCKSTAR PAD20 PRO ADVANCE', N'92060000', 18, 18, 0, 0, 43, 22000.0000, 946000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'BF1CDB2B-C2F3-41F7-8508-386133F7D460', N'SI24A036', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'BF40EC70-8FB0-4274-AF7C-12B7947F8DFD', N'SI24A001', N'SECUREYE CAT6 CABLE (4 PAIR) 305M', N'85444999', 18, 18, 0, 0, 24, 5950.0000, 142800.0000, N'9');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'BF6247B5-8524-49FF-843A-FD376954D2FF', N'SI25A056', N'Microbial solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'BFBC664C-2C65-4441-BB29-96F709644B7F', N'SI25A057', N'HDP Pipe', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C0CB66B1-FEE2-4F97-B2B4-C4119B4FA39C', N'SI25A086', N'SOFTWARE (WI 10)', N'85238020', 18, 18, 0, 0, 1, 450.0000, 450.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C11BBF73-66A3-464E-BE5C-2BF408ADF87A', N'SI25A053', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C193C610-79D3-401D-B127-DB5F503BD290', N'SI25A077', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 8, 220.0000, 1760.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C19CF4C6-B3B4-473D-8DBD-7CB743569EC6', N'SI25A060', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C22427D6-B8AE-49F3-A7EE-815A6D206834', N'SI25A084', N'ABC STORED PREEUSRE TYPE EXTN 06 KGS CAP', N'84241000', 18, 18, 0, 0, 474, 2850.0000, 1350900.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C2351F31-385B-461E-94F1-F51BF9995350', N'SI25A064', N'Zebronics UPS U735', N'85044029', 18, 18, 0, 0, 247, 1450.0000, 358150.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C2DE3117-A2A5-4A29-BD9E-6D3E662B4B1E', N'SI25A055', N'HDP Pipe
    100 MTR 1 Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C3BA6B65-8086-4D4B-9BA5-18E6589FC7DC', N'SI24A020', N'1000 LTR. LAYER COLOUR TANK ', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C413BA62-2506-46ED-85C8-9BEA0CCCF8C0', N'SI25A104', N'LAPTOP HP 255 G10-B1FW9PT', N'84713010', 18, 18, 0, 0, 26, 23389.8300, 608135.5800, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C4D8EB68-C997-47DC-ABF9-5B009E4FAC0F', N'SI25A063', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 2, 220.0000, 440.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C619A6B7-DB29-4541-9868-2E99F8531581', N'SI25A059', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 2, 30000.0000, 60000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C68CC28E-7C01-4389-827B-667A62C68ACA', N'SI25A075', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C6CBE7B6-1EE9-4596-8E02-DD69995C99F1', N'SI25A104', N'EIGHT IN ONE WITH BOX SS COM', N'85371000', 18, 18, 0, 0, 52, 166.0000, 8632.0000, N'25');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C79FCE7B-34B9-4276-A561-F3CC99324EA7', N'SI24A017', N'PVC POLLY PIPE', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C8083423-22A6-4A29-AA9D-386D9DB15D0A', N'SI24A027', N'1000 LTR. LAYER COLOUR TANK ', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C86854AE-98B0-4261-8537-DEBBDD2FD660', N'SI24A023', N'MICROBIAL SOLUTION ', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C89046B2-A30E-4698-ABAA-A1DBA4AE442A', N'SI25A053', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C9971F72-287E-4304-BD22-0F47017549E3', N'SI25A069', N'Microbial Solution', N'3002930', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C9A93709-B9E6-4BEE-B816-5EF1DCFE6BEC', N'SI25A096', N'HP Printer LJ P1108 Plus', N'84433240', 18, 18, 0, 0, 9, 12288.1400, 110593.2600, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'C9F9A6F9-8A9F-4E2E-AFFF-C4DB6833C800', N'SI25A063', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'CA290A52-1C11-4B79-8DA1-6481ADBB2E52', N'SI25A082', N'HDP Pipe', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'CBB1A002-13FD-4CFC-84BB-5EF1CCC49D47', N'SI24A033', N'INTEX TROLLY SPEAKER T-311', N'851822', 18, 18, 0, 0, 2, 8500.0000, 17000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'CBF5074B-BFCF-44F5-8067-9519893D03F3', N'SI25A058', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'CD4B1F4A-24C8-49CE-9EC2-02B7638FCA0B', N'SI24A027', N'MICROBILA SOLUTION', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'CF269869-F345-4FB4-A0AD-91115EFF0FC4', N'SI25A093', N'FLUTE', N'92030090', 0, 0, 0, 0, 43, 576.0000, 24768.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'CF3365D2-AAD2-47DB-A15B-DDDED4929E32', N'SI24A004', N'INTEX TRILLY SPEAKER T-311', N'851822', 18, 18, 0, 0, 6, 5850.0000, 35100.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'CFAE549E-6DA3-49B0-8ACF-0DB5A900E927', N'SI24A041', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'D07F482A-5AC1-4C72-A444-03ED69802288', N'SI25A078', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'D1AE33FB-4606-4BD7-9214-2C7DEAF6CFCA', N'SI25A095', N'KEYBOARD BAG /I455', N'42029200', 18, 18, 0, 0, 43, 466.1000, 20042.3000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'D1E24108-5547-431D-B049-737EF25AAA6E', N'SI24A028', N'MICROBIAL SOLUTION ', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'D2DF159B-AC36-4B9A-AD2A-94E4ED2A8D33', N'SI25A069', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'D30E36FA-7B73-4E4B-8272-B81B6FB091D2', N'SI24A024', N'1000 LTR. LAYER COLOUR TANK ', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'D50646D0-BF2C-441A-A687-32F258287A59', N'SI25A082', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'D56DB7F0-A8DA-4B03-B199-B8A0F098B9D9', N'SI25A103', N'PS1 OCTOPAD ', N'92099900', 18, 18, 0, 0, 43, 1550.0000, 66650.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'D642B598-2A98-414F-8DA4-F00BF0359BF9', N'SI24A017', N'MICROBIAL SOLUTION ', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'D7AEDED2-F01B-40BC-80AC-A1381C2E5E08', N'SI25A058', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 2, 220.0000, 440.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'D7C17E41-DD9A-4B64-B261-B8F317F82022', N'SI25A054', N'HDP Pipe
 100 Mtr 1 Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'D88070C2-7A12-4D45-A8C8-A982FF029432', N'SI24A034', N'1000 Ltr. Layer Colour Tank', N'39251000 ', 18, 18, 0, 0, 2, 3389.0000, 6778.0000, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'D8DCC6D7-6943-4FAB-BDEE-22F398A01B30', N'SI25A067', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'D9C6895E-4A91-4FB9-8ECD-343ECDDFDA7B', N'SI25A067', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'DA759B39-39C2-4A7A-A19B-C4FB2DE5C942', N'SI24A002', N'ELISTA LED TV 32" NH32ECA60 F', N'85285200', 18, 18, 0, 0, 18, 8300.0000, 149400.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'DA81856B-5557-443C-80D5-CACC379D157D', N'SI25A101', N'Microtek UPS 1000VA Legend', N'85044090', 18, 18, 0, 0, 5, 4449.1500, 22245.7500, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'DADFCC11-245B-475E-8582-235060E23659', N'SI25A085', N'TOSHIBA EXT HDD 1TB', N'84717020', 18, 18, 0, 0, 30, 4600.0000, 138000.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'DAEC78DA-0986-4524-B50C-D2E9DE5C1748', N'SI24A002', N'INTEX TROLLY SPEAKER T-311', N'851822', 18, 18, 0, 0, 18, 8500.0000, 153000.0000, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'DB088DD2-44E6-4E51-A761-3E905E94C786', N'SI24A025', N'1000 LTR. LAYER COLOUR TANK ', N'39241000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'DB7F9A5A-E7BD-4CEA-AB91-3289C44C18CB', N'SI25A074', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'DC804714-FA9D-476B-9E48-90EF3A505EE7', N'SI24A031', N'AVERTEK HDD TB SURVEILLANCE ', N'84717020', 18, 18, 0, 0, 4, 4150.0000, 16600.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'DEB8A5A9-8A3C-40E6-8C2A-7338AA8A3EF8', N'SI25A104', N'ZEB SURV .CCTV CABLE 90M', N'85442090', 18, 18, 0, 0, 26, 1050.0000, 27300.0000, N'15');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'DF9C3891-88E0-453A-9584-579AC793B9EC', N'SI25A057', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'DFC9EB17-0162-4A26-B76E-46E36B3AC91C', N'SI24A006', N'FREIGHT & FORWARDING CHARGES (GST)', N'996791', 18, 18, 0, 0, 10, 3500.0000, 35000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'E070729D-E659-463E-B7D0-99C74813E62C', N'SI24A037', N'PVC Polly Pipe', N'3917', 18, 18, 0, 0, 50, 69.0000, 3450.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'E3E37815-7757-4F04-85A5-4A1ECB0D4AA2', N'SI24A039', N'Microbial Solution', N'30029030', 12, 12, 0, 0, 2, 500.0000, 1000.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'E409FBF0-C03A-4FEF-83AA-99F8119F0A30', N'SI25A062', N'HDP Pipe', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'E4A4752A-5641-4772-86B7-0245E11C6DB3', N'SI24A018', N'PVC POLLY PIPE', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'E4CC4200-09CF-42A2-8C6B-4190D3D08825', N'SI24A039', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'E5FB4300-A7EC-4E2E-AB60-94734E44E142', N'SI24A017', N'1000 LTR. LAYER COLOUR TANK ', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'E69B34A4-5FB4-4103-B402-D4687851A9AC', N'SI24A027', N'FRP WASTERN BIO TOILET ', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'E6D7E583-B7CC-487A-81D5-3747B5DFF854', N'SI25A105', N'ROUND OFF', N'-', 0, 0, 0, 0, 1, 0.1500, 0.1500, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'E719A69C-F5E7-469D-9231-FA032D017012', N'SI25A104', N'CLIPBOARD', N'39261019', 18, 18, 0, 0, 52, 85.0000, 4420.0000, N'20');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'E7DB7C9C-E8D5-44D5-B1B9-A6F12A4090DA', N'SI25A066', N'HDP Pipe
   100 MTR 1 Roll', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'E81E4589-F3D3-4FC8-9A55-039C429E5D33', N'SI25A072', N'HDP Pipe', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'EC494F18-1930-4166-903E-2DCA260C7E4A', N'SI25A063', N'1000 Ltr. layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'ECF7EDC1-8762-4D70-B807-13987516439D', N'SI25A078', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 4, 220.0000, 880.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'ED0940C2-EA0D-4C8C-B19D-22BA79567A97', N'SI25A054', N'Microbial solution', N'30029030', 12, 12, 0, 0, 1, 500.0000, 500.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'ED5961C2-E4B5-4B08-8130-9ABC0DD71620', N'SI25A071', N'1000 Ltr. Layer Colour Tank', N'39251000', 18, 18, 0, 0, 1, 3389.8300, 3389.8300, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'EDB7C895-85FF-4433-8CEE-B9EB9A845C89', N'SI25A096', N'Lenovo Value Plus Backpack (4X40Y71789)', N'42021290', 18, 18, 0, 0, 5, 847.4600, 4237.3000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'EDBB76F5-157D-480D-9E85-42AD3600B1FC', N'SI25A083', N'FRP Western Bio-Toilet', N'940600', 18, 18, 0, 0, 1, 30000.0000, 30000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'EE4D5DE4-CE57-4B69-A0E0-294168C6DE2F', N'SI24A026', N'PVCPOLLY PIPE', N'3917', 18, 18, 0, 0, 100, 69.0000, 6900.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'EF255802-37BB-4528-A800-90007F94BFC0', N'SI25A102', N'HP MONITOR 19.5 V20', N'85285200', 18, 18, 0, 0, 3, 5338.9800, 16016.9400, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'F0DB344B-595D-444B-AECF-73CB03D03929', N'SI25A092', N'CLAPBOX CB50 CAJON', N'92060000', 18, 18, 0, 0, 43, 3810.0000, 163830.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'F148E42D-FE40-4723-A632-BB5046E3BD9B', N'SI24A013', N'INSTALLATION CHARGES (GST)', N'998736', 18, 18, 0, 0, 5, 25500.0000, 127500.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'F1D8F8E9-D1A4-4289-BECB-F2C9FB822D78', N'SI25A054', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'F28D39BC-BEDF-4333-A35E-B966CB6BE962', N'SI25A078', N'FRP Western Bio Toilet', N'940600', 18, 18, 0, 0, 4, 30000.0000, 120000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'F2D6CBDD-6B9C-4B2E-96C9-E3F123B335F6', N'SI25A099', N'Transportation Charges (Loading and unloading Transportation Charges to School)', N'996511', 18, 18, 0, 0, 38, 16300.0000, 619400.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'F334BEB4-1377-4D0C-9E21-6270926FA2C7', N'SI25A085', N'QUICK HEAL ANTIVIRUS PRO 10USER 1YR', N'85238020', 18, 18, 0, 0, 30, 2550.0000, 76500.0000, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'F3E8D0E7-5E0D-4669-8D9E-A98DF503517B', N'SI25A076', N'HDP Pipe', N'39173100', 18, 18, 0, 0, 8500, 0.1000, 850.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'F3EDE3FC-5941-4600-9E02-E7A3707C5A5E', N'SI25A105', N'ZAPPLX FOLDABLE RACK 4U ', N'84733099', 18, 18, 0, 0, 14, 1443.0900, 20203.2600, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'F42B9DF1-D42F-42F7-8727-AA0BA3AF9D05', N'SI25A104', N'HIKVISION DS7108HGHI-K1 DVR', N'85219090', 18, 18, 0, 0, 26, 5400.0000, 140400.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'F447B031-CA82-4521-B6EE-EB096AEBB0ED', N'SI25A102', N'MICROTEK UPS 1000VA LEGEND', N'85044090', 18, 18, 0, 0, 3, 4406.7800, 13220.3400, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'F4B0E679-D368-4BC3-BE61-8A014C97B489', N'SI24A016', N'1000 LTR. LAYER COLOUR TANK  ', N'39251000', 18, 18, 0, 0, 2, 3389.8300, 6779.6600, N'3');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'F5EEF52A-73A4-499E-831D-7FCBC16B8BCB', N'SI25A102', N'ROUND OFF', N'-', 0, 0, 0, 0, 1, 0.0100, 0.0100, N'6');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'F6DA1EC9-4E18-438A-8BA3-95BFF48B97DC', N'SI25A097', N'FRP Western Bio-Toilet', N'940600', 18, 18, 0, 0, 1, 30000.0000, 30000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'F7837EA1-6051-49BB-A826-05C72B970A5E', N'SI24A023', N'FRP WESTERN BIO TOILET ', N'940600', 18, 18, 0, 0, 8, 30000.0000, 240000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'F7843226-2079-4BBB-808C-1CF69DDAC738', N'SI24A005', N'FREIGHT & FORWARDING CHARGES (GST) ', N'996791', 18, 18, 0, 0, 10, 3500.0000, 35000.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'FA4298A5-AB09-49EE-80EB-8C71442A4C9C', N'SI25A095', N'KEYBOARD STAND DOLPHIN H / LEVER ', N'92099900', 18, 18, 0, 0, 3, 800.0000, 2400.0000, N'1');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'FA867441-A4D6-4591-835A-FA525A0273CD', N'SI24A048', N'Lamination Pesting', N'39204900', 18, 18, 0, 0, 1736, 10.0000, 17360.0000, N'2');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'FD87DEC1-5A14-40BB-82FF-BC0A7A206F07', N'SI24A043', N'PVC Polly Pipe', N'3917', 18, 18, 0, 0, 50, 69.0000, 3450.0000, N'4');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'FDE0EDF0-32DB-429C-A21C-AD7C338B993C', N'SI25A061', N'TF-CPVC SDR11-3MTR- 3/4" (20)', N'39172390', 18, 18, 0, 0, 4, 220.0000, 880.0000, N'5');
INSERT INTO [utblSaleInvoiceItems] ([ItemDtlID], [SaleInvoiceID], [ItemName], [ItemHSNCode], [GSTPercentage], [IGSTPercentage], [CGSTPercentage], [SGSTPercentage], [Qty], [Rate], [Amount], [SequenceNo]) VALUES (N'FFD0FF4B-1C15-4CEE-9A32-51090253619C', N'SI24A049', N'Software (Wi 10)', N'85238020', 18, 18, 0, 0, 300, 280.0000, 84000.0000, N'1');
GO

-- Data for table: [utblSaleInvoiceKeys] (105 rows)
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A001', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-04-01 00:00:00.000', N'SS/2024-25/1/INV', 2, 1, 373194.0000, 0.0000, 0.0000, 2073300.0000, 2446494.0000, 0.0000, N'', 2446494.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 12:09:09.783');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A002', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-04-02 00:00:00.000', N'SS/2024-25/2/INV', 2, 1, 74844.0000, 0.0000, 0.0000, 415800.0000, 490644.0000, 0.0000, N'', 490644.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 13:58:29.980');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A003', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-04-03 00:00:00.000', N'SS/2024-25/3/INV', 2, 1, 6318.0000, 0.0000, 0.0000, 35100.0000, 41418.0000, 0.0000, N'', 41418.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 14:01:14.953');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A004', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-04-04 00:00:00.000', N'SS/2024-25/4/INV', 2, 1, 6318.0000, 0.0000, 0.0000, 35100.0000, 41418.0000, 0.0000, N'', 41418.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 14:13:11.893');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A005', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-04-04 00:00:00.000', N'SS/2024-25/5/INV', 2, 1, 6300.0000, 0.0000, 0.0000, 35000.0000, 41300.0000, 0.0000, N'', 41300.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:43:32.693');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A006', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-04-05 00:00:00.000', N'SS/2024-25/6/INV', 2, 1, 6300.0000, 0.0000, 0.0000, 35000.0000, 41300.0000, 0.0000, N'', 41300.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:44:10.347');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A007', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-04-06 00:00:00.000', N'SS/2024-25/7/INV', 2, 1, 6300.0000, 0.0000, 0.0000, 35000.0000, 41300.0000, 0.0000, N'', 41300.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:44:50.843');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A008', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-04-07 00:00:00.000', N'SS/2024-25/8/INV', 2, 1, 630.0000, 0.0000, 0.0000, 3500.0000, 4130.0000, 0.0000, N'', 4130.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-07 10:34:02.667');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A009', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-04-08 00:00:00.000', N'SS/2024-25/9/INV', 2, 1, 22950.0000, 0.0000, 0.0000, 127500.0000, 150450.0000, 0.0000, N'', 150450.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:46:10.237');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A010', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-04-09 00:00:00.000', N'SS/2024-25/10/INV', 2, 1, 13770.0000, 0.0000, 0.0000, 76500.0000, 90270.0000, 0.0000, N'', 90270.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:46:40.820');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A011', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-04-10 00:00:00.000', N'SS/2024-25/11/INV', 2, 1, 4590.0000, 0.0000, 0.0000, 25500.0000, 30090.0000, 0.0000, N'', 30090.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:47:08.803');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A012', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-04-11 00:00:00.000', N'SS/2024-25/12/INV', 2, 1, 36720.0000, 0.0000, 0.0000, 204000.0000, 240720.0000, 0.0000, N'', 240720.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:47:53.033');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A013', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-04-12 00:00:00.000', N'SS/2024-25/13/INV', 2, 1, 22950.0000, 0.0000, 0.0000, 127500.0000, 150450.0000, 0.0000, N'', 150450.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-07 10:36:30.460');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A014', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-04-13 00:00:00.000', N'SS/2024-25/14/INV', 2, 1, 9180.0000, 0.0000, 0.0000, 51000.0000, 60180.0000, 0.0000, N'', 60180.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:48:50.787');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A015', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-04-18 00:00:00.000', N'SS/2024-25/15/INV', 2, 1, 3434.4000, 0.0000, 0.0000, 19080.0000, 22514.4000, 0.0000, N'', 22514.4000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:49:34.253');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A016', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-05-20 00:00:00.000', N'SS/2024-25/16/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:15:37.137');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A017', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-05-21 00:00:00.000', N'SS/2024-25/17/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL TO SDK SOLUTION', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:16:08.793');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A018', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-05-21 00:00:00.000', N'SS/2024-25/18/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:17:03.950');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A019', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-05-23 00:00:00.000', N'SS/2024-25/19/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:17:34.480');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A020', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-05-24 00:00:00.000', N'SS/2024-25/20/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:18:13.720');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A021', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-05-25 00:00:00.000', N'SS/2024-25/21/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:18:49.957');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A022', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-05-25 00:00:00.000', N'SS/2024-25/22/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:19:56.503');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A023', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-05-25 00:00:00.000', N'SS/2024-25/23/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:20:51.247');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A024', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-05-27 00:00:00.000', N'SS/2024-25/24/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL RTO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:21:57.377');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A025', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-05-27 00:00:00.000', N'SS/2024-25/25/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:22:55.193');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A026', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-05-27 00:00:00.000', N'SS/2024-25/26/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:23:56.367');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A027', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-05-30 00:00:00.000', N'SS/2024-25/27/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:25:15.027');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A028', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-05-31 00:00:00.000', N'SS/2024-25/28/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:26:07.333');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A029', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-06-01 00:00:00.000', N'SS/2024-25/29/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:26:56.673');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A030', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-06-01 00:00:00.000', N'SS/2024-25/30/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:13:58.750');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A031', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-06-01 00:00:00.000', N'SS/2024-25/31/INV', 2, 1, 5976.0000, 0.0000, 0.0000, 33200.0000, 39176.0000, 0.0000, N'', 39176.0000, N'BILL TO SDK SOLUTION ', 1, N'kabita.tamang@netspeq.com', '2024-06-06 17:32:38.310');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A032', N'', '2024-04-12 00:00:00.000', N'ACCOUNT SECTION ', '2024-06-03 00:00:00.000', N'SS/2024-25/32/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'BILL TO SDK SOLUTION ', 0, N'kabita.tamang@netspeq.com', '2024-06-06 17:39:22.950');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A033', N'SDK/2023-24/114/PO', '2024-03-29 00:00:00.000', N'ACCOUNT SECTION ', '2024-06-03 00:00:00.000', N'SS/2024-25/33/INV', 2, 1, 3060.0000, 0.0000, 0.0000, 17000.0000, 20060.0000, 0.0000, N'', 20060.0000, N'BOLL TO SDK SOLUTION ', 1, N'kabita.tamang@netspeq.com', '2024-06-06 17:41:19.773');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A034', N'', '2024-04-12 00:00:00.000', N'Proprietor', '2024-06-06 00:00:00.000', N'SS/2024-25/34/INV', 3, 2, 45782.0400, 0.0000, 0.0000, 254678.0000, 300460.0400, 0.0000, N'', 300460.0400, N'Invoice Raised for PERBING JHS & RANKA SSS', 0, N'alikabir20@gmail.com', '2024-06-08 10:40:32.127');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A035', N'TE/2024-25/01', '2024-04-12 00:00:00.000', N'Proprietor', '2024-06-06 00:00:00.000', N'SS/2024-25/35/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'Invoice Raised for ADAM POOL JHS & LOWER SYARI SS', 0, N'alikabir20@gmail.com', '2024-06-08 10:45:34.100');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A036', N'TE/2024-25/01', '2024-04-12 00:00:00.000', N'Account Section', '2024-06-07 00:00:00.000', N'SS/2024-25/36/INV', 3, 2, 22891.1700, 0.0000, 0.0000, 127339.8300, 150231.0000, 0.0000, N'', 150231.0000, N'Invoice raised for supply of Bio-toilets Items.', 0, N'kabita.tamang@netspeq.com', '2024-06-24 10:43:25.213');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A037', N'TE/2024-25/01', '2024-04-12 00:00:00.000', N'Account Section', '2024-06-07 00:00:00.000', N'SS/2024-25/37/INV', 3, 2, 22891.1700, 0.0000, 0.0000, 127339.8300, 150231.0000, 0.0000, N'', 150231.0000, N'Invoice raised for supply of Bio-Toilets Items.', 0, N'kabita.tamang@netspeq.com', '2024-06-24 11:06:13.920');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A038', N'TE/2024-25/01', '2024-04-12 00:00:00.000', N'Account Section', '2024-06-07 00:00:00.000', N'SS/2024-25/38/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'Invoice raised for supply of Bio-Toilets Items.', 0, N'kabita.tamang@netspeq.com', '2024-06-24 11:18:02.970');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A039', N'TE/2024-25/01', '2024-04-12 00:00:00.000', N'Account section', '2024-06-08 00:00:00.000', N'SS/2024-25/39/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'Invoice raised for supply of Bio-Toilets Items.', 0, N'kabita.tamang@netspeq.com', '2024-06-24 12:10:19.070');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A040', N'TE/2024-25/01', '2024-04-12 00:00:00.000', N'Account Section', '2024-06-08 00:00:00.000', N'SS/2024-25/40/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N'Invoice raised for supply of Bio-Toilets Items.', 0, N'kabita.tamang@netspeq.com', '2024-06-24 12:35:20.030');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A041', N'TE/2024-25/01', '2024-04-12 00:00:00.000', N'Account Section', '2024-06-10 00:00:00.000', N'SS/2024-25/41/INV', 3, 2, 22891.1700, 0.0000, 0.0000, 127339.8300, 150231.0000, 0.0000, N'', 150231.0000, N'Invoice raised for supply of Bio-Toilets Items.', 0, N'kabita.tamang@netspeq.com', '2024-06-25 10:47:28.740');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A042', N'TE/2024-25/01', '2024-04-12 00:00:00.000', N'Account Section', '2024-06-10 00:00:00.000', N'SS/2024-25/42/INV', 3, 2, 22891.1700, 0.0000, 0.0000, 127339.8300, 150231.0000, 0.0000, N'', 150231.0000, N'invoice raised for supply of Bio-Toilet Items.', 0, N'kabita.tamang@netspeq.com', '2024-06-25 11:04:28.083');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A043', N'TE/2024-25/01', '2024-04-12 00:00:00.000', N'Account Section', '2024-06-10 00:00:00.000', N'SS/2024-25/43/INV', 3, 2, 22891.1700, 0.0000, 0.0000, 127339.8300, 150231.0000, 0.0000, N'', 150231.0000, N'Invoice raised for supply of Bio- Toilet Items.', 0, N'kabita.tamang@netspeq.com', '2024-06-25 11:38:35.403');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A044', N'TE/2024-25/01', '2024-04-12 00:00:00.000', N'Account Section', '2024-06-17 00:00:00.000', N'SS/2024-25/44/INV', 3, 2, 110160.0000, 0.0000, 0.0000, 612000.0000, 722160.0000, 0.0000, N'', 722160.0000, N'invoice raised for transportation charges for supply of Bio-Toilets Items from calcutta to siliguri.', 0, N'kabita.tamang@netspeq.com', '2024-06-26 12:48:31.003');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A045', N'TE/2024-25/01', '2024-04-12 00:00:00.000', N'Account Section', '2024-06-17 00:00:00.000', N'SS/2024-25/45/INV', 3, 2, 136080.0000, 0.0000, 0.0000, 756000.0000, 892080.0000, 0.0000, N'', 892080.0000, N'Invoice raised for transportation charges for supply of Bio- Toilets Items from Siliguri to Location.', 0, N'kabita.tamang@netspeq.com', '2024-06-26 12:27:09.220');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A046', N'TE/2024-25/01', '2024-04-12 00:00:00.000', N'Account Section', '2024-06-18 00:00:00.000', N'SS/2024-25/46/INV', 3, 2, 8700.0000, 0.0000, 0.0000, 72500.0000, 81200.0000, 0.0000, N'', 81200.0000, N'Remaining Chemical Bill raised for Bio-Toilets Items.', 0, N'kabita.tamang@netspeq.com', '2024-07-05 15:36:14.027');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A047', N'TE/2024-25/01', '2024-04-12 00:00:00.000', N'Account Section', '2024-09-25 00:00:00.000', N'SS/2024-25/47/INV', 3, 2, 45782.3400, 0.0000, 0.0000, 254679.6600, 300462.0000, 0.0000, N'', 300462.0000, N' Suppy for Bio-Toilet.', 0, N'kabita.tamang@netspeq.com', '2024-09-26 15:11:12.977');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A048', N'TE/2024-25/01', '2024-04-12 00:00:00.000', N'Account Section', '2024-09-26 00:00:00.000', N'SS/2024-25/48/INV', 3, 2, 14061.6000, 0.0000, 0.0000, 78120.0000, 92181.6000, 0.0000, N'', 92181.6000, N'Invoice raised for Printing.', 0, N'kabita.tamang@netspeq.com', '2024-09-27 10:37:30.900');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A049', N'', NULL, N'Account Section', '2024-09-26 00:00:00.000', N'SS/2024-25/49/INV', 6, 3, 15120.0000, 0.0000, 0.0000, 84000.0000, 99120.0000, 0.0000, N'', 99120.0000, N'Being invoice raised for supply of  software (Wi 10) to Netspeq Solutions.', 0, N'kabita.tamang@netspeq.com', '2024-09-27 10:40:38.587');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI24A050', N'RTI/2024-25/02', '2024-10-01 00:00:00.000', N'Rudra Chettri', '2024-11-05 00:00:00.000', N'SS/2024-25/50/INV', 9, 7, 56880.0000, 0.0000, 0.0000, 316000.0000, 372880.0000, 0.0000, N'', 372880.0000, N'Invoice raised for supply of 8 nos Laptop for Atal Tinkering Lab of 8 PM Shri Schools.', 0, N'kabita.tamang@netspeq.com', '2024-12-11 17:08:21.113');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A051', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-18 00:00:00.000', N'SS/2024-25/51/INV', 3, 8, 79434.8400, 0.0000, 0.0000, 441971.3200, 521406.1600, 0.0000, N'', 521406.1600, N'Being invoice raised for SUPPLY OF FRP WESTERN BIO TOILET PHASE (II) 35 SCHOOLS 2024-25.', 0, N'kabita.tamang@netspeq.com', '2025-01-21 17:33:07.970');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A052', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-20 00:00:00.000', N'SS/2024-25/52/INV', 3, 8, 22578.5100, 0.0000, 0.0000, 125602.8300, 148181.3400, 0.0000, N'', 148181.3400, N' sl no. (3) Qty are given in gram value (Rate Rs. 98/Kg).  Invoice raised for supply of Western Bio-Toilet Phase (II).', 0, N'kabita.tamang@netspeq.com', '2025-01-22 11:38:07.960');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A053', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-20 00:00:00.000', N'SS/2024-25/53/INV', 3, 8, 22578.5100, 0.0000, 0.0000, 125602.8300, 148181.3400, 0.0000, N'', 148181.3400, N'Being invoice raised for supply of western Bio-toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-22 15:30:06.573');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A054', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-20 00:00:00.000', N'SS/2024-25/54/INV', 3, 8, 22578.5100, 0.0000, 0.0000, 125602.8300, 148181.3400, 0.0000, N'', 148181.3400, N'Being invoice raised for supply of FRP Western Bio-Toilets Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-22 16:19:45.983');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A055', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-20 00:00:00.000', N'SS/2024-25/55/INV', 3, 8, 11699.3100, 0.0000, 0.0000, 65162.8300, 76862.1400, 0.0000, N'', 76862.1400, N'Being invoice raised for supply of FRP Western Bio-Toilets Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-22 16:52:45.867');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A056', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-20 00:00:00.000', N'SS/2024-25/56/INV', 3, 8, 11699.3100, 0.0000, 0.0000, 65162.8300, 76862.1400, 0.0000, N'', 76862.1400, N'Being invoice raised for supply of FRP Western Bio-Toilets Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-22 17:13:36.197');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A057', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-20 00:00:00.000', N'SS/2024-25/57/INV', 3, 8, 11699.3100, 0.0000, 0.0000, 65162.8300, 76862.1400, 0.0000, N'', 76862.1400, N'Being invoice raised for supply of FRP Western BIO-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-23 10:52:31.663');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A058', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-20 00:00:00.000', N'SS/2024-25/58/INV', 3, 8, 11699.3100, 0.0000, 0.0000, 65162.8300, 76862.1400, 0.0000, N'', 76862.1400, N'Being invoice raised for supply of FRP Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-23 11:18:31.150');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A059', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-20 00:00:00.000', N'SS/2024-25/59/INV', 3, 8, 11699.3100, 0.0000, 0.0000, 65162.8300, 76862.1400, 0.0000, N'', 76862.1400, N'Being invoice raised for Supply of FRP Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-23 13:12:30.540');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A060', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-20 00:00:00.000', N'SS/2024-25/60/INV', 3, 8, 22578.5100, 0.0000, 0.0000, 125602.8300, 148181.3400, 0.0000, N'', 148181.3400, N'Being invoice raised for FRP Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-23 15:17:04.837');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A061', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-20 00:00:00.000', N'SS/2024-25/61/INV', 3, 8, 22578.5100, 0.0000, 0.0000, 125602.8300, 148181.3400, 0.0000, N'', 148181.3400, N'Being invoice raised for supply of FRP Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-23 15:36:18.947');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A062', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-22 00:00:00.000', N'SS/2024-25/62/INV', 3, 8, 11699.3100, 0.0000, 0.0000, 65162.8300, 76862.1400, 0.0000, N'', 76862.1400, N'Being invoice raised for supply of FRP Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-23 16:57:13.527');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A063', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-22 00:00:00.000', N'SS/2024-25/63/INV', 3, 8, 11699.3100, 0.0000, 0.0000, 65162.8300, 76862.1400, 0.0000, N'', 76862.1400, N'Being invoice raised for supply FRP Western Bio-Toilet Phase II', 0, N'kabita.tamang@netspeq.com', '2025-01-23 17:32:47.450');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A064', N'NS/PO/155/2024-25', '2024-12-24 00:00:00.000', N'Netspeq Solutions', '2025-01-24 00:00:00.000', N'SS/2024-25/64/INV', 6, 9, 64467.0000, 0.0000, 0.0000, 358150.0000, 422617.0000, 0.0000, N'', 422617.0000, N'Being invoice raised for supply of 495 nos UPS.', 0, N'kabita.tamang@netspeq.com', '2025-01-25 10:52:08.767');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A065', N'NS/PO/155/2024-25', '2024-12-24 00:00:00.000', N'Netspeq Solutions', '2025-01-24 00:00:00.000', N'SS/2024-25/65/INV', 6, 9, 64728.0000, 0.0000, 0.0000, 359600.0000, 424328.0000, 0.0000, N'', 424328.0000, N'Being invoice raised for the supply of 495nos of UPS.', 0, N'kabita.tamang@netspeq.com', '2025-01-25 11:10:32.650');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A066', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-28 00:00:00.000', N'SS/2024-25/66/INV', 3, 8, 22578.5100, 0.0000, 0.0000, 125602.8300, 148181.3400, 0.0000, N'', 148181.3400, N'Being invoice raised for supply of FRP Western Bio-Toilet PhaseII.', 0, N'kabita.tamang@netspeq.com', '2025-01-31 11:34:09.180');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A067', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-28 00:00:00.000', N'SS/2024-25/67/INV', 3, 8, 22578.5100, 0.0000, 0.0000, 125602.8300, 148181.3400, 0.0000, N'', 148181.3400, N'Being invoice raised for the supply of Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-31 11:43:35.467');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A068', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-28 00:00:00.000', N'SS/2024-25/68/INV', 3, 8, 33457.7100, 0.0000, 0.0000, 186042.8300, 219500.5400, 0.0000, N'', 219500.5400, N'Being invoice raised for the supply of ERP Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-31 11:52:43.350');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A069', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-28 00:00:00.000', N'SS/2024-25/69/INV', 3, 8, 22578.5100, 0.0000, 0.0000, 125602.8300, 148181.3400, 0.0000, N'', 148181.3400, N'Being invoice raised for the supply of FRP Western Bio-Toilet phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-31 12:07:05.520');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A070', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-28 00:00:00.000', N'SS/2024-25/70/INV', 3, 8, 22578.5100, 0.0000, 0.0000, 125602.8300, 148181.3400, 0.0000, N'', 148181.3400, N'Being invoice raised for the supply of FRP Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-31 15:55:11.537');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A071', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-28 00:00:00.000', N'SS/2024-25/71/INV', 3, 8, 22578.5100, 0.0000, 0.0000, 125602.8300, 148181.3400, 0.0000, N'', 148181.3400, N'Being invoice raised for the supply of FRP Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-31 16:09:01.190');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A072', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-30 00:00:00.000', N'SS/2024-25/72/INV', 3, 8, 44336.9100, 0.0000, 0.0000, 246482.8300, 290819.7400, 0.0000, N'', 290819.7400, N'Being invoice raised for the supply of FRP Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-31 16:42:47.613');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A073', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-30 00:00:00.000', N'SS/2024-25/73/INV', 3, 8, 44336.9100, 0.0000, 0.0000, 246482.8300, 290819.7400, 0.0000, N'', 290819.7400, N'Being invoice raised for the supply of FRP Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-01-31 16:48:46.203');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A074', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-30 00:00:00.000', N'SS/2024-25/74/INV', 3, 8, 44336.9100, 0.0000, 0.0000, 246482.8300, 290819.7400, 0.0000, N'', 290819.7400, N'Being invoice raised for the supply of FRP Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-02-01 12:34:34.947');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A075', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-30 00:00:00.000', N'SS/2024-25/75/INV', 3, 8, 44336.9100, 0.0000, 0.0000, 246482.8300, 290819.7400, 0.0000, N'', 290819.7400, N'Being invoice raised for the supply of FRP Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-02-03 11:18:19.780');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A076', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-30 00:00:00.000', N'SS/2024-25/76/INV', 3, 8, 44336.9100, 0.0000, 0.0000, 246482.8300, 290819.7400, 0.0000, N'', 290819.7400, N'Being invoice raised for the supply of FRP Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-02-03 12:28:47.467');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A077', N'', '2024-12-21 00:00:00.000', N'Tempel Emporium', '2025-01-30 00:00:00.000', N'SS/2024-25/77/INV', 3, 8, 44336.9100, 0.0000, 0.0000, 246482.8300, 290819.7400, 0.0000, N'', 290819.7400, N'Being invoice raised for the supply of FRP Western Bio Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-02-04 14:29:53.737');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A078', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-01-30 00:00:00.000', N'SS/2024-25/78/INV', 3, 8, 22578.5100, 0.0000, 0.0000, 125602.8300, 148181.3400, 0.0000, N'', 148181.3400, N'Being invoice raised for the supply of FRP Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-02-04 15:08:00.507');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A079', N'', NULL, N'JRMS Engineering Works', '2025-02-08 00:00:00.000', N'SS/2024-25/79/INV', 5, 10009, 0.0000, 2593.2200, 2593.2200, 28813.5600, 34000.0000, 0.0000, N'', 34000.0000, N'Being purchase return to JRMS Engineering Works. (return of 1nos of damaged Bio-Toilet).', 0, N'kabita.tamang@netspeq.com', '2025-02-15 11:48:15.293');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A080', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-02-14 00:00:00.000', N'SS/2024-25/80/INV', 3, 8, 22578.5100, 0.0000, 0.0000, 125602.8300, 148181.3400, 0.0000, N'', 148181.3400, N'Being invoice raised for the supply of western Bio-Toilet items Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-02-15 12:03:37.997');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A081', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-02-14 00:00:00.000', N'SS/2024-25/81/INV', 3, 8, 22578.5100, 0.0000, 0.0000, 125602.8300, 148181.3400, 0.0000, N'', 148181.3400, N'Being invoice raised for the supply of FRP Western Bio-toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-02-15 12:24:20.173');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A082', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-02-20 00:00:00.000', N'SS/2024-25/82/INV', 3, 8, 22578.5100, 0.0000, 0.0000, 125602.8300, 148181.3400, 0.0000, N'', 148181.3400, N'Being invoice raised for the supply of FRP Western Bio Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-02-21 11:55:59.067');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A083', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-02-20 00:00:00.000', N'SS/2024-25/83/INV', 3, 8, 5400.0000, 0.0000, 0.0000, 30000.0000, 35400.0000, 0.0000, N'', 35400.0000, N'Being invoice raised for the supply of Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-02-21 12:41:52.567');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A084', N'', NULL, N'SDK SOLUTIONS ', '2025-03-21 00:00:00.000', N'SS/2024-25/84/INV', 2, 10011, 243162.0000, 0.0000, 0.0000, 1350900.0000, 1594062.0000, 0.0000, N'', 1594062.0000, N'BEING INVOICE RAISED FOR SUPPLY OF FIRE EXTINGUISHER (SAFETY PROJECT PHASE II) TO SDK SOLUTIONS GTK', 0, N'kabita.tamang@netspeq.com', '2025-03-24 10:46:21.697');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A085', N'', NULL, N'Netspeq Solutions', '2025-03-22 00:00:00.000', N'SS/2024-25/85/INV', 6, 10010, 222183.0000, 0.0000, 0.0000, 1234350.0000, 1456533.0000, 0.0000, N'', 1456533.0000, N'Being Invoice raised for the supply of OPS HDD and anti-virus for PM Shri schools.', 0, N'kabita.tamang@netspeq.com', '2025-03-26 15:49:20.790');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A086', N'', '2025-03-24 00:00:00.000', N'SDK SOLUTION', '2025-03-25 00:00:00.000', N'SS/2024-25/86/INV', 2, 10013, 81.0000, 0.0000, 0.0000, 450.0000, 531.0000, 0.0000, N'', 531.0000, N'-', 1, N'kabita.tamang@netspeq.com', '2025-04-02 11:19:49.610');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A087', N'', NULL, N'NETSPEQ SOLUTION', '2025-03-25 00:00:00.000', N'SS/2024-25/87/INV', 6, 10010, 3348.0000, 0.0000, 0.0000, 18600.0000, 21948.0000, 0.0000, N'', 21948.0000, N'SUPPLY OF KEYBORD AND MOUSE OF OPS PROJECT', 0, N'kabita.tamang@netspeq.com', '2025-04-01 12:54:37.883');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A088', N'', NULL, N'NETSPEQ SOLUTION', '2025-03-26 00:00:00.000', N'SS/2024-25/88/INV', 6, 10010, 1080.0000, 0.0000, 0.0000, 6000.0000, 7080.0000, 0.0000, N'', 7080.0000, N'SUPPLY OF KEYBOARD AND MOUSE OF OPS PROJECT', 0, N'kabita.tamang@netspeq.com', '2025-04-01 13:00:16.137');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A089', N'', NULL, N'M/S NANCHEYBONG', '2025-03-26 00:00:00.000', N'SS/2024-25/89/INV', 11, 10012, 246801.2900, 0.0000, 0.0000, 1371119.1300, 1617920.4200, 0.4200, N'ROUNDOFF', 1617920.0000, N'SUPPLY OF MUSICIAL INSTRUMENT FOR 43 PM SHREE SCHOOL', 0, N'kabita.tamang@netspeq.com', '2025-04-01 13:15:12.280');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A090', N'', NULL, N'M/S NAMCHEYBONG', '2025-03-26 00:00:00.000', N'SS/2024-25/90/INV', 11, 10012, 133056.0000, 0.0000, 0.0000, 739200.0000, 872256.0000, 0.0000, N'', 872256.0000, N'SUPPLY OF MUSICAL INSTRUMENT TO 43 PM SHREE SCHOOL', 0, N'kabita.tamang@netspeq.com', '2025-04-01 13:19:24.073');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A091', N'', NULL, N'M/S NAMCHEYBONG', '2025-03-27 00:00:00.000', N'SS/2024-25/91/INV', 11, 10012, 155936.4400, 0.0000, 0.0000, 866313.5600, 1022250.0000, 0.0000, N'', 1022250.0000, N'SUPPLY OF MUSICAL INSTRUMENT FOR 43 PM SHREE SCHOOL', 0, N'kabita.tamang@netspeq.com', '2025-04-01 13:40:36.763');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A092', N'', NULL, N'M/S NAMCHEYBONG', '2025-03-27 00:00:00.000', N'SS/2024-25/92/INV', 11, 10012, 29489.4000, 0.0000, 0.0000, 188640.6000, 218130.0000, 0.0000, N'', 218130.0000, N'SUPPLY OF MUSICAL INSTRUMENT FOR 43 PM SHREE SCHOOL', 0, N'kabita.tamang@netspeq.com', '2025-04-01 13:56:03.500');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A093', N'', NULL, N'M/S NAMCHEYBONG', '2025-03-27 00:00:00.000', N'SS/2024-25/93/INV', 11, 10012, 0.0000, 0.0000, 0.0000, 186528.0000, 186528.0000, 0.0000, N'', 186528.0000, N'SUPPLY OF MUSICAL INSTRUMENT FOR 43PM SHREE SCHOOL', 0, N'kabita.tamang@netspeq.com', '2025-04-01 13:59:54.597');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A094', N'', NULL, N'M/S NAMCHEYBONG', '2025-03-30 00:00:00.000', N'SS/2024-25/94/INV', 11, 10012, 0.0000, 0.0000, 0.0000, 144400.0000, 144400.0000, 0.0000, N'', 144400.0000, N'SUPPLY OF MUSICAL INSTRUMENT FOR 43 PM SHREE SCHOOL', 0, N'kabita.tamang@netspeq.com', '2025-04-01 14:04:28.457');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A095', N'', NULL, N'M/S NAMCHEYBONG', '2025-03-30 00:00:00.000', N'SS/2024-25/95/INV', 11, 10012, 4039.6100, 0.0000, 0.0000, 22442.3900, 26482.0000, 0.0000, N'', 26482.0000, N'SUPPLY OF MUSICAL INSTRUMENT FOR 43 PM SHREE SCHOOL', 0, N'kabita.tamang@netspeq.com', '2025-04-01 14:10:05.777');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A096', N'', '2025-03-30 00:00:00.000', N'SDK Solution', '2025-03-31 00:00:00.000', N'SS/2024-25/96/INV', 2, 10014, 109351.5300, 0.0000, 0.0000, 607508.5100, 716860.0400, 0.0000, N'', 716860.0400, N'Supply of Computer & Accesories to SDk Solution Gangtok.', 0, N'kabita.tamang@netspeq.com', '2025-04-04 13:30:25.220');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A097', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-03-31 00:00:00.000', N'SS/2024-25/97/INV', 3, 8, 5400.0000, 0.0000, 0.0000, 30000.0000, 35400.0000, 0.0000, N'', 35400.0000, N'Being invoice raised for the supply of FRP Western Bio-Toilet Phase II.', 0, N'kabita.tamang@netspeq.com', '2025-04-04 13:43:29.160');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A098', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-03-31 00:00:00.000', N'SS/2024-25/98/INV', 3, 8, 77760.0000, 0.0000, 0.0000, 432000.0000, 509760.0000, 0.0000, N'', 509760.0000, N'Being invoice raised for Transportation charges from Kolkata to Siliguri.', 0, N'kabita.tamang@netspeq.com', '2025-04-04 13:55:52.277');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A099', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-03-31 00:00:00.000', N'SS/2024-25/99/INV', 3, 8, 111492.0000, 0.0000, 0.0000, 619400.0000, 730892.0000, 0.0000, N'', 730892.0000, N'Being in voice raised for transportation Charges For Loanding and Unloading to Schools.', 0, N'kabita.tamang@netspeq.com', '2025-04-04 13:58:41.673');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A100', N'', '2024-12-21 00:00:00.000', N'Tenpel Emporium', '2025-03-31 00:00:00.000', N'SS/2024-25/100/INV', 3, 8, 55430.6800, 0.0000, 0.0000, 307948.2000, 363378.8800, 0.0000, N'', 363378.8800, N'SUPPLY  Vinial printing for  FRP WESTERN BIO TOILET PHASE (II) 35 SCHOOLS 2024-25', 0, N'kabita.tamang@netspeq.com', '2025-04-04 14:51:33.827');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A101', N'', '2025-03-30 00:00:00.000', N'SDK Solution', '2025-04-01 00:00:00.000', N'SS/2025-26/1/INV', 2, 10014, 11250.0000, 0.0000, 0.0000, 62499.9900, 73749.9900, 0.0000, N'', 73749.9900, N'Being invoice raised to SDK Gangtok for supply of Computer & accessories for SSLS.', 0, N'kabita.tamang@netspeq.com', '2025-05-06 16:32:19.850');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A102', N'', NULL, N'SDK Solution', '2025-04-04 00:00:00.000', N'SS/2025-26/2/INV', 2, 10016, 31411.0700, 0.0000, 0.0000, 174505.9300, 205917.0000, 0.0000, N'', 205917.0000, N'SUPPLY OF COMPUTER, PRINTER AND ITS PERIPHERALS FOR DIRECTOR EXAM EDUCATION DEPARTMENT', 0, N'kabita.tamang@netspeq.com', '2025-05-08 14:19:35.113');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A103', N'', NULL, N'M/S NAMCHEYBONG', '2025-04-06 00:00:00.000', N'SS/2025-26/3/INV', 11, 10012, 11997.0000, 0.0000, 0.0000, 66650.0000, 78647.0000, 0.0000, N'', 78647.0000, N'Supply of Musical Instrument for 43 PM Shri Schools', 0, N'kabita.tamang@netspeq.com', '2025-05-08 14:22:12.853');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A104', N'', NULL, N'NETSPEQ SOLUTION', '2025-05-12 00:00:00.000', N'SS/2025-26/4/INV', 6, 10015, 332840.4000, 0.0000, 0.0000, 1872340.0000, 2205180.4000, 0.0000, N'', 2205180.4000, N'BEING SUPPLY OF LAPTOP, COMPUTERS, AND ACCESORIES TO NETSPEQ SOLUTION', 0, N'kabita.tamang@netspeq.com', '2025-05-13 14:35:05.850');
INSERT INTO [utblSaleInvoiceKeys] ([SaleInvoiceID], [OrderNo], [OrderDate], [InvoiceTo], [InvoiceDate], [ReferenceNo], [VenderID], [ProjectID], [IGSTAmount], [CGSTAmount], [SGSTAmount], [ExcludingTaxAmt], [IncludingTaxAmt], [AdvanceReceived], [ReceivedRemarks], [BalanceAmount], [Remarks], [IsCancelled], [UserID], [LastModifiedOn]) VALUES (N'SI25A105', N'', NULL, N'NETSPEQ SOLUTION', '2025-05-15 00:00:00.000', N'SS/2025-26/5/INV', 6, 10015, 3636.5900, 0.0000, 0.0000, 20203.4100, 23840.0000, 0.0000, N'', 23840.0000, N'BEING SUPPLY OF ZAPPLX FOLDABLE RACK TO NETSPEQ SOLUTION FOR FOREST PROJECT ', 0, N'kabita.tamang@netspeq.com', '2025-05-19 11:03:19.007');
GO

