Return-Path: <linux-iio+bounces-9469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DFD976D8C
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 17:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F39E1F24348
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 15:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234A61B9833;
	Thu, 12 Sep 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwJOn+aj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6026F076;
	Thu, 12 Sep 2024 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154170; cv=none; b=U6oH1fwuqLpvdqdEe9Y46vuljlW87XH+4gicm8irZvmpEj3DtJ0/fmoNIEviVSTqKeBXSy6zVkHn+gsgACzuHS658MFF6v0ZFWvb1x3ju1aojSkXoa9JSJlU/wxafkVonV/OVmlZaDm2Rk+k1qMzpmQJPDU9t6+O/A7b2C5YrJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154170; c=relaxed/simple;
	bh=1Ya8WglVWGY8fgH9b45ei/JXWDqJyhMDClZ/p4QtxlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQl3TJCxV2Q62MluvGeAmMXUz3E4W1hr771sFYKgmzWM6XgTOhVrGrr3GpcHautKuQKayryFMH77ipOZLrcDHey9b0ItGqpaUJGu/ilClgXJTa28Mlel/guvBlcE/ljV6S6d+4kpYty60S9xP6egsrPnEuwETYLhBd+qrYhWtVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwJOn+aj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f75c205e4aso13476131fa.0;
        Thu, 12 Sep 2024 08:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726154167; x=1726758967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTJmzg/cTN8RsU2hs14W4uKdu3EPXysnv6zCHHZgkc0=;
        b=iwJOn+ajI9YD/NFHa6CTuLzAchA8EH8rSwz/OdRaH2XhILZ3osS8oyiUGAq7y+ba5A
         6rL73hZl4adgu0ilyYPqeqwgR85VOkFT2h/qPAovCbx4xcwDfFQGevNQXTv+RwtRs6pE
         U0ChRNYo+vZlZ8hhUYkfB8md7DlhzH9mswntV13wvJi60JPzV/t4uR623QxbB0zloM+m
         0JdFCHQ3G88tLEtBF3qUGm2LvcrLpzZiTz97TmnlubtY3CYj6qpdr3RLGBiblP7RApNg
         ILaVeqq06wIfURPKcDtPPSyX/fp/WpvZ8NXnz4dmxz1PsFtd+JQrXdgzQICOq7qsKuZS
         /AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726154167; x=1726758967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTJmzg/cTN8RsU2hs14W4uKdu3EPXysnv6zCHHZgkc0=;
        b=UNMkHugs0IAIbKn7uBFwom6TCcNE24JInuOFetvs/gjPcq1tUP2wyt2WPds1p9o3gz
         6GPQlSh5uId/5HKqXRFlRIbKUWQPmwhBD1912IZFGFrEWcZAqDfHP2Oczf3zIe9Ic6Te
         GMvz/oiGVZirn9ifH6yhNYUBOdUpplPeQPRgb0MxWguN9fZe65dYQ5+cxWGlvcxxPAQm
         DBXWTBMl6pIz+zgszZnH9SMHOo/Z42M9BEHAqUFwX6+rI2IMHlrBQBci9+AFF502jCrY
         fZ3EAxIlX/iXoVwTR/hwDhCS3wMALh2usrtegcvyW7IBu4+BuE1a1XaulD9MmsW8ij+d
         7QDw==
X-Forwarded-Encrypted: i=1; AJvYcCURhgZJH32jGByagMBJHpiM657aXUFKXLmTnHFYfrbfpm3hoShJ1Uqk3z8ElKY3taIarNSQCZdfVQhc@vger.kernel.org, AJvYcCWIsD1/kDTQrrXaBiuBV1YMAv+TYyP5Kb5EPjp+cZhWe/AwcIt/7wJiE1AMCXEBpIZTxZwH/c23dWKF@vger.kernel.org, AJvYcCWkrj6JK18mgWPpDYUJFsen3dydBdvhayPnP61CdE6zxurclijOqfhpVtWAqJBtDYTB0FTDbP7u9Hjupmau@vger.kernel.org
X-Gm-Message-State: AOJu0YxHDicmk1b2nHRYluWqXgqr7ovNFmHz7O+7kZfxJ+7He6Wsrcwq
	MBhFGhQCIqWUdKGz/bY7ibu5aGqEeWQW648FhAmIaxcxnQ6H+vNzwlDFDeHdRPj1XcAuGOmAz8G
	Ocls/8WxI1XycYBzamqKiKTZMKpI=
X-Google-Smtp-Source: AGHT+IHhvW7ayKVJLuNwRUMJDtqNyvvEmcC6b7ZffkBWEpFHp/CRqQRsEukAB38kdoMrB9NlfXnVrODAKPdyexpIfns=
X-Received: by 2002:a2e:a316:0:b0:2f6:5f7b:e5e0 with SMTP id
 38308e7fff4ca-2f787ed89c2mr15980991fa.21.1726154166659; Thu, 12 Sep 2024
 08:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912121609.13438-1-ramona.nechita@analog.com> <20240912121609.13438-4-ramona.nechita@analog.com>
In-Reply-To: <20240912121609.13438-4-ramona.nechita@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 12 Sep 2024 18:15:29 +0300
Message-ID: <CAHp75VdBf6UX7XGVWi0Luw9Bs2tCzcvFFy8Dp-ZGsEU=TqOn1w@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] drivers: iio: adc: add support for ad777x family
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Dumitru Ceclan <mitrutzceclan@gmail.com>, Matteo Martelli <matteomartelli3@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alisa-Dariana Roman <alisadariana@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>, 
	Mike Looijmans <mike.looijmans@topic.nl>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 3:17=E2=80=AFPM Ramona Alexandra Nechita
<ramona.nechita@analog.com> wrote:
>
> Add support for AD7770, AD7771, AD7779 ADCs. The device is capable of

"..., and AD7779..."

> sending out data both on DOUT lines interface,as on the SDO line.
> The driver currently implements only the SDO data streaming mode. SPI
> communication is used alternatively for accessing registers and streaming
> data. Register access are protected by crc8.

accesses

...

> +/*
> + * AD7770, AD7771, AD7779 ADC

"..., and AD7779..."

> + *
> + * Copyright 2023-2024 Analog Devices Inc.
> + */

...

> +#define AD7779_MAXCLK_LOWPOWER                 4096000

Units? _HZ? _uV?

...

> +#define GAIN_REL                               0x555555

Is it something like making value for 12 channels? Can you elaborate a
bit (perhaps in the comment)?

...

> +struct ad7779_state {
> +       struct spi_device *spi;
> +       const struct ad7779_chip_info *chip_info;
> +       struct clk *mclk;
> +       struct iio_trigger *trig;
> +       struct completion completion;
> +       unsigned int sampling_freq;
> +       enum ad7779_filter filter_enabled;
> +       /*
> +        * DMA (thus cache coherency maintenance) requires the
> +        * transfer buffers to live in their own cache lines.
> +        */
> +       u8                      reg_rx_buf[3] __aligned(IIO_DMA_MINALIGN)=
;
> +       u8                      reg_tx_buf[3];
> +       u32                     spidata_rx[8];
> +       u32                     spidata_tx[8];
> +       u8                      reset_buf[8];
> +};

Have you run `pahole` to check if this can be optimised in size?

...

> +static int ad7779_spi_read(struct ad7779_state *st, u8 reg, u8 *rbuf)
> +{
> +       int ret;
> +       int length =3D 3;
> +       u8 crc_buf[2];
> +       u8 exp_crc =3D 0;
> +       struct spi_transfer reg_read_tr[] =3D {
> +               {
> +                       .tx_buf =3D st->reg_tx_buf,
> +                       .rx_buf =3D st->reg_rx_buf,
> +               },
> +       };
> +
> +       if (reg =3D=3D AD7779_REG_GEN_ERR_REG_1_EN)
> +               length =3D 2;

Does it mean the crc byte will be ignored? If so, why do we even
bother to spend resources on calculating it in that case? Same Q for
other similar cases.

> +       reg_read_tr[0].len =3D length;
> +
> +       st->reg_tx_buf[0] =3D AD7779_SPI_READ_CMD | FIELD_GET(AD7779_REG_=
MSK, reg);
> +       st->reg_tx_buf[1] =3D 0;
> +       st->reg_tx_buf[2] =3D crc8(ad7779_crc8_table, st->reg_tx_buf, 2, =
0);
> +
> +       ret =3D spi_sync_transfer(st->spi, reg_read_tr, ARRAY_SIZE(reg_re=
ad_tr));
> +       if (ret)
> +               return ret;
> +
> +       crc_buf[0] =3D AD7779_SPI_READ_CMD | FIELD_GET(AD7779_REG_MSK, re=
g);
> +       crc_buf[1] =3D st->reg_rx_buf[1];
> +       exp_crc =3D crc8(ad7779_crc8_table, crc_buf, 2, 0);
> +       if (reg !=3D AD7779_REG_GEN_ERR_REG_1_EN && exp_crc !=3D st->reg_=
rx_buf[2]) {
> +               dev_err(&st->spi->dev, "Bad CRC %x, expected %x",
> +                       st->reg_rx_buf[2], exp_crc);
> +               return -EINVAL;
> +       }
> +       *rbuf =3D st->reg_rx_buf[1];
> +
> +       return 0;
> +}

...

> +       regval =3D data;
> +       regval &=3D ~mask;
> +       regval |=3D val;

Traditional pattern is to have this as

    regval =3D (data & ~mask) | (val & mask);

...

> +static int ad7779_set_sampling_frequency(struct ad7779_state *st,
> +                                        unsigned int sampling_freq)
> +{
> +       int ret;
> +       unsigned int dec;
> +       unsigned int div;
> +       unsigned int decimal;
> +       int temp;
> +       unsigned int kfreq;

freq_khz will be better name

> +       if (st->filter_enabled =3D=3D AD7779_SINC3 &&
> +           sampling_freq > AD7779_SINC3_MAXFREQ)
> +               return -EINVAL;
> +
> +       if (st->filter_enabled =3D=3D AD7779_SINC5 &&
> +           sampling_freq > AD7779_SINC5_MAXFREQ)
> +               return -EINVAL;
> +
> +       if (sampling_freq > AD7779_SPIMODE_MAX_SAMP_FREQ)
> +               return -EINVAL;
> +
> +       div =3D AD7779_HIGHPOWER_DIV;
> +
> +       kfreq =3D sampling_freq / KILO;
> +       dec =3D div / kfreq;
> +
> +       ret =3D ad7779_spi_write(st, AD7779_REG_SRC_N_MSB,
> +                              FIELD_GET(AD7779_FREQ_MSB_MSK, dec));
> +       if (ret)
> +               return ret;
> +       ret =3D ad7779_spi_write(st, AD7779_REG_SRC_N_LSB,
> +                              FIELD_GET(AD7779_FREQ_LSB_MSK, dec));
> +       if (ret)
> +               return ret;

> +       if (div % kfreq) {

It's better to combine with / above, because some ISAs may have a
single assembly instruction to do both at the same time. I'm not sure
compiler (os some versions of it) may see this.

  dec =3D div / freq_khz;
  frac =3D div % freq_khz;
  ...
  if (frac) {
      ...
  }

> +               temp =3D (div * KILO) / kfreq;
> +               decimal =3D ((temp -  dec * KILO) << 16) / KILO;

I would add a small comment to show the formula behind this.

> +               ret =3D ad7779_spi_write(st, AD7779_REG_SRC_N_MSB,
> +                                      FIELD_GET(AD7779_FREQ_MSB_MSK, dec=
imal));
> +               if (ret)
> +                       return ret;
> +               ret =3D ad7779_spi_write(st, AD7779_REG_SRC_N_LSB,
> +                                      FIELD_GET(AD7779_FREQ_LSB_MSK, dec=
imal));
> +               if (ret)
> +                       return ret;
> +       } else {
> +               ret =3D ad7779_spi_write(st, AD7779_REG_SRC_N_MSB,
> +                                      FIELD_GET(AD7779_FREQ_MSB_MSK, 0x0=
));
> +               if (ret)
> +                       return ret;
> +               ret =3D ad7779_spi_write(st, AD7779_REG_SRC_N_LSB,
> +                                      FIELD_GET(AD7779_FREQ_LSB_MSK, 0x0=
));
> +               if (ret)
> +                       return ret;
> +       }
> +       ret =3D ad7779_spi_write(st, AD7779_REG_SRC_UPDATE, 0x1);
> +       if (ret)
> +               return ret;
> +
> +       /* SRC update settling time */
> +       fsleep(15);

+ Blank line, otherwise it's unclear how fsleep() is applied (or to
which sections).

> +       ret =3D ad7779_spi_write(st, AD7779_REG_SRC_UPDATE, 0x0);
> +       if (ret)
> +               return ret;
> +
> +       /* SRC update settling time */
> +       fsleep(15);

Alternatively make a helper to avoid potential desynchronisation in
the code pieces

statuc int ad7779_update_src(..., val)
{
    ...
    /* ... */
    fsleep(...);

    return 0;
}

> +       st->sampling_freq =3D sampling_freq;
> +
> +       return 0;
> +}

...

> +static int ad7779_set_calibscale(struct ad7779_state *st, int channel, i=
nt val)
> +{
> +       int ret;
> +       unsigned int gain;
> +       unsigned long long tmp;
> +       u8 gain_bytes[3];
> +
> +       tmp =3D val * 5592405LL;
> +       gain =3D DIV_ROUND_CLOSEST_ULL(tmp, MEGA);

Formula to be explained?
Magic number to be described (in the same comment), please?

> +       put_unaligned_be24(gain, gain_bytes);
> +       ret =3D ad7779_spi_write(st,
> +                              AD7779_REG_CH_GAIN_UPPER_BYTE(channel),
> +                              gain_bytes[0]);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ad7779_spi_write(st,
> +                              AD7779_REG_CH_GAIN_MID_BYTE(channel),
> +                              gain_bytes[1]);
> +       if (ret)
> +               return ret;
> +
> +       return ad7779_spi_write(st,
> +                               AD7779_REG_CH_GAIN_LOWER_BYTE(channel),
> +                               gain_bytes[2]);
> +}

...

> +       iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +               switch (mask) {
> +               case IIO_CHAN_INFO_CALIBSCALE:
> +                       *val =3D ad7779_get_calibscale(st, chan->channel)=
;
> +                       if (*val < 0)
> +                               return -EINVAL;
> +                       *val2 =3D GAIN_REL;
> +                       return IIO_VAL_FRACTIONAL;
> +               case IIO_CHAN_INFO_CALIBBIAS:
> +                       *val =3D ad7779_get_calibbias(st, chan->channel);
> +                       if (*val < 0)
> +                               return -EINVAL;
> +                       return IIO_VAL_INT;
> +               case IIO_CHAN_INFO_SAMP_FREQ:
> +                       *val =3D st->sampling_freq;
> +                       if (*val < 0)
> +                               return -EINVAL;
> +                       return IIO_VAL_INT;
> +               }
> +               return -EINVAL;
> +       }

> +       unreachable();

Hmm... Is it necessary? Same Q for other similar cases. I.o.w. what
will be if we don't add this line?

> +}

...

> +static irqreturn_t ad7779_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf =3D p;
> +       struct iio_dev *indio_dev =3D pf->indio_dev;
> +       struct ad7779_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +       int bit;
> +       int k =3D 0;
> +       /*
> +        * Each channel shifts out HEADER + 24 bits of data therefore 8 *=
 u32
> +        * for the data and 64 bits for the timestamp
> +        */

May you do the respective structure and use aligned_s64 for the timestamp?

> +       u32 tmp[10];
> +
> +       struct spi_transfer sd_readback_tr[] =3D {
> +               {
> +                       .rx_buf =3D st->spidata_rx,
> +                       .tx_buf =3D st->spidata_tx,
> +                       .len =3D AD7779_NUM_CHANNELS * AD7779_CHAN_DATA_S=
IZE,
> +               }
> +       };
> +
> +       if (!iio_buffer_enabled(indio_dev))
> +               goto exit_handler;
> +
> +       st->spidata_tx[0] =3D AD7779_SPI_READ_CMD;
> +       ret =3D spi_sync_transfer(st->spi, sd_readback_tr,
> +                               ARRAY_SIZE(sd_readback_tr));
> +       if (ret) {
> +               dev_err(&st->spi->dev,
> +                       "spi transfer error in irq handler");
> +               goto exit_handler;
> +       }
> +
> +       for_each_set_bit(bit, indio_dev->active_scan_mask, AD7779_NUM_CHA=
NNELS - 1)
> +               tmp[k++] =3D st->spidata_rx[bit];
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev, &tmp[0], pf->timest=
amp);
> +
> +exit_handler:
> +       iio_trigger_notify_done(indio_dev->trig);
> +       return IRQ_HANDLED;
> +}

...

> +       st->mclk =3D devm_clk_get_enabled(&spi->dev, "mclk");
> +       if (IS_ERR(st->mclk))
> +               return PTR_ERR(st->mclk);

> +       if (!spi->irq)
> +               return dev_err_probe(&spi->dev, ret,
> +                                    "DRDY irq not present\n");

This can be done much earlier and avoid unneeded resource allocations.

...

> +static int ad7779_suspend(struct device *dev)
> +{
> +       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +       struct ad7779_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       ret =3D ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_=
1,
> +                                   AD7779_MOD_POWERMODE_MSK,
> +                                   FIELD_PREP(AD7779_MOD_POWERMODE_MSK,
> +                                              AD7779_LOW_POWER));
> +       if (ret)
> +               return ret;
> +
> +       return 0;

  return ad7779_spi_write_mask(...);

> +}
> +
> +static int ad7779_resume(struct device *dev)
> +{
> +       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +       struct ad7779_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       ret =3D ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_=
1,
> +                                   AD7779_MOD_POWERMODE_MSK,
> +                                   FIELD_PREP(AD7779_MOD_POWERMODE_MSK,
> +                                              AD7779_HIGH_POWER));
> +       if (ret)
> +               return ret;
> +
> +       return 0;

Ditto.

> +}

...

> +static const struct spi_device_id ad7779_id[] =3D {
> +       {
> +               .name =3D "ad7770",
> +               .driver_data =3D (kernel_ulong_t)&ad7770_chip_info

Leave trailing comma.

> +       },
> +       {
> +               .name =3D "ad7771",
> +               .driver_data =3D (kernel_ulong_t)&ad7771_chip_info

Ditto.

> +       },
> +       {
> +               .name =3D "ad7779",
> +               .driver_data =3D (kernel_ulong_t)&ad7779_chip_info

Ditto.

> +       },
> +       { }
> +};

--=20
With Best Regards,
Andy Shevchenko

