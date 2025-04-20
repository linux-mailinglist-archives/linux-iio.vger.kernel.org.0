Return-Path: <linux-iio+bounces-18364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762ECA94666
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 03:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D47175842
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 01:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D5514F9FB;
	Sun, 20 Apr 2025 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ29zrTT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9790B70800;
	Sun, 20 Apr 2025 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745113756; cv=none; b=Ih5HRImUVSxF74dBBQTCoHqqMkwe0SQ5EQV+AaUOBDTiL4jK8MG3xtkVbePUlEERW4tix+nPQaBO2dg+kSHVmaRhuOIkJQlJ1kg6Iwzo2+t2+t9bGH4w2QkNe176yXPVudJwg8zahqg7imcNkcSnf0jG2a9+HgTVVxuTAq6JdxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745113756; c=relaxed/simple;
	bh=ZtWyf+85ZAZuuUdke/D6KK+1edjKVBiOUFx39D2hd6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBJqBtBTjxYyxHWOOHf6a+HYT2HQPLSy8P967zo8BBHSyG2dp/hg+lBeMi+ju+KGhsuOxdMHdNNuQl+F8ciyA/CJw/ufpZPhpa/h4w4k+rHsPArB4g4mr8J4esIKMJBUSghoT9nLTIpTK/KZzuF0gykn4lc0zv9oI3nJiI/wlSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ29zrTT; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8ffa00555so25896156d6.0;
        Sat, 19 Apr 2025 18:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745113753; x=1745718553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=de216G9QJ9z5gWQFLLYUZKYI5uHds9pgvjd/vVy9J+I=;
        b=AZ29zrTT2/qqywXteeVaxQvuMQ2zz7VYcFXeerX2M7fA8J2mh8eC6zVWhtaRX3BCEa
         kxYmYHQOImS6YWZQxQB/1JIhLpTsqyh/biLxNJBcqdcFXR411ti10eBN7EtXhy/St3AW
         iZ14VV3vNu0HdDetOgIcHuRgy0Ga1SwVNlhSYXrteuDA0EIs8GMYJxyosLJj30KBE7KS
         JwzGWDFxy3zXWVeRuVlYYKvqCmc6treL27KH9VDWy1R9TdSczuQJbjkmIx2tZAH8IH6D
         kuvjNlUJWusdsPxgATR+jz7SSuOCg90htgkQvOAjqmB+b/liTuPX7nz9kzu8/mV0q6qE
         dYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745113753; x=1745718553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=de216G9QJ9z5gWQFLLYUZKYI5uHds9pgvjd/vVy9J+I=;
        b=b9mk26V9Ycg0MdD8sWGQP5oOpQJQDt1axCnBK13HXbmi9ng1zj4lYf0t1TyGICjEex
         Lg30gBH2k767caSFXUIHDmVwCW/SoSYMK36Hd/+R24d4LDYywIfOddB+cNDPXKdbmYdv
         wsVdADbnq/N9ZjZ3u95nt/bjwbGxS/WtTPbKlmY/Zm0MQUHe1LmE4dTLtei2j/aA/XR1
         0ZOqhiiSqU+c7idlr3mgB/pVVUJxc14j4ZwDPFcSqTzima3/cVYORgwATbUXfdt27gMe
         hAGd04oQ6Rj5XLuppZBSXKuTHhkYDh53mxQ7yBtQA3M4Zn3lkpxfZt+7d4oZB+7KlH/r
         UiwA==
X-Forwarded-Encrypted: i=1; AJvYcCVFyZOnpS8QVauTf0xnDz69uZbq99KRXr6nj6EoHHeEA21zgrMrI7NJ3zFlZOCJmZq7IodNI5w6u6mIEwQ3@vger.kernel.org, AJvYcCXzmj99PzPQQnN5Gwqaa2IzX+t8yJ/vWoqcmw8U8r5l1jZaybT9mTG9MhJj2q/4bXSTFciqgkPsID0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeETbhDCdFTA736yx41irOp2f7AtGyiJSqcyU6exJUKq/mpbQw
	szNkkR0lxqaZfuLSGhlASmVFQwv2mrfAE9oYYzTNjGPGmIHAN8aC
X-Gm-Gg: ASbGncs6/h0zZhIuDa8yULC6dMqcrTGJSbrI9LbsYSI1NEOO1hIrppoa8EY61uj+rVG
	2R1q7UVSG0rG4KUjw+K/2RXFckJV/eZonSZcOhyRPjNGxxKkXG2FW//Wl5PgNcLruMTpbVFpzB/
	Dv9MbFNIJn4hwZ0pL8Rj9Nj8EDioTIfGMA/StEaHyxV5KYes6HyIFCxPV/O48O2Wd1JH1rit7vK
	DYpS1QdpK5JEAAEi+QYigwGRB+PTOCxM/jYLMPV6GomqJcyqNHdO3gro1fx84xh2y/6o2fXxKKc
	Abv1rnK3t6XsB7RhO2038KISc7YBqRzGasz65HYL7RROEeuePFSfnwPWOcWbm/HkNetnzCAou3I
	YrrRuSccuboi0pe56Oaw=
X-Google-Smtp-Source: AGHT+IH8VO4vXzl0rubJg0RyzomASRe17nj48diM7NE29nTOhklwT9EqFA+/1DRk9ANTDDCdzpLPwg==
X-Received: by 2002:ad4:5f8e:0:b0:6e8:9525:2ac3 with SMTP id 6a1803df08f44-6f2c4656a9amr154919086d6.34.1745113753379;
        Sat, 19 Apr 2025 18:49:13 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af1283sm27583846d6.23.2025.04.19.18.49.12
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
Subject: [PATCH v5 2/5] staging: iio: adc: ad7816: Rename state structure
Date: Sat, 19 Apr 2025 21:49:07 -0400
Message-ID: <20250420014910.849934-3-gshahrouzi@gmail.com>
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


