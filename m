Return-Path: <linux-iio+bounces-15201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDD5A2DFC3
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F3C16500A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7861E0E13;
	Sun,  9 Feb 2025 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnxqPhyT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14E1E0E01
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124462; cv=none; b=FHTM3MuNW7O/6j0/LzkMNlyJyHSko9sRTX76LnoHKwGeEjDMmw8g/0zw6Acqb9zqEqXrcWYiDs5qWHAANk14Gx2XWm8XGyE4MxnlXZ27pne8mM+xgGOYLBsUZY2nAVqgnXs00k6fQ5QTCH9BTgwaQaavCKVck90Ea6zB3bNRIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124462; c=relaxed/simple;
	bh=yR5Rcuszco9q7qJh5bH9jJDFxXUABvUrFpU0Snzfa5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHKN0vRIgHIDD6H8dBi+yJTg0MNZUxIE1qe2TIe7nHSZrKPNiZ3JZUYFLdOuSwC5Yf7xUxK8i4of534xOMqs2KUUwKz+l7nNS1RuEckd9mjqe1qpfHHziffqIog8oBJoc4X9TJDXfE9X0aN1e+nGSrqz9m/rh5H3mz+iyG36vQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnxqPhyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C11DC4CEDD;
	Sun,  9 Feb 2025 18:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124461;
	bh=yR5Rcuszco9q7qJh5bH9jJDFxXUABvUrFpU0Snzfa5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TnxqPhyTFPzjRKdq+0MxRssDszcs1HVlL+8cZaGB9W6veF8Eco6/A/kPQVR7YSlMc
	 gLOGEVsuv3yv5pO5ircBE8ewDXskIJ1fPsZiXQ0mVFeEQXXdxOgVt6E79r3qiOfUgg
	 EUyGgewmGp6rvyZ22aAYSs2Ziaf4DkY0dd+HsbF60q0O5llIoZ8XNfBB2tTI5cPy0h
	 T+J+3PSCOmurw82QHqcOSEnLsrluOzuT/6jYwN/krBhFeqy08awS/rlXi5Z7raY5z9
	 traNJ7ynfOSlQsVx6tygX8s4zeagWZ8BM4h0xPucnrDaRY+tkHDK7Noseb2M4xrSre
	 1ll0QTcwzi1VQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 08/27] iio: accel: adxl367: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:05 +0000
Message-ID: <20250209180624.701140-9-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209180624.701140-1-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This complex cleanup.h use case of conditional guards has proved
to be more trouble that it is worth in terms of false positive compiler
warnings and hard to read code.

Move directly to the new claim/release_direct() that allow sparse
to check for unbalanced context

In some cases there is a convenient wrapper function to which
the handling can be moved. Do that instead of introducing
another layer of wrappers. In others an outer wrapper is added
which claims direct mode, runs the original function with the
scoped claim logic removed, releases direct mode and then checks
for errors.

Cc: Cosmin Tanislav <demonsingur@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/adxl367.c | 194 ++++++++++++++++++++----------------
 1 file changed, 106 insertions(+), 88 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index a48ac0d7bd96..add4053e7a02 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -477,45 +477,42 @@ static int adxl367_set_fifo_watermark(struct adxl367_state *st,
 static int adxl367_set_range(struct iio_dev *indio_dev,
 			     enum adxl367_range range)
 {
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		struct adxl367_state *st = iio_priv(indio_dev);
-		int ret;
+	struct adxl367_state *st = iio_priv(indio_dev);
+	int ret;
 
-		guard(mutex)(&st->lock);
+	guard(mutex)(&st->lock);
 
-		ret = adxl367_set_measure_en(st, false);
-		if (ret)
-			return ret;
+	ret = adxl367_set_measure_en(st, false);
+	if (ret)
+		return ret;
 
-		ret = regmap_update_bits(st->regmap, ADXL367_REG_FILTER_CTL,
-					 ADXL367_FILTER_CTL_RANGE_MASK,
-					 FIELD_PREP(ADXL367_FILTER_CTL_RANGE_MASK,
-						    range));
-		if (ret)
-			return ret;
+	ret = regmap_update_bits(st->regmap, ADXL367_REG_FILTER_CTL,
+				 ADXL367_FILTER_CTL_RANGE_MASK,
+				 FIELD_PREP(ADXL367_FILTER_CTL_RANGE_MASK,
+					    range));
+	if (ret)
+		return ret;
 
-		adxl367_scale_act_thresholds(st, st->range, range);
+	adxl367_scale_act_thresholds(st, st->range, range);
 
-		/* Activity thresholds depend on range */
-		ret = _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
-						 st->act_threshold);
-		if (ret)
-			return ret;
+	/* Activity thresholds depend on range */
+	ret = _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
+					 st->act_threshold);
+	if (ret)
+		return ret;
 
-		ret = _adxl367_set_act_threshold(st, ADXL367_INACTIVITY,
-						 st->inact_threshold);
-		if (ret)
-			return ret;
+	ret = _adxl367_set_act_threshold(st, ADXL367_INACTIVITY,
+					 st->inact_threshold);
+	if (ret)
+		return ret;
 
-		ret = adxl367_set_measure_en(st, true);
-		if (ret)
-			return ret;
+	ret = adxl367_set_measure_en(st, true);
+	if (ret)
+		return ret;
 
-		st->range = range;
+	st->range = range;
 
-		return 0;
-	}
-	unreachable();
+	return 0;
 }
 
 static int adxl367_time_ms_to_samples(struct adxl367_state *st, unsigned int ms)
@@ -620,23 +617,20 @@ static int _adxl367_set_odr(struct adxl367_state *st, enum adxl367_odr odr)
 
 static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_odr odr)
 {
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		struct adxl367_state *st = iio_priv(indio_dev);
-		int ret;
+	struct adxl367_state *st = iio_priv(indio_dev);
+	int ret;
 
-		guard(mutex)(&st->lock);
+	guard(mutex)(&st->lock);
 
-		ret = adxl367_set_measure_en(st, false);
-		if (ret)
-			return ret;
+	ret = adxl367_set_measure_en(st, false);
+	if (ret)
+		return ret;
 
-		ret = _adxl367_set_odr(st, odr);
-		if (ret)
-			return ret;
+	ret = _adxl367_set_odr(st, odr);
+	if (ret)
+		return ret;
 
-		return adxl367_set_measure_en(st, true);
-	}
-	unreachable();
+	return adxl367_set_measure_en(st, true);
 }
 
 static int adxl367_set_temp_adc_en(struct adxl367_state *st, unsigned int reg,
@@ -725,32 +719,29 @@ static int adxl367_read_sample(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int *val)
 {
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		struct adxl367_state *st = iio_priv(indio_dev);
-		u16 sample;
-		int ret;
+	struct adxl367_state *st = iio_priv(indio_dev);
+	u16 sample;
+	int ret;
 
-		guard(mutex)(&st->lock);
+	guard(mutex)(&st->lock);
 
-		ret = adxl367_set_temp_adc_reg_en(st, chan->address, true);
-		if (ret)
-			return ret;
+	ret = adxl367_set_temp_adc_reg_en(st, chan->address, true);
+	if (ret)
+		return ret;
 
-		ret = regmap_bulk_read(st->regmap, chan->address, &st->sample_buf,
-				       sizeof(st->sample_buf));
-		if (ret)
-			return ret;
+	ret = regmap_bulk_read(st->regmap, chan->address, &st->sample_buf,
+			       sizeof(st->sample_buf));
+	if (ret)
+		return ret;
 
-		sample = FIELD_GET(ADXL367_DATA_MASK, be16_to_cpu(st->sample_buf));
-		*val = sign_extend32(sample, chan->scan_type.realbits - 1);
+	sample = FIELD_GET(ADXL367_DATA_MASK, be16_to_cpu(st->sample_buf));
+	*val = sign_extend32(sample, chan->scan_type.realbits - 1);
 
-		ret = adxl367_set_temp_adc_reg_en(st, chan->address, false);
-		if (ret)
-			return ret;
+	ret = adxl367_set_temp_adc_reg_en(st, chan->address, false);
+	if (ret)
+		return ret;
 
-		return IIO_VAL_INT;
-	}
-	unreachable();
+	return IIO_VAL_INT;
 }
 
 static int adxl367_get_status(struct adxl367_state *st, u8 *status,
@@ -852,10 +843,15 @@ static int adxl367_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long info)
 {
 	struct adxl367_state *st = iio_priv(indio_dev);
+	int ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		return adxl367_read_sample(indio_dev, chan, val);
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = adxl367_read_sample(indio_dev, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ACCEL: {
@@ -912,7 +908,12 @@ static int adxl367_write_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		return adxl367_set_odr(indio_dev, odr);
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = adxl367_set_odr(indio_dev, odr);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	}
 	case IIO_CHAN_INFO_SCALE: {
 		enum adxl367_range range;
@@ -921,7 +922,12 @@ static int adxl367_write_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		return adxl367_set_range(indio_dev, range);
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = adxl367_set_range(indio_dev, range);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	}
 	default:
 		return -EINVAL;
@@ -1069,13 +1075,15 @@ static int adxl367_read_event_config(struct iio_dev *indio_dev,
 	}
 }
 
-static int adxl367_write_event_config(struct iio_dev *indio_dev,
-				      const struct iio_chan_spec *chan,
-				      enum iio_event_type type,
-				      enum iio_event_direction dir,
-				      bool state)
+static int __adxl367_write_event_config(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir,
+					bool state)
 {
+	struct adxl367_state *st = iio_priv(indio_dev);
 	enum adxl367_activity_type act;
+	int ret;
 
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
@@ -1088,28 +1096,38 @@ static int adxl367_write_event_config(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		struct adxl367_state *st = iio_priv(indio_dev);
-		int ret;
+	guard(mutex)(&st->lock);
+
+	ret = adxl367_set_measure_en(st, false);
+	if (ret)
+		return ret;
 
-		guard(mutex)(&st->lock);
+	ret = adxl367_set_act_interrupt_en(st, act, state);
+	if (ret)
+		return ret;
 
-		ret = adxl367_set_measure_en(st, false);
-		if (ret)
-			return ret;
+	ret = adxl367_set_act_en(st, act, state ? ADCL367_ACT_REF_ENABLED
+				 : ADXL367_ACT_DISABLED);
+	if (ret)
+		return ret;
 
-		ret = adxl367_set_act_interrupt_en(st, act, state);
-		if (ret)
-			return ret;
+	return adxl367_set_measure_en(st, true);
+}
 
-		ret = adxl367_set_act_en(st, act, state ? ADCL367_ACT_REF_ENABLED
-					 : ADXL367_ACT_DISABLED);
-		if (ret)
-			return ret;
+static int adxl367_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      bool state)
+{
+	int ret;
 
-		return adxl367_set_measure_en(st, true);
-	}
-	unreachable();
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = __adxl367_write_event_config(indio_dev, chan, type, dir, state);
+	iio_device_release_direct(indio_dev);
+	return ret;
 }
 
 static ssize_t adxl367_get_fifo_enabled(struct device *dev,
-- 
2.48.1


