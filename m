Return-Path: <linux-iio+bounces-15926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E278A405F8
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 08:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C619970028A
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 07:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD551FFC73;
	Sat, 22 Feb 2025 07:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2GipyJY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8993BA53;
	Sat, 22 Feb 2025 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740207693; cv=none; b=uly2GXVeSNL98rgfIuksq6mJnPZ8WGnOLeFqzFJavnX9u09iSOMBHnkYz62XmxxHbKeiF71lgpBSRi8yMuzvCurMicaYqy5IMx9dFFVuC6nr8m8NEgbYAZsDirX3NGia5ThrGmhexFLR+BJgm2/i+DRJ00s50WLJTwTTh4VHF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740207693; c=relaxed/simple;
	bh=H4jdMRxo1QjBWmBc/XIad1TOgfrF2BAX7T+Pj7rAqnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbX9cF6szgtYm3y6InJWmMVsFu6hxmjHKWVdAw+7sSsrTPeVKFq/CEcHxsdSeb8PfTDcKKDZ5qh7MHQ1/7I0VNNGL9YBQo26yb6jUQ6ZV93GoAVasCo7+BfSvGigOtf7F0iemhDn5/UWB3ATYT7Fpsp7sZGoznDSZQ6AiRR44mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2GipyJY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f22fe8762so1413629f8f.2;
        Fri, 21 Feb 2025 23:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740207690; x=1740812490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZgaXAfibSbQ7l2mvjMR0J8qG7gm2e4rN1eNLdGzk9c=;
        b=h2GipyJY/0vYL6L+8RSi+LCRisEdme7gfv7djpQYKgoouwTjmzrLF2a+/9+9PDp1SE
         9htPhNZKnE/uyYF7JlyIRFWwU/9douozxN4+40uxZPU4JUf9bv+ZbV4mNQlKCcJxhD33
         wT7xMJ1wmZ6bPOzwlgonVkfs024lGw5z6NSuH6htMuFqbDOlNhWIV41gfKIJ+twDm/KC
         93XKUQIJ1PLgi2b/vZOhYk2557bdSgsro9a3oyGTVjmsmE85MpJwYB8fcySKYY/+fcNH
         Gs3W1m85KmeXoXhJp/5EPx7IGqlm+i+Q3w6fpc0C6MA+G+ZcfVq0HbykdLXLQRoiX7wq
         fYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740207690; x=1740812490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZgaXAfibSbQ7l2mvjMR0J8qG7gm2e4rN1eNLdGzk9c=;
        b=oe4OeZR1Mss42r/Btk9JLxtI/nv/dHgr7FNww8gYn4difcvARTffuE7c3nD+z+gVNf
         c65JEQY+0xsCIovPpA7Ix/qi4eiKjMimLLL/0P9g28p/G/xVjD8pMiHIYeWDAdgqVKMT
         tNUnqoDnb9RSQa5qtY1qFCN6OT6UA68bnXkdX6mN13MyqckI+dEaVMBZXfG/gKyKLTOa
         j4NHf+EGiFIhGrjGoFlX0tzLcndm8HKwJRlT2E6hzUWQNwQmgJnyEtrVHKtl4QVXymqd
         UISA4lDaJfFRzmwQgPq8JOwbT62G+0mzA4pon25FNHc4RSHMBd/L7h18Ipq8gakaFk0q
         vS4g==
X-Forwarded-Encrypted: i=1; AJvYcCUqFpZn9I9oxyMP/ALOg2hVe50LcthHgSLA5r8ZC1dFjmuweISc3Ly6kFjQ4Y0tQE7uq+tmdHuxnQn+@vger.kernel.org, AJvYcCVbzgWnM+BZF9eKc3TGxjaynJEx7E32qw088oH5m+fjkgtytUvv4ZrRtH5Vyy+R9Lb7udnfs6b6diMVbw==@vger.kernel.org, AJvYcCVeYrXRsc2jX8cgq/xjVeJS7ONcRExaFRtp9YkyqbCCaVwr2M+ewq1QN4rWf+++rnFuxZlJOVgm+Cl0@vger.kernel.org, AJvYcCW04x6sfH/G7GTjVzQwnVq9H43TV1jXpnmc8JKAYva2kzXgeHzJYaSgqQeDPgB+SNr4x8Dj25Meb+BQfTso@vger.kernel.org, AJvYcCXwAiTGoi5BoGDhr+PVYPQcv7quh5CsiAZsNqF27/EIQ6TsBMmmx5x+G5G7eokT8rfLwbmuYPQlZsUX02Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwF5QOBPrRcq2ugDYJDN9m9dSOaJ/Y+56gsws5AVNAk8OaBnr0
	RmL/qRksbjS7nabtF/A0dr8qarzJ343UVAVCifYviY6pTe3eyy4KBP+YG20GwE/ixk3O4A1C6qc
	ZCKK7MaY7WtjQarUIAYvNIp30sQ4=
X-Gm-Gg: ASbGncvAwW1EifIIxvr3gxJTdfXK+JxGStqNjDgZx4YslYboW5RZPiklQrheACwRsTt
	xkXLSY3gOz50zH2D2suowLRfDZO6RjVTVA8eA1zv25H/QhF3DuN+suDk1tbJsDnCnM2EB679xMD
	ge/41VJ9da
X-Google-Smtp-Source: AGHT+IEzStifYtOl7w0GKF2BwVUJFZAktJ1NZ9hcUTHRiwa9w046uG0bAkyJ5cymoxomlrlW6FbZ4Gbbv15AaJ4zE1Q=
X-Received: by 2002:a05:6000:881:b0:38f:2b77:a9f3 with SMTP id
 ffacd0b85a97d-38f6f08b157mr3898361f8f.43.1740207689787; Fri, 21 Feb 2025
 23:01:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218132702.114669-1-clamor95@gmail.com> <20250218132702.114669-2-clamor95@gmail.com>
 <20250221203803.GA24813-robh@kernel.org>
In-Reply-To: <20250221203803.GA24813-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 22 Feb 2025 09:01:18 +0200
X-Gm-Features: AWEUYZki6IoNxhM-igHwUWvNu_ZXweCvGGjDZ5X_mIFKa8Wopm6RhDiQcCJNax8
Message-ID: <CAPVz0n2wRu3X82nrnEac+XP+Q8uQMVwBLhGUaoqOLLf-V5dZfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: Document TI LM3533 MFD
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 21 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 22:38 Rob =
Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Feb 18, 2025 at 03:26:59PM +0200, Svyatoslav Ryhel wrote:
> > Add bindings for the LM3533 - a complete power source for
> > backlight, keypad, and indicator LEDs in smartphone handsets.
> > The high-voltage inductive boost converter provides the
> > power for two series LED strings display backlight and keypad
> > functions.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../devicetree/bindings/mfd/ti,lm3533.yaml    | 231 ++++++++++++++++++
> >  1 file changed, 231 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lm3533.yam=
l
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml b/Doc=
umentation/devicetree/bindings/mfd/ti,lm3533.yaml
> > new file mode 100644
> > index 000000000000..83542f0c7bf7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
> > @@ -0,0 +1,231 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/ti,lm3533.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI LM3533 Complete Lighting Power Solution
> > +
> > +description: |
>
> Use '>' rather than '|' if only formatting is paragraphs.
>

yaml check did not complain, fine.

> > +  The LM3533 is a complete power source for backlight,
> > +  keypad, and indicator LEDs in smartphone handsets. The
> > +  high-voltage inductive boost converter provides the
> > +  power for two series LED strings display backlight and
> > +  keypad functions.
>
> Wrap lines at 80
>

Checkpatch and yaml check do not complain, why? 80 char limit was removed, =
no?

> blank line here
>
> > +  https://www.ti.com/product/LM3533
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,lm3533
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  enable-gpios:
> > +    description: GPIO to use to enable/disable the backlight (HWEN pin=
).
> > +    maxItems: 1
> > +
> > +  ti,boost-ovp-microvolt:
> > +    description:
> > +      Boost OVP select (16V, 24V, 32V, 40V)
> > +    enum: [ 16000000, 24000000, 32000000, 40000000 ]
> > +    default: 16000000
> > +
> > +  ti,boost-freq-hz:
> > +    description:
> > +      Boost frequency select (500KHz or 1MHz)
> > +    enum: [ 500000, 1000000 ]
> > +    default: 500000
> > +
> > +  light-sensor@0:
> > +    type: object
> > +    description:
> > +      Properties for an illumination sensor.
> > +
> > +    properties:
> > +      compatible:
> > +        const: ti,lm3533-als
> > +
> > +      reg:
> > +        const: 0
> > +
> > +      ti,resistor-value-ohm:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: |
>
> Don't need '|'. Elsewhere too.
>
> > +          Internal configuration resister value when ALS is in Analog =
Sensor
> > +          mode and PWM mode is disabled.
> > +        minimum: 1575
> > +        maximum: 200000
> > +
> > +      ti,pwm-mode:
> > +        type: boolean
> > +        description: |
> > +          Switch for mode in which ALS is running. If this propertly i=
s
> > +          set then ALS is running in PWM mode, internal resistor value=
 is
> > +          set to high-impedance (0) and resistor-value-ohm propertly i=
s
> > +          ignored.
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +
> > +    additionalProperties: false
>
> Move this above 'properties'.
>

yaml check did not complain. additionalProperties is always set after
all properties description, no?

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +  - enable-gpios
> > +
> > +patternProperties:
> > +  "^backlight@[01]$":
> > +    type: object
> > +    description:
> > +      Properties for a backlight device.
> > +
> > +    $ref: /schemas/leds/backlight/common.yaml#
> > +
> > +    properties:
> > +      compatible:
> > +        const: ti,lm3533-backlight
> > +
> > +      reg:
> > +        description: |
> > +          The control bank that is used to program the two current sin=
ks. The
> > +          LM3533 has two control banks (A and B) and are represented a=
s 0 or 1
> > +          in this property. The two current sinks can be controlled
> > +          independently with both banks, or bank A can be configured t=
o control
> > +          both sinks with the led-sources property.
> > +        minimum: 0
> > +        maximum: 1
> > +
> > +      default-brightness: true
> > +
> > +      ti,max-current-microamp:
> > +        description:
> > +          Maximum current in =E6=B8=99 with a 800 =E6=B8=99 step.
> > +        enum: [ 5000, 5800, 6600, 7400, 8200, 9000, 9800,
> > +                10600, 11400, 12200, 13000, 13800, 14600,
> > +                15400, 16200, 17000, 17800, 18600, 19400,
> > +                20200, 21000, 21800, 22600, 23400, 24200,
> > +                25000, 25800, 26600, 27400, 28200, 29000,
> > +                29800 ]
> > +        default: 5000
> > +
> > +      ti,pwm-config-mask:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: |
> > +          Control Bank PWM Configuration Register mask that allows to =
configure
> > +          PWM input in Zones 0-4
> > +          BIT(0) - PWM Input is enabled
> > +          BIT(1) - PWM Input is enabled in Zone 0
> > +          BIT(2) - PWM Input is enabled in Zone 1
> > +          BIT(3) - PWM Input is enabled in Zone 2
> > +          BIT(4) - PWM Input is enabled in Zone 3
> > +          BIT(5) - PWM Input is enabled in Zone 4
> > +
> > +      ti,linear-mapping-mode:
> > +        description: |
> > +          Enable linear mapping mode. If disabled, then it will use ex=
ponential
> > +          mapping mode in which the ramp up/down appears to have a mor=
e uniform
> > +          transition to the human eye.
> > +        type: boolean
> > +
> > +      ti,hardware-controlled:
> > +        description: |
> > +          Each backlight has its own voltage Control Bank (A and B) an=
d there are
> > +          two HVLED sinks which by default are linked to respective Ba=
nk. Setting
> > +          this property will link both sinks to a Control Bank of back=
light where
> > +          property is defined.
> > +        type: boolean
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +
> > +    additionalProperties: false
> > +
> > +  "^led@[0-3]$":
> > +    type: object
> > +    description:
> > +      Properties for a led device.
> > +
> > +    $ref: /schemas/leds/common.yaml#
> > +
> > +    properties:
> > +      compatible:
> > +        const: ti,lm3533-leds
> > +
> > +      reg:
> > +        description:
> > +          4 led banks
> > +        minimum: 0
> > +        maximum: 3
> > +
> > +      linux,default-trigger: true
> > +
> > +      ti,max-current-microamp:
> > +        description:
> > +          Maximum current in =E6=B8=99 with a 800 =E6=B8=99 step.
> > +        enum: [ 5000, 5800, 6600, 7400, 8200, 9000, 9800,
> > +                10600, 11400, 12200, 13000, 13800, 14600,
> > +                15400, 16200, 17000, 17800, 18600, 19400,
> > +                20200, 21000, 21800, 22600, 23400, 24200,
> > +                25000, 25800, 26600, 27400, 28200, 29000,
> > +                29800 ]
> > +        default: 5000
> > +
> > +      ti,pwm-config-mask:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Same descryption and function as for backlight.
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +
> > +    additionalProperties: false
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        led-controller@36 {
> > +            compatible =3D "ti,lm3533";
> > +            reg =3D <0x36>;
> > +
> > +            enable-gpios =3D <&gpio 110 GPIO_ACTIVE_HIGH>;
> > +
> > +            ti,boost-ovp-microvolt =3D <24000000>;
> > +            ti,boost-freq-hz =3D <500000>;
> > +
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            backlight@0 {
> > +                compatible =3D "ti,lm3533-backlight";
> > +                reg =3D <0>;
> > +
> > +                ti,max-current-microamp =3D <23400>;
> > +                default-brightness =3D <113>;
> > +                ti,hardware-controlled;
> > +            };
>
> Please make the example complete.
>
> > +        };
> > +    };
> > +...
> > --
> > 2.43.0
> >

