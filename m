Return-Path: <linux-iio+bounces-8426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8E094F223
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 17:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163762836BA
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 15:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4960D185E7A;
	Mon, 12 Aug 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNvjyIvY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F74D112;
	Mon, 12 Aug 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477995; cv=none; b=HOywH5Sg6qjvwjVg5WZT537ExyrLfUDZVwlG59vkWb3cPMwV65f3C7CiqQV8A6V2gd3YT6wEEpEO8YMySuBciJzgWmpqQk8XufVP1AaGcgFQjMH/w6LgYv5mmexqPkgqhfWmMMa4Cf+z91nXbotBdK2gC3Ndr6a4//uEQrMAgh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477995; c=relaxed/simple;
	bh=HlRdvFKn4iFjzvom5J0DF55x13AYDpUEmQpaLh1Gggw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlJh3FGj/cWTbqMCzx0dHPu92+og9sPBhFTG5KUmAz5XeEU6BXOUnQXfuEsV1JK1ZP5gI9GTmqsoX6sz3SRHFFCLAHSudthwlhmiXWE65cV5POSaEDRS2fj8kXnK+OhuNn/NEZTkrb+7PeSUvwrG1+LRUKBdlmj48+A+zAGbZQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNvjyIvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433E9C32782;
	Mon, 12 Aug 2024 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723477994;
	bh=HlRdvFKn4iFjzvom5J0DF55x13AYDpUEmQpaLh1Gggw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNvjyIvYcUWCRotT7GQXgqUlrr5FSbUa41bF+C4Q8O9FFRsQi7TpfwO2qfPILOHLI
	 MF+lE2hpeNWcwGvlQSDyLXmIQgwb+YpXMz3VNQLUeGM71j8iMBfuYVcqFGZ+i3Y5wB
	 Va17H2VYVmfqjGUXSSc3oH4h7MJVVFEC6rm1ygQaF82Iwrre9WyHkpF42zFPXvkF2t
	 1Eehgat9ol63Z0l6MIrYBwGYslWQzKLWmZIK2TcfQIbJktRs56XmmZgaSa4JYrPb09
	 pw774D/pCJUrirfRHRn6YHv4Lm6g9p9J51Y5UpqLV9jXTrGhyDYiLT0JLszaRzrIi2
	 vNiqYIrH2WBTQ==
Date: Mon, 12 Aug 2024 16:53:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml:
 Add Sophgo CV18XX SARADC binding
Message-ID: <20240812-unwary-mongrel-9f6758bf624c@spud>
References: <20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com>
 <20240812-sg2002-adc-v4-1-599bdb67592f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IXMbfodZVYjINFLf"
Content-Disposition: inline
In-Reply-To: <20240812-sg2002-adc-v4-1-599bdb67592f@bootlin.com>


--IXMbfodZVYjINFLf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 05:00:55PM +0200, Thomas Bonnefille wrote:
> The Sophgo SARADC is a Successive Approximation ADC that can be found in
> the Sophgo SoC.
>=20
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>  .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 85 ++++++++++++++++=
++++++
>  1 file changed, 85 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-sara=
dc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.ya=
ml
> new file mode 100644
> index 000000000000..846590808e5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-saradc.yaml#

Filename matching the compatible please.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title:
> +  Sophgo CV18XX SoC series 3 channels Successive Approximation Analog to
> +  Digital Converters
> +
> +maintainers:
> +  - Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> +
> +description:
> +  Datasheet at https://github.com/sophgo/sophgo-doc/releases
> +
> +properties:
> +  compatible:
> +    const: sophgo,cv1800b-saradc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@[0-3]+$":
> +    $ref: adc.yaml
> +
> +    description: |

This | is not required.

> +      Represents the channels of the ADC.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can have up to 3 channels numbered from=
 0 to 2.
> +        items:
> +          - minimum: 0
> +            maximum: 2

Is this sufficient to limit the number of channels to 3? Aren't you relying
on the unique unit addresses warning in dtc to limit it, rather than
actually limiting with min/maxItems?

Otherwise, looks fine to me.

Cheers,
Conor.

> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sophgo,cv1800.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    adc@30f0000 {
> +        compatible =3D "sophgo,cv1800b-saradc";
> +        reg =3D <0x030f0000 0x1000>;
> +        clocks =3D <&clk CLK_SARADC>;
> +        interrupts =3D <100 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        channel@0 {
> +            reg =3D <0>;
> +        };
> +        channel@1 {
> +            reg =3D <1>;
> +        };
> +        channel@2 {
> +            reg =3D <2>;
> +        };
> +    };
>=20
> --=20
> 2.46.0
>=20

--IXMbfodZVYjINFLf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrov5QAKCRB4tDGHoIJi
0oaoAQDMe6NoYEYFRjr7uYTIB7DeEAi2qvZXnWVWHzFxwkkH8QEAw36aA0k+SIZe
JdTW3mWW5ZLezGEIrXTpuMaHzqoqWwQ=
=K9Up
-----END PGP SIGNATURE-----

--IXMbfodZVYjINFLf--

