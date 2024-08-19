Return-Path: <linux-iio+bounces-8586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE67D9563EA
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 08:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9041F22638
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 06:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F507158DC3;
	Mon, 19 Aug 2024 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NSjML6X/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D5158845
	for <linux-iio@vger.kernel.org>; Mon, 19 Aug 2024 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724050067; cv=none; b=D8tLUCCLxlE0ieAPHiJJfMMPM1Zbrd6e8l64NGv4Mc45LE5IL4rvycTYKuQ6G7nI34Nm313yWfqSzQ+1g2PaxCXXNfAIOWpght7xgaOgcmFz1iFhFqYntuH4TZyT2d67AK4Egff7O2JBftCIcmTqAbjXVX2u0UG2O2xE9bQuA90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724050067; c=relaxed/simple;
	bh=pmtIgdhzWLa/ZKEbL2pBQv6vMBM4gTaKKLivfp+dDGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyorHVDHMZNd23gw/z8yiUkMSD9SAJVTDyBjvXAzvheT/s2SDq687jTWQJqLbPBNFVZ/a0evSalCaBviq3eUhqwOBVOxsrO0RDEp55fFDrcLAXwmEa62DJdC/YA74HSKQs34LvhXW/4RYtUCnPm7nqAEvPFnIiE5VrgpUUpoK7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NSjML6X/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bef259a71fso104878a12.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Aug 2024 23:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724050064; x=1724654864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH15hzmOmML1/BW9BysaySXYu+XiXmIpiL0tw7k3/FY=;
        b=NSjML6X/3Rrt3TVA7QvmEoDYV3IwvTyurKGHAZZ+TnkcfOhdBycJheULIuXaOSPvoO
         Kw6OTlz8SzV0f/rYCvUAdh5TO2p2Au94LFOJQZ4O3Q19tbVDH8MYk1DW9Q+xyWMXWF2y
         Sieqpwd4LORuXZAHVLZchsxGtBHAnJswhb7xjZqFWvaVogU5i9yTgaRQhdoXVTXYYpsF
         4SzjIMGHdOg3z28jbF6UT2eBTq4ABqgO4fhQ4c30Kq930LcavEiXEK9dVlCVTYF5zDLV
         RgB0Sss1RzZL2BXQm0psD+/aWm+wf0bTYS+hJeAoslcNkA1+8goBqTpJIEzsQT/j9tZr
         L6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724050064; x=1724654864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wH15hzmOmML1/BW9BysaySXYu+XiXmIpiL0tw7k3/FY=;
        b=UPhL07DJkpk9uoB2rY5YrgPujnrSJgRummSEQWMi/6rbxuCbMxmeDtwQ+s7DjSMCB6
         YHSQMJ92AzfvGSB/+l+H/QP6WciKNn/P/5m1uyUs9DrWjRsJ7F6vaaIKKHkVqh+mXY64
         ncqBCskOUxQEVYSbIGsgQvK5n6UvybGGmEww8Yq4dRdO+2WJMfAzQKAR46mSjnnDyJzR
         G5CVOlS1E9EvXS5f0drXLaX447RRMTgUEU/FN9/W0CZoQDJl86FOTVadXbmI3h0MbFl0
         lL/10drmkXjBtqIvmdEz6yWV9Bdxa+TYXGwGLzDBs2lumy/qyfWY3DobaMsEnETvYQ2H
         SwWw==
X-Gm-Message-State: AOJu0YyIob7Bnj2ARDlu1rV6O6eICdYxlsPcKYgHBF4bhwFuKnqoTGCj
	8qkci98f3BKN22iqP5FtceOmsRyLaKJXGVAyJZWjD+eXkRKu26j94ojM61Y6FA2w2986Tbi/niW
	bKE8=
X-Google-Smtp-Source: AGHT+IH68BFFWpDM5vWPFq3UiupHgzhwsbeUiVHxg9SktswkQ6m4w4j+2J2VbJumRgV6cICDuiY37Q==
X-Received: by 2002:a17:907:96aa:b0:a7a:9f0f:ab1b with SMTP id a640c23a62f3a-a8392a41197mr396777266b.7.1724050064104;
        Sun, 18 Aug 2024 23:47:44 -0700 (PDT)
Received: from neptune.lan ([188.27.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6bfcsm599069966b.28.2024.08.18.23.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 23:47:43 -0700 (PDT)
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
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH 5/7] iio: adc: ad7606: rework available attributes for SW channels
Date: Mon, 19 Aug 2024 09:47:15 +0300
Message-ID: <20240819064721.91494-6-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819064721.91494-1-aardelean@baylibre.com>
References: <20240819064721.91494-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For SW mode, the oversampling and scales attributes are always present.
So, they can be implemented via a 'read_avail' hook in iio_info.

For HW mode, it's a bit tricky, as these attributes get assigned based on
GPIO definitions.

So, for SW mode, we define a separate AD7606_SW_CHANNEL() macro, and use
that for the SW channels.
And 'ad7606_info_os_range_and_debug' can be renamed to
'ad7606_info_sw_mode' as it is only used for SW mode.

For the 'read_avail' hook, we'll need to allocate the SW scales, so that
they are just returned userspace without any extra processing.
The oversampling available parameters don't need any extra processing.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 75 +++++++++++++++++++++++++++++++++++++---
 drivers/iio/adc/ad7606.h | 30 +++++++++++++---
 2 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 2554a4a4a9c0..7533aab4b7c8 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -507,6 +507,37 @@ static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static int ad7606_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_chan_scale *cs;
+	unsigned int ch = 0;
+
+	switch (info) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = st->oversampling_avail;
+		*length = st->num_os_ratios;
+		*type = IIO_VAL_INT;
+
+		return IIO_AVAIL_LIST;
+
+	case IIO_CHAN_INFO_SCALE:
+		if (st->sw_mode_en)
+			ch = chan->address;
+
+		cs = &st->chan_scales[ch];
+		*vals = cs->scale_avail_show;
+		*length = cs->num_scales * 2;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+
+		return IIO_AVAIL_LIST;
+	}
+	return -EINVAL;
+}
+
 static const struct iio_buffer_setup_ops ad7606_buffer_ops = {
 	.postenable = &ad7606_buffer_postenable,
 	.predisable = &ad7606_buffer_predisable,
@@ -524,11 +555,11 @@ static const struct iio_info ad7606_info_os_and_range = {
 	.validate_trigger = &ad7606_validate_trigger,
 };
 
-static const struct iio_info ad7606_info_os_range_and_debug = {
+static const struct iio_info ad7606_info_sw_mode = {
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
+	.read_avail = &ad7606_read_avail,
 	.debugfs_reg_access = &ad7606_reg_access,
-	.attrs = &ad7606_attribute_group_os_and_range,
 	.validate_trigger = &ad7606_validate_trigger,
 };
 
@@ -554,7 +585,8 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 {
 	unsigned int num_channels = indio_dev->num_channels - 1;
 	struct ad7606_state *st = iio_priv(indio_dev);
-	int ch;
+	unsigned int *scale_avail_show, num_scales_avail_show;
+	int ret, ch;
 
 	if (!st->bops->sw_mode_config)
 		return 0;
@@ -563,7 +595,7 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 	if (!st->sw_mode_en)
 		return 0;
 
-	indio_dev->info = &ad7606_info_os_range_and_debug;
+	indio_dev->info = &ad7606_info_sw_mode;
 
 	/* Scale of 0.076293 is only available in sw mode */
 	/* After reset, in software mode, ±10 V is set by default */
@@ -575,7 +607,40 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 		cs->range = 2;
 	}
 
-	return st->bops->sw_mode_config(indio_dev);
+	ret = st->bops->sw_mode_config(indio_dev);
+	if (ret)
+		return ret;
+
+	num_scales_avail_show = 1;
+
+	for (ch = 0; ch < num_channels; ch++) {
+		struct ad7606_chan_scale *cs;
+		int i;
+
+		/* AD7606C supports different scales per channel */
+		cs = &st->chan_scales[ch];
+
+		if (num_scales_avail_show == 1 && ch > 0) {
+			cs->scale_avail_show = scale_avail_show;
+			continue;
+		}
+
+		scale_avail_show = devm_kcalloc(st->dev, cs->num_scales * 2,
+						sizeof(*scale_avail_show),
+						GFP_KERNEL);
+		if (!scale_avail_show)
+			return -ENOMEM;
+
+		/* Generate a scale_avail list for showing to userspace */
+		for (i = 0; i < cs->num_scales; i++) {
+			scale_avail_show[i * 2] = 0;
+			scale_avail_show[i * 2 + 1] = cs->scale_avail[i];
+		}
+
+		cs->scale_avail_show = scale_avail_show;
+	}
+
+	return 0;
 }
 
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index afe6a4030e0e..d71a843a5de5 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -27,6 +27,29 @@
 		},						\
 }
 
+#define AD7606_SW_CHANNEL(num, bits) {				\
+		.type = IIO_VOLTAGE,				\
+		.indexed = 1,					\
+		.channel = num,					\
+		.address = num,					\
+		.info_mask_separate =				\
+			BIT(IIO_CHAN_INFO_RAW) | 		\
+			BIT(IIO_CHAN_INFO_SCALE),		\
+		.info_mask_separate_available =			\
+			BIT(IIO_CHAN_INFO_SCALE),		\
+		.info_mask_shared_by_all =			\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		.info_mask_shared_by_all_available =		\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		.scan_index = num,				\
+		.scan_type = {					\
+			.sign = 's',				\
+			.realbits = (bits),			\
+			.storagebits = (bits),			\
+			.endianness = IIO_CPU,			\
+		},						\
+}
+
 #define AD7605_CHANNEL(num)				\
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
 		BIT(IIO_CHAN_INFO_SCALE), 0, 16)
@@ -36,10 +59,6 @@
 		BIT(IIO_CHAN_INFO_SCALE),		\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
 
-#define AD7606_SW_CHANNEL(num, bits)	\
-	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
-		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
-
 #define AD7616_CHANNEL(num)	AD7606_SW_CHANNEL(num, 16)
 
 /**
@@ -65,11 +84,14 @@ struct ad7606_chip_info {
 /**
  * struct ad7606_chan_scale - channel scale configuration
  * @scale_avail		pointer to the array which stores the available scales
+ * @scale_avail_show	a duplicate of 'scale_avail' which is readily formatted
+ *			such that it can be read via the 'read_avail' hook
  * @num_scales		number of elements stored in the scale_avail array
  * @range		voltage range selection, selects which scale to apply
  */
 struct ad7606_chan_scale {
 	const unsigned int		*scale_avail;
+	const unsigned int		*scale_avail_show;
 	unsigned int			num_scales;
 	unsigned int			range;
 };
-- 
2.46.0


