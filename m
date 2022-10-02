Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380425F2544
	for <lists+linux-iio@lfdr.de>; Sun,  2 Oct 2022 22:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiJBUfD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Oct 2022 16:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJBUfC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2022 16:35:02 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8CD15725
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 13:34:59 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id r193so4592959vke.13
        for <linux-iio@vger.kernel.org>; Sun, 02 Oct 2022 13:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zgqs60F301pgabU/+9oujrfpsy56fQmCMYz4uw7ijK0=;
        b=gYpFOfwRB3UgwMpjOuohbh5v90GVGAfjZkTFenpFcBTAewUO2JiPdl8t8LLWVBP3VE
         igABUffwm5O0dQQn0UUUe4nPWEuc7zDu5lLqvTe2rwiMBCNpiE9Qc7OxUQAxmuPxK3Q7
         Zo1TXDkjRy6njm+iwxs1BOQEuNmEUUPJhZbuMn2dpMTwL97zmbFlwYfz50jmVlhDFlXH
         2ZjeYLNUQAA9e4S3KaBqqZBq4hVZizAjnBnnA6ILX5aKPRfS1ELUCWunU/kGBzeGvnUn
         0cSddZjpmKco3p902crUcpxEZUfmPbF7IE87FlOC9dNsqo93KVkSdITewtNqOJSIfFtU
         uMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zgqs60F301pgabU/+9oujrfpsy56fQmCMYz4uw7ijK0=;
        b=jqwClnxK8rVmdl/bIPr2Fz9KxqVKxczn9n/N7rxd95IwV8V+1R6xg5wP2afR5Lv4gf
         0/Tzf8Rl7N+wV6kyC66lgmqssZZ+ogDZ9j0uzzlltTgI2xCgmD2rsfbrpW0x9h/Wa+53
         TDrJwui+EZsPhObyE1j8NhyliJNFWQX6rO52i9QkiYU1ENctJhGv7AkNbh4MNaua1PeW
         NThdEP4Auzt9HY9F1U5yb03Ns0QREKd8GkX4yd1BdoovNQKfB9mBw0nmmbT4TsH7awzo
         szBG2dVwbaDY/lBqJP3I4Y3gbrAfQFMtjRhed/j0VmoNUny/cOwEKXw/aS+ZGtUrlYJF
         K2Rw==
X-Gm-Message-State: ACrzQf0trxDXcM5Rct0EDBtEqpa5eUQdhBZw3iQjzspP7ybccZ6L4ata
        dBWQ5sPOYhoVleEM+tbJx2nb1jqJAwVHM6d+Rbd9jQ==
X-Google-Smtp-Source: AMsMyM6TeNEmB5dQqU5JZPDif8yzuEKuuZt26iM0fOZTi76OJhuOYYLjNte6Yuu6nk9mt9F7daAInoD9Bi5neonEtDA=
X-Received: by 2002:a05:6122:812:b0:3a9:9cf9:8f91 with SMTP id
 18-20020a056122081200b003a99cf98f91mr3561429vkj.23.1664742898590; Sun, 02 Oct
 2022 13:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221001221225.668378-1-angelo.dureghello@timesys.com> <20221002125625.661b118d@jic23-huawei>
In-Reply-To: <20221002125625.661b118d@jic23-huawei>
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
Date:   Sun, 2 Oct 2022 22:32:59 +0200
Message-ID: <CALJHbkBPg=+N_6q+cVpFbmwM0mJbUhuH3wwWKma7GzaR1r1owQ@mail.gmail.com>
Subject: Re: [PATCH resend] iio: dac: add support for max5522
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     william.gray@linaro.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

thanks a lot for all the feedbacks,

On Sun, Oct 2, 2022 at 1:56 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun,  2 Oct 2022 00:12:25 +0200
> Angelo Dureghello <angelo.dureghello@timesys.com> wrote:
>
> > Add initial support for dac max5522.
>
> DAC preferred for comments.
>
ok, fixed

> >
> > Tested writing DAC A and B with some values,
> > from 0 to 1023, measured output voltages, driver works properly.
> >
> > Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
>
> Hi Angelo
>
> A quick review inline.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/dac/Kconfig   |  13 ++
> >  drivers/iio/dac/Makefile  |   1 +
> >  drivers/iio/dac/max5522.c | 246 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 260 insertions(+)
> >  create mode 100644 drivers/iio/dac/max5522.c
> >
> > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > index 80521bd28d0f..262688b5e39f 100644
> > --- a/drivers/iio/dac/Kconfig
> > +++ b/drivers/iio/dac/Kconfig
> > @@ -357,6 +357,19 @@ config MAX517
> >         This driver can also be built as a module.  If so, the module
> >         will be called max517.
> >
> > +config MAX5522
> > +     tristate "Maxim MAX5522 DAC driver"
> > +     depends on SPI
> Hmm. We only have one instance of the pattern and that's more complex because
> it's a driver that supports both SPI and I2C. Simpler to have (unless I'm missing
> something!)
>
>         depends on SPI_MASTER
>         select REGMAP_SPI
>
Not sure i am understanding this point, device is SPI only.
Anyway, ok, i changed as you are suggesting.

>
> > +     select REGMAP_SPI if SPI_MASTER
> > +     help
> > +       Say Y here if you want to build a driver for the Maxinm MAX5522.
>
> Maxim
ack, fixed

>
> > +
> > +       MAX5522 is a dual, ultra-low-power, 10-Bit, voltage-output
> > +       digital to analog converter (DAC) offering rail-to-rail buffered
> > +       voltage outputs.
> > +
> > +       If compiled as a module, it will be called max5522.
> > +
> >  config MAX5821
> >       tristate "Maxim MAX5821 DAC driver"
> >       depends on I2C
> > diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> > index ec3e42713f00..6c74fea21736 100644
> > --- a/drivers/iio/dac/Makefile
> > +++ b/drivers/iio/dac/Makefile
> > @@ -38,6 +38,7 @@ obj-$(CONFIG_LTC2632) += ltc2632.o
> >  obj-$(CONFIG_LTC2688) += ltc2688.o
> >  obj-$(CONFIG_M62332) += m62332.o
> >  obj-$(CONFIG_MAX517) += max517.o
> > +obj-$(CONFIG_MAX5522) += max5522.o
> >  obj-$(CONFIG_MAX5821) += max5821.o
> >  obj-$(CONFIG_MCP4725) += mcp4725.o
> >  obj-$(CONFIG_MCP4922) += mcp4922.o
> > diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
> > new file mode 100644
> > index 000000000000..aa4098a1d68c
> > --- /dev/null
> > +++ b/drivers/iio/dac/max5522.c
> > @@ -0,0 +1,246 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Maxim MAX5522
> > + * Dual, Ultra-Low-Power 10-Bit, Voltage-Output DACs
> > + *
> > + * Copyright 2022 Timesys Corp.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/slab.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> Alphabetical order for this block is slightly wrong.
ack, fixed

>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
>
> You aren't using any custom attributes so shouldn't need iio/sysfs.h
ack, fixed

> > +
> > +#define MAX5522_MAX_ADDR     15
> > +#define MAX5522_CTRL_NONE    0
> > +#define MAX5522_CTRL_LOAD_IN_A       9
> > +#define MAX5522_CTRL_LOAD_IN_B       10
> > +
> > +#define MAX5522_REG_DATA(x)  (x + MAX5522_CTRL_LOAD_IN_A)
>
> ((x) + MAX5522_CTRL_LOAD_IN_A)
> to protect against cases where the macro parameter is non trivial.
> It's easier to do this here than make a reader go check!
>
ack, fixed

> > +
> > +struct max5522_chip_info {
> > +     const struct iio_chan_spec *channels;
> > +     unsigned int num_channels;
> > +};
> > +
> > +struct max5522_state {
> > +     struct regmap *regmap;
> > +     const struct max5522_chip_info *chip_info;
> > +     unsigned short dac_cache[2];
> > +     unsigned int vrefin_mv;
>
> In theory voltages can change and sensible userspace software will only read them
> in a slow path anyway, so I'd just move the voltage readback into the
> read_raw() callback and drop this cache of the value.
>
Sorry, not clear. This device does not provide read operations.
There is only write operation and DIN spi pin.

> > +     struct regulator *vrefin_reg;
> > +};
> > +
> > +#define MAX5522_CHANNEL(chan) {      \
> > +     .type = IIO_VOLTAGE, \
> > +     .indexed = 1, \
> > +     .output = 1, \
> > +     .channel = chan, \
> > +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> > +                           BIT(IIO_CHAN_INFO_SCALE), \
> > +     .scan_type = { \
> As this driver doesn't yet support buffered mode, most of this info
> isn't used.  So just specify the bits you actually use (shift I think).
> > +             .sign = 'u', \
> > +             .realbits = 10, \
> > +             .storagebits = 16, \
> > +             .shift = 2, \
> > +     } \
> > +}
> > +
> > +const struct iio_chan_spec max5522_channels[] = {
> > +     MAX5522_CHANNEL(0),
> > +     MAX5522_CHANNEL(1),
> > +};
> > +
> > +enum max5522_type {
> > +     ID_MAX5522,
> > +};
> > +
> > +static const struct max5522_chip_info max5522_chip_info_tbl[] = {
>
> Unless you are going to follow this patch very soon with support for more devices,
> I'd prefer seeing this indirection only when it becomes necessary.
> For now, it just leads to less readable and longer code.
>
idea is to follow up with MAX5523/5524/5525,
not sure when right now, since i cannot test them, but code was ready
for addition

> > +     [ID_MAX5522] = {
> > +             .channels = max5522_channels,
> > +             .num_channels = 2,
> > +     },
> > +};
> > +
> > +static inline int max5522_info_to_reg(struct iio_chan_spec const *chan)
> > +{
> > +     return MAX5522_REG_DATA(chan->channel);
> > +}
> > +
> > +static int max5522_read_raw(struct iio_dev *indio_dev,
> > +     struct iio_chan_spec const *chan, int *val, int *val2, long info)
> > +{
> > +     struct max5522_state *state = iio_priv(indio_dev);
> > +
> > +     switch (info) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             *val = state->dac_cache[chan->channel];
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_SCALE:
> > +             *val = state->vrefin_mv;
> > +             *val2 = 10;
> > +             return IIO_VAL_FRACTIONAL_LOG2;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int max5522_write_raw(struct iio_dev *indio_dev,
> > +     struct iio_chan_spec const *chan, int val, int val2, long info)
> > +{
> > +     struct max5522_state *state = iio_priv(indio_dev);
> > +     int rval;
> > +
> > +     if (val > 1023 || val < 0)
> > +             return -EINVAL;
> > +
> > +     rval = regmap_write(state->regmap, max5522_info_to_reg(chan),
> > +                             val << chan->scan_type.shift);
> > +     if (rval < 0)
> > +             return rval;
> > +
> > +     state->dac_cache[chan->channel] = val;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct iio_info max5522_info = {
> > +     .read_raw = max5522_read_raw,
> > +     .write_raw = max5522_write_raw,
> > +};
> > +
> > +static void max5522_remove(struct device *dev)
> > +{
> > +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +
> > +     iio_device_unregister(indio_dev);
>
> Look at this and consider if there are appropriate devm_ forms
> for the two things you are doing in here.  If you use
> devm_iio_device_register() below and
> devm_kzalloc() or similar for the channels then the managed cleanup
> will allow you to drop remove entirely.
>
> > +     kfree(indio_dev->channels);
>
> You seem to be freeing static const data...
>
ops. Ok, used devm_iio_device_register and dropped remove entirely.

> > +}
> > +
> > +static const struct regmap_config max5522_regmap_config = {
> > +     .reg_bits = 4,
> > +     .val_bits = 12,
> > +     .max_register = MAX5522_MAX_ADDR,
> > +};
> > +
> > +static int max5522_spi_probe(struct spi_device *spi)
> > +{
> > +     const struct spi_device_id *id = spi_get_device_id(spi);
> > +     struct iio_dev *indio_dev;
> > +     struct max5522_state *state;
> > +     int ret;
> > +
> > +     indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
> > +     if (indio_dev == NULL) {
> > +             dev_err(&spi->dev, "failed to allocate iio device\n");
> > +             return  -ENOMEM;
> > +     }
> > +
> > +     state = iio_priv(indio_dev);
> > +     state->chip_info = &max5522_chip_info_tbl[id->driver_data];
>
> Whilst driver only supports one device hard code this - or just hard
> code the values it contains.
>
As above, idea was to add 5523/5524/5525, but i cannot test them rtight now.

> > +
> > +     state->vrefin_reg = devm_regulator_get(&spi->dev, "vrefin");
> > +     if (IS_ERR(state->vrefin_reg))
> > +             return dev_err_probe(&spi->dev, PTR_ERR(state->vrefin_reg),
> > +                                  "Vrefin regulator not specified\n");
>
> Turn the regulator on.  Not that you'll then want to add
> a devm_add_action_or_reset() call to call a callback to turn it fof again
> in the remove path.  We can't us the devm_regulator_get_enabled() path
> here because we need the pointer to get the voltage.
>
Thanks, added regulator_enable()

> > +
> > +     ret = regulator_get_voltage(state->vrefin_reg);
> > +     if (ret < 0) {
> > +             dev_err(&spi->dev, "Failed to read vrefin regulator: %d\n",
> > +                             ret);
> > +             goto error_disable_vrefin_reg;
> > +     }
> > +     state->vrefin_mv = ret / 1000;
> > +
> > +     spi_set_drvdata(spi, indio_dev);
>
> Once you've moved everything over to devm, you won't need this.
>
Thanks, removed

> > +
> > +     state->regmap = devm_regmap_init_spi(spi, &max5522_regmap_config);
> No blank line between a call and it's error handler.  Keeps the blocks
> slightly easier to read.
> > +
> > +     if (IS_ERR(state->regmap))
> > +             return PTR_ERR(state->regmap);
> > +
> > +     dev_info(&spi->dev, "iio dac ready");
>
> Don't add this noise to the boot log.  If it worked, you'll have lots
> of easy ways to find out!
>
Ok, removed, was just for initial debug

> > +
> > +     indio_dev->info = &max5522_info;
> > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > +     indio_dev->channels = max5522_channels;
> > +     indio_dev->num_channels = ARRAY_SIZE(max5522_channels);
> > +     indio_dev->name = id->name;
>
> Hard code the name preferred as it makes it easier to be sure it's exactly what
> we expect when reading the code and does rely on the fallback compatible matching
> in the spi core for dt described devices.
>
Ok, if possible i would keep the id table for next additions.

> > +
> > +     return iio_device_register(indio_dev);
> > +
> > +error_disable_vrefin_reg:
> > +     regulator_disable(state->vrefin_reg);
>
> Disabing a regulator you haven't enabled.  Use devm_add_action_or_reset()
> to register managed cleanup of this.
>
ops, fixed

> > +
> > +     return ret;
> > +}
> > +
> > +static void max5522_spi_remove(struct spi_device *spi)
> > +{
> > +     max5522_remove(&spi->dev);
> > +}
> > +
> > +static const struct spi_device_id max5522_ids[] = {
> > +     { "max5522", ID_MAX5522 },
>
> As below, don't introduce the data part until you need it.
>
Same as above, let me know if keeping it for next additions is ok.

> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(spi, ad5360_ids);
> > +
> > +
> > +static const struct of_device_id max5522_of_match[] = {
> > +     { .compatible = "maxim,max5522", },
>
> Be consistent on whether you are going to put commas after
> the end of structure intialisers.  For this I don't have
> a particular preference, just make them all the same!
>
ok

> Definitely prefer to have data set here and then
> use device_get_match_data() first then if that fails, fall back to
> using the spi_device_id path. However, only introduce that complexity
> when the driver supports multiple parts.  For now there is no point
> in introducing the data at all.
>
> > +     {},
>
> No comma after null terminators.
>
ok, done

> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, max5522_of_match);
> > +
> > +static struct spi_driver max5522_spi_driver = {
> > +     .driver = {
> > +                .name = "max5522",
> > +                .of_match_table = max5522_of_match,
> > +     },
> > +     .probe = max5522_spi_probe,
> > +     .remove = max5522_spi_remove,
> > +     .id_table = max5522_ids,
> > +};
> > +
> > +static inline int max5522_spi_register_driver(void)
> > +{
> > +     return spi_register_driver(&max5522_spi_driver);
> > +}
> > +
> > +static inline void max5522_spi_unregister_driver(void)
> > +{
> > +     spi_unregister_driver(&max5522_spi_driver);
> > +}
> > +
> > +static int __init max5522_spi_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret = max5522_spi_register_driver();
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +module_init(max5522_spi_init);
> > +
> > +static void __exit max5522_spi_exit(void)
> > +{
> > +     max5522_spi_unregister_driver();
> > +}
> > +module_exit(max5522_spi_exit);
>
> Why not use
> module_spi_driver() to get rid of all this boilerplate?
>
ok, much more simplier, removed all and used module_spi_driver()
> > +
> > +MODULE_AUTHOR("Angelo Dureghello <angelo.dureghello@timesys.com");
> > +MODULE_DESCRIPTION("MAX5522 DAC driver");
> > +MODULE_LICENSE("GPL");
>

Waiting for further comments before v2.

Thanks a lot,
--
Angelo Dureghello
Timesys
e. angelo.dureghello@timesys.com
