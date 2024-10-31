Return-Path: <linux-iio+bounces-11676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B359B7532
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 08:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AA91C219D3
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 07:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFD91547C0;
	Thu, 31 Oct 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cMW1ujZN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0714AD1A
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359078; cv=none; b=BVUI/46aWRqPcM1G2JAy5N0r93Cm8qInWigDtXpC62kfLkCznxRLVxmZdFfCurT4+cLhJMXn8TCD/Lb7d5mBcTavi+usTqfUi+h2vt5q6IQN9QvR/TKLHb07k16bwDkBgq58DWv413SwEI3iK8odQLPlmiGH3tzuNoYeXOzP3YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359078; c=relaxed/simple;
	bh=Op2p8Q2E5igZsGlkYWqymbzX2Ifj7PSmb49r/ALp7lU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f4vdDIszu6oef+LksvnH4+84CPUDqY5XHWYy3MMpZJHrnbpv4MexhjLAof9HgzYt1aorPGLgaaBU64MSu3mGj3n77wMOdjb571p4uCA4FH1pN+WjC+EXHBks8jGyI65135LC0feHWGZHQXGHrQrPUqVQPiZzp1L7T3PUP3y4+X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cMW1ujZN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37f52925fc8so340872f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 00:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730359075; x=1730963875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1pq/Bgv4QeCrwiPVa9U9DPj0A/SeEyPL96AcSHmLho=;
        b=cMW1ujZNbrhUsB95uM8iS5Y66yMmzaqHwBPFll+On9vBj8euqJESQl596o9IleEmWd
         ePwZ+Qrrk9gMDKteXQ3ULgYEU7hB7urb1vmNX5XBb2N5TbWea9ZP6N+uipU8fuYVRcWq
         f3N+3xdXiiVYWgjbb7OpCv+sHvWKMrm7iN0v9+4eSuMsgdXT1ODczUlmmimjiz5bU7l+
         CQKKrSxoPqEfcDNTGwJF7EAWhP/H2K2B3nm7xBc766OumapcsWVNKOkgv0INh2YaPg32
         2pld/G1OgP9ozhnNCpimS5bZtUb0xvHGfcLVrRepiCKzJKgy8blka6baWqheMK5/MTIs
         t0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359075; x=1730963875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1pq/Bgv4QeCrwiPVa9U9DPj0A/SeEyPL96AcSHmLho=;
        b=LCCNieL9tqrNBdtVxGrrRNK6LYH3cCmv+S6Jdqwf1/IlL6nBDsajtQ7WkhwmRdRX9m
         gOKnbrV//HzHZyEfEtGMb8HXfKKFNMK4sivR+5VK3mnZjPbXmwxHI8hgOAPD2CG68bYV
         CQGA7zB1TkmR8bqR2TXWljYDeyepLMCzAie/fGIG5KB4SaJBRAohnX6rz1r/53gdsAeU
         ySV/q7M1zU5QgL225DA7+fTogtFBEwMZ/aOGw4REmeMwmjZeXZEjx2T+tlvN8BMMpV/7
         kgj4LR4m8NkWiikl4WyKpboq6Y+WJRt4Q5gEFGwwnCHGg/bhdpOK8Jp2bm8pNIGLIcd0
         OlmQ==
X-Gm-Message-State: AOJu0YzBE+9+1NXc3khaXyf2iGdDWbWbT8OhQjTHxvpu5z7wujl7HVFb
	dpI0zTydhp2YKwALEEbdkOIWnnvyjS8cd2hLo8Aaz/VHvOqjGGOCQV5t/A6ELi4=
X-Google-Smtp-Source: AGHT+IGW7kCzNAoBXXZ34GznNmWRMdGAze3cMSGQu0oer+FnmY9AH27Byjv+q+Uux4qqJf3Mcgy/wA==
X-Received: by 2002:a5d:6a4e:0:b0:37d:4e74:689 with SMTP id ffacd0b85a97d-380611ed135mr13359122f8f.47.1730359075031;
        Thu, 31 Oct 2024 00:17:55 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e694sm1187547f8f.86.2024.10.31.00.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 00:17:54 -0700 (PDT)
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
Subject: [PATCH v3 4/6] iio: dac: ad5791: Add reset, clr and ldac gpios
Date: Thu, 31 Oct 2024 08:17:44 +0100
Message-Id: <20241031071746.848694-5-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031071746.848694-1-ahaslam@baylibre.com>
References: <20241031071746.848694-1-ahaslam@baylibre.com>
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

Reviewed-by: David Lechner <dlechner@baylibre.com>
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


