Return-Path: <linux-iio+bounces-18309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5FCA93F2F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 22:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000BB1B687FE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B0B250C18;
	Fri, 18 Apr 2025 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQUDstcj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A792472A1;
	Fri, 18 Apr 2025 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745009433; cv=none; b=DHJRKeDTEj39cTaEqhtUIePt1pTJPDiJCHQLhbr3g7zxulqMNrrjhM7O1A9FbbDkC5uKHog1ABNDrK+ANfRWAX6/WGgMCx0TqPIwYbOt39OuAYn1K/FSaJzCoHx8Q9gqMiZR3rK4tekHqNLlboETdAmWkFGqYbXSbjHNchM68mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745009433; c=relaxed/simple;
	bh=FS5Q98qLID6FAQ/N12FPnFMlE/nozAWlI7CwtVF5bKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKdm71s79WoJQCc3FyTNLyAe4G40ob3d8jbgiSjQdQoVianpLUPhMel0QPPz5AkKzgcM3zBoa1Y6HzNePds4H5YbrSICTiToV6PQzLbYG+SqZA3fcORpEN/p78GxCRBfPHlOaf7/taUeluuADD32IFCld+cW5vI9UzI62Rd8HCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQUDstcj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8f7019422so21298216d6.1;
        Fri, 18 Apr 2025 13:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745009430; x=1745614230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rd8epHvveGFvAa9vnuKQvCxPWBU3eQ5S8aYIg7aa9r4=;
        b=bQUDstcj0/N/57t6x4GKfwDWo3r7meDNgKKahPVVy+QvA3WYiwrZos5qfA82v3hcdb
         YQsscZKHay8bg0ePcvogHQ0PGvnuZrNIf8tuR+KScIr/jyBMFhWF8S1b08lKJW1pKkw5
         80RjQzmpd4417jmno6gzRjpbuorv+ANHThxCqYJne2fuTyIG9+93KMHJIjvb2bPBt+ep
         UJ2SSfKFxS08kB0efrgCG+GzTslLSlgc4+DlnoOtFp+ibFRxVc/HlDjcKCfukI8Z30TB
         wyJooK0lbV1Wzw9MhAFeBie1OOjSDEskMejgY4fNLQDOoCH9YBuuBt59/NRx10ksCepT
         bF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745009430; x=1745614230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rd8epHvveGFvAa9vnuKQvCxPWBU3eQ5S8aYIg7aa9r4=;
        b=c/JYdGnciy86pp2OUwPclfx6lWNPDDDOX0QQ1RFrR4/oNmNkZnhQ2MEMOFXQJ8QeVy
         mQbrUI2mObTrPHzp57niOzVgf9IBdzHjkjef+7S95n0qbAwizAfGmSzK46HAvQYvtjX6
         Ms/wHN4XHJIPK5bULzaXUIdZS8fNkLkd7o5wvHp7g+UTYbhK3Y25G9qWWb3W2bqwxkfu
         Yy+gDzbxluuu+CFelAFEnivmaJfutX7fFNGtfh+JOivYWOY1lesZJtzA9JOkqilS30xK
         tPXv26w2Ps0HA2m/aEiJWaMx2avoVxctdkUJFekvN9ZhYGjQ+ra6Bkp4FvdobeCO/2e/
         8Xrw==
X-Forwarded-Encrypted: i=1; AJvYcCUdq8L8E2JuPJh1HnNL61Zh4PcYlirZQqwJUzBIDM3g6km/Sn3hm+rN0n7Z3Rmc3aVNu1Q+fdgr4iU=@vger.kernel.org, AJvYcCXhUwYGZUhQnTxDjGBTOlkX1RYP7Bt2s2s0C5yPeitOO8lveglNs0v4qo8/Ydmr6gG/s0G7Hgvb1nluON29@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZc3p2Q5fW92evY4CD/cyqDfzgcwvvnsxrwtja7yQtakX5glT
	DZaKU3LaijSNdBVs9nZ7IwZF31/9cS7fWF7rOsVeSGp84gy70aEF
X-Gm-Gg: ASbGnctGjj9c7oWBXqCxaT6MWJe156o4/AkR9X1pr9nIrPEN5gzmTVxl55k4k2zafvZ
	vn32g7+mNhbdQoO8JpBBSU9Aj/0K8gv+rKfv3j5FJQO+QUeLfkkyj3cpja9fRjzK3zjvP2Ab0Qc
	MRQLATJ6aRGESpUmx85sRj2lc95sR6wizhGPVs6EWI6Tu0GwqPp2P4oGWeBt1Qc8O6Tqbty+Q4O
	J5kB3//PwXKjkcrK874DUSr3TzYaPdP2OCJ2HcT5XVMYj6z75qA3GaF5v7XW7zXGLdGqTLoqsKz
	O+/FHP2JjDqR0u4awllX8OnRCS9hVqgDflyw5DLil4sZL5WhCKpLVaRHUP70bcoImsHV0V8Z/Lw
	+a9xV+Cn5S4K6+Bp6Ams=
X-Google-Smtp-Source: AGHT+IGDmHTGhruK6wW4y9Jl3xhk5kCK95hI0Cft5V7xjnVFOw31DW5QPpTuy/nGifTpriStN2f6PA==
X-Received: by 2002:ad4:5f8e:0:b0:6e8:c713:321f with SMTP id 6a1803df08f44-6f2c4655d5fmr77521476d6.35.1745009430109;
        Fri, 18 Apr 2025 13:50:30 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af11d7sm14355906d6.6.2025.04.18.13.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 13:50:29 -0700 (PDT)
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
Subject: [PATCH v3 3/5] staging: iio: adc: ad7816: Introduce chip_info and use pointer matching
Date: Fri, 18 Apr 2025 16:47:37 -0400
Message-ID: <975a52c4713491be77e2f1dcc73a872017293550.1745007964.git.gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745007964.git.gshahrouzi@gmail.com>
References: <cover.1745007964.git.gshahrouzi@gmail.com>
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


