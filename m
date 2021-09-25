Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35FE418357
	for <lists+linux-iio@lfdr.de>; Sat, 25 Sep 2021 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbhIYQGk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 25 Sep 2021 12:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237147AbhIYQGj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Sep 2021 12:06:39 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E976109D;
        Sat, 25 Sep 2021 16:05:02 +0000 (UTC)
Date:   Sat, 25 Sep 2021 17:08:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, nuno.sa@analog.com
Subject: Re: iio: Understanding the modes
Message-ID: <20210925170850.11108e9b@jic23-huawei>
In-Reply-To: <20210922112231.37e565e6@xps13>
References: <20210922112231.37e565e6@xps13>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Sep 2021 11:22:31 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hello IIO folks,
> 
> I am currently writing a blog post trying to explain the situation that
> I had with the max1027 driver [1] and possibly try to explain the logic
> behind the changes that Jonathan/Nuno requested. As part of this work, I
> tried to understand (and explain?) the meaning of the mode definitions
> and if they were needed or not, but just looking at the code was not
> enough for me to really understand.
> 
> While digging into the IIO core, I realized that many definitions and
> helpers had no comments explaining their use. I could not find any
> documentation about the kernel API in general neither (while the
> userspace side is well documented).
> 
> I asked yesterday on #linux-iio but got no answers so I am also asking
> here in case there are knowledgeable people willing to explain what
> each of these definition actually mean and how they should be used:
> https://elixir.bootlin.com/linux/latest/source/include/linux/iio/iio.h#L319
> 
> I am ready to send a patch upstream to add the necessary comment
> so that these explanations do not stay on the mailing list only.

I'll have a go, but definitely would like others to sanity check my explanations
before we add them to the docs.  Thanks for offering to do that btw and blog
sounds like a great plan.

This stuff looks to have bitrotted pretty badly.

> /* Device operating modes */
> #define INDIO_DIRECT_MODE		0x01

This one simply means there is a sysfs poll mode.
We don't actually check anywhere if it is set for a driver so it's possible there
are drivers out there that should have this set and don't.
That might change in future if we have a reason to start checking.

It is used internally in the state management to indicate that we are not
currently in one of the buffered modes.   That's really just a place holder
though for 'not one one of the other options'

> #define INDIO_BUFFER_TRIGGERED		0x02

This is the most common mode when dealing with buffers. It indicates there
is an explicit trigger being used and so we should attach a poll func when
enabling the buffer.  There is a subtlety on this one.  If a device supports
both this and BUFFER_SOFTWARE (which typically means there is a FIFO or similar
and hence no explicit per scan trigger is exposed) then the mode setting will
use this if a trigger has been set, but otherwise use the INDIO_BUFFER_HARDWARE
or INDIO_BUFFER_SOFTWARE as appropriate (which normally means INDIO_BUFFER_SOFTWARE)

> #define INDIO_BUFFER_SOFTWARE		0x04

So this case is (now) misleadingly named. It's typically used for
FIFO cases. (Naming is because it used to reflect the presence of a KFIFO as
opposed to directly accessing a hardware FIFO).  Basically this means we
get the data in a kfifo but not one scan at a time if watermarks set
to greater than 1.

> #define INDIO_BUFFER_HARDWARE		0x08

An odd corner case similar to INDIO_BUFFER_SOFTWARE but with more restrictions
that exists for some unusual devices in which we are representing a flow of
data we can't actually see from software.  Used for some cases were a consumer
driver is actually accessing the data via some back channel.  I think we also
use it for DMA buffers because they have very similar restrictions (no DEMUX
in software).

What doesn't help is the meaning of this changed over time.  A long time back
IIRC it reflected a mode in which userspace was reading directly from fifos
on a device.  These days we always route through a kfifo to give us more
flexibility.

> #define INDIO_EVENT_TRIGGERED		0x10
There are devices (well 1 anyway) that use triggers to drive capture of
data that only results in events.  In that particular case it's a threshold
detector.  It uses some of the same intrastructure as INDIO_BUFFER_TRIGGERED.

> #define INDIO_HARDWARE_TRIGGERED	0x20
Ah, this one I'd forgotten about.  Its stm32 only (so far) and that has
a lot of internal data paths.  So we can have triggers that result in data
capture and IIRC can be routed to multiple components.  So we wire it
up in a similar fashion to a IIO trigger but none of the management of
interrupts / pollfuncs etc is relevant as it's all hardware mediated and
distributed.

I'm not sure how easy it will be to distill that into brief documentation.

If others want to contribute and point out what I got wrong above that would
be great.  This was very much an aspect that evolved rather than conformed
to an original plan unfortunately and so is perhaps less than ideal, but hard
to unwind.


Jonathan



> 
> Thanks,
> Miquèl
> 
> [1] https://lore.kernel.org/linux-iio/20210918180918.6908bbd9@jic23-huawei/

