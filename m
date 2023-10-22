Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F38B7D23BF
	for <lists+linux-iio@lfdr.de>; Sun, 22 Oct 2023 17:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjJVPrn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Oct 2023 11:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJVPrm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Oct 2023 11:47:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD47B4
        for <linux-iio@vger.kernel.org>; Sun, 22 Oct 2023 08:47:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9483AC433C8;
        Sun, 22 Oct 2023 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989659;
        bh=Z9+ZUROP2NzjgVMzBRQe8RNyVrb+lC3mlzJIZeH6YA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpRDMEhXG2/97bDxlAaU7/jN6MWBMlWkBzd4jvimGALu/ArdV0KEQaoK0cJ8I9llP
         isZGLJ2qszCBz2DmIutAy+PW+n+fdMMpxOOXme8usD7GPpewyWCPI2P8SvsaAjHfsi
         fT+arE97p+ThPYRYGruKWrKB6I8EdtJM0S+T7Ad1avBG3G1lm+Tnut8NWLxEsMytGm
         fFTCTcJ37IEg66eTaSdFRScZ6lvOiJjpFQm/7jUlItC+HE6vRKV5h/Hk3EPSBILcd6
         0MF6siB3J46NVmCThoVvS/knqm55L72BJ/wbqrZOOs2uOdwVtu5l09vyxAA3/f7VjM
         bB/+kG/oRvMdQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 3/8] iio: accel: adxl367: Use automated cleanup for locks and iio direct mode.
Date:   Sun, 22 Oct 2023 16:47:05 +0100
Message-ID: <20231022154710.402590-4-jic23@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231022154710.402590-1-jic23@kernel.org>
References: <20231022154710.402590-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Switching to the CLASS based cleanup for iio_device_direct_mode_claim()
and to guard() based unlocking of mutexes simplifies error handling
by allowing direct returns when an error is encountered.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/adxl367.c | 214 ++++++++++++++----------------------
 1 file changed, 80 insertions(+), 134 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 90b7ae6d42b7..50022f6b0f07 100644
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
@@ -482,25 +477,26 @@ static int adxl367_set_fifo_watermark(struct adxl367_state *st,
 static int adxl367_set_range(struct iio_dev *indio_dev,
 			     enum adxl367_range range)
 {
-	struct adxl367_state *st = iio_priv(indio_dev);
+	struct adxl367_state *st;
 	int ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+	if (IS_ERR(claimed_dev))
+		return PTR_ERR(claimed_dev);
 
-	mutex_lock(&st->lock);
+	st = iio_priv(claimed_dev);
+	guard(mutex)(&st->lock);
 
 	ret = adxl367_set_measure_en(st, false);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = regmap_update_bits(st->regmap, ADXL367_REG_FILTER_CTL,
 				 ADXL367_FILTER_CTL_RANGE_MASK,
 				 FIELD_PREP(ADXL367_FILTER_CTL_RANGE_MASK,
 					    range));
 	if (ret)
-		goto out;
+		return ret;
 
 	adxl367_scale_act_thresholds(st, st->range, range);
 
@@ -508,25 +504,20 @@ static int adxl367_set_range(struct iio_dev *indio_dev,
 	ret = _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
 					 st->act_threshold);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = _adxl367_set_act_threshold(st, ADXL367_INACTIVITY,
 					 st->inact_threshold);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = adxl367_set_measure_en(st, true);
 	if (ret)
-		goto out;
+		return ret;
 
 	st->range = range;
 
-out:
-	mutex_unlock(&st->lock);
-
-	iio_device_release_direct_mode(indio_dev);
-
-	return ret;
+	return 0;
 }
 
 static int adxl367_time_ms_to_samples(struct adxl367_state *st, unsigned int ms)
@@ -587,11 +578,11 @@ static int adxl367_set_act_time_ms(struct adxl367_state *st,
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
@@ -599,14 +590,9 @@ static int adxl367_set_act_time_ms(struct adxl367_state *st,
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
@@ -636,31 +622,25 @@ static int _adxl367_set_odr(struct adxl367_state *st, enum adxl367_odr odr)
 
 static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_odr odr)
 {
-	struct adxl367_state *st = iio_priv(indio_dev);
+	struct adxl367_state *st;
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
 
 	ret = adxl367_set_measure_en(st, false);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = _adxl367_set_odr(st, odr);
 	if (ret)
-		goto out;
-
-	ret = adxl367_set_measure_en(st, true);
-
-out:
-	mutex_unlock(&st->lock);
-
-	iio_device_release_direct_mode(indio_dev);
+		return ret;;
 
-	return ret;
+	return adxl367_set_measure_en(st, true);
 }
 
 static int adxl367_set_temp_adc_en(struct adxl367_state *st, unsigned int reg,
@@ -749,36 +729,34 @@ static int adxl367_read_sample(struct iio_dev *indio_dev,
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
@@ -886,12 +864,12 @@ static int adxl367_read_raw(struct iio_dev *indio_dev,
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
@@ -914,12 +892,12 @@ static int adxl367_read_raw(struct iio_dev *indio_dev,
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
@@ -1004,18 +982,15 @@ static int adxl367_read_event_value(struct iio_dev *indio_dev,
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
@@ -1024,15 +999,11 @@ static int adxl367_read_event_value(struct iio_dev *indio_dev,
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
@@ -1110,7 +1081,7 @@ static int adxl367_write_event_config(struct iio_dev *indio_dev,
 				      enum iio_event_direction dir,
 				      int state)
 {
-	struct adxl367_state *st = iio_priv(indio_dev);
+	struct adxl367_state *st;
 	enum adxl367_activity_type act;
 	int ret;
 
@@ -1125,33 +1096,27 @@ static int adxl367_write_event_config(struct iio_dev *indio_dev,
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
@@ -1176,9 +1141,8 @@ static ssize_t adxl367_get_fifo_watermark(struct device *dev,
 	struct adxl367_state *st = iio_priv(dev_to_iio_dev(dev));
 	unsigned int fifo_watermark;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	fifo_watermark = st->fifo_watermark;
-	mutex_unlock(&st->lock);
 
 	return sysfs_emit(buf, "%d\n", fifo_watermark);
 }
@@ -1207,22 +1171,17 @@ static int adxl367_set_watermark(struct iio_dev *indio_dev, unsigned int val)
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
@@ -1253,27 +1212,24 @@ static int adxl367_update_scan_mode(struct iio_dev *indio_dev,
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
@@ -1281,31 +1237,26 @@ static int adxl367_buffer_postenable(struct iio_dev *indio_dev)
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
@@ -1313,31 +1264,26 @@ static int adxl367_buffer_predisable(struct iio_dev *indio_dev)
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
2.42.0

