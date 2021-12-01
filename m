Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC14464B4B
	for <lists+linux-iio@lfdr.de>; Wed,  1 Dec 2021 11:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhLAKNq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Dec 2021 05:13:46 -0500
Received: from mslow1.mail.gandi.net ([217.70.178.240]:56303 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbhLAKNq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Dec 2021 05:13:46 -0500
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id D3A48D1424;
        Wed,  1 Dec 2021 10:04:04 +0000 (UTC)
Received: (Authenticated sender: foss@0leil.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 19582C0015;
        Wed,  1 Dec 2021 10:03:35 +0000 (UTC)
Date:   Wed, 1 Dec 2021 11:03:33 +0100
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: document TS voltage in AXP
 PMICs
Message-ID: <20211201100333.lwvxi5aluibm4iue@fiqs>
References: <20211118141233.247907-1-boger@wirenboard.com>
 <20211118141233.247907-3-boger@wirenboard.com>
 <20211122104915.zism6uadgwxjz5d2@gilmour>
 <d1a18116-e198-1b26-d73a-36fbf31aaa81@wirenboard.com>
 <35630e89-4988-a6a9-b801-0e9e44419684@sholland.org>
 <206c2a66-42b9-7e07-66c3-6007b010c996@wirenboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <206c2a66-42b9-7e07-66c3-6007b010c996@wirenboard.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Evgeny,

On Tue, Nov 30, 2021 at 02:58:23AM +0300, Evgeny Boger wrote:
> (added linux-pm@ list and maintainers)
> 
> 
> Actually, on second though, I think it might be doable to add voltage to
> temperature conversion to this driver.
> 
> I think since the NTC thermistor belongs to the battery, not charger, the
> thermistor should be described in monitored battery node.

Then we would duplicate the code in ntc thermistor driver and battery
subsystem (or simple-battery driver I assume), instead of reusing the
ntc thermistor driver.

> So I propose to extend battery node (power/supply/battery.yaml) by adding
> something like:
> 
> thermistor-resistance-temp-table = <25 10000>, <35 6530>, ...;
> 
> This driver will then interpolate between points to report temperature.
> 

Not sure this makes sense, that's the point of the ntc thermistor driver
which does all of this already AFAICT.

The battery node already supports operating-range-celsius and
alert-celsius. This driver should read that and then ask the ntc
thermistor driver what's the voltage of the thermistor associated with
this temperature and then set the register to this value.

What's missing in the ntc thermistor driver and/or its subsystem is the
ability to request a specific temperature to voltage conversion,
unrelated to the current value of the NTC thermistor.

In my head I picture the following:

battery node ----------> axp -------------------------------> ntc
             max/min °C		request °C to V for max/min
			     <-------------------------------
				V for max/min °C

The issue I see in this is that the axp needs to have a phandle to the
ntc thermistor... which does not make much sense from DTS point of view
IMO.

Now.. we could also have the following instead by extending the battery
subsystem:

		battery node --------------> axp
				max/min °C
ntc <----------		     <-------------
	request °C to V		request °C to V
    ---------->		     -------------->
	V for max/min °C	V for max/min °C

which means the battery driver/susbystem would have a phandle to the ntc
thermistor and proxy the °C to V conversionr equest from axp to ntc and
the answer back to the axp.

Obviously, ntc would still be a consumer of axp ts iio channel to
report the battery temp to userspace.

> We can also adjust PMIC voltage thresholds based on this table and
> "alert-celsius" property already described in battery.yaml.
> 
> I think the driver should report raw TS voltage as well, because the TS pin
> can also be used as general-purpose ADC pin.
> 

Raw TS voltage is still reported with your first patch so that's fine.

We'd need to create a pinctrl driver for the AXP to handle the few pins
with multiple fonctions, but it's outside of the scope of this patch
series :)

Regarding the injected current, I don't have enough knowledge in
electronics to understand what exactly would happen to the NTC
thermistor here since it seems the current is not used anywhere in the
formula to get the ohm of the resistor which is then converted to the
actual temperature. At least in the ntc thermistor driver. Also not sure
where this injected current should be declared in the device tree, is it
a limitation of the NTC thermistor (some kind of operating range?) which
should be propagated to the AXP to make it inject more/less current
depending on the NTC thermistor?

This patch is fine in itself since it's required for doing anything more
that is currently discussed in this thread. We can continue discussing
this but I don't think it is preventing this patch to continue its
normal life and be merged :)

Reviewed-by: Quentin Schulz <foss+kernel@0leil.net>

Cheers,
Quentin
