Return-Path: <linux-iio+bounces-14917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4034A2595D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 13:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C880E3A6355
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 12:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA1D202C23;
	Mon,  3 Feb 2025 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgyFBLHk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8E201016;
	Mon,  3 Feb 2025 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738585507; cv=none; b=eDpAyhxg4lpnCc1hQcK7rlgyXy/akbWiODoOIbgQnainhmaN3+hmY3o05CbBxVyqTjKjP8t6MPdU7N5XRpF0PGFCYmAT7is3F+f931sjJHqofqbEk9c7YVcY/rou6BPgOND3uI4BFLxfBG4vYctLIG0625iXVlAYgGPIeZvJDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738585507; c=relaxed/simple;
	bh=Yy5ZhC9XApBt7e/QvLBQSPY6sVLlD4cP7bLWazn+hTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmqFP0PE7meW755ZYON7aloSA8PMqWbPFAJuikwlPKSesYNGRjmlnIwTG7rXrfXxCNZNERS44jGfsZVnqPEaHY5GZ8P8A8Q7VPtREa1E336CGUuMvDwrHhOhwNaJ2MZ5a6JpsaM0rkq1+dL56YY6HC0GedPMCkR7MbPFpoxohY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgyFBLHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8399FC4CED2;
	Mon,  3 Feb 2025 12:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738585506;
	bh=Yy5ZhC9XApBt7e/QvLBQSPY6sVLlD4cP7bLWazn+hTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgyFBLHkuVy8bN5kDhkP1EGbAK7ioccPHVyLC25mEIayv3DJK7Tm2uRsQq2Jh0fAa
	 Int2NvfquWUvgrFZzmX67B845a0Y8UBFyg7F9lNoSnr141x2o7Hovef8R5iaJkW14L
	 O8Mw7GQg0x3bUmkm8V0HFhTiojVKh8J8yYO+/SA0RETVXQghpzP8Z6pw3Yuc9w2wuP
	 O/+dKCQy4+GohyTHCsRFy49HyIbtiUwOfs6Pip5+i0hyjjmkT3KjAT7BRymP6hhhlc
	 +7Lo9yiSJ7ER7dh3tF9j6L7ovChKtZABgfMeLV3WJ2J1EU47uFYiskzBnfxrlg6XKZ
	 xHQ+uFN17i2eg==
Date: Mon, 3 Feb 2025 12:24:55 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 13/13] ASoC: adau1701: use gpiods_set_array_value_cansleep
Message-ID: <a6e7f5c5-6dfa-4478-9a18-85d0897c7ca4@sirena.org.uk>
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
 <20250131-gpio-set-array-helper-v1-13-991c8ccb4d6e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QNJzo4TIn39F+gZd"
Content-Disposition: inline
In-Reply-To: <20250131-gpio-set-array-helper-v1-13-991c8ccb4d6e@baylibre.com>
X-Cookie: May your camel be as swift as the wind.


--QNJzo4TIn39F+gZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2025 at 02:24:53PM -0600, David Lechner wrote:
> Reduce verbosity by using gpiods_set_array_value_cansleep() instead of
> gpiods_set_array_value_cansleep().

Acked-by: Mark Brown <broonie@kernel.org>

--QNJzo4TIn39F+gZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmegtZYACgkQJNaLcl1U
h9BWNAf8CyCYjo0Xa7gTkGLLmI7BwVTj9VwAQiohEN7S8mXh4x6BMNsbB+GhBmqK
2cqPWAhXgBCR1kvmebge+UItA8kk9Hm/vKTZ2fJEuzIYpyKG6wVv65lqUDTGme3j
svxI492/g6DoPUWI/ZaK8PUVOqmQNjE+wky7xOZdb2eG5WFl5OwmCxNLlXogEngj
cWS5wNOJfsvcnrpTUwUP3HFFMEqmCU+KQAvQrEDnNEi5ad4AHR9kElX7nlTRNvtQ
CEboCfNuVvPxROZwWiizYuHZ920bL96QbtbAOiaXsYF5okR3tpwqkS07hsFyNr0u
JaOgDbfFUiICPW9L9H5h2OFYo5ZpxQ==
=nBtG
-----END PGP SIGNATURE-----

--QNJzo4TIn39F+gZd--

