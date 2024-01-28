Return-Path: <linux-iio+bounces-1983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB13283F609
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 16:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786951F22131
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963A425635;
	Sun, 28 Jan 2024 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTtORXnS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D1C1E50B
	for <linux-iio@vger.kernel.org>; Sun, 28 Jan 2024 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706454393; cv=none; b=N09noSmAdvEsJ3EwJl5NmCTVpAB8GY+CGMhkkYtxMK0Zu0MKacGZj6HAqxeannjnAjBp/l2fQ82EQCiyDzYOMJTEokYqSZzG/2jXE7d7xb3ooUfOq/UdaljxuXQrSt5YTtiL8W+7UClDesq46PoDDNkNOd5dTdu3m/BJaYV7esQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706454393; c=relaxed/simple;
	bh=LCv+peUUd9JySMVnbLKVjhQzHRf8Ft+WYjujrjVAJFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncwiQ7LFtE7rhnQqHuAibELjentLDrqy0NF5VjAHsNNbSMDCTwkkvpmlYi+DXOePXzi2xF4dY44GyCOtbP13O6vTz7X2tYaHtR2Tfa/r2ErSAQZiJWOukc8osdzIlscWQI9uEgHP95N3FHsb2LkZWuLFIxUjcrPYs4kz5TICOSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTtORXnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF15CC433F1;
	Sun, 28 Jan 2024 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706454393;
	bh=LCv+peUUd9JySMVnbLKVjhQzHRf8Ft+WYjujrjVAJFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTtORXnSeUcUFU1Gpk+G0YId16Bba6Xrby2Ave/jEqoejyIDFD94jM9p+jwSEsWOA
	 7yFqINbKUtmtBflwwrgBfj3SmBJxZONmJf9/AYkLmfVP59sb8Vyf/VpKkWLIXbfOUj
	 W1mgG8SqH2RScqnIopTzBM7FVIc02M0pJy/HAfS2VzrjGP9OXj3hiwNil1tFXGrPLW
	 8h3hajg/vrnyyJRvkWouxnDRZoIp0y2OtSUCXneRmWxmqketfcZj9xEMzK6yf+zVGl
	 RpfZI2cAm3d3zMvU82+nsXbPozKSXEHOdjDzp3IFyRAQn2AchvxLfmme/qr+Pjkj05
	 W/BwQmaM+HQag==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/10] iio: accel: adxl367: Use automated cleanup for locks and iio direct mode.
Date: Sun, 28 Jan 2024 15:05:30 +0000
Message-ID: <20240128150537.44592-4-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128150537.44592-1-jic23@kernel.org>
References: <20240128150537.44592-1-jic23@kernel.org>
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
Since RFC:
- Use unreachable() to stop complier moaning if we have

	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
		return 0;
	}
	unreachable(); /* can't get here */
- Update some code from earlier attempt to handle this that was left
  behind from before iio_device_claim_direct_scoped()
- Reduce scope of some local variables only used within
  iio_device_claim_direct_scoped() blocks.
---
 drivers/iio/accel/adxl367.c | 297 ++++++++++++++----------------------
 1 file changed, 118 insertions(+), 179 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 90b7ae6d42b7..834ee6d63947 100644
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
@@ -482,51 +477,45 @@ static int adxl367_set_fifo_watermark(struct adxl367_state *st,
 static int adxl367_set_range(struct iio_dev *indio_dev,
 			     enum adxl367_range range)
 {
-	struct adxl367_state *st = iio_priv(indio_dev);
-	int ret;
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		struct adxl367_state *st = iio_priv(indio_dev);
+		int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-
-	mutex_lock(&st->lock);
-
-	ret = adxl367_set_measure_en(st, false);
-	if (ret)
-		goto out;
+		guard(mutex)(&st->lock);
 
-	ret = regmap_update_bits(st->regmap, ADXL367_REG_FILTER_CTL,
-				 ADXL367_FILTER_CTL_RANGE_MASK,
-				 FIELD_PREP(ADXL367_FILTER_CTL_RANGE_MASK,
-					    range));
-	if (ret)
-		goto out;
+		ret = adxl367_set_measure_en(st, false);
+		if (ret)
+			return ret;
 
-	adxl367_scale_act_thresholds(st, st->range, range);
+		ret = regmap_update_bits(st->regmap, ADXL367_REG_FILTER_CTL,
+					 ADXL367_FILTER_CTL_RANGE_MASK,
+					 FIELD_PREP(ADXL367_FILTER_CTL_RANGE_MASK,
+						    range));
+		if (ret)
+			return ret;
 
-	/* Activity thresholds depend on range */
-	ret = _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
-					 st->act_threshold);
-	if (ret)
-		goto out;
+		adxl367_scale_act_thresholds(st, st->range, range);
 
-	ret = _adxl367_set_act_threshold(st, ADXL367_INACTIVITY,
-					 st->inact_threshold);
-	if (ret)
-		goto out;
-
-	ret = adxl367_set_measure_en(st, true);
-	if (ret)
-		goto out;
+		/* Activity thresholds depend on range */
+		ret = _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
+						 st->act_threshold);
+		if (ret)
+			return ret;
 
-	st->range = range;
+		ret = _adxl367_set_act_threshold(st, ADXL367_INACTIVITY,
+						 st->inact_threshold);
+		if (ret)
+			return ret;
 
-out:
-	mutex_unlock(&st->lock);
+		ret = adxl367_set_measure_en(st, true);
+		if (ret)
+			return ret;
 
-	iio_device_release_direct_mode(indio_dev);
+		st->range = range;
 
-	return ret;
+		return 0;
+	}
+	unreachable();
 }
 
 static int adxl367_time_ms_to_samples(struct adxl367_state *st, unsigned int ms)
@@ -587,11 +576,11 @@ static int adxl367_set_act_time_ms(struct adxl367_state *st,
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
@@ -599,14 +588,9 @@ static int adxl367_set_act_time_ms(struct adxl367_state *st,
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
@@ -636,31 +620,23 @@ static int _adxl367_set_odr(struct adxl367_state *st, enum adxl367_odr odr)
 
 static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_odr odr)
 {
-	struct adxl367_state *st = iio_priv(indio_dev);
-	int ret;
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		struct adxl367_state *st = iio_priv(indio_dev);;
+		int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+		guard(mutex)(&st->lock);
 
-	mutex_lock(&st->lock);
-
-	ret = adxl367_set_measure_en(st, false);
-	if (ret)
-		goto out;
-
-	ret = _adxl367_set_odr(st, odr);
-	if (ret)
-		goto out;
-
-	ret = adxl367_set_measure_en(st, true);
-
-out:
-	mutex_unlock(&st->lock);
+		ret = adxl367_set_measure_en(st, false);
+		if (ret)
+			return ret;
 
-	iio_device_release_direct_mode(indio_dev);
+		ret = _adxl367_set_odr(st, odr);
+		if (ret)
+			return ret;
 
-	return ret;
+		return adxl367_set_measure_en(st, true);
+	}
+	unreachable();
 }
 
 static int adxl367_set_temp_adc_en(struct adxl367_state *st, unsigned int reg,
@@ -749,36 +725,32 @@ static int adxl367_read_sample(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int *val)
 {
-	struct adxl367_state *st = iio_priv(indio_dev);
-	u16 sample;
-	int ret;
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		struct adxl367_state *st = iio_priv(indio_dev);
+		u16 sample;
+		int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+		guard(mutex)(&st->lock);
 
-	mutex_lock(&st->lock);
-
-	ret = adxl367_set_temp_adc_reg_en(st, chan->address, true);
-	if (ret)
-		goto out;
-
-	ret = regmap_bulk_read(st->regmap, chan->address, &st->sample_buf,
-			       sizeof(st->sample_buf));
-	if (ret)
-		goto out;
-
-	sample = FIELD_GET(ADXL367_DATA_MASK, be16_to_cpu(st->sample_buf));
-	*val = sign_extend32(sample, chan->scan_type.realbits - 1);
+		ret = adxl367_set_temp_adc_reg_en(st, chan->address, true);
+		if (ret)
+			return ret;
 
-	ret = adxl367_set_temp_adc_reg_en(st, chan->address, false);
+		ret = regmap_bulk_read(st->regmap, chan->address, &st->sample_buf,
+				       sizeof(st->sample_buf));
+		if (ret)
+			return ret;
 
-out:
-	mutex_unlock(&st->lock);
+		sample = FIELD_GET(ADXL367_DATA_MASK, be16_to_cpu(st->sample_buf));
+		*val = sign_extend32(sample, chan->scan_type.realbits - 1);
 
-	iio_device_release_direct_mode(indio_dev);
+		ret = adxl367_set_temp_adc_reg_en(st, chan->address, false);
+		if (ret)
+			return ret;
 
-	return ret ?: IIO_VAL_INT;
+		return IIO_VAL_INT;
+	}
+	unreachable();
 }
 
 static int adxl367_get_status(struct adxl367_state *st, u8 *status,
@@ -886,12 +858,12 @@ static int adxl367_read_raw(struct iio_dev *indio_dev,
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
@@ -914,12 +886,12 @@ static int adxl367_read_raw(struct iio_dev *indio_dev,
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
@@ -1004,18 +976,15 @@ static int adxl367_read_event_value(struct iio_dev *indio_dev,
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
@@ -1024,15 +993,11 @@ static int adxl367_read_event_value(struct iio_dev *indio_dev,
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
@@ -1110,9 +1075,7 @@ static int adxl367_write_event_config(struct iio_dev *indio_dev,
 				      enum iio_event_direction dir,
 				      int state)
 {
-	struct adxl367_state *st = iio_priv(indio_dev);
 	enum adxl367_activity_type act;
-	int ret;
 
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
@@ -1125,33 +1088,28 @@ static int adxl367_write_event_config(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-
-	mutex_lock(&st->lock);
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		struct adxl367_state *st = iio_priv(indio_dev);
+		int ret;
 
-	ret = adxl367_set_measure_en(st, false);
-	if (ret)
-		goto out;
+		guard(mutex)(&st->lock);
 
-	ret = adxl367_set_act_interrupt_en(st, act, state);
-	if (ret)
-		goto out;
-
-	ret = adxl367_set_act_en(st, act, state ? ADCL367_ACT_REF_ENABLED
-						: ADXL367_ACT_DISABLED);
-	if (ret)
-		goto out;
-
-	ret = adxl367_set_measure_en(st, true);
+		ret = adxl367_set_measure_en(st, false);
+		if (ret)
+			return ret;
 
-out:
-	mutex_unlock(&st->lock);
+		ret = adxl367_set_act_interrupt_en(st, act, state);
+		if (ret)
+			return ret;
 
-	iio_device_release_direct_mode(indio_dev);
+		ret = adxl367_set_act_en(st, act, state ? ADCL367_ACT_REF_ENABLED
+					 : ADXL367_ACT_DISABLED);
+		if (ret)
+			return ret;
 
-	return ret;
+		return adxl367_set_measure_en(st, true);
+	}
+	unreachable();
 }
 
 static ssize_t adxl367_get_fifo_enabled(struct device *dev,
@@ -1176,9 +1134,8 @@ static ssize_t adxl367_get_fifo_watermark(struct device *dev,
 	struct adxl367_state *st = iio_priv(dev_to_iio_dev(dev));
 	unsigned int fifo_watermark;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	fifo_watermark = st->fifo_watermark;
-	mutex_unlock(&st->lock);
 
 	return sysfs_emit(buf, "%d\n", fifo_watermark);
 }
@@ -1207,22 +1164,17 @@ static int adxl367_set_watermark(struct iio_dev *indio_dev, unsigned int val)
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
@@ -1253,27 +1205,24 @@ static int adxl367_update_scan_mode(struct iio_dev *indio_dev,
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
@@ -1281,31 +1230,26 @@ static int adxl367_buffer_postenable(struct iio_dev *indio_dev)
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
@@ -1313,31 +1257,26 @@ static int adxl367_buffer_predisable(struct iio_dev *indio_dev)
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


