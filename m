Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938673CD54D
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 14:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhGSMTD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 08:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbhGSMTD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 08:19:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412B1C061574;
        Mon, 19 Jul 2021 05:18:36 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso11361748pjx.1;
        Mon, 19 Jul 2021 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=w+hwueRqTUCjaFujfVdoRLdn7shROrp5/7MNNeywa2w=;
        b=iKAXaqJVoph4Wnx3nnZvXOYM8K9BpD+t4+MCSaNNMXRBfUFfP9JdpU9xW/PBGsQRy+
         i477Cky90DiGCmCpeSP/JoCELpAgTZPGeDBTbip4UrPHCzeki10Rt8l+kC5smZBdp0V6
         ZlVaINVfoer26+JpB375fwtDUu/1g1Tbe9VXgxv+5R6wbJJYuip1c715msy6/P7g1jEi
         +eOvDZ0ynq+APTjZEDG0Wv/3Z3XW9FpXlj9S4YI83p8a3QyHq+qvC0MzFJ05Ep6pCbd4
         maPGfgQ6JkCt9yh/FleZkmvq+qCsbFFxnMBWjm6YDxrnaqC9snVmV9ywhWRCIKr9upzC
         +f4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=w+hwueRqTUCjaFujfVdoRLdn7shROrp5/7MNNeywa2w=;
        b=gPfeq6Gnp/+McHrcHlvo/bvvWn2gnpf8MXYQFUKkW450P6p9zUw9x2BiDoVTc/E8F2
         YH7oCD2nyTOYaFBvBG7fbgXwy16PHkCel+GsQQPkBde1BHOsLdWAZIad+q/RX5vmx9BO
         iO/gQymivhylyyykNBwj4zhCIQDcffn2wrVwL7CZMdU7TK3A3Rg0euDh45K+yArhmcq8
         ZP9VQ/BvxJlRWL/LYz53DYc4YTvbIzApqYDgoh9KFc/HZ9sMKMyfflpL+S0suzIP0Wf4
         /DiiMG08v9w2L7B4FgJy70aRDg4hBZOAP3moZPVIEQzHc+EAuwXl9QrO13oPPE/M9I8m
         4GPg==
X-Gm-Message-State: AOAM530YuKvY7mwmZM6st9NGMLtkI247X75iwnEzP0j72sw65X0+1wyD
        6zFeDZTSSObF1UPrPh96d6SVnLmys91kP1x8r9I=
X-Google-Smtp-Source: ABdhPJyQMLeSewBNVKT1ExCATgS3p/vjjUQ0LVyLQcSQEAjorg53/92Fe//epKG/hMKAdpArQyY+7aqZHyxKUXQQKPU=
X-Received: by 2002:a17:90a:880c:: with SMTP id s12mr24703016pjn.72.1626699581617;
 Mon, 19 Jul 2021 05:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20210715141742.15072-5-andrea.merello@gmail.com> <20210717165018.50a26629@jic23-huawei>
 <CAN8YU5M4+ZFNzLkGhP1w7Q80yKVBxAXqK=k6qYzpTYXj=+707w@mail.gmail.com> <YPVoTp3SPzL6LQ6X@smile.fi.intel.com>
In-Reply-To: <YPVoTp3SPzL6LQ6X@smile.fi.intel.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 19 Jul 2021 14:59:30 +0200
Message-ID: <CAN8YU5N9mktrxT6Tv67m=nh_Cnw0SYBq+bf5kUzpoWUAToJm+Q@mail.gmail.com>
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

Il giorno lun 19 lug 2021 alle ore 13:56 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> ha scritto:
>
> On Mon, Jul 19, 2021 at 10:49:54AM +0200, Andrea Merello wrote:
> > Il giorno sab 17 lug 2021 alle ore 17:48 Jonathan Cameron
> > <jic23@kernel.org> ha scritto:
> > > On Thu, 15 Jul 2021 16:17:42 +0200
> > > Andrea Merello <andrea.merello@gmail.com> wrote:
>
> ...
>
> > > > +/*
> > > > + * Register writes cmd have the following format
> > > > + * +------+------+-----+-----+----- ... ----+
> > > > + * | 0xAA | 0xOO | REG | LEN | payload[LEN] |
> > > > + * +------+------+-----+-----+----- ... ----+
> > > > + *
> > > > + * Register write responses have the following format
> > > > + * +------+----------+
> > > > + * | 0xEE | ERROCODE |
> > > > + * +------+----------+
> > > > + *
> > > > + * Register read have the following format
> > > > + * +------+------+-----+-----+
> > > > + * | 0xAA | 0xO1 | REG | LEN |
> > > > + * +------+------+-----+-----+
> > > > + *
> > > > + * Successful register read response have the following format
> > > > + * +------+-----+----- ... ----+
> > > > + * | 0xBB | LEN | payload[LEN] |
> > > > + * +------+-----+----- ... ----+
> > > > + *
> > > > + * Failed register read response have the following format
> > > > + * +------+--------+
> > > > + * | 0xEE | ERRCODE|  (ERRCODE always > 1)
> > > > + * +------+--------+
> > > > + *
> > > > + * Error codes are
> > > > + * 01: OK
> > > > + * 02: read/write FAIL
> > > > + * 04: invalid address
> > > > + * 05: write on RO
> > > > + * 06: wrong start byte
> > > > + * 07: bus overrun
> > > > + * 08: len too high
> > > > + * 09: len too low
> > > > + * 10: bus RX byte timeout (timeout is 30mS)
> > > > + *
> > > > + *
> > > > + * **WORKAROUND ALERT**
> > > > + *
> > > > + * Serial communication seems very fragile: the BNO055 buffer seems to overflow
> > > > + * very easy; BNO055 seems able to sink few bytes, then it needs a brief pause.
> > > > + * On the other hand, it is also picky on timeout: if there is a pause > 30mS in
> > > > + * between two bytes then the transaction fails (IMU internal RX FSM resets).
> > > > + *
> > > > + * BMU055 has been seen also failing to process commands in case we send them
> > > > + * too close each other (or if it is somehow busy?)
> > > > + *
> > > > + * One idea would be to split data in chunks, and then wait 1-2mS between
> > > > + * chunks (we hope not to exceed 30mS delay for any reason - which should
> > > > + * be pretty a lot of time for us), and eventually retry in case the BNO055
> > > > + * gets upset for any reason. This seems to work in avoiding the overflow
> > > > + * errors, but indeed it seems slower than just perform a retry when an overflow
> > > > + * error occur.
> > > > + * In particular I saw these scenarios:
> > > > + * 1) If we send 2 bytes per time, then the IMU never(?) overflows.
> > > > + * 2) If we send 4 bytes per time (i.e. the full header), then the IMU could
> > > > + *    overflow, but it seem to sink all 4 bytes, then it returns error.
> > > > + * 3) If we send more than 4 bytes, the IMU could overflow, and I saw it sending
> > > > + *    error after 4 bytes are sent; we have troubles in synchronizing again,
> > > > + *    because we are still sending data, and the IMU interprets it as the 1st
> > > > + *    byte of a new command.
> > > > + *
> > > > + * So, we workaround all this in the following way:
> > > > + * In case of read we don't split the header but we rely on retries; This seems
> > > > + * convenient for data read (where we TX only the hdr).
> > > > + * For TX we split the transmission in 2-bytes chunks so that, we should not
> > > > + * only avoid case 2 (which is still manageable), but we also hopefully avoid
> > > > + * case 3, that would be by far worse.
> > >
> > > Nice docs and this sounds terrible!
> >
> > Indeed.. If anyone has nicer ideas, or is aware about better
> > workaround, I would really love to know...
>
> This needs somebody to go thru data sheet and check for possibilities, what you
> described above is not gonna fly. Okay, "in a robust way".
>
> I can't believe there is nothing in the communication protocol that may
> increase a robustness.

The serial protocol is both described in the datasheet and in an
application note "BNO055UART interface". Both of them mention the fact
that  the IMU could just fail in processing the commands and responds
with a status message with the "overflow" error code. The application
note says this can happen because of an internal IMU buffer clearing
stuff not happening in time, and that you have to retry the command in
such case (which works for read commands, because after the header the
IMU will always respond with something).

They say nothing about the fact that the IMU could decide to respond
with an "overflow" status message when a write command is still being
TXed, even if it is not finished yet, but this actually happens (seen
at least after the 4-bytes header).

I think there is not much other information about this in datasheet
and application note. Besides, the message formats are also described
the comments in bno055_sl.c

Given that the IMU behaves like this, I could only see three possible
workarounds for managing write commands:
1 - be quick enough on RX side in catching the IMU overflow status
response before sending the next char, which seems unfeasible.
2 - be slow enough to let the IMU do its own stuff, which seems doable.
3 - let the mess happen and try to recover: when we get the IMU
overflow error then we might still being TXing; in this case we stop
and we wait for the IMU to complain for a malformed command, but I'm
unsure how the IMU could handle this: it will refuse the wrong
starting byte (unless our payload is 0xAA by chance), but then how
many bytes does it throw away? How may (malformed) commands would it
try to extract from a the garbage we TXed (how may complaints response
would we receive and need to wait) ? And what if there is something in
payload that resembles a valid command and got accepted? This seems
worse than workaround #2

What I meant: given this IMU behaviour, if someone has a better idea
about how to deal with it, I would listen :)

> > > > + */
>
> ...
>
> > > > +/* Read operation overhead:
> > > > + * 4 bytes req + 2byte resp hdr
> > > > + * 6 bytes = 60 bit (considering 1start + 1stop bits).
> > > > + * 60/115200 = ~520uS
> > > > + * In 520uS we could read back about 34 bytes that means 3 samples, this means
> > > > + * that in case of scattered read in which the gap is 3 samples or less it is
> > > > + * still convenient to go for a burst.
> > > > + * We have to take into account also IMU response time - IMU seems to be often
> > > > + * reasonably quick to respond, but sometimes it seems to be in some "critical
> > > > + * section" in which it delays handling of serial protocol.
> > > > + * By experiment, it seems convenient to burst up to about 5/6-samples-long gap
>
> Missed perial and entire comment needs proper style and space occupation ratio.

Perial? But OK: text reflow and I see the 1st line for multilne
commend is not correct.

> > > > + */
>
> ...
>
> > > > +     enum {
> > > > +             STATUS_OK = 0,  /* command OK */
> > > > +             STATUS_FAIL = 1,/* IMU communicated an error */
> > > > +             STATUS_CRIT = -1/* serial communication with IMU failed */
>
> enum may be kernel doc described.

OK

> > > > +     } cmd_status;
>
> ...
>
> > > > +static struct serdev_device_driver bno055_sl_driver = {
> > > > +     .driver = {
>
> > > > +             .name = BNO055_SL_DRIVER_NAME,
>
> This is (semi-)ABI and preferably should be hard coded explicitly.

OK

> > > > +             .of_match_table = bno055_sl_of_match,
> > > > +     },
> > > > +     .probe = bno055_sl_probe,
> > > > +};
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
