Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE91A455513
	for <lists+linux-iio@lfdr.de>; Thu, 18 Nov 2021 08:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243547AbhKRHJR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Nov 2021 02:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhKRHJQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Nov 2021 02:09:16 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A163EC061570
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 23:06:16 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso9321122otg.9
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 23:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=IDMTs/7VgPYbzc+9F9rBq62UZEeQUnMWdSOqH+GHCcc=;
        b=ZUs9mS3QTfqYQomlyv2aC/Lk1d1dgJZKkZJR83cXLiXkFz/rR9C3wETEC4qwm7vOfP
         S5CgEl67FdewFcyZ/R5Ku9zJ3EdDHkzxQxMwUBzwjbpFg933klipEyvae1QfPsKwCFBi
         8TUYB2S9EodojaFBBq/ZX/0U0aYfi4Gw1pQU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=IDMTs/7VgPYbzc+9F9rBq62UZEeQUnMWdSOqH+GHCcc=;
        b=hOxiGWHHsw3shixyXsicD1n65vb5D60ZWmm23F1f4Bq4jd08K6sTJFfNYqVXEYb3K8
         m610GqYXf9mOXQBU8ZBTPL4vbQf8Mf4HRiX0mzS29U/0Za7FlgwB8P/GEKmIbE8MW2Ay
         acngB44PVQt+6uub/cLF7mSUcCVQ3/T+Xju37D4RGhqW9qF1Arm7lwD15p0HKdrZHe3N
         fdARAedIurPVR1ju4sYD2B7mt/2w9Vf27F/dq2I3pf2lmloRdxYSeMhHOS+bCWE2GJeh
         SFmyfsdTYI0fcTubdc4SXjBnyrYGUMMOYr6fQDN+2q24sFlHlZ9T6UUMwdN1Wx1klVF1
         R8Bw==
X-Gm-Message-State: AOAM533ZyxXdiNguqQ9VFYjvDtFvFJAqYBvh3CD56DHoaj0+lZOw+UyE
        KVzuo2cjkpO4EneoeF1LOl35ZtAcHgpyUzqJPfEwwg==
X-Google-Smtp-Source: ABdhPJzpIdRpqOyVxI019EcPNnXzsCz9Dyvt3hvPxow+sCU07idT2TK/B/vWMpH/K4O0Zlisrq8RwWfdW43aOtILIxM=
X-Received: by 2002:a05:6830:30b7:: with SMTP id g23mr18500227ots.159.1637219175792;
 Wed, 17 Nov 2021 23:06:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Nov 2021 23:06:15 -0800
MIME-Version: 1.0
In-Reply-To: <20211117084631.2820014-4-gwendal@chromium.org>
References: <20211117084631.2820014-1-gwendal@chromium.org> <20211117084631.2820014-4-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 17 Nov 2021 23:06:15 -0800
Message-ID: <CAE-0n51-qhaN=C6X-+j=D_0+HhbEpKctyfmqObxG_DAZ5Fwz4g@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] iio: proximity: Add SX9324 support
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-11-17 00:46:29)
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sx9324 b/Documentation/ABI/testing/sysfs-bus-iio-sx9324
> new file mode 100644
> index 00000000000000..db38cb307244e1
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-sx9324
> @@ -0,0 +1,28 @@
> +What:          /sys/bus/iio/devices/iio:deviceX/in_proximity<id>_setup
> +Date:          November 2021
> +KernelVersion: 5.14

I suppose this needs an update.

> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> new file mode 100644
> index 00000000000000..21423999a192ff
> --- /dev/null
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -0,0 +1,936 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 Google LLC.
> + *
> + * Driver for Semtech's SX9324 capacitive proximity/button solution.
> + * Based on SX9324 driver and copy of datasheet at:
> + * https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf
> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/irq.h>
> +#include <linux/gpio/consumer.h>

Is this include used?

> +#include <linux/kernel.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#include "sx_common.h"
> +
> +#define SX9324_DRIVER_NAME             "sx9324"
> +
[...]
> +
> +static int sx9324_read_thresh(struct sx_common_data *data,
> +                             const struct iio_chan_spec *chan, int *val)
> +{
> +       unsigned int regval;
> +       unsigned int reg;
> +       int ret;
> +
> +       /*
> +        * TODO(gwendal): Depending on the phase function
> +        * (proximity/table/body), retrieve the right threshold.

What is used right now? proximity threshold? Would be good to have that
clarified here for future readers.

> +        */
> +       reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
> +       ret = regmap_read(data->regmap, reg, &regval);
> +       if (ret)
> +               return ret;
> +
> +       if (regval <= 1)
> +               *val = regval;
> +       else
> +               *val = (regval * regval) / 2;
> +
> +       return IIO_VAL_INT;
> +}
> +
[...]
> +
> +static int sx9324_write_close_debounce(struct sx_common_data *data, int val)
> +{
> +       unsigned int regval;
> +       int ret;
> +
> +       if (val > 0)
> +               val = ilog2(val);

If val is less than 0 does FIELD_FIT bail out? Seems like we should
ignore negative values and/or treat them as 0?

> +       if (!FIELD_FIT(SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK, val))
> +               return -EINVAL;
> +
> +       regval = FIELD_PREP(SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK, val);
> +
> +       mutex_lock(&data->mutex);
> +       ret = regmap_update_bits(data->regmap, SX9324_REG_PROX_CTRL5,
> +                                SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK,
> +                                regval);
> +       mutex_unlock(&data->mutex);
> +
> +       return ret;
> +}
> +
> +static int sx9324_write_event_val(struct iio_dev *indio_dev,
> +                                 const struct iio_chan_spec *chan,
> +                                 enum iio_event_type type,
> +                                 enum iio_event_direction dir,
> +                                 enum iio_event_info info, int val, int val2)
> +{
> +       struct sx_common_data *data = iio_priv(indio_dev);
> +
> +       if (chan->type != IIO_PROXIMITY)
> +               return -EINVAL;
> +
> +       switch (info) {
> +       case IIO_EV_INFO_VALUE:
> +               return sx9324_write_thresh(data, chan, val);
> +       case IIO_EV_INFO_PERIOD:
> +               switch (dir) {
> +               case IIO_EV_DIR_RISING:
> +                       return sx9324_write_far_debounce(data, val);
> +               case IIO_EV_DIR_FALLING:
> +                       return sx9324_write_close_debounce(data, val);
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_EV_INFO_HYSTERESIS:
> +               return sx9324_write_hysteresis(data, chan, val);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int sx9324_write_gain(struct sx_common_data *data,
> +                            const struct iio_chan_spec *chan, int val)
> +{
> +       unsigned int gain, reg;
> +       int ret;
> +
> +       gain = ilog2(val);
> +       reg = SX9324_REG_PROX_CTRL0 + chan->channel / 2;
> +       gain = FIELD_PREP(SX9324_REG_PROX_CTRL0_GAIN_MASK, gain);
> +
> +       mutex_lock(&data->mutex);
> +       ret = regmap_update_bits(data->regmap, reg,
> +                                SX9324_REG_PROX_CTRL0_GAIN_MASK,
> +                                gain);
> +       mutex_unlock(&data->mutex);
> +
> +       return ret;
> +}
> +
> +static int sx9324_write_raw(struct iio_dev *indio_dev,
> +                           const struct iio_chan_spec *chan, int val, int val2,
> +                           long mask)
> +{
> +       struct sx_common_data *data = iio_priv(indio_dev);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               return sx9324_set_samp_freq(data, val, val2);
> +       case IIO_CHAN_INFO_HARDWAREGAIN:
> +               return sx9324_write_gain(data, chan, val);
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +/* Activate all channels and perform an initial compensation. */
> +static int sx9324_init_compensation(struct iio_dev *indio_dev)
> +{
> +       struct sx_common_data *data = iio_priv(indio_dev);
> +       unsigned int val;
> +       int ret;
> +
> +       /* run the compensation phase on all channels */
> +       ret = regmap_update_bits(data->regmap, SX9324_REG_STAT2,
> +                                SX9324_REG_STAT2_COMPSTAT_MASK,
> +                                SX9324_REG_STAT2_COMPSTAT_MASK);
> +       if (ret)
> +               return ret;
> +
> +       ret = regmap_read_poll_timeout(data->regmap, SX9324_REG_STAT2, val,
> +                                      !(val & SX9324_REG_STAT2_COMPSTAT_MASK),
> +                                      20000, 2000000);
> +       if (ret == -ETIMEDOUT)
> +               dev_err(&data->client->dev,
> +                       "initial compensation timed out: 0x%02x\n",
> +                       val);
> +       return ret;
> +}
> +
> +static int sx9324_check_whoami(struct device *dev,
> +                              struct iio_dev *indio_dev)
> +{
> +       struct sx_common_data *data = iio_priv(indio_dev);
> +       unsigned int long ddata;
> +       unsigned int whoami;
> +       int ret;
> +
> +       ret = regmap_read(data->regmap, SX9324_REG_WHOAMI, &whoami);
> +       if (ret) {
> +               dev_err(dev, "error in reading WHOAMI register: %d", ret);
> +               return ret;
> +       }
> +
> +       ddata = (uintptr_t)device_get_match_data(dev);
> +       if (ddata != whoami) {
> +               dev_err(dev, "WHOAMI does not match device data: %u\n", whoami);
> +               return -ENODEV;
> +       }
> +
> +       switch (whoami) {
> +       case SX9324_WHOAMI_VALUE:
> +               indio_dev->name = "sx9324";
> +               break;
> +       default:
> +               dev_err(dev, "unexpected WHOAMI response: %u\n", whoami);
> +               return -ENODEV;
> +       }

Is this necessary? There's only one match for this driver.

> +
> +       return 0;
> +}
> +
> +static const struct sx_common_chip_info sx9324_chip_info = {
> +       .reg_stat = SX9324_REG_STAT0,
> +       .reg_irq_msk = SX9324_REG_IRQ_MSK,
> +       .reg_enable_chan = SX9324_REG_GNRL_CTRL1,
> +       .reg_reset = SX9324_REG_RESET,
> +
> +       .mask_enable_chan = SX9324_REG_GNRL_CTRL1_PHEN_MASK,
> +       .irq_msk_offset = 3,
> +       .num_channels = SX9324_NUM_CHANNELS,
> +
> +       .ops = {
> +               .read_prox_data = sx9324_read_prox_data,
> +               .check_whoami = sx9324_check_whoami,
> +               .init_compensation = sx9324_init_compensation,
> +               .wait_for_sample = sx9324_wait_for_sample,
> +       },
> +
> +       .iio_channels = sx9324_channels,
> +       .num_iio_channels = ARRAY_SIZE(sx9324_channels),
> +       .iio_info =  {
> +               .read_raw = sx9324_read_raw,
> +               .read_avail = sx9324_read_avail,
> +               .read_event_value = sx9324_read_event_val,
> +               .write_event_value = sx9324_write_event_val,
> +               .write_raw = sx9324_write_raw,
> +               .read_event_config = sx_common_read_event_config,
> +               .write_event_config = sx_common_write_event_config,
> +       },
> +};
> +
> +static int sx9324_probe(struct i2c_client *client)
> +{
> +       return sx_common_probe(client, &sx9324_chip_info, &sx9324_regmap_config);
> +}
> +
> +static int __maybe_unused sx9324_suspend(struct device *dev)
> +{
> +       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +       struct sx_common_data *data = iio_priv(indio_dev);
> +       unsigned int regval;
> +       int ret;
> +
> +       disable_irq_nosync(data->client->irq);
> +
> +       mutex_lock(&data->mutex);
> +       ret = regmap_read(data->regmap, SX9324_REG_GNRL_CTRL1, &regval);
> +
> +       data->suspend_ctrl =
> +               FIELD_GET(SX9324_REG_GNRL_CTRL1_PHEN_MASK, regval);
> +
> +       if (ret < 0)
> +               goto out;
> +
> +       // disable all phases, send the device to sleep

Please use /* comments like this */

> +       ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1, 0);
> +
> +out:
> +       mutex_unlock(&data->mutex);
> +       return ret;
> +}
> +
> +static int __maybe_unused sx9324_resume(struct device *dev)
> +{
> +       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +       struct sx_common_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       mutex_lock(&data->mutex);
> +       ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
> +                          data->suspend_ctrl | SX9324_REG_GNRL_CTRL1_PAUSECTRL);
> +       mutex_unlock(&data->mutex);
> +       if (ret)
> +               return ret;
> +
> +       enable_irq(data->client->irq);
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops sx9324_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(sx9324_suspend, sx9324_resume)
> +};
> +
> +static const struct acpi_device_id sx9324_acpi_match[] = {
> +       { "STH9324", SX9324_WHOAMI_VALUE},
> +       { },

Nitpick: Drop comma after sentinel to avoid adding something after
without compilation error.

> +};
> +MODULE_DEVICE_TABLE(acpi, sx9324_acpi_match);
> +
> +static const struct of_device_id sx9324_of_match[] = {
> +       { .compatible = "semtech,sx9324", (void *)SX9324_WHOAMI_VALUE},
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, sx9324_of_match);
> +
> +static const struct i2c_device_id sx9324_id[] = {
> +       {"sx9324", SX9324_WHOAMI_VALUE},
> +       { },

Nitpick: Drop comma after sentinel to avoid adding something after
without compilation error.

> +};
> +MODULE_DEVICE_TABLE(i2c, sx9324_id);
> +
> +static struct i2c_driver sx9324_driver = {
> +       .driver = {
> +               .name   = SX9324_DRIVER_NAME,

If it's only used one time it's better to drop the #define

> +               .acpi_match_table = ACPI_PTR(sx9324_acpi_match),
> +               .of_match_table = of_match_ptr(sx9324_of_match),
> +               .pm = &sx9324_pm_ops,
> +
