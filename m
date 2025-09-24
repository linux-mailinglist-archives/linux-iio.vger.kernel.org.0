Return-Path: <linux-iio+bounces-24395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D91AB991A3
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 11:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BAA19C6C40
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 09:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882072D8DDB;
	Wed, 24 Sep 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVg6evSr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B48A2D738B;
	Wed, 24 Sep 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705848; cv=none; b=LB1XdSLcDKVriHyV31fVUCaHr+TdUCvw7JCm1Er+hjluM+PsjdCefUE+3mH7vomBVZkO1BK6BJFyzOcttbxqq8mxma6VuE6XwoZSlOBssqFpfR4XaQfIjfPs+aN0M6fE2uppxbKMwx2dlXX2aRir+zrWnFwqvFP11wf05enqSDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705848; c=relaxed/simple;
	bh=wgMI/sWEReySIwtMQSnErzJr5/GFWspk45BzYkZPIPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lohrmsqbd2myQIk/5nbZwmfPN11fHhoLUh4l8eA0gyZTRSn7rOElz6sty8MrVWne2cHxAbe3BKHiSOewrZF75PMJaS22Y5+KeeBm3MG7psIyubdC9gFFS6ExhB32rYAUgtYo4DmxQ6R7jbxcay+yMsw0dJ21g2x9WHyDW5Mq8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVg6evSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 936B0C2BCC4;
	Wed, 24 Sep 2025 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758705847;
	bh=wgMI/sWEReySIwtMQSnErzJr5/GFWspk45BzYkZPIPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TVg6evSrxHGseHYFMsIP7ouuXIke8jVlRmV1HPNS5hLD5UQ+Rcvr3cYbLm7uvBGJ/
	 KGdRVTWjVGEAG/ZuDhcSRLnRktsL+hOrO/QZLlxp8yqxpgDlMZf5jeybtBA8i9PRUV
	 JE1VN8hJtqKVDoD4h0y7uCLe8QD1eHr0Jp4KyEJJqba+1fK/vFpmckH60PiQUHtxvt
	 AY0ZSFfaYNTuRYcCd2Huh7MHkbYtmfGfzJZF2M3kHJAQinDU9FYEN2/09TZ6u02SKO
	 TjWKuxN4kFEtXIOId882YXGe1s+P2i81Sx3vwWxHoEjHajYjQ0ws9CR80fSUUHedDb
	 owIR+DRg//fSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4BBCAC5B0;
	Wed, 24 Sep 2025 09:24:07 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Wed, 24 Sep 2025 09:23:57 +0000
Subject: [PATCH v6 4/9] iio: imu: inv_icm45600: add IMU IIO gyroscope
 device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250924-add_newport_driver-v6-4-76687b9d8a6e@tdk.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758705845; l=38233;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=E/lJsSgMrenQQ+ZoUE+tMD+MoM3Gui5nvAVQxWLJenE=;
 b=PyaBFjcA6k5d5V6oz5UKiZo5DJUdvBaSrO7e0bU2bF611U9DDeeV4IP/T0z92bEfN2zg8EwL2
 /OuVO1hQxGNCZRjvJ3BU1/dLSozoj3cvvTPF5SNXEqrIJUT4emoxUYq
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Add IIO device for gyroscope sensor
with data polling interface and FIFO parsing.
Attributes: raw, scale, sampling_frequency, calibbias.
Temperature is available as a processed channel.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 drivers/iio/imu/inv_icm45600/Kconfig               |   2 +
 drivers/iio/imu/inv_icm45600/Makefile              |   1 +
 drivers/iio/imu/inv_icm45600/inv_icm45600.h        |  38 +
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c |  56 +-
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h |   5 +-
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   | 179 ++++-
 drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c   | 791 +++++++++++++++++++++
 7 files changed, 1069 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_icm45600/Kconfig b/drivers/iio/imu/inv_icm45600/Kconfig
index 8cb5543e0a5817323ab7b2d520dd3430ac5dbc99..ea0a8d20cba26549b74105fa6fdbca1ddb222633 100644
--- a/drivers/iio/imu/inv_icm45600/Kconfig
+++ b/drivers/iio/imu/inv_icm45600/Kconfig
@@ -2,4 +2,6 @@
 
 config INV_ICM45600
 	tristate
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 	select IIO_INV_SENSORS_TIMESTAMP
diff --git a/drivers/iio/imu/inv_icm45600/Makefile b/drivers/iio/imu/inv_icm45600/Makefile
index 72f95bc30d993e0ea16b97622f4a041a09ec6559..b5954b4053c25259957faf4fc9d1979c9ff74608 100644
--- a/drivers/iio/imu/inv_icm45600/Makefile
+++ b/drivers/iio/imu/inv_icm45600/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_INV_ICM45600) += inv-icm45600.o
 inv-icm45600-y += inv_icm45600_core.o
 inv-icm45600-y += inv_icm45600_buffer.o
+inv-icm45600-y += inv_icm45600_gyro.o
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
index aac8cd852c12cfba5331f2b7c1ffbbb2ed23d1c7..674c2b4091effaa594171157b8ed44dce4771c28 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600.h
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
@@ -113,8 +113,22 @@ struct inv_icm45600_chip_info {
 	u8 whoami;
 	const char *name;
 	const struct inv_icm45600_conf *conf;
+	const int *gyro_scales;
+	const int gyro_scales_len;
 };
 
+extern const struct inv_icm45600_chip_info inv_icm45605_chip_info;
+extern const struct inv_icm45600_chip_info inv_icm45606_chip_info;
+extern const struct inv_icm45600_chip_info inv_icm45608_chip_info;
+extern const struct inv_icm45600_chip_info inv_icm45634_chip_info;
+extern const struct inv_icm45600_chip_info inv_icm45686_chip_info;
+extern const struct inv_icm45600_chip_info inv_icm45687_chip_info;
+extern const struct inv_icm45600_chip_info inv_icm45688p_chip_info;
+extern const struct inv_icm45600_chip_info inv_icm45689_chip_info;
+
+extern const int inv_icm45600_gyro_scale[][2];
+extern const int inv_icm45686_gyro_scale[][2];
+
 /**
  *  struct inv_icm45600_state - driver state variables
  *  @lock:		lock for serializing multiple registers access.
@@ -319,6 +333,26 @@ const struct iio_mount_matrix *
 inv_icm45600_get_mount_matrix(const struct iio_dev *indio_dev,
 			      const struct iio_chan_spec *chan);
 
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
 u32 inv_icm45600_odr_to_period(enum inv_icm45600_odr odr);
 
 int inv_icm45600_set_accel_conf(struct inv_icm45600_state *st,
@@ -336,4 +370,8 @@ int inv_icm45600_core_probe(struct regmap *regmap,
 				const struct inv_icm45600_chip_info *chip_info,
 				bool reset, inv_icm45600_bus_setup bus_setup);
 
+struct iio_dev *inv_icm45600_gyro_init(struct inv_icm45600_state *st);
+
+int inv_icm45600_gyro_parse_fifo(struct iio_dev *indio_dev);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
index f81a85c5c77a0b0bc729734a1256af0c896c8fbd..6ffe45219f34ef248323993f8bf2790eb49bf78a 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
@@ -392,7 +392,8 @@ const struct iio_buffer_setup_ops inv_icm45600_buffer_ops = {
 	.postdisable = inv_icm45600_buffer_postdisable,
 };
 
-int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st)
+int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st,
+				  unsigned int max)
 {
 	const ssize_t packet_size = sizeof(struct inv_icm45600_fifo_2sensors_packet);
 	__le16 *raw_fifo_count;
@@ -420,6 +421,8 @@ int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st)
 	fifo_nb = le16_to_cpup(raw_fifo_count);
 	if (fifo_nb == 0)
 		return 0;
+	if (max > 0 && fifo_nb > max)
+		fifo_nb = max;
 
 	/* Try to read all FIFO data in internal buffer. */
 	st->fifo.count = fifo_nb * packet_size;
@@ -451,6 +454,57 @@ int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st)
 	return 0;
 }
 
+int inv_icm45600_buffer_fifo_parse(struct inv_icm45600_state *st)
+{
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
+	struct inv_sensors_timestamp *ts;
+	int ret;
+
+	if (st->fifo.nb.total == 0)
+		return 0;
+
+	/* Handle gyroscope timestamp and FIFO data parsing. */
+	if (st->fifo.nb.gyro > 0) {
+		ts = &gyro_st->ts;
+		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_gyro,
+						st->timestamp.gyro);
+		ret = inv_icm45600_gyro_parse_fifo(st->indio_gyro);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int inv_icm45600_buffer_hwfifo_flush(struct inv_icm45600_state *st,
+				     unsigned int count)
+{
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
+	struct inv_sensors_timestamp *ts;
+	s64 gyro_ts, accel_ts;
+	int ret;
+
+	gyro_ts = iio_get_time_ns(st->indio_gyro);
+	accel_ts = iio_get_time_ns(st->indio_accel);
+
+	ret = inv_icm45600_buffer_fifo_read(st, count);
+	if (ret)
+		return ret;
+
+	if (st->fifo.nb.total == 0)
+		return 0;
+
+	if (st->fifo.nb.gyro > 0) {
+		ts = &gyro_st->ts;
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);
+		ret = inv_icm45600_gyro_parse_fifo(st->indio_gyro);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int inv_icm45600_buffer_init(struct inv_icm45600_state *st)
 {
 	int ret;
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h
index 0c8caa8287dd4373cf11bb6c7b913a6c49e9eee5..941a744736d53faf9226757be2eaa52ccb3d3ee5 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h
@@ -86,7 +86,10 @@ int inv_icm45600_buffer_set_fifo_en(struct inv_icm45600_state *st,
 
 int inv_icm45600_buffer_update_watermark(struct inv_icm45600_state *st);
 
-int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st);
+int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st,
+				  unsigned int max);
+
+int inv_icm45600_buffer_fifo_parse(struct inv_icm45600_state *st);
 
 int inv_icm45600_buffer_hwfifo_flush(struct inv_icm45600_state *st,
 				     unsigned int count);
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
index d2744ed86f3708acdd54d449067593d1f3a927f8..c1de81a3cccd46c9de56c156c367d4a238328963 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
@@ -136,6 +136,97 @@ static const struct regmap_config inv_icm45600_regmap_config = {
 	.val_bits = 8,
 };
 
+/* These are the chip initial default configurations (default FS value is based on icm45686) */
+static const struct inv_icm45600_conf inv_icm45600_default_conf = {
+	.gyro = {
+		.mode = INV_ICM45600_SENSOR_MODE_OFF,
+		.fs = INV_ICM45686_GYRO_FS_2000DPS,
+		.odr = INV_ICM45600_ODR_800HZ_LN,
+		.filter = INV_ICM45600_GYRO_LP_AVG_SEL_8X,
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
+};
+
+const struct inv_icm45600_chip_info inv_icm45605_chip_info = {
+	.whoami = INV_ICM45600_WHOAMI_ICM45605,
+	.name = "icm45605",
+	.conf = &inv_icm45600_default_conf,
+	.gyro_scales = (const int *)inv_icm45600_gyro_scale,
+	.gyro_scales_len = INV_ICM45600_GYRO_FS_MAX,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm45605_chip_info, "IIO_ICM45600");
+
+const struct inv_icm45600_chip_info inv_icm45606_chip_info = {
+	.whoami = INV_ICM45600_WHOAMI_ICM45606,
+	.name = "icm45606",
+	.conf = &inv_icm45600_default_conf,
+	.gyro_scales = (const int *)inv_icm45600_gyro_scale,
+	.gyro_scales_len = INV_ICM45600_GYRO_FS_MAX,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm45606_chip_info, "IIO_ICM45600");
+
+const struct inv_icm45600_chip_info inv_icm45608_chip_info = {
+	.whoami = INV_ICM45600_WHOAMI_ICM45608,
+	.name = "icm45608",
+	.conf = &inv_icm45600_default_conf,
+	.gyro_scales = (const int *)inv_icm45600_gyro_scale,
+	.gyro_scales_len = INV_ICM45600_GYRO_FS_MAX,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm45608_chip_info, "IIO_ICM45600");
+
+const struct inv_icm45600_chip_info inv_icm45634_chip_info = {
+	.whoami = INV_ICM45600_WHOAMI_ICM45634,
+	.name = "icm45634",
+	.conf = &inv_icm45600_default_conf,
+	.gyro_scales = (const int *)inv_icm45600_gyro_scale,
+	.gyro_scales_len = INV_ICM45600_GYRO_FS_MAX,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm45634_chip_info, "IIO_ICM45600");
+
+const struct inv_icm45600_chip_info inv_icm45686_chip_info = {
+	.whoami = INV_ICM45600_WHOAMI_ICM45686,
+	.name = "icm45686",
+	.conf = &inv_icm45686_default_conf,
+	.gyro_scales = (const int *)inv_icm45686_gyro_scale,
+	.gyro_scales_len = INV_ICM45686_GYRO_FS_MAX,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm45686_chip_info, "IIO_ICM45600");
+
+const struct inv_icm45600_chip_info inv_icm45687_chip_info = {
+	.whoami = INV_ICM45600_WHOAMI_ICM45687,
+	.name = "icm45687",
+	.conf = &inv_icm45686_default_conf,
+	.gyro_scales = (const int *)inv_icm45686_gyro_scale,
+	.gyro_scales_len = INV_ICM45686_GYRO_FS_MAX,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm45687_chip_info, "IIO_ICM45600");
+
+const struct inv_icm45600_chip_info inv_icm45688p_chip_info = {
+	.whoami = INV_ICM45600_WHOAMI_ICM45688P,
+	.name = "icm45688p",
+	.conf = &inv_icm45686_default_conf,
+	.gyro_scales = (const int *)inv_icm45686_gyro_scale,
+	.gyro_scales_len = INV_ICM45686_GYRO_FS_MAX,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm45688p_chip_info, "IIO_ICM45600");
+
+const struct inv_icm45600_chip_info inv_icm45689_chip_info = {
+	.whoami = INV_ICM45600_WHOAMI_ICM45689,
+	.name = "icm45689",
+	.conf = &inv_icm45686_default_conf,
+	.gyro_scales = (const int *)inv_icm45686_gyro_scale,
+	.gyro_scales_len = INV_ICM45686_GYRO_FS_MAX,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm45689_chip_info, "IIO_ICM45600");
+
 const struct iio_mount_matrix *
 inv_icm45600_get_mount_matrix(const struct iio_dev *indio_dev,
 			      const struct iio_chan_spec *chan)
@@ -467,11 +558,14 @@ static irqreturn_t inv_icm45600_irq_handler(int irq, void *_data)
 	/* Read the FIFO data. */
 	mask = INV_ICM45600_INT_STATUS_FIFO_THS | INV_ICM45600_INT_STATUS_FIFO_FULL;
 	if (status & mask) {
-		ret = inv_icm45600_buffer_fifo_read(st);
+		ret = inv_icm45600_buffer_fifo_read(st, 0);
 		if (ret) {
 			dev_err(dev, "FIFO read error %d\n", ret);
 			return IRQ_HANDLED;
 		}
+		ret = inv_icm45600_buffer_fifo_parse(st);
+		if (ret)
+			dev_err(dev, "FIFO parsing error %d\n", ret);
 	}
 
 	/* FIFO full warning. */
@@ -644,6 +738,10 @@ int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chi
 	if (ret)
 		return ret;
 
+	st->indio_gyro = inv_icm45600_gyro_init(st);
+	if (IS_ERR(st->indio_gyro))
+		return PTR_ERR(st->indio_gyro);
+
 	ret = inv_icm45600_irq_init(st, irq, irq_type, open_drain);
 	if (ret)
 		return ret;
@@ -769,6 +867,85 @@ static int inv_icm45600_runtime_resume(struct device *dev)
 	return inv_icm45600_enable_regulator_vddio(st);
 }
 
+static int _inv_icm45600_temp_read(struct inv_icm45600_state *st, s16 *temp)
+{
+	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_KEEP_VALUES;
+	int ret;
+
+	/* Make sure a sensor is on. */
+	if (st->conf.gyro.mode == INV_ICM45600_SENSOR_MODE_OFF &&
+	    st->conf.accel.mode == INV_ICM45600_SENSOR_MODE_OFF) {
+		conf.mode = INV_ICM45600_SENSOR_MODE_LOW_POWER;
+		ret = inv_icm45600_set_accel_conf(st, &conf, NULL);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_bulk_read(st->map, INV_ICM45600_REG_TEMP_DATA,
+			       &st->buffer.u16, sizeof(st->buffer.u16));
+	if (ret)
+		return ret;
+
+	*temp = (s16)le16_to_cpup(&st->buffer.u16);
+	if (*temp == INV_ICM45600_DATA_INVALID)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int inv_icm45600_temp_read(struct inv_icm45600_state *st, s16 *temp)
+{
+	struct device *dev = regmap_get_device(st->map);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &st->lock)
+		ret = _inv_icm45600_temp_read(st, temp);
+
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
+	s16 temp;
+	int ret;
+
+	if (chan->type != IIO_TEMP)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = inv_icm45600_temp_read(st, &temp);
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
+
 EXPORT_NS_GPL_DEV_PM_OPS(inv_icm45600_pm_ops, IIO_ICM45600) = {
 	SYSTEM_SLEEP_PM_OPS(inv_icm45600_suspend, inv_icm45600_resume)
 	RUNTIME_PM_OPS(inv_icm45600_runtime_suspend,
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c
new file mode 100644
index 0000000000000000000000000000000000000000..1e85fd0e4ea9ff29069e864d51c35b5f0521bf92
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c
@@ -0,0 +1,791 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Invensense, Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/math64.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+
+#include "inv_icm45600_buffer.h"
+#include "inv_icm45600.h"
+
+enum inv_icm45600_gyro_scan {
+	INV_ICM45600_GYRO_SCAN_X,
+	INV_ICM45600_GYRO_SCAN_Y,
+	INV_ICM45600_GYRO_SCAN_Z,
+	INV_ICM45600_GYRO_SCAN_TEMP,
+	INV_ICM45600_GYRO_SCAN_TIMESTAMP,
+};
+
+static const struct iio_chan_spec_ext_info inv_icm45600_gyro_ext_infos[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm45600_get_mount_matrix),
+	{ }
+};
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
+	s16 temp;
+	aligned_s64 timestamp;
+};
+
+static const unsigned long inv_icm45600_gyro_scan_masks[] = {
+	/* 3-axis gyro + temperature */
+	BIT(INV_ICM45600_GYRO_SCAN_X) |
+	BIT(INV_ICM45600_GYRO_SCAN_Y) |
+	BIT(INV_ICM45600_GYRO_SCAN_Z) |
+	BIT(INV_ICM45600_GYRO_SCAN_TEMP),
+	0
+};
+
+/* enable gyroscope sensor and FIFO write */
+static int inv_icm45600_gyro_update_scan_mode(struct iio_dev *indio_dev,
+					      const unsigned long *scan_mask)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
+	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_KEEP_VALUES;
+	unsigned int fifo_en = 0;
+	unsigned int sleep = 0;
+	int ret;
+
+	scoped_guard(mutex, &st->lock) {
+		if (*scan_mask & BIT(INV_ICM45600_GYRO_SCAN_TEMP))
+			fifo_en |= INV_ICM45600_SENSOR_TEMP;
+
+		if (*scan_mask & (BIT(INV_ICM45600_GYRO_SCAN_X) |
+				 BIT(INV_ICM45600_GYRO_SCAN_Y) |
+				 BIT(INV_ICM45600_GYRO_SCAN_Z))) {
+			/* enable gyro sensor */
+			conf.mode = gyro_st->power_mode;
+			ret = inv_icm45600_set_gyro_conf(st, &conf, &sleep);
+			if (ret)
+				return ret;
+			fifo_en |= INV_ICM45600_SENSOR_GYRO;
+		}
+		ret = inv_icm45600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
+	}
+	if (sleep)
+		msleep(sleep);
+
+	return ret;
+}
+
+static int _inv_icm45600_gyro_read_sensor(struct inv_icm45600_state *st,
+					  struct inv_icm45600_sensor_state *gyro_st,
+					  unsigned int reg, int *val)
+{
+	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_KEEP_VALUES;
+	int ret;
+
+	/* enable gyro sensor */
+	conf.mode = gyro_st->power_mode;
+	ret = inv_icm45600_set_gyro_conf(st, &conf, NULL);
+	if (ret)
+		return ret;
+
+	/* read gyro register data */
+	ret = regmap_bulk_read(st->map, reg, &st->buffer.u16, sizeof(st->buffer.u16));
+	if (ret)
+		return ret;
+
+	*val = sign_extend32(le16_to_cpup(&st->buffer.u16), 15);
+	if (*val == INV_ICM45600_DATA_INVALID)
+		return -ENODATA;
+
+	return 0;
+}
+
+static int inv_icm45600_gyro_read_sensor(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan,
+					 int *val)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int reg;
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
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &st->lock)
+		ret = _inv_icm45600_gyro_read_sensor(st, gyro_st, reg, val);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+/* IIO format int + nano */
+const int inv_icm45600_gyro_scale[][2] = {
+	/* +/- 2000dps => 0.001065264 rad/s */
+	[INV_ICM45600_GYRO_FS_2000DPS] = { 0, 1065264 },
+	/* +/- 1000dps => 0.000532632 rad/s */
+	[INV_ICM45600_GYRO_FS_1000DPS] = { 0, 532632 },
+	/* +/- 500dps => 0.000266316 rad/s */
+	[INV_ICM45600_GYRO_FS_500DPS] = { 0, 266316 },
+	/* +/- 250dps => 0.000133158 rad/s */
+	[INV_ICM45600_GYRO_FS_250DPS] = { 0, 133158 },
+	/* +/- 125dps => 0.000066579 rad/s */
+	[INV_ICM45600_GYRO_FS_125DPS] = { 0, 66579 },
+	/* +/- 62.5dps => 0.000033290 rad/s */
+	[INV_ICM45600_GYRO_FS_62_5DPS] = { 0, 33290 },
+	/* +/- 31.25dps => 0.000016645 rad/s */
+	[INV_ICM45600_GYRO_FS_31_25DPS] = { 0, 16645 },
+	/* +/- 15.625dps => 0.000008322 rad/s */
+	[INV_ICM45600_GYRO_FS_15_625DPS] = { 0, 8322 },
+};
+
+/* IIO format int + nano */
+const int inv_icm45686_gyro_scale[][2] = {
+	/* +/- 4000dps => 0.002130529 rad/s */
+	[INV_ICM45686_GYRO_FS_4000DPS] = { 0, 2130529 },
+	/* +/- 2000dps => 0.001065264 rad/s */
+	[INV_ICM45686_GYRO_FS_2000DPS] = { 0, 1065264 },
+	/* +/- 1000dps => 0.000532632 rad/s */
+	[INV_ICM45686_GYRO_FS_1000DPS] = { 0, 532632 },
+	/* +/- 500dps => 0.000266316 rad/s */
+	[INV_ICM45686_GYRO_FS_500DPS] = { 0, 266316 },
+	/* +/- 250dps => 0.000133158 rad/s */
+	[INV_ICM45686_GYRO_FS_250DPS] = { 0, 133158 },
+	/* +/- 125dps => 0.000066579 rad/s */
+	[INV_ICM45686_GYRO_FS_125DPS] = { 0, 66579 },
+	/* +/- 62.5dps => 0.000033290 rad/s */
+	[INV_ICM45686_GYRO_FS_62_5DPS] = { 0, 33290 },
+	/* +/- 31.25dps => 0.000016645 rad/s */
+	[INV_ICM45686_GYRO_FS_31_25DPS] = { 0, 16645 },
+	/* +/- 15.625dps => 0.000008322 rad/s */
+	[INV_ICM45686_GYRO_FS_15_625DPS] = { 0, 8322 },
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
+	if (gyro_st->scales ==  (const int *)&inv_icm45600_gyro_scale)
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
+	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_KEEP_VALUES;
+	int ret;
+
+	for (idx = 0; idx < gyro_st->scales_len; idx += 2) {
+		if (val == gyro_st->scales[idx] &&
+		    val2 == gyro_st->scales[idx + 1])
+			break;
+	}
+	if (idx == gyro_st->scales_len)
+		return -EINVAL;
+
+	conf.fs = idx / 2;
+
+	/* Full scale register starts at 1 for not High FSR parts */
+	if (gyro_st->scales == (const int *)&inv_icm45600_gyro_scale)
+		conf.fs++;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &st->lock)
+		ret = inv_icm45600_set_gyro_conf(st, &conf, NULL);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+/* IIO format int + micro */
+static const int inv_icm45600_gyro_odr[] = {
+	1, 562500,	/* 1.5625Hz */
+	3, 125000,	/* 3.125Hz */
+	6, 250000,	/* 6.25Hz */
+	12, 500000,	/* 12.5Hz */
+	25, 0,		/* 25Hz */
+	50, 0,		/* 50Hz */
+	100, 0,		/* 100Hz */
+	200, 0,		/* 200Hz */
+	400, 0,		/* 400Hz */
+	800, 0,		/* 800Hz */
+	1600, 0,	/* 1.6kHz */
+	3200, 0,	/* 3.2kHz */
+	6400, 0,	/* 6.4kHz */
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
+static int _inv_icm45600_gyro_write_odr(struct iio_dev *indio_dev, int odr)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &gyro_st->ts;
+	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_KEEP_VALUES;
+	int ret;
+
+	conf.odr = odr;
+	ret = inv_sensors_timestamp_update_odr(ts, inv_icm45600_odr_to_period(conf.odr),
+						iio_buffer_enabled(indio_dev));
+	if (ret)
+		return ret;
+
+	if (st->conf.gyro.mode != INV_ICM45600_SENSOR_MODE_OFF)
+		conf.mode = gyro_st->power_mode;
+
+	ret = inv_icm45600_set_gyro_conf(st, &conf, NULL);
+	if (ret)
+		return ret;
+
+	inv_icm45600_buffer_update_fifo_period(st);
+	inv_icm45600_buffer_update_watermark(st);
+
+	return 0;
+}
+
+static int inv_icm45600_gyro_write_odr(struct iio_dev *indio_dev,
+				       int val, int val2)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	int odr;
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
+	odr = inv_icm45600_gyro_odr_conv[idx / 2];
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &st->lock)
+		ret = _inv_icm45600_gyro_write_odr(indio_dev, odr);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+/*
+ * Calibration bias values, IIO range format int + nano.
+ * Value is limited to +/-62.5dps coded on 14 bits signed. Step is 7.5mdps.
+ */
+static int inv_icm45600_gyro_calibbias[] = {
+	-1, 90830336,	/* min: -1.090830336 rad/s */
+	0, 133158,	/* step: 0.000133158 rad/s */
+	1, 90697178,	/* max: 1.090697178 rad/s */
+};
+
+static int inv_icm45600_gyro_read_offset(struct inv_icm45600_state *st,
+					 struct iio_chan_spec const *chan,
+					 int *val, int *val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	s64 val64;
+	s32 bias;
+	unsigned int reg;
+	s16 offset;
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
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &st->lock)
+		ret = regmap_bulk_read(st->map, reg, &st->buffer.u16, sizeof(st->buffer.u16));
+
+	pm_runtime_put_autosuspend(dev);
+	if (ret)
+		return ret;
+
+	offset = le16_to_cpup(&st->buffer.u16) & INV_ICM45600_GYRO_OFFUSER_MASK;
+	/* 14 bits signed value */
+	offset = sign_extend32(offset, 13);
+
+	/*
+	 * convert raw offset to dps then to rad/s
+	 * 14 bits signed raw max 62.5 to dps: 625 / 81920
+	 * dps to rad: Pi / 180
+	 * result in nano (1000000000)
+	 * (offset * 625 * Pi * 1000000000) / (81920 * 180)
+	 */
+	val64 = (s64)offset * 625LL * 3141592653LL;
+	/* for rounding, add + or - divisor (81920 * 180) divided by 2 */
+	if (val64 >= 0)
+		val64 += 81920 * 180 / 2;
+	else
+		val64 -= 81920 * 180 / 2;
+	bias = div_s64(val64, 81920 * 180);
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
+	s64 val64, min, max;
+	unsigned int reg;
+	s16 offset;
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
+	min = (s64)inv_icm45600_gyro_calibbias[0] * 1000000000LL -
+	      (s64)inv_icm45600_gyro_calibbias[1];
+	max = (s64)inv_icm45600_gyro_calibbias[4] * 1000000000LL +
+	      (s64)inv_icm45600_gyro_calibbias[5];
+	val64 = (s64)val * 1000000000LL;
+	if (val >= 0)
+		val64 += (s64)val2;
+	else
+		val64 -= (s64)val2;
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
+	offset = clamp(offset, -8192, 8191);
+
+	st->buffer.u16 = cpu_to_le16(offset & INV_ICM45600_GYRO_OFFUSER_MASK);
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &st->lock)
+		ret = regmap_bulk_write(st->map, reg, &st->buffer.u16, sizeof(st->buffer.u16));
+
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+static int inv_icm45600_gyro_read_raw(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      int *val, int *val2, long mask)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
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
+		ret = inv_icm45600_gyro_read_sensor(indio_dev, chan, val);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
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
+
+	guard(mutex)(&st->lock);
+
+	st->fifo.watermark.gyro = val;
+	return inv_icm45600_buffer_update_watermark(st);
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
+	if (ret)
+		return ret;
+
+	return st->fifo.nb.gyro;
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
+	struct inv_icm45600_sensor_state *gyro_st;
+	struct inv_sensors_timestamp_chip ts_chip;
+	struct iio_dev *indio_dev;
+	const char *name;
+	int ret;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", st->chip_info->name);
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*gyro_st));
+	if (!indio_dev)
+		return ERR_PTR(-ENOMEM);
+	gyro_st = iio_priv(indio_dev);
+
+	gyro_st->scales = st->chip_info->gyro_scales;
+	gyro_st->scales_len = st->chip_info->gyro_scales_len * 2;
+
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
+
+	/* parse all fifo packets */
+	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
+		struct inv_icm45600_gyro_buffer buffer = { };
+		const struct inv_icm45600_fifo_sensor_data *accel, *gyro;
+		const __le16 *timestamp;
+		const s8 *temp;
+		unsigned int odr;
+		s64 ts_val;
+
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
+		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
+		/* convert 8 bits FIFO temperature in high resolution format */
+		buffer.temp = temp ? (*temp * 64) : 0;
+		ts_val = inv_sensors_timestamp_pop(ts);
+		iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer), ts_val);
+	}
+
+	return 0;
+}

-- 
2.34.1



