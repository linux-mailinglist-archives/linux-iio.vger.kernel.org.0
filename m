Return-Path: <linux-iio+bounces-20817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA9FAE2A67
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 18:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEA73B8EA2
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 16:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8DB221F1C;
	Sat, 21 Jun 2025 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQ02WcIw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A4B221DB5;
	Sat, 21 Jun 2025 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750524949; cv=none; b=YlVsRZH7mZ+k8AYsLuRf6B3kZyRCAaswkywjc2Eh4JSbcpk9kG+eS5h/jIBfwePWeZ6KKjuaB6t3VxdI+4gmnnAMJxqrMe138mmFADUtuXyR+B/p1M/QXfI40JaTJm57KjOQjE+f+BnX36UtZjZG9nr6hZDzwdYjTNuxrBiplko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750524949; c=relaxed/simple;
	bh=PjBQFQE8zjc9oymlL/eDzoUk6y1uxAwN/iyT4IRP/mk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7cVDFZ0HqSMXz3DLlHbB8AdhY0F6a9nZHTiw72U+mMxJtinjrWlxJ97p8yfUdyNrlWXpSPdxLEzbWY04aZGAVaIFvV8JMIeTHNuMjmdMPQ0Zcfa30nboeuPKzySxYLLzX7qtInp4m/NzUfLFLlhk/ZxZFe8uiOFpi6e/FEljcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQ02WcIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116C9C4CEE7;
	Sat, 21 Jun 2025 16:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750524948;
	bh=PjBQFQE8zjc9oymlL/eDzoUk6y1uxAwN/iyT4IRP/mk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mQ02WcIw2N6SOWPysc7+BValZopTQJQS+rjo8k0kL1+14t5UqgAPZho7+j/WfzOvT
	 vtqeKzCc9LIazz3PEfnVwaSes/lp3nD0g0ieT8HEb3kyUCDlPlWizAMb36lsKWstzU
	 y0ws+WEcatBWD6HsCTjfOK2zn3XbjctRF/3cuz+ivQB8FSuELkdWYF8e8AGrRiMHqp
	 sSksQTlOQ69MT7LPQ90xT0QLVUaz6/vFWMmlUIp9EGVD2ezSoodL7QJMODSwgCfmJf
	 MlQFuvvBrek/72BYUk2Tpp/zp+EPIdD0zioKhdTHz1CYKhkHR3uuDWQAW6FGZLL0d4
	 fDTI8ubPql0bg==
Date: Sat, 21 Jun 2025 17:55:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v9 01/11] iio: accel: adxl345: apply scale factor to tap
 threshold
Message-ID: <20250621175540.4520a6b5@jic23-huawei>
In-Reply-To: <CAFXKEHbh=_A9WvEvkBaz9nNEGX5bxWu2sFvbMtqLM-Ag0cdY0A@mail.gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
	<20250610215933.84795-2-l.rubusch@gmail.com>
	<20250614144208.363c29cf@jic23-huawei>
	<CAFXKEHbh=_A9WvEvkBaz9nNEGX5bxWu2sFvbMtqLM-Ag0cdY0A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Jun 2025 00:20:49 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sat, Jun 14, 2025 at 3:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Tue, 10 Jun 2025 21:59:23 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > The threshold for tap detection was still not scaled. The datasheet s=
ets
> > > a scale factor of 62.5mg/LSB. Remove commit about not scaled threshold
> > > for tap detection, and apply scaling to it.
> > > =20
> >
> > Given tap detection algorithms are not generally well defined and not a=
 simple
> > threshold (generally) what scaling should we be aiming for here?
> > Even if it were a simple threshold, when a channel provides _raw the
> > expectation is that event config is vs _raw, not the base units.
> >
> > So if this doesn't care about the current fullscale range (which the
> > comment implied was the case) it would need to rescale when the
> > IIO_INFO_SCALE changes.
> >
> > That comment is I think indicating we decided to gloss over the
> > detail because it's going into a (potentially) non trivial algorithm an=
yway.
> >
> > Jonathan
> > =20
>=20
> Well, the tap threshold so far was around in "raw" LSB bits. At that
> time I only left the comment that the value is not scaled. The current
> patch is just putting now the scale factor and the sysfs handle then
> will take values of 'g' and not just raw bits. This is like for the
> other scaled values such as periods.

Tricky corner because tap isn't a simple threshold - it it were I'd have
a cleaner argument.

If we were doing this it would need to be scalling to m/s^2 not g but
that's not important for this discussion.

Huh. For thresholds I thought we had this clear in the ABI docs, but we don=
't.
The ABI doc refers to having _raw_ in the name which I'm not sure has been =
true=20
in a very long time.  The convention is intended to be if the channel
has _raw the thresholds are in that unit (i.e. ADC counts) and if not
they are in the processed value units.

It has to be this way because of non linear sensors.  We have cases
where there isn't a transform we can sensibly convert in the kernel
to set a 'raw' threshold.   (involves cube roots for instance).
As a side note, those sensors are one of the few cases where we have
both _RAW and _PROCESSED because the thresholds have to relate to _RAW
but we need _PROCESSED to give standard units.
=20
Now for this case where it's kind of tangentially connected by the
particular algorithm to the raw reading things are non obvious.
The tap detector could just as easily be a threshold on jerk -
rate of change of acceleration or some 'score' calculated from
a bunch of inputs in which case we couldn't apply a scaling.

>=20
> I think at the time I left the thresholds a bit out, because for me
> it's clear what a time is. But I'm not sure, if actually the
> thresholds are going so much by the unit values. So, in particular
> what is missing here? Is it just about the commit message, or does it
> need technical further adjustments?

I don't think the patch is needed. For this particular parameter there
isn't a clear concept of scale (putting aside that for this particular
sensor there is one).  Thus it's a twiddle control. No need to connect
it to real world units at all.  Also change this is an ABI change
so we should do it only if we are considering the change to be fixing
a bug.

Jonathan

>=20
> Best,
> L
> > =20
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl345_core.c | 11 +++++------
> > >  1 file changed, 5 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adx=
l345_core.c
> > > index 7c093c0241de..d80efb68d113 100644
> > > --- a/drivers/iio/accel/adxl345_core.c
> > > +++ b/drivers/iio/accel/adxl345_core.c
> > > @@ -697,17 +697,15 @@ static int adxl345_read_event_value(struct iio_=
dev *indio_dev,
> > >               switch (info) {
> > >               case IIO_EV_INFO_VALUE:
> > >                       /*
> > > -                      * The scale factor would be 62.5mg/LSB (i.e. 0=
xFF =3D 16g) but
> > > -                      * not applied here. In context of this general=
 purpose sensor,
> > > -                      * what imports is rather signal intensity than=
 the absolute
> > > -                      * measured g value.
> > > +                      * Scale factor is 62.5mg/LSB i.e. 0xff =3D 16g
> > >                        */
> > >                       ret =3D regmap_read(st->regmap, ADXL345_REG_THR=
ESH_TAP,
> > >                                         &tap_threshold);
> > >                       if (ret)
> > >                               return ret;
> > > -                     *val =3D sign_extend32(tap_threshold, 7);
> > > -                     return IIO_VAL_INT;
> > > +                     *val =3D 62500 * sign_extend32(tap_threshold, 7=
);
> > > +                     *val2 =3D MICRO;
> > > +                     return IIO_VAL_FRACTIONAL;
> > >               case IIO_EV_INFO_TIMEOUT:
> > >                       *val =3D st->tap_duration_us;
> > >                       *val2 =3D 1000000;
> > > @@ -746,6 +744,7 @@ static int adxl345_write_event_value(struct iio_d=
ev *indio_dev,
> > >       case IIO_EV_TYPE_GESTURE:
> > >               switch (info) {
> > >               case IIO_EV_INFO_VALUE:
> > > +                     val =3D DIV_ROUND_CLOSEST(val * MICRO + val2, 6=
2500);
> > >                       ret =3D regmap_write(st->regmap, ADXL345_REG_TH=
RESH_TAP,
> > >                                          min(val, 0xFF));
> > >                       if (ret) =20
> > =20


