Return-Path: <linux-iio+bounces-5564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29FE8D6B71
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 23:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7749E28325B
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 21:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B137B3FE;
	Fri, 31 May 2024 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aEqPs0Z1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB9208DA
	for <linux-iio@vger.kernel.org>; Fri, 31 May 2024 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190387; cv=none; b=RTDPlRmXOFoQKx3uKCA2AgRBwB3qDj8E9/LORuLHMdXibYuEbf9eVLHgqMGIKAa25YYz9DynkPtKEXOqiT54tTQCtQ80w+tSONmKMAbFSEWVbFi6ZqQIRbbl8uIdFU1RaLXch5NhLiFrFc0Kv30qw7WPI67Fse0ESkvE9jXAoFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190387; c=relaxed/simple;
	bh=Qz8pW8yq0GC1/ubfC/aOUI5AKdBL3VfpTv0r8bnNztA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=galnx4tG2hbixSw3Y9MoT4xIPj1HMiPdoFbpmfWFLYMIs7H+db0FntYG2ORPa1aHzawd1gh2HbrGnOvN6p95zUR+Q0lkb1Nzox9/1d4FdipVL3FnU1Yt7Cx2l6l252RC7+km6NB6PxDeflm8cQe8v8Ntb+KxSlGg/t75UxqDCFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aEqPs0Z1; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f8f56a30a4so1264633a34.0
        for <linux-iio@vger.kernel.org>; Fri, 31 May 2024 14:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717190384; x=1717795184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckX290zz5uu8jKssyQCBCI0FA48FwJ1fiAxtXMtJpto=;
        b=aEqPs0Z11iMwdJcHZZjYcJRw/XhfVKHRqQATw6W9+u77wJ7hqXbaSfCVp34qYAjtJM
         vG2130og96zqUnX4/26gaAN0G10WNiiqRM1UP8Q+kYTrtiPXAiqgpZwdsn9Yb5OEG9Qj
         lTFS/vaIrJ9Me2Eb4D3DGZWqZ0cXQ948GpflQuWDIP4h1Usc4tYuz2MU9nFEDCSKMBZN
         eO9vh78TaY9bq2hmTWj4DKmIt5DCI1OUclod04OH43vdLoygwH2YhOBHAx9Ns2c4YTbQ
         t+N74neSsR7KVLgswYeBlNjfkqBEsFUMz9vlJt7wwi7OoNybUCn1isr75V1UaW7LKZ+3
         9UWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717190384; x=1717795184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckX290zz5uu8jKssyQCBCI0FA48FwJ1fiAxtXMtJpto=;
        b=dztg9AkTSNUveBXBqNfoNqiKqjdY7LeSlD/jUkQeRkVMAF9i/mKKqKQSn1MWPQq8Gh
         xyyapHx4If60cssmnJdf7QspgMl5+LXPjlabknALjG/M/lO07htd09y4qL67iZQlVpka
         QVQZ1wBkDiGqix/YnLlw7Y632zPIEoZkxaAJJqJTO9qPRBNPmrv9IuYXDShphTZiaHoO
         FhacRYNXmdRDIsZ+JlmbmPt3NmU9NGn5dXD8CJfxQ4VkVxcNabsx2iypCaiTqDbmGFdS
         IplCZ3IyRr032mhOQmcY8oLwzS5kDI1KW1rHdUkWi9S9SkVg+XBSFlXbnUsovcdpzqoa
         keiA==
X-Forwarded-Encrypted: i=1; AJvYcCWvbhiSDJck+DhVpF6LbU8zlus0BeFwDiPEQxIShVYtA/TsxnxY8FbTwEmUUpy0TNFTFXrHVBFIsCEWT1PkvXyOU/pdHgZbAHmX
X-Gm-Message-State: AOJu0YwBxxiMEH9DTfszp1tfU6IoLUKIIk7Pb8LX6+bBEGV+gfhGqVfN
	lbYgYOE238KVkQeh3fvENRTK+WSYsa/vlgrwqZc7R8PoDiF9IZN+S/xxvKxpW0o=
X-Google-Smtp-Source: AGHT+IEau7lS2dPKfMn6MIumlMT/ZA8JQPuE5qugKldj0LRxpSaUAlV7RFTk4iq5sKbMb8HEHld1VA==
X-Received: by 2002:a9d:6548:0:b0:6f0:cf72:5d80 with SMTP id 46e09a7af769-6f911f9fa84mr2949949a34.30.1717190384232;
        Fri, 31 May 2024 14:19:44 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91054f6c5sm470176a34.38.2024.05.31.14.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 14:19:43 -0700 (PDT)
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
Subject: [PATCH 1/5] iio: adc: ad7192: use devm_regulator_get_enable_read_voltage
Date: Fri, 31 May 2024 16:19:32 -0500
Message-ID: <20240531-iio-adc-ref-supply-refactor-v1-1-4b313c0615ad@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
References: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
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

Error messages have changed slightly since there are now fewer places
where we print an error. The rest of the logic of selecting which
supply to use as the reference voltage remains the same.

Also 1000 is replaced by MILLI in a few places for consistency.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7192.c | 98 +++++++++++++++++-------------------------------
 1 file changed, 35 insertions(+), 63 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 0789121236d6..e08bf066b3f6 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -200,8 +200,6 @@ struct ad7192_chip_info {
 
 struct ad7192_state {
 	const struct ad7192_chip_info	*chip_info;
-	struct regulator		*avdd;
-	struct regulator		*vref;
 	struct clk			*mclk;
 	u16				int_vref_mv;
 	u32				aincom_mv;
@@ -1189,17 +1187,11 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 	},
 };
 
-static void ad7192_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int ad7192_probe(struct spi_device *spi)
 {
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
-	struct regulator *aincom;
-	int ret;
+	int ret, avdd_mv;
 
 	if (!spi->irq) {
 		dev_err(&spi->dev, "no IRQ?\n");
@@ -1219,74 +1211,54 @@ static int ad7192_probe(struct spi_device *spi)
 	 * Newer firmware should provide a zero volt fixed supply if wired to
 	 * ground.
 	 */
-	aincom = devm_regulator_get_optional(&spi->dev, "aincom");
-	if (IS_ERR(aincom)) {
-		if (PTR_ERR(aincom) != -ENODEV)
-			return dev_err_probe(&spi->dev, PTR_ERR(aincom),
-					     "Failed to get AINCOM supply\n");
-
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "aincom");
+	if (ret == -ENODEV)
 		st->aincom_mv = 0;
-	} else {
-		ret = regulator_enable(aincom);
-		if (ret)
-			return dev_err_probe(&spi->dev, ret,
-					     "Failed to enable specified AINCOM supply\n");
+	else if (ret < 0)
+		return dev_err_probe(&spi->dev, ret, "Failed to get AINCOM voltage\n");
+	else
+		st->aincom_mv = ret / MILLI;
 
-		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, aincom);
+	/* AVDD can optionally be used as reference voltage */
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "avdd");
+	if (ret == -EINVAL) {
+		/*
+		 * We get -EINVAL if avdd is a supply with unknown voltage. We
+		 * still need to enable it since it is also a power supply.
+		 */
+		ret = devm_regulator_get_enable(&spi->dev, "avdd");
 		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(aincom);
-		if (ret < 0)
 			return dev_err_probe(&spi->dev, ret,
-					     "Device tree error, AINCOM voltage undefined\n");
-		st->aincom_mv = ret / MILLI;
-	}
+					     "Failed to enable AVDD supply\n");
 
-	st->avdd = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(st->avdd))
-		return PTR_ERR(st->avdd);
-
-	ret = regulator_enable(st->avdd);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
-		return ret;
+		avdd_mv = 0;
+	} else if (ret < 0) {
+		return dev_err_probe(&spi->dev, ret, "Failed to get AVDD voltage\n");
+	} else {
+		avdd_mv = ret / MILLI;
 	}
 
-	ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->avdd);
-	if (ret)
-		return ret;
 
 	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
 	if (ret)
 		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVdd supply\n");
 
-	st->vref = devm_regulator_get_optional(&spi->dev, "vref");
-	if (IS_ERR(st->vref)) {
-		if (PTR_ERR(st->vref) != -ENODEV)
-			return PTR_ERR(st->vref);
-
-		ret = regulator_get_voltage(st->avdd);
-		if (ret < 0)
-			return dev_err_probe(&spi->dev, ret,
-					     "Device tree error, AVdd voltage undefined\n");
+	/*
+	 * This is either REFIN1 or REFIN2 depending on adi,refin2-pins-enable.
+	 * If this supply is not present, fall back to AVDD as reference.
+	 */
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret == -ENODEV) {
+		if (avdd_mv == 0)
+			return dev_err_probe(&spi->dev, -ENODEV,
+					     "No reference voltage available\n");
+
+		st->int_vref_mv = avdd_mv;
+	} else if (ret < 0) {
+		return ret;
 	} else {
-		ret = regulator_enable(st->vref);
-		if (ret) {
-			dev_err(&spi->dev, "Failed to enable specified Vref supply\n");
-			return ret;
-		}
-
-		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->vref);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->vref);
-		if (ret < 0)
-			return dev_err_probe(&spi->dev, ret,
-					     "Device tree error, Vref voltage undefined\n");
+		st->int_vref_mv = ret / MILLI;
 	}
-	st->int_vref_mv = ret / 1000;
 
 	st->chip_info = spi_get_device_match_data(spi);
 	indio_dev->name = st->chip_info->name;

-- 
2.45.1


