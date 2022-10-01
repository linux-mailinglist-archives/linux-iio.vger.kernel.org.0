Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4546F5F2062
	for <lists+linux-iio@lfdr.de>; Sun,  2 Oct 2022 00:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJAWih (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Oct 2022 18:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJAWif (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2022 18:38:35 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9251365D4
        for <linux-iio@vger.kernel.org>; Sat,  1 Oct 2022 15:38:34 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id t18so1451209vsr.12
        for <linux-iio@vger.kernel.org>; Sat, 01 Oct 2022 15:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wRkgMF1bpd/OU5MyBEItH2m3SS1tYHebI10PCScACgs=;
        b=4A7LxzqNk5uCE4uFDa3J10SD2G3pyILDBcozjfOquT6woBNO3C7dUDQ+g5HYELPrEv
         /BecUlhqbEOJ41uNRBkuLvyp8lBLry5kZ6p1Fkd2OFlmpN0VNuzSaXeD3y9Rc2DC6rCE
         DGWN5xx9pqDB8eddkKbhE86LZPqyQPhUW9Yfpc/dD2YM9Dtto8oMJhLTbLA5cg9yRb3d
         P4hsPZPVxCs9VgOpmAr2alnbc6p7UV7Y6va+xu8R4KLPZHXrkABMHFdUsXpIaLSkmFzN
         VATt3SSGOurtUxJBfngZJhOio1+aV53p3JeiXbrjy1Kj6ONMl8xkoN+xnXedk87I/qq9
         Im2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wRkgMF1bpd/OU5MyBEItH2m3SS1tYHebI10PCScACgs=;
        b=EScAgql+C5YY2YpwcQcET6a/XpdfEdwG+9mU1RqJCE+smWED2nKHqLeD0Jgg1oIczW
         EixPyGJCdiHUqF47DH+7BnczOSqaYXwFLhAHD4FLNWQ7tSbX2B4h5p7QKJ/oE1Qv+5eI
         py4opvgybOj63cXHqrCJHo1A7RBZUrauHwMZEqtTzFdkcSslwU93xP1KPrkkVKZYwmXP
         prR3mNjFsTC5H0+h3hhsPMfrz4b/OJMj70pT6zzwyWEG88hhjEHkNx5aC2/0z1lhweQ0
         AgbYA+7DI6AsBT/1ZPHAg2EiaOwSMIWeeFPVUZIwNENEZ3mAnjJ1dNYGgaPeyIVKd3fL
         26ug==
X-Gm-Message-State: ACrzQf0hFYSo+x1Ma/1Sr0mD9wR4sG3y2L5qdx3+Owr37UYDdJRr8lez
        +QNijPKnhzdZXfBR2yyUct/8Dw3GQMIDoOLsDL2nKMikXHwqKA==
X-Google-Smtp-Source: AMsMyM7NykvliKRoglEaes349hvbj+DjeQlj+CIc8NXt+tPRrwhsQahduUplD9iFbv/5kKCDecCMH1s6oVzKaqiSbK8=
X-Received: by 2002:a05:6102:312c:b0:3a6:3bb4:5198 with SMTP id
 f12-20020a056102312c00b003a63bb45198mr1253244vsh.54.1664663912661; Sat, 01
 Oct 2022 15:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221001173104.492027-1-angelo.dureghello@timesys.com>
In-Reply-To: <20221001173104.492027-1-angelo.dureghello@timesys.com>
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
Date:   Sun, 2 Oct 2022 00:36:34 +0200
Message-ID: <CALJHbkDwzaqFtXXKGD7A37kUsOd=eih0T+Ku=wHkUH5a0Wr_tg@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: add support for max5522
To:     william.gray@linaro.org
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I apologize.
Please discard this wrong patch, resending.

regards,
angelo


On Sat, Oct 1, 2022 at 7:32 PM Angelo Dureghello
<angelo.dureghello@timesys.com> wrote:
>
> Add initial support for dac max5522.
>
> Tested writing DAC A and B with some values,
> from 0 to 1023, measured output voltages, driver works properly.
>
> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> ---
>  drivers/iio/dac/Kconfig   |   1 +
>  drivers/iio/dac/max5522.c | 159 ++++++++++++++++++++------------------
>  2 files changed, 86 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 52bb393d043b..91b284342db6 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -360,6 +360,7 @@ config MAX517
>  config MAX5522
>         tristate "Maxim MAX5522 DAC driver"
>         depends on SPI
> +       select REGMAP_SPI if SPI_MASTER
>         help
>           Support for the MAX5522 2 channels
>           Digital to Analog Converters (DAC).
> diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
> index 5d3dce0e6bb1..3932834cc7b7 100644
> --- a/drivers/iio/dac/max5522.c
> +++ b/drivers/iio/dac/max5522.c
> @@ -3,11 +3,10 @@
>   * Maxim MAX5522
>   * Dual, Ultra-Low-Power 10-Bit, Voltage-Output DACs
>   *
> - * Copyright 2022 TImesys (C)
> + * Copyright 2022 Timesys Corp.
>   */
>
>  #include <linux/device.h>
> -#include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
> @@ -20,7 +19,6 @@
>  #include <linux/iio/sysfs.h>
>
>  #define MAX5522_MAX_ADDR       15
> -
>  #define MAX5522_CTRL_NONE      0
>  #define MAX5522_CTRL_LOAD_IN_A 9
>  #define MAX5522_CTRL_LOAD_IN_B 10
> @@ -35,46 +33,33 @@ struct max5522_chip_info {
>  struct max5522_state {
>         struct regmap *regmap;
>         const struct max5522_chip_info *chip_info;
> -       struct mutex lock;
> +       unsigned short dac_cache[2];
> +       unsigned int vrefin_mv;
> +       struct regulator *vrefin_reg;
>  };
>
> -const struct iio_chan_spec max5522_channels[] = {
> -{
> -       .type = IIO_VOLTAGE,
> -       .indexed = 1,
> -       .output = 1,
> -       .channel = 0,
> -       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -                             BIT(IIO_CHAN_INFO_SCALE),
> -       .address = 0,
> -       .scan_type = {
> -               .sign = 'u',
> -               .realbits = 10,
> -               .storagebits = 16,
> -               .shift = 6,
> -       },
> -}, {
> -       .type = IIO_VOLTAGE,
> -       .indexed = 1,
> -       .output = 1,
> -       .channel = 1,
> -       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -                             BIT(IIO_CHAN_INFO_SCALE),
> -       .address = 1,
> -       .scan_type = {
> -               .sign = 'u',
> -               .realbits = 10,
> -               .storagebits = 16,
> -               .shift = 6,
> -       },
> +#define MAX5522_CHANNEL(chan) {        \
> +       .type = IIO_VOLTAGE, \
> +       .indexed = 1, \
> +       .output = 1, \
> +       .channel = chan, \
> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +                             BIT(IIO_CHAN_INFO_SCALE), \
> +       .scan_type = { \
> +               .sign = 'u', \
> +               .realbits = 10, \
> +               .storagebits = 16, \
> +               .shift = 2, \
> +       } \
>  }
> +
> +const struct iio_chan_spec max5522_channels[] = {
> +       MAX5522_CHANNEL(0),
> +       MAX5522_CHANNEL(1),
>  };
>
>  enum max5522_type {
>         ID_MAX5522,
> -       ID_MAX5523,
> -       ID_MAX5524,
> -       ID_MAX5525,
>  };
>
>  static const struct max5522_chip_info max5522_chip_info_tbl[] = {
> @@ -82,43 +67,54 @@ static const struct max5522_chip_info max5522_chip_info_tbl[] = {
>                 .channels = max5522_channels,
>                 .num_channels = 2,
>         },
> -       [ID_MAX5523] = {
> -               .channels = max5522_channels,
> -               .num_channels = 2,
> -       },
> -       [ID_MAX5524] = {
> -               .channels = max5522_channels,
> -               .num_channels = 2,
> -       },
> -       [ID_MAX5525] = {
> -               .channels = max5522_channels,
> -               .num_channels = 2,
> -       },
>  };
>
> -static unsigned int max5522_info_to_reg(struct iio_chan_spec const *chan,
> -                                       long info)
> +static inline int max5522_info_to_reg(struct iio_chan_spec const *chan)
>  {
> +       return MAX5522_REG_DATA(chan->channel);
> +}
> +
> +static int max5522_read_raw(struct iio_dev *indio_dev,
> +       struct iio_chan_spec const *chan, int *val, int *val2, long info)
> +{
> +       struct max5522_state *state = iio_priv(indio_dev);
> +
>         switch (info) {
>         case IIO_CHAN_INFO_RAW:
> -               return MAX5522_REG_DATA(chan->address);
> +               *val = state->dac_cache[chan->channel];
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SCALE:
> +               *val = state->vrefin_mv;
> +               *val2 = 10;
> +               return IIO_VAL_FRACTIONAL_LOG2;
>         default:
> -               break;
> +               return -EINVAL;
>         }
>
> -       return 0;
> +       return -EINVAL;
>  }
>
>  static int max5522_write_raw(struct iio_dev *indio_dev,
>         struct iio_chan_spec const *chan, int val, int val2, long info)
>  {
> -       struct max5522_state *st = iio_priv(indio_dev);
> +       struct max5522_state *state = iio_priv(indio_dev);
> +       int rval;
>
> -       return regmap_write(st->regmap, max5522_info_to_reg(chan, info),
> +       if (val > 1023 || val < 0)
> +               return -EINVAL;
> +
> +       rval = regmap_write(state->regmap, max5522_info_to_reg(chan),
>                                 val << chan->scan_type.shift);
> +       if (rval < 0)
> +               return rval;
> +
> +       state->dac_cache[chan->channel] = val;
> +
> +       return 0;
>  }
>
>  static const struct iio_info max5522_info = {
> +       .read_raw = max5522_read_raw,
>         .write_raw = max5522_write_raw,
>  };
>
> @@ -131,40 +127,61 @@ static void max5522_remove(struct device *dev)
>  }
>
>  static const struct regmap_config max5522_regmap_config = {
> -
> +       .reg_bits = 4,
>         .val_bits = 12,
> -
>         .max_register = MAX5522_MAX_ADDR,
> -       .cache_type = REGCACHE_RBTREE,
>  };
>
>  static int max5522_spi_probe(struct spi_device *spi)
>  {
>         const struct spi_device_id *id = spi_get_device_id(spi);
> -       struct regmap *regmap;
>         struct iio_dev *indio_dev;
> -       struct max5522_state *st;
> +       struct max5522_state *state;
> +       int ret;
>
> -       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
>         if (indio_dev == NULL) {
>                 dev_err(&spi->dev, "failed to allocate iio device\n");
>                 return  -ENOMEM;
>         }
>
> -       st = iio_priv(indio_dev);
> +       state = iio_priv(indio_dev);
> +       state->chip_info = &max5522_chip_info_tbl[id->driver_data];
>
> -       st->chip_info = &max5522_chip_info_tbl[id->driver_data];
> +       state->vrefin_reg = devm_regulator_get(&spi->dev, "vrefin");
> +       if (IS_ERR(state->vrefin_reg))
> +               return dev_err_probe(&spi->dev, PTR_ERR(state->vrefin_reg),
> +                                    "Vrefin regulator not specified\n");
> +
> +       ret = regulator_get_voltage(state->vrefin_reg);
> +       if (ret < 0) {
> +               dev_err(&spi->dev, "Failed to read vrefin regulator: %d\n",
> +                               ret);
> +               goto error_disable_vrefin_reg;
> +       }
> +       state->vrefin_mv = ret / 1000;
>
>         spi_set_drvdata(spi, indio_dev);
>
> -       regmap = devm_regmap_init_spi(spi, &max5522_regmap_config);
> +       state->regmap = devm_regmap_init_spi(spi, &max5522_regmap_config);
>
> -       if (IS_ERR(regmap))
> -               return PTR_ERR(regmap);
> +       if (IS_ERR(state->regmap))
> +               return PTR_ERR(state->regmap);
>
> -       dev_err(&spi->dev, "device probed\n");
> +       dev_info(&spi->dev, "iio dac ready");
>
> -       return 0;
> +       indio_dev->info = &max5522_info;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->channels = max5522_channels;
> +       indio_dev->num_channels = ARRAY_SIZE(max5522_channels);
> +       indio_dev->name = id->name;
> +
> +       return iio_device_register(indio_dev);
> +
> +error_disable_vrefin_reg:
> +       regulator_disable(state->vrefin_reg);
> +
> +       return ret;
>  }
>
>  static void max5522_spi_remove(struct spi_device *spi)
> @@ -174,9 +191,6 @@ static void max5522_spi_remove(struct spi_device *spi)
>
>  static const struct spi_device_id max5522_ids[] = {
>         { "max5522", ID_MAX5522 },
> -       { "max5522", ID_MAX5523 },
> -       { "max5522", ID_MAX5524 },
> -       { "max5525", ID_MAX5525 },
>         {}
>  };
>  MODULE_DEVICE_TABLE(spi, ad5360_ids);
> @@ -184,9 +198,6 @@ MODULE_DEVICE_TABLE(spi, ad5360_ids);
>
>  static const struct of_device_id max5522_of_match[] = {
>         { .compatible = "maxim,max5522", },
> -       { .compatible = "maxim,max5523", },
> -       { .compatible = "maxim,max5524", },
> -       { .compatible = "maxim,max5525", },
>         {},
>  };
>
> --
> 2.37.3
>


-- 
Angelo Dureghello
Timesys
e. angelo.dureghello@timesys.com
