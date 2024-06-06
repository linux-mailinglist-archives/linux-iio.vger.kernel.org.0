Return-Path: <linux-iio+bounces-5932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DED38FF2CB
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 18:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84D82B2A0AC
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4921A198845;
	Thu,  6 Jun 2024 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlWSLPjI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA443ACB;
	Thu,  6 Jun 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691909; cv=none; b=ISZW/Sr49lLxu4SRfI5IrDPPfEOG70GHDIGUxiceb+QfgP2a6m5Y1AQORTQJZBs7Bj7b5oRiVd8qNzvst8Mj0NytQDSF1zcfK2NzcXXG+LlQSTAiWVCmqXzSSqRzHQX3AbZrDBtj//v4IaEme3MQn8jdLRj+XqSjZmIWOiU3198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691909; c=relaxed/simple;
	bh=toosofXlxyPkLKyNmOnNS6IdsUgdaS0Lex6c+Er5Ob4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ihj78SY8b1MelMYOyGBmRILMT3yICPHwvYFtHQ28mxHZE46kNu+hTv1PzeMRpDHIjrY40NtzqySv0E3/i3pNDAks0hZYhpqK+TrjgDa8nJGiWX8u9bdwB6SC+IZyIqq9yG3hCmAj7I9oKWKvbInqurWuRx2dGbJmWhlWUxKKDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlWSLPjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F107C2BD10;
	Thu,  6 Jun 2024 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717691908;
	bh=toosofXlxyPkLKyNmOnNS6IdsUgdaS0Lex6c+Er5Ob4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlWSLPjIcj8g2VEKb8D3AgtPbx4RLtISCQpeJW4eqWFBgWsWXkhkMYl3IKRgFLu/m
	 je+r20BojQ5Z8ARTN+8rkujew/SzrBUKokZ+IzG9mTrRjWPjDWVoUejuJejlWc2YV9
	 roFNg8K+iVKIR62o27j8M0hXX3BKig7rxH5ykmJlkn3FrxrSSJeOf/YTb6QRnD3mJf
	 g75q01u649/mTFC3Bay97BnN7rn8YLX5YHNuGkXfyfg0nZkvQhnp/7U3M+DKsEpZ2/
	 FD5NaedOPprEvSky8mNReoIAtIZpM3iCEST9YMWJ7yX5Js0fv81wyO5VnHDU6n9616
	 uT4RA3RaStvmw==
Date: Thu, 6 Jun 2024 17:38:24 +0100
From: Conor Dooley <conor@kernel.org>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v6 2/9] dt-bindings: adc: ad7173: add support for ad411x
Message-ID: <20240606-matchbook-hedging-6db729d4c304@spud>
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
 <20240606-ad4111-v6-2-573981fb3e2e@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hDKkRkJGh4Hdx0pa"
Content-Disposition: inline
In-Reply-To: <20240606-ad4111-v6-2-573981fb3e2e@analog.com>


--hDKkRkJGh4Hdx0pa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 07:07:41PM +0300, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.
>=20
> AD411x family ADCs support a VCOM pin. The purpose of this pin is to
> offer a dedicated common-mode voltage input for single-ended channels.
> This pin is specified as supporting a differential channel with VIN10 on
> model AD4116.
>=20
> AD4111/AD4112 support current channels. Support is implemented using
> single-channel and "adi,current-channel".
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--hDKkRkJGh4Hdx0pa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmHmAAAKCRB4tDGHoIJi
0tT0AQCn7eyplOvUIcTU8QqPpvwaIyG5129D8kctOmrMtVEaVwD9GaamRZS8ugvY
/KNQ75AAqjZuzZflmGMwhGj/geCMmwI=
=gVp6
-----END PGP SIGNATURE-----

--hDKkRkJGh4Hdx0pa--

