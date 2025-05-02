Return-Path: <linux-iio+bounces-19006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BFEAA774B
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 18:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60BA3AD6B9
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91163257440;
	Fri,  2 May 2025 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDtQZoNv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB31EEE6;
	Fri,  2 May 2025 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746203419; cv=none; b=tIq+kr9OAINVcC0+FqIua32UopqYnT+FgYedZ423/pKwaHUl5KV3HcWdUct+EyeONk8F0eL/mUx6bcIgCuQG/oYx6yZvzXB7Vzqwa/KWz5duxEsJZ5XMUt39uG3KzMZkySUMIxxTxwBIlXqZyvn+/kpgSH/grVZjNaqHir2Dr4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746203419; c=relaxed/simple;
	bh=EpbjrjQeBOmnCpxYDHoY++MSJMrwC1iPEWEi23m1lO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6rfySxQSDRBz9nFpXeGeSACfJQADo2zRx2eHC+xrQ2nlGzVGQsX5GBNEfGkiES7/PjSEUIkAmtotmKAlTz0zcFD6W4EEd02LURnaLVvjueG2oeKdbhttZfs1b+BcCcqvpXyx0shM+IwAgVzQ/JY/tY6S5oMm5OyJz2zN9Nqaeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDtQZoNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3DAC4CEE4;
	Fri,  2 May 2025 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746203418;
	bh=EpbjrjQeBOmnCpxYDHoY++MSJMrwC1iPEWEi23m1lO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDtQZoNv3cL3FOfTEYBe1NF+bWdWh2+E+X7U/ShyvXhUmYjdAY3d5DELCw45a+Y6e
	 1p1vMCQ+JK29fe1vfYQ6Ikkh0M5aTIRAhd6yFD2q7MuATUw+kVYPlJlYzx+iOXOWpW
	 5SerVYfBPrK+2dK9qmH6AyUM2Yyjfq1U5vz2QwvQ3S4uu3L0hLG/HrfTdtSe9tHRVK
	 8F/7KwwCLaxcanaHlYrBwz3yjSbyLeoxaYFRBGg6tGnQuWDhqkzyVJBCP8ITvEwtVF
	 RTgzfAbdHwURWBosZlc5Y04pLnUmKrvznn1r+gznWn3Ny+Utq00x2IgOH/QTRePRAw
	 JvsDz1WxjyCiQ==
Date: Fri, 2 May 2025 17:30:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: iio: adc: adi,ad7606: add gain
 calibration support
Message-ID: <20250502-yarn-answering-f395beaa1440@spud>
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
 <20250502-wip-bl-ad7606-calibration-v2-4-174bd0af081b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HfgoTnyluTIFnd9A"
Content-Disposition: inline
In-Reply-To: <20250502-wip-bl-ad7606-calibration-v2-4-174bd0af081b@baylibre.com>


--HfgoTnyluTIFnd9A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 03:27:01PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add gain calibration support by a per-channel resistor value.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 29 ++++++++++++++++=
++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 29f12d650442b8ff2eb455306ce59a0e87867ddd..d4b8ea51f60be367e79a4db18=
d932cbca9c7dc91 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -204,6 +204,15 @@ patternProperties:
>            considered a bipolar differential channel. Otherwise it is bip=
olar
>            single-ended.
> =20
> +      adi,rfilter-ohms:
> +        description:
> +          For ADCs that supports gain calibration, this property must be=
 set to
> +          the value of the external RFilter resistor. Proper gain error
> +          correction is applied based on this value.
> +        default: 0
> +        minimum: 0

Perhaps obvious to those working on these ADCs, but this is a series
resistor so a default of zero for the existing devices makes sense.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> +        maximum: 65536
> +
>      required:
>        - reg
>        - bipolar
> @@ -256,6 +265,25 @@ allOf:
>        properties:
>          adi,oversampling-ratio-gpios: false
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7605-4
> +              - adi,ad7606-4
> +              - adi,ad7606-6
> +              - adi,ad7606-8
> +              - adi,ad7607
> +              - adi,ad7608
> +              - adi,ad7609
> +              - adi,ad7616
> +    then:
> +      patternProperties:
> +        "^channel@[0-9a-f]+$":
> +          properties:
> +            adi,rfilter-ohms: false
> +
>    - if:
>        properties:
>          compatible:
> @@ -398,6 +426,7 @@ examples:
>                  reg =3D <8>;
>                  diff-channels =3D <8 8>;
>                  bipolar;
> +                adi,rfilter-ohms =3D <2048>;
>              };
> =20
>          };
>=20
> --=20
> 2.49.0
>=20

--HfgoTnyluTIFnd9A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBTzFQAKCRB4tDGHoIJi
0vZBAQD2cyiq/b9QR+BcUGzKmRbVuDtTnqIln/sWTRPzGOYiXAEArB2eBMq4S9EA
cIhDP1W+NVvY9Nr7KbNiBI8o7Y7WNwQ=
=nmcM
-----END PGP SIGNATURE-----

--HfgoTnyluTIFnd9A--

