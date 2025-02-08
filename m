Return-Path: <linux-iio+bounces-15160-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F74DA2D63C
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 14:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1676D16A7CE
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 13:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2132475D8;
	Sat,  8 Feb 2025 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrOIag8i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E31A7264;
	Sat,  8 Feb 2025 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739020838; cv=none; b=u4wmEI2uDrkMVJ432IPU68j25Kx9QFgYVfgU9Ow4jVU98nHx7vGwuMe2jim9MyF17CLbWZicYoL6OiCswWAZ6jzZv0WV5zUpL6JuG/Iq3GGhqMpats8bc0fm1c50ZtTa037LtuLINEk+xtqEEOwcBRh0wl0i4ewHwH0hgvgIPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739020838; c=relaxed/simple;
	bh=9W1Za/kbQu2xjBOIJYW7uwANkTVDwhxj/uoxldA8a54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nh8Xv/4U/1KCMb0rd/m78bwupbnc6jLosrbB6ErD3WNY4jf950SlnjyjHpxbMZ7/Pw0an+hodFS3n9CUQ2BkzNWQxa6lDGvL63O65YK8YQyYGi25MgmabzIYRdBIyQBGVKbEk3Tb/OX4vXn2d7jKekfqGNOS1Jl9jwWx9SRsVQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrOIag8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52FAC4CED6;
	Sat,  8 Feb 2025 13:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739020837;
	bh=9W1Za/kbQu2xjBOIJYW7uwANkTVDwhxj/uoxldA8a54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RrOIag8iqPc6KucVE91+M9OmAQtQ+pTpaePLyLuUomKErjy7CfkIoji0E2gJGBrPP
	 juxtLBHD4HXGM+K2063t/St1rKXOYVYo2GJgEdWTCyCHAGX43DGvMJJIssiVRh0vdh
	 naUzKVmpMN6/8o6jJHrA5XRi6FPUVwpCQCHT4Eresz0CpkfJud0IUbEuT6cnMvvWEJ
	 F5lZE8DaR8bbeeC+a0Zaff3qqIWzgDvOPYXTtwoKZASCtLqZ99Jb+2CCE2ewI8su1a
	 NZ7Qr23h/O7RZZBcQQC+CIbYF3LigoEkwoBcQR/tZpK5pZAvGGr9qE5ofDljpaqJJs
	 vYWfToR/We03g==
Date: Sat, 8 Feb 2025 13:20:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, David Lechner <dlechner@baylibre.com>, Linus Walleij
 <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Peter Rosin
 <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
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
Subject: Re: [PATCH v2 00/13] gpiolib: add gpiod_multi_set_value_cansleep
Message-ID: <20250208132022.564e7a46@jic23-huawei>
In-Reply-To: <CAHp75VdmN2wqwwnea0gtTQJ+Y5twQaJp6iEL2esEMCHDi8bvVg@mail.gmail.com>
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
	<CAMRc=Mf9WQjVXvea7tHx0MJG2H8Yqxw=zGqvjp7dfD7+=huDKw@mail.gmail.com>
	<CAPDyKFoNuXpTEm1rLPvAgib+ugqr7XyETZhfrNr6ypOOKRwjXQ@mail.gmail.com>
	<CAHp75VdmN2wqwwnea0gtTQJ+Y5twQaJp6iEL2esEMCHDi8bvVg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Feb 2025 14:20:16 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Feb 7, 2025 at 11:48=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> > On Fri, 7 Feb 2025 at 08:49, Bartosz Golaszewski <brgl@bgdev.pl> wrote:=
 =20
> > > On Thu, Feb 6, 2025 at 11:48=E2=80=AFPM David Lechner <dlechner@bayli=
bre.com> wrote: =20
>=20
> ...
>=20
> > > > Maintainers, if you prefer to have this go through the gpio tree, p=
lease
> > > > give your Acked-by:, otherwise I will resend what is left after the=
 next
> > > > kernel release. =20
>=20
> > > I can provide an immutable branch for the entire series for everyone
> > > to pull or I can apply patch one, provide an immutable branch and
> > > every subsystem can take their respective patches. What do you prefer=
? =20
> >
> > The changes look small and trivial to me. I wouldn't mind if you take
> > them all (at least for mmc). An immutable branch would be good, if it
> > turns out that we need to pull them. =20
>=20
> +1 here, the potential user for immutable branch/tag is IIO.
> The rest looks trivial and unlikely to have conflicts.

Whilst I'm not sure if we'll need it, definitely good to have immutable
branch just in case.

There is another change to the ad7606 on list, but it's no where near
this code so shouldn't be a problem however this goes in.
My slight preference would be an immutable with a tag on patch 1.
I'll pull that and apply the IIO ones on top.

If you want to grab the lot though that should be fine as well.

Jonathan

>=20


