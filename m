Return-Path: <linux-iio+bounces-6785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34082913D24
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 19:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654CC1C215D1
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E59118309B;
	Sun, 23 Jun 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEXYZkcB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ACE3C38;
	Sun, 23 Jun 2024 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163244; cv=none; b=Eb15qccewJFxhMDzqE44ZE6jkU55B8voDPO/AO5iBM6JoJoGjizrTeQntgSiMvuXNrB/CBwJIc0cVOVQFSBzQf4+rbEJSpCwTL09yXooiUb2HgEcqSIC1B1+MaB2NULB+pw7E0xZxTZ/+A0BgOTY70D+p+XcYh4DoZrZmX5orbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163244; c=relaxed/simple;
	bh=KUOUtfCCNgKjqvSnv1mUVYz9cezEf0ZdtMMNdF+YRTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIbwdSHk/Z5aqaOce6wq/NdeYAgCce7CRKwDokO2n/NKvT4Lfo2vQy7uGbC8GIF6yCVOJE0PrrVeS6QKP+7h9Dls8VQpwuiLOLgFXCrG+OLOo7ppB1r0+eLXaWyKJKHQN2z9uJ6OCqhXzI4HSaBriGM6nsVxp72HFRKHB4ESnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEXYZkcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256F4C2BD10;
	Sun, 23 Jun 2024 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719163244;
	bh=KUOUtfCCNgKjqvSnv1mUVYz9cezEf0ZdtMMNdF+YRTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEXYZkcBMbbBa8Dgj9xww3AWH8QdD7br+mrv8Z5uUwd5F+RlOeigbHp+gxIqkPhKS
	 B21F8Lgw59JfMNcE5ZIgZQnpkLX/LMMSFtNnatsa05A0rXV1MyYIk1XRUlugjHizpu
	 59vOaXWKyXlR3up8CHNAgTrCwairr/H+oSAkAGbWzknJBFq7ihYtLrQ2526n7LhJLX
	 YXAHn5YS908mhsQslhuVe03WELzdtDRrHi8yh2tRbQnH72V+P26vh755xbIgcdUgul
	 V6SLq+EpA3/Bb8cqnhkPhyBhsZiSRPaef9WKnPAv/M7eA3P2LhGM98Q9BymKexk9OP
	 QHRYH/QuVUM+Q==
Date: Sun, 23 Jun 2024 18:20:39 +0100
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] spi: add devm_spi_optimize_message() helper
Message-ID: <95eeae71-5270-4df2-acf4-a5308c2a8690@sirena.org.uk>
References: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l89kX42SZQGjRE9O"
Content-Disposition: inline
In-Reply-To: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
X-Cookie: Here there be tygers.


--l89kX42SZQGjRE9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 21, 2024 at 03:51:29PM -0500, David Lechner wrote:
> In the IIO subsystem, we are finding that it is common to call
> spi_optimize_message() during driver probe since the SPI message
> doesn't change for the lifetime of the driver. This patch adds a
> devm_spi_optimize_message() helper to simplify this common pattern.

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-devm-optimize

for you to fetch changes up to d4a0055fdc22381fa256e345095e88d134e354c5:

  spi: add devm_spi_optimize_message() helper (2024-06-22 12:14:33 +0100)

----------------------------------------------------------------
spi: add devm_spi_optimize_message() helper

Helper from David Lechner <dlechner@baylibre.com>:

    In the IIO subsystem, we are finding that it is common to call
    spi_optimize_message() during driver probe since the SPI message
    doesn't change for the lifetime of the driver. This patch adds a
    devm_spi_optimize_message() helper to simplify this common pattern.

----------------------------------------------------------------
David Lechner (2):
      Documentation: devres: add missing SPI helpers
      spi: add devm_spi_optimize_message() helper

 Documentation/driver-api/driver-model/devres.rst |  3 +++
 drivers/spi/spi.c                                | 27 ++++++++++++++++++++++++
 include/linux/spi/spi.h                          |  2 ++
 3 files changed, 32 insertions(+)

--l89kX42SZQGjRE9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ4WWYACgkQJNaLcl1U
h9DfRQf9Gcmpc9JBXul+Q2yiIl3Kl5FyHHIt7plQmobk8GEOn5VGXmpgnoujaswk
IveJkQDXAxRQ/G1/Nu4YhiUbLyqLpnj3pYaUo1zKfNoJNsGTm8Klhx0uoSlhBWYd
f9WHo6tdlmpF7Qebaz0iCq4uUb1MsyTnnvhgoL2498gBl9YQxjGNVwMCrFro/8x2
O/4qQefyaTiUn5eO2nXYrMIlWaPhhT3DjGKlkWyKAyZzCj0HO8R0uF2BNuIOfhz4
QJmFTcQT5NNmd5RfQVlVIdmvdiRfpk7LR/W0723SwDW72a+GjNOkrTMGk9f5RIwn
eoN1KzPdmAaU+WxzwkAIjmm+nLMMww==
=yTLn
-----END PGP SIGNATURE-----

--l89kX42SZQGjRE9O--

