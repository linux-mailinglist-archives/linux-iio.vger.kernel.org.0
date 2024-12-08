Return-Path: <linux-iio+bounces-13263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D31F9E87F3
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 21:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DC8164110
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 20:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C3192584;
	Sun,  8 Dec 2024 20:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr9mlfHM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB8922C6F7;
	Sun,  8 Dec 2024 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733691526; cv=none; b=Xx0C6D69mKRPJNsgEdyF27qxZrfE3MA6s14MwtALq2ZFW1B0W2hSwQKv/Fk3hJel6HBclxwWsN3F53xI9IREi/VuhHju0aKQySSSfN6l9cRJu+UrzAFHV1U/57wwtxUv5IdRVIgGEGgsoaeG27oSSLYmOLXlhiJ8piHLsWRSrvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733691526; c=relaxed/simple;
	bh=GKayzq++x2cS+3FrrLINdIH83LcmmvWUgLwbjiAYRFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9id3WQaUGd4fvygroPl4srlraPM6I1V5JAuyBSVCkWiBuenw+CgK/4g0jE1SDXvIRmPvrdvMpoYA6Zxn54pbQzTCXHtY8uUJ3be0k7qUKhQ8MrsogZ1KVBAUlVsOHglWT1D0VRmG8hrMKxHMRBKsF+yt7j/+5rIEf8xKNfA+XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mr9mlfHM; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-517ae9ff6e8so86743e0c.3;
        Sun, 08 Dec 2024 12:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733691523; x=1734296323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSUmxLEHdkx0GrZke/5HNOz0bP7VG9LP/qgMQQQuFN0=;
        b=mr9mlfHMmlsynNpkzkrESTSh0y/rsIhnpbia6JHH6T1tMiO0Ad1kYTl5wh/KXg3mCQ
         ABVowR2LwPybOm+I1avWZ5fa1iEeUR0zYR7tmMAnxY5KtowVsdNdy4jJb9TdjQFSDPlO
         1edCHqqFAikDSqom1U0NTf3ttEtveu9Co/0+gblK/C8527ZlqKt5uxbpS4+CtaXZdT3j
         FuD/KRHXGcHsw3yIHMkaUz65PImpPjcYskm71dVxSW39Q4gLBzjBMc8dkYyvHlFrrUnt
         gOAduS5ZSkwKnPL4qIEt+Te5BfLHKcNrjystOGAJg+hE5I+1iNiRYBvxZHapmIoVahp/
         CjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733691523; x=1734296323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSUmxLEHdkx0GrZke/5HNOz0bP7VG9LP/qgMQQQuFN0=;
        b=fQz0oMfr0clrUxUfp9f+rZ1Gj5ePm+3otIGsxd7rMPHcVg1pTHo/G6s6ZTq3q4R6Dv
         a6f/Wg/9sKgTouBZcm2qRQgPjs7y7wCLSkIa+K4j26tdUtVPV+pB8zipSB9FrQ2AvUAq
         OC4Lw9wuSrTFvK0Ilzy5MiwZFqFvHfF2kJw8FZrepB4vQdMMzfYeFFljRh4QPbQ1L0M8
         mdXA6ej+Q8Mkct9KaE3jMNL7G6WZKkR4bOO18x+P/AGW8P60tRopWu/SZK7fpXA5lM+L
         Ddh9CxjO/WRDx9BWrUmbT+LFPhV9i4Bqhy0XMR3fmP1urSK7OrDZlMRo8ByVxbTCq9bo
         Ejqg==
X-Forwarded-Encrypted: i=1; AJvYcCUew7nxPii0AXWWONe9+cugRCIqFzGEkQ/zTclvAtQvGTw33QauppG25HME/SRmPQ16+G2c2Mr+pL1f@vger.kernel.org, AJvYcCV8Dq9CJgUC1hJ57F1MBP75EqpdnPKjTRYb1KRMQoCtS2KZ265FLPQwlZT9/d2zmPM5PNW9kv68mYRL@vger.kernel.org, AJvYcCVTW0ioyv7xF+LgBdXh4/W9n//WL8XdGqDRRBH7yFSYZQzHPk+ioPN/SXLLApqKVKuWh5zzAcYpIiQzVEa6kDgBYiY=@vger.kernel.org, AJvYcCVpIcMKUuope87c+Tp9nJ5SLDkE4eOjGBp4BoujXqJAdD0za2CE3Rv986HuTUwJOV/iCRisdEpzjpHMFI05@vger.kernel.org, AJvYcCWJhwsYKfR17miLYY3tnpfbYu77gBwiEzNzcD3qVGaOotaXWAVBgY2obrOXqV4qPIDjoYNik4DvONHD@vger.kernel.org
X-Gm-Message-State: AOJu0YwKDWRr/YPaojHLEe81sTZJ1oUq1q3gvf9PabI/PUu0Rb3EVOeJ
	CRUXglihFI8XtElA9a+KZG/IfKICFfdtK2h+bYyxaJYDy/XBwL5UPRp9A5FFn000PU1Kte7wxah
	//UQVoT4eLrYbNYTaWDTZmbSTzvo=
X-Gm-Gg: ASbGncump1NnvOFYBP/VrySKPJwZImkN3aGpXai3FJJBQjCMtRqyqRePfcP99VrijLh
	P8kqyAQM9aI22r94Xf5C5I85i3PbOb0TA
X-Google-Smtp-Source: AGHT+IHDmdBmCkEAZodRPPqgsheG4Ok6izy1ZiF8Hgf5nMbWho3dwLhSkv0o3hNSMCvLl3z81HJJjgFWDI8cb6ku1Ck=
X-Received: by 2002:a05:6122:6415:b0:516:1a78:bfb with SMTP id
 71dfb90a1353d-5161a781082mr2615368e0c.7.1733691523705; Sun, 08 Dec 2024
 12:58:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com> <20241206111337.726244-8-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241206111337.726244-8-claudiu.beznea.uj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sun, 8 Dec 2024 20:58:17 +0000
Message-ID: <CA+V-a8t1NRXUhZTM+cK5v-g2EUKDz8GUpSYwXjLqpdMc3c3zNA@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] iio: adc: rzg2l_adc: Simplify the locking scheme
 in rzg2l_adc_read_raw()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com, 
	sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:15=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Simplify the locking scheme in rzg2l_adc_read_raw() by using
> guard(mutex)().
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - used guard(mutex)()
> - adjusted the patch description
>
>  drivers/iio/adc/rzg2l_adc.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 38d4fb014847..953511191eac 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -8,6 +8,7 @@
>   */
>
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
> @@ -220,21 +221,21 @@ static int rzg2l_adc_read_raw(struct iio_dev *indio=
_dev,
>         u8 ch;
>
>         switch (mask) {
> -       case IIO_CHAN_INFO_RAW:
> +       case IIO_CHAN_INFO_RAW: {
>                 if (chan->type !=3D IIO_VOLTAGE)
>                         return -EINVAL;
>
> -               mutex_lock(&adc->lock);
> +               guard(mutex)(&adc->lock);
> +
>                 ch =3D chan->channel & RZG2L_ADC_CHN_MASK;
>                 ret =3D rzg2l_adc_conversion(indio_dev, adc, ch);
> -               if (ret) {
> -                       mutex_unlock(&adc->lock);
> +               if (ret)
>                         return ret;
> -               }
> +
>                 *val =3D adc->last_val[ch];
> -               mutex_unlock(&adc->lock);
>
>                 return IIO_VAL_INT;
> +       }
>
>         default:
>                 return -EINVAL;
> --
> 2.39.2
>
>

