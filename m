Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C30CD20D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfJFNWc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 09:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfJFNWc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 09:22:32 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6E7B20867;
        Sun,  6 Oct 2019 13:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570368150;
        bh=qTEwSD5xhvujACEv3T9bUUzzwJf9LeeTjpnpHxmfh1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQSbzUPgyf8d9ShFUx9Ae/+DJBBgFppGLLIT5PBmeGDjSMoBA7HhKIH2tV9+EHg0Y
         9gGmq6PmB094E2mpU78nwnm/PtyuCtvn7xBS0F2rMVK+9BnXYLZTPC7vlr0agz08YY
         lX3got+Pm6JW+wGSBujS9YYw9m+UfX4SFceuVIUE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: [PATCH 03/13] iio: imu: st_lsm6dsx: move irq related definitions in irq_config
Date:   Sun,  6 Oct 2019 15:21:57 +0200
Message-Id: <873559493f99be2a659f27da293f66a546598c2b.1570367532.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Group irq related definition in irq_config structure in
st_lsm6dsx_settings. This is a preliminary patch to move
OpenDrain/Active low registers in st_lsm6dsx_settings.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  22 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 265 ++++++++++++-------
 2 files changed, 179 insertions(+), 108 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index fd02d0e184f3..873ec3b8fd69 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -236,29 +236,21 @@ struct st_lsm6dsx_ext_dev_settings {
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
-	u8 int1_func_addr;
-	u8 int2_func_addr;
-	u8 int_func_mask;
 	u8 reset_addr;
 	u16 max_fifo_size;
 	struct {
@@ -269,12 +261,18 @@ struct st_lsm6dsx_settings {
 		const struct iio_chan_spec *chan;
 		int len;
 	} channels[2];
+	struct {
+		struct st_lsm6dsx_reg irq1;
+		struct st_lsm6dsx_reg irq2;
+		struct st_lsm6dsx_reg irq1_func;
+		struct st_lsm6dsx_reg irq2_func;
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
@@ -359,9 +357,9 @@ struct st_lsm6dsx_hw {
 	u8 ts_sip;
 	u8 sip;
 
+	const struct st_lsm6dsx_reg *irq_routing;
 	u8 event_threshold;
 	u8 enable_event;
-	struct st_lsm6dsx_reg irq_routing;
 
 	u8 *buff;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index eac695663b6f..23d67caa24ed 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -61,7 +61,6 @@
 
 #include "st_lsm6dsx.h"
 
-#define ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK	BIT(3)
 #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
 #define ST_LSM6DSX_REG_RESET_MASK		BIT(0)
 #define ST_LSM6DSX_REG_BOOT_MASK		BIT(7)
@@ -97,8 +96,6 @@ static const struct iio_chan_spec st_lsm6ds0_gyro_channels[] = {
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	{
 		.wai = 0x68,
-		.int1_addr = 0x0c,
-		.int2_addr = 0x0d,
 		.reset_addr = 0x22,
 		.max_fifo_size = 32,
 		.id = {
@@ -164,14 +161,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
-		.int1_func_addr = 0x5e,
-		.int2_func_addr = 0x5f,
-		.int_func_mask = BIT(5),
 		.reset_addr = 0x12,
 		.max_fifo_size = 1365,
 		.id = {
@@ -238,6 +240,28 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
+			.irq1_func = {
+				.addr = 0x5e,
+				.mask = BIT(5),
+			},
+			.irq2_func = {
+				.addr = 0x5f,
+				.mask = BIT(5),
+			},
+		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x08,
@@ -248,10 +272,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -297,11 +317,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x69,
-		.int1_addr = 0x0d,
-		.int2_addr = 0x0e,
-		.int1_func_addr = 0x5e,
-		.int2_func_addr = 0x5f,
-		.int_func_mask = BIT(5),
 		.reset_addr = 0x12,
 		.max_fifo_size = 682,
 		.id = {
@@ -368,6 +383,28 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
+			.irq1_func = {
+				.addr = 0x5e,
+				.mask = BIT(5),
+			},
+			.irq2_func = {
+				.addr = 0x5f,
+				.mask = BIT(5),
+			},
+		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x08,
@@ -378,10 +415,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -427,11 +460,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6a,
-		.int1_addr = 0x0d,
-		.int2_addr = 0x0e,
-		.int1_func_addr = 0x5e,
-		.int2_func_addr = 0x5f,
-		.int_func_mask = BIT(5),
 		.reset_addr = 0x12,
 		.max_fifo_size = 682,
 		.id = {
@@ -507,6 +535,28 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
+			.irq1_func = {
+				.addr = 0x5e,
+				.mask = BIT(5),
+			},
+			.irq2_func = {
+				.addr = 0x5f,
+				.mask = BIT(5),
+			},
+		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x08,
@@ -517,10 +567,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -570,8 +616,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6c,
-		.int1_addr = 0x0d,
-		.int2_addr = 0x0e,
 		.reset_addr = 0x12,
 		.max_fifo_size = 512,
 		.id = {
@@ -641,6 +685,24 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -651,14 +713,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -711,11 +765,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6b,
-		.int1_addr = 0x0d,
-		.int2_addr = 0x0e,
-		.int1_func_addr = 0x5e,
-		.int2_func_addr = 0x5f,
-		.int_func_mask = BIT(5),
 		.reset_addr = 0x12,
 		.max_fifo_size = 512,
 		.id = {
@@ -782,6 +831,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
+			.irq1_func = {
+				.addr = 0x5e,
+				.mask = BIT(5),
+			},
+			.irq2_func = {
+				.addr = 0x5f,
+				.mask = BIT(5),
+			},
+		},
 		.batch = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x09,
@@ -792,14 +867,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -841,11 +908,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6b,
-		.int1_addr = 0x0d,
-		.int2_addr = 0x0e,
-		.int1_func_addr = 0x5e,
-		.int2_func_addr = 0x5f,
-		.int_func_mask = BIT(5),
 		.reset_addr = 0x12,
 		.max_fifo_size = 512,
 		.id = {
@@ -915,6 +977,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
+			.irq1_func = {
+				.addr = 0x5e,
+				.mask = BIT(5),
+			},
+			.irq2_func = {
+				.addr = 0x5f,
+				.mask = BIT(5),
+			},
+		},
 		.batch = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.addr = 0x09,
@@ -925,14 +1013,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -1281,7 +1361,7 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
 	int err;
 	u8 enable = 0;
 
-	if (!hw->settings->int1_func_addr)
+	if (!hw->settings->irq_config.irq1_func.addr)
 		return -ENOTSUPP;
 
 	enable = state ? hw->settings->event_settings.enable_reg.mask : 0;
@@ -1293,12 +1373,11 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
 	if (err < 0)
 		return err;
 
-	enable = state ? hw->irq_routing.mask : 0;
+	enable = state ? hw->irq_routing->mask : 0;
 
 	/* Enable wakeup interrupt */
-	return regmap_update_bits(hw->regmap, hw->irq_routing.addr,
-				  hw->irq_routing.mask,
-				  enable);
+	return regmap_update_bits(hw->regmap, hw->irq_routing->addr,
+				  hw->irq_routing->mask, enable);
 }
 
 static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
@@ -1527,7 +1606,9 @@ static int st_lsm6dsx_of_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_pin)
 	return of_property_read_u32(np, "st,drdy-int-pin", drdy_pin);
 }
 
-static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
+static int
+st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
+			const struct st_lsm6dsx_reg **drdy_reg)
 {
 	int err = 0, drdy_pin;
 
@@ -1541,14 +1622,12 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
 
 	switch (drdy_pin) {
 	case 1:
-		*drdy_reg = hw->settings->int1_addr;
-		hw->irq_routing.addr = hw->settings->int1_func_addr;
-		hw->irq_routing.mask = hw->settings->int_func_mask;
+		hw->irq_routing = &hw->settings->irq_config.irq1_func;
+		*drdy_reg = &hw->settings->irq_config.irq1;
 		break;
 	case 2:
-		*drdy_reg = hw->settings->int2_addr;
-		hw->irq_routing.addr = hw->settings->int2_func_addr;
-		hw->irq_routing.mask = hw->settings->int_func_mask;
+		hw->irq_routing = &hw->settings->irq_config.irq2_func;
+		*drdy_reg = &hw->settings->irq_config.irq2;
 		break;
 	default:
 		dev_err(hw->dev, "unsupported data ready pin\n");
@@ -1644,7 +1723,7 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
 
 static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 {
-	u8 drdy_int_reg;
+	const struct st_lsm6dsx_reg *reg;
 	int err;
 
 	/* device sw reset */
@@ -1673,35 +1752,29 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
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

