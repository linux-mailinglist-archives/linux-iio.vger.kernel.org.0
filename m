Return-Path: <linux-iio+bounces-16589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A89FA585C4
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8C4188A553
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45EB1D6DD8;
	Sun,  9 Mar 2025 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYZtJk9Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9D11FB3;
	Sun,  9 Mar 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741536882; cv=none; b=nrGLhdJCBc+slSKNsu259LC8fXtLJBnGsfr1Jdq3pq7r2WKD/eEsDgyVgsJ66Ox5YAVxHHjmWdqk1JbZBQ9AlVBwOWZwAXRC0i9FfT4/Fb8CKou5PnpSS6Lh7EhVMar5vMbok1UFPSDYoGVjqp6EWQHvsssfJ1QXxB9AmAtMKCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741536882; c=relaxed/simple;
	bh=UCzjb6mT5pSogUqZ8t4e5xh7nPyH86VIyNu4uY7K0Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+4ThFtD6ZdQfJTLEz5h+bgDzQ+oBo6wtrol7Ve9bqK2XV4ckahSk3q/MeMFRFxgTbbW52KmmfOCi74R3rR080Gt5Nkciyv4dOqI7rD75I4WCAKREOpG64bAMZzwtk9MMlIwlbOyU7mLyhXUUpe3JCkm5DwdFW/xJLo2+F84/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYZtJk9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45678C4CEE5;
	Sun,  9 Mar 2025 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741536880;
	bh=UCzjb6mT5pSogUqZ8t4e5xh7nPyH86VIyNu4uY7K0Ms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qYZtJk9YnZ98LqUhoMjJugtEkQZcP3SDm7DiSFXtBumMo+VKwllFUpD8gYHevZVC3
	 PlXvgPp+cKGNeb75Ja4Bgj79WeYlWzI0ya5J+IynCi7YsEnzvKXOxe00aQL9gwGtGQ
	 9wSU/Wk7fNZcKGf6wvvne8CiZ2fn9zBewEJgpfTbH8gJk46Ei2v8RdocVZ/m6e2Pkf
	 Nowd3x0ww/lDLrUMT3JKu+tREDeWUwRfJvqqD1KQTsA37kG+KtaeQYoYt8WhwrAw59
	 pxJ4mDgaLN0WOHXdRsTFvlyMiDj2yven5zGlvwbZeKUe4CpQ7z4XYPFevanGhZ/Hwz
	 zBzF+5Yns/nhw==
Date: Sun, 9 Mar 2025 16:14:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 cosmin.tanislav@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iio: accel: adxl367: fix setting odr for
 activity time update
Message-ID: <20250309161432.36af9272@jic23-huawei>
In-Reply-To: <CAFXKEHZEkNXAPVxZA5raPsA8cNt3A+tbd83kNzJc3wY5OjAsdw@mail.gmail.com>
References: <20250221203352.41941-1-l.rubusch@gmail.com>
	<20250222150329.66d6e79b@jic23-huawei>
	<CAFXKEHZEkNXAPVxZA5raPsA8cNt3A+tbd83kNzJc3wY5OjAsdw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 8 Mar 2025 22:26:36 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sat, Feb 22, 2025 at 4:03=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Fri, 21 Feb 2025 20:33:52 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Fix setting the odr value to update activity time based on frequency
> > > derrived by recent odr, and not by obsolete odr value.
> > >
> > > The [small] bug: When _adxl367_set_odr() is called with a new odr val=
ue,
> > > it first writes the new odr value to the hardware register
> > > ADXL367_REG_FILTER_CTL.
> > > Second, it calls _adxl367_set_act_time_ms(), which calls
> > > adxl367_time_ms_to_samples(). Here st->odr still holds the old odr va=
lue.
> > > This st->odr member is used to derrive a frequency value, which is
> > > applied to update ADXL367_REG_TIME_ACT. Hence, the idea is to update
> > > activity time, based on possibilities and power consumption by the
> > > current ODR rate.
> > > Finally, when the function calls return, again in _adxl367_set_odr() =
the
> > > new ODR is assigned to st->odr.
> > >
> > > The fix: When setting a new ODR value is set to ADXL367_REG_FILTER_CT=
L,
> > > also ADXL367_REG_TIME_ACT should probably be updated with a frequency
> > > based on the recent ODR value and not the old one. Changing the locat=
ion
> > > of the assignment to st->odr fixes this.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > Fixes tag?
> > =20
>=20
> Hi IIO ML readers - Hi Jonathan,
> AFAIK there is no tracked bug which I could refer to. Alternatively, I
> could refer to
> the commit hash of the original commit which introduced the code this
> patch is supposed
> to fix. Is this ok? Could you please help me here with the process?

Follow description in the submitting-patches documentation.

https://elixir.bootlin.com/linux/v6.14-rc5/source/Documentation/process/sub=
mitting-patches.rst

Here the commit hash + description is what I am after in the appropriate
format as described in that doc.

I don't really care about patch trackers as most bug fixes are never in
them as they come from people noticing issues whilst reading or testing
the code during other development.

Jonathan

>=20
> > Otherwise looks good to me.
> > =20
> > > ---
> > >  drivers/iio/accel/adxl367.c | 10 +++-------
> > >  1 file changed, 3 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> > > index add4053e7a02..0c04b2bb7efb 100644
> > > --- a/drivers/iio/accel/adxl367.c
> > > +++ b/drivers/iio/accel/adxl367.c
> > > @@ -601,18 +601,14 @@ static int _adxl367_set_odr(struct adxl367_stat=
e *st, enum adxl367_odr odr)
> > >       if (ret)
> > >               return ret;
> > >
> > > +     st->odr =3D odr;
> > > +
> > >       /* Activity timers depend on ODR */
> > >       ret =3D _adxl367_set_act_time_ms(st, st->act_time_ms);
> > >       if (ret)
> > >               return ret;
> > >
> > > -     ret =3D _adxl367_set_inact_time_ms(st, st->inact_time_ms);
> > > -     if (ret)
> > > -             return ret;
> > > -
> > > -     st->odr =3D odr;
> > > -
> > > -     return 0;
> > > +     return _adxl367_set_inact_time_ms(st, st->inact_time_ms);
> > >  }
> > >
> > >  static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_o=
dr odr) =20
> > =20


