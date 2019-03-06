-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 06 Mar 2019, 08:15:22
-- Sunucu sürümü: 5.7.14
-- PHP Sürümü: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `6mart2019`
--

DELIMITER $$
--
-- Yordamlar
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `prosedur1` ()  SELECT yazarlar.adi,yazarlar.soyadi,dogum_sehir.sehir,kitaplar.ad,kitaplar.tarih FROM kitap_yazar
INNER JOIN kitaplar ON kitap_yazar.kitap_id = kitaplar.kitap_id
INNER JOIN yazarlar ON kitap_yazar.yazar_id = yazarlar.yazar_id
INNER JOIN dogum_sehir ON yazarlar.dogum_yer_id = dogum_sehir.dogum_yer_id
where dogum_sehir.sehir = "izmir"
ORDER By(kitaplar.tarih) DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `yordam11` ()  NO SQL
SELECT yazarlar.adi,yazarlar.soyadi,count(kitaplar.kitap_id) as kitap_sayi FROM kitap_yazar
INNER JOIN kitaplar ON kitap_yazar.kitap_id = kitaplar.kitap_id
INNER JOIN yazarlar ON kitap_yazar.yazar_id = yazarlar.yazar_id
GROUP By (yazarlar.yazar_id)
HAVING kitap_sayi > 3$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `yordam2` ()  SELECT kitaplar.ad,turler.ad,yayinevleri.adi FROM kitaplar
INNER JOIN kitap_tur ON kitaplar.kitap_id = kitap_tur.kitap_id
INNER JOIN yayinevleri ON kitaplar.yayinevi_id = yayinevleri.yayinevi_id
INNER JOIN turler ON turler.tur_id = kitap_tur.tur_id
where  turler.ad like "%bilgisayar%"$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `yordam5` ()  NO SQL
SELECT CONCAT(yazarlar.adi," ",yazarlar.soyadi) as yazar, turler.ad FROM kitaplar

INNER JOIN kitap_tur ON kitaplar.kitap_id = kitap_tur.kitap_id

INNER JOIN kitap_yazar ON kitaplar.kitap_id = kitap_yazar.kitap_id

INNER JOIN turler ON turler.tur_id = kitap_tur.tur_id

INNER JOIN yazarlar ON yazarlar.yazar_id = kitap_yazar.yazar_id

WHERE turler.ad NOT LIKE "%felsefe%"$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `yordam7` ()  NO SQL
SELECT kitaplar.ad,turler.ad,kitaplar.satis_miktari FROM kitap_tur

INNER JOIN kitaplar ON kitap_tur.kitap_id = kitaplar.kitap_id
INNER JOIN turler ON kitap_tur.tur_id = turler.tur_id

WHERE kitaplar.satis_miktari < any (
    SELECT kitaplar.satis_miktari FROM kitap_tur
    INNER JOIN kitaplar ON kitap_tur.kitap_id = kitaplar.kitap_id 
    INNER JOIN turler ON kitap_tur.tur_id = turler.tur_id
	WHERE turler.ad LIKE "%reklamcılık%"
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `yordam8` ()  NO SQL
SELECT kitaplar.ad,turler.ad,kitaplar.satis_miktari FROM kitap_tur

INNER JOIN kitaplar ON kitap_tur.kitap_id = kitaplar.kitap_id
INNER JOIN turler ON kitap_tur.tur_id = turler.tur_id

WHERE kitaplar.satis_miktari < all (
    SELECT kitaplar.satis_miktari FROM kitap_tur
    INNER JOIN kitaplar ON kitap_tur.kitap_id = kitaplar.kitap_id 
    INNER JOIN turler ON kitap_tur.tur_id = turler.tur_id
	WHERE turler.ad LIKE "%reklamcılık%"
)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dogum_sehir`
--

CREATE TABLE `dogum_sehir` (
  `dogum_yer_id` int(11) NOT NULL,
  `sehir` varchar(255) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `dogum_sehir`
--

INSERT INTO `dogum_sehir` (`dogum_yer_id`, `sehir`) VALUES
(1, 'Adana'),
(6, 'Ankara'),
(10, 'Balıkesir'),
(14, 'Bolu'),
(17, 'Çanakkale'),
(20, 'Denizli'),
(35, 'İzmir'),
(38, 'Kayseri'),
(42, 'Konya');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitaplar`
--

CREATE TABLE `kitaplar` (
  `kitap_id` int(11) NOT NULL,
  `ad` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `tarih` year(4) NOT NULL,
  `yayinevi_id` int(11) NOT NULL,
  `satis_miktari` int(11) NOT NULL,
  `fiyati` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kitaplar`
--

INSERT INTO `kitaplar` (`kitap_id`, `ad`, `tarih`, `yayinevi_id`, `satis_miktari`, `fiyati`) VALUES
(1, 'Ekonomi', 2010, 1, 100, 50),
(2, 'Veritabanı', 2012, 2, 2000, 45),
(3, 'Borsa', 2017, 3, 1000, 100),
(4, 'Borsa\'da Başarı', 2012, 4, 1500, 20),
(5, 'Şiirler', 2008, 6, 100, 10),
(6, 'Efsane Müzikler', 1999, 9, 15000, 10),
(7, 'Felsefeli Günler', 2000, 7, 1000, 25),
(8, 'Bilim Felsefesi', 2005, 7, 400, 100),
(9, 'Bilgisayar', 1980, 6, 10000, 5),
(10, 'Kariyer', 2010, 5, 5000, 50),
(11, 'İş Dünyası', 2015, 8, 300, 30),
(12, 'Reklamcılık', 2008, 8, 500, 60),
(13, 'Sistem Analizi', 2017, 5, 100, 1000),
(14, 'Yapay Zeka', 2013, 5, 600, 50),
(15, 'Tarihe Bakış', 2009, 5, 300, 40),
(16, 'Bilgisayar Tarihçesi', 1985, 6, 10000, 10);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitap_tur`
--

CREATE TABLE `kitap_tur` (
  `kitap_id` int(11) NOT NULL,
  `tur_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kitap_tur`
--

INSERT INTO `kitap_tur` (`kitap_id`, `tur_id`) VALUES
(1, 4),
(2, 9),
(3, 1),
(4, 1),
(5, 5),
(6, 8),
(7, 7),
(8, 7),
(9, 9),
(10, 3),
(10, 1),
(10, 4),
(10, 3),
(11, 1),
(11, 2),
(11, 3),
(11, 4),
(12, 2),
(12, 3),
(13, 3),
(13, 9),
(14, 9),
(16, 9),
(14, 3),
(16, 4);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitap_yazar`
--

CREATE TABLE `kitap_yazar` (
  `yazar_id` int(11) NOT NULL,
  `kitap_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kitap_yazar`
--

INSERT INTO `kitap_yazar` (`yazar_id`, `kitap_id`) VALUES
(1, 1),
(2, 1),
(2, 5),
(3, 6),
(3, 9),
(4, 12),
(5, 13),
(6, 9),
(7, 16),
(8, 15),
(9, 8),
(10, 15),
(11, 15),
(12, 2),
(13, 14),
(14, 5),
(16, 4),
(16, 10),
(17, 15),
(1, 9),
(7, 5),
(14, 4),
(16, 1),
(3, 1),
(13, 2),
(14, 6),
(16, 16),
(17, 15),
(3, 11),
(10, 16),
(11, 8);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `turler`
--

CREATE TABLE `turler` (
  `tur_id` int(11) NOT NULL,
  `ad` varchar(255) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `turler`
--

INSERT INTO `turler` (`tur_id`, `ad`) VALUES
(1, 'Borsa-Finans-Analiz'),
(2, 'Reklamcılık'),
(3, 'İş Dünyası - Kariyer'),
(4, 'Dünya Ekonomisi'),
(5, 'Şiir'),
(6, 'Tarih'),
(7, 'Felsefe'),
(8, 'Müzik'),
(9, 'Bilgisayar Kitapları ');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yayinevleri`
--

CREATE TABLE `yayinevleri` (
  `yayinevi_id` int(11) NOT NULL,
  `adi` varchar(255) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `yayinevleri`
--

INSERT INTO `yayinevleri` (`yayinevi_id`, `adi`) VALUES
(1, 'Abaküs Yayınevi'),
(2, 'Alfa Yayıncılık '),
(3, 'İnkilap Yayınevi'),
(4, 'Alter Yayınevi'),
(5, 'Belge Yayınları'),
(6, 'Beta Yayınları'),
(7, 'Bilgi Yayınevi'),
(8, 'Donanım Yayınevi'),
(9, 'Yazılım Yayınevi');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yazarlar`
--

CREATE TABLE `yazarlar` (
  `yazar_id` int(11) NOT NULL,
  `adi` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `soyadi` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `dogum_yer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `yazarlar`
--

INSERT INTO `yazarlar` (`yazar_id`, `adi`, `soyadi`, `dogum_yer_id`) VALUES
(1, 'Mehmet', 'Yılmaz', 1),
(2, 'Kenan', 'Öztürk', 6),
(3, 'Orhan', 'Duru', 10),
(4, 'Ayşe', 'Gül', 20),
(5, 'Buse', 'Nur', 17),
(6, 'Mehmet', 'Erdem', 35),
(7, 'Funda', 'Yıkılmaz', 38),
(8, 'Özlem', 'Çetin', 42),
(9, 'Ece', 'Demir', 20),
(10, 'Aygül', 'Birgül', 35),
(11, 'Canan', 'Can', 6),
(12, 'Öztürk', 'Yıkılmaz', 10),
(13, 'Fatma', 'Yazar', 38),
(14, 'Simge', 'Okur', 14),
(15, 'Derya', 'Deniz', 38),
(16, 'Okan', 'Okur', 35),
(17, 'Ahmet', 'Terim', 6);

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `dogum_sehir`
--
ALTER TABLE `dogum_sehir`
  ADD PRIMARY KEY (`dogum_yer_id`);

--
-- Tablo için indeksler `kitaplar`
--
ALTER TABLE `kitaplar`
  ADD PRIMARY KEY (`kitap_id`),
  ADD KEY `yayinevi_id` (`yayinevi_id`);

--
-- Tablo için indeksler `kitap_tur`
--
ALTER TABLE `kitap_tur`
  ADD KEY `kitap_id` (`kitap_id`),
  ADD KEY `tur_id` (`tur_id`);

--
-- Tablo için indeksler `kitap_yazar`
--
ALTER TABLE `kitap_yazar`
  ADD KEY `yazar_id` (`yazar_id`),
  ADD KEY `kitap_id` (`kitap_id`);

--
-- Tablo için indeksler `turler`
--
ALTER TABLE `turler`
  ADD PRIMARY KEY (`tur_id`);

--
-- Tablo için indeksler `yayinevleri`
--
ALTER TABLE `yayinevleri`
  ADD PRIMARY KEY (`yayinevi_id`);

--
-- Tablo için indeksler `yazarlar`
--
ALTER TABLE `yazarlar`
  ADD PRIMARY KEY (`yazar_id`),
  ADD KEY `dogum_yer_id` (`dogum_yer_id`);

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `kitaplar`
--
ALTER TABLE `kitaplar`
  ADD CONSTRAINT `yayinevi` FOREIGN KEY (`yayinevi_id`) REFERENCES `yayinevleri` (`yayinevi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `kitap_tur`
--
ALTER TABLE `kitap_tur`
  ADD CONSTRAINT `kitaplar` FOREIGN KEY (`kitap_id`) REFERENCES `kitaplar` (`kitap_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `turler` FOREIGN KEY (`tur_id`) REFERENCES `turler` (`tur_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `kitap_yazar`
--
ALTER TABLE `kitap_yazar`
  ADD CONSTRAINT `kitap2` FOREIGN KEY (`kitap_id`) REFERENCES `kitaplar` (`kitap_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `yazar2` FOREIGN KEY (`yazar_id`) REFERENCES `yazarlar` (`yazar_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `yazarlar`
--
ALTER TABLE `yazarlar`
  ADD CONSTRAINT `dogum_yeri` FOREIGN KEY (`dogum_yer_id`) REFERENCES `dogum_sehir` (`dogum_yer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
