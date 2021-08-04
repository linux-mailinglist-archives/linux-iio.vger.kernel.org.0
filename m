Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E0A3E0626
	for <lists+linux-iio@lfdr.de>; Wed,  4 Aug 2021 18:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbhHDQur (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Aug 2021 12:50:47 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3582 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhHDQur (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Aug 2021 12:50:47 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GfyQy4lRhz6DKBl;
        Thu,  5 Aug 2021 00:50:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 18:50:32 +0200
Received: from localhost (10.47.91.83) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 4 Aug 2021
 17:50:31 +0100
Date:   Wed, 4 Aug 2021 17:50:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andrea Merello <andrea.merello@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Andrea Merello" <andrea.merello@iit.it>
Subject: Re: [PATCH 2/4] iio: imu: add Bosch Sensortec BNO055 core driver
Message-ID: <20210804175002.000059c5@Huawei.com>
In-Reply-To: <CAN8YU5OrXy0c5D+5141izDJHxqSakGsbrnkug2M56qczxK0BfQ@mail.gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20210715141742.15072-3-andrea.merello@gmail.com>
        <20210717163236.1553fbfa@jic23-huawei>
        <CAN8YU5NctVMPfNZn7ya-Jw7yE=NQDBq1aweWn0fX0Rp1p1P=aw@mail.gmail.com>
        <20210724180823.692b203f@jic23-huawei>
        <CAN8YU5PcrR-xM5A=3jd50=UaY9wWDJZGBqajmvM8Te1Ly14Hew@mail.gmail.com>
        <20210731190103.6e2a3d41@jic23-huawei>
        <CAN8YU5OrXy0c5D+5141izDJHxqSakGsbrnkug2M56qczxK0BfQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.83]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 4 Aug 2021 12:06:46 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> Il giorno sab 31 lug 2021 alle ore 19:58 Jonathan Cameron
> <jic23@kernel.org> ha scritto:
> >
> > On Mon, 26 Jul 2021 16:36:49 +0200
> > Andrea Merello <andrea.merello@gmail.com> wrote:
> >  
> > > just a few of in-line comment below; OK for all the rest of your
> > > comment, thanks!
> > >  
> > > > > > > +static int bno055_reg_write(struct bno055_priv *priv,
> > > > > > > +                         unsigned int reg, unsigned int val)
> > > > > > > +{
> > > > > > > +     int res = regmap_write(priv->regmap, reg, val);
> > > > > > > +
> > > > > > > +     if (res && res != -ERESTARTSYS) {  
> > > > > >
> > > > > > I think Andy asked about these, so I won't repeat...
> > > > > > Nice to get rid of those and just be able to make the regmap calls inline though...  
> > > > >
> > > > > Ok for inline. I've just answered in another mail to Andy's comments
> > > > > for the rest.  
> > >
> > > Indeed, so far I couldn't understand what do you really mean. Should I
> > > move those check+dev_err() inside the regmap core layer ?  
> >
> > Better to move any necessary print to the caller of the reg_write() where any
> > error message can often give more information.  Adding wrappers just to print
> > an error message normally mostly serves to make the code a little harder to
> > review.  
> 
> Isn't this like doing a cut-and-paste of check+dev_err() in more than
> a dozen places in the code?
> 
> If you just want more information about the caller then we could
> macroize those functions, so they can also print the caller code line
> number (or they could accept an additional argument, which is the code
> line number to print, and then a macro helper that adds that last
> argument can be used to invoke them).. But this wouldn't address your
> second point..
It's a trade off between reviewability which these wrappers make worse
and short code.

My personal preference is don't bother with messages on simple reg read /write
failures.  If it happens you either get an error reported to userspace and
can do some more debug, or the driver doesn't probe - again, more debug to 
be done even if you know it was a read or write.

> 
> > >  
> > > > > > > +     /*
> > > > > > > +      * Start in fusion mode (all data available), but with magnetometer auto
> > > > > > > +      * calibration switched off, in order not to overwrite magnetometer
> > > > > > > +      * calibration data in case one want to keep it untouched.  
> > > > > >
> > > > > > Why might you? good to have a default that is what people most commonly want...
> > > > > > If there is a usecase for this then it may be better to have a 'disable autocalibration
> > > > > > and manually reload a fixed calibration' path.  
> > > > >
> > > > > I'm not sure whether disabling autocalibration for magnetometer is
> > > > > just a matter of saving some power, or whether this has the purpose of
> > > > > carefully doing the calibration far from magnetic disturbances,
> > > > > avoiding screwing the calibration every time you briefly pass by a
> > > > > piece of iron. I think I found some clues for this second
> > > > > interpretation poking on the internet, but I don't know whether they
> > > > > were right.  
> > > >
> > > > It's possible if the calibration routines have much faster response than
> > > > you'd normally expect.  
> > >
> > > This HW function is called "Fast Magnetometer Calibration".. But I
> > > don't know how fast is it..  
> >
> > Nice  - got to love informative datasheets :)
> >  
> > >
> > >  
> > > > > > > +     &iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
> > > > > > > +     &iio_dev_attr_in_anglvel_range_available.dev_attr.attr,  
> > > > > >
> > > > > > Hmm. Range typically maps to something else (normally scale, but these smart
> > > > > > sensors can do weird things)  
> > > > >
> > > > > Here the scaling doesn't change, just the range. I *think* that by
> > > > > changing range you also get better or worse precision.  
> > > >
> > > > oh goody.  Make sure the default is maximum range + when you document this
> > > > we will have to be careful to make it clear we don't want this to be used in
> > > > drivers where scale is an option.  Perhaps we just put it in a device
> > > > specific ABI file.
> > > >  
> > >
> > > The default is to run the IMU with fusion mode enabled; in this mode
> > > those parameters are locked by the HW to a given value (which is not
> > > the maximum e.g. in case of accelerometer range).
> > >
> > > If the user disables the fusion mode, then those parameters become
> > > tweakable, but shouldn't they just remain at their previous values
> > > (the one set by fusion mode), unless the user change also them?  
> >
> > That makes sense to me.
> >  
> > >
> > > I.o.w the only chance we have for assigning them a "default" value is
> > > when the fusion is switched off, but this would mean that switching
> > > off fusion mode also has a side effect on those values (which I'm
> > > unsure if we really want to happen).  
> >
> > Thanks for the explanation.  Ok. Fine to have the range here, but please
> > sanity check we have appropriate ABI documentation in the main ABI doc
> > Documentation/ABI/testing/sysfs-bus-iio.  
> 
> So you are inclined to generalize this thing, rather than keeping it
> as bno055 specific..

My mistake.  I thought we had it already defined but seems we have avoided
it even though we have gotten close a few times ;)

sysfs-bus-iio-bno055 should be fine

> 
> > One thing to think about is how range would generalize.   These sensors are
> > symmetric, but not all are - a range that is higher in postive than negative
> > is definitely possible.  Perhaps we need to name it to make it clear we are
> > talking magnitude here?  
> 
> I'm open to suggestions here.

It's challenging to define a clean way of specifying two linked values.
We could define rangemax, rangemin and rely on the fact that any bit of IIO
ABI can affect other bits, but that's messy given our only current user
doesn't care.


> 
> The word "range" in my mind just recalls the idea of a minimum/maximum
> interval in which the sensor works, without recalling me the idea of
> "scaling" or changes to the unit too much; this is why I originally
> chosen this name, but that might be just mine personal taste.

We may regret it but let's stick with your range definition as is, with suitable
docs and keeping it device specific for now.

> 
> > Ideally it should state something about range should be used only when it has no
> > affect on scaling.  Hopefully we'll not get a device where it has an affect
> > but it's non linear as that doesn't make any sense.  I'd imagine a range
> > control in hardware either is proportional to the scale, or has no affect on
> > it as here.  
> 
> I may have a wrong memory here, but I think I've seen something like
> this on some current-sense chips, which were available for various
> current ranges, but their output scale changed in non linear way wrt
> the range.
> 
> Or I can imagine a device in which you can set the internal amplifier
> gain, and this will affect both the scale (because of the amplifier
> gain itself) and the range (because the amplifier output does saturate
> at a different voltage) with a linear relationship, but there is also
> another bound: the physical sensor attached to the amplifier
> mechanically clamp to a given max value, that happen to be less than
> the saturation point of the amp at is minimum gain. This would lead to
> a non-linear net relationship between scale and range because at the
> minimum gain the range doesn't extends as much as you would expect.
> 
> .. But even in non linear cases, just having the scale may be OK..
> Maybe we can just say that range can be used only if there are at
> least two values for which we have the same scale value; otherwise
> just having the scale attribute would suffice and thus we stick on
> that.. We may think about allowing a RO range attribute, alongside the
> scale attribute, for non obvious cases.

For read only, you can use the read_avail approach to provide a range
for the actual channel.  We do this for various in kernel consumer
users that need to know the range of values they might get.

That is only ever read only though, because of the difficulty of
allowing rights to two bounds together.

So we have devices where changing the scale will result in
inX_raw_avail changing (IIRC) and that's not necessarily linear.

Jonathan

> 
> 
> > Thanks,
> >
> > Jonathan
> >  
> > >
> > > Andrea  
> >  

