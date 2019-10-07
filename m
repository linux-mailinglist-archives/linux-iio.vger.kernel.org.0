Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA48FCDE63
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 11:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfJGJny (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 05:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfJGJny (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 05:43:54 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6563217D6;
        Mon,  7 Oct 2019 09:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570441433;
        bh=V/xJInUaTqH0Ti1PbLKHQWaFX7Iyr/onGP8eMynPRvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTPM+S6VeouhHfrvyfD7UI2/IcP7RHhMnwJR/vRn49x66NZno8neKziCBLzqH+XxC
         NNq0qoz9yiyCvPr4Iymxf/M1URqdlXMAvF/jQZl6wOXystUaFimShAfnij8eTGCK16
         VHsrLsLUStSzwM9w8/7wvSLF+udPqYu1BbX9MdZg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, martin@geanix.com,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to LSM6DS0
Date:   Mon,  7 Oct 2019 11:43:37 +0200
Message-Id: <bd3019f35dc743b0da6efc57d261c3484b978f72.1570441034.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570441034.git.lorenzo@kernel.org>
References: <cover.1570441034.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to STM LSM6DS0 6-axis (acc + gyro) Mems sensor

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig           | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 5 ++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  | 5 +++++
 5 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 77aa0e77212d..b425a356d99e 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -12,7 +12,7 @@ config IIO_ST_LSM6DSX
 	  Say yes here to build support for STMicroelectronics LSM6DSx imu
 	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
 	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr, lsm6ds3tr-c,
-	  ism330dhcx and the accelerometer/gyroscope of lsm9ds1.
+	  ism330dhcx, lsm6ds0 and the accelerometer/gyroscope of lsm9ds1.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm6dsx.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 40532f99ba4b..74854230aecf 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -26,6 +26,7 @@
 #define ST_LSM6DS3TRC_DEV_NAME	"lsm6ds3tr-c"
 #define ST_ISM330DHCX_DEV_NAME	"ism330dhcx"
 #define ST_LSM9DS1_DEV_NAME	"lsm9ds1-imu"
+#define ST_LSM6DS0_DEV_NAME	"lsm6ds0"
 
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID,
@@ -40,6 +41,7 @@ enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3TRC_ID,
 	ST_ISM330DHCX_ID,
 	ST_LSM9DS1_ID,
+	ST_LSM6DS0_ID,
 	ST_LSM6DSX_MAX_ID,
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index e8c3922f1b59..bacc908cf396 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -32,7 +32,7 @@
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 3KB
  *
- * - LSM9DS1:
+ * - LSM9DS1/LSM6DS0:
  *   - Accelerometer supported ODR [Hz]: 10, 50, 119, 238, 476, 952
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported ODR [Hz]: 15, 60, 119, 238, 476, 952
@@ -104,6 +104,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			{
 				.hw_id = ST_LSM9DS1_ID,
 				.name = ST_LSM9DS1_DEV_NAME,
+			}, {
+				.hw_id = ST_LSM6DS0_ID,
+				.name = ST_LSM6DS0_DEV_NAME,
 			},
 		},
 		.channels = {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index f52511059545..e57744affbd0 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -87,6 +87,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,lsm9ds1-imu",
 		.data = (void *)ST_LSM9DS1_ID,
 	},
+	{
+		.compatible = "st,lsm6ds0",
+		.data = (void *)ST_LSM6DS0_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
@@ -104,6 +108,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
 	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
 	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
+	{ ST_LSM6DS0_DEV_NAME, ST_LSM6DS0_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 344b28dddebb..933d4f9f6a4a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -87,6 +87,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,lsm9ds1-imu",
 		.data = (void *)ST_LSM9DS1_ID,
 	},
+	{
+		.compatible = "st,lsm6ds0",
+		.data = (void *)ST_LSM6DS0_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
@@ -104,6 +108,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
 	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
 	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
+	{ ST_LSM6DS0_DEV_NAME, ST_LSM6DS0_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
-- 
2.21.0

