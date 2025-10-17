Return-Path: <linux-iio+bounces-25202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A42BBEAA64
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 18:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92456626D08
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A05B2475CB;
	Fri, 17 Oct 2025 16:07:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA2D330B26
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717245; cv=none; b=rJ5qjnGSZ0Uh0Jk6HKbpm4gkq5woIydWqTi5ZT1o0IZnQMRKxMjisJV2lU4HPfmOghg4SUTVePUHBeqROCNWctG1JoPJDz+5fUiljuljN9hnm45k/i3o8BSPlqMaxL7uoMqmvTGfcV9oRgwln+SF0DQeyPZL0KhNVsEMgqb3Kz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717245; c=relaxed/simple;
	bh=5UuF/HjwkQMRQp3toEpBUcYrHBj825aq+Tc6Itk11zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awfEGU2GREUDxQN6aYu1Ye8iwWmqm8QauEO604nSBW/Fa3nMB+b+XLF9BJXoSabI7S7EgTl9uDdywJOpjCJ/bEMdZX11mkkiarvDxOntEp0rWehEaj7wwbXPnXHFIzSo3qLUu9BvjvN332nh7oxrfFXQQxXTWgbmuSZ8EafLXiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-651c77805d6so628444eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 09:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717242; x=1761322042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4mf9FdrvOGmLornKgNki0gXD9BcM6SCmzEl3gfV4Zs=;
        b=auA8p5Hu508+SLIXOgwG0dlD2rnQZJpJmUZ6v10DwA3LNgKmqwkVsvNP7UZ3vtWVgu
         TVEcwgxcpfPUGMMw3HZgC1WTTiPjprpI8eio4oTPN95zxKSEOLaLSqxmnC8kPEMZmrVM
         WEcFUJ9I97FVUuZtSTis27urh9uuvAwwO27XN4bZVImO/GNyYzzIk4cS2dNa8aombLuu
         lcVM5jD2cfMsRpWhF0K+8tYDcLikDVz6xDAbGWGJlqCr2NjcnVlcaMvDit6TovoAn5Ya
         nyAVKel0gYS8TssBtlTXVqhGCJDRPOb7r6MDIal4+ZSeQFq9eJL2wjKJWSJK+7RgS8F3
         bmqA==
X-Forwarded-Encrypted: i=1; AJvYcCWSo7mUTLru7DlqimD6Ub+oYZB5pNGjbztByAhVB3I2yQZkI1K/UNMALPl/8hHpTx0lVpEHdTOhaFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhFBxIMmu8CmdKZYGRpjpseMQ8/SrIBWB/I25Jbb7W34HD6zR8
	wHt+V/i+zQGPrtP8CIYwFcvMle/MjYIOF7b2s3xJqeF9Szc1fyEZuwRsND+87WR8
X-Gm-Gg: ASbGncu2o07ZfQk26/mWhIzFw6XyQTTsAm0wx7BR2PU39NS58aS2+CXc1Dx/CCu/3pL
	PsEr3u+BDBqj/HdQFGd9/CygV1mO2DIHZExpJjdKpWpMWmC/w/RGE3TxmTc8Ff5bTdmXysYnbDC
	tTowyrJEqZeQPSjrKVAbhpknmdWUwundu229QvgWsZlsF1P6kUL/H6mh/EhKC8k3n4t3pphFJHw
	rSQ0qIOykPjB0Y3g0Mm8ijxDwO58rtxJiDxqaLC5GDYOkIs9eb2MZcwwwaJ6ck4lnjDoGb9hKju
	2C2QGbb3OY0R8BQOtlKh6xgANqiRk8YqolBi5/XvLjK0y8+W7C4WnR+Bu3C/ROKwfweCESD8K44
	Q3QV+XO3Q3ryEFByXnivIL04yDZLFIdodb1CUhaIUKYpR3cks4Q3frnE+Bt+GyM8xKUyebb0liW
	KR4fN19Z15zD9dDjf3oYX8eocqgVMaaqLuvfD5+Q==
X-Google-Smtp-Source: AGHT+IGpI/b8Qwhuu2BOTDohccYqmY9YPByoqFf4VSMI6kCErC1lBjkkRwx+mSn/Y7KAk8q6VPp/3Q==
X-Received: by 2002:a05:6870:548a:b0:36f:e87a:fdab with SMTP id 586e51a60fabf-3c98d179bccmr1452654fac.44.1760717242502;
        Fri, 17 Oct 2025 09:07:22 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8e80a38sm7402125fac.15.2025.10.17.09.07.22
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 09:07:22 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c2730d8fb0so1196050a34.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 09:07:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwMLMhjEIbQ8U364EaapTSxmZrKXQbiTv4rNSGpZkyWjrJ+6JkMlJk5VCnIRKJtxG05hXsDmIpFQk=@vger.kernel.org
X-Received: by 2002:a05:6102:40c6:10b0:5d7:dec6:389a with SMTP id
 ada2fe7eead31-5d7dec64177mr1309355137.9.1760716852567; Fri, 17 Oct 2025
 09:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739540679.git.geert+renesas@glider.be> <2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
 <20251017081912.2ad26705@kernel.org>
In-Reply-To: <20251017081912.2ad26705@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Oct 2025 18:00:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVS5KmVkv_pmc+R-EXik-Z1_7nuiHM=vm1Cu8v91wmLBQ@mail.gmail.com>
X-Gm-Features: AS18NWD4CQztq7yi6j63q-9XtnW0otWo2wOw8z0_Fp7R-6z_qrlZWB5IqFYEbBg
Message-ID: <CAMuHMdVS5KmVkv_pmc+R-EXik-Z1_7nuiHM=vm1Cu8v91wmLBQ@mail.gmail.com>
Subject: Re: [PATCH treewide v3 2/4] bitfield: Add non-constant
 field_{prep,get}() helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>, 
	David Laight <david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	qat-linux@intel.com, linux-gpio@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Fri, 17 Oct 2025 at 17:19, Jakub Kicinski <kuba@kernel.org> wrote:
> On Fri, 14 Feb 2025 14:55:51 +0100 Geert Uytterhoeven wrote:
> > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > constants.  However, it is very common to prepare or extract bitfield
> > elements where the bitfield mask is not a compile-time constant.
> >
> > To avoid this limitation, the AT91 clock driver and several other
> > drivers already have their own non-const field_{prep,get}() macros.
> > Make them available for general use by consolidating them in
> > <linux/bitfield.h>, and improve them slightly:
> >   1. Avoid evaluating macro parameters more than once,
> >   2. Replace "ffs() - 1" by "__ffs()",
> >   3. Support 64-bit use on 32-bit architectures.
> >
> > This is deliberately not merged into the existing FIELD_{GET,PREP}()
> > macros, as people expressed the desire to keep stricter variants for
> > increased safety, or for performance critical paths.
>
> We already have helpers for this, please just don't know they exist :/
>
> The "const" version of the helpers are specifically defined to work
> on masks generated with BIT() and GENMASK(). If the mask is not
> constant we should expect it to have a well defined width.
>
> I strongly prefer that we do this instead and convert the users to
> the fixed-width version:
>
> ---->8----------------
>
> Subject: bitfield: open code the fixed-width non-const helpers so that people see them
>
> There is a number of useful helpers defined in bitfield.h but
> they are mostly invisible to the reader because they are all
> generated by macros. Open code the 32b versions (which are
> most commonly used) to give developers a chance to discover them.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks, but this is more or less the same code which you suggested
before [1], and to which I just replied[2] after looking at the
generated assembler output on various architectures.

> @@ -188,6 +193,81 @@ static __always_inline u64 field_mask(u64 field)
>         return field / field_multiplier(field);
>  }
>  #define field_max(field)       ((typeof(field))field_mask(field))
> +
> +/**
> + * u32_encode_bits() - prepare a u32 bitfield element (non-const)
> + * @v: value to put in the field
> + * @field: shifted mask defining the field's length and position
> + *
> + * Equivalent of FIELD_PREP() for u32, field does not have to be constant.
> + *
> + * Note that the helper is available for other field widths (generated below).
> + */
> +static __always_inline __u32 u32_encode_bits(u32 v, u32 field)
> +{
> +       if (__builtin_constant_p(v) && (v & ~field_mask(field)))
> +               __field_overflow();
> +       return ((v & field_mask(field)) * field_multiplier(field));

Unfortunately gcc emits actual divisions or __*div*() calls, and
multiplications in the non-constant case.

So I don't think this is suitable as-is.

> +}

[1] https://lore.kernel.org/all/20250214073402.0129e259@kernel.org
[2] https://lore.kernel.org/all/CAMuHMdU+0HGG22FbO3wNmXtbUm9RhTopYrGghF6UrkFu-iww2A@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

