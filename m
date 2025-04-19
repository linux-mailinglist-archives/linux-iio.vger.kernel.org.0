Return-Path: <linux-iio+bounces-18325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17521A943A3
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 15:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349DE1790CC
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 13:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4591DED47;
	Sat, 19 Apr 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6QjuiaX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A875D1DDC11;
	Sat, 19 Apr 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745071006; cv=none; b=RAa7WSqfcOYnLXCQa+cwjAallE3iuAVbiKM6eqoPXMfTRhR+3vnHeUjXlwWmT0mRRLTiuM4WWt3/4tJXcO+eHMps23RRLc2oY1hfjnx/ST1IgODkSvxuF8Ie10QNvGfdtBi9l9x0fHQ9PrICJA5EubaSXJZgjAd8XhsVFBw4LbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745071006; c=relaxed/simple;
	bh=ZtWyf+85ZAZuuUdke/D6KK+1edjKVBiOUFx39D2hd6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/X4TQvk1aU9it6r0yA4X38jb5MmVSLBxW6TKGKDTrrvd60D+c40AlgY8Ns9Kw7IknP/fFGJVfP7VrYpq1xmtc6kWP/M+iuw3bwpB/JwlZGNaAt4NQ1cQk87MzKxCkhZHNRpImWuBtSN2nz097HMNVFVgkJwUcaRulQZyc7HotM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6QjuiaX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5ba363f1aso348222985a.0;
        Sat, 19 Apr 2025 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745071002; x=1745675802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=de216G9QJ9z5gWQFLLYUZKYI5uHds9pgvjd/vVy9J+I=;
        b=d6QjuiaX1CgnE2nRscsRM+IqfTEql7UN3dLnMwdOgGaunp+Lh6lc9sr5RuFA4JqH/W
         3wMHoIU6MxXyKhu7JMIn9tCMzzutUoJnUg1HDrOUyHh7hc4HagEei8Byhrl+lOfXBuur
         eMqSYcoc5AiyXewNmOgI8UlY4VvaK1uXAI3tqIlFa13K4q71WDoqncveALt8ZKDOrin+
         Qr5elWefzdZuFaKyy87VwOdNXZKnzpzzyJIhCI6/N49B0z0bbfvIKLGgH6vnphc06pCJ
         KwMrNULyHIpK9tQAju/Vj2Rgvqe8QDL/yZteOhIFz0p/bzag4h5e2hbbbGXUx23Hj5Cv
         BK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745071002; x=1745675802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=de216G9QJ9z5gWQFLLYUZKYI5uHds9pgvjd/vVy9J+I=;
        b=oi8ehL0dEA074pqhN+Gcq14JPCx6mjBlPN2UtYhVIUQXNwfazcKFNXMiYnaygjwVDK
         gMC3G+XnjDW01KYjgkRjlnHAgjG2BOZgryHIrmyDmDrFZLW3eeQOGPNWHST1Dfw0dXfN
         qYeP91mmpahMQAXUiMJlM7cOehQ1tZcgUd/BjzeyxC7T9P93BqyLMfZGsOjTUUd7/ZeG
         1TLfFZKmlV3LrZScGdnnMnpXVznjkll2MesuTqiMupPnKY4dKKUdzL9EFdRIv2/t9oj9
         WPFlGP82seNzWtH21kl+WEpiF27eMRZvpnqz+mADIOKSAnTj71NJaSiLdo2JQ57+D3Hz
         3f7w==
X-Forwarded-Encrypted: i=1; AJvYcCWc8CKAuFnlTodYiOOuXKx/Lp4ho1tjgvo5SO9/fz807cjSA63wi4ERpgDXID4tgX95VbRxsF84KmZePDNC@vger.kernel.org, AJvYcCXPjlGGgpREKwP8SdGldm8z3sb4ZB1uZttuZ0OvKVNmyNFZGxZ2pffXWJNM9ATd5lgFkMUKjV4lxnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1ie2t8SqgwzGrz/uTIhyXqVi1v3Iq4GcG01gpYX06QzHP7mN
	jyE3Td9Gh0V6+Soya05S1dmfdCgfc93QKv18Z167GLnDyVFjbcUVjZfZnswbAWo=
X-Gm-Gg: ASbGnctTzJD11CxW35hE2ONWdGhirBJsKq0QUt4vmiH3ZqeDgbEGV2mPqB6Ub8EA0Si
	YdWJJdAV9V6zOdlr/dz257gLIwOHuPGZm0c0WE8r0lFUuyYUVU9o3iDnI82k3auKHysNMDi1iK4
	OLc8S56u7mpKhQ6f+9rg/7vE1nARMz4lMQItoVGeltAcKftSNHQcld+BJ40U3fGPRDrqn4NVZT8
	tSBwq0FACacqXZnG1HVq6EAMBZADeKeNgeKevRDfywIb17rV94mmp7ypOpBkF6Bbw7u5zYZGmaE
	zKU/OXR5U6wK+Nj3Pl6fTb8khaxydtdsZme+BrBpyt4jVsxrWRyn97ULg3JRJvNyIg==
X-Google-Smtp-Source: AGHT+IGjO9XrU530ITxvlahmC6BM8XwQH9uXIKeS9Jh/wyHB2OzRz2dqUKbHhGBZbB44HCl8uOWXMg==
X-Received: by 2002:a05:620a:2802:b0:7c5:a2f8:e6e4 with SMTP id af79cd13be357-7c927fb1a9bmr968863585a.29.1745071002382;
        Sat, 19 Apr 2025 06:56:42 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925ac4749sm214350185a.59.2025.04.19.06.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 06:56:42 -0700 (PDT)
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
Subject: [PATCH 2/5] staging: iio: adc: ad7816: Rename state structure
Date: Sat, 19 Apr 2025 09:56:35 -0400
Message-ID: <20250419135638.810070-3-gshahrouzi@gmail.com>
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


