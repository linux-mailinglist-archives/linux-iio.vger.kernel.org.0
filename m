Return-Path: <linux-iio+bounces-17945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 300E0A85EEE
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5791A1894273
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FFF1ACED1;
	Fri, 11 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEgwnzCb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE7D19DF5B;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378122; cv=none; b=nVYKTpDQncRFjPL3oFJEKz9l1FvqL44cfI7PbqYY+faquN6TIUOzgD51fPm065q9+B6clFRXW9w/NUGTx7STc+ln+8GRu1df+AwRXCdF6ea2fAJ6PduC/rnTLMR1qN9D14MgV2AZOza5OeZqYn75mIFY5/uRYFdlolFDO793rFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378122; c=relaxed/simple;
	bh=Yx7UoGOLaHGrDnmANbmMF99mA9ZlaNx+pyRCw79KUgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s71wdN/E6qd/G7HAiLvrCtiwHpyeF/rCOZZ/U54RiQGOcPwz6a4BU3RaCcVBdx8svWTTVHTwwLRzlaTdsxMIVcZHJiRG04kmOb0VwQxy0o4MKm37y/VWgWeG1Eg12w7d/0gi0MoH0Z5aLsLA5KZBEsdIaFJ5mWzLHKnLygmWM/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEgwnzCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A314C4CEE7;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744378121;
	bh=Yx7UoGOLaHGrDnmANbmMF99mA9ZlaNx+pyRCw79KUgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eEgwnzCboyUCxs2FNhuPCN7ANlY4RbqkQA9iANxjvvm8/a41DjV86uuZ9jW1+c68d
	 aAQJ81VyEpRRY2GhGMAm05Y9XfNtqSS3n1aAQkWgoL0Z7pWCdbI6etvm1gZWfGUWUa
	 CQjdKOA92JwdFii78sW++ImjibwWxSxI0JZpFcFFWzSjJdZwxwktIsV9THaDGRyF5i
	 BTcxx5n7682Yv3XtebEV2mFHWnx3iuWWkmI8cTAKepuvGnJQYzXj20v3JhPiiaxCch
	 4a4ksfxFDTZ4hJvhCsHa7lLwCKLVeVlvBG0ifMre8538pzm+9U2Hw20nK5MjBA1aog
	 PsoH6Db6GbrFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B4CC369AD;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Fri, 11 Apr 2025 13:28:33 +0000
Subject: [PATCH 1/8] iio: imu: inv_icm45600: add new inv_icm45600 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-add_newport_driver-v1-1-15082160b019@tdk.com>
References: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
In-Reply-To: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744378119; l=100545;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=QO89jpUHe1g0Q9p9/sAfufif+vuMcR0Ec4HUUU9g/Cg=;
 b=mQWbZdHGlKF5n73GzJoT3RtU9CSboz5g4jCnIwjd3KPX7OhKjDpYsMmx7dRVXogt4pq6mQWaG
 ol5/wLbZ5wIDwOJ8TtlMZ55hmiAuMgqhx8/NhqXaeowel4e064ORRWz
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Core component of a new driver for InvenSense ICM-456xx devices.
It includes:
- registers definition, main probe/setup, and device
utility functions.
- IIO device for gyroscope sensor with data polling interface.
Attributes: raw, scale, sampling_frequency, calibbias.
- IIO device for gyroscope sensor with data polling interface.
Attributes: raw, scale, sampling_frequency, calibbias.
- Temperature is available as a processed
channel

ICM-456xx devices are latest generation of 6-axis IMU,
gyroscope+accelerometer and temperature sensor. This device
includes a 8K FIFO, supports I2C/I3C/SPI, and provides
intelligent motion features like pedometer, tilt detection,
and tap detection.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 drivers/iio/imu/inv_icm45600/inv_icm45600.h       | 421 ++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c | 902 +++++++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c  | 906 +++++++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c  | 919 ++++++++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_temp.c  |  82 ++
 drivers/iio/imu/inv_icm45600/inv_icm45600_temp.h  |  31 +
 6 files changed, 3261 insertions(+)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
new file mode 100644
index 0000000000000000000000000000000000000000..6d10b3ffabbcbc054986d6cc0011891863b74e1a
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
@@ -0,0 +1,421 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025 Invensense, Inc.
+ */
+
+#ifndef INV_ICM45600_H_
+#define INV_ICM45600_H_
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/iio.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include "inv_icm45600_buffer.h"
+
+#define INV_ICM45600_REG_GET_BANK(_r)	FIELD_GET(GENMASK(15, 8), (_r))
+#define INV_ICM45600_REG_GET_ADDR(_r)	FIELD_GET(GENMASK(7, 0), (_r))
+
+enum inv_icm45600_chip {
+	INV_CHIP_INVALID,
+	INV_CHIP_ICM45605,
+	INV_CHIP_ICM45686,
+	INV_CHIP_ICM45688P,
+	INV_CHIP_ICM45608,
+	INV_CHIP_ICM45634,
+	INV_CHIP_ICM45689,
+	INV_CHIP_ICM45606,
+	INV_CHIP_ICM45687,
+	INV_CHIP_NB,
+};
+
+enum inv_icm45600_sensor_mode {
+	INV_ICM45600_SENSOR_MODE_OFF,
+	INV_ICM45600_SENSOR_MODE_STANDBY,
+	INV_ICM45600_SENSOR_MODE_LOW_POWER,
+	INV_ICM45600_SENSOR_MODE_LOW_NOISE,
+	INV_ICM45600_SENSOR_MODE_NB,
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
+	INV_ICM45600_GYRO_FS_NB,
+};
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
+	INV_ICM45686_GYRO_FS_NB,
+};
+
+/* accelerometer fullscale values */
+enum inv_icm45600_accel_fs {
+	INV_ICM45600_ACCEL_FS_16G,
+	INV_ICM45600_ACCEL_FS_8G,
+	INV_ICM45600_ACCEL_FS_4G,
+	INV_ICM45600_ACCEL_FS_2G,
+	INV_ICM45600_ACCEL_FS_NB,
+};
+enum inv_icm45686_accel_fs {
+	INV_ICM45686_ACCEL_FS_32G,
+	INV_ICM45686_ACCEL_FS_16G,
+	INV_ICM45686_ACCEL_FS_8G,
+	INV_ICM45686_ACCEL_FS_4G,
+	INV_ICM45686_ACCEL_FS_2G,
+	INV_ICM45686_ACCEL_FS_NB,
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
+	INV_ICM45600_ODR_NB,
+};
+
+struct inv_icm45600_sensor_conf {
+	int mode;
+	int fs;
+	int odr;
+	int filter;
+};
+#define INV_ICM45600_SENSOR_CONF_INIT		{-1, -1, -1, -1}
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
+/**
+ *  struct inv_icm45600_state - driver state variables
+ *  @lock:		lock for serializing multiple registers access.
+ *  @chip:		chip identifier.
+ *  @name:		chip name.
+ *  @map:		regmap pointer.
+ *  @vdd_supply:	VDD voltage regulator for the chip.
+ *  @vddio_supply:	I/O voltage regulator for the chip.
+ *  @orientation:	sensor chip orientation relative to main hardware.
+ *  @conf:		chip sensors configurations.
+ *  @suspended:		suspended sensors configuration.
+ *  @indio_gyro:	gyroscope IIO device.
+ *  @indio_accel:	accelerometer IIO device.
+ *  @timestamp:		interrupt timestamps.
+ *  @fifo:		FIFO management structure.
+ *  @buffer:		data transfer buffer aligned for DMA.
+ */
+struct inv_icm45600_state {
+	struct mutex lock;
+	enum inv_icm45600_chip chip;
+	const char *name;
+	struct regmap *map;
+	struct regulator *vdd_supply;
+	struct regulator *vddio_supply;
+	struct iio_mount_matrix orientation;
+	struct inv_icm45600_conf conf;
+	struct inv_icm45600_suspended suspended;
+	struct iio_dev *indio_gyro;
+	struct iio_dev *indio_accel;
+	struct {
+		int64_t gyro;
+		int64_t accel;
+	} timestamp;
+	struct inv_icm45600_fifo fifo;
+	uint8_t buffer[2] __aligned(IIO_DMA_MINALIGN);
+};
+
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
+#define INV_ICM45600_DRIVE_CONFIG0_I2C_MASK		GENMASK(6, 4)
+#define INV_ICM45600_DRIVE_CONFIG0_I2C(_rate)		\
+		FIELD_PREP(INV_ICM45600_DRIVE_CONFIG0_I2C_MASK, (_rate))
+#define INV_ICM45600_I2C_SLEW_RATE_7NS				\
+		INV_ICM45600_DRIVE_CONFIG0_I2C(2)
+#define INV_ICM45600_I2C_SLEW_RATE_20NS				\
+		INV_ICM45600_DRIVE_CONFIG0_I2C(0)
+#define INV_ICM45600_DRIVE_CONFIG0_SPI_MASK		GENMASK(3, 1)
+#define INV_ICM45600_DRIVE_CONFIG0_SPI(_rate)		\
+		FIELD_PREP(INV_ICM45600_DRIVE_CONFIG0_SPI_MASK, (_rate))
+#define INV_ICM45600_SPI_SLEW_RATE_0_5NS			\
+		INV_ICM45600_DRIVE_CONFIG0_SPI(6)
+#define INV_ICM45600_SPI_SLEW_RATE_4NS				\
+		INV_ICM45600_DRIVE_CONFIG0_SPI(5)
+#define INV_ICM45600_SPI_SLEW_RATE_5NS				\
+		INV_ICM45600_DRIVE_CONFIG0_SPI(4)
+#define INV_ICM45600_SPI_SLEW_RATE_7NS				\
+		INV_ICM45600_DRIVE_CONFIG0_SPI(3)
+#define INV_ICM45600_SPI_SLEW_RATE_10NS				\
+		INV_ICM45600_DRIVE_CONFIG0_SPI(2)
+#define INV_ICM45600_SPI_SLEW_RATE_14NS				\
+		INV_ICM45600_DRIVE_CONFIG0_SPI(1)
+#define INV_ICM45600_SPI_SLEW_RATE_38NS				\
+		INV_ICM45600_DRIVE_CONFIG0_SPI(0)
+
+#define INV_ICM45600_REG_DRIVE_CONFIG1			0x0033
+#define INV_ICM45600_DRIVE_CONFIG1_I3C_DDR_SLEW_MASK	GENMASK(5, 3)
+#define INV_ICM45600_DRIVE_CONFIG1_I3C_DDR_SLEW(_rate)		\
+		FIELD_PREP(INV_ICM45600_DRIVE_CONFIG1_I3C_DDR_SLEW_MASK, (_rate))
+#define INV_ICM45600_I3C_DDR_SLEW_0_5NS				\
+		INV_ICM45600_DRIVE_CONFIG1_I3C_DDR_SLEW(6)
+#define INV_ICM45600_I3C_DDR_SLEW_4NS				\
+		INV_ICM45600_DRIVE_CONFIG1_I3C_DDR_SLEW(5)
+#define INV_ICM45600_I3C_DDR_SLEW_5NS				\
+		INV_ICM45600_DRIVE_CONFIG1_I3C_DDR_SLEW(4)
+#define INV_ICM45600_I3C_DDR_SLEW_7NS				\
+		INV_ICM45600_DRIVE_CONFIG1_I3C_DDR_SLEW(3)
+#define INV_ICM45600_I3C_DDR_SLEW_10NS				\
+		INV_ICM45600_DRIVE_CONFIG1_I3C_DDR_SLEW(2)
+#define INV_ICM45600_I3C_DDR_SLEW_14NS				\
+		INV_ICM45600_DRIVE_CONFIG1_I3C_DDR_SLEW(1)
+#define INV_ICM45600_I3C_DDR_SLEW_38NS				\
+		INV_ICM45600_DRIVE_CONFIG1_I3C_DDR_SLEW(0)
+#define INV_ICM45600_DRIVE_CONFIG1_I3C_SDR_SLEW_MASK	GENMASK(2, 0)
+#define INV_ICM45600_DRIVE_CONFIG1_I3C_SDR_SLEW(_rate)		\
+		FIELD_PREP(INV_ICM45600_DRIVE_CONFIG1_I3C_SDR_SLEW_MASK, (_rate))
+#define INV_ICM45600_I3C_SDR_SLEW_0_5NS				\
+		INV_ICM45600_DRIVE_CONFIG1_I3C_SDR_SLEW(6)
+#define INV_ICM45600_I3C_SDR_SLEW_4NS				\
+		INV_ICM45600_DRIVE_CONFIG1_I3C_SDR_SLEW(5)
+#define INV_ICM45600_I3C_SDR_SLEW_5NS				\
+		INV_ICM45600_DRIVE_CONFIG1_I3C_SDR_SLEW(4)
+#define INV_ICM45600_I3C_SDR_SLEW_7NS				\
+		INV_ICM45600_DRIVE_CONFIG1_I3C_SDR_SLEW(3)
+#define INV_ICM45600_I3C_SDR_SLEW_10NS				\
+		INV_ICM45600_DRIVE_CONFIG1_I3C_SDR_SLEW(2)
+#define INV_ICM45600_I3C_SDR_SLEW_14NS				\
+		INV_ICM45600_DRIVE_CONFIG1_I3C_SDR_SLEW(1)
+#define INV_ICM45600_I3C_SDR_SLEW_38NS				\
+		INV_ICM45600_DRIVE_CONFIG1_I3C_SDR_SLEW(0)
+
+#define INV_ICM45600_REG_INT1_CONFIG2			0x0018
+#define INV_ICM45600_INT1_CONFIG2_PUSH_PULL		BIT(2)
+#define INV_ICM45600_INT1_CONFIG2_LATCHED		BIT(1)
+#define INV_ICM45600_INT1_CONFIG2_ACTIVE_HIGH		BIT(0)
+#define INV_ICM45600_INT1_CONFIG2_ACTIVE_LOW		0x00
+
+#define INV_ICM45600_REG_FIFO_CONFIG0			0x001D
+#define INV_ICM45600_FIFO_CONFIG0_MODE_MASK		GENMASK(7, 6)
+#define INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS			\
+		FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK, 0)
+#define INV_ICM45600_FIFO_CONFIG0_MODE_STREAM			\
+		FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK, 1)
+#define INV_ICM45600_FIFO_CONFIG0_MODE_STOP_ON_FULL		\
+		FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK, 2)
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
+#define INV_ICM45600_DATA_INVALID			-32768
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
+#define INV_ICM45600_PWR_MGMT0_GYRO(_mode)		\
+		FIELD_PREP(GENMASK(3, 2), (_mode))
+#define INV_ICM45600_PWR_MGMT0_ACCEL(_mode)		\
+		FIELD_PREP(GENMASK(1, 0), (_mode))
+
+#define INV_ICM45600_REG_ACCEL_CONFIG0			0x001B
+#define INV_ICM45600_ACCEL_CONFIG0_FS_MASK		GENMASK(6, 4)
+#define INV_ICM45600_ACCEL_CONFIG0_FS(_fs)		\
+		FIELD_PREP(INV_ICM45600_ACCEL_CONFIG0_FS_MASK, (_fs))
+#define INV_ICM45600_ACCEL_CONFIG0_FS_16G		\
+		INV_ICM45600_ACCEL_CONFIG0_FS(1)
+#define INV_ICM45600_ACCEL_CONFIG0_ODR(_odr)		\
+		FIELD_PREP(GENMASK(3, 0), (_odr))
+#define INV_ICM45600_REG_GYRO_CONFIG0			0x001C
+#define INV_ICM45600_GYRO_CONFIG0_FS_MASK		GENMASK(7, 4)
+#define INV_ICM45600_GYRO_CONFIG0_FS(_fs)		\
+		FIELD_PREP(INV_ICM45600_GYRO_CONFIG0_FS_MASK, (_fs))
+#define INV_ICM45600_GYRO_CONFIG0_FS_2000DPS		\
+		INV_ICM45600_GYRO_CONFIG0_FS(1)
+#define INV_ICM45600_GYRO_CONFIG0_ODR(_odr)		\
+		FIELD_PREP(GENMASK(3, 0), (_odr))
+
+#define INV_ICM45600_REG_SMC_CONTROL_0			0xA258
+#define INV_ICM45600_SMC_CONTROL_0_ACCEL_LP_CLK_SEL	BIT(4)
+#define INV_ICM45600_SMC_CONTROL_0_TMST_EN		BIT(0)
+
+/* FIFO watermark is 16 bits (2 registers wide) in little-endian */
+#define INV_ICM45600_REG_FIFO_WATERMARK			0x001E
+#define INV_ICM45600_FIFO_WATERMARK_VAL(_wm)		\
+		cpu_to_le16(_wm)
+/* FIFO is configured for 8kb */
+#define INV_ICM45600_FIFO_SIZE_MAX			(8 * 1024)
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
+/* Gyro Averaging filter */
+#define INV_ICM45600_IPREG_SYS1_REG_170			0xA4AA
+#define INV_ICM45600_IPREG_SYS1_REG_170_MASK		GENMASK(4, 1)
+#define INV_ICM45600_GYRO_LP_AVG_SEL_8X			\
+	FIELD_PREP_CONST(INV_ICM45600_IPREG_SYS1_REG_170_MASK, 5)
+#define INV_ICM45600_GYRO_LP_AVG_SEL_2X			\
+	FIELD_PREP_CONST(INV_ICM45600_IPREG_SYS1_REG_170_MASK, 1)
+/* Accel USER offset */
+#define INV_ICM45600_IPREG_SYS2_REG_24			0xA518
+#define INV_ICM45600_IPREG_SYS2_REG_32			0xA520
+#define INV_ICM45600_IPREG_SYS2_REG_40			0xA528
+/* Accel averaging filter */
+#define INV_ICM45600_IPREG_SYS2_REG_129			0xA581
+#define INV_ICM45600_ACCEL_LP_AVG_SEL_4X		0x0002
+
+/* Sleep times required by the driver */
+#define INV_ICM45600_POWER_UP_TIME_MS		100
+#define INV_ICM45600_RESET_TIME_MS		1
+#define INV_ICM45600_ACCEL_STARTUP_TIME_MS	60
+#define INV_ICM45600_GYRO_STARTUP_TIME_MS	60
+#define INV_ICM45600_GYRO_STOP_TIME_MS		150
+#define INV_ICM45600_SUSPEND_DELAY_MS		2000
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
+uint32_t inv_icm45600_odr_to_period(enum inv_icm45600_odr odr);
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
+int inv_icm45600_core_probe(struct regmap *regmap, int chip,
+			    bool reset, inv_icm45600_bus_setup bus_setup);
+
+struct iio_dev *inv_icm45600_gyro_init(struct inv_icm45600_state *st);
+
+int inv_icm45600_gyro_parse_fifo(struct iio_dev *indio_dev);
+
+struct iio_dev *inv_icm45600_accel_init(struct inv_icm45600_state *st);
+
+int inv_icm45600_accel_parse_fifo(struct iio_dev *indio_dev);
+
+#endif
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c
new file mode 100644
index 0000000000000000000000000000000000000000..3c046cad83474da43509295dd5542e40b7a0296a
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c
@@ -0,0 +1,902 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Invensense, Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include "inv_icm45600_buffer.h"
+#include "inv_icm45600_temp.h"
+#include "inv_icm45600.h"
+
+#define INV_ICM45600_ACCEL_CHAN(_modifier, _index, _ext_info)		\
+	{								\
+		.type = IIO_ACCEL,					\
+		.modified = 1,						\
+		.channel2 = _modifier,					\
+		.info_mask_separate =					\
+			BIT(IIO_CHAN_INFO_RAW) |			\
+			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
+		.info_mask_shared_by_type =				\
+			BIT(IIO_CHAN_INFO_SCALE),			\
+		.info_mask_shared_by_type_available =			\
+			BIT(IIO_CHAN_INFO_SCALE) |			\
+			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
+		.info_mask_shared_by_all =				\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+		.info_mask_shared_by_all_available =			\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+		.scan_index = _index,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+			.endianness = IIO_LE,				\
+		},							\
+		.ext_info = _ext_info,					\
+	}
+
+enum inv_icm45600_accel_scan {
+	INV_ICM45600_ACCEL_SCAN_X,
+	INV_ICM45600_ACCEL_SCAN_Y,
+	INV_ICM45600_ACCEL_SCAN_Z,
+	INV_ICM45600_ACCEL_SCAN_TEMP,
+	INV_ICM45600_ACCEL_SCAN_TIMESTAMP,
+};
+
+static const char * const inv_icm45600_accel_power_mode_items[] = {
+	"low-noise",
+	"low-power",
+};
+static const int inv_icm45600_accel_power_mode_values[] = {
+	INV_ICM45600_SENSOR_MODE_LOW_NOISE,
+	INV_ICM45600_SENSOR_MODE_LOW_POWER,
+};
+
+static int inv_icm45600_accel_power_mode_set(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan,
+					     unsigned int idx)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *accel_st = iio_priv(indio_dev);
+	unsigned int val = 0;
+	int power_mode;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	if (idx >= ARRAY_SIZE(inv_icm45600_accel_power_mode_values))
+		return -EINVAL;
+
+	if (iio_buffer_enabled(indio_dev))
+		return -EBUSY;
+
+	power_mode = inv_icm45600_accel_power_mode_values[idx];
+
+	guard(mutex)(&st->lock);
+
+	/* prevent change if power mode is not supported by the ODR */
+	switch (power_mode) {
+	case INV_ICM45600_SENSOR_MODE_LOW_NOISE:
+		if (st->conf.accel.odr >= INV_ICM45600_ODR_6_25HZ_LP &&
+		    st->conf.accel.odr <= INV_ICM45600_ODR_1_5625HZ_LP)
+			return -EPERM;
+		break;
+	case INV_ICM45600_SENSOR_MODE_LOW_POWER:
+	default:
+		if (st->conf.accel.odr <= INV_ICM45600_ODR_800HZ_LN)
+			return -EPERM;
+		break;
+	}
+
+	accel_st->power_mode = power_mode;
+
+	if (accel_st->power_mode == INV_ICM45600_SENSOR_MODE_LOW_POWER)
+		val = INV_ICM45600_SMC_CONTROL_0_ACCEL_LP_CLK_SEL;
+
+	return regmap_update_bits(st->map, INV_ICM45600_REG_SMC_CONTROL_0,
+				INV_ICM45600_SMC_CONTROL_0_ACCEL_LP_CLK_SEL, val);
+}
+
+static int inv_icm45600_accel_power_mode_get(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *accel_st = iio_priv(indio_dev);
+	unsigned int idx;
+	int power_mode;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+
+	/* if sensor is on, returns actual power mode and not configured one */
+	switch (st->conf.accel.mode) {
+	case INV_ICM45600_SENSOR_MODE_LOW_POWER:
+	case INV_ICM45600_SENSOR_MODE_LOW_NOISE:
+		power_mode = st->conf.accel.mode;
+		break;
+	default:
+		power_mode = accel_st->power_mode;
+		break;
+	}
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm45600_accel_power_mode_values); ++idx) {
+		if (power_mode == inv_icm45600_accel_power_mode_values[idx])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm45600_accel_power_mode_values))
+		return -EINVAL;
+
+	return idx;
+}
+
+static const struct iio_enum inv_icm45600_accel_power_mode_enum = {
+	.items = inv_icm45600_accel_power_mode_items,
+	.num_items = ARRAY_SIZE(inv_icm45600_accel_power_mode_items),
+	.set = inv_icm45600_accel_power_mode_set,
+	.get = inv_icm45600_accel_power_mode_get,
+};
+
+static const struct iio_chan_spec_ext_info inv_icm45600_accel_ext_infos[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm45600_get_mount_matrix),
+	IIO_ENUM_AVAILABLE("power_mode", IIO_SHARED_BY_TYPE,
+			   &inv_icm45600_accel_power_mode_enum),
+	IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE,
+		 &inv_icm45600_accel_power_mode_enum),
+	{},
+};
+
+static const struct iio_chan_spec inv_icm45600_accel_channels[] = {
+	INV_ICM45600_ACCEL_CHAN(IIO_MOD_X, INV_ICM45600_ACCEL_SCAN_X,
+				inv_icm45600_accel_ext_infos),
+	INV_ICM45600_ACCEL_CHAN(IIO_MOD_Y, INV_ICM45600_ACCEL_SCAN_Y,
+				inv_icm45600_accel_ext_infos),
+	INV_ICM45600_ACCEL_CHAN(IIO_MOD_Z, INV_ICM45600_ACCEL_SCAN_Z,
+				inv_icm45600_accel_ext_infos),
+	INV_ICM45600_TEMP_CHAN(INV_ICM45600_ACCEL_SCAN_TEMP),
+	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM45600_ACCEL_SCAN_TIMESTAMP),
+};
+
+/*
+ * IIO buffer data: size must be a power of 2 and timestamp aligned
+ * 16 bytes: 6 bytes acceleration, 2 bytes temperature, 8 bytes timestamp
+ */
+struct inv_icm45600_accel_buffer {
+	struct inv_icm45600_fifo_sensor_data accel;
+	int16_t temp;
+	aligned_s64 timestamp;
+};
+
+#define INV_ICM45600_SCAN_MASK_ACCEL_3AXIS				\
+	(BIT(INV_ICM45600_ACCEL_SCAN_X) |				\
+	BIT(INV_ICM45600_ACCEL_SCAN_Y) |				\
+	BIT(INV_ICM45600_ACCEL_SCAN_Z))
+
+#define INV_ICM45600_SCAN_MASK_TEMP	BIT(INV_ICM45600_ACCEL_SCAN_TEMP)
+
+static const unsigned long inv_icm45600_accel_scan_masks[] = {
+	/* 3-axis accel + temperature */
+	INV_ICM45600_SCAN_MASK_ACCEL_3AXIS | INV_ICM45600_SCAN_MASK_TEMP,
+	0,
+};
+
+/* enable accelerometer sensor and FIFO write */
+static int inv_icm45600_accel_update_scan_mode(struct iio_dev *indio_dev,
+					       const unsigned long *scan_mask)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *accel_st = iio_priv(indio_dev);
+	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_INIT;
+	unsigned int fifo_en = 0;
+	unsigned int sleep_temp = 0;
+	unsigned int sleep_accel = 0;
+	unsigned int sleep;
+	int ret;
+
+	scoped_guard(mutex, &st->lock) {
+		if (*scan_mask & INV_ICM45600_SCAN_MASK_TEMP)
+			fifo_en |= INV_ICM45600_SENSOR_TEMP;
+
+		if (*scan_mask & INV_ICM45600_SCAN_MASK_ACCEL_3AXIS) {
+			/* enable accel sensor */
+			conf.mode = accel_st->power_mode;
+			ret = inv_icm45600_set_accel_conf(st, &conf, &sleep_accel);
+			if (ret)
+				break;
+			fifo_en |= INV_ICM45600_SENSOR_ACCEL;
+		}
+
+		/* update data FIFO write */
+		ret = inv_icm45600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
+	}
+
+	/* sleep maximum required time */
+	sleep = max(sleep_accel, sleep_temp);
+	if (sleep)
+		msleep(sleep);
+	return ret;
+}
+
+static int inv_icm45600_accel_read_sensor(struct iio_dev *indio_dev,
+					  struct iio_chan_spec const *chan,
+					  int16_t *val)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *accel_st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_INIT;
+	unsigned int reg;
+	__le16 *data;
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM45600_REG_ACCEL_DATA_X;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM45600_REG_ACCEL_DATA_Y;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM45600_REG_ACCEL_DATA_Z;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	pm_runtime_get_sync(dev);
+	scoped_guard(mutex, &st->lock) {
+		/* enable accel sensor */
+		conf.mode = accel_st->power_mode;
+		ret = inv_icm45600_set_accel_conf(st, &conf, NULL);
+		if (ret)
+			break;
+
+		/* read accel register data */
+		data = (__le16 *)&st->buffer[0];
+		ret = regmap_bulk_read(st->map, reg, data, sizeof(*data));
+		if (ret)
+			break;
+
+		*val = (int16_t)le16_to_cpup(data);
+		if (*val == INV_ICM45600_DATA_INVALID)
+			ret = -EINVAL;
+	}
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+/* IIO format int + nano */
+static const int inv_icm45600_accel_scale[] = {
+	/* +/- 16G => 0.004788403 m/s-2 */
+	[2 * INV_ICM45600_ACCEL_FS_16G] = 0,
+	[2 * INV_ICM45600_ACCEL_FS_16G + 1] = 4788403,
+	/* +/- 8G => 0.002394202 m/s-2 */
+	[2 * INV_ICM45600_ACCEL_FS_8G] = 0,
+	[2 * INV_ICM45600_ACCEL_FS_8G + 1] = 2394202,
+	/* +/- 4G => 0.001197101 m/s-2 */
+	[2 * INV_ICM45600_ACCEL_FS_4G] = 0,
+	[2 * INV_ICM45600_ACCEL_FS_4G + 1] = 1197101,
+	/* +/- 2G => 0.000598550 m/s-2 */
+	[2 * INV_ICM45600_ACCEL_FS_2G] = 0,
+	[2 * INV_ICM45600_ACCEL_FS_2G + 1] = 598550,
+};
+static const int inv_icm45686_accel_scale[] = {
+	/* +/- 32G => 0.009576806 m/s-2 */
+	[2 * INV_ICM45686_ACCEL_FS_32G] = 0,
+	[2 * INV_ICM45686_ACCEL_FS_32G + 1] = 9576806,
+	/* +/- 16G => 0.004788403 m/s-2 */
+	[2 * INV_ICM45686_ACCEL_FS_16G] = 0,
+	[2 * INV_ICM45686_ACCEL_FS_16G + 1] = 4788403,
+	/* +/- 8G => 0.002394202 m/s-2 */
+	[2 * INV_ICM45686_ACCEL_FS_8G] = 0,
+	[2 * INV_ICM45686_ACCEL_FS_8G + 1] = 2394202,
+	/* +/- 4G => 0.001197101 m/s-2 */
+	[2 * INV_ICM45686_ACCEL_FS_4G] = 0,
+	[2 * INV_ICM45686_ACCEL_FS_4G + 1] = 1197101,
+	/* +/- 2G => 0.000598550 m/s-2 */
+	[2 * INV_ICM45686_ACCEL_FS_2G] = 0,
+	[2 * INV_ICM45686_ACCEL_FS_2G + 1] = 598550,
+};
+
+static int inv_icm45600_accel_read_scale(struct iio_dev *indio_dev,
+					 int *val, int *val2)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *accel_st = iio_priv(indio_dev);
+	unsigned int idx;
+
+	idx = st->conf.accel.fs;
+
+	/* Full scale register starts at 1 for not High FSR parts */
+	if (accel_st->scales == inv_icm45600_accel_scale)
+		idx--;
+
+	*val = accel_st->scales[2 * idx];
+	*val2 = accel_st->scales[2 * idx + 1];
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int inv_icm45600_accel_write_scale(struct iio_dev *indio_dev,
+					  int val, int val2)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *accel_st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_INIT;
+	int ret;
+
+	for (idx = 0; idx < accel_st->scales_len; idx += 2) {
+		if (val == accel_st->scales[idx] &&
+		    val2 == accel_st->scales[idx + 1])
+			break;
+	}
+	if (idx >= accel_st->scales_len)
+		return -EINVAL;
+
+	conf.fs = idx / 2;
+
+	/* Full scale register starts at 1 for not High FSR parts */
+	if (accel_st->scales == inv_icm45600_accel_scale)
+		conf.fs++;
+
+	pm_runtime_get_sync(dev);
+	scoped_guard(mutex, &st->lock) {
+		ret = inv_icm45600_set_accel_conf(st, &conf, NULL);
+	}
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+/* IIO format int + micro */
+static const int inv_icm45600_accel_odr[] = {
+	/* 1.5625Hz */
+	1, 562500,
+	/* 3.125Hz */
+	3, 125000,
+	/* 6.25Hz */
+	6, 250000,
+	/* 12.5Hz */
+	12, 500000,
+	/* 25Hz */
+	25, 0,
+	/* 50Hz */
+	50, 0,
+	/* 100Hz */
+	100, 0,
+	/* 200Hz */
+	200, 0,
+	/* 400Hz */
+	400, 0,
+	/* 800Hz */
+	800, 0,
+	/* 1.6kHz */
+	1600, 0,
+	/* 3.2kHz */
+	3200, 0,
+	/* 6.4kHz */
+	6400, 0,
+};
+
+static const int inv_icm45600_accel_odr_conv[] = {
+	INV_ICM45600_ODR_1_5625HZ_LP,
+	INV_ICM45600_ODR_3_125HZ_LP,
+	INV_ICM45600_ODR_6_25HZ_LP,
+	INV_ICM45600_ODR_12_5HZ,
+	INV_ICM45600_ODR_25HZ,
+	INV_ICM45600_ODR_50HZ,
+	INV_ICM45600_ODR_100HZ,
+	INV_ICM45600_ODR_200HZ,
+	INV_ICM45600_ODR_400HZ,
+	INV_ICM45600_ODR_800HZ_LN,
+	INV_ICM45600_ODR_1600HZ_LN,
+	INV_ICM45600_ODR_3200HZ_LN,
+	INV_ICM45600_ODR_6400HZ_LN,
+};
+
+static int inv_icm45600_accel_read_odr(struct inv_icm45600_state *st,
+				       int *val, int *val2)
+{
+	unsigned int odr;
+	unsigned int i;
+
+	odr = st->conf.accel.odr;
+
+	for (i = 0; i < ARRAY_SIZE(inv_icm45600_accel_odr_conv); ++i) {
+		if (inv_icm45600_accel_odr_conv[i] == odr)
+			break;
+	}
+	if (i >= ARRAY_SIZE(inv_icm45600_accel_odr_conv))
+		return -EINVAL;
+
+	*val = inv_icm45600_accel_odr[2 * i];
+	*val2 = inv_icm45600_accel_odr[2 * i + 1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_icm45600_accel_write_odr(struct iio_dev *indio_dev,
+					int val, int val2)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *accel_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &accel_st->ts;
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_INIT;
+	int ret;
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm45600_accel_odr); idx += 2) {
+		if (val == inv_icm45600_accel_odr[idx] &&
+		    val2 == inv_icm45600_accel_odr[idx + 1])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm45600_accel_odr))
+		return -EINVAL;
+
+	conf.odr = inv_icm45600_accel_odr_conv[idx / 2];
+
+	pm_runtime_get_sync(dev);
+	scoped_guard(mutex, &st->lock) {
+		ret = inv_sensors_timestamp_update_odr(ts, inv_icm45600_odr_to_period(conf.odr),
+						iio_buffer_enabled(indio_dev));
+		if (ret)
+			break;
+
+		if (st->conf.accel.mode != INV_ICM45600_SENSOR_MODE_OFF)
+			conf.mode = accel_st->power_mode;
+		ret = inv_icm45600_set_accel_conf(st, &conf, NULL);
+		if (ret)
+			break;
+		inv_icm45600_buffer_update_fifo_period(st);
+		inv_icm45600_buffer_update_watermark(st);
+	}
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+/*
+ * Calibration bias values, IIO range format int + micro.
+ * Value is limited to +/-1g coded on 12 bits signed. Step is 0.5mg.
+ */
+static int inv_icm45600_accel_calibbias[] = {
+	-10, 42010,		/* min: -10.042010 m/s² */
+	0, 4903,		/* step: 0.004903 m/s² */
+	10, 37106,		/* max: 10.037106 m/s² */
+};
+
+static int inv_icm45600_accel_read_offset(struct inv_icm45600_state *st,
+					  struct iio_chan_spec const *chan,
+					  int *val, int *val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	int64_t val64;
+	int32_t bias;
+	unsigned int reg;
+	int16_t offset;
+	uint8_t data[2];
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM45600_IPREG_SYS2_REG_24;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM45600_IPREG_SYS2_REG_32;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM45600_IPREG_SYS2_REG_40;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	pm_runtime_get_sync(dev);
+	scoped_guard(mutex, &st->lock) {
+		ret = regmap_bulk_read(st->map, reg, st->buffer, sizeof(data));
+		memcpy(data, st->buffer, sizeof(data));
+	}
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	if (ret)
+		return ret;
+
+	/* 12 bits signed value */
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		offset = sign_extend32(((data[0] & 0xF0) << 4) | data[1], 11);
+		break;
+	case IIO_MOD_Y:
+		offset = sign_extend32(((data[1] & 0x0F) << 8) | data[0], 11);
+		break;
+	case IIO_MOD_Z:
+		offset = sign_extend32(((data[0] & 0xF0) << 4) | data[1], 11);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * convert raw offset to g then to m/s²
+	 * 12 bits signed raw step 0.5mg to g: 5 / 10000
+	 * g to m/s²: 9.806650
+	 * result in micro (1000000)
+	 * (offset * 5 * 9.806650 * 1000000) / 10000
+	 */
+	val64 = (int64_t)offset * 5LL * 9806650LL;
+	/* for rounding, add + or - divisor (10000) divided by 2 */
+	if (val64 >= 0)
+		val64 += 10000LL / 2LL;
+	else
+		val64 -= 10000LL / 2LL;
+	bias = div_s64(val64, 10000L);
+	*val = bias / 1000000L;
+	*val2 = bias % 1000000L;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_icm45600_accel_write_offset(struct inv_icm45600_state *st,
+					   struct iio_chan_spec const *chan,
+					   int val, int val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	int64_t val64;
+	int32_t min, max;
+	unsigned int reg;
+	int16_t offset;
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM45600_IPREG_SYS2_REG_24;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM45600_IPREG_SYS2_REG_32;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM45600_IPREG_SYS2_REG_40;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* inv_icm45600_accel_calibbias: min - step - max in micro */
+	min = inv_icm45600_accel_calibbias[0] * 1000000L +
+	      inv_icm45600_accel_calibbias[1];
+	max = inv_icm45600_accel_calibbias[4] * 1000000L +
+	      inv_icm45600_accel_calibbias[5];
+	val64 = (int64_t)val * 1000000LL + (int64_t)val2;
+	if (val64 < min || val64 > max)
+		return -EINVAL;
+
+	/*
+	 * convert m/s² to g then to raw value
+	 * m/s² to g: 1 / 9.806650
+	 * g to raw 14 bits signed, step 0.125mg: 1000000 / 125
+	 * val in micro (1000000)
+	 * val * 1000000 / (9.806650 * 1000000 * 125)
+	 */
+	val64 = val64 * 1000000LL;
+	/* for rounding, add + or - divisor (9806650 * 125) divided by 2 */
+	if (val64 >= 0)
+		val64 += 9806650 * 125 / 2;
+	else
+		val64 -= 9806650 * 125 / 2;
+	offset = div_s64(val64, 9806650 * 125);
+
+	/* clamp value limited to 14 bits signed */
+	if (offset < -8192)
+		offset = -8192;
+	else if (offset > 8191)
+		offset = 8191;
+
+	pm_runtime_get_sync(dev);
+	scoped_guard(mutex, &st->lock) {
+		ret = regmap_bulk_write(st->map, reg, st->buffer, 2);
+	}
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+static int inv_icm45600_accel_read_raw(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       int *val, int *val2, long mask)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	int16_t data;
+	int ret;
+
+	switch (chan->type) {
+	case IIO_ACCEL:
+		break;
+	case IIO_TEMP:
+		return inv_icm45600_temp_read_raw(indio_dev, chan, val, val2, mask);
+	default:
+		return -EINVAL;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm45600_accel_read_sensor(indio_dev, chan, &data);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		*val = data;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return inv_icm45600_accel_read_scale(indio_dev, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm45600_accel_read_odr(st, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm45600_accel_read_offset(st, chan, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm45600_accel_read_avail(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan,
+					 const int **vals,
+					 int *type, int *length, long mask)
+{
+	struct inv_icm45600_sensor_state *accel_st = iio_priv(indio_dev);
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = accel_st->scales;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = accel_st->scales_len;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = inv_icm45600_accel_odr;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(inv_icm45600_accel_odr);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*vals = inv_icm45600_accel_calibbias;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm45600_accel_write_raw(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					int val, int val2, long mask)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm45600_accel_write_scale(indio_dev, val, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm45600_accel_write_odr(indio_dev, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm45600_accel_write_offset(st, chan, val, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm45600_accel_write_raw_get_fmt(struct iio_dev *indio_dev,
+						struct iio_chan_spec const *chan,
+						long mask)
+{
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm45600_accel_hwfifo_set_watermark(struct iio_dev *indio_dev,
+						   unsigned int val)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	st->fifo.watermark.accel = val;
+	ret = inv_icm45600_buffer_update_watermark(st);
+
+	return ret;
+}
+
+static int inv_icm45600_accel_hwfifo_flush(struct iio_dev *indio_dev,
+					   unsigned int count)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	if (count == 0)
+		return 0;
+
+	guard(mutex)(&st->lock);
+
+	ret = inv_icm45600_buffer_hwfifo_flush(st, count);
+	if (!ret)
+		ret = st->fifo.nb.accel;
+
+	return ret;
+}
+
+static const struct iio_info inv_icm45600_accel_info = {
+	.read_raw = inv_icm45600_accel_read_raw,
+	.read_avail = inv_icm45600_accel_read_avail,
+	.write_raw = inv_icm45600_accel_write_raw,
+	.write_raw_get_fmt = inv_icm45600_accel_write_raw_get_fmt,
+	.debugfs_reg_access = inv_icm45600_debugfs_reg,
+	.update_scan_mode = inv_icm45600_accel_update_scan_mode,
+	.hwfifo_set_watermark = inv_icm45600_accel_hwfifo_set_watermark,
+	.hwfifo_flush_to_buffer = inv_icm45600_accel_hwfifo_flush,
+};
+
+struct iio_dev *inv_icm45600_accel_init(struct inv_icm45600_state *st)
+{
+	struct device *dev = regmap_get_device(st->map);
+	const char *name;
+	struct inv_icm45600_sensor_state *accel_st;
+	struct inv_sensors_timestamp_chip ts_chip;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "%s-accel", st->name);
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*accel_st));
+	if (!indio_dev)
+		return ERR_PTR(-ENOMEM);
+	accel_st = iio_priv(indio_dev);
+
+	switch (st->chip) {
+	case INV_CHIP_ICM45686:
+	case INV_CHIP_ICM45688P:
+	case INV_CHIP_ICM45689:
+	case INV_CHIP_ICM45687:
+		accel_st->scales = inv_icm45686_accel_scale;
+		accel_st->scales_len = ARRAY_SIZE(inv_icm45686_accel_scale);
+		break;
+	default:
+		accel_st->scales = inv_icm45600_accel_scale;
+		accel_st->scales_len = ARRAY_SIZE(inv_icm45600_accel_scale);
+		/* Set Accel default FSR */
+		ret = regmap_update_bits(st->map, INV_ICM45600_REG_ACCEL_CONFIG0,
+					INV_ICM45600_ACCEL_CONFIG0_FS_MASK,
+					INV_ICM45600_ACCEL_CONFIG0_FS_16G);
+		if (ret)
+			return ERR_PTR(ret);
+		break;
+	}
+	/* low-power (LP) mode by default at init, no ULP mode */
+	accel_st->power_mode = INV_ICM45600_SENSOR_MODE_LOW_POWER;
+	ret = regmap_set_bits(st->map, INV_ICM45600_REG_SMC_CONTROL_0,
+			      INV_ICM45600_SMC_CONTROL_0_ACCEL_LP_CLK_SEL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/*
+	 * clock period is 32kHz (31250ns)
+	 * jitter is +/- 2% (20 per mille)
+	 */
+	ts_chip.clock_period = 31250;
+	ts_chip.jitter = 20;
+	ts_chip.init_period = inv_icm45600_odr_to_period(st->conf.accel.odr);
+	inv_sensors_timestamp_init(&accel_st->ts, &ts_chip);
+
+	iio_device_set_drvdata(indio_dev, st);
+	indio_dev->name = name;
+	indio_dev->info = &inv_icm45600_accel_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = inv_icm45600_accel_channels;
+	indio_dev->num_channels = ARRAY_SIZE(inv_icm45600_accel_channels);
+	indio_dev->available_scan_masks = inv_icm45600_accel_scan_masks;
+
+	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
+					  &inv_icm45600_buffer_ops);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return indio_dev;
+}
+
+int inv_icm45600_accel_parse_fifo(struct iio_dev *indio_dev)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *accel_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &accel_st->ts;
+	ssize_t i, size;
+	unsigned int no;
+	const void *accel, *gyro, *timestamp;
+	const int8_t *temp;
+	unsigned int odr;
+	int64_t ts_val;
+	struct inv_icm45600_accel_buffer buffer;
+
+	/* parse all fifo packets */
+	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
+		size = inv_icm45600_fifo_decode_packet(&st->fifo.data[i],
+				&accel, &gyro, &temp, &timestamp, &odr);
+		/* quit if error or FIFO is empty */
+		if (size <= 0)
+			return size;
+
+		/* skip packet if no accel data or data is invalid */
+		if (accel == NULL || !inv_icm45600_fifo_is_data_valid(accel))
+			continue;
+
+		/* update odr */
+		if (odr & INV_ICM45600_SENSOR_ACCEL)
+			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
+							 st->fifo.nb.total, no);
+
+		/* buffer is copied to userspace, zeroing it to avoid any data leak */
+		memset(&buffer, 0, sizeof(buffer));
+		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
+		/* convert 8 bits FIFO temperature in high resolution format */
+		buffer.temp = temp ? (*temp * 64) : 0;
+		ts_val = inv_sensors_timestamp_pop(ts);
+		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
+	}
+
+	return 0;
+}
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
new file mode 100644
index 0000000000000000000000000000000000000000..66e9826005a9fecf5b154c0a1308a4c4f40c4edd
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
@@ -0,0 +1,906 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Invensense, Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#include "inv_icm45600_buffer.h"
+#include "inv_icm45600.h"
+
+static int inv_icm45600_ireg_read(struct regmap *map, unsigned int reg,
+				   unsigned int *data, size_t count)
+{
+	int ret;
+	uint8_t addr[2];
+	ssize_t i;
+
+	addr[0] = INV_ICM45600_REG_GET_BANK(reg);
+	addr[1] = INV_ICM45600_REG_GET_ADDR(reg);
+
+	/* Burst write address */
+	ret = regmap_bulk_write(map, INV_ICM45600_REG_IREG_ADDR, addr, 2);
+	udelay(INV_ICM45600_IREG_DELAY_US);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < count; i++) {
+		ret = regmap_read(map, INV_ICM45600_REG_IREG_DATA, &data[i]);
+		udelay(INV_ICM45600_IREG_DELAY_US);
+	}
+
+	return ret;
+}
+
+static int inv_icm45600_ireg_write(struct regmap *map, unsigned int reg,
+				   uint8_t *data, size_t count)
+{
+	int ret;
+	uint8_t addr_data0[3];
+	ssize_t i;
+
+	addr_data0[0] = INV_ICM45600_REG_GET_BANK(reg);
+	addr_data0[1] = INV_ICM45600_REG_GET_ADDR(reg);
+	addr_data0[2] = data[0];
+
+	/* Burst write address and first byte */
+	ret = regmap_bulk_write(map, INV_ICM45600_REG_IREG_ADDR, addr_data0, 3);
+	udelay(INV_ICM45600_IREG_DELAY_US);
+	if (ret)
+		return ret;
+
+	for (i = 1; i < count; i++) {
+		ret = regmap_write(map, INV_ICM45600_REG_IREG_DATA, data[i]);
+		udelay(INV_ICM45600_IREG_DELAY_US);
+	}
+
+	return ret;
+}
+
+static int inv_icm45600_read(void *context, const void *reg_buf, size_t reg_size,
+			  void *val_buf, size_t val_size)
+{
+	unsigned int reg = (unsigned int) be16_to_cpup(reg_buf);
+	struct regmap *map = context;
+
+	if (INV_ICM45600_REG_GET_BANK(reg) == 0)
+		return regmap_bulk_read(map, INV_ICM45600_REG_GET_ADDR(reg), val_buf,
+						val_size);
+
+	return inv_icm45600_ireg_read(map, reg, val_buf, val_size);
+}
+
+static int inv_icm45600_write(void *context, const void *data,
+				   size_t count)
+{
+	uint8_t *d = (uint8_t *)data;
+	unsigned int reg = (unsigned int) be16_to_cpup(data);
+	struct regmap *map = context;
+
+	if (INV_ICM45600_REG_GET_BANK(reg) == 0)
+		return regmap_bulk_write(map, INV_ICM45600_REG_GET_ADDR(reg),
+					d+2, count-2);
+
+	return inv_icm45600_ireg_write(map, reg, d+2, count-2);
+}
+
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
+struct inv_icm45600_hw {
+	uint8_t whoami;
+	const char *name;
+	const struct inv_icm45600_conf *conf;
+};
+
+/* chip initial default configuration (default FS value is based on icm45686) */
+static const struct inv_icm45600_conf inv_icm45600_default_conf = {
+	.gyro = {
+		.mode = INV_ICM45600_SENSOR_MODE_OFF,
+		.fs = INV_ICM45686_GYRO_FS_2000DPS,
+		.odr = INV_ICM45600_ODR_800HZ_LN,
+		.filter = INV_ICM45600_GYRO_LP_AVG_SEL_8X,
+	},
+	.accel = {
+		.mode = INV_ICM45600_SENSOR_MODE_OFF,
+		.fs = INV_ICM45686_ACCEL_FS_16G,
+		.odr = INV_ICM45600_ODR_800HZ_LN,
+		.filter = INV_ICM45600_ACCEL_LP_AVG_SEL_4X,
+	},
+};
+
+static const struct inv_icm45600_conf inv_icm45686_default_conf = {
+	.gyro = {
+		.mode = INV_ICM45600_SENSOR_MODE_OFF,
+		.fs = INV_ICM45686_GYRO_FS_4000DPS,
+		.odr = INV_ICM45600_ODR_800HZ_LN,
+		.filter = INV_ICM45600_GYRO_LP_AVG_SEL_8X,
+	},
+	.accel = {
+		.mode = INV_ICM45600_SENSOR_MODE_OFF,
+		.fs = INV_ICM45686_ACCEL_FS_32G,
+		.odr = INV_ICM45600_ODR_800HZ_LN,
+		.filter = INV_ICM45600_ACCEL_LP_AVG_SEL_4X,
+	},
+};
+
+static const struct inv_icm45600_hw inv_icm45600_hw[INV_CHIP_NB] = {
+	[INV_CHIP_ICM45605] = {
+		.whoami = INV_ICM45600_WHOAMI_ICM45605,
+		.name = "icm45605",
+		.conf = &inv_icm45600_default_conf,
+	},
+	[INV_CHIP_ICM45686] = {
+		.whoami = INV_ICM45600_WHOAMI_ICM45686,
+		.name = "icm45686",
+		.conf = &inv_icm45686_default_conf,
+	},
+	[INV_CHIP_ICM45688P] = {
+		.whoami = INV_ICM45600_WHOAMI_ICM45688P,
+		.name = "icm45688p",
+		.conf = &inv_icm45686_default_conf,
+	},
+	[INV_CHIP_ICM45608] = {
+		.whoami = INV_ICM45600_WHOAMI_ICM45608,
+		.name = "icm45608",
+		.conf = &inv_icm45600_default_conf,
+	},
+	[INV_CHIP_ICM45634] = {
+		.whoami = INV_ICM45600_WHOAMI_ICM45634,
+		.name = "icm45634",
+		.conf = &inv_icm45600_default_conf,
+	},
+	[INV_CHIP_ICM45689] = {
+		.whoami = INV_ICM45600_WHOAMI_ICM45689,
+		.name = "icm45689",
+		.conf = &inv_icm45686_default_conf,
+	},
+	[INV_CHIP_ICM45606] = {
+		.whoami = INV_ICM45600_WHOAMI_ICM45606,
+		.name = "icm45606",
+		.conf = &inv_icm45600_default_conf,
+	},
+	[INV_CHIP_ICM45687] = {
+		.whoami = INV_ICM45600_WHOAMI_ICM45687,
+		.name = "icm45687",
+		.conf = &inv_icm45686_default_conf,
+	},
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
+uint32_t inv_icm45600_odr_to_period(enum inv_icm45600_odr odr)
+{
+	static uint32_t odr_periods[INV_ICM45600_ODR_NB] = {
+		/* reserved values */
+		0, 0, 0,
+		/* 6.4kHz */
+		156250,
+		/* 3.2kHz */
+		312500,
+		/* 1.6kHz */
+		625000,
+		/* 800kHz */
+		1250000,
+		/* 400Hz */
+		2500000,
+		/* 200Hz */
+		5000000,
+		/* 100Hz */
+		10000000,
+		/* 50Hz */
+		20000000,
+		/* 25Hz */
+		40000000,
+		/* 12.5Hz */
+		80000000,
+		/* 6.25Hz */
+		160000000,
+		/* 3.125Hz */
+		320000000,
+		/* 1.5625Hz */
+		640000000,
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
+	val = INV_ICM45600_PWR_MGMT0_GYRO(gyro) |
+	      INV_ICM45600_PWR_MGMT0_ACCEL(accel);
+	ret = regmap_write(st->map, INV_ICM45600_REG_PWR_MGMT0, val);
+	if (ret)
+		return ret;
+
+	st->conf.gyro.mode = gyro;
+	st->conf.accel.mode = accel;
+
+	/* compute required wait time for sensors to stabilize */
+	sleepval = 0;
+
+	/* accel startup time */
+	if (accel != oldaccel && oldaccel == INV_ICM45600_SENSOR_MODE_OFF) {
+		if (sleepval < INV_ICM45600_ACCEL_STARTUP_TIME_MS)
+			sleepval = INV_ICM45600_ACCEL_STARTUP_TIME_MS;
+	}
+	if (gyro != oldgyro) {
+		/* gyro startup time */
+		if (oldgyro == INV_ICM45600_SENSOR_MODE_OFF) {
+			if (sleepval < INV_ICM45600_GYRO_STARTUP_TIME_MS)
+				sleepval = INV_ICM45600_GYRO_STARTUP_TIME_MS;
+		/* gyro stop time */
+		} else if (gyro == INV_ICM45600_SENSOR_MODE_OFF) {
+			if (sleepval < INV_ICM45600_GYRO_STOP_TIME_MS)
+				sleepval =  INV_ICM45600_GYRO_STOP_TIME_MS;
+		}
+	}
+
+	/* deferred sleep value if sleep pointer is provided or direct sleep */
+	if (sleep_ms)
+		*sleep_ms = sleepval;
+	else if (sleepval)
+		msleep(sleepval);
+
+	return 0;
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
+	/* Sanitize missing values with current values */
+	if (conf->mode < 0)
+		conf->mode = oldconf->mode;
+	if (conf->fs < 0)
+		conf->fs = oldconf->fs;
+	if (conf->odr < 0)
+		conf->odr = oldconf->odr;
+	if (conf->filter < 0)
+		conf->filter = oldconf->filter;
+
+	/* force power mode against ODR when sensor is on */
+	switch (conf->mode) {
+	case INV_ICM45600_SENSOR_MODE_LOW_POWER:
+	case INV_ICM45600_SENSOR_MODE_LOW_NOISE:
+		if (conf->odr <= INV_ICM45600_ODR_800HZ_LN) {
+			conf->mode = INV_ICM45600_SENSOR_MODE_LOW_NOISE;
+		} else if (conf->odr >= INV_ICM45600_ODR_6_25HZ_LP &&
+			   conf->odr <= INV_ICM45600_ODR_1_5625HZ_LP) {
+			conf->mode = INV_ICM45600_SENSOR_MODE_LOW_POWER;
+		}
+		break;
+	default:
+		break;
+	}
+
+	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
+	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
+		val = INV_ICM45600_ACCEL_CONFIG0_FS(conf->fs) |
+		      INV_ICM45600_ACCEL_CONFIG0_ODR(conf->odr);
+		ret = regmap_write(st->map, INV_ICM45600_REG_ACCEL_CONFIG0, val);
+		if (ret)
+			return ret;
+		oldconf->fs = conf->fs;
+		oldconf->odr = conf->odr;
+	}
+
+	/* set ACCEL_LP_AVG_SEL register (accel low-power average filter) */
+	if (conf->filter != oldconf->filter) {
+		ret = regmap_write(st->map, INV_ICM45600_IPREG_SYS2_REG_129,
+			conf->filter);
+		if (ret)
+			return ret;
+		oldconf->filter = conf->filter;
+	}
+
+	/* set PWR_MGMT0 register (accel sensor mode) */
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
+	/* sanitize missing values with current values */
+	if (conf->mode < 0)
+		conf->mode = oldconf->mode;
+	if (conf->fs < 0)
+		conf->fs = oldconf->fs;
+	if (conf->odr < 0)
+		conf->odr = oldconf->odr;
+	if (conf->filter < 0)
+		conf->filter = oldconf->filter;
+
+	/* force power mode against ODR when sensor is on */
+	switch (conf->mode) {
+	case INV_ICM45600_SENSOR_MODE_LOW_POWER:
+		if (conf->odr != INV_ICM45600_ODR_400HZ)
+			conf->filter = INV_ICM45600_GYRO_LP_AVG_SEL_8X;
+		else
+			conf->filter = INV_ICM45600_GYRO_LP_AVG_SEL_2X;
+		if (conf->odr <= INV_ICM45600_ODR_800HZ_LN)
+			conf->mode = INV_ICM45600_SENSOR_MODE_LOW_NOISE;
+		break;
+	case INV_ICM45600_SENSOR_MODE_LOW_NOISE:
+		if (conf->odr >= INV_ICM45600_ODR_6_25HZ_LP &&
+			   conf->odr <= INV_ICM45600_ODR_1_5625HZ_LP) {
+			conf->mode = INV_ICM45600_SENSOR_MODE_LOW_POWER;
+			conf->filter = INV_ICM45600_GYRO_LP_AVG_SEL_8X;
+		}
+		break;
+	default:
+		break;
+	}
+
+	/* set GYRO_CONFIG0 register (gyro fullscale & odr) */
+	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
+		val = INV_ICM45600_GYRO_CONFIG0_FS(conf->fs) |
+		      INV_ICM45600_GYRO_CONFIG0_ODR(conf->odr);
+		ret = regmap_write(st->map, INV_ICM45600_REG_GYRO_CONFIG0, val);
+		if (ret)
+			return ret;
+		oldconf->fs = conf->fs;
+		oldconf->odr = conf->odr;
+	}
+
+	/* set GYRO_LP_AVG_SEL register (gyro low-power average filter) */
+	if (conf->filter != oldconf->filter) {
+		ret = regmap_update_bits(st->map, INV_ICM45600_IPREG_SYS1_REG_170,
+			INV_ICM45600_IPREG_SYS1_REG_170_MASK, conf->filter);
+		if (ret)
+			return ret;
+		oldconf->filter = conf->filter;
+	}
+
+	/* set PWR_MGMT0 register (gyro sensor mode) */
+	return inv_icm45600_set_pwr_mgmt0(st, conf->mode, st->conf.accel.mode,
+					  sleep_ms);
+
+	return 0;
+}
+
+int inv_icm45600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	if (readval)
+		ret = regmap_read(st->map, reg, readval);
+	else
+		ret = regmap_write(st->map, reg, writeval);
+
+	return ret;
+}
+
+static int inv_icm45600_set_conf(struct inv_icm45600_state *st,
+				 const struct inv_icm45600_conf *conf)
+{
+	unsigned int val;
+	int ret;
+
+	/* set PWR_MGMT0 register (gyro & accel sensor mode, temp enabled) */
+	val = INV_ICM45600_PWR_MGMT0_GYRO(conf->gyro.mode) |
+	      INV_ICM45600_PWR_MGMT0_ACCEL(conf->accel.mode);
+	ret = regmap_write(st->map, INV_ICM45600_REG_PWR_MGMT0, val);
+	if (ret)
+		return ret;
+
+	/* set GYRO_CONFIG0 register (gyro fullscale & odr) */
+	val = INV_ICM45600_GYRO_CONFIG0_FS(conf->gyro.fs) |
+	      INV_ICM45600_GYRO_CONFIG0_ODR(conf->gyro.odr);
+	ret = regmap_write(st->map, INV_ICM45600_REG_GYRO_CONFIG0, val);
+	if (ret)
+		return ret;
+
+	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
+	val = INV_ICM45600_ACCEL_CONFIG0_FS(conf->accel.fs) |
+	      INV_ICM45600_ACCEL_CONFIG0_ODR(conf->accel.odr);
+	ret = regmap_write(st->map, INV_ICM45600_REG_ACCEL_CONFIG0, val);
+	if (ret)
+		return ret;
+
+	/* update internal conf */
+	st->conf = *conf;
+
+	return 0;
+}
+
+/**
+ *  inv_icm45600_setup() - check and setup chip
+ *  @st:	driver internal state
+ *  @bus_setup:	callback for setting up bus specific registers
+ *
+ *  Returns 0 on success, a negative error code otherwise.
+ */
+static int inv_icm45600_setup(struct inv_icm45600_state *st, bool reset,
+			      inv_icm45600_bus_setup bus_setup)
+{
+	const struct inv_icm45600_hw *hw = &inv_icm45600_hw[st->chip];
+	const struct device *dev = regmap_get_device(st->map);
+	unsigned int val;
+	int ret;
+
+	/* set chip bus configuration if specified */
+	if (bus_setup) {
+		ret = bus_setup(st);
+		if (ret)
+			return ret;
+	}
+
+	/* check chip self-identification value */
+	ret = regmap_read(st->map, INV_ICM45600_REG_WHOAMI, &val);
+	if (ret)
+		return ret;
+	if (val != hw->whoami) {
+		dev_err(dev, "invalid whoami %#02x expected %#02x (%s)\n",
+			val, hw->whoami, hw->name);
+		return -ENODEV;
+	}
+	st->name = hw->name;
+
+	if (reset) {
+		/* reset to make sure previous state are not there */
+		ret = regmap_write(st->map, INV_ICM45600_REG_MISC2,
+				INV_ICM45600_MISC2_SOFT_RESET);
+		if (ret)
+			return ret;
+		msleep(INV_ICM45600_RESET_TIME_MS);
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
+	return inv_icm45600_set_conf(st, hw->conf);
+}
+
+static irqreturn_t inv_icm45600_irq_timestamp(int irq, void *_data)
+{
+	struct inv_icm45600_state *st = _data;
+
+	st->timestamp.gyro = iio_get_time_ns(st->indio_gyro);
+	st->timestamp.accel = iio_get_time_ns(st->indio_accel);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t inv_icm45600_irq_handler(int irq, void *_data)
+{
+	struct inv_icm45600_state *st = _data;
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int mask, status;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->map, INV_ICM45600_REG_INT_STATUS, &status);
+	if (ret)
+		return IRQ_HANDLED;
+
+	/* read FIFO data */
+	mask = INV_ICM45600_INT_STATUS_FIFO_THS | INV_ICM45600_INT_STATUS_FIFO_FULL;
+	if (status & mask) {
+		ret = inv_icm45600_buffer_fifo_read(st, 0);
+		if (ret) {
+			dev_err(dev, "FIFO read error %d\n", ret);
+			return IRQ_HANDLED;
+		}
+		ret = inv_icm45600_buffer_fifo_parse(st);
+		if (ret)
+			dev_err(dev, "FIFO parsing error %d\n", ret);
+	}
+
+	/* FIFO full warning */
+	if (status & INV_ICM45600_INT_STATUS_FIFO_FULL)
+		dev_warn(dev, "FIFO full possible data lost!\n");
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * inv_icm45600_irq_init() - initialize int pin and interrupt handler
+ * @st:		driver internal state
+ * @irq:	irq number
+ * @irq_type:	irq trigger type
+ * @open_drain:	true if irq is open drain, false for push-pull
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static int inv_icm45600_irq_init(struct inv_icm45600_state *st, int irq,
+				 int irq_type, bool open_drain)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int val;
+	int ret;
+
+	/* configure INT1 interrupt: default is active low on edge */
+	switch (irq_type) {
+	case IRQF_TRIGGER_RISING:
+	case IRQF_TRIGGER_HIGH:
+		val = INV_ICM45600_INT1_CONFIG2_ACTIVE_HIGH;
+		break;
+	default:
+		val = INV_ICM45600_INT1_CONFIG2_ACTIVE_LOW;
+		break;
+	}
+
+	switch (irq_type) {
+	case IRQF_TRIGGER_LOW:
+	case IRQF_TRIGGER_HIGH:
+		val |= INV_ICM45600_INT1_CONFIG2_LATCHED;
+		break;
+	default:
+		break;
+	}
+
+	if (!open_drain)
+		val |= INV_ICM45600_INT1_CONFIG2_PUSH_PULL;
+
+	ret = regmap_write(st->map, INV_ICM45600_REG_INT1_CONFIG2, val);
+	if (ret)
+		return ret;
+
+	irq_type |= IRQF_ONESHOT;
+	return devm_request_threaded_irq(dev, irq, inv_icm45600_irq_timestamp,
+					 inv_icm45600_irq_handler, irq_type,
+					 "inv_icm45600", st);
+}
+
+static int inv_icm45600_timestamp_setup(struct inv_icm45600_state *st)
+{
+	/* enable timestamp */
+	return regmap_set_bits(st->map, INV_ICM45600_REG_SMC_CONTROL_0,
+					INV_ICM45600_SMC_CONTROL_0_TMST_EN);
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
+	/* wait a little for supply ramp */
+	usleep_range(3000, 4000);
+
+	return 0;
+}
+
+static void inv_icm45600_disable_vdd_reg(void *_data)
+{
+	struct inv_icm45600_state *st = _data;
+	const struct device *dev = regmap_get_device(st->map);
+	int ret;
+
+	ret = regulator_disable(st->vdd_supply);
+	if (ret)
+		dev_err(dev, "failed to disable vdd error %d\n", ret);
+}
+
+static void inv_icm45600_disable_vddio_reg(void *_data)
+{
+	struct inv_icm45600_state *st = _data;
+	const struct device *dev = regmap_get_device(st->map);
+	int ret;
+
+	ret = regulator_disable(st->vddio_supply);
+	if (ret)
+		dev_err(dev, "failed to disable vddio error %d\n", ret);
+}
+
+static void inv_icm45600_disable_pm(void *_data)
+{
+	struct device *dev = _data;
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+}
+
+int inv_icm45600_core_probe(struct regmap *regmap, int chip, bool reset,
+			    inv_icm45600_bus_setup bus_setup)
+{
+	struct device *dev = regmap_get_device(regmap);
+	struct fwnode_handle *fwnode;
+	struct inv_icm45600_state *st;
+	struct regmap *regmap_custom;
+	int irq, irq_type;
+	bool open_drain;
+	int ret;
+
+	if (chip <= INV_CHIP_INVALID || chip >= INV_CHIP_NB) {
+		dev_err(dev, "invalid chip = %d\n", chip);
+		return -ENODEV;
+	}
+
+	/* get INT1 only supported interrupt */
+	fwnode = dev_fwnode(dev);
+	if (!fwnode)
+		return -ENODEV;
+	irq = fwnode_irq_get_byname(fwnode, "INT1");
+	if (irq < 0) {
+		if (irq != -EPROBE_DEFER)
+			dev_err(dev, "error missing INT1 interrupt\n");
+		return irq;
+	}
+
+	irq_type = irq_get_trigger_type(irq);
+	if (!irq_type)
+		irq_type = IRQF_TRIGGER_FALLING;
+
+	open_drain = device_property_read_bool(dev, "drive-open-drain");
+
+	regmap_custom = devm_regmap_init(dev, &inv_icm45600_regmap_bus,
+					 regmap, &inv_icm45600_regmap_config);
+	if (IS_ERR(regmap_custom)) {
+		dev_err(dev, "Failed to register icm45600 regmap %ld\n", PTR_ERR(regmap_custom));
+		return PTR_ERR(regmap_custom);
+	}
+
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, st);
+	mutex_init(&st->lock);
+	st->chip = chip;
+	st->map = regmap_custom;
+
+	ret = iio_read_mount_matrix(dev, &st->orientation);
+	if (ret) {
+		dev_err(dev, "failed to retrieve mounting matrix %d\n", ret);
+		return ret;
+	}
+
+	st->vdd_supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(st->vdd_supply))
+		return PTR_ERR(st->vdd_supply);
+
+	st->vddio_supply = devm_regulator_get(dev, "vddio");
+	if (IS_ERR(st->vddio_supply))
+		return PTR_ERR(st->vddio_supply);
+
+	ret = regulator_enable(st->vdd_supply);
+	if (ret)
+		return ret;
+	msleep(INV_ICM45600_POWER_UP_TIME_MS);
+
+	ret = devm_add_action_or_reset(dev, inv_icm45600_disable_vdd_reg, st);
+	if (ret)
+		return ret;
+
+	ret = inv_icm45600_enable_regulator_vddio(st);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, inv_icm45600_disable_vddio_reg, st);
+	if (ret)
+		return ret;
+
+	/* setup chip registers */
+	ret = inv_icm45600_setup(st, reset, bus_setup);
+	if (ret)
+		return ret;
+
+	ret = inv_icm45600_timestamp_setup(st);
+	if (ret)
+		return ret;
+
+	ret = inv_icm45600_buffer_init(st);
+	if (ret)
+		return ret;
+
+	st->indio_gyro = inv_icm45600_gyro_init(st);
+	if (IS_ERR(st->indio_gyro))
+		return PTR_ERR(st->indio_gyro);
+
+	st->indio_accel = inv_icm45600_accel_init(st);
+	if (IS_ERR(st->indio_accel))
+		return PTR_ERR(st->indio_accel);
+
+	ret = inv_icm45600_irq_init(st, irq, irq_type, open_drain);
+	if (ret)
+		return ret;
+
+	/* setup runtime power management */
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		return ret;
+	pm_runtime_get_noresume(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, INV_ICM45600_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_put(dev);
+
+	return devm_add_action_or_reset(dev, inv_icm45600_disable_pm, dev);
+}
+EXPORT_SYMBOL_NS_GPL(inv_icm45600_core_probe, "IIO_ICM45600");
+
+/*
+ * Suspend saves sensors state and turns everything off.
+ * Check first if runtime suspend has not already done the job.
+ */
+static int inv_icm45600_suspend(struct device *dev)
+{
+	struct inv_icm45600_state *st = dev_get_drvdata(dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	st->suspended.gyro = st->conf.gyro.mode;
+	st->suspended.accel = st->conf.accel.mode;
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	/* disable FIFO data streaming */
+	if (st->fifo.on) {
+		ret = regmap_clear_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3,
+					INV_ICM45600_FIFO_CONFIG3_IF_EN);
+		if (ret)
+			return ret;
+		ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
+					 INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
+					 INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS);
+		if (ret)
+			return ret;
+	}
+
+	ret = inv_icm45600_set_pwr_mgmt0(st, INV_ICM45600_SENSOR_MODE_OFF,
+					 INV_ICM45600_SENSOR_MODE_OFF, NULL);
+	if (ret)
+		return ret;
+
+	regulator_disable(st->vddio_supply);
+
+	return ret;
+}
+
+/*
+ * System resume gets the system back on and restores the sensors state.
+ * Manually put runtime power management in system active state.
+ */
+static int inv_icm45600_resume(struct device *dev)
+{
+	struct inv_icm45600_state *st = dev_get_drvdata(dev);
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
+	struct inv_icm45600_sensor_state *accel_st = iio_priv(st->indio_accel);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = inv_icm45600_enable_regulator_vddio(st);
+	if (ret)
+		return ret;
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	/* restore sensors state */
+	ret = inv_icm45600_set_pwr_mgmt0(st, st->suspended.gyro,
+					 st->suspended.accel, NULL);
+	if (ret)
+		return ret;
+
+	/* restore FIFO data streaming */
+	if (st->fifo.on) {
+		inv_sensors_timestamp_reset(&gyro_st->ts);
+		inv_sensors_timestamp_reset(&accel_st->ts);
+		ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
+					 INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
+					 INV_ICM45600_FIFO_CONFIG0_MODE_STREAM);
+		if (ret)
+			return ret;
+		ret = regmap_set_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3,
+				      INV_ICM45600_FIFO_CONFIG3_IF_EN);
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
+	return ret;
+}
+
+/* Sensors are enabled by iio devices, no need to turn them back on here. */
+static int inv_icm45600_runtime_resume(struct device *dev)
+{
+	struct inv_icm45600_state *st = dev_get_drvdata(dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = inv_icm45600_enable_regulator_vddio(st);
+
+	return ret;
+}
+
+
+EXPORT_NS_GPL_DEV_PM_OPS(inv_icm45600_pm_ops, IIO_ICM45600) = {
+	SET_SYSTEM_SLEEP_PM_OPS(inv_icm45600_suspend, inv_icm45600_resume)
+	SET_RUNTIME_PM_OPS(inv_icm45600_runtime_suspend,
+			   inv_icm45600_runtime_resume, NULL)
+};
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense ICM-456xx device driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_INV_SENSORS_TIMESTAMP");
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c
new file mode 100644
index 0000000000000000000000000000000000000000..4ada93f990c1ffdc1e0a00ae7c78e03c09d1c682
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c
@@ -0,0 +1,919 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Invensense, Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include "inv_icm45600_buffer.h"
+#include "inv_icm45600_temp.h"
+#include "inv_icm45600.h"
+
+
+#define INV_ICM45600_GYRO_CHAN(_modifier, _index, _ext_info)		\
+	{								\
+		.type = IIO_ANGL_VEL,					\
+		.modified = 1,						\
+		.channel2 = _modifier,					\
+		.info_mask_separate =					\
+			BIT(IIO_CHAN_INFO_RAW) |			\
+			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
+		.info_mask_shared_by_type =				\
+			BIT(IIO_CHAN_INFO_SCALE),			\
+		.info_mask_shared_by_type_available =			\
+			BIT(IIO_CHAN_INFO_SCALE) |			\
+			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
+		.info_mask_shared_by_all =				\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+		.info_mask_shared_by_all_available =			\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+		.scan_index = _index,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+			.endianness = IIO_LE,				\
+		},							\
+		.ext_info = _ext_info,					\
+	}
+
+enum inv_icm45600_gyro_scan {
+	INV_ICM45600_GYRO_SCAN_X,
+	INV_ICM45600_GYRO_SCAN_Y,
+	INV_ICM45600_GYRO_SCAN_Z,
+	INV_ICM45600_GYRO_SCAN_TEMP,
+	INV_ICM45600_GYRO_SCAN_TIMESTAMP,
+};
+
+
+static const char * const inv_icm45600_gyro_power_mode_items[] = {
+	"low-noise",
+	"low-power",
+};
+static const int inv_icm45600_gyro_power_mode_values[] = {
+	INV_ICM45600_SENSOR_MODE_LOW_NOISE,
+	INV_ICM45600_SENSOR_MODE_LOW_POWER,
+};
+
+static int inv_icm45600_gyro_power_mode_set(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan,
+					     unsigned int idx)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
+	int power_mode;
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	if (idx >= ARRAY_SIZE(inv_icm45600_gyro_power_mode_values))
+		return -EINVAL;
+
+	if (iio_buffer_enabled(indio_dev))
+		return -EBUSY;
+
+	power_mode = inv_icm45600_gyro_power_mode_values[idx];
+
+	guard(mutex)(&st->lock);
+
+	/* prevent change if power mode is not supported by the ODR */
+	switch (power_mode) {
+	case INV_ICM45600_SENSOR_MODE_LOW_NOISE:
+		if (st->conf.gyro.odr >= INV_ICM45600_ODR_6_25HZ_LP &&
+		    st->conf.gyro.odr <= INV_ICM45600_ODR_1_5625HZ_LP)
+			return -EPERM;
+		break;
+	case INV_ICM45600_SENSOR_MODE_LOW_POWER:
+	default:
+		if (st->conf.gyro.odr <= INV_ICM45600_ODR_800HZ_LN)
+			return -EPERM;
+		break;
+	}
+
+	gyro_st->power_mode = power_mode;
+
+	return 0;
+}
+
+static int inv_icm45600_gyro_power_mode_get(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
+	unsigned int idx;
+	int power_mode;
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+
+	/* if sensor is on, returns actual power mode and not configured one */
+	switch (st->conf.gyro.mode) {
+	case INV_ICM45600_SENSOR_MODE_LOW_POWER:
+	case INV_ICM45600_SENSOR_MODE_LOW_NOISE:
+		power_mode = st->conf.gyro.mode;
+		break;
+	default:
+		power_mode = gyro_st->power_mode;
+		break;
+	}
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm45600_gyro_power_mode_values); ++idx) {
+		if (power_mode == inv_icm45600_gyro_power_mode_values[idx])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm45600_gyro_power_mode_values))
+		return -EINVAL;
+
+	return idx;
+}
+
+static const struct iio_enum inv_icm45600_gyro_power_mode_enum = {
+	.items = inv_icm45600_gyro_power_mode_items,
+	.num_items = ARRAY_SIZE(inv_icm45600_gyro_power_mode_items),
+	.set = inv_icm45600_gyro_power_mode_set,
+	.get = inv_icm45600_gyro_power_mode_get,
+};
+
+static const struct iio_chan_spec_ext_info inv_icm45600_gyro_ext_infos[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm45600_get_mount_matrix),
+	IIO_ENUM_AVAILABLE("power_mode", IIO_SHARED_BY_TYPE,
+			   &inv_icm45600_gyro_power_mode_enum),
+	IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE,
+		 &inv_icm45600_gyro_power_mode_enum),
+	{},
+};
+
+static const struct iio_chan_spec inv_icm45600_gyro_channels[] = {
+	INV_ICM45600_GYRO_CHAN(IIO_MOD_X, INV_ICM45600_GYRO_SCAN_X,
+			       inv_icm45600_gyro_ext_infos),
+	INV_ICM45600_GYRO_CHAN(IIO_MOD_Y, INV_ICM45600_GYRO_SCAN_Y,
+			       inv_icm45600_gyro_ext_infos),
+	INV_ICM45600_GYRO_CHAN(IIO_MOD_Z, INV_ICM45600_GYRO_SCAN_Z,
+			       inv_icm45600_gyro_ext_infos),
+	INV_ICM45600_TEMP_CHAN(INV_ICM45600_GYRO_SCAN_TEMP),
+	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM45600_GYRO_SCAN_TIMESTAMP),
+};
+
+/*
+ * IIO buffer data: size must be a power of 2 and timestamp aligned
+ * 16 bytes: 6 bytes angular velocity, 2 bytes temperature, 8 bytes timestamp
+ */
+struct inv_icm45600_gyro_buffer {
+	struct inv_icm45600_fifo_sensor_data gyro;
+	int16_t temp;
+	aligned_s64 timestamp;
+};
+
+#define INV_ICM45600_SCAN_MASK_GYRO_3AXIS				\
+	(BIT(INV_ICM45600_GYRO_SCAN_X) |				\
+	BIT(INV_ICM45600_GYRO_SCAN_Y) |					\
+	BIT(INV_ICM45600_GYRO_SCAN_Z))
+
+#define INV_ICM45600_SCAN_MASK_TEMP	BIT(INV_ICM45600_GYRO_SCAN_TEMP)
+
+static const unsigned long inv_icm45600_gyro_scan_masks[] = {
+	/* 3-axis gyro + temperature */
+	INV_ICM45600_SCAN_MASK_GYRO_3AXIS | INV_ICM45600_SCAN_MASK_TEMP,
+	0,
+};
+
+/* enable gyroscope sensor and FIFO write */
+static int inv_icm45600_gyro_update_scan_mode(struct iio_dev *indio_dev,
+					      const unsigned long *scan_mask)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
+	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_INIT;
+	unsigned int fifo_en = 0;
+	unsigned int sleep_gyro = 0;
+	unsigned int sleep_temp = 0;
+	unsigned int sleep;
+	int ret;
+
+	scoped_guard(mutex, &st->lock) {
+		if (*scan_mask & INV_ICM45600_SCAN_MASK_TEMP)
+			fifo_en |= INV_ICM45600_SENSOR_TEMP;
+
+		if (*scan_mask & INV_ICM45600_SCAN_MASK_GYRO_3AXIS) {
+			/* enable gyro sensor */
+			conf.mode = gyro_st->power_mode;
+			ret = inv_icm45600_set_gyro_conf(st, &conf, &sleep_gyro);
+			if (ret)
+				break;
+			fifo_en |= INV_ICM45600_SENSOR_GYRO;
+		}
+		/* update data FIFO write */
+		ret = inv_icm45600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
+	}
+	/* sleep maximum required time */
+	sleep = max(sleep_gyro, sleep_temp);
+	if (sleep)
+		msleep(sleep);
+	return ret;
+}
+
+static int inv_icm45600_gyro_read_sensor(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan,
+					 int16_t *val)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_INIT;
+	unsigned int reg;
+	__le16 *data;
+	int ret;
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM45600_REG_GYRO_DATA_X;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM45600_REG_GYRO_DATA_Y;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM45600_REG_GYRO_DATA_Z;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	pm_runtime_get_sync(dev);
+	scoped_guard(mutex, &st->lock) {
+		/* enable gyro sensor */
+		conf.mode = gyro_st->power_mode;
+		ret = inv_icm45600_set_gyro_conf(st, &conf, NULL);
+		if (ret)
+			break;
+
+		/* read gyro register data */
+		data = (__le16 *)&st->buffer[0];
+		ret = regmap_bulk_read(st->map, reg, data, sizeof(*data));
+		if (ret)
+			break;
+
+		*val = (int16_t)le16_to_cpup(data);
+		if (*val == INV_ICM45600_DATA_INVALID)
+			ret = -EINVAL;
+	}
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+/* IIO format int + nano */
+static const int inv_icm45600_gyro_scale[] = {
+	/* +/- 2000dps => 0.001065264 rad/s */
+	[2 * INV_ICM45600_GYRO_FS_2000DPS] = 0,
+	[2 * INV_ICM45600_GYRO_FS_2000DPS + 1] = 1065264,
+	/* +/- 1000dps => 0.000532632 rad/s */
+	[2 * INV_ICM45600_GYRO_FS_1000DPS] = 0,
+	[2 * INV_ICM45600_GYRO_FS_1000DPS + 1] = 532632,
+	/* +/- 500dps => 0.000266316 rad/s */
+	[2 * INV_ICM45600_GYRO_FS_500DPS] = 0,
+	[2 * INV_ICM45600_GYRO_FS_500DPS + 1] = 266316,
+	/* +/- 250dps => 0.000133158 rad/s */
+	[2 * INV_ICM45600_GYRO_FS_250DPS] = 0,
+	[2 * INV_ICM45600_GYRO_FS_250DPS + 1] = 133158,
+	/* +/- 125dps => 0.000066579 rad/s */
+	[2 * INV_ICM45600_GYRO_FS_125DPS] = 0,
+	[2 * INV_ICM45600_GYRO_FS_125DPS + 1] = 66579,
+	/* +/- 62.5dps => 0.000033290 rad/s */
+	[2 * INV_ICM45600_GYRO_FS_62_5DPS] = 0,
+	[2 * INV_ICM45600_GYRO_FS_62_5DPS + 1] = 33290,
+	/* +/- 31.25dps => 0.000016645 rad/s */
+	[2 * INV_ICM45600_GYRO_FS_31_25DPS] = 0,
+	[2 * INV_ICM45600_GYRO_FS_31_25DPS + 1] = 16645,
+	/* +/- 15.625dps => 0.000008322 rad/s */
+	[2 * INV_ICM45600_GYRO_FS_15_625DPS] = 0,
+	[2 * INV_ICM45600_GYRO_FS_15_625DPS + 1] = 8322,
+};
+
+/* IIO format int + nano */
+static const int inv_icm45686_gyro_scale[] = {
+	/* +/- 4000dps => 0.002130529 rad/s */
+	[2 * INV_ICM45686_GYRO_FS_4000DPS] = 0,
+	[2 * INV_ICM45686_GYRO_FS_4000DPS + 1] = 2130529,
+	/* +/- 2000dps => 0.001065264 rad/s */
+	[2 * INV_ICM45686_GYRO_FS_2000DPS] = 0,
+	[2 * INV_ICM45686_GYRO_FS_2000DPS + 1] = 1065264,
+	/* +/- 1000dps => 0.000532632 rad/s */
+	[2 * INV_ICM45686_GYRO_FS_1000DPS] = 0,
+	[2 * INV_ICM45686_GYRO_FS_1000DPS + 1] = 532632,
+	/* +/- 500dps => 0.000266316 rad/s */
+	[2 * INV_ICM45686_GYRO_FS_500DPS] = 0,
+	[2 * INV_ICM45686_GYRO_FS_500DPS + 1] = 266316,
+	/* +/- 250dps => 0.000133158 rad/s */
+	[2 * INV_ICM45686_GYRO_FS_250DPS] = 0,
+	[2 * INV_ICM45686_GYRO_FS_250DPS + 1] = 133158,
+	/* +/- 125dps => 0.000066579 rad/s */
+	[2 * INV_ICM45686_GYRO_FS_125DPS] = 0,
+	[2 * INV_ICM45686_GYRO_FS_125DPS + 1] = 66579,
+	/* +/- 62.5dps => 0.000033290 rad/s */
+	[2 * INV_ICM45686_GYRO_FS_62_5DPS] = 0,
+	[2 * INV_ICM45686_GYRO_FS_62_5DPS + 1] = 33290,
+	/* +/- 31.25dps => 0.000016645 rad/s */
+	[2 * INV_ICM45686_GYRO_FS_31_25DPS] = 0,
+	[2 * INV_ICM45686_GYRO_FS_31_25DPS + 1] = 16645,
+	/* +/- 15.625dps => 0.000008322 rad/s */
+	[2 * INV_ICM45686_GYRO_FS_15_625DPS] = 0,
+	[2 * INV_ICM45686_GYRO_FS_15_625DPS + 1] = 8322,
+};
+
+static int inv_icm45600_gyro_read_scale(struct iio_dev *indio_dev,
+					int *val, int *val2)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
+	unsigned int idx;
+
+	idx = st->conf.gyro.fs;
+
+	/* Full scale register starts at 1 for not High FSR parts */
+	if (gyro_st->scales == inv_icm45600_gyro_scale)
+		idx--;
+
+	*val = gyro_st->scales[2 * idx];
+	*val2 = gyro_st->scales[2 * idx + 1];
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int inv_icm45600_gyro_write_scale(struct iio_dev *indio_dev,
+					 int val, int val2)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_INIT;
+	int ret;
+
+	for (idx = 0; idx < gyro_st->scales_len; idx += 2) {
+		if (val == gyro_st->scales[idx] &&
+		    val2 == gyro_st->scales[idx + 1])
+			break;
+	}
+	if (idx >= gyro_st->scales_len)
+		return -EINVAL;
+
+	conf.fs = idx / 2;
+
+	/* Full scale register starts at 1 for not High FSR parts */
+	if (gyro_st->scales == inv_icm45600_gyro_scale)
+		conf.fs++;
+
+	pm_runtime_get_sync(dev);
+	scoped_guard(mutex, &st->lock) {
+		ret = inv_icm45600_set_gyro_conf(st, &conf, NULL);
+	}
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+/* IIO format int + micro */
+static const int inv_icm45600_gyro_odr[] = {
+	/* 1.5625Hz */
+	1, 562500,
+	/* 3.125Hz */
+	3, 125000,
+	/* 6.25Hz */
+	6, 250000,
+	/* 12.5Hz */
+	12, 500000,
+	/* 25Hz */
+	25, 0,
+	/* 50Hz */
+	50, 0,
+	/* 100Hz */
+	100, 0,
+	/* 200Hz */
+	200, 0,
+	/* 400Hz */
+	400, 0,
+	/* 800Hz */
+	800, 0,
+	/* 1.6kHz */
+	1600, 0,
+	/* 3.2kHz */
+	3200, 0,
+	/* 6.4kHz */
+	6400, 0,
+};
+
+static const int inv_icm45600_gyro_odr_conv[] = {
+	INV_ICM45600_ODR_1_5625HZ_LP,
+	INV_ICM45600_ODR_3_125HZ_LP,
+	INV_ICM45600_ODR_6_25HZ_LP,
+	INV_ICM45600_ODR_12_5HZ,
+	INV_ICM45600_ODR_25HZ,
+	INV_ICM45600_ODR_50HZ,
+	INV_ICM45600_ODR_100HZ,
+	INV_ICM45600_ODR_200HZ,
+	INV_ICM45600_ODR_400HZ,
+	INV_ICM45600_ODR_800HZ_LN,
+	INV_ICM45600_ODR_1600HZ_LN,
+	INV_ICM45600_ODR_3200HZ_LN,
+	INV_ICM45600_ODR_6400HZ_LN,
+};
+
+static int inv_icm45600_gyro_read_odr(struct inv_icm45600_state *st,
+				      int *val, int *val2)
+{
+	unsigned int odr;
+	unsigned int i;
+
+	odr = st->conf.gyro.odr;
+
+	for (i = 0; i < ARRAY_SIZE(inv_icm45600_gyro_odr_conv); ++i) {
+		if (inv_icm45600_gyro_odr_conv[i] == odr)
+			break;
+	}
+	if (i >= ARRAY_SIZE(inv_icm45600_gyro_odr_conv))
+		return -EINVAL;
+
+	*val = inv_icm45600_gyro_odr[2 * i];
+	*val2 = inv_icm45600_gyro_odr[2 * i + 1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_icm45600_gyro_write_odr(struct iio_dev *indio_dev,
+				       int val, int val2)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &gyro_st->ts;
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_INIT;
+	int ret;
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm45600_gyro_odr); idx += 2) {
+		if (val == inv_icm45600_gyro_odr[idx] &&
+		    val2 == inv_icm45600_gyro_odr[idx + 1])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm45600_gyro_odr))
+		return -EINVAL;
+
+	conf.odr = inv_icm45600_gyro_odr_conv[idx / 2];
+
+	pm_runtime_get_sync(dev);
+	scoped_guard(mutex, &st->lock) {
+		ret = inv_sensors_timestamp_update_odr(ts, inv_icm45600_odr_to_period(conf.odr),
+						       iio_buffer_enabled(indio_dev));
+		if (ret)
+			break;
+
+		if (st->conf.gyro.mode != INV_ICM45600_SENSOR_MODE_OFF)
+			conf.mode = gyro_st->power_mode;
+		ret = inv_icm45600_set_gyro_conf(st, &conf, NULL);
+		if (ret)
+			break;
+		inv_icm45600_buffer_update_fifo_period(st);
+		inv_icm45600_buffer_update_watermark(st);
+	}
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+/*
+ * Calibration bias values, IIO range format int + nano.
+ * Value is limited to +/-64dps coded on 12 bits signed. Step is 1/32 dps.
+ */
+static int inv_icm45600_gyro_calibbias[] = {
+	-1, 117010721,		/* min: -1.117010721 rad/s */
+	0, 545415,		/* step: 0.000545415 rad/s */
+	1, 116465306,		/* max: 1.116465306 rad/s */
+};
+
+static int inv_icm45600_gyro_read_offset(struct inv_icm45600_state *st,
+					 struct iio_chan_spec const *chan,
+					 int *val, int *val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	int64_t val64;
+	int32_t bias;
+	unsigned int reg;
+	int16_t offset;
+	uint8_t data[2];
+	int ret;
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM45600_IPREG_SYS1_REG_42;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM45600_IPREG_SYS1_REG_56;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM45600_IPREG_SYS1_REG_70;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	pm_runtime_get_sync(dev);
+	scoped_guard(mutex, &st->lock) {
+		ret = regmap_bulk_read(st->map, reg, st->buffer, sizeof(data));
+		memcpy(data, st->buffer, sizeof(data));
+	}
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	if (ret)
+		return ret;
+
+	/* 12 bits signed value */
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		offset = sign_extend32(((data[1] & 0x0F) << 8) | data[0], 11);
+		break;
+	case IIO_MOD_Y:
+		offset = sign_extend32(((data[0] & 0xF0) << 4) | data[1], 11);
+		break;
+	case IIO_MOD_Z:
+		offset = sign_extend32(((data[1] & 0x0F) << 8) | data[0], 11);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * convert raw offset to dps then to rad/s
+	 * 12 bits signed raw max 64 to dps: 64 / 2048
+	 * dps to rad: Pi / 180
+	 * result in nano (1000000000)
+	 * (offset * 64 * Pi * 1000000000) / (2048 * 180)
+	 */
+	val64 = (int64_t)offset * 64LL * 3141592653LL;
+	/* for rounding, add + or - divisor (2048 * 180) divided by 2 */
+	if (val64 >= 0)
+		val64 += 2048 * 180 / 2;
+	else
+		val64 -= 2048 * 180 / 2;
+	bias = div_s64(val64, 2048 * 180);
+	*val = bias / 1000000000L;
+	*val2 = bias % 1000000000L;
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int inv_icm45600_gyro_write_offset(struct inv_icm45600_state *st,
+					  struct iio_chan_spec const *chan,
+					  int val, int val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	int64_t val64, min, max;
+	unsigned int reg;
+	int16_t offset;
+	int ret;
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM45600_IPREG_SYS1_REG_42;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM45600_IPREG_SYS1_REG_56;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM45600_IPREG_SYS1_REG_70;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* inv_icm45600_gyro_calibbias: min - step - max in nano */
+	min = (int64_t)inv_icm45600_gyro_calibbias[0] * 1000000000LL +
+	      (int64_t)inv_icm45600_gyro_calibbias[1];
+	max = (int64_t)inv_icm45600_gyro_calibbias[4] * 1000000000LL +
+	      (int64_t)inv_icm45600_gyro_calibbias[5];
+	val64 = (int64_t)val * 1000000000LL + (int64_t)val2;
+	if (val64 < min || val64 > max)
+		return -EINVAL;
+
+	/*
+	 * convert rad/s to dps then to raw value
+	 * rad to dps: 180 / Pi
+	 * dps to raw 14 bits signed, max 62.5: 8192 / 62.5
+	 * val in nano (1000000000)
+	 * val * 180 * 8192 / (Pi * 1000000000 * 62.5)
+	 */
+	val64 = val64 * 180LL * 8192;
+	/* for rounding, add + or - divisor (314159265 * 625) divided by 2 */
+	if (val64 >= 0)
+		val64 += 314159265LL * 625LL / 2LL;
+	else
+		val64 -= 314159265LL * 625LL / 2LL;
+	offset = div64_s64(val64, 314159265LL * 625LL);
+
+	/* clamp value limited to 14 bits signed */
+	if (offset < -8192)
+		offset = -8192;
+	else if (offset > 8191)
+		offset = 8191;
+
+	pm_runtime_get_sync(dev);
+	scoped_guard(mutex, &st->lock) {
+		ret = regmap_bulk_write(st->map, reg, st->buffer, 2);
+	}
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+static int inv_icm45600_gyro_read_raw(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      int *val, int *val2, long mask)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	int16_t data;
+	int ret;
+
+	switch (chan->type) {
+	case IIO_ANGL_VEL:
+		break;
+	case IIO_TEMP:
+		return inv_icm45600_temp_read_raw(indio_dev, chan, val, val2, mask);
+	default:
+		return -EINVAL;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm45600_gyro_read_sensor(indio_dev, chan, &data);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		*val = data;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return inv_icm45600_gyro_read_scale(indio_dev, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm45600_gyro_read_odr(st, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm45600_gyro_read_offset(st, chan, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm45600_gyro_read_avail(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					const int **vals,
+					int *type, int *length, long mask)
+{
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = gyro_st->scales;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = gyro_st->scales_len;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = inv_icm45600_gyro_odr;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(inv_icm45600_gyro_odr);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*vals = inv_icm45600_gyro_calibbias;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm45600_gyro_write_raw(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       int val, int val2, long mask)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm45600_gyro_write_scale(indio_dev, val, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm45600_gyro_write_odr(indio_dev, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm45600_gyro_write_offset(st, chan, val, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm45600_gyro_write_raw_get_fmt(struct iio_dev *indio_dev,
+					       struct iio_chan_spec const *chan,
+					       long mask)
+{
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm45600_gyro_hwfifo_set_watermark(struct iio_dev *indio_dev,
+						  unsigned int val)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	st->fifo.watermark.gyro = val;
+	ret = inv_icm45600_buffer_update_watermark(st);
+
+	return ret;
+}
+
+static int inv_icm45600_gyro_hwfifo_flush(struct iio_dev *indio_dev,
+					  unsigned int count)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	if (count == 0)
+		return 0;
+
+	guard(mutex)(&st->lock);
+
+	ret = inv_icm45600_buffer_hwfifo_flush(st, count);
+	if (!ret)
+		ret = st->fifo.nb.gyro;
+
+	return ret;
+}
+
+static const struct iio_info inv_icm45600_gyro_info = {
+	.read_raw = inv_icm45600_gyro_read_raw,
+	.read_avail = inv_icm45600_gyro_read_avail,
+	.write_raw = inv_icm45600_gyro_write_raw,
+	.write_raw_get_fmt = inv_icm45600_gyro_write_raw_get_fmt,
+	.debugfs_reg_access = inv_icm45600_debugfs_reg,
+	.update_scan_mode = inv_icm45600_gyro_update_scan_mode,
+	.hwfifo_set_watermark = inv_icm45600_gyro_hwfifo_set_watermark,
+	.hwfifo_flush_to_buffer = inv_icm45600_gyro_hwfifo_flush,
+};
+
+struct iio_dev *inv_icm45600_gyro_init(struct inv_icm45600_state *st)
+{
+	struct device *dev = regmap_get_device(st->map);
+	const char *name;
+	struct inv_icm45600_sensor_state *gyro_st;
+	struct inv_sensors_timestamp_chip ts_chip;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", st->name);
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*gyro_st));
+	if (!indio_dev)
+		return ERR_PTR(-ENOMEM);
+	gyro_st = iio_priv(indio_dev);
+
+	switch (st->chip) {
+	case INV_CHIP_ICM45686:
+	case INV_CHIP_ICM45688P:
+	case INV_CHIP_ICM45689:
+	case INV_CHIP_ICM45687:
+		gyro_st->scales = inv_icm45686_gyro_scale;
+		gyro_st->scales_len = ARRAY_SIZE(inv_icm45686_gyro_scale);
+		break;
+	default:
+		gyro_st->scales = inv_icm45600_gyro_scale;
+		gyro_st->scales_len = ARRAY_SIZE(inv_icm45600_gyro_scale);
+		/* Set Gyro default FSR */
+		ret = regmap_update_bits(st->map, INV_ICM45600_REG_GYRO_CONFIG0,
+					INV_ICM45600_GYRO_CONFIG0_FS_MASK,
+					INV_ICM45600_GYRO_CONFIG0_FS_2000DPS);
+		if (ret)
+			return ERR_PTR(ret);
+		break;
+	}
+	/* low-noise by default at init */
+	gyro_st->power_mode = INV_ICM45600_SENSOR_MODE_LOW_NOISE;
+
+	/*
+	 * clock period is 32kHz (31250ns)
+	 * jitter is +/- 2% (20 per mille)
+	 */
+	ts_chip.clock_period = 31250;
+	ts_chip.jitter = 20;
+	ts_chip.init_period = inv_icm45600_odr_to_period(st->conf.gyro.odr);
+	inv_sensors_timestamp_init(&gyro_st->ts, &ts_chip);
+
+	iio_device_set_drvdata(indio_dev, st);
+	indio_dev->name = name;
+	indio_dev->info = &inv_icm45600_gyro_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = inv_icm45600_gyro_channels;
+	indio_dev->num_channels = ARRAY_SIZE(inv_icm45600_gyro_channels);
+	indio_dev->available_scan_masks = inv_icm45600_gyro_scan_masks;
+	indio_dev->setup_ops = &inv_icm45600_buffer_ops;
+
+	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
+					  &inv_icm45600_buffer_ops);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return indio_dev;
+}
+
+int inv_icm45600_gyro_parse_fifo(struct iio_dev *indio_dev)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &gyro_st->ts;
+	ssize_t i, size;
+	unsigned int no;
+	const void *accel, *gyro, *timestamp;
+	const int8_t *temp;
+	unsigned int odr;
+	int64_t ts_val;
+	struct inv_icm45600_gyro_buffer buffer;
+
+	/* parse all fifo packets */
+	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
+		size = inv_icm45600_fifo_decode_packet(&st->fifo.data[i],
+				&accel, &gyro, &temp, &timestamp, &odr);
+		/* quit if error or FIFO is empty */
+		if (size <= 0)
+			return size;
+
+		/* skip packet if no gyro data or data is invalid */
+		if (gyro == NULL || !inv_icm45600_fifo_is_data_valid(gyro))
+			continue;
+
+		/* update odr */
+		if (odr & INV_ICM45600_SENSOR_GYRO)
+			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
+							st->fifo.nb.total, no);
+
+		/* buffer is copied to userspace, zeroing it to avoid any data leak */
+		memset(&buffer, 0, sizeof(buffer));
+		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
+		/* convert 8 bits FIFO temperature in high resolution format */
+		buffer.temp = temp ? (*temp * 64) : 0;
+		ts_val = inv_sensors_timestamp_pop(ts);
+		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
+	}
+
+	return 0;
+}
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_temp.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_temp.c
new file mode 100644
index 0000000000000000000000000000000000000000..b2b5697da407de0a0338841eb858b4322996923c
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_temp.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Invensense, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include "inv_icm45600_temp.h"
+#include "inv_icm45600.h"
+
+static int inv_icm45600_temp_read(struct inv_icm45600_state *st, int16_t *temp)
+{
+	struct device *dev = regmap_get_device(st->map);
+	__le16 *raw;
+	int ret;
+
+	pm_runtime_get_sync(dev);
+	scoped_guard(mutex, &st->lock) {
+		raw = (__le16 *)&st->buffer[0];
+		ret = regmap_bulk_read(st->map, INV_ICM45600_REG_TEMP_DATA, raw, sizeof(*raw));
+		if (ret)
+			break;
+
+		*temp = (int16_t)le16_to_cpup(raw);
+		if (*temp == INV_ICM45600_DATA_INVALID)
+			ret = -EINVAL;
+	}
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+int inv_icm45600_temp_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	int16_t temp;
+	int ret;
+
+	if (chan->type != IIO_TEMP)
+		return -EINVAL;
+
+	/* temperature sensor work only with accel and/or gyro */
+	if (st->conf.accel.mode <= INV_ICM45600_SENSOR_MODE_STANDBY &&
+		st->conf.gyro.mode  <= INV_ICM45600_SENSOR_MODE_STANDBY) {
+		return -ENODATA;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm45600_temp_read(st, &temp);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		*val = temp;
+		return IIO_VAL_INT;
+	/*
+	 * T°C = (temp / 128) + 25
+	 * Tm°C = 1000 * ((temp * 100 / 12800) + 25)
+	 * scale: 100000 / 13248 = 7.8125
+	 * offset: 25000
+	 */
+	case IIO_CHAN_INFO_SCALE:
+		*val = 7;
+		*val2 = 812500;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 25000;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_temp.h b/drivers/iio/imu/inv_icm45600/inv_icm45600_temp.h
new file mode 100644
index 0000000000000000000000000000000000000000..1b93e1417e2ec1292e44f05b98c6393354c5297c
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_temp.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025 Invensense, Inc.
+ */
+
+#ifndef INV_ICM45600_TEMP_H_
+#define INV_ICM45600_TEMP_H_
+
+#include <linux/iio/iio.h>
+
+#define INV_ICM45600_TEMP_CHAN(_index)					\
+	{								\
+		.type = IIO_TEMP,					\
+		.info_mask_separate =					\
+			BIT(IIO_CHAN_INFO_RAW) |			\
+			BIT(IIO_CHAN_INFO_OFFSET) |			\
+			BIT(IIO_CHAN_INFO_SCALE),			\
+		.scan_index = _index,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+			.endianness = IIO_LE,				\
+		},							\
+	}
+
+int inv_icm45600_temp_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask);
+
+#endif

-- 
2.34.1



