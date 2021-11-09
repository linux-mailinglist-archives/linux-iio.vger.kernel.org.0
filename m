Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C605E44B1AE
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 18:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbhKIRGK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 12:06:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4077 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239427AbhKIRGK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 12:06:10 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HpZ6w6wh2z67gk4;
        Wed, 10 Nov 2021 01:03:04 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 18:03:21 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.15; Tue, 9 Nov
 2021 17:03:21 +0000
Date:   Tue, 9 Nov 2021 17:03:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andrea Merello <andrea.merello@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v2 03/10] iio: document euler angles modifiers
Message-ID: <20211109170320.0000597b@Huawei.com>
In-Reply-To: <CAN8YU5P97Au5Sq+43czRygGo4saywhR6BzefAsNz8ffDB3uEcg@mail.gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
        <20211028101840.24632-4-andrea.merello@gmail.com>
        <20211028114154.19e596fc@jic23-huawei>
        <CAN8YU5P97Au5Sq+43czRygGo4saywhR6BzefAsNz8ffDB3uEcg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 9 Nov 2021 09:15:09 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> Il giorno gio 28 ott 2021 alle ore 12:37 Jonathan Cameron
> <jic23@kernel.org> ha scritto:
> >
> > On Thu, 28 Oct 2021 12:18:33 +0200
> > Andrea Merello <andrea.merello@gmail.com> wrote:
> >  
> > > This patch introduces ABI documentation for new modifiers used for
> > > reporting rotations expressed as euler angles (i.e. yaw, pitch, roll).
> > >
> > > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > index 5147a00bf24a..f0adc2c817bd 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > @@ -1965,3 +1965,11 @@ KernelVersion: 5.15
> > >  Contact:     linux-iio@vger.kernel.org
> > >  Description:
> > >               Raw (unscaled) linear acceleration readings.
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_rot_yaw_raw
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_rot_pitch_raw
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_rot_roll_raw
> > > +KernelVersion:       5.15
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Raw (unscaled) euler angles readings.  
> > Any _raw entry should also include what the units are after application of
> > offset and scale.   Or you could just add this as more info to the in_rot_raw
> > block as an extra sentence explaining that they are euler angles.
> > That will lose the 'KernelVersion' information but honestly I'm not sure we
> > care that much about that.  
> 
> I'm unsure which block you are talking about: I see there are two
> blocks that refer to rot things: in_rot_quaternion_raw and
> in_rot_from_north_xxx_raw.
> 
> Looking at the 1st one description, it looks very specific to
> quaternions to me; the 2nd seems very specific to its own thing,
> whatever it is.. So I would just add the missing information (unit) in
> the new block just being introduced, if this is ok for you. Or am I
> missing some other block in which I could  coalesce this new euler
> thing?

Good point, not sure what I was thinking.  There isn't a sensible block
to add this to.  So just add the info about units.

Jonathan

> 
> 
> > Jonathan
> >
> >  

