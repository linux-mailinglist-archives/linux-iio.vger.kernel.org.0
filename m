Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0832F464C48
	for <lists+linux-iio@lfdr.de>; Wed,  1 Dec 2021 12:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbhLALGI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Dec 2021 06:06:08 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:47045 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhLALGI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Dec 2021 06:06:08 -0500
Received: (Authenticated sender: foss@0leil.net)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 529F11C0015;
        Wed,  1 Dec 2021 11:02:43 +0000 (UTC)
Date:   Wed, 1 Dec 2021 12:02:41 +0100
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
Message-ID: <20211201110241.kts5caycdmzqtp3i@fiqs>
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

Hi all,

On Tue, Nov 30, 2021 at 02:58:23AM +0300, Evgeny Boger wrote:
> (added linux-pm@ list and maintainers)
> 
> 
> Actually, on second though, I think it might be doable to add voltage to
> temperature conversion to this driver.
> 
> I think since the NTC thermistor belongs to the battery, not charger, the
> thermistor should be described in monitored battery node.
> So I propose to extend battery node (power/supply/battery.yaml) by adding
> something like:
> 
> thermistor-resistance-temp-table = <25 10000>, <35 6530>, ...;
> 
> This driver will then interpolate between points to report temperature.
> 

I disagree, I think it does not make much sense. This is already done by
the NTC thermistor driver.
The battery "subsystem" already provides operating-range-celsius and
alert-celsius properties for that.
Since the battery is linked to the AXP, all we need is to be able to ask
the NTC thermistor driver to do the conversion from temperature to
voltage of the two voltage values we get from the battery and use the
result as threshold in the AXP registers.
I wouldn't want to have the extrapolation done in two different places.

I can see two ways of specifying that interation:

battery -------------------> axp --------------------> ntc
	min/max °C			request °C to V
				 <--------------------
					response V

This however would require a phandle in the AXP to the NTC thermistor
driver and I don't feel like it's that good of an idea?

Another way would be to use the battery as a proxy for the voltage
request to ntc.

		     battery --------------------> axp
				min/max °C
ntc <--------------- 	     <--------------------
	request °C to V		request °C to V
    --------------->	     --------------------->
	response V		response V

This would require a phandle to the ntc thermistor in the battery node,
which kind of makes sense to me. And since the AXP already has knowledge
of the battery, it can request the appropriate value to the battery
which then proxies it to and back from the ntc.

Forgive me for my poor ASCII drawing skills :) hopefully it's good
enough to convey my thoughts.

> We can also adjust PMIC voltage thresholds based on this table and
> "alert-celsius" property already described in battery.yaml.
> 
> I think the driver should report raw TS voltage as well, because the TS pin
> can also be used as general-purpose ADC pin.
> 

Since the ntc anyway needs this raw TS voltage and that patch does that,
I think it's fine. Specifically, re-using this pin as a general-purpose
ADC won't impact the current patchset.

What we'll need is to have a pinctrl driver for the few pins in the AXP
which have multiple functions. But that's outside of the scope of this
patchset.

Regarding the injected current, I don't have enough knowledge in
electronics to understand how this will change things in the thermistor
since in the NTC thermistor driver there's no logic related to the
actual current being injected. Maybe it is related to some operating
value required by the NTC? I can't say unfortunately.

We can continue this discussion but I don't think this should block this
patch as I don't see the outcome of this discussion change anything in
this patchset.

Reviewed-by: Quentin Schulz <foss+kernel@0leil.net>

Thanks!
Quentin
