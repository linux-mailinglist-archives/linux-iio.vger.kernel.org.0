Return-Path: <linux-iio+bounces-15002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6E5A27C5B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EADB07A1F62
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC36514B094;
	Tue,  4 Feb 2025 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J75HbVh6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA82040AF
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699423; cv=none; b=ez4DJ/v9h9JG/plVfLfHJ1e50LCfXvCCBLH8Y1VzOs/p5G8Gxc9rKj6WrCPX3ljfjURW7BOc59sSu70+J31F6L23k1qANaJMCYrOkDkAAIlaaq3TXRXnGpJ5pUFbL5LnOLq/JUU72p8sbhkcoEv0QyQuNFvCjZvy9bg+ECC/UsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699423; c=relaxed/simple;
	bh=Nm+9CD2nPcl5umV5fVKARPQZiuoPeHnOb9ZJmZVWEh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJ8dID8UcKn+XbDeMXb2MyQKKpYeuhGR0v7vHUXbRCNoCGmnaTBrV+pII8h/VkAM/B42uIJBstG5yw30R11IJp+FSuJn+a68c3eJ/o/snNEYi76/+x+RkKc2/+u1Kknle6Ur3LZDVbMJyTkaP4yogSGA88ULVV33VY6epa8AmaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J75HbVh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF2EC4CEDF;
	Tue,  4 Feb 2025 20:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699421;
	bh=Nm+9CD2nPcl5umV5fVKARPQZiuoPeHnOb9ZJmZVWEh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J75HbVh6Z6LtCHxDgPbAvM8qYoJNn17MULK7JSB23zFtspT6Ek4PqU8tY5PjzCC/S
	 Ue8Vh/UCdPxYwaAALu1ASZ86wZgicJwvl9c9DXOGIuMctsdwmOOd2DY0IoNpp/fhLG
	 +P08uAgsrW7Apf8qSSVtuOCfyQNCBtfbb3dxYAZFoRNFUa7AmU8ZfEDwDONYhqaOXn
	 0ExAFu8wvCJNZ2c/o/S4DOUi/C6wGVjSn08/FggR3Sq5D4uVyti0eSepoRX+j4uZAT
	 XV1uGqSE0yoIEpOPmHKNTGKdsRq3Xpti/ypvPPHFuoyzQlCgZnqPihwL4VnwUiRRw2
	 QAIRM1cFW+I0Q==
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
Subject: [PATCH 08/27] iio: accel: adxl367: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:30 +0000
Message-ID: <20250204200250.636721-9-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204200250.636721-1-jic23@kernel.org>
References: <20250204200250.636721-1-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Cosmin Tanislav <demonsingur@gmail.com>
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


