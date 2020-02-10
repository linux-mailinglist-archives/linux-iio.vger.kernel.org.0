Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490EA1585C8
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 23:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgBJWyw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 17:54:52 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:37310 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBJWyw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Feb 2020 17:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581375290; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=RoEUjYGHpDWYkMI9Sm+5cUiTPPmHHbR6p6+DPe39ywI=;
        b=vOzpa76uGng09tyiI6jDNsvMN3DQ6r4XgbmP8soXBH4ArPlaQ2u17UOY+6wfd+HGKwyNtv
        ajUbea1/oIItj9jGa3PsxZHCNFRuF2K2mtSlZjxhJByGU2zdJBlg6sn+mSrt1/cuZ2NtUS
        6njlIxfU8GyAZPfu1nB6ACRtD42Qhto=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>
Cc:     od@zcrc.me, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] iio: afe: rescale: Add support for converting scale avail table
Date:   Mon, 10 Feb 2020 19:54:37 -0300
Message-Id: <20200210225438.112660-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the IIO channel has a scale_available attribute, we want the values
contained to be properly converted the same way the scale value is.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/afe/iio-rescale.c | 125 ++++++++++++++++++++++++++++------
 1 file changed, 103 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index e9ceee66d1e7..95802d9ee25e 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -31,14 +31,45 @@ struct rescale {
 	struct iio_chan_spec_ext_info *ext_info;
 	s32 numerator;
 	s32 denominator;
+	int scale_type, scale_len;
+	int *scale_data;
 };
 
+static int rescale_convert(struct rescale *rescale, int type,
+			   const int val, const int val2,
+			   int *val_out, int *val2_out)
+{
+	unsigned long long tmp;
+
+	switch (type) {
+	case IIO_VAL_FRACTIONAL:
+		*val_out = val * rescale->numerator;
+		*val2_out = val2 * rescale->denominator;
+		return type;
+	case IIO_VAL_INT:
+		*val_out = val * rescale->numerator;
+		if (rescale->denominator == 1)
+			return type;
+		*val2_out = rescale->denominator;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_VAL_FRACTIONAL_LOG2:
+		tmp = val * 1000000000LL;
+		do_div(tmp, rescale->denominator);
+		tmp *= rescale->numerator;
+		do_div(tmp, 1000000000LL);
+		*val_out = tmp;
+		*val2_out = val2;
+		return type;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int rescale_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
-	unsigned long long tmp;
 	int ret;
 
 	switch (mask) {
@@ -47,27 +78,7 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_SCALE:
 		ret = iio_read_channel_scale(rescale->source, val, val2);
-		switch (ret) {
-		case IIO_VAL_FRACTIONAL:
-			*val *= rescale->numerator;
-			*val2 *= rescale->denominator;
-			return ret;
-		case IIO_VAL_INT:
-			*val *= rescale->numerator;
-			if (rescale->denominator == 1)
-				return ret;
-			*val2 = rescale->denominator;
-			return IIO_VAL_FRACTIONAL;
-		case IIO_VAL_FRACTIONAL_LOG2:
-			tmp = *val * 1000000000LL;
-			do_div(tmp, rescale->denominator);
-			tmp *= rescale->numerator;
-			do_div(tmp, 1000000000LL);
-			*val = tmp;
-			return ret;
-		default:
-			return -EOPNOTSUPP;
-		}
+		return rescale_convert(rescale, ret, *val, *val2, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -85,6 +96,14 @@ static int rescale_read_avail(struct iio_dev *indio_dev,
 		*type = IIO_VAL_INT;
 		return iio_read_avail_channel_raw(rescale->source,
 						  vals, length);
+	case IIO_CHAN_INFO_SCALE:
+		if (rescale->scale_len) {
+			*type = rescale->scale_type;
+			*length = rescale->scale_len;
+			*vals = rescale->scale_data;
+			return IIO_AVAIL_LIST;
+		}
+		/* fall-through */
 	default:
 		return -EINVAL;
 	}
@@ -119,11 +138,65 @@ static ssize_t rescale_write_ext_info(struct iio_dev *indio_dev,
 					  buf, len);
 }
 
+static int rescale_init_scale_avail(struct device *dev, struct rescale *rescale)
+{
+	const int *scale_raw;
+	unsigned int i;
+	int ret;
+
+	ret = iio_read_avail_channel_attribute(rescale->source, &scale_raw,
+					       &rescale->scale_type,
+					       &rescale->scale_len,
+					       IIO_CHAN_INFO_SCALE);
+	if (ret)
+		return ret;
+
+	if (rescale->scale_type == IIO_VAL_INT && rescale->denominator > 1)
+		rescale->scale_len *= 2;
+
+	rescale->scale_data = devm_kzalloc(dev,
+					   sizeof(int) * rescale->scale_len,
+					   GFP_KERNEL);
+	if (!rescale->scale_len)
+		return -ENOMEM;
+
+	if (rescale->scale_type != IIO_VAL_INT) {
+		for (i = 0; i < rescale->scale_len; i += 2) {
+			ret = rescale_convert(rescale, rescale->scale_type,
+					      scale_raw[i], scale_raw[i + 1],
+					      &rescale->scale_data[i],
+					      &rescale->scale_data[i + 1]);
+			if (ret < 0)
+				return ret;
+		}
+	} else if (rescale->denominator == 1) {
+		for (i = 0; i < rescale->scale_len; i++) {
+			ret = rescale_convert(rescale, IIO_VAL_INT,
+					      scale_raw[i], 0,
+					      &rescale->scale_data[i], NULL);
+			if (ret < 0)
+				return ret;
+		}
+	} else {
+		for (i = 0; i < rescale->scale_len / 2; i++) {
+			ret = rescale_convert(rescale, IIO_VAL_INT,
+					      scale_raw[i], 0,
+					      &rescale->scale_data[i * 2],
+					      &rescale->scale_data[i * 2 + 1]);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int rescale_configure_channel(struct device *dev,
 				     struct rescale *rescale)
 {
 	struct iio_chan_spec *chan = &rescale->chan;
 	struct iio_chan_spec const *schan = rescale->source->channel;
+	int ret;
 
 	chan->indexed = 1;
 	chan->output = schan->output;
@@ -142,6 +215,14 @@ static int rescale_configure_channel(struct device *dev,
 	if (iio_channel_has_available(schan, IIO_CHAN_INFO_RAW))
 		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
 
+	if (iio_channel_has_available(schan, IIO_CHAN_INFO_SCALE)) {
+		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_SCALE);
+
+		ret = rescale_init_scale_avail(dev, rescale);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.25.0

