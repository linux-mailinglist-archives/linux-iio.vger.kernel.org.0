Return-Path: <linux-iio+bounces-14222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F584A0AA69
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC557A2C7B
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A9A1B87F1;
	Sun, 12 Jan 2025 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIC7/maf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB272F56;
	Sun, 12 Jan 2025 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736695396; cv=none; b=hYiJ3Pt14wTeRwo9H3bFz9JOB/B1uh9VLE4KPN40S2zhylsgqNMPhaMmhbUqt7xp9nafFOwb99tss1j1HecBCg+asoPcltXvfFH9b9WqMPBBIHfhgml5boLrzm+UMD0xp6N8E7ntNUU+iKZit3eAUbQFt/hR8OB6IB3hlY59PXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736695396; c=relaxed/simple;
	bh=f9U8svexXK5c8Ufd9gFrJHoqWu7DupLZYsdMd/JWmN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDqZUXffC/GFJsWGgfUZnwGaUK7MnzMdmX4IelVlCTpqhRlaBThOSQxwsma+GFWkMB293Tk5UubMu/yCy9cdpVONR5nq86EH2cQFam/61c0XBLfi6FvxBS2oTfom9tkzQP3DQL0SYun+vQN9IFfCHC/xcBiJFNPDYvzPZo3Jhxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIC7/maf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0504CC4CEDF;
	Sun, 12 Jan 2025 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736695396;
	bh=f9U8svexXK5c8Ufd9gFrJHoqWu7DupLZYsdMd/JWmN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bIC7/mafNDehGnGtsWwYz2Mprb1Ssbuu6ojtTKAczZyBEjl1vh8KyIpbqAyFpdYfC
	 ON4maxqI8m7ooXzahKD4rrIhUR79++vzpjOriakcPqa9c4NXMeMNOE2F8R4FiXuoAM
	 qo87CD56FYYRXZ8b9E9JjTgMutNIWfPjce1Rg1M4letY/NWbd1Ijfsr2pWeF429ty3
	 vzMteZimz/tNeUop5g++sfDUDZphXNDDo1NVdalsjP1ZA2T3Bc+UwaIedP7p+APHII
	 kDsu9S4zjLqjCsoHMkwEZ7cZtvNMOrGNcXQ+J9bDsXf0N6u0MBQL7cjdXcLDqjbOB3
	 bUt0Hx0GNS59w==
Date: Sun, 12 Jan 2025 15:23:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Ranquet <granquet@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/2] iio: adc: ad7173: add openwire detection
 support for single conversions
Message-ID: <20250112152309.4ee25d25@jic23-huawei>
In-Reply-To: <CABnWg9uhso0S14eQa6uF6a4wwrmiHqo4HMLxvaKhxsjeCta7Yg@mail.gmail.com>
References: <20250109-ad4111_openwire-v2-0-0372c2dde0ce@baylibre.com>
	<20250109-ad4111_openwire-v2-2-0372c2dde0ce@baylibre.com>
	<3ebe506b-17d8-4639-94e2-16ef75a221a5@baylibre.com>
	<CABnWg9uhso0S14eQa6uF6a4wwrmiHqo4HMLxvaKhxsjeCta7Yg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 05:50:45 -0500
Guillaume Ranquet <granquet@baylibre.com> wrote:

> On Thu, 09 Jan 2025 22:53, David Lechner <dlechner@baylibre.com> wrote:
> >On 1/9/25 7:55 AM, Guillaume Ranquet wrote:  
> >> Some chips of the ad7173 family supports open wire detection.
> >>
> >> Generate a threshold event whenever an external source is disconnected  
> >
> >s/threshold/"openwire"/
> >  
> >> from the system input on single conversions.  
> >
> >And also an event when reconnected.
> >
> >What about during buffered reads? Is the recommendation that we should do a
> >single conversion, check for event, do buffered read, do a single conversion,
> >check for event to ensure that a wire did not become disconnected while doing a
> >buffered read?  
> 
> With the current design of the ad7173/ad_sigma_delta, the buffered
> read enables continuous mode.
> 
> Continuous mode makes the ADC cycle through all enabled channels
> automatically.
> 
> So, enabling open wire detection during buffered reads has its own
> challenges:
> * Assigning channels gets more complicated in the current state of the
> 	driver
> * We divide the number of possible channels by two (or even three
> 	depending on the gymnastic we did when assigning channels).
> * Timing performance will suffer as twice as many conversions needs to
> 	happen
> * Accuracy might also suffer as we would need to keep
> 	AD4111_GPIO_GP_OW_EN enabled at all times.
> 
> So, I don't know what the recommendation is, but having open wire
> detection enabled during buffered reads seems complex (and is it worth
> the performance penalties?).

Whilst I'm not sure on usecases for this part, I'd go with it not being
worth it.

> 
> Another way of doing it would be to decouple open wire detection from
> single conversions and create a new channel property instead of an
> event.
> 
> The property would trigger the two conversions needed for open wire
> detection and return synchronously the current status of the channel.

That would result in some ABI that isn't particularly general,
so I'd rather not go that way.  It probably also interferes with
continuous mode anyway so doesn't gain us anything.

> 
> What happens when the user reads the "open wire" property when a
> buffered read is in progress?
> 
> * Pause the buffered read, do the open wire detection and resume?
> * Return an error signaling openwire detection doesn't work when a
> 	concurrent buffered read is in progress?

Assume openwire events are rare and just check before enabling and
after disabling buffered mode. We could do that in driver if it
turns out to be useful.  Otherwise don't bother and make it a userspace
problem.

I thought about suggesting we poll for this like we'd do for other
events where the device doesn't self clock, but it makes little sense.
We don't really care about a wire being out until we want to read.


> >> +		return;
> >> +
> >> +	adchan->cfg.openwire_comp_chan =
> >> +		openwire_ain_to_channel_pair[chan->channel][chan->differential][0];
> >> +
> >> +	ret = ad_sigma_delta_single_conversion(indio_dev, chan, &val1);
> >> +	if (ret < 0)
> >> +		goto out;
> >> +
> >> +	adchan->cfg.openwire_comp_chan =
> >> +		openwire_ain_to_channel_pair[chan->channel][chan->differential][1];
> >> +
> >> +	ret = ad_sigma_delta_single_conversion(indio_dev, chan, &val2);
> >> +	if (ret < 0)
> >> +		goto out;
> >> +
> >> +	if (abs(val1 - val2) > cfg->openwire_thrsh_raw)
> >> +		iio_push_event(indio_dev,
> >> +			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, chan->address,
> >> +						    IIO_EV_TYPE_OPENWIRE, IIO_EV_DIR_RISING),
> >> +			       iio_get_time_ns(indio_dev));
> >> +	else
> >> +		iio_push_event(indio_dev,
> >> +			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, chan->address,
> >> +						    IIO_EV_TYPE_OPENWIRE, IIO_EV_DIR_FALLING),
> >> +			       iio_get_time_ns(indio_dev));  
> >
> >Hmm... rising and falling doesn't make so much sense for an openwire event. It
> >is either "open" or "closed" and doesn't really have a direction. (The threshold
> >is just an internal implementation detail of how it is detected.)

True.

> >
> >So maybe we need new IIO_EV_DIR_ members for this too?

Silly question. Does a close wire event make any sense?  What is the usecase?
I can see short detection being useful just not 'wire plugged back in'.

I was thinking of this as detection for nasty events - repairing them is an engineer
problem who can check the actual data makes sense.  We can provide debugfs
for that if it is useful.  Everyone wants to know there is a problem but the
set of people and generality of interface needed for repair is a different
question!

We probably do need multiple "types" even so,  Open wire / short etc.

Could do
IIO_EV_TYPE_OPENWIRE
IIO_EV_TYPE_SHORT...

Or go down the gesture route and
IIO_EV_TYPE_FAULT
+
IIO_EV_DIR_OPENWIRE
IIO_EV_DIR_SHORT


(only implement what we need here though).



> >
> >I guess we could call it "opening" and "closing" to make it direction-like?
> >
> >Also, this implementation makes it a level event instead of an edge event.
> >In other words, on every single conversion, we will get an event. Usually, we
> >would keep track of the previous value and only emit an event when the state
> >changes.
For open wire, I'm fine with just squirting events out on every read.  Any detection
of this event should cause userspace to stop polling it anyway.

However, if you want to make it edge based that's fine too as long as it will
trigger on first enabling of error checking followed by a read.

> >  
> >> +
> >> +out:
> >> +	adchan->cfg.openwire_comp_chan = -1;
> >> +	regmap_clear_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, AD4111_GPIO_GP_OW_EN);
> >> +}
> >> +

> >> +static int ad7173_write_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> >> +				    enum iio_event_type type, enum iio_event_direction dir,
> >> +				    enum iio_event_info info, int val, int val2)
> >> +{
> >> +	struct ad7173_state *st = iio_priv(indio_dev);
> >> +	struct ad7173_channel *adchan = &st->channels[chan->address];
> >> +
> >> +	switch (info) {
> >> +	case IIO_EV_INFO_VALUE:
> >> +		adchan->cfg.openwire_thrsh_raw = val;  
> >
> >This difference threshold seems like an internal implementation detail of how
> >this specific chip handles open wire detection. I'm not sure that writing
> >this value to the events/in_voltageY_openwire_value attribute makes much sense
> >from an IIO ABI point of view.
> >
> >It would be OK with me to just always use 300mV for now. And if we find an
> >application where that doesn't work, consider adding an adjustment somewhere.
> >For example, we might find that it makes more sense to put this in the
> >devictree because it depends on electrical properties of the application.
> >  
> 
> The datasheet suggests 300mV, I don't know what factors could make this
> threshold change.
> I agree we could hardcode it as a first approach.

Agreed.

> 
> >> +		return 0;
> >> +
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +}
> >> +
...

> >
> >Overall, I think the way this is implemented looks reasonable. We'll see how
> >much Jonathan agrees or disagrees my comments on the ABI stuff. :-)  
You spotted the problem which was the hard bit! :)  
> 
> Thx for the review,
> Guillaume.


