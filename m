Return-Path: <linux-iio+bounces-25340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23838BFB4DA
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 12:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C96E189B7AA
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C284119CC28;
	Wed, 22 Oct 2025 10:07:08 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39083195F7
	for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127628; cv=none; b=YCziHoSWyM0qLNWZVfoY9IvFC86CRmELwQYnfP9zCA8JNO+7da/VfwzDkcbSEFI/RKJAxCsMaARLT6rb/EyAGvBN1sHugIOl4HukijatPVo5lG6dwvK7fSpWKfC6nA9v2L25kFDwrNEw9MeDjiHQwWI31cYUXA4qi0D584mu90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127628; c=relaxed/simple;
	bh=n8auG5eKlZyr31ot6Kp1D+Gj8aLD/n7p+Qqeh5TWnJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldR6yaPyZqj6Q5GiC3scUyuESYkW2bYghY3tyOZU8fdpx8PJEGf3eFiG3WomtMOjEMtHfDdt7y9l9puByj3gtnxaUW2yb4yd1DM/vthH59+cjqOWiO4A376jDCer07X+qK/WuhYNGjRon9Jcs6uatIiKRyZB/o0UeTvI5o1jtQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88fa5974432so879980185a.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 03:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127623; x=1761732423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEJ/AcXuMMrQoXRwb6HmCfF3LFX3cn+TJWCKJF/dV3w=;
        b=Xjd4v9LbP5y7D0VeZRJ66gpvelRDacbH8wrRMhNl+98TDo6znDsKy9Q/xEcAVMpuwV
         sh9ASu8OnraC0sEvoh8ktqSPcz++pZG8m0C7Au4sO9HR2kfHlSM5lmtO0O3QIxXc/NKj
         E9+IriXPDoAJouREAMPFS9qjpHaPGMoWrnnBrT2A55tb4HtUDEH0cb9B+u7yZ/p+CvQT
         JbP3tHZ7Cx7LPTIlJmlD0wUPmbepfi/bnL6GMB9Vv0I5KP0UXank0bKvB4P7+Wr44+wq
         vGqDJ3CVOousraYgd0RgtIUlkCCrQLZdFtHj3j9UBHqP/kXRdCK50Dt1BlvgqZFnPlRH
         /FRw==
X-Forwarded-Encrypted: i=1; AJvYcCXr+ViH/YxJ5RyqnGEBzKdMBkLY/hl6TQxmoe4ZCjG6+EXgfKs6oi0aIqkFHEh1wYkyNddUs/sRBeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9nn1uOnuCla2qPQBGR6HeasHsJ3D4k5Qp3yFrUiO+hhg2UQN4
	nOTpmB6kk5TN48nDxzKRbY2N0v5mcmAYB4zS8V9yd+06JyKqBQUJj0u8lRxIconn
X-Gm-Gg: ASbGncviG667Kv2Wf1KkgbPuW6TnqrPgXQD73xcXnAumxcNt4MH4Ppmp3Gf+7EGNrO6
	/5oA6Z2q1lkLtCHLEWt9VzVMacNj6jsg5GcCqHfNtLDBb0miTlewyax/Y3yvzj75j0Ogpk8uANo
	rFtaBjMejJfMzAO7GeQceE0gh2iP8By27hFOw1nahuR9oabU9sxGbAo9UKr612XKqTi/L1CAM2d
	2wR6/sPEYqvG9kYb567XBWuSAmxnHolsu44MzaMNDqSQ6Gy7vjDt6lNhq+wqPJ5rDabpc4515yI
	E6Oe1ctgL3CWtG2P9Xi0aCbCI0IwB3yNR1Ak6IGMhjdFeRSpQtan6DwPr59FvloHfCPI9b8ENfn
	4jfbgIgo3ePbfZ4gebqkHyLXbrJIypEfYwcrAmW0Ysu7Eb2vG91n46Umsre9lmeWx6vTsTLbluz
	vAuDinB29o+Uibo+JUCxJYDIU84X1YzXYEK5GRhRMC7Hek+qj8
X-Google-Smtp-Source: AGHT+IFZ2rN1YKaASY/sAmAlfxtLX+ZlLOPBj8r8oQHKkCbG0V81Ko5TfLp36QoyzIUNkolZWVe4Pg==
X-Received: by 2002:a05:620a:4488:b0:84d:f2b:ae9a with SMTP id af79cd13be357-8906dfdef7fmr2387687785a.11.1761127623034;
        Wed, 22 Oct 2025 03:07:03 -0700 (PDT)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cd6717desm940306485a.26.2025.10.22.03.07.02
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 03:07:02 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-87c11268b97so98621236d6.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 03:07:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQPiPYCsplWKvTUX+2qdZ1MPQSHr7uhC0myN3zLfwYcLIVdvOOAxgTV7zMTXGZ0kWJ0tae5KQOLyI=@vger.kernel.org
X-Received: by 2002:a05:6102:3f49:b0:5d6:615:a687 with SMTP id
 ada2fe7eead31-5d7dd5544d6mr5930459137.7.1761127308820; Wed, 22 Oct 2025
 03:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760696560.git.geert+renesas@glider.be> <67c1998f144b3a21399672c8e4d58d3884ae2b3c.1760696560.git.geert+renesas@glider.be>
 <aPKQMdyMO-vrb30X@yury> <CAMuHMdXq7xubX4a6SZWcC1HX+_TsKeQigDVQrWvA=js5bhaUiQ@mail.gmail.com>
 <aPhbhQEWAel4aD9t@yury>
In-Reply-To: <aPhbhQEWAel4aD9t@yury>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Oct 2025 12:01:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUOX=ToDU_44fHrqKWUtee1LKpgisfTKOe4R33er9g+DA@mail.gmail.com>
X-Gm-Features: AS18NWAJp5tYw_pRqlFhPyJqRT3wi5ZG4jspqrcr0Xp9hgyi6lbaoTACOgNkevQ
Message-ID: <CAMuHMdUOX=ToDU_44fHrqKWUtee1LKpgisfTKOe4R33er9g+DA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] bitfield: Add non-constant field_{prep,get}() helpers
To: Yury Norov <yury.norov@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
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
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Yury,

On Wed, 22 Oct 2025 at 06:20, Yury Norov <yury.norov@gmail.com> wrote:
> On Mon, Oct 20, 2025 at 03:00:24PM +0200, Geert Uytterhoeven wrote:
> > On Fri, 17 Oct 2025 at 20:51, Yury Norov <yury.norov@gmail.com> wrote:
> > > On Fri, Oct 17, 2025 at 12:54:10PM +0200, Geert Uytterhoeven wrote:
> > > > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > > > constants.  However, it is very common to prepare or extract bitfield
> > > > elements where the bitfield mask is not a compile-time constant.
> > > >
> > > > To avoid this limitation, the AT91 clock driver and several other
> > > > drivers already have their own non-const field_{prep,get}() macros.
> > > > Make them available for general use by consolidating them in
> > > > <linux/bitfield.h>, and improve them slightly:
> > > >   1. Avoid evaluating macro parameters more than once,
> > > >   2. Replace "ffs() - 1" by "__ffs()",
> > > >   3. Support 64-bit use on 32-bit architectures.
> > > >
> > > > This is deliberately not merged into the existing FIELD_{GET,PREP}()
> > > > macros, as people expressed the desire to keep stricter variants for
> > > > increased safety, or for performance critical paths.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Acked-by: Crt Mori <cmo@melexis.com>
> > > > ---
> > > > v4:
> > > >   - Add Acked-by,
> > > >   - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
> > > >     power management debugfs helper APIs") in v6.17-rc1,
> > > >   - Convert more recently introduced upstream copies:
> > > >       - drivers/edac/ie31200_edac.c
> > > >       - drivers/iio/dac/ad3530r.c
> > >
> > > Can you split out the part that actually introduces the new API?
> >
> > Unfortunately not, as that would cause build warnings/failures due
> > to conflicting redefinitions.
> > That is a reason why I want to apply this patch ASAP: new copies show
> > up all the time.
>
> In a preparation patch, for each driver:
>
>  +#ifndef field_prep
>  #define field_prep() ...
>  +#endif
>
> Or simply
>
>  +#undef field_prep
>  #define field_prep() ...
>
> Then add the generic field_prep() in a separate patch. Then you can drop
> ifdefery in the drivers.
>
> Yeah, more patches, but the result is cleaner.

And we need 3 kernel releases, as the addition of the macros to
the header file now has a hard dependency on adding the #undefs?
Unless I still apply all of them to an immutable branch, but then what
is the point?

> > > > --- a/include/linux/bitfield.h
> > > > +++ b/include/linux/bitfield.h
> > > > @@ -220,4 +220,40 @@ __MAKE_OP(64)
> > > >  #undef __MAKE_OP
> > > >  #undef ____MAKE_OP
> > > >
> > > > +/**
> > > > + * field_prep() - prepare a bitfield element
> > > > + * @mask: shifted mask defining the field's length and position
> > > > + * @val:  value to put in the field
> > > > + *
> > > > + * field_prep() masks and shifts up the value.  The result should be
> > > > + * combined with other fields of the bitfield using logical OR.
> > > > + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
> > > > + */
> > > > +#define field_prep(mask, val)                                                \
> > > > +     ({                                                              \
> > > > +             __auto_type __mask = (mask);                            \
> > > > +             typeof(mask) __val = (val);                             \
> > > > +             unsigned int __shift = sizeof(mask) <= 4 ?              \
> > > > +                                    __ffs(__mask) : __ffs64(__mask); \
> > > > +             (__val << __shift) & __mask;    \
> > >
> > > __ffs(0) is undef. The corresponding comment in
> > > include/asm-generic/bitops/__ffs.h explicitly says: "code should check
> > > against 0 first".
> >
> > An all zeroes mask is a bug in the code that calls field_{get,prep}().
>
> It's a bug in FIELD_GET() - for sure. Because it's enforced in
> __BF_FIELD_CHECK(). field_get() doesn't enforce it, doesn't even
> mention that in the comment.
>
> I'm not fully convinced that empty runtime mask should be a bug.

Getting (and using) data from nowhere is a bug.
Storing data where there is no space to store is also a bug.

I will add a comment.

> Consider memcpy(dst, src, 0). This is a no-op, but not a bug as
> soon as the pointers are valid. If you _think_ it's a bug - please
> enforce it.

memcpy() with a fixed size of zero is probably a bug.
memcpy() with a variable size is usually used to copy "as much as is
needed", so zero is usually not a bug.

> > > I think mask = 0 is a sign of error here. Can you add a code catching
> > > it at compile time, and maybe at runtime too? Something like:
> > >
> > >  #define __field_prep(mask, val)
> > >  ({
> > >         unsigned __shift = sizeof(mask) <= 4 ? __ffs(mask) : __ffs64(mask);
> > >         (val << __shift) & mask;
> > >  })
> > >
> > >  #define field_prep(mask, val)
> > >  ({
> > >         unsigned int __shift;
> > >         __auto_type __mask = (mask), __ret = 0;
> > >         typeof(mask) __val = (val);
> > >
> > >         BUILD_BUG_ON_ZERO(const_true(mask == 0));
> >
> > Futile, as code with a constant mask should use FIELD_PREP() instead.
>
> It's a weak argument. Sometimes compiler is smart enough to realize
> that something is a constant, while people won't. Sometimes code gets
> refactored. Sometimes people build complex expressions that should
> work both in run-time and compile time cases. Sometimes variables are
> compile- or run-time depending on config (nr_cpu_ids is an example).
>
> The field_prep() must handle const case just as good as capitalized
> version does.

OK, I will add the (build-time) check.

> > >         if (WARN_ON_ONCE(mask == 0))
> > >                 goto out;
> > >
> > >         __ret = __field_prep(__mask, __val);
> > >  out:
> > >         ret;
> > >  })
> >
> > Should we penalize all users (this is a macro, thus inlined everywhere)
> > to protect against something that is clearly a bug in the caller?
>
> No. But we can wrap it with a config:
>
>  #ifdef CONFIG_BITFIELD_HARDENING
>          if (WARN_ON_ONCE(mask == 0))
>                  goto out;
>  #endif

That can be done later, when hardening other bitfield functions
and macros.

> > These new macros are intended for the case where mask is not a constant.
> > So typically it is a variable of type u32 or u64.
>
> You never mentioned that. Anyways, it's again a weak argument.

I'll add more comments ;-)

> > > > +             unsigned int __shift = sizeof(mask) <= 4 ?              \
> > > > +                                    __ffs(__mask) : __ffs64(__mask); \
> > >
> > > Can you use BITS_PER_TYPE() here?
> >
> > Yes, I could use BITS_PER_TYPE(unsigned long) here, to match the
> > parameter type of __ffs() (on 64-bit platforms, __ffs() can be used
> > unconditionally anyway), at the expense of making the line much longer
> > so it has to be split.  Is that worthwhile?
>
> Not sure I understand... The
>
>         "unsigned int __shift = BITS_PER_TYPE(mask) < 64 ?"
>
> is 49 chars long vs 42 in your version. Even if you add two tabs, it's
> still way below limits. And yes,

Oh, you meant instead of the size check.
I thought you objected to the hardcoded number 4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

