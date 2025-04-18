Return-Path: <linux-iio+bounces-18276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A3A93ABA
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12AB1896A8E
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740D1214812;
	Fri, 18 Apr 2025 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jiind6Vw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF1D1FE461;
	Fri, 18 Apr 2025 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993152; cv=none; b=fZaM5JA2E7Gyerqimzlp5lg1akvJ8LTNii6qZKEUQzsK5LfQAF1OUy+XNBvlfbJvtBeJvubTSz/ZtHDsO0BjYzufSGZWtBU/20rr8WJtFWClfA4Wz9uy7jzqdfPAtx+KJ5ThgPwXu88nTZKiYbY+ex+3EbHZESYWFnaLCsLofsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993152; c=relaxed/simple;
	bh=aRMTV0ru9OLAKHjuS1KvidYIWpKuNe3mHnpcD3M9xuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ow3ENOrl14zUQYYvIHAPjc0g13JVr0jCxmOuE+JIulN7d2Po4LWslcIMB3DTiLdSjtlp2mX4fU12fZFxoKcpiGPCfJXLTBhyVEkhTnqkAih/W5GDDFwjSyjAldRxKynajLrLc2Q1LSi9e8dbqrAh3OKKxO+w3TVrcJB8eAZ6Qvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jiind6Vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFB42C4CEEA;
	Fri, 18 Apr 2025 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744993151;
	bh=aRMTV0ru9OLAKHjuS1KvidYIWpKuNe3mHnpcD3M9xuo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Jiind6VwI+gxMPoMa30YNGYdYabRspLFgppA1R4S3t4mriZg+i6JY5t16PXgv0BcC
	 95LGKenuBaFfl4Bn9EUj7rgCUDh6v9WivHSNkuWRZfjzwq3JIgh9GKIi2iA5OJaN2f
	 UWtLLtOqrnimziMJ5OJHvr8hqDjIPuMHtk6Pfj2B4m6oQ0hx5Y21B3k9bKNenw0qw7
	 CdaFtJvC5lFK/krwxg7Ymy9RJ67OBPeBwsmzugE+UXzz+wY9KSvhEpymMBwB59mX1R
	 FsD11+PfhR3JnHwdWIlpHbEHCCAAd+4zTEPgQCdsyGvmKCCyn27oix3WbmEGcjK153
	 HHbBe+LHu2rEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B8AC369CA;
	Fri, 18 Apr 2025 16:19:11 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Fri, 18 Apr 2025 18:19:02 +0200
Subject: [PATCH v3 1/2] iio: imu: inv_icm42600: add WoM support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250418-losd-3-inv-icm42600-add-wom-support-v3-1-7a180af02bfe@tdk.com>
References: <20250418-losd-3-inv-icm42600-add-wom-support-v3-0-7a180af02bfe@tdk.com>
In-Reply-To: <20250418-losd-3-inv-icm42600-add-wom-support-v3-0-7a180af02bfe@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744993145; l=20231;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=uuvbT2GgYbO6yPlvvBuiYs3p4AAcc4/Bqw73GHMY4Z0=;
 b=PoTh+rxB8yY6Zy11ebTPjd3NL5145QE2SLUuetAtDSPn/nvHqqazWMkfQh0Sw+3TWdlsRDpZY
 Czi9+2DU6YNBNspNCyoYZej3llpc7s+6sgibBn0bPPc9HTWFViqfoM6
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Add WoM as accel roc rising x|y|z event.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  54 +++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 279 ++++++++++++++++++++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  58 +++++
 4 files changed, 385 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index f893dbe6996506a33eb5d3be47e6765a923665c9..bcf588a048836f909c26908f0677833303a94ef9 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -135,6 +135,14 @@ struct inv_icm42600_suspended {
 	bool temp;
 };
 
+struct inv_icm42600_apex {
+	unsigned int on;
+	struct {
+		uint64_t value;
+		bool enable;
+	} wom;
+};
+
 /**
  *  struct inv_icm42600_state - driver state variables
  *  @lock:		lock for serializing multiple registers access.
@@ -148,9 +156,10 @@ struct inv_icm42600_suspended {
  *  @suspended:		suspended sensors configuration.
  *  @indio_gyro:	gyroscope IIO device.
  *  @indio_accel:	accelerometer IIO device.
- *  @buffer:		data transfer buffer aligned for DMA.
- *  @fifo:		FIFO management structure.
  *  @timestamp:		interrupt timestamps.
+ *  @apex:		APEX features management.
+ *  @fifo:		FIFO management structure.
+ *  @buffer:		data transfer buffer aligned for DMA.
  */
 struct inv_icm42600_state {
 	struct mutex lock;
@@ -164,12 +173,13 @@ struct inv_icm42600_state {
 	struct inv_icm42600_suspended suspended;
 	struct iio_dev *indio_gyro;
 	struct iio_dev *indio_accel;
-	uint8_t buffer[2] __aligned(IIO_DMA_MINALIGN);
-	struct inv_icm42600_fifo fifo;
 	struct {
 		int64_t gyro;
 		int64_t accel;
 	} timestamp;
+	struct inv_icm42600_apex apex;
+	struct inv_icm42600_fifo fifo;
+	uint8_t buffer[3] __aligned(IIO_DMA_MINALIGN);
 };
 
 
@@ -253,6 +263,18 @@ struct inv_icm42600_sensor_state {
 #define INV_ICM42600_REG_FIFO_COUNT			0x002E
 #define INV_ICM42600_REG_FIFO_DATA			0x0030
 
+#define INV_ICM42600_REG_INT_STATUS2			0x0037
+#define INV_ICM42600_INT_STATUS2_SMD_INT		BIT(3)
+#define INV_ICM42600_INT_STATUS2_WOM_INT		GENMASK(2, 0)
+
+#define INV_ICM42600_REG_INT_STATUS3			0x0038
+#define INV_ICM42600_INT_STATUS3_STEP_DET_INT		BIT(5)
+#define INV_ICM42600_INT_STATUS3_STEP_CNT_OVF_INT	BIT(4)
+#define INV_ICM42600_INT_STATUS3_TILT_DET_INT		BIT(3)
+#define INV_ICM42600_INT_STATUS3_WAKE_INT		BIT(2)
+#define INV_ICM42600_INT_STATUS3_SLEEP_INT		BIT(1)
+#define INV_ICM42600_INT_STATUS3_TAP_DET_INT		BIT(0)
+
 #define INV_ICM42600_REG_SIGNAL_PATH_RESET		0x004B
 #define INV_ICM42600_SIGNAL_PATH_RESET_DMP_INIT_EN	BIT(6)
 #define INV_ICM42600_SIGNAL_PATH_RESET_DMP_MEM_RESET	BIT(5)
@@ -309,6 +331,14 @@ struct inv_icm42600_sensor_state {
 #define INV_ICM42600_TMST_CONFIG_TMST_FSYNC_EN		BIT(1)
 #define INV_ICM42600_TMST_CONFIG_TMST_EN		BIT(0)
 
+#define INV_ICM42600_REG_SMD_CONFIG			0x0057
+#define INV_ICM42600_SMD_CONFIG_WOM_INT_MODE		BIT(3)
+#define INV_ICM42600_SMD_CONFIG_WOM_MODE		BIT(2)
+#define INV_ICM42600_SMD_CONFIG_SMD_MODE_OFF		0x00
+#define INV_ICM42600_SMD_CONFIG_SMD_MODE_WOM		0x01
+#define INV_ICM42600_SMD_CONFIG_SMD_MODE_SHORT		0x02
+#define INV_ICM42600_SMD_CONFIG_SMD_MODE_LONG		0x03
+
 #define INV_ICM42600_REG_FIFO_CONFIG1			0x005F
 #define INV_ICM42600_FIFO_CONFIG1_RESUME_PARTIAL_RD	BIT(6)
 #define INV_ICM42600_FIFO_CONFIG1_WM_GT_TH		BIT(5)
@@ -338,6 +368,11 @@ struct inv_icm42600_sensor_state {
 #define INV_ICM42600_INT_SOURCE0_FIFO_FULL_INT1_EN	BIT(1)
 #define INV_ICM42600_INT_SOURCE0_UI_AGC_RDY_INT1_EN	BIT(0)
 
+#define INV_ICM42600_REG_INT_SOURCE1			0x0066
+#define INV_ICM42600_INT_SOURCE1_I3C_ERROR_INT1_EN	BIT(6)
+#define INV_ICM42600_INT_SOURCE1_SMD_INT1_EN		BIT(3)
+#define INV_ICM42600_INT_SOURCE1_WOM_INT1_EN		GENMASK(2, 0)
+
 #define INV_ICM42600_REG_WHOAMI				0x0075
 #define INV_ICM42600_WHOAMI_ICM42600			0x40
 #define INV_ICM42600_WHOAMI_ICM42602			0x41
@@ -373,6 +408,10 @@ struct inv_icm42600_sensor_state {
 #define INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN		BIT(0)
 
 /* User bank 4 (MSB 0x40) */
+#define INV_ICM42600_REG_ACCEL_WOM_X_THR		0x404A
+#define INV_ICM42600_REG_ACCEL_WOM_Y_THR		0x404B
+#define INV_ICM42600_REG_ACCEL_WOM_Z_THR		0x404C
+
 #define INV_ICM42600_REG_INT_SOURCE8			0x404F
 #define INV_ICM42600_INT_SOURCE8_FSYNC_IBI_EN		BIT(5)
 #define INV_ICM42600_INT_SOURCE8_PLL_RDY_IBI_EN		BIT(4)
@@ -423,6 +462,9 @@ int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,
 int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
 			       unsigned int *sleep_ms);
 
+int inv_icm42600_enable_wom(struct inv_icm42600_state *st);
+int inv_icm42600_disable_wom(struct inv_icm42600_state *st);
+
 int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval);
 
@@ -437,4 +479,8 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st);
 
 int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev);
 
+void inv_icm42600_accel_handle_events(struct iio_dev *indio_dev,
+				      unsigned int status2, unsigned int status3,
+				      int64_t timestamp);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index e6cd9dcb0687d19554e63a69dc60f065c58d70ee..9c21d0855f95ec0c085d29bb67da934ca1a8d339 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -10,9 +10,12 @@
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 
@@ -47,6 +50,16 @@
 		.ext_info = _ext_info,					\
 	}
 
+#define INV_ICM42600_ACCEL_EVENT_CHAN(_modifier, _events, _events_nb)	\
+	{								\
+		.type = IIO_ACCEL,					\
+		.modified = 1,						\
+		.channel2 = _modifier,					\
+		.event_spec = _events,					\
+		.num_event_specs = _events_nb,				\
+		.scan_index = -1,					\
+	}
+
 enum inv_icm42600_accel_scan {
 	INV_ICM42600_ACCEL_SCAN_X,
 	INV_ICM42600_ACCEL_SCAN_Y,
@@ -82,14 +95,15 @@ static int inv_icm42600_accel_power_mode_set(struct iio_dev *indio_dev,
 	if (idx >= ARRAY_SIZE(inv_icm42600_accel_power_mode_values))
 		return -EINVAL;
 
-	if (iio_buffer_enabled(indio_dev))
-		return -EBUSY;
-
 	power_mode = inv_icm42600_accel_power_mode_values[idx];
 	filter = inv_icm42600_accel_filter_values[idx];
 
 	guard(mutex)(&st->lock);
 
+	/* cannot change if accel sensor is on */
+	if (st->conf.accel.mode != INV_ICM42600_SENSOR_MODE_OFF)
+		return -EBUSY;
+
 	/* prevent change if power mode is not supported by the ODR */
 	switch (power_mode) {
 	case INV_ICM42600_SENSOR_MODE_LOW_NOISE:
@@ -160,6 +174,16 @@ static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
 	{ }
 };
 
+/* WoM event: rising ROC */
+static const struct iio_event_spec inv_icm42600_wom_events[] = {
+	{
+		.type = IIO_EV_TYPE_ROC,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
 static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 	INV_ICM42600_ACCEL_CHAN(IIO_MOD_X, INV_ICM42600_ACCEL_SCAN_X,
 				inv_icm42600_accel_ext_infos),
@@ -169,6 +193,8 @@ static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 				inv_icm42600_accel_ext_infos),
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP),
 	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_ACCEL_SCAN_TIMESTAMP),
+	INV_ICM42600_ACCEL_EVENT_CHAN(IIO_MOD_X_OR_Y_OR_Z, inv_icm42600_wom_events,
+				      ARRAY_SIZE(inv_icm42600_wom_events)),
 };
 
 /*
@@ -294,6 +320,153 @@ static int inv_icm42600_accel_read_sensor(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static unsigned int inv_icm42600_accel_convert_roc_to_wom(uint64_t roc,
+							  int accel_hz, int accel_uhz)
+{
+	/* 1000/256mg per LSB converted in µm/s² */
+	const unsigned int convert = (1000U * 9807U) / 256U;
+	uint64_t value;
+	uint64_t freq_uhz;
+
+	/* return 0 only if roc is 0 */
+	if (roc == 0)
+		return 0;
+
+	freq_uhz = (uint64_t)accel_hz * MICRO + (uint64_t)accel_uhz;
+	value = div64_u64(roc * MICRO, freq_uhz * (uint64_t)convert);
+
+	/* limit value to 8 bits and prevent 0 */
+	return clamp(value, 1, 255);
+}
+
+static uint64_t inv_icm42600_accel_convert_wom_to_roc(unsigned int threshold,
+						      int accel_hz, int accel_uhz)
+{
+	/* 1000/256mg per LSB converted in µm/s² */
+	const unsigned int convert = (1000U * 9807U) / 256U;
+	uint64_t value;
+	uint64_t freq_uhz;
+
+	value = threshold * convert;
+	freq_uhz = (uint64_t)accel_hz * MICRO + (uint64_t)accel_uhz;
+
+	/* compute the differential by multiplying by the frequency */
+	return div_u64(value * freq_uhz, MICRO);
+}
+
+static int inv_icm42600_accel_set_wom_threshold(struct inv_icm42600_state *st,
+						uint64_t value,
+						int accel_hz, int accel_uhz)
+{
+	unsigned int threshold;
+	int ret;
+
+	/* convert roc to wom threshold and convert back to handle clipping */
+	threshold = inv_icm42600_accel_convert_roc_to_wom(value, accel_hz, accel_uhz);
+	value = inv_icm42600_accel_convert_wom_to_roc(threshold, accel_hz, accel_uhz);
+
+	dev_dbg(regmap_get_device(st->map), "wom_threshold: 0x%x\n", threshold);
+
+	/* set accel WoM threshold for the 3 axes */
+	st->buffer[0] = threshold;
+	st->buffer[1] = threshold;
+	st->buffer[2] = threshold;
+	ret = regmap_bulk_write(st->map, INV_ICM42600_REG_ACCEL_WOM_X_THR, st->buffer, 3);
+	if (ret)
+		return ret;
+
+	st->apex.wom.value = value;
+
+	return 0;
+}
+
+static int inv_icm42600_accel_enable_wom(struct iio_dev *indio_dev)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
+	struct device *pdev = regmap_get_device(st->map);
+	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
+	unsigned int sleep_ms = 0;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(pdev);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &st->lock) {
+		/* turn on accel sensor */
+		conf.mode = accel_st->power_mode;
+		conf.filter = accel_st->filter;
+		ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_ms);
+		if (ret)
+			goto error_suspend;
+	}
+
+	if (sleep_ms)
+		msleep(sleep_ms);
+
+	scoped_guard(mutex, &st->lock) {
+		ret = inv_icm42600_enable_wom(st);
+		if (ret)
+			goto error_suspend;
+		st->apex.on++;
+		st->apex.wom.enable = true;
+	}
+
+	return 0;
+
+error_suspend:
+	pm_runtime_mark_last_busy(pdev);
+	pm_runtime_put_autosuspend(pdev);
+	return ret;
+}
+
+static int inv_icm42600_accel_disable_wom(struct iio_dev *indio_dev)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *pdev = regmap_get_device(st->map);
+	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
+	unsigned int sleep_ms = 0;
+	int ret;
+
+	scoped_guard(mutex, &st->lock) {
+		st->apex.wom.enable = false;
+		st->apex.on--;
+		ret = inv_icm42600_disable_wom(st);
+		if (ret)
+			break;
+		/* turn off accel sensor if not used */
+		if (!st->apex.on && !iio_buffer_enabled(indio_dev)) {
+			conf.mode = INV_ICM42600_SENSOR_MODE_OFF;
+			ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_ms);
+			if (ret)
+				break;
+		}
+	}
+
+	if (sleep_ms)
+		msleep(sleep_ms);
+	pm_runtime_mark_last_busy(pdev);
+	pm_runtime_put_autosuspend(pdev);
+
+	return ret;
+}
+
+void inv_icm42600_accel_handle_events(struct iio_dev *indio_dev,
+				      unsigned int status2, unsigned int status3,
+				      int64_t timestamp)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	uint64_t ev_code;
+
+	/* handle WoM event */
+	if (st->apex.wom.enable && (status2 & INV_ICM42600_INT_STATUS2_WOM_INT)) {
+		ev_code = IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,
+					     IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING);
+		iio_push_event(indio_dev, ev_code, timestamp);
+	}
+}
+
 /* IIO format int + nano */
 static const int inv_icm42600_accel_scale[] = {
 	/* +/- 16G => 0.004788403 m/s-2 */
@@ -464,6 +637,10 @@ static int inv_icm42600_accel_write_odr(struct iio_dev *indio_dev,
 		goto out_unlock;
 
 	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
+	if (ret)
+		goto out_unlock;
+	/* update wom threshold since roc is dependent on sampling frequency */
+	ret = inv_icm42600_accel_set_wom_threshold(st, st->apex.wom.value, val, val2);
 	if (ret)
 		goto out_unlock;
 	inv_icm42600_buffer_update_fifo_period(st);
@@ -819,6 +996,98 @@ static int inv_icm42600_accel_hwfifo_flush(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int inv_icm42600_accel_read_event_config(struct iio_dev *indio_dev,
+						const struct iio_chan_spec *chan,
+						enum iio_event_type type,
+						enum iio_event_direction dir)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+
+	guard(mutex)(&st->lock);
+
+	/* handle WoM (roc rising) event */
+	if (type == IIO_EV_TYPE_ROC && dir == IIO_EV_DIR_RISING)
+		return st->apex.wom.enable ? 1 : 0;
+
+	return -EINVAL;
+}
+
+static int inv_icm42600_accel_write_event_config(struct iio_dev *indio_dev,
+						 const struct iio_chan_spec *chan,
+						 enum iio_event_type type,
+						 enum iio_event_direction dir,
+						 bool state)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+
+	/* handle only WoM (roc rising) event */
+	if (type != IIO_EV_TYPE_ROC || dir != IIO_EV_DIR_RISING)
+		return -EINVAL;
+
+	scoped_guard(mutex, &st->lock) {
+		if (st->apex.wom.enable == state)
+			return 0;
+	}
+
+	if (state)
+		return inv_icm42600_accel_enable_wom(indio_dev);
+	else
+		return inv_icm42600_accel_disable_wom(indio_dev);
+}
+
+static int inv_icm42600_accel_read_event_value(struct iio_dev *indio_dev,
+					       const struct iio_chan_spec *chan,
+					       enum iio_event_type type,
+					       enum iio_event_direction dir,
+					       enum iio_event_info info,
+					       int *val, int *val2)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	u32 rem;
+
+	guard(mutex)(&st->lock);
+
+	/* handle only WoM (roc rising) event value */
+	if (type != IIO_EV_TYPE_ROC || dir != IIO_EV_DIR_RISING)
+		return -EINVAL;
+
+	/* return value in micro */
+	*val = div_u64_rem(st->apex.wom.value, MICRO, &rem);
+	*val2 = rem;
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_icm42600_accel_write_event_value(struct iio_dev *indio_dev,
+						const struct iio_chan_spec *chan,
+						enum iio_event_type type,
+						enum iio_event_direction dir,
+						enum iio_event_info info,
+						int val, int val2)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	uint64_t value;
+	unsigned int accel_hz, accel_uhz;
+	int ret;
+
+	/* handle only WoM (roc rising) event value */
+	if (type != IIO_EV_TYPE_ROC || dir != IIO_EV_DIR_RISING || val < 0 || val2 < 0)
+		return -EINVAL;
+
+	value = (uint64_t)val * MICRO + (uint64_t)val2;
+	pm_runtime_get_sync(dev);
+	scoped_guard(mutex, &st->lock) {
+		ret = inv_icm42600_accel_read_odr(st, &accel_hz, &accel_uhz);
+		if (ret >= 0)
+			ret = inv_icm42600_accel_set_wom_threshold(st, value,
+								   accel_hz, accel_uhz);
+	}
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
 static const struct iio_info inv_icm42600_accel_info = {
 	.read_raw = inv_icm42600_accel_read_raw,
 	.read_avail = inv_icm42600_accel_read_avail,
@@ -828,6 +1097,10 @@ static const struct iio_info inv_icm42600_accel_info = {
 	.update_scan_mode = inv_icm42600_accel_update_scan_mode,
 	.hwfifo_set_watermark = inv_icm42600_accel_hwfifo_set_watermark,
 	.hwfifo_flush_to_buffer = inv_icm42600_accel_hwfifo_flush,
+	.read_event_config = inv_icm42600_accel_read_event_config,
+	.write_event_config = inv_icm42600_accel_write_event_config,
+	.read_event_value = inv_icm42600_accel_read_event_value,
+	.write_event_value = inv_icm42600_accel_write_event_value,
 };
 
 struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index aae7c56481a3fa4351e921fb98ce61d31d1d7d6a..094d739d7d862f6916ff31f09af227c80a3bdce5 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -422,7 +422,7 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	conf.mode = INV_ICM42600_SENSOR_MODE_OFF;
 	if (sensor == INV_ICM42600_SENSOR_GYRO)
 		ret = inv_icm42600_set_gyro_conf(st, &conf, &sleep_sensor);
-	else
+	else if (!st->apex.on)
 		ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_sensor);
 	if (ret)
 		goto out_unlock;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 63d46619ebfaa1372171129fca96381ef4606b2e..9a2150ab9e874f17d7fda731cb131c3f688a75a3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -404,6 +404,37 @@ int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
 					  sleep_ms);
 }
 
+int inv_icm42600_enable_wom(struct inv_icm42600_state *st)
+{
+	int ret;
+
+	/* enable WoM hardware */
+	ret = regmap_write(st->map, INV_ICM42600_REG_SMD_CONFIG,
+			   INV_ICM42600_SMD_CONFIG_SMD_MODE_WOM |
+			   INV_ICM42600_SMD_CONFIG_WOM_MODE);
+	if (ret)
+		return ret;
+
+	/* enable WoM interrupt */
+	return regmap_set_bits(st->map, INV_ICM42600_REG_INT_SOURCE1,
+			      INV_ICM42600_INT_SOURCE1_WOM_INT1_EN);
+}
+
+int inv_icm42600_disable_wom(struct inv_icm42600_state *st)
+{
+	int ret;
+
+	/* disable WoM interrupt */
+	ret = regmap_clear_bits(st->map, INV_ICM42600_REG_INT_SOURCE1,
+				INV_ICM42600_INT_SOURCE1_WOM_INT1_EN);
+	if (ret)
+		return ret;
+
+	/* disable WoM hardware */
+	return regmap_write(st->map, INV_ICM42600_REG_SMD_CONFIG,
+			    INV_ICM42600_SMD_CONFIG_SMD_MODE_OFF);
+}
+
 int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval)
 {
@@ -548,6 +579,19 @@ static irqreturn_t inv_icm42600_irq_handler(int irq, void *_data)
 
 	mutex_lock(&st->lock);
 
+	if (st->apex.on) {
+		unsigned int status2, status3;
+
+		/* read INT_STATUS2 and INT_STATUS3 in 1 operation */
+		ret = regmap_bulk_read(st->map, INV_ICM42600_REG_INT_STATUS2, st->buffer, 2);
+		if (ret)
+			goto out_unlock;
+		status2 = st->buffer[0];
+		status3 = st->buffer[1];
+		inv_icm42600_accel_handle_events(st->indio_accel, status2, status3,
+						 st->timestamp.accel);
+	}
+
 	ret = regmap_read(st->map, INV_ICM42600_REG_INT_STATUS, &status);
 	if (ret)
 		goto out_unlock;
@@ -819,6 +863,13 @@ static int inv_icm42600_suspend(struct device *dev)
 			goto out_unlock;
 	}
 
+	/* disable APEX features */
+	if (st->apex.wom.enable) {
+		ret = inv_icm42600_disable_wom(st);
+		if (ret)
+			goto out_unlock;
+	}
+
 	ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
 					 INV_ICM42600_SENSOR_MODE_OFF, false,
 					 NULL);
@@ -860,6 +911,13 @@ static int inv_icm42600_resume(struct device *dev)
 	if (ret)
 		goto out_unlock;
 
+	/* restore APEX features */
+	if (st->apex.wom.enable) {
+		ret = inv_icm42600_enable_wom(st);
+		if (ret)
+			goto out_unlock;
+	}
+
 	/* restore FIFO data streaming */
 	if (st->fifo.on) {
 		inv_sensors_timestamp_reset(&gyro_st->ts);

-- 
2.49.0



