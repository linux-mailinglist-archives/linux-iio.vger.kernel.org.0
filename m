Return-Path: <linux-iio+bounces-1023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4164B816140
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 18:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2D02817A7
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 17:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C4346440;
	Sun, 17 Dec 2023 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYaIwfdI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7071DFD8
	for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2023 17:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369B1C433C8;
	Sun, 17 Dec 2023 17:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834573;
	bh=QQynbvjgsLe33ko9cdD5OZQ8vBzFCWWpw51zSa9Rz8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYaIwfdISipWvC3pOdh+qIMkDKa6+0CkvsXieM5WwDBZm6+PazWOkzweeZNMiWsHo
	 ZK2VPh4cWD0L/wl60MBOsuzR/lrYEbzc0FY06CbjJQgK7xyhXeohSh3z8LXaqenNtR
	 ajvZlO9fs4dtMHPlYICP9r0u0ZQE+YnmjWmv+bfNAhaMuOY5XwxUy1yQiBzGSVDUhv
	 ItACg8aarmSenv3XOrcZTxM19bXvV1RQDvAEbfRb52Hgk4nj1cGBufT894QwZkKQZn
	 JMgpGAaCKSBgIhRjGY6mH3a1GmD1kcQBRU22ZBKPd/S6X4YVxEtbPzBm6s8giwnY4L
	 N+61ZON5o5nBg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 03/10] iio: accel: adxl367: Use automated cleanup for locks and iio direct mode.
Date: Sun, 17 Dec 2023 17:35:41 +0000
Message-ID: <20231217173548.112701-4-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217173548.112701-1-jic23@kernel.org>
References: <20231217173548.112701-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Switching to the iio_device_claim_direct_scoped() for state
and to guard() based unlocking of mutexes simplifies error handling
by allowing direct returns when an error is encountered.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/adxl367.c | 261 ++++++++++++++----------------------
 1 file changed, 103 insertions(+), 158 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 90b7ae6d42b7..f4e1b013f2a1 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -339,22 +339,17 @@ static int adxl367_set_act_threshold(struct adxl367_state *st,
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = adxl367_set_measure_en(st, false);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = _adxl367_set_act_threshold(st, act, threshold);
 	if (ret)
-		goto out;
-
-	ret = adxl367_set_measure_en(st, true);
-
-out:
-	mutex_unlock(&st->lock);
+		return ret;
 
-	return ret;
+	return adxl367_set_measure_en(st, true);
 }
 
 static int adxl367_set_act_proc_mode(struct adxl367_state *st,
@@ -482,51 +477,43 @@ static int adxl367_set_fifo_watermark(struct adxl367_state *st,
 static int adxl367_set_range(struct iio_dev *indio_dev,
 			     enum adxl367_range range)
 {
-	struct adxl367_state *st = iio_priv(indio_dev);
+	struct adxl367_state *st;
 	int ret;
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		st = iio_priv(indio_dev);
+		guard(mutex)(&st->lock);
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-
-	mutex_lock(&st->lock);
-
-	ret = adxl367_set_measure_en(st, false);
-	if (ret)
-		goto out;
-
-	ret = regmap_update_bits(st->regmap, ADXL367_REG_FILTER_CTL,
-				 ADXL367_FILTER_CTL_RANGE_MASK,
-				 FIELD_PREP(ADXL367_FILTER_CTL_RANGE_MASK,
-					    range));
-	if (ret)
-		goto out;
-
-	adxl367_scale_act_thresholds(st, st->range, range);
-
-	/* Activity thresholds depend on range */
-	ret = _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
-					 st->act_threshold);
-	if (ret)
-		goto out;
+		ret = adxl367_set_measure_en(st, false);
+		if (ret)
+			return ret;
 
-	ret = _adxl367_set_act_threshold(st, ADXL367_INACTIVITY,
-					 st->inact_threshold);
-	if (ret)
-		goto out;
+		ret = regmap_update_bits(st->regmap, ADXL367_REG_FILTER_CTL,
+					 ADXL367_FILTER_CTL_RANGE_MASK,
+					 FIELD_PREP(ADXL367_FILTER_CTL_RANGE_MASK,
+						    range));
+		if (ret)
+			return ret;
 
-	ret = adxl367_set_measure_en(st, true);
-	if (ret)
-		goto out;
+		adxl367_scale_act_thresholds(st, st->range, range);
 
-	st->range = range;
+		/* Activity thresholds depend on range */
+		ret = _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
+						 st->act_threshold);
+		if (ret)
+			return ret;
 
-out:
-	mutex_unlock(&st->lock);
+		ret = _adxl367_set_act_threshold(st, ADXL367_INACTIVITY,
+						 st->inact_threshold);
+		if (ret)
+			return ret;
 
-	iio_device_release_direct_mode(indio_dev);
+		ret = adxl367_set_measure_en(st, true);
+		if (ret)
+			return ret;
 
-	return ret;
+		st->range = range;
+	}
+	return 0;
 }
 
 static int adxl367_time_ms_to_samples(struct adxl367_state *st, unsigned int ms)
@@ -587,11 +574,11 @@ static int adxl367_set_act_time_ms(struct adxl367_state *st,
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = adxl367_set_measure_en(st, false);
 	if (ret)
-		goto out;
+		return ret;
 
 	if (act == ADXL367_ACTIVITY)
 		ret = _adxl367_set_act_time_ms(st, ms);
@@ -599,14 +586,9 @@ static int adxl367_set_act_time_ms(struct adxl367_state *st,
 		ret = _adxl367_set_inact_time_ms(st, ms);
 
 	if (ret)
-		goto out;
-
-	ret = adxl367_set_measure_en(st, true);
-
-out:
-	mutex_unlock(&st->lock);
+		return ret;
 
-	return ret;
+	return adxl367_set_measure_en(st, true);
 }
 
 static int _adxl367_set_odr(struct adxl367_state *st, enum adxl367_odr odr)
@@ -636,31 +618,28 @@ static int _adxl367_set_odr(struct adxl367_state *st, enum adxl367_odr odr)
 
 static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_odr odr)
 {
-	struct adxl367_state *st = iio_priv(indio_dev);
+	struct adxl367_state *st;
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-
-	mutex_lock(&st->lock);
-
-	ret = adxl367_set_measure_en(st, false);
-	if (ret)
-		goto out;
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		st = iio_priv(indio_dev);
 
-	ret = _adxl367_set_odr(st, odr);
-	if (ret)
-		goto out;
+		guard(mutex)(&st->lock);
 
-	ret = adxl367_set_measure_en(st, true);
+		ret = adxl367_set_measure_en(st, false);
+		if (ret)
+			return ret;
 
-out:
-	mutex_unlock(&st->lock);
+		ret = _adxl367_set_odr(st, odr);
+		if (ret)
+			return ret;
 
-	iio_device_release_direct_mode(indio_dev);
+		ret = adxl367_set_measure_en(st, true);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int adxl367_set_temp_adc_en(struct adxl367_state *st, unsigned int reg,
@@ -749,36 +728,34 @@ static int adxl367_read_sample(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int *val)
 {
-	struct adxl367_state *st = iio_priv(indio_dev);
+	struct adxl367_state *st;
 	u16 sample;
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+	if (IS_ERR(claimed_dev))
+		return PTR_ERR(claimed_dev);
+	st = iio_priv(claimed_dev);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = adxl367_set_temp_adc_reg_en(st, chan->address, true);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = regmap_bulk_read(st->regmap, chan->address, &st->sample_buf,
 			       sizeof(st->sample_buf));
 	if (ret)
-		goto out;
+		return ret;
 
 	sample = FIELD_GET(ADXL367_DATA_MASK, be16_to_cpu(st->sample_buf));
 	*val = sign_extend32(sample, chan->scan_type.realbits - 1);
 
 	ret = adxl367_set_temp_adc_reg_en(st, chan->address, false);
+	if (ret)
+		return ret;
 
-out:
-	mutex_unlock(&st->lock);
-
-	iio_device_release_direct_mode(indio_dev);
-
-	return ret ?: IIO_VAL_INT;
+	return IIO_VAL_INT;
 }
 
 static int adxl367_get_status(struct adxl367_state *st, u8 *status,
@@ -886,12 +863,12 @@ static int adxl367_read_raw(struct iio_dev *indio_dev,
 		return adxl367_read_sample(indio_dev, chan, val);
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
-		case IIO_ACCEL:
-			mutex_lock(&st->lock);
+		case IIO_ACCEL: {
+			guard(mutex)(&st->lock);
 			*val = adxl367_range_scale_tbl[st->range][0];
 			*val2 = adxl367_range_scale_tbl[st->range][1];
-			mutex_unlock(&st->lock);
 			return IIO_VAL_INT_PLUS_NANO;
+		}
 		case IIO_TEMP:
 			*val = 1000;
 			*val2 = ADXL367_TEMP_PER_C;
@@ -914,12 +891,12 @@ static int adxl367_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		mutex_lock(&st->lock);
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&st->lock);
 		*val = adxl367_samp_freq_tbl[st->odr][0];
 		*val2 = adxl367_samp_freq_tbl[st->odr][1];
-		mutex_unlock(&st->lock);
 		return IIO_VAL_INT_PLUS_MICRO;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -1004,18 +981,15 @@ static int adxl367_read_event_value(struct iio_dev *indio_dev,
 {
 	struct adxl367_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
 	switch (info) {
 	case IIO_EV_INFO_VALUE: {
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
-			mutex_lock(&st->lock);
 			*val = st->act_threshold;
-			mutex_unlock(&st->lock);
 			return IIO_VAL_INT;
 		case IIO_EV_DIR_FALLING:
-			mutex_lock(&st->lock);
 			*val = st->inact_threshold;
-			mutex_unlock(&st->lock);
 			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
@@ -1024,15 +998,11 @@ static int adxl367_read_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_INFO_PERIOD:
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
-			mutex_lock(&st->lock);
 			*val = st->act_time_ms;
-			mutex_unlock(&st->lock);
 			*val2 = 1000;
 			return IIO_VAL_FRACTIONAL;
 		case IIO_EV_DIR_FALLING:
-			mutex_lock(&st->lock);
 			*val = st->inact_time_ms;
-			mutex_unlock(&st->lock);
 			*val2 = 1000;
 			return IIO_VAL_FRACTIONAL;
 		default:
@@ -1110,7 +1080,7 @@ static int adxl367_write_event_config(struct iio_dev *indio_dev,
 				      enum iio_event_direction dir,
 				      int state)
 {
-	struct adxl367_state *st = iio_priv(indio_dev);
+	struct adxl367_state *st;
 	enum adxl367_activity_type act;
 	int ret;
 
@@ -1125,33 +1095,27 @@ static int adxl367_write_event_config(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+	if (IS_ERR(claimed_dev))
+		return PTR_ERR(claimed_dev);
+	st = iio_priv(claimed_dev);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = adxl367_set_measure_en(st, false);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = adxl367_set_act_interrupt_en(st, act, state);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = adxl367_set_act_en(st, act, state ? ADCL367_ACT_REF_ENABLED
 						: ADXL367_ACT_DISABLED);
 	if (ret)
-		goto out;
-
-	ret = adxl367_set_measure_en(st, true);
-
-out:
-	mutex_unlock(&st->lock);
-
-	iio_device_release_direct_mode(indio_dev);
+		return ret;
 
-	return ret;
+	return adxl367_set_measure_en(st, true);
 }
 
 static ssize_t adxl367_get_fifo_enabled(struct device *dev,
@@ -1176,9 +1140,8 @@ static ssize_t adxl367_get_fifo_watermark(struct device *dev,
 	struct adxl367_state *st = iio_priv(dev_to_iio_dev(dev));
 	unsigned int fifo_watermark;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	fifo_watermark = st->fifo_watermark;
-	mutex_unlock(&st->lock);
 
 	return sysfs_emit(buf, "%d\n", fifo_watermark);
 }
@@ -1207,22 +1170,17 @@ static int adxl367_set_watermark(struct iio_dev *indio_dev, unsigned int val)
 	if (val > ADXL367_FIFO_MAX_WATERMARK)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = adxl367_set_measure_en(st, false);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = adxl367_set_fifo_watermark(st, val);
 	if (ret)
-		goto out;
-
-	ret = adxl367_set_measure_en(st, true);
-
-out:
-	mutex_unlock(&st->lock);
+		return ret;
 
-	return ret;
+	return adxl367_set_measure_en(st, true);
 }
 
 static bool adxl367_find_mask_fifo_format(const unsigned long *scan_mask,
@@ -1253,27 +1211,24 @@ static int adxl367_update_scan_mode(struct iio_dev *indio_dev,
 	if (!adxl367_find_mask_fifo_format(active_scan_mask, &fifo_format))
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = adxl367_set_measure_en(st, false);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = adxl367_set_fifo_format(st, fifo_format);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = adxl367_set_measure_en(st, true);
 	if (ret)
-		goto out;
+		return ret;
 
 	st->fifo_set_size = bitmap_weight(active_scan_mask,
 					  indio_dev->masklength);
 
-out:
-	mutex_unlock(&st->lock);
-
-	return ret;
+	return 0;
 }
 
 static int adxl367_buffer_postenable(struct iio_dev *indio_dev)
@@ -1281,31 +1236,26 @@ static int adxl367_buffer_postenable(struct iio_dev *indio_dev)
 	struct adxl367_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = adxl367_set_temp_adc_mask_en(st, indio_dev->active_scan_mask,
 					   true);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = adxl367_set_measure_en(st, false);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = adxl367_set_fifo_watermark_interrupt_en(st, true);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = adxl367_set_fifo_mode(st, ADXL367_FIFO_MODE_STREAM);
 	if (ret)
-		goto out;
-
-	ret = adxl367_set_measure_en(st, true);
-
-out:
-	mutex_unlock(&st->lock);
+		return ret;
 
-	return ret;
+	return adxl367_set_measure_en(st, true);
 }
 
 static int adxl367_buffer_predisable(struct iio_dev *indio_dev)
@@ -1313,31 +1263,26 @@ static int adxl367_buffer_predisable(struct iio_dev *indio_dev)
 	struct adxl367_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = adxl367_set_measure_en(st, false);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = adxl367_set_fifo_mode(st, ADXL367_FIFO_MODE_DISABLED);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = adxl367_set_fifo_watermark_interrupt_en(st, false);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = adxl367_set_measure_en(st, true);
 	if (ret)
-		goto out;
-
-	ret = adxl367_set_temp_adc_mask_en(st, indio_dev->active_scan_mask,
-					   false);
-
-out:
-	mutex_unlock(&st->lock);
+		return ret;
 
-	return ret;
+	return adxl367_set_temp_adc_mask_en(st, indio_dev->active_scan_mask,
+					    false);
 }
 
 static const struct iio_buffer_setup_ops adxl367_buffer_ops = {
-- 
2.43.0


