Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FE6407AC6
	for <lists+linux-iio@lfdr.de>; Sun, 12 Sep 2021 01:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhIKXVv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Sep 2021 19:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhIKXVv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Sep 2021 19:21:51 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1B3C061574;
        Sat, 11 Sep 2021 16:20:38 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 4so3772501qvp.3;
        Sat, 11 Sep 2021 16:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gDvp0kzxS8IqGS2HqiBTnWvzXm/5/CWVV7jFnhxmvBs=;
        b=Kfdc7GmDuKugBerM7HGzpQ6eiujv5xzzYIluryXoeMQFgr/fn0+hVCsU0ysuXHy5dC
         fdQsFTGdZoBKv3GNY5L0BlOJHR9ijCR5GpmLPSAHfUtkeWcPWlCsaG8IWbXYrqefNEXe
         gOYoIuhZw3BCH3WyObZzyUDjXgN5krXHK0NTqaeh691uP9bNbaCxqy3k+Q7pph4flBbx
         ezIBiZKAoFqOmkQPs11MqIxjr0W275+PGxc5rC/9AXBK7QNgDNMkyHLImD6pBuKhIUH7
         Daj5u5BaPFaOEb36LS4dVjfXtsVnSeokS1S+qKQTpXP+SUHGbEfuaH0uqWPdPEt3Bp7c
         F0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gDvp0kzxS8IqGS2HqiBTnWvzXm/5/CWVV7jFnhxmvBs=;
        b=zW6xIw1O9uxOuzm0Fti0V+bCsdzCbTqKKHGljhvmrjOs00+Y0/cAtKTYWv+ZDVtn+V
         iex+AZzT/Q7RGh4X965xB6ufe2cW45Hf7ozWm2v6PVLsiyjjKcZbl1jPrX6zlbTt8DW3
         QYwzOARmiN+3rEv5/fAeKJdSHgjDwiHlg60AcoBrUhTH8jIju5+Tj9tDx4zxLkKpIjJi
         A5Juo5Ilseruz+zkrSVH86XrkW7+E40tzMUsU8j2uFqb9qqygy/NA0zwqt3VxeTTUBZS
         C25SSS6Yo93MgH4ln7q+tstEpH44aOylBVRWZD2fJbWKop2WXWF0wPgDjUzKciDFTiCy
         TPAg==
X-Gm-Message-State: AOAM530gXXQy+1LqoxEY/UmTskBLQ55DN8zwi34yAc9wjpqJCid0peDx
        YsZIDcWoQE7f2J3pU86OWXE=
X-Google-Smtp-Source: ABdhPJwF2ofOIlYfgei2IHG4OOowsOIyOup0zzm+ToR0kl9/1YMB/X+lO3CIq89qVRVMJqTq9YwJHw==
X-Received: by 2002:a05:6214:2d1:: with SMTP id g17mr3798877qvu.63.1631402436996;
        Sat, 11 Sep 2021 16:20:36 -0700 (PDT)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h12sm1733316qth.1.2021.09.11.16.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 16:20:36 -0700 (PDT)
Date:   Sat, 11 Sep 2021 19:20:34 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v8 09/14] iio: afe: rescale: fix accuracy for small
Message-ID: <YT05wgzDT1r2KdpO@shaak>
References: <YSVWZcjW8QoDaSpN@shaak>
 <c63fb63f-884d-0ffb-b25c-bac591f169f7@axentia.se>
 <YSsP8aWU2uFBOt6M@shaak>
 <d714a5ca-07d6-1e6b-53d6-3353fe24e485@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d714a5ca-07d6-1e6b-53d6-3353fe24e485@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 30, 2021 at 03:03:52PM +0200, Peter Rosin wrote:
> On 2021-08-29 06:41, Liam Beguin wrote:
> > On Thu, Aug 26, 2021 at 11:53:14AM +0200, Peter Rosin wrote:
> >> On 2021-08-24 22:28, Liam Beguin wrote:
> >>> On Mon Aug 23, 2021 at 00:18:55 +0200, Peter Rosin wrote:
> >>>> [I started to write an answer to your plans in the v7 thread, but didn't
> >>>> have time to finish before v8 appeared...]
> >>>>
> >>>> On 2021-08-20 21:17, Liam Beguin wrote:
> >>>>> From: Liam Beguin <lvb@xiphos.com>
> >>>>>
> >>>>> The approximation caused by integer divisions can be costly on smaller
> >>>>> scale values since the decimal part is significant compared to the
> >>>>> integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
> >>>>> cases to maintain accuracy.
> >>>>
> >>>
> >>> Hi Peter,
> >>>
> >>> Thanks for taking time to look at this in detail again. I really
> >>> appreciate all the feedback you've provided.
> >>>
> >>>> The conversion to int-plus-nano may also carry a cost of accuracy.
> >>>>
> >>>> 90/1373754273 scaled by 261/509 is 3.359e-8, the old code returns 3.348e-8,
> >>>> but the new one gets you 3.3e-8 (0.000000033, it simply cannot provide more
> >>>> digits). So, in this case you lose precision with the new code.
> >>>>
> >>>> Similar problem with 100 / 2^30 scaled by 3782/7000. It is 5.032e-8, the old
> >>>> code returns 5.029e-8, but the new one gets you the inferior 5.0e-8.
> >>>>
> >>>
> >>> I see what you mean here.
> >>> I added test cases with these values to see exactly what we get.
> >>
> >> Excellent!
> >>
> >>>
> >>> Expected rel_ppm < 0, but
> >>>     rel_ppm == 1000000
> >>>
> >>>      real=0.000000000
> >>>  expected=0.000000033594
> >>> # iio_rescale_test_scale: not ok 42 - v8 - 90/1373754273 scaled by 261/509
> >>> Expected rel_ppm < 0, but
> >>>     rel_ppm == 1000000
> >>>
> >>>      real=0.000000000
> >>>  expected=0.000000050318
> >>> # iio_rescale_test_scale: not ok 43 - v8 - 100/1073741824 scaled by 3782/7000
> >>>
> >>>
> >>> The main issue is that the first two examples return 0 which night be worst
> >>> that loosing a little precision.
> >>
> >> They shouldn't return zero?
> >>
> >> Here's the new code quoted from the test robot (and assuming
> >> a 64-bit machine, thus ignoring the 32-bit problem on line 56).
> >>
> >>     36		case IIO_VAL_FRACTIONAL:
> >>     37		case IIO_VAL_FRACTIONAL_LOG2:
> >>     38			tmp = (s64)*val * 1000000000LL;
> >>     39			tmp = div_s64(tmp, rescale->denominator);
> >>     40			tmp *= rescale->numerator;
> >>     41	
> >>     42			tmp = div_s64_rem(tmp, 1000000000LL, &rem);
> >>     43			*val = tmp;
> >>     44	
> >>     45			/*
> >>     46			 * For small values, the approximation can be costly,
> >>     47			 * change scale type to maintain accuracy.
> >>     48			 *
> >>     49			 * 100 vs. 10000000 NANO caps the error to about 100 ppm.
> >>     50			 */
> >>     51			if (scale_type == IIO_VAL_FRACTIONAL)
> >>     52				tmp = *val2;
> >>     53			else
> >>     54				tmp = 1 << *val2;
> >>     55	
> >>   > 56			 if (abs(rem) > 10000000 && abs(*val / tmp) < 100) {
> >>     57				 *val = div_s64_rem(*val, tmp, &rem2);
> >>     58	
> >>     59				 *val2 = div_s64(rem, tmp);
> >>     60				 if (rem2)
> >>     61					 *val2 += div_s64(rem2 * 1000000000LL, tmp);
> >>     62	
> >>     63				 return IIO_VAL_INT_PLUS_NANO;
> >>     64			 }
> >>     65	
> >>     66			return scale_type;
> >>
> >> When I go through the above manually, I get:
> >>
> >> line 
> >> 38: tmp = 90000000000    ; 90 * 1000000000
> >> 39: tmp = 176817288      ; 90000000000 / 509
> >> 40: tmp = 46149312168    ; 176817288 * 261
> >> 42: rem = 149312168      ; 46149312168 % 1000000000
> >>     tmp = 46             ; 46149312168 / 1000000000
> >> 43: *val = 46
> >> 51: if (<fractional>) [yes]
> >> 52: tmp = 1373754273
> >> 56: if (149312168 > 10000000 && 46/1373754273 < 100) [yes && yes]
> >> 57: rem2 = 46            ; 46 % 1373754273
> >>     *val = 0             ; 46 / 1373754273
> >> 59: *val2 = 0            ; 149312168 / 1373754273
> >> 60: if 46 [yes]
> >> 61: *val2 = 33           ; 0 + 46 * 1000000000 / 1373754273
> >> 63: return <int-plus-nano> [0.000000033]
> >>
> >> and
> >>
> >> line 
> >> 38: tmp = 100000000000   ; 100 * 1000000000
> >> 39: tmp = 14285714       ; 100000000000 / 7000
> >> 40: tmp = 54028570348    ; 176817288 * 3782
> >> 42: rem = 28570348       ; 54028570348 % 1000000000
> >>     tmp = 54             ; 54028570348 / 1000000000
> >> 43: *val = 54
> >> 51: if (<fractional>) [no]
> >> 54: tmp = 1073741824     ; 1 << 30
> >> 56: if (28570348 > 10000000 && 54/1073741824 < 100) [yes && yes]
> >> 57: rem2 = 54            ; 54 % 1073741824
> >>     *val = 0             ; 54 / 1073741824
> >> 59: *val2 = 0            ; 28570348 / 1073741824
> >> 60: if 46 [yes]
> >> 61: *val2 = 50           ; 0 + 54 * 1000000000 / 1073741824
> >> 63: return <int-plus-nano> [0.000000050]
> >>
> >> Why do you get zero, what am I missing?
> > 
> > So... It turns out, I swapped schan and rescaler values which gives us:
> 
> Ahh, good. The explanation is simple!
> 
> > 
> > numerator = 90
> > denominator = 1373754273
> > schan_val = 261
> > schan_val2 = 509
> > 
> > line
> > 38: tmp = 261000000000   ; 261 * 1000000000
> > 39: tmp = 189            ; 261000000000 / 1373754273
> > 40: tmp = 17010          ; 189 * 90
> > 42: rem = 17010          ; 17010 % 1000000000
> >     tmp = 0              ; 17010 / 1000000000
> > 43: *val = 0
> > 51: if (<fractional>) [yes]
> > 52: tmp = 509
> > 56: if (17010 > 10000000 && 0/509 < 100) [no && yes]
> > 66: *val = 0
> >     *val2 = 509
> >     return <fractional> [0.000000000]
> > 
> > Swapping back the values, I get the same results as you!
> > 
> > Also, replacing line 56 from the snippet above with
> > 
> > 	- if (abs(rem) > 10000000 && abs(div64_s64(*val, tmp)) < 100) {
> > 	+ if (abs(rem)) {
> > 
> > Fixes these precision errors. It also prevents us from returning
> > different scales if we swap the two divisions (schan and rescaler
> > parameters).
> 
> No, it doesn't fix the precision problems. Not really, it only reduces
> them. See below.
> 
> *snip*
> 
> >>> Considering these null values and the possible issue of not always having the
> >>> same scale type, would it be better to always return an IIO_VAL_INT_PLUS_NANO
> >>> scale?
> >>
> >> No, that absolutely kills the precision for small values that are much
> >> better off as-is. The closer you get to zero, the more the conversion
> >> to int-plus-nano hurts, relatively speaking.
> > 
> > I'm not sure I understand what you mean. The point of switching to
> > IIO_VAL_INT_PLUS_NANO at the moment is to get more precision on small
> > values. Am I missing something?

Hi Peter,

Apologies for the late reply.

> Yes, apparently :-) We always sacrifice accuracy by going to
> IIO_VAL_INT_PLUS_NANO. More is lost with smaller numbers, relatively.
> That is an inherent property of fix-point style representations such
> as IIO_VAL_INT_PLUS_NANO. Unless we get lucky and just happen to be
> able to represent the desired number exactly of course, but that tends
> to be both non-interesting and the exception.

I think I see where our misunderstanding comes from :-)

I understand that mathematically, IIO_VAL_FRACTIONAL is more accurate
than IIO_VAL_INT_PLUS_NANO for rational numbers given that it provides
an exact value to the IIO consumer.

My point is that the IIO core will represent IIO_VAL_FRACTIONAL scales
as fixed point when using iio_format_value().

Also, my current setup, uses drivers/hwmon/iio_hwmon.c which is worst
since it relies on iio_read_channel_processed() to get an integer scale.

(I wonder if it would make sense at some point to update iio_hwmon.c to
use iio_format_value() instead).

> Let's go back to the example from my response to the 8/14 patch, i.e.
> 5/32768 scaled by 3/10000. With the current code this yields
> 
> 15 / 327680000 (0.0000000457763671875)
> 
> Note, the above is /exact/. With IIO_VAL_INT_PLUS_NANO we instead get
> the truncated 0.000000045
> 
> The relative error introduced by the IIO_VAL_INT_PLUS_NANO conversion
> is almost 1.7% in this case. Sure, rounding instead of truncating
> would reduce that to 0.5%, but that's not really a significant
> improvement if you compare to /no/ error. Besides, there are many
> smaller numbers with even bigger relative conversion "noise".
> 
> And remember, this function is used to rescale the scale of the
> raw values. We are going to multiply the scale and the raw values
> at some point. If we have rounding errors in the scale, they will
> multiply with the raw values. It wouldn't look too good if something
> that should be able to reach 3V with a lot of accuracy (ca 26 bits)
> instead caps out at 2.94912V (or hits 3.014656V) because of accuracy
> issues with the scaling (1.7% too low or 0.5% too high).

I understand your point, but a device that has an IIO_VAL_FRACTIONAL
scale with *val=15 and *val2=327680000 will also show a scale of
0.000000045 in the sysfs interface.

Since other parts of the core already behave like this, I'm inclined to
say that this is a more general "issue", and that this kind of precision
loss would only affect consumers making direct use of the scaling
values. With all this, I wonder how careful we really have to be with
these extra digits.

> It's impossible to do better than exact, which is what we have now for
> IIO_VAL_FRACTIONAL and IIO_VAL_INT (for IIO_VAL_FRACTIONAL_LOG2, not
> so much...). At least as long as there's no overflow.

Right, but like I said above, depending on which path you take, that
value might not be exact in the end.

Thanks,
Liam

> 
> Cheers,
> Peter
