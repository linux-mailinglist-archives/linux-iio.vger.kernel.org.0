Return-Path: <linux-iio+bounces-25617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E20C1BA37
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 16:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6240587C1C
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 14:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E812D2494;
	Wed, 29 Oct 2025 14:40:45 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4D3346BD
	for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748845; cv=none; b=FBg4GXRXBG4Fqe5gzkJlFrFEz1ePcNhXypNpxPNFuoGWYR+jF9x2YRdy9mi9kN6DtkWTnJ1TWbwY1+ByfnlcoQTCw2gq30zEnd2WiZhiR/hjg/zPCbHEsfzA3eA6FaWxW9EEVGVsGEw7tKeK2PaoLQU7liIanaCIU9h2Anw6OsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748845; c=relaxed/simple;
	bh=QXFJ9Wye89l5k56IzhXHnCZ5vP4dVOGIaGxaTnibrdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7Rz2xhg1hC4TreA8k0zPhMkW80vE/LiBjaZ1nDPAs/DersiAIhA7AP3LRBcB0hIh61zgKcRZ5Y6D4+/8wgRxkUcMlGw0tIgp7h5qbmMwxeKen4iYyxFgT8v8jlStSwJd2mSTLLgzVHGZrAsz6vPJtSUfKo1eeP+El9hpW0ji2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8eafd5a7a23so733952241.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 07:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748843; x=1762353643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohi/8MFIs+pUNYTuSKDH5KUVpFMJO5wn0YyhdMa7QIc=;
        b=kclzYZ44bdS4nc62223ZuCFyJ/7jqk079S6tn9ZYW0oodf8AJ13eWfRVtNeqvBhNh5
         +O0jbLUby/Wtizf3Gv7ibBdCz6jo0sGpuersIN/FAd1rOoksq64XES7Hm5TMkMa40Wak
         Z34sICgYE5jzj4rnK8B/MqT7gSsiY3qRPVKx+5wDyhjAOXjJqoJoi5XKoz8Q8WN9LTik
         nvY00j47TElnk7gX5vhhSZATduSqqbpnJKWs5RxdfLMK/SQVgaxKU9ACTjE4LKvTUBLn
         6W3U2hESHqyp16/PaV/zH7suyqhBnK8RSvmc7HTUa189RySeIrHsUUE7d64XoOnLl+3u
         w0qA==
X-Forwarded-Encrypted: i=1; AJvYcCXqc7WAbop2FomvVZ5EZYQD5q6mIS+vCRRdbolbZF5FQfez/g/Fm3u4xirv+uyV0t9QpC1YldR/0fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVTnHv8zXBjgzWoONZQfTzuMo9xHaaSng6WRfr4lWp66/nz4Ll
	sC1dTYYiq8zzC6arH6ApYzMs1aYbUWsI1VuhDzypLQjF/Gf1pccizbiSJ1TVxnYV
X-Gm-Gg: ASbGncuFSOOPulhGe7eN0Wh85Rt8NdOZdC4b41X3SkFtZOjVfmhyMtGmyb7UMxRYXA4
	LlOMWbCVpH4UddIMWF9oxpgQhQUboTv52M+GBTDJVnSZ2WDL7iWRJpt7CuOZFIcNg/2th9/XCKH
	9Tnpg7FJD7D4lyG8BvqLiHB8W4fqc864X+Oq0qsX/wKz8h2h3Y/tWLyqfNU3cODYan5V/YfUgCv
	iFGw3HURso1R5eoR2VNRRYZdbeshDEAeZY6+dceilIAb+3opr2k2QkVSDANUxxrncuPrxA3G/Iy
	cbsCQgJL51fUB7/ZgR1gNCx5RIajPGgvIi98VVGp3B3yOYhcOlzJX9Tvh/NvYl98bmL1dX1XcPR
	MN7X6FH7flCtZBxaKf2nfz/h6AQNkEjoZeJSRxLBrhdtrut0XdqGoWKNE2z8A5YJPFRkxm74r/p
	aRICpHBubKhSJxpBEER9WXcfTHqKp6HtOa1X5edIhlH9ZKLgUIxvPXDnULXI/ubww=
X-Google-Smtp-Source: AGHT+IHXoH9b9SqZtN4tMQCdoSWvximYFxDmzF2QUC9hn4ZDdRWVqAnn9SMiek4vSSPLIfutl6rkwg==
X-Received: by 2002:a05:6102:6105:10b0:5db:2168:77bd with SMTP id ada2fe7eead31-5db7e069f95mr2514164137.2.1761748842469;
        Wed, 29 Oct 2025 07:40:42 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-934c40c0492sm5232412241.16.2025.10.29.07.40.42
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:40:42 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5db2dc4e42dso1155706137.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 07:40:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5iCH2VNQxP7oh9qb4FIMw4UVxjBEpN0JesOjvBy/RwvnGGhawIQdGLWMpWS9lyk7SnvafDB4maXw=@vger.kernel.org
X-Received: by 2002:a05:6102:2acd:b0:5db:9b88:1fec with SMTP id
 ada2fe7eead31-5db9b88219emr535412137.9.1761748503547; Wed, 29 Oct 2025
 07:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <ac3e718c5de6a23375055dd3c2e4ed6daf7542d5.1761588465.git.geert+renesas@glider.be>
 <CACRpkdYMv+R-NJ5R4+UyhK1+DJia0z72kZgt45+0eubXMuGpEw@mail.gmail.com>
In-Reply-To: <CACRpkdYMv+R-NJ5R4+UyhK1+DJia0z72kZgt45+0eubXMuGpEw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:34:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUvLH-8yNRoqBdTB+mcmOUedwVGpJ_HGdq8sqgLNB4dvw@mail.gmail.com>
X-Gm-Features: AWmQ_blZ8dUVr2aBwtWAAkAOaE93AtUSPNFDpslgvmXepFfW4tMWIOUWnRJkksY
Message-ID: <CAMuHMdUvLH-8yNRoqBdTB+mcmOUedwVGpJ_HGdq8sqgLNB4dvw@mail.gmail.com>
Subject: Re: [PATCH v5 18/23] pinctrl: ma35: Convert to common
 field_{get,prep}() helpers
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
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

Hi Linus,

On Wed, 29 Oct 2025 at 15:21, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
> On Mon, Oct 27, 2025 at 7:44=E2=80=AFPM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>
> > Drop the driver-specific field_get() and field_prep() macros, in favor
> > of the globally available variants from <linux/bitfield.h>.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v5:
> >   - Extracted from "bitfield: Add non-constant field_{prep,get}()
> >     helpers".
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

> I guess this needs to go with the rest of the patches?

There is no hard requirement for that, but if 07/23 goes in, why not
include this one, too?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

