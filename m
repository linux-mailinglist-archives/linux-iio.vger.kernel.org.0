Return-Path: <linux-iio+bounces-25367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C89E0C000C0
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 10:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 275BD4FF008
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E912DEA72;
	Thu, 23 Oct 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="k23t3nkw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176D2F3622
	for <linux-iio@vger.kernel.org>; Thu, 23 Oct 2025 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209866; cv=none; b=gwct1ysImRxhWqEibie437FzC09+Xd7fL2hpYg8KKMB7XjLZBD0TMmD//WMDXZLKE+USTizvYYbnXCpug8YnfYyNyLYygHrJJhNhVCDVik4+TfzUF59ZkrlGPoBiGIU+8HIMW+Zh2hxWLOf0oxhU76oBxWa07rv40bCTj5F4anc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209866; c=relaxed/simple;
	bh=x727wb4gVGpsnRAl9GVfYJBsW0o01Yyxtev4lLfXK3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baWueKhRnDmazKlhL9L8OB/stbsFC1XuyKIlaJfaO882MfFcaa9J2e8GBxh5apcxcvjTvgCqSOukkIoSb+15hjolGokdMxRNyhd1OLQPQnCtit/W22SW8YB0BytX/tJboh+Q12QSqntsaPDtDCr6TXZbwPFww27Itft3gOu7pr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=k23t3nkw; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=lbi5
	8QaPic1LfjvTfz2JhctAgdDUIqwY+EH58Nv5UmM=; b=k23t3nkwhkz1oeDQytba
	ne5W0mNuM/Er9edxfRgcGMvyKDbDUeMGQXWrLFVeQIhZWigl7ViSBi0aC7jdpXiA
	IioIpoPqOORfEA0YifHAO2HPZPJ5HUq4ofXwtM3LAg9SgjoErZkwwUchWC+4vIza
	+pDvZUzHDiUkAvhzUwybz8r5qF58WqbSnVbnOs5DO27Owginwo8IwU7cKqIIXYIC
	NHL6i5fHjz3+bFwxojC3Eul3vwJ0gMazYyjmojsyjCJ3760wLnOHINTBV3s5xwAA
	jRWgP73LmHkx3+dsWQwUqhaMsagpbyI1uVfzz5Ior7mUKqY2j7L02yqYYj3Xd3dU
	VA==
Received: (qmail 2136513 invoked from network); 23 Oct 2025 10:57:41 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Oct 2025 10:57:41 +0200
X-UD-Smtp-Session: l3s3148p1@gW8eoM9B0m5tKPAY
Date: Thu, 23 Oct 2025 10:57:40 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: Add the Renesas RZ/N1 ADC
Message-ID: <aPnuBFARM4mqB7EG@shikoro>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
 <20251015142816.1274605-2-herve.codina@bootlin.com>
 <aPEoqkdatl4G82co@shikoro>
 <20251017090742.49f2d628@bootlin.com>
 <20251023105445.1adb2e86@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m+/uSDtnyk5fnHyE"
Content-Disposition: inline
In-Reply-To: <20251023105445.1adb2e86@bootlin.com>


--m+/uSDtnyk5fnHyE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>     compatible:
>       items:
>         - const: renesas,r9a06g032-adc   # RZ/N1D
>         - const: renesas,rzn1-adc

This. Just switch from a forever-single enum to a const for the first
entry.


--m+/uSDtnyk5fnHyE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmj57gQACgkQFA3kzBSg
KbZcWQ//a0QHTORdjgz22rHifjEMais0eU0NSHuHTfdjNW0KT3dCVeX/v9A/P0m0
oEAMmA4r0pOAX91GrlYzJKJ3n/gEGowt2pOq0dSkDiSCooWhRUkBF4tBG9mXhg6k
YljAEvisS6vP48uiHabi8fXdjQNTeX8PU8Z5R1OORdE47vpRY0my6/tHAvwTnx0/
EeiN5I3N+YkgQ69EvvijbCXcoMtZXUIRg/+xRPgK+OIYCN2vFRdy/a1amdM9ahf9
af+4U0BPyUNZg1IKPMJbin4RXRTB6831h+7O6aN0Q8ZhiCnmygdPi70NJVl8ivQr
qht3R5+kQsITnIJdJYGgMBqI0N1uTZbUwX9LsIohwlVSEkC1EKgRzTJfyfgi0iiD
0zrVyw8nuCZA432jH57+oYp/Za3yyOnFrSxU0f2lfhNFsIsvlTPvG5kxUOlDaiZC
VsbQ22mzjE0OYxFXCjVJzKXt0/RoDjchaCE/1DQZAjCe366fU1aB5JHzmwIuMMYy
ljsTbVYWmsONp/9//n0b8Fw/QMywZNbuPyFC1wyprEsL/f99DoAQf4TxsF9N5UBa
4TtODQC+0taMXJOjdUyOBDD5UCOX+nCp4fScVq4ZUnXJa3IYGjqH28JVWy4Xz8vh
JyOw5wEVbBSpPc1QYfy49RHpkSW3dYmfaKkd1Kyrkma5J6TllWA=
=uRA0
-----END PGP SIGNATURE-----

--m+/uSDtnyk5fnHyE--

