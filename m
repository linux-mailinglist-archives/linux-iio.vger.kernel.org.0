Return-Path: <linux-iio+bounces-11548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642329B434B
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 08:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EDE1F234FD
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 07:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7972038D6;
	Tue, 29 Oct 2024 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xsNcgShk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D49203700
	for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187549; cv=none; b=U1XphFqkX6dHk0An2qytCxCDvvEnw841vz/KUrG58Sm4yR6PaqC7yTaQvNu7qDOkm9wppIKuwvXePnsHauUH7KYJt7JSMX0HKEomFalAU9bIJvLojMpKTdutRoDasM7ryV5pjM50Er5qpy1J2Ry+jzPip2RTZgKni5cCM+ldp68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187549; c=relaxed/simple;
	bh=lgc3ZdvonuJhwFaGdS5M3g6B8YizifcdxdIZV7LNhqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fe7pse+5wZlw3WYrj6Htd8UD8Dkiht2EZFdnfK85p5hek34U4YZlc6UC6D4E7BxmXzF88UB6K+jVmYEGD5xb8uViFp6/QWKMpPj9zjWps4/pXskdvjxFlUIOn3zGahyZ3CPviR/dinofPN7XIsjfyFj6j4ziSqmMJW7vrBw6rAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xsNcgShk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so3346958f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730187545; x=1730792345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6+OsC9+LoXLR+j3K6I0JJSao5QQ/Zax5Bndg5L11B8=;
        b=xsNcgShkNcseJg+YQUzGMjpD2YOqRl+yQT2OpeAKwSqKv7FMkKl1WjJR6mF66eZPrS
         xNulAykMihM2hUoaUImwP40Nm5Wtiq1M0yNzx8bghTc4wPr50l6ty4LYEn0QofgWYlJe
         wk4VKt6ZpxglErrAf7S9obzjl9SQRECgxuluZu55dEsi0NTvyOsCKEHpokoD8cUqDUw8
         Nsgzg2fdKbPwQhMiFjtO5Sq2UuTcnwYcLlXstjCP1sQNyYlyySjaoKkrQjpZoL/Y4GDS
         F/JOWKV6HcXZwwwm0OdV94dUQwo9++cD2PKqF9M4ZwbxWN7NM1QUSiBkx0t3oqb90rpT
         ODQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730187545; x=1730792345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6+OsC9+LoXLR+j3K6I0JJSao5QQ/Zax5Bndg5L11B8=;
        b=JGwXKcTUFV8m3nNAcNdfCBdIdrBOqgiMopNVPbXJm2YLEG46SA0Ribz6/tdkbXVrWd
         ygwgxqqXkBWtbWs1sAjVaLlbe9vVi7TNRh6jo0490EGTqsqC4sG8bIKpK0QAhrJakCo/
         ceIMQa5aZCRAQVWIe9PXDPWKBdBoLVuWoEA5STE3Ogp90xmYNsryP8jPMrJGd39uqwma
         eq15AeTwfud7t8rURmnxdc5AAM3xjnJlvSOJjek8AYFsEVuSuUAR1zVcJQLKa58IKsD5
         R1wXSwJ1cLxXAoLAQ9e9Ww0J8/nS2S6uDJuXQGIus82Qa0oauqSQKLrc7QpPi0G1Ab9p
         PTPQ==
X-Gm-Message-State: AOJu0Ywn176qZ3HIpzACY42R0OG4XyjBiqpT3QXppyVtHspcIuv4F7wX
	hhRK9ivd+S4SCcYv+Ro/j5Zfumlbeu1rAN7PKoBc9yYgFzhDAq9TRjqGhs/TZaY=
X-Google-Smtp-Source: AGHT+IHAE7eZN+Eog3lt2T5PRj6/6N6+17FYiNk3ptAKBpVkQC3Djm2jkgzh/D+1INJFk+3xjoxEDA==
X-Received: by 2002:a5d:484a:0:b0:37d:8084:160b with SMTP id ffacd0b85a97d-38061127f9cmr7578370f8f.23.1730187544626;
        Tue, 29 Oct 2024 00:39:04 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b714fesm11692939f8f.71.2024.10.29.00.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 00:39:03 -0700 (PDT)
From: ahaslam@baylibre.com
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH 4/6] iio: dac: ad5791: Add reset, clr and ldac gpios
Date: Tue, 29 Oct 2024 08:38:55 +0100
Message-Id: <20241029073857.753782-5-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029073857.753782-1-ahaslam@baylibre.com>
References: <20241029073857.753782-1-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Axel Haslam <ahaslam@baylibre.com>

The ad7591 has reset, clr and ldac gpios. For the DAC to output data
continuously written to the data register the state of these gpios needs
to be set by the driver.

Add these gpios to the driver making them optional in case they are fixed
on the pcb.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/iio/dac/ad5791.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index f6b9a40241f3..c5d4d755d57a 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/device.h>
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
@@ -76,6 +77,9 @@ struct ad5791_chip_info {
  * @spi:			spi_device
  * @reg_vdd:		positive supply regulator
  * @reg_vss:		negative supply regulator
+ * @gpio_reset:		reset gpio
+ * @gpio_clear:		clear gpio
+ * @gpio_ldac:		load dac gpio
  * @chip_info:		chip model specific constants
  * @vref_mv:		actual reference voltage used
  * @vref_neg_mv:	voltage of the negative supply
@@ -88,6 +92,9 @@ struct ad5791_state {
 	struct spi_device		*spi;
 	struct regulator		*reg_vdd;
 	struct regulator		*reg_vss;
+	struct gpio_desc		*gpio_reset;
+	struct gpio_desc		*gpio_clear;
+	struct gpio_desc		*gpio_ldac;
 	const struct ad5791_chip_info	*chip_info;
 	unsigned short			vref_mv;
 	unsigned int			vref_neg_mv;
@@ -337,6 +344,22 @@ static int ad5791_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
+
+	st->gpio_reset = devm_gpiod_get_optional(&spi->dev, "reset",
+						 GPIOD_OUT_HIGH);
+	if (IS_ERR(st->gpio_reset))
+		return PTR_ERR(st->gpio_reset);
+
+	st->gpio_clear = devm_gpiod_get_optional(&spi->dev, "clear",
+						 GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_clear))
+		return PTR_ERR(st->gpio_clear);
+
+	st->gpio_ldac = devm_gpiod_get_optional(&spi->dev, "ldac",
+						GPIOD_OUT_HIGH);
+	if (IS_ERR(st->gpio_ldac))
+		return PTR_ERR(st->gpio_ldac);
+
 	st->reg_vdd = devm_regulator_get(&spi->dev, "vdd");
 	if (!IS_ERR(st->reg_vdd)) {
 		ret = regulator_enable(st->reg_vdd);
@@ -382,9 +405,14 @@ static int ad5791_probe(struct spi_device *spi)
 		dev_warn(&spi->dev, "reference voltage unspecified\n");
 	}
 
-	ret = ad5791_spi_write(st, AD5791_ADDR_SW_CTRL, AD5791_SWCTRL_RESET);
-	if (ret)
-		goto error_disable_reg_neg;
+	if (st->gpio_reset) {
+		fsleep(20);
+		gpiod_set_value_cansleep(st->gpio_reset, 0);
+	} else {
+		ret = ad5791_spi_write(st, AD5791_ADDR_SW_CTRL, AD5791_SWCTRL_RESET);
+		if (ret)
+			goto error_disable_reg_neg;
+	}
 
 	st->chip_info = spi_get_device_match_data(spi);
 	if (!st->chip_info)
-- 
2.34.1


