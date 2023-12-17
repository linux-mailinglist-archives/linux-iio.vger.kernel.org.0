Return-Path: <linux-iio+bounces-1026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C789A816143
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 18:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FC91F22CA1
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5956346445;
	Sun, 17 Dec 2023 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIzHk2J+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E0B315B6
	for <linux-iio@vger.kernel.org>; Sun, 17 Dec 2023 17:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60577C433C8;
	Sun, 17 Dec 2023 17:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834581;
	bh=NE9q82KndZsXskbV6xRhOt07Df0JO9B3LlyEf52OKRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PIzHk2J+b0zKB3ucPeddITgTe4YLaO6Yhwf8PhJJYLqDLB4wEXakBgrrbWaaYYn7R
	 GiQFWw5XkmMIqM4tQVzE9hh0atvViMeYzfQ9WaOfTpRJtTeX5Z5SNJELBe9ZqQ2Lqv
	 ht9yh6quZy3pp7beN/KswcT7Qx4/Mta+y7HhnkI9p+jlJyfHmDmlnKb3cpZrTdW9mp
	 o7qwsDMt7xSM0pRr5mXn08h7lE3ZS4EZ0RaqR2SmPKeGnS5SYLgryugF0C6HNOGAEy
	 rK3OtMRFgCYz+VsHSTowQ4sdQR6wja35P20JfhM9S7Mb62yngdizEeHx3F7FV+6xFG
	 99ihQ0dNpUpXA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 06/10] iio: proximity: sx9360: Use automated cleanup for locks and IIO mode claiming.
Date: Sun, 17 Dec 2023 17:35:44 +0000
Message-ID: <20231217173548.112701-7-jic23@kernel.org>
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
 drivers/iio/proximity/sx9360.c | 111 +++++++++++----------------------
 1 file changed, 37 insertions(+), 74 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 2c4e14a4fe9f..3f894c276e25 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -322,25 +322,16 @@ static int sx9360_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct sx_common_data *data = iio_priv(indio_dev);
-	int ret;
 
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
-		ret = sx9360_read_gain(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return sx9360_read_gain(data, chan, val);
+		return -EINVAL;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return sx9360_read_samp_freq(data, val, val2);
 	default:
@@ -387,19 +378,15 @@ static int sx9360_read_avail(struct iio_dev *indio_dev,
 static int sx9360_set_samp_freq(struct sx_common_data *data,
 				int val, int val2)
 {
-	int ret, reg;
+	int reg;
 	__be16 buf;
 
 	reg = val * 8192 / SX9360_FOSC_HZ + val2 * 8192 / (SX9360_FOSC_MHZ);
 	buf = cpu_to_be16(reg);
-	mutex_lock(&data->mutex);
-
-	ret = regmap_bulk_write(data->regmap, SX9360_REG_GNRL_CTRL1, &buf,
-				sizeof(buf));
+	guard(mutex)(&data->mutex);
 
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return regmap_bulk_write(data->regmap, SX9360_REG_GNRL_CTRL1, &buf,
+				 sizeof(buf));
 }
 
 static int sx9360_read_thresh(struct sx_common_data *data, int *val)
@@ -510,7 +497,6 @@ static int sx9360_read_event_val(struct iio_dev *indio_dev,
 static int sx9360_write_thresh(struct sx_common_data *data, int _val)
 {
 	unsigned int val = _val;
-	int ret;
 
 	if (val >= 1)
 		val = int_sqrt(2 * val);
@@ -518,11 +504,8 @@ static int sx9360_write_thresh(struct sx_common_data *data, int _val)
 	if (val > 0xff)
 		return -EINVAL;
 
-	mutex_lock(&data->mutex);
-	ret = regmap_write(data->regmap, SX9360_REG_PROX_CTRL5, val);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	guard(mutex)(&data->mutex);
+	return regmap_write(data->regmap, SX9360_REG_PROX_CTRL5, val);
 }
 
 static int sx9360_write_hysteresis(struct sx_common_data *data, int _val)
@@ -546,18 +529,14 @@ static int sx9360_write_hysteresis(struct sx_common_data *data, int _val)
 		return -EINVAL;
 
 	hyst = FIELD_PREP(SX9360_REG_PROX_CTRL4_HYST_MASK, hyst);
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, SX9360_REG_PROX_CTRL4,
-				 SX9360_REG_PROX_CTRL4_HYST_MASK, hyst);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, SX9360_REG_PROX_CTRL4,
+				  SX9360_REG_PROX_CTRL4_HYST_MASK, hyst);
 }
 
 static int sx9360_write_far_debounce(struct sx_common_data *data, int _val)
 {
 	unsigned int regval, val = _val;
-	int ret;
 
 	if (val > 0)
 		val = ilog2(val);
@@ -566,19 +545,15 @@ static int sx9360_write_far_debounce(struct sx_common_data *data, int _val)
 
 	regval = FIELD_PREP(SX9360_REG_PROX_CTRL4_FAR_DEBOUNCE_MASK, val);
 
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, SX9360_REG_PROX_CTRL4,
-				 SX9360_REG_PROX_CTRL4_FAR_DEBOUNCE_MASK,
-				 regval);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, SX9360_REG_PROX_CTRL4,
+				  SX9360_REG_PROX_CTRL4_FAR_DEBOUNCE_MASK,
+				  regval);
 }
 
 static int sx9360_write_close_debounce(struct sx_common_data *data, int _val)
 {
 	unsigned int regval, val = _val;
-	int ret;
 
 	if (val > 0)
 		val = ilog2(val);
@@ -587,13 +562,10 @@ static int sx9360_write_close_debounce(struct sx_common_data *data, int _val)
 
 	regval = FIELD_PREP(SX9360_REG_PROX_CTRL4_CLOSE_DEBOUNCE_MASK, val);
 
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, SX9360_REG_PROX_CTRL4,
-				 SX9360_REG_PROX_CTRL4_CLOSE_DEBOUNCE_MASK,
-				 regval);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, SX9360_REG_PROX_CTRL4,
+				  SX9360_REG_PROX_CTRL4_CLOSE_DEBOUNCE_MASK,
+				  regval);
 }
 
 static int sx9360_write_event_val(struct iio_dev *indio_dev,
@@ -630,19 +602,15 @@ static int sx9360_write_gain(struct sx_common_data *data,
 			     const struct iio_chan_spec *chan, int val)
 {
 	unsigned int gain, reg;
-	int ret;
 
 	gain = ilog2(val);
 	reg = SX9360_REG_PROX_CTRL0_PHR + chan->channel;
 	gain = FIELD_PREP(SX9360_REG_PROX_CTRL0_GAIN_MASK, gain);
 
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, reg,
-				 SX9360_REG_PROX_CTRL0_GAIN_MASK,
-				 gain);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, reg,
+				  SX9360_REG_PROX_CTRL0_GAIN_MASK,
+				  gain);
 }
 
 static int sx9360_write_raw(struct iio_dev *indio_dev,
@@ -827,21 +795,17 @@ static int sx9360_suspend(struct device *dev)
 
 	disable_irq_nosync(data->client->irq);
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	ret = regmap_read(data->regmap, SX9360_REG_GNRL_CTRL0, &regval);
+	if (ret < 0)
+		return ret;
 
 	data->suspend_ctrl =
 		FIELD_GET(SX9360_REG_GNRL_CTRL0_PHEN_MASK, regval);
 
-	if (ret < 0)
-		goto out;
 
 	/* Disable all phases, send the device to sleep. */
-	ret = regmap_write(data->regmap, SX9360_REG_GNRL_CTRL0, 0);
-
-out:
-	mutex_unlock(&data->mutex);
-	return ret;
+	return regmap_write(data->regmap, SX9360_REG_GNRL_CTRL0, 0);
 }
 
 static int sx9360_resume(struct device *dev)
@@ -849,14 +813,13 @@ static int sx9360_resume(struct device *dev)
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, SX9360_REG_GNRL_CTRL0,
-				 SX9360_REG_GNRL_CTRL0_PHEN_MASK,
+	scoped_guard(mutex, &data->mutex) {
+		ret = regmap_update_bits(data->regmap, SX9360_REG_GNRL_CTRL0,
+					 SX9360_REG_GNRL_CTRL0_PHEN_MASK,
 				 data->suspend_ctrl);
-	mutex_unlock(&data->mutex);
-	if (ret)
-		return ret;
-
+		if (ret)
+			return ret;
+	}
 	enable_irq(data->client->irq);
 	return 0;
 }
-- 
2.43.0


