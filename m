Return-Path: <linux-iio+bounces-9512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADD3978211
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 16:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1FC1F26237
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 14:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DBB1E00A3;
	Fri, 13 Sep 2024 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S1qNOCpR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF83B1DFE25
	for <linux-iio@vger.kernel.org>; Fri, 13 Sep 2024 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235880; cv=none; b=jprs/CCYzCVH2XCvK8qS3+Xxm/glcheH5Xh6e59W3CVXbUwLtgU/WgVftm69I8yIjMpinQoQQ0WgCslqDuOfuGyQAhVRwd9u2Ms2OUPz8Lhoe5+QIJc+tDPoO3l/rho097XT4qM+fgy8hXoxX1bBEygwlqZptasdcCU3Xz0axeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235880; c=relaxed/simple;
	bh=RzKqVRTlU4lc2tQgU6jZrPJ/xkgEk5frw6b90nEo2eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQO3+KIDkn8GIJSbVtBprhqyfDN+n7hgiEG8k3PXZm1aZOIF4Vyf9D64cmwCNFgUKoZz0sSkV01SmJR2Bca2g2SxF6UQULDyur8+9vYLGJz+o1/Bqx84CrX+gbLNk1UBVTjLgPsej9dVjTmpNcVvJSQa0mBFJb+KW1BhS0Hy9sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S1qNOCpR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-371ba7e46easo1659488f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Sep 2024 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726235877; x=1726840677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3L8FUnehujX20iEAFhi39bqT6dZ8dbQps0T02oejwI=;
        b=S1qNOCpRcSabwZOQQEvBZF1EndXw59hvqxTN/0GMheXoS7Iq9x+i66l104GO00sgCl
         TEjm3Es+729uhOjBgLirBtfHZEX+Ok9cGUovDIEEIAXPIC+zUERT3JJw79TuPHqJZabA
         Fbu4QGF12PgiN4j35KGe/SMBYr1zxbOSk/SL5/G/urMRPlw7esDAoIzwK92Us3y78hXj
         2LrZDpGuV7OFLKt6rBiDtWPb4uN7NS/Tq42WKwA5m4ZhmtnFqFy0EtpaYetDD2Tm3rCr
         gyY3P9aIbM7l8Mr0TFQtzpLQPB4J8ZMQZavBIdKDd0ukxsNGPXoX8Rhf3eP39dVeDBfN
         A2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726235877; x=1726840677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3L8FUnehujX20iEAFhi39bqT6dZ8dbQps0T02oejwI=;
        b=nIZO5d7L0GcwRhWKP9WRoTXKgEVKir8ouhmbiv+v7xU/jhx525uCZH/vmlGdeyaWdw
         /MBNOaTKoFpDA8Nrv1uVlGQY3oyRM2DXj9GW/0rmPDbCX5oQlkFxHyVQclluu7D44w51
         8KZtF3NxeIRs7SM6mKtXb9+GXQ/Vf0Hf6UauvBkz/iloyDIEI4Rt3UArbLmr6PxvVnvv
         4fbTS9JZNCHjhPHPLIWrqsToavoxW4z++cTo55NWaT/2L4rRxZLUigIReKRLOjRXC1K4
         XUMA/zuVjaIy5fH5/WogNaEsde6qVQNpHaoAPSNyfu3EOtoIu8sfMx9HspTW5HRZmr+S
         Tghw==
X-Gm-Message-State: AOJu0YxAboiYy9XF2e0zxhNp5sNOSjSNP++/T3cmBi3TWDWawlNsawWZ
	KlvKNpQt60uT1bapF9SuYseW67FOdmWc5CcnBtlPAe4vXBuCfJW6suBCRf97VYqsvfbAKp8BYcN
	+EiQ=
X-Google-Smtp-Source: AGHT+IEkI2KSw85IDTMbbhjtAvbfk8iwC6Thl/9VxphrlV2HxZV8p7CBZsprMsDXFbTh9L2M0wRbSw==
X-Received: by 2002:adf:ed08:0:b0:377:2ce0:a760 with SMTP id ffacd0b85a97d-378c2d5530bmr3992276f8f.49.1726235876633;
        Fri, 13 Sep 2024 06:57:56 -0700 (PDT)
Received: from neptune.lan ([188.27.129.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3941sm17104749f8f.84.2024.09.13.06.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:57:56 -0700 (PDT)
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
Subject: [PATCH v6 5/8] iio: adc: ad7606: rework available attributes for SW channels
Date: Fri, 13 Sep 2024 16:57:40 +0300
Message-ID: <20240913135744.152669-6-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913135744.152669-1-aardelean@baylibre.com>
References: <20240913135744.152669-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
The allocation will happen when then ad7606_state struct is allocated.
The oversampling available parameters don't need any extra processing; they
can just be passed back to userspace (as they are).

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c    | 52 ++++++++++++++++++++++++++++++++++---
 drivers/iio/adc/ad7606.h    | 32 ++++++++++++++++++++---
 drivers/iio/adc/ad7606_spi. |  0
 3 files changed, 77 insertions(+), 7 deletions(-)
 create mode 100644 drivers/iio/adc/ad7606_spi.

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 94a254c0725e..b909ee14fd81 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -512,6 +512,37 @@ static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
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
@@ -529,11 +560,11 @@ static const struct iio_info ad7606_info_os_and_range = {
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
 
@@ -564,7 +595,7 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 	if (!st->sw_mode_en)
 		return 0;
 
-	indio_dev->info = &ad7606_info_os_range_and_debug;
+	indio_dev->info = &ad7606_info_sw_mode;
 
 	return st->bops->sw_mode_config(indio_dev);
 }
@@ -576,9 +607,24 @@ static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
 	int ch, ret;
 
 	for (ch = 0; ch < num_channels; ch++) {
+		struct ad7606_chan_scale *cs;
+		int i;
+
 		ret = st->chip_info->scale_setup_cb(st, ch);
 		if (ret)
 			return ret;
+
+		cs = &st->chan_scales[ch];
+
+		if (cs->num_scales * 2 > AD760X_MAX_SCALE_SHOW)
+			return dev_err_probe(st->dev, -ERANGE,
+					"Driver error: scale range too big");
+
+		/* Generate a scale_avail list for showing to userspace */
+		for (i = 0; i < cs->num_scales; i++) {
+			cs->scale_avail_show[i * 2] = 0;
+			cs->scale_avail_show[i * 2 + 1] = cs->scale_avail[i];
+		}
 	}
 
 	return 0;
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 2b90f52affba..25e84efd15c3 100644
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
+			BIT(IIO_CHAN_INFO_RAW) |		\
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
+			.storagebits = (bits) > 16 ? 32 : 16,	\
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
 
 struct ad7606_state;
@@ -71,11 +90,16 @@ struct ad7606_chip_info {
 /**
  * struct ad7606_chan_scale - channel scale configuration
  * @scale_avail		pointer to the array which stores the available scales
+ * @scale_avail_show	a duplicate of 'scale_avail' which is readily formatted
+ *			such that it can be read via the 'read_avail' hook
  * @num_scales		number of elements stored in the scale_avail array
  * @range		voltage range selection, selects which scale to apply
  */
 struct ad7606_chan_scale {
+#define AD760X_MAX_SCALES		16
+#define AD760X_MAX_SCALE_SHOW		(AD760X_MAX_SCALES * 2)
 	const unsigned int		*scale_avail;
+	int				scale_avail_show[AD760X_MAX_SCALE_SHOW];
 	unsigned int			num_scales;
 	unsigned int			range;
 };
diff --git a/drivers/iio/adc/ad7606_spi. b/drivers/iio/adc/ad7606_spi.
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.46.0


