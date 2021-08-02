Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBC83DD104
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 09:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhHBHM2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 03:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhHBHMW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 03:12:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E632FC06175F
        for <linux-iio@vger.kernel.org>; Mon,  2 Aug 2021 00:12:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b1-20020a17090a8001b029017700de3903so18154352pjn.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Aug 2021 00:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSGWbbFuRedaEdyHysxeV1IP4YatfL/K7UHxptSqMq8=;
        b=d8GCocRVSdHjh4nXPI+PqdClqXgDWX1asq1kRffmHK9uHUakFQimtLIba2jjgi4fxu
         NGp4+kc/i84QqimetCqakCFsLc358eMookhk2TRzJiCmQpCNHPqRBqxvoYO115RklATS
         wdywI8GjtUazGAjDLbZsYp6pDsliQzcSP+rcvfBaLjVvEHWb8avMW3c6Cbr7FMI4xXW2
         kT1mcL73s4C2s5R5s0aHC5ahkaSM+7aQstZ5nXNF7sewFqVMr++Y68WiiV3C3cdaRGys
         CVyw7M3zFmibM1AXWB2sONDsClatiw5r3hrXRgVzEWKQIWRshrsqu3mu/Ux+tFBrUJxh
         zSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSGWbbFuRedaEdyHysxeV1IP4YatfL/K7UHxptSqMq8=;
        b=lJcXzf1er6yPNG8//WvB9XBFWKiRwtdEZQcjdkMweOMaP0WzlWVCcVDDZbSikf8DRv
         HkNzvW0P3dIds0zcXWgSzzxZJMd7xifn1dzCJSyN7fFuswM+uaBq1dk+L+XUzCS8CNnR
         IZk0SoOjyNo7s6OO3zvzyiHupnquLPSNSZNroV7deBC2pLDIJcFPhPM/d6vphE8ZE3db
         dw5VmbhFLK5aZum67Mn9tQWlB281KDwyZC9sb90RWPk5cz0jh/Ff/QHlqiKUUK4VQsD5
         YNPoR7lQuHbkzazQ2sinHHSBqwccjkTE6KnVhOTzC2wrriaFbIpJoU74Id6p8dil6zPi
         +a6w==
X-Gm-Message-State: AOAM530WpXL/Js5uXp48nzmUK8LB4OYF70eqVfUsfaa0MTXNjx5FoIBj
        zfOwAmPnIUL71TpvvCd7fu5XI8znx9rz6iO33Ew=
X-Google-Smtp-Source: ABdhPJxoSuZCu3vEitn2+ghjhTMOqbnX+5SeLRWSihnF89/mMMv7piQKFmLb7sgZGI2gsT8ryhTyFV1VX+MYTZfl57Q=
X-Received: by 2002:a63:7209:: with SMTP id n9mr1567421pgc.253.1627888332321;
 Mon, 02 Aug 2021 00:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210801034341.67953-1-navin@linumiz.com>
In-Reply-To: <20210801034341.67953-1-navin@linumiz.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 2 Aug 2021 10:12:00 +0300
Message-ID: <CA+U=DsrmYJTJNgK52CQc6kiP0Fxe4sV+33f8ViV5ED2-5RmDXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: temperature: Add MAX31865 RTD Support
To:     Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 1, 2021 at 7:06 AM Navin Sankar Velliangiri
<navin@linumiz.com> wrote:
>
> This patch adds support for Maxim MAX31865 RTD temperature
> sensor support.
>
> More information can be found in:
> https://datasheets.maximintegrated.com/en/ds/MAX31865.pdf
>
> Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>
>
> Note: Changes in v2:
>         -> removed unnecessary header #include <linux/util_macros.h>
>         -> implemented mutex to protect the device state
>         -> Added __cacheline_aligned buffer to hold the raw temperature data
>         -> implemented separate function to enable_bias() & disable_bias()
>         -> call max31865_init() func when updating the filter
>         -> Added ABI documentation for reference & testing
>         -> dropped spi_set_drvdata()
> ---
>  .../sysfs-bus-iio-temperature-max31865        |  25 ++
>  drivers/iio/temperature/Kconfig               |  10 +
>  drivers/iio/temperature/Makefile              |   1 +
>  drivers/iio/temperature/max31865.c            | 347 ++++++++++++++++++
>  4 files changed, 383 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
>  create mode 100644 drivers/iio/temperature/max31865.c
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
> new file mode 100644
> index 000000000000..7ca1e09b73f5
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
> @@ -0,0 +1,25 @@
> +What:          /sys/bus/iio/devices/iio:deviceX/fault_ovuv
> +KernelVersion: 5.11
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               Overvoltage or Undervoltage Input fault. The internal circuitry
> +               is protected from excessive voltages applied to the thermocouple
> +               cables at FORCE+, FORCE2, RTDIN+ & RTDIN-. This circuitry turn
> +               off when the input voltage is negative or greater than VDD.
> +
> +               Reading returns either '1' or '0'
> +
> +               === =======================================================
> +               '1' The input voltage is negative or greater than VDD.
> +               '0' The input voltage is positive and less than VDD (normal
> +                   state).
> +               === =======================================================
> +
> +What:          /sys/bus/iio/devices/iio:deviceX/in_temp_filter_notch_frequency
> +KernelVersion: 5.11
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               Notch frequency in Hz for a noise rejection filter. Used i.e for
> +               line noise rejection.
> +
> +               Valid notch filter values are 50 Hz and 60 Hz.
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 4df60082c1fa..c9412abca069 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -128,4 +128,14 @@ config MAX31856
>           This driver can also be built as a module.  If so, the module
>           will be called max31856.
>
> +config MAX31865
> +       tristate "MAX31865 RTD to Digital converter"
> +       depends on SPI
> +       help
> +         If you say yes here you get support for MAX31865
> +         thermocouple sensor chip connected via SPI.
> +
> +         This driver can also be build as a module. If so, the module
> +         will be called max31865.
> +
>  endmenu
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index 90c113115422..a8f3187258dc 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_LTC2983) += ltc2983.o
>  obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
>  obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
>  obj-$(CONFIG_MAX31856) += max31856.o
> +obj-$(CONFIG_MAX31865) += max31865.o
>  obj-$(CONFIG_MLX90614) += mlx90614.o
>  obj-$(CONFIG_MLX90632) += mlx90632.o
>  obj-$(CONFIG_TMP006) += tmp006.o
> diff --git a/drivers/iio/temperature/max31865.c b/drivers/iio/temperature/max31865.c
> new file mode 100644
> index 000000000000..9a6ee251bb3e
> --- /dev/null
> +++ b/drivers/iio/temperature/max31865.c
> @@ -0,0 +1,347 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (c) Linumiz 2021
> + *
> + * max31865.c - Maxim MAX31865 RTD-to-Digital Converter sensor driver
> + *
> + * Author: Navin Sankar Velliangiri <navin@linumiz.com>
> + */
> +
> +#include <linux/ctype.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/spi/spi.h>
> +#include <asm/unaligned.h>
> +
> +/*
> + * The MSB of the register value determines whether the following byte will
> + * be written or read. If it is 0, read will follow and if it is 1, write
> + * will follow.
> + */
> +#define MAX31865_RD_WR_BIT                     BIT(7)
> +
> +#define MAX31865_CFG_VBIAS                     BIT(7)
> +#define MAX31865_CFG_1SHOT                     BIT(5)
> +#define MAX31865_3WIRE_RTD                     BIT(4)
> +#define MAX31865_FAULT_STATUS_CLEAR            BIT(1)
> +#define MAX31865_FILTER_50HZ                   BIT(0)
> +
> +/* The MAX31865 registers */
> +#define MAX31865_CFG_REG                       0x00
> +#define MAX31865_RTD_MSB                       0x01
> +#define MAX31865_FAULT_STATUS                  0x07
> +
> +#define MAX31865_FAULT_OVUV                    BIT(2)
> +
> +static const struct iio_chan_spec max31865_channels[] = {
> +       {       /* RTD Temperature */
> +               .type = IIO_TEMP,
> +               .info_mask_separate =
> +                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)
> +       },
> +};
> +
> +struct max31865_data {
> +       struct spi_device *spi;
> +       struct mutex lock;
> +       u8 buf[2] ____cacheline_aligned;
> +       bool filter_50hz;
> +       bool three_wire;
> +};
> +
> +static int max31865_read(struct max31865_data *data, u8 reg,
> +                        unsigned int read_size)
> +{
> +       return spi_write_then_read(data->spi, &reg, 1, data->buf, read_size);
> +}
> +
> +static int max31865_write(struct max31865_data *data, size_t len)
> +{
> +       return spi_write(data->spi, data->buf, len);
> +}
> +
> +static int enable_bias(struct max31865_data *data)
> +{
> +       u8 cfg;
> +       int ret;
> +
> +       ret = max31865_read(data, MAX31865_CFG_REG, 1);
> +       if (ret)
> +               return ret;
> +
> +       cfg = data->buf[0];
> +
> +       data->buf[0] = MAX31865_CFG_REG | MAX31865_RD_WR_BIT;
> +       data->buf[1] = cfg | MAX31865_CFG_VBIAS;
> +
> +       return max31865_write(data, 2);
> +}
> +
> +static int disable_bias(struct max31865_data *data)
> +{
> +       u8 cfg;
> +       int ret;
> +
> +       ret = max31865_read(data, MAX31865_CFG_REG, 1);
> +       if (ret)
> +               return ret;
> +
> +       cfg = data->buf[0];
> +       cfg &= ~MAX31865_CFG_VBIAS;
> +
> +       data->buf[0] = MAX31865_CFG_REG | MAX31865_RD_WR_BIT;
> +       data->buf[1] = cfg;
> +
> +       return max31865_write(data, 2);
> +}
> +
> +static int max31865_rtd_read(struct max31865_data *data, int *val)
> +{
> +       u8 reg;
> +       int ret;
> +
> +       /* Enable BIAS to start the conversion */
> +       ret = enable_bias(data);
> +       if (ret)
> +               return ret;
> +
> +       /* wait 10.5ms before initiating the conversion */
> +       msleep(11);
> +
> +       ret = max31865_read(data, MAX31865_CFG_REG, 1);
> +       if (ret)
> +               return ret;
> +
> +       reg = data->buf[0];
> +       reg |= MAX31865_CFG_1SHOT | MAX31865_FAULT_STATUS_CLEAR;
> +       data->buf[0] = MAX31865_CFG_REG | MAX31865_RD_WR_BIT;
> +       data->buf[1] = reg;
> +
> +       ret = max31865_write(data, 2);
> +       if (ret)
> +               return ret;
> +
> +       if (data->filter_50hz) {
> +               /* 50Hz filter mode requires 62.5ms to complete */
> +               msleep(63);
> +       } else {
> +               /* 60Hz filter mode requires 52ms to complete */
> +               msleep(52);
> +       }
> +
> +       ret = max31865_read(data, MAX31865_RTD_MSB, 2);
> +       if (ret)
> +               return ret;
> +
> +       *val = (data->buf[0] << 8 | data->buf[1]) >> 1;
> +
> +       return disable_bias(data);
> +}
> +
> +static int max31865_read_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan,
> +                            int *val, int *val2, long mask)
> +{
> +       struct max31865_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               mutex_lock(&data->lock);
> +               ret = max31865_rtd_read(data, val);
> +               mutex_unlock(&data->lock);
> +               if (ret)
> +                       return ret;
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SCALE:
> +               /* Temp. Data resolution is 0.03125 degree centigrade */
> +               *val = 31;
> +               *val2 = 250000; /* 1000 * 0.03125 */
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int max31865_init(struct max31865_data *data)
> +{
> +       u8 cfg;
> +       int ret;
> +
> +       ret = max31865_read(data, MAX31865_CFG_REG, 1);
> +       if (ret)
> +               return ret;
> +
> +       cfg = data->buf[0];
> +
> +       if (data->three_wire)
> +               /* 3-wire RTD connection */
> +               cfg |= MAX31865_3WIRE_RTD;
> +
> +       if (data->filter_50hz)
> +               /* 50Hz noise rejection filter */
> +               cfg |= MAX31865_FILTER_50HZ;
> +
> +       data->buf[0] = MAX31865_CFG_REG | MAX31865_RD_WR_BIT;
> +       data->buf[1] = cfg;
> +
> +       return max31865_write(data, 2);
> +}
> +
> +static ssize_t show_fault(struct device *dev, u8 faultbit, char *buf)
> +{
> +       int ret;
> +       bool fault;
> +       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +       struct max31865_data *data = iio_priv(indio_dev);
> +
> +       ret = max31865_read(data, MAX31865_FAULT_STATUS, 1);
> +       if (ret)
> +               return ret;
> +
> +       fault = data->buf[0] & faultbit;
> +
> +       return sprintf(buf, "%d\n", fault);
> +}
> +
> +static ssize_t show_fault_ovuv(struct device *dev,
> +                             struct device_attribute *attr,
> +                             char *buf)
> +{
> +       return show_fault(dev, MAX31865_FAULT_OVUV, buf);
> +}
> +
> +static ssize_t show_filter(struct device *dev,
> +                          struct device_attribute *attr,
> +                          char *buf)
> +{
> +       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +       struct max31865_data *data = iio_priv(indio_dev);
> +
> +       return sprintf(buf, "%d\n", data->filter_50hz ? 50 : 60);
> +}
> +
> +static ssize_t set_filter(struct device *dev,
> +                         struct device_attribute *attr,
> +                         const char *buf,
> +                         size_t len)
> +{
> +       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +       struct max31865_data *data = iio_priv(indio_dev);
> +       unsigned int freq;
> +       int ret;
> +
> +       ret = kstrtouint(buf, 10, &freq);
> +       if (ret)
> +               return ret;
> +
> +       switch (freq) {
> +       case 50:
> +               data->filter_50hz = true;
> +               break;
> +       case 60:
> +               data->filter_50hz = false;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       mutex_lock(&data->lock);
> +       ret = max31865_init(data);
> +       mutex_unlock(&data->lock);
> +       if (ret)
> +               return ret;
> +
> +       return len;
> +}
> +
> +static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
> +static IIO_DEVICE_ATTR(in_temp_filter_notch_frequency, 0644,
> +                   show_filter, set_filter, 0);
> +
> +static struct attribute *max31865_attributes[] = {
> +       &iio_dev_attr_fault_ovuv.dev_attr.attr,
> +       &iio_dev_attr_in_temp_filter_notch_frequency.dev_attr.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group max31865_group = {
> +       .attrs = max31865_attributes,
> +};
> +
> +static const struct iio_info max31865_info = {
> +       .read_raw = max31865_read_raw,
> +       .attrs = &max31865_group,
> +};
> +
> +static int max31865_probe(struct spi_device *spi)
> +{
> +       const struct spi_device_id *id = spi_get_device_id(spi);
> +       struct iio_dev *indio_dev;
> +       struct max31865_data *data;
> +       int ret;
> +
> +       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       data = iio_priv(indio_dev);
> +       data->spi = spi;
> +       data->filter_50hz = false;
> +       mutex_init(&data->lock);
> +
> +       indio_dev->info = &max31865_info;
> +       indio_dev->name = id->name;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->channels = max31865_channels;
> +       indio_dev->num_channels = ARRAY_SIZE(max31865_channels);
> +
> +       if (of_property_read_bool(spi->dev.of_node, "maxim,3-wire")) {
> +               /* select 3 wire */
> +               data->three_wire = 1;
> +       } else {
> +               /* select 2 or 4 wire */
> +               data->three_wire = 0;
> +       }
> +
> +       mutex_lock(&data->lock);
> +       ret = max31865_init(data);
> +       mutex_unlock(&data->lock);

There aren't any changes for race-conditions here.
There is no userspace access to the device yet (before
devm_iio_device_register() is being called).
So, the locking can be removed [here] in probe().

> +       if (ret) {
> +               dev_err(&spi->dev, "error: Failed to configure max31865\n");
> +               return ret;
> +       }
> +
> +       return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id max31865_id[] = {
> +       { "max31865", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(spi, max31865_id);
> +
> +static const struct of_device_id max31865_of_match[] = {
> +       { .compatible = "maxim,max31865" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, max31865_of_match);
> +
> +static struct spi_driver max31865_driver = {
> +       .driver = {
> +               .name   = "max31865",
> +               .of_match_table = max31865_of_match,
> +       },
> +       .probe = max31865_probe,
> +       .id_table = max31865_id,
> +};
> +module_spi_driver(max31865_driver);
> +
> +MODULE_AUTHOR("Navin Sankar Velliangiri <navin@linumiz.com>");
> +MODULE_DESCRIPTION("Maxim MAX31865 RTD-to-Digital Converter sensor driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.32.0
>
