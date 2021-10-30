Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB0F44098F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 16:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhJ3Ohq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 10:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhJ3Ohq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Oct 2021 10:37:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A617A60F58;
        Sat, 30 Oct 2021 14:35:14 +0000 (UTC)
Date:   Sat, 30 Oct 2021 15:39:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] docs: counter: add latch_mode and latched_count
 sysfs attributes
Message-ID: <20211030153939.44c8145d@jic23-huawei>
In-Reply-To: <YXygyba/r/8+h+W3@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
        <20211017013343.3385923-7-david@lechnology.com>
        <YXkFzK0TA5zswSrQ@shinobu>
        <e660e9c5-a116-5450-8afb-1053a1504ab6@lechnology.com>
        <YXygyba/r/8+h+W3@shinobu>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 30 Oct 2021 10:32:57 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Wed, Oct 27, 2021 at 12:00:24PM -0500, David Lechner wrote:
> > On 10/27/21 2:54 AM, William Breathitt Gray wrote:  
> > > On Sat, Oct 16, 2021 at 08:33:41PM -0500, David Lechner wrote:  
> > >> @@ -147,6 +150,14 @@ Description:
> > >>   			updates	the respective count. Quadrature encoding
> > >>   			determines the direction.
> > >>   
> > >> +What:		/sys/bus/counter/devices/counterX/countY/latched_count
> > >> +KernelVersion:	5.16
> > >> +Contact:	linux-iio@vger.kernel.org
> > >> +Description:
> > >> +		Latched count data of Count Y represented as a string. The value
> > >> +		is latched in based on the trigger selected by the
> > >> +		counterX/latch_mode attribute.
> > >> +  
> > > 
> > > Latches are pretty common components of devices, and not simply limited
> > > to latching the count data. I wonder if it would be better to omit the
> > > "_count" suffix in order to make this more general. Well, the name
> > > "latched_count" is suitable for counters so you probably don't need to
> > > change it, but it's something to think about in the future.
> > >   
> > 
> > I chose the name counterX/countY/latched_count since we already have
> > counterX/countY/count to read the same (not latched) count. This
> > indicates that they are the same quantity, just from a different
> > point in time.
> > 
> > Also for consideration, this particular hardware actually has 3
> > independent latched counts. One is triggered by the selected
> > latched_mode. One is triggered by the index signal and one is
> > triggered by the strobe signal.
> > 
> > The latter two are not implemented in this series, but if there were a
> > use for those, I would probably submit attributes index_latched_count
> > and strobe_latched_count. These are unaffected by the latch_mode.
> > 
> > Similarly, the unit timer has a timer latch and a period latch. If we
> > change the unit timer to be a Count as suggested, then the latched
> > timer would basically be the same as latched_count. Both of these
> > are triggered by the selected latch_mode.
> > 
> > So, I supposed if we wanted to keep things really generic, we would
> > want to introduce some sort of "latch trigger" component (synapse?).
> > There could theoretically be multiple configurable triggers, so
> > the proposed latch_mode might need to be made indexed or part of
> > an index component/extension.  
> 
> Aside from deriving their latched values from the current and historical
> count values, these latches don't seem to be related to Counters in an
> operational sense; i.e. they don't really fit into the Counter subsystem
> paradigm because they aren't functionally counters, but rather just use
> the count values here as source data for their own operations. As such,
> I'm not sure yet if they really belong in the Counter subsystem or
> somewhere else in the IIO subsystem.

In this particular case I think we are talking about latching counts rather
than something else?  So one event happens and we latch the count at that
point.

The IIO equivalent is a trigger event driving data into a buffer.
There are a few examples of this though it's pretty rare.
The most general corner case is probably what we see with impact sensors.
In those cases we have data captured around an event (rather than a single
latched value).

They are rather complex beasts but the best we've managed is a special
trigger used only with that device and some control attributes to say what
is captured when the trigger fires.  Note this is a stetch in IIO because
normally triggers are one per sample...

> 
> >   
> > >>   What:		/sys/bus/counter/devices/counterX/countY/name
> > >>   KernelVersion:	5.2
> > >>   Contact:	linux-iio@vger.kernel.org
> > >> @@ -209,6 +220,7 @@ What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
> > >>   What:		/sys/bus/counter/devices/counterX/countY/direction_component_id
> > >>   What:		/sys/bus/counter/devices/counterX/countY/enable_component_id
> > >>   What:		/sys/bus/counter/devices/counterX/countY/error_noise_component_id
> > >> +What:		/sys/bus/counter/devices/counterX/countY/latched_count_component_id
> > >>   What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_id
> > >>   What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
> > >>   What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_id
> > >> @@ -218,6 +230,7 @@ What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
> > >>   What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
> > >>   What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
> > >>   What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
> > >> +What:		/sys/bus/counter/devices/latch_mode_component_id
> > >>   What:		/sys/bus/counter/devices/unit_timer_enable_component_id
> > >>   What:		/sys/bus/counter/devices/unit_timer_period_component_id
> > >>   What:		/sys/bus/counter/devices/unit_timer_time_component_id  
> > 
> > Just noticing here, I missed the counterX in the device-level components.
> >   
> > >> @@ -244,6 +257,22 @@ Description:
> > >>   		counter_event data structures. The number of elements will be
> > >>   		rounded-up to a power of 2.
> > >>   
> > >> +What:		/sys/bus/counter/devices/counterX/latch_mode
> > >> +KernelVersion:	5.16
> > >> +Contact:	linux-iio@vger.kernel.org
> > >> +Description:
> > >> +		Read/write attribute that selects the trigger for latching
> > >> +		values. Valid values are device-specific (given by
> > >> +		latch_mode_available attribute) and may include:
> > >> +
> > >> +		"Read count":
> > >> +			Reading the countY/count attribute latches values.
> > >> +
> > >> +		"Unit timeout":
> > >> +			Unit timer timeout event latches values.
> > >> +
> > >> +		The latched values can be read from latched_* attributes.
> > >> +  
> > > 
> > > To make these modes more generic for use in future drivers, I suggest
> > > removing the "Unit " prefix and just leaving that mode as "Timeout". In
> > > a similar vein, rewording "Read count" to "Count read" would make this
> > > mode easier to understand in case a future driver introduces a mode
> > > called "Signal read" or similar.
> > >   
> > 
> > Continuing my thoughts from above and taking this suggestion into
> > consideration...
> > 
> > Maybe we need a /sys/bus/counter/devices/counterX/latchY component.
> > This would represent the trigger for a latch. For the TI eQEP in this
> > series, there are potentially 3 of these (only one implemented for
> > now).
> > 
> > latchY would have a required `trigger` attribute that would describe
> > what triggers the latch. If the trigger is selectable, there would be
> > a `triggers_available` attribute that would list the possible triggers,
> > otherwise the `trigger` attribute would just be read-only. Available
> > triggers could could be "X read" where X is a fully qualified component
> > name, e.g. "Count0 count read" or a fully qualified event, e.g.
> > "Count1 overflow event" (this is unit timer timeout in generic counter
> > terms). But, there may be potential triggers that don't fit either
> > of these patterns.
> > 
> > Although not currently needed, the triggers for the index and strobe
> > latches on the eQEP get more interesting. The `triggers_available` for
> > the index latch are "index rising edge", "index falling edge" and
> > "software" (this would require a `software_trigger` attribute that
> > would be written to trigger the latch). The `triggers_available` for
> > the strobe latch are "strobe rising edge" and "strobe rising edge if
> > direction is clockwise and strobe falling edge if direction is
> > counterclockwise".
> > 
> > Circling back to the beginning, to read latched registers, there
> > would be attributes like counterX/countY/latchY_count instead of
> > the proposed counterX/countY/latched_count. So for the eQEP there
> > would be counter0/count0/latch0_count (triggered by reading
> > counter0/count0/count or counter0/count1 overflow event),
> > counter0/count0/latch1_count (triggered by index signal),
> > counter0/count0/latch2_count (triggered by strobe signal),
> > counter0/count1/latch0_count (unit timer latched timer trigger
> > by same trigger as counter0/count0/latch0_count) and
> > counter0/count0/latch0_ceiling (unit timer latched period
> > triggered by same trigger as counter0/count0/latch0_count).  
> 
> The complexity of configuration here is a good indication that these
> latches deserve their own tree structure as you suggest. Furthermore, we
> see that there at least three of these latches available for this
> particular device, so just a single "latch_count" or similar will not be
> sufficient -- enumeration of the form /sys/bus/../latchY or similar
> would be prudent.
> 
> Jonathan, perhaps you have some insight here. From a functional aspect,
> latches are not unique to counter devices, so I wonder if the IIO
> subsytem has already encountered similar functionality amongst its
> drivers. Essentially, a latch is just a memory buffer provided by the
> device.

As mentioned above, they exist but are fairly rare, unless you think
of time triggers as being in this category in which case any data
ready signal is basically like this.  Ignoring that common case,
we map them onto a device specific trigger (one that has a
validate_device callback to check it's being assigned to that right device).
Another case where we do odd things like this is SoC ADCs that support touch
screen type functionality.  In those case we are grabbing data only when
the screen is touched.


> 
> For the TI eQEP device here, the buffer for each latch provides a single
> read-only value that is updated by the device; the update behavior can
> be configured by respective control registers. However, it's not so
> far-fetched to assume that there a other devices out that that have
> buffers spanning multiple latched values storing historical data.

A fifo filled on 'index' event or similar would indeed be a reasonable
bit of hardware to build.  I've world with PLC code that does this sort
of things so the requirements are there (tracking products on a conveyor
belt would be a classic case - you latch the count when a light gate is
broken).

> 
> Because a latch can theoretically provide any sort of data, not
> necessary count values, it seems reasonable that supporting latches
> would involve their own interface independent of the Counter paradigm.
> How that interface looks is the question. Should the TI eQEP latches
> here be exposed through some sort of generic latches interface, or
> would it be better to have a more abstract representation of what these
> latches are for; e.g. if these latches are used to measure speed, then
> some sort of IIO speedometer interface might be appropriate).

I'd suggest trying to avoid being too generic about this.  There might
be some reason to do it in the future but trying to define interfaces
across subsystems is a pain.  More likely we'll get some bridging
type drivers to map between different abstractions if they are needed.

Jonathan

> 
> William Breathitt Gray

