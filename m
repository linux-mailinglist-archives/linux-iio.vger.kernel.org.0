Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926D73FA87F
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 06:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhH2ECL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 00:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbhH2ECB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Aug 2021 00:02:01 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5966FC0613D9;
        Sat, 28 Aug 2021 21:01:10 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id y144so11877228qkb.6;
        Sat, 28 Aug 2021 21:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fSSsuKoNeu1t947etf4vDYMxOrKjGwLy6/t/UlTfj6o=;
        b=Kk6XJubjL4GaTwzaHutlp4DKZV9qO8c2abHQZZ9pfQiYCCFRjMypyPrKzGRch16VHJ
         HLLqXpn3AigsHU5YhE+eHAoMF08XzbpqGm8kYRku+Y8JuKLE9MxByPcfoR4jS3bheNfi
         /noF9w/eoP3Z9BNzlrGxwwYFakE4UuxWzvH6+TCyFzgcrylayLmYRkJAhmGyF6+CTd7K
         uK1xugFyNFXyJmVqW9OuD9nnPn/LfqBiKnhyMlNyOW0mBHDVG8IvJvJuOVIaJWpl5h2n
         56WcstQJ/jnl2g6DhYiWYKanvGxLWAekA634y1imzHNuMC98ccCsGAfphKSIGuSZgyFN
         kpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fSSsuKoNeu1t947etf4vDYMxOrKjGwLy6/t/UlTfj6o=;
        b=FeYaqk+WDidkL2TbTv+xcGCfhYsK1Sql42h5CWZkLp37vsS+o5r2gaqB2u14Nffynp
         WWWRjV3Q64FN28dE5dQD6y1Fse5DtgJuYvKzBd4GWOcIwLW4ZmqDdxbZzt2hyNdBMQro
         UvZlz4ET4ORHEUtRpVViCzhnRUD3wA7B8iYpKGXUuwbhrNevOnlFkZYJZhvtsyZPwHlB
         LkgGe0H0Kz5UhYsnLTjgjsZcIXT3Jxps3yZ3ZX0rZZg/BS9UXF9pZm8AJyYz6GFIl7zc
         6YZlmZsPrSluhEvw4ClFR2s5hK9pCdcoDiJuG5KJK+w7JYXmmqvsTo9yJKH1RSGqFA7E
         XW2g==
X-Gm-Message-State: AOAM531sEDlAmXc2icJPf1gCHN3niAZKty8O+4E6adV3A5qhgeoAAeec
        aq/60NIEIYVvWRY5RN0Luks92Z0wZfs=
X-Google-Smtp-Source: ABdhPJz3g/1TqagtKcs0XvfepYQj3EF56jAwoEOE0maHdy0GMrxO+8BOWUSEOR9Pz2AOfXUGkfSI5A==
X-Received: by 2002:a05:620a:1495:: with SMTP id w21mr16409117qkj.443.1630209669426;
        Sat, 28 Aug 2021 21:01:09 -0700 (PDT)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id i2sm20448qkf.3.2021.08.28.21.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 21:01:08 -0700 (PDT)
Date:   Sun, 29 Aug 2021 00:01:07 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v8 08/14] iio: afe: rescale: reduce risk of integer
 overflow
Message-ID: <YSsGgwlnO7Wd7BDS@shaak>
References: <20210820191714.69898-1-liambeguin@gmail.com>
 <20210820191714.69898-9-liambeguin@gmail.com>
 <1e18e5b3-9335-ca55-3506-4b4cb19d5661@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e18e5b3-9335-ca55-3506-4b4cb19d5661@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 26, 2021 at 11:13:38AM +0200, Peter Rosin wrote:
> On 2021-08-20 21:17, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> > 
> > Reduce the risk of integer overflow by doing the scale calculation on
> > a 64-bit integer. Since the rescaling is only performed on *val, reuse
> > the IIO_VAL_FRACTIONAL_LOG2 case.
> 
> While this patch certainly helps with overflow problems, it also
> potentially kills precision in some cases where there currently are
> no overflow issues.
> 
> E.g. this patch transforms 5/32768 scaled by 3/10000 from the exact
> 
> 15 / 327680000 (0.0000000457763671875)
> 
> to the heavily truncated plain old sorry "zero".
> 
> Sure, 9/14 improves the situation, but patch 9/14 simply cannot
> make this example any better than returning 2 significant digits
> since the value is so small.

The 100 ppm check introduced in 09/14 is really objective and might not
be the best choice. Changing it to

	- if (abs(rem) > 10000000 && abs(div64_s64(*val, tmp)) < 100) {
	+ if (abs(rem)) {

Helps with the precision issues you brought up here, and in 09/14.
I was originally trying to keep the original scale as much as possible,
I'll continue the rest of the discussion on the 09/14 thread we already
have.

> 
> Side note, there is also the same type of risk of overflow for
> IIO_VAL_INT. Why does that case not get the same treatment as
> IIO_VAL_FRACTIONAL?
> 

Being totally honest, I noticed we have the same issue with IIO_VAL_INT,
but since I didn't run into the issue on my setup I left it out to focus
on getting the rest cleaned up.

I guess it couldn't hurt to fix that too while we're at it.
I'll work on it!

> But again, I see no elegant solution. The best I can think of is the
> inelegant solution to provide extra info on the input range, the
> exact desired scaling method, the desired output type, some mix of
> all of the above or something else that helps determining the
> appropriate scaling method w/o looking at the individual number.

I don't really like having to add a range parameter.
If changing the scale type dynamically isn't an issue, I think we can
get away with not adding a parameter.
If it is an issue, we might have to look into it...

Thanks,
Liam

> 
> Cheers,
> Peter
> 
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> > index 809e966f7058..c408c4057c08 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -27,16 +27,13 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
> >  	u32 neg;
> >  
> >  	switch (scale_type) {
> > -	case IIO_VAL_FRACTIONAL:
> > -		*val *= rescale->numerator;
> > -		*val2 *= rescale->denominator;
> > -		return scale_type;
> >  	case IIO_VAL_INT:
> >  		*val *= rescale->numerator;
> >  		if (rescale->denominator == 1)
> >  			return scale_type;
> >  		*val2 = rescale->denominator;
> >  		return IIO_VAL_FRACTIONAL;
> > +	case IIO_VAL_FRACTIONAL:
> >  	case IIO_VAL_FRACTIONAL_LOG2:
> >  		tmp = (s64)*val * 1000000000LL;
> >  		tmp = div_s64(tmp, rescale->denominator);
> > 
> 
