Return-Path: <linux-iio+bounces-7364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E31A9928B09
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 17:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A582B25665
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 15:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F4154C11;
	Fri,  5 Jul 2024 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJcdLZ6t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C321BDDC;
	Fri,  5 Jul 2024 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191683; cv=none; b=T+BIxP8tsE2dCCjluQONotiikEeoWioqI71f888LPUGZKULC8sGJYpFVYHyyzEjlW0f8IWBiBvLuB+nV3Wzsb9p4I4+IlNWW8gGIXz9ixLa8/PLgwhinddEI/Rd4pHoIvGax8uVduBYNrP8GdTqRmbSOgMjPOfqzSq6YytIWC7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191683; c=relaxed/simple;
	bh=xEoppWy0KqDVp9QxcL7rzFgPsmzQXswT2gXTdcrZA/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLOKAVqrHMfEtqbfHxUJ5SxZTatw+olwWGbZSX2Py4q2uoceQ2wAs+8hFyzJiSDTmyDjkPP7iETQ2DinsxUeQ6CPuyhqgocwmhRHycQeV1H6qMSDgosxfk4Hh2a9NZT+I+0O/gtuO/9zdyzobNxJCd9Q/nXs+R5O3m+tovCgtds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJcdLZ6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630D1C116B1;
	Fri,  5 Jul 2024 15:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720191682;
	bh=xEoppWy0KqDVp9QxcL7rzFgPsmzQXswT2gXTdcrZA/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJcdLZ6tECRRBILi98BHYGvO9qjylZnL2oVf7RRyX4bk8aaaktei/fm5RbUE4ZvUR
	 DZix8dkn/ovADFeS3oVmNF+p7GficsV4yPuzp3tgM0gDZMo5bBfslDMG+V9dyXmYkW
	 xctYTsj7Mey6zvp0vqSxxtC/DMaRXiGZhIfAsi97x9bl71zJc+qmajUCymzGlz+IXP
	 oAxCubPSbxQzejO28pRdoxoXLhw4WlT1A6gl5sdcG+YFWcyTVT7hCSc9pGq8kVx0cy
	 3O1aXk1WBrOyagNWE+kU/pQmIuVWI37gi7xWQjRlIJlM3/v5tyQa6TPfNPaKGz8+Y1
	 it5ieQhVJoFmg==
Date: Fri, 5 Jul 2024 16:01:17 +0100
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
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml:
 Add Sophgo SARADC binding documentation
Message-ID: <20240705-unaired-pesticide-4135eaa04212@spud>
References: <20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com>
 <20240705-sg2002-adc-v2-1-83428c20a9b2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xMmRnVLDUviAWcqC"
Content-Disposition: inline
In-Reply-To: <20240705-sg2002-adc-v2-1-83428c20a9b2@bootlin.com>


--xMmRnVLDUviAWcqC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 03:42:23PM +0200, Thomas Bonnefille wrote:
> The Sophgo SARADC is a Successive Approximation ADC that can be found in
> the Sophgo SoC.
>=20
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>  .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 63 ++++++++++++++++=
++++++
>  1 file changed, 63 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-sara=
dc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.ya=
ml
> new file mode 100644
> index 000000000000..31bd8ac6dfa5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-saradc.yaml#
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
> +    oneOf:
> +      - items:
> +          - enum:
> +              - sophgo,cv1800b-saradc
> +          - const: sophgo,cv18xx-saradc

I don't think the fallback here makes sense. If there's other devices
with a compatible programming model added later, we can fall back to the
cv1800b.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      SARADC will use the presence of this clock to determine if the con=
troller
> +      needs to be explicitly clocked by it (Active domain) or if it is p=
art of
> +      the No-Die Domain, along with the RTC, which does not require expl=
icit
> +      clocking.

What does "explicit clocking" mean? Is it clocked directly (or via
dividers) by a clock on the board or another source?

Cheers,
Conor.

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sophgo,cv1800.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    /* ADC in the Active domain */
> +    adc@30f0000 {
> +        compatible =3D "sophgo,cv1800b-saradc", "sophgo,cv18xx-saradc";
> +        clocks =3D <&clk CLK_SARADC>;
> +        interrupts =3D <100 IRQ_TYPE_LEVEL_HIGH>;
> +        reg =3D <0x030F0000 0x1000>;
> +    };
> +  - |
> +    #include <dt-bindings/clock/sophgo,cv1800.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    /* ADC in the No-Die domain */
> +    adc@502c000 {
> +        compatible =3D "sophgo,cv1800b-saradc", "sophgo,cv18xx-saradc";
> +        reg =3D <0x0502C000 0x1000>;
> +    };
>=20
> --=20
> 2.45.2
>=20

--xMmRnVLDUviAWcqC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZogKvQAKCRB4tDGHoIJi
0giYAQCgNHCyz5yAdPei9eufgsMfJqNkiZDfQ8RrCap1Y6BZqwD/VGne9AxOjshS
nixXIYG/eV1vC5giJbjCGbmArAA8nwM=
=k1hL
-----END PGP SIGNATURE-----

--xMmRnVLDUviAWcqC--

