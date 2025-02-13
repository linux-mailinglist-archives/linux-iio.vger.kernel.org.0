Return-Path: <linux-iio+bounces-15503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4DBA34D13
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 19:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBB51891241
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8286B245B12;
	Thu, 13 Feb 2025 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm9yNc2T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CFF24290C;
	Thu, 13 Feb 2025 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469855; cv=none; b=qd38jjys2Lehv+B5mWdd9PFOzEQBpSJ4OVO5D5tQjM85HvHsreLLZJvkcrw0oGH77F+ttHT786L0nI8hV0YML7patLn0Ocxe8uZ9+h33BMl5txlIXgn0dX2Y9rv023v74KQVR4JwctP3b5pcvYyEHb4DEBXDgOd8Typ3xotSn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469855; c=relaxed/simple;
	bh=F3mVXg5snyDpxEsavZ/5IjthjylA1qbTG8dFGI27YYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXtazYKQiWlGmstBigXdYwRrMFPTIAvBstJZVg90mC9XWSJh4XwE8GyXf9/F9C2PCREbRdHMiojTrRbW2sr7ictL7Kfm1N0fQf5lL//OBrPbyVKVv2ZUKab6UgviEFfRGaOYjwmbHOFY1lpyG51k+95tcZUuzpq2Jb1WZcS/nJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qm9yNc2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FC6C4CED1;
	Thu, 13 Feb 2025 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739469854;
	bh=F3mVXg5snyDpxEsavZ/5IjthjylA1qbTG8dFGI27YYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qm9yNc2T/FZRL+nWkoWqyuclWyXIxj7RSCvd8Il+j9Mcr0q18gifQlmhE4Jqn/QtT
	 SHV5jzlLb+lJgNVOXSn63z76y+Ab9cQ/uBggC1lAEVvOvpJMRDdlJ7eNAqOL0k0vD3
	 8EmxbuLba8Z//xg/3GRX+7JX5hhPxSeMBAyFgX04i1TWpJYrULPt6OqVD+JM1wqM6C
	 jZ+/gP3k681pGkaYyHLuoIN3tn66OHhTGDdamLv9vrL3kdfMV/4mOLV+/STaB37IOb
	 odPhRLQZz0kNZMUsQ0bLZiVqKnrdXn1A3kIG5447I5PAaxpI+lgX6UV3+FiuroBz6m
	 k5bnVgDCx1VrA==
Date: Thu, 13 Feb 2025 18:04:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: David Lechner <dlechner@baylibre.com>,
	Linus Walleij <linus.walleij@linaro.org>,
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-sound@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: (subset) [PATCH v3 00/15] gpiolib: add
 gpiod_multi_set_value_cansleep
Message-ID: <a98d8255-6267-4c4f-9b75-8f3fbdaadc90@sirena.org.uk>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <173935301204.11039.10193374588878813157.b4-ty@linaro.org>
 <801b5364-129f-42e9-bf9a-a90d9eeb4629@baylibre.com>
 <CAMRc=MeXTvPnEPjOmPd5Vw0FYKHzndsB0SVjQErA4CY_0MGsMQ@mail.gmail.com>
 <7989a6a0-b761-416c-ad97-69bd23fdc2c4@sirena.org.uk>
 <CAMRc=Mea5imComkraP=v9TKsxLDoBm4XtbLL1QxCbhJ8d4uxcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8dqGeFBusm2eevtX"
Content-Disposition: inline
In-Reply-To: <CAMRc=Mea5imComkraP=v9TKsxLDoBm4XtbLL1QxCbhJ8d4uxcA@mail.gmail.com>
X-Cookie: Take it easy, we're in a hurry.


--8dqGeFBusm2eevtX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 06:58:04PM +0100, Bartosz Golaszewski wrote:
> On Thu, Feb 13, 2025 at 6:53=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > If people are acking things that generally means they're expecting them
> > to go along with the rest of the series.  When you didn't apply the ASoC
> > patch I did actually put into CI but it was a bit surprising that you
> > seemed to be expecting that.

> There was no clear consensus. Some patches are still not acked.

What I would do in that situation is apply the patches that were acked
and leave the rest.

> No worries, I will take the acked ones. I didn't see any b4
> notifications from your side yet, so I assume the patches are still
> pending?

Yes, like I say they're in CI.

--8dqGeFBusm2eevtX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeuNBUACgkQJNaLcl1U
h9D7XAf/ZOJbznj+kR0nWMA9aMwpcy+sZtOGrPU2NlEuXbE9T6iSncOwANVAM/WG
qy0hFl8VWIWtR5k6vSTQqcIXIDfpzlG9WivypRx4LeCZf2k0NwqoTffiijgvzYzG
4+n/G6f1+tWy4gMxAWSiCWihVjnY6OzIdnwZ/h1OyIk1udqQlKCgJ3/wPbCh5HzM
nWQdusaZRMBjQrHhbtzsWbTuilCb5US2Hu0/eDDjxo1ebJizZm2oIr8mcdu51rSf
YlLi5/GlFwwo+ItSnnbI8Dl7BbrcLWr3MOXyLOSISKN4jA/VT+MKUU/NHl5FvsrX
4fwSx/1bsqjSeBP6FjEdoniRW8UjPw==
=t6DC
-----END PGP SIGNATURE-----

--8dqGeFBusm2eevtX--

