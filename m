Return-Path: <linux-iio+bounces-24391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8A5B9917F
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 11:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AD31773FD
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 09:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398BA2D7DF1;
	Wed, 24 Sep 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPhnsIg6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01252D5923;
	Wed, 24 Sep 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705848; cv=none; b=ZvDQegYQfSiJ+i1r5gLn+bt73iBrTpqDhhA4Ic3X6VgP1UYml6Vyp7KxXhi8IQtyRJsqRLR83Y2czvQQ++mz7ti/0QnYG7D86DnXwUXPXSe6tZr5y8vGS6zc0pEeCfBce9SU6zvSZ8dTPoL5zvXrp9XRWEs2d1KAN2QXL1+7dI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705848; c=relaxed/simple;
	bh=+xbZi7StoAeiNKTZubEc0N7EBC+mmOS1zxGO5ARrR+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QsQWZ6iv2sP+aVXvRHMrKCkmSrW1ZXfdZcjp6LRk5IPuQA6w4hNPeTcAH+eO9Cp1u134QhakZTrDKKJygPBJ1rsM7grh3HrLEUsqwna+2/oGLW7pnFmKKeK9t4MysVp5JIb7SqVK14uH+nO9/X47CZnxKHwBoAOOp4zuKnlXCwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPhnsIg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75880C2BCB0;
	Wed, 24 Sep 2025 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758705847;
	bh=+xbZi7StoAeiNKTZubEc0N7EBC+mmOS1zxGO5ARrR+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qPhnsIg6Zf8xPSRcwIrZV5wZ4CUU+FtMkXc1s+NULpDhOq9J8K/kWj7rPVYPpa+4Z
	 hJS9JmD0mavFGI2bqpBVsqQ9jCpPbyD8rRaexaDWUgTa92voxsuDhjgDQVjE18zpHi
	 n+IMdEe8/+SrcwivBPranwh0PpNhWOMcnIVQYG6tmHRVvGuguuuLdZo4JxqkOvFRPH
	 SILvtQuxiuWI7NaLQXc1VhTqnCmivRXdqSeQDWt530AYf0DPjKWwFfJxjcDeTIqJj5
	 MkprQfBj56Lk/WJybmZAm14JJxu9rImzn8Gy6gqn18vjwaaXAFEJZpETKXlU5DYKZ6
	 uiQGbuU5LoiOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687E5CAC5A5;
	Wed, 24 Sep 2025 09:24:07 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Wed, 24 Sep 2025 09:23:55 +0000
Subject: [PATCH v6 2/9] iio: imu: inv_icm45600: add new inv_icm45600 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-add_newport_driver-v6-2-76687b9d8a6e@tdk.com>
References: <20250924-add_newport_driver-v6-0-76687b9d8a6e@tdk.com>
In-Reply-To: <20250924-add_newport_driver-v6-0-76687b9d8a6e@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758705845; l=32861;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=FtohEZKxWPyAyGRWvYLZKak1X6eGoafrvHlXQ+3c5o0=;
 b=EIdIvWmoSISpeB7dA21v3WDMljNgZtqKJZQPhdlGGLdJR9FLtHJs7MYav3q3WY6+90HvT5edz
 SOzM6p9sn6OC8tXXwgFno24aSPosgKhWG/OAej5RvtOF/zSkygQLeRm
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Core component of a new driver for InvenSense ICM-45600 devices.
It includes registers definition, main probe/setup, and device
utility functions.

ICM-456xx devices are latest generation of 6-axis IMU,
gyroscope+accelerometer and temperature sensor. This device
includes a 8K FIFO, supports I2C/I3C/SPI, and provides
intelligent motion features like pedometer, tilt detection,
and tap detection.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 drivers/iio/imu/Kconfig                          |   1 +
 drivers/iio/imu/Makefile                         |   1 +
 drivers/iio/imu/inv_icm45600/Kconfig             |   5 +
 drivers/iio/imu/inv_icm45600/Makefile            |   4 +
 drivers/iio/imu/inv_icm45600/inv_icm45600.h      | 331 ++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c | 623 +++++++++++++++++++++++
 6 files changed, 965 insertions(+)

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 15612f0f189b5114deb414ef840339678abdc562..9d732bed9fcdac12a13713dba3455c1fdf9f4a53 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -109,6 +109,7 @@ config KMX61
 	  be called kmx61.
 
 source "drivers/iio/imu/inv_icm42600/Kconfig"
+source "drivers/iio/imu/inv_icm45600/Kconfig"
 source "drivers/iio/imu/inv_mpu6050/Kconfig"
 
 config SMI240
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index e901aea498d37e5897e8b71268356a19eac2cb59..2ae6344f84699b2f85fff1c8077cb412f6ae2658 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_FXOS8700_I2C) += fxos8700_i2c.o
 obj-$(CONFIG_FXOS8700_SPI) += fxos8700_spi.o
 
 obj-y += inv_icm42600/
+obj-y += inv_icm45600/
 obj-y += inv_mpu6050/
 
 obj-$(CONFIG_KMX61) += kmx61.o
diff --git a/drivers/iio/imu/inv_icm45600/Kconfig b/drivers/iio/imu/inv_icm45600/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..8cb5543e0a5817323ab7b2d520dd3430ac5dbc99
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config INV_ICM45600
+	tristate
+	select IIO_INV_SENSORS_TIMESTAMP
diff --git a/drivers/iio/imu/inv_icm45600/Makefile b/drivers/iio/imu/inv_icm45600/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..4f442b61896e91647c7947a044949792bae06a30
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+obj-$(CONFIG_INV_ICM45600) += inv-icm45600.o
+inv-icm45600-y += inv_icm45600_core.o
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
new file mode 100644
index 0000000000000000000000000000000000000000..5f637e2f2ec8f1537459459dbb7e8a796d0ef7a6
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
@@ -0,0 +1,331 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2025 Invensense, Inc. */
+
+#ifndef INV_ICM45600_H_
+#define INV_ICM45600_H_
+
+#include <linux/bits.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/iio.h>
+
+#define INV_ICM45600_REG_BANK_MASK	GENMASK(15, 8)
+#define INV_ICM45600_REG_ADDR_MASK	GENMASK(7, 0)
+
+enum inv_icm45600_sensor_mode {
+	INV_ICM45600_SENSOR_MODE_OFF,
+	INV_ICM45600_SENSOR_MODE_STANDBY,
+	INV_ICM45600_SENSOR_MODE_LOW_POWER,
+	INV_ICM45600_SENSOR_MODE_LOW_NOISE,
+	INV_ICM45600_SENSOR_MODE_MAX
+};
+
+/* gyroscope fullscale values */
+enum inv_icm45600_gyro_fs {
+	INV_ICM45600_GYRO_FS_2000DPS,
+	INV_ICM45600_GYRO_FS_1000DPS,
+	INV_ICM45600_GYRO_FS_500DPS,
+	INV_ICM45600_GYRO_FS_250DPS,
+	INV_ICM45600_GYRO_FS_125DPS,
+	INV_ICM45600_GYRO_FS_62_5DPS,
+	INV_ICM45600_GYRO_FS_31_25DPS,
+	INV_ICM45600_GYRO_FS_15_625DPS,
+	INV_ICM45600_GYRO_FS_MAX
+};
+
+enum inv_icm45686_gyro_fs {
+	INV_ICM45686_GYRO_FS_4000DPS,
+	INV_ICM45686_GYRO_FS_2000DPS,
+	INV_ICM45686_GYRO_FS_1000DPS,
+	INV_ICM45686_GYRO_FS_500DPS,
+	INV_ICM45686_GYRO_FS_250DPS,
+	INV_ICM45686_GYRO_FS_125DPS,
+	INV_ICM45686_GYRO_FS_62_5DPS,
+	INV_ICM45686_GYRO_FS_31_25DPS,
+	INV_ICM45686_GYRO_FS_15_625DPS,
+	INV_ICM45686_GYRO_FS_MAX
+};
+
+/* accelerometer fullscale values */
+enum inv_icm45600_accel_fs {
+	INV_ICM45600_ACCEL_FS_16G,
+	INV_ICM45600_ACCEL_FS_8G,
+	INV_ICM45600_ACCEL_FS_4G,
+	INV_ICM45600_ACCEL_FS_2G,
+	INV_ICM45600_ACCEL_FS_MAX
+};
+
+enum inv_icm45686_accel_fs {
+	INV_ICM45686_ACCEL_FS_32G,
+	INV_ICM45686_ACCEL_FS_16G,
+	INV_ICM45686_ACCEL_FS_8G,
+	INV_ICM45686_ACCEL_FS_4G,
+	INV_ICM45686_ACCEL_FS_2G,
+	INV_ICM45686_ACCEL_FS_MAX
+};
+
+/* ODR suffixed by LN or LP are Low-Noise or Low-Power mode only */
+enum inv_icm45600_odr {
+	INV_ICM45600_ODR_6400HZ_LN = 0x03,
+	INV_ICM45600_ODR_3200HZ_LN,
+	INV_ICM45600_ODR_1600HZ_LN,
+	INV_ICM45600_ODR_800HZ_LN,
+	INV_ICM45600_ODR_400HZ,
+	INV_ICM45600_ODR_200HZ,
+	INV_ICM45600_ODR_100HZ,
+	INV_ICM45600_ODR_50HZ,
+	INV_ICM45600_ODR_25HZ,
+	INV_ICM45600_ODR_12_5HZ,
+	INV_ICM45600_ODR_6_25HZ_LP,
+	INV_ICM45600_ODR_3_125HZ_LP,
+	INV_ICM45600_ODR_1_5625HZ_LP,
+	INV_ICM45600_ODR_MAX
+};
+
+struct inv_icm45600_sensor_conf {
+	u8 mode;
+	u8 fs;
+	u8 odr;
+	u8 filter;
+};
+
+struct inv_icm45600_conf {
+	struct inv_icm45600_sensor_conf gyro;
+	struct inv_icm45600_sensor_conf accel;
+};
+
+struct inv_icm45600_suspended {
+	enum inv_icm45600_sensor_mode gyro;
+	enum inv_icm45600_sensor_mode accel;
+};
+
+struct inv_icm45600_chip_info {
+	u8 whoami;
+	const char *name;
+	const struct inv_icm45600_conf *conf;
+};
+
+/**
+ *  struct inv_icm45600_state - driver state variables
+ *  @lock:		lock for serializing multiple registers access.
+ *  @map:		regmap pointer.
+ *  @vddio_supply:	I/O voltage regulator for the chip.
+ *  @orientation:	sensor chip orientation relative to main hardware.
+ *  @conf:		chip sensors configurations.
+ *  @suspended:		suspended sensors configuration.
+ *  @indio_gyro:	gyroscope IIO device.
+ *  @indio_accel:	accelerometer IIO device.
+ *  @chip_info:		chip driver data.
+ *  @timestamp:		interrupt timestamps.
+ *  @buffer:		data transfer buffer aligned for DMA.
+ */
+struct inv_icm45600_state {
+	struct mutex lock;
+	struct regmap *map;
+	struct regulator *vddio_supply;
+	struct iio_mount_matrix orientation;
+	struct inv_icm45600_conf conf;
+	struct inv_icm45600_suspended suspended;
+	struct iio_dev *indio_gyro;
+	struct iio_dev *indio_accel;
+	const struct inv_icm45600_chip_info *chip_info;
+	struct {
+		s64 gyro;
+		s64 accel;
+	} timestamp;
+	union {
+		u8 buff[2];
+		__le16 u16;
+		u8 ireg[3];
+	} buffer __aligned(IIO_DMA_MINALIGN);
+};
+
+/**
+ * struct inv_icm45600_sensor_state - sensor state variables
+ * @scales:		table of scales.
+ * @scales_len:		length (nb of items) of the scales table.
+ * @power_mode:		sensor requested power mode (for common frequencies)
+ * @ts:			timestamp module states.
+ */
+struct inv_icm45600_sensor_state {
+	const int *scales;
+	size_t scales_len;
+	enum inv_icm45600_sensor_mode power_mode;
+	struct inv_sensors_timestamp ts;
+};
+
+/* Virtual register addresses: @bank on MSB (16 bits), @address on LSB */
+
+/* Indirect register access */
+#define INV_ICM45600_REG_IREG_ADDR			0x7C
+#define INV_ICM45600_REG_IREG_DATA			0x7E
+
+/* Direct acces registers */
+#define INV_ICM45600_REG_MISC2				0x007F
+#define INV_ICM45600_MISC2_SOFT_RESET			BIT(1)
+
+#define INV_ICM45600_REG_DRIVE_CONFIG0			0x0032
+#define INV_ICM45600_DRIVE_CONFIG0_SPI_MASK		GENMASK(3, 1)
+#define INV_ICM45600_SPI_SLEW_RATE_0_5NS		6
+#define INV_ICM45600_SPI_SLEW_RATE_4NS			5
+#define INV_ICM45600_SPI_SLEW_RATE_5NS			4
+#define INV_ICM45600_SPI_SLEW_RATE_7NS			3
+#define INV_ICM45600_SPI_SLEW_RATE_10NS			2
+#define INV_ICM45600_SPI_SLEW_RATE_14NS			1
+#define INV_ICM45600_SPI_SLEW_RATE_38NS			0
+
+#define INV_ICM45600_REG_INT1_CONFIG2			0x0018
+#define INV_ICM45600_INT1_CONFIG2_PUSH_PULL		BIT(2)
+#define INV_ICM45600_INT1_CONFIG2_LATCHED		BIT(1)
+#define INV_ICM45600_INT1_CONFIG2_ACTIVE_HIGH		BIT(0)
+#define INV_ICM45600_INT1_CONFIG2_ACTIVE_LOW		0x00
+
+#define INV_ICM45600_REG_FIFO_CONFIG0			0x001D
+#define INV_ICM45600_FIFO_CONFIG0_MODE_MASK		GENMASK(7, 6)
+#define INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS		0
+#define INV_ICM45600_FIFO_CONFIG0_MODE_STREAM		1
+#define INV_ICM45600_FIFO_CONFIG0_MODE_STOP_ON_FULL	2
+#define INV_ICM45600_FIFO_CONFIG0_FIFO_DEPTH_MAX	0x1F
+
+#define INV_ICM45600_REG_FIFO_CONFIG2			0x0020
+#define INV_ICM45600_REG_FIFO_CONFIG2_FIFO_FLUSH	BIT(7)
+#define INV_ICM45600_REG_FIFO_CONFIG2_WM_GT_TH		BIT(3)
+
+#define INV_ICM45600_REG_FIFO_CONFIG3			0x0021
+#define INV_ICM45600_FIFO_CONFIG3_ES1_EN		BIT(5)
+#define INV_ICM45600_FIFO_CONFIG3_ES0_EN		BIT(4)
+#define INV_ICM45600_FIFO_CONFIG3_HIRES_EN		BIT(3)
+#define INV_ICM45600_FIFO_CONFIG3_GYRO_EN		BIT(2)
+#define INV_ICM45600_FIFO_CONFIG3_ACCEL_EN		BIT(1)
+#define INV_ICM45600_FIFO_CONFIG3_IF_EN			BIT(0)
+
+#define INV_ICM45600_REG_FIFO_CONFIG4			0x0022
+#define INV_ICM45600_FIFO_CONFIG4_COMP_EN		BIT(2)
+#define INV_ICM45600_FIFO_CONFIG4_TMST_FSYNC_EN		BIT(1)
+#define INV_ICM45600_FIFO_CONFIG4_ES0_9B		BIT(0)
+
+/* all sensor data are 16 bits (2 registers wide) in big-endian */
+#define INV_ICM45600_REG_TEMP_DATA			0x000C
+#define INV_ICM45600_REG_ACCEL_DATA_X			0x0000
+#define INV_ICM45600_REG_ACCEL_DATA_Y			0x0002
+#define INV_ICM45600_REG_ACCEL_DATA_Z			0x0004
+#define INV_ICM45600_REG_GYRO_DATA_X			0x0006
+#define INV_ICM45600_REG_GYRO_DATA_Y			0x0008
+#define INV_ICM45600_REG_GYRO_DATA_Z			0x000A
+
+#define INV_ICM45600_REG_INT_STATUS			0x0019
+#define INV_ICM45600_INT_STATUS_RESET_DONE		BIT(7)
+#define INV_ICM45600_INT_STATUS_AUX1_AGC_RDY		BIT(6)
+#define INV_ICM45600_INT_STATUS_AP_AGC_RDY		BIT(5)
+#define INV_ICM45600_INT_STATUS_AP_FSYNC		BIT(4)
+#define INV_ICM45600_INT_STATUS_AUX1_DRDY		BIT(3)
+#define INV_ICM45600_INT_STATUS_DATA_RDY		BIT(2)
+#define INV_ICM45600_INT_STATUS_FIFO_THS		BIT(1)
+#define INV_ICM45600_INT_STATUS_FIFO_FULL		BIT(0)
+
+/*
+ * FIFO access registers
+ * FIFO count is 16 bits (2 registers)
+ * FIFO data is a continuous read register to read FIFO content
+ */
+#define INV_ICM45600_REG_FIFO_COUNT			0x0012
+#define INV_ICM45600_REG_FIFO_DATA			0x0014
+
+#define INV_ICM45600_REG_PWR_MGMT0			0x0010
+#define INV_ICM45600_PWR_MGMT0_GYRO_MODE_MASK		GENMASK(3, 2)
+#define INV_ICM45600_PWR_MGMT0_ACCEL_MODE_MASK		GENMASK(1, 0)
+
+#define INV_ICM45600_REG_ACCEL_CONFIG0			0x001B
+#define INV_ICM45600_ACCEL_CONFIG0_FS_MASK		GENMASK(6, 4)
+#define INV_ICM45600_ACCEL_CONFIG0_ODR_MASK		GENMASK(3, 0)
+#define INV_ICM45600_REG_GYRO_CONFIG0			0x001C
+#define INV_ICM45600_GYRO_CONFIG0_FS_MASK		GENMASK(7, 4)
+#define INV_ICM45600_GYRO_CONFIG0_ODR_MASK		GENMASK(3, 0)
+
+#define INV_ICM45600_REG_SMC_CONTROL_0			0xA258
+#define INV_ICM45600_SMC_CONTROL_0_ACCEL_LP_CLK_SEL	BIT(4)
+#define INV_ICM45600_SMC_CONTROL_0_TMST_EN		BIT(0)
+
+/* FIFO watermark is 16 bits (2 registers wide) in little-endian */
+#define INV_ICM45600_REG_FIFO_WATERMARK			0x001E
+
+/* FIFO is configured for 8kb */
+#define INV_ICM45600_FIFO_SIZE_MAX			SZ_8K
+
+#define INV_ICM45600_REG_INT1_CONFIG0			0x0016
+#define INV_ICM45600_INT1_CONFIG0_RESET_DONE_EN		BIT(7)
+#define INV_ICM45600_INT1_CONFIG0_AUX1_AGC_RDY_EN	BIT(6)
+#define INV_ICM45600_INT1_CONFIG0_AP_AGC_RDY_EN		BIT(5)
+#define INV_ICM45600_INT1_CONFIG0_AP_FSYNC_EN		BIT(4)
+#define INV_ICM45600_INT1_CONFIG0_AUX1_DRDY_EN		BIT(3)
+#define INV_ICM45600_INT1_CONFIG0_DRDY_EN		BIT(2)
+#define INV_ICM45600_INT1_CONFIG0_FIFO_THS_EN		BIT(1)
+#define INV_ICM45600_INT1_CONFIG0_FIFO_FULL_EN		BIT(0)
+
+#define INV_ICM45600_REG_WHOAMI				0x0072
+#define INV_ICM45600_WHOAMI_ICM45605			0xE5
+#define INV_ICM45600_WHOAMI_ICM45686			0xE9
+#define INV_ICM45600_WHOAMI_ICM45688P			0xE7
+#define INV_ICM45600_WHOAMI_ICM45608			0x81
+#define INV_ICM45600_WHOAMI_ICM45634			0x82
+#define INV_ICM45600_WHOAMI_ICM45689			0x83
+#define INV_ICM45600_WHOAMI_ICM45606			0x84
+#define INV_ICM45600_WHOAMI_ICM45687			0x85
+
+/* Gyro USER offset */
+#define INV_ICM45600_IPREG_SYS1_REG_42			0xA42A
+#define INV_ICM45600_IPREG_SYS1_REG_56			0xA438
+#define INV_ICM45600_IPREG_SYS1_REG_70			0xA446
+#define INV_ICM45600_GYRO_OFFUSER_MASK			GENMASK(13, 0)
+/* Gyro Averaging filter */
+#define INV_ICM45600_IPREG_SYS1_REG_170			0xA4AA
+#define INV_ICM45600_IPREG_SYS1_170_GYRO_LP_AVG_MASK	GENMASK(4, 1)
+#define INV_ICM45600_GYRO_LP_AVG_SEL_8X			5
+#define INV_ICM45600_GYRO_LP_AVG_SEL_2X			1
+/* Accel USER offset */
+#define INV_ICM45600_IPREG_SYS2_REG_24			0xA518
+#define INV_ICM45600_IPREG_SYS2_REG_32			0xA520
+#define INV_ICM45600_IPREG_SYS2_REG_40			0xA528
+#define INV_ICM45600_ACCEL_OFFUSER_MASK			GENMASK(13, 0)
+/* Accel averaging filter */
+#define INV_ICM45600_IPREG_SYS2_REG_129			0xA581
+#define INV_ICM45600_ACCEL_LP_AVG_SEL_1X		0x0000
+#define INV_ICM45600_ACCEL_LP_AVG_SEL_4X		0x0002
+
+/* Sleep times required by the driver */
+#define INV_ICM45600_ACCEL_STARTUP_TIME_MS	60
+#define INV_ICM45600_GYRO_STARTUP_TIME_MS	60
+#define INV_ICM45600_GYRO_STOP_TIME_MS		150
+#define INV_ICM45600_IREG_DELAY_US		4
+
+typedef int (*inv_icm45600_bus_setup)(struct inv_icm45600_state *);
+
+extern const struct dev_pm_ops inv_icm45600_pm_ops;
+
+const struct iio_mount_matrix *
+inv_icm45600_get_mount_matrix(const struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan);
+
+u32 inv_icm45600_odr_to_period(enum inv_icm45600_odr odr);
+
+int inv_icm45600_set_accel_conf(struct inv_icm45600_state *st,
+				struct inv_icm45600_sensor_conf *conf,
+				unsigned int *sleep_ms);
+
+int inv_icm45600_set_gyro_conf(struct inv_icm45600_state *st,
+			       struct inv_icm45600_sensor_conf *conf,
+			       unsigned int *sleep_ms);
+
+int inv_icm45600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval);
+
+int inv_icm45600_core_probe(struct regmap *regmap,
+				const struct inv_icm45600_chip_info *chip_info,
+				bool reset, inv_icm45600_bus_setup bus_setup);
+
+#endif
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
new file mode 100644
index 0000000000000000000000000000000000000000..04f04c72e1710efde0ab8e83f9ce26d28e102c9b
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
@@ -0,0 +1,623 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2025 Invensense, Inc. */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/limits.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+
+#include <linux/iio/iio.h>
+
+#include "inv_icm45600.h"
+
+static int inv_icm45600_ireg_read(struct regmap *map, unsigned int reg,
+				   u8 *data, size_t count)
+{
+	const struct device *dev = regmap_get_device(map);
+	struct inv_icm45600_state *st = dev_get_drvdata(dev);
+	unsigned int d;
+	size_t i;
+	int ret;
+
+	st->buffer.ireg[0] = FIELD_GET(INV_ICM45600_REG_BANK_MASK, reg);
+	st->buffer.ireg[1] = FIELD_GET(INV_ICM45600_REG_ADDR_MASK, reg);
+
+	/* Burst write address. */
+	ret = regmap_bulk_write(map, INV_ICM45600_REG_IREG_ADDR, st->buffer.ireg, 2);
+	/*
+	 * Wait while the device is busy processing the address.
+	 * Datasheet: 13.3 MINIMUM WAIT TIME-GAP
+	 */
+	fsleep(INV_ICM45600_IREG_DELAY_US);
+	if (ret)
+		return ret;
+
+	/* Read the data. */
+	for (i = 0; i < count; i++) {
+		ret = regmap_read(map, INV_ICM45600_REG_IREG_DATA, &d);
+		/*
+		 * Wait while the device is busy processing the address.
+		 * Datasheet: 13.3 MINIMUM WAIT TIME-GAP
+		 */
+		fsleep(INV_ICM45600_IREG_DELAY_US);
+		if (ret)
+			return ret;
+		data[i] = d;
+	}
+
+	return 0;
+}
+
+static int inv_icm45600_ireg_write(struct regmap *map, unsigned int reg,
+				   const u8 *data, size_t count)
+{
+	const struct device *dev = regmap_get_device(map);
+	struct inv_icm45600_state *st = dev_get_drvdata(dev);
+	size_t i;
+	int ret;
+
+	st->buffer.ireg[0] = FIELD_GET(INV_ICM45600_REG_BANK_MASK, reg);
+	st->buffer.ireg[1] = FIELD_GET(INV_ICM45600_REG_ADDR_MASK, reg);
+	st->buffer.ireg[2] = data[0];
+
+	/* Burst write address and first byte. */
+	ret = regmap_bulk_write(map, INV_ICM45600_REG_IREG_ADDR, st->buffer.ireg, 3);
+	/*
+	 * Wait while the device is busy processing the address.
+	 * Datasheet: 13.3 MINIMUM WAIT TIME-GAP
+	 */
+	fsleep(INV_ICM45600_IREG_DELAY_US);
+	if (ret)
+		return ret;
+
+	/* Write the remaining bytes. */
+	for (i = 1; i < count; i++) {
+		ret = regmap_write(map, INV_ICM45600_REG_IREG_DATA, data[i]);
+		/*
+		 * Wait while the device is busy processing the address.
+		 * Datasheet: 13.3 MINIMUM WAIT TIME-GAP
+		 */
+		fsleep(INV_ICM45600_IREG_DELAY_US);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int inv_icm45600_read(void *context, const void *reg_buf, size_t reg_size,
+			  void *val_buf, size_t val_size)
+{
+	unsigned int reg = be16_to_cpup(reg_buf);
+	struct regmap *map = context;
+
+	if (FIELD_GET(INV_ICM45600_REG_BANK_MASK, reg))
+		return inv_icm45600_ireg_read(map, reg, val_buf, val_size);
+
+	return regmap_bulk_read(map, FIELD_GET(INV_ICM45600_REG_ADDR_MASK, reg),
+				val_buf, val_size);
+}
+
+static int inv_icm45600_write(void *context, const void *data, size_t count)
+{
+	const u8 *d = data;
+	unsigned int reg = be16_to_cpup(data);
+	struct regmap *map = context;
+
+	if (FIELD_GET(INV_ICM45600_REG_BANK_MASK, reg))
+		return inv_icm45600_ireg_write(map, reg, d + 2, count - 2);
+
+	return regmap_bulk_write(map, FIELD_GET(INV_ICM45600_REG_ADDR_MASK, reg),
+				 d + 2, count - 2);
+}
+
+static const struct regmap_bus inv_icm45600_regmap_bus = {
+	.read = inv_icm45600_read,
+	.write = inv_icm45600_write,
+};
+
+static const struct regmap_config inv_icm45600_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+};
+
+const struct iio_mount_matrix *
+inv_icm45600_get_mount_matrix(const struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan)
+{
+	const struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+
+	return &st->orientation;
+}
+
+u32 inv_icm45600_odr_to_period(enum inv_icm45600_odr odr)
+{
+	static const u32 odr_periods[INV_ICM45600_ODR_MAX] = {
+		0,		/* reserved value */
+		0,		/* reserved value */
+		0,		/* reserved value */
+		156250,		/* 6.4kHz */
+		312500,		/* 3.2kHz */
+		625000,		/* 1.6kHz */
+		1250000,	/* 800kHz */
+		2500000,	/* 400Hz */
+		5000000,	/* 200Hz */
+		10000000,	/* 100Hz */
+		20000000,	/* 50Hz */
+		40000000,	/* 25Hz */
+		80000000,	/* 12.5Hz */
+		160000000,	/* 6.25Hz */
+		320000000,	/* 3.125Hz */
+		640000000,	/* 1.5625Hz */
+	};
+
+	return odr_periods[odr];
+}
+
+static int inv_icm45600_set_pwr_mgmt0(struct inv_icm45600_state *st,
+				      enum inv_icm45600_sensor_mode gyro,
+				      enum inv_icm45600_sensor_mode accel,
+				      unsigned int *sleep_ms)
+{
+	enum inv_icm45600_sensor_mode oldgyro = st->conf.gyro.mode;
+	enum inv_icm45600_sensor_mode oldaccel = st->conf.accel.mode;
+	unsigned int sleepval;
+	unsigned int val;
+	int ret;
+
+	/* if nothing changed, exit */
+	if (gyro == oldgyro && accel == oldaccel)
+		return 0;
+
+	val = FIELD_PREP(INV_ICM45600_PWR_MGMT0_GYRO_MODE_MASK, gyro) |
+	      FIELD_PREP(INV_ICM45600_PWR_MGMT0_ACCEL_MODE_MASK, accel);
+	ret = regmap_write(st->map, INV_ICM45600_REG_PWR_MGMT0, val);
+	if (ret)
+		return ret;
+
+	st->conf.gyro.mode = gyro;
+	st->conf.accel.mode = accel;
+
+	/* Compute the required wait time for sensors to stabilize. */
+	sleepval = 0;
+	if (accel != oldaccel && oldaccel == INV_ICM45600_SENSOR_MODE_OFF)
+		sleepval = max(sleepval, INV_ICM45600_ACCEL_STARTUP_TIME_MS);
+
+	if (gyro != oldgyro) {
+		if (oldgyro == INV_ICM45600_SENSOR_MODE_OFF)
+			sleepval = max(sleepval, INV_ICM45600_GYRO_STARTUP_TIME_MS);
+		else if (gyro == INV_ICM45600_SENSOR_MODE_OFF)
+			sleepval = max(sleepval, INV_ICM45600_GYRO_STOP_TIME_MS);
+	}
+
+	/* Deferred sleep value if sleep pointer is provided or direct sleep */
+	if (sleep_ms)
+		*sleep_ms = sleepval;
+	else if (sleepval)
+		msleep(sleepval);
+
+	return 0;
+}
+
+static void inv_icm45600_set_default_conf(struct inv_icm45600_sensor_conf *conf,
+					  struct inv_icm45600_sensor_conf *oldconf)
+{
+	/* Sanitize missing values with current values. */
+	if (conf->mode == U8_MAX)
+		conf->mode = oldconf->mode;
+	if (conf->fs == U8_MAX)
+		conf->fs = oldconf->fs;
+	if (conf->odr == U8_MAX)
+		conf->odr = oldconf->odr;
+	if (conf->filter == U8_MAX)
+		conf->filter = oldconf->filter;
+}
+
+int inv_icm45600_set_accel_conf(struct inv_icm45600_state *st,
+				struct inv_icm45600_sensor_conf *conf,
+				unsigned int *sleep_ms)
+{
+	struct inv_icm45600_sensor_conf *oldconf = &st->conf.accel;
+	unsigned int val;
+	int ret;
+
+	inv_icm45600_set_default_conf(conf, oldconf);
+
+	/* Force the power mode against the ODR when sensor is on. */
+	if (conf->mode > INV_ICM45600_SENSOR_MODE_STANDBY) {
+		if (conf->odr <= INV_ICM45600_ODR_800HZ_LN) {
+			conf->mode = INV_ICM45600_SENSOR_MODE_LOW_NOISE;
+		} else {
+			conf->mode = INV_ICM45600_SENSOR_MODE_LOW_POWER;
+			/* sanitize averaging value depending on ODR for low-power mode */
+			/* maximum 1x @400Hz */
+			if (conf->odr == INV_ICM45600_ODR_400HZ)
+				conf->filter = INV_ICM45600_ACCEL_LP_AVG_SEL_1X;
+			else
+				conf->filter = INV_ICM45600_ACCEL_LP_AVG_SEL_4X;
+		}
+	}
+
+	/* Set accel fullscale & odr. */
+	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
+		val = FIELD_PREP(INV_ICM45600_ACCEL_CONFIG0_FS_MASK, conf->fs) |
+		      FIELD_PREP(INV_ICM45600_ACCEL_CONFIG0_ODR_MASK, conf->odr);
+		ret = regmap_write(st->map, INV_ICM45600_REG_ACCEL_CONFIG0, val);
+		if (ret)
+			return ret;
+		oldconf->fs = conf->fs;
+		oldconf->odr = conf->odr;
+	}
+
+	/* Set accel low-power average filter. */
+	if (conf->filter != oldconf->filter) {
+		ret = regmap_write(st->map, INV_ICM45600_IPREG_SYS2_REG_129,
+				   conf->filter);
+		if (ret)
+			return ret;
+		oldconf->filter = conf->filter;
+	}
+
+	/* Update the sensor accel mode. */
+	return inv_icm45600_set_pwr_mgmt0(st, st->conf.gyro.mode, conf->mode,
+					  sleep_ms);
+}
+
+int inv_icm45600_set_gyro_conf(struct inv_icm45600_state *st,
+			       struct inv_icm45600_sensor_conf *conf,
+			       unsigned int *sleep_ms)
+{
+	struct inv_icm45600_sensor_conf *oldconf = &st->conf.gyro;
+	unsigned int val;
+	int ret;
+
+	inv_icm45600_set_default_conf(conf, oldconf);
+
+	/* Force the power mode against ODR when sensor is on. */
+	if (conf->mode > INV_ICM45600_SENSOR_MODE_STANDBY) {
+		if (conf->odr >= INV_ICM45600_ODR_6_25HZ_LP) {
+			conf->mode = INV_ICM45600_SENSOR_MODE_LOW_POWER;
+			conf->filter = INV_ICM45600_GYRO_LP_AVG_SEL_8X;
+		} else {
+			conf->mode = INV_ICM45600_SENSOR_MODE_LOW_NOISE;
+		}
+	}
+
+	/* Set gyro fullscale & odr. */
+	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
+		val = FIELD_PREP(INV_ICM45600_GYRO_CONFIG0_FS_MASK, conf->fs) |
+		      FIELD_PREP(INV_ICM45600_GYRO_CONFIG0_ODR_MASK, conf->odr);
+		ret = regmap_write(st->map, INV_ICM45600_REG_GYRO_CONFIG0, val);
+		if (ret)
+			return ret;
+		oldconf->fs = conf->fs;
+		oldconf->odr = conf->odr;
+	}
+
+	/* Set gyro low-power average filter. */
+	if (conf->filter != oldconf->filter) {
+		val = FIELD_PREP(INV_ICM45600_IPREG_SYS1_170_GYRO_LP_AVG_MASK, conf->filter);
+		ret = regmap_update_bits(st->map, INV_ICM45600_IPREG_SYS1_REG_170,
+					 INV_ICM45600_IPREG_SYS1_170_GYRO_LP_AVG_MASK, val);
+		if (ret)
+			return ret;
+		oldconf->filter = conf->filter;
+	}
+
+	/* Update the sensor gyro mode. */
+	return inv_icm45600_set_pwr_mgmt0(st, conf->mode, st->conf.accel.mode,
+					  sleep_ms);
+}
+
+int inv_icm45600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+
+	guard(mutex)(&st->lock);
+
+	if (readval)
+		return regmap_read(st->map, reg, readval);
+	else
+		return regmap_write(st->map, reg, writeval);
+}
+
+static int inv_icm45600_set_conf(struct inv_icm45600_state *st,
+				 const struct inv_icm45600_conf *conf)
+{
+	unsigned int val;
+	int ret;
+
+	val = FIELD_PREP(INV_ICM45600_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode) |
+	      FIELD_PREP(INV_ICM45600_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);
+	ret = regmap_write(st->map, INV_ICM45600_REG_PWR_MGMT0, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(INV_ICM45600_GYRO_CONFIG0_FS_MASK, conf->gyro.fs) |
+	      FIELD_PREP(INV_ICM45600_GYRO_CONFIG0_ODR_MASK, conf->gyro.odr);
+	ret = regmap_write(st->map, INV_ICM45600_REG_GYRO_CONFIG0, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(INV_ICM45600_ACCEL_CONFIG0_FS_MASK, conf->accel.fs) |
+	      FIELD_PREP(INV_ICM45600_ACCEL_CONFIG0_ODR_MASK, conf->accel.odr);
+	ret = regmap_write(st->map, INV_ICM45600_REG_ACCEL_CONFIG0, val);
+	if (ret)
+		return ret;
+
+	/* Save configuration. */
+	st->conf = *conf;
+
+	return 0;
+}
+
+/**
+ *  inv_icm45600_setup() - check and setup chip
+ *  @st:	driver internal state
+ *  @chip_info:	detected chip description
+ *  @reset:	define whether a reset is required or not
+ *  @bus_setup:	callback for setting up bus specific registers
+ *
+ *  Returns: 0 on success, a negative error code otherwise.
+ */
+static int inv_icm45600_setup(struct inv_icm45600_state *st,
+				const struct inv_icm45600_chip_info *chip_info,
+				bool reset, inv_icm45600_bus_setup bus_setup)
+{
+	const struct device *dev = regmap_get_device(st->map);
+	unsigned int val;
+	int ret;
+
+	/* Set chip bus configuration if specified. */
+	if (bus_setup) {
+		ret = bus_setup(st);
+		if (ret)
+			return ret;
+	}
+
+	/* Check chip self-identification value. */
+	ret = regmap_read(st->map, INV_ICM45600_REG_WHOAMI, &val);
+	if (ret)
+		return ret;
+	if (val != chip_info->whoami) {
+		/*
+		 * SPI interface has no ack mechanism.
+		 * 0xFF or 0x00 wwhoami means no response from the device.
+		 */
+		if (val == U8_MAX || val == 0)
+			return dev_err_probe(dev, -ENODEV,
+					     "Invalid whoami %#02x expected %#02x (%s)\n",
+					     val, chip_info->whoami, chip_info->name);
+
+		dev_warn(dev, "Unexpected whoami %#02x expected %#02x (%s)\n",
+			 val, chip_info->whoami, chip_info->name);
+	}
+
+	st->chip_info = chip_info;
+
+	if (reset) {
+		/* Reset previous state. */
+		ret = regmap_write(st->map, INV_ICM45600_REG_MISC2,
+				   INV_ICM45600_MISC2_SOFT_RESET);
+		if (ret)
+			return ret;
+		/*
+		 * IMU reset time.
+		 * Datasheet: 16.84 REG_MISC2
+		 */
+		fsleep(USEC_PER_MSEC);
+
+		if (bus_setup) {
+			ret = bus_setup(st);
+			if (ret)
+				return ret;
+		}
+
+		ret = regmap_read(st->map, INV_ICM45600_REG_INT_STATUS, &val);
+		if (ret)
+			return ret;
+		if (!(val & INV_ICM45600_INT_STATUS_RESET_DONE)) {
+			dev_err(dev, "reset error, reset done bit not set\n");
+			return -ENODEV;
+		}
+	}
+
+	return inv_icm45600_set_conf(st, chip_info->conf);
+}
+
+static int inv_icm45600_timestamp_setup(struct inv_icm45600_state *st)
+{
+	/* Enable timestamps. */
+	return regmap_set_bits(st->map, INV_ICM45600_REG_SMC_CONTROL_0,
+			       INV_ICM45600_SMC_CONTROL_0_TMST_EN);
+}
+
+static int inv_icm45600_enable_regulator_vddio(struct inv_icm45600_state *st)
+{
+	int ret;
+
+	ret = regulator_enable(st->vddio_supply);
+	if (ret)
+		return ret;
+
+	/*
+	 * Wait a little for supply ramp.
+	 * Duration is empirically defined.
+	 */
+	fsleep(3 * USEC_PER_MSEC);
+
+	return 0;
+}
+
+static void inv_icm45600_disable_vddio_reg(void *_data)
+{
+	struct inv_icm45600_state *st = _data;
+	struct device *dev = regmap_get_device(st->map);
+
+	if (pm_runtime_status_suspended(dev))
+		return;
+
+	regulator_disable(st->vddio_supply);
+}
+
+int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chip_info *chip_info,
+			    bool reset, inv_icm45600_bus_setup bus_setup)
+{
+	struct device *dev = regmap_get_device(regmap);
+	struct inv_icm45600_state *st;
+	struct regmap *regmap_custom;
+	int ret;
+
+	regmap_custom = devm_regmap_init(dev, &inv_icm45600_regmap_bus, regmap,
+					 &inv_icm45600_regmap_config);
+	if (IS_ERR(regmap_custom))
+		return dev_err_probe(dev, PTR_ERR(regmap_custom), "Failed to register regmap\n");
+
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, st);
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	st->map = regmap_custom;
+
+	ret = iio_read_mount_matrix(dev, &st->orientation);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to retrieve mounting matrix\n");
+
+	st->vddio_supply = devm_regulator_get(dev, "vddio");
+	if (IS_ERR(st->vddio_supply))
+		return PTR_ERR(st->vddio_supply);
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get vdd regulator\n");
+
+	/*
+	 * Supply ramp time + Start-up time.
+	 * Datasheet: 3.3.2 A.C. Electrical Characteristics
+	 */
+	fsleep(5 * USEC_PER_MSEC);
+
+	ret = inv_icm45600_enable_regulator_vddio(st);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, inv_icm45600_disable_vddio_reg, st);
+	if (ret)
+		return ret;
+
+	ret = inv_icm45600_setup(st, chip_info, reset, bus_setup);
+	if (ret)
+		return ret;
+
+	ret = inv_icm45600_timestamp_setup(st);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_autosuspend_delay(dev, 2 * USEC_PER_MSEC);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_put(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(inv_icm45600_core_probe, "IIO_ICM45600");
+
+/*
+ * Suspend saves sensors state and turns everything off.
+ */
+static int inv_icm45600_suspend(struct device *dev)
+{
+	struct inv_icm45600_state *st = dev_get_drvdata(dev);
+
+	scoped_guard(mutex, &st->lock) {
+		/* Save sensors states */
+		st->suspended.gyro = st->conf.gyro.mode;
+		st->suspended.accel = st->conf.accel.mode;
+	}
+
+	return pm_runtime_force_suspend(dev);
+}
+
+/*
+ * System resume gets the system back on and restores the sensors state.
+ * Manually put runtime power management in system active state.
+ */
+static int inv_icm45600_resume(struct device *dev)
+{
+	struct inv_icm45600_state *st = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &st->lock) {
+		/* Restore sensors state. */
+		ret = inv_icm45600_set_pwr_mgmt0(st, st->suspended.gyro,
+						 st->suspended.accel, NULL);
+	}
+
+	return ret;
+}
+
+/* Runtime suspend will turn off sensors that are enabled by iio devices. */
+static int inv_icm45600_runtime_suspend(struct device *dev)
+{
+	struct inv_icm45600_state *st = dev_get_drvdata(dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	/* disable all sensors */
+	ret = inv_icm45600_set_pwr_mgmt0(st, INV_ICM45600_SENSOR_MODE_OFF,
+					 INV_ICM45600_SENSOR_MODE_OFF, NULL);
+	if (ret)
+		return ret;
+
+	regulator_disable(st->vddio_supply);
+
+	return 0;
+}
+
+/* Sensors are enabled by iio devices, no need to turn them back on here. */
+static int inv_icm45600_runtime_resume(struct device *dev)
+{
+	struct inv_icm45600_state *st = dev_get_drvdata(dev);
+
+	guard(mutex)(&st->lock);
+
+	return inv_icm45600_enable_regulator_vddio(st);
+}
+
+EXPORT_NS_GPL_DEV_PM_OPS(inv_icm45600_pm_ops, IIO_ICM45600) = {
+	SYSTEM_SLEEP_PM_OPS(inv_icm45600_suspend, inv_icm45600_resume)
+	RUNTIME_PM_OPS(inv_icm45600_runtime_suspend,
+			   inv_icm45600_runtime_resume, NULL)
+};
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense ICM-456xx device driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_INV_SENSORS_TIMESTAMP");

-- 
2.34.1



