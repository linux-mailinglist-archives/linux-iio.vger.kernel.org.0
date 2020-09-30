Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EED327E319
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 09:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgI3H5m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 03:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3H5c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 03:57:32 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3817DC0613D2
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 00:57:32 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x16so614013pgj.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 00:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNjgwLzIscFwNfVVuDP0cWzptVOPdfQ1UdopMo5CJ/g=;
        b=WSa3WaMEFTZtxvFLG5x8A6AZXpelTVAY+ucWPP7iA/MiepvKOF1fzxfvGNmkAXH4FL
         1c75Waw0dSEQJSkjG8BTVxMgkYMrIFAAlt+ZaOlhK408PiN6Z357EF3ut7Vu0hlqp1x7
         myLVQgf8acvn382jegnJBiqWtMa5w4cpLesFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNjgwLzIscFwNfVVuDP0cWzptVOPdfQ1UdopMo5CJ/g=;
        b=tCwHRuPG1hxrEPgQuhlKIg1uXFaCAqYzjGfW3DX9JwZO7WRfZCd8I3XPDlTzmRA+mn
         5NJr6mZgLOBKcZqI+Yx1EpZOf434WnLxDR7o98HQAiLtxZJmwP6Yj6xpumJSxZCzY2v/
         ZH/srheAM5N2/8huYGU0vT+71ePNFnrNaETsanBfQOEhvg5udrfDOoz9h9Z/NouTUCAg
         O8Jvjz+lqR2LpZj5xWGOcx+x4SFFPt8VeOZN1km/rAAvnaHyUhGJB0guvkHIOT3kPLVm
         lypt81njtwmNT8++1Rq9AIgmmC9yeyFBjjLPgWN4fNC363a9hMl7K9JEvBL32UlLtfAZ
         QjTw==
X-Gm-Message-State: AOAM533qv7WfXI9YVLmNFRJjN4WeIQEtT/nT7q8TmGHU6g/huPJyD+EW
        f5WSSDjfkc+Ch00SlGXstc5+q2igeGxczw==
X-Google-Smtp-Source: ABdhPJxYUcsIgOKsd806QxJlrLf9IElOndRksw7p4VncTGkvxGkc+durkgyI8B2+WW+rySwdLcTYlQ==
X-Received: by 2002:a63:1cd:: with SMTP id 196mr1219943pgb.108.1601452651415;
        Wed, 30 Sep 2020 00:57:31 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id l21sm1272131pjq.54.2020.09.30.00.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 00:57:30 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 1/6] iio: sx9310: Support hardware gain factor
Date:   Wed, 30 Sep 2020 00:57:23 -0700
Message-Id: <20200930075728.2410327-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
In-Reply-To: <20200930075728.2410327-1-swboyd@chromium.org>
References: <20200930075728.2410327-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to set the hardware gain of the channels as a multiplier of
2x, 4x, or 8x.

Cc: Daniel Campello <campello@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 109 +++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 9d72d08ab9e7..030397a85845 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -16,6 +16,7 @@
 #include <linux/i2c.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
+#include <linux/log2.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pm.h>
@@ -51,7 +52,9 @@
 #define   SX9310_REG_PROX_CTRL2_COMBMODE_CS1_CS2	(0x02 << 6)
 #define   SX9310_REG_PROX_CTRL2_SHIELDEN_DYNAMIC	(0x01 << 2)
 #define SX9310_REG_PROX_CTRL3				0x13
+#define   SX9310_REG_PROX_CTRL3_GAIN0_MASK		GENMASK(3, 2)
 #define   SX9310_REG_PROX_CTRL3_GAIN0_X8		(0x03 << 2)
+#define   SX9310_REG_PROX_CTRL3_GAIN12_MASK		GENMASK(1, 0)
 #define   SX9310_REG_PROX_CTRL3_GAIN12_X4		0x02
 #define SX9310_REG_PROX_CTRL4				0x14
 #define   SX9310_REG_PROX_CTRL4_RESOLUTION_FINEST	0x07
@@ -145,15 +148,18 @@ static const struct iio_event_spec sx9310_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_VALUE),
 	},
 };
 
 #define SX9310_NAMED_CHANNEL(idx, name)					 \
 	{								 \
 		.type = IIO_PROXIMITY,					 \
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		 \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		 \
+				      BIT(IIO_CHAN_INFO_HARDWAREGAIN),   \
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_separate_available =				 \
+			BIT(IIO_CHAN_INFO_HARDWAREGAIN),		 \
 		.indexed = 1,						 \
 		.channel = idx,						 \
 		.extend_name = name,					 \
@@ -426,6 +432,34 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 	return ret;
 }
 
+static int sx9310_read_gain(struct sx9310_data *data,
+			    const struct iio_chan_spec *chan, int *val)
+{
+	unsigned int regval, gain;
+	int ret;
+
+	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL3, &regval);
+	if (ret)
+		return ret;
+
+	switch (chan->channel) {
+	case 0:
+	case 3:
+		gain = FIELD_GET(SX9310_REG_PROX_CTRL3_GAIN0_MASK, regval);
+		break;
+	case 1:
+	case 2:
+		gain = FIELD_GET(SX9310_REG_PROX_CTRL3_GAIN12_MASK, regval);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*val = 1 << gain;
+
+	return IIO_VAL_INT;
+}
+
 static int sx9310_read_samp_freq(struct sx9310_data *data, int *val, int *val2)
 {
 	unsigned int regval;
@@ -461,6 +495,14 @@ static int sx9310_read_raw(struct iio_dev *indio_dev,
 		ret = sx9310_read_proximity(data, chan, val);
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = sx9310_read_gain(data, chan, val);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return sx9310_read_samp_freq(data, val, val2);
 	default:
@@ -468,6 +510,27 @@ static int sx9310_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static const int sx9310_gain_vals[] = { 1, 2, 4, 8 };
+
+static int sx9310_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(sx9310_gain_vals);
+		*vals = sx9310_gain_vals;
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+
 static int sx9310_set_samp_freq(struct sx9310_data *data, int val, int val2)
 {
 	int i, ret;
@@ -492,6 +555,37 @@ static int sx9310_set_samp_freq(struct sx9310_data *data, int val, int val2)
 	return ret;
 }
 
+static int sx9310_write_gain(struct sx9310_data *data,
+			    const struct iio_chan_spec *chan, int val)
+{
+	unsigned int gain, mask;
+	int ret;
+
+	gain = ilog2(val);
+
+	switch (chan->channel) {
+	case 0:
+	case 3:
+		mask = SX9310_REG_PROX_CTRL3_GAIN0_MASK;
+		gain = FIELD_PREP(SX9310_REG_PROX_CTRL3_GAIN0_MASK, gain);
+		break;
+	case 1:
+	case 2:
+		mask = SX9310_REG_PROX_CTRL3_GAIN12_MASK;
+		gain = FIELD_PREP(SX9310_REG_PROX_CTRL3_GAIN12_MASK, gain);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL3, mask,
+				 gain);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
 static int sx9310_write_raw(struct iio_dev *indio_dev,
 			    const struct iio_chan_spec *chan, int val, int val2,
 			    long mask)
@@ -501,10 +595,14 @@ static int sx9310_write_raw(struct iio_dev *indio_dev,
 	if (chan->type != IIO_PROXIMITY)
 		return -EINVAL;
 
-	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
-		return -EINVAL;
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return sx9310_set_samp_freq(data, val, val2);
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		return sx9310_write_gain(data, chan, val);
+	}
 
-	return sx9310_set_samp_freq(data, val, val2);
+	return -EINVAL;
 }
 
 static irqreturn_t sx9310_irq_handler(int irq, void *private)
@@ -645,6 +743,7 @@ static const struct attribute_group sx9310_attribute_group = {
 static const struct iio_info sx9310_info = {
 	.attrs = &sx9310_attribute_group,
 	.read_raw = sx9310_read_raw,
+	.read_avail = sx9310_read_avail,
 	.write_raw = sx9310_write_raw,
 	.read_event_config = sx9310_read_event_config,
 	.write_event_config = sx9310_write_event_config,
-- 
Sent by a computer, using git, on the internet

