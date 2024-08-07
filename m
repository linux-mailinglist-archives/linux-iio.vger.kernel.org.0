Return-Path: <linux-iio+bounces-8311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DC394AE29
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 18:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31481C21162
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 16:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C7B13664E;
	Wed,  7 Aug 2024 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roUETvn0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6A82209B;
	Wed,  7 Aug 2024 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048266; cv=none; b=srwT1Hzie1SndiFNSEKYEhubllXXZbjJ83PPiYafhCipQJjktM9wsJAanSrrnsrq/NLWGLZMQlxBApuUyutOsbzE7BeGWbQGbsjLKStKm5K0Nt4kx7qZwZNp9oaATgMJkGs+45/n/8mbd2KTOBwDAQ74riwcOjxU15nwLHp8Occ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048266; c=relaxed/simple;
	bh=xpY5vvCuu+qLHbq5z8UGWcEKnBhb+gnD0MYieQx7bCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4NpCP/7HJPNyuz62RtjPGkssFMICW7zdWvprdEC6mwmw8rhSo7ldfBQLFQptiUgTT2Mcb8GKasxsl9fzwaKN6bh2a0zEfU1mFvckB5/m2lDo6ANDButXiQzQBX0cHgLtLugVk0UQIGfyPeqmPg/IDFmgJVF4q1c6BXbMpdKQd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roUETvn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB311C32781;
	Wed,  7 Aug 2024 16:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723048266;
	bh=xpY5vvCuu+qLHbq5z8UGWcEKnBhb+gnD0MYieQx7bCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roUETvn0NR/ps9fkVEd9ofFY9QdUbVr7O54be0AJW0r48LjzfJg2xflkXT/1/+CQo
	 PnK2D49iSdewAmj7GPQyIN4ujHhbmR6+LrkfZgvdW+0PSEZGwVgcrZFc8t9OTH+qBD
	 2R4QoT3G829AqiKMPVrva1tYaKchgIqrf+aOtZMmryhctyfl4kvfYwgfFjPqzK3RGL
	 5PcJaaoyZ+hikcVz4QF+ExcLRds2LhMAgyIbh9dcNZiVrQJRwS10FSQhpjIgV2+GkR
	 sXzt7eykRciwl40F8sCVTXe+9XHjkJ7Xehsfz48G68aLTvvDhkIV/PsHDEcbwCOoe6
	 MhnASxeo4BIXw==
Date: Wed, 7 Aug 2024 17:31:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, mitrutz_ceclan@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <dumitru.ceclan@analog.com>
Subject: Re: [PATCH 1/2] dt-bindings: adc: ad7173: add support for ad4113
Message-ID: <20240807-crystal-fructose-7893ab4d8771@spud>
References: <20240807-ad4113-v1-0-2d338f702c7b@analog.com>
 <20240807-ad4113-v1-1-2d338f702c7b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="htDToTwmXcfMf35/"
Content-Disposition: inline
In-Reply-To: <20240807-ad4113-v1-1-2d338f702c7b@analog.com>


--htDToTwmXcfMf35/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 05:58:04PM +0300, Dumitru Ceclan wrote:
> This commit adds bindings support for AD4113.
>=20
> The AD4113 is a low power, low noise, 16-bit, =CE=A3-=CE=94 analog-to-dig=
ital
> converter (ADC) that integrates an analog front end (AFE) for four
> fully differential or eight single-ended inputs.

You should highlight why it is incompatible from existing devices, it's
not clear from the description/diff.

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

--htDToTwmXcfMf35/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrOhRQAKCRB4tDGHoIJi
0l5iAQDqQhWk64z9hZCUGYoQfNRbN5NJQDLXUDfQGLlhGAdXagEA5L9JOs6r6aU8
wg9X0av/Kl3QNDjlTiVy52w1mVTkjAE=
=r+wF
-----END PGP SIGNATURE-----

--htDToTwmXcfMf35/--

