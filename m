Return-Path: <linux-iio+bounces-17831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2600A8122E
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 18:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46BEA7B0F06
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 16:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354A922E3FA;
	Tue,  8 Apr 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lcz9Sx02"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCD222DFA4;
	Tue,  8 Apr 2025 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129436; cv=none; b=PPENIHTw/yEsWDxW7Fwj1RC7/pBLss6X3m0P7PhyZVkK8cwvaR6u7Rbd+If4PPqkdFXduN7pdpHJyGKiHV2I6xzMi1JlA1rrO0u0cylJXQnpu0FWoee+mt1adYyQBiqbB+C3CUIQuj1VF+JE67lGmOo6BuAb+Z+y8Ubz00t25cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129436; c=relaxed/simple;
	bh=weuM5HHgCtZNBPja0bMhFSdjHzltz9a4z0dVDbIuEn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br5EmkZnXVUlKqOdgNFsYsmc1IoQ23KVmUaDdk3dQfZYJVBhA6jO2s4i06IPBtUjiHMG3BrhlVil/dJRnyZXmNr7PsLhWNOzjJ5s7VyZqqkDqeY3GGVVgE7Hbt/58JkLn6qJb6qNVUndp5ZC7tQykkm1VH0eaeFfEUWBYbaANx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lcz9Sx02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D56C4CEE5;
	Tue,  8 Apr 2025 16:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744129435;
	bh=weuM5HHgCtZNBPja0bMhFSdjHzltz9a4z0dVDbIuEn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lcz9Sx02EkL93wNfEQgiN+4bu3Mry8XBiie4IWFmbJrdYzR/7HOm+EMCwxM7u3jgh
	 cBv0DAJ327eotLodf2+R0WA+3bLPy8XI62PDSNVk+YNvNiYn/80foCrXRuCH1Ic6D8
	 0LgCE4wao6dnF1ZKlaF08T5mogoE+pgj2rEfownT/ffUmkbfq9oko0pSKTcVFZo0Dq
	 NuFtqn/rRJVEBo3MPw79Utp+zu4zgUhqhN8iFcPyEr+J4w6xlbyHtFtqYp1YgHKe/l
	 w2Z3ke6GiXlNbL5tiRBAOp9npfJ/+5AxXvNebMrzkulSrjIXUQV0yPGX0IAE/CGN/k
	 Tt/+3/Dz0whZg==
Date: Tue, 8 Apr 2025 17:23:51 +0100
From: Conor Dooley <conor@kernel.org>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: icm42600: add interrupt
 naming support
Message-ID: <20250408-dandy-rental-c76bcb4a5788@spud>
References: <20250407-iio-imu-inv-icm42600-rework-interrupt-using-names-v2-0-c278acf587b2@tdk.com>
 <20250407-iio-imu-inv-icm42600-rework-interrupt-using-names-v2-1-c278acf587b2@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ct6e+utvgFb1PaQy"
Content-Disposition: inline
In-Reply-To: <20250407-iio-imu-inv-icm42600-rework-interrupt-using-names-v2-1-c278acf587b2@tdk.com>


--ct6e+utvgFb1PaQy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 09:57:16PM +0200, Jean-Baptiste Maneyrol via B4 Rel=
ay wrote:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
> Add interrupt-names field for specifying interrupt used. Only INT1
> is supported by the driver currently.
>=20
> Add minItems 1 for interrupts since interrupt is mandatory for the driver.
>=20
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml    | 13 +++++++=
++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm4260=
0.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> index 7e4492bbd0278a336587dc5ac04da7153453da29..707f2169ce9a3ca41d81560be=
d15786fe010109e 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> @@ -41,6 +41,17 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 1
> +    items:
> +      enum:
> +        - INT1
> +        - INT2

I might be misremembering from looking up the datasheet, but it gave the
impression that either all interrupts can be wired to int1 or int1 and
int2 are usable. How come maxItems is set to one here, not two? Surely
someone could wire them both up, even if the driver only ever uses the
former.

> +    description: |
> +      choose chip interrupt pin to be used as interrupt input, beware th=
at the
> +      only support interrupt pin is INT1 for the moment.

What linux supports should not be part of the hardware description.

> +
>    drive-open-drain:
>      type: boolean
> =20
> @@ -76,6 +87,7 @@ examples:
>              reg =3D <0x68>;
>              interrupt-parent =3D <&gpio2>;
>              interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names =3D "INT1";
>              vdd-supply =3D <&vdd>;
>              vddio-supply =3D <&vddio>;
>          };
> @@ -95,6 +107,7 @@ examples:
>              spi-cpol;
>              interrupt-parent =3D <&gpio1>;
>              interrupts =3D <2 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names =3D "INT1";
>              vdd-supply =3D <&vdd>;
>              vddio-supply =3D <&vddio>;
>          };
>=20
> --=20
> 2.49.0
>=20
>=20

--ct6e+utvgFb1PaQy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/VNlwAKCRB4tDGHoIJi
0rS2AQCnm9DYKRvtnDPGowZ4dvJAqiYQE6oES141rk+xib1wuAEA9xoFkksxQwRU
fLx3hu6Y9gvxMJR06DgEn+9VQ5/+NgU=
=a6IA
-----END PGP SIGNATURE-----

--ct6e+utvgFb1PaQy--

