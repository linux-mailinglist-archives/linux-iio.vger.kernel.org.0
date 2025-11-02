Return-Path: <linux-iio+bounces-25808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBB5C28F3F
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 13:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 248274E5B07
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E78A27EFFA;
	Sun,  2 Nov 2025 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGDrS39r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8FB1F5F6;
	Sun,  2 Nov 2025 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762087055; cv=none; b=nTGahLPJ9xqw63NAkaii0fFlRJjTQqg7hCLNRYbGrJjVrDy8ntQkz2tgkdGie6kyiwC/Vt8Z0Kov4YxoVRlX2INbyfT6JHTIcE1nABddlETXj2K50dk/+wurR0K9gpcNS0Plc/8tO/2XM5wR1D5kIfImp8+STNdlkss342EwshU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762087055; c=relaxed/simple;
	bh=rP3Ut9VUZbK8NEAr9WzP7R+2DKbuOFd36IZ2axgA4CE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyLUKiRGLw2TJvl90veQ2NGsGFH/Xih2jxIrxxzjX5KTse2bOzW00CgxacnH/r7t3lJiHEhlATrZzAPDS3xAlsh+/PYWfxin/tTxK/x3WvkM6mYoU4R2SYkR873QNdEMvATbHWMcfMTdMbp5NdheIrXoQU2J6DzIZuSnbT6m5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGDrS39r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E105C4CEF7;
	Sun,  2 Nov 2025 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762087054;
	bh=rP3Ut9VUZbK8NEAr9WzP7R+2DKbuOFd36IZ2axgA4CE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IGDrS39rRKOdQS534H9pfRnMLOKskZ6BlsEsJpHb9NFfxFsdEDsmq6jVaBG6Gk1dT
	 Kflluz9IKa6Xhf7bM1cWupwOG1FWja6h7QwJjcfHfArxEoeUGAFraUkQnBeccLZoSJ
	 48ci5fxBknFPxSxJ3y41a2ruPWAfB4r/iITlc6JpW+mf/KFy8VXjVebdkFSp8g7V/G
	 xYZDqzqxCW5bX8YOx3iuJkhb08AE8qyOab9D2T6Ish9LfKKHSeUgiN8xVTSleNxcfe
	 f3+fKispkOb1kD3neKelQhuM4oVXEI/dgpSQgbFHMqDV/7zfp+hRX6M9gt/R+ISvmv
	 Vv+aUx7P6e6gg==
Date: Sun, 2 Nov 2025 12:37:27 +0000
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
Message-ID: <20251102123727.0aa4c031@jic23-huawei>
In-Reply-To: <skcjf6tdo7bktdx4g2bm42gkzd5vdtckxsxzgu7s6dwmiwfdpw@hxhol4g4adcs>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
	<20251013-staging-ad4062-v1-2-0f8ce7fef50c@analog.com>
	<20251018162113.002d92f7@jic23-huawei>
	<skcjf6tdo7bktdx4g2bm42gkzd5vdtckxsxzgu7s6dwmiwfdpw@hxhol4g4adcs>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 16:31:46 +0100
Jorge Marques <gastmaier@gmail.com> wrote:

> On Sat, Oct 18, 2025 at 04:21:13PM +0100, Jonathan Cameron wrote:
> > On Mon, 13 Oct 2025 09:28:00 +0200
> > Jorge Marques <jorge.marques@analog.com> wrote:
> >   
> > > This adds a new page to document how to use the ad4062 ADC driver.
> > > 
> > > Signed-off-by: Jorge Marques <jorge.marques@analog.com>  
> > Hi Jorge,
> > 
> > Various comments inline.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> Hi Jonathan,
> 
> > > ---
> > >  Documentation/iio/ad4062.rst | 89 ++++++++++++++++++++++++++++++++++++++++++++
> > >  MAINTAINERS                  |  1 +
> > >  2 files changed, 90 insertions(+)
> > > 
> > > diff --git a/Documentation/iio/ad4062.rst b/Documentation/iio/ad4062.rst
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..b486d7fe1916d2963c94581be3696cf58d51ca48
> > > --- /dev/null
> > > +++ b/Documentation/iio/ad4062.rst
> > > @@ -0,0 +1,89 @@
> > > +.. SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +=============
> > > +AD4062 driver
> > > +=============
> > > +
> > > +ADC driver for Analog Devices Inc. AD4060/AD4062 devices. The module name is
> > > +``ad4062``.
> > > +
> > > +Supported devices
> > > +=================
> > > +
> > > +The following chips are supported by this driver:
> > > +
> > > +* `AD4060 <https://www.analog.com/AD4060>`_
> > > +* `AD4062 <https://www.analog.com/AD4062>`_
> > > +
> > > +Wiring modes
> > > +============
> > > +
> > > +The ADC is interfaced through an I3C bus, and contains two programmable GPIOs.  
> > This raises a question on whether it makes sense for the binding to support providing
> > gpios from the start (as alternative to interrupts).  Seems like the two pins
> > are completely interchangeable so one might well be 'left' for use by some other
> > device that needs a gpio pin.
> > 
> > I don't mind that much if we want to leave the binding support for that for later
> > but in the ideal case we'd have it from the start (even if the driver doesn't
> > support it until we have a user).  
> 
> Yep, they are almost interchangeable except GP0 cannot be DEV_DRY (device is
> ready to accept serial interface communications). The question is how to
> represent that in the devicetree.
> 
> I am ok with adding `gpio-controller` as an optional property. If
> present, and if the gp0/1 is not taken by the interrupt-names property,
> it fallback to expose as a gpo0 (they cannot be set as gpi).
> 
> For the other roles, based on
> https://elixir.bootlin.com/linux/v6.18-rc3/source/Documentation/devicetree/bindings/hwmon/adi,ltc4282.yaml#L109
> We would have
> 
>   adi,gp0-mode = "dev-en";
>   adi,gp1-mode = "rdy";
> 
> Some examples:
> 
>   // gp0: threshold-either (default), gp1: data ready (default)
>   adc@0,2ee007c0000 {
>       reg = <0x0 0x2ee 0x7c0000>;
>       vdd-supply = <&vdd>;
>       vio-supply = <&vio>;
>       ref-supply = <&ref>;
> 
>       interrupt-parent = <&gpio>;
>       interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
>                    <0 1 IRQ_TYPE_EDGE_FALLING>;
>       interrupt-names = "gp0", "gp1";
>   };
> 
>   // gp0: user GPO, gp1: data ready
>   adc@0,2ee007c0000 {
>       reg = <0x0 0x2ee 0x7c0000>;
>       vdd-supply = <&vdd>;
>       vio-supply = <&vio>;
>       ref-supply = <&ref>;
> 
>       gpio-controller;
> 
>       interrupt-parent = <&gpio>;
>       interrupts = <0 1 IRQ_TYPE_EDGE_FALLING>;
>       interrupt-names = "gp1";
>   };
> 
>   // gp0: threshold crossed high value, g1: unused
>   adc@0,2ee007c0000 {
>       reg = <0x0 0x2ee 0x7c0000>;
>       vdd-supply = <&vdd>;
>       vio-supply = <&vio>;
>       ref-supply = <&ref>;
> 
>       interrupt-parent = <&gpio>;
>       interrupts = <0 0 IRQ_TYPE_EDGE_FALLING>;
>       interrupt-names = "gp0";
> 
>       adi,gp0-mode = "thresh-high"
>   };
> 
> 
> And the driver constraints the valid configurations.

More or less looks good  We have other drivers effectively doing this.
Whether we actively handle the final case or not in driver probably doesn't matter.
Wtihout the gpio-controller specified nothing can use the gpios anyway so
if we support them they simply won't get used.

I'm not sure on the gpi0-mode though.  Why is that useful? That feels like
a choice the driver should make dependent on what is available to it.
So if we've specified it is in interrupt, only the modes that might be
an interrupt are available to the driver.

The only case I can see being useful is dev_en as that's a specifically timed
control signal for the analog front end.

So a specific flag for that probably makes sense - I'm not sure if we'd
ever have an AFE where it would make sense to drive it from a hardware
signal on the ADC like this one AND from a gpio, so I don't think we need
to support binding this as a gpio in that case.

> 
> >   
> > > +
> > > +The ADC convert-start happens on the SDA rising edge of the I3C stop (P) bit
> > > +at the end of the read command.
> > > +
> > > +The two programmable GPIOS are optional and have a role assigned if present in
> > > +the devicetree:
> > > +
> > > +- GP1: Is assigned the role of Data Ready signal.  
> > 
> > I assume that's only the case if GP1 is provided?  If GP0 is the only one
> > we should allow use that for data ready.  As long as the DT allows that it is
> > permissible for the driver to not do so for now.
> >   
> 
> Suggested `adi,gp*-mode` should solve.
> 
> > > +
> > > +Device attributes
> > > +=================
> > > +
> > > +The ADC contains only one channel with following attributes:
> > > +
> > > +.. list-table:: Channel attributes
> > > +   :header-rows: 1
> > > +
> > > +   * - Attribute
> > > +     - Description
> > > +   * - ``in_voltage_calibscale``
> > > +     - Sets the scale factor to multiply the raw value.  
> > That's confusing.  This should be hardware 'tweak' to compensate for
> > calibration or similar.  The text doesn't make it clear where that multiply
> > is happening. Sounds too much like _scale.  
> 
> The user does raw * _scale * _calibscale to get the value in volts.

That's not ABI compliant so no general purpose user space is going to do that.
So a hard no for this being what userspace needs to apply.

I'm not particularly keen on calibscale for things other than tweaking so
that raw * _scale is in milivolts.

Normally if we have other forms of controllable scaling it's a question
of wrapping up any such scan factors into a writeable _scale.

> 
> _calibscale is 1 by default and serves two purposes:
> 
> * small hw corrections (matches ABI); or 
> * an arbitrary user set scale, ideally also for corrections, but not
>   constrained.
> 
> For the prior, the device does support computing the appropriate
> _calibscale value, but it is not implemented.
> 
> If it was implemented, it would occur once during driver initialization
> and then _calibscale default value would be approximately 1, (e.g.,
> 0.997).
> 
> >   
> > > +   * - ``in_voltage_oversampling_ratio``
> > > +     - Sets device's burst averaging mode to over sample using the
> > > +       internal sample rate. Value 1 disable the burst averaging mode.
> > > +   * - ``in_voltage_oversampling_ratio_available``
> > > +     - List of available oversampling values.
> > > +   * - ``in_voltage_raw``
> > > +     - Returns the raw ADC voltage value.
> > > +   * - ``in_voltage_scale``
> > > +     - Returs the channel scale in reference to the reference voltage  
> > 
> > Spell check needed.  Also this describes why it might take different values
> > but not the bit users care about which is the standard ABI thing of
> > Real value in mV = _raw * _scale 
> >   
> Ack, will describe
> 
>  raw * _scale * _calibscale

As above, no to this.  It must be just raw * _scale.

> 
> > > +       ``ref-supply``.
> > > +
> > > +Also contain the following device attributes:
> > > +
> > > +.. list-table:: Device attributes
> > > +   :header-rows: 1
> > > +
> > > +   * - Attribute
> > > +     - Description
> > > +   * - ``samling_frequency``  
> > 
> > Check these.. sampling_frequency.
> >   
> > > +     - Sets the sets the device internal sample rate, used in the burst
> > > +       averaging mode.  
> > 
> > It's not use otherwise?  That's unusual ABI.  I'd expect it to give
> > the right value at least when burst mode isn't used. Or is burst mode
> > the only way we do buffered capture?
> >   
> 
> It is not used otherwise, the device internal sample rate is used only
> to evenly distribute readings used in the burst averaging mode.
> There is no sampling trigger to evenly space the adc conversion reading,

In event of no internal trigger, sampling_frequency is normally
1/duration of a single scan (or sample if a per channel attribute).


> e.g.,:
> 
>   Oversampling 4, sampling ratio 2Hz
>   Sampling trigger |        |        |        |        |
>   ADC conversion   ++++     ++++     ++++     ++++     ++++
>   ADC data ready      *        *        *        *        *
> 
>   Oversampling 4, sampling ratio 1Hz
>   Sampling trigger |        |        |        |        |
>   ADC conversion   + + + +  + + + +  + + + +  + + + +  + + + +
>   ADC data ready         *        *        *        *        *
> 
> For this driver, the sampling trigger is a register access (the stop bit
> of the i3c transfer to be exact), so in buffer mode it reads as fast as
> possible.
> 
> > > +   * - ``sampling_frequency_available``
> > > +     - Lists the available device internal sample rates.
> > > +
> > > +Interrupts
> > > +==========
> > > +
> > > +The interrupts are mapped through the ``interrupt-names`` and ``interrupts``
> > > +properties.
> > > +
> > > +The ``interrupt-names`` ``gp1`` entry sets the role of Data Ready signal.
> > > +If it is not present, the driver fallback to enabling the same role as an
> > > +I3C IBI.  
> > 
> > It feels like it should be easy to use the other GPO pin in this case if that
> > is present. 
> >   
> adi-gp0-mode should solve.
> 
> I wouldn't auto-set the mode by the position in the interrupt-names
> array, but let me know your opinion.

Mode when multiple are equally valid (for a given device wiring)
is purely down to what the driver wants to do. There is no benefit in
encoding that in dt.
Thanks,

Jonathan


