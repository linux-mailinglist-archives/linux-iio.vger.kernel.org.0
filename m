Return-Path: <linux-iio+bounces-15092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC49DA2B5A0
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 23:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65A03A780B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 22:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD489239083;
	Thu,  6 Feb 2025 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aNwOUcLy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE223908B
	for <linux-iio@vger.kernel.org>; Thu,  6 Feb 2025 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882111; cv=none; b=XhDqpUbcx0ylL5wkIGM6WDJFCJL49fzVUWxmM8yTSEmR4jnC5YC5GxzGbNGlFvkYgX0mv2eOgH3ecWGbaHOKkYZZiXr37WjrSw9LDfUakoeeFgWrxn8ata1B+bujn5Bd5ei8PpVWkwqkd+UTGbToLu4+HZxrKWxWzmCHw+utW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882111; c=relaxed/simple;
	bh=0MHJjqUwgl86scGzhwXQmZbiZ1mEDsd1fWdD2VX9p+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVM/LPsQ0SVB6HpXBcXf1ickfWyl9jveSNiC+I9+mVwGXlRZFr+HOGqKlkIwSs1JPMTk5I1lu0dH1tv6pXSBuaDmUn3kMItU7/Ty/yaK0gTbF3cMe9SuYj4I4T8px1WtLyP1aIdh03cZK7RA/J46giFCsuOR1a3ts5D8pvvaw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aNwOUcLy; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2b83078ed33so450383fac.2
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2025 14:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738882108; x=1739486908; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1G+5KuhaA9Y/JWZMuBnNAEnz6cO9OcsXFwLiAeC3p1s=;
        b=aNwOUcLyH2Qi14xgvm61ESdvsbtDTjPEmqKUa5ANJYhgh5jcK27hZ4nIbcw0ajkcXI
         jJ5kQ2WZSdkyQwauR6oOgTNxrU7mfHhdSV4DzchNywzPlbQE2JCNKHacaiygpdNqQrcD
         mcPWSHElpji2WpGlhyRzuIHWhstDyv+8DFSk1FH7zC3jWYNMtBNPrQfhnqybFG7AHxpB
         oEjRzot3lwcHYVKGZxw0MftmUNR+4cKkDAix9D5zWtnTY23O70GUA8+tR6t/fFywUzYR
         6wB9F8GINjxdkPYqTfCMqSBCu4TxIuiAB2ksAJ96ZRDFoRRarV0N36sNe2AyatBrIh5t
         airQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738882108; x=1739486908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1G+5KuhaA9Y/JWZMuBnNAEnz6cO9OcsXFwLiAeC3p1s=;
        b=bQt4L5/SlbeyVDRrV3leH8oRTDgV8wSmQ1xgRoBa1GM2Z15rBLutJhr0g+0OmJrsBv
         pjT1gOlnPI9ygc8hOzeGDB5bVqa4hvjTwNXmz4f+P2CbtHB8BUQZTw7vMvsGLEuExhLl
         UKhE2SjuUFT6koJt1I6GxJcQ1pbgMvaoRV/2CwNwk3ieNOia8Z4czY+GEtYu9bAcOdEu
         MHPCeeTPrnz8UaZKpbjXYjxTB81FGT1Ffw2j2TojE1QLvZDAPkq65PTBKEYDQ9h/lgdf
         lBa9M3ByXuZXlpqlwk3oO/N0meMdEJq9+rU8a0PRQTUPKLj4hQIELoEMI5NgJJtOldhB
         aneg==
X-Forwarded-Encrypted: i=1; AJvYcCX7acVAYtGc1edJxOtY8CksMT7t5tflhax6qQbMG8qE0qw/bclqycEhY4Nmh4TUxlCmBobhEMhm5lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8s/k60m5ezxeyZVf8VC21yVsMEZWqw+1B+XBaL+wgRHOmykc2
	wBsO+ONjJ1Dv8B4dYN9M/8aprikt+zZ5QNltn1e2FygV00o9wvZ8GBFHKw1houE=
X-Gm-Gg: ASbGncuNx5CRHJKx07AEX2XMVkZCPpfuJCXBQ4BEp0JvkZIYSjEZTJyuocwxP1XqNdf
	6h21r/Q9p1bqSTYQ2ubMQy59SvJGJh/nK8E/4WspRRPXV/6khrEVzRmSBQ+NpRvGYMnEop8JCFa
	PaMwDPrLyDk4cO+q67pFg6pNa64B0Hg5ymCn/NqpeonpVQ7tOP59LSAclpGfDSlFKytFlg33NqI
	A/0SHv9ig3zvPcbsvuw+RjvvuE3RCS1mVR/vO/QDelf00q04H9v2arFF1rLGDIq0Gp2zriP7q9A
	gvKFqYdM6Dg0iHIF/8C/0HICjLuvpcEXajN/LmqgE8FI0+4=
X-Google-Smtp-Source: AGHT+IHhS6xIbsoZ9Y9JyXWh4zSyrZ2jgd8SnPiV9tauY6RFNa0jyaYnEj0rYnfG1jHSP16xj2DPIg==
X-Received: by 2002:a05:6871:70e:b0:29f:b7f1:d844 with SMTP id 586e51a60fabf-2b83eb6727cmr752453fac.2.1738882108087;
        Thu, 06 Feb 2025 14:48:28 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af95bbb5sm510986a34.41.2025.02.06.14.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:48:27 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Feb 2025 16:48:19 -0600
Subject: [PATCH v2 05/13] gpio: max3191x: use
 gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-gpio-set-array-helper-v2-5-1c5f048f79c3@baylibre.com>
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
In-Reply-To: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
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

Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
gpiod_set_array_value_cansleep().

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/gpio/gpio-max3191x.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-max3191x.c b/drivers/gpio/gpio-max3191x.c
index bbacc714632b70e672a3d8494636fbc40dfea8ec..36ca07be3e1811fd3f0b27f41bfd307de50ec5b4 100644
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
+	gpiod_multi_set_value_cansleep(descs, values);
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


