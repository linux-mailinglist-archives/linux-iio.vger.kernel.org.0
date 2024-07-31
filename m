Return-Path: <linux-iio+bounces-8075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A34999423B1
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 02:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D08FB24645
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 00:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D9F1FA4;
	Wed, 31 Jul 2024 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpbLC2Dk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B09C7FD;
	Wed, 31 Jul 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722384310; cv=none; b=DleqnxhYRsQ2224JPNh06yc/PFvPPbXZq9j8as5wfGuYPn4GbTJnxxiuS1xU3xcUY+qT9Q5Wq+Ke3S0s6TtaW6m8mCUZpcOigEPowEmkBQTMCWQg4f5EFCDS52PGkhcn1eOCpDbne+n+02FOWxUqLdtrQeIPs93JzbumPc+S8JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722384310; c=relaxed/simple;
	bh=/lIIeNoHyasDW8eVa8mloH62NADC/12tw0iVP9lb8oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUW7Z2ADlnblrTwH44g+Xw8aGY5bxFFUkoDO3pwbyj/vbfVBrHW4yDyt4XxNzx9myoWLLd5PS0WwgnCe59ai4ZBEnSc5pOym1zlxjV9gLPcfItFex4xOzhOz/MzDSfQhwAde04LLDrqvhIiOrKSWyuj4N7GAIUwzu3UYxY/CD+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpbLC2Dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30146C32782;
	Wed, 31 Jul 2024 00:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722384309;
	bh=/lIIeNoHyasDW8eVa8mloH62NADC/12tw0iVP9lb8oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpbLC2DkPkdlxNQ3CyWVzOCyU0qqir8qddA0+YlLv+8V67g/AQoc48q+PyAFpDzxn
	 if4+n7GTeCAJhzm2cM+Ha5MdKuX2qe7Kew2dULqkrTA50ftLBgjLmBmAJjTETmTAUQ
	 MxB/w3juFkZABJvUQ5XN0XWJBMqOAnRkdHXW3XodS/0gYhPXbcIXXIu9+bbbzeZ2eA
	 Pk8r9zmxkzbEshihcHApjjt7FQ8a1iZB5W/OJ/osEJcMAoH/PzwUIW4lEOBfA6MaBw
	 OAC5nR+02Ki/fJ7q/nvnhY3/ZV0DdEaa3cB6v3fGeXUsQHs4VLSiIV+iGC/N7PXPHI
	 Cieba4OL40Gag==
Date: Wed, 31 Jul 2024 01:04:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	corbet@lwn.net, marcelo.schmitt1@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/7] Add support for AD4000 series of ADCs
Message-ID: <a76c50b6-b1a4-4e99-b353-51ee3454ef0e@sirena.org.uk>
References: <cover.1720810545.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Arvazn/Tx4fbX1Zo"
Content-Disposition: inline
In-Reply-To: <cover.1720810545.git.marcelo.schmitt@analog.com>
X-Cookie: May all your PUSHes be POPped.


--Arvazn/Tx4fbX1Zo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2024 at 04:20:00PM -0300, Marcelo Schmitt wrote:
> This patch series extends the SPI bitbang, gpio, and spi-engine controllers to
> support configurable MOSI line idle states.

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-mosi-config

for you to fetch changes up to 96472f18a4affdaff5013a836c48375f1eddb4a4:

  dt-bindings: iio: adc: Add AD4000 (2024-07-29 01:19:55 +0100)

----------------------------------------------------------------
spi: Support MOSI idle configuration

Add support for configuring the idle state of the MOSI signal in
controllers.

----------------------------------------------------------------
Marcelo Schmitt (5):
      spi: Enable controllers to extend the SPI protocol with MOSI idle configuration
      spi: bitbang: Implement support for MOSI idle state configuration
      spi: spi-gpio: Add support for MOSI idle state configuration
      spi: spi-axi-spi-engine: Add support for MOSI idle configuration
      dt-bindings: iio: adc: Add AD4000

 .../devicetree/bindings/iio/adc/adi,ad4000.yaml    | 197 +++++++++++++++++++++
 Documentation/spi/spi-summary.rst                  |  83 +++++++++
 MAINTAINERS                                        |   7 +
 drivers/spi/spi-axi-spi-engine.c                   |  15 +-
 drivers/spi/spi-bitbang.c                          |  24 +++
 drivers/spi/spi-gpio.c                             |  12 +-
 drivers/spi/spi.c                                  |   6 +
 include/linux/spi/spi_bitbang.h                    |   1 +
 include/uapi/linux/spi/spi.h                       |   5 +-
 9 files changed, 344 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml

--Arvazn/Tx4fbX1Zo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmapf6UACgkQJNaLcl1U
h9AiwQf/XcIk98YDz7GB9SR622tsKCJ2y0tmd2LudEfcjtQiRohCQdCwiuz+NXBS
91FYydVEhAwxKN6hnZTxtbyJzojW0/BJIPrumlZnmAyK6C29fP8PRg7TblEYjWxt
0tjWZ/7G6IWR3D6lpBKkyeSxuYrfmrJyaU2Fd9X1+LDeqkU0JwuhUAheXsExHlBM
u+eECotMLQS2OS8/dsHy5ykuURF4pF3rrQ//luefyqiyqKXR53jXChduQximqJ6o
uUgWTzcBulW87+3JmBmamPL6/9rUCy6lai6rzjCiNS7735LeaGjUJtC1TDOpcnJb
AETnGo6zbOwwiR4fMjtILzCRqaJQiA==
=EV5D
-----END PGP SIGNATURE-----

--Arvazn/Tx4fbX1Zo--

