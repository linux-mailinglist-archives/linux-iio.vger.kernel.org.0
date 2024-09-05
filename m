Return-Path: <linux-iio+bounces-9171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD41596D200
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 10:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E88285877
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 08:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1B8197A76;
	Thu,  5 Sep 2024 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FSsfrIon"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CFF194139
	for <linux-iio@vger.kernel.org>; Thu,  5 Sep 2024 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524662; cv=none; b=I67iSU9QdAc41a/BHIlVRp4oxHtwOA/GG7h9tW2VipLO0FOaeCODlZ3TUCE2ZdkBs5kQccoPR72beLLd9YetzqSbBStgMVPDi2gm7x28wNs9nPaGSZa2wLJd8lXtCQCnWsTvpLf6Y/x7/HO+SOc8KS7Cp8fRbf6RGHEFYQbfBls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524662; c=relaxed/simple;
	bh=nVbw190QbFvntpv2F3+c7kcWkCwggr81hIv8yKcYO0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MydZIoZFUyvQPChEHhKZPNQjokfcEw9hJCjAsIBiNwfEYws9e4vGPBTTFv4N+12Kuy2Ft3ESm7EdA+W2aUELDYtP0LcP+yvb2tn6BtgThplVUYiFtNa8kHwSlScKFZ+sXJBkPrR6GDubANPcqm+hGBmDyNQGXgUCsYpvu9rs/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FSsfrIon; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f74e468aa8so1291261fa.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Sep 2024 01:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725524658; x=1726129458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VP40VYCR8trduWJE1JYza3M6qtnB5tUGujhHJKROTmg=;
        b=FSsfrIonIRx+lqW6+oxXa+/Jr4yI5a8yee8pp8M4Qp8xeI88CGL1zy67e4p74mNhWH
         JXTk6Fn8wQYzkwMXvv4Hv2xOMf8fX/8+3RP6ejavapNvseLWYO77FtQ8SrKxmDkKk8Z3
         wukKn/YiOzzezCY8ymsjdhxrOCBjmAx1+H5e6xzTjCMEoVS8fy3e0XoSjIhTryBe2My1
         qy9xiETuNqBhj01KgitmLo2SV4utSA/AbVOSg6kZPTUwPy7BHk+HbSbA/WCZTNV2uV9r
         97kjHU+80JP3taxbLAXMKMDIEB/L0MSFSY9d2BtHuk3w1jfUz/i4E2iQCHCH6qvsmIi1
         f6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524658; x=1726129458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VP40VYCR8trduWJE1JYza3M6qtnB5tUGujhHJKROTmg=;
        b=XyvPcky6Yah6FaFzvho+rgkVWU9aA66XKnGXG7J7ZCErJ7gEj6dG8ouRQOGBow4yG6
         OdiWjwpNBW0W+uRluydIlg7Objm7LHFEPcSW36lARMFXBJ47WAFLq124BNIGC9MvnNy5
         9bddifSJEgygYCsQ/KYJzPeKCbRDLvGFwAysdR40TNl7NznWdeojZI+2WWkPHFdDXZWu
         0qbFAsjpI/96cDgUi8Gk3fPq6qVtgYLGsB7xC7goReNpyNF9BX8PmvC7KdYwhBwm4J7q
         +ZhxFkGm+3ZLOv3x3Q9BACFZ7f7Jmezfertm3D3WiKp+Zk7VMtpfr+cjNw4xFG2k2KbC
         dJEg==
X-Gm-Message-State: AOJu0YyM4MK5TS1ip0VXjBHJdptk60QCOyGfFqgGkPiBzJWTzf7TaUus
	Oc2sEClSiidpOSJl8FK+hRG436uwbRBcjKBy+BvtUjiAs4ehVpRgeV1Twsu+r+Xg1zjm2Sh+UdX
	3YJI=
X-Google-Smtp-Source: AGHT+IHmi5jxxopFnmutzL8/6MWeq0rpUDvbCBpGqbzVbF0c/vORPSOhCkrOwQdegUJ8Za4qK584fw==
X-Received: by 2002:a05:6512:33cb:b0:52c:f3fa:86c with SMTP id 2adb3069b0e04-53546b25743mr14493703e87.18.1725524657493;
        Thu, 05 Sep 2024 01:24:17 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6c80sm102300366b.174.2024.09.05.01.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 01:24:17 -0700 (PDT)
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
Subject: [PATCH v4 5/8] iio: adc: ad7606: rework available attributes for SW channels
Date: Thu,  5 Sep 2024 11:23:59 +0300
Message-ID: <20240905082404.119022-6-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905082404.119022-1-aardelean@baylibre.com>
References: <20240905082404.119022-1-aardelean@baylibre.com>
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
The allocation will happen when then ad7606_state struct is allocated.
The oversampling available parameters don't need any extra processing; they
can just be passed back to userspace (as they are).

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 63 ++++++++++++++++++++++++++++++++++++----
 drivers/iio/adc/ad7606.h | 31 +++++++++++++++++---
 2 files changed, 85 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 2554a4a4a9c0..4c3fbb28f790 100644
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
 
@@ -554,7 +585,7 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 {
 	unsigned int num_channels = indio_dev->num_channels - 1;
 	struct ad7606_state *st = iio_priv(indio_dev);
-	int ch;
+	int ret, ch;
 
 	if (!st->bops->sw_mode_config)
 		return 0;
@@ -563,7 +594,7 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 	if (!st->sw_mode_en)
 		return 0;
 
-	indio_dev->info = &ad7606_info_os_range_and_debug;
+	indio_dev->info = &ad7606_info_sw_mode;
 
 	/* Scale of 0.076293 is only available in sw mode */
 	/* After reset, in software mode, ±10 V is set by default */
@@ -575,7 +606,29 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 		cs->range = 2;
 	}
 
-	return st->bops->sw_mode_config(indio_dev);
+	ret = st->bops->sw_mode_config(indio_dev);
+	if (ret)
+		return ret;
+
+	for (ch = 0; ch < num_channels; ch++) {
+		struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+		int i;
+
+		cs = &st->chan_scales[ch];
+
+		if (cs->num_scales * 2 > AD760X_MAX_SCALE_SHOW) {
+			dev_err(st->dev, "Driver error: scale range too big");
+			return -ERANGE;
+		}
+
+		/* Generate a scale_avail list for showing to userspace */
+		for (i = 0; i < cs->num_scales; i++) {
+			cs->scale_avail_show[i * 2] = 0;
+			cs->scale_avail_show[i * 2 + 1] = cs->scale_avail[i];
+		}
+	}
+
+	return 0;
 }
 
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index afe6a4030e0e..2113ad460c0f 100644
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
@@ -65,11 +84,15 @@ struct ad7606_chip_info {
 /**
  * struct ad7606_chan_scale - channel scale configuration
  * @scale_avail		pointer to the array which stores the available scales
+ * @scale_avail_show	a duplicate of 'scale_avail' which is readily formatted
+ *			such that it can be read via the 'read_avail' hook
  * @num_scales		number of elements stored in the scale_avail array
  * @range		voltage range selection, selects which scale to apply
  */
 struct ad7606_chan_scale {
+#define AD760X_MAX_SCALE_SHOW		(AD760X_MAX_CHANNELS * 2)
 	const unsigned int		*scale_avail;
+	int				scale_avail_show[AD760X_MAX_SCALE_SHOW];
 	unsigned int			num_scales;
 	unsigned int			range;
 };
-- 
2.46.0


