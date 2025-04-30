Return-Path: <linux-iio+bounces-18905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38043AA50A1
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 17:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851B69C1BB7
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56E2609FE;
	Wed, 30 Apr 2025 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPXSIeo8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AF02609F4;
	Wed, 30 Apr 2025 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746027782; cv=none; b=aBE4BzG3a8vEi+Dv5cuVlLBucI8rABjlj8CcVm9n1Y6skscnPQbHfgJY/XoXhJDJfvpkHfqlcOVGScpfAQg9kVScOSCt+xbSwg1S02M69l6lYf4LVuKZq5iYnii4xoIgO7ZpaNnnFNVh2AqbszonE/Z919XXRPzxOOxkWb7xvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746027782; c=relaxed/simple;
	bh=cMohmDDOMvrG0cwSob/om89yJTT/ehRLLR48RgsOAo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5u4DfipFPGZRMRvjaDcSwdHLHdxEznQwNYBNdwmSvZ6ATXE32GcSYBiFuujFJ+RXiStBfj4SPO35edHy5yVWnA22rvsPHgFeWWGesUpRKNKxLmpy8R3SB0jf4MFVAnGOZuuzR/ep4KjWGz1mQ+1FlQTUrrE169NgWOGhFGA+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPXSIeo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8039C4CEEC;
	Wed, 30 Apr 2025 15:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746027781;
	bh=cMohmDDOMvrG0cwSob/om89yJTT/ehRLLR48RgsOAo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPXSIeo8HMGd3tm0i8k6eHxDGrAkRqfT6/6UdIcX7j3ac35cEXK4mBLh42b+maAko
	 UxBX3Y56+gydf0wp6iq5VKMuwgY+gp8piPGz8zZvWpjZs4J6BP/aQMWq2N5KiMQqPf
	 2KP5LmWESocF5N4nyYaejbAp4nqStVOOJWbbIJPED1KarR51MVWXIKET77EUR4xN8D
	 zp3BAY2gTyzQbw2cOX2WI5sLJI5UnYV8S3rltVzRUakD6y6f0e59nwj2uXOwnToJbn
	 kg5ElxnTfJXHA3VePv2FUJ6ys1+qB4Agvv+lNMg2hxBVv1kLQUuK4Gcl7UZujd9T35
	 NMn/PXQXLbIkQ==
Date: Wed, 30 Apr 2025 16:42:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings:iio:adc:st,spear600-adc: txt to yaml
 format conversion.
Message-ID: <20250430-folic-skittle-06b0ccbedf35@spud>
References: <20250430020248.26639-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibWcqrFQAaMOHemi"
Content-Disposition: inline
In-Reply-To: <20250430020248.26639-1-rodrigo.gobbi.7@gmail.com>


--ibWcqrFQAaMOHemi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Apr 29, 2025 at 10:50:01PM -0300, Rodrigo Gobbi wrote:
> Straight forward conversion from spear-adc.txt into yaml format.
>=20
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> Some constraints were extracted from the driver (spear_adc.c) and the pub=
lic datasheet
> referenced at the yaml.
>=20
> Changelog:
> v2: add constraints over properties and remove a ref at MAINTAINERS file.
> v1: https://lore.kernel.org/linux-devicetree/20250423022956.31218-1-rodri=
go.gobbi.7@gmail.com/
> ---
>  .../bindings/iio/adc/st,spear600-adc.yaml     | 69 +++++++++++++++++++
>  .../bindings/staging/iio/adc/spear-adc.txt    | 24 -------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 70 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,spear600=
-adc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/staging/iio/adc/spe=
ar-adc.txt
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.ya=
ml b/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
> new file mode 100644
> index 000000000000..afce10eab1c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/st,spear600-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ST SPEAr ADC device driver
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>
> +
> +description: |
> +  Integrated ADC inside the ST SPEAr SoC, SPEAr600, supporting
> +  10-bit resolution. Datasheet can be found here:
> +  https://www.st.com/resource/en/datasheet/spear600.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,spear600-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  sampling-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 2500000
> +    maximum: 20000000
> +    description:
> +      Default sampling frequency of the ADC

I think you should note that this is in Hz, while you're at it.

> +  vref-external:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1000
> +    maximum: 2800
> +    description:
> +      External voltage reference in milli-volts. If omitted
> +      the internal voltage reference will be used.
> +
> +  average-samples:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 128
> +    default: 0

Is 0 the default here or 1? "Single data conversion" sounds more like 1
sample than 0, and the default of 0 is below the minimum of 1. What's
going on there?


> +    description:
> +      Number of samples to generate an average value. If
> +      omitted, single data conversion will be used.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - sampling-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc: adc@d8200000 {

The "adc:" label here can be removed, it's not doing anything!

> +        compatible =3D "st,spear600-adc";
> +        reg =3D <0xd8200000 0x1000>;
> +        interrupt-parent =3D <&vic1>;
> +        interrupts =3D <6>;
> +        sampling-frequency =3D <5000000>;
> +        vref-external =3D <2500>;	/* 2.5V VRef */
> +    };
> diff --git a/Documentation/devicetree/bindings/staging/iio/adc/spear-adc.=
txt b/Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
> deleted file mode 100644
> index 88bc94fe1f6d..000000000000
> --- a/Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -* ST SPEAr ADC device driver
> -
> -Required properties:
> -- compatible: Should be "st,spear600-adc"
> -- reg: Address and length of the register set for the device
> -- interrupts: Should contain the ADC interrupt
> -- sampling-frequency: Default sampling frequency
> -
> -Optional properties:
> -- vref-external: External voltage reference in milli-volts. If omitted
> -  the internal voltage reference will be used.
> -- average-samples: Number of samples to generate an average value. If
> -  omitted, single data conversion will be used.
> -
> -Examples:
> -
> -	adc: adc@d8200000 {
> -		compatible =3D "st,spear600-adc";
> -		reg =3D <0xd8200000 0x1000>;
> -		interrupt-parent =3D <&vic1>;
> -		interrupts =3D <6>;
> -		sampling-frequency =3D <5000000>;
> -		vref-external =3D <2500>;	/* 2.5V VRef */
> -	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 906881b6c5cb..e923becb0633 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23213,7 +23213,7 @@ STAGING - INDUSTRIAL IO
>  M:	Jonathan Cameron <jic23@kernel.org>
>  L:	linux-iio@vger.kernel.org
>  S:	Odd Fixes
> -F:	Documentation/devicetree/bindings/staging/iio/
> +F:	Documentation/devicetree/bindings/iio/

This change seems unneeded? The main iio entry already covers this
directory. I think you can probably just drop the line from the staging
entry?

Cheers,
Conor.

>  F:	drivers/staging/iio/
> =20
>  STAGING - NVIDIA COMPLIANT EMBEDDED CONTROLLER INTERFACE (nvec)
> --=20
> 2.47.0
>=20

--ibWcqrFQAaMOHemi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBJFAQAKCRB4tDGHoIJi
0qoZAQDMrzTgfpSpUUMuUtE0d9/Zi/zzTpVR+Xi53kujOqwQjQD8Cgaqm53v5yQ+
jXxwetXO7DVqdp252PPgH3lDXLq1+AU=
=VweJ
-----END PGP SIGNATURE-----

--ibWcqrFQAaMOHemi--

