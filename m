Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416403DC78A
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 19:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhGaR6f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 13:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhGaR6e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Jul 2021 13:58:34 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D00360FE7;
        Sat, 31 Jul 2021 17:58:24 +0000 (UTC)
Date:   Sat, 31 Jul 2021 19:01:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [PATCH 2/4] iio: imu: add Bosch Sensortec BNO055 core driver
Message-ID: <20210731190103.6e2a3d41@jic23-huawei>
In-Reply-To: <CAN8YU5PcrR-xM5A=3jd50=UaY9wWDJZGBqajmvM8Te1Ly14Hew@mail.gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20210715141742.15072-3-andrea.merello@gmail.com>
        <20210717163236.1553fbfa@jic23-huawei>
        <CAN8YU5NctVMPfNZn7ya-Jw7yE=NQDBq1aweWn0fX0Rp1p1P=aw@mail.gmail.com>
        <20210724180823.692b203f@jic23-huawei>
        <CAN8YU5PcrR-xM5A=3jd50=UaY9wWDJZGBqajmvM8Te1Ly14Hew@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Jul 2021 16:36:49 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> just a few of in-line comment below; OK for all the rest of your
> comment, thanks!
> 
> > > > > +static int bno055_reg_write(struct bno055_priv *priv,
> > > > > +                         unsigned int reg, unsigned int val)
> > > > > +{
> > > > > +     int res = regmap_write(priv->regmap, reg, val);
> > > > > +
> > > > > +     if (res && res != -ERESTARTSYS) {  
> > > >
> > > > I think Andy asked about these, so I won't repeat...
> > > > Nice to get rid of those and just be able to make the regmap calls inline though...  
> > >
> > > Ok for inline. I've just answered in another mail to Andy's comments
> > > for the rest.  
> 
> Indeed, so far I couldn't understand what do you really mean. Should I
> move those check+dev_err() inside the regmap core layer ?

Better to move any necessary print to the caller of the reg_write() where any
error message can often give more information.  Adding wrappers just to print
an error message normally mostly serves to make the code a little harder to
review.

> 
> > > > > +     /*
> > > > > +      * Start in fusion mode (all data available), but with magnetometer auto
> > > > > +      * calibration switched off, in order not to overwrite magnetometer
> > > > > +      * calibration data in case one want to keep it untouched.  
> > > >
> > > > Why might you? good to have a default that is what people most commonly want...
> > > > If there is a usecase for this then it may be better to have a 'disable autocalibration
> > > > and manually reload a fixed calibration' path.  
> > >
> > > I'm not sure whether disabling autocalibration for magnetometer is
> > > just a matter of saving some power, or whether this has the purpose of
> > > carefully doing the calibration far from magnetic disturbances,
> > > avoiding screwing the calibration every time you briefly pass by a
> > > piece of iron. I think I found some clues for this second
> > > interpretation poking on the internet, but I don't know whether they
> > > were right.  
> >
> > It's possible if the calibration routines have much faster response than
> > you'd normally expect.  
> 
> This HW function is called "Fast Magnetometer Calibration".. But I
> don't know how fast is it..

Nice  - got to love informative datasheets :)

> 
> 
> > > > > +     &iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
> > > > > +     &iio_dev_attr_in_anglvel_range_available.dev_attr.attr,  
> > > >
> > > > Hmm. Range typically maps to something else (normally scale, but these smart
> > > > sensors can do weird things)  
> > >
> > > Here the scaling doesn't change, just the range. I *think* that by
> > > changing range you also get better or worse precision.  
> >
> > oh goody.  Make sure the default is maximum range + when you document this
> > we will have to be careful to make it clear we don't want this to be used in
> > drivers where scale is an option.  Perhaps we just put it in a device
> > specific ABI file.
> >  
> 
> The default is to run the IMU with fusion mode enabled; in this mode
> those parameters are locked by the HW to a given value (which is not
> the maximum e.g. in case of accelerometer range).
> 
> If the user disables the fusion mode, then those parameters become
> tweakable, but shouldn't they just remain at their previous values
> (the one set by fusion mode), unless the user change also them?

That makes sense to me.

> 
> I.o.w the only chance we have for assigning them a "default" value is
> when the fusion is switched off, but this would mean that switching
> off fusion mode also has a side effect on those values (which I'm
> unsure if we really want to happen).

Thanks for the explanation.  Ok. Fine to have the range here, but please
sanity check we have appropriate ABI documentation in the main ABI doc
Documentation/ABI/testing/sysfs-bus-iio.
One thing to think about is how range would generalize.   These sensors are
symmetric, but not all are - a range that is higher in postive than negative
is definitely possible.  Perhaps we need to name it to make it clear we are
talking magnitude here? 

Ideally it should state something about range should be used only when it has no
affect on scaling.  Hopefully we'll not get a device where it has an affect
but it's non linear as that doesn't make any sense.  I'd imagine a range
control in hardware either is proportional to the scale, or has no affect on
it as here.

Thanks,

Jonathan

> 
> Andrea

