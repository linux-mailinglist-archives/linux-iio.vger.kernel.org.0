Return-Path: <linux-iio+bounces-16258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAC1A4BE68
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1588216372C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E04F1EE008;
	Mon,  3 Mar 2025 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="mdDLG9XM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB481F1818
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000986; cv=none; b=HNZyUj+OJAte+NTF8mlgT/vL6/pIPmUriyUzT/23UjH03LHMgoisDZRkQQBI/6GPxFKJHdCX5rQY31zi7PSfktK7+gzoK1CLUAcg7VARGmQ9DvpbonZ9SlizZM8J+sHju2/eGBdZynNDUj0QMFEO1Ejzt7s4hEuv+SxMqcYY9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000986; c=relaxed/simple;
	bh=T2/0vtnTHd+jEFQfmJdgjKR4ED0aLjzFr+5YOFGUjfc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBWIPbmaoxhQt8l5X5HdusvfFlyHJgEP13LPhLnLUJW25xGICf/iHsOgILSI1F4nAjne/fhHbn/1dXrzHpZHBc3MxSvcpfEn0Rc5mLbGJe30JCFEYKKoFCdNPOfSLBoDj717hS9lLEnVPKsrM9cT0VJE9txzde0ToQ1bZI7M4z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=mdDLG9XM; arc=none smtp.client-ip=94.124.121.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=aYFQrbEXcXVk/RpIHRvcbpzo0ainO+2MV7BBazpXsNM=;
	b=mdDLG9XM0xS9qj5ouZGMgE2pJs8KIO/BmCLOeQMwUL/EXNFTiOwgcmHWoIXfe3uRIpD1NwN9ln3OF
	 suxAAa8B6RWYwQt0AuquyhZUvUNwseS5QGFqvCfCy3xbMtfrMEzRvKSfcM3kYguX+ehQljA2AIva79
	 nSsb0ildy3B/CED0f3d8EltoRBaNIVoRm+JfVgmh61D8zOpmy9Na1hRV/UAloxOHguJD34xyZ2DCiU
	 XB6CwcWvgb/yy5I89E0NjS5dohCWASUkfhBpPO6+cltyv4mRvL2HUrObBqA8dHu/778elJk48WCk8d
	 78w71JpZw8fQ3Gtl7e1x30RqWWOy9Zg==
X-MSG-ID: d9a8e41c-f821-11ef-b5ca-0050568164d1
Date: Mon, 3 Mar 2025 12:22:53 +0100
From: David Jander <david@protonic.nl>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 6/7] dt-bindings: motion: Add adi,tmc5240 bindings
Message-ID: <20250303122253.26fec335@erd003.prtnl>
In-Reply-To: <7b2a8d71-9d83-4d40-903b-ba7ef1c686f3@baylibre.com>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-7-david@protonic.nl>
	<7b2a8d71-9d83-4d40-903b-ba7ef1c686f3@baylibre.com>
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


Dear David,

On Fri, 28 Feb 2025 16:38:51 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/27/25 10:28 AM, David Jander wrote:
> > Add device-tree bindings for Analog Devices TMC5240 stepper controllers.
> > 
> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  .../bindings/motion/adi,tmc5240.yaml          | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/motion/adi,tmc5240.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/motion/adi,tmc5240.yaml b/Documentation/devicetree/bindings/motion/adi,tmc5240.yaml
> > new file mode 100644
> > index 000000000000..3364f9dfccb1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/motion/adi,tmc5240.yaml
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/motion/adi,tmc5240.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices TMC5240 Stepper Motor controller
> > +
> > +maintainers:
> > +  - David Jander <david@protonic>
> > +
> > +description: |
> > +   Stepper motor controller with motion engine and SPI interface.  
> 
> Please include a link to the datasheet.

Will do.

> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,tmc5240
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1  
> 
> I assume that this is the overvoltage output (OV pin). Would be nice to have
> a description here saying that. There are also NAO and DIAG0/1 output pins, so
> it's a bit ambiguous otherwise.

This is the DIAG0 output pin which on this chip has a dual function as either
a STEP output or an interrupt output. The pin name is a bit misleading, but it
is the "interrupt" function that is meant here. The datasheet documents all
the different events that can trigger this interrupt.
I will add a description to clarify this.

> > +
> > +  enable-supply:
> > +    description: Optional external enable supply to control SLEEPn pin. Can
> > +      be shared between several controllers.
> > +  
> 
> This doesn't look like a supply, but krzk already discussed that. But there
> should be actual power supplies: vs-supply, vdd1v8-supply, vcc-io-supply. And
> a reference voltage supply: iref-supply

I have added vs-supply and vcc-io-supply to the binding. These are the only
supply pins that can be connected to the outside world or otherwise be of
concern to the software.

vdd1v8-supply is an internal power rail that must not have a connection to the
outside of the chip (besides an external filtering capacitor) and also doesn't
have any bearing to the software at all. It cannot be disabled, adjusted or
anything, so I don't think it needs to be mentioned.

IREF isn't a supply pin. It is merely a pin for connecting an external
reference resistor that is used internally for current scaling and it too has
no interaction with the software in any way.

The resistor connected to the IREF pin (Rref) OTOH does have an implication to
the software, as it sets the full-range current of the output stage.

How should we specify that? Is it adequate to add an optional DT property
"rref" or "rref-ohm" with an int32 value in Ohm? The default value if
unspecified is 12000 Ohm.

> And if there are any pins would make sense to connect to a gpio, we can add
> those even if the driver doesn't use it currently.
> 
> > +  clocks:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +  - $ref: /schemas/motion/common.yaml#  
> 
> If we need to know about what is connected to the output of a motor controller
> I would expect it to be done with child node for each output. That way each
> output can be unique, if needed. Basically, similar to iio/adc.yaml is used to
> provide common properties for channel@ child nodes on iio devices.

This controller chip only has one single output for one stepper motor (4
wires). While technically you could connect something else to those 4 wires, I
don't think it is the scope of LMC to support that. The chip itself isn't
designed for that purpose and it would clearly go far beyond the intended
purpose of this device.

That being said, your suggestion of supporting child nodes may actually be a
good idea. Right now, we specify the type of motor (basically nominal- and hold
current settings) in user-space and set the IRUN/IHOLD parameters from
user-space via the sysfs attributes interface. It might make sense to have a DT
child node to specify this, although in our current application this is not
very practical, since there are many motor controllers on one board, and it is
configurable in software (runtime) which motor is connected to which output.

But I can imagine a situation where it may be fixed and thus can be described
in the DT of a board.

Then again I don't know if it would be over-complicating things with something
like this:

	motor-controller@0 {
		...
		motor@0 {
			compatible = "nanotec,st4118s1006";
			irun-ma = <1800>;
			ihold-ma = <270>;
		};
	};

where we'd possibly have a stepper-motors.c file with a lot of structs and
matching tables for the different motor types.... sounds like overkill to me,
but maybe not?

> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        motor@0 {  
> 
> motor-controller@ or actuator-controller@
> 
> The chip is the controller/driver, it is not a motor.

Make sense. Will change this.

> > +            compatible = "adi,tmc5240";
> > +            reg = <0>;
> > +            interrupts-extended = <&gpiok 7 0>;
> > +            clocks = <&clock_tmc5240>;
> > +            enable-supply = <&stpsleepn>;
> > +            spi-max-frequency = <1000000>;
> > +        };
> > +    };

Best regards,

-- 
David Jander

