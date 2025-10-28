Return-Path: <linux-iio+bounces-25580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC8DC15279
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8873BD459
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28959332ECA;
	Tue, 28 Oct 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uIBa1ecY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C7A335090
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661230; cv=none; b=i0OZLMsVJZPRJ4c8IgS13Gj6AlfeV3U+TQF/Yr2zzEQPC+iBSluwpTFZpS6qe75RxbXiqF0n4gFS8LjWtQGL40nOKMIB5s82eznAqfwiXlTuXxy/ld9sDOmaXWAaWSq8jYwmVhMD6h2IVQvxj1juCYcpshEvdqTneqhJzNDnfwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661230; c=relaxed/simple;
	bh=pP8FTV47DQsaScTl4AKuec/C6HsHLvvn5JrdlNFvXF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rok61aCXaTHwrXqFgUUh54SFSYLVVehKQpK2kZY+Sk1/kyt2McVHvjVwoWnb/wXvNKXAGZ8pr63fKEv9tWUWtTJfYUuMyTJtWO1QODjvlfchnNK3cr8v9oCLtmNrSl+6LQ/DWpJr8G1bCCBv6TOfQz9tcJgUrTJ3+0Dyk9UL3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uIBa1ecY; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-362e291924aso49443171fa.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 07:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761661227; x=1762266027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOmSiTMyA8cqAorOzkSzQ5xujNoDEMVqXsbHnkkNM1c=;
        b=uIBa1ecYcS0SjQasgAEKQr/pVNdcH2s+vv+Ivq8X+TvJlZm3PK4XkoOKj+ySjsss6V
         0g8VjUJ/7QVvEAWpyHMqMetwZu3/zoN1N9yyXtB0KFxrE/rVPaA1Wla9t4UuOGIAw/wn
         tLvnxdxSdn4y9ZLZkoqvs3/uknC8cTF+ohyHp0eXubW+fJwQrXlNVOsgxyt8mMbBy66D
         1uC4SKbYh7kSu4m2DIPdoiKVO+xnGkWcrG1i+y3Uwm1SYSS1wzr0PjgOSFofFE0v8Jnx
         uh6w6swnMKwZGoMtYXUS13Dhkpdcfv4aAkZJJYWpnhecHmYQWvg4zllIFHM+xQPboquJ
         uIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761661227; x=1762266027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOmSiTMyA8cqAorOzkSzQ5xujNoDEMVqXsbHnkkNM1c=;
        b=bD+mKNCfk1eID0Xz7S3pkBJXFH8Zru+tDTEtmeX6sFCw+i3slq5r08KbqrIhA+GvWf
         PjR0zuRexMrtcCNWqERKt3Ib6bt8VXZ3UvbTSFcfixIGfe9TlriKvTCaMJPDW9Uqt8s6
         haurrViWbRnc5E0bilCFP7jad7vVlwxD+Hx/0qMv032hbFKpYPUfME1c6Fl3x0PujIh6
         w+JYbZvJgo/oL9YFXeVCSLG0yysBgvmIryskJWIK25Asml03DiPhVru/Vs2lhtDO0eRX
         vyQnGxxM+1PUup0dFwYG1oP0V7g+0473xZ2jviq1wNeXdjhXymiUuHTEjqtM7KxbNb/I
         HwjA==
X-Forwarded-Encrypted: i=1; AJvYcCUvKEcUqxWxQ5Y2kyFfMaOANMM/LQKVeeaaXNhsbXoPUH0BWpnDVkgb+d8ADwxuz5ziw59R/mvSSGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8BmDtYMX7MP/6R7EyqrsGo3R5nShC6+sC7NBq8z36bWSueRbt
	1O65Z3WHItl4gVL7bBMxn6o/yE3AbOUvkf3oARARE1k+8y6FO6eY5F6WgMpxRV4hKH9Onr2U9W/
	4DwcnRsHxFAwvzEpvhGbPReZYU/M5ZM+vwtWUB+uCkQ==
X-Gm-Gg: ASbGnctYHYRM4CIyYVS0tooGypk3OHHG0KFPua/XvlhAwYP4B06fZPQ8+Pyv6dxnL/4
	k2TkXBdtCBX8TNpGntFavkWDYn96Gxvsy171bLAU5ETftKv1gE3Pd6IdbCYXLrRRgd2b2sZzyEM
	9RSfbK1Iu1wyzHMjtbBwRqeDU9ahv39ouXGrtdAfMGCLP9V86bU0RHRlyZ7YE/kp5pTCysK6NQD
	35+X5BZCOZe1W//iugGNLZ637YDjBrf8mb+JyoZPu3SITLxf1YWioOCXEX0gNcZFHH96/LgYNow
	pN9OKmN5vjm2LfDVVtdWC2zLckc=
X-Google-Smtp-Source: AGHT+IEa9/49xzFtkrl2WuFSbF2nGR0Ee3sa2JYGGK47IcVnnhS7gaKd3pqPtDHg3v3/2iaUnvbb9dKc2W6cTL8KA/s=
X-Received: by 2002:a05:651c:2354:10b0:351:62e3:95d6 with SMTP id
 38308e7fff4ca-3790773c607mr10303011fa.28.1761661226962; Tue, 28 Oct 2025
 07:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <76ac5587c5ff3aae3c23f7b41e2f3eacb32ebd21.1761588465.git.geert+renesas@glider.be>
In-Reply-To: <76ac5587c5ff3aae3c23f7b41e2f3eacb32ebd21.1761588465.git.geert+renesas@glider.be>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 Oct 2025 15:20:13 +0100
X-Gm-Features: AWmQ_bkGEmC8OCwW4QksGegCfgNPPWl_EjVB0knvBjv-hfBoqYq6hENcwtWJ0QE
Message-ID: <CAMRc=MdcH-56_cJ7oDUhHRsJRnDqbss5ET-3yGrBffGmEK_ieQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/23] gpio: aspeed: #undef field_{get,prep}() before
 local definition
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
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
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 7:42=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> --
> v5:
>   - New.
> ---
>  drivers/gpio/gpio-aspeed.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 7953a9c4e36d7550..ef4ccaf74a5b379e 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -32,7 +32,9 @@
>  #include "gpiolib.h"
>
>  /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> +#undef field_get
>  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#undef field_prep
>  #define field_prep(_mask, _val)        (((_val) << (ffs(_mask) - 1)) & (=
_mask))
>
>  #define GPIO_G7_IRQ_STS_BASE 0x100
> --
> 2.43.0
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

