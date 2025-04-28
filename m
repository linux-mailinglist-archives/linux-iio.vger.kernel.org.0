Return-Path: <linux-iio+bounces-18751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD350A9E88D
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 08:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D97188C2D3
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 06:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C4B1D5CC2;
	Mon, 28 Apr 2025 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkz8lfxH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C7E1CAA7B;
	Mon, 28 Apr 2025 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823084; cv=none; b=sagyGtXYR3hSRgJoILoqo7BhuCo1AE9ldI9oAiTJcrc9NCGjCPj8ZvH4VciYeKyvKhtHtn5mKi8T7JlifLoduxcjtkZjetCNMyida+CGAJndwQk6SdUTHqlrWss2fC0Nc12aaszLa595iTB3S7/o3WZflcTawQk55coTtxKyouA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823084; c=relaxed/simple;
	bh=0Pld1a2MzJofAsOTCHr+Q+IIwwPYL7BMWNwta9Ubkk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5dpHuZ5t2jg6frhYfipthbDuOKRfAAvVtR5EtXnptAwRP8Ttpa+DuPQOKpQq1SoYNA+u5KMbUQfydAoyofimfDDB7KyAYvgJHgKuewTgaz3ELZLj4NpWSRZFfl+PTzX9rC6TznCjcoiZ2J0qOi2XSC+XHOpKzWiNQ9RTBYlx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkz8lfxH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso8358760a12.3;
        Sun, 27 Apr 2025 23:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745823081; x=1746427881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi43n4IcBdhVLvOaOx+3iA/0eX/Szd+TDDCfcl8t5Wg=;
        b=nkz8lfxHJ6Ye+bWRMx87WwCsglQh0muZzSXnTQ6fS+ID5tiK+b/anRxurYkzLwr43d
         YoV291U/brDQQ4rZZTJb26t+JCL8is1nVo6AxKyGoq74CddxyCaP4SPh/138j///Ax19
         44ybWR6FIQmLqLbRj3b55H2ipOW8oB1ESvifjgVyRsqyiwz6qUxPVwZYa7FhkKiGEvFL
         iWkbJpN8yqWDplga+K5xHaMgMSRV2ctmD6vso03OI0OG1HFInM/GMlpA/g5RfRKB5/xx
         tKW1It7/OZdsvRra02f4cw6XvZUQilm8Jsi7WIrd0/Itsb7YruVaaLBN8FvqVkJQGbd7
         c07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745823081; x=1746427881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi43n4IcBdhVLvOaOx+3iA/0eX/Szd+TDDCfcl8t5Wg=;
        b=S8foysDNOdegJXUEmDOtllQHfcYGbtyK2HKrvtf9aDA2vcG3MsItL/k/Kj81joDEUM
         idBKmodalGMT2954vLMQDssC7Mx//9h2JhXoVCOb0kjBCnNGuuPwxJptL2D6HLqrMfSS
         WBiRY1mvdrCr5nO6q3imYMf3pBdplupbXVtr4CTyHOYBuFkX1OIn7w2O+pvlrsGfk+0f
         pYMQKGF6PtaEFpyK2mbaB7JJDbuj7V6UTVzN6FDnybXeiFBXfmqeZ3t7/D48qczKk4Cy
         Wt3k5uMR8/dc0TSHzjD/y+jNv7Eb+xFJRtqzL/ca9RVPJ5Ll42r1euqjGzWDFAiC2Pks
         7/zw==
X-Forwarded-Encrypted: i=1; AJvYcCUhJWwJg4qqDSmKC462cK2jTW/5Tm9m4z8uk0mUMLNJBQ0afcbstFG115WqVd15RvGPOOLLIqGG8Ctd@vger.kernel.org, AJvYcCV2soyz6M5BJbZ9u6I9P4R8763S8kO0nD87QQ/1zT9cwGMHBbTk6iLS+5B8FdNrGkk06V9H8fPBSeOIuQ==@vger.kernel.org, AJvYcCXEXZQNNl1L+hbW4n/NX1Pkcr+jijliYU7QCKB8JQ5CwSdtBIEuw/ZdSIoHka6ze9m4tuW/LxcFUF4tLrF7@vger.kernel.org
X-Gm-Message-State: AOJu0YyQoLMJCJCBtRBfMkglT0tvyZiSkvdtcGx3SLmnmnnUogx3L7MU
	APP+wxWuEywQacJmIlq/NyJHY/Px43yFvrJBCAG781ZvnrqW7yC08CJdz/47I+IkuBJP8LH/1Qx
	lYyiKPEOA5eMxxqBPj3goqV82U7A=
X-Gm-Gg: ASbGncvh8J6RXSRiqJKQduqcgHfdY0jKrGivPbhGAvmroxv34WdGDSdsDEnDbTJsKjG
	jdb77vrUtam44QGra8eMtJz1IYvanef4+c2jLPo6KjaqyunOIKcAjBLWvJcfhEtuSuqNKT1u3J0
	PYXsEaTsC5yoPoAxEc1aJztujy
X-Google-Smtp-Source: AGHT+IEkASV0hxNvYb5ls5XU6N8PiOuOxkodobZeYhl/S2nbHHdlz3AJ68sH/k9QmanKndXp09dW/wEfCx6omY9vxHE=
X-Received: by 2002:a17:907:f509:b0:aca:c532:cf07 with SMTP id
 a640c23a62f3a-ace711655e5mr928400766b.35.1745823080557; Sun, 27 Apr 2025
 23:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745605382.git.Jonathan.Santos@analog.com> <2a8a327e589703ee53dbfb5190d20680ac3b350f.1745605382.git.Jonathan.Santos@analog.com>
In-Reply-To: <2a8a327e589703ee53dbfb5190d20680ac3b350f.1745605382.git.Jonathan.Santos@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 Apr 2025 09:50:43 +0300
X-Gm-Features: ATxdqUEBba2M8zExxClBxVqYkvVQ1NpU-dNtSsRR8YiWUveJwNaf_wH1l9SpSQA
Message-ID: <CAHp75VdbD4HTonEZT8O-3bsqQ70_XRnZd7vS7gdyrG2gKYBHPA@mail.gmail.com>
Subject: Re: [PATCH v6 06/11] iio: adc: ad7768-1: Add GPIO controller support
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, andy@kernel.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl, 
	lgirdwood@gmail.com, broonie@kernel.org, jonath4nns@gmail.com, 
	dlechner@baylibre.com, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 3:13=E2=80=AFAM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:
>
> The AD7768-1 has the ability to control other local hardware (such as gai=
n
> stages),to power down other blocks in the signal chain, or read local
> status signals over the SPI interface.
>
> Add direct mode conditional locks in the gpio callbacks to prevent regist=
er
> access when the device is in buffered mode.
>
> This change exports the AD7768-1's four gpios and makes them accessible
> at an upper layer.

...

> +#include <linux/gpio.h>

No way. This header must not be in any of the code. (Yes, there are
leftovers in the kernel, but work is ongoing to clean that up)

> +#include <linux/gpio/driver.h>
>  #include <linux/gpio/consumer.h>

>  #include <linux/kernel.h>

And since you are doing the big series for the driver, please drop
this header and replace it (if required) with what is used. No driver
code should use kernel.h.

>  #include <linux/module.h>

...

> struct ad7768_state {

>         struct regulator_dev *vcm_rdev;
>         unsigned int vcm_output_sel;
>         struct clk *mclk;
> +       struct gpio_chip gpiochip;
>         unsigned int mclk_freq;
>         unsigned int samp_freq;
>         struct completion completion;

Btw, have you run `pahole`? Is this the best place for a new field in
accordance with its output?

...

> +static int ad7768_gpio_set(struct gpio_chip *chip, unsigned int offset, =
int value)
> +{
> +       struct iio_dev *indio_dev =3D gpiochip_get_data(chip);
> +       struct ad7768_state *st =3D iio_priv(indio_dev);
> +       unsigned int val;
> +       int ret;
> +
> +       if (!iio_device_claim_direct(indio_dev))
> +               return -EBUSY;
> +
> +       ret =3D regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &val);
> +       if (ret)
> +               goto err_release;
> +
> +       if (val & BIT(offset))
> +               ret =3D regmap_update_bits(st->regmap, AD7768_REG_GPIO_WR=
ITE,
> +                                        BIT(offset), value << offset);

And if value happens to be > 1?
Also consider the use of regmap_assign_bits().

> +err_release:
> +       iio_device_release_direct(indio_dev);
> +
> +       return ret;
> +}

...

> +static int ad7768_gpio_init(struct iio_dev *indio_dev)
> +{
> +       struct ad7768_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       ret =3D regmap_write(st->regmap, AD7768_REG_GPIO_CONTROL,
> +                          AD7768_GPIO_UNIVERSAL_EN);
> +       if (ret)
> +               return ret;
> +
> +       st->gpiochip =3D (struct gpio_chip) {

> +               .label =3D "ad7768_1_gpios",

What is '_1' for?
Also, what will happen if the device has two or more such ADCs
installed? Will they all provide _the same_ label?!

> +               .base =3D -1,
> +               .ngpio =3D 4,
> +               .parent =3D &st->spi->dev,
> +               .can_sleep =3D true,
> +               .direction_input =3D ad7768_gpio_direction_input,
> +               .direction_output =3D ad7768_gpio_direction_output,
> +               .get =3D ad7768_gpio_get,
> +               .set_rv =3D ad7768_gpio_set,
> +               .owner =3D THIS_MODULE,
> +       };
> +
> +       return devm_gpiochip_add_data(&st->spi->dev, &st->gpiochip, indio=
_dev);
> +}

...

> +       /* Only create a Chip GPIO if flagged for it */
> +       if (device_property_read_bool(&st->spi->dev, "gpio-controller")) =
{
> +               ret =3D ad7768_gpio_init(indio_dev);
> +               if (ret < 0)

Why ' < 0'?

> +                       return ret;
> +       }

--=20
With Best Regards,
Andy Shevchenko

