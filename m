Return-Path: <linux-iio+bounces-25354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB827BFD6DD
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 19:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F63189074A
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956762638B2;
	Wed, 22 Oct 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSaxwcYR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9FD1F63D9;
	Wed, 22 Oct 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152448; cv=none; b=NisM2vrvwzdju1g6oE0uqaC4iLtARYvHWmPFyEQ2VIppGbezXYhqVyXKrCbpfYA60G/bNKHGfoQzVFeYqbxYhgkpoxdRnv9M0vK6D8QsSmbI87FoqNSpnVVkPJgoiuIq50w8wVTCSTwM2TyarFnUO9eSJTtUjZP/yhDKEuR2Duk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152448; c=relaxed/simple;
	bh=SJFlazEtm8bU1PqI+Ip5NI92gSiRot30yqSpwLlPL5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfIRoM1gdThHkAz43PM8fJ7AjwoahTzlVecpAc9bVRwRiG7EbrIAqpKauVf2dVRCofC0gTV2VStS8MkTotZiz7Z1sJVhhhJtSwmzDEbpkCqnq8hLWE7wPKAxDunNJFusE4ySy50Y2M398fIDk8VHrob5vDEVcEXixR9Nk7cv2bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSaxwcYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B82CC4CEE7;
	Wed, 22 Oct 2025 17:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761152447;
	bh=SJFlazEtm8bU1PqI+Ip5NI92gSiRot30yqSpwLlPL5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSaxwcYR899oCpILFf0Wn06yWMAKWI1bGpOsg2m9KJXUV8EDY/K4t0kThpAEmVkHt
	 VLYu5yLWkwHukU8oumiGUv6JgfRiIVC4GWjgFDYjotGHFI0e0rioLhMh0Ev8dTkFrw
	 ttqp8pkuY9UGpym8eyIwp5i2YppqoMCPicg4hi0ukV357zoLDUyolMZj/bl3KDeE7T
	 /k6wYkL139wjO6HCXSNIA9TOfy/RnZDM/roLdpbCWbsa7ae18ugOo6V1jFeYn6cDJT
	 zJuTWEzaTXru6zaQiNG25vOtWqTK7Dd1TlZG1blyqj5xUBQNfFrv95OU3aiOmK+eKk
	 CPei+P8ZF5TPw==
Date: Wed, 22 Oct 2025 18:00:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Justin Weiss <justin@justinweiss.com>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: iio: pressure: Remove vdd-supply and
 vddio-supply from required list
Message-ID: <20251022-obscurity-bulldog-bf9b50dcc127@spud>
References: <20251022164154.2994517-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xWzJRU5tQank2y47"
Content-Disposition: inline
In-Reply-To: <20251022164154.2994517-1-Frank.Li@nxp.com>


--xWzJRU5tQank2y47
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:41:51PM -0400, Frank Li wrote:
> Some board designs connect vdd and vddio to the system power supply. Remo=
ve
> these properties from the required list and make them optional, since
> drivers/iio/pressure/mpl3115.c does not use them.

That just reads as if the supplies are still required, just the source
of the power has changed.

>=20
> Fix below CHECK_DTBS warnings:
> arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: pressure-sensor@60 (fsl,mpl=
3115): 'vdd-supply' is a required property
>         from schema $id: http://devicetree.org/schemas/iio/pressure/fsl,m=
pl3115.yaml#
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.y=
aml b/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
> index 2933c2e10695e..04703a01cf7af 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
> @@ -47,8 +47,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - vdd-supply
> -  - vddio-supply
> =20
>  additionalProperties: false
> =20
> --=20
> 2.34.1
>=20

--xWzJRU5tQank2y47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkNtwAKCRB4tDGHoIJi
0thyAPoDI/5v70JlUWJtZ6WOYrSszKcHZYZPDKhQkDq2sFbI2gD+MRdZiHopbC22
KW1pIWtYJaGWOq+s7KUUDfYPsjb2Hwo=
=ZjYD
-----END PGP SIGNATURE-----

--xWzJRU5tQank2y47--

