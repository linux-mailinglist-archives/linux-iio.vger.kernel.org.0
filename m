Return-Path: <linux-iio+bounces-19284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4133DAAF780
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 12:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C3D1BC4F80
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 10:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FE9223336;
	Thu,  8 May 2025 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F9211VZI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0BA21146C
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746698854; cv=none; b=iRPEwCFNsONpot9iacgGeR8xiHR6n526ko+OkfwMVJau+dJ4AC7wZqQx+kTqoCtVKXGpUSn7mLgMdxXewrSAXbO+TvF93wAocjUckWW159Avkxg8pZYUm3B1jgHsLCfGAxgliLZRKo/+eBjS0x3xLpFJ60HsXC5buztju/gh/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746698854; c=relaxed/simple;
	bh=LaGh0Kujnup56yjDawQUQI97S1eYBLbTsxHVwVAGhQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WBktE23t5oLvaENfEzTwBWux3NqfLo7jFoelvIs9b+yQwGXRA3P1qzVZiHqFVAEV3iPQNlRpYv0/D3BQUf/jv4AhmWPZuaQyza0E0cHuviVZPk5t6L/CJehumZrgrdWwW2at3jWuKrbe64V89lCqxllhPVDehDWwdouU9woV6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F9211VZI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso8642065e9.1
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 03:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746698851; x=1747303651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCwW3EHexWqSBzmEUcVwhny0/+RhPmV0FH0hxwaO9ag=;
        b=F9211VZIiZdRmIMOTtLPe0cNGq8CVcGCgaW4uJNbJeCa0Awc9kYMvYrZnjanAYndCa
         iHE0zwoja5nQ4FgifeOrpFm7a45h/3I2szXcBurtWIwggkQbE4sHx4YKYUFcAj9dwK/M
         kqpsZFC4zNec7SD17AlC0qJQ1iAyL96Fb4HEVUZd/qqcmWa0A6hNxAqiHol2CqIXdAAV
         umB3vmL5Qsn0tYkK49vsOfZcDxQ5bQX7g2yZH4XCA+MFIaNnqYb/9/UObNIzdYlrT33w
         9rp6A6vU0/VUuo5awiLQ498H1a93AWaTEGcULirSANcilmClVUSRAuUr31QRi7BuvDge
         +JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746698851; x=1747303651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCwW3EHexWqSBzmEUcVwhny0/+RhPmV0FH0hxwaO9ag=;
        b=lLosCARgUpU6dDniddBLMKIyGjlGX1SV8ly/7smR3D0DHw0hG5k5iEwWK8B1D/NqFe
         5BhFgiCQEd3IMaSXbHRi1dkRIjS1vx+bOmVQUDsNZXEGHE2Jkk//1lbYzs5rUdtpsGa/
         ohHU1mwJMnwxTJ85Toupp5NgPnP3X5LOYDa7pMIZB6GStAHP7IdIPW7RlAaRbOVMn0uH
         wv8CZTmYZwBL5Ul4fjfHTMhi1M5PHBXlX174kDtqEHCd9DcNxOE7Uw/J+hKxrVLm8PgW
         VIZAmhnvjUlTFrW+XhmqXQWuKxkPSnJBuymIJN/7n78LxSn0gloo34o7Pp7lRV2KDtai
         NjSw==
X-Gm-Message-State: AOJu0Ywet5rFBBV3nuYYrUxBXkt7OaXe4r751TGjM2zymjR0Wh8UvQZ0
	F1PuRdy0DnuRUTtRLVLju3TOWt/4lm3rWwjMmu9TqHDIzYco4kj/a8CrF4nsJB0=
X-Gm-Gg: ASbGncuq8DCIkusQ4dUCoNZlXwWd9W0ZOSLXFylIdgF/S+lWFazxHIl1UFwEJb7ozbz
	v0bd1AY4/Qkllx2+JmYNXWxiLs1KAzJw6TrvaAGOkxTLP4HrnEVceza2hgEpWipTpHrDZcblKSQ
	MiOQsodlt6l8vWpPwVWmo75wQVs4rlrVH/r+L+QwpWr7wG/kRzCJVD7ZL7pi/UM3BJi2lij8dvA
	OUergcHKDMeiPBCrfoLgZIH0YoyATKf5FI5vmsb4/2o+dl9oDE0+Z9P7eHlMkXzHkKljqq5x1Qc
	S+ZBHjhY22r7RQ1E/rj5ny/lpyHFbzoo5Iimhad1MMjwhybiLt/rhkjgUDQqVztYH2OG+Nej8pQ
	kd7K5hq1E97QS
X-Google-Smtp-Source: AGHT+IFHXa2KsEyS/1hw19kNchTVBACJ7US3YxgxvrYog0GndSzf22ZeUUFPoP0SJ8iME5FDsfeUEA==
X-Received: by 2002:a05:600d:1b:b0:43c:ef55:f1e8 with SMTP id 5b1f17b1804b1-442d19207ebmr19677655e9.13.1746698851008;
        Thu, 08 May 2025 03:07:31 -0700 (PDT)
Received: from [192.168.0.2] (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd363940sm31699665e9.25.2025.05.08.03.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 03:07:30 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 08 May 2025 12:06:09 +0200
Subject: [PATCH v4 5/5] iio: adc: ad7606: add gain calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250508-wip-bl-ad7606-calibration-v4-5-91a3f2837e6b@baylibre.com>
References: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
In-Reply-To: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5809;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=V2tKK2iV+MzCpP+CvjJLJlOfjDRuO88z48EIieZNapU=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiQaRKo7pqUESMewPJdQdv+4mcX7oToq+uOqIYznC9qW
 MuoneHYUcrCIMbFICumyFKXGGESejtUSnkB42yYOaxMIEMYuDgFYCI3LjH8D+iz/X9Q5Pip+Hdz
 Izu17933+JpTY5inWMhiLSG35OaTDQx/pV9qNvJ9e8b0Xl+t/tjC3guPBO9dkCxZ/nWzUaDfAqP
 5DAA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add gain calibration support, using resistor values set on devicetree,
values to be set accordingly with ADC external RFilter, as explained in
the ad7606c-16 datasheet, rev0, page 37.

Usage example in the fdt yaml documentation.

Tested-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h |  3 +++
 2 files changed, 64 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index a986eb1284106da4980ac36cb0b5990e4e3bd948..be86e14ba85d07398e870ad680764958aa6ef471 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -33,6 +33,10 @@
 
 #include "ad7606.h"
 
+#define AD7606_CALIB_GAIN_MIN	0
+#define AD7606_CALIB_GAIN_STEP	1024
+#define AD7606_CALIB_GAIN_MAX	(63 * AD7606_CALIB_GAIN_STEP)
+
 /*
  * Scales are computed as 5000/32768 and 10000/32768 respectively,
  * so that when applied to the raw values they provide mV values.
@@ -125,6 +129,7 @@ static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan);
 static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
 static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
+static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev);
 
 const struct ad7606_chip_info ad7605_4_info = {
 	.max_samplerate = 300 * KILO,
@@ -180,6 +185,7 @@ const struct ad7606_chip_info ad7606b_info = {
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
 	.calib_offset_avail = ad7606_calib_offset_avail,
 	.calib_phase_avail = ad7606b_calib_phase_avail,
 };
@@ -195,6 +201,7 @@ const struct ad7606_chip_info ad7606c_16_info = {
 	.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
 	.calib_offset_avail = ad7606_calib_offset_avail,
 	.calib_phase_avail = ad7606c_calib_phase_avail,
 };
@@ -246,6 +253,7 @@ const struct ad7606_chip_info ad7606c_18_info = {
 	.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
 	.offload_storagebits = 32,
+	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
 	.calib_offset_avail = ad7606c_18bit_calib_offset_avail,
 	.calib_phase_avail = ad7606c_calib_phase_avail,
 };
@@ -357,6 +365,52 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 	return 0;
 }
 
+static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int num_channels = st->chip_info->num_adc_channels;
+	struct device *dev = st->dev;
+	int ret;
+
+	/*
+	 * This function is called once, and parses all the channel nodes,
+	 * so continuing on next channel node on errors, informing of them.
+	 */
+	device_for_each_child_node_scoped(dev, child) {
+		u32 reg, r_gain;
+
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			continue;
+
+		/* Chan reg is a 1-based index. */
+		if (reg < 1 || reg > num_channels) {
+			dev_warn(dev, "wrong ch number (ignoring): %d\n", reg);
+			continue;
+		}
+
+		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
+					       &r_gain);
+		if (ret)
+			/* Keep the default register value. */
+			continue;
+
+		if (r_gain > AD7606_CALIB_GAIN_MAX) {
+			dev_warn(dev, "wrong gain calibration value");
+			continue;
+		}
+
+		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
+			DIV_ROUND_CLOSEST(r_gain, AD7606_CALIB_GAIN_STEP));
+		if (ret) {
+			dev_warn(dev, "error writing r_gain");
+			continue;
+		}
+	}
+
+	return 0;
+}
+
 static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan)
 {
@@ -1448,6 +1502,13 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
 	if (slow_bus)
 		channels[i] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(i);
 
+	/* Setting up gain calibration for all channels. */
+	if (st->sw_mode_en && st->chip_info->calib_offset_avail) {
+		ret = st->chip_info->calib_gain_setup_cb(indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	indio_dev->channels = channels;
 
 	return 0;
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index f613583a7fa4095115b0b28e3f8e51cd32b93524..6313eea2bd0ccf97222a50dc26d8ec65042d0db7 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -50,6 +50,7 @@ struct ad7606_state;
 typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
 				       struct iio_chan_spec *chan);
 typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
+typedef int (*ad7606_calib_gain_setup_cb_t)(struct iio_dev *indio_dev);
 
 /**
  * struct ad7606_chip_info - chip specific information
@@ -66,6 +67,7 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
  * @init_delay_ms:	required delay in milliseconds for initialization
  *			after a restart
  * @offload_storagebits: storage bits used by the offload hw implementation
+ * @calib_gain_setup_cb: callback to setup of gain calibration
  * @calib_offset_avail: pointer to offset calibration range/limits array
  * @calib_phase_avail:  pointer to phase calibration range/limits array
  */
@@ -81,6 +83,7 @@ struct ad7606_chip_info {
 	bool				os_req_reset;
 	unsigned long			init_delay_ms;
 	u8				offload_storagebits;
+	ad7606_calib_gain_setup_cb_t	calib_gain_setup_cb;
 	const int			*calib_offset_avail;
 	const int			(*calib_phase_avail)[2];
 };

-- 
2.49.0


