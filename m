Return-Path: <linux-iio+bounces-16282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0C7A4C054
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 13:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62AEC3A6998
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7097A20FAB5;
	Mon,  3 Mar 2025 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rnDLM9T3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0581D5CD9
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004932; cv=none; b=lLPYlvzjHnGQXw5kgzj1XNfoM6ujR/RSlZGj7mjLNjbm+1B8ayufbRFTmX/UkfDKD8ivzOkpNNWAICXO5A/3OSb9Ra9fHJ4fZ7h74/HawEYiSVZ6KKHvUQZjaFFmzVPTHbQ+OJbUo39VE73uQVYHEEKVV/A+mky6y6/00dzc99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004932; c=relaxed/simple;
	bh=OJuD4nh5qDduoT1qMA986Nis1xRS6yZJndL3RjVGrBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3qyTNwAapXVKZY1SpKRqNfuNRdNkEQX5ummD9+PPnFxbrsjdbzrCZyaeTfse0a7mUS2fNI1ygcX2MxsI2BveR1jtD/XsWLS3Pk2P7r+BYMXa7yLvIC9Iwo2wCKkxWdsKMzVMICqWCdfEbUEIdUGWCUPWHTzxgpKbcqyFPwDFV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rnDLM9T3; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30613802a04so44914421fa.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 04:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741004927; x=1741609727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuV4Heg6y327cT5t8SADpvVNAjdpje5FChTnyyX6MR8=;
        b=rnDLM9T30dqi2nFxFqxEffcwEATPUkSk6ERFeJ6YyB95qzmFsNGQ5qGBgRruUkJ9pt
         6+XjnkrHuyR0WNi3/RNmnWDTZSZlAq/ydeYJTi78CAwSV/VqbrEtA2j4UlKEOjdOexi5
         KRIsBL5nFk81W8SMvF7dypWNikBt8dIeGa2BLMn9cH9PV1p87OdvE9fXBs4+UT5w/T1y
         dN8nqeGG5DAZdXGk30ndui+FE1YYZCKcVY8E/BwbLIRitQrPSvTwLQVHfiqUBdBDGSb7
         vQJnDTQemmoYelv4AI/N+SaM6YXlk/yzZdlIWZDMJlV9rvleF4qE47SVR6rlXmvBFhAa
         sJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741004927; x=1741609727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuV4Heg6y327cT5t8SADpvVNAjdpje5FChTnyyX6MR8=;
        b=bEa+as3mXedQjUmlp+LzDJkrwhVQjrqMS1sAYoqarwQCXW25fqP4t+7pO+KRjHxRLw
         i3W8iQ0axNIgEKIzzUu9itfazu67r55/UP9ARMCVAqWFmoqL0XhuN1OAWujBu6gzESq1
         DwamD/pZvh0OqM9vujGxCJMPtwObnJhdttW+u+Acv42qHxjFdUcRTqrz1zgA27t/CI0/
         1OjNrQNTdplDuBWMA1GHjyVciy0fkpMs2HPJ6nX/2RbbjXN7+Oq/rQhUrQdCUTb3BBjY
         CMPXyxKGoFxa3KNQuRzbwmK2qc/0fgXdPv09zj/Gd5XCc6VjeJNC2wNMj5KI9B/XEC4u
         KMfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbEp1eoE1CiD1erPusfFmN2Bzb4cr9gdopRL9CYlrssBYYB0PnaJOwIaG9uEI9+OQqfbsLt8Mo4xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt1J3oc8pUf83E/ATznpOOgSENzpIYbkzEjk3khX3wdtNXxmce
	gsCs6MXNrZKNvrTRLKBj8H9Xoo5w0uABq9HHTtNysgTK4qSF1A+49EbjkWO1imDEdMh568ozUa0
	y/7YFhs9serIx6mR9F48l9hBEh3+LBXk1PWnyjA==
X-Gm-Gg: ASbGnctYR3NZVYsYeAi/zBvuKRREZZfBFxNjkA2IuPGFdIGQLi0+VDLnbimi8fgUOF5
	gFkM854O5JRYUFVznSIx/W5aqzVlgm8xWFKfQepoBzt2RdFNk/0pLjPjKEf3uWMFXgBphjxHy5/
	Q4+VdA7xivBcH992Nygj1uxmUvrA==
X-Google-Smtp-Source: AGHT+IFQjWCVfYvVjqrhiYeoVVCii+BCnHEEwspsU3nYkgMsvxbUiPrrpwMddXZrBO2cTKjwXbjtGrEtQ/qF9ee0CR4=
X-Received: by 2002:a05:651c:198d:b0:30b:b3a1:d390 with SMTP id
 38308e7fff4ca-30bb3a1eec1mr15314461fa.16.1741004926495; Mon, 03 Mar 2025
 04:28:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227162823.3585810-1-david@protonic.nl> <20250227162823.3585810-7-david@protonic.nl>
 <7b2a8d71-9d83-4d40-903b-ba7ef1c686f3@baylibre.com> <20250303122253.26fec335@erd003.prtnl>
In-Reply-To: <20250303122253.26fec335@erd003.prtnl>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 3 Mar 2025 13:28:35 +0100
X-Gm-Features: AQ5f1Jp_SOcTl9D-8tg4bO9crBJVLRBfADMprZjGHDyBqnvNsQnEZS-pyxe1y-E
Message-ID: <CAMknhBFoRoaXWBL-vDnDrepqw_KJ-VrYeOoGJfjz8q=wDNM6xA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/7] dt-bindings: motion: Add adi,tmc5240 bindings
To: David Jander <david@protonic.nl>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Sorry if you get this twice. I don't have my regular computer today
and didn't realize I was sending HTML the first time. Resending in
plain text so the lists pick it up.)

On Mon, Mar 3, 2025 at 12:22=E2=80=AFPM David Jander <david@protonic.nl> wr=
ote:
>
>
> Dear David,
>
> On Fri, 28 Feb 2025 16:38:51 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On 2/27/25 10:28 AM, David Jander wrote:
> > > Add device-tree bindings for Analog Devices TMC5240 stepper controlle=
rs.
> > >
> > > Signed-off-by: David Jander <david@protonic.nl>
> > > ---
> > >  .../bindings/motion/adi,tmc5240.yaml          | 60 +++++++++++++++++=
++
> > >  1 file changed, 60 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/motion/adi,tmc5=
240.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/motion/adi,tmc5240.yam=
l b/Documentation/devicetree/bindings/motion/adi,tmc5240.yaml
> > > new file mode 100644
> > > index 000000000000..3364f9dfccb1
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/motion/adi,tmc5240.yaml
> > > @@ -0,0 +1,60 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/motion/adi,tmc5240.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices TMC5240 Stepper Motor controller
> > > +
> > > +maintainers:
> > > +  - David Jander <david@protonic>
> > > +
> > > +description: |
> > > +   Stepper motor controller with motion engine and SPI interface.
> >
> > Please include a link to the datasheet.
>
> Will do.
>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,tmc5240
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> >
> > I assume that this is the overvoltage output (OV pin). Would be nice to=
 have
> > a description here saying that. There are also NAO and DIAG0/1 output p=
ins, so
> > it's a bit ambiguous otherwise.
>
> This is the DIAG0 output pin which on this chip has a dual function as ei=
ther
> a STEP output or an interrupt output. The pin name is a bit misleading, b=
ut it
> is the "interrupt" function that is meant here. The datasheet documents a=
ll
> the different events that can trigger this interrupt.
> I will add a description to clarify this.
>

If it makes sense that other pins could possibly ever be connected to
interrupts then we can add those and also add interrupt-names (but
only if there is more than one possible interrupt).

> > > +
> > > +  enable-supply:
> > > +    description: Optional external enable supply to control SLEEPn p=
in. Can
> > > +      be shared between several controllers.
> > > +
> >
> > This doesn't look like a supply, but krzk already discussed that. But t=
here
> > should be actual power supplies: vs-supply, vdd1v8-supply, vcc-io-suppl=
y. And
> > a reference voltage supply: iref-supply
>
> I have added vs-supply and vcc-io-supply to the binding. These are the on=
ly
> supply pins that can be connected to the outside world or otherwise be of
> concern to the software.
>
> vdd1v8-supply is an internal power rail that must not have a connection t=
o the
> outside of the chip (besides an external filtering capacitor) and also do=
esn't
> have any bearing to the software at all. It cannot be disabled, adjusted =
or
> anything, so I don't think it needs to be mentioned.
>
> IREF isn't a supply pin. It is merely a pin for connecting an external
> reference resistor that is used internally for current scaling and it too=
 has
> no interaction with the software in any way.
>

Ah, I read the datasheet too quickly.

> The resistor connected to the IREF pin (Rref) OTOH does have an implicati=
on to
> the software, as it sets the full-range current of the output stage.
>
> How should we specify that? Is it adequate to add an optional DT property
> "rref" or "rref-ohm" with an int32 value in Ohm? The default value if
> unspecified is 12000 Ohm.

It looks like there are a few standardized properties, like
sense-resistor-ohms if that fits the use case. Otherwise, an
vendor-specific ti,rref-ohms would work. FYI, you can find the
preferred units at [1].

[1]: https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas=
/property-units.yaml

>
> > And if there are any pins would make sense to connect to a gpio, we can=
 add
> > those even if the driver doesn't use it currently.
> >
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - clocks
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > +  - $ref: /schemas/motion/common.yaml#
> >
> > If we need to know about what is connected to the output of a motor con=
troller
> > I would expect it to be done with child node for each output. That way =
each
> > output can be unique, if needed. Basically, similar to iio/adc.yaml is =
used to
> > provide common properties for channel@ child nodes on iio devices.
>
> This controller chip only has one single output for one stepper motor (4
> wires). While technically you could connect something else to those 4 wir=
es, I
> don't think it is the scope of LMC to support that. The chip itself isn't
> designed for that purpose and it would clearly go far beyond the intended
> purpose of this device.
>
> That being said, your suggestion of supporting child nodes may actually b=
e a
> good idea. Right now, we specify the type of motor (basically nominal- an=
d hold
> current settings) in user-space and set the IRUN/IHOLD parameters from
> user-space via the sysfs attributes interface. It might make sense to hav=
e a DT
> child node to specify this, although in our current application this is n=
ot
> very practical, since there are many motor controllers on one board, and =
it is
> configurable in software (runtime) which motor is connected to which outp=
ut.
>
> But I can imagine a situation where it may be fixed and thus can be descr=
ibed
> in the DT of a board.
>
> Then again I don't know if it would be over-complicating things with some=
thing
> like this:
>
>         motor-controller@0 {
>                 ...
>                 motor@0 {
>                         compatible =3D "nanotec,st4118s1006";
>                         irun-ma =3D <1800>;
>                         ihold-ma =3D <270>;
>                 };
>         };
>
> where we'd possibly have a stepper-motors.c file with a lot of structs an=
d
> matching tables for the different motor types.... sounds like overkill to=
 me,
> but maybe not?

A compatible for motors seems too much. I was just thinking along the
lines that 1) if we need to so some scaling or something that depends
on a motor constant, then it would make sense to put those constants
in the DT and 2) if there is a motor controller with more than one
output that could be connected to two or more different sizes of
motors with different constants, then we either need child nodes or an
array to be able to enter the different constants. Either one would
work. So maybe simpler to just use an array instead of child nodes now
that I'm thinking about it more.

>
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    spi {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        motor@0 {
> >
> > motor-controller@ or actuator-controller@
> >
> > The chip is the controller/driver, it is not a motor.
>
> Make sense. Will change this.
>
> > > +            compatible =3D "adi,tmc5240";
> > > +            reg =3D <0>;
> > > +            interrupts-extended =3D <&gpiok 7 0>;
> > > +            clocks =3D <&clock_tmc5240>;
> > > +            enable-supply =3D <&stpsleepn>;
> > > +            spi-max-frequency =3D <1000000>;
> > > +        };
> > > +    };
>
> Best regards,
>
> --
> David Jander

