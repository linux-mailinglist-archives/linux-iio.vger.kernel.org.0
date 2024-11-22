Return-Path: <linux-iio+bounces-12520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA6F9D64E5
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 21:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90823282B92
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 20:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C381714B9;
	Fri, 22 Nov 2024 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1hvtttw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1D19BBA;
	Fri, 22 Nov 2024 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307506; cv=none; b=iEJE5C9jCwGjDgKb0R7mcCeC6q6RRXuDXxFG7m90tbe29v1cIDV1JK0dfRUwYv4kR2FmSsNLRHs4esqFLYczhrZmkuv7rw2BxkAJV1yXAhdoXO7ww0ZGixF8NfXKXOySfq/RQVH8FSsmcFjq8uOnEdsRZQgT2a4UZj0/9ZcK15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307506; c=relaxed/simple;
	bh=ziLbRXnJ0wfwY3lRozK7HsbN69rHAIv4Er5fi6E+OYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8ALR9/CQKuhwbMMPl0bCAkMnCc/87jRuFyZsx499RouZ0XDkzTQireFVmNdUa5jxE3NirCbiiDfxnKJLC0jNs5OX8F3JYjbQIO3812ADmT7CRu0t+ywENcJyVdLXksTNPSNQIXl3LRw4LM7CS72E/Q7YNTBIj8BkWppbxa3QXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1hvtttw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9aa8895facso415163766b.2;
        Fri, 22 Nov 2024 12:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732307503; x=1732912303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmnBXSE8iY0Ad9o08V6iIIwsqy152a2FyVrZuxwevQ8=;
        b=T1hvtttwpd0R/Vw7Lqumz3HsuJB8XfCSGKxLYVtvLNC2888CtzH9dUo8TLZyjlH8XS
         /h1R5RNpk/c4IE8l7GTzcC86mpnvJvzSgG5LJVPV3HrOYV/J88VVEFPnFQGu9VWhNIJo
         bKtyDYblgPR8e73jRk/5pzKlt4qLuETloBzDsVGJuVl/PMJgwM+7O79hnal8sZYPAkOU
         lLntuMHESl3WSbyAb0stHxleSvsodtXa6HL2b/P2i0Ks2nI0RLgpRFJI3sN9fGLTgIJu
         +pO8X+NEAotcIx/Oieeb/Hj9Cs4CX3vQsPSxK7AVu2FEaTw7HPCJ93Dc8bl2xAswkxpd
         1a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732307503; x=1732912303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmnBXSE8iY0Ad9o08V6iIIwsqy152a2FyVrZuxwevQ8=;
        b=mYhD0+KUUpwkxbHBnyLycROXfgTpyOAsyx+WJn3+WIVRWQIfBgH2PWUU5RgWSIfxH3
         9LAaFcGRbqbo9csDwLhtqEv6TuRY8txFEXBR8IaLdgaDpibKjQaFla6OOT/7klESE9JP
         g8EOmu+Ysp61UZEK/EoSxSNfdfSUG4Rg0jfzA2mGvE+2W7n61xizH+lW/r9eitApEHw5
         LLHZnPWSXF7/rlFpfuBzoc9fo8hBQE2NFxxhvabnam6D250K7bIQgplkAOldTTlCHivZ
         EgCXnbqGFTPUVgsvonMQ5UlPpfgtqGcgNTyW7lNPOCsHE0PHvfb+S7neeZIU8fVZifln
         NdRg==
X-Forwarded-Encrypted: i=1; AJvYcCU1n116o84p5rqDHpjFFAITtfcbXzN825J2x8Y3DNixbAAF/x84lazO0zTyqGD4DJQ2t7Kh85kt5lmt@vger.kernel.org, AJvYcCVXS5rSS63iOBRGG0zjpuuu+se6xlbVutTCTvssUGOCWzKmAjfjq899G1QRexl3gmUn4kfad5BwwyRr@vger.kernel.org
X-Gm-Message-State: AOJu0YwVoE/Jx9Zl6fHpWdpHwcJ2ic7hdgDs3epCBa8wciyFB0FQJBEw
	5z6YOEWDb3JF5Zg4y6Gz5UxF77vk19thrrRiViNelK1brNhmKBNVuOA3gDPmuAIwnsqibYPwety
	CMB2pY1mipKrTFsAKH5M6JJczAGD4/6cb
X-Gm-Gg: ASbGncsgel40mCuupQLb9E148cEFZleW1oYBt6rVoSp5H9VUUfmwvcxm321IYo5YTiM
	3C8n4lvPLplsd04YmvpcOTSotDHsmA8A=
X-Google-Smtp-Source: AGHT+IEMX7l3kmvBT5zLl6Dn6D/OfJ6qovwkrG3C4P8rCZkfC8J31ArmeP1T8WC6vX8b4E/O7uBiV1Ud6UQoylRgKok=
X-Received: by 2002:a17:906:30cb:b0:aa5:2232:c8e4 with SMTP id
 a640c23a62f3a-aa52232c9b4mr147437366b.11.1732307503336; Fri, 22 Nov 2024
 12:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com> <20241122113322.242875-22-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241122113322.242875-22-u.kleine-koenig@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 Nov 2024 22:31:07 +0200
Message-ID: <CAHp75Ve_sD-a-m4pYmKrT=LhajO=F7TG7KM7AsM47J0=ksVgNw@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] iio: adc: ad7124: Implement temperature measurement
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Alexandru Ardelean <aardelean@baylibre.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 1:34=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> If the maximal count of channels the driver supports isn't fully
> utilized, add an attribute providing the internal temperature.

...

>         case IIO_CHAN_INFO_SCALE:
> -               mutex_lock(&st->cfgs_lock);
> +               switch (chan->type) {
> +               case IIO_VOLTAGE:
> +                       mutex_lock(&st->cfgs_lock);

Side note 1: cleanup.h at some point?

...

>         case IIO_CHAN_INFO_OFFSET:
> -               mutex_lock(&st->cfgs_lock);
> -               if (st->channels[chan->address].cfg.bipolar)
> -                       *val =3D -(1 << (chan->scan_type.realbits - 1));
> -               else
> -                       *val =3D 0;
> +               switch (chan->type) {
> +               case IIO_VOLTAGE:
> +                       mutex_lock(&st->cfgs_lock);
> +                       if (st->channels[chan->address].cfg.bipolar)
> +                               *val =3D -(1 << (chan->scan_type.realbits=
 - 1));

Side note 2: BIT() ?

...

>         case IIO_CHAN_INFO_SAMP_FREQ:
>                 mutex_lock(&st->cfgs_lock);
>                 *val =3D st->channels[chan->address].cfg.odr;
>                 mutex_unlock(&st->cfgs_lock);
>
>                 return IIO_VAL_INT;
> +
>         case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>                 mutex_lock(&st->cfgs_lock);
>                 *val =3D ad7124_get_3db_filter_freq(st, chan->scan_index)=
;
>                 mutex_unlock(&st->cfgs_lock);
>
>                 return IIO_VAL_INT;
> +

Seems like stray / unrelated changes. Do you really want to combine
this with style changing? Usually we either change style first
followed by featuring, or vice versa.

>         default:
>                 return -EINVAL;
>         }
> @@ -645,6 +685,7 @@ static int ad7124_write_raw(struct iio_dev *indio_dev=
,
>
>                 ad7124_set_channel_odr(st, chan->address, val);
>                 break;
> +
>         case IIO_CHAN_INFO_SCALE:
>                 if (val !=3D 0) {
>                         ret =3D -EINVAL;
> @@ -666,6 +707,7 @@ static int ad7124_write_raw(struct iio_dev *indio_dev=
,
>
>                 st->channels[chan->address].cfg.pga_bits =3D res;
>                 break;
> +
>         case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>                 if (val2 !=3D 0) {
>                         ret =3D -EINVAL;

Ditto.

...

> +       /* Add one for temperature */
> +       st->num_channels =3D min(num_channels + 1, AD7124_MAX_CHANNELS);

Is the type of both arguments the same?

--=20
With Best Regards,
Andy Shevchenko

