Return-Path: <linux-iio+bounces-25618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602ECC1B717
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 15:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520241A25CB7
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 14:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48D12BFC85;
	Wed, 29 Oct 2025 14:41:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19C2D321A
	for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748888; cv=none; b=q8iCIX/VtVwH8r8cyN85VhbfPHAwi/9y3h6DeeahApd4vHFEcO0sWpwYxsjCjBWyE4B0VFZgHuzkz0jxcnkrySfHpBE5pE3JmRGbfp+EJy3rKC4sOcqckuQw8JmU/9Dy3+E+DIJb3C9eRG7E7rEKWMJptKruRPjmynJhy7h6Ye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748888; c=relaxed/simple;
	bh=FbqavNtq8VJC+dwAXLJIaCG9l+pt4WVO7NOuPi3OYaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mF6A1niK7i8NKuVRUNklqvjiMjLeiMor5vrKWUYRLfC7/Scala018mDNPwcjmUbhjRaeAbgv0TGlRq5It0LwAZ1LMZTf1bJqw157ylE85trAufKhvpndzhNzwlNLOtvJXYDCBSUgxbOH1eVGgEkmMHcg1JiUCTj6FCU0pjRuXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-88f2b29b651so740789185a.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 07:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748886; x=1762353686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNDkhDDabcFgtYSzLRibzijDMaquJ035sDb5A+sIiAE=;
        b=FL98nfVAg9o8ENtNz5sxuGhvieaXaW9is7uvM3VJz1gwNeaVzZzSa1Ar2ymp6Dj5uV
         kWAfxlS5C5694eEgRjJFoi7aCJ/YAKFCWLkpMEuqo3RweRyzEuXqcej3Hc581gPTJ7o4
         VlXDlUYU4sw4jyDkK9AKQeH71+WFjmC2eWPObkMgje+Nv/vKgdeYA4J8gYLc+PNd3rv4
         OqZzmyhRTNvNoawzIaQQ/76SO3T9QrhEHlRgQAw7pOG2NVt7CGVKbZf9BUMELI+ag0sO
         W3j5G5k1i3GwHpjgU09E8Lnczdh64y8O9zlaYAwh/dKOrhxrBSrKUA1rb5iV+iZyHIZj
         saCg==
X-Forwarded-Encrypted: i=1; AJvYcCWPVdjaETXotFVGqICPCsvcIwHki63UgFXEqg8PHOXCxle8IcHqv5GmEIGDnjR/+JWVe6i8ccCdhY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx151qj/qW07h2uQsQWvWpQ5zAqcAA1JntMIuvoGkbWxNCxii4w
	mVIABy0NlXPeioJuSwt0pEDh28VCzT/EKbomna6CxuMV8FsPnrBGV1OAuJ7u+qqu
X-Gm-Gg: ASbGncu1RNEm7GURM4znaW7ShnJFEE4xOg2HptL8KPWhPBXK6SNomfi3IHGJ+E+WyDP
	R36TzbZ1tR7XlKsXM3k5Y3xgvbn1RrqEEGx6SpJeH9jJlmLo3qEHLFKx8fX3E9GJj9yukSJp/xP
	9JJVLnJ5xNI7Wh/yi/cl+kjHRmR8ZVtkAO855sJlJC4PobCXWhMet88uCaO1I9DKJYKcOvhizMK
	IE8UFDazxA+/ru2Khc3Qn4kR8GuWUbkADt9Vb3NkjLieWuw/w5TTnxaZQ1GxXY/emZWy5lLqIB/
	88BGuyQvWMNUThaXDOWKXoegc5MYhrhMvIv8ZylnrtuLOdX2iNR9C6EatmXYVwkeycZthz27OdQ
	0GflMR15p2HFJBcCoh0yB2HPPPxRO7kSM5r+ve4quXbCYhGozapWJj/UlRZfl/m+kLI8whfjBbP
	OP7ZA8TAvImTYRQmoEdQxlNFGlHfyZhHzwpbf4QsFpOg9RtyCMOUJk
X-Google-Smtp-Source: AGHT+IGixbwy7XRsaH4oY6Ogc+mgWAr5uxA2lEGEY2gflWxljDSNT4AcOHlE9VkxIfApb5xE95AP9w==
X-Received: by 2002:a05:620a:6cc9:b0:8a9:b0cf:fba5 with SMTP id af79cd13be357-8a9b0d004fbmr154995385a.69.1761748885477;
        Wed, 29 Oct 2025 07:41:25 -0700 (PDT)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421ee50sm1064612785a.6.2025.10.29.07.41.25
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:41:25 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-78f30dac856so84986086d6.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 07:41:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuiUt1FKsVqmTBsYL9/lZo0i0RShbcaJ1wU/N0qjRXJ/SlcFATUsvM9iLf28T2HzSTtGQfo5VVCs4=@vger.kernel.org
X-Received: by 2002:a05:6102:26d3:b0:5d6:156f:fedb with SMTP id
 ada2fe7eead31-5db90694687mr933346137.36.1761748440676; Wed, 29 Oct 2025
 07:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <03a492c8af84a41e47b33c9a974559805d070d8d.1761588465.git.geert+renesas@glider.be>
 <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com> <aQIlB8KLhVuSqQvt@yury>
In-Reply-To: <aQIlB8KLhVuSqQvt@yury>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:33:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUTR2VnQ++j_ccUN3-GzKmSzS3H3QNyYqZNacfOBXD50Q@mail.gmail.com>
X-Gm-Features: AWmQ_blqiXGJheNiHtKi_cJSwq0gfFP8sAonrx_tsjN_f5pUMr0aiWqvAOsiPck
Message-ID: <CAMuHMdUTR2VnQ++j_ccUN3-GzKmSzS3H3QNyYqZNacfOBXD50Q@mail.gmail.com>
Subject: Re: [PATCH v5 07/23] pinctrl: ma35: #undef field_{get,prep}() before
 local definition
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
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

Hi Yury,

On Wed, 29 Oct 2025 at 15:30, Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Oct 29, 2025 at 03:19:45PM +0100, Linus Walleij wrote:
> > On Mon, Oct 27, 2025 at 7:43=E2=80=AFPM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > Prepare for the advent of globally available common field_get() and
> > > field_prep() macros by undefining the symbols before defining local
> > > variants.  This prevents redefinition warnings from the C preprocesso=
r
> > > when introducing the common macros later.
> > >
> > > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Do you want me to just merge this patch to the pinctrl tree or do
> > you have other plans?
>
> There's a couple nits from Andy, and also a clang W=3D1 warning to
> address. So I think, v6 is needed.

Indeed....

> But overlall, the series is OK, and I'd like to take it in bitmaps
> branch as it's more related to bits rather than a particular
> subsystem.

OK, fine for me (if I can still get an immutable branch ;-)

Note that as of today there are two more to fix in next:
commit d21b4338159ff7d7 ("mtd: rawnand: sunxi: introduce ecc_mode_mask
in sunxi_nfc_caps") in next-20251029
commit 6fc2619af1eb6f59 ("mtd: rawnand: sunxi: rework pattern found
registers") in next-20251029

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

