Return-Path: <linux-iio+bounces-6947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A38917FCD
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 13:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03A6287877
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 11:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D726917F39A;
	Wed, 26 Jun 2024 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0YLvAdE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4FF148FE3;
	Wed, 26 Jun 2024 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401685; cv=none; b=XOiScjwzMat466cC1vn27YL24aquW3fSiaUs8uMV6Cl3S6LngU8HpFk9+PskIAg0VkTELz64/FiPlstpil86cCpGh4B6grOV7tTOPpA7NKcGEXFip0xXSsBVcjGDLa39sWMFyejdxRu8Kbf/+FylElkfuZ8+GevTE6gsCAPIDi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401685; c=relaxed/simple;
	bh=qbiy6Fgp2bm0hkADsq5IGcGBc9I/3nBS4s5u3d1poSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojzxlRWIYGmW91pHf2xZNJ+t5+lbLETJbQ2T5bnymSqmdrpY2aMlVHtbOSXZ2sTeCs1fTewjlloVOFdK3ksy5npqj0Ue95u8rbJHoRAt3+QnbuSjFU2CRnMJcm2P+peyostfOoMyQCH9A57UZpwnnVRrZS1hBz54pDEI5f8Ypek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0YLvAdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A2FC2BD10;
	Wed, 26 Jun 2024 11:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719401685;
	bh=qbiy6Fgp2bm0hkADsq5IGcGBc9I/3nBS4s5u3d1poSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0YLvAdEG+rYvLPWUP2jCiTS/JopkRtuPMsE3URFpkubiMX+wUKPF2ONR1Mg3O6r/
	 ZtLrjgeLuN1p2IvyYpBsDYsy57VTpq6xfUu8Z9nzX6GtOEetvcXabiwUoYhtEUkQDq
	 0EFcFK909NUINO2NTMH4q/0OcdEHOOaspP92EHuCX3P92nk4wNG4S5vjbHpvrlwtZM
	 5TlbqoYRQVtE/Teqw7l71o6n+OSzaOyAVY1lrgnNWe3a7rDWfFhDRSMzmI1Zj81A3O
	 OZO+EGZOmPWsx7/qWwEJwqETLNQrkpKXT+U+PyJi7Hvuw4DjYvX/43TN0E0TeFL0nC
	 olKJqS8JAh/Ww==
Date: Wed, 26 Jun 2024 12:34:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: broonie@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, corbet@lwn.net,
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/7] dt-bindings: iio: adc: Add AD4000
Message-ID: <20240626-handbrake-mustang-38c2aab3f04b@spud>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
 <10678612efbbd97bb47a31f4a062607cf35b03f9.1719351923.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QP1fq927jihdQdME"
Content-Disposition: inline
In-Reply-To: <10678612efbbd97bb47a31f4a062607cf35b03f9.1719351923.git.marcelo.schmitt@analog.com>


--QP1fq927jihdQdME
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 06:55:03PM -0300, Marcelo Schmitt wrote:
> Add device tree documentation for AD4000 series of ADC devices.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad4000.yaml          | 190 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 197 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> new file mode 100644
> index 000000000000..76035dff5474
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> @@ -0,0 +1,190 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4000 and similar Analog to Digital Converters
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +
> +description: |
> +  Analog Devices AD4000 family of Analog to Digital Converters with SPI =
support.
> +  Specifications can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4000-4004-4008.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4001-4005.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4002-4006-4010.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4003-4007-4011.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4020-4021-4022.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
adaq4001.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
adaq4003.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: adi,ad4000
> +      - items:
> +          - enum:
> +              - adi,ad4004
> +              - adi,ad4008
> +          - const: adi,ad4000

> +      - const: adi,ad4001
> +      - items:
> +          - enum:
> +              - adi,ad4005
> +          - const: adi,ad4001

> +      - const: adi,ad4002
> +      - items:
> +          - enum:
> +              - adi,ad4006
> +              - adi,ad4010
> +          - const: adi,ad4002

> +      - const: adi,ad4003
> +      - items:
> +          - enum:
> +              - adi,ad4007
> +              - adi,ad4011
> +          - const: adi,ad4003

> +      - const: adi,ad4020
> +      - items:
> +          - enum:
> +              - adi,ad4021
> +              - adi,ad4022
> +          - const: adi,ad4020

> +      - const: adi,adaq4001

> +      - const: adi,adaq4003

I think some blank lines, maybe like the above, would go a long way with
this list of compatibles.

> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 102040816 # for VIO > 2.7 V, 81300813 for VIO > 1.7 V
> +
> +  adi,sdi-pin:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ high, low, cs ]

    enum: [ high, low, cs, sdi ]
    default: sdi

I'd do this, so that the default is documented in the binding, not in
the description text.

Otherwise, this looks good to me.

--QP1fq927jihdQdME
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnv8zwAKCRB4tDGHoIJi
0niZAP9rjml4FX9J5YcHZEsoDTdGZp2QtDDXoMjlf4egM1sttAD9HWoM7tT1u3x2
BfEys783Oxp2baO4Uey0cJifxyCBVAU=
=iNmk
-----END PGP SIGNATURE-----

--QP1fq927jihdQdME--

