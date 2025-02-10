Return-Path: <linux-iio+bounces-15302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2140A2FD3E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 23:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED07168AF3
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 22:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84845254AEB;
	Mon, 10 Feb 2025 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UtsC4PU2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E478725334B
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227056; cv=none; b=fuXRFJjNkdfIMGsApHosiNPMhc+NA0nTbJAemeraR6LSJs4qw8LMyq7Lf34OQGrkiEJMGTGrzhoit+GaJzkm6ELOi+OVZSZ2+D33HgKhxs2TXdOF+2phqIW6BU9VA7ooTyPtVIHCe9Mkgongo9tQ0u9g+/o7d7hg4Myw1l9RdY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227056; c=relaxed/simple;
	bh=N0Em4RkHQUvBxoy2r74GZrWjDlivg7oqNPXmv4at8dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bXiBJEmaFPAx/S7AvslEV8+8ij7jU/YChfdZFGASAzuFESFdIcLfCdq0890zKNP24OlNIKWfcb2MLMwWu12qFx7vjgaCRLVqPDeNyzqQHVUqQY4KalGK8lAIC07XwEPLI3jR+XvbSWImkvmw5XtFycyzM+WLdoQ7r7LhNCx0/ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UtsC4PU2; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f3a97b3e26so1138336b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 14:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739227053; x=1739831853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BdRdts91zZ1lBz7cZl7Oig3MKNc6jPxib3EI6sYvCw=;
        b=UtsC4PU2jEf6Iigi4rlnw6wcpWHJPn9dN1Y/ssJiTHPQO/CZtNRpsBzMfDZlyt/we0
         RHuvVN+hHYkiWa+JZ9v2hwWgZBkL9x+SieJHP5Ac/9ymC+T0V6fuZ9mDkfZyOmRAwJne
         uPbi8Z4raeikVNmyPxq48ndMS9AY4DnshSuYZQXcVYZAxWB6CLw/5yRRn7eHlEkcFFnI
         cWRNaWQ/SNXQXB/fEk3gZ3NBilf2Ay0p8Z3tmcIGDHXh9atrJO+I7wOKX6b+rD/P9Tw9
         bum8f285kxDjh+R4nDlD/oxghHe+83NmYNGeeyjmHMDgAXUxM9+gyp49TVcNafo13Xw1
         0qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739227053; x=1739831853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BdRdts91zZ1lBz7cZl7Oig3MKNc6jPxib3EI6sYvCw=;
        b=d4lHNO6Hi/lY6m/1ANVsNl+IjmrKWjeL474EXN3W9ZsxhLmBtR8QrVfkaU5U7bctJz
         UBZXbNglNvw/hauAWF2i5Hn1u8d4yKBVzYnNLG8XzrgWm8GRGeyxeBRlF2b74gmPE7tl
         JV2lK7QBHsWNKOj2/SYOfvBQTYnbShiY8NGJFdt39zrSET/vrb2lI12KrZL0IHJUum+M
         QzB/RCs+FNlv51Km++bW2LMvnEliOLpY2+ow+zzoEqF7W0egxJUHdUM3BilaGn2KfJcN
         964fZPM79Aw49BVvqz+uUv1voHxo/DHgB3/0Mpj8+x0D72cBeAT0nlmO+Tv5OlHfpoHh
         g1vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnFX8WUInfcfxS+ISxoKGeC1GH7YyHrLBIgrPg7EQ/mRPI+FM2cBcphnGLIC8VuhTu7Uo43u0EGBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxArasSP2WxhjV4fazi5xLoAAbfGXTt4jMiEgUA9MgC9SItmQfe
	IG6EpYJGDlPClf1+ZUhhEkjrQhxyGXshr/wBGsV29WuTOym6MiwzdgE2l0I1IgE=
X-Gm-Gg: ASbGnctHKVJjhWWHHnJcaQ8X5c9vL/vlQm5qcKnt8DZT2RZlfmyBGxmgRi7dI16Ws/6
	DLPci1u5VKsufU1d1Nve814ccdM7nLT40xUcxJiBOIfoCiEj6ld8XwV+uGLq3PmrPP+FSWrSCpv
	ExZBmCufNzj9EVnJOp6ooPWgqvyXyNpouRJ6TtkFaVPfBhahlveARKD/v94p+LeiKR4uei30PI3
	k1ltCbU5YpGg2TUUEQniatsSijJ3uylnlaZgQ/f/JjASF+z2Qh/0eD+VvNOAcAPME0denHW2Day
	vUgsgbd/5a7wQzCr7W6TtGS1NY/Mn16oEbDbT2LrnuUzuO8=
X-Google-Smtp-Source: AGHT+IHsM3QlE/6UGVvIOu1IlhPnETs+gBtT/fIeOJD2BqtDOh052hlxzN8ugWj1HusAxyIKgoI2uA==
X-Received: by 2002:a05:6808:1590:b0:3f3:b8c5:4ff9 with SMTP id 5614622812f47-3f3b8c55799mr3309849b6e.28.1739227052973;
        Mon, 10 Feb 2025 14:37:32 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed1ca2sm2521820b6e.11.2025.02.10.14.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:37:31 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Feb 2025 16:33:27 -0600
Subject: [PATCH v3 01/15] gpiolib: add gpiod_multi_set_value_cansleep()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-gpio-set-array-helper-v3-1-d6a673674da8@baylibre.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
In-Reply-To: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
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

Add a new gpiod_multi_set_value_cansleep() helper function with fewer
parameters than gpiod_set_array_value_cansleep().

Calling gpiod_set_array_value_cansleep() can get quite verbose. In many
cases, the first arguments all come from the same struct gpio_descs, so
having a separate function where we can just pass that cuts down on the
boilerplate.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

FYI, I dropped Linus' Reviewed-by: tag since adding the IS_ERR_OR_NULL()
check isn't exactly trivial.
---
 include/linux/gpio/consumer.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index db2dfbae8edbd12059826183b1c0f73c7a58ff40..5cbd4afd78625367a761e224acc3f7336d310dd0 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -3,6 +3,7 @@
 #define __LINUX_GPIO_CONSUMER_H
 
 #include <linux/bits.h>
+#include <linux/err.h>
 #include <linux/types.h>
 
 struct acpi_device;
@@ -655,4 +656,14 @@ static inline void gpiod_unexport(struct gpio_desc *desc)
 
 #endif /* CONFIG_GPIOLIB && CONFIG_GPIO_SYSFS */
 
+static inline int gpiod_multi_set_value_cansleep(struct gpio_descs *descs,
+						 unsigned long *value_bitmap)
+{
+	if (IS_ERR_OR_NULL(descs))
+		return PTR_ERR_OR_ZERO(descs);
+
+	return gpiod_set_array_value_cansleep(descs->ndescs, descs->desc,
+					      descs->info, value_bitmap);
+}
+
 #endif

-- 
2.43.0


