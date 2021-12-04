Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F407D4685E4
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 16:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbhLDPYp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 4 Dec 2021 10:24:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36526 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbhLDPYo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 10:24:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3ABA60E9C;
        Sat,  4 Dec 2021 15:21:18 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 7E2BDC341C2;
        Sat,  4 Dec 2021 15:21:13 +0000 (UTC)
Date:   Sat, 4 Dec 2021 15:26:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Evgeny Boger <boger@wirenboard.com>,
        Quentin Schulz <foss+kernel@0leil.net>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: document TS voltage in AXP
 PMICs
Message-ID: <20211204152621.4f15b3d0@jic23-huawei>
In-Reply-To: <20211203204754.2ucaiiwyrvbtwgbz@earth.universe>
References: <20211118141233.247907-1-boger@wirenboard.com>
        <20211118141233.247907-3-boger@wirenboard.com>
        <20211122104915.zism6uadgwxjz5d2@gilmour>
        <d1a18116-e198-1b26-d73a-36fbf31aaa81@wirenboard.com>
        <35630e89-4988-a6a9-b801-0e9e44419684@sholland.org>
        <206c2a66-42b9-7e07-66c3-6007b010c996@wirenboard.com>
        <20211201110241.kts5caycdmzqtp3i@fiqs>
        <4fd167ed-d5dc-358a-00f5-6590f4c20a68@wirenboard.com>
        <20211203204754.2ucaiiwyrvbtwgbz@earth.universe>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 3 Dec 2021 21:47:54 +0100
Sebastian Reichel <sebastian.reichel@collabora.com> wrote:

> Hi,
> 
> On Wed, Dec 01, 2021 at 06:45:44PM +0300, Evgeny Boger wrote:
> > Hi Quentin,
> > 
> > thank you for the feedback!
> > 
> > 01.12.2021 14:02, Quentin Schulz пишет:  
> > > Hi all,
> > > 
> > > On Tue, Nov 30, 2021 at 02:58:23AM +0300, Evgeny Boger wrote:  
> > > > (added linux-pm@ list and maintainers)
> > > > 
> > > > 
> > > > Actually, on second though, I think it might be doable to add voltage to
> > > > temperature conversion to this driver.
> > > > 
> > > > I think since the NTC thermistor belongs to the battery, not charger, the
> > > > thermistor should be described in monitored battery node.
> > > > So I propose to extend battery node (power/supply/battery.yaml) by adding
> > > > something like:
> > > > 
> > > > thermistor-resistance-temp-table = <25 10000>, <35 6530>, ...;
> > > > 
> > > > This driver will then interpolate between points to report temperature.
> > > >   
> > > I disagree, I think it does not make much sense. This is already done by
> > > the NTC thermistor driver.
> > > The battery "subsystem" already provides operating-range-celsius and
> > > alert-celsius properties for that.
> > > Since the battery is linked to the AXP, all we need is to be able to ask
> > > the NTC thermistor driver to do the conversion from temperature to
> > > voltage of the two voltage values we get from the battery and use the
> > > result as threshold in the AXP registers.
> > > I wouldn't want to have the extrapolation done in two different places.
> > > 
> > > I can see two ways of specifying that interation:
> > > 
> > > battery -------------------> axp --------------------> ntc
> > > 	min/max °C			request °C to V
> > > 				 <--------------------
> > > 					response V
> > > 
> > > This however would require a phandle in the AXP to the NTC thermistor
> > > driver and I don't feel like it's that good of an idea?
> > > 
> > > Another way would be to use the battery as a proxy for the voltage
> > > request to ntc.
> > > 
> > > 		     battery --------------------> axp
> > > 				min/max °C
> > > ntc <--------------- 	     <--------------------
> > > 	request °C to V		request °C to V  
> > >      --------------->	     --------------------->  
> > > 	response V		response V
> > > 
> > > This would require a phandle to the ntc thermistor in the battery node,
> > > which kind of makes sense to me. And since the AXP already has knowledge
> > > of the battery, it can request the appropriate value to the battery
> > > which then proxies it to and back from the ntc.
> > > 
> > > Forgive me for my poor ASCII drawing skills :) hopefully it's good
> > > enough to convey my thoughts.  

If we were going to do something like this, I'd see the battery as a
consumer of the the temperature measurement from the NTC (might also consume other
things from axp directly).  So it should be

Temperature / events flow.

battery <---temperature----- NTC driver <--Voltage----   axp

Threshold configuration flow

battery --temp thresh-----> NTC driver ---volt thres--> axp

What's missing infrastructure wise is that we don't have an in kernel
interface for IIO events (i.e. the thresholds). It's been discussed
quite a few times in the past, but there has never been a strong enough
reason for anyone to have bothered implementing it.  It wouldn't be
very hard to do if we do need it.  Previous discussions concluded it is
fine to leave demux of events to the consumer unlike the main data flow.
We might refine that in future but for initial usecases that would greatly
simplify the code whilst still allowing multiple consumers from a single
device (which you would need here for example).

These flows are the same we do for data etc for things like
analog accelerometers. That accel driver is a consumer of the ADC
channels as it is using them to convert the voltages to accelerations
that it wants to then present to it's own consumers (typically userspace).


> > I see quite a few problems with NTC driver approach.
> > 
> > The problem is, I don't know any suitable subsystem for that. NTC
> > is not a subsystem, NTC in kernel is a mere hwmon driver, and also
> > is quite an old one.
> > 
> > Also, we already have iio-afe, which, in a sense, already does pretty much
> > the same as NTC
> > hwmon driver. Maybe using iio-afe is the better idea?
> > But then, I think that's a very complicated interaction for a simple
> > interpolation between points.
> > 
> > Another thing is, in our design we ended up using not a simple 10k NTC
> > thermistor, but a 10k NTC is series with fixed 2.2k.
> > The reason why it's needed is that AXP NTC voltage thresholds are fixed at
> > startup time, and if we somehow have to deal
> > with default thresholds to get different behaviour.  So the
> > resistance-temperature curve in our case is different from any standard
> > NTC. Speaking of "standard" NTC, our supplier has like 15 different models
> > for *each* resistance, which slightly differ in
> > resistance-temperature curve. Adding them all into a driver would be
> > strange.
> > 
> > Personally, I think better approach with NTCs is to place the
> > resistance-temperature tables for bunch of models to .dtsi
> > files, describe the thermistor node in DT and then make all drivers (hwmon
> > NTC, iio-afe, this one) to use this data in the same way
> > it's done with monitored-battery node.

Agreed those tables would be needed whatever the solution.  We might
stick to 'standard' tables for simple cases but someone will always wire
a circuit up that does something we haven't thought of.

> >   
> > > > We can also adjust PMIC voltage thresholds based on this table and
> > > > "alert-celsius" property already described in battery.yaml.
> > > > 
> > > > I think the driver should report raw TS voltage as well, because the TS pin
> > > > can also be used as general-purpose ADC pin.
> > > >   
> > > Since the ntc anyway needs this raw TS voltage and that patch does that,
> > > I think it's fine. Specifically, re-using this pin as a general-purpose
> > > ADC won't impact the current patchset.
> > > 
> > > What we'll need is to have a pinctrl driver for the few pins in the AXP
> > > which have multiple functions. But that's outside of the scope of this
> > > patchset.  
> > Should it really be pinctrl, though? Unfortunately the choice will alter
> > other
> > functions as well. Say, if we use TS pin in GPADC mode, we'll have to
> > disable
> > temperature thresholds and current injection.  
> > > 
> > > Regarding the injected current, I don't have enough knowledge in
> > > electronics to understand how this will change things in the thermistor
> > > since in the NTC thermistor driver there's no logic related to the
> > > actual current being injected. Maybe it is related to some operating
> > > value required by the NTC? I can't say unfortunately.  
> > It's basically Ohm's law, so it's not related to the NTC thermistor itself,
> > but more to the voltage across NTC that the AXP can measure.
> > Say, if maximum measurable voltage is 3.3V, than the maximum measurable
> > resistance
> > at the given current would be 3.3V/80uA = 41 kOhm. In case of 10k NTC it's
> > about -5C or so.
> > 
> > But again, one can't really alter startup voltage thresholds of the AXP. And
> > also, regardless of
> > settings, at least AXP221s will completely disable TS-based protection if
> > voltage on TS pin is below 0.2V.
> > So at the end, unfortunately, there are not so many options when it comes to
> > the thermistor and the injection current.  
> 
> Linus W. recently sent a series for NTC support in power-supply
> core, please synchronize with him (added to Cc):
> 
> https://lore.kernel.org/linux-pm/20211122234141.3356340-1-linus.walleij@linaro.org/
> 
> (FWIW I don't have any strong opinion about any solution)
> 
> -- Sebastian

