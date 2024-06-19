Return-Path: <linux-iio+bounces-6599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAC190F58E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 19:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39972B22010
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 17:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E1F15698D;
	Wed, 19 Jun 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0xpagqW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701FE55884;
	Wed, 19 Jun 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819802; cv=none; b=mWaOLIoQ285Zt4cQakacT/7MkqgOIJPQZ3j9ItAJbcAavvWl/mSvAVkKpvhcJa6dyxBauv0gD+KLNHgb3YocnM/KsRyyaf3j3v0Pf4AgCXkcBs2tBZhXDtwYFftVrWJIIeyNxEsqTBFhm/iysnlRbEYXzttxTTrawCYVbNdvmBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819802; c=relaxed/simple;
	bh=DCOrH0OZSQJd5pXhQNmxRLV8v4tj9PjaFm7KtBv65fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV/hyv4TjGAjIvIv0P4BOaFns1odWFK+JXAgE6JS68Z9+NojW6bv9T/+1RxynxmoA3+n426yuF0575ywUbzN2WheYH3HEy6HLO/CxKGxNxIbbc/eQfWmBsIJpMUmXX7+zOY8aCxNaLvo6E+kPiiE0aNaqZe/w1VpHnaYukQOMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0xpagqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0036BC2BBFC;
	Wed, 19 Jun 2024 17:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718819801;
	bh=DCOrH0OZSQJd5pXhQNmxRLV8v4tj9PjaFm7KtBv65fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0xpagqWXN01HKeXoD9/oBeeyEaCbhjSETFc7wR9y83EgL5z8dUHQimHhknOEjEKv
	 7k60YkVQ6S7Wb/EBhYN1wUDB7KDmwbzME/wwwm4qO5Y2adxpT8d7ZzihXNkGGuNan7
	 e6+zJFswQe3+YJJmeIw9fYJNZXdhWDMRmuybinbD7aQYTrvY3cDVm/E52uVwuQRfrg
	 TKO9iGK8nY8dmNuQT7uWLh/3yaqddTn65owE0tCuxIQwxDQuykVdjAsHoxXLEz6xEb
	 MJCCkdF911ul+eztryYaF26kbIO7tqU4H9xYUwOCFlsDRTNiaz9E1YzI2Z97yXmPWe
	 F/I9CpqH0btQA==
Date: Wed, 19 Jun 2024 18:56:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Message-ID: <20240619-left-usable-316cbe62468a@spud>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
 <20240619064904.73832-4-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XW3JZQj+36UYFiPt"
Content-Disposition: inline
In-Reply-To: <20240619064904.73832-4-kimseer.paller@analog.com>


--XW3JZQj+36UYFiPt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 02:49:02PM +0800, Kim Seer Paller wrote:
> Add documentation for ltc2664.
>=20
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../bindings/iio/dac/adi,ltc2664.yaml         | 167 ++++++++++++++++++
>  MAINTAINERS                                   |   8 +
>  2 files changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2664=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml b=
/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> new file mode 100644
> index 000000000000..be37700e3b1f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> @@ -0,0 +1,167 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ltc2664.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2664 DAC
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description: |
> +  Analog Devices LTC2664 4 channel, 12-/16-Bit, +-10V DAC
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/26=
64fa.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ltc2664
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 50000000
> +
> +  vcc-supply:
> +    description: Analog Supply Voltage Input.
> +
> +  v-pos-supply:
> +    description: Positive Supply Voltage Input.
> +
> +  v-neg-supply:
> +    description: Negative Supply Voltage Input.
> +
> +  iovcc-supply:
> +    description: Digital Input/Output Supply Voltage.
> +
> +  ref-supply:
> +    description:
> +      Reference Input/Output. The voltage at the REF pin sets the full-s=
cale
> +      range of all channels. If not provided the internal reference is u=
sed and
> +      also provided on the VREF pin.
> +
> +  reset-gpios:
> +    description:
> +      Active-low Asynchronous Clear Input. A logic low at this level-tri=
ggered
> +      input clears the part to the reset code and range determined by the
> +      hardwired option chosen using the MSPAN pins. The control register=
s are
> +      cleared to zero.
> +    maxItems: 1
> +
> +  adi,manual-span-operation-config:
> +    description:
> +      This property must mimic the MSPAN pin configurations. By tying th=
e MSPAN
> +      pins (MSP2, MSP1 and MSP0) to GND and/or VCC, any output range can=
 be
> +      hardware-configured with different mid-scale or zero-scale reset o=
ptions.
> +      The hardware configuration is latched during power on reset for pr=
oper
> +      operation.
> +        0 - MPS2=3DGND, MPS1=3DGND, MSP0=3DGND (+-10V, reset to 0V)
> +        1 - MPS2=3DGND, MPS1=3DGND, MSP0=3DVCC (+-5V, reset to 0V)
> +        2 - MPS2=3DGND, MPS1=3DVCC, MSP0=3DGND (+-2.5V, reset to 0V)
> +        3 - MPS2=3DGND, MPS1=3DVCC, MSP0=3DVCC (0V to 10, reset to 0V)
> +        4 - MPS2=3DVCC, MPS1=3DGND, MSP0=3DGND (0V to 10V, reset to 5V)
> +        5 - MPS2=3DVCC, MPS1=3DGND, MSP0=3DVCC (0V to 5V, reset to 0V)
> +        6 - MPS2=3DVCC, MPS1=3DVCC, MSP0=3DGND (0V to 5V, reset to 2.5V)
> +        7 - MPS2=3DVCC, MPS1=3DVCC, MSP0=3DVCC (0V to 5V, reset to 0V, e=
nables SoftSpan)
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3, 4, 5, 6, 7]

Can you explain why this property is required, when below there's one
that sets the ranges in microvolts? Isn't the only new information that
this provides the reset values (in a few cases that it is not 0).
What am I missing?

> +    default: 7
> +
> +  io-channels:
> +    description:
> +      ADC channel to monitor voltages and temperature at the MUXOUT pin.
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@[0-3]$":
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel number representing the DAC output chan=
nel.
> +        maximum: 3
> +
> +      adi,toggle-mode:
> +        description:
> +          Set the channel as a toggle enabled channel. Toggle operation =
enables
> +          fast switching of a DAC output between two different DAC codes=
 without
> +          any SPI transaction.
> +        type: boolean
> +
> +      adi,output-range-microvolt:
> +        description: Specify the channel output full scale range.
> +        oneOf:
> +          - items:
> +              - const: 0
> +              - enum: [5000000, 10000000]
> +          - items:
> +              - const: -5000000
> +              - const: 5000000
> +          - items:
> +              - const: -10000000
> +              - const: 10000000
> +          - items:
> +              - const: -2500000
> +              - const: 2500000
> +
> +    required:
> +      - reg
> +      - adi,output-range-microvolt
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - vcc-supply
> +  - iovcc-supply
> +  - v-pos-supply
> +  - v-neg-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        dac@0 {
> +            compatible =3D "adi,ltc2664";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <10000000>;
> +
> +            vcc-supply =3D <&vcc>;
> +            iovcc-supply =3D <&vcc>;
> +            ref-supply =3D <&vref>;
> +            v-pos-supply =3D <&vpos>;
> +            v-neg-supply =3D <&vneg>;
> +
> +            io-channels =3D <&adc 0>;
> +
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +            channel@0 {
> +                    reg =3D <0>;
> +                    adi,toggle-mode;
> +                    adi,output-range-microvolt =3D <(-10000000) 10000000=
>;
> +            };
> +
> +            channel@1 {
> +                    reg =3D <1>;
> +                    adi,output-range-microvolt =3D <0 10000000>;
> +            };
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index be590c462d91..849800d9cbf7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13074,6 +13074,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
>  F:	drivers/iio/dac/ltc1660.c
> =20
> +LTC2664 IIO DAC DRIVER
> +M:	Michael Hennerich <michael.hennerich@analog.com>
> +M:	Kim Seer Paller <kimseer.paller@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> +
>  LTC2688 IIO DAC DRIVER
>  M:	Nuno S=E1 <nuno.sa@analog.com>
>  L:	linux-iio@vger.kernel.org
> --=20
> 2.34.1
>=20

--XW3JZQj+36UYFiPt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnMb1AAKCRB4tDGHoIJi
0mZsAP9GNCu3FZFO1OetheXbTc08RY3vcp3bln0Pju6dJ3cGBAD5AcRIAm+Pgz1w
nLR10IFUS+x7zo1wvVKMyMXZhZG/6QI=
=YAw6
-----END PGP SIGNATURE-----

--XW3JZQj+36UYFiPt--

