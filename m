Return-Path: <linux-iio+bounces-17593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1601FA7A21C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 13:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4801891A16
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B16B24293D;
	Thu,  3 Apr 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NoZEQAO7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B588F1F63CD
	for <linux-iio@vger.kernel.org>; Thu,  3 Apr 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743680762; cv=none; b=kjsyTBZBxp4TWg4yFQsBe8OdiKpHQ/eQHmlQEQc0uwFEd9SCr+zKnRzrep+1cwWULb5lfWCZGVGdSkvI790kZ6XGzwH+pI34rewUUUyl+fSTkH3c/eAwj4Azn2OO3F5qCta7a9bQs+PRYI4KejjXhGiMKDyqWFX4SA8URI3toUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743680762; c=relaxed/simple;
	bh=6seZVMT4mxgUw2pvw23TXxODsiaG8bqs2GuUNLWPHfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSxC9jwrOBQmyORHqaV/3SFb0ZX6jRZM8sWv98i1BGKjv2RIadMZGD6GIdJ2I5XAhwQkHTUbyW6CWakk9IFuFftKuQ4PAGZjh1cAVxzqS2BB/+3m6KS2JL5p5YC9u/vmPr7ah5t2YYNSpH+LyEsXUMaZCzHiLAAgZG6oMZyoj+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NoZEQAO7; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso125903566b.3
        for <linux-iio@vger.kernel.org>; Thu, 03 Apr 2025 04:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743680758; x=1744285558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xT0elqA6Ab35N4vIgDBgG0DeM4CG/y6atakTcDGWwVY=;
        b=NoZEQAO7c8wzygUE1SPK8/X/r8K/LGLGO2dhpAxNUWSzn5XtszJnaaiGQ4unlVDXv5
         ONsFyJgAA0/HrnCUWQR0zKTz7tFYwHkc/mjG1TEUsB/u0EXEqEq8z17dz3qlDDR49rsA
         Gcjz024pgSbXCBcx6rIPUR8gV1Zx4g0QADjc2mjJ8yoHhndQtENB/hTDjF/kliRkyBSD
         8nbPGJWMnyo443urzDXOMlML+Dw0udz8uIV2xjwyrowWe1VTW5jWRHj1Vf+FIGn1W0F1
         2GXYV2PdkYVwlZpv/CSASob6oCa6iGdUA9ScrCfrnuhYO1lYGDrd4Db5E+i6dscaPf/F
         UlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743680758; x=1744285558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xT0elqA6Ab35N4vIgDBgG0DeM4CG/y6atakTcDGWwVY=;
        b=DKHzWc2J4NbCcwkB7KeUoI7nWeibughhdUKuYDXxhNEKlDUs/TEnlc8boFuNVZ35Wa
         4dsnQtmZEmKh2/K6AWdVRU/T+6RS/VDfKMkpDwDugyV4Woz9/b7nMla+MPdPF+KOHZLz
         9Sv6t56pfTmFvE/m5VAyaUu4Yn6G9fWzkWex/pgnYotprs23QPY0jxjjgPgH2UAEL9OQ
         FyCMTnaEVI8R2+g+30JQ1Vfj/rN10Z6RBFjzWpteeBO4lId2gl1YTtK2OyPS9iSfE3Qk
         QnVG+XG4/UJUtJlWgZES4smYbkCdl9A/s7Y8Rk+ycsaD+cpxxt/e0VqDrrAd8gLBJrre
         c0fA==
X-Forwarded-Encrypted: i=1; AJvYcCXvtXph8bkgJCvsUQNmfO0TLabOmxSx7500SpU3RxWXOLFIIgKjxuMub7MpvmymGrVgQWWmxJ4JwAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/lBLGG3OhhdCkaj7Dd2YIkJKaYlM5sQ7Eg8qWntFVMwLEtuC0
	DM7Nnt0shcPvg+dxJ3kB6kIRqzTPVupqonQtFDhRtrDAxtO+aBaAZuhoR4Z/9p7d1NqUGoM1CvA
	5/KBV4r1iZgwghfut8WSbupirUyBXCf+DEWJ6YA==
X-Gm-Gg: ASbGncvIaeWQ0y3oSfpoH300+FXwPcsLLdHmAh36Au7Y+AJ+zpNB8Re+dBi7iXEMpGo
	26tzbv47NBQwZc2lU5jjt55SKE8PUVo24Hez1KxXtWfrB9Y+goqO8ThHfIHECJmjnp9Nh08xUc+
	9jEzbPmxUb+alTt3acoVARjga4vFHk8jMIHSVzDcb1tu5GkBZ4N8xHyLCTt7k=
X-Google-Smtp-Source: AGHT+IFEoSrJqV3CuTWmq5VUsEKTKD2aQ7X1u8XmIfa8FBxx9myROHVSeAT9MVg3SGJ6Q068sZDIjLAYp1E/afFvhsQ=
X-Received: by 2002:a17:907:2cc5:b0:ac6:d142:2c64 with SMTP id
 a640c23a62f3a-ac7a16c1272mr538034766b.18.1743680757983; Thu, 03 Apr 2025
 04:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402-iio-adc-ad7380-fix-event-threshold-shift-v1-1-ad4975c296b2@baylibre.com>
In-Reply-To: <20250402-iio-adc-ad7380-fix-event-threshold-shift-v1-1-ad4975c296b2@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 3 Apr 2025 13:45:41 +0200
X-Gm-Features: AQ5f1JrIaOCDhWTTME3ilw0spgYzdZsMYgvmtZS5ARs3HjvqzcXVm1pdZCCYC84
Message-ID: <CAEHHSvbt7v7OCbW4PEwgop74n_5NW8Una1-R3w3yUqu8-22=Dg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7380: fix event threshold shift
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 3 avr. 2025 =C3=A0 01:56, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> Add required bit shift to the event threshold read function to get
> correct scaling.
>
> When alert support was added, the write function correctly included the
> required shift needed to convert the threshold register value to the
> same scale as the raw ADC value. However, the shift got missed in the
> read function.

Hi David,

Thank you for fixing that. LGTM

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

>
> Fixes: 27d1a4dbe1e1 ("iio: adc: ad7380: add alert support")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad7380.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 4fcb49fdf56639784098f0147a9faef8dcb6b0f6..f3962a45e1e5b88cebf712cc8=
67fbb576d3ca058 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -1611,11 +1611,25 @@ static int ad7380_write_event_config(struct iio_d=
ev *indio_dev,
>         return ret;
>  }
>
> -static int ad7380_get_alert_th(struct ad7380_state *st,
> +static int ad7380_get_alert_th(struct iio_dev *indio_dev,
> +                              const struct iio_chan_spec *chan,
>                                enum iio_event_direction dir,
>                                int *val)
>  {
> -       int ret, tmp;
> +       struct ad7380_state *st =3D iio_priv(indio_dev);
> +       const struct iio_scan_type *scan_type;
> +       int ret, tmp, shift;
> +
> +       scan_type =3D iio_get_current_scan_type(indio_dev, chan);
> +       if (IS_ERR(scan_type))
> +               return PTR_ERR(scan_type);
> +
> +       /*
> +        * The register value is 12-bits and is compared to the most sign=
ificant
> +        * bits of raw value, therefore a shift is required to convert th=
is to
> +        * the same scale as the raw value.
> +        */
> +       shift =3D scan_type->realbits - 12;
>
>         switch (dir) {
>         case IIO_EV_DIR_RISING:
> @@ -1625,7 +1639,7 @@ static int ad7380_get_alert_th(struct ad7380_state =
*st,
>                 if (ret)
>                         return ret;
>
> -               *val =3D FIELD_GET(AD7380_ALERT_HIGH_TH, tmp);
> +               *val =3D FIELD_GET(AD7380_ALERT_HIGH_TH, tmp) << shift;
>                 return IIO_VAL_INT;
>         case IIO_EV_DIR_FALLING:
>                 ret =3D regmap_read(st->regmap,
> @@ -1634,7 +1648,7 @@ static int ad7380_get_alert_th(struct ad7380_state =
*st,
>                 if (ret)
>                         return ret;
>
> -               *val =3D FIELD_GET(AD7380_ALERT_LOW_TH, tmp);
> +               *val =3D FIELD_GET(AD7380_ALERT_LOW_TH, tmp) << shift;
>                 return IIO_VAL_INT;
>         default:
>                 return -EINVAL;
> @@ -1648,7 +1662,6 @@ static int ad7380_read_event_value(struct iio_dev *=
indio_dev,
>                                    enum iio_event_info info,
>                                    int *val, int *val2)
>  {
> -       struct ad7380_state *st =3D iio_priv(indio_dev);
>         int ret;
>
>         switch (info) {
> @@ -1656,7 +1669,7 @@ static int ad7380_read_event_value(struct iio_dev *=
indio_dev,
>                 if (!iio_device_claim_direct(indio_dev))
>                         return -EBUSY;
>
> -               ret =3D ad7380_get_alert_th(st, dir, val);
> +               ret =3D ad7380_get_alert_th(indio_dev, chan, dir, val);
>
>                 iio_device_release_direct(indio_dev);
>                 return ret;
>
> ---
> base-commit: f8ffc92ae9052e6615896052f0c5b808bfc17520
> change-id: 20250402-iio-adc-ad7380-fix-event-threshold-shift-b614db1a307f
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

