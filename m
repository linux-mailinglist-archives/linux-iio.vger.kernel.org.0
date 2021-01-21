Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC112FF0B2
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 17:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbhAUQmV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 11:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388043AbhAUQmF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2021 11:42:05 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86C4C061756;
        Thu, 21 Jan 2021 08:41:23 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 30so1696773pgr.6;
        Thu, 21 Jan 2021 08:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akda6afINCiP/jlkD7Qva1n/yoVCiIAqPE5va9RpOtw=;
        b=amGM57mxt9hAY7ewQ9ONycuJJa1UpVu2EOTVU22asnbzkRk4Q1zVoSxJGMY6xj90k+
         Iy/ofi3+9bsca3r/WfjaBui8lhmzkYFgotsLGD4GoTyXFJHpZ06Hipz26Df9HVsf07Pz
         TEvAB0KpZxX81UXqpVknPLDyvKh968CXGpnFJsDTmH9ZM/QqKEJrf1Wo4JXiue/YtTYN
         8T51ai+5j+FQ35ZA3oGPAXE9xFQGYrWhqCN/gT11K6XoxGxjOJYyEXRrC/5rUH1oRa4i
         JoOljWjlP+QsaBSJjR9tczcZpHY8czNH0Z7Ii7tIDGs38fO6pirhM3gApvZgYA8InJ5S
         kCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akda6afINCiP/jlkD7Qva1n/yoVCiIAqPE5va9RpOtw=;
        b=H6i3huxpl2NA2onDQiMSTy8YvFpA/W5nFrCASo2OMFMOn9zVx9+8kv2eGtiWoncz1Z
         GxWE+OcuvDYhr3FoPviuH4Voy1lqP/6c1+9Gkuw+ehGH8+KkIrZg/1H6njby3GSJzhip
         1V+CEng1DnR7apOz/wufWZiQeVKu88UJwS27JOZXGJ1NErsS83zk5GRZSO5pW/FanuaK
         fErdsMnuoA2VF6UKFvnTDiJLBeD0JezrjdN7OXSEWVAf6InCrpydCKJpV+Hp2dvtlk5R
         MGni57E4Jt1NS5yd1hiINOiEWByq0T+Bnd/KucsURfra0TMGpr4TgxBD+CCu9VqTLF/A
         Z5ag==
X-Gm-Message-State: AOAM530Eo/Nmkh6a8LiiaaRoC4UiFnIII29rhrKMROg4HyvhQDOKVNm2
        0D5Mzo1ZEi4UpQ9OSsEQgCuzxreZCcqnZTNtCF6v3EputuuGZMQN
X-Google-Smtp-Source: ABdhPJzT/vXVlPZvq2wB9cWw/osqtOHiruTWjRXst6np42w0BiE4w7TPffReBkTNIinSCEk+Huk5Z4Yzbe4DC+dJzug=
X-Received: by 2002:a62:445:0:b029:19c:162b:bbef with SMTP id
 66-20020a6204450000b029019c162bbbefmr233800pfe.40.1611247283052; Thu, 21 Jan
 2021 08:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20210112095128.7112-1-tomislav.denis@avl.com> <20210112095128.7112-2-tomislav.denis@avl.com>
In-Reply-To: <20210112095128.7112-2-tomislav.denis@avl.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Jan 2021 18:42:11 +0200
Message-ID: <CAHp75VfNweJyXgzCcvZUWj=3mCVkP=+HaFmG2XaKmKP1cATa=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: adc: Add driver for Texas Instruments
 ADS131E0x ADC family
To:     tomislav.denis@avl.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 12, 2021 at 2:37 PM <tomislav.denis@avl.com> wrote:
>
> From: Tomislav Denis <tomislav.denis@avl.com>
>
> The ADS131E0x are a family of multichannel, simultaneous sampling,
> 24-bit, delta-sigma, analog-to-digital converters (ADCs) with a
> built-in programmable gain amplifier (PGA), internal reference
> and an onboard oscillator.

...

> +config TI_ADS131E08
> +       tristate "Texas Instruments ADS131E08"
> +       depends on SPI && OF

Why OF?!

> +       select IIO_BUFFER
> +       select IIO_TRIGGERED_BUFFER
> +       help
> +         Say yes here to get support for Texas Instruments ADS131E04, ADS131E06
> +         and ADS131E08 chips.
> +
> +         This driver can also be built as a module. If so, the module will be
> +         called ti-ads131e08.

...

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Texas Instruments ADS131E0x 4-, 6- and 8-Channel ADCs
> + *
> + * Copyright (c) 2020 AVL DiTEST GmbH
> + *   Tomislav Denis <tomislav.denis@avl.com>
> + *
> + * Datasheet: https://www.ti.com/lit/ds/symlink/ads131e08.pdf

Please, put this as a tag in the commit message as well

> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>

> +#include <linux/of_device.h>

Why?!

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <asm/unaligned.h>

Can we group these to something like (wit blank lines between groups)

linux/*.h

linux/iio*.h

asm/*.h

?

...

> +#define ADS131E08_CMD_RREG(r)          (0x20 | (r & GENMASK(4, 0)))
> +#define ADS131E08_CMD_WREG(r)          (0x40 | (r & GENMASK(4, 0)))

BIT(5)
BIT(6)

...

> +#define ADS131E08_VREF_2V4_MV          2400
> +#define ADS131E08_VREF_4V_MV           4000

I prefer mV despite this being defined constant.

...

> +struct ads131e08_state {
> +       const struct ads131e08_info *info;
> +       struct spi_device *spi;
> +       struct iio_trigger *trig;
> +       struct clk *adc_clk;
> +       struct regulator *vref_reg;
> +       struct ads131e08_channel_config *channel_config;
> +       unsigned int data_rate;
> +       unsigned int vref_mv;
> +       unsigned int sdecode_delay_us;
> +       unsigned int reset_delay_us;
> +       unsigned int readback_len;
> +       struct completion completion;

> +

Redundant blank line. But it's up to you.

> +       struct {
> +               u8 data[ADS131E08_NUM_DATA_BYTES_MAX];
> +               s64 ts __aligned(8);
> +       } tmp_buf;
> +
> +       u8 tx_buf[3] ____cacheline_aligned;
> +       /*
> +        * Add extra one padding byte to be able to access the last channel
> +        * value using u32 pointer
> +        */
> +       u8 rx_buf[ADS131E08_NUM_STATUS_BYTES +
> +               ADS131E08_NUM_DATA_BYTES_MAX + 1];
> +};

...

> +static const struct ads131e08_data_rate_desc ads131e08_data_rate_tbl[] = {
> +       { .rate = 64,   .reg = 0x00 },
> +       { .rate = 32,   .reg = 0x01 },
> +       { .rate = 16,   .reg = 0x02 },
> +       { .rate = 8,    .reg = 0x03 },
> +       { .rate = 4,    .reg = 0x04 },
> +       { .rate = 2,    .reg = 0x05 },
> +       { .rate = 1,    .reg = 0x06 },
> +};

Can't you use simple bit operations on this?

rate = BIT(6 - index)
reg = index

...

> +static const struct ads131e08_pga_gain_desc ads131e08_pga_gain_tbl[] = {
> +       { .gain = 1,   .reg = 0x01 },
> +       { .gain = 2,   .reg = 0x02 },

reg == 3 valid?

> +       { .gain = 4,   .reg = 0x04 },
> +       { .gain = 8,   .reg = 0x05 },
> +       { .gain = 12,  .reg = 0x06 },
> +};

Also can be changed by formula, but I remember that in some cases
tables are preferable.

...

> +static int ads131e08_exec_cmd(struct ads131e08_state *st, u8 cmd)
> +{
> +       int ret;
> +
> +       ret = spi_write_then_read(st->spi, &cmd, 1, NULL, 0);
> +       if (ret) {
> +               dev_err(&st->spi->dev,
> +                       "%s: SPI write failed for cmd: %02x\n", __func__, cmd);

__func__ is not needed.

> +               return ret;
> +       }
> +
> +       return 0;

The last is redundant, simply
  return ret;
instead of both of them.

> +}
> +
> +static int ads131e08_read_reg(struct ads131e08_state *st, u8 reg)
> +{
> +       int ret;

> +

Redundant blank line.

> +       struct spi_transfer transfer[] = {
> +               {
> +                       .tx_buf = &st->tx_buf,
> +                       .len = 2,
> +                       .delay_usecs = st->sdecode_delay_us,
> +               }, {
> +                       .rx_buf = &st->rx_buf,
> +                       .len = 1,
> +               },
> +       };
> +
> +       st->tx_buf[0] = ADS131E08_CMD_RREG(reg);
> +       st->tx_buf[1] = 0;
> +
> +       ret = spi_sync_transfer(st->spi, transfer, ARRAY_SIZE(transfer));
> +       if (ret) {
> +               dev_err(&st->spi->dev, "%s: SPI transfer failed\n", __func__);

__func__ is almost useless. Better to think about the uniqueness of
the messages across the driver.

> +               return ret;
> +       }
> +
> +       return st->rx_buf[0];
> +}

> +static int ads131e08_write_reg(struct ads131e08_state *st, u8 reg, u8 value)
> +{

Similar comments as per previous function.

> +       ret = spi_sync_transfer(st->spi, transfer, ARRAY_SIZE(transfer));
> +       if (ret) {
> +               dev_err(&st->spi->dev, "%s: SPI transfer failed\n", __func__);

> +               return ret;
> +       }
> +
> +       return 0;

return ret;

> +}
> +
> +static int ads131e08_read_data(struct ads131e08_state *st, int rx_len)
> +{

As above.

> +}

...

> +       for (i = 0; i < ARRAY_SIZE(ads131e08_data_rate_tbl); ++i) {

i++ works the same and more regular pattern.
Ditto for other occurrences.

> +               if (ads131e08_data_rate_tbl[i].rate == data_rate)
> +                       break;
> +       }

...

> +       struct ads131e08_state *st = iio_priv(indio_dev);
> +       const struct iio_chan_spec *channel = indio_dev->channels;
> +       int ret, i;
> +       u8 active_channels = 0;

Reversed xmas tree order?
Also for the rest of the driver.

...

> +       /* Power down unused channels */
> +       for (i = 0; i < st->info->max_channels; ++i) {
> +               if (!(active_channels & BIT(i))) {

NIH of for_each_clear_bit()

> +                       ret = ads131e08_power_down_channel(st, i, true);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }

...

> +       /*
> +        * Channel offset calibration is triggered with first START command.

the first

> +        * Since calibration take more time than settling operation,

takes

> +        * this causes timeout error when command START is sent first
> +        * time (e.g. first call of the ads131e08_read_direct method).
> +        * To avoid this problem offset calibration is triggered here.
> +        */

...

> +       ret = ads131e08_exec_cmd(st, ADS131E08_CMD_STOP);
> +       if (ret)
> +               return ret;
> +
> +       return 0;

return _exec_cmd(...);

...

> +       ret = wait_for_completion_timeout(&st->completion,
> +               msecs_to_jiffies(ADS131E08_MAX_SETTLING_TIME_MS));

With a temporary variable is easier to read.

... timeout = msecs_to_jiffies(...);

       ret = wait_for_completion_timeout(&st->completion, timeout);

> +       if (!ret)
> +               return -ETIMEDOUT;

...

> +       *value = sign_extend32(
> +               get_unaligned_be32(src) >> (32 - num_bits), num_bits - 1);

One line, please.

> +       return ret;

Expected other than 0?

...

> +       case IIO_CHAN_INFO_SCALE:
> +               if (!IS_ERR(st->vref_reg)) {

Why not positive conditional?

> +                       ret = regulator_get_voltage(st->vref_reg);
> +                       if (ret < 0)
> +                               return ret;
> +
> +                       *value = ret / 1000;
> +               } else {
> +                       *value = st->vref_mv;
> +               }

...

> +       return -EINVAL;

Can you use rather
  default:
   return -EINVAL;
instead?

...

> +       switch (mask) {
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               ret = iio_device_claim_direct_mode(indio_dev);
> +               if (ret)
> +                       return ret;
> +
> +               ret = ads131e08_set_data_rate(st, value);
> +               iio_device_release_direct_mode(indio_dev);
> +               return ret;
> +       }
> +
> +       return -EINVAL;

Ditto.

...

> +static int ads131e08_debugfs_reg_access(struct iio_dev *indio_dev,
> +       unsigned int reg, unsigned int writeval, unsigned int *readval)
> +{
> +       struct ads131e08_state *st = iio_priv(indio_dev);
> +
> +       if (readval) {
> +               int ret = ads131e08_read_reg(st, (u8)reg);

Is casting needed?

> +               *readval = ret;
> +               return ret;
> +       }

...

> +       /*
> +        * The number of data bits per channel depends on the data rate.
> +        * For 32 and 64 ksps data rates, number of data bits per channel
> +        * is 16. This case is not compliant with used (fixed) scan element
> +        * type (be:s24/32>>8). So we use a litle tweek to pack properly

little tweak

> +        * 16 bits of data into the buffer.
> +        */

...

> +       for_each_set_bit(chn, indio_dev->active_scan_mask,
> +               indio_dev->masklength) {

One line.

...

> +               /*
> +                * Data conversion from 16 bits of data to 24 bits of data
> +                * is done by sign etension (properly filling padding byte).

extension

> +                */
> +               if (tweek_offset)
> +                       memset(dest, *src & BIT(7) ? 0xff : 0x00, 1);

One byte with memset()?!

...

> +       ret = of_property_read_u32(node, "ti,vref-internal", &tmp);

device_property_read_u32()

> +       if (ret)
> +               tmp = 0;

...

> +       num_channels = of_get_available_child_count(node);

fwnode API has something OF agnostic.

> +       if (num_channels == 0) {
> +               dev_err(&st->spi->dev, "no channel children\n");
> +               return -ENODEV;
> +       }

...

> +       for_each_available_child_of_node(node, child) {
> +               ret = of_property_read_u32(child, "reg", &channel);

> +               ret = of_property_read_u32(child, "ti,gain", &tmp);

> +               ret = of_property_read_u32(child, "ti,mux", &tmp);

> +       }

Easy to convert to fwnode API.

...

> +       info = of_device_get_match_data(&spi->dev);

device_get_match_data()

> +       if (!info) {
> +               dev_err(&spi->dev, "failed to get match data\n");
> +               return -ENODEV;
> +       }

...

> +       indio_dev->dev.of_node = spi->dev.of_node;

Do you need to copy fwnode as well?

...

> +       st->adc_clk = devm_clk_get(&spi->dev, "adc-clk");
> +       if (IS_ERR(st->adc_clk)) {
> +               dev_err(&spi->dev, "failed to get the ADC clock\n");

Spam when deferred.

> +               return PTR_ERR(st->adc_clk);
> +       }

...

> +       ret = clk_prepare_enable(st->adc_clk);
> +       if (ret) {
> +               dev_err(&spi->dev, "failed to prepare/enable the ADC clock\n");
> +               return ret;
> +       }
> +
> +       ret = devm_add_action_or_reset(&spi->dev, ads131e08_clk_disable, st);
> +       if (ret) {

> +               clk_disable_unprepare(st->adc_clk);

"_or_reset" does call this, no?

> +               return ret;
> +       }

Actually both calls can be moved to a separate helper.

...

> +       adc_clk_ns = NSEC_PER_SEC / adc_clk_hz;
> +       st->sdecode_delay_us = DIV_ROUND_UP(
> +               ADS131E08_WAIT_SDECODE_CYCLES * adc_clk_ns, 1000);

NSEC_PER_USEC

> +       st->reset_delay_us = DIV_ROUND_UP(
> +               ADS131E08_WAIT_RESET_CYCLES * adc_clk_ns, 1000);

Ditto.


> +       ret = devm_iio_device_register(&spi->dev, indio_dev);
> +       if (ret) {
> +               dev_err(&spi->dev, "failed to register IIO device\n");
> +               return ret;
> +       }
> +
> +       return 0;

return devm_iio_device_register(...);

-- 
With Best Regards,
Andy Shevchenko
