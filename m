Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC48362FCA
	for <lists+linux-iio@lfdr.de>; Sat, 17 Apr 2021 14:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhDQMSk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Apr 2021 08:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbhDQMSk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Apr 2021 08:18:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B959C061574;
        Sat, 17 Apr 2021 05:18:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n10so4193590plc.0;
        Sat, 17 Apr 2021 05:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GTc6b+3SZigaKZgqu3pRLJMVceZ4b8Dh1BP4K52myOg=;
        b=MSfOt300sEUYN8HIQurzQggF+GBpp7JAr0sOhVQ7FJuXo6A6jpKJ4aIiBFEvB3gLEg
         DdRowJXXm33m5yV7x7CDRvXoQ947RkvkxGPrKEUWExlHQwotnxbFi+wei3OaR1VIX5Rc
         t+d0zMKu3FlmApxsMKcElPklBqGBFb8oj/E+1HM2JwRl3L189ULpcH2rlZ+/nnq9w8ra
         YDGS6+aaBLIBwsqbxvEvEPJ7dcROyPYksAl3zTleBkI4N3dfAp2d5f2X0xOaW5oX6WgO
         W2Bm/XOGOTukmAoH8cTrS7xCyq+ISRJI31rZyuvJLbJxryXMNzTNTQAiqnvrtArDxrJ0
         Q/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTc6b+3SZigaKZgqu3pRLJMVceZ4b8Dh1BP4K52myOg=;
        b=tr0Cy4H0mMh7/COWPjaraZVVkyUjuWEgprqEt0/GpVdv3oBE8qMwgUf3ooclzxQ0jF
         5c6t9bw9YfMFnYqgmA6OZYZnp7ooYqkhffzaz1fZDAxcfsupF+9rZ5XtB12WsdUsugbM
         YmQb6LOT2I7WdIDq3KbTOjXNkaoVtXDbdHVokVzw0AxLv3x2NGS+4QX/NEtSc2ZOm1PP
         Zv+91yGiGsRdumQyazoP19fBNUq4GmSrJAf8Z9oXs/0dTsLyNaLF6zDlXYWjQLeiW2CB
         /Qzsp7W/eTFJN73vj96VptzvQD/LKP8L+MpxNo/YvqNQVrnAsmXxKA/G+VmPVD9q4eiW
         iLsQ==
X-Gm-Message-State: AOAM5303HrAMF1OiYE3+uZdhdSpcIxmAUXlESZkwYGlN/ddN2Cook+iU
        JXv1fYgJj/yOUxnCexubBsBPudTxVRTwz0aOh1GyNtYOtplBrw==
X-Google-Smtp-Source: ABdhPJxsfFkM1m+6OfvdxGHojNVD4eS7iXL5jF9RoVdGgZw8Y6fbU1ELEea8jWugqlG9tA5wb1r6X/ab3/d+3BJtBWo=
X-Received: by 2002:a17:902:264:b029:eb:3d3a:a09c with SMTP id
 91-20020a1709020264b02900eb3d3aa09cmr14158969plc.0.1618661893636; Sat, 17 Apr
 2021 05:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210416093039.1424135-1-sean@geanix.com>
In-Reply-To: <20210416093039.1424135-1-sean@geanix.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 17 Apr 2021 15:17:57 +0300
Message-ID: <CAHp75VfAuXztsJE2qq_TFDovptPnaYfioLXuL5bVz2T9B0f1TA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?B?TnVubyBTw6E=?= <Nuno.Sa@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 16, 2021 at 1:28 PM Sean Nyekjaer <sean@geanix.com> wrote:
>
> Add basic support for NXP FXLS8962AF/FXLS8964AF Automotive
> accelerometers.
> It will allow setting up scale/gain and reading x,y,z
> axis.

Do you have a link to the data sheet? Can you add it as Datasheet: tag?

> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

...

> +config FXLS8962AF
> +       tristate "NXP FXLS8962AF and similar Accelerometers Driver"

I guess this can be hidden.

> +       select REGMAP
> +       help
> +         Say yes here to build support for the NXP 3-axis automotive
> +         accelerometer FXLS8962AF/FXLS8964AF.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called fxls8962af.
> +
> +config FXLS8962AF_I2C
> +       tristate "NXP FXLS8962AF I2C transport"

> +       depends on FXLS8962AF

Why not select?

> +       depends on I2C

> +       default FXLS8962AF

And drop this.

> +       select REGMAP_I2C
> +       help
> +         Say yes here to enable the NXP FXLS8962AF accelerometer
> +         I2C transport channel.

Missed module name.

> +config FXLS8962AF_SPI
> +       tristate "NXP FXLS8962AF SPI transport"
> +       depends on FXLS8962AF
> +       depends on SPI
> +       default FXLS8962AF
> +       select REGMAP_SPI
> +       help
> +         Say yes here to enable the NXP FXLS8962AF accelerometer
> +         SPI transport channel.

Three comments as per I2C case.

...

> +/*
> + * Copyright 2021 Connected Cars A/S
> + */

One line

...

> +#include <linux/module.h>


Missed bits.h

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Can you split it to a separate group to go...

> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>

...here?

> +#include "fxls8962af.h"

...

> +#define FXLS8962AF_FSR_MASK                    (BIT(2) | BIT(1))

GENMASK() ?

...

> +#define FXLS8962AF_TEMP_CENTER_VAL             25

Is it decimal one or bit based? I mean the maximum is 50 or is it a
bit field which represents raw value?

...

> +struct fxls8962af_chip_info {
> +       u8 chip_id;

You may save some memory if you move this at the end of the structure.

> +       const char *name;
> +       const struct iio_chan_spec *channels;
> +       int num_channels;
> +};

...

> +struct fxls8962af_data {
> +       struct regmap *regmap;
> +       struct mutex lock;

So, you are  using the regmap lock, what is this for? The golden rule
one _must_ describe locks (their purposes).

> +       const struct fxls8962af_chip_info *chip_info;
> +       struct regulator *vdd_reg;
> +       struct iio_mount_matrix orientation;
> +};

...

> +static int fxls8962af_drdy(struct fxls8962af_data *data)
> +{
> +       int tries = 150, ret;
> +       unsigned int reg;
> +       struct device *dev = regmap_get_device(data->regmap);

Try to keep reversed xmas tree order in definition block(s).

> +       while (tries-- > 0) {
> +               ret = regmap_read(data->regmap, FXLS8962AF_INT_STATUS, &reg);
> +               if (ret < 0)
> +                       return ret;
> +
> +               if ((reg & FXLS8962AF_INT_STATUS_SRC_DRDY) ==
> +                   FXLS8962AF_INT_STATUS_SRC_DRDY)
> +                       return 0;
> +
> +               msleep(20);
> +       }

Entire loop is repetition of regmap_read_poll_timeout().

> +       dev_err(dev, "data not ready\n");
> +
> +       return -EIO;
> +}
> +
> +static int fxls8962af_set_power_state(struct fxls8962af_data *data, bool on)
> +{

> +#ifdef CONFIG_PM

Why?

> +       struct device *dev = regmap_get_device(data->regmap);
> +       int ret;
> +
> +       if (on) {
> +               ret = pm_runtime_get_sync(dev);
> +       } else {
> +               pm_runtime_mark_last_busy(dev);
> +               ret = pm_runtime_put_autosuspend(dev);
> +       }
> +
> +       if (ret < 0) {
> +               dev_err(dev, "failed to change power state to %d\n", on);
> +               if (on)
> +                       pm_runtime_put_noidle(dev);
> +
> +               return ret;
> +       }

Untangle this. You may do on and off cases separately for better understanding.

> +#endif
> +
> +       return 0;
> +}

...

> +       if (ret < 0) {
> +               mutex_unlock(&data->lock);
> +               return ret;
> +       }

goto variant in all similar places will save you a lot of lines

goto out_unlock;

...

out_unlock: // or err_unlock if it's only for error path.
  mutex_unlock(...);
  return ret;

...

> +       *val = sign_extend32(le16_to_cpu(raw_val),
> +                            chan->scan_type.realbits - 1);

One line?

...

> +       mutex_lock(&data->lock);
> +
> +       is_active = fxls8962af_is_active(data);
> +       if (is_active < 0) {
> +               ret = is_active;
> +               goto fail;
> +       }

Why not

ret = ...;
if (ret < 0)
  goto fail;

... = ret;

?

Also note inconsistency here with goto style and there where you open
coded error paths.

...

> + fail:

err_unlock:

Labels should be descriptive.

> +       mutex_unlock(&data->lock);

...

> +               switch (chan->type) {
> +               case IIO_TEMP:
> +                       ret = fxls8962af_get_temp(data, val);
> +                       break;
> +               case IIO_ACCEL:
> +                       ret = fxls8962af_get_axis(data, chan, val);
> +                       break;
> +               default:
> +                       ret = -EINVAL;

break is missed.

> +               }

...

> +       case IIO_CHAN_INFO_OFFSET:
> +               if (chan->type == IIO_TEMP) {
> +                       *val = FXLS8962AF_TEMP_CENTER_VAL;
> +                       return IIO_VAL_INT;


> +               } else {

Redundant 'else'

> +                       return -EINVAL;
> +               }

You may rather refactor this to be like

if (type != ...)
  return -EINVAL;

...


> +               ret = fxls8962af_read_full_scale(data, val2);
> +               return ret;

Why not return directly?

> +       default:
> +               ret = -EINVAL;
> +               break;

Ditto.

> +       }

> +       return -EINVAL;

Isn't it a dead code?

...

> +static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
> +       [fxls8962af] = {
> +               .chip_id = FXLS8962AF_DEVICE_ID,
> +               .name = "fxls8962af",
> +               .channels = fxls8962af_channels,
> +               .num_channels = ARRAY_SIZE(fxls8962af_channels),
> +       },
> +       [fxls8964af] = {
> +               .chip_id = FXLS8964AF_DEVICE_ID,
> +               .name = "fxls8964af",
> +               .channels = fxls8962af_channels,
> +               .num_channels = ARRAY_SIZE(fxls8962af_channels),


> +       }

Leave the comma here as well.

> +};

...

> +       for (i = 0; i < 10; i++) {
> +               usleep_range(100, 200);
> +               ret = regmap_read(data->regmap, FXLS8962AF_SENS_CONFIG1, &reg);
> +               if (ret == -EIO)
> +                       continue;       /* I2C comm reset */
> +               if (ret < 0)
> +                       return ret;
> +               if (!(reg & FXLS8962AF_SENS_CONFIG1_RST))
> +                       return 0;
> +       }
> +
> +       return -ETIMEDOUT;

Consider to adapt to regmap_read_poll_timeout().

> +}

...

> +       ret = devm_add_action_or_reset(dev, fxls8962af_pm_disable, dev);
> +       if (ret)
> +               return ret;
> +
> +

Too many blank lines.

> +       return devm_iio_device_register(dev, indio_dev);
> +

Ditto.

...

> +#ifdef CONFIG_PM

No, please use __maybe_unused attribute.

> +static int fxls8962af_runtime_suspend(struct device *dev)
> +{
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct fxls8962af_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       mutex_lock(&data->lock);
> +       ret = fxls8962af_standby(data);
> +       mutex_unlock(&data->lock);
> +       if (ret < 0) {
> +               dev_err(dev, "powering off device failed\n");

> +               return -EAGAIN;

Why error code shadowing?

> +       }
> +
> +       return 0;
> +}
> +
> +static int fxls8962af_runtime_resume(struct device *dev)
> +{
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct fxls8962af_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       ret = fxls8962af_active(data);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +#endif

...

> +/*
> + * Copyright 2021 Connected Cars A/S
> + */

One line.

...

> +#include <linux/device.h>

Shouldn't this be dev_printk.h?

> +#include <linux/mod_devicetable.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>

...

> +/*
> + * Copyright 2021 Connected Cars A/S
> + */

One line?

...

> +#include <linux/kernel.h>

What for?

...

> +static const struct of_device_id fxls8962af_spi_of_match[] = {
> +       {.compatible = "nxp,fxls8962af"},
> +       {.compatible = "nxp,fxls8964af"},

> +       {},

Comma is not needed for terminator lines.

> +};

...

> +static const struct spi_device_id fxls8962af_spi_id_table[] = {
> +       {"fxls8962af", fxls8962af},
> +       {"fxls8964af", fxls8964af},
> +       {},

Ditto.

> +};

...

> +/*
> + * Copyright 2021 Connected Cars A/S
> + */

One line.

...

> +struct regmap;

struct device;

is missed.

-- 
With Best Regards,
Andy Shevchenko
