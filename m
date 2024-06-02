Return-Path: <linux-iio+bounces-5611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739928D7541
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 14:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBC8281D49
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB8C39FD0;
	Sun,  2 Jun 2024 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOee0fy0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128622D058;
	Sun,  2 Jun 2024 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717330460; cv=none; b=pFuLle4ohj8lY5Ht9da1uj9yXQDR05W0J5G2wUKeX4kSTHuBTK6N8odJ1pST/k3WXrHle6/xm4l7fid4L1hkAs+6ol+hecdwubgMfJlMl5zkOVSsNbicDA0tAHSC7BAk3YTJuLamm+/5nJXjKksiAbm8l8Urahu74LhjPF6JJA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717330460; c=relaxed/simple;
	bh=miEiGWm2+ntCH5f5SoeSTAVniwWnl4HtGbPoJcC3D88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qz0yfzNKALeVJRzuWRYxk3zOE/VvFCHvzgyR94XKVPQAMqVjiD8eHTiG4AgAV1sspKBnYSeYUmZJLVu0ThB1MXzBTA8VGnd/UVIbWJm2tKW5lCDYuwlv0dDZgM17ahmwih+bWRh3NyF9Rea+AhO0DSot4soqeADwRiClSqup+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOee0fy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C38C2BBFC;
	Sun,  2 Jun 2024 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717330459;
	bh=miEiGWm2+ntCH5f5SoeSTAVniwWnl4HtGbPoJcC3D88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WOee0fy09cu48BimDTNZOiDduOJ8jitnp3G9/SV+NaPfmx0xNLs0jNxoeCruaEplX
	 JMCYHzxI0UdQZAkrWyKa0sZ2LexUt5hGoNWxcMDge8t77/EfStjr+B24a7eQ7ZUc9c
	 0x2kvkVGHMc6GM/rNlSSnMhoMNwVvzBD0kZfVpKLm89bBZeUuTCsai5O6bH5JRA8Dw
	 +PxeXfZiT2+fo8WXJP4Y5taNmfL7qj7zShl1Wa+l/hs7lZpG78pvF+NbPEcjoul5zZ
	 4cXze6QbWK5Na+qZzYUOxZLePgyRdkm6MlaaROjD9lVSfkcYdw5ODYJpSCgOsjcbfA
	 ntVUJt0VEqmmQ==
Date: Sun, 2 Jun 2024 13:14:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>, Anshul
 Dalal <anshulusr@gmail.com>, Andrea Collamati <andrea.collamati@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad9739a: drop COMPILE_TEST option
Message-ID: <20240602131408.08fb15d8@jic23-huawei>
In-Reply-To: <73d7ba0e54a93696aa2c8cab3e6599038bddf533.camel@gmail.com>
References: <20240528121304.3695252-1-arnd@kernel.org>
	<539a815398a3c991c1bc1a53967fbcba282dfe3b.camel@gmail.com>
	<81ec1d1a-d8de-47e4-a5d4-eeaaf1e806a2@app.fastmail.com>
	<73d7ba0e54a93696aa2c8cab3e6599038bddf533.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 May 2024 10:09:28 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2024-05-29 at 09:23 +0200, Arnd Bergmann wrote:
> > On Wed, May 29, 2024, at 09:20, Nuno S=C3=A1 wrote: =20
> > > On Tue, 2024-05-28 at 14:12 +0200, Arnd Bergmann wrote: =20
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >=20
> > > > Build testing without SPI results in a warning:
> > > >=20
> > > > WARNING: unmet direct dependencies detected for REGMAP_SPI
> > > > =C2=A0 Depends on [n]: SPI [=3Dn]
> > > > =C2=A0 Selected by [m]:
> > > > =C2=A0 - AD9739A [=3Dm] && IIO [=3Dm] && (SPI [=3Dn] || COMPILE_TES=
T [=3Dy])
> > > >=20
> > > > There is no need for this particular COMPILE_TEST option, as allmod=
config
> > > > and randconfig testing can just assume that SPI is enabled separate=
ly.
> > > >=20
> > > > Drop it to avoid the warning.
> > > >=20
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > --- =20
> > >=20
> > > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > Only for my understanding. When does COMPILE_TEST makes sense to add?=
 =20
> >=20
> > The most common use is to enable building a driver
> > that is platform specific on x86 allmodconfig
> > or on randconfig, e.g.
> >=20
> > config LPC18XX_DAC
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "NXP LPC18xx DAC dr=
iver"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ARCH_LPC18XX || C=
OMPILE_TEST
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on HAS_IOMEM
> >=20
> > Since ARCH_LPC18XX is only visible on arch/arm, the
> > driver would never be build tested on anything else
> > without the ||COMPILE_TEST. =20
>=20
> Makes sense... Thanks!
>=20
> - Nuno S=C3=A1
>=20

Applied. Thanks

