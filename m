Return-Path: <linux-iio+bounces-5581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411518D718A
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 20:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B691C20B17
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 18:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20CF1552E6;
	Sat,  1 Jun 2024 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="VhLJrsN2"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B716A154C01;
	Sat,  1 Jun 2024 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717266933; cv=none; b=n6cqdi1VUVWYrDfYZ92C3siqzVCfHTn5pT+Xf6dPdelLxhqUSuWCtcI2H6Az2k+3Rr32YcLcicMtJbXFw59Y4570ZGPU9gsIMriOGIwEprV2bHw3EFC0X8j1DtyrQh2RU9AXq3SDhc8lBuhXTqC9kCkwblyx0kS7ThV5Rjgn11U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717266933; c=relaxed/simple;
	bh=P1OTpKV/R6By4dLLQwzp2PNebfKG3S0FnUodq0ZXGis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IAl75tnuCWlUk4VSZoRgWsIgRgcP49RtHfLW+rlhTafgmHhfena+m1E2WF0EpbOuY4gJARBupv02xUcF+x4g0nZOUWi471o95qDTeCQ+tsHZXM/9Mk6QEY9U+ZbjYNPkHkPFjwmG6A8y0TGMl92XjH7+j1wXYtTruK5qEnz+ByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=VhLJrsN2; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9290640C71;
	Sat,  1 Jun 2024 20:35:22 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BGAEVI2169fv; Sat,  1 Jun 2024 20:35:21 +0200 (CEST)
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1717266921; bh=P1OTpKV/R6By4dLLQwzp2PNebfKG3S0FnUodq0ZXGis=;
	h=From:To:Cc:Subject:Date;
	b=VhLJrsN22T5t8i9IFIsE7Xbl5JYDXM/0TKNca9F0RgLRSXsXRcRETSOlHfSLaUDei
	 mz/O6i8fjbSSayboG/fCjFII6koJ7IwdB7IsZiMuzS6eXuPJ4ht+SvUBn/hrkqQpZV
	 qGcIhoUjQKR9xCWWRnPkQk8EndgQj/C4IrKm4gPn+HHbDwvySIbU1fA3LbxXKko+N9
	 CgElRiu0VS2vUf3FxJBXGH0HqBXIzgSCJHDKMgJ15f5oS4IAVwmo9pclYEi6CR/S52
	 iCN4Mz82tE4QPqegDNX5V1ikMFWTa/J+zQ1hR92xucOcqo4bPO9AdFxV8zlHnZd3hE
	 x2M72I1MTEccw==
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	denis.ciocca@st.com
Cc: devicetree@vger.kernel.org,
	linus.walleij@linaro.org,
	robh+dt@kernel.org,
	kauschluss@disroot.org
Subject: [PATCH v2] iio: accel: st_accel: add LIS2DS12
Date: Sat,  1 Jun 2024 23:49:00 +0530
Message-ID: <20240601183233.118397-1-kauschluss@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LIS2DS12 accelerometer by STMicroelectronics is mostly compatible
with the LIS2DE12 variant, except the WhoAmI value (0x43).

Define sensor settings for LIS2DS12, and add support in the I2C and
SPI drivers.

Datasheet: https://www.st.com/resource/en/datasheet/lis2ds12.pdf

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- add SPI support
- link datasheet in commit description

v1: https://lore.kernel.org/linux-iio/20240526083302.87172-1-kauschluss@disroot.org/
---
 drivers/iio/accel/st_accel.h      |  1 +
 drivers/iio/accel/st_accel_core.c | 77 +++++++++++++++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c  |  5 ++
 drivers/iio/accel/st_accel_spi.c  |  5 ++
 4 files changed, 88 insertions(+)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index e7525615712b..2659f536cef6 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -35,6 +35,7 @@
 #define LIS3DHH_ACCEL_DEV_NAME		"lis3dhh"
 #define LIS3DE_ACCEL_DEV_NAME		"lis3de"
 #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
+#define LIS2DS12_ACCEL_DEV_NAME		"lis2ds12"
 #define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
 #define LIS302DL_ACCEL_DEV_NAME		"lis302dl"
 #define LSM303C_ACCEL_DEV_NAME		"lsm303c_accel"
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index d2104e14e255..08356a90d48b 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -925,6 +925,83 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
+	{
+		.wai = 0x43,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = LIS2DS12_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_8bit_channels,
+		.odr = {
+			.addr = 0x20,
+			.mask = 0xf0,
+			.odr_avl = {
+				{ .hz = 1, .value = 0x01, },
+				{ .hz = 10, .value = 0x02, },
+				{ .hz = 25, .value = 0x03, },
+				{ .hz = 50, .value = 0x04, },
+				{ .hz = 100, .value = 0x05, },
+				{ .hz = 200, .value = 0x06, },
+				{ .hz = 400, .value = 0x07, },
+				{ .hz = 1620, .value = 0x08, },
+				{ .hz = 5376, .value = 0x09, },
+			},
+		},
+		.pw = {
+			.addr = 0x20,
+			.mask = 0xf0,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = 0x23,
+			.mask = 0x30,
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_2G,
+					.value = 0x00,
+					.gain = IIO_G_TO_M_S_2(15600),
+				},
+				[1] = {
+					.num = ST_ACCEL_FS_AVL_4G,
+					.value = 0x01,
+					.gain = IIO_G_TO_M_S_2(31200),
+				},
+				[2] = {
+					.num = ST_ACCEL_FS_AVL_8G,
+					.value = 0x02,
+					.gain = IIO_G_TO_M_S_2(62500),
+				},
+				[3] = {
+					.num = ST_ACCEL_FS_AVL_16G,
+					.value = 0x03,
+					.gain = IIO_G_TO_M_S_2(187500),
+				},
+			},
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x22,
+				.mask = 0x10,
+			},
+			.addr_ihl = 0x25,
+			.mask_ihl = 0x02,
+			.stat_drdy = {
+				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
+				.mask = 0x07,
+			},
+		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
+		.multi_read_bit = true,
+		.bootime = 2,
+	},
+
 	{
 		.wai = 0x41,
 		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index fd3749871121..329a4d6fb2ec 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -102,6 +102,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lis2de12",
 		.data = LIS2DE12_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lis2ds12",
+		.data = LIS2DS12_ACCEL_DEV_NAME,
+	},
 	{
 		.compatible = "st,lis2hh12",
 		.data = LIS2HH12_ACCEL_DEV_NAME,
@@ -154,6 +158,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LIS2DW12_ACCEL_DEV_NAME },
 	{ LIS3DE_ACCEL_DEV_NAME },
 	{ LIS2DE12_ACCEL_DEV_NAME },
+	{ LIS2DS12_ACCEL_DEV_NAME },
 	{ LIS2HH12_ACCEL_DEV_NAME },
 	{ LIS302DL_ACCEL_DEV_NAME },
 	{ LSM303C_ACCEL_DEV_NAME },
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index f72a24f45322..eadeb22c6ef7 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -60,6 +60,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lsm303agr-accel",
 		.data = LSM303AGR_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lis2ds12",
+		.data = LIS2DS12_ACCEL_DEV_NAME,
+	},
 	{
 		.compatible = "st,lis2dh12-accel",
 		.data = LIS2DH12_ACCEL_DEV_NAME,
@@ -150,6 +154,7 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LIS331DLH_ACCEL_DEV_NAME },
 	{ LSM330_ACCEL_DEV_NAME },
 	{ LSM303AGR_ACCEL_DEV_NAME },
+	{ LIS2DS12_ACCEL_DEV_NAME },
 	{ LIS2DH12_ACCEL_DEV_NAME },
 	{ LIS3L02DQ_ACCEL_DEV_NAME },
 	{ LNG2DM_ACCEL_DEV_NAME },
-- 
2.45.1


