Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE08398DC8
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 17:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhFBPE1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 11:04:27 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:45900 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhFBPEU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 11:04:20 -0400
Received: by mail-pf1-f177.google.com with SMTP id d16so2369647pfn.12
        for <linux-iio@vger.kernel.org>; Wed, 02 Jun 2021 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFKZzHEpjqH0kFWk2QrqMoH051oh2DiaRhTWjg6yaZY=;
        b=mEsvsE0hHSZTVpqGDb+YvGWV1MOgOXEilfU3jBAdsIx0stiT0P9g5k+M87MMwI5mAK
         tOxGJ5AVXLjLOCl1laPg/a2Y1C9GtfFYHMP8sHtSDC8Chppi5xE/u3E1mw1WhFVJH7mt
         srgsqd4Vafq7a/TvgFPtFy7PxM5BTp3k8BWFABP89WYNzYCwZEhlUpZCTRg8840ibvgP
         emMTILVZDbfCaXDPVHTXiKJ1UdP1+UKEHmyjG6a/EV/ABhNMzRsFh4oMExCqv/caiexy
         Omhg0q3o2R0FmOGufOlhOGpuf1ZyOTZjGQUNmuAGcC03Y9jWkqonP33Yd4icim8X2rj3
         cSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFKZzHEpjqH0kFWk2QrqMoH051oh2DiaRhTWjg6yaZY=;
        b=f5n1ZdJmUQihbrKImWMScRdwJ2eWynYlsa1oL8iomX4rGqGPuNJZ6Gqi2fzbNI5to9
         F0PwPd24vN6mk15rUjdJgnAmWp/qPZQQwMMmzqWBpUtFljBC/2bDV8SrSKpRbMRh9lzy
         oO2dPYoLrV8o1YjdjNhaunIYkvNNnfEiz30h77m3cg0g/hodF0PIVXPX6Jiua7JyS5MP
         Q3gU9+BTPZ7am9ZpoHovhYFx74mHAXylGOsChjsUoAvRqnGMlvDptsj18x9HFLPthI+n
         8kSp7y3rp+shaXs64Q8ndMdL1daTBWwfkazC1d+qDnKpvbXA1ua8mqueY6gcYKd0avdu
         bw+w==
X-Gm-Message-State: AOAM532xIpGk9jzVY/lb7DdOG3FHzR74uyN+R78sfO5ZaqCgl0lzXeM5
        B4H6Fg77xAUq6zq7BgeHzfEczsdv5jqdrrWqgb9GnKFT2W+g7w==
X-Google-Smtp-Source: ABdhPJy4fh+2QWFpAXURjR82VvFOReiLYPeA7AjmaKgRo3wPmBktAdjogvzXszwisk1Qdhql4HWFad7B8Wzp7YaJ140=
X-Received: by 2002:a05:6a00:1591:b029:2d9:369a:b846 with SMTP id
 u17-20020a056a001591b02902d9369ab846mr27947605pfk.40.1622646096791; Wed, 02
 Jun 2021 08:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210602134512.193186-1-chf.fritz@googlemail.com> <20210602134512.193186-2-chf.fritz@googlemail.com>
In-Reply-To: <20210602134512.193186-2-chf.fritz@googlemail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Jun 2021 18:01:20 +0300
Message-ID: <CAHp75Vd4Ar-mdBNApEwB+wb_Km2zWMuyQpWU8GDqrA2g0c5Chw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: light: Add support for Intersil isl76683 sensor
To:     Christoph Fritz <chf.fritz@googlemail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 2, 2021 at 4:45 PM Christoph Fritz <chf.fritz@googlemail.com> wrote:
>
> This patch adds support for Intersil isl76683 light sensor.

Any Datasheet link? (If it's one there, add it here as Datasheet: tag)

...


Missed bits.h

> +#include <linux/module.h>

Missed mod_devicetable.h

> +#include <linux/i2c.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/util_macros.h>

+ blank line

Ordered alphabetically?

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>

Ditto.

...

> +#define ISL76683_INTPERS_MASK          0x3

GENMASK()
...

> +#define ISL76683_LUXRANGE_MASK         (0x3 << ISL76683_LUXRANGE_SHFT)

GENMASK() with direct numbers, please. No need to reuse those shifts here.

...

> +#define ISL76683_RESOLUTION_MASK       (0x3 << ISL76683_RESOLUTION_SHFT)

Ditto.

...

> +enum isl76683_dmode {

> +       ISL76683_DIODE_0 = 0,

0 is default by C standard.
Ditto for all enums.

> +       ISL76683_DIODE_IR,
> +       ISL76683_DIODE_DIFF,
> +};

...

> +static const int isl76683_lux_ranges_available[] = {
> +       1000, 4000, 16000, 64000};

Wrong indentation, i.e. '};' part should be on a separate line.

...

> +struct isl76683_chip {
> +       enum isl76683_lux_range         luxrange;
> +       enum isl76683_dmode             photodiode;
> +       struct i2c_client               *client;
> +       struct regmap                   *rmp;
> +       struct completion               irq_complete;
> +       struct iio_trigger              *trig;
> +       bool                            trig_enabled;

> +       struct mutex                    lock;

Lock must be explained. What's for?

> +       s64                             time_ns;
> +};

...

> +static int isl76683_singleshot_conversion(struct isl76683_chip *chip, int *val)
> +{
> +       long timeout;
> +       int ret;

> +       /* wait for measurement to complete */
> +       timeout = wait_for_completion_interruptible_timeout(
> +                       &chip->irq_complete,

> +                       msecs_to_jiffies(5000));

Magic number. Add a self-explanatory definition with explanation of
the chosen value.

> +       if (timeout == 0) {
> +               dev_err(&chip->client->dev, "measurement timed out\n");
> +               return -ETIMEDOUT;
> +       } else if (timeout < 0) {
> +               dev_err(&chip->client->dev, "wait for measurement failed\n");
> +               return -EINTR;
> +       }
> +
> +       ret = isl76683_get_sensordata(chip, val);
> +       if (ret) {
> +               dev_err(&chip->client->dev, "%s: Error %d reading lux\n",
> +                               __func__, ret);

Drop __func__, it doesn't bring any value.

> +               return ret;
> +       }
> +
> +       return IIO_VAL_INT;
> +}

...

> +static irqreturn_t isl76683_trigger_handler(int irq, void *p)
> +{

> +done:

out_unlock: ?

> +       mutex_unlock(&chip->lock);
> +       iio_trigger_notify_done(indio_dev->trig);
> +       return IRQ_HANDLED;
> +}

...

> +       case IIO_CHAN_INFO_SCALE:
> +               *val = isl76683_lux_ranges_available[chip->luxrange];
> +               return IIO_VAL_INT;
> +       }
> +
> +       return -EINVAL;

default case?

...

> +       switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               mutex_lock(&chip->lock);
> +               chip->luxrange = find_closest(val,
> +                       isl76683_lux_ranges_available,
> +                       ARRAY_SIZE(isl76683_lux_ranges_available));
> +               ret = isl76683_set_config(chip);
> +               mutex_unlock(&chip->lock);
> +               return ret;
> +       }
> +
> +       return -EINVAL;

Ditto.

...

> +static IIO_CONST_ATTR(in_illuminance_scale_available,
> +               ISL76683_LUXRANGE_STR);

One line?

...

> +static int isl76683_set_trigger_state(struct iio_trigger *trig, bool enable)
> +{
> +       struct isl76683_chip *chip = iio_trigger_get_drvdata(trig);
> +       int ret;

> +       if (enable) {
> +               chip->trig_enabled = true;
> +               ret = isl76683_start_measurement(chip);
> +               if (ret < 0)
> +                       return ret;
> +       } else
> +               chip->trig_enabled = false;

    chip->trig_enabled = enable;
    if (chip->trig_enabled) {
        ...
    }

> +       return 0;
> +}

...

> +       chip->rmp = devm_regmap_init_i2c(client, &isl76683_regmap_config);
> +       if (IS_ERR(chip->rmp)) {
> +               ret = PTR_ERR(chip->rmp);

> +               dev_err(dev, "%s: Error %d initializing regmap\n",
> +                       __func__, ret);

Drop __func__.

> +               return ret;
> +       }

...

> +       chip->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +                       indio_dev->name, indio_dev->id);

One line?

> +       if (!chip->trig)
> +               return -ENOMEM;

...

> +       ret = devm_request_irq(dev, client->irq,
> +                       isl76683_interrupt_handler,
> +                       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,

One short for non-threaded IRQ?! Perhaps you wanted a threaded IRQ handler?

> +                       "isl76683_event", indio_dev);
> +       if (ret) {
> +               dev_err(dev, "irq request error\n");
> +               return ret;
> +       }

...

> +       ret = devm_iio_device_register(dev, indio_dev);
> +       if (ret) {
> +               dev_err(dev, "%s(): iio registration failed with error %d\n",
> +                       __func__, ret);

Drop __func__.

> +       }

...

> +static int __maybe_unused isl76683_suspend(struct device *dev)
> +{

> +       struct isl76683_chip *chip =
> +               iio_priv(i2c_get_clientdata(to_i2c_client(dev)));

One line.

> +}

...

> +static int __maybe_unused isl76683_resume(struct device *dev)
> +{
> +       struct isl76683_chip *chip =
> +               iio_priv(i2c_get_clientdata(to_i2c_client(dev)));

Ditto.
In both cases use dev_get_drvdata() IIUC.

> +}

> +

Useless blank line.

> +static SIMPLE_DEV_PM_OPS(isl76683_pm_ops, isl76683_suspend, isl76683_resume);

--
With Best Regards,
Andy Shevchenko
