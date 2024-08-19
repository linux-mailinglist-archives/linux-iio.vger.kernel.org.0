Return-Path: <linux-iio+bounces-8585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75EF9563E6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 08:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27CD5B21B4D
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 06:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49044158A37;
	Mon, 19 Aug 2024 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fijMUKEq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80115886C
	for <linux-iio@vger.kernel.org>; Mon, 19 Aug 2024 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724050065; cv=none; b=a6XtaON8Jbg4PDuNGsazecWs+YZiWbbUsgIudWgFUuwEyrGs8RPXbVsWKNHDJa8e4pSByoLX7aY4bsy7xStL45iS5gy6zksfsp5i8kPOBorcCujj0Y5a3NW0wojiWVaqlum7Iv+JCadLFFrwgOmlj6VSVO3cOwhr8GnFESmHGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724050065; c=relaxed/simple;
	bh=ZK9Z1/Q4filbKX1kKWRghKSgUBwXpAJI26eeyznAt94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cx6KPq5IlPrYTTYrKBuNkYVmrRltFfQX1stk9mFF2RqU2vIPV7zG5S2wQhDf17zzfhCTxe909z5jB9l4gEh/MeFIm2YzmbevCoKGkazamS5nEcoNto5y9RzZU3djy28FfZY2U8j6z29WyM6sqITmFZTrlFH+vOqoq7DO8Bms9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fijMUKEq; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bebc865578so621750a12.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Aug 2024 23:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724050061; x=1724654861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMjsY+V8C+xpLeayM52S92PbmAJB3Osj5meZbpqVaZk=;
        b=fijMUKEq2XedXxUEHBQXwErQt0aic1z9yMHWtHcthEHpMXzuBl9O4jPcuBC5n00PIe
         pWNmfYP8Ghii0ITjcDXAul/p7R38/3EwBPTW7BicWjc1C7yKmajNVfzks6Gtcwu5PH9W
         saRupSTkU40FtGDdV6wLZdFobmPEigQEy4+MlxVCE3YBLF6ZwzmfJwa0kABbXeHmYYQn
         A4anFCjvbYKX7XtIVh3H73y8Ae/yy0JPuIJZVtzRuA0W7sPBOUV4D0botiRrjCYE9QgF
         M5IiXscjijH2igu7LXObxrSNCFo3CGn/bCMerXAZlgSD57j5nGZQR3Kt5jrsDSpiEFf+
         szTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724050061; x=1724654861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMjsY+V8C+xpLeayM52S92PbmAJB3Osj5meZbpqVaZk=;
        b=botPwWp1RV6pKVo/KBvQSpoSXoaRTXln2IQAxkW9DrbRJRN2gBS98kivvZ6a+Opf+z
         Tq83nZwz0dv1ExzmEmS1TAVX6yCuFn0Y8oMb55Ha+ESukPfz0ezqls97zbBWnXVPfgDE
         kRw5zbUo+oPfqx3oH0uZcUR7WlCEhN8lv6rPt28zsK+RDNlQFWxmgNNdxpRIdyNT/oN4
         0C+MCaJvB11beuoJYaJzGhU6HF2+4wLMV++E9Y2F4jJkgWNb1rZBTWnPliZe8kUF+3zH
         EIlF8dZR/vVp1bTmZkj1IPJOGEzyju8ih6IgXmXorNr/L1PyeEt3tPeRFiw3WwA5FR23
         d7xA==
X-Gm-Message-State: AOJu0YwEME+yaVMlxWhu+t8UoSkvPIXietQApDI0C7NoCu72cPXMfCUY
	p0ZJ0KBTfQs0jmv6BDh6JTdWGIrduQ1MmeY1jYLlN4FjBUyAI3jEfE8xNlb0c+mAhIOUxgIueaw
	uy6M=
X-Google-Smtp-Source: AGHT+IHJnJbkmdTrX7s12spzvoZRN74RsDx4TSyadgSkApcAiXcpxyKNu1VgqMgPz6xu/5Cvo/q8qw==
X-Received: by 2002:a17:906:6a18:b0:a80:ed7e:8468 with SMTP id a640c23a62f3a-a8392a9c641mr414381466b.0.1724050061333;
        Sun, 18 Aug 2024 23:47:41 -0700 (PDT)
Received: from neptune.lan ([188.27.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6bfcsm599069966b.28.2024.08.18.23.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 23:47:41 -0700 (PDT)
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
Subject: [PATCH 4/7] iio: adc: ad7606: wrap channel ranges & scales into struct
Date: Mon, 19 Aug 2024 09:47:14 +0300
Message-ID: <20240819064721.91494-5-aardelean@baylibre.com>
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

With the addition of AD7606C-16,18 which have differential & bipolar
channels (and ranges), which can vary from channel to channel, we'll need
to keep more information about each channel range.

To do that, we'll add a 'struct ad7606_chan_scale' type to hold just
configuration for each channel.
This includes the scales per channel (which can be different with
AD7606C-16,18), as well as the range for each channel.
This driver was already keeping the range value for each channel before,
and since this is couple with the scales, it also makes sense to put them
in the same struct.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 37 +++++++++++++++++++++++++------------
 drivers/iio/adc/ad7606.h | 22 ++++++++++++++++------
 2 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index b400c9b2519d..2554a4a4a9c0 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -170,6 +170,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 {
 	int ret, ch = 0;
 	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_chan_scale *cs;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
@@ -183,8 +184,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		if (st->sw_mode_en)
 			ch = chan->address;
+		cs = &st->chan_scales[ch];
 		*val = 0;
-		*val2 = st->scale_avail[st->range[ch]];
+		*val2 = cs->scale_avail[cs->range];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->oversampling;
@@ -214,8 +216,9 @@ static ssize_t in_voltage_scale_available_show(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_chan_scale *cs = &st->chan_scales[0];
 
-	return ad7606_show_avail(buf, st->scale_avail, st->num_scales, true);
+	return ad7606_show_avail(buf, cs->scale_avail, cs->num_scales, true);
 }
 
 static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
@@ -253,19 +256,21 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_chan_scale *cs;
 	int i, ret, ch = 0;
 
 	guard(mutex)(&st->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		i = find_closest(val2, st->scale_avail, st->num_scales);
 		if (st->sw_mode_en)
 			ch = chan->address;
+		cs = &st->chan_scales[ch];
+		i = find_closest(val2, cs->scale_avail, cs->num_scales);
 		ret = st->write_scale(indio_dev, ch, i);
 		if (ret < 0)
 			return ret;
-		st->range[ch] = i;
+		cs->range = i;
 
 		return 0;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -547,7 +552,9 @@ static const struct iio_trigger_ops ad7606_trigger_ops = {
 
 static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 {
+	unsigned int num_channels = indio_dev->num_channels - 1;
 	struct ad7606_state *st = iio_priv(indio_dev);
+	int ch;
 
 	if (!st->bops->sw_mode_config)
 		return 0;
@@ -559,11 +566,14 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 	indio_dev->info = &ad7606_info_os_range_and_debug;
 
 	/* Scale of 0.076293 is only available in sw mode */
-	st->scale_avail = ad7616_sw_scale_avail;
-	st->num_scales = ARRAY_SIZE(ad7616_sw_scale_avail);
-
 	/* After reset, in software mode, ±10 V is set by default */
-	memset32(st->range, 2, ARRAY_SIZE(st->range));
+	for (ch = 0; ch < num_channels; ch++) {
+		struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+
+		cs->scale_avail = ad7616_sw_scale_avail;
+		cs->num_scales = ARRAY_SIZE(ad7616_sw_scale_avail);
+		cs->range = 2;
+	}
 
 	return st->bops->sw_mode_config(indio_dev);
 }
@@ -572,6 +582,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops)
 {
+	struct ad7606_chan_scale *cs;
 	struct ad7606_state *st;
 	int ret;
 	struct iio_dev *indio_dev;
@@ -588,10 +599,12 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->bops = bops;
 	st->base_address = base_address;
 	/* tied to logic low, analog input range is +/- 5V */
-	st->range[0] = 0;
 	st->oversampling = 1;
-	st->scale_avail = ad7606_scale_avail;
-	st->num_scales = ARRAY_SIZE(ad7606_scale_avail);
+
+	cs = &st->chan_scales[0];
+	cs->range = 0;
+	cs->scale_avail = ad7606_scale_avail;
+	cs->num_scales = ARRAY_SIZE(ad7606_scale_avail);
 
 	ret = devm_regulator_get_enable(dev, "avcc");
 	if (ret)
@@ -698,7 +711,7 @@ static int ad7606_resume(struct device *dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	if (st->gpio_standby) {
-		gpiod_set_value(st->gpio_range, st->range[0]);
+		gpiod_set_value(st->gpio_range, st->chan_scales[0].range);
 		gpiod_set_value(st->gpio_standby, 1);
 		ad7606_reset(st);
 	}
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 771121350f98..afe6a4030e0e 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -8,6 +8,8 @@
 #ifndef IIO_ADC_AD7606_H_
 #define IIO_ADC_AD7606_H_
 
+#define AD760X_MAX_CHANNELS	16
+
 #define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {	\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
@@ -60,17 +62,27 @@ struct ad7606_chip_info {
 	unsigned long			init_delay_ms;
 };
 
+/**
+ * struct ad7606_chan_scale - channel scale configuration
+ * @scale_avail		pointer to the array which stores the available scales
+ * @num_scales		number of elements stored in the scale_avail array
+ * @range		voltage range selection, selects which scale to apply
+ */
+struct ad7606_chan_scale {
+	const unsigned int		*scale_avail;
+	unsigned int			num_scales;
+	unsigned int			range;
+};
+
 /**
  * struct ad7606_state - driver instance specific data
  * @dev		pointer to kernel device
  * @chip_info		entry in the table of chips that describes this device
  * @bops		bus operations (SPI or parallel)
- * @range		voltage range selection, selects which scale to apply
+ * @chan_scales		scale configuration for channels
  * @oversampling	oversampling selection
  * @base_address	address from where to read data in parallel operation
  * @sw_mode_en		software mode enabled
- * @scale_avail		pointer to the array which stores the available scales
- * @num_scales		number of elements stored in the scale_avail array
  * @oversampling_avail	pointer to the array which stores the available
  *			oversampling ratios.
  * @num_os_ratios	number of elements stored in oversampling_avail array
@@ -94,12 +106,10 @@ struct ad7606_state {
 	struct device			*dev;
 	const struct ad7606_chip_info	*chip_info;
 	const struct ad7606_bus_ops	*bops;
-	unsigned int			range[16];
+	struct ad7606_chan_scale	chan_scales[AD760X_MAX_CHANNELS];
 	unsigned int			oversampling;
 	void __iomem			*base_address;
 	bool				sw_mode_en;
-	const unsigned int		*scale_avail;
-	unsigned int			num_scales;
 	const unsigned int		*oversampling_avail;
 	unsigned int			num_os_ratios;
 	int (*write_scale)(struct iio_dev *indio_dev, int ch, int val);
-- 
2.46.0


