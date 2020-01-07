Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5004B13257C
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2020 12:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgAGL7m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Jan 2020 06:59:42 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2233 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbgAGL7l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 Jan 2020 06:59:41 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 12FB45C68102FBB7BE4F;
        Tue,  7 Jan 2020 11:59:40 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 7 Jan 2020 11:59:39 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Jan 2020
 11:59:39 +0000
Date:   Tue, 7 Jan 2020 11:59:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Linux Input" <linux-input@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Donggeun Kim <dg77.kim@samsung.com>,
        Minkyu Kang <mk7.kang@samsung.com>,
        =?UTF-8?Q?Pawe=C5=82?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        "Jonathan Bakker" <xc-racer2@live.ca>,
        Oskar Andero <oskar.andero@gmail.com>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2 v1] iio: light: Add a driver for Sharp GP2AP002x00F
Message-ID: <20200107115938.00005c08@Huawei.com>
In-Reply-To: <CACRpkdbpqge9beL8QEdqnA3pN+41PUfJg4Zr9hDnnYYkatSYTg@mail.gmail.com>
References: <20191228201109.13635-1-linus.walleij@linaro.org>
        <20191228201109.13635-2-linus.walleij@linaro.org>
        <20191230173919.373f4e8a@archlinux>
        <CACRpkdbpqge9beL8QEdqnA3pN+41PUfJg4Zr9hDnnYYkatSYTg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 6 Jan 2020 10:08:55 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> Hi Jonathan,
> 
> fixed most of the things and resending as v2 soon-ish,
> some inline responses, comments:
> 
> On Mon, Dec 30, 2019 at 6:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sat, 28 Dec 2019 21:11:09 +0100 Linus Walleij <linus.walleij@linaro.org> wrote:  
> 
> > If at all possible I'd like to discourage use of of specific
> > calls in favour of the generic ones.  It's pretty unlikely we'll
> > ever see this driver using anything else, but I'd like to build
> > up a good set of examples to point people at now that functionality
> > is in place.  
> 
> I guess you mean to use fwnode where possible. I comment on this
> below.

yes, though more specifically PRP0001 usage, which basically puts the
DT directly into ACPI.

> 
> > > +     iio_push_event(indio_dev, ev, iio_get_time_ns(indio_dev));
> > > +     usleep_range(20000, 30000);  
> >
> > What is the basis for these timings?  
> 
> Detection cycle, I explained this with an inline comment.
> 
> > > +     gp2ap002->is_gp2ap002s00f =
> > > +             of_device_is_compatible(np, "sharp,gp2ap002s00f");  
> >
> > Hmm. This rather breaks my comment below about trying to avoid making
> > this of specific if we don't need to...
> >
> > I 'think' we could use device_property_read_string
> > There is a bit of precedence for doing so, but it is not common.  
> 
> This is the real trick. Using
> device_property_read_string(dev, "compatible", str);
> isn't going to work as ACPI probes from a unique 4-char
> ID not a compatible string this will never work on ACPI
> anyways.

Is that true for PRP0001?  That's the ACPI case we normally
care about in cases like this.

https://lkml.org/lkml/2019/3/22/1612

Has an explicit "compatible" property.


> 
> I can try to go some extra mile to support a hypothetical
> ACPI client by adding a struct with one bool member as
> match data and pass that around if you insist, but I think it's
> more something appropriate for the first ACPI user to do.
> 
> It's no problem if you want it, but it will add a bunch of
> boilerplate just for this.
> 
> > > +     /* Check the device tree for the IR LED hysteresis */
> > > +     ret = of_property_read_u32(np, "sharp,proximity-far-hysteresis", &val);  
> >
> > Do these belong in DT at all, or are they more of a policy decision?
> > Without a datasheet I'm kind of guessing what they actually are.  
> 
> There is a datasheet:
> https://global.sharp/products/device-china/lineup/data/pdf/datasheet/gp2ap002s00f_appl_e.pdf
> 
> > We have the option for hysterisis controls on events from sysfs if that
> > make sense.  
> 
> I don't know, these are two hysteresis settings: one that detects an
> object close to the sensor and one detecting an object far from
> the sensor.
> 
> The two settings are describes as fixed to mode A, B1 and B2 in the
> datasheet. However there is a vendor driver in one of the phone
> trees that use "mode B 1.5" not documented in the datasheet
> (bummer). So given how fluid this all is I opted for just an u8
> in the device tree for "close" and "far" hysteresis setting.

OK, lets leave this, but maybe add a comment somewhere to give this
bit of detail.

> 
> > Could use the fwnode_get_property_u32 etc to drop reliance on OF.  
> 
> Will do if we must support hypotetical non-DT probe.
> 
> > > +     /* The GP2AP002A00F has a light sensor too */
> > > +     if (!gp2ap002->is_gp2ap002s00f) {  
> >
> > This section is rather 'unusual' and definitely needs some explanatory
> > comments - particularly as I can't find any reference docs for the part.  
> 
> The only reference for the light sensor part in GP2AP002A00F
> is the submission from Samsung mentioned in the header of the
> driver submitted by Donggeun Kim & Minkyu Kang in 2011:
> https://lore.kernel.org/lkml/1315556546-7445-1-git-send-email-dg77.kim@samsung.com/
> 
> It also appears in the GPL code from GT-S7710 which seems to
> derive from a code drop from Sharp.
> 
> Yep the code is the documentation...

:(

> 
> > I'm guessing that the light sensor is simply an analog output?  As such
> > you need to wire it up to a separate ADC to actually read the light level...  
> 
> Yep that's the same method as used for
> drivers/iio/light/cm3605.c
> Most early Androids do something like that, and all SoCs seem to
> provide some ADC to do the conversion.
> 

Fair enough, a few more comments perhaps in the code for when we inevitably
forget all this history ;)

Thanks,

Jonathan

> Yours,
> Linus Walleij


