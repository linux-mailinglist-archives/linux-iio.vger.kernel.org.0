Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4563B197E4E
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 16:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgC3O0d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 10:26:33 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:49661 "EHLO
        smtpout1.mo529.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727899AbgC3O0d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 10:26:33 -0400
Received: from DAG2EX1.mxp2.local (unknown [10.108.4.98])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 631562BB9042;
        Mon, 30 Mar 2020 16:19:39 +0200 (CEST)
Received: from gaetanandre.eu (37.59.142.105) by DAG2EX1.mxp2.local
 (172.16.2.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 30 Mar
 2020 16:19:38 +0200
From:   =?UTF-8?q?Ga=C3=ABtan=20Andr=C3=A9?= <rvlander@gaetanandre.eu>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        =?UTF-8?q?Ga=C3=ABtan=20Andr=C3=A9?= <rvlander@gaetanandre.eu>
Subject: [PATCH 2/2] iio: accel: st_sensors:  add support for LIS2HH12
Date:   Mon, 30 Mar 2020 16:19:23 +0200
Message-ID: <20200330141923.280226-2-rvlander@gaetanandre.eu>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200330141923.280226-1-rvlander@gaetanandre.eu>
References: <20200330141923.280226-1-rvlander@gaetanandre.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG3EX2.mxp2.local (172.16.2.6) To DAG2EX1.mxp2.local
 (172.16.2.3)
X-Ovh-Tracer-GUID: b16f366e-b63f-48ca-8e8a-b87c52f15bf8
X-Ovh-Tracer-Id: 18445336701414359203
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofgjfhggtgfgihesthekredtredtjeenucfhrhhomhepifgrtohtrghnucetnhgurhoruceorhhvlhgrnhguvghrsehgrggvthgrnhgrnhgurhgvrdgvuheqnecuffhomhgrihhnpehsthdrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopefftefivdfgigdurdhmgihpvddrlhhotggrlhdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhhvlhgrnhguvghrsehgrggvthgrnhgrnhgurhgvrdgvuhdprhgtphhtthhopehrvhhlrghnuggvrhesghgrvghtrghnrghnughrvgdrvghu
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for STMicroelectronics LISHH12 accelerometer in st_accel
framework.

https://www.st.com/resource/en/datasheet/lis2hh12.pdf

Signed-off-by: Gaëtan André <rvlander@gaetanandre.eu>
---
 drivers/iio/accel/Kconfig         |  2 +-
 drivers/iio/accel/st_accel.h      |  2 +
 drivers/iio/accel/st_accel_core.c | 77 +++++++++++++++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c  |  5 ++
 4 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 5d91a6dda894..24ebe9e76915 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -238,7 +238,7 @@ config IIO_ST_ACCEL_3AXIS
 	  Say yes here to build support for STMicroelectronics accelerometers:
 	  LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
 	  LIS331DLH, LSM303DL, LSM303DLM, LSM330, LIS2DH12, H3LIS331DL,
-	  LNG2DM, LIS3DE, LIS2DE12
+	  LNG2DM, LIS3DE, LIS2DE12, LIS2HH12
 
 	  This driver can also be built as a module. If so, these modules
 	  will be created:
diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 5b13e293cade..5d356288e001 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -35,6 +35,7 @@ enum st_accel_type {
 	LIS2DW12,
 	LIS3DHH,
 	LIS2DE12,
+	LIS2HH12,
 	ST_ACCEL_MAX,
 };
 
@@ -59,6 +60,7 @@ enum st_accel_type {
 #define LIS3DHH_ACCEL_DEV_NAME		"lis3dhh"
 #define LIS3DE_ACCEL_DEV_NAME		"lis3de"
 #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
+#define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
 
 /**
 * struct st_sensors_platform_data - default accel platform data
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index e2ec5d127495..43c50167d220 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -904,6 +904,83 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
+	{
+		.wai = 0x41,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = LIS2HH12_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_16bit_channels,
+		.odr = {
+			.addr = 0x20,
+			.mask = 0x70,
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
+			.mask = 0x70,
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
+			},
+		},
+		.bdu = {
+			.addr = 0x20,
+			.mask = 0x08,
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x22,
+				.mask = 0x01,
+			},
+			.int2 = {
+				.addr = 0x25,
+				.mask = 0x01,
+			},
+			.addr_ihl = 0x24,
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
 };
 
 static int st_accel_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 8c489312f668..821854251a7b 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -104,6 +104,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lis2de12",
 		.data = LIS2DE12_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "st,lis2hh12",
+		.data = LIS2HH12_ACCEL_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -138,6 +142,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LIS2DW12_ACCEL_DEV_NAME },
 	{ LIS3DE_ACCEL_DEV_NAME },
 	{ LIS2DE12_ACCEL_DEV_NAME },
+	{ LIS2HH12_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
-- 
2.26.0

