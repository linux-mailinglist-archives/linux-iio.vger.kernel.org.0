Return-Path: <linux-iio+bounces-26055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536F0C43D98
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 13:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7DC3A673F
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 12:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35272EC547;
	Sun,  9 Nov 2025 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6tkKY49"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774CC2459EA;
	Sun,  9 Nov 2025 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762691522; cv=none; b=BR9BTNxkO+Rv8Uu6YMcnAbSB+SHXdjF2F5KHG9u/rkMAEyURQVsT9X/UGyszXi23gDSJ17zmrLXrkG366YaSHaq7xPJshscG8zUEvkA7g0/kAjxD+UFFUd8wGn4cFdEO/vaSiOrLaVawI0VV5c46KsBZ1lzxnJyMEPr9ea6XNZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762691522; c=relaxed/simple;
	bh=LGYTQwUkxBt0o3+LvefP3AgSY4sePqqHapsIYEqlCeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaKyIrhL7DBcIP7NBjpDl35v9mZ2Mr2kC16zFmSsJgdya4ohM78wBME2uGOLXNC4qdVSlcPVJoRAv1Uda7J2S3+MjcXKdhFn9eUf2Iim+XLO4rExGq99z8PHPXjFIE6QGSmZM4SqcUn9SVkDgQ7JSg7m/rOinncAvwODfDIRO/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6tkKY49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E899C4CEF8;
	Sun,  9 Nov 2025 12:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762691522;
	bh=LGYTQwUkxBt0o3+LvefP3AgSY4sePqqHapsIYEqlCeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I6tkKY49wEmejIHJanVAPCGscv0SznQrStzJWzGXtM/MoGWmHg6UVTTLkWJybZ+Lh
	 4UMm5gGx0I9XSQACiITsQ9qryP+EArrVwQ2Hb1f1g6F1GcQVpQLa9OEIaBI1lhVMex
	 hn2ZwrsUYrHnG3yk/s79Hlug4tSxh/7uK6qVOv9sa/5dHE9I8wFOXPfWel6OiUTeLf
	 29OSW64+0xwA2mWRrjYmYIWpsgVJS18ajVZJ/mGF7vV9AxtbnJty+qCktnxWMNOi0X
	 a4Jwk1jBcT7ggA2MiHvGkX22fAhQxp+wknU5gXoQVMt22wh5KY6NrccPXfYo43ZghL
	 EFRCI8UKkm74A==
Date: Sun, 9 Nov 2025 12:31:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/7] docs: iio: New docs for ad4062 driver
Message-ID: <20251109123153.65cea85a@jic23-huawei>
In-Reply-To: <6zxwgpdz6zz3owrr5h277otv4b3gbbc47amgatkyatjdv2ruqv@kgsekg6utqqc>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
	<20251013-staging-ad4062-v1-2-0f8ce7fef50c@analog.com>
	<20251018162113.002d92f7@jic23-huawei>
	<skcjf6tdo7bktdx4g2bm42gkzd5vdtckxsxzgu7s6dwmiwfdpw@hxhol4g4adcs>
	<20251102123727.0aa4c031@jic23-huawei>
	<6zxwgpdz6zz3owrr5h277otv4b3gbbc47amgatkyatjdv2ruqv@kgsekg6utqqc>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > > > +Supported devices
> > > > > +=================
> > > > > +
> > > > > +The following chips are supported by this driver:
> > > > > +
> > > > > +* `AD4060 <https://www.analog.com/AD4060>`_
> > > > > +* `AD4062 <https://www.analog.com/AD4062>`_
> > > > > +
> > > > > +Wiring modes
> > > > > +============
> > > > > +
> > > > > +The ADC is interfaced through an I3C bus, and contains two programmable GPIOs.    
> > > > This raises a question on whether it makes sense for the binding to support providing
> > > > gpios from the start (as alternative to interrupts).  Seems like the two pins
> > > > are completely interchangeable so one might well be 'left' for use by some other
> > > > device that needs a gpio pin.
> > > > 
> > > > I don't mind that much if we want to leave the binding support for that for later
> > > > but in the ideal case we'd have it from the start (even if the driver doesn't
> > > > support it until we have a user).    
> > > 
> > > Yep, they are almost interchangeable except GP0 cannot be DEV_DRY (device is
> > > ready to accept serial interface communications). The question is how to
> > > represent that in the devicetree.
> > > 
> > > I am ok with adding `gpio-controller` as an optional property. If
> > > present, and if the gp0/1 is not taken by the interrupt-names property,
> > > it fallback to expose as a gpo0 (they cannot be set as gpi).
> > > 
> > > For the other roles, based on
> > > https://elixir.bootlin.com/linux/v6.18-rc3/source/Documentation/devicetree/bindings/hwmon/adi,ltc4282.yaml#L109
> > > We would have
> > > 
> > >   adi,gp0-mode = "dev-en";
> > >   adi,gp1-mode = "rdy";
> > > 
> > > Some examples:
> > > 
> > >   // gp0: threshold-either (default), gp1: data ready (default)
> > >   adc@0,2ee007c0000 {
> > >       reg = <0x0 0x2ee 0x7c0000>;
> > >       vdd-supply = <&vdd>;
> > >       vio-supply = <&vio>;
> > >       ref-supply = <&ref>;
> > > 
> > >       interrupt-parent = <&gpio>;
> > >       interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> > >                    <0 1 IRQ_TYPE_EDGE_FALLING>;
> > >       interrupt-names = "gp0", "gp1";
> > >   };
> > > 
> > >   // gp0: user GPO, gp1: data ready
> > >   adc@0,2ee007c0000 {
> > >       reg = <0x0 0x2ee 0x7c0000>;
> > >       vdd-supply = <&vdd>;
> > >       vio-supply = <&vio>;
> > >       ref-supply = <&ref>;
> > > 
> > >       gpio-controller;
> > > 
> > >       interrupt-parent = <&gpio>;
> > >       interrupts = <0 1 IRQ_TYPE_EDGE_FALLING>;
> > >       interrupt-names = "gp1";
> > >   };
> > > 
> > >   // gp0: threshold crossed high value, g1: unused
> > >   adc@0,2ee007c0000 {
> > >       reg = <0x0 0x2ee 0x7c0000>;
> > >       vdd-supply = <&vdd>;
> > >       vio-supply = <&vio>;
> > >       ref-supply = <&ref>;
> > > 
> > >       interrupt-parent = <&gpio>;
> > >       interrupts = <0 0 IRQ_TYPE_EDGE_FALLING>;
> > >       interrupt-names = "gp0";
> > > 
> > >       adi,gp0-mode = "thresh-high"
> > >   };
> > > 
> > > 
> > > And the driver constraints the valid configurations.  
> >   
> 
> Hi Jonathan,
> 
> A comment on the gpio modes and sampling frequency.
> Ack on `raw * _scale`.
> 
> > More or less looks good  We have other drivers effectively doing this.
> > Whether we actively handle the final case or not in driver probably doesn't matter.
> > Wtihout the gpio-controller specified nothing can use the gpios anyway so
> > if we support them they simply won't get used.
> > 
> > I'm not sure on the gpi0-mode though.  Why is that useful? That feels like
> > a choice the driver should make dependent on what is available to it.
> > So if we've specified it is in interrupt, only the modes that might be
> > an interrupt are available to the driver.
> > 
> > The only case I can see being useful is dev_en as that's a specifically timed
> > control signal for the analog front end.
> > 
> > So a specific flag for that probably makes sense - I'm not sure if we'd
> > ever have an AFE where it would make sense to drive it from a hardware
> > signal on the ADC like this one AND from a gpio, so I don't think we need
> > to support binding this as a gpio in that case.
> >   
> 
> So, by default gp0 is set threshold-either, and gp1 data ready.
> The `adi,gp*-mode` would be useful to invert for example, have gp0 as
> data ready and gp1 as threshold-either.
> 
> On the threshold, there are 3 different crossings:
> * either: the reading crosses either the upper or lower boundary.
> * max: crosses the upper boundary.
> * min: crosses the lower boundary.
> 
> To not make the `adi,gp*-mode` attribute necessary I can:
> * make the driver set either, max, min roles based on the
>   values written to the IIO attributes, e.g. writing -1 for
>   IIO_EV_INFO_HYSTERESIS, or a max/min value high/low enough?

This confuses me a little. Which direction do the thresholds apply in?
Looks from the datasheet like these are standard in that
crossing the min threshold triggers the interrupt when the value
goes below that threshold (and hysteresis means the detector doesn't
reset until the value goes above min + hysteresis)
So for that it's a falling threshold with normal hysteresis.

For the max on it will be a rising threshold with hysteresis applying below
that. The ABI docs describe this directional use of hysteresis.
Either case seems to correspond to both other interrupts enabled at the
same time.  Helpfully it's the or of the control bits so easy to support
as no obvious coupling between them.  They seem to have separate status
bits as well.


> * dev_en use case is to shutdown/turn-on an AFE, amplifiers,
>   but I wouldn't support in this series.

Often that can be tied to runtime PM, but I agree that is better
left for a future series.

> 
> So, I believe the solution for the dt-binding is add the optional
> `gpio-controller`, and if set, expose the unused (not in the
> interrupts-names) as GPOutput. And not support inversion gp0<->gp1 of
> the mode, the specific threshold crossing (max, min, either), nor the
> dev_en use case.
> 
> This then doesn't change the series much, just appends a commit adding
> the gpio-controller support.
Agreed.

...

> 
> > >   
> > > > > +       ``ref-supply``.
> > > > > +
> > > > > +Also contain the following device attributes:
> > > > > +
> > > > > +.. list-table:: Device attributes
> > > > > +   :header-rows: 1
> > > > > +
> > > > > +   * - Attribute
> > > > > +     - Description
> > > > > +   * - ``samling_frequency``    
> > > > 
> > > > Check these.. sampling_frequency.
> > > >     
> > > > > +     - Sets the sets the device internal sample rate, used in the burst
> > > > > +       averaging mode.    
> > > > 
> > > > It's not use otherwise?  That's unusual ABI.  I'd expect it to give
> > > > the right value at least when burst mode isn't used. Or is burst mode
> > > > the only way we do buffered capture?
> > > >     
> > > 
> > > It is not used otherwise, the device internal sample rate is used only
> > > to evenly distribute readings used in the burst averaging mode.
> > > There is no sampling trigger to evenly space the adc conversion reading,  
> > 
> > In event of no internal trigger, sampling_frequency is normally
> > 1/duration of a single scan (or sample if a per channel attribute).
> > 
> >   
> 
> The duration of a single scan (duration between the convert-start high
> edge until RDY falling edge), would be ((n_avg - 1) / fosc + tconv)
> (datasheet fig.56, p.31) , where fosc is the internal timer frequency
> directly exposed in this series. I can make the driver use this formula,
> just setting it will be less straight forward, since currently a clear
> enum of the values the register supports is returned by the
> sampling_frequency_available attribute. Instead, it will scale based on
> the number of samples per burst (averaging ratio/n_avg). tconv is typ
> 270ns and max 320ns.

Agreed this can get a bit fiddly :( 

There are also some slightly nasty race conditions around updating
available attributes.  We had a solution for that a while back but
I'm not sure what happened to it and the complexity only really applies
when using in kernel consumers for those values rather than sysfs where
we can apply a driver local lock.

That n_avg seems to be oversampling - hence indeed we have to deal
with the affect of that on the sampling frequency (it's documented
in the ABI as sampling frequency is for the total time for oversampling
to deliver data).

Jonathan


