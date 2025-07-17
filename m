Return-Path: <linux-iio+bounces-21740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8237B08E1F
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 15:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C981AA4597
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 13:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8B2E543F;
	Thu, 17 Jul 2025 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGMx7khO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7F2E49BE;
	Thu, 17 Jul 2025 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758765; cv=none; b=ZvKV8kGIeUKbnBoPkxwaFEWTTBofcn4UewyYYjBU65v1hA5RIbU4PZrfMI0CaHBNW5BHAtLZTg0qzJR7tU5UsOeuptj6xkbxKnmAOj85COB/lFKtD2qWceLseUxomt3hZRsYYWSLcpp6MWpxSgiu9Ct7yQ3Jgl6oT1nlW4Y2DQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758765; c=relaxed/simple;
	bh=kNLtdNjtsc/KXTZFfBMByGcDTmYIPqKr99aX5VW6RRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GdMw+Qpf25IYWLMDm9tWG7IdnOjiTmm7+uMARNSMPbtzM101reVwhmXT3/7fQFOIHJkYo9gGESbe4BYyaNhqdvH2KyBqKgeXH4559El5qgdqSV0so3r/qKd1fUr3qRCsINi2zjhQ3/QXpcpUN0Dp2sq1BgxeMdIxRe4o6qzLQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGMx7khO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A04DC4CEF5;
	Thu, 17 Jul 2025 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752758764;
	bh=kNLtdNjtsc/KXTZFfBMByGcDTmYIPqKr99aX5VW6RRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sGMx7khOkTvp8mZsiQd6deINhcTKGO3kliN1wdOiNm0Z9WDJZH91ouc858StBlgkB
	 i6uKMHl2xofRkVzu91ppThIsYTtEZ2a7jbVBuajQcHymHLJfG/Vhh258AD4/1CuGWY
	 1ly90Kx3f9g6tFj+28JRxoJXqmKas+08fZiByY9qCHm0j+Izfe1j2yHF3Qv2oOFB/z
	 YtZueGj6OWp8L2TuTt7Eyhpx7jqNYShI/ea14CjqbbKDIzz+QEcojQSXCI2sXuU+nG
	 v7uMiizN77pRJVS+9ICtdyatWq7AF44WaCXR1asE1UG/OFZemBc71WlDeAJcS60Jrf
	 o0maWfB+QIrfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD6DC83F39;
	Thu, 17 Jul 2025 13:26:04 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Thu, 17 Jul 2025 13:25:55 +0000
Subject: [PATCH v3 3/8] iio: imu: inv_icm45600: add buffer support in iio
 devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-add_newport_driver-v3-3-c6099e02c562@tdk.com>
References: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
In-Reply-To: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752758762; l=27617;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=sjqHyfZ+Kzzb7Q79XXVNcxDsdSZGYH/XJsYPZCo5HrA=;
 b=OcJfFJ97O4x0Y8CVRpjRcE2Qqu7Dl+mqbhR8nrjnodv1F2d2etN/dJLsMhnBzTenSTEvK2oJE
 mzEjwWL5wLeC4HS67/8soxeRy33ECIdfqDR7bc6i2FSIMLdwpNR/wWA
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Add FIFO control functions.
Support hwfifo watermark by multiplexing gyro and accel settings.
Support hwfifo flush.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 drivers/iio/imu/inv_icm45600/Makefile              |   1 +
 drivers/iio/imu/inv_icm45600/inv_icm45600.h        |   7 +
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 514 +++++++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h |  99 ++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   | 137 +++++-
 5 files changed, 757 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm45600/Makefile b/drivers/iio/imu/inv_icm45600/Makefile
index 4f442b61896e91647c7947a044949792bae06a30..19c521ffba17b0d108a8ecb45ecdea35dff6fd18 100644
--- a/drivers/iio/imu/inv_icm45600/Makefile
+++ b/drivers/iio/imu/inv_icm45600/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_INV_ICM45600) += inv-icm45600.o
 inv-icm45600-y += inv_icm45600_core.o
+inv-icm45600-y += inv_icm45600_buffer.o
\ No newline at end of file
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
index 59aed59b94ca2d4709b0c986ddeda80b33064f90..5625c437b6f54336f6e652c2ae2e4ea8f88e2396 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600.h
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
@@ -8,8 +8,11 @@
 #include <linux/bits.h>
 #include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
+#include <linux/limits.h>
 #include <linux/types.h>
 
+#include "inv_icm45600_buffer.h"
+
 #define INV_ICM45600_REG_BANK_MASK	GENMASK(15, 8)
 #define INV_ICM45600_REG_ADDR_MASK	GENMASK(7, 0)
 
@@ -90,6 +93,8 @@ struct inv_icm45600_sensor_conf {
 	u8 filter;
 };
 
+#define INV_ICM45600_SENSOR_CONF_KEEP_VALUES {U8_MAX, U8_MAX, U8_MAX, U8_MAX, }
+
 struct inv_icm45600_conf {
 	struct inv_icm45600_sensor_conf gyro;
 	struct inv_icm45600_sensor_conf accel;
@@ -127,6 +132,7 @@ extern const struct inv_icm45600_chip_info inv_icm45689_chip_info;
  *  @indio_gyro:	gyroscope IIO device.
  *  @indio_accel:	accelerometer IIO device.
  *  @timestamp:		interrupt timestamps.
+ *  @fifo:		FIFO management structure.
  *  @buffer:		data transfer buffer aligned for DMA.
  */
 struct inv_icm45600_state {
@@ -143,6 +149,7 @@ struct inv_icm45600_state {
 		s64 gyro;
 		s64 accel;
 	} timestamp;
+	struct inv_icm45600_fifo fifo;
 	union {
 		u8 buff[2];
 		__le16 u16;
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
new file mode 100644
index 0000000000000000000000000000000000000000..b37607e52721097daf6362bac20001b0d4210f4b
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
@@ -0,0 +1,514 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2025 Invensense, Inc. */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/iio.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include "inv_icm45600_buffer.h"
+#include "inv_icm45600.h"
+
+/* FIFO header: 1 byte */
+#define INV_ICM45600_FIFO_EXT_HEADER		BIT(7)
+#define INV_ICM45600_FIFO_HEADER_ACCEL		BIT(6)
+#define INV_ICM45600_FIFO_HEADER_GYRO		BIT(5)
+#define INV_ICM45600_FIFO_HEADER_HIGH_RES	BIT(4)
+#define INV_ICM45600_FIFO_HEADER_TMST_FSYNC	GENMASK(3, 2)
+#define INV_ICM45600_FIFO_HEADER_ODR_ACCEL	BIT(1)
+#define INV_ICM45600_FIFO_HEADER_ODR_GYRO	BIT(0)
+
+struct inv_icm45600_fifo_1sensor_packet {
+	u8 header;
+	struct inv_icm45600_fifo_sensor_data data;
+	s8 temp;
+} __packed;
+#define INV_ICM45600_FIFO_1SENSOR_PACKET_SIZE		8
+
+struct inv_icm45600_fifo_2sensors_packet {
+	u8 header;
+	struct inv_icm45600_fifo_sensor_data accel;
+	struct inv_icm45600_fifo_sensor_data gyro;
+	s8 temp;
+	__le16 timestamp;
+} __packed;
+#define INV_ICM45600_FIFO_2SENSORS_PACKET_SIZE		16
+
+ssize_t inv_icm45600_fifo_decode_packet(const void *packet,
+					const struct inv_icm45600_fifo_sensor_data **accel,
+					const struct inv_icm45600_fifo_sensor_data **gyro,
+					const s8 **temp,
+					const __le16 **timestamp, unsigned int *odr)
+{
+	const struct inv_icm45600_fifo_1sensor_packet *pack1 = packet;
+	const struct inv_icm45600_fifo_2sensors_packet *pack2 = packet;
+	u8 header = *((const u8 *)packet);
+
+	/* FIFO extended header */
+	if (header & INV_ICM45600_FIFO_EXT_HEADER) {
+		/* Not yet supported */
+		return 0;
+	}
+
+	/* handle odr flags. */
+	*odr = 0;
+	if (header & INV_ICM45600_FIFO_HEADER_ODR_GYRO)
+		*odr |= INV_ICM45600_SENSOR_GYRO;
+	if (header & INV_ICM45600_FIFO_HEADER_ODR_ACCEL)
+		*odr |= INV_ICM45600_SENSOR_ACCEL;
+
+	/* Accel + Gyro data are present. */
+	if ((header & INV_ICM45600_FIFO_HEADER_ACCEL) &&
+	    (header & INV_ICM45600_FIFO_HEADER_GYRO)) {
+		*accel = &pack2->accel;
+		*gyro = &pack2->gyro;
+		*temp = &pack2->temp;
+		*timestamp = &pack2->timestamp;
+		return INV_ICM45600_FIFO_2SENSORS_PACKET_SIZE;
+	}
+
+	/* Accel data only. */
+	if (header & INV_ICM45600_FIFO_HEADER_ACCEL) {
+		*accel = &pack1->data;
+		*gyro = NULL;
+		*temp = &pack1->temp;
+		*timestamp = NULL;
+		return INV_ICM45600_FIFO_1SENSOR_PACKET_SIZE;
+	}
+
+	/* Gyro data only. */
+	if (header & INV_ICM45600_FIFO_HEADER_GYRO) {
+		*accel = NULL;
+		*gyro = &pack1->data;
+		*temp = &pack1->temp;
+		*timestamp = NULL;
+		return INV_ICM45600_FIFO_1SENSOR_PACKET_SIZE;
+	}
+
+	/* Invalid packet if here. */
+	return -EINVAL;
+}
+
+void inv_icm45600_buffer_update_fifo_period(struct inv_icm45600_state *st)
+{
+	u32 period_gyro, period_accel, period;
+
+	if (st->fifo.en & INV_ICM45600_SENSOR_GYRO)
+		period_gyro = inv_icm45600_odr_to_period(st->conf.gyro.odr);
+	else
+		period_gyro = U32_MAX;
+
+	if (st->fifo.en & INV_ICM45600_SENSOR_ACCEL)
+		period_accel = inv_icm45600_odr_to_period(st->conf.accel.odr);
+	else
+		period_accel = U32_MAX;
+
+	if (period_gyro <= period_accel)
+		period = period_gyro;
+	else
+		period = period_accel;
+
+	st->fifo.period = period;
+}
+
+int inv_icm45600_buffer_set_fifo_en(struct inv_icm45600_state *st,
+				    unsigned int fifo_en)
+{
+	unsigned int mask, val;
+	int ret;
+
+	/* Update only FIFO EN bits. */
+	mask = INV_ICM45600_FIFO_CONFIG3_GYRO_EN |
+	       INV_ICM45600_FIFO_CONFIG3_ACCEL_EN;
+
+	val = 0;
+	if ((fifo_en & INV_ICM45600_SENSOR_GYRO) || (fifo_en & INV_ICM45600_SENSOR_ACCEL))
+		val = (INV_ICM45600_FIFO_CONFIG3_GYRO_EN | INV_ICM45600_FIFO_CONFIG3_ACCEL_EN);
+
+	ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3, mask, val);
+	if (ret)
+		return ret;
+
+	st->fifo.en = fifo_en;
+	inv_icm45600_buffer_update_fifo_period(st);
+
+	return 0;
+}
+
+static unsigned int inv_icm45600_wm_truncate(unsigned int watermark, size_t packet_size,
+					     unsigned int fifo_period)
+{
+	size_t watermark_max, grace_samples;
+
+	/* Keep 20ms for processing FIFO. */
+	grace_samples = (20U * 1000000U) / fifo_period;
+	if (grace_samples < 1)
+		grace_samples = 1;
+
+	watermark_max = INV_ICM45600_FIFO_SIZE_MAX / packet_size;
+	watermark_max -= grace_samples;
+
+	if (watermark > watermark_max)
+		watermark = watermark_max;
+
+	return watermark;
+}
+
+/**
+ * inv_icm45600_buffer_update_watermark - update watermark FIFO threshold
+ * @st:	driver internal state
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ *
+ * FIFO watermark threshold is computed based on the required watermark values
+ * set for gyro and accel sensors. Since watermark is all about acceptable data
+ * latency, use the smallest setting between the 2. It means choosing the
+ * smallest latency but this is not as simple as choosing the smallest watermark
+ * value. Latency depends on watermark and ODR. It requires several steps:
+ * 1) compute gyro and accel latencies and choose the smallest value.
+ * 2) adapt the chosen latency so that it is a multiple of both gyro and accel
+ *    ones. Otherwise it is possible that you don't meet a requirement. (for
+ *    example with gyro @100Hz wm 4 and accel @100Hz with wm 6, choosing the
+ *    value of 4 will not meet accel latency requirement because 6 is not a
+ *    multiple of 4. You need to use the value 2.)
+ * 3) Since all periods are multiple of each others, watermark is computed by
+ *    dividing this computed latency by the smallest period, which corresponds
+ *    to the FIFO frequency.
+ */
+int inv_icm45600_buffer_update_watermark(struct inv_icm45600_state *st)
+{
+	const size_t packet_size = INV_ICM45600_FIFO_2SENSORS_PACKET_SIZE;
+	unsigned int wm_gyro, wm_accel, watermark;
+	u32 period_gyro, period_accel, period;
+	u32 latency_gyro, latency_accel, latency;
+
+	/* Compute sensors latency, depending on sensor watermark and odr. */
+	wm_gyro = inv_icm45600_wm_truncate(st->fifo.watermark.gyro, packet_size,
+					   st->fifo.period);
+	wm_accel = inv_icm45600_wm_truncate(st->fifo.watermark.accel, packet_size,
+					    st->fifo.period);
+	/* Use us for odr to avoid overflow using 32 bits values. */
+	period_gyro = inv_icm45600_odr_to_period(st->conf.gyro.odr) / 1000UL;
+	period_accel = inv_icm45600_odr_to_period(st->conf.accel.odr) / 1000UL;
+	latency_gyro = period_gyro * wm_gyro;
+	latency_accel = period_accel * wm_accel;
+
+	/* 0 value for watermark means that the sensor is turned off. */
+	if (wm_gyro == 0 && wm_accel == 0)
+		return 0;
+
+	if (latency_gyro == 0) {
+		watermark = wm_accel;
+		st->fifo.watermark.eff_accel = wm_accel;
+	} else if (latency_accel == 0) {
+		watermark = wm_gyro;
+		st->fifo.watermark.eff_gyro = wm_gyro;
+	} else {
+		/* Compute the smallest latency that is a multiple of both. */
+		if (latency_gyro <= latency_accel)
+			latency = latency_gyro - (latency_accel % latency_gyro);
+		else
+			latency = latency_accel - (latency_gyro % latency_accel);
+		/* Use the shortest period. */
+		if (period_gyro <= period_accel)
+			period = period_gyro;
+		else
+			period = period_accel;
+		/* All this works because periods are multiple of each others. */
+		watermark = latency / period;
+		if (watermark < 1)
+			watermark = 1;
+		/* Update effective watermark. */
+		st->fifo.watermark.eff_gyro = latency / period_gyro;
+		if (st->fifo.watermark.eff_gyro < 1)
+			st->fifo.watermark.eff_gyro = 1;
+		st->fifo.watermark.eff_accel = latency / period_accel;
+		if (st->fifo.watermark.eff_accel < 1)
+			st->fifo.watermark.eff_accel = 1;
+	}
+
+
+	st->buffer.u16 = cpu_to_le16(watermark);
+	return regmap_bulk_write(st->map, INV_ICM45600_REG_FIFO_WATERMARK,
+				&st->buffer.u16, sizeof(st->buffer.u16));
+}
+
+static int inv_icm45600_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm45600_sensor_state *sensor_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &sensor_st->ts;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+	inv_sensors_timestamp_reset(ts);
+
+	return 0;
+}
+
+/*
+ * Update_scan_mode callback is turning sensors on and setting data FIFO enable
+ * bits.
+ */
+static int inv_icm45600_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	unsigned int val;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	/* Exit if FIFO is already on. */
+	if (st->fifo.on) {
+		/* Increase FIFO on counter. */
+		st->fifo.on++;
+		return 0;
+	}
+
+	/* Flush all FIFO data. */
+	ret = regmap_set_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG2,
+			   INV_ICM45600_REG_FIFO_CONFIG2_FIFO_FLUSH);
+	if (ret)
+		return ret;
+
+	/* Set FIFO threshold and full interrupt. */
+	ret = regmap_set_bits(st->map, INV_ICM45600_REG_INT1_CONFIG0,
+			      INV_ICM45600_INT1_CONFIG0_FIFO_THS_EN |
+			      INV_ICM45600_INT1_CONFIG0_FIFO_FULL_EN);
+	if (ret)
+		return ret;
+
+	/* Set FIFO in streaming mode. */
+	val = FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
+			INV_ICM45600_FIFO_CONFIG0_MODE_STREAM);
+	ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
+				 INV_ICM45600_FIFO_CONFIG0_MODE_MASK, val);
+	if (ret)
+		return ret;
+
+	/* Enable writing sensor data to FIFO. */
+	ret = regmap_set_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3,
+			      INV_ICM45600_FIFO_CONFIG3_IF_EN);
+	if (ret)
+		return ret;
+
+	/* Increase FIFO on counter. */
+	st->fifo.on++;
+	return 0;
+}
+
+static int inv_icm45600_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	unsigned int val;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	/* Exit if there are several sensors using the FIFO. */
+	if (st->fifo.on > 1) {
+		/* decrease FIFO on counter */
+		st->fifo.on--;
+		return 0;
+	}
+
+	/* Disable writing sensor data to FIFO. */
+	ret = regmap_clear_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3,
+				INV_ICM45600_FIFO_CONFIG3_IF_EN);
+	if (ret)
+		return ret;
+
+	/* Set FIFO in bypass mode. */
+	val = FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
+			INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS);
+	ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
+				 INV_ICM45600_FIFO_CONFIG0_MODE_MASK, val);
+	if (ret)
+		return ret;
+
+	/* Disable FIFO threshold and full interrupt. */
+	ret = regmap_clear_bits(st->map, INV_ICM45600_REG_INT1_CONFIG0,
+				INV_ICM45600_INT1_CONFIG0_FIFO_THS_EN |
+				INV_ICM45600_INT1_CONFIG0_FIFO_FULL_EN);
+	if (ret)
+		return ret;
+
+	/* Flush all FIFO data. */
+	ret = regmap_set_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG2,
+			   INV_ICM45600_REG_FIFO_CONFIG2_FIFO_FLUSH);
+	if (ret)
+		return ret;
+
+	/* Decrease FIFO on counter. */
+	st->fifo.on--;
+	return 0;
+}
+
+static int _inv_icm45600_buffer_postdisable(struct inv_icm45600_state *st,
+					    unsigned int sensor, unsigned int *watermark,
+					    unsigned int *sleep)
+{
+	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_KEEP_VALUES;
+	int ret;
+
+	ret = inv_icm45600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
+	if (ret)
+		return ret;
+
+	*watermark = 0;
+	ret = inv_icm45600_buffer_update_watermark(st);
+	if (ret)
+		return ret;
+
+	conf.mode = INV_ICM45600_SENSOR_MODE_OFF;
+	if (sensor == INV_ICM45600_SENSOR_GYRO)
+		ret = inv_icm45600_set_gyro_conf(st, &conf, sleep);
+	else
+		ret = inv_icm45600_set_accel_conf(st, &conf, sleep);
+
+	return ret;
+}
+
+static int inv_icm45600_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int sensor;
+	unsigned int *watermark;
+	unsigned int sleep;
+	int ret;
+
+	if (indio_dev == st->indio_gyro) {
+		sensor = INV_ICM45600_SENSOR_GYRO;
+		watermark = &st->fifo.watermark.gyro;
+	} else if (indio_dev == st->indio_accel) {
+		sensor = INV_ICM45600_SENSOR_ACCEL;
+		watermark = &st->fifo.watermark.accel;
+	} else {
+		return -EINVAL;
+	}
+
+	scoped_guard(mutex, &st->lock)
+		ret = _inv_icm45600_buffer_postdisable(st, sensor, watermark, &sleep);
+
+	/* Sleep required time. */
+	if (sleep)
+		msleep(sleep);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+const struct iio_buffer_setup_ops inv_icm45600_buffer_ops = {
+	.preenable = inv_icm45600_buffer_preenable,
+	.postenable = inv_icm45600_buffer_postenable,
+	.predisable = inv_icm45600_buffer_predisable,
+	.postdisable = inv_icm45600_buffer_postdisable,
+};
+
+int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st,
+				  unsigned int max)
+{
+	const ssize_t packet_size = INV_ICM45600_FIFO_2SENSORS_PACKET_SIZE;
+	__le16 *raw_fifo_count;
+	size_t fifo_nb, i;
+	ssize_t size;
+	const struct inv_icm45600_fifo_sensor_data *accel, *gyro;
+	const __le16 *timestamp;
+	const s8 *temp;
+	unsigned int odr;
+	int ret;
+
+	/* Reset all samples counters. */
+	st->fifo.count = 0;
+	st->fifo.nb.gyro = 0;
+	st->fifo.nb.accel = 0;
+	st->fifo.nb.total = 0;
+
+	/* Read FIFO count value. */
+	raw_fifo_count = &st->buffer.u16;
+	ret = regmap_bulk_read(st->map, INV_ICM45600_REG_FIFO_COUNT,
+			       raw_fifo_count, sizeof(*raw_fifo_count));
+	if (ret)
+		return ret;
+	fifo_nb = le16_to_cpup(raw_fifo_count);
+
+	/* Check and limit number of samples if requested. */
+	if (fifo_nb == 0)
+		return 0;
+	if (max > 0 && fifo_nb > max)
+		fifo_nb = max;
+
+	/* Try to read all FIFO data in internal buffer. */
+	st->fifo.count = fifo_nb * packet_size;
+	ret = regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,
+				st->fifo.data, st->fifo.count);
+	if (ret == -ENOTSUPP || ret == -EFBIG) {
+		/* Read full fifo is not supported, read samples one by one. */
+		ret = 0;
+		for (i = 0; i < st->fifo.count && ret == 0; i += packet_size)
+			ret = regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,
+							&st->fifo.data[i], packet_size);
+	}
+	if (ret)
+		return ret;
+
+	for (i = 0; i < st->fifo.count; i += size) {
+		size = inv_icm45600_fifo_decode_packet(&st->fifo.data[i],
+			&accel, &gyro, &temp, &timestamp, &odr);
+		if (size <= 0)
+			break;
+		if (gyro != NULL && inv_icm45600_fifo_is_data_valid(gyro))
+			st->fifo.nb.gyro++;
+		if (accel != NULL && inv_icm45600_fifo_is_data_valid(accel))
+			st->fifo.nb.accel++;
+		st->fifo.nb.total++;
+	}
+
+	return 0;
+}
+
+int inv_icm45600_buffer_init(struct inv_icm45600_state *st)
+{
+	int ret;
+	unsigned int val;
+
+	st->fifo.watermark.eff_gyro = 1;
+	st->fifo.watermark.eff_accel = 1;
+
+	/* Disable all FIFO EN bits. */
+	ret = regmap_write(st->map, INV_ICM45600_REG_FIFO_CONFIG3, 0);
+	if (ret)
+		return ret;
+
+	/* Disable FIFO and set depth. */
+	val = FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
+			INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS);
+	val |= INV_ICM45600_FIFO_CONFIG0_FIFO_DEPTH_MAX;
+	ret = regmap_write(st->map, INV_ICM45600_REG_FIFO_CONFIG0, val);
+	if (ret)
+		return ret;
+
+	/* Enable only timestamp in fifo, disable compression. */
+	ret = regmap_write(st->map, INV_ICM45600_REG_FIFO_CONFIG4,
+			   INV_ICM45600_FIFO_CONFIG4_TMST_FSYNC_EN);
+	if (ret)
+		return ret;
+
+	/* Enable FIFO continuous watermark interrupt. */
+	return regmap_set_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG2,
+			       INV_ICM45600_REG_FIFO_CONFIG2_WM_GT_TH);
+}
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h
new file mode 100644
index 0000000000000000000000000000000000000000..09595a41cf637a3ba9bc44e4df53a9d0aa11f485
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2025 Invensense, Inc. */
+
+#ifndef INV_ICM45600_BUFFER_H_
+#define INV_ICM45600_BUFFER_H_
+
+#include <linux/bits.h>
+#include <linux/iio/iio.h>
+#include <linux/types.h>
+
+struct inv_icm45600_state;
+
+#define INV_ICM45600_SENSOR_GYRO	BIT(0)
+#define INV_ICM45600_SENSOR_ACCEL	BIT(1)
+#define INV_ICM45600_SENSOR_TEMP	BIT(2)
+
+/**
+ * struct inv_icm45600_fifo - FIFO state variables
+ * @on:		reference counter for FIFO on.
+ * @en:		bits field of INV_ICM45600_SENSOR_* for FIFO EN bits.
+ * @period:	FIFO internal period.
+ * @watermark:	watermark configuration values for accel and gyro.
+ * @count:	number of bytes in the FIFO data buffer.
+ * @nb:		gyro, accel and total samples in the FIFO data buffer.
+ * @data:	FIFO data buffer aligned for DMA (8kB)
+ */
+struct inv_icm45600_fifo {
+	unsigned int on;
+	unsigned int en;
+	u32 period;
+	struct {
+		unsigned int gyro;
+		unsigned int accel;
+		unsigned int eff_gyro;
+		unsigned int eff_accel;
+	} watermark;
+	size_t count;
+	struct {
+		size_t gyro;
+		size_t accel;
+		size_t total;
+	} nb;
+	u8 data[8192] __aligned(IIO_DMA_MINALIGN);
+};
+
+/* FIFO data packet */
+struct inv_icm45600_fifo_sensor_data {
+	__le16 x;
+	__le16 y;
+	__le16 z;
+} __packed;
+#define INV_ICM45600_FIFO_DATA_INVALID		-32768
+
+static inline s16 inv_icm45600_fifo_get_sensor_data(__le16 d)
+{
+	return le16_to_cpu(d);
+}
+
+static inline bool
+inv_icm45600_fifo_is_data_valid(const struct inv_icm45600_fifo_sensor_data *s)
+{
+	s16 x, y, z;
+
+	x = inv_icm45600_fifo_get_sensor_data(s->x);
+	y = inv_icm45600_fifo_get_sensor_data(s->y);
+	z = inv_icm45600_fifo_get_sensor_data(s->z);
+
+	if (x == INV_ICM45600_FIFO_DATA_INVALID &&
+	    y == INV_ICM45600_FIFO_DATA_INVALID &&
+	    z == INV_ICM45600_FIFO_DATA_INVALID)
+		return false;
+
+	return true;
+}
+
+ssize_t inv_icm45600_fifo_decode_packet(const void *packet,
+					const struct inv_icm45600_fifo_sensor_data **accel,
+					const struct inv_icm45600_fifo_sensor_data **gyro,
+					const s8 **temp,
+					const __le16 **timestamp, unsigned int *odr);
+
+extern const struct iio_buffer_setup_ops inv_icm45600_buffer_ops;
+
+int inv_icm45600_buffer_init(struct inv_icm45600_state *st);
+
+void inv_icm45600_buffer_update_fifo_period(struct inv_icm45600_state *st);
+
+int inv_icm45600_buffer_set_fifo_en(struct inv_icm45600_state *st,
+				    unsigned int fifo_en);
+
+int inv_icm45600_buffer_update_watermark(struct inv_icm45600_state *st);
+
+int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st,
+				  unsigned int max);
+
+int inv_icm45600_buffer_hwfifo_flush(struct inv_icm45600_state *st,
+				     unsigned int count);
+
+#endif
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
index b961f774e54d0ad109b4ed19eec1cd9b65803c96..0b85630610dcbae7890e69423e1878364ebc3f0d 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/types.h>
 
+#include "inv_icm45600_buffer.h"
 #include "inv_icm45600.h"
 
 static int inv_icm45600_ireg_read(struct regmap *map, unsigned int reg,
@@ -530,6 +531,95 @@ static int inv_icm45600_setup(struct inv_icm45600_state *st,
 	return inv_icm45600_set_conf(st, chip_info->conf);
 }
 
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
+	/* Read the FIFO data. */
+	mask = INV_ICM45600_INT_STATUS_FIFO_THS | INV_ICM45600_INT_STATUS_FIFO_FULL;
+	if (status & mask) {
+		ret = inv_icm45600_buffer_fifo_read(st, 0);
+		if (ret) {
+			dev_err(dev, "FIFO read error %d\n", ret);
+			return IRQ_HANDLED;
+		}
+	}
+
+	/* FIFO full warning. */
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
+	/* Configure INT1 interrupt: default is active low on edge. */
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
 static int inv_icm45600_timestamp_setup(struct inv_icm45600_state *st)
 {
 	/* Enable timestamps. */
@@ -631,6 +721,14 @@ int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chi
 	if (ret)
 		return ret;
 
+	ret = inv_icm45600_buffer_init(st);
+	if (ret)
+		return ret;
+
+	ret = inv_icm45600_irq_init(st, irq, irq_type, open_drain);
+	if (ret)
+		return ret;
+
 	/* Setup runtime power management. */
 	ret = devm_pm_runtime_set_active_enabled(dev);
 	if (ret)
@@ -662,6 +760,22 @@ static int inv_icm45600_suspend(struct device *dev)
 	if (pm_runtime_suspended(dev))
 		return 0;
 
+	/* Disable FIFO data streaming. */
+	if (st->fifo.on) {
+		unsigned int val;
+
+		ret = regmap_clear_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3,
+					INV_ICM45600_FIFO_CONFIG3_IF_EN);
+		if (ret)
+			return ret;
+		val = FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
+			INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS);
+		ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
+					 INV_ICM45600_FIFO_CONFIG0_MODE_MASK, val);
+		if (ret)
+			return ret;
+	}
+
 	ret = inv_icm45600_set_pwr_mgmt0(st, INV_ICM45600_SENSOR_MODE_OFF,
 					 INV_ICM45600_SENSOR_MODE_OFF, NULL);
 	if (ret)
@@ -679,6 +793,8 @@ static int inv_icm45600_suspend(struct device *dev)
 static int inv_icm45600_resume(struct device *dev)
 {
 	struct inv_icm45600_state *st = dev_get_drvdata(dev);
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
+	struct inv_icm45600_sensor_state *accel_st = iio_priv(st->indio_accel);
 	int ret = 0;
 
 	guard(mutex)(&st->lock);
@@ -691,9 +807,28 @@ static int inv_icm45600_resume(struct device *dev)
 		return ret;
 
 	/* Restore sensors state. */
-	return inv_icm45600_set_pwr_mgmt0(st, st->suspended.gyro,
+	ret = inv_icm45600_set_pwr_mgmt0(st, st->suspended.gyro,
 					 st->suspended.accel, NULL);
+	if (ret)
+		return ret;
 
+	/* Restore FIFO data streaming. */
+	if (st->fifo.on) {
+		unsigned int val;
+
+		inv_sensors_timestamp_reset(&gyro_st->ts);
+		inv_sensors_timestamp_reset(&accel_st->ts);
+		val = FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
+			INV_ICM45600_FIFO_CONFIG0_MODE_STREAM);
+		ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
+					 INV_ICM45600_FIFO_CONFIG0_MODE_MASK, val);
+		if (ret)
+			return ret;
+		ret = regmap_set_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3,
+				      INV_ICM45600_FIFO_CONFIG3_IF_EN);
+	}
+
+	return ret;
 }
 
 /* Runtime suspend will turn off sensors that are enabled by iio devices. */

-- 
2.34.1



