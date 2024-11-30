Return-Path: <linux-iio+bounces-12857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD229DF12F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 15:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D3EB210EC
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7613199244;
	Sat, 30 Nov 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQdPnfGW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B522066;
	Sat, 30 Nov 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732977315; cv=none; b=OFihX/Mi2mwJFdn9WS6rdS6JQsGKpl3FtIBfLgghJ9rsF8+U0aMcj1UxUbFHJ6sYOAKq+Y7iX9lQx0STuT2vfX7Z9Y011o1geI2fKCZgqFMmJcRo8J23eoLJyCTlKO81Yxj126huGtEl3gzLPpB/6MlJLe+E2s/KBfe6yPmEr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732977315; c=relaxed/simple;
	bh=Qr9/VH+QjmMpO1LCTY0JC4VbxBw671YMA+63h+7HpBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeyNaOTo3vcmc5cUUM77Vl71exYjVCe1VGtuN6XG/BHtweQr7bndE7vOhuWE87PJsy3C8usXLU94zGoIx3ccMMMYnV38Rg8O7yDfrRs/3RI761qmiNGUMvBY8btU1Jx0LBgooqBo2PQHx+p/FFgwEYgkLdGAgcK4bQiSyg1MeH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQdPnfGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1723BC4CECC;
	Sat, 30 Nov 2024 14:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732977315;
	bh=Qr9/VH+QjmMpO1LCTY0JC4VbxBw671YMA+63h+7HpBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fQdPnfGW5VbAn1OukMtk2xa8qLdZD1dcZi3VSgy269ui+i4sfzjHKomIxT7p4rcy3
	 bOZ3nQfiHG2fna3tKZegUXax/QnYuFvHjmYFWcfXpUlwqmQMkuIFFaGDuETWgH4hsL
	 NNF6P7WWUWNB5QcpSJfda4k7hz4kFLSkN8VjgORXoVs4cD6SYTpfmdkUctuiYSLCpQ
	 CG7EqhnfeDLj933MM+b7kzHyQFOvxoqd4qqzOQbR/7FqnG84taCrmFM2uVbVsxR6LM
	 VJ2Qyxyib1YUUJE5y/Sf3MXTWQxRm27tYrNSKkU48D+RVgP0yHxjgThzD70VjgSAls
	 wVxXGnFaAzC+w==
Date: Sat, 30 Nov 2024 14:35:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Jakob Hauser' <jahau@rocketmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Walleij
 <linus.walleij@linaro.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] iio: magnetometer: yas530: Use signed integer type
 for clamp limits
Message-ID: <20241130143506.53973e40@jic23-huawei>
In-Reply-To: <9f5793f03c2440d2aa18630469df06df@AcuMS.aculab.com>
References: <11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
	<11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
	<9f5793f03c2440d2aa18630469df06df@AcuMS.aculab.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 11:40:45 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Jakob Hauser
> 
> Copying Andrew M - he might want to take this through his mm tree.

I'm confused. Why?

Looks like a local bug in an IIO driver.  What am I missing?

> 
> > Sent: 29 November 2024 21:25
> > 
> > In the function yas537_measure() there is a clamp_val() with limits of
> > -BIT(13) and  BIT(13) - 1. The input clamp value h[] is of type s32. The BIT()
> > is of type unsigned long integer due to its define in include/vdso/bits.h.
> > The lower limit -BIT(13) is recognized as -8192 but expressed as an unsigned
> > long integer. The size of an unsigned long integer differs between 32-bit and
> > 64-bit architectures. Converting this to type s32 may lead to undesired
> > behavior.
> > 
> > Additionally, in the calculation lines h[0], h[1] and h[2] the unsigned long
> > integer divisor BIT(13) causes an unsigned division, shifting the left-hand
> > side of the equation back and forth, possibly ending up in large positive
> > values instead of negative values on 32-bit architectures.
> > 
> > To solve those two issues, declare a signed integer with a value of BIT(13).
> > 
> > There is another omission in the clamp line: clamp_val() returns a value and
> > it's going nowhere here. Self-assign it to h[i] to make use of the clamp
> > macro.
> > 
> > Finally, replace clamp_val() macro by clamp() because after changing the limits
> > from type unsigned long integer to signed integer it's fine that way.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202411230458.dhZwh3TT-lkp@intel.com/
> > Closes: https://lore.kernel.org/oe-kbuild-all/202411282222.oF0B4110-lkp@intel.com/
> > Fixes: 65f79b501030 ("iio: magnetometer: yas530: Add YAS537 variant")
> > Cc: David Laight <david.laight@aculab.com>
> > Signed-off-by: Jakob Hauser <jahau@rocketmail.com>  
> 
> Reviewed-by: David Laight <david.laight@aculab.com>
> 
> I THINK all the other BIT() and GENMASK() are ok.
> The code also rather heavily relies on u16 being promoted to 'signed int'.
> 
> 	David
> 
> 
> > ---
> > The patch is based on torvalds/linux v6.12.
> > 
> > The calculation lines h[0], h[1] and h[2] exceed the limit of 80 characters per
> > line. In terms of readability I would prefer to keep it that way.
> > 
> > Changes in v2:
> >  - Self-assigned the clamp macro to h[i].
> >  - Changed from clamp_val() macro to clamp().
> >  - In commit message added issues on divisor BIT(13) and missing clamp
> >    assignment.
> >  - In tags added another (duplicate) report by the kernel test robot.
> > 
> > Link to v1: https://lore.kernel.org/linux-iio/20241126234021.19749-1-jahau@rocketmail.com/T/#t
> > ---
> >  drivers/iio/magnetometer/yamaha-yas530.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
> > index 65011a8598d3..c55a38650c0d 100644
> > --- a/drivers/iio/magnetometer/yamaha-yas530.c
> > +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> > @@ -372,6 +372,7 @@ static int yas537_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
> >  	u8 data[8];
> >  	u16 xy1y2[3];
> >  	s32 h[3], s[3];
> > +	int half_range = BIT(13);
> >  	int i, ret;
> > 
> >  	mutex_lock(&yas5xx->lock);
> > @@ -406,13 +407,13 @@ static int yas537_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
> >  	/* The second version of YAS537 needs to include calibration coefficients */
> >  	if (yas5xx->version == YAS537_VERSION_1) {
> >  		for (i = 0; i < 3; i++)
> > -			s[i] = xy1y2[i] - BIT(13);
> > -		h[0] = (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2])) / BIT(13);
> > -		h[1] = (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2])) / BIT(13);
> > -		h[2] = (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2])) / BIT(13);
> > +			s[i] = xy1y2[i] - half_range;
> > +		h[0] = (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2])) / half_range;
> > +		h[1] = (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2])) / half_range;
> > +		h[2] = (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2])) / half_range;
> >  		for (i = 0; i < 3; i++) {
> > -			clamp_val(h[i], -BIT(13), BIT(13) - 1);
> > -			xy1y2[i] = h[i] + BIT(13);
> > +			h[i] = clamp(h[i], -half_range, half_range - 1);
> > +			xy1y2[i] = h[i] + half_range;
> >  		}
> >  	}
> > 
> > --
> > 2.43.0  
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 


