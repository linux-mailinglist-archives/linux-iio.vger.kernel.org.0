Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E41457CD4
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 11:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbhKTKT2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 05:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhKTKT1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Nov 2021 05:19:27 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6136C061574
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:16:24 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id m5so4288715ilh.11
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eth3xd1FIU1CK6HoY7T1HM0ijM9TwMcBulQz5PKsgZk=;
        b=jr3pmbq2BsmfphXULpNRO/1oNgLfm2TcncktN1jCocUM/hM5dx4YuZrLgDJKhPGIhy
         iWW6PNbEtX95reB0xdTCy9xRW9iwjcTgM4gffgEJuV3+Vmts2koG7vENTzy79zBGdqKf
         s5skadX9O3voS6Cb9mSgLMmHMG+dHk+KDABkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eth3xd1FIU1CK6HoY7T1HM0ijM9TwMcBulQz5PKsgZk=;
        b=DPzQ8NvphIj5tjen+372JL+sjGhLixmht4SdixtfIjTlN+sMYNMz1V6b0KhgrjRZqw
         TcRld8eYimijwvA6z9ZBu/uiZ3d2IA0HbLrWzkpYXbyCHga9C5e7MXH1pdwgHe0HfJ6h
         DtSGrAhDktF7oXcBB59qBcKS1XqovT3nwCVJ7TkylJ5jUn0fhFw/91wAiWY2CkxFInCd
         aY0MvinAmd/0bxpn88Y29cORhngpR2UZKidfrHOaa4w46Y/I54GCWNY10dDJ06jz+PcA
         xBtYQ4cDhmmy3dBr3LFGwWZOjfxM2ZvyPLP28HEgT4vi8O3d/xs2GqG6trHdGoxZVMgV
         2lyA==
X-Gm-Message-State: AOAM533F7rioTQt/21WdZ6cvGPj7n3QslFVxQKQFlZw1/rNCqbxa+kuG
        sgmi7Y21nDdXpK5/YqXiY+GJq+8QR7aXBWcgPR8d/A==
X-Google-Smtp-Source: ABdhPJwpOC3sSHVI6NQvZ/fT2D/jmFsRDu6w8LgTg5AfPhjsAYnSRwMhMZzFLXA4PBXMZMoTBnn4bQGPpBn9mVSXNEk=
X-Received: by 2002:a92:d8cf:: with SMTP id l15mr9155228ilo.59.1637403384228;
 Sat, 20 Nov 2021 02:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20211117084631.2820014-1-gwendal@chromium.org>
 <20211117084631.2820014-4-gwendal@chromium.org> <CAE-0n51-qhaN=C6X-+j=D_0+HhbEpKctyfmqObxG_DAZ5Fwz4g@mail.gmail.com>
In-Reply-To: <CAE-0n51-qhaN=C6X-+j=D_0+HhbEpKctyfmqObxG_DAZ5Fwz4g@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sat, 20 Nov 2021 02:16:13 -0800
Message-ID: <CAPUE2uu-iMPmdBZRRh4rXFrhC6pr_k5QiHZ6psiW2wxnnBP1gA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] iio: proximity: Add SX9324 support
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 17, 2021 at 11:06 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Gwendal Grignou (2021-11-17 00:46:29)
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sx9324 b/Documentation/ABI/testing/sysfs-bus-iio-sx9324
> > new file mode 100644
> > index 00000000000000..db38cb307244e1
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-sx9324
> > @@ -0,0 +1,28 @@
> > +What:          /sys/bus/iio/devices/iio:deviceX/in_proximity<id>_setup
> > +Date:          November 2021
> > +KernelVersion: 5.14
>
> I suppose this needs an update.
Done
>
> > diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> > new file mode 100644
> > index 00000000000000..21423999a192ff
> > --- /dev/null
> > +++ b/drivers/iio/proximity/sx9324.c
> > @@ -0,0 +1,936 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2021 Google LLC.
> > + *
> > + * Driver for Semtech's SX9324 capacitive proximity/button solution.
> > + * Based on SX9324 driver and copy of datasheet at:
> > + * https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf
> > + *
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/irq.h>
> > +#include <linux/gpio/consumer.h>
>
> Is this include used?
>
> > +#include <linux/kernel.h>
> > +#include <linux/log2.h>
> > +#include <linux/module.h>
> > +#include <linux/pm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +
> > +#include "sx_common.h"
> > +
> > +#define SX9324_DRIVER_NAME             "sx9324"
> > +
> [...]
> > +
> > +static int sx9324_read_thresh(struct sx_common_data *data,
> > +                             const struct iio_chan_spec *chan, int *val)
> > +{
> > +       unsigned int regval;
> > +       unsigned int reg;
> > +       int ret;
> > +
> > +       /*
> > +        * TODO(gwendal): Depending on the phase function
> > +        * (proximity/table/body), retrieve the right threshold.
>
> What is used right now? proximity threshold? Would be good to have that
> clarified here for future readers.
Done
>
> > +        */
> > +       reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
> > +       ret = regmap_read(data->regmap, reg, &regval);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (regval <= 1)
> > +               *val = regval;
> > +       else
> > +               *val = (regval * regval) / 2;
> > +
> > +       return IIO_VAL_INT;
> > +}
> > +
> [...]
> > +
> > +static int sx9324_write_close_debounce(struct sx_common_data *data, int val)
> > +{
> > +       unsigned int regval;
> > +       int ret;
> > +
> > +       if (val > 0)
> > +               val = ilog2(val);
>
> If val is less than 0 does FIELD_FIT bail out? Seems like we should
> ignore negative values and/or treat them as 0?
Recast to unsigned, as done in sx9324_write_hysteresis(). Same for
sx9324_write_far_debounce().
>
> > +       if (!FIELD_FIT(SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK, val))
> > +               return -EINVAL;
> > +
> > +       regval = FIELD_PREP(SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK, val);
> > +
> > +       mutex_lock(&data->mutex);
> > +       ret = regmap_update_bits(data->regmap, SX9324_REG_PROX_CTRL5,
> > +                                SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK,
> > +                                regval);
> > +       mutex_unlock(&data->mutex);
> > +
> > +       return ret;
> > +}
> > +
> > +static int sx9324_write_event_val(struct iio_dev *indio_dev,
> > +                                 const struct iio_chan_spec *chan,
> > +                                 enum iio_event_type type,
> > +                                 enum iio_event_direction dir,
> > +                                 enum iio_event_info info, int val, int val2)
> > +{
> > +       struct sx_common_data *data = iio_priv(indio_dev);
> > +
> > +       if (chan->type != IIO_PROXIMITY)
> > +               return -EINVAL;
> > +
> > +       switch (info) {
> > +       case IIO_EV_INFO_VALUE:
> > +               return sx9324_write_thresh(data, chan, val);
> > +       case IIO_EV_INFO_PERIOD:
> > +               switch (dir) {
> > +               case IIO_EV_DIR_RISING:
> > +                       return sx9324_write_far_debounce(data, val);
> > +               case IIO_EV_DIR_FALLING:
> > +                       return sx9324_write_close_debounce(data, val);
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +       case IIO_EV_INFO_HYSTERESIS:
> > +               return sx9324_write_hysteresis(data, chan, val);
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static int sx9324_write_gain(struct sx_common_data *data,
> > +                            const struct iio_chan_spec *chan, int val)
> > +{
> > +       unsigned int gain, reg;
> > +       int ret;
> > +
> > +       gain = ilog2(val);
> > +       reg = SX9324_REG_PROX_CTRL0 + chan->channel / 2;
> > +       gain = FIELD_PREP(SX9324_REG_PROX_CTRL0_GAIN_MASK, gain);
> > +
> > +       mutex_lock(&data->mutex);
> > +       ret = regmap_update_bits(data->regmap, reg,
> > +                                SX9324_REG_PROX_CTRL0_GAIN_MASK,
> > +                                gain);
> > +       mutex_unlock(&data->mutex);
> > +
> > +       return ret;
> > +}
> > +
> > +static int sx9324_write_raw(struct iio_dev *indio_dev,
> > +                           const struct iio_chan_spec *chan, int val, int val2,
> > +                           long mask)
> > +{
> > +       struct sx_common_data *data = iio_priv(indio_dev);
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > +               return sx9324_set_samp_freq(data, val, val2);
> > +       case IIO_CHAN_INFO_HARDWAREGAIN:
> > +               return sx9324_write_gain(data, chan, val);
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> > +/* Activate all channels and perform an initial compensation. */
> > +static int sx9324_init_compensation(struct iio_dev *indio_dev)
> > +{
> > +       struct sx_common_data *data = iio_priv(indio_dev);
> > +       unsigned int val;
> > +       int ret;
> > +
> > +       /* run the compensation phase on all channels */
> > +       ret = regmap_update_bits(data->regmap, SX9324_REG_STAT2,
> > +                                SX9324_REG_STAT2_COMPSTAT_MASK,
> > +                                SX9324_REG_STAT2_COMPSTAT_MASK);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = regmap_read_poll_timeout(data->regmap, SX9324_REG_STAT2, val,
> > +                                      !(val & SX9324_REG_STAT2_COMPSTAT_MASK),
> > +                                      20000, 2000000);
> > +       if (ret == -ETIMEDOUT)
> > +               dev_err(&data->client->dev,
> > +                       "initial compensation timed out: 0x%02x\n",
> > +                       val);
> > +       return ret;
> > +}
> > +
> > +static int sx9324_check_whoami(struct device *dev,
> > +                              struct iio_dev *indio_dev)
> > +{
> > +       struct sx_common_data *data = iio_priv(indio_dev);
> > +       unsigned int long ddata;
> > +       unsigned int whoami;
> > +       int ret;
> > +
> > +       ret = regmap_read(data->regmap, SX9324_REG_WHOAMI, &whoami);
> > +       if (ret) {
> > +               dev_err(dev, "error in reading WHOAMI register: %d", ret);
> > +               return ret;
> > +       }
> > +
> > +       ddata = (uintptr_t)device_get_match_data(dev);
> > +       if (ddata != whoami) {
> > +               dev_err(dev, "WHOAMI does not match device data: %u\n", whoami);
> > +               return -ENODEV;
> > +       }
> > +
> > +       switch (whoami) {
> > +       case SX9324_WHOAMI_VALUE:
> > +               indio_dev->name = "sx9324";
> > +               break;
> > +       default:
> > +               dev_err(dev, "unexpected WHOAMI response: %u\n", whoami);
> > +               return -ENODEV;
> > +       }
>
> Is this necessary? There's only one match for this driver.
If we trust the bios/device tree, it is indeed not necessary.
>
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct sx_common_chip_info sx9324_chip_info = {
> > +       .reg_stat = SX9324_REG_STAT0,
> > +       .reg_irq_msk = SX9324_REG_IRQ_MSK,
> > +       .reg_enable_chan = SX9324_REG_GNRL_CTRL1,
> > +       .reg_reset = SX9324_REG_RESET,
> > +
> > +       .mask_enable_chan = SX9324_REG_GNRL_CTRL1_PHEN_MASK,
> > +       .irq_msk_offset = 3,
> > +       .num_channels = SX9324_NUM_CHANNELS,
> > +
> > +       .ops = {
> > +               .read_prox_data = sx9324_read_prox_data,
> > +               .check_whoami = sx9324_check_whoami,
> > +               .init_compensation = sx9324_init_compensation,
> > +               .wait_for_sample = sx9324_wait_for_sample,
> > +       },
> > +
> > +       .iio_channels = sx9324_channels,
> > +       .num_iio_channels = ARRAY_SIZE(sx9324_channels),
> > +       .iio_info =  {
> > +               .read_raw = sx9324_read_raw,
> > +               .read_avail = sx9324_read_avail,
> > +               .read_event_value = sx9324_read_event_val,
> > +               .write_event_value = sx9324_write_event_val,
> > +               .write_raw = sx9324_write_raw,
> > +               .read_event_config = sx_common_read_event_config,
> > +               .write_event_config = sx_common_write_event_config,
> > +       },
> > +};
> > +
> > +static int sx9324_probe(struct i2c_client *client)
> > +{
> > +       return sx_common_probe(client, &sx9324_chip_info, &sx9324_regmap_config);
> > +}
> > +
> > +static int __maybe_unused sx9324_suspend(struct device *dev)
> > +{
> > +       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > +       struct sx_common_data *data = iio_priv(indio_dev);
> > +       unsigned int regval;
> > +       int ret;
> > +
> > +       disable_irq_nosync(data->client->irq);
> > +
> > +       mutex_lock(&data->mutex);
> > +       ret = regmap_read(data->regmap, SX9324_REG_GNRL_CTRL1, &regval);
> > +
> > +       data->suspend_ctrl =
> > +               FIELD_GET(SX9324_REG_GNRL_CTRL1_PHEN_MASK, regval);
> > +
> > +       if (ret < 0)
> > +               goto out;
> > +
> > +       // disable all phases, send the device to sleep
>
> Please use /* comments like this */
Done
>
> > +       ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1, 0);
> > +
> > +out:
> > +       mutex_unlock(&data->mutex);
> > +       return ret;
> > +}
> > +
> > +static int __maybe_unused sx9324_resume(struct device *dev)
> > +{
> > +       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > +       struct sx_common_data *data = iio_priv(indio_dev);
> > +       int ret;
> > +
> > +       mutex_lock(&data->mutex);
> > +       ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
> > +                          data->suspend_ctrl | SX9324_REG_GNRL_CTRL1_PAUSECTRL);
> > +       mutex_unlock(&data->mutex);
> > +       if (ret)
> > +               return ret;
> > +
> > +       enable_irq(data->client->irq);
> > +       return 0;
> > +}
> > +
> > +static const struct dev_pm_ops sx9324_pm_ops = {
> > +       SET_SYSTEM_SLEEP_PM_OPS(sx9324_suspend, sx9324_resume)
> > +};
> > +
> > +static const struct acpi_device_id sx9324_acpi_match[] = {
> > +       { "STH9324", SX9324_WHOAMI_VALUE},
> > +       { },
>
> Nitpick: Drop comma after sentinel to avoid adding something after
> without compilation error.
Done
>
> > +};
> > +MODULE_DEVICE_TABLE(acpi, sx9324_acpi_match);
> > +
> > +static const struct of_device_id sx9324_of_match[] = {
> > +       { .compatible = "semtech,sx9324", (void *)SX9324_WHOAMI_VALUE},
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(of, sx9324_of_match);
> > +
> > +static const struct i2c_device_id sx9324_id[] = {
> > +       {"sx9324", SX9324_WHOAMI_VALUE},
> > +       { },
>
> Nitpick: Drop comma after sentinel to avoid adding something after
> without compilation error.
Done
>
> > +};
> > +MODULE_DEVICE_TABLE(i2c, sx9324_id);
> > +
> > +static struct i2c_driver sx9324_driver = {
> > +       .driver = {
> > +               .name   = SX9324_DRIVER_NAME,
>
> If it's only used one time it's better to drop the #define
Done.
"sx9324" is used multiple times, but it is more readable than
SX9324_DRIVER_NAME and I don't plan to change it.
Besides, grepping other drivers, strings are used 90% of the time.

>
> > +               .acpi_match_table = ACPI_PTR(sx9324_acpi_match),
> > +               .of_match_table = of_match_ptr(sx9324_of_match),
> > +               .pm = &sx9324_pm_ops,
> > +
