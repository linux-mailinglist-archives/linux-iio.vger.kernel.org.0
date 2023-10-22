Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7776E7D23C2
	for <lists+linux-iio@lfdr.de>; Sun, 22 Oct 2023 17:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjJVPrw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Oct 2023 11:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJVPrv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Oct 2023 11:47:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D976119
        for <linux-iio@vger.kernel.org>; Sun, 22 Oct 2023 08:47:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33199C433C8;
        Sun, 22 Oct 2023 15:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989669;
        bh=yJG6XlJVyHvABi/sFVtX1o0sGf5yohgtyqcERFiv0nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hGbBPucrVMua6ofbLLi40mDizyH83d8Bi+2rov5lJHM88jlfCJnaMlwAmWhKqP9X1
         90iEXp3T9kzp87cV8EW6FL8KEBoRVe57EyVHqXZnUCEtB/9dJKLMlG6Rvyk3vnRytC
         5CwvtuT81BlQsfeAORn1AecUVgCa7wvaNipl5cVj6uWTJzepznmZ5HjFVpyUt7xtzH
         SCcg5nWZIhyFiLo5v23J/qM7BTXq9mxLXwu1oiZVb+t60d4Os5x8id+IrpBqyoYCRv
         nHXy9l8+dCHZmowJThS/9RxD3R+/260DgZN8EXloA1KeBKZfoKmFN/yPjxIuV6flJI
         dDFZ0slx2OkKg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 6/8] iio: proximity: sx9360: Use automated cleanup for locks and IIO mode claiming.
Date:   Sun, 22 Oct 2023 16:47:08 +0100
Message-ID: <20231022154710.402590-7-jic23@kernel.org>
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

This simplifies error handling paths and generallly removes a bunch
of boilerplate.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/sx9360.c | 117 ++++++++++++---------------------
 1 file changed, 43 insertions(+), 74 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 2c4e14a4fe9f..1ffb1abd1bfa 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -322,25 +322,22 @@ static int sx9360_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct sx_common_data *data = iio_priv(indio_dev);
-	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+	case IIO_CHAN_INFO_RAW: {
+		CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+		if (IS_ERR(claimed_dev))
+			return PTR_ERR(claimed_dev);
 
-		ret = sx_common_read_proximity(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
-	case IIO_CHAN_INFO_HARDWAREGAIN:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		return sx_common_read_proximity(data, chan, val);
+	}
+	case IIO_CHAN_INFO_HARDWAREGAIN: {
+		CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+		if (IS_ERR(claimed_dev))
+			return PTR_ERR(claimed_dev);
 
-		ret = sx9360_read_gain(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		return sx9360_read_gain(data, chan, val);
+	}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return sx9360_read_samp_freq(data, val, val2);
 	default:
@@ -387,19 +384,15 @@ static int sx9360_read_avail(struct iio_dev *indio_dev,
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
-
-	mutex_unlock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	return ret;
+	return regmap_bulk_write(data->regmap, SX9360_REG_GNRL_CTRL1, &buf,
+				 sizeof(buf));
 }
 
 static int sx9360_read_thresh(struct sx_common_data *data, int *val)
@@ -510,7 +503,6 @@ static int sx9360_read_event_val(struct iio_dev *indio_dev,
 static int sx9360_write_thresh(struct sx_common_data *data, int _val)
 {
 	unsigned int val = _val;
-	int ret;
 
 	if (val >= 1)
 		val = int_sqrt(2 * val);
@@ -518,11 +510,8 @@ static int sx9360_write_thresh(struct sx_common_data *data, int _val)
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
@@ -546,18 +535,14 @@ static int sx9360_write_hysteresis(struct sx_common_data *data, int _val)
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
@@ -566,19 +551,15 @@ static int sx9360_write_far_debounce(struct sx_common_data *data, int _val)
 
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
@@ -587,13 +568,10 @@ static int sx9360_write_close_debounce(struct sx_common_data *data, int _val)
 
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
@@ -630,19 +608,15 @@ static int sx9360_write_gain(struct sx_common_data *data,
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
@@ -827,21 +801,17 @@ static int sx9360_suspend(struct device *dev)
 
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
@@ -849,14 +819,13 @@ static int sx9360_resume(struct device *dev)
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
2.42.0

