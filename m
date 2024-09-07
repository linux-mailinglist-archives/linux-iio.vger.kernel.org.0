Return-Path: <linux-iio+bounces-9265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8C3970070
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 08:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A42A1C20A1F
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 06:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C66215855B;
	Sat,  7 Sep 2024 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="21YvUZCY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78278157493
	for <linux-iio@vger.kernel.org>; Sat,  7 Sep 2024 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725691862; cv=none; b=HYenLA9gyQuxBb5rlKJ49yBsz1mRCFU8tYGzWKp1Ww5T21hzRYvIqXZa2GxdPVNVa+X3n/McHlADZE79JwFwqlVvaQyngQwMhKbSIHi2FRPiCXVPe4yaAzcRyBu06uQHlb+O2f1L+9j0QiZtrtXESNlO0eq2x7BxouPGTl8Df1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725691862; c=relaxed/simple;
	bh=30ItHTLovVM1Ek7VqZlwyvYFIdtpxGD4hrvXB2LDUIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSgIB0dgrOfO/Uqf4m/kZ8Bhm0eBPCu2v/2xErRV8Y88uOd/N2Kvny5Xuwjc/IioPbs6kMDEp7E6nNNAxETb6aXo6+qt8KKXK965K20qZff6CDS8CCOcwROG1PDd7nctCwuGUeLiySsm8vkKjWjFomJGKIwIFBS6poMmg7cifPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=21YvUZCY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso4800862e87.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Sep 2024 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725691858; x=1726296658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+L8RwiILhPiWz6XMzynW5ib21/NG2r40upss5Y2x7I=;
        b=21YvUZCYEgnkjSg/gfoA+YXJp3cLC7pekGwYCqW7jUtqLs1FsRpoaKeSihOKGRIwfv
         7YY/nqwR/xN383XP5CiU6LCTsV9cn13r994Meg9bTUQtgpcavVs8tjI/KQI8ndT9SIFt
         lP9yqI0/bdSwmdvOdXYOO1efcIMHTTIsYyfcUdxY9KNjSINfoSLrwoVQdDqBlQkNng0z
         m0KgO5I5/6KjQXMheNVANnUQLILFz6uEFioEhF0DsV/9amw0pCfwDsHmHNBjBKzrnyYc
         ksenJln9Tnu89py+gcGiKEIkvtUytnZKfZKpe2PdAGe2Xcj3qg9ps1+8rXFzgzxzo0Q3
         Z/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725691858; x=1726296658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+L8RwiILhPiWz6XMzynW5ib21/NG2r40upss5Y2x7I=;
        b=IiMA65xICoPlxMI5Hr4wkihlxB5BcF1aNx7Gg2BNzr1DSzEoe8T7y4wMxgiyr6fVD9
         EgMs6ooEvWrxBFKWth7jyl0hs+MYwT1MulEusabFZMDQkBvZ4znwtoBI+NunLGyPCYIs
         X7SvAVmdpdenZjOsoVVuoNfv+CcUZXA47xN51rpy7j51g8oWdtDc0dLiMuSTFCO1It9R
         Tv/gXvWHNsPTK0FByiqmZW4f0hMBrDaLHSxFBX40nD771q5rtbOqgnQAAAswwqcArFDk
         MnjtWFD1iOH3mNqjTc9a23d8qXj0ET5/hadP9BuGTEy1Lp87PIOu6pFsVluCKu05PibR
         7wtQ==
X-Gm-Message-State: AOJu0Yw6sxeNp0XDEiXgqvFPzfEIS3azlOtMWFFsBPx/NrVTB72jFRdQ
	JXlrXx/31qYwkGVmSZPmmxkIy3vXk4s8J9rr6Ivc3r7QUykYw364Bnf+lIEpqDZn01l4XBSI/r1
	Bw6w=
X-Google-Smtp-Source: AGHT+IGb8Ow+LDuZDRfrlDyrYU9D8XeQFB7ZRUiyYK+1f6RQHb70HpOV/0B8HkAhPL3xXic8uNbqlw==
X-Received: by 2002:a05:6512:3088:b0:535:6892:3be6 with SMTP id 2adb3069b0e04-5365880bf79mr2638100e87.54.1725691857112;
        Fri, 06 Sep 2024 23:50:57 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835a76sm36539266b.39.2024.09.06.23.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 23:50:56 -0700 (PDT)
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
Subject: [PATCH v5 5/9] iio: adc: ad7606: wrap channel ranges & scales into struct
Date: Sat,  7 Sep 2024 09:50:38 +0300
Message-ID: <20240907065043.771364-6-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907065043.771364-1-aardelean@baylibre.com>
References: <20240907065043.771364-1-aardelean@baylibre.com>
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
index 5d92463abf8c..39ef72a8acd2 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -146,6 +146,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 {
 	int ret, ch = 0;
 	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_chan_scale *cs;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
@@ -159,8 +160,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
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
@@ -190,8 +192,9 @@ static ssize_t in_voltage_scale_available_show(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_chan_scale *cs = &st->chan_scales[0];
 
-	return ad7606_show_avail(buf, st->scale_avail, st->num_scales, true);
+	return ad7606_show_avail(buf, cs->scale_avail, cs->num_scales, true);
 }
 
 static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
@@ -229,19 +232,21 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
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
@@ -523,7 +528,9 @@ static const struct iio_trigger_ops ad7606_trigger_ops = {
 
 static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 {
+	unsigned int num_channels = indio_dev->num_channels - 1;
 	struct ad7606_state *st = iio_priv(indio_dev);
+	int ch;
 
 	if (!st->bops->sw_mode_config)
 		return 0;
@@ -535,11 +542,14 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
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
@@ -548,6 +558,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops)
 {
+	struct ad7606_chan_scale *cs;
 	struct ad7606_state *st;
 	int ret;
 	struct iio_dev *indio_dev;
@@ -564,10 +575,12 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
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
@@ -674,7 +687,7 @@ static int ad7606_resume(struct device *dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	if (st->gpio_standby) {
-		gpiod_set_value(st->gpio_range, st->range[0]);
+		gpiod_set_value(st->gpio_range, st->chan_scales[0].range);
 		gpiod_set_value(st->gpio_standby, 1);
 		ad7606_reset(st);
 	}
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 204a343067e5..635407c2acc0 100644
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


