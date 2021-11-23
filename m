Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B4645AD34
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 21:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbhKWU0u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 15:26:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235541AbhKWU0t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 15:26:49 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56BB760F5A;
        Tue, 23 Nov 2021 20:23:39 +0000 (UTC)
Date:   Tue, 23 Nov 2021 20:28:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Liam Beguin <liambeguin@gmail.com>, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v9 00/14] iio: afe: add temperature rescaling support
Message-ID: <20211123202835.71e57e41@jic23-huawei>
In-Reply-To: <156bc2fa-6754-2350-4a12-ff25b23ae8a2@axentia.se>
References: <20211115034334.1713050-1-liambeguin@gmail.com>
        <156bc2fa-6754-2350-4a12-ff25b23ae8a2@axentia.se>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Nov 2021 01:53:44 +0100
Peter Rosin <peda@axentia.se> wrote:

> Hi Liam!
> 
> On 2021-11-15 04:43, Liam Beguin wrote:
> > Hi Jonathan, Peter,
> > 
> > Apologies for not getting back to you sooner. I got caught up on other
> > work and wasn't able to dedicate time to this earlier. Hopefully, this
> > time around, I'll be able to get this to the finish line :-)
> > 
> > I left out IIO_VAL_INT overflows for now, so that I can focus on getting
> > the rest of these changes pulled in, but I don't mind adding a patch for
> > that later on.
> > 
> > This series focuses on adding temperature rescaling support to the IIO
> > Analog Front End (AFE) driver.
> > 
> > The first few patches address minor bugs in IIO inkernel functions, and
> > prepare the AFE driver for the additional features.
> > 
> > The main changes to the AFE driver include an initial Kunit test suite,
> > support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
> > and temperature transducer sensors.
> > 
> > Thanks for your time,  
> 
> And thanks for yours!
> 
> > Liam
> > 
> > Changes since v8:
> > - reword comment
> > - fix erroneous 64-bit division
> > - optimize and use 32-bit divisions when values are know to not overflow
> > - keep IIO_VAL_FRACTIONAL scale when possible, if not default to fixed
> >   point  
> 
> This is not what is going on. Patch 9/14 will convert all fractional
> scales to fixed point. But I would really like if you in the "reduce
> risk of integer overflow" patch (8/14) would hold true to the above
> and keep the fractional scale when possible and only fall back to
> the less precise fractional-log case if any of the multiplications
> needed for an exact fractional scale causes overflow.
> 
> The v8 discussion concluded that this was a valid approach, right?
> 
> I know you also said that the core exposes the scale with nano
> precision in sysfs anyway, but that is not true for in-kernel
> consumers. They have an easier time reading the "real" scale value
> compared to going via the string representation of fixed point
> returned from iio_format_value. At least the rescaler itself does so,
> which means that chaining rescalers might suffer needless accuracy
> degradation.
> 
> So, please add the overflow fallback thingy right away, it would make
> me feel much better.
> 
> > - add test cases
> > - use nano precision in test cases
> > - simplify offset calculation in rtd_props()
> > 
> > Changes since v7:
> > - drop gcd() logic in rescale_process_scale()
> > - use div_s64() instead of do_div() for signed 64-bit divisions
> > - combine IIO_VAL_FRACTIONAL and IIO_VAL_FRACTIONAL_LOG2 scale cases
> > - switch to INT_PLUS_NANO when accuracy is lost with FRACTIONAL scales
> > - rework test logic to allow for small relative error
> > - rename test variables to align error output messages
> > 
> > Changes since v6:
> > - rework IIO_VAL_INT_PLUS_{NANO,MICRO} based on Peter's suggestion
> > - combine IIO_VAL_INT_PLUS_{NANO,MICRO} cases
> > - add test cases for negative IIO_VAL_INT_PLUS_{NANO,MICRO} corner cases
> > - force use of positive integers with gcd()
> > - reduce risk of integer overflow in IIO_VAL_FRACTIONAL_LOG2
> > - fix duplicate symbol build error
> > - apply Reviewed-by
> > 
> > Changes since v5:
> > - add include/linux/iio/afe/rescale.h
> > - expose functions use to process scale and offset
> > - add basic iio-rescale kunit test cases
> > - fix integer overflow case
> > - improve precision for IIO_VAL_FRACTIONAL_LOG2
> > 
> > Changes since v4:
> > - only use gcd() when necessary in overflow mitigation
> > - fix INT_PLUS_{MICRO,NANO} support
> > - apply Reviewed-by
> > - fix temperature-transducer bindings
> > 
> > Changes since v3:
> > - drop unnecessary fallthrough statements
> > - drop redundant local variables in some calculations
> > - fix s64 divisions on 32bit platforms by using do_div
> > - add comment describing iio-rescaler offset calculation
> > - drop unnecessary MAINTAINERS entry
> > 
> > Changes since v2:
> > - don't break implicit offset truncations
> > - make a best effort to get a valid value for fractional types
> > - drop return value change in iio_convert_raw_to_processed_unlocked()
> > - don't rely on processed value for offset calculation
> > - add INT_PLUS_{MICRO,NANO} support in iio-rescale
> > - revert generic implementation in favor of temperature-sense-rtd and
> >   temperature-transducer
> > - add separate section to MAINTAINERS file
> > 
> > Changes since v1:
> > - rebase on latest iio `testing` branch
> > - also apply consumer scale on integer channel scale types
> > - don't break implicit truncation in processed channel offset
> >   calculation
> > - drop temperature AFE flavors in favor of a simpler generic
> >   implementation
> > 
> > Liam Beguin (14):
> >   iio: inkern: apply consumer scale on IIO_VAL_INT cases
> >   iio: inkern: apply consumer scale when no channel scale is available
> >   iio: inkern: make a best effort on offset calculation
> >   iio: afe: rescale: expose scale processing function
> >   iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
> >   iio: afe: rescale: add offset support
> >   iio: afe: rescale: use s64 for temporary scale calculations
> >   iio: afe: rescale: reduce risk of integer overflow
> >   iio: afe: rescale: fix accuracy for small fractional scales  
> 
> Can you please swap the order of these two patches? (i.e. "reduce
> risk..." and "fix accuracy...")
> 
> Basically, I think the accuracy of the IIO_VAL_FRACTIONAL_LOG2
> case should be improved before the IIO_VAL_FRACTIONAL case is
> joined with it. I.e. swap the order of 8/14 and 9/14 (or almost,
> you need to also move the addition of the
> scale_type == IIO_VAL_FRACTIONAL condition to the other patch in
> order for it to make sense).
> 
> That's all I'm finding. But then again, I don't know what to do
> about the 0day report on 10/14. It does say that it's a W=1
> build, maybe we need not worry about it?

W=1 won't affect that undefined symbols error.

I'd be cynical and assume it's a random issue, post a v10 perhaps
with a note in the cover letter on this.

Jonathan
> 
> Cheers,
> Peter
> 
> >   iio: test: add basic tests for the iio-rescale driver
> >   iio: afe: rescale: add RTD temperature sensor support
> >   iio: afe: rescale: add temperature transducers
> >   dt-bindings: iio: afe: add bindings for temperature-sense-rtd
> >   dt-bindings: iio: afe: add bindings for temperature transducers  
> 

