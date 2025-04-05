Return-Path: <linux-iio+bounces-17640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CBCA7CA31
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD8A3B92EE
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767E91537DA;
	Sat,  5 Apr 2025 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTpEFuVj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AC52C9D;
	Sat,  5 Apr 2025 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743870098; cv=none; b=H4CygYrnJP1U7YSMjukBbZa94Q0+BPLC2La1cDC7LdONb3MhoqUfkkiEjTkEtC4iInyI12xwuXfjGAjwZ4nq4IBYNdqWIFssls/d1yPC9uIjTXLs540qjBJJdRRMspDWz/1P64HcD5DLAuSmI8Gs42F4KkE6MFOBcQXgfrRzPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743870098; c=relaxed/simple;
	bh=FMZsCjVJoDuC4NgUGqJMQBqh8VxxWlRRa7DVpA+BNz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dst2p1pBPGHBcTlMa2otlGvRcj1v+3a8qFHY6es/UNbBeRifiGBgH+VVqn5p7gODSEPrtIb5Kcwd4MvammbrYMNQQLv1ZZ49Y/JKC05gr8ehpzQLID4zS/PvsmA+4ThaHECtsN7D+b8HNqMZbcqpGA0/0iFnWnbzB7xEle1jgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTpEFuVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F58BC4CEE4;
	Sat,  5 Apr 2025 16:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743870097;
	bh=FMZsCjVJoDuC4NgUGqJMQBqh8VxxWlRRa7DVpA+BNz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kTpEFuVj9WbNNF0JOAUOLOzD02K9mz5bX9PGJGxcGVPiMmdetz3CfdLCvv1JGSdG0
	 QI0mtEGCVzWR5i8on75QqhwgmM60YmhkAsncPmXhzOdSjGm+JMWsibClEP60B/Qiq8
	 P9jwFv9cGPsNszJ+zYwb4mlO808zrskESmXWWIkS8tk3Rsz56xgmS54PadhIiQvOIZ
	 Y8B56mRSdpDmd9rbVdBzuOw0YM7tFn2DmqPMMpGM9DHlKL3mEpH3XZUtfqwPwAidZY
	 gecW013ZzURN1j+Riwl8ZPgNB1CF6SdgBK42nUwYcTseBtRWI2tWC/sgnvdUG4t9D+
	 khSyy0Gh+Clzg==
Date: Sat, 5 Apr 2025 17:21:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7380: fix event threshold shift
Message-ID: <20250405172133.3262bed0@jic23-huawei>
In-Reply-To: <CAEHHSvbt7v7OCbW4PEwgop74n_5NW8Una1-R3w3yUqu8-22=Dg@mail.gmail.com>
References: <20250402-iio-adc-ad7380-fix-event-threshold-shift-v1-1-ad4975c296b2@baylibre.com>
	<CAEHHSvbt7v7OCbW4PEwgop74n_5NW8Una1-R3w3yUqu8-22=Dg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Apr 2025 13:45:41 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> Le jeu. 3 avr. 2025 =C3=A0 01:56, David Lechner <dlechner@baylibre.com> a=
 =C3=A9crit :
> >
> > Add required bit shift to the event threshold read function to get
> > correct scaling.
> >
> > When alert support was added, the write function correctly included the
> > required shift needed to convert the threshold register value to the
> > same scale as the raw ADC value. However, the shift got missed in the
> > read function. =20
>=20
> Hi David,
>=20
> Thank you for fixing that. LGTM
>=20
> Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

J
>=20
> >
> > Fixes: 27d1a4dbe1e1 ("iio: adc: ad7380: add alert support")
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  drivers/iio/adc/ad7380.c | 25 +++++++++++++++++++------
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> > index 4fcb49fdf56639784098f0147a9faef8dcb6b0f6..f3962a45e1e5b88cebf712c=
c867fbb576d3ca058 100644
> > --- a/drivers/iio/adc/ad7380.c
> > +++ b/drivers/iio/adc/ad7380.c
> > @@ -1611,11 +1611,25 @@ static int ad7380_write_event_config(struct iio=
_dev *indio_dev,
> >         return ret;
> >  }
> >
> > -static int ad7380_get_alert_th(struct ad7380_state *st,
> > +static int ad7380_get_alert_th(struct iio_dev *indio_dev,
> > +                              const struct iio_chan_spec *chan,
> >                                enum iio_event_direction dir,
> >                                int *val)
> >  {
> > -       int ret, tmp;
> > +       struct ad7380_state *st =3D iio_priv(indio_dev);
> > +       const struct iio_scan_type *scan_type;
> > +       int ret, tmp, shift;
> > +
> > +       scan_type =3D iio_get_current_scan_type(indio_dev, chan);
> > +       if (IS_ERR(scan_type))
> > +               return PTR_ERR(scan_type);
> > +
> > +       /*
> > +        * The register value is 12-bits and is compared to the most si=
gnificant
> > +        * bits of raw value, therefore a shift is required to convert =
this to
> > +        * the same scale as the raw value.
> > +        */
> > +       shift =3D scan_type->realbits - 12;
> >
> >         switch (dir) {
> >         case IIO_EV_DIR_RISING:
> > @@ -1625,7 +1639,7 @@ static int ad7380_get_alert_th(struct ad7380_stat=
e *st,
> >                 if (ret)
> >                         return ret;
> >
> > -               *val =3D FIELD_GET(AD7380_ALERT_HIGH_TH, tmp);
> > +               *val =3D FIELD_GET(AD7380_ALERT_HIGH_TH, tmp) << shift;
> >                 return IIO_VAL_INT;
> >         case IIO_EV_DIR_FALLING:
> >                 ret =3D regmap_read(st->regmap,
> > @@ -1634,7 +1648,7 @@ static int ad7380_get_alert_th(struct ad7380_stat=
e *st,
> >                 if (ret)
> >                         return ret;
> >
> > -               *val =3D FIELD_GET(AD7380_ALERT_LOW_TH, tmp);
> > +               *val =3D FIELD_GET(AD7380_ALERT_LOW_TH, tmp) << shift;
> >                 return IIO_VAL_INT;
> >         default:
> >                 return -EINVAL;
> > @@ -1648,7 +1662,6 @@ static int ad7380_read_event_value(struct iio_dev=
 *indio_dev,
> >                                    enum iio_event_info info,
> >                                    int *val, int *val2)
> >  {
> > -       struct ad7380_state *st =3D iio_priv(indio_dev);
> >         int ret;
> >
> >         switch (info) {
> > @@ -1656,7 +1669,7 @@ static int ad7380_read_event_value(struct iio_dev=
 *indio_dev,
> >                 if (!iio_device_claim_direct(indio_dev))
> >                         return -EBUSY;
> >
> > -               ret =3D ad7380_get_alert_th(st, dir, val);
> > +               ret =3D ad7380_get_alert_th(indio_dev, chan, dir, val);
> >
> >                 iio_device_release_direct(indio_dev);
> >                 return ret;
> >
> > ---
> > base-commit: f8ffc92ae9052e6615896052f0c5b808bfc17520
> > change-id: 20250402-iio-adc-ad7380-fix-event-threshold-shift-b614db1a30=
7f
> >
> > Best regards,
> > --
> > David Lechner <dlechner@baylibre.com>
> > =20


