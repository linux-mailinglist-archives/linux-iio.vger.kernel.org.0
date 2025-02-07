Return-Path: <linux-iio+bounces-15149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D68DA2CE0B
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 21:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB86A3A3118
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 20:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84FE1A0BFD;
	Fri,  7 Feb 2025 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKSn+A7I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7567E23C8C7;
	Fri,  7 Feb 2025 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959635; cv=none; b=s/K5ZVA5+8L1mpLFn1nxEQ5P0HeqZN5X9pGv0conYjUiTq7y/cnwrLQeA0tcQiRyDU0n5slkSpqkpqIpfXIR/T4mkYHfIlSNgVPgyBwUtXgGemU08t/jzmkA3B9Er4t9u/OQZvaJsC/luSX0mmqtelNCH+UUdphbUBP2qYnW4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959635; c=relaxed/simple;
	bh=MLjnC+mynJL2UmCIr8H5tB9W8MhrU4FrF7Oz9XY2KwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzdOF0ewYtGUjEcc8qDYqV8wFH7qccb1cEUu7bMOuspeL4BQVVKL8QcEikRQgm+IbzIrtHWDJrrEyDv4v17mgIWxGsgHyqvbttavx0+ziTc7Lfg6Jo2Dr4tFZNzzWHfiDL/dc1SUF8HAFBWniwIFfrxjyTykFBSebFs7hVG5jqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKSn+A7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56F5C4CED1;
	Fri,  7 Feb 2025 20:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738959633;
	bh=MLjnC+mynJL2UmCIr8H5tB9W8MhrU4FrF7Oz9XY2KwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZKSn+A7IFh24bVSH8hJWECHIoGjfn5iYv6bUluFevl+J9oK9eDLBl5q46UB+Po2Hq
	 tPHknN1reWjwMkeZOkhefM0l2RQmidagoL/AFI9mYxsSZXFmcEL7iQAzHFCOSLqZfh
	 gGc1B5w2iXrUPXwEJvfuG8ucb3UnmVntaAuQ3FsqvkLDEcUEGrdg7LqQM+ykxQjX14
	 5yjgzTcPfUyT6OjikmKvP3LeTI+eDc/OMEYIbz4ryr4fqPBZJ6oKZbvcTCsR80c7XD
	 IQmuTtalEyNRwohZAGBerJAa0PUBAEzDLqxcfYP/E2DRZFCJpHFAZv5Mi1pSudIUOT
	 soC8vxNPa/O0g==
Date: Fri, 7 Feb 2025 20:20:27 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 14/17] iio: adc: ad4695: Add support for SPI offload
Message-ID: <11b7f0fd-88ae-46c3-93b5-f7a0166e82be@sirena.org.uk>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
 <20250207-dlech-mainline-spi-engine-offload-2-v8-14-e48a489be48c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PH/cu5q3o2YSgbcb"
Content-Disposition: inline
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-14-e48a489be48c@baylibre.com>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!


--PH/cu5q3o2YSgbcb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 07, 2025 at 02:09:11PM -0600, David Lechner wrote:

> Add support for SPI offload to the ad4695 driver. SPI offload allows
> sampling data at the max sample rate (500kSPS or 1MSPS).

This doesn't apply (against -rc1) so I'll skip all the IIO stuff.

--PH/cu5q3o2YSgbcb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmemawsACgkQJNaLcl1U
h9C6jwf9HUgpmIWlGPn0UR+YhcWnVkyyoaE7eIKkym6mjxeWKRneyLtLTjXp9JQL
LKLtUDQvr/xtHX3BCQYDMYHqERwCIEgbbjdqz3U+4JWlnt9wCHcTz5ipucBiLKjY
kQKvHD8jUORwWI1VJHijeL9JMnEwqgAn9q26KDuC+/uiCIQnswML31TaNbtoaBhk
0MF7N0LSEpcU7dvZDEyOFQk3Uwgx5o1Gjjj1MF8M9y7UgfEMREikDivqaxDyWjZt
h1j0AwznPbj9+aWGLnkQ090VwtCrn5KhHr/cgh/l4Dgr0HOTGPaaa57QZuHFoYYF
gdPJ2RDl9eIE0H6n14xNw7lN6L0/lQ==
=9/2D
-----END PGP SIGNATURE-----

--PH/cu5q3o2YSgbcb--

