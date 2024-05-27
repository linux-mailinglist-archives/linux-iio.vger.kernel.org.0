Return-Path: <linux-iio+bounces-5351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FB68D0891
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC931F2192D
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 16:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B52815A851;
	Mon, 27 May 2024 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glMXHRXu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C9415A844;
	Mon, 27 May 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827382; cv=none; b=fIknklZflanjNaGxI05b1Kf2n/E59cXYDy/nJ83npF3lvC3tEeRvJAuy9vjhkVEbfAlkvfyOS/AzP8yjdbcbFkbi5LrtQ/AFSaR4tqgVZ31hKkDa9Ta9YC5hoRr+eHSS9yNAASFgwkuluAnB4q3y9Nav291/xR6KCYh++Qp9Q/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827382; c=relaxed/simple;
	bh=7pj/XCLGDOEGfoe0oU0fc4KA6+ZTDkriw3sFEhW+RVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvfBzEUzKcSk71w1aWt6sE2+l/41jdlfXJ0Ru6a42pQcAv501wF1QMaXEPyEzr4J9Z+SSnlDR73nicQUX44YMFa+2KkVTCFYUKkNYgCyN9daGaHeyoOixzp0BBVON1EC71IsOwnflrMB4o20Xrk6Dws6cX63cTYDiSO3Dr72948=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glMXHRXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC91C2BBFC;
	Mon, 27 May 2024 16:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716827381;
	bh=7pj/XCLGDOEGfoe0oU0fc4KA6+ZTDkriw3sFEhW+RVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=glMXHRXuglCtiUTeVFEbFc9v/xeuPPUw5UmRugqMGpQdELUc3uUQ3DArHs3+amVKv
	 dt7xpbHboS0lxyQW04SZc6i+LbHkWzTgkxS9ZJXCdT/+alufGI3EXQZIzmkETwgeLa
	 7/YUrCXdorrfbtl53ErUvGiinyS8em0aDsTK3ESLnjJs7gM/T7y4rKgac0DPzJqZtE
	 SOwEkictvfJejCTyYjlbvtPhOEuCqXM0ZbN3ckqbEzEHTNlU6A9qLA6PDJrCP5rJIA
	 +IooP9jdfK+9X3v4jUpn91HaB7TsrFidB0/NnezdEl47lcu90wCa8Y3YtmESodk4wa
	 RgvVQiDiog+ng==
Date: Mon, 27 May 2024 17:29:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: add ti,ads1119
Message-ID: <20240527-ecosystem-mountable-d9a6eebc7607@spud>
References: <20240527154050.24975-1-francesco@dolcini.it>
 <20240527154050.24975-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zNG+bgDFF3VuTFdF"
Content-Disposition: inline
In-Reply-To: <20240527154050.24975-2-francesco@dolcini.it>


--zNG+bgDFF3VuTFdF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 05:40:49PM +0200, Francesco Dolcini wrote:
> From: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
>=20
> Add devicetree bindings for Texas Instruments ADS1119 16-bit ADC
> with I2C interface.
>=20
> Datasheet: https://www.ti.com/lit/gpn/ads1119
> Signed-off-by: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../bindings/iio/adc/ti,ads1119.yaml          | 122 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1119.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml b/=
Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
> new file mode 100644
> index 000000000000..ab4f01199dbe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1119.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS1119 ADC
> +
> +maintainers:
> +  - Jo=E3o Paulo Gon=E7alves <jpaulo.silvagoncalves@gmail.com>
> +
> +description: |

Most of the |s you have in this file are not needed - you don't have any
formatting to preserve in all but the channels.

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
> +
> +patternProperties:
> +  "^channel@([0-6])$":
> +    $ref: adc.yaml
> +    type: object
> +    description: |
> +      ADC channels.
> +
> +    properties:
> +      reg:
> +        description: |
> +          0: Voltage over AIN0 and AIN1.
> +          1: Voltage over AIN2 and AIN3.
> +          2: Voltage over AIN1 and AIN2.
> +          3: Voltage over AIN0 and GND.
> +          4: Voltage over AIN1 and GND.
> +          5: Voltage over AIN2 and GND.
> +          6: Voltage over AIN3 and GND.

Take a look at diff-channels.

> +        items:
> +          - minimum: 0
> +            maximum: 6
> +
> +      ti,gain:

What makes this a property of the hardware?
Also, missing unit.

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          PGA gain value.
> +        enum: [1, 4]
> +        default: 1
> +
> +      ti,datarate:

Ditto here, why's this a property of the hardware? Usually this gets set
=66rom sysfs..

Thanks,
Conor.

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Data acquisition rate in samples per second.
> +        enum: [20, 90, 330, 1000]
> +        default: 20
> +
> +    required:
> +      - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@40 {
> +            compatible =3D "ti,ads1119";
> +            reg =3D <0x40>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +            #io-channel-cells =3D <1>;
> +
> +            channel@0 {
> +                reg =3D <0>;
> +                ti,gain =3D <4>;
> +                ti,datarate =3D <330>;
> +            };
> +
> +            channel@4 {
> +                reg =3D <4>;
> +                ti,datarate =3D <1000>;
> +            };
> +
> +            channel@5 {
> +                reg =3D <5>;
> +                ti,gain =3D <4>;
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
> +M:	Jo=E3o Paulo Gon=E7alves <jpaulo.silvagoncalves@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
> +
>  TI ADS7924 ADC DRIVER
>  M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
>  L:	linux-iio@vger.kernel.org
> --=20
> 2.39.2
>=20

--zNG+bgDFF3VuTFdF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlS08AAKCRB4tDGHoIJi
0tuwAP9bAJ1q8cEi8wbDHJNK175XRR6DiVvTUcizd1Y7Psac1gEAhAHM9ucMk9u/
Q74H0LG4aMVAbRpYeu1qFSZ8etUsYwQ=
=LjsF
-----END PGP SIGNATURE-----

--zNG+bgDFF3VuTFdF--

