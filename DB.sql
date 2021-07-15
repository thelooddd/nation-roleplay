SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

CREATE TABLE IF NOT EXISTS `accounts` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(24) NOT NULL,
  `Password` varchar(64) NOT NULL,
  `Email` varchar(64) DEFAULT NULL,
  `Level` int(5) NOT NULL,
  `Exp` int(11) NOT NULL,
  `Money` int(11) NOT NULL,
  `Admin` int(2) NOT NULL,
  `Donate` int(11) NOT NULL,
  `Skin` int(3) NOT NULL,
  `FSkin` int(3) NOT NULL,
  `BMoney` int(11) NOT NULL,
  `Health` float NOT NULL,
  `Armour` float NOT NULL,
  `House` int(11) NOT NULL,
  `Car` int(11) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `Interior` int(4) NOT NULL,
  `VW` int(4) NOT NULL,
  `Frac` int(2) NOT NULL,
  `Business` int(3) NOT NULL,
  `Bank` int(2) NOT NULL,
  `Drugs` int(11) NOT NULL,
  `Golod` int(3) NOT NULL,
  `Bann` int(1) NOT NULL,
  `BanTime` int(40) NOT NULL,
  `Sex` int(1) NOT NULL,
  `JailTime` int(11) NOT NULL,
  `Warn` int(1) NOT NULL,
  `Muted` int(4) NOT NULL,
  `DeMorgan` int(6) NOT NULL,
  `Status` int(1) NOT NULL,
  `AdminP` text NOT NULL,
  `FermaLS` int(1) NOT NULL,
  `FermaSF` int(1) NOT NULL,
  `Support` int(1) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Donate` (`Donate`)
) ENGINE=InnoDB  DEFAULT CHARSET=cp1251 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `bans` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `AdmName` varchar(24) CHARACTER SET utf8 NOT NULL,
  `Name` varchar(24) CHARACTER SET utf8 NOT NULL,
  `time` int(40) NOT NULL,
  `Reason` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=cp1251 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `business` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `Boss` int(11) DEFAULT NULL,
  `Ammount` int(11) NOT NULL,
  `Status` int(1) NOT NULL,
  `TDX` float NOT NULL,
  `TDY` float NOT NULL,
  `TDZ` float NOT NULL,
  `SpawnX` float NOT NULL,
  `SpawnY` float NOT NULL,
  `SpawnZ` float NOT NULL,
  `Interior` int(3) NOT NULL,
  `Angel` float NOT NULL,
  `EnterX` float NOT NULL,
  `EnterY` float NOT NULL,
  `EnterZ` float NOT NULL,
  `EnterA` float NOT NULL,
  `sEnterX` float NOT NULL,
  `sEnterY` float NOT NULL,
  `sEnterZ` float NOT NULL,
  `Sum` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  `Type` int(2) NOT NULL,
  `AngelE` float NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=cp1251 AUTO_INCREMENT=28 ;

INSERT INTO `business` (`ID`, `Name`, `Boss`, `Ammount`, `Status`, `TDX`, `TDY`, `TDZ`, `SpawnX`, `SpawnY`, `SpawnZ`, `Interior`, `Angel`, `EnterX`, `EnterY`, `EnterZ`, `EnterA`, `sEnterX`, `sEnterY`, `sEnterZ`, `Sum`, `Price`, `Type`, `AngelE`) VALUES
(20, '', 0, 0, 2, 1658.5, -1955.1, 13.5469, 362.95, -75.25, 1001.51, 10, -92.2892, 1668.05, -1954.76, 13.5469, 89.5908, 365.85, -73.44, 1001.51, 90000, 0, 5, 0),
(21, '', 0, 0, 2, 1708.62, -1950.01, 14.1172, 362.95, -75.25, 1001.51, 10, 91.4709, 1701.46, -1950.19, 14.1172, 271.471, 365.85, -73.44, 1001.51, 90000, 0, 5, 300),
(22, '', 0, 0, 2, 1699.07, -1937.77, 13.5626, 372.21, -133.52, 1001.49, 5, 173.397, 1698.9, -1943.45, 13.5453, 353.397, 371.72, -130.47, 1001.49, 90000, 0, 4, 0),
(23, '', 0, 0, 2, 1723.26, -1914.72, 13.5645, 362.95, -75.25, 1001.51, 10, 164.67, 1721.13, -1922.5, 13.5649, 349.37, 365.85, -73.44, 1001.51, 90000, 0, 5, 300),
(24, '', 0, 0, 2, 1723.86, -1895.84, 13.5644, 362.95, -75.25, 1001.51, 10, 177.83, 1723.64, -1901.64, 13.5645, 357.83, 365.85, -73.44, 1001.51, 90000, 0, 5, 300),
(25, '', 0, 0, 2, 1713.65, -1896.39, 13.5669, 364.73, -11.66, 1001.85, 9, -130.951, 1717.87, -1900.05, 13.5659, 49.0488, 365.82, -9.64, 1001.85, 90000, 0, 3, 341),
(26, '', 0, 0, 2, 1709.15, -1913.51, 13.568, 362.95, -75.25, 1001.51, 10, -177.493, 1709.43, -1919.8, 13.5679, 2.50663, 365.85, -73.44, 1001.51, 90000, 0, 5, 300),
(27, '', 0, 0, 2, 1716.42, -1937.53, 13.583, 362.95, -75.25, 1001.51, 10, 11.9071, 1714.96, -1930.61, 13.5673, 191.907, 365.85, -73.44, 1001.51, 90000, 0, 5, 300);

CREATE TABLE IF NOT EXISTS `ferma` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `Boss` int(11) DEFAULT NULL,
  `Ammount` int(11) NOT NULL,
  `Ur` int(11) NOT NULL,
  `UrP` int(11) NOT NULL,
  `Status` int(1) NOT NULL,
  `TDX` float NOT NULL,
  `TDY` float NOT NULL,
  `TDZ` float NOT NULL,
  `SpawnX` float NOT NULL,
  `SpawnY` float NOT NULL,
  `SpawnZ` float NOT NULL,
  `Interior` int(3) NOT NULL,
  `Angel` float NOT NULL,
  `EnterX` float NOT NULL,
  `EnterY` float NOT NULL,
  `EnterZ` float NOT NULL,
  `EnterA` float NOT NULL,
  `sEnterX` float NOT NULL,
  `sEnterY` float NOT NULL,
  `sEnterZ` float NOT NULL,
  `Sum` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  `Fermer1` int(11) NOT NULL,
  `Fermer2` int(11) NOT NULL,
  `Fermer3` int(11) NOT NULL,
  `Fermer4` int(11) NOT NULL,
  `Fermer5` int(11) NOT NULL,
  `Bank` int(11) NOT NULL,
  `Zerno` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=cp1251 AUTO_INCREMENT=3 ;

INSERT INTO `ferma` (`ID`, `Name`, `Boss`, `Ammount`, `Ur`, `UrP`, `Status`, `TDX`, `TDY`, `TDZ`, `SpawnX`, `SpawnY`, `SpawnZ`, `Interior`, `Angel`, `EnterX`, `EnterY`, `EnterZ`, `EnterA`, `sEnterX`, `sEnterY`, `sEnterZ`, `Sum`, `Price`, `Fermer1`, `Fermer2`, `Fermer3`, `Fermer4`, `Fermer5`, `Bank`, `Zerno`) VALUES
(1, 'Ферма Лос Сантоса', 0, 0, 0, 0, 2, -94.14, 63.02, 4.04, 1714.3, -2440.09, 8.3, 0, 90, -99.7626, 51.7577, 3.4504, 90, 1716.87, -2439.98, 8.5645, 500000, 6, 0, 0, 0, 0, 0, 0, 0),
(2, 'Ферма Сан Фиерро', 0, 0, 0, 0, 2, -1061.16, -1205.73, 129.5, 1714.3, -2440.09, 8.3, 0, 270, -1058.77, -1195.67, 128.735, 270, 1716.87, -2439.98, 8.5645, 500000, 6, 0, 0, 0, 0, 0, 0, 0);

CREATE TABLE IF NOT EXISTS `frac` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `Drugs` int(11) NOT NULL,
  `Guns` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `garage` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `House` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `A` float NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

INSERT INTO `garage` (`ID`, `House`, `X`, `Y`, `Z`, `A`) VALUES
(1, 114, 1714.24, -1863.53, 13.575, 268.819),
(2, 115, 1723.73, -1863.02, 13.5756, 273.206),
(3, 120, 2052.22, -1694.72, 13.5547, 269.554),
(4, 119, 2016.33, -1707.57, 13.5469, 87.216),
(5, 118, 2014.63, -1738.14, 13.5547, 90.6628);

CREATE TABLE IF NOT EXISTS `house` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Price` int(11) NOT NULL,
  `Boss` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `InteriorB` int(11) NOT NULL,
  `Bank` int(11) NOT NULL,
  `Heal` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `SHX` float NOT NULL,
  `SHY` float NOT NULL,
  `SHZ` float NOT NULL,
  `SHXB` float NOT NULL,
  `SHYB` float NOT NULL,
  `SHZB` float NOT NULL,
  `Status` int(11) NOT NULL,
  `Angle` float NOT NULL,
  `Angl` float NOT NULL,
  `AngleB` float NOT NULL,
  `Klad` int(11) NOT NULL,
  `Signal` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=121 ;

INSERT INTO `house` (`ID`, `Price`, `Boss`, `Interior`, `InteriorB`, `Bank`, `Heal`, `X`, `Y`, `Z`, `SHX`, `SHY`, `SHZ`, `SHXB`, `SHYB`, `SHZB`, `Status`, `Angle`, `Angl`, `AngleB`, `Klad`, `Signal`) VALUES
(114, 500000, 0, 6, 6, 0, 0, 1707.26, -1869.11, 13.5684, 234.19, 1063.73, 1084.21, 234.19, 1063.73, 1084.21, 2, 0, 0, 0, 0, 0),
(115, 85000, 0, 1, 1, 0, 0, 1720.18, -1863.44, 13.5751, 2218.4, -1076.18, 1050.48, 2218.4, -1076.18, 1050.48, 2, 90, 251.296, 90, 0, 0),
(116, 60000, 0, 10, 10, 0, 0, 1708.61, -1902.8, 13.5681, 2259.38, -1135.77, 1050.64, 2259.38, -1135.77, 1050.64, 2, 270, 356.867, 270, 0, 0),
(117, 100000, 0, 15, 15, 0, 0, 1705.66, -1909.08, 13.5688, 295.04, 1472.26, 1080.26, 295.04, 1472.26, 1080.26, 2, 0, 192.679, 0, 0, 0),
(118, 75000, 0, 8, 8, 0, 0, 2014.92, -1732.62, 14.2344, -42.59, 1405.47, 1084.43, -42.59, 1405.47, 1084.43, 2, 0, 267.964, 0, 0, 0),
(119, 85000, 0, 1, 1, 0, 0, 2017.96, -1703.33, 14.2344, 2218.4, -1076.18, 1050.48, 2218.4, -1076.18, 1050.48, 2, 90, 272.978, 90, 0, 0),
(120, 300000, 0, 5, 5, 0, 0, 2065.23, -1703.6, 14.1484, 140.17, 1366.07, 1083.65, 140.17, 1366.07, 1083.65, 2, 0, 90.0126, 0, 0, 0);

CREATE TABLE IF NOT EXISTS `kicks` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `AdmName` varchar(24) NOT NULL,
  `Name` varchar(24) NOT NULL,
  `reason` varchar(64) NOT NULL,
  `time` varchar(40) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=cp1251 AUTO_INCREMENT=9 ;

CREATE TABLE IF NOT EXISTS `logs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `Do` text NOT NULL,
  `time` varchar(30) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `moneys` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(24) NOT NULL,
  `GiveName` varchar(24) NOT NULL,
  `time` int(40) NOT NULL,
  `sum` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `warns` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `AdmName` varchar(24) NOT NULL,
  `Name` varchar(24) NOT NULL,
  `time` int(40) NOT NULL,
  `reason` varchar(64) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 AUTO_INCREMENT=1 ;
