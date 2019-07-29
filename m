Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC4793B4
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2019 21:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfG2TXB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 15:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfG2TXB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Jul 2019 15:23:01 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.59.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4E562070B;
        Mon, 29 Jul 2019 19:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428179;
        bh=TRj/ssDcMSVFt6+u8XPqJCyyT0IJhKAhELwFvT07pQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pP7FsePRKZfYIbTxCTPh89POOiqs7+9b9rA3Y+ijAVhSxPssdhb9rnWwf6ZfcoQfe
         JGqAayhMqLrmhrC5Nn0EEqEO2Yya+EetyI4mFSb53yIAeSNE7wYjwIbjy349YdajbU
         vo2uDjeQczvVXWtgK2qmyMtW/3UbGhq4Gv4RhJ18=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        martin.kepplinger@puri.sm
Subject: [PATCH v2 4/4] iio: imu: st_lsm6dsx: move iio chan definitions in st_lsm6dsx_sensor_settings
Date:   Mon, 29 Jul 2019 21:22:31 +0200
Message-Id: <f4adc084ad92c1c31c2ed9cc748321c29e457c1c.1564427804.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564427804.git.lorenzo@kernel.org>
References: <cover.1564427804.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move IIO channel definitions in st_lsm6dsx_sensor_settings in order to
support sensors with different channels maps.
This is a preliminary patch to add support for LSM9DS1 sensor to
st_lsm6dsx driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 96 ++++++++++++++++----
 2 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index ab1c66615d67..5090f1b3525a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -200,6 +200,7 @@ struct st_lsm6dsx_ext_dev_settings {
  * @wai: Sensor WhoAmI default value.
  * @max_fifo_size: Sensor max fifo length in FIFO words.
  * @id: List of hw id/device name supported by the driver configuration.
+ * @channels: IIO channels supported by the device.
  * @odr_table: Hw sensors odr table (Hz + val).
  * @fs_table: Hw sensors gain table (gain + val).
  * @decimator: List of decimator register info (addr + mask).
@@ -215,6 +216,10 @@ struct st_lsm6dsx_settings {
 		enum st_lsm6dsx_hw_id hw_id;
 		const char *name;
 	} id[ST_LSM6DSX_MAX_ID];
+	struct {
+		const struct iio_chan_spec *chan;
+		int len;
+	} channels[2];
 	struct st_lsm6dsx_odr_table_entry odr_table[2];
 	struct st_lsm6dsx_fs_table_entry fs_table[2];
 	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 0abd5b85b398..fc4d18b58c97 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -61,6 +61,20 @@
 #define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR	0x13
 #define ST_LSM6DSX_REG_INT2_ON_INT1_MASK	BIT(5)
 
+static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
+	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
+	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
+	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
+	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x22, IIO_MOD_X, 0),
+	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x24, IIO_MOD_Y, 1),
+	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x26, IIO_MOD_Z, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	{
 		.wai = 0x69,
@@ -71,6 +85,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.name = ST_LSM6DS3_DEV_NAME,
 			},
 		},
+		.channels = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.chan = st_lsm6dsx_acc_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.chan = st_lsm6dsx_gyro_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
+			},
+		},
 		.odr_table = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.reg = {
@@ -169,6 +193,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.name = ST_LSM6DS3H_DEV_NAME,
 			},
 		},
+		.channels = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.chan = st_lsm6dsx_acc_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.chan = st_lsm6dsx_gyro_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
+			},
+		},
 		.odr_table = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.reg = {
@@ -276,6 +310,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.name = ST_LSM6DS3TRC_DEV_NAME,
 			},
 		},
+		.channels = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.chan = st_lsm6dsx_acc_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.chan = st_lsm6dsx_gyro_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
+			},
+		},
 		.odr_table = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.reg = {
@@ -377,6 +421,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.name = ST_LSM6DSOX_DEV_NAME,
 			},
 		},
+		.channels = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.chan = st_lsm6dsx_acc_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.chan = st_lsm6dsx_gyro_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
+			},
+		},
 		.odr_table = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.reg = {
@@ -493,6 +547,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.name = ST_ASM330LHH_DEV_NAME,
 			},
 		},
+		.channels = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.chan = st_lsm6dsx_acc_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.chan = st_lsm6dsx_gyro_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
+			},
+		},
 		.odr_table = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.reg = {
@@ -583,6 +647,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.name = ST_LSM6DSR_DEV_NAME,
 			},
 		},
+		.channels = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.chan = st_lsm6dsx_acc_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.chan = st_lsm6dsx_gyro_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
+			},
+		},
 		.odr_table = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.reg = {
@@ -692,20 +766,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 };
 
-static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
-	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
-	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
-	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
-};
-
-static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
-	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x22, IIO_MOD_X, 0),
-	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x24, IIO_MOD_Y, 1),
-	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x26, IIO_MOD_Z, 2),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
-};
-
 int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable)
 {
 	const struct st_lsm6dsx_shub_settings *hub_settings;
@@ -1263,6 +1323,8 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	iio_dev->modes = INDIO_DIRECT_MODE;
 	iio_dev->dev.parent = hw->dev;
 	iio_dev->available_scan_masks = st_lsm6dsx_available_scan_masks;
+	iio_dev->channels = hw->settings->channels[id].chan;
+	iio_dev->num_channels = hw->settings->channels[id].len;
 
 	sensor = iio_priv(iio_dev);
 	sensor->id = id;
@@ -1273,18 +1335,12 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 
 	switch (id) {
 	case ST_LSM6DSX_ID_ACC:
-		iio_dev->channels = st_lsm6dsx_acc_channels;
-		iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_acc_channels);
 		iio_dev->info = &st_lsm6dsx_acc_info;
-
 		scnprintf(sensor->name, sizeof(sensor->name), "%s_accel",
 			  name);
 		break;
 	case ST_LSM6DSX_ID_GYRO:
-		iio_dev->channels = st_lsm6dsx_gyro_channels;
-		iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_gyro_channels);
 		iio_dev->info = &st_lsm6dsx_gyro_info;
-
 		scnprintf(sensor->name, sizeof(sensor->name), "%s_gyro",
 			  name);
 		break;
-- 
2.21.0

