Return-Path: <linux-iio+bounces-5589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B64828D71B1
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 21:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC9E1F21880
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 19:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC811D543;
	Sat,  1 Jun 2024 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Xr9q0HRO"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472CE2582;
	Sat,  1 Jun 2024 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717270295; cv=none; b=qPzO7WgtuPzho32eY7cUTa20SrVvlY9xPx/esAtkLVPNTuLBx90KiA6MXCYc6TkhpNaHTEbmXqH5MJoMCpkip67n/gvRMMu8+LxvP/s/I7u5kxw+h7rAzkk1n3CBJIVXTOLCT+J9xMhEOIW/98Ler0EAN6FmKgo4JB0qh3EdxzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717270295; c=relaxed/simple;
	bh=07g1c1YULA/f44mcBqlbF85COSc0n1ZZl299/Wei0Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSqP0Mqaa/xBhSltdnpDk6Y7uA6FgYHsc2aCQH6zxFTm7pT4UYyn0pD5tUOwJSAC1KHqScerIvrZEm0M2h2m5Wfa8gaPqG+VCcZYB/TBxxZS+slR0+8mIxE29Md3/TyN5TI3wHbE/nA0BqLZSC6e4ip93CortpxgUaSEOElNMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Xr9q0HRO; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 827FF41164;
	Sat,  1 Jun 2024 21:31:30 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dgjq-Yvk1jWp; Sat,  1 Jun 2024 21:31:29 +0200 (CEST)
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1717270289; bh=07g1c1YULA/f44mcBqlbF85COSc0n1ZZl299/Wei0Ns=;
	h=From:To:Cc:Subject:Date;
	b=Xr9q0HROUOMNRkJ4NH8XyQavEF04/nr4yhqKRWxH2IyL93zV6YAqeb4ilFUJ+YxtE
	 3MyZ96Xz2eKfRP4Pv3xwrYPi19lQC8fwnvVwI3R8q8w28cvB2ClyuFl/ydcm4zCyVP
	 HjXHZlBmo5vGoEpWlqJaBKcBLq8uLLmAA+NpYBJG/AIEwDgmU5mDYV2SpyeH9plyvC
	 7HWo7bHh+SwzobubXx6u9mfYWDf7SRh3IKO67PWXCAm7vhEKNP8QjGnD16qqmLxYMi
	 Cnu3hiYqEVjHUL55Su8qEHOVY8EsWOx51DqaPxC39pGmCy++nNOfOcJgRkPJHhOZ1h
	 XI00JSy1ulFLA==
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	denis.ciocca@st.com
Cc: devicetree@vger.kernel.org,
	linus.walleij@linaro.org,
	robh+dt@kernel.org,
	kauschluss@disroot.org
Subject: [PATCH v3] iio: accel: st_accel: add LIS2DS12
Date: Sun,  2 Jun 2024 00:56:41 +0530
Message-ID: <20240601192914.141906-1-kauschluss@disroot.org>
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
Changes in v3:
- fix code formatting

v2: https://lore.kernel.org/linux-iio/20240601183233.118397-1-kauschluss@disroot.org/
Changes in v2:
- add SPI support
- link datasheet in commit description

v1: https://lore.kernel.org/linux-iio/20240526083302.87172-1-kauschluss@disroot.org/
---
 drivers/iio/accel/st_accel.h      |  1 +
 drivers/iio/accel/st_accel_core.c | 76 +++++++++++++++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c  |  5 ++
 drivers/iio/accel/st_accel_spi.c  |  5 ++
 4 files changed, 87 insertions(+)

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
index d2104e14e255..8552faea1913 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -925,6 +925,82 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
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
index f72a24f45322..825adab37105 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -64,6 +64,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lis2dh12-accel",
 		.data = LIS2DH12_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lis2ds12",
+		.data = LIS2DS12_ACCEL_DEV_NAME,
+	},
 	{
 		.compatible = "st,lis3l02dq",
 		.data = LIS3L02DQ_ACCEL_DEV_NAME,
@@ -151,6 +155,7 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LSM330_ACCEL_DEV_NAME },
 	{ LSM303AGR_ACCEL_DEV_NAME },
 	{ LIS2DH12_ACCEL_DEV_NAME },
+	{ LIS2DS12_ACCEL_DEV_NAME },
 	{ LIS3L02DQ_ACCEL_DEV_NAME },
 	{ LNG2DM_ACCEL_DEV_NAME },
 	{ H3LIS331DL_ACCEL_DEV_NAME },
-- 
2.45.1


