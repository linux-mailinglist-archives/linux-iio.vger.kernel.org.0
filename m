Return-Path: <linux-iio+bounces-15101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A847FA2B5C6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 23:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC3C167897
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 22:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B139024060F;
	Thu,  6 Feb 2025 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3d8s6bOu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC7623FC57
	for <linux-iio@vger.kernel.org>; Thu,  6 Feb 2025 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882122; cv=none; b=Zegr7I7x6IMVp0eJg5CGZaTADJur7bcat5H8p5pfGtWAfRf0AHWcZLcYwtUVxVd9U/mSHkTSzwkv613TUWIV0fXuqLzBOjB2l7obro3y1U7KaKx0O1Gyd59phS/a3cxD82rGjxRNSyojD23sSkHeIPYpJAIROrdRZZQgSrlLDQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882122; c=relaxed/simple;
	bh=SREiuK3L9rZlfmn2CRPkgp1zixwI3ho4VDIygOej2Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=djSdRIriz5xqG7dGmT+HXZMGlylmdxajitBKXlyBZjCmYbeoQLLe/SZa8mCQsR9ZPc88xDwccoqS7Uq4mG1XJAdYWeXMnh52N+XTqFvX1ZaWK4ns2cGEa3jbTf5IxqvsE6DI5E5JdIf8hiJ+jJ0jJH871Sea+Jimo9h83K70gG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3d8s6bOu; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71e10e6a1ceso461107a34.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2025 14:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738882119; x=1739486919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zrl0lG0s99SDBuGZ/+AcMLJIAJmPLy1NCd/dBoX8jU8=;
        b=3d8s6bOucWMdaoYvNt0o9ANhpGoZ8C427iKTKgI76bTHXp9+xlOcMknn6M9/irBoHV
         nksFkUy5g7dk2r+aT8r5Wx15FhnIPzzraKfbBSWHmfzbJ+eUY3B/pY56TQU2xouTA2LN
         Vr+dhX50lwrQrCydJKGi0eQuZXeXfCm5BYc3W/Cy4BvTMCozQ4iImUZ5VfL403WpkJmG
         +eUzou/GvavA8Zh2VtAQmAtBgduaJd9HFjMyCPE9Fm6iy4wic4oDzhZJC14LWYjdn/Qb
         JFVxWz21CfUGF6uZwXo0357IZHuLwyMGehza6M1gc5KXCv6L1kz+rrw+kJrP0vLjxP0Q
         3TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738882119; x=1739486919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zrl0lG0s99SDBuGZ/+AcMLJIAJmPLy1NCd/dBoX8jU8=;
        b=lWL5Ppfjzqkt0g+hth9V2ImBmsxfWe/bDtJQEyiHmpDtrL96mywAOS+udYdRvjFRzN
         1Ztv1BNytMk+1NJ5V2z9bz6GqyJTx22d5tIX5hpAhQ+pf5Eammipb15d/X+3eG1rcLxK
         eH8e6Wf18FkOGn/ap6VH6/GnvKbvh+Foim9QaS6cwFTowSEfpmPfwEdBY9k07RgQabCW
         OYKAlA37aPLoUWvMeDnhlim/T0ocmmRYHD9w0tZHcXcBhOd5nqEbfnWOgLQch3N/QfLG
         NzSV4X5hmXWFJ+GWWqpQmzevw89bPYksKvju1BIE5Uhf5MUieelM30wOn+3Co8PIrEbO
         eyLA==
X-Forwarded-Encrypted: i=1; AJvYcCVMtvpYWacQL7G3mcYLJHK5ZEysLMoJ4LPwW0SHOZUeuHbicx63DDxn9x0/RyHjq9kFYT4U1jLaE6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vn/Ekg2+6wW4edlWT8UMyxRO2doY/JboL3rwCtrp4CeZydGD
	7hyZ9VPJh+3xxqiyWIUkP9INn6Xo25F8wcRGHyYmUux+VGmvDtRPE/cr2U4BGlE=
X-Gm-Gg: ASbGncu5YfUGJQEDLvYZQ/6iHfmmbMOZnLQ2ym9lyuq6qcWzpqS4DexZvwrL4ROMKT+
	5coDtcua9VsB5n/UbQ57cgCoYVJK82huxRploOJTa9SLrJ0CqCp0wkO1ERsohdLgI553qv273oL
	ynVxlT7JrBkMorJsYkRTZVwj9bk7C9eJ3HnVw12ERannjwTkQ/rkMVwWxUJGtjnyI3nFcYaoh3Z
	toNXEjlQIYqh+Zl7l5JRLpMSgA95XPlVuWTmo1MfBJEJzp3eRk9hO9kKEFIL77HLlCNUCmrgvwG
	awedS+0xdLSvotBiSMJoE0VD6ju2t2IFKG7eoykGeOsyvbE=
X-Google-Smtp-Source: AGHT+IF6EkhBBGtZyNdnec2UQucqxt5fakVdlz2IO8AnBCKVXc9lOTpKIIPxZD3f0MWNAAb4im2E5A==
X-Received: by 2002:a05:6830:6819:b0:710:f38a:191c with SMTP id 46e09a7af769-726b87c732bmr566366a34.11.1738882119510;
        Thu, 06 Feb 2025 14:48:39 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af95bbb5sm510986a34.41.2025.02.06.14.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:48:39 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Feb 2025 16:48:27 -0600
Subject: [PATCH v2 13/13] ASoC: adau1701: use
 gpiod_multi_set_value_cansleep
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-gpio-set-array-helper-v2-13-1c5f048f79c3@baylibre.com>
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

Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 sound/soc/codecs/adau1701.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 291249e0a2a32df7dde81904dce2f6be143fc2d7..6876462d8bdbb41d551f776c2d7fe6ed46115fa1 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -325,9 +325,7 @@ static int adau1701_reset(struct snd_soc_component *component, unsigned int clkd
 			__assign_bit(1, values, 1);
 			break;
 		}
-		gpiod_set_array_value_cansleep(adau1701->gpio_pll_mode->ndescs,
-				adau1701->gpio_pll_mode->desc, adau1701->gpio_pll_mode->info,
-				values);
+		gpiod_multi_set_value_cansleep(adau1701->gpio_pll_mode, values);
 	}
 
 	adau1701->pll_clkdiv = clkdiv;

-- 
2.43.0


