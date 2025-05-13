Return-Path: <linux-iio+bounces-19497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCEBAB5754
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 16:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACB419E4F88
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 14:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D822257AE4;
	Tue, 13 May 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A41JKPij"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A51AF0A7;
	Tue, 13 May 2025 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147156; cv=none; b=Vw6YVLJYMfdZxtHKV8gwKpLoenvhETkdrHZmOeiCOv7kiH5Giz2bTR1BbidCDRmkuuoUpbjSsM8+SX2FiR7IGjk5n4mSEjIPqUf8vp/jU6kg8bCSJOyHk2euzbVZcE50wLjM9jr808jznk/kNUevYze3zhzlMyKSG+RJQ+I6NxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147156; c=relaxed/simple;
	bh=78Y5nsSn8msKod2hNt2UnJfWyWqWqV+GVJgn5s8T3Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOOmDIB+eNXdKmV6zbV7tULimB9WUuUxhmipNG/NZCx7FKf08drhCjG8tUaX7r7AK0BF8dLdl3FUXX/soNRWmdcLdRe531E2EoAA1Kg0u/0R8P8yAMhb7AyZDRXrBf76LyNRGrG0pQzzl7Y1gaayoWDZ5QUY90VbE3t6vAxF77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A41JKPij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB42C4CEE4;
	Tue, 13 May 2025 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747147156;
	bh=78Y5nsSn8msKod2hNt2UnJfWyWqWqV+GVJgn5s8T3Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A41JKPijktm+f+RGXnOom9m4ILl78/IyYQDQrNeVYzrb2fHt70U2ZEbcOMX4wtAZ6
	 dGA//+j2Je0TvzMMbGuAdK+uZPZtoAq9sKSsiF+aZTvDKo0cfeS3V1pYjm2GXzHhZQ
	 crY0MUnnzTvs+asz2lO+0YDFS8oNgKQWGrhAeYi3VfIRHKTr1ZAYHv3BSB37ArVOeQ
	 Atq/Vq8CwuVUKt7fdqpv+zfyaS/9jWZMgW6jLhVpcxP+iONLIEbT7h1tWkqdPRaSk9
	 JEmrYA7fX1+r0WMJu1B8Of7iD4wVEXaRZesxJaJ5VRiqx0SCNw25kPbNW9WE7YR5p7
	 oYRm8iYpBCYNw==
Date: Tue, 13 May 2025 15:39:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add ROHM BD79100G
Message-ID: <20250513-coconut-reconfirm-b90590efeb45@spud>
References: <cover.1747123883.git.mazziesaccount@gmail.com>
 <7deb4b69795c298ba51c9b198bc87000ad35cc9b.1747123883.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cZaU8kTRn+sahJLj"
Content-Disposition: inline
In-Reply-To: <7deb4b69795c298ba51c9b198bc87000ad35cc9b.1747123883.git.mazziesaccount@gmail.com>


--cZaU8kTRn+sahJLj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 11:26:27AM +0300, Matti Vaittinen wrote:
> The ROHM BD79100G is a 12-bit ADC which can be read over SPI. Device has
> no MOSI pin. ADC results can be read from MISO by clocking in 16 bits.
> The 4 leading bits will be zero, last 12 containig the data.

I think it is probably worth mentioning why a rohm device is going into
this binding (clone?) and that the 12-bit thing is a differentiator that
is why you're not using a fallback.

>=20
> Device has only VCC supply pin, which acts also as a VFS, determining the
> voltage for full 12-bits. Specifying it is mandatory.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
> index 44c671eeda73..10fb6e14c2d0 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
> @@ -46,6 +46,7 @@ properties:
>        - ti,ads7867
>        - ti,ads7868
>        - lltc,ltc2314-14
> +      - rohm,bu79100g
> =20
>    reg:
>      maxItems: 1
> @@ -96,6 +97,7 @@ allOf:
>                - ti,adc121s
>                - ti,ads7866
>                - ti,ads7868
> +              - rohm,bu79100g
>      then:
>        required:
>          - vcc-supply
> --=20
> 2.49.0
>=20



--cZaU8kTRn+sahJLj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCNZjwAKCRB4tDGHoIJi
0sfZAP9Acd/fZWC6ewRdnPz+rvcYrfmun41w8NuwwkbNFOhUIgEA2la5SGiVOrwC
aJ5qS6G67sDt8oplZ5HC3bFJxwBvqQg=
=4wMc
-----END PGP SIGNATURE-----

--cZaU8kTRn+sahJLj--

