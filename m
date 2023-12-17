Return-Path: <linux-iio+bounces-1028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19E0816145
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 18:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A8A281346
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF80646537;
	Sun, 17 Dec 2023 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1q8WfMZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A646529
	for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2023 17:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25ACC433C8;
	Sun, 17 Dec 2023 17:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834585;
	bh=AtXfAer1Jh1YALW92R8+uOmFheDRTlYo3rN9ybQmrO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1q8WfMZ0RlpXl/S4UQH0F/xePPauxQpHVTpvmyfNnNtpxJzwktn6GCu+15JplLbo
	 FnzIzCW6Eg2PIneFPnDiUjywT4boUyIa6GSc227+dRHc/UcCdn3/iJVYoN5dIivXhX
	 zhC7ERrYTth+fzu7qFzHSfyur1G+Rk4Unl7De7+C/bs0WkfdYAtayILAJii+9uWqwl
	 6LGx/Zp7E0Eam3aztw0SeinEjOjJ7lTW8A7VC+V56WqpEOdV8OgCvbIEC5/y7/QO22
	 QV//EHSSHoLoN7oeQfKstqeAy38ABbLE1dEzIql5SkRtfUuS0pASd0P7d2CHoUYJss
	 ePxjwn+iQKP8g==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 08/10] iio: proximity: sx9310: Use automated cleanup for locks and IIO mode claiming.
Date: Sun, 17 Dec 2023 17:35:46 +0000
Message-ID: <20231217173548.112701-9-jic23@kernel.org>
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

This simplifies error handling paths and generallly removes a bunch
of boilerplate.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/sx9310.c | 114 +++++++++++----------------------
 1 file changed, 39 insertions(+), 75 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 0d230a0dff56..73e95b3e4770 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -337,28 +337,19 @@ static int sx9310_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct sx_common_data *data = iio_priv(indio_dev);
-	int ret;
 
 	if (chan->type != IIO_PROXIMITY)
 		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = sx_common_read_proximity(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return sx_common_read_proximity(data, chan, val);
+		return -EINVAL;
 	case IIO_CHAN_INFO_HARDWAREGAIN:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = sx9310_read_gain(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return sx9310_read_gain(data, chan, val);
+		return -EINVAL;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return sx9310_read_samp_freq(data, val, val2);
 	default:
@@ -546,12 +537,10 @@ static int sx9310_write_thresh(struct sx_common_data *data,
 		return -EINVAL;
 
 	regval = FIELD_PREP(SX9310_REG_PROX_CTRL8_9_PTHRESH_MASK, regval);
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, reg,
-				 SX9310_REG_PROX_CTRL8_9_PTHRESH_MASK, regval);
-	mutex_unlock(&data->mutex);
 
-	return ret;
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, reg,
+				  SX9310_REG_PROX_CTRL8_9_PTHRESH_MASK, regval);
 }
 
 static int sx9310_write_hysteresis(struct sx_common_data *data,
@@ -576,17 +565,14 @@ static int sx9310_write_hysteresis(struct sx_common_data *data,
 		return -EINVAL;
 
 	hyst = FIELD_PREP(SX9310_REG_PROX_CTRL10_HYST_MASK, hyst);
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL10,
-				 SX9310_REG_PROX_CTRL10_HYST_MASK, hyst);
-	mutex_unlock(&data->mutex);
 
-	return ret;
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL10,
+				  SX9310_REG_PROX_CTRL10_HYST_MASK, hyst);
 }
 
 static int sx9310_write_far_debounce(struct sx_common_data *data, int val)
 {
-	int ret;
 	unsigned int regval;
 
 	if (val > 0)
@@ -596,18 +582,14 @@ static int sx9310_write_far_debounce(struct sx_common_data *data, int val)
 
 	regval = FIELD_PREP(SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK, val);
 
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL10,
-				 SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK,
-				 regval);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL10,
+				  SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_MASK,
+				  regval);
 }
 
 static int sx9310_write_close_debounce(struct sx_common_data *data, int val)
 {
-	int ret;
 	unsigned int regval;
 
 	if (val > 0)
@@ -617,13 +599,10 @@ static int sx9310_write_close_debounce(struct sx_common_data *data, int val)
 
 	regval = FIELD_PREP(SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK, val);
 
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL10,
-				 SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK,
-				 regval);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL10,
+				  SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_MASK,
+				  regval);
 }
 
 static int sx9310_write_event_val(struct iio_dev *indio_dev,
@@ -658,7 +637,7 @@ static int sx9310_write_event_val(struct iio_dev *indio_dev,
 
 static int sx9310_set_samp_freq(struct sx_common_data *data, int val, int val2)
 {
-	int i, ret;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sx9310_samp_freq_table); i++)
 		if (val == sx9310_samp_freq_table[i].val &&
@@ -668,23 +647,17 @@ static int sx9310_set_samp_freq(struct sx_common_data *data, int val, int val2)
 	if (i == ARRAY_SIZE(sx9310_samp_freq_table))
 		return -EINVAL;
 
-	mutex_lock(&data->mutex);
-
-	ret = regmap_update_bits(
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(
 		data->regmap, SX9310_REG_PROX_CTRL0,
 		SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK,
 		FIELD_PREP(SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK, i));
-
-	mutex_unlock(&data->mutex);
-
-	return ret;
 }
 
 static int sx9310_write_gain(struct sx_common_data *data,
 			     const struct iio_chan_spec *chan, int val)
 {
 	unsigned int gain, mask;
-	int ret;
 
 	gain = ilog2(val);
 
@@ -703,12 +676,9 @@ static int sx9310_write_gain(struct sx_common_data *data,
 		return -EINVAL;
 	}
 
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL3, mask,
-				 gain);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL3, mask,
+				  gain);
 }
 
 static int sx9310_write_raw(struct iio_dev *indio_dev,
@@ -969,22 +939,18 @@ static int sx9310_suspend(struct device *dev)
 
 	disable_irq_nosync(data->client->irq);
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0,
 			  &data->suspend_ctrl);
 	if (ret)
-		goto out;
+		return ret;
 
 	ctrl0 = data->suspend_ctrl & ~SX9310_REG_PROX_CTRL0_SENSOREN_MASK;
 	ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0, ctrl0);
 	if (ret)
-		goto out;
-
-	ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 0);
+		return ret;
 
-out:
-	mutex_unlock(&data->mutex);
-	return ret;
+	return regmap_write(data->regmap, SX9310_REG_PAUSE, 0);
 }
 
 static int sx9310_resume(struct device *dev)
@@ -992,18 +958,16 @@ static int sx9310_resume(struct device *dev)
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 1);
-	if (ret)
-		goto out;
-
-	ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
-			   data->suspend_ctrl);
+	scoped_guard(mutex, &data->mutex) {
+		ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 1);
+		if (ret)
+			return ret;
 
-out:
-	mutex_unlock(&data->mutex);
-	if (ret)
-		return ret;
+		ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
+				   data->suspend_ctrl);
+		if (ret)
+			return ret;
+	}
 
 	enable_irq(data->client->irq);
 	return 0;
-- 
2.43.0


