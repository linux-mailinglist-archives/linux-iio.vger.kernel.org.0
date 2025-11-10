Return-Path: <linux-iio+bounces-26124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD7DC4586D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 10:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A88618822C5
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 09:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAFA2FE06B;
	Mon, 10 Nov 2025 09:06:59 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA62FD7C7
	for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765618; cv=none; b=LSDspQSYS0qg96AN2Cpfp6zEkm8vPSGJCze7rsrEJ0IO4ZDNW/g2NBdSY2MBdsTf5+7l/N3b5Y8L8w9u95oMaTQ94R8jeZjwx9au5LqzUsE6iDNxmfnMMtW7cGeGgDMVxZB+r3sEJdLsHkTnNbmycbae34UwdUYuBZrbUqbltYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765618; c=relaxed/simple;
	bh=JRmjklDdMnXYPa/YzcCMj4xR0iBgS1Ed7pmHd076aaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVt/4LMgbh6Jt08M3B7FnUZTwQ0k9VMPwJpn/5vVobbBOmlXVESmAidKBrzCN2n+gh3HmFzLzvP7x1dMHONah7TexmRHWvY7A4+BiyfVZA41Ep1rmh92O67OxwA7KpsqRaLcCBbCNWKG0Yf+XbKJG+6ERuEmatRvbefZXngTLhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ba488b064cbso1831761a12.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 01:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762765614; x=1763370414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuaR1c68u39/qbD5w07qCJ9IxeheIz5/8CL8hB/l6OE=;
        b=tSO1AEu4S4Y4VmZrZanPPQgDwcbRWrAKQM5W+LPoo71xjUHgE7Po79IjWkoOpbkbnc
         F3/4eP1TV6fquXbRXZWv3V+aKH26EiVCgfFybYgpiT1vnVVeTqaGGtBfHRcCk+Fixbr6
         jYMqCMM58EahivFxPnQ8ETIzKZ/EXItDDUJ8zUGVnv0fIC7qeIvcWNudhCHU8Tv4y9dg
         Xdq7ksSBfreQkTGpBNLvAQloWVfwlz3S+c+K6YgRrNL7/VAw7uB+mkFfdyyIKkfHab5F
         T4hL/Ivx5+9yj49vhOkzBY8AhulX4nNrdsR0tF6WlCMVbAkf05IgxtvZd7S24IPTm+/s
         9DWw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4shX5D3ntmrt8pJyk3FUM0NRy2WuVCylkAQCaVLie3FQ6PM82wQjvDJ42ojmmgeJr8jNvHh+0EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAS4ERVIVbSpyndPOEKZupgdTrWk4SHEm6ZXK1q9jZO57nn1K2
	jZfNWTbU7bZQEVEAHLK/tfSuXqYGJI46DYOr80P3gXrK+hpx5GhzezMfgWUx/LjR
X-Gm-Gg: ASbGncs7g8olaCtFrkfoo/4naoTLv5JnFHj5e2LT2JVbvPeUZ22JEf1RND2LusMJbNH
	p5FD1K87UDHBUOZTXYM/qmYzEp+61W6wBduVCAQZzt0Tq6C3dYDF4M9b5umNzRbhapbWnhLTXAG
	hZvb0VW8W5097dQD1eTZLtRpH0zHGsle451YG4Qz2B23OnQpO0Dgq26oS+pkWirJlHAMfqYcNOD
	9gHC3mbgy/msa2TvU7MwZ1sD/S4g4QG0ObQSyzb5h3fkJwxSeiNXrv5DBVMGdj8iePLawv/0XFg
	VZMlG+cbU6QW0k21q1k0/nlTa+lm9DXNFQhOqIPDYXiaffI68XBISRvq2R2y52FVzT5RfMHOr3U
	4nMQ29sX6zyoIUQ2feiS7cT8U9nzLNE9rFm5gtsmMHIvEZYWSm+9NvPORS9dUvBdr1eEFYfQgz1
	u0aepHVhIrVkuxWqyS4MSy1/GRx8BmYDgCkZmoT8qrYKDAuQ==
X-Google-Smtp-Source: AGHT+IHlHokL/v92Gv54Z3S3k48FwHjaFmuAy9kBV+XoSIvcmJcQUXPOZ4VXxikTOQhrMCCyAo1ffA==
X-Received: by 2002:a17:902:da4b:b0:295:1351:f629 with SMTP id d9443c01a7336-297e540d626mr85975125ad.9.1762765614411;
        Mon, 10 Nov 2025 01:06:54 -0800 (PST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c9325asm140606125ad.84.2025.11.10.01.06.54
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 01:06:54 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ba488b064cbso1831750a12.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 01:06:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5lFo72FqwVRwG4x86ihhJ6mYui/eO9uPpwtgcec+uvQzonhnVQLhffMR9KbjwS+YRSfaycSwP3Bg=@vger.kernel.org
X-Received: by 2002:a05:6102:950:b0:5db:fb4c:3a89 with SMTP id
 ada2fe7eead31-5ddc471358fmr2304047137.19.1762765185596; Mon, 10 Nov 2025
 00:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <97549838f28a1bb7861cfb42ee687f832942b13a.1761588465.git.geert+renesas@glider.be>
 <20251102104326.0f1db96a@jic23-huawei> <CAMuHMdUkm2hxSW1yeKn8kZkSrosr8V-QTrHKSMkY2CPJ8UH_BQ@mail.gmail.com>
 <20251109125956.106c9a1a@jic23-huawei>
In-Reply-To: <20251109125956.106c9a1a@jic23-huawei>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 09:59:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX8c1VkBuPDpJ5mpCcRH+zEX4F1bQKFf_V8N9ZZtCYqxA@mail.gmail.com>
X-Gm-Features: AWmQ_bmD7LCstBufqr7pTwqKUhf3WnheTdaFZy-l1C13xKAmQ3xomq2Nqy5MxZo
Message-ID: <CAMuHMdX8c1VkBuPDpJ5mpCcRH+zEX4F1bQKFf_V8N9ZZtCYqxA@mail.gmail.com>
Subject: Re: [PATCH -next v5 10/23] iio: imu: smi330: #undef
 field_{get,prep}() before definition
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
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

Hi Jonathan,

On Sun, 9 Nov 2025 at 14:01, Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 3 Nov 2025 11:09:36 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, 2 Nov 2025 at 11:43, Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Mon, 27 Oct 2025 19:41:44 +0100
> > > Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > >
> > > > Prepare for the advent of globally available common field_get() and
> > > > field_prep() macros by undefining the symbols before defining local
> > > > variants.  This prevents redefinition warnings from the C preprocessor
> > > > when introducing the common macros later.
> > > >
> > > > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > So this is going to make a mess of merging your series given this is
> > > queued up for next merge window.
> > >
> > > I can pick this one up perhaps and we loop back to the replacement of
> > > these in a future patch?  Or perhaps go instead with a rename
> > > of these two which is probably nicer in the intermediate state than
> > > undefs.
> >
> > Renaming would mean a lot of churn.
> > Just picking up the #undef patch should be simple and safe? The
> > removal of the underf and redef can be done in the next cycle.
> > Thanks!
>
> Only 1 call of each of these in the driver, so churn is small either way.
>
> To avoid a bisection problem if your tree merges first I need to modify
> this stuff in the original patch or leave it for Linus to deal with as
> a merge conflict resolution which is mess I'd rather do without.

If you add the #undef, there won't be any bisection problem?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

