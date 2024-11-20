Return-Path: <linux-iio+bounces-12440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880BD9D4391
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 22:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE98283938
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 21:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0291CB50B;
	Wed, 20 Nov 2024 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eWdCakaS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A61CB328
	for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138457; cv=none; b=C1OXQomc4xLBqli5XZ2L1Q3FU6WfG238azmaHHJP1cxn7zq82OZPhW8yj+DF+Zm8quViMYM9lUlMWh/0TpggfFD/lPLrhKvjndgH9bek9giITbhR8QIQp2Parbh7JcBNA/TV6dUJPrw0Mred3nIZOKlEEG+r9adeSdLpc5/Ttag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138457; c=relaxed/simple;
	bh=p+nS5eNSFSea7wrSjxxVMVpqrYPjYIH7CARSb8ahoso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YLqLkPMie3ZgwmDTJF4y7zuOncfDpP97zie6pHK38F8CPWlnFcKn2/OcvDlEE0n7UwmX9Lkdqy8m5OLgC4w3NJflTk2MLCCTNrX0EnGLE8ZaSuCQyRz3r+EHbLDySUBEuD8/L82iY9s2Wl1Qrh9TEYBPN2CPwADsx5WAzBNqUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eWdCakaS; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ebc0e13d25so108637eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 13:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138455; x=1732743255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iu7aDJGbDBdHDN9nX/nWmhMIbwEvqk3RBRXOi7f/0Bs=;
        b=eWdCakaS1yWEa5IIT34PgY74OenRfeKe7SngSBN+gJZGVnplvScAZ/YtU2GcygfrP7
         75AitbXoNAEZ7mgrzy9+XuQDoocSLYs6s8wWEmIWAIrLGfcw62x9ylZTvZJ4Vgx/5ATz
         TSH7a6DG9SgNnIIL0za2EbIZmt0wVNdis6zTGz1fqPzYETcDjAGyRKLrl0RwnTrl1YOl
         dNBoDqZFemnek89qCiEsDRje/kWKcK5ERg+7xDLkq1++7IA96AnBlitDJk+Lgaz2/Tw+
         TL+VudG+xWeI64sOouOyv5ff7cFxBHyLg1tBX/tg28qAodkgzI7djI2+z4PnDRT+MU7y
         7GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138455; x=1732743255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iu7aDJGbDBdHDN9nX/nWmhMIbwEvqk3RBRXOi7f/0Bs=;
        b=UH7IrEbNDKhzzN7AF0iEUn8Lu52eEGCscgZqdBlkv+bHBECoxzU4lDMXH4cVKxriV6
         mervB77oUuLMlDS+SlX6hveIEwxiYZ4eD59TT8qnSFKXKmUvUOykTC/sLzhj688WpY4s
         YWl/kizeGdHorPnGFEwYkZ4SMf0u5F12N2lmN7Idq1pliyhnrmB1/dNbsrn55OJa+Olz
         2i7ecNbD0Y4076p48HDjp+zbTvKVvEeVNVYQorJF1/5mYgYKEVbxUJe3h1OvYI7fgJ53
         8i19x5pK9qLrduRpWk3SoNatumFGwKFNupi0s74gHmwbvFik3MHwDLKZ/V43xU+Cu3Im
         +pNg==
X-Forwarded-Encrypted: i=1; AJvYcCXi7Lb0WpuPXGuDiSLM9rLSs1dHyR9+fVmxv1P3w4J7c0sn16ZxlwWNTpViadaZYqF7T0EjMq1MpC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEmQs46qB4ugUV7mkT+zrjQ8p1rhuWKNAyxE6fSkAKLbFzucQ2
	R3AN/PUrEPNt1bKsSRJbl9HJ6c5PR8NX1smmuRRHbIJ+93aCQUx0VeIyjC72dIQ=
X-Google-Smtp-Source: AGHT+IHXx6o3MNspetZNr4gTo1mEHeioI28P55Eo6Nd/3JODlVCwxdabASABo8ThWmfyi+yvZviiTw==
X-Received: by 2002:a05:6871:4b12:b0:295:d711:f12d with SMTP id 586e51a60fabf-296d9ae33ecmr3788154fac.15.1732138455002;
        Wed, 20 Nov 2024 13:34:15 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:34:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 20 Nov 2024 15:33:33 -0600
Subject: [PATCH 10/11] iio: dac: ltc2688: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-10-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using devm_regulator_get_enable_read_voltage().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ltc2688.c | 44 ++++++++++----------------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index 376dca163c91..bdc857c7fa6d 100644
--- a/drivers/iio/dac/ltc2688.c
+++ b/drivers/iio/dac/ltc2688.c
@@ -842,7 +842,7 @@ static int ltc2688_channel_config(struct ltc2688_state *st)
 	return 0;
 }
 
-static int ltc2688_setup(struct ltc2688_state *st, struct regulator *vref)
+static int ltc2688_setup(struct ltc2688_state *st, bool has_external_vref)
 {
 	struct device *dev = &st->spi->dev;
 	struct gpio_desc *gpio;
@@ -881,18 +881,13 @@ static int ltc2688_setup(struct ltc2688_state *st, struct regulator *vref)
 	if (ret)
 		return ret;
 
-	if (!vref)
+	if (!has_external_vref)
 		return 0;
 
 	return regmap_set_bits(st->regmap, LTC2688_CMD_CONFIG,
 			       LTC2688_CONFIG_EXT_REF);
 }
 
-static void ltc2688_disable_regulator(void *regulator)
-{
-	regulator_disable(regulator);
-}
-
 static bool ltc2688_reg_readable(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -947,8 +942,8 @@ static int ltc2688_probe(struct spi_device *spi)
 	static const char * const regulators[] = { "vcc", "iovcc" };
 	struct ltc2688_state *st;
 	struct iio_dev *indio_dev;
-	struct regulator *vref_reg;
 	struct device *dev = &spi->dev;
+	bool has_external_vref;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -973,34 +968,15 @@ static int ltc2688_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
 
-	vref_reg = devm_regulator_get_optional(dev, "vref");
-	if (IS_ERR(vref_reg)) {
-		if (PTR_ERR(vref_reg) != -ENODEV)
-			return dev_err_probe(dev, PTR_ERR(vref_reg),
-					     "Failed to get vref regulator");
-
-		vref_reg = NULL;
-		/* internal reference */
-		st->vref = 4096;
-	} else {
-		ret = regulator_enable(vref_reg);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to enable vref regulators\n");
-
-		ret = devm_add_action_or_reset(dev, ltc2688_disable_regulator,
-					       vref_reg);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(vref_reg);
-		if (ret < 0)
-			return dev_err_probe(dev, ret, "Failed to get vref\n");
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret,
+				     "Failed to get vref regulator voltage\n");
 
-		st->vref = ret / 1000;
-	}
+	has_external_vref = ret != -ENODEV;
+	st->vref = has_external_vref ? ret / 1000 : 0;
 
-	ret = ltc2688_setup(st, vref_reg);
+	ret = ltc2688_setup(st, has_external_vref);
 	if (ret)
 		return ret;
 

-- 
2.43.0


