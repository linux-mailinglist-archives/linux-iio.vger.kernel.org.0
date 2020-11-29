Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4941F2C7886
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 10:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgK2JoO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Nov 2020 04:44:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgK2JoO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Nov 2020 04:44:14 -0500
Received: from localhost.localdomain (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FA80207BC;
        Sun, 29 Nov 2020 09:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606643013;
        bh=89Ag5QrONcS3ZLA5cd9bkcNx2xdOnFZpfnP3cIVVgCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/3oW0O17MCPx4Z9whSSDkbQqZkLMPj3Icd6wZ/U0z79Kf3+O39rpq+DETuFgYzWK
         7SoUkvE1uaN+lnZ89rI91EQughTgNmoBDZaGodyKncK4/eAwpGoI6r5py2w8A1yB++
         9MMLE6VLNd3t/ZlKpM9qN9V5bKkuGdgK3NTCwTE0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to LSM6DSOP
Date:   Sun, 29 Nov 2020 10:43:06 +0100
Message-Id: <d3c459ad945ccd1a256f4a217128be214b0c024e.1606642528.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606642528.git.lorenzo@kernel.org>
References: <cover.1606642528.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to STM LSM6DSOP (acc + gyro) Mems sensor
https://www.st.com/resource/en/datasheet/lsm6dsop.pdf

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig             | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 6 +++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    | 5 +++++
 6 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 76c7abbd1ae8..85860217aaf3 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -12,7 +12,7 @@ config IIO_ST_LSM6DSX
 	  Say yes here to build support for STMicroelectronics LSM6DSx imu
 	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
 	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr, lsm6ds3tr-c,
-	  ism330dhcx, lsm6dsrx, lsm6ds0, the accelerometer/gyroscope
+	  ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop, the accelerometer/gyroscope
 	  of lsm9ds1 and lsm6dst.
 
 	  To compile this driver as a module, choose M here: the module
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index b81da6053b3c..5ef55763a6cc 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -30,6 +30,7 @@
 #define ST_LSM6DS0_DEV_NAME	"lsm6ds0"
 #define ST_LSM6DSRX_DEV_NAME	"lsm6dsrx"
 #define ST_LSM6DST_DEV_NAME	"lsm6dst"
+#define ST_LSM6DSOP_DEV_NAME	"lsm6dsop"
 
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID,
@@ -47,6 +48,7 @@ enum st_lsm6dsx_hw_id {
 	ST_LSM6DS0_ID,
 	ST_LSM6DSRX_ID,
 	ST_LSM6DST_ID,
+	ST_LSM6DSOP_ID,
 	ST_LSM6DSX_MAX_ID,
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 49923503b75a..f1103ecedd64 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -14,7 +14,7 @@
  * (e.g. Gx, Gy, Gz, Ax, Ay, Az), then data are repeated depending on the
  * value of the decimation factor and ODR set for each FIFO data set.
  *
- * LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/LSM6DSRX/ISM330DHCX/LSM6DST:
+ * LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/LSM6DSRX/ISM330DHCX/LSM6DST/LSM6DSOP:
  * The FIFO buffer can be configured to store data from gyroscope and
  * accelerometer. Each sample is queued with a tag (1B) indicating data
  * source (gyroscope, accelerometer, hw timer).
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c05910fa0de6..467214e2e77c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -26,7 +26,7 @@
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 4KB
  *
- * - LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX/LSM6DST:
+ * - LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX/LSM6DST/LSM6DSOP:
  *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416,
  *     833
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
@@ -990,6 +990,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.hw_id = ST_ASM330LHH_ID,
 				.name = ST_ASM330LHH_DEV_NAME,
 				.wai = 0x6b,
+			}, {
+				.hw_id = ST_LSM6DSOP_ID,
+				.name = ST_LSM6DSOP_DEV_NAME,
+				.wai = 0x6c,
 			},
 		},
 		.channels = {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index e0f945dde12d..ec8d4351390a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -98,6 +98,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,lsm6dst",
 		.data = (void *)ST_LSM6DST_ID,
 	},
+	{
+		.compatible = "st,lsm6dsop",
+		.data = (void *)ST_LSM6DSOP_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
@@ -118,6 +122,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_LSM6DS0_DEV_NAME, ST_LSM6DS0_ID },
 	{ ST_LSM6DSRX_DEV_NAME, ST_LSM6DSRX_ID },
 	{ ST_LSM6DST_DEV_NAME, ST_LSM6DST_ID },
+	{ ST_LSM6DSOP_DEV_NAME, ST_LSM6DSOP_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index c57895be8afe..349ec9c1890d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -98,6 +98,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,lsm6dst",
 		.data = (void *)ST_LSM6DST_ID,
 	},
+	{
+		.compatible = "st,lsm6dsop",
+		.data = (void *)ST_LSM6DSOP_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
@@ -118,6 +122,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_LSM6DS0_DEV_NAME, ST_LSM6DS0_ID },
 	{ ST_LSM6DSRX_DEV_NAME, ST_LSM6DSRX_ID },
 	{ ST_LSM6DST_DEV_NAME, ST_LSM6DST_ID },
+	{ ST_LSM6DSOP_DEV_NAME, ST_LSM6DSOP_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
-- 
2.28.0

