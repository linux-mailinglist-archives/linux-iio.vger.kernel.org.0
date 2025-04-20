Return-Path: <linux-iio+bounces-18365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D94A94668
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 03:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E421894151
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 01:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46413188006;
	Sun, 20 Apr 2025 01:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL5U+YOt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E3213212A;
	Sun, 20 Apr 2025 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745113757; cv=none; b=XvQ9tfoTR5NHAFvs5dEU5qATbKvz17hhxh5m9dGwIuYH+ujS8GTqHu3q/qUDs+i7h+qpvyQRZ+nowu2qJf5i95s3TLzEquK3x5adiDiPyL6HBmyd4DNbBSScJdIa/gHrND2/bVg1Y227KbguXHvqCXqYYEdxqYzHxSWcO9nmqfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745113757; c=relaxed/simple;
	bh=FS5Q98qLID6FAQ/N12FPnFMlE/nozAWlI7CwtVF5bKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btmwMwh3n92dBw/whepZbnS0a8wI/yYuFCGKNCALHYKNknK/G2Kcm4YSHSp60oAw3a3fJk/piDD4v1M7b073MCJI1SFFVWfXgGN8FhGB74Vg25404eHBYzbTegzaYdL2d9hxxBm7iSK6q/tJFIabD5+X2ZCO72stOvs4jSQdZ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL5U+YOt; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so40321336d6.0;
        Sat, 19 Apr 2025 18:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745113754; x=1745718554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rd8epHvveGFvAa9vnuKQvCxPWBU3eQ5S8aYIg7aa9r4=;
        b=iL5U+YOteawkFlWL5esSQHtPq6EPJheZB3YfyhdXdMwWBgprXoG45DuFtlabbkVJ7N
         ju31cfybFi0D6aRVp1qSzRLnCi7XoiKE+QBPR/5fQE4fBxTx09pt0AmUtvEm9Y7wOAzC
         suVn2XlJUuWRVz30P7T2EFlGWeN3eh/0HfcQiW06+nJbcD8Bx0k3GWKkUHZkf2qDDZI1
         cOcvsytj78Xx09rwm1PYZVur2Qbqx7qYzJG2ONr68WguU+7BUQTXyRm9OG4vp2qwZ874
         yt797TO8HQbPjejX7blmEMG2HfkVFlP3eb+c/+z3DM06M/PWC1NXUkPt8ekr4Kj0hyUn
         pjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745113754; x=1745718554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rd8epHvveGFvAa9vnuKQvCxPWBU3eQ5S8aYIg7aa9r4=;
        b=mMYGFH1w8sGnWiXvO5B/Wbl/Y3ds0HRixtd3g/u2U58Qh1bFHoZZh8o03uxIyR7qFx
         jhCeyR5r7iQW27/aFPgvGQ74F0vSys6rlZCvV7RRik3RBIamo+n5YVt2RJYYv/PomJsW
         G83j45/llIpyFMcscemlQjDX9HVKXjZWtXG39Fuk/jM2hGKefbD4vbeARupGDKhvE7T+
         g6iqjkVrMfd9w9+e9q7SCX4Vo5pGfupMMcDEg8h0VH4z2ay/M2vzoDHNoxQX43wn9KeP
         xAWl8nR5ECbMTgYnlyUxXmkiUcmM6MZbKeLkoB9vEBJIH1WbgIhYWz6NKC+MoV6yuNLe
         bghA==
X-Forwarded-Encrypted: i=1; AJvYcCU41EFMtLCZF74Jjq0Zo8DL/m+b8maRrYbYeViExXUnCLNTPjQDcfQmC/oLjiO/vVzNLnd73RBRPDc=@vger.kernel.org, AJvYcCUrKlgSHc1U0BKpTbCIqP2Bcet1nIauvEWx8WHsrMJdPyByxgFTGdxBJ10gnlW2iINFcZNfrOwCTJb849fv@vger.kernel.org
X-Gm-Message-State: AOJu0YyUufFx1dY+CcPySvd1K2akKaG9F+7p/FswgFpIcXm0i85NBPFg
	ySq57OvUJgruFTWKAzn4pxQV90XWqqMIXENEUVAIPK/i1XYbLa6S
X-Gm-Gg: ASbGncueVvoaNdfs0/nwn/fOAvTMcuGmYyXxvNjIAM8GzM/WJYQc7JbEh2OyU0rcgmC
	4fuBg7yTpiOy+DSF6UROtiCS5ytdQ6enTP5MD0U2iBdjNAz4cNq+4k2rm4AqVeTBiwbrCTAqK0H
	GHrGRPCWkuqDO4bW5ID0o3/fCb+ZNVfX4aenyLP3y9f3oUxp/fVnmE2MMH+n2h3JNVmwlk019r5
	gunzojh4s0bRmvCRsSIZ4YJeFqo4M/C4gYK4kdw4xHyHxHFwKW4pOgh0jwUPv7B5u5D6vujdnjs
	VCt8ea19vo+v0L8LjffXmnKPAr6kLZLiVOSjlWZx1/LLu6VMmSTFhx6hX5jm5ukbZNJ70Kfin1F
	TqD+Mb2Atx8al6q16BsqJVw/zgqu48w==
X-Google-Smtp-Source: AGHT+IE8QhtT14V2rzTMTBv+XClz9Lo8X3jPZXkIOiI7VIkejQCyQnS53LwCvsx93xyvO0wCQY0mjg==
X-Received: by 2002:a05:6214:f06:b0:6e6:9b86:85d0 with SMTP id 6a1803df08f44-6f2c26c9d2emr136152386d6.8.1745113754262;
        Sat, 19 Apr 2025 18:49:14 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af1283sm27583846d6.23.2025.04.19.18.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 18:49:13 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com,
	sonic.zhang@analog.com,
	vapier@gentoo.org
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v5 3/5] staging: iio: adc: ad7816: Introduce chip_info and use pointer matching
Date: Sat, 19 Apr 2025 21:49:08 -0400
Message-ID: <20250420014910.849934-4-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420014910.849934-1-gshahrouzi@gmail.com>
References: <20250420014910.849934-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce struct ad7816_chip_info to centralize static properties (e.g.
name, max channels) that differ between chip variants (AD7816/7/8) but
are constant for any specific type.

Store pointers to these instances in the of_device_id (.data) and
spi_device_id (driver_data) tables. Retrieve the pointer in probe()
using the firmware-independent device_get_match_data() and store it in
the ad7816_state struct.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 55 +++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index cad2e55aff3f9..39310ade770d0 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -41,8 +41,28 @@
  * struct ad7816_state - chip specific information
  */
 
+struct ad7816_chip_info {
+	const char *name;
+	u8 max_channels;
+};
+
+static const struct ad7816_chip_info ad7816_info_ad7816 = {
+	.name = "ad7816",
+	.max_channels = 0,
+};
+
+static const struct ad7816_chip_info ad7817_info_ad7817 = {
+	.name = "ad7817",
+	.max_channels = 3,
+};
+
+static const struct ad7816_chip_info ad7818_info_ad7818 = {
+	.name = "ad7818",
+	.max_channels = 1,
+};
+
 struct ad7816_state {
-	kernel_ulong_t id;
+	const struct ad7816_chip_info *chip_info;
 	struct spi_device *spi_dev;
 	struct gpio_desc *rdwr_pin;
 	struct gpio_desc *convert_pin;
@@ -52,12 +72,6 @@ struct ad7816_state {
 	u8  mode;
 };
 
-enum ad7816_type {
-	ID_AD7816,
-	ID_AD7817,
-	ID_AD7818,
-};
-
 /*
  * ad7816 data access by SPI
  */
@@ -84,7 +98,7 @@ static int ad7816_spi_read(struct ad7816_state *chip, u16 *data)
 		gpiod_set_value(chip->convert_pin, 1);
 	}
 
-	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
+	if (chip->chip_info == &ad7816_info_ad7816 || chip->chip_info == &ad7817_info_ad7817) {
 		while (gpiod_get_value(chip->busy_pin))
 			cpu_relax();
 	}
@@ -353,6 +367,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 {
 	struct ad7816_state *chip;
 	struct iio_dev *indio_dev;
+	const struct ad7816_chip_info *info;
 	int i, ret;
 
 	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
@@ -362,11 +377,15 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	/* this is only used for device removal purposes */
 	dev_set_drvdata(&spi_dev->dev, indio_dev);
 
+	info = device_get_match_data(&spi_dev->dev);
+	if (!info)
+		return -ENODEV;
+	chip->chip_info = info;
+
 	chip->spi_dev = spi_dev;
 	for (i = 0; i <= AD7816_CS_MAX; i++)
 		chip->oti_data[i] = 203;
 
-	chip->id = spi_get_device_id(spi_dev)->driver_data;
 	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
 	if (IS_ERR(chip->rdwr_pin)) {
 		ret = PTR_ERR(chip->rdwr_pin);
@@ -382,7 +401,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 			ret);
 		return ret;
 	}
-	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
+	if (chip->chip_info == &ad7816_info_ad7816 || chip->chip_info == &ad7817_info_ad7817) {
 		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
 						GPIOD_IN);
 		if (IS_ERR(chip->busy_pin)) {
@@ -393,7 +412,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 		}
 	}
 
-	indio_dev->name = spi_get_device_id(spi_dev)->name;
+	indio_dev->name = chip->chip_info->name;
 	indio_dev->info = &ad7816_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
@@ -420,18 +439,18 @@ static int ad7816_probe(struct spi_device *spi_dev)
 }
 
 static const struct of_device_id ad7816_of_match[] = {
-	{ .compatible = "adi,ad7816", },
-	{ .compatible = "adi,ad7817", },
-	{ .compatible = "adi,ad7818", },
+	{ .compatible = "adi,ad7816", .data = &ad7816_info_ad7816 },
+	{ .compatible = "adi,ad7817", .data = &ad7817_info_ad7817 },
+	{ .compatible = "adi,ad7818", .data = &ad7818_info_ad7818 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7816_of_match);
 
 static const struct spi_device_id ad7816_id[] = {
-	{ "ad7816", ID_AD7816 },
-	{ "ad7817", ID_AD7817 },
-	{ "ad7818", ID_AD7818 },
-	{}
+	{ "ad7816", (kernel_ulong_t)&ad7816_info_ad7816 },
+	{ "ad7817", (kernel_ulong_t)&ad7817_info_ad7817 },
+	{ "ad7818", (kernel_ulong_t)&ad7818_info_ad7818 },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(spi, ad7816_id);
-- 
2.43.0


