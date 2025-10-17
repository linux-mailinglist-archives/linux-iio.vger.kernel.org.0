Return-Path: <linux-iio+bounces-25188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 400C3BE8369
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 13:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 161C24E94C2
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA2432B9B6;
	Fri, 17 Oct 2025 11:00:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558DA32B99D
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698828; cv=none; b=CWWG6rra2tOJoEhXulunubg4SKn0I2L8a3bUHKauKj2CZEkeVdw22nK/ZnpPML4hyIqQtacSKOe2w95vXwF4t5hhK+bslNdgxYt6zYWgTk0+MwxZAIv2PrBmgmG/ymGn2S4T5J7ZdzCZ47undBYhTwTLPFtBzR3MBkAu2xMOd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698828; c=relaxed/simple;
	bh=7roeWK5AtO/7ZwDK0dlN3Uu9wiMocaa5toCTUlYqJaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfN9CoO9AmC1RQmQiz7uHsOEQDySpmoDH70SKByu85dktDfV2F0S4Zue+TEkge+z9HakMNgGq/f7zebmY6Bp6SICmRuRUV2wYP84JdVcbCOfsz90VuQ0+Pu3Zv3FbHZu1hEC77Mngg4G/cOQ1D4GhlVlV1fnxHjJo805DQXf/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7930132f59aso2475012b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 04:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698826; x=1761303626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPE9WHNZsdRI3QmdRcH/wWeYzKksV+R5Ry8aWltKbjU=;
        b=TkIOE0IGOehB0XaxImmL32Fg2Ujv53orq6HSFUEeux7/RwfW7P1LiHHYar+lENTObV
         VJMxwu7I3CLcdJPWOi+HcgVkwa7vbqu3R0WjMwnbZ4NoIM8XpkNxMV0BKGNJpXVQPuwt
         48Dvx2pk67+YaKOzY7Z1VhyrZPNDM7j6O/PBP/EU9KtzB5t2D3QQ4htP/EU005HD+pay
         u4TrKcO4LHcG0ZCzgEFGgDCHrxh8tCpl7tD9rGxdGPTjVaDJg3kUnVjTjFCXu2tuYT/R
         vt/h7E95exNQV/xguQij+X3fPmLc3oKM51LNb+VgEBt7quqJCB6Ov+CLA+adPF8m2uef
         yVfA==
X-Forwarded-Encrypted: i=1; AJvYcCWA13o3QIvlvQToNKJuPtYxuaUlGKtytjiObhKWtQ5U1oh4SK6qFEBN9gna7c19s+mF9jmpG/VsmU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6OgmaYrVFP5QH2fBrkKGOE3ToQh2CVvmedFHhhpZ4AiK/98YI
	60LWtTv5dDJdiaDCCY4eUtJwC5VoHN1cczoSqMqLH+bmFs6Cv71SbTG1ap9gsFSa
X-Gm-Gg: ASbGncvGmR2SBTYg5DAKmOYBtYCkXH+/1FSkSz9i818+z/wcWAY+82N6F7CCtI6l3Oz
	/kPT4U7vzmsqohMGQDKKnZTxkyucOQwjwvsTbpfYU8w/u1m2tFgIyPQZC4rQgG11FKaANDLPcaw
	u8b008Bn69uHsT8HzC2nlabU12zcKvm2W/rcAXEJVbFW/gOhyTJ5emyu4H5L4m+QeXZqHtyLb1d
	Luqq0OsmbtkesCoxllxyB1HaZgnQEbf78jLgxralq1cERCYJQjA+5o/RwJ7E2nfslkNDXERbNQN
	eewbkGhzqFOm3LO0zOG6+jaiobndNayKH3ytTGk41yaUNQ7WeeImw1xbBtQDFz/H83tAuq8ZKe8
	u5jDhDUSoqLVkfaG4JD+uxU19w3wnK+l8BHlkLJZVL2vZwD6u8OpiJuobIFbypGThkmVow08aTt
	g3njZReK/N9Fjaha0KVjU9tLuMrCX5BjvqOcAhVlnI0uMeU/NXXFW4
X-Google-Smtp-Source: AGHT+IFj947x1uzMZTLATeRJgvKmn8TMsxTIcJAURrAF+YyT6ybRrveOud5j2VCkQs0ISeYJ5SOPrg==
X-Received: by 2002:a05:6a21:33a7:b0:334:9bdc:16af with SMTP id adf61e73a8af0-334a84855a2mr4396408637.1.1760698826071;
        Fri, 17 Oct 2025 04:00:26 -0700 (PDT)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com. [209.85.210.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb18e28sm25468966b3a.29.2025.10.17.04.00.25
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 04:00:25 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-782023ca359so1841472b3a.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 04:00:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqs1z6Kr6qGSuhhHvDQirawxGWVI4p9fBB2Y975Ci8FYMQWfMiuxS9eRfN5K9vc8pTda5HiZtidk4=@vger.kernel.org
X-Received: by 2002:a05:6102:5111:b0:5d5:f766:333e with SMTP id
 ada2fe7eead31-5d7dd5934demr1126362137.15.1760698513447; Fri, 17 Oct 2025
 03:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739540679.git.geert+renesas@glider.be> <2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
 <20250214073402.0129e259@kernel.org> <20250214164614.29bbc620@pumpkin>
In-Reply-To: <20250214164614.29bbc620@pumpkin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Oct 2025 12:55:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXost7vL5uTocMGtrqhEk5AY3QUWvyP5w7_hBtf3MkMfA@mail.gmail.com>
X-Gm-Features: AS18NWAcP6voBjoIoEi-7RxJ0pdmzXqhfe5FdHBNP60R0y-DyUBofdEL44euygw
Message-ID: <CAMuHMdXost7vL5uTocMGtrqhEk5AY3QUWvyP5w7_hBtf3MkMfA@mail.gmail.com>
Subject: Re: [PATCH treewide v3 2/4] bitfield: Add non-constant
 field_{prep,get}() helpers
To: David Laight <david.laight.linux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, qat-linux@intel.com, linux-gpio@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Fri, 14 Feb 2025 at 17:46, David Laight <david.laight.linux@gmail.com> wrote:
> On Fri, 14 Feb 2025 07:34:02 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> > On Fri, 14 Feb 2025 14:55:51 +0100 Geert Uytterhoeven wrote:
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
> >
> > I really really think that people should just use the static inline
> > helpers if the field is not constant. And we should do something like
> > below so that people can actually find them.
>
> Especially since you really don't want to be calling ffs() on variables.

It is not that bad, as most temporary architectures have an instruction
for that.

> Much better to have saved the low bit and field width/mask.

While that would allow some space saving (only 10 or 12 bits needed to
store low + width), gcc would generate quite some code to create the
mask (even on PowerPC, where I expected a single instruction would
do ;-).


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

