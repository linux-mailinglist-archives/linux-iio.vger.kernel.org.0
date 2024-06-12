Return-Path: <linux-iio+bounces-6224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B75905D63
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 23:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58FC1C20E4A
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 21:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F00F1272A7;
	Wed, 12 Jun 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ODTpRE24"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0842B126F02
	for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226202; cv=none; b=NNlrZPc/oAFkl0Yfh+EBW9NOCK8XrLFte+fTcVDMDIgiRT1Mi1mpXEOHKeKwVe/x15MfptyjjL5TDa/UM6v6Tm3zyUOoDQbaquoSJHizEjBi0lHFWC7d2fdN5QVOxLrwfEU5lsoFq4rstWBLUPMqZxX7SfGQpjlqQ+HtTt2Q5JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226202; c=relaxed/simple;
	bh=vc0wQLAQuMRAyELjvGU21hVTnrdkk+B+80Fp46TOhLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NinVmGVdagqPgoD3LB8sZON8s6upUuAiS7/dVMyxCyJAd0PdLvtBLZYwYBObb6dfQM8qSbcmV6hn+g0sEbXESGLOwE2cdGxjV0BxqqudC3805/90njL0OS9kzHt6p0Gkhjx5Xb7AGMMhEshZ9KW7ySioqt8mchw4dDdiVE6sg/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ODTpRE24; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d227b1f4f0so111565b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 14:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718226200; x=1718831000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6phvgA6PKlI7Rsgp8QhIcT0Puar9wQt5/4QK7wk+xs=;
        b=ODTpRE24Yyq7TCx0ziq4zsUDnttyP4NQNmw6qjMDHu6Gmh+qcCpm3qpqCGyH4SLVcK
         XkRA9BnBLPzKg5Wrd5zAmyk1FqpXojUNqhEZgMNpXciNaofqqnXOTVc0nVW9lruKEs/k
         COQQxBMfNPcvSwbkchtOY8eMhTh+rSh/8pi/sfk7IA7ZTW8NLX6HnU2aaXmSfWY2z1/5
         X/VYr0JvOekKb9MsFyJZu9Qo6gQsn/UURE48nwIXQuHLDb2FJWCxz1VZddvd7jHYJilo
         p6yIEQ4QLYeBxswV9FPTT1f7NFzm0RF8WdprLKvbAXdaOid34/pDmm/rcjlV6tfE0od9
         Ju6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718226200; x=1718831000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6phvgA6PKlI7Rsgp8QhIcT0Puar9wQt5/4QK7wk+xs=;
        b=Q+ZRktn/x/hybzGAN/YguxS1z8qvbbOugCGSg2RIZb8XDXcGE9KDE4lro75im+DGT2
         Ta/Xvw60eWfIbsk63F7CwE7VHuN9zmOdF/hsF9Hor6UKjKrNDdVtn3CzuWR8CU1sQWH9
         9jSuaMCN8rXH2eybOC1cd02z4Vabf3x+bFv6wfPplI+MTOPOq2NJ48Gs8ny2gM+QwwfJ
         o0NfnQgcwmhDhzMmyXtynyL2IOACfxN13uRKfEAfcIWaCs9fCd3qZFif6x2tfmp53K3c
         O7NM1Z0liPeTXt+3lWRlyFyOzR/SHRy9p1BFmZWXgpg+RQKI9Gyb3QLh89xUv1FaUNzp
         At4g==
X-Forwarded-Encrypted: i=1; AJvYcCVQPJOwp1TZq0dFoMW52cxhDa06k8DJlRuK/KqNVBahgGUIKRACQZaHFTHtBpQLjAcuLjARVIYxC531MNLKKj7F7OjNf4KsG+c/
X-Gm-Message-State: AOJu0Yx6Wt4mrdqt+6mqcFWisQ4hqHfih9Iw6TEIODl8/8yORT4CcFQ/
	YPUaHTpctHlwmJqnJv/FlhTOh3OxQjFfr2CmPHnE3+PhCXzAxIO/LJISd0KfzNo=
X-Google-Smtp-Source: AGHT+IEnh8HX9zJsqhJ8nU/HGtmIfcg8BsqljTsGbB9Qo4c5ZfFEkouPBvBHLlNZasDRiQIrBh4oDg==
X-Received: by 2002:a05:6808:2288:b0:3d2:2334:67e5 with SMTP id 5614622812f47-3d23dfd9dd9mr3384141b6e.4.1718226200044;
        Wed, 12 Jun 2024 14:03:20 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d20b68f5a1sm2433368b6e.23.2024.06.12.14.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 14:03:19 -0700 (PDT)
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
Subject: [PATCH v2 1/5] iio: adc: ad7192: use devm_regulator_get_enable_read_voltage
Date: Wed, 12 Jun 2024 16:03:05 -0500
Message-ID: <20240612-iio-adc-ref-supply-refactor-v2-1-fa622e7354e9@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
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

v2 changes:
- avoid using else on return value check of "aincom" regulator
- also fall back to dummy regulator on "avdd" in case of ENODEV
---
 drivers/iio/adc/ad7192.c | 100 +++++++++++++++++------------------------------
 1 file changed, 35 insertions(+), 65 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 0789121236d6..409c73d16460 100644
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
@@ -1219,74 +1211,52 @@ static int ad7192_probe(struct spi_device *spi)
 	 * Newer firmware should provide a zero volt fixed supply if wired to
 	 * ground.
 	 */
-	aincom = devm_regulator_get_optional(&spi->dev, "aincom");
-	if (IS_ERR(aincom)) {
-		if (PTR_ERR(aincom) != -ENODEV)
-			return dev_err_probe(&spi->dev, PTR_ERR(aincom),
-					     "Failed to get AINCOM supply\n");
-
-		st->aincom_mv = 0;
-	} else {
-		ret = regulator_enable(aincom);
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "aincom");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret, "Failed to get AINCOM voltage\n");
+
+	st->aincom_mv = ret == -ENODEV ? 0 : ret / MILLI;
+
+	/* AVDD can optionally be used as reference voltage */
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "avdd");
+	if (ret == -ENODEV || ret == -EINVAL) {
+		/*
+		 * We get -EINVAL if avdd is a supply with unknown voltage. We
+		 * still need to enable it since it is also a power supply.
+		 */
+		ret = devm_regulator_get_enable(&spi->dev, "avdd");
 		if (ret)
 			return dev_err_probe(&spi->dev, ret,
-					     "Failed to enable specified AINCOM supply\n");
+					     "Failed to enable AVDD supply\n");
 
-		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, aincom);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(aincom);
-		if (ret < 0)
-			return dev_err_probe(&spi->dev, ret,
-					     "Device tree error, AINCOM voltage undefined\n");
-		st->aincom_mv = ret / MILLI;
+		avdd_mv = 0;
+	} else if (ret < 0) {
+		return dev_err_probe(&spi->dev, ret, "Failed to get AVDD voltage\n");
+	} else {
+		avdd_mv = ret / MILLI;
 	}
 
-	st->avdd = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(st->avdd))
-		return PTR_ERR(st->avdd);
-
-	ret = regulator_enable(st->avdd);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
-		return ret;
-	}
-
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
2.45.2


