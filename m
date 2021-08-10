Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA1C3DD452
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 12:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhHBKvy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 06:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhHBKvy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 06:51:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C36C0613D5
        for <linux-iio@vger.kernel.org>; Mon,  2 Aug 2021 03:51:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a20so19245478plm.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Aug 2021 03:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JtKSw+xQxWf2TzgDawjxde/8ddeemMhy/dNh5pKNbGQ=;
        b=lAoXRjYAqihJC085wrJlNaAR4+KUityR+8QIeSEucGLWII9Xd9qkU3bWjn+svpdj5y
         4gjRxqhS1Zr9mXyZ1av/KhirSYr5AKW5Zfxu6mU04G2ELmOn0XGqcijVI1PMjYgnMZlD
         hfb5FSkC/DOgjoaT+rgJm644CeBFl0PhGgDrVw5jv5Q9suUAG+FNpGAmjU8mnGYy9adI
         LAakslckWnMH4GdGnaRMDTP+rFKPs4giG8psP0Br32vKgXuCWBpd81X7UmGOZ9uizWCV
         p3LzXb8BOu7hfpu53kEfVQHa+lauzNXS6kSzxxz1a9sd0qlVrs7k+RNy0qBY1QcqjwnZ
         r+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JtKSw+xQxWf2TzgDawjxde/8ddeemMhy/dNh5pKNbGQ=;
        b=jknc3MbPdccqslSFzY8qNHTg8ngfk7i2Z+ZEgmolbNA2Wb+Z7YHfm6VLMQ7aPFVpg3
         FNhrgYVgL+9NDmPmyRNG9RYiaLPLHFj36JeqtLPVpj+M6capmCu3VAtRSib3K572R+6N
         iq2SgQnPGZI/2HLW5yhJn2TPuBGci9DZrPDcyyAqQAGo0QtT1ne12ajG30eTfFFNXsr2
         GL2sMMzLA5xWa1uMtskGLHdortoxoMLxfwtpNFkaY/HFvkrOgRIcjnxKTNUWg1TH1Rwj
         wNEnGPz03HX3QUZcWltRnQr80Nxm7dfM7DJS5bmCH1J0dbEsANO4aAKQ9GsGwHgtIW6/
         pusw==
X-Gm-Message-State: AOAM533nASoeeuizPeX8grfWRrI+EP5AzsTuhSkl8MRNiAP+d2phd8p1
        Jw0Q17pSPUeaIhderVIFuYB+b+7FoQWerk8mxCTWVWITbuAUWg==
X-Google-Smtp-Source: ABdhPJwwJ+KMd+qbwAOqrSYuhxQiDvFEfGSMkJ8R1i503CS//HkMMGsIr7IybypRiU8v/VHnXCtefDVMZaCH9HOX3X8=
X-Received: by 2002:a63:7209:: with SMTP id n9mr157052pgc.253.1627901503642;
 Mon, 02 Aug 2021 03:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210802102131.856129-1-giometti@enneenne.com>
In-Reply-To: <20210802102131.856129-1-giometti@enneenne.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 2 Aug 2021 13:51:31 +0300
Message-ID: <CA+U=Dsr9UE0s_ocM=zgw0Zps-bEdgQTN-rV39Hy7GPX9rqwVcA@mail.gmail.com>
Subject: Re: [PATCH] drivers iio/adc: add driver for Texas Instruments TLA2528 adc
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 2, 2021 at 1:29 PM Rodolfo Giometti <giometti@enneenne.com> wrote:
>
> This adds a new driver for the TI TLA2528 ADC chip.
>

Hey,

The driver looks really good.

A general note:  the `drivers` prefix in the patch title could be removed

A few more notes inline.

> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> ---
>  drivers/iio/adc/Kconfig      |  10 ++
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/ti-tla2528.c | 246 +++++++++++++++++++++++++++++++++++
>  3 files changed, 257 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-tla2528.c
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index db0c8fb60515..f42e6d84c8f3 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1178,6 +1178,16 @@ config TI_AM335X_ADC
>           To compile this driver as a module, choose M here: the module will be
>           called ti_am335x_adc.
>
> +config TI_TLA2528
> +       tristate "Texas Instruments TLA2528 ADC driver"
> +       depends on I2C
> +       help
> +         Say yes here to build support for Texas Instruments TLA2528
> +         12-Bit 8-Channel ADC.
> +
> +         To compile this driver as a module, choose M here: the module will be
> +         called ti-tla2528.
> +
>  config TI_TLC4541
>         tristate "Texas Instruments TLC4541 ADC driver"
>         depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index f70d877c555a..0bf287672838 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -105,6 +105,7 @@ obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
>  obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
>  obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
> +obj-$(CONFIG_TI_TLA2528) += ti-tla2528.o
>  obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
>  obj-$(CONFIG_TI_TSC2046) += ti-tsc2046.o
>  obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
> diff --git a/drivers/iio/adc/ti-tla2528.c b/drivers/iio/adc/ti-tla2528.c
> new file mode 100644
> index 000000000000..4512362e1d2e
> --- /dev/null
> +++ b/drivers/iio/adc/ti-tla2528.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Texas Instruments TLA2528 ADC
> + *
> + * Copyright (C) 2020-2021 Rodolfo Giometti <giometti@enneenne.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/of.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define TLA2528_OP_READ_REG            0x10
> +#define TLA2528_OP_WRITE_REG           0x08
> +
> +#define TLA2528_GENERAL_CFG            0x01
> +#define TLA2528_GENERAL_CFG_CNVST      BIT(3)
> +#define TLA2528_DATA_CFG               0x02
> +#define TLA2528_DATA_CFG_APPEND_STATUS BIT(4)
> +#define TLA2528_DATA_CFG_FIX_PAT       BIT(7)
> +#define TLA2528_PIN_CFG                        0x05
> +#define TLA2528_SEQUENCE_CFG           0x10
> +#define TLA2528_CHANNEL_SEL            0x11
> +
> +struct tla2528_st {
> +       struct i2c_client *client;
> +       struct regulator *ref;
> +
> +       u8 last_read_channel;
> +};
> +
> +static s32 i2c_smbus_read_sample(const struct i2c_client *client)
> +{
> +       struct i2c_msg msg[1];
> +       u8 data[2];
> +       int ret;
> +
> +       msg[0].addr = client->addr;
> +       msg[0].flags = I2C_M_RD;
> +       msg[0].buf = (u8 *) &data;
> +       msg[0].len = 2;
> +
> +       ret = i2c_transfer(client->adapter, msg, 1);
> +
> +       return (ret < 0) ? ret : le16_to_cpu(data[1] | (data[0] << 8));

this line does quite a lot of things;
one preferred way to do things would be:

if (ret < 0)
   return ret;

return le16_to_cpu(data[1] | (data[0] << 8));

> +}
> +
> +static s32 i2c_smbus_write_reg(const struct i2c_client *client, u8 reg, u8 val)
> +{
> +       struct i2c_msg msg[1];
> +       u8 cmd[3] = {TLA2528_OP_WRITE_REG, reg, val};
> +
> +       msg[0].addr = client->addr;
> +       msg[0].flags = 0;
> +       msg[0].buf = cmd;
> +       msg[0].len = 3;
> +
> +       return i2c_transfer(client->adapter, msg, 1);
> +}
> +
> +static int tla2528_read(struct tla2528_st *st, u8 channel, int *val)
> +{
> +       struct i2c_client *client = st->client;
> +       int ret;
> +
> +       if (channel != st->last_read_channel) {
> +               ret = i2c_smbus_write_reg(st->client,
> +                                       TLA2528_CHANNEL_SEL, channel);
> +               if (ret < 0)
> +                       return ret;
> +
> +               st->last_read_channel = channel;
> +       }
> +
> +       /* Read ADC data (2 bytes) */
> +       ret = i2c_smbus_read_sample(client);
> +       if (ret < 0)  {
> +               dev_err(&client->dev, "i2c_master_recv failed\n");
> +               return ret;
> +       }
> +       *val = ret >> 4;
> +
> +       return 0;
> +}
> +
> +static int tla2528_read_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan,
> +                           int *val, int *val2, long mask)
> +{
> +       struct tla2528_st *st = iio_priv(indio_dev);
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               mutex_lock(&indio_dev->mlock);
> +               ret = tla2528_read(st, chan->channel, val);
> +               mutex_unlock(&indio_dev->mlock);
> +               if (ret < 0)
> +                       return ret;
> +
> +               return IIO_VAL_INT;
> +
> +       case IIO_CHAN_INFO_SCALE:
> +               ret = regulator_get_voltage(st->ref);
> +               if (ret < 0)
> +                       return ret;
> +
> +               *val = ret / 1000;
> +               *val2 = 12;
> +
> +               return IIO_VAL_FRACTIONAL_LOG2;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +#define TLA2528_CHAN(_chan, _name) { \
> +       .type = IIO_VOLTAGE,                                    \
> +       .channel = (_chan),                                     \
> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
> +       .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),   \
> +       .datasheet_name = _name,                                \
> +       .indexed = 1,                                           \
> +}
> +
> +static const struct iio_chan_spec tla2528_channel[] = {
> +       TLA2528_CHAN(0, "AIN0"),
> +       TLA2528_CHAN(1, "AIN1"),
> +       TLA2528_CHAN(2, "AIN2"),
> +       TLA2528_CHAN(3, "AIN3"),
> +       TLA2528_CHAN(4, "AIN4"),
> +       TLA2528_CHAN(5, "AIN5"),
> +       TLA2528_CHAN(6, "AIN6"),
> +       TLA2528_CHAN(7, "AIN7"),
> +};
> +
> +static const struct iio_info tla2528_info = {
> +       .read_raw = tla2528_read_raw,
> +};
> +
> +static int tla2528_probe(struct i2c_client *client,
> +                        const struct i2c_device_id *id)
> +{
> +       struct iio_dev *indio_dev;
> +       struct tla2528_st *st;
> +       int ret;
> +
> +       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> +                                    I2C_FUNC_SMBUS_WRITE_BYTE))
> +               return -EOPNOTSUPP;
> +
> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       st = iio_priv(indio_dev);
> +       i2c_set_clientdata(client, indio_dev);
> +       st->client = client;
> +
> +       indio_dev->dev.parent = &client->dev;

this assignment can be removed;
in newer kernels {devm_}iio_device_alloc() assigns the parent of the
iio_dev object

> +       indio_dev->name = id->name;
> +       indio_dev->info = &tla2528_info;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->channels = tla2528_channel;
> +       indio_dev->num_channels = ARRAY_SIZE(tla2528_channel);
> +
> +       st->ref = devm_regulator_get(&client->dev, "vref");
> +       if (IS_ERR(st->ref))
> +               return PTR_ERR(st->ref);
> +
> +       ret = regulator_enable(st->ref);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* Set all inputs as analog */
> +       ret = i2c_smbus_write_reg(st->client, TLA2528_PIN_CFG, 0x00);
> +       if (ret < 0)
> +               goto err_regulator_disable;
> +
> +       ret = i2c_smbus_write_reg(st->client, TLA2528_DATA_CFG,
> +                                       TLA2528_DATA_CFG_APPEND_STATUS);

minor: alignment of this line looks a little off

> +       if (ret < 0)
> +               goto err_regulator_disable;
> +
> +       /* Set manual mode */
> +       ret = i2c_smbus_write_reg(st->client, TLA2528_SEQUENCE_CFG, 0x00);
> +       if (ret < 0)
> +               goto err_regulator_disable;
> +
> +       /* Init private data */
> +       st->last_read_channel = ~0;
> +
> +       ret = iio_device_register(indio_dev);
> +       if (ret < 0)
> +               goto err_regulator_disable;
> +
> +       return 0;
> +
> +err_regulator_disable:
> +       regulator_disable(st->ref);
> +
> +       return ret;
> +}
> +
> +static int tla2528_remove(struct i2c_client *client)
> +{
> +       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +       struct tla2528_st *st = iio_priv(indio_dev);
> +
> +       iio_device_unregister(indio_dev);
> +       regulator_disable(st->ref);
> +
> +       return 0;
> +}
> +
> +static const struct i2c_device_id tla2528_id[] = {
> +       { "tla2528", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, tla2528_id);
> +
> +static const struct of_device_id tla2528_of_match[] = {
> +       { .compatible = "ti,tla2528", },
> +       {},

nitpick: remove command from null-terminator;

> +};
> +MODULE_DEVICE_TABLE(of, tla2528_of_match);
> +
> +static struct i2c_driver tla2528_driver = {
> +       .driver = {
> +               .name = "tla2528",
> +               .of_match_table = of_match_ptr(tla2528_of_match),

of_match_ptr() can be removed;
this can help the driver probe with ACPI later [if someone else wants to try it]

> +       },
> +       .probe = tla2528_probe,
> +       .remove = tla2528_remove,
> +       .id_table = tla2528_id,
> +};
> +module_i2c_driver(tla2528_driver);
> +
> +MODULE_AUTHOR("Rodolfo Giometti <giometti@enneenne.com>");
> +MODULE_DESCRIPTION("Texas Instruments TLA2528 ADC driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.25.1
>
