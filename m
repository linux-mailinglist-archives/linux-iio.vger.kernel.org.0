Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F269B444F8B
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 08:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhKDHSb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 03:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKDHSb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 03:18:31 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB591C061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 00:15:53 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id c206so4348425iof.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 00:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MsQsTGVwZzCNJZdH7tGt0Vkk4Jt2LeoKRR40ftJbHnQ=;
        b=MkSWCSbiYoDqybKpOJirQuLmUGvC+UePjqFMkWXF6Z6UK5clfzXdoWuEX95jqS6cSM
         bFoULG/ObmrBkcp7fQwnzf4FtAsdkolRAJVPW32HNVCS8QK2QLZyXNxHP20IC0w3wjED
         TvoEn7jEvwuuSJtoUpiFKMTD44Q6MjKK9DmxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsQsTGVwZzCNJZdH7tGt0Vkk4Jt2LeoKRR40ftJbHnQ=;
        b=TrZkHfZOpvebf2mhxF7qdJYrOX3s++InQa+ZXskXCR2YaOMWCCdNxlUhe7bMbqU/bp
         yb6s4/Ozmuo1lKJpsxHhTEWciFVABImzj/VuaCR2c2Rxr3MzmyiqDzF88RB3Z4Qq+G2t
         ifJy/2nyOFqyOxO5KH7I0qGZapFe2RR+ufgrjZszpR8+KkyEO55AQ2TXuH/7fmv1zQ/K
         0FatxOPZUeZX5mLHR4MttxJsyrszwheKKwT1x9KC1qLik58o8xAL9EzQzFEIcCcn/cFb
         egyyn9alU6ivXKsmyezqJcLw6bFu1lnFMVgHKXNOYHTW/+/V4Zw+CVrDHrXHgct5MerE
         nR0g==
X-Gm-Message-State: AOAM533ToNPD91GrvIwmh9ZyJXR+2N9KRBXWBfJp0BR59qplqnSLZvrP
        PYMRZMRRifMnpHbiKbdK9eRhTX9uxkYzLXc8YrlSyIDSzus=
X-Google-Smtp-Source: ABdhPJxief9go2058s/7ITkpzz0+nTEkVA2AsYk4dt2Uc/ColnFBMg1WpNQPjPi25+Mw71Kr8hx6j9OoW5jCbV1O7yQ=
X-Received: by 2002:a05:6602:1cc:: with SMTP id w12mr8255892iot.63.1636010153081;
 Thu, 04 Nov 2021 00:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211030111827.1494139-1-gwendal@chromium.org>
 <20211030111827.1494139-4-gwendal@chromium.org> <20211030180423.6451830e@jic23-huawei>
In-Reply-To: <20211030180423.6451830e@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 4 Nov 2021 00:15:41 -0700
Message-ID: <CAPUE2utpxe098AZEkAKnJDte7Kv8v3R44w71b0Tdba+vXskv2w@mail.gmail.com>
Subject: Re: [PATCH 3/5] iio: proximity: Add SX9324 support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, swboyd@chromium.org, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 30, 2021 at 9:59 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 30 Oct 2021 04:18:25 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > Semtech SAR sensor SX9324 is an evolution of the SX9310:
> > It has 4 phases that can be configure to capture and process data
> > from any of 3 CS pins and provide independent detection:
> > proximity, table proximity or body proximity.
> >
> > Gather antenna data:
> > echo sx9324-dev3 > trigger/current_trigger
> > echo 1 > scan_elements/in_proximity0_en
> > echo 1 > buffer/enable
> > od -v -An --endian=big -t d2 -w2 /dev/iio\:device3
> > (at 10Hz, the default).
> >
> > Trigger events:
> > Setting:
> > thresh_falling_period: 2 (events)
> > thresh_rising_period: 2 (events)
> > in_proximity0_thresh_either_value: 300
> > in_proximity0_thresh_either_hysteresis: 72
> >
> > using iio_event_monitor /dev/iio\:deviceX, approaching my hand to the
> > antenna pad, I see:
> > ...
> > Event: time: 1634763907532035297, type: proximity, channel: 0, evtype:
> > thresh, direction: falling
> > Event: time: 1634763910138104640, type: proximity, channel: 0, evtype:
> > thresh, direction: rising
> > ...
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>
> Various comment inline, but biggest one is lack of docs of non standard ABI
> which means discussion is very difficult.
>
> Jonathan
>
> > ---
> >  drivers/iio/proximity/Kconfig  |  18 +
> >  drivers/iio/proximity/Makefile |   3 +-
> >  drivers/iio/proximity/sx9324.c | 931 +++++++++++++++++++++++++++++++++
> >  3 files changed, 951 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/iio/proximity/sx9324.c
> >
> > diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> > index 7c7203ca3ac63..aaddf97f9b219 100644
> > --- a/drivers/iio/proximity/Kconfig
> > +++ b/drivers/iio/proximity/Kconfig
> > @@ -112,11 +112,15 @@ config SRF04
> >         To compile this driver as a module, choose M here: the
> >         module will be called srf04.
> >
> > +config SX_COMMON
> > +     tristate
> > +
> >  config SX9310
> >       tristate "SX9310/SX9311 Semtech proximity sensor"
> >       select IIO_BUFFER
> >       select IIO_TRIGGERED_BUFFER
> >       select REGMAP_I2C
> > +     select SX_COMMON
> >       depends on I2C
> >       help
> >         Say Y here to build a driver for Semtech's SX9310/SX9311 capacitive
> > @@ -125,6 +129,20 @@ config SX9310
> >         To compile this driver as a module, choose M here: the
> >         module will be called sx9310.
> >
> > +config SX9324
> > +     tristate "SX9324 Semtech proximity sensor"
> > +     select IIO_BUFFER
> > +     select IIO_TRIGGERED_BUFFER
> > +     select REGMAP_I2C
> > +     select SX_COMMON
> > +     depends on I2C
> > +     help
> > +       Say Y here to build a driver for Semtech's SX9324
> > +       proximity/button sensor.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called sx9324.
> > +
> >  config SX9500
> >       tristate "SX9500 Semtech proximity sensor"
> >       select IIO_BUFFER
> > diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> > index cbdac09433eb5..1b026fedc396c 100644
> > --- a/drivers/iio/proximity/Makefile
> > +++ b/drivers/iio/proximity/Makefile
> > @@ -14,7 +14,8 @@ obj-$(CONFIG_RFD77402)              += rfd77402.o
> >  obj-$(CONFIG_SRF04)          += srf04.o
> >  obj-$(CONFIG_SRF08)          += srf08.o
> >  obj-$(CONFIG_SX9310)         += sx9310.o
> > +obj-$(CONFIG_SX9324)         += sx9324.o
> > +obj-$(CONFIG_SX_COMMON)      += sx_common.o
> Previous patch...
Done
>
> >  obj-$(CONFIG_SX9500)         += sx9500.o
> >  obj-$(CONFIG_VCNL3020)               += vcnl3020.o
> >  obj-$(CONFIG_VL53L0X_I2C)    += vl53l0x-i2c.o
> > -
> stray
I just realized I missed this one.
>
> > diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> > new file mode 100644
> > index 0000000000000..41d9c950c5abd
> > --- /dev/null
> > +++ b/drivers/iio/proximity/sx9324.c
> > @@ -0,0 +1,931 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2021 Google LLC.
> > + *
> > + * Driver for Semtech's SX9324 capacitive proximity/button solution.
> > + * Based on SX9324 driver and copy of datasheet at:
> > + * https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License version 2 as published by
> > + * the Free Software Foundation.
> > + */
>
> SPDX tag usually means we can drop the GPL license blurb.
Done
>
> > +
>
> > +
> > +/* 4 channels, as defined in STAT0: PH0, PH1, PH2 and PH3. */
> > +#define SX9324_NUM_CHANNELS          4
> > +/* 3 CS pins: CS0, CS1, CS2. */
> > +#define SX9324_NUM_PINS                      3
> > +
> > +#define SX9324_CHANNEL(idx)                                          \
> > +     {                                                               \
> > +             .type = IIO_PROXIMITY,                                  \
> > +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
> > +                                   BIT(IIO_CHAN_INFO_HARDWAREGAIN),  \
> > +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> > +             .info_mask_separate_available =                         \
> > +                     BIT(IIO_CHAN_INFO_HARDWAREGAIN),                \
> > +             .indexed = 1,                                           \
> > +             .channel = idx,                                         \
> > +             .address = SX9324_REG_DIFF_MSB,                         \
> > +             .event_spec = sx_common_events,                         \
> > +             .num_event_specs = ARRAY_SIZE(sx_common_events),        \
> > +             .scan_index = idx,                                      \
> > +             .scan_type = {                                          \
> > +                     .sign = 's',                                    \
> > +                     .realbits = 12,                                 \
> > +                     .storagebits = 16,                              \
> > +                     .endianness = IIO_BE,                           \
> > +             },                                                      \
> > +     }
> > +
> > +static const struct iio_chan_spec sx9324_channels[] = {
> > +     SX9324_CHANNEL(0),                      /* Phase 0 */
> > +     SX9324_CHANNEL(1),                      /* Phase 1 */
> > +     SX9324_CHANNEL(2),                      /* Phase 2 */
> > +     SX9324_CHANNEL(3),                      /* Phase 3 */
> > +     IIO_CHAN_SOFT_TIMESTAMP(4),
> > +};
> > +
> > +static const char * const sx9324_cs_pin_usage[] = { "HZ", "MI", "DS", "GD" };
> > +
> > +static ssize_t sx9324_phase_configuration_show(struct device *dev,
> > +                                            struct device_attribute *attr,
> > +                                            char *buf)
> > +{
> > +     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> > +     struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +     struct sx_common_data *data = iio_priv(indio_dev);
> > +     unsigned int val;
> > +     int i, ret, pin_idx;
> > +     size_t len = 0;
> > +
> > +     ret = regmap_read(data->regmap, SX9324_REG_AFE_PH0 + this_attr->address, &val);
> > +
> > +     for (i = 0; i < SX9324_NUM_PINS; i++) {
> > +             pin_idx = (val & SX9324_REG_AFE_PH0_PIN_MASK(i)) >> (2 * i);
> > +             len += scnprintf(buf + len, PAGE_SIZE - len, "%s,",
> > +                              sx9324_cs_pin_usage[pin_idx]);
> > +     }
> > +     buf[len - 1] = '\n';
> > +     return len;
> > +}
> > +
> > +static ssize_t sx9324_phase_configuration_store(struct device *dev,
> > +                                             struct device_attribute *attr,
> > +                                             const char *buf,
> > +                                             size_t len)
> > +{
> > +     return -EINVAL;
>
> Don't do this. If they are read only treat them correctly as such
> with appropriate permissions etc.
used channel .ext_info instead.
>
> > +}
> > +
> > +#define IIO_DEV_ATTR_PHASE_CONFIG(_idx) \
> > +IIO_DEVICE_ATTR(in_proximity_configuration##_idx, 0644, \
> > +             sx9324_phase_configuration_show, \
> > +             sx9324_phase_configuration_store, _idx)
> > +
> > +static IIO_DEV_ATTR_PHASE_CONFIG(0);
> > +static IIO_DEV_ATTR_PHASE_CONFIG(1);
> > +static IIO_DEV_ATTR_PHASE_CONFIG(2);
> > +static IIO_DEV_ATTR_PHASE_CONFIG(3);
>
> Documentation of these? I'm not going to comment on them without appropriate
> docs in
>
> Documentation/ABI/testing/
>
> Just wastes time figuring out what they are.
It is not easy to explain without the doc (not released by semtech but
available at https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf),
but let me try:

Each sensor has 3 inputs, CS0, CS1 and CS2. Hardware engineers decide
if the input is not connected (HZ), grounded (GD), connected to an
antenna where it can act as a base (DS - data shield), or measured
input (MI).
The sensor rotates measurement across 4 phases (PH0, PH1, PH2, PH3),
where the inputs are configured and then measured.
By default,  during the first phase, [PH0], CS0 is measured, while CS1
and CS2 are used as shields. `cat in_proximity0_mode` returns
"MI,DS,DS".
I did not make this change configurable: if the hardware designer
decided to ground or leave an input dangling, it does not make sense
to set it as a shield. [it can be changed if the need arises].
Having 4 phases allows different treatment of the input. For instance,
one phase could be used for object detection,the other for body
detection. Configuring each phase is not implemented yet.

Add missing documentation in ABI/testing/sysfs-bus-iio-sx9324.

>
>
> ...
>us
>
>
> > +static int sx9324_write_raw(struct iio_dev *indio_dev,
> > +                         const struct iio_chan_spec *chan, int val, int val2,
> > +                         long mask)
> > +{
> > +     struct sx_common_data *data = iio_priv(indio_dev);
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             return sx9324_set_samp_freq(data, val, val2);
> > +     case IIO_CHAN_INFO_HARDWAREGAIN:
> > +             return sx9324_write_gain(data, chan, val);
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static struct attribute *sx9324_attributes[] = {
> > +     &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>
> As mentioned in previous review, ideally move this to using the
> read_avail callback.
Done.
>
> > +     &iio_dev_attr_in_proximity_configuration0.dev_attr.attr,
> > +     &iio_dev_attr_in_proximity_configuration1.dev_attr.attr,
> > +     &iio_dev_attr_in_proximity_configuration2.dev_attr.attr,
> > +     &iio_dev_attr_in_proximity_configuration3.dev_attr.attr,
> > +     NULL
> > +};
>
> ...
>
> > +
> > +static const struct acpi_device_id sx9324_acpi_match[] = {
> > +     { "STH9324", SX9324_WHOAMI_VALUE},
>
> Any reference to a board, preferably with a dump of the DSDT/SSDT
> that uses this or an official doc etc to justify that it's valid?
>
> STH isn't in the pnp database so if it's in the wild we need a comment
> to say where.

STH93xx follow the convention adopted for older sensors:
Semtech SX9310: STH9310: https://drivers.eu/DeviceId/ACPI%5CSTH9310
Semtech SX9500: STH9500: https://drivers.eu/DeviceId/ACPI%5CSTH9500



>
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, sx9324_acpi_match);
> > +
> ...
>
