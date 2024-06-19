Return-Path: <linux-iio+bounces-6573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D16D90EA66
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 14:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089061C21EE4
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 12:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8765413E3F2;
	Wed, 19 Jun 2024 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iew0RSTw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E89F20B34;
	Wed, 19 Jun 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798885; cv=none; b=ofpufYozXaIrj2vHHO19xzEILOYhJJr1chUR+o9rWHIFAIPLM7eifVvjQo8nJbYs/r+TJOno8adGSRfBENMXs2uH2wjWYTyeoSGTvXStk6asOFl7QiUm4V/5U7jizU5+BdCk9+pb/s9hvep6RgITI1NuY60ZbELLVViDKrNEMeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798885; c=relaxed/simple;
	bh=SehDOVj0xcMmEoe78u3jDOta+JmRt6fmwneR9FCzK7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOWsxM0qWdSC9dOyeJi0IbQjNj7YJ9FR0b93206Y7KIAEIBPbx5Hf+2OpUx53sn7Y6GYCsmH6K4i0qiLqLOLZeWQG/dZP3/Zh5/99lcCruu2sN6iIWJEr7ajt6jxJeU7rPbMQ8J6zIcERyou5VERdYXNaxwt3tthZNcnMgAV9LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iew0RSTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48DDC2BBFC;
	Wed, 19 Jun 2024 12:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718798884;
	bh=SehDOVj0xcMmEoe78u3jDOta+JmRt6fmwneR9FCzK7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iew0RSTwct1BQsvJDNOLo9Xi4avPrBNVX4Mom0A5+ovGuO/6i/Fdvcc/21VqQOdRG
	 Po3Xnxk6cfOytUfhqJRAsgOMZKJSOhAwXumb6HX3chubWZ/AnDLVtd4rm2fKMser2P
	 lxUtKY9vwF8yiWEbip1vtalrze9EU+YSlgKvbaRrN14lL8UwaYRbefCm3WqdZBkj5b
	 7D+4TULE5IXxENs+y4U0mxBRtXNmw5x4S5Pp0+AeuGpIwkn7Ou6GLm0oNdyCGwpdSv
	 viV8jesakSxfU313MWCQZhAjyMjCjnsSN+qFK2gJsgomm+1pNfltQZXUY0OJCU/KHq
	 hSCVnsoVKM6KA==
Date: Wed, 19 Jun 2024 13:07:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] spi: Enable controllers to extend the SPI
 protocol with MOSI idle configuration
Message-ID: <5f89baeb-c95a-4ad9-adc7-769fb124c0d4@sirena.org.uk>
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QH6J6xih8fp6IIfc"
Content-Disposition: inline
In-Reply-To: <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
X-Cookie: Don't I know you?


--QH6J6xih8fp6IIfc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 08:10:44PM -0300, Marcelo Schmitt wrote:

> First replies to v3 brought the idea of having a feature detection mechan=
ism.
> I didn't really get how to do that. If feature detection is required, can
> somebody please provide some pointers on how to implement that?

Look at the checks in spi_setup() for bad_bits. =20

--QH6J6xih8fp6IIfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZyyh0ACgkQJNaLcl1U
h9ABLgf/XM3S8vAY2xtIjPhw+56Z159aXWzIYnT0IGXhhosxN+39kKViSxaSuO+W
5xpbfrztdw+y//xbq8xYwOXL8o8/k9s6PCXjJgPJ0pqTWdsXUWNB8ofaPQPZO+Bx
F/vaxzGc2Rv42MGjSjAp9bMck8a7UCGTxPQRjlhEIcT8fsRGuy+nuYngKekxgz7b
NI4gBSAnRjYhS8GII4iMdNMqeUuAfLE2d4bwgekJ20E+m28HZWlL86+gwwqCNk6n
6WSesT5eGGJXaxSm4JJ8UnQTbP/qAWtN9FTFq5riu9APPnXmzvfXHGajMwpEpS6w
5wS5FeRNgr5EKM5cng2zcjnT8E6a0Q==
=shHL
-----END PGP SIGNATURE-----

--QH6J6xih8fp6IIfc--

