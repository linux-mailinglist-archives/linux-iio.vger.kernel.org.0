Return-Path: <linux-iio+bounces-9120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 186A096B2D4
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 09:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36AF285F94
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 07:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE45D14A4FB;
	Wed,  4 Sep 2024 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kn31VeNX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10F14883C
	for <linux-iio@vger.kernel.org>; Wed,  4 Sep 2024 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434854; cv=none; b=mtdJKcbwnvMCVX+KCqpu7jfabl0M4TRMc+tvXfbuiIQSAzNUWOF2dEQQIiHWuideVoPB465nDcQT9MYOtlyopVNBWy+UFBo7/ixkq7fKVLMzHMLmg3gU4oycNL0YziEFsIINXtfACgD74j8K72FeqRDMLZpGE9EOs2KlCAmbHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434854; c=relaxed/simple;
	bh=ZK9Z1/Q4filbKX1kKWRghKSgUBwXpAJI26eeyznAt94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQ+LHljbfxhXZy7KxhKIXM8R5evJrUHgkHq4XOe7mR+VPcLafVR2vaH8KIIxg4PaPREmcgALbaDyyd1gjdHxN0rTuHmMpKrx9tfMWU6L2/TSmIuEqab43DkVv/Hrn9cgaimBA2O4J38/u1HSia7f/EAPZM0zjNs5nsVFXSHlhqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kn31VeNX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8684c31c60so708176166b.3
        for <linux-iio@vger.kernel.org>; Wed, 04 Sep 2024 00:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725434850; x=1726039650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMjsY+V8C+xpLeayM52S92PbmAJB3Osj5meZbpqVaZk=;
        b=kn31VeNX2SENfFLwxlRKl60QSt3iLF1W5lER3EAM1nWSTFK2tOWq3gZhCxhzHMmkw8
         fJiJIJQOC6+zV+gfda/J2GaZUrtdTvcqDas6U3lA37N7ouGQQbN7TPODV/0bUkLejkcI
         H86LuuMrPQebxv448HFcCuvgz64R4T2sdAgcmfVf7Fla0TU5TxfPQ3eV/RZUNak1ALoC
         EUswAQX8xxxLoSsvNeI6q8ztEQXyXQAIsybX9d26cWBfuHQFFdr6D0+tX/qmDT7X1X1Y
         JxugfxMRc4WJVrg3qNS38Xg9VTqujjT2KDL251r3PgoRIHFs5OHkWb93aBeGDkF5Napw
         P45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434850; x=1726039650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMjsY+V8C+xpLeayM52S92PbmAJB3Osj5meZbpqVaZk=;
        b=ikIj+XQKnqJLlSxfRDgJc/lbOogBfQXsqp+FObLMfu1urO3VEAU1wbJA58yKmtmjps
         Jhs5RIEKJ0CqwhjFLYb5QjstiLQLaz3nha8Oi1MpBSKaVWs0DMCdFpByTygHyNmI7AQJ
         UqmUajjyXSciiZo5uu1AhN2sc1Mt9f7BPmXUvukCGI31t9KSlFKEcz4Mqdl45Hn1uCTm
         s5Ubd4GyZT0yxWKdb+l6y5tCZopEJq5TbdfQVpREEY8DCcbxGtVXXof27+E0gjId74gI
         A86SqB5vgM2q2B2wPF7VTnk72kA8ePxlTdAqbqXF0WA5ub9x23GlBVr+ezQ+A1sPMECi
         mpCw==
X-Gm-Message-State: AOJu0YzbxUyaTPlDPB4Rd634rezC1jHndRZNMyXqWfWGMm0ewzPSTg00
	hIRCzAwPB1l1b1dBWkPBwPsHyFbU5+JRctt2uDWu3l+K9STbM7hLiURKhWSggItUbRlcW+zIh0T
	J+FU=
X-Google-Smtp-Source: AGHT+IFsUgq0CpDUxU+jCRXnAz9i2A7gEDgikGOoHQIBWcwmlnwPMr1De5G+WsNXilZzytFkb6DiDg==
X-Received: by 2002:a17:907:3208:b0:a87:31c:c6c4 with SMTP id a640c23a62f3a-a897f83623fmr1536620866b.24.1725434850445;
        Wed, 04 Sep 2024 00:27:30 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d77fasm771151766b.167.2024.09.04.00.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:27:29 -0700 (PDT)
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
Subject: [PATCH v3 4/8] iio: adc: ad7606: wrap channel ranges & scales into struct
Date: Wed,  4 Sep 2024 10:27:12 +0300
Message-ID: <20240904072718.1143440-5-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904072718.1143440-1-aardelean@baylibre.com>
References: <20240904072718.1143440-1-aardelean@baylibre.com>
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


