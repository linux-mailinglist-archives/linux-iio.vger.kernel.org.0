Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AC9455577
	for <lists+linux-iio@lfdr.de>; Thu, 18 Nov 2021 08:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbhKRHXa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Nov 2021 02:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243867AbhKRHXQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Nov 2021 02:23:16 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87338C061570
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 23:20:16 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s139so12200195oie.13
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 23:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=xM5HW6crGQrRvKK1GRmISLgHUKAjsytIyuZ/4yFgDqo=;
        b=Az8oqbNrU52j9Sl47fnKn4IKYvomBqSoADatFRo17TeFhHM5B2Tvtw1Kb0g1zZXDjA
         B4LVkCE15mwD7J+lZTLl+//4NJY1W1T5C0sS0/9dy16uNq/apeM0an8x+7cz4Ph0xNAZ
         Ks5k1yT3VJ8dHZYtYmrITr8ghSL8RxLrZYKqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=xM5HW6crGQrRvKK1GRmISLgHUKAjsytIyuZ/4yFgDqo=;
        b=mRkiU12J5ly3WHyJ6zKH5aya+G9nbOspW/xRCK57vgQ0ZkkB/hueejpwpzTZZexZFk
         1oOtK8+9qZQiXwFiJiQx8x2RiSuFfi7iRcDnWK9LEZjv/wZFAHcDgVbn3iwOaN+5dTEn
         7+AhjcTLCKKxOmp/FWIxVsZWncEeFql5daaPumBronjzDzgjM5qH5vqUsma4IKp09s0y
         BdksAH9GwwD//xSWHgbUfQOZ1NUU1Z12PD7lL4G6eaSKfGMurt64Tk6TdEusarzGDbwb
         QtCmizq2s3B9vzCNVpJqmEzSmr/o6mRUwDINZ8wQG/SMk1YI+25cAFqRTRNNQMQSXhBm
         lTQQ==
X-Gm-Message-State: AOAM531vT5rYwd+R1hjEbwiUha11Ea3QKT2d5wppU8mzbcVzEpPDPALM
        RQBc7LMKGQPxm448o0MWWhxuk5Q6kKXX+jf6FnM+8A==
X-Google-Smtp-Source: ABdhPJwawZa8JyM39I7L9SD6NTzq61nETdM8T6XUbJVMWdBcMTVv0imYIgysiWS+DZJg9nOyu812kkbqhS4caPtPac0=
X-Received: by 2002:aca:2319:: with SMTP id e25mr5826673oie.164.1637220015844;
 Wed, 17 Nov 2021 23:20:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Nov 2021 23:20:15 -0800
MIME-Version: 1.0
In-Reply-To: <20211117084631.2820014-3-gwendal@chromium.org>
References: <20211117084631.2820014-1-gwendal@chromium.org> <20211117084631.2820014-3-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 17 Nov 2021 23:20:15 -0800
Message-ID: <CAE-0n52Vk7wdh3zCqcTTrVJOeRs48UcRpta-h=CSCm5u2LtFng@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] iio: sx9310: Extract common Semtech sensor logic
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-11-17 00:46:28)
>  drivers/iio/proximity/Kconfig     |   4 +
>  drivers/iio/proximity/Makefile    |   1 +
>  drivers/iio/proximity/sx9310.c    | 677 +++++-------------------------
>  drivers/iio/proximity/sx_common.c | 575 +++++++++++++++++++++++++
>  drivers/iio/proximity/sx_common.h | 158 +++++++

Does 'git format-patch -C' find that there's a bunch of code similarity
and reduces the patch size? It would be great to not have to re-review
this whole driver.

>  5 files changed, 836 insertions(+), 579 deletions(-)
>  create mode 100644 drivers/iio/proximity/sx_common.c
>  create mode 100644 drivers/iio/proximity/sx_common.h
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 1647268b6471f1..a621e892bf3314 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -1490,7 +1009,7 @@ static int __maybe_unused sx9310_suspend(struct device *dev)
>  static int __maybe_unused sx9310_resume(struct device *dev)
>  {
>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> -       struct sx9310_data *data = iio_priv(indio_dev);
> +       struct sx_common_data *data = iio_priv(indio_dev);
>         int ret;
>
>         mutex_lock(&data->mutex);
> @@ -1499,7 +1018,7 @@ static int __maybe_unused sx9310_resume(struct device *dev)
>                 goto out;
>
>         ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
> -                          data->suspend_ctrl0);
> +                          data->suspend_ctrl);

Any reason to drop the 0 on the end?

>
>  out:
>         mutex_unlock(&data->mutex);
> diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
> new file mode 100644
> index 00000000000000..94dbd299357ffc
> --- /dev/null
> +++ b/drivers/iio/proximity/sx_common.c
> @@ -0,0 +1,575 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018 Google LLC.
> + *
> + * Driver for Semtech's SX9310/SX9311 capacitive proximity/button solution.
> + * Based on SX9500 driver and Semtech driver using the input framework
> + * <https://my.syncplicity.com/share/teouwsim8niiaud/
> + *          linux-driver-sx_common_NoSmartHSensing>.
> + * Reworked in April 2019 by Evan Green <evgreen@chromium.org>
> + * and in January 2020 by Daniel Campello <campello@chromium.org>.

Is this from the sx9310 driver? Maybe leave that in sx9310 and just say
this is common semtech proximity sensor functionality.

> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>

Is this include used?

> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
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
[...]
> diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
> new file mode 100644
> index 00000000000000..7f4d696ca16d34
> --- /dev/null
> +++ b/drivers/iio/proximity/sx_common.h
> @@ -0,0 +1,158 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Code shared between most Semtech SAR sensor driver.
> + */
> +
> +#ifndef IIO_SX_COMMON_H
> +#define IIO_SX_COMMON_H
> +
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define SX_COMMON_REG_IRQ_SRC                          0x00
> +
> +#define   SX9310_WHOAMI_VALUE                          0x01
> +#define   SX9311_WHOAMI_VALUE                          0x02
> +#define   SX9324_WHOAMI_VALUE                          0x23
> +#define   SX9360_WHOAMI_VALUE                          0x60

Can these two new defines come in the patches that add support for those
chips?

> +
> +#define SX_COMMON_MAX_NUM_CHANNELS     4
> +static_assert(SX_COMMON_MAX_NUM_CHANNELS < BITS_PER_LONG);
> +
> +struct sx_common_data;
> +
> +struct sx_common_reg_default {
> +       u8 reg;
> +       u8 def;
> +};
> +
> +/** sx_common_ops: function pointers needed by common code

The /** is on a line by itself for kernel-doc. Also missing 'struct'

> + *
> + * List functions needed by common code to gather information or configure
> + * the sensor.
> + *
> + * @read_prox_data:    Function to read raw proximity data.
> + * @check_whoami:      Set device name based on whoami register.
> + * @init_compensation: Function to set initial compensation.
> + * @wait_for_sample:   When there are no physical IRQ, function to wait for a
> + *                     sample to be ready.

Missing get_default_reg

> + */
> +struct sx_common_ops {
> +       int (*read_prox_data)(struct sx_common_data *data,
> +                             const struct iio_chan_spec *chan, __be16 *val);
> +       int (*check_whoami)(struct device *dev, struct iio_dev *indio_dev);
> +       int (*init_compensation)(struct iio_dev *indio_dev);
> +       int (*wait_for_sample)(struct sx_common_data *data);
> +       const struct sx_common_reg_default  *
> +               (*get_default_reg)(struct device *dev, int idx,
> +                                  struct sx_common_reg_default *reg_def);
> +};
> +
> +/**
> + * struct sx_common_chip_info: Semtech Sensor private chip information
> + *
> + * @reg_stat:          Main status register address.
> + * @reg_irq_msk:       IRQ mask register address.
> + * @reg_enable_chan:   Address to enable/disable channels/phases.
> + * @reg_reset:         Reset register address.
> + *
> + * @mask_enable_chan:  Mask over the channels bits in the enable channel
> + *                     register.
> + * @irq_msk_offset:    Offset to enable interrupt in the IRQ mask
> + *                     register.
> + *
> + * @num_channels:      Number of channel/phase.
> + * @num_default_regs:  Number of internal registers that can be configured.
> + *
> + * @ops:               Private functions pointers.
> + *
> + * @iio_channels:      Description of exposed iio channels.
> + * @num_iio_channels:  Number of iio_channels.
> + * @iio_info:          iio_info structure for this driver.
> + *
> + */
> +struct sx_common_chip_info {
> +       unsigned int reg_stat;
> +       unsigned int reg_irq_msk;
> +       unsigned int reg_enable_chan;
> +       unsigned int reg_reset;
> +
> +       unsigned int mask_enable_chan;
> +       unsigned int irq_msk_offset;
> +       unsigned int num_channels;
> +       int num_default_regs;
> +
> +       struct sx_common_ops ops;
> +
> +       const struct iio_chan_spec *iio_channels;
> +       int num_iio_channels;
> +       struct iio_info iio_info;
> +};
> +
> +/**
> + * struct sx_common_data: Semtech Sensor private data structure.
> + *
> + * @info:              Structure defining sensor internals.
> + * @mutex:             Serialize access to registers and channel configuration.
> + * @num_channels:      Number of channel/phase.
> + * @completion:                completion object to wait for data acquisition.
> + * @client:            I2C client structure.
> + * @trig:              IIO trigger object.
> + * @regmap:            Register map.
> + *
> + * @num_default_regs:  Number of default registers to set at init.
> + * @supplies:          Power supplies object.
> + * @chan_prox_stat:    Last reading of the proximity status for each channel.
> + *                     We only send an event to user space when this changes.
> + * @trigger_enabled:   True when the device trigger is enabled.
> + *
> + * @buffer:            Bufffer to store raw samples.
> + * @suspend_ctrl:      Remember enabled channels and sample rate during suspend.
> + * @chan_read:         Bit field for each raw channel enabled.
> + * @chan_event:                Bit field for each event enabled.
> + *
> + */
> +struct sx_common_data {
> +       const struct sx_common_chip_info *info;

Maybe 'chip_info' so we don't alias with the other 'info' in this patch,
iio_event_info? Similar comment wherever it's passed as 'info' to some
function.

> +
> +       struct mutex mutex;
> +       struct completion completion;
> +       struct i2c_client *client;
> +       struct iio_trigger *trig;
> +       struct regmap *regmap;
> +
> +       struct regulator_bulk_data supplies[2];
> +       unsigned long chan_prox_stat;
> +       bool trigger_enabled;
> +
> +       /* Ensure correct alignment of timestamp when present. */
> +       struct {
> +               __be16 channels[SX_COMMON_MAX_NUM_CHANNELS];
> +               s64 ts __aligned(8);
> +       } buffer;
> +
> +       unsigned int suspend_ctrl;
> +       unsigned long chan_read;
> +       unsigned long chan_event;
> +};
> +
