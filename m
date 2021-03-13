Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C7033A00B
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 19:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhCMSr3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 13:47:29 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:48706 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhCMSqv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Mar 2021 13:46:51 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id C62779E00A0;
        Sat, 13 Mar 2021 18:46:48 +0000 (GMT)
Date:   Sat, 13 Mar 2021 18:46:46 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Subject: Re: [PATCH v6 20/24] iio: buffer: add ioctl() to support opening
 extra buffers for IIO device
Message-ID: <20210313184646.76653fae@archlinux>
In-Reply-To: <20210307121308.4702dcce@archlinux>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
        <20210215104043.91251-21-alexandru.ardelean@analog.com>
        <877ca331-1a56-1bd3-6637-482bbf060ba9@metafoo.de>
        <20210228143429.00001f01@Huawei.com>
        <5f9070a5-2c3d-f185-1981-10ec768dbb4a@metafoo.de>
        <20210228172753.0000568c@Huawei.com>
        <CA+U=Dsqs_B3=6FSS0dmGsRUKwD826Qy250OXzyp5mBFHt4t6MQ@mail.gmail.com>
        <20210307121308.4702dcce@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 7 Mar 2021 12:13:08 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 6 Mar 2021 19:00:52 +0200
> Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
> 
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
> > > > >>> With this change, an ioctl() call is added to open a character device for a
> > > > >>> buffer. The ioctl() number is 'i' 0x91, which follows the
> > > > >>> IIO_GET_EVENT_FD_IOCTL ioctl.
> > > > >>>
> > > > >>> The ioctl() will return an FD for the requested buffer index. The indexes
> > > > >>> are the same from the /sys/iio/devices/iio:deviceX/bufferY (i.e. the Y
> > > > >>> variable).
> > > > >>>
> > > > >>> Since there doesn't seem to be a sane way to return the FD for buffer0 to
> > > > >>> be the same FD for the /dev/iio:deviceX, this ioctl() will return another
> > > > >>> FD for buffer0 (or the first buffer). This duplicate FD will be able to
> > > > >>> access the same buffer object (for buffer0) as accessing directly the
> > > > >>> /dev/iio:deviceX chardev.
> > > > >>>
> > > > >>> Also, there is no IIO_BUFFER_GET_BUFFER_COUNT ioctl() implemented, as the
> > > > >>> index for each buffer (and the count) can be deduced from the
> > > > >>> '/sys/bus/iio/devices/iio:deviceX/bufferY' folders (i.e the number of
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
> > > > >>>                   fprintf(stderr, "Error open() %d errno %d\n",fd, errno);
> > > > >>>                   return -1;
> > > > >>>           }
> > > > >>>
> > > > >>>           fprintf(stderr, "Using FD %d\n", fd);
> > > > >>>
> > > > >>>           fd1 = atoi(argv[1]);
> > > > >>>
> > > > >>>           ret = ioctl(fd, IIO_BUFFER_GET_FD_IOCTL, &fd1);
> > > > >>>           if (ret < 0) {
> > > > >>>                   fprintf(stderr, "Error for buffer %d ioctl() %d errno %d\n", fd1, ret, errno);
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
> > > > >>> iio:device0 has some fake kfifo buffers attached to an IIO device.    
> > > > >> For me there is one major problem with this approach. We only allow one
> > > > >> application to open /dev/iio:deviceX at a time. This means we can't have
> > > > >> different applications access different buffers of the same device. I
> > > > >> believe this is a circuital feature.    
> > > > > Thats not quite true (I think - though I've not tested it).  What we don't
> > > > > allow is for multiple processes to access them in an unaware fashion.
> > > > > My assumption is we can rely on fork + fd passing via appropriate sockets.
> > > > >    
> > > > >> It is possible to open the chardev, get the annonfd, close the chardev
> > > > >> and keep the annonfd open. Then the next application can do the same and
> > > > >> get access to a different buffer. But this has room for race conditions
> > > > >> when two applications try this at the very same time.
> > > > >>
> > > > >> We need to somehow address this.    
> > > > > I'd count this as a bug :).  It could be safely done in a particular custom
> > > > > system but in general it opens a can of worm.
> > > > >    
> > > > >> I'm also not much of a fan of using ioctls to create annon fds. In part
> > > > >> because all the standard mechanisms for access control no longer work.    
> > > > > The inability to trivially have multiple processes open the anon fds
> > > > > without care is one of the things I like most about them.
> > > > >
> > > > > IIO drivers and interfaces really aren't designed for multiple unaware
> > > > > processes to access them.  We don't have per process controls for device
> > > > > wide sysfs attributes etc.  In general, it would be hard to
> > > > > do due to the complexity of modeling all the interactions between the
> > > > > different interfaces (events / buffers / sysfs access) in a generic fashion.
> > > > >
> > > > > As such, the model, in my head at least, is that we only want a single
> > > > > process to ever be responsible for access control.  That process can then
> > > > > assign access to children or via a deliberate action (I think passing the
> > > > > anon fd over a unix socket should work for example).  The intent being
> > > > > that it is also responsible for mediating access to infrastructure that
> > > > > multiple child processes all want to access.
> > > > >
> > > > > As such, having one chrdev isn't a disadvantage because only one process
> > > > > should ever open it at a time.  This same process also handles the
> > > > > resource / control mediation.  Therefore we should only have one file
> > > > > exposed for all the standard access control mechanisms.
> > > > >    
> > > > Hm, I see your point, but I'm not convinced.
> > > >
> > > > Having to have explicit synchronization makes it difficult to mix and
> > > > match. E.g. at ADI a popular use case for testing was to run some signal
> > > > generator application on the TX buffer and some signal analyzer
> > > > application on the RX buffer.
> > > >
> > > > Both can be launched independently and there can be different types of
> > > > generator and analyzer applications. Having to have a 3rd application to
> > > > arbitrate access makes this quite cumbersome. And I'm afraid that in
> > > > reality people might just stick with the two devices model just to avoid
> > > > this restriction.    
> > >
> > > I'd argue that's a problem best tackled in a library - though it's a bit
> > > fiddly.  It ought to be possible to make it invisible that this level
> > > of sharing is going on.   The management process you describe would probably
> > > be a thread running inside the first process to try and access a given device.
> > > A second process failing to open the file with -EBUSY then connects to
> > > appropriate socket (via path in /tmp or similar) and asks for the FD.
> > > There are race conditions that might make it fail, but a retry loop should
> > > deal with those.
> > >
> > > I agree people might just stick to a two device model and if the devices
> > > are independent enough I'm not sure that is the wrong way to approach the
> > > problem.  It represents the independence and that the driver is being careful
> > > that it both can and is safely handle independent simultaneous accessors.
> > > We are always going to have some drivers doing that anyway because they've
> > > already been doing that for years.
> > >    
> > 
> > This is the last of the 3 patches that I need to re-spin after Lars' review.
> > I have a good handle on the small stuff.
> > 
> > I'm not sure about the race-condition about which Lars was talking about.
> > I mean, I get the problem, but is it a problem that we should fix in the kernel?
> > 
> > I'm sensing that Jonathan's preference is to keep things mostly as the
> > current implementation.
> > I'll probably leave this alone for a few days.  
> 
> Wise move :)  Whilst I'm currently falling on the side of leaving the
> current situation fo the ioctl, I'm not sure the discussion has completely
> finished. 
> 
> I'm not keen to delay this series too much because other stuff will back
> up behind it.  For now I'm in two minds on whether to back out the series
> (on basis it's easy enough to bring back until churn gets us) or rely
> on us being able to make any tweaks in a safe fashion.
> 
> Note we will have a little time to tweak the interface either way
> as there aren't any mainline drivers using it yet.  As a result
> I'm open to other proposals until this becomes ABI that we have to
> support for ever.
> 
> Ideally I'd have lots of time and mock up the userspace library handling
> that I think would hid most of the magic needed, but who knows when I'll
> get time for that...
So just to update. My current plan is to leave this series in place as it
is (with fixes etc as they come).

If we need to we can always block off the ioctl later this cycle and rethink.

Jonathan

> 
> > And I'll prepare some patches for the tweaks Lars suggested (adding
> > O_NONBLOCK and doing things a bit differently with the FD).
> > I'll send those in the next few days.  
> 
> Great.
> 
> Jonathan
> 
> >   
> > > J
> > >    
> > > >
> > > > - Lars
> > > >    
> > >    
> 

