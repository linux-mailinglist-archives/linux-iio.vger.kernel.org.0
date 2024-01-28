Return-Path: <linux-iio+bounces-2000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835CC83FA2F
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 22:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A212B1C218BC
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 21:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6532B3C082;
	Sun, 28 Jan 2024 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IdzEqNre"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBEA3C461
	for <linux-iio@vger.kernel.org>; Sun, 28 Jan 2024 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706478777; cv=none; b=d9R/jVykx0qtnyRuCgKFoZzcdHoDwEgMRY7HF2gsPcg5gfFjsbcdV1r7IIcEPztAxkKY0APYV1WRGNzVI6jc/tOZRF37OQJRYoTPuQ3FbHIVeSmEWmIlWmumd0kCQ3zknxuntCIZd4UEU/AbZNyTNTLqs+PR5Dcqk7ffWFN9wdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706478777; c=relaxed/simple;
	bh=murJu3OJPVpjzB+F7iu5mCqzVgC6RU/jRdygxnAAjk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ly5Bi99rGRnoy7d4CzAm9aZNWGcvebL3eY4cA/6fcrXqcEaRIcWa97jv7LqaEf7KzPC8nyZX5Y45QnQ1JueyACoGxMPFn3Pr+vzNFf0yhWnbTLPncdvNSw2NLUiX+V5Nbyjws8DK0TmNbe4GWSRj5II4ib/dgYEsLz8VFJymDrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IdzEqNre; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cf2adac1ccso23198841fa.3
        for <linux-iio@vger.kernel.org>; Sun, 28 Jan 2024 13:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706478772; x=1707083572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkmKJovn38Zcn3jqE4wxSHRsM3yDOcxxeHOgV9Pp9Gc=;
        b=IdzEqNrexRfmfd7HFvsyPta3nAe2MFH4k0UBvWaNRBdDQuIu4B64UIhBVlHKbXFKDs
         dE0KfmPQOwWAWZvEKQL14tK2v0AJAjXNgDf0KAFWe5d8gbGetejCK7+yQdy4Cxkyw+o/
         7lbNqvAHjh5sBa0112F2IMeMN28YO9JDA/L3Egq08OkBa4ZubZyRdruclfn9lUIdZ5xf
         JZ2aeE/dKPa/cf8+L4VPjurfUEdMOVM/AhjqNkLAU0MePunjB86t5mjOzixvUIqZGDn7
         gdA4eijAfeLwsnGa7ahHe1TBtEa09eh/JQeseSUIM12V1r8y/dCCMe/a6Yn0SLuj1Ixc
         MxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706478772; x=1707083572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkmKJovn38Zcn3jqE4wxSHRsM3yDOcxxeHOgV9Pp9Gc=;
        b=j03xQrCtx1OnYdPs1CJeqfJVqC/8fnw+JbyFmwrYNoMaiww3RA3E8pkssYb65IQeKX
         Dt1hCFzssmRYwCqnPXhqOl+lm6TZssTh0I7pKuVzfc66MlLOCr8GRP7As6WpRjArRzI3
         C8ionAbIWY2KsSEnx/CBGiqnoDo/RkhcYtKN+UfiC4qM6b/nv2F97m3DIEz9LtFyyNgL
         yiDycIi1cQDCedjAs/naCL0dyuPEj9qCqkIIEaf3aTK8mPC/rQ/3QOy6CgMBtNfaxZsf
         GB+kIQLr7QzUZ8yyUjvYMO8q7fCwDBKtqj2bzEHbblEEOe7X4VI6kUPGd65J6YpPgPwq
         9Gaw==
X-Gm-Message-State: AOJu0Yw2HNKsXUkDQYUSjPqqHQW2dc6PvXRZJgmP1Y7LBYsHaeOuUDUK
	j4FvgeImZ9NBJ71kMEatUI5g+SJdMGFRv3LUFyEedFUTG1PjCreI9uX/2+XtA4mV4/YcYPXDUuQ
	hmGf2nCFrcyX9XabaiaPvcDT3kGVbswD91YFGUA==
X-Google-Smtp-Source: AGHT+IFK3XGV+VgiX4ZZqSfX+XM44HRPwfZAW301sTjQyPDmUEj7jWmD+8RePu7wOtP7GPUIk+xkoHHpYA8+62gTYH4=
X-Received: by 2002:a2e:b4b6:0:b0:2cf:4017:64ed with SMTP id
 q22-20020a2eb4b6000000b002cf401764edmr2698004ljm.4.1706478771956; Sun, 28 Jan
 2024 13:52:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128150537.44592-1-jic23@kernel.org> <20240128150537.44592-3-jic23@kernel.org>
In-Reply-To: <20240128150537.44592-3-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 28 Jan 2024 15:52:41 -0600
Message-ID: <CAMknhBFzuoQQDbfJjUkDd8udAkRzhsM_Vs-FyEmaAE_k6QXk3Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] iio: dummy: Use automatic lock and direct mode cleanup.
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 9:06=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Given we now have iio_device_claim_direct_scoped() to perform automatic
> releasing of direct mode at exit from the scope that follows it, this can
> be used in conjunction with guard(mutex) etc remove a lot of special case
> handling.
>
> Note that in this particular example code, there is no real reason you ca=
n't
> read channels via sysfs at the same time as filling the software buffer.
> To make it look more like a real driver constrain raw and processed
> channel reads from occurring whilst the buffer is in use.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> Since RFC:
> - Dropped a stale comment about a local variable that existed
>   in an earlier version of this patch before the new scoped_guard_cond()
>   infrastructure was added.
> - Use unreachable() to convince the compiler we can't get to code
>   at end of the pattern.
>
>         iio_device_claim_direct_scoped(return -EBUSY, iio_dev) {
>                 return 0;
>         }
>         unreacahable();
> ---
>  drivers/iio/dummy/iio_simple_dummy.c | 182 +++++++++++++--------------
>  1 file changed, 88 insertions(+), 94 deletions(-)
>
> diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio=
_simple_dummy.c
> index c24f609c2ade..d6ef556698fb 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.c
> +++ b/drivers/iio/dummy/iio_simple_dummy.c
> @@ -283,65 +283,63 @@ static int iio_dummy_read_raw(struct iio_dev *indio=
_dev,
>                               long mask)
>  {
>         struct iio_dummy_state *st =3D iio_priv(indio_dev);
> -       int ret =3D -EINVAL;
>
> -       mutex_lock(&st->lock);
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW: /* magic value - channel value read */
> -               switch (chan->type) {
> -               case IIO_VOLTAGE:
> -                       if (chan->output) {
> -                               /* Set integer part to cached value */
> -                               *val =3D st->dac_val;
> -                               ret =3D IIO_VAL_INT;
> -                       } else if (chan->differential) {
> -                               if (chan->channel =3D=3D 1)
> -                                       *val =3D st->differential_adc_val=
[0];
> -                               else
> -                                       *val =3D st->differential_adc_val=
[1];
> -                               ret =3D IIO_VAL_INT;
> -                       } else {
> -                               *val =3D st->single_ended_adc_val;
> -                               ret =3D IIO_VAL_INT;
> +               iio_device_claim_direct_scoped(return -EBUSY, indio_dev) =
{
> +                       guard(mutex)(&st->lock);
> +                       switch (chan->type) {
> +                       case IIO_VOLTAGE:
> +                               if (chan->output) {
> +                                       /* Set integer part to cached val=
ue */
> +                                       *val =3D st->dac_val;
> +                                       return IIO_VAL_INT;
> +                               } else if (chan->differential) {
> +                                       if (chan->channel =3D=3D 1)
> +                                               *val =3D st->differential=
_adc_val[0];
> +                                       else
> +                                               *val =3D st->differential=
_adc_val[1];
> +                                       return IIO_VAL_INT;
> +                               } else {
> +                                       *val =3D st->single_ended_adc_val=
;
> +                                       return IIO_VAL_INT;
> +                               }
> +
> +                       case IIO_ACCEL:
> +                               *val =3D st->accel_val;
> +                               return IIO_VAL_INT;
> +                       default:
> +                               return -EINVAL;
>                         }
> -                       break;
> -               case IIO_ACCEL:
> -                       *val =3D st->accel_val;
> -                       ret =3D IIO_VAL_INT;
> -                       break;
> -               default:
> -                       break;
>                 }
> -               break;
> +               unreachable();
>         case IIO_CHAN_INFO_PROCESSED:
> -               switch (chan->type) {
> -               case IIO_STEPS:
> -                       *val =3D st->steps;
> -                       ret =3D IIO_VAL_INT;
> -                       break;
> -               case IIO_ACTIVITY:
> -                       switch (chan->channel2) {
> -                       case IIO_MOD_RUNNING:
> -                               *val =3D st->activity_running;
> -                               ret =3D IIO_VAL_INT;
> -                               break;
> -                       case IIO_MOD_WALKING:
> -                               *val =3D st->activity_walking;
> -                               ret =3D IIO_VAL_INT;
> -                               break;
> +               iio_device_claim_direct_scoped(return -EBUSY, indio_dev) =
{
> +                       guard(mutex)(&st->lock);
> +                       switch (chan->type) {
> +                       case IIO_STEPS:
> +                               *val =3D st->steps;
> +                               return IIO_VAL_INT;
> +                       case IIO_ACTIVITY:
> +                               switch (chan->channel2) {
> +                               case IIO_MOD_RUNNING:
> +                                       *val =3D st->activity_running;
> +                                       return IIO_VAL_INT;
> +                               case IIO_MOD_WALKING:
> +                                       *val =3D st->activity_walking;
> +                                       return IIO_VAL_INT;
> +                               default:
> +                                       return -EINVAL;
> +                               }
>                         default:
> -                               break;
> +                               return -EINVAL;
>                         }
> -                       break;
> -               default:
> -                       break;
>                 }
> -               break;
> +               unreachable();
>         case IIO_CHAN_INFO_OFFSET:
>                 /* only single ended adc -> 7 */
>                 *val =3D 7;
> -               ret =3D IIO_VAL_INT;
> -               break;
> +               return IIO_VAL_INT;
>         case IIO_CHAN_INFO_SCALE:
>                 switch (chan->type) {
>                 case IIO_VOLTAGE:
> @@ -350,60 +348,57 @@ static int iio_dummy_read_raw(struct iio_dev *indio=
_dev,
>                                 /* only single ended adc -> 0.001333 */
>                                 *val =3D 0;
>                                 *val2 =3D 1333;
> -                               ret =3D IIO_VAL_INT_PLUS_MICRO;
> -                               break;
> +                               return IIO_VAL_INT_PLUS_MICRO;
>                         case 1:
>                                 /* all differential adc -> 0.000001344 */
>                                 *val =3D 0;
>                                 *val2 =3D 1344;
> -                               ret =3D IIO_VAL_INT_PLUS_NANO;
> +                               return IIO_VAL_INT_PLUS_NANO;
> +                       default:
> +                               return -EINVAL;
>                         }
> -                       break;
>                 default:
> -                       break;
> +                       return -EINVAL;
>                 }
> -               break;
> -       case IIO_CHAN_INFO_CALIBBIAS:
> +       case IIO_CHAN_INFO_CALIBBIAS: {
> +               guard(mutex)(&st->lock);
>                 /* only the acceleration axis - read from cache */
>                 *val =3D st->accel_calibbias;
> -               ret =3D IIO_VAL_INT;
> -               break;
> -       case IIO_CHAN_INFO_CALIBSCALE:
> +               return IIO_VAL_INT;
> +       }
> +       case IIO_CHAN_INFO_CALIBSCALE: {
> +               guard(mutex)(&st->lock);
>                 *val =3D st->accel_calibscale->val;
>                 *val2 =3D st->accel_calibscale->val2;
> -               ret =3D IIO_VAL_INT_PLUS_MICRO;
> -               break;
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       }
>         case IIO_CHAN_INFO_SAMP_FREQ:
>                 *val =3D 3;
>                 *val2 =3D 33;
> -               ret =3D IIO_VAL_INT_PLUS_NANO;
> -               break;
> -       case IIO_CHAN_INFO_ENABLE:
> +               return IIO_VAL_INT_PLUS_NANO;
> +       case IIO_CHAN_INFO_ENABLE: {
> +               guard(mutex)(&st->lock);
>                 switch (chan->type) {
>                 case IIO_STEPS:
>                         *val =3D st->steps_enabled;
> -                       ret =3D IIO_VAL_INT;
> -                       break;
> +                       return IIO_VAL_INT;
>                 default:
> -                       break;
> +                       return -EINVAL;
>                 }
> -               break;
> -       case IIO_CHAN_INFO_CALIBHEIGHT:
> +       }
> +       case IIO_CHAN_INFO_CALIBHEIGHT: {
> +               guard(mutex)(&st->lock);
>                 switch (chan->type) {
>                 case IIO_STEPS:
>                         *val =3D st->height;
> -                       ret =3D IIO_VAL_INT;
> -                       break;
> +                       return IIO_VAL_INT;
>                 default:
> -                       break;
> +                       return -EINVAL;
>                 }
> -               break;
> -
> +       }
>         default:
> -               break;
> +               return -EINVAL;
>         }
> -       mutex_unlock(&st->lock);
> -       return ret;
>  }
>
>  /**
> @@ -436,10 +431,10 @@ static int iio_dummy_write_raw(struct iio_dev *indi=
o_dev,
>                         if (chan->output =3D=3D 0)
>                                 return -EINVAL;
>
> -                       /* Locking not required as writing single value *=
/
> -                       mutex_lock(&st->lock);
> -                       st->dac_val =3D val;
> -                       mutex_unlock(&st->lock);
> +                       scoped_guard(mutex, &st->lock) {
> +                               /* Locking not required as writing single=
 value */
> +                               st->dac_val =3D val;
> +                       }
>                         return 0;
>                 default:
>                         return -EINVAL;
> @@ -447,9 +442,9 @@ static int iio_dummy_write_raw(struct iio_dev *indio_=
dev,
>         case IIO_CHAN_INFO_PROCESSED:
>                 switch (chan->type) {
>                 case IIO_STEPS:
> -                       mutex_lock(&st->lock);
> -                       st->steps =3D val;
> -                       mutex_unlock(&st->lock);
> +                       scoped_guard(mutex, &st->lock) {
> +                               st->steps =3D val;
> +                       }
>                         return 0;
>                 case IIO_ACTIVITY:
>                         if (val < 0)
> @@ -470,30 +465,29 @@ static int iio_dummy_write_raw(struct iio_dev *indi=
o_dev,
>                 default:
>                         return -EINVAL;
>                 }
> -       case IIO_CHAN_INFO_CALIBSCALE:
> -               mutex_lock(&st->lock);
> +       case IIO_CHAN_INFO_CALIBSCALE: {
> +               guard(mutex)(&st->lock);
>                 /* Compare against table - hard matching here */
>                 for (i =3D 0; i < ARRAY_SIZE(dummy_scales); i++)
>                         if (val =3D=3D dummy_scales[i].val &&
>                             val2 =3D=3D dummy_scales[i].val2)
>                                 break;
>                 if (i =3D=3D ARRAY_SIZE(dummy_scales))
> -                       ret =3D -EINVAL;
> -               else
> -                       st->accel_calibscale =3D &dummy_scales[i];
> -               mutex_unlock(&st->lock);
> +                       return  -EINVAL;
> +               st->accel_calibscale =3D &dummy_scales[i];
>                 return ret;

Can we change this to `return 0;` and get rid of the `ret =3D 0`
initialization at the beginning of the function?

> +       }
>         case IIO_CHAN_INFO_CALIBBIAS:
> -               mutex_lock(&st->lock);
> -               st->accel_calibbias =3D val;
> -               mutex_unlock(&st->lock);
> +               scoped_guard(mutex, &st->lock) {
> +                       st->accel_calibbias =3D val;
> +               }
>                 return 0;
>         case IIO_CHAN_INFO_ENABLE:
>                 switch (chan->type) {
>                 case IIO_STEPS:
> -                       mutex_lock(&st->lock);
> -                       st->steps_enabled =3D val;
> -                       mutex_unlock(&st->lock);
> +                       scoped_guard(mutex, &st->lock) {
> +                               st->steps_enabled =3D val;
> +                       }
>                         return 0;
>                 default:
>                         return -EINVAL;
> --
> 2.43.0
>

