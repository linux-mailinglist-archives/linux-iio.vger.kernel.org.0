Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F1B316108
	for <lists+linux-iio@lfdr.de>; Wed, 10 Feb 2021 09:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBJIbC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Feb 2021 03:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhBJIaj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2021 03:30:39 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1DCC06174A
        for <linux-iio@vger.kernel.org>; Wed, 10 Feb 2021 00:29:59 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id f2so1059406ioq.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Feb 2021 00:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mK7YnMmK+qe+iHkzBCGOZFYLKrBvUMqrDRvVqkHIMk=;
        b=kRXY56OGfXgnarKojbs9Mc3fMH5td6OoFbmce7m00KPyzVT/s5kYTv8Ubf43UxTBOB
         cfkHoA03/coAxM8W7/SvkSjVRasJjzgaXtuHqfI9hIiHqOU5es+h4VBzPP+zyHluF9D/
         H3t40kPxAKZna5joythv86hFALJdeYDbRoivg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mK7YnMmK+qe+iHkzBCGOZFYLKrBvUMqrDRvVqkHIMk=;
        b=HKr8XChIGIk+WBgWkUpJhzEEwFAIkrB17jkRc25er1B18Bb57uNTs896YAlRJQQnc8
         5FfY371hIfcKCdGfwvehpFIs96/HzYkPQYoY+RB6jrgi845EDAN/sgMTBdywrPLwEFHr
         8JPjjVvh7Sdd24tcUxR7ulvEb/uopXUX1Wu+f5UrAVGgNqm4Rrlw85h2ZfRC2+VmmKBn
         WA62IQ2dFJ2+IIdBPCbGxUinhjB2Fj7MmDvXKAC7aOSdCTZkDheLarTc2jrbsY8O3w4h
         pS2TXZp91+LTMfEKbA20jT6xIdcsekJJFy9S92BlyBnBsFVsaQ5bzK3pdBOZXq+Pp/JI
         yKnw==
X-Gm-Message-State: AOAM530tOj1ztjUQvB6L7mk+rK3URGtjwmXk7JbVqFgXa8jIB2xhOUpo
        ezv5eXorZNyM8TjCEfpVLJwB0kpQqOqqXBzN5HjWcg==
X-Google-Smtp-Source: ABdhPJzRUcl05SXYMupODGV5BeFPUv5YoSTpFIsCzxkqCeY/dyVft+YvjCCfC0IKg/iTkrz9DIuYMVlnvH2uQajGb1w=
X-Received: by 2002:a02:2a01:: with SMTP id w1mr2114826jaw.19.1612945796038;
 Wed, 10 Feb 2021 00:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20210210025142.3609708-1-swboyd@chromium.org> <20210210025142.3609708-4-swboyd@chromium.org>
In-Reply-To: <20210210025142.3609708-4-swboyd@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 10 Feb 2021 00:29:45 -0800
Message-ID: <CAPUE2utey1os_CmYxHdmObCSPZWFGrLCVfP24wuZj_iQDNqQ5Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity driver
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 9, 2021 at 6:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Add support for a ChromeOS EC proximity driver that exposes a "front"
> proximity sensor via the IIO subsystem. The EC decides when front
> proximity is near and sets an MKBP switch 'EC_MKBP_FRONT_PROXIMITY' to
> notify the kernel of proximity. Similarly, when proximity detects
> something far away it sets the switch bit to 0. For now this driver
> exposes a single sensor, but it could be expanded in the future via more
> MKBP bits if desired.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v4:
>  * Dropped of_match_ptr()
>
>  drivers/iio/proximity/Kconfig                 |  11 +
>  drivers/iio/proximity/Makefile                |   1 +
>  .../iio/proximity/cros_ec_mkbp_proximity.c    | 242 ++++++++++++++++++
>  3 files changed, 254 insertions(+)
>  create mode 100644 drivers/iio/proximity/cros_ec_mkbp_proximity.c
>
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 12672a0e89ed..7c7203ca3ac6 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -21,6 +21,17 @@ endmenu
>
>  menu "Proximity and distance sensors"
>
> +config CROS_EC_MKBP_PROXIMITY
> +       tristate "ChromeOS EC MKBP Proximity sensor"
> +       depends on CROS_EC
> +       help
> +         Say Y here to enable the proximity sensor implemented via the ChromeOS EC MKBP
> +         switches protocol. You must enable one bus option (CROS_EC_I2C or CROS_EC_SPI)
> +         to use this.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called cros_ec_mkbp_proximity.
> +
>  config ISL29501
>         tristate "Intersil ISL29501 Time Of Flight sensor"
>         depends on I2C
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index 9c1aca1a8b79..cbdac09433eb 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -5,6 +5,7 @@
>
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AS3935)           += as3935.o
> +obj-$(CONFIG_CROS_EC_MKBP_PROXIMITY) += cros_ec_mkbp_proximity.o
>  obj-$(CONFIG_ISL29501)         += isl29501.o
>  obj-$(CONFIG_LIDAR_LITE_V2)    += pulsedlight-lidar-lite-v2.o
>  obj-$(CONFIG_MB1232)           += mb1232.o
> diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
> new file mode 100644
> index 000000000000..2cdaf05c0ec2
> --- /dev/null
> +++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for cros-ec proximity sensor exposed through MKBP switch
> + *
> + * Copyright 2021 Google LLC.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include <asm/unaligned.h>
> +
> +struct cros_ec_mkbp_proximity_data {
> +       struct cros_ec_device *ec;
> +       struct iio_dev *indio_dev;
> +       struct mutex lock;
> +       struct notifier_block notifier;
> +       bool enabled;
> +};
> +
> +static const struct iio_event_spec cros_ec_mkbp_proximity_events[] = {
> +       {
> +               .type = IIO_EV_TYPE_THRESH,
> +               .dir = IIO_EV_DIR_EITHER,
> +               .mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +       },
> +};
> +
> +static const struct iio_chan_spec cros_ec_mkbp_proximity_chan_spec[] = {
> +       {
> +               .type = IIO_PROXIMITY,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +               .event_spec = cros_ec_mkbp_proximity_events,
> +               .num_event_specs = ARRAY_SIZE(cros_ec_mkbp_proximity_events),
> +       },
> +};
> +
> +static int cros_ec_mkbp_proximity_parse_state(const void *data)
> +{
> +       u32 switches = get_unaligned_le32(data);
> +
> +       return !!(switches & BIT(EC_MKBP_FRONT_PROXIMITY));
> +}
> +
> +static int cros_ec_mkbp_proximity_query(struct cros_ec_device *ec_dev,
> +                                       int *state)
> +{
> +       struct {
> +               struct cros_ec_command msg;
> +               union {
> +                       struct ec_params_mkbp_info params;
> +                       u32 switches;
> +               };
> +       } __packed buf = { };
> +       struct ec_params_mkbp_info *params = &buf.params;
> +       struct cros_ec_command *msg = &buf.msg;
> +       u32 *switches = &buf.switches;
> +       size_t insize = sizeof(*switches);
> +       int ret;
> +
> +       msg->command = EC_CMD_MKBP_INFO;
> +       msg->version = 1;
> +       msg->outsize = sizeof(*params);
> +       msg->insize = insize;
> +
> +       params->info_type = EC_MKBP_INFO_CURRENT;
> +       params->event_type = EC_MKBP_EVENT_SWITCH;
> +
> +       ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (ret != insize) {
> +               dev_warn(ec_dev->dev, "wrong result size: %d != %zu\n", ret,
> +                        insize);
> +               return -EPROTO;
> +       }
> +
> +       *state = cros_ec_mkbp_proximity_parse_state(switches);
> +       return IIO_VAL_INT;
> +}
> +
> +static int cros_ec_mkbp_proximity_notify(struct notifier_block *nb,
> +                                        unsigned long queued_during_suspend,
> +                                        void *_ec)
> +{
> +       struct cros_ec_mkbp_proximity_data *data;
> +       struct cros_ec_device *ec = _ec;
> +       u8 event_type = ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK;
> +       void *switches = &ec->event_data.data.switches;
> +       struct iio_dev *indio_dev;
> +       s64 timestamp;
> +       int state, dir;
> +       u64 ev;
> +
> +       if (event_type == EC_MKBP_EVENT_SWITCH) {
> +               data = container_of(nb, struct cros_ec_mkbp_proximity_data,
> +                                   notifier);
> +               indio_dev = data->indio_dev;
> +
> +               mutex_lock(&data->lock);
> +               if (data->enabled) {
> +                       timestamp = ktime_to_ns(ec->last_event_time);
Note to self, ktime_to_ns is a noop, but make code cleaner: need to
change other access to ec->last_event_time.
> +                       if (iio_device_get_clock(indio_dev) != CLOCK_BOOTTIME)
> +                               timestamp = iio_get_time_ns(indio_dev);
> +                       state = cros_ec_mkbp_proximity_parse_state(switches);
There can be several switches in the EC (lid open, tablet mode, ...),
so you can get a switch event even when the proximity switch did not
trigger.
You can keep the current state and push an iio event only when there
is a change. See cbas_ec_notify().
> +                       dir = state ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
> +
> +                       ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> +                                                 IIO_EV_TYPE_THRESH, dir);
> +                       iio_push_event(indio_dev, ev, timestamp);
> +               }
> +               mutex_unlock(&data->lock);
> +       }
> +
> +       return NOTIFY_OK;
> +}
> +
> +static int cros_ec_mkbp_proximity_read_raw(struct iio_dev *indio_dev,
> +                          const struct iio_chan_spec *chan, int *val,
> +                          int *val2, long mask)
> +{
> +       struct cros_ec_mkbp_proximity_data *data = iio_priv(indio_dev);
> +       struct cros_ec_device *ec = data->ec;
> +
> +       if (chan->type != IIO_PROXIMITY)
> +               return -EINVAL;
> +
> +       switch (mask) {
A switch is not necessary here.
> +       case IIO_CHAN_INFO_RAW:
> +               return cros_ec_mkbp_proximity_query(ec, val);
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int cros_ec_mkbp_proximity_read_event_config(struct iio_dev *indio_dev,
> +                                   const struct iio_chan_spec *chan,
> +                                   enum iio_event_type type,
> +                                   enum iio_event_direction dir)
> +{
> +       struct cros_ec_mkbp_proximity_data *data = iio_priv(indio_dev);
> +
> +       return data->enabled;
> +}
> +
> +static int cros_ec_mkbp_proximity_write_event_config(struct iio_dev *indio_dev,
> +                                    const struct iio_chan_spec *chan,
> +                                    enum iio_event_type type,
> +                                    enum iio_event_direction dir, int state)
> +{
> +       struct cros_ec_mkbp_proximity_data *data = iio_priv(indio_dev);
> +
> +       mutex_lock(&data->lock);
> +       data->enabled = state;
> +       mutex_unlock(&data->lock);
> +
> +       return 0;
> +}
> +
> +static const struct iio_info cros_ec_mkbp_proximity_info = {
> +       .read_raw = cros_ec_mkbp_proximity_read_raw,
> +       .read_event_config = cros_ec_mkbp_proximity_read_event_config,
> +       .write_event_config = cros_ec_mkbp_proximity_write_event_config,
> +};
> +
> +static int cros_ec_mkbp_proximity_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct cros_ec_device *ec = dev_get_drvdata(dev->parent);
> +       struct iio_dev *indio_dev;
> +       struct cros_ec_mkbp_proximity_data *data;
> +       int ret;
> +
> +       indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       data = iio_priv(indio_dev);
> +       data->ec = ec;
> +       data->indio_dev = indio_dev;
> +       mutex_init(&data->lock);
> +       platform_set_drvdata(pdev, data);
> +
> +       indio_dev->name = dev->driver->name;
> +       indio_dev->info = &cros_ec_mkbp_proximity_info;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->channels = cros_ec_mkbp_proximity_chan_spec;
> +       indio_dev->num_channels = ARRAY_SIZE(cros_ec_mkbp_proximity_chan_spec);
> +
> +       ret = devm_iio_device_register(dev, indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       data->notifier.notifier_call = cros_ec_mkbp_proximity_notify;
> +       blocking_notifier_chain_register(&ec->event_notifier, &data->notifier);
> +
> +       return 0;
> +}
> +
> +static int cros_ec_mkbp_proximity_remove(struct platform_device *pdev)
> +{
> +       struct cros_ec_mkbp_proximity_data *data = platform_get_drvdata(pdev);
> +       struct cros_ec_device *ec = data->ec;
> +
> +       blocking_notifier_chain_unregister(&ec->event_notifier,
> +                                          &data->notifier);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id cros_ec_mkbp_proximity_of_match[] = {
> +       { .compatible = "google,cros-ec-mkbp-proximity" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, cros_ec_mkbp_proximity_of_match);
> +
> +static struct platform_driver cros_ec_mkbp_proximity_driver = {
> +       .driver = {
> +               .name = "cros-ec-mkbp-proximity",
> +               .of_match_table = cros_ec_mkbp_proximity_of_match,
> +       },
> +       .probe = cros_ec_mkbp_proximity_probe,
> +       .remove = cros_ec_mkbp_proximity_remove,
> +};
> +module_platform_driver(cros_ec_mkbp_proximity_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ChromeOS EC MKBP proximity sensor driver");
> --
> https://chromeos.dev
>
