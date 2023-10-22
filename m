Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6318D7D23C3
	for <lists+linux-iio@lfdr.de>; Sun, 22 Oct 2023 17:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjJVPrz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Oct 2023 11:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJVPry (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Oct 2023 11:47:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406C6119
        for <linux-iio@vger.kernel.org>; Sun, 22 Oct 2023 08:47:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB99C433C7;
        Sun, 22 Oct 2023 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989671;
        bh=+SQsrLCdxlw//cpxE3xuFOqFbUs7eUtqjxntK/NqY6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dpKynJu/aEOVST5cyDHRqlcW6BVG3C5JaBo4Wo9NFJ1pZ+Hl/6Dkb7MGMHG+iHZ0x
         ZaZAI8RJDRImKkKao3Bu1JDgcFXb2mSvCHxmlxBr/1ADn7bCHxdCiSvX8KK0U4zRz7
         YJMoaF1b42naCQkd/BWKIY49gYEhjH/RcI8w7k6Qh+iq6ZQJ+67xJ2OuJ6uFMar4y3
         BFltjh918FwDBSNNmlkCOwMtjccMxYqAtqmH56oXzCFExR2aVE+iusXiAv6z6vvKHc
         26KAj2V4UaVTGkV5SNoS3OYd+SUczihZQSawxTn4x/TAgbyEtcQHCZTEQmxAPWLO8k
         /oSn9l6YMxXIQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 7/8] iio: proximity: sx9324: Use automated cleanup for locks and IIO mode claiming.
Date:   Sun, 22 Oct 2023 16:47:09 +0100
Message-ID: <20231022154710.402590-8-jic23@kernel.org>
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
 drivers/iio/proximity/sx9324.c | 113 +++++++++++++--------------------
 1 file changed, 44 insertions(+), 69 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index ac2ed2da21cc..836feb6ae0c4 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -429,25 +429,22 @@ static int sx9324_read_raw(struct iio_dev *indio_dev,
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
 
-		ret = sx9324_read_gain(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		return sx9324_read_gain(data, chan, val);
+	}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return sx9324_read_samp_freq(data, val, val2);
 	default:
@@ -484,7 +481,7 @@ static int sx9324_read_avail(struct iio_dev *indio_dev,
 static int sx9324_set_samp_freq(struct sx_common_data *data,
 				int val, int val2)
 {
-	int i, ret;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sx9324_samp_freq_table); i++)
 		if (val == sx9324_samp_freq_table[i].val &&
@@ -494,15 +491,11 @@ static int sx9324_set_samp_freq(struct sx_common_data *data,
 	if (i == ARRAY_SIZE(sx9324_samp_freq_table))
 		return -EINVAL;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	ret = regmap_update_bits(data->regmap,
-				 SX9324_REG_GNRL_CTRL0,
-				 SX9324_REG_GNRL_CTRL0_SCANPERIOD_MASK, i);
-
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return regmap_update_bits(data->regmap,
+				  SX9324_REG_GNRL_CTRL0,
+				  SX9324_REG_GNRL_CTRL0_SCANPERIOD_MASK, i);
 }
 
 static int sx9324_read_thresh(struct sx_common_data *data,
@@ -623,7 +616,6 @@ static int sx9324_write_thresh(struct sx_common_data *data,
 			       const struct iio_chan_spec *chan, int _val)
 {
 	unsigned int reg, val = _val;
-	int ret;
 
 	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
 
@@ -633,11 +625,9 @@ static int sx9324_write_thresh(struct sx_common_data *data,
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
@@ -662,18 +652,15 @@ static int sx9324_write_hysteresis(struct sx_common_data *data,
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
@@ -682,19 +669,16 @@ static int sx9324_write_far_debounce(struct sx_common_data *data, int _val)
 
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
@@ -703,13 +687,11 @@ static int sx9324_write_close_debounce(struct sx_common_data *data, int _val)
 
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
@@ -746,7 +728,6 @@ static int sx9324_write_gain(struct sx_common_data *data,
 			     const struct iio_chan_spec *chan, int val)
 {
 	unsigned int gain, reg;
-	int ret;
 
 	reg = SX9324_REG_PROX_CTRL0 + chan->channel / 2;
 
@@ -756,13 +737,11 @@ static int sx9324_write_gain(struct sx_common_data *data,
 
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
@@ -1081,21 +1060,17 @@ static int sx9324_suspend(struct device *dev)
 
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
@@ -1103,12 +1078,12 @@ static int sx9324_resume(struct device *dev)
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
-			   data->suspend_ctrl | SX9324_REG_GNRL_CTRL1_PAUSECTRL);
-	mutex_unlock(&data->mutex);
-	if (ret)
-		return ret;
+	scoped_guard(mutex, &data->mutex) {
+		ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
+				   data->suspend_ctrl | SX9324_REG_GNRL_CTRL1_PAUSECTRL);
+		if (ret)
+			return ret;
+	}
 
 	enable_irq(data->client->irq);
 	return 0;
-- 
2.42.0

