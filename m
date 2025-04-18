Return-Path: <linux-iio+bounces-18308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B5AA93F2E
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 22:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB538E27FE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB8224BBEC;
	Fri, 18 Apr 2025 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAylS444"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF330244196;
	Fri, 18 Apr 2025 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745009431; cv=none; b=gNqKisie7UOC7x/7oa0WcZxpwAjHL+136tma4heU6dr/nUITQJ5y4HT1i4kYeOCALtc4nuVMh8oFpPnsuCroTiOo4j5djS9m7a8r9AJRUu3YYYEkc7zh9J1H2jmHShrRTl7qvO5onrh64fPX0xGK6lGHtF+CES/et+E1JuebPYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745009431; c=relaxed/simple;
	bh=ZtWyf+85ZAZuuUdke/D6KK+1edjKVBiOUFx39D2hd6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oR5BywI03sNbFMV9S7pje1jntqsqPzHq6AJXNNa8hA68o5rwguanHXEd9ww/tWOdtLYDJ4LDRAbi+ycA4l0pcYYQPUDBtnpvG+L2m9HYmq/tPXQh0arICXnCiRzxid8RHJY+Y53ngEk7SPYcPAT9u/0/zlrE08twT59Qd8VxVLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAylS444; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f8657f29so20583286d6.3;
        Fri, 18 Apr 2025 13:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745009428; x=1745614228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=de216G9QJ9z5gWQFLLYUZKYI5uHds9pgvjd/vVy9J+I=;
        b=hAylS444n9Mf91eGeGzwTagVLvvTKgkedy4g2DjiY6X8hf7GpDxOWisZMCkQHALnDj
         s5cKlBE7VH4+xjvf9lLX7VV68xfQE51sgyBzGgvFVmoKrJ/LPj57Jmon16e9Gp0rDSaJ
         avDYhP/yXSv+KG7PKAlu4GUNzJSPWP98Zz4JW31HobmeGTjtiihiKesLnzPGJTLLIGPH
         AZ5YJsRU2mfLBF5/SRe+RVIxl91HBD1oAnLEQ3DWu17fhZVskw45RPtbrYuf7o8RkJ5P
         kEmn8Qdg9IhzGm59Q26mT1qIS6DfNT39DjdTA9kSJFeVv5TsatJH5tOIT2I6NL+5r5av
         mrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745009428; x=1745614228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=de216G9QJ9z5gWQFLLYUZKYI5uHds9pgvjd/vVy9J+I=;
        b=ebEjdNdvmXn1mbpcgyMPsxk4vnwQa4DWuzAXbtFjEOV2TyCR6r8LIwwa2h2uJWKeGS
         Y/3YNYxmBJb/cMNKDQ6zbIlbNsVFeuwgfDHoZS07HfZ7BFpTfHBYtTXgd49c2KlL2YQu
         1Yt6vHLhzvzE/icv80igrxwUS7gIG3muaP0jabGbFMjjkJneiTDeMQrr66ZBYDdEN5qw
         11uvvrWC+RJ/aIqPemQyTK50vNtAf3IQQXaoFpDYzf0O6Ye/Oqou0Y+bi6NEV0UuQSbE
         n9NkBehzBiJMtAGBa8r7SEnkCVp7M8q6jwV7YANo7BhT8nKENhU2BxrC93lBBl3PISUw
         vYxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0PvcYtxYtBOGo1NIh3Z4+6ehpXNvmKHgOfWtmmhXG7uugFhIN14kjQ8HCuN0uSnSMAi0ramaxsFY=@vger.kernel.org, AJvYcCXXSleDgX3wD04MCGejseBv2eBubRhOaFg6mAjmcWcaBKT8xu19cjEgOzL+YE7tSC1k8pCzL9nKv/eioAXm@vger.kernel.org
X-Gm-Message-State: AOJu0YxoL5nD3cPjrunK+xr+rsuuIKbu2hqxJ0TC5sy8P19Wb/rC/7Cm
	vd02/T0SDTCIQktNKJ+CYINbWHdvm/fG6RZP4TmvO7VKk7sVijuN
X-Gm-Gg: ASbGncseT8RzxyIxT7NS5ikFHbZkTLuLmxUJF6Ec/A8nraYMaWxDhObbzFP9o0QR3CO
	jZ1oZscDcCqgVObBRKkfLSetS7V2Jh8riHYurieKgoDuW9kmy1XFlYd8qVrEwRVjKgmTXp2klQw
	eJ84Gacw21FL4yvDPT3yIrGntExpkVoikg2e7698k8p+B0bwakb+pqXXWz5CT1PUZTxoSouMdYc
	m2BTHfSbs2PklOUeBcJgf+Zy9FCel9Y7NvY/I3efYr2INr+SXP/JmkgLEZABOu+OYdM55Hb+bPo
	xxNCCreSEwD1dGuIgCmGagFyebDo2AjK50wWRNCqp/rByt9DnqOlbbptKqD5wg9rZEm8/RSwvaV
	O5QTA9WxGlpHNAvX5VIA=
X-Google-Smtp-Source: AGHT+IGime0GJ1aBGvs77WfZsnIYGkl8D80gnhzNZ442Bzp45vV8+8Pl5nqX8PtMoaqO+wpE1Aqmwg==
X-Received: by 2002:a05:6214:250b:b0:6e8:fbb7:6760 with SMTP id 6a1803df08f44-6f2c44ebfbdmr65373506d6.1.1745009428478;
        Fri, 18 Apr 2025 13:50:28 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af11d7sm14355906d6.6.2025.04.18.13.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 13:50:28 -0700 (PDT)
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
Subject: [PATCH v3 2/5] staging: iio: adc: ad7816: Rename state structure
Date: Fri, 18 Apr 2025 16:47:36 -0400
Message-ID: <b2d3bb8d1e3ef161e0bea7423656a57cececc2b6.1745007964.git.gshahrouzi@gmail.com>
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

Rename the main driver state structure from 'ad7816_chip_info' to
'ad7816_state' to avoid confusion with the upcoming structure that will
hold static, per-device-type information.

This is purely a mechanical rename with no functional changes.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index a44b0c8c82b12..cad2e55aff3f9 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -38,10 +38,10 @@
 #define AD7816_TEMP_FLOAT_MASK		0x3
 
 /*
- * struct ad7816_chip_info - chip specific information
+ * struct ad7816_state - chip specific information
  */
 
-struct ad7816_chip_info {
+struct ad7816_state {
 	kernel_ulong_t id;
 	struct spi_device *spi_dev;
 	struct gpio_desc *rdwr_pin;
@@ -61,7 +61,7 @@ enum ad7816_type {
 /*
  * ad7816 data access by SPI
  */
-static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
+static int ad7816_spi_read(struct ad7816_state *chip, u16 *data)
 {
 	struct spi_device *spi_dev = chip->spi_dev;
 	int ret;
@@ -102,7 +102,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 	return ret;
 }
 
-static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
+static int ad7816_spi_write(struct ad7816_state *chip, u8 data)
 {
 	struct spi_device *spi_dev = chip->spi_dev;
 	int ret;
@@ -121,7 +121,7 @@ static ssize_t ad7816_show_mode(struct device *dev,
 				char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
+	struct ad7816_state *chip = iio_priv(indio_dev);
 
 	if (chip->mode)
 		return sprintf(buf, "power-save\n");
@@ -134,7 +134,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 				 size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
+	struct ad7816_state *chip = iio_priv(indio_dev);
 
 	if (strcmp(buf, "full")) {
 		gpiod_set_value(chip->rdwr_pin, 1);
@@ -167,7 +167,7 @@ static ssize_t ad7816_show_channel(struct device *dev,
 				   char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
+	struct ad7816_state *chip = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", chip->channel_id);
 }
@@ -178,7 +178,7 @@ static ssize_t ad7816_store_channel(struct device *dev,
 				    size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
+	struct ad7816_state *chip = iio_priv(indio_dev);
 	unsigned long data;
 	int ret;
 
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
@@ -351,7 +351,7 @@ static const struct iio_info ad7816_info = {
 
 static int ad7816_probe(struct spi_device *spi_dev)
 {
-	struct ad7816_chip_info *chip;
+	struct ad7816_state *chip;
 	struct iio_dev *indio_dev;
 	int i, ret;
 
-- 
2.43.0


