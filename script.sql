USE [master]
GO
/****** Object:  Database [bazaRadova]    Script Date: 09/02/2014 23:26:43 ******/
CREATE DATABASE [bazaRadova] ON  PRIMARY 
( NAME = N'bazaRadova', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\bazaRadova.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'bazaRadova_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\bazaRadova_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [bazaRadova] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [bazaRadova].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [bazaRadova] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [bazaRadova] SET ANSI_NULLS OFF
GO
ALTER DATABASE [bazaRadova] SET ANSI_PADDING OFF
GO
ALTER DATABASE [bazaRadova] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [bazaRadova] SET ARITHABORT OFF
GO
ALTER DATABASE [bazaRadova] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [bazaRadova] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [bazaRadova] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [bazaRadova] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [bazaRadova] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [bazaRadova] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [bazaRadova] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [bazaRadova] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [bazaRadova] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [bazaRadova] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [bazaRadova] SET  DISABLE_BROKER
GO
ALTER DATABASE [bazaRadova] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [bazaRadova] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [bazaRadova] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [bazaRadova] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [bazaRadova] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [bazaRadova] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [bazaRadova] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [bazaRadova] SET  READ_WRITE
GO
ALTER DATABASE [bazaRadova] SET RECOVERY SIMPLE
GO
ALTER DATABASE [bazaRadova] SET  MULTI_USER
GO
ALTER DATABASE [bazaRadova] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [bazaRadova] SET DB_CHAINING OFF
GO
USE [bazaRadova]
GO
/****** Object:  Table [dbo].[Rad]    Script Date: 09/02/2014 23:26:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rad](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Year] [smallint] NOT NULL,
	[filePDFpath] [nvarchar](500) NOT NULL,
	[fileTXTpath] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_Rad] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kategorija]    Script Date: 09/02/2014 23:26:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kategorija](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Kategorija] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Autor]    Script Date: 09/02/2014 23:26:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Autor](
	[IDAutor] [int] IDENTITY(1,1) NOT NULL,
	[ImeAutora] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Autor] PRIMARY KEY CLUSTERED 
(
	[IDAutor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Slicnost]    Script Date: 09/02/2014 23:26:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slicnost](
	[IDrad1] [int] NOT NULL,
	[IDrad2] [int] NOT NULL,
	[Similarity] [decimal](8, 4) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RadKategorija]    Script Date: 09/02/2014 23:26:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RadKategorija](
	[RadID] [int] NOT NULL,
	[KatID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RadAutor]    Script Date: 09/02/2014 23:26:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RadAutor](
	[IDRad] [int] NOT NULL,
	[IDAutor] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spInsertAutore]    Script Date: 09/02/2014 23:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertAutore]
	-- Add the parameters for the stored procedure here
@imeautora as varchar(100)
AS
BEGIN
declare @idrad as int
set @idrad = (select MAX(id) from Rad)

begin tran
 insert into autor (imeautora) values (@imeautora)
 commit tran
 
 declare @idautor as int
 set @idautor = (select idautor from autor where imeautora = @imeautora)
  insert into radautor (idrad,idautor) values (@idrad,@idautor)
  
END
GO
/****** Object:  ForeignKey [FK_RadKategorija_Kategorija]    Script Date: 09/02/2014 23:26:45 ******/
ALTER TABLE [dbo].[RadKategorija]  WITH CHECK ADD  CONSTRAINT [FK_RadKategorija_Kategorija] FOREIGN KEY([KatID])
REFERENCES [dbo].[Kategorija] ([ID])
GO
ALTER TABLE [dbo].[RadKategorija] CHECK CONSTRAINT [FK_RadKategorija_Kategorija]
GO
/****** Object:  ForeignKey [FK_RadKategorija_Rad]    Script Date: 09/02/2014 23:26:45 ******/
ALTER TABLE [dbo].[RadKategorija]  WITH CHECK ADD  CONSTRAINT [FK_RadKategorija_Rad] FOREIGN KEY([RadID])
REFERENCES [dbo].[Rad] ([ID])
GO
ALTER TABLE [dbo].[RadKategorija] CHECK CONSTRAINT [FK_RadKategorija_Rad]
GO
/****** Object:  ForeignKey [FK_RadAutor_Autor]    Script Date: 09/02/2014 23:26:45 ******/
ALTER TABLE [dbo].[RadAutor]  WITH CHECK ADD  CONSTRAINT [FK_RadAutor_Autor] FOREIGN KEY([IDAutor])
REFERENCES [dbo].[Autor] ([IDAutor])
GO
ALTER TABLE [dbo].[RadAutor] CHECK CONSTRAINT [FK_RadAutor_Autor]
GO
/****** Object:  ForeignKey [FK_RadAutor_Rad]    Script Date: 09/02/2014 23:26:45 ******/
ALTER TABLE [dbo].[RadAutor]  WITH CHECK ADD  CONSTRAINT [FK_RadAutor_Rad] FOREIGN KEY([IDRad])
REFERENCES [dbo].[Rad] ([ID])
GO
ALTER TABLE [dbo].[RadAutor] CHECK CONSTRAINT [FK_RadAutor_Rad]
GO
