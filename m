Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD71C3E4109
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 09:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhHIHrc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 03:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbhHIHrb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 03:47:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85365C0613CF;
        Mon,  9 Aug 2021 00:47:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c24so5294240lfi.11;
        Mon, 09 Aug 2021 00:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=95DgjYsJqVmq4MdhlTcH4MrWr0NBdjqbFECgPrk7ymQ=;
        b=SDJQMlcIPwtsV0R2J0lnm8o9sH35K6pblpzZGX72WJip4axoCpqRd3b60UCxYRAKfi
         fmGqGqvgJ3oSIifJhUuXhtSTuNyZtGlL5bBNtoGZtjblLI0U5Ii+f5dtVU0Xz3B58gRy
         l/9VXKsDRPJz4r+p+Ga3CQhwe2AK97VuHEm1s8L85lpowKmQ/AHsdp7uDntptQ49RKqo
         /9Y4QaWwLl9PiexCobD+clm1AwirUkV844CE/Hiax+VHIemEcJVAO76kFeRuMBQO7L5F
         Vj76QSGHDiIvAGG8eIkIfqP6J9+eZ7LAI27DdNy1AhG5o+Re+xk+FadV+5+Oe/99HLjn
         YWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=95DgjYsJqVmq4MdhlTcH4MrWr0NBdjqbFECgPrk7ymQ=;
        b=nMtBQ6FKt0stYWgAbZfvjmr1x2qsAfmJcmrulKfqsA61ELS+bVT5WiFj2bQ/UByp7L
         rzClAGN3arCoVM5GMQpRIo9bGuGVg1IQa4NJTtkY6mI6upm5qY2Wx07zLMfb1iD6dgY6
         gSxuWV3KlxVW8wIUPjsfM5IQEXafOQnHmyD27gx82piFqK7t5APPhD2Vf/R52wHGkp01
         wuMaEVmw6o1UB1qLDSIQL8e2Td6ez6+Cd2tjc1UGmiU+EWqnYbSO4H1XDT+fiYHerphU
         scaQNovM9IhbzvrkqMlQrVNN6kXIM21DEyLSyt/P6m2bAPljVjlc3w4oP6oyeAsw43Tm
         iGeQ==
X-Gm-Message-State: AOAM531Z4LCEFAqwZcH38cs9s9se0D+4TeXHAZaNRUuaagAk+ytSYgH7
        Z+6V5VjNJknZiNt9p7qu8D00WljjW3ewWRbnFWA=
X-Google-Smtp-Source: ABdhPJxmAhamE5VsnMPXj122P2Fb16hxt1wIBK/qCkCgXT+eFD/CzbLkEGWz1znxiYY5dR/rTqECCGT00iCpHMNWujE=
X-Received: by 2002:ac2:4c13:: with SMTP id t19mr16578544lfq.450.1628495229877;
 Mon, 09 Aug 2021 00:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210809074512.34757-1-puranjay12@gmail.com> <20210809074512.34757-3-puranjay12@gmail.com>
In-Reply-To: <20210809074512.34757-3-puranjay12@gmail.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Mon, 9 Aug 2021 13:16:58 +0530
Message-ID: <CANk7y0gXwMPqAXDTcB-w9MiM=fwjQrSWauXnw9G-V2QohF=CAg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] iio: accel: adxl355: Add triggered buffer support
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Please ignore this patch.
It was sent by mistake, it is not supposed to be a part of this series.

On Mon, Aug 9, 2021 at 1:15 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Provide a way for continuous data capture by setting up buffer support. The
> data ready signal exposed at the DRDY pin of the ADXL355 is exploited as
> a hardware interrupt which triggers to fill the buffer.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  drivers/iio/accel/Kconfig        |   4 ++
>  drivers/iio/accel/adxl355.h      |   2 +-
>  drivers/iio/accel/adxl355_core.c | 102 ++++++++++++++++++++++++++++++-
>  drivers/iio/accel/adxl355_i2c.c  |   3 +-
>  drivers/iio/accel/adxl355_spi.c  |   2 +-
>  5 files changed, 108 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index d0c45c809..9c16c1841 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -69,6 +69,8 @@ config ADXL355_I2C
>         depends on I2C
>         select ADXL355
>         select REGMAP_I2C
> +       select IIO_BUFFER
> +       select IIO_TRIGGERED_BUFFER
>         help
>           Say Y here if you want to build i2c support for the Analog Devices
>           ADXL355 3-axis digital accelerometer.
> @@ -82,6 +84,8 @@ config ADXL355_SPI
>         depends on SPI
>         select ADXL355
>         select REGMAP_SPI
> +       select IIO_BUFFER
> +       select IIO_TRIGGERED_BUFFER
>         help
>           Say Y here if you want to build spi support for the Analog Devices
>           ADXL355 3-axis digital accelerometer.
> diff --git a/drivers/iio/accel/adxl355.h b/drivers/iio/accel/adxl355.h
> index 322b0abb8..f0a376e6d 100644
> --- a/drivers/iio/accel/adxl355.h
> +++ b/drivers/iio/accel/adxl355.h
> @@ -15,5 +15,5 @@ extern const struct regmap_access_table adxl355_readable_regs_tbl;
>  extern const struct regmap_access_table adxl355_writeable_regs_tbl;
>
>  int adxl355_core_probe(struct device *dev, struct regmap *regmap,
> -                      const char *name);
> +                      const char *name, int irq);
>  #endif /* _ADXL355_H_ */
> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> index d1163cde1..45397dcce 100644
> --- a/drivers/iio/accel/adxl355_core.c
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -9,6 +9,10 @@
>
>  #include <asm/unaligned.h>
>  #include <linux/bitfield.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/limits.h>
>  #include <linux/math64.h>
> @@ -153,6 +157,7 @@ static const struct adxl355_chan_info adxl355_chans[] = {
>  };
>
>  struct adxl355_data {
> +       int irq;
>         struct regmap *regmap;
>         struct device *dev;
>         struct mutex lock; /* lock to protect op_mode */
> @@ -162,6 +167,12 @@ struct adxl355_data {
>         int calibbias[3];
>         int adxl355_hpf_3db_table[7][2];
>         u8 transf_buf[3] ____cacheline_aligned;
> +       struct iio_trigger      *dready_trig;
> +       /* Ensure correct alignment of timestamp when present */
> +       struct {
> +               __be32 channels[3];
> +               s64 ts;
> +       } buffer ____cacheline_aligned;
>  };
>
>  static int adxl355_set_op_mode(struct adxl355_data *data,
> @@ -493,12 +504,46 @@ static int adxl355_read_avail(struct iio_dev *indio_dev,
>         }
>  }
>
> +static const unsigned long adxl355_avail_scan_masks[] = {
> +       GENMASK(3, 0),
> +       0
> +};
> +
>  static const struct iio_info adxl355_info = {
>         .read_raw       = adxl355_read_raw,
>         .write_raw      = adxl355_write_raw,
>         .read_avail     = &adxl355_read_avail
>  };
>
> +static const struct iio_trigger_ops adxl355_trigger_ops = {
> +       .validate_device = &iio_trigger_validate_own_device,
> +};
> +
> +static irqreturn_t adxl355_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev = pf->indio_dev;
> +       struct adxl355_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       mutex_lock(&data->lock);
> +
> +       ret = regmap_bulk_read(data->regmap, ADXL355_XDATA3_REG,
> +                              data->buffer.channels,
> +                              9);
> +       if (ret)
> +               goto out_unlock_notify;
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> +                                          pf->timestamp);
> +
> +out_unlock_notify:
> +       mutex_unlock(&data->lock);
> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}
> +
>  #define ADXL355_ACCEL_CHANNEL(index, reg, axis) {                      \
>         .type = IIO_ACCEL,                                              \
>         .address = reg,                                                 \
> @@ -512,6 +557,7 @@ static const struct iio_info adxl355_info = {
>         .info_mask_shared_by_type_available =                           \
>                 BIT(IIO_CHAN_INFO_SAMP_FREQ) |                          \
>                 BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),      \
> +       .scan_index = index,                                            \
>         .scan_type = {                                                  \
>                 .sign = 's',                                            \
>                 .realbits = 20,                                         \
> @@ -531,17 +577,56 @@ static const struct iio_chan_spec adxl355_channels[] = {
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>                                       BIT(IIO_CHAN_INFO_SCALE) |
>                                       BIT(IIO_CHAN_INFO_OFFSET),
> +               .scan_index = 3,
>                 .scan_type = {
>                         .sign = 's',
>                         .realbits = 12,
>                         .storagebits = 16,
>                         .endianness = IIO_BE,
>                 },
> -       }
> +       },
> +       IIO_CHAN_SOFT_TIMESTAMP(4)
>  };
>
> +static int adxl355_probe_trigger(struct iio_dev *indio_dev)
> +{
> +       struct adxl355_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       if (!data->irq) {
> +               dev_info(data->dev, "no irq, using polling\n");
> +               return 0;
> +       }
> +
> +       data->dready_trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
> +                                                  indio_dev->name,
> +                                                  indio_dev->id);
> +       if (!data->dready_trig)
> +               return -ENOMEM;
> +
> +       data->dready_trig->ops = &adxl355_trigger_ops;
> +       iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> +
> +       ret = devm_request_irq(data->dev, data->irq,
> +                              &iio_trigger_generic_data_rdy_poll,
> +                              IRQF_ONESHOT, "adxl355_irq", data->dready_trig);
> +       if (ret < 0)
> +               return dev_err_probe(data->dev, ret, "request irq %d failed\n",
> +                                    data->irq);
> +
> +       ret = devm_iio_trigger_register(data->dev, data->dready_trig);
> +       if (ret) {
> +               dev_err(data->dev, "iio trigger register failed\n");
> +               return ret;
> +       }
> +
> +       indio_dev->trig = iio_trigger_get(data->dready_trig);
> +
> +       return 0;
> +}
> +
>  int adxl355_core_probe(struct device *dev, struct regmap *regmap,
> -                      const char *name)
> +                      const char *name, int irq)
>  {
>         struct adxl355_data *data;
>         struct iio_dev *indio_dev;
> @@ -554,6 +639,7 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
>         data = iio_priv(indio_dev);
>         data->regmap = regmap;
>         data->dev = dev;
> +       data->irq = irq;
>         data->op_mode = ADXL355_STANDBY;
>         mutex_init(&data->lock);
>
> @@ -562,6 +648,7 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = adxl355_channels;
>         indio_dev->num_channels = ARRAY_SIZE(adxl355_channels);
> +       indio_dev->available_scan_masks = adxl355_avail_scan_masks;
>
>         ret = adxl355_setup(data);
>         if (ret < 0) {
> @@ -569,6 +656,17 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
>                 return ret;
>         }
>
> +       ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +                                             &iio_pollfunc_store_time,
> +                                             &adxl355_trigger_handler, NULL);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret,
> +                                    "iio triggered buffer setup failed\n");
> +
> +       ret = adxl355_probe_trigger(indio_dev);
> +       if (ret < 0)
> +               return ret;
> +
>         return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_GPL(adxl355_core_probe);
> diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_i2c.c
> index e3070ee81..c18521819 100644
> --- a/drivers/iio/accel/adxl355_i2c.c
> +++ b/drivers/iio/accel/adxl355_i2c.c
> @@ -31,7 +31,8 @@ static int adxl355_i2c_probe(struct i2c_client *client)
>                 return PTR_ERR(regmap);
>         }
>
> -       return adxl355_core_probe(&client->dev, regmap, client->name);
> +       return adxl355_core_probe(&client->dev, regmap, client->name,
> +                                 client->irq);
>  }
>
>  static const struct i2c_device_id adxl355_i2c_id[] = {
> diff --git a/drivers/iio/accel/adxl355_spi.c b/drivers/iio/accel/adxl355_spi.c
> index a16bd1407..f9ba153f6 100644
> --- a/drivers/iio/accel/adxl355_spi.c
> +++ b/drivers/iio/accel/adxl355_spi.c
> @@ -34,7 +34,7 @@ static int adxl355_spi_probe(struct spi_device *spi)
>                 return PTR_ERR(regmap);
>         }
>
> -       return adxl355_core_probe(&spi->dev, regmap, id->name);
> +       return adxl355_core_probe(&spi->dev, regmap, id->name, spi->irq);
>  }
>
>  static const struct spi_device_id adxl355_spi_id[] = {
> --
> 2.30.1
>


-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
