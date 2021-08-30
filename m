Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6696F3FB480
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 13:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhH3LZJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 07:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235387AbhH3LZJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 07:25:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60917610E8;
        Mon, 30 Aug 2021 11:24:13 +0000 (UTC)
Date:   Mon, 30 Aug 2021 12:27:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v8 09/14] iio: afe: rescale: fix accuracy for small
Message-ID: <20210830122724.2722c086@jic23-huawei>
In-Reply-To: <YSsP8aWU2uFBOt6M@shaak>
References: <YSVWZcjW8QoDaSpN@shaak>
        <c63fb63f-884d-0ffb-b25c-bac591f169f7@axentia.se>
        <YSsP8aWU2uFBOt6M@shaak>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 29 Aug 2021 00:41:21 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> On Thu, Aug 26, 2021 at 11:53:14AM +0200, Peter Rosin wrote:
> > On 2021-08-24 22:28, Liam Beguin wrote:  
> > > On Mon Aug 23, 2021 at 00:18:55 +0200, Peter Rosin wrote:  
> > >> [I started to write an answer to your plans in the v7 thread, but didn't
> > >> have time to finish before v8 appeared...]
> > >>
> > >> On 2021-08-20 21:17, Liam Beguin wrote:  
> > >>> From: Liam Beguin <lvb@xiphos.com>
> > >>>
> > >>> The approximation caused by integer divisions can be costly on smaller
> > >>> scale values since the decimal part is significant compared to the
> > >>> integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
> > >>> cases to maintain accuracy.  
> > >>  
> > > 
> > > Hi Peter,
> > > 
> > > Thanks for taking time to look at this in detail again. I really
> > > appreciate all the feedback you've provided.
> > >   
> > >> The conversion to int-plus-nano may also carry a cost of accuracy.
> > >>
> > >> 90/1373754273 scaled by 261/509 is 3.359e-8, the old code returns 3.348e-8,
> > >> but the new one gets you 3.3e-8 (0.000000033, it simply cannot provide more
> > >> digits). So, in this case you lose precision with the new code.
> > >>
> > >> Similar problem with 100 / 2^30 scaled by 3782/7000. It is 5.032e-8, the old
> > >> code returns 5.029e-8, but the new one gets you the inferior 5.0e-8.
> > >>  
> > > 
> > > I see what you mean here.
> > > I added test cases with these values to see exactly what we get.  
> > 
> > Excellent!
> >   
> > > 
> > > Expected rel_ppm < 0, but
> > >     rel_ppm == 1000000
> > > 
> > >      real=0.000000000
> > >  expected=0.000000033594
> > > # iio_rescale_test_scale: not ok 42 - v8 - 90/1373754273 scaled by 261/509
> > > Expected rel_ppm < 0, but
> > >     rel_ppm == 1000000
> > > 
> > >      real=0.000000000
> > >  expected=0.000000050318
> > > # iio_rescale_test_scale: not ok 43 - v8 - 100/1073741824 scaled by 3782/7000
> > > 
> > > 
> > > The main issue is that the first two examples return 0 which night be worst
> > > that loosing a little precision.  
> > 
> > They shouldn't return zero?
> > 
> > Here's the new code quoted from the test robot (and assuming
> > a 64-bit machine, thus ignoring the 32-bit problem on line 56).
> > 
> >     36		case IIO_VAL_FRACTIONAL:
> >     37		case IIO_VAL_FRACTIONAL_LOG2:
> >     38			tmp = (s64)*val * 1000000000LL;
> >     39			tmp = div_s64(tmp, rescale->denominator);
> >     40			tmp *= rescale->numerator;
> >     41	
> >     42			tmp = div_s64_rem(tmp, 1000000000LL, &rem);
> >     43			*val = tmp;
> >     44	
> >     45			/*
> >     46			 * For small values, the approximation can be costly,
> >     47			 * change scale type to maintain accuracy.
> >     48			 *
> >     49			 * 100 vs. 10000000 NANO caps the error to about 100 ppm.
> >     50			 */
> >     51			if (scale_type == IIO_VAL_FRACTIONAL)
> >     52				tmp = *val2;
> >     53			else
> >     54				tmp = 1 << *val2;
> >     55	  
> >   > 56			 if (abs(rem) > 10000000 && abs(*val / tmp) < 100) {  
> >     57				 *val = div_s64_rem(*val, tmp, &rem2);
> >     58	
> >     59				 *val2 = div_s64(rem, tmp);
> >     60				 if (rem2)
> >     61					 *val2 += div_s64(rem2 * 1000000000LL, tmp);
> >     62	
> >     63				 return IIO_VAL_INT_PLUS_NANO;
> >     64			 }
> >     65	
> >     66			return scale_type;
> > 
> > When I go through the above manually, I get:
> > 
> > line 
> > 38: tmp = 90000000000    ; 90 * 1000000000
> > 39: tmp = 176817288      ; 90000000000 / 509
> > 40: tmp = 46149312168    ; 176817288 * 261
> > 42: rem = 149312168      ; 46149312168 % 1000000000
> >     tmp = 46             ; 46149312168 / 1000000000
> > 43: *val = 46
> > 51: if (<fractional>) [yes]
> > 52: tmp = 1373754273
> > 56: if (149312168 > 10000000 && 46/1373754273 < 100) [yes && yes]
> > 57: rem2 = 46            ; 46 % 1373754273
> >     *val = 0             ; 46 / 1373754273
> > 59: *val2 = 0            ; 149312168 / 1373754273
> > 60: if 46 [yes]
> > 61: *val2 = 33           ; 0 + 46 * 1000000000 / 1373754273
> > 63: return <int-plus-nano> [0.000000033]
> > 
> > and
> > 
> > line 
> > 38: tmp = 100000000000   ; 100 * 1000000000
> > 39: tmp = 14285714       ; 100000000000 / 7000
> > 40: tmp = 54028570348    ; 176817288 * 3782
> > 42: rem = 28570348       ; 54028570348 % 1000000000
> >     tmp = 54             ; 54028570348 / 1000000000
> > 43: *val = 54
> > 51: if (<fractional>) [no]
> > 54: tmp = 1073741824     ; 1 << 30
> > 56: if (28570348 > 10000000 && 54/1073741824 < 100) [yes && yes]
> > 57: rem2 = 54            ; 54 % 1073741824
> >     *val = 0             ; 54 / 1073741824
> > 59: *val2 = 0            ; 28570348 / 1073741824
> > 60: if 46 [yes]
> > 61: *val2 = 50           ; 0 + 54 * 1000000000 / 1073741824
> > 63: return <int-plus-nano> [0.000000050]
> > 
> > Why do you get zero, what am I missing?  
> 
> So... It turns out, I swapped schan and rescaler values which gives us:
> 
> numerator = 90
> denominator = 1373754273
> schan_val = 261
> schan_val2 = 509
> 
> line
> 38: tmp = 261000000000   ; 261 * 1000000000
> 39: tmp = 189            ; 261000000000 / 1373754273
> 40: tmp = 17010          ; 189 * 90
> 42: rem = 17010          ; 17010 % 1000000000
>     tmp = 0              ; 17010 / 1000000000
> 43: *val = 0
> 51: if (<fractional>) [yes]
> 52: tmp = 509
> 56: if (17010 > 10000000 && 0/509 < 100) [no && yes]
> 66: *val = 0
>     *val2 = 509
>     return <fractional> [0.000000000]
> 
> Swapping back the values, I get the same results as you!
> 
> Also, replacing line 56 from the snippet above with
> 
> 	- if (abs(rem) > 10000000 && abs(div64_s64(*val, tmp)) < 100) {
> 	+ if (abs(rem)) {
> 
> Fixes these precision errors. It also prevents us from returning
> different scales if we swap the two divisions (schan and rescaler
> parameters).
> 
> >   
> > > At the same time, I wonder how "real" these values would be. Having such a
> > > small scale would mean having a large raw value. With 16-bits of resolution,
> > > that would still give about (1 << 16) * 3.3594e-08 = 0.002201616 mV.  
> > 
> > If we cap at 16 bits it sounds as if we probably erase some precision
> > provided by 24-bit ADCs. We have drivers for those. I didn't really
> > dig that deep in the driver offerings, but I did find a AD7177 ADC
> > (but no driver) which is 32-bit. If we don't have any 32-bit ADC driver
> > yet, it's only a matter of time, methinks. I have personally worked
> > with 24-bit DACs, and needed every last bit...
> >   
> 
> I was only using 16-bits as an example, but I guess you're right, these
> values do start to make sense when you're looking at 24-bit and 32-bit
> ADCs.

I'd be tempted to be cynical on this.  High resolution devices are rare
as frankly building a low enough noise board to take advantage is hard.
Known users of the AFE infrastructure also rare and so as long as we don't
break any 'current' users via loss of accuracy I'm not that bothered if
we aren't perfect for 32 bit devices. 

I'm guessing we can sometimes sanity check if an overflow will occur
at probe?  Perhaps do that where possible and print something obvious
to the log.  Then someone who needs it can figure out the magic maths
to do this for those high resolution devices!

> 
> > > We could try to get more precision out of the first division
> > > 
> > > 	tmp = (s64)*val * 1000000000LL;
> > > 	tmp = div_s64(tmp, rescale->denominator);
> > > 	tmp *= rescale->numerator;
> > > 	tmp = div_s64_rem(tmp, 1000000000LL, &rem);
> > > 
> > > But then, we'd be more likely to overflow. What would be a good middle
> > > ground?  
> > 
> > I don't think we can settle for anything that makes any existing case
> > worse. That's a regression waiting to happen, and what to do then?
> >   
> 
> Agreed, and looking at this more, there's still ways to improve without
> having to compromise.
> Hopefully adding the test suite will make it easier to catch potential
> regressions in the future :-)

Absolutely.  Have that test suite is great :)

> 
> > >> I'm also wondering if it is wise to not always return the same scale type?
> > >> What happens if we want to extend this driver to scale a buffered channel?
> > >> Honest question! I don't know, but I fear that this patch may make that
> > >> step more difficult to take??  
> > > 
> > > That's a fair point, I didn't know it could be a problem to change
> > > scale.  
> > 
> > I don't *know* either? But it would not be completely alien to me if
> > the buffered case assumes "raw" numbers, and that there is little room
> > for "meta-data" with each sample.

Spot on.  Meta data is a pain so an early design decision in IIO was to
not support it in band.

> >   
> > >>
> > >> Jonathan, do you have any input on that?
> > >>
> > >> Some more examples of problematic properties of this patch:
> > >>
> > >> 21837/24041 scaled by 427/24727 is 0.01568544672, you get 0.015685446. Ok.
> > >> But if you reduce the input number, gcd(21837, 24041) -> 29, you have:
> > >> 753/829 scaled by 427/24727 which still is 0.01568544672 of course, but in
> > >> this case you get 0.01568154403. Which is less precise. It is unfortunate
> > >> that input that should be easier to scale may yield worse results.  
> > > 
> > > Expected rel_ppm < 0, but
> > >     rel_ppm == 0
> > > 
> > >      real=0.015685445
> > >  expected=0.015685446719
> > > # iio_rescale_test_scale: not ok 44 - v8 - 21837/24041 scaled by 427/24727
> > > Expected rel_ppm < 0, but
> > >     rel_ppm == 0
> > > 
> > >      real=0.015685445
> > >  expected=0.015685446719
> > > # iio_rescale_test_scale: not ok 45 - v8 - 753/829 scaled by 427/24727
> > > 
> > > It seems like both cases are rounded and give the same result. I do get
> > > your point though, values that could be simplified might loose more
> > > precision because of this change in scale type.  
> > 
> > I aimed at this:
> > 
> > line
> > 38: tmp = 21837000000000 ; 21837 * 1000000000
> > 39: tmp = 883123710      ; 21837000000000 / 24727
> > 40: tmp = 377093824170   ; 883123710 * 427
> > 42: rem = 93824170       ; 377093824170 % 1000000000
> >     tmp = 377            ; 377093824170 / 1000000000
> > 43: *val = 377
> > 51: if (<fractional>) [yes]
> > 52: tmp = 24041
> > 56: if (149312168 > 10000000 && 377/24041 < 100) [yes && yes]
> > 57: rem2 = 377           ; 377 % 24041
> >     *val = 0             ; 377 / 24041
> > 59: *val2 = 3902         ; 93824170 / 24041
> > 60: if 377 [yes]
> > 61: *val2 = 15685446     ; 3902 + 377 * 1000000000 / 24041
> > 63: return <int-plus-nano> [0.0015685446]
> > 
> > Why does the test output a 5 at the end and not a 6? It's all
> > integer arithmetic so there is no room for rounding issues.
> > 
> > and
> > 
> > line 
> > 38: tmp = 753000000000   ; 753 * 1000000000
> > 39: tmp = 30452541       ; 753000000000 / 24727
> > 40: tmp = 13003235007    ; 30452541 * 427
> > 42: rem = 3235007        ; 13003235007 % 1000000000
> >     tmp = 13             ; 13003235007 / 1000000000
> > 43: *val = 13
> > 51: if (<fractional>) [yes]
> > 52: tmp = 829
> > 56: if (3235007 > 10000000 && 13/829 < 100) [no && yes]
> > 66: return <fractional> [13/829 ~= 0.015681544]
> > 
> > 0.015681544 is pretty different from 0.015685446
> > 
> > Again, I don't understand what's going on.
> >   
> > >>
> > >> 760/1373754273 scaled by 427/2727 is 8.662580e-8, and 8.662393e-8 is
> > >> returned. Which is perhaps not great accuracy, but such is life. However.
> > >> 761/1373754273 scaled by 427/2727 is 8.673978e-8, which is of course
> > >> greater, but 8.6e-8 is returned. Which is less than what was returned for
> > >> the smaller 760/1373754273 value above.  
> > > 
> > > Expected rel_ppm < 0, but
> > >     rel_ppm == 1000000
> > > 
> > >      real=0.000000000
> > >  expected=0.000000086626
> > > # iio_rescale_test_scale: not ok 46 - v8 - 760/1373754273 scaled by 427/2727
> > > Expected rel_ppm < 0, but
> > >     rel_ppm == 1000000
> > > 
> > >      real=0.000000000
> > >  expected=0.000000086740
> > > # iio_rescale_test_scale: not ok 47 - v8 - 761/1373754273 scaled by 427/2727
> > > 
> > > We fall into the same case as the first two examples where the real value is
> > > null.  
> > 
> > I aimed at
> > 
> > line
> > 38: tmp = 760000000000   ; 760 * 1000000000
> > 39: tmp = 278694536      ; 760000000000 / 2727
> > 40: tmp = 119002566872   ; 278694536 * 427
> > 42: rem = 2566872        ; 119002566872 % 1000000000
> >     tmp = 119            ; 119002566872 / 1000000000
> > 43: *val = 119
> > 51: if (<fractional>) [yes]
> > 52: tmp = 1373754273
> > 56: if (2566872 > 10000000 && 119/1373754273 < 100) [no && yes]
> > 66: return <fractional> [119/1373754273 ~= 0.000000086624]
> > 
> > and
> > 
> > line
> > 38: tmp = 761000000000   ; 761 * 1000000000
> > 39: tmp = 279061239      ; 761000000000 / 2727
> > 40: tmp = 119159149053   ; 279061239 * 427
> > 42: rem = 159149053      ; 119159149053 % 1000000000
> >     tmp = 119            ; 119159149053 / 1000000000
> > 43: *val = 119
> > 51: if (<fractional>) [yes]
> > 52: tmp = 1373754273
> > 56: if (159149053 > 10000000 && 119/1373754273 < 100) [yes && yes]
> > 57: rem2 = 119           ; 119 % 1373754273
> >     *val = 0             ; 119 / 1373754273
> > 59: *val2 = 0            ; 159149053 / 1373754273
> > 60: if 119 [yes]
> > 61: *val2 = 86           ; 0 + 119 * 1000000000 / 1373754273
> > 63: return <int-plus-nano> [0.000000086]
> >   
> > > Considering these null values and the possible issue of not always having the
> > > same scale type, would it be better to always return an IIO_VAL_INT_PLUS_NANO
> > > scale?  
> > 
> > No, that absolutely kills the precision for small values that are much
> > better off as-is. The closer you get to zero, the more the conversion
> > to int-plus-nano hurts, relatively speaking.  
> 
> I'm not sure I understand what you mean. The point of switching to
> IIO_VAL_INT_PLUS_NANO at the moment is to get more precision on small
> values. Am I missing something?
> 
> >   
> > >>
> > >> Some of these objections are related to what I talked about in v7, i.e.:
> > >>
> > >>     Also, changing the calculation so that you get more precision whenever that is
> > >>     possible feels dangerous. I fear linearity breaks and that bigger input cause
> > >>     smaller output due to rounding if the bigger value has to be rounded down, but
> > >>     that this isn't done carefully enough. I.e. attempting to return an exact
> > >>     fraction and only falling back to the old code when that is not possible is
> > >>     still not safe since the old code isn't careful enough about rounding. I think
> > >>     it is really important that bigger input cause bigger (or equal) output.
> > >>     Otherwise you might trigger instability in feedback loops should a rescaler be
> > >>     involved in a some regulator function.  
> > > 
> > > I think I didn't read this closely enought the first time around. I agree that
> > > bigger inputs should cause bigger outputs, especially with these rounding
> > > errors. My original indention was to have all scales withing a tight margin,
> > > that's why I ended up going with ppm for the test cases.
> > >   
> > >>
> > >> Sadly, I see no elegant solution to your problem.
> > >>
> > >> One way forward may be to somehow provide information on the expected
> > >> input range, and then determine the scaling method based on that
> > >> instead of the individual values. But, as indicated, there's no real
> > >> elegance in that. It can't be automated...  
> > > 
> > > I guess the issue with that is that unless it's a user parameter, we're
> > > always going go have these little islands you mentioned in v7...
> > > 
> > > Would it be viable to guaranty a MICRO precision instead of NANO, and
> > > not have the range parameter?  
> > 
> > I don't get what you mean here? Returning int-plus-micro can't be it,
> > since that would be completely pointless and only make it easier to
> > trigger accuracy problems of the conversion. However, I feel that any
> > attempt to shift digits but still having the same general approch will
> > just change the size and position of the islands, and thus not fix the
> > fundamental problematic border between land and water.  
> 
> My apologies, discard this last comment. I was suggesting to guaranty
> less precision, but consistent over the full range. I don't believe
> that's a viable option.

Keep up the good work!  I'm looking forward to this going in (hopefully
shortly!)

Jonathan

> 
> Thanks again for your time,
> Liam
> 
> > 
> > Cheers,
> > Peter
> >   
> > >>  
> > >>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > >>> ---
> > >>>  drivers/iio/afe/iio-rescale.c | 27 +++++++++++++++++++++++++--
> > >>>  1 file changed, 25 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> > >>> index c408c4057c08..7304306c9806 100644
> > >>> --- a/drivers/iio/afe/iio-rescale.c
> > >>> +++ b/drivers/iio/afe/iio-rescale.c
> > >>> @@ -22,7 +22,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
> > >>>  			  int *val, int *val2)
> > >>>  {
> > >>>  	s64 tmp;
> > >>> -	s32 rem;
> > >>> +	s32 rem, rem2;
> > >>>  	u32 mult;
> > >>>  	u32 neg;
> > >>>  
> > >>> @@ -38,8 +38,31 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
> > >>>  		tmp = (s64)*val * 1000000000LL;
> > >>>  		tmp = div_s64(tmp, rescale->denominator);
> > >>>  		tmp *= rescale->numerator;
> > >>> -		tmp = div_s64(tmp, 1000000000LL);
> > >>> +
> > >>> +		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
> > >>>  		*val = tmp;
> > >>> +
> > >>> +		/*
> > >>> +		 * For small values, the approximation can be costly,
> > >>> +		 * change scale type to maintain accuracy.
> > >>> +		 *
> > >>> +		 * 100 vs. 10000000 NANO caps the error to about 100 ppm.
> > >>> +		 */
> > >>> +		if (scale_type == IIO_VAL_FRACTIONAL)
> > >>> +			tmp = *val2;
> > >>> +		else
> > >>> +			tmp = 1 << *val2;
> > >>> +
> > >>> +		 if (abs(rem) > 10000000 && abs(*val / tmp) < 100) {
> > >>> +			 *val = div_s64_rem(*val, tmp, &rem2);
> > >>> +
> > >>> +			 *val2 = div_s64(rem, tmp);
> > >>> +			 if (rem2)
> > >>> +				 *val2 += div_s64(rem2 * 1000000000LL, tmp);  
> > >>
> > >> rem2 is 32-bit. Might 1000000000LL also be 32-bit on a small machine
> > >> where 64-bit arithmetic is really expensive? In that case, the above
> > >> is broken. The safe route is to do these things as in the existing
> > >> code with a cast to s64. But maybe that's just cargo cult crap?  
> > > 
> > > You're right, this should be
> > > 
> > > 	div_s64((s64)rem2 * 1000000000LL, tmp);
> > > 
> > > I've been trying th get the kunit tests running on a 32-bit kernel image, but
> > > I'm still having issues with that...
> > > 
> > > Thanks,
> > > Liam
> > >   
> > >>
> > >> Cheers,
> > >> Peter
> > >>  
> > >>> +
> > >>> +			 return IIO_VAL_INT_PLUS_NANO;
> > >>> +		 }
> > >>> +
> > >>>  		return scale_type;
> > >>>  	case IIO_VAL_INT_PLUS_NANO:
> > >>>  	case IIO_VAL_INT_PLUS_MICRO:
> > >>>  
> > >>  

