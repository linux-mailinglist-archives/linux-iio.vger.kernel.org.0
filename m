Return-Path: <linux-iio+bounces-6215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0019058E7
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 18:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4950B24378
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F7818130D;
	Wed, 12 Jun 2024 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Igv5DP48"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD3C12F365;
	Wed, 12 Jun 2024 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209841; cv=none; b=DkMmmb5GsUqkxS/yVDGUmkiTTu6z75YimrihyOxXF+/gdOEVv37y2YyTWz8gD5hLL8XKjwtq/ypi8gVOgzvgO4b4c9ZWxj4bzw5Njow5RM4To89FbcYszJRxx3elkYJIviri+GGHr5JkzYDNVVq9oO8ippgGlG9C3OtPwaTQf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209841; c=relaxed/simple;
	bh=MuDkD4Y5Xr/E5kiJGSuSZCUhZSy7wFH47LvJyu+n4XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8QKSRwPRxQY/DOivdV7aYIjTqANDHB6uHvwUwhgjH36Wl1SOp7OIE/eqPKB79A9d78i0BIZg/VVSWFcre7eEiwtB14Yoa/h09l6c9pqBpXdMad1etmZOUM/3KA2Ut1tA6LZQFkjN4k6usrP2z103U93qMV3uVXkxjqKbZqbEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Igv5DP48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2034C116B1;
	Wed, 12 Jun 2024 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718209841;
	bh=MuDkD4Y5Xr/E5kiJGSuSZCUhZSy7wFH47LvJyu+n4XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Igv5DP48E7gNgtaishMOuW/uxRb2oa2oF1jJSIBsCB94WOPVICkT7NUItrvQSDu0a
	 ppA/Xf5jRb7QXNe5semzQH/6wef5jzHca7S1Myl10h4d2hrdevl0t3uZebUc0K07bQ
	 pcrTcyFxVebMSGwUNnEiZostHhIRgXH5blHo3QrXuABbK499JO9GNiICuitw6q+v4h
	 pR0J4Bi1mnn5UHOeQEsNwU82r+3NCQrZWO75rl+h37W3oML3a4Nsh9xFZiISpNTmL4
	 z0qwT0OD9XrgnDfFC2iBZC5W5dapwtv/sN1hOtw4e4n5Q3K0ct0IZEf6LP5IQnO0pm
	 FWduKDqn58PGQ==
Date: Wed, 12 Jun 2024 17:30:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: ad7192: Fix clock config
Message-ID: <20240612-daylong-unnamable-c6f3aa60c8e3@spud>
References: <20240612141637.175709-1-alisa.roman@analog.com>
 <20240612141637.175709-2-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jKTczYEpqqA+Uas4"
Content-Disposition: inline
In-Reply-To: <20240612141637.175709-2-alisa.roman@analog.com>


--jKTczYEpqqA+Uas4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 05:16:36PM +0300, Alisa-Dariana Roman wrote:
> There are actually 4 configuration modes of clock source for AD719X
> devices. Either a crystal can be attached externally between MCLK1 and
> MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> pin. The other 2 modes make use of the 4.92MHz internal clock.
>=20
> The presence of an external clock is optional, not required. When
> absent, internal clock of the device is used.
>=20
> Fixes: f7356e47032c ("dt-bindings: iio: adc: ad7192: Add binding document=
ation for AD7192")
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7192.yaml    | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index a03da9489ed9..3ae2f860d24c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -39,11 +39,15 @@ properties:
> =20
>    clocks:
>      maxItems: 1
> -    description: phandle to the master clock (mclk)
> +    description: |
> +      Optionally, either a crystal can be attached externally between MC=
LK1 and
> +      MCLK2 pins, or an external CMOS-compatible clock can drive the MCL=
K2
> +      pin. If absent, internal 4.92MHz clock is used.
> =20
>    clock-names:
> -    items:
> -      - const: mclk
> +    enum:
> +      - xtal
> +      - mclk

Nothing in this commit message explains why "mclk" is not a suitable
name for either of the two configurations.

--jKTczYEpqqA+Uas4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmnNLAAKCRB4tDGHoIJi
0oivAP9ktMVN6kGzDFf2XPHRXYTqo7uhIEZosOdgNo/1+GdS/AD/XfF4SgDkYQ3j
fXy1FbHzAmmbzVEl0pVGOUJBRPv9XA4=
=SUxL
-----END PGP SIGNATURE-----

--jKTczYEpqqA+Uas4--

