Return-Path: <linux-iio+bounces-27997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2978FD3B5DA
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ED3B305EF88
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078D32D7FB;
	Mon, 19 Jan 2026 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGLOWVbE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C721FF7C8;
	Mon, 19 Jan 2026 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847278; cv=none; b=aCq88BXCyfQpji3ohbKs5s8fsgmpvqXqvp6kufRqidcolY2uFZkmNi97vt3s8kR6vHG6pEu9AiIjeoNUhaa7/q/zHhE8VsK4uK947+MbVHtHBk376Hffyc+TcW+IZ+u/V4Kk48RNzLbannEh4COrhvPJLsvky9+nzDCCLwyIOgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847278; c=relaxed/simple;
	bh=L6kd6rK56lAvDVoyrMuozTE2tPG4+fjmRT1394CuikI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K98q9FnsuSpswkjfOZ4nh+1ejaJQ/TNNN69Hr+2Rki4hYC37sEz/giCv38IGYUlHF8NjzUq6ySkGfvoakmy6Zux7xh8Z+OER1DucHOudELXzcXx9lxLVYctFUE2MzcsAQoep3HakVcTR9DyeV/oKMyyoG7OlNgnMe1NitMhKxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGLOWVbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E65AC116C6;
	Mon, 19 Jan 2026 18:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768847277;
	bh=L6kd6rK56lAvDVoyrMuozTE2tPG4+fjmRT1394CuikI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGLOWVbEfQCIRh9xOOpN2qeXbWNg/Dvd0OCWxPhGYaSz2gKwAdLLj0vMdjiyNve6E
	 M/5trnvZUE7WEbQ6Sr0sfjI2F5aA3u0Tjhn8q9M3TEXhDEMw/pTIPCAXmH2IpnSQHe
	 Q9nO/FQi4dCCSgA2dZu+9sYhWLA1vdHG9ccqz3A1e/WLjiJOPlvgPNrDr72Hh/SKfT
	 uBU+iqBAHErw0onk3qqAjvApToStzxjOV0zbU0ol556+WDNPe4U6vymFykvdPdkmJr
	 xX3J7U+JZcHgefX2fh/6l+GCuOJ0LSPv/hGVOhe2ivIywP4C+BM8dFXWDoWUa+crAa
	 OYRfIuWEiAIDA==
Date: Mon, 19 Jan 2026 18:27:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 2/8] dt-bindings: iio: dac: maxim,ds4424: add
 maxim,rfs-ohms property
Message-ID: <20260119-turbine-feminize-9dcd5c86feec@spud>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
 <20260119182424.1660601-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="paRMaVr6zOe1oSdk"
Content-Disposition: inline
In-Reply-To: <20260119182424.1660601-3-o.rempel@pengutronix.de>


--paRMaVr6zOe1oSdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 07:24:18PM +0100, Oleksij Rempel wrote:
> Introduce the 'maxim,rfs-ohms' property. The full-scale output current
> of these DACs is determined by external resistors (Rfs) connected to
> the FS pins. The driver requires the physical resistance values to
> calculate the correct current scale (Amps per step) for the IIO
> subsystem.
>=20
> Keep it optional to avoid forcing updates of existing DTs; without it
> the driver cannot derive a correct IIO scale.

I don't really follow the logic here, if the driver doesn't work
properly without it, shouldn't it be a required property even if that
means existing devicetrees get new warnings? Warnings are preferable to
the drivers malfunctioning on those devices, after all!

>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/iio/dac/maxim,ds4424.yaml     | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml =
b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> index efe63e6cb55d..b7af8464a4fc 100644
> --- a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> @@ -27,6 +27,17 @@ properties:
> =20
>    vcc-supply: true
> =20
> +  maxim,rfs-ohms:
> +    description: |
> +      Array of resistance values in Ohms for the external Rfs resistors
> +      connected to the FS pins.
> +      - For DS44x2 (2 channels): 2 values required.
> +      - For DS44x4 (4 channels): 4 values required.
> +      Typical values range from 40000 (40 kOhm) to 160000 (160 kOhm).
> +    minItems: 2
> +    maxItems: 4
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.47.3
>=20

--paRMaVr6zOe1oSdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaW53qAAKCRB4tDGHoIJi
0ja0AP0TeEviw0mZoPm+Cxsj90U0d9I6xz7Gx3TbUYd75BFq5gEAsyxvEA+QRSuP
Zabnl5yBcc0ghRYkX2TvzMoFVSNMCgI=
=xqx7
-----END PGP SIGNATURE-----

--paRMaVr6zOe1oSdk--

