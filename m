Return-Path: <linux-iio+bounces-26270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F4C65EDE
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 20:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1F8FC29334
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 19:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4117E332EAB;
	Mon, 17 Nov 2025 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5fb8kTd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5CD2C21DC;
	Mon, 17 Nov 2025 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407147; cv=none; b=cL6CEe/tMa/Uvtv311lX6RhD48TQ+bV8UKG4RuYLWkHuzmt9J7il99Oa91jWvLarS7bt8fvVJPBLfU2EQpUtJOm1RLYg8a51qwh7V8Ic4wmfAs8O/mBYsHvm7WsPAllNN6N+ZEklMriC2vqWfv5pHaigjeS2Ucpp9qGqx338y28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407147; c=relaxed/simple;
	bh=pdc2rdhvuxB1Oa8NpgMCujQh0ZDWSavBoRu5IkO/N0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkjWUVAd8fCnjOm882JV5UCzHl9LeCAm0r9cUCoo3lBsql8L3PyMuhA8MsvMF4OPboECA1sCeii5bB3uMN1HNK5cgq1m1eKogP0ylNOy1i/fyG+bLyACoNvzfoidNKqBkPCwdp4WflsaDfwRgtuADOKBXnNzgYM8L+muSNZzb0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5fb8kTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0DBC19421;
	Mon, 17 Nov 2025 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763407146;
	bh=pdc2rdhvuxB1Oa8NpgMCujQh0ZDWSavBoRu5IkO/N0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5fb8kTdCIZxNX5iu+ImZ9W7gigIiPJyd3X+XR5akyiP+Efryf+xBEQlvj6/bggEK
	 4gH1ESBKVwUWjt3RnLCCNfoRIVFNPTUcc9WQ09EUMZzp6KQt0/3pFJELCC3BszT5oe
	 fbV6tFvrZgsvAau0m4MMTrifzgo5aWm3Uw7RYlHsELNVFPFEhzEIzXKh5k83KPNO70
	 uMvP1CbVnSDHNFvNg8NTAg2Eq/nxIri0GzYXzmtdOzrtJaXbgGIISMik7uL1n741ar
	 noKOss3LES/uLPku+F1Gmh4ak+xSsfEORnCFzxFpAMwOMnRS3chEpH1R9iKZroefob
	 F2FaBC5x/b/yw==
Date: Mon, 17 Nov 2025 19:19:01 +0000
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: frequency: adf4377: add clk provider
Message-ID: <20251117-cloning-nickname-16a95d4b0795@spud>
References: <20251114115923.6043-1-antoniu.miclaus@analog.com>
 <20251114115923.6043-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SQq7q8Dw9jqiMkWO"
Content-Disposition: inline
In-Reply-To: <20251114115923.6043-2-antoniu.miclaus@analog.com>


--SQq7q8Dw9jqiMkWO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 11:59:22AM +0000, Antoniu Miclaus wrote:
> Add support for clock provider.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/frequency/adi,adf4377.yaml   | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.=
yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> index 5f950ee9aec7..dab1591a36b3 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> @@ -40,6 +40,12 @@ properties:
>      items:
>        - const: ref_in
> =20
> +  '#clock-cells':
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1
> +
>    chip-enable-gpios:
>      description:
>        GPIO that controls the Chip Enable Pin.
> @@ -99,4 +105,18 @@ examples:
>              clock-names =3D "ref_in";
>          };
>      };
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        frequency@0 {
> +            compatible =3D "adi,adf4378";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <10000000>;
> +            clocks =3D <&adf4378_ref_in>;
> +            clock-names =3D "ref_in";
> +            #clock-cells =3D <0>;
> +            clock-output-names =3D "adf4378_clk";

Why's the point of having "_clk" in a clock name?
Also, not sure you need a new example for this, could just put them in
the other example, no?

Drop the _clk at least, and then
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

> +        };
> +    };
>  ...
> --=20
> 2.43.0
>=20

--SQq7q8Dw9jqiMkWO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRt1JQAKCRB4tDGHoIJi
0haBAP9Vi5bdSlfZF77blYUge9AK3h4kfLU4NWiIbwvjkWCONQD9FCVr5kT480el
H3uEXOtM6h1IA4uZLpuOL8uGPdp7xwc=
=TTn0
-----END PGP SIGNATURE-----

--SQq7q8Dw9jqiMkWO--

