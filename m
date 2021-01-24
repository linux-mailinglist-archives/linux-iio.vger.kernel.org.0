Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591FB301EED
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 22:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbhAXVmk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Jan 2021 16:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbhAXVmh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2021 16:42:37 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DD1C061574
        for <linux-iio@vger.kernel.org>; Sun, 24 Jan 2021 13:41:57 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q129so22766092iod.0
        for <linux-iio@vger.kernel.org>; Sun, 24 Jan 2021 13:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6lwV28GijY7rTHRfDpxxrCaKS6WvW3gX681i6ru1Cg=;
        b=ENb5DAuDy3PaY65g0ICGXitGeIT4QgOzh32R1huFEo2KSm44etc2scNVyyWh+tyO1x
         CAprWKugAF/cZEj/sunHXxim9E4t2u3iMqj3fg0AGXVW103YHEx6kxdtl3CAXUyTHfNg
         2K+yFMQhY4lSTODW27qp24BGuSlyQd4SaGGws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6lwV28GijY7rTHRfDpxxrCaKS6WvW3gX681i6ru1Cg=;
        b=t+e+cs8HEIVFt9DXfbzQFrojydvE4SD71rQqSnY0IwAENq1P6AjgSO0wVFxzNgKpkd
         uV0DRFjBeDRO3m/fUdeQvxOmZyGnzRq/8BwcP4v8D0HijQthxS8DWD43O0Ro1mX1CBJL
         xaJ/Ebxey3wVySLLMJLbrlkRxcBppFHks2GjH3RMKD1ClzUxHBtp9uzp9WukW8OH7NWc
         L+XfPc1BvemW8hfWGqScxFVEG3RewbjuB/xm40gNedE5fsi4bmmLdCoyzEIqGZpxfuG0
         CCzkZK9kGXv9T9H4LDRy2XzH2BWPxjEFXGoR/sjd5yJ2VbhpMv+Pb5NGGPkQcOpXwyRI
         1eTA==
X-Gm-Message-State: AOAM530LmQeDVqF9ZixiNePJi2Q898nRTzh6/qrKtrP+eX/k4aS5rzLI
        o1C05ET6sTuGDlsKwrn9Y+/xPY/K1klrNe9uhQO9AQ==
X-Google-Smtp-Source: ABdhPJyXZzYDTIAIcHUr/KEtq1hGjuPn7nnyCg8uzJBbdtGTivrruVd5illo+njcpht4Pjb4sTJ+xRHwKQEszNvBCx4=
X-Received: by 2002:a02:5ec1:: with SMTP id h184mr808921jab.133.1611524516497;
 Sun, 24 Jan 2021 13:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20210122225443.186184-1-swboyd@chromium.org> <20210122225443.186184-4-swboyd@chromium.org>
 <20210124173820.4528b9c9@archlinux>
In-Reply-To: <20210124173820.4528b9c9@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sun, 24 Jan 2021 13:41:44 -0800
Message-ID: <CAPUE2uuQsa7=pjw+D=r0QtLGTd1kQa7X6VBVa73=gx47Vf7KDA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 24, 2021 at 9:38 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 22 Jan 2021 14:54:43 -0800
> Stephen Boyd <swboyd@chromium.org> wrote:
>
> > Add support for a ChromeOS EC proximity driver that exposes a "front"
> > proximity sensor via the IIO subsystem. The EC decides when front
> > proximity is near and sets an MKBP switch 'EC_MKBP_FRONT_PROXIMITY' to
> > notify the kernel of proximity. Similarly, when proximity detects
> > something far away it sets the switch bit to 0. For now this driver
> > exposes a single sensor, but it could be expanded in the future via more
> > MKBP bits if desired.
> >
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Benson Leung <bleung@chromium.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
> Hi Stephen,
>
> Looks more or less fine to me.  My main concern is potential confusion
> in naming with the cros_ec_prox_light driver that we already have.
>
> A few other minor bits and bobs inline.
>
> thanks,
>
> Jonathan
>
>
> > ---
> >  drivers/iio/proximity/Kconfig             |  11 +
> >  drivers/iio/proximity/Makefile            |   1 +
> >  drivers/iio/proximity/cros_ec_proximity.c | 252 ++++++++++++++++++++++
> >  3 files changed, 264 insertions(+)
> >  create mode 100644 drivers/iio/proximity/cros_ec_proximity.c
> >
> > diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> > index 12672a0e89ed..35a04e9ede7d 100644
> > --- a/drivers/iio/proximity/Kconfig
> > +++ b/drivers/iio/proximity/Kconfig
> > @@ -21,6 +21,17 @@ endmenu
> >
> >  menu "Proximity and distance sensors"
> >
> > +config CROS_EC_PROXIMITY
> > +     tristate "ChromeOS EC MKBP Proximity sensor"
> > +     depends on CROS_EC
> > +     help
> > +       Say Y here to enable the proximity sensor implemented via the ChromeOS EC MKBP
> > +       switches protocol. You must enable one bus option (CROS_EC_I2C or CROS_EC_SPI)
> > +       to use this.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called cros_ec_prox.
> > +
> >  config ISL29501
> >       tristate "Intersil ISL29501 Time Of Flight sensor"
> >       depends on I2C
> > diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> > index 9c1aca1a8b79..b1330dd8e212 100644
> > --- a/drivers/iio/proximity/Makefile
> > +++ b/drivers/iio/proximity/Makefile
> > @@ -5,6 +5,7 @@
> >
> >  # When adding new entries keep the list in alphabetical order
> >  obj-$(CONFIG_AS3935)         += as3935.o
> > +obj-$(CONFIG_CROS_EC_PROXIMITY)      += cros_ec_proximity.o
> >  obj-$(CONFIG_ISL29501)               += isl29501.o
> >  obj-$(CONFIG_LIDAR_LITE_V2)  += pulsedlight-lidar-lite-v2.o
> >  obj-$(CONFIG_MB1232)         += mb1232.o
> > diff --git a/drivers/iio/proximity/cros_ec_proximity.c b/drivers/iio/proximity/cros_ec_proximity.c
> > new file mode 100644
> > index 000000000000..a3aef911e3cc
> > --- /dev/null
> > +++ b/drivers/iio/proximity/cros_ec_proximity.c
> > @@ -0,0 +1,252 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for cros-ec proximity sensor exposed through MKBP switch
> > + *
> > + * Copyright 2021 Google LLC.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/kernel.h>
>
> Slight preference for alphabetical order though keeping specific
> sections separate as done here is fine.
>
> > +#include <linux/notifier.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +
> > +#include <linux/platform_data/cros_ec_commands.h>
> > +#include <linux/platform_data/cros_ec_proto.h>
> > +
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#include <asm/unaligned.h>
> > +
> > +struct cros_ec_proximity_data {
> > +     struct cros_ec_device *ec;
> > +     struct iio_dev *indio_dev;
> > +     struct mutex lock;
> > +     struct notifier_block notifier;
> > +     bool enabled;
> > +};
> > +
> > +static const struct iio_event_spec cros_ec_prox_events[] = {
> > +     {
> > +             .type = IIO_EV_TYPE_THRESH,
> > +             .dir = IIO_EV_DIR_EITHER,
> > +             .mask_separate = BIT(IIO_EV_INFO_ENABLE),
> > +     },
> > +};
> > +
> > +static const struct iio_chan_spec cros_ec_prox_chan_spec[] = {
> > +     {
> > +             .type = IIO_PROXIMITY,
> > +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +             .event_spec = cros_ec_prox_events,
> > +             .num_event_specs = ARRAY_SIZE(cros_ec_prox_events),
> > +     },
> > +};
> > +
> > +static int cros_ec_proximity_parse_state(const void *data)
> > +{
> > +     u32 switches = get_unaligned_le32(data);
> > +
> > +     return !!(switches & BIT(EC_MKBP_FRONT_PROXIMITY));
> > +}
> > +
> > +static int cros_ec_proximity_query(struct cros_ec_device *ec_dev, int *state)
> > +{
> > +     struct ec_params_mkbp_info *params;
> > +     struct cros_ec_command *msg;
> > +     int ret;
> > +
> > +     msg = kzalloc(sizeof(*msg) + max(sizeof(u32), sizeof(*params)),
> > +                   GFP_KERNEL);
>
> Given this is known at build time, perhaps better to add it to the
> iio_priv() accessed structure and avoid having to handle allocations
> separately.
As Jonathan said, it can be preallocated in iio private structure. We
can also use the stack, given the response size is known beforehand.
See cros_ec_cec_set_log_addr() or cros_ec_pwm_get_duty() for example.
>
> > +     if (!msg)
> > +             return -ENOMEM;
> > +
> > +     msg->command = EC_CMD_MKBP_INFO;
> > +     msg->version = 1;
> > +     msg->outsize = sizeof(*params);
> > +     msg->insize = sizeof(u32);
> > +     params = (struct ec_params_mkbp_info *)msg->data;
> > +     params->info_type = EC_MKBP_INFO_CURRENT;
> > +     params->event_type = EC_MKBP_EVENT_SWITCH;
> > +
> > +     ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> > +     if (ret >= 0) {
> > +             if (ret != sizeof(u32)) {
> > +                     dev_warn(ec_dev->dev, "wrong result size: %d != %zu\n",
> > +                              ret, sizeof(u32));
> > +                     ret = -EPROTO;
> > +             } else {
> > +                     *state = cros_ec_proximity_parse_state(msg->data);
> > +                     ret = 0;
> If you move the allocation as suggested above, this can become
>
> if (ret < 0)
>         return ret;
>
> if (ret != sizeof(u32)) {
>         ...
>         return -EPROTO;
> }
>
> *state = cros_..
> return 0;
>
> Which will be neater and not as deeply nested.
>
> > +             }
> > +     }
> > +
> > +     kfree(msg);
> > +
> > +     return ret;
> > +}
> > +
> > +static int cros_ec_proximity_notify(struct notifier_block *nb,
> > +                          unsigned long queued_during_suspend, void *_ec)
> > +{
> > +     struct cros_ec_proximity_data *data;
> > +     struct cros_ec_device *ec = _ec;
> > +     u8 event_type = ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK;
> > +     void *switches = &ec->event_data.data.switches;
> > +     struct iio_dev *indio_dev;
> > +     s64 timestamp;
> > +     int state, dir;
> > +     u64 ev;
> > +
> > +     if (event_type == EC_MKBP_EVENT_SWITCH) {
> > +             data = container_of(nb, struct cros_ec_proximity_data, notifier);
> > +             indio_dev = data->indio_dev;
> > +
> > +             mutex_lock(&data->lock);
> > +             if (data->enabled) {
> > +                     timestamp = iio_get_time_ns(indio_dev);
For Android, given the timestamp must be time it happens, not reported
[https://source.android.com/devices/sensors/sensors-hal2] """The
timestamp must be accurate and correspond to the time at which the
event physically happened, not the time it was reported.""", consider
using ec_dev->last_event_time and apply a delta if the iio clock base
is different from CLOCK_BOOTTIME.
> > +                     state = cros_ec_proximity_parse_state(switches);
> > +                     dir = state ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
> > +
> > +                     ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> > +                                               IIO_EV_TYPE_THRESH, dir);
> > +                     iio_push_event(indio_dev, ev, timestamp);
> > +             }
> > +             mutex_unlock(&data->lock);
> > +     }
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +static int cros_ec_proximity_read_raw(struct iio_dev *indio_dev,
> > +                        const struct iio_chan_spec *chan, int *val,
> > +                        int *val2, long mask)
> > +{
> > +     struct cros_ec_proximity_data *data = iio_priv(indio_dev);
> > +     struct cros_ec_device *ec = data->ec;
> > +     int ret;
> > +
> > +     if (chan->type != IIO_PROXIMITY)
> > +             return -EINVAL;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret = iio_device_claim_direct_mode(indio_dev);
>
> Normally we only introduce these protections when adding the ability
> to change the state from direct to buffered (which these prevent).
> This driver doesn't yet support any other modes so I don't think
> there is any benefit in having these.
>
> If the aim is more local protection then should use a local lock
> as the semantics fo these functions might change in future.
>
>
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret = cros_ec_proximity_query(ec, val);
> > +             iio_device_release_direct_mode(indio_dev);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             return IIO_VAL_INT;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int cros_ec_proximity_read_event_config(struct iio_dev *indio_dev,
> > +                                 const struct iio_chan_spec *chan,
> > +                                 enum iio_event_type type,
> > +                                 enum iio_event_direction dir)
> > +{
> > +     struct cros_ec_proximity_data *data = iio_priv(indio_dev);
> > +
> > +     return data->enabled;
> > +}
> > +
> > +static int cros_ec_proximity_write_event_config(struct iio_dev *indio_dev,
> > +                                  const struct iio_chan_spec *chan,
> > +                                  enum iio_event_type type,
> > +                                  enum iio_event_direction dir, int state)
> > +{
> > +     struct cros_ec_proximity_data *data = iio_priv(indio_dev);
> > +
> > +     mutex_lock(&data->lock);
> > +     data->enabled = state;
> > +     mutex_unlock(&data->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct iio_info cros_ec_proximity_info = {
> > +     .read_raw = cros_ec_proximity_read_raw,
> > +     .read_event_config = cros_ec_proximity_read_event_config,
> > +     .write_event_config = cros_ec_proximity_write_event_config,
> > +};
> > +
> > +static int cros_ec_proximity_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct cros_ec_device *ec = dev_get_drvdata(dev->parent);
> > +     struct iio_dev *indio_dev;
> > +     struct cros_ec_proximity_data *data;
> > +     int ret;
> > +
> > +     indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     data = iio_priv(indio_dev);
> > +     data->ec = ec;
> > +     data->indio_dev = indio_dev;
> > +     mutex_init(&data->lock);
> > +     platform_set_drvdata(pdev, data);
> > +
> > +     indio_dev->name = "cros_ec_proximity";
Define a constant CROS_EC_[MKBP_]PROXIMITY_DRIVER_NAME and use it here
and in struct platform_driver cros_ec_proximity_driver.
> > +     indio_dev->dev.parent = dev;
Not needed, done by iio_device_alloc(), called by devm_iio_device_alloc().
> > +     indio_dev->info = &cros_ec_proximity_info;
> > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > +     indio_dev->channels = cros_ec_prox_chan_spec;
> > +     indio_dev->num_channels = ARRAY_SIZE(cros_ec_prox_chan_spec);
> > +
> > +     ret = devm_iio_device_register(dev, indio_dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     data->notifier.notifier_call = cros_ec_proximity_notify;
> > +     ret = blocking_notifier_chain_register(&ec->event_notifier,
> > +                                            &data->notifier);
> > +     if (ret)
> > +             dev_err(dev, "cannot register notifier: %d\n", ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static int cros_ec_proximity_remove(struct platform_device *pdev)
> > +{
> > +     struct cros_ec_proximity_data *data = platform_get_drvdata(pdev);
> > +     struct cros_ec_device *ec = data->ec;
> > +
> > +     blocking_notifier_chain_unregister(&ec->event_notifier,
> > +                                        &data->notifier);
> > +
> > +     return 0;
> > +}
> > +
> > +#ifdef CONFIG_OF
>
> As a general rule, we are trying to clear out protections on CONFIG_OF etc
> and use of of_match_ptr() on the basis they don't really gain us anything
> and prevent use of some other firmware types.  Here I guess you know what
> your firmware looks like, but I'm still keen to drop it in the interests
> of there being fewer places to copy it from.
>
> It may be a good idea to give this a more specific name as well given
> we already have cros-ec-prox as a platform device id from
> the cros_ec_light_prox driver.
>
>
> > +static const struct of_device_id cros_ec_proximity_of_match[] = {
> > +     { .compatible = "google,cros-ec-proximity" },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, cros_ec_proximity_of_match);
> > +#endif
> > +
> > +static struct platform_driver cros_ec_proximity_driver = {
> > +     .driver = {
> > +             .name = "cros-ec-proximity",
> > +             .of_match_table = of_match_ptr(cros_ec_proximity_of_match),
Add a ACPI match table to match.
> > +     },
> > +     .probe = cros_ec_proximity_probe,
> > +     .remove = cros_ec_proximity_remove,
> > +};
> > +module_platform_driver(cros_ec_proximity_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("ChromeOS EC MKBP proximity sensor driver");
>
