Return-Path: <linux-iio+bounces-22687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F1CB251ED
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 19:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8791B1895CCB
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 17:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08E9303C9E;
	Wed, 13 Aug 2025 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSHOzGym"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A909303C80;
	Wed, 13 Aug 2025 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105297; cv=none; b=QoykQudwY0XfAVYACKAjQZ0k+9fzk60NRYolJjKiz0wEBCMywoh1F+PR1iRA5X7iynGlLUniHFe7PSXrBnSvOLRa3LLE/ABxOT750yYzWbvRz12EVPB+/z6LhJygopXQSMhFm+Sxr+mYWuR3cTpsEp6VYPpY6/A3XKG60SC1MZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105297; c=relaxed/simple;
	bh=mayIuz9FzEfxwkOtICI3sdZAkR5purWvcUkLFWa/lws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YU9+Yf0R5zfbNs8wigtg3JsWsbOObkUg5ZpqM7dfolyBVO3040JpWVxr19nK2tXWjlavukVP7HjRaLsk9EBCudE5RSvnsLVGKirANALN+UtU09dqOiUjQErpwnCAvZDMzB4IwBPRpQYJq8sHAvtkCrFgwhsCFB9OCfFJgTjCxTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSHOzGym; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b733bbaso41779a12.3;
        Wed, 13 Aug 2025 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755105294; x=1755710094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idv2l4uN3E5LeMu5nrAfJ4xtwBVCw+9su/hvj8uID+Y=;
        b=CSHOzGymfW8CmygVvdbZ6y+W7F4GUQ89MvyVvsOXhPMx8GQq/SCVvTBs5xCPUY6UzX
         IQ0tv7QTM22gvMw4yNa6MSlVu+aC6SC/5wMuR4D7VUVDrvHlKDnY8rKp8mDcW3RhkoEs
         +65gSMspMMgESTJ8BRIgV7sQPrSIXN8j/VHzXtB2jDQ1BqvniQ7XGFUNsXDuXy1hVYmV
         ewd46l8l0fV616In6gfxJQq5rDjEx8HRgZuEFafi8kruyTsmdMYbTTntu15672On3Dvx
         nzeWvlEr/NBybKFtnSA/NKenBjNCW+eKtiQcCyCUEec/59EYneR1wOTkj8Eui1aBf8qu
         aaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755105294; x=1755710094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idv2l4uN3E5LeMu5nrAfJ4xtwBVCw+9su/hvj8uID+Y=;
        b=OBo0k71wjRQgOUxhVaY01qcx3n7OsDPv/I+NFijM/kdvMl/L3PgwQ9z4V0XuN00yZZ
         raTvsgm7Hq/qxATMSSMCybwyfoa7i8VDvcilyJJZBGEf0JvzPDLdG8C6ogECubF2HW3u
         YoOuyEoXm1uJ1WPCJfH2X24fAMG0etrEXwEPwdwSnz3NyydCyrb64s8tF84RV4UDVcXp
         kYUveNylZh3rOanhHgzNlbzdAe8fId+nEIOO95yha7FibNRcsZTLbueh0v5HNVwy3QqO
         ug7hE+qHGZlrxIJ2JUqKMKX8dAf8uiN6uigO/JyMpEtiOGWqFPnceQe1unPtJjUnp+JV
         /TUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/PFCFhe3JTI56C9GRPnBv1L7JKWPfvn1VCkY2Rjmoh/YBS49eoOQcguOv1LJvdCl5yKMTefulW5Sc@vger.kernel.org, AJvYcCUgkzJnmimy8BxjZJS62vnPtiGlcbDn95tzyaNRB7OCxv//DR6VAOT0+SlqyrgqeStDE+adjjYaggHq8kbM@vger.kernel.org, AJvYcCV3oqOkEOVe0ZaiqQcFmPwhZUfbNaKVvCoTYS71g//bRgca566H81lTa4qgNoq1JL8gfB7UJMifaSYU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6gMfSEGddUnASLw9I91RW0NXBU0ZY861RhBREUvMPmLBc46Ve
	HBtefOLxmXG+AAsdNDaAQjBrhB/bEIOMOpXbmekAwEkOvvelpiCWEBfvAHKBHgfN1aUbdkT/4cc
	IEL5Og3VxyQqSAP4fWj5IHutCZx+L90Q/oxWdev0=
X-Gm-Gg: ASbGncs/bW3Q6JP8+5hw+hvtvsx4FXHJIXa+/ui0lCoEWf0j22xaW7hVR0H8UFFU2Qj
	rnjbj7u8qF+k2Y7YmE28LhVbQbvtvE2015FunbRUwULKK3peVK6H8TK9wumnJSPVZ/4wJmMyERA
	shN7d8+hxSXVdKZC59p+S7FXvp/9aUvexrN6Nkyxdur0TBpiQ/VHBBaLl8EMyROjVYCvoiluih1
	di4IB0Flw==
X-Google-Smtp-Source: AGHT+IEEaW5NQ17RU/qBGIIHWUT0gBVYzKWm68IoRLIJqhhFjjweabCQgEX2CBSgxZ95HJ7DLuEy1rRqeGLgOVi8VEU=
X-Received: by 2002:a17:907:7e9f:b0:afa:2772:68fd with SMTP id
 a640c23a62f3a-afca4e4a6ffmr319672866b.44.1755105294292; Wed, 13 Aug 2025
 10:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-ltc2495-v2-0-bbaf20f6ba07@gmail.com> <20250813-ltc2495-v2-3-bbaf20f6ba07@gmail.com>
In-Reply-To: <20250813-ltc2495-v2-3-bbaf20f6ba07@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Aug 2025 19:14:16 +0200
X-Gm-Features: Ac12FXyfk41V0ky5AzgSd3wHpnabIo-HVoBXAkojCjgiZVqIe6CNdrA400Vs1UQ
Message-ID: <CAHp75VfM6WzNCT=ihN=wkaY0dQwjnJ0VLSyaGVbhCw4Lg-aXAQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: adc: ltc2497: add temperature sensor support
To: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:54=E2=80=AFPM Yusuf Alper Bilgin
<y.alperbilgin@gmail.com> wrote:
>
> Support for reading the internal temperature sensor on LTC2495 and
> LTC2499 via a standard IIO temperature channel.

...

> +#define LTC2497_KELVIN_TO_CELCIUS      273

Drop it, see below why.

...

> +               *val =3D -LTC2497_KELVIN_TO_CELCIUS * ddata->chip_info->t=
emp_scale_mV;

Can you use kelvin_to_celsius(0) from units.h instead?

> +               *val2 =3D ret / 1000;
> +
> +               return IIO_VAL_FRACTIONAL;

...

> +#define LTC2497_T_CHAN {                                                =
                       \

It's better to locate { on the new line.

> +       .type =3D IIO_TEMP,                                              =
                         \
> +       .channel =3D 0,                                                  =
                         \
> +       .address =3D (LTC2497_ENABLE_TEMPERATURE_CONV),                  =
                         \
> +       .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),                  =
                         \
> +       .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_=
CHAN_INFO_OFFSET),       \
> +}

...

> +       LTC2497_CHANNELS,

Seems like a terminator, so add _MAX in the middle and remove the
trailing comma.

...


> +static const struct iio_chan_spec ltc2497core_channel_with_temperature[]=
 =3D {
> +       LTC2497_CHANNELS,
> +       LTC2497_T_CHAN,

(Same as above may be applied to _T_CHAN, but I haven't seen the enum
to be sure)

>  };

...

>  struct ltc2497_chip_info {
> -       u32 resolution;
>         const char *name;
> +       u32 resolution;

Perhaps above deserves a separate change (with the `pahole` summary),
but I don't care as it's a little change here. Leave this to Jonathan
to decide.

> +       /*
> +        * Represents the datasheet constant from the temperature formula=
:
> +        * T_Kelvin =3D (DATAOUT * Vref) / temp_scale, where Vref is in V=
olts.
> +        *
> +        * To allow the driver to use Vref in millivolts for the calculat=
ion
> +        * and also to avoid floating points, this stored value represent=
s the
> +        * datasheet constant scaled by 1000.
> +        */
> +       u32 temp_scale_mV;
> +       bool has_temp_channel;
>  };

--=20
With Best Regards,
Andy Shevchenko

