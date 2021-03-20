Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241E5342EA7
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 18:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhCTRlM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 20 Mar 2021 13:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229905AbhCTRlH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 13:41:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7161161922;
        Sat, 20 Mar 2021 17:41:04 +0000 (UTC)
Date:   Sat, 20 Mar 2021 17:41:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "zzzzArdelean, zzzzAlexandru" <alexandru.Ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH v6 20/24] iio: buffer: add ioctl() to support opening
 extra buffers for IIO device
Message-ID: <20210320174100.6808ad36@jic23-huawei>
In-Reply-To: <CY4PR03MB2631CF5082542DBF3F109E08996C9@CY4PR03MB2631.namprd03.prod.outlook.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
        <20210215104043.91251-21-alexandru.ardelean@analog.com>
        <877ca331-1a56-1bd3-6637-482bbf060ba9@metafoo.de>
        <20210228143429.00001f01@Huawei.com>
        <5f9070a5-2c3d-f185-1981-10ec768dbb4a@metafoo.de>
        <20210228172753.0000568c@Huawei.com>
        <CA+U=Dsqs_B3=6FSS0dmGsRUKwD826Qy250OXzyp5mBFHt4t6MQ@mail.gmail.com>
        <CY4PR03MB2631CF5082542DBF3F109E08996C9@CY4PR03MB2631.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Mar 2021 09:58:08 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Alexandru Ardelean <ardeleanalex@gmail.com>
> > Sent: Saturday, March 6, 2021 6:01 PM
> > To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>; zzzzArdelean,
> > zzzzAlexandru <alexandru.Ardelean@analog.com>; LKML <linux-  
> > kernel@vger.kernel.org>; linux-iio <linux-iio@vger.kernel.org>;  
> > Hennerich, Michael <Michael.Hennerich@analog.com>; Jonathan
> > Cameron <jic23@kernel.org>; Sa, Nuno <Nuno.Sa@analog.com>;
> > Bogdan, Dragos <Dragos.Bogdan@analog.com>
> > Subject: Re: [PATCH v6 20/24] iio: buffer: add ioctl() to support opening
> > extra buffers for IIO device
> > 
> > [External]
> > 
> > On Sun, Feb 28, 2021 at 9:00 PM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:  
> > >
> > > On Sun, 28 Feb 2021 16:51:51 +0100
> > > Lars-Peter Clausen <lars@metafoo.de> wrote:
> > >  
> > > > On 2/28/21 3:34 PM, Jonathan Cameron wrote:  
> > > > > On Sun, 28 Feb 2021 09:51:38 +0100
> > > > > Lars-Peter Clausen <lars@metafoo.de> wrote:
> > > > >  
> > > > >> On 2/15/21 11:40 AM, Alexandru Ardelean wrote:  
> > > > >>> With this change, an ioctl() call is added to open a character  
> > device for a  
> > > > >>> buffer. The ioctl() number is 'i' 0x91, which follows the
> > > > >>> IIO_GET_EVENT_FD_IOCTL ioctl.
> > > > >>>
> > > > >>> The ioctl() will return an FD for the requested buffer index.  
> > The indexes  
> > > > >>> are the same from the /sys/iio/devices/iio:deviceX/bufferY  
> > (i.e. the Y  
> > > > >>> variable).
> > > > >>>
> > > > >>> Since there doesn't seem to be a sane way to return the FD for  
> > buffer0 to  
> > > > >>> be the same FD for the /dev/iio:deviceX, this ioctl() will return  
> > another  
> > > > >>> FD for buffer0 (or the first buffer). This duplicate FD will be  
> > able to  
> > > > >>> access the same buffer object (for buffer0) as accessing  
> > directly the  
> > > > >>> /dev/iio:deviceX chardev.
> > > > >>>
> > > > >>> Also, there is no IIO_BUFFER_GET_BUFFER_COUNT ioctl()  
> > implemented, as the  
> > > > >>> index for each buffer (and the count) can be deduced from  
> > the  
> > > > >>> '/sys/bus/iio/devices/iio:deviceX/bufferY' folders (i.e the  
> > number of  
> > > > >>> bufferY folders).
> > > > >>>
> > > > >>> Used following C code to test this:
> > > > >>> -------------------------------------------------------------------
> > > > >>>
> > > > >>>    #include <stdio.h>
> > > > >>>    #include <stdlib.h>
> > > > >>>    #include <unistd.h>
> > > > >>>    #include <sys/ioctl.h>
> > > > >>>    #include <fcntl.h"
> > > > >>>    #include <errno.h>
> > > > >>>
> > > > >>>    #define IIO_BUFFER_GET_FD_IOCTL      _IOWR('i', 0x91, int)
> > > > >>>
> > > > >>> int main(int argc, char *argv[])
> > > > >>> {
> > > > >>>           int fd;
> > > > >>>           int fd1;
> > > > >>>           int ret;
> > > > >>>
> > > > >>>           if ((fd = open("/dev/iio:device0", O_RDWR))<0) {
> > > > >>>                   fprintf(stderr, "Error open() %d errno %d\n",fd,  
> > errno);  
> > > > >>>                   return -1;
> > > > >>>           }
> > > > >>>
> > > > >>>           fprintf(stderr, "Using FD %d\n", fd);
> > > > >>>
> > > > >>>           fd1 = atoi(argv[1]);
> > > > >>>
> > > > >>>           ret = ioctl(fd, IIO_BUFFER_GET_FD_IOCTL, &fd1);
> > > > >>>           if (ret < 0) {
> > > > >>>                   fprintf(stderr, "Error for buffer %d ioctl() %d errno  
> > %d\n", fd1, ret, errno);  
> > > > >>>                   close(fd);
> > > > >>>                   return -1;
> > > > >>>           }
> > > > >>>
> > > > >>>           fprintf(stderr, "Got FD %d\n", fd1);
> > > > >>>
> > > > >>>           close(fd1);
> > > > >>>           close(fd);
> > > > >>>
> > > > >>>           return 0;
> > > > >>> }
> > > > >>> -------------------------------------------------------------------
> > > > >>>
> > > > >>> Results are:
> > > > >>> -------------------------------------------------------------------
> > > > >>>    # ./test 0
> > > > >>>    Using FD 3
> > > > >>>    Got FD 4
> > > > >>>
> > > > >>>    # ./test 1
> > > > >>>    Using FD 3
> > > > >>>    Got FD 4
> > > > >>>
> > > > >>>    # ./test 2
> > > > >>>    Using FD 3
> > > > >>>    Got FD 4
> > > > >>>
> > > > >>>    # ./test 3
> > > > >>>    Using FD 3
> > > > >>>    Got FD 4
> > > > >>>
> > > > >>>    # ls /sys/bus/iio/devices/iio\:device0
> > > > >>>    buffer  buffer0  buffer1  buffer2  buffer3  dev
> > > > >>>    in_voltage_sampling_frequency  in_voltage_scale
> > > > >>>    in_voltage_scale_available
> > > > >>>    name  of_node  power  scan_elements  subsystem  uevent
> > > > >>> -------------------------------------------------------------------
> > > > >>>
> > > > >>> iio:device0 has some fake kfifo buffers attached to an IIO  
> > device.  
> > > > >> For me there is one major problem with this approach. We only  
> > allow one  
> > > > >> application to open /dev/iio:deviceX at a time. This means we  
> > can't have  
> > > > >> different applications access different buffers of the same  
> > device. I  
> > > > >> believe this is a circuital feature.  
> > > > > Thats not quite true (I think - though I've not tested it).  What we  
> > don't  
> > > > > allow is for multiple processes to access them in an unaware  
> > fashion.  
> > > > > My assumption is we can rely on fork + fd passing via appropriate  
> > sockets.  
> > > > >  
> > > > >> It is possible to open the chardev, get the annonfd, close the  
> > chardev  
> > > > >> and keep the annonfd open. Then the next application can do  
> > the same and  
> > > > >> get access to a different buffer. But this has room for race  
> > conditions  
> > > > >> when two applications try this at the very same time.
> > > > >>
> > > > >> We need to somehow address this.  
> > > > > I'd count this as a bug :).  It could be safely done in a particular  
> > custom  
> > > > > system but in general it opens a can of worm.
> > > > >  
> > > > >> I'm also not much of a fan of using ioctls to create annon fds. In  
> > part  
> > > > >> because all the standard mechanisms for access control no  
> > longer work.  
> > > > > The inability to trivially have multiple processes open the anon  
> > fds  
> > > > > without care is one of the things I like most about them.
> > > > >
> > > > > IIO drivers and interfaces really aren't designed for multiple  
> > unaware  
> > > > > processes to access them.  We don't have per process controls  
> > for device  
> > > > > wide sysfs attributes etc.  In general, it would be hard to
> > > > > do due to the complexity of modeling all the interactions  
> > between the  
> > > > > different interfaces (events / buffers / sysfs access) in a generic  
> > fashion.  
> > > > >
> > > > > As such, the model, in my head at least, is that we only want a  
> > single  
> > > > > process to ever be responsible for access control.  That process  
> > can then  
> > > > > assign access to children or via a deliberate action (I think passing  
> > the  
> > > > > anon fd over a unix socket should work for example).  The intent  
> > being  
> > > > > that it is also responsible for mediating access to infrastructure  
> > that  
> > > > > multiple child processes all want to access.
> > > > >
> > > > > As such, having one chrdev isn't a disadvantage because only one  
> > process  
> > > > > should ever open it at a time.  This same process also handles the
> > > > > resource / control mediation.  Therefore we should only have  
> > one file  
> > > > > exposed for all the standard access control mechanisms.
> > > > >  
> > > > Hm, I see your point, but I'm not convinced.
> > > >
> > > > Having to have explicit synchronization makes it difficult to mix and
> > > > match. E.g. at ADI a popular use case for testing was to run some  
> > signal  
> > > > generator application on the TX buffer and some signal analyzer
> > > > application on the RX buffer.
> > > >
> > > > Both can be launched independently and there can be different  
> > types of  
> > > > generator and analyzer applications. Having to have a 3rd  
> > application to  
> > > > arbitrate access makes this quite cumbersome. And I'm afraid that  
> > in  
> > > > reality people might just stick with the two devices model just to  
> > avoid  
> > > > this restriction.  
> > >
> > > I'd argue that's a problem best tackled in a library - though it's a bit
> > > fiddly.  It ought to be possible to make it invisible that this level
> > > of sharing is going on.   The management process you describe would  
> > probably  
> > > be a thread running inside the first process to try and access a given  
> > device.  
> > > A second process failing to open the file with -EBUSY then connects  
> > to  
> > > appropriate socket (via path in /tmp or similar) and asks for the FD.
> > > There are race conditions that might make it fail, but a retry loop  
> > should  
> > > deal with those.
> > >
> > > I agree people might just stick to a two device model and if the  
> > devices  
> > > are independent enough I'm not sure that is the wrong way to  
> > approach the  
> > > problem.  It represents the independence and that the driver is  
> > being careful  
> > > that it both can and is safely handle independent simultaneous  
> > accessors.  
> > > We are always going to have some drivers doing that anyway  
> > because they've  
> > > already been doing that for years.
> > >  
> > 
> > This is the last of the 3 patches that I need to re-spin after Lars' review.
> > I have a good handle on the small stuff.
> > 
> > I'm not sure about the race-condition about which Lars was talking
> > about.
> > I mean, I get the problem, but is it a problem that we should fix in the
> > kernel?  
> 
> Hi all,
> 
> FWIW, I think that this really depends on the chosen ABI. If we do use
> the ioctl to return the buffer fd and just allow one app to hold the chardev
> at a time, I agree with Alex that this is not really a race and is just something
> that userspace needs to deal with....
> 
> That said and giving my superficial (I did not really read the full series) piece on this,
> I get both Lars and Jonathan points and, personally, it feels that the most natural thing
> would be to have a chardev per buffer...
> 
> On the other hand, AFAIC, events are also being handled in the same chardev as
> buffers, which makes things harder in terms of consistency... Events are per device
> and not per buffers right? My point is that, to have a chardev per buffer, it would make
> sense to detach events from the buffer stuff and that seems to be not doable without
> breaking ABI (we would probably need to assume that events and buffer0 are on the
> same chardev).

Events are interesting as there is no particular reason to assume the driver
handling buffer0 is the right one to deal with them.  It might just as easily
be the case that they are of interest to a process that is concerned with buffer1.

To add a bit more flavour to my earlier comments.

I'm still concerned that if we did do multiple /dev/* files it would allow code
to think it has complete control over the device when it really doesn't.
Events are just one aspect of that.

We have had discussions in the past about allowing multiple userspace consumers
for a single buffer, but the conclusion there was that was a job for userspace
(daemon or similar) software which can deal with control inter dependencies etc.

There are already potential messy corners we don't handle for userspace
iio buffers vs in kernel users (what happens if they both try to control the
sampling frequency?)  I'm not keen to broaden this problem set.
If a device genuinely has separate control and pipelines for different
buffers then we are probably better representing that cleanly as
an mfd type layer and two separate IIO devices. Its effectively the
same a multi chip package.

A more classic multibuffer usecase is the one where you have related
datastreams that run at different rates (often happens in devices with
tagged FIFO elements). These are tightly coupled but we need to split
the data stream (or add tagging to our FIFOs.). Another case would be
DMA based device that puts channels into buffers that are entirely
separate in memory address rather than interleaved.

So I still need to put together a PoC, but it feels like there are various
software models that will give the illusion of there being separate
/dev/* files, but with an aspect of control being possible.

1. Daemon, if present that can hand off chardevs to who needs them
2. Library to make the first user of the buffer responsible for providing
   service to other users.  Yes there are races, but I don't think they
   are hard to deal in normal usecases.  (retry loops)

Jonathan


> 
> - Nuno Sá

