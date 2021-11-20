Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F1457CD3
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 11:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbhKTKTW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 05:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhKTKTV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Nov 2021 05:19:21 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9ECC061574
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:16:18 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id l8so12722788ilv.3
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 02:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+aqsR1CEbjSLmp4vazU2/LUWzbrBzligmx6H6KpXUs=;
        b=MW1Obc7LzWrmltJbB1eL8yOhRQH0cJ3HhJY5rB34Nh/S00Dxtu/mhQg2/zxny2MVjE
         oW+zRlntFcLThABB+OEkQnXc66XjOno3GFGtVtdJlXqyf7cqRpPYZlf6uBq59j3OppEy
         Y4ysu/Kdrlu47GcmQnSGyL+q6Qsn7HyvYeuGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+aqsR1CEbjSLmp4vazU2/LUWzbrBzligmx6H6KpXUs=;
        b=ww4oTvnUtiIqmUknv1lNydRt9ATzNbH+9KqHEp2Q0HqGI5CeKc0drApD8c6VlzqxQp
         6mA+NsQsEQWXWQqp/9BhKk60RCNjQpOcSAwk6uwiMPFc9tI2YFhXUOIB3oA+0Aoj43qC
         B7sd24T+PnVIGYqZ67WFr0SO5VmtybFAbCJLKn3gKhHWkN4aP1lU9LBcXVbtlsQLYVPl
         Q7InD02jccLqkPvFEIl1bJKpKEqpoQpxH/zyPB94qVf6ifSb2o140COersxfh9Z3k3ae
         DiYCjbr4cZK9mhxqqPMlRqE+0NcMUx1L3LbNbLV7EaSHwbCg1Ixpt9jLm8L1x+4swHo/
         z8mQ==
X-Gm-Message-State: AOAM530BPXDvCfAcWtHuze/Ldwoak8jI3v6DiTSFyI0FZiNEUc4Msz+R
        tKWTjNQlFUuMLcn/eCXDfiPDjWaqkF1IyyhOV6lfAQ==
X-Google-Smtp-Source: ABdhPJxU/3dj62pbEcQU7E7ClIRzfbVb460ymYAPluddm5+4ZvPz0U3DsZ2gNUfmnWwquRYOKKxE3GdqdCDkAg7z+iM=
X-Received: by 2002:a05:6e02:1848:: with SMTP id b8mr8653950ilv.299.1637403377632;
 Sat, 20 Nov 2021 02:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20211117084631.2820014-1-gwendal@chromium.org>
 <20211117084631.2820014-3-gwendal@chromium.org> <CAE-0n52Vk7wdh3zCqcTTrVJOeRs48UcRpta-h=CSCm5u2LtFng@mail.gmail.com>
In-Reply-To: <CAE-0n52Vk7wdh3zCqcTTrVJOeRs48UcRpta-h=CSCm5u2LtFng@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sat, 20 Nov 2021 02:16:07 -0800
Message-ID: <CAPUE2ut+7FhNNtQJ7OT+nMk=eknvXu=Tiepy6Dfzs1jDr1kjzQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] iio: sx9310: Extract common Semtech sensor logic
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thanks for attention to details,
Gwendal.

On Wed, Nov 17, 2021 at 11:20 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Gwendal Grignou (2021-11-17 00:46:28)
> >  drivers/iio/proximity/Kconfig     |   4 +
> >  drivers/iio/proximity/Makefile    |   1 +
> >  drivers/iio/proximity/sx9310.c    | 677 +++++-------------------------
> >  drivers/iio/proximity/sx_common.c | 575 +++++++++++++++++++++++++
> >  drivers/iio/proximity/sx_common.h | 158 +++++++
>
> Does 'git format-patch -C' find that there's a bunch of code similarity
> and reduces the patch size? It would be great to not have to re-review
> this whole driver.
I tried, unfortunately it looks like when the file is split, git is
not able to reduce the patch size. I tried -C for 10% to 100%.
>
> >  5 files changed, 836 insertions(+), 579 deletions(-)
> >  create mode 100644 drivers/iio/proximity/sx_common.c
> >  create mode 100644 drivers/iio/proximity/sx_common.h
> >
> > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > index 1647268b6471f1..a621e892bf3314 100644
> > --- a/drivers/iio/proximity/sx9310.c
> > +++ b/drivers/iio/proximity/sx9310.c
> > @@ -1490,7 +1009,7 @@ static int __maybe_unused sx9310_suspend(struct device *dev)
> >  static int __maybe_unused sx9310_resume(struct device *dev)
> >  {
> >         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > -       struct sx9310_data *data = iio_priv(indio_dev);
> > +       struct sx_common_data *data = iio_priv(indio_dev);
> >         int ret;
> >
> >         mutex_lock(&data->mutex);
> > @@ -1499,7 +1018,7 @@ static int __maybe_unused sx9310_resume(struct device *dev)
> >                 goto out;
> >
> >         ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
> > -                          data->suspend_ctrl0);
> > +                          data->suspend_ctrl);
>
> Any reason to drop the 0 on the end?
Yes, the field suspend_ctrl is used by all the sensors, and it does
not always save the content of REG_PROX_CTRL0 register.
>
> >
> >  out:
> >         mutex_unlock(&data->mutex);
> > diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
> > new file mode 100644
> > index 00000000000000..94dbd299357ffc
> > --- /dev/null
> > +++ b/drivers/iio/proximity/sx_common.c
> > @@ -0,0 +1,575 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2018 Google LLC.
> > + *
> > + * Driver for Semtech's SX9310/SX9311 capacitive proximity/button solution.
> > + * Based on SX9500 driver and Semtech driver using the input framework
> > + * <https://my.syncplicity.com/share/teouwsim8niiaud/
> > + *          linux-driver-sx_common_NoSmartHSensing>.
> > + * Reworked in April 2019 by Evan Green <evgreen@chromium.org>
> > + * and in January 2020 by Daniel Campello <campello@chromium.org>.
>
> Is this from the sx9310 driver? Maybe leave that in sx9310 and just say
> this is common semtech proximity sensor functionality.
Done.
>
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/i2c.h>
> > +#include <linux/irq.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mod_devicetable.h>
>
> Is this include used?
No, and remove a few others as well.
>
> > +#include <linux/module.h>
> > +#include <linux/pm.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
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
> [...]
> > diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
> > new file mode 100644
> > index 00000000000000..7f4d696ca16d34
> > --- /dev/null
> > +++ b/drivers/iio/proximity/sx_common.h
> > @@ -0,0 +1,158 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Code shared between most Semtech SAR sensor driver.
> > + */
> > +
> > +#ifndef IIO_SX_COMMON_H
> > +#define IIO_SX_COMMON_H
> > +
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#define SX_COMMON_REG_IRQ_SRC                          0x00
> > +
> > +#define   SX9310_WHOAMI_VALUE                          0x01
> > +#define   SX9311_WHOAMI_VALUE                          0x02
> > +#define   SX9324_WHOAMI_VALUE                          0x23
> > +#define   SX9360_WHOAMI_VALUE                          0x60
>
> Can these two new defines come in the patches that add support for those
> chips?
Done.
>
> > +
> > +#define SX_COMMON_MAX_NUM_CHANNELS     4
> > +static_assert(SX_COMMON_MAX_NUM_CHANNELS < BITS_PER_LONG);
> > +
> > +struct sx_common_data;
> > +
> > +struct sx_common_reg_default {
> > +       u8 reg;
> > +       u8 def;
> > +};
> > +
> > +/** sx_common_ops: function pointers needed by common code
>
> The /** is on a line by itself for kernel-doc. Also missing 'struct'
Done. Check with ./scripts/kernel-doc
>
> > + *
> > + * List functions needed by common code to gather information or configure
> > + * the sensor.
> > + *
> > + * @read_prox_data:    Function to read raw proximity data.
> > + * @check_whoami:      Set device name based on whoami register.
> > + * @init_compensation: Function to set initial compensation.
> > + * @wait_for_sample:   When there are no physical IRQ, function to wait for a
> > + *                     sample to be ready.
>
> Missing get_default_reg.
Done, check with ./scripts/kernel-doc
>
> > + */
> > +struct sx_common_ops {
> > +       int (*read_prox_data)(struct sx_common_data *data,
> > +                             const struct iio_chan_spec *chan, __be16 *val);
> > +       int (*check_whoami)(struct device *dev, struct iio_dev *indio_dev);
> > +       int (*init_compensation)(struct iio_dev *indio_dev);
> > +       int (*wait_for_sample)(struct sx_common_data *data);
> > +       const struct sx_common_reg_default  *
> > +               (*get_default_reg)(struct device *dev, int idx,
> > +                                  struct sx_common_reg_default *reg_def);
> > +};
> > +
> > +/**
> > + * struct sx_common_chip_info: Semtech Sensor private chip information
> > + *
> > + * @reg_stat:          Main status register address.
> > + * @reg_irq_msk:       IRQ mask register address.
> > + * @reg_enable_chan:   Address to enable/disable channels/phases.
> > + * @reg_reset:         Reset register address.
> > + *
> > + * @mask_enable_chan:  Mask over the channels bits in the enable channel
> > + *                     register.
> > + * @irq_msk_offset:    Offset to enable interrupt in the IRQ mask
> > + *                     register.
> > + *
> > + * @num_channels:      Number of channel/phase.
> > + * @num_default_regs:  Number of internal registers that can be configured.
> > + *
> > + * @ops:               Private functions pointers.
> > + *
> > + * @iio_channels:      Description of exposed iio channels.
> > + * @num_iio_channels:  Number of iio_channels.
> > + * @iio_info:          iio_info structure for this driver.
> > + *
> > + */
> > +struct sx_common_chip_info {
> > +       unsigned int reg_stat;
> > +       unsigned int reg_irq_msk;
> > +       unsigned int reg_enable_chan;
> > +       unsigned int reg_reset;
> > +
> > +       unsigned int mask_enable_chan;
> > +       unsigned int irq_msk_offset;
> > +       unsigned int num_channels;
> > +       int num_default_regs;
> > +
> > +       struct sx_common_ops ops;
> > +
> > +       const struct iio_chan_spec *iio_channels;
> > +       int num_iio_channels;
> > +       struct iio_info iio_info;
> > +};
> > +
> > +/**
> > + * struct sx_common_data: Semtech Sensor private data structure.
> > + *
> > + * @info:              Structure defining sensor internals.
> > + * @mutex:             Serialize access to registers and channel configuration.
> > + * @num_channels:      Number of channel/phase.
> > + * @completion:                completion object to wait for data acquisition.
> > + * @client:            I2C client structure.
> > + * @trig:              IIO trigger object.
> > + * @regmap:            Register map.
> > + *
> > + * @num_default_regs:  Number of default registers to set at init.
> > + * @supplies:          Power supplies object.
> > + * @chan_prox_stat:    Last reading of the proximity status for each channel.
> > + *                     We only send an event to user space when this changes.
> > + * @trigger_enabled:   True when the device trigger is enabled.
> > + *
> > + * @buffer:            Bufffer to store raw samples.
> > + * @suspend_ctrl:      Remember enabled channels and sample rate during suspend.
> > + * @chan_read:         Bit field for each raw channel enabled.
> > + * @chan_event:                Bit field for each event enabled.
> > + *
> > + */
> > +struct sx_common_data {
> > +       const struct sx_common_chip_info *info;
>
> Maybe 'chip_info' so we don't alias with the other 'info' in this patch,
> iio_event_info? Similar comment wherever it's passed as 'info' to some
> function.
Done.



>
> > +
> > +       struct mutex mutex;
> > +       struct completion completion;
> > +       struct i2c_client *client;
> > +       struct iio_trigger *trig;
> > +       struct regmap *regmap;
> > +
> > +       struct regulator_bulk_data supplies[2];
> > +       unsigned long chan_prox_stat;
> > +       bool trigger_enabled;
> > +
> > +       /* Ensure correct alignment of timestamp when present. */
> > +       struct {
> > +               __be16 channels[SX_COMMON_MAX_NUM_CHANNELS];
> > +               s64 ts __aligned(8);
> > +       } buffer;
> > +
> > +       unsigned int suspend_ctrl;
> > +       unsigned long chan_read;
> > +       unsigned long chan_event;
> > +};
> > +
