Return-Path: <linux-iio+bounces-6226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D731A905D68
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 23:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879C628301B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 21:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4027512DD88;
	Wed, 12 Jun 2024 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ahG1CHFT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0AA126F1E
	for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226205; cv=none; b=o9SWV3OHux7zSiJmkDQxlMXYcRNbKRm5Gonr0tWUmv8+vriq00hWSFilCLEo6XP0M3ojN0PinCtqNGdLC9LMphCQd+rVmE9qiTlcT4rNM1N+wclvgHIqe8j1MCjftnr6lZIbOtihDK4UFHuIWw3nh8EKH9sUXZIcC1GIOVn0C+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226205; c=relaxed/simple;
	bh=RQGZCDhf9GURnEWrVzA4GpPy1QAW6p5jP0M4N6GMfTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkRhEHmfm0sh7ra0Z+Z7H0xvqT5XfzFtUCwh5uBKEyHWJHS7Gi9aP9UtmlRiaH73675qTWF+e4u28bw2wJFlwnjBuZ3rvtSexcF5+JWf3zmvhBHj12mdqwNnWPa6G82p0sgPWXboK3FUyEcATboS1MlglNY5EUI4heDwpjEJ2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ahG1CHFT; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3cabac56b38so119216b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 14:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718226202; x=1718831002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60rjWI/eWg2WwJP9vLG2m5CtLQt8gZzyCnXFhPgOW24=;
        b=ahG1CHFTLv1cMBkeRGAN6HmYwxuGvKVaMkZVj8BABDx1q1O6FS1hAaMcLB/l0+UkTY
         MONxVwfWjVDRr64R9AONQMRFnuEOXjsNMEPLRNf4uNwrnkCKA+fmxXHcbqFSoY4E3/GG
         8Wecwu4446N7co19eN58KP4N+dArpMuMIVqCMca+0GleulfxSxJ/KkTyiptWjXdF915Y
         0jEdSNW0Pb7L4sxqwrRNmjdR+4AXKOUnwxoymWkNR72FiH6j5/Tj6R54R6vEZXuB7r+m
         asK1eaIJ4knItwiuut80MX3Uk/lPORZ8qHRN80Jd0nkpOJ0q8aLVd+LYzRL7/i3Ozwih
         jPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718226202; x=1718831002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60rjWI/eWg2WwJP9vLG2m5CtLQt8gZzyCnXFhPgOW24=;
        b=WI28QGyHhqm87qvDSkb0bZ4dKLHHiAXN6xFqoX9eRtyVqF91qYIQMpu26talgztcFD
         D6VD+/RumL1k0dGKoN3brrU5oAFC1sDSqCqipcyvEhqg1EiJNPMtsjU+2S7Dcm7YMSth
         Fpybeot5ABLz+oWLE/cgUg/H65LO5MFOfef5AO/kObIsvVvk7hdBYnEsFlXLccOGjul6
         dZoT5o9ycXv05e3G/ZLJmLfpDxbDNdAH01oR4bCWxDOAn+3USg0acg8gJz44nrEk7z/N
         kuM4CAGWGMeRhFuXjTbDD+ECA8st0r5C9BuKr3Ei/inUe+ZDgO9YqA+u4/3Ny5uWmq80
         PM9A==
X-Forwarded-Encrypted: i=1; AJvYcCX3UR93TJAsV7WCpl4GUeTbN6jZ+MFUthUDi3JPfyGMhUobF5wK6GfDn6auzhmOykzWq4QDnCHtcxOs1lG96RWmQ8iNzjQ332vV
X-Gm-Message-State: AOJu0YxddYlph/5Qv6l9+QBUBxFb2nuts9AvlI3MDMnewqmxMkVC0DgP
	b9OsIxCAv7QM9o01BObE1xKUBag5DdiA8uptKqmRcjeS7fNUct9rS2D7BYFV45M=
X-Google-Smtp-Source: AGHT+IGENQe4ez4Gwyda3rsmnSjRQps4X8hzl0vGRVzINVJNtM7Np1gleBLWblptPg91hq9vLRK58g==
X-Received: by 2002:a05:6808:1b11:b0:3d2:231e:4b30 with SMTP id 5614622812f47-3d23dfdef65mr3638602b6e.13.1718226201601;
        Wed, 12 Jun 2024 14:03:21 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d20b68f5a1sm2433368b6e.23.2024.06.12.14.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 14:03:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] iio: adc: ad7292: use devm_regulator_get_enable_read_voltage
Date: Wed, 12 Jun 2024 16:03:07 -0500
Message-ID: <20240612-iio-adc-ref-supply-refactor-v2-3-fa622e7354e9@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This makes use of the new devm_regulator_get_enable_read_voltage()
function to reduce boilerplate code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v2 changes:
* avoid else in return value check
* use macro instead of comment to document internal reference voltage
---
 drivers/iio/adc/ad7292.c | 36 ++++++------------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
index 6aadd14f459d..87ffe66058a1 100644
--- a/drivers/iio/adc/ad7292.c
+++ b/drivers/iio/adc/ad7292.c
@@ -17,6 +17,8 @@
 
 #define ADI_VENDOR_ID 0x0018
 
+#define AD7292_INTERNAL_REF_MV 1250
+
 /* AD7292 registers definition */
 #define AD7292_REG_VENDOR_ID		0x00
 #define AD7292_REG_CONF_BANK		0x05
@@ -79,7 +81,6 @@ static const struct iio_chan_spec ad7292_channels_diff[] = {
 
 struct ad7292_state {
 	struct spi_device *spi;
-	struct regulator *reg;
 	unsigned short vref_mv;
 
 	__be16 d16 __aligned(IIO_DMA_MINALIGN);
@@ -250,13 +251,6 @@ static const struct iio_info ad7292_info = {
 	.read_raw = ad7292_read_raw,
 };
 
-static void ad7292_regulator_disable(void *data)
-{
-	struct ad7292_state *st = data;
-
-	regulator_disable(st->reg);
-}
-
 static int ad7292_probe(struct spi_device *spi)
 {
 	struct ad7292_state *st;
@@ -277,29 +271,11 @@ static int ad7292_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret) {
-			dev_err(&spi->dev,
-				"Failed to enable external vref supply\n");
-			return ret;
-		}
-
-		ret = devm_add_action_or_reset(&spi->dev,
-					       ad7292_regulator_disable, st);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->reg);
-		if (ret < 0)
-			return ret;
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret < 0 && ret == -ENODEV)
+		return ret;
 
-		st->vref_mv = ret / 1000;
-	} else {
-		/* Use the internal voltage reference. */
-		st->vref_mv = 1250;
-	}
+	st->vref_mv = ret == -ENODEV ? AD7292_INTERNAL_REF_MV : ret / 1000;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;

-- 
2.45.2


