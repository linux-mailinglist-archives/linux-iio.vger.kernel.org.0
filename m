Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F059A72E49E
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jun 2023 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242616AbjFMNuj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jun 2023 09:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242583AbjFMNuf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jun 2023 09:50:35 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BCCA6;
        Tue, 13 Jun 2023 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686664234;
  x=1718200234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XyLHca4d3J9CSl8Sc9yYWb/QTbf/Yaus43MFIh/G9So=;
  b=eO232TExgmpJTc58IqSUPJY5evEbJMgWdbKWx/DOyE3tV/gpFDacFM/e
   YBnF+v/GQYo2297n29amMSGhRXuVaQWSF5gs49nEd73JwIqbgUDBEqfkQ
   0hAnsmGrXJid3dEkT8Iu7LvnGt0/w7FoGoOnJqmf254ap9vwJrycwT43E
   sp30V5uEO6l3VcvbMzbU3FTbpuPKuMOlhewH4bf3wO05e2QYn6Uzvc5hx
   i0DYrvRBGqiQ3qLZP1LFnMNnh1Au248nAWeIbCswzYCgz3I19lWmkFf4P
   f1DOK3qONNHkzuA7If5IJmrpb/tlHwvodK0pFc9ThB33qMHfHxlOjiE5H
   A==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v6 7/8] iio: light: vcnl4000: Add oversampling_ratio for 4040/4200
Date:   Tue, 13 Jun 2023 15:50:23 +0200
Message-ID: <20230613135025.2596641-8-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230613135025.2596641-1-astrid.rost@axis.com>
References: <20230613135025.2596641-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the proximity multi pulse (PS_MPS) as oversampling_ratio.
Instead of one single pulse per every defined time frame, one can
program2, 4, or even 8 pulses. This leads to a longer IRED on-time
for each proximity measurement value, which also results in a higher
detection range.

Add read/write attribute for proximity oversampling-ratio and read
attribute for available oversampling-ratio.
This is supported for vcnl4040 and vcnl4200.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/iio/light/vcnl4000.c | 83 +++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 435bf57eb4c8..ebe9b5343bb3 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -61,6 +61,7 @@
 
 #define VCNL4200_AL_CONF	0x00 /* Ambient light configuration */
 #define VCNL4200_PS_CONF1	0x03 /* Proximity configuration */
+#define VCNL4200_PS_CONF3	0x04 /* Proximity configuration */
 #define VCNL4040_PS_THDL_LM	0x06 /* Proximity threshold low */
 #define VCNL4040_PS_THDH_LM	0x07 /* Proximity threshold high */
 #define VCNL4040_ALS_THDL_LM	0x02 /* Ambient light threshold low */
@@ -90,6 +91,7 @@
 #define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration time */
 #define VCNL4040_CONF1_PS_PERS	GENMASK(5, 4) /* Proximity interrupt persistence setting */
 #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mode */
+#define VCNL4040_PS_CONF3_MPS		GENMASK(6, 5) /* Proximity multi pulse number */
 #define VCNL4040_PS_IF_AWAY		BIT(8) /* Proximity event cross low threshold */
 #define VCNL4040_PS_IF_CLOSE		BIT(9) /* Proximity event cross high threshold */
 #define VCNL4040_ALS_RISING		BIT(12) /* Ambient Light cross high threshold */
@@ -158,6 +160,7 @@ static const int vcnl4200_als_it_times[][2] = {
 
 static const int vcnl4040_als_persistence[] = {1, 2, 4, 8};
 static const int vcnl4040_ps_persistence[] = {1, 2, 3, 4};
+static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
 
 #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
 
@@ -770,6 +773,53 @@ static ssize_t vcnl4040_write_ps_period(struct vcnl4000_data *data, int val, int
 	return ret;
 }
 
+static ssize_t vcnl4040_read_ps_oversampling_ratio(struct vcnl4000_data *data, int *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
+	if (ret < 0)
+		return ret;
+
+	ret = FIELD_GET(VCNL4040_PS_CONF3_MPS, ret);
+	if (ret >= ARRAY_SIZE(vcnl4040_ps_oversampling_ratio))
+		return -EINVAL;
+
+	*val = vcnl4040_ps_oversampling_ratio[ret];
+
+	return ret;
+}
+
+static ssize_t vcnl4040_write_ps_oversampling_ratio(struct vcnl4000_data *data, int val)
+{
+	unsigned int i;
+	int ret;
+	u16 regval;
+
+	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_oversampling_ratio); i++) {
+		if (val == vcnl4040_ps_oversampling_ratio[i])
+			break;
+	}
+
+	if (i >= ARRAY_SIZE(vcnl4040_ps_oversampling_ratio))
+		return -EINVAL;
+
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
+	if (ret < 0)
+		goto out_unlock;
+
+	regval = FIELD_PREP(VCNL4040_PS_CONF3_MPS, i);
+	regval |= (ret & ~VCNL4040_PS_CONF3_MPS);
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
+					regval);
+
+out_unlock:
+	mutex_unlock(&data->vcnl4000_lock);
+	return ret;
+}
+
 static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int *val, int *val2, long mask)
@@ -820,6 +870,16 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			ret = vcnl4040_read_ps_oversampling_ratio(data, val);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -843,6 +903,13 @@ static int vcnl4040_write_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			return vcnl4040_write_ps_oversampling_ratio(data, val);
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -871,6 +938,16 @@ static int vcnl4040_read_avail(struct iio_dev *indio_dev,
 		}
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			*vals = (int *)vcnl4040_ps_oversampling_ratio;
+			*length = ARRAY_SIZE(vcnl4040_ps_oversampling_ratio);
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1643,8 +1720,10 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
 	}, {
 		.type = IIO_PROXIMITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_INT_TIME),
-		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
+			BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.ext_info = vcnl4000_ext_info,
 		.event_spec = vcnl4040_event_spec,
 		.num_event_specs = ARRAY_SIZE(vcnl4040_event_spec),
-- 
2.30.2

