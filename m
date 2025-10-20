Return-Path: <linux-iio+bounces-25277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C45BF124E
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 14:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8A0424301
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFA4313278;
	Mon, 20 Oct 2025 12:20:19 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D0C313537
	for <linux-iio@vger.kernel.org>; Mon, 20 Oct 2025 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962818; cv=none; b=AKsNouMxs3Cd7dlfuHoPL9UBqfbVG/KivB6/zVnaYqgRileiQ3MUsYE1zzYRiHyvuJloDHySgvQoPa51vfZJc3VuMIwA6aW7exqdvgV64mAUMwOqXeeCgkxruiecVB8ECW5E1CBg8xbwNbSO7rGEZ4ks9WKuhpofyC0redw18eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962818; c=relaxed/simple;
	bh=zQJyABbFIFRgraIjRfB4Kv0edNHngRx2HTU3PnrqMSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fz/1vSofyqDesEUp35GDv9Uxu6sIRC9CTurVei328wrGrjxc0qJ/tIjSUsr//SzK+Qkc4MJU8MSURI5qnPGNEK9pMztUty20O+XL/o02lAO8CMmbegTM7TegokBVLuDROt5FKIwi1VjrkYt4FzI7U5s3DHpQRKwGBMLmQtQAoOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430d06546d3so22114635ab.3
        for <linux-iio@vger.kernel.org>; Mon, 20 Oct 2025 05:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760962816; x=1761567616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pomt2ITXhIHlFit8dq3w5svz3PMdwi8h98cx9ZzxHC0=;
        b=UVkK+aT6J7B4278H8tC6nfmvIUSUduxNvBIuZMXl0d603/WCFzuefIfpI8TWSMpb7p
         WiU1WP16jTer7MVIV3je9SGgpJum6QhcH7RxGuN4OJ5u6z1IugYrRPvMFnQPRPqo7ft0
         9z2NJSQS6z4KxSaza2jGuG43ZHbHlObD/2N96GOSZJpbJgDEINdcURRDdDl8fz6oqRRB
         aUm+pU4Vh3WcfKw8K7w2n8YsTbdWL4fwEFlUnxLtWclYkOCdZIU//xi3ngiRxb6Q94AR
         KaUG+PVJ/tjvfZMEd0CkhB0fjGRsbJrE0GgWYoWXLgTix3yOxInPTe9rkf5sKsg+x2tI
         50yg==
X-Forwarded-Encrypted: i=1; AJvYcCWqw/VtbMYSzKeC64pGeIlgNNKgpxhyvyAl1PX5EFZDSYyawopP1rSEMis95ZWHxDn5CtOKMNnLJ0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZgV3rHizhLQfVKIwRlFueIiY82Epv4VnHOw9JDZn67APtkTeU
	HT6sU9poNtlT11uEixafgBSktXJBPWgeISgwQSlncOEo0lPtHRoDHezyuS2M7wdX
X-Gm-Gg: ASbGncvP/ilqYw/chwx5AwO2bbj5uvqaqzr38JtSnj+fF2AS0imXXiiJPFl6GaYY0+N
	nAXRgZK8KoxuYtHh9b30pvJMr6Swsbxyb6NYCgP86OpqLSm+v6L6BpJgBOXIWkAjPDpf3BwfQ6k
	5TXg+OrMY6JZIk4oekJCZ5QsYtHClFwcuhkcsODJEmI5Av6dd+cvymmICYJBSGqp/Zqr6pBKZJf
	jIo2NzxY98SMJAxhhtH5meYWJZNKJLMLz/sN4Tdzpt/VxKFGSzFWuouBYZ4dcFLrW5NLGv3JXE0
	ohGOF+N8PGwc4WK9zpak+dLvZb25hsE7RxVzHQn6EZL1ahzg6W/Nfg3PInSoSKyp2Wj2kS+TWCB
	5+4ySdey3V31qJNgHiHAAK+XSt7JPhOzi2SmxkhIReYgQbEpDf7CiTDTYdMjXXEETMVezSl/amE
	N2x2fPtnyJDh/ekQegFLdJs3o0LksHHjXC8QE7fQuGWYyd7fjM
X-Google-Smtp-Source: AGHT+IFZ3jR++ayWHKMiY5UO+taarBFyC60Sod+OBuRDJGBcjKE2i3CtceE2kOX+D5jA3yvPnCWVIA==
X-Received: by 2002:a05:6e02:148e:b0:42d:8c07:70d2 with SMTP id e9e14a558f8ab-430c5263edemr202488675ab.11.1760962815890;
        Mon, 20 Oct 2025 05:20:15 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07b3eccsm31335285ab.28.2025.10.20.05.20.15
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 05:20:15 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93e7ff97d9fso289054139f.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Oct 2025 05:20:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3/Td4jin2n7DjrP6aRZDqooG4O6lKy7F2/8WljDNBFs7vKpzAUKlaOFyrnZCOp9priRVIL0rCRv4=@vger.kernel.org
X-Received: by 2002:a05:6102:50a2:b0:5d5:f6ae:38ca with SMTP id
 ada2fe7eead31-5d7dd6f4c27mr3609494137.41.1760962417639; Mon, 20 Oct 2025
 05:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760696560.git.geert+renesas@glider.be> <792d176149bc4ffde2a7b78062388dc2466c23ca.1760696560.git.geert+renesas@glider.be>
 <aPJwtZSMgZLDzxH8@yury>
In-Reply-To: <aPJwtZSMgZLDzxH8@yury>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Oct 2025 14:13:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXCoqZmSqRAfujib=2fk0Ob1FiPYWBj8vMXfuXNoKhfVg@mail.gmail.com>
X-Gm-Features: AS18NWDS1vbUG4-z_--VlQ3gjSspwjijy0fs8EPqX7O88cWCZQUNQKHTmAYei1k
Message-ID: <CAMuHMdXCoqZmSqRAfujib=2fk0Ob1FiPYWBj8vMXfuXNoKhfVg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] bitfield: Drop underscores from macro parameters
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
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yury,

On Fri, 17 Oct 2025 at 18:37, Yury Norov <yury.norov@gmail.com> wrote:
> On Fri, Oct 17, 2025 at 12:54:09PM +0200, Geert Uytterhoeven wrote:
> > There is no need to prefix macro parameters with underscores.
> > Remove the underscores.
> >
> > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v4:
> >   - Update recently introduced FIELD_MODIFY() macro,

> > --- a/include/linux/bitfield.h
> > +++ b/include/linux/bitfield.h
> > @@ -60,68 +60,68 @@
> >
> >  #define __bf_cast_unsigned(type, x)  ((__unsigned_scalar_typeof(type))(x))
> >
> > -#define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                    \
> > +#define __BF_FIELD_CHECK(mask, reg, val, pfx)                                \
> >       ({                                                              \
> > -             BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
> > -                              _pfx "mask is not constant");          \
> > -             BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
> > -             BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
> > -                              ~((_mask) >> __bf_shf(_mask)) &        \
> > -                                     (0 + (_val)) : 0,               \
> > -                              _pfx "value too large for the field"); \
> > -             BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
> > -                              __bf_cast_unsigned(_reg, ~0ull),       \
> > -                              _pfx "type of reg too small for mask"); \
> > -             __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
> > -                                           (1ULL << __bf_shf(_mask))); \
> > +             BUILD_BUG_ON_MSG(!__builtin_constant_p(mask),           \
> > +                              pfx "mask is not constant");           \
> > +             BUILD_BUG_ON_MSG((mask) == 0, pfx "mask is zero");      \
> > +             BUILD_BUG_ON_MSG(__builtin_constant_p(val) ?            \
> > +                              ~((mask) >> __bf_shf(mask)) &  \
> > +                                     (0 + (val)) : 0,                \
> > +                              pfx "value too large for the field"); \
> > +             BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >       \
> > +                              __bf_cast_unsigned(reg, ~0ull),        \
> > +                              pfx "type of reg too small for mask"); \
> > +             __BUILD_BUG_ON_NOT_POWER_OF_2((mask) +                  \
> > +                                           (1ULL << __bf_shf(mask))); \
> >       })
>
> I agree that underscored parameters are excessive. But fixing them has
> a side effect of wiping the history, which is a bad thing.
>
> I would prefer to save a history over following a rule that seemingly
> is not written down. Let's keep this untouched for now, and if there
> will be a need to move the code, we can drop underscores as well.

Fair enough.
So I assume you are fine with not having underscored parameters in
new code, like in [PATCH v4 2/4]?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

