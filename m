Return-Path: <linux-iio+bounces-6099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CB8901588
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 12:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CAE1B2114E
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 10:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E242020DD2;
	Sun,  9 Jun 2024 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3h9CX1G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABEA22619;
	Sun,  9 Jun 2024 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717928318; cv=none; b=QObW4J2AoOutSQ7kp2ZkmRkHXizHgwbtsAe1ODzXzu7cHEIn71xbhgBuA0F4rRDKtb02T2c8FO2n5x+JcMnKhXMO4DIM+HQzjn9URgHEktg04wqfWF699qpqtQ3nKR81BAvaN0MWGplhHQSXh6LHQwkpFgZ69ZsEHiHgNOFKlfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717928318; c=relaxed/simple;
	bh=fy4wqIGP/0XPQnNOrnmxbqYJ84UFY/vN3hZc+RbEo2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFuOiIfev8tlNApnZkrRzqAE9dKHaMnY7YuNn6uQUcFf7wOvSrPwbA4Xx1pjHR0vjDvDrw9k/G531gL8BjFmp/QXofolGY40uKUBUQcbZ8/ov/GxrSntUrzQQ8xjItCxjJVDzmkD1eS8GTAQUHNPBlzK/dOk0hd05UAeFZBz5g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3h9CX1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CBCC2BD10;
	Sun,  9 Jun 2024 10:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717928318;
	bh=fy4wqIGP/0XPQnNOrnmxbqYJ84UFY/vN3hZc+RbEo2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I3h9CX1GPHvxMGFCT0woGd59deltw5THyyUnHqHwwGn357o/S5lO/m6ft/Vj4HuvZ
	 m4iRydXXf1Z8tbGu5ME+nkSY5kF5xhJC8P2lQGIhXUouDYbgeSwmwlltuCsoR8dr7i
	 Pm7Sir7aOVVQCxu5eb44zTDuo6oJH8TY1XhNhbS/RurFdDWXrHcaZVuwN10MOXNVsc
	 S4PeMybJwU0qCTxFajs4o26hADH7gfxraZtdLyEJfk7Ubnv9tp8q3+Ha6td0PPRN7L
	 JDbhCcJyAeYIrxNr9AqQp5q2unefpATxjA1iDewKmuJLc1pyhv6ivtw7N+BGNTSTlE
	 v18AETj417kjA==
Date: Sun, 9 Jun 2024 11:17:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Francesco Dolcini
 <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add ti,ads1119
Message-ID: <20240609111740.1c61ce07@jic23-huawei>
In-Reply-To: <20240606163529.87528-2-francesco@dolcini.it>
References: <20240606163529.87528-1-francesco@dolcini.it>
	<20240606163529.87528-2-francesco@dolcini.it>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  6 Jun 2024 18:35:28 +0200
Francesco Dolcini <francesco@dolcini.it> wrote:

> From: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex.com>
>=20
> Add devicetree bindings for Texas Instruments ADS1119 16-bit ADC
> with I2C interface.
>=20
> Datasheet: https://www.ti.com/lit/gpn/ads1119
> Signed-off-by: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

I missed it on previous version but you only have description in here
for vref and few devices power them selves from something called vref!

The binding should describe the other power supplies as well and mark
them as required.

We've left these out too many times in the past and ended up having
a patch very soon after adding them. Better to have them from the start.
Driver should just use devm_regulator_get_enabled() to turn them on and
register them to be turned off on driver removal, and ignore them
after that.  If anyone has controlled supplies and wants to do more
sophisticated handling they can add it later.

Note that even though the dt-binding will list them as required, if
a particular DTS doesn't provide them the regulator framework will
give a dummy uncontrolled regulator to represent the assumption that
the power is always there.  We still document them as required in
the dt-binding though as other OS may not be so clever.

Only needs minimal entries though - see inline

Jonathan

> ---
> v2:
>  - add diff-channels and single-channel
>  - add XOR check to make diff/single channel property required=20
>  - add interrupts, reset-gpios and vref-supply to the example=20
>  - fix missing additionalProperties/unevaluatedProperties warning in chan=
nels
>  - remove ti,gain and ti,datarate as they aren't fixed hw properties
>  - remove unnecessary |=20
> ---
>  .../bindings/iio/adc/ti,ads1119.yaml          | 148 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1119.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml b/=
Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
> new file mode 100644
> index 000000000000..cbf0d4ef3a11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
> @@ -0,0 +1,148 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1119.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS1119 ADC
> +
> +maintainers:
> +  - Jo=C3=A3o Paulo Gon=C3=A7alves <jpaulo.silvagoncalves@gmail.com>
> +
> +description:
> +  The TI ADS1119 is a precision 16-bit ADC over I2C that offers single-e=
nded and
> +  differential measurements using a multiplexed input. It features a pro=
grammable
> +  gain, a programmable sample rate, an internal oscillator and voltage r=
eference,
> +  and a 50/60Hz rejection filter.
> +
> +properties:
> +  compatible:
> +    const: ti,ads1119
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
avdd-supply: true
dvdd-supply: true

> +  vref-supply:
> +    description:
> +      ADC external reference voltage (VREF).
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
    - avdd-supply
    - dvdd-supply

> +
> +patternProperties:
> +  "^channel@([0-6])$":
> +    $ref: adc.yaml
> +    type: object
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 6
> +
> +      diff-channels:
> +        description:
> +          Differential input channels AIN0-AIN1, AIN2-AIN3 and AIN1-AIN2.
> +        oneOf:
> +          - items:
> +              - const: 0
> +              - const: 1
> +          - items:
> +              - const: 2
> +              - const: 3
> +          - items:
> +              - const: 1
> +              - const: 2
> +
> +      single-channel:
> +        description:
> +          Single-ended input channels AIN0, AIN1, AIN2 and AIN3.
> +        minimum: 0
> +        maximum: 3
> +
> +    oneOf:
> +      - required:
> +          - diff-channels
> +      - required:
> +          - single-channel
> +
> +    required:
> +      - reg
> +
> +    unevaluatedProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@40 {
> +            compatible =3D "ti,ads1119";
> +            reg =3D <0x40>;
> +            interrupt-parent =3D <&gpio1>;
> +            interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>;
> +            reset-gpios =3D <&gpio1 10 GPIO_ACTIVE_LOW>;
> +            vref-supply =3D <&reg_vref_ads1119>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +            #io-channel-cells =3D <1>;
> +
> +            channel@0 {
> +                reg =3D <0>;
> +                single-channel =3D <0>;
> +            };
> +
> +            channel@1 {
> +                reg =3D <1>;
> +                diff-channels =3D <0 1>;
> +            };
> +
> +            channel@2 {
> +                reg =3D <2>;
> +                single-channel =3D <3>;
> +            };
> +
> +            channel@3 {
> +                reg =3D <3>;
> +                single-channel =3D <1>;
> +            };
> +
> +            channel@4 {
> +                reg =3D <4>;
> +                single-channel =3D <2>;
> +            };
> +
> +            channel@5 {
> +                reg =3D <5>;
> +                diff-channels =3D <1 2>;
> +            };
> +
> +            channel@6 {
> +                reg =3D <6>;
> +                diff-channels =3D <2 3>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..f1b2c4b815e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22380,6 +22380,13 @@ M:	Robert Richter <rric@kernel.org>
>  S:	Odd Fixes
>  F:	drivers/gpio/gpio-thunderx.c
> =20
> +TI ADS1119 ADC DRIVER
> +M:	Francesco Dolcini <francesco@dolcini.it>
> +M:	Jo=C3=A3o Paulo Gon=C3=A7alves <jpaulo.silvagoncalves@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
> +
>  TI ADS7924 ADC DRIVER
>  M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
>  L:	linux-iio@vger.kernel.org


