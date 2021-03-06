USE [master]
GO
/****** Object:  Database [Biblioteka]    Script Date: 2/26/2017 6:39:00 PM ******/
CREATE DATABASE [Biblioteka]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Biblioteka', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.ROOT\MSSQL\DATA\Biblioteka.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'Biblioteka_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.ROOT\MSSQL\DATA\Biblioteka_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Biblioteka] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Biblioteka].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Biblioteka] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Biblioteka] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Biblioteka] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Biblioteka] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Biblioteka] SET ARITHABORT OFF 
GO
ALTER DATABASE [Biblioteka] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Biblioteka] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Biblioteka] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Biblioteka] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Biblioteka] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Biblioteka] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Biblioteka] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Biblioteka] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Biblioteka] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Biblioteka] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Biblioteka] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Biblioteka] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Biblioteka] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Biblioteka] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Biblioteka] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Biblioteka] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Biblioteka] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Biblioteka] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Biblioteka] SET  MULTI_USER 
GO
ALTER DATABASE [Biblioteka] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Biblioteka] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Biblioteka] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Biblioteka] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Biblioteka] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Biblioteka] SET QUERY_STORE = OFF
GO
USE [Biblioteka]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Biblioteka]
GO
/****** Object:  User [test]    Script Date: 2/26/2017 6:39:00 PM ******/
CREATE USER [test] FOR LOGIN [test] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [test]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [test]
GO
/****** Object:  Table [dbo].[Korisnik]    Script Date: 2/26/2017 6:39:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Korisnik](
	[KorisnikId] [int] IDENTITY(1,1) NOT NULL,
	[Ime] [nvarchar](25) NOT NULL,
	[Prezime] [nvarchar](30) NOT NULL,
	[BrojLK] [int] NOT NULL,
	[BrojTelefona] [int] NOT NULL,
	[Adresa] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Korisnik] PRIMARY KEY CLUSTERED 
(
	[KorisnikId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[View_Korisnik]    Script Date: 2/26/2017 6:39:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Korisnik]
AS
SELECT        KorisnikId, Ime, Prezime, BrojLK, BrojTelefona, Adresa
FROM            dbo.Korisnik

GO
/****** Object:  Table [dbo].[VrstaPublikacije]    Script Date: 2/26/2017 6:39:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VrstaPublikacije](
	[VrstaPublikacijeId] [int] IDENTITY(1,1) NOT NULL,
	[Naziv] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_VrstaPublikacije] PRIMARY KEY CLUSTERED 
(
	[VrstaPublikacijeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Publikacija]    Script Date: 2/26/2017 6:39:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publikacija](
	[PublikacijaId] [int] IDENTITY(1,1) NOT NULL,
	[VrstaPublikacijeId] [int] NULL,
	[Naziv] [nvarchar](50) NULL,
	[Kom] [int] NULL,
 CONSTRAINT [PK_Publikacija] PRIMARY KEY CLUSTERED 
(
	[PublikacijaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[View_Test]    Script Date: 2/26/2017 6:39:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Test]
AS
SELECT        dbo.VrstaPublikacije.VrstaPublikacijeId, dbo.VrstaPublikacije.Naziv, dbo.Publikacija.PublikacijaId, dbo.Publikacija.Naziv AS Expr2
FROM            dbo.Publikacija INNER JOIN
                         dbo.VrstaPublikacije ON dbo.Publikacija.VrstaPublikacijeId = dbo.VrstaPublikacije.VrstaPublikacijeId

GO
/****** Object:  Table [dbo].[Zaduzenje]    Script Date: 2/26/2017 6:39:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zaduzenje](
	[ZaduzenjeId] [int] IDENTITY(1,1) NOT NULL,
	[PublikacijaId] [int] NOT NULL,
	[KorisnikId] [int] NOT NULL,
	[DatumZaduzenja] [datetime] NULL,
	[DatumRazduzenja] [datetime] NULL,
	[BibliotekarIdZaduzio] [int] NULL,
	[BibiliotekarIdRazduzio] [int] NULL,
	[BrojKnjiga] [int] NOT NULL,
 CONSTRAINT [PK_Zaduzenje] PRIMARY KEY CLUSTERED 
(
	[ZaduzenjeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[View_Zaduzenje]    Script Date: 2/26/2017 6:39:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Zaduzenje]
AS
SELECT        dbo.Korisnik.Ime, dbo.Korisnik.Prezime, dbo.Korisnik.BrojLK, dbo.Korisnik.BrojTelefona, dbo.Korisnik.Adresa, dbo.Zaduzenje.DatumRazduzenja, dbo.Publikacija.Naziv, dbo.Zaduzenje.BrojKnjiga
FROM            dbo.Korisnik INNER JOIN
                         dbo.Zaduzenje ON dbo.Korisnik.KorisnikId = dbo.Zaduzenje.KorisnikId INNER JOIN
                         dbo.Publikacija ON dbo.Zaduzenje.PublikacijaId = dbo.Publikacija.PublikacijaId

GO
/****** Object:  Table [dbo].[Admin]    Script Date: 2/26/2017 6:39:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[Ime] [nvarchar](50) NOT NULL,
	[Sifra] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Autor]    Script Date: 2/26/2017 6:39:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Autor](
	[AutorId] [int] IDENTITY(1,1) NOT NULL,
	[Ime] [nvarchar](25) NOT NULL,
	[Prezime] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Autor] PRIMARY KEY CLUSTERED 
(
	[AutorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AutorPublikacije]    Script Date: 2/26/2017 6:39:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AutorPublikacije](
	[AutorId] [int] NOT NULL,
	[PublikacijaId] [int] NOT NULL,
 CONSTRAINT [PK_AutorPublikacije] PRIMARY KEY CLUSTERED 
(
	[AutorId] ASC,
	[PublikacijaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Bibliotekar]    Script Date: 2/26/2017 6:39:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bibliotekar](
	[BibliotekarId] [int] IDENTITY(1,1) NOT NULL,
	[Ime] [nvarchar](25) NOT NULL,
	[Prezime] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Bibliotekar] PRIMARY KEY CLUSTERED 
(
	[BibliotekarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Admin] ([Ime], [Sifra]) VALUES (N'Test', N'Test')
SET IDENTITY_INSERT [dbo].[Autor] ON 

INSERT [dbo].[Autor] ([AutorId], [Ime], [Prezime]) VALUES (1, N'Ivo', N'Andric')
INSERT [dbo].[Autor] ([AutorId], [Ime], [Prezime]) VALUES (2, N'Wendy', N'Holen')
INSERT [dbo].[Autor] ([AutorId], [Ime], [Prezime]) VALUES (3, N'Richard', N'Wiseman ')
INSERT [dbo].[Autor] ([AutorId], [Ime], [Prezime]) VALUES (4, N'w', N'w')
SET IDENTITY_INSERT [dbo].[Autor] OFF
INSERT [dbo].[AutorPublikacije] ([AutorId], [PublikacijaId]) VALUES (1, 1)
INSERT [dbo].[AutorPublikacije] ([AutorId], [PublikacijaId]) VALUES (1, 2)
INSERT [dbo].[AutorPublikacije] ([AutorId], [PublikacijaId]) VALUES (1, 3)
INSERT [dbo].[AutorPublikacije] ([AutorId], [PublikacijaId]) VALUES (2, 4)
INSERT [dbo].[AutorPublikacije] ([AutorId], [PublikacijaId]) VALUES (3, 5)
SET IDENTITY_INSERT [dbo].[Bibliotekar] ON 

INSERT [dbo].[Bibliotekar] ([BibliotekarId], [Ime], [Prezime]) VALUES (1, N'Predrag', N'Adamovic')
INSERT [dbo].[Bibliotekar] ([BibliotekarId], [Ime], [Prezime]) VALUES (9, N'test', N'test')
SET IDENTITY_INSERT [dbo].[Bibliotekar] OFF
SET IDENTITY_INSERT [dbo].[Korisnik] ON 

INSERT [dbo].[Korisnik] ([KorisnikId], [Ime], [Prezime], [BrojLK], [BrojTelefona], [Adresa]) VALUES (1, N'Dusan', N'Nikolic', 387156, 693300175, N'Brace Lukica 84A')
INSERT [dbo].[Korisnik] ([KorisnikId], [Ime], [Prezime], [BrojLK], [BrojTelefona], [Adresa]) VALUES (24, N'Pera', N'Peric', 234234, 123123, N'Neka 20')
SET IDENTITY_INSERT [dbo].[Korisnik] OFF
SET IDENTITY_INSERT [dbo].[Publikacija] ON 

INSERT [dbo].[Publikacija] ([PublikacijaId], [VrstaPublikacijeId], [Naziv], [Kom]) VALUES (1, 1, N'Most na Drini', 10)
INSERT [dbo].[Publikacija] ([PublikacijaId], [VrstaPublikacijeId], [Naziv], [Kom]) VALUES (2, 1, N'Prokleta avlija', 30)
INSERT [dbo].[Publikacija] ([PublikacijaId], [VrstaPublikacijeId], [Naziv], [Kom]) VALUES (3, 1, N'Bosnian Chronicle', 5)
INSERT [dbo].[Publikacija] ([PublikacijaId], [VrstaPublikacijeId], [Naziv], [Kom]) VALUES (4, 2, N'Putovanje koje menja zivot', 8)
INSERT [dbo].[Publikacija] ([PublikacijaId], [VrstaPublikacijeId], [Naziv], [Kom]) VALUES (5, 2, N'59 sekundi', 10)
INSERT [dbo].[Publikacija] ([PublikacijaId], [VrstaPublikacijeId], [Naziv], [Kom]) VALUES (6, 3, N'Test', 10)
INSERT [dbo].[Publikacija] ([PublikacijaId], [VrstaPublikacijeId], [Naziv], [Kom]) VALUES (7, 3, N'a', 8)
INSERT [dbo].[Publikacija] ([PublikacijaId], [VrstaPublikacijeId], [Naziv], [Kom]) VALUES (10, 3, N'w', 6)
SET IDENTITY_INSERT [dbo].[Publikacija] OFF
SET IDENTITY_INSERT [dbo].[VrstaPublikacije] ON 

INSERT [dbo].[VrstaPublikacije] ([VrstaPublikacijeId], [Naziv]) VALUES (1, N'Romani')
INSERT [dbo].[VrstaPublikacije] ([VrstaPublikacijeId], [Naziv]) VALUES (2, N'Duhovnost')
INSERT [dbo].[VrstaPublikacije] ([VrstaPublikacijeId], [Naziv]) VALUES (3, N'Knjizevnost')
SET IDENTITY_INSERT [dbo].[VrstaPublikacije] OFF
SET IDENTITY_INSERT [dbo].[Zaduzenje] ON 

INSERT [dbo].[Zaduzenje] ([ZaduzenjeId], [PublikacijaId], [KorisnikId], [DatumZaduzenja], [DatumRazduzenja], [BibliotekarIdZaduzio], [BibiliotekarIdRazduzio], [BrojKnjiga]) VALUES (10, 1, 1, CAST(N'2017-02-26T00:00:00.000' AS DateTime), CAST(N'2017-02-28T00:00:00.000' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Zaduzenje] ([ZaduzenjeId], [PublikacijaId], [KorisnikId], [DatumZaduzenja], [DatumRazduzenja], [BibliotekarIdZaduzio], [BibiliotekarIdRazduzio], [BrojKnjiga]) VALUES (11, 2, 24, CAST(N'2017-02-26T00:00:00.000' AS DateTime), CAST(N'2017-03-28T00:00:00.000' AS DateTime), NULL, NULL, 2)
SET IDENTITY_INSERT [dbo].[Zaduzenje] OFF
ALTER TABLE [dbo].[AutorPublikacije]  WITH CHECK ADD  CONSTRAINT [FK_AutorPublikacije_Autor] FOREIGN KEY([AutorId])
REFERENCES [dbo].[Autor] ([AutorId])
GO
ALTER TABLE [dbo].[AutorPublikacije] CHECK CONSTRAINT [FK_AutorPublikacije_Autor]
GO
ALTER TABLE [dbo].[AutorPublikacije]  WITH CHECK ADD  CONSTRAINT [FK_AutorPublikacije_Publikacija] FOREIGN KEY([PublikacijaId])
REFERENCES [dbo].[Publikacija] ([PublikacijaId])
GO
ALTER TABLE [dbo].[AutorPublikacije] CHECK CONSTRAINT [FK_AutorPublikacije_Publikacija]
GO
ALTER TABLE [dbo].[Publikacija]  WITH CHECK ADD  CONSTRAINT [FK_Publikacija_VrstaPublikacije] FOREIGN KEY([VrstaPublikacijeId])
REFERENCES [dbo].[VrstaPublikacije] ([VrstaPublikacijeId])
GO
ALTER TABLE [dbo].[Publikacija] CHECK CONSTRAINT [FK_Publikacija_VrstaPublikacije]
GO
ALTER TABLE [dbo].[Zaduzenje]  WITH CHECK ADD  CONSTRAINT [FK_Zaduzenje_Bibliotekar] FOREIGN KEY([BibliotekarIdZaduzio])
REFERENCES [dbo].[Bibliotekar] ([BibliotekarId])
GO
ALTER TABLE [dbo].[Zaduzenje] CHECK CONSTRAINT [FK_Zaduzenje_Bibliotekar]
GO
ALTER TABLE [dbo].[Zaduzenje]  WITH CHECK ADD  CONSTRAINT [FK_Zaduzenje_Bibliotekar1] FOREIGN KEY([BibiliotekarIdRazduzio])
REFERENCES [dbo].[Bibliotekar] ([BibliotekarId])
GO
ALTER TABLE [dbo].[Zaduzenje] CHECK CONSTRAINT [FK_Zaduzenje_Bibliotekar1]
GO
ALTER TABLE [dbo].[Zaduzenje]  WITH CHECK ADD  CONSTRAINT [FK_Zaduzenje_Korisnik] FOREIGN KEY([KorisnikId])
REFERENCES [dbo].[Korisnik] ([KorisnikId])
GO
ALTER TABLE [dbo].[Zaduzenje] CHECK CONSTRAINT [FK_Zaduzenje_Korisnik]
GO
ALTER TABLE [dbo].[Zaduzenje]  WITH CHECK ADD  CONSTRAINT [FK_Zaduzenje_Publikacija] FOREIGN KEY([PublikacijaId])
REFERENCES [dbo].[Publikacija] ([PublikacijaId])
GO
ALTER TABLE [dbo].[Zaduzenje] CHECK CONSTRAINT [FK_Zaduzenje_Publikacija]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Korisnik"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Korisnik'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Korisnik'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Publikacija"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "VrstaPublikacije"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 102
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Test'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Test'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Zaduzenje"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 203
               Right = 451
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "Publikacija"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Korisnik"
            Begin Extent = 
               Top = 6
               Left = 489
               Bottom = 136
               Right = 659
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Zaduzenje'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Zaduzenje'
GO
USE [master]
GO
ALTER DATABASE [Biblioteka] SET  READ_WRITE 
GO
