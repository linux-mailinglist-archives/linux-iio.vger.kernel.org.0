Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE5B2CBB0A
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 11:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgLBKuh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 05:50:37 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:10607 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729524AbgLBKuh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 05:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606906062;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=wFgALst/b5iWwL0gRXpR50vbfsW9fq6jVyFp8tX0Cx8=;
        b=rquZu1uqDYdCkc1TxoWjkpBH4hZAIulPnhHCTaVThEA9tmhhgLyONjQXDrApkYkQh/
        nuarQklmzIP3Hq/r/79mYD8gpymYth8sJZyO7arFOXaB5nh/o2KNJSH832jjYIpqHNAb
        WanDBqUZJkzOb+oVe19q4oHi+pliCZSJmOwKsicxW0rjwo/C2tPM5YJVs9fccmiRduQO
        T3kDbbOPJCcCXVBV++wd2BKFg9XWAC5ZF+1FK6z2fij6YZoHFJa6uwnIwMW3gD45SBrC
        x/jO60l5No9nwl35k/rjtGBygr36T9adx0M0aPrpsMKB69WW2iRcM7pv6j7C6APqgEK9
        Km0A==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB626NJkxR"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 47.3.4 SBL|AUTH)
        with ESMTPSA id Z061efwB2AldX0s
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 2 Dec 2020 11:47:39 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 2/2] iio: imu: inv_mpu6050: Add support for MPU-6880
Date:   Wed,  2 Dec 2020 11:46:56 +0100
Message-Id: <20201202104656.5119-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202104656.5119-1-stephan@gerhold.net>
References: <20201202104656.5119-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

MPU-6880 seems to be very similar to MPU-6500 and it works
fine with some minor additions for the mpu6050 driver.

Add the necessary defines for it and make it use the same registers
as MPU-6500 but with a FIFO size of 4096.

Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
I tested this on a Xiaomi Redmi 2 (or Wingtech WT88047).

Changes in v2:
  - Mention support for MPU-6880 in Kconfig
---
 drivers/iio/imu/inv_mpu6050/Kconfig        | 8 ++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 9 +++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 5 +++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 5 +++++
 5 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index 7137ea6f25db..9c625517173a 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -16,8 +16,8 @@ config INV_MPU6050_I2C
 	select REGMAP_I2C
 	help
 	  This driver supports the Invensense MPU6050/9150,
-	  MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM20602/ICM20690 and
-	  IAM20680 motion tracking devices over I2C.
+	  MPU6500/6515/6880/9250/9255, ICM20608/20609/20689, ICM20602/ICM20690
+	  and IAM20680 motion tracking devices over I2C.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-i2c.
 
@@ -28,7 +28,7 @@ config INV_MPU6050_SPI
 	select REGMAP_SPI
 	help
 	  This driver supports the Invensense MPU6000,
-	  MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM20602/ICM20690 and
-	  IAM20680 motion tracking devices over SPI.
+	  MPU6500/6515/6880/9250/9255, ICM20608/20609/20689, ICM20602/ICM20690
+	  and IAM20680 motion tracking devices over SPI.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-spi.
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 18a1898e3e34..453c51c79655 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -160,6 +160,14 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.fifo_size = 512,
 		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
 	},
+	{
+		.whoami = INV_MPU6880_WHOAMI_VALUE,
+		.name = "MPU6880",
+		.reg = &reg_set_6500,
+		.config = &chip_config_6500,
+		.fifo_size = 4096,
+		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
+	},
 	{
 		.whoami = INV_MPU6000_WHOAMI_VALUE,
 		.name = "MPU6000",
@@ -1323,6 +1331,7 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 	case INV_MPU6000:
 	case INV_MPU6500:
 	case INV_MPU6515:
+	case INV_MPU6880:
 	case INV_MPU9250:
 	case INV_MPU9255:
 		/* reset signal path (required for spi connection) */
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 28cfae1e61cf..95f16951c8f4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -177,6 +177,7 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"mpu6050", INV_MPU6050},
 	{"mpu6500", INV_MPU6500},
 	{"mpu6515", INV_MPU6515},
+	{"mpu6880", INV_MPU6880},
 	{"mpu9150", INV_MPU9150},
 	{"mpu9250", INV_MPU9250},
 	{"mpu9255", INV_MPU9255},
@@ -204,6 +205,10 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,mpu6515",
 		.data = (void *)INV_MPU6515
 	},
+	{
+		.compatible = "invensense,mpu6880",
+		.data = (void *)INV_MPU6880
+	},
 	{
 		.compatible = "invensense,mpu9150",
 		.data = (void *)INV_MPU9150
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index eb522b38acf3..58188dc0dd13 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -70,6 +70,7 @@ enum inv_devices {
 	INV_MPU6050,
 	INV_MPU6500,
 	INV_MPU6515,
+	INV_MPU6880,
 	INV_MPU6000,
 	INV_MPU9150,
 	INV_MPU9250,
@@ -373,6 +374,7 @@ struct inv_mpu6050_state {
 #define INV_MPU6000_WHOAMI_VALUE		0x68
 #define INV_MPU6050_WHOAMI_VALUE		0x68
 #define INV_MPU6500_WHOAMI_VALUE		0x70
+#define INV_MPU6880_WHOAMI_VALUE		0x78
 #define INV_MPU9150_WHOAMI_VALUE		0x68
 #define INV_MPU9250_WHOAMI_VALUE		0x71
 #define INV_MPU9255_WHOAMI_VALUE		0x73
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 6f968ce687e1..b056f3fe2561 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -70,6 +70,7 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"mpu6000", INV_MPU6000},
 	{"mpu6500", INV_MPU6500},
 	{"mpu6515", INV_MPU6515},
+	{"mpu6880", INV_MPU6880},
 	{"mpu9250", INV_MPU9250},
 	{"mpu9255", INV_MPU9255},
 	{"icm20608", INV_ICM20608},
@@ -96,6 +97,10 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,mpu6515",
 		.data = (void *)INV_MPU6515
 	},
+	{
+		.compatible = "invensense,mpu6880",
+		.data = (void *)INV_MPU6880
+	},
 	{
 		.compatible = "invensense,mpu9250",
 		.data = (void *)INV_MPU9250
-- 
2.29.2

