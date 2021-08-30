Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDCB3FB471
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 13:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbhH3LUK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 07:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235387AbhH3LUK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 07:20:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 741396112D;
        Mon, 30 Aug 2021 11:19:14 +0000 (UTC)
Date:   Mon, 30 Aug 2021 12:22:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Liam Beguin <liambeguin@gmail.com>, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v8 09/14] iio: afe: rescale: fix accuracy for small
 fractional scales
Message-ID: <20210830122224.3efc5a63@jic23-huawei>
In-Reply-To: <2d028a60-d1fe-7fa1-da4a-0d80f8d468ea@axentia.se>
References: <20210820191714.69898-1-liambeguin@gmail.com>
        <20210820191714.69898-10-liambeguin@gmail.com>
        <2d028a60-d1fe-7fa1-da4a-0d80f8d468ea@axentia.se>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Aug 2021 00:18:55 +0200
Peter Rosin <peda@axentia.se> wrote:

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
> The conversion to int-plus-nano may also carry a cost of accuracy.
> 
> 90/1373754273 scaled by 261/509 is 3.359e-8, the old code returns 3.348e-8,
> but the new one gets you 3.3e-8 (0.000000033, it simply cannot provide more
> digits). So, in this case you lose precision with the new code.
> 
> Similar problem with 100 / 2^30 scaled by 3782/7000. It is 5.032e-8, the old
> code returns 5.029e-8, but the new one gets you the inferior 5.0e-8.
> 
> I'm also wondering if it is wise to not always return the same scale type?
> What happens if we want to extend this driver to scale a buffered channel?
> Honest question! I don't know, but I fear that this patch may make that
> step more difficult to take??
> 
> Jonathan, do you have any input on that?

I'm a bit lost.  As things currently stand IIO buffered data flows all use
_RAW.  It's either up to userspace or the inkernel user to query scale
and use that to compute the appropriate _processed values.  There have been
various discussions over the years on how to add metadata but it's tricky
without adding significant complexity and for vast majority of usecases not
necessary.  Given the rescaler copes with _raw and _processed inputs, we
would only support buffered flows if using the _raw ones.

If nothing changes in configuration of the rescaler, the scale should be
static for a given device.  What format that 'scale' takes is something
that userspace code or inkernel users should cope fine with given they
need to do that anyway for different devices.

Jonathan


> 
> Some more examples of problematic properties of this patch:
> 
> 21837/24041 scaled by 427/24727 is 0.01568544672, you get 0.015685446. Ok.
> But if you reduce the input number, gcd(21837, 24041) -> 29, you have:
> 753/829 scaled by 427/24727 which still is 0.01568544672 of course, but in
> this case you get 0.01568154403. Which is less precise. It is unfortunate
> that input that should be easier to scale may yield worse results.
> 
> 760/1373754273 scaled by 427/2727 is 8.662580e-8, and 8.662393e-8 is
> returned. Which is perhaps not great accuracy, but such is life. However.
> 761/1373754273 scaled by 427/2727 is 8.673978e-8, which is of course
> greater, but 8.6e-8 is returned. Which is less than what was returned for
> the smaller 760/1373754273 value above.
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
> 
> Sadly, I see no elegant solution to your problem.
> 
> One way forward may be to somehow provide information on the expected
> input range, and then determine the scaling method based on that
> instead of the individual values. But, as indicated, there's no real
> elegance in that. It can't be automated...
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

