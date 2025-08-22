Return-Path: <linux-iio+bounces-23162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB0DB32368
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 22:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA13685741
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 20:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91BF2D660E;
	Fri, 22 Aug 2025 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDVUNafm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12EE296BC2;
	Fri, 22 Aug 2025 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755893520; cv=none; b=KiG/3547IcvSeUcNIv3dk+vKG9pXGztc1i0U9vge29Vk+npMYbdxXmQYs5Re94wSzsuLYIP/Ov/e43Dru4oDBFPu0J9YBtmjqlfTohm2Z0pQepgPd2Y/WoGR9YTbSoIcDKKULp3O4QJ5/+VGehAaPfXsGEJuPmlwgn7g1ShFdq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755893520; c=relaxed/simple;
	bh=Qc+tAas79SoueLGZxYqBMNxoUP0dz7M7A9BmuH2IGqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OB0HLWjYABHnJv9Db8Y78DsuZzvFR1Pfj2m9qmBFs6uilaMKhdLimD8gtVHBWy92d25p3wUtFNLH/4OvuDaJkOm0ZrE9/fvMn6kgvbdEIM+noYlYy1PrTY6/fnPbVcxFthT4jSSwe57TmDTqyIO9CG7IRRkinSreXRLytQjXgtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDVUNafm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7347e09so413454566b.0;
        Fri, 22 Aug 2025 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755893517; x=1756498317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4A1Ql4lSxr5sI97S3+o3OJuBZrWXIlFBUEQUap99xyg=;
        b=WDVUNafmOHTNx9eMfCHB9SGoSj1P4OTdSrTE6q3npaCf3esuxh6xOan6iG7j8BBz5D
         FrsZwRkAAU91NrQy53854JN7+WOxOCkijK97sQ2PzkuVxuInPvwAr6eCBBSzD3Kt7r1G
         IbFzcwl5CO8jU8/NLN5FtLnz9FaJ3DTt3KjD4k7Yl28ULrxQVSbVzhYuknx8lnTF4atg
         Eqmh3GxNBfmdK9K11VC8AXpToLTNrpNiWo23L/yjJD1IZnoCNkq/35bdARxQo2azuvQL
         RjyWN1ZrM9Klhc2KO82lVbAGzRaeLi5drGeN81qswtsZI0RBrofdf8C+JfqIrD+PKIBh
         menw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755893517; x=1756498317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4A1Ql4lSxr5sI97S3+o3OJuBZrWXIlFBUEQUap99xyg=;
        b=G9AvguYa71G2RKJUQAbKyz8Sdgq3g30660rLEo1BQKh1Rqil7Fvuona1Ika6F9HMEb
         swoDUdxyWiFoErPW2HwQy+L6zS0Vj3cTaOumA47Jmf5BCbMcA8uV5k9cbqGEixz0H/Mh
         tfMeU/wP/w25e3M9yXrNtMinEFMG0KklO0YyPkjOGASjS8zUBAIvVow37JGauETlKQDt
         /1gvGONWfPV163HLvtx4ii/L83/xiD1SBIGCm/zcCyZ0oiE83iqeDPhkPQXGsmDLJWe6
         97t4OraMePOrh2FzTucoBMPcTqLxzYD9eDhLSTbZF2XtV1pdEpHDU1kOSfz8jTUnXBlG
         QxXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlqKuJSkBQE3aBliodBJMCOG53wkUyqz9RUpW1I0eKdfOp4lvh1ToI46XaU2kcNWQ7MuwwB4bGOS+CNNW8@vger.kernel.org, AJvYcCVguX9cEkxUsDAyGrokC1rrEsbSLhGT+esRAW2ijHpUaLvSdbRvP89yZ8sQ1JnylBqZLDRenMK5OJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe3E3cli2eJ8pi7vOf90gftCtRI0ck7WDs86zyqa+PUunB3XjG
	o6SeMaK8AGPOEoECXpgsZLF6pftnS+AuRd808zRYH6rbRX8iTOSDZTStbXl77zXxtuQ2QoyQmwQ
	/8SaQ8sZzIAWc8hLPYH9ubs2+Kzg9wpg=
X-Gm-Gg: ASbGnctT8YqObxJS7/9OYsJnTMuidDdJDhrBxk5xCdiYLnWNBETR4Z09o93kA3QXYi8
	i0tl+gJjfMpo8coMwySsrosAvNM+5iwLpBeBJzLVQJ3JqB6tSyUtpXgCK7eNm2Ojr3dYEDYWIx+
	JK+xUbJERi41aC6ZwW78I1SZ5sIrEfokDm12n0oe061TS1xeWPaQawljqdOJfFccMYvJ2BCMCBy
	rvtsP0=
X-Google-Smtp-Source: AGHT+IHn4GOiuwGaU6VFDIZs961JwxHdDxXoF3cqv0zx77t33hP5YIEeDsdS5T62+lZsEVADGUhPBA0EQmaSJmo6/R0=
X-Received: by 2002:a17:907:ea0:b0:afd:fed4:9bec with SMTP id
 a640c23a62f3a-afe29548e90mr398121066b.31.1755893516882; Fri, 22 Aug 2025
 13:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822180335.362979-1-akshayaj.lkd@gmail.com>
In-Reply-To: <20250822180335.362979-1-akshayaj.lkd@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 Aug 2025 23:11:20 +0300
X-Gm-Features: Ac12FXxqaQRGd6tU76w-OOR4W7PTDWpiileG2wHNSCaUs6qC23trjcC1zzJpbqs
Message-ID: <CAHp75Veqf6tKiFh=dNkgNkc2qE17VM7u-Yt8CZaXOsnEFUwd_w@mail.gmail.com>
Subject: Re: [PATCH] iio: light: ltr390: Add runtime PM support
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 9:03=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail.c=
om> wrote:
>
> Implement runtime power management for the LTR390 sensor.
> The device would now autosuspend after 1s of idle time.
> This would save the overall power consumption by the sensor.
>
> Ensure that interrupts continue to be delivered during
> runtime suspend by disabling the sensor only when no
> interrupts are enabled. This prevents loss of events
> while still allowing power savings when IRQs are unused.

Have you tried to enable it as a wake source and disable it?

...

> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -30,6 +30,7 @@
>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/events.h>

> +#include <linux/pm_runtime.h>

Please, preserve ordering.

>  #include <linux/unaligned.h>

(This is here due to historical reasons when mass move from
asm/unaligned to linux/unaligned happened)

...

> +static int ltr390_set_power_state(struct ltr390_data *data, bool on)
> +{
> +       struct device *dev =3D &data->client->dev;
> +       int ret =3D 0;

Replace this assignment...

> +       if (on) {
> +               ret =3D pm_runtime_resume_and_get(dev);
> +               if (ret) {
> +                       dev_err(dev, "failed to resume runtime PM: %d\n",=
 ret);
> +                       return ret;
> +               }
> +       } else {
> +               pm_runtime_mark_last_busy(dev);
> +               pm_runtime_put_autosuspend(dev);

mark_last_busy is redundant.

> +       }

> +       return ret;

...calling return 0; here.

> +}


...

> +       ltr390_set_power_state(data, true);

The boolean parameter is a sign for refactoring to have just two
functions for false and for true cases respectively.

...

>                 default:
> -                       return -EINVAL;
> +                       ret =3D -EINVAL;
>                 }
> +               break;
>
>         case IIO_CHAN_INFO_INT_TIME:
>                 *val =3D data->int_time_us;
> -               return IIO_VAL_INT;
> +               ret =3D IIO_VAL_INT;
> +               break;
>
>         case IIO_CHAN_INFO_SAMP_FREQ:
>                 *val =3D ltr390_get_samp_freq_or_period(data, LTR390_GET_=
FREQ);
> -               return IIO_VAL_INT;
> +               ret =3D IIO_VAL_INT;
> +               break;
>
>         default:
> -               return -EINVAL;
> +               ret =3D -EINVAL;
>         }
> +
> +handle_pm:
> +       ltr390_set_power_state(data, false);
> +       return ret;


Instead, refactor the code the way that it just will have a wrapper
with power state calls. The change will be much smaller and easier to
understand, review, etc.

...

>  static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_s=
pec const *chan,
>                                 int val, int val2, long mask)
>  {
> +       int ret;
>         struct ltr390_data *data =3D iio_priv(indio_dev);
>
> +       ltr390_set_power_state(data, true);
> +
>         switch (mask) {
>         case IIO_CHAN_INFO_SCALE:
> -               if (val2 !=3D 0)
> -                       return -EINVAL;
> -
> -               return ltr390_set_gain(data, val);
> +               if (val2 !=3D 0) {
> +                       ret =3D -EINVAL;
> +                       goto handle_pm;
> +               }

Ditto.

And so on. I stop here, because this seems needlessly invasive change.
Just refactor first.

...

> +       ret =3D devm_pm_runtime_enable(dev);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                       "failed to enable powermanagement=
\n");

Missed space.

...

> +static _DEFINE_DEV_PM_OPS(ltr390_pm_ops,

Why _DEFINE_... macro? This one is internal to the header.

> +               ltr390_suspend, ltr390_resume,
> +               ltr390_runtime_suspend, ltr390_runtime_resume, NULL);

--=20
With Best Regards,
Andy Shevchenko

