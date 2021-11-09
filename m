Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDFC44B1A4
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 18:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhKIRDa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 12:03:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4076 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236134AbhKIRD3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 12:03:29 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HpYyf1PVRz67xMM;
        Wed, 10 Nov 2021 00:55:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 18:00:41 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.15; Tue, 9 Nov
 2021 17:00:40 +0000
Date:   Tue, 9 Nov 2021 17:00:38 +0000
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
Subject: Re: [v2 02/10] iio: document linear acceleration modifiers
Message-ID: <20211109170038.00001879@Huawei.com>
In-Reply-To: <CAN8YU5O=rUMQNvu5TmRphYb9gqzNAS=Aai9TYf4bywi3QNXV6w@mail.gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
        <20211028101840.24632-3-andrea.merello@gmail.com>
        <20211028114008.0c2abf06@jic23-huawei>
        <CAN8YU5O=rUMQNvu5TmRphYb9gqzNAS=Aai9TYf4bywi3QNXV6w@mail.gmail.com>
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

On Tue, 9 Nov 2021 09:00:09 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> Il giorno gio 28 ott 2021 alle ore 12:35 Jonathan Cameron
> <jic23@kernel.org> ha scritto:
> >
> > On Thu, 28 Oct 2021 12:18:32 +0200
> > Andrea Merello <andrea.merello@gmail.com> wrote:
> >  
> > > This patch introduces ABI documentation for new iio modifiers used for
> > > reporting "linear acceleration" measures.
> > >
> > > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > index 6ad47a67521c..5147a00bf24a 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > @@ -1957,3 +1957,11 @@ Description:
> > >               Specify the percent for light sensor relative to the channel
> > >               absolute value that a data field should change before an event
> > >               is generated. Units are a percentage of the prior reading.
> > > +
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_accel_linear_x_raw
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_accel_linear_y_raw
> > > +What:                /sys/bus/iio/devices/iio:deviceX/in_accel_linear_z_raw
> > > +KernelVersion:       5.15
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Raw (unscaled) linear acceleration readings.  
> >
> > Probably need more information that this.   What element is being 'removed' from
> > a normal acceleration measurement? What are units after application of offset and
> > scale?  Can cross refer to the in_accel_x_raw for that info if you like.  
> 
> OK.  So, may I just state something like "As per in_accel_X_raw
> attributes, but minus the gravity acceleration"  ?

Yup, something along those lines.

Wow, I had a lot of typos in my email. :)

Jonathan


> 
> > Also, but them immediately after the block with the in_accel_x_raw etc  
> 
> OK
> 
> > The organization fo that file needs a rethink but let us try to avoid making
> > it worse in the meeantime!
> >
> > Jonathan
> >
> >  

