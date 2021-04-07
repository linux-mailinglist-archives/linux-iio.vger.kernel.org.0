Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7235B356612
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 10:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhDGIIy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 04:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhDGIIv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 04:08:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D12C06174A;
        Wed,  7 Apr 2021 01:08:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d5-20020a17090a2a45b029014d934553c4so141481pjg.1;
        Wed, 07 Apr 2021 01:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BMoc5hPkxy7fsOAEMQeYNlaXoRBjBfIzaTXjUbnT8o=;
        b=qRyTQmvY0x/57FKRL+UN0fdeFa03LemGalP0S7OczVk2ecOK4na/u8S6vy1mByfqhj
         w3usCjh8wnGxFBsbiF9vyt06jY4OjmHgAqcBox0le+i3JU2haLaMmWRU4kYaJzM/NzXV
         acVTxRpEW+AikREeXSh3o+zcaDmtC/TnbPree2gwROQikIj9Jd5AKdqWgBPVQwpzy4ne
         2R89IsHH5ysh7nPhjGXGpNnyjmmoKL+rIUCd1Xfiojow9Wn641W4WlbGrtomx56qEvsW
         ttnAEMbMLqpatkUBhHq1jLABxBTnWhSJ8+iX6ELAOVuBKiNxqJZFf8hAvrOgtAvZgY3H
         I+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BMoc5hPkxy7fsOAEMQeYNlaXoRBjBfIzaTXjUbnT8o=;
        b=VMBB2NhYlQjGJboZEDTTkO7IBgHTTXqF1eXokMNW2vBTKO+S4pAOodiScMxBhgx6Sn
         tCRK0XqroVovsK330J9V2La558hqz0j1OGqEmw8oudlajnme4ObpcvEFDE3qI+RSmSU+
         QkVCI/3u5RJ6ZPX1mPtR4vsuQFtBcwX4TjRKEZX4H3Ol8RDhJzGTuoltOx/Z/6AXzvsf
         AuPPIZZP/bZJJqq80pmJBhVJhVV79URO2FWXSQ3YLuSpzkxXWlTvnYgtQDmMrR/NjKNf
         MI2Y5+nPzg3CitdYOFB7LJX+5O1zzoWjxtksCMSXGt735SbA2WfPylXQ4qk1wIl8b/GV
         L01w==
X-Gm-Message-State: AOAM531XNncS/82QcFoRaFpScXim+YzhbyiAbWB98dH2gL7FTt0fXZlO
        i4ega1sZrZ2BDfNW6Mz6BU6aDyQ238g9S/FSrlU=
X-Google-Smtp-Source: ABdhPJwZabodD5+Ekzs9L1KoCtRQBLD7boir9a/vwp3qH6lpRD+Lm6wKXGBf8RQAHz0GzftyEzxQgcoovK6PJDOIAkk=
X-Received: by 2002:a17:90b:1e0a:: with SMTP id pg10mr1514532pjb.129.1617782921358;
 Wed, 07 Apr 2021 01:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210402004548.20813-1-joe.g.sandom@gmail.com>
In-Reply-To: <20210402004548.20813-1-joe.g.sandom@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Apr 2021 11:08:24 +0300
Message-ID: <CAHp75VdCmc6FST2hYyWR6eLSL2W03MtSBhwLANr1vz3=xJUTcw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] Added AMS tsl2591 driver implementation
To:     Joe Sandom <joe.g.sandom@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 2, 2021 at 3:45 AM Joe Sandom <joe.g.sandom@gmail.com> wrote:
>
> Driver implementation for AMS/TAOS tsl2591 ambient light sensor.
>
> This driver supports configuration via device tree and sysfs.
> Supported channels for raw infrared light intensity,
> raw combined light intensity and illuminance in lux.
> The driver additionally supports iio events on lower and
> upper thresholds.
>
> This is a very-high sensitivity light-to-digital converter that
> transforms light intensity into a digital signal.

> Datasheet: https://ams.com/tsl25911#tab/documents
>

Shouldn't be blank lines in the tag block.

> Signed-off-by: Joe Sandom <joe.g.sandom@gmail.com>

...

> +#include <asm/unaligned.h>

Better to put this in a separate group after linux/* , but before linux/iio*

> +#include <linux/bitfield.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

...

> +/* ADC integration time, field value to time in ms*/

Missed space.

> +#define TSL2591_FVAL_TO_ATIME(x) (((x) + 1) * 100)
> +/* ADC integration time, time in ms to field value */
> +#define TSL2591_ATIME_TO_FVAL(x) (((x) / 100) - 1)

Taking comments into consideration I would simply rename

ATIME -> MSEC

...

> +#define TSL2591_CTRL_ALS_INTEGRATION_100MS  0x00
> +#define TSL2591_CTRL_ALS_INTEGRATION_200MS  0x01
> +#define TSL2591_CTRL_ALS_INTEGRATION_300MS  0x02
> +#define TSL2591_CTRL_ALS_INTEGRATION_400MS  0x03
> +#define TSL2591_CTRL_ALS_INTEGRATION_500MS  0x04
> +#define TSL2591_CTRL_ALS_INTEGRATION_600MS  0x05
> +#define TSL2591_CTRL_ALS_LOW_GAIN           0x00
> +#define TSL2591_CTRL_ALS_MED_GAIN           0x10
> +#define TSL2591_CTRL_ALS_HIGH_GAIN          0x20
> +#define TSL2591_CTRL_ALS_MAX_GAIN           0x30
> +#define TSL2591_CTRL_SYS_RESET              0x80

I would do it differently, since they are bit fields, e.g. for GAIN
(0 << 4)
(1 << 4)
(2 << 4)
(3 << 4)

and so on for the rest.

But there are pros and cons for yours and proposed variants, so I
leave it for you and maintainers.

...

> +#define TSL2591_PRST_ALS_INT_CYCLE_MAX      TSL2591_PRST_ALS_INT_CYCLE_60

I guess it's a bitfield, so instead of using value from the list, show
explicitly the size in bits of the field

(BIT(x) - 1), or here looks like (BIT(4) - 1)

...

> +/* TSL2591 status register masks */
> +#define TSL2591_STS_ALS_VALID_MASK   BIT(0)
> +#define TSL2591_STS_ALS_INT_MASK     0x10
> +#define TSL2591_STS_NPERS_INT_MASK   0x20
> +#define TSL2591_STS_VAL_HIGH_MASK    0x01

Why inconsistent ? Use BIT() for all here, or switch to left shifts or
plain numbers.

...

> +/*
> + * LUX calculations;
> + * AGAIN values from Adafruits TSL2591 Arduino library

Adafruit's

> + * https://github.com/adafruit/Adafruit_TSL2591_Library
> + */

...

> +static int tsl2591_set_als_lower_threshold(struct tsl2591_chip *chip,
> +                                          u16 als_lower_threshold);
> +static int tsl2591_set_als_upper_threshold(struct tsl2591_chip *chip,
> +                                          u16 als_upper_threshold);

Why forward declarations? Do you have recursion in use?
Otherwise, rearrange functions to be ordered and drop these.

...

> +static int tsl2591_check_als_valid(struct i2c_client *client)
> +{
> +       int ret;
> +
> +       ret = i2c_smbus_read_byte_data(client,
> +                                      TSL2591_CMD_NOP | TSL2591_STATUS);

One line?

> +       if (ret < 0) {
> +               dev_err(&client->dev, "Failed to read register\n");
> +               return -EINVAL;
> +       }

> +       ret = FIELD_GET(TSL2591_STS_ALS_VALID_MASK, ret);
> +
> +       return ret;

return FIELD_GET(...);

> +}

...

> +       struct tsl2591_chip *chip = iio_priv(indio_dev);
> +       struct tsl2591_als_settings *settings = &chip->als_settings;
> +       struct i2c_client *client = chip->client;

> +

Extra unneeded blank line.

> +       u8 als_data[TSL2591_NUM_DATA_REGISTERS];
> +       int counts_per_lux, int_time_fval, gain_multi, lux;
> +       u16 als_ch0, als_ch1;
> +       int ret;

...

> +       struct tsl2591_als_settings als_settings = chip->als_settings;
> +       struct i2c_client *client = chip->client;

> +

Ditto.

> +       u16 als_upper_threshold;
> +       u8 als_lower_l;
> +       u8 als_lower_h;
> +       int ret;

...

> +       struct tsl2591_als_settings als_settings = chip->als_settings;
> +       struct i2c_client *client = chip->client;

> +

Ditto.

> +       u16 als_lower_threshold;
> +       u8 als_upper_l;
> +       u8 als_upper_h;
> +       int ret;

...

> +static ssize_t tsl2591_in_illuminance_period_available_show(struct device *dev,
> +                                                           struct device_attribute *attr,
> +                                                           char *buf)
> +{
> +       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +       struct tsl2591_chip *chip = iio_priv(indio_dev);

> +       return snprintf(buf, PAGE_SIZE, "%s\n",
> +                      tsl2591_als_period_list[chip->als_settings.als_int_time]);

sysfs_emit()

> +}

> +

Unneeded blank line.

> +static IIO_DEVICE_ATTR_RO(tsl2591_in_illuminance_period_available, 0);

...

> +static int tsl2591_read_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan,
> +                           int *val, int *val2, long mask)
> +{
> +       struct tsl2591_chip *chip = iio_priv(indio_dev);
> +       struct i2c_client *client = chip->client;
> +       int ret;
> +
> +       pm_runtime_get_sync(&client->dev);
> +
> +       mutex_lock(&chip->als_mutex);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               if (chan->type != IIO_INTENSITY) {
> +                       ret = -EINVAL;
> +                       break;
> +               }
> +
> +               ret = tsl2591_read_channel_data(indio_dev, chan, val, val2);
> +               if (ret < 0)
> +                       break;
> +
> +               ret = IIO_VAL_INT;
> +               break;
> +       case IIO_CHAN_INFO_PROCESSED:
> +               if (chan->type != IIO_LIGHT) {
> +                       ret = -EINVAL;
> +                       break;
> +               }
> +
> +               ret = tsl2591_read_channel_data(indio_dev, chan, val, val2);
> +               if (ret < 0)
> +                       break;
> +
> +               ret = IIO_VAL_INT_PLUS_MICRO;
> +               break;
> +       case IIO_CHAN_INFO_INT_TIME:
> +               if (chan->type != IIO_INTENSITY) {
> +                       ret = -EINVAL;
> +                       break;
> +               }
> +
> +               *val = TSL2591_FVAL_TO_ATIME(chip->als_settings.als_int_time);
> +               ret = IIO_VAL_INT;
> +               break;
> +       case IIO_CHAN_INFO_CALIBSCALE:
> +               if (chan->type != IIO_INTENSITY) {
> +                       ret = -EINVAL;
> +                       break;
> +               }
> +
> +               *val = tsl2591_gain_to_multiplier(chip->als_settings.als_gain);
> +               ret = IIO_VAL_INT;
> +               break;
> +       default:

> +               ret = -EINVAL;

Missed break; statement.

> +       }
> +
> +       mutex_unlock(&chip->als_mutex);
> +
> +       pm_runtime_mark_last_busy(&client->dev);
> +       pm_runtime_put_autosuspend(&client->dev);
> +
> +       return ret;
> +}

...

> +err:

err_unlock:

> +       mutex_unlock(&chip->als_mutex);
> +       return ret;
> +}

It's interesting why in one case full of break statements and another
is goto style. Can you be consistent, please?

...

> +err:
> +       mutex_unlock(&chip->als_mutex);
> +       return ret;
> +}

Ditto.

...

> +err:
> +       mutex_unlock(&chip->als_mutex);
> +       return ret;
> +}

Ditto.

...

> +       if (!i2c_check_functionality(client->adapter,
> +                                    I2C_FUNC_SMBUS_BYTE_DATA)) {

One line?

> +               dev_err(&client->dev,
> +                       "I2C smbus byte data functionality is not supported\n");
> +               return -EOPNOTSUPP;
> +       }

...

> +       /*
> +        * Add chip off to automatically managed path and disable runtime
> +        * power management. This ensures that the chip power management
> +        * is handled correctly on driver remove. tsl2591_chip_off must be

tsl2591_chip_off()

> +        * added to the managed path after pm runtime is enabled and before
> +        * any error exit paths are met to ensure we're not left in a state
> +        * of pm runtime not being disabled properly.
> +        */

--
With Best Regards,
Andy Shevchenko
