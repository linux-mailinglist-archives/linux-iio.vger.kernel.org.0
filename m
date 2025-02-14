Return-Path: <linux-iio+bounces-15517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F331A35C30
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 12:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589B43AE03E
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B39261372;
	Fri, 14 Feb 2025 11:10:38 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932D25D539;
	Fri, 14 Feb 2025 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531438; cv=none; b=ftg4dXxg4D/TXtXtr3QT213O5Azw3ZtE+ciPKa2/v2QzcUcuIaAYxEM1L/lReYLm4GSe8oaNSwvgszIP8WFumruBktHlAOtxpaF0Q4SCq6hya8MjvaQjj0YbeinPKPqldQUVI1ndfKLrVXfHuZTu0h1vIh+O1mDaUqrK7sXv7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531438; c=relaxed/simple;
	bh=hdsgSjQQ8qgcIp8XrQEUL7+bx/XSkrcszbmnaoinpo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTACUON0S9b2/1hwURkwaq/Y/en56w2Ix+F3c0NaMa/4c3DKSJiGjD0nvrXNORXouKNJxvj8+FNhLxKhJe3KnT0qfoI+zpaxzPxaVyb/DW+2Z2H2hGVSuM85uvNqkgcsrrKyHsTXX7w3LoaOb70+WPSY1yaHQ/R+v4VwD7cXHpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3f3b93e4e32so1796708b6e.0;
        Fri, 14 Feb 2025 03:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739531435; x=1740136235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+/2I2hmbkU9zkmHuYX1t9oqaBOTTvF7uTNap3Wsbsk=;
        b=n+gFbF+9HQy32m63+iRfU7baomTogRZt8Q0x+8p1o1I9VNtjyMgiSGmrWFtaOCJWOx
         dbXd7ASszWZp7+nJFerhuQlESYXG1au5TAw8zwj0rnqkNbDHNjTW/zvBrVJgbh8jK5v+
         hTPxf4M+elrzhwfKUADHYwCg6zdPhc1FPuR9yoxDOSbNdZ/ZrYnkxfln5pEr0258OWP+
         ObRSjx7bTgA+uxEdA7EmOtmi6IUqhJkfbZSlWuVesMmpuqqmcxUBhvphOIzgD9SmpOr+
         Lwc1LYPyG4BnC15MkYla0AxiBBxq/3hmajbV0X6Xa6xu4p0DsZk7RSp79XKK2vc4ai+R
         R4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDVCUK6c/F3iml1NpIaVqopvbCyJAh8oxLb9I3BOXnjFJic1zL0taRowjbrVA1MN9gPwp4Ow3VqssDNqY=@vger.kernel.org, AJvYcCUbTOYIh1mG8TPX0Bi4c5rn5098w8UcKyqORjVAaFM6JCLn+hHFFsIHaVUAey5iUsTrMdJHJD1VP5m2@vger.kernel.org, AJvYcCUiHv7z7osjvN7WSDwCff0AV7rGVxgWHrJvyZ9rTEQKdFwO6pTmPaQfAIoLZDiUUPvNRm7eYV0CP3U=@vger.kernel.org, AJvYcCVKS/5ZYXsPcouogUjX1/7d56V4NXP/ZjViLwkHqpkfOss36i9fu9SRTbrEmpmaWJPmKDlOCowPguWnDfof@vger.kernel.org, AJvYcCVguviZY4vRnP70NorWp75Xw2fv1Z+mhtQ7r/c2apzkZCIQeecTjcRkaiJlyVgLCQFH0O4os6pGlYjO7xOcHtk83Y8=@vger.kernel.org, AJvYcCW5cx1lF5pOHqZKo0CKzLdtS/2tTkQ6kcS3kq/p/UyobKPe/lUIHCDmYAQxQPsWHXXO8AV9FC2r+Q853Q==@vger.kernel.org, AJvYcCWnpjvqjCh5ARprm5JFHRwhBOZw3EWQkHBoFYxXJRJFUA8O2rUsa4QoCi2nZTZVKsp5NHQFDhR8yHSAhCCq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6f0rdew3/WcRh9++9RoN6tQciQDyRPIlq7sLsYoQfh066Cs8g
	Mc0oOV5ObrC61jrHfYNxtQuyyPVwW88b2iJhchQVVmOUJIQawZk50r4Pyts8Tp0=
X-Gm-Gg: ASbGncvRkLVEyhKe5BvrB7ocx1yBnp4UQJczt0gdj48+Ag/O7lqsGg/ePTEm1kgz3c0
	p3RJHBPUXeN8tSav7dtbLxFOJWGeOr0WVXhfOP6ITcqod3O6QC3CtR557+tbHvpKoFjUcSzMaXZ
	AeqtIXfz7q7Y6TKq0TFL9I8quBxoQkeLzI04g/Ec8PUB70GM0TrYmX44/DgwLPu6R3RHTTPxHCf
	djR4v9ZsrpWL6gwYqW4KN1lmRXKWW7zWH7pUWTxavgT8zJHZR/P0rYWqWoXGDrqA8F4gNRZqa4t
	CB+P+cFPzq4PT0nIHeCdhOREwjqDTcQj71p5JtdawaCDM4Tk4l0PKA==
X-Google-Smtp-Source: AGHT+IEmOpncqw55JDATPBMdgoevFZbTsL+l4QREB3q5EOlWtwZuqK0wyAgTzC8TAmqM9FoNpjSQ/g==
X-Received: by 2002:a05:6808:2508:b0:3f3:b97d:769e with SMTP id 5614622812f47-3f3d90dc9b8mr4185959b6e.7.1739531435211;
        Fri, 14 Feb 2025 03:10:35 -0800 (PST)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com. [209.85.160.51])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3daa1a4b8sm1191927b6e.49.2025.02.14.03.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 03:10:34 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2bc607b3190so788701fac.1;
        Fri, 14 Feb 2025 03:10:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUy1lu/GJ6ERAmnfIqzVmu3C/Md9NgZanbZ9AlBkuxSikVLdWVTmv16zY9OytdJ9x+1bOD1xBdZoVtQDc2H@vger.kernel.org, AJvYcCVgqycNxfL55R6c69VsRIV//3UbVnRy1LsM6IXcdNZYTodYYbT5innUZI6qyiaXzFTDRrBAWAEYH0aK@vger.kernel.org, AJvYcCVpGAmsVWktjDWORoOa8SWbZwR93fR8IPXy2OueOJIEQibrvap3HctBV43GhtrSUSFdRoQjJT5SbI6afK3k8MmVtH0=@vger.kernel.org, AJvYcCWWolf/nrJ/6oXgSTgl4K14aY2GU29mdny1O3QmYSTUlOy83g0aI8cAUH46uNcAE8RT4WEzhyw79zid0g==@vger.kernel.org, AJvYcCWpxs59d1sDbltZAD01S8wzlCfefYW8qP+/tZshXhdVgrZs0TFBeWYfiGZaBJEEMeoH8TTdo0ifxNACHlY5@vger.kernel.org, AJvYcCXjdZfphJOJxdL4qtr/C2vSJUbLZss3zvveDNYzH/+JwLUMPqZ4sgGhNUqedcDrwir7VegLfNqsyVQ=@vger.kernel.org, AJvYcCXnbvOjDVxkbOaz9rzFBCQak2a0XzV/FMhTNT9F6vcz8d4anXpU42wkjTw7eso94fv0n53k7Wnu03YBCgE=@vger.kernel.org
X-Received: by 2002:a05:6102:829:b0:4bb:c670:7ef4 with SMTP id
 ada2fe7eead31-4bc04dbedfdmr3900426137.3.1739531008576; Fri, 14 Feb 2025
 03:03:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738329458.git.geert+renesas@glider.be> <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr> <Z5-xMUqrDuaE8Eo_@thinkpad>
 <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net>
 <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr> <CAMuHMdXZKNtAmiMP8uuSngZMsDLGcYwrLS0xNWzN4UfLaccdyA@mail.gmail.com>
 <16e1568d-8747-41e0-91b9-ce23c5592799@wanadoo.fr> <Z6DzQHebEKBb12Wo@thinkpad>
In-Reply-To: <Z6DzQHebEKBb12Wo@thinkpad>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Feb 2025 12:03:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVFG57rUVC-XXk6bsZupVTeV0YAcue=zKWGnm4owjDiEA@mail.gmail.com>
X-Gm-Features: AWEUYZnx82TO-9m0J2Kj8kCR7cxX7DuFclptN97k0_3_zHZhXPo2iBI5bXbywtI
Message-ID: <CAMuHMdVFG57rUVC-XXk6bsZupVTeV0YAcue=zKWGnm4owjDiEA@mail.gmail.com>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
To: Yury Norov <yury.norov@gmail.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	qat-linux@intel.com, linux-gpio@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alex Elder <elder@ieee.org>
Content-Type: text/plain; charset="UTF-8"

Hu Yury,

On Mon, 3 Feb 2025 at 17:48, Yury Norov <yury.norov@gmail.com> wrote:
> On Tue, Feb 04, 2025 at 12:41:55AM +0900, Vincent Mailhol wrote:
> > On 03/02/2025 at 22:59, Geert Uytterhoeven wrote:
> > > On Mon, 3 Feb 2025 at 14:37, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> > >> On 03/02/2025 at 16:44, Johannes Berg wrote:
> > >>> On Sun, 2025-02-02 at 12:53 -0500, Yury Norov wrote:
> > >>>>> Instead of creating another variant for
> > >>>>> non-constant bitfields, wouldn't it be better to make the existing macro
> > >>>>> accept both?
> > >>>>
> > >>>> Yes, it would definitely be better IMO.
> > >>>
> > >>> On the flip side, there have been discussions in the past (though I
> > >>> think not all, if any, on the list(s)) about the argument order. Since
> > >>> the value is typically not a constant, requiring the mask to be a
> > >>> constant has ensured that the argument order isn't as easily mixed up as
> > >>> otherwise.
> > >>
> > >> If this is a concern, then it can be checked with:
> > >>
> > >>   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask) &&
> > >>                    __builtin_constant_p(_val),
> > >>                    _pfx "mask is not constant");
> > >>
> > >> It means that we forbid FIELD_PREP(non_const_mask, const_val) but allow
> > >> any other combination.
> > >
> > > Even that case looks valid to me. Actually there is already such a user
> > > in drivers/iio/temperature/mlx90614.c:
> > >
> > >     ret |= field_prep(chip_info->fir_config_mask, MLX90614_CONST_FIR);
> > >
> > > So if you want enhanced safety, having both the safer/const upper-case
> > > variants and the less-safe/non-const lower-case variants makes sense.
>
> I agree with that. I just don't want the same shift-and operation to be
> opencoded again and again.
>
> What I actually meant is that I'm OK with whatever number of field_prep()
> macro flavors, if we make sure that they don't duplicate each other. So
> for me, something like this would be the best solution:
>
>  #define field_prep(mask, val) \
>        (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))
>
>  #define FIELD_PREP(mask, val)                                         \
>          (                                                             \
>                  FIELD_PREP_INPUT_CHECK(_mask, _val,);                 \
>                  field_prep(mask, val);                                \
>          )
>
> #define FIELD_PREP_CONST(_mask, _val)                                  \
>         (                                                              \
>                 FIELD_PREP_CONST_INPUT_CHECK(mask, val);
>                 FIELD_PREP(mask, val); // or field_prep()
>         )
>
> We have a similar macro GENMASK() in linux/bits.h. It is implemented
> like this:
>
>  #define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
>  #define GENMASK(h, l) \
>          (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>
> And it works just well. Can we end up with a similar approach here?

Note that there already exists a FIELD_PREP_CONST() macro, which is
intended for struct member initialization.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

