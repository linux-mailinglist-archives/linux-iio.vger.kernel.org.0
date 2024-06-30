Return-Path: <linux-iio+bounces-7072-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A453B91D0E4
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 11:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477DF1F21544
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9AC12E1E9;
	Sun, 30 Jun 2024 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPdbSO91"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343852E419;
	Sun, 30 Jun 2024 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719740726; cv=none; b=cKTO4yXKMJXeEzbqBuXEUpGQ3nk/4ne94GpScGJP7tgwV+i8m1OdL36WZSfCUhPFpvDJQjdMpBgWR7YT08DYh8R8hF1otsmyQLaSwX1CBck+Ttd4rmet8MfA7vgWOtj221/9R+dHdGjzrARhTZgByq3lJU+iiXop+FHwEJA96vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719740726; c=relaxed/simple;
	bh=g+PY0maDJocsoPGrq31JuY5v06MgC/XeszNsjUSePKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgWbhsqDmGQteBBbPmxKV5uHy/nNxailSeevwYM19DnbI26R2e1ZowGKc+JvQ8Q3weGNyRbNpxHaEFeyjW0deb/qz25pJOTjMA7idOAZre+1qGsT8QetFA8XvvIM8lDTGGHjh/Fg/Lt54tmB8rt7HF4Xp7WKyufbZOLE1faof6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPdbSO91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DCBC2BD10;
	Sun, 30 Jun 2024 09:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719740725;
	bh=g+PY0maDJocsoPGrq31JuY5v06MgC/XeszNsjUSePKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jPdbSO91z7funRYpDY6X4e/ez7UtTStjCKtRta2i8kC9S+NloRtaXPyZZFe8Kb+Ee
	 /MKw+DN4Ju7RyapaLCCYa8+xVnza9HXHMXBQ0FOs8SkpnYHZ/85kHbHLdwU23uDauo
	 ueAfrWr4wcUgE73jHYnHya+FucnxG54UvFhesaFE3KRSX7KwannjQW9ehXnPokQ3Ku
	 wGWy2cmQfIwZvEg4fU67/oHh6ZM/OMVXARR8z6YlVorSafQH6jsuPAejP8VJ3MDSWh
	 On6obrGMgQE3yx15sC02GuTkTJPLybcIez+2RGu0GrFM1SCfG7F3vJg9VLhL5rmzx6
	 6a1vhKw2rh/Dw==
Date: Sun, 30 Jun 2024 10:45:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 3/6] iio: adc: ad7192: Update clock config
Message-ID: <20240630104516.59505c39@jic23-huawei>
In-Reply-To: <CA+GgBR9V=SqeA2fbeBDUO=Cr1s6GTbq6_779uQmiKCF2EjkHBg@mail.gmail.com>
References: <20240624124941.113010-1-alisa.roman@analog.com>
	<20240624124941.113010-4-alisa.roman@analog.com>
	<CA+GgBR9V=SqeA2fbeBDUO=Cr1s6GTbq6_779uQmiKCF2EjkHBg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Jun 2024 08:30:47 +0300
Alexandru Ardelean <aardelean@baylibre.com> wrote:

> On Mon, Jun 24, 2024 at 3:50=E2=80=AFPM Alisa-Dariana Roman
> <alisadariana@gmail.com> wrote:
> > =20
>=20
> Hello,
>=20
> A few comments inline.
>=20
> > There are actually 4 configuration modes of clock source for AD719X
> > devices. Either a crystal can be attached externally between MCLK1 and
> > MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> > pin. The other 2 modes make use of the 4.92MHz internal clock.
> >
> > Removed properties adi,int-clock-output-enable and adi,clock-xtal were
> > undocumented. Use cleaner alternative of configuring external clock by
> > using clock names mclk and xtal. =20
>=20
> Should we keep the old properties for backwards compatibility?
> While I like the new approach, the downside is that someone upgrades
> the kernel and may run into issues with their board, because one of
> these properties went away.
>=20
It's indeed a gamble that no one was actually using them.  Whilst
the lack of documentation suggests that might be the case, who knows.

If it isn't a bit maintenance issue to keep the old property support
in the driver it is probably a good idea (with lots of comments to
say it's deprecated).

> >
> > Removed functionality of AD7192_CLK_INT_CO restored in complementary
> > patch.
> >
> > Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> > ---
> >  drivers/iio/adc/ad7192.c | 56 ++++++++++++++++++++--------------------
> >  1 file changed, 28 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > index 334ab90991d4..940517df5429 100644
> > --- a/drivers/iio/adc/ad7192.c
> > +++ b/drivers/iio/adc/ad7192.c
> > @@ -396,25 +396,37 @@ static inline bool ad7192_valid_external_frequenc=
y(u32 freq)
> >                 freq <=3D AD7192_EXT_FREQ_MHZ_MAX);
> >  }
> >
> > -static int ad7192_clock_select(struct ad7192_state *st)
> > +static const char *const ad7192_clock_names[] =3D {
> > +       "xtal",
> > +       "mclk" =20
>=20
> Just a thought; no strong opinion.
> Maybe add a short comment about these being "clock_sel" values
> AD7192_CLK_EXT_MCLK1_2 & AD7192_CLK_EXT_MCLK2 ?
> This is mostly due to the "st->clock_sel =3D AD7192_CLK_EXT_MCLK1_2 +
> ret;" logic (which is fine)
> Before, this change, it would

Did we lose rest of sentence here?

J




