Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137496F7C8B
	for <lists+linux-iio@lfdr.de>; Fri,  5 May 2023 07:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjEEFts (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 May 2023 01:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjEEFtn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 May 2023 01:49:43 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A4611D96;
        Thu,  4 May 2023 22:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683265774;
  x=1714801774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cDIBRX8Ulk8P+kDO+DNb87Xtv4IZjVGMishO+Kq42zY=;
  b=i4K+PgPjwlObV0Y5cW/BW6Kv1ynf/QChun7ZvoJVfDmtwEeMXDw3xZO+
   U9lfhVQrO/ac+YgNEs3Z0LoveHE27knZIRnxMUoMUiggOJP7wSgqB4lcF
   +EUvp4wmkbPtzMkYaOeqQxm13vgNQAyjjfO9B2lBs1tCF9w2vfo+IwZgW
   Byj8cJBCnLCUOlC2S0o9zBHmfafrhJqU//bKDAxPN8b4D+M/yZnNJSN4A
   B/OQQnBAsE22c0hbinHHQ9rnMt7I7g022psvsCM8OIlF1jfubRyGNenUW
   Tjux1ChiogQe80/wG5qOs7tJwcwj2GZptQMVSxyYDSAKpuqT8sElxmwZ7
   w==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <jmaneyrol@invensense.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 2/2] iio: imu: mpu6050: Add support for the ICM 20600 IMU
Date:   Fri, 5 May 2023 13:48:53 +0800
Message-ID: <20230505054853.2155326-3-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230505054853.2155326-1-chenhuiz@axis.com>
References: <20230505054853.2155326-1-chenhuiz@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Invensense ICM-20600 is a 6-axis MotionTracking device that combines a
3-axis gyroscope and an 3-axis accelerometer. It is very similar to the
ICM20602 imu which is already supported by the mpu6050 driver. The main
difference is that the ICM-20600 has a different WHOAMI value.

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---
 drivers/iio/imu/inv_mpu6050/Kconfig        |  4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 10 ++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  6 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  5 +++++
 5 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index 3636b1bc90f1..64dd73dcc4ba 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -16,7 +16,7 @@ config INV_MPU6050_I2C
 	select REGMAP_I2C
 	help
 	  This driver supports the Invensense MPU6050/9150,
-	  MPU6500/6515/6880/9250/9255, ICM20608(D)/20609/20689, ICM20602/ICM20690
+	  MPU6500/6515/6880/9250/9255, ICM20608(D)/20609/20689, ICM20600/20602/20690
 	  and IAM20680 motion tracking devices over I2C.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-i2c.
@@ -28,7 +28,7 @@ config INV_MPU6050_SPI
 	select REGMAP_SPI
 	help
 	  This driver supports the Invensense MPU6000,
-	  MPU6500/6515/6880/9250/9255, ICM20608(D)/20609/20689, ICM20602/ICM20690
+	  MPU6500/6515/6880/9250/9255, ICM20608(D)/20609/20689, ICM20600/20602/20690
 	  and IAM20680 motion tracking devices over SPI.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-spi.
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 8a129120b73d..592a6e60b413 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -244,6 +244,15 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
 		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
 	},
+	{
+		.whoami = INV_ICM20600_WHOAMI_VALUE,
+		.name = "ICM20600",
+		.reg = &reg_set_icm20602,
+		.config = &chip_config_6500,
+		.fifo_size = 1008,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_ICM20602_GYRO_STARTUP_TIME, INV_ICM20602_ACCEL_STARTUP_TIME},
+	},
 	{
 		.whoami = INV_ICM20602_WHOAMI_VALUE,
 		.name = "ICM20602",
@@ -1597,6 +1606,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		indio_dev->num_channels = ARRAY_SIZE(inv_mpu9250_channels);
 		indio_dev->available_scan_masks = inv_mpu9x50_scan_masks;
 		break;
+	case INV_ICM20600:
 	case INV_ICM20602:
 		indio_dev->channels = inv_mpu_channels;
 		indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 2f2da4cb7321..0e39877678df 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -32,6 +32,7 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)
 	case INV_ICM20608D:
 	case INV_ICM20609:
 	case INV_ICM20689:
+	case INV_ICM20600:
 	case INV_ICM20602:
 	case INV_IAM20680:
 		/* no i2c auxiliary bus on the chip */
@@ -183,6 +184,7 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"icm20608d", INV_ICM20608D},
 	{"icm20609", INV_ICM20609},
 	{"icm20689", INV_ICM20689},
+	{"icm20600", INV_ICM20600},
 	{"icm20602", INV_ICM20602},
 	{"icm20690", INV_ICM20690},
 	{"iam20680", INV_IAM20680},
@@ -236,6 +238,10 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,icm20689",
 		.data = (void *)INV_ICM20689
 	},
+	{
+		.compatible = "invensense,icm20600",
+		.data = (void *)INV_ICM20600
+	},
 	{
 		.compatible = "invensense,icm20602",
 		.data = (void *)INV_ICM20602
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 94b54c501ec0..b4ab2c397d0f 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -79,6 +79,7 @@ enum inv_devices {
 	INV_ICM20608D,
 	INV_ICM20609,
 	INV_ICM20689,
+	INV_ICM20600,
 	INV_ICM20602,
 	INV_ICM20690,
 	INV_IAM20680,
@@ -398,6 +399,7 @@ struct inv_mpu6050_state {
 #define INV_ICM20608D_WHOAMI_VALUE		0xAE
 #define INV_ICM20609_WHOAMI_VALUE		0xA6
 #define INV_ICM20689_WHOAMI_VALUE		0x98
+#define INV_ICM20600_WHOAMI_VALUE		0x11
 #define INV_ICM20602_WHOAMI_VALUE		0x12
 #define INV_ICM20690_WHOAMI_VALUE		0x20
 #define INV_IAM20680_WHOAMI_VALUE		0xA9
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 89f46c2f213d..05451ca1580b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -76,6 +76,7 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"icm20608d", INV_ICM20608D},
 	{"icm20609", INV_ICM20609},
 	{"icm20689", INV_ICM20689},
+	{"icm20600", INV_ICM20600},
 	{"icm20602", INV_ICM20602},
 	{"icm20690", INV_ICM20690},
 	{"iam20680", INV_IAM20680},
@@ -125,6 +126,10 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,icm20689",
 		.data = (void *)INV_ICM20689
 	},
+	{
+		.compatible = "invensense,icm20600",
+		.data = (void *)INV_ICM20600
+	},
 	{
 		.compatible = "invensense,icm20602",
 		.data = (void *)INV_ICM20602
-- 
2.30.2

