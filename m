Return-Path: <linux-iio+bounces-18100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E616BA88B19
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F551899C60
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860C028BA93;
	Mon, 14 Apr 2025 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f85bucBm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400FF289374;
	Mon, 14 Apr 2025 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655417; cv=none; b=eLtN40DrP3+6x1lpxmxIJ6FoDPS/sCYtX4iKjYhceZYNTZDjuINJtVf0nhy25xq8HOPZj56LBKnZQ0pI1zlHEuv7yhwazNXIKdVj1BMy8JpTMvyH59MSNRLvvXVNJkhbEX5aVj7qAL7V8tr/cnD04mY6t8MJ2nHxvrReP1YOd5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655417; c=relaxed/simple;
	bh=BtcwZGRvn5TesENoDrfjjj8HyL7mLHa6Ze3jrfXvGEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdmipwymVHphUUg5tFy+U+y3I2NbgWUNKba8C7V17fHN4kAkM5vdUA2NKoRQC6we7TSLPywxe0Zo7d6gKqt/2QCTMoKYAj43baO30UOHux9vG8HqSgNLpzTOkTU7GnsBZOtI/gYKNSN/mRcUYEALtbBn1gxUiLe/c684q18wWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f85bucBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706B9C4CEE2;
	Mon, 14 Apr 2025 18:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744655416;
	bh=BtcwZGRvn5TesENoDrfjjj8HyL7mLHa6Ze3jrfXvGEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f85bucBmfd43blwejOgTiqV2C9OWkdfcVHiTrbzYmvV2XqwNIgUK9u+tGs5xOdpDR
	 ueoH4ADTmzHAOimKyQPO7Q+3msaeRxjgbqg3ChtKPiFsIu4dY068I+LXuzCoEN3K7V
	 ViIVtbfOcoSezM6+xU7547ln4NYvl3ZLXuoSuNkqJZZaK6dTZ34Y4BonCrHUTvb7kA
	 //GRZ1Td00Ndc/2c0qB2s/G+Ss/R4W6EI4KoCoIbKAXZl4bPLEWHY00AkFZooRUguq
	 D6NTw8POTU/wu10HjOoUu9jhPv3JkXjrXYTaqr+j+Je1018Kowda/jAEEKhxhgiMYy
	 G/8m1/IuPvhGg==
Date: Mon, 14 Apr 2025 19:30:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 06/11] iio: accel: adxl345: extend sample frequency
 adjustments
Message-ID: <20250414193010.0ff1ea59@jic23-huawei>
In-Reply-To: <CAFXKEHau6n2o_MPimiEkYRNvE3TO9f5j_tDH0FwJYsk6V5B9WA@mail.gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
	<20250318230843.76068-7-l.rubusch@gmail.com>
	<20250331113300.08379a5a@jic23-huawei>
	<CAFXKEHau6n2o_MPimiEkYRNvE3TO9f5j_tDH0FwJYsk6V5B9WA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Apr 2025 13:41:20 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Mon, Mar 31, 2025 at 12:33=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Tue, 18 Mar 2025 23:08:38 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Introduce enums and functions to work with the sample frequency
> > > adjustments. Let the sample frequency adjust via IIO and configure
> > > a reasonable default.
> > >
> > > Replace the old static sample frequency handling. During adjustment of
> > > bw registers, measuring is disabled and afterwards enabled again.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > One minor thing inline.
> >
> > =20
> > >       return -EINVAL;
> > > @@ -504,7 +581,12 @@ static int adxl345_write_raw(struct iio_dev *ind=
io_dev,
> > >                            int val, int val2, long mask)
> > >  {
> > >       struct adxl345_state *st =3D iio_priv(indio_dev);
> > > -     s64 n;
> > > +     enum adxl345_odr odr;
> > > +     int ret;
> > > +
> > > +     ret =3D adxl345_set_measure_en(st, false); =20
> >
> > Why is this necessary but wasn't before?
> > If it should always have been done for existing calibbias etc,
> > perhaps a separate precursor patch is appropriate?
> > =20
>=20
> On the one side the datasheet recommends to have measurement disabled,
> when adjusting certain sensor registers, mostly related to interrupt
> events. Before the sensor was operated in FIFO_BYPASS mode only
> without using the sensor events. With interrupt based events, it will
> operate in FIFO_STREAM or similar. Then it seems to me to be a better
> approach to put it generally in standby mode when configuring
> registers to avoid ending up e.g. in FIFO overrun or the like. On the
> other side, I saw similar approaches in the sources of Analog sensors.
> Enable/disable measurement was done there in the particular functions.
> In the particular case of adxl345_write_raw, odr and range values are
> going to be set and I implement enable/disable measurement directly in
> the write_raw. In comparison to the ADXL380 (different sensor!) where
> this is done, too, but down in the specific setter functions. I can
> see a bit of an advantage, if something fails, the sensor generally
> stays turned off. I'll keep this in v6 of the patches.

Thanks for the explanation.  That answered my question nicely and
this is fine.

>=20
> Pls,  note, I did not observe faulty behavior due to that or analyzed
> it thoroughly if and where it is probably better to have measurement
> turned off. At best, it won't make any difference and is probably
> rather kind of "best practice". If not, I would expect rather sporadic
> minor issues.
>=20
> As always, pls consider my patch(es) as a proposal, sometimes with an
> invisible question mark ;) If you have a contrary opinion and/or
> experience, please let me know.
>=20
> > =20
> > > +     if (ret)
> > > +             return ret;
> > >
> > >       switch (mask) {
> > >       case IIO_CHAN_INFO_CALIBBIAS:
> > > @@ -512,20 +594,26 @@ static int adxl345_write_raw(struct iio_dev *in=
dio_dev,
> > >                * 8-bit resolution at +/- 2g, that is 4x accel data sc=
ale
> > >                * factor
> > >                */
> > > -             return regmap_write(st->regmap,
> > > -                                 ADXL345_REG_OFS_AXIS(chan->address),
> > > -                                 val / 4);
> > > +             ret =3D regmap_write(st->regmap,
> > > +                                ADXL345_REG_OFS_AXIS(chan->address),
> > > +                                val / 4);
> > > +             if (ret)
> > > +                     return ret;
> > > +             break;
> > >       case IIO_CHAN_INFO_SAMP_FREQ:
> > > -             n =3D div_s64(val * NANOHZ_PER_HZ + val2,
> > > -                         ADXL345_BASE_RATE_NANO_HZ);
> > > +             ret =3D adxl345_find_odr(st, val, val2, &odr);
> > > +             if (ret)
> > > +                     return ret;
> > >
> > > -             return regmap_update_bits(st->regmap, ADXL345_REG_BW_RA=
TE,
> > > -                                       ADXL345_BW_RATE,
> > > -                                       clamp_val(ilog2(n), 0,
> > > -                                                 ADXL345_BW_RATE));
> > > +             ret =3D adxl345_set_odr(st, odr);
> > > +             if (ret)
> > > +                     return ret;
> > > +             break;
> > > +     default:
> > > +             return -EINVAL;
> > >       }
> > >
> > > -     return -EINVAL;
> > > +     return adxl345_set_measure_en(st, true);
> > >  } =20


