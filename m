Return-Path: <linux-iio+bounces-15500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78561A34C6F
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 18:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D45188C619
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D665E23A9B5;
	Thu, 13 Feb 2025 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tS2lLmVd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F42428A2D6;
	Thu, 13 Feb 2025 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469186; cv=none; b=eNnQr+rN+u0IbyLM7iOdGRD3YG8tMKwBpf7hWq6dxDxpQ5wwQC0bfv+4rWy7AEHTEl5fue8FylNtl1qAQpyR36O/4WobrdYOHRqbBHFHDQvFiYKLTkaEOsnObF3rjc8Wh63KsCC3m7+dAgXZ1w7Oi1HdmGaT3X1nC9ZDkJ0OWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469186; c=relaxed/simple;
	bh=0/EZ08bVHan3Oir1oM3FqVRV3qOf4zQaimq6QliMxv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY6yDt3qvEY7GByuphWWoFV6bfhzOGux+q8hk1rXOFIoEg6t2nfHHYERrcXILtvoG/lj11ghi+eENbIUM6lMdtvTo4rBzP/JtkBLazrKiDKLWFo22FrW9O1yA82XKFt2RLOsbxlaA1+8dZz4diZXfFr33wwwAAYxoSzk/uhsQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tS2lLmVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEA1C4CED1;
	Thu, 13 Feb 2025 17:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739469186;
	bh=0/EZ08bVHan3Oir1oM3FqVRV3qOf4zQaimq6QliMxv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tS2lLmVdPvAZXUu/UmlDRziM1qm9d2Bg4NRvDv5uzGqDYiZOSrgzi5no2n9N++ZdX
	 oHRJkPLSZq+PrL7V5NEMyvzmmpeKsnPoXZNx42bTHsBpLj5Jxv68XPw3GHbduDjrJf
	 qgF8Tmb+/6RUUNVT83x9CWZ41jUMN0XZq7jgyJ5WVa6Gj6LLFiIvFLcNN2tyxGpUjt
	 VLVljmLmMshzHV7jEmI7CfmG6EC/KfO6/Y+nBzMu0p4O7UwC49DjNkXZsTy/8CPZiy
	 wBY1c5w+Vwg0jyxI9nrF7NKhxt0MDnJsutq0jwETD6vEkiF37z7pigNaiWF04Zbfop
	 X8TgFF+tmoELQ==
Date: Thu, 13 Feb 2025 17:52:56 +0000
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
Message-ID: <7989a6a0-b761-416c-ad97-69bd23fdc2c4@sirena.org.uk>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <173935301204.11039.10193374588878813157.b4-ty@linaro.org>
 <801b5364-129f-42e9-bf9a-a90d9eeb4629@baylibre.com>
 <CAMRc=MeXTvPnEPjOmPd5Vw0FYKHzndsB0SVjQErA4CY_0MGsMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZlXg6mnu447oqkvT"
Content-Disposition: inline
In-Reply-To: <CAMRc=MeXTvPnEPjOmPd5Vw0FYKHzndsB0SVjQErA4CY_0MGsMQ@mail.gmail.com>
X-Cookie: Take it easy, we're in a hurry.


--ZlXg6mnu447oqkvT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 06:42:19PM +0100, Bartosz Golaszewski wrote:
> On Thu, Feb 13, 2025 at 6:25=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:

> > Do you plan to pick up the other patches that have been acked
> > as well? It seems like most folks were OK with everything going
> > though the gpio tree since the changes are small.

> Jonathan requested a branch so I made one and sent out a PR. I figured
> people would just pick the relevant patches into their respective
> trees? For patches that won't be in next by rc5 - I will take them if
> Acked - just remind me.

If people are acking things that generally means they're expecting them
to go along with the rest of the series.  When you didn't apply the ASoC
patch I did actually put into CI but it was a bit surprising that you
seemed to be expecting that.

--ZlXg6mnu447oqkvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeuMXgACgkQJNaLcl1U
h9BoDgf/W5CpihAHC/LYRf8SQvXiRwjxswvLLHFJuH31Mlm004xXbQEhnVGnx0y5
BQuUSIV5VBOy8sV3etF5jay1rfAtGlXAa6tfyCNLSjF6164Pa3MmGuNcxlA6mijW
bHTSKgw0661wFELE/2qvRoPQKQmeo6POj/IJBf5mM4u4keHyjlCm+3FaYkBMTz16
Plm2wDHNvrjxP4KKza3/uwwcSJTSQrVF2SXDqi/bFgV18RrljglU4KJAiM+K08OB
o0BJjYG+Rxesf072hc7kDvG/B3yk/8cC8bnDpdtIkeVN+dVcW2d7QktryNVqQgbM
xlC6PgwJOwzMzOkxSTgIUpQqYYa8nQ==
=Ir02
-----END PGP SIGNATURE-----

--ZlXg6mnu447oqkvT--

