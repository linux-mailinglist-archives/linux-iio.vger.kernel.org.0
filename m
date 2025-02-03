Return-Path: <linux-iio+bounces-14941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27639A26082
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 17:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6F81886ED0
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 16:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8DF20B7E8;
	Mon,  3 Feb 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFak/j1Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D972063CC;
	Mon,  3 Feb 2025 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601285; cv=none; b=XcTpDsNddU3IUO2yvHQBcRObP3fEGdVzTI4PLtUI+vP4jml5PiBllJJHFPDLj1Y5J8B8LqZrLsuVQH9Yd7oiL6SlEEaBza/JFIy7KltykKU+OqxKEsIwkQDei5ELr5H2o/OCB/cm49E09KNH6SPKY7sSujF/TzSK53zeNJgzHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601285; c=relaxed/simple;
	bh=KsQAqNFBlCnRQ0Q1Ww9rKgZbgaipv1/rUQJ1vcpzy8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHcrfVFx9f3nkhhMktE3w+8Z1kaCTLAKpoDzUZfXw/hOP69/qw/s4h56PPWp4rYWrQJwBFL6Pv7tucAZ/zRBx3uHFjKn2/zRdCyrqeuSma9ebQ7KugLGPalx17HjxZZ8r5qrEOZ7xAut/utCVyWI/BsDZeruQ+rLeSFazPij8y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFak/j1Q; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so7995336a91.2;
        Mon, 03 Feb 2025 08:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738601283; x=1739206083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPAYDZWhZdvT52ze2ZOmieMRhyI6YJK1D7vMTJGJV3Q=;
        b=VFak/j1QQn9eqWpMCfprLZRAQvJYeLtwMPSW3t+Hl9xEo7gv8nm8NtkAUq/vjWlcB1
         k+9wvy9/nnkVuarYEz8/vwky0zaRJxjJUfVb5+ZpcRZ4w/l3lnRRdpjS86aL8W3tJwYL
         p0e3AGfPh9xD17WyesmahD0vHsEpcF5EtNE0X0a1rVoGkLtQSOYextSwqxqLKm7wAzFC
         xaGFWcEXKuCr9EJYxMEzYKISXAi58jYvDW0m3BzlgUWza4YGHUPRyGflkh2ysq2o+0s8
         HLQHbKHqUex7UQaEzpJ+8+xsdiy3x6Iqiu2tu/mGMePhCFDcHeVATtpuyRTk0l9x/gTa
         bbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738601283; x=1739206083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPAYDZWhZdvT52ze2ZOmieMRhyI6YJK1D7vMTJGJV3Q=;
        b=UZ6EYeHTApIsiGvD/qsHRPdK9DIpQTuT8u42RQAHZTR8kCdO5FdDma9rrAG0yszKje
         Evbpijx55ZDWvsy6V84fQ8fbRC2OKphA3mczw2DtdHKigtPqYzj6oMyOBmJxUz1+0Se5
         iWzfovJVB2hwGoYizRjc7cTaNyOzDAE95DTRLKscqS08Y3H2KTtcO/xOSCUfrJcQnbXB
         EYxykrtUHm9mKkPyOpG8R5I2sFReFCiDy1M8McjFsYSjaeNjY+4tz9GeYXFBRtC4WeqB
         kUSDqgx+v33sMNYYeZGMlqoFtHRQSeZCgqAJToIJlOIAKFQKISQQUOyNvC7YLP56adRE
         wXuw==
X-Forwarded-Encrypted: i=1; AJvYcCUUY19bS/ZEWxR4yBiIHSCOtUYLMMJEvr0kg1sYCoQeag7cWKHynJ7W/dvv7kHLhRuntP5VaQamlwDIVhY=@vger.kernel.org, AJvYcCUmxMZCZPR/J/irL78+bM8npSxcQSRUNlclvcByecUsChG2xOG8NZmLhtkz7YVX2/hqd2GcEyp9YQQ=@vger.kernel.org, AJvYcCVaQ94QCECD6CsaVQcpmpDOtJDofTxgxpXkRZyNzkZR8kLFx7F5o6DYY4QPb6qsPty6AfOZYXJMAmAUoZGxlndCxic=@vger.kernel.org, AJvYcCWqAnBLub6psTdytPFGkZ0o8x+IocXqluD+Y/8binoGLYkJa8dwnld7JxEnmrU61bdeygXRJdgY3qMGjw==@vger.kernel.org, AJvYcCX/g/1O+m+dvfkoO+EB1tQ33l7H6nD7i1lSu6fciuavWqJOjCSTo1mx8qdCzHoIJE8LZdDX9CWP6VYuSQRg@vger.kernel.org, AJvYcCXTo1Tj6PeUDgRjMyzRKCU5D514rXIdFijHCc42hLhbZkFtZB5ucBBTo77IkCJW0S6UTPUud28O6xgZ@vger.kernel.org, AJvYcCXWgMs09BCPi9mnCUvLPB/FjLnjjGsRBQSEMWdQ34sYSLrG10WX7M28Dg9jvklhg3gpRxLABHBQzT8d6Tcg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+tCWLwELb8usKdgEpi3lWf3l9mQpZjxHZsuJAurvG23ZwXlF3
	TGAIIcBJNnRBaNmus+PuCkmxN/MlgbelIv1e3YDGCcSIqEKlM1wR
X-Gm-Gg: ASbGncv2h++5K+eZ1aEQdWC1obF/67WtcALH/k+WBeKhLjb5+ocuuKbFQ0o0vfDg57Y
	TD7OfDOOE5V8d6TvDyDOtwWmrwngC2BQpDYuALp3PNQHjxrG7oLxZ3fvLHaQiEeE85ygYOxPw2I
	L2NpgmXa6kYP0pGN20MnaLCi7nc2FQYYASVwnlloeMba0Ig5fqUBSKXxB6KRbnJF4bEWE1pY34s
	BoInwJXaNpxnsvZ3fVGKmgcVgwqRVEkWli4IZi4R3NFAswiNdnc35cDtiQ4vKFwT7wyVq4Zal6+
	s+8DuZUwf0LAqXBRbRbuMLlwekxoH1XCbT19AlY=
X-Google-Smtp-Source: AGHT+IHh9exrF+8QB08CxBY/dutMFmF0pU/5zhM+ZnTaly80R74kffODtDWK+nW0lOwVLaaD6ED6FA==
X-Received: by 2002:a17:90b:53d0:b0:2ee:45fd:34f2 with SMTP id 98e67ed59e1d1-2f83abb8f42mr30994632a91.6.1738601283227;
        Mon, 03 Feb 2025 08:48:03 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489adf7csm9341363a91.13.2025.02.03.08.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:48:02 -0800 (PST)
Date: Mon, 3 Feb 2025 11:48:00 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	qat-linux@intel.com, linux-gpio@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
Message-ID: <Z6DzQHebEKBb12Wo@thinkpad>
References: <cover.1738329458.git.geert+renesas@glider.be>
 <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>
 <Z5-xMUqrDuaE8Eo_@thinkpad>
 <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net>
 <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr>
 <CAMuHMdXZKNtAmiMP8uuSngZMsDLGcYwrLS0xNWzN4UfLaccdyA@mail.gmail.com>
 <16e1568d-8747-41e0-91b9-ce23c5592799@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e1568d-8747-41e0-91b9-ce23c5592799@wanadoo.fr>

On Tue, Feb 04, 2025 at 12:41:55AM +0900, Vincent Mailhol wrote:
> On 03/02/2025 at 22:59, Geert Uytterhoeven wrote:
> > Hi Vincent,
> > 
> > On Mon, 3 Feb 2025 at 14:37, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> >> On 03/02/2025 at 16:44, Johannes Berg wrote:
> >>> On Sun, 2025-02-02 at 12:53 -0500, Yury Norov wrote:
> >>>>> Instead of creating another variant for
> >>>>> non-constant bitfields, wouldn't it be better to make the existing macro
> >>>>> accept both?
> >>>>
> >>>> Yes, it would definitely be better IMO.
> >>>
> >>> On the flip side, there have been discussions in the past (though I
> >>> think not all, if any, on the list(s)) about the argument order. Since
> >>> the value is typically not a constant, requiring the mask to be a
> >>> constant has ensured that the argument order isn't as easily mixed up as
> >>> otherwise.
> >>
> >> If this is a concern, then it can be checked with:
> >>
> >>   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask) &&
> >>                    __builtin_constant_p(_val),
> >>                    _pfx "mask is not constant");
> >>
> >> It means that we forbid FIELD_PREP(non_const_mask, const_val) but allow
> >> any other combination.
> > 
> > Even that case looks valid to me. Actually there is already such a user
> > in drivers/iio/temperature/mlx90614.c:
> > 
> >     ret |= field_prep(chip_info->fir_config_mask, MLX90614_CONST_FIR);
> > 
> > So if you want enhanced safety, having both the safer/const upper-case
> > variants and the less-safe/non-const lower-case variants makes sense.

I agree with that. I just don't want the same shift-and operation to be
opencoded again and again.

What I actually meant is that I'm OK with whatever number of field_prep()
macro flavors, if we make sure that they don't duplicate each other. So
for me, something like this would be the best solution:

 #define field_prep(mask, val) \
       (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))

 #define FIELD_PREP(mask, val)                                         \
         (                                                             \
                 FIELD_PREP_INPUT_CHECK(_mask, _val,);                 \
                 field_prep(mask, val);                                \
         )
 
#define FIELD_PREP_CONST(_mask, _val)                                  \
        (                                                              \
                FIELD_PREP_CONST_INPUT_CHECK(mask, val);
                FIELD_PREP(mask, val); // or field_prep()
        )

We have a similar macro GENMASK() in linux/bits.h. It is implemented
like this:

 #define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
 #define GENMASK(h, l) \
         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))

And it works just well. Can we end up with a similar approach here?

> So, we are scared of people calling FIELD_PREP() with the arguments in
> the wrong order:
>
>   FIELD_PREP(val, mask)
> 
> thus adding the check that mask must be a compile time constant.

Don't be scared. Kernel coding implies that people get used to read
function declarations and comments on top of them before using
something.

Thansk,
Yury

