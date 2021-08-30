Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DC93FBA88
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 19:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbhH3RBe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 13:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbhH3RBd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 13:01:33 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A72260F23;
        Mon, 30 Aug 2021 17:00:36 +0000 (UTC)
Date:   Mon, 30 Aug 2021 18:03:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Liam Beguin <liambeguin@gmail.com>, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v8 09/14] iio: afe: rescale: fix accuracy for small
 fractional scales
Message-ID: <20210830180348.032b217f@jic23-huawei>
In-Reply-To: <e1542f14-f271-a0a3-eaa1-092e12c3ed6c@axentia.se>
References: <20210820191714.69898-1-liambeguin@gmail.com>
        <20210820191714.69898-10-liambeguin@gmail.com>
        <2d028a60-d1fe-7fa1-da4a-0d80f8d468ea@axentia.se>
        <20210830122224.3efc5a63@jic23-huawei>
        <e1542f14-f271-a0a3-eaa1-092e12c3ed6c@axentia.se>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Aug 2021 16:30:54 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2021-08-30 13:22, Jonathan Cameron wrote:
> > On Mon, 23 Aug 2021 00:18:55 +0200
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> [I started to write an answer to your plans in the v7 thread, but didn't
> >> have time to finish before v8 appeared...]
> >>
> >> On 2021-08-20 21:17, Liam Beguin wrote:  
> >>> From: Liam Beguin <lvb@xiphos.com>
> >>>
> >>> The approximation caused by integer divisions can be costly on smaller
> >>> scale values since the decimal part is significant compared to the
> >>> integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
> >>> cases to maintain accuracy.    
> >>
> >> The conversion to int-plus-nano may also carry a cost of accuracy.
> >>
> >> 90/1373754273 scaled by 261/509 is 3.359e-8, the old code returns 3.348e-8,
> >> but the new one gets you 3.3e-8 (0.000000033, it simply cannot provide more
> >> digits). So, in this case you lose precision with the new code.
> >>
> >> Similar problem with 100 / 2^30 scaled by 3782/7000. It is 5.032e-8, the old
> >> code returns 5.029e-8, but the new one gets you the inferior 5.0e-8.
> >>
> >> I'm also wondering if it is wise to not always return the same scale type?
> >> What happens if we want to extend this driver to scale a buffered channel?
> >> Honest question! I don't know, but I fear that this patch may make that
> >> step more difficult to take??
> >>
> >> Jonathan, do you have any input on that?  
> > 
> > I'm a bit lost.  As things currently stand IIO buffered data flows all use
> > _RAW.  It's either up to userspace or the inkernel user to query scale
> > and use that to compute the appropriate _processed values.  There have been
> > various discussions over the years on how to add metadata but it's tricky
> > without adding significant complexity and for vast majority of usecases not
> > necessary.  Given the rescaler copes with _raw and _processed inputs, we
> > would only support buffered flows if using the _raw ones.
> > 
> > If nothing changes in configuration of the rescaler, the scale should be
> > static for a given device.  What format that 'scale' takes is something
> > that userspace code or inkernel users should cope fine with given they
> > need to do that anyway for different devices.  
> 
> Ok, if 'scale' (and 'offset') of the source channel is to be considered
> static, then it is much safer to ignore the "island problem" and rescale
> each value independently on a case-by-case basis. We should add an
> explicit comment somewhere that we make this assumption.
> 
> Sorry for wasting time and effort by not realizing by myself (and earlier).
> 
> Maybe something like this?
> 
> /*
>  * The rescaler assumes that the 'scale' and 'offset' properties of
>  * the source channel are static. If they are not, there exist some
>  * corner cases where rounding/truncating might cause confusing
>  * mathematical properties (non-linearity).
>  */
Looks good to me.

There are some really obscure corner cases in which it is theoretically possible
to have scale change autonomously. Reality is they mostly don't happen in reality
and are on strange sensors you couldn't stick an AFE on anyway ;)
IIRC hid-sensors in theory allow this, but as far as I know, no device actually does
it...  I'm not sure the driver takes any notice if they do!

Jonathan

> 
> I then propose that we rescale IIO_VAL_FRACTIONAL as before if that works,
> thus preserving any previous exact rescaling, but if there is an overflow
> while doing that, then we fall back to new code that rescales to a
> IIO_VAL_INT_PLUS_NANO value. Trying the gcd-thing as it ended up in v7 still
> seems expensive to me, but maybe I overestimate the cost of gcd? Anyway, my
> guts vote for completely skipping gcd and that we aim directly for
> IIO_VAL_INT_PLUS_NANO in case of overflow while doing the old thing.
> 
> Having said that, if 'scale' and 'offset' indeed are static, then the gcd
> cost can be mitigated by caching the result. Exact rescaling is always
> nice...
> 
> If IIO_VAL_INT overflows while rescaling, we are SOL whichever way we turn,
> so ignore doing anything about that.
> 
> Liam, was it IIO_VAL_FRACTIONAL or IIO_VAL_FRACTIONAL_LOG2 that was your
> real use case? Anyway, your 100 ppm threshold is probably as good a
> compromise as any for this case. However, that threshold does nothing for
> the case where the conversion to IIO_VAL_INT_PLUS_NANO throws away way
> more precision than the existing operations. It would probably be good
> to somehow stay with the old method for the really tiny values, if there
> is a viable test/threshold for when to do what.
> 
> Cheers,
> Peter

