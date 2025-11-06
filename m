Return-Path: <linux-iio+bounces-25984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2AAC3C7AC
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 17:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6C144F9A6F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 16:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815093587C5;
	Thu,  6 Nov 2025 16:20:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748DE34B1A3
	for <linux-iio@vger.kernel.org>; Thu,  6 Nov 2025 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446035; cv=none; b=JThUZtraU8Oa8YTXGqssqi1VgVqnMLrR3YmbYEeXlRjDyzOqrLBaa94765hOee4hOEJ51S+RCEouzBPJrkbh0moQyiJHGYfisM74nIfNtwmEdgJH+FZHJYpFlWPQU2gYrpifJJ9mt9yxPoCqpIKHYvhCddoUjJ1AwkemVZeazXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446035; c=relaxed/simple;
	bh=3N1qJZ6LWFBTfpoRaZzcBCl8k2fr4s1S594WsHSwxm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHyy25I1rS61RCeUEHaK2hwqKlr4HDJEaxyGCARL7nj13P7dCpk29hBXG5XEK1bPGP6kUtDVUh9L/y/f0/BvAHJW3USx9PPUctd5wDj2ubztj03qRs3/yRCfL0zo7xSA2k8NzMi7RsOKVvEWJzwMPRSD/GnlNhMG0SK0CxWS7Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7042e50899so194103466b.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2025 08:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446027; x=1763050827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plp2F71zo3wke225yJ4Ea1I1OPDOMxgAH1RlngZdvGo=;
        b=DDGjnKJWisClFqEnHBzfAMUp/U5H48YZUg46dfgEo0Xu7rj+nlxs3o7INvWeQdW2YC
         yM5ILafDKMDlu5chT2veWWMis1HsogYQ4UL42VwSRGYi65QiU0jeZIK9m+fANQ3gkkMx
         ye8IsCmdAKtSgclw4EhOvahkSw1GUM4VEPBdjZpQ/GH6br2RVzpwSvrvFMZ/icjX8TH0
         5Gsd5CIxhbbflQbseWz83mIUnpKYBf2fesNX2V3PMhfESEVK+voEjtB1k8sfB72+cZUk
         JLTN1tuFQ4EcmuPt8y7wqthP0QD6tSBxoxokBVvTknVwduoBn0OS1IAnFB+0r7lbRrzM
         oMHA==
X-Forwarded-Encrypted: i=1; AJvYcCUB6J9h4vNrdVIU/tVZUXVMKBT1fJGI53BP2XRLWQn/IrDHm7BqHq5Ymo2Fyo3qYjlhe6/7OkvarvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz7TKf8J49boPCFQIPPIpKv+6UfG8885UNaklaCNCkHje8gFSO
	dvYetWCcVGdFSQb70sbvdfAX+QOs9yZQvEnutIuYEvksCrehGr5UdilBPX2E/Rs9nlY=
X-Gm-Gg: ASbGncvL2/UN2lowg1cecXuPMBMDS3CzbCfV9IZVs2GICMheqXSZHvLu/8xvqL/YbOI
	DzfmncNXfgw59uwdxB1uqpbunithv6anytRowOzOCpTLdHlGib0oZorCTrE0oG0ZRxY1Vlx36y2
	6KoMe0Epx0OEc84Rz1lFh/GKCNpaU/YlqYC3PuUmjQ5yJO0pBk9nvzpS6uuW5Zd9xbkKCJAivP8
	tVveLFI0spQpLI/dqEW72OrfGmOLgEsJLIjn3A91fHwx66AMd3bNwNWeFeLZCXyKSYbU6bomadd
	riYflzHC9ZVaFwgHyjK8rFzGveHGiBCVA0qqjREW9jRWL0qHOgxve0uiiU8k2IF1yxdS8XoNe9/
	dH1s75g6UVYgdFRThbGTx54mXEhCMs4YPV3cz9xTjN+nR7yX+1ubhVBDURTIn7nmN6lY0vBWrol
	3sVjrSnttLFzszQO+92Q6qrFLOFkCyeW34spyjaz1k4y5Yq4t4
X-Google-Smtp-Source: AGHT+IEzaKJfqAsHBJX6m4CED4Xwmykz9VGSVBXibPKmfknibVgQjw0iUqioHRBgOiaZBxOZVc4bFQ==
X-Received: by 2002:a17:907:60cf:b0:b46:31be:e8fe with SMTP id a640c23a62f3a-b7265154d67mr740722166b.11.1762446026558;
        Thu, 06 Nov 2025 08:20:26 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289644b39sm251454166b.40.2025.11.06.08.20.22
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:20:23 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso2352534a12.3
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2025 08:20:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWDFzNyqA2e7W2HkkhbQqR+azejf6CIt4y5Vim9Po7jJvF7En6pJHoedNofYcE65lO+VWhhK/cMPw=@vger.kernel.org
X-Received: by 2002:a05:6402:3590:b0:640:fa38:7e4a with SMTP id
 4fb4d7f45d1cf-6410588d45bmr7763851a12.8.1762446022573; Thu, 06 Nov 2025
 08:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762435376.git.geert+renesas@glider.be> <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com> <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
 <aQzIIqNnTY41giH_@smile.fi.intel.com>
In-Reply-To: <aQzIIqNnTY41giH_@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 17:20:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW8ndAdGnSHopYFMWvw7wk7wKz_7+N91M1jRHoqK1KBrg@mail.gmail.com>
X-Gm-Features: AWmQ_blD_P8L06tcYy5Zd39ODOkLvksucIxy1SkcdgHAnKwygGve4Lbclr5ZO9k
Message-ID: <CAMuHMdW8ndAdGnSHopYFMWvw7wk7wKz_7+N91M1jRHoqK1KBrg@mail.gmail.com>
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
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Thu, 6 Nov 2025 at 17:09, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Thu, Nov 06, 2025 at 03:49:03PM +0100, Geert Uytterhoeven wrote:
> > On Thu, 6 Nov 2025 at 15:44, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wrote:
> > > > The BUILD_BUG_ON_MSG() check against "~0ull" works only with "unsigned
> > > > (long) long" _mask types.  For constant masks, that condition is usually
> > > > met, as GENMASK() yields an UL value.  The few places where the
> > > > constant mask is stored in an intermediate variable were fixed by
> > > > changing the variable type to u64 (see e.g. [1] and [2]).
> > > >
> > > > However, for non-constant masks, smaller unsigned types should be valid,
> > > > too, but currently lead to "result of comparison of constant
> > > > 18446744073709551615 with expression of type ... is always
> > > > false"-warnings with clang and W=1.
> > > >
> > > > Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> > > > __FIELD_{GET,PREP}().  The later lack the single problematic check, but
> > > > are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
> > > > used in the fully non-const variants later.

> > > > +     BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
> > > > +                      __bf_cast_unsigned(reg, ~0ull),                \
> > > > +                      pfx "type of reg too small for mask")
> > >
> > > Perhaps we may convert this (and others?) to static_assert():s at some point?
> >
> > Nick tried that before, without success:
> > https://lore.kernel.org/all/CAKwvOdm_prtk1UQNJQGidZm44Lk582S3p=of0y46+rVjnSgXJg@mail.gmail.com
>
> Ah, this is unfortunate.

Of course, it might be an actual bug in the i915 driver...

The extra checking in field_prep() in case the compiler can
determine that the mask is a constant already found a possible bug
in drivers/net/wireless/realtek/rtw89/core.c:rtw89_roc_end():

    rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->hal.rx_fltr);

drivers/net/wireless/realtek/rtw89/reg.h:

    #define B_AX_RX_MPDU_MAX_LEN_MASK GENMASK(21, 16)
    #define B_AX_RX_FLTR_CFG_MASK ((u32)~B_AX_RX_MPDU_MAX_LEN_MASK)

so it looks like B_AX_RX_FLTR_CFG_MASK is not the proper mask for
this operation...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

