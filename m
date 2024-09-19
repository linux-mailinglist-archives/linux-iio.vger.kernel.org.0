Return-Path: <linux-iio+bounces-9652-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED4797C9AC
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 15:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CBD51F2427E
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 13:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F1819FA9C;
	Thu, 19 Sep 2024 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VGqwEDeA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA119F49A
	for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751100; cv=none; b=h8X6L06WlrJccV1xgq/JjJbHkdqEx3n3Hqpjn56z+nIUj7J9ln4IeYFs4r9ej8BFVyO8Q8LGl2i6S1s7G+QUx6GWD3eZIuMZB5XbvlbQ57tHDSrTlfxb7QmFU6Pl3g0jOeVScc6e8xCk4N9SQ4IPDY0Do94LhQzN5szFn9yJ7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751100; c=relaxed/simple;
	bh=AiPTW+eC15hy8WCQnEhvb/1uaDdvGFA0NbdJznajRXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEQy9i0TOLQ+p7vZG0czd7tkvNQThvRlPEdqGmCAZ7rxfvSEGADYI8CDcGnObA37NnaIYsvWiMxyoHqjKAennKc7IodoSiWtkCf7m433UIpRW/cp+Ruh62wZiynScVg68IQwpQfZHTrXtA54qgFJJX9XtPhqj5CLYX5tQIro0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VGqwEDeA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c423d496abso586130a12.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726751096; x=1727355896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyNNlkM7L3gokB2vnij6JW+A3TweMpCxgtAx8xE2ujg=;
        b=VGqwEDeAT+gNBV8F/r8eqUvUl6XAaqX1Sh1lI/1Npgf8lG/Abn8wvcFFW+k6oeLJ69
         q8hqv15ozIyJ163TvigRVicJowbXSiGibQieOjEWMb/Z9aMPwif1sivl+D5u58mjO9vz
         P+XduiQN/v9eXGgEv5x3RITi25UazvjUy6P/+4jb3AvnfbKlzSoMuzXhpeUQVEwug4s2
         cKYHOp6KZKm0Uqz/NLRLm85NtIWEwHuTmxqMlcw6F+g7ZrNHGic6fUoiOj3tnJOlfCPk
         bBrvXbuf/KHLNC9mVV5OHwoGKbp3BQkndb34uw6WMauvAGZnjfrWtFrwjQy7jwW5LVXa
         a7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726751096; x=1727355896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyNNlkM7L3gokB2vnij6JW+A3TweMpCxgtAx8xE2ujg=;
        b=kiiVMg9eyieujiRZAgAhJEmJldQu8GDbu5nM1exy027lfaBrFXgX77K5nJOoVUP+ps
         fkMO2F1kNcOMwQq8iBBAXDBevLhGI0msUszTTVTdGVgFK3rNz4z3/5b1T/I9nrYTicPc
         1HjGbI8WTfG9LeDy/EI70m/kQp8X5INv6E6hvXJIQPZID1FvuYZF6VulfBusaynZNFli
         WISNjbvrPISQMDBwJPldZ3vBSOfcWYXErVkNM1I7EdFKvV7vWLJ0bnHKw98bkJtGDoJh
         98pfaCzpsqkkP1OfqeQPbC0enHPRt0EV/fn4x7y/hYB84IcMhe6a55h3PjxbabRvf4HT
         tIqQ==
X-Gm-Message-State: AOJu0Ywlj1Q/z5pfMoy7Ktkqbu61i7RDK+OZmqywvBqT1bEUDucXgYTb
	kKA/3yrc7L6lgmHnlEl+eLtvigy8mqDbjiVARAN2NJNOQ/U4+hA2SSbzcwR96BRzOAzdrmcVni7
	uYlQ=
X-Google-Smtp-Source: AGHT+IFsIEnS+1xTSYTHdSp6hiXffA07P4l0229m/9LQuDVZfBMaMTJic2JjSwIY7FZYrQG6iyNeTA==
X-Received: by 2002:a05:6402:530b:b0:5c0:8eb1:2800 with SMTP id 4fb4d7f45d1cf-5c41e0969bdmr28971931a12.11.1726751096528;
        Thu, 19 Sep 2024 06:04:56 -0700 (PDT)
Received: from localhost.localdomain ([188.27.132.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90cbc7122esm53213166b.124.2024.09.19.06.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 06:04:56 -0700 (PDT)
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
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v7 4/8] iio: adc: ad7606: wrap channel ranges & scales into struct
Date: Thu, 19 Sep 2024 16:04:39 +0300
Message-ID: <20240919130444.2100447-5-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919130444.2100447-1-aardelean@baylibre.com>
References: <20240919130444.2100447-1-aardelean@baylibre.com>
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
 drivers/iio/adc/ad7606.c | 29 ++++++++++++++++++-----------
 drivers/iio/adc/ad7606.h | 22 ++++++++++++++++------
 2 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 7dc299aeee15..94a254c0725e 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -64,19 +64,21 @@ EXPORT_SYMBOL_NS_GPL(ad7606_reset, IIO_AD7606);
 
 static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st, int ch)
 {
+	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+
 	if (!st->sw_mode_en) {
 		/* tied to logic low, analog input range is +/- 5V */
-		st->range[ch] = 0;
-		st->scale_avail = ad7606_16bit_hw_scale_avail;
-		st->num_scales = ARRAY_SIZE(ad7606_16bit_hw_scale_avail);
+		cs->range = 0;
+		cs->scale_avail = ad7606_16bit_hw_scale_avail;
+		cs->num_scales = ARRAY_SIZE(ad7606_16bit_hw_scale_avail);
 		return 0;
 	}
 
 	/* Scale of 0.076293 is only available in sw mode */
 	/* After reset, in software mode, ±10 V is set by default */
-	st->range[ch] = 2;
-	st->scale_avail = ad7606_16bit_sw_scale_avail;
-	st->num_scales = ARRAY_SIZE(ad7606_16bit_sw_scale_avail);
+	cs->range = 2;
+	cs->scale_avail = ad7606_16bit_sw_scale_avail;
+	cs->num_scales = ARRAY_SIZE(ad7606_16bit_sw_scale_avail);
 
 	return 0;
 }
@@ -167,6 +169,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 {
 	int ret, ch = 0;
 	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_chan_scale *cs;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
@@ -180,8 +183,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
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
@@ -211,8 +215,9 @@ static ssize_t in_voltage_scale_available_show(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_chan_scale *cs = &st->chan_scales[0];
 
-	return ad7606_show_avail(buf, st->scale_avail, st->num_scales, true);
+	return ad7606_show_avail(buf, cs->scale_avail, cs->num_scales, true);
 }
 
 static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
@@ -250,19 +255,21 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
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
@@ -707,7 +714,7 @@ static int ad7606_resume(struct device *dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	if (st->gpio_standby) {
-		gpiod_set_value(st->gpio_range, st->range[0]);
+		gpiod_set_value(st->gpio_range, st->chan_scales[0].range);
 		gpiod_set_value(st->gpio_standby, 1);
 		ad7606_reset(st);
 	}
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 95f3b3cb0be3..2b90f52affba 100644
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
@@ -66,17 +68,27 @@ struct ad7606_chip_info {
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
@@ -100,12 +112,10 @@ struct ad7606_state {
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


