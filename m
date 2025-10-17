Return-Path: <linux-iio+bounces-25187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502CDBE8366
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 13:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2F06E8129
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 10:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D98232AACA;
	Fri, 17 Oct 2025 10:55:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9EB32AAAE
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698518; cv=none; b=OX69s0HReRu77SSMVJpJ+BMeSA0jlq/6VCjOnqD93xxFQbciyCDLzunBj36mhju/6YccnSAG1iAm6Iw/efkmHeZQb7CjRbwLs+c/J/gd9e4M7S6JGNA79t0a/HNmOEiFoh7gdeMvP9zg91HJA957jx/5Jf3OjSF5QV5yBTi1TxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698518; c=relaxed/simple;
	bh=LrniXy6ZCFM530ZMtcnDRQn9pcEmCEynLCDVJ3AMIhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyBfpAYznBsfwifJaJ6sQ9SWiclDoT3ZX1AYl6GAbtiDLc+uBjgb1cCs5zvGq+ZUHirhuqpvW6wwG3735BAqwlaNNit1aXAAUCpCubs4z7qi6G8PrZu8/qUzS1tEwu5RgNtu0JlG5SnQtafQWLZr+r3rO7irXk8dJSfHjPu/NNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5d3fb34ba53so1398323137.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 03:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698513; x=1761303313;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCpfZFAx3hiLnczCJXcXTR7Dek411X8RRc+fD4xQf5M=;
        b=kF2uMgJoTeVU/RMAluZp8MdikMqKay28q11/z0kkH7J8hubwyymGWszOriTYUwbpjA
         IRuahkY6torbRlKQ7NXUyvcfIesfXowZtP8mQqRNDHNEq/4eBz6lLF5u29td4/EpnuG9
         q7UN0FYVg0xRg61WG4ueE4IIlvR6+Hj0utDb8CVTkN/I9D6MRJvvzK3K2Pvpezoh1euG
         kZDC76ogjQX/K8shO3Ul1UIT1QlquMV4EX2je4aMxne6DqTVIeBBAGfZVlbExSo8V1eZ
         3yWQ3JaoqQ+bwzfWccLW9xTFXk8S4laKAdQ09MXwkKC+z39Dtg/Iz2l3VRGYCWFv7aj0
         1wSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXK4eQfUXo+2nrIfVAQajXzooBiBfUJJ60VxDdknm2J4slLD70sDagZUb70TK1uM2OJu8scVEIiCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn7ehvJpl3l4P5Q0VI0XBIkuk/BXAqOioYOTDPl8nIU0Lv3+Yv
	vKUcOcLLkMpBeC2Wn+YLzZATEZz/BpJarAUgjj54TPoxftoarP+ePo4YLIOFEqzs
X-Gm-Gg: ASbGncsWg8S+FgrBDRYEfPqaa899okkyajXSDyFWadLLSQa6pfjnhBfyLc1bOJZ/+8R
	SyLzpjdiROhdxpMyaWeJ/JhXtP9gBZK0j3gK6wZNq6mroTuJzZ3/9mPzJlLC5ZJGOFrSb6L/H9e
	fL+KG/qrdIUeW1p2JwKlsaEp3uJbazrp3TtMJPneiubdBeS7CrAEy4uXo0fDXrUoPJ1Uw0rkXUL
	Zhy52NSiFM3Q4RIXQwy0Gjji5lyl/TaWB9EiaVVxLeDfRHvA2kWpvKzxtir+Qm+hqKCBNQRXxdU
	a8EhqNxx4t7yamWZ6UKdxMldO0Z3VYOCo5h84Q4gs+ZPYjTOQk6jGwuRsh5VPSZnlfWIecIBSFP
	bMMeuIiHJZSxQsvT9cB1Ge8J5zl6puIPo1mXmS1wnpvSLfSvHTIUjKrlryAYGKpM38gPLM2vxL7
	5Z3nTuyX+uwNtZcTXvXlGVUj+S9Xp91d+ROPqXGnb9mTtwrmZe
X-Google-Smtp-Source: AGHT+IHQ0WqsCVnHe3c67jmOP6ubh9epVu0IIH07bF565qblpAkkva6h4vCCRHH3cbADjhJa+oxKXA==
X-Received: by 2002:a05:6102:dcb:b0:5d5:ff4a:87fa with SMTP id ada2fe7eead31-5d7dd6f5c1fmr1240284137.43.1760698512928;
        Fri, 17 Oct 2025 03:55:12 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55634adad1asm2517056e0c.6.2025.10.17.03.55.11
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 03:55:11 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-580144a31b0so897429137.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 03:55:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7ePaufTowFIu/gel2rwTEt3NagewGDvafqgj2edbukvvgkBDPcFAHK57J5L6nV+HC6LTQiOLAV04=@vger.kernel.org
X-Received: by 2002:a05:6102:c49:b0:5a1:f09f:524e with SMTP id
 ada2fe7eead31-5d7dd59bcd6mr1313646137.16.1760698511065; Fri, 17 Oct 2025
 03:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739540679.git.geert+renesas@glider.be> <2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
 <20250214073402.0129e259@kernel.org>
In-Reply-To: <20250214073402.0129e259@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Oct 2025 12:55:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+0HGG22FbO3wNmXtbUm9RhTopYrGghF6UrkFu-iww2A@mail.gmail.com>
X-Gm-Features: AS18NWCjFk9wo7Q1aPnnkBYJzaq6xcQVQAXawyeid30N8a2RlJlAbXrKkziomTs
Message-ID: <CAMuHMdU+0HGG22FbO3wNmXtbUm9RhTopYrGghF6UrkFu-iww2A@mail.gmail.com>
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

On Fri, 14 Feb 2025 at 16:34, Jakub Kicinski <kuba@kernel.org> wrote:
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
> I really really think that people should just use the static inline
> helpers if the field is not constant. And we should do something like
> below so that people can actually find them.
>
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 63928f173223..e02afcd7aeee 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -156,6 +156,80 @@
>                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
>         })
>
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
> +}

Unfortunately gcc emits actual divisions or __*div*() calls, and
multiplications in the non-constant case.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

