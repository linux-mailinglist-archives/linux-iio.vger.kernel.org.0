Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E303DFF01
	for <lists+linux-iio@lfdr.de>; Wed,  4 Aug 2021 12:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbhHDKHP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Aug 2021 06:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbhHDKHO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Aug 2021 06:07:14 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374FEC06179B;
        Wed,  4 Aug 2021 03:06:58 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u16so2487615ple.2;
        Wed, 04 Aug 2021 03:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ymDXWS2hyeGNxR6Ju15eQGcpdIUyM4VaIjxECbsCPdQ=;
        b=Xel88Q0y996Uyf+whVVK5ltO/gywAd03sBNlREnxdB+2bjGyREuaN7CyfphZn/aKB4
         z/5GA8oZNnTySHiasv/c4SKkJqqhSCAhmgygJZCcS9W0fE8mmpHMjlRjSryX8um1WHIt
         oqdhHmKdBXY65qZDp8pgAV6yswd/82XJw8HKdWL4MzyikhOMfuIpEVDiAgRZxg7yA/up
         7hvQpgBEmMoA00VInKRuHI8HId2GHRGru7qiP77GKOY/Mms3eKPB7kXs30yAqd+k4yZX
         faetiUhgPS/U3XjlfzdKHdrFqjyOrbACakeC0nlE3qtL4sxE6Y+9Fp/jiXyw7nF28/tW
         8qog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ymDXWS2hyeGNxR6Ju15eQGcpdIUyM4VaIjxECbsCPdQ=;
        b=nmjITql0QvJWGgSlvIgyTiYhlUyQG9NXcyjLisohes1gxnbFaNngb8DAc2cDzyRMmi
         Yf3oa8tVDY4LnBZ7e4KfezO2ibA+dKGHLuYmSYcodZdZF4xa4HvPyRSf9Jq1+akiU337
         RbkvNLS49KweHSD8J4L+8R+u4Yyx7Q97VAHHj/r2b3e3Gcy0u/ViWSTIEqciKG/x7UP2
         QIlm1rSnViR22Lla++kaQnAkDSeTj1LK+oLYkhDSMNPLQbesGTUsYvTYFXJ/1TpFCPA0
         69ZojG/DsVyNiVR/nw7MdIgsF0+ODsF/bHzymiM2Ajmt8yYTVvvpCNSwBy0aqBQwkVJ4
         jqFw==
X-Gm-Message-State: AOAM530S5sFmvQ8VTpBedMOnORnVWKVCS47izuN4DI5hQ0hXXxP1r2w3
        gts8dAy38vQabpdFjkFoELeYXLFXtvQ/HTeIO3I=
X-Google-Smtp-Source: ABdhPJyPEdcybWyvdshvKeX/8ccFxq4hZzl5YLTEk0OB0DNSUjheuanINxea+/oAqZDW69lmFWTZQR3roTC5/LyhO/M=
X-Received: by 2002:a62:87c5:0:b029:3b5:f90f:c2eb with SMTP id
 i188-20020a6287c50000b02903b5f90fc2ebmr20378847pfe.28.1628071618273; Wed, 04
 Aug 2021 03:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20210715141742.15072-3-andrea.merello@gmail.com> <20210717163236.1553fbfa@jic23-huawei>
 <CAN8YU5NctVMPfNZn7ya-Jw7yE=NQDBq1aweWn0fX0Rp1p1P=aw@mail.gmail.com>
 <20210724180823.692b203f@jic23-huawei> <CAN8YU5PcrR-xM5A=3jd50=UaY9wWDJZGBqajmvM8Te1Ly14Hew@mail.gmail.com>
 <20210731190103.6e2a3d41@jic23-huawei>
In-Reply-To: <20210731190103.6e2a3d41@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Wed, 4 Aug 2021 12:06:46 +0200
Message-ID: <CAN8YU5OrXy0c5D+5141izDJHxqSakGsbrnkug2M56qczxK0BfQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno sab 31 lug 2021 alle ore 19:58 Jonathan Cameron
<jic23@kernel.org> ha scritto:
>
> On Mon, 26 Jul 2021 16:36:49 +0200
> Andrea Merello <andrea.merello@gmail.com> wrote:
>
> > just a few of in-line comment below; OK for all the rest of your
> > comment, thanks!
> >
> > > > > > +static int bno055_reg_write(struct bno055_priv *priv,
> > > > > > +                         unsigned int reg, unsigned int val)
> > > > > > +{
> > > > > > +     int res = regmap_write(priv->regmap, reg, val);
> > > > > > +
> > > > > > +     if (res && res != -ERESTARTSYS) {
> > > > >
> > > > > I think Andy asked about these, so I won't repeat...
> > > > > Nice to get rid of those and just be able to make the regmap calls inline though...
> > > >
> > > > Ok for inline. I've just answered in another mail to Andy's comments
> > > > for the rest.
> >
> > Indeed, so far I couldn't understand what do you really mean. Should I
> > move those check+dev_err() inside the regmap core layer ?
>
> Better to move any necessary print to the caller of the reg_write() where any
> error message can often give more information.  Adding wrappers just to print
> an error message normally mostly serves to make the code a little harder to
> review.

Isn't this like doing a cut-and-paste of check+dev_err() in more than
a dozen places in the code?

If you just want more information about the caller then we could
macroize those functions, so they can also print the caller code line
number (or they could accept an additional argument, which is the code
line number to print, and then a macro helper that adds that last
argument can be used to invoke them).. But this wouldn't address your
second point..

> >
> > > > > > +     /*
> > > > > > +      * Start in fusion mode (all data available), but with magnetometer auto
> > > > > > +      * calibration switched off, in order not to overwrite magnetometer
> > > > > > +      * calibration data in case one want to keep it untouched.
> > > > >
> > > > > Why might you? good to have a default that is what people most commonly want...
> > > > > If there is a usecase for this then it may be better to have a 'disable autocalibration
> > > > > and manually reload a fixed calibration' path.
> > > >
> > > > I'm not sure whether disabling autocalibration for magnetometer is
> > > > just a matter of saving some power, or whether this has the purpose of
> > > > carefully doing the calibration far from magnetic disturbances,
> > > > avoiding screwing the calibration every time you briefly pass by a
> > > > piece of iron. I think I found some clues for this second
> > > > interpretation poking on the internet, but I don't know whether they
> > > > were right.
> > >
> > > It's possible if the calibration routines have much faster response than
> > > you'd normally expect.
> >
> > This HW function is called "Fast Magnetometer Calibration".. But I
> > don't know how fast is it..
>
> Nice  - got to love informative datasheets :)
>
> >
> >
> > > > > > +     &iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
> > > > > > +     &iio_dev_attr_in_anglvel_range_available.dev_attr.attr,
> > > > >
> > > > > Hmm. Range typically maps to something else (normally scale, but these smart
> > > > > sensors can do weird things)
> > > >
> > > > Here the scaling doesn't change, just the range. I *think* that by
> > > > changing range you also get better or worse precision.
> > >
> > > oh goody.  Make sure the default is maximum range + when you document this
> > > we will have to be careful to make it clear we don't want this to be used in
> > > drivers where scale is an option.  Perhaps we just put it in a device
> > > specific ABI file.
> > >
> >
> > The default is to run the IMU with fusion mode enabled; in this mode
> > those parameters are locked by the HW to a given value (which is not
> > the maximum e.g. in case of accelerometer range).
> >
> > If the user disables the fusion mode, then those parameters become
> > tweakable, but shouldn't they just remain at their previous values
> > (the one set by fusion mode), unless the user change also them?
>
> That makes sense to me.
>
> >
> > I.o.w the only chance we have for assigning them a "default" value is
> > when the fusion is switched off, but this would mean that switching
> > off fusion mode also has a side effect on those values (which I'm
> > unsure if we really want to happen).
>
> Thanks for the explanation.  Ok. Fine to have the range here, but please
> sanity check we have appropriate ABI documentation in the main ABI doc
> Documentation/ABI/testing/sysfs-bus-iio.

So you are inclined to generalize this thing, rather than keeping it
as bno055 specific..

> One thing to think about is how range would generalize.   These sensors are
> symmetric, but not all are - a range that is higher in postive than negative
> is definitely possible.  Perhaps we need to name it to make it clear we are
> talking magnitude here?

I'm open to suggestions here.

The word "range" in my mind just recalls the idea of a minimum/maximum
interval in which the sensor works, without recalling me the idea of
"scaling" or changes to the unit too much; this is why I originally
chosen this name, but that might be just mine personal taste.

> Ideally it should state something about range should be used only when it has no
> affect on scaling.  Hopefully we'll not get a device where it has an affect
> but it's non linear as that doesn't make any sense.  I'd imagine a range
> control in hardware either is proportional to the scale, or has no affect on
> it as here.

I may have a wrong memory here, but I think I've seen something like
this on some current-sense chips, which were available for various
current ranges, but their output scale changed in non linear way wrt
the range.

Or I can imagine a device in which you can set the internal amplifier
gain, and this will affect both the scale (because of the amplifier
gain itself) and the range (because the amplifier output does saturate
at a different voltage) with a linear relationship, but there is also
another bound: the physical sensor attached to the amplifier
mechanically clamp to a given max value, that happen to be less than
the saturation point of the amp at is minimum gain. This would lead to
a non-linear net relationship between scale and range because at the
minimum gain the range doesn't extends as much as you would expect.

.. But even in non linear cases, just having the scale may be OK..
Maybe we can just say that range can be used only if there are at
least two values for which we have the same scale value; otherwise
just having the scale attribute would suffice and thus we stick on
that.. We may think about allowing a RO range attribute, alongside the
scale attribute, for non obvious cases.


> Thanks,
>
> Jonathan
>
> >
> > Andrea
>
