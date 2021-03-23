Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F818345B5F
	for <lists+linux-iio@lfdr.de>; Tue, 23 Mar 2021 10:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhCWJvh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Mar 2021 05:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhCWJvR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Mar 2021 05:51:17 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B39C061574;
        Tue, 23 Mar 2021 02:51:17 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id v3so17566039ilj.12;
        Tue, 23 Mar 2021 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J+WSriuUwQvhkJ+nAbVFbI+yZGyYoM9Oab0+ZkZxTBc=;
        b=MKXSk5i7EcOQ1joO3Fl8ooDl0LdnCVzjU1TmFJ5E+6fhEBZdyisRM5mIqmx2/U6JgU
         tjkEpFzYPHzCLCNzYNdfMKuCBFMDCT7Rii8kUjuACrHW0uxy3mIxHIzdp5ivW4L8qfmM
         P4+GMiHOvSHSX+eqmz31RCiYgNa3lOHBq1hmD7KJ3LQTr/r7bVAvqZMS7uTp+F2TDThB
         /1QsetOgcUevKcSK2D4AwdwTw941JRmKcz9Sz0aF7K1rhZYgNPHcGLP1tMepuNpeQ338
         ABOVmIs3+D6DejL31X1uivkQZUNeiDyEmlRltf09oM66CsIQtpc0OyFL+MtWkecplPqg
         sn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J+WSriuUwQvhkJ+nAbVFbI+yZGyYoM9Oab0+ZkZxTBc=;
        b=dGipMA8ENHe/CbzTG/tOCMks2zP5oP9L21tu+dEBI5bPg2JQWMP6n4JgERvsBMAWA4
         jfT9lu7mwvrOcBlsykU2SPN89c7U7Jc+6koghw7/35uJcFZDEYVhpHsa5XqtN26hsLux
         K58IgdvOhRjmzKJdaaEAhXGku5/lmT2M9idi1av7u3PHPUJaei60CH/5wqPEhHBVZkuX
         ztL5aaaLD8K2IPKnxk2wSdUNnyRZ15DN4ORbHR5RlyggIeaKkPrXnol7qQM5nSFCS2DA
         OIFY+8CD6UtytdCFZCiarqekCiYtKWo12CrmzQhXH9OUkmqdhDRLjhmWAR2CEImJgXiq
         PAbg==
X-Gm-Message-State: AOAM533h/obIL2u7u/ZiSitvragW5fVT4bN8Y06gZicnS8qxuHVmQc6Z
        cmRDB8UkSunZCUJCXiXZsa2JxYIpYL1elH59QrQMPMrW3TE=
X-Google-Smtp-Source: ABdhPJwR0XaUDuLIJRs8kzCVtckRsJpSueX0ej8zQ5KtLOnNcSFsGI/UCcJtxeWYtbCZbZPCbGw3CG9s8Nn7Pd25J84=
X-Received: by 2002:a05:6e02:138f:: with SMTP id d15mr4000313ilo.217.1616493076710;
 Tue, 23 Mar 2021 02:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-21-alexandru.ardelean@analog.com> <877ca331-1a56-1bd3-6637-482bbf060ba9@metafoo.de>
 <20210228143429.00001f01@Huawei.com> <5f9070a5-2c3d-f185-1981-10ec768dbb4a@metafoo.de>
 <20210228172753.0000568c@Huawei.com> <CA+U=Dsqs_B3=6FSS0dmGsRUKwD826Qy250OXzyp5mBFHt4t6MQ@mail.gmail.com>
 <CY4PR03MB2631CF5082542DBF3F109E08996C9@CY4PR03MB2631.namprd03.prod.outlook.com>
 <20210320174100.6808ad36@jic23-huawei> <20210321173713.2691e0bb@jic23-huawei>
In-Reply-To: <20210321173713.2691e0bb@jic23-huawei>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 23 Mar 2021 11:51:04 +0200
Message-ID: <CA+U=DsouJuVyUThPO_p9MNt5ziWHdU2RhuGQLWgOBML6wFPWhA@mail.gmail.com>
Subject: Re: [PATCH v6 20/24] iio: buffer: add ioctl() to support opening
 extra buffers for IIO device
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "zzzzArdelean, zzzzAlexandru" <alexandru.Ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 21, 2021 at 7:37 PM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
> On Sat, 20 Mar 2021 17:41:00 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Mon, 15 Mar 2021 09:58:08 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> >
> > > > -----Original Message-----
> > > > From: Alexandru Ardelean <ardeleanalex@gmail.com>
> > > > Sent: Saturday, March 6, 2021 6:01 PM
> > > > To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Cc: Lars-Peter Clausen <lars@metafoo.de>; zzzzArdelean,
> > > > zzzzAlexandru <alexandru.Ardelean@analog.com>; LKML <linux-
> > > > kernel@vger.kernel.org>; linux-iio <linux-iio@vger.kernel.org>;
> > > > Hennerich, Michael <Michael.Hennerich@analog.com>; Jonathan
> > > > Cameron <jic23@kernel.org>; Sa, Nuno <Nuno.Sa@analog.com>;
> > > > Bogdan, Dragos <Dragos.Bogdan@analog.com>
> > > > Subject: Re: [PATCH v6 20/24] iio: buffer: add ioctl() to support o=
pening
> > > > extra buffers for IIO device
> > > >
> > > > [External]
> > > >
> > > > On Sun, Feb 28, 2021 at 9:00 PM Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > >
> > > > > On Sun, 28 Feb 2021 16:51:51 +0100
> > > > > Lars-Peter Clausen <lars@metafoo.de> wrote:
> > > > >
> > > > > > On 2/28/21 3:34 PM, Jonathan Cameron wrote:
> > > > > > > On Sun, 28 Feb 2021 09:51:38 +0100
> > > > > > > Lars-Peter Clausen <lars@metafoo.de> wrote:
> > > > > > >
> > > > > > >> On 2/15/21 11:40 AM, Alexandru Ardelean wrote:
> > > > > > >>> With this change, an ioctl() call is added to open a charac=
ter
> > > > device for a
> > > > > > >>> buffer. The ioctl() number is 'i' 0x91, which follows the
> > > > > > >>> IIO_GET_EVENT_FD_IOCTL ioctl.
> > > > > > >>>
> > > > > > >>> The ioctl() will return an FD for the requested buffer inde=
x.
> > > > The indexes
> > > > > > >>> are the same from the /sys/iio/devices/iio:deviceX/bufferY
> > > > (i.e. the Y
> > > > > > >>> variable).
> > > > > > >>>
> > > > > > >>> Since there doesn't seem to be a sane way to return the FD =
for
> > > > buffer0 to
> > > > > > >>> be the same FD for the /dev/iio:deviceX, this ioctl() will =
return
> > > > another
> > > > > > >>> FD for buffer0 (or the first buffer). This duplicate FD wil=
l be
> > > > able to
> > > > > > >>> access the same buffer object (for buffer0) as accessing
> > > > directly the
> > > > > > >>> /dev/iio:deviceX chardev.
> > > > > > >>>
> > > > > > >>> Also, there is no IIO_BUFFER_GET_BUFFER_COUNT ioctl()
> > > > implemented, as the
> > > > > > >>> index for each buffer (and the count) can be deduced from
> > > > the
> > > > > > >>> '/sys/bus/iio/devices/iio:deviceX/bufferY' folders (i.e the
> > > > number of
> > > > > > >>> bufferY folders).
> > > > > > >>>
> > > > > > >>> Used following C code to test this:
> > > > > > >>> -----------------------------------------------------------=
--------
> > > > > > >>>
> > > > > > >>>    #include <stdio.h>
> > > > > > >>>    #include <stdlib.h>
> > > > > > >>>    #include <unistd.h>
> > > > > > >>>    #include <sys/ioctl.h>
> > > > > > >>>    #include <fcntl.h"
> > > > > > >>>    #include <errno.h>
> > > > > > >>>
> > > > > > >>>    #define IIO_BUFFER_GET_FD_IOCTL      _IOWR('i', 0x91, in=
t)
> > > > > > >>>
> > > > > > >>> int main(int argc, char *argv[])
> > > > > > >>> {
> > > > > > >>>           int fd;
> > > > > > >>>           int fd1;
> > > > > > >>>           int ret;
> > > > > > >>>
> > > > > > >>>           if ((fd =3D open("/dev/iio:device0", O_RDWR))<0) =
{
> > > > > > >>>                   fprintf(stderr, "Error open() %d errno %d=
\n",fd,
> > > > errno);
> > > > > > >>>                   return -1;
> > > > > > >>>           }
> > > > > > >>>
> > > > > > >>>           fprintf(stderr, "Using FD %d\n", fd);
> > > > > > >>>
> > > > > > >>>           fd1 =3D atoi(argv[1]);
> > > > > > >>>
> > > > > > >>>           ret =3D ioctl(fd, IIO_BUFFER_GET_FD_IOCTL, &fd1);
> > > > > > >>>           if (ret < 0) {
> > > > > > >>>                   fprintf(stderr, "Error for buffer %d ioct=
l() %d errno
> > > > %d\n", fd1, ret, errno);
> > > > > > >>>                   close(fd);
> > > > > > >>>                   return -1;
> > > > > > >>>           }
> > > > > > >>>
> > > > > > >>>           fprintf(stderr, "Got FD %d\n", fd1);
> > > > > > >>>
> > > > > > >>>           close(fd1);
> > > > > > >>>           close(fd);
> > > > > > >>>
> > > > > > >>>           return 0;
> > > > > > >>> }
> > > > > > >>> -----------------------------------------------------------=
--------
> > > > > > >>>
> > > > > > >>> Results are:
> > > > > > >>> -----------------------------------------------------------=
--------
> > > > > > >>>    # ./test 0
> > > > > > >>>    Using FD 3
> > > > > > >>>    Got FD 4
> > > > > > >>>
> > > > > > >>>    # ./test 1
> > > > > > >>>    Using FD 3
> > > > > > >>>    Got FD 4
> > > > > > >>>
> > > > > > >>>    # ./test 2
> > > > > > >>>    Using FD 3
> > > > > > >>>    Got FD 4
> > > > > > >>>
> > > > > > >>>    # ./test 3
> > > > > > >>>    Using FD 3
> > > > > > >>>    Got FD 4
> > > > > > >>>
> > > > > > >>>    # ls /sys/bus/iio/devices/iio\:device0
> > > > > > >>>    buffer  buffer0  buffer1  buffer2  buffer3  dev
> > > > > > >>>    in_voltage_sampling_frequency  in_voltage_scale
> > > > > > >>>    in_voltage_scale_available
> > > > > > >>>    name  of_node  power  scan_elements  subsystem  uevent
> > > > > > >>> -----------------------------------------------------------=
--------
> > > > > > >>>
> > > > > > >>> iio:device0 has some fake kfifo buffers attached to an IIO
> > > > device.
> > > > > > >> For me there is one major problem with this approach. We onl=
y
> > > > allow one
> > > > > > >> application to open /dev/iio:deviceX at a time. This means w=
e
> > > > can't have
> > > > > > >> different applications access different buffers of the same
> > > > device. I
> > > > > > >> believe this is a circuital feature.
> > > > > > > Thats not quite true (I think - though I've not tested it).  =
What we
> > > > don't
> > > > > > > allow is for multiple processes to access them in an unaware
> > > > fashion.
> > > > > > > My assumption is we can rely on fork + fd passing via appropr=
iate
> > > > sockets.
> > > > > > >
> > > > > > >> It is possible to open the chardev, get the annonfd, close t=
he
> > > > chardev
> > > > > > >> and keep the annonfd open. Then the next application can do
> > > > the same and
> > > > > > >> get access to a different buffer. But this has room for race
> > > > conditions
> > > > > > >> when two applications try this at the very same time.
> > > > > > >>
> > > > > > >> We need to somehow address this.
> > > > > > > I'd count this as a bug :).  It could be safely done in a par=
ticular
> > > > custom
> > > > > > > system but in general it opens a can of worm.
> > > > > > >
> > > > > > >> I'm also not much of a fan of using ioctls to create annon f=
ds. In
> > > > part
> > > > > > >> because all the standard mechanisms for access control no
> > > > longer work.
> > > > > > > The inability to trivially have multiple processes open the a=
non
> > > > fds
> > > > > > > without care is one of the things I like most about them.
> > > > > > >
> > > > > > > IIO drivers and interfaces really aren't designed for multipl=
e
> > > > unaware
> > > > > > > processes to access them.  We don't have per process controls
> > > > for device
> > > > > > > wide sysfs attributes etc.  In general, it would be hard to
> > > > > > > do due to the complexity of modeling all the interactions
> > > > between the
> > > > > > > different interfaces (events / buffers / sysfs access) in a g=
eneric
> > > > fashion.
> > > > > > >
> > > > > > > As such, the model, in my head at least, is that we only want=
 a
> > > > single
> > > > > > > process to ever be responsible for access control.  That proc=
ess
> > > > can then
> > > > > > > assign access to children or via a deliberate action (I think=
 passing
> > > > the
> > > > > > > anon fd over a unix socket should work for example).  The int=
ent
> > > > being
> > > > > > > that it is also responsible for mediating access to infrastru=
cture
> > > > that
> > > > > > > multiple child processes all want to access.
> > > > > > >
> > > > > > > As such, having one chrdev isn't a disadvantage because only =
one
> > > > process
> > > > > > > should ever open it at a time.  This same process also handle=
s the
> > > > > > > resource / control mediation.  Therefore we should only have
> > > > one file
> > > > > > > exposed for all the standard access control mechanisms.
> > > > > > >
> > > > > > Hm, I see your point, but I'm not convinced.
> > > > > >
> > > > > > Having to have explicit synchronization makes it difficult to m=
ix and
> > > > > > match. E.g. at ADI a popular use case for testing was to run so=
me
> > > > signal
> > > > > > generator application on the TX buffer and some signal analyzer
> > > > > > application on the RX buffer.
> > > > > >
> > > > > > Both can be launched independently and there can be different
> > > > types of
> > > > > > generator and analyzer applications. Having to have a 3rd
> > > > application to
> > > > > > arbitrate access makes this quite cumbersome. And I'm afraid th=
at
> > > > in
> > > > > > reality people might just stick with the two devices model just=
 to
> > > > avoid
> > > > > > this restriction.
> > > > >
> > > > > I'd argue that's a problem best tackled in a library - though it'=
s a bit
> > > > > fiddly.  It ought to be possible to make it invisible that this l=
evel
> > > > > of sharing is going on.   The management process you describe wou=
ld
> > > > probably
> > > > > be a thread running inside the first process to try and access a =
given
> > > > device.
> > > > > A second process failing to open the file with -EBUSY then connec=
ts
> > > > to
> > > > > appropriate socket (via path in /tmp or similar) and asks for the=
 FD.
> > > > > There are race conditions that might make it fail, but a retry lo=
op
> > > > should
> > > > > deal with those.
> > > > >
> > > > > I agree people might just stick to a two device model and if the
> > > > devices
> > > > > are independent enough I'm not sure that is the wrong way to
> > > > approach the
> > > > > problem.  It represents the independence and that the driver is
> > > > being careful
> > > > > that it both can and is safely handle independent simultaneous
> > > > accessors.
> > > > > We are always going to have some drivers doing that anyway
> > > > because they've
> > > > > already been doing that for years.
> > > > >
> > > >
> > > > This is the last of the 3 patches that I need to re-spin after Lars=
' review.
> > > > I have a good handle on the small stuff.
> > > >
> > > > I'm not sure about the race-condition about which Lars was talking
> > > > about.
> > > > I mean, I get the problem, but is it a problem that we should fix i=
n the
> > > > kernel?
> > >
> > > Hi all,
> > >
> > > FWIW, I think that this really depends on the chosen ABI. If we do us=
e
> > > the ioctl to return the buffer fd and just allow one app to hold the =
chardev
> > > at a time, I agree with Alex that this is not really a race and is ju=
st something
> > > that userspace needs to deal with....
> > >
> > > That said and giving my superficial (I did not really read the full s=
eries) piece on this,
> > > I get both Lars and Jonathan points and, personally, it feels that th=
e most natural thing
> > > would be to have a chardev per buffer...
> > >
> > > On the other hand, AFAIC, events are also being handled in the same c=
hardev as
> > > buffers, which makes things harder in terms of consistency... Events =
are per device
> > > and not per buffers right? My point is that, to have a chardev per bu=
ffer, it would make
> > > sense to detach events from the buffer stuff and that seems to be not=
 doable without
> > > breaking ABI (we would probably need to assume that events and buffer=
0 are on the
> > > same chardev).
> >
> > Events are interesting as there is no particular reason to assume the d=
river
> > handling buffer0 is the right one to deal with them.  It might just as =
easily
> > be the case that they are of interest to a process that is concerned wi=
th buffer1.
> >
> > To add a bit more flavour to my earlier comments.
> >
> > I'm still concerned that if we did do multiple /dev/* files it would al=
low code
> > to think it has complete control over the device when it really doesn't=
.
> > Events are just one aspect of that.
> >
> > We have had discussions in the past about allowing multiple userspace c=
onsumers
> > for a single buffer, but the conclusion there was that was a job for us=
erspace
> > (daemon or similar) software which can deal with control inter dependen=
cies etc.
> >
> > There are already potential messy corners we don't handle for userspace
> > iio buffers vs in kernel users (what happens if they both try to contro=
l the
> > sampling frequency?)  I'm not keen to broaden this problem set.
> > If a device genuinely has separate control and pipelines for different
> > buffers then we are probably better representing that cleanly as
> > an mfd type layer and two separate IIO devices. Its effectively the
> > same a multi chip package.
> >
> > A more classic multibuffer usecase is the one where you have related
> > datastreams that run at different rates (often happens in devices with
> > tagged FIFO elements). These are tightly coupled but we need to split
> > the data stream (or add tagging to our FIFOs.). Another case would be
> > DMA based device that puts channels into buffers that are entirely
> > separate in memory address rather than interleaved.
> >
> > So I still need to put together a PoC, but it feels like there are vari=
ous
> > software models that will give the illusion of there being separate
> > /dev/* files, but with an aspect of control being possible.
> >
> > 1. Daemon, if present that can hand off chardevs to who needs them
> > 2. Library to make the first user of the buffer responsible for providi=
ng
> >    service to other users.  Yes there are races, but I don't think they
> >    are hard to deal in normal usecases.  (retry loops)
>
> Hi Nuno / Others,
>
> Nuno's mention of things being similar for the event anon
> FD to the situation for the buffer anon FDs made me realise there was
> a horrible short cut to a proof of concept that didn't require me
> to wire up a multiple buffer device.
>
> Upshot, is that I've just sent out a (definitely not for merging)
> hacked up version of the iio_event_monitor that can act as server
> or client.  The idea is that the socket handling looks a bit
> like what I'd expect to see hidden away in a library so as to
> allow
>
> 1) Client 1 is after buffer 3.
>    It tries to open the /dev/iio\:deviceX chrdev and succeeds.
>    It spins up a thread with a listening socket for /tmp/iio\:deviceX-mag=
ic
>    Continues in main thread to request buffer 3.
> 2) Client 2 is after buffer 2
>    I tries to open the /dev/iio\:deviceX chrdev and fails.
>    It sleeps a moment (reduces chance of race with client 1)
>    It opens a connection to the socket via /tmp/iio\:deviceX-magic
>    Sends a request for the buffer 2 FD.
>    Thread in Client 1 calls the ioctl to get the buffer 2 FD which
>    it then sends on to Client 2 which can use it as if it had
>    requested it directly.
>
> We might want to have a generic server version as well that doesn't
> itself make use of any of the buffers as keeps the model more symmetric
> and reduce common corner cases.
>
> Anyhow the code I put together is terrible, but I wasn't 100% sure
> there weren't any issues passing anon fd file handles and this shows
> that at least in theory the approach I proposed above works.
>
> Test is something like
> ./iio_events_network /dev/iio\:device1
> ./iio_events_network -c
>
> Then make some events happen (I was using the dummy driver and
> the event generator associated with that).
> The server in this PoC just quits after handling off the FD.

The whole code looks good functionally.
If there are any race issues [as discussed here], they can be handled
in the server code.
And if this is the model we try to enforce/propose in userspace, then
all should be fine.


Continuing a bit with the original IIO buffer ioctl(), I talked to
Lars a bit over IRC.
And there was an idea/suggestion to maybe use a struct to pass more
information to the buffer FD.

So, right now the ioctl() just returns an FD.
Would it be worth to extend this to a struct?
What I'm worried about is that it opens the discussion to add more
stuff to that struct.

so now, it would be:

struct iio_buffer_ioctl_data {
            __u32 fd;
            __u32 flags;   // flags for the new FD, which maybe we
could also pass via fcntl()
}

anything else that we would need?

>
> Jonathan
>
> >
> > Jonathan
> >
> >
> > >
> > > - Nuno S=C3=A1
> >
>
