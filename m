Return-Path: <linux-iio+bounces-18083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 240DCA8858D
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 16:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7B01673FE
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 14:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDDE2951C8;
	Mon, 14 Apr 2025 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWlt2Eto"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3631B27FD5A;
	Mon, 14 Apr 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640737; cv=none; b=sa3PpRbIuGgr1xKY+I1njEeYB57iqAeVf6e75ymbJS7v5S6Xf4iJ8Jw13d5Oafsbp5OWqxks0zMIHRNOUBXxojiyYyswC+r4kTqWyUK0kq9xqWRbzvj5uZBIIxrkQZTsmjlCKsf3BtM96jig+SSGL4h1waGKVsNeS7c2Cv0oB0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640737; c=relaxed/simple;
	bh=4M1D99PAVqvZi96MOYQWeD6ZcQwnEQ4Bpbi2arizon8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLdPWbhTAV5FcK0Ewc8DH/kYtBHOy8qeoWqGfbh1Y7o73MGOVuHFYWn2mRbPwRIR6uRUdnun9rD0tXjGFeFpEC0Qjipu0hRkAYlP7A1FLX8pFcSI1MG5qQouJxubirHRwrWmISJS8uR30cnMUmrVqMu41a5zWzzDciaHwfgpsTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWlt2Eto; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac289147833so882154766b.2;
        Mon, 14 Apr 2025 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744640734; x=1745245534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+i03KpPoesYplL/qUIjpUO++rCb/s/V2SLn3HX44rs=;
        b=WWlt2EtoJrK2pDfD+x91wBOv3XwvN4eLM9mCpehMWB10GPGRoV90RRM1wXA66mHoBs
         waZ/UjxtcYoDDgE4J/XM7L3d3Wh0IgqasczzFTY3VacJ9osYR3zw9pSGLSkzFE6DvxiV
         d8CPN+3hCc6Ruhq9ySTR63cfDzdRtUQHUveVXWZodyRKwS8LZFc3UHvXD7JNKiCrIIk9
         1kV4TyJE2U0dzRJI5pyZf2MCV/wE+BG/N3XXnqMNHLfTPQPSBwyMkYvhRrZBdSYxo8x3
         bf3eMTtvAyNhamPq9POi8hO58cA4OIkSM8B0TBQFI6h5iM2/H7eaJyu0CZTpTcQ6tov4
         7VhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744640734; x=1745245534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+i03KpPoesYplL/qUIjpUO++rCb/s/V2SLn3HX44rs=;
        b=tDMMFLSb9a2QgCiwLmPrLFBkHcIEfnzuuDAlais4Z9czFQF2V9ZMSp+tVHZEVdC0xt
         6v0J6hX3quzweGcQFDgPr9R14VNUt1e4m+0AX3SmiKhKXY6p14uwQonA4QNeMHIo4yKK
         ZkU3BAAw8lGk6O3eou7lmVaAcDkXKPyewjQ+/gYXsbeAVfSboZv4EOotwgR5Z6c61l9j
         XbYjuFO3PUYjiGOmNxqk3U06E92/D9NV8sniU+Ug/dae00wWM8u2bhqGukLcN/X6df3b
         x9fGoBvqafkh+j8KV/U98k+2xV6/6FzDLHCrBbHL8Sk2KRHZ1uO4eLGcO4CEM/hjGJ1P
         iT7w==
X-Forwarded-Encrypted: i=1; AJvYcCWVQTNFG1bqc4sgt0XHzWeU5QM/7l04KTYiI2sCR2bted/liyhUtoLW7dcHn1dhy7AitPIMqLUDL6Dv@vger.kernel.org, AJvYcCWq5nreiIj/ZQA6XllMTYgQpr+n985HuusVpBh8uu2dpOte3qy3WH4DAM3wEVb1n4DoS8eE63e5W0t/jJRl@vger.kernel.org
X-Gm-Message-State: AOJu0YzFHEoNAwzoP7VllRDRxSNkkTEsjclxRi8wGt0G2IiMjt4kPiA8
	HXxxf/pgCqT7oaqVivYhwcafM451O9Ioxc8Na/Vd3pRHNCUofjEbjmKQQvHYDyZJsjkhtd4zFBj
	H+EzEZIDlAxuWgSSR6MJmtrF7kOJGvksuqEI=
X-Gm-Gg: ASbGncu3Yy7b3E9DLtoblhQ15KzkLT/1kG7AU2YkGq5xNZGNyLJzDNpx4/srhKjyuQc
	lcElPwQjkWojdtkLK9JWYuAMPjOUJbI4zuyazslfWSMoTwii1DkDJqeidUfB1DwwJqYH+iBvGUV
	LYU0H/3i4WRyyB9g/u0FkdPw==
X-Google-Smtp-Source: AGHT+IEYDHe/CyayPDTDqvHH4oIbkb5IHFVr7IgvWmBdzKWAYSHg3a4OGWTd63RP+MkrvE177Dbl49YlDHB/xdWMl9k=
X-Received: by 2002:a17:907:7e81:b0:ac3:3d10:6f with SMTP id
 a640c23a62f3a-acad345696fmr932095366b.8.1744640734274; Mon, 14 Apr 2025
 07:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744200264.git.marcelo.schmitt@analog.com> <247566f848cdf2a245a8b6da6a84c22e155beeb7.1744200264.git.marcelo.schmitt@analog.com>
In-Reply-To: <247566f848cdf2a245a8b6da6a84c22e155beeb7.1744200264.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 Apr 2025 17:24:56 +0300
X-Gm-Features: ATxdqUGWdI8hC2QgSnrOE_-PLsI5VnqZbkBRp-jyeE-Ur815irq6_hSV1BgqeX8
Message-ID: <CAHp75VfyZ-f+KMVjyFVMitmQA65enJwHV+nBdC=XqE_Pz5cP1g@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] iio: adc: ad4170: Add GPIO controller support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 3:26=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> The AD4170 has four multifunctional pins that can be used as GPIOs. The
> GPIO functionality can be accessed when the AD4170 chip is not busy
> performing continuous data capture or handling any other register
> read/write request. Also, the AD4170 does not provide any interrupt based
> on GPIO pin states so AD4170 GPIOs can't be used as interrupt sources.
>
> Implement gpio_chip callbacks so to make AD4170 GPIO pins controllable

callbacks to

> through the gpiochip interface.

...

> +static int ad4170_gpio_direction_output(struct gpio_chip *gc,
> +                                       unsigned int offset, int value)
> +{
> +       struct iio_dev *indio_dev =3D gpiochip_get_data(gc);
> +       struct ad4170_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       if (!iio_device_claim_direct(indio_dev))
> +               return -EBUSY;
> +
> +       ret =3D regmap_clear_bits(st->regmap16, AD4170_GPIO_MODE_REG,
> +                               BIT(offset * 2));
> +       if (ret)
> +               goto err_release;
> +
> +       ret =3D regmap_set_bits(st->regmap16, AD4170_GPIO_MODE_REG,
> +                             BIT(offset * 2 + 1));
> +
> +err_release:
> +       iio_device_release_direct(indio_dev);
> +
> +       ad4170_gpio_set(gc, offset, value);

This is incorrect ordering, you will have glitches. Can you set the
value beforehands? Or is it broken hardware?

> +       return ret;
> +}

...

> +static int ad4170_gpio_init(struct iio_dev *indio_dev)
> +{
> +       struct ad4170_state *st =3D iio_priv(indio_dev);

> +       st->gpiochip =3D (struct gpio_chip) {
> +               .label =3D "ad4170_gpios",
> +               .base =3D -1,
> +               .ngpio =3D 4,
> +               .parent =3D &st->spi->dev,
> +               .can_sleep =3D true,
> +               .get_direction =3D ad4170_gpio_get_direction,
> +               .direction_input =3D ad4170_gpio_direction_input,
> +               .direction_output =3D ad4170_gpio_direction_output,
> +               .get =3D ad4170_gpio_get,
> +               .set_rv =3D ad4170_gpio_set,
> +               .owner =3D THIS_MODULE,
> +       };

I think it would be better to have it field by field initialised.

> +       return devm_gpiochip_add_data(&st->spi->dev, &st->gpiochip, indio=
_dev);
> +}

...

> +       /* Only create a GPIO chip if flagged for it */
> +       if (device_property_read_bool(&st->spi->dev, "gpio-controller")) =
{
> +               ret =3D ad4170_gpio_init(indio_dev);
> +               if (ret < 0)

< 0 ? What is the meaning of the positive values that you expect from
this function?

> +                       return ret;
> +       }

--=20
With Best Regards,
Andy Shevchenko

