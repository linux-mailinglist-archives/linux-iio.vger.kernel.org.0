Return-Path: <linux-iio+bounces-19936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86802AC3DA8
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 12:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB2F1898097
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 10:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC01FDA61;
	Mon, 26 May 2025 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tlwiup4Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B451F4C94
	for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253894; cv=none; b=ImC9XLfmaYqnFPGBhDK2NLkN0JYeoRo2qRXJtNcuUYvuTSsaieI/Gl08+uLUWpGlQ/BV2/m2mOXPSL+cXzwXvv2cYhZ6oRaJelAOaKn1PxIItb37smYUOq7CPCkbi+7BVBwPbi+ocGaP8oHqlb8ZEwSDXD7eF5U9TWKJV3HRizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253894; c=relaxed/simple;
	bh=+6B4Ob+yfzec6F/Q3oyJRE9udnynOrOuj3LLQ6kkxsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/tKMK2XyqcirJe1AKfqEccRc6hxTNZ4mQfPHTRa3giMPOqyKAZeuC4KKjeLeMhJCIxh9/rU/D/lYae82g9oBZ/Qx0i5P0ijYRbgLQeBG/XFHDlI0ei4g9P2JCFSg9YQOgfsW1TxNLWAMWOmcqpe8y1gwRniteuBswa0BM9D/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tlwiup4Y; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-441c99459e9so12252455e9.3
        for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 03:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748253890; x=1748858690; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0tSdZHx7w1B//uEapJ6mnjhDL7NbW0bow2VA9wTvIw=;
        b=tlwiup4Ym9MTVzU/Yje7LUL6h/0fWuSxaY1FDCAIekR/6/D+585vYbKMqcUKJLe979
         c6+omtoUshiEEcGLErB2ARAgtuyMix+0hok/iCgVx5RjS4kNWOzs30kWQz7Ln3r1Dg4x
         a7X42pcl2kBLETttmW1KD2Xc7vF3MRCNywcibWg9zyf57LrJI0rbVA/x0m/D74Ehy7AB
         r83/pOfuwx2F60J1cq8ySWd1DNhQB+kuUMumYra46Z5ftQ4LlGuFd4QnBKgHD3inVZp6
         hjxkPHP5zQJohB9YRRUb2kfComv9UGRmH9E29t8cIUpGU48oCSUbAGnHyizJV45Y8jeY
         VVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253890; x=1748858690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0tSdZHx7w1B//uEapJ6mnjhDL7NbW0bow2VA9wTvIw=;
        b=M4JZDAQLUtSrQGQDferYI2CtdC5M3hagrpzejyVhWv56p/Bd3AbQwdN/H+Rrjrv9Jp
         hkITkZ2KJOcJuz5BSdv+JZu3+Lpn8rL0PFJYWfu3LTW+NWP2aZqzGdHhuNU3TAab6dgX
         /4DRvpo8F/gKCtKXISSg+DeqTjQKWrrcOx+mSFQn+wXqt+Oef4SibbVpiVKYTi/OcP0q
         /yiYaPHvDp0Wf2yyWkPinQFoVMjsXvZEJKUv0mhCNvXZQ3nCwLXfSaz+6p8YZSwycVEB
         5dtjP1L8EHqJczRNtkcq5idraESyG6STShiaztQ8Xi1iujubmE4FSuMzNnZTyVwL9uHT
         uzjg==
X-Gm-Message-State: AOJu0YwzhahU2yI1HxBpYHoS3Uv2/RO1ghyCF8k8vSo5WUet34L7GtRr
	UUse+ZGN2OnIDjou7LRtg1v9zpZVJ9b7iDmIk94dIf/hMI97yunwS0txqgW9uBNoHZk=
X-Gm-Gg: ASbGncv5JUHVgHW9b/NY/b2nrXsXixXSrNqE3vdFFHLj4toaFDZ5QliQ69XG0vTqp5J
	wO/NpNX6qHyRYLAcLzUNgs4DNoo/j4qOvMBuCiFMw9raRq/7j98tEkyw8dHCwFpdXOWUZhB8wlh
	FdeVyRhAm0DuuYNaPGpzC7HFiqa2I04ZBmg67JUfngVciRCtpGqUfIdGw4Dals+DYkwDdkB5y9p
	mOUI3JsO5sLihnQM02P0Yw6d+iIeHdHcAQVPqMzkwuSTOKJHlw/2NPJ9WqMu+7R8crJEd5Tq9GP
	zYN8aIt8Qi6mrk0ImqI1U5BCq5pLiLPKW361E9Qic4Jttvg51toju46rbjeL//O1PCe3DFJ8dCK
	XkLcQc2g0HZ9LA/on4Atf606Z89FacZw=
X-Google-Smtp-Source: AGHT+IGaJt2vHpqfKlS5cBDtDHQGsqtmwZDKEFRfCosf+8OmOWWt9tc/0NIdrcJ31CrE9tEfO9+IzQ==
X-Received: by 2002:a05:600c:4fc9:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-44c91ad70d0mr93867775e9.10.1748253890567;
        Mon, 26 May 2025 03:04:50 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca888fcsm36141834f8f.78.2025.05.26.03.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:04:50 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 26 May 2025 12:03:21 +0200
Subject: [PATCH v7 6/6] iio: adc: ad7606: add gain calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250526-wip-bl-ad7606-calibration-v7-6-b487022ce199@baylibre.com>
References: <20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com>
In-Reply-To: <20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5427;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=2enztWCaqivWNg+b+KQz77hVRXgwpcSxoo97MZwtRNU=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsgwscnepuFy44nCxIgXm87tebY6bIvu82tRyW5Hdu9TN
 plYLxdq0VHKwiDGxSArpshSlxhhEno7VEp5AeNsmDmsTCBDGLg4BWAiv3sY/tdMPfr8w9zq+U/b
 DQKPbQ2+fVwgoW+dWMGk1Lrc4OhzgVUM/ywKUhMS3hpZSzVI7xWfJ9Kpf+5I8fldDD7/z/jcssr
 N5QQA
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
 drivers/iio/adc/ad7606.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h |  3 +++
 2 files changed, 51 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index e0a666cc0e14255754e74daa9e1e88bc4ad1665c..3fe035d25024c174cb546f2e4b706b573abbe761 100644
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
@@ -355,6 +363,39 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 	return 0;
 }
 
+static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int num_channels = st->chip_info->num_adc_channels;
+	struct device *dev = st->dev;
+	int ret;
+
+	device_for_each_child_node_scoped(dev, child) {
+		u32 reg, r_gain;
+
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return ret;
+
+		/* Chan reg is a 1-based index. */
+		if (reg < 1 || reg > num_channels)
+			return ret;
+
+		r_gain = 0;
+		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
+					       &r_gain);
+		if (r_gain > AD7606_CALIB_GAIN_MAX)
+			return -EINVAL;
+
+		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
+			DIV_ROUND_CLOSEST(r_gain, AD7606_CALIB_GAIN_STEP));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan)
 {
@@ -1444,6 +1485,13 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
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


