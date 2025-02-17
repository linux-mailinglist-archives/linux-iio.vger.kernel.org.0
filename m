Return-Path: <linux-iio+bounces-15705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E97A38659
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9F817433A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620FA22069A;
	Mon, 17 Feb 2025 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv7irP97"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CEA21D5B0;
	Mon, 17 Feb 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802286; cv=none; b=Am1QlfkAr7CNEWAdt61mohFyDpSBm7Prgq7TQE3Mn5P2w9yLDkLQirmGsZ8NEZEVnbi9uAUdyUqZ0IXh0K5dP+S6wWiqVqspQa1vDrRlI5LFYqe+oChm7S0jKRkgGPxC/p+HSY3eELJKVKOG0YxCGMt/pRVnRw6oxZVU9tkI1dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802286; c=relaxed/simple;
	bh=yd9PnR+BwLNDAH7iL0n5kuyPV1fByt9Z80i3v6lRtAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqIrJXAHKSkEfYTN1vVj9g/BFiM4NSMkf83IXSC0oOZueJj+DQQi3xhmfxsvs7Kx8DlgGn5N2JtspTtCZ6+awK2/VRETkNhtrXFtXyK0O0bKVbYuC0yMH/FM0K/+46BhbzlWrvmzTtsAkd5y2F0m79SDv75azYSJDSP+1kkKtbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yv7irP97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244A1C4CED1;
	Mon, 17 Feb 2025 14:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739802285;
	bh=yd9PnR+BwLNDAH7iL0n5kuyPV1fByt9Z80i3v6lRtAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yv7irP97jNj+AxDLGonPN8w1WPI1/tREGBuqeJ0N22uf45XRCZNLs9sxhkvMZO4ce
	 aKG2cLJ2CPOx4w7GBgoc8acUlSk1ojWPfOLQqfczJLVEnK0wM41qBQyC3y5PF4tszr
	 nv0pzXe4hkmRyixoRu/E7tiRLIr6VCcJFTLV/gqMUUy3a8UnfWiPUoVXmEhB0wLX2g
	 y5Pf9l4p2dHsUAKn072S7F4zfZRm/U37sR22zDxV9GfJOJjZpQFfGo+Jtg6KtcU38F
	 oeIxX0tvYdmmwIyWJ3NoNBtvy/ld3wZJia0q1Q6PPo01rvidRVMrTzezBZ11AOHsrP
	 QMtTjdfhiH/Cg==
Date: Mon, 17 Feb 2025 14:24:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan
 Hunter <jonathanh@nvidia.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Emil Gedenryd
 <emil.gedenryd@axis.com>, Arthur Becker <arthur.becker@sentec.com>, Mudit
 Sharma <muditsharma.info@gmail.com>, Per-Daniel Olsson
 <perdaniel.olsson@axis.com>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, Ivan Orlov <ivan.orlov0322@gmail.com>,
 David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: light: Add support for AL3000a illuminance
 sensor
Message-ID: <20250217142433.12183a17@jic23-huawei>
In-Reply-To: <CAPVz0n1529ydFRHn9N3jEsS8Rhdf-c4xECkMd9TDczzBTNuJzA@mail.gmail.com>
References: <20250215103159.106343-1-clamor95@gmail.com>
	<20250215103159.106343-3-clamor95@gmail.com>
	<20250216145445.1278b6ae@jic23-huawei>
	<CAPVz0n1529ydFRHn9N3jEsS8Rhdf-c4xECkMd9TDczzBTNuJzA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


Hi,

> > > +static int al3000a_read_raw(struct iio_dev *indio_dev,
> > > +                         struct iio_chan_spec const *chan, int *val,
> > > +                         int *val2, long mask)
> > > +{
> > > +     struct al3000a_data *data =3D iio_priv(indio_dev);
> > > +     int ret, gain;
> > > +
> > > +     switch (mask) {
> > > +     case IIO_CHAN_INFO_RAW:
> > > +             ret =3D regmap_read(data->regmap, AL3000A_REG_DATA, &ga=
in);
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +
> > > +             *val =3D lux_table[gain & AL3000A_GAIN_MASK]; =20
> >
> > I may have misinterpreted the other thread.  IS this value in lux?
> > If it is make this channel IIO_CHAN_INFO_PROCESSED instead.
> > =20
>=20
> This is actually a really good hint, I will check if this works out
> and if yes, then definitely will use it. Thank you.

=46rom your other reply it seems we have no idea of the correct scaling.
If that is the case, then channel type should be IIO_INTENSITY as
I assume we also have no idea if the light sensitivity curve is
matched to that required for illuminance (which approximates the
sensitivity of the human eye).  Various datasheets provide completely
garbage conversion formulas btw so even if we have data this can
be problematic. One recent sensor was using a green filter and
saying illuminance in lux was 1.2 * green which was assuming their
own definition of white light.

Jonathan


