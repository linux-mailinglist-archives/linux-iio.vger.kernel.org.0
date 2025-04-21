Return-Path: <linux-iio+bounces-18453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363E4A95219
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9047A7AA9
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99024266B4B;
	Mon, 21 Apr 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvDVule4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2F3265CCF;
	Mon, 21 Apr 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243775; cv=none; b=ZWSzAWU0APAVFLjIN9ppTutdjNLd3si6bNUeNqkvLarlNgJp8fz5pZc5S2Li3qCigyujwRCAhUKfg6K4ZudBYqH+cNSlM94Yqe00sV6UDW9uSA5CTvbWYuvjNSFG4CTrBNbk8Z9GBHR01QgF00KDxcySmLoyL4GggXXuW5k+hUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243775; c=relaxed/simple;
	bh=hSaG2QXlza+5IUydYkepExN1nBF7f8yUE9GylDBCfXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZL80XFmMF6YWFxZZphcsHUfnjkJU+R9Pwu6V/6LLuW3d4aw7LUGqoXy8NLnxEhUZQR3UtxCYZBzqyrQHsSg0Pfzy5SYfCHGoLV1pPLgpezl4NYA4QYnI2gO2TC//YLZKMNjbAx8W/8Zt6s1r5uWnUHIFK04NJyXxAqrX7MGI8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvDVule4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8466AC4CEE4;
	Mon, 21 Apr 2025 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745243774;
	bh=hSaG2QXlza+5IUydYkepExN1nBF7f8yUE9GylDBCfXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MvDVule4QeVJnhhDlI3q/7WaQt4zDaIlcd9IdtOXJpOzqhANKct46715DQyoSywpd
	 m0+Bj2MVXim2yl+s77xyulhumta93UV9WSO+Z/FXB6HthVD1Jn5oxYhEnN1KD2JVIL
	 x659Jm0j49l3AuoD7CwZookPBQ1h3cvNxWLw/F32B968Vv/6p/2Z1da1Ru6Ydp4KGE
	 hIAw/1MrpdUjWHCN6HElE65KKGxYWYRFPvI1/q8nFkk4chY6vI8CuGl0BqZAdz6UbE
	 +iqAOkrcslFVGKETiUO3wSBsP8jfoBlp1mTC4gptI+h0PznqpeKtIPh3oKTJaYU/lt
	 86HsyX5ijlZrg==
Date: Mon, 21 Apr 2025 14:56:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Antoniu Miclaus	 <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] iio: amplifiers: ada4250: use DMA-safe memory for
 regmap_bulk_read()
Message-ID: <20250421145606.7620bf25@jic23-huawei>
In-Reply-To: <3875da4e070f991484b8536f6066347615b0815a.camel@gmail.com>
References: <20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v1-1-7e7bd6dad423@baylibre.com>
	<CAHp75Vdxdbqu6qkbuo5y4jADOH_h9Re6m8icSj3Je4hnVsha0g@mail.gmail.com>
	<ed5c4b46-0b3f-4278-ba8e-6f6977f18429@baylibre.com>
	<aAO7Lw13xrEGmZLL@smile.fi.intel.com>
	<9cdc7053-ae22-4ad5-801c-46df7398ebf9@baylibre.com>
	<20250421115758.62c16f94@jic23-huawei>
	<3875da4e070f991484b8536f6066347615b0815a.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Apr 2025 14:00:30 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2025-04-21 at 11:57 +0100, Jonathan Cameron wrote:
> > On Sat, 19 Apr 2025 13:07:25 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >  =20
> > > On 4/19/25 10:03 AM, Andy Shevchenko wrote: =20
> > > > On Fri, Apr 18, 2025 at 02:09:04PM -0500, David Lechner wrote:=C2=
=A0  =20
> > > > > On 4/18/25 1:58 PM, Andy Shevchenko wrote:=C2=A0  =20
> > > > > > =D0=BF=CA=BC=D1=8F=D1=82=D0=BD=D0=B8=D1=86=D1=8F, 18 =D0=BA=D0=
=B2=D1=96=D1=82=D0=BD=D1=8F 2025=E2=80=AF=D1=80. David Lechner
> > > > > > <dlechner@baylibre.com=C2=A0<mailto:dlechner@baylibre.com>> =D0=
=BF=D0=B8=D1=88=D0=B5:
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0 Use DMA-safe memory instead of stack-allocat=
ed memory for the call
> > > > > > to
> > > > > > =C2=A0=C2=A0=C2=A0 regmap_bulk_read() in the ada4250_init() fun=
ction as this could be
> > > > > > used
> > > > > > =C2=A0=C2=A0=C2=A0 directly by a SPI controller.
> > > > > >=20
> > > > > > Sorry, but can you elaborate more on this? If driver doesn=E2=
=80=99t override
> > > > > > the
> > > > > > callbacks the regmap SPI uses spi_write_then_read() which is su=
pposed
> > > > > > to be
> > > > > > dma safe.=C2=A0=C2=A0  =20
> > > > >=20
> > > > > Ah, I didn't dig that far down. Will send a new patch that just c=
leans
> > > > > up the
> > > > > unnecessary alignment and unaligned call.=C2=A0  =20
> > > >=20
> > > > But do you have a real life issue with that? Coincidentally we disc=
ussed
> > > > similar case in another driver with colleague of mine, and he insis=
ts that
> > > > it
> > > > might be still broken (somewhere).
> > > > =C2=A0  =20
> > >=20
> > > Some drivers that use regmap with SPI implement their own read and wr=
ite
> > > callbacks if the default one doesn't work, so maybe something like th=
at?
> > >  =20
> >=20
> > I asked Mark about this long ago. Maybe the guidance has changed, but t=
he
> > request
> > if my memory is correct was to treat bulk regmap accesses with the same=
 care
> > wrt to
> > DMA safety that we treat direct use of the underlying bus accessors.
> > (unfortunately I have no idea what thread this was in!)
> >=20
> > The reasoning I think was that it was an implementation detail whether
> > regmap copied the data or not for bulk accesses.=C2=A0 Back then I chas=
ed through
> > the SPI case and couldn't find a path that didn't bounce the data (thou=
gh some
> > paths could have been made zero copy).
> >  =20
>=20
> Looking on the implementation, indeed it looks like that everything shoul=
d be
> fine... However, IMO, David's reasoning about potential drivers using the=
ir own
> regmap_bus (or just overriding read and write) is perhaps justification e=
nough
> for doing it.

That's in a specific driver which is the same one allocating the buffer.
Doing it defensively in other drivers is probably a step too far if we don't
still want to do it everwhere regmap and SPI are combined.

Jonathan


>=20
> - Nuno S=C3=A1=20
>=20
> > Anyhow, +CC Mark as maybe I remembered that wrong or his view has
> > changed!
> >=20
> > Jonathan =20


