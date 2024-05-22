Return-Path: <linux-iio+bounces-5182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9B18CC3B7
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 17:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C301C22E5D
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B906C4F883;
	Wed, 22 May 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mh1NEQPS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9022940B
	for <linux-iio@vger.kernel.org>; Wed, 22 May 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390175; cv=none; b=tRGzT4uX4qZZcMbcah+faZibYAbWNAPzucMjTXmiHVLZa6x3a9wNTObvp22mqHBjiI555Q2ssdpw7c+AadzBoXj5J6c6d7tCSkIqEizumwoqm1xpBRnviWFvkxgY46CluzZmBjr6nk4gJ3MgjIdnLayjnTZh01ffthyefN99+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390175; c=relaxed/simple;
	bh=JkVbE4Y3WkBnzc/N2Xv7o2O7qEwpm7OELDM+ScIxCWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hj4Sg8ql2qornjEGOPFmGKNLyqD0fbdtLwl/O50l3Qm4ZdhG4suRlm9RaQSeX0deDSoY9vbiagCNRd0yuJESmG5kx+lAxts+fN2Z9zCkpthxKaq71Tz3Nc6YND83Yby3c8Q/wABIVZAwxT6CMzd0HzY3ouzBOyPqy8cJkvlyNik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mh1NEQPS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42011507a57so44922385e9.1
        for <linux-iio@vger.kernel.org>; Wed, 22 May 2024 08:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716390172; x=1716994972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hVNU4a78SiOOCC9kV1Z6zz+W5lUlkPH0msGia4TH6k=;
        b=mh1NEQPSJT7edR1mUFG6jXxxfmYkx5PQ1gyJ/6ZxnfTVsM0mUne63V+z6txuYfvcMH
         slV93Hum6nzf6Me3wRtEE8B/LRnNO0wiyMsRKRF3lMnwl7gM2e9TYnMT3Y6eXkxqy/i6
         JMT4fCAFzFSlhsCjwII3oDGZXYscln2F5Enf24tQpJVx62Ric12YeIbiHyQoHI7NBSWL
         /ioQSjLwulomN92/t/B1Y1N1K/L606Ii6U0sfEDcpzndMf8IQgOMCFohgU2QxlPlqRIA
         QlnNKuAWpuzLn9nAO3RqdoVVy9sRSEmcgzlfQhIWD8T/D/PRyl1grNBUat23rNKPw9Pp
         T5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716390172; x=1716994972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hVNU4a78SiOOCC9kV1Z6zz+W5lUlkPH0msGia4TH6k=;
        b=hLMIIkaW/VZwXta4OfwyGG2HrlMcUo8vU0ZrRAZfwbRj+kJIasnIWV0xBJ6QJms/N0
         WRJqczSjl25BPlnsOzUkNhy2ADwA+OLrH3ORfzDIDyhQT3illMBMxBPaZTJo+WrkS6yA
         w8844/9mMuTn/etCpI+VXGxWFwPmsqRBURJlg6YY1dp3UWniLRbfHmtjpUcj+8RqGZ6z
         ryVOCZ7/mEcFs1skuAlhlwGt3vVr0qclavhDEhr0kVaUEGAhl+94xMNm5iaJdzHtdaGV
         6f4lKm9JSDPtEgkyds1cibP8L043jMYSP6/2roMoHqZb2Iv0cIGPrMkBW3eT917mUbII
         4yhg==
X-Forwarded-Encrypted: i=1; AJvYcCUiEDS8UYbXMVGVy1tQrJIv6qygKwhjZZvucQPmds25grusgBZLGwk/Xm1QeQRRa2YIt/WwqZl+G4XgjiEhWmFaok0cCbVRf+8J
X-Gm-Message-State: AOJu0YwuH5CABgLbKFnNx64ofB9uYrSPyV6uiaksN+5xddHSjSHBlhQF
	02XADtbYbod/56J1nPcI0Zplb5NuTZiR3VJfoQNI/EZb7eAl5X+sBTpkGL/vNk0=
X-Google-Smtp-Source: AGHT+IF27wX7armSFJqEp/cFvKhhk93XUz8Ir9vmAoGFDVZiERrS9gpV1gcC/aNyMjhDab9+ifJTVA==
X-Received: by 2002:a05:600c:2108:b0:420:ef93:cd2f with SMTP id 5b1f17b1804b1-420fd321a7dmr18341595e9.21.1716390171912;
        Wed, 22 May 2024 08:02:51 -0700 (PDT)
Received: from localhost.localdomain (host-79-16-6-145.retail.telecomitalia.it. [79.16.6.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fa90e93absm531370515e9.9.2024.05.22.08.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:02:51 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: nuno.sa@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH v2 3/6] iio: dac: ad3552r: add model data structure
Date: Wed, 22 May 2024 17:01:38 +0200
Message-ID: <20240522150141.1776196-4-adureghello@baylibre.org>
X-Mailer: git-send-email 2.45.0.rc1
In-Reply-To: <20240522150141.1776196-1-adureghello@baylibre.org>
References: <20240522150141.1776196-1-adureghello@baylibre.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Angelo Dureghello <adureghello@baylibre.com>

Add a "model data" structure to keep useful hardware-related
information as from datasheet, avoiding id-based conditional
choices later on.

Removed id-based checks and filled model-specific structures
with device specific features, In particular, num_hw_channels
is introduced to keep the number of hardware implemented
channels, since 1-channel versions of the DACs are added
in this same patchset.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes for v2:
- patch added in v2
---
 drivers/iio/dac/ad3552r.c | 98 +++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index a492e8f2fc0f..6a40c7eece1f 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -261,7 +261,17 @@ struct ad3552r_ch_data {
 	bool	range_override;
 };
 
+struct ad3552r_model_data {
+	const char *model_name;
+	enum ad3542r_id chip_id;
+	unsigned int num_hw_channels;
+	const s32 (*ranges_table)[2];
+	int num_ranges;
+	bool requires_output_range;
+};
+
 struct ad3552r_desc {
+	const struct ad3552r_model_data *model_data;
 	/* Used to look the spi bus for atomic operations where needed */
 	struct mutex		lock;
 	struct gpio_desc	*gpio_reset;
@@ -271,7 +281,6 @@ struct ad3552r_desc {
 	struct iio_chan_spec	channels[AD3552R_NUM_CH + 1];
 	unsigned long		enabled_ch;
 	unsigned int		num_ch;
-	enum ad3542r_id		chip_id;
 };
 
 static const u16 addr_mask_map[][2] = {
@@ -745,13 +754,8 @@ static void ad3552r_calc_gain_and_offset(struct ad3552r_desc *dac, s32 ch)
 	} else {
 		/* Normal range */
 		idx = dac->ch_data[ch].range;
-		if (dac->chip_id == AD3542R_ID) {
-			v_min = ad3542r_ch_ranges[idx][0];
-			v_max = ad3542r_ch_ranges[idx][1];
-		} else {
-			v_min = ad3552r_ch_ranges[idx][0];
-			v_max = ad3552r_ch_ranges[idx][1];
-		}
+		v_min = dac->model_data->ranges_table[idx][0];
+		v_max = dac->model_data->ranges_table[idx][1];
 	}
 
 	/*
@@ -775,22 +779,14 @@ static void ad3552r_calc_gain_and_offset(struct ad3552r_desc *dac, s32 ch)
 	dac->ch_data[ch].offset_dec = div_s64(tmp, span);
 }
 
-static int ad3552r_find_range(u16 id, s32 *vals)
+static int ad3552r_find_range(const struct ad3552r_model_data *model_data,
+			      s32 *vals)
 {
-	int i, len;
-	const s32 (*ranges)[2];
+	int i;
 
-	if (id == AD3542R_ID) {
-		len = ARRAY_SIZE(ad3542r_ch_ranges);
-		ranges = ad3542r_ch_ranges;
-	} else {
-		len = ARRAY_SIZE(ad3552r_ch_ranges);
-		ranges = ad3552r_ch_ranges;
-	}
-
-	for (i = 0; i < len; i++)
-		if (vals[0] == ranges[i][0] * 1000 &&
-		    vals[1] == ranges[i][1] * 1000)
+	for (i = 0; i < model_data->num_ranges; i++)
+		if (vals[0] == model_data->ranges_table[i][0] * 1000 &&
+		    vals[1] == model_data->ranges_table[i][1] * 1000)
 			return i;
 
 	return -EINVAL;
@@ -955,9 +951,9 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 			dev_err(dev, "mandatory reg property missing\n");
 			goto put_child;
 		}
-		if (ch >= AD3552R_NUM_CH) {
+		if (ch >= dac->model_data->num_hw_channels) {
 			dev_err(dev, "reg must be less than %d\n",
-				AD3552R_NUM_CH);
+				dac->model_data->num_hw_channels);
 			err = -EINVAL;
 			goto put_child;
 		}
@@ -973,7 +969,7 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 				goto put_child;
 			}
 
-			err = ad3552r_find_range(dac->chip_id, vals);
+			err = ad3552r_find_range(dac->model_data, vals);
 			if (err < 0) {
 				dev_err(dev,
 					"Invalid adi,output-range-microvolt value\n");
@@ -987,9 +983,10 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 				goto put_child;
 
 			dac->ch_data[ch].range = val;
-		} else if (dac->chip_id == AD3542R_ID) {
+		} else if (dac->model_data->requires_output_range) {
 			dev_err(dev,
-				"adi,output-range-microvolt is required for ad3542r\n");
+				"adi,output-range-microvolt is required for %s\n",
+				dac->model_data->model_name);
 			err = -EINVAL;
 			goto put_child;
 		} else {
@@ -1011,7 +1008,8 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 	}
 
 	/* Disable unused channels */
-	for_each_clear_bit(ch, &dac->enabled_ch, AD3552R_NUM_CH) {
+	for_each_clear_bit(ch, &dac->enabled_ch,
+			   dac->model_data->num_hw_channels) {
 		err = ad3552r_set_ch_value(dac, AD3552R_CH_AMPLIFIER_POWERDOWN,
 					   ch, 1);
 		if (err)
@@ -1058,7 +1056,7 @@ static int ad3552r_init(struct ad3552r_desc *dac)
 	}
 
 	id |= val << 8;
-	if (id != dac->chip_id) {
+	if (id != dac->model_data->chip_id) {
 		dev_err(&dac->spi->dev, "Product id not matching\n");
 		return -ENODEV;
 	}
@@ -1068,7 +1066,6 @@ static int ad3552r_init(struct ad3552r_desc *dac)
 
 static int ad3552r_probe(struct spi_device *spi)
 {
-	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct ad3552r_desc *dac;
 	struct iio_dev *indio_dev;
 	int err;
@@ -1079,7 +1076,9 @@ static int ad3552r_probe(struct spi_device *spi)
 
 	dac = iio_priv(indio_dev);
 	dac->spi = spi;
-	dac->chip_id = id->driver_data;
+	dac->model_data = spi_get_device_match_data(spi);
+	if (!dac->model_data)
+		return -EINVAL;
 
 	mutex_init(&dac->lock);
 
@@ -1088,10 +1087,7 @@ static int ad3552r_probe(struct spi_device *spi)
 		return err;
 
 	/* Config triggered buffer device */
-	if (dac->chip_id == AD3552R_ID)
-		indio_dev->name = "ad3552r";
-	else
-		indio_dev->name = "ad3542r";
+	indio_dev->name = dac->model_data->model_name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ad3552r_iio_info;
 	indio_dev->num_channels = dac->num_ch;
@@ -1109,16 +1105,40 @@ static int ad3552r_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
+static const struct ad3552r_model_data ad3542r_model_data = {
+	.model_name = "ad3542r",
+	.chip_id = AD3542R_ID,
+	.num_hw_channels = 2,
+	.ranges_table = ad3542r_ch_ranges,
+	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
+	.requires_output_range = true,
+};
+
+static const struct ad3552r_model_data ad3552r_model_data = {
+	.model_name = "ad3552r",
+	.chip_id = AD3552R_ID,
+	.num_hw_channels = 2,
+	.ranges_table = ad3552r_ch_ranges,
+	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
+	.requires_output_range = false,
+};
+
 static const struct spi_device_id ad3552r_id[] = {
-	{ "ad3542r", AD3542R_ID },
-	{ "ad3552r", AD3552R_ID },
+	{
+		.name = "ad3542r",
+		.driver_data = (kernel_ulong_t)&ad3542r_model_data
+	},
+	{
+		.name = "ad3552r",
+		.driver_data = (kernel_ulong_t)&ad3552r_model_data
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad3552r_id);
 
 static const struct of_device_id ad3552r_of_match[] = {
-	{ .compatible = "adi,ad3542r"},
-	{ .compatible = "adi,ad3552r"},
+	{ .compatible = "adi,ad3542r", .data = &ad3542r_model_data },
+	{ .compatible = "adi,ad3552r", .data = &ad3552r_model_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad3552r_of_match);
-- 
2.45.0.rc1


