Return-Path: <linux-iio+bounces-2036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42B841401
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 21:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B865B239D1
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jan 2024 20:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E216F097;
	Mon, 29 Jan 2024 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uPslWfJD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9E48790
	for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 20:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558728; cv=none; b=jYK7xmpW4yVqvFx2HDItQNCqRItXN5NA7zEzgAbmOe4OSSdZgJwtBFHg7/eMDPm7XHT04d5sNZBILEdUrq7xevC64QhETLNK3oQgx6UCMkIIGKagdee3JHb9a4zlE3Ne3OdveXtmS8pnyxw5w6yoLpegS58hHTc2ynhHh3LqpW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558728; c=relaxed/simple;
	bh=3TehCbVz8ApsZuDlRfbfKtgLeG3s0JILI2kq1nsVKdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcK41H7xTak1vmdIwj0jBdPXAL46aG7ex3p821qBD43gjptNr3t0u0ol1wD2vSq8vlatSNdouhnB8IO+L9d1MkyGvh6KQH7htoVU5B3htbezNj6kVbCYuqVWKMBl+NO5GNeHRLJvcOlVsxNMVPr/WRnzArqbZtYkOwveSoYqyZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uPslWfJD; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d03fde0bd9so23922471fa.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Jan 2024 12:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706558724; x=1707163524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf+kpwnXRc+O/IVIlptu9ivGnQE7Iaq6gMnzGPIrjRw=;
        b=uPslWfJDZeUmeUKUHJFy+ZDTsMMY/aPTNe8abd4FqrASDC52lKJ64wQPMlaSuTQHp3
         q0D4V7sQxOFt1rd33VtrDGtOjgpW4BdQAV1qhYtEBUnBnsRk+Lg7SG6ZSoQAgHOAu3Q1
         RXSuX5wh7bQHuWh1KZtbdFBGx/dru6LXHBl0uNeCPGekxoT48+DaYW+PssmETKB5Pdwb
         Zm39o94r0ca4PJIAUU89K4xa8mixPU2Xhsb94wEQkUFuxpNEgSeWWnuFTySUpfEdfMq7
         9sSqIZY8V4r87FWBp5AgO+vHxxaJTy6DPWpkHZZYItcO1mExoAePn4GI0X0qCPrQOTWd
         PCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558724; x=1707163524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf+kpwnXRc+O/IVIlptu9ivGnQE7Iaq6gMnzGPIrjRw=;
        b=cyN0GMIhCqdL7+AQB5nLxnGBhErGL2hpjEenH2xhnyLg9sFfnn2wyDYADVepQ9Hf9V
         knoSW0DtvgQ8Vx66TZzI16CnOihKCEAFG7uShux848i2vouPZjVooXGmRyAEL0TqrJBL
         rINwTlbbH8WuMyrYxzS8wWxzjjbwSCKt0G7BgweaOUbTWu9ekCXQutCZYJfgtYvlJ2am
         f/Xss4NM0l8cxnPfNfCb35TCGuQmxT2OK7zchREVYrh47AHQdHVQF9pG/42/jHcBfh8r
         4TnFN3Fg7rnVaj09PwktynuZPFzWelXyLtOaIv0EcpMHezVLlx7Bd8tiAan4OASrhajd
         h4AQ==
X-Gm-Message-State: AOJu0YwfYBn3TNh4odBwi8QLj96dc5vLijUtgGx9JZW7TrcH6cCdeVNW
	AyqJlWtV9koxMeddD1F7svbcP2chCtJMsxqKoZMhu4G90mGT5b8tt4f6At9RVBaYbZUkejE4Nyb
	lp7AlA27zpPMjrW/l7IzNZbfxcsFDkoFyTWKZ/lOGAMri0x3M
X-Google-Smtp-Source: AGHT+IFMN/mKSteZ7NRdm7d+Z3Jvk2qfsbDOj+H2K1H8YQXsrhB1Kx+z2dhYS27sQoD4L8rHeG1r1JKH1AM5kNaIq/g=
X-Received: by 2002:a2e:9011:0:b0:2cf:81d:3abe with SMTP id
 h17-20020a2e9011000000b002cf081d3abemr5618100ljg.33.1706558723632; Mon, 29
 Jan 2024 12:05:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128150537.44592-1-jic23@kernel.org> <20240128150537.44592-3-jic23@kernel.org>
 <CAMknhBFzuoQQDbfJjUkDd8udAkRzhsM_Vs-FyEmaAE_k6QXk3Q@mail.gmail.com>
 <20240129114622.00007e1c@Huawei.com> <20240129195813.34912f8c@jic23-huawei>
In-Reply-To: <20240129195813.34912f8c@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 29 Jan 2024 14:05:12 -0600
Message-ID: <CAMknhBE2kxguB6Yx1q_ktp68EY+DOpiu98d-26MHJgBqAc2F-w@mail.gmail.com>
Subject: Re: [PATCH 02/10] iio: dummy: Use automatic lock and direct mode cleanup.
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 1:58=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 29 Jan 2024 11:46:22 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > > > @@ -436,10 +431,10 @@ static int iio_dummy_write_raw(struct iio_dev=
 *indio_dev,
> > > >                         if (chan->output =3D=3D 0)
> > > >                                 return -EINVAL;
> > > >
> > > > -                       /* Locking not required as writing single v=
alue */
> > > > -                       mutex_lock(&st->lock);
> > > > -                       st->dac_val =3D val;
> > > > -                       mutex_unlock(&st->lock);
> > > > +                       scoped_guard(mutex, &st->lock) {
> > > > +                               /* Locking not required as writing =
single value */
> > > > +                               st->dac_val =3D val;
> > > > +                       }
> > > >                         return 0;
> > > >                 default:
> > > >                         return -EINVAL;
> > > > @@ -447,9 +442,9 @@ static int iio_dummy_write_raw(struct iio_dev *=
indio_dev,
> > > >         case IIO_CHAN_INFO_PROCESSED:
> > > >                 switch (chan->type) {
> > > >                 case IIO_STEPS:
> > > > -                       mutex_lock(&st->lock);
> > > > -                       st->steps =3D val;
> > > > -                       mutex_unlock(&st->lock);
> > > > +                       scoped_guard(mutex, &st->lock) {
> > > > +                               st->steps =3D val;
> > > > +                       }
> > > >                         return 0;
> > > >                 case IIO_ACTIVITY:
> > > >                         if (val < 0)
> > > > @@ -470,30 +465,29 @@ static int iio_dummy_write_raw(struct iio_dev=
 *indio_dev,
> > > >                 default:
> > > >                         return -EINVAL;
> > > >                 }
> > > > -       case IIO_CHAN_INFO_CALIBSCALE:
> > > > -               mutex_lock(&st->lock);
> > > > +       case IIO_CHAN_INFO_CALIBSCALE: {
> > > > +               guard(mutex)(&st->lock);
> > > >                 /* Compare against table - hard matching here */
> > > >                 for (i =3D 0; i < ARRAY_SIZE(dummy_scales); i++)
> > > >                         if (val =3D=3D dummy_scales[i].val &&
> > > >                             val2 =3D=3D dummy_scales[i].val2)
> > > >                                 break;
> > > >                 if (i =3D=3D ARRAY_SIZE(dummy_scales))
> > > > -                       ret =3D -EINVAL;
> > > > -               else
> > > > -                       st->accel_calibscale =3D &dummy_scales[i];
> > > > -               mutex_unlock(&st->lock);
> > > > +                       return  -EINVAL;
> > > > +               st->accel_calibscale =3D &dummy_scales[i];
> > > >                 return ret;
> > >
> > > Can we change this to `return 0;` and get rid of the `ret =3D 0`
> > > initialization at the beginning of the function?
> >
> > Yes. That would make sense.
>
> Given it's fairly trivial, I may not post it again but instead just
> tidy that up whilst applying.  Diff will also git rid of the bonus space
> in this block. oops.

In that case:

Reviewed-by: David Lechner <dlechner@baylibre.com>

>
> diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio=
_simple_dummy.c
> index d6ef556698fb..09efacaf8f78 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.c
> +++ b/drivers/iio/dummy/iio_simple_dummy.c
> @@ -421,7 +421,6 @@ static int iio_dummy_write_raw(struct iio_dev *indio_=
dev,
>                                long mask)
>  {
>         int i;
> -       int ret =3D 0;
>         struct iio_dummy_state *st =3D iio_priv(indio_dev);
>
>         switch (mask) {
> @@ -473,9 +472,9 @@ static int iio_dummy_write_raw(struct iio_dev *indio_=
dev,
>                             val2 =3D=3D dummy_scales[i].val2)
>                                 break;
>                 if (i =3D=3D ARRAY_SIZE(dummy_scales))
> -                       return  -EINVAL;
> +                       return -EINVAL;
>                 st->accel_calibscale =3D &dummy_scales[i];
> -               return ret;
> +               return 0;
>         }
>         case IIO_CHAN_INFO_CALIBBIAS:
>                 scoped_guard(mutex, &st->lock) {
>
> > >
> > > > +       }
> >
>

