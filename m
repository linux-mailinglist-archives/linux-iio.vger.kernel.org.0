Return-Path: <linux-iio+bounces-25856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E5C2CDA2
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 16:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 558454F6572
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7718320CCC;
	Mon,  3 Nov 2025 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoqaC9vu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F92F29;
	Mon,  3 Nov 2025 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184016; cv=none; b=IN3S0h2SEnBzEXnpLVK5wLejhZgSYYIkljjn3ZBwldassYkwri1oexXYIq4fRFqdRAek/+fDS0ABI0vvGnIHg+I0T79sjjL80cgmPtlaXE8r6gUdzSNaBi/wSd+BEAEzszNB8y7UumRkK7NoKdqeasxsy7KKTc3NMskNJHvSB5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184016; c=relaxed/simple;
	bh=uNgNaPYwouZv9T9lCZAvJr4F5YbOOwITKjbMBTcUrBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrCRdHtpQctpYxxwa3bWmsIVMu7INlmA+Qc8mFR8840b5bia+xtC9EPv4de82MVdZ1NPjyPdFIbG2EAG7l8/N/ImLJniYR1f2lcwx7iCXKz8FfVMRFa6PpQEKyGiK8u7EVmUwwGa2EkxUF2dFggEduvfRpIIIZA9kT8P0CYeiGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoqaC9vu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC50C4CEE7;
	Mon,  3 Nov 2025 15:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762184016;
	bh=uNgNaPYwouZv9T9lCZAvJr4F5YbOOwITKjbMBTcUrBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EoqaC9vuQda+zjylpdayNSFe10w5OE5vTjDXkIBunHgQzE3bO872axhDmzaERKKc4
	 1WO4YOH7eYFyN57IViLtXDCrjg9KhRMgfUaQ5wvFdAILIJ+KJxIythXbxl2DudG1ny
	 6tPkIKJBZtN1QqqRhBrdVrjEHLxHNDazsSSAGXNV6/vFAwylTY5nsLR8bFV6JyMjZO
	 iCqOtgaf65zxNMDC0B7+AsdsCtdYCThD9y8rPIyO8SbNqJMdrALHupnB49CN6j9eDA
	 0SQ3+IxKdr/f/jFAtkS8A2J+ex/qA+tAfeh8rwofIinxaf4uRECGvhVZtZmc5/lO/T
	 2L1Sj+MI9pXBQ==
Date: Mon, 3 Nov 2025 15:33:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>,
	jic23@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 1/1] spi: offload: Add offset parameter
Message-ID: <aQjLTc_2gnmv6Im3@finisterre.sirena.org.uk>
References: <cd315e95c0bd8523f00e91c400abcd6a418e5924.1759760519.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o8Uu4xR4vYJkTo3h"
Content-Disposition: inline
In-Reply-To: <cd315e95c0bd8523f00e91c400abcd6a418e5924.1759760519.git.marcelo.schmitt@analog.com>
X-Cookie: If in doubt, mumble.


--o8Uu4xR4vYJkTo3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 11:25:41AM -0300, Marcelo Schmitt wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
>=20
> Add an offset parameter that can be passed in the periodic trigger.
> This is useful for example when ADC drivers implement a separate periodic
> signal to trigger conversion and need offload to read the result with
> some delay. While at it, add some documentation to offload periodic trigg=
er
> parameters.

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
offload-offset

for you to fetch changes up to b83fb1b14c06bdd765903ac852ba20a14e24f227:

  spi: offload: Add offset parameter (2025-10-13 11:27:52 +0100)

----------------------------------------------------------------
spi: offload: Add offset parameter

Add an offset parameter that can be passed in the periodic trigger.
This is useful for example when ADC drivers implement a separate periodic
signal to trigger conversion and need offload to read the result with
some delay. While at it, add some documentation to offload periodic trigger
parameters.

----------------------------------------------------------------
Axel Haslam (1):
      spi: offload: Add offset parameter

Mark Brown (1):
      Merge existing fixes from spi/for-6.18 into new branch

 Documentation/devicetree/bindings/spi/spi-cadence.yaml | 11 ++++++++---
 drivers/spi/spi-dw-mmio.c                              |  4 +++-
 drivers/spi/spi-offload-trigger-pwm.c                  |  3 +++
 drivers/spi/spi-rockchip-sfc.c                         | 12 +++++++++++-
 include/linux/spi/offload/types.h                      |  9 +++++++++
 5 files changed, 34 insertions(+), 5 deletions(-)

--o8Uu4xR4vYJkTo3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkIy0wACgkQJNaLcl1U
h9B+TQf8CLMMp0eFM4Yft6zWiJu3qRiTwKgwwP8ASigBd/9Zl4WfV2JcrdE0IMzP
GZsATHGwDGWbgG4Gkak2Q31XLQIyfVPg1hCEBuC3MEvPafGScG4q8wACtOBJDV/0
8vj1B9PAyEKETM/2PrsOpPZQx7nXuFTRM699p1ICONrGYx/vTScIfxMMYd5Opy93
bagKs62vmVPSAaZ8YLHLC8a+kxIMVb051vSUacEEl2vZNCVS8atZIOfne4pjkvWd
AAmiPnypnYSnV2NrHI0z+yfCAqTV92TToD5HNBAVyGgkeUBhEVNT+o8KceYqlmyG
tTcDZTSksf70z5bfXsMVz7G+GimfYQ==
=BJP0
-----END PGP SIGNATURE-----

--o8Uu4xR4vYJkTo3h--

