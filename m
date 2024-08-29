Return-Path: <linux-iio+bounces-8880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0CE964A73
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 17:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F14B1F24504
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879E1B3B05;
	Thu, 29 Aug 2024 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwHGbfry"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C6246B91;
	Thu, 29 Aug 2024 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946424; cv=none; b=lvzeL1J5Kunjw/LeOCQ3bldUQj5rMz/B3kgY4zYO5oWo4MlL/eIuiyWclesKLlRjs9lWGcoay7/Iq2ESxvbU5B+QmTiVntftpjHMQhiMqtc1we/WQayM7VTADwajkcoXQoNPVM6ZToUwrWvDrhKsZg3YPEHATuJKBgpUI1NZ43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946424; c=relaxed/simple;
	bh=U2cO3Y3eW0lQ0P74rSCozMZbvUMOSpflSpyK9zSbO78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+FHqqTd/ZA6TMLQyONU4Q62/keDh+LqljfrwLU/G6uJvzwjSWqsjAsL8OZTbyZdPbGiOAszia8PItZmktBgWhXtQ37gHj7PzmU2zcwfw5qa7E1FIN+GYDZc0O+y1A1Px0/vvxDwTrKvcPqKut3/Vesd37j99hCs6NxNPnX+CY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwHGbfry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84673C4CEC1;
	Thu, 29 Aug 2024 15:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724946424;
	bh=U2cO3Y3eW0lQ0P74rSCozMZbvUMOSpflSpyK9zSbO78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwHGbfryA5pNISl2VdFb/CZPZ6GmuYLxUjN5YgaH1cb6ii/dBL3MjgSj4oOGCsvvu
	 wHgna8VDhocU1eEpAIeLQ+T3NpacVqdP5x1DU5Ut7nG0JHHAt4xwUChOsYO5loQq8p
	 cj35odTMzWwnv0r39n4gJP62cgoBdFRoN3WGGpYq29wI3TDu+60nrGGrbvC+nlpQ72
	 s3t837McFO9ZoTGtyhXuFMZZahgQxztMeTV4Zb9UjoMpuHwfnoq+yPyjXswCURQh50
	 97wIfEn+FjjkbO4UpnAkratAG1zzFbXDUHNZ54qUmEOefVY2AnHz6xgfDluKLR2Eo8
	 6j5SpY3Pu0rLg==
Date: Thu, 29 Aug 2024 16:46:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH RFC 4/8] dt-bindings: iio: dac: add adi axi-dac bus
 property
Message-ID: <20240829-stopwatch-morality-a933abb4d688@spud>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FtoiXBdIW3OmYFeF"
Content-Disposition: inline
In-Reply-To: <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>


--FtoiXBdIW3OmYFeF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 02:32:02PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add bus property.

RFC it may be, but you do need to explain what this bus-type actually
describes for commenting on the suitability of the method to be
meaningful.

>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b=
/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> index a55e9bfc66d7..a7ce72e1cd81 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> @@ -38,6 +38,15 @@ properties:
>    clocks:
>      maxItems: 1

You mentioned about new compatible strings, does the one currently
listed in this binding support both bus types?

Making the bus type decision based on compatible only really makes sense
if they're different versions of the IP, but not if they're different
configuration options for a given version.

> +  bus-type:

If, as you mentioned, there are multiple bus types, a non-flag property
does make sense. However, I am really not keen on these "forced" numerical
properties at all, I'd much rather see strings used here.

Thanks,
Conor.

> +    maxItems: 1
> +    description: |
> +      Configure bus type:
> +        - 0: none
> +        - 1: qspi
> +    enum: [0, 1]
> +    default: 0
> +
>    '#io-backend-cells':
>      const: 0
> =20
>=20
> --=20
> 2.45.0.rc1
>=20

--FtoiXBdIW3OmYFeF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtCX8wAKCRB4tDGHoIJi
0pmkAP4uV+pw1FeyYtkjnBsCgD0EHjgDRKD2ZRXw3NnI0rsCbQD/XQbICb7bCchB
DM48Rzx7rHwTgNFWlNQBQtTWhOPzFg0=
=NY/t
-----END PGP SIGNATURE-----

--FtoiXBdIW3OmYFeF--

