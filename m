Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E106E41DDF9
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 17:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346283AbhI3PxC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 30 Sep 2021 11:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346268AbhI3PxB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Sep 2021 11:53:01 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0E661267;
        Thu, 30 Sep 2021 15:51:16 +0000 (UTC)
Date:   Thu, 30 Sep 2021 16:55:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, nuno.sa@analog.com
Subject: Re: iio: Understanding the modes
Message-ID: <20210930165510.2295e6c4@jic23-huawei>
In-Reply-To: <20210927172927.51198ab7@xps13>
References: <20210922112231.37e565e6@xps13>
        <20210925170850.11108e9b@jic23-huawei>
        <20210927172927.51198ab7@xps13>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Sep 2021 17:29:27 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Jonathan,
> 
> jic23@kernel.org wrote on Sat, 25 Sep 2021 17:08:50 +0100:
> 
> > On Wed, 22 Sep 2021 11:22:31 +0200
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >   
> > > Hello IIO folks,
> > > 
> > > I am currently writing a blog post trying to explain the situation that
> > > I had with the max1027 driver [1] and possibly try to explain the logic
> > > behind the changes that Jonathan/Nuno requested. As part of this work, I
> > > tried to understand (and explain?) the meaning of the mode definitions
> > > and if they were needed or not, but just looking at the code was not
> > > enough for me to really understand.
> > > 
> > > While digging into the IIO core, I realized that many definitions and
> > > helpers had no comments explaining their use. I could not find any
> > > documentation about the kernel API in general neither (while the
> > > userspace side is well documented).
> > > 
> > > I asked yesterday on #linux-iio but got no answers so I am also asking
> > > here in case there are knowledgeable people willing to explain what
> > > each of these definition actually mean and how they should be used:
> > > https://elixir.bootlin.com/linux/latest/source/include/linux/iio/iio.h#L319
> > > 
> > > I am ready to send a patch upstream to add the necessary comment
> > > so that these explanations do not stay on the mailing list only.    
> > 
> > I'll have a go, but definitely would like others to sanity check my explanations
> > before we add them to the docs.  Thanks for offering to do that btw and blog
> > sounds like a great plan.
> > 
> > This stuff looks to have bitrotted pretty badly.
> >   
> > > /* Device operating modes */
> > > #define INDIO_DIRECT_MODE		0x01    
> > 
> > This one simply means there is a sysfs poll mode.  
> 
> Would "sysfs read mode" work for you here? In my mind "poll" means that
> this is a continuous effort while here I believe we are mainly talking
> about single shots.

Sysfs read is close, but not quite right. There are devices which have separate
fifo and last value registers.  So you can be streaming data and still have sysfs reads
of the channel work. I thought about your single shot terminology but
that's not quite always true as we offer 'last value' type things on devices that
don't support a read on demand function.

All it really means is we aren't in another mode and sysfs reads will 'definitely'
work.

> 
> > We don't actually check anywhere if it is set for a driver so it's possible there
> > are drivers out there that should have this set and don't.
> > That might change in future if we have a reason to start checking.
> > 
> > It is used internally in the state management to indicate that we are not
> > currently in one of the buffered modes.   That's really just a place holder
> > though for 'not one one of the other options'  
> 
> Perhaps it would be good to explain these two fields first:
> * iio_dev->modes
> This is the list of supported modes by the IIO device.
> This list should be initialized before registering the IIO device.
> This list can be filled up by the IIO core depending on the features
> advertised by the driver during other steps of the registration.
Good idea - Add additional detail to the iio_dev kernel doc.

> 
> * iio_dev->currentmode
> This is the mode currently in use. It may be checked by device drivers
> but should be considered read-only by individual drivers, only the core
> updates this field.

Oops.  This one is marked int eh iio_dev docs as [DRIVER] and as you note
it's only set by the core.  Please switch it to [INTERN] in your patch and
we can look at moving it into the iio_opaque structure soon with an access function
for the few cases that need to read it.

The rm3100-core is using it in places where I think it should be checking if
the buffer is enabled instead.  If we hide it away then it's harder to use
it in an unintended fashion in future.

> 
> > > #define INDIO_BUFFER_TRIGGERED		0x02    
> > 
> > This is the most common mode when dealing with buffers. It indicates there
> > is an explicit trigger being used and so we should attach a poll func when
> > enabling the buffer.  
> 
> Here by "the buffer" I assume you mean "any type of buffer, including a
> software buffer, eg. an array kmalloc'ed by the core to store the
> samples"?

In this case it's just a kfifo these days (we used to have several implementations
but reality is no one wanted anything beyond the fifo one so we dropped my hideous
not quite lockless ring buffer)

> 
> So here I understand that "_TRIGGERED" in the name means that the core
> needs to attach a poll function to the trigger handler in order to fill
> a buffer.

Exactly.

>  
> > There is a subtlety on this one.  If a device supports
> > both this and BUFFER_SOFTWARE (which typically means there is a FIFO or similar
> > and hence no explicit per scan trigger is exposed) then the mode setting will
> > use this if a trigger has been set, but otherwise use the INDIO_BUFFER_HARDWARE
> > or INDIO_BUFFER_SOFTWARE as appropriate (which normally means INDIO_BUFFER_SOFTWARE)
> >   
> > > #define INDIO_BUFFER_SOFTWARE		0x04    
> > 
> > So this case is (now) misleadingly named. It's typically used for
> > FIFO cases. (Naming is because it used to reflect the presence of a KFIFO as
> > opposed to directly accessing a hardware FIFO).  Basically this means we
> > get the data in a kfifo but not one scan at a time if watermarks set
> > to greater than 1.  
> 
> Is this what we usually refer to "continuous mode" in devices
> datasheets? So the difference with BUFFER_TRIGGERED is that the _TRIG*
> mode can be enabled at some point in time by an external event while
> the _SOFT* mode does it more or less continuously and reading the FIFO
> only gives the last samples that have not yet been overwritten?

It's not about overwriting of hardware fifo entries but more that we might not get
an event per 'scan' of data.  So there is no purpose in pushing through the
triggered infrastructure as we can't use it to cause capture from other devices
anyway.  So we don't register a trigger at all in most cases (IIRC there are a
few nasty cases where we need to pick between several different hardware signals
that are invisible to IIO and cause elements to be pushed into the fifo.)  Honestly
those are rare enough I'd not mention them in the documentation for this mode.

> 
> > > #define INDIO_BUFFER_HARDWARE		0x08    
> > 
> > An odd corner case similar to INDIO_BUFFER_SOFTWARE but with more restrictions
> > that exists for some unusual devices in which we are representing a flow of
> > data we can't actually see from software.  Used for some cases were a consumer
> > driver is actually accessing the data via some back channel.  I think we also
> > use it for DMA buffers because they have very similar restrictions (no DEMUX
> > in software).  
> 
> I think I get the rough idea but this is still pretty obscure.

Yup.

> 
> I believe this one should might not be considered as a real mode, I feel
> it's more like something that should be advertised by an additional flag
> because in the end it is a sub-case of INDIO_BUFFER_SOFT*. But I guess
> we can flag it as being special and not meant to be used in most cases.

It's more complex than the other modes because we can't read the data.  It only
exists as a flow in a pipeline in the hardware.   Agreed that it's fine to
say it's special case - or cynically skip documenting it for now which will
reflect the same thing.  Hopefully people will stick to the documented options.

> 
> > What doesn't help is the meaning of this changed over time.  A long time back
> > IIRC it reflected a mode in which userspace was reading directly from fifos
> > on a device.  These days we always route through a kfifo to give us more
> > flexibility.
> >   
> > > #define INDIO_EVENT_TRIGGERED		0x10    
> > There are devices (well 1 anyway) that use triggers to drive capture of
> > data that only results in events.  In that particular case it's a threshold
> > detector.  It uses some of the same intrastructure as INDIO_BUFFER_TRIGGERED.  
> 
> The explanation is clear to me, the name definitely is not :)

Better name?  It would be easy to change that as only one user!

> 
> > > #define INDIO_HARDWARE_TRIGGERED	0x20    
> > Ah, this one I'd forgotten about.  Its stm32 only (so far) and that has
> > a lot of internal data paths.  So we can have triggers that result in data
> > capture and IIRC can be routed to multiple components.  So we wire it
> > up in a similar fashion to a IIO trigger but none of the management of
> > interrupts / pollfuncs etc is relevant as it's all hardware mediated and
> > distributed.  
> 
> I am not sure how relevant it is to have this specific mode in the
> 'public' definitions list. Most of them are tied to the core's
> constraints but this one really only is used in the following files:


> 
> $ git grep INDIO_HARDWARE_TRIGG
> drivers/iio/adc/stm32-adc.c:    indio_dev->modes = INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
> drivers/iio/adc/stm32-dfsdm-adc.c:      indio_dev->modes |= INDIO_HARDWARE_TRIGGERED;
> drivers/iio/trigger/stm32-lptimer-trigger.c:    if (indio_dev->modes & INDIO_HARDWARE_TRIGGERED)
> drivers/iio/trigger/stm32-timer-trigger.c:      indio_dev->modes = INDIO_HARDWARE_TRIGGERED;
> include/linux/iio/iio.h:#define INDIO_HARDWARE_TRIGGERED        0x20
> include/linux/iio/iio.h:         | INDIO_HARDWARE_TRIGGERED)
> 
> Maybe we should kill this mode and just use an internal flag specific
> to the STM32 devices? (or otherwise flat it "STM32" in order to clearly
> communicate with developers that "this mode is not suitable for your
> driver").

Issue I think is it's part of INDIO_ALL_TRIGGERED_MODES because there are some
general things in the core we want to do, but not some of the ones related to other
modes.  I think it's mostly about providing the sysfs interfaces for a trigger which
we need to stitch together the pipelines.

> 
> This is not a mandatory step but while discussing the definition of
> these fields I feel that maybe we could as well reword a bit the
> definitions and try to convey their meaning more easily. Of course this
> is highly possible that I missed some of the key concepts there and I
> may be proposing something completely wrong.
> 
> /* Device operating modes */
> -#define INDIO_DIRECT_MODE              0x01
> -#define INDIO_BUFFER_TRIGGERED         0x02
> -#define INDIO_BUFFER_SOFTWARE          0x04
> -#define INDIO_BUFFER_HARDWARE          0x08
> -#define INDIO_EVENT_TRIGGERED          0x10
> +#define INDIO_SINGLE_READ_MODE         0x01

It's hard to not exclude valid uses.  This really just means that we aren't
in another mode and (almost) that reads are directly from the hardware.
There may be a few cases were it only looks direct though can't remember which.
(oddly restricted hardware where the best you can do is have a small fifo
 and drain it on sysfs read). Lots of devices where you have to read all
the channels and filter for just the one you asked for.

> +#define INDIO_SINGLE_TRIGGER_MODE      0x02

Hmm. Bikeshedding but kind of sounds like only one trigger will work
rather than single trigger per scan. Could use
INDIO_TRIGGER_PER_SCAN_MODE maybe?

> +#define INDIO_CONTINUOUS_CAPTURE_MODE  0x04

These start to get more overloaded as we go on - they really reflect only what
we want the driver to construct than a precise operating mode of the hardware.
95% of these could be described as

INDIO_HWFIFO_TO_KFIFO_MODE perhaps

> +#define INDIO_INDIRECT_CONTINUOUS_CAPTURE_MODE 0x08
I hate to name on functionality but this really just reflect that we can't demux
the stream in software.  There are multiple possible reasons for that.  We could
break them out and use a mask, but not sure how clean that would end up.

> +#define INDIO_NON_CAPTURE_TRIGGER_MODE 0x10
That's a bit reversed.  I'd say what it is used for rather than what it's not.

> -#define INDIO_HARDWARE_TRIGGERED       0x20

To be honest I'd suggest starting with documentation and
later we can think on naming after a bunch of sanity checking and potentially
splitting up of modes where we are sharing the same MODE value purely because
we want to do something the same in the core rather than them being usecase
based.

> 
> > I'm not sure how easy it will be to distill that into brief documentation.
> > 
> > If others want to contribute and point out what I got wrong above that would
> > be great.  This was very much an aspect that evolved rather than conformed
> > to an original plan unfortunately and so is perhaps less than ideal, but hard
> > to unwind.  
> 
> I understand. I am regularly working in the MTD subsystem, everything
> there stayed for legacy and historical reasons, but that's not a reason
> to keep it that way :-)

Maintenance burden is.  Though these days most of these modes are contained in
relatively few files which does make reworking this now a little more plausible
than it was a few years back.

Jonathan

> 
> Thanks,
> Miquèl

