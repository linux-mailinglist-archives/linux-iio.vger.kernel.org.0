Return-Path: <linux-iio+bounces-25092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D33BDE60A
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 14:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676FF19A7D06
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 12:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF913324B38;
	Wed, 15 Oct 2025 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdwgvO/t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93291221FCB;
	Wed, 15 Oct 2025 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529802; cv=none; b=BJFWyBpBj7Nun+p8rNf0BorDPIqjQcfP4XZPomgacBrh8UHT5aZ1k5Yn4vBonkD2150Jrrpl8oDeLTQ89nLr4MFEmVEIIe+JGxNhYAfAEKYukWTBE3PkYY50JzOp+Mje7oVrwXgzRZV/dzjYQ13nenRlAO4M5R0upi9lXNB1Mr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529802; c=relaxed/simple;
	bh=rBcEcp5gh4WzW4q8kM8GvUQXZjf1NbSSnFncWi8p32w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmTHilTgh4xsgwgssIMIZzZqSSFfV/jnELQQ4jPWX6KtI9oBPvbtta+ExiE10tizwA/0PeVbk/F3v0Z/VMVIWpCK5kIiSVb+5DMh1CZhajDjOkQl5Bp0SJ1O7TXzs774C/vl35g33a0vz6/Kteh0YFT0JkGIBBJCh4dDSYfowlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdwgvO/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B68C4CEF8;
	Wed, 15 Oct 2025 12:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760529802;
	bh=rBcEcp5gh4WzW4q8kM8GvUQXZjf1NbSSnFncWi8p32w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdwgvO/tyYbo8EVGxVwnluWaIVdIFPMRY3siss0igYKWQXpTBiIFOLYfedvO6Lzcs
	 A5shPbJenQPB2nvm+/8D4WSUZoDCDgtT33B1WrjWdPFKIBcZHj1OXI+NJCDNTyt6or
	 zm33Q9KpAuOSEBSDdS1jHTCKHegjHp/bnFXK5mANs6n6A0txd8u4hA7Q2zEErtoi/F
	 iGBCGWvDVYJrtQBELOQHHUICOvbWUbsOIbvM7ywLJTNLn/DFc64udAXnIXWt1h+pKe
	 rkcBy0GpsPysBSvZK45dznXg6RoBvXdEzYn8MmTjxPpxzq+87BcSQM5fds67AYGRc2
	 CxXmC36Ebn9Ug==
Date: Wed, 15 Oct 2025 13:03:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/6] spi: axi-spi-engine: support
 SPI_MULTI_BUS_MODE_STRIPE
Message-ID: <90407135-f9fc-4b83-a2b2-393bb20aef87@sirena.org.uk>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-4-2098c12d6f5f@baylibre.com>
 <3180475bd51e1e057d6aa7e1b62f564cb57a117e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8a16MxYkGAbfehvy"
Content-Disposition: inline
In-Reply-To: <3180475bd51e1e057d6aa7e1b62f564cb57a117e.camel@gmail.com>
X-Cookie: Long life is in store for you.


--8a16MxYkGAbfehvy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 11:30:39AM +0100, Nuno S=E1 wrote:
> On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:
> > Add support for SPI_MULTI_BUS_MODE_STRIPE to the AXI SPI engine driver.
> >=20
> > The v2.0.0 version of the AXI SPI Engine IP core supports multiple
> > buses. This can be used with SPI_MULTI_BUS_MODE_STRIPE to support
> > reading from simultaneous sampling ADCs that have a separate SDO line
> > for each analog channel. This allows reading all channels at the same
> > time to increase throughput.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--8a16MxYkGAbfehvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjvjYMACgkQJNaLcl1U
h9CKWQf/fiOSGY9C8sjgxx1MNemuLhL+GY5hU8hErhOnmiBuVX/BrfM5BhZBX3Ie
DtHQs30ExfmeTtdXlnE0we1o4FnLMu8cnZ0KRDkgbX13ysFuPlYnPLGhOy/OhN2y
DrtJVl7q/+orQsQeFK7fN5vnZMv0Q3fmwBCJcEc+iqkcBjuOy5pTEmdRHKRKcsAP
QmbolaIdR/By1dvRRtYxAtEPcvOLjit5C2aoop4GOdkd+5YIED8EFq7ipI8cZAuS
h/t04+iHN7IdNwiYtq04GhfnT2M9Iyb7Jmq/ZpcsOLDOVeF77yBrwu59H5YV4808
UFnutk6J4vqii8+N/TfsS5YcYgfmnw==
=9TaG
-----END PGP SIGNATURE-----

--8a16MxYkGAbfehvy--

