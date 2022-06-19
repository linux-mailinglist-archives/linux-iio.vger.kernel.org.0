Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B311550CA1
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 20:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbiFSS7b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 14:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbiFSS7N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 14:59:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4E6BC8F
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 11:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D198561133
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 18:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441C1C3411D;
        Sun, 19 Jun 2022 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655665151;
        bh=62EvVMErAr7EUA1hz/IbWeQpjno50IHYaNuFObwdW0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kh2fufQlCUhfjjtNwRxJjvUXHfwXRDGgyaAv7CpTaIXA8qiqiaHM1Xvmoc/6Nmh6d
         ropDK8h8sYd96ZebAliT1ON4dwhX57hhVbCpc0SR6RVT/47oI8Nyj1i/zhu9s1VFtz
         FLV/S8Lrhp6X9ICd+6A0ezIGs6O4ireZw6k3HsiZz0ubd6iFPamvnnFg05Oq17dOPR
         rVcqVhH7Cn1pinTpr0yd5GNfqdsAHFOJQoAQ601br4scRlbIZMfbDO9Hf4R6KfV70m
         aofDqhe1d0swe8g16CMf+cjaq0MAZzVje8MzoMlu/pVBvoRggShr9F930r0EMSsmKq
         WFV9MXLW0pQyw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 07/17] staging: iio: cdc: ad7764: Push locking down into case statements in read/write_raw
Date:   Sun, 19 Jun 2022 19:58:29 +0100
Message-Id: <20220619185839.1363503-8-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220619185839.1363503-1-jic23@kernel.org>
References: <20220619185839.1363503-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Not all paths require any locking at all. So to simplify the
removal of such locking push the locks down into the individual
case statements.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 125 ++++++++++++++-----------------
 1 file changed, 58 insertions(+), 67 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index bf20c14f60e4..41d9ea4ccb02 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -418,14 +418,10 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 	struct ad7746_chip_info *chip = iio_priv(indio_dev);
 	int ret, reg;
 
-	mutex_lock(&chip->lock);
-
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBSCALE:
-		if (val != 1) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (val != 1)
+			return -EINVAL;
 
 		val = (val2 * 1024) / 15625;
 
@@ -437,33 +433,31 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 			reg = AD7746_REG_VOLT_GAINH;
 			break;
 		default:
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 
+		mutex_lock(&chip->lock);
 		ret = i2c_smbus_write_word_swapped(chip->client, reg, val);
+		mutex_unlock(&chip->lock);
 		if (ret < 0)
-			goto out;
+			return ret;
 
-		ret = 0;
-		break;
+		return 0;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		if (val < 0 || val > 0xFFFF) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (val < 0 || val > 0xFFFF)
+			return -EINVAL;
+
+		mutex_lock(&chip->lock);
 		ret = i2c_smbus_write_word_swapped(chip->client,
 						   AD7746_REG_CAP_OFFH, val);
+		mutex_unlock(&chip->lock);
 		if (ret < 0)
-			goto out;
+			return ret;
 
-		ret = 0;
-		break;
+		return 0;
 	case IIO_CHAN_INFO_OFFSET:
-		if (val < 0 || val > 43008000) { /* 21pF */
-			ret = -EINVAL;
-			goto out;
-		}
+		if (val < 0 || val > 43008000) /* 21pF */
+			return -EINVAL;
 
 		/*
 		 * CAPDAC Scale = 21pF_typ / 127
@@ -472,34 +466,43 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 		 */
 
 		val /= 338646;
-
+		mutex_lock(&chip->lock);
 		chip->capdac[chan->channel][chan->differential] = val > 0 ?
 			AD7746_CAPDAC_DACP(val) | AD7746_CAPDAC_DACEN : 0;
 
 		ret = ad7746_set_capdac(chip, chan->channel);
-		if (ret < 0)
-			goto out;
+		if (ret < 0) {
+			mutex_unlock(&chip->lock);
+			return ret;
+		}
 
 		chip->capdac_set = chan->channel;
+		mutex_unlock(&chip->lock);
 
-		ret = 0;
-		break;
+		return 0;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val2) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (val2)
+			return -EINVAL;
 
 		switch (chan->type) {
 		case IIO_CAPACITANCE:
+			mutex_lock(&chip->lock);
 			ret = ad7746_store_cap_filter_rate_setup(chip, val);
-			break;
+			mutex_unlock(&chip->lock);
+			return ret;
 		case IIO_VOLTAGE:
+			mutex_lock(&chip->lock);
 			ret = ad7746_store_vt_filter_rate_setup(chip, val);
-			break;
+			mutex_unlock(&chip->lock);
+			return ret;
 		default:
-			ret = -EINVAL;
+			return -EINVAL;
 		}
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ad7746_read_channel(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int *val)
@@ -552,17 +555,16 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 	int ret, idx;
 	u8 reg;
 
-	mutex_lock(&chip->lock);
-
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
+		mutex_lock(&chip->lock);
 		ret = ad7746_read_channel(indio_dev, chan, val);
+		mutex_unlock(&chip->lock);
 		if (ret < 0)
-			goto out;
+			return ret;
 
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBSCALE:
 		switch (chan->type) {
 		case IIO_CAPACITANCE:
@@ -572,80 +574,69 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 			reg = AD7746_REG_VOLT_GAINH;
 			break;
 		default:
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 
+		mutex_lock(&chip->lock);
 		ret = i2c_smbus_read_word_swapped(chip->client, reg);
+		mutex_unlock(&chip->lock);
 		if (ret < 0)
-			goto out;
+			return ret;
 		/* 1 + gain_val / 2^16 */
 		*val = 1;
 		*val2 = (15625 * ret) / 1024;
 
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
+		mutex_lock(&chip->lock);
 		ret = i2c_smbus_read_word_swapped(chip->client,
 						  AD7746_REG_CAP_OFFH);
+		mutex_unlock(&chip->lock);
 		if (ret < 0)
-			goto out;
+			return ret;
 		*val = ret;
 
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = AD7746_CAPDAC_DACP(chip->capdac[chan->channel]
 					  [chan->differential]) * 338646;
 
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_CAPACITANCE:
 			/* 8.192pf / 2^24 */
 			*val =  0;
 			*val2 = 488;
-			ret = IIO_VAL_INT_PLUS_NANO;
-			break;
+			return IIO_VAL_INT_PLUS_NANO;
 		case IIO_VOLTAGE:
 			/* 1170mV / 2^23 */
 			*val = 1170;
 			if (chan->channel == 1)
 				*val *= 6;
 			*val2 = 23;
-			ret = IIO_VAL_FRACTIONAL_LOG2;
-			break;
+			return IIO_VAL_FRACTIONAL_LOG2;
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-
-		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (chan->type) {
 		case IIO_CAPACITANCE:
 			idx = (chip->config & AD7746_CONF_CAPFS_MASK) >>
 				AD7746_CONF_CAPFS_SHIFT;
 			*val = ad7746_cap_filter_rate_table[idx][0];
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		case IIO_VOLTAGE:
 			idx = (chip->config & AD7746_CONF_VTFS_MASK) >>
 				AD7746_CONF_VTFS_SHIFT;
 			*val = ad7746_vt_filter_rate_table[idx][0];
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		default:
-			ret = -EINVAL;
+			return -EINVAL;
 		}
-		break;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-out:
-	mutex_unlock(&chip->lock);
-	return ret;
 }
 
 static const struct iio_info ad7746_info = {
-- 
2.36.1

