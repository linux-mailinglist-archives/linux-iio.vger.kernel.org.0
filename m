Return-Path: <linux-iio+bounces-6718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB0C9133F9
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 14:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28361F232BD
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86B216DEBD;
	Sat, 22 Jun 2024 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="LetzEit2"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E878314B97A;
	Sat, 22 Jun 2024 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719059822; cv=none; b=dIiY67Al5an0QJHnzm09B8HirRkHOwQQ6r24/9aWttpN9iMMcAurfoNeUlOjUwMTP/so8ZHf2Iqf86hHKGiGODT/kIxMZvqvBIcbNGsuCLahvCvU8qaF/yCh2bLyztMRGlFgosfHzRPs2eFrbBCwwy0jcroHOIxTSVYd6Jct/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719059822; c=relaxed/simple;
	bh=h7whw2AYyqsNwF3U1uayY34akXxwQgj4aLRDnufhU30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYcirar2/iOHgSe3MyRTQu9EPpF9LoTg5RWygZexz/NlkdOVi+GMNc+MsLadvjMizGBi19RgNXQnGrgUKkFzrm0uaGS48eX+ZOV2Dr5pnkQd9MLkE4KdyS1+19+00x+3sTC0rh/FfLSNrOX5x5US/CtrQtw5FG7ACy9fCfprWH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=LetzEit2; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1719059809; bh=h7whw2AYyqsNwF3U1uayY34akXxwQgj4aLRDnufhU30=;
	h=From:To:Cc:Subject:Date;
	b=LetzEit217K8UR7WrWhaKJpHe7GjdnOlCg9PFcFYnsT4bDBHG2an60rDLSYdFzGkb
	 TpXLsw0kH29fJSlWtARUHmHzvRMbD3AFF8bYUdSKwO/duJ9aE1QbOJs8cE+Vl1G1ZI
	 eKP8P6Rx4OXitJQCvrrd6BH1UZCdZDcSKaLrzmqu82tnRB1bwRhpWh4O3owM+hrtU4
	 te05FFlzi9QmIspLCE8NY/jTRBwXXx2BDvDg2wZe7/NtdOZ6rF8IichJRN8rZytlmM
	 3pDqRXVzp7NT6lWttnkLpYULmUZB695WQ/7qaGw+ZsMFOib/C0RU138w0kZRUBI+rK
	 VwbRyBCDk1gsQ==
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	denis.ciocca@st.com
Cc: devicetree@vger.kernel.org,
	linus.walleij@linaro.org,
	robh+dt@kernel.org,
	kauschluss@disroot.org
Subject: [PATCH v5 1/2] iio: accel: st_accel: add support for LIS2DS12
Date: Sat, 22 Jun 2024 18:03:45 +0530
Message-ID: <20240622123520.39253-1-kauschluss@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define sensor settings for LIS2DS12 by STMicroelectronics (WhoAmI 0x43)
and add support in the I2C and SPI drivers.

Datasheet: https://www.st.com/resource/en/datasheet/lis2ds12.pdf

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v5:
- clarify incompatibility with other devices in description

v4: https://lore.kernel.org/linux-iio/20240611160821.13941-1-kauschluss@disroot.org/
Changes in v4:
- add compatible string to documentation
- correct register addresses and settings

v3: https://lore.kernel.org/linux-iio/20240601192914.141906-1-kauschluss@disroot.org/
Changes in v3:
- fix code formatting

v2: https://lore.kernel.org/linux-iio/20240601183233.118397-1-kauschluss@disroot.org/
Changes in v2:
- add SPI support
- link datasheet in commit description

v1: https://lore.kernel.org/linux-iio/20240526083302.87172-1-kauschluss@disroot.org/
---
 drivers/iio/accel/st_accel.h      |  1 +
 drivers/iio/accel/st_accel_core.c | 81 +++++++++++++++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c  |  5 ++
 drivers/iio/accel/st_accel_spi.c  |  5 ++
 4 files changed, 92 insertions(+)

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
index d2104e14e255..0e371efbda70 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -925,6 +925,87 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
+	{
+		.wai = 0x43,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = LIS2DS12_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_16bit_channels,
+		.odr = {
+			.addr = 0x20,
+			.mask = 0xf0,
+			.odr_avl = {
+				{ .hz = 10, .value = 0x01, },
+				{ .hz = 50, .value = 0x02, },
+				{ .hz = 100, .value = 0x03, },
+				{ .hz = 200, .value = 0x04, },
+				{ .hz = 400, .value = 0x05, },
+				{ .hz = 800, .value = 0x06, },
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
+			.addr = 0x20,
+			.mask = 0x0c,
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_2G,
+					.value = 0x00,
+					.gain = IIO_G_TO_M_S_2(61),
+				},
+				[1] = {
+					.num = ST_ACCEL_FS_AVL_4G,
+					.value = 0x02,
+					.gain = IIO_G_TO_M_S_2(122),
+				},
+				[2] = {
+					.num = ST_ACCEL_FS_AVL_8G,
+					.value = 0x03,
+					.gain = IIO_G_TO_M_S_2(244),
+				},
+				[3] = {
+					.num = ST_ACCEL_FS_AVL_16G,
+					.value = 0x01,
+					.gain = IIO_G_TO_M_S_2(488),
+				},
+			},
+		},
+		.bdu = {
+			.addr = 0x20,
+			.mask = 0x01,
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x23,
+				.mask = 0x01,
+			},
+			.int2 = {
+				.addr = 0x24,
+				.mask = 0x01,
+			},
+			.addr_ihl = 0x22,
+			.mask_ihl = 0x02,
+			.stat_drdy = {
+				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
+				.mask = 0x01,
+			},
+		},
+		.sim = {
+			.addr = 0x21,
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


