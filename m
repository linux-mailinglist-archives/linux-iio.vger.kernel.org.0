Return-Path: <linux-iio+bounces-1987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F88D83F60C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 16:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3A8284797
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 15:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C1024214;
	Sun, 28 Jan 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWx1focs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7494022EE8
	for <linux-iio@vger.kernel.org>; Sun, 28 Jan 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706454399; cv=none; b=CrmTDggfAqyL/C5Wv6hoDpIK6tyTCAn+YUz4sVTBkJB8kkx+BmCitSGQaLBVWFgRbp3D8SpDzmHOrp5x81RYd+MLs03YBNpAvBmA7hCrGTg+kQNb/jtY60wbM9ZZxm4knHQGf5YjUmVkLicEYn3TA673ljJQiI4kwghnbWtfwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706454399; c=relaxed/simple;
	bh=JElBofTTRu4v2f/E3YDsiJjbXkZbPCarGF2qYWsmb0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZavvoKoBiLquJIO+XMIzlIBLuk9zSWPCHc17dLgREm34QPE6mh2HBTMSBBTMHizean4YbCtE4Qo7ULX00Zz97urQaxlJjhuZ198qDbTSQiao7tinqHzRAyHVUgReQFoF1/r4mltwMXeAAzI68GIJsWAMGJBxpJymSCRo3T3TTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWx1focs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56124C433C7;
	Sun, 28 Jan 2024 15:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706454399;
	bh=JElBofTTRu4v2f/E3YDsiJjbXkZbPCarGF2qYWsmb0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWx1focstIauKPZ3gqu0yvhLR0G2G/e2gUu+YZ0iAblacsfNu/+pZJ9S30hlrDqaE
	 G7TbH2MbPfTe+lNw3qesfSQYrNDOHaGifq4t2UlAOc5S5WeVvq3J7DCQ+xKX9iy/m1
	 MVDA1GRXCsEBsG1z5U0e4CKkAWagxmNHPhZIyn6qXwWNUjfPahucF5n7uJIfZ1Ohyp
	 DavTWQDmbfPb3Dyyhw48exEKwJ6/58EkEyMCG6Bf71w1KKw3XZGfBkw3N8T5i+IytV
	 XKoQoJMmsjcwIRUMeNia0RgwqoYRUYJcAa1Li9NwIAcvWMCroUoTTHqVSOOUxWMoUK
	 s0kvc0t95V+aw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/10] iio: proximity: sx9324: Use automated cleanup for locks and IIO mode claiming.
Date: Sun, 28 Jan 2024 15:05:34 +0000
Message-ID: <20240128150537.44592-8-jic23@kernel.org>
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

This simplifies error handling paths and generallly removes a bunch
of boilerplate.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Since RFC:
 - Use unreachable() rather than return -EINVAL; to convince compiler
   that the code is really unreachable and stop it complaining.
 - Reduce scope of int ret in resume() callback.
---
 drivers/iio/proximity/sx9324.c | 109 ++++++++++++---------------------
 1 file changed, 39 insertions(+), 70 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index ac2ed2da21cc..3bf51bd2ec21 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -429,25 +429,16 @@ static int sx9324_read_raw(struct iio_dev *indio_dev,
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
+		unreachable();
 	case IIO_CHAN_INFO_HARDWAREGAIN:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = sx9324_read_gain(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return sx9324_read_gain(data, chan, val);
+		unreachable();
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return sx9324_read_samp_freq(data, val, val2);
 	default:
@@ -484,7 +475,7 @@ static int sx9324_read_avail(struct iio_dev *indio_dev,
 static int sx9324_set_samp_freq(struct sx_common_data *data,
 				int val, int val2)
 {
-	int i, ret;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sx9324_samp_freq_table); i++)
 		if (val == sx9324_samp_freq_table[i].val &&
@@ -494,15 +485,11 @@ static int sx9324_set_samp_freq(struct sx_common_data *data,
 	if (i == ARRAY_SIZE(sx9324_samp_freq_table))
 		return -EINVAL;
 
-	mutex_lock(&data->mutex);
-
-	ret = regmap_update_bits(data->regmap,
-				 SX9324_REG_GNRL_CTRL0,
-				 SX9324_REG_GNRL_CTRL0_SCANPERIOD_MASK, i);
+	guard(mutex)(&data->mutex);
 
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return regmap_update_bits(data->regmap,
+				  SX9324_REG_GNRL_CTRL0,
+				  SX9324_REG_GNRL_CTRL0_SCANPERIOD_MASK, i);
 }
 
 static int sx9324_read_thresh(struct sx_common_data *data,
@@ -623,7 +610,6 @@ static int sx9324_write_thresh(struct sx_common_data *data,
 			       const struct iio_chan_spec *chan, int _val)
 {
 	unsigned int reg, val = _val;
-	int ret;
 
 	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
 
@@ -633,11 +619,9 @@ static int sx9324_write_thresh(struct sx_common_data *data,
 	if (val > 0xff)
 		return -EINVAL;
 
-	mutex_lock(&data->mutex);
-	ret = regmap_write(data->regmap, reg, val);
-	mutex_unlock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	return ret;
+	return regmap_write(data->regmap, reg, val);
 }
 
 static int sx9324_write_hysteresis(struct sx_common_data *data,
@@ -662,18 +646,15 @@ static int sx9324_write_hysteresis(struct sx_common_data *data,
 		return -EINVAL;
 
 	hyst = FIELD_PREP(SX9324_REG_PROX_CTRL5_HYST_MASK, hyst);
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, SX9324_REG_PROX_CTRL5,
-				 SX9324_REG_PROX_CTRL5_HYST_MASK, hyst);
-	mutex_unlock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	return ret;
+	return regmap_update_bits(data->regmap, SX9324_REG_PROX_CTRL5,
+				  SX9324_REG_PROX_CTRL5_HYST_MASK, hyst);
 }
 
 static int sx9324_write_far_debounce(struct sx_common_data *data, int _val)
 {
 	unsigned int regval, val = _val;
-	int ret;
 
 	if (val > 0)
 		val = ilog2(val);
@@ -682,19 +663,16 @@ static int sx9324_write_far_debounce(struct sx_common_data *data, int _val)
 
 	regval = FIELD_PREP(SX9324_REG_PROX_CTRL5_FAR_DEBOUNCE_MASK, val);
 
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, SX9324_REG_PROX_CTRL5,
-				 SX9324_REG_PROX_CTRL5_FAR_DEBOUNCE_MASK,
-				 regval);
-	mutex_unlock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	return ret;
+	return regmap_update_bits(data->regmap, SX9324_REG_PROX_CTRL5,
+				  SX9324_REG_PROX_CTRL5_FAR_DEBOUNCE_MASK,
+				  regval);
 }
 
 static int sx9324_write_close_debounce(struct sx_common_data *data, int _val)
 {
 	unsigned int regval, val = _val;
-	int ret;
 
 	if (val > 0)
 		val = ilog2(val);
@@ -703,13 +681,11 @@ static int sx9324_write_close_debounce(struct sx_common_data *data, int _val)
 
 	regval = FIELD_PREP(SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK, val);
 
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, SX9324_REG_PROX_CTRL5,
-				 SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK,
-				 regval);
-	mutex_unlock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	return ret;
+	return regmap_update_bits(data->regmap, SX9324_REG_PROX_CTRL5,
+				  SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK,
+				  regval);
 }
 
 static int sx9324_write_event_val(struct iio_dev *indio_dev,
@@ -746,7 +722,6 @@ static int sx9324_write_gain(struct sx_common_data *data,
 			     const struct iio_chan_spec *chan, int val)
 {
 	unsigned int gain, reg;
-	int ret;
 
 	reg = SX9324_REG_PROX_CTRL0 + chan->channel / 2;
 
@@ -756,13 +731,11 @@ static int sx9324_write_gain(struct sx_common_data *data,
 
 	gain = FIELD_PREP(SX9324_REG_PROX_CTRL0_GAIN_MASK, gain);
 
-	mutex_lock(&data->mutex);
-	ret = regmap_update_bits(data->regmap, reg,
-				 SX9324_REG_PROX_CTRL0_GAIN_MASK,
-				 gain);
-	mutex_unlock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	return ret;
+	return regmap_update_bits(data->regmap, reg,
+				  SX9324_REG_PROX_CTRL0_GAIN_MASK,
+				  gain);
 }
 
 static int sx9324_write_raw(struct iio_dev *indio_dev,
@@ -1081,34 +1054,30 @@ static int sx9324_suspend(struct device *dev)
 
 	disable_irq_nosync(data->client->irq);
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	ret = regmap_read(data->regmap, SX9324_REG_GNRL_CTRL1, &regval);
+	if (ret < 0)
+		return ret;
 
 	data->suspend_ctrl =
 		FIELD_GET(SX9324_REG_GNRL_CTRL1_PHEN_MASK, regval);
 
-	if (ret < 0)
-		goto out;
 
 	/* Disable all phases, send the device to sleep. */
-	ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1, 0);
-
-out:
-	mutex_unlock(&data->mutex);
-	return ret;
+	return regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1, 0);
 }
 
 static int sx9324_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
-	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
-			   data->suspend_ctrl | SX9324_REG_GNRL_CTRL1_PAUSECTRL);
-	mutex_unlock(&data->mutex);
-	if (ret)
-		return ret;
+	scoped_guard(mutex, &data->mutex) {
+		int ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
+				       data->suspend_ctrl |
+				       SX9324_REG_GNRL_CTRL1_PAUSECTRL);
+		if (ret)
+			return ret;
+	}
 
 	enable_irq(data->client->irq);
 	return 0;
-- 
2.43.0


