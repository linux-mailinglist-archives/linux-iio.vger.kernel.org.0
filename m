Return-Path: <linux-iio+bounces-15053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC68AA29A96
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 21:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42D918856BB
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 20:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9F920C026;
	Wed,  5 Feb 2025 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeJTukVY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7EF510;
	Wed,  5 Feb 2025 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785842; cv=none; b=ssvgAcCayZ5Vi4ouDwmn0rNa/KT3eEBFkwEsCFK5rWG0GGDhqxj2gDZg1Wh/Z8GVYuz3znuGoh9IHVjFzLkRsSkQGClkAOH+5KkWR/NCbf3IMCfwC+F8IIPsUJbv5CaowcOWQgWMvU1CnpQugQt1bt0yq+VF0cSg7QoyfYbC61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785842; c=relaxed/simple;
	bh=cqtvkklhEhB0dODG1Vl5z2G6YHW2NJWGENWdGBrHkeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HL3kd3lfeup9Uvb9z0/L+mNe9oClmOfBChf7gLiMauefKz6dWYLL8hvtXNHn+PKQJVf6Ht9yeE+E6WhgQHf2engA8mQffWaNiZmlkIShNfbXFHQuPpKOQDIUs+tIUVcX1NCQXYqZEek7ImBlLO26OhSBRhcKi6D8mNz1J1LlzLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeJTukVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F00FC4CEE2;
	Wed,  5 Feb 2025 20:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738785842;
	bh=cqtvkklhEhB0dODG1Vl5z2G6YHW2NJWGENWdGBrHkeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FeJTukVY0r2+phkxY4vD1jGpBVAhNBTpFgl7sCJyqr5cAVb85N2ySX0U5TOnmxGnr
	 uT+MouOjlbg6gjpSWcawzcDxsZ1F1ty4mcxqkGp+usJM2eX9b9/kle9wneOylRKc86
	 PsSvRjOczvK79o4dUc1GxFdUSqK/Ix2Vq5+wYP/zit5fwwHg+ZpRLiHAQKv1xCmJJw
	 9HFwuunW1YNhKOaqfKF7dWFU0DOSdCQgoYRXgztu9RCNem1DS8KI7dli94pFhmsWNZ
	 zl1be9nY8up9x0rDNGn/NjvJkhqiBCDbGlxvGi3ljzL2lN+oo5xkKJaHZVEhiKCYfm
	 G//JPB5h0LU+g==
Date: Wed, 5 Feb 2025 20:03:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: ROHM BD79124 ADC/GPO
Message-ID: <20250205-stalemate-shorthand-5a29fbc4081f@spud>
References: <cover.1738761899.git.mazziesaccount@gmail.com>
 <4e6cd143d3e896587528a415c8623ecd610fac55.1738761899.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vu8978jfQni0yQFt"
Content-Disposition: inline
In-Reply-To: <4e6cd143d3e896587528a415c8623ecd610fac55.1738761899.git.mazziesaccount@gmail.com>


--vu8978jfQni0yQFt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 03:34:29PM +0200, Matti Vaittinen wrote:
> Add binding document for the ROHM BD79124 ADC / GPO.
>=20
> ROHM BD79124 is a 8-channel, 12-bit ADC. The input pins can also be used
> as general purpose outputs.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Revision history:
> RFC v1 =3D> v2:
>  - drop MFD and represent directly as ADC
>  - drop pinmux and treat all non ADC channel pins as GPOs
> ---
>  .../bindings/iio/adc/rohm,bd79124.yaml        | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd7912=
4.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml =
b/Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml
> new file mode 100644
> index 000000000000..50889dc6b9a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/rohm,bd79124.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BD79124 ADC/GPO
> +
> +maintainers:
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> +
> +description: |
> +  The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
> +  an automatic measurement mode, with an alarm interrupt for out-of-wind=
ow
> +  measurements. ADC input pins can be also configured as general purpose
> +  outputs.
> +
> +properties:
> +  compatible:
> +    const: rohm,bd79124
> +
> +  reg:
> +    description:
> +      I2C slave address.
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 1
> +    description:
> +      The pin number.
> +
> +  vdd-supply: true
> +
> +  iovdd-supply: true
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^channel@[0-9a-f]+$":

You can only have 8 channels, there's no need for this to be so
permissive, right?
Otherwise, this looks good enough to me.

> +    type: object
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    description: Represents ADC channel.
> +
> +    properties:
> +      reg:
> +        description: AIN pin number
> +        minimum: 0
> +        maximum: 7
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - iovdd-supply
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/leds/common.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        adc: adc@10 {
> +            compatible =3D "rohm,bd79124";
> +            reg =3D <0x10>;
> +
> +            interrupt-parent =3D <&gpio1>;
> +            interrupts =3D <29 8>;
> +
> +            vdd-supply =3D <&dummyreg>;
> +            iovdd-supply =3D <&dummyreg>;
> +
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            channel@0 {
> +                reg =3D <0>;
> +            };
> +            channel@1 {
> +                reg =3D <1>;
> +            };
> +            channel@2 {
> +                reg =3D <2>;
> +            };
> +            channel@3 {
> +                reg =3D <3>;
> +            };
> +            channel@4 {
> +                reg =3D <4>;
> +            };
> +            channel@5 {
> +                reg =3D <5>;
> +            };
> +            channel@6 {
> +                reg =3D <6>;
> +            };
> +        };
> +    };
> --=20
> 2.48.1
>=20



--vu8978jfQni0yQFt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6PELQAKCRB4tDGHoIJi
0nAdAP4jXKqyfRAMMvjzMrlM0XfhisGC3LV05/dS61edgIUhNwEApAM8EcrfeloJ
x1zImD4zFU0fcyXdWWfFA28lc32iHA0=
=u2gq
-----END PGP SIGNATURE-----

--vu8978jfQni0yQFt--

