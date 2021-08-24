Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935A13F6A61
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 22:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhHXU3N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 16:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhHXU3M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 16:29:12 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510D6C061757;
        Tue, 24 Aug 2021 13:28:25 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b64so10821077qkg.0;
        Tue, 24 Aug 2021 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=MljK3PLZzRJ/Nu5jyOet8tAx8GtKQDOv8ezr+rdqbS4=;
        b=TW6Iqf2c37Vx+rJ0G6FNrfQUoUv42SAL7fQorfyTuUzULE1O5CeiyeWFdFuVSC2GSE
         fgv3einHPmnWVvylVSTXx/JOgTB5Vk1X8j0+8ZoJNZcD0KS0bJ4sqHWvs1t98XFrwk2c
         C9PSype7Xsh5Cbl7PxY/AyCpgJ48xWj5e7V1/UgNKyMHzMqlltHDNBdwreFzeGTcsAiL
         8EedEPjj8XxRBuoH7ruf63+g2uHD7j8IZaZxld28MqSsy1Pg4vajiaGmbDmtBaI/wG6M
         0GWyzxcLAFFUJyROd+/1v/9a7nkOkHNEhly3EMfW0kZwndfVHyH/3KZwQATtCzOseLtc
         ay1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=MljK3PLZzRJ/Nu5jyOet8tAx8GtKQDOv8ezr+rdqbS4=;
        b=g/kHztEwyhYbbBDCVAeQ9W9MzebApoYj5lWLSllbP2T/GCFhAJxZK8dbEUwBO+m+6v
         dh+zXlgsSztoNXzAKECuBjWwJeW30PuRL3/aPV669vOlqv1IAARPxPfLHho1kvUXBwyD
         Yj3WoPXAzwTHFqYDIbxAsvEQ1GwNcFyL7/71KAQwuup1pSqf+w2wjGvHaFN5uqoWq9FI
         0Z08WPw6nSIImtiLPAy89vPiLIGERNAHNNxsxPwjFkr2DfZWmByhc2o78a5JK+0uJKqt
         I91GUiwDGS2wvGFscE3G31KqdaErZT7U8fDCRAywQDvlWEKmnzxxcd6eIj0cfv9L64yu
         9mBg==
X-Gm-Message-State: AOAM532Avk9CxIMJ+gq4XUkwNHHlbfOQIVqxPeBhP6u10IKL+QGq7WEu
        09WJwSlI18u4qdVVLQDyYWFXDPAS3OM=
X-Google-Smtp-Source: ABdhPJzpM87ltr/K8kgzcIL120p8yqOpY/aQTLGWoXAtQ54etEetW4e+TymXGf1WAu2tK7flOqWd+w==
X-Received: by 2002:a05:620a:c05:: with SMTP id l5mr28827399qki.17.1629836904336;
        Tue, 24 Aug 2021 13:28:24 -0700 (PDT)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id y15sm11417784qko.78.2021.08.24.13.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 13:28:23 -0700 (PDT)
Date:   Tue, 24 Aug 2021 16:28:21 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Peter Rosin <peda@axentia.se>, jic23@kernel.org, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v8 09/14] iio: afe: rescale: fix accuracy for small
Message-ID: <YSVWZcjW8QoDaSpN@shaak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d028a60-d1fe-7fa1-da4a-0d80f8d468ea@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon Aug 23, 2021 at 00:18:55 +0200, Peter Rosin wrote:
> [I started to write an answer to your plans in the v7 thread, but didn't
> have time to finish before v8 appeared...]
> 
> On 2021-08-20 21:17, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> > 
> > The approximation caused by integer divisions can be costly on smaller
> > scale values since the decimal part is significant compared to the
> > integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
> > cases to maintain accuracy.
> 

Hi Peter,

Thanks for taking time to look at this in detail again. I really
appreciate all the feedback you've provided.

> The conversion to int-plus-nano may also carry a cost of accuracy.
> 
> 90/1373754273 scaled by 261/509 is 3.359e-8, the old code returns 3.348e-8,
> but the new one gets you 3.3e-8 (0.000000033, it simply cannot provide more
> digits). So, in this case you lose precision with the new code.
> 
> Similar problem with 100 / 2^30 scaled by 3782/7000. It is 5.032e-8, the old
> code returns 5.029e-8, but the new one gets you the inferior 5.0e-8.
> 

I see what you mean here.
I added test cases with these values to see exactly what we get.

Expected rel_ppm < 0, but
    rel_ppm == 1000000

     real=0.000000000
 expected=0.000000033594
# iio_rescale_test_scale: not ok 42 - v8 - 90/1373754273 scaled by 261/509
Expected rel_ppm < 0, but
    rel_ppm == 1000000

     real=0.000000000
 expected=0.000000050318
# iio_rescale_test_scale: not ok 43 - v8 - 100/1073741824 scaled by 3782/7000


The main issue is that the first two examples return 0 which night be worst
that loosing a little precision.

At the same time, I wonder how "real" these values would be. Having such a
small scale would mean having a large raw value. With 16-bits of resolution,
that would still give about (1 << 16) * 3.3594e-08 = 0.002201616 mV.

We could try to get more precision out of the first division

	tmp = (s64)*val * 1000000000LL;
	tmp = div_s64(tmp, rescale->denominator);
	tmp *= rescale->numerator;
	tmp = div_s64_rem(tmp, 1000000000LL, &rem);

But then, we'd be more likely to overflow. What would be a good middle
ground?

> I'm also wondering if it is wise to not always return the same scale type?
> What happens if we want to extend this driver to scale a buffered channel?
> Honest question! I don't know, but I fear that this patch may make that
> step more difficult to take??

That's a fair point, I didn't know it could be a problem to change
scale.

> 
> Jonathan, do you have any input on that?
> 
> Some more examples of problematic properties of this patch:
> 
> 21837/24041 scaled by 427/24727 is 0.01568544672, you get 0.015685446. Ok.
> But if you reduce the input number, gcd(21837, 24041) -> 29, you have:
> 753/829 scaled by 427/24727 which still is 0.01568544672 of course, but in
> this case you get 0.01568154403. Which is less precise. It is unfortunate
> that input that should be easier to scale may yield worse results.

Expected rel_ppm < 0, but
    rel_ppm == 0

     real=0.015685445
 expected=0.015685446719
# iio_rescale_test_scale: not ok 44 - v8 - 21837/24041 scaled by 427/24727
Expected rel_ppm < 0, but
    rel_ppm == 0

     real=0.015685445
 expected=0.015685446719
# iio_rescale_test_scale: not ok 45 - v8 - 753/829 scaled by 427/24727

It seems like both cases are rounded and give the same result. I do get
your point though, values that could be simplified might loose more
precision because of this change in scale type.

> 
> 760/1373754273 scaled by 427/2727 is 8.662580e-8, and 8.662393e-8 is
> returned. Which is perhaps not great accuracy, but such is life. However.
> 761/1373754273 scaled by 427/2727 is 8.673978e-8, which is of course
> greater, but 8.6e-8 is returned. Which is less than what was returned for
> the smaller 760/1373754273 value above.

Expected rel_ppm < 0, but
    rel_ppm == 1000000

     real=0.000000000
 expected=0.000000086626
# iio_rescale_test_scale: not ok 46 - v8 - 760/1373754273 scaled by 427/2727
Expected rel_ppm < 0, but
    rel_ppm == 1000000

     real=0.000000000
 expected=0.000000086740
# iio_rescale_test_scale: not ok 47 - v8 - 761/1373754273 scaled by 427/2727

We fall into the same case as the first two examples where the real value is
null.

Considering these null values and the possible issue of not always having the
same scale type, would it be better to always return an IIO_VAL_INT_PLUS_NANO
scale?

> 
> Some of these objections are related to what I talked about in v7, i.e.:
> 
>     Also, changing the calculation so that you get more precision whenever that is
>     possible feels dangerous. I fear linearity breaks and that bigger input cause
>     smaller output due to rounding if the bigger value has to be rounded down, but
>     that this isn't done carefully enough. I.e. attempting to return an exact
>     fraction and only falling back to the old code when that is not possible is
>     still not safe since the old code isn't careful enough about rounding. I think
>     it is really important that bigger input cause bigger (or equal) output.
>     Otherwise you might trigger instability in feedback loops should a rescaler be
>     involved in a some regulator function.

I think I didn't read this closely enought the first time around. I agree that
bigger inputs should cause bigger outputs, especially with these rounding
errors. My original indention was to have all scales withing a tight margin,
that's why I ended up going with ppm for the test cases.

> 
> Sadly, I see no elegant solution to your problem.
> 
> One way forward may be to somehow provide information on the expected
> input range, and then determine the scaling method based on that
> instead of the individual values. But, as indicated, there's no real
> elegance in that. It can't be automated...

I guess the issue with that is that unless it's a user parameter, we're
always going go have these little islands you mentioned in v7...

Would it be viable to guaranty a MICRO precision instead of NANO, and
not have the range parameter?

> 
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 27 +++++++++++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> > index c408c4057c08..7304306c9806 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -22,7 +22,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
> >  			  int *val, int *val2)
> >  {
> >  	s64 tmp;
> > -	s32 rem;
> > +	s32 rem, rem2;
> >  	u32 mult;
> >  	u32 neg;
> >  
> > @@ -38,8 +38,31 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
> >  		tmp = (s64)*val * 1000000000LL;
> >  		tmp = div_s64(tmp, rescale->denominator);
> >  		tmp *= rescale->numerator;
> > -		tmp = div_s64(tmp, 1000000000LL);
> > +
> > +		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
> >  		*val = tmp;
> > +
> > +		/*
> > +		 * For small values, the approximation can be costly,
> > +		 * change scale type to maintain accuracy.
> > +		 *
> > +		 * 100 vs. 10000000 NANO caps the error to about 100 ppm.
> > +		 */
> > +		if (scale_type == IIO_VAL_FRACTIONAL)
> > +			tmp = *val2;
> > +		else
> > +			tmp = 1 << *val2;
> > +
> > +		 if (abs(rem) > 10000000 && abs(*val / tmp) < 100) {
> > +			 *val = div_s64_rem(*val, tmp, &rem2);
> > +
> > +			 *val2 = div_s64(rem, tmp);
> > +			 if (rem2)
> > +				 *val2 += div_s64(rem2 * 1000000000LL, tmp);
> 
> rem2 is 32-bit. Might 1000000000LL also be 32-bit on a small machine
> where 64-bit arithmetic is really expensive? In that case, the above
> is broken. The safe route is to do these things as in the existing
> code with a cast to s64. But maybe that's just cargo cult crap?

You're right, this should be

	div_s64((s64)rem2 * 1000000000LL, tmp);

I've been trying th get the kunit tests running on a 32-bit kernel image, but
I'm still having issues with that...

Thanks,
Liam

> 
> Cheers,
> Peter
> 
> > +
> > +			 return IIO_VAL_INT_PLUS_NANO;
> > +		 }
> > +
> >  		return scale_type;
> >  	case IIO_VAL_INT_PLUS_NANO:
> >  	case IIO_VAL_INT_PLUS_MICRO:
> > 
> 
