Return-Path: <linux-iio+bounces-25833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7D9C2AFBE
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 11:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D01DF4EF2FC
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 10:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5321F2FCBED;
	Mon,  3 Nov 2025 10:16:53 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC92299937
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165013; cv=none; b=Y1R5gTpe9HI9LZE2/S2rWRApagxjt9oZzHnuTyONTQtVT142PkFoOqRItcw/+aoULSJZ6a1XGEp6rZ83I2Bwbf7LvV6Bhjew5No5K+EkowEtFCIrS40G8t93Sh2ck7D78dvyGDyzYb+FSYGlBOBbc+dA8Fe7HHLCctK9FTkSmHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165013; c=relaxed/simple;
	bh=mTHQRbPtXcLW9RC24UimP00dT4bpQ240D8TduWco7Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktBPPZPlsKNL1IMG6Y/pDke7bcinmM/SD+gdCnnYKRxmfLBZ4MFKAa/qJmdYm6rf5lkwHb2J5k5QDQQbplDbbozfPwsW5YbIcjUGdajolpj1hkYuXr24aNxA0mwSNyUo0spud/fYut4fjz4r62zjZ4j5+X8UBKsf3Dq1OsiMoXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so3876740a12.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 02:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165011; x=1762769811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WN9rH9/69UaI2zM1r1sL3pcOf4U1LH9TZ13cniByZO0=;
        b=w1OXIYj+gR9jlSJlTy3mBZn/UdAKT60+2N2MO0Heryi/sqSPNfiomvSyO2CZLFgrzh
         Vd4cNA0/MlMkP9ZpwGBv2TNKO2K1hepNOCzONsXPZIVgrj+XH8H8X8g4D4jaVMiBeGa5
         LPvfQMYFIxQmnHKa/3my8NFT6CJ6rKtU+VrZ05lC6+wcbtl0NQGYxNkiW651F0WIopDd
         db2EJziqw/KNS+RscvGb8OZrjcUbCmVxElmABT43Q1F4xhrfooJtjx0gTVAkv5wCfQUR
         uYzaxFb3kyC6EzMynwRTyl9x7tYVzJ7HEcv9kRFQusqFLV8PRWhthTnUJVbNaPIT3w+i
         CRsA==
X-Forwarded-Encrypted: i=1; AJvYcCXmuPKWaehJ8KBAYc99uUP63ygKwRLSU0/VHqxgF5IjqpvFqmzZ98tAjLfARJILzKC8UWuP0Mz0b+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2GifM7AocWAu+juq/N52WNFKCgtqlNQhdj5jA5PhJk+5/S56Q
	uWHuvfop/YC+YpUhqyNIxYn6FiODWvwy6jG8yEePbowKyC11DA1pH/UDsUWNhFRc
X-Gm-Gg: ASbGncv8OXnTQzF7pyEsNt3+Y2c2Zr17PMcCWbIqDJPuYaNpcpRwr1S04BuzKAGvUTC
	f54wk4SOZGBJ25v6FZxGdnl5yTcradcmy4vTCSMT1AcSW1votvjterRZ/dOk5OJG77F2ipTP+4c
	8paEkRvMrZ/7mADyIE6qZjnJ+sSmIpbODKxVjSWWXqFVGBYik55+Rcv86NUZ9duD0H44d7OT5za
	UT095uKFTqkpodJsovshQ5XJzNMcDYlsR7I8EMXCp1+uK/U2VHbbhtb2+EUvySZY9pqsreK/vW7
	vkAbqHwaD0bwGa+fNHE4hzq8wV09/1/gfGP9+4nRRk4NdDhYziaNSYD2eqmSEWB4wniVMdkbKJ9
	YOc1Xf26uIJ79/0GFC8UXDa2qiAyRT4jkUcjxLd1Vc7U+i1OOCNac5yEGQ2N4dxXs3JIN0YJqSv
	aljREh6TQuy4jXaD/hFdOlORpNeV+hTsmgNm17wOTSfIvbNA==
X-Google-Smtp-Source: AGHT+IGOtzz3EvNeVuBIGmP69AYWW9KdvKiZ+mHgnwqgBFy6NUIEB4b3iMrnCE2yOSYZQ2P0Bvsceg==
X-Received: by 2002:a17:902:f54d:b0:295:82d0:9ba2 with SMTP id d9443c01a7336-29582d0a0ebmr66616445ad.1.1762165010750;
        Mon, 03 Nov 2025 02:16:50 -0800 (PST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com. [209.85.215.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bb28fsm113333435ad.100.2025.11.03.02.16.50
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 02:16:50 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b9a6ff216faso919929a12.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 02:16:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrW5CnTDL0Os/7VwhoxRR9g5wfM19gCT8UH3eswnlsVN7ff1YUN4diGIcGW7qt/Qzq7v0vw/c0fdg=@vger.kernel.org
X-Received: by 2002:a05:6102:418d:b0:5db:f031:84ce with SMTP id
 ada2fe7eead31-5dbf031902dmr85155137.29.1762164587067; Mon, 03 Nov 2025
 02:09:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <97549838f28a1bb7861cfb42ee687f832942b13a.1761588465.git.geert+renesas@glider.be>
 <20251102104326.0f1db96a@jic23-huawei>
In-Reply-To: <20251102104326.0f1db96a@jic23-huawei>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Nov 2025 11:09:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUkm2hxSW1yeKn8kZkSrosr8V-QTrHKSMkY2CPJ8UH_BQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmxzzzgoIljXMDy5wJmHF15bg4ZKICGjY8c2_gWom3ME9XAPzMw0ghLXn4
Message-ID: <CAMuHMdUkm2hxSW1yeKn8kZkSrosr8V-QTrHKSMkY2CPJ8UH_BQ@mail.gmail.com>
Subject: Re: [PATCH -next v5 10/23] iio: imu: smi330: #undef
 field_{get,prep}() before definition
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, 
	David Laight <david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Kim Seer Paller <kimseer.paller@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Jianping Shen <Jianping.Shen@de.bosch.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, 
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

On Sun, 2 Nov 2025 at 11:43, Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 27 Oct 2025 19:41:44 +0100
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> > Prepare for the advent of globally available common field_get() and
> > field_prep() macros by undefining the symbols before defining local
> > variants.  This prevents redefinition warnings from the C preprocessor
> > when introducing the common macros later.
> >
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> So this is going to make a mess of merging your series given this is
> queued up for next merge window.
>
> I can pick this one up perhaps and we loop back to the replacement of
> these in a future patch?  Or perhaps go instead with a rename
> of these two which is probably nicer in the intermediate state than
> undefs.

Renaming would mean a lot of churn.
Just picking up the #undef patch should be simple and safe? The
removal of the underf and redef can be done in the next cycle.
Thanks!

> > --- a/drivers/iio/imu/smi330/smi330_core.c
> > +++ b/drivers/iio/imu/smi330/smi330_core.c
> > @@ -68,7 +68,9 @@
> >  #define SMI330_SOFT_RESET_DELAY 2000
> >
> >  /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> > +#undef field_get
> >  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > +#undef field_prep
> >  #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> >
> >  #define SMI330_ACCEL_CHANNEL(_axis) {                                        \

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

