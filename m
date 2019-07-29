Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 348E3793B2
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2019 21:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfG2TWu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 15:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729364AbfG2TWu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Jul 2019 15:22:50 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.59.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42B5620C01;
        Mon, 29 Jul 2019 19:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428169;
        bh=G0ciTASPa04H8WS/FBgRX72BsS/ILc5/5xQ5keR9xjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdwtUcWvI81kgoXBTAozieFqrVmOVV+X30SwCYwtrWQcbliVDhtE0tjJMGvqLYGRW
         bkw7bu6LH3/ralpmPjmD7RZKsjmaeMv7Tss8duDwOm3StwYi+qVJfJ35lQOaP4HZ7e
         mqtoT431OYCiIU7kRY6StTMjF2d6YdtwJ9IEO4/w=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        martin.kepplinger@puri.sm
Subject: [PATCH v2 2/4] iio: imu: st_lsm6dsx: move fs_table in st_lsm6dsx_sensor_settings
Date:   Mon, 29 Jul 2019 21:22:29 +0200
Message-Id: <9f290ea02b9e878c20cc57880d506acf03bf8ff0.1564427804.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564427804.git.lorenzo@kernel.org>
References: <cover.1564427804.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move fs_table in st_lsm6dsx_sensor_settings in order to support
sensors with different gain maps. This is a preliminary patch to add
support for LSM9DS1 sensor to st_lsm6dsx driver

Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 175 +++++++++++++++----
 2 files changed, 144 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 3a89f3f6e2c7..ab1c66615d67 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -201,6 +201,7 @@ struct st_lsm6dsx_ext_dev_settings {
  * @max_fifo_size: Sensor max fifo length in FIFO words.
  * @id: List of hw id/device name supported by the driver configuration.
  * @odr_table: Hw sensors odr table (Hz + val).
+ * @fs_table: Hw sensors gain table (gain + val).
  * @decimator: List of decimator register info (addr + mask).
  * @batch: List of FIFO batching register info (addr + mask).
  * @fifo_ops: Sensor hw FIFO parameters.
@@ -215,6 +216,7 @@ struct st_lsm6dsx_settings {
 		const char *name;
 	} id[ST_LSM6DSX_MAX_ID];
 	struct st_lsm6dsx_odr_table_entry odr_table[2];
+	struct st_lsm6dsx_fs_table_entry fs_table[2];
 	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
 	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
 	struct st_lsm6dsx_fifo_ops fifo_ops;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index b3c6c9792913..9aa109428a52 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -69,29 +69,6 @@
 #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
 #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
 
-static const struct st_lsm6dsx_fs_table_entry st_lsm6dsx_fs_table[] = {
-	[ST_LSM6DSX_ID_ACC] = {
-		.reg = {
-			.addr = 0x10,
-			.mask = GENMASK(3, 2),
-		},
-		.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
-		.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
-		.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
-		.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
-	},
-	[ST_LSM6DSX_ID_GYRO] = {
-		.reg = {
-			.addr = 0x11,
-			.mask = GENMASK(3, 2),
-		},
-		.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
-		.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
-		.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
-		.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
-	}
-};
-
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	{
 		.wai = 0x69,
@@ -128,6 +105,28 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[5] = { 416, 0x06 },
 			},
 		},
+		.fs_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(3, 2),
+				},
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x11,
+					.mask = GENMASK(3, 2),
+				},
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+			},
+		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x08,
@@ -204,6 +203,28 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[5] = { 416, 0x06 },
 			},
 		},
+		.fs_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(3, 2),
+				},
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x11,
+					.mask = GENMASK(3, 2),
+				},
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+			},
+		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x08,
@@ -289,6 +310,28 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[5] = { 416, 0x06 },
 			},
 		},
+		.fs_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(3, 2),
+				},
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x11,
+					.mask = GENMASK(3, 2),
+				},
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+			},
+		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x08,
@@ -368,6 +411,28 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[5] = { 416, 0x06 },
 			},
 		},
+		.fs_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(3, 2),
+				},
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x11,
+					.mask = GENMASK(3, 2),
+				},
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+			},
+		},
 		.batch = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x09,
@@ -462,6 +527,28 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[5] = { 416, 0x06 },
 			},
 		},
+		.fs_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(3, 2),
+				},
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x11,
+					.mask = GENMASK(3, 2),
+				},
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+			},
+		},
 		.batch = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x09,
@@ -530,6 +617,28 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[5] = { 416, 0x06 },
 			},
 		},
+		.fs_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(3, 2),
+				},
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x11,
+					.mask = GENMASK(3, 2),
+				},
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+			},
+		},
 		.batch = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x09,
@@ -665,23 +774,22 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
 static int st_lsm6dsx_set_full_scale(struct st_lsm6dsx_sensor *sensor,
 				     u32 gain)
 {
-	struct st_lsm6dsx_hw *hw = sensor->hw;
-	const struct st_lsm6dsx_reg *reg;
+	const struct st_lsm6dsx_fs_table_entry *fs_table;
 	unsigned int data;
 	int i, err;
-	u8 val;
 
+	fs_table = &sensor->hw->settings->fs_table[sensor->id];
 	for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++)
-		if (st_lsm6dsx_fs_table[sensor->id].fs_avl[i].gain == gain)
+		if (fs_table->fs_avl[i].gain == gain)
 			break;
 
 	if (i == ST_LSM6DSX_FS_LIST_SIZE)
 		return -EINVAL;
 
-	val = st_lsm6dsx_fs_table[sensor->id].fs_avl[i].val;
-	reg = &st_lsm6dsx_fs_table[sensor->id].reg;
-	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
-	err = st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
+	data = ST_LSM6DSX_SHIFT_VAL(fs_table->fs_avl[i].val,
+				    fs_table->reg.mask);
+	err = st_lsm6dsx_update_bits_locked(sensor->hw, fs_table->reg.addr,
+					    fs_table->reg.mask, data);
 	if (err < 0)
 		return err;
 
@@ -934,11 +1042,12 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
 	enum st_lsm6dsx_sensor_id id = sensor->id;
+	struct st_lsm6dsx_hw *hw = sensor->hw;
 	int i, len = 0;
 
 	for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++)
 		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
-				 st_lsm6dsx_fs_table[id].fs_avl[i].gain);
+				 hw->settings->fs_table[id].fs_avl[i].gain);
 	buf[len - 1] = '\n';
 
 	return len;
@@ -1173,7 +1282,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	sensor->id = id;
 	sensor->hw = hw;
 	sensor->odr = hw->settings->odr_table[id].odr_avl[0].hz;
-	sensor->gain = st_lsm6dsx_fs_table[id].fs_avl[0].gain;
+	sensor->gain = hw->settings->fs_table[id].fs_avl[0].gain;
 	sensor->watermark = 1;
 
 	switch (id) {
-- 
2.21.0

