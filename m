Return-Path: <linux-iio+bounces-6913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9A0916DFC
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 18:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A7C283D1F
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7167173325;
	Tue, 25 Jun 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QibZCrOJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E62449629;
	Tue, 25 Jun 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332664; cv=none; b=DMNsON4fGDqaeytyVpxwNecJf1M65dQJXPFzjX0dd/RfDnNeX/8rRSNBoJ4yFnL/fjgW19zyDwStdcGg6x7u6sc1cM5PPp/44PNOiWXLjvqyC5+4JMIlR2ASknMs7Shh2+F05XJkSR7M73qCAE9O41H+PYj079bDeWBJhbZOCe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332664; c=relaxed/simple;
	bh=7YZlz23yUHTKCjEJ0DtkNCpW8MKikV7v5efaQ6NoijI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoctrbQ6TNO6Y+0kTE8mFFMUmdqcJcul1HyiwV5n4BCxHBQSdWodLA2p9lonkV/7EDRgYYs8z13jJQOSCvsyA9FWZLDzYB817AIQDQj277bPXUzGUPiTNGLdAgbjnB367G7nk/cQNnBBVoqWqAo6oG3j/vi4aljqqVIoqzk1tIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QibZCrOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C237DC32781;
	Tue, 25 Jun 2024 16:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719332664;
	bh=7YZlz23yUHTKCjEJ0DtkNCpW8MKikV7v5efaQ6NoijI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QibZCrOJE3TdSC/l6jubXU5aQ6D6tBlszjzyGCmfHCrWr8u7S16hKoB+8UhJWUfUU
	 50AX+3jqnm/RPWUcMAg70zsj9HanIUY6o2ws4vYQNHYSouCjdZk/l4we7TyaTVQHo1
	 2OWuHTxFXU4ySpoth1awIcoY8clXvBWP09YMU2wDSfIlmBkM8pZDEwYiLC4RRLFe+y
	 COx3WQLjoPVPZ9FdS4CK/hkhup7ppglV2YzHb+3LB/XlmJAro1WIKIdqgtFiijQKJq
	 +CXEX43uXCnT231WwnkoF6SC8WeRGAfKPFFaUkgNOFb8ir0WedmZM7BqzZGCVmWogS
	 F7QPoBObm0DQg==
Date: Tue, 25 Jun 2024 17:24:18 +0100
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: add
 EXPORT_SYMBOL_GPL(devm_spi_optimize_message)
Message-ID: <0bf8f28d-e8df-458e-aa23-f597ba009466@sirena.org.uk>
References: <20240624-devm_spi_optimize_message-v2-0-58155c0180c2@baylibre.com>
 <20240624-devm_spi_optimize_message-v2-1-58155c0180c2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ko8OmLQlxLrDF+hM"
Content-Disposition: inline
In-Reply-To: <20240624-devm_spi_optimize_message-v2-1-58155c0180c2@baylibre.com>
X-Cookie: Results vary by individual.


--Ko8OmLQlxLrDF+hM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2024 at 03:10:30PM -0500, David Lechner wrote:
> devm_spi_optimize_message() is a public function and needs
> EXPORT_SYMBOL_GPL.

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-devm-optimize

for you to fetch changes up to 7e74a45c7afdd8a9f82d14fd79ae0383bbaaed1e:

  spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message) (2024-06-24 21:25:57 +0100)

----------------------------------------------------------------
spi: add devm_spi_optimize_message() helper

Helper from David Lechner <dlechner@baylibre.com>:

    In the IIO subsystem, we are finding that it is common to call
    spi_optimize_message() during driver probe since the SPI message
    doesn't change for the lifetime of the driver. This patch adds a
    devm_spi_optimize_message() helper to simplify this common pattern.

----------------------------------------------------------------
David Lechner (3):
      Documentation: devres: add missing SPI helpers
      spi: add devm_spi_optimize_message() helper
      spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)

 Documentation/driver-api/driver-model/devres.rst |  3 +++
 drivers/spi/spi.c                                | 28 ++++++++++++++++++++++++
 include/linux/spi/spi.h                          |  2 ++
 3 files changed, 33 insertions(+)

--Ko8OmLQlxLrDF+hM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ67zEACgkQJNaLcl1U
h9AtDgf9G4HuXLXJ2ShPnYWdK55ZIitx+2RbwKOwcYn0s6zT4jUrMp8C2ggDu6Bk
tEBWoHQq8LEjne7rvdJPe3bQgn1P/oX/uTyYrinnUCzACuv1D0HVmLOWescGu58K
DFULjCinMjTDxTbTqIfmCyA00KzWbGdqPxyGuNAFUId+bRXVxR+DSJR4/4A9/A06
39NlPhx41PePcsDgueEQActE2eZGWk3G/0wYybsgYIJx/sma5+oS+3+2fBr13xfq
1Xaibgp2Vwf9qcANlaFVY3IVC4VyBBiQfAeSbzU7viDKAfcVGwYYajqg8XOIdnuR
MjQFfz+1nXMQqqDPLK6Frx6hiwLUiQ==
=YZv0
-----END PGP SIGNATURE-----

--Ko8OmLQlxLrDF+hM--

