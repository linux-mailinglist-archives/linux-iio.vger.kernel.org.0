Return-Path: <linux-iio+bounces-17949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0688A85EF4
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182F91895262
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A31DB13A;
	Fri, 11 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3u4g3pt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8713D1C6FF4;
	Fri, 11 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378122; cv=none; b=r4gbhe61MAXUdE0g1n/zB3pb9lt28R+b4sOfpH2redeanjnvlAU/ELGDYTQ8YNjYeHwT5SKdQ+8V4H1QqFxV7WGKFbLeHhNTxggOLSSuHhDq0lsBu0aDMDJ2wUWeLbWVQ2tl/okIQN0yM5SMv1v+IAUGpjZ35sYgbOEdLBBESPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378122; c=relaxed/simple;
	bh=0nY/AtFpoH954yRrlAuta5Tv6bDZX8S17v1gqTdTo8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vmg43WdOPPaaa0/gqgHsUVicztYL4iK8TtSXQFrhmWM4l99ur0BxKhYZySU34Fl2YqUpDdGsSgtO7ggZv854fIIqIcKmhlUNnhKkTKvv22kijscWDwRpzSlMa2Gz4pD1DRYPW6p8oO9rZDWEOOOBIkUQC8uMJqF656oENXdgfx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3u4g3pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA9DBC4CEF4;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744378121;
	bh=0nY/AtFpoH954yRrlAuta5Tv6bDZX8S17v1gqTdTo8g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=o3u4g3ptHX+0CgGY3p6yrXTUXYSnKKdCXEClQ3qS3L6xn24TSg6z83crJwsfGsam+
	 MumWhsca8qNEXZsExpAtm8f3T+85hyJFK4pFlVtZY0i9HHm02t4jRWq2Ju71+ftCPR
	 60L6Y5QaddfPyyN8VeveNhpVRRPSwUPrb5oIDkjNPA9gG7/BXEEZWTMYc4TldGut4q
	 NZ38AR+yzghzoRINuX29wmnq5qpg9AH4BVo4CHPlqn2Zn/5Pniasr4OdYkO+w3cttK
	 8mHsrwZ7dEIcUPN0/BFiEzkI/H0XHyXMMn7BlsuzzvRUSRTmq+GuCeakRyOyCmQVmJ
	 7nZXP1yGuTNQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D81C369AE;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Fri, 11 Apr 2025 13:28:37 +0000
Subject: [PATCH 5/8] iio: imu: inv_icm45600: add buffer support in iio
 devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-add_newport_driver-v1-5-15082160b019@tdk.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744378119; l=21460;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=shWLFNOSbbL6CH4BKWqSsJcmmzEV7CGMLBJhh0eB/Dg=;
 b=jJjMV3KRKxjUYcvJlYudevJebWaPY/1G2u/GFKmRkKnSNBfPVm4Qts2WYSCjVi5fHZ+yS5UTz
 eSxnvLMpwI+CIwnaj/EMwqRb4m+MfHv1YsdjPuaME8kgXEWQc2P2uHe
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Add all FIFO parsing and reading functions. Add accel and gyro
kfifo buffer and FIFO data parsing. Use device interrupt for
reading data FIFO and launching accel and gyro parsing.

Support hwfifo watermark by multiplexing gyro and accel settings.
Support hwfifo flush.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 572 +++++++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h | 100 ++++
 2 files changed, 672 insertions(+)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
new file mode 100644
index 0000000000000000000000000000000000000000..ed6f46eb4865fa3299b0240cc5f520e0326a7648
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
@@ -0,0 +1,572 @@
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
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
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
+	uint8_t header;
+	struct inv_icm45600_fifo_sensor_data data;
+	int8_t temp;
+} __packed;
+#define INV_ICM45600_FIFO_1SENSOR_PACKET_SIZE		8
+
+struct inv_icm45600_fifo_2sensors_packet {
+	uint8_t header;
+	struct inv_icm45600_fifo_sensor_data accel;
+	struct inv_icm45600_fifo_sensor_data gyro;
+	int8_t temp;
+	__le16 timestamp;
+} __packed;
+#define INV_ICM45600_FIFO_2SENSORS_PACKET_SIZE		16
+
+ssize_t inv_icm45600_fifo_decode_packet(const void *packet, const void **accel,
+					const void **gyro, const int8_t **temp,
+					const void **timestamp, unsigned int *odr)
+{
+	const struct inv_icm45600_fifo_1sensor_packet *pack1 = packet;
+	const struct inv_icm45600_fifo_2sensors_packet *pack2 = packet;
+	uint8_t header = *((const uint8_t *)packet);
+
+	/* FIFO extended header */
+	if (header & INV_ICM45600_FIFO_EXT_HEADER) {
+		/* Not yet supported */
+		return 0;
+	}
+
+	/* handle odr flags */
+	*odr = 0;
+	if (header & INV_ICM45600_FIFO_HEADER_ODR_GYRO)
+		*odr |= INV_ICM45600_SENSOR_GYRO;
+	if (header & INV_ICM45600_FIFO_HEADER_ODR_ACCEL)
+		*odr |= INV_ICM45600_SENSOR_ACCEL;
+
+	/* accel + gyro */
+	if ((header & INV_ICM45600_FIFO_HEADER_ACCEL) &&
+	    (header & INV_ICM45600_FIFO_HEADER_GYRO)) {
+		*accel = &pack2->accel;
+		*gyro = &pack2->gyro;
+		*temp = &pack2->temp;
+		*timestamp = &pack2->timestamp;
+		return INV_ICM45600_FIFO_2SENSORS_PACKET_SIZE;
+	}
+
+	/* accel only */
+	if (header & INV_ICM45600_FIFO_HEADER_ACCEL) {
+		*accel = &pack1->data;
+		*gyro = NULL;
+		*temp = &pack1->temp;
+		*timestamp = NULL;
+		return INV_ICM45600_FIFO_1SENSOR_PACKET_SIZE;
+	}
+
+	/* gyro only */
+	if (header & INV_ICM45600_FIFO_HEADER_GYRO) {
+		*accel = NULL;
+		*gyro = &pack1->data;
+		*temp = &pack1->temp;
+		*timestamp = NULL;
+		return INV_ICM45600_FIFO_1SENSOR_PACKET_SIZE;
+	}
+
+	/* invalid packet if here */
+	return -EINVAL;
+}
+
+void inv_icm45600_buffer_update_fifo_period(struct inv_icm45600_state *st)
+{
+	uint32_t period_gyro, period_accel, period;
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
+	/* update only FIFO EN bits */
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
+	/* keep 20ms for processing FIFO */
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
+	uint32_t period_gyro, period_accel, period;
+	uint32_t latency_gyro, latency_accel, latency;
+	__le16 raw_wm;
+	int ret;
+
+	/* compute sensors latency, depending on sensor watermark and odr */
+	wm_gyro = inv_icm45600_wm_truncate(st->fifo.watermark.gyro, packet_size,
+					   st->fifo.period);
+	wm_accel = inv_icm45600_wm_truncate(st->fifo.watermark.accel, packet_size,
+					    st->fifo.period);
+	/* use us for odr to avoid overflow using 32 bits values */
+	period_gyro = inv_icm45600_odr_to_period(st->conf.gyro.odr) / 1000UL;
+	period_accel = inv_icm45600_odr_to_period(st->conf.accel.odr) / 1000UL;
+	latency_gyro = period_gyro * wm_gyro;
+	latency_accel = period_accel * wm_accel;
+
+	/* 0 value for watermark means that the sensor is turned off */
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
+		/* compute the smallest latency that is a multiple of both */
+		if (latency_gyro <= latency_accel)
+			latency = latency_gyro - (latency_accel % latency_gyro);
+		else
+			latency = latency_accel - (latency_gyro % latency_accel);
+		/* use the shortest period */
+		if (period_gyro <= period_accel)
+			period = period_gyro;
+		else
+			period = period_accel;
+		/* all this works because periods are multiple of each others */
+		watermark = latency / period;
+		if (watermark < 1)
+			watermark = 1;
+		/* update effective watermark */
+		st->fifo.watermark.eff_gyro = latency / period_gyro;
+		if (st->fifo.watermark.eff_gyro < 1)
+			st->fifo.watermark.eff_gyro = 1;
+		st->fifo.watermark.eff_accel = latency / period_accel;
+		if (st->fifo.watermark.eff_accel < 1)
+			st->fifo.watermark.eff_accel = 1;
+	}
+
+	raw_wm = INV_ICM45600_FIFO_WATERMARK_VAL(watermark);
+	memcpy(st->buffer, &raw_wm, sizeof(raw_wm));
+	ret = regmap_bulk_write(st->map, INV_ICM45600_REG_FIFO_WATERMARK,
+				st->buffer, sizeof(raw_wm));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int inv_icm45600_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm45600_sensor_state *sensor_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &sensor_st->ts;
+
+	pm_runtime_get_sync(dev);
+
+	guard(mutex)(&st->lock);
+	inv_sensors_timestamp_reset(ts);
+
+	return 0;
+}
+
+/*
+ * update_scan_mode callback is turning sensors on and setting data FIFO enable
+ * bits.
+ */
+static int inv_icm45600_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	/* exit if FIFO is already on */
+	if (st->fifo.on) {
+		ret = 0;
+		goto out_on;
+	}
+
+	/* flush FIFO data */
+	ret = regmap_set_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG2,
+			   INV_ICM45600_REG_FIFO_CONFIG2_FIFO_FLUSH);
+	if (ret)
+		return ret;
+
+	/* set FIFO threshold and full interrupt */
+	ret = regmap_set_bits(st->map, INV_ICM45600_REG_INT1_CONFIG0,
+			      INV_ICM45600_INT1_CONFIG0_FIFO_THS_EN |
+			      INV_ICM45600_INT1_CONFIG0_FIFO_FULL_EN);
+	if (ret)
+		return ret;
+
+	/* set FIFO in streaming mode */
+	ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
+				 INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
+				 INV_ICM45600_FIFO_CONFIG0_MODE_STREAM);
+	if (ret)
+		return ret;
+
+	/* enable writing sensor data to FIFO */
+	ret = regmap_set_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3,
+			      INV_ICM45600_FIFO_CONFIG3_IF_EN);
+	if (ret)
+		return ret;
+
+out_on:
+	/* increase FIFO on counter */
+	st->fifo.on++;
+	return ret;
+}
+
+static int inv_icm45600_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	/* exit if there are several sensors using the FIFO */
+	if (st->fifo.on > 1) {
+		ret = 0;
+		goto out_off;
+	}
+
+	/* disable writing sensor data to FIFO */
+	ret = regmap_clear_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3,
+				INV_ICM45600_FIFO_CONFIG3_IF_EN);
+	if (ret)
+		return ret;
+
+	/* set FIFO in bypass mode */
+	ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
+				 INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
+				 INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS);
+	if (ret)
+		return ret;
+
+	/* disable FIFO threshold and full interrupt */
+	ret = regmap_clear_bits(st->map, INV_ICM45600_REG_INT1_CONFIG0,
+				INV_ICM45600_INT1_CONFIG0_FIFO_THS_EN |
+				INV_ICM45600_INT1_CONFIG0_FIFO_FULL_EN);
+	if (ret)
+		return ret;
+
+	/* flush FIFO data */
+	ret = regmap_set_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG2,
+			   INV_ICM45600_REG_FIFO_CONFIG2_FIFO_FLUSH);
+	if (ret)
+		return ret;
+
+out_off:
+	/* decrease FIFO on counter */
+	st->fifo.on--;
+	return ret;
+}
+
+static int inv_icm45600_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct inv_icm45600_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int sensor;
+	unsigned int *watermark;
+	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_INIT;
+	unsigned int sleep_temp = 0;
+	unsigned int sleep_sensor = 0;
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
+	scoped_guard(mutex, &st->lock) {
+		ret = inv_icm45600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
+		if (ret)
+			break;
+
+		*watermark = 0;
+		ret = inv_icm45600_buffer_update_watermark(st);
+		if (ret)
+			break;
+
+		conf.mode = INV_ICM45600_SENSOR_MODE_OFF;
+		if (sensor == INV_ICM45600_SENSOR_GYRO)
+			ret = inv_icm45600_set_gyro_conf(st, &conf, &sleep_sensor);
+		else
+			ret = inv_icm45600_set_accel_conf(st, &conf, &sleep_sensor);
+	}
+	/* sleep maximum required time */
+	sleep = max(sleep_sensor, sleep_temp);
+	if (sleep)
+		msleep(sleep);
+
+	pm_runtime_mark_last_busy(dev);
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
+	const void *accel, *gyro, *timestamp;
+	const int8_t *temp;
+	unsigned int odr;
+	int ret;
+
+	/* reset all samples counters */
+	st->fifo.count = 0;
+	st->fifo.nb.gyro = 0;
+	st->fifo.nb.accel = 0;
+	st->fifo.nb.total = 0;
+
+	/* read FIFO count value */
+	raw_fifo_count = (__le16 *)st->buffer;
+	ret = regmap_bulk_read(st->map, INV_ICM45600_REG_FIFO_COUNT,
+			       raw_fifo_count, sizeof(*raw_fifo_count));
+	if (ret)
+		return ret;
+	fifo_nb = le16_to_cpup(raw_fifo_count);
+
+	/* check and limit number of samples if requested */
+	if (fifo_nb == 0)
+		return 0;
+	if (max > 0 && fifo_nb > max)
+		fifo_nb = max;
+
+	/* Try to read all FIFO data in internal buffer */
+	st->fifo.count = fifo_nb * packet_size;
+	ret = regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,
+				st->fifo.data, st->fifo.count);
+	if (ret == -ENOTSUPP || ret == -EFBIG) {
+		/* Read full fifo is not supported, read samples one by one */
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
+int inv_icm45600_buffer_fifo_parse(struct inv_icm45600_state *st)
+{
+	struct inv_icm45600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
+	struct inv_icm45600_sensor_state *accel_st = iio_priv(st->indio_accel);
+	struct inv_sensors_timestamp *ts;
+	int ret;
+
+	if (st->fifo.nb.total == 0)
+		return 0;
+
+	/* handle gyroscope timestamp and FIFO data parsing */
+	if (st->fifo.nb.gyro > 0) {
+		ts = &gyro_st->ts;
+		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_gyro,
+						st->timestamp.gyro);
+		ret = inv_icm45600_gyro_parse_fifo(st->indio_gyro);
+		if (ret)
+			return ret;
+	}
+
+	/* handle accelerometer timestamp and FIFO data parsing */
+	if (st->fifo.nb.accel > 0) {
+		ts = &accel_st->ts;
+		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_accel,
+						st->timestamp.accel);
+		ret = inv_icm45600_accel_parse_fifo(st->indio_accel);
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
+	struct inv_icm45600_sensor_state *accel_st = iio_priv(st->indio_accel);
+	struct inv_sensors_timestamp *ts;
+	int64_t gyro_ts, accel_ts;
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
+	if (st->fifo.nb.accel > 0) {
+		ts = &accel_st->ts;
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
+		ret = inv_icm45600_accel_parse_fifo(st->indio_accel);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int inv_icm45600_buffer_init(struct inv_icm45600_state *st)
+{
+	int ret;
+
+	st->fifo.watermark.eff_gyro = 1;
+	st->fifo.watermark.eff_accel = 1;
+
+	/* Disable all FIFO EN bits. */
+	ret = regmap_write(st->map, INV_ICM45600_REG_FIFO_CONFIG3, 0);
+	if (ret)
+		return ret;
+
+	/* Disable FIFO and set depth */
+	ret = regmap_write(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
+			   INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS |
+			   INV_ICM45600_FIFO_CONFIG0_FIFO_DEPTH_MAX);
+	if (ret)
+		return ret;
+
+	/* enable only timestamp in fifo, disable compression */
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
index 0000000000000000000000000000000000000000..f725f841e07bc1e738ca7df07accd50484c8ceda
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025 Invensense, Inc.
+ */
+
+#ifndef INV_ICM45600_BUFFER_H_
+#define INV_ICM45600_BUFFER_H_
+
+#include <linux/bits.h>
+#include <linux/kernel.h>
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
+	uint32_t period;
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
+	uint8_t data[8192] __aligned(IIO_DMA_MINALIGN);
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
+static inline int16_t inv_icm45600_fifo_get_sensor_data(__le16 d)
+{
+	return le16_to_cpu(d);
+}
+
+static inline bool
+inv_icm45600_fifo_is_data_valid(const struct inv_icm45600_fifo_sensor_data *s)
+{
+	int16_t x, y, z;
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
+ssize_t inv_icm45600_fifo_decode_packet(const void *packet, const void **accel,
+					const void **gyro, const int8_t **temp,
+					const void **timestamp, unsigned int *odr);
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
+int inv_icm45600_buffer_fifo_parse(struct inv_icm45600_state *st);
+
+int inv_icm45600_buffer_hwfifo_flush(struct inv_icm45600_state *st,
+				     unsigned int count);
+
+#endif

-- 
2.34.1



