Return-Path: <linux-iio+bounces-15894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33045A3E61C
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 21:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B2F7A298C
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198C2641C1;
	Thu, 20 Feb 2025 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRiL4aB2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ABD1E4AB;
	Thu, 20 Feb 2025 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084733; cv=none; b=jL663TpTJM33dNJ1ab3cGSUFw53bxUYzD5llFdJoGu3afQvRUMZHuRBP08fpyRtnmb6CrrrIoPq+mGVFXt82JGVOlpR1P3zEuOEBNLTh7PQg+uc/4xs5EN+dAcWI8RRq9Op74EZnQBH4BkGA7/qKiU6gGvmSeleoZdSzy+ckV1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084733; c=relaxed/simple;
	bh=D2GnpH4zWMbC1eHgKSETuRTbODKtesUWcfufwNal5Ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rei8ZAsgwlveIdQLhlsVjoErLqYYBO01lLvyKTfHbQkKkbTW7hBgPIdhj0B73ZAK51KQAkYpl9Ll0gKywVv3MkPDbHj1opeWgmHgTVA6jijZ6t5BgIyiQ2b1U04RCqkplVvnblHPPWKVEGPDlN3AaTG/49KvQ0wJCw2I+1gsjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRiL4aB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36CFCC4CED6;
	Thu, 20 Feb 2025 20:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740084733;
	bh=D2GnpH4zWMbC1eHgKSETuRTbODKtesUWcfufwNal5Ww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kRiL4aB2vWG9O4GDIUHpEW0Issr3cMRaRctC2iEMkqvywoHh9V1EcsESgrajJfqEm
	 r2/V1Cf9Qf3brH0wrmEVOi4nm/P+CzFRGF+qOHuqOAN4HRVyiOvWF7RymvpkllK5WA
	 7eTLvUjuvpg+6LkGDIGx/ZKK7DfZt7FpIzvAaLEg9IuMQuM/C5GGJWff0yb9Y02sOx
	 8TwcGtwbKLX943zEhiL5EASfwNZ2B2nUM/aoq+bvu0EKgJwesnhM3GczE+YnL2Ou6o
	 xTMgPX2UB/P398sJH8PrPocd4PCmd3fY05OPCDvqPNVN/2v5JvnleQ9VCww1cAuUN7
	 CnmxgyW3bjGhQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC21C021B3;
	Thu, 20 Feb 2025 20:52:13 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 20 Feb 2025 21:52:06 +0100
Subject: [PATCH 1/2] iio: imu: inv_icm42600: add WoM support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250220-losd-3-inv-icm42600-add-wom-support-v1-1-9b937f986954@tdk.com>
References: <20250220-losd-3-inv-icm42600-add-wom-support-v1-0-9b937f986954@tdk.com>
In-Reply-To: <20250220-losd-3-inv-icm42600-add-wom-support-v1-0-9b937f986954@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740084731; l=19726;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=DWXn5I4JY6Fdbcu1I7AHakDUIjQ007DvGfuKs/m6i1M=;
 b=IMVDMSejMfemv5qXw/1w0L8GMn4JqhoLjgf6pp9kb+p+Tg+aM8QDS71FMogePgOq3f3Vm+8JF
 RqJWvZwfOp7BDzZ0OhXxkBYLwRRYsZSx0EiuPriAUBUkWZvOHStd4n9
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
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  47 +++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 264 ++++++++++++++++++++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  56 ++++-
 4 files changed, 363 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 18787a43477b89db12caee597ab040af5c8f52d5..8dfbeaf1c768d7d25cb58ecf9804446f3cbbd465 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -135,6 +135,14 @@ struct inv_icm42600_suspended {
 	bool temp;
 };
 
+struct inv_icm42600_apex {
+	unsigned int on;
+	struct {
+		bool enable;
+		uint64_t value;
+	} wom;
+};
+
 /**
  *  struct inv_icm42600_state - driver state variables
  *  @lock:		lock for serializing multiple registers access.
@@ -151,6 +159,7 @@ struct inv_icm42600_suspended {
  *  @buffer:		data transfer buffer aligned for DMA.
  *  @fifo:		FIFO management structure.
  *  @timestamp:		interrupt timestamps.
+ *  @apex:		APEX features management.
  */
 struct inv_icm42600_state {
 	struct mutex lock;
@@ -164,12 +173,13 @@ struct inv_icm42600_state {
 	struct inv_icm42600_suspended suspended;
 	struct iio_dev *indio_gyro;
 	struct iio_dev *indio_accel;
-	uint8_t buffer[2] __aligned(IIO_DMA_MINALIGN);
+	uint8_t buffer[3] __aligned(IIO_DMA_MINALIGN);
 	struct inv_icm42600_fifo fifo;
 	struct {
 		int64_t gyro;
 		int64_t accel;
 	} timestamp;
+	struct inv_icm42600_apex apex;
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
@@ -423,6 +462,8 @@ int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,
 int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
 			       unsigned int *sleep_ms);
 
+int inv_icm42600_set_wom(struct inv_icm42600_state *st, bool enable);
+
 int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval);
 
@@ -437,4 +478,8 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st);
 
 int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev);
 
+void inv_icm42600_accel_handle_events(struct iio_dev *indio_dev,
+				      unsigned int status2, unsigned int status3,
+				      int64_t timestamp);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 388520ec60b5c5d21b16717978ebf330e38aa1fe..8ce2276b3edc61cc1ea26810198dd0057054ec48 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -13,6 +13,7 @@
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/common/inv_sensors_timestamp.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 
@@ -47,6 +48,16 @@
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
@@ -82,14 +93,15 @@ static int inv_icm42600_accel_power_mode_set(struct iio_dev *indio_dev,
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
@@ -160,6 +172,16 @@ static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
 	{},
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
@@ -169,6 +191,8 @@ static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 				inv_icm42600_accel_ext_infos),
 	INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP),
 	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_ACCEL_SCAN_TIMESTAMP),
+	INV_ICM42600_ACCEL_EVENT_CHAN(IIO_MOD_X_OR_Y_OR_Z, inv_icm42600_wom_events,
+				      ARRAY_SIZE(inv_icm42600_wom_events)),
 };
 
 /*
@@ -294,6 +318,140 @@ static int inv_icm42600_accel_read_sensor(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static unsigned int inv_icm42600_accel_convert_roc_to_wom(uint64_t roc,
+							  int accel_hz, int accel_uhz)
+{
+	/* 1000/256mg per LSB converted in m/s² in micro (1000000) */
+	const unsigned int convert = (1000U * 9807U) / 256U;
+	uint64_t value;
+	uint64_t freq_uhz;
+
+	/* return 0 only if roc is 0 */
+	if (roc == 0)
+		return 0;
+
+	freq_uhz = (uint64_t)accel_hz * 1000000U + (uint64_t)accel_uhz;
+	value = div64_u64(roc * 1000000U, freq_uhz * (uint64_t)convert);
+
+	/* limit value to 8 bits and prevent 0 */
+	return min(255, max(1, value));
+}
+
+static uint64_t inv_icm42600_accel_convert_wom_to_roc(unsigned int threshold,
+						      int accel_hz, int accel_uhz)
+{
+	/* 1000/256mg per LSB converted in m/s² in micro (1000000) */
+	const unsigned int convert = (1000U * 9807U) / 256U;
+	uint64_t value;
+	uint64_t freq_uhz;
+
+	value = threshold * convert;
+	freq_uhz = (uint64_t)accel_hz * 1000000U + (uint64_t)accel_uhz;
+
+	/* compute the differential by multiplying by the frequency */
+	return div_u64(value * freq_uhz, 1000000U);
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
+static int inv_icm42600_accel_enable_wom(struct iio_dev *indio_dev, bool enable)
+{
+	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
+	struct device *pdev = regmap_get_device(st->map);
+	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
+	unsigned int sleep_ms = 0;
+	int ret;
+
+	if (enable) {
+		ret = pm_runtime_resume_and_get(pdev);
+		if (ret)
+			return ret;
+		scoped_guard(mutex, &st->lock) {
+			/* turn on accel sensor */
+			conf.mode = accel_st->power_mode;
+			conf.filter = accel_st->filter;
+			ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_ms);
+			if (ret)
+				goto error_suspend;
+		}
+		if (sleep_ms)
+			msleep(sleep_ms);
+		scoped_guard(mutex, &st->lock) {
+			ret = inv_icm42600_set_wom(st, true);
+			if (ret)
+				goto error_suspend;
+			st->apex.on++;
+			st->apex.wom.enable = true;
+		}
+	} else {
+		scoped_guard(mutex, &st->lock) {
+			st->apex.wom.enable = false;
+			st->apex.on--;
+			ret = inv_icm42600_set_wom(st, false);
+			if (ret)
+				goto error_suspend;
+			/* turn off accel sensor if not used */
+			if (!st->apex.on && !iio_buffer_enabled(indio_dev)) {
+				conf.mode = INV_ICM42600_SENSOR_MODE_OFF;
+				ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_ms);
+				if (ret)
+					goto error_suspend;
+			}
+		}
+		if (sleep_ms)
+			msleep(sleep_ms);
+		pm_runtime_mark_last_busy(pdev);
+		pm_runtime_put_autosuspend(pdev);
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
@@ -464,6 +622,10 @@ static int inv_icm42600_accel_write_odr(struct iio_dev *indio_dev,
 		goto out_unlock;
 
 	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
+	if (ret)
+		goto out_unlock;
+	/* update wom threshold since roc is dependent on sampling frequency */
+	ret = inv_icm42600_accel_set_wom_threshold(st, st->apex.wom.value, val, val2);
 	if (ret)
 		goto out_unlock;
 	inv_icm42600_buffer_update_fifo_period(st);
@@ -822,6 +984,98 @@ static int inv_icm42600_accel_hwfifo_flush(struct iio_dev *indio_dev,
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
+	/* handle WoM (roc rising) event */
+	if (type == IIO_EV_TYPE_ROC && dir == IIO_EV_DIR_RISING) {
+		scoped_guard(mutex, &st->lock) {
+			if (st->apex.wom.enable == state)
+				return 0;
+		}
+		return inv_icm42600_accel_enable_wom(indio_dev, state);
+	}
+
+	return -EINVAL;
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
+	/* handle WoM (roc rising) event value */
+	if (type == IIO_EV_TYPE_ROC && dir == IIO_EV_DIR_RISING) {
+		/* return value in micro */
+		*val = div_u64_rem(st->apex.wom.value, 1000000U, &rem);
+		*val2 = rem;
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+
+	return -EINVAL;
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
+	/* handle WoM (roc rising) event value */
+	if (type == IIO_EV_TYPE_ROC && dir == IIO_EV_DIR_RISING) {
+		if (val < 0 || val2 < 0)
+			return -EINVAL;
+		value = (uint64_t)val * 1000000ULL + (uint64_t)val2;
+		pm_runtime_get_sync(dev);
+		scoped_guard(mutex, &st->lock) {
+			ret = inv_icm42600_accel_read_odr(st, &accel_hz, &accel_uhz);
+			if (ret >= 0)
+				ret = inv_icm42600_accel_set_wom_threshold(st, value,
+									   accel_hz, accel_uhz);
+		}
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
 static const struct iio_info inv_icm42600_accel_info = {
 	.read_raw = inv_icm42600_accel_read_raw,
 	.read_avail = inv_icm42600_accel_read_avail,
@@ -831,6 +1085,10 @@ static const struct iio_info inv_icm42600_accel_info = {
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
index ef9875d3b79db116f9fb4f6d881a7979292c1792..c0fd2770d66f02d1965fa07f819fd2db9a1d6bd2 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -404,6 +404,35 @@ int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
 					  sleep_ms);
 }
 
+int inv_icm42600_set_wom(struct inv_icm42600_state *st, bool enable)
+{
+	unsigned int val;
+	int ret;
+
+	if (enable) {
+		/* enable WoM hardware */
+		val = INV_ICM42600_SMD_CONFIG_SMD_MODE_WOM |
+		      INV_ICM42600_SMD_CONFIG_WOM_MODE;
+		ret = regmap_write(st->map, INV_ICM42600_REG_SMD_CONFIG, val);
+		if (ret)
+			return ret;
+		/* enable WoM interrupt */
+		ret = regmap_set_bits(st->map, INV_ICM42600_REG_INT_SOURCE1,
+				      INV_ICM42600_INT_SOURCE1_WOM_INT1_EN);
+	} else {
+		/* disable WoM interrupt */
+		ret = regmap_clear_bits(st->map, INV_ICM42600_REG_INT_SOURCE1,
+					INV_ICM42600_INT_SOURCE1_WOM_INT1_EN);
+		if (ret)
+			return ret;
+		/* disable WoM hardware */
+		val = INV_ICM42600_SMD_CONFIG_SMD_MODE_OFF;
+		ret = regmap_write(st->map, INV_ICM42600_REG_SMD_CONFIG, val);
+	}
+
+	return ret;
+}
+
 int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval)
 {
@@ -543,11 +572,22 @@ static irqreturn_t inv_icm42600_irq_handler(int irq, void *_data)
 {
 	struct inv_icm42600_state *st = _data;
 	struct device *dev = regmap_get_device(st->map);
-	unsigned int status;
+	unsigned int status, status2, status3;
 	int ret;
 
 	mutex_lock(&st->lock);
 
+	if (st->apex.on) {
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
@@ -809,6 +849,13 @@ static int inv_icm42600_suspend(struct device *dev)
 			goto out_unlock;
 	}
 
+	/* disable APEX features */
+	if (st->apex.wom.enable) {
+		ret = inv_icm42600_set_wom(st, false);
+		if (ret)
+			goto out_unlock;
+	}
+
 	ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
 					 INV_ICM42600_SENSOR_MODE_OFF, false,
 					 NULL);
@@ -850,6 +897,13 @@ static int inv_icm42600_resume(struct device *dev)
 	if (ret)
 		goto out_unlock;
 
+	/* restore APEX features */
+	if (st->apex.wom.enable) {
+		ret = inv_icm42600_set_wom(st, true);
+		if (ret)
+			goto out_unlock;
+	}
+
 	/* restore FIFO data streaming */
 	if (st->fifo.on) {
 		inv_sensors_timestamp_reset(&gyro_st->ts);

-- 
2.48.1



