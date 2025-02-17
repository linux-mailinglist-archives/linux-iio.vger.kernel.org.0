Return-Path: <linux-iio+bounces-15655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C398A38438
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF690188276A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5137C21C19D;
	Mon, 17 Feb 2025 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLtC95GD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE89921B1B4;
	Mon, 17 Feb 2025 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797888; cv=none; b=GzxWQBlSRrEmjeztLKRvmDM1ZMgwsrNImyX97Yry5J09ztxwzb/JMX+6t6IRPnj68YXGtdWDzKv6oE+duCzceDucZF07FNBspDWVNPWIWpSt5wl6bS1o0v0Kdmqiz4NsbKwNmmUT1IUeZXzItL1qwHWBES1bXWGoMH6vSro10uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797888; c=relaxed/simple;
	bh=1PiBDGXviXFsoAeEznRpjkJuqVWjReFh5mfoR8+tPJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzyIOBOT0PbYJe+ILGoJ48YZHiqhF2QMfDa7B8OoWKk+hXxIUMx2sAqHQwUaopJj0pyq57ShR6dhce0MmOZs+s6JLuSTfO3opIe7IJtF8MtCjRrpD6IhB973Nd0av49jcaRFYM37E8yv4uRaJbD4SOP8ocglDOqroeWpRxFLgfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLtC95GD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40C3C4CED1;
	Mon, 17 Feb 2025 13:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739797887;
	bh=1PiBDGXviXFsoAeEznRpjkJuqVWjReFh5mfoR8+tPJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WLtC95GDNZ/X0s+hfQucYzO3kU+Rh5UgXxg+E6+ek+M4ridMVG6kAEleF01gndwVH
	 8kbjGK8bw3shQpq+zR5Sq5mTGyLenbNNTpk6vPcSBAERAm/YqIrevEy6deAw2gYd51
	 +6Z0P/gt6AH2RWzUjQCrhRXFdo7ErlgscBvdmNbqoywYjXZQybziAkfobxVGYS3OxT
	 5cOCBqcqHwvqlDolpX+gjqdLDpktZKKuSPwD6bYWh/ueX9jKkMRNJsJfc3krmttNSP
	 0x5gToctYLmU18WiDPJ6s/4/w8DzpdAuT9WEgRG5brTf7wwxDY2ymWUYBFwU8gqN7U
	 PmtYI/xK+DYfA==
Date: Mon, 17 Feb 2025 13:11:10 +0000
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
Message-ID: <20250217131110.5803b68b@jic23-huawei>
In-Reply-To: <CAMRc=Meq639NMz6TuOw=xQ_A8VDwA5OXoXU47JNt7x0C7jDtGQ@mail.gmail.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
	<173952845012.57797.11986673064009251713.b4-ty@linaro.org>
	<CAHp75VcjAFEdaDQAMXVMO96uxwz5byWZvybhq2fdL9ur4WP3rg@mail.gmail.com>
	<CAMRc=MefPRs-REL=OpuUFJe=MVbmeqqodp+wCxLCE8CQqdL4gQ@mail.gmail.com>
	<20250216142313.743af564@jic23-huawei>
	<CAMRc=Meq639NMz6TuOw=xQ_A8VDwA5OXoXU47JNt7x0C7jDtGQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 16 Feb 2025 16:55:04 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> On Sun, Feb 16, 2025 at 3:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Fri, 14 Feb 2025 15:37:48 +0100
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > =20
> > > On Fri, Feb 14, 2025 at 3:35=E2=80=AFPM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote: =20
> > > >
> > > > On Fri, Feb 14, 2025 at 12:21=E2=80=AFPM Bartosz Golaszewski <brgl@=
bgdev.pl> wrote: =20
> > > > > On Mon, 10 Feb 2025 16:33:26 -0600, David Lechner wrote: =20
> > > > > > This series was inspired by some minor annoyance I have experie=
nced a
> > > > > > few times in recent reviews. =20
> > > >
> > > > ...
> > > > =20
> > > > > [07/15] iio: adc: ad7606: use gpiod_multi_set_value_cansleep
> > > > >         commit: 8203bc81f025a3fb084357a3d8a6eb3053bc613a
> > > > > [08/15] iio: amplifiers: hmc425a: use gpiod_multi_set_value_cansl=
eep
> > > > >         commit: e18d359b0a132eb6619836d1bf701f5b3b53299b
> > > > > [09/15] iio: resolver: ad2s1210: use gpiod_multi_set_value_cansle=
ep
> > > > >         commit: 7920df29f0dd3aae3acd8a7115d5a25414eed68f
> > > > > [10/15] iio: resolver: ad2s1210: use bitmap_write
> > > > >         commit: a67e45055ea90048372066811da7c7fe2d91f9aa =20
> > > >
> > > > FWIW, Jonathan usually takes care of patch queue on weekends.
> > > > But whatever, it's not my business after all :-)
> > > > =20
> > >
> > > Too many conflicting suggestions. I just picked up all Acked patches.=
 =C2=AF\_(=E3=83=84)_/=C2=AF =20
> >
> > Resolution of any issues 'should' be easy enough. Let's keep an eye on =
how
> > it goes as other series hit Linux next.  Might be a little work to be d=
one there
> > and by Linus in next merge window.
> >
> > Jonathan
> > =20
>=20
> I'm totally fine with removing the iio commits from my queue if you
> prefer to take them.
>=20
Hi Bartosz,

That's probably going to prove slightly less painful, so please do.
I'll merge in that immutable tag and pick them up once you've dropped them.

Jonathan

> Bartosz


