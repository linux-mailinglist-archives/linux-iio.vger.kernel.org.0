Return-Path: <linux-iio+bounces-6795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E28914294
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 08:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8340B21603
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 06:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6181BC20;
	Mon, 24 Jun 2024 06:15:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FACF210E9;
	Mon, 24 Jun 2024 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719209716; cv=none; b=d+XdPqNpokZluzrLBGRoeMiK1sJZLfbx2b2/Ndt3Cbpk7ftyG4eSzVsFKfpWAA23gdsGP/E+UjpfQMIdI4fRs8DV6RClO9aC3aG5fkSTFKD46BuznfUUrgbN3rvmFsy0MAOboZusXfWXJN/lpxHDcsNcgjne9A+VjA4Y71V3xbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719209716; c=relaxed/simple;
	bh=LyITajvfZ1CYC3rJmlH7koFvWcirjcPli+4A4YGoJyY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=g1Yqmhoth4c8b4NOy3gALH2AXKQfEzEVGjeu8N/vl3um8Hvz/XbYUNZy59/OYyjOw+Uz92jTnEdJEUC2qgMEf1GXspSMlcRC4AsvtT4o2Q21j46QDvM5gbhUCOEfO8AjMn4eqKvNjfWY7KO6OtcN0JdKV1keGqok7W9bomH/L9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1sLcny-000N1i-1N;
	Mon, 24 Jun 2024 08:03:54 +0200
Received: from [31.220.119.164] (helo=mail.your-server.de)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1sLcny-00038L-27;
	Mon, 24 Jun 2024 08:03:54 +0200
Date: Mon, 24 Jun 2024 08:03:52 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Andreas Klinger <ak@it-klinger.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] iio: adc: hx711: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <ZnkMSO_dPWNY712F@mail.your-server.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N0AifF9IzWj2884v"
Content-Disposition: inline
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-2-49e50cd0b99a@baylibre.com>
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.3/27315/Sun Jun 23 10:23:58 2024)


--N0AifF9IzWj2884v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-06-21 at 22:11 +0000, David Lechner wrote:
> Use the devm_regulator_get_enable_read_voltage() helper to simplify the
> code.
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Andreas Klinger <ak@it-klinger.de>

--=20

--N0AifF9IzWj2884v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEE7/NrAFtB/Pj7rTUyyHDM+xwPAVEFAmZ5DEgACgkQyHDM+xwP
AVE47Av7BUpI4xHaIMA7TiHs6JARgCK+wBtJWrS4/DxpJ8GsTmhhP5wZ6TC96nHL
FtJH828ECT8BBgmkpoFYqLwiSdncLwUBAkQ36MukVjzIBXDYlyJRHHRbZb33NRGK
v0xL0Fxhv6u5oh8uvwmJjfTFBvx98TQkLdcUbfkQ2R8P7oPHN1q9AVybLlQIGSe7
/YEuHN7eLODtfGwxqhnhXFDXaSdLyjgK0xXOfaCgE925fBZd8t/fnJnXWQWdH5k+
1+TzAFV7/kQiQpfnefQDhMaAFNmmpbDpIaiwXTWW5C7D94acGZBFYWibOfCU/MsY
LEGsB99G24vtqUAjTofGQO5c8f3RaU7Q8TSBcQ1gtuEDXDT9T7fOoqJ6xTfRDb2i
p8bJMTO28RdnAh32lKS1BdnRywk7i458mTQcT6ZSoumKaCr8qLrn9A27uzwmlnIo
NFfNC8bLiVdk5WuS90o2zGZ3/hVuNWw8RjQNb8boUnDrzkQeY1JbSFma0KfayEzs
NcnAWhsO
=U+8T
-----END PGP SIGNATURE-----

--N0AifF9IzWj2884v--

