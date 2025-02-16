Return-Path: <linux-iio+bounces-15558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB25A374B0
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 15:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C76D3A4DA7
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 14:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAAA195B1A;
	Sun, 16 Feb 2025 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLFeQF/y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159872E64A;
	Sun, 16 Feb 2025 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739715808; cv=none; b=Ft6U3LRdKCRmoqaRF6l5Yzz0zEf+R9I78CAayXbnoz+k45DNVqm4pjc5p/Oeli2QeGTtpvEoIR6M3XGpirHAm+76Ep7qZ4e859jTL2KYejQtYRDgTBY+BWCV3oBAkRC4HVxxNh/BDJFgA5dD2cK6v7mckJIXOzGM8/9FzK1w1pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739715808; c=relaxed/simple;
	bh=CHx2ST4zktCV02lmLrwqE/s3ts+t8MfWDPW0ZGK9ATc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRk3Tdhvi9dpfHHTmVGutLUU3b9Kujj6PnV6rgcRwdjniln7PQQMQxwBlITzz1GV3y64QjEY0w+ahdr3LHLr1rajQL3FABDVnnV1Q/iqlwyxa7JtEWFv2tMex8AOR1V7wJm4bH7boFo6QLQ80L4rEO1ApnIHIgL/7pJ6tHfAENU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLFeQF/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340B2C4CEDD;
	Sun, 16 Feb 2025 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739715807;
	bh=CHx2ST4zktCV02lmLrwqE/s3ts+t8MfWDPW0ZGK9ATc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nLFeQF/y42wVWIR3fGqepgiiyhB1EMEB9TJ3SxTEdt2lKEf0g4hRNmC7jJ+NbpAOR
	 FbMTsQsbvPG0N5aYlW699M3UJR8kOZElpZ05ZhxdLoNuqk5WQHFqIV/BOKjWqhu95I
	 dVeYlaYtBZdi3TGnVNeIAqiSv6gHo/fwe2q80M5SxfwzQhapn+/E534ECVjw68f4Cx
	 3Y7i7V1iYpLbT9Wj2lta8S9X3+9CVDnTMRy0TEzfct3l5Hgzlkcz0UgKcmIYqiwoeo
	 Vn1UOBHP/I2zQV0z1jKxy/e5fBQg8ZsYsMj7VRz99WJUKJ+yOympCuVgQLJL9PAkos
	 +KMSCyNkdXjnQ==
Date: Sun, 16 Feb 2025 14:23:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Linus Walleij
 <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, David
 Lechner <dlechner@baylibre.com>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-sound@vger.kernel.org, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: (subset) [PATCH v3 00/15] gpiolib: add
 gpiod_multi_set_value_cansleep
Message-ID: <20250216142313.743af564@jic23-huawei>
In-Reply-To: <CAMRc=MefPRs-REL=OpuUFJe=MVbmeqqodp+wCxLCE8CQqdL4gQ@mail.gmail.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
	<173952845012.57797.11986673064009251713.b4-ty@linaro.org>
	<CAHp75VcjAFEdaDQAMXVMO96uxwz5byWZvybhq2fdL9ur4WP3rg@mail.gmail.com>
	<CAMRc=MefPRs-REL=OpuUFJe=MVbmeqqodp+wCxLCE8CQqdL4gQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Feb 2025 15:37:48 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> On Fri, Feb 14, 2025 at 3:35=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Fri, Feb 14, 2025 at 12:21=E2=80=AFPM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote: =20
> > > On Mon, 10 Feb 2025 16:33:26 -0600, David Lechner wrote: =20
> > > > This series was inspired by some minor annoyance I have experienced=
 a
> > > > few times in recent reviews. =20
> >
> > ...
> > =20
> > > [07/15] iio: adc: ad7606: use gpiod_multi_set_value_cansleep
> > >         commit: 8203bc81f025a3fb084357a3d8a6eb3053bc613a
> > > [08/15] iio: amplifiers: hmc425a: use gpiod_multi_set_value_cansleep
> > >         commit: e18d359b0a132eb6619836d1bf701f5b3b53299b
> > > [09/15] iio: resolver: ad2s1210: use gpiod_multi_set_value_cansleep
> > >         commit: 7920df29f0dd3aae3acd8a7115d5a25414eed68f
> > > [10/15] iio: resolver: ad2s1210: use bitmap_write
> > >         commit: a67e45055ea90048372066811da7c7fe2d91f9aa =20
> >
> > FWIW, Jonathan usually takes care of patch queue on weekends.
> > But whatever, it's not my business after all :-)
> > =20
>=20
> Too many conflicting suggestions. I just picked up all Acked patches. =C2=
=AF\_(=E3=83=84)_/=C2=AF

Resolution of any issues 'should' be easy enough. Let's keep an eye on how
it goes as other series hit Linux next.  Might be a little work to be done =
there
and by Linus in next merge window.

Jonathan

>=20
> Bart


