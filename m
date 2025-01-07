Return-Path: <linux-iio+bounces-13949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B2CA03A21
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 09:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167463A50C7
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2210B1E32D6;
	Tue,  7 Jan 2025 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vqkheXwg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50DB1DFE29
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239713; cv=none; b=FL7lfxNEG1mhZT3mmAJtU1h5M6KKVc2yJwUzOeP+3eBVdP6bfil8gpBBsadpM9UymKpZ9BNtn36dfadQ5v5LITOUjmskHkcNiDXr8f7fiqiG7Hjvth5xzX+oHtQVmA3P05036Ka82xcXE2CB/g5XbQjwH3i9K+ktX2/G2A9ZwzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239713; c=relaxed/simple;
	bh=UTYlw9Zlr+lHINhy3laLfpr2OQpisYLFZWlXjMVRxLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mEgfXZG0vi6jqM0H/NSCfjaK04mATOBQnmQgdV1z7c7osTT++4pz/iwS7Sy9IQoivirX4BVeTS1Vsb0TZ5XXkFpLvMPh5QAnEbztptbQ7jyTlTeYHZlSgmzXpc6vwQ4xNiaLZazxQ+krLflBy0C6Mz4jGsCc5dIf9Qz6e9YDfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vqkheXwg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43621d27adeso105422555e9.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 00:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736239708; x=1736844508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6iRFmMQps5zu9ZbxUCjXbpdFZyZtopNerBmAGwGvIa0=;
        b=vqkheXwgaGNIYeroni9SmFkm/LY+XXwjy6LGasRMuhaUZszFntRSvASrs2Hmc8UjrF
         3alLMdFu7w+po5j62CX/psCTOKDqmsZ/a3ubwUKk4Bezy6FHkqJA9WQ4ELOE988YX769
         TIaajSczbUj/eyOAZHirD36ahyG17wARsrLQn9A8+9EowPvqKLMXlefy+fqfYHW2ceMj
         BA4k7KR5rNfjjxxnaW/+uyJQRENCFwSEgnoD9GcolIooNrxglkJ8ZwlcyRynrb6jxGzj
         Bu/C1Tp2q0fipe5PiZU1zvqLLejMnLmCA2U297y1kx1ZkoqlppruNllvE5LWQGGxOjzg
         zYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736239708; x=1736844508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iRFmMQps5zu9ZbxUCjXbpdFZyZtopNerBmAGwGvIa0=;
        b=RWpDJfe8ZQXQeJXn0t6pi86AbhhUzwwRdoGdQQbQYobLttKhWIs0mHAjs4Bo8LeinX
         R5jxU9lkNjKC5jm3RoGSP3wOHFU7ydQk7vV1DTMTjaX2hQqo49Z5vW5JFtgPVgVwZste
         CS60925BiQDaCGf5GA27E+t178h76RfR+kvJi736i243j41nEfmakpt9isVEt4nmB4Nj
         jnFuGE23FAZUvEii4B3XNOedt6zzom6ZdaEfNVMZv8c82WxbeZJ8l6psHyJYBJ+5fClX
         cUZnN6GcFaE5ZBSYH5PbF6EqAQDEOgYOOLkCTo3jeUUcIgJROBTFnFIPB5ltTQkW7WbO
         jveA==
X-Gm-Message-State: AOJu0YxnLtW1jE12GDXiJ6n+3XyOW6ppWhpI9WZrsSZO+T5CMNroTHWC
	JVSQOopvIKaRu9AbzelXhvvyYeKU1V5/6EX5+FpNCTOH7pYfXCTAHnX7d49S748=
X-Gm-Gg: ASbGnct+1s31SmsoipksFBydj6fDEedqYGalF75tUbMQQ/uv096kS00M1ScmxLJIzEH
	F/BsJPW7pnXWkHY0jqXxR1QPRu/Iztzaqk4F6HdwiL53eyZezTIccFzYWD7VczCkgs/bikR3qt6
	dR0Az1wj5yxOIGyPkB/I6L5pPOmmZE7mOzW8YOzT588qxWlFSVaP+qrM4ErKGx9cvnmfPJLtFF5
	1DQjKpp0sbSScGkx+GxjWMlKWPOVZdqPvqTBsO4lOz5E5Mc/Bk7CRBwuDBxudS8qKy6C9PBzIAZ
	sFlcE/Kaec+aSx239tdqHyXqsAc5rMdTrqO7eWaXtATogbpVGA==
X-Google-Smtp-Source: AGHT+IFqMY+CA86z83irMoj4XLZkusS97SD29Pd3zZjXUFHiblT6HkBzrJ9Esc5MMVAvH2x4qFrqTg==
X-Received: by 2002:a05:600c:3554:b0:434:a923:9310 with SMTP id 5b1f17b1804b1-43668646103mr558109495e9.15.1736239707897;
        Tue, 07 Jan 2025 00:48:27 -0800 (PST)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828817sm50722280f8f.1.2025.01.07.00.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 00:48:27 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 07 Jan 2025 09:48:27 +0100
Subject: [PATCH v3 3/5] iio: adc: ad7380: do not store osr in private data
 structure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-ad7380-add-alert-support-v3-3-bce10afd656b@baylibre.com>
References: <20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com>
In-Reply-To: <20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com>
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


