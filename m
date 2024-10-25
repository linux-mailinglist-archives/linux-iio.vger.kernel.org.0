Return-Path: <linux-iio+bounces-11272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE669AFF49
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 12:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C96C286B21
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 10:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4BF1EF931;
	Fri, 25 Oct 2024 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZzTVltuU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29311DE895
	for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850398; cv=none; b=P2YPUQLG7eQcZlH1zZnARkt+N2uJUiv0fuW21KkY25dMKsVZH7jv91s7Y5nYnll0ZVc4/Ftb3kXTrsE0x6rlPwRjhjlxmc4lPF3jdAD6PqD+3forkyYoZWnKFno7EXRSjWDZAEAm6B3lAsi7NQLVQWKY1dTiw03Pfb0i8pTEfWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850398; c=relaxed/simple;
	bh=bnh6k+2nsTlVPGOPQPnS6MUhhFKm2XQJVM/36CFpswI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsWE07RfphWebPCxv2zU4GfWK3+TdmqQVjaCsreqbJk1rTDwN6QE7LLZgRIILY/HZL/h9SWyqWTumRn46Tf8O//rAfesiHInsqcWqjep8KGPrT1UtEDux9wQCo/wycpYV83LkMimwT9P3R5aDG9felDQBnwD5slHSV0ROglWgvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZzTVltuU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so257355766b.0
        for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 02:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729850394; x=1730455194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGoGtNY9UtsrMSYGprOqDMvN9BiGWMz+YiNB4/Bovi0=;
        b=ZzTVltuU80JUGGq/SDxc/Y4FLEnkYnYQJSjWDIxE8A7To4N8pEAGePUFg7aQXOVTtY
         RQk6o7yt7LBiIrw5d5B81kK+e9/NT9Aidnm3fyrkLro67bPN4Gnn/ti02Os1tq4yjYdO
         1dv+BPKEg+HJrKTyqnzHNoKemw/lPfDlM1CnQm6ldyHzf3+k6+RceDfGmNXFl8oqfZzw
         Rnbbwavfi9SGXRLnRA60sgpenT8ssy1WOQav6totKjkn6T3r2NnHyQGXNO2JUme9QIsJ
         MfGHEhHWCDdf1VSHNt+S1NDJL8/4kg6jtrWfYnDsaklupfBC5ERmQD0QfqVXAPQPjp2N
         jppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729850394; x=1730455194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGoGtNY9UtsrMSYGprOqDMvN9BiGWMz+YiNB4/Bovi0=;
        b=wXwAYqs7gocS7r/fU0N7gx36XWJYEPXTU4/iu5J11df4S8qNFKzM5KOxutZcopvHS3
         sO9kJvpBMCoH++UrWCjLTUdsojcUfINvMqat/kiNpMNTUYwYTJJ844SyxZTw9fauzcBq
         rYjhrunBvlRr4GcM6q5nZfy/WCzsbNwvWlh8YlScOMngVGEJ4V7ZZ0i6ha7QTJJypQ+7
         //vMq4Mawqpq3XkzP8c1WhuUvODOnQhkt1hU06RGwIMo/ugwWkRUOeKqvBszLGirDs7O
         vaIIfua5BJ7O7GVV2NOCPefvcOnw91FJwJ0Ykep69AiV9Yd9TtWryBmDPqgNa2F+vuy6
         YbUg==
X-Gm-Message-State: AOJu0YyQP2bp+/PCHiwW4e+koGAy7OTvnQcd7UMw3uzSYKJH72ct7LFR
	LhyVz1JPRwHu0mDeslxzbkZOOEJEduNJNP8KhDLo0yyDAKErtrkxcVGrUlu77xcIWiBrnoIT8Ft
	enmc=
X-Google-Smtp-Source: AGHT+IFMtmJpPN1a5j/r7T2Jvn7suJkfOXqhDLSHqOMT3yOEa2QZQmBW3GF5Q/ArO2jjFvM4A8g9kg==
X-Received: by 2002:a17:907:31c5:b0:a9a:a5c:e23b with SMTP id a640c23a62f3a-a9abf96aa4cmr870774166b.58.1729850393935;
        Fri, 25 Oct 2024 02:59:53 -0700 (PDT)
Received: from localhost.localdomain ([188.27.128.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f02951esm51737266b.71.2024.10.25.02.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:59:53 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	dlechner@baylibre.com,
	conor.dooley@microchip.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v2 3/5] iio: adc: ad7606: rework scale-available to be static
Date: Fri, 25 Oct 2024 12:59:37 +0300
Message-ID: <20241025095939.271811-4-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241025095939.271811-1-aardelean@baylibre.com>
References: <20241025095939.271811-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The main driver for this change is the AD7607 part, which has a scale of
"1.220703" for the ±10V range. The AD7607 has a resolution of 14-bits.

So, just adding the scale-available list for that part would require some
quirks to handle just that scale value.
But to do it more neatly, the best approach is to rework the scale
available lists to have the same format as it is returned to userspace.
That way, we can also get rid of the allocation for the 'scale_avail_show'
array.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 106 ++++++++++++++++++---------------------
 drivers/iio/adc/ad7606.h |   6 +--
 2 files changed, 50 insertions(+), 62 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index effb98b4dc77..94756bb87b95 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -33,42 +33,44 @@
 
 /*
  * Scales are computed as 5000/32768 and 10000/32768 respectively,
- * so that when applied to the raw values they provide mV values
+ * so that when applied to the raw values they provide mV values.
+ * The scale arrays are kept as IIO_VAL_INT_PLUS_MICRO, so index
+ * X is the integer part and X + 1 is the fractional part.
  */
-static const unsigned int ad7606_16bit_hw_scale_avail[2] = {
-	152588, 305176
+static const unsigned int ad7606_16bit_hw_scale_avail[2][2] = {
+	{ 0, 152588 }, { 0, 305176 }
 };
 
-static const unsigned int ad7606_18bit_hw_scale_avail[2] = {
-	38147, 76294
+static const unsigned int ad7606_18bit_hw_scale_avail[2][2] = {
+	{ 0, 38147 }, { 0, 76294 }
 };
 
-static const unsigned int ad7606c_16bit_single_ended_unipolar_scale_avail[3] = {
-	76294, 152588, 190735,
+static const unsigned int ad7606c_16bit_single_ended_unipolar_scale_avail[3][2] = {
+	{ 0, 76294 }, { 0, 152588 }, { 0, 190735 }
 };
 
-static const unsigned int ad7606c_16bit_single_ended_bipolar_scale_avail[5] = {
-	76294, 152588, 190735, 305176, 381470
+static const unsigned int ad7606c_16bit_single_ended_bipolar_scale_avail[5][2] = {
+	{ 0, 76294 }, { 0, 152588 }, { 0, 190735 }, { 0, 305176 }, { 0, 381470 }
 };
 
-static const unsigned int ad7606c_16bit_differential_bipolar_scale_avail[4] = {
-	152588, 305176, 381470, 610352
+static const unsigned int ad7606c_16bit_differential_bipolar_scale_avail[4][2] = {
+	{ 0, 152588 }, { 0, 305176 }, { 0, 381470 }, { 0, 610352 }
 };
 
-static const unsigned int ad7606c_18bit_single_ended_unipolar_scale_avail[3] = {
-	19073, 38147, 47684
+static const unsigned int ad7606c_18bit_single_ended_unipolar_scale_avail[3][2] = {
+	{ 0, 19073 }, { 0, 38147 }, { 0, 47684 }
 };
 
-static const unsigned int ad7606c_18bit_single_ended_bipolar_scale_avail[5] = {
-	19073, 38147, 47684, 76294, 95367
+static const unsigned int ad7606c_18bit_single_ended_bipolar_scale_avail[5][2] = {
+	{ 0, 19073 }, { 0, 38147 }, { 0, 47684 }, { 0, 76294 }, { 0, 95367 }
 };
 
-static const unsigned int ad7606c_18bit_differential_bipolar_scale_avail[4] = {
-	38147, 76294, 95367, 152588
+static const unsigned int ad7606c_18bit_differential_bipolar_scale_avail[4][2] = {
+	{ 0, 38147 }, { 0, 76294 }, { 0, 95367 }, { 0, 152588 }
 };
 
-static const unsigned int ad7606_16bit_sw_scale_avail[3] = {
-	76293, 152588, 305176
+static const unsigned int ad7606_16bit_sw_scale_avail[3][2] = {
+	{ 0, 76293 }, { 0, 152588 }, { 0, 305176 }
 };
 
 static const unsigned int ad7606_oversampling_avail[7] = {
@@ -649,8 +651,8 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 		if (st->sw_mode_en)
 			ch = chan->address;
 		cs = &st->chan_scales[ch];
-		*val = 0;
-		*val2 = cs->scale_avail[cs->range];
+		*val = cs->scale_avail[cs->range][0];
+		*val2 = cs->scale_avail[cs->range][1];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->oversampling;
@@ -667,21 +669,6 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static ssize_t ad7606_show_avail(char *buf, const unsigned int *vals,
-				 unsigned int n, bool micros)
-{
-	size_t len = 0;
-	int i;
-
-	for (i = 0; i < n; i++) {
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-			micros ? "0.%06u " : "%u ", vals[i]);
-	}
-	buf[len - 1] = '\n';
-
-	return len;
-}
-
 static ssize_t in_voltage_scale_available_show(struct device *dev,
 					       struct device_attribute *attr,
 					       char *buf)
@@ -689,8 +676,16 @@ static ssize_t in_voltage_scale_available_show(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs = &st->chan_scales[0];
+	const unsigned int (*vals)[2] = cs->scale_avail;
+	unsigned int i;
+	size_t len = 0;
 
-	return ad7606_show_avail(buf, cs->scale_avail, cs->num_scales, true);
+	for (i = 0; i < cs->num_scales; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%u.%06u ",
+				 vals[i][0], vals[i][1]);
+	buf[len - 1] = '\n';
+
+	return len;
 }
 
 static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
@@ -728,6 +723,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int scale_avail_uv[AD760X_MAX_SCALES];
 	struct ad7606_chan_scale *cs;
 	int i, ret, ch = 0;
 
@@ -738,7 +734,12 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		if (st->sw_mode_en)
 			ch = chan->address;
 		cs = &st->chan_scales[ch];
-		i = find_closest(val2, cs->scale_avail, cs->num_scales);
+		for (i = 0; i < cs->num_scales; i++) {
+			scale_avail_uv[i] = cs->scale_avail[i][0] * MICRO +
+					    cs->scale_avail[i][1];
+		}
+		val = (val * MICRO) + val2;
+		i = find_closest(val, scale_avail_uv, cs->num_scales);
 		ret = st->write_scale(indio_dev, ch, i + cs->reg_offset);
 		if (ret < 0)
 			return ret;
@@ -771,9 +772,15 @@ static ssize_t ad7606_oversampling_ratio_avail(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
+	const unsigned int *vals = st->oversampling_avail;
+	unsigned int i;
+	size_t len = 0;
 
-	return ad7606_show_avail(buf, st->oversampling_avail,
-				 st->num_os_ratios, false);
+	for (i = 0; i < st->num_os_ratios; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%u ", vals[i]);
+	buf[len - 1] = '\n';
+
+	return len;
 }
 
 static IIO_DEVICE_ATTR(oversampling_ratio_available, 0444,
@@ -927,8 +934,8 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
 			ch = chan->address;
 
 		cs = &st->chan_scales[ch];
-		*vals = cs->scale_avail_show;
-		*length = cs->num_scales * 2;
+		*vals = (int *)cs->scale_avail;
+		*length = cs->num_scales;
 		*type = IIO_VAL_INT_PLUS_MICRO;
 
 		return IIO_AVAIL_LIST;
@@ -1051,24 +1058,9 @@ static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
 	indio_dev->channels = chans;
 
 	for (ch = 0; ch < num_channels; ch++) {
-		struct ad7606_chan_scale *cs;
-		int i;
-
 		ret = st->chip_info->scale_setup_cb(st, &chans[ch + 1], ch);
 		if (ret)
 			return ret;
-
-		cs = &st->chan_scales[ch];
-
-		if (cs->num_scales * 2 > AD760X_MAX_SCALE_SHOW)
-			return dev_err_probe(st->dev, -ERANGE,
-					"Driver error: scale range too big");
-
-		/* Generate a scale_avail list for showing to userspace */
-		for (i = 0; i < cs->num_scales; i++) {
-			cs->scale_avail_show[i * 2] = 0;
-			cs->scale_avail_show[i * 2 + 1] = cs->scale_avail[i];
-		}
 	}
 
 	return 0;
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 2c629a15cc33..32c6f776c5df 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -103,8 +103,6 @@ struct ad7606_chip_info {
 /**
  * struct ad7606_chan_scale - channel scale configuration
  * @scale_avail		pointer to the array which stores the available scales
- * @scale_avail_show	a duplicate of 'scale_avail' which is readily formatted
- *			such that it can be read via the 'read_avail' hook
  * @num_scales		number of elements stored in the scale_avail array
  * @range		voltage range selection, selects which scale to apply
  * @reg_offset		offset for the register value, to be applied when
@@ -112,9 +110,7 @@ struct ad7606_chip_info {
  */
 struct ad7606_chan_scale {
 #define AD760X_MAX_SCALES		16
-#define AD760X_MAX_SCALE_SHOW		(AD760X_MAX_SCALES * 2)
-	const unsigned int		*scale_avail;
-	int				scale_avail_show[AD760X_MAX_SCALE_SHOW];
+	const unsigned int		(*scale_avail)[2];
 	unsigned int			num_scales;
 	unsigned int			range;
 	unsigned int			reg_offset;
-- 
2.46.1


