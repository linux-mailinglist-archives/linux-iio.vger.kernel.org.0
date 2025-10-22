Return-Path: <linux-iio+bounces-25338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF20BBF9EDC
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 06:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D10F04ECDEA
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 04:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEFC20ADD6;
	Wed, 22 Oct 2025 04:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+8RY0mo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5227FD49
	for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761106828; cv=none; b=BmgknVTCNp22nz6srrc7FRWin8QFVa3wxrZUOFuGsbDyZJGPCZ3NeBT3Awar0uIKRdzKQ9zeueJ9o7n+zDSEgZgz5Ta/BrAOjzU4psB5ISie+5keJ9155AR6ItATdDRmIz6uPLmBGiEqXGroivMAwtwfWVSTJvBixlg0Of51jaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761106828; c=relaxed/simple;
	bh=2LvoX8vCx1tufVUw3MgzD/5yh2XJb4pcCLw0O06vvgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SARqUyu1BDVE337cz42RaCc295K8Cy0ET22aJ1cUHhD8xjIYwnsg3Wk64YI8C2VX841AmGlmrtOyfbFpqIj0M+QNtxxoaenn68YHUTHl9no5Nc//D2OfZVKvdPGho+CA+rlAjLQhWtUxylz9I3HJPIzsvvcw/NlCBMRObz1xdts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+8RY0mo; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-88e456972d5so1158257385a.3
        for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 21:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761106825; x=1761711625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ODhNpK7RnCdLY40s70BovQLD/n6xOeEpw27aGxRtg2g=;
        b=T+8RY0mo3meFeGrhtNs+SAdbYh9kG5VFitFWNSDnMij0o+QbhBGCv+rDwxpRy2qLYo
         EGWSBn2jnRpMcVRu20fkCv/jKd94mIw5/860KfVkpF6fKtKLAsB84FINpiplQt8Qa6NE
         Z/XXwywgxJCr6qlQ+RHmOhCzfzYbZ/0t4OV87C8hefJ9MhxIXWfVNccCP5EFzmsy+52R
         AE128zR2vcG1vjP4s1ExGkBra15uUU5wtN0ga3AYAcVnNaYIw9Hg5DmG82xlw5E9N0Yf
         GspTUqa8lXbptoM923M+LWCHz/kWUCqF94edYTHA4Vo6DX+J68qYSgvsV/O6wnh/ftM3
         WHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761106825; x=1761711625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODhNpK7RnCdLY40s70BovQLD/n6xOeEpw27aGxRtg2g=;
        b=IVuxOdaT/zZvipB59BoydTzD4eSuKv2m3AKW0URvjw/FUdPKi4jg2XGn9uU6R7e5h7
         e+IzRUp7LLGE+wIwSyRguWCywu2dQCAmCTVRelk3TY4nCV3Y5lXBWsEFMheHclj82oNO
         wOnUAOF2btc9zWGbyGyfTFUxOpi8wN3neISOBfFifV8arUUou5TZK5SJtn3Mzhc2vnw9
         CZ7ETNODYCa2dc8kxABSqQ58pzUPiPGOvnGPOpgZFwaMmHBXZMkDcds51V/vx85utFmI
         7jvOrZ26N+wCjKdtVU9lQ51wro57B0+XStOqJUfEe4gOsiaQqg1gjQs+KQnWbYaKULVq
         CVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc8qgVfU0EKJORiQJjGnqs0Pri/kguEtGZslmqnE5JQNkjx2Bw+gobpA61OTQ7q5tfI5z94z5tL/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOr+S1od7vnRdRbiPxIyXou/vBkk6qMHGkxKyxZdJ9pHvG8z9Z
	GkMuXyRutyfvLxxT/1a+epPRIl6UsW9lBYfbIFBlr8KotzItMyXXqXKV
X-Gm-Gg: ASbGncslriSimrxuid6GE14NUXknkM4AjpfA+vMoq7Yneo7Nbp8P33qRpx+nCEhFrse
	P++n7v+RdpCHoB7L+zoPes7yYqU1nT7127R89ZTIu/s/V0mlre5iVIIJEj1ykIcKlYVj9wiq9r0
	2doNRBd/m+44YGFrVyWQ3P3y4WLNtG6hAvB9hJr2cUEKE1+7xbKqFMtGeznY4+m064MRZo1vq3U
	0HZSSKDkJ/ZBId6Y99YCHqr3JGLmb2bdSba1I5ixcVfAM3FIftZy31/pTjoaMRU1g1nrgJW2Kaw
	ir1eYrYUDfzJUBLd1HNxZVMmgc3wR3ZBZCm9T4LXwvz2Zotc703lnMit1Fbb++m4AqGD/zwT72F
	1T3XUN/19iN1EVCvb5FAcozkbWveT3DH2HXrVWEv7pEFc4d5sj5FrBAdmHF1TnFN/AFWSPz1N
X-Google-Smtp-Source: AGHT+IFKpjZaqHyEdyKVtERVYcIxj+O15A9VpaXXOseaN7ns0Zwp6c8+X3yhxQ/MJYZF6q3dxlGylA==
X-Received: by 2002:a05:620a:170c:b0:891:81e2:fca8 with SMTP id af79cd13be357-89181e2fe2fmr1995019985a.69.1761106824637;
        Tue, 21 Oct 2025 21:20:24 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cfb56807sm902420985a.63.2025.10.21.21.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:20:23 -0700 (PDT)
Date: Wed, 22 Oct 2025 00:20:21 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>,
	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org, qat-linux@intel.com,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 2/4] bitfield: Add non-constant field_{prep,get}()
 helpers
Message-ID: <aPhbhQEWAel4aD9t@yury>
References: <cover.1760696560.git.geert+renesas@glider.be>
 <67c1998f144b3a21399672c8e4d58d3884ae2b3c.1760696560.git.geert+renesas@glider.be>
 <aPKQMdyMO-vrb30X@yury>
 <CAMuHMdXq7xubX4a6SZWcC1HX+_TsKeQigDVQrWvA=js5bhaUiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXq7xubX4a6SZWcC1HX+_TsKeQigDVQrWvA=js5bhaUiQ@mail.gmail.com>

On Mon, Oct 20, 2025 at 03:00:24PM +0200, Geert Uytterhoeven wrote:
> Hi Yury,
> 
> On Fri, 17 Oct 2025 at 20:51, Yury Norov <yury.norov@gmail.com> wrote:
> > On Fri, Oct 17, 2025 at 12:54:10PM +0200, Geert Uytterhoeven wrote:
> > > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > > constants.  However, it is very common to prepare or extract bitfield
> > > elements where the bitfield mask is not a compile-time constant.
> > >
> > > To avoid this limitation, the AT91 clock driver and several other
> > > drivers already have their own non-const field_{prep,get}() macros.
> > > Make them available for general use by consolidating them in
> > > <linux/bitfield.h>, and improve them slightly:
> > >   1. Avoid evaluating macro parameters more than once,
> > >   2. Replace "ffs() - 1" by "__ffs()",
> > >   3. Support 64-bit use on 32-bit architectures.
> > >
> > > This is deliberately not merged into the existing FIELD_{GET,PREP}()
> > > macros, as people expressed the desire to keep stricter variants for
> > > increased safety, or for performance critical paths.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Acked-by: Crt Mori <cmo@melexis.com>
> > > ---
> > > v4:
> > >   - Add Acked-by,
> > >   - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
> > >     power management debugfs helper APIs") in v6.17-rc1,
> > >   - Convert more recently introduced upstream copies:
> > >       - drivers/edac/ie31200_edac.c
> > >       - drivers/iio/dac/ad3530r.c
> >
> > Can you split out the part that actually introduces the new API?
> 
> Unfortunately not, as that would cause build warnings/failures due
> to conflicting redefinitions.
> That is a reason why I want to apply this patch ASAP: new copies show
> up all the time.

In a preparation patch, for each driver:

 +#ifndef field_prep
 #define field_prep() ...
 +#endif

Or simply

 +#undef field_prep
 #define field_prep() ...

Then add the generic field_prep() in a separate patch. Then you can drop
ifdefery in the drivers.

Yeah, more patches, but the result is cleaner.

> > > --- a/include/linux/bitfield.h
> > > +++ b/include/linux/bitfield.h
> > > @@ -220,4 +220,40 @@ __MAKE_OP(64)
> > >  #undef __MAKE_OP
> > >  #undef ____MAKE_OP
> > >
> > > +/**
> > > + * field_prep() - prepare a bitfield element
> > > + * @mask: shifted mask defining the field's length and position
> > > + * @val:  value to put in the field
> > > + *
> > > + * field_prep() masks and shifts up the value.  The result should be
> > > + * combined with other fields of the bitfield using logical OR.
> > > + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
> > > + */
> > > +#define field_prep(mask, val)                                                \
> > > +     ({                                                              \
> > > +             __auto_type __mask = (mask);                            \
> > > +             typeof(mask) __val = (val);                             \
> > > +             unsigned int __shift = sizeof(mask) <= 4 ?              \
> > > +                                    __ffs(__mask) : __ffs64(__mask); \
> > > +             (__val << __shift) & __mask;    \
> >
> > __ffs(0) is undef. The corresponding comment in
> > include/asm-generic/bitops/__ffs.h explicitly says: "code should check
> > against 0 first".
> 
> An all zeroes mask is a bug in the code that calls field_{get,prep}().

It's a bug in FIELD_GET() - for sure. Because it's enforced in
__BF_FIELD_CHECK(). field_get() doesn't enforce it, doesn't even
mention that in the comment.

I'm not fully convinced that empty runtime mask should be a bug.
Consider memcpy(dst, src, 0). This is a no-op, but not a bug as
soon as the pointers are valid. If you _think_ it's a bug - please
enforce it.

> > I think mask = 0 is a sign of error here. Can you add a code catching
> > it at compile time, and maybe at runtime too? Something like:
> >
> >  #define __field_prep(mask, val)
> >  ({
> >         unsigned __shift = sizeof(mask) <= 4 ? __ffs(mask) : __ffs64(mask);
> >         (val << __shift) & mask;
> >  })
> >
> >  #define field_prep(mask, val)
> >  ({
> >         unsigned int __shift;
> >         __auto_type __mask = (mask), __ret = 0;
> >         typeof(mask) __val = (val);
> >
> >         BUILD_BUG_ON_ZERO(const_true(mask == 0));
> 
> Futile, as code with a constant mask should use FIELD_PREP() instead.

It's a weak argument. Sometimes compiler is smart enough to realize
that something is a constant, while people won't. Sometimes code gets
refactored. Sometimes people build complex expressions that should
work both in run-time and compile time cases. Sometimes variables are
compile- or run-time depending on config (nr_cpu_ids is an example).

The field_prep() must handle const case just as good as capitalized
version does.
 
> >         if (WARN_ON_ONCE(mask == 0))
> >                 goto out;
> >
> >         __ret = __field_prep(__mask, __val);
> >  out:
> >         ret;
> >  })
> 
> Should we penalize all users (this is a macro, thus inlined everywhere)
> to protect against something that is clearly a bug in the caller?

No. But we can wrap it with a config:

 #ifdef CONFIG_BITFIELD_HARDENING
         if (WARN_ON_ONCE(mask == 0))
                 goto out;
 #endif

The real question here: do you want to help people to catch their bugs,
or you want them to fight it alone?

The _BF_FIELD_CHECK() authors are nice people and provide helpful guides.
(I don't insist, it's up to you.)

> E.g. do_div() does not check for a zero divisor either.
>
> > > +/**
> > > + * field_get() - extract a bitfield element
> > > + * @mask: shifted mask defining the field's length and position
> > > + * @reg:  value of entire bitfield
> > > + *
> > > + * field_get() extracts the field specified by @mask from the
> > > + * bitfield passed in as @reg by masking and shifting it down.
> > > + * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
> > > + */
> > > +#define field_get(mask, reg)                                         \
> > > +     ({                                                              \
> > > +             __auto_type __mask = (mask);                            \
> > > +             typeof(mask) __reg =  (reg);                            \
> >
> > This would trigger Wconversion warning. Consider
> >         unsigned reg = 0xfff;
> >         field_get(0xf, reg);
> >
> > <source>:6:26: warning: conversion to 'int' from 'unsigned int' may change the sign of the result [-Wsign-conversion]
> >     6 |     typeof(mask) __reg = reg;
> >       |                          ^~~
> >
> > Notice, the __auto_type makes the __mask to be int, while the reg is
> 
> Apparently using typeof(mask) has the same "issue"...
> 
> > unsigned int. You need to do:
> >
> >         typeof(mask) __reg = (typeof(mask))(reg);
> 
> ... so the cast is just hiding the issue? Worse, the cast may prevent the
> compiler from flagging other issues, e.g. when accidentally passing
> a pointer for reg.
 
Ok, makes sense.

> > Please enable higher warning levels for the next round.
> 
> Enabling -Wsign-conversion gives lots of other (false positive?)
> warnings.
> 
> > Also, because for numerals __auto_type is int, when char is enough - are
> > you sure that the macro generates the optimal code? User can workaround it
> > with:
> >
> >         field_get((u8)0xf, reg)
> >
> > but it may not be trivial. Can you add an example and explanation please?
> 
> These new macros are intended for the case where mask is not a constant.
> So typically it is a variable of type u32 or u64.

You never mentioned that. Anyways, it's again a weak argument.
 
> > > +             unsigned int __shift = sizeof(mask) <= 4 ?              \
> > > +                                    __ffs(__mask) : __ffs64(__mask); \
> >
> > Can you use BITS_PER_TYPE() here?
> 
> Yes, I could use BITS_PER_TYPE(unsigned long) here, to match the
> parameter type of __ffs() (on 64-bit platforms, __ffs() can be used
> unconditionally anyway), at the expense of making the line much longer
> so it has to be split.  Is that worthwhile?
 
Not sure I understand... The

        "unsigned int __shift = BITS_PER_TYPE(mask) < 64 ?"

is 49 chars long vs 42 in your version. Even if you add two tabs, it's
still way below limits. And yes, 

        unsigned int __shift = sizeof(mask) <= 4 ?               \
                                __ffs(__mask) : __ffs64(__mask); \

is worse than

        unsigned int __shift = BITS_PER_TYPE(mask) < 64 ?        \
                                __ffs(__mask) : __ffs64(__mask); \

> > > +             (__reg & __mask) >> __shift;    \
> > > +     })
> > > +
> >
> > When mask == 0, we shouldn't touch 'val' at all. Consider
> >
> >         field_get(0, get_user(ptr))
> >
> > In this case, evaluating 'reg' is an error, similarly to memcpy().
> 
> Again, a zero mask is a bug.
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

