Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D727A3CDC3E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 17:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243241AbhGSOvt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 10:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245715AbhGSOsK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 10:48:10 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1C3C0A88D8;
        Mon, 19 Jul 2021 07:37:20 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t9so19279886pgn.4;
        Mon, 19 Jul 2021 08:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=PLz8EifVbvuejdzmJtsQlC2LwyXKUj5bie8PKGDaTRI=;
        b=jFsUyKV2K1wTAVQBwzOydhwnvr5v1uXUAbXf7lj0+73sUmJG2OY7dy7iY1e5AZoWPZ
         EmrYy+z0vQ0Vexjx6kuIL/AnQYOqGkRZtWqvmf/5LiU2HyH6DojT5JvNp8yyuk/iNLnO
         6TAsHW8eHnJybfid2ZntyENRYePoSu62r2GZv1brZAlLr97VQIpTpgzwVnB4njuEzRGk
         q5FJWy25snuwWntywi028USXiqYd9ZCLEaGkT11OU6Vup3T0SzJzoPzeqWSr27iueX9C
         N05kTuCXMn8D34FFgOCBJ4ngg9vPrRhgy+TdrZEIqp6fh78tLB+EwEw5Q7KVKUcFsuG3
         IN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=PLz8EifVbvuejdzmJtsQlC2LwyXKUj5bie8PKGDaTRI=;
        b=mbYZr53wgHbzvM2SysuhFRKOsD1aOnMIXuhpEojOFPP2JzkdIq1q+SBah/gy4Vb+HB
         nPCctuRnOEjdFZYfbXYeZJPplCfmO5FnqgnZstuI6AVybmE0SKKL5RugxxydezNVKmAs
         9aRkR6sXJdl/fEcyqoxcvL4u6fgEaYjyOIZaogqkkfO3pGZoDKyh2D8Seccx1qze0tVb
         JLLYr7GfiD8I+ThXAnYQug+8SN8b0Nd8GyGKLKjpOJAjFWRmbB4KyCBJaMsZ/gWByY5N
         Yk1ZJyMfkP0CyPdHGkxvc52rsla8nviaG7EqDDHwKKj6Xl6Y62NX7oUpqnI7EPmyzYqD
         dXvA==
X-Gm-Message-State: AOAM531IRJpl5YS0NquO+IJhuz3ZIZsstQY2vbwm6Mwi/cGuo9761nyh
        86Onf49ihhr+8Mp/qqZvMFpTSf+Wp0PY6FmNfw0=
X-Google-Smtp-Source: ABdhPJyo3jAOtys4kUeLLoWI1SOGRPb6q7moE1eOOLTCdJixkva3z5EXqAGjT43Rcr0oGuQAsbj87xDie8SXDULpAvA=
X-Received: by 2002:a63:ae48:: with SMTP id e8mr4831838pgp.0.1626707265611;
 Mon, 19 Jul 2021 08:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20210715141742.15072-5-andrea.merello@gmail.com> <20210717165018.50a26629@jic23-huawei>
 <CAN8YU5M4+ZFNzLkGhP1w7Q80yKVBxAXqK=k6qYzpTYXj=+707w@mail.gmail.com>
 <YPVoTp3SPzL6LQ6X@smile.fi.intel.com> <CAN8YU5N9mktrxT6Tv67m=nh_Cnw0SYBq+bf5kUzpoWUAToJm+Q@mail.gmail.com>
 <YPWJCE55q04bUEuA@smile.fi.intel.com>
In-Reply-To: <YPWJCE55q04bUEuA@smile.fi.intel.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 19 Jul 2021 17:07:34 +0200
Message-ID: <CAN8YU5P5XwdviNsh-rAHwx-Ay3nKoUZtcwc-At+PUpt4UKPReQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: imu: add BNO055 serdev driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno lun 19 lug 2021 alle ore 16:15 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> ha scritto:
>
> On Mon, Jul 19, 2021 at 02:59:30PM +0200, Andrea Merello wrote:
> > Il giorno lun 19 lug 2021 alle ore 13:56 Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> ha scritto:
> > >
> > > On Mon, Jul 19, 2021 at 10:49:54AM +0200, Andrea Merello wrote:
> > > > Il giorno sab 17 lug 2021 alle ore 17:48 Jonathan Cameron
> > > > <jic23@kernel.org> ha scritto:
> > > > > On Thu, 15 Jul 2021 16:17:42 +0200
> > > > > Andrea Merello <andrea.merello@gmail.com> wrote:
>
> ...
>
> > > > > > +/*
> > > > > > + * Register writes cmd have the following format
> > > > > > + * +------+------+-----+-----+----- ... ----+
> > > > > > + * | 0xAA | 0xOO | REG | LEN | payload[LEN] |
> > > > > > + * +------+------+-----+-----+----- ... ----+
> > > > > > + *
> > > > > > + * Register write responses have the following format
> > > > > > + * +------+----------+
> > > > > > + * | 0xEE | ERROCODE |
> > > > > > + * +------+----------+
> > > > > > + *
> > > > > > + * Register read have the following format
> > > > > > + * +------+------+-----+-----+
> > > > > > + * | 0xAA | 0xO1 | REG | LEN |
> > > > > > + * +------+------+-----+-----+
> > > > > > + *
> > > > > > + * Successful register read response have the following format
> > > > > > + * +------+-----+----- ... ----+
> > > > > > + * | 0xBB | LEN | payload[LEN] |
> > > > > > + * +------+-----+----- ... ----+
> > > > > > + *
> > > > > > + * Failed register read response have the following format
> > > > > > + * +------+--------+
> > > > > > + * | 0xEE | ERRCODE|  (ERRCODE always > 1)
> > > > > > + * +------+--------+
> > > > > > + *
> > > > > > + * Error codes are
> > > > > > + * 01: OK
> > > > > > + * 02: read/write FAIL
> > > > > > + * 04: invalid address
> > > > > > + * 05: write on RO
> > > > > > + * 06: wrong start byte
> > > > > > + * 07: bus overrun
> > > > > > + * 08: len too high
> > > > > > + * 09: len too low
> > > > > > + * 10: bus RX byte timeout (timeout is 30mS)
> > > > > > + *
> > > > > > + *
> > > > > > + * **WORKAROUND ALERT**
> > > > > > + *
> > > > > > + * Serial communication seems very fragile: the BNO055 buffer seems to overflow
> > > > > > + * very easy; BNO055 seems able to sink few bytes, then it needs a brief pause.
> > > > > > + * On the other hand, it is also picky on timeout: if there is a pause > 30mS in
> > > > > > + * between two bytes then the transaction fails (IMU internal RX FSM resets).
> > > > > > + *
> > > > > > + * BMU055 has been seen also failing to process commands in case we send them
> > > > > > + * too close each other (or if it is somehow busy?)
> > > > > > + *
> > > > > > + * One idea would be to split data in chunks, and then wait 1-2mS between
> > > > > > + * chunks (we hope not to exceed 30mS delay for any reason - which should
> > > > > > + * be pretty a lot of time for us), and eventually retry in case the BNO055
> > > > > > + * gets upset for any reason. This seems to work in avoiding the overflow
> > > > > > + * errors, but indeed it seems slower than just perform a retry when an overflow
> > > > > > + * error occur.
> > > > > > + * In particular I saw these scenarios:
> > > > > > + * 1) If we send 2 bytes per time, then the IMU never(?) overflows.
> > > > > > + * 2) If we send 4 bytes per time (i.e. the full header), then the IMU could
> > > > > > + *    overflow, but it seem to sink all 4 bytes, then it returns error.
> > > > > > + * 3) If we send more than 4 bytes, the IMU could overflow, and I saw it sending
> > > > > > + *    error after 4 bytes are sent; we have troubles in synchronizing again,
> > > > > > + *    because we are still sending data, and the IMU interprets it as the 1st
> > > > > > + *    byte of a new command.
> > > > > > + *
> > > > > > + * So, we workaround all this in the following way:
> > > > > > + * In case of read we don't split the header but we rely on retries; This seems
> > > > > > + * convenient for data read (where we TX only the hdr).
> > > > > > + * For TX we split the transmission in 2-bytes chunks so that, we should not
> > > > > > + * only avoid case 2 (which is still manageable), but we also hopefully avoid
> > > > > > + * case 3, that would be by far worse.
> > > > >
> > > > > Nice docs and this sounds terrible!
> > > >
> > > > Indeed.. If anyone has nicer ideas, or is aware about better
> > > > workaround, I would really love to know...
> > >
> > > This needs somebody to go thru data sheet and check for possibilities, what you
> > > described above is not gonna fly. Okay, "in a robust way".
> > >
> > > I can't believe there is nothing in the communication protocol that may
> > > increase a robustness.
> >
> > The serial protocol is both described in the datasheet and in an
> > application note "BNO055UART interface". Both of them mention the fact
> > that  the IMU could just fail in processing the commands and responds
> > with a status message with the "overflow" error code. The application
> > note says this can happen because of an internal IMU buffer clearing
> > stuff not happening in time, and that you have to retry the command in
> > such case (which works for read commands, because after the header the
> > IMU will always respond with something).
> >
> > They say nothing about the fact that the IMU could decide to respond
> > with an "overflow" status message when a write command is still being
> > TXed, even if it is not finished yet, but this actually happens (seen
> > at least after the 4-bytes header).
>
> (1)
>
> >
> > I think there is not much other information about this in datasheet
> > and application note. Besides, the message formats are also described
> > the comments in bno055_sl.c
> >
> > Given that the IMU behaves like this, I could only see three possible
> > workarounds for managing write commands:
> > 1 - be quick enough on RX side in catching the IMU overflow status
> > response before sending the next char, which seems unfeasible.
> > 2 - be slow enough to let the IMU do its own stuff, which seems doable.
> > 3 - let the mess happen and try to recover: when we get the IMU
> > overflow error then we might still being TXing; in this case we stop
> > and we wait for the IMU to complain for a malformed command, but I'm
> > unsure how the IMU could handle this: it will refuse the wrong
> > starting byte (unless our payload is 0xAA by chance), but then how
> > many bytes does it throw away? How may (malformed) commands would it
> > try to extract from a the garbage we TXed (how may complaints response
> > would we receive and need to wait) ? And what if there is something in
> > payload that resembles a valid command and got accepted? This seems
> > worse than workaround #2
>
> I believe the #3 is the right thing to do actually.
>
> The payload is up to 128 bytes and speed is fixed. I believe that firmware has
> internally the state of the input processing. OTOH the UART is duplex and what
> you need in the driver is to have a callback that will read whatever the answer
> from the sensor will be at the time it appears.

I can add a reader thread that always process IMU data, but I doubt we
can make assumptions on the fact it will be triggered in time to avoid
to TX extra characters after IMU signals an overflow; this seems
really a RT stuff, and it would even depends by the USART HW (think
about USB-UART adaptors).

So, how could we implement #3 dealing correctly with the issue about
the IMU possiblly misinterpreting the bytes we might have already sent
out? What's if they are a valid command by chance? The problem here is
that this protocol has no any CRC or something like that to make sure
garbage is really thrown away.

> Also note that Linux is not an RTOS and you may end up, maybe rarely, in the
> case which resembles the #3 while using workaround #2.

Yes, in case we sleep more than 30mS we fail. I would say it's very
unlikely, but that's true.

Maybe if I add a reader thread to the workaround #2, considering we
sleep every two bytes, then we can know about IMU errors - maybe still
not before TXing any further data - but before we TX the bare minimum
data amount in order to produce an unintentionally valid write command
(should be 5 bytes).

Anyway it seems to me that there is no perfectly robust way to deal
with this IMU.. But, in real word scenarios, workaround #2 seem to
work well enough.

> On top of that you demolish the idea of using DMA with UART.

True, but we really have no rush for write commands, so that it
shouldn't be an issue indeed - and apart for the few bytes of the
calibration data, that we might discuss about, all other writes are so
short that DMA has probably no real advantage (OTOH read command
doesn't have any extra sleep, so we are fine with reading the IMU
measures).

> (Btw, AN012 [1] says 100ms is the write timeout for the next byte,
>  and not 30ms.)

Yes: there is an inconsistency here: the datasheet says 30mS, the AN
says 100mS. We should then consider not to exceed 30mS.

> As AN012 rightfully pointed out the UART is _async_ interface, so I believe (1)
> is covered by this, meaning that error respond may appear _at any time_ on the
> (host-side) Rx line.

Ah, that is an interesting interpretation :)

> My personal take away is never ever use UART for this kind (*) of
> communications and this sensor specifically.

Consider that this kind of devices are position dependant, e.g. you
want to fix them on your arms, or on your robot feet, etc. I2C is
electrically unsuitable for long off-board wires, while serial lines
should be by far better in this case.

> *) time-based IPCs are doomed by definition in non-RTOS environments with UART
>    hardware interface.

We have to live with this :/ But indeed having sensors that measure
real-world physical phenomena probably are a bit RT-ish anyway..

> [1]: BST-BNO055-AN012-00 | Revision 1.0 | June 2015
>
> > What I meant: given this IMU behaviour, if someone has a better idea
> > about how to deal with it, I would listen :)
> >
> > > > > > + */
>
> ...
>
> > > > > > +/* Read operation overhead:
> > > > > > + * 4 bytes req + 2byte resp hdr
> > > > > > + * 6 bytes = 60 bit (considering 1start + 1stop bits).
> > > > > > + * 60/115200 = ~520uS
> > > > > > + * In 520uS we could read back about 34 bytes that means 3 samples, this means
> > > > > > + * that in case of scattered read in which the gap is 3 samples or less it is
> > > > > > + * still convenient to go for a burst.
> > > > > > + * We have to take into account also IMU response time - IMU seems to be often
> > > > > > + * reasonably quick to respond, but sometimes it seems to be in some "critical
> > > > > > + * section" in which it delays handling of serial protocol.
> > > > > > + * By experiment, it seems convenient to burst up to about 5/6-samples-long gap
> > >
> > > Missed perial and entire comment needs proper style and space occupation ratio.
> >
> > Perial? But OK: text reflow and I see the 1st line for multilne
>
> Period.

Ah, OK :)

> > commend is not correct.
> >
> > > > > > + */
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
