Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A69319D8E2
	for <lists+linux-iio@lfdr.de>; Fri,  3 Apr 2020 16:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391008AbgDCOUq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Apr 2020 10:20:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34210 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDCOUp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Apr 2020 10:20:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id l14so3590825pgb.1;
        Fri, 03 Apr 2020 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xuBGO7d/R9GsrqUl1Eu2AH8e0oacW++coCFqKSXGCEw=;
        b=IkLfYcVoJ7oodw/fs6epj/4UmXEkwhCZjaCWRBsr5FKp/LqLwpp/eELKLEP80IN38z
         wzShE8El4vALLsz9A4S56TEtxArvsKxic8fwNiRtKrnjuzY6Nq/s11MPymFTDjMFg/6J
         TJneH6QQESP4YSLe1Fm2OemDIl5tKSUQrZSgtbrAOHn8/ha/feClLGWl7b2CRvRa+g0Y
         q0AdRoJQBlrzzFrqNcuyOu/2oFGhZTP2TmvDJV7Pi1EHquu+j31kTjZgauZQEZRPwvv/
         KZoY6nJb9i2v6fTT342Cq2qVlGfGz0nrLoXWgwOuzhw9coQDCZFaUvIFcX8Dff69I2hM
         hlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xuBGO7d/R9GsrqUl1Eu2AH8e0oacW++coCFqKSXGCEw=;
        b=ItuRbDU52XW5agMxIGKNkWRXlybOnO4EOZC/B/D7vw/HiOhpSQSjQU8k6z1okJYMNi
         LQvqhaB7j6+tM6GJ8iAeWJ62kqJtzMBtADnPL2iaKf7b/RiQGcOWidDpe9g1UnYiv75r
         B/+3w3kFpy3GLhebxH/dZbe38Qw7sOSA4BQDFQtDH9dSSa97c8rXJq92A6AllOfDo9qt
         QQ99mhwYQso9lZFdAvsFxKVJ1QOgNOVYAVsFgb5sHYtcLvj6UKCN1LVqhLxuSFKIYXLG
         m6jfSyr7hEoVTDVQ4oKxBYkoBQx3jq2HCvT3wEVPhmKedG2OF87Pab/GhMQWgNSdqOai
         pA0A==
X-Gm-Message-State: AGi0PuZg9JHH8uNOUnmDKn3rFA/nN4VRJIG2OgzJlpT2kZACi3wF5afE
        uPaSATbWNjC7uwF5XK8+GkZM0ykXf5OpX7kWhLs=
X-Google-Smtp-Source: APiQypISwIbhDDGd6rQlauqO+vA1GEf239ii+/RGEmn4uh1r0LnyEw67S3xEGro2YY2CetnA6ypxzahe+ZhLz/2m3I4=
X-Received: by 2002:aa7:958f:: with SMTP id z15mr8389692pfj.130.1585923643112;
 Fri, 03 Apr 2020 07:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200403121323.1742-1-alazar@startmail.com> <20200403121323.1742-3-alazar@startmail.com>
In-Reply-To: <20200403121323.1742-3-alazar@startmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Apr 2020 17:20:35 +0300
Message-ID: <CAHp75VcKEqM4nxvu3QtqNDpwtJU77zu=YfPwmCXn_L=LsGSuAQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] iio: adc: Add MAX1241 driver
To:     Alexandru Lazar <alazar@startmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 3, 2020 at 3:09 PM Alexandru Lazar <alazar@startmail.com> wrote:
>
> Add driver for the Maxim MAX1241 12-bit, single-channel ADC.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf

>

No blank line, but this can be fixed by maintainer, I think.

> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Alexandru Lazar <alazar@startmail.com>
> ---
>  drivers/iio/adc/Kconfig   |  10 ++
>  drivers/iio/adc/Makefile  |   1 +
>  drivers/iio/adc/max1241.c | 227 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 238 insertions(+)
>  create mode 100644 drivers/iio/adc/max1241.c
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 5d8540b7b427..55f6462cd93f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -566,6 +566,16 @@ config MAX1118
>           To compile this driver as a module, choose M here: the module will be
>           called max1118.
>
> +config MAX1241
> +       tristate "Maxim max1241 ADC driver"
> +       depends on SPI_MASTER
> +       help
> +         Say yes here to build support for Maxim max1241 12-bit, single-channel
> +         ADC.
> +
> +         To compile this driver as a module, choose M here: the module will be
> +         called max1241.
> +
>  config MAX1363
>         tristate "Maxim max1363 ADC driver"
>         depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index a1f1fbec0f87..37d6f17559dc 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_LTC2497) += ltc2497.o
>  obj-$(CONFIG_MAX1027) += max1027.o
>  obj-$(CONFIG_MAX11100) += max11100.o
>  obj-$(CONFIG_MAX1118) += max1118.o
> +obj-$(CONFIG_MAX1241) += max1241.o
>  obj-$(CONFIG_MAX1363) += max1363.o
>  obj-$(CONFIG_MAX9611) += max9611.o
>  obj-$(CONFIG_MCP320X) += mcp320x.o
> diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
> new file mode 100644
> index 000000000000..541939c7abca
> --- /dev/null
> +++ b/drivers/iio/adc/max1241.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MAX1241 low-power, 12-bit serial ADC
> + *
> + * Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#define MAX1241_VAL_MASK GENMASK(11, 0)
> +#define MAX1241_SHUTDOWN_DELAY_USEC 4
> +
> +enum max1241_id {
> +       max1241,
> +};
> +
> +struct max1241 {
> +       struct spi_device *spi;
> +       struct mutex lock;
> +       struct regulator *vdd;
> +       struct regulator *vref;
> +       struct gpio_desc *shutdown;
> +
> +       __be16 data ____cacheline_aligned;
> +};
> +
> +static const struct iio_chan_spec max1241_channels[] = {
> +       {
> +               .type = IIO_VOLTAGE,
> +               .indexed = 1,
> +               .channel = 0,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +                               BIT(IIO_CHAN_INFO_SCALE),
> +       },
> +};
> +
> +static int max1241_read(struct max1241 *adc)
> +{
> +       struct spi_transfer xfers[] = {
> +               /*
> +                * Begin conversion by bringing /CS low for at least
> +                * tconv us.
> +                */
> +               {
> +                       .len = 0,
> +                       .delay.value = 8,
> +                       .delay.unit = SPI_DELAY_UNIT_USECS,
> +               },
> +               /*
> +                * Then read two bytes of data in our RX buffer.
> +                */
> +               {
> +                       .rx_buf = &adc->data,
> +                       .len = 2,
> +               },
> +       };
> +
> +       return spi_sync_transfer(adc->spi, xfers, ARRAY_SIZE(xfers));
> +}
> +
> +static int max1241_read_raw(struct iio_dev *indio_dev,
> +                       struct iio_chan_spec const *chan,
> +                       int *val, int *val2, long mask)
> +{
> +       int ret, vref_uV;
> +       struct max1241 *adc = iio_priv(indio_dev);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               mutex_lock(&adc->lock);
> +
> +               if (adc->shutdown) {
> +                       gpiod_set_value(adc->shutdown, 0);
> +                       udelay(MAX1241_SHUTDOWN_DELAY_USEC);
> +                       ret = max1241_read(adc);
> +                       gpiod_set_value(adc->shutdown, 1);
> +               } else
> +                       ret = max1241_read(adc);
> +
> +               if (ret) {
> +                       mutex_unlock(&adc->lock);
> +                       return ret;
> +               }
> +
> +               *val = (be16_to_cpu(adc->data) >> 3) & MAX1241_VAL_MASK;
> +
> +               mutex_unlock(&adc->lock);
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SCALE:
> +               vref_uV = regulator_get_voltage(adc->vref);
> +
> +               if (vref_uV < 0)
> +                       return vref_uV;
> +
> +               *val = vref_uV / 1000;
> +               *val2 = 12;
> +
> +               return IIO_VAL_FRACTIONAL_LOG2;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static const struct iio_info max1241_info = {
> +       .read_raw = max1241_read_raw,
> +};
> +
> +static void max1241_disable_vdd_action(void *data)
> +{
> +       struct max1241 *adc = data;
> +       struct device *dev = &adc->spi->dev;
> +       int err;
> +
> +       err = regulator_disable(adc->vdd);
> +       if (err)
> +               dev_err(dev, "could not disable vdd regulator.\n");
> +}
> +
> +static void max1241_disable_vref_action(void *data)
> +{
> +       struct max1241 *adc = data;
> +       struct device *dev = &adc->spi->dev;
> +       int err;
> +
> +       err = regulator_disable(adc->vref);
> +       if (err)
> +               dev_err(dev, "could not disable vref regulator.\n");
> +}
> +
> +static int max1241_probe(struct spi_device *spi)
> +{
> +       struct device *dev = &spi->dev;
> +       struct iio_dev *indio_dev;
> +       struct max1241 *adc;
> +       int ret;
> +
> +       indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       adc = iio_priv(indio_dev);
> +       adc->spi = spi;
> +       mutex_init(&adc->lock);
> +
> +       spi_set_drvdata(spi, indio_dev);
> +
> +       adc->vdd = devm_regulator_get(dev, "vdd");
> +       if (IS_ERR(adc->vdd)) {
> +               dev_err(dev, "failed to get vdd regulator\n");
> +               return PTR_ERR(adc->vdd);
> +       }
> +
> +       ret = regulator_enable(adc->vdd);
> +       if (ret)
> +               return ret;
> +
> +       ret = devm_add_action_or_reset(dev, max1241_disable_vdd_action, adc);
> +       if (ret) {
> +               dev_err(dev, "could not set up vdd regulator cleanup action\n");
> +               return ret;
> +       }
> +
> +       adc->vref = devm_regulator_get(dev, "vref");
> +       if (IS_ERR(adc->vref)) {
> +               dev_err(dev, "failed to get vref regulator\n");
> +               return PTR_ERR(adc->vref);
> +       }
> +
> +       ret = regulator_enable(adc->vref);
> +       if (ret)
> +               return ret;
> +
> +       ret = devm_add_action_or_reset(dev, max1241_disable_vref_action, adc);
> +       if (ret) {
> +               dev_err(dev, "could not set up vref regulator cleanup action\n");
> +               return ret;
> +       }
> +
> +       adc->shutdown = devm_gpiod_get_optional(dev, "shutdown",
> +                                               GPIOD_OUT_HIGH);
> +       if (IS_ERR(adc->shutdown))
> +               return PTR_ERR(adc->shutdown);
> +
> +       if (adc->shutdown)
> +               dev_dbg(dev, "shutdown pin passed, low-power mode enabled");
> +       else
> +               dev_dbg(dev, "no shutdown pin passed, low-power mode disabled");
> +
> +       indio_dev->name = spi_get_device_id(spi)->name;
> +       indio_dev->dev.parent = dev;
> +       indio_dev->info = &max1241_info;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->channels = max1241_channels;
> +       indio_dev->num_channels = ARRAY_SIZE(max1241_channels);
> +
> +       return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct spi_device_id max1241_id[] = {
> +       { "max1241", max1241 },
> +       {}
> +};
> +
> +static const struct of_device_id max1241_dt_ids[] = {
> +       { .compatible = "maxim,max1241" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, max1241_dt_ids);
> +
> +static struct spi_driver max1241_spi_driver = {
> +       .driver = {
> +               .name = "max1241",
> +               .of_match_table = max1241_dt_ids,
> +       },
> +       .probe = max1241_probe,
> +       .id_table = max1241_id,
> +};
> +module_spi_driver(max1241_spi_driver);
> +
> +MODULE_AUTHOR("Alexandru Lazar <alazar@startmail.com>");
> +MODULE_DESCRIPTION("MAX1241 ADC driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
