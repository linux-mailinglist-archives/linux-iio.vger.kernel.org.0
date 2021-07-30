Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725E33DB971
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jul 2021 15:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhG3NkD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 30 Jul 2021 09:40:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3541 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbhG3Nir (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jul 2021 09:38:47 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GbpCG0wt3z6G9gq;
        Fri, 30 Jul 2021 21:29:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 15:38:34 +0200
Received: from localhost (10.47.1.48) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 30 Jul
 2021 14:38:33 +0100
Date:   Fri, 30 Jul 2021 14:38:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Patrick Regnouf <patrick@patricknet.net>
CC:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: IRQ related query
Message-ID: <20210730143804.00000037@Huawei.com>
In-Reply-To: <57344167-348E-4DB9-9FBF-354265200913@patricknet.net>
References: <CA+U=DsoVoTAodAYPKbpshHx3B3u5Cdeg0UJCumVOKO4YQLXCJg@mail.gmail.com>
        <57344167-348E-4DB9-9FBF-354265200913@patricknet.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.1.48]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 30 Jul 2021 11:08:54 +0100
Patrick Regnouf <patrick@patricknet.net> wrote:

> Alex, 
> 
> Thank you so much for clarifying this. It surely explains why I couldn’t find any documentation on how to do that!!!
> 
> Seems like, taking this in account,  we are going to go the i2c route…
> 
> Thanks again
> 
> 
> 
> /Patrick
> 
> > On 30 Jul 2021, at 09:30, Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
> > 
> > ﻿On Fri, Jul 30, 2021 at 11:03 AM <patrick@patricknet.net> wrote:  
> >> 
> >> Alex,
> >> 
> >> Thank you so very much for your help, I browsed most of that
> >> litterature already and the kernel side of it is very much covered,
> >> understood and assimilated.
> >> 
> >> However my question is basically: How can I be alerted, for example
> >> through a callback function, when an interruption occurs in the kernel
> >> space and my daemon lives in userspace.
> >> 
> >> IRQ Occuring -------> Upper half of the interrupt(put the timestamp in
> >> the buffer) ---------> Lower half of the interrupt handler (read data
> >> and adds the timestamp in the buffer) -----------> ???? userspace
> >> daemon (async callback of some description) that will write a log on
> >> the HD.
> >> 
> >> I have everything up to the daemon part written and working, I seem to
> >> understand that through libiio you can assign a trigger to a
> >> particular channel or attribute but that is where I get stuck.
> >> 
> >> Litterature on the libiio (most notably its wiki) has a chapter on
> >> triggers that is 4 lines long ... not very helpful to say the least.
> >> 
> >> iioinfo lists the devices present in the LSM6DSLTR (18 devices
> >> including two triggers) and I have been unable to assign the triggers
> >> to any device that they are not assigned to already (No such file or
> >> directory) which I gather refer to the absence of the trigger
> >> directory in the sysfs for that  particular device.
> >> 
> >> I also gather that the sysfs directory is, of course, slave to the
> >> kernel device tree and that the creation of that part of the device
> >> tree is made as the driver is loaded.
> >> 
> >> So there must be a way to alter that part of the sysfs filesystem by
> >> asking the kernel driver to provision a device in the context to
> >> implement the trigger directory so we can assign a trigger to it
> >> 
> >> second part will be to slave that trigger to an actual IRQ (42 in my
> >> case - as listed in /proc/interrupts) and be alerted in the  userspace
> >> daemon when a thresold has been reached in terms of either
> >> acceleration or vibration ...
> >> 
> >> Well, this is the nuts and bolts of what I am trying to achieve. the
> >> last part will be to write a few registers on the chip to configure
> >> how and when IRQ will occur for any given integrated devices.
> >> 
> >> Sorry to be such a pain but I thnk my problem lies in the passage of
> >> information from kernel space (very well documented) to the userspace
> >> (could not find reasonable documention and/or C code examples on how
> >> to achieve this)
> >> 
> >> Thnks again
> >> 
> >> /Patrick
> >> 
> >> 
> >> 
> >> 
> >> 
> >> 
> >> 
> >> 
> >> 
> >> Quoting Alexandru Ardelean <ardeleanalex@gmail.com>:
> >>   
> >>> On Thu, Jul 29, 2021 at 3:54 PM Patrick Regnouf
> >>> <patrick@patricknet.net> wrote:  
> >>>> 
> >>>> Hello,
> >>>>   
> >>> 
> >>> [I did not hit Reply All on my first email]
> >>> 
> >>> Hey,
> >>> 
> >>> For libiio in particular, it's on Github:
> >>> https://github.com/analogdevicesinc/libiio
> >>> 
> >>> I think you could raise some questions as issues there.
> >>> 
> >>> And there's also a wiki that can be browsed:
> >>> https://wiki.analog.com/resources/tools-software/linux-software/libiio
> >>> https://wiki.analog.com/resources/tools-software/linux-software/libiio_internals
> >>> 
> >>> Now, regarding IIO events support in libiio, I am not sure [at point
> >>> in time] whether support is implemented.
> >>> 
> >>> But an example of getting events from IIO can be found here:
> >>> https://github.com/torvalds/linux/blob/master/tools/iio/iio_event_monitor.c
> >>> 
> >>> The https://github.com/torvalds/linux/blob/master/tools/iio/  folder
> >>> in the kernel should offer some basic bits about accessing IIO
> >>> devices, and getting events [which can be driver IRQ events, or kernel
> >>> IIO polling]
> >>> 
> >>> I was going to answer on the previous question that you raised, but I forgot.
> >>> Apologies. It's been a busy week.  
> > 
> > Wait, I'm confusing/mixing triggers and events [in my head].
> > Apologies. I'm still processing the coffee I ingested 1-2h ago.
> > 
> > libiio supports triggers. But not events.
> > 
> > However, the driver for LSM6DSLTR (i.e. the one here
> > drivers/iio/imu/st_lsm6dsx) doesn't register any IIO triggers.
> > So, there's nothing for libiio [or any userspace tool] to hook into
> > for triggers.
> > 
> > There's an IRQ handler and IRQ thread-handler, but nothing to link
> > these to IIO framework triggers.
> > This needs to be implemented in the driver.
> > An example of how IIO kernel triggers should be implemented in the
> > driver is in drivers/iio/accel/adxl372.c and drivers/iio/imu/adis***
> > drivers.

The reason this device driver doesn't present a trigger is because the
hardware uses a rather sophisticated hardware fifo and those don't map
to a trigger (which tends to be one trigger per channel scan).

As such, based on the watermarks, data is pushed directly into the buffers.

So assuming your irq above is the one that the hardware is using to signal
events, then ignore triggers entirely - you don't need one here.

Userspace is ultimately able to use poll / select to be notified of
new data entering the software fifo, unfortunately I don't know how
libiio handles hardware fifo equipped devices.  The in kernel tree
https://elixir.bootlin.com/linux/latest/source/tools/iio/iio_generic_buffer.c
will handle this case fine with the -g parameter, though you may
want to poke appropriately small values into the watermark sysfs
files as well so you get data with lower latency.

Jonathan

> >   
> >>> 
> >>> Alex
> >>>   
> >>>> Please someone tell me whether this is the right mailing list to
> >>>> ask questions related to actually using libiio or actually please
> >>>> point me in the right direction
> >>>> 
> >>>> To summarise I am looking for C source code that would capture an
> >>>> IRQ emitted by an iio accelerometer (LSM6DSLTR) all of that using
> >>>> libiio
> >>>> 
> >>>> I have successfully implemented a program that can read the x, y
> >>>> and z axis but that means polling constantly. Not an option…  the
> >>>> iio_device_set_trigger however returns “no such file or directory “
> >>>> 
> >>>> Thanks
> >>>> 
> >>>> /Patrick  
> >> 
> >> 
> >>   
> 

