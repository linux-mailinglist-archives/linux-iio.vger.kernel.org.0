Return-Path: <linux-iio+bounces-23183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85146B33267
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 21:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D41E480B3A
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 19:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD24221277;
	Sun, 24 Aug 2025 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvrbHFgn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EA37260B;
	Sun, 24 Aug 2025 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756064644; cv=none; b=ceODhFBt7ZZBiEYDI69M6G/Dh02Tah0wLuwcH9GvFaruVtcYoJs4PyX27o3IdLnMau+732ft/zNCYW31151AiYNGwW5ubHM3re5OCfK5fBPQnTQ+q2Rdepf/6HWYdMUq43+Tqo2brcWKiz0lKR5N8UQ7iW+OPUgdi6BXgCVCBGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756064644; c=relaxed/simple;
	bh=jJHPPRz5a60q2K5eQDE/xgULCF4RuoBZirsLcvAWthg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xg6lGkRhv2UShP8RxFPEACua7HemYxlGI3Q3Z647vQUITE/xYu72ObEOkbOkvzkJItEaFKROqWm4RmJdSZD45G7ln+v+6/O/8ffBef7LjVG9DQl5+0g7zRYa+oVkfNcn7706qHpQKXnvDkz/EltVgMztxQL0ZNHJKi98IGq+cqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvrbHFgn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7ae31caso682007666b.3;
        Sun, 24 Aug 2025 12:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756064641; x=1756669441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utlwL9wBX+M4YY4c+rj3p87w/ofsjyRVljcQTwjO7vU=;
        b=EvrbHFgnsMkkwvLq8VYmwzaKy3wRMdeNB8BNGjyMenrCQu3ME/Vjp67WBpAMQFtRxq
         U7e+6YY63M/HD7Ce24VCkej3t+DGnPz6uiWRVDRZGzrVIKk1MnmD3v140FYZwFsdq9+T
         vpfF5/rcnhN3EzxW2wHcKh9tExMS4hoeAZEzkVJTU9DwNpXCLRlAjJvesTK9OJz+r8bE
         /C0wQbF35tA34X3mJCRt7YoKlXuGfYxIr7Z57rsLlmTrrQ7fn0AZ55DdeFugDNyDkzSG
         oCL3BYLEHeSUwLqhufxAr5HU28gg8HqXJJR9jKCeTPEWEgU2m/kn4n8sFbi2Lap2gxsM
         Vchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756064641; x=1756669441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utlwL9wBX+M4YY4c+rj3p87w/ofsjyRVljcQTwjO7vU=;
        b=Hp0MXH9RRhoxBhLEnNsNm2PhY8cEFzcw+9up9981z1PvIAqZ3x+AQtEVP/U4iREPh3
         eYcVOmoYO57KnEJBO8DATUvUuf2avE217Rz8tkMkddvxZM0GUDfhd097QDK6srK3ZkqX
         1luc2bfWPI226499L+5uoJF58unsm3jP67tPjpFOUS3qz6574Rq467EdJzaLGGccKGjg
         MTC+0KIQJ83pYjwVH1p5CMKAHkSjJ/6uTvLoAA8W2DD0UWrZXwt8ELEp3iYshHuGgyKA
         3Tyahjssfjyfc2YmDpB7J1ah4kGqz8To5ez42tgAUBTxL/7Z3BRwi11SMr7+gBWRUxFW
         /zgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1bORjbnzJc39kncjl9Y7oAlP5SUPWFk6AWaSXtDaqkL8kZsvZ8X5oMAy0aGjED8cMJAkb+4LDGVEc@vger.kernel.org, AJvYcCWh4x1Bpx7PUospoAc1I7rxeuy6AN6O1CQiym+66LU+diVWfFxhOTHS2XbTPFXnnn0yL8tbTOIlcWIs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1RS/LN/E9h6M2sqopp1OaXgPPxw8lsm6WkTppwEg7gUHFzu3z
	Ypc6nfulWT58fECilIi7PAfLb7FfB193x0cPjbxH5vApan93nGr5BurzJrsNHeODHq3lEdeLrVM
	cE0sUhSp6blY68QYyz/0LeYAs9gh4MWyeaxxRa9C5Aw==
X-Gm-Gg: ASbGncvviSFJo78P7LMoq8gEauTTGwciS0wo2qwOEMyBOmDSwZoi5nIoDay1MS2BUlh
	eS4EWfEVNbMs8Br4TvU82ihEjyPVOklsOIyT1fkIYTSg15yqYvS+D5l7AlXSVIcT8kGdIMV1Bu9
	z+3Nf46hDuu0JHnAKsigHidsVJAQRJom5ziJDN9/hUBu1K46WolYCOfwvO1X1XayISH/6nMwDsW
	7a1dhs=
X-Google-Smtp-Source: AGHT+IFA5U90+sDFqnJKW8Dw2Nb1thTFsKnynUWvaLndK+kTjALrT665YOEhge2tenBTAf0CApq5efpQCRz+7mGOS4M=
X-Received: by 2002:a17:906:478f:b0:af9:3589:68cb with SMTP id
 a640c23a62f3a-afe2974a001mr926933066b.48.1756064640455; Sun, 24 Aug 2025
 12:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824041013.9872-1-Jonathan.Santos@analog.com>
In-Reply-To: <20250824041013.9872-1-Jonathan.Santos@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 24 Aug 2025 22:43:23 +0300
X-Gm-Features: Ac12FXyibD45P5EcA1edWZixxjO8COvoJLTTXgEkZO0qwsN2Ul5CObhKNgLqzAs
Message-ID: <CAHp75VcGG_h+wpo7hHL=ERYqbrvvAaufwPAYBsEbRn3dB8-dfA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, Michael.Hennerich@analog.com, lars@metafoo.de, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 7:10=E2=80=AFAM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:
>
> Add support for ADAQ7767/68/69-1 series, which includes PGIA and
> Anti-aliasing filter (AAF) gains. Unlike the AD7768-1, they do not
> provide a VCM regulator interface.
>
> The PGA gain is configured in run-time through the scale attribute,
> if supported by the device. PGA is enabled and controlled by the GPIO
> controller (GPIOs 0, 1 and 2) provided by the device with the SPI
> interface.
>
> The AAF gain is defined by hardware connections and should be specified
> in device tree.

the device

...

> +enum {
> +       AD7768_PGA_GAIN_0,
> +       AD7768_PGA_GAIN_1,
> +       AD7768_PGA_GAIN_2,
> +       AD7768_PGA_GAIN_3,
> +       AD7768_PGA_GAIN_4,
> +       AD7768_PGA_GAIN_5,
> +       AD7768_PGA_GAIN_6,
> +       AD7768_PGA_GAIN_7,

> +       AD7768_MAX_PGA_GAIN,

No trailing comma for the terminator line and I haven't noticed if
it's even being used in the code...

> +};

...

> +/* PGA and AAF gains in V/V */
> +static const int adaq7768_gains[7] =3D {

The 7 is redundant. Leave it for the compiler.

> +       [AD7768_PGA_GAIN_0] =3D 325,      /* 0.325 */
> +       [AD7768_PGA_GAIN_1] =3D 650,      /* 0.650 */
> +       [AD7768_PGA_GAIN_2] =3D 1300,     /* 1.300 */
> +       [AD7768_PGA_GAIN_3] =3D 2600,     /* 2.600 */
> +       [AD7768_PGA_GAIN_4] =3D 5200,     /* 5.200 */
> +       [AD7768_PGA_GAIN_5] =3D 10400,    /* 10.400 */
> +       [AD7768_PGA_GAIN_6] =3D 20800     /* 20.800 */

Please, leave a trailing comma.

> +};
> +
> +static const int adaq7769_gains[8] =3D {

8 is redundant.

> +       [AD7768_PGA_GAIN_0] =3D 1000,     /* 1.000 */
> +       [AD7768_PGA_GAIN_1] =3D 2000,     /* 2.000 */
> +       [AD7768_PGA_GAIN_2] =3D 4000,     /* 4.000 */
> +       [AD7768_PGA_GAIN_3] =3D 8000,     /* 8.000 */
> +       [AD7768_PGA_GAIN_4] =3D 16000,    /* 16.000 */
> +       [AD7768_PGA_GAIN_5] =3D 32000,    /* 32.000 */
> +       [AD7768_PGA_GAIN_6] =3D 64000,    /* 64.000 */
> +       [AD7768_PGA_GAIN_7] =3D 128000    /* 128.000 */

Please, leave a trailing comma.

> +};

> +static const int ad7768_aaf_gains[3] =3D {

3 is redundant,

> +       [AD7768_AAF_IN1] =3D 1000,        /* 1.000 */
> +       [AD7768_AAF_IN2] =3D 364,         /* 0.364 */
> +       [AD7768_AAF_IN3] =3D 143          /* 0.143 */

Please, leave a trailing comma.

> +};

...

>  static const int ad7768_filter_3db_odr_multiplier[] =3D {
>         [AD7768_FILTER_SINC5] =3D 204,            /* 0.204 */

>         const unsigned long *available_masks;
>         const struct iio_chan_spec *channel_spec;
>         int num_channels;
> +       const int *pga_gains;
> +       int num_pga_modes;
> +       int default_pga_mode;
> +       int pgia_mode2pin_offset;
> +       bool has_pga;
> +       bool has_variable_aaf;
> +       bool has_vcm_regulator;
>  };

Same comments as per below.

...

>  struct ad7768_state {

>         unsigned int samp_freq;
>         unsigned int samp_freq_avail[ARRAY_SIZE(ad7768_mclk_div_rates)];
>         unsigned int samp_freq_avail_len;
> +       int pga_gain_mode;
> +       int aaf_gain;
> +       int scale_tbl[ADAQ776X_MAX_GAIN_MODES][2];

Why all signed?

>         struct completion completion;
>         struct iio_trigger *trig;
>         struct gpio_desc *gpio_sync_in;

>         struct gpio_chip gpiochip;
>         const struct ad7768_chip_info *chip;
>         bool en_spi_sync;
> +       struct mutex pga_lock; /* protect PGA value access */

>  }

Have you run `pahole`? Does it suggest a better layout?

...

> +static void ad7768_fill_scale_tbl(struct iio_dev *dev)
> +{
> +       struct ad7768_state *st =3D iio_priv(dev);
> +       const struct iio_scan_type *scan_type;
> +       int val, val2, tmp0, tmp1, i;

> +       unsigned long denominator, numerator;

struct u32_fract fract;

> +       u64 tmp2;
> +
> +       scan_type =3D iio_get_current_scan_type(dev, &dev->channels[0]);
> +       if (scan_type->sign =3D=3D 's')
> +               val2 =3D scan_type->realbits - 1;
> +       else
> +               val2 =3D scan_type->realbits;
> +
> +       for (i =3D 0; i < st->chip->num_pga_modes; i++) {
> +               /* Convert gain to a fraction format */
> +               numerator =3D st->chip->pga_gains[i];
> +               denominator =3D MILLI;
> +               if (st->chip->has_variable_aaf) {
> +                       numerator *=3D ad7768_aaf_gains[st->aaf_gain];
> +                       denominator *=3D MILLI;
> +               }
> +
> +               rational_best_approximation(numerator, denominator, INT_M=
AX, INT_MAX,
> +                                           &numerator, &denominator);
> +
> +               val =3D mult_frac(st->vref_uv, denominator, numerator);
> +               /* Would multiply by NANO here, but value is already in m=
illi */
> +               tmp2 =3D shift_right((u64)val * MICRO, val2);

> +               tmp0 =3D (int)div_u64_rem(tmp2, NANO, &tmp1);

Why casting here?

> +               st->scale_tbl[i][0] =3D tmp0; /* Integer part */
> +               st->scale_tbl[i][1] =3D abs(tmp1); /* Fractional part */
> +       }
> +}

...

> +static int ad7768_set_pga_gain(struct ad7768_state *st,
> +                              int gain_mode)
> +{
> +       int pgia_pins_value =3D abs(gain_mode - st->chip->pgia_mode2pin_o=
ffset);
> +       int check_val;
> +       int ret;
> +
> +       guard(mutex)(&st->pga_lock);

+ Blank line.

> +       /* Check GPIO control register */
> +       ret =3D regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &check_v=
al);
> +       if (ret < 0)

Here and elsewhere when it makes sense, drop redundant ' < 0' pieces.
It's even inconsistent in the same patch with how you check other
regmap returned calls.

> +               return ret;


> +       return 0;
> +}

...

>         case IIO_CHAN_INFO_SCALE:
> +               if (st->chip->has_pga) {
> +                       guard(mutex)(&st->pga_lock);
> +
> +                       *val =3D st->scale_tbl[st->pga_gain_mode][0];
> +                       *val2 =3D st->scale_tbl[st->pga_gain_mode][1];
> +                       return IIO_VAL_INT_PLUS_NANO;
> +               }
> +
>                 *val =3D (st->vref_uv * 2) / 1000;
> +               if (st->chip->has_variable_aaf)
> +                       *val =3D (*val * MILLI) / ad7768_aaf_gains[st->aa=
f_gain];

This is unreadable. Just use a temporary variable for all calculations
and when it's done, assign *val to it.

>                 *val2 =3D scan_type->realbits;
>
>                 return IIO_VAL_FRACTIONAL_LOG2;

...

> +static int ad7768_write_raw_get_fmt(struct iio_dev *indio_dev,
> +                                   struct iio_chan_spec const *chan, lon=
g mask)
> +{
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               return IIO_VAL_INT_PLUS_NANO;
> +       default:
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       }

> +
> +       return -EINVAL;

What's the point in this return, please?

> +}

...

>  static const struct ad7768_chip_info ad7768_chip_info =3D {

>         .channel_spec =3D ad7768_channels,
>         .num_channels =3D ARRAY_SIZE(ad7768_channels),
>         .available_masks =3D ad7768_channel_masks,
> +       .has_vcm_regulator =3D true

Missing trailing comma. Also same in the below. I believe I have
pointed that out in v1.

> +};
> +
> +static const struct ad7768_chip_info adaq7767_chip_info =3D {
> +       .name =3D "adaq7767-1",
> +       .channel_spec =3D ad7768_channels,
> +       .num_channels =3D ARRAY_SIZE(ad7768_channels),
> +       .available_masks =3D ad7768_channel_masks,
> +       .has_variable_aaf =3D true
> +};

> +static const struct ad7768_chip_info adaq7769_chip_info =3D {
> +       .name =3D "adaq7769-1",
> +       .channel_spec =3D adaq776x_channels,
> +       .num_channels =3D ARRAY_SIZE(adaq776x_channels),
> +       .available_masks =3D ad7768_channel_masks,
> +       .pga_gains =3D adaq7769_gains,
> +       .default_pga_mode =3D AD7768_PGA_GAIN_0,
> +       .num_pga_modes =3D ARRAY_SIZE(adaq7769_gains),
> +       .pgia_mode2pin_offset =3D 0,
> +       .has_pga =3D true,
> +       .has_variable_aaf =3D true
>  };

...


>         init_completion(&st->completion);
> +       mutex_init(&st->pga_lock);

Perhaps devm_mutex_init()?

--=20
With Best Regards,
Andy Shevchenko

