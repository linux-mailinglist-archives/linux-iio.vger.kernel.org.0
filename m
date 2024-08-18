Return-Path: <linux-iio+bounces-8574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E91A955E77
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 20:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3682E1C209FC
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 18:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D9A149C51;
	Sun, 18 Aug 2024 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAD6K0sb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73E75FB9C
	for <linux-iio@vger.kernel.org>; Sun, 18 Aug 2024 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724004593; cv=none; b=SbnrIPZYrWUt5uePWSwaN/yWN9DSmTMeGJI82mgrX5rBhLKLDNCVYgUuJmL+51/uGLgw7fDnq+IMplYdZuWWsQdYLyd9OXgxpK3OGQZtyOmIisybPDPuTO3C3IOBVWcpjKzcZ/RwCDhrBFmZq7ae6cb/H8UuOHVvGDRmDH1fyN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724004593; c=relaxed/simple;
	bh=9dCvNY2Y1dTvw7DJg9S2dsSUnk3MJuIM+rTVaodtuOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=caa4+px47SnIqEVTmkleldaNQhSHGSaQWJvJ+PPZrHLGqiWIcHDaILyWmAgGf3FrPVuFnERfmacPhyc4dpdkTkIksRIWC3lyib5trKTXwZTn2SfrbLjJs3nNhu2qjzqZ/i3FX+s07qZEQnc1U78HeEOXba0lt8GKgpvaNBwmIRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAD6K0sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7228C32786;
	Sun, 18 Aug 2024 18:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724004592;
	bh=9dCvNY2Y1dTvw7DJg9S2dsSUnk3MJuIM+rTVaodtuOo=;
	h=From:To:Cc:Subject:Date:From;
	b=KAD6K0sbZ8eobi0xfr9Gm9S1hAHgIp2Cx5g5qgP6xyrbXfCSKmfw/NZhomfuaFlRg
	 yzVr1MUhOsrEe9vUUe+ftsNS4gESJQ/KP2jNlYXzFwopO/X08p+drl9JQ/9g/zi2Nz
	 +HOo+tUNuj2uFzt58VFc/CpKaRBI2YnW48u9toyGSLTS0qp1Qr/9oWFC22Gu1O3sLq
	 5TDk5JWhKbKY8/fmzp4Ip/z7B5rPenqTA31iyb0Zbq/4RxG3aUgnySOdGgId4yBjS8
	 SKGNH9uaQWHdQiZYWUhC7P0xMcekPXiLXq9jlK353EBQ4pnhZvaReF40yAdZZMV5yH
	 HjxyrQ9mXr3XA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio: adc: standardize on formatting for id match tables
Date: Sun, 18 Aug 2024 19:09:12 +0100
Message-ID: <20240818180912.719399-1-jic23@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is a frequent minor comment in reviews, so start cleaning up
existing drivers in the hope we get fewer cases of cut and paste.

There are not kernel wide rules for these, but for IIO the style
that I prefer (and hence most common) is:

- Space after { and before }
- No comma after terminator { }

This may cause merge conflicts but they should be trivial to resolve
hence I have not broken this into per driver patches.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

This is obviously trivial, but it's amazing how often I type
the same advice.

Doing only for ADCs today because I do want to get some eyes
on this and that is going to be easier for a relatively small patch.

Note I haven't fixed other similar issues outside of the ID
tables.

 drivers/iio/adc/ad7091r5.c          |  6 +--
 drivers/iio/adc/ad7124.c            |  4 +-
 drivers/iio/adc/ad7192.c            |  6 +--
 drivers/iio/adc/ad7266.c            |  4 +-
 drivers/iio/adc/ad7280a.c           |  4 +-
 drivers/iio/adc/ad7291.c            |  4 +-
 drivers/iio/adc/ad7292.c            |  4 +-
 drivers/iio/adc/ad7298.c            |  4 +-
 drivers/iio/adc/ad7476.c            | 58 ++++++++++++++---------------
 drivers/iio/adc/ad7606_par.c        |  2 +-
 drivers/iio/adc/ad7606_spi.c        |  4 +-
 drivers/iio/adc/ad7766.c            | 14 +++----
 drivers/iio/adc/ad7768-1.c          |  2 +-
 drivers/iio/adc/ad7780.c            | 10 ++---
 drivers/iio/adc/ad7793.c            | 20 +++++-----
 drivers/iio/adc/ad7887.c            |  4 +-
 drivers/iio/adc/ad7923.c            | 18 ++++-----
 drivers/iio/adc/ad9467.c            |  4 +-
 drivers/iio/adc/aspeed_adc.c        |  2 +-
 drivers/iio/adc/at91_adc.c          |  2 +-
 drivers/iio/adc/axp288_adc.c        |  2 +-
 drivers/iio/adc/bcm_iproc_adc.c     |  2 +-
 drivers/iio/adc/berlin2-adc.c       |  2 +-
 drivers/iio/adc/ep93xx_adc.c        |  2 +-
 drivers/iio/adc/exynos_adc.c        |  2 +-
 drivers/iio/adc/hi8435.c            |  2 +-
 drivers/iio/adc/hx711.c             |  2 +-
 drivers/iio/adc/ina2xx-adc.c        | 14 +++----
 drivers/iio/adc/ingenic-adc.c       |  2 +-
 drivers/iio/adc/lpc32xx_adc.c       |  2 +-
 drivers/iio/adc/ltc2496.c           |  2 +-
 drivers/iio/adc/ltc2497.c           |  2 +-
 drivers/iio/adc/max1027.c           | 16 ++++----
 drivers/iio/adc/max11100.c          |  4 +-
 drivers/iio/adc/max1118.c           |  4 +-
 drivers/iio/adc/max1241.c           |  4 +-
 drivers/iio/adc/max34408.c          |  4 +-
 drivers/iio/adc/max9611.c           |  6 +--
 drivers/iio/adc/mp2629_adc.c        |  4 +-
 drivers/iio/adc/mt6360-adc.c        |  2 +-
 drivers/iio/adc/nau7802.c           |  2 +-
 drivers/iio/adc/pac1921.c           |  4 +-
 drivers/iio/adc/pac1934.c           |  6 +--
 drivers/iio/adc/qcom-pm8xxx-xoadc.c |  2 +-
 drivers/iio/adc/qcom-spmi-rradc.c   |  2 +-
 drivers/iio/adc/rockchip_saradc.c   |  2 +-
 drivers/iio/adc/rtq6056.c           |  2 +-
 drivers/iio/adc/stm32-adc.c         |  2 +-
 drivers/iio/adc/stm32-dfsdm-adc.c   |  2 +-
 drivers/iio/adc/stm32-dfsdm-core.c  |  2 +-
 drivers/iio/adc/stmpe-adc.c         |  2 +-
 drivers/iio/adc/ti-adc0832.c        |  4 +-
 drivers/iio/adc/ti-adc084s021.c     |  4 +-
 drivers/iio/adc/ti-adc12138.c       |  4 +-
 drivers/iio/adc/ti-adc161s626.c     |  8 ++--
 drivers/iio/adc/ti-ads1015.c        |  4 +-
 drivers/iio/adc/ti-ads124s08.c      |  2 +-
 drivers/iio/adc/ti-ads131e08.c      |  4 +-
 drivers/iio/adc/ti-ads7924.c        |  4 +-
 drivers/iio/adc/ti-ads7950.c        |  2 +-
 drivers/iio/adc/ti-ads8344.c        |  2 +-
 drivers/iio/adc/ti-ads8688.c        |  6 +--
 drivers/iio/adc/ti-lmp92064.c       |  2 +-
 drivers/iio/adc/ti-tlc4541.c        |  8 ++--
 64 files changed, 169 insertions(+), 169 deletions(-)

diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index a75837334157..1b59708abf30 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -112,13 +112,13 @@ static int ad7091r5_i2c_probe(struct i2c_client *i2c)
 
 static const struct of_device_id ad7091r5_dt_ids[] = {
 	{ .compatible = "adi,ad7091r5", .data = &ad7091r5_init_info },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7091r5_dt_ids);
 
 static const struct i2c_device_id ad7091r5_i2c_ids[] = {
-	{"ad7091r5", (kernel_ulong_t)&ad7091r5_init_info },
-	{}
+	{ "ad7091r5", (kernel_ulong_t)&ad7091r5_init_info },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad7091r5_i2c_ids);
 
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 37aa3bdcdf4f..c5ace69bfa43 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -1008,14 +1008,14 @@ static const struct of_device_id ad7124_of_match[] = {
 		.data = &ad7124_chip_info_tbl[ID_AD7124_4], },
 	{ .compatible = "adi,ad7124-8",
 		.data = &ad7124_chip_info_tbl[ID_AD7124_8], },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7124_of_match);
 
 static const struct spi_device_id ad71124_ids[] = {
 	{ "ad7124-4", (kernel_ulong_t)&ad7124_chip_info_tbl[ID_AD7124_4] },
 	{ "ad7124-8", (kernel_ulong_t)&ad7124_chip_info_tbl[ID_AD7124_8] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad71124_ids);
 
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 10ce66b999c6..7042ddfdfc03 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -286,7 +286,7 @@ static const struct iio_chan_spec_ext_info ad7192_calibsys_ext_info[] = {
 		 &ad7192_syscalib_mode_enum),
 	IIO_ENUM_AVAILABLE("sys_calibration_mode", IIO_SHARED_BY_TYPE,
 			   &ad7192_syscalib_mode_enum),
-	{}
+	{ }
 };
 
 static struct ad7192_state *ad_sigma_delta_to_ad7192(struct ad_sigma_delta *sd)
@@ -1431,7 +1431,7 @@ static const struct of_device_id ad7192_of_match[] = {
 	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
 	{ .compatible = "adi,ad7194", .data = &ad7192_chip_info_tbl[ID_AD7194] },
 	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7192_of_match);
 
@@ -1441,7 +1441,7 @@ static const struct spi_device_id ad7192_ids[] = {
 	{ "ad7193", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7193] },
 	{ "ad7194", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7194] },
 	{ "ad7195", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7195] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7192_ids);
 
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 88f39533f249..7949b076fb87 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -457,8 +457,8 @@ static int ad7266_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7266_id[] = {
-	{"ad7265", 0},
-	{"ad7266", 0},
+	{ "ad7265", 0 },
+	{ "ad7266", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7266_id);
diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index 7bfa090da4df..35aa39fe4bde 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -1090,8 +1090,8 @@ static int ad7280_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7280_id[] = {
-	{"ad7280a", 0},
-	{}
+	{ "ad7280a", 0 },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7280_id);
 
diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
index b59b2a51623c..4c7f887adbbf 100644
--- a/drivers/iio/adc/ad7291.c
+++ b/drivers/iio/adc/ad7291.c
@@ -537,14 +537,14 @@ static int ad7291_probe(struct i2c_client *client)
 
 static const struct i2c_device_id ad7291_id[] = {
 	{ "ad7291" },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, ad7291_id);
 
 static const struct of_device_id ad7291_of_match[] = {
 	{ .compatible = "adi,ad7291" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7291_of_match);
 
diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
index ede80f380911..a398973f313d 100644
--- a/drivers/iio/adc/ad7292.c
+++ b/drivers/iio/adc/ad7292.c
@@ -301,13 +301,13 @@ static int ad7292_probe(struct spi_device *spi)
 
 static const struct spi_device_id ad7292_id_table[] = {
 	{ "ad7292", 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7292_id_table);
 
 static const struct of_device_id ad7292_of_match[] = {
 	{ .compatible = "adi,ad7292" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7292_of_match);
 
diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 0128436367db..b35bd4d9ef81 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -355,8 +355,8 @@ static const struct acpi_device_id ad7298_acpi_ids[] = {
 MODULE_DEVICE_TABLE(acpi, ad7298_acpi_ids);
 
 static const struct spi_device_id ad7298_id[] = {
-	{"ad7298", 0},
-	{}
+	{ "ad7298", 0 },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7298_id);
 
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 80aebed47d1f..aeb8e383fe71 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -409,35 +409,35 @@ static int ad7476_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7476_id[] = {
-	{"ad7091", ID_AD7091},
-	{"ad7091r", ID_AD7091R},
-	{"ad7273", ID_AD7273},
-	{"ad7274", ID_AD7274},
-	{"ad7276", ID_AD7276},
-	{"ad7277", ID_AD7277},
-	{"ad7278", ID_AD7278},
-	{"ad7466", ID_AD7466},
-	{"ad7467", ID_AD7467},
-	{"ad7468", ID_AD7468},
-	{"ad7475", ID_AD7475},
-	{"ad7476", ID_AD7466},
-	{"ad7476a", ID_AD7466},
-	{"ad7477", ID_AD7467},
-	{"ad7477a", ID_AD7467},
-	{"ad7478", ID_AD7468},
-	{"ad7478a", ID_AD7468},
-	{"ad7495", ID_AD7495},
-	{"ad7910", ID_AD7467},
-	{"ad7920", ID_AD7466},
-	{"ad7940", ID_AD7940},
-	{"adc081s", ID_ADC081S},
-	{"adc101s", ID_ADC101S},
-	{"adc121s", ID_ADC121S},
-	{"ads7866", ID_ADS7866},
-	{"ads7867", ID_ADS7867},
-	{"ads7868", ID_ADS7868},
-	{"ltc2314-14", ID_LTC2314_14},
-	{}
+	{ "ad7091", ID_AD7091 },
+	{ "ad7091r", ID_AD7091R },
+	{ "ad7273", ID_AD7273 },
+	{ "ad7274", ID_AD7274 },
+	{ "ad7276", ID_AD7276},
+	{ "ad7277", ID_AD7277 },
+	{ "ad7278", ID_AD7278 },
+	{ "ad7466", ID_AD7466 },
+	{ "ad7467", ID_AD7467 },
+	{ "ad7468", ID_AD7468 },
+	{ "ad7475", ID_AD7475 },
+	{ "ad7476", ID_AD7466 },
+	{ "ad7476a", ID_AD7466 },
+	{ "ad7477", ID_AD7467 },
+	{ "ad7477a", ID_AD7467 },
+	{ "ad7478", ID_AD7468 },
+	{ "ad7478a", ID_AD7468 },
+	{ "ad7495", ID_AD7495 },
+	{ "ad7910", ID_AD7467 },
+	{ "ad7920", ID_AD7466 },
+	{ "ad7940", ID_AD7940 },
+	{ "adc081s", ID_ADC081S },
+	{ "adc101s", ID_ADC101S },
+	{ "adc121s", ID_ADC121S },
+	{ "ads7866", ID_ADS7866 },
+	{ "ads7867", ID_ADS7867 },
+	{ "ads7868", ID_ADS7868 },
+	{ "ltc2314-14", ID_LTC2314_14 },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7476_id);
 
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index d8408052262e..b5975bbfcbe0 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -83,7 +83,7 @@ static const struct of_device_id ad7606_of_match[] = {
 	{ .compatible = "adi,ad7606-4" },
 	{ .compatible = "adi,ad7606-6" },
 	{ .compatible = "adi,ad7606-8" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7606_of_match);
 
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 287a0591533b..62ec12195307 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -334,7 +334,7 @@ static const struct spi_device_id ad7606_id_table[] = {
 	{ "ad7606-8", ID_AD7606_8 },
 	{ "ad7606b",  ID_AD7606B },
 	{ "ad7616",   ID_AD7616 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7606_id_table);
 
@@ -345,7 +345,7 @@ static const struct of_device_id ad7606_of_match[] = {
 	{ .compatible = "adi,ad7606-8" },
 	{ .compatible = "adi,ad7606b" },
 	{ .compatible = "adi,ad7616" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7606_of_match);
 
diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 3079a0872947..4d570383ef02 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -291,13 +291,13 @@ static int ad7766_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7766_id[] = {
-	{"ad7766", ID_AD7766},
-	{"ad7766-1", ID_AD7766_1},
-	{"ad7766-2", ID_AD7766_2},
-	{"ad7767", ID_AD7766},
-	{"ad7767-1", ID_AD7766_1},
-	{"ad7767-2", ID_AD7766_2},
-	{}
+	{ "ad7766", ID_AD7766 },
+	{ "ad7766-1", ID_AD7766_1 },
+	{ "ad7766-2", ID_AD7766_2 },
+	{ "ad7767", ID_AD7766 },
+	{ "ad7767-1", ID_AD7766_1 },
+	{ "ad7767-2", ID_AD7766_2 },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7766_id);
 
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 721672fe84ab..113703fb7245 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -655,7 +655,7 @@ MODULE_DEVICE_TABLE(spi, ad7768_id_table);
 
 static const struct of_device_id ad7768_of_match[] = {
 	{ .compatible = "adi,ad7768-1" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7768_of_match);
 
diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
index a813fe04787c..e9b0c577c9cc 100644
--- a/drivers/iio/adc/ad7780.c
+++ b/drivers/iio/adc/ad7780.c
@@ -355,11 +355,11 @@ static int ad7780_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7780_id[] = {
-	{"ad7170", ID_AD7170},
-	{"ad7171", ID_AD7171},
-	{"ad7780", ID_AD7780},
-	{"ad7781", ID_AD7781},
-	{}
+	{ "ad7170", ID_AD7170 },
+	{ "ad7171", ID_AD7171 },
+	{ "ad7780", ID_AD7780 },
+	{ "ad7781", ID_AD7781 },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7780_id);
 
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index d4ad7e0b515a..abebd519cafa 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -824,16 +824,16 @@ static int ad7793_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7793_id[] = {
-	{"ad7785", ID_AD7785},
-	{"ad7792", ID_AD7792},
-	{"ad7793", ID_AD7793},
-	{"ad7794", ID_AD7794},
-	{"ad7795", ID_AD7795},
-	{"ad7796", ID_AD7796},
-	{"ad7797", ID_AD7797},
-	{"ad7798", ID_AD7798},
-	{"ad7799", ID_AD7799},
-	{}
+	{ "ad7785", ID_AD7785 },
+	{ "ad7792", ID_AD7792 },
+	{ "ad7793", ID_AD7793 },
+	{ "ad7794", ID_AD7794 },
+	{ "ad7795", ID_AD7795 },
+	{ "ad7796", ID_AD7796 },
+	{ "ad7797", ID_AD7797 },
+	{ "ad7798", ID_AD7798 },
+	{ "ad7799", ID_AD7799 },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7793_id);
 
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 965bdc8aa696..6265ce7df703 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -329,8 +329,8 @@ static int ad7887_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7887_id[] = {
-	{"ad7887", ID_AD7887},
-	{}
+	{ "ad7887", ID_AD7887 },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7887_id);
 
diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 9d6bf6d0927a..09680015a7ab 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -361,14 +361,14 @@ static int ad7923_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad7923_id[] = {
-	{"ad7904", AD7904},
-	{"ad7914", AD7914},
-	{"ad7923", AD7924},
-	{"ad7924", AD7924},
-	{"ad7908", AD7908},
-	{"ad7918", AD7918},
-	{"ad7928", AD7928},
-	{}
+	{ "ad7904", AD7904 },
+	{ "ad7914", AD7914 },
+	{ "ad7923", AD7924 },
+	{ "ad7924", AD7924 },
+	{ "ad7908", AD7908 },
+	{ "ad7918", AD7918 },
+	{ "ad7928", AD7928 },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7923_id);
 
@@ -380,7 +380,7 @@ static const struct of_device_id ad7923_of_match[] = {
 	{ .compatible = "adi,ad7908", },
 	{ .compatible = "adi,ad7918", },
 	{ .compatible = "adi,ad7928", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7923_of_match);
 
diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index ce0bae94aa3a..05fb7a75531f 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -1252,7 +1252,7 @@ static const struct of_device_id ad9467_of_match[] = {
 	{ .compatible = "adi,ad9643", .data = &ad9643_chip_tbl, },
 	{ .compatible = "adi,ad9649", .data = &ad9649_chip_tbl, },
 	{ .compatible = "adi,ad9652", .data = &ad9652_chip_tbl, },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad9467_of_match);
 
@@ -1263,7 +1263,7 @@ static const struct spi_device_id ad9467_ids[] = {
 	{ "ad9643", (kernel_ulong_t)&ad9643_chip_tbl },
 	{ "ad9649", (kernel_ulong_t)&ad9649_chip_tbl, },
 	{ "ad9652", (kernel_ulong_t)&ad9652_chip_tbl, },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad9467_ids);
 
diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 064cddaf6399..1d5fd5f534b8 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -694,7 +694,7 @@ static const struct of_device_id aspeed_adc_matches[] = {
 	{ .compatible = "aspeed,ast2500-adc", .data = &ast2500_model_data },
 	{ .compatible = "aspeed,ast2600-adc0", .data = &ast2600_adc0_model_data },
 	{ .compatible = "aspeed,ast2600-adc1", .data = &ast2600_adc1_model_data },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, aspeed_adc_matches);
 
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 510e826014e6..9c39acff17e6 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1335,7 +1335,7 @@ static const struct of_device_id at91_adc_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9g45-adc", .data = &at91sam9g45_caps },
 	{ .compatible = "atmel,at91sam9x5-adc", .data = &at91sam9x5_caps },
 	{ .compatible = "atmel,sama5d3-adc", .data = &sama5d3_caps },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, at91_adc_dt_ids);
 
diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index f135cf2362df..8c3acc0cd7e9 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -299,7 +299,7 @@ static int axp288_adc_probe(struct platform_device *pdev)
 
 static const struct platform_device_id axp288_adc_id_table[] = {
 	{ .name = "axp288_adc" },
-	{},
+	{ }
 };
 
 static struct platform_driver axp288_adc_driver = {
diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 6bc149c51414..cdfe304eaa20 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -606,7 +606,7 @@ static void iproc_adc_remove(struct platform_device *pdev)
 
 static const struct of_device_id iproc_adc_of_match[] = {
 	{.compatible = "brcm,iproc-static-adc", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, iproc_adc_of_match);
 
diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index 4cdddc6e36e9..fa04e0a5f645 100644
--- a/drivers/iio/adc/berlin2-adc.c
+++ b/drivers/iio/adc/berlin2-adc.c
@@ -351,7 +351,7 @@ static int berlin2_adc_probe(struct platform_device *pdev)
 
 static const struct of_device_id berlin2_adc_match[] = {
 	{ .compatible = "marvell,berlin2-adc", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, berlin2_adc_match);
 
diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
index 971942ce4c66..cc38d5e0608e 100644
--- a/drivers/iio/adc/ep93xx_adc.c
+++ b/drivers/iio/adc/ep93xx_adc.c
@@ -228,7 +228,7 @@ static void ep93xx_adc_remove(struct platform_device *pdev)
 
 static const struct of_device_id ep93xx_adc_of_ids[] = {
 	{ .compatible = "cirrus,ep9301-adc" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ep93xx_adc_of_ids);
 
diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 78fada4b7b1c..4d00ee8dd14d 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -519,7 +519,7 @@ static const struct of_device_id exynos_adc_match[] = {
 		.compatible = "samsung,exynos7-adc",
 		.data = &exynos7_adc_data,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, exynos_adc_match);
 
diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index 771fa12bdc02..fb635a756440 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -524,7 +524,7 @@ static int hi8435_probe(struct spi_device *spi)
 
 static const struct of_device_id hi8435_dt_ids[] = {
 	{ .compatible = "holt,hi8435" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, hi8435_dt_ids);
 
diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 376f4e02de97..8da0419ecfa3 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -552,7 +552,7 @@ static int hx711_probe(struct platform_device *pdev)
 
 static const struct of_device_id of_hx711_match[] = {
 	{ .compatible = "avia,hx711", },
-	{},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, of_hx711_match);
diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 0fc24bceb58a..48c95e12e791 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -1052,12 +1052,12 @@ static void ina2xx_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ina2xx_id[] = {
-	{"ina219", ina219},
-	{"ina220", ina219},
-	{"ina226", ina226},
-	{"ina230", ina226},
-	{"ina231", ina226},
-	{}
+	{ "ina219", ina219 },
+	{ "ina220", ina219 },
+	{ "ina226", ina226 },
+	{ "ina230", ina226 },
+	{ "ina231", ina226 },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ina2xx_id);
 
@@ -1082,7 +1082,7 @@ static const struct of_device_id ina2xx_of_match[] = {
 		.compatible = "ti,ina231",
 		.data = (void *)ina226
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ina2xx_of_match);
 
diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index af70ca760797..1e802c8779a4 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -908,7 +908,7 @@ static const struct of_device_id ingenic_adc_of_match[] = {
 	{ .compatible = "ingenic,jz4760-adc", .data = &jz4760_adc_soc_data, },
 	{ .compatible = "ingenic,jz4760b-adc", .data = &jz4760_adc_soc_data, },
 	{ .compatible = "ingenic,jz4770-adc", .data = &jz4770_adc_soc_data, },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ingenic_adc_of_match);
 
diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index e34ed7dacd89..43a7bc8158b5 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -217,7 +217,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 
 static const struct of_device_id lpc32xx_adc_match[] = {
 	{ .compatible = "nxp,lpc3220-adc" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, lpc32xx_adc_match);
 
diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
index 2593fa4322eb..f06dd0b9a858 100644
--- a/drivers/iio/adc/ltc2496.c
+++ b/drivers/iio/adc/ltc2496.c
@@ -94,7 +94,7 @@ static const struct ltc2497_chip_info ltc2496_info = {
 
 static const struct of_device_id ltc2496_of_match[] = {
 	{ .compatible = "lltc,ltc2496", .data = &ltc2496_info, },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2496_of_match);
 
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 6401a7727c31..f010b2fd1202 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -151,7 +151,7 @@ MODULE_DEVICE_TABLE(i2c, ltc2497_id);
 static const struct of_device_id ltc2497_of_match[] = {
 	{ .compatible = "lltc,ltc2497", .data = &ltc2497_info[TYPE_LTC2497] },
 	{ .compatible = "lltc,ltc2499", .data = &ltc2497_info[TYPE_LTC2499] },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2497_of_match);
 
diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 136fcf753837..f5ba4a1b5a7d 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -73,13 +73,13 @@ enum max1027_id {
 };
 
 static const struct spi_device_id max1027_id[] = {
-	{"max1027", max1027},
-	{"max1029", max1029},
-	{"max1031", max1031},
-	{"max1227", max1227},
-	{"max1229", max1229},
-	{"max1231", max1231},
-	{}
+	{ "max1027", max1027 },
+	{ "max1029", max1029 },
+	{ "max1031", max1031 },
+	{ "max1227", max1227 },
+	{ "max1229", max1229 },
+	{ "max1231", max1231 },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, max1027_id);
 
@@ -90,7 +90,7 @@ static const struct of_device_id max1027_adc_dt_ids[] = {
 	{ .compatible = "maxim,max1227" },
 	{ .compatible = "maxim,max1229" },
 	{ .compatible = "maxim,max1231" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, max1027_adc_dt_ids);
 
diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
index 49e38dca8fe2..2f07437caec3 100644
--- a/drivers/iio/adc/max11100.c
+++ b/drivers/iio/adc/max11100.c
@@ -143,8 +143,8 @@ static int max11100_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id max11100_ids[] = {
-	{.compatible = "maxim,max11100"},
-	{ },
+	{ .compatible = "maxim,max11100" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, max11100_ids);
 
diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
index 0beccfde81f2..3d0a7d0eb7ee 100644
--- a/drivers/iio/adc/max1118.c
+++ b/drivers/iio/adc/max1118.c
@@ -260,7 +260,7 @@ static const struct spi_device_id max1118_id[] = {
 	{ "max1117", max1117 },
 	{ "max1118", max1118 },
 	{ "max1119", max1119 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, max1118_id);
 
@@ -268,7 +268,7 @@ static const struct of_device_id max1118_dt_ids[] = {
 	{ .compatible = "maxim,max1117" },
 	{ .compatible = "maxim,max1118" },
 	{ .compatible = "maxim,max1119" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, max1118_dt_ids);
 
diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
index 500bb09ab19b..d62c1a011659 100644
--- a/drivers/iio/adc/max1241.c
+++ b/drivers/iio/adc/max1241.c
@@ -177,12 +177,12 @@ static int max1241_probe(struct spi_device *spi)
 
 static const struct spi_device_id max1241_id[] = {
 	{ "max1241", max1241 },
-	{}
+	{ }
 };
 
 static const struct of_device_id max1241_dt_ids[] = {
 	{ .compatible = "maxim,max1241" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, max1241_dt_ids);
 
diff --git a/drivers/iio/adc/max34408.c b/drivers/iio/adc/max34408.c
index 6c2ea2bc52c6..ffec22be2d59 100644
--- a/drivers/iio/adc/max34408.c
+++ b/drivers/iio/adc/max34408.c
@@ -250,14 +250,14 @@ static const struct of_device_id max34408_of_match[] = {
 		.compatible = "maxim,max34409",
 		.data = &max34409_model_data,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, max34408_of_match);
 
 static const struct i2c_device_id max34408_id[] = {
 	{ "max34408", (kernel_ulong_t)&max34408_model_data },
 	{ "max34409", (kernel_ulong_t)&max34409_model_data },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max34408_id);
 
diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index 76e517b7b1e4..14fe42fc4b7d 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -504,9 +504,9 @@ static int max9611_init(struct max9611_dev *max9611)
 }
 
 static const struct of_device_id max9611_of_table[] = {
-	{.compatible = "maxim,max9611", .data = "max9611"},
-	{.compatible = "maxim,max9612", .data = "max9612"},
-	{ },
+	{ .compatible = "maxim,max9611", .data = "max9611" },
+	{ .compatible = "maxim,max9612", .data = "max9612" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, max9611_of_table);
diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index 5f672765d4a2..5fbf9b6abd9c 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -184,8 +184,8 @@ static void mp2629_adc_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id mp2629_adc_of_match[] = {
-	{ .compatible = "mps,mp2629_adc"},
-	{}
+	{ .compatible = "mps,mp2629_adc" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mp2629_adc_of_match);
 
diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index f74347663ad8..e2ec805e834f 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -355,7 +355,7 @@ static int mt6360_adc_probe(struct platform_device *pdev)
 
 static const struct of_device_id mt6360_adc_of_id[] = {
 	{ .compatible = "mediatek,mt6360-adc", },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mt6360_adc_of_id);
 
diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index 600151a62f1f..458544cb8ee4 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -539,7 +539,7 @@ MODULE_DEVICE_TABLE(i2c, nau7802_i2c_id);
 
 static const struct of_device_id nau7802_dt_ids[] = {
 	{ .compatible = "nuvoton,nau7802" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, nau7802_dt_ids);
 
diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index 8200a47bdf21..4c2a1c07bc39 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -1234,13 +1234,13 @@ static int pac1921_probe(struct i2c_client *client)
 
 static const struct i2c_device_id pac1921_id[] = {
 	{ .name = "pac1921", 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pac1921_id);
 
 static const struct of_device_id pac1921_of_match[] = {
 	{ .compatible = "microchip,pac1921" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, pac1921_of_match);
 
diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index ae24a27805ab..8210728034d0 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1571,7 +1571,7 @@ static const struct i2c_device_id pac1934_id[] = {
 	{ .name = "pac1932", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1932] },
 	{ .name = "pac1933", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1933] },
 	{ .name = "pac1934", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1934] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pac1934_id);
 
@@ -1592,7 +1592,7 @@ static const struct of_device_id pac1934_of_match[] = {
 		.compatible = "microchip,pac1934",
 		.data = &pac1934_chip_config[PAC1934]
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, pac1934_of_match);
 
@@ -1602,7 +1602,7 @@ MODULE_DEVICE_TABLE(of, pac1934_of_match);
  */
 static const struct acpi_device_id pac1934_acpi_match[] = {
 	{ "MCHP1930", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1934] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, pac1934_acpi_match);
 
diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index c9d2c66434e4..9e1112f5acc6 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -1006,7 +1006,7 @@ static const struct of_device_id pm8xxx_xoadc_id_table[] = {
 		.compatible = "qcom,pm8921-adc",
 		.data = &pm8921_variant,
 	},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8xxx_xoadc_id_table);
 
diff --git a/drivers/iio/adc/qcom-spmi-rradc.c b/drivers/iio/adc/qcom-spmi-rradc.c
index 1402df68dd52..6aa70b4629a7 100644
--- a/drivers/iio/adc/qcom-spmi-rradc.c
+++ b/drivers/iio/adc/qcom-spmi-rradc.c
@@ -1002,7 +1002,7 @@ static int rradc_probe(struct platform_device *pdev)
 static const struct of_device_id rradc_match_table[] = {
 	{ .compatible = "qcom,pm660-rradc" },
 	{ .compatible = "qcom,pmi8998-rradc" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, rradc_match_table);
 
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 71f58e3a8307..240cfa391674 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -331,7 +331,7 @@ static const struct of_device_id rockchip_saradc_match[] = {
 		.compatible = "rockchip,rk3588-saradc",
 		.data = &rk3588_saradc_data,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, rockchip_saradc_match);
 
diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index 45b1b81c9fdd..56ed948a8ae1 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -865,7 +865,7 @@ static const struct richtek_dev_data rtq6059_devdata = {
 static const struct of_device_id rtq6056_device_match[] = {
 	{ .compatible = "richtek,rtq6056", .data = &rtq6056_devdata },
 	{ .compatible = "richtek,rtq6059", .data = &rtq6059_devdata },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, rtq6056_device_match);
 
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index c901ba1bc6ba..32ca26ed59f7 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2638,7 +2638,7 @@ static const struct of_device_id stm32_adc_of_match[] = {
 	{ .compatible = "st,stm32h7-adc", .data = (void *)&stm32h7_adc_cfg },
 	{ .compatible = "st,stm32mp1-adc", .data = (void *)&stm32mp1_adc_cfg },
 	{ .compatible = "st,stm32mp13-adc", .data = (void *)&stm32mp13_adc_cfg },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
 
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 1a24d496fc61..2037f73426d4 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1466,7 +1466,7 @@ static const struct iio_chan_spec_ext_info dfsdm_adc_audio_ext_info[] = {
 		.read = dfsdm_adc_audio_get_spiclk,
 		.write = dfsdm_adc_audio_set_spiclk,
 	},
-	{},
+	{ }
 };
 
 static void stm32_dfsdm_dma_release(struct iio_dev *indio_dev)
diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index a05d978b8cb8..bef59fcc0d80 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -299,7 +299,7 @@ static const struct of_device_id stm32_dfsdm_of_match[] = {
 		.compatible = "st,stm32mp1-dfsdm",
 		.data = &stm32mp1_dfsdm_data,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
 
diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index 8e56def1c9e5..b0add5a2eab5 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -347,7 +347,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stmpe_adc_pm_ops, NULL, stmpe_adc_resume);
 
 static const struct of_device_id stmpe_adc_ids[] = {
 	{ .compatible = "st,stmpe-adc", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stmpe_adc_ids);
 
diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
index d7800e1fa536..e2dbd070c7c4 100644
--- a/drivers/iio/adc/ti-adc0832.c
+++ b/drivers/iio/adc/ti-adc0832.c
@@ -309,7 +309,7 @@ static const struct of_device_id adc0832_dt_ids[] = {
 	{ .compatible = "ti,adc0832", },
 	{ .compatible = "ti,adc0834", },
 	{ .compatible = "ti,adc0838", },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adc0832_dt_ids);
 
@@ -318,7 +318,7 @@ static const struct spi_device_id adc0832_id[] = {
 	{ "adc0832", adc0832 },
 	{ "adc0834", adc0834 },
 	{ "adc0838", adc0838 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc0832_id);
 
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index 4a07c6295a2b..bf98f9bf942a 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -242,13 +242,13 @@ static int adc084s021_probe(struct spi_device *spi)
 
 static const struct of_device_id adc084s021_of_match[] = {
 	{ .compatible = "ti,adc084s021", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adc084s021_of_match);
 
 static const struct spi_device_id adc084s021_id[] = {
 	{ ADC084S021_DRIVER_NAME, 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc084s021_id);
 
diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
index a2cd8c454e11..7f065f457b36 100644
--- a/drivers/iio/adc/ti-adc12138.c
+++ b/drivers/iio/adc/ti-adc12138.c
@@ -519,7 +519,7 @@ static const struct of_device_id adc12138_dt_ids[] = {
 	{ .compatible = "ti,adc12130", },
 	{ .compatible = "ti,adc12132", },
 	{ .compatible = "ti,adc12138", },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adc12138_dt_ids);
 
@@ -527,7 +527,7 @@ static const struct spi_device_id adc12138_id[] = {
 	{ "adc12130", adc12130 },
 	{ "adc12132", adc12132 },
 	{ "adc12138", adc12138 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc12138_id);
 
diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index f7c78d0dd449..474e733fb8e0 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -226,14 +226,14 @@ static int ti_adc_probe(struct spi_device *spi)
 static const struct of_device_id ti_adc_dt_ids[] = {
 	{ .compatible = "ti,adc141s626", },
 	{ .compatible = "ti,adc161s626", },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ti_adc_dt_ids);
 
 static const struct spi_device_id ti_adc_id[] = {
-	{"adc141s626", TI_ADC141S626},
-	{"adc161s626", TI_ADC161S626},
-	{},
+	{ "adc141s626", TI_ADC141S626 },
+	{ "adc161s626", TI_ADC161S626 },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ti_adc_id);
 
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index ca432c49eab1..6d1bc9659946 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1173,7 +1173,7 @@ static const struct i2c_device_id ads1015_id[] = {
 	{ "ads1015", (kernel_ulong_t)&ads1015_data },
 	{ "ads1115", (kernel_ulong_t)&ads1115_data },
 	{ "tla2024", (kernel_ulong_t)&tla2024_data },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ads1015_id);
 
@@ -1181,7 +1181,7 @@ static const struct of_device_id ads1015_of_match[] = {
 	{ .compatible = "ti,ads1015", .data = &ads1015_data },
 	{ .compatible = "ti,ads1115", .data = &ads1115_data },
 	{ .compatible = "ti,tla2024", .data = &tla2024_data },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ads1015_of_match);
 
diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index c115f892232a..14941f384dad 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -357,7 +357,7 @@ MODULE_DEVICE_TABLE(spi, ads124s_id);
 static const struct of_device_id ads124s_of_table[] = {
 	{ .compatible = "ti,ads124s06" },
 	{ .compatible = "ti,ads124s08" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ads124s_of_table);
 
diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index 55366ffb0489..91a427eb0882 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -918,7 +918,7 @@ static const struct of_device_id ads131e08_of_match[] = {
 	  .data = &ads131e08_info_tbl[ads131e06], },
 	{ .compatible = "ti,ads131e08",
 	  .data = &ads131e08_info_tbl[ads131e08], },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ads131e08_of_match);
 
@@ -926,7 +926,7 @@ static const struct spi_device_id ads131e08_ids[] = {
 	{ "ads131e04", (kernel_ulong_t)&ads131e08_info_tbl[ads131e04] },
 	{ "ads131e06", (kernel_ulong_t)&ads131e08_info_tbl[ads131e06] },
 	{ "ads131e08", (kernel_ulong_t)&ads131e08_info_tbl[ads131e08] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ads131e08_ids);
 
diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
index 4da78302359b..66b54c0d75aa 100644
--- a/drivers/iio/adc/ti-ads7924.c
+++ b/drivers/iio/adc/ti-ads7924.c
@@ -448,13 +448,13 @@ static int ads7924_probe(struct i2c_client *client)
 
 static const struct i2c_device_id ads7924_id[] = {
 	{ "ads7924" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ads7924_id);
 
 static const struct of_device_id ads7924_of_match[] = {
 	{ .compatible = "ti,ads7924", },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ads7924_of_match);
 
diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 263fc3a1b87e..af28672aa803 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -705,7 +705,7 @@ static const struct of_device_id ads7950_of_table[] = {
 	{ .compatible = "ti,ads7959", .data = &ti_ads7950_chip_info[TI_ADS7959] },
 	{ .compatible = "ti,ads7960", .data = &ti_ads7950_chip_info[TI_ADS7960] },
 	{ .compatible = "ti,ads7961", .data = &ti_ads7950_chip_info[TI_ADS7961] },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ads7950_of_table);
 
diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
index bbd85cb47f81..3bec8a2e61ab 100644
--- a/drivers/iio/adc/ti-ads8344.c
+++ b/drivers/iio/adc/ti-ads8344.c
@@ -175,7 +175,7 @@ static int ads8344_probe(struct spi_device *spi)
 
 static const struct of_device_id ads8344_of_match[] = {
 	{ .compatible = "ti,ads8344", },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ads8344_of_match);
 
diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 94cc823b26f3..9b1814f1965a 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -452,9 +452,9 @@ static int ads8688_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ads8688_id[] = {
-	{"ads8684", ID_ADS8684},
-	{"ads8688", ID_ADS8688},
-	{}
+	{ "ads8684", ID_ADS8684 },
+	{ "ads8688", ID_ADS8688 },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ads8688_id);
 
diff --git a/drivers/iio/adc/ti-lmp92064.c b/drivers/iio/adc/ti-lmp92064.c
index 84ba5c4a0eea..169e3591320b 100644
--- a/drivers/iio/adc/ti-lmp92064.c
+++ b/drivers/iio/adc/ti-lmp92064.c
@@ -360,7 +360,7 @@ static int lmp92064_adc_probe(struct spi_device *spi)
 
 static const struct spi_device_id lmp92064_id_table[] = {
 	{ "lmp92064" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, lmp92064_id_table);
 
diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
index 30f629a553a1..08de997584fd 100644
--- a/drivers/iio/adc/ti-tlc4541.c
+++ b/drivers/iio/adc/ti-tlc4541.c
@@ -237,14 +237,14 @@ static void tlc4541_remove(struct spi_device *spi)
 static const struct of_device_id tlc4541_dt_ids[] = {
 	{ .compatible = "ti,tlc3541", },
 	{ .compatible = "ti,tlc4541", },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tlc4541_dt_ids);
 
 static const struct spi_device_id tlc4541_id[] = {
-	{"tlc3541", TLC3541},
-	{"tlc4541", TLC4541},
-	{}
+	{ "tlc3541", TLC3541 },
+	{ "tlc4541", TLC4541 },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, tlc4541_id);
 
-- 
2.46.0


