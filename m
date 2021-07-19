Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BDA3CD65E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 16:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239985AbhGSNfG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 09:35:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:43438 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239523AbhGSNfG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Jul 2021 09:35:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="198263971"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="198263971"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 07:15:45 -0700
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="495812070"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 07:15:43 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m5U3U-00FXxJ-T8; Mon, 19 Jul 2021 17:15:36 +0300
Date:   Mon, 19 Jul 2021 17:15:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [PATCH 4/4] iio: imu: add BNO055 serdev driver
Message-ID: <YPWJCE55q04bUEuA@smile.fi.intel.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20210715141742.15072-5-andrea.merello@gmail.com>
 <20210717165018.50a26629@jic23-huawei>
 <CAN8YU5M4+ZFNzLkGhP1w7Q80yKVBxAXqK=k6qYzpTYXj=+707w@mail.gmail.com>
 <YPVoTp3SPzL6LQ6X@smile.fi.intel.com>
 <CAN8YU5N9mktrxT6Tv67m=nh_Cnw0SYBq+bf5kUzpoWUAToJm+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN8YU5N9mktrxT6Tv67m=nh_Cnw0SYBq+bf5kUzpoWUAToJm+Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 19, 2021 at 02:59:30PM +0200, Andrea Merello wrote:
> Il giorno lun 19 lug 2021 alle ore 13:56 Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> ha scritto:
> >
> > On Mon, Jul 19, 2021 at 10:49:54AM +0200, Andrea Merello wrote:
> > > Il giorno sab 17 lug 2021 alle ore 17:48 Jonathan Cameron
> > > <jic23@kernel.org> ha scritto:
> > > > On Thu, 15 Jul 2021 16:17:42 +0200
> > > > Andrea Merello <andrea.merello@gmail.com> wrote:

...

> > > > > +/*
> > > > > + * Register writes cmd have the following format
> > > > > + * +------+------+-----+-----+----- ... ----+
> > > > > + * | 0xAA | 0xOO | REG | LEN | payload[LEN] |
> > > > > + * +------+------+-----+-----+----- ... ----+
> > > > > + *
> > > > > + * Register write responses have the following format
> > > > > + * +------+----------+
> > > > > + * | 0xEE | ERROCODE |
> > > > > + * +------+----------+
> > > > > + *
> > > > > + * Register read have the following format
> > > > > + * +------+------+-----+-----+
> > > > > + * | 0xAA | 0xO1 | REG | LEN |
> > > > > + * +------+------+-----+-----+
> > > > > + *
> > > > > + * Successful register read response have the following format
> > > > > + * +------+-----+----- ... ----+
> > > > > + * | 0xBB | LEN | payload[LEN] |
> > > > > + * +------+-----+----- ... ----+
> > > > > + *
> > > > > + * Failed register read response have the following format
> > > > > + * +------+--------+
> > > > > + * | 0xEE | ERRCODE|  (ERRCODE always > 1)
> > > > > + * +------+--------+
> > > > > + *
> > > > > + * Error codes are
> > > > > + * 01: OK
> > > > > + * 02: read/write FAIL
> > > > > + * 04: invalid address
> > > > > + * 05: write on RO
> > > > > + * 06: wrong start byte
> > > > > + * 07: bus overrun
> > > > > + * 08: len too high
> > > > > + * 09: len too low
> > > > > + * 10: bus RX byte timeout (timeout is 30mS)
> > > > > + *
> > > > > + *
> > > > > + * **WORKAROUND ALERT**
> > > > > + *
> > > > > + * Serial communication seems very fragile: the BNO055 buffer seems to overflow
> > > > > + * very easy; BNO055 seems able to sink few bytes, then it needs a brief pause.
> > > > > + * On the other hand, it is also picky on timeout: if there is a pause > 30mS in
> > > > > + * between two bytes then the transaction fails (IMU internal RX FSM resets).
> > > > > + *
> > > > > + * BMU055 has been seen also failing to process commands in case we send them
> > > > > + * too close each other (or if it is somehow busy?)
> > > > > + *
> > > > > + * One idea would be to split data in chunks, and then wait 1-2mS between
> > > > > + * chunks (we hope not to exceed 30mS delay for any reason - which should
> > > > > + * be pretty a lot of time for us), and eventually retry in case the BNO055
> > > > > + * gets upset for any reason. This seems to work in avoiding the overflow
> > > > > + * errors, but indeed it seems slower than just perform a retry when an overflow
> > > > > + * error occur.
> > > > > + * In particular I saw these scenarios:
> > > > > + * 1) If we send 2 bytes per time, then the IMU never(?) overflows.
> > > > > + * 2) If we send 4 bytes per time (i.e. the full header), then the IMU could
> > > > > + *    overflow, but it seem to sink all 4 bytes, then it returns error.
> > > > > + * 3) If we send more than 4 bytes, the IMU could overflow, and I saw it sending
> > > > > + *    error after 4 bytes are sent; we have troubles in synchronizing again,
> > > > > + *    because we are still sending data, and the IMU interprets it as the 1st
> > > > > + *    byte of a new command.
> > > > > + *
> > > > > + * So, we workaround all this in the following way:
> > > > > + * In case of read we don't split the header but we rely on retries; This seems
> > > > > + * convenient for data read (where we TX only the hdr).
> > > > > + * For TX we split the transmission in 2-bytes chunks so that, we should not
> > > > > + * only avoid case 2 (which is still manageable), but we also hopefully avoid
> > > > > + * case 3, that would be by far worse.
> > > >
> > > > Nice docs and this sounds terrible!
> > >
> > > Indeed.. If anyone has nicer ideas, or is aware about better
> > > workaround, I would really love to know...
> >
> > This needs somebody to go thru data sheet and check for possibilities, what you
> > described above is not gonna fly. Okay, "in a robust way".
> >
> > I can't believe there is nothing in the communication protocol that may
> > increase a robustness.
> 
> The serial protocol is both described in the datasheet and in an
> application note "BNO055UART interface". Both of them mention the fact
> that  the IMU could just fail in processing the commands and responds
> with a status message with the "overflow" error code. The application
> note says this can happen because of an internal IMU buffer clearing
> stuff not happening in time, and that you have to retry the command in
> such case (which works for read commands, because after the header the
> IMU will always respond with something).
> 
> They say nothing about the fact that the IMU could decide to respond
> with an "overflow" status message when a write command is still being
> TXed, even if it is not finished yet, but this actually happens (seen
> at least after the 4-bytes header).

(1)

> 
> I think there is not much other information about this in datasheet
> and application note. Besides, the message formats are also described
> the comments in bno055_sl.c
> 
> Given that the IMU behaves like this, I could only see three possible
> workarounds for managing write commands:
> 1 - be quick enough on RX side in catching the IMU overflow status
> response before sending the next char, which seems unfeasible.
> 2 - be slow enough to let the IMU do its own stuff, which seems doable.
> 3 - let the mess happen and try to recover: when we get the IMU
> overflow error then we might still being TXing; in this case we stop
> and we wait for the IMU to complain for a malformed command, but I'm
> unsure how the IMU could handle this: it will refuse the wrong
> starting byte (unless our payload is 0xAA by chance), but then how
> many bytes does it throw away? How may (malformed) commands would it
> try to extract from a the garbage we TXed (how may complaints response
> would we receive and need to wait) ? And what if there is something in
> payload that resembles a valid command and got accepted? This seems
> worse than workaround #2

I believe the #3 is the right thing to do actually.

The payload is up to 128 bytes and speed is fixed. I believe that firmware has
internally the state of the input processing. OTOH the UART is duplex and what
you need in the driver is to have a callback that will read whatever the answer
from the sensor will be at the time it appears.

Also note that Linux is not an RTOS and you may end up, maybe rarely, in the
case which resembles the #3 while using workaround #2.

On top of that you demolish the idea of using DMA with UART.

(Btw, AN012 [1] says 100ms is the write timeout for the next byte,
 and not 30ms.)

As AN012 rightfully pointed out the UART is _async_ interface, so I believe (1)
is covered by this, meaning that error respond may appear _at any time_ on the
(host-side) Rx line.

My personal take away is never ever use UART for this kind (*) of
communications and this sensor specifically.

*) time-based IPCs are doomed by definition in non-RTOS environments with UART
   hardware interface.

[1]: BST-BNO055-AN012-00 | Revision 1.0 | June 2015

> What I meant: given this IMU behaviour, if someone has a better idea
> about how to deal with it, I would listen :)
> 
> > > > > + */

...

> > > > > +/* Read operation overhead:
> > > > > + * 4 bytes req + 2byte resp hdr
> > > > > + * 6 bytes = 60 bit (considering 1start + 1stop bits).
> > > > > + * 60/115200 = ~520uS
> > > > > + * In 520uS we could read back about 34 bytes that means 3 samples, this means
> > > > > + * that in case of scattered read in which the gap is 3 samples or less it is
> > > > > + * still convenient to go for a burst.
> > > > > + * We have to take into account also IMU response time - IMU seems to be often
> > > > > + * reasonably quick to respond, but sometimes it seems to be in some "critical
> > > > > + * section" in which it delays handling of serial protocol.
> > > > > + * By experiment, it seems convenient to burst up to about 5/6-samples-long gap
> >
> > Missed perial and entire comment needs proper style and space occupation ratio.
> 
> Perial? But OK: text reflow and I see the 1st line for multilne

Period.

> commend is not correct.
> 
> > > > > + */

-- 
With Best Regards,
Andy Shevchenko


