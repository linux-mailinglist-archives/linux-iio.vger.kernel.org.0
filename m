Return-Path: <linux-iio+bounces-27946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1001D3A443
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 11:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15218305245E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 10:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0316359FB8;
	Mon, 19 Jan 2026 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Eyp0kUBW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFF135970F
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817098; cv=none; b=YAVMEgiGYbm1lO7caB/D4KqccZPsaGqO4OBsTEkKBLz9ekxjnrHlyz7vcSrCUUAHrrJlFNXFrfu9m5iyjTgwivUS4G93V3VwsWZD+z45L0dg47wR/Z2V4caPXFVWux8GoGP8Sj3bfmryxX9WGvowxM1LO9eHc7J7XsTWkGdvc/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817098; c=relaxed/simple;
	bh=IdNDndd7w5r7M55hTueySne0XQOKVU9++ZeguJiIhU4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m1PfmveDhSaNkDMTyFcc3zChrK5y3pnHqO0JYbxAx0OKi2oq+EEdIDdaEt0Y4HixzRx8tikE2J6n8eZQxXOCjJnBVhtO4CDcQTqOFSTXUvEC6GG1qtXXWcMVO8T50e77Ps1X5+yqITNI6TuQWzvnlBuJksJd83ARM6S/9TQbPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Eyp0kUBW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b876c0d5318so556927266b.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 02:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768817094; x=1769421894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TyWqUq5LW1GdDM0hxf7vaSFYPuU6ZgyjgP98+ub5RWo=;
        b=Eyp0kUBWFuh+84TTtiNP0QrRx9AihdwHyuLbInFgeuGnPH49jounPyBiDb6AB1uCDF
         7xYNLvUlySEFHsDOHPp5LLXMWU5dYnfX3GJtqNw8pnpOq6wKV532CZszuJo8LHOtMCIc
         /hOpdJH3DpL1vQCvIVYKAH6T7OCZD5cplL5w3kE1ys/HcGkuWvvWj5zFz5PlChpLnZ5I
         ZVXVNuDuQq5djpPfvmxUwSduYSt/IERDelUsp9KN2k8tmcW3NWNDLk3kBuxhiCyHw+5r
         yjpNWTh6tl+9L5hqgeo/K8azMXbYkyOVNL0cp94YQGkcJjWIGrxw1S3cpeuw8iSMcOVu
         /bSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817094; x=1769421894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TyWqUq5LW1GdDM0hxf7vaSFYPuU6ZgyjgP98+ub5RWo=;
        b=ebcN4e456g2f/QmSlQCMpI3CBl/xLiGxczB6xATjcPWIFFuOBQ/FJBdzogpT+SIXqF
         YzJ6BPsbttC0Gn+HhyOxtNk3dgLB91cKZp6vPcKRVAt56BCU/SMFBCnqL+T3OqwGVfCj
         WkX3sWBHaWvYv/fBSbB+isch/BIEHZvdkaX+wA30Rf2Lub201SRj1BV8yX2K2HvjaRII
         NXY7Lg6QVfAOgiyLTkpEkUjzVen39CUcmU5KlzRB+mE5QWOeq3lWxuZtbcAFXow4sbYI
         uxjUIpfYxKkear+a2D0c7HrtUhvLEzaEL44jWIl9sxywn1AnDOTAuLk+mcVsrTn9Cg7G
         jZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCW/AJka8+cpHvoOIJXwiMPs0SiLPOrH3aLZjKX1wJWZyi0iOM1IHK1b+/TMwy38FAi3i2QKoCPBxok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK4hTcIG/0cBNiG0blGU1VcH2i7+sGM6u5VZirR7WF5XQy1v5y
	RywFibwfstoFOonObKVRZn/BnmBhK/nBE5mQ80hnkz7Ea/FZU27An4KKeGSTzMExeJI=
X-Gm-Gg: AY/fxX65evpDWbq8N8DoXc+v3j+ngJ132yGuVDtsYHSYJIQCe1DWftBdlf0kIFe8yIn
	aEKBuiB+gn+n2Aa5VYirZHK5Lqqy1q0uCpGScDALnpyiK46zGqD7SYi0ysIB23bJmsc8zwuGSk7
	Ay24biBgBwR+esWnX59E2Qrfx08oXNPEBDHBajmxWRQNfs74R3UFa3Q1hlZa9/GhAPqcZ2AXgHw
	T3QIwi6viqlraAU4BKu5B1+SZI7NAcR06QHcXgkK1mpRWXHfciKb1MOt9+ivDKeguScmVNdnpVI
	cyNVTnXLvSkV7qxzOGAlXfEh5OqoZrSiz1AWRTdbK05pOe/MGATuMm831Y0TXe5SzAma4wRAkgo
	dRuPwZj/TnS1Z6Wno14ATnxZpR/3gaJE47SMlIvryfT+WSxJ6xMhsFzY=
X-Received: by 2002:a17:907:a0c9:b0:b87:117f:b6f0 with SMTP id a640c23a62f3a-b8792fc4530mr1030605166b.30.1768817094330;
        Mon, 19 Jan 2026 02:04:54 -0800 (PST)
Received: from localhost ([151.37.196.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9fbbsm1082403666b.38.2026.01.19.02.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:04:54 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] iio: imu: st_lsm6dsx: add support for rotation sensor
Date: Mon, 19 Jan 2026 11:04:49 +0100
Message-Id: <20260119100449.1559624-4-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260119100449.1559624-1-flavra@baylibre.com>
References: <20260119100449.1559624-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14868; i=flavra@baylibre.com; h=from:subject; bh=IdNDndd7w5r7M55hTueySne0XQOKVU9++ZeguJiIhU4=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpbgGpuU6B8snJcX4r7ubTdSiorjIeBqeelyUFw v4q5XHYN6eJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaW4BqQAKCRDt8TtzzpQ2 XycmDACujL1uw6lOqo5udaxf+wgtFgaZq8c1hCEuLJ4457k22ZrdlUfxODCyPDdVwSPX/9YsZCN 4kOqWISUjEgel9cu65qyJ4mJnviH0oCBtvTmaoLm2EAgNjedtbvz0dCx7fL2UT/a9ygUAsfJRva IvVOsow0iPF8Dyj0RKU8ImQCsWklmopz5g9yI+ndvUhYZwOA/PDbre5OZQT8DvjwDU16x26mHPj 3Ix7D8qR2CwXniSHOUnlB3AG/6nVDOeP9OYfBIsfxgiav3ghaKyMn1W27nEVtDMdufGnmHgDVz9 rNUrA1gVvlked0Wl8//6SRYhA/VCBtUGcG43WuZ6VifuK74SQkn9EiekNrP6sfssmebkSzKS0e4 oJoLXHN2yQIj7UrSnTx6z3mSsUj2D/r/Bq+c+kOQoO2KLdHbfiwxtXyZulbZN3FEpTwhTMRbIA/ l29sW4PR3fnuc4rrZtOXIxC4RV2vnhmpE2WtZhuGplU8eVB8gztTL4qmLCP+5IMHxxhCY=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

Some IMU chips in the LSM6DSX family have sensor fusion features that
combine data from the accelerometer and gyroscope. One of these features
generates rotation vector data and makes it available in the hardware
FIFO as a quaternion (more specifically, the X, Y and Z components of the
quaternion vector, expressed as 16-bit half-precision floating-point
numbers).

Add support for a new sensor instance that allows receiving sensor fusion
data, by defining a new struct st_lsm6dsx_sf_settings (which contains
chip-specific details for the sensor fusion functionality), and adding this
struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_core.c,
populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add the
logic to initialize an additional IIO device if this struct is populated
for the hardware type being probed.
Note: a new IIO device is being defined (as opposed to adding channels to
an existing device) because the rate at which sensor fusion data is
generated may not match the data rate from any of the existing devices.

Tested on LSMDSV16X.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/Makefile           |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  26 ++-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  16 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 220 ++++++++++++++++++
 5 files changed, 315 insertions(+), 7 deletions(-)
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

diff --git a/drivers/iio/imu/st_lsm6dsx/Makefile b/drivers/iio/imu/st_lsm6dsx/Makefile
index 57cbcd67d64f..19a488254de3 100644
--- a/drivers/iio/imu/st_lsm6dsx/Makefile
+++ b/drivers/iio/imu/st_lsm6dsx/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 st_lsm6dsx-y := st_lsm6dsx_core.o st_lsm6dsx_buffer.o \
-		st_lsm6dsx_shub.o
+		st_lsm6dsx_shub.o st_lsm6dsx_fusion.o
 
 obj-$(CONFIG_IIO_ST_LSM6DSX) += st_lsm6dsx.o
 obj-$(CONFIG_IIO_ST_LSM6DSX_I2C) += st_lsm6dsx_i2c.o
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 07b1773c87bd..4173f670f7af 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -294,6 +294,7 @@ enum st_lsm6dsx_sensor_id {
 	ST_LSM6DSX_ID_EXT0,
 	ST_LSM6DSX_ID_EXT1,
 	ST_LSM6DSX_ID_EXT2,
+	ST_LSM6DSX_ID_SF,
 	ST_LSM6DSX_ID_MAX
 };
 
@@ -301,6 +302,15 @@ enum st_lsm6dsx_ext_sensor_id {
 	ST_LSM6DSX_ID_MAGN,
 };
 
+struct st_lsm6dsx_sf_settings {
+	const struct iio_chan_spec *chan;
+	int chan_len;
+	struct st_lsm6dsx_odr_table_entry odr_table;
+	struct st_lsm6dsx_reg fifo_enable;
+	struct st_lsm6dsx_reg page_mux;
+	struct st_lsm6dsx_reg enable;
+};
+
 /**
  * struct st_lsm6dsx_ext_dev_settings - i2c controller slave settings
  * @i2c_addr: I2c slave address list.
@@ -388,6 +398,7 @@ struct st_lsm6dsx_settings {
 	struct st_lsm6dsx_hw_ts_settings ts_settings;
 	struct st_lsm6dsx_shub_settings shub_settings;
 	struct st_lsm6dsx_event_settings event_settings;
+	struct st_lsm6dsx_sf_settings sf_settings;
 };
 
 enum st_lsm6dsx_fifo_mode {
@@ -510,6 +521,9 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *val);
 int st_lsm6dsx_shub_probe(struct st_lsm6dsx_hw *hw, const char *name);
 int st_lsm6dsx_shub_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable);
 int st_lsm6dsx_shub_read_output(struct st_lsm6dsx_hw *hw, u8 *data, int len);
+int st_lsm6dsx_sf_probe(struct st_lsm6dsx_hw *hw, const char *name);
+int st_lsm6dsx_sf_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable);
+int st_lsm6dsx_sf_set_odr(struct st_lsm6dsx_sensor *sensor, bool enable);
 int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable);
 
 static inline int
@@ -564,12 +578,14 @@ st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio_dev,
 static inline int
 st_lsm6dsx_device_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
 {
-	if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
-	    sensor->id == ST_LSM6DSX_ID_EXT1 ||
-	    sensor->id == ST_LSM6DSX_ID_EXT2)
+	switch (sensor->id) {
+	case ST_LSM6DSX_ID_EXT0 ... ST_LSM6DSX_ID_EXT2:
 		return st_lsm6dsx_shub_set_enable(sensor, enable);
-
-	return st_lsm6dsx_sensor_set_enable(sensor, enable);
+	case ST_LSM6DSX_ID_SF:
+		return st_lsm6dsx_sf_set_enable(sensor, enable);
+	default:
+		return st_lsm6dsx_sensor_set_enable(sensor, enable);
+	}
 }
 
 static const
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 5b28a3ffcc3d..9a259e04755f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -88,6 +88,7 @@ enum st_lsm6dsx_fifo_tag {
 	ST_LSM6DSX_EXT0_TAG = 0x0f,
 	ST_LSM6DSX_EXT1_TAG = 0x10,
 	ST_LSM6DSX_EXT2_TAG = 0x11,
+	ST_LSM6DSX_ROT_TAG = 0x13,
 };
 
 static const
@@ -226,8 +227,11 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
 	u8 data;
 
 	/* Only internal sensors have a FIFO ODR configuration register. */
-	if (sensor->id >= ARRAY_SIZE(hw->settings->batch))
+	if (sensor->id >= ARRAY_SIZE(hw->settings->batch)) {
+		if (sensor->id == ST_LSM6DSX_ID_SF)
+			return st_lsm6dsx_sf_set_odr(sensor, enable);
 		return 0;
+	}
 
 	batch_reg = &hw->settings->batch[sensor->id];
 	if (batch_reg->addr) {
@@ -580,6 +584,16 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
 	case ST_LSM6DSX_EXT2_TAG:
 		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT2];
 		break;
+	case ST_LSM6DSX_ROT_TAG:
+		/*
+		 * The sensor reports only the {X, Y, Z} elements of the
+		 * quaternion vector; set the W value to 0 (it can be derived
+		 * from the {X, Y, Z} values due to the property that the vector
+		 * is normalized).
+		 */
+		*(u16 *)(data + ST_LSM6DSX_SAMPLE_SIZE) = 0;
+		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_SF];
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index dc0ae0e488ce..c21163a06a71 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -94,6 +94,24 @@
 
 #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
 
+/* Raw values from the IMU are 16-bit half-precision floating-point numbers. */
+#define ST_LSM6DSX_CHANNEL_ROT						\
+{									\
+	.type = IIO_ROT,						\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_QUATERNION,					\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = 0,						\
+	.scan_type = {							\
+		.sign = 'u',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+		.repeat = 4,						\
+	},								\
+	.ext_info = st_lsm6dsx_ext_info,				\
+}
+
 static const struct iio_event_spec st_lsm6dsx_ev_motion[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -153,6 +171,11 @@ static const struct iio_chan_spec st_lsm6ds0_gyro_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const struct iio_chan_spec st_lsm6dsx_sf_channels[] = {
+	ST_LSM6DSX_CHANNEL_ROT,
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	{
 		.reset = {
@@ -1492,6 +1515,35 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				},
 			},
 		},
+		.sf_settings = {
+			.chan = st_lsm6dsx_sf_channels,
+			.chan_len = ARRAY_SIZE(st_lsm6dsx_sf_channels),
+			.odr_table = {
+				.reg = {
+					.addr = 0x5e,
+					.mask = GENMASK(5, 3),
+				},
+				.odr_avl[0] = {  15000, 0x00 },
+				.odr_avl[1] = {  30000, 0x01 },
+				.odr_avl[2] = {  60000, 0x02 },
+				.odr_avl[3] = { 120000, 0x03 },
+				.odr_avl[4] = { 240000, 0x04 },
+				.odr_avl[5] = { 480000, 0x05 },
+				.odr_len = 6,
+			},
+			.fifo_enable = {
+				.addr = 0x44,
+				.mask = BIT(1),
+			},
+			.page_mux = {
+				.addr = 0x01,
+				.mask = BIT(7),
+			},
+			.enable = {
+				.addr = 0x04,
+				.mask = BIT(1),
+			},
+		},
 	},
 	{
 		.reset = {
@@ -2899,6 +2951,12 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
+	if (hw->settings->sf_settings.chan) {
+		err = st_lsm6dsx_sf_probe(hw, name);
+		if (err)
+			return err;
+	}
+
 	if (hw->irq > 0) {
 		err = st_lsm6dsx_irq_setup(hw);
 		if (err < 0)
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
new file mode 100644
index 000000000000..11ab246ef9d6
--- /dev/null
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * STMicroelectronics st_lsm6dsx IMU sensor fusion
+ */
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/sprintf.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include "st_lsm6dsx.h"
+
+static int
+st_lsm6dsx_sf_get_odr_val(const struct st_lsm6dsx_sf_settings *settings,
+			  u32 odr, u8 *val)
+{
+	int i;
+
+	for (i = 0; i < settings->odr_table.odr_len; i++) {
+		if (settings->odr_table.odr_avl[i].milli_hz == odr)
+			break;
+	}
+	if (i == settings->odr_table.odr_len)
+		return -EINVAL;
+
+	*val = settings->odr_table.odr_avl[i].val;
+	return 0;
+}
+
+/**
+ * st_lsm6dsx_sf_set_page - Enable or disable access to sensor fusion
+ * configuration registers.
+ * @hw: Sensor hardware instance.
+ * @enable: True to enable access, false to disable access.
+ *
+ * Return: 0 on success, negative value on error.
+ */
+static int st_lsm6dsx_sf_set_page(struct st_lsm6dsx_hw *hw, bool enable)
+{
+	const struct st_lsm6dsx_reg *mux = &hw->settings->sf_settings.page_mux;
+
+	return regmap_assign_bits(hw->regmap, mux->addr, mux->mask, enable);
+}
+
+int st_lsm6dsx_sf_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
+{
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+	const struct st_lsm6dsx_reg *en_reg;
+	int err;
+
+	guard(mutex)(&hw->page_lock);
+
+	en_reg = &hw->settings->sf_settings.enable;
+	err = st_lsm6dsx_sf_set_page(hw, true);
+	if (err < 0)
+		return err;
+
+	err = regmap_assign_bits(hw->regmap, en_reg->addr, en_reg->mask, enable);
+	if (err < 0) {
+		st_lsm6dsx_sf_set_page(hw, false);
+		return err;
+	}
+
+	return st_lsm6dsx_sf_set_page(hw, false);
+}
+
+int st_lsm6dsx_sf_set_odr(struct st_lsm6dsx_sensor *sensor, bool enable)
+{
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+	const struct st_lsm6dsx_sf_settings *settings;
+	u8 data;
+	int err;
+
+	guard(mutex)(&hw->page_lock);
+
+	err = st_lsm6dsx_sf_set_page(hw, true);
+	if (err < 0)
+		return err;
+
+	settings = &hw->settings->sf_settings;
+	if (enable) {
+		u8 odr_val;
+		const struct st_lsm6dsx_reg *reg = &settings->odr_table.reg;
+
+		st_lsm6dsx_sf_get_odr_val(settings, sensor->hwfifo_odr_mHz,
+					  &odr_val);
+		data = ST_LSM6DSX_SHIFT_VAL(odr_val, reg->mask);
+		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+					 data);
+		if (err < 0)
+			goto out;
+	}
+
+	err = regmap_assign_bits(hw->regmap, settings->fifo_enable.addr,
+				 settings->fifo_enable.mask, enable);
+	if (err < 0)
+		goto out;
+
+	return st_lsm6dsx_sf_set_page(hw, false);
+
+out:
+	st_lsm6dsx_sf_set_page(hw, false);
+
+	return err;
+}
+
+static int st_lsm6dsx_sf_read_raw(struct iio_dev *iio_dev,
+				  struct iio_chan_spec const *ch,
+				  int *val, int *val2, long mask)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = sensor->hwfifo_odr_mHz / MILLI;
+		*val2 = (sensor->hwfifo_odr_mHz % MILLI) * (MICRO / MILLI);
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int st_lsm6dsx_sf_write_raw(struct iio_dev *iio_dev,
+				   struct iio_chan_spec const *chan,
+				   int val, int val2, long mask)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+	const struct st_lsm6dsx_sf_settings *settings;
+	int err;
+
+	settings = &sensor->hw->settings->sf_settings;
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		u32 odr_mHz = val * MILLI + val2 * MILLI / MICRO;
+		u8 odr_val;
+
+		/* check that the requested frequency is supported */
+		err = st_lsm6dsx_sf_get_odr_val(settings, odr_mHz, &odr_val);
+		if (err)
+			return err;
+
+		sensor->hwfifo_odr_mHz = odr_mHz;
+		return 0;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t st_lsm6dsx_sf_sampling_freq_avail(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_to_iio_dev(dev));
+	const struct st_lsm6dsx_sf_settings *settings;
+	int len = 0;
+
+	settings = &sensor->hw->settings->sf_settings;
+	for (unsigned int i = 0; i < settings->odr_table.odr_len; i++) {
+		u32 val = settings->odr_table.odr_avl[i].milli_hz;
+
+		len += sysfs_emit_at(buf, len, "%lu.%03lu ", val / MILLI,
+				     val % MILLI);
+	}
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sf_sampling_freq_avail);
+static struct attribute *st_lsm6dsx_sf_attributes[] = {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group st_lsm6dsx_sf_attribute_group = {
+	.attrs = st_lsm6dsx_sf_attributes,
+};
+
+static const struct iio_info st_lsm6dsx_sf_info = {
+	.attrs = &st_lsm6dsx_sf_attribute_group,
+	.read_raw = st_lsm6dsx_sf_read_raw,
+	.write_raw = st_lsm6dsx_sf_write_raw,
+	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
+};
+
+int st_lsm6dsx_sf_probe(struct st_lsm6dsx_hw *hw, const char *name)
+{
+	const struct st_lsm6dsx_sf_settings *settings;
+	struct st_lsm6dsx_sensor *sensor;
+	struct iio_dev *iio_dev;
+
+	iio_dev = devm_iio_device_alloc(hw->dev, sizeof(*sensor));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	settings = &hw->settings->sf_settings;
+	sensor = iio_priv(iio_dev);
+	sensor->id = ST_LSM6DSX_ID_SF;
+	sensor->hw = hw;
+	sensor->hwfifo_odr_mHz = settings->odr_table.odr_avl[0].milli_hz;
+	sensor->watermark = 1;
+	iio_dev->modes = INDIO_DIRECT_MODE;
+	iio_dev->info = &st_lsm6dsx_sf_info;
+	iio_dev->channels = settings->chan;
+	iio_dev->num_channels = settings->chan_len;
+	snprintf(sensor->name, sizeof(sensor->name), "%s_sf", name);
+	iio_dev->name = sensor->name;
+
+	/*
+	 *  Put the IIO device pointer in the iio_devs array so that the caller
+	 *  can set up a buffer and register this IIO device.
+	 */
+	hw->iio_devs[ST_LSM6DSX_ID_SF] = iio_dev;
+
+	return 0;
+}
-- 
2.39.5


