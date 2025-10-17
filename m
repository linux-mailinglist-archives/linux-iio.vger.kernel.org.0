Return-Path: <linux-iio+bounces-25169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2046BE6B72
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 08:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E9A1898E17
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 06:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8503101A2;
	Fri, 17 Oct 2025 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="UNcwvPdK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8CE30FC2C
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682995; cv=none; b=vGs8QSpaCmHMJU9eXWE4VXXTE9BYBcV7ahIjSRoU6IHZaWJueSkYJG6vqguJ5KGjqCeo6KsQZkbc9DVzXVxDJqic4Pi3De63hcBV8obaF+Pq7nkyIjN1a0HOK3wXNxNETw+d/Iuk+H6h8O1Zo5eq3lpgMPQ57Pb+yE0zo98XIus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682995; c=relaxed/simple;
	bh=STcBceaCHdIlXSeKQ6i20Wg9ICYTLWWg9f/Od09MSeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6LuGOCWnwQeRy4aHBz93rnvHY3GkEBVqWETrfKRnkGt/SiOdt0VggODhqw5kUhOOc48PVWxIkC7jikX2NZVrfiTXFQAPaGPbxwhjXqHJlr1UphgR1DjIl8UZHLURcKz3Y8ejXnoT8VC6nmTZDCRrrXrSx76ZA1UHVePbWnmOkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=UNcwvPdK; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=STcB
	ceaCHdIlXSeKQ6i20Wg9ICYTLWWg9f/Od09MSeg=; b=UNcwvPdK/NlaTng2xkLa
	oPaSIIl0DS2CV3aHTQMFzIqxIwBkI2tuxmu2Mn9zE4Qn9gXJeZ5sgvSF9bxtSQaY
	AXaxkIjys7NyFuhWlXo3/1tt6gjjInxCvEdH66WZHWclvjrUvSX5T+bO9D+zj+H3
	oCNTbPtVQMf8l2rRlYoxRpA1SxF/J48FFjthQnupWvgZEtodDaUF/6IWQeb3m2mS
	wkwM3Wklfn9AdfKlCh09LdAPtUxv15M6dVhn8dboC8PYZ4VM+/j1xTq/Rzk6VG47
	Bc4ZKUDGvSLFB+AbeWnC4fdw3TryCGCXh7GWlnEDD4qx8pDecO3wC0Lt4rfjhucC
	JQ==
Received: (qmail 4113514 invoked from network); 17 Oct 2025 08:36:31 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Oct 2025 08:36:31 +0200
X-UD-Smtp-Session: l3s3148p1@4GZF9FRBPuYujntM
Date: Fri, 17 Oct 2025 08:36:31 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/4] ARM: dts: renesas: r9a06g032: Add the ADC device
Message-ID: <aPHj77kAxEmEEPmW@ninjato>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
 <20251015142816.1274605-4-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="434UvbnTmnzbTDnb"
Content-Disposition: inline
In-Reply-To: <20251015142816.1274605-4-herve.codina@bootlin.com>


--434UvbnTmnzbTDnb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 04:28:15PM +0200, Herve Codina (Schneider Electric)=
 wrote:
> The ADC available in the r9a06g032 SoC can use up to two internal ACD
> cores (ADC1 and ADC2) those internal cores are handled through ADC
> controller virtual channels.
>=20
> Describe this device.
>=20
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.co=
m>

Looks good given the current bindings. Despite clock-names will need an upd=
ate:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--434UvbnTmnzbTDnb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjx4+8ACgkQFA3kzBSg
KbYlVA//brX4gPpHtvlI8akGOMW7khm3j/dmpEerFqmJolr4GeRKas8XfaLSiSfu
M65DY6Bk9vmADWxn/Zi37aREbr5oR2URCZJK8GAfSkRZDUl7xrxvZm49l00fWggI
EikQnmqB30n1oESTlEjEQ5gn5T0qjA6VZbn0LOhuZQw3Et/egtNCOA2ZxYuoSf5U
jLAS7h10To+LChI0OZng9bIamK+M5yYMSTTdiWuCCKySlhj4Oo7EQ5Xnqx0bZUNb
HDdrzklOP6xSBNfHatdb0wBfHhAPbd4ZHj5NPMLTlRMbM/fD6XhpWkH/R9Hzp00/
AoZ7dMylpEqvP9DJJwXAmTX+v9NHcHrx+y2yorCCSVB+VdPFYYO0jGyMNe0+tBBw
4KWepTaesh2jTFnWIB4lVPa+ecnoG8LcQ9H/X/15bdZ6tnREdBhmL1kOWfpxJihU
Y9AGUvRUADtCJATFdXqH8i8lRLidVcLUCXk79+brUptXHFnKWPC9I1SC/a8NiYEO
5lkLvndHgkdE/H+alrK735T6fmZ76VWEgP/KkmMEmCVsQ8i/nfMiKnx68VuCZRZR
UISWVOXbGC1gQGQEj1aynYhs3OQB85PUhzZ42CVRafsU9lx8ENfTeNNi7gog6cwc
k6j5MKzdA+2n3D1K+sgWJhma3H7zX+GhAmjvOi5LL2M4fs4iKR8=
=pqT9
-----END PGP SIGNATURE-----

--434UvbnTmnzbTDnb--

