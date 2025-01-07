Return-Path: <linux-iio+bounces-13951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AE5A03A26
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 09:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B071654B8
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDE81E0B7D;
	Tue,  7 Jan 2025 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QmbOoHym"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD831DF75E
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239714; cv=none; b=ZR4xBkLos4Uw5ekBo2y9ik+VmagnoaN1dJ6o+XsuZpYouqE7C4IvUK6BsMoh92/W+0yQOe3Jx2KKCGc4pdBkNOPswTidN1D94WTBlqZpX0nyYBxHvriOAlYkjLzM2Y1AOlIuUAWc1xq9eUc1DAf/SYRDa3a8hYRc73P9gHYU8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239714; c=relaxed/simple;
	bh=eSSplP/3FY91YR2XwZTXJZ2Ax/rrzWeyNFYg2OhghvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZcIqO8x7J8jZkruYTqlibEaoLQrPSuHq9e3wHp5xYH2VyVNsqn9mpyxy3yvmnbDqwEyMgZVoEHXpcpzd4G8e6cpwxi6ObaC1wapgueBP2BRGACm4KfduigQ6tenFW/kOijiQzTJyq+THjmQm6nDG4qP5VJSMpJ2wNz5XHWE413I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QmbOoHym; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43635796b48so91868995e9.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 00:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736239706; x=1736844506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZ+/3KnECndMbh/2k2JKBTk8y/NjC4Kknkr3b9iFCA8=;
        b=QmbOoHymiXR3HSPWS4+gtQR+EwmtBPja7KgOHX6jD3cKInHr78dlnaAXdAYrnQys35
         m3KLBez06RVWIiuDMFc5JzUhdBia+Ql2MEECtqOd5PdAuPEC8050yHjKV84CqxWkVIWs
         wDPW5LskeTD+mB1QxjHWucJbTtj1eK882mV0PaQBHPt3zbl3dCgdzMU5DLX1CW/nYKoH
         qnmK0Yzg3I8WYtDCEClssUqzqbTIvN8hncqrJCKJ/Vr8+85xLiyF/PWVp1Heo6GjANgu
         rKFXOqxEk68zPgC1OGm40+ltp23QZWeijHa6UJ5wlmEwmE2PAr+iV2iSSFY2xegEMBLL
         /VlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736239706; x=1736844506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ+/3KnECndMbh/2k2JKBTk8y/NjC4Kknkr3b9iFCA8=;
        b=VeQkawMytPiDIlZU6GdiRl7Q3qR9Weua53nxCokYyWqywfi1CACujs743CI7Xy7oPh
         YtULwJUMwsQgi4+MykpL4YwqPA3K3LK+LM4Qj6mwPUqsX9TsMGlq86S8opppMUh3ewah
         H8DtVmYV/UKY9yt78F4wisYzX27gNGiSheLow514NyeoWJ0XPMexl6lzCzuKCVc7Tt8i
         vqp4YUK1ktTic840ZjqijwUnVe2d8ObLkmf5+lNYUYzQPNuF8Q8SfFhxJ5hyKoMdUyWx
         1YHty3ak/IWrWwRFtO9gHHFI9vFVu5tcoUJi4yPDx70q77Y/YwzP9mwX0IwNpwUP6xEk
         zrZQ==
X-Gm-Message-State: AOJu0Yw8yGi2ZTB2YznDSTmn7lZesgG2UZZjzBtCIZi+am0dGJIrDxwa
	9c6e77k5sqFD6lV277MJEKGDxPYgKwJ34V1GEAAjlvatNkMMVLATFs/f/iJr1Nc=
X-Gm-Gg: ASbGnctan+rK+YQz9mRTGkWzGb1oj1UaZb2ZjH1RR1SwnUTf4meAv+jy7mw5Sd1hbTT
	UGX6O667g7DQfWcEX+kW/aPEDFe2t3fGhtPaNgelOPVWf9chSEMColzomN/92hzGCQFenRn1v0N
	26aKDAUr9hlQGnsj+Et7NxJ/PpOCBEANoauG1NzQmvJJ3eCLKYBsYdQ8E3M+CVJ5ZNsGvdwHSsm
	svY4HyZRp4YGR/ASUpzZs+kW2Wn34YRwXzmGSQfvffPYq84oMzRvfFuWEo0LANda02kLZ2rmtA0
	4iFiuzWkbUjKNvikblM/8hpQKGZ5T1Mp1UjzjvBxtoOYhRLGcg==
X-Google-Smtp-Source: AGHT+IGQ4V3dSc3vK+Zyhlr0chhocUMOJ1bGwH2LL7mekY4ZcsViuFPyGalpXb4K+Ellw6y7xZP6gw==
X-Received: by 2002:a05:600c:1d12:b0:436:1b86:f05 with SMTP id 5b1f17b1804b1-436dc20b0c1mr16203915e9.11.1736239706555;
        Tue, 07 Jan 2025 00:48:26 -0800 (PST)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828817sm50722280f8f.1.2025.01.07.00.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 00:48:26 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 07 Jan 2025 09:48:25 +0100
Subject: [PATCH v3 1/5] iio: adc: ad7380: do not use
 iio_device_claim_direct_scoped anymore
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-ad7380-add-alert-support-v3-1-bce10afd656b@baylibre.com>
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

Conditionnal scoped handlers are turning out to be a real pain:
readability issues, compiler and linker handling issues among others so
rollback and remove the scoped version of iio_dvice_claim_direct_mode.

To impove code readability factorize code to set oversampling ratio.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 110 +++++++++++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 4f32cb22f140442b831dc9a4f275e88e4ab2388e..bc7d58850a3e2a84a241d81377e3dc14c43fc101 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -675,15 +675,21 @@ static const struct regmap_config ad7380_regmap_config = {
 static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
 				     u32 writeval, u32 *readval)
 {
-	iio_device_claim_direct_scoped(return  -EBUSY, indio_dev) {
-		struct ad7380_state *st = iio_priv(indio_dev);
+	struct ad7380_state *st = iio_priv(indio_dev);
+	int ret;
 
-		if (readval)
-			return regmap_read(st->regmap, reg, readval);
-		else
-			return regmap_write(st->regmap, reg, writeval);
-	}
-	unreachable();
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	if (readval)
+		ret = regmap_read(st->regmap, reg, readval);
+	else
+		ret = regmap_write(st->regmap, reg, writeval);
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return ret;
 }
 
 /*
@@ -920,6 +926,7 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad7380_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
+	int ret;
 
 	scan_type = iio_get_current_scan_type(indio_dev, chan);
 
@@ -928,11 +935,16 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			return ad7380_read_direct(st, chan->scan_index,
-						  scan_type, val);
-		}
-		unreachable();
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ad7380_read_direct(st, chan->scan_index,
+					 scan_type, val);
+
+		iio_device_release_direct_mode(indio_dev);
+
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		/*
 		 * According to the datasheet, the LSB size is:
@@ -1008,47 +1020,59 @@ static int ad7380_osr_to_regval(int ratio)
 	return -EINVAL;
 }
 
+static int ad7380_set_oversampling_ratio(struct ad7380_state *st, int val)
+{
+	int ret, osr, boost;
+
+	osr = ad7380_osr_to_regval(val);
+	if (osr < 0)
+		return osr;
+
+	/* always enable resolution boost when oversampling is enabled */
+	boost = osr > 0 ? 1 : 0;
+
+	ret = regmap_update_bits(st->regmap,
+				 AD7380_REG_ADDR_CONFIG1,
+				 AD7380_CONFIG1_OSR | AD7380_CONFIG1_RES,
+				 FIELD_PREP(AD7380_CONFIG1_OSR, osr) |
+				 FIELD_PREP(AD7380_CONFIG1_RES, boost));
+
+	if (ret)
+		return ret;
+
+	st->oversampling_ratio = val;
+	st->resolution_boost_enabled = boost;
+
+	/*
+	 * Perform a soft reset. This will flush the oversampling
+	 * block and FIFO but will maintain the content of the
+	 * configurable registers.
+	 */
+	ret = regmap_update_bits(st->regmap,
+				 AD7380_REG_ADDR_CONFIG2,
+				 AD7380_CONFIG2_RESET,
+				 FIELD_PREP(AD7380_CONFIG2_RESET,
+					    AD7380_CONFIG2_RESET_SOFT));
+	return ret;
+}
 static int ad7380_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int val,
 			    int val2, long mask)
 {
 	struct ad7380_state *st = iio_priv(indio_dev);
-	int ret, osr, boost;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		osr = ad7380_osr_to_regval(val);
-		if (osr < 0)
-			return osr;
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
 
-		/* always enable resolution boost when oversampling is enabled */
-		boost = osr > 0 ? 1 : 0;
+		ret = ad7380_set_oversampling_ratio(st, val);
 
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = regmap_update_bits(st->regmap,
-					AD7380_REG_ADDR_CONFIG1,
-					AD7380_CONFIG1_OSR | AD7380_CONFIG1_RES,
-					FIELD_PREP(AD7380_CONFIG1_OSR, osr) |
-					FIELD_PREP(AD7380_CONFIG1_RES, boost));
+		iio_device_release_direct_mode(indio_dev);
 
-			if (ret)
-				return ret;
-
-			st->oversampling_ratio = val;
-			st->resolution_boost_enabled = boost;
-
-			/*
-			 * Perform a soft reset. This will flush the oversampling
-			 * block and FIFO but will maintain the content of the
-			 * configurable registers.
-			 */
-			return regmap_update_bits(st->regmap,
-					AD7380_REG_ADDR_CONFIG2,
-					AD7380_CONFIG2_RESET,
-					FIELD_PREP(AD7380_CONFIG2_RESET,
-						   AD7380_CONFIG2_RESET_SOFT));
-		}
-		unreachable();
+		return ret;
 	default:
 		return -EINVAL;
 	}

-- 
2.47.1


