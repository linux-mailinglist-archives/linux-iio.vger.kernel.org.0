Return-Path: <linux-iio+bounces-16284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF999A4C106
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 13:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012B81630E8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96021210190;
	Mon,  3 Mar 2025 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="RD38Rfrb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60907DA6C
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006483; cv=none; b=L/cGPOJ6rmLYLFfRsfNkgc5sLgnl5EWEJwgI4sIOdyBUrtcrXXbNx0pkWTMTB3Si3SaqBdYdErraez64ToIFTnPNhUDgWw0jybVe617PJg++7QPvWn4MuTOdU0AOA3jwGhyObKBppRlNKLQlI9/qGSvfI9X+uOmz6K79oi5WwhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006483; c=relaxed/simple;
	bh=rlTejGww3GQcdaCE0lGdR0xVCG5KcxUJXrQx3paY4gI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roivXjO8Cg+xD0lvJVTr4BHIH6aEqKGOnf41//tHu25pm/HfVYVqjuSgwvd2/jDnhkhQ8JelvhvYlbIFn1jpSe5Mtf6wGGkqR4IEUSz6KDh3LTCF5uKrgVPiDCIrcGj/5w/ygM4ECp0P3v+mmXmkK7mROMiFyIvuWH60CAhyFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=RD38Rfrb; arc=none smtp.client-ip=94.124.121.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=HYNOahwtKoOEdFJgHijQNkEchw/+KmIF5XNlrs66Y0A=;
	b=RD38RfrbMLHFIRCg9/+3j9jeYTiY6iP9DmgwPclo0hnp1mUtSmTcuyWMZQkjJMu1y4MbeSUCeBibS
	 L86np1SKnar/GHxF/D6QRjr3p7G1TKOaci/QnMtR39CFDCHxft0KsFqCJ1tU0XjBZMyhaTSrf3xC51
	 Axjrotmo9EjaYWxAgTPRWKRGV1b/36ArOUURfTZ9OIMPqHTNC7JqNijCVZgOgNCTPIAupWCunpT4o4
	 j0Is8xKoIIJjrNZiX6JjtBPxeVtwdA3kHT5JDZV32Ra7a3wq/AmyZVvdibQ5HMEZ2k1dTuxGNdbmxy
	 h36piBLw6uR7/h8Mtr7k9DPE3SDalmw==
X-MSG-ID: a940bcd0-f82e-11ef-b5ca-0050568164d1
Date: Mon, 3 Mar 2025 13:54:35 +0100
From: David Jander <david@protonic.nl>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 7/7] dt-bindings: motion: Add motion-simple-pwm
 bindings
Message-ID: <20250303135435.509c230f@erd003.prtnl>
In-Reply-To: <8db96db5-c258-4c42-a70a-56fdf24ecdc6@baylibre.com>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-8-david@protonic.nl>
	<8db96db5-c258-4c42-a70a-56fdf24ecdc6@baylibre.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi David,

On Fri, 28 Feb 2025 16:41:29 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/27/25 10:28 AM, David Jander wrote:
> > Add device-tree bindings for simple Linux Motion Control devices that
> > are based on 1 or 2 PWM outputs.
> > 
> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  .../bindings/motion/motion-simple-pwm.yaml    | 55 +++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml b/Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml
> > new file mode 100644
> > index 000000000000..409e3aef6f3f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml
> > @@ -0,0 +1,55 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/motion/motion-simple-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Simple PWM based motor controller  
> 
> I think it has been said many times before, in DT, there is no such thing as
> a simple device! It will be much more future-proof if we write bindings for
> actual individual motor controller chips than try to generalize all in a single
> binding. The chip you gave as an example is far from the simplest H-bridge I
> have seen!

To clarify, my intention is not to generalize all existing DC motor controllers
into one driver or dt-binding. I mentioned the drv8873, but only as an example.
Actually my plan is to make a separate driver and separate bindings for the
drv8873, but I haven't had time for that yet, and it would be too much for the
first version of LMC.

There are a lot of simple "dumb" devices though, that have integrated or even
discrete H-bridges with fixed dead-time, that can't do more than just 2 PWM
signals to control left-/right-speed. There are also lots of places where
people connect a DC motor to just a simple power-MOSFET. All of these cases can
be handled by this driver.

Maybe the name "simple-pwm" isn't adequate. Should we name it "pwm-motor" or
something liket that instead?

The intend of motion/simple-pwm.c is to be the analog of something like
these other "simple" or "generic" drivers and corresponding dt-bindings, for
example:

gpio_keys.c:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/input/keyboard/gpio_keys.c
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/input/gpio-keys.yaml

gpio-regulator.c:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/regulator/gpio-regulator.c
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml

pwm-regulator.c:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/regulator/pwm-regulator.c
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml

pwm_bl.c:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/video/backlight/pwm_bl.c
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml

etc...

Although the driver actually is simple, and intended for simple hardware.
The fact that it can even be used with more complex chips, like the drv8873, if
the requirements are simple enough, and as long as there is no dedicated
driver yet, doesn't change that fact.

> > +maintainers:
> > +  - David Jander <david@protonic>
> > +
> > +description: |
> > +   Simple motor control device based on 1 or 2 PWM outputs
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - motion-simple-pwm  
> 
> This should be e.g. ti,drv8873-q1. This device has much more pins that is given
> in these bindings.

Like I said, this driver isn't intended for the drv8873. It was merely an
example where as a matter of fact this driver could be used for the drv8873,
but that's not the intention. Sorry for not being clear. :-)

> If we find more devices that have similar functionality/pinout we can add them
> to the same bindings, but we will likely find that trying to cram all H-bridges
> into a single binding is too much.
> 
> For starters, every H-bridge chip is going to have one or more power supplies.
> ti,drv8873-q1 would need dvdd-supply and vm-supply properties for the DVDD and
> VM pins.
> 
> Many have inputs for disabling the chip, e.g. for power management. And some
> have outputs to indicate faults.
> 
> The TI DRV8873 in particular has an nSLEEP, DISABLE, nOL, SR, MODE and nITRIP
> inputs in addition to the IN1 and IN2 that would be connected to the PWMs.
> So we would have properties for all of these to either say how the pin is
> hardwired or a *-gpios property if it needs to be controlled by the driver.

Yes, sure. These will all be in the dt-binding for the drv8873. Our board
actually uses the drv8873s, which has an SPI interface, so that will of course
also be part of the bindings and of the driver.

> The fault output would generally be an interrupts property.

Ack.

> The IPROPI1 and IPROPI2 output pins look like they would be connected to an
> ADC, so it would make sense to have an io-channels property show that
> connection.

Ack. In fact, our board has these connected to the internal ADC of the SoC.

> This chip also has a SPI interface. So it needs to have the possibility of
> being a SPI peripheral node.

Sure, like I said above.

> And even if the Linux driver doesn't implement all of these features, we still
> want the DT bindings to be as complete as possible, so we shouldn't be leaving
> these out, at least for the trivial ones where there is an obvious correct
> binding (which I think is the case for most of what I suggested).

Completely agree. Will be done, but not for this first version. It is simply
too much to review, I'm afraid. It will be a separate binding, in
motion/ti,drv8873.yaml (not included in this version).

> > +
> > +  pwms:
> > +    maxItems: 2
> > +
> > +  pwm-names:
> > +    maxItems: 2  
> 
> Specifying what is wired up to the IN pins can be tricky. Using two PWMs is
> the most sensible. But I've also seen devices where there was a single PWM
> gated by two gpios. And for very basic H-bridges, there might not even be a
> PWM. Just gpios to turn it on or off.

That would be something for a future motion/gpio-motor.yaml, I guess.

> > +
> > +  motion,pwm-inverted:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      If present, this flag indicates that the PWM signal should be inverted.
> > +      The duty-cycle will be scaled from 100% down to 0% instead 0% to 100%.
> > +
> > +required:
> > +  - compatible
> > +  - pwms
> > +
> > +allOf:
> > +  - $ref: /schemas/motion/common.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    // This example shows how to use the TI DRV8873 or similar motor controllers
> > +    // with this driver
> > +    motion-simple-pwm0 {
> > +      compatible = "motion-simple-pwm";
> > +      pwms = <&hpdcm0_pwm 0 50000 0>,
> > +             <&hpdcm0_pwm 1 50000 0>;
> > +      pwm-names = "left", "right";
> > +      motion,pwm-inverted;  
> 
> 
> > +      motion,speed-conv-mul = <3600>;
> > +      motion,speed-conv-div = <100000>;
> > +      motion,acceleration-conv-mul = <3600>;
> > +      motion,acceleration-conv-div = <100000>;  
> 
> This H-bridge controller doesn't have any kind of speed sensors that I can see
> so these properties don't make sense to me. The H-bridge can control the voltage
> sent to the motor, but there are more variables involved to convert voltage to
> speed. It isn't a constant.

Sure. In the most basic case, when there is no feedback signal for speed (like
an encoder for example), the best thing you can do is assume an (imperfect)
relation between duty-cycle and motor speed. That's what these factors are for.

You could have a reduction gearbox even, so specifying some parameters for the
user-space software to work with seems sensible. If you leave them out, the
default values are used, which are all 1's, basically making the "speed" value
equal to the (scaled) duty-cycle of the PWMs.

The driver scales duty-cycle to 1/1000th of a percent, which seemed a sensible
resolution to use and be intuitive enough, since due to the lack of floating
point numbers in the kernel, it is common practice to scale values by a factor
of 1000 to enhance resolution. If you prefer, we could also use
parts-per-million, or ppm (1/1,000,000).

With this in mind, setting the PWM outputs to 100% duty-cycle
(0% if inverted), would correspond to setting a motor speed of 3600 in the
case of the example scaling values given in the bindings.

Best regards,

-- 
David Jander

