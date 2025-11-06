Return-Path: <linux-iio+bounces-25970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACDFC3BEE7
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 16:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B40B46625E
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79BA333753;
	Thu,  6 Nov 2025 14:56:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16812EB860
	for <linux-iio@vger.kernel.org>; Thu,  6 Nov 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440978; cv=none; b=XCBQi7VeClbZiSKgU7xbN6+jc9QM7l7xTvDo7b0OvZqdEchoKd6yADUGuh9YOFh0vS7aE4qxHQ3eLqPIJNvBS7F4e7eZx88kRM7NDAERqTeAlQQeN8QWrOf67gFCxB/imiiSg36IScURiAsrcM8yI1q9zOfzJQYIr1yqLA+Euds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440978; c=relaxed/simple;
	bh=HaefBq/9gx/xpe6H9SR+jXE6I2U49/Bi4dkyZMOckp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbynixjPgl8kU9zhMUTtCfdoS51XsfqrXpmHLFmhvtLTIAiid3aOUKlxGe62/pjlMGx+JBavW19DP70ae2FGBy2HaOf63C4QQ+vGUynriKo8+JbOpEd2gogUlYlVQCjMR+jDN6rxFvi/Y3cm0JhZA9h1Cd3oXPiU1N8FKAI5Q6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59431cce798so1166982e87.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2025 06:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440975; x=1763045775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxZVtMOHoNocoyXPFvfejRTHivuCeFc8a9lYqiVNw1Y=;
        b=pFMlSBDD59r3XwLv/k1NiGMDP3dJzfHBv0biDbeROG+iNcNq3NYOvLhguaEnEnxl7q
         VQTJH73fovLEU3x3fqDOmRRHZ4REpGxaf5SqUlzZyLGj2tVtOpCTQZjKUFAQN9bvjwAS
         eL4UhBasvWU1FAwuwYcx9pzZ2kWNMO60JhEEKjpvY7RRd1Iu8vMh+DD9QkLL7PKUl0nB
         4ACyR9w0cwb5vVb5igPBOFDmU4G5w+HpqKafeNeFztcozlGe+2To5UqQfO9U5Ow80XoO
         ILzfbyY1ZmoLqgLlBfM4DGNhN/oCu55ULTeY5CpRPC+w3/CdeKJWlXojrV/QFPALYrPO
         l6gg==
X-Forwarded-Encrypted: i=1; AJvYcCVVyu1IZZjCz5u9rGl7YuGLcvm084PRWPnvd6NTGtXKQctxcmkKRoieChB+/RyC+vmPfOApFor74/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt4723kaU7qV6uoQZCtDlVKS8JLMN+CkDQowvMKp2PiRgL/dIo
	2s16l0d35ihdwE4giGpQKUPv12aP69bFXF//KeSiNpFBIC6vsNl1yLlNvDBZCPvsvJU=
X-Gm-Gg: ASbGncs/L70+LZ5i5N5mXgg2zY2Bxe2Gxg/ZsiXBJ2jkWsgUBkOo72/2SRR8aQSy0js
	/V8sRR8glvPeraIAe0Hlj0EW3GuJ6uTYc161Gter7SPft/gzpSIS0VKtqmhYaTpMqDkdPnX+WRq
	ZbKwDv+zmLjKGDnb70OJ+UjWrW/9E4axR1qF1G4fR7P3kgPM08TE8e9Ls8m7tBEeBwcMQPESyWo
	kXMPh7soLAWMhxKOcaVjDQdYKuBcC3JcZ9LpCdBKz2Aon2tyucHQzf4R3Wq8THXSUCAGZj43PkT
	dsuBIdW90gcM17Vi/nJtn9vq/mFHU6FCE+NCh1skbMs1TmaoD19yj+llqn7PrtBOQ7RCiK3Bq3z
	sLB3tP7q3N3XYAu4Dvpj6nw2jcEtD+Qwg1VhITcqWnauxJ5PG2OMLWi/6CJTx+RtwCV4MX38NOy
	L/9vH8fPLCY8Hoo90xvqYthRE5EJwH92+vEB6HBsM1MrKJdf5+XZcpjMc75smVETA=
X-Google-Smtp-Source: AGHT+IEjNEneoCesAYL9vFc38yh3wggWw0c7ymbuxfOOCCevtgC/ofZHOmtg8Cj8G+KO8tic6bxuJQ==
X-Received: by 2002:a05:6512:402a:b0:560:9702:4fe6 with SMTP id 2adb3069b0e04-5943d755b01mr2569557e87.24.1762440974540;
        Thu, 06 Nov 2025 06:56:14 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0fdc90sm6472191fa.51.2025.11.06.06.56.13
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:56:13 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-375eff817a3so9813441fa.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2025 06:56:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWVXISozbSA6hRrNLRhfB2meZwpCcfIjV5L/Ya3b3nTc0gipw2Wt1rdHRhZDr2idxiUJcFOW3KuyM=@vger.kernel.org
X-Received: by 2002:a05:6402:1ed5:b0:640:b643:f3c5 with SMTP id
 4fb4d7f45d1cf-641058cf323mr7301623a12.16.1762440555932; Thu, 06 Nov 2025
 06:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762435376.git.geert+renesas@glider.be> <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com>
In-Reply-To: <aQy0T2vUINze_6_q@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 15:49:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
X-Gm-Features: AWmQ_bnZOzLGAFcWzxKh1EIKjH4MNs7moeVCtN8xGb6mN65nYBliBYrABdUBf0M
Message-ID: <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
Subject: Re: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
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
	Jianping Shen <Jianping.Shen@de.bosch.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, 
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Thu, 6 Nov 2025 at 15:44, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wrote:
> > The BUILD_BUG_ON_MSG() check against "~0ull" works only with "unsigned
> > (long) long" _mask types.  For constant masks, that condition is usually
> > met, as GENMASK() yields an UL value.  The few places where the
> > constant mask is stored in an intermediate variable were fixed by
> > changing the variable type to u64 (see e.g. [1] and [2]).
> >
> > However, for non-constant masks, smaller unsigned types should be valid,
> > too, but currently lead to "result of comparison of constant
> > 18446744073709551615 with expression of type ... is always
> > false"-warnings with clang and W=1.
> >
> > Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> > __FIELD_{GET,PREP}().  The later lack the single problematic check, but
> > are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
> > used in the fully non-const variants later.
> >
> > [1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
> >     HWM_FIELD_PREP()")
> > [2] commit cfd6fb45cfaf46fa ("crypto: ccree - avoid out-of-range
> >     warnings from clang")
>
> Also can be made as
>
> Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]

Nooooh... torvalds might click on it, and complain ;-)

> > +     BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
> > +                      __bf_cast_unsigned(reg, ~0ull),                \
> > +                      pfx "type of reg too small for mask")
>
> Perhaps we may convert this (and others?) to static_assert():s at some point?

Nick tried that before, without success:
https://lore.kernel.org/all/CAKwvOdm_prtk1UQNJQGidZm44Lk582S3p=of0y46+rVjnSgXJg@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

