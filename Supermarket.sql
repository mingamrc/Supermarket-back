USE [master]
GO

ALTER DATABASE [Supermarket] SET SINGLE_USER WITH ROLLBACK IMMEDIATE

DROP DATABASE [Supermarket]

/****** Object:  Database [Supermarket]    Script Date: 25/09/2021 10:11:29 ******/
CREATE DATABASE [Supermarket]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Supermarket', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Supermarket.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Supermarket_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Supermarket_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Supermarket] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Supermarket].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Supermarket] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Supermarket] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Supermarket] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Supermarket] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Supermarket] SET ARITHABORT OFF 
GO
ALTER DATABASE [Supermarket] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Supermarket] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Supermarket] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Supermarket] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Supermarket] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Supermarket] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Supermarket] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Supermarket] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Supermarket] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Supermarket] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Supermarket] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Supermarket] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Supermarket] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Supermarket] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Supermarket] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Supermarket] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Supermarket] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Supermarket] SET RECOVERY FULL 
GO
ALTER DATABASE [Supermarket] SET  MULTI_USER 
GO
ALTER DATABASE [Supermarket] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Supermarket] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Supermarket] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Supermarket] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Supermarket] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Supermarket] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Supermarket', N'ON'
GO
ALTER DATABASE [Supermarket] SET QUERY_STORE = OFF
GO
USE [Supermarket]
GO
/****** Object:  Table [dbo].[Articles]    Script Date: 25/09/2021 10:11:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Code] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[Expiration] [date] NULL,
	[CatID] [int] NOT NULL,
	[ImgURL] [varchar](max) NULL,
 CONSTRAINT [PK_Articles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 25/09/2021 10:11:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CatID] [int] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](50) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 25/09/2021 10:11:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Admin] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articles] ADD  DEFAULT ('https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png') FOR [ImgURL]
GO
ALTER TABLE [dbo].[Articles]  WITH CHECK ADD  CONSTRAINT [FK_Articles_Categories] FOREIGN KEY([CatID])
REFERENCES [dbo].[Categories] ([CatID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Articles] CHECK CONSTRAINT [FK_Articles_Categories]
GO
USE [master]
GO
ALTER DATABASE [Supermarket] SET  READ_WRITE 
GO

USE [Supermarket]
GO
INSERT INTO 
	[dbo].[Categories] (category, description)
VALUES
	('Frutta', 'tutto ciò che ha i semi'),
	('Carne', 'Tutto ciò che mangi dagli animali'),
	('Latticini', 'Latte di prima qualità appena munto'),
	('Giocattoli', 'Divertimento per tutti'),
	('Pescheria', 'Pesce fresco pesce vivo')

INSERT INTO 
	[dbo].[Articles] (name, code, price, expiration, CatID, ImgURL)
VALUES
	('Meloni', 19638527, 2.34, '10/10/2021', 1, 'https://www.fruttaweb.com/consigli/wp-content/uploads/2017/10/melone_proprieta_benefici.jpg'),
	('Prosciutto', 54387628, 1.99, '5/10/2021', 2, 'https://www.ilprosciuttocrudo.it/998-thickbox_default/prosciutto-cotto-italiano-lo-storico-nazionale-105-kg-buoni-cotti-pertus.jpg'),
	('Latte', 87654321, 0.99, '3/9/2021', 3, 'https://uploads.nonsprecare.it/wp-content/uploads/2017/03/benefici-latte-2.jpg'),
	('Barbie', 12456735, 5.99, '8/10/2021', 4, 'https://storage.googleapis.com/toyscenter-media/2020/03/57904ec6-hdg_matgjn32-600x548.jpg'),
	('Totani', 11329874, 4.74, '9/10/2021', 5, 'https://www.ilgiornaledelcibo.it/wp-content/uploads/2017/06/caratteristiche-totani.jpg'),
	('Cocomeri', 87437645, 1.34, '8/10/2021', 1, 'https://file.cure-naturali.it/site/image/hotspot_article_first/5588.jpg'),
	('HotWheels', 45729867, 2.01, '3/10/2021', 4, 'https://www.mammacheshop.com/wp-content/uploads/products/62539/gvg37-hotwheels-camion-trasportatore-2-1.jpg'),
	('Burro', 22234236, 1.62, '8/10/2021', 3, 'https://www.greenme.it/wp-content/uploads/2020/09/burro-test.jpg'),
	('Capocollo', 65477899, 2.34, '4/11/2021', 2, 'https://www.dortacarni.it/wp-content/uploads/2019/04/capicollo-161.jpg'),
	('Calamari', 88876665, 6.44, '1/11/2021', 5, 'https://www.cucchiaio.it/content/cucchiaio/it/ricette/2019/06/calamari-al-sugo/_jcr_content/header-par/image-single.img10.jpg/1559662038755.jpg'),
	('Gormiti', 54112349, 9.55, '7/12/2021', 3, 'https://sites.google.com/site/preziosicollectionit/_/rsrc/1365166081672/nuovi-gormiti-3d/5127_42_MediaCenterZoom_.jpg')


INSERT INTO
	[dbo].[Users] (Name, Email, Username, Password, Admin)
VALUES
	('admin', 'admin@admin.it', 'admin', 'admin', 1),
	('Mario', 'mario@tiscali.it', 'mario', 'mario', 0),
	('Anselmo', 'anselmo99@libero.it', 'anselmo', 'anselmo', 0),
	('Plinio', 'plinio@gmail.com', 'plinio', 'plinio', 0),
	('Giovanna', 'giovanna@hotmail.it', 'giovanna', 'giovanna', 0)

SELECT * FROM Categories
SELECT * FROM Articles
SELECT * FROM Users
