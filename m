Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A045C3F2DF2
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 16:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbhHTOWu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 10:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240855AbhHTOWt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 10:22:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D430CC061575
        for <linux-iio@vger.kernel.org>; Fri, 20 Aug 2021 07:22:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso9271440wmj.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Aug 2021 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YX9kwvHqDFy0hnVHGun1TmEBCC9n/3N+wVbcPB28fJU=;
        b=gKuPjJw1lrNrGNK+b0bhRxovCA5eH3p7jWVXR9wOUoLQLLLZHf6qG/JTdjOP3aqjlX
         fOn5LMjztwBHVzwTV846lCSfrV6fBXxMftIn3yBFlPK0poqVFm7XzXlJ2AUIWRiPdDMo
         4ZpAQT37sbjB1JtdxIhn/jgpf4ZOM7l0K43H+ihwXHEW131DLs4a5b42uq9XFXlu0ghM
         izWOq0UluYGxEGPuH/CxkA24+r8PbZbrWQvIpEIAR0HMb93QfhHu5kAwgWTgaGVn5L+D
         SsWAVgJ/mQFqkEYrNZ4Dh/KhTx6wlct/lanp9HjHizSqwt+T4nNUatdrta/OBZzZudyu
         dLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YX9kwvHqDFy0hnVHGun1TmEBCC9n/3N+wVbcPB28fJU=;
        b=BKIjs21RfByh3qrR+PuZ4Fu0aAommwfMC85gKF8i5FwGfub5DYddM83V7/OxfILCrD
         htslYFx4TxRMclM4qKxqtkYB3CSb6cUFkZ6GM31tBFn9Jfcc459/7ZfJYL+o5nUEeDui
         kc/dkJcKDiAY6vu1BNUav7GMEZ46oRRKmmDb48uu2TSK6iUz0j/+JzZCNZ2cZA13KN04
         OMRns7Pg/y1nb0s7bk8kBICWyYuno3vOoKDfmGIC2u9CCaq2sJoIZQoDDj4BR9nT8eCP
         wPbFt6uMch9pvDOJuWkKj/bD44RR9sOTzO9fScvCX24z3FqX+TeXymFXPN65CHUpCNdX
         hqTA==
X-Gm-Message-State: AOAM531cU/T9cuKMQZ6F6H2UZzWZhYgGcsHmEBoppzkhKkjC+qX7Gt5D
        SinLT4cju2zRNhRKvmAH6A6WXlcPfyJLzOi+oFQ=
X-Google-Smtp-Source: ABdhPJwJc58V9KiDkXorCYm4SpEpEWdzvYCg1TlZPa+2ZtHMYirp+kweX+bi39BgnvCcmncbNwcj0EoAt0cXIlX7Gjs=
X-Received: by 2002:a7b:c014:: with SMTP id c20mr4235648wmb.81.1629469330331;
 Fri, 20 Aug 2021 07:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210820133821.159239-1-jacopo@jmondi.org> <20210820133821.159239-3-jacopo@jmondi.org>
In-Reply-To: <20210820133821.159239-3-jacopo@jmondi.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Aug 2021 17:21:30 +0300
Message-ID: <CAHp75Vej52puQ6jTvxoMDnfJc82Sg1u53Y=2_qquvkZf8Khpxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: chemical: Add Sensteair Sunrise 006-0-007 driver
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 20, 2021 at 4:38 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
>
> Add support for the Senseair Sunrise 006-0-0007 driver through the
> IIO subsystem.

...

> +config SENSEAIR_SUNRISE_CO2
> +       tristate "Senseair Sunrise 006-0-0007 CO2 sensor"

> +       depends on I2C

Actually

select REGMAP_I2C

...

> + * List of features not yet supported by the driver:
> + * - support for controllable EN pin

To avoid tautology

* - controllable EN pin


> + * - support for single-shot operations using the nDRY pin.

Ditto.

* - single-shot operations using the nDRY pin.

> + * - ABC/target calibration

...

> +#include <linux/i2c.h>

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Can you move this as a separate group...

> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/sysfs.h>

...here ?

...

> +#define SUNRISE_CALIBRATION_TIMEOUT_US         30000000

30 * USEC_PER_SEC ?

...

> +static void sunrise_wakeup(struct sunrise_dev *sunrise)
> +{
> +       struct i2c_client *client = sunrise->client;
> +
> +       /*
> +        * Wake up sensor by sending sensor address: START, sensor address,
> +        * STOP. Sensor will not ACK this byte.
> +        *
> +        * The chip returns in low power state after 15msec without
> +        * communications or after a complete read/write sequence.
> +        */

I'm wondering if there is a better way to perform this.

> +       i2c_smbus_xfer(client->adapter, client->addr, I2C_M_IGNORE_NAK,
> +                      I2C_SMBUS_WRITE, 0, I2C_SMBUS_QUICK, NULL);
> +}

...

> +               dev_err(sunrise->dev, "Read word failed: reg 0x%2x (%d)\n",
> +                       reg, ret);

One line?

...

> +               dev_err(sunrise->dev, "Write byte failed: reg 0x%2x (%d)\n",
> +                       reg, ret);

One line?

...

> +               dev_err(sunrise->dev, "Write word failed: reg 0x%2x (%d)\n",
> +                       reg, ret);

One line?

...

> +       /* Write calibration command and poll the calibration status bit. */

Write a calibration

...

> +static ssize_t sunrise_calibration_write(struct iio_dev *iiodev,
> +                                        uintptr_t private,
> +                                        const struct iio_chan_spec *chan,
> +                                        const char *buf, size_t len)
> +{
> +       struct sunrise_dev *sunrise = iio_priv(iiodev);
> +       bool calibrate;
> +       int ret;
> +
> +       ret = kstrtobool(buf, &calibrate);
> +       if (ret)

> +               return -EINVAL;

Shadowed return code.

> +       if (!calibrate)
> +               return 0;
> +
> +       ret = sunrise_calibrate(sunrise);
> +
> +       return ret ?: len;

In this case

  if (ret)
    return ret;

return len;

will look more natural.

> +}

...

> +static ssize_t sunrise_error_status_read(struct iio_dev *iiodev,
> +                                        uintptr_t private,
> +                                        const struct iio_chan_spec *chan,
> +                                        char *buf)
> +{
> +       struct sunrise_dev *sunrise = iio_priv(iiodev);
> +       ssize_t len = 0;
> +       u16 value;
> +       int ret;
> +       u8 i;
> +
> +       ret = sunrise_read_word(sunrise, SUNRISE_ERROR_STATUS_REG, &value);
> +       if (ret)
> +               return -EINVAL;

> +       for (i = 0; i < ARRAY_SIZE(error_codes); ++i) {
> +               if (!(value & BIT(error_codes[i])))
> +                       continue;

for_each_set_bit()

> +               len += sysfs_emit_at(buf, len, "%s ",
> +                                    sunrise_error_statuses[i]);

One line?

> +       }
> +
> +       if (len)
> +               buf[len - 1] = '\n';
> +
> +       return len;
> +}

...

> +static const struct iio_chan_spec_ext_info sunrise_concentration_ext_info[] = {
> +       /* Calibration modes and calibration trigger. */
> +       {
> +               .name = "calibration",
> +               .write = sunrise_calibration_write,
> +               .shared = IIO_SEPARATE,
> +       },

> +       IIO_ENUM("calibration_mode", IIO_SEPARATE,
> +                &sunrise_calibration_modes_enum),

One line?

> +       IIO_ENUM_AVAILABLE("calibration_mode",
> +                          &sunrise_calibration_modes_enum),

One line?

> +       /* Error statuses. */
> +       {
> +               .name = "error_status",
> +               .read = sunrise_error_status_read,
> +               .shared = IIO_SEPARATE,
> +       },
> +       IIO_ENUM_AVAILABLE("error_status", &sunrise_error_statuses_enum),

> +       {},

No comma for terminator entries.

> +};

...

> +static int sunrise_read_raw(struct iio_dev *iio_dev,
> +                           const struct iio_chan_spec *chan,
> +                           int *val, int *val2, long mask)
> +{
> +       struct sunrise_dev *sunrise = iio_priv(iio_dev);
> +       u16 value;
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:

> +

Redundant blank line.

> +               mutex_lock(&sunrise->lock);
> +
> +               switch (chan->type) {
> +               case IIO_CONCENTRATION: {
> +                       ret = sunrise_read_word(sunrise,
> +                                               SUNRISE_CO2_FILTERED_COMP_REG,
> +                                               &value);
> +                       *val = value;
> +                       mutex_unlock(&sunrise->lock);
> +
> +                       return ret ?: IIO_VAL_INT;
> +               }

You don't need {} anymore.

> +               case IIO_TEMP: {
> +                       ret = sunrise_read_word(sunrise,
> +                                               SUNRISE_CHIP_TEMPERATURE_REG,
> +                                               &value);
> +                       *val = value;
> +                       mutex_unlock(&sunrise->lock);
> +
> +                       return ret ?: IIO_VAL_INT;
> +               }

Ditto.

> +               default:
> +                       mutex_unlock(&sunrise->lock);
> +                       return -EINVAL;
> +               }
> +
> +       case IIO_CHAN_INFO_SCALE:
> +               /* Chip temperature scale = 1/100 */
> +               *val = 1;
> +               *val2 = 100;
> +               return IIO_VAL_FRACTIONAL;
> +
> +       default:
> +               return -EINVAL;
> +       }

> +
> +       return 0;

Dead code?

> +}


-- 
With Best Regards,
Andy Shevchenko
