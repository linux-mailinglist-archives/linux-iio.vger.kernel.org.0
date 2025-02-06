Return-Path: <linux-iio+bounces-15093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A35A2B5A4
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 23:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53ECB3A3DDC
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 22:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491F72376F6;
	Thu,  6 Feb 2025 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vXsnwKxu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189B246320
	for <linux-iio@vger.kernel.org>; Thu,  6 Feb 2025 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882112; cv=none; b=KfO8TJ4fe/+RwgqP7sBDv6G6F8OomenFaPMWdFLBqQQrKAuEs0OfZvauoyB+Fx0HP7ldtSrTRKi+n7zutv2/gt19WQj1i/n1isAPpnyk0yGf3n/gdK8k/gVuHK8Agh1b77tSzJKyou/updBu6hAJxRHZ5rpql00qTk9O5OIW+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882112; c=relaxed/simple;
	bh=K5V5TnWu+110nnHuULWw1Pwd0QiBFgzUapmy9BeC2p8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jT6bNVo2/vU7p876ldudeICNiSHaY43v6ShTKuB3Sqzlvfhmc6hsnhFMJ91rETDn4mO7XddcHC3kbEAsqG+OYV0Wc9Evdpy74Q+ThUSm2cC4B+QanTJfc7X+43ZAY1ehRI2iJ8EafMvNrfSCFMXbzhP+Dg0ZCS/4uU5RzxdgOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vXsnwKxu; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb790888c6so468085b6e.2
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2025 14:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738882108; x=1739486908; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAgdP5/7nbSCpei3bdgHz+Kvp3J/VbeQ+Dc9cWuRxQY=;
        b=vXsnwKxuC71ZpjX0nbYzQvtqVo6OCEuNOXds+okgver7+eVdKXmmAWRZ54Thz+OlOv
         NuhCFxG1N01NsmMhVGyZpKW/y7TYPrahCu2+KpHU1wIFjLmeMweXSt2xh5hQ8PA5uwas
         lLw6la+v7QrTwYGmAEGIBRkIhjC+XJCb0A3aFKtH/aHHHqkb+CJ1jjM+LixP6ENvMH+x
         NIoHa+hlCWZxQBqKg/uZ5cYFgAVOuDWCpioO7yN4y83nOjgVt00GP6uyFJrhO/A1QVAd
         +Wo85rhB/AZSM5Sz/u89qYKqyITVswuV/ShwQ9dodVE1GHEFTtRaEB9AkSPiqZ6hsry0
         pc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738882108; x=1739486908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAgdP5/7nbSCpei3bdgHz+Kvp3J/VbeQ+Dc9cWuRxQY=;
        b=uw+M9SGDKSJumKY4lHyDawmeWT1Pa0BvvydjW0pK2PeboSdGuXPFpVOnE0eIm0xJGz
         tSCAIMNp0HLNY8XGPbZPtnV6h8nDPlBctvBx7kzo4qRWb3DqY6UnqZfpvLTkcJfzmcjB
         NK46RwjHNv6kbZqF+WHrydYfPkCwGGnUMrTVDMTzIW1PWiJZvqbozU66oJrjspm2Dl3s
         clYhYZr20I8sIPb/7w/YkWBXzifmzgU1x+lrKdPC/d9HJ3zMZkwBOEK60IuT5oLzYtBa
         0w2R7x0VQAhnWsLIJLCdY+4nhWp9qUDyGMrvD0WX1k+XFIJrHN6De2/2b3nhggZblAU0
         H+tA==
X-Forwarded-Encrypted: i=1; AJvYcCUAoQIytU7wYSrhgYM6tej8u7MqUJ236FzubaxYhzqottWtHZBBOJnQLb31MoZMxnoJgZLvSqo/wFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL1vyGn0nc7OGKFHK6BermKpJHIZYIQSydjCN3CR+V6j6t6nJ0
	CbkGTXkVH85/0A606wrAH7cTSKS0KV2OJo0V40CUCKOmBeZxU75Go2yO6j8oFNs=
X-Gm-Gg: ASbGncuezvX3fisaETjxKttgpIk6YMkatTbBOd06RB0Z9Pnu/SUR/uuTMuWtv06zpTw
	3Bb3BbXNjKkkUZAzNkpBWakM3+ESPdZa2HPgYcIBdJlvCzYCKEfCnsg246fSw1rHwQCvGrHqMvX
	MaoiEoMeWNpzqfwrIl284bU/krH4G/sz3ufX3nY09TZIQ9wH8ml8BcqYP07SsJWPq1ZDLvsWBlX
	oLKwLW56/14gKWMcj4Z8UqPmHkw+BTabIzNzRLy5064lEzfYxthDkOyHRNFTHdRV5qQzUho4ivJ
	ptX8FasZixIZAfKSXLhTq4TakPHuxYQMO2+gVzbm9OQ6mu0=
X-Google-Smtp-Source: AGHT+IHR3rdzOh31Bx2HFTQsJV0ppIelp4NfQddbrynjHIrf2JbNfAwcWx67zk6KGYi6B0FrKmfqwA==
X-Received: by 2002:a05:6808:189d:b0:3e6:3a82:f790 with SMTP id 5614622812f47-3f3922a086amr707666b6e.6.1738882106950;
        Thu, 06 Feb 2025 14:48:26 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af95bbb5sm510986a34.41.2025.02.06.14.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:48:26 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Feb 2025 16:48:18 -0600
Subject: [PATCH v2 04/13] bus: ts-nbus: use gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-gpio-set-array-helper-v2-4-1c5f048f79c3@baylibre.com>
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

ts_nbus->data->ndescs is validated to be 8 during probe, so will have
the same value as the hard-coded 8 that is removed by this change.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/bus/ts-nbus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index d3ee102a13893c83c50e41f7298821f4d7ae3487..b4c9308caf0647a3261071d9527fffce77784af2 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -109,8 +109,7 @@ static void ts_nbus_reset_bus(struct ts_nbus *ts_nbus)
 
 	values[0] = 0;
 
-	gpiod_set_array_value_cansleep(8, ts_nbus->data->desc,
-				       ts_nbus->data->info, values);
+	gpiod_multi_set_value_cansleep(ts_nbus->data, values);
 	gpiod_set_value_cansleep(ts_nbus->csn, 0);
 	gpiod_set_value_cansleep(ts_nbus->strobe, 0);
 	gpiod_set_value_cansleep(ts_nbus->ale, 0);
@@ -150,12 +149,11 @@ static int ts_nbus_read_byte(struct ts_nbus *ts_nbus, u8 *val)
  */
 static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
 {
-	struct gpio_descs *gpios = ts_nbus->data;
 	DECLARE_BITMAP(values, 8);
 
 	values[0] = byte;
 
-	gpiod_set_array_value_cansleep(8, gpios->desc, gpios->info, values);
+	gpiod_multi_set_value_cansleep(ts_nbus->data, values);
 }
 
 /*

-- 
2.43.0


