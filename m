Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFC5C4507
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 02:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfJBAe7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 20:34:59 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41056 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfJBAe7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2019 20:34:59 -0400
Received: by mail-yw1-f65.google.com with SMTP id 129so5507004ywb.8
        for <linux-iio@vger.kernel.org>; Tue, 01 Oct 2019 17:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RG8vm7hKpSdFgBxD0meJx+orsHILwMpDpi3s7ULpZ9o=;
        b=YlvXyCn+ttYx6RiWkkm9Oj7fDsZ6MmxjGHj1dRHDkQZzDl1LCTgy8v9U/Q6IxodC4E
         VxGD4TJ7MsZdbGqYSylgWvp39YsHYZVRpo5S6OuMNmyjc/V3I1TdGH5N3Qfgd1iXgybi
         h9xn618w6pOQNCRcjiPO1pL8696PwfyZuygQ9N72Pq5Y+drRtg2lEudMTArbMLIvS2Hu
         Af2iL3dsTevSK4UG0k5bAk8B9DMVEFzkmuK/oUooc8s7ps6w7BXM4yEyU5K4uoJqRgWQ
         QWlNUsV0eC8TPtAViKv0esgK7ZCiJ7jnV9KHnM6zCtpXPC7VVGKmnpt8dJY56TbMv8Hb
         fziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RG8vm7hKpSdFgBxD0meJx+orsHILwMpDpi3s7ULpZ9o=;
        b=sbCDb5mFYEgMDIB3iwHxzfbO/Zqdswpr+lKWQyKNwfSfo8A/8Df5NFaGy0+mqesLTa
         xXJg3yJBIEtbIy0DKcO+oWb4KsXjJbArrYvOzsNWpgKicNLfw6i1WI/0dijRQIt6ZqFF
         pjdUFlcNgCSsu8ThbvflDXH9GW+ylTftW3O3upxnOCYazCUgOaIA7df/Sm7IyLYGYeHd
         kEOiCrkoPfUGDRRMOqkwl2Ks+1GwdMdxyPEt1pjLRfHXwwsl5BwFvb+yeWIaJ+Pti97U
         leSNKLE70n6gXpMjkVzLIX7bbNVlsARkp3aGoQAkpsr7OacW7WpHy7ZbzKl3NSx3fq/B
         3R5g==
X-Gm-Message-State: APjAAAXhkOMmbvgILheuXCVj6ATM+sZznYhq/y+ATo8NnjzLgfxc8VD4
        ZCMsAsgF+imR4Qe9C3swnYEUF0K7
X-Google-Smtp-Source: APXvYqwTaXlBt8IChK0vdSDfZdl/+j1MuM2I5O6F+Qw5BIFIB2Qer70xByqaJikJv9023pt2cJmXJg==
X-Received: by 2002:a81:9951:: with SMTP id q78mr914530ywg.332.1569976496725;
        Tue, 01 Oct 2019 17:34:56 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id q2sm3896738ywd.12.2019.10.01.17.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 17:34:55 -0700 (PDT)
Date:   Tue, 1 Oct 2019 20:34:42 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        jic23@jic23.retrosnub.co.uk,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>
Subject: Re: [RFC/PATCHv2 2/2] counter: introduce support for Intel QEP
 Encoder
Message-ID: <20191002003442.GA3364@icarus>
References: <20190917114403.GA8368@icarus>
 <20190919080305.960198-1-felipe.balbi@linux.intel.com>
 <20190919080305.960198-2-felipe.balbi@linux.intel.com>
 <20190922233538.GA3119@icarus>
 <e24965be-3b0b-7f5e-bc5b-e2fb09ce6d19@lechnology.com>
 <20190928213348.GA4693@icarus>
 <87muemwe74.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87muemwe74.fsf@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 30, 2019 at 08:22:39AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> William Breathitt Gray <vilhelm.gray@gmail.com> writes:
> > On Tue, Sep 24, 2019 at 04:46:57PM -0500, David Lechner wrote:
> >> On 9/22/19 6:35 PM, William Breathitt Gray wrote:
> >> > On Thu, Sep 19, 2019 at 11:03:05AM +0300, Felipe Balbi wrote:
> >> >> Add support for Intel PSE Quadrature Encoder
> >> >>
> >> >> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> >> >> ---
> >> >>
> >> >> Changes since v1:
> >> >> 	- Many more private sysfs files converted over to counter interface
> >> >>
> >> >>
> >> >> How do you want me to model this device's Capture Compare Mode (see
> >> >> below)?
> >> > 
> >> > Hi Felipe,
> >> > 
> >> > I'm CCing Fabien and David as they may be interested in the timestamps
> >> > discussion. See below for some ideas I have on implementing this.
> >> > 
> >> 
> >> Could be an interesting read (thread from my first counter driver):
> >> 
> >> https://lore.kernel.org/linux-iio/1b913919-beb9-34e7-d915-6bcc40eeee1d@lechnology.com/
> >> 
> >> What would be useful to me is something like the buffer feature in iio
> >> where a timestamp is associated with a count and stored in a buffer so that
> >> we can look at a window of all values recorded in the last 20ms. Being able
> >> to access this via mmap would be very helpful for performance (running on
> >> 300MHz ARM). Anything to do with timestamps in sysfs is probably not useful
> >> unless it is a rare event, like a watchdog timeout.
> >
> > I'm CCing Jonathan Cameron since I'm not familiar with how IIO handles
> > timestamps and buffers. I don't want to reinvent something that is
> > working well, so hopefully we can reuse the IIO timestamp design for the
> > Counter subsystem.
> >
> > I would argue that a human-readable timestamps printout is useful for
> > certain applications (e.g. a tally counter attached to a fault line: a
> > human administrator will be able to review previous fault times).
> > However as you point out, a low latency operation is necessary for
> > performance critical applications.
> >
> > Although you are correct that mmap is a good low latency operation to
> > get access to a timestamp buffer, I'm afraid giving direct access to
> > memory like that will lead to many incompatible representations of
> > timestamp data (e.g. variations in endianness, signedness, data size,
> > etc.). I would like a standardized representation for this data that
> > userspace applications can expect to receive and interpret, especially
> > when time is widely represented as an unsigned integer.
> >
> > Felipe suggested the creation of a counter_event structure so that users
> > can poll on an attribute. This kind of behavior is useful for notifying
> > users of interrupts and other events, but I think we should restrict the
> > use of the read call on these sysfs attributes to just human-readable
> > data. Instead, perhaps ioctl calls can be used to facilitate binary data
> > transfers.
> >
> > For example, we can define a COUNTER_GET_TIMESTAMPS_IOCTL ioctl request
> > that returns a counter_timestamps structure with a timestamps array
> > populated:
> >
> >         struct counter_timestamps{
> >                 size_t num_timestamps;
> >         	unsigned int *timestamps;
> >         }
> >
> > That would allow quick access to the timestamps data, while also
> > restricting it to a standard representation that all userspace
> > applications can follow and interpret. In addition, this won't interfer
> > with polling, so users can still wait for an interrupt and then decide
> > whether they want to use the slower human-readable printout (via read)
> > or the faster binary data access (via ioctl).
> 
> Seems like we're starting to build the need for a /dev/counter[0123...]
> representation of the subsystem. If that's the case, then it may very
> well be that sysfs becomes somewhat optional.
> 
> I think is makes sense to rely more on character devices specially since
> I know of devices running linux with so little memory that sysfs (and a
> bunch of other features) are removed from the kernel. Having a character
> device representation would allow counter subsystem to be used on such
> devices.
> 
> cheers
> 
> -- 
> balbi

A character device node for a counter might be a good idea. If a
performance critical application can't depend on parsing a sysfs
printout for timestamps, then it probably doesn't want to do so for the
other attributes either. I think you are right that certain systems
would have sysfs disabled for that very reason.

I think latency concerns are the same reason the GPIO subsystem started
providing character device nodes as well. We can do similar with the
Counter subsystem: provide character device nodes by default, and
optionally provide the human-readable sysfs interface as well. This
would allow applications with latency concerns to use a standard
interface for the Counter subsystem, while optionally providing a
simpler sysfs interface for other users.

William Breathitt Gray
