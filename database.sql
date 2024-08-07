USE [master]
GO
/****** Object:  Database [CS349Proj]    Script Date: 5/6/2023 2:39:44 PM ******/
CREATE DATABASE [CS349Proj]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CS349Proj', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\CS349Proj.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CS349Proj_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\CS349Proj_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [CS349Proj] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CS349Proj].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CS349Proj] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CS349Proj] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CS349Proj] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CS349Proj] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CS349Proj] SET ARITHABORT OFF 
GO
ALTER DATABASE [CS349Proj] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CS349Proj] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CS349Proj] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CS349Proj] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CS349Proj] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CS349Proj] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CS349Proj] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CS349Proj] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CS349Proj] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CS349Proj] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CS349Proj] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CS349Proj] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CS349Proj] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CS349Proj] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CS349Proj] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CS349Proj] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CS349Proj] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CS349Proj] SET RECOVERY FULL 
GO
ALTER DATABASE [CS349Proj] SET  MULTI_USER 
GO
ALTER DATABASE [CS349Proj] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CS349Proj] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CS349Proj] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CS349Proj] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CS349Proj] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CS349Proj] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CS349Proj', N'ON'
GO
ALTER DATABASE [CS349Proj] SET QUERY_STORE = ON
GO
ALTER DATABASE [CS349Proj] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [CS349Proj]
GO
/****** Object:  User [root]    Script Date: 5/6/2023 2:39:45 PM ******/
CREATE USER [root] FOR LOGIN [root] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [root]
GO
/****** Object:  Table [dbo].[Bills]    Script Date: 5/6/2023 2:39:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bills](
	[bill_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[bill_no] [int] NOT NULL,
	[payment_date] [smalldatetime] NOT NULL,
	[customerID] [int] NOT NULL,
	[bill_amount] [float] NOT NULL,
	[rem_amount] [float] NOT NULL,
	[paid_amount] [float] NOT NULL,
	[Status] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Bills__D7338ACB64BCCF4A] PRIMARY KEY CLUSTERED 
(
	[bill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 5/6/2023 2:39:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[customerID] [int] IDENTITY(1,1) NOT NULL,
	[customerName] [varchar](50) NOT NULL,
	[meterType] [varchar](50) NOT NULL,
	[address] [varchar](max) NOT NULL,
	[postalCode] [int] NOT NULL,
	[email] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[customerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 5/6/2023 2:39:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[invoiceID] [int] IDENTITY(1,1) NOT NULL,
	[customerID] [int] NOT NULL,
	[tariffID] [int] NOT NULL,
	[bill_no] [int] NOT NULL,
	[STD_USE] [float] NOT NULL,
	[DCIM_USE] [float] NOT NULL,
	[FAC_USE] [float] NOT NULL,
	[RESH_USE] [float] NOT NULL,
	[STD_Total] [float] NOT NULL,
	[DCIM_Total] [float] NOT NULL,
	[FAC_Total] [float] NOT NULL,
	[RESH_Total] [float] NOT NULL,
	[total_Amount] [float] NOT NULL,
	[status] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[invoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Logins]    Script Date: 5/6/2023 2:39:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logins](
	[username] [varchar](50) NOT NULL,
	[passwordHash] [binary](50) NOT NULL,
 CONSTRAINT [PK_Logins] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tariff]    Script Date: 5/6/2023 2:39:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tariff](
	[tariffID] [int] IDENTITY(1,1) NOT NULL,
	[customerID] [int] NOT NULL,
	[STD_rate] [float] NOT NULL,
	[DCIM_rate] [float] NOT NULL,
	[FAC_rate] [float] NOT NULL,
	[RESHRAM_rate] [float] NOT NULL,
 CONSTRAINT [PK_Tariff] PRIMARY KEY CLUSTERED 
(
	[tariffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bills]  WITH CHECK ADD  CONSTRAINT [FK_Bills_Customers] FOREIGN KEY([customerID])
REFERENCES [dbo].[Customers] ([customerID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Bills] CHECK CONSTRAINT [FK_Bills_Customers]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Customers] FOREIGN KEY([customerID])
REFERENCES [dbo].[Customers] ([customerID])
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Customers]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Tariff] FOREIGN KEY([tariffID])
REFERENCES [dbo].[Tariff] ([tariffID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Tariff]
GO
ALTER TABLE [dbo].[Tariff]  WITH CHECK ADD  CONSTRAINT [FK_Tariff_Customers] FOREIGN KEY([customerID])
REFERENCES [dbo].[Customers] ([customerID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Tariff] CHECK CONSTRAINT [FK_Tariff_Customers]
GO
/****** Object:  StoredProcedure [dbo].[CreateCustomer]    Script Date: 5/6/2023 2:39:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ashna
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[CreateCustomer] 
	-- Add the parameters for the stored procedure here
	@name varchar(50),
	@meterType varchar(50),
	@address varchar(MAX),
	@postal int,
	@email varchar(MAX),
	@std_rate float,
	@dcim_rate float,
	@fac_rate float,
	@resh_rate float

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @customerID int;
	INSERT INTO dbo.Customers Values(@name, @meterType, @address, @postal, @email)
	SET @customerID = (SELECT customerID from dbo.Customers where customerName = @name)

	INSERT INTO dbo.Tariff Values(@customerID, @std_rate, @dcim_rate, @fac_rate, @resh_rate)


	


   
END
GO
/****** Object:  StoredProcedure [dbo].[GetBillAmount]    Script Date: 5/6/2023 2:39:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ashna
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetBillAmount] 
	-- Add the parameters for the stored procedure here
	@customerName varchar(50), 
	@billNum int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--DECLARE @remaining_amount as float = NULL

	--SET @remaining_amount = 
	--(
	--SELECT rem_amount from dbo.Customers 
	--INNER JOIN dbo.Bills 
	--ON dbo.Customers.customerID = dbo.Bills.customerID 
	--AND dbo.Bills.bill_no = @billNum
	--) 

    -- Insert statements for procedure here
	--IF(@remaining_amount > 0)
		--return @remaining_amount
	--ELSE IF(@remaining_amount = NULL)
		SELECT dbo.Invoice.total_Amount 
		from dbo.Customers INNER JOIN dbo.Invoice 
		ON dbo.Customers.customerID = dbo.Invoice.customerID 
		and customerName = @customerName and bill_no = @billNum
END
GO
/****** Object:  StoredProcedure [dbo].[GetBillNumbersForCustomer]    Script Date: 5/6/2023 2:39:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ashna
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetBillNumbersForCustomer] 
	-- Add the parameters for the stored procedure here
	@name varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT dbo.Invoice.bill_no FROM dbo.Customers INNER JOIN  dbo.Invoice
	ON dbo.Customers.customerID = dbo.Invoice.customerID
	and customerName = @name

END
GO
/****** Object:  StoredProcedure [dbo].[GetBills]    Script Date: 5/6/2023 2:39:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ashna
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetBills] 
	-- Add the parameters for the stored procedure here
	@customerName varchar(50), 
	@startDate varchar(50),
	@endDate varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
	dbo.Customers.customerID, 
	dbo.Customers.customerName,
	dbo.Invoice.bill_no,
	dbo.Invoice.STD_USE,
	dbo.Invoice.DCIM_USE,
	dbo.Invoice.FAC_USE,
	dbo.Invoice.RESH_USE,
	dbo.Invoice.STD_Total,
	dbo.Invoice.DCIM_Total,
	dbo.Invoice.FAC_Total, 
	dbo.Invoice.RESH_Total,
	dbo.Bills.bill_amount,
	dbo.Bills.payment_date,
	dbo.Bills.paid_amount,
	dbo.Bills.Status
	FROM dbo.Customers 
	JOIN dbo.Invoice 
	ON dbo.Customers.customerID = dbo.Invoice.customerID
	JOIN dbo.Bills
	ON dbo.Invoice.customerID = dbo.Bills.customerID 
	where dbo.Customers.customerName = @customerName
	and
	dbo.Bills.payment_date between CONVERT(smalldatetime, @startDate) and CONVERT(smalldatetime, @endDate)
	ORDER BY dbo.Bills.payment_date
END
GO
/****** Object:  StoredProcedure [dbo].[GETCustomerDetails]    Script Date: 5/6/2023 2:39:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ashna
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GETCustomerDetails] 
	-- Add the parameters for the stored procedure here
	@name varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM dbo.Customers INNER JOIN  dbo.Tariff
	ON dbo.Customers.customerID = dbo.Tariff.customerID
	and customerName = @name
	
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetMeterRates]    Script Date: 5/6/2023 2:39:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ashna
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetMeterRates] 
	-- Add the parameters for the stored procedure here
	@name varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT STD_rate, DCIM_rate, FAC_rate, RESHRAM_rate from dbo.Tariff 
	INNER JOIN dbo.Customers ON dbo.Tariff.customerID = dbo.Customers.customerID and dbo.Customers.customerName = @name
END
GO
/****** Object:  StoredProcedure [dbo].[PayBill]    Script Date: 5/6/2023 2:39:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ashna
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[PayBill] 
	-- Add the parameters for the stored procedure here
	@billNum int, 
	@customerName varchar(50),
	@paymentDate varchar(50),
	@billAmount float,
	@paymentAmount float
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--SET IDENTITY_INSERT dbo.Bills ON;

	DECLARE @custID as int = (
	SELECT dbo.Invoice.customerID 
	FROM dbo.Customers 
	INNER JOIN dbo.Invoice 
	ON dbo.Customers.customerID = dbo.Invoice.customerID
	AND customerName = @customerName
	AND bill_no = @billNum)

    -- Insert statements for procedure here
	IF(@paymentAmount < @billAmount)
		INSERT INTO dbo.Bills 
		Values(@billNum, CONVERT(smalldatetime, @paymentDate), @custID, @billAmount, @billAmount - @paymentAmount, @paymentAmount, 'unpaid')
	ELSE IF(@paymentAmount >= @billAmount)
		INSERT INTO dbo.Bills 
		Values(@billNum, CONVERT(smalldatetime, @paymentDate), @custID, @billAmount, 0, @paymentAmount, 'paid')

	SET IDENTITY_INSERT dbo.Bills OFF;

END
GO
/****** Object:  StoredProcedure [dbo].[SendInvoice]    Script Date: 5/6/2023 2:39:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ashna
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SendInvoice] 
	-- Add the parameters for the stored procedure here
	@name varchar(50), 
	@std_use float = 0,
	@dcim_use float = 0,
	@fac_use float = 0,
	@resh_use float = 0,
	@std_total float = 0,
	@dcim_total float = 0,
	@fac_total float = 0,
	@resh_total float = 0,
	@totalAmount float = 0,
	@status varchar(50) = 'in-process'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @customerID int;
	DECLARE @tariffID int;
	SET @customerID = (SELECT customerID from dbo.Customers where customerName = @name)
	SET @tariffID = (SELECT tariffID from dbo.Tariff where customerID = @customerID)

	INSERT INTO dbo.Invoice Values(
	@customerID, 
	@tariffID, 
	ABS(CHECKSUM(NewId())) % 50, 
	@std_use, 
	@dcim_use, 
	@fac_use, 
	@resh_use, 
	@std_total, 
	@dcim_total, 
	@fac_total, 
	@resh_total, 
	@totalAmount, 
	@status)
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateCustomer]    Script Date: 5/6/2023 2:39:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ashna
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[UpdateCustomer] 
	-- Add the parameters for the stored procedure here
	@name varchar(50), 
	@newName varchar(50),
	@newMeter varchar(50),
	@newAddress varchar(MAX),
	@newZipCode int,
	@newEmail varchar(MAX),
	@newDCIM float,
	@newSTD float,
	@newFAC float,
	@newRESH float




AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @custID as int

	SET @custID = (SELECT customerID from dbo.Customers where customerName = @name)

    -- Insert statements for procedure here
	UPDATE dbo.Customers
	SET customerName = @newName, meterType = @newMeter, address = @newAddress, email = @newEmail
	WHERE customerName = @name

	UPDATE dbo.Tariff
	SET DCIM_rate = @newDCIM, STD_rate = @newSTD, FAC_rate = @newFAC, RESHRAM_rate = @newRESH
	WHERE customerID = @custID
END
GO
/****** Object:  StoredProcedure [dbo].[UserAuth]    Script Date: 5/6/2023 2:39:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ashna
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[UserAuth] 
	-- Add the parameters for the stored procedure here
	@username varchar(50), 
	@password varchar(50),
	@result int = '0' output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM dbo.Logins WHERE username = @username AND passwordHash = HASHBYTES('SHA1', @password))
		SET @result = 1
	ELSE
		SET @result = 0
END
GO
USE [master]
GO
ALTER DATABASE [CS349Proj] SET  READ_WRITE 
GO
