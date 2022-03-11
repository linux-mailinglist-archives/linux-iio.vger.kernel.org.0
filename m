Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93DF4D65EA
	for <lists+linux-iio@lfdr.de>; Fri, 11 Mar 2022 17:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350157AbiCKQTx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Mar 2022 11:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240035AbiCKQTw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Mar 2022 11:19:52 -0500
Received: from mxd1.seznam.cz (mxd1.seznam.cz [IPv6:2a02:598:a::78:210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E01D1CD7E6;
        Fri, 11 Mar 2022 08:18:45 -0800 (PST)
Received: from email.seznam.cz
        by email-smtpc21b.ko.seznam.cz (email-smtpc21b.ko.seznam.cz [10.53.18.27])
        id 732ddcdc282388b572841082;
        Fri, 11 Mar 2022 17:18:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1647015502; bh=+SW7gvP/Lj8jgIjjy9F4j1gSQrTfgZOYTRmKc2+iewE=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:X-szn-frgn:
         X-szn-frgc;
        b=AA8YgM41U/reS56yOeHlVqGucN3innKpwQtCIqMEr18w4SE27EE+oybUpVgw5Wkbp
         nst9MqQGirDAtGJQwRLnSqz8fH9Oaw/iN8E0pDECpwJH4M6biz4ZpwhDxVbME5py+u
         qEiKnU40B4HnA2Q2+VMLyPFna+VcdOx9eXnvOe2s=
Received: from localhost.localdomain (ip-111-27.static.ccinternet.cz [147.161.27.111])
        by email-relay29.ko.seznam.cz (Seznam SMTPD 1.3.136) with ESMTP;
        Fri, 11 Mar 2022 17:18:17 +0100 (CET)  
From:   michael.srba@seznam.cz
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Srba <Michael.Srba@seznam.cz>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v2 2/2] iio: imu: inv_mpu6050: Add support for ICM-20608-D
Date:   Fri, 11 Mar 2022 17:16:00 +0100
Message-Id: <20220311161600.1469-3-michael.srba@seznam.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311161600.1469-1-michael.srba@seznam.cz>
References: <20220311161600.1469-1-michael.srba@seznam.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-szn-frgn: <277e48de-6894-46fe-a3ab-fdc9f1a88712>
X-szn-frgc: <0>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Michael Srba <Michael.Srba@seznam.cz>

The difference between the ICM-20608-D and the other ICM-20608
variants is the addition of a DMP (Digital Motion Processor) core.
This difference is deemed substantial enough to change the WHOAMI
register value.
Since this driver doesn't currently acknowledge the exisence of
something like a DMP core, simply copy ICM-20608 except for the
aforementioned WHOAMI register.

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
changes:
 - v2: none
---
 drivers/iio/imu/inv_mpu6050/Kconfig        | 4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 9 +++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 6 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 5 +++++
 5 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index 9c625517173a..3636b1bc90f1 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -16,7 +16,7 @@ config INV_MPU6050_I2C
 	select REGMAP_I2C
 	help
 	  This driver supports the Invensense MPU6050/9150,
-	  MPU6500/6515/6880/9250/9255, ICM20608/20609/20689, ICM20602/ICM20690
+	  MPU6500/6515/6880/9250/9255, ICM20608(D)/20609/20689, ICM20602/ICM20690
 	  and IAM20680 motion tracking devices over I2C.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-i2c.
@@ -28,7 +28,7 @@ config INV_MPU6050_SPI
 	select REGMAP_SPI
 	help
 	  This driver supports the Invensense MPU6000,
-	  MPU6500/6515/6880/9250/9255, ICM20608/20609/20689, ICM20602/ICM20690
+	  MPU6500/6515/6880/9250/9255, ICM20608(D)/20609/20689, ICM20602/ICM20690
 	  and IAM20680 motion tracking devices over SPI.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-spi.
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 597768c29a72..86fbbe904050 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -217,6 +217,15 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
 		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
 	},
+	{
+		.whoami = INV_ICM20608D_WHOAMI_VALUE,
+		.name = "ICM20608D",
+		.reg = &reg_set_6500,
+		.config = &chip_config_6500,
+		.fifo_size = 512,
+		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
+	},
 	{
 		.whoami = INV_ICM20609_WHOAMI_VALUE,
 		.name = "ICM20609",
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index fe03707ec2d3..ed52b27409ac 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -29,6 +29,7 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)
 
 	switch (st->chip_type) {
 	case INV_ICM20608:
+	case INV_ICM20608D:
 	case INV_ICM20609:
 	case INV_ICM20689:
 	case INV_ICM20602:
@@ -182,6 +183,7 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"mpu9250", INV_MPU9250},
 	{"mpu9255", INV_MPU9255},
 	{"icm20608", INV_ICM20608},
+	{"icm20608d", INV_ICM20608D},
 	{"icm20609", INV_ICM20609},
 	{"icm20689", INV_ICM20689},
 	{"icm20602", INV_ICM20602},
@@ -225,6 +227,10 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,icm20608",
 		.data = (void *)INV_ICM20608
 	},
+	{
+		.compatible = "invensense,icm20608d",
+		.data = (void *)INV_ICM20608D
+	},
 	{
 		.compatible = "invensense,icm20609",
 		.data = (void *)INV_ICM20609
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index c6aa36ee966a..8e14f20b1314 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -76,6 +76,7 @@ enum inv_devices {
 	INV_MPU9250,
 	INV_MPU9255,
 	INV_ICM20608,
+	INV_ICM20608D,
 	INV_ICM20609,
 	INV_ICM20689,
 	INV_ICM20602,
@@ -394,6 +395,7 @@ struct inv_mpu6050_state {
 #define INV_MPU9255_WHOAMI_VALUE		0x73
 #define INV_MPU6515_WHOAMI_VALUE		0x74
 #define INV_ICM20608_WHOAMI_VALUE		0xAF
+#define INV_ICM20608D_WHOAMI_VALUE		0xAE
 #define INV_ICM20609_WHOAMI_VALUE		0xA6
 #define INV_ICM20689_WHOAMI_VALUE		0x98
 #define INV_ICM20602_WHOAMI_VALUE		0x12
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 6800356b25fb..ce8ab6db2bf2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -74,6 +74,7 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"mpu9250", INV_MPU9250},
 	{"mpu9255", INV_MPU9255},
 	{"icm20608", INV_ICM20608},
+	{"icm20608d", INV_ICM20608D},
 	{"icm20609", INV_ICM20609},
 	{"icm20689", INV_ICM20689},
 	{"icm20602", INV_ICM20602},
@@ -113,6 +114,10 @@ static const struct of_device_id inv_of_match[] = {
 		.compatible = "invensense,icm20608",
 		.data = (void *)INV_ICM20608
 	},
+	{
+		.compatible = "invensense,icm20608d",
+		.data = (void *)INV_ICM20608D
+	},
 	{
 		.compatible = "invensense,icm20609",
 		.data = (void *)INV_ICM20609
-- 
2.34.1

