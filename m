Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1AC974503
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2019 07:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403837AbfGYFch (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Jul 2019 01:32:37 -0400
Received: from comms.puri.sm ([159.203.221.185]:59528 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403750AbfGYFcU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Jul 2019 01:32:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 7384FE0493;
        Wed, 24 Jul 2019 22:32:18 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4kFFWbujvfGN; Wed, 24 Jul 2019 22:32:17 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v3 2/5] iio: imu: st_lsm6dsx: move fs_table in st_lsm6dsx_sensor_settings
Date:   Thu, 25 Jul 2019 07:31:29 +0200
Message-Id: <20190725053132.9589-3-martin.kepplinger@puri.sm>
In-Reply-To: <20190725053132.9589-1-martin.kepplinger@puri.sm>
References: <20190725053132.9589-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Move fs_table in st_lsm6dsx_sensor_settings in order to support
sensors with different gain maps. This is a preliminary patch to add
support for LSM9DS1 sensor to st_lsm6dsx driver

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
2.20.1

