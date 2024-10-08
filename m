Return-Path: <linux-iio+bounces-10347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C33995561
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 19:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E456328584F
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915D61E1321;
	Tue,  8 Oct 2024 17:12:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D037708;
	Tue,  8 Oct 2024 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407526; cv=none; b=WggxSEdJ/aguMR1A28tFTYpB/IzwaGGIzMegDklyjvqJMSbOxMHvGCis5qta2LnG7h5Ul9vx+ixDqP4B/2B1VsAjPfkaDjKTf8AKtjRw4HEYvxHLti7W+IlUAZPg9tf9M5l6EiUFrAro5bX0UaJ76uBCzAZIXKOsBFNs+dKio8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407526; c=relaxed/simple;
	bh=59yKlXYBlxc/pMmSiYavJGAYttcgFjbWpTJG/QF2Z3o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bg1u7iigEncWt38z/qPdEZgLykZEcWj+84cdY3DXp5bfBp4T8lyRfq5nORTS7LN7+j8eK7uWdtNPSVB+Lsr6l1KcWLCo9Arx0mH1qwPQMzvqdWd5eccCkNJwCJ7xJuvRs8ap/TlASNEYIH+fA9hOdT3LkMBdneGdLXb1sjl1+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNMs506mSz6L784;
	Wed,  9 Oct 2024 01:07:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CADE140C98;
	Wed,  9 Oct 2024 01:11:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Oct
 2024 19:11:54 +0200
Date: Tue, 8 Oct 2024 18:11:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<rickard.andersson@axis.com>, <kernel@axis.com>
Subject: Re: [PATCH v2 0/2] Support for Texas Instruments OPT4060 RGBW Color
 sensor.
Message-ID: <20241008181151.00006abd@Huawei.com>
In-Reply-To: <3ee27b01-ca9a-4f5c-b48a-c5613139895d@axis.com>
References: <20241005165119.3549472-1-perdaniel.olsson@axis.com>
	<20241006162446.51a93744@jic23-huawei>
	<3ee27b01-ca9a-4f5c-b48a-c5613139895d@axis.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 7 Oct 2024 15:37:07 +0200
Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:

> On 10/6/24 17:24, Jonathan Cameron wrote:
> > On Sat, 5 Oct 2024 18:51:17 +0200
> > Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:
> >   
> >> This patch series adds support for Texas Instruments OPT4060 RGBW Color sensor
> >> using the i2c interface.
> >>
> >> The driver exposes both raw adc values and calculated lux values though sysfs.
> >> Integration time can be configured though sysfs as well.  
> > 
> > Lux is a unit with a particular light curve.  It has no defined meaning for
> > color channels.  As a result we usually only have colors as intensity channels
> > (unit free).  If it is possible to compute an estimate of the illuminance then
> > that can be a separate IIO_LIGHT channel.  
> 
> The thing with lux is not actually something I know much about,

https://en.wikipedia.org/wiki/Illuminance is a decent description
(though I haven't reread it today!)

Key thing is a brightness measure adjusted to take into account an
approximation of the human eye sensitivity to various wavelengths.

> I just read the
> data sheet (https://www.ti.com/lit/gpn/opt4060). According to chapter 8.4.5.2
> (page 17), lux can be calculated this way:
> 
> lux = GREEN_ADC_RAW * 2.15e-3
ouch.  
> 
> It is also stated that R=G=B for a D65 standard white light source if red is
> multiplied by 2.4 and blue is multiplied with 1.3. I interpreted this as if
> IIO_LIGHT was the best fit and that's why I didn't use IIO_INTENSITY. Should I
> change to IIO_INTENSITY?

Yes.  Light isn't typically a d65 light unfortunately (reference lights
are expensive!)

Mind you I guess if was, we'd live in a blank and white world as there
would be no colors, just shades of gray...


> 
> >   
> >> The OPT4060 sensor
> >> supports both rising and falling threshold interrupts. These interrupts are
> >> exposed as IIO events. The driver also implements an IIO triggered buffer with
> >> two triggers, one trigger for conversion ready interrupts and one trigger for
> >> threshold interrupts. The typical use case for this is to define a threshold and
> >> listen for the events, and at the same time enable the triggered buffer with the
> >> threshold trigger. Once the application gets the threshold event, the values
> >> from the time of the event will be available in the triggered buffer. This
> >> limits the number of interrupts between sensor and host and also the the usage
> >> of sysfs for reading values after events.  
> > 
> > We have had various discussions of threshold triggers in the past, but I don't
> > think we ever merged any (maybe there is one somewhere?) The reasons for that are:
> > 1) They are hard for generic userspace to understand.
> > 2) For light sensors the input tends to be slow moving - grabbing one reading
> >    on a threshold interrupt is rarely that informative (or are you grabbing them
> >    on dataready once the threshold is breached?)  
> 
> When the sensor triggers an interrupt for a threshold, it will also have the bit for
> dataready set. So the values available at that point in time are the values that
> triggered the threshold interrupt.
> 
> > 3) If we want to do threshold triggers we should really add generic infrastructure
> >    for them based on adding an in kernel events consumer path and a way to
> >    instantiate a trigger based on any event.  Doing it in a single driver creates
> >    an ABI we won't want to retain long term.
> > 
> > So how important is this feature to you and why?  Maybe it is time to finally
> > take a close look at option 3.  
> 
> Our userspace application needs the values after getting the threshold event. Before
> I implemented the threshold trigger and the triggered buffer, the application would
> read the values from sysfs right after the event. In that case the values will not be
> the ones that actually triggered the event. When the light condition is close to the
> threshold, the value from sysfs might even be on the wrong side of the threshold which
> can be confusing for the state machine in userspace. I would say that this feature is
> fairly important to us, this is the way our userspace is using the sensor.

Brutal answer is fix your state machine to drop that assumption. I'd try to clamp
the nearest to threshold to the threshold value in your userspace app. Any error
that introduces should be lost in the noise.

> 
> If I understand you correctly, the problem you see with threshold triggers is that
> it creates an implicit dependency between events and triggers. For the trigger to
> function, userspace will first have to enable the event and set the threshold. I can
> understand this issue, I think. Your suggestion with a way to instantiate triggers
> from events sounds like a potential way forward. Do you have any more thoughts on how
> that could be implemented? How can we proceed? How can I help?

Step one would be to add a general in kernel interface to get hold of events.
That would have to look a little like the in kernel access to buffers (see inkern.c)
We might be able to get away with different consumers just having to accept
they may get events they didn't ask for.  So make the consumers filter them
and the interface would just allow requesting 'more' events from a device.
That device could say no if it doesn't support the requested events in addition
to what it already has. 

That interface has a bunch of other uses such as trip points for thermal etc.

After that was done we'd also need a way to instantiate a trigger on a particular
devices' event stream + filter.  Maybe we could do it for all devices, though that is
going to be a little ugly as a lot of new triggers would turn up as in theory
we should register one for every possible event each device can create.
(imagine we want a trigger on a rising threshold and a different one to capture
something else on the falling threshold).

Alternative would be to use configfs to provide a creation path for such triggers.

So not a small job, but not really breaking any new ground, just filling in
a couple of long known to be missing features.

We might need some example tooling + a bunch of docs on how to use this as well.

Jonathan

> 
> Thank you for you comments so far, looking forward to hearing your thoughts on a way
> forward.
> 
> / P-D
> 
> > 
> > Jonathan
> >   
> >>
> >> Changes in v2:
> >> - dt-bindings: Removed incorrect allOf.
> >> - dt-bindings: Changed to generic node name.
> >> - Correction in opt4060_trigger_one_shot(...) for continuous mode.
> >> - Correction in opt4060_power_down(...), wrong register was read.
> >> - Corrected usage of active_scan_mask in opt4060_trigger_handler(...).
> >> - Clean-up of various comments.
> >> - Link to V1: https://lore.kernel.org/lkml/20241003164932.1162049-1-perdaniel.olsson@axis.com/
> >>
> >> Per-Daniel Olsson (2):
> >>   dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
> >>   iio: light: Add support for TI OPT4060 color sensor
> >>
> >>  .../bindings/iio/light/ti,opt4060.yaml        |   51 +
> >>  drivers/iio/light/Kconfig                     |   13 +
> >>  drivers/iio/light/Makefile                    |    1 +
> >>  drivers/iio/light/opt4060.c                   | 1216 +++++++++++++++++
> >>  4 files changed, 1281 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
> >>  create mode 100644 drivers/iio/light/opt4060.c
> >>
> >>
> >> base-commit: 0c559323bbaabee7346c12e74b497e283aaafef5  
> >   
> 
> 


