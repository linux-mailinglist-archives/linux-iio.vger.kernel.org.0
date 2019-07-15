Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951FF68A7B
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2019 15:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfGON0K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 09:26:10 -0400
Received: from comms.puri.sm ([159.203.221.185]:53318 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730266AbfGON0J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Jul 2019 09:26:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D9F50E0222;
        Mon, 15 Jul 2019 06:20:16 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VNCPJLdSTWw1; Mon, 15 Jul 2019 06:20:15 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 2/3] iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9sd1
Date:   Mon, 15 Jul 2019 15:19:18 +0200
Message-Id: <20190715131919.31938-2-martin.kepplinger@puri.sm>
In-Reply-To: <20190715131919.31938-1-martin.kepplinger@puri.sm>
References: <20190715131919.31938-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The LSM9DS1's accelerometer / gyroscope unit and it's magnetometer (separately
supported in iio/magnetometer/st_magn*) are located on a separate i2c addresses
on the bus.

For the datasheet, see https://www.st.com/resource/en/datasheet/lsm9ds1.pdf

Treat it just like the LSM6* devices and, despite it's name, hook it up
to the st_lsm6dsx driver, using it's basic functionality.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---

What do you think about an addition like this? How confusing is it to support
an LSM9 module by the lsm6 driver, despite it's name? It requires almost no
code, so why not think about it, right?

Oh, I'm not 100% convinced by my new "if" in probe(), but even that is
not too confusing I guess.

thanks,

                           martin

p.s.: todos:
* hook up the fifo / buffer / trigger functionality,
* (off-topic a bit) move the (currently strange) gyro-only support
  for lsm9ds0 to this driver as well.



 drivers/iio/imu/st_lsm6dsx/Kconfig           |   3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   4 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 105 ++++++++++++++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |   5 +
 5 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 002a423eae52..0b5a568e4c16 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -10,7 +10,8 @@ config IIO_ST_LSM6DSX
 	help
 	  Say yes here to build support for STMicroelectronics LSM6DSx imu
 	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
-	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr
+	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr and the
+	  accelerometer/gyroscope of lsm9ds1.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm6dsx.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index f072ac14f213..8af9641260fa 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -22,6 +22,7 @@
 #define ST_ASM330LHH_DEV_NAME	"asm330lhh"
 #define ST_LSM6DSOX_DEV_NAME	"lsm6dsox"
 #define ST_LSM6DSR_DEV_NAME	"lsm6dsr"
+#define ST_LSM9DS1_DEV_NAME	"lsm9ds1"
 
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID,
@@ -33,6 +34,7 @@ enum st_lsm6dsx_hw_id {
 	ST_ASM330LHH_ID,
 	ST_LSM6DSOX_ID,
 	ST_LSM6DSR_ID,
+	ST_LSM9DS1_ID,
 	ST_LSM6DSX_MAX_ID,
 };
 
@@ -230,6 +232,8 @@ enum st_lsm6dsx_sensor_id {
 	ST_LSM6DSX_ID_EXT0,
 	ST_LSM6DSX_ID_EXT1,
 	ST_LSM6DSX_ID_EXT2,
+	ST_LSM9DSX_ID_GYRO,
+	ST_LSM9DSX_ID_ACC,
 	ST_LSM6DSX_ID_MAX,
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 7a4fe70a8f20..6acfe63073de 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -10,6 +10,8 @@
  * +-125/+-245/+-500/+-1000/+-2000 dps
  * LSM6DSx series has an integrated First-In-First-Out (FIFO) buffer
  * allowing dynamic batching of sensor data.
+ * LSM9DSx series is similar but includes an additional magnetometer, handled
+ * by a different driver.
  *
  * Supported sensors:
  * - LSM6DS3:
@@ -30,6 +32,13 @@
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 3KB
  *
+ * - LSM9DS1:
+ *   - Accelerometer supported ODR [Hz]: 10, 50, 119, 238, 476, 952
+ *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
+ *   - Gyroscope supported ODR [Hz]: 15, 60, 119, 238, 476, 952
+ *   - Gyroscope supported full-scale [dps]: +-245/+-500/+-2000
+ *   - FIFO size: 32
+ *
  * Copyright 2016 STMicroelectronics Inc.
  *
  * Lorenzo Bianconi <lorenzo.bianconi@st.com>
@@ -64,6 +73,10 @@
 #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
 #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
 
+#define ST_LSM9DSX_REG_GYRO_OUT_X_L_ADDR	0x18
+#define ST_LSM9DSX_REG_GYRO_OUT_Y_L_ADDR	0x1a
+#define ST_LSM9DSX_REG_GYRO_OUT_Z_L_ADDR	0x1c
+
 static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
 	[ST_LSM6DSX_ID_ACC] = {
 		.reg = {
@@ -88,6 +101,30 @@ static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
 		.odr_avl[3] = { 104, 0x04 },
 		.odr_avl[4] = { 208, 0x05 },
 		.odr_avl[5] = { 416, 0x06 },
+	},
+	[ST_LSM9DSX_ID_ACC] = {
+		.reg = {
+			.addr = 0x20,
+			.mask = GENMASK(7, 5),
+		},
+		.odr_avl[0] = {  10, 0x01 },
+		.odr_avl[1] = {  50, 0x02 },
+		.odr_avl[2] = { 119, 0x03 },
+		.odr_avl[3] = { 238, 0x04 },
+		.odr_avl[4] = { 476, 0x05 },
+		.odr_avl[5] = { 952, 0x06 },
+	},
+	[ST_LSM9DSX_ID_GYRO] = {
+		.reg = {
+			.addr = 0x10,
+			.mask = GENMASK(7, 5),
+		},
+		.odr_avl[0] = {  15, 0x01 },
+		.odr_avl[1] = {  60, 0x02 },
+		.odr_avl[2] = { 119, 0x03 },
+		.odr_avl[3] = { 238, 0x04 },
+		.odr_avl[4] = { 476, 0x05 },
+		.odr_avl[5] = { 952, 0x06 },
 	}
 };
 
@@ -111,10 +148,43 @@ static const struct st_lsm6dsx_fs_table_entry st_lsm6dsx_fs_table[] = {
 		.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
 		.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
 		.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+	},
+	[ST_LSM9DSX_ID_ACC] = {
+		.reg = {
+			.addr = 0x20,
+			.mask = GENMASK(4, 3),
+		},
+		.fs_avl[0] = {  599, 0x0 },
+		.fs_avl[1] = { 1197, 0x2 },
+		.fs_avl[2] = { 2394, 0x3 },
+		.fs_avl[3] = { 4788, 0x1 },
+	},
+	[ST_LSM9DSX_ID_GYRO] = {
+		.reg = {
+			.addr = 0x10,
+			.mask = GENMASK(4, 3),
+		},
+		.fs_avl[0] = { IIO_DEGREE_TO_RAD(245), 0x0 },
+		.fs_avl[1] = { IIO_DEGREE_TO_RAD(500), 0x1 },
+		.fs_avl[2] = { IIO_DEGREE_TO_RAD(0), 0x2 },
+		.fs_avl[3] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
 	}
 };
 
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
+	{
+		.wai = 0x68,
+		.reg_int1_addr = 0x0c,
+		.reg_int2_addr = 0x0d,
+		.reg_reset_addr = 0x22,
+		.max_fifo_size = 32,
+		.id = {
+			{
+				.hw_id = ST_LSM9DS1_ID,
+				.name = ST_LSM9DS1_DEV_NAME,
+			},
+		},
+	},
 	{
 		.wai = 0x69,
 		.reg_int1_addr = 0x0d,
@@ -492,6 +562,16 @@ static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const struct iio_chan_spec st_lsm9dsx_gyro_channels[] = {
+	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM9DSX_REG_GYRO_OUT_X_L_ADDR,
+			   IIO_MOD_X, 0),
+	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM9DSX_REG_GYRO_OUT_Y_L_ADDR,
+			   IIO_MOD_Y, 1),
+	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM9DSX_REG_GYRO_OUT_Z_L_ADDR,
+			   IIO_MOD_Z, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
 int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable)
 {
 	const struct st_lsm6dsx_shub_settings *hub_settings;
@@ -1056,6 +1136,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 
 	switch (id) {
 	case ST_LSM6DSX_ID_ACC:
+	case ST_LSM9DSX_ID_ACC:
 		iio_dev->channels = st_lsm6dsx_acc_channels;
 		iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_acc_channels);
 		iio_dev->info = &st_lsm6dsx_acc_info;
@@ -1068,6 +1149,14 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 		iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_gyro_channels);
 		iio_dev->info = &st_lsm6dsx_gyro_info;
 
+		scnprintf(sensor->name, sizeof(sensor->name), "%s_gyro",
+			  name);
+		break;
+	case ST_LSM9DSX_ID_GYRO:
+		iio_dev->channels = st_lsm9dsx_gyro_channels;
+		iio_dev->num_channels = ARRAY_SIZE(st_lsm9dsx_gyro_channels);
+		iio_dev->info = &st_lsm6dsx_gyro_info;
+
 		scnprintf(sensor->name, sizeof(sensor->name), "%s_gyro",
 			  name);
 		break;
@@ -1109,10 +1198,18 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 	if (err < 0)
 		return err;
 
-	for (i = 0; i < ST_LSM6DSX_ID_EXT0; i++) {
-		hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i, name);
-		if (!hw->iio_devs[i])
-			return -ENOMEM;
+	if (hw_id == ST_LSM9DS1_ID) {
+		for (i = ST_LSM9DSX_ID_GYRO; i <= ST_LSM9DSX_ID_ACC; i++) {
+			hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i, name);
+			if (!hw->iio_devs[i])
+				return -ENOMEM;
+		}
+	} else {
+		for (i = 0; i < ST_LSM6DSX_ID_EXT0; i++) {
+			hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i, name);
+			if (!hw->iio_devs[i])
+				return -ENOMEM;
+		}
 	}
 
 	err = st_lsm6dsx_init_device(hw);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index b3211e0ac07b..a684e7db1299 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -75,6 +75,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,lsm6dsr",
 		.data = (void *)ST_LSM6DSR_ID,
 	},
+	{
+		.compatible = "st,lsm9ds1",
+		.data = (void *)ST_LSM9DS1_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
@@ -89,6 +93,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
 	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
 	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
+	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index c9d3c4711018..709769177e91 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -75,6 +75,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,lsm6dsr",
 		.data = (void *)ST_LSM6DSR_ID,
 	},
+	{
+		.compatible = "st,lsm9ds1",
+		.data = (void *)ST_LSM9DS1_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
@@ -89,6 +93,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
 	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
 	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
+	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
-- 
2.20.1

