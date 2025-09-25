Return-Path: <linux-iio+bounces-24438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD18BA12CE
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 21:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BC7188A946
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 19:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E88331D37A;
	Thu, 25 Sep 2025 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k26gTBOX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1531CA7B;
	Thu, 25 Sep 2025 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828431; cv=none; b=QFxidmFrvsnMkDcujrxCyIvtXhQE9hoO6PAIYbIiEBVd91ffCN7QguVM2oTxu78mfrxmm4Vwc17oxH0V25T+DeT5nl4NCkLq4VQ5bR24LeWR94bbxecabzpUwrzHYPii35fwvK2Pw1ROOrrmUSU4qm9i86KeoqfVzONmtvbO7zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828431; c=relaxed/simple;
	bh=8vm6F+0OMAOJtiNGO0yQnoDSWYInV+uyaO2RGW6fnWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olcP+WDDzpPpQuP112rGmnXQP2RfMprj3LRHS+pCFKMQoVTMZe0TlQKKFc/u6AfTt+ADDB84/7u4Jgg/eJDTmd1zi9vOtgw7ewi+enNYJqiaaaRXxvf3DHMxeDv/aV+397TnGa1R74AOjy9w4MipiEYP0gpx7GjaGCB8I5jmTXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k26gTBOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7BDC4CEF7;
	Thu, 25 Sep 2025 19:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758828431;
	bh=8vm6F+0OMAOJtiNGO0yQnoDSWYInV+uyaO2RGW6fnWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k26gTBOXzb9SWd5o56WWrXTAoQjbKIpkMqqM+zjosIr/+KjhuIMpKZLf/eKGzEkQl
	 BGDt0AEXN/PARtvW3W7bM+35qnvcn3PUtwUA/ZoPMnsczyJeY8arvOtMSMtcCIAHgO
	 8BSNaE5tISv5Kurwy+ImUFxj7uoOZ2cm/NQieLLLl9Ukk++LiagfZkRefIFjq6Izqv
	 aFOE/RqX5RT59h13/MV+BFhPvWuViyFoh6bVOFDIUNWY9BR1BIbBh0kZkN7nlRyHsT
	 wcEQT8Sy16XrLSY5RhWf1hhdiOEIfzS2WXF2hgn8no9YTYxYjvQVS1pN6qQX3LkE9W
	 tkpJr4adaJdtA==
Date: Thu, 25 Sep 2025 20:27:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/5] regulator: dt-bindings: Add Linear Technology
 LTM8054 regulator
Message-ID: <20250925-pushchair-charity-9ccee20d8a6e@spud>
References: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
 <20250925-ltm8054-driver-v2-1-bb61a401a0dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NOfbYS7pJJYrvl13"
Content-Disposition: inline
In-Reply-To: <20250925-ltm8054-driver-v2-1-bb61a401a0dc@bootlin.com>


--NOfbYS7pJJYrvl13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 02:37:33PM +0200, Romain Gantois wrote:
> The Linear Technology LTM8054 is a Buck-Boost voltage regulator with an
> input range of 5V to 36V and an output range of 1.2V to 36V.
>=20
> The LTM8054's output voltage level is typically set using a voltage divid=
er
> between the Vout and FB pins, the FB pin being constantly regulated to
> 1.2V.
>=20
> The output current limit of the LTM8054 may be statically set by placing a
> sense resistor on a dedicated pin. This limit can then be lowered by
> controlling the voltage level on the CTL pin.
>=20
> Describe the LTM8054 voltage regulator.
>=20
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  .../devicetree/bindings/regulator/adi,ltm8054.yaml | 73 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 78 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/regulator/adi,ltm8054.yaml=
 b/Documentation/devicetree/bindings/regulator/adi,ltm8054.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..8ca8fc4e80b5722f58b4cbe9d=
e22c16d4fd91670
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/adi,ltm8054.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/adi,ltm8054.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTM8054 buck-boost regulator
> +
> +maintainers:
> +  - Romain Gantois <romain.gantois@bootlin.com>
> +
> +description:
> +  This regulator operates over an input voltage range of 5V to 36V, and =
can
> +  output from 1.2V to 36V. The output voltage level is typically set wit=
h a
> +  voltage divider between the Vout pin and the FB pin which is internally
> +  regulated to 1.2V.
> +
> +  The output current of the LTM8054 can be limited by tying the Iout pin=
 to a
> +  current sense resistor. This limit can be further lowered by applying a
> +  voltage below 1.2V to the CTL pin.
> +
> +allOf:
> +  - $ref: /schemas/regulator/regulator.yaml#
> +
> +properties:
> +  compatible:
> +    const: adi,ltm8054
> +
> +  enable-gpios:
> +    description: GPIO connected to the RUN pin.
> +    maxItems: 1
> +
> +  lltc,fb-voltage-divider:

Why does this property have a ?linear? vendor prefix?
Shouldn't it be adi to match the other property and compatible?

> +    description:
> +      An array of two integers containing the resistor values
> +      R1 and R2 of the feedback voltage divider in Ohms.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 2
> +    maxItems: 2
> +
> +  adi,iout-rsense-micro-ohms:
> +    description:
> +      Value of the output current sense resistor, in micro Ohms.
> +
> +  io-channels:
> +    items:
> +      - description: DAC controlling the voltage level of the CTL pin.
> +
> +  io-channel-names:
> +    items:
> +      - const: ctl
> +
> +required:
> +  - compatible
> +  - lltc,fb-voltage-divider
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    regulator {
> +        compatible =3D "adi,ltm8054";
> +
> +        enable-gpios =3D <&gpio0 1 GPIO_ACTIVE_HIGH>;
> +
> +        lltc,fb-voltage-divider =3D <1000000 68000>;
> +
> +        adi,iout-rsense-micro-ohms =3D <20000>;
> +
> +        io-channels =3D <&dac 1>;
> +        io-channel-names =3D "ctl";
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3763f9fc9e4ed62bc8b273756a25f9c921570bee..69bcba82808bb815af436232f=
ab50f70713fd533 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14534,6 +14534,11 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
>  F:	drivers/i2c/muxes/i2c-mux-ltc4306.c
> =20
> +LTM8054 REGULATOR DRIVER
> +M:	Romain Gantois <romain.gantois@bootlin.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/regulator/adi,ltm8054.yaml
> +
>  LTP (Linux Test Project)
>  M:	Andrea Cervesato <andrea.cervesato@suse.com>
>  M:	Cyril Hrubis <chrubis@suse.cz>
>=20
> --=20
> 2.51.0
>=20

--NOfbYS7pJJYrvl13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNWXigAKCRB4tDGHoIJi
0qjBAQCK0FwCo4J6VNYKXGN7DAklkUROwwlUJ2XruMTbIzpCpgEA5B0VduNMH7Bc
XQGuXdfkq3ChPsYaFdszHuMhSFNrLwE=
=F7gn
-----END PGP SIGNATURE-----

--NOfbYS7pJJYrvl13--

