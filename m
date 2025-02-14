Return-Path: <linux-iio+bounces-15516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB879A35C12
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 12:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58673AC42E
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 11:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B467525D527;
	Fri, 14 Feb 2025 11:01:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B93186E40;
	Fri, 14 Feb 2025 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530864; cv=none; b=mmhflTtdzFsnIRecwfysiFSEJw+kK4CaZXDksdsZefvnCUQdnCCTMlxBlduN3+bRwxvY/bC2FnPHg1Z7iwGZN3OxkQMpd/1EUBIr9o9nupKUXNXPsq2fANxQQ4ZPY4/+fGxIE6qE6FCdvNmU5wetfXrwD2Mupmiy7EbcSLnoPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530864; c=relaxed/simple;
	bh=HCSrKtFLXQYg/hN8pgM00YPPxdWJEKp9xVwF87ANE0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0hxu5gnz6LYK3+7PXCOQ5CGydSsMTNvWDVxZ5aZVYRAG95jXZNuvD2ZJCtnnJbZX+K/ub61NiN2fZKQQMkCypwhhpHPG9XJ4EZ71UXX2ifc2V9thXm1fR2PlaIr7KlzufbayAVqarxn3piwxbiUIKs+005HuUKBUjVCxuvjAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-51faf3342b3so532938e0c.2;
        Fri, 14 Feb 2025 03:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739530860; x=1740135660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOhOeuJi5yrz4/2ECZyl6aYLZu4BPC+rC7vskT2goxo=;
        b=Pvdyhryz3Ptqxi3GE89BwEg889mtBIGNWrnuw/Doube60JG7g6CItDrTtvrXk2NJQv
         2KaWrOkSTviq2JjXHT5PgUVhFOPr3EF3Tlm/GgOpO626hpSszBts5LfLvifhz8aaz/jf
         fLdVE4OsIs7aBdpki3hVEz2nX8o/u60JsbJeGT7UAWuO+7ESbOqb+grHtsoif+aK2Ych
         2dnXNMlgMi6cd4xpVAi8yqJ0NZ2i6A6G5wp19TpV0NHAL3z1o5UqyJ9ite5V2GWx82I4
         xdGoBXYAIwn0URy0+XtIKeWk/QpzfjnwlBn0mEBUeOA/joEhH9NGlex0+L+cp7NxKh13
         BptQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXATJn+T9uEFwoE20ctB65WemGQxGIFfUm9egxSkZyzlrqx3gZv2zLnVUdIhzDeGDCXfNmFVJ06VZq@vger.kernel.org, AJvYcCVaJIGO6pdORbADozbxQfqHcpZojVvLexMpuXZeUWnmPLQKo4gdIQtVP4az+Y4+dVBl1NNKufdKK/s=@vger.kernel.org, AJvYcCVmEXnaiua2V6AYiz6cwd7oJpvqqvo5qPZ+UeJs4aUJAJkTdNZZuAcv8jEql0wzgdUHAuJaqroh4NR/HRL0@vger.kernel.org, AJvYcCWJCD3RgZswpSvpuQvl2ZpxF/HmwQtVDsmD6hETDEtR5CBmhlpjxV3aEKEAV5Dy8kOcyq8U8LlETJEKY9km@vger.kernel.org, AJvYcCWPXSn8g8DsaDJ3w6AarNxt4sAi2D0tyMWuCv5V1AMiDADGK6tvHWHdpul1IJeo2yG/HuNbYXUUUHU4Pg==@vger.kernel.org, AJvYcCX61ml0/OVWYe0bW7Y5sEFr8UD8uK4So4vO9cRNZZof/kawugS0LEQltekNxwVedT3wankfhMo/6V1OnjUKIgkChsU=@vger.kernel.org, AJvYcCXU6qmewtSpToTcTZpT3wSFj3363PNbIVcDYoMN//tBngNRh0gcei9N9mF0IuCjss+AxXjGfBQyosB8Sg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+EqFzcJEdRDVJASo8nSVhC+dBwrZKePhwLxJVymH0YYqxBcSZ
	PHzVJh2a/G2Qf8OhdyE+tBhcIIGyUBKYmCpse2lvlmsAR5di1JuICB9DadorWPY=
X-Gm-Gg: ASbGnct7AcjTZlGSP0t5f1FY2knO75QUM+jHYNb4jF8x3Ybzb/1kBBsYHELU+EoLRL6
	XGYDdv020STMMkbdNkDnOcUogml1ZxbEsXZnb9b2Sd4IvvH54012ReSkvhwmlkgykCxTBYTlAgZ
	HO/EfSn6X4e0VrPARX1ImkYUgHWsI8mQ03BBGey3yrjr3GZkFBOSRb8zHYcpBu4Zt8QWA5Q+NLZ
	YLojU0H7Wi/UjHS4Wml1De/hmw3Z70gcQOE5xLoAvIaAUkXE387Ko6N+0mioWnmNNbweaNFUMVs
	C94BOf2sx8Oo9a027nLkpvuj8IPI8i+clRkCLNeAQ/Pwjns0ZYxeTA==
X-Google-Smtp-Source: AGHT+IGHH9J7WZSjKynsDjHuSsccA2kFViXzNv+B5erRopmD4ma7JLHpufx70/+OndgF2fUEBiRpCw==
X-Received: by 2002:a05:6122:218c:b0:520:64ea:c482 with SMTP id 71dfb90a1353d-52067cfeecamr9542209e0c.7.1739530859918;
        Fri, 14 Feb 2025 03:00:59 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5207a9170d0sm573723e0c.0.2025.02.14.03.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 03:00:59 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4ba00b6821aso560090137.2;
        Fri, 14 Feb 2025 03:00:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6p2ZNVce3wzCsN84khp/yf2aoFM2NoxlOsTAkOdkzB/EGFZl+hgeXW9aEmkJN50+k1+9bHTiqufsf0xZe@vger.kernel.org, AJvYcCUEY3Bu6Xp26XZZORUUa7P2BZ6Es+gA60ASufMHNFkghZK+4WkUGNHCYOqWBYvXRoLn8Ke+czd6wrXvrkdd@vger.kernel.org, AJvYcCUh1RRal+P9iqmdibgyMCxrj8Y852inLqrYATCV398PU3oBqwS/Y0P+BmhtlGAW0D2c2LN7ZYfLOLDLZkSPyfEHLyU=@vger.kernel.org, AJvYcCWEyvbCrFMOciebR4enqJG3nca7jcKIRX+FCV6GcDF1vTYXNkQtSzaP0vh46X4ehFxOvokJNKuVqkBjtPM=@vger.kernel.org, AJvYcCWOx7mse05HHdxq4osJ3ziz9hyC8lj5M91JlUHZz+olPYT4hauZXlvqEHzl7xIfPtNHx3TfkbQjamWx@vger.kernel.org, AJvYcCWkmU86h+qALXsltL9xiNrweiKQ56TGWVsP1pH+NNQakrqQzeaMwYTpoCHxcOHefZyS4mEKMb/+1P4yaw==@vger.kernel.org, AJvYcCWxuPl1JQl+cNzfsYqzlgnxv2ktOctDnSmwQt0P/Xnf36D7qyvc9o+kwEVTsFVBHQMIA+Ht3NjDHxU=@vger.kernel.org
X-Received: by 2002:a05:6102:32c6:b0:4b2:adfb:4f91 with SMTP id
 ada2fe7eead31-4bbf2312e79mr9166519137.21.1739530858000; Fri, 14 Feb 2025
 03:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738329458.git.geert+renesas@glider.be> <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr> <20250204073011.5f6ca125@kernel.org>
In-Reply-To: <20250204073011.5f6ca125@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Feb 2025 12:00:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWe1Fe4ZvWHB1tf_NQNg6W9PmJzpEK_28g+ix9an3jw_Q@mail.gmail.com>
X-Gm-Features: AWEUYZljxHasbqOWVQ67DCDXNharhoOj8Y29FWByT7hZT_VuVaki-I-AuDEVuCo
Message-ID: <CAMuHMdWe1Fe4ZvWHB1tf_NQNg6W9PmJzpEK_28g+ix9an3jw_Q@mail.gmail.com>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, qat-linux@intel.com, linux-gpio@vger.kernel.org, 
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
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Tue, 4 Feb 2025 at 16:30, Jakub Kicinski <kuba@kernel.org> wrote:
> On Sun, 2 Feb 2025 17:26:04 +0900 Vincent Mailhol wrote:
> > On 31/01/2025 at 22:46, Geert Uytterhoeven wrote:
> > > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > > constants.  However, it is very common to prepare or extract bitfield
> > > elements where the bitfield mask is not a compile-time constant.
> >
> > Why is it that the existing FIELD_{GET,PREP}() macros must be limited to
> > compile time constants?
>
> Hard no, some high performance networking drivers use this on
> the fastpath. We want to make sure that the compiler doesn't
> do anything stupid, and decomposes the masks at build time.
>
> The macros work just fine for a *lot* of code:
>
> $ git grep -E 'FIELD_(PREP|GET)\(' | wc -l
> 22407

Indeed.

> BTW aren't u32_get_bits(), u32_replace_bits() etc. not what
> you need in the first place? I think people don't know about
> those, with all due respect the way they are coded up looks
> like an IOCCC submission..

These support only compile-time constants, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

