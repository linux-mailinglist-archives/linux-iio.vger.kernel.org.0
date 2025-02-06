Return-Path: <linux-iio+bounces-15095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03BFA2B5A7
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 23:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C8F163DAF
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 22:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6650123BFA2;
	Thu,  6 Feb 2025 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AnYjx7dv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766CF3DAC10
	for <linux-iio@vger.kernel.org>; Thu,  6 Feb 2025 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882114; cv=none; b=Q3ERa/Yb3ei8yhfxziz3pRXSuys9YUOzFOKus83N/qaejGc/VkJ+lAJ4ebJvYKyKgoiWqLcFz1evy3Wd0hj9lUODSW9vtEFxc2+9ZiG3DEAsQt7OOusNqzmu8macFOf/TgtvDVYphS1sXrd1Fld8gjtjcWKB69QFSUxHCPvlGDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882114; c=relaxed/simple;
	bh=IH4g1d8UAtzwg8g1uq4cmWqDVZbX87ChiYlpGpKjpcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zwrkm3y7YBFP+DER2iV9zf/zNm4rEBCNjHVqqvZazmE4VeeAewF2pvPLAwLBUX9Fe6V57gC2CZldyln6i2RaAkUqFP41pAeQeqQlh2eAqWr3u2gohX2e04xr2QoduQoINLPuuLFs9uPlzBX1kTV0rOPxa2mwRWYuT7Iqx6SjyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AnYjx7dv; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-724d1724657so1335009a34.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2025 14:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738882111; x=1739486911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wznyorGz9Vd3pJ7hNo9c2JQSgu4MoX0a4PWBg4SPl0=;
        b=AnYjx7dv/fHT+RaED0QPGTL31FjQ8sPhaC9j6rFbYMIqV1bhjP7GNgroxDh2xTM8qE
         X3quFZWilB3KMjn4EFADZF9L+JrUvA3mcmJ0AeJ2ODcxjMSjwix5XgGmu9ttLKsFOWdX
         KnEzRgKY/TYZbPgQhK9gsmaKhaFHixmME7pXAwcdbr7R/6fWRAyHSoZFeahw6OZtohqL
         wm47wd5LlVjIKn0kaq4Sy3PRn3FguH5BqbXEWuvUFu48GWxy1niWvSh6G78pDnZYl5e0
         D2/rKKaYEslnT5KZlOy0NdQAf+KtgZaqBuVg5lex0hkL3chwwd1hgWaNF2CBULDDY4EF
         mbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738882111; x=1739486911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wznyorGz9Vd3pJ7hNo9c2JQSgu4MoX0a4PWBg4SPl0=;
        b=Ks2WkxUtwDoxv2AbNlFFF50MRNqKmIruWQatjnYA9dVv54JHIj79MyLF9vP7VMqAh5
         r1RE74JT+HF0sEbQUmlruJE2p5jrDdRgF0pbixTwLJg8htVRAd5liEAJ14LPOJfKqkAF
         i3WZaabJl1vqWsztbQdbPjUNXToDzIUoPySDi7LXU3MGfinl+AsMWxILS6R6ZMHQDHnq
         s8bes34kUgpn/dBlStdukCOYwiJEacuUlzvWKk8v/oNzKwEbchDl17z8fuDMU1eqIDNX
         D0wUoqwInDbkqhjxzDBb03SPVPzHEq/H2HWEhtmsWhI4VdivZBOgp2C7kpyK0W7Tz07c
         DYLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPs7Qb0tOpAgKdXGElP8DV8dxwLE68KrKoDd39U7BaUuoP1mGdalnKg3YOXxTQpjTWXInYPD0MiqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxniUnDXeiB++83kaUxWMm4H3hj9T7UDLvq+WCi9QWYV0drsHj0
	UxT/F8X+LyJaN4xsUPqCWfoC83lD7F2TrNNl4n9VIj6rH1pq7Umn3XuQUSDEd6g=
X-Gm-Gg: ASbGnct/OXiH4btb4ryYEHitIVT+UnvG18ybwonJbWOMBnohDUD5RMU+qVOHNBvAA+N
	zOEiFINsO/BKG91Le6ZWFsMMssBFQxPdqrwXWVgz40aW9luYZt1KZ6VeeQo/f8KcMKP84Lnyli6
	c/5uck+aZbmlGCzsLoWwF+yU1B2euuEmUrxlAreK8bc46wWRtmuEvw496qSI2cgN8izVTax6Xdp
	qkuqZ4w1qaFss9iImYvu/FfyaArDCsqvpXhNrgAA9Fj0cCCYQrkW0JIzwptxgzyVrH2TczzR+xT
	st/wkVBLnu/P5z9JqzttBoVQwcN2hF9/2HRMkb0e285XWhI=
X-Google-Smtp-Source: AGHT+IFY5Ed96/KcKz8L7aoyZ9lE6qS5z+d/+9NsZ4rcpOBs9+vdKruwDq8O9FLpVqE3mmL4J2bJeg==
X-Received: by 2002:a05:6830:3981:b0:70f:7375:e2b5 with SMTP id 46e09a7af769-726b8f3ab09mr416508a34.6.1738882111587;
        Thu, 06 Feb 2025 14:48:31 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af95bbb5sm510986a34.41.2025.02.06.14.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:48:31 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Feb 2025 16:48:21 -0600
Subject: [PATCH v2 07/13] iio: amplifiers: hmc425a: use
 gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-gpio-set-array-helper-v2-7-1c5f048f79c3@baylibre.com>
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

Passing NULL as the 3rd argument to gpiod_set_array_value_cansleep()
only needs to be done if the array was constructed manually, which is
not the case here. This change effectively replaces that argument with
st->gpios->array_info. The possible side effect of this change is that
it could make setting the GPIOs more efficient.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/amplifiers/hmc425a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index 2ee4c0d70281e24c1c818249b86d89ebe06d4876..d9a359e1388a0f3eb5909bf668ff82102286542b 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -161,8 +161,7 @@ static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
 
 	values[0] = value;
 
-	gpiod_set_array_value_cansleep(st->gpios->ndescs, st->gpios->desc,
-				       NULL, values);
+	gpiod_multi_set_value_cansleep(st->gpios, values);
 	return 0;
 }
 

-- 
2.43.0


