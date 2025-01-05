Return-Path: <linux-iio+bounces-13907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A76CA01ADD
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25773A2EF1
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2A165F13;
	Sun,  5 Jan 2025 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNuCNkEj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B18F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098004; cv=none; b=U7o3eq9hIH7GbP3HPezu9rO4PBD/JBNqvTG95WUG2kNW4uUkm5x9NiFB9kUIQRkNGP9Abo7wLH6D7Vham2El+5ejD4kcEOjmLmEypxJNvqc20v2jXQVSf/kzhBWlEsVaijB0unrRNwJEpU+C/jB/XXYyL/i/TZzGrL9xYllJ1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098004; c=relaxed/simple;
	bh=iG6L6cXGESzrWrgcvBGtR9H+em9f1BXhQCTTSs4lXy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqzWCJKX7nTHCv78FAeFrCts25JoDmmGoCKrpLr/nKQ3xUPXxxrRc6ye06lt21xNeHaGU0EkZfM89bSMkLkCxqLwn8o0u97X3qREPL0iWZcS2w8BNvgubIPLf68VW1DXoieXm361aci/iWg4A4kJ6I5Ev48H/sof7hxrauMVG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNuCNkEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DA7C4CEDD;
	Sun,  5 Jan 2025 17:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098004;
	bh=iG6L6cXGESzrWrgcvBGtR9H+em9f1BXhQCTTSs4lXy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TNuCNkEj+ehcOHSN0/OJnR8brQ399FmZkkcA3xcy96qd55Fw+97BYs0taDEMVd14y
	 iUk56ltJzC99CLqABFmzE0TRZpS1yDTU24YxFvkrg8ledvXHT1+6XZkSIUPX+kwwu8
	 9ToYAJ1HB4IHHHRxnMXU2nsnla4loeW6R/0sBgbpWtHbOuV+tc9Bde95Z7xF3R80Sj
	 B5B1buKjVj2JalFqjcPXhQV5QsGRkatqPIiwQMAMIjFNg2z1PhXwjiUHBupNHIBdb2
	 jTtMaz0hVOXQ6u2yVO74jx8HMXiQ8tNakdZo2Enduoo/VvBtuDWS1VpgET++RvZEcH
	 KVih85t9rIFTA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 08/27] iio: accel: adxl367: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:25:53 +0000
Message-ID: <20250105172613.1204781-9-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105172613.1204781-1-jic23@kernel.org>
References: <20250105172613.1204781-1-jic23@kernel.org>
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
2.47.1


