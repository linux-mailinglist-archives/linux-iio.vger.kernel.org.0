Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377A42CBA6D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 11:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgLBKSc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 05:18:32 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:35078 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbgLBKSc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 05:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606904137;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=8WxxH3T9uH57AYrirrvN7p1x1i+whQJhaNX94BhwbOo=;
        b=daCgMV/6gxb2amANVAa+hBAorKMglO73e7FzNmqsnthE923TOnL0e1FxZmQrw0lu7B
        IBlfynAZiy5l9F4IPpKvtgPE4eaeycptILAPXySb81AIxHsAggqFWqzz/Xg3kOs6Osic
        cnwAZlPDUT5ta01cFDftUZHRX7IZ7/DN1Ur8vb/CnhEsR5VdF7vzUvUKCI0mlV+z+K67
        FPCU1xa6bTsYUlIFCubCOhh2tlwXsbRcEbMHqgc+PLr35qs2uPYpI+MkuJioYThdrTnp
        CQXwD50ozpihyBS+/lYuIgHNBOzA7qx4thk/jWAFTKP+HxWNntTK3I2SETZ9knf57GfU
        LgOw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB626NJkxR"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 47.3.4 SBL|AUTH)
        with ESMTPSA id Z061efwB2AFUWXb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 2 Dec 2020 11:15:30 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/2] iio: imu: inv_mpu6050: Add support for MPU-6880
Date:   Wed,  2 Dec 2020 11:13:55 +0100
Message-Id: <20201202101355.87112-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202101355.87112-1-stephan@gerhold.net>
References: <20201202101355.87112-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

MPU-6880 seems to be very similar to MPU-6500 / MPU-6050 and it works
fine with some minor additions for the mpu6050 driver.

Add the necessary defines for it and make it use the same registers as
MPU-6500 but with a FIFO size of 4096.

Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
I tested this on a Xiaomi Redmi 2 (or Wingtech WT88047).

Unfortunately I was not able to find a proper register description
for MPU-6880. :( It seems to work fine with both 6050 or 6500 registers
but I guess that it is more similar to MPU-6500. Not sure though.

I'm mainly unsure about
	.accl_offset		= INV_MPU6500_REG_ACCEL_OFFSET,
vs
	.accl_offset		= INV_MPU6050_REG_ACCEL_OFFSET,

Both registers read some funny values but I cannot say which one
is more appropriate...

Perhaps Jean-Baptiste can shed some light on this? :)
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 9 +++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 5 +++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 5 +++++
 4 files changed, 21 insertions(+)

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

