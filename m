Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F682C538C
	for <lists+linux-iio@lfdr.de>; Thu, 26 Nov 2020 13:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgKZMFA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Nov 2020 07:05:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2163 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgKZME7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Nov 2020 07:04:59 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ChbxW2SBLz67H3c;
        Thu, 26 Nov 2020 20:03:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 26 Nov 2020 13:04:57 +0100
Received: from localhost (10.52.122.48) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 26 Nov
 2020 12:04:56 +0000
Date:   Thu, 26 Nov 2020 12:04:40 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        russianneuromancer <russianneuromancer@ya.ru>
Subject: Re: [PATCH] iio: accel: kxcjk1013: Add tablet_mode sysfs file for
 exercising the KIOX010A ACPI DSM
Message-ID: <20201126120440.00006610@Huawei.com>
In-Reply-To: <1cf7d44c-832c-a62b-da4e-1df3a95610da@redhat.com>
References: <20201125085444.11593-1-hdegoede@redhat.com>
        <20201125085444.11593-2-hdegoede@redhat.com>
        <CAHp75VfMxzO2Qx_t7mSv+Y_DEN8Y2KYw02No=y=VuBNACtj4zg@mail.gmail.com>
        <94522440-5842-4527-f14e-e02462272611@redhat.com>
        <20201125184824.2052d6aa@archlinux>
        <1cf7d44c-832c-a62b-da4e-1df3a95610da@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.48]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 26 Nov 2020 11:30:22 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 11/25/20 7:48 PM, Jonathan Cameron wrote:
> > On Wed, 25 Nov 2020 11:55:45 +0100
> > Hans de Goede <hdegoede@redhat.com> wrote:
> >   
> >> Hi,
> >>
> >> On 11/25/20 11:34 AM, Andy Shevchenko wrote:  
> >>> On Wed, Nov 25, 2020 at 10:56 AM Hans de Goede <hdegoede@redhat.com> wrote:    
> >>>>
> >>>> Some 360 degree hinges (yoga) style 2-in-1 devices use 2 KXCJ91008-s
> >>>> to allow the OS to determine the angle between the display and the base
> >>>> of the device, so that the OS can determine if the 2-in-1 is in laptop
> >>>> or in tablet-mode.
> >>>>
> >>>> On Windows both accelerometers are read by a special HingeAngleService
> >>>> process; and this process calls a DSM (Device Specific Method) on the
> >>>> ACPI KIOX010A device node for the sensor in the display, to let the
> >>>> embedded-controller (EC) know about the mode so that it can disable the
> >>>> kbd and touchpad to avoid spurious input while folded into tablet-mode.
> >>>>
> >>>> Currently the kxcjk1013 driver calls the DSM for this once at probe time
> >>>> to ensure that the builtin kbd and touchpad work.
> >>>>
> >>>> But some users have expressed interest in using this functionality to
> >>>> disable the kbd and touchpad when folded into tablet-mode as done under
> >>>> Windows.
> >>>>
> >>>> Add a tablet_mode sysfs file so that users can control the kbd/touchpad
> >>>> enable/disable functionality from user-space.    
> > 
> > Biggest thing missing here is documentation.
> > 
> > Documentation/ABI/testing/sysfs-bus-iio-kxcjk1013  
> 
> Erm, as I explained in the cover letter this new sysfs attribute sits below
> 
> /sys/bus/i2c/devices/KIOX010A:00/
> 
oops.

> So thew new file is:
> 
> /sys/bus/i2c/devices/KIOX010A:00/tablet_mode
> 
> IOW it does NOT sit below:
> 
> /sys/bus/iio/devices/iio-device1
> 
> I did this deliberately so that it is in no way part of the IIO userspace-API
> (where it does not belong).
> 
> I did have it as part of the IIO userspace API before, that is one of
> the reasons why I wrote the:
> "iio: core: Copy iio_info.attrs->is_visible into iio_dev_opaque.chan_attr_group.is_visible"
> 
> Patch so that I could only make it show up in the KIOX010A case without needing
> to duplicate the structures describing the IIO channels. But just not putting
> it in the IIO "namespace" at all seemed cleaner, so I eventually went with
> that as solution.  And I still believe that having this under the i2c-device
> rather then under the iio-device is the right thing to do, but I'm open to
> changing that.
> 
> I guess I could still try to document it somewhere, but with the scheme
> which I chose there really isn't a vert good place to document this...

Definitely need docs, even if you need to create a new place to put it.
Probably need to cc the i2c list as well given it's ABI directly under
the I2C device. Possibly best to also cc linux-abi as this one is a bit
unusual.

ABI/test/sysfs-bus-i2c-devices-kxcjk1013 is probably the right place.
There is some precedent in similar files + they deliberately avoid
being too specific on the naming of the path.

> 
> > Unless this is documented somewhere else?  I've no idea if there is any
> > precedence for this/  
> 
> There is plenty of precedence for adhoc driver specific sysfs attributes
> being added to the (parent) device, but these tend to not be documented
> (which I must admit is kinda bad).

Absolutely.  I suspect and hope things are getting stricter on that
front than they have been in the past. Certainly Greg KH has been
pointing out when people try to sneak in undocumented ABI.

I guess long term, we should do a cleanup exercise to try and document
as many of those non standard bits of ABI as possible.  This is particularly
true as the ABI docs are now part of the nice pretty printed HTML docs.
(or will be very soon anyway given I'm not sure Mauro's work has landed
yet!)

Jonathan


> 
> >   
> >>>
> >>> ...
> >>>     
> >>>> +       err = kiox010a_dsm(&data->client->dev,
> >>>> +                          tablet_mode ? KIOX010A_SET_TABLET_MODE :
> >>>> +                                        KIOX010A_SET_LAPTOP_MODE);    
> >>>
> >>> A nit. With temporary variable it may be slightly better to read, like:
> >>>
> >>>   int value;
> >>>   ...
> >>>   value = tablet_mode ? KIOX010A_SET_TABLET_MODE : KIOX010A_SET_LAPTOP_MODE);
> >>>   err = kiox010a_dsm(&data->client->dev, value);    
> >>
> >> I'm fine with either solution, Jonathan let me know if you want a v2 with
> >> Andy's suggestion implemented (assuming you are willing to take this at all).  
> > 
> > Prefer Andy's suggestion slightly seeing as you are going around again to
> > include some docs :)  
> 
> Ok, I'll change this for v2 once we have the other bits figured out.
> 
> Regards,
> 
> Hans
> 

