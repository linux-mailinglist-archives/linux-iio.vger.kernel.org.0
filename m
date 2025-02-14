Return-Path: <linux-iio+bounces-15515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECEDA35B95
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 11:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9281880368
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871625A2C2;
	Fri, 14 Feb 2025 10:28:29 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0DA2566D9;
	Fri, 14 Feb 2025 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528909; cv=none; b=mj6mTPPMApo8pLe1pqx3U+58+BtMLbOpVEOcCbSNpUDoqL1DxJLLIGCn5HL/wFtdnrdWFONWSRcrhiw4H0+O+wHQruKfGl6JOwMasaRw2X0WMMu8XhseNdeAaHqkDggTUVKfrbsa1fMHyMj0ShlIwPj29/6B4VNWaaMQOg8WtTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528909; c=relaxed/simple;
	bh=HkXvzUaZbtDUm8GieM/LwNsjaKwR4/lhnzAFeAhmDrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmdiS7keOswVj4AfZw3c2KvgSKWGBQO637g6s2uuI3+7jVe3WMIVAxIVzTG/VVwI3kKQq/ev9CSn/G6F3NwXYPFdThiqw5qGslwHmFuixZkK06cDmFzj7cMbj3WgXr51/WkEUMmagCTiv8L65SQlSBMycEqg1k3Cc8W23raFnOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-860f0e91121so1845440241.0;
        Fri, 14 Feb 2025 02:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739528905; x=1740133705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DD+ssK7Im57vlq5FNxfqHbbrTwFIXn9O88i3TIuD0PI=;
        b=JbVhTfhGIYpojq17+W3u20mUpdAIWWa1tvL4aQBZvD5MOixxF0gd76szsgG+4XFFxq
         KJUViOlXbQEjcxpG0ejfDb+tQW6MFc4a8bS5wttuEa2YQNfkPrELPMAYpmghgbUO/bj5
         jz7dBuvEoD7oL1uJk9aj7iVIOndUfIbgB5UQXN83rBaN0lAU7PQ8TEwUjITv9TA4+gLO
         oniK6iGtyjEsitwFVJArLKTJQutFImCpIRISIV2llKaZYlyeYkqxfFqLRiIXwmN1se1/
         4L99p+Im9KuLXbnnjm4Owv65kXA5apMtE3kXQDHnxjrlRQu5fumDCzYRef32AjM7XrRQ
         BOCw==
X-Forwarded-Encrypted: i=1; AJvYcCUiUJoL4Te2VEpWU/yQa7sVUMW2hHtCmLMsB1ToztS+oaoJ92njwbVKJk3wa5Z4u+yiVVxAl8vFPIVxJA==@vger.kernel.org, AJvYcCUmtUW8i/iSLUVtPFWatyZ0ObM1dl9jrrsaKbOXwwxOdsowyRk061J2ew/s665cR6jFbcizxl/uVTeH57eyhibRSmc=@vger.kernel.org, AJvYcCVIdu2RAPbLpLdTDnaSJGokcrkyS20fbX1oSeD0yxPSIAx9tV04LXkZXdkp6XBj4GIg4rpOMGNZmRY=@vger.kernel.org, AJvYcCVJRSGV00Zv+SHULWlOSMW3zXPH7WHewzk0HL8mYg9671/QDjUrKVI4+Ntqz4FuD1W4jMjl8IfOgZvMDG8=@vger.kernel.org, AJvYcCWrnCmcSAl9CLRHHVDX3fDXsw80SSwG28aXYrVsA0CpNktNGVypWaFzVJMon+ufQDmSKxBS+JdeIuAz5mkv@vger.kernel.org, AJvYcCX6l/8UDRHSDx53Ctx/ixmxGgz/BaPJG2EmLM6bwUTip4PJIXv+6HoczPGOSOJqOAG6LGKoo8baZPb8EBrA@vger.kernel.org, AJvYcCXCj2vR9py3dXnUBl04GVleSZLzKmRENp8KLA0GNe76CsuUp2e5YMvk/bHFK5nT1nkYzPy8G6ca/JQ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9yXDe2TKk0lQAX4OTIuw9bmRgkZTuLrN+4yXr/x5e2W9aAegn
	S1qh7i9dIWkITfkNLavNK1YuKaA8+3w1BbPAzfvAgJmP0arYYXMtKZ3lODBf3AE=
X-Gm-Gg: ASbGncvg8pD+bUzAkA0HzoNw9JD8pTlc6echtP509S0Y1e699xTFPYMcOqDGeB+NYM9
	hx4DV4zbpWmEwQNv2fwixwkswJiRa/8KU9QYA0SiFwWgyrpMwoEJXFWhvfrFXVC4r8KYOpgI3mN
	wz0I2AZqSizGNn8fLzFkQKErsXUWGnHA0q9Q2qHPYhGESPDz1j2Zk0qrXrtZiyBDVC65+XJ4lvu
	oVnZmNMNbG1sk67TxgnT5MOny5/nXP2aNXXtcA8C9UPM3Rz+49xRFfIXXf4TDlqUA8QuvFpoWri
	w7oneVIHYAS/iMMY5J8FwSCQ1g10NW7uB/lV4oJWiJ5Nl7ITA2QikQ==
X-Google-Smtp-Source: AGHT+IEKiaeKBRzxQM/1KzXGMyx9lWg1nfN6iTMlWnWde3zYMMm0H/7R4uLfb2ckogPdFqw+4MzbMA==
X-Received: by 2002:a05:6102:2749:b0:4bc:1600:7c43 with SMTP id ada2fe7eead31-4bc16007c6emr1580769137.11.1739528905455;
        Fri, 14 Feb 2025 02:28:25 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e8548ae3sm536863241.2.2025.02.14.02.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 02:28:23 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4bbb56bbbd4so1807993137.1;
        Fri, 14 Feb 2025 02:28:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUc0a1xwQlaItPr0wtGa1oeiIwsW9tLZxbCg9TCVDEzNu+tcmwcm3P3oSQL+8pCDUeuKpcsJXWpc2vfdA==@vger.kernel.org, AJvYcCVT0vFtgOAjXIh/vHIRUzTJjRfPpJW2rmAuhWico4cTIvb9kEVchR5BEXctXcMRJzLk5xljXQ/cEO0J+gt7YnuePvw=@vger.kernel.org, AJvYcCVm6dS2hGkD8R7mdOq3zjxhAvBBN8H02AMCYWNDf8porsnq8pXkEOynDIX1PHB1iyqCODPwJE8AJVeEivRv@vger.kernel.org, AJvYcCVz9wDj1/rGI1N2FrU7m5AwWJjcqWx+0k7eWeVgALrDdAuXtjLn0ZIDBsXhnVtT7uyGxxP7CZdyG8M=@vger.kernel.org, AJvYcCWI5mKmLluJ4VLIneptFo+ykZtQEi0N3ppigqCNpNCjpcF4znltj5hzBy2o9UFi4+PNInP83hvodxovWf92@vger.kernel.org, AJvYcCWQaYPQ0bl9aPNyVn3be+sK10ytEBG1GesH/1+sLsXvx8xk6rcgzhrFJ0O97QmTF258zsm2lsioFQ6V@vger.kernel.org, AJvYcCWZ95hd1DxtIm1cWw+V33v3fhOFYpAOvSR8lUrrKUjVK9NmFMyscF7JRWTRwJCOd4ncjS+04+Yrvrwk0RI=@vger.kernel.org
X-Received: by 2002:a05:6102:50a4:b0:4bb:ceeb:eaca with SMTP id
 ada2fe7eead31-4bc04dc0ad2mr4618891137.1.1739528903305; Fri, 14 Feb 2025
 02:28:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738329458.git.geert+renesas@glider.be> <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
 <20250131190335.4c18fb3c@pumpkin>
In-Reply-To: <20250131190335.4c18fb3c@pumpkin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Feb 2025 11:28:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVP+GBFMfd-C_7oiXHKSbycPv6adxJdM-Kt03+m9UqDiw@mail.gmail.com>
X-Gm-Features: AWEUYZm97sUT3mKi6JQWzWdUxKryfF3L2VZZmMQJHiBs0ICC7K3YkCuZ7Ruhdt0
Message-ID: <CAMuHMdVP+GBFMfd-C_7oiXHKSbycPv6adxJdM-Kt03+m9UqDiw@mail.gmail.com>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
To: David Laight <david.laight.linux@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	qat-linux@intel.com, linux-gpio@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Fri, 31 Jan 2025 at 20:03, David Laight <david.laight.linux@gmail.com> wrote:
> On Fri, 31 Jan 2025 14:46:51 +0100
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
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
> ...
> > diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> > index 63928f1732230700..c62324a9fcc81241 100644
> > --- a/include/linux/bitfield.h
> > +++ b/include/linux/bitfield.h
> > @@ -203,4 +203,38 @@ __MAKE_OP(64)
> >  #undef __MAKE_OP
> >  #undef ____MAKE_OP
> >
> > +/**
> > + * field_prep() - prepare a bitfield element
> > + * @_mask: shifted mask defining the field's length and position
> > + * @_val:  value to put in the field
> > + *
> > + * field_prep() masks and shifts up the value.  The result should be
> > + * combined with other fields of the bitfield using logical OR.
> > + * Unlike FIELD_PREP(), @_mask is not limited to a compile-time constant.
> > + */
> > +#define field_prep(_mask, _val)                                              \
>
> You don't need an _ prefix on the 'parameters' - it doesn't gain anything.

I just followed the style of all other macros in this file.
I can add a new patch converting the existing macros, though...

>
> > +     ({                                                              \
> > +             typeof(_mask) __mask = (_mask);                         \
>
> Use: __auto_type __mask = (_mask);

Likewise ;-)

> > +             unsigned int __shift = sizeof(_mask) <= 4 ?             \
> > +                                    __ffs(__mask) : __ffs64(__mask); \
> > +             (((typeof(_mask))(_val) << __shift) & (__mask));        \
>
> There are a lot of () in that line, perhaps:
>
>                 __auto_type(__mask) = (_mask);
>                 typeof (__mask) __val = (_val);
>                 unsigned int __shift = ...;
>
>                 (__val << __shift) & __mask;
>
> Note the typeof (__mask) - avoids line-length 'bloat' when the arguments are non-trivial.

OK, thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

