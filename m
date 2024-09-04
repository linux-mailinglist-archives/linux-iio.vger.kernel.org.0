Return-Path: <linux-iio+bounces-9121-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F59C96B2D7
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 09:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1FA285AB0
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 07:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBDA14D6ED;
	Wed,  4 Sep 2024 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vttD+hDn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802A14A4E1
	for <linux-iio@vger.kernel.org>; Wed,  4 Sep 2024 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434856; cv=none; b=YzrqJNWnDGOwaA42GMrtvOzH304xXEEA5HxNzVrcZ6j9O2TdASucrDXpxJPxsqn/rmPbgOzCKkk+30g1/Z5G7XDQiYxbCOMMGULGcfCOt6qRy9K1s+Gg3/yI+U6/b3DZy9EJqDAsCFEVFniWufUktb3wh7XqrXtG0er53pZ+dXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434856; c=relaxed/simple;
	bh=nVbw190QbFvntpv2F3+c7kcWkCwggr81hIv8yKcYO0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZktWyVk6Rdb/CCfk9cG5AzvXe7P13AJRPYRVrSF/SFgvuqFjQ8uFtdjt0nlEk3isrWxHGylPySHwzqASI4le/ylGPKqoy7lRQRLcuC40o6/6NUjsqNKGvPZLXyae0lzpHrNMwu6vCIBPz98Lbl+stQOTOQhHiqglFpFdK1WP3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vttD+hDn; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-533496017f8so8224935e87.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Sep 2024 00:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725434852; x=1726039652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VP40VYCR8trduWJE1JYza3M6qtnB5tUGujhHJKROTmg=;
        b=vttD+hDne2dAXcv4UhefUUVngRDn/JY7mCeBvybDN/5AeqSZFXfqZ1ovq+QPGlL1Ez
         MD7OQPPWI+4dOdSEwAAr+2mZfgcs/IWeX5xccL5Gq3TmbcaOHpGFZ3XG7EtSM4d93Aa4
         pv1FGwFfZmTvI/xq086MaduA827PiDHnzfUPNaZwBrFwF3H+6bXS74jjtAQVytjYAcQa
         lpplDRNfVRSLyPsLEfyaX/kKwHv2jPMjGHX4Q22WeSqIkzvauKmUHI5eg/QqnW9oQdw/
         EU+1Li6EHeuZhWSfPVxHBDoNt3AxK3ulmBsXewLfaum69lg9fx6J5SVLc7jUaHp9e2XU
         ykQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434852; x=1726039652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VP40VYCR8trduWJE1JYza3M6qtnB5tUGujhHJKROTmg=;
        b=iLjCpo1gBl8Z2r5T+grXpTKcMz5YbK5nWTfa1+lEJH8r26Dhj/a8aZryzwxjb00DXi
         GV3ak3zLCNg3zWtFGO+x0cvEjDhpDDZUnBJwSfribdiawo9n/2raTfU6WC0mWnbz8IFo
         JwF0ouHOXf/rXQitnBEsLuXxb1FJaE7YtEsNHm51on004+IMsp0yWixqLHbVg7ef4lqF
         +9f3L3FoH+oFsBXleHZFWtBNzaer3ldq397ujtoerJiajgGrBCJ1ic2CmqJLgaOQbAvz
         vAmHQf7KdI3yik/8tMaTxzB3tiFU2Et+fmYrarBKH5kwFdx38I+lVSVhKpjDmVBGVZcN
         eEaA==
X-Gm-Message-State: AOJu0Ywkb95yjRmxmL4Slme0idIzZ9I+XvOMr0tNVnrh4lvX1s5xMJ03
	a6f/kQmno2lUfa0/eOrFEf5sIM1ZvBMhPjMULcQPOAAwZcNc9Qbz07Mqq5YHolzoghtW3WReoPQ
	e3jU=
X-Google-Smtp-Source: AGHT+IHBDWSUfWh2iI0hlKtdvN+a5GYy6WXjsuNEDF7uKl0CsLCCVUmCq81WqE5zqRNmCwg0qOG9FQ==
X-Received: by 2002:a05:6512:3194:b0:52c:9e82:a971 with SMTP id 2adb3069b0e04-53546af527emr10190412e87.7.1725434852293;
        Wed, 04 Sep 2024 00:27:32 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d77fasm771151766b.167.2024.09.04.00.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:27:31 -0700 (PDT)
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
Subject: [PATCH v3 5/8] iio: adc: ad7606: rework available attributes for SW channels
Date: Wed,  4 Sep 2024 10:27:13 +0300
Message-ID: <20240904072718.1143440-6-aardelean@baylibre.com>
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


