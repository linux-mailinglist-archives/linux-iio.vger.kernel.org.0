Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53466BA19B
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2019 11:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfIVJTJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Sep 2019 05:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfIVJTJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Sep 2019 05:19:09 -0400
Received: from localhost.localdomain (unknown [151.66.30.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC10E2070C;
        Sun, 22 Sep 2019 09:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569143948;
        bh=tcN6G35hFN0zcO4/Kxfl9Kc7Gheu6TleF9ESFaq82wE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIMa8MCqXy0y/Up8ABBdiyMcInvBea2ZiYPpOwl4+5SNUE9gEXBQfrp0xJ4IIhZ55
         EQcMbVdw4rhsqu232WThrkO7hYBwu1eF/9HofmwCAasoDp4TqOXaA39Lqy8lV5S9Oc
         7Ab/Y4j/ftfJi5Z9RvWKu6+i9pWRM16OOXATdOvE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        martin.kepplinger@puri.sm, rjones@gateworks.com
Subject: [PATCH 1/3] iio: imu: st_lsm6dsx: move irq related definitions in irq_config
Date:   Sun, 22 Sep 2019 11:18:51 +0200
Message-Id: <345877d7372d5ea90b5fa699de908bd8378fa9bf.1569143551.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1569143551.git.lorenzo@kernel.org>
References: <cover.1569143551.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Group irq related definition in irq_config structure in
st_lsm6dsx_settings. This is a preliminary patch to check
OpenDrain/Active low registers before accessing them

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  15 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 195 ++++++++++++-------
 2 files changed, 130 insertions(+), 80 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 21d14072d1c6..b2c568aadd4c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -205,26 +205,21 @@ struct st_lsm6dsx_ext_dev_settings {
 /**
  * struct st_lsm6dsx_settings - ST IMU sensor settings
  * @wai: Sensor WhoAmI default value.
- * @int1_addr: Control Register address for INT1
- * @int2_addr: Control Register address for INT2
  * @reset_addr: register address for reset/reboot
  * @max_fifo_size: Sensor max fifo length in FIFO words.
  * @id: List of hw id/device name supported by the driver configuration.
  * @channels: IIO channels supported by the device.
+ * @irq_config: interrupts related registers.
  * @odr_table: Hw sensors odr table (Hz + val).
  * @fs_table: Hw sensors gain table (gain + val).
  * @decimator: List of decimator register info (addr + mask).
  * @batch: List of FIFO batching register info (addr + mask).
- * @lir: Latched interrupt register info (addr + mask).
- * @clear_on_read: Clear on read register info (addr + mask).
  * @fifo_ops: Sensor hw FIFO parameters.
  * @ts_settings: Hw timer related settings.
  * @shub_settings: i2c controller related settings.
  */
 struct st_lsm6dsx_settings {
 	u8 wai;
-	u8 int1_addr;
-	u8 int2_addr;
 	u8 reset_addr;
 	u16 max_fifo_size;
 	struct {
@@ -235,12 +230,16 @@ struct st_lsm6dsx_settings {
 		const struct iio_chan_spec *chan;
 		int len;
 	} channels[2];
+	struct {
+		struct st_lsm6dsx_reg irq1;
+		struct st_lsm6dsx_reg irq2;
+		struct st_lsm6dsx_reg lir;
+		struct st_lsm6dsx_reg clear_on_read;
+	} irq_config;
 	struct st_lsm6dsx_odr_table_entry odr_table[2];
 	struct st_lsm6dsx_fs_table_entry fs_table[2];
 	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
 	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
-	struct st_lsm6dsx_reg lir;
-	struct st_lsm6dsx_reg clear_on_read;
 	struct st_lsm6dsx_fifo_ops fifo_ops;
 	struct st_lsm6dsx_hw_ts_settings ts_settings;
 	struct st_lsm6dsx_shub_settings shub_settings;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index b65a6ca775e0..c14441040a62 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -58,7 +58,6 @@
 
 #include "st_lsm6dsx.h"
 
-#define ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK	BIT(3)
 #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
 #define ST_LSM6DSX_REG_RESET_MASK		BIT(0)
 #define ST_LSM6DSX_REG_BOOT_MASK		BIT(7)
@@ -89,8 +88,6 @@ static const struct iio_chan_spec st_lsm6ds0_gyro_channels[] = {
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	{
 		.wai = 0x68,
-		.int1_addr = 0x0c,
-		.int2_addr = 0x0d,
 		.reset_addr = 0x22,
 		.max_fifo_size = 32,
 		.id = {
@@ -156,11 +153,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[2] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
 			},
 		},
+		.irq_config = {
+			.irq1 = {
+				.addr = 0x0c,
+				.mask = BIT(3),
+			},
+			.irq2 = {
+				.addr = 0x0d,
+				.mask = BIT(3),
+			},
+		},
 	},
 	{
 		.wai = 0x69,
-		.int1_addr = 0x0d,
-		.int2_addr = 0x0e,
 		.reset_addr = 0x12,
 		.max_fifo_size = 1365,
 		.id = {
@@ -227,6 +232,20 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
 			},
 		},
+		.irq_config = {
+			.irq1 = {
+				.addr = 0x0d,
+				.mask = BIT(3),
+			},
+			.irq2 = {
+				.addr = 0x0e,
+				.mask = BIT(3),
+			},
+			.lir = {
+				.addr = 0x58,
+				.mask = BIT(0),
+			},
+		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x08,
@@ -237,10 +256,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
-		.lir = {
-			.addr = 0x58,
-			.mask = BIT(0),
-		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
 			.read_fifo = st_lsm6dsx_read_fifo,
@@ -275,8 +290,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x69,
-		.int1_addr = 0x0d,
-		.int2_addr = 0x0e,
 		.reset_addr = 0x12,
 		.max_fifo_size = 682,
 		.id = {
@@ -343,6 +356,20 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
 			},
 		},
+		.irq_config = {
+			.irq1 = {
+				.addr = 0x0d,
+				.mask = BIT(3),
+			},
+			.irq2 = {
+				.addr = 0x0e,
+				.mask = BIT(3),
+			},
+			.lir = {
+				.addr = 0x58,
+				.mask = BIT(0),
+			},
+		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x08,
@@ -353,10 +380,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
-		.lir = {
-			.addr = 0x58,
-			.mask = BIT(0),
-		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
 			.read_fifo = st_lsm6dsx_read_fifo,
@@ -391,8 +414,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6a,
-		.int1_addr = 0x0d,
-		.int2_addr = 0x0e,
 		.reset_addr = 0x12,
 		.max_fifo_size = 682,
 		.id = {
@@ -468,6 +489,20 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
 			},
 		},
+		.irq_config = {
+			.irq1 = {
+				.addr = 0x0d,
+				.mask = BIT(3),
+			},
+			.irq2 = {
+				.addr = 0x0e,
+				.mask = BIT(3),
+			},
+			.lir = {
+				.addr = 0x58,
+				.mask = BIT(0),
+			},
+		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x08,
@@ -478,10 +513,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
-		.lir = {
-			.addr = 0x58,
-			.mask = BIT(0),
-		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
 			.read_fifo = st_lsm6dsx_read_fifo,
@@ -516,8 +547,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6c,
-		.int1_addr = 0x0d,
-		.int2_addr = 0x0e,
 		.reset_addr = 0x12,
 		.max_fifo_size = 512,
 		.id = {
@@ -587,6 +616,24 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
 			},
 		},
+		.irq_config = {
+			.irq1 = {
+				.addr = 0x0d,
+				.mask = BIT(3),
+			},
+			.irq2 = {
+				.addr = 0x0e,
+				.mask = BIT(3),
+			},
+			.lir = {
+				.addr = 0x56,
+				.mask = BIT(0),
+			},
+			.clear_on_read = {
+				.addr = 0x56,
+				.mask = BIT(6),
+			},
+		},
 		.batch = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x09,
@@ -597,14 +644,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 4),
 			},
 		},
-		.lir = {
-			.addr = 0x56,
-			.mask = BIT(0),
-		},
-		.clear_on_read = {
-			.addr = 0x56,
-			.mask = BIT(6),
-		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
 			.read_fifo = st_lsm6dsx_read_tagged_fifo,
@@ -657,8 +696,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6b,
-		.int1_addr = 0x0d,
-		.int2_addr = 0x0e,
 		.reset_addr = 0x12,
 		.max_fifo_size = 512,
 		.id = {
@@ -725,6 +762,24 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
 			},
 		},
+		.irq_config = {
+			.irq1 = {
+				.addr = 0x0d,
+				.mask = BIT(3),
+			},
+			.irq2 = {
+				.addr = 0x0e,
+				.mask = BIT(3),
+			},
+			.lir = {
+				.addr = 0x56,
+				.mask = BIT(0),
+			},
+			.clear_on_read = {
+				.addr = 0x56,
+				.mask = BIT(6),
+			},
+		},
 		.batch = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x09,
@@ -735,14 +790,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 4),
 			},
 		},
-		.lir = {
-			.addr = 0x56,
-			.mask = BIT(0),
-		},
-		.clear_on_read = {
-			.addr = 0x56,
-			.mask = BIT(6),
-		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
 			.read_fifo = st_lsm6dsx_read_tagged_fifo,
@@ -769,8 +816,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6b,
-		.int1_addr = 0x0d,
-		.int2_addr = 0x0e,
 		.reset_addr = 0x12,
 		.max_fifo_size = 512,
 		.id = {
@@ -840,6 +885,24 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
 			},
 		},
+		.irq_config = {
+			.irq1 = {
+				.addr = 0x0d,
+				.mask = BIT(3),
+			},
+			.irq2 = {
+				.addr = 0x0e,
+				.mask = BIT(3),
+			},
+			.lir = {
+				.addr = 0x56,
+				.mask = BIT(0),
+			},
+			.clear_on_read = {
+				.addr = 0x56,
+				.mask = BIT(6),
+			},
+		},
 		.batch = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x09,
@@ -850,14 +913,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 4),
 			},
 		},
-		.lir = {
-			.addr = 0x56,
-			.mask = BIT(0),
-		},
-		.clear_on_read = {
-			.addr = 0x56,
-			.mask = BIT(6),
-		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
 			.read_fifo = st_lsm6dsx_read_tagged_fifo,
@@ -1299,7 +1354,9 @@ static int st_lsm6dsx_of_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_pin)
 	return of_property_read_u32(np, "st,drdy-int-pin", drdy_pin);
 }
 
-static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
+static int
+st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
+			const struct st_lsm6dsx_reg **drdy_reg)
 {
 	int err = 0, drdy_pin;
 
@@ -1313,10 +1370,10 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
 
 	switch (drdy_pin) {
 	case 1:
-		*drdy_reg = hw->settings->int1_addr;
+		*drdy_reg = &hw->settings->irq_config.irq1;
 		break;
 	case 2:
-		*drdy_reg = hw->settings->int2_addr;
+		*drdy_reg = &hw->settings->irq_config.irq2;
 		break;
 	default:
 		dev_err(hw->dev, "unsupported data ready pin\n");
@@ -1412,7 +1469,7 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
 
 static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 {
-	u8 drdy_int_reg;
+	const struct st_lsm6dsx_reg *reg;
 	int err;
 
 	/* device sw reset */
@@ -1441,35 +1498,29 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 		return err;
 
 	/* enable FIFO watermak interrupt */
-	err = st_lsm6dsx_get_drdy_reg(hw, &drdy_int_reg);
+	err = st_lsm6dsx_get_drdy_reg(hw, &reg);
 	if (err < 0)
 		return err;
 
-	err = regmap_update_bits(hw->regmap, drdy_int_reg,
-				 ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK,
-				 FIELD_PREP(ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK,
-					    1));
+	err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+				 ST_LSM6DSX_SHIFT_VAL(1, reg->mask));
 	if (err < 0)
 		return err;
 
 	/* enable Latched interrupts for device events */
-	if (hw->settings->lir.addr) {
-		unsigned int data;
-
-		data = ST_LSM6DSX_SHIFT_VAL(1, hw->settings->lir.mask);
-		err = regmap_update_bits(hw->regmap, hw->settings->lir.addr,
-					 hw->settings->lir.mask, data);
+	if (hw->settings->irq_config.lir.addr) {
+		reg = &hw->settings->irq_config.lir;
+		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+					 ST_LSM6DSX_SHIFT_VAL(1, reg->mask));
 		if (err < 0)
 			return err;
 
 		/* enable clear on read for latched interrupts */
-		if (hw->settings->clear_on_read.addr) {
-			data = ST_LSM6DSX_SHIFT_VAL(1,
-					hw->settings->clear_on_read.mask);
+		if (hw->settings->irq_config.clear_on_read.addr) {
+			reg = &hw->settings->irq_config.clear_on_read;
 			err = regmap_update_bits(hw->regmap,
-					hw->settings->clear_on_read.addr,
-					hw->settings->clear_on_read.mask,
-					data);
+					reg->addr, reg->mask,
+					ST_LSM6DSX_SHIFT_VAL(1, reg->mask));
 			if (err < 0)
 				return err;
 		}
-- 
2.21.0

