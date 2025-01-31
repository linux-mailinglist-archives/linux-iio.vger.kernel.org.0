Return-Path: <linux-iio+bounces-14783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DFFA243E2
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 21:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16E53A9297
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 20:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F123A1F55F9;
	Fri, 31 Jan 2025 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g6MnSnqm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E7B1F540E
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355101; cv=none; b=bmTDLRDgcZGNY1j71/JsZH1kopZXNH0/o0gJzBFsQiw1MRP2GH1zJWFktQsEK2ITkYcsBA0ujhQNmlrUdJCFxijCPx+2KejDCA6ZYB/MUO/UhGQaU1C0vuX3Yuje9URHtMCrBxa+tGaVCSm2tuozy9HvO+mU46zMUHYUUlJQadc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355101; c=relaxed/simple;
	bh=Y984jgguFlZIBOThWuuUJpuuUbC3lQREEzsrrqDNozE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXjRIWSdwHWvRUmByrjuQBc7SUfAtKyHGqmganbUaxg/7sJm1t+LHPZECjuB4m4F36vUOIc7zn6w7F5dyurMUZUTlmh65OLrEBeLc+7/URHZDHW9E3+Sgu7cxds60CvPppCi7FxhuMbvAJZVilNg6710nFU5MGIq1aGIKCVsDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g6MnSnqm; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5f2d7868ef0so642631eaf.3
        for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 12:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738355099; x=1738959899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0JxocTLtlGRqW6c379kuZnM3hX6Je635Dhf0CbFSJY=;
        b=g6MnSnqmPtos+/Hg7bCHWyJKjyq+TDTZqQp7OZrONvvlcKC/VYH7QgztlisRLGBmdQ
         jghEuXFMKrOniW4QAFgqAQCOipaZgdbpuJ2O4hEfYH6TL1LPD66bsT8BBIUmC5cK5oXY
         a3WzaqU9TOr9tJbZlFvfxYd28mIK3gM++T93/iSK0iFNb/wyxXP5FCzwszwhwIwkWzPF
         Cf7b4jyXBl9ahw4wJ+Dwp0erV/pFzP6ulzDkKc2WOMQkoWqUs0lv6OwYa4WGFYdXzh04
         EW1bOG18E7VCvYDsAEcFi3H4hFINROcY5yuREBrnlO8RR+FZ0ZCadWx38i+EYlzpnau/
         dkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355099; x=1738959899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0JxocTLtlGRqW6c379kuZnM3hX6Je635Dhf0CbFSJY=;
        b=cLFVaNgBjvlXLsx29apkDeTay6ftdjsRKoNmSXvTNw4gqcI1CbrrGi7VTQCBFxl4Ej
         jcycVcVGccIETI1WomyDbOvRDnGxTpkQOUoLZDHL/kDX+SsYKbbA8kEz3OBZsMg4W5qg
         fLNfpNe38VqEH2v1hRp7iK2o5hps26wp3o745gn9Jfm4ddTfv2ni/Xk1/rU9jGkj7UI7
         md51WItgSg28S4Dy0qz0zvNyjy0MBKS0eKqtG5B2zMl3zSgg2SI8UMcW3npX1pHXw/Ke
         z2YH0biazL9RfuTi+o4DERTR8bx5DclnOmGo9yhzRqEUdw7edxweWoQx4sS1dsfb/wiF
         nrDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXW3rSX6GYslT5GAm/XLGS3cY1XgfUQOfyf6FVVEhEBAVBHVZwngXdyWbDo1sS10VL0BAizxMZB1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtwIVuMKyUCCixgYAZd2guEMYeyJGsW9tgMfrUozt6l4/2BMWS
	B6RlAWlsuBZuovzk8n1VnIintUu3vbszh5Coa3PZO2IYu5luT9lFaBdsNbWdjuM=
X-Gm-Gg: ASbGncv/vyR0Xe1xIB2afAwtJqjKrkbcRKG7PafwWIy1SZZjmv9zJbz0IE6vLjt8bfG
	f8/k2Hrov0wdbzjO4YGFLlH3pqnKOpjYhCOAxoJ8Rqc3atD9oKeSUQodq2hA0ADf+F1pUezPRsQ
	4LaHzaxeXo2n1YFNqhSEZqGdKIGpL2hKg0wN2gxSvKAyvNhaCO/hYNn/XCVImLDf4668xJXWkyQ
	V/mk5YeYtjmQjY4Gh6xkzxKEBpsSHGVapovqmCIjGfuzfeU801wdwX20N5ckbiugBKrP3WLNwC9
	tRiSpbXBAnOcj5QEyvee2SbNPgVIxVQ61Ead28VYn0UUGkg=
X-Google-Smtp-Source: AGHT+IHLLvw8v92D1IAdlvToO2DW44SjM8+FGXyX2n6gPI7BbY77buvq2CWQaGC5P0PVhdqadGjO1Q==
X-Received: by 2002:a05:6870:948e:b0:296:beb3:aa40 with SMTP id 586e51a60fabf-2b32f350834mr9144614fac.36.1738355098867;
        Fri, 31 Jan 2025 12:24:58 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b35623d2ffsm1403157fac.22.2025.01.31.12.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:24:57 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jan 2025 14:24:45 -0600
Subject: [PATCH 05/13] gpio: max3191x: use gpiods_set_array_value_cansleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-gpio-set-array-helper-v1-5-991c8ccb4d6e@baylibre.com>
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, 
 netdev@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-sound@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
gpiods_set_array_value_cansleep().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/gpio/gpio-max3191x.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-max3191x.c b/drivers/gpio/gpio-max3191x.c
index bbacc714632b70e672a3d8494636fbc40dfea8ec..fee8dd2bd3c9eb7c06817430634eaf905cc9cbd8 100644
--- a/drivers/gpio/gpio-max3191x.c
+++ b/drivers/gpio/gpio-max3191x.c
@@ -309,23 +309,21 @@ static int max3191x_set_config(struct gpio_chip *gpio, unsigned int offset,
 	return 0;
 }
 
-static void gpiod_set_array_single_value_cansleep(unsigned int ndescs,
-						  struct gpio_desc **desc,
-						  struct gpio_array *info,
+static void gpiod_set_array_single_value_cansleep(struct gpio_descs *descs,
 						  int value)
 {
 	unsigned long *values;
 
-	values = bitmap_alloc(ndescs, GFP_KERNEL);
+	values = bitmap_alloc(descs->ndescs, GFP_KERNEL);
 	if (!values)
 		return;
 
 	if (value)
-		bitmap_fill(values, ndescs);
+		bitmap_fill(values, descs->ndescs);
 	else
-		bitmap_zero(values, ndescs);
+		bitmap_zero(values, descs->ndescs);
 
-	gpiod_set_array_value_cansleep(ndescs, desc, info, values);
+	gpiods_set_array_value_cansleep(descs, values);
 	bitmap_free(values);
 }
 
@@ -396,10 +394,8 @@ static int max3191x_probe(struct spi_device *spi)
 	max3191x->mode = device_property_read_bool(dev, "maxim,modesel-8bit")
 				 ? STATUS_BYTE_DISABLED : STATUS_BYTE_ENABLED;
 	if (max3191x->modesel_pins)
-		gpiod_set_array_single_value_cansleep(
-				 max3191x->modesel_pins->ndescs,
-				 max3191x->modesel_pins->desc,
-				 max3191x->modesel_pins->info, max3191x->mode);
+		gpiod_set_array_single_value_cansleep(max3191x->modesel_pins,
+						      max3191x->mode);
 
 	max3191x->ignore_uv = device_property_read_bool(dev,
 						  "maxim,ignore-undervoltage");

-- 
2.43.0


