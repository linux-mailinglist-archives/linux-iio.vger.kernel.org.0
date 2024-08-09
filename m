Return-Path: <linux-iio+bounces-8366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9625594D20E
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 16:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5735628454F
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 14:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1B419645D;
	Fri,  9 Aug 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyCv1HaB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A781E49B;
	Fri,  9 Aug 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213273; cv=none; b=s5JtEMib65QKApTQvyOnM2OdWe+p2ZjC6NG6Be8K+qhXWadCILJukvEhflymSijaRhGnZt7oBEOjTv+Ca8yiNe2+S2Xl1FQDYUz7mu/6k/DVhaNlTYXVvfgD+GP0iGlsUG+wfVKRSG8ytXGshwtCw/Tn304i3za1VNADqR+Mpyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213273; c=relaxed/simple;
	bh=D3KOQ1lz6fObG3Up+Pkf3Q2wDvBRrliNyfSpEXtz9Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0O6Mi9zPN59H71xgKLoM9Pu3mLwU9fDPs45lDm3ZsvpVrJKICbmqhCsoLhAG0ur0wVy0DmHODvqlE75uf8TZAmROniVRnbFK2RH6NCVKcBHVzkgMKlhDENUVz/3kUrySnzQmALywga9vUbO3T0wuuOi4vDp/2XL7ySkjwwSQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyCv1HaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A113EC4AF0D;
	Fri,  9 Aug 2024 14:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723213272;
	bh=D3KOQ1lz6fObG3Up+Pkf3Q2wDvBRrliNyfSpEXtz9Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyCv1HaBGEqenaSqmEzCmpzaRQboOvUnt9A88P2wZ2vhFmuMqwNhhisHMEsyGIH2v
	 AlE6dKTSyLsQTY/Hb3itNqD83CaIpV1aTnhfEzLv1aBBy+7Q2tcu5C39X6ViemXtXR
	 h+XsIdcQVzL7WY938VDvr4dzMPZOPVFsTJUkzJtn6+sU4Oyc+hGwrsUDJ22fi/WmcO
	 FhkAGnQorHB6cyt5bPDXt1Xxbnwia6DEqPGoGCZ5UVZcSiss+qCIyZUzERpf/Mqvmz
	 iOTf2uH96QFyPr8ptysSrzJopl2R/g5GvKvxMvPnysGeWCwx8CzvJN0McvSMWcftST
	 A0l2lmveUb/Lw==
Date: Fri, 9 Aug 2024 15:21:08 +0100
From: Conor Dooley <conor@kernel.org>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, mitrutzceclan@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: ad7173: add support for ad4113
Message-ID: <20240809-glowing-discard-87263f656a7e@spud>
References: <20240809-ad4113-v2-0-2a70c101a1f4@analog.com>
 <20240809-ad4113-v2-1-2a70c101a1f4@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h5xwHwgJrpSmMpcr"
Content-Disposition: inline
In-Reply-To: <20240809-ad4113-v2-1-2a70c101a1f4@analog.com>


--h5xwHwgJrpSmMpcr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 01:33:24PM +0300, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> This commit adds bindings support for AD4113.
>=20
> The AD4113 is a low power, low noise, 16-bit, =CE=A3-=CE=94 analog-to-dig=
ital
> converter (ADC) that integrates an analog front end (AFE) for four
> fully differential or eight single-ended inputs.
>=20
> Added ad4113 to the compatible list and the "avdd2-supply: false"
> restriction.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> index 17c5d39cc2c1..ad15cf9bc2ff 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> @@ -28,6 +28,7 @@ description: |
>    Datasheets for supported chips:
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4111.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4112.pdf
> +    <AD4113: not released yet>

Am I meant to ack it with this placeholder? When will the document be
released?
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4114.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4115.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4116.pdf
> @@ -44,6 +45,7 @@ properties:
>      enum:
>        - adi,ad4111
>        - adi,ad4112
> +      - adi,ad4113
>        - adi,ad4114
>        - adi,ad4115
>        - adi,ad4116
> @@ -331,6 +333,7 @@ allOf:
>              enum:
>                - adi,ad4111
>                - adi,ad4112
> +              - adi,ad4113
>                - adi,ad4114
>                - adi,ad4115
>                - adi,ad4116
>=20
> --=20
> 2.43.0
>=20
>=20

--h5xwHwgJrpSmMpcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrYl1AAKCRB4tDGHoIJi
0uasAP98ZL0MS6Ck9rDG7L+3myxCmOGrrEofGAhhyVGiUxt6pgEAnezu+HrD2ee4
LOFCngiz8LH+w6EpJ3QKu6yWZHT9qgI=
=iBLz
-----END PGP SIGNATURE-----

--h5xwHwgJrpSmMpcr--

