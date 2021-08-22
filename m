Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D5C3F4165
	for <lists+linux-iio@lfdr.de>; Sun, 22 Aug 2021 22:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhHVUKZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Aug 2021 16:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhHVUKZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Aug 2021 16:10:25 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B3DC061575
        for <linux-iio@vger.kernel.org>; Sun, 22 Aug 2021 13:09:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oc2-20020a17090b1c0200b00179e56772d6so7381856pjb.4
        for <linux-iio@vger.kernel.org>; Sun, 22 Aug 2021 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3HZcs9opVXbQisP2uOA3EtvtjuPCwD4ihwTbkN/I22I=;
        b=cG07a01LBqNfdJWe9QZ9ys0a84A9hNJAd76HHY7fi0DLUdQsZ+w6P4ajx7wxEtJPmP
         8/idWyNWBEaxTQvjo32YHtsUttUsNzReUZ/v0lCX6TbZgyCNtR/4O6naOqiSPFvC95Tz
         yGfLXFp0KakhKc7bUNJe7o4OnHVj2xjuC212iQ2hdditP17OhQdK7DslDHRuV9zN2NPi
         6mkjpMC4Wv1n9NWJrVR5BQsQJ+nHL3GpFBm+SbyJydCSi84XS1EF5x4nPdUj11BXBawQ
         rnP6RzY4uQJ5f7JLLrvMDdql5Hra2fdFswtzR0tFWkjVFENCEAkjDBqzhXMEuIIsc47F
         zbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3HZcs9opVXbQisP2uOA3EtvtjuPCwD4ihwTbkN/I22I=;
        b=qyfIkq3xFEzqTlQh+jZ89711NOvHW3vvgGX+UEnDLLJJBF8SRdJuAHmOXlkiYCfi7k
         FXq8hJftx9pprq5r9KlQCrQsazrbqs6yY/UGh1kdNuhq1jxLZQ0I7LhS2IiojvyUukMx
         xeFPoW8Pt3N4ffChzx4gangLFO58CLlr9La941Q261mtSiv0rQUfn3ZOlVHeO2X5xo7h
         O4N/yKwerhyR4Nfcdl31qE6IiqIbDUY+ceuUCxOBIDt7zJPIrMD6/31Lioxp7STvcPOq
         9ICXuOlrnA51IFW5bc3E4/V5VqULbHGpQhHaqcl5iMd99tLz/u5mxirwikxFBbzA8UQY
         ksSg==
X-Gm-Message-State: AOAM5307f6cWexb8sZfNdJaSKkmi28SHG+/2+4/g2/ZHWka+TtZkbtgo
        9KjQMMGPbzc8Oqa92yPeisJhk9BwxOz7VyTxTBk=
X-Google-Smtp-Source: ABdhPJymUq4rv//FG3clT1oV38d7rT7GJlN3xnE/r90qgBfiNiEtk7YWv+o1Npl0WvksLCrWMbYIsyaL+fpm512euzs=
X-Received: by 2002:a17:902:ced0:b029:12d:4ce1:ce3a with SMTP id
 d16-20020a170902ced0b029012d4ce1ce3amr25504885plg.0.1629662981831; Sun, 22
 Aug 2021 13:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210822184927.94673-1-jacopo@jmondi.org> <20210822184927.94673-3-jacopo@jmondi.org>
In-Reply-To: <20210822184927.94673-3-jacopo@jmondi.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 22 Aug 2021 23:09:05 +0300
Message-ID: <CAHp75Vc-=HKnC43+SnAAyP3GmdhMCuC7dBLyO_EHdSf3Jj29XA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: chemical: Add Sensteair Sunrise 006-0-007 driver
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 22, 2021 at 9:49 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
>
> Add support for the Senseair Sunrise 006-0-0007 driver through the
> IIO subsystem.

Thanks for an update, my comments below.

> Datasheet: https://rmtplusstoragesenseair.blob.core.windows.net/docs/Dev/publicerat/TDE5531.pdf
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> ---
>  MAINTAINERS                        |   6 +
>  drivers/iio/chemical/Kconfig       |  13 +
>  drivers/iio/chemical/Makefile      |   1 +
>  drivers/iio/chemical/sunrise_co2.c | 450 +++++++++++++++++++++++++++++
>  4 files changed, 470 insertions(+)
>  create mode 100644 drivers/iio/chemical/sunrise_co2.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90ca9df1d3c3..43f5bba46673 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16544,6 +16544,12 @@ S:     Maintained
>  F:     drivers/misc/phantom.c
>  F:     include/uapi/linux/phantom.h
>
> +SENSEAIR SUNRISE 006-0-0007
> +M:     Jacopo Mondi <jacopo@jmondi.org>
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
> +F:     drivers/iio/chemical/sunrise_co2.c
> +
>  SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
>  M:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
>  S:     Maintained
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index 10bb431bc3ce..ee8562949226 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -144,6 +144,19 @@ config SPS30
>           To compile this driver as a module, choose M here: the module will
>           be called sps30.
>
> +config SENSEAIR_SUNRISE_CO2
> +       tristate "Senseair Sunrise 006-0-0007 CO2 sensor"
> +       depends on OF
> +       depends on I2C
> +       depends on SYSFS
> +       select REGMAP_I2C
> +       help
> +         Say yes here to build support for Senseair Sunrise 006-0-0007 CO2
> +         sensor.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called sunrise_co2.
> +
>  config VZ89X
>         tristate "SGX Sensortech MiCS VZ89X VOC sensor"
>         depends on I2C
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index fef63dd5bf92..d5e2a3331d57 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -17,4 +17,5 @@ obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
>  obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
>  obj-$(CONFIG_SENSIRION_SGP30)  += sgp30.o
>  obj-$(CONFIG_SPS30) += sps30.o
> +obj-$(CONFIG_SENSEAIR_SUNRISE_CO2) += sunrise_co2.o
>  obj-$(CONFIG_VZ89X)            += vz89x.o
> diff --git a/drivers/iio/chemical/sunrise_co2.c b/drivers/iio/chemical/sunrise_co2.c
> new file mode 100644
> index 000000000000..1dcfe8e1a94a
> --- /dev/null
> +++ b/drivers/iio/chemical/sunrise_co2.c
> @@ -0,0 +1,450 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Senseair Sunrise 006-0-0007 CO2 sensor driver.
> + *
> + * Copyright (C) 2021 Jacopo Mondi
> + *
> + * List of features not yet supported by the driver:
> + * - controllable EN pin
> + * - single-shot operations using the nDRY pin.
> + * - ABC/target calibration
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/time64.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define DRIVER_NAME "sunrise"
> +
> +#define SUNRISE_ERROR_STATUS_REG               0x00
> +#define SUNRISE_CO2_FILTERED_COMP_REG          0x06
> +#define SUNRISE_CHIP_TEMPERATURE_REG           0x08
> +#define SUNRISE_CALIBRATION_STATUS_REG         0x81
> +#define SUNRISE_CALIBRATION_COMMAND_REG                0x82
> +#define SUNRISE_CALIBRATION_FACTORY_CMD                0x7c02
> +#define SUNRISE_CALIBRATION_BACKGROUND_CMD     0x7c06
> +/*
> + * The calibration timeout is not characterized in the datasheet.
> + * Use 30 seconds as a reasonable upper limit.
> + */
> +#define SUNRISE_CALIBRATION_TIMEOUT_US         (30 * USEC_PER_SEC)
> +
> +enum sunrise_calib {
> +       SUNRISE_CALIBRATION_FACTORY,
> +       SUNRISE_CALIBRATION_BACKGROUND,
> +};
> +
> +struct sunrise_dev {

> +       struct device *dev;
> +       struct i2c_client *client;

Is the *dev is different to &client->dev?

> +       struct regmap *regmap;
> +       struct mutex lock;
> +       enum sunrise_calib calibration;
> +};
> +
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
> +       i2c_smbus_xfer(client->adapter, client->addr, I2C_M_IGNORE_NAK,
> +                      I2C_SMBUS_WRITE, 0, I2C_SMBUS_QUICK, NULL);
> +}
> +
> +static int sunrise_read_word(struct sunrise_dev *sunrise, u8 reg, u16 *val)
> +{
> +       __be16 be_val;
> +       int ret;
> +
> +       sunrise_wakeup(sunrise);
> +       ret = regmap_bulk_read(sunrise->regmap, reg, &be_val, 2);
> +       if (ret) {
> +               dev_err(sunrise->dev, "Read word failed: reg 0x%2x (%d)\n", reg, ret);
> +               return ret;
> +       }
> +
> +       *val = be16_to_cpu(be_val);
> +
> +       return 0;
> +}
> +
> +static int sunrise_write_byte(struct sunrise_dev *sunrise, u8 reg, u8 val)
> +{
> +       int ret;
> +
> +       sunrise_wakeup(sunrise);
> +       ret = regmap_write(sunrise->regmap, reg, val);
> +       if (ret) {
> +               dev_err(sunrise->dev, "Write byte failed: reg 0x%2x (%d)\n", reg, ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int sunrise_write_word(struct sunrise_dev *sunrise, u8 reg, u16 data)
> +{
> +       __be16 be_data = cpu_to_be16(data);
> +       int ret;
> +
> +       sunrise_wakeup(sunrise);
> +       ret = regmap_bulk_write(sunrise->regmap, reg, &be_data, 2);
> +       if (ret) {
> +               dev_err(sunrise->dev, "Write word failed: reg 0x%2x (%d)\n", reg, ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + *  --- Calibration ---
> + *
> + *  Enumerate and select calibration modes, trigger a calibration cycle.
> + */
> +static const char * const sunrise_calibration_modes[] = {
> +       [SUNRISE_CALIBRATION_FACTORY] = "factory_calibration",
> +       [SUNRISE_CALIBRATION_BACKGROUND] = "background_calibration"
> +};
> +
> +static const struct sunrise_calibration_data {
> +       u16 calibration_cmd;
> +       u8 calibration_bit;
> +} sunrise_calibrations[] = {
> +       [SUNRISE_CALIBRATION_FACTORY] = {
> +               SUNRISE_CALIBRATION_FACTORY_CMD,
> +               BIT(2)

+ Comma

> +       },
> +       [SUNRISE_CALIBRATION_BACKGROUND] = {
> +               SUNRISE_CALIBRATION_BACKGROUND_CMD,
> +               BIT(5)

Ditto.

> +};
> +
> +static int sunrise_calibrate(struct sunrise_dev *sunrise)
> +{
> +       const struct sunrise_calibration_data *data;
> +       unsigned int status;
> +       int ret;
> +
> +       /* Reset the calibration status reg. */
> +       ret = sunrise_write_byte(sunrise, SUNRISE_CALIBRATION_STATUS_REG, 0x00);
> +       if (ret)
> +               return ret;
> +
> +       /* Write a calibration command and poll the calibration status bit. */
> +       data = &sunrise_calibrations[sunrise->calibration];
> +       ret = sunrise_write_word(sunrise, SUNRISE_CALIBRATION_COMMAND_REG,
> +                                data->calibration_cmd);
> +       if (ret)
> +               return ret;
> +
> +       dev_dbg(sunrise->dev, "%s in progress\n",
> +               sunrise_calibration_modes[sunrise->calibration]);
> +
> +       return regmap_read_poll_timeout(sunrise->regmap,
> +                                       SUNRISE_CALIBRATION_STATUS_REG,
> +                                       status, status & data->calibration_bit,
> +                                       100, SUNRISE_CALIBRATION_TIMEOUT_US);
> +}
> +
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
> +               return ret;
> +
> +       if (!calibrate)
> +               return 0;
> +
> +       ret = sunrise_calibrate(sunrise);
> +       if (ret)
> +               return ret;
> +
> +       return len;
> +}
> +
> +static int sunrise_set_calibration_mode(struct iio_dev *iiodev,
> +                                       const struct iio_chan_spec *chan,
> +                                       unsigned int mode)
> +{
> +       struct sunrise_dev *sunrise = iio_priv(iiodev);
> +
> +       mutex_lock(&sunrise->lock);
> +       sunrise->calibration = mode;
> +       mutex_unlock(&sunrise->lock);
> +
> +       return 0;
> +}
> +
> +static int sunrise_get_calibration_mode(struct iio_dev *iiodev,
> +                                       const struct iio_chan_spec *chan)
> +{
> +       struct sunrise_dev *sunrise = iio_priv(iiodev);
> +       int mode;
> +
> +       mutex_lock(&sunrise->lock);
> +       mode = sunrise->calibration;
> +       mutex_unlock(&sunrise->lock);
> +
> +       return mode;
> +}
> +
> +static const struct iio_enum sunrise_calibration_modes_enum = {
> +       .items = sunrise_calibration_modes,
> +       .num_items = ARRAY_SIZE(sunrise_calibration_modes),
> +       .set = sunrise_set_calibration_mode,
> +       .get = sunrise_get_calibration_mode,
> +};
> +
> +/* --- Error status---
> + *
> + * Enumerate and retrieve the chip error status.
> + */
> +enum {
> +       SUNRISE_ERROR_FATAL,
> +       SUNRISE_ERROR_I2C,
> +       SUNRISE_ERROR_ALGORITHM,
> +       SUNRISE_ERROR_CALIBRATION,
> +       SUNRISE_ERROR_SELF_DIAGNOSTIC,
> +       SUNRISE_ERROR_OUT_OF_RANGE,
> +       SUNRISE_ERROR_MEMORY,
> +       SUNRISE_ERROR_NO_MEASUREMENT,
> +       SUNRISE_ERROR_LOW_VOLTAGE,
> +       SUNRISE_ERROR_MEASUREMENT_TIMEOUT

+ Comma

> +};
> +
> +static const char * const sunrise_error_statuses[] = {
> +       [SUNRISE_ERROR_FATAL] = "error_fatal",
> +       [SUNRISE_ERROR_I2C] = "error_i2c",
> +       [SUNRISE_ERROR_ALGORITHM] = "error_algorithm",
> +       [SUNRISE_ERROR_CALIBRATION] = "error_calibration",
> +       [SUNRISE_ERROR_SELF_DIAGNOSTIC] = "error_self_diagnostic",
> +       [SUNRISE_ERROR_OUT_OF_RANGE] = "error_out_of_range",
> +       [SUNRISE_ERROR_MEMORY] = "error_memory",
> +       [SUNRISE_ERROR_NO_MEASUREMENT] = "error_no_measurement",
> +       [SUNRISE_ERROR_LOW_VOLTAGE] = "error_low_voltage",
> +       [SUNRISE_ERROR_MEASUREMENT_TIMEOUT] = "error_measurement_timeout"

Ditto.

> +};
> +
> +static const u8 error_codes[] = {
> +       SUNRISE_ERROR_FATAL,
> +       SUNRISE_ERROR_I2C,
> +       SUNRISE_ERROR_ALGORITHM,
> +       SUNRISE_ERROR_CALIBRATION,
> +       SUNRISE_ERROR_SELF_DIAGNOSTIC,
> +       SUNRISE_ERROR_OUT_OF_RANGE,
> +       SUNRISE_ERROR_MEMORY,
> +       SUNRISE_ERROR_NO_MEASUREMENT,
> +       SUNRISE_ERROR_LOW_VOLTAGE,
> +       SUNRISE_ERROR_MEASUREMENT_TIMEOUT

Ditto.

> +};
> +
> +static const struct iio_enum sunrise_error_statuses_enum = {
> +       .items = sunrise_error_statuses,
> +       .num_items = ARRAY_SIZE(sunrise_error_statuses)

Ditto.


> +};
> +
> +static ssize_t sunrise_error_status_read(struct iio_dev *iiodev,
> +                                        uintptr_t private,
> +                                        const struct iio_chan_spec *chan,
> +                                        char *buf)
> +{
> +       struct sunrise_dev *sunrise = iio_priv(iiodev);
> +       const unsigned long *errors;
> +       ssize_t len = 0;
> +       u16 value;
> +       int ret;
> +       u8 i;
> +
> +       ret = sunrise_read_word(sunrise, SUNRISE_ERROR_STATUS_REG, &value);
> +       if (ret)
> +               return -EINVAL;
> +

> +pr_err("%s:%d0x%x\n", __func__, __LINE__, value);

What's this?

> +       errors = (const unsigned long *)&value;
> +       for_each_set_bit(i, errors, ARRAY_SIZE(error_codes))
> +               len += sysfs_emit_at(buf, len, "%s ", sunrise_error_statuses[i]);
> +
> +       if (len)
> +               buf[len - 1] = '\n';
> +
> +       return len;
> +}
> +
> +static const struct iio_chan_spec_ext_info sunrise_concentration_ext_info[] = {
> +       /* Calibration modes and calibration trigger. */
> +       {
> +               .name = "calibration",
> +               .write = sunrise_calibration_write,
> +               .shared = IIO_SEPARATE

+ Comma

> +       },
> +       IIO_ENUM("calibration_mode", IIO_SEPARATE,
> +                &sunrise_calibration_modes_enum),
> +       IIO_ENUM_AVAILABLE("calibration_mode",
> +                          &sunrise_calibration_modes_enum),
> +
> +       /* Error statuses. */
> +       {
> +               .name = "error_status",
> +               .read = sunrise_error_status_read,
> +               .shared = IIO_SEPARATE
> +       },
> +       IIO_ENUM_AVAILABLE("error_status", &sunrise_error_statuses_enum),
> +       {}
> +};
> +
> +static const struct iio_chan_spec sunrise_channels[] = {
> +       {
> +               .type = IIO_CONCENTRATION,
> +               .modified = 1,
> +               .channel2 = IIO_MOD_CO2,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +               .ext_info = sunrise_concentration_ext_info,
> +               .scan_index = 0,
> +               .scan_type =  {
> +                       .sign = 's',
> +                       .realbits = 16,
> +                       .storagebits = 16,
> +                       .endianness = IIO_CPU,
> +               }
> +       },
> +       {
> +               .type = IIO_TEMP,
> +               .info_mask_separate =  BIT(IIO_CHAN_INFO_RAW) |
> +                                      BIT(IIO_CHAN_INFO_SCALE),
> +               .scan_index = 1,
> +               .scan_type =  {
> +                       .sign = 's',
> +                       .realbits = 16,
> +                       .storagebits = 16,
> +                       .endianness = IIO_CPU,
> +               }
> +       }

+ Comma

> +};
> +
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
> +               mutex_lock(&sunrise->lock);
> +
> +               switch (chan->type) {
> +               case IIO_CONCENTRATION:
> +                       ret = sunrise_read_word(sunrise, SUNRISE_CO2_FILTERED_COMP_REG,
> +                                               &value);
> +                       *val = value;
> +                       mutex_unlock(&sunrise->lock);
> +
> +                       return ret ?: IIO_VAL_INT;
> +
> +               case IIO_TEMP:
> +                       ret = sunrise_read_word(sunrise, SUNRISE_CHIP_TEMPERATURE_REG,
> +                                               &value);
> +                       *val = value;
> +                       mutex_unlock(&sunrise->lock);
> +
> +                       return ret ?: IIO_VAL_INT;
> +
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
> +}
> +
> +static const struct iio_info sunrise_info = {
> +       .read_raw = sunrise_read_raw

+ Comma

> +};
> +
> +static struct regmap_config sunrise_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8

+ Comma

Do you need a regmap lock?

> +};
> +
> +static int sunrise_probe(struct i2c_client *client)
> +{
> +       struct sunrise_dev *sunrise;
> +       struct iio_dev *iio_dev;
> +
> +       iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*sunrise));
> +       if (!iio_dev)
> +               return -ENOMEM;

> +
> :q
> :q

Not sure what this is and how it comes to here. Have you tested your patches?

> +       i2c_set_clientdata(client, iio_dev);
> +
> +       sunrise = iio_priv(iio_dev);
> +       sunrise->client = client;
> +       sunrise->dev = &client->dev;
> +       mutex_init(&sunrise->lock);
> +
> +       sunrise->regmap = devm_regmap_init_i2c(client, &sunrise_regmap_config);
> +       if (IS_ERR(sunrise->regmap)) {
> +               dev_err(&client->dev, "Failed to initialize regmap\n");
> +               return PTR_ERR(sunrise->regmap);
> +       }
> +
> +       iio_dev->info = &sunrise_info;
> +       iio_dev->name = DRIVER_NAME;
> +       iio_dev->channels = sunrise_channels;
> +       iio_dev->num_channels = ARRAY_SIZE(sunrise_channels);
> +       iio_dev->modes = INDIO_DIRECT_MODE;
> +
> +       return devm_iio_device_register(&client->dev, iio_dev);
> +}
> +
> +static const struct of_device_id sunrise_of_match[] = {
> +       { .compatible = "senseair,sunrise-006-0-0007" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, sunrise_of_match);
> +
> +static struct i2c_driver sunrise_driver = {
> +       .driver = {
> +               .name = DRIVER_NAME,
> +               .of_match_table = sunrise_of_match

+ Comma

> +       },
> +       .probe_new = sunrise_probe

+ Comma

> +};

I think you didn't get my comment about commas. Terminator line is one
which is used as a marker of the end of an array. In such cases a
comma is not needed, otherwise always add it.

--
With Best Regards,
Andy Shevchenko
