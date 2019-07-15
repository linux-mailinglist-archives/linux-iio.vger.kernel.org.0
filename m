Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C306469E6F
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2019 23:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbfGOVm1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 17:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730574AbfGOVm1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Jul 2019 17:42:27 -0400
Received: from localhost.localdomain (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34FD220693;
        Mon, 15 Jul 2019 21:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563226946;
        bh=BmhGzwTeE/rKQYrnH3OlrgJSc7OAiC7C5onWCNocbgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0sLvEucXDi9Vpdi5Q23usGD4QBRVJlzvDfwkrovykS7T2No49SWw+8i/ytBD0j/t6
         gMEp58m6NArPGIhFCkxyF7C4EouZKzhJLTYCeSDoVdafpN9B1Zccu5ilwr/MEjZvqb
         dNwYSnOXqxlzN+4LONH+dPHV8zA+hl9URq5xCjt0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        martin.kepplinger@puri.sm
Subject: [PATCH 1/3] iio: imu: st_lsm6dsx: move odr_table in st_lsm6dsx_sensor_settings
Date:   Mon, 15 Jul 2019 23:42:09 +0200
Message-Id: <266b36facd2c0b36454f0d6023a886e246441348.1563226641.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563226641.git.lorenzo@kernel.org>
References: <cover.1563226641.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move sensor odr table in st_lsm6dsx_sensor_settings in order to support
sensors with different odr maps. This is a preliminary patch to add
support for LSM9DS1 sensor to st_lsm6dsx driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 196 ++++++++++++++++---
 2 files changed, 166 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index af379a5429ed..3a89f3f6e2c7 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -200,6 +200,7 @@ struct st_lsm6dsx_ext_dev_settings {
  * @wai: Sensor WhoAmI default value.
  * @max_fifo_size: Sensor max fifo length in FIFO words.
  * @id: List of hw id/device name supported by the driver configuration.
+ * @odr_table: Hw sensors odr table (Hz + val).
  * @decimator: List of decimator register info (addr + mask).
  * @batch: List of FIFO batching register info (addr + mask).
  * @fifo_ops: Sensor hw FIFO parameters.
@@ -213,6 +214,7 @@ struct st_lsm6dsx_settings {
 		enum st_lsm6dsx_hw_id hw_id;
 		const char *name;
 	} id[ST_LSM6DSX_MAX_ID];
+	struct st_lsm6dsx_odr_table_entry odr_table[2];
 	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
 	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
 	struct st_lsm6dsx_fifo_ops fifo_ops;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index d8c4417cf4eb..b3c6c9792913 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -69,33 +69,6 @@
 #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
 #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
 
-static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
-	[ST_LSM6DSX_ID_ACC] = {
-		.reg = {
-			.addr = 0x10,
-			.mask = GENMASK(7, 4),
-		},
-		.odr_avl[0] = {  13, 0x01 },
-		.odr_avl[1] = {  26, 0x02 },
-		.odr_avl[2] = {  52, 0x03 },
-		.odr_avl[3] = { 104, 0x04 },
-		.odr_avl[4] = { 208, 0x05 },
-		.odr_avl[5] = { 416, 0x06 },
-	},
-	[ST_LSM6DSX_ID_GYRO] = {
-		.reg = {
-			.addr = 0x11,
-			.mask = GENMASK(7, 4),
-		},
-		.odr_avl[0] = {  13, 0x01 },
-		.odr_avl[1] = {  26, 0x02 },
-		.odr_avl[2] = {  52, 0x03 },
-		.odr_avl[3] = { 104, 0x04 },
-		.odr_avl[4] = { 208, 0x05 },
-		.odr_avl[5] = { 416, 0x06 },
-	}
-};
-
 static const struct st_lsm6dsx_fs_table_entry st_lsm6dsx_fs_table[] = {
 	[ST_LSM6DSX_ID_ACC] = {
 		.reg = {
@@ -129,6 +102,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.name = ST_LSM6DS3_DEV_NAME,
 			},
 		},
+		.odr_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(7, 4),
+				},
+				.odr_avl[0] = {  13, 0x01 },
+				.odr_avl[1] = {  26, 0x02 },
+				.odr_avl[2] = {  52, 0x03 },
+				.odr_avl[3] = { 104, 0x04 },
+				.odr_avl[4] = { 208, 0x05 },
+				.odr_avl[5] = { 416, 0x06 },
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x11,
+					.mask = GENMASK(7, 4),
+				},
+				.odr_avl[0] = {  13, 0x01 },
+				.odr_avl[1] = {  26, 0x02 },
+				.odr_avl[2] = {  52, 0x03 },
+				.odr_avl[3] = { 104, 0x04 },
+				.odr_avl[4] = { 208, 0x05 },
+				.odr_avl[5] = { 416, 0x06 },
+			},
+		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x08,
@@ -179,6 +178,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.name = ST_LSM6DS3H_DEV_NAME,
 			},
 		},
+		.odr_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(7, 4),
+				},
+				.odr_avl[0] = {  13, 0x01 },
+				.odr_avl[1] = {  26, 0x02 },
+				.odr_avl[2] = {  52, 0x03 },
+				.odr_avl[3] = { 104, 0x04 },
+				.odr_avl[4] = { 208, 0x05 },
+				.odr_avl[5] = { 416, 0x06 },
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x11,
+					.mask = GENMASK(7, 4),
+				},
+				.odr_avl[0] = {  13, 0x01 },
+				.odr_avl[1] = {  26, 0x02 },
+				.odr_avl[2] = {  52, 0x03 },
+				.odr_avl[3] = { 104, 0x04 },
+				.odr_avl[4] = { 208, 0x05 },
+				.odr_avl[5] = { 416, 0x06 },
+			},
+		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x08,
@@ -238,6 +263,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.name = ST_LSM6DS3TRC_DEV_NAME,
 			},
 		},
+		.odr_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(7, 4),
+				},
+				.odr_avl[0] = {  13, 0x01 },
+				.odr_avl[1] = {  26, 0x02 },
+				.odr_avl[2] = {  52, 0x03 },
+				.odr_avl[3] = { 104, 0x04 },
+				.odr_avl[4] = { 208, 0x05 },
+				.odr_avl[5] = { 416, 0x06 },
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x11,
+					.mask = GENMASK(7, 4),
+				},
+				.odr_avl[0] = {  13, 0x01 },
+				.odr_avl[1] = {  26, 0x02 },
+				.odr_avl[2] = {  52, 0x03 },
+				.odr_avl[3] = { 104, 0x04 },
+				.odr_avl[4] = { 208, 0x05 },
+				.odr_avl[5] = { 416, 0x06 },
+			},
+		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x08,
@@ -291,6 +342,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.name = ST_LSM6DSOX_DEV_NAME,
 			},
 		},
+		.odr_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(7, 4),
+				},
+				.odr_avl[0] = {  13, 0x01 },
+				.odr_avl[1] = {  26, 0x02 },
+				.odr_avl[2] = {  52, 0x03 },
+				.odr_avl[3] = { 104, 0x04 },
+				.odr_avl[4] = { 208, 0x05 },
+				.odr_avl[5] = { 416, 0x06 },
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x11,
+					.mask = GENMASK(7, 4),
+				},
+				.odr_avl[0] = {  13, 0x01 },
+				.odr_avl[1] = {  26, 0x02 },
+				.odr_avl[2] = {  52, 0x03 },
+				.odr_avl[3] = { 104, 0x04 },
+				.odr_avl[4] = { 208, 0x05 },
+				.odr_avl[5] = { 416, 0x06 },
+			},
+		},
 		.batch = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x09,
@@ -359,6 +436,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.name = ST_ASM330LHH_DEV_NAME,
 			},
 		},
+		.odr_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(7, 4),
+				},
+				.odr_avl[0] = {  13, 0x01 },
+				.odr_avl[1] = {  26, 0x02 },
+				.odr_avl[2] = {  52, 0x03 },
+				.odr_avl[3] = { 104, 0x04 },
+				.odr_avl[4] = { 208, 0x05 },
+				.odr_avl[5] = { 416, 0x06 },
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x11,
+					.mask = GENMASK(7, 4),
+				},
+				.odr_avl[0] = {  13, 0x01 },
+				.odr_avl[1] = {  26, 0x02 },
+				.odr_avl[2] = {  52, 0x03 },
+				.odr_avl[3] = { 104, 0x04 },
+				.odr_avl[4] = { 208, 0x05 },
+				.odr_avl[5] = { 416, 0x06 },
+			},
+		},
 		.batch = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x09,
@@ -401,6 +504,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.name = ST_LSM6DSR_DEV_NAME,
 			},
 		},
+		.odr_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(7, 4),
+				},
+				.odr_avl[0] = {  13, 0x01 },
+				.odr_avl[1] = {  26, 0x02 },
+				.odr_avl[2] = {  52, 0x03 },
+				.odr_avl[3] = { 104, 0x04 },
+				.odr_avl[4] = { 208, 0x05 },
+				.odr_avl[5] = { 416, 0x06 },
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x11,
+					.mask = GENMASK(7, 4),
+				},
+				.odr_avl[0] = {  13, 0x01 },
+				.odr_avl[1] = {  26, 0x02 },
+				.odr_avl[2] = {  52, 0x03 },
+				.odr_avl[3] = { 104, 0x04 },
+				.odr_avl[4] = { 208, 0x05 },
+				.odr_avl[5] = { 416, 0x06 },
+			},
+		},
 		.batch = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x09,
@@ -563,20 +692,22 @@ static int st_lsm6dsx_set_full_scale(struct st_lsm6dsx_sensor *sensor,
 
 int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val)
 {
+	const struct st_lsm6dsx_odr_table_entry *odr_table;
 	int i;
 
+	odr_table = &sensor->hw->settings->odr_table[sensor->id];
 	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
 		/*
 		 * ext devices can run at different odr respect to
 		 * accel sensor
 		 */
-		if (st_lsm6dsx_odr_table[sensor->id].odr_avl[i].hz >= odr)
+		if (odr_table->odr_avl[i].hz >= odr)
 			break;
 
 	if (i == ST_LSM6DSX_ODR_LIST_SIZE)
 		return -EINVAL;
 
-	*val = st_lsm6dsx_odr_table[sensor->id].odr_avl[i].val;
+	*val = odr_table->odr_avl[i].val;
 
 	return 0;
 }
@@ -641,7 +772,7 @@ static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 req_odr)
 			return err;
 	}
 
-	reg = &st_lsm6dsx_odr_table[ref_sensor->id].reg;
+	reg = &hw->settings->odr_table[ref_sensor->id].reg;
 	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
 	return st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
 }
@@ -786,11 +917,12 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
 	enum st_lsm6dsx_sensor_id id = sensor->id;
+	struct st_lsm6dsx_hw *hw = sensor->hw;
 	int i, len = 0;
 
 	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
 		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
-				 st_lsm6dsx_odr_table[id].odr_avl[i].hz);
+				 hw->settings->odr_table[id].odr_avl[i].hz);
 	buf[len - 1] = '\n';
 
 	return len;
@@ -1040,7 +1172,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	sensor = iio_priv(iio_dev);
 	sensor->id = id;
 	sensor->hw = hw;
-	sensor->odr = st_lsm6dsx_odr_table[id].odr_avl[0].hz;
+	sensor->odr = hw->settings->odr_table[id].odr_avl[0].hz;
 	sensor->gain = st_lsm6dsx_fs_table[id].fs_avl[0].gain;
 	sensor->watermark = 1;
 
-- 
2.21.0

