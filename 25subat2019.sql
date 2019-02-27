-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 27 Şub 2019, 08:31:53
-- Sunucu sürümü: 5.7.14
-- PHP Sürümü: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `25subat2019`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bolum`
--

CREATE TABLE `bolum` (
  `bolum_id` varchar(10) COLLATE utf8_turkish_ci NOT NULL,
  `bolum_ad` varchar(50) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `bolum`
--

INSERT INTO `bolum` (`bolum_id`, `bolum_ad`) VALUES
('1', 'ybs'),
('2', 'iktisat'),
('3', 'isletme'),
('4', 'maliye');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ders`
--

CREATE TABLE `ders` (
  `ders_id` varchar(10) COLLATE utf8_turkish_ci NOT NULL,
  `ders_ad` varchar(100) COLLATE utf8_turkish_ci NOT NULL,
  `kredi_teorik` int(11) NOT NULL,
  `kredi_uygulama` int(11) NOT NULL,
  `hoca_id` int(11) NOT NULL,
  `bolum_id` varchar(10) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `ders`
--

INSERT INTO `ders` (`ders_id`, `ders_ad`, `kredi_teorik`, `kredi_uygulama`, `hoca_id`, `bolum_id`) VALUES
('YBS1002', 'ybs', 3, 0, 1, '1'),
('YBS2006', 'vtys', 2, 2, 2, '1');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `hoca`
--

CREATE TABLE `hoca` (
  `hoca_id` int(11) NOT NULL,
  `hoca_ad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `hoca_soyad` varchar(50) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `hoca`
--

INSERT INTO `hoca` (`hoca_id`, `hoca_ad`, `hoca_soyad`) VALUES
(1, 'ahmet', 'yılmaz'),
(2, 'ayse', 'güzel'),
(3, 'deniz', 'gözlük'),
(4, 'mehmet', 'can'),
(5, 'pelin ', 'tok'),
(6, 'cansu', 'yel');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `il`
--

CREATE TABLE `il` (
  `plaka_no` varchar(2) COLLATE utf8_turkish_ci NOT NULL,
  `il_ad` varchar(50) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `il`
--

INSERT INTO `il` (`plaka_no`, `il_ad`) VALUES
('1', 'Adana'),
('16', 'bursa'),
('34', 'istanbul'),
('35', 'izmir'),
('54', 'sakarya'),
('6', 'ankara'),
('7', 'antalya');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `notlar`
--

CREATE TABLE `notlar` (
  `ogrenci_no` varchar(11) COLLATE utf8_turkish_ci NOT NULL,
  `ders_id` varchar(10) COLLATE utf8_turkish_ci NOT NULL,
  `vize` int(11) NOT NULL,
  `final` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ogrenci`
--

CREATE TABLE `ogrenci` (
  `ogrenci_no` varchar(11) COLLATE utf8_turkish_ci NOT NULL,
  `ogrenci_ad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `ogrenci_soyad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `bolum_id` varchar(10) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `ogrenci`
--

INSERT INTO `ogrenci` (`ogrenci_no`, `ogrenci_ad`, `ogrenci_soyad`, `bolum_id`) VALUES
('2015300401', 'canan', 'biricik', '2'),
('2015300402', 'Gülsüm', 'Gül', '2');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ogrenci_kimlik`
--

CREATE TABLE `ogrenci_kimlik` (
  `ogrenci_no` varchar(11) COLLATE utf8_turkish_ci NOT NULL,
  `tc_kimlik_no` varchar(11) COLLATE utf8_turkish_ci NOT NULL,
  `dogum_yeri` varchar(2) COLLATE utf8_turkish_ci NOT NULL,
  `dogum_tarihi` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `ogrenci_kimlik`
--

INSERT INTO `ogrenci_kimlik` (`ogrenci_no`, `tc_kimlik_no`, `dogum_yeri`, `dogum_tarihi`) VALUES
('2015300401', '1234567890', '1', '1999-01-09'),
('2015300402', '1234567899', '6', '2000-07-26');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `bolum`
--
ALTER TABLE `bolum`
  ADD PRIMARY KEY (`bolum_id`);

--
-- Tablo için indeksler `ders`
--
ALTER TABLE `ders`
  ADD PRIMARY KEY (`ders_id`),
  ADD KEY `hoca_id` (`hoca_id`),
  ADD KEY `bolum_id` (`bolum_id`);

--
-- Tablo için indeksler `hoca`
--
ALTER TABLE `hoca`
  ADD PRIMARY KEY (`hoca_id`);

--
-- Tablo için indeksler `il`
--
ALTER TABLE `il`
  ADD PRIMARY KEY (`plaka_no`);

--
-- Tablo için indeksler `notlar`
--
ALTER TABLE `notlar`
  ADD PRIMARY KEY (`ogrenci_no`,`ders_id`),
  ADD UNIQUE KEY `ogrenci_no` (`ogrenci_no`),
  ADD UNIQUE KEY `ders_id` (`ders_id`);

--
-- Tablo için indeksler `ogrenci`
--
ALTER TABLE `ogrenci`
  ADD PRIMARY KEY (`ogrenci_no`),
  ADD KEY `bolum_id` (`bolum_id`);

--
-- Tablo için indeksler `ogrenci_kimlik`
--
ALTER TABLE `ogrenci_kimlik`
  ADD PRIMARY KEY (`tc_kimlik_no`),
  ADD UNIQUE KEY `ogrenci_no` (`ogrenci_no`),
  ADD KEY `dogum_yeri` (`dogum_yeri`);

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `ders`
--
ALTER TABLE `ders`
  ADD CONSTRAINT `bolum` FOREIGN KEY (`bolum_id`) REFERENCES `bolum` (`bolum_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `hoca` FOREIGN KEY (`hoca_id`) REFERENCES `hoca` (`hoca_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `notlar`
--
ALTER TABLE `notlar`
  ADD CONSTRAINT `ders` FOREIGN KEY (`ders_id`) REFERENCES `ders` (`ders_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ogrenci` FOREIGN KEY (`ogrenci_no`) REFERENCES `ogrenci` (`ogrenci_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `ogrenci`
--
ALTER TABLE `ogrenci`
  ADD CONSTRAINT `bolumdid` FOREIGN KEY (`bolum_id`) REFERENCES `bolum` (`bolum_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `ogrenci_kimlik`
--
ALTER TABLE `ogrenci_kimlik`
  ADD CONSTRAINT `dy` FOREIGN KEY (`dogum_yeri`) REFERENCES `il` (`plaka_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ogrenci_ok` FOREIGN KEY (`ogrenci_no`) REFERENCES `ogrenci` (`ogrenci_no`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
