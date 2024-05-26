Return-Path: <linux-iio+bounces-5308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065218CF2DD
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 10:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B5C1F21205
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 08:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF468BEE;
	Sun, 26 May 2024 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="HBMmJm0O"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC667AD51;
	Sun, 26 May 2024 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716713018; cv=none; b=vFGTceK8oIGsctIyYTpjMShg1v6lTUgAl5BwXegTS/cX1cbUC50NzaGWxqhOy3+G46CZRRBPLdo9EVPb1Dl/FWBVnD8VbCcCdOCp67NS/pemQ/EFeatEwfcl4dVXKIrkuAE7772iuSz4EtE4J1pHVc4QSV7ARUO2bMHMCW2eZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716713018; c=relaxed/simple;
	bh=rqls52QsTwTEMqEaclSyHk4FQVIg+A9t4zcX9jS+Wkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxzC53Awe6jDiSLPPJUMBodhYQae0NGBqy78so++dWE8S1SlKBKMK8xql2i+UgyG/W1J5+uZ0VP1Rot8xImPDmBqAkFEQDkva6XKLguh+uNXocFJdssbOgEC7k5ALrdrGHngJXO+H9A9+4Gm8PHPlwjBW0NyHMuowWMF5UyNedQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=HBMmJm0O; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1716712619; bh=rqls52QsTwTEMqEaclSyHk4FQVIg+A9t4zcX9jS+Wkc=;
	h=From:To:Cc:Subject:Date;
	b=HBMmJm0ODLLNIJN+VPFgjz6u+qJhZmF9pg3DCDhNVBveoT6Zz/N0dnW6DED5f60r5
	 9QMGA6isdveZeEXbmsA91DPTPOPpP5hxOPqmMVqSXKQg0V0ItIkTmCf5U03wQjMfs6
	 TjtAQTZLorRkX0w3SakLYm8QpOCeI/UMir/jiC45mr3cbYY6NaBc3HUVej698SeHJJ
	 ZMJeT3WKJX1EuFRfJjdGVYJoIO5AId9y+kmkbfTlpEN9aaA6oJtX3KDO+f+1CQLPS9
	 /wLt7hV4lgzDncvysm7kAaMI6nELJX1f8DW9HMkacUcIrP2tN+RN/snQ6vy2Ip3KXV
	 QPxw8d71CSgcg==
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	denis.ciocca@st.com
Cc: devicetree@vger.kernel.org,
	linus.walleij@linaro.org,
	robh+dt@kernel.org,
	kauschluss@disroot.org
Subject: [PATCH] iio: accel: st_accel: add LIS2DS12
Date: Sun, 26 May 2024 14:03:02 +0530
Message-ID: <20240526083302.87172-1-kauschluss@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LIS2DS12 accelerometer by STMicroelectronics is mostly compatible
with the LIS2DE12 variant, except the WhoAmI value (0x43).

Define sensor settings for LIS2DS12, and add support in the I2C
driver.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/iio/accel/st_accel.h      |  1 +
 drivers/iio/accel/st_accel_core.c | 76 +++++++++++++++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c  |  5 ++
 3 files changed, 82 insertions(+)

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
-- 
2.45.1


