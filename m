Return-Path: <linux-iio+bounces-18214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729AAA9234D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A174647D6
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603161DE8A0;
	Thu, 17 Apr 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsSm4LF6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F12522371B;
	Thu, 17 Apr 2025 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909278; cv=none; b=j64bznkXdghki4pMdGhoBZg5PKDosBMQhRzjwy8qIlHLeC4AfrIk2jeeyJpJOgrqrbNEtlt/ienllO7lYs8csPvx8vRnTvoVCvPPTzzOzZjgYd81Hsd+WsLlWDUBMrdAMLqUyYQLYM4VuzZq9y26zL/wk07cxuJuQPb0LkpIwzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909278; c=relaxed/simple;
	bh=9oEB2dkP3S7X/B2dnDJe2lnfHeb3jiQQLugvRc19tac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/GQ1h75UNkm6bcKbsxgyBfEq/QkdwRYvCm9vqPNRTG4k8gxSRctMoYuCqKyGx/1FOJWHbtgG/MttI+VTa8U5sEouk5ImglukKzH84++TIA+5q+OpnC3SaDultlSd6Kq0csSMHnvOlJWEtRRLSIZBkdU48BYivs+1N9gNFsxvzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsSm4LF6; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f05acc13so11900386d6.2;
        Thu, 17 Apr 2025 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744909274; x=1745514074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXWRs1cTjol07xpBkUHs8BYxQsZJt8nnKpT27OeCG9Q=;
        b=hsSm4LF6AL1k/+6YYBwQOlDkLQ08Auwz/rOpsApiPnElsUIM8I3SaBHu+egHMz0my+
         Ou8RARSI3/PmQ12BINHhRNkSPKYT4ooqVYSdnx2Ahy/46gh934uZY2F+MzQflLv8m9Fe
         CMQPCVDfQzRgSkaW7jWV1kIrq6Q5nHo6Sjyhcu1vw8REcBa1/mOB1cbizifPjUWK9qSu
         G2PEngVpwN3ezFRim9bj4XnJ6m0iqOnSZAUvOJFdBcg7/f2WS7ySpZ9Q4Qb+wpUA3Xlb
         3HGn8y44l8B+atYULs0pVh9rHJfI4YsGOjJ5CeSyAdTpKidzZPLphDhhHbrODTMfkSaG
         +bbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744909274; x=1745514074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXWRs1cTjol07xpBkUHs8BYxQsZJt8nnKpT27OeCG9Q=;
        b=ampN679vmhOfrZeUU7EO/zT8luwdTc3wQDT9TuIoHuWupHBn8Ls+d0GRwlKIfExwIA
         T9mZnoQvb3sxTaExXFzbBNJdJZ18WqCWT7Xj4EmCj8pzNCWqaZkt8Ao+9MaGomKjFoow
         QLhlPRVAGlvARRo1pmxM5fDAFa1yWPgl3q0BNv69EcpKUyttzvvx1GqUYEDdQf2Nexg/
         CN0QGT2c98V+lLKLM8Sbd4QgEzrLNiMf0sngEiXVH1NJaHQZtlKL7c9fPgB5DU8e7tfO
         VWqmS01c6eJRYe8nZzvMh5Eu9vgwKnxSHgXHRR7C3ZPWMjkrTQQFM4CsKZKHlQfFVBdB
         hCLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAzBOmh33sy0xKIFvRER44PuzW3v/DRWwbxb3tGpD1neLN6r8NimJ5VMvgyBUY5giGfgFnbcnb@vger.kernel.org, AJvYcCUaevvTuKJKB1KXzXNrKS1LRuMQiQuH9Npi1F5xxMv9VN1Ubn9/5SwDdvATW7JO3DEiMu20DZ9BShD262Wt@vger.kernel.org, AJvYcCXOFgcNT8q72CkIcv1C5hvQzOoVIQnZBgPtEk0JzCAG/A24DAhPgvZgdLUzVFJ76i8M2MaN0U4bs9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR4eXBRH8MBdIW7mV1XBvGmDXrBAs1dt5L9y6M8DWsA6pbx8FW
	kDvEP7zsTcS4Vw30Spc8aPcoTdY86cyGp+ATrtnZ4ebeMLnuEz4q
X-Gm-Gg: ASbGnctd1/NykRIk3qytMokluVlv/uuqxWF2SQieCIWGuaUYoO68ajmvKhWQZ5W+4FD
	2lfFuY2dIFkngfGQbIpVkN9jIhYZcca1H6MInvzkwnlPQWY7/les72qBMqSPvFC/swkcT9xA2MX
	Jv/11cj7xftnxw9vhCX/IwZa0p4YiZxjoTWCHnrLMt5Ee4Bkf0P0MQr/d6tvJI0LBZ6f0lFkTHg
	mF3I/uhIwzlmnk0pkMTp8iLQazUH9daiSmFfuuOarXNIQfxAzvBRK2VqRWM1+M9jaOL8+Ky0pkS
	9afW4kBvxo7FDizj71LsLAylu6+1FQUVbhEG9qJSaIvBgtRLbOObSVk=
X-Google-Smtp-Source: AGHT+IHYzgvyals3Cpf2qth3nNDQ//h870rA/XXk4zzkO6uy9etL5tq59U7gkjqSLQAvzlKJg1Ozaw==
X-Received: by 2002:a0c:ed52:0:b0:6f2:bcbf:101d with SMTP id 6a1803df08f44-6f2bcbf11f5mr39617326d6.38.1744909273730;
        Thu, 17 Apr 2025 10:01:13 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2bfcc26sm1082906d6.92.2025.04.17.10.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 10:01:13 -0700 (PDT)
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
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: adc: Include valid channel for channel selection
Date: Thu, 17 Apr 2025 13:01:09 -0400
Message-ID: <20250417170109.602659-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet on page 9 under the channel selection table,
all devices (AD7816/7/8) are able to use the channel marked as 7. This
channel is used for diagnostic purposes by routing the internal 1.23V
bandgap source through the MUX to the input of the ADC.

Replace checking for string equality with checking for the same chip ID
to reduce time complexity.

Group invalid channels for all devices together because they are
processed the same way.

Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
Changes since v2:
	- Refactor by adding chip_info struct which simplifies
	  condtional logic.
---
 drivers/staging/iio/adc/ad7816.c | 68 ++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 6c14d7bcdd675..ec955cbf06c17 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -41,8 +41,20 @@
  * struct ad7816_chip_info - chip specific information
  */
 
+enum ad7816_type {
+	ID_AD7816,
+	ID_AD7817,
+	ID_AD7818,
+};
+
 struct ad7816_chip_info {
-	kernel_ulong_t id;
+	const char *name;
+	enum ad7816_type type;
+	u8 max_channels;
+};
+
+struct ad7816_state {
+	const struct ad7816_chip_info *chip_info;
 	struct spi_device *spi_dev;
 	struct gpio_desc *rdwr_pin;
 	struct gpio_desc *convert_pin;
@@ -52,16 +64,11 @@ struct ad7816_chip_info {
 	u8  mode;
 };
 
-enum ad7816_type {
-	ID_AD7816,
-	ID_AD7817,
-	ID_AD7818,
-};
 
 /*
  * ad7816 data access by SPI
  */
-static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
+static int ad7816_spi_read(struct ad7816_state *chip, u16 *data)
 {
 	struct spi_device *spi_dev = chip->spi_dev;
 	int ret;
@@ -84,7 +91,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 		gpiod_set_value(chip->convert_pin, 1);
 	}
 
-	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
+	if (chip->chip_info->type == ID_AD7816 || chip->chip_info->type == ID_AD7817) {
 		while (gpiod_get_value(chip->busy_pin))
 			cpu_relax();
 	}
@@ -102,7 +109,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 	return ret;
 }
 
-static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
+static int ad7816_spi_write(struct ad7816_state *chip, u8 data)
 {
 	struct spi_device *spi_dev = chip->spi_dev;
 	int ret;
@@ -121,7 +128,7 @@ static ssize_t ad7816_show_mode(struct device *dev,
 				char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
+	struct ad7816_state *chip = iio_priv(indio_dev);
 
 	if (chip->mode)
 		return sprintf(buf, "power-save\n");
@@ -134,7 +141,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 				 size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
+	struct ad7816_state *chip = iio_priv(indio_dev);
 
 	if (strcmp(buf, "full")) {
 		gpiod_set_value(chip->rdwr_pin, 1);
@@ -167,7 +174,7 @@ static ssize_t ad7816_show_channel(struct device *dev,
 				   char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
+	struct ad7816_state *chip = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", chip->channel_id);
 }
@@ -178,7 +185,7 @@ static ssize_t ad7816_store_channel(struct device *dev,
 				    size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
+	struct ad7816_state *chip = iio_priv(indio_dev);
 	unsigned long data;
 	int ret;
 
@@ -186,17 +193,10 @@ static ssize_t ad7816_store_channel(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (data > AD7816_CS_MAX && data != AD7816_CS_MASK) {
-		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
-			data, indio_dev->name);
-		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1) {
+	if (data > chip->chip_info->max_channels && data != AD7816_CS_MASK) {
 		dev_err(&chip->spi_dev->dev,
-			"Invalid channel id %lu for ad7818.\n", data);
-		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0) {
-		dev_err(&chip->spi_dev->dev,
-			"Invalid channel id %lu for ad7816.\n", data);
+			"Invalid channel id %lu for %s (max regular: %u).\n", data,
+			chip->chip_info->name, chip->chip_info->max_channels);
 		return -EINVAL;
 	}
 
@@ -215,7 +215,7 @@ static ssize_t ad7816_show_value(struct device *dev,
 				 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
+	struct ad7816_state *chip = iio_priv(indio_dev);
 	u16 data;
 	s8 value;
 	int ret;
@@ -271,7 +271,7 @@ static ssize_t ad7816_show_oti(struct device *dev,
 			       char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
+	struct ad7816_state *chip = iio_priv(indio_dev);
 	int value;
 
 	if (chip->channel_id > AD7816_CS_MAX) {
@@ -292,7 +292,7 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
 				     size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
+	struct ad7816_state *chip = iio_priv(indio_dev);
 	long value;
 	u8 data;
 	int ret;
@@ -345,14 +345,22 @@ static const struct iio_info ad7816_info = {
 	.event_attrs = &ad7816_event_attribute_group,
 };
 
+static const struct ad7816_chip_info ad7816_chip_infos[] = {
+	[ID_AD7816] = { .name = "ad7816", .max_channels = 0, .type = ID_AD7816 },
+	[ID_AD7817] = { .name = "ad7817", .max_channels = 3, .type = ID_AD7817 },
+	[ID_AD7818] = { .name = "ad7818", .max_channels = 1, .type = ID_AD7818 },
+};
+
 /*
  * device probe and remove
  */
 
 static int ad7816_probe(struct spi_device *spi_dev)
 {
-	struct ad7816_chip_info *chip;
+	struct ad7816_state *chip;
 	struct iio_dev *indio_dev;
+	const struct spi_device_id *id = spi_get_device_id(spi_dev);
+	enum ad7816_type chip_type = (enum ad7816_type)id->driver_data;
 	int i, ret;
 
 	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
@@ -361,12 +369,12 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	chip = iio_priv(indio_dev);
 	/* this is only used for device removal purposes */
 	dev_set_drvdata(&spi_dev->dev, indio_dev);
+	chip->chip_info = &ad7816_chip_infos[chip_type];
 
 	chip->spi_dev = spi_dev;
 	for (i = 0; i <= AD7816_CS_MAX; i++)
 		chip->oti_data[i] = 203;
 
-	chip->id = spi_get_device_id(spi_dev)->driver_data;
 	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
 	if (IS_ERR(chip->rdwr_pin)) {
 		ret = PTR_ERR(chip->rdwr_pin);
@@ -382,7 +390,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 			ret);
 		return ret;
 	}
-	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
+	if (chip->chip_info->type == ID_AD7816 || chip->chip_info->type == ID_AD7817) {
 		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
 						GPIOD_IN);
 		if (IS_ERR(chip->busy_pin)) {
@@ -393,7 +401,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 		}
 	}
 
-	indio_dev->name = spi_get_device_id(spi_dev)->name;
+	indio_dev->name = chip->chip_info->name;
 	indio_dev->info = &ad7816_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-- 
2.43.0


