USE [NW4PA]
GO
/****** Object:  Schema [AdminSPs]    Script Date: 7/26/2025 5:33:34 AM ******/
CREATE SCHEMA [AdminSPs]
GO
/****** Object:  Schema [BackupSPs]    Script Date: 7/26/2025 5:33:34 AM ******/
CREATE SCHEMA [BackupSPs]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_FullName]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_FullName]
(
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100)
)
RETURNS NVARCHAR(201)
AS
BEGIN
    DECLARE @First NVARCHAR(100) = NULLIF(LTRIM(RTRIM(@FirstName)), '')
    DECLARE @Last NVARCHAR(100)  = NULLIF(LTRIM(RTRIM(@LastName)), '')
    DECLARE @FullName NVARCHAR(201)

    IF @First IS NOT NULL AND @Last IS NOT NULL
        SET @FullName = @First + ' ' + @Last
    ELSE IF @First IS NOT NULL
        SET @FullName = @First
    ELSE IF @Last IS NOT NULL
        SET @FullName = @Last
    ELSE
        SET @FullName = ''

    RETURN @FullName
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_FullNameLF]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_FullNameLF]
(
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100)
)
RETURNS NVARCHAR(202)
AS
BEGIN
    DECLARE @First NVARCHAR(100) = NULLIF(LTRIM(RTRIM(@FirstName)), '')
    DECLARE @Last NVARCHAR(100)  = NULLIF(LTRIM(RTRIM(@LastName)), '')
    DECLARE @FullName NVARCHAR(202)

    IF @First IS NOT NULL AND @Last IS NOT NULL
        SET @FullName = @Last + ', ' + @First
    ELSE IF @Last IS NOT NULL
        SET @FullName = @Last
    ELSE IF @First IS NOT NULL
        SET @FullName = @First
    ELSE
        SET @FullName = ''

    RETURN @FullName
END
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Discount] [decimal](6, 3) NULL,
	[OrderDetailStatusID] [int] NOT NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [OrderDetails$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetailStatus]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetailStatus](
	[OrderDetailStatusID] [int] IDENTITY(1,1) NOT NULL,
	[OrderDetailStatusName] [nvarchar](50) NOT NULL,
	[SortOrder] [tinyint] NOT NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [OrderDetailStatus$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[OrderDetailStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Companies]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Companies](
	[CompanyID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](50) NOT NULL,
	[CompanyTypeID] [int] NOT NULL,
	[BusinessPhone] [nvarchar](20) NULL,
	[Address] [nvarchar](255) NOT NULL,
	[City] [nvarchar](255) NOT NULL,
	[StateAbbrev] [nvarchar](2) NOT NULL,
	[Zip] [nvarchar](10) NOT NULL,
	[Website] [nvarchar](1024) NULL,
	[Notes] [nvarchar](max) NULL,
	[StandardTaxStatusID] [int] NOT NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [Companies$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[OrderStatusID] [int] IDENTITY(1,1) NOT NULL,
	[OrderStatusCode] [nvarchar](5) NOT NULL,
	[OrderStatusName] [nvarchar](50) NOT NULL,
	[SortOrder] [tinyint] NOT NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [OrderStatus$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[OrderStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[InvoiceDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[ShipperID] [int] NULL,
	[ShippingFee] [money] NULL,
	[TaxRate] [decimal](6, 3) NOT NULL,
	[TaxStatusID] [int] NOT NULL,
	[PaymentMethod] [nvarchar](50) NULL,
	[PaidDate] [datetime] NULL,
	[Notes] [nvarchar](4000) NULL,
	[OrderStatusID] [int] NOT NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [Orders$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](20) NOT NULL,
	[LastName] [nvarchar](30) NOT NULL,
	[EmailAddress] [nvarchar](255) NULL,
	[JobTitle] [nvarchar](50) NOT NULL,
	[PrimaryPhone] [nvarchar](20) NULL,
	[SecondaryPhone] [nvarchar](20) NULL,
	[Title] [nvarchar](20) NULL,
	[Notes] [nvarchar](max) NULL,
	[EmployeeImagePA] [image] NULL,
	[EmployeeImageName] [nvarchar](80) NULL,
	[EmployeeImage] [varbinary](max) NULL,
	[SupervisorID] [int] NULL,
	[WindowsUserName] [nvarchar](50) NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [Employees$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_OrderList]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_OrderList]
AS

WITH OrderTotal AS
(
	SELECT O .OrderID, IsNull(Sum([Quantity]*(1-[Discount])*[UnitPrice]),0) AS OrderTotal 
	FROM Orders O Left Outer JOIN dbo.OrderDetails OD
	ON O.OrderID = OD.OrderID
	GROUP BY O.OrderID
),
OrderDetailLowest AS 
(
	SELECT OD.OrderID,
	IsNull(Min(ODS.SortOrder),10) AS MinOfSortOrder
	FROM   OrderDetails AS OD 
	LEFT OUTER JOIN  OrderDetailStatus AS ODS
	ON OD.OrderDetailStatusID = ODS.OrderDetailStatusID 
	GROUP BY OD.OrderID 
)
SELECT Distinct 
	O.OrderID,
	E.EmployeeID,
	E.FirstName + ' ' + E.LastName AS EmployeeFNLN,
	C.CompanyID as CustomerID,
	C.CompanyName AS Customer,
	O.OrderDate, 
	O.ShippedDate, 
	O.ShippingFee,
	Cast(ISNULL(OrderTotal.OrderTotal,0) AS Money) AS OrderTotal,
	OS.OrderStatusID,
	OS.OrderStatusName,
	O.PaidDate, 
	ISNull(OrderDetailLowest.MinOfSortOrder,20) AS MinOfSortOrder,
	ODS.OrderDetailStatusName
FROM dbo.Orders O INNER JOIN
     dbo.Employees AS E 
	 ON O.EmployeeID = E.EmployeeID INNER JOIN
     dbo.Companies  AS C 
	 ON O.CustomerID = C.CompanyID INNER  JOIN
     dbo.OrderStatus AS OS 
	 ON O.OrderStatusID=OS.OrderStatusID 
	 LEFT OUTER JOIN
     dbo.OrderDetails AS OD 
	 ON O.OrderID = OD.OrderID 
	 LEFT OUTER JOIN
     OrderDetailStatus AS ODS 
	 ON OD.OrderDetailStatusID = ODS.OrderDetailStatusID 
	 LEFT OUTER JOIN 
	 OrderTotal 
	 ON OD.OrderID= OrderTotal.OrderID  
	 LEFT OUTER JOIN 
	 OrderDetailLowest 
	 on ODS.SortOrder =OrderDetailLowest.MinOfSortOrder 
	 WHERE OD.OrderID = OrderDetailLowest.OrderID OR OD.ORDERID Is Null
		
			 
GO
/****** Object:  Table [dbo].[EmployeePrivileges]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeePrivileges](
	[EmployeePrivilegeID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[PrivilegeID] [int] NOT NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [EmployeePrivileges$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[EmployeePrivilegeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Privileges]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Privileges](
	[PrivilegeID] [int] IDENTITY(1,1) NOT NULL,
	[PrivilegeName] [nvarchar](50) NOT NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [Privileges$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[PrivilegeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_employees]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_employees]
AS
With EmployeePriveleges AS
(SELECT EP.EmployeeID,EP.PrivilegeID,P.PrivilegeName
FROM EmployeePrivileges AS EP INNER JOIN
Privileges AS P on EP.PrivilegeID = P.PrivilegeID
)
SELECT E.EmployeeID, 
	E.LastName, 
	E.FirstName,
	dbo.fn_FullNameLF(E.FirstName,  E.LastName) as NameLF,
	dbo.fn_FullName(E.FirstName, E.LastName) as NameFL,
	Concat(Coalesce(E.Title +' ','') ,dbo.fn_FullName(E.FirstName, E.LastName)) as NameTitleFL,
	E.EmailAddress, 
	E.JobTitle, 
	E.PrimaryPhone, 
	E.SecondaryPhone, 
	E.Title, 
	E.Notes, 
	E.SupervisorID,
	[dbo].[fn_FullName](S.FirstName, S.LastName ) as  Supervisor,
	E.WindowsUserName, 
	E.EmployeeImageName,
	E.EmployeeImagePA,
	EP.PrivilegeID,
	EP.PrivilegeName
FROM dbo.Employees AS E
LEFT OUTER JOIN Employees AS S
ON E.SupervisorID = S.EmployeeID
LEFT OUTER JOIN EmployeePriveleges AS EP 
ON E.EmployeeID= EP.EmployeeID
GO
/****** Object:  View [dbo].[vw_EmployeeOrders]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_EmployeeOrders]
AS
SELECT E.EmployeeID
, [dbo].[fn_FullName](E.FirstName ,E.LastName) as Employee
, O.OrderID
, C.CompanyID
, C.CompanyName
, O.OrderDate
, Cast(
		Sum((IsNull(OD.Quantity,0) * IsNull(OD.UnitPrice,0)) * (1-IsNull(OD.Discount,0))) + 
		(Sum((IsNull(OD.Quantity,0)  * IsNull(OD.UnitPrice,0)) * (1-IsNull(OD.Discount,0)) * 
		(IsNull(O.TaxRate,0) * C.StandardTaxStatusID))  ) AS Money
	) AS ExtendedPrice
,IsNull(O.ShippingFee,0) AS ShippingFee
,O.OrderStatusID
,OS.OrderStatusName
,S.CompanyName As ShipperName
FROM    dbo.Orders  AS O LEFT OUTER JOIN
            dbo.OrderDetails AS OD ON O.OrderID = OD.OrderID INNER JOIN
            dbo.Companies AS C ON O.CustomerID = C.CompanyID INNER JOIN
            dbo.Employees AS E ON O.EmployeeID=E.EmployeeID INNER JOIN
			dbo.OrderStatus AS OS ON O.OrderStatusID=OS.OrderStatusID LEFT Outer JOIN 
			dbo.companies AS S ON O.ShipperID= S.CompanyID
GROUP BY E.EmployeeID
, O.OrderID
, C.CompanyID
, C.CompanyName
, O.OrderDate
, O.OrderStatusID
, [dbo].[fn_FullName](E.FirstName ,E.LastName)
, S.CompanyName
, IsNull(O.ShippingFee,0)
, OS.OrderStatusName
GO
/****** Object:  Table [dbo].[PurchaseOrderDetails]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseOrderDetails](
	[PurchaseOrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseOrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[UnitCost] [money] NOT NULL,
	[ReceivedDate] [datetime] NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PurchaseOrderDetails$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseOrders]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseOrders](
	[PurchaseOrderID] [int] IDENTITY(1,1) NOT NULL,
	[VendorID] [int] NOT NULL,
	[SubmittedByID] [int] NULL,
	[SubmittedDate] [datetime] NULL,
	[ApprovedByID] [int] NULL,
	[ApprovedDate] [datetime] NULL,
	[StatusID] [int] NOT NULL,
	[ReceivedDate] [datetime] NULL,
	[ShippingFee] [money] NULL,
	[TaxAmount] [money] NULL,
	[PaymentDate] [datetime] NULL,
	[PaymentAmount] [money] NULL,
	[PaymentMethod] [nvarchar](50) NULL,
	[Notes] [nvarchar](max) NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [PurchaseOrders$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseOrderStatus]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseOrderStatus](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](50) NOT NULL,
	[SortOrder] [tinyint] NOT NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PurchaseOrderStatus$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_PurchaseOrderList]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [dbo].[vw_PurchaseOrderList]
AS
WITH PurchaseOrderTotal AS
(
	SELECT PO.PurchaseOrderID, IsNull(Sum([Quantity]*UnitCost),0) AS PurchaseOrderTotal 
	FROM PurchaseOrders PO Left Outer JOIN dbo.PurchaseOrderDetails POD
	ON PO.PurchaseOrderID = POD.PurchaseOrderID
	GROUP BY PO.PurchaseOrderID
)

SELECT Distinct 
	PO.PurchaseOrderID,
	V.CompanyName AS Vendor,
	S.EmployeeID AS SubmittedByID,
	PO.SubmittedDate,
	dbo.[fn_FullName](S.FirstName, S.LastName) AS SubmittedByFNLN, 
	A.EmployeeID AS ApprovedByID,
	dbo.[fn_FullName]( A.FirstName, A.LastName) AS ApprovedByFNLN,
	PO.ApprovedDate,
	PO.StatusID,
	POS.StatusName,
	PO.ReceivedDate, 
	PO.ShippingFee,
	Cast(ISNULL(PO.TaxAmount,0) AS Money) AS TaxAmount,
	Cast(ISNULL(PurchaseOrderTotal.PurchaseOrderTotal,0) AS Money) AS PurchaseOrderTotal,
	PO.PaymentDate,
	Cast(PO.PaymentAmount as Money) AS PaymentAmount,
	PO.PaymentMethod 
FROM dbo.PurchaseOrders PO 
	Left Outer JOIN
     dbo.Employees AS S 
	 ON PO.SubmittedByID = S.EmployeeID 
	 Left Outer JOIN
	 dbo.Employees as A
	 ON PO.ApprovedByID = A.EmployeeID
	 INNER JOIN
     dbo.Companies  AS V 
	 ON PO.VendorID = V.CompanyID 
	 INNER  JOIN
     dbo.PurchaseOrderStatus AS POS 
	 ON PO.StatusID=POS.StatusID 
	 LEFT OUTER JOIN
     dbo.PurchaseOrderDetails AS POD 
	 ON PO.PurchaseOrderID = POD.PurchaseOrderID 
	 LEFT OUTER JOIN
	 PurchaseOrderTotal 
	 ON POD.PurchaseOrderID= PurchaseOrderTotal.PurchaseOrderID  
	 
GO
/****** Object:  Table [dbo].[Products]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCode] [nvarchar](20) NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[ProductDescription] [nvarchar](max) NULL,
	[StandardUnitCost] [money] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[ReorderLevel] [smallint] NULL,
	[TargetLevel] [smallint] NULL,
	[QuantityPerUnit] [nvarchar](50) NULL,
	[Discontinued] [bit] NOT NULL,
	[MinimumReorderQuantity] [smallint] NULL,
	[ProductCategoryID] [int] NOT NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [Products$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockTake]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockTake](
	[StockTakeID] [int] IDENTITY(1,1) NOT NULL,
	[StockTakeDate] [datetime] NOT NULL,
	[ProductID] [int] NOT NULL,
	[QuantityOnHand] [smallint] NOT NULL,
	[ExpectedQuantity] [int] NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [StockTake$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[StockTakeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_StockAvailable]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[vw_StockAvailable] 
AS
With LastStockTakeDate AS
(SELECT ProductID,  
		Cast(Max(StockTakeDate) as Date) AS LastStockTakeDate
 FROM Stocktake
 --WHERE ProductID =4
 GROUP BY ProductID
),
LastStockTakeQOH AS
(SELECT ST.ProductID,
		ST.QuantityOnHand,
		Cast(ST.StockTakeDate as Date) as StockTakeDate
 FROM StockTake AS ST
 INNER JOIN LastStockTakeDate AS LSTD
 ON ST.ProductID =LSTD.ProductID 
 AND Cast(ST.StockTakeDate as Date)  =  LSTD.LastStockTakeDate
 ),
ProductBought AS
(SELECT POD.ProductID,
		Sum(Quantity) AS TotalBought
FROM [dbo].[PurchaseOrderDetails] AS POD
INNER JOIN 
	[dbo].[PurchaseOrders] AS PO
	ON POD.PurchaseOrderID= PO.PurchaseOrderID
LEFT OUTER JOIN LastStockTakeDate LSTD
ON POD.ProductID=LSTD.ProductID
WHERE Cast(POD.ReceivedDate as Date) > LSTD.LastStockTakeDate 
GROUP BY POD.ProductID
),
ProductSold AS
(
	SELECT OD.ProductID,
			Sum(Quantity) AS TotalSold
	FROM dbo.OrderDetails AS OD
	INNER JOIN 
		dbo.Orders AS O
		ON OD.OrderID=O.OrderID
	LEFT OUTER JOIN 
		LastStockTakeDate AS LSTD
		ON OD.ProductID =LSTD.ProductID
	WHERE O.InvoiceDate > LSTD.LastStockTakeDate   
	GROUP BY OD.ProductID
),
ProductAllocated AS
(
	SELECT ProductID, Sum(quantity) AS Allocated
    FROM OrderDetails
    WHERE OrderDetailStatusID = 1
    GROUP BY ProductID
	)
SELECT P.ProductID, 
	   LSTD.StockTakeDate,
	   IsNull(LSTD.QuantityOnHand,0) AS StockTake ,
	   IsNull(PB.TotalBought ,0) as ProductBought  ,
	   IsNull(PS.TotalSold ,0) AS ProductSold ,
	   IsNull(PA.Allocated,0) As ProductAllocated,
	   IsNull(LSTD.QuantityOnHand,0) + 
	   IsNull(PB.TotalBought ,0)  - 
	   IsNull(PS.TotalSold ,0) -
	   IsNull(PA.Allocated,0) 
	   AS ProductsAvailableToSell
FROM Products P
Left Outer JOIN
LastStockTakeQOH AS LSTD
ON 
P.ProductID= LSTD.ProductID
LEFT OUTER JOIN
	ProductBought AS PB
	ON LSTD.ProductID=PB.ProductID
LEFT OUTER JOIN 
	ProductSold  AS PS
	ON LSTD.ProductID = PS.ProductID
	LEFT OUTER JOIN 
	ProductAllocated AS PA
	ON LSTD.ProductID = PA.ProductID
GO
/****** Object:  Table [dbo].[ProductCategories]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategories](
	[ProductCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCategoryName] [nvarchar](255) NOT NULL,
	[ProductCategoryCode] [nvarchar](3) NOT NULL,
	[ProductCategoryDesc] [nvarchar](255) NULL,
	[ProductCategoryImageName] [nvarchar](80) NULL,
	[ProductCategoryImage] [varbinary](max) NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [ProductCategories$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ProductCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ProductList]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ProductList]
AS
WITH NoStock AS 
(
SELECT ProductID, Sum(quantity) AS NoStock
FROM OrderDetails
WHERE OrderDetailStatusID = 4
GROUP BY ProductID
),
Allocated AS
(SELECT ProductID, Sum(quantity) AS Allocated
FROM OrderDetails
WHERE OrderDetailStatusID = 1
GROUP BY ProductID
),
ToSell AS
(SELECT  [ProductID],ProductsAvailabletoSell AS ToSell
  FROM [NW4PA].[dbo].[vw_StockAvailable]
),
QuantityOnOrder AS
(SELECT ProductID, Sum(quantity) AS OnOrder
FROM OrderDetails
WHERE OrderDetailStatusID = 5
GROUP BY ProductID
)

SELECT P.ProductID
, P.ProductCode
, P.ProductName
, P.ProductDescription
, IsNull(NoStock.NoStock,0) AS NoStock
, IsNull(Allocated.Allocated,0) as Allocated
, IsNull(ToSell.ToSell,0) As ToSell
, IsNull(QuantityOnOrder.OnOrder,0) AS QuantityOnOrder
, P.StandardUnitCost
, P.UnitPrice
, P.ReorderLevel
, P.TargetLevel
, P.MinimumReorderQuantity
, P.QuantityPerUnit
, P.Discontinued
, P.ProductCategoryID
, PC.ProductCategoryName
FROM    dbo.ProductCategories AS PC INNER JOIN
            dbo.Products AS P 
			ON PC.ProductCategoryID =P.ProductCategoryID
			Left Outer JOIN NoStock 
			ON P.ProductID =NoStock.ProductID
			Left Outer Join Allocated
			ON P.ProductID=Allocated.ProductID 
			Left Outer Join ToSell
			ON P.ProductID=ToSell.ProductID
			Left Outer Join QuantityOnOrder
			ON P.ProductID=QuantityOnOrder.ProductID
			
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacts](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyID] [int] NOT NULL,
	[LastName] [nvarchar](30) NOT NULL,
	[FirstName] [nvarchar](20) NOT NULL,
	[EmailAddress] [nvarchar](255) NULL,
	[JobTitle] [nvarchar](50) NOT NULL,
	[PrimaryPhone] [nvarchar](20) NULL,
	[SecondaryPhone] [nvarchar](20) NULL,
	[Notes] [nvarchar](max) NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [Contacts$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Contacts]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Contacts]
AS
SELECT CP.CompanyName, 
CN.ContactID, 
CN.CompanyID, 
CN.FirstName,
CN.LastName, 
[dbo].[fn_FullName](CN.FirstName, CN.LastName ) as  FullName,
CN.EmailAddress, 
CN.JobTitle,
CN.PrimaryPhone, 
CN.SecondaryPhone, 
CN.Notes
FROM    dbo.Companies AS CP INNER JOIN
            dbo.Contacts AS CN ON CP.CompanyID = CN.CompanyID
GO
/****** Object:  View [dbo].[vw_PODetails_AllPOs]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_PODetails_AllPOs]
AS
SELECT dbo.PurchaseOrders.PurchaseOrderID, 
dbo.PurchaseOrderDetails.PurchaseOrderDetailID, 
dbo.PurchaseOrderDetails.Quantity, 
dbo.PurchaseOrderDetails.UnitCost, 
dbo.PurchaseOrderDetails.ReceivedDate, 
dbo.PurchaseOrderDetails.ProductID
FROM    dbo.PurchaseOrderDetails RIGHT OUTER JOIN
            dbo.PurchaseOrders ON 
			dbo.PurchaseOrderDetails.PurchaseOrderID = dbo.PurchaseOrders.PurchaseOrderID
GO
/****** Object:  View [dbo].[vw_CompaniesFieldNames]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[vw_CompaniesFieldNames]
AS 
SELECT T.Name as TableName, AC.name AS FieldName
FROM 
 sys.tables AS T
 INNER JOIN 
 sys.all_columns AS AC
 ON t.object_id= AC.object_id
WHERE T.Name ='Companies' 
AND 
AC.Name Not like'Added%'
AND 
AC.Name Not like'Modified%' 
AND 
AC.Name Not like 'SSMA%'
GO
/****** Object:  View [dbo].[vw_nwpaTableColumn]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     VIEW [dbo].[vw_nwpaTableColumn]
-- 20240410
AS
WITH
tbl AS (
		SELECT 
				object_id		
					AS Table_ID
				, name			
					AS Table_Name
		FROM sys.tables
	)
, DF AS (
			SELECT 
				parent_object_id
					AS Table_ID
				, parent_column_id
					AS Column_ID
			, name	 
				AS DF_Name
			, definition 
				AS DF_Value
	FROM [sys].[default_constraints]
)
SELECT 
		CONCAT(object_id, '.', col.column_id)
			AS TableColumn_ID
		, tbl.Table_ID
		, Table_Name
		, col.column_id			
			AS Ordinal_Position
		, col.name				
			AS Column_Name
		, col.is_nullable		
			AS Allow_Null
		, col.system_type_id	
			AS ColumnType_ID
		, col.max_length		
			AS Column_Length
		, col.precision			
			AS Column_Precision
		, col.scale				
			AS Column_Scale
		, col.is_identity		
			AS Column_Identity
		, CASE 
				WHEN col.system_type_id = 167 AND col. Max_length < 0
					THEN 12 -- VarChar(Max)
				WHEN col.system_type_id = 167
					THEN 10 -- VarChar

				WHEN col.system_type_id = 231 AND col.max_length < 0
					THEN 12 -- nVarChar(Max)
				WHEN col.system_type_id = 231
					THEN 10 -- nVarChar

				WHEN col.system_type_id = 40
					THEN 8 -- Date
				WHEN col.system_type_id = 61
					THEN 8 -- DateTime
				WHEN col.system_type_id = 42
					THEN 8 -- DateTime2

				WHEN col.system_type_id = 104
					THEN 1 -- Bit					WHEN col.system_type_id = 52
				WHEN col.system_type_id = 52
					THEN 3 -- SmallInt
				WHEN col.system_type_id = 56
					THEN 4 -- Int
				WHEN col.system_type_id = 127
					THEN 16 -- BigInt				
				WHEN col.system_type_id = 60
					THEN 5 -- Money

				WHEN col.system_type_id = 106
					THEN 20 -- Decimal
				WHEN col.system_type_id = 189
					THEN 23 -- RowVersion

				ELSE 0
				END		
				AS DataType_ID

		, CASE -- ColumnType_Name
				WHEN col.system_type_id = 167 AND col.max_length < 0
				THEN 'VarChar(Max)'
				WHEN col.system_type_id = 167
				THEN CONCAT('VarChar(', col.max_length, ')')

				WHEN col.system_type_id = 231 AND col.max_length < 0
				THEN 'nVarChar(Max)'
				WHEN col.system_type_id = 231
				THEN CONCAT('nVarChar(', col.max_length, ')')

				WHEN col.system_type_id = 40
					THEN 'Date'
				WHEN col.system_type_id = 61
					THEN 'DateTime'
				WHEN col.system_type_id = 42
					THEN CONCAT('DateTime2(', col.scale, ')')

				WHEN col.system_type_id = 104
					THEN 'Bit'
				WHEN col.system_type_id = 52
					THEN 'SmallInt'
				WHEN col.system_type_id = 56
					THEN 'Int'
				WHEN col.system_type_id = 127
					THEN 'BigInt'			
				WHEN col.system_type_id = 60
					THEN 'Money'

				WHEN col.system_type_id = 106
					THEN CONCAT('Decimal(', col.precision, ',', col.scale, ')')
				
				WHEN col.system_type_id = 189
					THEN 'Timestamp'

				ELSE NULL
				END		
				AS ColumnType_Name
			, DF_Name
			, DF_Value
FROM sys.columns AS col
	JOIN tbl
		ON col.object_id = tbl.Table_ID
	LEFT JOIN DF
		ON col.object_id = DF.Table_ID
		AND col.column_id = DF.Column_ID
WHERE col.name	 not in ('AddedBy',
'AddedOn',
'ModifiedBy',
'ModifiedOn',
'SSMA_TimeStamp')
GO
/****** Object:  View [dbo].[vw_nwpaTableColumnwAuditFields]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     VIEW [dbo].[vw_nwpaTableColumnwAuditFields]
AS
WITH
tbl AS (
		SELECT 
				object_id		
					AS Table_ID
				, name			
					AS Table_Name
		FROM sys.tables
	)
, DF AS (
			SELECT 
				parent_object_id
					AS Table_ID
				, parent_column_id
					AS Column_ID
			, name	 
				AS DF_Name
			, definition 
				AS DF_Value
	FROM [sys].[default_constraints]
)
SELECT 
		CONCAT(object_id, '.', col.column_id)
			AS TableColumn_ID
		, tbl.Table_ID
		, Table_Name
		, col.column_id			
			AS Ordinal_Position
		, col.name				
			AS Column_Name
		, col.is_nullable		
			AS Allow_Null
		, col.system_type_id	
			AS ColumnType_ID
		, col.max_length		
			AS Column_Length
		, col.precision			
			AS Column_Precision
		, col.scale				
			AS Column_Scale
		, col.is_identity		
			AS Column_Identity
		, CASE 
				WHEN col.system_type_id = 167 AND col. Max_length < 0
					THEN 12 -- VarChar(Max)
				WHEN col.system_type_id = 167
					THEN 10 -- VarChar
				WHEN col.system_type_id = 231 AND col.max_length < 0
					THEN 12 -- nVarChar(Max)
				WHEN col.system_type_id = 231
					THEN 10 -- nVarChar
				WHEN col.system_type_id = 40
					THEN 8 -- Date
				WHEN col.system_type_id = 61
					THEN 8 -- DateTime
				WHEN col.system_type_id = 42
					THEN 8 -- DateTime2
				WHEN col.system_type_id = 104
					THEN 1 -- Bit					WHEN col.system_type_id = 52
				WHEN col.system_type_id = 52
					THEN 3 -- SmallInt
				WHEN col.system_type_id = 56
					THEN 4 -- Int
				WHEN col.system_type_id = 127
					THEN 16 -- BigInt				
				WHEN col.system_type_id = 60
					THEN 5 -- Money
				WHEN col.system_type_id = 106
					THEN 20 -- Decimal
				WHEN col.system_type_id = 189
					THEN 23 -- RowVersion
				ELSE 0
				END		
				AS DataType_ID
		, CASE -- ColumnType_Name
				WHEN col.system_type_id = 167 AND col.max_length < 0
				THEN 'VarChar(Max)'
				WHEN col.system_type_id = 167
				THEN CONCAT('VarChar(', col.max_length, ')')
				WHEN col.system_type_id = 231 AND col.max_length < 0
				THEN 'nVarChar(Max)'
				WHEN col.system_type_id = 231
				THEN CONCAT('nVarChar(', col.max_length, ')')
				WHEN col.system_type_id = 40
					THEN 'Date'
				WHEN col.system_type_id = 61
					THEN 'DateTime'
				WHEN col.system_type_id = 42
					THEN CONCAT('DateTime2(', col.scale, ')')
				WHEN col.system_type_id = 104
					THEN 'Bit'
				WHEN col.system_type_id = 52
					THEN 'SmallInt'
				WHEN col.system_type_id = 56
					THEN 'Int'
				WHEN col.system_type_id = 127
					THEN 'BigInt'			
				WHEN col.system_type_id = 60
					THEN 'Money'
				WHEN col.system_type_id = 106
					THEN CONCAT('Decimal(', col.precision, ',', col.scale, ')')		
				WHEN col.system_type_id = 189
					THEN 'Timestamp'
				ELSE NULL
				END		
				AS ColumnType_Name
			, DF_Name
			, DF_Value
FROM sys.columns AS col
	JOIN tbl
		ON col.object_id = tbl.Table_ID
	LEFT JOIN DF
		ON col.object_id = DF.Table_ID
		AND col.column_id = DF.Column_ID
GO
/****** Object:  Table [dbo].[Catalog_TableOfContents]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Catalog_TableOfContents](
	[TocTitle] [nvarchar](255) NOT NULL,
	[TocPage] [smallint] NOT NULL,
 CONSTRAINT [Catalog_TableOfContents$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[TocTitle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompanyTypes]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyTypes](
	[CompanyTypeID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyType] [nvarchar](50) NOT NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [CompanyTypes$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[CompanyTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Learn]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Learn](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SectionNo] [smallint] NOT NULL,
	[SectionText] [nvarchar](max) NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [Learn$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuOptions]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuOptions](
	[MenuID] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[ScreenName] [nvarchar](255) NULL,
	[Icon] [nvarchar](255) NULL,
 CONSTRAINT [MenuOptions$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MRU]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MRU](
	[MRU_ID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[TableName] [nvarchar](50) NOT NULL,
	[PKValue] [int] NOT NULL,
	[DateAdded] [datetime] NOT NULL,
 CONSTRAINT [MRU$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[MRU_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NorthwindFeatures]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NorthwindFeatures](
	[NorthwindFeaturesID] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Navigation] [nvarchar](255) NOT NULL,
	[LearnMore] [nvarchar](max) NULL,
	[HelpKeywords] [nvarchar](255) NULL,
	[OpenMethod] [int] NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [NorthwindFeatures$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[NorthwindFeaturesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NWPATriggers]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NWPATriggers](
	[NWPATriggersID] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [nvarchar](100) NULL,
	[TriggerName] [nvarchar](100) NULL,
 CONSTRAINT [PK_NWPATriggers] PRIMARY KEY CLUSTERED 
(
	[NWPATriggersID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductVendors]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductVendors](
	[ProductVendorID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[VendorID] [int] NOT NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [ProductVendors$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ProductVendorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SSErrors]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SSErrors](
	[SSErrorID] [int] NOT NULL,
	[SSError] [nvarchar](max) NOT NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [SSErrors$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[SSErrorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[States]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[States](
	[StateAbbrev] [nvarchar](2) NOT NULL,
	[StateName] [nvarchar](50) NOT NULL,
 CONSTRAINT [States$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[StateAbbrev] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Strings]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Strings](
	[StringID] [int] IDENTITY(1,1) NOT NULL,
	[StringData] [nvarchar](max) NOT NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [Strings$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[StringID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemSettings]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemSettings](
	[SettingID] [int] IDENTITY(1,1) NOT NULL,
	[SettingName] [nvarchar](50) NOT NULL,
	[SettingValue] [nvarchar](255) NULL,
	[Notes] [nvarchar](255) NULL,
 CONSTRAINT [SystemSettings$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[SettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaxStatus]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaxStatus](
	[TaxStatusID] [int] NOT NULL,
	[TaxStatus] [nvarchar](50) NOT NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [TaxStatus$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[TaxStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Titles]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Titles](
	[Title] [nvarchar](20) NOT NULL,
	[AddedBy] [nvarchar](255) NULL,
	[AddedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](255) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [Titles$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[Title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserSettings]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSettings](
	[SettingID] [int] IDENTITY(1,1) NOT NULL,
	[SettingName] [nvarchar](50) NOT NULL,
	[SettingValue] [nvarchar](255) NULL,
	[Notes] [nvarchar](255) NULL,
 CONSTRAINT [UserSettings$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[SettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USysRibbons]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USysRibbons](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RibbonName] [nvarchar](255) NULL,
	[RibbonXML] [nvarchar](max) NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [USysRibbons$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Welcome]    Script Date: 7/26/2025 5:33:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Welcome](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Welcome] [nvarchar](max) NULL,
	[Learn] [nvarchar](max) NULL,
	[DataMacro] [nvarchar](max) NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [Welcome$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Baked Goods & Mixes', 4)
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Beverages', 4)
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Candy', 4)
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Canned Fruit & Vegetables', 5)
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Canned Meat', 5)
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Cereal', 5)
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Chips, Snacks', 5)
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Condiments', 6)
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Dairy Products', 6)
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Dried Fruit & Nuts', 6)
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Grains', 6)
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Jams, Preserves', 7)
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Oil', 7)
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Pasta', 7)
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Sauces', 7)
GO
INSERT [dbo].[Catalog_TableOfContents] ([TocTitle], [TocPage]) VALUES (N'Soups', 8)
GO
SET IDENTITY_INSERT [dbo].[Companies] ON 
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'Adatum Corporation', 1, N'123-555-1212', N'123 Oak Street', N'Redmond', N'WA', N'90001', N'#http://www.adatum.com/#', N'<div><span style="color:#70ad47; font-size:large"><strong>This </strong></span><span style="font-size:large">is an <strong>RTF </strong></span><span style="color:#2e75b5; font-size:large"><strong>test</strong></span></div>', 1, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-04-20T06:04:28.933' AS DateTime))
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'Adventure Works Cycles', 1, N'234-555-1212 x123', N'234 Elm Street', N'Tacoma', N'WA', N'90002-2222', NULL, NULL, 0, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-04-21T18:28:24.767' AS DateTime))
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, N'Best For You Organics Company', 1, N'425-876-0535', N'345 Mesquite Lane', N'Mesa', N'AZ', N'90003', N'http://www.bestforyouorganics.com', NULL, 0, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-03-15T06:15:24.000' AS DateTime))
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (4, N'Contoso, Inc.', 1, NULL, N'456 Queen Palm Avenue', N'Ft Lauderdale', N'FL', N'90004', N'http://www.contoso.com/', NULL, 0, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (5, N'Woodgrove Bank', 1, N'505-555-1212 (cell)', N'567 Green Avenue', N'St. Louis', N'MO', N'90005', N'www.woodgrove.com', NULL, 1, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T13:30:40.523' AS DateTime))
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (6, N'Wide World Importers', 1, N'600-555-1212', N'6001 Purple Street', N'Atlanta', N'GA', N'90006', NULL, NULL, 0, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (7, N'Tailwind Traders', 1, N'711-555-1212', N'70 N Blue Water Lane', N'Richmond', N'VA', N'90007', NULL, NULL, 0, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (8, N'Proseware, Inc.', 1, N'8012221212ext22022', N'801 Ironwood Rd', N'Manchester', N'NH', N'90008', NULL, NULL, 1, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (9, N'Green Shipping Co', 2, N'800-555-1212', N'9000 Green Street', N'Green Bay', N'WI', N'90009', NULL, NULL, 0, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (10, N'Blue Shipping Co', 2, N'800-555-1313', N'100 Blue Street', N'Columbus', N'OH', N'90010', NULL, NULL, 0, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (11, N'Yellow Vendor Co', 3, NULL, N'111 Yellow Brick Road', N'New York', N'NY', N'90011', NULL, NULL, 1, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (12, N'Brown Vendor Co', 3, NULL, N'222 Brown Street', N'Brownsville', N'TX', N'78520', NULL, NULL, 1, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (13, N'Northwind Traders', 4, NULL, N'One Portals Way', N'Twin Points', N'WA', N'12345', N'www.northwindtraders.com#http://www.northwindtraders.com/#', NULL, 0, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (85, N'Brave Heart', 1, N'666-666-9898', N'123 S Main', N'Brisbane', N'MN', N'99999', N'www.Brave.org', N'<p>Sole Prop needs a break</p>', 0, N'NW4PA_user', CAST(N'2025-04-19T16:09:31.943' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T13:30:15.953' AS DateTime))
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (101, N'Grover Park Consulting', 1, N'425-000-0000', N'5555 5th St S', N'Puyallup', N'WA', N'98300', N'www.gpcdata.com', N'most important', 1, N'NW4PA_user', CAST(N'2025-04-21T19:16:31.543' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T16:07:52.280' AS DateTime))
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (107, N'Miracles', 1, N'333-333-6666', N'123', N'Puyallup', N'WA', N'99999', NULL, NULL, 0, N'NW4PA_user', CAST(N'2025-05-01T14:50:33.003' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyTypeID], [BusinessPhone], [Address], [City], [StateAbbrev], [Zip], [Website], [Notes], [StandardTaxStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (116, N'Northwest Candy Company', 1, N'425 555 0000', N'39090 SE 5th Street', N'Puyallup', N'WA', N'98374', NULL, N'<p>New as of May, 2025</p>', 1, N'NW4PA_user', CAST(N'2025-05-11T07:37:13.753' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Companies] OFF
GO
SET IDENTITY_INSERT [dbo].[CompanyTypes] ON 
GO
INSERT [dbo].[CompanyTypes] ([CompanyTypeID], [CompanyType], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'Customer', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-03-15T06:24:49.000' AS DateTime))
GO
INSERT [dbo].[CompanyTypes] ([CompanyTypeID], [CompanyType], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'Shipper', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[CompanyTypes] ([CompanyTypeID], [CompanyType], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, N'Vendor', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[CompanyTypes] ([CompanyTypeID], [CompanyType], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (4, N'Northwind', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[CompanyTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Contacts] ON 
GO
INSERT [dbo].[Contacts] ([ContactID], [CompanyID], [LastName], [FirstName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (9, 1, N'Chauvin', N'Alexandre', N'test@test.com', N'Senior Buyer', N'1234567890x1234', NULL, NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Contacts] ([ContactID], [CompanyID], [LastName], [FirstName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (11, 3, N'Eden', N'Bouchard', NULL, N'Dry Goods Rep', NULL, NULL, NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Contacts] ([ContactID], [CompanyID], [LastName], [FirstName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (13, 5, N'Fuster', N'Adriana', NULL, N'Sales Manager', NULL, NULL, NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Contacts] ([ContactID], [CompanyID], [LastName], [FirstName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (14, 6, N'Gagnon', N'Alex', NULL, N'Senior Buyer', NULL, NULL, NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Contacts] ([ContactID], [CompanyID], [LastName], [FirstName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (15, 7, N'Albert', N'Sasha', NULL, N'Vendor Relations', NULL, NULL, NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Contacts] ([ContactID], [CompanyID], [LastName], [FirstName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (16, 8, N'Monte', N'Ariana', NULL, N'Senior Buyer', NULL, NULL, NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Contacts] OFF
GO
SET IDENTITY_INSERT [dbo].[EmployeePrivileges] ON 
GO
INSERT [dbo].[EmployeePrivileges] ([EmployeePrivilegeID], [EmployeeID], [PrivilegeID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, 2, 1, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[EmployeePrivileges] ([EmployeePrivilegeID], [EmployeeID], [PrivilegeID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, 9, 1, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[EmployeePrivileges] ([EmployeePrivilegeID], [EmployeeID], [PrivilegeID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (11, 8, 1, N'NW4PA_user', CAST(N'2025-03-15T06:29:02.000' AS DateTime), N'NW4PA_user', CAST(N'2025-03-15T06:29:22.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[EmployeePrivileges] OFF
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 
GO
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Title], [Notes], [EmployeeImagePA], [EmployeeImageName], [EmployeeImage], [SupervisorID], [WindowsUserName], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'Nancy', N'Freehafer', N'nancy@northwindtraders.com', N'Sales Representative', N'123-555-0100', N'123-555-0200', N'Ms.', N'Responsible for large corporate accounts.
Supervisor in training', NULL, N'NancyF.jpg', NULL, NULL, N'GPGeorge@GPCData.onmicrosoft.com', N'Admin', CAST(N'2025-02-16T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-07-12T06:48:13.930' AS DateTime))
GO
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Title], [Notes], [EmployeeImagePA], [EmployeeImageName], [EmployeeImage], [SupervisorID], [WindowsUserName], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'Andrew', N'Cencini', N'Andrew@northwindtraders.com', N'Vice President, Sale', N'123-555-0101', N'123-999-6565', N'Mr.', N'Joined the company as a sales representative, was promoted to sales manager and was then named vice president of sales.', NULL, N'AndrewC.jpg', NULL, 1, N'GPGeorge@GPCData.onmicrosoft.com', N'Admin', CAST(N'2025-02-16T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T15:54:10.223' AS DateTime))
GO
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Title], [Notes], [EmployeeImagePA], [EmployeeImageName], [EmployeeImage], [SupervisorID], [WindowsUserName], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, N'Jan', N'Kotas', N'jan@northwindtraders.com', N'Sales Representative', N'123-555-0102', NULL, N'Ms.', N'Was hired as a sales associate and was promoted to sales representative.', NULL, N'JanK.jpg', NULL, 2, NULL, N'Admin', CAST(N'2025-02-16T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-03-31T07:33:55.040' AS DateTime))
GO
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Title], [Notes], [EmployeeImagePA], [EmployeeImageName], [EmployeeImage], [SupervisorID], [WindowsUserName], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (4, N'Mariya', N'Sergienko', N'mariya@northwindtraders.com', N'Sales Representative', N'123-555-0103', NULL, NULL, NULL, NULL, N'MariyaS.jpg', NULL, NULL, NULL, N'Admin', CAST(N'2025-02-16T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-03-31T07:33:55.040' AS DateTime))
GO
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Title], [Notes], [EmployeeImagePA], [EmployeeImageName], [EmployeeImage], [SupervisorID], [WindowsUserName], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (5, N'Steven', N'Thorpe', N'steven@northwindtraders.com', N'Sales Manager', N'123-555-0104', NULL, NULL, N'Joined the company as a sales representative and was promoted to sales manager.  Fluent in French.', NULL, N'StevenT.jpg', NULL, 3, NULL, N'Admin', CAST(N'2025-02-16T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-03-31T07:33:55.040' AS DateTime))
GO
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Title], [Notes], [EmployeeImagePA], [EmployeeImageName], [EmployeeImage], [SupervisorID], [WindowsUserName], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (6, N'Michael', N'Neipper', N'michael@northwindtraders.com', N'Sales Representative', N'123-555-0105', NULL, NULL, N'Fluent in Japanese and can read and write French, Portuguese, and Spanish.', NULL, N'MichaelN.jpg', NULL, NULL, NULL, N'Admin', CAST(N'2025-02-16T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-03-31T07:33:55.040' AS DateTime))
GO
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Title], [Notes], [EmployeeImagePA], [EmployeeImageName], [EmployeeImage], [SupervisorID], [WindowsUserName], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (7, N'Robert', N'Zare', N'robert@northwindtraders.com', N'Sales Representative', N'123-555-0106', NULL, NULL, NULL, NULL, N'RobertZ.jpg', NULL, NULL, NULL, N'Admin', CAST(N'2025-02-16T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-03-31T07:33:55.040' AS DateTime))
GO
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Title], [Notes], [EmployeeImagePA], [EmployeeImageName], [EmployeeImage], [SupervisorID], [WindowsUserName], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (8, N'Laura', N'Giussani', N'laura@northwindtraders.com', N'Sales Coordinator', N'123-555-0107', NULL, N'Ms.', N'Reads and writes French.', NULL, N'LauraG.jpg', NULL, 2, N'GPGeorge@GPCData.onmicrosoft.com', N'Admin', CAST(N'2025-02-16T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-04-01T16:24:09.153' AS DateTime))
GO
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Title], [Notes], [EmployeeImagePA], [EmployeeImageName], [EmployeeImage], [SupervisorID], [WindowsUserName], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (9, N'Anne', N'Hellung-Larsen', N'anne@northwindtraders.com', N'Sales Representative', N'123-555-0108', NULL, NULL, N'Fluent in French and German.', NULL, N'AnneH.jpg', NULL, 2, NULL, N'Admin', CAST(N'2025-02-16T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-03-31T07:33:55.040' AS DateTime))
GO
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Title], [Notes], [EmployeeImagePA], [EmployeeImageName], [EmployeeImage], [SupervisorID], [WindowsUserName], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (10, N'Internet', N'Sales', NULL, N'Internet Bot', NULL, NULL, N'Mr.', N'Internet sales is not a human employee', NULL, NULL, NULL, 2, N'GPGeorge@GPCData.onmicrosoft.com', N'Admin', CAST(N'2025-02-16T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T15:51:11.967' AS DateTime))
GO
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [EmailAddress], [JobTitle], [PrimaryPhone], [SecondaryPhone], [Title], [Notes], [EmployeeImagePA], [EmployeeImageName], [EmployeeImage], [SupervisorID], [WindowsUserName], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (27, N'Wilmer', N'Ortega', N'WOR@NorthwinderTraders.com', N'Bubba', N'111-111-1111', N'222-222-3333', N'Mr.', N'New Bubba sells stuff!', NULL, NULL, NULL, 1, N'GPGeorge@GPCData.onmicrosoft.com', N'NW4PA_user', CAST(N'2025-04-20T10:19:47.010' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T14:01:01.070' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
SET IDENTITY_INSERT [dbo].[Learn] ON 
GO
INSERT [dbo].[Learn] ([ID], [SectionNo], [SectionText]) VALUES (1, 10, N'<div><font size=5>Welcome!</font></div>

<div>The Northwind 2.0 Developer Edition Template expands on the concepts of the Northwind 2.0 Starter edition, with a more complete data model and more sophisticated features. To learn more, select any of the following topics.</div>')
GO
INSERT [dbo].[Learn] ([ID], [SectionNo], [SectionText]) VALUES (2, 20, N'<div><font size=5>About the Template</font></div>

<div>The Northwind 2.0 Developer Edition template showcases major features of Access; it is not designed to run a company nor show you how to build such an application. </div>

<div>&nbsp;</div>

<div><strong><em>Northwind </em></strong>is a fictitious trading company whose customers are independent grocery stores.</div>

<div>&nbsp;</div>

<ul>
 <li>Customers call in orders or place them over the internet. In this template, Internet orders are a mockup.</li>
 <li>Northwind invoices, ships, collects payments, and closes orders. Purchase orders and inventory management are also included in this edition.</li>
</ul>

<div>&nbsp;</div>

<div>Sample data in the template will help you started quickly. </div>')
GO
INSERT [dbo].[Learn] ([ID], [SectionNo], [SectionText]) VALUES (3, 30, N'<div><font size=5>How to Navigate</font></div>

<div><font size=4>Home Ribbon</font></div>

<div>This template implements navigation using a custom Home ribbon.</div>')
GO
INSERT [dbo].[Learn] ([ID], [SectionNo], [SectionText]) VALUES (4, 40, N'<div>The left side of the custom Home ribbon contains Northwind application menu navigation.</div>

<div>&nbsp;</div>

<ul>
 <li><font size=4>MRU</font> </li>
</ul>

<div>&nbsp;</div>

<blockquote>

<div>MRU = Most Recently Used. This ribbon menu item contains a combo box that is refreshed when an order or a purchase order is added or deleted. This enables the current user to quickly revisit their most recently added orders and purchase orders.</div>

</blockquote>')
GO
INSERT [dbo].[Learn] ([ID], [SectionNo], [SectionText]) VALUES (5, 50, N'<div>Visit <strong>Home &gt; Help Topics &gt; Northwind Features</strong> to learn how Northwind 2.0 Developer Edition implements this concept.</div>

<div>&nbsp;</div>

<ul>
 <li>Orders</li>
 <li>Maintenance</li>
 <li>Reports</li>
</ul>

<div>&nbsp;</div>

<div>The right side contains a group of <strong>Help Topics</strong>:</div>

<div>&nbsp;</div>

<ul>
 <li><strong>Learn </strong>displays this “Welcome” panel.</li>
 <li><strong>Northwind Features</strong> displays a list of features implemented in this template, with navigation tips to view the features’ implementation in the application, and links to Online and in-application Help topics for further exploration.</li>
 <li><strong>About Northwind</strong> displays a very brief history of this template’s conception and development.</li>
</ul>

<div>&nbsp;</div>

<ul>
 <li>In addition to these ribbon buttons, many forms have a Help button</li>
</ul>')
GO
INSERT [dbo].[Learn] ([ID], [SectionNo], [SectionText]) VALUES (6, 60, N'<div>which opens a form-specific help page.</div>

<div>&nbsp;</div>

<div><font size=4>“Develop” Ribbon</font></div>

<div>&nbsp;</div>

<div>Common development tools are grouped here. For a production environment, you might want to make this invisible.</div>')
GO
INSERT [dbo].[Learn] ([ID], [SectionNo], [SectionText]) VALUES (7, 70, N'<div><font size=5>Northwind Features</font></div>

<div>Northwind 2.0 Developer edition includes a feature matrix accessible from the custom Home ribbon Northwind Features button. It contains a list of notable concepts implemented in this version. Each concept topic outlines how you can view an example of it within the Northwind 2.0 Developer template, as well as handy links to learn more about the topic:</div>

<div>&nbsp;</div>

<ul>
 <li><strong>Click for On-Line Help</strong> opens a Web page addressing the topic.</li>
 <li><strong>Click for in-App Help</strong> opens the access application’s internal Help library to the topic.</li>
</ul>

<div>&nbsp;</div>

<div><font size=5>Multiple Form Instances</font></div>

<div>By default, Access forms can be instantiated only once. In this template, Northwind Orders and Purchase Orders forms (frmOrderDetails and frmPurchaseOrderDetails) can be instantiated multiple times concurrently. In these forms, follow the</div>')
GO
INSERT [dbo].[Learn] ([ID], [SectionNo], [SectionText]) VALUES (8, 80, N'<div>for a deeper dive into how this is accomplished.</div>

<div>&nbsp;</div>

<div><font size=5>Cascading Combo Boxes</font></div>

<div>Refer to the Orders form for a method of implementing cascading combo boxes where a Product Categories combobox leads to a Products combobox with only the products for the selected category.</div>

<div>&nbsp;</div>

<div><font size=5>Validating Required Fields</font></div>

<div>This edition features the VBA function ValidateForm() to highlight required form fields that are empty. For an example, try creating an Order without completing fields Customer and Tax Status. You can further investigate how this was accomplished using the</div>')
GO
INSERT [dbo].[Learn] ([ID], [SectionNo], [SectionText]) VALUES (9, 90, N'<div>on the Order screen.</div>

<div>&nbsp;</div>

<div><font size=5>“Lazy Loading” Subforms</font></div>

<div>Sometimes referred to as “late binding,” lazy loading in a tab control delays loading a tab’s subform contents until the tab is selected. By default, Access loads subforms before loading the form itself. Late binding can improve form performance (loading speed).</div>

<div>&nbsp;</div>

<div>See the Product Detail form.</div>

<div>&nbsp;</div>

<div><font size=5>Street Address Map Link</font></div>

<div>The Company Detail form (frmCompanyDetail) features a <strong>Map </strong>button that opens the default Web browser to a map of the company’s address. Northwind 2.0 Developer implements this using Microsoft Bing maps, but could use any Web-based map site, such as Google Maps or MapQuest.</div>

<div>&nbsp;</div>

<div><font size=5>Show Filter</font></div>

<div>Company List and Company Detail forms also demonstrate a means to allow users to view a form’s current filters.</div>')
GO
INSERT [dbo].[Learn] ([ID], [SectionNo], [SectionText]) VALUES (10, 100, N'<div><font size=5>Workflows</font></div>

<div>Both <strong>Orders </strong>and <strong>Purchase Orders</strong> implement very simple workflows. These demonstrate a means for controlling the sequence of data updates required to enforce business rules for moving an order from one status to the next.</div>

<div>&nbsp;</div>

<div><font size=5>Reports</font></div>

<div><strong>Report Fall Catalog</strong> - demonstrates a number of more advanced report development topics</div>

<div>&nbsp;</div>

<ul>
 <li>Multiple sections (Introduction, TOC, Categories, Order form)</li>
 <li>TOC and pagination</li>
 <li>Resulting report is a publisher-quality catalog</li>
</ul>

<div>&nbsp;</div>

<div><strong>Monthly Sales By Employee</strong> – The report can be filtered at runtime in Report View.</div>

<div>&nbsp;</div>

<div><font size=5>Database Design</font></div>

<div>Northwind has a simple but correct Relational Database Design.</div>

<div>&nbsp;</div>

<div>Tables hold specific information about Northwind''s business.</div>

<div>&nbsp;</div>

<div>Fields in the tables have specific properties set to make them required or to enforce a certain data type (for example, numeric, date, and yes/no).</div>

<div>&nbsp;</div>

<div>Relations between tables enforce business rules and ensure data consistency (for example, an order must be for an existing customer).</div>

<div>&nbsp;</div>

<div>To explore Northwind''s database design, press F11 to open the Navigation Pane which displays tables and other objects, or choose Develop &gt; Relationships in the ribbon.</div>')
GO
INSERT [dbo].[Learn] ([ID], [SectionNo], [SectionText]) VALUES (11, 110, N'<div><font size=5>Programming and Visual Basic for Applications (VBA)</font></div>

<div>This edition features more extensive implementation using VBA instead of macros.</div>

<div>&nbsp;</div>

<div>Examining the VBA modules, you may find examples of alternate or <em>Equivalent Syntax</em>. This is included to help you recognize different syntax that accomplishes exactly or approximately the same result.</div>

<div>&nbsp;</div>

<div>Programming facilitates application flow (for example, Opening the next form) or enforces business rules (for example, you cannot update an Order status to “Closed” without first receiving payment for it).</div>

<div>&nbsp;</div>

<div>Northwind Developer uses different examples of Programming to show Access capabilities:</div>

<div>&nbsp;</div>

<ul>
 <li>Expressions in the Employees table create the <em>FullNameFNLN </em>and <em>FullNameLNFN </em>fields. An expression field in a table can be used elsewhere, for example, to show the employee''s full name in the Access main window title.</li>
</ul>')
GO
INSERT [dbo].[Learn] ([ID], [SectionNo], [SectionText]) VALUES (12, 120, N'<ul>
 <li>In Northwind 2.0 Developer Edition, macros are replaced with VBA procedures. To view the VBA editor, press Alt+F11.</li>
</ul>

<div>&nbsp;</div>

<div>By default, Access creates macros when you use Wizards, such as when dropping a button on a form in design view. Access can convert macros to VBA for you: In form Design view, <strong>Design &gt; Tools &gt; Convert Form’s Macros to Visual Basic.</strong></div>')
GO
INSERT [dbo].[Learn] ([ID], [SectionNo], [SectionText]) VALUES (13, 130, N'<div>To explore form programming, open the form in Design view, then select <strong>Form Design &gt; Property Sheet</strong> to inspect the properties of the selected object. Most of the code is accessed from the <strong>Events </strong>tab of the property sheet, as shown below.</div>')
GO
INSERT [dbo].[Learn] ([ID], [SectionNo], [SectionText]) VALUES (14, 140, N'<div><font size=5>Additional Documentation</font></div>

<div>Most Northwind forms contain a special help link denoted with the symbol:</div>')
GO
INSERT [dbo].[Learn] ([ID], [SectionNo], [SectionText]) VALUES (15, 150, N'<div>This symbol will link contextually to Microsoft web pages devoted to all things Northwind, featuring detailed discussions on the Northwind application form objects, their showcased functionality, and how it was accomplished.</div>')
GO
SET IDENTITY_INSERT [dbo].[Learn] OFF
GO
INSERT [dbo].[MenuOptions] ([MenuID], [Title], [ScreenName], [Icon]) VALUES (1, N'Orders', N''' scrOrderList''', N'Icon.ListScrollWatchlist')
GO
INSERT [dbo].[MenuOptions] ([MenuID], [Title], [ScreenName], [Icon]) VALUES (2, N'POs', N''' scrPurchaseOrderList''', N'Icon.ListScrollWatchlist')
GO
INSERT [dbo].[MenuOptions] ([MenuID], [Title], [ScreenName], [Icon]) VALUES (3, N'Vendors', N''' scrVendorList''', N'Icon.ListScrollWatchlist')
GO
INSERT [dbo].[MenuOptions] ([MenuID], [Title], [ScreenName], [Icon]) VALUES (4, N'Companies', N''' scrCompanyList''', N'Icon.ListScrollWatchlist')
GO
INSERT [dbo].[MenuOptions] ([MenuID], [Title], [ScreenName], [Icon]) VALUES (5, N'Employees', N''' scrEmployeeList''', N'Icon.ListScrollWatchlist')
GO
INSERT [dbo].[MenuOptions] ([MenuID], [Title], [ScreenName], [Icon]) VALUES (6, N'Stock Take', N''' scrStockTake''', N'Icon.ListScrollWatchlist')
GO
SET IDENTITY_INSERT [dbo].[MRU] ON 
GO
INSERT [dbo].[MRU] ([MRU_ID], [EmployeeID], [TableName], [PKValue], [DateAdded]) VALUES (2, 11, N'PurchaseOrders', 1, CAST(N'2024-10-25T12:41:02.000' AS DateTime))
GO
INSERT [dbo].[MRU] ([MRU_ID], [EmployeeID], [TableName], [PKValue], [DateAdded]) VALUES (3, 11, N'Orders', 56, CAST(N'2025-01-17T13:50:44.000' AS DateTime))
GO
INSERT [dbo].[MRU] ([MRU_ID], [EmployeeID], [TableName], [PKValue], [DateAdded]) VALUES (4, 11, N'Orders', 50, CAST(N'2025-01-17T13:50:50.000' AS DateTime))
GO
INSERT [dbo].[MRU] ([MRU_ID], [EmployeeID], [TableName], [PKValue], [DateAdded]) VALUES (5, 11, N'Orders', 48, CAST(N'2025-01-17T13:50:53.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[MRU] OFF
GO
SET IDENTITY_INSERT [dbo].[NorthwindFeatures] ON 
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (2, N'List form - Multiple items', N'Fixed width columns. A.k.a. Continuous forms', N'Orders
Employees
Products', N'Create a form in Access#https://support.microsoft.com/office/create-a-form-in-access-5d550a3d-92e1-4f38-9772-7e7e21e80c6b#', N'Create form', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (3, N'List form - Datasheet', N'Reorder and Resize columns', N'Products > Click hyperlink > Orders for [product]
Customers (technically a Split Form, but acts the same way', N'Create a form using a datasheet in Access#https://support.microsoft.com/office/create-a-form-using-the-datasheet-tool-d0cfef2d-1ffb-4300-8ab3-7bcef4b4ef6d#', N'Working with datasheets', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (4, N'Single record form', NULL, N'Add Order. 
Products > Click hyperlink', N'Create a form in Access#https://support.microsoft.com/office/create-a-form-in-access-5d550a3d-92e1-4f38-9772-7e7e21e80c6b#', N'Create form', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (5, N'List form - Split form', N'Combination of Datasheet and Single Record form.', N'Customer List
Feature Matrix', N'Create a split form in Access#https://support.microsoft.com/office/create-a-split-form-e8eb0efb-2fa6-4315-9d4b-86e79a1fbe1e#', N'Create Split Form', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (6, N'Resizable form', NULL, N'Orders > Click hyperlink', N'#https://learn.microsoft.com/office/vba/api/access.form.borderstyle#', N'Form Borderstyle Property', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (7, N'Popup form', N'Form can float anywhere', N'Add Employee. Assign Employee Privileges pops up.', N'Pop-up Forms#https://learn.microsoft.com/office/vba/api/access.form.popup#', N'Form.Popup', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (8, N'Modal form', N'User cannot select outside of this form', N'Add Employee. Assign Employee Privileges pop-up is  modal.', NULL, N'Modal Property', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (9, N'Totals calculations', NULL, N'Orders
Orders > Click hyperlink', NULL, N'Totals', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (10, N'Navigate using hyperlink', N'Check the VBA procedure for the Click event of the item in design view', N'Orders
Customers
Employees
Product', N'Form DisplayAsHyperlink property#https://learn.microsoft.com/office/vba/api/access.textbox.displayashyperlink#', NULL, 2)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (11, N'Open form with filter', N'Can use WhereCondition or OpenArgs argument of OpenForm', N'All hyperlink navigation forms', NULL, N'Filter Forms', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (12, N'Navigate form to another record', NULL, N'Products > Click hyperlink > Go to Product', N'Find a record by selecting a value from a list#https://support.microsoft.com/office/enable-users-to-find-a-record-by-selecting-a-value-from-a-list-e3ed7711-433a-4931-9cab-b0f71a90c329#', N'Find a record by selecting a value from a list', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (13, N'Apply predefined filter', NULL, N'Orders
Orders > Click hyperlink > Recent Orders', N'Apply Filter to Forms#https://support.microsoft.com/office/filter-property-18be7152-a700-4f34-9768-74da413766a5#', N'Filter Forms', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (14, N'Attachments', N'Files that are associated with a record', N'Employees > Click hyperlink > Employee picture', N'Attach files and graphics to records#https://support.microsoft.com/article/d40a09ad-a753-4a14-9161-7f15baad6dbd#', N'Attach Fields', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (15, N'Editable value list', N'Dropdown allowing user to edit list items', N'Employees > Click hyperlink > Title', NULL, N'Editable Value Lists', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (16, N'Split form Splitter bar', NULL, N'Customer List; the splitter bar is just above the grid column headers. Grab it and pull it down.', NULL, N'Split Form', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (17, N'Show/Hide columns in a datasheet view', NULL, N'Customer List', NULL, N'Working with Datasheets', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (18, N'Reorder and resize columns', N'All Datasheet views can do this.', N'Customer List', NULL, N'Working with Datasheets', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (19, N'Open a web page', NULL, N'Customers > Click hyperlink > Website', NULL, N'Create or delete a Hyperlink field', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (20, N'Open a map to an address', NULL, N'Customers > Click hyperlink > Click to Map', NULL, NULL, NULL)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (21, N'Phone number formatting', N'Input mask can allow for extra text', N'Customers > Click hyperlink > Business Phone', N'Use Input Masks to control data entry formats#https://support.microsoft.com/office/control-data-entry-formats-with-input-masks-e125997a-7791-49e5-8672-4a47832de8da#', N'Input Mask', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (22, N'Formatting of text', N'Called "Rich Text" in Access', N'Employees > Click hyperlink > Notes
Products > Product Description field', N'Formatting Rich Text#https://support.microsoft.com/office/enable-or-disable-full-rich-text-formatting-in-a-rich-text-box-d3c71c1d-8c88-41e9-9ee5-2ca6a3d0ea67#', N'Rich Text', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (23, N'Photo', NULL, N'Employees > Click hyperlink > Employee picture', N'Attach Fields and Graphics to Records in your Database#https://support.microsoft.com/office/attach-files-and-graphics-to-the-records-in-your-database-d40a09ad-a753-4a14-9161-7f15baad6dbd#', N'Attach Fields', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (24, N'Create Email', NULL, N'Employees > Click hyperlink > Email  Address', N'Follow a Hyperlink in Access#https://learn.microsoft.com/office/vba/api/Access.Application.FollowHyperlink#', N'Create or delete a Hyperlink field', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (25, N'Export data', N'To Excel or other formats', N'Products > Export to File', N'Introduction to importing, linking and exporting data in Access#https://support.microsoft.com/office/introduction-to-importing-linking-and-exporting-data-in-access-08422593-42dd-4e73-bdf1-4c21fc3aa1b0#', NULL, 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (26, N'Create orders programmatically', NULL, N'Admin > Internet Orders', NULL, NULL, NULL)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (27, N'Reset all dates programmatically', N'So you''re working with current data', N'Admin > Reset Dates', NULL, NULL, NULL)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (28, N'Charts and Graphs', N'These are called "Modern Chart"', N'Reports > Sales Reports', N'Introducing new and modern chart types in Access#https://techcommunity.microsoft.com/t5/access-blog/introducing-new-and-modern-chart-types/ba-p/193479#', N'New and Modern  Charts', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (29, N'Automatic resizing of controls', N'This is called "Control Anchoring"', N'Orders > Click hyperlink > resize vertically', N'Make controls stretch, shrink or move as you resize a form#https://support.microsoft.com/office/make-controls-stretch-shrink-or-move-as-you-resize-a-form-51fd88e0-43d3-4070-a298-18ba273f4cf8#', N'Stretch Controls', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (30, N'Automatic tracking of Create and Modified user and date', N'Data Macros are created in table design view.', N'Open any table in Design view > Create Data Macros > Before Change', N'Create a data macro#https://support.microsoft.com/office/create-a-data-macro-b1b94bca-4f17-47ad-a66d-f296ef834200#', N'Data Macros in Access', 1)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (31, N'Things to help you on your journey', N'Links and comments you might find helpful', N'Link to Things you should know Developer Edition', NULL, NULL, NULL)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (32, N'Error Handling', N'Global Error Handler in VBA', N'Link to Things you should know Developer Edition', NULL, NULL, NULL)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (33, N'Create custom ribbon', NULL, N'n/a', N'Create Custom Ribbon#https://support.microsoft.com/article/45e110b9-531c-46ed-ab3a-4e25bc9413de#', NULL, 2)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (34, N'Access Glossary', N'Common terminology used by Access', N'n/a', N'Access Glossary#https://support.microsoft.com/article/29ab26b7-1f36-4da4-9e75-479f8e6e3c35#', NULL, 2)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (35, N'Data Macros', N'Adding data macros in a desktop database', N'n/a', N'Data Macros#https://support.microsoft.com/article/74a736ec-9bff-4ad1-b27b-dbe63c07784c#', NULL, 2)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (36, N'Run macro at startup', N'Create a macro that runs when you open a database', N'n/a', N'Run macro at startup#https://support.microsoft.com/article/98ba1508-dcc6-4e0f-9698-a4755e548124#', NULL, 2)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (37, N'Filter Property', NULL, N'Companies > click a radio button in the header > Show Filter', N'Filter Property#https://support.microsoft.com/article/18be7152-a700-4f34-9768-74da413766a5#', NULL, 2)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (38, N'Navigation Pane', N'Use the Navigation Pane', N'n/a', N'Navigation Pane#https://support.microsoft.com/article/274dfc5a-281b-472b-94e2-ef931c5cc590#', NULL, 2)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (39, N'MRU List', N'Most Recently Used orders and purchase orders dropdown in the Ribbon', N'Ribbon', N'TODO: Link to NW2 Help Page##', N'ribbon dropdown mru', 2)
GO
INSERT [dbo].[NorthwindFeatures] ([NorthwindFeaturesID], [ItemName], [Description], [Navigation], [LearnMore], [HelpKeywords], [OpenMethod]) VALUES (40, N'Listbox form navigation', N'An unbound Listbox control used to navigate to a selected record in a form', N'System Admin > Product Categories', N'Listbox Object#https://learn.microsoft.com/office/vba/api/access.listbox#', N'Enable users to find a record by selecting a value from a list', 1)
GO
SET IDENTITY_INSERT [dbo].[NorthwindFeatures] OFF
GO
SET IDENTITY_INSERT [dbo].[NWPATriggers] ON 
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (1, N'Strings', N'AuditStrings')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (2, N'Employees', N'AuditEmployees')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (3, N'Titles', N'AuditTitles')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (4, N'CompanyTypes', N'AuditCompanyTypes')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (5, N'Contacts', N'AuditContacts')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (6, N'EmployeePrivileges', N'AuditEmployeePrivileges')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (7, N'OrderDetailStatus', N'AuditOrderDetailStatus')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (8, N'TaxStatus', N'AuditTaxStatus')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (9, N'OrderStatus', N'AuditOrderStatus')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (10, N'Privileges', N'AuditPrivileges')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (11, N'Companies', N'AuditCompanies')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (12, N'ProductCategories', N'AuditProductCategories')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (13, N'Products', N'AuditProducts')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (14, N'OrderDetails', N'AuditOrderDetails')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (15, N'ProductVendors', N'AuditProductVendors')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (16, N'PurchaseOrderDetails', N'AuditPurchaseOrderDetails')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (17, N'PurchaseOrders', N'AuditPurchaseOrders')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (18, N'Orders', N'AuditOrders')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (19, N'PurchaseOrderStatus', N'AuditPurchaseOrderStatus')
GO
INSERT [dbo].[NWPATriggers] ([NWPATriggersID], [TableName], [TriggerName]) VALUES (20, N'StockTake', N'AuditStockTake')
GO
SET IDENTITY_INSERT [dbo].[NWPATriggers] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, 177, 4, 10, 12.4900, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-06-05T13:55:20.293' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, 177, 13, 25, 46.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-06-05T14:01:41.427' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, 177, 37, 25, 4.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-06-05T14:04:18.323' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (4, 177, 34, 5, 1.8000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-06-05T14:06:47.883' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (5, 176, 2, 30, 14.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-06-05T14:51:26.483' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (6, 185, 4, 5, 12.4900, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-06-11T11:15:27.507' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (7, 185, 13, 20, 46.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-06-11T11:15:44.603' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (8, 199, 24, 25, 2.9900, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-06-16T14:42:36.897' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (9, 189, 39, 20, 4.0000, CAST(0.000 AS Decimal(6, 3)), 1, N'NW4PA_user', CAST(N'2025-06-16T15:15:27.900' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (10, 192, 13, 25, 46.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-06-16T16:31:24.097' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (11, 200, 8, 20, 2.0000, CAST(0.000 AS Decimal(6, 3)), 2, N'NW4PA_user', CAST(N'2025-06-17T07:01:10.450' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:32:50.490' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (14, 200, 7, 20, 18.0000, CAST(0.000 AS Decimal(6, 3)), 2, N'NW4PA_user', CAST(N'2025-06-17T11:27:10.813' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:32:50.490' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (18, 200, 12, 10, 9.6500, CAST(0.000 AS Decimal(6, 3)), 2, N'NW4PA_user', CAST(N'2025-06-17T14:37:02.323' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:32:50.490' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (21, 201, 7, 42, 18.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-01T12:33:41.500' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (22, 202, 7, 35, 18.0000, CAST(0.000 AS Decimal(6, 3)), 2, N'NW4PA_user', CAST(N'2025-07-01T12:35:14.417' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T16:09:45.440' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (23, 202, 35, 22, 19.5000, CAST(0.000 AS Decimal(6, 3)), 2, N'NW4PA_user', CAST(N'2025-07-01T13:16:35.537' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T16:09:45.440' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (24, 203, 4, 15, 12.4900, CAST(0.000 AS Decimal(6, 3)), 2, N'NW4PA_user', CAST(N'2025-07-04T05:34:57.210' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:32:50.490' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (27, 204, 7, 2, 18.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-04T05:38:37.953' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T16:34:49.107' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (28, 204, 24, 4, 2.9900, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-04T05:42:02.430' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T16:34:49.107' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (29, 204, 39, 4, 4.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-04T05:43:38.340' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T16:34:49.107' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (30, 204, 13, 6, 46.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-04T05:52:19.307' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T16:34:49.107' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (31, 204, 38, 6, 10.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-04T09:36:36.383' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T16:34:49.107' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (33, 206, 74, 30, 6.9900, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-07T10:45:18.573' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (34, 205, 81, 18, 36.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-07T13:10:11.483' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (35, 205, 80, 5, 35.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-07T13:10:42.147' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (37, 205, 76, 12, 36.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-07T13:23:31.000' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (38, 207, 82, 10, 48.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-07T15:54:42.630' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (39, 208, 13, 30, 46.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-07T15:56:48.630' AS DateTime), N'NW4PA_user', CAST(N'2025-07-14T15:50:54.130' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (40, 209, 83, 30, 6.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-09T12:21:01.857' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (41, 209, 13, 10, 46.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-09T12:25:20.460' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:31:34.917' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (43, 211, 6, 10, 15.9900, CAST(0.000 AS Decimal(6, 3)), 1, N'NW4PA_user', CAST(N'2025-07-10T14:03:07.207' AS DateTime), N'NW4PA_user', CAST(N'2025-07-22T11:02:31.247' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (47, 212, 10, 25, 12.7500, CAST(0.000 AS Decimal(6, 3)), 2, N'NW4PA_user', CAST(N'2025-07-10T14:18:47.150' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T15:32:50.490' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (50, 213, 21, 5, 38.0000, CAST(0.020 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-12T06:17:49.923' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T16:33:14.820' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51, 213, 8, 12, 2.0000, CAST(0.000 AS Decimal(6, 3)), 6, N'NW4PA_user', CAST(N'2025-07-12T06:18:20.777' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T16:33:14.820' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (52, 211, 2, 10, 14.0000, CAST(0.040 AS Decimal(6, 3)), 1, N'NW4PA_user', CAST(N'2025-07-22T10:57:00.523' AS DateTime), N'NW4PA_user', CAST(N'2025-07-22T11:01:45.050' AS DateTime))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [UnitPrice], [Discount], [OrderDetailStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (53, 211, 15, 1, 18.4000, CAST(0.000 AS Decimal(6, 3)), 1, N'NW4PA_user', CAST(N'2025-07-22T11:02:13.017' AS DateTime), N'NW4PA_user', CAST(N'2025-07-22T11:02:27.100' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetailStatus] ON 
GO
INSERT [dbo].[OrderDetailStatus] ([OrderDetailStatusID], [OrderDetailStatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'Allocated', 40, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[OrderDetailStatus] ([OrderDetailStatusID], [OrderDetailStatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'Invoiced', 50, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[OrderDetailStatus] ([OrderDetailStatusID], [OrderDetailStatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, N'New', 10, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[OrderDetailStatus] ([OrderDetailStatusID], [OrderDetailStatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (4, N'No Stock', 20, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[OrderDetailStatus] ([OrderDetailStatusID], [OrderDetailStatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (5, N'On Order', 30, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[OrderDetailStatus] ([OrderDetailStatusID], [OrderDetailStatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (6, N'Shipped', 60, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[OrderDetailStatus] ([OrderDetailStatusID], [OrderDetailStatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (7, N'Lost in Transit', 70, N'NW4PA_user', CAST(N'2025-03-15T06:46:10.000' AS DateTime), N'NW4PA_user', CAST(N'2025-03-15T06:46:26.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[OrderDetailStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (176, 10, 2, CAST(N'2025-06-05T14:20:39.453' AS DateTime), CAST(N'2025-06-05T14:51:48.137' AS DateTime), CAST(N'2025-06-05T14:51:54.490' AS DateTime), 85, 40.0000, CAST(0.085 AS Decimal(6, 3)), 0, N'Check', CAST(N'2025-06-05T14:51:57.797' AS DateTime), NULL, 1, N'NW4PA_user', CAST(N'2025-06-05T13:53:47.680' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:52:09.720' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (177, 10, 2, CAST(N'2025-06-05T14:20:39.453' AS DateTime), CAST(N'2025-06-05T14:07:11.417' AS DateTime), CAST(N'2025-06-05T14:11:45.500' AS DateTime), NULL, 26.0000, CAST(0.085 AS Decimal(6, 3)), 0, N'Cash', CAST(N'2025-06-05T14:14:46.483' AS DateTime), NULL, 1, N'NW4PA_user', CAST(N'2025-06-05T13:54:05.310' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:20:39.463' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (181, 10, 2, CAST(N'2025-06-05T21:46:34.780' AS DateTime), NULL, NULL, NULL, 0.0000, CAST(0.085 AS Decimal(6, 3)), 0, N'Cash', NULL, NULL, 3, N'NW4PA_user', CAST(N'2025-06-05T21:46:34.790' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T11:07:34.717' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (185, 10, 2, CAST(N'2025-06-06T06:13:31.407' AS DateTime), CAST(N'2025-06-11T11:17:49.363' AS DateTime), CAST(N'2025-06-11T11:18:11.227' AS DateTime), 10, 60.0000, CAST(0.085 AS Decimal(6, 3)), 0, N'Cash', CAST(N'2025-06-11T11:18:19.053' AS DateTime), NULL, 1, N'NW4PA_user', CAST(N'2025-06-06T06:13:31.420' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T11:18:23.883' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (189, 10, 2, CAST(N'2025-06-06T06:24:35.670' AS DateTime), NULL, NULL, 9, 0.0000, CAST(0.085 AS Decimal(6, 3)), 0, N'Cash', NULL, NULL, 3, N'NW4PA_user', CAST(N'2025-06-06T06:24:35.670' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T12:10:22.727' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (192, 10, 2, CAST(N'2025-06-06T06:34:01.987' AS DateTime), CAST(N'2025-06-16T16:33:08.810' AS DateTime), CAST(N'2025-07-13T14:42:36.087' AS DateTime), 10, 10.0000, CAST(0.085 AS Decimal(6, 3)), 0, N'Cash', CAST(N'2025-07-13T14:42:38.903' AS DateTime), NULL, 1, N'NW4PA_user', CAST(N'2025-06-06T06:34:02.000' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T14:42:41.280' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (199, 6, 4, CAST(N'2025-06-16T14:42:25.600' AS DateTime), CAST(N'2025-06-16T15:21:56.350' AS DateTime), CAST(N'2025-06-16T15:29:21.493' AS DateTime), 10, 12.5000, CAST(0.085 AS Decimal(6, 3)), 0, N'Cash', CAST(N'2025-06-17T06:59:01.717' AS DateTime), NULL, 1, N'NW4PA_user', CAST(N'2025-06-16T14:42:25.613' AS DateTime), N'NW4PA_user', CAST(N'2025-06-17T06:59:09.180' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (200, 10, 101, CAST(N'2025-06-17T06:59:34.273' AS DateTime), CAST(N'2025-06-17T16:18:54.373' AS DateTime), NULL, 10, 22.0000, CAST(0.085 AS Decimal(6, 3)), 0, N'Cash', NULL, NULL, 2, N'NW4PA_user', CAST(N'2025-06-17T06:59:34.273' AS DateTime), N'NW4PA_user', CAST(N'2025-06-17T16:18:54.373' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (201, 10, 2, CAST(N'2025-06-20T06:19:34.110' AS DateTime), CAST(N'2025-07-01T12:33:45.870' AS DateTime), CAST(N'2025-07-01T12:33:50.813' AS DateTime), 10, 56.0000, CAST(0.085 AS Decimal(6, 3)), 0, N'Cash', CAST(N'2025-07-01T12:33:53.467' AS DateTime), NULL, 1, N'NW4PA_user', CAST(N'2025-06-20T06:19:34.123' AS DateTime), N'NW4PA_user', CAST(N'2025-07-01T12:33:56.130' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (202, 10, 101, CAST(N'2025-07-01T12:35:01.660' AS DateTime), CAST(N'2025-07-13T16:09:45.430' AS DateTime), NULL, 85, 0.0000, CAST(0.085 AS Decimal(6, 3)), 0, N'Cash', NULL, NULL, 2, N'NW4PA_user', CAST(N'2025-07-01T12:35:01.663' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T16:09:45.430' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (203, 10, 1, CAST(N'2025-07-04T05:01:15.500' AS DateTime), CAST(N'2025-07-04T05:35:38.443' AS DateTime), NULL, 10, 15.0000, CAST(0.085 AS Decimal(6, 3)), 1, N'Cash', NULL, NULL, 2, N'NW4PA_user', CAST(N'2025-07-04T05:01:15.510' AS DateTime), N'NW4PA_user', CAST(N'2025-07-04T05:35:38.443' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (204, 10, 101, CAST(N'2025-07-04T05:37:37.403' AS DateTime), CAST(N'2025-07-13T16:34:37.590' AS DateTime), CAST(N'2025-07-13T16:34:49.103' AS DateTime), NULL, 0.0000, CAST(0.085 AS Decimal(6, 3)), 1, N'Cash', NULL, NULL, 4, N'NW4PA_user', CAST(N'2025-07-04T05:37:37.403' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T16:34:49.107' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (205, 10, 101, CAST(N'2025-07-05T07:58:12.510' AS DateTime), CAST(N'2025-07-07T13:25:20.600' AS DateTime), CAST(N'2025-07-07T13:25:32.170' AS DateTime), 10, 150.0000, CAST(0.085 AS Decimal(6, 3)), 0, N'Cash', CAST(N'2025-07-07T13:25:51.343' AS DateTime), N'Shipped early. Let customer know.', 1, N'NW4PA_user', CAST(N'2025-07-05T07:58:12.523' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T13:25:58.937' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (206, 10, 101, CAST(N'2025-07-07T10:07:02.583' AS DateTime), CAST(N'2025-07-07T10:51:43.590' AS DateTime), CAST(N'2025-07-07T10:52:56.557' AS DateTime), 9, 40.0000, CAST(0.085 AS Decimal(6, 3)), 0, N'Cash', CAST(N'2025-07-07T10:53:00.453' AS DateTime), NULL, 1, N'NW4PA_user', CAST(N'2025-07-07T10:07:02.597' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T10:53:03.990' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (207, 10, 3, CAST(N'2025-07-07T15:54:15.780' AS DateTime), CAST(N'2025-07-07T15:55:06.450' AS DateTime), CAST(N'2025-07-07T15:55:30.020' AS DateTime), 10, 48.0000, CAST(0.085 AS Decimal(6, 3)), 0, N'Cash', CAST(N'2025-07-07T15:55:40.173' AS DateTime), NULL, 1, N'NW4PA_user', CAST(N'2025-07-07T15:54:15.790' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T15:55:43.860' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (208, 10, 6, CAST(N'2025-07-07T15:56:28.467' AS DateTime), CAST(N'2025-07-07T15:57:20.940' AS DateTime), CAST(N'2025-07-07T15:57:38.770' AS DateTime), NULL, 40.0000, CAST(0.085 AS Decimal(6, 3)), 1, N'Cash', CAST(N'2025-07-07T15:57:42.713' AS DateTime), NULL, 1, N'NW4PA_user', CAST(N'2025-07-07T15:56:28.467' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T15:57:50.660' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (209, 10, 101, CAST(N'2025-07-09T12:20:29.660' AS DateTime), CAST(N'2025-07-09T12:27:38.360' AS DateTime), CAST(N'2025-07-09T12:28:27.640' AS DateTime), 10, 60.0000, CAST(0.085 AS Decimal(6, 3)), 1, N'Cash', CAST(N'2025-07-09T12:28:32.987' AS DateTime), NULL, 1, N'NW4PA_user', CAST(N'2025-07-09T12:20:29.670' AS DateTime), N'NW4PA_user', CAST(N'2025-07-09T12:28:35.383' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (210, 10, 4, CAST(N'2025-07-10T13:52:20.080' AS DateTime), NULL, NULL, NULL, 0.0000, CAST(0.000 AS Decimal(6, 3)), 0, N'Cash', NULL, NULL, 3, N'NW4PA_user', CAST(N'2025-07-10T13:52:20.093' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (211, 10, 85, CAST(N'2025-07-10T13:53:23.990' AS DateTime), NULL, NULL, 10, 15.0000, CAST(0.085 AS Decimal(6, 3)), 0, N'Cash', NULL, NULL, 3, N'NW4PA_user', CAST(N'2025-07-10T13:53:23.990' AS DateTime), N'NW4PA_user', CAST(N'2025-07-23T13:09:29.743' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (212, 10, 3, CAST(N'2025-07-10T14:04:10.723' AS DateTime), CAST(N'2025-07-12T06:06:05.280' AS DateTime), NULL, 10, 20.0000, CAST(0.085 AS Decimal(6, 3)), 0, N'Cash', NULL, NULL, 2, N'NW4PA_user', CAST(N'2025-07-10T14:04:10.727' AS DateTime), N'NW4PA_user', CAST(N'2025-07-12T06:06:05.280' AS DateTime))
GO
INSERT [dbo].[Orders] ([OrderID], [EmployeeID], [CustomerID], [OrderDate], [InvoiceDate], [ShippedDate], [ShipperID], [ShippingFee], [TaxRate], [TaxStatusID], [PaymentMethod], [PaidDate], [Notes], [OrderStatusID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (213, 10, 6, CAST(N'2025-07-12T06:16:41.847' AS DateTime), CAST(N'2025-07-12T06:18:36.230' AS DateTime), CAST(N'2025-07-13T16:32:55.413' AS DateTime), 10, 10.0000, CAST(0.085 AS Decimal(6, 3)), 0, N'Cash', CAST(N'2025-07-13T16:33:03.037' AS DateTime), NULL, 1, N'NW4PA_user', CAST(N'2025-07-12T06:16:41.850' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T16:33:14.820' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 
GO
INSERT [dbo].[OrderStatus] ([OrderStatusID], [OrderStatusCode], [OrderStatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'CLO', N'Closed', 40, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[OrderStatus] ([OrderStatusID], [OrderStatusCode], [OrderStatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'INV', N'Invoiced', 20, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[OrderStatus] ([OrderStatusID], [OrderStatusCode], [OrderStatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, N'NEW', N'New', 10, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[OrderStatus] ([OrderStatusID], [OrderStatusCode], [OrderStatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (4, N'SHI', N'Shipped', 30, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[OrderStatus] ([OrderStatusID], [OrderStatusCode], [OrderStatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (5, N'PAY', N'Paid', 35, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[Privileges] ON 
GO
INSERT [dbo].[Privileges] ([PrivilegeID], [PrivilegeName], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'Purchase Approvals', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Privileges] ([PrivilegeID], [PrivilegeName], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'Close for StockTake', N'NW4PA_user', CAST(N'2025-03-15T06:52:17.000' AS DateTime), N'NW4PA_user', CAST(N'2025-03-15T06:52:40.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Privileges] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategories] ON 
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'Baked Goods & Mixes', N'BAK', N'Baked Goods and Baking Mixes', N'Baked3.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'Beverages', N'BEV', N'Coffee, Soda, Water, Juices and Beers', N'Beverage3.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, N'Candy', N'CDY', N'Chocolate, Hard Candy and Mints', N'Candy3.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (4, N'Canned Fruit & Vegetables', N'CFV', N'Fruits and Vegetables in Cans and Jars', N'Canned Fruit.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (5, N'Canned Meat', N'CM', N'Tinned Fish, Beef and Pork', N'Canned Meat2.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (6, N'Cereal', N'CER', N'Oatmeal, Granola and Boxed Cereals', N'Cereal2.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (7, N'Chips, Snacks', N'SNK', N'Chips, Pretzels, Popcorn and Cheese Puffs', N'Chips3.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (8, N'Condiments', N'CON', N'Whole and Ground Spices, Herbs and Bottled Sauces', N'Condiment3.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (9, N'Dairy Products', N'DAI', N'Milk and Cheese from Satisfied Cows', N'Dairy.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (10, N'Dried Fruit & Nuts', N'DRI', N'Raw and Roasted Nuts, Seeds and Dehydrated Fruits', N'Dried Fruit3.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (11, N'Grains', N'GRA', N'Rice, Whole Wheat and Oats', N'Grains.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (12, N'Jams, Preserves', N'JAM', N'Preserved Fruit in Jars', N'Jam2.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (13, N'Oil', N'OIL', N'Cooking and Salad Oils', N'Oil.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (14, N'Pasta', N'PAS', N'Dried Wheat and Rice Pasta in Various Shapes and Varieties', N'Pasta3.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (15, N'Sauces', N'SAU', N'Tomato Sauces, Gravies and Hot Sauce', N'Sauce.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductCategories] ([ProductCategoryID], [ProductCategoryName], [ProductCategoryCode], [ProductCategoryDesc], [ProductCategoryImageName], [ProductCategoryImage], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (16, N'Soups', N'SOU', N'Canned Soups, Chowders and Bisques', N'Soup.jpg', NULL, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[ProductCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'NWTDRI- 74', N'Almonds', N'<div>Premium almonds from California''s Central Valley</div>', 7.5000, 10.0000, 30, 20, N'5 kg pkg.', 0, 5, 10, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'NWTBEV-2', N'Beer', N'<p>Belgian-style: a flavorful, balanced beer with characteristics of hops, malt and fruity yeast</p>', 10.5000, 14.0000, 90, 160, N'24 - 12 oz bottles', 0, 160, 2, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-07-15T05:57:26.753' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, N'NWTJAM- 6', N'Boysenberry Spread', N'<div>Boy, some berries. A <font face="Berlin Sans FB" color="#6F3198"><strong>delicious</strong></font><font
color="#6F3198"> </font>alternative topping for toast, pancakes and waffles</div>', 18.7500, 25.0000, 130, 100, N'12 - 8 oz jars', 0, 25, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-04-07T14:41:52.760' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (4, N'NWTBAK-4', N'Brownie Mix', N'<p>Rich and fudgy, for a dense, chewy brownie with fudge topping</p>', 9.0000, 12.4900, 30, 20, N'3 boxes', 0, 5, 1, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T14:38:20.783' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (5, N'NWTCON- 4', N'Cajun Seasoning', N'<div>Adds <font face=Forte color="#C55A11">zingy </font>new taste to meat, seafood, vegetables, eggs and more</div>', 16.5000, 22.0000, 60, 40, N'48 - 6 oz jars', 0, 10, 8, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (6, N'NWTBAK-6', N'Cake Mix', NULL, 10.5000, 15.9900, 30, 20, N'4 boxes', 0, 5, 1, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-07-14T13:13:45.150' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (7, N'NWTBEV- 1', N'Chai', N'<div><font face="Monotype Corsiva" color="#0C0C0C"><strong><em>Black tea</em></strong></font><em> </em>with a blend of cardamom, ginger, cloves and cinnamon</div>', 13.5000, 18.0000, 60, 40, N'10 boxes x 20 bags', 0, 10, 2, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (8, N'NWTCFV-8', N'Cherry Pie Filling', N'<div>Real, whole, tart <font face="Bauhaus 93" color="#CC0066"><strong>cherries</strong></font><font
face="Bauhaus 93"> </font>hand-picked at their peak</div>', 1.0000, 2.0000, 60, 40, N'15.25 OZ', 0, 40, 4, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-06-01T09:14:52.240' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (9, N'NWTSOU- 99', N'Chicken Soup', N'<div>To warm the soul. Rich broth chock-full of tender chicken, fresh diced vegetables and hearty egg noodles</div>', 1.0000, 1.9500, 260, 200, N'1', 0, 90, 16, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (10, N'NWTCDY-10', N'Chocolate', N'<div>Smooth and satisfying, 72% <font face=Broadway color="#7A4E2B">cacao </font>for an antioxidant boost</div>', 9.5600, 12.7500, 130, 100, N'10 pkgs', 0, 25, 3, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-06-30T14:22:19.153' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (11, N'NWTBAK-11', N'Chocolate Biscuits Mix', N'<div>A flaky, buttery, <font face="Lucida Handwriting" color="#7A4E2B"><strong>chocolatey </strong></font>twist on traditional biscuits</div>', 6.9000, 9.2000, 30, 20, N'10 boxes x 12 pieces', 0, 5, 1, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-06-30T14:54:38.543' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (12, N'NWTSOU- 41', N'Clam Chowder', N'<div>New England style with a creamy base, with generous portions of clams and bacon</div>', 7.2375, 9.6500, 60, 40, N'12 - 12 oz cans', 0, 10, 16, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (13, N'NWTBEV-13', N'Coffee', NULL, 34.5000, 46.0000, 130, 100, N'16 - 500 g tins', 0, 25, 2, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-07-14T15:51:31.743' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (14, N'NWTCFV-14', N'Corn', N'<div>Delicious, tender tri-color sweet corn on the cob</div>', 1.0000, 1.2000, 80, 50, N'14.5 OZ', 0, 40, 4, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-06-30T14:25:39.143' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (15, N'NWTCM- 40', N'Crab Meat', N'<div>Authentic Maryland Blue crab meat, packed by hand</div>', 13.8000, 18.4000, 160, 120, N'24 - 4 oz tins', 0, 30, 5, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (16, N'NWTSAU- 8', N'Curry Sauce', N'<div>Thai style red curry sauce is a zesty blend of red chili puree, coconut milk, onions, garlic and ginger</div>', 30.0000, 40.0000, 60, 40, N'12 - 12 oz jars', 0, 10, 15, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (17, N'NWTDRI-17', N'Dried Apples', NULL, 39.7500, 53.0000, 60, 40, N'50 - 300 g pkgs.', 0, 10, 10, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-07-09T12:06:35.813' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (18, N'NWTDRI- 7', N'Dried Pears', N'<div>A sweet treat for hikers and snackers</div>', 22.5000, 30.0000, 60, 40, N'12 - 1 lb pkgs.', 0, 10, 10, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (19, N'NWTDRI- 80', N'Dried Plums', N'<div>Dense, sweet <font face="Curlz MT" size=3 color="#6F3198"><strong>dried plums</strong></font>: the perfect snack for people on the go</div>', 3.0000, 3.5000, 100, 75, N'1 lb bag', 0, 25, 10, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (20, N'NWTCFV-20', N'Fruit Cocktail', NULL, 29.2500, 39.0000, 60, 40, N'15.25 OZ cans', 0, 10, 4, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-07-01T12:18:22.220' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (21, N'NWTPAS- 56', N'Gnocchi', N'<div>Traditional Italian potato dumplings, fully-cooked; ready to heat and eat</div>', 28.5000, 38.0000, 160, 120, N'24 - 250 g pkgs.', 0, 30, 14, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (22, N'NWTCER- 82', N'Granola', N'<div>A super <font face="Snap ITC" size=3 color="#2F5496">crunchy </font>treat: Oats loaded with almonds, walnuts, hazelnuts, raisins, coconut and dried cranberry</div>', 2.0000, 4.0000, 130, 100, NULL, 0, 50, 6, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (23, N'NWTCFV-23', N'Green Beans', N'<div>Whole fresh <font color="#538135"><strong>green </strong></font>beans picked in their prime</div>', 1.0000, 1.2000, 60, 40, N'14.5 OZ', 0, 40, 4, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-06-01T09:38:28.663' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (24, N'NWTBEV- 81', N'Green Tea', N'<div>Authentic <font color="#538135"><strong>green tea</strong></font> leaves, dried quickly after harvest to preserve their vibrant color and naturally occurring antioxidants</div>', 2.0000, 2.9900, 170, 125, N'20 bags per box', 0, 25, 2, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (25, N'NWTSAU- 65', N'Hot Pepper Sauce', N'<div><font face=Chiller size=4 color="#ED1C24"><strong>Hot stuff!</strong></font><font
size=4> </font>Adds tastebud-searing warmth to any dish</div>', 15.7875, 21.0500, 60, 40, N'32 - 8 oz bottles', 0, 10, 15, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (26, N'NWTGRA- 52', N'Long Grain Rice', N'<div>Premium white Basmati</div>', 5.2500, 7.0000, 130, 100, N'16 - 2 kg boxes', 0, 25, 11, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (27, N'NWTDAI- 72', N'Mozzarella', N'<div>Fresh, mild and cheesy; a staple of Italian cuisine</div>', 26.1000, 34.8000, 60, 40, N'24 - 200 g pkgs.', 0, 10, 9, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (28, N'NWTCON- 77', N'Mustard', N'<div>Stone-ground dijon-style prepared mustard</div>', 9.7500, 13.0000, 90, 60, N'12 boxes', 0, 15, 8, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (29, N'NWTOIL- 5', N'Olive Oil', N'<div>Extra virgin for smooth taste and versatility</div>', 16.0125, 21.3500, 60, 40, N'36 boxes', 0, 10, 13, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (30, N'NWTCFV-30', N'Peaches', N'<div>Delicious, juicy freestone peaches suitable for canning, baking and snacking</div>', 1.0000, 1.5000, 60, 40, N'15.25 OZ', 0, 40, 4, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-06-01T09:43:29.650' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (31, N'NWTCFV-31', N'Pears', N'<div>Organic <font face="Berlin Sans FB" color="#BA1419">red D''Anjou pears</font>, ripened to pear-fection</div>', 1.0000, 1.3000, 60, 40, N'15.25 OZ', 0, 48, 4, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-06-01T09:42:06.260' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (32, N'NWTCFV-32', N'Peas', N'<div>Baby <font face="Showcard Gothic" color="#538135"><strong>green peas</strong> </font>in the pod, ready for shucking</div>', 1.0000, 1.5000, 60, 40, N'14.5 OZ', 0, 48, 4, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-06-01T09:44:05.723' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (33, N'NWTCFV-33', N'Pineapple', N'<div>Fresh from Hawaii: ripe, succulent whole fruits</div>', 1.0000, 1.8000, 60, 40, N'15.25 OZ', 0, 48, 4, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-06-01T09:44:21.033' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (34, N'NWTSNK- 83', N'Potato Chips', N'<div>Kettle-cooked crispy snackers</div>', 0.5000, 1.8000, 70, 50, NULL, 0, 75, 7, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (35, N'NWTPAS-35', N'Ravioli', N'<div>Tender pasta envelopes filled with ricotta cheese and spinach</div>', 14.6300, 19.5000, 110, 80, N'24 - 250 g pkgs.', 0, 20, 14, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T13:17:31.233' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (36, N'NWTBAK-36', N'Scones', N'<div>The perfect accompaniment to coffee or proper tea</div>', 7.5000, 10.0000, 30, 20, N'24 pkgs. x 4 pieces', 0, 5, 1, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-06-30T14:40:28.960' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (37, N'NWTCM-37', N'Smoked Salmon', N'<div>From the Pacific Northwest''s pristine icy cold waters and hardwood-smoked </div>', 2.0000, 4.0000, 70, 50, N'5 oz', 0, 25, 5, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-06-01T09:45:01.487' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (38, N'NWTCON- 3', N'Syrup', N'<div>Pure cane syrup</div>', 7.5000, 10.0000, 130, 100, N'12 - 550 ml bottles', 0, 25, 8, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (39, N'NWTBEV-39', N'Tea', N'<div>Robust<font color="#0C0C0C"><strong> </strong></font><font
face="Kristen ITC" color="#0C0C0C"><strong>black tea leaves</strong></font> have rich flavor, dark color, and a smooth finish</div>', 2.0000, 4.0000, 70, 50, N'100 count per box', 0, 50, 2, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-06-30T14:11:57.987' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (40, N'NWTSAU- 66', N'Tomato Sauce', N'<div>Delicately seasoned with salt, pepper and herbs</div>', 12.7500, 17.0000, 110, 80, N'24 - 8 oz jars', 0, 20, 15, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (41, N'NWTCM-41', N'Tuna Fish', N'<div>Wild-caught solid-white albacore tuna packed in water</div>', 0.5000, 2.0000, 70, 50, N'5 oz', 0, 60, 5, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'NW4PA_user', CAST(N'2025-06-01T09:45:44.077' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (42, N'NWTSOU- 98', N'Vegetable Soup', N'<div>Farm-fresh diced vegetable medley in a rich vegetable broth</div>', 1.0000, 1.8900, 260, 200, N'1', 0, NULL, 16, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (43, N'NWTDRI- 14', N'Walnuts', N'<div>Shelled, energy-dense and loaded with polyunsaturated &quot;good&quot; fats. Perfect baking and snacking</div>', 17.4375, 23.2500, 60, 40, N'40 - 100 g pkgs.', 0, 10, 10, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (44, N'NWTCDY-44', N'Grampa''s Gummies', N'<p>Surprise your fiends and family with<span style="color:#27ae60"><em> test products </em></span><em>based on your favorite cartoon characters.</em></p>', 12.0000, 24.0000, 25, 30, N'24 packets per box', 0, 45, 3, N'NW4PA_user', CAST(N'2025-03-17T06:27:32.473' AS DateTime), N'NW4PA_user', CAST(N'2025-05-03T13:50:07.873' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (47, N'NWTBAK-47', N'Multi-Grain Bun', NULL, 2.6500, 4.9900, 60, 40, N'40', 0, 40, 1, N'NW4PA_user', CAST(N'2025-04-21T10:09:44.833' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T09:43:14.097' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (49, N'NWTCM-49', N'Chili Dogs and Cheese', N'<p>Delicious and wholesome</p>', 16.0000, 32.5000, 60, 60, N'60', 0, 60, 5, N'NW4PA_user', CAST(N'2025-04-22T07:38:21.857' AS DateTime), N'NW4PA_user', CAST(N'2025-04-27T09:29:38.820' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (56, N'NWTCER-56', N'Golden Globes', N'Golden gloves of goodness. Real Chocolate, Real Peanuts, Real Good', 12.0000, 12.0000, 12, 12, N'12', 0, 60, 6, N'NW4PA_user', CAST(N'2025-04-22T08:28:46.950' AS DateTime), N'NW4PA_user', CAST(N'2025-05-03T13:35:41.713' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (59, N'NWTCM-59', N'Chili con Pollo', NULL, 1.0000, 2.9500, 60, 60, N'60', 0, 60, 5, N'NW4PA_user', CAST(N'2025-04-22T09:35:39.753' AS DateTime), N'NW4PA_user', CAST(N'2025-04-22T09:35:39.763' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (60, N'NWTCDY-60', N'Great Gobs of Fire', N'<p>Fiery <span style="color:#c0392b">cinnamon </span>goodness for the adventurous candy-lover.</p>', 9.0000, 18.0000, 50, 80, N'80', 0, 50, 3, N'NW4PA_user', CAST(N'2025-05-11T07:34:30.880' AS DateTime), N'NW4PA_user', CAST(N'2025-07-15T05:57:43.863' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (61, N'NWTJAM-61', N'Thank Heavens for Honey', N'<p>The most <span style="background-color:#f39c12">bee-</span>utiful honey available.</p>', 18.0000, 36.0000, 40, 60, N'60', 0, 36, 12, N'NW4PA_user', CAST(N'2025-06-03T17:11:28.697' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (64, N'NWTCDY-64', N'Goody Gum Drops', N'<p>Every drop is a burst of flavor delight. <span style="color:#c0392b">Strawberry</span>, <span style="color:#f39c12">Orange </span>and <span style="color:#8e44ad">Grape</span>.</p>', 2.5000, 6.7500, 100, 120, N'1', 0, 25, 3, N'NW4PA_user', CAST(N'2025-06-20T11:02:52.290' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T09:20:21.750' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (66, N'NWTPAS-66', N'Shell Macaroni', N'<p>Only first quality ingredients ensure a wholesome, tasty treat for your family</p>', 9.0000, 6.0000, 30, 30, N'30', 0, 30, 14, N'NW4PA_user', CAST(N'2025-06-29T11:01:52.220' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (71, N'NWTJAM-71', N'Chokecherry Jelly', N'<p>Exquisite taste. Unique color. A taste experience only available for a short time each season. Hand-crafted in small batches just for Northwind''s discriminating customers.</p>', 36.0000, 54.0000, 30, 30, N'30', 0, 30, 12, N'NW4PA_user', CAST(N'2025-06-29T11:26:14.207' AS DateTime), N'NW4PA_user', CAST(N'2025-07-01T13:39:07.747' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (73, N'NWTCM-73', N'Shredded Brisket', N'<p><strong>Prime </strong>Brisket, slow-roasted to a golden perfection.&nbsp;Your guests will toast your good taste. So pair this one with a wine from our wine list.</p>', 90.0000, 60.0000, 60, 90, N' 12 8 ounce cans', 0, 45, 5, N'NW4PA_user', CAST(N'2025-06-29T12:23:23.253' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T12:44:39.347' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (74, N'NWTBAK-74', N'Maple Bars', N'<p>Wake up to the nostalgic taste of Vermont Maple Sugar. Relax with the favorite hot beverage and savor the magic of our Maple Bars</p>', 2.9900, 6.9900, 50, 50, N'50', 0, 25, 1, N'NW4PA_user', CAST(N'2025-07-07T09:19:52.180' AS DateTime), N'NW4PA_user', CAST(N'2025-07-14T13:39:01.347' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (75, N'NWTDAI-75', N'Cheddar Bites', N'<p>Healthier snacking for everyone</p>', 36.0000, 48.0000, 90, 90, N'90', 0, 100, 9, N'NW4PA_user', CAST(N'2025-07-07T11:49:41.547' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T11:55:13.313' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (76, N'NWTDRI-76', N'Banana Chips', N'<p>Freeze dried at the peak of ripeness and shipped directly from the tropics to your door.</p>', 20.0000, 36.0000, 60, 60, N'60', 0, 45, 10, N'NW4PA_user', CAST(N'2025-07-07T12:30:52.990' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (77, N'NWTDRI-77', N'Betty Goat Gruff Cheese', NULL, 60.0000, 45.0000, 60, 60, N'60', 0, 60, 10, N'NW4PA_user', CAST(N'2025-07-07T12:43:31.010' AS DateTime), N'NW4PA_user', CAST(N'2025-07-12T06:57:38.870' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (78, N'NWTJAM-78', N'Golden Grape Jelly', N'<p>Grape Jelly like you''ve never tasted it before.</p>', 30.0000, 48.0000, 60, 60, N'60', 0, 60, 12, N'NW4PA_user', CAST(N'2025-07-07T12:49:21.077' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (80, N'NWTCM-80', N'Glazed Ham', N'<p>Slow cooked to perfection</p>', 18.0000, 35.0000, 60, 60, N'60 oz cans', 0, 9, 5, N'NW4PA_user', CAST(N'2025-07-07T12:55:16.683' AS DateTime), N'NW4PA_user', CAST(N'2025-07-15T06:49:12.317' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (81, N'NWTCDY-81', N'Swirly Bits in Chocolate', NULL, 22.0000, 36.0000, 60, 90, N'18 3 ounce pouchs', 0, 90, 3, N'NW4PA_user', CAST(N'2025-07-07T13:01:41.677' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T15:47:26.737' AS DateTime))
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (82, N'NWTCFV-82', N'Nectarines', N'<p>Picked at the peak of flavor. Nectarines are the fruit of the gods.</p>', 30.0000, 48.0000, 90, 90, N'90', 0, 90, 4, N'NW4PA_user', CAST(N'2025-07-07T15:49:38.103' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Products] ([ProductID], [ProductCode], [ProductName], [ProductDescription], [StandardUnitCost], [UnitPrice], [ReorderLevel], [TargetLevel], [QuantityPerUnit], [Discontinued], [MinimumReorderQuantity], [ProductCategoryID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (83, N'NWTSNK-83', N'Carmel Popping Corn', N'<p>Firm and full-sized kernels every time</p>', 4.0000, 6.0000, 60, 60, N'60', 0, 25, 7, N'NW4PA_user', CAST(N'2025-07-09T12:17:13.450' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductVendors] ON 
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, 2, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, 3, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (4, 4, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (5, 5, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (6, 6, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (7, 7, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (8, 8, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (9, 9, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (10, 10, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (11, 11, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (12, 12, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (13, 13, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (14, 14, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (15, 15, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (16, 16, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (17, 17, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (18, 18, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (19, 19, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (20, 20, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (21, 21, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (22, 22, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (23, 23, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (24, 24, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (25, 25, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (26, 26, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (27, 27, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (28, 28, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (29, 29, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (30, 30, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (31, 31, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (32, 32, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (33, 33, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (34, 34, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (35, 35, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (36, 36, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (37, 37, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (38, 38, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (39, 39, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (40, 40, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (41, 41, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (42, 42, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (43, 43, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (44, 1, 12, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (45, 1, 11, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (46, 2, 11, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (47, 3, 11, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (48, 4, 11, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (49, 59, 12, N'NW4PA_user', CAST(N'2025-06-29T15:43:07.287' AS DateTime), N'NW4PA_user', CAST(N'2025-06-29T15:47:07.063' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (50, 49, 12, N'NW4PA_user', CAST(N'2025-06-29T15:43:07.287' AS DateTime), N'NW4PA_user', CAST(N'2025-06-29T15:47:07.063' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51, 71, 12, N'NW4PA_user', CAST(N'2025-06-29T15:43:07.287' AS DateTime), N'NW4PA_user', CAST(N'2025-06-29T15:47:07.063' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (52, 56, 12, N'NW4PA_user', CAST(N'2025-06-29T15:43:07.287' AS DateTime), N'NW4PA_user', CAST(N'2025-06-29T15:47:07.063' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (53, 64, 12, N'NW4PA_user', CAST(N'2025-06-29T15:43:07.287' AS DateTime), N'NW4PA_user', CAST(N'2025-06-29T15:47:07.063' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (54, 44, 12, N'NW4PA_user', CAST(N'2025-06-29T15:43:07.287' AS DateTime), N'NW4PA_user', CAST(N'2025-06-29T15:47:07.063' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (55, 60, 12, N'NW4PA_user', CAST(N'2025-06-29T15:43:07.287' AS DateTime), N'NW4PA_user', CAST(N'2025-06-29T15:47:07.063' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (56, 47, 12, N'NW4PA_user', CAST(N'2025-06-29T15:43:07.287' AS DateTime), N'NW4PA_user', CAST(N'2025-06-29T15:47:07.063' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (57, 66, 12, N'NW4PA_user', CAST(N'2025-06-29T15:43:07.287' AS DateTime), N'NW4PA_user', CAST(N'2025-06-29T15:47:07.063' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (58, 73, 12, N'NW4PA_user', CAST(N'2025-06-29T15:43:07.287' AS DateTime), N'NW4PA_user', CAST(N'2025-06-29T15:47:07.063' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (59, 61, 12, N'NW4PA_user', CAST(N'2025-06-29T15:43:07.287' AS DateTime), N'NW4PA_user', CAST(N'2025-06-29T15:47:07.063' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (60, 76, 11, N'NW4PA_user', CAST(N'2025-07-13T10:07:49.343' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T10:15:53.523' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (61, 77, 11, N'NW4PA_user', CAST(N'2025-07-13T10:07:49.343' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T10:15:53.523' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (62, 83, 11, N'NW4PA_user', CAST(N'2025-07-13T10:07:49.343' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T10:15:53.523' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (63, 75, 11, N'NW4PA_user', CAST(N'2025-07-13T10:07:49.343' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T10:15:53.523' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (64, 80, 11, N'NW4PA_user', CAST(N'2025-07-13T10:07:49.343' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T10:15:53.523' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (65, 78, 11, N'NW4PA_user', CAST(N'2025-07-13T10:07:49.343' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T10:15:53.523' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (66, 74, 11, N'NW4PA_user', CAST(N'2025-07-13T10:07:49.343' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T10:15:53.523' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (67, 82, 11, N'NW4PA_user', CAST(N'2025-07-13T10:07:49.343' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T10:15:53.523' AS DateTime))
GO
INSERT [dbo].[ProductVendors] ([ProductVendorID], [ProductID], [VendorID], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (68, 81, 11, N'NW4PA_user', CAST(N'2025-07-13T10:07:49.343' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T10:15:53.523' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[ProductVendors] OFF
GO
SET IDENTITY_INSERT [dbo].[PurchaseOrderDetails] ON 
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, 91, 1, 20, 7.5000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, 91, 2, 160, 10.5000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, 91, 3, 100, 18.7500, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (4, 91, 4, 20, 9.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (5, 91, 5, 40, 16.5000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (6, 91, 6, 20, 10.5000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (7, 91, 7, 40, 13.5000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (8, 91, 8, 40, 1.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (9, 91, 9, 200, 1.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (10, 91, 10, 100, 9.5625, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (11, 91, 11, 20, 6.9000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (12, 91, 12, 40, 7.2375, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (13, 91, 13, 100, 34.5000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (14, 91, 14, 40, 1.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (15, 91, 15, 120, 13.8000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (16, 91, 16, 40, 30.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (17, 91, 17, 40, 39.7500, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (18, 91, 18, 40, 22.5000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (19, 91, 19, 75, 3.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (20, 91, 20, 40, 29.2500, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (21, 91, 21, 120, 28.5000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (22, 91, 22, 100, 2.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (23, 91, 23, 40, 1.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (24, 91, 24, 125, 2.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (25, 91, 25, 40, 15.7875, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (26, 91, 26, 100, 5.2500, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (27, 91, 27, 40, 26.1000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (28, 91, 28, 60, 9.7500, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (29, 91, 29, 40, 16.0125, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (30, 91, 30, 40, 1.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (31, 91, 31, 40, 1.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (32, 91, 32, 40, 1.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (33, 91, 33, 40, 1.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (34, 91, 34, 50, 0.5000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (35, 91, 35, 80, 14.6250, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (36, 91, 36, 20, 7.5000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (37, 91, 37, 50, 2.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (38, 91, 38, 100, 7.5000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (39, 91, 39, 50, 2.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (40, 91, 40, 80, 12.7500, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (41, 91, 41, 50, 0.5000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (42, 91, 42, 200, 1.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (43, 91, 43, 40, 17.4375, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (44, 91, 44, 30, 12.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (45, 91, 47, 40, 2.6500, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (46, 91, 49, 60, 16.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (47, 91, 56, 12, 12.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (48, 91, 59, 60, 1.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (49, 91, 60, 80, 9.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (50, 91, 61, 60, 18.0000, CAST(N'2025-06-05T11:52:00.050' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:32:33.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.450' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51, 92, 4, 100, 9.0000, CAST(N'2025-06-11T15:58:43.950' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T15:57:57.950' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T15:58:51.117' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (52, 92, 2, 100, 10.5000, CAST(N'2025-06-11T15:58:43.950' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T15:58:09.060' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T15:58:51.117' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (53, 92, 7, 40, 13.5000, CAST(N'2025-06-11T15:58:43.950' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T15:58:17.770' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T15:58:51.117' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (54, 93, 71, 30, 36.0000, CAST(N'2025-07-02T14:20:04.403' AS DateTime), N'NW4PA_user', CAST(N'2025-07-01T13:39:39.540' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:20:09.637' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (55, 93, 7, 60, 13.5000, CAST(N'2025-07-02T14:20:04.403' AS DateTime), N'NW4PA_user', CAST(N'2025-07-01T13:39:57.203' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:20:09.637' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (56, 94, 7, 100, 13.5000, CAST(N'2025-07-02T14:30:56.673' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:29:02.400' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:30:59.947' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (57, 94, 13, 50, 34.5000, CAST(N'2025-07-02T14:30:56.673' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:29:26.490' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:30:59.947' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (58, 94, 14, 45, 1.0000, CAST(N'2025-07-02T14:30:56.673' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:30:06.010' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:30:59.947' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (59, 96, 24, 90, 2.0000, CAST(N'2025-07-02T14:37:19.117' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:32:44.783' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:37:23.843' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (60, 96, 64, 25, 2.5000, CAST(N'2025-07-02T14:37:19.117' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:32:57.197' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:37:23.843' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (62, 97, 64, 95, 2.5000, CAST(N'2025-07-02T14:45:44.367' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:43:48.013' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:45:46.137' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (64, 98, 66, 60, 9.0000, CAST(N'2025-07-02T14:53:43.380' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:47:06.027' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:53:48.023' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (65, 99, 73, 30, 90.0000, CAST(N'2025-07-02T15:03:15.610' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:54:37.190' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:03:19.600' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (66, 100, 73, 60, 90.0000, CAST(N'2025-07-02T15:08:32.750' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:05:04.477' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:08:37.150' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (67, 101, 6, 60, 10.5000, CAST(N'2025-07-02T15:15:39.690' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:09:27.440' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:15:43.837' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (68, 102, 5, 25, 16.5000, CAST(N'2025-07-02T15:16:42.390' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:16:19.933' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:16:45.553' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (69, 103, 20, 40, 29.2500, CAST(N'2025-07-02T15:17:33.140' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:17:08.833' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:17:36.390' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (73, 104, 1, 25, 7.5000, CAST(N'2025-07-02T15:19:35.967' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:18:53.680' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:19:38.993' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (74, 104, 2, 5, 10.5000, CAST(N'2025-07-02T15:19:35.967' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:18:58.617' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:19:38.993' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (75, 104, 3, 160, 18.7500, CAST(N'2025-07-02T15:19:35.967' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:19:05.027' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:19:38.993' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (76, 104, 4, 25, 9.0000, CAST(N'2025-07-02T15:19:35.967' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:19:11.267' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:19:38.993' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (77, 104, 7, 5, 13.5000, CAST(N'2025-07-02T15:19:35.967' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:19:18.010' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:19:38.993' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (79, 116, 74, 50, 2.9900, CAST(N'2025-07-07T10:06:19.363' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T10:06:00.683' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T10:06:22.770' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (81, 117, 81, 50, 22.0000, CAST(N'2025-07-07T13:09:23.223' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T13:06:22.917' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T13:09:27.900' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (82, 117, 76, 60, 20.0000, CAST(N'2025-07-07T13:09:23.223' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T13:06:42.103' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T13:09:27.900' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (83, 117, 78, 60, 30.0000, CAST(N'2025-07-07T13:09:23.223' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T13:06:58.370' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T13:09:27.900' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (84, 117, 80, 60, 18.0000, CAST(N'2025-07-07T13:09:23.223' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T13:07:24.060' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T13:09:27.900' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (85, 118, 82, 90, 30.0000, CAST(N'2025-07-07T15:51:49.073' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T15:51:00.940' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T15:52:48.223' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (86, 120, 83, 60, 4.0000, CAST(N'2025-07-09T12:20:06.290' AS DateTime), N'NW4PA_user', CAST(N'2025-07-09T12:19:29.683' AS DateTime), N'NW4PA_user', CAST(N'2025-07-09T12:20:10.407' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (88, 114, 6, 10, 10.5000, NULL, N'NW4PA_user', CAST(N'2025-07-10T14:22:45.293' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (89, 114, 5, 15, 16.5000, NULL, N'NW4PA_user', CAST(N'2025-07-10T14:24:19.733' AS DateTime), N'NW4PA_user', CAST(N'2025-07-10T14:24:29.110' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (90, 123, 5, 25, 16.5000, CAST(N'2025-07-12T06:21:03.127' AS DateTime), N'NW4PA_user', CAST(N'2025-07-12T06:19:16.053' AS DateTime), N'NW4PA_user', CAST(N'2025-07-12T06:21:06.777' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (91, 124, 77, 60, 60.0000, CAST(N'2025-07-12T06:56:43.330' AS DateTime), N'NW4PA_user', CAST(N'2025-07-12T06:56:17.817' AS DateTime), N'NW4PA_user', CAST(N'2025-07-12T06:56:45.943' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (92, 125, 74, 30, 2.9900, CAST(N'2025-07-13T11:09:24.960' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T11:07:43.213' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T11:09:37.650' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (93, 125, 76, 30, 20.0000, CAST(N'2025-07-13T11:09:24.960' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T11:08:10.693' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T11:09:37.650' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (94, 121, 5, 95, 16.5000, NULL, N'NW4PA_user', CAST(N'2025-07-13T11:12:42.783' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T11:12:46.733' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (95, 126, 5, 95, 16.5000, CAST(N'2025-07-13T11:18:24.243' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T11:15:46.830' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T11:18:29.200' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (96, 122, 4, 22, 9.0000, NULL, N'NW4PA_user', CAST(N'2025-07-22T10:23:50.303' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[PurchaseOrderDetails] ([PurchaseOrderDetailID], [PurchaseOrderID], [ProductID], [Quantity], [UnitCost], [ReceivedDate], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (97, 122, 49, 15, 16.0000, NULL, N'NW4PA_user', CAST(N'2025-07-22T10:39:44.740' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[PurchaseOrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[PurchaseOrders] ON 
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (91, 11, 5, CAST(N'2025-06-01T00:00:00.000' AS DateTime), 2, CAST(N'2025-06-02T00:00:00.000' AS DateTime), 2, CAST(N'2025-06-05T11:52:00.050' AS DateTime), 100.0000, 2908.1925, CAST(N'2025-06-05T11:52:42.377' AS DateTime), 35321.4425, N'Credit Card', N'Initial Product Purchase', N'NW4PA_user', CAST(N'2025-06-05T11:32:33.430' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T11:52:42.380' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (92, 12, 10, CAST(N'2025-06-11T15:58:25.290' AS DateTime), 2, CAST(N'2025-06-11T15:58:40.257' AS DateTime), 2, CAST(N'2025-06-11T15:58:43.950' AS DateTime), 0.0000, 224.1000, CAST(N'2025-06-11T15:58:51.113' AS DateTime), 2714.1000, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-06-11T15:57:45.580' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T15:58:51.113' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (93, 12, 10, CAST(N'2025-07-02T14:20:09.637' AS DateTime), 10, CAST(N'2025-07-02T14:20:09.637' AS DateTime), 2, CAST(N'2025-07-02T14:20:04.403' AS DateTime), 0.0000, 170.1000, CAST(N'2025-07-02T14:20:09.637' AS DateTime), 2060.1000, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-01T12:31:31.017' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:20:09.637' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (94, 11, 10, CAST(N'2025-07-02T14:30:59.947' AS DateTime), 2, CAST(N'2025-07-02T14:30:59.947' AS DateTime), 2, CAST(N'2025-07-02T14:30:56.673' AS DateTime), 0.0000, 280.8000, CAST(N'2025-07-02T14:30:59.947' AS DateTime), 3400.8000, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-02T14:28:25.037' AS DateTime), N'NW4PA_user', CAST(N'2025-07-03T09:06:28.613' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (96, 11, 10, CAST(N'2025-07-02T14:37:23.843' AS DateTime), 2, CAST(N'2025-07-02T14:37:23.843' AS DateTime), 2, CAST(N'2025-07-02T14:37:19.117' AS DateTime), 0.0000, 21.8250, CAST(N'2025-07-02T14:37:23.843' AS DateTime), 264.3250, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-02T14:32:04.017' AS DateTime), N'NW4PA_user', CAST(N'2025-07-03T09:06:30.343' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (97, 12, 10, CAST(N'2025-07-02T14:45:46.133' AS DateTime), 2, CAST(N'2025-07-02T14:44:00.030' AS DateTime), 2, CAST(N'2025-07-02T14:45:44.367' AS DateTime), 0.0000, 21.3750, CAST(N'2025-07-02T14:45:46.133' AS DateTime), 258.8750, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-02T14:43:36.270' AS DateTime), N'NW4PA_user', CAST(N'2025-07-03T09:06:31.420' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (98, 12, 10, CAST(N'2025-07-02T14:53:48.020' AS DateTime), 8, CAST(N'2025-07-02T14:52:00.890' AS DateTime), 2, CAST(N'2025-07-02T14:53:43.380' AS DateTime), 0.0000, 48.6000, CAST(N'2025-07-02T14:53:48.020' AS DateTime), 588.6000, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-02T14:46:43.873' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T14:53:48.020' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (99, 11, 10, CAST(N'2025-07-02T15:03:19.597' AS DateTime), 8, CAST(N'2025-07-02T15:01:55.123' AS DateTime), 2, CAST(N'2025-07-02T15:03:15.610' AS DateTime), 0.0000, 243.0000, CAST(N'2025-07-02T15:03:19.597' AS DateTime), 2943.0000, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-02T14:54:23.850' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:03:19.600' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (100, 11, 10, CAST(N'2025-07-02T15:08:37.137' AS DateTime), 8, CAST(N'2025-07-02T15:05:57.177' AS DateTime), 2, CAST(N'2025-07-02T15:08:32.750' AS DateTime), 0.0000, 486.0000, CAST(N'2025-07-02T15:08:37.137' AS DateTime), 5886.0000, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-02T15:04:51.723' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:08:37.147' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (101, 12, 10, CAST(N'2025-07-02T15:15:43.837' AS DateTime), 2, CAST(N'2025-07-02T15:14:53.960' AS DateTime), 2, CAST(N'2025-07-02T15:15:39.690' AS DateTime), 0.0000, 56.7000, CAST(N'2025-07-02T15:15:43.837' AS DateTime), 686.7000, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-02T15:09:13.940' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:15:43.837' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (102, 11, 10, CAST(N'2025-07-02T15:16:45.553' AS DateTime), 2, CAST(N'2025-07-02T15:16:37.597' AS DateTime), 2, CAST(N'2025-07-02T15:16:42.390' AS DateTime), 0.0000, 37.1250, CAST(N'2025-07-02T15:16:45.553' AS DateTime), 449.6250, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-02T15:16:04.983' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:16:45.553' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (103, 12, 10, CAST(N'2025-07-02T15:17:36.390' AS DateTime), 2, CAST(N'2025-07-02T15:17:28.860' AS DateTime), 2, CAST(N'2025-07-02T15:17:33.140' AS DateTime), 0.0000, 105.3000, CAST(N'2025-07-02T15:17:36.390' AS DateTime), 1275.3000, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-02T15:16:56.727' AS DateTime), N'NW4PA_user', CAST(N'2025-07-02T15:17:36.390' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (104, 12, 10, CAST(N'2025-07-02T15:19:38.993' AS DateTime), 2, CAST(N'2025-07-02T15:19:32.950' AS DateTime), 2, CAST(N'2025-07-02T15:19:35.967' AS DateTime), 0.0000, 317.9250, CAST(N'2025-07-02T15:19:38.993' AS DateTime), 3850.4250, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-02T15:18:47.260' AS DateTime), N'NW4PA_user', CAST(N'2025-07-03T09:08:39.680' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (114, 12, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'NW4PA_user', CAST(N'2025-07-07T09:50:21.267' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (116, 12, 10, CAST(N'2025-07-07T10:06:22.750' AS DateTime), 2, CAST(N'2025-07-07T10:06:16.657' AS DateTime), 2, CAST(N'2025-07-07T10:06:19.363' AS DateTime), 0.0000, 13.4550, CAST(N'2025-07-07T10:06:22.750' AS DateTime), 162.9550, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-07T09:59:22.683' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T10:06:22.763' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (117, 11, 10, CAST(N'2025-07-07T13:09:27.897' AS DateTime), 9, CAST(N'2025-07-07T13:09:17.997' AS DateTime), 2, CAST(N'2025-07-07T13:09:23.223' AS DateTime), 0.0000, 466.2000, CAST(N'2025-07-07T13:09:27.897' AS DateTime), 5646.2000, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-07T13:05:38.980' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T13:09:27.897' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (118, 12, 10, CAST(N'2025-07-07T15:52:48.220' AS DateTime), 2, CAST(N'2025-07-07T15:51:28.883' AS DateTime), 2, CAST(N'2025-07-07T15:51:49.073' AS DateTime), 0.0000, 243.0000, CAST(N'2025-07-07T15:52:48.220' AS DateTime), 2943.0000, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-07T15:50:08.760' AS DateTime), N'NW4PA_user', CAST(N'2025-07-07T15:52:48.220' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (120, 12, 10, CAST(N'2025-07-09T12:20:10.403' AS DateTime), 2, CAST(N'2025-07-09T12:19:56.550' AS DateTime), 2, CAST(N'2025-07-09T12:20:06.290' AS DateTime), 0.0000, 21.6000, CAST(N'2025-07-09T12:20:10.403' AS DateTime), 261.6000, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-09T12:18:46.293' AS DateTime), N'NW4PA_user', CAST(N'2025-07-09T12:20:10.407' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (121, 12, 10, CAST(N'2025-07-13T11:12:46.733' AS DateTime), NULL, NULL, 4, NULL, 0.0000, 0.0000, NULL, 0.0000, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-10T14:24:47.957' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T11:12:46.733' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (122, 12, 10, NULL, NULL, NULL, 3, NULL, 16.0000, 39.4200, NULL, 483.4200, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-10T14:24:51.297' AS DateTime), N'NW4PA_user', CAST(N'2025-07-22T14:17:16.313' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (123, 11, 10, CAST(N'2025-07-12T06:21:06.773' AS DateTime), 8, CAST(N'2025-07-12T06:20:59.280' AS DateTime), 2, CAST(N'2025-07-12T06:21:03.127' AS DateTime), 0.0000, 37.1250, CAST(N'2025-07-12T06:21:06.773' AS DateTime), 449.6250, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-10T14:26:17.983' AS DateTime), N'NW4PA_user', CAST(N'2025-07-12T06:21:06.777' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (124, 11, 10, CAST(N'2025-07-12T06:56:45.940' AS DateTime), 2, CAST(N'2025-07-12T06:56:39.520' AS DateTime), 2, CAST(N'2025-07-12T06:56:43.330' AS DateTime), 0.0000, 324.0000, CAST(N'2025-07-12T06:56:45.940' AS DateTime), 3924.0000, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-12T06:55:33.757' AS DateTime), N'NW4PA_user', CAST(N'2025-07-12T06:56:45.940' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (125, 12, 10, CAST(N'2025-07-13T11:09:37.647' AS DateTime), 2, CAST(N'2025-07-13T11:09:13.720' AS DateTime), 2, CAST(N'2025-07-13T11:09:24.960' AS DateTime), 0.0000, 62.0730, CAST(N'2025-07-13T11:09:37.647' AS DateTime), 751.7730, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-13T11:07:25.487' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T11:09:37.650' AS DateTime))
GO
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderID], [VendorID], [SubmittedByID], [SubmittedDate], [ApprovedByID], [ApprovedDate], [StatusID], [ReceivedDate], [ShippingFee], [TaxAmount], [PaymentDate], [PaymentAmount], [PaymentMethod], [Notes], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (126, 12, 10, CAST(N'2025-07-13T11:18:29.200' AS DateTime), 2, CAST(N'2025-07-13T11:17:12.150' AS DateTime), 2, CAST(N'2025-07-13T11:18:24.243' AS DateTime), 0.0000, 141.0750, CAST(N'2025-07-13T11:18:29.200' AS DateTime), 1708.5750, N'Cash', NULL, N'NW4PA_user', CAST(N'2025-07-13T11:15:27.077' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T11:18:29.200' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[PurchaseOrders] OFF
GO
SET IDENTITY_INSERT [dbo].[PurchaseOrderStatus] ON 
GO
INSERT [dbo].[PurchaseOrderStatus] ([StatusID], [StatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'Approved', 30, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderStatus] ([StatusID], [StatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'Closed', 50, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderStatus] ([StatusID], [StatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, N'New', 10, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderStatus] ([StatusID], [StatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (4, N'Submitted', 20, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderStatus] ([StatusID], [StatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (5, N'Received', 40, N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[PurchaseOrderStatus] ([StatusID], [StatusName], [SortOrder], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (6, N'Cancelled', 60, N'NW4PA_user', CAST(N'2025-03-15T08:24:57.000' AS DateTime), N'NW4PA_user', CAST(N'2025-03-15T08:25:17.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[PurchaseOrderStatus] OFF
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (-100, N'Nothing to update or delete in {0}.', N'NW4PA_user', CAST(N'2025-07-26T05:12:46.390' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (-1, N'Invalid Input in {0}: Custom Error Code not found.', N'NW4PA_user', CAST(N'2025-06-26T05:52:19.250' AS DateTime), N'NW4PA_user', CAST(N'2025-07-03T11:50:46.997' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (0, N'Success: {0}', N'NW4PA_user', CAST(N'2025-04-18T11:55:42.227' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T12:09:01.720' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (102, N'Invalid Syntax in {0}. Please contact the developer for support.', N'NW4PA_user', CAST(N'2025-04-29T13:55:24.287' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T12:09:40.050' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (105, N'Invalid Syntax in {0}. Please contact the developer for support.', N'NW4PA_user', CAST(N'2025-04-29T14:26:21.933' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T12:09:15.583' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (201, N'A Required Value was not supplied for {0}.', N'NW4PA_user', CAST(N'2025-04-20T07:33:48.223' AS DateTime), N'NW4PA_user', CAST(N'2025-04-20T07:36:17.847' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (241, N'Invalid Syntax  in  {0}. Please contact the developer for support.', N'NW4PA_user', CAST(N'2025-04-29T14:28:26.010' AS DateTime), N'NW4PA_user', CAST(N'2025-04-29T14:28:30.537' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (515, N'Can''t Insert Null in required field(s) in {0}.', N'NW4PA_user', CAST(N'2025-04-15T10:37:59.010' AS DateTime), N'NW4PA_user', CAST(N'2025-04-20T07:11:19.440' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (547, N'Can''t Add, Update or Delete {0};  Either related data exists in other tables, required data is missing from other tables, or invalid values were submitted for one or more fields.', N'NW4PA_user', CAST(N'2025-04-15T10:39:00.190' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T15:53:20.400' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (2601, N'Can''t insert Duplicate Value in  {0}.', N'NW4PA_user', CAST(N'2025-04-14T17:56:33.107' AS DateTime), N'NW4PA_user', CAST(N'2025-04-20T07:11:22.190' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (8143, N'Invalid Syntax  in  {0}. Please Contact the developer for support.', N'NW4PA_user', CAST(N'2025-04-26T14:09:28.310' AS DateTime), N'NW4PA_user', CAST(N'2025-04-26T14:11:58.680' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (8144, N'Invalid Syntax  in  {0}. Please contact the developer for support.', N'NW4PA_user', CAST(N'2025-04-20T10:02:55.193' AS DateTime), N'NW4PA_user', CAST(N'2025-04-26T14:12:03.523' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (8145, N'Invalid Request in {0}.', N'NW4PA_user', CAST(N'2025-04-26T13:38:02.447' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (50000, N'Invalid table name specified {0}.', N'NW4PA_user', CAST(N'2025-05-01T20:47:05.680' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51000, N'The order containing this product has been invoiced and can''t be deleted {0}.', N'NW4PA_user', CAST(N'2025-05-02T13:52:39.067' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51100, N'{0}  has already been received and can''t be deleted', N'NW4PA_user', CAST(N'2025-06-20T11:45:10.443' AS DateTime), N'NW4PA_user', CAST(N'2025-06-20T11:45:34.430' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51200, N'{0} cannot be approved, received, or paid before they been submitted', N'NW4PA_user', CAST(N'2025-05-04T10:37:37.600' AS DateTime), N'NW4PA_user', CAST(N'2025-05-09T15:27:40.473' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51210, N'{0} cannot be received or paid before they been approved', N'NW4PA_user', CAST(N'2025-05-04T10:21:30.603' AS DateTime), N'NW4PA_user', CAST(N'2025-05-09T15:27:45.440' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51220, N'The Submitted Date for a {0} must be the earliest date for the {0}.', N'NW4PA_user', CAST(N'2025-05-04T11:26:26.637' AS DateTime), N'NW4PA_user', CAST(N'2025-06-29T10:00:29.927' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51230, N'{0}s can''t be submitted without one or more {0} Details', N'NW4PA_user', CAST(N'2025-05-04T09:55:13.640' AS DateTime), N'NW4PA_user', CAST(N'2025-06-29T10:01:06.547' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51240, N'The Approved Date must be on before the Received Date for {0}s', N'NW4PA_user', CAST(N'2025-05-04T12:32:44.367' AS DateTime), N'NW4PA_user', CAST(N'2025-05-09T05:10:43.450' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51250, N'The Approved Date must be on before the Payment Date for {0}s', N'NW4PA_user', CAST(N'2025-05-04T12:33:43.397' AS DateTime), N'NW4PA_user', CAST(N'2025-05-09T05:10:46.397' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51260, N'{0}s can''t be submitted without a Shipping Fee', N'NW4PA_user', CAST(N'2025-05-04T10:04:06.467' AS DateTime), N'NW4PA_user', CAST(N'2025-05-09T05:11:04.553' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51290, N'{0}s cannot be submitted without a Vendor', N'NW4PA_user', CAST(N'2025-06-29T10:02:23.397' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51300, N'To submit a {0}, indicate who submitted it. ', N'NW4PA_user', CAST(N'2025-05-06T15:26:46.017' AS DateTime), N'NW4PA_user', CAST(N'2025-05-09T05:11:15.430' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51310, N'To approve a {0}, indicate who approved it.  ', N'NW4PA_user', CAST(N'2025-05-06T17:40:45.493' AS DateTime), N'NW4PA_user', CAST(N'2025-05-09T05:11:27.357' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51330, N'Customer is required for {0}.', N'NW4PA_user', CAST(N'2025-06-06T05:23:19.673' AS DateTime), N'NW4PA_user', CAST(N'2025-06-06T05:25:33.427' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51340, N'Employee is required for {0}.', N'NW4PA_user', CAST(N'2025-06-06T05:24:58.770' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (52210, N'{0} Random Error', N'NW4PA_user', CAST(N'2025-05-04T10:48:06.297' AS DateTime), N'NW4PA_user', CAST(N'2025-05-09T05:11:53.233' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (52290, N'Select in proper Order: Submit a new {0}.', N'NW4PA_user', CAST(N'2025-05-09T05:01:35.100' AS DateTime), N'NW4PA_user', CAST(N'2025-05-10T19:25:05.420' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (52291, N'Select in proper Order: Approve submitted {0}', N'NW4PA_user', CAST(N'2025-05-10T19:24:30.777' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (52292, N'Select in proper Order: Receive approved {0}.', N'NW4PA_user', CAST(N'2025-05-10T19:25:50.463' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (52293, N'Select in proper Order: Close received {0}.', N'NW4PA_user', CAST(N'2025-05-10T19:26:23.790' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (52310, N'To approve a {0}, indicate who approved it.', N'NW4PA_user', CAST(N'2025-05-06T15:25:40.603' AS DateTime), N'NW4PA_user', CAST(N'2025-05-09T05:12:10.867' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (52601, N'Can''t insert Duplicate Value in  {0}.', N'NW4PA_user', CAST(N'2025-04-14T17:56:33.107' AS DateTime), N'NW4PA_user', CAST(N'2025-04-20T07:11:22.190' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (53230, N'{0} can''t be invoiced without one or more order details.', N'NW4PA_user', CAST(N'2025-05-08T15:50:29.617' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T11:32:10.680' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (53240, N'{0} cannot be invoiced 
without all Order Details allocated', N'NW4PA_user', CAST(N'2025-05-28T13:57:05.900' AS DateTime), N'NW4PA_user', CAST(N'2025-07-13T16:36:07.580' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (53260, N'{0} can''t be invoiced without a Ship fee.', N'NW4PA_user', CAST(N'2025-05-28T10:52:09.687' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T12:09:55.787' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (53270, N'{0} can''t be invoiced without a Shipper.', N'NW4PA_user', CAST(N'2025-05-09T06:56:30.953' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T12:10:01.913' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (53280, N'Indicate the Payment Method for the {0} and try again.', N'NW4PA_user', CAST(N'2025-05-08T16:29:58.710' AS DateTime), N'NW4PA_user', CAST(N'2025-05-09T05:12:35.080' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (53290, N'Select in proper sequence: create invoice for a new {0}.', N'NW4PA_user', CAST(N'2025-05-08T17:21:27.193' AS DateTime), N'NW4PA_user', CAST(N'2025-05-10T18:47:36.620' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (53291, N'Select in proper sequence: ship {0} after invoice', N'NW4PA_user', CAST(N'2025-05-10T18:48:28.090' AS DateTime), N'NW4PA_user', CAST(N'2025-05-10T18:48:34.000' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (53292, N'Select in proper sequence: receive payment after shipping {0}', N'NW4PA_user', CAST(N'2025-05-10T18:49:08.730' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (53293, N'Select in proper sequence: close {0} after receiving payment', N'NW4PA_user', CAST(N'2025-05-10T18:49:43.880' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (54000, N'{0} First Name is required.', N'NW4PA_user', CAST(N'2025-06-11T14:11:17.210' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T14:12:32.867' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (54100, N'{0} Last Name is required.', N'NW4PA_user', CAST(N'2025-06-11T14:11:38.093' AS DateTime), N'NW4PA_user', CAST(N'2025-06-11T15:52:13.797' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (54200, N'{0} Title is required.', N'NW4PA_user', CAST(N'2025-06-11T14:12:28.570' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (55000, N'{0} must be assigned to an order.', N'NW4PA_user', CAST(N'2025-07-04T05:02:25.060' AS DateTime), N'NW4PA_user', CAST(N'2025-07-04T05:04:33.683' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (55100, N'{0} Product is required.', N'NW4PA_user', CAST(N'2025-07-04T05:04:28.223' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (55200, N'{0} Unit Price is required.', N'NW4PA_user', CAST(N'2025-07-04T05:04:58.310' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (55300, N'{0} Quantity is required.', N'NW4PA_user', CAST(N'2025-07-04T05:40:48.067' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (55547, N'That Product is in Stock and can''t be deleted for {0}.', N'NW4PA_user', CAST(N'2025-04-27T08:50:38.453' AS DateTime), N'NW4PA_user', CAST(N'2025-04-27T08:51:37.687' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (56547, N'That Product has been previously sold and can''t be deleted for {0}.', N'NW4PA_user', CAST(N'2025-05-02T14:28:54.930' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (58000, N'This {0} already includes the selected product. Select a different product or change the quantity.', N'NW4PA_user', CAST(N'2025-06-17T11:42:33.893' AS DateTime), N'NW4PA_user', CAST(N'2025-06-17T11:43:11.510' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (58010, N'{0} Name is required.', N'NW4PA_user', CAST(N'2025-06-20T06:46:58.740' AS DateTime), N'NW4PA_user', CAST(N'2025-06-20T10:50:05.947' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (58020, N'{0} Standard Unit Cost is required.', N'NW4PA_user', CAST(N'2025-06-20T10:41:30.180' AS DateTime), N'NW4PA_user', CAST(N'2025-06-20T10:50:08.333' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (58030, N'{0) Unit Price is required.', N'NW4PA_user', CAST(N'2025-06-20T10:42:33.827' AS DateTime), N'NW4PA_user', CAST(N'2025-06-20T10:50:10.463' AS DateTime))
GO
INSERT [dbo].[SSErrors] ([SSErrorID], [SSError], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (58040, N'{0} Category is required.', N'NW4PA_user', CAST(N'2025-06-20T10:44:44.753' AS DateTime), N'NW4PA_user', CAST(N'2025-06-20T10:50:13.233' AS DateTime))
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'AL', N'Alabama')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'AK', N'Alaska')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'AZ', N'Arizona')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'AR', N'Arkansas')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'CA', N'California')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'CO', N'Colorado')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'CT', N'Connecticut')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'DE', N'Delaware')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'DC', N'District of Columbia')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'FL', N'Florida')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'GA', N'Georgia')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'HI', N'Hawaii')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'ID', N'Idaho')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'IL', N'Illinois')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'IN', N'Indiana')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'IA', N'Iowa')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'KS', N'Kansas')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'KY', N'Kentucky')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'LA', N'Louisiana')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'ME', N'Maine')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'MD', N'Maryland')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'MA', N'Massachusetts')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'MI', N'Michigan')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'MN', N'Minnesota')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'MS', N'Mississippi')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'MO', N'Missouri')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'MT', N'Montana')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'NE', N'Nebraska')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'NV', N'Nevada')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'NH', N'New Hampshire')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'NJ', N'New Jersey')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'NM', N'New Mexico')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'NY', N'New York')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'NC', N'North Carolina')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'ND', N'North Dakota')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'OH', N'Ohio')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'OK', N'Oklahoma')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'OR', N'Oregon')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'PA', N'Pennsylvania')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'RI', N'Rhode Island')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'SC', N'South Carolina')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'SD', N'South Dakota')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'TN', N'Tennessee')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'TX', N'Texas')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'UT', N'Utah')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'VT', N'Vermont')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'VA', N'Virginia')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'WA', N'Washington')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'WV', N'West Virginia')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'WI', N'Wisconsin')
GO
INSERT [dbo].[States] ([StateAbbrev], [StateName]) VALUES (N'WY', N'Wyoming')
GO
SET IDENTITY_INSERT [dbo].[StockTake] ON 
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (688, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 1, 20, 20, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (689, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 2, 160, 160, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (690, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 3, 100, 100, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (691, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 4, 20, 20, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (692, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 5, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (693, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 6, 20, 20, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (695, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 8, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (696, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 9, 200, 200, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (697, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 10, 100, 100, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (698, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 11, 20, 20, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (699, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 12, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (700, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 13, 100, 100, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (701, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 14, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (702, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 15, 120, 120, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (703, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 16, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (704, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 17, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (705, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 18, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (706, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 19, 75, 75, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (707, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 20, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (708, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 21, 120, 120, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (709, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 22, 100, 100, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (710, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 23, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (711, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 24, 125, 125, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (712, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 25, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (713, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 26, 100, 100, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (714, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 27, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (715, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 28, 60, 60, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (716, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 29, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (717, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 30, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (718, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 31, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (719, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 32, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (720, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 33, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (721, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 34, 50, 50, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (723, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 36, 20, 20, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (724, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 37, 50, 50, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (725, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 38, 100, 100, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (726, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 39, 50, 50, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (727, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 40, 80, 80, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (728, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 41, 50, 50, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (729, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 42, 200, 200, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (730, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 43, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (731, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 44, 30, 30, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (732, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 47, 40, 40, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (733, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 49, 60, 60, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (734, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 56, 12, 12, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (735, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 59, 60, 60, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (736, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 60, 80, 80, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (737, CAST(N'2025-06-05T14:19:29.140' AS DateTime), 61, 60, 60, N'NW4PA_user', CAST(N'2025-06-05T11:32:33.467' AS DateTime), N'NW4PA_user', CAST(N'2025-06-05T14:19:29.170' AS DateTime))
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (747, CAST(N'2025-06-05T17:00:00.000' AS DateTime), 7, 38, 40, N'NW4PA_user', CAST(N'2025-06-05T16:49:43.480' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (761, CAST(N'2025-06-20T00:00:00.000' AS DateTime), 64, 0, 0, N'NW4PA_user', CAST(N'2025-06-20T11:02:52.307' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (764, CAST(N'2025-06-29T00:00:00.000' AS DateTime), 66, 0, 0, N'NW4PA_user', CAST(N'2025-06-29T11:01:52.230' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (768, CAST(N'2025-06-29T00:00:00.000' AS DateTime), 71, 0, 0, N'NW4PA_user', CAST(N'2025-06-29T11:26:14.220' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (773, CAST(N'2025-06-29T00:00:00.000' AS DateTime), 73, 0, 0, N'NW4PA_user', CAST(N'2025-06-29T12:23:23.300' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (816, CAST(N'2025-07-07T00:00:00.000' AS DateTime), 75, 0, 0, N'NW4PA_user', CAST(N'2025-07-07T11:49:41.557' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (821, CAST(N'2025-07-07T00:00:00.000' AS DateTime), 76, 0, 0, N'NW4PA_user', CAST(N'2025-07-07T12:30:53.013' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (823, CAST(N'2025-07-07T00:00:00.000' AS DateTime), 77, 0, 0, N'NW4PA_user', CAST(N'2025-07-07T12:43:31.033' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (826, CAST(N'2025-07-07T00:00:00.000' AS DateTime), 78, 0, 0, N'NW4PA_user', CAST(N'2025-07-07T12:49:21.087' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (845, CAST(N'2025-07-09T00:00:00.000' AS DateTime), 83, 0, 0, N'NW4PA_user', CAST(N'2025-07-09T12:17:13.460' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (873, CAST(N'2025-07-11T00:00:00.000' AS DateTime), 2, 230, 235, N'NW4PA_user', CAST(N'2025-07-13T10:24:21.083' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (882, CAST(N'2025-06-06T00:00:00.000' AS DateTime), 35, 80, 80, N'NW4PA_user', CAST(N'2025-07-13T13:04:30.050' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (883, CAST(N'2025-07-07T00:00:00.000' AS DateTime), 81, 50, 50, N'NW4PA_user', CAST(N'2025-07-13T16:06:15.070' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (890, CAST(N'2025-07-11T00:00:00.000' AS DateTime), 74, 20, 20, N'NW4PA_user', CAST(N'2025-07-14T13:38:50.443' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (892, CAST(N'2025-07-12T00:00:00.000' AS DateTime), 13, 34, 34, N'NW4PA_user', CAST(N'2025-07-14T15:52:57.987' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (895, CAST(N'2025-07-07T00:00:00.000' AS DateTime), 82, 90, 90, N'NW4PA_user', CAST(N'2025-07-15T06:28:19.670' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (896, CAST(N'2025-07-07T00:00:00.000' AS DateTime), 80, 60, 60, N'NW4PA_user', CAST(N'2025-07-15T06:48:40.770' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[StockTake] ([StockTakeID], [StockTakeDate], [ProductID], [QuantityOnHand], [ExpectedQuantity], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (898, CAST(N'2025-07-07T00:00:00.000' AS DateTime), 73, 90, 60, N'NW4PA_user', CAST(N'2025-07-15T06:53:38.803' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[StockTake] OFF
GO
SET IDENTITY_INSERT [dbo].[Strings] ON 
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'Hello {0}. This is {1}.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'Please enter a number between {0} and {1}.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (4, N'Only orders with status of Paid can be closed.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (5, N'OK to close this order?', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (6, N'An order can only be deleted before it is Shipped or Closed.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (7, N'Are you sure you want to permanently delete this {0}?', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (8, N'Record cannot be saved because not all required fields have been filled out. They are highlighted for your review.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (9, N'The order cannot be shipped until all Shipping related fields are filled out.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (10, N'Only orders with status of Invoiced can be shipped.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (11, N'There is no data for this report. Please try different criteria.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (12, N'{0} is not in the list of employees. If you want to add {0} as a supervisor, you must first add them as an employee.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (13, N'{0} {1} <br />
     {2}.<br /><br />', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (14, N'Confirm deletion of {0}.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (15, N'{0} is not a valid US phone number. Phone numbers must be formatted as either "(222) 333-444" or "555-6666"', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (16, N'The example companies, organizations, products, domain names, e-mail addresses, logos, people, places, and events depicted herein are fictitious.  No association with any real company, organization, product, domain name, email address, logo, person, places, or events is intended or should be inferred.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (17, N'The order cannot be invoiced until all line items have a status of Allocated. Allocation happens automatically when a PO is received with sufficient quantity.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (18, N'You are already on a new record.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (19, N'You don''t have the {0} privilege so you cannot perform this action. If you feel this is an error, discuss it with your supervisor. (TIP: login as Andrew Cencini, or give yourself rights in System Admin > Privileges)', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (20, N'The purchase order can only be submitted if it is in the New status.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (21, N'The purchase order can only be approved if it is in the Submitted status.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (22, N'Changing vendor will remove all purchase line items. OK to continue?', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (23, N'Has the entire purchase order been received, and are you ready to post to inventory? Orders waiting for these products will be updated.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (24, N'The purchase order can only be received if it is in the Approved status.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (25, N'The purchase order can only be closed if it is in the Received status.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (26, N'Shipping Fee and Payment Method are required before closing the purchase order.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (27, N'A purchase order can only be deleted when its Status is New or Submitted.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (28, N'This quantity is less than the Minimum Re-Order Quantity of {0}. That is not allowed.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (29, N'This quantity will result in an inventory level less than the Target Level of {0}. That is allowed but undesirable. Consider ordering at least {1} more.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (30, N'The new status has been set.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (32, N'Was the order paid today?', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (33, N'{0} ''{1}'' cannot be deleted because it has a related {2} record.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (34, N'An order must have at least one line item.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (35, N'You cannot change the Company Type if the Company has Orders/Purchase Orders.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (36, N'The order cannot be paid until all Payment related fields are filled out.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (37, N'You can''t {0} if the Company has<br />     Customer Orders ({1}) <br />     Shipper Orders ({2}) <br />     Vendor Purchase Orders ({3}) <br />     {4}  <br />', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (38, N'If you delete the Company any <br />     Contacts ({0}) <br />     and/or Vendor Products ({1}) will be deleted.<br /><br />    Is this OK?', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (39, N'This option is not available on a new order.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (40, N'If there are no recent orders, you may want to use Recent Dates on the System Admin form to move the dates of existing records forward.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (41, N'This Northwind Dev Edition template is brought to you by the "Northwind Working Group", a community team of volunteers who spent a year designing, implementing, documenting, and testing this application, and its companion Northwind Starter Edition.

The core working group members are Dawn Taylor, George Hepworth, George Young, Kim Young, and Tom van Stiphout. Michael Aldridge led the effort at Microsoft.

Many people contributed to the success of this project, including focus group members, alpha testers, former and current Access MVPs, videographers, help text editors, accessibility testers, intellectual property lawyers, and many others. It really takes a whole community.

Please share your feedback with the team. We will be watching the Access Tech Community forum, as well as other forums where Access developers hang out.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (42, N'The form {0} is already open. Please close the form before opening a new {0}.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (43, N'Tour the Gastronomic World with Northwind Traders!', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (44, N'When Northwind Traders buyers set out to search for the Wonders of the Gastronomic World they found a lot more than seven of them. And here they are--tastefully presented in our Fall Catalog.

The beverages and confections we''re featuring this fall are sure to please even the most discerning palates.

For thirst quenchers, try exotic chai, a hearty beer, or revitalizing coffee.

And for a taste of something sweet, try our brownie and cake mixes, or our rich, dark chocolate.

Our sales representatives are ready to take your orders now. For your convenience, we''ve included details on ordering on the last page of this catalog.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (45, N'Commitment to Quality', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (46, N'Northwind Traders is committed to bringing you products of the highest quality from all over the world. If at any time you are not completely satisfied with any of our products, you may return them to us for a full refund.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (47, N'How to order:
To place your order, fill out this order form and return it to us. For fast personal service,
call us at 1-206-555-1417. If you prefer to order by fax, prepare your order as you would
for a mail-in, and then fax us at 1-206-555-5938.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (48, N'You have changed the data and not saved it.  Do you want to save it now? Selecting No will undo your changes.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (49, N'Only orders with status of Shipped can be paid.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (50, N'Only orders with status of New can be invoiced.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Strings] ([StringID], [StringData], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (51, N'Please first complete the Order at the top of this form, before entering Order Line Items.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Strings] OFF
GO
SET IDENTITY_INSERT [dbo].[SystemSettings] ON 
GO
INSERT [dbo].[SystemSettings] ([SettingID], [SettingName], [SettingValue], [Notes]) VALUES (1, N'TaxRate', N'.085', N'[percent] Rate charged to taxable customers by Northwind Traders. Divide by 1000 to get Single value.')
GO
INSERT [dbo].[SystemSettings] ([SettingID], [SettingName], [SettingValue], [Notes]) VALUES (4, N'LastResetDate', N'2023-03-30', N'[date]')
GO
INSERT [dbo].[SystemSettings] ([SettingID], [SettingName], [SettingValue], [Notes]) VALUES (5, N'ShowWelcome', N'0', N'[boolean] Show the Welcome Screen')
GO
INSERT [dbo].[SystemSettings] ([SettingID], [SettingName], [SettingValue], [Notes]) VALUES (6, N'TaxRate_Vendors', N'.09', N'[percent] Rate paid by Northwind Traders to its vendors. Divide by 1000 to get Single value.')
GO
INSERT [dbo].[SystemSettings] ([SettingID], [SettingName], [SettingValue], [Notes]) VALUES (7, N'FirstTimeProcessingSuccess', N'-1', N'[boolean] Did we successfully complete first-time run functionality?')
GO
SET IDENTITY_INSERT [dbo].[SystemSettings] OFF
GO
INSERT [dbo].[TaxStatus] ([TaxStatusID], [TaxStatus], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (0, N'Tax Exempt', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[TaxStatus] ([TaxStatusID], [TaxStatus], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'Taxable', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Titles] ([Title], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (N'', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Titles] ([Title], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (N'Mr.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
INSERT [dbo].[Titles] ([Title], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (N'Mrs.', N'NW4PA_user', CAST(N'2025-03-15T08:38:51.000' AS DateTime), N'NW4PA_user', CAST(N'2025-03-15T08:45:11.000' AS DateTime))
GO
INSERT [dbo].[Titles] ([Title], [AddedBy], [AddedOn], [ModifiedBy], [ModifiedOn]) VALUES (N'Ms.', N'Admin', CAST(N'2024-09-21T00:00:00.000' AS DateTime), N'georg', CAST(N'2024-10-25T12:30:06.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[UserSettings] ON 
GO
INSERT [dbo].[UserSettings] ([SettingID], [SettingName], [SettingValue], [Notes]) VALUES (2, N'AutoLogin', N'-1', N'[boolean]')
GO
SET IDENTITY_INSERT [dbo].[UserSettings] OFF
GO
SET IDENTITY_INSERT [dbo].[USysRibbons] ON 
GO
INSERT [dbo].[USysRibbons] ([ID], [RibbonName], [RibbonXML]) VALUES (1, N'Main', N'<customUI xmlns="http://schemas.microsoft.com/office/2006/01/customui" onLoad="ribbonLoaded">
	<!-- Do not start from scratch; suppress built-ins instead. -->
	<ribbon startFromScratch="false">
		<tabs>
			<tab id="tHome" label="Home">
				<group id="gCurrentStatus" label="MRU">
					<box id="bxMRU" boxStyle="vertical">
						<dropDown id="ddMRU"
						          getItemCount="ddMRU_GetItemCount"
						          getItemLabel="ddMRU_GetItemLabel"
						          getSelectedItemIndex="ddMRU_GetSelectedItemIndex"
						          getItemID="ddMRU_GetItemID"
						          onAction="ddMRU_OnAction"
						          screentip="Most Recently Used Objects">
						</dropDown>
					</box>
				</group>
				<group id="gOrders" label="Orders">
					<button id="cmdOrders"
					        label="Orders"
					        size="large"
					        imageMso="CatalogMergeFindRecipient"
					        onAction="cmdOrders_OnAction"/>
					<button id="cmdAddOrder"
					        label="Add Order"
					        size="large"
					        imageMso="AdpNewTable"
					        onAction="cmdAddOrder_OnAction"/>
					<button id="cmdPurchaseOrders"
					        label="Purchase Orders"
					        size="large"
					        imageMso="WindowsCascade"
					        onAction="cmdPurchaseOrders_OnAction"/>
					<button id="cmdAddPurchaseOrder"
					        label="Add Purchase Order"
					        size="large"
					        imageMso="WindowNew"
					        onAction="cmdAddPurchaseOrder_OnAction"/>
				</group>
				<group id="gMaintenance" label="Maintenance">
					<button id="cmdCustomers"
					        label="Companies"
					        size="large"
					        imageMso="BusinessCardInsertMenu"
					        onAction="cmdCustomers_OnAction"/>
					<button id="cmdProducts"
					        label="Products"
					        size="large"
					        imageMso="MaterialResourceInsert"
					        onAction="cmdProducts_OnAction"/>
					<button id="cmdEmployees"
					        label="Employees"
					        size="large"
					        imageMso="MeetingsWorkspace"
					        onAction="cmdEmployees_OnAction"/>
					<button id="cmdAdmin"
					        label="System Admin"
					        size="large"
					        imageMso="ControlsGalleryClassic"
					        onAction="cmdAdmin_OnAction"/>
				</group>
				<group id="gReports" label="Reports" visible="true">
					<button id="cmdReports"
					        label="Reports"
					        size="large"
					        imageMso="ViewsReportView"
					        onAction="cmdReports_OnAction"/>
				</group>
				<group id="gExport" label="Export">
					<button id="cmdExportToExcel"
					        label="Export to Excel"
					        size="large"
					        imageMso="ExportExcel"
					        onAction="cmdExportToExcel_OnAction"/>
				</group>
				<group id="gReportOptions" label="Report Options" getVisible="gReportOptions_GetVisible">
					<button idMso="PrintDialogAccess" size="large"/>
					<button idMso="FilePrintQuick" size="large"/>
					<button idMso="FileSendAsAttachment" size="large"/>
					<button idMso="PublishToPdfOrEdoc" size="large"/>
					<button idMso="PrintPreviewClose" size="large"/>
				</group>
				<group id="gAbout" label="Help Topics">
					<button id="cmdLearn"
					        label="Learn"
					        size="large"
					        imageMso="WatchWindow"
					        onAction="cmdLearn_OnAction"/>
					<button id="cmdFeatures"
					        label="Northwind Features"
					        size="large"
					        imageMso="HelpDevResources"
					        onAction="cmdFeatures_OnAction"/>
					<button id="cmdNorthwindDocumentation"
					        label="Northwind Documentation"
					        size="large"
					        imageMso="HelpDevResources"
					        onAction="cmdNorthwindDocumentation_OnAction"/>
					<button id="cmdAbout"
					        label="About Northwind"
					        size="large"
					        imageMso="GroupAuthors"
					        onAction="cmdAbout_OnAction"/>
				</group>
				<group id="gExit" label="Exit Application">
					<button id="cmdExitApplication"
					        imageMso="PrintPreviewClose"
					        size="large"
					        label="Exit"
					        onAction="cmdExitApplication_OnAction"/>
				</group>
			</tab>

			<!-- Built-in tabs -->
			<tab idMso="TabPrintPreviewAccess" label="Original Print Preview" visible="false"/>
			<tab idMso="TabHomeAccess" label="Original Home" visible="false"/>
			<tab idMso="TabCreate" label="Original Create" visible="false"/>
			<tab idMso="TabExternalData" label="Original External Data" visible="false"/>
			<tab idMso="TabDatabaseTools" label="Original Database Tools" visible="false"/>
			<!-- Rarely use Source Control, not worth customizing -->
			<tab idMso="TabSourceControl" label="Original Source Control" visible="false"/>
			<!-- Normally this may be desirable to disable AddIns tab but to avoid confusion I''m leaving this alone for now. -->
			<tab idMso="TabAddIns" label="AddIns" visible="true"/>
			<!-- Custom tabs -->
			<tab id="DevelopTab" label="Develop">
				<group id="ViewGroup" label="View or Run">
					<splitButton idMso="ViewsModeMenu" size="large">
					</splitButton>
					<button idMso="QueryRunQuery" size="large"/>
				</group>
				<group id="EditGroup" label="Edit">
					<box id="EditBox1" boxStyle="horizontal">
						<button idMso="Cut"/>
						<button idMso="Copy"/>
						<splitButton id="PasteIt">
							<button idMso="Paste"/>
							<menu id="PasteMenu">
								<button idMso="Paste"/>
								<button idMso="PasteSpecialDialog"/>
								<button idMso="PasteAppend"/>
							</menu>
						</splitButton>
					</box>
					<box id="EditBox2" boxStyle="horizontal">
						<gallery idMso="Undo"/>
						<gallery idMso="Redo"/>
					</box>
					<box id="EditBox3" boxStyle="horizontal">
						<comboBox idMso="FormattingFormat"/>
						<control idMso="FormatPainter" label="Paint"/>
					</box>
				</group>
				<group id="TableGroup" label="Tables and Relationship">
					<splitButton id="CreateTableSplitButton" size="large">
						<button idMso="CreateTableInDesignView"/>
						<menu id="CreateTableMenu">
							<button idMso="CreateTableInDesignView"/>
							<button idMso="CreateTable"/>
							<gallery idMso="CreateTableTemplatesGallery"/>
							<gallery idMso="CreateTableUsingSharePointListsGallery"/>
						</menu>
					</splitButton>
					<splitButton id="DatabaseRelationshipsSplitButton" size="large">
						<button idMso="DatabaseRelationships"/>
						<menu id="RelationshipsMenu">
							<button idMso="DatabaseRelationships"/>
							<toggleButton idMso="DatabaseObjectDependencies"/>
						</menu>
					</splitButton>
				</group>
				<group id="ExternalDataGroup" label="External Data">
					<menu id="ImportMenu" label="Import or Link" imageMso="ImportMoreMenu" size="large">
						<menuSeparator id="ImportLink" title="Link tables"/>
						<button idMso="FileServerLinkTables"/>
						<menuSeparator id="ImportMicrosoft" title="Import from Office"/>
						<button idMso="ImportAccess"/>
						<button idMso="ImportExcel"/>
						<button idMso="ImportOutlook"/>
						<button idMso="ImportSharePointList"/>
						<menuSeparator id="ImportOdbc" title="Import from ODBC"/>
						<button idMso="ImportOdbcDatabase"/>
						<menuSeparator id="ImportFlatFile" title="Import from flat files"/>
						<button idMso="ImportTextFile"/>
						<button idMso="ImportHtmlDocument"/>
						<button idMso="ImportXmlFile"/>
						<button idMso="ImportSavedImports"/>
						<menuSeparator id="ImportISAM" title="Import from ISAM"/>
						<button idMso="ImportDBase"/>
						<button idMso="ImportParadox"/>
						<button idMso="ImportLotus"/>
					</menu>
					<menu id="ExportMenu" label="Export" imageMso="ExportMoreMenu" size="large">
						<menuSeparator id="ExportMicrosoft" title="Export to Office"/>
						<button idMso="ExportAccess"/>
						<button idMso="ExportExcel"/>
						<button idMso="ExportWord"/>
						<button idMso="ExportSharePointList"/>
						<menuSeparator id="ExportOdbc" title="Export to ODBC"/>
						<button idMso="ExportOdbcDatabase"/>
						<menuSeparator id="ExportFlatFiles" title="Export to flat files"/>
						<button idMso="ExportTextFile"/>
						<button idMso="ExportHtmlDocument"/>
						<button idMso="ExportXmlFile"/>
						<button idMso="ExportSavedExports"/>
						<menuSeparator id="ExportISAM" title="Export to ISAM"/>
						<button idMso="ExportDBase"/>
						<button idMso="ExportParadox"/>
						<button idMso="ExportLotus"/>
						<menuSeparator id="ExportSnapshot" title="Export as PDF"/>
						<!-- <button idMso="ExportSnapshot" /> -->
						<button idMso="PublishToPdfOrEdoc"/>
					</menu>
					<splitButton id="LinkedTableSplitButton" size="large">
						<button idMso="DatabaseLinedTableManager"/>
						<menu id="LinkedTableMenu">
							<button idMso="DatabaseLinedTableManager"/>
							<button idMso="DatabaseAccessBackEnd" label="Split Database"/>
						</menu>
					</splitButton>
				</group>
				<group id="ObjectGroup" label="Create Objects">
					<splitButton id="QuerySplitButton" size="large">
						<button idMso="CreateQueryInDesignView"/>
						<menu id="QueryMenu">
							<button idMso="CreateQueryInDesignView"/>
							<button idMso="CreateQueryFromWizard"/>
						</menu>
					</splitButton>
					<splitButton id="FormSplitButton" size="large">
						<button idMso="CreateFormInDesignView"/>
						<menu id="FormMenu">
							<button idMso="CreateFormInDesignView"/>
							<button idMso="CreateFormBlankForm"/>
							<button idMso="CreateForm"/>
							<button idMso="CreateFormSplitForm"/>
							<button idMso="CreateFormWithMultipleItems"/>
							<menuSeparator id="SwitchBoardSeparator" title="Switchboard"/>
							<button idMso="DatabaseSwitchboardManager"/>
							<button idMso="BusinessFormWizard"/>
						</menu>
					</splitButton>
					<splitButton id="ReportSplitButton" size="large">
						<button idMso="CreateReportInDesignView"/>
						<menu id="ReportMenu">
							<button idMso="CreateReportInDesignView"/>
							<button idMso="CreateReportBlankReport"/>
							<button idMso="CreateReport"/>
							<button idMso="CreateLabels"/>
							<button idMso="CreateReportFromWizard"/>
						</menu>
					</splitButton>
					<splitButton id="MacroSplitButton" size="large">
						<button idMso="CreateMacro"/>
						<menu id="MacroMenu">
							<button idMso="CreateMacro"/>
							<button idMso="CreateShortcutMenuFromMacro"/>
						</menu>
					</splitButton>
					<splitButton id="VBASplitButton" size="large">
						<button idMso="VisualBasic"/>
						<menu id="VBAMenu">
							<button idMso="VisualBasic"/>
							<button idMso="CreateModule"/>
							<button idMso="CreateClassModule"/>
							<menuSeparator id="ConvertMacroSeparator" title="Convert Macros to VBA"/>
							<button idMso="MacroConvertMacrosToVisualBasic"/>
						</menu>
					</splitButton>
				</group>
				<group id="AdministerGroup" label="Administer">
					<splitButton id="AdministerSplitButton" size="large">
						<button idMso="FileCompactAndRepairDatabase" label="Compact and Repair"/>
						<menu id="AdministerMenu">
							<button idMso="FileCompactAndRepairDatabase"/>
							<button idMso="FileBackupDatabase"/>
							<button idMso="DatabaseCopyDatabaseFile"/>
							<menuSeparator id="ConvertFileSeparator" title="Convert to different version"/>
							<button idMso="FileSaveAsAccess2007"/>
							<button idMso="FileSaveAsAccess2002_2003"/>
							<button idMso="FileSaveAsAccess2000"/>
							<menuSeparator id="SecuritySeparator" title="Secure the file"/>
							<button idMso="SetDatabasePassword"/>
							<button idMso="DatabaseMakeMdeFile"/>
							<button idMso="FilePackageAndSign"/>
							<menuSeparator id="AnalyzeSeparator" title="Analyze/Document"/>
							<button idMso="DatabaseAnalyzeTable"/>
							<button idMso="DatabaseAnalyzePerformance"/>
							<button idMso="DatabaseDocumenter"/>
							<menuSeparator id="CustomizeSeparator" title="Customize"/>
							<button idMso="QuickAccessToolbarCustomization"/>
							<menu idMso="AddInsMenu"/>
							<button idMso="ComAddInsDialog"/>
						</menu>
					</splitButton>
					<button idMso="ApplicationOptionsDialog" size="large"/>
				</group>
				<group id="HelpGroup" label="Help">
					<button idMso="Help" size="large" label="Help"/>
				</group>
			</tab>
		</tabs>
		<contextualTabs>
			<!-- Built-in contextual tabs will be used -->
			<!-- To suppress the built-in tabs, change visible to false, rename the label to "Original <whatever>" then add new tab with a new id, same label -->
			<!-- The ordering of tabSets are roughly Tables, Queries, Forms, Reports, Macros -->
			<tabSet idMso="TabSetTableToolsDesign">
				<tab idMso="TabTableToolsDesignAccess" label="Design" visible="true"/>
			</tabSet>
			<tabSet idMso="TabSetTableToolsDatasheet">
				<tab idMso="TabTableToolsDatasheet" label="Datasheet" visible="true"/>
			</tabSet>
			<tabSet idMso="TabSetRelationshipTools">
				<tab idMso="TabRelationshipToolsDesign" label="Design" visible="true"/>
			</tabSet>
			<tabSet idMso="TabSetQueryTools">
				<tab idMso="TabQueryToolsDesign" label="Design" visible="true"/>
			</tabSet>
			<tabSet idMso="TabSetFormTools">
				<tab idMso="TabFormToolsDesign" label="Design" visible="true"/>
				<tab idMso="TabFormToolsLayout" label="Arrange" visible="true"/>
			</tabSet>
			<tabSet idMso="TabSetFormToolsLayout">
				<tab idMso="TabFormToolsFormatting" label="Format" visible="true"/>
				<tab idMso="TabControlLayout" label="Arrange" visible="true"/>
			</tabSet>
			<tabSet idMso="TabSetReportTools">
				<tab idMso="TabReportToolsDesign" label="Design" visible="true"/>
				<tab idMso="TabReportToolsAlignment" label="Arrange" visible="true"/>
				<tab idMso="TabReportToolsPageSetupDesign" label="Page Setup" visible="true"/>
			</tabSet>
			<tabSet idMso="TabSetReportToolsLayout">
				<tab idMso="TabReportToolsFormatting" label="Format" visible="true"/>
				<tab idMso="TabReportToolsLayout" label="Layout" visible="true"/>
				<tab idMso="TabReportToolsPageSetupLayout" label="Page Setup" visible="true"/>
			</tabSet>
			<tabSet idMso="TabSetMacroTools">
				<tab idMso="TabMacroToolsDesign" label="Design" visible="true"/>
			</tabSet>
		</contextualTabs>
	</ribbon>
</customUI>')
GO
SET IDENTITY_INSERT [dbo].[USysRibbons] OFF
GO
SET IDENTITY_INSERT [dbo].[Welcome] ON 
GO
INSERT [dbo].[Welcome] ([ID], [Welcome], [Learn], [DataMacro]) VALUES (1, N'<div>The <i>Northwind Developer Edition Template</i> showcases major Access features.</div>

<div>&nbsp;</div>

<div>Northwind is a fictitious Trading Company whose customers are independent grocery stores. </div>

<div>Customers call in orders or place them over the internet. </div>

<div>Northwind invoices, ships, collects payments, and closes orders. </div>

<div>Sample data in this template will get you started quickly.</div>

<div>&nbsp;</div>', N'https://support.office.com/f1/topic/a685f382-e246-4f55-888f-52e4766868f8', N'<?xml version="1.0" encoding="UTF-16" standalone="no"?>
<DataMacros xmlns="http://schemas.microsoft.com/office/accessservices/2009/11/application"><DataMacro Event="BeforeChange"><Statements>
<Comment>Upate the Audit Fields for an Insert (AddedBy AddedOn) or and Update (ModifiedBy ModifiedOn)</Comment>
<ConditionalBlock>
<If><Condition>[IsInsert]</Condition>
<Statements>
<Action Name="SetField"><Argument Name="Field">AddedBy</Argument><Argument Name="Value">GetAuditFieldsUserName()</Argument></Action>
<Action Name="SetField"><Argument Name="Field">AddedOn</Argument><Argument Name="Value">Now()</Argument></Action>
<Action Name="SetField"><Argument Name="Field">ModifiedBy</Argument><Argument Name="Value">GetAuditFieldsUserName()</Argument></Action>
<Action Name="SetField"><Argument Name="Field">ModifiedOn</Argument><Argument Name="Value">Now()</Argument></Action>
</Statements>
</If>
<Else>
<Statements>
<Comment>This is an update</Comment>
<Action Name="SetField"><Argument Name="Field">ModifiedBy</Argument><Argument Name="Value">GetAuditFieldsUserName()</Argument></Action>
<Action Name="SetField"><Argument Name="Field">ModifiedOn</Argument><Argument Name="Value">Now()</Argument></Action>
<Comment>We only set the Added audit values once when the record is added.  If the user has deleted the AddedBy or AddedOn values we want to put them back  </Comment>
<ConditionalBlock>
<If>
<Condition>[Old].[AddedBy]&lt;&gt;[AddedBy]</Condition>
<Statements><Action Name="SetField"><Argument Name="Field">AddedBy</Argument><Argument Name="Value">[Old].[AddedBy]</Argument>
</Action>
</Statements>
</If>
<Else><Statements>
<ConditionalBlock>
<If><Condition>IsNull([AddedBy])</Condition><Statements>
<Action Name="SetField"><Argument Name="Field">AddedBy</Argument><Argument Name="Value">[Old].[AddedBy]</Argument></Action>
</Statements></If></ConditionalBlock></Statements></Else></ConditionalBlock>
<ConditionalBlock>
<If><Condition>IsNull([AddedOn])</Condition>
<Statements><Action Name="SetField"><Argument Name="Field">AddedOn</Argument><Argument Name="Value">[Old].[AddedOn]</Argument></Action>
</Statements></If>
<Else><Statements><ConditionalBlock><If><Condition>[Old].[AddedOn]&lt;&gt;[AddedOn]</Condition><Statements><Action Name="SetField"><Argument Name="Field">AddedOn</Argument><Argument Name="Value">[Old].[AddedOn]</Argument></Action>
</Statements></If></ConditionalBlock></Statements></Else></ConditionalBlock></Statements></Else></ConditionalBlock></Statements>
</DataMacro></DataMacros>')
GO
SET IDENTITY_INSERT [dbo].[Welcome] OFF
GO
/****** Object:  Index [Catalog_TableOfContents$TocPage]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [Catalog_TableOfContents$TocPage] ON [dbo].[Catalog_TableOfContents]
(
	[TocPage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Companies$CompanyTypesCompanies]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [Companies$CompanyTypesCompanies] ON [dbo].[Companies]
(
	[CompanyTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Companies$CustomerName]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Companies$CustomerName] ON [dbo].[Companies]
(
	[CompanyName] ASC,
	[CompanyTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Companies$StatesCompanies]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [Companies$StatesCompanies] ON [dbo].[Companies]
(
	[StateAbbrev] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Companies$TaxStatusCompanies]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [Companies$TaxStatusCompanies] ON [dbo].[Companies]
(
	[StandardTaxStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CompanyTypes$CompanyType]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [CompanyTypes$CompanyType] ON [dbo].[CompanyTypes]
(
	[CompanyType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Contacts$CompaniesContacts]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [Contacts$CompaniesContacts] ON [dbo].[Contacts]
(
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Contacts$uidxCompanyFNLN]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Contacts$uidxCompanyFNLN] ON [dbo].[Contacts]
(
	[CompanyID] ASC,
	[FirstName] ASC,
	[LastName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Contacts$uidxCompanyLNFN]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Contacts$uidxCompanyLNFN] ON [dbo].[Contacts]
(
	[CompanyID] ASC,
	[LastName] ASC,
	[FirstName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [EmployeePrivileges$EmployeesEmployeePrivileges]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [EmployeePrivileges$EmployeesEmployeePrivileges] ON [dbo].[EmployeePrivileges]
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [EmployeePrivileges$PrivilegeID]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [EmployeePrivileges$PrivilegeID] ON [dbo].[EmployeePrivileges]
(
	[PrivilegeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [EmployeePrivileges$PrivilegesEmployeePrivileges]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [EmployeePrivileges$PrivilegesEmployeePrivileges] ON [dbo].[EmployeePrivileges]
(
	[PrivilegeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [EmployeePrivileges$UniqueIdx]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [EmployeePrivileges$UniqueIdx] ON [dbo].[EmployeePrivileges]
(
	[EmployeePrivilegeID] ASC,
	[PrivilegeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Employees$EmployeesEmployees]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [Employees$EmployeesEmployees] ON [dbo].[Employees]
(
	[SupervisorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Employees$SalutationsEmployees]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [Employees$SalutationsEmployees] ON [dbo].[Employees]
(
	[Title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Employees$uidxFNLN]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Employees$uidxFNLN] ON [dbo].[Employees]
(
	[FirstName] ASC,
	[LastName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Employees$uidxLNFN]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Employees$uidxLNFN] ON [dbo].[Employees]
(
	[LastName] ASC,
	[FirstName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Employees$WindowsUserName]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [Employees$WindowsUserName] ON [dbo].[Employees]
(
	[WindowsUserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Learn$SectionNo]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Learn$SectionNo] ON [dbo].[Learn]
(
	[SectionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [MRU$EmployeesMRU]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [MRU$EmployeesMRU] ON [dbo].[MRU]
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [MRU$SortIdx]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [MRU$SortIdx] ON [dbo].[MRU]
(
	[EmployeeID] ASC,
	[DateAdded] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [MRU$UniqueIdx]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [MRU$UniqueIdx] ON [dbo].[MRU]
(
	[EmployeeID] ASC,
	[TableName] ASC,
	[PKValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [OrderDetails$OrderDetailsStatusOrderDetails]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [OrderDetails$OrderDetailsStatusOrderDetails] ON [dbo].[OrderDetails]
(
	[OrderDetailStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [OrderDetails$OrdersOrderDetails]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [OrderDetails$OrdersOrderDetails] ON [dbo].[OrderDetails]
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [OrderDetails$ProductID]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [OrderDetails$ProductID] ON [dbo].[OrderDetails]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [OrderDetails$ProductsOrderDetails]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [OrderDetails$ProductsOrderDetails] ON [dbo].[OrderDetails]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [OrderDetails$StatusID]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [OrderDetails$StatusID] ON [dbo].[OrderDetails]
(
	[OrderDetailStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [OrderDetails$uidxOrderID_ProductID]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [OrderDetails$uidxOrderID_ProductID] ON [dbo].[OrderDetails]
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [OrderDetailStatus$SortOrder]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [OrderDetailStatus$SortOrder] ON [dbo].[OrderDetailStatus]
(
	[SortOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [OrderDetailStatus$StatusName]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [OrderDetailStatus$StatusName] ON [dbo].[OrderDetailStatus]
(
	[OrderDetailStatusName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Orders$CompaniesOrders]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [Orders$CompaniesOrders] ON [dbo].[Orders]
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Orders$CompaniesOrders1]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [Orders$CompaniesOrders1] ON [dbo].[Orders]
(
	[ShipperID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Orders$EmployeesOrders]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [Orders$EmployeesOrders] ON [dbo].[Orders]
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Orders$OrderDate]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [Orders$OrderDate] ON [dbo].[Orders]
(
	[OrderDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Orders$OrdersStatusOrders]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [Orders$OrdersStatusOrders] ON [dbo].[Orders]
(
	[OrderStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Orders$TaxStatusOrders]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [Orders$TaxStatusOrders] ON [dbo].[Orders]
(
	[TaxStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [OrderStatus$SortOrder]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [OrderStatus$SortOrder] ON [dbo].[OrderStatus]
(
	[SortOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [OrderStatus$StatusCode]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [OrderStatus$StatusCode] ON [dbo].[OrderStatus]
(
	[OrderStatusCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [OrderStatus$StatusName]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [OrderStatus$StatusName] ON [dbo].[OrderStatus]
(
	[OrderStatusName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Privileges$PrivilegeName]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Privileges$PrivilegeName] ON [dbo].[Privileges]
(
	[PrivilegeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ProductCategories$ProductCategory]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [ProductCategories$ProductCategory] ON [dbo].[ProductCategories]
(
	[ProductCategoryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ProductCategories$ProductCategoryCode]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [ProductCategories$ProductCategoryCode] ON [dbo].[ProductCategories]
(
	[ProductCategoryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Products$ProductCategories_NEWProducts]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [Products$ProductCategories_NEWProducts] ON [dbo].[Products]
(
	[ProductCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Products$ProductCode]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Products$ProductCode] ON [dbo].[Products]
(
	[ProductCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Products$ProductName]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Products$ProductName] ON [dbo].[Products]
(
	[ProductName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ProductVendors$CompaniesProductVendors]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [ProductVendors$CompaniesProductVendors] ON [dbo].[ProductVendors]
(
	[VendorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ProductVendors$ProductsProductVendors]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [ProductVendors$ProductsProductVendors] ON [dbo].[ProductVendors]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ProductVendors$UniqueIdx]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [ProductVendors$UniqueIdx] ON [dbo].[ProductVendors]
(
	[ProductID] ASC,
	[VendorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ProductVendors$VendorID]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [ProductVendors$VendorID] ON [dbo].[ProductVendors]
(
	[VendorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PurchaseOrderDetails$ProductsPurchaseOrderDetails]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [PurchaseOrderDetails$ProductsPurchaseOrderDetails] ON [dbo].[PurchaseOrderDetails]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PurchaseOrderDetails$PurchaseOrdersPurchaseOrderDetails]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [PurchaseOrderDetails$PurchaseOrdersPurchaseOrderDetails] ON [dbo].[PurchaseOrderDetails]
(
	[PurchaseOrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PurchaseOrderDetails$uidxPurchaseOrderID_ProductID]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [PurchaseOrderDetails$uidxPurchaseOrderID_ProductID] ON [dbo].[PurchaseOrderDetails]
(
	[PurchaseOrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PurchaseOrders$CompaniesPurchaseOrders]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [PurchaseOrders$CompaniesPurchaseOrders] ON [dbo].[PurchaseOrders]
(
	[VendorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PurchaseOrders$EmployeesPurchaseOrders1]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [PurchaseOrders$EmployeesPurchaseOrders1] ON [dbo].[PurchaseOrders]
(
	[ApprovedByID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PurchaseOrders$EmployeesPurchaseOrders2]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [PurchaseOrders$EmployeesPurchaseOrders2] ON [dbo].[PurchaseOrders]
(
	[SubmittedByID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PurchaseOrders$PurchaseOrdersStatusPurchaseOrders]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [PurchaseOrders$PurchaseOrdersStatusPurchaseOrders] ON [dbo].[PurchaseOrders]
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PurchaseOrders$StatusCode]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [PurchaseOrders$StatusCode] ON [dbo].[PurchaseOrders]
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PurchaseOrders$SubmittedDate]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [PurchaseOrders$SubmittedDate] ON [dbo].[PurchaseOrders]
(
	[SubmittedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PurchaseOrderStatus$SortOrder]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [PurchaseOrderStatus$SortOrder] ON [dbo].[PurchaseOrderStatus]
(
	[SortOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [PurchaseOrderStatus$StatusName]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [PurchaseOrderStatus$StatusName] ON [dbo].[PurchaseOrderStatus]
(
	[StatusName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [States$StateName]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [States$StateName] ON [dbo].[States]
(
	[StateName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [StockTake$ProductsStockTake]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE NONCLUSTERED INDEX [StockTake$ProductsStockTake] ON [dbo].[StockTake]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [SystemSettings$SettingName]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [SystemSettings$SettingName] ON [dbo].[SystemSettings]
(
	[SettingName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [TaxStatus$TaxStatus]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [TaxStatus$TaxStatus] ON [dbo].[TaxStatus]
(
	[TaxStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserSettings$SettingName]    Script Date: 7/26/2025 5:33:40 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserSettings$SettingName] ON [dbo].[UserSettings]
(
	[SettingName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Companies] ADD  CONSTRAINT [DF__Companies__Stand__59C55456]  DEFAULT ((0)) FOR [StandardTaxStatusID]
GO
ALTER TABLE [dbo].[OrderDetails] ADD  CONSTRAINT [DF__OrderDeta__Disco__5AB9788F]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF__Orders__OrderDat__5BAD9CC8]  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF__Products__Reorde__5CA1C101]  DEFAULT ((0)) FOR [ReorderLevel]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF__Products__Discon__5D95E53A]  DEFAULT ((0)) FOR [Discontinued]
GO
ALTER TABLE [dbo].[Companies]  WITH NOCHECK ADD  CONSTRAINT [Companies$New_CompanyTypesCompanies] FOREIGN KEY([CompanyTypeID])
REFERENCES [dbo].[CompanyTypes] ([CompanyTypeID])
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [Companies$New_CompanyTypesCompanies]
GO
ALTER TABLE [dbo].[Companies]  WITH NOCHECK ADD  CONSTRAINT [Companies$New_StatesCompanies] FOREIGN KEY([StateAbbrev])
REFERENCES [dbo].[States] ([StateAbbrev])
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [Companies$New_StatesCompanies]
GO
ALTER TABLE [dbo].[Companies]  WITH NOCHECK ADD  CONSTRAINT [Companies$New_TaxStatusCompanies] FOREIGN KEY([StandardTaxStatusID])
REFERENCES [dbo].[TaxStatus] ([TaxStatusID])
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [Companies$New_TaxStatusCompanies]
GO
ALTER TABLE [dbo].[Contacts]  WITH NOCHECK ADD  CONSTRAINT [Contacts$New_CompaniesContacts] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[Companies] ([CompanyID])
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [Contacts$New_CompaniesContacts]
GO
ALTER TABLE [dbo].[EmployeePrivileges]  WITH NOCHECK ADD  CONSTRAINT [EmployeePrivileges$New_PrivilegesEmployeePrivileges] FOREIGN KEY([PrivilegeID])
REFERENCES [dbo].[Privileges] ([PrivilegeID])
GO
ALTER TABLE [dbo].[EmployeePrivileges] CHECK CONSTRAINT [EmployeePrivileges$New_PrivilegesEmployeePrivileges]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [Employees$New_EmployeesEmployees] FOREIGN KEY([SupervisorID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [Employees$New_EmployeesEmployees]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [Employees$New_SalutationsEmployees] FOREIGN KEY([Title])
REFERENCES [dbo].[Titles] ([Title])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [Employees$New_SalutationsEmployees]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Employees]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH NOCHECK ADD  CONSTRAINT [OrderDetails$New_OrderDetailsStatusOrderDetails] FOREIGN KEY([OrderDetailStatusID])
REFERENCES [dbo].[OrderDetailStatus] ([OrderDetailStatusID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [OrderDetails$New_OrderDetailsStatusOrderDetails]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH NOCHECK ADD  CONSTRAINT [OrderDetails$New_OrdersOrderDetails] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [OrderDetails$New_OrdersOrderDetails]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH NOCHECK ADD  CONSTRAINT [OrderDetails$New_ProductsOrderDetails] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [OrderDetails$New_ProductsOrderDetails]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [Orders$New_CompaniesOrders] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Companies] ([CompanyID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Orders$New_CompaniesOrders]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [Orders$New_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Orders$New_Employees]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [Orders$New_OrdersStatusOrders] FOREIGN KEY([OrderStatusID])
REFERENCES [dbo].[OrderStatus] ([OrderStatusID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Orders$New_OrdersStatusOrders]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [Orders$New_Shippers] FOREIGN KEY([ShipperID])
REFERENCES [dbo].[Companies] ([CompanyID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Orders$New_Shippers]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [Orders$New_TaxStatusOrders] FOREIGN KEY([TaxStatusID])
REFERENCES [dbo].[TaxStatus] ([TaxStatusID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [Orders$New_TaxStatusOrders]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [Products$New_ProductCategories_NEWProducts] FOREIGN KEY([ProductCategoryID])
REFERENCES [dbo].[ProductCategories] ([ProductCategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [Products$New_ProductCategories_NEWProducts]
GO
ALTER TABLE [dbo].[ProductVendors]  WITH NOCHECK ADD  CONSTRAINT [fkProductVendors_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductVendors] CHECK CONSTRAINT [fkProductVendors_Product]
GO
ALTER TABLE [dbo].[ProductVendors]  WITH NOCHECK ADD  CONSTRAINT [fkProductVendors_VendorID] FOREIGN KEY([VendorID])
REFERENCES [dbo].[Companies] ([CompanyID])
GO
ALTER TABLE [dbo].[ProductVendors] CHECK CONSTRAINT [fkProductVendors_VendorID]
GO
ALTER TABLE [dbo].[PurchaseOrderDetails]  WITH NOCHECK ADD  CONSTRAINT [PurchaseOrderDetails$New_ProductsPurchaseOrderDetails] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[PurchaseOrderDetails] CHECK CONSTRAINT [PurchaseOrderDetails$New_ProductsPurchaseOrderDetails]
GO
ALTER TABLE [dbo].[PurchaseOrderDetails]  WITH NOCHECK ADD  CONSTRAINT [PurchaseOrderDetails$New_PurchaseOrdersPurchaseOrderDetails] FOREIGN KEY([PurchaseOrderID])
REFERENCES [dbo].[PurchaseOrders] ([PurchaseOrderID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PurchaseOrderDetails] CHECK CONSTRAINT [PurchaseOrderDetails$New_PurchaseOrdersPurchaseOrderDetails]
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrders_ApprovedBy] FOREIGN KEY([ApprovedByID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[PurchaseOrders] CHECK CONSTRAINT [FK_PurchaseOrders_ApprovedBy]
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH NOCHECK ADD  CONSTRAINT [FK_PurchaseOrders_Status] FOREIGN KEY([StatusID])
REFERENCES [dbo].[PurchaseOrderStatus] ([StatusID])
GO
ALTER TABLE [dbo].[PurchaseOrders] CHECK CONSTRAINT [FK_PurchaseOrders_Status]
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrders_SubmittedBy] FOREIGN KEY([SubmittedByID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[PurchaseOrders] CHECK CONSTRAINT [FK_PurchaseOrders_SubmittedBy]
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH NOCHECK ADD  CONSTRAINT [FK_PurchaseOrders_Vendor] FOREIGN KEY([VendorID])
REFERENCES [dbo].[Companies] ([CompanyID])
GO
ALTER TABLE [dbo].[PurchaseOrders] CHECK CONSTRAINT [FK_PurchaseOrders_Vendor]
GO
ALTER TABLE [dbo].[StockTake]  WITH NOCHECK ADD  CONSTRAINT [StockTake$New_ProductsStockTake] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[StockTake] CHECK CONSTRAINT [StockTake$New_ProductsStockTake]
GO
ALTER TABLE [dbo].[Catalog_TableOfContents]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Catalog_TableOfContents$TocTitle$disallow_zero_length] CHECK  ((len([TocTitle])>(0)))
GO
ALTER TABLE [dbo].[Catalog_TableOfContents] CHECK CONSTRAINT [SSMA_CC$Catalog_TableOfContents$TocTitle$disallow_zero_length]
GO
ALTER TABLE [dbo].[Companies]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Companies$AddedBy$disallow_zero_length] CHECK  ((len([AddedBy])>(0)))
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [SSMA_CC$Companies$AddedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[Companies]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Companies$Address$disallow_zero_length] CHECK  ((len([Address])>(0)))
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [SSMA_CC$Companies$Address$disallow_zero_length]
GO
ALTER TABLE [dbo].[Companies]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Companies$BusinessPhone$disallow_zero_length] CHECK  ((len([BusinessPhone])>(0)))
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [SSMA_CC$Companies$BusinessPhone$disallow_zero_length]
GO
ALTER TABLE [dbo].[Companies]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Companies$City$disallow_zero_length] CHECK  ((len([City])>(0)))
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [SSMA_CC$Companies$City$disallow_zero_length]
GO
ALTER TABLE [dbo].[Companies]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Companies$CompanyName$disallow_zero_length] CHECK  ((len([CompanyName])>(0)))
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [SSMA_CC$Companies$CompanyName$disallow_zero_length]
GO
ALTER TABLE [dbo].[Companies]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Companies$ModifiedBy$disallow_zero_length] CHECK  ((len([ModifiedBy])>(0)))
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [SSMA_CC$Companies$ModifiedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[Companies]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Companies$Notes$disallow_zero_length] CHECK  ((len([Notes])>(0)))
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [SSMA_CC$Companies$Notes$disallow_zero_length]
GO
ALTER TABLE [dbo].[Companies]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Companies$StateAbbrev$disallow_zero_length] CHECK  ((len([StateAbbrev])>(0)))
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [SSMA_CC$Companies$StateAbbrev$disallow_zero_length]
GO
ALTER TABLE [dbo].[Companies]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Companies$Website$disallow_zero_length] CHECK  ((len([Website])>(0)))
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [SSMA_CC$Companies$Website$disallow_zero_length]
GO
ALTER TABLE [dbo].[Companies]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Companies$Zip$disallow_zero_length] CHECK  ((len([Zip])>(0)))
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [SSMA_CC$Companies$Zip$disallow_zero_length]
GO
ALTER TABLE [dbo].[CompanyTypes]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$CompanyTypes$CompanyType$disallow_zero_length] CHECK  ((len([CompanyType])>(0)))
GO
ALTER TABLE [dbo].[CompanyTypes] CHECK CONSTRAINT [SSMA_CC$CompanyTypes$CompanyType$disallow_zero_length]
GO
ALTER TABLE [dbo].[Contacts]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Contacts$AddedBy$disallow_zero_length] CHECK  ((len([AddedBy])>(0)))
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [SSMA_CC$Contacts$AddedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[Contacts]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Contacts$EmailAddress$disallow_zero_length] CHECK  ((len([EmailAddress])>(0)))
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [SSMA_CC$Contacts$EmailAddress$disallow_zero_length]
GO
ALTER TABLE [dbo].[Contacts]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Contacts$FirstName$disallow_zero_length] CHECK  ((len([FirstName])>(0)))
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [SSMA_CC$Contacts$FirstName$disallow_zero_length]
GO
ALTER TABLE [dbo].[Contacts]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Contacts$JobTitle$disallow_zero_length] CHECK  ((len([JobTitle])>(0)))
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [SSMA_CC$Contacts$JobTitle$disallow_zero_length]
GO
ALTER TABLE [dbo].[Contacts]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Contacts$LastName$disallow_zero_length] CHECK  ((len([LastName])>(0)))
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [SSMA_CC$Contacts$LastName$disallow_zero_length]
GO
ALTER TABLE [dbo].[Contacts]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Contacts$ModifiedBy$disallow_zero_length] CHECK  ((len([ModifiedBy])>(0)))
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [SSMA_CC$Contacts$ModifiedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[Contacts]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Contacts$Notes$disallow_zero_length] CHECK  ((len([Notes])>(0)))
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [SSMA_CC$Contacts$Notes$disallow_zero_length]
GO
ALTER TABLE [dbo].[Contacts]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Contacts$PrimaryPhone$disallow_zero_length] CHECK  ((len([PrimaryPhone])>(0)))
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [SSMA_CC$Contacts$PrimaryPhone$disallow_zero_length]
GO
ALTER TABLE [dbo].[Contacts]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Contacts$SecondaryPhone$disallow_zero_length] CHECK  ((len([SecondaryPhone])>(0)))
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [SSMA_CC$Contacts$SecondaryPhone$disallow_zero_length]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [EmployeeSupervisor] CHECK  (([SupervisorID]<>[EmployeeID]))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [EmployeeSupervisor]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Employees$AddedBy$disallow_zero_length] CHECK  ((len([AddedBy])>(0)))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [SSMA_CC$Employees$AddedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Employees$EmailAddress$disallow_zero_length] CHECK  ((len([EmailAddress])>(0)))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [SSMA_CC$Employees$EmailAddress$disallow_zero_length]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Employees$FirstName$disallow_zero_length] CHECK  ((len([FirstName])>(0)))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [SSMA_CC$Employees$FirstName$disallow_zero_length]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Employees$JobTitle$disallow_zero_length] CHECK  ((len([JobTitle])>(0)))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [SSMA_CC$Employees$JobTitle$disallow_zero_length]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Employees$LastName$disallow_zero_length] CHECK  ((len([LastName])>(0)))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [SSMA_CC$Employees$LastName$disallow_zero_length]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Employees$ModifiedBy$disallow_zero_length] CHECK  ((len([ModifiedBy])>(0)))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [SSMA_CC$Employees$ModifiedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Employees$Notes$disallow_zero_length] CHECK  ((len([Notes])>(0)))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [SSMA_CC$Employees$Notes$disallow_zero_length]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Employees$PrimaryPhone$disallow_zero_length] CHECK  ((len([PrimaryPhone])>(0)))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [SSMA_CC$Employees$PrimaryPhone$disallow_zero_length]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Employees$SecondaryPhone$disallow_zero_length] CHECK  ((len([SecondaryPhone])>(0)))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [SSMA_CC$Employees$SecondaryPhone$disallow_zero_length]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Employees$Title$disallow_zero_length] CHECK  ((len([Title])>(0)))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [SSMA_CC$Employees$Title$disallow_zero_length]
GO
ALTER TABLE [dbo].[Employees]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Employees$WindowsUserName$disallow_zero_length] CHECK  ((len([WindowsUserName])>(0)))
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [SSMA_CC$Employees$WindowsUserName$disallow_zero_length]
GO
ALTER TABLE [dbo].[MenuOptions]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$MenuOptions$Icon$disallow_zero_length] CHECK  ((len([Icon])>(0)))
GO
ALTER TABLE [dbo].[MenuOptions] CHECK CONSTRAINT [SSMA_CC$MenuOptions$Icon$disallow_zero_length]
GO
ALTER TABLE [dbo].[MenuOptions]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$MenuOptions$ScreenName$disallow_zero_length] CHECK  ((len([ScreenName])>(0)))
GO
ALTER TABLE [dbo].[MenuOptions] CHECK CONSTRAINT [SSMA_CC$MenuOptions$ScreenName$disallow_zero_length]
GO
ALTER TABLE [dbo].[MenuOptions]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$MenuOptions$Title$disallow_zero_length] CHECK  ((len([Title])>(0)))
GO
ALTER TABLE [dbo].[MenuOptions] CHECK CONSTRAINT [SSMA_CC$MenuOptions$Title$disallow_zero_length]
GO
ALTER TABLE [dbo].[MRU]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$MRU$TableName$disallow_zero_length] CHECK  ((len([TableName])>(0)))
GO
ALTER TABLE [dbo].[MRU] CHECK CONSTRAINT [SSMA_CC$MRU$TableName$disallow_zero_length]
GO
ALTER TABLE [dbo].[NorthwindFeatures]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$NorthwindFeatures$Description$disallow_zero_length] CHECK  ((len([Description])>(0)))
GO
ALTER TABLE [dbo].[NorthwindFeatures] CHECK CONSTRAINT [SSMA_CC$NorthwindFeatures$Description$disallow_zero_length]
GO
ALTER TABLE [dbo].[NorthwindFeatures]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$NorthwindFeatures$HelpKeywords$disallow_zero_length] CHECK  ((len([HelpKeywords])>(0)))
GO
ALTER TABLE [dbo].[NorthwindFeatures] CHECK CONSTRAINT [SSMA_CC$NorthwindFeatures$HelpKeywords$disallow_zero_length]
GO
ALTER TABLE [dbo].[NorthwindFeatures]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$NorthwindFeatures$ItemName$disallow_zero_length] CHECK  ((len([ItemName])>(0)))
GO
ALTER TABLE [dbo].[NorthwindFeatures] CHECK CONSTRAINT [SSMA_CC$NorthwindFeatures$ItemName$disallow_zero_length]
GO
ALTER TABLE [dbo].[NorthwindFeatures]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$NorthwindFeatures$LearnMore$disallow_zero_length] CHECK  ((len([LearnMore])>(0)))
GO
ALTER TABLE [dbo].[NorthwindFeatures] CHECK CONSTRAINT [SSMA_CC$NorthwindFeatures$LearnMore$disallow_zero_length]
GO
ALTER TABLE [dbo].[NorthwindFeatures]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$NorthwindFeatures$Navigation$disallow_zero_length] CHECK  ((len([Navigation])>(0)))
GO
ALTER TABLE [dbo].[NorthwindFeatures] CHECK CONSTRAINT [SSMA_CC$NorthwindFeatures$Navigation$disallow_zero_length]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$OrderDetails$AddedBy$disallow_zero_length] CHECK  ((len([AddedBy])>(0)))
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [SSMA_CC$OrderDetails$AddedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$OrderDetails$ModifiedBy$disallow_zero_length] CHECK  ((len([ModifiedBy])>(0)))
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [SSMA_CC$OrderDetails$ModifiedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$OrderDetails$Quantity$validation_rule] CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [SSMA_CC$OrderDetails$Quantity$validation_rule]
GO
ALTER TABLE [dbo].[OrderDetailStatus]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$OrderDetailStatus$OrderDetailStatusName$disallow_zero_length] CHECK  ((len([OrderDetailStatusName])>(0)))
GO
ALTER TABLE [dbo].[OrderDetailStatus] CHECK CONSTRAINT [SSMA_CC$OrderDetailStatus$OrderDetailStatusName$disallow_zero_length]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Orders$AddedBy$disallow_zero_length] CHECK  ((len([AddedBy])>(0)))
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [SSMA_CC$Orders$AddedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Orders$ModifiedBy$disallow_zero_length] CHECK  ((len([ModifiedBy])>(0)))
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [SSMA_CC$Orders$ModifiedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Orders$Notes$disallow_zero_length] CHECK  ((len([Notes])>(0)))
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [SSMA_CC$Orders$Notes$disallow_zero_length]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Orders$PaymentMethod$disallow_zero_length] CHECK  ((len([PaymentMethod])>(0)))
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [SSMA_CC$Orders$PaymentMethod$disallow_zero_length]
GO
ALTER TABLE [dbo].[OrderStatus]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$OrderStatus$OrderStatusCode$disallow_zero_length] CHECK  ((len([OrderStatusCode])>(0)))
GO
ALTER TABLE [dbo].[OrderStatus] CHECK CONSTRAINT [SSMA_CC$OrderStatus$OrderStatusCode$disallow_zero_length]
GO
ALTER TABLE [dbo].[OrderStatus]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$OrderStatus$OrderStatusName$disallow_zero_length] CHECK  ((len([OrderStatusName])>(0)))
GO
ALTER TABLE [dbo].[OrderStatus] CHECK CONSTRAINT [SSMA_CC$OrderStatus$OrderStatusName$disallow_zero_length]
GO
ALTER TABLE [dbo].[Privileges]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Privileges$PrivilegeName$disallow_zero_length] CHECK  ((len([PrivilegeName])>(0)))
GO
ALTER TABLE [dbo].[Privileges] CHECK CONSTRAINT [SSMA_CC$Privileges$PrivilegeName$disallow_zero_length]
GO
ALTER TABLE [dbo].[ProductCategories]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$ProductCategories$AddedBy$disallow_zero_length] CHECK  ((len([AddedBy])>(0)))
GO
ALTER TABLE [dbo].[ProductCategories] CHECK CONSTRAINT [SSMA_CC$ProductCategories$AddedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[ProductCategories]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$ProductCategories$ModifiedBy$disallow_zero_length] CHECK  ((len([ModifiedBy])>(0)))
GO
ALTER TABLE [dbo].[ProductCategories] CHECK CONSTRAINT [SSMA_CC$ProductCategories$ModifiedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[ProductCategories]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$ProductCategories$ProductCategoryCode$disallow_zero_length] CHECK  ((len([ProductCategoryCode])>(0)))
GO
ALTER TABLE [dbo].[ProductCategories] CHECK CONSTRAINT [SSMA_CC$ProductCategories$ProductCategoryCode$disallow_zero_length]
GO
ALTER TABLE [dbo].[ProductCategories]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$ProductCategories$ProductCategoryDesc$disallow_zero_length] CHECK  ((len([ProductCategoryDesc])>(0)))
GO
ALTER TABLE [dbo].[ProductCategories] CHECK CONSTRAINT [SSMA_CC$ProductCategories$ProductCategoryDesc$disallow_zero_length]
GO
ALTER TABLE [dbo].[ProductCategories]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$ProductCategories$ProductCategoryName$disallow_zero_length] CHECK  ((len([ProductCategoryName])>(0)))
GO
ALTER TABLE [dbo].[ProductCategories] CHECK CONSTRAINT [SSMA_CC$ProductCategories$ProductCategoryName$disallow_zero_length]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Products$AddedBy$disallow_zero_length] CHECK  ((len([AddedBy])>(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [SSMA_CC$Products$AddedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Products$ModifiedBy$disallow_zero_length] CHECK  ((len([ModifiedBy])>(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [SSMA_CC$Products$ModifiedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Products$ProductCode$disallow_zero_length] CHECK  ((len([ProductCode])>(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [SSMA_CC$Products$ProductCode$disallow_zero_length]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Products$ProductDescription$disallow_zero_length] CHECK  ((len([ProductDescription])>(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [SSMA_CC$Products$ProductDescription$disallow_zero_length]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Products$ProductName$disallow_zero_length] CHECK  ((len([ProductName])>(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [SSMA_CC$Products$ProductName$disallow_zero_length]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Products$QuantityPerUnit$disallow_zero_length] CHECK  ((len([QuantityPerUnit])>(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [SSMA_CC$Products$QuantityPerUnit$disallow_zero_length]
GO
ALTER TABLE [dbo].[PurchaseOrderDetails]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$PurchaseOrderDetails$AddedBy$disallow_zero_length] CHECK  ((len([AddedBy])>(0)))
GO
ALTER TABLE [dbo].[PurchaseOrderDetails] CHECK CONSTRAINT [SSMA_CC$PurchaseOrderDetails$AddedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[PurchaseOrderDetails]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$PurchaseOrderDetails$ModifiedBy$disallow_zero_length] CHECK  ((len([ModifiedBy])>(0)))
GO
ALTER TABLE [dbo].[PurchaseOrderDetails] CHECK CONSTRAINT [SSMA_CC$PurchaseOrderDetails$ModifiedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$PurchaseOrders$AddedBy$disallow_zero_length] CHECK  ((len([AddedBy])>(0)))
GO
ALTER TABLE [dbo].[PurchaseOrders] CHECK CONSTRAINT [SSMA_CC$PurchaseOrders$AddedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$PurchaseOrders$ModifiedBy$disallow_zero_length] CHECK  ((len([ModifiedBy])>(0)))
GO
ALTER TABLE [dbo].[PurchaseOrders] CHECK CONSTRAINT [SSMA_CC$PurchaseOrders$ModifiedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$PurchaseOrders$Notes$disallow_zero_length] CHECK  ((len([Notes])>(0)))
GO
ALTER TABLE [dbo].[PurchaseOrders] CHECK CONSTRAINT [SSMA_CC$PurchaseOrders$Notes$disallow_zero_length]
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$PurchaseOrders$PaymentMethod$disallow_zero_length] CHECK  ((len([PaymentMethod])>(0)))
GO
ALTER TABLE [dbo].[PurchaseOrders] CHECK CONSTRAINT [SSMA_CC$PurchaseOrders$PaymentMethod$disallow_zero_length]
GO
ALTER TABLE [dbo].[PurchaseOrderStatus]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$PurchaseOrderStatus$StatusName$disallow_zero_length] CHECK  ((len([StatusName])>(0)))
GO
ALTER TABLE [dbo].[PurchaseOrderStatus] CHECK CONSTRAINT [SSMA_CC$PurchaseOrderStatus$StatusName$disallow_zero_length]
GO
ALTER TABLE [dbo].[SSErrors]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$SSErrors$AddedBy$disallow_zero_length] CHECK  ((len([AddedBy])>(0)))
GO
ALTER TABLE [dbo].[SSErrors] CHECK CONSTRAINT [SSMA_CC$SSErrors$AddedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[SSErrors]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$SSErrors$ModifiedBy$disallow_zero_length] CHECK  ((len([ModifiedBy])>(0)))
GO
ALTER TABLE [dbo].[SSErrors] CHECK CONSTRAINT [SSMA_CC$SSErrors$ModifiedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[SSErrors]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$SSErrors$SSError$disallow_zero_length] CHECK  ((len([SSError])>(0)))
GO
ALTER TABLE [dbo].[SSErrors] CHECK CONSTRAINT [SSMA_CC$SSErrors$SSError$disallow_zero_length]
GO
ALTER TABLE [dbo].[States]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$States$StateAbbrev$disallow_zero_length] CHECK  ((len([StateAbbrev])>(0)))
GO
ALTER TABLE [dbo].[States] CHECK CONSTRAINT [SSMA_CC$States$StateAbbrev$disallow_zero_length]
GO
ALTER TABLE [dbo].[States]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$States$StateName$disallow_zero_length] CHECK  ((len([StateName])>(0)))
GO
ALTER TABLE [dbo].[States] CHECK CONSTRAINT [SSMA_CC$States$StateName$disallow_zero_length]
GO
ALTER TABLE [dbo].[StockTake]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$StockTake$AddedBy$disallow_zero_length] CHECK  ((len([AddedBy])>(0)))
GO
ALTER TABLE [dbo].[StockTake] CHECK CONSTRAINT [SSMA_CC$StockTake$AddedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[StockTake]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$StockTake$ExpectedQuantity$validation_rule] CHECK  (([ExpectedQuantity]>=(0)))
GO
ALTER TABLE [dbo].[StockTake] CHECK CONSTRAINT [SSMA_CC$StockTake$ExpectedQuantity$validation_rule]
GO
ALTER TABLE [dbo].[StockTake]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$StockTake$ModifiedBy$disallow_zero_length] CHECK  ((len([ModifiedBy])>(0)))
GO
ALTER TABLE [dbo].[StockTake] CHECK CONSTRAINT [SSMA_CC$StockTake$ModifiedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[StockTake]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$StockTake$QuantityOnHand$validation_rule] CHECK  (([QuantityOnHand]>=(0)))
GO
ALTER TABLE [dbo].[StockTake] CHECK CONSTRAINT [SSMA_CC$StockTake$QuantityOnHand$validation_rule]
GO
ALTER TABLE [dbo].[Strings]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Strings$AddedBy$disallow_zero_length] CHECK  ((len([AddedBy])>(0)))
GO
ALTER TABLE [dbo].[Strings] CHECK CONSTRAINT [SSMA_CC$Strings$AddedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[Strings]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Strings$ModifiedBy$disallow_zero_length] CHECK  ((len([ModifiedBy])>(0)))
GO
ALTER TABLE [dbo].[Strings] CHECK CONSTRAINT [SSMA_CC$Strings$ModifiedBy$disallow_zero_length]
GO
ALTER TABLE [dbo].[Strings]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Strings$StringData$disallow_zero_length] CHECK  ((len([StringData])>(0)))
GO
ALTER TABLE [dbo].[Strings] CHECK CONSTRAINT [SSMA_CC$Strings$StringData$disallow_zero_length]
GO
ALTER TABLE [dbo].[SystemSettings]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$SystemSettings$Notes$disallow_zero_length] CHECK  ((len([Notes])>(0)))
GO
ALTER TABLE [dbo].[SystemSettings] CHECK CONSTRAINT [SSMA_CC$SystemSettings$Notes$disallow_zero_length]
GO
ALTER TABLE [dbo].[SystemSettings]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$SystemSettings$SettingName$disallow_zero_length] CHECK  ((len([SettingName])>(0)))
GO
ALTER TABLE [dbo].[SystemSettings] CHECK CONSTRAINT [SSMA_CC$SystemSettings$SettingName$disallow_zero_length]
GO
ALTER TABLE [dbo].[SystemSettings]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$SystemSettings$SettingValue$disallow_zero_length] CHECK  ((len([SettingValue])>(0)))
GO
ALTER TABLE [dbo].[SystemSettings] CHECK CONSTRAINT [SSMA_CC$SystemSettings$SettingValue$disallow_zero_length]
GO
ALTER TABLE [dbo].[TaxStatus]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$TaxStatus$TaxStatus$disallow_zero_length] CHECK  ((len([TaxStatus])>(0)))
GO
ALTER TABLE [dbo].[TaxStatus] CHECK CONSTRAINT [SSMA_CC$TaxStatus$TaxStatus$disallow_zero_length]
GO
ALTER TABLE [dbo].[UserSettings]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$UserSettings$Notes$disallow_zero_length] CHECK  ((len([Notes])>(0)))
GO
ALTER TABLE [dbo].[UserSettings] CHECK CONSTRAINT [SSMA_CC$UserSettings$Notes$disallow_zero_length]
GO
ALTER TABLE [dbo].[UserSettings]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$UserSettings$SettingName$disallow_zero_length] CHECK  ((len([SettingName])>(0)))
GO
ALTER TABLE [dbo].[UserSettings] CHECK CONSTRAINT [SSMA_CC$UserSettings$SettingName$disallow_zero_length]
GO
ALTER TABLE [dbo].[UserSettings]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$UserSettings$SettingValue$disallow_zero_length] CHECK  ((len([SettingValue])>(0)))
GO
ALTER TABLE [dbo].[UserSettings] CHECK CONSTRAINT [SSMA_CC$UserSettings$SettingValue$disallow_zero_length]
GO
ALTER TABLE [dbo].[USysRibbons]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$USysRibbons$RibbonName$disallow_zero_length] CHECK  ((len([RibbonName])>(0)))
GO
ALTER TABLE [dbo].[USysRibbons] CHECK CONSTRAINT [SSMA_CC$USysRibbons$RibbonName$disallow_zero_length]
GO
ALTER TABLE [dbo].[USysRibbons]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$USysRibbons$RibbonXML$disallow_zero_length] CHECK  ((len([RibbonXML])>(0)))
GO
ALTER TABLE [dbo].[USysRibbons] CHECK CONSTRAINT [SSMA_CC$USysRibbons$RibbonXML$disallow_zero_length]
GO
ALTER TABLE [dbo].[Welcome]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Welcome$Learn$disallow_zero_length] CHECK  ((len([Learn])>(0)))
GO
ALTER TABLE [dbo].[Welcome] CHECK CONSTRAINT [SSMA_CC$Welcome$Learn$disallow_zero_length]
GO
ALTER TABLE [dbo].[Welcome]  WITH NOCHECK ADD  CONSTRAINT [SSMA_CC$Welcome$Welcome$disallow_zero_length] CHECK  ((len([Welcome])>(0)))
GO
ALTER TABLE [dbo].[Welcome] CHECK CONSTRAINT [SSMA_CC$Welcome$Welcome$disallow_zero_length]
GO
/****** Object:  StoredProcedure [AdminSPs].[AddOrUpdateExtendedProperty]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [AdminSPs].[AddOrUpdateExtendedProperty]
    @PropertyName NVARCHAR(128),
    @PropertyValue NVARCHAR(1200),
    @Level0Type NVARCHAR(60),
    @Level0Name NVARCHAR(128),
    @Level1Type NVARCHAR(60) = NULL,
    @Level1Name NVARCHAR(128) = NULL,
    @Level2Type NVARCHAR(60) = NULL,
    @Level2Name NVARCHAR(128) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Validate required inputs
    IF @PropertyName IS NULL OR @PropertyValue IS NULL OR @Level0Type IS NULL OR @Level0Name IS NULL
    BEGIN
        RAISERROR('Property name, value, and at least Level0 (e.g. schema) are required.', 16, 1);
        RETURN;
    END

    -- Build the dynamic SQL for fn_listextendedproperty
    DECLARE @Exists INT;
    SELECT @Exists = COUNT(*)
    FROM fn_listextendedproperty (
        @PropertyName,
        @Level0Type, @Level0Name,
        @Level1Type, @Level1Name,
        @Level2Type, @Level2Name
    );

    IF @Exists > 0
    BEGIN
        EXEC sys.sp_updateextendedproperty 
            @name = @PropertyName,
            @value = @PropertyValue,
            @level0type = @Level0Type, @level0name = @Level0Name,
            @level1type = @Level1Type, @level1name = @Level1Name,
            @level2type = @Level2Type, @level2name = @Level2Name;
    END
    ELSE
    BEGIN
        EXEC sys.sp_addextendedproperty 
            @name = @PropertyName,
            @value = @PropertyValue,
            @level0type = @Level0Type, @level0name = @Level0Name,
            @level1type = @Level1Type, @level1name = @Level1Name,
            @level2type = @Level2Type, @level2name = @Level2Name;
    END
END
GO
/****** Object:  StoredProcedure [AdminSPs].[DataTypingForPowerApps]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [AdminSPs].[DataTypingForPowerApps]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--	| Type    | Behavior When Blank in PowerApps           | SQL Risk                             | Best Practice                    |
--| ------- | ------------------------------------------ | ------------------------------------ | -------------------------------- |
--| `INT`   | Passed as `''` (empty string)              | Conversion failure or silent `0`     | Accept as `NVARCHAR`, `TRY_CAST` |
--| `MONEY` | Passed as `''` or `0.00`                   | Incorrect assumptions or zeroing out | Same as above                    |
--| `DATE`  | Often passed as `'1900-01-01'` or `''`     | Epoch default if not handled         | Accept as `NVARCHAR`, normalize  |
--| `BIT`   | Usually handled OK, but still inconsistent | Misinterpretation of false/null      | Explicit coercion if needed      |

END
GO
/****** Object:  StoredProcedure [AdminSPs].[FixEqualSignSpacing]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- SQL Server Optimized Version
-- This procedure finds and fixes = signs without proper spacing in all stored procedures
-- Uses SQL Server specific features for better performance and accuracy

CREATE PROCEDURE [AdminSPs].[FixEqualSignSpacing]
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ProcName NVARCHAR(255);
    DECLARE @Definition NVARCHAR(MAX);
    DECLARE @NewDefinition NVARCHAR(MAX);
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @ChangesCount INT = 0;
    DECLARE @TotalProcs INT = 0;
    DECLARE @Schema NVARCHAR(255);
    
    -- Create temporary table to store results
    CREATE TABLE #Results (
        SchemaName NVARCHAR(255),
        ProcedureName NVARCHAR(255),
        FoundIssues BIT,
        ChangesCount INT,
        OriginalLength INT,
        NewLength INT,
        SampleBefore NVARCHAR(200),
        SampleAfter NVARCHAR(200)
    );
    
    -- Cursor to iterate through all stored procedures
    DECLARE proc_cursor CURSOR LOCAL FAST_FORWARD FOR
    SELECT 
        s.name AS schema_name,
        o.name AS proc_name,
        m.definition
    FROM sys.sql_modules m
    INNER JOIN sys.objects o ON m.object_id = o.object_id
    INNER JOIN sys.schemas s ON o.schema_id = s.schema_id
    WHERE o.type = 'P'
        AND m.definition IS NOT NULL
        AND o.is_ms_shipped = 0  -- Exclude system procedures
        AND s.name = 'dbo'
    ORDER BY s.name, o.name;
    
    OPEN proc_cursor;
    FETCH NEXT FROM proc_cursor INTO @Schema, @ProcName, @Definition;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @TotalProcs = @TotalProcs + 1;
        SET @NewDefinition = @Definition;
        SET @ChangesCount = 0;
        
        DECLARE @OriginalDef NVARCHAR(MAX) = @Definition;
        DECLARE @SampleBefore NVARCHAR(200) = '';
        DECLARE @SampleAfter NVARCHAR(200) = '';
        
        -- SQL Server specific pattern replacements using REPLACE with COLLATE for case sensitivity
        -- Handle common data type assignments
        IF @NewDefinition LIKE '%[a-zA-Z0-9_]=[a-zA-Z0-9_@''"]%' COLLATE SQL_Latin1_General_CP1_CS_AS
        BEGIN
            -- Variables and parameters
            SET @NewDefinition = REPLACE(@NewDefinition, '@', '§@');  -- Temporarily mark variables
            
            -- Fix variable assignments: @var=value → @var = value
            DECLARE @pos INT = 1;
            DECLARE @newResult NVARCHAR(MAX) = '';
            DECLARE @len INT = LEN(@NewDefinition);
            
            WHILE @pos <= @len
            BEGIN
                DECLARE @currentChar NCHAR(1) = SUBSTRING(@NewDefinition, @pos, 1);
                DECLARE @prevChar NCHAR(1) = CASE WHEN @pos > 1 THEN SUBSTRING(@NewDefinition, @pos - 1, 1) ELSE ' ' END;
                DECLARE @nextChar NCHAR(1) = CASE WHEN @pos < @len THEN SUBSTRING(@NewDefinition, @pos + 1, 1) ELSE ' ' END;
                
                IF @currentChar = '='
                BEGIN
                    DECLARE @needSpaceBefore BIT = 0;
                    DECLARE @needSpaceAfter BIT = 0;
                    
                    -- Check if we need space before =
                    IF @prevChar LIKE '[a-zA-Z0-9_)]' AND @prevChar != ' '
                        SET @needSpaceBefore = 1;
                    
                    -- Check if we need space after =
                    IF @nextChar LIKE '[a-zA-Z0-9_@''("+-]' AND @nextChar != ' '
                        SET @needSpaceAfter = 1;
                    
                    -- Skip if this is part of a comparison operator
                    IF @prevChar IN ('!', '<', '>', '=') OR @nextChar IN ('=', '>')
                    BEGIN
                        SET @needSpaceBefore = 0;
                        SET @needSpaceAfter = 0;
                    END
                    
                    -- Add spaces as needed
                    IF @needSpaceBefore = 1
                    BEGIN
                        SET @newResult = @newResult + ' = ';
                        SET @ChangesCount = @ChangesCount + 1;
                        
                        -- Capture sample for first change
                        IF @SampleBefore = ''
                        BEGIN
                            SET @SampleBefore = SUBSTRING(@NewDefinition, GREATEST(@pos - 20, 1), 40);
                        END
                    END
                    ELSE IF @needSpaceAfter = 1
                    BEGIN
                        SET @newResult = @newResult + '= ';
                        SET @ChangesCount = @ChangesCount + 1;
                        
                        -- Capture sample for first change
                        IF @SampleBefore = ''
                        BEGIN
                            SET @SampleBefore = SUBSTRING(@NewDefinition, GREATEST(@pos - 20, 1), 40);
                        END
                    END
                    ELSE
                    BEGIN
                        SET @newResult = @newResult + @currentChar;
                    END
                END
                ELSE
                BEGIN
                    SET @newResult = @newResult + @currentChar;
                END
                
                SET @pos = @pos + 1;
            END
            
            SET @NewDefinition = @newResult;
            
            -- Restore variable markers
            SET @NewDefinition = REPLACE(@NewDefinition, '§@', '@');
            
            -- Capture sample after if changes were made
            IF @ChangesCount > 0
            BEGIN
                SET @SampleAfter = SUBSTRING(@NewDefinition, CHARINDEX('=', @NewDefinition) - 20, 40);
            END
        END
        
        -- Clean up any double spaces that might have been created
        WHILE CHARINDEX('  ', @NewDefinition) > 0
        BEGIN
            SET @NewDefinition = REPLACE(@NewDefinition, '  ', ' ');
        END
        
        -- Fix spacing around comparison operators that shouldn't have spaces
        SET @NewDefinition = REPLACE(@NewDefinition, '! =', '!=');
        SET @NewDefinition = REPLACE(@NewDefinition, '< =', '<=');
        SET @NewDefinition = REPLACE(@NewDefinition, '> =', '>=');
        SET @NewDefinition = REPLACE(@NewDefinition, '< >', '<>');
        
        -- Record results
        INSERT INTO #Results (SchemaName, ProcedureName, FoundIssues, ChangesCount, OriginalLength, NewLength, SampleBefore, SampleAfter)
        VALUES (@Schema, @ProcName, 
                CASE WHEN @OriginalDef != @NewDefinition THEN 1 ELSE 0 END, 
                @ChangesCount,
                LEN(@OriginalDef),
                LEN(@NewDefinition),
                @SampleBefore,
                @SampleAfter);
        
        -- Generate ALTER statement if changes were made
        IF @OriginalDef != @NewDefinition
        BEGIN
            -- Create the ALTER statement
            SET @SQL = REPLACE(@NewDefinition, 'CREATE PROCEDURE', 'ALTER PROCEDURE');
            SET @SQL = REPLACE(@SQL, 'CREATE PROC', 'ALTER PROC');
            
            PRINT '-- Procedure: [' + @Schema + '].[' + @ProcName + '] - ' + CAST(@ChangesCount AS VARCHAR(10)) + ' changes found';
            PRINT '-- Sample change: ' + ISNULL(@SampleBefore, 'N/A') + ' → ' + ISNULL(@SampleAfter, 'N/A');
            PRINT @SQL;
            PRINT 'GO';
            PRINT '';
            
            -- Uncomment the next line to actually execute the changes
             EXEC sp_executesql @SQL;
        END;
        
        FETCH NEXT FROM proc_cursor INTO @Schema, @ProcName, @Definition;
    END;
    
    CLOSE proc_cursor;
    DEALLOCATE proc_cursor;
    
    -- Display summary
    PRINT '========================================';
    PRINT 'SUMMARY REPORT';
    PRINT '========================================';
    
    SELECT 
        'SUMMARY' AS ReportSection,
        @TotalProcs AS TotalProcedures,
        COUNT(*) AS ProceduresWithIssues,
        SUM(ChangesCount) AS TotalChanges
    FROM #Results
    WHERE FoundIssues = 1;
    
    PRINT '';
    PRINT 'DETAILED RESULTS:';
    
    -- Show detailed results
    SELECT 
        SchemaName + '.' + ProcedureName AS FullProcedureName,
        ChangesCount,
        OriginalLength,
        NewLength,
        CASE 
            WHEN LEN(SampleBefore) > 0 THEN 'BEFORE: ' + SampleBefore 
            ELSE 'No sample captured' 
        END AS SampleBefore,
        CASE 
            WHEN LEN(SampleAfter) > 0 THEN 'AFTER: ' + SampleAfter 
            ELSE 'No sample captured' 
        END AS SampleAfter
    FROM #Results
    WHERE FoundIssues = 1
    ORDER BY ChangesCount DESC, SchemaName, ProcedureName;
    
    -- Show procedures without issues (optional)
    SELECT 
        COUNT(*) AS ProceduresWithoutIssues
    FROM #Results
    WHERE FoundIssues = 0;
    
    DROP TABLE #Results;
    
    PRINT '';
    PRINT '========================================';
    PRINT 'INSTRUCTIONS:';
    PRINT '1. Review the ALTER statements above';
    PRINT '2. Test on a development database first';
    PRINT '3. Uncomment the EXEC sp_executesql line to apply changes';
    PRINT '4. Consider running this in a transaction for safety';
    PRINT '========================================';
END;

-- Usage Examples:
-- EXEC FixEqualSignSpacing;
--
-- To run with transaction safety:
-- BEGIN TRANSACTION
-- EXEC FixEqualSignSpacing;
-- -- Review results, then either:
-- COMMIT TRANSACTION;  -- or ROLLBACK TRANSACTION;
GO
/****** Object:  StoredProcedure [AdminSPs].[GetDynamicFilteredData]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [AdminSPs].[GetDynamicFilteredData]
    @TableName NVARCHAR(128),
    @WhereClause NVARCHAR(1000) = NULL,  -- Optional WHERE clause
    @OrderByClause NVARCHAR(500) = NULL, -- Optional ORDER BY clause
    @TopRowCount INT = 100,               -- Limit for unfiltered data

	@LocalID AS int = 0 OUTPUT ,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT	 
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @SQL NVARCHAR(MAX)
    -- Validate the table name (prevents SQL injection)
    IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = @TableName)
    BEGIN
        RAISERROR('Invalid table name specified', 16, 1)
        RETURN
    END
    
    -- First result set: Filtered data
    SET @SQL = N'SELECT * FROM ' + QUOTENAME(@TableName)
    
    IF @WhereClause IS NOT NULL AND LEN(@WhereClause) > 0
        SET @SQL = @SQL + N' WHERE ' + @WhereClause  
        
    IF @OrderByClause IS NOT NULL AND LEN(@OrderByClause) > 0
        SET @SQL = @SQL + N' ORDER BY ' + @OrderByClause
    
    EXEC sp_executesql @SQL
    
    -- Second result set: Unfiltered data with TOP limit
    SET @SQL = N'SELECT TOP (' + CAST(@TopRowCount AS NVARCHAR(10)) + ') * FROM ' + QUOTENAME(@TableName)
    
    -- Use default ordering if none specified
    IF @OrderByClause IS NOT NULL AND LEN(@OrderByClause) > 0
        SET @SQL = @SQL + N' ORDER BY ' + @OrderByClause
    ELSE
        SET @SQL = @SQL + N' ORDER BY (SELECT NULL)'  -- Default ordering if none specified
    
    EXEC sp_executesql @SQL
END
GO
/****** Object:  StoredProcedure [AdminSPs].[GetExtendedProperty]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [AdminSPs].[GetExtendedProperty]
    @PropertyName NVARCHAR(128),
    @Level0Type NVARCHAR(60),
    @Level0Name NVARCHAR(128),
    @Level1Type NVARCHAR(60) = NULL,
    @Level1Name NVARCHAR(128) = NULL,
    @Level2Type NVARCHAR(60) = NULL,
    @Level2Name NVARCHAR(128) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        name        = ep.name,
        value       = ep.value,
        level0type  = @Level0Type,
        level0name  = @Level0Name,
        level1type  = @Level1Type,
        level1name  = @Level1Name,
        level2type  = @Level2Type,
        level2name  = @Level2Name
    FROM fn_listextendedproperty (
        @PropertyName,
        @Level0Type, @Level0Name,
        @Level1Type, @Level1Name,
        @Level2Type, @Level2Name
    ) AS ep;
END
GO
/****** Object:  StoredProcedure [AdminSPs].[ListFieldsByDataType]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==============================================================
-- Author:		George Hepworth
-- Create date: 5/24/2025
-- Description:	Create a list of all fields by data type in all tables
-- ==============================================================
CREATE PROCEDURE [AdminSPs].[ListFieldsByDataType]
	@TableName as nvarchar(60) = Null,
	@DataType as nvarchar(24) = Null,
	@Result nvarchar(500) OUTPUT
AS
BEGIN
 SET NOCOUNT ON;
 BEGIN Try
		SELECT 
			TABLE_SCHEMA AS SchemaName,
			TABLE_NAME AS TableName,
			COLUMN_NAME AS ColumnName,
			DATA_TYPE AS DataType,
			CHARACTER_MAXIMUM_LENGTH AS MaxLength 
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE DATA_TYPE = CASE 
						 WHEN @DataType Is Null
						 Then DATA_TYPE
						 ELSE @DataType
						 END
		ORDER BY SchemaName, TableName, ColumnName;
	END Try
	BEGIN Catch
		SELECT @Result = 'Error Number: ' + Cast(ERROR_NUMBER() as nvarchar(10)) +
			' Error Message: ' +ERROR_MESSAGE();
	END Catch
END;
GO
/****** Object:  StoredProcedure [AdminSPs].[ListRequiredFieldsByTable]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ==============================================================
-- Author:		George Hepworth
-- Create date: 5/24/2025
-- Description:	Create a list of required fields in all tables in the database
-- ==============================================================
CREATE PROCEDURE [AdminSPs].[ListRequiredFieldsByTable]
	@FilterTable as nvarchar(128) = Null,
	@Result nvarchar(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN Try
		SELECT 
			TABLE_SCHEMA AS SchemaName,
			TABLE_NAME AS TableName,
			COLUMN_NAME AS ColumnName,
			DATA_TYPE AS DataType,
			CASE 
			WHEN DATA_TYPE In ('varchar','nvarchar') 
			THEN 
			Cast(CHARACTER_MAXIMUM_LENGTH as nvarchar(10))
			ELSE
			'NA'
			END
			AS MaxLength,
		 
			'Required (Is Not Null)' AS Required
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE IS_NULLABLE = 'NO'
		AND DATA_TYPE <> 'TimeStamp'
		AND Table_Name Like
		 CASE WHEN @FilterTable Is Null Then '%' ELSE @FilterTable END
		ORDER BY SchemaName, CASE 
			WHEN DATA_TYPE In ('varchar','nvarchar') 
			THEN 
			0
			ELSE
			1
			END, 
			TableName, 
			ColumnName;
	END Try
	BEGIN Catch
		SELECT @Result = 'Error Number: ' + Cast(ERROR_NUMBER() as nvarchar(10)) +
			  ' Error Message: ' +ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [AdminSPs].[RebuildInventory]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
===============================================================
Author:		 George Hepworth
Create date: 2025-03-22
Description: Reset All Product Inventory to pre-sales status
             Add new orders after this step to Complete rebuild
===============================================================
*/
CREATE PROCEDURE [AdminSPs].[RebuildInventory]
	@BusinessStartDate as DateTime,
	@Result as nvarchar(500) OUTPUT,
	@ErrorCode as int = 0 OUTPUT,
	@Message as Nvarchar(128) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		Declare @POID as int;
		BEGIN TRANSACTION;
		DELETE FROM PurchaseOrderDetails;
		DELETE FROM PurchaseOrders;
		DELETE FROM OrderDetails;
		DELETE FROM Orders;
		DELETE FROM StockTake;
		INSERT INTO [dbo].[PurchaseOrders]
           (
			   [VendorID]
			   ,[SubmittedByID]
			   ,[SubmittedDate]
			   ,[ApprovedByID]
			   ,[ApprovedDate]
			   ,[StatusID]
			   ,[ReceivedDate]
			   ,[ShippingFee]
			   ,[TaxAmount]
			   ,[PaymentDate]
			   ,[PaymentAmount]
			   ,[PaymentMethod]
			   ,[Notes]
		   )
		Values
		   (
			   11, --VendorID
			   5, --SubmittedBy
			   @BusinessStartDate,--SubmittedDate
			   2, --ApprovedBy
			   DateAdd(d,1,@BusinessStartDate), --ApprovedDate
			   5, --StatusID
			   DateAdd(d,5,@BusinessStartDate), --ReceivedDate
			   100,--ShippingFee
			   0, --TaxAmount
				DateAdd(d,7,@BusinessStartDate), --PaymentDate
			   0, --Default PaymentAmount
			   'Credit Card', --PaymentMethod
			   'Initial Product Purchase' --Notes
		   );
	SELECT @POID = SCOPE_IDENTITY();

	INSERT INTO [dbo].[PurchaseOrderDetails]
        (
			[PurchaseOrderID]
			,[ProductID]
			,[Quantity]
			,[UnitCost]
			,[ReceivedDate]
		)
		--use Target level to rebuild initial PO Line Items
	SELECT 
		@POID,
		ProductID,
		TargetLevel,
		StandardUnitCost,
		DateAdd(d,5,@BusinessStartDate)
		FROM Products;

	UPDATE [dbo].[PurchaseOrders]
	SET [PaymentAmount] = PODTotal.OrderTotal
	FROM   PurchaseOrderDetails AS POD
	  INNER JOIN PurchaseOrders PO
	ON POD.PurchaseOrderID = PO.PurchaseOrderID
	  INNER JOIN 
	  (SELECT POD2.PurchaseOrderID,SUM(POD2.Quantity*POD2.UnitCost) AS OrderTotal
	  FROM PurchaseOrderDetails AS POD2
	  GROUP BY POD2.PurchaseOrderID) AS PODTotal
	  ON POD.PurchaseOrderID = PODTotal.PurchaseOrderID;

	--recreate an initial stock take
	INSERT INTO [dbo].[StockTake]
        (
			 [StockTakeDate]
			,[ProductID]
			,[QuantityOnHand]
			,[ExpectedQuantity]
		)
	SELECT 
		DateAdd(d,6,@BusinessStartDate),
		ProductID,
		quantity,
		Quantity
		FROM PurchaseOrderDetails;
		COMMIT TRANSACTION;
		SET @ErrorCode = 0;
		SET @Message = 'Rebuilt Starting Inventory'; 
	END Try
	BEGIN Catch
		SELECT @Result = 'Error Number: ' + Cast(ERROR_NUMBER() as nvarchar(10)) +
			' Error Message: ' +ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [AdminSPs].[ReindexEntireDatabase]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [AdminSPs].[ReindexEntireDatabase]

	 --@databaseName NVarchar(50) 
AS
BEGIN
/* 
Reindex an entire database. 
Work-around for maint wizard failure. 
For more information, click the following article number to view the article in the Microsoft Knowledge Base: 
1. (http://support.microsoft.com/kb/902388/) Event ID: 208 may be logged*/

SET ARITHABORT ON 
SET QUOTED_IDENTIFIER ON
 
DECLARE @tabname sysname 
DECLARE @dbstring varchar(300) 
DECLARE @exec_string varchar(300)

DECLARE tabDBCC CURSOR FOR SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'

OPEN tabDBCC 
FETCH NEXT FROM tabDBCC INTO @tabname

SELECT @dbstring = DB_NAME() 
PRINT 'Starting DBCC DBREINDEX for database ' + upper(@dbstring)

WHILE (@@fetch_status = 0) 
BEGIN 
PRINT 'Reindexing table ' + upper(@tabname) 
SELECT @exec_string = 'dbcc dbreindex ([' + @tabname + '])' 
EXEC(@exec_string) 
FETCH NEXT FROM tabDBCC INTO @tabname 
END 
CLOSE tabDBCC 
DEALLOCATE tabDBCC

PRINT 'Finished DBCC DBREINDEX for database ' + upper(@dbstring) 


END

GO
/****** Object:  StoredProcedure [AdminSPs].[RemoveDevTestDataFromNWDev]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George Hepworth
-- Create date: 6/2/2025
-- Description:	Remove Test Data from NW Dev
-- =============================================
CREATE PROCEDURE [AdminSPs].[RemoveDevTestDataFromNWDev] 
		@ErrorCode AS int = 0 OUTPUT,
		@Message AS nvarchar(400) = 'Removed Test Data' OUTPUT
AS
BEGIN
 
	SET NOCOUNT ON;
	BEGIN Try 
		BEGIN TRANSACTION;
			Truncate table OrderDetails;
			Truncate table PurchaseOrderDetails;
			DELETE FROM Orders;
			DELETE FROM PurchaseOrders;
			DELETE FROM StockTake;
		COMMIT TRANSACTION;
		SET @ErrorCode = 0;
		SET @Message = 'Removed Test Data';
		End Try

	BEGIN Catch
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [BackupSPs].[CRUDOrderDetails]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		George Hepworth
-- Create date: 5/21/2025
-- Description:	CRUD operations on OrderDetails
-- =============================================
CREATE   PROCEDURE [BackupSPs].[CRUDOrderDetails] 
	--CRUDTypes
	--Create = 1
	--Read = 2 Default Read only. Don't accidentally mess with stored values 
	--Update = 3
	--Delete = 4

	@CRUDType as int = 2,
	@OrderID AS int = 0, 
	@OrderDetailID AS Int = 0,
	@ProductID AS int = 0,
	@Quantity AS smallint= 0,
	@Discount AS decimal(6,3) =0,
	@UnitPrice AS money = 0, 
	@OrderDetailStatusID AS int = 0,

	@UnifiedID As Int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try

	DECLARE
			@LocalID as int,
			@LocalErrorCode as INT,
			@LocalMessage as NVarChar(400);

	If @CRUDType = 1 
		BEGIN
			EXEC [dbo].[Z_AddOrderDetail]
				@OrderID = @OrderID,
				@ProductID = @ProductID,
				@Quantity = @Quantity,
				@Discount = @Discount,
				@UnitPrice = @UnitPrice,
				@OrderDetailStatusID = @OrderDetailStatusID,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT; 
			Set @LocalID = @OrderDetailID;
		END

 	ELSE If @CRUDType = 2 -- The default
		BEGIN
			EXEC [dbo].Z_SelectOrderDetail
				@OrderDetailID = @OrderDetailID, 
				--@OrderID = @OrderID,
				--@ProductID = @ProductID,
				--@Quantity = @Quantity,  
				--@Discount = @Discount,
				--@UnitPrice = @UnitPrice, 
				--@OrderDetailStatusID = @OrderDetailStatusID,
	
				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT; 
		END

	ELSE If @CRUDType = 3 
		BEGIN
			EXEC [dbo].Z_UpdateOrderDetail
				@OrderDetailID = @OrderDetailID,
				@ProductID = @ProductID,
				@Quantity = @Quantity,
				@Discount = @Discount,
				@UnitPrice = @UnitPrice,
				@OrderDetailStatusID = @OrderDetailStatusID,

				@LocalID = @LocalID OUTPUT, 
				@ErrorCode = @LocalErrorCode OUTPUT, 
				@Message = @LocalMessage OUTPUT;
			Set @LocalID = @OrderDetailID;
		END

	ELSE If @CRUDType =  4 
		BEGIN
			EXEC [dbo].[Z_DeleteOrderDetail]
				@OrderDetailID = @OrderDetailID,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;
				Set @LocalID = @OrderDetailID;
		END

		SET @UnifiedID = @LocalID;
		SET @ErrorCode = @LocalErrorCode;
		SET @Message = @LocalMessage;
    
	End Try
	BEGIN CATCH
		-- NO SELECT HERE! Only set OUTPUT parameters
		SET @LocalID = @OrderDetailID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		
		-- Return empty result set with correct structure for consistency
		SELECT 
		   CAST(NULL AS int) AS [OrderDetailID]
		  ,CAST(NULL AS int) AS [OrderID]
		  ,CAST(NULL AS int) AS [ProductID]
		  ,CAST(NULL AS int) AS [Quantity]
		  ,CAST(NULL AS money) AS [UnitPrice]
		  ,CAST(NULL AS decimal(6,3)) AS [Discount]
		  ,CAST(NULL AS int) AS [OrderDetailStatusID]
		WHERE 1 = 0; -- This ensures no rows are returned but structure is maintained
	END CATCH

END
GO
/****** Object:  StoredProcedure [BackupSPs].[CRUDPurchaseOrders]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		George Hepworth
-- Create date: 5/24/2025
-- Description:	Master CRUD for Purchase Orders
-- =============================================
CREATE PROCEDURE [BackupSPs].[CRUDPurchaseOrders]
	@CrudType as int = 2, --Read by default to avoid irrational data changes 
	
	@PurchaseOrderID AS int =0,
	@VendorID AS int = NULL,
	@SubmittedByID AS int= NULL,
	@SubmittedDate AS datetime= NULL,
	@ApprovedByID  AS int= NULL,
	@ApprovedDate AS  datetime= NULL,
	@StatusID  AS int = NULL,
	@ReceivedDate  AS datetime= NULL,
	@ShippingFee AS  money = NULL,
	@TaxAmount  AS money = NULL,
	@PaymentDate  AS datetime = NULL,
	@PaymentAmount  AS money = NULL,
	@PaymentMethod  AS nvarchar(50)= NULL,
	@Notes  AS nvarchar(max) = NULL,

	@UnifiedID As Int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 

AS
BEGIN
	BEGIN Try

		DECLARE
			@LocalID as int,
			@LocalErrorCode as INT,
			@LocalMessage as NVarChar(400);

		If @CrudType = 1
		BEGIN
			Exec dbo.Z_AddPO
				 @VendorID =@VendorID
				,@SubmittedByID = @SubmittedByID
				,@ApprovedByID = @ApprovedByID
				,@StatusID = 3  
				,@ShippingFee = @ShippingFee
				,@TaxAmount = @TaxAmount
				,@PaymentAmount = @PaymentAmount
				,@PaymentMethod = @PaymentMethod
				,@Notes = @Notes

				,@LocalID = @LocalID OUTPUT -- on Success, a new PK is passed back out as @LocalID
				,@ErrorCode = @LocalErrorCode OUTPUT
				,@Message = @LocalMessage OUTPUT;	
		END
		If @CrudType = 2
		BEGIN
			Exec [dbo].[Z_SelectPO] 
				@PurchaseOrderID = @PurchaseOrderID , 

				@LocalID = @LocalID OUTPUT, 
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	
		END
		If @CrudType = 3
		BEGIN
			Exec  [dbo].[Z_UpdatePO]
				 @PurchaseOrderID = @PurchaseOrderID
				,@SubmittedByID = @SubmittedByID
				,@SubmittedDate = @SubmittedDate
				,@ApprovedByID = @ApprovedByID
				,@ApprovedDate = @ApprovedDate
				,@ReceivedDate = @ReceivedDate
				,@ShippingFee = @ShippingFee
				,@TaxAmount = @TaxAmount
				,@PaymentDate = @PaymentDate
				,@PaymentAmount = @PaymentAmount
				,@PaymentMethod = @PaymentMethod
				,@Notes = @Notes
				,@VendorID = @VendorID
				,@StatusID= @StatusID

				,@LocalID = @LocalID OUTPUT 
				,@ErrorCode = @LocalErrorCode OUTPUT
				,@Message = @LocalMessage OUTPUT;	
		END
		If @CrudType = 4
		BEGIN
			Exec [dbo].[Z_DeletePO]
				@PurchaseOrderID = @PurchaseOrderID,
	
				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	
		END

		SET @UnifiedID = @LocalID;
		SET @ErrorCode = @LocalErrorCode;
		SET @Message = @LocalMessage;
	End Try
	Begin Catch
	
		SET @LocalID = @PurchaseOrderID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		End Catch

END
GO
/****** Object:  StoredProcedure [BackupSPs].[CustomErrorMessage_V2]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [BackupSPs].[CustomErrorMessage_V2]
    @SysErrorCode AS INT,
    @CurrentObject AS NVARCHAR(120) = 'Object',
    @CustomErrorCode AS INT = 0 OUTPUT,
    @CustomErrorMessage AS NVARCHAR(400) = 'Unknown Error in {0}' OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Input validation
    IF @SysErrorCode IS NULL
    BEGIN
        SET @CustomErrorCode = -1;
        SET @CustomErrorMessage = 'Invalid input: @SysErrorCode cannot be NULL';
        RETURN;
    END
    
    -- Ensure @CurrentObject has a default value if NULL
    IF @CurrentObject IS NULL OR LTRIM(RTRIM(@CurrentObject)) = ''
        SET @CurrentObject = 'Object';
    
    BEGIN TRY
        DECLARE @SysErrorMessage AS NVARCHAR(400);
        
        -- Retrieve error message from SSErrors table
        SELECT @SysErrorMessage = SSError
        FROM dbo.SSErrors WITH (NOLOCK)
        WHERE SSErrorID = @SysErrorCode;
        
        -- Handle case where error code is not found
        IF @SysErrorMessage IS NULL
            SET @SysErrorMessage = 'Unknown Error in {0}';
        
        -- Set output parameters
        SET @CustomErrorCode = @SysErrorCode;
        SET @CustomErrorMessage = REPLACE(@SysErrorMessage, '{0}', @CurrentObject);
        
    END TRY
    BEGIN CATCH
        -- In case of any error during execution, return system error info
        SET @CustomErrorCode = ERROR_NUMBER();
        SET @CustomErrorMessage = CONCAT('Error in CustomErrorMessage procedure: ', ERROR_MESSAGE());
        
        -- Log the error for debugging (optional - uncomment if you have error logging)
        /*
        INSERT INTO ErrorLog (ErrorNumber, ErrorMessage, ProcedureName, ErrorDate)
        VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), 'CustomErrorMessage', GETDATE());
        */
        
    END CATCH
END
GO
/****** Object:  StoredProcedure [BackupSPs].[ProductList]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
=============================================
Author:		 George Hepworth
Create date: 4/1/2025
Description: Product list with details 
=============================================
*/
CREATE  PROCEDURE [BackupSPs].[ProductList] 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 	
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT P.ProductID
			, P.ProductCode
			, P.ProductName
			, P.ProductDescription
			, P.NoStock
			, P.Allocated
			, P.ToSell
			, P.QuantityOnOrder
			, P.StandardUnitCost
			, P.UnitPrice
			, P.ReorderLevel
			, P.TargetLevel
			, P.MinimumReorderQuantity
			, P.QuantityPerUnit
			, P.Discontinued
			, P.ProductCategoryID
			, P.ProductCategoryName
		FROM vw_ProductList AS P;  
		SET @ErrorCode = 0;
		SET @Message = 'Selected Products';
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT P.ProductID
			, P.ProductCode
			, P.ProductName
			, P.ProductDescription
			, P.NoStock
			, P.Allocated
			, P.ToSell
			, P.QuantityOnOrder
			, P.StandardUnitCost
			, P.UnitPrice
			, P.ReorderLevel
			, P.TargetLevel
			, P.MinimumReorderQuantity
			, P.QuantityPerUnit
			, P.Discontinued
			, P.ProductCategoryID
			, P.ProductCategoryName
		FROM vw_ProductList AS P
		WHERE 1=0;
	END Catch
END
GO
/****** Object:  StoredProcedure [BackupSPs].[UpdatePOStatus]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		George Hepworth
-- Create date: 4/24/2025
-- Description:	Validate PO Status at various stages
-- =============================================
CREATE PROCEDURE [BackupSPs].[UpdatePOStatus]
	
	 @PurchaseOrderID as int 
	,@SubmittedByID as int = Null
	,@SubmittedDate as datetime = Null
	,@ApprovedByID as int = Null
	,@ApprovedDate as Datetime = Null
	,@ReceivedDate As DateTime = Null
	,@ShippingFee As money = Null
	,@TaxAmount AS money = Null
	,@PaymentDate As DateTime = Null
	,@PaymentAmount AS money = Null
	,@PaymentMethod as nvarchar(50) = Null
	,@Notes AS nvarchar(max) = Null
	,@VendorID  as Int = Null

	,@LocalID as int = 0 OUTPUT

	,@ErrorCode AS int = 0 OUTPUT
	,@Message AS nvarchar(400) = 'Purchase Order Status' OUTPUT

AS
BEGIN

	BEGIN TRY
	
		SET @LocalID=@PurchaseOrderID;
		SET NOCOUNT ON;	
	
		Declare	@DatetoUpdate as Nvarchar(40),
				@strSQL as Nvarchar(400),
				@CurrentSubmittedDate as datetime,
				@CurrentApprovedDate as datetime,
				@CurrentReceivedDate as datetime,
				@CurrentPaymentDate as datetime,
				@CurrentStatusID as int,
				@CurrentLineItems as int,
				@CurrentShipFee as money,
				@NewStatusID as int,
				@NewSubmittedDate as datetime,
				@NewApprovedDate as datetime,
				@NewPaymentDate as datetime,
				@NewReceivedDate as datetime,
				@Error as nvarchar(180);
	
--Step 1:--	Correct incoming 0 dates to null dates
--			PowerApps sends Nulls as Blanks() which can end up 
--			being interpreted as 0, or 1900-01-01 00:00:00.000 
--			Date validation fails because of this problem
--Note: Currently for POs, no dates are passed as parameters. In future, if we implement an Admin Override,
--       this will become required.

		SET @NewSubmittedDate = CASE WHEN Cast(@SubmittedDate as int) = 0 THEN NULL ELSE @SubmittedDate END;
		SET @NewApprovedDate = CASE WHEN Cast(@ApprovedDate as int) = 0 THEN NULL ELSE @ApprovedDate END;
		SET @NewPaymentDate = CASE WHEN Cast(@PaymentDate as int) = 0 THEN NULL ELSE @PaymentDate END;
		SET @NewReceivedDate = CASE WHEN Cast(@ReceivedDate as int) = 0 THEN NULL ELSE @ReceivedDate END;
		 
--Use only these parameters in the remainder of the procecedure

--Step 2: Validate the PO has one or more line items 
		BEGIN
		SELECT @CurrentLineItems = COUNT(*)
		FROM	PurchaseOrderDetails
		WHERE	PurchaseOrderID = @PurchaseOrderID;	

		IF @CurrentLineItems = 0
			Throw   51230,'Purchase Orders cannot be submitted 
			    without one or more Order Details ', 16; 

--Step 3: Validate the Shipping Fee is supplied or previously recorded 
--        before allowing a PO to be submitted.
--        While we're at it, get an current dates for later comparisons
		Select	
			@CurrentSubmittedDate = SubmittedDate,
			@CurrentApprovedDate = ApprovedDate, 
			@CurrentReceivedDate = ReceivedDate,
			@CurrentPaymentDate =  PaymentDate,
			@CurrentStatusID = StatusID,
			@CurrentShipFee = ShippingFee
		FROM	PurchaseOrders
		WHERE	PurchaseOrderID = @PurchaseOrderID;

		IF  @CurrentShipFee Is Null and @ShippingFee  Is Null
			Throw   51260,'Purchase Orders cannot be submitted 
				without a Shipping Fee ',16;
		END
--Step 4: For Admin override only, validate that steps are completed in the correct order
--        
--4a: If the PO has not previously been submitted, it can not be approved
	If @CurrentSubmittedDate Is Null  
		AND @NewApprovedDate Is Not Null
		Throw   51200,'Purchase Orders cannot be approved before they are submitted',16;


 
--4b: If The stored ApprovedDate and the proposed ApprovedDate are both Null,
--       no additional dates can be saved. I.e. Logically, Approval precedes Receipt and Payment
	If	
		(@CurrentApprovedDate Is Null AND @NewApprovedDate Is Null)
		AND 
		(
			@NewReceivedDate Is Not Null  OR
			@NewPaymentDate Is Not Null
			)  
		Throw   51210, 'Purchase Orders cannot be received or paid 
			before they been approved '  ,16;

--4c: If there is a stored SubmittedDate or a new proposed SubmittedDate is provided 
--       as well as a new proposed ApprovalDate, the new dates must be in sequence--
--       Submitted then Approved
		IF	(@CurrentSubmittedDate Is Not Null OR 
			@NewSubmittedDate Is Not Null) AND 
			(@NewApprovedDate Is Not Null OR @CurrentApprovedDate Is Not Null )
			IF	(@CurrentSubmittedDate > @NewApprovedDate)  OR 
				(@NewSubmittedDate > @CurrentApprovedDate) OR
				(@NewSubmittedDate > @NewApprovedDate)
			THROW   51220, 'The Submitted Date must be the earliest date for the PO',16 ;	
			
--4d: If there is a stored ApprovedDate or new proposed ApprovalDate or new proposed ReceivedDate
--	    the new proposed Approval and Receipt dates must be in sequence--
--       Approved then Received
		IF  (@CurrentApprovedDate Is Not NULL OR
			@NewApprovedDate Is Not NULL) AND
			(@NewReceivedDate Is Not NULL Or @CurrentReceivedDate Is Not Null)
			IF	(@CurrentApprovedDate > @NewReceivedDate) OR
				(@NewApprovedDate > @CurrentReceivedDate) OR  
				(@NewApprovedDate > @NewReceivedDate) 
				THROW   51240, 'The Approved Date must be before the Received Date for the PO',16 ;

--4e: If there is a stored ApprovedDate or new proposed ApprovalDate or new proposed PaymentDate
--	    the new proposed Approval and Payment dates must be in sequence--
--       Approved then Paid
		IF  (@CurrentApprovedDate Is Not NULL  OR
			@NewApprovedDate Is Not NULL)  AND
			(@NewPaymentDate Is Not NULL OR @CurrentPaymentDate Is Not Null)
			IF	(@CurrentApprovedDate > @NewPaymentDate) OR
				(@NewApprovedDate > @CurrentPaymentDate) OR  
				(@NewApprovedDate > @NewPaymentDate) 
				THROW   51250, 'The Approved Date must be on before the Payment Date for the PO',16 ;


--Step 5: Determine appropriate StatusID based on the latest date.
--          Default to current Status, i.e. no change in status
--        We check for the first null date in the sequence, assuming that any subsequent
--          dates will therefore be null as well.

--        Future Admin override also checks for replacement dates if supplied
		SET @NewStatusID =  @CurrentStatusID;
		If  @CurrentSubmittedDate Is Null OR @NewSubmittedDate Is Not  Null
			SET @NewStatusID = 4 -- Status = "Submitted"		  
		ELSE If  @CurrentApprovedDate IS Null OR @NewApprovedDate Is Not Null
			SET @NewStatusID = 1 -- Status = "Approved"
		ELSE If  @CurrentReceivedDate IS  Null OR @NewReceivedDate  Is Not Null 
			SET @NewStatusID = 5 -- Status = "Received"
		ELSE If @CurrentPaymentDate IS  Null OR @NewPaymentDate Is Not Null --we are recording payment to close the invoice
			Set @NewStatusID = 2 --Status = "Closed";
		If @NewStatusID = 4
			BEGIN
			Set @NewSubmittedDate= GetDate();
			END
		ELSE If @NewStatusID = 1
			BEGIN
			Set @NewApprovedDate= GetDate();
			END
		ELSE If @NewStatusID = 5
			Set @NewReceivedDate= GetDate()
	ELSE If @NewStatusID = 2
			Set @NewPaymentDate= GetDate()
	If @NewStatusID =4 AND @SubmittedByID Is Null
	Throw 51300, 'To Submit the Purchase Order, select the Submitter',16;
	If @NewStatusID = 1 and (@ApprovedByID Is Null OR @ApprovedByID=0)
	Throw 52310, 'To approve the Purchase Order, select the approver',16;

	Exec dbo.Z_UpdatePO
		 @PurchaseOrderID = @PurchaseOrderID
		,@SubmittedByID = @SubmittedByID
		,@SubmittedDate = @NewSubmittedDate
		,@ApprovedByID = @ApprovedByID
		,@ApprovedDate = @NewApprovedDate
		,@ReceivedDate = @NewReceivedDate
		,@ShippingFee = @ShippingFee
		,@TaxAmount = @TaxAmount
		,@PaymentDate = @NewPaymentDate
		,@PaymentAmount = @PaymentAmount
		,@PaymentMethod = @PaymentMethod
		,@Notes = @Notes
		,@VendorID  = @VendorID
		,@StatusID = @NewStatusID

		,@LocalID = @LocalID OUTPUT
		,@ErrorCode = @ErrorCode OUTPUT
		,@Message = @Message OUTPUT	
	

		SET @LocalID = @PurchaseOrderID;
		SET	@ErrorCode = 0 ;
		SET	@Message  = 'Updated Purchase Order ' + cast(@LocalID as nvarchar(12));
		

	End Try

	BEGIN Catch

		SET @LocalID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();

	END Catch	
END
GO
/****** Object:  StoredProcedure [dbo].[AddNewProductToStockTake]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
=============================================
 Author:		George Hepworth
 Create date: 4/22/2025
 Description:	When adding a new product, 
				create an initial stocktake record 
				with 0 quantity and 0 Expected
 =============================================
*/
CREATE PROCEDURE [dbo].[AddNewProductToStockTake] 
	@ProductID as int =0,
	
	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Added to Stocktake' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE @LastStockTakeDate as date;
			BEGIN TRANSACTION;
				SELECT @LastStockTakeDate = Max([StockTakeDate]) 
				FROM [dbo].[StockTake]
				WHERE ProductID = @ProductID;
				IF @LastStockTakeDate IS NULL
					BEGIN
						SELECT @LastStockTakeDate = IsNull(AddedOn,GetDate())
						FROM Products
						WHERE ProductID = @ProductID;
						INSERT INTO [dbo].[StockTake]
						(
							StockTakeDate,
							ProductID,
							QuantityOnHand,
							ExpectedQuantity
						)
						VALUES 
						(
							@LastStockTakeDate,
							@ProductID,
							0,
							0
						);
						SET @LocalID = @ProductID;
						SET	@ErrorCode = 0 ;
						SET	@Message = 'Added StockTake for product ' + Cast(@ProductID as nvarchar(10)); 
					END

				SET @LocalID = @ProductID;
				SET	@ErrorCode = 0 ;
				SET	@Message = ' StockTake exists for product'; 
			Commit Transaction;
	END Try
	BEGIN Catch
		IF @@TRANCOUNT > 0
				ROLLBACK TRANSACTION;
		SET @LocalID = @ProductID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[AllocateInventory]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George Hepworth
-- Create date: 4/24/2025
-- Description:	Allocate Products received in a New PO Details to orders awaiting fulfillment
-- =============================================
CREATE PROCEDURE [dbo].[AllocateInventory]
	@ProductID as int = 0,
	
	@LocalID as int OUTPUT, 
	@LocalErrorCode AS int = 0 OUTPUT,
	@LocalMessage AS nvarchar(400) = 'Allocated Inventory' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;	
	BEGIN Try 
		SET @LocalID = @ProductID;
		SET @LocalErrorCode = 0;
		DECLARE 
				@ThisOrderQuantity as int,
				@LocalOrderID as INT,
				@LocalOrderDetailID as int,
				@ThisOrderProductID as int,
				@ProductUpdateID as int,
				@ProductAvailable as int,
				@ProductOnOrder as int ,
				@ProductProjected as int,
				@QuantityToAllocate as int ,
				@LocalProductOnOrder as int,
				@OrderDetailStatusID as int,
				@LocalProductAvailableToSell as int,
				@LastStockTakeDate as date,
				@LocalLastStockTakeDate as date,
				@LocalLastStockTakeQOH as int,
				@CustomErrorCode as int,
				@CustomErrorMessage as nvarchar(400);
		BEGIN TRANSACTION;
			BEGIN 
				--Get parameters for the current allocation from appropriate Stored Procedures:
				--LastStockTakeDate, ProductAvailable in Stock, and ProductOnOrder
				--Get the last StockTake date for the product
				Exec [dbo].[ProductLastStockTakeDateQOH]
					@ProductID = @ProductID,
					@LocalID = @ProductID,
					@LastStockTakeDate = @LocalLastStockTakeDate OutPut,
					@LastStockTakeQOH = @LocalLastStockTakeQOH OutPUT,
					@LocalErrorCode= @LocalErrorCode,
					@LocalMessage = @LocalMessage;
			
				--Get the currently available quantity of the product 
				--Prior to receipt of this PO
				Exec [dbo].ProductAvailable
					@ProductID = @ProductID,
					@CurrentOrder = 0,
					@LastStockTakeQOH= 0 ,
					@ProductBoughtSinceLastStockTake = 0 ,
					@ProductSold = 0 ,
					@LocalProductAvailableToSell = @LocalProductAvailableToSell OUTPUT,
					@AvailableProductID = 0 ,
					@LocalErrorCode = @LocalErrorCode OUTPUT,
					@LocalMessage = @LocalMessage OUTPUT ;

				SET @ProductAvailable= IsNull(@LocalProductAvailableToSell,0);
				--Get the quantity on Order and not yet received
				Exec [dbo].[ProductOnOrder]
					@ProductID = @ProductID,
					@LocalProductOnOrder = @LocalProductOnOrder OUTPUT,
					@LocalErrorCode = @LocalErrorCode OUTPUT,
					@LocalMessage = @LocalMessage OUTPUT 
				SET @ProductOnOrder = IsNull(@LocalProductOnOrder,0);
			
				--Sum the amount available + the amount on order to get Quantity available to allocate
				SET @QuantityToAllocate = @ProductAvailable + @ProductOnOrder;
		END
		-- We have the amounts we need to allocate available product to orders asking for it
		BEGIN 
			IF CURSOR_STATUS('local', 'UpdateProducts') >= 0
				BEGIN
					CLOSE UpdateProducts;
					DEALLOCATE UpdateProducts;
				END
				DECLARE UpdateProducts CURSOR Fast_Forward FOR
					SELECT od.OrderDetailID,
							od.Quantity
					FROM OrderDetails od 
					INNER JOIN Orders o ON o.OrderID = od.OrderID 
					WHERE od.ProductID = @ProductID AND od.OrderDetailStatusID in ( 4, 5) -- 4 = No Stock, 5 = On Order
					ORDER BY o.OrderDate, o.OrderID;
					OPEN UpdateProducts;
					FETCH NEXT FROM UpdateProducts 
					INTO @LocalOrderDetailID, @ThisOrderQuantity;
					;
					WHILE @@FETCH_STATUS = 0
					BEGIN	-- Update each order in turn in the cursor
						If @ThisOrderQuantity <= @ProductAvailable
							BEGIN
								Update OrderDetails
								SET OrderDetailStatusID = 1 -- Allocated
								WHERE OrderDetailID = @LocalOrderDetailID;
								--
								SET @QuantityToAllocate = @QuantityToAllocate - @ThisOrderQuantity
								SET @ProductAvailable = @ProductAvailable - @ThisOrderQuantity; 
							END
						Else If @ThisOrderQuantity <= @QuantityToAllocate -- Remainder after allowing for allocated orders
							BEGIN
								Update OrderDetails
								SET OrderDetailStatusID = 5 --On Order
								WHERE OrderDetailID = @LocalOrderDetailID;

								SET @QuantityToAllocate = @QuantityToAllocate-@ThisOrderQuantity;
							END
						ELSE
							BEGIN
								Update OrderDetails
								SET OrderDetailStatusID = 4 --No Stock
								WHERE OrderDetailID = @LocalOrderDetailID ;
							END
						FETCH NEXT FROM UpdateProducts 
						INTO @LocalOrderDetailID, @ThisOrderQuantity;
				END	
				CLOSE UpdateProducts;
				DEALLOCATE UpdateProducts;
			END
			COMMIT TRANSACTION;
			SET @LocalMessage = 
				'Successfully allocated inventory for ProductID: ' + 
				CAST(@ProductID AS VARCHAR);
		End Try

		BEGIN Catch
			IF @@TRANCOUNT > 0
				ROLLBACK TRANSACTION;
			IF CURSOR_STATUS('local', 'UpdateProducts') >= 0
				BEGIN
					CLOSE UpdateProducts;
					DEALLOCATE UpdateProducts;
				END
				SET @LocalID = @ProductID;
				SET @LocalErrorCode = ERROR_NUMBER();
				SET @LocalMessage = ERROR_MESSAGE();
				EXEC CustomErrorMessage
					@SysErrorCode = @LocalErrorCode,
					@CurrentObject = 'Inventory Allocation',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;
				SET @LocalErrorCode = Coalesce(@CustomErrorCode,@LocalErrorCode);
				SET @LocalMessage = Coalesce(@CustomErrorMessage,@LocalMessage);
		END Catch
 
END
GO
/****** Object:  StoredProcedure [dbo].[AuditTriggers]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George Hepworth
-- Create date: 3/3/2025
-- Description:	Manage Triggers so PowerApps can Patch SQL Server tables w/triggers
-- NOTE: Disabling triggers bypasses auditing, so only use it as a last resort
-- =============================================
CREATE PROCEDURE [dbo].[AuditTriggers]
	@TableName as NVarchar(100),
	@TriggerName as NVarchar(100),
	@OnOff As NVarchar(8),
	@Result AS NVarchar(500) OUTPUT
	 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		Declare @StrSQL as NVarchar(200)
		SET @StrSQL = @OnOff + ' TRIGGER ' + @TriggerName + ' ON ' + @TableName;
		Print @StrSQL;
 
		EXEC( @strSQL );
	END Try
	BEGIN Catch
		SELECT @Result = 'Error Number: ' + Cast(ERROR_NUMBER() as nvarchar(10)) +
			' Error Message: ' +ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[CompaniesFieldName]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
=============================================
 Author:	 George Hepworth
 Create date: 06/11/2025
 Description: Companies Table Field Names
			 Used in Show/Hide Feature
=============================================
*/
CREATE PROCEDURE [dbo].[CompaniesFieldName]
 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
	AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
	DECLARE @CustomErrorCode as int,
			@CustomErrorMessage as Nvarchar(400);
		SELECT [TableName]
				,[FieldName]
		FROM [dbo].[vw_CompaniesFieldNames];
				SET @ErrorCode = 0;
				SET @Message = 'Success';
	END Try
 	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		EXEC CustomErrorMessage
			@SysErrorCode = @ErrorCode,
			@CurrentObject = 'Orders',
			@CustomErrorCode = @CustomErrorCode OUTPUT,
			@CustomErrorMessage = @CustomErrorMessage OUTPUT;
		SET @ErrorCode = Coalesce(@CustomErrorCode,@ErrorCode);
		SET @Message = Coalesce(@CustomErrorMessage,@Message);

	END Catch

END
GO
/****** Object:  StoredProcedure [dbo].[CompanyContacts]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
 Author:	 George Hepworth
 Create date: 2025-05-14
 Description: Companies and contacts
-- =============================================
*/
CREATE PROCEDURE [dbo].[CompanyContacts]

	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try 
		SELECT CP.CompanyName, 
		CN.ContactID, 
		CN.CompanyID, 
		CN.FirstName,
		CN.LastName, 
		dbo.fn_FullName(CN.FirstName ,CN.LastName) as FullName,
		CN.EmailAddress, 
		CN.JobTitle,
		CN.PrimaryPhone, 
		CN.SecondaryPhone, 
		CN.Notes
		FROM dbo.Companies AS CP INNER JOIN
			 dbo.Contacts AS CN ON CP.CompanyID = CN.CompanyID
		ORDER BY CN.CompanyID,CN.LastName,CN.FirstName;
		SET	@ErrorCode = 0;
		SET	@Message = 'Success';
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT CP.CompanyName, 
		CN.ContactID, 
		CN.CompanyID, 
		CN.FirstName,
		CN.LastName, 
		CN.FirstName + ' ' + CN.LastName as FullName,
		CN.EmailAddress, 
		CN.JobTitle,
		CN.PrimaryPhone, 
		CN.SecondaryPhone, 
		CN.Notes
		FROM dbo.Companies AS CP INNER JOIN
					dbo.Contacts AS CN ON CP.CompanyID = CN.CompanyID
		WHERE 1 = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[CompanyTypesList]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 2025-05-14
Description: Company Types List
-- =============================================
*/
CREATE PROCEDURE [dbo].[CompanyTypesList] 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT [CompanyTypeID]
			 ,[CompanyType]
		FROM [dbo].[CompanyTypes];
		SET	@ErrorCode = 0;
		SET	@Message = 'Success';
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT [CompanyTypeID]
		 ,[CompanyType]
		FROM [dbo].[CompanyTypes]
		WHERE 1 = 0;
	END Catch

END
GO
/****** Object:  StoredProcedure [dbo].[CRUDCompany]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CRUDCompany]
 @CrudType INT = 2, 
 @CompanyID INT = 0, 
 @CompanyName NVARCHAR (50) = NULL, 
 @CompanyTypeID INT = NULL, 
 @BusinessPhone NVARCHAR (20) = NULL, 
 @Address NVARCHAR (255) = NULL, 
 @City NVARCHAR (255) = NULL, 
 @StateAbbrev NVARCHAR (2) = NULL, 
 @Zip NVARCHAR (10) = NULL, 
 @Website NVARCHAR (1024) = NULL, 
 @Notes NVARCHAR (MAX) = NULL, 
 @StandardTaxStatusID INT = -1, 
 @UnifiedID INT = 0 OUTPUT, 
 @ErrorCode INT = 0 OUTPUT, 
 @Message NVARCHAR (400) = 'Success' OUTPUT
AS
BEGIN
 SET NOCOUNT ON;
 BEGIN TRY
 DECLARE @LocalID AS INT, @LocalErrorCode AS INT, @LocalMessage AS NVARCHAR (400), @CustomErrorCode AS INT, @CustomErrorMessage AS NVARCHAR (400);
 IF @CrudType = 1
 EXECUTE [dbo].[Z_AddCompany] @CompanyName = @CompanyName, @CompanyTypeID = @CompanyTypeID, @BusinessPhone = @BusinessPhone, @Address = @Address, @City = @City, @StateAbbrev = @StateAbbrev, @Zip = @Zip, @Website = @Website, @Notes = @Notes, @StandardTaxStatusID = @StandardTaxStatusID, @LocalID = @LocalID OUTPUT, @ErrorCode = @LocalErrorCode OUTPUT, @Message = @LocalMessage OUTPUT;
 ELSE
 IF @CrudType = 2
 EXECUTE [dbo].[Z_SelectCompany] @CompanyID = @CompanyID, @CompanyTypeID = @CompanyTypeID, @StandardTaxStatusID = @StandardTaxStatusID, @StateAbbrev = @StateAbbrev, @CompanyName = @CompanyName, @City = @City, @LocalID = @LocalID OUTPUT, @ErrorCode = @LocalErrorCode OUTPUT, @Message = @LocalMessage OUTPUT;
 ELSE
 IF @CrudType = 3
 EXECUTE dbo.Z_UpdateCompany @CompanyID = @CompanyID, @CompanyName = @CompanyName, @CompanyTypeID = @CompanyTypeID, @BusinessPhone = @BusinessPhone, @Address = @Address, @City = @City, @StateAbbrev = @StateAbbrev, @Zip = @Zip, @Website = @Website, @Notes = @Notes, @StandardTaxStatusID = @StandardTaxStatusID, @LocalID = @LocalID OUTPUT, @ErrorCode = @LocalErrorCode OUTPUT, @Message = @LocalMessage OUTPUT;
 ELSE
 IF @CrudType = 4
 EXECUTE dbo.Z_DeleteCompany @CompanyID = @CompanyID, @LocalID = @LocalID OUTPUT, @ErrorCode = @LocalErrorCode OUTPUT, @Message = @LocalMessage OUTPUT;
 SET @UnifiedID = @LocalID;
 IF @LocalErrorCode = 0
 BEGIN
 SET @ErrorCode = @LocalErrorCode;
 SET @Message = @LocalMessage;
 END
 ELSE
 BEGIN
 EXECUTE CustomErrorMessage @SysErrorCode = @LocalErrorCode, @CurrentObject = 'Company', @CustomErrorCode = @CustomErrorCode OUTPUT, @CustomErrorMessage = @CustomErrorMessage OUTPUT;
 SET @ErrorCode = @CustomErrorCode;
 SET @Message = @CustomErrorMessage;
 END
 END TRY
 BEGIN CATCH
 SET @UnifiedID = 0;
 SET @ErrorCode = ERROR_NUMBER();
 SET @Message = ERROR_MESSAGE();
 END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[CRUDEmployee]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/1/2025
Description: CRUD operations on Employees
-- =============================================
*/
CREATE PROCEDURE [dbo].[CRUDEmployee] 
	/*CRUDTypes
		Create = 1 Requires values for all required fields, or defaults if not provided
		Read = 2 Requires the PK of the record to be Read as 0 for all, non-0 for one selected employee
		 Default to Read only. Don't mess with stored values by accident
		Update = 3 Requires values for any field or fields to be updated
		Delete = 4 Requires only the PK of the record to be deleted
	*/
	@CrudType AS int = 2, 
	@EmployeeID as Int = 0,
	@FirstName nvarchar(20) = Null,
	@LastName nvarchar(30)= Null,
	@EmailAddress nvarchar(255) = Null,
	@JobTitle nvarchar(50) = Null,
	@PrimaryPhone nvarchar(20) = Null,
	@SecondaryPhone nvarchar(20) = Null,
	@Title nvarchar(20) = Null,
	@Notes nvarchar(4000) = Null,
	@SupervisorID int = 0,
	@WindowsUserName nvarchar(50) = Null,
	@EmployeeImageName nvarchar(80) = null,
	@EmployeeImagePA image = null,

	@UnifiedID As Int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE
			@LocalID as int,
			@LocalErrorCode as INT,
			@LocalMessage as NVarChar(400),
			@CustomErrorCode as int,
			@CustomErrorMessage as NVarChar(400);
		If @CrudType = 1 
			EXEC [dbo].[Z_AddEmployee]
				@FirstName = @FirstName ,
				@LastName = @LastName,
				@EmailAddress = @EmailAddress,
				@JobTitle = @JobTitle,
				@PrimaryPhone = @PrimaryPhone,
				@SecondaryPhone = @SecondaryPhone,
				@Title = @Title,
				@Notes = @Notes,
				@SupervisorID = @SupervisorID,
				@WindowsUserName = @WindowsUserName, 

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 
		ELSE If @CrudType = 2 
			EXEC [dbo].[Z_SelectEmployee]
				@EmployeeID = @EmployeeID,
				@FirstName =@FirstName,
				@LastName =@LastName,
				@JobTitle =@JobTitle,
				@SupervisorID =@SupervisorID,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 
		ELSE If @CrudType = 3 
			EXEC [dbo].Z_UpdateEmployee
				@EmployeeID = @EmployeeID,
				@FirstName = @FirstName ,
				@LastName = @LastName ,
				@EmailAddress = @EmailAddress,
				@JobTitle = @JobTitle,
				@PrimaryPhone = @PrimaryPhone,
				@SecondaryPhone = @SecondaryPhone,
				@Title = @Title,
				@Notes = @Notes,
				@SupervisorID = @SupervisorID,
				@WindowsUserName = @WindowsUserName,
				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 
		ELSE If @CrudType = 4 
			EXEC [dbo].[Z_DeleteEmployee]
				@EmployeeID = @EmployeeID,
				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;

		SET @UnifiedID = @LocalID;		
		IF @LocalErrorCode= 0
			BEGIN
				SET @ErrorCode = @LocalErrorCode;
				SET @Message = @LocalMessage;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @LocalErrorCode,
					@CurrentObject = 'Employees',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;
				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
			END
	End Try
	BEGIN Catch
		SET @UnifiedID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDMRU]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 5/27/2025
Description: CRUD operations on MRUs
-- =============================================
*/
CREATE PROCEDURE [dbo].[CRUDMRU] 
	/*CRUDTypes
		Create = 1 Requires values for all required fields, or defaults if not provided
		Read = 2 Requires the PK of the record to be Read as 0 for all, non-0 for one selected MRU
		 Default to Read only. Don't mess with stored values by accident
		Update = 3 Requires values for any field or fields to be updated
		Delete = 4 Requires only the PK of the record to be deleted
	*/
	@CrudType AS int = 2,
 @MRU_ID AS int = 0,
	@EmployeeID as Int = 0,
	@TableName as nvarchar(50) = null,
	@PKValue as int = 0,
	@DateAdded as datetime = null,

	@UnifiedID As Int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE
			@LocalID as int,
			@LocalErrorCode as INT,
			@LocalMessage as NVarChar(400),
			@CustomErrorCode as Int,
			@CustomErrorMessage as nvarchar(400);
		If @CrudType = 1 
			EXEC [dbo].[Z_AddMRU] 
				@EmployeeID =@EmployeeID,
				@TableName =@TableName,
				@PKValue = @PKValue,
				@DateAdded = @DateAdded,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 
		ELSE If @CrudType = 2 
			EXEC [dbo].Z_SelectMRU
				@MRU_ID = @MRU_ID,
				@EmployeeID =@EmployeeID,
				@TableName = @TableName,
				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 		
		ELSE If @CrudType = 3 
			EXEC dbo.Z_UpdateMRU
				@MRU_ID = @MRU_ID,
				@EmployeeID =@EmployeeID,
				@TableName =@TableName,
				@PKValue = @PKValue,
				@DateAdded = @DateAdded,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT, 
				@Message = @LocalMessage OUTPUT;	 
		 ELSE If @CrudType = 4 
			EXEC dbo.Z_DeleteMRU
				@MRU_ID = @MRU_ID,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;

			SET @UnifiedID = @LocalID;
		IF @LocalErrorCode = 0
			BEGIN
				SET @ErrorCode = @LocalErrorCode;
				SET @Message = @LocalMessage;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @LocalErrorCode,
					@CurrentObject = 'MRU',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;
				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
	END	End Try
	BEGIN Catch
		SET @UnifiedID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDOrder]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/1/2025
Description: CRUD operations on Orders
=============================================
*/
CREATE PROCEDURE [dbo].[CRUDOrder] 
	/*CRUDTypes
		Create = 1 Requires values for all required fields, or defaults if not provided
		Read = 2 Requires the PK of the record to be Read as 0 for all, non-0 for one selected Order
		 Default to Read only. Don't mess with stored values by accident
		Update = 3 Requires values for any field or fields to be updated
		Delete = 4 Requires only the PK of the record to be deleted
	*/
	 @CRUDType as int = 2
	,@OrderID as int = 0 
	,@EmployeeID AS int =0 
	,@CustomerID AS int = 0
	,@OrderDate as datetime = Null
	,@OrderDateStart As nvarchar(30) = '1900-01-01 00:00:00'
	,@OrderDateEnd As nvarchar(30) = NULL
	,@InvoiceDate as Datetime = Null
	,@ShippedDate As DateTime = Null
	,@ShipperID as Int = 0
	,@ShippingFee As money = 0
	,@TaxRate AS Decimal(6,3) = 0
	,@TaxStatusID AS tinyint = null
	,@PaymentMethod as nvarchar(50) = Null
	,@PaidDate As DateTime = Null
	,@Notes AS nvarchar(max) = Null 
	,@OrderStatusID AS int = null,

	@UnifiedID As Int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE
			@LocalID as int,
			@LocalErrorCode as INT,
			@LocalMessage as NVarChar(400),
			@CustomErrorCode as Int ,
			@CustomErrorMessage as nvarchar(400);
		If @CrudType= 1 
			EXEC [dbo].[Z_AddOrder]
				 @EmployeeID =@EmployeeID 
				,@CustomerID = @CustomerID
				,@OrderDate = @OrderDate
				,@InvoiceDate = @InvoiceDate
				,@ShippedDate = @ShippedDate
				,@ShipperID = @ShipperID
				,@ShippingFee = @ShippingFee
				,@TaxRate = @TaxRate
				,@TaxStatusID = @TaxStatusID
				,@PaymentMethod = @PaymentMethod
				,@PaidDate = @PaidDate
				,@Notes =@Notes
				,@OrderStatusID = @OrderStatusID,
	
				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 
		ELSE If @CrudType = 2 
			BEGIN	
				EXEC [dbo].[Z_SelectOrder]
					@OrderID = @OrderID,
					@EmployeeID = @EmployeeID,
					@CustomerID = @CustomerID,
					@OrderDateStart = @OrderDateStart,
					@OrderDateEnd = @OrderDateEnd,
					@OrderStatusID = @OrderStatusID,
					@TaxRate = @TaxRate,
					@TaxStatusID = @TaxStatusID,
					@Notes = @Notes,
					@ShipperID = @ShipperID,
					@ShippingFee = @ShippingFee,
					@InvoiceDate = @InvoiceDate,
					@ShippedDate = @ShippedDate,
					@PaymentMethod = @PaymentMethod,
					@PaidDate = @PaidDate,
									 					 
					@LocalID = @LocalID OUTPUT,
					@ErrorCode = @LocalErrorCode OUTPUT,
					@Message = @LocalMessage OUTPUT;
			END	
		ELSE If @CrudType = 3 
			EXEC [dbo].Z_UpdateOrder
			 	 @OrderID = @OrderID
				,@InvoiceDate = @InvoiceDate
				,@ShippedDate = @ShippedDate
				,@ShipperID = @ShipperID
				,@ShippingFee = @ShippingFee
				,@TaxRate = @TaxRate
				,@TaxStatusID = @TaxStatusID
				,@PaymentMethod = @PaymentMethod
				,@PaidDate = @PaidDate
				,@Notes = @Notes 
				,@OrderStatusID = @OrderStatusID

				,@LocalID = @LocalID OUTPUT 
				,@ErrorCode = @LocalErrorCode OUTPUT 
				,@Message = @LocalMessage OUTPUT;	 
		 ELSE If @CrudType = 4 
			EXEC [dbo].[Z_DeleteOrder]
				@OrderID = @OrderID,
				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;
		SET @UnifiedID = @LocalID;
		IF @LocalErrorCode= 0
			BEGIN
				SET @ErrorCode = @LocalErrorCode;
				SET @Message = @LocalMessage;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @LocalErrorCode,
					@CurrentObject = 'Orders',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;

				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
			END
	End Try
	BEGIN Catch
		SET @UnifiedID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDOrderDetail]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 5/25/2025
Description: Replace CRUD Order Details 
=============================================
*/
CREATE PROCEDURE [dbo].[CRUDOrderDetail]
	/*CRUDTypes
		Create = 1 Requires values for all required fields, or defaults if not provided
		Read = 2 Requires the PK of the record to be Read as 0 for all, non-0 for one selected Order Detail
		 Default to Read only. Don't mess with stored values by accident
		Update = 3 Requires values for any field or fields to be updated
		Delete = 4 Requires only the PK of the record to be deleted
	*/
	 @CRUDType as int = 2
	,@OrderDetailID as int = 0
	,@OrderID as int = 0
	,@ProductID as int = 0
	,@Quantity as smallint = 0
	,@UnitPrice as money = 0
	,@Discount as decimal(6,3) = 0
	,@OrderDetailStatusID as int = null

	,@UnifiedID As Int = 0 OUTPUT
	,@ErrorCode AS int = 0 OUTPUT
	,@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE 
			@LocalID as int,
			--@LocalErrorCode as INT,
			--@LocalMessage as NVarChar(400),
			@ReturnValue as nvarchar(4000),
			@CustomErrorCode as Int,
			@CustomErrorMessage as nvarchar(400);
		If @CRUDType= 1 
			BEGIN
				EXEC dbo.Z_AddOrderDetail 
					@OrderID = @OrderID,
					@ProductID = @ProductID,
					@Quantity = @Quantity, 
					@Discount = @Discount , 
					@UnitPrice = @UnitPrice, 
					@OrderDetailStatusID = 1, -- status is new for new order details
				
					@LocalID = @LocalID OUTPUT, 
					@ErrorCode = @ErrorCode OUTPUT,
					@Message = @Message OUTPUT;
			END
		ELSE If @CRUDType= 2 
			BEGIN
				EXEC dbo.Z_SelectOrderDetail
					@OrderDetailID = @OrderDetailID,
					@OrderID = @OrderID,
					@ProductID = @ProductID,
					@Quantity = @Quantity, 
					@Discount = @Discount , 
					@UnitPrice = @UnitPrice, 
					@OrderDetailStatusID = @OrderDetailStatusID,

					@LocalID = @LocalID OUTPUT, 
					@ErrorCode = @ErrorCode OUTPUT,
					@Message = @Message OUTPUT;
			END
		ELSE If @CRUDType= 3 
			BEGIN
				EXEC dbo.Z_UpdateOrderDetail
					@OrderDetailID = @OrderDetailID,
					@OrderID = @OrderID,
					@ProductID = @ProductID,
					@Quantity = @Quantity,
					@Discount = @Discount,
					@UnitPrice = @UnitPrice, 
					@OrderDetailStatusID = @OrderDetailStatusID,

					@LocalID = @LocalID OUTPUT, 
					@ErrorCode = @ErrorCode OUTPUT,
					@Message = @Message OUTPUT;
			END
		ELSE If @CRUDType= 4 
			BEGIN
				EXEC dbo.Z_DeleteOrderDetail	
					@OrderDetailID = @OrderDetailID,

					@LocalID = @LocalID OUTPUT, 
					@ErrorCode = @ErrorCode OUTPUT,
					@Message = @Message OUTPUT;
			END
		SET @UnifiedID = @LocalID;
		IF @ErrorCode = 0
			BEGIN
				SET @ErrorCode = @ErrorCode;
				SET @Message = @Message;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @ErrorCode,
					@CurrentObject = 'Order Details',
					@CustomErrorCode = @ErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;
				SET @ErrorCode = @ErrorCode;
				SET @Message = @CustomErrorMessage;
			END
	End Try
	BEGIN Catch
		SET @LocalID = @OrderDetailID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	End Catch
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDProduct]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/19/2025
Description: CRUD operations on Products
=============================================
*/
CREATE PROCEDURE [dbo].[CRUDProduct] 
	/*CRUDTypes
		Create = 1 Requires values for all required fields, or defaults if not provided
		Read = 2 Requires the PK of the record to be Read as 0 for all, non-0 for one selected Product
		 Default to Read only. Don't mess with stored values by accident
		Update = 3 Requires values for any field or fields to be updated
		Delete = 4 Requires only the PK of the record to be deleted
	*/
	@CrudType AS int = 2,
	@ProductID AS int = 0,
	@ProductCode as nvarchar(20) = Null ,
	@ProductName as nvarchar(50) = Null,
	@ProductDescription as nvarchar(Max)= null,
	@ClearProductDescription as bit = 0,
	@StandardUnitCost as money = Null,
	@UnitPrice as money = Null,
	@ReorderLevel as smallint = null ,
	@TargetLevel as smallint = null ,
	@QuantityPerUnit as nvarchar(50) = Null,
	@Discontinued as bit = Null,
	@MinimumReorderQuantity as smallint = Null,
	@ProductCategoryID as int = null,

	@UnifiedID As Int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE
			@LocalID as int,
			@LocalErrorCode as INT,
			@LocalMessage as NVarChar(400),
			@CustomErrorCode as Int,
			@CustomErrorMessage as nvarchar(400); 
		If @CrudType= 1 
			EXEC [dbo].Z_AddProduct
				@ProductName = @ProductName,
				@ProductDescription = @ProductDescription,
				@StandardUnitCost = @StandardUnitCost,
				@UnitPrice = @UnitPrice,
				@ReorderLevel = @ReorderLevel,
				@TargetLevel = @TargetLevel ,
				@QuantityPerUnit = @QuantityPerUnit,
				@Discontinued = @Discontinued,
				@MinimumReorderQuantity = @MinimumReorderQuantity,
				@ProductCategoryID = @ProductCategoryID,
	
				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 
		ELSE If @CrudType = 2 
			EXEC [dbo].[Z_SelectProduct]
				@ProductID = @ProductID,
				@ProductCode = @ProductCode,
				@ProductName = @ProductName,
				@ProductDescription = @ProductDescription,
				@StandardUnitCost = @StandardUnitCost,
				@UnitPrice = @UnitPrice,
				@ReorderLevel = @ReorderLevel,
				@TargetLevel = @TargetLevel ,
				@QuantityPerUnit = @QuantityPerUnit,
				@Discontinued = @Discontinued,
				@MinimumReorderQuantity = @MinimumReorderQuantity,
				@ProductCategoryID = @ProductCategoryID,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 		
		ELSE If @CrudType = 3 
			EXEC [dbo].Z_UpdateProduct
				@ProductID = @ProductID,
				@ProductName = @ProductName,
				@ProductDescription = @ProductDescription,
				@ClearProductDescription =@ClearProductDescription,
				@StandardUnitCost = @StandardUnitCost,
				@UnitPrice = @UnitPrice,
				@ReorderLevel = @ReorderLevel,
				@TargetLevel = @TargetLevel ,
				@QuantityPerUnit = @QuantityPerUnit,
				@Discontinued = @Discontinued,
				@MinimumReorderQuantity = @MinimumReorderQuantity,
				@ProductCategoryID = @ProductCategoryID,
	
				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 
		 ELSE If @CrudType = 4 
			EXEC [dbo].Z_DeleteProduct
				@ProductID = @ProductID,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;
		SET @UnifiedID = @LocalID;
		IF @LocalErrorCode= 0
			BEGIN
				SET @ErrorCode = @LocalErrorCode;
				SET @Message = @LocalMessage;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @LocalErrorCode,
					@CurrentObject = 'Product',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;

				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
			END
	END Try
	BEGIN Catch
		SET @UnifiedID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDProductVendors]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 6/29/2025
Description: CRUD operations on Product Vendors
=============================================
*/
CREATE PROCEDURE [dbo].[CRUDProductVendors]
	/*CRUDTypes
		Create = 1 Requires values for all required fields, or defaults if not provided
		Read   = 2 Requires the PK of the record to be Read as 0 for all, non-0 for one selected User Setting
		        Default to Read only. Don't mess with stored values by accident
		Update = 3 Requires values for any field or fields to be updated
		Delete = 4 Requires only the PK of the record to be deleted
	*/
	@CrudType AS int = 2,   
	@ProductVendorID as int = 0,
	@ProductID As int= Null,
	@VendorID As int= Null, 

	@UnifiedID As Int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE
			@LocalID as int,
			@LocalErrorCode as INT,
			@LocalMessage as NVarChar(400),
			@CustomErrorCode as Int,
			@CustomErrorMessage as nvarchar(400);
		If @CrudType= 1  
			EXEC [dbo].[Z_AddProductVendor] 
				@ProductID = @ProductID,
				@VendorID = @VendorID,

				@LocalID = @LocalID OUTPUT,  
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 
		ELSE If @CrudType = 2   
			EXEC [dbo].[Z_SelectProductVendor]
				@ProductVendorID = @ProductVendorID, 
				@ProductID = @ProductID,
				@VendorID = @VendorID,

				@LocalID = @LocalID OUTPUT, 
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 
		ELSE If @CrudType = 3  
			EXEC dbo.Z_UpdateProductVendor
				@ProductVendorID = @ProductVendorID,
				@ProductID = @ProductID,
				@VendorID = @VendorID,
				

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT, 
				@Message = @LocalMessage OUTPUT;	 
		ELSE If @CrudType =  4  
			EXEC dbo.Z_DeleteProductVendor
				@ProductVendorID =@ProductVendorID,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT, 
				@Message = @LocalMessage OUTPUT;
			SET @UnifiedID = @LocalID;
		IF @LocalErrorCode= 0
			BEGIN
				SET @ErrorCode = @LocalErrorCode;
				SET @Message = @LocalMessage;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @LocalErrorCode,
					@CurrentObject = 'ProductVendors',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;

				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
			END
	End Try
	BEGIN Catch
		SET @UnifiedID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDPurchaseOrder]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 5/24/2025
Description: Master CRUD for Purchase Orders
=============================================
*/
CREATE PROCEDURE [dbo].[CRUDPurchaseOrder]
	/*CRUDTypes
		Create = 1 Requires values for all required fields, or defaults if not provided
		Read = 2 Requires the PK of the record to be Read as 0 for all, non-0 for one selected Purchase Order
		 Default to Read only. Don't mess with stored values by accident
		Update = 3 Requires values for any field or fields to be updated
		Delete = 4 Requires only the PK of the record to be deleted
	*/
	@CrudType AS int = 2, 
	@PurchaseOrderID as int = Null,
	@VendorID as int = 0,
	@SubmittedByID as int = 0 ,
	@SubmittedDate as DateTime = Null,
	@ApprovedByID as int = 0,
	@ApprovedDate as DateTime = Null,
	@StatusID as int = 0,
	@ReceivedDate as DateTime = Null,
	@ShippingFee as Money = 0,
	@TaxAmount as Money = 0,
	@PaymentDate as DateTime = Null,
	@PaymentAmount as Money = 0,
	@PaymentMethod as nvarchar(50) = Null,
	@Notes as nvarchar(max) = Null,
	 
	@UnifiedID As Int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE
			@LocalID as int,
			@LocalErrorCode as INT,
			@LocalMessage as NVarChar(400),
			@CustomErrorCode as Int,
			@CustomErrorMessage as nvarchar(400);
		If @CrudType = 1
			EXEC dbo.Z_AddPO
				 @VendorID = @VendorID
				,@SubmittedByID = 10 --Internet orders as the default
				,@ApprovedByID = @ApprovedByID
				,@StatusID = 3 --Default New
				,@ShippingFee = @ShippingFee
				,@TaxAmount = @TaxAmount
				,@PaymentAmount = @PaymentAmount
				,@PaymentMethod = @PaymentMethod
				,@Notes = @Notes
				
				,@LocalID = @LocalID OUTPUT
				,@ErrorCode = @LocalErrorCode OUTPUT
				,@Message = @LocalMessage OUTPUT;
		If @CrudType = 2
			EXEC dbo.Z_SelectPO
				 @PurchaseOrderID = @PurchaseOrderID 
				,@VendorID = @VendorID
				,@SubmittedByID = @SubmittedByID
				,@ApprovedByID = @ApprovedByID
				,@StatusID = @StatusID
				,@ShippingFee = @ShippingFee
				,@TaxAmount = @TaxAmount
				,@PaymentAmount = @PaymentAmount
				,@PaymentMethod = @PaymentMethod
				,@Notes = @Notes
				,@SubmittedDate = @SubmittedDate
				,@ApprovedDate = @ApprovedDate
				,@ReceivedDate = @ReceivedDate
				,@PaymentDate = @PaymentDate

				,@LocalID = @LocalID OUTPUT
				,@ErrorCode = @LocalErrorCode OUTPUT
				,@Message = @LocalMessage OUTPUT;
		If @CrudType = 3
			EXEC dbo.Z_UpdatePO
				 @PurchaseOrderID = @PurchaseOrderID
				,@SubmittedByID = @SubmittedByID
				,@SubmittedDate = @SubmittedDate
				,@ApprovedByID = @ApprovedByID
				,@ApprovedDate = @ApprovedDate
				,@ReceivedDate = @ReceivedDate
				,@ShippingFee = @ShippingFee
				,@TaxAmount = @TaxAmount
				,@PaymentDate = @PaymentDate
				,@PaymentAmount = @PaymentAmount
				,@PaymentMethod = @PaymentMethod
				,@Notes = @Notes
				,@VendorID = @VendorID
				,@StatusID = @StatusID

				,@LocalID = @LocalID OUTPUT
				,@ErrorCode = @LocalErrorCode OUTPUT
				,@Message = @LocalMessage OUTPUT;
		If @CrudType = 4
			EXEC dbo.Z_DeletePO
				 @PurchaseOrderID = @PurchaseOrderID 
				,@LocalID = @LocalID OUTPUT
				,@ErrorCode = @LocalErrorCode OUTPUT
				,@Message = @LocalMessage OUTPUT;

		SET @UnifiedID = @LocalID;
		IF IsNull(@LocalErrorCode,0) = 0
			BEGIN
				SET @ErrorCode = @LocalErrorCode;
				SET @Message = @LocalMessage;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @LocalErrorCode,
					@CurrentObject = 'Purchase Orders',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;

				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
			END
	End Try
	Begin Catch
		SET @LocalID = @PurchaseOrderID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	End Catch
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDPurchaseOrderDetail]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		George Hepworth
Create date: 4/19/2025
Description:	CRUD operations on Purchase Order Details
=============================================
*/
CREATE PROCEDURE [dbo].[CRUDPurchaseOrderDetail] 
	/*CRUDTypes
		Create = 1 Requires values for all required fields, or defaults if not provided
		Read = 2 Requires the PK of the record to be Read as 0 for all, non-0 for one selected PO Detail
		 Default to Read only. Don't mess with stored values by accident
		Update = 3 Requires values for any field or fields to be updated
		Delete = 4 Requires only the PK of the record to be deleted
	*/
	@CRUDType as int = 2,
	@PurchaseOrderDetailID AS int = 0,--Default to all or nothing
	@PurchaseOrderID as int = 0,
	@ProductID as int = 0,
	@Quantity as int = 0,
	@UnitCost as money = 0,
	@ReceivedDate as DateTime = Null,

	@UnifiedID As Int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE
			@LocalID as int,
			@LocalErrorCode as INT = 0,
			@LocalMessage as NVarChar(400) = 'PO Details',
			@CustomErrorCode as Int,
			@CustomErrorMessage as nvarchar(400);
		If @CrudType = 1 
			EXEC [dbo].[Z_AddPODetail]
				@PurchaseOrderID =@PurchaseOrderID,
				@ProductID = @ProductID,
				@Quantity = @Quantity,
				@UnitCost = @UnitCost,
			 
				@LocalID = @LocalID OUTPUT	,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 
		ELSE If @CrudType = 2 
			EXEC [dbo].[Z_SelectPODetail]
				@PurchaseOrderDetailID = @PurchaseOrderDetailID,
				@PurchaseOrderID =@PurchaseOrderID,
				@ProductID = @ProductID,
				@Quantity = @Quantity,
				@UnitCost = @UnitCost,
				@ReceivedDate = @ReceivedDate,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 		
		ELSE If @CrudType = 3 
			EXEC [dbo].Z_UpdatePODetail
				@PurchaseOrderDetailID = @PurchaseOrderDetailID , 
				@ProductID = @ProductID,
				@Quantity = @Quantity,
				@UnitCost = @UnitCost,
				@ReceivedDate = @ReceivedDate,

				@LocalID = @LocalID OUTPUT, 
				@ErrorCode = @LocalErrorCode OUTPUT, 
				@Message = @LocalMessage OUTPUT;
		 ELSE If @CrudType = 4 
			EXEC [dbo].[Z_DeletePODetail]
				@PurchaseOrderDetailID = @PurchaseOrderDetailID,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;
		SET @UnifiedID = @LocalID;
		IF @LocalErrorCode = 0
			BEGIN
				SET @ErrorCode = @LocalErrorCode;
				SET @Message = @LocalMessage;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @LocalErrorCode,
					@CurrentObject = 'Purchase Order Details',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;
				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
			END
	End Try
	BEGIN CATCH
 SET @UnifiedID = 0;
 SET @ErrorCode = ERROR_NUMBER();
 SET @Message = ERROR_MESSAGE();
 END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDStockTake]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 5/21/2025
Description: CRUD operations on StockTakes
=============================================
*/
CREATE PROCEDURE [dbo].[CRUDStockTake] 
	/*CRUDTypes
		Create = 1 Requires values for all required fields, or defaults if not provided
		Read = 2 Requires the PK of the record to be Read as 0 for all, non-0 for one selected StockTake
		 Default to Read only. Don't mess with stored values by accident
		Update = 3 Requires values for any field or fields to be updated
		Delete = 4 Requires only the PK of the record to be deleted
	*/
	@CrudType AS int = 2,
	@StockTakeID as int = 0,
	@ProductID as int = 0 ,
	@StockTakeDate as DateTime = Null,
	@QuantityOnHand as int =0,
	@ExpectedQuantity as Int =0,

	@UnifiedID As Int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE
			@LocalID as int,
			@LocalErrorCode as INT,
			@LocalMessage as NVarChar(400),
			@CustomErrorCode as Int,
			@CustomErrorMessage as nvarchar(400); 
		If @CrudType= 1 
			EXEC [dbo].[Z_AddStockTake]
				@ProductID = @ProductID,
				@StockTakeDate = @StockTakeDate,
				@QuantityOnHand = @QuantityOnHand,
				@ExpectedQuantity = @ExpectedQuantity ,
	
				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 
		ELSE If @CrudType = 2 
			EXEC [dbo].[Z_SelectStockTake]
				@ProductID = @ProductID,
				@StockTakeDate = @StockTakeDate,
				@QuantityOnHand = @QuantityOnHand,
				@ExpectedQuantity = @ExpectedQuantity ,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 	
		ELSE If @CrudType = 3 
			EXEC [dbo].Z_UpdateStockTake
				@StockTakeID = @StockTakeID,
				@ProductID = @ProductID,
				@StockTakeDate = @StockTakeDate,
				@QuantityOnHand = @QuantityOnHand,
				@ExpectedQuantity = @ExpectedQuantity,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 
		 ELSE If @CrudType = 4 
			BEGIN
			EXEC [dbo].Z_DeleteStockTake
				@StockTakeID = @StockTakeID,
				@ProductID = @ProductID,
				@StockTakeDate= @StockTakeDate,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;
			END
		SET @UnifiedID = @LocalID;
		IF @LocalErrorCode= 0
			BEGIN
				SET @ErrorCode = @LocalErrorCode;
				SET @Message = @LocalMessage;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @LocalErrorCode,
					@CurrentObject = 'Stock Takes',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;
				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
			END
	END Try
	BEGIN Catch
		SET @UnifiedID = @ProductID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch

END
GO
/****** Object:  StoredProcedure [dbo].[CRUDSystemSettings]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 5/27/2025
Description: CRUD operations on System Settings
=============================================
*/
CREATE PROCEDURE [dbo].[CRUDSystemSettings] 
	/*CRUDTypes
		Create = 1 Requires values for all required fields, or defaults if not provided
		Read = 2 Requires the PK of the record to be Read as 0 for all, non-0 for one selected System Setting
		 Default to Read only. Don't mess with stored values by accident
		Update = 3 Requires values for any field or fields to be updated
		Delete = 4 Requires only the PK of the record to be deleted
	*/
	@CrudType AS int = 2, 
	@SettingID as Int = 0,
	@SettingName As nvarchar(50)= Null,
	@SettingValue As nvarchar(255)= Null,
	@Notes As nvarchar(255)= Null,

	@UnifiedID As Int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE
			@LocalID as int,
			@LocalErrorCode as INT,
			@LocalMessage as NVarChar(400),
			@CustomErrorCode as Int,
			@CustomErrorMessage as nvarchar(400);
		If @CrudType= 1
			EXEC [dbo].[Z_AddSystemSetting] 
				@SettingName =@SettingName,
				@SettingValue =@SettingValue,
				@Notes = @Notes,

				@LocalID = @LocalID OUTPUT, 
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 
		ELSE If @CrudType = 2
			EXEC [dbo].[Z_SelectSystemSetting]
				@SettingID = @SettingID, 

				@LocalID = @LocalID OUTPUT, 
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 			
		ELSE If @CrudType = 3
			EXEC dbo.Z_UpdateSystemSetting
				@SettingID =@SettingID,
				@SettingName =@SettingName,
				@SettingValue =@SettingValue,
				@Notes = @Notes,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT, 
				@Message = @LocalMessage OUTPUT;	 
		 ELSE If @CrudType = 4 
			EXEC dbo.Z_DeleteSystemSetting
				@SettingID =@SettingID,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT, 
				@Message = @LocalMessage OUTPUT;
			SET @UnifiedID = @LocalID;
		IF @LocalErrorCode= 0
			BEGIN
				SET @ErrorCode = @LocalErrorCode;
				SET @Message = @LocalMessage;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @LocalErrorCode,
					@CurrentObject = 'System Settings',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;
				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
			END
	End Try
	BEGIN Catch
		SET @UnifiedID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[CRUDUserSettings]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		George Hepworth
Create date: 5/27/2025
Description:	CRUD operations on USER Settings
=============================================
*/
CREATE PROCEDURE [dbo].[CRUDUserSettings] 
	/*CRUDTypes
		Create = 1 Requires values for all required fields, or defaults if not provided
		Read = 2 Requires the PK of the record to be Read as 0 for all, non-0 for one selected User Setting
		 Default to Read only. Don't mess with stored values by accident
		Update = 3 Requires values for any field or fields to be updated
		Delete = 4 Requires only the PK of the record to be deleted
	*/
	@CrudType AS int = 2, 
	@SettingID as Int = 0,
	@SettingName As nvarchar(50)= Null,
	@SettingValue As nvarchar(255)= Null,
	@Notes As nvarchar(255)= Null,

	@UnifiedID As Int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE
			@LocalID as int,
			@LocalErrorCode as INT,
			@LocalMessage as NVarChar(400),
			@CustomErrorCode as Int,
			@CustomErrorMessage as nvarchar(400);
		If @CrudType= 1 
			EXEC [dbo].[Z_AddUserSetting] 
				@SettingName =@SettingName,
				@SettingValue =@SettingValue,
				@Notes = @Notes,

				@LocalID = @LocalID OUTPUT, 
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 
		ELSE If @CrudType = 2 
			EXEC [dbo].[Z_SelectUserSetting]
				@SettingID = @SettingID, 
				@SettingName =@SettingName,
				@SettingValue =@SettingValue,
				@Notes = @Notes,

				@LocalID = @LocalID OUTPUT, 
				@ErrorCode = @LocalErrorCode OUTPUT,
				@Message = @LocalMessage OUTPUT;	 
		ELSE If @CrudType = 3 
			EXEC dbo.Z_UpdateUserSetting
				@SettingID =@SettingID,
				@SettingName =@SettingName,
				@SettingValue =@SettingValue,
				@Notes = @Notes,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT, 
				@Message = @LocalMessage OUTPUT;	 
		ELSE If @CrudType = 4 
			EXEC dbo.Z_DeleteUserSetting
				@SettingID =@SettingID,

				@LocalID = @LocalID OUTPUT,
				@ErrorCode = @LocalErrorCode OUTPUT, 
				@Message = @LocalMessage OUTPUT;
			SET @UnifiedID = @LocalID;
		IF @LocalErrorCode= 0
			BEGIN
				SET @ErrorCode = @LocalErrorCode;
				SET @Message = @LocalMessage;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @LocalErrorCode,
					@CurrentObject = 'User Settings',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;

				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
			END
	End Try
	BEGIN Catch
		SET @UnifiedID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[CustomErrorMessage]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 6/6/2025
Description: Trap System and Error Codes and 
			 return custom Error Messages
=============================================
*/
CREATE PROCEDURE [dbo].[CustomErrorMessage]
	@SysErrorCode as int,
	@CurrentObject as nvarchar(120) = 'Object',

	@CustomErrorCode as int = 0 OUTPUT,
	@CustomErrorMessage as nvarchar(400) = 'Unknown Error in {0}' OUTPUT
AS
BEGIN
	SET NOCOUNT ON
 -- Input validation
 IF @SysErrorCode IS NULL
 BEGIN
 SET @CustomErrorCode = -1;
 SET @CustomErrorMessage = 'Invalid input: @SysErrorCode cannot be NULL';
 RETURN;
 END
 -- Ensure @CurrentObject has a default value if NULL
 IF @CurrentObject IS NULL OR LTRIM(RTRIM(@CurrentObject)) = ''
 SET @CurrentObject = 'Object';
 
	BEGIN Try
		DECLARE @SysErrorMessage as nvarchar(400);
		SELECT @SysErrorMessage = SSError
		FROM SSErrors
		WHERE SSErrorID = @SysErrorCode;
		If @SysErrorMessage is null 
		SET @SysErrorMessage = 'Unknown Error in {0}';
		SET @CustomErrorCode = @SysErrorCode;
		SET @CustomErrorMessage = 
			Replace(@SysErrorMessage,'{0}',@CurrentObject);
	END Try
	BEGIN Catch
		SET @SysErrorCode = ERROR_NUMBER();
		SET @CustomErrorMessage = CONCAT('Error in CustomErrorMessage procedure: ', ERROR_MESSAGE());

	 -- Stubbed in logging code
 -- Log the error for debugging (optional - uncomment if you have error logging)
 /*
 INSERT INTO ErrorLog (ErrorNumber, ErrorMessage, ProcedureName, ErrorDate)
 VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), 'CustomErrorMessage', GETDATE());
 */ 
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[EmployeeOrders]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 2025-03-22
Description: Orders submitted by employees
=============================================
*/
CREATE PROCEDURE [dbo].[EmployeeOrders]
		@ErrorCode AS int = 0 OUTPUT,
		@Message AS nvarchar(400) = 'Success' OUTPUT
	AS
	BEGIN
		BEGIN Try
			SELECT E.EmployeeID
			, dbo.fn_FullName(E.FirstName,E.LastName) as Employee
			,dbo.fn_FullNameLF(E.FirstName,E.LastName) as EmployeeLF
			, O.OrderID
			, C.CompanyID
			, C.CompanyName
			, O.OrderDate
			,Cast(
					Sum((OD.Quantity * OD.UnitPrice) * (1-OD.Discount)) + 
					(Sum((OD.Quantity * OD.UnitPrice) * (1-OD.Discount) * 
					(O.TaxRate * C.StandardTaxStatusID)) ) AS Money
				) AS ExtendedPrice
			,IsNull(O.ShippingFee,0) AS ShippingFee
			,O.OrderStatusID
			,OS.OrderStatusName
			,S.CompanyName As ShipperName
			FROM dbo.Orders AS O LEFT OUTER JOIN
				 dbo.OrderDetails AS OD ON O.OrderID = OD.OrderID INNER JOIN
				 dbo.Companies AS C ON O.CustomerID = C.CompanyID INNER JOIN
				 dbo.Employees AS E ON O.EmployeeID = E.EmployeeID INNER JOIN
	 			dbo.OrderStatus AS OS ON O.OrderStatusID = OS.OrderStatusID LEFT Outer JOIN 
	 			dbo.companies AS S ON O.ShipperID = S.CompanyID
			GROUP BY E.EmployeeID
				, O.OrderID
				, C.CompanyID
				, C.CompanyName
				, O.OrderDate,
				O.OrderStatusID
				,dbo.fn_FullName(E.FirstName,E.LastName)
				,dbo.fn_FullNameLF(E.FirstName,E.LastName) 
				,S.CompanyName
				, IsNull(O.ShippingFee,0)
				,OS.OrderStatusName
			ORDER BY dbo.fn_FullNameLF(E.FirstName,E.LastName) 
				, O.OrderID;
				SET	@ErrorCode = 0;
				SET @Message ='Success';
		END Try
 		BEGIN Catch
			SET @ErrorCode = ERROR_NUMBER();
			SET @Message = ERROR_MESSAGE();	 
		END Catch
	END
GO
/****** Object:  StoredProcedure [dbo].[ImportEmployeeImage]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ImportEmployeeImage] (
 @PicName NVARCHAR(100),
 @ImageFolderPath NVARCHAR(1000),
 @Filename NVARCHAR(1000),
 @EmployeeID INT = 0,
 @Result NVARCHAR(500) OUTPUT
)
AS
BEGIN
 SET NOCOUNT ON;
 BEGIN TRY
 DECLARE @Path2OutFile NVARCHAR(2000);
 DECLARE @tsql NVARCHAR(MAX);
 -- Construct full path
 SET @Path2OutFile = CONCAT(@ImageFolderPath, '\', @Filename);
 -- Create temp table
 CREATE TABLE #Pictures (
 EmployeeID INT,
 pictureName NVARCHAR(100),
 picFileName NVARCHAR(1000),
 PictureData VARBINARY(MAX)
 );
 -- Build dynamic SQL
 SET @tsql = '
 INSERT INTO #Pictures (EmployeeID, pictureName, picFileName, PictureData)
 SELECT 
 ' + CAST(@EmployeeID AS NVARCHAR) + ',
 ''' + REPLACE(@PicName, '''', '''''') + ''',
 ''' + REPLACE(@Filename, '''', '''''') + ''',
 img.BulkColumn
 FROM OPENROWSET(BULK N''' + REPLACE(@Path2OutFile, '''', '''''') + ''', SINGLE_BLOB) AS img;
 ';
 -- Execute dynamic SQL
 EXEC sp_executesql @tsql;
 -- Update Employee record
 UPDATE EMPLOYEES 
 SET EmployeeImagePA = p.PictureData,
 EmployeeImageName = p.pictureName
 FROM EMPLOYEES e
 INNER JOIN #Pictures p ON e.EmployeeID = p.EmployeeID
 WHERE e.EmployeeID = @EmployeeID;
 SET @Result = 'Image imported successfully.';
 END TRY
 BEGIN CATCH
 SET @Result = 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10)) +
 ' Error Message: ' + ERROR_MESSAGE();
 END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[InvoiceOrders]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 2025-03-22
Description: Completed Orders for Invoicing
=============================================
*/
CREATE PROCEDURE [dbo].[InvoiceOrders]
	@OrderID AS int = 0,
	@InvoicedOrderID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
	AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		With EmployeeExtended AS
			(
			SELECT 
				 [EmployeeID]
				,[FirstName]
				,[LastName]
				,[EmailAddress]
				,[JobTitle]
				,[PrimaryPhone]
				,[SecondaryPhone]
				,[Title]
				,[Notes]
				,[EmployeeImagePA]
				,[EmployeeImageName]
				,[SupervisorID]
				,[WindowsUserName]			
				,[FirstName] + ' ' + [LastName] AS FullNameFNLN
				,[LastName] + ', ' + [FirstName] AS FullNameLNFN
			FROM Employees
			),

		CustomerExtended AS
			(
			SELECT 
				 [CompanyID]
				,[CompanyName]
				,[CompanyTypeID]
				,[BusinessPhone]
				,[Address]
				,[City]
				,[StateAbbrev]
				,[Zip]
				,[Website]
				,[Notes]
				,[StandardTaxStatusID]
			FROM Companies
			WHERE Companies.CompanyTypeID = 1
			),
		OrderTotal AS
			(
			SELECT OrderID, 
				Cast(Sum(OrderDetails.Quantity * (1- OrderDetails.Discount) *	
				OrderDetails.UnitPrice) as money)AS SubTotal
				FROM OrderDetails 
				GROUP BY OrderID
				HAVING OrderDetails.OrderID = @OrderID
			)
		SELECT 
			 CustomerExtended.CompanyName
			,CustomerExtended.Address
			,CustomerExtended.City
			,CustomerExtended.StateAbbrev
			,CustomerExtended.Zip
			,Orders.[OrderID]
			,Orders.[EmployeeID]
			,Orders.[CustomerID]
			,Orders.[OrderDate]
			,Orders.[InvoiceDate]
			,Orders.[ShippedDate]
			,Orders.[ShipperID]
			,Orders.[ShippingFee]
			,Orders.[TaxRate]
			,Orders.[TaxStatusID]
			,Orders.[PaymentMethod]
			,Orders.[PaidDate]
			,Orders.[Notes]
			,Orders.[OrderStatusID]
			,EmployeeExtended.FullNameFNLN AS SalesPerson
			,OrderDetails.ProductID
			,OrderDetails.Quantity
			,OrderDetails.UnitPrice
			,OrderDetails.Discount
			,Cast(OrderDetails.Quantity * (1- OrderDetails.Discount)*
				OrderDetails.UnitPrice as money) As ExtendedPrice
			,Case 
				When Orders.TaxstatusID = 1 
				Then Cast(OrderDetails.Quantity * (1- OrderDetails.Discount)*
				OrderDetails.UnitPrice * Orders.TaxRate as money)
				Else Cast(0 as Money)
				END AS TaxAmount
			,OrderTotal.SubTotal
			,Products.ProductCode
			,Products.ProductName
		FROM Orders
		INNER JOIN CustomerExtended
		ON Orders.CustomerID = CustomerExtended.CompanyID
		INNER JOIN OrderDetails
		ON Orders.OrderID = OrderDetails.OrderID
		INNER JOIN OrderTotal
		ON OrderDetails.OrderID = OrderTotal.OrderID
		INNER JOIN Products 
		ON OrderDetails.ProductID = Products.ProductID 
		INNER JOIN EmployeeExtended 
		ON Orders.EmployeeID = EmployeeExtended.EmployeeID 
		WHERE Orders.OrderID = @OrderID;
		SET @InvoicedOrderID = @OrderID;
		SET	@ErrorCode = 0;
		SET	@Message = 'Success';
	END Try
 	BEGIN Catch
		SET @InvoicedOrderID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch

END
GO
/****** Object:  StoredProcedure [dbo].[InvoiceStatus]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 2025-03-24
Description: Check Invoice Status before printing new invoice
=============================================
*/
CREATE PROCEDURE [dbo].[InvoiceStatus]
	@OrderID int = 0,
	@InvoiceStatusID int OUTPUT,
	@InvoiceDate datetime OUTPUT,
	@LocalOrderID as int OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
 	SET NOCOUNT ON;
	BEGIN Try
		SELECT @InvoiceStatusID = OrderStatusID,
			 @InvoiceDate = InvoiceDate
		FROM Orders
		WHERE OrderID = @OrderID;

		SET @LocalOrderID = @OrderID;
		SELECT @InvoiceStatusID = Coalesce(@InvoiceStatusID,0);
		SELECT	@ErrorCode = 0,
				@Message = 'Invoice Status for Order' + Cast(@LocalOrderID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @InvoiceStatusID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT @InvoiceStatusID = OrderStatusID , @InvoiceDate = InvoiceDate
		FROM Orders
		WHERE 1 = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[LineItemsAllocated]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 2025-03-18
Description: Are all lines items in an order allocated for invoicing?
=============================================
*/
CREATE PROCEDURE [dbo].[LineItemsAllocated] 
	@OrderID as int = 0, 
	@AllAllocated as int = 0 OUTPUT,

	@AllocatedOrderID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT @AllAllocated = Count(OrderID)
		FROM OrderDetails
		WHERE orderdetails.OrderDetailStatusID<>1
			AND OrderID =	@OrderID ;
		SET @AllocatedOrderID = @OrderID;
		SET	@ErrorCode = 0;
		SET	@Message = 'Success';
	END Try
	BEGIN Catch
		SET	@AllocatedOrderID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT @AllAllocated = Count(OrderID)
		FROM OrderDetails
		WHERE 1 = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[PODetails_AllPOs]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 04/21/2025
Description: Get a list of Purchase orders 
			 containing a product
=============================================
*/
CREATE PROCEDURE [dbo].[PODetails_AllPOs]
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Selected' OUTPUT 
AS
BEGIN	
	SET NOCOUNT ON;
	BEGIN Try
		SELECT	dbo.PurchaseOrders.PurchaseOrderID, 
				dbo.PurchaseOrderDetails.PurchaseOrderDetailID, 
				dbo.PurchaseOrderDetails.Quantity, 
				dbo.PurchaseOrderDetails.UnitCost, 
				dbo.PurchaseOrderDetails.ReceivedDate, 
				dbo.PurchaseOrderDetails.ProductID
		FROM dbo.PurchaseOrderDetails RIGHT OUTER JOIN
				dbo.PurchaseOrders ON 
				dbo.PurchaseOrderDetails.PurchaseOrderID = dbo.PurchaseOrders.PurchaseOrderID
		SET @ErrorCode = 0;
		SET @Message = 'Selected Orders';
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
 		SELECT dbo.PurchaseOrders.PurchaseOrderID, 
		dbo.PurchaseOrderDetails.PurchaseOrderDetailID, 
		dbo.PurchaseOrderDetails.Quantity, 
		dbo.PurchaseOrderDetails.UnitCost, 
		dbo.PurchaseOrderDetails.ReceivedDate, 
		dbo.PurchaseOrderDetails.ProductID
		FROM dbo.PurchaseOrderDetails RIGHT OUTER JOIN
			 dbo.PurchaseOrders ON 
			 dbo.PurchaseOrderDetails.PurchaseOrderID = dbo.PurchaseOrders.PurchaseOrderID
		WHERE 1 = 0;
	END Catch 
END
GO
/****** Object:  StoredProcedure [dbo].[ProductAllocated]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 2025-03-18
Description: Number of items allocated 
			 in one or more purchase orders
=============================================
*/
CREATE PROCEDURE [dbo].[ProductAllocated] 
	@ProductID as int = 0, 

	@LocalProductID as int OUTPUT,
	@LocalAllocatedProduct as int = 0 OUTPUT,
	@LocalErrorCode AS int = 0 OUTPUT,
	@LocalMessage AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT @LocalAllocatedProduct = IsNull(Sum(Quantity),0)
		FROM OrderDetails
		WHERE ProductID = @ProductID and orderdetails.OrderDetailStatusID = 1 ;
		SET @LocalProductID = @ProductID;
		SET	@LocalErrorCode = 0;
		SET	@LocalMessage = 'Product Allocated';
	END Try
	BEGIN Catch
		SET @LocalProductID = @ProductID;
		SET	@LocalAllocatedProduct = 0;
		SET @LocalErrorCode = ERROR_NUMBER();
		SET @LocalMessage = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[ProductAvailable]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 03/17/2025
Description: Check Stock Level of Products 
			 for POs and Orders
=============================================
*/
CREATE PROCEDURE [dbo].[ProductAvailable]
	@ProductID AS Int,
	@CurrentOrder as Int = 0,
	@LastStockTakeQOH as Int OUTPUT,
	@ProductBoughtSinceLastStockTake As Int OUTPUT,
	@ProductSold As Int OUTPUT,
	@LocalProductAvailableToSell As Int OUTPUT,
	@AvailableProductID As Int = 0 OUTPUT,
	@LocalErrorCode AS int = 0 OUTPUT,
	@LocalMessage AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		Declare 
			@LocalProductSold as int,
			@LocalProductBought as int,
			@LocalID as int,
			@LocalAllocatedProduct as int,
			@ErrorCode as INT,
			@Message as NVarChar(400),
			@CustomErrorCode as int,
			@CustomErrorMessage as NVarChar(400);
		Set @AvailableProductID = @ProductID;

		--Newly added products may or may not be in a stocktake yet.
		--AddNewProductToStockTake adds a stocktake for it, if neccessary.
		BEGIN
		Exec dbo.AddNewProductToStockTake
			@ProductID =@ProductID,
			@LocalID = @LocalID OUTPUT,
			@ErrorCode = @ErrorCode OUTPUT,
			@Message = @Message OUTPUT
			SET @LocalErrorCode = Cast(IsNull(@ErrorCode,0) as NVarChar(40));
			SET @LocalMessage = Isnull(@Message,'StockTake Created For ProductID ' 
			+ Cast(@ProductID AS nvarchar(10))) ;
		END
		--ProductAvailable is used by multiple parent SPs for different purposes
		--Calculate ProductLastStockTakeDateQOH for each because some parent SPs do not provide these values
		EXEC dbo.ProductLastStockTakeDateQOH
			@ProductID =@ProductID,
			@LastStockTakeQOH =@LastStockTakeQOH OUTPUT,			 
			@LocalErrorCode = @LocalErrorCode OUTPUT,
			@LocalMessage = @LocalMessage OUTPUT;
			SET @LastStockTakeQOH = Isnull(@LastStockTakeQOH,0);
			SET @LocalErrorCode = @LocalErrorCode + ' ' + Cast(@LocalErrorCode as Nvarchar(40));
			SET @LocalMessage = @LocalMessage + '; '+ IsNull(@LocalMessage,' Last StockTake Date ');
		EXEC [dbo].[ProductSoldSinceLastStockTake]
			@ProductID = @ProductID,
	
			@LocalID =@LocalID,
			@ProductSold = @ProductSold OUTPUT,
			@ErrorCode = @LocalErrorCode OUTPUT,
			@Message = @LocalMessage OUTPUT;
			SET @LocalErrorCode = @LocalErrorCode + ' ' + Cast(@LocalErrorCode as Nvarchar(40));
			SET @LocalMessage = @LocalMessage + '; ' + IsNull(@LocalMessage,' Sold ');

		EXEC [dbo].[ProductBoughtSinceLastStockTake]
			@ProductID = @ProductID,
	
			@LocalID =@LocalID,
			@ProductBoughtSinceLastStockTake = @LocalProductBought OUTPUT,
			@ErrorCode = @LocalErrorCode OUTPUT,
			@Message = @LocalMessage OUTPUT;
			SET @ProductBoughtSinceLastStockTake = IsNull(@LocalProductBought,0);
			SET @LocalErrorCode = @LocalErrorCode + ' ' + Cast(@LocalErrorCode as Nvarchar(40));
			SET @LocalMessage = @LocalMessage + '; ' + IsNull(@LocalMessage,' Bought ');

		Declare @LocalProductID as int = 0;

		Exec dbo.ProductAllocated
			@ProductID = @ProductID,
			@LocalProductID = @LocalProductID OUTPUT,
			@LocalAllocatedProduct = @LocalAllocatedProduct OUTPUT,
			@LocalErrorCode = @LocalErrorCode OUTPUT,
			@LocalMessage = @LocalMessage;

	--The formula for ProductAvailableToSell is:
	
	--Quantity On Hand from most recent StockTake
	--Plus Quantity Bought Since Last StockTake
	--Minus Quantity Sold Since Last StockTake
	--Minus Quantity Allocated on Unshipped Orders

	 Set @LocalProductAvailableToSell = 
		 IsNull(@LastStockTakeQOH,0) + 
		 IsNull(@ProductBoughtSinceLastStockTake,0) -
		 IsNull(@ProductSold,0) -
		 IsNull(@LocalAllocatedProduct,0);
	
	 	IF @LocalErrorCode = 0
			BEGIN
				SET @ErrorCode = @LocalErrorCode;
				SET @Message = @LocalMessage;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @LocalErrorCode,
					@CurrentObject = 'Orders',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;
				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
			END
	End Try
	BEGIN Catch
		SET @LocalErrorCode = ERROR_NUMBER();
		SET @LocalMessage = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[ProductBoughtAllTime]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/22/2025
Description: Get most Total Bought 
			 since last stocktake date for a product
=============================================
*/
CREATE PROCEDURE [dbo].[ProductBoughtAllTime]
	@ProductID as int = 0,
	@LocalID as Int = 0 OUTPUT,
	@ProductBought as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Added' OUTPUT
AS
BEGIN
	BEGIN TRY
		SET NOCOUNT ON;
		DECLARE
		@LocalLastStockTakeDate as date,
		@LocalLastStockTakeQOH as int,
		@LocalErrorCode as int = 0,
		@LocalMessage as nvarchar(400);
		SELECT @LocalLastStockTakeDate = Max([StockTakeDate])
		FROM [dbo].[StockTake]
		WHERE ProductID = @ProductID;
		SELECT @ProductBought= Sum(IsNull(POD.Quantity,0))
		FROM PurchaseOrderDetails As POD INNER JOIN
			PurchaseOrders AS PO ON POD.PurchaseOrderID= PO.PurchaseOrderID
		WHERE ProductID = @ProductiD 
		GROUP BY ProductID;
		If @ProductBought Is Null
			Set @ProductBought= 0 ;
		SET @LocalID = @ProductID;
		SET	@ErrorCode = 0 ;
		SET	@Message = 'product bought Alltime'; 
	End Try
	BEGIN Catch
		SET @ProductBought= 0;
		SET @LocalID = @ProductID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	 End Catch
END
GO
/****** Object:  StoredProcedure [dbo].[ProductBoughtSinceLastStockTake]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/22/2025
Description: Get most Total Bought 
			 since last stocktake date for a product
=============================================
*/
CREATE PROCEDURE [dbo].[ProductBoughtSinceLastStockTake]
	@ProductID as int = 0,
	@LocalID as Int = 0 OUTPUT,
	@ProductBoughtSinceLastStockTake as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Added' OUTPUT
AS
BEGIN		
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE
		@LocalLastStockTakeDate as date,
		@LocalLastStockTakeQOH as int,
		@LocalErrorCode as int = 0,
		@LocalMessage as nvarchar(400);
		Print @ProductiD;
		SELECT @LocalLastStockTakeDate = Cast(Max([StockTakeDate]) as Date)
		FROM [dbo].[StockTake]
		WHERE ProductID = @ProductID;
		Print @LocalLastStockTakeDate;
		SELECT @ProductBoughtSinceLastStockTake= Sum(IsNull(POD.Quantity,0))
		FROM PurchaseOrderDetails As POD INNER JOIN
			PurchaseOrders AS PO ON POD.PurchaseOrderID= PO.PurchaseOrderID
		WHERE ProductID = @ProductID
			AND (PO.ReceivedDate Is Not Null And Cast(PO.ReceivedDate as Date) > @LocalLastStockTakeDate) 
		GROUP BY ProductID;
		If @ProductBoughtSinceLastStockTake Is Null
		Set @ProductBoughtSinceLastStockTake= 0;
		SET @LocalID = @ProductID;
		SET	@ErrorCode = 0 ;
		SET	@Message = 'product bought since last stock take'; 
	End Try
	BEGIN Catch
		SET @ProductBoughtSinceLastStockTake= 0;
		SET @LocalID = @ProductID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	End Catch
END
GO
/****** Object:  StoredProcedure [dbo].[ProductCategoryList]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/1/2025
Description: Product list with details 
=============================================
*/
CREATE PROCEDURE [dbo].[ProductCategoryList] 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT [ProductCategoryID]
			,[ProductCategoryName]
			,[ProductCategoryCode]
			,[ProductCategoryDesc]
			,[ProductCategoryImageName]
			,[ProductCategoryImage]
		FROM [dbo].[ProductCategories]
		ORDER BY [ProductCategoryName];
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = 'Selected Products';
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT [ProductCategoryID]
			,[ProductCategoryName]
			,[ProductCategoryCode]
			,[ProductCategoryDesc]
			,[ProductCategoryImageName]
			,[ProductCategoryImage]
		FROM [dbo].[ProductCategories]
		WHERE 1 = 0;
	END Catch 
END
GO
/****** Object:  StoredProcedure [dbo].[ProductLastStockTakeDateQOH]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/22/2025
Description: Get most recent stocktake date 
			 and Quantity on Hand for a product
=============================================
*/
CREATE PROCEDURE [dbo].[ProductLastStockTakeDateQOH]
	@ProductID as int = 0,
	
	@LocalID as Int = 0 OUTPUT,
	@LastStockTakeDate AS Date = Null OUTPUT,
 @LastStockTakeQOH as Int = 0 OUTPUT,
	@LocalErrorCode AS int = 0 OUTPUT,
	@LocalMessage AS nvarchar(400) = 'Last StockTake' OUTPUT
AS
BEGIN	
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE @LocalLastStockTakeDate as Date,
				@LocalLastStockTakeQOH as int;
		SELECT @LocalLastStockTakeDate = Cast(Max([StockTakeDate]) as Date)
		FROM [dbo].[StockTake]
		WHERE ProductID = @ProductID;
		SELECT @LocalLastStockTakeQOH = QuantityonHand
		FROM [dbo].[StockTake]
		WHERE ProductID = @ProductID
		AND Cast(StockTakeDate as Date) = @LocalLastStockTakeDate;
		SET @LastStockTakeQOH =@LocalLastStockTakeQOH;
		SET @LastStockTakeDate =@LocalLastStockTakeDate;
		SET @LocalID = @ProductID;
		SET	@LocalErrorCode = 0 ;
		SET	@LocalMessage = 'Last StockTakeDate; Product Quantity as of StockTakeDate'; 
	End Try
	BEGIN Catch
		SET @LastStockTakeDate = Null;
		SET @LastStockTakeQOH = 0;
		SET @LocalID = @ProductID;
		SET @LocalErrorCode = ERROR_NUMBER();
		SET @LocalMessage = ERROR_MESSAGE();
	 End Catch
END
GO
/****** Object:  StoredProcedure [dbo].[ProductList]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ProductList]
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 	
AS
BEGIN
 SET NOCOUNT ON;
 
 BEGIN TRY
 WITH NoStock AS 
 (
 SELECT ProductID, Sum(quantity) AS NoStock
 FROM OrderDetails
 WHERE OrderDetailStatusID = 4
 GROUP BY ProductID
 ),
 Allocated AS
 (
 SELECT ProductID, Sum(quantity) AS Allocated
 FROM OrderDetails
 WHERE OrderDetailStatusID = 1
 GROUP BY ProductID
 ),
 ToSell AS
 (
 SELECT [ProductID], ProductsAvailabletoSell AS ToSell
 FROM [NW4PA].[dbo].[vw_StockAvailable]
 ),
 QuantityOnOrder AS
 (
 SELECT ProductID, Sum(quantity) AS OnOrder
 FROM OrderDetails
 WHERE OrderDetailStatusID = 5
 GROUP BY ProductID
 )
 SELECT P.ProductID
 , P.ProductCode
 , P.ProductName
 , P.ProductDescription
 , IsNull(NoStock.NoStock,0) AS NoStock
 , IsNull(Allocated.Allocated,0) as Allocated
 , IsNull(ToSell.ToSell,0) As ToSell
 , IsNull(QuantityOnOrder.OnOrder,0) AS QuantityOnOrder
 , P.StandardUnitCost
 , P.UnitPrice
 , P.ReorderLevel
 , P.TargetLevel
 , P.MinimumReorderQuantity
 , P.QuantityPerUnit
 , P.Discontinued
 , P.ProductCategoryID
 , PC.ProductCategoryName
 FROM dbo.ProductCategories AS PC 
 INNER JOIN dbo.Products AS P 
 ON PC.ProductCategoryID = P.ProductCategoryID
 LEFT OUTER JOIN NoStock 
 ON P.ProductID = NoStock.ProductID
 LEFT OUTER JOIN Allocated
 ON P.ProductID = Allocated.ProductID 
 LEFT OUTER JOIN ToSell
 ON P.ProductID = ToSell.ProductID
 LEFT OUTER JOIN QuantityOnOrder
 ON P.ProductID = QuantityOnOrder.ProductID
 ORDER BY P.ProductCategoryID,P.ProductName; 
 SET @ErrorCode = 0;
		SET @Message = 'Selected Products List';
	End Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
 BEGIN
 DECLARE @CustomErrorCode as Int,
 @CustomErrorMessage as NVARCHAR(400);
			EXEC CustomErrorMessage
				@SysErrorCode = @ErrorCode,
				@CurrentObject = 'Product List',
				@CustomErrorCode = @CustomErrorCode OUTPUT,
				@CustomErrorMessage = @CustomErrorMessage OUTPUT;
				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
		END
 END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[ProductNoStock]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George R Hepworth
Create date: 4/22/2025
Description: Check Product for no stock status
=============================================
*/
CREATE PROCEDURE [dbo].[ProductNoStock] 
	@ProductID as Int = 0,

	@LocalID as int OUTPUT,
	@LocalProductNoStock as int OUTPUT, 
	@LocalErrorCode AS int = 0 OUTPUT,
	@LocalMessage AS nvarchar(400) = 'Added' OUTPUT
AS
BEGIN
		SET NOCOUNT ON;
		BEGIN Try
			SELECT @LocalProductNoStock = IsNull(Sum(Quantity),0)
			FROM OrderDetails 
			WHERE ProductID = @ProductID AND 
				OrderDetailStatusID = 4; -- No Stock

			SET @LocalID = @ProductID;
			SET	@LocalErrorCode = 0 ;
			SET	@LocalMessage = 'Product NoStock amount'; 
		End Try
		BEGIN Catch
			SET @LocalProductNoStock= 0;
			SET @LocalID = @ProductID;
			SET @LocalErrorCode = ERROR_NUMBER();
			SET @LocalMessage = ERROR_MESSAGE();
		END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[ProductOnOrder]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/22/2025
Description: Get the Quantity of a Product 
			 on open, Approved POs
=============================================
*/
CREATE PROCEDURE [dbo].[ProductOnOrder]
	@ProductID as int = 0,

	@LocalProductOnOrder as int = 0 OUTPUT,
	@LocalID as Int = 0 OUTPUT,
	@LocalErrorCode AS int = 0 OUTPUT,
	@LocalMessage AS nvarchar(400) = 'On Order' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT @LocalProductOnOrder = Sum(IsNull(POD.Quantity,0))
		FROM PurchaseOrderDetails As POD INNER JOIN
			PurchaseOrders AS PO ON POD.PurchaseOrderID= PO.PurchaseOrderID
		WHERE ProductID = @ProductID
			 AND PO.StatusID = 1 --PO is Approved 
		GROUP BY ProductID;

		SET @LocalID = @ProductID;
		SET @LocalProductOnOrder = IsNull(@LocalProductOnOrder,0);
		SET	@LocalErrorCode = 0 ;
		SET	@LocalMessage = 'Quantity of Product on Purchase Order(s)'; 
	END Try
	BEGIN Catch
		SET @LocalProductOnOrder= 0;
		SET @LocalID = @ProductID;
		SET @LocalErrorCode = ERROR_NUMBER();
		SET @LocalMessage = ERROR_MESSAGE();
	 END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[ProductOrdersByProduct]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 04/21/2025
Description: Get a list of orders 
			 containing a product
=============================================
*/
CREATE PROCEDURE [dbo].[ProductOrdersByProduct]
	@ProductID AS Int = 0,

	@LocalID AS int = 0 OUTPUT ,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Selected' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try	
		SELECT 
		O.OrderID,
		O.OrderDate,
		OD.Quantity,
		OD.UnitPrice,
		(OD.Quantity * OD.UnitPrice) *(1-Od.Discount) AS ExtendedPrice,
		O.OrderStatusID,
		OD.OrderDetailStatusID,
		ODS.OrderDetailStatusName,
		OS.OrderStatusName ,
		OD.ProductID
		FROM dbo.Companies AS C INNER JOIN
			 dbo.Orders AS O 
			 ON C.CompanyID = O.CustomerID INNER JOIN
			 dbo.OrderDetails AS OD 
			 ON O.OrderID = OD.OrderID
			 INNER JOIN OrderDetailStatus AS ODS 
			 ON OD.OrderDetailStatusID = ODS.OrderDetailStatusID
			 INNER JOIN OrderStatus AS OS
			 ON O.OrderStatusID = OS.OrderStatusID
		WHERE OD.ProductID = @ProductID
		ORDER BY OrderID;

		SET @LocalID = @ProductID;
		SET @ErrorCode = 0;
		SET @Message = 'Selected Orders';
	END Try
	BEGIN Catch
		SET @LocalID = @LocalID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
 		SELECT 
		O.OrderID,
		O.OrderDate,
		OD.Quantity,
		OD.UnitPrice,
		(OD.Quantity * OD.UnitPrice) *(1-Od.Discount) AS ExtendedPrice,
		O.OrderStatusID,
		OD.OrderDetailStatusID,
		ODS.OrderDetailStatusName,
		OS.OrderStatusName ,
		OD.ProductID
		FROM dbo.Companies AS C INNER JOIN
			 dbo.Orders AS O 
			 ON C.CompanyID = O.CustomerID INNER JOIN
			 dbo.OrderDetails AS OD 
			 ON O.OrderID = OD.OrderID
			 INNER JOIN OrderDetailStatus AS ODS 
			 ON OD.OrderDetailStatusID = ODS.OrderDetailStatusID
			 INNER JOIN OrderStatus AS OS
			 ON O.OrderStatusID = OS.OrderStatusID
		WHERE 1 = 0;
	END Catch 		
END
GO
/****** Object:  StoredProcedure [dbo].[ProductReorderQuantity]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/22/2025
Update Date: 7/15/2025
Description: Calculate the desired minimum Reorder and other inventory amounts
 for one product
=============================================
*/
CREATE PROCEDURE [dbo].[ProductReorderQuantity]
	@ProductID as int = 0,

	@ProductReorderQuantity as int OUTPUT, -- Calculated
	@ProductOnOrder as int OUTPUT, --Retrieved by helper sp
	@ProductAvailableToSell as int OUTPUT, --Retrieved by helper sp
	@ProductAllocated as int OUTPUT, --Retrieved by helper sp
	@ProductNoStock as int OUTPUT, --Retrieved by helper sp
	@ReorderLevel as int OUTPUT, --Retrieved by helper sp
	@MinReOrder as int OUTPUT, --Retrieved by helper sp
	@ProductTargetLevel as int OUTPUT, --Retrieved by helper sp
	@UnifiedID as int OUTPUT,	 --Used for Error Handling
	@ErrorCode as int OUTPUT, --Used for Error Handling
	@Message as nvarchar(400) OUTPUT --Used for Error Handling
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		Declare 			
			@LocalProductNoStock as int,
			@LocalID as int,
			@LocalProductOnOrder as int,
			@LocalProductAvailableToSell as int,
			@LocalProductAllocated as int,
			@LastStockTakeDate as date,
			@LocalLastStockTakeDate as date,
			@LocalLastStockTakeQOH as int,
			@LastStockTakeQOH as int,
			@QTYAvailable as int,
			@LocalErrorCode as int,
			@LocalMessage as NvarChar(400),
			@CustomErrorCode as int,
			@CustomErrorMessage as NVarChar(400);
		
		BEGIN
			EXEC [dbo].[ProductLastStockTakeDateQOH]
				@ProductID = @ProductID,
				@LocalID = @ProductID,
				@LastStockTakeDate = @LastStockTakeDate OUTPUT, -- Last (most recent) StockTake date for this product
				@LastStockTakeQOH = @LastStockTakeQOH output, -- Last (most recent) StockTake quantity on hand for this product
				@LocalErrorCode= @LocalErrorCode,
				@LocalMessage = @LocalMessage

				SET @LastStockTakeDate = @LocalLastStockTakeDate;
				SET @UnifiedID = @ProductID ;	 
				SET @ErrorCode = @LocalErrorCode ;
				SET @Message = @LocalMessage ;
	
			EXEC dbo.ProductNoStock
				@ProductID = @ProductID,
				@LocalProductNoStock = @LocalProductNoStock OUTPUT, -- Quantity of this product in "No Stock" status on open Orders
				@LocalID = @LocalID OUTPUT,	 
				@LocalErrorCode = @LocalErrorCode OUTPUT,
				@LocalMessage = @LocalMessage OUTPUT

				SET @ProductNoStock = @LocalProductNoStock;
				SET @UnifiedID = @ProductID ;	 
				SET @ErrorCode = @LocalErrorCode ;
				SET @Message = @LocalMessage ;
		END
		BEGIN
			EXEC [dbo].[ProductOnOrder]
				@ProductID = @ProductID,
				@LocalID = @LocalID OUTPUT,
				@LocalProductOnOrder = @LocalProductOnOrder OUTPUT, -- Quantity of this product in "On Order" status on open Orders
				@LocalErrorCode = @LocalErrorCode OUTPUT,
				@LocalMessage = @LocalMessage OUTPUT
				
				SET @ProductOnOrder = @LocalProductOnOrder;
				SET @UnifiedID = @ProductID ;	 
				SET @ErrorCode = @LocalErrorCode ;
				SET @Message = @LocalMessage ;
		END	
		--An example of encapsulation and singularity of purpose: ProductAvailable and ProductAllocated
		--I decoupled the ProductAllocated sub procedure from ProductAvailable and call both where needed in this procedure.
		--The stored procedure "ProductAllocated" (run next in this sequence) is also called inside ProductAvailable 
		-- where it is needed for that calculation as well.
		--I also call ProductAllocated in this level where it is used 
		BEGIN
			EXEC [dbo].ProductAvailable
				@ProductID = @ProductID,
				@CurrentOrder = 0,
				@LastStockTakeQOH = 0 ,
				@ProductBoughtSinceLastStockTake = 0 ,
				@ProductSold = 0 ,
				@LocalProductAvailableToSell = @LocalProductAvailableToSell OUTPUT,
				@AvailableProductID = 0 ,

				@LocalErrorCode = @LocalErrorCode OUTPUT,
				@LocalMessage = @LocalMessage OUTPUT 

				SET @ProductAvailableToSell = IsNull(@LocalProductAvailableToSell,0);
				SET @UnifiedID = @ProductID ;	 
				SET @ErrorCode = @LocalErrorCode ;
				SET @Message = @LocalMessage ;
		END
		--An example of encapsulation and singularity of purpose: ProductAvailable and ProductAllocated
		--I decoupled the ProductAllocated sub procedure from ProductAvailable and call where needed in this procedure.
		--The stored procedure "ProductAllocated" is also called inside ProductAvailable (above) 
		-- where it is needed for that calculation
		--But I also call ProductAllocated in this level where it is used 
		BEGIN
			EXEC dbo.ProductAllocated
				@ProductID = @ProductID,
				@LocalProductID = @ProductID OUTPUT,
				@LocalAllocatedProduct = @LocalProductAllocated OUTPUT;

				SET @ProductAllocated = IsNull(@LocalProductAllocated,0);
				SET @UnifiedID = @ProductID ;	 
				SET @ErrorCode = @LocalErrorCode ;
				SET @Message = @LocalMessage ;
		END
		--With the dynamic components of the calculation gathered, it's time to put them to work with the static components from the table
		--Retrieve the defaults for Minimum Reorder Quantity, Target Level and Reorder Level from the Products table itself
		BEGIN
			SELECT	@MinReOrder = IsNull(MinimumReorderQuantity,0),
					@ProductTargetLevel = IsNull(TargetLevel,0),
					@ReorderLevel = IsNull(ReorderLevel,0)
			FROM Products 
			WHERE ProductID = @ProductID;
		END
		--Calculate the default quantity to reorder based on the following logic
		BEGIN
			-- Product in the warehouse + product on a truck coming in compared to Product on Orders with no stock to fill them + our Target Level
			IF	(IsNull(@ProductAvailableToSell,0) + IsNull(@ProductOnOrder,0)) > (@ProductNoStock + @ProductTargetLevel)
				--We dont need to order anything; publish the default minimum reorder quantity for the Product in the next step.
				SET @ProductReorderQuantity = @MinReOrder 
			ELSE
				--We do need to reorder. How Much? 
				--(Product on Orders with no stock to fill them + our Target Level) - (Product available in the warehouse + product on a truck coming in
				SET @ProductReorderQuantity = (@ProductNoStock + @ProductTargetLevel) - (IsNull(@ProductAvailableToSell,0) + IsNull(@ProductOnOrder,0))
				--But! Order at least the minimum reorder quantity
			If @MinReOrder > @ProductReorderQuantity
			 --Although we currently need less than the minimum reorder quantity; use the minimum reorder quantity.
				SET @ProductReorderQuantity = @MinReOrder
		END
		SET @UnifiedID = @ProductID ;	 
		IF @LocalErrorCode= 0
			BEGIN
				SET @ErrorCode = @LocalErrorCode;
				SET @Message = @LocalMessage;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @LocalErrorCode,
					@CurrentObject = 'Inventory',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;
				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
			END
	END Try
	BEGIN Catch
		SET @UnifiedID = @ProductID ;	 
		SET @ErrorCode = ERROR_NUMBER() ;
		SET @Message = ERROR_MESSAGE() ;

		SET @ProductReorderQuantity = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[ProductsAllocated]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		George Hepworth
Create date: 2025-03-18
Description:	Are all lines items in an order allocated for invoicing
=============================================
*/
CREATE PROCEDURE [dbo].[ProductsAllocated] 
	@ProductID as int = 0, 

	@LocalProductID as int OUTPUT,
	@AllocatedProduct as int = 0 OUTPUT,
	@LocalErrorCode AS int = 0 OUTPUT,
	@LocalMessage AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE @LocalAllocatedProduct as int;
		SELECT @LocalAllocatedProduct = IsNull(Sum(Quantity),0)
		FROM OrderDetails
		WHERE ProductID = @ProductID and orderdetails.OrderDetailStatusID = 1 ;
		SET @AllocatedProduct = @LocalAllocatedProduct;
		Set @LocalProductID = @ProductID;
		SET	@LocalErrorCode = 0;
		SET	@LocalMessage = 'Product Allocated';
	END Try
	BEGIN Catch
		SET	@AllocatedProduct = 0;
		Set @LocalProductID = @ProductID;
		SET @LocalErrorCode = ERROR_NUMBER();
		SET @LocalMessage = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[ProductsNotInPO]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/27/2025
Description: Products not already 
			 in a Purchase Order
=============================================
*/
CREATE PROCEDURE [dbo].[ProductsNotInPO]
	@PurchaseOrderID as Int
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT ProductID, ProductName
		FROM Products
		WHERE ProductID Not IN (
			SELECT ProductID 
			FROM PurchaseOrderDetails 
			WHERE PurchaseOrderID = @PurchaseOrderID)
		ORDER BY ProductName;
	END Try
	BEGIN Catch
		SELECT ProductID, ProductName
		FROM Products
		WHERE ProductID Not IN (
			SELECT ProductID 
			FROM PurchaseOrderDetails 
			WHERE 1 = 1);
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[ProductSoldAllTime]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/22/2025
Description: Product Sales All Time
=============================================
*/
CREATE PROCEDURE [dbo].[ProductSoldAllTime]
	@ProductID as int = 0,
	
	@LocalID as Int = 0 OUTPUT,
	@ProductSold as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Added' OUTPUT

AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE
			@LocalProductSold as int, 
			@LastStockTakeDate AS Date;
			SELECT @LocalProductSold = IsNull(SUM(Quantity),0)
			FROM OrderDetails OD
			WHERE (@ProductID = 0 OR ProductID = @ProductID);
			SET @LocalID = @ProductID;
			SET @ProductSold = @LocalProductSold;
			SET	@ErrorCode = 0 ;
			SET	@Message = 'Product sold Alltime'; 
	END Try
	BEGIN Catch
		SET @ProductSold = 0;
		SET @LocalID = @ProductID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	 End Catch
END
GO
/****** Object:  StoredProcedure [dbo].[ProductSoldSinceLastStockTake]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/22/2025
Description: Get most recent stocktake date 
			 for a product
=============================================
*/
CREATE PROCEDURE [dbo].[ProductSoldSinceLastStockTake]
	@ProductID as int = 0,
	
	@LocalID as Int = 0 OUTPUT,
	@ProductSold as int = 0 OUTPUT,
	@LastStockTakeDate as DateTime = null OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Added' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE
			@LocalProductSold as int, 
			@LocalLastStockTakeDate AS DateTime;
		SELECT @LocalLastStockTakeDate = Cast(Max([StockTakeDate]) as Date)
		FROM [dbo].[StockTake]
		WHERE ProductID = @ProductID;
		SELECT @LocalProductSold = IsNull(SUM(Quantity) ,0)
		FROM OrderDetails OD
		WHERE ProductID = @ProductID
			AND OrderID IN(SELECT OrderID
		FROM Orders 
		WHERE IsNull(InvoiceDate,0) >= @LocalLastStockTakeDate);
		SET @LocalID = @ProductID;
		SET @ProductSold= @LocalProductSold;
		SET @LastStockTakeDate= @LocalLastStockTakeDate;
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Product sold & invoiced since last stocktake'; 
	END Try
	BEGIN Catch
		SET @ProductSold= 0;
		SET @LocalID = @ProductID;
		SET @LastStockTakeDate= Null;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[ProductStockTakesByProduct]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 04/21/2025
Description: Get a list of Purchase orders containing a product
=============================================
*/
CREATE PROCEDURE [dbo].[ProductStockTakesByProduct]
	@ProductID AS Int = 0,

	@LocalID AS int = 0 OUTPUT ,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Selected' OUTPUT 
AS
BEGIN	
	SET NOCOUNT ON;
	BEGIN Try
		SELECT
			 [StockTakeID]
			,[StockTakeDate]
			,[ProductID]
			,[QuantityOnHand]
			,[ExpectedQuantity]
		FROM StockTake AS ST
		WHERE ST.ProductID = @ProductID;
		SET @LocalID = @ProductID;
		SET @ErrorCode = 0;
		SET @Message = 'Selected Orders';	
	END Try
	BEGIN Catch
		SET @LocalID = @LocalID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT
			 [StockTakeID]
			,[StockTakeDate]
			,[ProductID]
			,[QuantityOnHand]
			,[ExpectedQuantity]
		FROM StockTake AS ST
		WHERE 1 = 0;
	END Catch 		
END
GO
/****** Object:  StoredProcedure [dbo].[ProductVendorsByProduct]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: June 19, 20205
Description: List product vendors by product
=============================================
*/
CREATE PROCEDURE [dbo].[ProductVendorsByProduct]
	 @ProductID AS int = 0

	,@LocalID as int = 0 OUTPUT
	,@ErrorCode AS int = 0 OUTPUT
	,@Message AS nvarchar(400) = 'Success' OUTPUT
	 AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE @CustomErrorCode as Int,
				@CustomErrorMessage as nvarchar(400);
		SELECT 
		ProductVendors.ProductVendorID, 
		ProductVendors.ProductID, 
		ProductVendors.VendorID, 
		Companies.CompanyName
		FROM ProductVendors INNER JOIN
		Companies ON
		Companies.CompanyID = ProductVendors.VendorID
		WHERE ProductID = @ProductID;
		SET @LocalID = @ProductID;
		SET	@ErrorCode = 0;
		SET @Message = 'Success';
	END Try
	BEGIN Catch
		SET @LocalID = @ProductID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @ErrorCode,
					@CurrentObject = 'Employees',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;
				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
			END
		SELECT 
			ProductVendors.ProductVendorID, 
			ProductVendors.ProductID, 
			ProductVendors.VendorID, 
			Companies.CompanyName
			FROM ProductVendors INNER JOIN
			Companies ON
			Companies.CompanyID = ProductVendors.VendorID
		WHERE 1 = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[PurchaseOrderList]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		George Hepworth
Create date: 4/1/2025
Description:	Update company 
=============================================
*/
CREATE PROCEDURE [dbo].[PurchaseOrderList] 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		WITH PurchaseOrderTotal AS
		(
			SELECT PO.PurchaseOrderID, IsNull(Sum([Quantity]*UnitCost),0) AS PurchaseOrderTotal 
			FROM PurchaseOrders PO Left Outer JOIN dbo.PurchaseOrderDetails POD
			ON PO.PurchaseOrderID = POD.PurchaseOrderID
			GROUP BY PO.PurchaseOrderID
		)
		SELECT Distinct 
			PO.PurchaseOrderID,
			V.CompanyName AS Vendor,
			S.EmployeeID AS SubmittedByID,
			PO.SubmittedDate,
			S.FirstName + ' ' + S.LastName AS SubmittedByFNLN, 
			A.EmployeeID AS ApprovedByID,
			A.FirstName + ' ' + A.LastName AS ApprovedByFNLN,
			PO.ApprovedDate,
			PO.StatusID,
			POS.StatusName,
			PO.ReceivedDate, 
			PO.ShippingFee,
			Cast(ISNULL(PO.TaxAmount,0) AS Money) AS TaxAmount,
			Cast(ISNULL(PurchaseOrderTotal.PurchaseOrderTotal,0) AS Money) AS PurchaseOrderTotal,
			PO.PaymentDate,
			Cast(PO.PaymentAmount as Money) AS PaymentAmount,
			PO.PaymentMethod 
		FROM dbo.PurchaseOrders PO 
			Left Outer JOIN
			 dbo.Employees AS S 
			 ON PO.SubmittedByID = S.EmployeeID 
			 Left Outer JOIN
			 dbo.Employees as A
			 ON PO.ApprovedByID = A.EmployeeID
			 INNER JOIN
			 dbo.Companies AS V 
			 ON PO.VendorID = V.CompanyID 
			 INNER JOIN
			 dbo.PurchaseOrderStatus AS POS 
			 ON PO.StatusID = POS.StatusID 
			 LEFT OUTER JOIN
			 dbo.PurchaseOrderDetails AS POD 
			 ON PO.PurchaseOrderID = POD.PurchaseOrderID 
			 LEFT OUTER JOIN
			 PurchaseOrderTotal 
			 ON POD.PurchaseOrderID = PurchaseOrderTotal.PurchaseOrderID 
			 ORDER BY PO.PurchaseOrderID
		SET @ErrorCode = 0;
		SET @Message = 'Selected PurchaseOrders for List';
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		WITH PurchaseOrderTotal AS
		(
			SELECT PO.PurchaseOrderID, IsNull(Sum([Quantity]*UnitCost),0) AS PurchaseOrderTotal 
			FROM PurchaseOrders PO Left Outer JOIN dbo.PurchaseOrderDetails POD
			ON PO.PurchaseOrderID = POD.PurchaseOrderID
			GROUP BY PO.PurchaseOrderID
		)
		SELECT Distinct 
			PO.PurchaseOrderID,
			V.CompanyName AS Vendor,
			S.EmployeeID AS SubmittedByID,
			PO.SubmittedDate,
			S.FirstName + ' ' + S.LastName AS SubmittedByFNLN, 
			A.EmployeeID AS ApprovedByID,
			A.FirstName + ' ' + A.LastName AS ApprovedByFNLN,
			PO.ApprovedDate,
			PO.StatusID,
			POS.StatusName,
			PO.ReceivedDate, 
			PO.ShippingFee,
			Cast(ISNULL(PO.TaxAmount,0) AS Money) AS TaxAmount,
			Cast(ISNULL(PurchaseOrderTotal.PurchaseOrderTotal,0) AS Money) AS PurchaseOrderTotal,
			PO.PaymentDate,
			Cast(PO.PaymentAmount as Money) AS PaymentAmount,
			PO.PaymentMethod 
		FROM dbo.PurchaseOrders PO 
			Left Outer JOIN
			 dbo.Employees AS S 
			 ON PO.SubmittedByID = S.EmployeeID 
			 Left Outer JOIN
			 dbo.Employees as A
			 ON PO.ApprovedByID = A.EmployeeID
			 INNER JOIN
			 dbo.Companies AS V 
			 ON PO.VendorID = V.CompanyID 
			 INNER JOIN
			 dbo.PurchaseOrderStatus AS POS 
			 ON PO.StatusID = POS.StatusID 
			 LEFT OUTER JOIN
			 dbo.PurchaseOrderDetails AS POD 
			 ON PO.PurchaseOrderID = POD.PurchaseOrderID 
			 LEFT OUTER JOIN
			 PurchaseOrderTotal 
			 ON POD.PurchaseOrderID = PurchaseOrderTotal.PurchaseOrderID 
			 WHERE 1 = 0;
	END Catch 
END
GO
/****** Object:  StoredProcedure [dbo].[PurchaseOrdersByProduct]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
==================================================
Author:		 George Hepworth
Create date: 04/21/2025
Description: Get a list of Purchase orders 
			 containing a product or all products
==================================================
*/
CREATE PROCEDURE [dbo].[PurchaseOrdersByProduct]
	@ProductID AS Int = 0,

	@LocalID AS int = 0 OUTPUT ,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Selected' OUTPUT 
AS
BEGIN	
	SET NOCOUNT ON;
	BEGIN Try
		SELECT 
			PO.PurchaseOrderID,
			C.CompanyName AS Vendor,
			PO.SubmittedDate,
			POD.Quantity,
			POD.UnitCost,
			(POD.Quantity * POD.UnitCost) AS ExtendedCost,
			PO.StatusID,
			PO.ReceivedDate,
			POS.StatusName ,
			POD.ProductID
		FROM dbo.Companies AS C INNER JOIN
			 dbo.PurchaseOrders AS PO 
			 ON C.CompanyID = PO.VendorID INNER JOIN
			 dbo.PurchaseOrderDetails AS POD 
			 ON PO.PurchaseOrderID = POD.PurchaseOrderID
			 INNER JOIN PurchaseOrderStatus AS POS
			 ON PO.StatusID = POS.StatusID
		WHERE (@ProductID = 0 OR POD.ProductID = @ProductID) 

		SET @LocalID = @ProductID;
		SET @ErrorCode = 0;
		SET @Message = 'Selected Purchase Orders';
	END Try
	BEGIN Catch
		SET @LocalID = @LocalID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT 
			PO.PurchaseOrderID,
			C.CompanyName AS Vendor,
			PO.SubmittedDate,
			POD.Quantity,
			POD.UnitCost,
			(POD.Quantity * POD.UnitCost) AS ExtendedCost,
			PO.StatusID,
			PO.ReceivedDate,
			POS.StatusName ,
			POD.ProductID
		FROM dbo.Companies AS C INNER JOIN
			 dbo.PurchaseOrders AS PO 
			 ON C.CompanyID = PO.VendorID INNER JOIN
			 dbo.PurchaseOrderDetails AS POD 
			 ON PO.PurchaseOrderID = POD.PurchaseOrderID
			 INNER JOIN PurchaseOrderStatus AS POS
			 ON PO.StatusID = POS.StatusID
		WHERE 1 = 0;
	END Catch 	
END
GO
/****** Object:  StoredProcedure [dbo].[ReceivePurchaseOrder]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=================================================
Author:		 George Hepworth
Create date: 4/24/2025
Description: Receive a PO and Allocate Inventory
=================================================
*/
CREATE PROCEDURE [dbo].[ReceivePurchaseOrder]
	@PurchaseOrderID as int = 0,
	@LocalID as int OUTPUT,
	@LocalErrorCode AS int = 0 OUTPUT,
	@LocalMessage AS nvarchar(400) = 'Allocated all PO Items to Orders' OUTPUT
AS
BEGIN
 SET NOCOUNT ON;
 BEGIN TRY
 DECLARE 
				@ThisProductQuantity as int,
 @Quantity as int,
 @ProductOnOrder as int,
 @QtytoAllocate as int,
 @ProductID as INT,
 @ProductUpdateID as int,
 @PurchaseOrderDetailID as int; 
 BEGIN TRANSACTION;
		IF CURSOR_STATUS('local', 'UpdatePODetails') >= 0
 BEGIN
 CLOSE UpdatePODetails;
 DEALLOCATE UpdatePODetails;
 END
 DECLARE UpdatePODetails CURSOR FAST_FORWARD FOR
 SELECT PurchaseOrderDetailID, 
 ProductID,
 Quantity
 FROM PurchaseOrderDetails
 WHERE PurchaseOrderID = @PurchaseOrderID; 
 OPEN UpdatePODetails;
 FETCH NEXT FROM UpdatePODetails 
 INTO @PurchaseOrderDetailID, @ProductID, @ThisProductQuantity;
 WHILE @@FETCH_STATUS = 0
 BEGIN
 EXEC [dbo].[AllocateInventory]
 @ProductID = @ProductID,
 --@POQuantity = @ThisProductQuantity,
 @LocalID = @ProductUpdateID OUTPUT, 
 @LocalErrorCode = @LocalErrorCode OUTPUT,
 @LocalMessage = @LocalMessage OUTPUT
 --Check if AllocateInventory was successful
 IF @LocalErrorCode <> 0
 BEGIN
 RAISERROR(@LocalMessage, 16, 1)
 END
 FETCH NEXT FROM UpdatePODetails 
 INTO @PurchaseOrderDetailID, @ProductID, @ThisProductQuantity;
 END
 CLOSE UpdatePODetails;
 DEALLOCATE UpdatePODetails;
 --Check if UpdatePOStatus was successful
 IF @LocalErrorCode <> 0
 BEGIN
 RAISERROR(@LocalMessage, 16, 1);
 END
 COMMIT TRANSACTION;
 SET @LocalID = @PurchaseOrderID;
 SET @LocalErrorCode = 0;
 SET @LocalMessage = 'Successfully allocated Purchase Order to all Orders for ' 
 + CAST(@PurchaseOrderID AS VARCHAR);
 END TRY
 BEGIN CATCH
 IF @@TRANCOUNT > 0
 ROLLBACK TRANSACTION; 
 --Only close/deallocate cursor if it was successfully opened
 IF CURSOR_STATUS('local', 'UpdatePODetails') >= 0
 BEGIN
 CLOSE UpdatePODetails;
 DEALLOCATE UpdatePODetails;
 END
 SET @LocalID = @PurchaseOrderID;
 SET @LocalErrorCode = ERROR_NUMBER();
 SET @LocalMessage = ERROR_MESSAGE();
 END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[SelectEmployeeforApprove]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
=============================================
Author:		 George Hepworth
Create date: 4/1/2025
Description: Select Employees for Approvals
=============================================
*/
CREATE PROCEDURE [dbo].[SelectEmployeeforApprove] 
	@LocalID AS int = 0 OUTPUT ,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
	Declare @Approve as int = 1;
		SELECT 
			E.EmployeeID, 
			E.LastName, 
			E.FirstName,
			NameLF,
			NameFL,
			E.PrivilegeID,
			E.PrivilegeName
		FROM vw_employees AS E
		WHERE E.PrivilegeID = @Approve;
		SET @ErrorCode = 0;
		SET @Message = 'Selected Employees for ApprovedBy';
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT 
			E.EmployeeID, 
			E.LastName, 
			E.FirstName,
			NameLF,
			NameFL,
			E.PrivilegeID,
			E.PrivilegeName
		FROM vw_employees AS E
		WHERE 1 = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[SelectEmployeeforSubmit]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=================================================
Author:		 George Hepworth
Create date: 4/1/2025
Description: Select Employees for Order Submittals
=================================================
*/
CREATE PROCEDURE [dbo].[SelectEmployeeforSubmit] 
	@LocalID AS int = 0 OUTPUT ,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
	Declare @Approve as int = 1;
		SELECT 
			E.EmployeeID, 
			E.LastName, 
			E.FirstName,
			NameLF,
			NameFL,
			E.PrivilegeID,
			E.PrivilegeName
		FROM vw_employees AS E
		WHERE E.PrivilegeID is Null OR E.PrivilegeID <> @Approve;
		SET @ErrorCode = 0;
		SET @Message = 'Selected Employees for SubmittedBy';	
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT 
		E.EmployeeID, 
		E.LastName, 
		E.FirstName,
		NameLF,
		NameFL,
		E.PrivilegeID,
		E.PrivilegeName
		FROM vw_employees AS E
		WHERE 1 = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[SelectEmployeesforList]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/1/2025
Description: Select Employees for List Screen
=============================================
*/
CREATE PROCEDURE [dbo].[SelectEmployeesforList] 
	@LocalID AS int = 0 OUTPUT ,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT 
			E.EmployeeID, 
			E.LastName, 
			E.FirstName,
			NameLF,
			NameFL,
			NameTitleFL,
			E.EmailAddress, 
			E.JobTitle, 
			E.PrimaryPhone, 
			E.SecondaryPhone, 
			E.Title, 
			E.Notes, 
			E.SupervisorID,
			Supervisor,
			E.WindowsUserName, 
			E.EmployeeImageName,
			E.EmployeeImagePA,
			PrivilegeID,
			PrivilegeName
		FROM vw_employees AS E;
		SET @ErrorCode = 0;
		SET @Message = 'Selected Employees for Employee List';
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT 
			E.EmployeeID, 
			E.LastName, 
			E.FirstName,
			NameLF,
			NameFL,
			NameTitleFL,
			E.EmailAddress, 
			E.JobTitle, 
			E.PrimaryPhone, 
			E.SecondaryPhone, 
			E.Title, 
			E.Notes, 
			E.SupervisorID,
			Supervisor,
			E.WindowsUserName, 
			E.EmployeeImageName,
			E.EmployeeImagePA,
			PrivilegeID,
			PrivilegeName
		FROM vw_employees AS E
		WHERE 1 = 0;
	END Catch 
END
GO
/****** Object:  StoredProcedure [dbo].[SelectOrderList]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/19/2025
Description: Select Orders with filters
=============================================
*/
 CREATE PROCEDURE [dbo].[SelectOrderList] 
 @OrderID As Int = 0, 
 @EmployeeID As Int = 0,
 @CustomerID As Int = 0,
	@Orderdate as Date = Null,
 @OrderDateStart As nvarchar(30) = NULL, --Accept date as string
 @OrderDateEnd As nvarchar(30) = NULL, --Accept date as string
 @OrderStatusID As Int = Null,

 @LocalID AS int = 0 OUTPUT,
 @ErrorCode AS int = 0 OUTPUT,
 @Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
 SET NOCOUNT ON;
 BEGIN TRY
 DECLARE @OrderDateStartDT DATE = 
			CASE 
 WHEN @OrderDateStart IS NULL THEN NULL
 ELSE TRY_CONVERT(DATE, @OrderDateStart) 
			END;
		Print @OrderDateStartDT;
 DECLARE @OrderDateEndDT DATE = CASE 
 WHEN @OrderDateEnd IS NULL THEN NULL
 ELSE TRY_CONVERT(DATE, @OrderDateEnd)
			END;
		DECLARE	@CustomErrorCode as int,
				@CustomErrorMessage as NVarChar(400);
		SELECT [OrderID]
				,[EmployeeID]
				,[EmployeeFNLN]
				,[CustomerID]
				,[Customer]
				,[OrderDate]
				,[ShippedDate]
				,[ShippingFee]
				,[OrderTotal]
				,[OrderStatusID]
				,[OrderStatusName]
				,[PaidDate]
				,[MinOfSortOrder]
				,[OrderDetailStatusName]
				,@EmployeeID AS OrderFilter
		FROM [dbo].[vw_OrderList]
 WHERE 
 -- Add filters based on parameter values
			-- These filters reflect the current "special filtering" on the Order list screen
 (@OrderID = 0 OR OrderID = @OrderID)
 AND (@EmployeeID = 0 OR EmployeeID = @EmployeeID)
 AND (@CustomerID = 0 OR CustomerID = @CustomerID)
 AND (@OrderDateStartDT IS NULL OR OrderDate >= dateAdd(d,-14,@OrderDateStartDT)) 
 AND (@OrderDateEndDT IS NULL OR OrderDate <= @OrderDateEndDT)
			AND (@OrderStatusID = 0 OR OrderStatusID <> @OrderStatusID);
 
 SET @LocalID = ISNULL(@OrderID, 0);
 SET @ErrorCode = 0;
 SET @Message = 'Selected Order List';
 END TRY
 BEGIN CATCH
 SET @LocalID = ISNULL(@OrderID, 0);
 SET @ErrorCode = ERROR_NUMBER();
 SET @Message = ERROR_MESSAGE();
 -- Return an empty result set with the correct schema
 SELECT 
 [OrderID],
 [EmployeeID],
 [CustomerID],
 [OrderDate],
 [InvoiceDate],
 [ShippedDate],
 [ShipperID],
 [ShippingFee],
 [TaxRate],
 [TaxStatusID],
 [PaymentMethod],
 [PaidDate],
 [Notes],
 [OrderStatusID]
 FROM Orders
 WHERE 1 = 0;
 END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[SelectWelcome]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
=============================================
Author:		 George Hepworth
Create date: 6/16/2025
Description: Select Welcome 
=============================================
*/
CREATE PROCEDURE [dbo].[SelectWelcome] 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Selected' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT [ID]
			,[Welcome]
			,[Learn]
		FROM [dbo].[Welcome]
		SET @ErrorCode = 0;
		SET @Message = 'Selected Welcome' ;
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[SSEErrorList]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 2025-05-14
Description: SS Errors for reference
=============================================
*/
CREATE PROCEDURE [dbo].[SSEErrorList] 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT [SSErrorID]
			 ,[SSError]
		FROM SSERRORs
		ORDER BY SSErrorID
		SET	@ErrorCode = 0;
		SET	@Message = 'Success';
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT [SSErrorID]
			 ,[SSError]
		FROM SSERRORs
		WHERE 1 = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[StatesList]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 2025-05-14
Description: States List
=============================================
*/
CREATE PROCEDURE [dbo].[StatesList] 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT [StateAbbrev]
			 ,[StateName]
		FROM [dbo].[States]
		ORDER BY StateAbbrev;
		SET	@ErrorCode = 0;
		SET	@Message = 'Success';
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT [StateAbbrev]
			 ,[StateName]
		FROM [dbo].[States]
		WHERE 1 = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Statuses]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 5/14/2025
Description: List Status of Orders,OrderDetails
			 and PurchaseOrders
=============================================
*/
CREATE PROCEDURE [dbo].[Statuses] 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT 
			'Orders' as TableName,
			OrderStatusID as StatusID,
			OrderStatusCode as StatusCode,
			OrderStatusName As StatusName,
			SortOrder
		FROM orderStatus 
		UNION
		SELECT 
			'OrderDetails' as TableName,
			OrderDetailStatusID as StatusID,
			'' as StatusCode,
			OrderDetailStatusName As StatusName,
			SortOrder
		FROM OrderDetailStatus
		UNION
		SELECT 
			'PurchaseOrders' as TableName,
			StatusID as StatusID,
			'' as StatusCode,
			StatusName As StatusName,
			SortOrder
		FROM PurchaseOrderStatus
		Order By TableName, SortOrder;
 END TRY
	BEGIN Catch
		SELECT 
			'Orders' as TableName,
			OrderStatusID as StatusID,
			OrderStatusCode as StatusCode,
			OrderStatusName As StatusName,
			SortOrder
		FROM orderStatus 
		UNION
		SELECT 
			'OrderDetails' as TableName,
			OrderDetailStatusID as StatusID,
			'' as StatusCode,
			OrderDetailStatusName As StatusName,
			SortOrder
		FROM OrderDetailStatus
		UNION
		SELECT 
			'PurchaseOrders' as TableName,
			StatusID as StatusID,
			'' as StatusCode,
			StatusName As StatusName,
			SortOrder
		FROM PurchaseOrderStatus
		WHERE 1 = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[StockLevelCheck]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=======================================================
Author:		George Hepworth
Create date: 20250317
Description:	Check Stock Level of Products on Order
=======================================================
*/
CREATE PROCEDURE [dbo].[StockLevelCheck]
	@ProductID AS Int,
	@CurrentLineItemqty AS Int = 0, --Int because in NW Dev, fractional quantities are not allowed
	@StockLevelProductID as int OUTPUT, 	 
	@ErrorCode AS int OUTPUT,
	@Message AS nvarchar(400) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT * FROM Products
		WHERE ProductID = @ProductID;	
		/*TO DO: Calculate amount bought, amount sold, amount allocated and amount last inventory
		 and insert new stock take */
		SET @StockLevelProductID = SCOPE_IDENTITY(); 
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Success'; 
	End Try
	BEGIN Catch
		SET @StockLevelProductID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT * FROM Products
		WHERE 1 = 0;
	END Catch	

END
GO
/****** Object:  StoredProcedure [dbo].[StockTakeList]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: May 14, 2025
Description: The Stock Take List
=============================================
*/
CREATE PROCEDURE [dbo].[StockTakeList] 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT [StockTakeID]
			,[StockTakeDate]
			,[ProductID]
			,[QuantityOnHand]
			,[ExpectedQuantity]
		FROM [dbo].[StockTake]
		ORDER BY ProductID, StockTakeDate;
		SET	@ErrorCode = 0;
		SET	@Message = 'Success';
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT [StockTakeID]
			,[StockTakeDate]
			,[ProductID]
			,[QuantityOnHand]
			,[ExpectedQuantity]
		FROM [dbo].[StockTake]
		WHERE 1 = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[TablesFieldNames]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 2025-05-14
Description: Companies and field names 
			 for the show/hide columns feature
=============================================
*/
CREATE PROCEDURE [dbo].[TablesFieldNames]
	@TableName as nvarchar(24) = Null,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT T.Name as TableName, AC.name AS FieldName
		FROM 
		sys.tables AS T
		INNER JOIN 
		sys.all_columns AS AC
		ON t.object_id = AC.object_id
		WHERE T.Name = Case 
					 WHEN @TableName Is Null
					 THEN T.Name
					 Else @TableName
					 END
		AND 
		AC.Name Not like'Added%'
		AND 
		AC.Name Not like'Modified%' 
		AND 
		AC.Name Not like 'SSMA%'

		SET	@ErrorCode = 0;
		SET	@Message = 'Success';
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT T.Name as TableName, AC.name AS FieldName
		FROM 
		sys.tables AS T
		INNER JOIN 
		sys.all_columns AS AC
		ON t.object_id = AC.object_id
		WHERE 1 = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[TaxStatusList]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 2025-05-14
Description: Tax Status List
=============================================
*/
CREATE PROCEDURE [dbo].[TaxStatusList] 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT [TaxStatusID]
	 ,[TaxStatus]
		FROM [dbo].[TaxStatus]
		ORDER BY TaxStatusID
		SET	@ErrorCode = 0;
		SET	@Message = 'Success';
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT [TaxStatusID]
	 ,[TaxStatus]
		FROM [dbo].[TaxStatus]
		WHERE 1 = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[TitleList]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 2025-05-14
Description: Tax Status
=============================================
*/
CREATE PROCEDURE [dbo].[TitleList] 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT [Title]
		FROM [dbo].[Titles]
		ORDER BY Title
		SET	@ErrorCode = 0;
		SET	@Message = 'Success';
	END Try
	BEGIN Catch
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT [Title]
		FROM [dbo].[Titles]
		WHERE 1 = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmployeePhoto]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 3/30/2025
Description: Insert Employee Photo
=============================================
*/
CREATE PROCEDURE [dbo].[UpdateEmployeePhoto]
 @EmployeeID as INT= 0,
 @ImageData as varchar(MAX),
	@NewEmployeeID as Int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	BEGIN Try
		--PowerApps can't directly update tables with Triggers
		EXEC('DISABLE TRIGGER DatabaseEventsTrigger ON Employees'); 
		UPDATE Employees
		SET [EmployeeImage] = CAST(
		CAST(N'' AS XML).value('xs:base64Binary(sql:variable("@ImageData"))', 'VARBINARY(MAX)') 
		AS VARBINARY(MAX)) 
		WHERE EmployeeID = @EmployeeID
		EXEC('ENABLE TRIGGER DatabaseEventsTrigger ON Employees');
		SET @NewEmployeeID = @EmployeeID;
		SET	@ErrorCode = 0;
		SET	@Message ='Success';
	End Try
	BEGIN Catch
		SET	@NewEmployeeID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateOrderStatus]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 05-08-2025
Update date: 07-13-2025
Description: Update Order Status and relevant dates
=============================================
*/
CREATE PROCEDURE [dbo].[UpdateOrderStatus] 
	@OrderID AS int = 0,
	@OrderStatusID as int = null,
	@EmployeeID as int = 10,
	@CustomerID as int = Null, 
	@ShipperID as int = Null,
	@ShippingFee as money = Null,
	@TaxRate as Decimal(6,3) = Null,
	@TaxStatusID AS int = Null,
	@PaymentMethod as nvarchar(50) = Null,		
	@Notes as nvarchar(4000) = Null,

	@LocalID as int = 0 OUTPUT,
	@NewOrderStatusID AS int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SET @LocalID = @OrderID;
		Declare	
				@CurrentOrderStatusID as int,
				@CurrentShipperID as int,
				@NewShipperID as int,
				@CurrentShipFee as money,
				@NewShipFee as money,
				@CurrentEmployeeID as int,
				@NewEmployeeID as int,
				@CurrentCustomerID as int,
				@NewCustomerID as int,
				@CurrentLineItems as int,
				@CurrentLineItemsUnAllocated as int,
				@NewInvoicedDate as datetime,
				@NewPaidDate as datetime,
				@NewShippedDate as datetime,
				@CurrentPaymentMethod as nvarchar(10),
				@NewPaymentMethod as nvarchar(10),
				@NewOrderDetailStatusID as int = null,
				@CustomErrorCode as int,
				@CustomErrorMessage as NVarChar(400);
		Select	
			@CurrentShipFee = ShippingFee,
			@CurrentOrderStatusID = OrderStatusID,
			@CurrentShipperID = ShipperID,
			@CurrentEmployeeID = EmployeeID,
			@CurrentCustomerID = CustomerID,
			@CurrentPaymentMethod = PaymentMethod 
		FROM	Orders
		WHERE	OrderID = @OrderID;
--Step 1: Make sure the user clicked a button in the proper sequence.
		BEGIN
			If @OrderStatusID = 2 AND @CurrentOrderStatusID <> 3 
			BEGIN
				Set @ErrorCode = 53290;
				SET @Message ='Select in proper sequence: create invoice for a new order';
				RETURN;

			END
		END
		BEGIN
			If @OrderStatusID = 4 AND @CurrentOrderStatusID <> 2
			BEGIN
				Set @ErrorCode = 53291;
				SET @Message = 'Select in proper sequence: ship order after invoice';
				RETURN;
			END
		END
		BEGIN
			If @OrderStatusID = 5 AND @CurrentOrderStatusID <> 4
			BEGIN
				Set @ErrorCode = 53292;
				SET @Message = 'Select in proper sequence: receive payment after shipping';
				RETURN;
			END
		END
		BEGIN
			If @OrderStatusID = 1 AND @CurrentOrderStatusID <> 5
			BEGIN
				Set @ErrorCode = 53293;
				SET @Message ='Select in proper sequence: close order after receiving payment';
				RETURN;
			END
		END

--Step 2a: Validate the Order has one or more line items 
		BEGIN
			SELECT @CurrentLineItems = COUNT(*)
			FROM	 OrderDetails
			WHERE	 OrderID = @OrderID;	
			Print @CurrentLineItems;
			IF @CurrentLineItems = 0 and @OrderID <> 0
			Begin
				Set @ErrorCode = 53230;
				SET @Message = 'Orders cannot be invoiced 
					without one or more Order Details '; 
				RETURN;
		 END
		END
--Step 2b: Validate the all line items are in allocated status
		BEGIN
			SELECT @CurrentLineItemsUnAllocated = COUNT(*)
			FROM	 OrderDetails
			WHERE	 OrderID = @OrderID 
			AND OrderDetails.OrderDetailStatusID In (3,4,5);	

			IF @CurrentLineItemsUnAllocated <> 0 and @OrderID <> 0
				Begin
					Set @ErrorCode = 53240;
					SET @Message = 'Orders cannot be invoiced 
					without all Order Details allocated'; 
					RETURN;
				END
		END
--Step 3: Validate the Shipping Fee and Shipper ID are 
-- 		 a) supplied as @ShippingFee & @ShipperID or 
-- b) previously recorded as @CurrentShippingFee @ShippingFee
-- before allowing a PO to be submitted.
		BEGIN
			IF @CurrentShipFee Is Null and @ShippingFee Is Null and @OrderID <> 0
				Begin
					Set @ErrorCode = 53260;
					SET @Message = 'Orders cannot be submitted 
					without a Shipping Fee';
					RETURN;
				END
			ELSE
				Set @NewShipFee = Case 
								 WHEN @CurrentShipFee <> @ShippingFee 
								 THEN @ShippingFee 
								 ELSE @CurrentShipFee
								 END;

			If @CurrentShipperID Is Null and @ShipperID Is Null and @OrderID <> 0
				Begin
					Set @ErrorCode = 53270;
					SET @Message = 'Orders cannot be submitted without a Shipper';
					RETURN;
				END
			ELSE
				Set @NewShipperID = Case 
								 WHEN @CurrentShipperID <> @ShipperID 
								 THEN @ShipperID
								 ELSE @CurrentShipperID
								 END;
		END
					
-- Although this code would allow an override of saved values for Employee, Shipper, etc.,
-- regular users entering orders can't change them in the interface.
-- Therefore, those changes will only be available for an Admin with permissions 
-- to make changes in the interface.

-- Step 4: Progress through statuses

	If @CurrentOrderStatusID = 3 -- New Order to progress to invoiced
		BEGIN
			If @CurrentEmployeeID is Null and @EmployeeID Is Null
			Begin
				Set @ErrorCode = 53270;
				SET @Message = 'To invoice the Order, select the employee who took it.';
				RETURN;
			END
			Set @NewEmployeeID = Case 
								 WHEN @CurrentEmployeeID <> @EmployeeID
								 THEN @EmployeeID
								 ELSE @CurrentEmployeeID
								 END;

			Set @NewInvoicedDate = GetDate();
			Set @NewOrderStatusID = 2; --Invoiced
			Set @NewOrderDetailStatusID = 2;--Invoiced because the order can't be invoiced with unallocated items
		END
	Else IF @CurrentOrderStatusID = 2 -- Invoiced Order to progress to shipped
		BEGIN
		 	
			Set @NewShippedDate = GetDate();
			Set @NewOrderStatusID = 4; -- Shipped
			Set @NewOrderDetailStatusID = 6; -- Shipped because the order is shipped
		END
	ELSE IF @CurrentOrderStatusID = 4 -- Shipped Order to progress to Paid	
		BEGIN
			Set @NewPaidDate = GetDate();
			Set @NewOrderStatusID = 5; -- Paid
			Set @NewOrderDetailStatusID = 6; -- Shipped because the order is paid (no change)
		END
	ELSE If @CurrentOrderStatusID = 5 -- Paid Order to progress to closed
		BEGIN
			Print @CurrentOrderStatusID;
			Set @NewOrderStatusID = 1 ;-- Closed
			Set @NewOrderDetailStatusID = 6; -- Shipped because the order is closed (no change)
			Set @NewPaymentMethod = CASE WHEN @CurrentPaymentMethod <> @PaymentMethod
										 THEN @PaymentMethod
										 ELSE @CurrentPaymentMethod
										 END;
			BEGIN
				If @NewPaymentMethod Is Null
				Begin
					Set @ErrorCode = 53280;
					SET @Message = 'Indicate the payment method and try again.';
					RETURN;
				END
			END
		END

--Step 5: Update the order with the new status and status date

	Exec dbo.Z_UpdateOrder
		 @OrderID = @OrderID 
		,@TaxRate = @TaxRate
		,@TaxStatusID = @TaxStatusID
		,@Notes = @Notes
		,@OrderStatusID = @NewOrderStatusID
		,@ShipperID = @NewShipperID
		,@ShippingFee = @NewShipFee
		,@InvoiceDate = @NewInvoicedDate
		,@ShippedDate = @NewShippedDate
		,@PaymentMethod = @NewPaymentMethod
		,@PaidDate = @NewPaidDate

		,@LocalID = @LocalID OUTPUT
		,@ErrorCode = @ErrorCode OUTPUT
		,@Message = @Message OUTPUT;
		SET @LocalID = @OrderID;

--Step 6: Update the current order detail Status For the entire Order
		UPDATE dbo.OrderDetails
		SET	OrderDetailStatusID = IsNull(@NewOrderDetailStatusID ,OrderDetailStatusID) 
		WHERE OrderID = @OrderID; 
		IF @ErrorCode = 0
			BEGIN
				SET @ErrorCode = @ErrorCode;
				SET @Message = @Message;
			END
		ELSE
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @ErrorCode,
					@CurrentObject = 'Orders',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;
				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
			END
		SET @NewOrderStatusID = @NewOrderStatusID;
	End Try
	BEGIN Catch
		SET @LocalID = @OrderID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SET @NewOrderStatusID = @CurrentOrderStatusID; 
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[UpdatePOStatus]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
===================================================
Author:		 George Hepworth
Create date: 05/06/2025
Description: Validate PO Status at various stages, 
			 Update as appropriate
===================================================
*/
CREATE PROCEDURE [dbo].[UpdatePOStatus]
	@PurchaseOrderID as int,
	@StatusID as int = null,
	@SubmittedbyID as int = 10, --Default to Internet Orders
	@ApprovedbyID as int = Null,
	@VendorID as int = Null,
	@ShippingFee as money = Null,
	@PaymentAmount AS money = Null,	 
	@TaxAmount AS money = Null,
	@PaymentMethod as nvarchar(50) = Null,

	@LocalID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Purchase Order Status' OUTPUT,
	@NewStatusID as int OUTPUT
AS
BEGIN
	SET NOCOUNT ON;	
	BEGIN TRY
		SET @LocalID = @PurchaseOrderID;
		Declare	
				@CurrentStatusID as int,
				@CurrentVendorID as int,
				@NewVendorID as int,
				@CurrentLineItems as int,
				@CurrentShipFee as money,
				@NewShipFee as money,
				@CurrentSubmittedByID as int,
				@NewSubmittedByID as int,
				@CurrentApprovedByID as int,
				@NewApprovedByID as int,
				@CurrentPaymentAmount as money,
				@NewPaymentAmount as money,
				@CurrentPaymentMethod as nvarchar(10),
				@NewPaymentMethod as nvarchar(10),
				@CurrentTaxAmount as money,
				@NewTaxAmount as Money,
				@NewOrderSubtotal as money,
				@ProductID as int,
				@PurchaseOrderDetailID as int,
				@NewSubmittedDate as datetime = null,
				@NewApprovedDate as datetime = null,
				@NewPaymentDate as datetime = null,
				@NewReceivedDate as datetime = null,
				@CustomErrorCode as int,
				@CustomErrorMessage as NVarChar(400);
		Select	
				@CurrentStatusID = StatusID,
				@CurrentShipFee = ShippingFee,
				@CurrentVendorID = VendorID,
				@CurrentSubmittedByID = SubmittedByID,
				@CurrentApprovedByID = ApprovedByID,
				@CurrentPaymentAmount = PaymentAmount,
				@CurrentPaymentMethod = @PaymentMethod,
				@CurrentTaxAmount = TaxAmount
			FROM	PurchaseOrders
			WHERE	PurchaseOrderID = @PurchaseOrderID;	
-- Step 1: Make sure the user clicked a button in the proper sequence.
			SET @ErrorCode = 0;
			SET @Message = 'Initialized';
			SET @NewStatusID= @CurrentStatusID;
			If Coalesce(@StatusID, 0) = 4 and @CurrentStatusID <> 3
			BEGIN
				SET @ErrorCode = 52290;
				SET @Message = 'Select in proper Order: Submit a new purchase order';
				RETURN;
			END
			If Coalesce(@StatusID, 0) = 1 and @CurrentStatusID <> 4
			BEGIN
				SET @ErrorCode = 52291;
				SET @Message = 'Please Select in proper Order: Approve submitted purchase order';
				RETURN;
			END
			If Coalesce(@StatusID, 0) = 5 and @CurrentStatusID <> 1
				BEGIN
					SET @ErrorCode = 52292;
					SET @Message = 'Select in proper Order: Receive approved purchase order';
					RETURN;
				END
			If Coalesce(@StatusID, 0) = 2 and @CurrentStatusID <> 5
				BEGIN
					SET @ErrorCode = 52293;
					SET @Message = 'Select in proper Order: Close received purchase order';
					RETURN;
				END

--Step 2: Validate the PO has one or more line items 
 
		SELECT @CurrentLineItems = COUNT(*)
		FROM	PurchaseOrderDetails
		WHERE	PurchaseOrderID = @PurchaseOrderID;	
		IF @CurrentLineItems = 0
			BEGIN
				SET @ErrorCode = 51230;
				SET @Message = 'Purchase Orders cannot be submitted 
							without one or more PurchaseOrder Details '; 
				RETURN;
			END
--Step 3: Validate the Shipping Fee and Vendor ID are supplied or previously recorded 
-- before allowing a PO to be submitted.
		IF @CurrentShipFee Is Null and @ShippingFee Is Null
			BEGIN
				SET @ErrorCode = 51260;
				SET @Message = 'Purchase Orders cannot be submitted 
					without a Shipping Fee ';
				RETURN;
			END
			SET @NewShipFee = CASE WHEN @CurrentShipFee<> @ShippingFee
									THEN @ShippingFee
									ELSE @CurrentShipFee
									END;
		If @CurrentVendorID Is Null and @VendorID Is Null
			BEGIN
				SET @ErrorCode = 51290;
				SET @Message = 'Purchase Orders cannot be submitted without a Vendor';
				RETURN;
			END
			Set @NewVendorID= CASE 
								WHEN IsNull(@CurrentVendorID,0)<> @VendorID
								THEN @VendorID
								ELSE @CurrentVendorID
								END;				
-- Although this code would allow an override of saved values for Employee, Vendor, etc.,
-- regular users entering purchase orders can't change them in the interface.
-- Therefore, those changes will only be available for an Admin with permissions 
-- make changes in the interface.

--Step 4: Progress through statuses as appropriate

		IF @StatusID = 4 AND @CurrentStatusID = 3 -- New PO to submitted
			If @SubmittedByID Is Null
				BEGIN
					SET @ErrorCode = 51300;
					SET @Message = 'To submit the Purchase Order, select the person who submitted it.';	
					RETURN;
				END
				BEGIN
					SET @NewSubmittedDate = GetDate();
					SET @NewSubmittedByID = Case 
											WHEN IsNull(@CurrentSubmittedByID,0) <> @SubmittedbyID
											THEN @SubmittedByID
											ELSE @CurrentSubmittedByID
											END;
					SET @NewStatusID = 4; -- Submitted
				END
		IF @StatusID = 1 AND @CurrentStatusID = 4 -- Submitted PO to Approved
			BEGIN
				IF @ApprovedByID Is Null
					BEGIN
						SET @ErrorCode = 51310;
						SET @Message = 'To approve the Purchase Order, select the Approval person who approved it.';
						RETURN;
					END
				ELSE
					BEGIN
						Set @NewApprovedDate = GetDate();
						Set @NewApprovedByID = Case 
												WHEN IsNull(@CurrentApprovedByID,0) <> @ApprovedbyID
												THEN @ApprovedByID
												ELSE @CurrentApprovedByID
												END;
						Set @NewStatusID = 1; -- Approved
					END
			END
		IF @StatusID = 5 AND @CurrentStatusID = 1 -- Approved PO to received
			BEGIN
				Set @NewReceivedDate = GetDate();
				Set @NewStatusID = 5; -- Paid
			END
		IF @StatusID = 2 AND @CurrentStatusID = 5 -- Paid PO to closed; include calculated payment information
			BEGIN
				SELECT @NewOrderSubtotal = SUM(Quantity * UnitCost) 
					FROM PurchaseOrderDetails POD
					WHERE POD.PurchaseOrderID = @PurchaseOrderID;
				Set @NewPaymentDate = GetDate();
				WITH NWTaxRate AS 
				(SELECT SettingValue from SystemSettings 
				WHERE systemsettings.SettingID = 6) -- 6 is the tax rate paid by Northwind to all vendors
				Select @NewTaxAmount = (Sum(Quantity*UnitCost) * NWTaxRate.SettingValue)
				From 	 PurchaseOrderDetails POD, NWTaxRate
				Where PurchaseOrderID = @PurchaseOrderID
				GROUP BY NWTaxRate.SettingValue;
				Set @NewPaymentMethod = CASE 
										WHEN IsNull(@CurrentPaymentMethod,'') <> @PaymentMethod
										THEN @PaymentMethod
										ELSE @CurrentPaymentMethod
										END;
				Set @NewPaymentAmount = IsNull(@NewOrderSubtotal,0) + 
										IsNull(@NewTaxAmount,0) +
										IsNull(@NewShipFee,0);
				Set @NewStatusID = 2 ;-- Closed
			END	
		
		
		Exec dbo.Z_UpdatePO
			 @PurchaseOrderID = @PurchaseOrderID
			,@SubmittedByID = @NewSubmittedByID
			,@SubmittedDate = @NewSubmittedDate
			,@ApprovedByID = @NewApprovedByID
			,@ApprovedDate = @NewApprovedDate
			,@ReceivedDate = @NewReceivedDate
			,@ShippingFee = @newShipFee
			,@TaxAmount = @NewTaxAmount
			,@PaymentDate = @NewPaymentDate
			,@PaymentAmount = @NewPaymentAmount
			,@PaymentMethod = @NewPaymentMethod
			,@VendorID = @newVendorID
			,@StatusID = @NewStatusID

			,@LocalID = @LocalID OUTPUT
			,@ErrorCode = @ErrorCode OUTPUT;

/*In order to keep received date/status in synch for POs and PODetails
also update PO Details for this PO */	 
		BEGIN
			UPDATE PurchaseOrderDetails
			SET PurchaseOrderDetails.ReceivedDate = PurchaseOrders.ReceivedDate
			FROM PurchaseOrders INNER JOIN PurchaseOrderDetails 
			ON PurchaseOrders.PurchaseOrderID = PurchaseOrderDetails.PurchaseOrderID 
			WHERE PurchaseOrders.PurchaseOrderID = @PurchaseOrderID;
		END

		IF @ErrorCode <> 0
			BEGIN
				EXEC CustomErrorMessage
					@SysErrorCode = @ErrorCode,
					@CurrentObject = ' Purchase Orders',
					@CustomErrorCode = @CustomErrorCode OUTPUT,
					@CustomErrorMessage = @CustomErrorMessage OUTPUT;
				SET @ErrorCode = @CustomErrorCode;
				SET @Message = @CustomErrorMessage;
				SET @NewStatusID = @CurrentStatusID;
			END	
	END Try
	BEGIN Catch
		SET @LocalID = @PurchaseOrderID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		Set @NewStatusID = @CurrentStatusID;
	END Catch	
END
GO
/****** Object:  StoredProcedure [dbo].[Z_AddCompany]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
================================================================
Author:		 George Hepworth
Create date: 4/1/2025
Description: Add a Company
 Called by the Master Stored Procedure, CRUDCompany
================================================================
*/
CREATE PROCEDURE [dbo].[Z_AddCompany] 
	@CompanyName As nvarchar(50),
	@CompanyTypeID AS int = 1 , --Required field. Default to Company. 
	@BusinessPhone AS nvarchar(20) = Null,
	@Address As nvarchar(255),--Required field.
	@City nvarchar(255),--Required field.
	@StateAbbrev nvarchar(2),--Required field.
	@Zip nvarchar(10),--Required field.
	@Website nvarchar(1024) = Null,
	@Notes nvarchar(Max) = Null , 
	@StandardTaxStatusID int = 0, --Default to Tax Exempt

	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Company Added' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	Begin Try
		INSERT INTO [dbo].[Companies]
 ([CompanyName]
 ,[CompanyTypeID]
 ,[BusinessPhone]
 ,[Address]
 ,[City]
 ,[StateAbbrev]
 ,[Zip]
 ,[Website]
 ,[Notes]
 ,[StandardTaxStatusID]
		 )
		VALUES
 (
			 @CompanyName 
			, @CompanyTypeID 
			, cast(NULLIF(@BusinessPhone ,'') AS nvarchar(20))
			, @Address
			, @City
			, @StateAbbrev
			, @Zip
			, cast(NULLIF(@Website,'') AS nvarchar(1024))
			, cast(NULLIF(@Notes,'') AS nvarchar(Max))
			, @StandardTaxStatusID	
			);
		SET @LocalID = SCOPE_IDENTITY(); 
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Added '+ @CompanyName ; 
	End Try
	BEGIN Catch
		SET @LocalID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch	
END
GO
/****** Object:  StoredProcedure [dbo].[Z_AddEmployee]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/1/2025
Description: Add an Employee
=============================================
*/
CREATE PROCEDURE [dbo].[Z_AddEmployee] 
	@FirstName nvarchar(20) = Null,
	@LastName nvarchar(30)= Null,
	@EmailAddress nvarchar(255) = Null,
	@JobTitle nvarchar(20),
	@PrimaryPhone nvarchar(20) = Null,
	@SecondaryPhone nvarchar(20) = Null,
	@Title nvarchar(20) = Null,
	@Notes nvarchar(4000) = Null,
	@SupervisorID int = Null,
	@WindowsUserName nvarchar(50) = Null,

	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		BEGIN
			If @FirstName is Null
				Throw 54000 ,'First Name is required', 16;
			If @LastName is Null
				Throw 54100 ,'Last Name is required', 16;
			If @Title is Null
				Throw 54200 ,'Title is required', 16;
			END
		INSERT INTO [dbo].[Employees]
			(
			 [FirstName]
			,[LastName]
			,[EmailAddress]
			,[JobTitle]
			,[PrimaryPhone]
			,[SecondaryPhone]
			,[Title]
			,[Notes]
			,[SupervisorID]
			,[WindowsUserName]
			)
		VALUES
			( 
			 @FirstName
			,@LastName
			,cast(NULLIF(@EmailAddress,'') AS nvarchar(255)) 
			,@JobTitle 
			,cast(NULLIF(@PrimaryPhone ,'') AS nvarchar(20)) 
			,cast(NULLIF(@SecondaryPhone ,'') AS nvarchar(20)) 
			,cast(NULLIF(@Title ,'') AS nvarchar(20))
			,cast(NULLIF(@Notes,'') AS nvarchar(4000))
			,Case WHEN @SupervisorID = 0 Then Null Else @SuperVisorID END
			,cast(NULLIF(@WindowsUserName ,'') AS nvarchar(50))
			)
		SET @LocalID = SCOPE_IDENTITY(); 
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Added ' + @Title+ ' ' + @FirstName +' ' + @LastName; 
	End Try
	BEGIN Catch
		SET @LocalID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_AddMRU]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
================================================================
Author:		 George Hepworth
Create date: 5/27/2025
Description: Add an MRU record
================================================================
*/
CREATE PROCEDURE [dbo].[Z_AddMRU] 
	@EmployeeID as Int = 0,
	@TableName as nvarchar(24) = null,
	@PKValue as int = 0,
	@DateAdded as datetime = null,

	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Company Added' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	Begin Try
		INSERT INTO [dbo].[MRU]
 ([EmployeeID]
 ,[TableName]
 ,[PKValue]
 ,[DateAdded])
		VALUES
			(@EmployeeID ,
			@TableName ,
			@PKValue ,
			@DateAdded);

		SET @LocalID = SCOPE_IDENTITY(); 
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Added MRU';
	End Try
	BEGIN Catch
		SET @LocalID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch	
END
GO
/****** Object:  StoredProcedure [dbo].[Z_AddOrder]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 2025-03-18
Description: Add new Order
--=============================================
*/
CREATE PROCEDURE [dbo].[Z_AddOrder]
	 @EmployeeID AS int = 0
	,@CustomerID AS int = 0
	,@OrderDate AS datetime = null --use the current date as the default, handled below
	,@TaxRate AS Decimal(6,3) = 0
	,@TaxStatusID AS tinyint = 0 --Default to tax exempt
	,@Notes AS nvarchar(max) = Null 
	,@OrderStatusID AS int = 3 --Default to New
	,@ShipperID as Int = 0
	,@ShippingFee As money = 0 --Default to 0 shipping
	,@InvoiceDate as Datetime = Null
	,@ShippedDate As DateTime = Null
	,@PaymentMethod as nvarchar(50) = Null
	,@PaidDate As DateTime = Null 

	,@LocalID AS int = 0 OUTPUT 
	,@ErrorCode AS int = 0 OUTPUT
	,@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
SET NOCOUNT ON;
Begin Try
--ShipperID is not required when orders are first entered.
--ShipperID is required in order to invoice already entered orders.
--ShipperID validation occurs in sp UpdateOrderStatus, not here.
	Declare @LocalShipperID as int;
	SET @LocalShipperID = 
		CASE 
			WHEN @ShipperID = 0 THEN NULL
			ELSE TRY_CAST(@ShipperID AS INT)
		END;
	If IsNull(@CustomerID,0) = 0 
		THROW 51330, 'Customer is required.', 16;
	If IsNull(@EmployeeID,0) = 0
		THROW 51340, 'Employee is required.', 16;
	Begin
	--In this version of NW Dev, we override Tax rate passed in 
	--and use the standard tax rate from System Settings
	--In an enhanced version, where an admin role is active, 
	--this could be reversed to allow an admin user to override
	--the system setting value.
	--Tax Rate is stored as a whole integer, so convert to decimal for calculations.
		SELECT @TaxRate = Cast(SettingValue as Decimal(6,3))/1000
		FROM SystemSettings 
		WHERE SettingName = 'TaxRate';
	End
	INSERT INTO [dbo].[Orders]
			 (
				[EmployeeID]
			 ,[CustomerID]
			 ,[OrderDate]
			 ,[TaxRate]
			 ,[TaxStatusID]
			 ,[Notes] 
			 ,[OrderStatusID]
			 ,[ShipperID]
			 ,[ShippingFee]
			 ,[ShippedDate]
			 ,[InvoiceDate]
			 ,[PaymentMethod]
			 ,[PaidDate]
			 ) 
		 
			 SELECT 
			 @EmployeeID
			 ,@CustomerID 
			 ,IsNull(@OrderDate, GetDate())
			 ,@TaxRate 
			 ,@TaxStatusID 
			 ,cast(NULLIF(@Notes,'') AS nvarchar(1000))
			 ,@OrderStatusID
			 ,@LocalShipperID
			 ,@ShippingFee
			 ,Cast(NULLIF(@ShippedDate,'') AS DateTime)
			 ,Cast(NULLIF(@InvoiceDate,'') AS DateTime)
			 ,cast(NULLIF(@PaymentMethod,'') as nvarchar(50) ) 
			 ,Cast(NULLIF(@PaidDate,'') AS DateTime) ;
			 
		SET @LocalID = SCOPE_IDENTITY();
		SET @ErrorCode = 0;
		SET @Message = 'Added Order ' +Cast(@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch 
END
GO
/****** Object:  StoredProcedure [dbo].[Z_AddOrderDetail]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 06/17/2025
Description: Add a new line item 
 to an order in the OrderDetails table
=============================================
*/
CREATE PROCEDURE [dbo].[Z_AddOrderDetail] 
	@OrderID int,
	@ProductID int,
	@Quantity smallint = 1 , --Default to an order of 1 item
	@Discount decimal(6,3) = 0 , -- Default to no discount
	@UnitPrice money = 0, 
	@OrderDetailStatusID int = 1, --Default to new

	@LocalID AS int = 0 OUTPUT, 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Added Order Detail' OUTPUT 
AS
BEGIN
--We have a business rule disallowing duplicating products in an order. 
--A product can be changed before it is committed.
--A Check restraint on ProductID and OrderID raises an error if we try to add
--a new Order Detail or modify an existing Order Detail that violates the rule.
--In the case of such an error, disallow adding other fields as well.
--I.e. only commit complete inserts.
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE @LocalProductAvailable as int,
				@LocalProductAvailableToSell as int,
				@LocalProductOnOrder as int,
				@LocalProductInOrder as int,
				@LastStockTakeQOH as int,
				@ProductBought as int,
				@ProductSold as int;
		SET @ErrorCode = 0;

		IF IsNull(@OrderID ,0) = 0 --Required Fields Check
			BEGIN 
			SET @ErrorCode = 55000;
				SET @Message = ' Order is Required ';
				RETURN;
			END
		IF IsNull(@ProductID,0) = 0 --Required Fields Check
			BEGIN 
				SET @ErrorCode = 55100;
				SET @Message = ' Product is Required ';
				RETURN;
			END
		IF IsNull(@UnitPrice,0) = 0 --Required Fields Check
			BEGIN 
				SET @ErrorCode = 55200;
				SET @Message = ' Unit Price is Required ';
				RETURN;
			END	
		IF IsNull(@Quantity,0) = 0 --Required Fields Check
			BEGIN 
				SET @ErrorCode = 55300;
				SET @Message = ' Quantity is Required ';
				RETURN;
			END	
		BEGIN --Check for Duplicate Product on Order
			SELECT @LocalProductInOrder = Count(OrderDetailID)
			FROM OrderDetails
			WHERE OrderID = @OrderID and ProductID = @ProductID;
			BEGIN
				If @LocalProductInOrder <> 0
				BEGIN
					SET @ErrorCode = 58000;
					SET @Message = ' already includes selected product. 
					Select a different product or change the quantity.';
					RETURN;
				END
			END
		END
	--Set Status of this order detail to allocated if product available will cover it
	--or On Order if the amount on order will cover it
	--or No Stock if not enough available and nothing on order for it

		EXEC [dbo].[ProductAvailable]
			 @ProductID = @ProductID, 
			 @LastStockTakeQOH = @LastStockTakeQOH OUTPUT,
	 		 @ProductBoughtSinceLastStockTake = @ProductBought OUTPUT,
			 @ProductSold = @ProductSold OUTPUT,
			 @LocalProductAvailableToSell = @LocalProductAvailable OUTPUT;

			SET @LocalProductAvailableToSell = @LocalProductAvailable;

		EXEC [dbo].[ProductOnOrder]
			 @ProductID = @ProductID,
			 @LocalID = @ProductID OUTPUT,
			 @LocalProductOnOrder = @LocalProductOnOrder OUTPUT;

			Set @LocalProductOnOrder = @LocalProductOnOrder;

			SET @OrderDetailStatusID =
			CASE WHEN @LocalProductAvailableToSell >= @Quantity
				 THEN 1 --Allocated
				 WHEN @LocalProductAvailableToSell < @Quantity AND @LocalProductOnOrder>0
				 THEN 5 --On Order
				 ELSE 4 --No Stock
			END

		INSERT INTO dbo.OrderDetails
		(
			OrderID,
			ProductID,
			Quantity,
			UnitPrice,
			Discount,
			OrderDetailStatusID
		)
		VALUES
		(
			@OrderID ,
			@ProductID,
			@Quantity ,
			@UnitPrice ,
			@Discount ,
			@OrderDetailStatusID
		) 
		SET @LocalID = SCOPE_IDENTITY();
		SET @ErrorCode = 0;
		SET @Message = 'Added Order Detail ' +Cast(@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch 
END
 
GO
/****** Object:  StoredProcedure [dbo].[Z_AddPO]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 2025-03-21
Description: Add new Purchase Order
=============================================
*/
CREATE PROCEDURE [dbo].[Z_AddPO]
	 @VendorID AS int 
	,@SubmittedByID AS int = 10 --Internet orders as the default
	,@ApprovedByID as int = 0
	,@StatusID AS int = 3 --Default to New
	,@ShippingFee As money = Null
	,@TaxAmount AS Money = Null
	,@PaymentAmount AS money = Null
	,@PaymentMethod as nvarchar(50) = Null
	,@Notes AS nvarchar(max) = Null

	,@LocalID as int = 0 OUTPUT
	,@ErrorCode AS int = 0 OUTPUT
	,@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	Begin Try
		/* ApprovedByID can not be 0 for a new PO, so convert 0 to Null*/
		If @ApprovedByID = 0
			Set @ApprovedByID = Null;
		INSERT INTO [dbo].[PurchaseOrders]
			(
			 SubmittedByID
			,VendorID
			,TaxAmount
			,Notes
			,StatusID
			,ApprovedByID 
			,ShippingFee 
			,PaymentAmount 
			,PaymentMethod
			) 
			SELECT 
			 @SubmittedByID
			,@VendorID 
			,@TaxAmount
			,CAST(NULLIF(@Notes,'') AS Nvarchar(1000))
			,@StatusID
			,@ApprovedByID 
			,@ShippingFee
			,@PaymentAmount
			,@PaymentMethod;
		SET @LocalID = SCOPE_IDENTITY();
		SET	@ErrorCode = 0;
		SET @Message = 'Added Purchase Order ' + Cast(@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_AddPODetail]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=====================================================
Author:		 George Hepworth
Create date: 20250316
Description: Add a new detail line item 
 to an order in the OrderDetails table
=====================================================
*/
CREATE PROCEDURE [dbo].[Z_AddPODetail] 
	@PurchaseOrderID AS int,
	@ProductID AS int = 0,
	@Quantity AS int = 1, --Default to 1 PO item
	@UnitCost AS money = 0,

	@LocalID AS int = 0 OUTPUT, 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Added PO Detail' OUTPUT 
AS
BEGIN
	Declare @ExistingPODetailID as int;
	SET NOCOUNT ON;
	Begin Try	
		SELECT @ExistingPODetailID = PurchaseOrderDetailID 
		FROM dbo.PurchaseOrderDetails
		WHERE PurchaseOrderID = @PurchaseOrderID AND ProductID= @ProductID
		If 	(IsNull(@ExistingPODetailID,0)> 0)
			Throw 52601, 'That Product is already in this Purchase Order ' ,16; 
			BEGIN
				INSERT INTO dbo.PurchaseOrderDetails
				(
					PurchaseOrderID,
					ProductID,
					Quantity,
					UnitCost
				)
				VALUES
				(
					@PurchaseOrderID ,
					@ProductID ,
					@Quantity ,
					@UnitCost 
				) 
				SET @LocalID = SCOPE_IDENTITY();
				SET @ErrorCode = 0;
				SET @Message = 'Added New PO Detail ' +Cast(@LocalID as nvarchar(10));
			END
	END Try
	BEGIN Catch
		SET @LocalID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch 
END
 
GO
/****** Object:  StoredProcedure [dbo].[Z_AddProduct]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/19/2025
Description: Add a Product
=============================================
*/
CREATE PROCEDURE [dbo].[Z_AddProduct] 
	 @ProductName as nvarchar(50) = Null,
	 @ProductDescription as nvarchar(Max)= Null,
	 @StandardUnitCost as money = Null,
	 @UnitPrice as money = Null,
	 @ReorderLevel as int = 1 , 
	 @TargetLevel as int =1 , 
	 @QuantityPerUnit as nvarchar(50) = Null,
	 @Discontinued as bit = 0, 
	 @MinimumReorderQuantity as int = 1, 
	 @ProductCategoryID as int = Null,

	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Product Added' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	Begin Try
		Declare 
			@LocalErrorCode as INT,
			@LocalMessage as NVarChar(400);
		If @ProductName Is Null
			BEGIN
				SET	@ErrorCode = 58010;
				SET	@Message = 'Product Name is required';
				RETURN;
			END;
		If @StandardUnitCost Is Null
			BEGIN
				SET	@ErrorCode = 58020;
				SET	@Message = 'Standard Unit Cost is required';
				RETURN;
			END;
		If @UnitPrice Is Null
			BEGIN
				SET	@ErrorCode = 58030;
				SET	@Message = ' Unit Price is required';
				RETURN;
			END;
		If @ProductCategoryID Is Null
			BEGIN
				SET	@ErrorCode = 58040;
				SET	@Message = 'Product Category is required';
				RETURN;
			END;
		INSERT INTO [dbo].Products
 ( 
			 [ProductName]
			,[ProductDescription]
			,[StandardUnitCost]
			,[UnitPrice]
			,[ReorderLevel]
			,[TargetLevel]
			,[QuantityPerUnit]
			,[Discontinued]
			,[MinimumReorderQuantity]
			,[ProductCategoryID]
		 )
		VALUES
 (
			 @ProductName
			, @ProductDescription
			, @StandardUnitCost 
			, @UnitPrice
			, @ReorderLevel
			, @TargetLevel
			, @TargetLevel
			, @Discontinued 
			, @MinimumReorderQuantity
			, @ProductCategoryID	
			);
		SET @LocalID = SCOPE_IDENTITY(); 
		Exec dbo.AddNewProductToStockTake
			@ProductID =@LocalID,
			
			@LocalID = @LocalID OUTPUT,
			@ErrorCode = @LocalErrorCode OUTPUT,
			@Message = @LocalMessage OUTPUT
 
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Added Product'; 
	End Try
	BEGIN Catch
		SET @LocalID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch	
END
GO
/****** Object:  StoredProcedure [dbo].[Z_AddProductVendor]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
================================================================
Author:		 George Hepworth
Create date: 4/1/2025
Description: Add a ProductVendor 
 Called by the Master Stored Procedure, CRUDProductVendor
================================================================
*/
CREATE PROCEDURE [dbo].[Z_AddProductVendor] 
	@ProductVendorID As int = 0,
	@ProductID AS int = 0, 
	@VendorID AS int = 0,

	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Product Vendor Added' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	Begin Try
		INSERT INTO [dbo].ProductVendors
			(ProductID
			,VendorID
			 )
		VALUES
			(
			 @ProductID 
			, @VendorID
			);
		SET @LocalID = SCOPE_IDENTITY(); 
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Added '+ Cast(@ProductVendorID as Nvarchar(10)); 
	End Try
	BEGIN Catch
		SET @LocalID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch	
END
GO
/****** Object:  StoredProcedure [dbo].[Z_AddStockTake]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 =============================================
 Author:	 George Hepworth
 Create date: 5/21/2025
 Description: Add a StockTake
 =============================================
*/
CREATE PROCEDURE [dbo].[Z_AddStockTake] 
	 @ProductID as int ,
	 @StockTakeDate as DateTime = Null,
	 @QuantityOnHand as int =0,
	 @ExpectedQuantity as Int =0,

	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'StockTake Added' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		Declare 
			@LocalErrorCode as INT,
			@LocalMessage as NVarChar(400);		
		INSERT INTO [dbo].StockTake
 ( 
			 ProductID
			,StockTakeDate
			,QuantityOnHand
			,ExpectedQuantity
		 )
		VALUES
 (
			 @ProductID
			,Case 
			 WHEN @StockTakeDate Is Null
			 THEN GetDate() 
			 ELSE @StockTakeDate 
			 END
			,@QuantityOnHand
			,@ExpectedQuantity 
			);
		SET @LocalID = @ProductID
		SET	@ErrorCode = 0;
		SET	@Message = 'Added StockTake'; 
	End Try
	BEGIN Catch
		SET @LocalID = @ProductID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch	
END
GO
/****** Object:  StoredProcedure [dbo].[Z_AddSystemSetting]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 ================================================================
 Author:	 George Hepworth
 Create date: 5/27/2025
 Description: Add a System Setting 
 ================================================================
*/
CREATE PROCEDURE [dbo].[Z_AddSystemSetting] 
	@SettingID as int = 0 ,
	@SettingName as nvarchar(50) = Null,
	@SettingValue as nvarchar(255) = Null ,
	@Notes as nvarchar(255) = Null ,

	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Company Added' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	Begin Try
		INSERT INTO [dbo].[SystemSettings]
 ([SettingName]
 ,[SettingValue]
 ,[Notes])
		 VALUES
 (
			@SettingName ,
			@SettingValue ,
			@Notes 	
			);
		SET @LocalID = SCOPE_IDENTITY(); 
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Added '+ @SettingName ; 
	End Try
	BEGIN Catch
		SET @LocalID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch	
END
GO
/****** Object:  StoredProcedure [dbo].[Z_AddUserSetting]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 ================================================================
 Author:	 George Hepworth
 Create date: 5/27/2025
 Description: Add a User Setting 
 ================================================================
*/
CREATE PROCEDURE [dbo].[Z_AddUserSetting] 
	@SettingID as int = 0 ,
	@SettingName as nvarchar(50) = Null,
	@SettingValue as nvarchar(255) = Null ,
	@Notes as nvarchar(255) = Null ,

	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Company Added' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	Begin Try
		INSERT INTO [dbo].[UserSettings]
 ([SettingName]
 ,[SettingValue]
 ,[Notes])
		 VALUES
 (
			@SettingName ,
			@SettingValue ,
			@Notes 	
			);
		SET @LocalID = SCOPE_IDENTITY(); 
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Added '+ @SettingName ; 
	End Try
	BEGIN Catch
		SET @LocalID = 0;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch	
END
GO
/****** Object:  StoredProcedure [dbo].[Z_DeleteCompany]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 =============================================
 Author:		George Hepworth
 Create date: 03-27-2025
 Description:	Delete one Company 
 =============================================
*/
CREATE PROCEDURE [dbo].[Z_DeleteCompany]
	@CompanyID AS int = 0, --If no PK is provided, delete a non-existent company rather than raise an error

	@LocalID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DELETE FROM [dbo].[Companies]
		WHERE CompanyID = @CompanyID;

		SET @LocalID = @CompanyID;
		SET	@ErrorCode = 0;
		SET @Message = 'Deleted Company';
	END Try
	BEGIN Catch
		SET @LocalID = @CompanyID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_DeleteEmployee]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 =============================================
 Author:		George Hepworth
 Create date: 03-27-2025
 Description:	Delete one Employee from Employees
 =============================================
*/
CREATE PROCEDURE [dbo].[Z_DeleteEmployee]
	@EmployeeID AS int = 0,

	@LocalID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try --Referential Integrity will not permit deletions that would leave orphans
		DELETE FROM [dbo].Employees
		WHERE EmployeeID = @EmployeeID;
		SET @LocalID = @EmployeeID;
		SET	@ErrorCode = 0;
		SET @Message = 'Deleted Employee ' + Cast(@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @EmployeeID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_DeleteMRU]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 =============================================
 Author:	 George Hepworth
 Create date: 5/27/2025
 Description: Delete one MRU Record from MRUs
 =============================================
*/
CREATE PROCEDURE [dbo].[Z_DeleteMRU]
	@MRU_ID AS int = 0,

	@LocalID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DELETE FROM [dbo].MRU
		WHERE MRU_ID = @MRU_ID;
		SET @LocalID = @MRU_ID;
		SET	@ErrorCode = 0;
		SET @Message = 'Deleted MRU ' + Cast(@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @MRU_ID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_DeleteOrder]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 ===============================================
 Author:	 George Hepworth
 Create date: 03-27-2025
 Description: Delete one Order from Orders
 Cascade delete on Order Details
 ===============================================
*/
CREATE PROCEDURE [dbo].[Z_DeleteOrder]
	@OrderID AS int = 0,

	@LocalID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DELETE FROM [dbo].Orders
		WHERE OrderID = @OrderID;
		SET @LocalID = @OrderID;
		SET	@ErrorCode = 0;
		SET @Message = 'Deleted Order ' + cast(@LocalID as nvarchar(10)) ;
	END Try
	BEGIN Catch
		SET @LocalID = @OrderID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_DeleteOrderDetail]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 =====================================================
 Author:	 George Hepworth
 Create date: 03-27-2025
 Description: Delete one Line Item from OrderDetails
 =====================================================
*/
CREATE PROCEDURE [dbo].[Z_DeleteOrderDetail]
	@OrderDetailID AS int =0,

	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		Declare @OrderStatusID as int;
		Select @OrderStatusID = OrderStatusID
		FROM Orders WHERE OrderID IN
		(SELECT OrderID FROM OrderDetails WHERE OrderDetailID = @OrderDetailID);
		If @OrderStatusID <> 3 --New
			BEGIN
				SET @ErrorCode = 51000;
				SET @Message ='The Order containing this product has been invoiced and can''t be deleted.';
				RETURN
			END
		DELETE FROM [dbo].[OrderDetails]
		WHERE OrderDetailID = @OrderDetailID;
		SET @LocalID = @OrderDetailID; 
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Deleted Order Detail ' + Cast(@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @OrderDetailID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch	
END
GO
/****** Object:  StoredProcedure [dbo].[Z_DeletePO]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 ========================================
 Author:	 George Hepworth
 Create date: 4/19/2025
 Description: Delete one Purchase Order 
			 from Purchase Orders
 =============================================
*/
CREATE PROCEDURE [dbo].[Z_DeletePO]
	@PurchaseOrderID AS int = 0,

	@LocalID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		Declare @POStatusID as int,
		@POInStatusCount as Int = 0;
		SELECT @POInStatusCount = Count(*)
		FROM PurchaseOrders 
		WHERE PurchaseOrderID = @PurchaseOrderID 
		AND (StatusID = 5 or StatusID = 2);
		If IsNull(@POInStatusCount,0) > 0
			BEGIN
				SET @ErrorCode = 51100;
				SET @Message = 'Purchase Order has already been received and can''t be deleted' ;
				RETURN;
			END
		DELETE FROM [dbo].[PurchaseOrders]
		WHERE PurchaseOrderID = @PurchaseOrderID;
		SET @LocalID = @PurchaseOrderID;
		SET	@ErrorCode = 0;
		SET @Message = 'Deleted Purchase Order ' + Cast(@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @PurchaseOrderID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_DeletePODetail]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/19/2025
Description: Delete one Purchase Order 
			 from Purchase Orders
=============================================
*/
CREATE PROCEDURE [dbo].[Z_DeletePODetail]
	@PurchaseOrderDetailID AS int = 0,
	@LocalID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE @POStatusID as int;
		SELECT @POStatusID = StatusID
		FROM PurchaseOrders
		WHERE PurchaseOrderID In 
			(Select PurchaseOrderID 
			 FROM PurchaseOrderDetails 
			 WHERE PurchaseOrderDetailID = @PurchaseOrderDetailID);
		If @POStatusID = 5 or @POStatusID = 2
			BEGIN
				SET @ErrorCode = 51100;
				SET @Message = 'The Purchase Order containing this Detail has already been received 
						and can''t be deleted';
				RETURN
			END
		DELETE FROM [dbo].[PurchaseOrderDetails]
		WHERE PurchaseOrderDetailID = @PurchaseOrderDetailID;
		SET @LocalID = @PurchaseOrderDetailID;
		SET	@ErrorCode = 0;
		SET @Message = 'Deleted PO Detail ' + Cast(@LocalID as NvarChar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @PurchaseOrderDetailID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_DeleteProduct]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:	 	 George Hepworth
Create date: 03-27-2025
Description: Delete one Product from Products
=============================================
*/
CREATE PROCEDURE [dbo].[Z_DeleteProduct]
	@ProductID AS int = 0,

	@LocalID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Deleted' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		Declare 
		@AILastStockTake as int,
		@LocalLastStockTakeDate as date,
		@LocalLastStockTakeQOH as int,
		@PreviouslySold as int,
		@LocalErrorCode as int,
		@LocalMessage as nvarchar(400);
	
		Exec [dbo].[ProductLastStockTakeDateQOH]
				@ProductID =@ProductID,
				@LocalID =@ProductID,
				@LastStockTakeDate = @LocalLastStockTakeDate OUTPUT,
				@LastStockTakeQOH =@LocalLastStockTakeQOH OUTPUT,
				@LocalErrorCode = @LocalErrorCode OUTPUT,
				@LocalMessage = @LocalMessage OUTPUT;
		SET @AILastStockTake =@LocalLastStockTakeQOH;
	
		If IsNull(@AILastStockTake,0) <> 0
			BEGIN
				SET	@ErrorCode = 55547;
				SET @Message = 'That Product is in Stock and can''t be deleted.';
				RETURN;
			END
		SELECT @PreviouslySold = SUM(Quantity) 
		FROM OrderDetails
		WHERE ProductID = @ProductID
		GROUP BY ProductID;
		If IsNull(@PreviouslySold,0) <> 0
			BEGIN
				SET	@ErrorCode = 56547;
				SET @Message = 'That Product has previously been sold and can''t be deleted.';
				RETURN;
			END
		BEGIN
			DELETE FROM StockTake
			WHERE ProductID =@ProductID;
			DELETE FROM [dbo].Products
			WHERE ProductID = @ProductID;
		END
		SET @LocalID = @ProductID;
		SET	@ErrorCode = 0;
		SET @Message = 'Deleted Product';
	END Try
	BEGIN Catch
		SET @LocalID = @ProductID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_DeleteProductVendor]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
 =============================================
 Author:		George Hepworth
 Create date: 03-27-2025
 Description:	Delete one ProductVendor
 =============================================
*/
CREATE PROCEDURE [dbo].[Z_DeleteProductVendor]
	@ProductVendorID AS int = 0, 

	@LocalID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DELETE FROM [dbo].[ProductVendors]
		WHERE ProductVendorID = @ProductVendorID;
		IF @@ROWCOUNT = 0
			BEGIN
				SET @ErrorCode = -100;
				SET @Message = 'ProductVendor ID ' + CAST(@ProductVendorID AS NVARCHAR(10)) + ' not found';
			END
			ELSE
			BEGIN
				SET @LocalID = @ProductVendorID;
				SET @ErrorCode = 0;
				SET @Message = 'Deleted ProductVendor ' + Cast(@LocalID as NvarChar(10));
			END
	END Try
	BEGIN Catch
		SET @LocalID = @ProductVendorID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_DeleteStockTake]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 05-21-2025
Description: Delete one Stocktake 
			 from StockTakes
=============================================
*/
CREATE PROCEDURE [dbo].[Z_DeleteStockTake]
	@StockTakeID as int,
	@ProductID AS int = 0,
	@StockTakeDate as DateTime = Null,

	@LocalID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Deleted' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DELETE FROM StockTake
		WHERE StockTakeID = @StockTakeID; 
		SET @LocalID = @ProductID;
		SET	@ErrorCode = 0;
		SET @Message = 'Deleted StockTake';
	END Try
	BEGIN Catch
		SET @LocalID = @ProductID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_DeleteSystemSetting]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 5/27/2025
Description: Delete one System Setting
=============================================
*/
CREATE PROCEDURE [dbo].[Z_DeleteSystemSetting]
	@SettingID as int = 0, 
	@LocalID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DELETE FROM [dbo].SystemSettings
		WHERE SettingID = @SettingID;
		SET @LocalID = @SettingID;
		SET	@ErrorCode = 0;
		SET @Message = 'Deleted System Setting ' + Cast(@LocalID as NvarChar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @SettingID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_DeleteUserSetting]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		George Hepworth
Create date: 5/27/2025
Description:	Delete one User Setting
=============================================
*/
CREATE PROCEDURE [dbo].[Z_DeleteUserSetting]
	@SettingID as int = 0, 
	@LocalID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DELETE FROM [dbo].UserSettings
		WHERE SettingID = @SettingID;
		SET @LocalID = @SettingID;
		SET	@ErrorCode = 0;
		SET @Message = 'Deleted User Setting ' + Cast(@LocalID as NvarChar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @SettingID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_SelectCompany]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/1/2025
Description: Select one company 
=============================================
*/
/* 
	StandardTaxStatusID is implemented as an int, 
	but with only two values 0 (Tax Exempt) or 1 (Taxable).
	Therefore, the All or One Option for StandardTaxStatusID 
	can't use the same 0/non-0 options as other parameters.
*/
CREATE PROCEDURE [dbo].[Z_SelectCompany] 
	@CompanyID As Int = 0, 
	@CompanyTypeID as Int = 0,
	@CompanyName as nvarchar(50) = Null,
	@City as nvarchar(255) = Null,
	@StandardTaxStatusID as Int = -1,
	@StateAbbrev as Nvarchar(2) = Null,
	@LocalID AS int = 0 OUTPUT ,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT 
			[CompanyID], 
			[CompanyName],
			[CompanyTypeID],
			[BusinessPhone],
			[Address],
			[City],
			[StateAbbrev],
			[Zip],
			[Website],
			[Notes],
			[StandardTaxStatusID]
			FROM Companies
			WHERE		(@CompanyID = 0 OR CompanyID = @CompanyID )
					AND (@StandardTaxStatusID = -1 OR StandardTaxStatusID = @StandardTaxStatusID)
					AND (@CompanyTypeID = 0 OR CompanyTypeID = @CompanyTypeID)
					AND (@StateAbbrev IS NULL OR StateAbbrev = @StateAbbrev)
					AND (@CompanyName IS NULL or CompanyName Like '%' + @CompanyName +'%')
					AND (@City Is Null or City Like '%' + @City +'%');
		SET @LocalID = @CompanyID;
		SET @ErrorCode = 0;
		SET @Message = 'Selected Company ' + Cast (@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @CompanyID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT 
			[CompanyID], 
			[CompanyName],
			[CompanyTypeID],
			[BusinessPhone],
			[Address],
			[City],
			[StateAbbrev],
			[Zip],
			[Website],
			[Notes],
			[StandardTaxStatusID]
			FROM Companies
			WHERE 1 = 0;
	END Catch 
END
GO
/****** Object:  StoredProcedure [dbo].[Z_SelectEmployee]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/1/2025
Description: Select Employees 
=============================================
*/
CREATE PROCEDURE [dbo].[Z_SelectEmployee] 
	@EmployeeID As Int = 0, 
	@FirstName as nvarchar(20) = Null,
	@LastName as nvarchar(30) = Null,
	@JobTitle as nvarchar(50) = Null,
	@SupervisorID as int = 0,

	@LocalID AS int = 0 OUTPUT ,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		 SELECT 
		 [EmployeeID]
		 ,[FirstName]
		 ,[LastName]
		 ,dbo.fn_FullNameLF(FirstName,LastName) As LastFirst
		 ,[EmailAddress]
		 ,[JobTitle]
		 ,[PrimaryPhone]
		 ,[SecondaryPhone]
		 ,[Title]
		 ,[Notes]
		 ,[EmployeeImagePA]
		 ,[EmployeeImageName]
		 ,[EmployeeImage]
		 ,[SupervisorID]
		 ,[WindowsUserName]
		FROM Employees
		WHERE		(@EmployeeID = 0 OR EmployeeID = @EmployeeID )
				AND (@SupervisorID = 0 OR SupervisorID = @SupervisorID)
				AND (@JobTitle IS NULL OR JobTitle Like '%' + @JobTitle + '%')
				AND (@LastName IS NULL OR LastName Like '%' + @LastName + '%')
				AND (@FirstName IS NULL OR FirstName Like '%' + @FirstName + '%');
		SET @LocalID = @EmployeeID;
		SET @ErrorCode = 0;
		SET @Message = 'Selected Employee ' + Cast(@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @EmployeeID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT 
		 [EmployeeID]
		 ,[FirstName]
		 ,[LastName]
		 ,[EmailAddress]
		 ,[JobTitle]
		 ,[PrimaryPhone]
		 ,[SecondaryPhone]
		 ,[Title]
		 ,[Notes]
		 ,[EmployeeImagePA]
		 ,[EmployeeImageName]
		 ,[EmployeeImage]
		 ,[SupervisorID]
		 ,[WindowsUserName]
		FROM Employees
		WHERE 1 = 0;
	END Catch 
END
GO
/****** Object:  StoredProcedure [dbo].[Z_SelectMRU]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
=============================================
Author:		 George Hepworth
Create date: 5/27/2025
Description: Select MRU 
=============================================
*/
CREATE PROCEDURE [dbo].[Z_SelectMRU] 
	@MRU_ID As Int = 0, 
	@EmployeeID as Int = 0,
	@TableName as nvarchar(50) = null,

	@LocalID AS int = 0 OUTPUT ,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Selected' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT [MRU_ID]
			 ,[EmployeeID]
			 ,[TableName]
			 ,[PKValue]
			 ,[DateAdded]
		FROM [dbo].[MRU]
		WHERE		(@MRU_ID = 0 Or MRU_ID = @MRU_ID)
				AND (@EmployeeID = 0 OR EmployeeID = @EmployeeID)
				AND (@TableName is Null OR TableName like '%' + @TableName +'%') ;
		SET @LocalID = @MRU_ID;
		SET @ErrorCode = 0;
		SET @Message = 'Selected Product '+ Cast (@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @MRU_ID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT [MRU_ID]
			 ,[EmployeeID]
			 ,[TableName]
			 ,[PKValue]
			 ,[DateAdded]
		FROM [dbo].[MRU]
		WHERE 1 = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_SelectOrder]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/19/2025
Description: Select One Order 
=============================================
*/
 CREATE PROCEDURE [dbo].[Z_SelectOrder] 
 @OrderID As Int = 0, 
 @EmployeeID As Int = 0,
 @CustomerID As Int = 0,
 @OrderDateStart As nvarchar(30) = '2000-1-1 00:00:00', 
 @OrderDateEnd As nvarchar(30) = NULL, 
 @OrderStatusID As Int = 0,
	@TaxRate AS Decimal(6,3) = 0,
	@TaxStatusID AS tinyint = null,
	@Notes AS nvarchar(max) = Null,
	@ShipperID as Int = 0,
	@ShippingFee As money = 0,
	@InvoiceDate as Datetime = Null,
	@ShippedDate As DateTime = Null,
	@PaymentMethod as nvarchar(50) = Null,
	@PaidDate As DateTime = Null,

 @LocalID AS int = 0 OUTPUT,
 @ErrorCode AS int = 0 OUTPUT,
 @Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
 SET NOCOUNT ON;
 BEGIN TRY
 DECLARE @OrderDateStartDT DATETIME = 
			CASE 
 WHEN @OrderDateStart IS NULL THEN NULL
 ELSE TRY_CONVERT(DATETIME, @OrderDateStart) 
			END
 DECLARE @OrderDateEndDT DATETIME = CASE 
 WHEN @OrderDateEnd IS NULL THEN NULL
 ELSE TRY_CONVERT(DATETIME, @OrderDateEnd)
			END
		DECLARE @FilterTaxStatusID as Int =
		CASE WHEN @TaxStatusID Is Null Then -1 Else @TaxStatusID END;
		SELECT 
			[OrderID],
			[EmployeeID],
			[CustomerID],
			[OrderDate],
			[InvoiceDate],
			[ShippedDate],
			[ShipperID],
			[ShippingFee],
			[TaxRate],
			[TaxStatusID],
			[PaymentMethod],
			[PaidDate],
			[Notes],
			[OrderStatusID]
		FROM Orders
		WHERE
				(@OrderID = 0 OR OrderID = @OrderID)
			AND (@EmployeeID = 0 OR EmployeeID = @EmployeeID)
			AND (@CustomerID = 0 OR CustomerID = @CustomerID)
			AND (@OrderDateStartDT IS NULL OR (OrderDate >= DateAdd(d,-14,@OrderDateStartDT)))
			AND (@OrderDateEndDT IS NULL OR OrderDate <= @OrderDateEndDT)
			AND (@OrderStatusID = 0 OR OrderStatusID = @OrderStatusID)
			AND (@InvoiceDate IS NULL OR Cast(InvoiceDate as Date) = Cast(@InvoiceDate as Date))
			AND (@ShippedDate IS NULL OR Cast(ShippedDate as Date) = Cast(@ShippedDate as Date))
			AND (@PaidDate IS NULL OR Cast(PaidDate as Date) = Cast(@PaidDate as Date))
			AND (@ShipperID = 0 OR ShipperID = @ShipperID)
			AND (@ShippingFee = 0 OR ShippingFee = @ShippingFee)
			AND (@TaxRate = 0 OR TaxRate = @TaxRate)
			AND (@FilterTaxStatusID = -1 OR TaxStatusID = @FilterTaxStatusID)
			AND (@PaymentMethod Is Null OR PaymentMethod Like '%' + @PaymentMethod +'%')
			AND (@Notes Is Null OR Notes Like '%' + @Notes +'%');
 SET @LocalID = ISNULL(@OrderID, 0);
 SET @ErrorCode = 0;
 SET @Message = 'Selected Order(s)';
 END TRY
 BEGIN CATCH
 SET @LocalID = ISNULL(@OrderID, 0);
 SET @ErrorCode = ERROR_NUMBER();
 SET @Message = ERROR_MESSAGE();
 SELECT 
 [OrderID],
 [EmployeeID],
 [CustomerID],
 [OrderDate],
 [InvoiceDate],
 [ShippedDate],
 [ShipperID],
 [ShippingFee],
 [TaxRate],
 [TaxStatusID],
 [PaymentMethod],
 [PaidDate],
 [Notes],
 [OrderStatusID]
 FROM Orders
 WHERE 1 = 0;
 END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Z_SelectOrderDetail]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
===================================================
Author:		 George Hepworth
Create date: 03/16/2025
Description: Update one line item for OrderDetails
===================================================
*/
CREATE PROCEDURE [dbo].[Z_SelectOrderDetail] 	 
	 @OrderDetailID AS Int = 0
	,@OrderID as int = 0
	,@ProductID as int = 0
	,@Quantity as smallint = 0
	,@UnitPrice as money = 0
	,@Discount as decimal(6,3) = 0
	,@OrderDetailStatusID as int = 0

	,@LocalID As Int = 0 OUTPUT
	,@ErrorCode AS int = 0 OUTPUT
	,@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY	
		SELECT 
		 OrderDetailID
		 ,[OrderID]
		 ,[ProductID]
		 ,[Quantity]
		 ,[UnitPrice]
		 ,[Discount]
		 ,[OrderDetailStatusID]
		FROM [dbo].[OrderDetails]
		WHERE (@OrderDetailID = 0 OR OrderDetailID = @OrderDetailID)
			AND (@OrderID = 0 OR OrderID = @OrderID)
			AND (@ProductID = 0 OR ProductID = @ProductID)
			AND (@Quantity = 0 OR Quantity = @Quantity)
			AND (@UnitPrice = 0 OR UnitPrice = @UnitPrice)
			AND (@Discount = 0 OR Discount = @Discount)
			AND (@OrderDetailStatusID = 0 OR OrderDetailStatusID = @OrderDetailStatusID);
		SET @LocalID = @OrderDetailID; 
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Selected Order Detail ' --+Cast(@LocalID as nvarchar(10)); 
	END Try
	BEGIN Catch
		SET @LocalID = @OrderDetailID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT 
		 OrderDetailID
		 ,[OrderID]
		 ,[ProductID]
		 ,[Quantity]
		 ,[UnitPrice]
		 ,[Discount]
		 ,[OrderDetailStatusID]
		FROM [dbo].[OrderDetails]
		WHERE 1 = 0;
	END Catch
END
 
GO
/****** Object:  StoredProcedure [dbo].[Z_SelectPO]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/19/2025
Description: Select One Order 
=============================================
*/
CREATE PROCEDURE [dbo].[Z_SelectPO] 
	@PurchaseOrderID as int = 0,
	@VendorID as int = 0,
	@SubmittedByID as int = 0 ,
	@SubmittedDate as DateTime = Null,
	@ApprovedByID as int = 0,
	@ApprovedDate as DateTime = Null,
	@StatusID as int = 0,
	@ReceivedDate as DateTime = Null,
	@ShippingFee as Money = 0,
	@TaxAmount as Money = 0,
	@PaymentDate as DateTime = Null,
	@PaymentAmount as Money = 0,
	@PaymentMethod as nvarchar(50) = Null,
	@Notes as nvarchar(max) = Null,

	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT 
		 [PurchaseOrderID]
		,[VendorID]
		,[SubmittedByID]
		,[SubmittedDate]
		,[ApprovedByID]
		,[ApprovedDate]
		,[StatusID]
		,[ReceivedDate]
		,[ShippingFee]
		,[TaxAmount]
		,[PaymentDate]
		,[PaymentAmount]
		,[PaymentMethod]
		,[Notes]
		FROM PurchaseOrders
		WHERE (@PurchaseOrderID = 0 OR PurchaseOrderID = @PurchaseOrderID)
			AND (@VendorID = 0 OR VendorID = @VendorID)
			AND (@SubmittedByID = 0 OR SubmittedByID = @SubmittedByID)
			AND (@SubmittedDate Is Null OR Cast(SubmittedDate as Date) = Cast(@SubmittedDate as Date))
			AND (@ApprovedByID = 0 OR ApprovedByID = @ApprovedByID)
			AND (@ApprovedDate Is Null OR Cast(ApprovedDate as Date) = Cast(@ApprovedDate as Date))
			AND (@StatusID = 0 OR StatusID = @StatusID)
			AND (@ReceivedDate Is Null OR Cast(ReceivedDate as Date) = Cast(@ReceivedDate as Date))
			AND (@PaymentDate Is Null OR Cast(PaymentDate as Date) = Cast(@PaymentDate as Date))
			AND (@ShippingFee = 0 OR ShippingFee = @ShippingFee)
			AND (@TaxAmount = 0 OR TaxAmount = @TaxAmount)
			AND (@PaymentAmount = 0 OR PaymentAmount = @PaymentAmount)
			AND (@PaymentMethod Is Null OR PaymentMethod Like '%' + @PaymentMethod + '%');
		SET @LocalID = @PurchaseOrderID;
		SET @ErrorCode = 0;
		SET @Message = 'Selected PO '--+ Cast (@LocalID as nvarchar(10)) ;
	END Try
	BEGIN Catch
		SET @LocalID = @PurchaseOrderID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT 
		 [PurchaseOrderID]
		,[VendorID]
		,[SubmittedByID]
		,[SubmittedDate]
		,[ApprovedByID]
		,[ApprovedDate]
		,[StatusID]
		,[ReceivedDate]
		,[ShippingFee]
		,[TaxAmount]
		,[PaymentDate]
		,[PaymentAmount]
		,[PaymentMethod]
		,[Notes]
		FROM PurchaseOrders
		WHERE 1 = 0;
	END Catch 
END
GO
/****** Object:  StoredProcedure [dbo].[Z_SelectPODetail]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/19/2025
Description: Select One Order 
=============================================
*/
CREATE PROCEDURE [dbo].[Z_SelectPODetail]
	@PurchaseOrderDetailID As Int = 0 ,
	@PurchaseOrderID as int = 0,
	@ProductID as int = 0,
	@Quantity as int = 0,
	@UnitCost as money = 0,
	@ReceivedDate as DateTime = Null,

	@LocalID AS int = 0 OUTPUT ,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT 
			 [PurchaseOrderDetailID]
			,[PurchaseOrderID]
			,[ProductID]
			,[Quantity]
			,[UnitCost]
			,[ReceivedDate]
		FROM PurchaseOrderDetails
		WHERE (@PurchaseOrderDetailID = 0 OR PurchaseOrderDetailID = @PurchaseOrderDetailID)
			AND (@PurchaseOrderID = 0 OR PurchaseOrderID= @PurchaseOrderID)
			AND (@ProductID = 0 OR ProductID = @ProductID)
			AND (@Quantity = 0 OR Quantity = @Quantity)
			AND (@UnitCost = 0 OR UnitCost = @UnitCost)
			AND (@ReceivedDate Is Null OR Cast(ReceivedDate as Date) = Cast( @ReceivedDate as Date));
		SET @LocalID = @PurchaseOrderDetailID;
		SET @ErrorCode = 0;
		SET @Message = 'Selected PO Detail ' + Cast (@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @PurchaseOrderDetailID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT 
		[PurchaseOrderDetailID]
		,[PurchaseOrderID]
		,[ProductID]
		,[Quantity]
		,[UnitCost]
		,[ReceivedDate]
		FROM PurchaseOrderDetails
		WHERE 1 =0;
	END Catch 
END
GO
/****** Object:  StoredProcedure [dbo].[Z_SelectProduct]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/1/2025
Description: Select Product or All Products 
=============================================
*/
CREATE PROCEDURE [dbo].[Z_SelectProduct] 
	@ProductID As Int = 0 , 
	@ProductCode as nvarchar(20) = Null ,
	@ProductName as nvarchar(50) = Null,
	@ProductDescription as nvarchar(Max) = null,
	@StandardUnitCost as money = 0,
	@UnitPrice as money = 0,
	@ReorderLevel as smallint = 0 ,
	@TargetLevel as smallint = 0 ,
	@QuantityPerUnit as nvarchar(50) = Null,
	@Discontinued as bit = null,
	@MinimumReorderQuantity as smallint = 0,
	@ProductCategoryID as int = 0,

	@LocalID AS int = 0 OUTPUT ,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Selected' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		Declare @LocalDiscontinued as smallint;
		--Discontinued is a bit field, so "all" needs to be neither 0 nor 1
		SET @LocalDiscontinued = Case WHEN @Discontinued Is Null Then -1 Else @Discontinued End;
		SELECT 
			 ProductID
			,[ProductCode]
			,[ProductName]
			,[ProductDescription]
			,[StandardUnitCost]
			,[UnitPrice]
			,[ReorderLevel]
			,[TargetLevel]
			,[QuantityPerUnit]
			,[Discontinued]
			,[MinimumReorderQuantity]
			,[ProductCategoryID]
		FROM Products
		WHERE (@ProductID = 0 OR ProductID = @ProductID)
			AND (@ProductCode IS NULL OR ProductCode Like '%' + @ProductCode + '%' )
			AND (@ProductName IS NULL OR ProductName Like '%' + @ProductName + '%')
			AND (@ProductDescription IS NULL OR ProductDescription Like '%' + @ProductDescription + '%')
			AND (@StandardUnitCost = 0 OR StandardUnitCost = @StandardUnitCost)
			AND (@UnitPrice = 0 OR UnitPrice = @UnitPrice)
			AND (@ReorderLevel = 0 OR ReorderLevel = @ReorderLevel)
			AND (@TargetLevel = 0 OR TargetLevel = @TargetLevel)
			AND (@QuantityPerUnit Is null OR QuantityPerUnit Like '%' + @QuantityPerUnit + '%')
			AND (@LocalDiscontinued = -1 OR Discontinued = @LocalDiscontinued)
			AND (@MinimumReorderQuantity = 0 OR MinimumReorderQuantity = @MinimumReorderQuantity)
			AND (@ProductCategoryID = 0 OR ProductCategoryID = @ProductCategoryID);
		SET @LocalID = @ProductID;
		SET @ErrorCode = 0;
		SET @Message = 'Selected Product '+ Cast (@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @ProductID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT 
			 ProductID
			,[ProductCode]
			,[ProductName]
			,[ProductDescription]
			,[StandardUnitCost]
			,[UnitPrice]
			,[ReorderLevel]
			,[TargetLevel]
			,[QuantityPerUnit]
			,[Discontinued]
			,[MinimumReorderQuantity]
			,[ProductCategoryID]
		FROM Products
		WHERE 1 = 0;
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_SelectProductVendor]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/1/2025
Description: Select one Product Vendor 
=============================================
*/

CREATE PROCEDURE [dbo].[Z_SelectProductVendor] 
	@ProductVendorID As Int = 0, 
	@ProductID as Int = 0,
	@VendorID as Int = 0, 

	@LocalID AS int = 0 OUTPUT ,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT 
			[ProductVendorID], 
			[VendorID],
			[ProductID]
			FROM ProductVendors
			WHERE		(@ProductVendorID = 0 OR ProductVendorID = @ProductVendorID )
					AND (@ProductID = 0 OR ProductID = @ProductID)
					AND (@VendorID = 0 OR VendorID = @VendorID);
		SET @ErrorCode = 0;
		SET @Message = 'Selected Product Vendor ' + Cast (@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @ProductVendorID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT 
			[ProductVendorID], 
			[VendorID],
			[ProductID]
			FROM ProductVendors
			WHERE 1 = 0;
	END Catch 
END
GO
/****** Object:  StoredProcedure [dbo].[Z_SelectStocktake]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
===============================================
Author:		 George Hepworth
Create date: 5/21/2025
Description: Select Stocktake or All Stocktakes
===============================================
*/
CREATE PROCEDURE [dbo].[Z_SelectStocktake] 
	@ProductID As Int = 0 , 
	@StockTakeDate as DateTime = null,
	@QuantityOnHand As Int = 0,
	@ExpectedQuantity As int = 0 ,

	@LocalID AS int = 0 OUTPUT ,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Selected' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		SELECT
			 StockTakeID
			,ProductID
			,StockTakeDate
			,QuantityOnHand
			,ExpectedQuantity
		FROM StockTake
		WHERE (@ProductID = 0 or ProductID = @ProductID)
			AND (@StockTakeDate is Null Or Cast(StockTakeDate as Date) = Cast( @StockTakeDate AS Date))
			AND (@QuantityOnHand = 0 or QuantityOnHand = @QuantityOnHand)
			AND (@ExpectedQuantity = 0 or ExpectedQuantity = @ExpectedQuantity);
		SET @LocalID = @ProductID;
		SET @ErrorCode = 0;
		SET @Message = 'Selected Stocktakes for '+ Cast (@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @ProductID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
		SELECT 
			 ProductID
			,StockTakeDate
			,QuantityOnHand
			,ExpectedQuantity
		FROM StockTake
		WHERE 1 = 0;
	END Catch 
END
GO
/****** Object:  StoredProcedure [dbo].[Z_SelectSystemSetting]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George Hepworth
-- Create date: 5/27/2025
-- Description:	One System Setting 
-- =============================================
CREATE PROCEDURE [dbo].[Z_SelectSystemSetting] 
	@SettingID as int = 0,
	@SettingName as nvarchar(50) = Null,
	@SettingValue as nvarchar(255) = Null,
	@Notes as nvarchar(255) = Null,
	
	@LocalID AS int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT [SettingID]
			 ,[SettingName]
			 ,[SettingValue]
			 ,[Notes]
		FROM [dbo].[SystemSettings]
		WHERE (@SettingID = 0 Or SettingID = @SettingID)
			AND (@SettingName IS Null or SettingName Like '%' + @SettingName +'%')
			AND (@SettingValue IS Null or SettingValue Like '%' + @SettingValue +'%')
			AND (@Notes Is Null or Notes Like '%' + @Notes +'%');
 
		SET @LocalID = ISNULL(@SettingID, 0);
		SET @ErrorCode = 0;
		SET @Message = 'Selected Setting(s)';
 END TRY
 BEGIN CATCH
 SET @LocalID = ISNULL(@SettingID, 0);
 SET @ErrorCode = ERROR_NUMBER();
 SET @Message = ERROR_MESSAGE();
 -- Return an empty result set with the correct schema
 SELECT [SettingID]
		,[SettingName]
		,[SettingValue]
		,[Notes]
		FROM [dbo].[SystemSettings]
 WHERE 1 = 0;
 END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Z_SelectUserSetting]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		George Hepworth
Create date: 5/27/2025
Description:	CRUD operations on User Settings
=============================================
*/
CREATE PROCEDURE [dbo].[Z_SelectUserSetting] 
	@SettingID as int = 0,
	@SettingName as nvarchar(50) = Null,
	@SettingValue as nvarchar(255) = Null,
	@Notes as nvarchar(255) = Null,
	
	@LocalID AS int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT [SettingID]
			 ,[SettingName]
			 ,[SettingValue]
			 ,[Notes]
		FROM [dbo].[UserSettings]
		WHERE (@SettingID = 0 OR SettingID = @SettingID )
			AND (@SettingName IS Null OR SettingName Like '%' + @SettingName + '%')
			AND (@SettingValue IS NULL or SettingValue Like '%' + @SettingValue +'%')
			AND (@Notes Is Null or Notes Like '%' + @Notes +'%');
		SET @LocalID = ISNULL(@SettingID, 0);
		SET @ErrorCode = 0;
		SET @Message = 'Selected Setting(s)';
 END TRY
 BEGIN CATCH
 SET @LocalID = ISNULL(@SettingID, 0);
 SET @ErrorCode = ERROR_NUMBER();
 SET @Message = ERROR_MESSAGE();
 SELECT [SettingID]
				,[SettingName]
				,[SettingValue]
				,[Notes]
		FROM [dbo].[SystemSettings]
 WHERE 1 = 0;
 END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Z_UpdateCompany]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
=============================================
Author:		George Hepworth
Create date: 4/1/2025
Description:	Update company 
=============================================
*/
CREATE PROCEDURE [dbo].[Z_UpdateCompany]
	@CompanyID As Int,
	@CompanyName As nvarchar(50) = Null ,
	@CompanyTypeID AS int = Null ,
	@BusinessPhone AS nvarchar(20) = Null,
	@Address As nvarchar(255) = Null,
	@City AS nvarchar(255) = Null,
	@StateAbbrev AS nvarchar(2) = Null,
	@Zip AS nvarchar(10) = Null,
	@Website AS nvarchar(1024) = Null,
	@Notes AS nvarchar(Max) = Null , 
	@StandardTaxStatusID AS int = Null,

	@LocalID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		UPDATE [dbo].[Companies]
		SET [CompanyName]		 = CASE WHEN @CompanyName Is Null THEN [CompanyName] ELSE @CompanyName END
			,[CompanyTypeID]	 = IsNull(@CompanyTypeID , CompanyTypeID)
			,[BusinessPhone]	 = IsNull(@BusinessPhone ,[BusinessPhone]) 
			,[Address]			 = IsNull(@Address,[Address]) 
			,[City]				 = IsNull(@City,[City]) 
			,[StateAbbrev]		 = IsNull(@StateAbbrev,[StateAbbrev]) 
			,[Zip]				 = IsNull(@Zip,[Zip])
			,[Website]			 = IsNull(@Website,[Website]) 
			,[StandardTaxStatusID] = IsNull(@StandardTaxStatusID,[StandardTaxStatusID])
			,[Notes]			 = CASE WHEN @Notes Is Null THEN [Notes] 
										 WHEN @Notes = '' THEN Null ELSE [Notes] END
		WHERE CompanyID =@CompanyID;
		SET @LocalID = @CompanyID;
		SET @ErrorCode = 0;
		SET @Message = 'Updated Company ' + Cast(@LocalID as NvarChar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @CompanyID;;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_UpdateEmployee]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 4/1/2025
Description: Update One Employee
=============================================
*/
CREATE PROCEDURE [dbo].[Z_UpdateEmployee] 
	@EmployeeID int ,
	@FirstName AS nvarchar(20) = Null ,
	@LastName AS nvarchar(30) = Null ,
	@EmailAddress AS nvarchar(255) = Null,
	@JobTitle AS nvarchar(50) = Null,
	@PrimaryPhone AS nvarchar(20) = Null,
	@SecondaryPhone AS nvarchar(20) = Null,
	@Title AS nvarchar(20) = Null,
	@Notes AS nvarchar(max) = Null,
	@SupervisorID AS int = 0,
	@WindowsUserName AS nvarchar(50) = Null ,

	@LocalID AS int = 0 OUTPUT ,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		UPDATE [dbo].[Employees]
		SET	 [FirstName]	 = CASE WHEN @FirstName Is NULL THEN FirstName ELSE @FirstName END
			,[LastName]		 = CASE WHEN @LastName Is NULL THEN LastName ELSE @LastName END			 
			,[EmailAddress] = IsNull(@EmailAddress, [EmailAddress]) 
			,[JobTitle] = IsNull(@JobTitle, [JobTitle]) 
			,[PrimaryPhone]	 = IsNull(@PrimaryPhone, [PrimaryPhone]) 
			,[SecondaryPhone] = IsNull(@SecondaryPhone, [SecondaryPhone]) 
			,[Title]		 = CASE WHEN @Title Is NULL THEN Title ELSE @Title END		
			,[Notes]		 = CASE WHEN @Notes Is Null THEN [Notes] WHEN @Notes = '' THEN Null ELSE @Notes END
			,[SupervisorID] = CASE WHEN @SupervisorID =0 Then [SupervisorID] ELSE @SupervisorID END
			,[WindowsUserName] = IsNull(@WindowsUserName ,[WindowsUserName]) 
		WHERE EmployeeID = @EmployeeID;
		SET @LocalID = @EmployeeID; 
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Updated Employee ' + cast( @LocalID as nvarchar(10)); 
	End Try
	BEGIN Catch
		SET @LocalID = @EmployeeID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_UpdateMRU]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		George Hepworth
Create date: 05/27/2025
Description:	Update one MRU 
=============================================
*/
CREATE PROCEDURE [dbo].[Z_UpdateMRU]
	@MRU_ID AS int = 0,
	@EmployeeID As int = 0,
	@TableName as nvarchar(50) = Null,
	@PKValue as int = 0,
	@DateAdded as DateTime = Null,

	@LocalID AS int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		UPDATE [dbo].MRU
		SET EmployeeID = CASE WHEN @EmployeeID = 0 THEN EmployeeID ELSE @EmployeeID END,
			TableName = CASE WHEN @TableName = 0 THEN TableName ELSE @TableName END,
			PKValue = CASE WHEN @PKValue = 0 THEN PKValue ELSE @PKValue END,
			DateAdded = CASE WHEN @DateAdded = 0 THEN DateAdded ELSE @DateAdded END 	
		WHERE MRU_ID = @MRU_ID;
		SET @LocalID = @MRU_ID;
		SET @ErrorCode = 0;
		SET @Message = 'Updated MRU ' + Cast(@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @MRU_ID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch 
END
GO
/****** Object:  StoredProcedure [dbo].[Z_UpdateOrder]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		George Hepworth
Create date: 2025-03-18
Description:	Update one Order
=============================================
*/
CREATE PROCEDURE [dbo].[Z_UpdateOrder]
	 @OrderID AS int
	,@TaxRate AS Decimal(6,3) = Null
	,@TaxStatusID AS int = Null
	,@Notes AS nvarchar(4000) = Null
	,@OrderStatusID AS int = Null --Default to New Status
	,@ShipperID as Int = 0
	,@ShippingFee As money = 0 --Default to 0 shipping
	,@InvoiceDate AS Datetime= Null
	,@ShippedDate AS Datetime= Null
	,@PaymentMethod as nvarchar(50) = Null
	,@PaidDate AS Datetime= Null
 
	,@LocalID AS int = 0 OUTPUT 
	,@ErrorCode AS int = 0 OUTPUT
	,@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		--ShipperID is not required when orders are first entered.
		--ShipperID is required in order to invoice already entered orders.
		--However, ShipperID validation occurs in sp UpdateOrderStatus.
		--Until invoiced, allow ShipperID to remain null.
		Declare @LocalShipperID as int;
		SET @LocalShipperID = 
		CASE 
			WHEN @ShipperID = 0 THEN NULL
			ELSE TRY_CAST(@ShipperID AS INT)
		END;
		--Logic to keep OrderStatusID and statusdate fields in synch 
		--is in the UpdateOrderStatus SP because
		--this part of NW Dev is not fully normalized
		--Allow overrides of default taxrate, etc. on updates
		UPDATE [dbo].[Orders]
		SET [TaxRate]	 = CASE WHEN @TaxRate IS NULL THEN TaxRate ELSE @TaxRate END
			,[TaxStatusID] = CASE WHEN @TaxStatusID IS NULL THEN TaxStatusID ELSE @TaxStatusID END
			,[OrderStatusID] = CASE WHEN @OrderStatusID IS NULL THEN OrderStatusID ELSE @OrderStatusID END
			,[ShipperID]	 = CASE WHEN @LocalShipperID IS NULL THEN ShipperID ELSE @LocalShipperID END
			,[ShippingFee]	 = CASE WHEN @ShippingFee IS NULL THEN ShippingFee ELSE @ShippingFee END
			,[InvoiceDate]	 = CASE WHEN @InvoiceDate IS NULL THEN [InvoiceDate] ELSE @InvoiceDate END 
			,[ShippedDate]	 = CASE WHEN @ShippedDate IS NULL THEN [ShippedDate] ELSE @ShippedDate END 
			,[PaymentMethod] = CASE WHEN @PaymentMethod IS NULL THEN [PaymentMethod] 
									WHEN @PaymentMethod = '' THEN NULL ELSE @PaymentMethod END 
			,[PaidDate]		 = Case WHEN @PaidDate IS NULL THEN [PaidDate] ELSE @PaidDate END
			,[Notes]		 = CASE WHEN @Notes IS NULL THEN [Notes] WHEN @Notes = '' 
									THEN NULL ELSE @Notes END
		WHERE OrderID = @OrderID;
		SET @LocalID = @OrderID;
		SET @ErrorCode = 0;
		SET @Message = 'Updated Order ' + Cast(@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @OrderID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch 
END
GO
/****** Object:  StoredProcedure [dbo].[Z_UpdateOrderDetail]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 03/16/2025
Description: Update one line item 
			 for OrderDetails
=============================================
*/
CREATE PROCEDURE [dbo].[Z_UpdateOrderDetail] 
	@OrderDetailID AS Int,
	@OrderID as Int,
	@ProductID AS int,
	@Quantity AS smallint = Null,
	@Discount AS decimal(6,3) = Null,
	@UnitPrice AS money = Null, 
	@OrderDetailStatusID AS int = Null,

	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
--We have a business rule disallowing duplicating products in an order. 
--A product can be changed before it is committed.
--A Check restraint on ProductID and OrderID raises an error if we try to add
--a new Order Detail or modify an existing Order Detail that violates the rule.
--In the case of such an error, disallow the update of other fields as well.
--I.e. only commit complete updates.
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE @LocalProductAvailable as int,
		@ThisProductID as int,
		@PreviousProductAvailableToSell as int,
		@CurrentProductOnOrder as int,
		@LastStockTakeQOH as int,
		@ProductBought as int,
		@ProductSold as int; 
		--Set Status of this order detail to: 
		--'Allocated' if product available will cover the quantity in this order detail
		--'On Order' if product available + amount on order will cover it
		--'No Stock' if product available + amount on order will NOT cover it
--Step 1 Check available inventory of the product on this order detail
		SET @ThisProductID = @ProductID;
		EXEC [dbo].[ProductAvailable]
			@ProductID = @ThisProductID, 
			@LastStockTakeQOH =@LastStockTakeQOH OUTPUT, --Required parameter, but not used locally
			@ProductBoughtSinceLastStockTake = @ProductBought OUTPUT, --Required parameter, but not used locally
			@ProductSold = @ProductSold OUTPUT, --Required parameter, but not used locally
			@LocalProductAvailableToSell = @PreviousProductAvailableToSell OUTPUT; --We only need this OUTPUT
			--Print ' Available to sell Previous ' + Cast(@PreviousProductAvailableToSell as nvarchar(10)); 
--Step 2 Get the amount on Order, if any, but not yet added to inventory
		EXEC [dbo].[ProductOnOrder]
			@ProductID = @ProductID,
			@LocalID = @ProductID OUTPUT,
			@LocalProductOnOrder =@CurrentProductOnOrder OUTPUT;
			--Print 'Product currently on Purchase Orders ' + Cast(@CurrentProductOnOrder as nvarchar(10));
			--Print 'Product for this Order ' + Cast(@Quantity as nvarchar(10));
			--Print 'Available to sell ,minus this order ' + Cast(@PreviousProductAvailableToSell - @Quantity as nvarchar(10));
--Step 3 Use the availability of the Product to determine the status of this order detail following
			-- this update
		SET @CurrentProductOnOrder = @CurrentProductOnOrder;
		SET @OrderDetailStatusID = CASE WHEN @PreviousProductAvailableToSell >= @Quantity
							 	 THEN 1 --Allocated
								 WHEN @PreviousProductAvailableToSell < @Quantity AND @CurrentProductOnOrder>0
								 THEN 5 --On Order
								 ELSE 4 --No Stock
								 END
--Step 4 Update the current order detail with parameters passed in and calculated in Step 3
		UPDATE dbo.OrderDetails
		SET ProductID = IsNull(@ProductID, ProductID),
			Quantity = IsNull(@Quantity,1),
			UnitPrice = IsNull(@UnitPrice, UnitPrice),
			Discount = IsNull(@Discount,0),
			OrderDetailStatusID = IsNull(@OrderDetailStatusID ,OrderDetailStatusID) --This is a Safety check, @OrderDetailStatusID should never be null and it should never be an invalid option
		WHERE OrderDetailID = @OrderDetailID; 
--Step 5 Update the current order detail Status For the Order



		SET @LocalID = @OrderDetailID; 
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Updated Order Detail ' +Cast(@LocalID as nvarchar(10)); 
	END Try
	BEGIN Catch
	SET @LocalID = @OrderDetailID;
	SET @ErrorCode = ERROR_NUMBER();
	SET @Message = ERROR_MESSAGE();
END Catch
END
 
GO
/****** Object:  StoredProcedure [dbo].[Z_UpdatePO]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 2025-03-18
Description: Update Existing Purchase Orders
=============================================
*/
CREATE PROCEDURE [dbo].[Z_UpdatePO]
	 @PurchaseOrderID AS int
	,@SubmittedByID as int = Null
	,@SubmittedDate as datetime = Null
	,@ApprovedByID as int = Null
	,@ApprovedDate as Datetime = Null
	,@ReceivedDate As DateTime = Null
	,@ShippingFee As money = Null
	,@TaxAmount AS money = Null
	,@PaymentDate As DateTime = Null
	,@PaymentAmount AS money = Null
	,@PaymentMethod as nvarchar(50) = Null
	,@Notes AS nvarchar(max) = Null
	,@VendorID as Int = Null
	,@StatusID as int = null

	,@LocalID as int = 0 OUTPUT
	,@ErrorCode AS int = 0 OUTPUT
	,@Message AS nvarchar(400) = 'Updated Purchase Order' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	Begin Try 
		BEGIN
			UPDATE [dbo].[PurchaseOrders]
			SET [VendorID] =	CASE 
								WHEN @VendorID = 0 
								THEN VendorID
								ELSE COALESCE(NULLIF(@VendorID,''), VendorID)
								END 
				,[SubmittedByID] =	CASE 
									WHEN @SubmittedByID = 0 
									THEN SubmittedByID
									ELSE COALESCE(NULLIF(@SubmittedByID,''), SubmittedByID)
									END 
				,[SubmittedDate] = CASE WHEN @SubmittedDate IS NULL THEN [SubmittedDate] ELSE @SubmittedDate END
				,[ApprovedByID] = CASE 
									WHEN @ApprovedByID = 0 
									THEN ApprovedByID
									ELSE COALESCE(NULLIF(@ApprovedByID,''), ApprovedByID) 
									END
				,[ApprovedDate] = IsNull(@ApprovedDate,[ApprovedDate]) 
				,[StatusID]		 = CASE 
									WHEN @StatusID = 0 
									THEN StatusID
									ELSE COALESCE(NULLIF(@StatusID,''), StatusID) 
									END
				,[ReceivedDate] = CASE WHEN @ReceivedDate IS NULL THEN [ReceivedDate] ELSE @ReceivedDate END 
				,[ShippingFee] = CASE WHEN @ShippingFee IS NULL THEN [ShippingFee] ELSE @ShippingFee END
				,[TaxAmount]	 = IsNull(@TaxAmount,TaxAmount) 
				,[PaymentDate] = CASE WHEN @PaymentDate IS NULL THEN PaymentDate ELSE @PaymentDate END 
				,[PaymentAmount] = IsNull(@PaymentAmount,PaymentAmount) 
				,[PaymentMethod] = IsNull(@PaymentMethod,[PaymentMethod]) 
				,[Notes] = IsNull(@Notes,[Notes]) 
			WHERE PurchaseOrderID = @PurchaseOrderID;
		END	
		SET @LocalID = @PurchaseOrderID;
		SET @ErrorCode = 0;
		SET @Message = 'Updated Purchase Order ' + Cast(@LocalID as NVarchar(10));
		If @StatusID = 5 
			BEGIN
				DECLARE @LocalErrorCode as int,
						@LocalMessage as nvarchar(400);
				Exec [dbo].[ReceivePurchaseOrder]
					@PurchaseOrderID = @PurchaseOrderID,

					@LocalID = @LocalID OUTPUT,
					@LocalErrorCode = @ErrorCode OUTPUT,
					@LocalMessage = @Message OUTPUT;
				SET @ErrorCode = @LocalErrorCode;
				SET @Message = @LocalMessage;
			END
	END Try
	BEGIN Catch
		SET @LocalID = @PurchaseOrderID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_UpdatePODetail]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 20250316
Description: Called to update an item in the PO Details table
=============================================
*/
CREATE PROCEDURE [dbo].[Z_UpdatePODetail] 
	@PurchaseOrderDetailID AS int ,
	@ProductID as int = Null,
	@Quantity as int = Null,
	@UnitCost as money = Null,
	@ReceivedDate as DateTime = Null,

 @LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Updated PO Detail' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		DECLARE @POReceivedDate as DateTime;
		BEGIN
			SELECT @POReceivedDate = PO.ReceivedDate
			FROM PurchaseOrders AS PO INNER JOIN PurchaseOrderDetails AS POD
			ON PO.PurchaseOrderID = POD.PurchaseOrderID 
			WHERE POD.PurchaseOrderDetailID =@PurchaseOrderDetailID;
			IF @POReceivedDate Is Null AND @ReceivedDate Is Not Null
				BEGIN
					SET	@ErrorCode = 51260;
					SET	@Message = 'Purchase Order Details can''t be received 
									 until the Purchase Order is received ';
					RETURN;
				END
			ELSE 
				SET @ReceivedDate =@POReceivedDate;
		END
 		UPDATE dbo.PurchaseOrderDetails
		Set ProductID = IsNull(@ProductID,ProductID),
			Quantity = IsNull(@Quantity,Quantity),
			UnitCost = IsNull(@UnitCost,UnitCost),
			ReceivedDate = CASE WHEN @ReceivedDate IS Null Then ReceivedDate ELSE @ReceivedDate END
		WHERE PurchaseOrderDetailID= @PurchaseOrderDetailID; 
		SET @LocalID = @PurchaseOrderDetailID; 
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Updated Purchase Order Detail ' +Cast(@LocalID as nvarchar(10)); 
	END Try
	BEGIN Catch
		SET @LocalID = @PurchaseOrderDetailID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
 
GO
/****** Object:  StoredProcedure [dbo].[Z_UpdateProduct]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		George Hepworth
Create date: 03/16/2025
Description:	Update an item in the Product table
=============================================
*/
CREATE PROCEDURE [dbo].[Z_UpdateProduct] 
	@ProductID AS int,
	@ProductName as nvarchar(50) = Null ,
	@ProductDescription as nvarchar(Max) = null,
	@ClearProductDescription as bit = 0, 
	@StandardUnitCost as money = Null,
	@UnitPrice as money = Null,
	@ReorderLevel as int = Null ,
	@TargetLevel as int = Null ,
	@QuantityPerUnit as nvarchar(50) = Null,
	@Discontinued as bit = Null , 
	@MinimumReorderQuantity as int = Null,
	@ProductCategoryID as int = Null,

	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Updated' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		UPDATE dbo.Products
		Set ProductName = COALESCE(NULLIF(@ProductName,''), ProductName),
			ProductDescription = CASE 
				WHEN @ClearProductDescription = 1 THEN NULL
				ELSE COALESCE(NULLIF(@ProductDescription,''), ProductDescription)
				END,
			StandardUnitCost = IsNull(@StandardUnitCost, StandardUnitCost),
			UnitPrice = IsNull(@UnitPrice, UnitPrice),
			ReorderLevel = IsNull(@ReorderLevel, ReorderLevel),
			TargetLevel = IsNull(@TargetLevel, TargetLevel),
			QuantityPerUnit = COALESCE(NULLIF(@QuantityPerUnit,''), QuantityPerUnit),
			Discontinued = IsNull(@Discontinued, Discontinued),
			MinimumReorderQuantity = IsNull(@MinimumReorderQuantity, MinimumReorderQuantity),
			ProductCategoryID = IsNull(@ProductCategoryID, ProductCategoryID)
		WHERE ProductID = @ProductID; 
		SET @LocalID = @ProductID; 
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Updated Product ' +Cast(@LocalID as nvarchar(10)); 
	END Try
	BEGIN Catch
		SET @LocalID = @ProductID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
 
GO
/****** Object:  StoredProcedure [dbo].[Z_UpdateProductVendor]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
=============================================
Author:		George Hepworth
Create date: 4/1/2025
Description:	Update Product Vendor 
=============================================
*/
CREATE PROCEDURE [dbo].[Z_UpdateProductVendor]
	@ProductVendorID As Int,
	@ProductID AS int = Null,
	@VendorID AS int = Null,

	@LocalID as int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		UPDATE [dbo].[ProductVendors]
		SET [ProductID] = IsNull(@ProductID , [ProductID])
		   ,[VendorID] = IsNull(@VendorID , VendorID)
		WHERE ProductVendorID = @ProductVendorID;
		IF @@ROWCOUNT = 0
			BEGIN
				SET @ErrorCode = -100;
				SET @Message = 'ProductVendor ID ' + CAST(@ProductVendorID AS NVARCHAR(10)) + ' not found';
			END
			ELSE
			BEGIN
				SET @LocalID = @ProductVendorID;
				SET @ErrorCode = 0;
				SET @Message = 'Updated ProductVendor ' + Cast(@LocalID as NvarChar(10));
			END
	END Try
	BEGIN Catch
		SET @LocalID = @ProductVendorID; 
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
GO
/****** Object:  StoredProcedure [dbo].[Z_UpdateStockTake]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 5/21/2025
Description: Update a StockTake for a Product
=============================================
*/
CREATE PROCEDURE [dbo].[Z_UpdateStockTake] 
	@StockTakeID as int,
	@ProductID AS int = 0,
	@StockTakeDate as DateTime = Null,
	@QuantityOnHand As Int = Null,
	@ExpectedQuantity as Int = Null,

	@LocalID As Int = 0 OUTPUT,	 
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Updated' OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN Try
		UPDATE dbo.StockTake
		SET QuantityOnHand = CASE WHEN @QuantityOnHand Is NULL THEN QuantityOnHand ELSE @QuantityOnHand END,
			ExpectedQuantity = CASE WHEN @ExpectedQuantity Is Null THEN ExpectedQuantity 
							 ELSE @ExpectedQuantity END
		WHERE StockTakeID = @StockTakeID; 
		SET @LocalID = @ProductID; 
		SET	@ErrorCode = 0 ;
		SET	@Message = 'Updated Stocktake for ' + Cast(@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @ProductID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch
END
 
GO
/****** Object:  StoredProcedure [dbo].[Z_UpdateSystemSetting]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 05/27/2025
Description: Update one System Setting
=============================================
*/
CREATE PROCEDURE [dbo].[Z_UpdateSystemSetting]
	@SettingID as Int = 0,
	@SettingName As nvarchar(50)= Null,
	@SettingValue As nvarchar(255)= Null,
	@Notes As nvarchar(255)= Null,
 
	@LocalID AS int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		UPDATE [dbo].[SystemSettings]
		SET [SettingName] = Case WHEN @SettingName Is Null THEN SettingName ELSE @SettingID END,
			[SettingValue] = Case WHEN @SettingValue Is Null THEN SettingValue ELSE @SettingValue END,
			[Notes]		 = Case WHEN @Notes Is Null THEN Notes ELSE @Notes END
		WHERE SettingID = @SettingID;
		SET @LocalID = @SettingID;
		SET @ErrorCode = 0;
		SET @Message = 'Updated System Settings ' + Cast(@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @SettingID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch 
END
GO
/****** Object:  StoredProcedure [dbo].[Z_UpdateUserSetting]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George Hepworth
Create date: 05/27/2025
Description: Update one User Setting
=============================================
*/
CREATE PROCEDURE [dbo].[Z_UpdateUserSetting]
	@SettingID as Int = 0,
	@SettingName As nvarchar(50)= Null,
	@SettingValue As nvarchar(255)= Null,
	@Notes As nvarchar(255)= Null,
 
	@LocalID AS int = 0 OUTPUT,
	@ErrorCode AS int = 0 OUTPUT,
	@Message AS nvarchar(400) = 'Success' OUTPUT 
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		UPDATE [dbo].[UserSettings]
		SET [SettingName] = Case WHEN @SettingName Is Null THEN SettingName ELSE @SettingID END,
			[SettingValue] = Case WHEN @SettingValue Is Null THEN SettingValue ELSE @SettingValue END,
			[Notes]		 = Case WHEN @Notes Is Null THEN Notes ELSE @Notes END
		WHERE SettingID = @SettingID;
		SET @LocalID = @SettingID;
		SET @ErrorCode = 0;
		SET @Message = 'Updated System Settings ' + Cast(@LocalID as nvarchar(10));
	END Try
	BEGIN Catch
		SET @LocalID = @SettingID;
		SET @ErrorCode = ERROR_NUMBER();
		SET @Message = ERROR_MESSAGE();
	END Catch 
END
GO
/****** Object:  Trigger [dbo].[AuditCompanies]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditCompanies] 
   ON [dbo].[Companies] 
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.Companies  t
    INNER JOIN inserted i ON t.CompanyID = i.CompanyID
    LEFT JOIN deleted d ON t.CompanyID = d.CompanyID
    WHERE d.CompanyID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.Companies  t
    INNER JOIN inserted i ON t.CompanyID = i.CompanyID
    INNER JOIN deleted d ON t.CompanyID = d.CompanyID;  -- Only for updates
 

END
GO
ALTER TABLE [dbo].[Companies] ENABLE TRIGGER [AuditCompanies]
GO
/****** Object:  Trigger [dbo].[AuditCompanyTypes]    Script Date: 7/26/2025 5:33:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditCompanyTypes] 
   ON [dbo].[CompanyTypes] 
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.CompanyTypes  t
    INNER JOIN inserted i ON t.CompanyTypeID = i.CompanyTypeID
    LEFT JOIN deleted d ON t.CompanyTypeID = d.CompanyTypeID
    WHERE d.CompanyTypeID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.CompanyTypes  t
    INNER JOIN inserted i ON t.CompanyTypeID = i.CompanyTypeID
    INNER JOIN deleted d ON t.CompanyTypeID = d.CompanyTypeID;  -- Only for updates
 

END
GO
ALTER TABLE [dbo].[CompanyTypes] ENABLE TRIGGER [AuditCompanyTypes]
GO
/****** Object:  Trigger [dbo].[AuditContacts]    Script Date: 7/26/2025 5:33:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditContacts] 
   ON [dbo].[Contacts] 
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.Contacts  t
    INNER JOIN inserted i ON t.ContactID = i.ContactID
    LEFT JOIN deleted d ON t.ContactID = d.ContactID
    WHERE d.ContactID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.Contacts  t
    INNER JOIN inserted i ON t.ContactID = i.ContactID
    INNER JOIN deleted d ON t.ContactID = d.ContactID;  -- Only for updates
 

END
GO
ALTER TABLE [dbo].[Contacts] ENABLE TRIGGER [AuditContacts]
GO
/****** Object:  Trigger [dbo].[AuditEmployeePrivileges]    Script Date: 7/26/2025 5:33:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditEmployeePrivileges] 
   ON [dbo].[EmployeePrivileges] 
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.EmployeePrivileges  t
    INNER JOIN inserted i ON t.EmployeePrivilegeID = i.EmployeePrivilegeID
    LEFT JOIN deleted d ON t.EmployeePrivilegeID = d.EmployeePrivilegeID
    WHERE d.EmployeePrivilegeID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.EmployeePrivileges  t
    INNER JOIN inserted i ON t.EmployeePrivilegeID = i.EmployeePrivilegeID
    INNER JOIN deleted d ON t.EmployeePrivilegeID = d.EmployeePrivilegeID;  -- Only for updates
 

END
GO
ALTER TABLE [dbo].[EmployeePrivileges] ENABLE TRIGGER [AuditEmployeePrivileges]
GO
/****** Object:  Trigger [dbo].[AuditEmployees]    Script Date: 7/26/2025 5:33:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditEmployees] 
   ON [dbo].[Employees] 
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.Employees  t
    INNER JOIN inserted i ON t.EmployeeID = i.EmployeeID
    LEFT JOIN deleted d ON t.EmployeeID = d.EmployeeID
    WHERE d.EmployeeID IS NULL;  -- Filtering on records in the deleted table 
								 -- where the employeeID is null limits the action to new inserts only

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.Employees  t
    INNER JOIN inserted i ON t.EmployeeID = i.EmployeeID
    INNER JOIN deleted d ON t.EmployeeID = d.EmployeeID;  -- Filtering on records in the deleted table 
								    					  -- where the employeeID is not null limits the action to updates only
 

END
GO
ALTER TABLE [dbo].[Employees] ENABLE TRIGGER [AuditEmployees]
GO
/****** Object:  Trigger [dbo].[AuditOrderDetails]    Script Date: 7/26/2025 5:33:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditOrderDetails] 
   ON [dbo].[OrderDetails] 
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.OrderDetails  t
    INNER JOIN inserted i ON t.OrderDetailID = i.OrderDetailID
    LEFT JOIN deleted d ON t.OrderDetailID = d.OrderDetailID
    WHERE d.OrderDetailID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.OrderDetails  t
    INNER JOIN inserted i ON t.OrderDetailID = i.OrderDetailID
    INNER JOIN deleted d ON t.OrderDetailID = d.OrderDetailID;  -- Only for updates
 

END
GO
ALTER TABLE [dbo].[OrderDetails] ENABLE TRIGGER [AuditOrderDetails]
GO
/****** Object:  Trigger [dbo].[AuditOrderDetailStatus]    Script Date: 7/26/2025 5:33:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditOrderDetailStatus] 
   ON [dbo].[OrderDetailStatus] 
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.OrderDetailStatus  t
    INNER JOIN inserted i ON t.OrderDetailStatusID = i.OrderDetailStatusID
    LEFT JOIN deleted d ON t.OrderDetailStatusID = d.OrderDetailStatusID
    WHERE d.OrderDetailStatusID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.OrderDetailStatus  t
    INNER JOIN inserted i ON t.OrderDetailStatusID = i.OrderDetailStatusID
    INNER JOIN deleted d ON t.OrderDetailStatusID = d.OrderDetailStatusID;  -- Only for updates
 

END
GO
ALTER TABLE [dbo].[OrderDetailStatus] ENABLE TRIGGER [AuditOrderDetailStatus]
GO
/****** Object:  Trigger [dbo].[AuditOrders]    Script Date: 7/26/2025 5:33:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditOrders] 
   ON [dbo].[Orders] 
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.Orders  t
    INNER JOIN inserted i ON t.OrderID = i.OrderID
    LEFT JOIN deleted d ON t.OrderID = d.OrderID
    WHERE d.OrderID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.Orders  t
    INNER JOIN inserted i ON t.OrderID = i.OrderID
    INNER JOIN deleted d ON t.OrderID = d.OrderID;  -- Only for updates
 

END
GO
ALTER TABLE [dbo].[Orders] ENABLE TRIGGER [AuditOrders]
GO
/****** Object:  Trigger [dbo].[AuditOrderStatus]    Script Date: 7/26/2025 5:33:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditOrderStatus] 
   ON [dbo].[OrderStatus] 
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.OrderStatus  t
    INNER JOIN inserted i ON t.OrderStatusID = i.OrderStatusID
    LEFT JOIN deleted d ON t.OrderStatusID = d.OrderStatusID
    WHERE d.OrderStatusID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.OrderStatus  t
    INNER JOIN inserted i ON t.OrderStatusID = i.OrderStatusID
    INNER JOIN deleted d ON t.OrderStatusID = d.OrderStatusID;  -- Only for updates
 
END
GO
ALTER TABLE [dbo].[OrderStatus] ENABLE TRIGGER [AuditOrderStatus]
GO
/****** Object:  Trigger [dbo].[AuditPrivileges]    Script Date: 7/26/2025 5:33:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditPrivileges] 
   ON [dbo].[Privileges] 
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.Privileges  t
    INNER JOIN inserted i ON t.PrivilegeID = i.PrivilegeID
    LEFT JOIN deleted d ON t.PrivilegeID = d.PrivilegeID
    WHERE d.PrivilegeID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.Privileges  t
    INNER JOIN inserted i ON t.PrivilegeID = i.PrivilegeID
    INNER JOIN deleted d ON t.PrivilegeID = d.PrivilegeID;  -- Only for updates
 
END
GO
ALTER TABLE [dbo].[Privileges] ENABLE TRIGGER [AuditPrivileges]
GO
/****** Object:  Trigger [dbo].[AuditProductCategories]    Script Date: 7/26/2025 5:33:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditProductCategories] 
   ON [dbo].[ProductCategories] 
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.ProductCategories  t
    INNER JOIN inserted i ON t.ProductCategoryID = i.ProductCategoryID
    LEFT JOIN deleted d ON t.ProductCategoryID = d.ProductCategoryID
    WHERE d.ProductCategoryID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.ProductCategories  t
    INNER JOIN inserted i ON t.ProductCategoryID = i.ProductCategoryID
    INNER JOIN deleted d ON t.ProductCategoryID = d.ProductCategoryID;  -- Only for updates
 
END
GO
ALTER TABLE [dbo].[ProductCategories] ENABLE TRIGGER [AuditProductCategories]
GO
/****** Object:  Trigger [dbo].[AuditProducts]    Script Date: 7/26/2025 5:33:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
=============================================
Author:		 George R Hepworth
Create date: 20250315
Description: Capture all data changes
               ChatGPT assisted
			 Create Unique Product Code 
=============================================
*/
CREATE TRIGGER [dbo].[AuditProducts] 
   ON [dbo].[Products] 
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;
	Declare @ProductCode As NVarchar(5),
	@LocalID as Int;
     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME()) 
    FROM dbo.Products  t
    INNER JOIN inserted i ON t.ProductID = i.ProductID
    LEFT JOIN deleted d ON t.ProductID = d.ProductID
    WHERE d.ProductID IS NULL;  --Only for inserts
    --Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.Products  t
    INNER JOIN inserted i ON t.ProductID = i.ProductID
    INNER JOIN deleted d ON t.ProductID = d.ProductID;  --Only for updates
	SELECT @LocalID =  ProductID FROM inserted; 
		Update Products SET ProductCode =
		'NWT'+ 
		PC.ProductCategoryCode +
		'-' +
		Cast(P.ProductID as Nvarchar(6)) 
		FROM ProductCategories PC
		INNER JOIN Products P
		ON PC.ProductCategoryID=P.ProductCategoryID
		WHERE P.ProductID =@LocalID;
END
GO
ALTER TABLE [dbo].[Products] ENABLE TRIGGER [AuditProducts]
GO
/****** Object:  Trigger [dbo].[AuditProductVendors]    Script Date: 7/26/2025 5:33:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditProductVendors] 
   ON [dbo].[ProductVendors]
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.ProductVendors  t
    INNER JOIN inserted i ON t.ProductVendorID = i.ProductVendorID
    LEFT JOIN deleted d ON t.ProductID = d.ProductID
    WHERE d.ProductVendorID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.ProductVendors  t
    INNER JOIN inserted i ON t.ProductVendorID = i.ProductVendorID
    INNER JOIN deleted d ON t.ProductVendorID = d.ProductVendorID;  -- Only for updates
 
END
GO
ALTER TABLE [dbo].[ProductVendors] ENABLE TRIGGER [AuditProductVendors]
GO
/****** Object:  Trigger [dbo].[AuditPurchaseOrderDetails]    Script Date: 7/26/2025 5:33:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditPurchaseOrderDetails] 
   ON [dbo].[PurchaseOrderDetails]
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.PurchaseOrderDetails  t
    INNER JOIN inserted i ON t.PurchaseOrderDetailID = i.PurchaseOrderDetailID
    LEFT JOIN deleted d ON t.PurchaseOrderDetailID = d.PurchaseOrderDetailID
    WHERE d.PurchaseOrderDetailID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.PurchaseOrderDetails  t
    INNER JOIN inserted i ON t.PurchaseOrderDetailID = i.PurchaseOrderDetailID
    INNER JOIN deleted d ON t.PurchaseOrderDetailID = d.PurchaseOrderDetailID;  -- Only for updates
 
END
GO
ALTER TABLE [dbo].[PurchaseOrderDetails] ENABLE TRIGGER [AuditPurchaseOrderDetails]
GO
/****** Object:  Trigger [dbo].[AuditPurchaseOrders]    Script Date: 7/26/2025 5:33:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditPurchaseOrders] 
   ON [dbo].[PurchaseOrders]
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.PurchaseOrders  t
    INNER JOIN inserted i ON t.PurchaseOrderID = i.PurchaseOrderID
    LEFT JOIN deleted d ON t.PurchaseOrderID = d.PurchaseOrderID
    WHERE d.PurchaseOrderID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.PurchaseOrders  t
    INNER JOIN inserted i ON t.PurchaseOrderID = i.PurchaseOrderID
    INNER JOIN deleted d ON t.PurchaseOrderID = d.PurchaseOrderID;  -- Only for updates
 
END
GO
ALTER TABLE [dbo].[PurchaseOrders] ENABLE TRIGGER [AuditPurchaseOrders]
GO
/****** Object:  Trigger [dbo].[AuditPurchaseOrderStatus]    Script Date: 7/26/2025 5:33:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditPurchaseOrderStatus] 
   ON [dbo].[PurchaseOrderStatus]
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.PurchaseOrderStatus  t
    INNER JOIN inserted i ON t.StatusID = i.StatusID
    LEFT JOIN deleted d ON t.StatusID = d.StatusID
    WHERE d.StatusID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.PurchaseOrderStatus  t
    INNER JOIN inserted i ON t.StatusID = i.StatusID
    INNER JOIN deleted d ON t.StatusID = d.StatusID;  -- Only for updates
 
END
GO
ALTER TABLE [dbo].[PurchaseOrderStatus] ENABLE TRIGGER [AuditPurchaseOrderStatus]
GO
/****** Object:  Trigger [dbo].[AuditSSErrors]    Script Date: 7/26/2025 5:33:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
Create TRIGGER [dbo].[AuditSSErrors] 
   ON [dbo].[SSErrors]
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.SSErrors  t
    INNER JOIN inserted i ON t.SSErrorID = i.SSErrorID
    LEFT JOIN deleted d ON t.SSErrorID = d.SSErrorID
    WHERE d.SSErrorID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.SSErrors  t
    INNER JOIN inserted i ON t.SSErrorID = i.SSErrorID
    INNER JOIN deleted d ON t.SSErrorID = d.SSErrorID;  -- Only for updates
 
END
GO
ALTER TABLE [dbo].[SSErrors] ENABLE TRIGGER [AuditSSErrors]
GO
/****** Object:  Trigger [dbo].[AuditStockTake]    Script Date: 7/26/2025 5:33:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditStockTake] 
   ON [dbo].[StockTake]
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.StockTake  t
    INNER JOIN inserted i ON t.StockTakeID = i.StockTakeID
    LEFT JOIN deleted d ON t.StockTakeID = d.StockTakeID
    WHERE d.StockTakeID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.StockTake  t
    INNER JOIN inserted i ON t.StockTakeID = i.StockTakeID
    INNER JOIN deleted d ON t.StockTakeID = d.StockTakeID;  -- Only for updates
 
END
GO
ALTER TABLE [dbo].[StockTake] ENABLE TRIGGER [AuditStockTake]
GO
/****** Object:  Trigger [dbo].[AuditStrings]    Script Date: 7/26/2025 5:33:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditStrings] 
   ON [dbo].[Strings]
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.Strings  t
    INNER JOIN inserted i ON t.StringID = i.StringID
    LEFT JOIN deleted d ON t.StringID = d.StringID
    WHERE d.StringID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.Strings  t
    INNER JOIN inserted i ON t.StringID = i.StringID
    INNER JOIN deleted d ON t.StringID = d.StringID;  -- Only for updates
 
END
GO
ALTER TABLE [dbo].[Strings] ENABLE TRIGGER [AuditStrings]
GO
/****** Object:  Trigger [dbo].[AuditTaxStatus]    Script Date: 7/26/2025 5:33:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE TRIGGER [dbo].[AuditTaxStatus] 
   ON [dbo].[TaxStatus]
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.TaxStatus  t
    INNER JOIN inserted i ON t.TaxStatusID = i.TaxStatusID
    LEFT JOIN deleted d ON t.TaxStatusID = d.TaxStatusID
    WHERE d.TaxStatusID IS NULL;  -- Only for inserts

    -- Update records for UPDATE
    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.TaxStatus  t
    INNER JOIN inserted i ON t.TaxStatusID = i.TaxStatusID
    INNER JOIN deleted d ON t.TaxStatusID = d.TaxStatusID;  -- Only for updates
 
END
GO
ALTER TABLE [dbo].[TaxStatus] ENABLE TRIGGER [AuditTaxStatus]
GO
/****** Object:  Trigger [dbo].[AuditTitles]    Script Date: 7/26/2025 5:33:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		George R Hepworth
-- Create date: 20250315
-- Description:	Capture all data changes
--               ChatGPT assisted 
-- =============================================
CREATE   TRIGGER [dbo].[AuditTitles] 
   ON [dbo].[Titles]
   AFTER INSERT,UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

     UPDATE t
    SET 
        t.AddedOn = COALESCE(i.AddedOn, GETDATE()), 
        t.AddedBy = COALESCE(i.AddedBy, SUSER_NAME())
    FROM dbo.Titles  t
    INNER JOIN inserted i ON t.Title = i.Title
    LEFT JOIN deleted d ON t.Title = d.Title
    WHERE d.Title IS NULL;

    UPDATE t
    SET 
        t.ModifiedOn = GETDATE(), 
        t.ModifiedBy = SUSER_NAME()
    FROM dbo.Titles  t
	WHERE T.Title in (SELECT Title FROM inserted);
 
END
GO
ALTER TABLE [dbo].[Titles] ENABLE TRIGGER [AuditTitles]
GO
