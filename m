Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 825F5744FA
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2019 07:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403841AbfGYFc0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Jul 2019 01:32:26 -0400
Received: from comms.puri.sm ([159.203.221.185]:59566 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403827AbfGYFc0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Jul 2019 01:32:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 33810E0496;
        Wed, 24 Jul 2019 22:32:24 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IkkQiEiP6mV5; Wed, 24 Jul 2019 22:32:23 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3 4/5] iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9sd1
Date:   Thu, 25 Jul 2019 07:31:31 +0200
Message-Id: <20190725053132.9589-5-martin.kepplinger@puri.sm>
In-Reply-To: <20190725053132.9589-1-martin.kepplinger@puri.sm>
References: <20190725053132.9589-1-martin.kepplinger@puri.sm>
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
 drivers/iio/imu/st_lsm6dsx/Kconfig           |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 94 +++++++++++++++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  5 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  5 ++
 5 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 2d8b2e1edfce..4a57bfb3c12e 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -11,6 +11,7 @@ config IIO_ST_LSM6DSX
 	  Say yes here to build support for STMicroelectronics LSM6DSx imu
 	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
 	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr, lsm6ds3tr-c
+	  and the accelerometer/gyroscope of lsm9ds1.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm6dsx.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 3c47f5d27d30..9a30cc717de2 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -23,6 +23,7 @@
 #define ST_LSM6DSOX_DEV_NAME	"lsm6dsox"
 #define ST_LSM6DSR_DEV_NAME	"lsm6dsr"
 #define ST_LSM6DS3TRC_DEV_NAME	"lsm6ds3tr-c"
+#define ST_LSM9DS1_DEV_NAME	"lsm9ds1"
 
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID,
@@ -35,6 +36,7 @@ enum st_lsm6dsx_hw_id {
 	ST_LSM6DSOX_ID,
 	ST_LSM6DSR_ID,
 	ST_LSM6DS3TRC_ID,
+	ST_LSM9DS1_ID,
 	ST_LSM6DSX_MAX_ID,
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index e0d2149625cc..2f3d2bf25646 100644
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
@@ -64,7 +73,72 @@
 #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
 #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
 
+#define ST_LSM9DSX_REG_GYRO_OUT_X_L_ADDR	0x18
+#define ST_LSM9DSX_REG_GYRO_OUT_Y_L_ADDR	0x1a
+#define ST_LSM9DSX_REG_GYRO_OUT_Z_L_ADDR	0x1c
+
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
+	{
+		.wai = 0x68,
+		.int1_addr = 0x0c,
+		.int2_addr = 0x0d,
+		.reset_addr = 0x22,
+		.max_fifo_size = 32,
+		.id = {
+			{
+				.hw_id = ST_LSM9DS1_ID,
+				.name = ST_LSM9DS1_DEV_NAME,
+			},
+		},
+		.odr_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x20,
+					.mask = GENMASK(7, 5),
+				},
+				.odr_avl[0] = {  10, 0x01 },
+				.odr_avl[1] = {  50, 0x02 },
+				.odr_avl[2] = { 119, 0x03 },
+				.odr_avl[3] = { 238, 0x04 },
+				.odr_avl[4] = { 476, 0x05 },
+				.odr_avl[5] = { 952, 0x06 },
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(7, 5),
+				},
+				.odr_avl[0] = {  15, 0x01 },
+				.odr_avl[1] = {  60, 0x02 },
+				.odr_avl[2] = { 119, 0x03 },
+				.odr_avl[3] = { 238, 0x04 },
+				.odr_avl[4] = { 476, 0x05 },
+				.odr_avl[5] = { 952, 0x06 },
+			},
+		},
+		.fs_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x20,
+					.mask = GENMASK(4, 3),
+				},
+				.fs_avl[0] = {  599, 0x0 },
+				.fs_avl[1] = { 1197, 0x2 },
+				.fs_avl[2] = { 2394, 0x3 },
+				.fs_avl[3] = { 4788, 0x1 },
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(4, 3),
+				},
+				.fs_avl[0] = { IIO_DEGREE_TO_RAD(245), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(500), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(0), 0x2 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
+			},
+		},
+	},
 	{
 		.wai = 0x69,
 		.int1_addr = 0x0d,
@@ -733,6 +807,16 @@ static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
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
@@ -1278,7 +1362,7 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 
 static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 					       enum st_lsm6dsx_sensor_id id,
-					       const char *name)
+					       const char *name, int hw_id)
 {
 	struct st_lsm6dsx_sensor *sensor;
 	struct iio_dev *iio_dev;
@@ -1308,7 +1392,11 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 			  name);
 		break;
 	case ST_LSM6DSX_ID_GYRO:
-		iio_dev->channels = st_lsm6dsx_gyro_channels;
+		if (hw_id == ST_LSM9DS1_ID)
+			iio_dev->channels = st_lsm9dsx_gyro_channels;
+		else
+			iio_dev->channels = st_lsm6dsx_gyro_channels;
+
 		iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_gyro_channels);
 		iio_dev->info = &st_lsm6dsx_gyro_info;
 
@@ -1354,7 +1442,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		return err;
 
 	for (i = 0; i < ST_LSM6DSX_ID_EXT0; i++) {
-		hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i, name);
+		hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i, name, hw_id);
 		if (!hw->iio_devs[i])
 			return -ENOMEM;
 	}
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 28581eb0532c..c36a057c36ee 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -79,6 +79,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,lsm6ds3tr-c",
 		.data = (void *)ST_LSM6DS3TRC_ID,
 	},
+	{
+		.compatible = "st,lsm9ds1",
+		.data = (void *)ST_LSM9DS1_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
@@ -94,6 +98,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
 	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
 	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
+	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 0371e8b94a3e..138e3b985865 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -79,6 +79,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,lsm6ds3tr-c",
 		.data = (void *)ST_LSM6DS3TRC_ID,
 	},
+	{
+		.compatible = "st,lsm9ds1",
+		.data = (void *)ST_LSM9DS1_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
@@ -94,6 +98,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
 	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
 	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
+	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
-- 
2.20.1

