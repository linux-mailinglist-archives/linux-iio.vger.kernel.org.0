Return-Path: <linux-iio+bounces-8588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D254C9563F0
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 08:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B29E282D3C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 06:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF7D15A863;
	Mon, 19 Aug 2024 06:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OCe83cQ/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7A158D80
	for <linux-iio@vger.kernel.org>; Mon, 19 Aug 2024 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724050074; cv=none; b=g/YC8XM+c4hxMZx3Vf+UFkTZrOj7Iq8vFip6rVpZ6rnaMNA7kljTNWX8D/MU+qwhjGIYsm3Q39SccT21rmm524o1+FUhXbdTqPa5g03wrb3TjDiBpvROaZ9Pg80cTHoikgcQOOnhJeZPDl49lfY9Zs4OFSKKe5qGQwpVqB3thQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724050074; c=relaxed/simple;
	bh=XXVymd2d9ZQoYqV5x0X+F5zZ9r3Uty1aQWWKL0LW7kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqIt5Zo4IwN1g5E1VEcON4BWEBCqgGKQegJTqndLXhUdLjkYayivzIMzQUfxH7WCr9K86KXCsRcWnJCbac5MdzfpJ5EwUhExiMAWa5tA07ZOQ9SnlQ87CKa1uY1Rn8PE38lbD9LQA0uxK63qFHJMQAf3Ifguy9yZuPtjB7kAic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OCe83cQ/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bec67709easo694098a12.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Aug 2024 23:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724050070; x=1724654870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3S6X4VoAXj5qYcKOoiYF3CVxTxMLh1pVsU+4wLTCGQ=;
        b=OCe83cQ/gQE2MoBwpRpj4gjr38DPKUCcWEBlxVOCTe4erSikulCLjbHQyw0GoZETL+
         7Lo+b/2L/mbUtTzFdV7ujv40xJaW4fMr9JVvTkM1RvibuiSzlEBEqOqmPlMEBeK29RGw
         i24ujnJETCWPel2C+AH89UJ27yAQCqxHB4vwDnBbV9BTXNK2zSmvfzFJexkQsp3TRLhA
         3gPLqeCMeuLuGoGDi0303utXG8clTc3pg0Nw2CA2oPkbmG5s8QIb/QKGbOsgY6ggC+z1
         yCXSyzLFQ967V3rcbFabfoLlt5fAjaIw82yCh9RsJV2GwJxnKJe3LNSlqAxjb+aja3w6
         aP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724050070; x=1724654870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3S6X4VoAXj5qYcKOoiYF3CVxTxMLh1pVsU+4wLTCGQ=;
        b=L9ykL9ZZ0MRDYeb4emEvqo/lH8TmmymrfkDGyB5GxWgmujp2VZqbRYqtKYviuk6wA2
         DxpdOp5N7N8h8QNDQkJymDfJDgLL/6BHY2xqPjjBMBA516dGmBDCY4AE1JEt+Ukf2rcs
         LMgoufQuh2q1cBDLziXTcUJQK99orS39jt+hdc9F1Uz4OUM6vr3wraT8PQ10mdCbmjdr
         x4UHm2jQT+lmQxiOzlOkURsFWK4oekAo+oleDYrgtD2FuJE0NWkwXwgF7gSSBnLBDCDQ
         ZI0AFrvVWcF+zz/OhUIKAWr2394Z8fsu7aFVQYzBzf478Z3e5Ocf4/VM3Kmoqg6B0ZZs
         gzLw==
X-Gm-Message-State: AOJu0Ywv/PEsbCOGxdWuj6IBM5ioBLR4Xv0sYefgoX08VGRgQPiTaWC9
	SK7sE6RQtEnnCg+imdonjMSr7Xzgmm8YQEADVjA64ptv3n8S7csV0X904u6wl1UWWkqZ02+bnyt
	Z80w=
X-Google-Smtp-Source: AGHT+IH4qvrSGlYAiMNgzXG0J4/feXQUFfFIMFIWtWu8957Gg0iqKfR09LSzDv22PwR0i5eVkGC39Q==
X-Received: by 2002:a17:906:6a1c:b0:a80:f63e:159b with SMTP id a640c23a62f3a-a83925633ddmr429621766b.0.1724050070309;
        Sun, 18 Aug 2024 23:47:50 -0700 (PDT)
Received: from neptune.lan ([188.27.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6bfcsm599069966b.28.2024.08.18.23.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 23:47:49 -0700 (PDT)
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
Subject: [PATCH 7/7] iio: adc: ad7606: add support for AD7606C-{16,18} parts
Date: Mon, 19 Aug 2024 09:47:17 +0300
Message-ID: <20240819064721.91494-8-aardelean@baylibre.com>
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

The AD7606C-16 and AD7606C-18 are pretty similar with the AD7606B.
The main difference between AD7606C-16 & AD7606C-18 is the precision in
bits (16 vs 18).
Because of that, some scales need to be defined for the 18-bit variants, as
they need to be computed against 2**18 (vs 2**16 for the 16 bit-variants).

Because the AD7606C-16,18 also supports bipolar & differential channels,
for SW-mode, the default range of 10 V or ±10V should be set at probe.
On reset, the default range (in the registers) is set to value 0x3 which
corresponds to '±10 V single-ended range', regardless of bipolar or
differential configuration.

Aside from the scale/ranges, the AD7606C-16 is similar to the AD7606B.

And the AD7606C-18 variant offers 18-bit precision. The unfortunate effect
of this 18-bit sample size, is that there is no simple/neat way to get the
samples into a 32-bit array without having to do a home-brewed bit-buffer.
The ADC must read all samples (from all 8 channels) in order to get the
N-th sample (this could be reworked to do up-to-N-th sample for scan-direct).
There doesn't seem to be any quick-trick to be usable to pad the samples
up to at least 24 bits.
Even the optional status-header is 8-bits, which would mean 26-bits of data
per sample.
That means that when using a simple SPI controller (which can usually read
8 bit multiples) a simple bit-buffer trick is required.

Datasheet links:
  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-16.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-18.pdf

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 274 ++++++++++++++++++++++++++++++++---
 drivers/iio/adc/ad7606.h     |  17 ++-
 drivers/iio/adc/ad7606_spi.c |  94 ++++++++++++
 3 files changed, 357 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 7533aab4b7c8..55faab321092 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -28,14 +28,44 @@
 
 #include "ad7606.h"
 
+typedef void (*ad7606c_chan_setup_cb_t)(struct ad7606_state *st, int ch,
+					bool bipolar, bool differential);
+
 /*
  * Scales are computed as 5000/32768 and 10000/32768 respectively,
  * so that when applied to the raw values they provide mV values
  */
-static const unsigned int ad7606_scale_avail[2] = {
+static const unsigned int ad7606_16bit_hw_scale_avail[2] = {
 	152588, 305176
 };
 
+static const unsigned int ad7606_18bit_hw_scale_avail[2] = {
+	38147, 76294
+};
+
+static const unsigned int ad7606c_16_scale_single_ended_unipolar_avail[3] = {
+	76294, 152588, 190735,
+};
+
+static const unsigned int ad7606c_16_scale_single_ended_bipolar_avail[5] = {
+	76294, 152588, 190735, 305176, 381470
+};
+
+static const unsigned int ad7606c_16_scale_differential_bipolar_avail[4] = {
+	152588, 305176, 381470, 610352
+};
+
+static const unsigned int ad7606c_18_scale_single_ended_unipolar_avail[3] = {
+	19073, 38147, 47684
+};
+
+static const unsigned int ad7606c_18_scale_single_ended_bipolar_avail[5] = {
+	19073, 38147, 47684, 76294, 95367
+};
+
+static const unsigned int ad7606c_18_scale_differential_bipolar_avail[4] = {
+	38147, 76294, 95367, 152588
+};
 
 static const unsigned int ad7616_sw_scale_avail[3] = {
 	76293, 152588, 305176
@@ -84,10 +114,18 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
 
 static int ad7606_read_samples(struct ad7606_state *st)
 {
+	unsigned int storagebits = st->chip_info->channels[1].scan_type.storagebits;
 	unsigned int num = st->chip_info->num_channels - 1;
-	u16 *data = st->data;
+	u32 *data32 = st->data.d32;
+	u16 *data16 = st->data.d16;
+	void *data;
 	int ret;
 
+	if (storagebits > 16)
+		data = data32;
+	else
+		data = data16;
+
 	/*
 	 * The frstdata signal is set to high while and after reading the sample
 	 * of the first channel and low for all other channels. This can be used
@@ -108,7 +146,10 @@ static int ad7606_read_samples(struct ad7606_state *st)
 			return -EIO;
 		}
 
-		data++;
+		if (storagebits > 16)
+			data32++;
+		else
+			data16++;
 		num--;
 	}
 
@@ -128,7 +169,7 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 	if (ret)
 		goto error_ret;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
+	iio_push_to_buffers_with_timestamp(indio_dev, st->data.d16,
 					   iio_get_time_ns(indio_dev));
 error_ret:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -142,6 +183,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 			      int *val)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int storagebits = st->chip_info->channels[1].scan_type.storagebits;
 	int ret;
 
 	gpiod_set_value(st->gpio_convst, 1);
@@ -153,8 +195,12 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 	}
 
 	ret = ad7606_read_samples(st);
-	if (ret == 0)
-		*val = sign_extend32(st->data[ch], 15);
+	if (ret == 0) {
+		if (storagebits > 16)
+			*val = sign_extend32(st->data.d32[ch], 17);
+		else
+			*val = sign_extend32(st->data.d16[ch], 15);
+	}
 
 error_ret:
 	gpiod_set_value(st->gpio_convst, 0);
@@ -267,7 +313,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			ch = chan->address;
 		cs = &st->chan_scales[ch];
 		i = find_closest(val2, cs->scale_avail, cs->num_scales);
-		ret = st->write_scale(indio_dev, ch, i);
+		ret = st->write_scale(indio_dev, ch, i + cs->reg_offset);
 		if (ret < 0)
 			return ret;
 		cs->range = i;
@@ -350,6 +396,18 @@ static const struct iio_chan_spec ad7606_channels_16bit[] = {
 	AD7606_CHANNEL(7, 16),
 };
 
+static const struct iio_chan_spec ad7606_channels_18bit[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+	AD7606_CHANNEL(0, 18),
+	AD7606_CHANNEL(1, 18),
+	AD7606_CHANNEL(2, 18),
+	AD7606_CHANNEL(3, 18),
+	AD7606_CHANNEL(4, 18),
+	AD7606_CHANNEL(5, 18),
+	AD7606_CHANNEL(6, 18),
+	AD7606_CHANNEL(7, 18),
+};
+
 /*
  * The current assumption that this driver makes for AD7616, is that it's
  * working in Hardware Mode with Serial, Burst and Sequencer modes activated.
@@ -410,6 +468,18 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
 		.oversampling_avail = ad7606_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
+	[ID_AD7606C_16] = {
+		.channels = ad7606_channels_16bit,
+		.num_channels = 9,
+		.oversampling_avail = ad7606_oversampling_avail,
+		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	},
+	[ID_AD7606C_18] = {
+		.channels = ad7606_channels_18bit,
+		.num_channels = 9,
+		.oversampling_avail = ad7606_oversampling_avail,
+		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	},
 	[ID_AD7616] = {
 		.channels = ad7616_channels,
 		.num_channels = 17,
@@ -563,6 +633,14 @@ static const struct iio_info ad7606_info_sw_mode = {
 	.validate_trigger = &ad7606_validate_trigger,
 };
 
+static const struct iio_info ad7606c_info_sw_mode = {
+	.read_raw = &ad7606_read_raw,
+	.write_raw = &ad7606_write_raw,
+	.read_avail = &ad7606_read_avail,
+	.debugfs_reg_access = &ad7606_reg_access,
+	.validate_trigger = &ad7606_validate_trigger,
+};
+
 static const struct iio_info ad7606_info_os = {
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
@@ -581,7 +659,136 @@ static const struct iio_trigger_ops ad7606_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
 
-static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
+static void ad7606c_18_chan_setup(struct ad7606_state *st, int ch,
+				  bool bipolar, bool differential)
+{
+	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+
+	if (differential) {
+		cs->scale_avail =
+			ad7606c_18_scale_differential_bipolar_avail;
+		cs->num_scales =
+			ARRAY_SIZE(ad7606c_18_scale_differential_bipolar_avail);
+		/* Bipolar differential ranges start at 8 (b1000) */
+		cs->reg_offset = 8;
+		cs->range = 1;
+	} else if (bipolar) {
+		cs->scale_avail =
+			ad7606c_18_scale_single_ended_bipolar_avail;
+		cs->num_scales =
+			ARRAY_SIZE(ad7606c_18_scale_single_ended_bipolar_avail);
+		cs->range = 3;
+	} else {
+		cs->scale_avail =
+			ad7606c_18_scale_single_ended_unipolar_avail;
+		cs->num_scales =
+			ARRAY_SIZE(ad7606c_18_scale_single_ended_unipolar_avail);
+		/* Unipolar single-ended ranges start at 5 (b0101) */
+		cs->reg_offset = 5;
+		cs->range = 1;
+	}
+}
+
+static void ad7606c_16_chan_setup(struct ad7606_state *st, int ch,
+				  bool bipolar, bool differential)
+{
+	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+
+	if (differential) {
+		cs->scale_avail =
+			ad7606c_16_scale_differential_bipolar_avail;
+		cs->num_scales =
+			ARRAY_SIZE(ad7606c_16_scale_differential_bipolar_avail);
+		/* Bipolar differential ranges start at 8 (b1000) */
+		cs->reg_offset = 8;
+		cs->range = 1;
+	} else if (bipolar) {
+		cs->scale_avail =
+			ad7606c_16_scale_single_ended_bipolar_avail;
+		cs->num_scales =
+			ARRAY_SIZE(ad7606c_16_scale_single_ended_bipolar_avail);
+		cs->range = 3;
+	} else {
+		cs->scale_avail =
+			ad7606c_16_scale_single_ended_unipolar_avail;
+		cs->num_scales =
+			ARRAY_SIZE(ad7606c_16_scale_single_ended_unipolar_avail);
+		/* Unipolar single-ended ranges start at 5 (b0101) */
+		cs->reg_offset = 5;
+		cs->range = 1;
+	}
+}
+
+static int ad7606c_sw_mode_setup_channels(struct iio_dev *indio_dev,
+					  ad7606c_chan_setup_cb_t chan_setup_cb)
+{
+	unsigned int num_channels = indio_dev->num_channels - 1;
+	struct ad7606_state *st = iio_priv(indio_dev);
+	bool chan_configured[AD760X_MAX_CHANNELS];
+	struct device *dev = st->dev;
+	int ret;
+	u32 ch;
+
+	/* We need to hook this first */
+	ret = st->bops->sw_mode_config(indio_dev);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &ad7606c_info_sw_mode;
+
+	memset(chan_configured, 0, sizeof(chan_configured));
+
+	device_for_each_child_node_scoped(dev, child) {
+		bool bipolar, differential;
+
+		ret = fwnode_property_read_u32(child, "reg", &ch);
+		if (ret)
+			continue;
+
+		if (ch >= num_channels) {
+			dev_warn(st->dev,
+				 "Invalid channel number (ignoring): %d\n", ch);
+			continue;
+		}
+
+		bipolar = fwnode_property_present(child, "bipolar");
+		differential = fwnode_property_present(child, "diff-channel");
+
+		chan_setup_cb(st, ch, bipolar, differential);
+		chan_configured[ch] = true;
+	}
+
+	/* Apply default configuration to unconfigured (via DT) channels */
+	for (ch = 0; ch < num_channels; ch++) {
+		struct ad7606_chan_scale *cs;
+		unsigned int *scale_avail_show;
+		int i;
+
+		if (!chan_configured[ch])
+			chan_setup_cb(st, ch, false, false);
+
+		/* AD7606C supports different scales per channel */
+		cs = &st->chan_scales[ch];
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
+}
+
+static int ad7606_sw_mode_setup(struct iio_dev *indio_dev, unsigned int id)
 {
 	unsigned int num_channels = indio_dev->num_channels - 1;
 	struct ad7606_state *st = iio_priv(indio_dev);
@@ -597,21 +804,33 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 
 	indio_dev->info = &ad7606_info_sw_mode;
 
-	/* Scale of 0.076293 is only available in sw mode */
-	/* After reset, in software mode, ±10 V is set by default */
-	for (ch = 0; ch < num_channels; ch++) {
-		struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	switch (id) {
+	case ID_AD7606C_18:
+		num_scales_avail_show = num_channels;
+		ret = ad7606c_sw_mode_setup_channels(indio_dev,
+						     ad7606c_18_chan_setup);
+		break;
+	case ID_AD7606C_16:
+		num_scales_avail_show = num_channels;
+		ret = ad7606c_sw_mode_setup_channels(indio_dev,
+						     ad7606c_16_chan_setup);
+		break;
+	default:
+		num_scales_avail_show = 1;
 
-		cs->scale_avail = ad7616_sw_scale_avail;
-		cs->num_scales = ARRAY_SIZE(ad7616_sw_scale_avail);
-		cs->range = 2;
-	}
+		/* Scale of 0.076293 is only available in sw mode */
+		/* After reset, in software mode, ±10 V is set by default */
+		for (ch = 0; ch < num_channels; ch++) {
+			struct ad7606_chan_scale *cs = &st->chan_scales[ch];
 
-	ret = st->bops->sw_mode_config(indio_dev);
-	if (ret)
-		return ret;
+			cs->scale_avail = ad7616_sw_scale_avail;
+			cs->num_scales = ARRAY_SIZE(ad7616_sw_scale_avail);
+			cs->range = 2;
+		}
 
-	num_scales_avail_show = 1;
+		ret = st->bops->sw_mode_config(indio_dev);
+		break;
+	}
 
 	for (ch = 0; ch < num_channels; ch++) {
 		struct ad7606_chan_scale *cs;
@@ -667,9 +886,16 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->oversampling = 1;
 
 	cs = &st->chan_scales[0];
-	cs->range = 0;
-	cs->scale_avail = ad7606_scale_avail;
-	cs->num_scales = ARRAY_SIZE(ad7606_scale_avail);
+	switch (id) {
+	case ID_AD7606C_18:
+		cs->scale_avail = ad7606_18bit_hw_scale_avail;
+		cs->num_scales = ARRAY_SIZE(ad7606_18bit_hw_scale_avail);
+		break;
+	default:
+		cs->scale_avail = ad7606_16bit_hw_scale_avail;
+		cs->num_scales = ARRAY_SIZE(ad7606_16bit_hw_scale_avail);
+		break;
+	}
 
 	ret = devm_regulator_get_enable(dev, "avcc");
 	if (ret)
@@ -718,7 +944,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->write_scale = ad7606_write_scale_hw;
 	st->write_os = ad7606_write_os_hw;
 
-	ret = ad7606_sw_mode_setup(indio_dev);
+	ret = ad7606_sw_mode_setup(indio_dev, id);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index d71a843a5de5..fa9305923a72 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -22,7 +22,7 @@
 		.scan_type = {					\
 			.sign = 's',				\
 			.realbits = (bits),			\
-			.storagebits = (bits),			\
+			.storagebits = (bits) > 16 ? 32 : 16,	\
 			.endianness = IIO_CPU,			\
 		},						\
 }
@@ -45,7 +45,7 @@
 		.scan_type = {					\
 			.sign = 's',				\
 			.realbits = (bits),			\
-			.storagebits = (bits),			\
+			.storagebits = (bits) > 16 ? 32 : 16,	\
 			.endianness = IIO_CPU,			\
 		},						\
 }
@@ -88,12 +88,15 @@ struct ad7606_chip_info {
  *			such that it can be read via the 'read_avail' hook
  * @num_scales		number of elements stored in the scale_avail array
  * @range		voltage range selection, selects which scale to apply
+ * @reg_offset		offset for the register value, to be applied when
+ *			writing the value of 'range' to the register value
  */
 struct ad7606_chan_scale {
 	const unsigned int		*scale_avail;
 	const unsigned int		*scale_avail_show;
 	unsigned int			num_scales;
 	unsigned int			range;
+	unsigned int			reg_offset;
 };
 
 /**
@@ -150,9 +153,13 @@ struct ad7606_state {
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
-	 * 16 * 16-bit samples + 64-bit timestamp
+	 * 16 * 16-bit samples + 64-bit timestamp - for AD7616
+	 * 8 * 32-bit samples + 64-bit timestamp - for AD7616C-18 (and similar)
 	 */
-	unsigned short			data[20] __aligned(IIO_DMA_MINALIGN);
+	union {
+		unsigned short d16[20];
+		unsigned int d32[10];
+	} data __aligned(IIO_DMA_MINALIGN);
 	__be16				d16[2];
 };
 
@@ -191,6 +198,8 @@ enum ad7606_supported_device_ids {
 	ID_AD7606_6,
 	ID_AD7606_4,
 	ID_AD7606B,
+	ID_AD7606C_16,
+	ID_AD7606C_18,
 	ID_AD7616,
 };
 
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index dd0075c97c24..73a7b0007bf8 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -45,6 +45,8 @@
 #define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
 #define AD7606_OS_MODE			0x08
 
+#define AD7606C_18_SAMPLE_MASK		GENMASK(17, 0)
+
 static const struct iio_chan_spec ad7616_sw_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(16),
 	AD7616_CHANNEL(0),
@@ -77,6 +79,18 @@ static const struct iio_chan_spec ad7606b_sw_channels[] = {
 	AD7606_SW_CHANNEL(7, 16),
 };
 
+static const struct iio_chan_spec ad7606c_18_sw_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+	AD7606_SW_CHANNEL(0, 18),
+	AD7606_SW_CHANNEL(1, 18),
+	AD7606_SW_CHANNEL(2, 18),
+	AD7606_SW_CHANNEL(3, 18),
+	AD7606_SW_CHANNEL(4, 18),
+	AD7606_SW_CHANNEL(5, 18),
+	AD7606_SW_CHANNEL(6, 18),
+	AD7606_SW_CHANNEL(7, 18),
+};
+
 static const unsigned int ad7606B_oversampling_avail[9] = {
 	1, 2, 4, 8, 16, 32, 64, 128, 256
 };
@@ -120,6 +134,56 @@ static int ad7606_spi_read_block(struct device *dev,
 	return 0;
 }
 
+static int ad7606_spi_read_block18to32(struct device *dev,
+				       int count, void *buf)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	u32 i, bit_buffer, buf_size, bit_buf_size;
+	u32 *data = buf;
+	u8 *bdata = buf;
+	int j, ret;
+
+	/**
+	 * With the 18 bit ADC variants (here) is that we can't assume that all
+	 * SPI controllers will pad 18-bit sequences into 32-bit arrays,
+	 * so we need to do a bit of buffer magic here.
+	 * Alternatively, we can have a variant of this function that works
+	 * for SPI controllers that can pad 18-bit samples into 32-bit arrays.
+	 */
+
+	/* Write 'count' bytes to the right, to not overwrite samples */
+	bdata += count;
+
+	/* Read 24 bits only, as we'll only get samples of 18 bits each */
+	buf_size = count * 3;
+	ret = spi_read(spi, bdata, buf_size);
+	if (ret < 0) {
+		dev_err(&spi->dev, "SPI read error\n");
+		return ret;
+	}
+
+	bit_buffer = 0;
+	bit_buf_size = 0;
+	for (j = 0, i = 0; i < buf_size; i++) {
+		u32 sample;
+
+		bit_buffer = (bit_buffer << 8) | bdata[i];
+		bit_buf_size += 8;
+
+		if (bit_buf_size < 18)
+			continue;
+
+		bit_buf_size -= 18;
+		sample = (bit_buffer >> bit_buf_size) & AD7606C_18_SAMPLE_MASK;
+		data[j++] = sign_extend32(sample, 17);
+
+		if (j == count)
+			break;
+	}
+
+	return 0;
+}
+
 static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
 {
 	struct spi_device *spi = to_spi_device(st->dev);
@@ -283,6 +347,19 @@ static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static int ad7606c_18_sw_mode_config(struct iio_dev *indio_dev)
+{
+	int ret;
+
+	ret = ad7606B_sw_mode_config(indio_dev);
+	if (ret)
+		return ret;
+
+	indio_dev->channels = ad7606c_18_sw_channels;
+
+	return 0;
+}
+
 static const struct ad7606_bus_ops ad7606_spi_bops = {
 	.read_block = ad7606_spi_read_block,
 };
@@ -305,6 +382,15 @@ static const struct ad7606_bus_ops ad7606B_spi_bops = {
 	.sw_mode_config = ad7606B_sw_mode_config,
 };
 
+static const struct ad7606_bus_ops ad7606c_18_spi_bops = {
+	.read_block = ad7606_spi_read_block18to32,
+	.reg_read = ad7606_spi_reg_read,
+	.reg_write = ad7606_spi_reg_write,
+	.write_mask = ad7606_spi_write_mask,
+	.rd_wr_cmd = ad7606B_spi_rd_wr_cmd,
+	.sw_mode_config = ad7606c_18_sw_mode_config,
+};
+
 static int ad7606_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
@@ -315,8 +401,12 @@ static int ad7606_spi_probe(struct spi_device *spi)
 		bops = &ad7616_spi_bops;
 		break;
 	case ID_AD7606B:
+	case ID_AD7606C_16:
 		bops = &ad7606B_spi_bops;
 		break;
+	case ID_AD7606C_18:
+		bops = &ad7606c_18_spi_bops;
+		break;
 	default:
 		bops = &ad7606_spi_bops;
 		break;
@@ -333,6 +423,8 @@ static const struct spi_device_id ad7606_id_table[] = {
 	{ "ad7606-6", ID_AD7606_6 },
 	{ "ad7606-8", ID_AD7606_8 },
 	{ "ad7606b",  ID_AD7606B },
+	{ "ad7606c-16",  ID_AD7606C_16 },
+	{ "ad7606c-18",  ID_AD7606C_18 },
 	{ "ad7616",   ID_AD7616 },
 	{}
 };
@@ -344,6 +436,8 @@ static const struct of_device_id ad7606_of_match[] = {
 	{ .compatible = "adi,ad7606-6" },
 	{ .compatible = "adi,ad7606-8" },
 	{ .compatible = "adi,ad7606b" },
+	{ .compatible = "adi,ad7606c-16" },
+	{ .compatible = "adi,ad7606c-18" },
 	{ .compatible = "adi,ad7616" },
 	{ },
 };
-- 
2.46.0


