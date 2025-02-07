Return-Path: <linux-iio+bounces-15106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D01A2BEDF
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 10:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2145D18896AC
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA5D225414;
	Fri,  7 Feb 2025 09:11:19 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4321D618E;
	Fri,  7 Feb 2025 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919479; cv=none; b=fmYrvDM5JrBpsQ5K2CrgL/IoJR8npja/LZtz3s52n6exjOmfiA3MVVnC1Y/urCIzGHEOazk++1U8rM/F9+2Me7/JY4PG2oECE8L+dq/rkAJnb0HSowWjC1Rxs9Og652nw66E1oGzAy0X5Gy8yUgGlfR9n6PFwnv/qC00f32/Nys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919479; c=relaxed/simple;
	bh=u61PcvQYvGjXqoKlF75HIDoW1zfSqi+e4jVbsPkHMQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ompPuE8xTyWfcdusCcLxW93BEq5f+EN90MAOktkv2wTuy1GChnFM0799MPD52MiYPV4uAMy2KqVDFFZZ4kuAzEkM7wUT/nR5P4anoSnbr8fjA5/fc7NnvcAFPrE5Rbz6yyvOngusHJsiccDd1NkOuwBvtpRGikGwBSoVjZfZVmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso16622965ab.1;
        Fri, 07 Feb 2025 01:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738919475; x=1739524275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXaXKdHLoKk2Bg/TFRHcL35cN8BOIB//KM9g1NizCeg=;
        b=hfvAeUTwlk/2A+rCIyzt1PoPKA5lN1MK1BL6wosEZHeUPwVS05BSAkK4w8pJ+irJxb
         G7ZXRCL/QEGkzAWpCUVpnq/+cbogtzpw/amTy3tKtYfTh/ym7NdRrIz+wRlw5TCiAz7b
         Vmb+p8TYm3nOrcXzmZ/x5Djap38XK1fyTicBmLGyttpgvioIP9uLCJgCzQe3FcC3WA9c
         M2DnlgvAD/6ei3jmXq5QMUKsbNW3fKuRwH8PznQ2MJZWuIGUqKJh+7B6pHXbciIfDNfk
         uW/MXievSsOtauncDr+Gl3C+KaN4b+sBRQ66P4ZLzxj8OeAEOg01VtR1Md6tH96OUEJm
         OZ/g==
X-Forwarded-Encrypted: i=1; AJvYcCUJQNGfJIfPkRlkGCKhHRu4X+yUcg7ipVvN7dBehpFKNgap9LSho29I1o2eGYHpAA8hPJxzzJeExxxYy9tw@vger.kernel.org, AJvYcCUKWC4lfNmoHF5Sureb2vB1IdHcYVNh2/I4nLL++PxFzZks6gbCX0Vq4xphfxyl1/+iGxxq8fOt6e9VL8I=@vger.kernel.org, AJvYcCUUKxRZA+v7emcz8l6KlmPIwFCswgGK5ZeKmdgCmTUUMs1HgXbC/X2rEafM5o73/Qv2rCVZ9KZh9mEV@vger.kernel.org, AJvYcCV03gkTNiJT3xhzN59FL3LybE3CuFRyz7AGoqmRVU9bIWqqw0pHgCNndoZjgnpvjbPTMN1OlLvKGr4q@vger.kernel.org, AJvYcCVRbQuVSOcJJHyzS/x3dtyzn+Bz7o/w12tFKW5BqgdT/itt0qqtL1KiauQV1mWpvNpk6K28XuwBp79s@vger.kernel.org, AJvYcCXUjPyz5ZQPoipatz7YMtSTaJguaG894CHoQ6HLbrG9R/kCaaz6rIubjTQ2ZGoJhlmTEbWgVdVK@vger.kernel.org
X-Gm-Message-State: AOJu0YyF6rUy4sq6Fe8DaQT9Q+9MRGIaU1TABNtR12RyQK6peqCjJD2g
	Yt2zfK4FqwXqMWkf7jGB8qNQp4lHhG4nKUtOBHLAEDKkzj962Sv/yVwB6qi3
X-Gm-Gg: ASbGncsZfedorOGy8b2zSaFT2BsI+1Yty4g7FFSnHrilQZSUKWecuNX5Am5AX3ppQWK
	rjZrXcUQKL8VIAktOToUE3WACLUsgdU/DtzT/ftFk5jzF5PPNqipQYtup2/aTcVD1Opgf46N03q
	E+Q5h9itk2IfpEUGbPWmy1edo1ZiMtTq3z39iB2ygVMN7nUovlITR7q4hVOBks18bBvImED2H2k
	n663ZictBqwOVZHJXew0HatwoUj7mF17M137ZLBQJ+ZKUdoKsnCsaq/VHroBRT+ebBmMyOYcpAD
	hdcDC4Jax0ht0m+XkwyEhFvrl1agP10QtEbkWNX7KaIJ9Biu4OIKf7cYGQ==
X-Google-Smtp-Source: AGHT+IFkY09aibSPf1/gpIlUnx6Qdvk0iARD9BLTGhOSqcq0FflVzJ8fTSgviMpRL59x4GveJtKc8w==
X-Received: by 2002:a05:6e02:1c0e:b0:3d0:28d3:e4ba with SMTP id e9e14a558f8ab-3d13dfa700amr19512425ab.18.1738919474810;
        Fri, 07 Feb 2025 01:11:14 -0800 (PST)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccfa0322asm642257173.60.2025.02.07.01.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 01:11:14 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3cfcf8b7455so13598995ab.3;
        Fri, 07 Feb 2025 01:11:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8Hw4ojbNL12uqG+c2M6mead8QB/BDeyBs7da6BK6122NKkEA9IhXSF1Z8FuovhBhv7JVQX5+DsecI@vger.kernel.org, AJvYcCVUyPcHvFN8dxr2MbFdaZW5ByG4QyuARlp4J//bmYWVEpvQwULsH7bipcffsHBacLQWi13UjPPLXvGcCUo=@vger.kernel.org, AJvYcCWRxx/cLuJ+2CoocQnwsYx/8NU1B5OOmtHvNSO9iEDnVA50GzVcnwQ8MPad7nThCsgBkNvKwdh3Gvy0@vger.kernel.org, AJvYcCXWFkEcfqqjpBajkcQqb+4ETmeMlWlQz9A1xSwMLksEpGT4hW3z+AjCq+Ud5K5SH84LTZ+l4YR6@vger.kernel.org, AJvYcCXii3TQp4lD/bD7Vl4E9PGlnUafvSf/g5H8Dc2dIGwOno/6Pzdzxfg7k59gAHUrvaNg0JNCdrJjAwHeSUJA@vger.kernel.org, AJvYcCXniRzRN6bTGwDjv8vVqDbQD38CTJKb8iaCYKpI7kzmo4i+Hia71HKCdlHwftA/bUIwa+YlblmuTHSp@vger.kernel.org
X-Received: by 2002:a05:6102:5088:b0:4b2:4877:30bd with SMTP id
 ada2fe7eead31-4ba85e54e05mr1293360137.12.1738919086507; Fri, 07 Feb 2025
 01:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com> <20250206-gpio-set-array-helper-v2-2-1c5f048f79c3@baylibre.com>
In-Reply-To: <20250206-gpio-set-array-helper-v2-2-1c5f048f79c3@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Feb 2025 10:04:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU-aUcBJgPoJRGqzBY-Bz2m4vqcbNdNtKJNVO7-uoYjLw@mail.gmail.com>
X-Gm-Features: AWEUYZm7zUNXfbynKkUkF501_SJvA4QZJWomDWGGkRSnLChv7AsYMrm87FyiXfA
Message-ID: <CAMuHMdU-aUcBJgPoJRGqzBY-Bz2m4vqcbNdNtKJNVO7-uoYjLw@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] auxdisplay: seg-led-gpio: use gpiod_multi_set_value_cansleep
To: David Lechner <dlechner@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Feb 2025 at 23:48, David Lechner <dlechner@baylibre.com> wrote:
> Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
> gpiod_set_array_value_cansleep().
>
> Acked-by: Andy Shevchenko <andy@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

