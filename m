Return-Path: <linux-iio+bounces-14018-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0BFA05C06
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 13:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2250C1651C9
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE491F9F67;
	Wed,  8 Jan 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GmJQQgJn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0001FBC92
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340589; cv=none; b=VDmQRK7tx0i+JOHjS7dQZYVm5b7xzseVdpND5SOO3bLkCAEJeWcfv/I/RGK3lruE6hH/zAiQEMJ2SSG/CE6kdMurQHWE1VQWHkPqCQ8FY/HaDZHrh5AxVCjBfCu+Krzya48fWqXEBUbMgfnwD/Hb8iwmiVZP54+Ge/xJMVGVozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340589; c=relaxed/simple;
	bh=t81/yNLGUuGTbNCX3xw1FFNci9RHYp8JgJnWXFdWioA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TTRR7SAqjMY+X4jhbB9Vf6p108TMSvivLAFDfkeZbKHU4B+mn22XBQnjsEphh0oACyfpJ06JKDxCP+TetAp/tRRUHoYvvLbMO300r56F9dOSRIfBbJsqfE7PRaPkB8PrvVPnK+C9H4WqKDDOwf+6Sx/BYM6G8N8bG7BkEkWEla8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GmJQQgJn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4368a293339so135676265e9.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 04:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736340585; x=1736945385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ILpJ8cyEJ/3U1U5xHGXrfoZNcmFJHQkvJM8+6HPLCw=;
        b=GmJQQgJnGCOrW6YAvhp6x2ZGHdhVRb30S617ojkTUNRTQf/kau7iEzqPfa1JqA1Vio
         l5vJFh6g+7p0V++iW106O9LRe10MOugeoP/4NnkM4mNXf3qLN6MOi3abtsY2qNVARWos
         lj1rC9qIbnP62LnNIKBzppfAnLRhzGB5HNzQtV+q3U3d8upSZsR85kvT9cr8RzZjxFyw
         0AGc0+igdHo0ddoR4k623+5dtMYmXrnEKrUHuiHQzIdGxGByhBPXMmNl1WzlvpC+aU1p
         BJwfOVEuSeitLjMDCaUzV1lL6QQvrRAXD7nbD4LsybrOItsv2kGc3xluzm4zFDsg1hvi
         m8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736340585; x=1736945385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ILpJ8cyEJ/3U1U5xHGXrfoZNcmFJHQkvJM8+6HPLCw=;
        b=wg+IIH7z121HtTZXazrNIBHTjmvI11AzjxIvT5W28APApXVWpswKop6/WBDxRJqaEc
         OEdoaDmxkUwcaQCjT+IqlqiREVOMk10IZ7UOvVqGKnNFjtnZwD9+RYAPQt18fI5DfLj6
         /CmMOqnL8ClZBcrB/swlJW8/yzhS2rfZsxb8n3WB3tld4AVPrf1plRFWtLDmimWPTpaC
         Pu5VPz2DO9cxf+n1akjWEO3uRNO/AgJSzFMYE2bPK3fBwbXjVWCN6PIISCCq4ZpFh5G8
         tX942CjFE3o3jbn3rpgoN4bz+XvgYhn7WaeDvElN8iHkJPPCnEjuMwE9AlKp/KbEP7HP
         aDzg==
X-Gm-Message-State: AOJu0YzvK2rO1pw2DrJNxvLVOClcHndwnK0n96skCyZivEDx7+EQIZ9P
	5I0nvPT/Y7LciWXstiG3XiAuiP9C0lXEC9GpIy0yoAuYwVdlCcz2q/TSZBZR8zg=
X-Gm-Gg: ASbGncuAXo85WmBp0AiUnZkE4uT6lSG03wF5JCRFFEQYCleBNxsDJAhTb+iaTDtx0ZD
	Odon9oYNq4eaDikJlGpNCC93ZF80rSr8gSSNTXpRUjYimRVA4+wro0pT/8CqUD7ELBs1t4xyy89
	v51b9Ga2wwkPcQwvJGZm2oOtklmooelIG0N+itiIsMa7Vqw31grtAkxhesG9/xi3H1/qmFK9r5s
	hpRcU4SSLm7+KJbrPra7MlgFzjfK6BMnCzWmYZq2exd1fjAieO17wF7/dvHf1Hj84Q4QkCwzvpt
	ohSK+F5DdsClpC+A9us2/yGVcIh1ZzMdDfrMUWW0j36CTfODOOj2uw==
X-Google-Smtp-Source: AGHT+IEJUKPIsY0/+87opxSoC/qv+r+Aof0lKFXqkysIxkeur2mxHgvy0OB9e0pOpf72jDBsYf4V4A==
X-Received: by 2002:a05:600c:138a:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-436e271bcb3mr24895925e9.30.1736340585622;
        Wed, 08 Jan 2025 04:49:45 -0800 (PST)
Received: from jstephan-bl.local (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da63eesm19846805e9.3.2025.01.08.04.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:49:45 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 08 Jan 2025 13:49:35 +0100
Subject: [PATCH v4 3/5] iio: adc: ad7380: do not store osr in private data
 structure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-ad7380-add-alert-support-v4-3-1751802471ba@baylibre.com>
References: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
In-Reply-To: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Since regmap cache is now enabled, we don't need to store the
oversampling ratio in the private data structure.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 79 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index b97d2978289e92ad502cd6a67de43d2b51cdab56..a532de4422082df8503454d66fc49f75b52cff68 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -582,7 +582,6 @@ struct ad7380_state {
 	const struct ad7380_chip_info *chip_info;
 	struct spi_device *spi;
 	struct regmap *regmap;
-	unsigned int oversampling_ratio;
 	bool resolution_boost_enabled;
 	unsigned int ch;
 	bool seq;
@@ -710,6 +709,36 @@ static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
 	return ret;
 }
 
+/**
+ * ad7380_regval_to_osr - convert OSR register value to ratio
+ * @regval: register value to check
+ *
+ * Returns: the ratio corresponding to the OSR register. If regval is not in
+ * bound, return 1 (oversampling disabled)
+ *
+ */
+static int ad7380_regval_to_osr(unsigned int regval)
+{
+	if (regval >= ARRAY_SIZE(ad7380_oversampling_ratios))
+		return 1;
+
+	return ad7380_oversampling_ratios[regval];
+}
+
+static int ad7380_get_osr(struct ad7380_state *st, int *val)
+{
+	u32 tmp;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD7380_REG_ADDR_CONFIG1, &tmp);
+	if (ret)
+		return ret;
+
+	*val = ad7380_regval_to_osr(FIELD_GET(AD7380_CONFIG1_OSR, tmp));
+
+	return 0;
+}
+
 /*
  * When switching channel, the ADC require an additional settling time.
  * According to the datasheet, data is value on the third CS low. We already
@@ -725,11 +754,15 @@ static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
 			.unit = SPI_DELAY_UNIT_NSECS,
 		}
 	};
-	int ret;
+	int oversampling_ratio, ret;
 
 	if (st->ch == ch)
 		return 0;
 
+	ret = ad7380_get_osr(st, &oversampling_ratio);
+	if (ret)
+		return ret;
+
 	ret = regmap_update_bits(st->regmap,
 				 AD7380_REG_ADDR_CONFIG1,
 				 AD7380_CONFIG1_CH,
@@ -740,9 +773,9 @@ static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
 
 	st->ch = ch;
 
-	if (st->oversampling_ratio > 1)
+	if (oversampling_ratio > 1)
 		xfer.delay.value = T_CONVERT_0_NS +
-			T_CONVERT_X_NS * (st->oversampling_ratio - 1) *
+			T_CONVERT_X_NS * (oversampling_ratio - 1) *
 			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
 
 	return spi_sync_transfer(st->spi, &xfer, 1);
@@ -753,20 +786,25 @@ static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
  * @st:		device instance specific state
  * @scan_type:	current scan type
  */
-static void ad7380_update_xfers(struct ad7380_state *st,
+static int ad7380_update_xfers(struct ad7380_state *st,
 				const struct iio_scan_type *scan_type)
 {
 	struct spi_transfer *xfer = st->seq ? st->seq_xfer : st->normal_xfer;
 	unsigned int t_convert = T_CONVERT_NS;
+	int oversampling_ratio, ret;
 
 	/*
 	 * In the case of oversampling, conversion time is higher than in normal
 	 * mode. Technically T_CONVERT_X_NS is lower for some chips, but we use
 	 * the maximum value for simplicity for now.
 	 */
-	if (st->oversampling_ratio > 1)
+	ret = ad7380_get_osr(st, &oversampling_ratio);
+	if (ret)
+		return ret;
+
+	if (oversampling_ratio > 1)
 		t_convert = T_CONVERT_0_NS + T_CONVERT_X_NS *
-			(st->oversampling_ratio - 1) *
+			(oversampling_ratio - 1) *
 			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
 
 	if (st->seq) {
@@ -779,7 +817,7 @@ static void ad7380_update_xfers(struct ad7380_state *st,
 			st->chip_info->num_simult_channels;
 		xfer[3].rx_buf = xfer[2].rx_buf + xfer[2].len;
 		/* Additional delay required here when oversampling is enabled */
-		if (st->oversampling_ratio > 1)
+		if (oversampling_ratio > 1)
 			xfer[2].delay.value = t_convert;
 		else
 			xfer[2].delay.value = 0;
@@ -791,6 +829,8 @@ static void ad7380_update_xfers(struct ad7380_state *st,
 		xfer[1].len = BITS_TO_BYTES(scan_type->storagebits) *
 			st->chip_info->num_simult_channels;
 	}
+
+	return 0;
 }
 
 static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
@@ -798,6 +838,7 @@ static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
 	struct ad7380_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
 	struct spi_message *msg = &st->normal_msg;
+	int ret;
 
 	/*
 	 * Currently, we always read all channels at the same time. The scan_type
@@ -809,7 +850,6 @@ static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
 
 	if (st->chip_info->has_mux) {
 		unsigned int index;
-		int ret;
 
 		/*
 		 * Depending on the requested scan_mask and current state,
@@ -840,7 +880,9 @@ static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
 
 	}
 
-	ad7380_update_xfers(st, scan_type);
+	ret = ad7380_update_xfers(st, scan_type);
+	if (ret)
+		return ret;
 
 	return spi_optimize_message(st->spi, msg);
 }
@@ -913,7 +955,9 @@ static int ad7380_read_direct(struct ad7380_state *st, unsigned int scan_index,
 			return ret;
 	}
 
-	ad7380_update_xfers(st, scan_type);
+	ret = ad7380_update_xfers(st, scan_type);
+	if (ret)
+		return ret;
 
 	ret = spi_sync(st->spi, &st->normal_msg);
 	if (ret < 0)
@@ -991,7 +1035,16 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		*val = st->oversampling_ratio;
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ad7380_get_osr(st, val);
+
+		iio_device_release_direct_mode(indio_dev);
+
+		if (ret)
+			return ret;
 
 		return IIO_VAL_INT;
 	default:
@@ -1058,7 +1111,6 @@ static int ad7380_set_oversampling_ratio(struct ad7380_state *st, int val)
 	if (ret)
 		return ret;
 
-	st->oversampling_ratio = val;
 	st->resolution_boost_enabled = boost;
 
 	/*
@@ -1134,7 +1186,6 @@ static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 	}
 
 	/* This is the default value after reset. */
-	st->oversampling_ratio = 1;
 	st->ch = 0;
 	st->seq = false;
 

-- 
2.47.1


