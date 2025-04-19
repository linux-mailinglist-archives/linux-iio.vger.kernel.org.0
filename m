Return-Path: <linux-iio+bounces-18324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80696A943A4
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 15:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BED18950FF
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 13:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4BD1DED4B;
	Sat, 19 Apr 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxfAuJWg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975E31DDC0B;
	Sat, 19 Apr 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745071006; cv=none; b=d8vwris1afV2cXgDaDdO1/AHPZ5hLmWUwcPnYLKcQQBmmVVecwxgprMr2Js1xoOO9haT5Z81Hwt3HNFnVjItQCn/Naoae0hHw6ImehLlUXOzHdhKHRqu3UsQIn7DGHPD6J9vOIlVvAlif55O8mg3YHYLgpPidoeFOA5n6z0J8BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745071006; c=relaxed/simple;
	bh=FS5Q98qLID6FAQ/N12FPnFMlE/nozAWlI7CwtVF5bKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BV8w4GPSvsV9hRkHtDaI0HQaHDCxiRmgjlZhUD3sWa0fcBIspjUFUUsKUAJj9CYDQU7a+tHZdS7+cO15a+X7FXE3j7NMRXhqUxHaeGyAjtNe/fRjOGCHY4ySaXA740H6ruPSalao1VmraaTcKPfgEH2x9C03INuE23ygE3vCgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxfAuJWg; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c59e7039eeso372765585a.2;
        Sat, 19 Apr 2025 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745071003; x=1745675803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rd8epHvveGFvAa9vnuKQvCxPWBU3eQ5S8aYIg7aa9r4=;
        b=NxfAuJWgAnDE6QSV/g3duXOAXs/vym16QyE6w5h94iXYJ44EjdcWb4UY6Vsnmfjlkm
         zEAUnbHbr98cEl1Ej9oaul83uyOwXR60JtpqGGcR84Qzvc7Dw/3qTN9ZO7TI1bgyitGv
         42kw7uFofzQMsVW3rBxK/fUSGmr6bF2paVCqggwkMXSkwMMG1RfYt3FuGO/68/gIkbNB
         aCYhrUGfKUBP1uroTbRtSu80/tH4fnCTUbYMpYuMMVnQN7FOGcIEX2SQJtMHzSx16ZSz
         TZeGsWVkjmaActTHiKjjpuiWF5HNxNB3gxbpw3vJ6MG39QShi9MR3Lo1uO8ESff5aqkA
         uAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745071003; x=1745675803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rd8epHvveGFvAa9vnuKQvCxPWBU3eQ5S8aYIg7aa9r4=;
        b=P+CM1S9fC/sr75zP/tu//h2C2sbwYRvGhF/qFJ1sbcFmQIFqRNpJt6arFhCHGMa92u
         4OSd3A0PNM7NwgbeID/w75gj+JiGfzqHrYLMWZQOcG6TI7J/vJRA1WLchH7Vdxg2NKGm
         X79dQujejISAjS6RIr39T8vi3xuvNssogTU7MbVHsPANEfCQHN3D5nKpboMlcRFWyNsz
         1H05ZxtQzabuhvaLcwemw3XFoopmUtc5P6F/Q45LsVyU4mRnnoBFkzIMBt2I9wZOpc04
         S7+VXqJY3TQqeSK1oGnQ+jbXXMYG65xwlq8v8Pq3sOh54fJiwVLIIUdlZNpcS7pAmhfU
         KiLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2RAl1Pe2SZ8UJTqNIBYyYMzOvsjH5ZALcA/nq9uX2rK69QN2BNEvi05+pab/mr1nA9DnmVO60/8R+JkTV@vger.kernel.org, AJvYcCUR2/dguEzMudyiLds27LvNJcvHHbVKozml/CTBYUuCDNf5eRzvQAcp91HcPzlImSLnqoFpk4kKZ54=@vger.kernel.org
X-Gm-Message-State: AOJu0YznSRf9fQ1kC7xuTtTmkk+HuugisKTPJNvrlfzb4nTElHVn7oIN
	N+61iRFK30CcjnknwU2ePhABSZmM82DDfddHEmxrB+yvXIEpo8Bb
X-Gm-Gg: ASbGncupm+28U6l0/kJq3eqFXBYAWv2qgBpiM3wL0cpaRd1n1nlWcy4Ti5QveUwiBDY
	Qj+sAj/ECwls4S56xPlRCogRP1ZPAE4Z3rDFXYRoTP9sX1X1UYzKwKdo46gVQOJF/GZoOaHrVyd
	JpohK3WECDppbdJ9f3qBF7jLBYArcQPWl6BaibXQ4afarCXoWhWu1VTGx3aI/qxJbAHDpXTdBQl
	UhGfZObrG0ox4bAfCuEXD2E4tPCLdJMgrv/Wrl4n3t7yWcNUgHbeUb7lMhoIMsF6R6HzBwHLvJC
	/PSH693D0u1w4pfmom+prVyoxvLwa0+3ofsZxD3zQOweBiilZRay4Jw=
X-Google-Smtp-Source: AGHT+IFVmEYILIl7Bx9bPOG6d33ZGT/0pPwV1G1+NPCc5IPhW9OYdHlwxHRMX0my6CmQO0+vJtJu2w==
X-Received: by 2002:a05:620a:4153:b0:7c5:a2de:71d3 with SMTP id af79cd13be357-7c927f92045mr827457885a.20.1745071003444;
        Sat, 19 Apr 2025 06:56:43 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925ac4749sm214350185a.59.2025.04.19.06.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 06:56:43 -0700 (PDT)
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
Subject: [PATCH 3/5] staging: iio: adc: ad7816: Introduce chip_info and use pointer matching
Date: Sat, 19 Apr 2025 09:56:36 -0400
Message-ID: <20250419135638.810070-4-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250419135638.810070-1-gshahrouzi@gmail.com>
References: <20250419135638.810070-1-gshahrouzi@gmail.com>
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


