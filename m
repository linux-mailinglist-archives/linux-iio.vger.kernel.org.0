Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C818CF5C
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 14:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgCTNso (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 09:48:44 -0400
Received: from www381.your-server.de ([78.46.137.84]:49808 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgCTNso (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 09:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gPTUvwoFQCVPpAwkgN/y5IkDMvbHkXhl6sSP/MmNu+0=; b=bzU3ztzvfcMZrICWHoeYIOq59Z
        ERbc1yGRoGfH8B4xiHUekYd+UUuUOIWhkQkULJYmOR9Q9DV6Rm5/uFDlNJ2i+KmrTaKOFTz2JN+uv
        4+KkN6e1WPwsQRo1mP3xz+X34lcaCOmRVLAlVE4MlNOC3KT7XgUjxxwRnPc2KdDPZ2mSbgqABx8fr
        0Xh4hmK6uPCRFU+gJmP4FOMrF+ud/Ia4VeFLOOHa85bDe4WNgvbLQVFpISBvtHshnhbNoBGxdajoX
        QsXeb/bNHLkGZUskzNDm+2mXUfL3hvVT2nQLKIhqP3zECu9LmiRwHoi28CKK91lrSbY75K6OcVval
        0VaDovzg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jFI0s-0005YM-B7; Fri, 20 Mar 2020 14:48:38 +0100
Received: from [93.104.114.206] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jFI0r-000T0t-TI; Fri, 20 Mar 2020 14:48:38 +0100
Subject: Re: [PATCH v1 1/1] iio: new iio kernel module for the ltc2945 device
To:     Pascal Bouwmann <bouwmann@tau-tec.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
References: <70e814b8-0ec9-05ca-6441-1a8222b13371@tau-tec.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <6a3da633-1742-b9fc-d2cd-cf848beea0d3@metafoo.de>
Date:   Fri, 20 Mar 2020 14:48:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <70e814b8-0ec9-05ca-6441-1a8222b13371@tau-tec.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25757/Fri Mar 20 14:13:59 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adding Guenter

On 3/20/20 1:05 PM, Pascal Bouwmann wrote:
> New iio driver for the ltc2945 device based on the hwmon ltc2945 driver. With this iio driver, data readout of the ltc2945 device can be performed by the library libIIO in user applications.

Usally we try to avoid having a driver in IIO and hwmon for the same 
hardware device. Is there a reason why you can't use the hwmon userspace 
interface?

- Lars

> 
> Signed-off-by: Pascal Bouwmann<bouwmann@tau-tec.de>
> ---
> 
> diff --git a/drivers/iio/adc/ltc2945_iio.c b/drivers/iio/adc/ltc2945_iio.c
> new file mode 100644
> index 000000000000..0ede89b6515e
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2945_iio.c
> @@ -0,0 +1,495 @@
> +/*
> + * Driver for Linear Technology LTC2945 I2C Power Monitor
> + *
> + * Copyright (c) 2019 tau-tec GmbH
> + * Author: Pascal Bouwmann<bouwmann@tau-tec.de>
> + *
> + *
> + * based on the hwmon ltc2945 driver
> + * Copyright (c) 2014 Guenter Roeck
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/stat.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/regmap.h>
> +
> +
> +/* chip registers */
> +#define LTC2945_CONTROL                0x00
> +#define LTC2945_ALERT                0x01
> +#define LTC2945_STATUS                0x02
> +#define LTC2945_FAULT                0x03
> +#define LTC2945_POWER_H                0x05
> +#define LTC2945_MAX_POWER_H            0x08
> +#define LTC2945_MIN_POWER_H            0x0b
> +#define LTC2945_MAX_POWER_THRES_H    0x0e
> +#define LTC2945_MIN_POWER_THRES_H    0x11
> +#define LTC2945_SENSE_H                0x14
> +#define LTC2945_MAX_SENSE_H            0x16
> +#define LTC2945_MIN_SENSE_H            0x18
> +#define LTC2945_MAX_SENSE_THRES_H    0x1a
> +#define LTC2945_MIN_SENSE_THRES_H    0x1c
> +#define LTC2945_VIN_H                0x1e
> +#define LTC2945_MAX_VIN_H            0x20
> +#define LTC2945_MIN_VIN_H            0x22
> +#define LTC2945_MAX_VIN_THRES_H        0x24
> +#define LTC2945_MIN_VIN_THRES_H        0x26
> +#define LTC2945_ADIN_H                0x28
> +#define LTC2945_MAX_ADIN_H            0x2a
> +#define LTC2945_MIN_ADIN_H            0x2c
> +#define LTC2945_MAX_ADIN_THRES_H    0x2e
> +#define LTC2945_MIN_ADIN_THRES_H    0x30
> +#define LTC2945_MIN_ADIN_THRES_L    0x31
> +
> +/* Fault register bits */
> +#define FAULT_ADIN_UV        (1 << 0)
> +#define FAULT_ADIN_OV        (1 << 1)
> +#define FAULT_VIN_UV        (1 << 2)
> +#define FAULT_VIN_OV        (1 << 3)
> +#define FAULT_SENSE_UV        (1 << 4)
> +#define FAULT_SENSE_OV        (1 << 5)
> +#define FAULT_POWER_UV        (1 << 6)
> +#define FAULT_POWER_OV        (1 << 7)
> +
> +/* Control register bits */
> +#define CONTROL_MULT_SELECT    (1 << 0)
> +#define CONTROL_TEST_MODE    (1 << 4)
> +
> +
> +/* Shunt resistor in uOhm */
> +#define DEFAULT_SHUNT_RESISTOR 1000
> +
> +
> +struct ltc2945_data
> +{
> +    int device_id;
> +    void *client;
> +    struct device *dev;
> +    struct regmap *regmap;
> +    unsigned int shunt_resistor;
> +    struct mutex lock;
> +};
> +
> +static inline bool is_power_reg(u8 reg)
> +{
> +    return (reg < LTC2945_SENSE_H);
> +}
> +
> +/* Return the value of the given register in uW, mV, or mA */
> +static long long ltc2945_reg_to_val(struct iio_dev *indio_dev, u8 reg)
> +{
> +    unsigned int control;
> +    u8 buf[3];
> +    long long val;
> +    int ret;
> +    struct ltc2945_data *data = iio_priv(indio_dev);
> +
> +    ret = regmap_bulk_read(data->regmap, reg, buf,
> +        is_power_reg(reg) ? 3 : 2);
> +
> +    if (ret < 0)
> +        return (ret);
> +
> +    if (is_power_reg(reg))
> +        /* power */
> +        val = (buf[0] << 16) + (buf[1] << 8) + buf[2];
> +    else
> +        /* current, voltage */
> +        val = (buf[0] << 4) + (buf[1] >> 4);
> +
> +    switch (reg) {
> +    case LTC2945_POWER_H:
> +    case LTC2945_MAX_POWER_H:
> +    case LTC2945_MIN_POWER_H:
> +    case LTC2945_MAX_POWER_THRES_H:
> +    case LTC2945_MIN_POWER_THRES_H:
> +        /*
> +        * Convert to uW by assuming current is measured with
> +        * an 1mOhm sense resistor, similar to current
> +        * measurements.
> +        * Control register bit 0 selects if voltage at SENSE+/VDD
> +        * or voltage at ADIN is used to measure power.
> +        */
> +        ret = regmap_read(data->regmap, LTC2945_CONTROL, &control);
> +
> +        if (ret < 0)
> +            return (ret);
> +
> +        if (control & CONTROL_MULT_SELECT)
> +            /* 25 mV * 25 uV = 0.625 uV resolution. */
> +            val *= 625LL;
> +        else
> +            /* 0.5 mV * 25 uV = 0.0125 uV resolution. */
> +            val = (val * 25LL) >> 1;
> +
> +        /* val has to be divided by the square of the shunt resistor in mOhm */
> +        val = div_u64(val, (data->shunt_resistor / 1000)^2);
> +        break;
> +
> +    case LTC2945_VIN_H:
> +    case LTC2945_MAX_VIN_H:
> +    case LTC2945_MIN_VIN_H:
> +    case LTC2945_MAX_VIN_THRES_H:
> +    case LTC2945_MIN_VIN_THRES_H:
> +        /* 25 mV resolution. Convert to mV. */
> +        val *= 25;
> +        break;
> +
> +    case LTC2945_ADIN_H:
> +    case LTC2945_MAX_ADIN_H:
> +    case LTC2945_MIN_ADIN_THRES_H:
> +    case LTC2945_MAX_ADIN_THRES_H:
> +    case LTC2945_MIN_ADIN_H:
> +        /* 0.5mV resolution. Convert to mV. */
> +        val = val >> 1;
> +        break;
> +
> +    case LTC2945_SENSE_H:
> +    case LTC2945_MAX_SENSE_H:
> +    case LTC2945_MIN_SENSE_H:
> +    case LTC2945_MAX_SENSE_THRES_H:
> +    case LTC2945_MIN_SENSE_THRES_H:
> +        /*
> +        * 25 uV resolution. Convert to current as measured with
> +        * an 1 mOhm sense resistor, in mA. If a different sense
> +        * resistor is installed, calculate the actual current by
> +        * dividing the reported current by the sense resistor value
> +        * in mOhm.
> +        */
> +        val *= 25;
> +        /* val has to be divided by the shunt resistor in mOhm */
> +        val = div_u64(val, data->shunt_resistor / 1000);
> +        break;
> +
> +    default:
> +        return (-EINVAL);
> +    }
> +
> +    return (val);
> +} /* static long long ltc2945_reg_to_val */
> +
> +static int ltc2945_val_to_reg(struct iio_dev *indio_dev, u8 reg,
> +                  unsigned long val)
> +{
> +    unsigned int control;
> +    int ret;
> +    struct ltc2945_data *data = iio_priv(indio_dev);
> +
> +    switch (reg) {
> +    case LTC2945_POWER_H:
> +    case LTC2945_MAX_POWER_H:
> +    case LTC2945_MIN_POWER_H:
> +    case LTC2945_MAX_POWER_THRES_H:
> +    case LTC2945_MIN_POWER_THRES_H:
> +        /*
> +        * Convert to register value by assuming current is measured
> +        * with an 1mOhm sense resistor, similar to current
> +        * measurements.
> +        * Control register bit 0 selects if voltage at SENSE+/VDD
> +        * or voltage at ADIN is used to measure power, which in turn
> +        * determines register calculations.
> +        */
> +        ret = regmap_read(data->regmap, LTC2945_CONTROL, &control);
> +
> +        if (ret < 0)
> +            return (ret);
> +
> +        if (control & CONTROL_MULT_SELECT)
> +            /* 25 mV * 25 uV = 0.625 uV resolution. */
> +            val = DIV_ROUND_CLOSEST(val, 625);
> +        else
> +            /*
> +            * 0.5 mV * 25 uV = 0.0125 uV resolution.
> +            * Divide first to avoid overflow;
> +            * accept loss of accuracy.
> +            */
> +            val = DIV_ROUND_CLOSEST(val, 25) * 2;
> +
> +        /* val has to be divided by the square of the shunt resistor in mOhm */
> +        val = div_u64(val, (data->shunt_resistor / 1000)^2);
> +        break;
> +
> +    case LTC2945_VIN_H:
> +    case LTC2945_MAX_VIN_H:
> +    case LTC2945_MIN_VIN_H:
> +    case LTC2945_MAX_VIN_THRES_H:
> +    case LTC2945_MIN_VIN_THRES_H:
> +        /* 25 mV resolution. */
> +        val /= 25;
> +        break;
> +
> +    case LTC2945_ADIN_H:
> +    case LTC2945_MAX_ADIN_H:
> +    case LTC2945_MIN_ADIN_THRES_H:
> +    case LTC2945_MAX_ADIN_THRES_H:
> +    case LTC2945_MIN_ADIN_H:
> +        /* 0.5mV resolution. */
> +        val *= 2;
> +        break;
> +
> +    case LTC2945_SENSE_H:
> +    case LTC2945_MAX_SENSE_H:
> +    case LTC2945_MIN_SENSE_H:
> +    case LTC2945_MAX_SENSE_THRES_H:
> +    case LTC2945_MIN_SENSE_THRES_H:
> +        /*
> +        * 25 uV resolution. Convert to current as measured with
> +        * an 1 mOhm sense resistor, in mA. If a different sense
> +        * resistor is installed, calculate the actual current by
> +        * dividing the reported current by the sense resistor value
> +        * in mOhm.
> +        */
> +        val = DIV_ROUND_CLOSEST(val, 25);
> +        /* val has to be divided by the shunt resistor in mOhm */
> +        val = div_u64(val, (data->shunt_resistor / 1000)^2);
> +        break;
> +
> +    default:
> +        return (-EINVAL);
> +    }
> +
> +    return (val);
> +
> +} /* static int ltc2945_val_to_reg */
> +
> +static ssize_t ltc2945_show_value(struct iio_dev *indio_dev,
> +                u8 reg)
> +{
> +    long long value;
> +    value = ltc2945_reg_to_val(indio_dev, reg);
> +    return (value);
> +} /* static ssize_t ltc2945_show_value */
> +
> +static int ltc2945_read_raw(struct iio_dev *indio_dev,
> +                struct iio_chan_spec const *chan,
> +                int *val, int *val2, long mask)
> +{
> +    switch (chan->type) {
> +    case IIO_VOLTAGE:
> +        switch (chan->channel) {
> +        case 1:
> +            *val = ltc2945_show_value(indio_dev, LTC2945_VIN_H);
> +
> +            if (*val < 0)
> +                return ( -EINVAL );
> +
> +            break;
> +
> +        case 2:
> +            *val = ltc2945_show_value(indio_dev, LTC2945_ADIN_H);
> +
> +            if (*val < 0)
> +                return ( -EINVAL );
> +
> +            break;
> +
> +        default:
> +            return (-EINVAL);
> +        }
> +
> +        return ( IIO_VAL_INT );
> +
> +    case IIO_CURRENT:
> +        *val = ltc2945_show_value(indio_dev, LTC2945_SENSE_H);
> +
> +        if (*val < 0)
> +            return (-EINVAL);
> +
> +        return (IIO_VAL_INT);
> +
> +    case IIO_POWER:
> +        *val = ltc2945_show_value(indio_dev, LTC2945_POWER_H);
> +
> +        if (*val < 0)
> +            return (-EINVAL);
> +
> +        return (IIO_VAL_INT);
> +
> +    default:
> +        return (-EINVAL);
> +    }
> +
> +    return (-EINVAL);
> +
> +} /* static int ltc2945_read_raw */
> +
> +/* set the value of the shunt resistor in uOhm */
> +static int set_shunt_resistor(struct ltc2945_data *chip, unsigned int val)
> +{
> +    chip->shunt_resistor = val;
> +    return (0);
> +} /* static int set_shunt_resistor */
> +
> +static ssize_t ltc2945_shunt_resistor_show(struct device *dev,
> +                      struct device_attribute *attr,
> +                      char *buf)
> +{
> +    struct ltc2945_data *chip = iio_priv(dev_to_iio_dev(dev));
> +    return sprintf(buf, "%d\n", chip->shunt_resistor);
> +} /* static ssize_t ltc2945_shunt_resistor_show */
> +
> +static ssize_t ltc2945_shunt_resistor_store(struct device *dev,
> +                       struct device_attribute *attr,
> +                       const char *buf, size_t len)
> +{
> +    struct ltc2945_data *chip = iio_priv(dev_to_iio_dev(dev));
> +    unsigned long val;
> +    int ret;
> +
> +    ret = kstrtoul((const char *) buf, 10, &val);
> +
> +    if (ret)
> +        return (ret);
> +
> +    ret = set_shunt_resistor(chip, val);
> +
> +    if (ret)
> +        return (ret);
> +
> +    return (len);
> +} /* static ssize_t ltc2945_shunt_resistor_store */
> +
> +#define LTC2945_CHAN_RAW(_type, _index, _address) { \
> +    .type = (_type), \
> +    .address = (_address), \
> +    .indexed = 1, \
> +    .channel = (_index), \
> +    .info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +}
> +
> +#define LTC2945_CHAN_PROCESSED(_type, _index, _address) { \
> +    .type = (_type), \
> +    .address = (_address), \
> +    .indexed = 1, \
> +    .channel = (_index), \
> +    .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
> +}
> +
> +static const struct iio_chan_spec ltc2945_channels[] = {
> +    LTC2945_CHAN_PROCESSED(IIO_VOLTAGE, 1, LTC2945_VIN_H),
> +    LTC2945_CHAN_PROCESSED(IIO_VOLTAGE, 2, LTC2945_ADIN_H),
> +    LTC2945_CHAN_PROCESSED(IIO_POWER, 1, LTC2945_POWER_H),
> +    LTC2945_CHAN_PROCESSED(IIO_CURRENT, 1, LTC2945_SENSE_H),
> +};
> +
> +
> +static IIO_DEVICE_ATTR(
> +    in_shunt_resistor,
> +    S_IRUGO | S_IWUSR,
> +    ltc2945_shunt_resistor_show,
> +    ltc2945_shunt_resistor_store,
> +    0
> +);
> +
> +static struct attribute *ltc2945_attributes[] = {
> +    &iio_dev_attr_in_shunt_resistor.dev_attr.attr,
> +    NULL,
> +};
> +
> +static const struct attribute_group ltc2945_attribute_group = {
> +    .attrs = ltc2945_attributes,
> +};
> +
> +
> +static const struct regmap_config ltc2945_regmap_config = {
> +    .reg_bits = 8,
> +    .val_bits = 8,
> +    .max_register = LTC2945_MIN_ADIN_THRES_L,
> +};
> +
> +
> +static const struct iio_info ltc2945_info = {
> +    .read_raw = &ltc2945_read_raw,
> +    .attrs = &ltc2945_attribute_group,
> +};
> +
> +
> +static int ltc2945_probe(struct i2c_client *client,
> +               const struct i2c_device_id *id)
> +{
> +    int ret;
> +    struct ltc2945_data *dev_data;
> +    struct iio_dev *indio_dev;
> +
> +    if (!i2c_check_functionality(client->adapter,
> +                I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> +                I2C_FUNC_SMBUS_WRITE_BYTE |
> +                I2C_FUNC_SMBUS_READ_I2C_BLOCK))
> +        return -EOPNOTSUPP;
> +
> +    indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
> +
> +    if (!indio_dev)
> +        return -ENOMEM;
> +
> +    dev_data = iio_priv(indio_dev);
> +
> +    dev_data->client = client;
> +    mutex_init(&dev_data->lock);
> +
> +    dev_data->regmap = devm_regmap_init_i2c(client, &ltc2945_regmap_config);
> +
> +    if (IS_ERR(dev_data->regmap))
> +        return (PTR_ERR(dev_data->regmap));
> +
> +    ret = set_shunt_resistor(dev_data, DEFAULT_SHUNT_RESISTOR);
> +
> +    if (ret)
> +        return (ret);
> +
> +    /* Clear faults */
> +    regmap_write(dev_data->regmap, LTC2945_FAULT, 0x00);
> +
> +    indio_dev->info = &ltc2945_info;
> +    indio_dev->name = id->name;
> +    indio_dev->dev.parent = &client->dev;
> +    indio_dev->modes = INDIO_DIRECT_MODE;
> +    indio_dev->channels = ltc2945_channels;
> +    indio_dev->num_channels = ARRAY_SIZE(ltc2945_channels);
> +
> +    /* This is only used for device removal purposes. */
> +    i2c_set_clientdata(client, indio_dev);
> +
> +    return devm_iio_device_register(&client->dev, indio_dev);
> +} /* static int ltc2945_probe */
> +
> +
> +static const struct i2c_device_id ltc2945_id[] = {
> +    {"ltc2945_iio", 0},
> +    {}
> +};
> +MODULE_DEVICE_TABLE(i2c, ltc2945_id);
> +
> +
> +static struct i2c_driver ltc2945_driver = {
> +    .probe = ltc2945_probe,
> +    .id_table = ltc2945_id,
> +    .driver = {
> +        .name = "ltc2945_iio",
> +    },
> +};
> +
> +module_i2c_driver(ltc2945_driver);
> +
> +
> +MODULE_AUTHOR("Pascal Bouwmann<bouwmann@tau-tec.de>");
> +MODULE_DESCRIPTION("Linear Technology LTC2945 driver");
> +MODULE_LICENSE("GPL");
> 
> 

