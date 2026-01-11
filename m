Return-Path: <linux-iio+bounces-27613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF3AD0EF8A
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 14:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DD4830038DD
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B231014F70;
	Sun, 11 Jan 2026 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suHQRPmd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755DF450F2;
	Sun, 11 Jan 2026 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768137855; cv=none; b=QhqsMcAEn96865qFM/pewofkrKW7RJk9B6CGSTUEgq38ic94Q6280h6hrGMRgM6qyxS3KsB+muGSNMJmgV3VAgmzxlbtjseJmfOg6aRCHQ3wUKPz1LIA9N/kUM8A80TuAf0Nu99h4+wRpgTHmaTYU1XmDr1xQko8YCj0Hq7HPMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768137855; c=relaxed/simple;
	bh=ybys45kBaZeNfqk8/6xjCfL0R4x9ifQnVmVeylsi2is=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZSxfR0PNKYA+5Jo+/ntLWbZqgh20kKH831jQ20KwIdsWaeQ8VRIXH2cBNgdvbD3UyVanWT8Ufn/J+wF/BBc8JaKKnLHI7NQO/YrzEYzy+ISYMHDiQwqu3yNrP7RB5nSCVqE5mpv4VKdwA+nwQyEdlS+ZK6Z/yGVYOuEMcoJ/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suHQRPmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2540AC4CEF7;
	Sun, 11 Jan 2026 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768137855;
	bh=ybys45kBaZeNfqk8/6xjCfL0R4x9ifQnVmVeylsi2is=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=suHQRPmdP1oDkGfNLdYCEIe6ak7Q8jBeg2hzzvtnCMS93RxRv+M3WPtP0+UHKJhgT
	 H7KCghImAdo8tCxx8T9+nuz8tpkbz0TKVSoclT3DmhMyWqO0x+QVuKIZ3YUEviS8W7
	 Wa72yh9Kxy/uzAWcUhbLTjL1+to7JG+4F2EydTQTj8ziXdRTktgPHz/4I7O6QwMD5y
	 vJEkWL6W1PBaKa1pXtJTj/9PiBzVdY+xri/zh7M3VRu2+PGWpUywmDkuxgiaScmxwK
	 tUPKtBwylNyiAAhDztS26To+XpQUC+UQVLWPSFoZu1+rOzKXwZHjBau5m7kEY6W0p7
	 76Ts+X9wLVsQg==
Date: Sun, 11 Jan 2026 13:24:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Francesco Lavra <flavra@baylibre.com>, Ramona Gradinariu	
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: accel: adxl380: Add support for 1 kHz sampling
 frequency
Message-ID: <20260111132406.0d8f2707@jic23-huawei>
In-Reply-To: <5cd68e397bb45f606f59038290e4f3ac09d241da.camel@gmail.com>
References: <20260107123518.4017292-1-flavra@baylibre.com>
	<20260107123518.4017292-3-flavra@baylibre.com>
	<52e5cea72b99fc23c922cf74d7dce3403f43c9cd.camel@gmail.com>
	<9a5db937dc7072d95d6757cdf2eb8d6fde4abbd0.camel@baylibre.com>
	<5cd68e397bb45f606f59038290e4f3ac09d241da.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 08 Jan 2026 13:45:59 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2026-01-07 at 16:39 +0100, Francesco Lavra wrote:
> > On Wed, 2026-01-07 at 13:56 +0000, Nuno S=C3=A1 wrote: =20
> > > Hi Francesco,
> > >=20
> > > On Wed, 2026-01-07 at 13:35 +0100, Francesco Lavra wrote: =20
> > > > In sensor variants (such as ADXL380 and ADXL382) that support low-p=
ower
> > > > mode, the SAR signal path allows sampling acceleration data at lower
> > > > rates;
> > > > more specifically, when the sensor operates in VLP mode, the sampli=
ng
> > > > frequency is 1 kHz.
> > > > To add support for the 1kHz sampling frequency value, modify the
> > > > operating
> > > > mode selection logic to take into account the sampling frequency, a=
nd
> > > > configure the decimation filters only when applicable (i.e. when us=
ing
> > > > a
> > > > sampling frequency that relies on the DSM signal path).
> > > >=20
> > > > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> > > > ---
> > > > =C2=A0drivers/iio/accel/adxl380.c | 49 +++++++++++++++++++++++-----=
---------
> > > > =C2=A0drivers/iio/accel/adxl380.h | 10 +++++++-
> > > > =C2=A02 files changed, 40 insertions(+), 19 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl38=
0.c
> > > > index bbf1f88ca781..a6919dfce2e9 100644
> > > > --- a/drivers/iio/accel/adxl380.c
> > > > +++ b/drivers/iio/accel/adxl380.c
> > > > @@ -245,12 +245,14 @@ static int adxl380_set_measure_en(struct
> > > > adxl380_state *st, bool en)
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Activity/Inactivity detection available on=
ly in
> > > > VLP/ULP
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * mode and for devices that support low power mode=
s.
> > > > Otherwise
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * go straight to measure mode (same bits as
> > > > ADXL380_OP_MODE_HP).
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * mode and for devices that support low power mode=
s.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (st->chip_info->has_low_power &&
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (FIELD_GET(ADXL380_ACT_EN_=
MSK, act_inact_ctl) ||
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_GET(ADXL380_IN=
ACT_EN_MSK, act_inact_ctl)))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st-=
>odr =3D ADXL380_ODR_VLP;
> > > > + =20
> > >=20
> > > So before this change we would go to low power mode but still report
> > > whatever sampling frequency
> > > userspace had configured (which I guess would not correspond to reali=
ty)? =20
> >=20
> > Correct.
> >  =20
> > > With the above we'll
> > > update the reported odr right? =20
> >=20
> > Right.
> >  =20
> > > Some things/doubts that come to mind:
> > >=20
> > > 1. If I'm right not sure if this shouldn't be treated as a fix. =20
> >=20
> > Yes, this technically fixes an existing issue, but I didn't advertise i=
t as
> > a fix because solving the issue requires adding support for the 1kHz
> > frequency, which seems to go beyond the strict definition of a fix and
> > sounds more like a new feature.
> > =C2=A0 =20
> > > 2. Should we cache the current odr so that we restore it when
> > > appropriate? =20
> >=20
> > Do you mean caching it when activity detection is enabled and restoring=
 it
> > when detection is disabled? It could be done.
> >  =20
>=20
> Just and idea. I think it makes sense since enabling activity detection w=
ill change things
> under the hood and some users might not realize it. But it is not super i=
mportant I guess.

Given these sorts of complex interactions between userspace attributes in I=
IO
are common, we allow any ABI to change any other.  So I'd keep it simple and
not cache the previous value.   Enabling activity/inactivity switches to th=
e low
frequency and we stay there if it is disabled until userspace elects to spe=
ed
things up again.

>=20
> > > 3. Other thing that comes to mind is if it makes sense to allow
> > > controlling odr if
> > > Activity/Inactivity detection is enabled? =20
> >=20
> > Disallowing odr control when activity detection is enabled could be an
> > option, but what error code should be returned if the user tries to set=
 the
> > sampling frequency value when not allowed? -EBUSY? =20
>=20
> I think it makes sense given the constrains on activity events. EBUSY wou=
ld be my choice as well.
> Out of curiosity, do you know how the chip behaves if we change the odr w=
ith activity enabled? Is it
> just ignored?

Make sure than we report _available for the sampling_frequency and that upd=
ates to reflect
what is possible when activity detection enabled.  That then represents tha=
t we can't
change it in that mode, but can if we disable activity detection.

Jonathan

>=20
> - Nuno S=C3=A1
>=20
>=20


