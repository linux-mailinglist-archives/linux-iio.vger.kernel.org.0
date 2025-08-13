Return-Path: <linux-iio+bounces-22661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5F5B2495B
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 14:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D2C1BC5280
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEBF145355;
	Wed, 13 Aug 2025 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdiKE5wG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105562746C;
	Wed, 13 Aug 2025 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087402; cv=none; b=ZX4fzv1zN1pzTKC/JbNZBL31F7F+nEg0MmTrkA+5iqsBwjsTtsx/PtcqMMM3EOhIuj6NAIhWbQdbyuSsbt7u5D/c4sCSM6dfsBkoRyiIhEtQkckoK1uxao/JjYGgAACLqghImDz7c9DtavwhcPSVV57aXQ0Ycd7VYqK5rrxwKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087402; c=relaxed/simple;
	bh=fF2FI5F4pxx7/cTLciBThx1pVqO3D5mIAtQHMhOILwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLIfexodm4dKuASQZLu+tu235xbLXNHYMiw7jKbtdpDBHOYt4CJIHRFnpQ5kWGHwJYrIeHgfSiBq9aEn+/qIc7GqUhAJjO/JE9KEMFLmd/2xiBsi/DzmJgud6P4JGZHl/ECSGLnG5VLBVs6UXntvhzdUofMxEeNDMi2itDnnkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdiKE5wG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af922ab4849so996906466b.3;
        Wed, 13 Aug 2025 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755087398; x=1755692198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gVTVwl5K8yG5aSFfH7JPYY3jkQ/ImSb/uinOfz8bks=;
        b=KdiKE5wGf56TwQbLYbOIZ8qozCI12TBqqp1saAEeDYxUop9S4WqPsXWEyLcwPqO62Q
         4qT9cHK0B7yJMFSNfa1l/FLhXhCz+Hq19drgOleRVNPIQS913em+sjMIusQZHKb0yUZQ
         OevN6l4PHkSGiKRaVUuEL1mQD7HdQUmbdoLXGw+6h/KL8/TJ1LqIcMqvYbGeFtZXPbrp
         VGppkXa9Fo1KZTkXXg4s3erxN3QXIPJuc3rTC2Mr5wQea71PSH3LoGzOzmosdu4LdZuj
         m8xQ7Z5cXTLgircs2qVZBGzKFqbrgKmHVABkfiTlHTgaiDFF8qi2AGTShzuMMiXy4jGa
         Fyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755087398; x=1755692198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gVTVwl5K8yG5aSFfH7JPYY3jkQ/ImSb/uinOfz8bks=;
        b=L7lsNBM6gVV1sF0esx9qlO3NBMRuZLLMRw05u7ptwcDTnWAVE9if9nKSv8wSEwFu/C
         8bU6IJ016L748omXNx6N/0F80z5lntnTO7wvk+q7Kqvls6x8XnzxV+rUhBt/sdz7iW62
         6GuURHeJxMcUq36tuwsDAByrkapolak5vBDypqJ4wGeOfslTtslvxHsR4uWISXq3JaXP
         6Zz6EgWfYVFWSIrnJA5Oav+RUtIak55O6SYAKeHvDmQS5eIm/DXSptjFBwgwBvoLOR75
         xdwknkFMbf2I2iTLugWQm0q2Ks0c87i7fVSfvcyGVOyMk7ozZGOG24C+kXNHymWWytCM
         mbew==
X-Forwarded-Encrypted: i=1; AJvYcCV53JmMFl4xMX1Zp0eR9UksZ3ZDQnbOAZm8QYFHZzEQo2BVhSTNzPP3VL/Ypw/4qGte8cgl0ommgr/y@vger.kernel.org, AJvYcCVbIzImoHT3Q1UxQH45GHZ9hVsi+S9zgpDz8KIZPxGDnkhWR8E1jsKEdmaonhkyRew3A1Ikxc2Zgd14Gfjc@vger.kernel.org
X-Gm-Message-State: AOJu0YymIbQHhwHh0JcLrbhgCyDCdSaxv1XH/9kekhCKoHTenyCKHLdv
	Y90YgPFSKBVzPzmvqdr11dman4GVJyWXnsEb+gZJIaNaqLqx4jbjrENdDdJEyd0kxcG4Ve3AOES
	dRAGZBu7MyCW186fnNTtVvB2JNZqsbUsUyFGpIcIpsA==
X-Gm-Gg: ASbGncvNKurk3WQHQSuCC83uoplb5QBhZ30S8/9w23qxYpNLYsmi3Scd2XPivx3gY9t
	CNilbItwEVpKUgpwkXqexXs7Vo/pvkTr7sYfYtnOycDhfb6BlXtMTNq4o/6P8K4xJf3LBIiQFtd
	w2LT28CLNxrW40xXbf6b/8Jou1xVXQf1opwiMgK0W9c8lOAa+8PvlOkjFDb7dkE4NtmQXEj6Xzl
	dcjj0b1mg==
X-Google-Smtp-Source: AGHT+IEEg+Q5mfvuWmkdpLeC8WszBcye8iP/kRXAx43GWOomzzYo9FiU9DIGK0fiI4imHGsW7qNk9JWjM5l+9yKcqJ8=
X-Received: by 2002:a17:907:1c1b:b0:af9:8c1c:b9be with SMTP id
 a640c23a62f3a-afca4d00e51mr269914666b.14.1755087398051; Wed, 13 Aug 2025
 05:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754617360.git.Jonathan.Santos@analog.com> <f0c1cbc9c2994a90113788cad57df1f32f9db45e.1754617360.git.Jonathan.Santos@analog.com>
In-Reply-To: <f0c1cbc9c2994a90113788cad57df1f32f9db45e.1754617360.git.Jonathan.Santos@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Aug 2025 14:16:01 +0200
X-Gm-Features: Ac12FXwyCGGvXLd_mSfSCwCVjXuPnYAAD7LgOjTPAwcgge6NI0IR64OYYbPXCwY
Message-ID: <CAHp75VdqbhwZTjA2TQPFeoAHQv1NCO949kdxYQbUSZmjm3kP6g@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 4:49=E2=80=AFAM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:
>
> Add support for ADAQ7767/68/69-1 series, which includes PGIA and
> Anti-aliasing filter (AAF) gains.
>
> The PGA gain is configured in run-time through the scale attribute,
> if supported by the device. The scale options are updated according
> to the output data width.
>
> The AAF gain is configured in the devicetree and it should correspond to
> the AAF channel selected in hardware.
> +#define AD7768_GPIO_READ(x)            FIELD_PREP(AD7768_GPIO_READ_MSK, =
x)
>
>  #define AD7768_VCM_OFF                 0x07
>  #define AD7768_CHAN_INFO_NONE          0
>
> +#define ADAQ776X_GAIN_MAX_NANO         (128 * NANO)
> +#define ADAQ776X_MAX_GAIN_MODES                8
> +
>  #define AD7768_TRIGGER_SOURCE_SYNC_IDX 0
>
>  #define AD7768_MAX_CHANNELS 1
> @@ -154,6 +161,52 @@ enum ad7768_scan_type {
>         AD7768_SCAN_TYPE_HIGH_SPEED,
>  };
>
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
> +};
> +
> +enum {
> +       AD7768_AAF_IN1,
> +       AD7768_AAF_IN2,
> +       AD7768_AAF_IN3,
> +};
> +
> +/* PGA and AAF gains in V/V */
> +static const int adaq7768_gains[7] =3D {
> +       [AD7768_PGA_GAIN_0] =3D 325,      /* 0.325 */
> +       [AD7768_PGA_GAIN_1] =3D 650,      /* 0.650 */
> +       [AD7768_PGA_GAIN_2] =3D 1300,     /* 1.300 */
> +       [AD7768_PGA_GAIN_3] =3D 2600,     /* 2.600 */
> +       [AD7768_PGA_GAIN_4] =3D 5200,     /* 5.200 */
> +       [AD7768_PGA_GAIN_5] =3D 10400,    /* 10.400 */
> +       [AD7768_PGA_GAIN_6] =3D 20800     /* 20.800 */
> +};
> +
> +static const int adaq7769_gains[8] =3D {
> +       [AD7768_PGA_GAIN_0] =3D 1000,     /* 1.000 */
> +       [AD7768_PGA_GAIN_1] =3D 2000,     /* 2.000 */
> +       [AD7768_PGA_GAIN_2] =3D 4000,     /* 4.000 */
> +       [AD7768_PGA_GAIN_3] =3D 8000,     /* 8.000 */
> +       [AD7768_PGA_GAIN_4] =3D 16000,    /* 16.000 */
> +       [AD7768_PGA_GAIN_5] =3D 32000,    /* 32.000 */
> +       [AD7768_PGA_GAIN_6] =3D 64000,    /* 64.000 */
> +       [AD7768_PGA_GAIN_7] =3D 128000    /* 128.000 */
> +};
> +
> +static const int ad7768_aaf_gains[3] =3D {
> +       [AD7768_AAF_IN1] =3D 1000,        /* 1.000 */
> +       [AD7768_AAF_IN2] =3D 364,         /* 0.364 */
> +       [AD7768_AAF_IN3] =3D 143          /* 0.143 */
> +};
> +
>  /* -3dB cutoff frequency multipliers (relative to ODR) for each filter t=
ype. */
>  static const int ad7768_filter_3db_odr_multiplier[] =3D {
>         [AD7768_FILTER_SINC5] =3D 204,            /* 0.204 */
> @@ -216,6 +269,12 @@ static const struct iio_scan_type ad7768_scan_type[]=
 =3D {
>
>  struct ad7768_chip_info {
>         const char *name;
> +       bool has_variable_aaf;
> +       bool has_pga;
> +       int num_pga_modes;
> +       int default_pga_mode;
> +       int pgia_mode2pin_offset;
> +       const int *pga_gains;
>         const struct iio_chan_spec *channel_spec;
>         const unsigned long *available_masks;
>         int num_channels;
> @@ -236,6 +295,9 @@ struct ad7768_state {
>         unsigned int samp_freq;
>         unsigned int samp_freq_avail[ARRAY_SIZE(ad7768_mclk_div_rates)];
>         unsigned int samp_freq_avail_len;
> +       int pga_gain_mode;
> +       int aaf_gain;
> +       int scale_tbl[ADAQ776X_MAX_GAIN_MODES][2];
>         struct completion completion;
>         struct iio_trigger *trig;
>         struct gpio_desc *gpio_sync_in;
> @@ -466,6 +528,43 @@ static int ad7768_reg_access(struct iio_dev *indio_d=
ev,
>         return ret;
>  }
>
> +static void ad7768_fill_scale_tbl(struct iio_dev *dev)
> +{
> +       struct ad7768_state *st =3D iio_priv(dev);
> +       const struct iio_scan_type *scan_type;
> +       int val, val2, tmp0, tmp1, i;
> +       unsigned long denominator, numerator;
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
> +               rational_best_approximation(numerator, denominator, __INT=
_MAX__, __INT_MAX__,
> +                                           &numerator, &denominator);
> +
> +               val =3D st->vref_uv / 1000;
> +               /* Multiply by MILLI here to avoid losing precision */
> +               val =3D mult_frac(val, denominator * MILLI, numerator);
> +               /* Would multiply by NANO here but we already multiplied =
by MILLI */
> +               tmp2 =3D shift_right((u64)val * MICRO, val2);
> +               tmp0 =3D (int)div_s64_rem(tmp2, NANO, &tmp1);
> +               st->scale_tbl[i][0] =3D tmp0; /* Integer part */
> +               st->scale_tbl[i][1] =3D abs(tmp1); /* Fractional part */
> +       }
> +}
> +
>  static int ad7768_set_sinc3_dec_rate(struct ad7768_state *st,
>                                      unsigned int dec_rate)
>  {
> @@ -567,12 +666,68 @@ static int ad7768_configure_dig_fil(struct iio_dev =
*dev,
>                 st->oversampling_ratio =3D ad7768_dec_rate_values[dec_rat=
e_idx];
>         }
>
> +       /* Update scale table: scale values vary according to the precisi=
on */
> +       ad7768_fill_scale_tbl(dev);
> +
>         ad7768_fill_samp_freq_tbl(st);
>
>         /* A sync-in pulse is required after every configuration change *=
/
>         return ad7768_send_sync_pulse(st);
>  }
>
> +static int ad7768_calc_pga_gain(struct ad7768_state *st, int gain_int,
> +                               int gain_fract, int precision)
> +{
> +       u64 gain_nano, tmp;
> +       int gain_idx;
> +
> +       precision--;
> +       gain_nano =3D gain_int * NANO + gain_fract;
> +       if (gain_nano < 0 || gain_nano > ADAQ776X_GAIN_MAX_NANO)
> +               return -EINVAL;
> +
> +       tmp =3D DIV_ROUND_CLOSEST_ULL(gain_nano << precision, NANO);
> +       gain_nano =3D DIV_ROUND_CLOSEST_ULL(st->vref_uv, tmp);
> +       if (st->chip->has_variable_aaf)
> +               /* remove the AAF gain from the overall gain */
> +               gain_nano =3D DIV_ROUND_CLOSEST_ULL(gain_nano *  MILLI,
> +                                                 ad7768_aaf_gains[st->aa=
f_gain]);
> +       tmp =3D st->chip->num_pga_modes;
> +       gain_idx =3D find_closest(gain_nano, st->chip->pga_gains, tmp);
> +
> +       return gain_idx;
> +}
> +
> +static int ad7768_set_pga_gain(struct ad7768_state *st,
> +                              int gain_mode)
> +{
> +       int pgia_pins_value =3D abs(gain_mode - st->chip->pgia_mode2pin_o=
ffset);
> +       int check_val;
> +       int ret;
> +
> +       /* Check GPIO control register */
> +       ret =3D regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &check_v=
al);
> +       if (ret < 0)
> +               return ret;
> +
> +       if ((check_val & AD7768_GPIO_PGIA_EN) !=3D AD7768_GPIO_PGIA_EN) {
> +               /* Enable PGIA GPIOs and set them as output */
> +               ret =3D regmap_write(st->regmap, AD7768_REG_GPIO_CONTROL,=
 AD7768_GPIO_PGIA_EN);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       /* Write the respective gain values to GPIOs 0, 1, 2 */
> +       ret =3D regmap_write(st->regmap, AD7768_REG_GPIO_WRITE,
> +                          AD7768_GPIO_WRITE(pgia_pins_value));
> +       if (ret < 0)
> +               return ret;
> +
> +       st->pga_gain_mode =3D gain_mode;
> +
> +       return 0;
> +}
> +
>  static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned =
int offset)
>  {
>         struct iio_dev *indio_dev =3D gpiochip_get_data(chip);
> @@ -782,13 +937,17 @@ static const struct iio_chan_spec ad7768_channels[]=
 =3D {
>         AD7768_CHAN(0, AD7768_CHAN_INFO_NONE),
>  };
>
> +static const struct iio_chan_spec adaq776x_channels[] =3D {
> +       AD7768_CHAN(0, BIT(IIO_CHAN_INFO_SCALE)),
> +};
> +
>  static int ad7768_read_raw(struct iio_dev *indio_dev,
>                            struct iio_chan_spec const *chan,
>                            int *val, int *val2, long info)
>  {
>         struct ad7768_state *st =3D iio_priv(indio_dev);
>         const struct iio_scan_type *scan_type;
> -       int scale_uv, ret, temp;
> +       int ret, temp;
>
>         scan_type =3D iio_get_current_scan_type(indio_dev, chan);
>         if (IS_ERR(scan_type))
> @@ -809,12 +968,19 @@ static int ad7768_read_raw(struct iio_dev *indio_de=
v,
>                 return IIO_VAL_INT;
>
>         case IIO_CHAN_INFO_SCALE:
> -               scale_uv =3D st->vref_uv;
> -               if (scale_uv < 0)
> -                       return scale_uv;
> -
> -               *val =3D (scale_uv * 2) / 1000;
> -               *val2 =3D scan_type->realbits;
> +               if (st->chip->has_pga) {
> +                       *val =3D st->scale_tbl[st->pga_gain_mode][0];
> +                       *val2 =3D st->scale_tbl[st->pga_gain_mode][1];
> +                       return IIO_VAL_INT_PLUS_NANO;
> +               }
> +               *val =3D st->vref_uv / 1000;
> +               if (st->chip->has_variable_aaf)
> +                       *val =3D (*val * MILLI) / ad7768_aaf_gains[st->aa=
f_gain];
> +               /*
> +                * ADC output code is two's complement so only (realbits =
- 1)
> +                * bits express voltage magnitude.
> +                */
> +               *val2 =3D scan_type->realbits - 1;
>
>                 return IIO_VAL_FRACTIONAL_LOG2;
>
> @@ -869,18 +1035,42 @@ static int ad7768_read_avail(struct iio_dev *indio=
_dev,
>                 *length =3D st->samp_freq_avail_len;
>                 *type =3D IIO_VAL_INT;
>                 return IIO_AVAIL_LIST;
> +       case IIO_CHAN_INFO_SCALE:
> +               *vals =3D (int *)st->scale_tbl;
> +               *length =3D st->chip->num_pga_modes * 2;
> +               *type =3D IIO_VAL_INT_PLUS_NANO;
> +               return IIO_AVAIL_LIST;
>         default:
>                 return -EINVAL;
>         }
>  }
>
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
> +}
> +
>  static int __ad7768_write_raw(struct iio_dev *indio_dev,
>                               struct iio_chan_spec const *chan,
>                               int val, int val2, long info)
>  {
>         struct ad7768_state *st =3D iio_priv(indio_dev);
> +       const struct iio_scan_type *scan_type;
> +       int gain_mode;
>         int ret;
>
> +       scan_type =3D iio_get_current_scan_type(indio_dev, chan);
> +       if (IS_ERR(scan_type))
> +               return PTR_ERR(scan_type);
> +
>         switch (info) {
>         case IIO_CHAN_INFO_SAMP_FREQ:
>                 return ad7768_set_freq(st, val);
> @@ -892,6 +1082,13 @@ static int __ad7768_write_raw(struct iio_dev *indio=
_dev,
>
>                 /* Update sampling frequency */
>                 return ad7768_set_freq(st, st->samp_freq);
> +       case IIO_CHAN_INFO_SCALE:
> +               if (!st->chip->has_pga)
> +                       return -EOPNOTSUPP;
> +
> +               gain_mode =3D ad7768_calc_pga_gain(st, val, val2,
> +                                                scan_type->realbits);
> +               return ad7768_set_pga_gain(st, gain_mode);
>         default:
>                 return -EINVAL;
>         }
> @@ -933,6 +1130,7 @@ static const struct iio_info ad7768_info =3D {
>         .read_raw =3D &ad7768_read_raw,
>         .read_avail =3D &ad7768_read_avail,
>         .write_raw =3D &ad7768_write_raw,
> +       .write_raw_get_fmt =3D &ad7768_write_raw_get_fmt,
>         .read_label =3D ad7768_read_label,
>         .get_current_scan_type =3D &ad7768_get_current_scan_type,
>         .debugfs_reg_access =3D &ad7768_reg_access,
> @@ -1351,10 +1549,46 @@ static const struct ad7768_chip_info ad7768_chip_=
info =3D {
>         .available_masks =3D ad7768_channel_masks,
>  };
>
> +static const struct ad7768_chip_info adaq7767_chip_info =3D {
> +       .name =3D "adaq7767-1",
> +       .channel_spec =3D ad7768_channels,
> +       .num_channels =3D ARRAY_SIZE(ad7768_channels),
> +       .available_masks =3D ad7768_channel_masks,
> +       .has_pga =3D false,
> +       .has_variable_aaf =3D true
> +};
> +
> +static const struct ad7768_chip_info adaq7768_chip_info =3D {
> +       .name =3D "adaq7768-1",
> +       .channel_spec =3D adaq776x_channels,
> +       .num_channels =3D ARRAY_SIZE(adaq776x_channels),
> +       .available_masks =3D ad7768_channel_masks,
> +       .pga_gains =3D adaq7768_gains,
> +       .default_pga_mode =3D AD7768_PGA_GAIN_2,
> +       .num_pga_modes =3D ARRAY_SIZE(adaq7768_gains),
> +       .pgia_mode2pin_offset =3D 6,
> +       .has_pga =3D true,
> +       .has_variable_aaf =3D false
> +};
> +
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
> +};
> +
>  static int ad7768_probe(struct spi_device *spi)
>  {
>         struct ad7768_state *st;
>         struct iio_dev *indio_dev;
> +       u32 val;
>         int ret;
>

...

> +       st->aaf_gain =3D AD7768_AAF_IN1;
> +       ret =3D device_property_read_u32(&spi->dev, "adi,aaf-gain", &val)=
;
> +       if (ret) {
> +               /* AAF gain required, but not specified */
> +               if (st->chip->has_variable_aaf)
> +                       return dev_err_probe(&spi->dev, -EINVAL, "AAF gai=
n not specified\n");

> +

Stray blank line.

> +       } else if (!st->chip->has_variable_aaf) {


> +               /* AAF gain provided, but not supported */
> +               return dev_err_probe(&spi->dev, -EINVAL, "AAF gain not su=
pported for %s\n",
> +                                    st->chip->name);

I would rewrite these conditionals as

  if (ret && ->has_variable_aaf)
    return dev_err_probe(...);
  if (!ret && ! ->has_variable_aaf)
    return dev_err_probe(...);

> +       } else {

It will be redundant 'else' after the above being applied.

> +               /* Device supports variable AAF gain, validate and set th=
e gain */
> +               switch (val) {
> +               case 1000:
> +                       st->aaf_gain =3D AD7768_AAF_IN1;
> +                       break;
> +               case 364:
> +                       st->aaf_gain =3D AD7768_AAF_IN2;
> +                       break;
> +               case 143:
> +                       st->aaf_gain =3D AD7768_AAF_IN3;
> +                       break;
> +               default:
> +                       return dev_err_probe(&spi->dev, -EINVAL,
> +                                            "Invalid firmware provided g=
ain\n");
> +               }
> +       }


--=20
With Best Regards,
Andy Shevchenko

