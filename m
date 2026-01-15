Return-Path: <linux-iio+bounces-27828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0778ED247A4
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 13:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2836F30590D9
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 12:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C81396D15;
	Thu, 15 Jan 2026 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Sh0mtqrT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3187395268
	for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479889; cv=none; b=aTmBLEj8K+oY+xGygIK0qrQUuHKM0nFOfrZ1QWLFo0smOgXINnViq0K+TAZAYe4gDQ/5e8WJ5+OFiWyyFvXbogVy3iDmZUIUhSDMQ9ZHy+fIqzeBp3lem1rbTZQ6rC3vYLIcukWBvctpEaDxYjBDdDc5Rhu/FrAvP87u/tu5ad8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479889; c=relaxed/simple;
	bh=eAE8bx3nthEXnPAwN1UtDNhmJKqoQvTIIPqqhN93GaU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sh92UXpvhPGN66LbrN03ZJ5n8UgsqpRx4/WSzO7wgYPo65HT0y9SkIgwZTZeqN6XNIMxi54VzURzz03pvsNgdico8k2pLFHCOQ0QSFhySuRNI+DfLMZUm2iSF+ubP3/lA4yz8L1Du1x+GsLfWagrt9H27nGqJZclMbAgGGsB8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Sh0mtqrT; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b870732cce2so137027066b.3
        for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 04:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768479878; x=1769084678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6mzEvNPGvJ4fziVk+je0M6PHmlcevtcpm9cWqsEor0=;
        b=Sh0mtqrTJhrKTpatDGnd0DqssJ5JU7ajfEMmlmwmN0z7Zka+twONIhCPH269YD22R4
         Chf7Bb7ZaPErHUi+e+2HgwhL+Yql+qBbQ2/uHly2swYvlfJiK6pBuLU+TKm5+AfOnR2e
         oeVMs6mlGHYpHXxC+wY3pzEBRjXz4bhhO4LD1wIiq3SZi4MD8oxuB83nbGNJNu8TRu8I
         d6qnO9JwyuLPiu3aKr4R6Z3ZyNPgguIteWjyT+puQ4wmPWQvRVzJd0OpVWEA/URRdK2B
         lhcIc3J6kA0vHpi4tIJE0YOmEfWTfxyX8KvrUTT/1waKfM3Z8ivK49kpwJ3rSi+FImJ+
         DlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479878; x=1769084678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i6mzEvNPGvJ4fziVk+je0M6PHmlcevtcpm9cWqsEor0=;
        b=I69dYAToeyrVao3ybaOZTYB9g0ijQlCOBRrEgh43DMKextpVHJgfZEvXUWd/sKzjhX
         PS19w7n7aghgVziy+BDQuGV8b5sfLprZwoamZ42fJyQJGypyog6z8zmgLTz9F3qqNLJp
         CY5VHf9ogjy61d0kAhJHoOeFCqwqlCkbHgdPSJfpS6NDTTQU0yBdSQKLZEg1crq5gvXY
         kxG6vW+M0/mB5rHRW6R3BAgFSTbxzBQdRf/+9U8fyjk+kbsopw9CTlOH79bvOcxw4qJg
         tjn9KU+tdit1jrtwU+FgMmVo3oWt4GcOdG0VwJxAKKLZNMG55eDMRyoWCG86690cUJLp
         ZKJw==
X-Forwarded-Encrypted: i=1; AJvYcCVRSrWiSTY8oJUqHDy+QbJQuoEJiAgY7lF0oX4Ovy2f0GVd+vTe6jx5P7y90mkTO02UuJ81GFq1HTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr3lENc6UwVR2IyA0Q9bQWewP6qhHBDfzteo7QSU1yDyfHYKjb
	hZyFbpKIBE/lN7/9COBAOh3YongSvexQu3BykX3FO7ZjtEJ25OUJ9j+1MgUHQbB0w2qzptq0QSs
	WcY36+Zk=
X-Gm-Gg: AY/fxX4kE9OUm8BRBEbMERiIskYnSx/Zu6LS08mH89s8Ig6YHht65CVxwzElkLgJeeR
	soGJHUZUFTHJbYc8yVXB569UTMUaJ38KzXJKN29pYGsuifOqq/+PWWh9RVbMUKocuNlFzQWqQWl
	8DeOcgQRYqfxCvlStz1neaDwI8bfhcWiLjDnX8xjSk/Qx4lr5U56aoAwwMv7s8311720RIOTaIt
	m7izBApnR6tsT0E4pGvw48ygemkI1rr2tKhHVSPYjCRGtxXps81xT0kTRhdi1gYT/GJfeZlw3rJ
	6TmslUjZ7MtVBq3TU+7iAzS0uHeC4uP9VKYXoHhCjQ7HKkVCwyQyiEwmXbkspoMsv3pdd6DTH/x
	k8m6tWpg+J0wx1dg38+GEsQ04BnXHTb4eKfi13jR+0NDlTxgx5/GLkHMgPA==
X-Received: by 2002:a17:906:6a09:b0:b87:965:9078 with SMTP id a640c23a62f3a-b8760fcbe64mr436660566b.7.1768479877960;
        Thu, 15 Jan 2026 04:24:37 -0800 (PST)
Received: from localhost ([151.47.157.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b876b6865desm407693166b.12.2026.01.15.04.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:24:37 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iio: imu: st_lsm6dsx: Add support for rotation sensor
Date: Thu, 15 Jan 2026 13:24:31 +0100
Message-Id: <20260115122431.1014630-4-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260115122431.1014630-1-flavra@baylibre.com>
References: <20260115122431.1014630-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14623; i=flavra@baylibre.com; h=from:subject; bh=eAE8bx3nthEXnPAwN1UtDNhmJKqoQvTIIPqqhN93GaU=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpaNxmqFjb4CwiGPmvIqKChd2gAjf0e1YnApW5+ MgO2Hc8BGGJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaWjcZgAKCRDt8TtzzpQ2 X4ixDAClJyYq9v6llugFdnbebCrjF6xjKL1zs0ypxz+5lb9lUfYYCt1qSpIbZltE0prLKfY1LWl oV5rDfMUgS4zKuJOJs76GpmQHvZK2SCMI0NmAXnlczTCbofODua0zJ5X36jSNaJwh30jLVn02AL ATvvavSEyzMaWhj3/kxQEbjybQbBisqk1nntPIlewI+10beLY28c5kCukc4BmZ29JgdZiPemeXT 3HOlcoHUoHYkubO6Cnr3TU+GSuPPeGBffAefr+PWnT0LJV9GunjTMEnWd6z7bUsYeODy15kyNFv n0VGjs9QuDf5//z2yjiCPyEeqN3YauRpJ5wUPHhz5MQ4AjeeZ3ZUhNHpw5IXOrWvnqCFhmIjWNp yrnAHhZPssfzG09wVzXTQWX72kuCWQrTZX4I+qoLr56JgcOrXz2ODoJ5Hj5TFomqoSbnG5xaAzt zdAr0ILAUGBgF86mxC7YBIY8OzYPMTIQTd0NyTfUE6hKBsN3RXtPovNwSEkEKaxjKp78Y=
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
---
 drivers/iio/imu/st_lsm6dsx/Makefile           |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  26 ++-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  16 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 212 ++++++++++++++++++
 5 files changed, 307 insertions(+), 7 deletions(-)
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
index cde29b2e6f34..1846b9f84c29 100644
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
index 000000000000..3594d97a98ff
--- /dev/null
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
@@ -0,0 +1,212 @@
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
+	st_lsm6dsx_sf_set_page(hw, false);
+
+	return err;
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
+	err = regmap_assign_bits(hw->regmap, settings->fifo_enable.addr,
+				 settings->fifo_enable.mask, enable);
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
+		u32 odr_mHz;
+		u8 odr_val;
+
+		odr_mHz = val * MILLI + val2 * MILLI / MICRO;
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


