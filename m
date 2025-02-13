Return-Path: <linux-iio+bounces-15483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B3AA337F6
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 07:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 918BF7A3BC0
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 06:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC4F207A1D;
	Thu, 13 Feb 2025 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4B6blvA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83116207641;
	Thu, 13 Feb 2025 06:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428078; cv=none; b=AsXbdA9fcignhyhhMIkVSD/J1Oly9SgG0lYLNTkP+mEwZFhgRaBQtH5DYzXQxa6plWOodpryHRdQuNVcTo2/NBIQ5lCvbAxKDmM/luKgBs3SntOI7CO7Ah0aZuM/4UEyu/vZM7O65y22NAXIODbKqjUooEEroxzDZxhawiAWwAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428078; c=relaxed/simple;
	bh=/ITHLgy9JYrnb84+uFgHUA5tidkL9hWALUk8ObVqab8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImxK5oAunCbG8tjNFB9FKPJA9z+FXC0HadAi32iUcPey/S+p9yVT0ddm9dXemFD0VMVpf/d0+wfzf59fJsalHlXsECy1Tg6YurUmSqU4kFg+CZNWzzDzXam9NrAk0YPSefv3C+WuTlQ6g2b5/fy+/Et9YSFncQagAZggv2GqgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4B6blvA; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f22fe889aso278960f8f.3;
        Wed, 12 Feb 2025 22:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739428075; x=1740032875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOzwMl8VwHYfyLhIMZVPabSmX4hCvOI4+kS23hOataA=;
        b=d4B6blvAcgBEkF8PskjpLe7uR5BSu4Xd/uGftz8wkaYn8rtsNEQLXUl55cETS3F9RR
         AIW6X0MIh1NF5KP2hfkGfBqpgUFtLJkWfYjXG12heAK+F1nbgck4DHWULhyxEJNYZ4kK
         RDbyf6f2tmhmA4cBiXmVT95v3BtNC7c7m/b0TKxYsAFZKBKKVku5O3EvHY42gkJsdWW6
         p4Ia7RiqUB1zHEaPFI0U+UwYL5ZgpHTukESnnmA3jIBJ+Bucvv3wNkw+NAzMdn0Sg8Ly
         va2yMGoCL0BNRqsnM9hzVojeAqsMXxpKcToUt0syGsK0e8BIKMEVHZAoxLhbAcu0OOTO
         SPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739428075; x=1740032875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOzwMl8VwHYfyLhIMZVPabSmX4hCvOI4+kS23hOataA=;
        b=eowXEO/GgFNSfM2ib19BlSyJy/D+hm3VDeVofhThSi4a7SqZkqp6jGdjXTQsLVR4lD
         pb98XzeTAdx16wAkhPbhEdUsJzGyzLS2ZehL5DW4HTeCBTt/pXs5iSAnvDeI3pLJ+DY8
         tYVqduywwTiNLkHAlk/8qHff/agTfdo/CVSfy9Km9oH0j9jYCzSAX43eVjnOF47TlVVz
         LXoqcBaiMc8EgLQpxXec6alLNDAQ0ImelcnsEHlddtt9RfrwpuPAbhqVywPF2uXRuLiC
         DdlSvtorT9HT0QTP7ZH1pNuEN4WQcuZ0bn/zWWNu0g84As7rySn/KT8RFiQCKViUQUKn
         Ng1w==
X-Forwarded-Encrypted: i=1; AJvYcCV5NGZGXGmV5hxbM7Ui82gGH9udXBFjhLcXKqvFYE3A4wdZ7u3sJabqrnBQG3kocflpQ1Aa3g6lA5yVvKbl@vger.kernel.org, AJvYcCVzjFn1yijuYw2nU4SuF0CmYvQ8jbprXZLUtfdO3nz/dhYXRn/NrKUGLPsuoPdl1RFvi/MpCO1kBK3PWw==@vger.kernel.org, AJvYcCWhklCF3Bb6LveHmdCE0D+IhDIBheT83NSeTgw/2woWP8lAPkvVmPJoiKRO0v3f1YLkS4Hj3WdzgomM@vger.kernel.org, AJvYcCWyVJ8XkTMhaemhDk590NBQ5hL7/LXRWr+0mtE3L7EE+Yl7hhkkZ+/tUB7aiXNtM+vjxRmqBY6YpYom/ro=@vger.kernel.org, AJvYcCX9EmEuOJJP4kHRwADFM71yCbW4S4JdFGRJgoeMQu/5x85tML+FV8Dq24QjP6MFiT5IK00+6yokELMa@vger.kernel.org
X-Gm-Message-State: AOJu0YwXlYxBn06kxFUKHqQent6I9TF84V4XiT3bSHJICLs4BnZbbnCl
	GUxWVTUOch10uu2/slZrwHzcgxma0ySJPdWHp/aJKPbGiZCLSy3uO5S/jtJyvqnGsp7zwY7dlr5
	O7OvQA6pksg9QojszMbuOJSICqco=
X-Gm-Gg: ASbGncsdLCuZEgfVEBFWwqBVbfkGL4UP0tgRKZKwNfePJ/xLOgaUP5uBn9Y93w0xsO5
	bIbPNlRnvEGsu5Ez8jA858o8T1vO564F9b3e9W+M41EvGe/EjyW+guRgdKmQNaeVe86GDst3m8A
	==
X-Google-Smtp-Source: AGHT+IGd3aSb6EVJT9y79hOBqqnlYiGX2mzwTicjMhOTwe0xN57IDbNmeue9tZ+J44tqG/5xONzLJq2CfewOMFhktjk=
X-Received: by 2002:a5d:588a:0:b0:38f:2073:14a7 with SMTP id
 ffacd0b85a97d-38f24526be2mr2020172f8f.47.1739428074400; Wed, 12 Feb 2025
 22:27:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212075845.11338-1-clamor95@gmail.com> <20250212075845.11338-2-clamor95@gmail.com>
 <20250212-reprint-underfed-fd723ebf3df3@spud>
In-Reply-To: <20250212-reprint-underfed-fd723ebf3df3@spud>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 13 Feb 2025 08:27:43 +0200
X-Gm-Features: AWEUYZmuyAB8gQ5te2zUGxj5B78TV5g_h5KsY5EeG0lXC_QDun0uHJ9JminpPgQ
Message-ID: <CAPVz0n0-ywJfoXBwQ5H8z7831kHFxbCMfsibanSRNGMoghAkGg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: mfd: Document TI LM3533 MFD
To: Conor Dooley <conor@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 12 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 21:49 Cono=
r Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 12, 2025 at 09:58:41AM +0200, Svyatoslav Ryhel wrote:
> > Add bindings for the LM3533 - a complete power source for
> > backlight, keypad, and indicator LEDs in smartphone handsets.
> > The high-voltage inductive boost converter provides the
> > power for two series LED strings display backlight and keypad
> > functions.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../devicetree/bindings/mfd/ti,lm3533.yaml    | 221 ++++++++++++++++++
> >  include/dt-bindings/mfd/lm3533.h              |  19 ++
> >  2 files changed, 240 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lm3533.yam=
l
> >  create mode 100644 include/dt-bindings/mfd/lm3533.h
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml b/Doc=
umentation/devicetree/bindings/mfd/ti,lm3533.yaml
> > new file mode 100644
> > index 000000000000..d0307e5894f8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
> > @@ -0,0 +1,221 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/ti,lm3533.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI LM3533 Complete Lighting Power Solution
> > +
> > +description: |
> > +  The LM3533 is a complete power source for backlight,
> > +  keypad, and indicator LEDs in smartphone handsets. The
> > +  high-voltage inductive boost converter provides the
> > +  power for two series LED strings display backlight and
> > +  keypad functions.
> > +  https://www.ti.com/product/LM3533
> > +
> > +maintainers:
> > +  - Johan Hovold <jhovold@gmail.com>
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
> > +  ti,boost-ovp:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Boost OVP select (16V, 24V, 32V, 40V)
> > +    enum: [ 0, 1, 2, 3 ]
> > +    default: 0
> > +
> > +  ti,boost-freq:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Boost frequency select (500KHz or 1MHz)
> > +    enum: [ 0, 1 ]
> > +    default: 0
>
> Properties like these should be in units, so some standard voltage-based
> one for the boost and in hertz for the second. See property-units.yaml
> in dt-schema.
>
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
> > +    properties:
> > +      compatible:
> > +        const: lm3533-backlight
>
> Missing vendor prefix
>
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
> > +      max-current-microamp:
> > +        description:
> > +          Maximum current in =C2=B5A with a 800 =C2=B5A step.
> > +        enum: [ 5000, 5800, 6600, 7400, 8200, 9000, 9800,
> > +                10600, 11400, 12200, 13000, 13800, 14600,
> > +                15400, 16200, 17000, 17800, 18600, 19400,
> > +                20200, 21000, 21800, 22600, 23400, 24200,
> > +                25000, 25800, 26600, 27400, 28200, 29000,
> > +                29800 ]
> > +        default: 5000
> > +
> > +      default-brightness:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Default brightness level on boot.
> > +        minimum: 0
> > +        maximum: 255
> > +        default: 255
> > +
> > +      pwm:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Default pwm level on boot.
> > +        minimum: 0
> > +        maximum: 63
> > +        default: 0
>
> Why is default-brightness /and/ a default for pwm needed? If the pwm
> drives the backlight, wouldn't you only need one of these two?
>
> If it stays, I think it needs a rename to be more clear about what it is
> doing. "pwm" is very close to "pwms", the property used for phandles to
> pwm providers but the use is rather different.
>
> backlight/common.yaml has standard properties that you could be using,
> so I'd expect to see a ref here, rather than redefining your own
> version.
>
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
> > +    properties:
> > +      compatible:
> > +        const: lm3533-leds
>
> Ditto here re: compatible.
>
> > +
> > +      reg:
> > +        description:
> > +          4 led banks
> > +        minimum: 0
> > +        maximum: 3
> > +
> > +      max-current-microamp:
> > +        description:
> > +          Maximum current in =C2=B5A with a 800 =C2=B5A step.
> > +        enum: [ 5000, 5800, 6600, 7400, 8200, 9000, 9800,
> > +                10600, 11400, 12200, 13000, 13800, 14600,
> > +                15400, 16200, 17000, 17800, 18600, 19400,
> > +                20200, 21000, 21800, 22600, 23400, 24200,
> > +                25000, 25800, 26600, 27400, 28200, 29000,
> > +                29800 ]
> > +        default: 5000
> > +
> > +      default-trigger:
> > +        $ref: /schemas/types.yaml#/definitions/string
> > +        description: |
> > +          This parameter, if present, is a string defining
> > +          the trigger assigned to the LED. Check linux,default-trigger=
.
> > +
> > +      pwm:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Default pwm level on boot.
> > +        minimum: 0
> > +        maximum: 63
> > +        default: 0
>
> Same applies here, leds/common.yaml has some of these already.
>
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +
> > +    additionalProperties: false
> > +
> > +  "^light-sensor@[0]$":
>
> Not a pattern if it can only have 1 outcome.
>
> > +    type: object
> > +    description:
> > +      Properties for an illumination sensor.
> > +
> > +    properties:
> > +      compatible:
> > +        const: lm3533-als
> > +
> > +      reg:
> > +        const: 0
> > +
> > +      resistor-value:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: |
> > +          PWM resistor value a linear step in currents
> > +          of 10 =C2=B5A per code based upon 2V/R_ALS.
> > +        minimum: 1
> > +        maximum: 127
> > +        default: 1
> > +
>
> I'd expect a resistor to be measured in ohms of some sort,
> hard to tell what the increments actually are here, they don't appear to
> be a real unit. Are they register values?
>
> This and all other custom properties need to have a vendor prefix on
> them btw.
>
> > +      pwm-mode:
> > +        type: boolean
> > +        description: Mode in which ALS is running
>
> Are there multiple pwm modes? Or is this trying to say that, if set, the
> sensor is in pwm mode? Hard to tell from the description here, sorry.
>
> Cheers,
> Conor.
>

Acknowledged, thank you.

>
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
> > +    #include <dt-bindings/mfd/lm3533.h>
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
> > +            ti,boost-ovp =3D <LM3533_BOOST_OVP_24V>;
> > +            ti,boost-freq =3D <LM3533_BOOST_FREQ_500KHZ>;
> > +
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            backlight@0 {
> > +                compatible =3D "lm3533-backlight";
> > +                reg =3D <0>;
> > +
> > +                max-current-microamp =3D <23400>;
> > +                default-brightness =3D <113>;
> > +                pwm =3D <0x00>;
> > +            };
> > +        };
> > +    };
>

