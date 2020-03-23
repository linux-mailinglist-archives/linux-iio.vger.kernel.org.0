Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D8B18F628
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 14:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgCWNuj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 09:50:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44897 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgCWNui (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Mar 2020 09:50:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so5927550plr.11
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2020 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kgWpbrLIRNf1mizjVv188sEJD0ASu7u5h8nrY5ln3hM=;
        b=E2O4iRFZTJ8NXzhzU7S2jTW01gw5/sinK9SwoxcNzWzIMbHmHa0ggFiSiPjDmbDQMP
         CFX+b5JM6Ii4tI5TkGe2JDBLkSjPhKy37KSkg+I8vwG8GFyYjau/SD71OmkYuZ3R+QID
         oh2L3Y+i7abuzotakgAhgpZ1gJG6gARlYn+41ygPlInmtCgeiPHoPME2r9D2Rfy1UCNP
         Zi/Ui7OLLbmNQEJKIsFq2Y3n+00GQp9iUoNcJ3BbbQQSfM/Arw4/euDtoPILGVp5MWVq
         U+hzhS5cp7sckiH3IxRyfCrfVbcgxO6ALit++Ikp1fgOwRz1QrGivnQqKTqxBtnBjitB
         TQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kgWpbrLIRNf1mizjVv188sEJD0ASu7u5h8nrY5ln3hM=;
        b=Prk2I0asxMbBUmQs/GgDr9GNWujS8z9G6f78gMW9bv3FPCry0dQcuo6fPZ4PbuZRZb
         okZFb8mjahwFgpq18y86nKrk4RO0uaMHxjGqr2yTJjm/ES4C56Fmz33HS+rmaOjfaJR6
         Y72XNQuNMCcnTo0Xp36JIJusaFKCxC42el7ktO6uN13UOP9b60FzYQLICg/e88PS4HDE
         VwCNCkuvDmYP99aahwW/iT1RMz9gAPexma1X3QdiCaotsLtGN9AgJsgzNExYQEeIwitu
         TF/BHhMyecfX91oFhFc7EurW9fSqj3Kj+9EZuOl+Z1yMt7yJx5+Fn8mDO52BNb0HYZC6
         62Ug==
X-Gm-Message-State: ANhLgQ03WzP15QNp1p5i0E2+O5L8tk00V+tMBaimfX72lZD42YCfD1pi
        DSBiGSk7KMWbTI8Fxi4NScZCe+Tj
X-Google-Smtp-Source: ADFU+vshXZh5BC8k+G4SfnHg4upa50G7N5jLVer8PMpY9spRJqeUyIFmFZR/T60xt7wcppX0Oipdvw==
X-Received: by 2002:a17:90a:c985:: with SMTP id w5mr12479413pjt.187.1584971435113;
        Mon, 23 Mar 2020 06:50:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s15sm13543693pfd.164.2020.03.23.06.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 06:50:34 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] iio: new iio kernel module for the ltc2945 device
To:     Pascal Bouwmann <bouwmann@tau-tec.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <70e814b8-0ec9-05ca-6441-1a8222b13371@tau-tec.de>
 <6a3da633-1742-b9fc-d2cd-cf848beea0d3@metafoo.de>
 <29bbd1de-7210-3da6-9159-61e6559001f4@tau-tec.de>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <00664608-5629-77db-8fb0-d0638eb78b4b@roeck-us.net>
Date:   Mon, 23 Mar 2020 06:50:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <29bbd1de-7210-3da6-9159-61e6559001f4@tau-tec.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/23/20 5:24 AM, Pascal Bouwmann wrote:
> Dear Lars,
> 
> no, there is no reason, why I can't use the hwmon userspace interface.
> The only purpose for developing the iio driver was that I have several devices whose linux drivers belong to the iio subsystem. Only the LTC2945 linux driver doesn't belong to the iio subsystem.
> To avoid developing two userspace applications (one for the iio devices and one for the hwmon device), I developed the iio driver.
> 

We should reject that. Write a userspace library that can read both,
or write a hwmon->iio bridge, similar to the iio->hwmon bridge.

Guenter

> 
> Best regards,
> Pascal
> 
> 
> 
> Am 20.03.2020 um 14:48 schrieb Lars-Peter Clausen:
>>
>> Adding Guenter
>>
>>> New iio driver for the ltc2945 device based on the hwmon ltc2945 driver. With this iio driver, data readout of the ltc2945 device can be performed by the library libIIO in user applications.
>>
>> Usally we try to avoid having a driver in IIO and hwmon for the same hardware device. Is there a reason why you can't use the hwmon userspace interface?
>>
>> - Lars
>>
>>>
>>> Signed-off-by: Pascal Bouwmann<bouwmann@tau-tec.de>
>>> ---
>>>
>>> diff --git a/drivers/iio/adc/ltc2945_iio.c b/drivers/iio/adc/ltc2945_iio.c
>>> new file mode 100644
>>> index 000000000000..0ede89b6515e
>>> --- /dev/null
>>> +++ b/drivers/iio/adc/ltc2945_iio.c
>>> @@ -0,0 +1,495 @@
>>> +/*
>>> + * Driver for Linear Technology LTC2945 I2C Power Monitor
>>> + *
>>> + * Copyright (c) 2019 tau-tec GmbH
>>> + * Author: Pascal Bouwmann<bouwmann@tau-tec.de>
>>> + *
>>> + *
>>> + * based on the hwmon ltc2945 driver
>>> + * Copyright (c) 2014 Guenter Roeck
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#include <linux/init.h>
>>> +#include <linux/module.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/device.h>
>>> +#include <linux/stat.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/sysfs.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/regmap.h>
>>> +
>>> +
>>> +/* chip registers */
>>> +#define LTC2945_CONTROL                0x00
>>> +#define LTC2945_ALERT                0x01
>>> +#define LTC2945_STATUS                0x02
>>> +#define LTC2945_FAULT                0x03
>>> +#define LTC2945_POWER_H                0x05
>>> +#define LTC2945_MAX_POWER_H            0x08
>>> +#define LTC2945_MIN_POWER_H            0x0b
>>> +#define LTC2945_MAX_POWER_THRES_H    0x0e
>>> +#define LTC2945_MIN_POWER_THRES_H    0x11
>>> +#define LTC2945_SENSE_H                0x14
>>> +#define LTC2945_MAX_SENSE_H            0x16
>>> +#define LTC2945_MIN_SENSE_H            0x18
>>> +#define LTC2945_MAX_SENSE_THRES_H    0x1a
>>> +#define LTC2945_MIN_SENSE_THRES_H    0x1c
>>> +#define LTC2945_VIN_H                0x1e
>>> +#define LTC2945_MAX_VIN_H            0x20
>>> +#define LTC2945_MIN_VIN_H            0x22
>>> +#define LTC2945_MAX_VIN_THRES_H        0x24
>>> +#define LTC2945_MIN_VIN_THRES_H        0x26
>>> +#define LTC2945_ADIN_H                0x28
>>> +#define LTC2945_MAX_ADIN_H            0x2a
>>> +#define LTC2945_MIN_ADIN_H            0x2c
>>> +#define LTC2945_MAX_ADIN_THRES_H    0x2e
>>> +#define LTC2945_MIN_ADIN_THRES_H    0x30
>>> +#define LTC2945_MIN_ADIN_THRES_L    0x31
>>> +
>>> +/* Fault register bits */
>>> +#define FAULT_ADIN_UV        (1 << 0)
>>> +#define FAULT_ADIN_OV        (1 << 1)
>>> +#define FAULT_VIN_UV        (1 << 2)
>>> +#define FAULT_VIN_OV        (1 << 3)
>>> +#define FAULT_SENSE_UV        (1 << 4)
>>> +#define FAULT_SENSE_OV        (1 << 5)
>>> +#define FAULT_POWER_UV        (1 << 6)
>>> +#define FAULT_POWER_OV        (1 << 7)
>>> +
>>> +/* Control register bits */
>>> +#define CONTROL_MULT_SELECT    (1 << 0)
>>> +#define CONTROL_TEST_MODE    (1 << 4)
>>> +
>>> +
>>> +/* Shunt resistor in uOhm */
>>> +#define DEFAULT_SHUNT_RESISTOR 1000
>>> +
>>> +
>>> +struct ltc2945_data
>>> +{
>>> +    int device_id;
>>> +    void *client;
>>> +    struct device *dev;
>>> +    struct regmap *regmap;
>>> +    unsigned int shunt_resistor;
>>> +    struct mutex lock;
>>> +};
>>> +
>>> +static inline bool is_power_reg(u8 reg)
>>> +{
>>> +    return (reg < LTC2945_SENSE_H);
>>> +}
>>> +
>>> +/* Return the value of the given register in uW, mV, or mA */
>>> +static long long ltc2945_reg_to_val(struct iio_dev *indio_dev, u8 reg)
>>> +{
>>> +    unsigned int control;
>>> +    u8 buf[3];
>>> +    long long val;
>>> +    int ret;
>>> +    struct ltc2945_data *data = iio_priv(indio_dev);
>>> +
>>> +    ret = regmap_bulk_read(data->regmap, reg, buf,
>>> +        is_power_reg(reg) ? 3 : 2);
>>> +
>>> +    if (ret < 0)
>>> +        return (ret);
>>> +
>>> +    if (is_power_reg(reg))
>>> +        /* power */
>>> +        val = (buf[0] << 16) + (buf[1] << 8) + buf[2];
>>> +    else
>>> +        /* current, voltage */
>>> +        val = (buf[0] << 4) + (buf[1] >> 4);
>>> +
>>> +    switch (reg) {
>>> +    case LTC2945_POWER_H:
>>> +    case LTC2945_MAX_POWER_H:
>>> +    case LTC2945_MIN_POWER_H:
>>> +    case LTC2945_MAX_POWER_THRES_H:
>>> +    case LTC2945_MIN_POWER_THRES_H:
>>> +        /*
>>> +        * Convert to uW by assuming current is measured with
>>> +        * an 1mOhm sense resistor, similar to current
>>> +        * measurements.
>>> +        * Control register bit 0 selects if voltage at SENSE+/VDD
>>> +        * or voltage at ADIN is used to measure power.
>>> +        */
>>> +        ret = regmap_read(data->regmap, LTC2945_CONTROL, &control);
>>> +
>>> +        if (ret < 0)
>>> +            return (ret);
>>> +
>>> +        if (control & CONTROL_MULT_SELECT)
>>> +            /* 25 mV * 25 uV = 0.625 uV resolution. */
>>> +            val *= 625LL;
>>> +        else
>>> +            /* 0.5 mV * 25 uV = 0.0125 uV resolution. */
>>> +            val = (val * 25LL) >> 1;
>>> +
>>> +        /* val has to be divided by the square of the shunt resistor in mOhm */
>>> +        val = div_u64(val, (data->shunt_resistor / 1000)^2);
>>> +        break;
>>> +
>>> +    case LTC2945_VIN_H:
>>> +    case LTC2945_MAX_VIN_H:
>>> +    case LTC2945_MIN_VIN_H:
>>> +    case LTC2945_MAX_VIN_THRES_H:
>>> +    case LTC2945_MIN_VIN_THRES_H:
>>> +        /* 25 mV resolution. Convert to mV. */
>>> +        val *= 25;
>>> +        break;
>>> +
>>> +    case LTC2945_ADIN_H:
>>> +    case LTC2945_MAX_ADIN_H:
>>> +    case LTC2945_MIN_ADIN_THRES_H:
>>> +    case LTC2945_MAX_ADIN_THRES_H:
>>> +    case LTC2945_MIN_ADIN_H:
>>> +        /* 0.5mV resolution. Convert to mV. */
>>> +        val = val >> 1;
>>> +        break;
>>> +
>>> +    case LTC2945_SENSE_H:
>>> +    case LTC2945_MAX_SENSE_H:
>>> +    case LTC2945_MIN_SENSE_H:
>>> +    case LTC2945_MAX_SENSE_THRES_H:
>>> +    case LTC2945_MIN_SENSE_THRES_H:
>>> +        /*
>>> +        * 25 uV resolution. Convert to current as measured with
>>> +        * an 1 mOhm sense resistor, in mA. If a different sense
>>> +        * resistor is installed, calculate the actual current by
>>> +        * dividing the reported current by the sense resistor value
>>> +        * in mOhm.
>>> +        */
>>> +        val *= 25;
>>> +        /* val has to be divided by the shunt resistor in mOhm */
>>> +        val = div_u64(val, data->shunt_resistor / 1000);
>>> +        break;
>>> +
>>> +    default:
>>> +        return (-EINVAL);
>>> +    }
>>> +
>>> +    return (val);
>>> +} /* static long long ltc2945_reg_to_val */
>>> +
>>> +static int ltc2945_val_to_reg(struct iio_dev *indio_dev, u8 reg,
>>> +                  unsigned long val)
>>> +{
>>> +    unsigned int control;
>>> +    int ret;
>>> +    struct ltc2945_data *data = iio_priv(indio_dev);
>>> +
>>> +    switch (reg) {
>>> +    case LTC2945_POWER_H:
>>> +    case LTC2945_MAX_POWER_H:
>>> +    case LTC2945_MIN_POWER_H:
>>> +    case LTC2945_MAX_POWER_THRES_H:
>>> +    case LTC2945_MIN_POWER_THRES_H:
>>> +        /*
>>> +        * Convert to register value by assuming current is measured
>>> +        * with an 1mOhm sense resistor, similar to current
>>> +        * measurements.
>>> +        * Control register bit 0 selects if voltage at SENSE+/VDD
>>> +        * or voltage at ADIN is used to measure power, which in turn
>>> +        * determines register calculations.
>>> +        */
>>> +        ret = regmap_read(data->regmap, LTC2945_CONTROL, &control);
>>> +
>>> +        if (ret < 0)
>>> +            return (ret);
>>> +
>>> +        if (control & CONTROL_MULT_SELECT)
>>> +            /* 25 mV * 25 uV = 0.625 uV resolution. */
>>> +            val = DIV_ROUND_CLOSEST(val, 625);
>>> +        else
>>> +            /*
>>> +            * 0.5 mV * 25 uV = 0.0125 uV resolution.
>>> +            * Divide first to avoid overflow;
>>> +            * accept loss of accuracy.
>>> +            */
>>> +            val = DIV_ROUND_CLOSEST(val, 25) * 2;
>>> +
>>> +        /* val has to be divided by the square of the shunt resistor in mOhm */
>>> +        val = div_u64(val, (data->shunt_resistor / 1000)^2);
>>> +        break;
>>> +
>>> +    case LTC2945_VIN_H:
>>> +    case LTC2945_MAX_VIN_H:
>>> +    case LTC2945_MIN_VIN_H:
>>> +    case LTC2945_MAX_VIN_THRES_H:
>>> +    case LTC2945_MIN_VIN_THRES_H:
>>> +        /* 25 mV resolution. */
>>> +        val /= 25;
>>> +        break;
>>> +
>>> +    case LTC2945_ADIN_H:
>>> +    case LTC2945_MAX_ADIN_H:
>>> +    case LTC2945_MIN_ADIN_THRES_H:
>>> +    case LTC2945_MAX_ADIN_THRES_H:
>>> +    case LTC2945_MIN_ADIN_H:
>>> +        /* 0.5mV resolution. */
>>> +        val *= 2;
>>> +        break;
>>> +
>>> +    case LTC2945_SENSE_H:
>>> +    case LTC2945_MAX_SENSE_H:
>>> +    case LTC2945_MIN_SENSE_H:
>>> +    case LTC2945_MAX_SENSE_THRES_H:
>>> +    case LTC2945_MIN_SENSE_THRES_H:
>>> +        /*
>>> +        * 25 uV resolution. Convert to current as measured with
>>> +        * an 1 mOhm sense resistor, in mA. If a different sense
>>> +        * resistor is installed, calculate the actual current by
>>> +        * dividing the reported current by the sense resistor value
>>> +        * in mOhm.
>>> +        */
>>> +        val = DIV_ROUND_CLOSEST(val, 25);
>>> +        /* val has to be divided by the shunt resistor in mOhm */
>>> +        val = div_u64(val, (data->shunt_resistor / 1000)^2);
>>> +        break;
>>> +
>>> +    default:
>>> +        return (-EINVAL);
>>> +    }
>>> +
>>> +    return (val);
>>> +
>>> +} /* static int ltc2945_val_to_reg */
>>> +
>>> +static ssize_t ltc2945_show_value(struct iio_dev *indio_dev,
>>> +                u8 reg)
>>> +{
>>> +    long long value;
>>> +    value = ltc2945_reg_to_val(indio_dev, reg);
>>> +    return (value);
>>> +} /* static ssize_t ltc2945_show_value */
>>> +
>>> +static int ltc2945_read_raw(struct iio_dev *indio_dev,
>>> +                struct iio_chan_spec const *chan,
>>> +                int *val, int *val2, long mask)
>>> +{
>>> +    switch (chan->type) {
>>> +    case IIO_VOLTAGE:
>>> +        switch (chan->channel) {
>>> +        case 1:
>>> +            *val = ltc2945_show_value(indio_dev, LTC2945_VIN_H);
>>> +
>>> +            if (*val < 0)
>>> +                return ( -EINVAL );
>>> +
>>> +            break;
>>> +
>>> +        case 2:
>>> +            *val = ltc2945_show_value(indio_dev, LTC2945_ADIN_H);
>>> +
>>> +            if (*val < 0)
>>> +                return ( -EINVAL );
>>> +
>>> +            break;
>>> +
>>> +        default:
>>> +            return (-EINVAL);
>>> +        }
>>> +
>>> +        return ( IIO_VAL_INT );
>>> +
>>> +    case IIO_CURRENT:
>>> +        *val = ltc2945_show_value(indio_dev, LTC2945_SENSE_H);
>>> +
>>> +        if (*val < 0)
>>> +            return (-EINVAL);
>>> +
>>> +        return (IIO_VAL_INT);
>>> +
>>> +    case IIO_POWER:
>>> +        *val = ltc2945_show_value(indio_dev, LTC2945_POWER_H);
>>> +
>>> +        if (*val < 0)
>>> +            return (-EINVAL);
>>> +
>>> +        return (IIO_VAL_INT);
>>> +
>>> +    default:
>>> +        return (-EINVAL);
>>> +    }
>>> +
>>> +    return (-EINVAL);
>>> +
>>> +} /* static int ltc2945_read_raw */
>>> +
>>> +/* set the value of the shunt resistor in uOhm */
>>> +static int set_shunt_resistor(struct ltc2945_data *chip, unsigned int val)
>>> +{
>>> +    chip->shunt_resistor = val;
>>> +    return (0);
>>> +} /* static int set_shunt_resistor */
>>> +
>>> +static ssize_t ltc2945_shunt_resistor_show(struct device *dev,
>>> +                      struct device_attribute *attr,
>>> +                      char *buf)
>>> +{
>>> +    struct ltc2945_data *chip = iio_priv(dev_to_iio_dev(dev));
>>> +    return sprintf(buf, "%d\n", chip->shunt_resistor);
>>> +} /* static ssize_t ltc2945_shunt_resistor_show */
>>> +
>>> +static ssize_t ltc2945_shunt_resistor_store(struct device *dev,
>>> +                       struct device_attribute *attr,
>>> +                       const char *buf, size_t len)
>>> +{
>>> +    struct ltc2945_data *chip = iio_priv(dev_to_iio_dev(dev));
>>> +    unsigned long val;
>>> +    int ret;
>>> +
>>> +    ret = kstrtoul((const char *) buf, 10, &val);
>>> +
>>> +    if (ret)
>>> +        return (ret);
>>> +
>>> +    ret = set_shunt_resistor(chip, val);
>>> +
>>> +    if (ret)
>>> +        return (ret);
>>> +
>>> +    return (len);
>>> +} /* static ssize_t ltc2945_shunt_resistor_store */
>>> +
>>> +#define LTC2945_CHAN_RAW(_type, _index, _address) { \
>>> +    .type = (_type), \
>>> +    .address = (_address), \
>>> +    .indexed = 1, \
>>> +    .channel = (_index), \
>>> +    .info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>>> +}
>>> +
>>> +#define LTC2945_CHAN_PROCESSED(_type, _index, _address) { \
>>> +    .type = (_type), \
>>> +    .address = (_address), \
>>> +    .indexed = 1, \
>>> +    .channel = (_index), \
>>> +    .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
>>> +}
>>> +
>>> +static const struct iio_chan_spec ltc2945_channels[] = {
>>> +    LTC2945_CHAN_PROCESSED(IIO_VOLTAGE, 1, LTC2945_VIN_H),
>>> +    LTC2945_CHAN_PROCESSED(IIO_VOLTAGE, 2, LTC2945_ADIN_H),
>>> +    LTC2945_CHAN_PROCESSED(IIO_POWER, 1, LTC2945_POWER_H),
>>> +    LTC2945_CHAN_PROCESSED(IIO_CURRENT, 1, LTC2945_SENSE_H),
>>> +};
>>> +
>>> +
>>> +static IIO_DEVICE_ATTR(
>>> +    in_shunt_resistor,
>>> +    S_IRUGO | S_IWUSR,
>>> +    ltc2945_shunt_resistor_show,
>>> +    ltc2945_shunt_resistor_store,
>>> +    0
>>> +);
>>> +
>>> +static struct attribute *ltc2945_attributes[] = {
>>> +    &iio_dev_attr_in_shunt_resistor.dev_attr.attr,
>>> +    NULL,
>>> +};
>>> +
>>> +static const struct attribute_group ltc2945_attribute_group = {
>>> +    .attrs = ltc2945_attributes,
>>> +};
>>> +
>>> +
>>> +static const struct regmap_config ltc2945_regmap_config = {
>>> +    .reg_bits = 8,
>>> +    .val_bits = 8,
>>> +    .max_register = LTC2945_MIN_ADIN_THRES_L,
>>> +};
>>> +
>>> +
>>> +static const struct iio_info ltc2945_info = {
>>> +    .read_raw = &ltc2945_read_raw,
>>> +    .attrs = &ltc2945_attribute_group,
>>> +};
>>> +
>>> +
>>> +static int ltc2945_probe(struct i2c_client *client,
>>> +               const struct i2c_device_id *id)
>>> +{
>>> +    int ret;
>>> +    struct ltc2945_data *dev_data;
>>> +    struct iio_dev *indio_dev;
>>> +
>>> +    if (!i2c_check_functionality(client->adapter,
>>> +                I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
>>> +                I2C_FUNC_SMBUS_WRITE_BYTE |
>>> +                I2C_FUNC_SMBUS_READ_I2C_BLOCK))
>>> +        return -EOPNOTSUPP;
>>> +
>>> +    indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
>>> +
>>> +    if (!indio_dev)
>>> +        return -ENOMEM;
>>> +
>>> +    dev_data = iio_priv(indio_dev);
>>> +
>>> +    dev_data->client = client;
>>> +    mutex_init(&dev_data->lock);
>>> +
>>> +    dev_data->regmap = devm_regmap_init_i2c(client, &ltc2945_regmap_config);
>>> +
>>> +    if (IS_ERR(dev_data->regmap))
>>> +        return (PTR_ERR(dev_data->regmap));
>>> +
>>> +    ret = set_shunt_resistor(dev_data, DEFAULT_SHUNT_RESISTOR);
>>> +
>>> +    if (ret)
>>> +        return (ret);
>>> +
>>> +    /* Clear faults */
>>> +    regmap_write(dev_data->regmap, LTC2945_FAULT, 0x00);
>>> +
>>> +    indio_dev->info = &ltc2945_info;
>>> +    indio_dev->name = id->name;
>>> +    indio_dev->dev.parent = &client->dev;
>>> +    indio_dev->modes = INDIO_DIRECT_MODE;
>>> +    indio_dev->channels = ltc2945_channels;
>>> +    indio_dev->num_channels = ARRAY_SIZE(ltc2945_channels);
>>> +
>>> +    /* This is only used for device removal purposes. */
>>> +    i2c_set_clientdata(client, indio_dev);
>>> +
>>> +    return devm_iio_device_register(&client->dev, indio_dev);
>>> +} /* static int ltc2945_probe */
>>> +
>>> +
>>> +static const struct i2c_device_id ltc2945_id[] = {
>>> +    {"ltc2945_iio", 0},
>>> +    {}
>>> +};
>>> +MODULE_DEVICE_TABLE(i2c, ltc2945_id);
>>> +
>>> +
>>> +static struct i2c_driver ltc2945_driver = {
>>> +    .probe = ltc2945_probe,
>>> +    .id_table = ltc2945_id,
>>> +    .driver = {
>>> +        .name = "ltc2945_iio",
>>> +    },
>>> +};
>>> +
>>> +module_i2c_driver(ltc2945_driver);
>>> +
>>> +
>>> +MODULE_AUTHOR("Pascal Bouwmann<bouwmann@tau-tec.de>");
>>> +MODULE_DESCRIPTION("Linear Technology LTC2945 driver");
>>> +MODULE_LICENSE("GPL");
>>>
>>>
> 

