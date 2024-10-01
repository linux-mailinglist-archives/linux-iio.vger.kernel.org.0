Return-Path: <linux-iio+bounces-9988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE36E98C843
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 00:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217EC1F25D01
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 22:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FBD1CEE81;
	Tue,  1 Oct 2024 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aM/IKUO2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3508E1CF5D1
	for <linux-iio@vger.kernel.org>; Tue,  1 Oct 2024 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821852; cv=none; b=ANR4B1Om71Q6oO1jJ1kjV5oGsmkUZSodUxeiIUkQxE1o5g7qMbqNL1wGfGVPtdDSe17bhyyWII+eNb+tucYV26J4yjuSiCuMq3mKokav1aiIi/8aHp7/1ua3EdfzTsBOkjIOQ839lDcW4S7BBxI154FEw8UapVZXRLxKffdDgO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821852; c=relaxed/simple;
	bh=yEmxUF8NvIZhxJNK3VZlTS7eTyiN+Ut8yjRJbZlxock=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nsw6JgTyW84bSyUlgt7arx5BocquAywGDzHTvbOk5OUbmEKgWMBu1z8vue+CvEdlW4pBPGjN2PYP8nRhLCZW7j8LsxqL1rYaP/bX5LHnrly96/Tq7TuxItdUmrUPeXl+D9CE5fT5PYjb+vkGBsunH9xdn2owDU+id43FigpNCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aM/IKUO2; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e03a5ed4d7so3178437b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Oct 2024 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727821850; x=1728426650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpf61w6aK144lw1gfwbrMjBFwopIsPReXKSdcPJBI24=;
        b=aM/IKUO2mZ47JhOKG+XEVxc4/yjYb/WrSBVfs8PhBbcXvfLftZZ9PioyRk1QRUfh5Q
         PxI14cpa57I1oiBR87vuHYwB2hY/yToaDEeVgdSVBellPWWQY4WVskKrSR/FgLYQo1j9
         4kr7RawAIcFQtjNdqVO0JA/O+S3CXptj/Ys/hWlXf/RjLEQUVOrtf7FyFh8NYVsOnQyB
         J5aJlT4WRU9lVplkrPYngIuOY/fUBxjlvjlyflsb+VLwKsPuLXfRE7Cj8tsyKYdHLHo7
         kH01atRr2VDju1NBVynqVwSlP8N9HyhlNHsRQG/q/7xRJzJ75L7O2evzpSvejvLsQ9JS
         rP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727821850; x=1728426650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpf61w6aK144lw1gfwbrMjBFwopIsPReXKSdcPJBI24=;
        b=rMlIVk26iWiNlr7QLAkO8aoSCn8AgRnwEHb0ADdX4j08Gwrt0k9ZP3tEqjozFg3+an
         L2K2SDC1WrcnJ9QKx0BW18ckwXiClOoxmzzRwS0etYxDErUxnizhUEvaKOGBCz/Ef/Uk
         QNoWCIFxdPJyeav+R7HWBpyHkacwnKWYc1mijQ/nvvvR2el7URAo29t8aZdYhxJasmyk
         FHKQ5Pe2aI2Vf7wVbeiusTDlp5Yc+YMv62BKiBtC8OdKcnYzDDBAhWWOEcagoXO4QC5B
         99NDhzLUXMwhPY3aNm3HfYTydoEfYM7FyO2qSMviXCEPrjB1qdTWpMqX7ccbeTuCtL/S
         vZnw==
X-Forwarded-Encrypted: i=1; AJvYcCVHlMPYuGi4jIMrcPCl3arEyH23HoOZXK9V27gMqExs/5L5qNoLgLOUC28jLze6E+xfl80O2IPi4Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgIOJ8nFJSEys8Hby6T1gna+ob3nK8EBfXkmIw8y42XVbDTCz8
	cxC8KGVEuyUE0GbrVwQ1zY4l8w9mftBg7K6td6ronmFzQLXVpJ1P6Yg48i86ueY=
X-Google-Smtp-Source: AGHT+IECe1/6DpxPJtyNlXLYmMWiHW8Lt0uF/1UH+h2LA80+tHG3gxfcLs3eXm7cgXnKvbptv7D51g==
X-Received: by 2002:a05:6808:3009:b0:3e2:8be4:49da with SMTP id 5614622812f47-3e3b417b5b0mr1293101b6e.42.1727821850348;
        Tue, 01 Oct 2024 15:30:50 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e770eaa056sm3002097eaf.31.2024.10.01.15.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 15:30:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Oct 2024 17:30:19 -0500
Subject: [PATCH 2/3] iio: adc: ad7380: use if_not_cond_guard for claim
 direct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-cleanup-if_not_cond_guard-v1-2-7753810b0f7a@baylibre.com>
References: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
In-Reply-To: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
To: Peter Zijlstra <peterz@infradead.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-cxl@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Replace usage of iio_device_claim_direct_scoped() with
if_not_cond_guard().

This makes fewer lines of code, less indentation, avoids having the
error return statement in the macro args, and avoids needing to use
unreachable().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 70 +++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index e8bddfb0d07d..19a942035e93 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -569,15 +569,15 @@ static const struct regmap_config ad7380_regmap_config = {
 static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
 				     u32 writeval, u32 *readval)
 {
-	iio_device_claim_direct_scoped(return  -EBUSY, indio_dev) {
-		struct ad7380_state *st = iio_priv(indio_dev);
+	struct ad7380_state *st = iio_priv(indio_dev);
 
-		if (readval)
-			return regmap_read(st->regmap, reg, readval);
-		else
-			return regmap_write(st->regmap, reg, writeval);
-	}
-	unreachable();
+	if_not_cond_guard(iio_claim_direct_try, indio_dev)
+		return -EBUSY;
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
 }
 
 /*
@@ -820,11 +820,10 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			return ad7380_read_direct(st, chan->scan_index,
-						  scan_type, val);
-		}
-		unreachable();
+		if_not_cond_guard(iio_claim_direct_try, indio_dev)
+			return -EBUSY;
+
+		return ad7380_read_direct(st, chan->scan_index, scan_type, val);
 	case IIO_CHAN_INFO_SCALE:
 		/*
 		 * According to the datasheet, the LSB size is:
@@ -909,31 +908,30 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
 		/* always enable resolution boost when oversampling is enabled */
 		boost = osr > 0 ? 1 : 0;
 
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = regmap_update_bits(st->regmap,
-					AD7380_REG_ADDR_CONFIG1,
-					AD7380_CONFIG1_OSR | AD7380_CONFIG1_RES,
-					FIELD_PREP(AD7380_CONFIG1_OSR, osr) |
-					FIELD_PREP(AD7380_CONFIG1_RES, boost));
+		if_not_cond_guard(iio_claim_direct_try, indio_dev)
+			return -EBUSY;
 
-			if (ret)
-				return ret;
+		ret = regmap_update_bits(st->regmap,
+					 AD7380_REG_ADDR_CONFIG1,
+					 AD7380_CONFIG1_OSR | AD7380_CONFIG1_RES,
+					 FIELD_PREP(AD7380_CONFIG1_OSR, osr) |
+					 FIELD_PREP(AD7380_CONFIG1_RES, boost));
 
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
+		if (ret)
+			return ret;
+
+		st->oversampling_ratio = val;
+		st->resolution_boost_enabled = boost;
+
+		/*
+		 * Perform a soft reset. This will flush the oversampling block
+		 * and FIFO but will maintain the content of the configurable
+		 * registers.
+		 */
+		return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
+					  AD7380_CONFIG2_RESET,
+					  FIELD_PREP(AD7380_CONFIG2_RESET,
+						     AD7380_CONFIG2_RESET_SOFT));
 	default:
 		return -EINVAL;
 	}

-- 
2.43.0


