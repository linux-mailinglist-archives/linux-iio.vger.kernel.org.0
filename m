Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB384C9F27
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2019 15:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfJCNO6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Oct 2019 09:14:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726811AbfJCNO6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Oct 2019 09:14:58 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 59995F7AFB9B11772778;
        Thu,  3 Oct 2019 21:14:55 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 3 Oct 2019
 21:14:52 +0800
Date:   Thu, 3 Oct 2019 14:14:43 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        David Lechner <david@lechnology.com>,
        <linux-iio@vger.kernel.org>, <jic23@jic23.retrosnub.co.uk>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>
Subject: Re: [RFC/PATCHv2 2/2] counter: introduce support for Intel QEP
 Encoder
Message-ID: <20191003141443.00003dd6@huawei.com>
In-Reply-To: <20191002003442.GA3364@icarus>
References: <20190917114403.GA8368@icarus>
        <20190919080305.960198-1-felipe.balbi@linux.intel.com>
        <20190919080305.960198-2-felipe.balbi@linux.intel.com>
        <20190922233538.GA3119@icarus>
        <e24965be-3b0b-7f5e-bc5b-e2fb09ce6d19@lechnology.com>
        <20190928213348.GA4693@icarus>
        <87muemwe74.fsf@gmail.com>
        <20191002003442.GA3364@icarus>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 1 Oct 2019 20:34:42 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Mon, Sep 30, 2019 at 08:22:39AM +0300, Felipe Balbi wrote:
> > 
> > Hi,
> > 
> > William Breathitt Gray <vilhelm.gray@gmail.com> writes:  
> > > On Tue, Sep 24, 2019 at 04:46:57PM -0500, David Lechner wrote:  
> > >> On 9/22/19 6:35 PM, William Breathitt Gray wrote:  
> > >> > On Thu, Sep 19, 2019 at 11:03:05AM +0300, Felipe Balbi wrote:  
> > >> >> Add support for Intel PSE Quadrature Encoder
> > >> >>
> > >> >> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> > >> >> ---
> > >> >>
> > >> >> Changes since v1:
> > >> >> 	- Many more private sysfs files converted over to counter interface
> > >> >>
> > >> >>
> > >> >> How do you want me to model this device's Capture Compare Mode (see
> > >> >> below)?  
> > >> > 
> > >> > Hi Felipe,
> > >> > 
> > >> > I'm CCing Fabien and David as they may be interested in the timestamps
> > >> > discussion. See below for some ideas I have on implementing this.
> > >> >   
> > >> 
> > >> Could be an interesting read (thread from my first counter driver):
> > >> 
> > >> https://lore.kernel.org/linux-iio/1b913919-beb9-34e7-d915-6bcc40eeee1d@lechnology.com/
> > >> 
> > >> What would be useful to me is something like the buffer feature in iio
> > >> where a timestamp is associated with a count and stored in a buffer so that
> > >> we can look at a window of all values recorded in the last 20ms. Being able
> > >> to access this via mmap would be very helpful for performance (running on
> > >> 300MHz ARM). Anything to do with timestamps in sysfs is probably not useful
> > >> unless it is a rare event, like a watchdog timeout.  
> > >
> > > I'm CCing Jonathan Cameron since I'm not familiar with how IIO handles
> > > timestamps and buffers. I don't want to reinvent something that is
> > > working well, so hopefully we can reuse the IIO timestamp design for the
> > > Counter subsystem.

Simple approach, push them both into a kfifo. Userspace then reads this
(with poll/select/blocking read + things like watermarks all available).
The description of what is there in each record is handled via sysfs as
the IIO model is that the format of each record only changes with userspace
intervention.

The complexities mostly come from allowing the hardware side of what is there
and the software side to differ, but this is only really needed if you want
to have multiple readers and need to split up the data so each thinks it has
the device to itself.  I would guess not needed for counter usecases, but who
knows down the line.

> > >
> > > I would argue that a human-readable timestamps printout is useful for
> > > certain applications (e.g. a tally counter attached to a fault line: a
> > > human administrator will be able to review previous fault times).
> > > However as you point out, a low latency operation is necessary for
> > > performance critical applications.

For this sort of case you could use a sysfs file that just returns the oldest
entry when read.  A seek back to the start and reread or a reopen of the file
can then give you the next one and an appropriate error return indicates none
left.

> > >
> > > Although you are correct that mmap is a good low latency operation to
> > > get access to a timestamp buffer, I'm afraid giving direct access to
> > > memory like that will lead to many incompatible representations of
> > > timestamp data (e.g. variations in endianness, signedness, data size,
> > > etc.). I would like a standardized representation for this data that
> > > userspace applications can expect to receive and interpret, especially
> > > when time is widely represented as an unsigned integer.

It is moderately hard to get that sort of interface right, but it can be done.
IIO does it for DMA type buffers, but not for anything where a software
fifo is involved.   You would need to guarantee a fixed format etc.

> > >
> > > Felipe suggested the creation of a counter_event structure so that users
> > > can poll on an attribute. This kind of behavior is useful for notifying
> > > users of interrupts and other events, but I think we should restrict the
> > > use of the read call on these sysfs attributes to just human-readable
> > > data. Instead, perhaps ioctl calls can be used to facilitate binary data
> > > transfers.
> > >
> > > For example, we can define a COUNTER_GET_TIMESTAMPS_IOCTL ioctl request
> > > that returns a counter_timestamps structure with a timestamps array
> > > populated:
> > >
> > >         struct counter_timestamps{
> > >                 size_t num_timestamps;
> > >         	unsigned int *timestamps;
> > >         }
> > >
> > > That would allow quick access to the timestamps data, while also
> > > restricting it to a standard representation that all userspace
> > > applications can follow and interpret. In addition, this won't interfer
> > > with polling, so users can still wait for an interrupt and then decide
> > > whether they want to use the slower human-readable printout (via read)
> > > or the faster binary data access (via ioctl).  
> > 
> > Seems like we're starting to build the need for a /dev/counter[0123...]
> > representation of the subsystem. If that's the case, then it may very
> > well be that sysfs becomes somewhat optional.

Agreed.  Don't map this stuff onto sysfs where a chardev is more sensible.

> > 
> > I think is makes sense to rely more on character devices specially since
> > I know of devices running linux with so little memory that sysfs (and a
> > bunch of other features) are removed from the kernel. Having a character
> > device representation would allow counter subsystem to be used on such
> > devices.
> > 
> > cheers
> > 
> > -- 
> > balbi  
> 
> A character device node for a counter might be a good idea. If a
> performance critical application can't depend on parsing a sysfs
> printout for timestamps, then it probably doesn't want to do so for the
> other attributes either. I think you are right that certain systems
> would have sysfs disabled for that very reason.
> 

I am a little curious to whether people often run sysfs free any more?
I know it used to happen a fair bit, but a lot of the kernel is now rather
dependent on it.

Of course you can add IOCTLs to do all the configuration of a device, but
you can end up with a nasty and inflexible interface + add a burden
on simple users of them having to use a library to unwind it all rather
than simply poking text files. 

> I think latency concerns are the same reason the GPIO subsystem started
> providing character device nodes as well. 

That was part of it, but a big element was also to provide the ability
to set+get multiple lines in parallel.  Kind of the same as you have
here with a timestamp matching to a count.  For low latency gpio on an
SoC people often just directly write the registers from a userspace
mapping.

> We can do similar with the
> Counter subsystem: provide character device nodes by default, and
> optionally provide the human-readable sysfs interface as well. This
> would allow applications with latency concerns to use a standard
> interface for the Counter subsystem, while optionally providing a
> simpler sysfs interface for other users.

I wouldn't necessarily go for making the sysfs interface optional.
It is extremely convenient for describing complex devices. It is
possible to do all that via complex IOCTL query interfaces (see
the mediabus framework for example), but it's much heavier weight.

The IIO approach was to use the chardev for fast path and sysfs
for slow.  Maybe we'd do it differently if starting now, but I'm
not sure we would end up different in this aspect.  Other things
would change though ;)


Jonathan

> 
> William Breathitt Gray


