Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26D13DB527
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jul 2021 10:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhG3IpK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jul 2021 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhG3IpK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jul 2021 04:45:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9120C061765
        for <linux-iio@vger.kernel.org>; Fri, 30 Jul 2021 01:45:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b6so14144102pji.4
        for <linux-iio@vger.kernel.org>; Fri, 30 Jul 2021 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M0Pd/6e/ayI/Ykwy3iGuE3HpnEx3t7F74jKrEx7HaTs=;
        b=ngjTYOOc+OboeaxzPDUtzx8ye7XJ280Zg6DGaNFQ6lK9idOvszX/jhwynddwSGOyh9
         n6FFWOxH31CnrkiABlQYupjXTGHdWMFiqj2TZ/abyJBqWFIocBl1sacXsCgC5FJ5Zf43
         vtNJnGC8Nat0q0eSELlcvbCF7vpaDc0YWrUPkWYYKODPnewp87WShn56CGhl2CnzV9V3
         RLBRoTjJCbhZabxWp+I2VzfnxJnT17y/i/n7KQIO+PpXWQHpE5tmKTGliOWgh/51JBti
         qlENeHoLHipMMNJJRwiN1W2xamjcO4qJSgqWEHr5QIJf9+dI8cWCykKrzGv39/yRqvGf
         1hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M0Pd/6e/ayI/Ykwy3iGuE3HpnEx3t7F74jKrEx7HaTs=;
        b=Udd8TL7hsP9/7aUMDeTp9xWH0qh+7Rsom4hDqh+SMaEPnr7QGrboYQq3LLCb+yjwJ3
         +VWBDd24K/ZPFCk6XE2ew4txR+J4umoQsn17KaLhP2ymjz2waCXMglHvxwVLtDBHZ/x/
         XRqM65C4mKSPuCWXj6K95H/Gu5LcO3hznpFR3r6QG9x153kAKuOO/EthS76gIuAsnZx3
         IrwDZSzq8Pg0BOcxFrIQ1Q7R8M9jKQggkslYOmbdg0bmedUrZuIZHgcVqTEaGSZsCFGr
         BZwj1jOf/w/xqOWv6ZRoZ7fQDSAfdCg58wcYi8akkOgOC72onSWcDcqmioescnrJl3De
         GJOQ==
X-Gm-Message-State: AOAM532zNBFaQ7VdHT4X0/XzZNPLBeP60YMwYIpWOjoF/UvbftPzj95K
        lqChWclQuMOEHvkckS833uhwVRRZlema9VeeyQ4=
X-Google-Smtp-Source: ABdhPJyb8dDRpkScBmtDzmJA1mPPiJ5wzbSfxvYqqX0IvCzydXBhCX8yy2fyBFh+dQCZiGuan3yoovOjHU0TPB1BtrY=
X-Received: by 2002:a17:90a:d250:: with SMTP id o16mr1982861pjw.181.1627634704329;
 Fri, 30 Jul 2021 01:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <2B7BAE11-FF1D-4A3C-9E00-E3ACD280D66E@patricknet.net>
 <CA+U=DsroXD3v85COsvXqB5xkVYTzayuEb-gWWF=-45+MhJyUfA@mail.gmail.com> <20210730090328.Horde.UFBzdgjVdntkW8Y7kU-s71p@www.patricknet.net>
In-Reply-To: <20210730090328.Horde.UFBzdgjVdntkW8Y7kU-s71p@www.patricknet.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 30 Jul 2021 11:44:53 +0300
Message-ID: <CA+U=DsoVoTAodAYPKbpshHx3B3u5Cdeg0UJCumVOKO4YQLXCJg@mail.gmail.com>
Subject: Re: IRQ related query
To:     Patrick Regnouf <patrick@patricknet.net>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 30, 2021 at 11:03 AM <patrick@patricknet.net> wrote:
>
> Alex,
>
> Thank you so very much for your help, I browsed most of that
> litterature already and the kernel side of it is very much covered,
> understood and assimilated.
>
> However my question is basically: How can I be alerted, for example
> through a callback function, when an interruption occurs in the kernel
> space and my daemon lives in userspace.
>
> IRQ Occuring -------> Upper half of the interrupt(put the timestamp in
> the buffer) ---------> Lower half of the interrupt handler (read data
> and adds the timestamp in the buffer) -----------> ???? userspace
> daemon (async callback of some description) that will write a log on
> the HD.
>
> I have everything up to the daemon part written and working, I seem to
> understand that through libiio you can assign a trigger to a
> particular channel or attribute but that is where I get stuck.
>
> Litterature on the libiio (most notably its wiki) has a chapter on
> triggers that is 4 lines long ... not very helpful to say the least.
>
> iioinfo lists the devices present in the LSM6DSLTR (18 devices
> including two triggers) and I have been unable to assign the triggers
> to any device that they are not assigned to already (No such file or
> directory) which I gather refer to the absence of the trigger
> directory in the sysfs for that  particular device.
>
> I also gather that the sysfs directory is, of course, slave to the
> kernel device tree and that the creation of that part of the device
> tree is made as the driver is loaded.
>
> So there must be a way to alter that part of the sysfs filesystem by
> asking the kernel driver to provision a device in the context to
> implement the trigger directory so we can assign a trigger to it
>
> second part will be to slave that trigger to an actual IRQ (42 in my
> case - as listed in /proc/interrupts) and be alerted in the  userspace
> daemon when a thresold has been reached in terms of either
> acceleration or vibration ...
>
> Well, this is the nuts and bolts of what I am trying to achieve. the
> last part will be to write a few registers on the chip to configure
> how and when IRQ will occur for any given integrated devices.
>
> Sorry to be such a pain but I thnk my problem lies in the passage of
> information from kernel space (very well documented) to the userspace
> (could not find reasonable documention and/or C code examples on how
> to achieve this)
>
> Thnks again
>
> /Patrick
>
>
>
>
>
>
>
>
>
> Quoting Alexandru Ardelean <ardeleanalex@gmail.com>:
>
> > On Thu, Jul 29, 2021 at 3:54 PM Patrick Regnouf
> > <patrick@patricknet.net> wrote:
> >>
> >> Hello,
> >>
> >
> > [I did not hit Reply All on my first email]
> >
> > Hey,
> >
> > For libiio in particular, it's on Github:
> > https://github.com/analogdevicesinc/libiio
> >
> > I think you could raise some questions as issues there.
> >
> > And there's also a wiki that can be browsed:
> > https://wiki.analog.com/resources/tools-software/linux-software/libiio
> > https://wiki.analog.com/resources/tools-software/linux-software/libiio_=
internals
> >
> > Now, regarding IIO events support in libiio, I am not sure [at point
> > in time] whether support is implemented.
> >
> > But an example of getting events from IIO can be found here:
> > https://github.com/torvalds/linux/blob/master/tools/iio/iio_event_monit=
or.c
> >
> > The https://github.com/torvalds/linux/blob/master/tools/iio/  folder
> > in the kernel should offer some basic bits about accessing IIO
> > devices, and getting events [which can be driver IRQ events, or kernel
> > IIO polling]
> >
> > I was going to answer on the previous question that you raised, but I f=
orgot.
> > Apologies. It's been a busy week.

Wait, I'm confusing/mixing triggers and events [in my head].
Apologies. I'm still processing the coffee I ingested 1-2h ago.

libiio supports triggers. But not events.

However, the driver for LSM6DSLTR (i.e. the one here
drivers/iio/imu/st_lsm6dsx) doesn't register any IIO triggers.
So, there's nothing for libiio [or any userspace tool] to hook into
for triggers.

There's an IRQ handler and IRQ thread-handler, but nothing to link
these to IIO framework triggers.
This needs to be implemented in the driver.
An example of how IIO kernel triggers should be implemented in the
driver is in drivers/iio/accel/adxl372.c and drivers/iio/imu/adis***
drivers.

> >
> > Alex
> >
> >> Please someone tell me whether this is the right mailing list to
> >> ask questions related to actually using libiio or actually please
> >> point me in the right direction
> >>
> >> To summarise I am looking for C source code that would capture an
> >> IRQ emitted by an iio accelerometer (LSM6DSLTR) all of that using
> >> libiio
> >>
> >> I have successfully implemented a program that can read the x, y
> >> and z axis but that means polling constantly. Not an option=E2=80=A6  =
the
> >> iio_device_set_trigger however returns =E2=80=9Cno such file or direct=
ory =E2=80=9C
> >>
> >> Thanks
> >>
> >> /Patrick
>
>
>
