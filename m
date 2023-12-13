Return-Path: <linux-iio+bounces-905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F161E81192E
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 17:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E30F1F21232
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D5333CF1;
	Wed, 13 Dec 2023 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq2WMYzG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F73321B1;
	Wed, 13 Dec 2023 16:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE61C433CA;
	Wed, 13 Dec 2023 16:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702484627;
	bh=XFSkcVLPkIh+/24c0S1bkj+e0UjVJVCIdZQ/7DuBXHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kq2WMYzG0Cksn/leFF/HBWvYW1ptopPBajj6mSVWswXhL8w+5UoXhWV5C2kFrblWY
	 3f8JvxOJXj6P293FCK26KRbYf0CIpGgI7QdcsNTohxKCQKxIC5nVYTaSbEl3uBj/p7
	 WDDltBGUsUGIt2vmrG0KIHTi4/qOM9sxUMA+fYFwr2Xgfr0Wb92ZU5AWGtb4mGH3dS
	 7qnhPVJV+u8lorOfGGYB9eT6OyrIJJFTy9CLtc2ls/6wtPhZoaVF7gU3ZJ/Q5KDPUU
	 KAsX6552wsIzfj/Noo0xB7/ulMgC5zZJK4HhT0Dgt96AROoYf5UQeI04LJhsENtQUb
	 Pa2lnInOvHS7w==
Date: Wed, 13 Dec 2023 16:23:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti-ads1298: Add driver
Message-ID: <20231213-diffuser-disposal-ea21bbce8b64@spud>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.618139b3-8cb2-4e4c-9283-9e3787c70105@emailsignatures365.codetwo.com>
 <20231213094722.31547-1-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wheiXICN3N+7aHqO"
Content-Disposition: inline
In-Reply-To: <20231213094722.31547-1-mike.looijmans@topic.nl>


--wheiXICN3N+7aHqO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:47:21AM +0100, Mike Looijmans wrote:
> Skeleton driver for the TI ADS1298 medical ADC. This device is
> typically used for ECG and similar measurements. Supports data
> acquisition at configurable scale and sampling frequency.

I think the commit subject and body here were accidentally copy-pasted
=66rom the driver patch. Patches for bindings should avoid talking about
drivers and focus on the harware (unless we are talking about LEDs or
motors etc)

>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>=20
> ---
>=20
>  .../bindings/iio/adc/ti,ads1298.yaml          | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1298.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/=
Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> new file mode 100644
> index 000000000000..7a160ba721eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1298.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments' ads1298 medical ADC chips
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads1298
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description:
> +      Analog power supply, voltage between AVDD and AVSS. When providing=
 a
> +      symmetric +/- 2.5V, the regulator should report 5V.
> +
> +  vref-supply:
> +    description:
> +      Optional reference voltage. If omitted, internal reference is used,
> +      depending on analog supply this is 2.4 or 4V.

It may be worth mentioning here what the conditions for the internal
reference being 2.4 or 4 volts actually are.

> +
> +  clocks:
> +    description: Optional 2.048 MHz external source clock on CLK pin
> +    maxItems: 1
> +
> +  clock-names:
> +    const: clk

Since you have only one clock, having clock-names (especially with a
name like "clk") is pointless IMO.

Generally though, this patch looks good to me.

Cheers,
Conor.

> +  interrupts:
> +    description: Interrupt on DRDY pin, triggers on falling edge
> +    maxItems: 1
> +
> +  label: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - interrupts
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@1 {
> +          reg =3D <1>;
> +          compatible =3D "ti,ads1298";
> +          label =3D "ads1298-1-ecg";
> +          avdd-supply =3D <&reg_iso_5v_a>;
> +          clock-names =3D "clk";
> +          clocks =3D <&clk_ads1298>;
> +          interrupt-parent =3D <&gpio0>;
> +          interrupts =3D <78 IRQ_TYPE_EDGE_FALLING>;
> +          spi-max-frequency =3D <20000000>;
> +          spi-cpha;
> +        };
> +    };
> +...
> --=20
> 2.34.1
>=20
>=20
> Met vriendelijke groet / kind regards,
>=20
> Mike Looijmans
> System Expert
>=20
>=20
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
>=20
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topic.nl
> W: www.topic.nl
>=20
> Please consider the environment before printing this e-mail

--wheiXICN3N+7aHqO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXnajgAKCRB4tDGHoIJi
0uX4AQDdQsLinMnKQNR0gruAlC6KO76Muuel5q+ksbfjERk0UwD+I7lYJD33yIjB
9BRsIVetMvFlFztwVEH+OctNqIhFHQs=
=aemH
-----END PGP SIGNATURE-----

--wheiXICN3N+7aHqO--

