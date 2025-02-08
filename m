Return-Path: <linux-iio+bounces-15163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC762A2D64D
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 14:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFEB1885712
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA502475EA;
	Sat,  8 Feb 2025 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7mZXu+F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D6E246335;
	Sat,  8 Feb 2025 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739021009; cv=none; b=CrwkcfJqxGsUnpantHVSNS5l/cS2DIobKsuucz7rKwpuy8lrX1+Enpe8bqVZN3UCI5R8ME0n+CpBPdAMcyrreBRXo1WR8GSRqraUnKo5SAPXUnTUBMU6ucOaQumecL93F1wKxh/eylX9+Nm4VRGFmK0f5JZstYMie4pEuUboIX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739021009; c=relaxed/simple;
	bh=UNQXvy+RWVdaIktgs9KmgGDMboPWfIfWS1mqCJ2dRMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iikbuXTnK8R88zZ2nSzF70WwyfOMTyJMG20F+0Lk9+gTjtL3OqtmPQcUzz98oD2u4ktelPTkl5tO33/WTtNUrM6ukfn31kPnJnEKFNS3m/i4oITjXQzBCLVJ4sgKOrDdazUKOUN3WNVRr3j0/VtxQqu2P3hOaP7Ab2Fo6KPm9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7mZXu+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BC1C4CED6;
	Sat,  8 Feb 2025 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739021008;
	bh=UNQXvy+RWVdaIktgs9KmgGDMboPWfIfWS1mqCJ2dRMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n7mZXu+FCZa2zBnn8hwWDCQCrgdVRU/FiEZdEcQhRFE2+nrnbu4E/0rVIg30241ib
	 j0uIVrbv8sxiG5Wl8Yy7b/XA4xW3Sd4uxw3aSH7yTq04q3R7OFyMX+WHkGLZuizJ9k
	 z6GuuALfG/T8Bah6qucmpo2JYD+ThC0uCCsoYMYUlvSsIkD6sneYZan+4gme1v3dxB
	 B6zYusbkISPsakXAcWU4bCRtbGN6JI/Don++Czch/tP72/U2kR50qAmUDp6wVrUfyQ
	 xTrNY7rF50Zq6Fg8HGxNLhtOrMUMH9Hd45oFh73gupOaHy3TLmExhSv0xB6tntaZ2r
	 whcVehzM3yyeA==
Date: Sat, 8 Feb 2025 13:23:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy
 Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Ulf Hansson <ulf.hansson@linaro.org>, Peter
 Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 06/13] iio: adc: ad7606: use
 gpiod_multi_set_value_cansleep
Message-ID: <20250208132313.5b151ca0@jic23-huawei>
In-Reply-To: <CAHp75Vfb7EgHkHtqm4b0QnG=uWwszpWwFe8MLDPRSifKtQFAcA@mail.gmail.com>
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
	<20250206-gpio-set-array-helper-v2-6-1c5f048f79c3@baylibre.com>
	<CAHp75Vfb7EgHkHtqm4b0QnG=uWwszpWwFe8MLDPRSifKtQFAcA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Feb 2025 14:13:23 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Feb 7, 2025 at 12:48=E2=80=AFAM David Lechner <dlechner@baylibre.=
com> wrote:
> >
> > Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
> > gpiod_set_array_value().
> >
> > These are not called in an atomic context, so changing to the cansleep
> > variant is fine. =20
>=20
> ...
>=20
> >         if (st->gpio_os) {
> > -               gpiod_set_array_value(st->gpio_os->ndescs,
> > -                                     st->gpio_os->desc, st->gpio_os->i=
nfo, os);
> > +               gpiod_multi_set_value_cansleep(st->gpio_os, os);
> >         } =20
>=20
> Now I do not see any justification to leave {}.
>=20
With that tidied up (good spot!) if this goes through the GPIO tree
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



