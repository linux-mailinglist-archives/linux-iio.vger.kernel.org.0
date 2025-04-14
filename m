Return-Path: <linux-iio+bounces-18099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB721A88B0A
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19430177616
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5894128BA94;
	Mon, 14 Apr 2025 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snjgvQkD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1398928BA88;
	Mon, 14 Apr 2025 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655328; cv=none; b=dtjJ2s8/6orySdw5noH4Zy9n+QpzSmEP70Nk+aB6IiLjq51IgRfTaF7F7XFByPy5ydoiVKLSkLkE4lEGLsmw1lqUsV9bYshbLbr56whqaw0f7uyZQpJsfvWzvwAfT6veWPTkQhuhqOW7Tci7+Mp8SzbI4oZ+09boTtxbDp+6yvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655328; c=relaxed/simple;
	bh=mC2BUTSr6K9M5H82HVF6sdpNUZeudf8LZ6dRlOe1ETU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nh6n6S1MbeShy2Isj2FPVX7JBGDjmveEvc37u8WKD/fI/c2jI1qgCSM+SaRyvx67+xviLTRf9QNXFIBW3tJ/mdpwU8yrFKE2f2eKs/t5McP4ycG8oukxHmJTvPG06oVDUjI6OjXiOvP/GzLoAqOXlxcvgwnK2HgTuhSjHduMIDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snjgvQkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A49C4CEEB;
	Mon, 14 Apr 2025 18:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744655327;
	bh=mC2BUTSr6K9M5H82HVF6sdpNUZeudf8LZ6dRlOe1ETU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=snjgvQkDsJMRcE9FlwHD039ZUU5KS88+JIYIteGHLIQzeBob2MOYKJ3GZV1frW9iA
	 TVIMAoyDG2oHoopr1HuAwHNM1i1vkNLmg1wfOTycr/ZmY9F4Bl1x/QsCHUcUe39EkD
	 af42AHdfjd3aAFI4oMcDMz4O6bgk7OkwmiG3hvUhWvE73ajIMEpcYCxtx9oBxf38yP
	 1MwN7v8I7SfelIU7gaSvB7eZTpc3Q5e7mP98P8ysMaS5aB8XGJtWkN7EB1RR3gAR2W
	 G/ufAIf99GJloCj8f3fTlr1ab4Z3YYtp2Rr6EsKJ5wxm9Ctkw2pPDIkbzlCW6BseIR
	 1EHMd6kvi2sxA==
Date: Mon, 14 Apr 2025 19:28:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 05/11] iio: accel: adxl345: add freefall feature
Message-ID: <20250414192840.0147bb97@jic23-huawei>
In-Reply-To: <CAFXKEHZ6pozMTw_8hT9i7rp_OtPZMaFXEisW925oYgFFJeXv=Q@mail.gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
	<20250318230843.76068-6-l.rubusch@gmail.com>
	<20250331112839.78c2bc71@jic23-huawei>
	<CAFXKEHZ6pozMTw_8hT9i7rp_OtPZMaFXEisW925oYgFFJeXv=Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Apr 2025 16:30:35 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Mon, Mar 31, 2025 at 12:28=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Tue, 18 Mar 2025 23:08:37 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add the freefall detection of the sensor together with a threshold and
> > > time parameter. A freefall event is detected if the measuring signal
> > > falls below the threshold.
> > >
> > > Introduce a freefall threshold stored in regmap cache, and a freefall
> > > time, having the scaled time value stored as a member variable in the
> > > state instance.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > Hi Lothar,
> >
> > Apologies for the slow review!  Just catching up after travel
> > and I did it reverse order.
> > =20
> > > +
> > > +static int adxl345_set_ff_en(struct adxl345_state *st, bool cmd_en)
> > > +{
> > > +     unsigned int regval, ff_threshold;
> > > +     const unsigned int freefall_mask =3D 0x02; =20
> >
> > Where did this mask come from?   Feels like it should be a define
> > (just use ADXL345_INT_FREE_FALL probably)
> > or if not that at lest use BIT(1) to make it clear it's a bit rather
> > than the number 2.
> > =20
> > > +     bool en;
> > > +     int ret;
> > > +
> > > +     ret =3D regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &ff_thre=
shold);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     en =3D cmd_en && ff_threshold > 0 && st->ff_time_ms > 0;
> > > +
> > > +     regval =3D en ? ADXL345_INT_FREE_FALL : 0x00;
> > > +
> > > +     return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> > > +                               freefall_mask, regval);
> > > +} =20
> > =20
>=20
> This raises for me a bit of a general question. I face this situation
> quite often when using FIELD_GET() or, like here,
> regmap_update_bits(). In general, when I need to apply a mask on a
> value to be set or unset.
>=20
> A fixed version of the above could be this:
>  421         regval =3D en ? ADXL345_INT_FREE_FALL : 0x00;
>  422
>  423         return regmap_update_bits(st->regmap,
> ADXL345_REG_INT_ENABLE,
>  424                                   ADXL345_INT_FREE_FALL, regval);
>=20
> Actually, (suppose we have uint8_t, and mask only masks a single bit),
> I tend more and more to prefer 0xff over the particular bit, so...
> 421         regval =3D en ? 0xff : 0x00;
>=20
> ...and then apply the mask on it. Is there any opinion on using 0xff
> or rather using the exact bit? Or, do you, Jonathan, care more about
> one or the other?

The actual bit(s) would be my preference.  Whilst I agree it would in theory
be fine to use 0xff that would require me going to check the register
width.  Using ~0 might always work but that is just weird to look at.

Jonathan


>=20
> Best,
> L


