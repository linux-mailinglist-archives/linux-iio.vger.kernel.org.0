Return-Path: <linux-iio+bounces-12263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 391E19C92A9
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 20:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C25B261A8
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 19:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0C81A2658;
	Thu, 14 Nov 2024 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwk+sLiD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2CC19F13C;
	Thu, 14 Nov 2024 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614158; cv=none; b=rDcCJrgWmphVNTPSM0tAknyWmU6qlfJXeM/PMDkEPasq+bADx9RBBGntvMLXM5hk7T5YSqS5r+xpVHrdx/75M7OeXwqjbOD7bNBBXr9sceVuxAVAJzN8j6hnBAa2MVACnKXCAG7SlVh+8P1ONC7Jf9Orsw693nV7Krg9OlOCNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614158; c=relaxed/simple;
	bh=D3XjcAmO1ZZsm3oT5ykTy3Fhs5gciXuLfbiQ2wqdU88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3dGFCJMKUwzx0UzRuGHjN0QVRV2hwKmT9q4WBLOJ/zfjuZFFeHtv6/wa6H2ybtdQGMBhKTTD/JNCP0SH2LGs+SCVtqrgd/GB2MvT9jArsP/jT5qrS1HY+Dm2o+TRsip4TReZdHp04r8hsOoTbItLnogmzjEHOiRpAZVxVT04+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwk+sLiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFC2C4CECD;
	Thu, 14 Nov 2024 19:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731614157;
	bh=D3XjcAmO1ZZsm3oT5ykTy3Fhs5gciXuLfbiQ2wqdU88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwk+sLiDJ1v2L9noDhtVxojBBZsk//F1C1yStmQc1eJHZgxN58E+DRRFnzOaOf7hJ
	 4qQM8uO27yFe3N4smc3Rlz/brWAyrXG6KF9lTF+FYXQMyYK/oZ3m4dVYIdZuORLYBJ
	 t7q0nuyQN0Bu+Kv0e/C8qY67/iT0CXdnB6KIJPSijAIpWy/84OSSpRaR/x1pgsZCOs
	 Kwni25AI/RyVrQ4NGB39HDo7jzgA5M/nfM23MmPeCPHOqlGso04SONiKBZatDnc4+d
	 Po9D9HdOvqCZMzEUqiJTKImvS78l7Ay6aLi+Kqq+Qy88cvrlH7jnH/DR9du/pkt7Si
	 hYrUF/HCO0eyw==
Date: Thu, 14 Nov 2024 19:55:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: frequency: Add ADF4382
Message-ID: <20241114-popsicle-trump-39fb46d7eec0@spud>
References: <20241114130340.7354-1-ciprian.hegbeli@analog.com>
 <20241114130340.7354-2-ciprian.hegbeli@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NEjQEE1Rhb1FHGcE"
Content-Disposition: inline
In-Reply-To: <20241114130340.7354-2-ciprian.hegbeli@analog.com>


--NEjQEE1Rhb1FHGcE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 03:03:10PM +0200, Ciprian Hegbeli wrote:
> The ADF4382A is a high performance, ultralow jitter, Frac-N PLL
> with integrated VCO ideally suited for LO generation for 5G applications
> or data converter clock applications. The high performance
> PLL has a figure of merit of -239 dBc/Hz, low 1/f Noise and
> high PFD frequency of 625MHz in integer mode that can achieve
> ultralow in-band noise and integrated jitter. The ADF4382A can
> generate frequencies in a fundamental octave range of 11.5 GHz to
> 21 GHz, thereby eliminating the need for sub-harmonic filters. The
> divide by 2 and 4 output dividers on the part allow frequencies to
> be generated from 5.75GHz to 10.5GHz and 2.875GHz to 5.25GHz
> respectively.
>=20
> Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> ---
>  .../bindings/iio/frequency/adi,adf4382.yaml   | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,a=
df4382.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4382.=
yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml
> new file mode 100644
> index 000000000000..44a29ac7a2e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4382.yaml
> @@ -0,0 +1,141 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,adf4382.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADF4382 Microwave Wideband Synthesizer with Integrated VCO
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +  - Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> +
> +description: The ADF4382 is a high performance, ultralow jitter, Frac-N =
PLL with
> +   integrated VCO ideally suited for LO generation for 5G applications
> +   or data converter clock applications.
> +
> +   https://www.analog.com/en/products/adf4382a.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adf4382
> +      - adi,adf4382a
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 75000000
> +
> +  clocks:
> +    description: Clock to provide CLKIN reference clock signal.
> +    maxItems: 1

All you need here is:

clocks:
  items:
    - description: foo

> +
> +  clock-names:
> +    description:
> +      External clock that provides reference input frequency.

Drop the description, you have one above.

> +    items:
> +      - const: ref_clk
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  adi,charge-pump-microamp:
> +    description:
> +      The charge pump current that the external loop filter was designed=
 for.
> +      If this property is not specified, then the charge pump current is=
 set to the
> +      default 11100uA. The valid values are listed below. However, if th=
e set value is
> +      not supported, the driver will look for the closest valid charge p=
ump current.
> +    anyOf:
> +      - enum: [790, 990, 1190, 1380, 1590, 1980, 2390, 2790, 3180, 3970,=
 4770, 5570, 6330, 7910, 9510, 11100]

Just enum, drop the anyof.

> +
> +  adi,ref-divider:
> +    description:
> +      Input divider of the reference frequency, cannot be lower then 1 or
> +      higher then 63.
> +    allOf:

This allof isn't required, all these can move up a level. Not entirely
sure why this is actually required though, shouldn't the driver be able
to compute this based on the output frequency requested?

> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 1
> +      - maximum: 63
> +      - default: 1

> +    maxItems: 1

drop this.


> +
> +  adi,ref-doubler-enable:
> +    description:
> +      Enables the doubling of the reference clock.
> +    type: boolean

type: flag
but same question here about why this is in the binding.

> +    maxItems: 1
> +
> +  adi,bleed-word:
> +    description:
> +      A small programmable constant charge pump current, known as bleed =
current,
> +      can be used to optimize the phase noise and fractional spurious si=
gnals
> +      in fractional mode.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 4095
> +      - default: 0
> +    maxItems: 1

Same comments about allOf/maxItems here. Additionally, why is this in
the binding, and not something controllable from userspace etc?
If it stays in the binding, why "bleed-word" and not
"bleed-current-microamps" (or w/e other unit that is more appropriate)

> +
> +  adi,power-up-frequency:
> +    description:
> +      PLL tunes to the set frequency on probe or defaults to 2,305 GHz.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint64
> +      - minimum: 687500000
> +      - maximum: 22000000000
> +      - default: 2305000000
> +    maxItems: 1

Same comments here.

> +
> +  adi,output-power-value:
> +    description:
> +      The output power amplitude level which will be applied for both ch=
annels
> +      at startup.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 15
> +      - default: 11
> +    maxItems: 1

Is this a unitless gain or a power that should have a unit?
Same comments as other properties about allOf/anyOf.

> +
> +  adi,spi-3wire-enable:

spi-3wire is a standard property

> +    description:
> +      Uses SPI in 3 wire mode, by default is uses 4 wire mode.
> +    type: boolean
> +    maxItems: 1
> +
> +  adi,cmos-3v3:
> +    description:
> +      Sets the SPI logic to 3.3V, by defautl it uses 1,8V.
> +    type: boolean
> +    maxItems: 1

type: flag. Drop the maxItems.

Cheers,
Conor.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        frequency@0 {
> +          compatible =3D "adi,adf4382";
> +          reg =3D <0>;
> +          spi-max-frequency =3D <1000000>;
> +          clocks =3D <&adf4382_clkin>;
> +          clock-names =3D "ref_clk";
> +          adi,charge-pump-current =3D <15>;
> +          adi,ref-divider =3D <1>;
> +        };
> +    };
> +...
> --=20
> 2.43.0
>=20

--NEjQEE1Rhb1FHGcE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZVyAAKCRB4tDGHoIJi
0iw1AQDAgk0+cQugL5UwCSbK+rFKLIHk/wYFFz6ILxw78HCfcAD/dEGYFdYngZb4
b6lb7Y5JKnxuH+j440HqLtt4P/+DDQ0=
=b/wh
-----END PGP SIGNATURE-----

--NEjQEE1Rhb1FHGcE--

