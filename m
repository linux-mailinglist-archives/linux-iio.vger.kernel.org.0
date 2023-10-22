Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC78E7D23C4
	for <lists+linux-iio@lfdr.de>; Sun, 22 Oct 2023 17:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjJVPr7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Oct 2023 11:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjJVPr6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Oct 2023 11:47:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A90FF7
        for <linux-iio@vger.kernel.org>; Sun, 22 Oct 2023 08:47:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB93CC433C9;
        Sun, 22 Oct 2023 15:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989675;
        bh=9wqXg8cQsOo9A/EsCktbjIJgvdnUnkxzxOMTxc/KuOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvIwpDKBmGxyDu9fY30Dtzao8RGaGL79LEzhvErz9fjSY+gIfeu5l3HrWq65xoTzu
         U2w3uDKGwFeHSio8LMobe+S3Twjyd5RVgUo6Gs/0NVnRTxXINPMo+CBrWLTVGyUx94
         Rvfuk8rCWVGyZzVHpdepaBdfZKSjbmoXSV+aGofF479w1jMnWt0ifReV2YHHB/+zEl
         n1idN68N7oSD4Wkl3kwD61a9HewN39lsdYobV4Lx+nktG2uejS4jR0PAHuwYmUhfcb
         QIXUQUH/tUr01J/4ECG1zP1wlJ5RgbKrdy+6N+O9lyEEHBClT4rKLCUjXvzeJbTcHD
         CF2vrpIMUEyUQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 8/8] iio: proximity: sx9310: Use automated cleanup for locks and IIO mode claiming.
Date:   Sun, 22 Oct 2023 16:47:10 +0100
Message-ID: <20231022154710.402590-9-jic23@kernel.org>
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
 drivers/iio/proximity/sx9310.c | 120 +++++++++++++--------------------
 1 file changed, 45 insertions(+), 75 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 0d230a0dff56..5e5436791550 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -337,28 +337,25 @@ static int sx9310_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct sx_common_data *data = iio_priv(indio_dev);
-	int ret;
 
 	if (chan->type != IIO_PROXIMITY)
 		return -EINVAL;
 
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
 
-		ret = sx9310_read_gain(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		return sx9310_read_gain(data, chan, val);
+	}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return sx9310_read_samp_freq(data, val, val2);
 	default:
@@ -546,12 +543,10 @@ static int sx9310_write_thresh(struct sx_common_data *data,
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
@@ -576,17 +571,14 @@ static int sx9310_write_hysteresis(struct sx_common_data *data,
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
@@ -596,18 +588,14 @@ static int sx9310_write_far_debounce(struct sx_common_data *data, int val)
 
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
@@ -617,13 +605,10 @@ static int sx9310_write_close_debounce(struct sx_common_data *data, int val)
 
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
@@ -658,7 +643,7 @@ static int sx9310_write_event_val(struct iio_dev *indio_dev,
 
 static int sx9310_set_samp_freq(struct sx_common_data *data, int val, int val2)
 {
-	int i, ret;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sx9310_samp_freq_table); i++)
 		if (val == sx9310_samp_freq_table[i].val &&
@@ -668,23 +653,17 @@ static int sx9310_set_samp_freq(struct sx_common_data *data, int val, int val2)
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
 
@@ -703,12 +682,9 @@ static int sx9310_write_gain(struct sx_common_data *data,
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
@@ -969,22 +945,18 @@ static int sx9310_suspend(struct device *dev)
 
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
@@ -992,18 +964,16 @@ static int sx9310_resume(struct device *dev)
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
2.42.0

