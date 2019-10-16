Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB3CD9B92
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2019 22:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbfJPUUw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Oct 2019 16:20:52 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45801 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbfJPUUw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2019 16:20:52 -0400
Received: by mail-yb1-f196.google.com with SMTP id q143so8243635ybg.12
        for <linux-iio@vger.kernel.org>; Wed, 16 Oct 2019 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PI7KrLqthxMMTVofkEXGWv285Mvk1pA5eR0dGJiBHws=;
        b=iUinHmeVnrKVaHK8vxHbt+Yq5L28oPzaPtDwDtYNjMX1Am3K3F/vqeFRBBEzQAuDex
         q0MwW9uakoKHAZL+OpqIDbHFIEN73D8V8spU0jbrHcKwr25YvGvjnblymZSyH9oUxPq5
         3fnPmYgM9TD5JfS7FnkLda56VVxFCi2VgmurzI4f+D9cETIRXrLDvRvawer5zDt+NHgV
         a0FRJokRemugx7YdIc3Nhg3qv09DxFd+xZoehpmcW1dwf2zbYk0SX9E/sNm5iuRNrWdU
         eJvjzkuHf9s9g8VzXrfppRKPDrDsUJCVBxGWzBDZgZR5nitnH3sHHuHFEeFDMQkMHxqg
         hZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PI7KrLqthxMMTVofkEXGWv285Mvk1pA5eR0dGJiBHws=;
        b=B78BfTRGUUMI+99FPNyVhlRLh2pGMDSZUpH2v1m8IuTn3UXb1SFq+QEVpXXGXexdDI
         7f3TT9pZoNnTineYK6nI8m4LWXnxTVEi4X1tFqSrNk3JDGFq1esBTbWBafZezh1XYF0/
         VdSJNE4BErIR6O2vYnU5THYwqaPgjuOaFfBx8zB6kIMeEELd5zTbEzY/IfpG2z0ugD20
         Dahc3aTaf9ZiizCd+G4mgAhnAUurIiebKF5isZQNlwxOh9MYwQzjAQDMZGfiurndaQAV
         Ur7JIogPLyickmGxTIQcJD2m2hYOk4gihUwgfpQaEdG3aLoIc1nN0pAimdspsVZn/jID
         i+5g==
X-Gm-Message-State: APjAAAXfIDGqHWf2Wb0VvKSdotNljnzea2SpbSfbFjjpyHjXjkPIJ8w6
        uUwhxv2Q5EwPNLZMfhMuO4I=
X-Google-Smtp-Source: APXvYqw5ggrF2A3N/yQwgNpGqKEY3I+gQ2a4Z/CNKAc1fiM2sa9zauty99YgAnDNXnu8A4Scubc9yg==
X-Received: by 2002:a25:bc49:: with SMTP id d9mr339328ybk.293.1571257250958;
        Wed, 16 Oct 2019 13:20:50 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id c80sm6787005ywa.3.2019.10.16.13.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:20:49 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:20:35 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        David Lechner <david@lechnology.com>,
        linux-iio@vger.kernel.org, jic23@jic23.retrosnub.co.uk,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>
Subject: Re: [RFC/PATCHv2 2/2] counter: introduce support for Intel QEP
 Encoder
Message-ID: <20191016202035.GA513122@icarus>
References: <20190917114403.GA8368@icarus>
 <20190919080305.960198-1-felipe.balbi@linux.intel.com>
 <20190919080305.960198-2-felipe.balbi@linux.intel.com>
 <20190922233538.GA3119@icarus>
 <e24965be-3b0b-7f5e-bc5b-e2fb09ce6d19@lechnology.com>
 <20190928213348.GA4693@icarus>
 <87muemwe74.fsf@gmail.com>
 <20191002003442.GA3364@icarus>
 <20191003141443.00003dd6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191003141443.00003dd6@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 03, 2019 at 02:14:43PM +0100, Jonathan Cameron wrote:
> On Tue, 1 Oct 2019 20:34:42 -0400
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
> > On Mon, Sep 30, 2019 at 08:22:39AM +0300, Felipe Balbi wrote:
> > > 
> > > Hi,
> > > 
> > > William Breathitt Gray <vilhelm.gray@gmail.com> writes:  
> > > > On Tue, Sep 24, 2019 at 04:46:57PM -0500, David Lechner wrote:  
> > > >> On 9/22/19 6:35 PM, William Breathitt Gray wrote:  
> > > >> > On Thu, Sep 19, 2019 at 11:03:05AM +0300, Felipe Balbi wrote:  
> > > >> >> Add support for Intel PSE Quadrature Encoder
> > > >> >>
> > > >> >> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> > > >> >> ---
> > > >> >>
> > > >> >> Changes since v1:
> > > >> >> 	- Many more private sysfs files converted over to counter interface
> > > >> >>
> > > >> >>
> > > >> >> How do you want me to model this device's Capture Compare Mode (see
> > > >> >> below)?  
> > > >> > 
> > > >> > Hi Felipe,
> > > >> > 
> > > >> > I'm CCing Fabien and David as they may be interested in the timestamps
> > > >> > discussion. See below for some ideas I have on implementing this.
> > > >> >   
> > > >> 
> > > >> Could be an interesting read (thread from my first counter driver):
> > > >> 
> > > >> https://lore.kernel.org/linux-iio/1b913919-beb9-34e7-d915-6bcc40eeee1d@lechnology.com/
> > > >> 
> > > >> What would be useful to me is something like the buffer feature in iio
> > > >> where a timestamp is associated with a count and stored in a buffer so that
> > > >> we can look at a window of all values recorded in the last 20ms. Being able
> > > >> to access this via mmap would be very helpful for performance (running on
> > > >> 300MHz ARM). Anything to do with timestamps in sysfs is probably not useful
> > > >> unless it is a rare event, like a watchdog timeout.  
> > > >
> > > > I'm CCing Jonathan Cameron since I'm not familiar with how IIO handles
> > > > timestamps and buffers. I don't want to reinvent something that is
> > > > working well, so hopefully we can reuse the IIO timestamp design for the
> > > > Counter subsystem.
> 
> Simple approach, push them both into a kfifo. Userspace then reads this
> (with poll/select/blocking read + things like watermarks all available).
> The description of what is there in each record is handled via sysfs as
> the IIO model is that the format of each record only changes with userspace
> intervention.
> 
> The complexities mostly come from allowing the hardware side of what is there
> and the software side to differ, but this is only really needed if you want
> to have multiple readers and need to split up the data so each thinks it has
> the device to itself.  I would guess not needed for counter usecases, but who
> knows down the line.

Is the kfifo updating only when a user interacts with the timestamp
sysfs attributes? If so, why store the timestamps in a kfifo instead of
serving them directly on demand; or is the kfifo there to allow multiple
users to access the same timestamp fifo?

> > > >
> > > > I would argue that a human-readable timestamps printout is useful for
> > > > certain applications (e.g. a tally counter attached to a fault line: a
> > > > human administrator will be able to review previous fault times).
> > > > However as you point out, a low latency operation is necessary for
> > > > performance critical applications.
> 
> For this sort of case you could use a sysfs file that just returns the oldest
> entry when read.  A seek back to the start and reread or a reopen of the file
> can then give you the next one and an appropriate error return indicates none
> left.

The downside to this interface is that it's volatile, in the sense that
once the fifo is read you can't reread it unless you saved those
timestamps yourself. However, as you've pointed out in another email,
sysfs has a "single value" rule so returning the latest timestamp is
likely the best solution given the restriction that multiple values
cannot be returned via a single attribute.

> > > >
> > > > Although you are correct that mmap is a good low latency operation to
> > > > get access to a timestamp buffer, I'm afraid giving direct access to
> > > > memory like that will lead to many incompatible representations of
> > > > timestamp data (e.g. variations in endianness, signedness, data size,
> > > > etc.). I would like a standardized representation for this data that
> > > > userspace applications can expect to receive and interpret, especially
> > > > when time is widely represented as an unsigned integer.
> 
> It is moderately hard to get that sort of interface right, but it can be done.
> IIO does it for DMA type buffers, but not for anything where a software
> fifo is involved.   You would need to guarantee a fixed format etc.
> 
> > > >
> > > > Felipe suggested the creation of a counter_event structure so that users
> > > > can poll on an attribute. This kind of behavior is useful for notifying
> > > > users of interrupts and other events, but I think we should restrict the
> > > > use of the read call on these sysfs attributes to just human-readable
> > > > data. Instead, perhaps ioctl calls can be used to facilitate binary data
> > > > transfers.
> > > >
> > > > For example, we can define a COUNTER_GET_TIMESTAMPS_IOCTL ioctl request
> > > > that returns a counter_timestamps structure with a timestamps array
> > > > populated:
> > > >
> > > >         struct counter_timestamps{
> > > >                 size_t num_timestamps;
> > > >         	unsigned int *timestamps;
> > > >         }
> > > >
> > > > That would allow quick access to the timestamps data, while also
> > > > restricting it to a standard representation that all userspace
> > > > applications can follow and interpret. In addition, this won't interfer
> > > > with polling, so users can still wait for an interrupt and then decide
> > > > whether they want to use the slower human-readable printout (via read)
> > > > or the faster binary data access (via ioctl).  
> > > 
> > > Seems like we're starting to build the need for a /dev/counter[0123...]
> > > representation of the subsystem. If that's the case, then it may very
> > > well be that sysfs becomes somewhat optional.
> 
> Agreed.  Don't map this stuff onto sysfs where a chardev is more sensible.
> 
> > > 
> > > I think is makes sense to rely more on character devices specially since
> > > I know of devices running linux with so little memory that sysfs (and a
> > > bunch of other features) are removed from the kernel. Having a character
> > > device representation would allow counter subsystem to be used on such
> > > devices.
> > > 
> > > cheers
> > > 
> > > -- 
> > > balbi  
> > 
> > A character device node for a counter might be a good idea. If a
> > performance critical application can't depend on parsing a sysfs
> > printout for timestamps, then it probably doesn't want to do so for the
> > other attributes either. I think you are right that certain systems
> > would have sysfs disabled for that very reason.
> > 
> 
> I am a little curious to whether people often run sysfs free any more?
> I know it used to happen a fair bit, but a lot of the kernel is now rather
> dependent on it.
> 
> Of course you can add IOCTLs to do all the configuration of a device, but
> you can end up with a nasty and inflexible interface + add a burden
> on simple users of them having to use a library to unwind it all rather
> than simply poking text files. 
> 
> > I think latency concerns are the same reason the GPIO subsystem started
> > providing character device nodes as well. 
> 
> That was part of it, but a big element was also to provide the ability
> to set+get multiple lines in parallel.  Kind of the same as you have
> here with a timestamp matching to a count.  For low latency gpio on an
> SoC people often just directly write the registers from a userspace
> mapping.
> 
> > We can do similar with the
> > Counter subsystem: provide character device nodes by default, and
> > optionally provide the human-readable sysfs interface as well. This
> > would allow applications with latency concerns to use a standard
> > interface for the Counter subsystem, while optionally providing a
> > simpler sysfs interface for other users.
> 
> I wouldn't necessarily go for making the sysfs interface optional.
> It is extremely convenient for describing complex devices. It is
> possible to do all that via complex IOCTL query interfaces (see
> the mediabus framework for example), but it's much heavier weight.
> 
> The IIO approach was to use the chardev for fast path and sysfs
> for slow.  Maybe we'd do it differently if starting now, but I'm
> not sure we would end up different in this aspect.  Other things
> would change though ;)
> 
> 
> Jonathan
> 
> > 
> > William Breathitt Gray

I agree about the utility and convenience of sysfs; it's an interface
that is simple enough for a human to understand and provides information
in a universally parsable format: text. We can leave the sysfs interface
available by default since disabling it can be left to the power users
that have a need to do so (and flipping a Kconfig option shouldn't be
that difficult to accomplish).

Regardless, I do see the benefits of providing a chardev interface --
not just for timestamps evaluation but in other counter applications as
well, such as two-dimensional positioning tables where multiple counter
values would need to be read at relatively the same time (a situation
where multiple sysfs reads would impede precision).

My concern with this is similar: a growing list of IOCTLs that are added
with new drivers trying to expose their device-specific extensions. I
think exposing every single extension with a respective dedicated IOCTL
is not the way to go; this would quickly lead to an unmaintainable list
of IOCTLs that most users would never need

A more maintainable approach is to dedicate specialized IOCTLs only for
those features that are used by multiple counter drivers (i.e. listed in
Documentation/ABI/testing/sysfs-bus-counter); this will help curb
feature creep. The other driver-specific extensions can be accessed via
a few IOCTLs made for such interaction: perhaps one to poll for a list
of available extensions and another to read/write.

The only change required to the Counter driver API is to allow for a
more opaque extension structure. This will allow us to supply dedicated
extension callbacks to handle binary data rather than text (though in an
opaque way such as the existing counter_count_direction enum); however,
driver-specific extensions can still be handled by text for simplicity.

The main change would be in the drivers/counter/counter.c file. This can
be split into three file: counter-core, counter-sysfs, counter-chardev.
The counter-core file would provide the core Counter functionality and
handle the driver API; the counter-sysfs and counter-chardev files can
expose the Counter subsystem to userspace in their respective formats.

William Breathitt Gray
