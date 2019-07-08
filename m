Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E2261995
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2019 05:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfGHDty (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jul 2019 23:49:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41347 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfGHDtx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jul 2019 23:49:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id q4so6936757pgj.8;
        Sun, 07 Jul 2019 20:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wlsWE2sBshBJN2G3QjJ7riXPImdr5euvnFvQcVEqoj0=;
        b=sVisJhC7AQNz4TxWOi+2CJ+Q8MeTNXt8lIbTFtRY6ofeFlU+QVGTRUdHJ1zXrtp/H0
         VZwYPrJrFngIL2fl5NL4tbhd0JN00yF2yRvtHUG8lKpYXN1BqYWYpAg2AdP6NqOgZslS
         /M+G/cUvRlwPjeZkmJM2W62AnUvPyj5lWUxYWX9sS6XcFlHOfF0BkmXF90Zk1HxwoWAU
         tfPTL/1Mevrc0GY0QsG/0ef4LWA6yTQIDCVtrt9N6zKu/fHvZIsrKOXeAEDOLIc11UM4
         mikLt4AXM3HyKtRGvt6GqsG4fhlVgA0UO8eiD1taLx2jo+njbID1HqUySCj1ryu7xB8K
         2MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wlsWE2sBshBJN2G3QjJ7riXPImdr5euvnFvQcVEqoj0=;
        b=tzyW6pq8O8K9VxwYBoH6O5DPsf1ldb+lcZ1GDQiTkSgaf1MaQdBW2mL7uGjnEqpb6G
         pIMuvTXl0dveAGyebV1PSQJaVQNviLr8qM6KMMoanz8WRZCcmydkMh7Y4ODySOCg7dKm
         S5UZ3Ftg8q/LvpqBoZr6rZIdjNdeqILR4PbbYE/sLar4WHYiBEQX4AMkOR7GxuKEmL4n
         rYAplIETr4/aCF6tbrPsIufe7OFBe96/F12F6fgpaLi2BuoAb8L9cSCYioSGDBcUbKXL
         2WF6u496ItSiPkHrI+9anhBrwaVO7tuWj6ykGvkh8Me5zvV+a68Lo33/Fhkf/LL4DBUH
         gpCQ==
X-Gm-Message-State: APjAAAXamOPRUBOyv1Jn4C0iiA9czyb/ExVTAgbFyO1jRnI/P15tgQrd
        JOulKVzJT4LJzNO/Psrkzsg=
X-Google-Smtp-Source: APXvYqznI31Uy34+0qQdECAP540BmK/CTUwt0X9y4opVHcsvOtQXTDMOtyIdXbGWAYidsdjj3SP8jg==
X-Received: by 2002:a17:90a:bf03:: with SMTP id c3mr21180794pjs.112.1562557792922;
        Sun, 07 Jul 2019 20:49:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 196sm17197959pfy.167.2019.07.07.20.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 20:49:51 -0700 (PDT)
Subject: Re: [PATCH 2/2] iio: add driver for PCT2075 temperature sensor
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Daniel Mack <daniel@zonque.org>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Jean Delvare <jdelvare@suse.com>
References: <20190701180158.9463-1-daniel@zonque.org>
 <20190701180158.9463-2-daniel@zonque.org>
 <20190707135449.000010b9@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5e3904a6-07d9-dc79-6799-c775174c65d0@roeck-us.net>
Date:   Sun, 7 Jul 2019 20:49:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707135449.000010b9@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/7/19 5:54 AM, Jonathan Cameron wrote:
> 
> +CC Jean and Guenter (the hwmon maintainers)
> 
> On Mon, 1 Jul 2019 20:01:58 +0200
> Daniel Mack <daniel@zonque.org> wrote:
> 
>> This patch adds a driver for NXP PCT2075 temperature sensors, connected
>> via I2C.
>>
>> The datasheet for this part is here:
>>
>>   https://www.nxp.com/docs/en/data-sheet/PCT2075.pdf
>>
>> All hardware configuration options are accessible via DT properites.
>>
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
> Hi Daniel,
> 
> My main concern with this one is whether IIO is the most suitable place to
> put the driver.  Whilst the iio-hwmon bridge can be used to allow
> a generic temperature sensor with an IIO driver to be used for hardware
> monitoring, some devices are designed for that application so should
> just be given hwmon drivers in the first place.
> 
> What made you propose an IIO driver for this one?
> 
> "I2C-bus Fm+, 1C accuracy, digital temperature sensor and
> thermal watchdog" definitely sounds like a hardware monitoring device.
> 
> Note that the temp sensors in IIO fall into a few existing categories
> 1) Temperatures sensors that are definitely not commonly used for hardware
> monitoring. This includes things like non contact infrared thermal sensors.
> 2) Temperature sensors that form part of device that includes other sensors
> or ADC channels that aren't meant for hardware monitoring (perhaps an
> air pressure sensor).
> 3) A few odd corner cases where the interface is the same as a part with
> other non hmwon channels, but that part isn't present for a particular
> part (these are rare!)
> 

On top of that, unless I am missing something, the chip is compatible with
lm75. Extending the existing lm75 hwmon driver should only require a few
lines of code. Writing a duplicate of the lm75 driver in iio really doesn't
make sense to me, an even less less so under some pretty much unknown name.

Guenter

> Sorry for the slow response, I'm traveling at the moment.
> 
> Jonathan
> 
>> ---
>>   drivers/iio/temperature/Kconfig   |  11 ++
>>   drivers/iio/temperature/Makefile  |   1 +
>>   drivers/iio/temperature/pct2075.c | 307 ++++++++++++++++++++++++++++++
>>   3 files changed, 319 insertions(+)
>>   create mode 100644 drivers/iio/temperature/pct2075.c
>>
>> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
>> index c185cbee25c7..20aeb4c764b7 100644
>> --- a/drivers/iio/temperature/Kconfig
>> +++ b/drivers/iio/temperature/Kconfig
>> @@ -55,6 +55,17 @@ config MLX90632
>>   	  This driver can also be built as a module. If so, the module will
>>   	  be called mlx90632.
>>   
>> +config PCT2075
>> +	tristate "NXP PCT2075 temperature sensor"
>> +	depends on I2C
>> +	help
>> +	  If you say yes here you get support for the NXP
>> +	  NCP2075 I2C connected Fm+ digital temperature sensor and
>> +	  thermal watchdog.
>> +
>> +	  This driver can also be built as a module. If so, the module will
>> +	  be called pct2075.
>> +
>>   config TMP006
>>   	tristate "TMP006 infrared thermopile sensor"
>>   	depends on I2C
>> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
>> index baca4776ca0d..7fad51b8be4f 100644
>> --- a/drivers/iio/temperature/Makefile
>> +++ b/drivers/iio/temperature/Makefile
>> @@ -8,6 +8,7 @@ obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
>>   obj-$(CONFIG_MAX31856) += max31856.o
>>   obj-$(CONFIG_MLX90614) += mlx90614.o
>>   obj-$(CONFIG_MLX90632) += mlx90632.o
>> +obj-$(CONFIG_PCT2075) += pct2075.o
>>   obj-$(CONFIG_TMP006) += tmp006.o
>>   obj-$(CONFIG_TMP007) += tmp007.o
>>   obj-$(CONFIG_TSYS01) += tsys01.o
>> diff --git a/drivers/iio/temperature/pct2075.c b/drivers/iio/temperature/pct2075.c
>> new file mode 100644
>> index 000000000000..e2a092079905
>> --- /dev/null
>> +++ b/drivers/iio/temperature/pct2075.c
>> @@ -0,0 +1,307 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +#define PCT2075_REG_CONF	1
>> +#define		PCT2075_CONF_OS_F_QUEUE(val) (((val) & 0x3) << 3)
>> +#define		PCT2075_CONF_OS_ACTIVE_HIGH	BIT(2)
>> +#define		PCT2075_CONF_OS_COMP_INT	BIT(1)
>> +#define		PCT2075_CONF_SHUTDOWN		BIT(0)
>> +
>> +#define PCT2075_REG_TEMP	0
>> +#define PCT2075_REG_THYST	2
>> +#define PCT2075_REG_TOS		3
>> +#define PCT2075_REG_TIDLE	4
>> +
>> +struct pct2075_data {
>> +	struct i2c_client *client;
>> +	struct regulator *regulator;
>> +	u8 reg_conf;
>> +	u8 reg_tidle;
>> +	u16 reg_thyst;
>> +	u16 reg_tos;
>> +};
>> +
>> +static const struct iio_chan_spec pct2075_channel = {
>> +	.type = IIO_TEMP,
>> +	.channel = IIO_MOD_TEMP_AMBIENT,
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>> +};
>> +
>> +static int pct2075_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int *val,
>> +			    int *val2,
>> +			    long mask)
>> +{
>> +	struct pct2075_data *pct2075 = iio_priv(indio_dev);
>> +	int ret, v;
>> +
>> +	ret = i2c_smbus_read_word_swapped(pct2075->client,
>> +					  PCT2075_REG_TEMP);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	v = sign_extend32(ret >> 5, 10) * 125;
>> +	*val = v / 1000;
>> +	*val2 = (v % 1000) * 1000;
>> +
>> +	return IIO_VAL_INT_PLUS_MICRO;
>> +}
>> +
>> +static int pct2075_sync(struct pct2075_data *pct2075)
>> +{
>> +	struct i2c_client *client = pct2075->client;
>> +	struct device *dev = &client->dev;
>> +	int ret;
>> +
>> +	ret = i2c_smbus_write_byte_data(client, PCT2075_REG_CONF,
>> +					pct2075->reg_conf);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Cannot write CONF register: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = i2c_smbus_write_byte_data(client, PCT2075_REG_TIDLE,
>> +					pct2075->reg_tidle);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Cannot write TIDLE register: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = i2c_smbus_write_word_swapped(client, PCT2075_REG_TOS,
>> +					   pct2075->reg_tos);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Cannot write TOS register: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = i2c_smbus_write_word_swapped(client, PCT2075_REG_THYST,
>> +					   pct2075->reg_thyst);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Cannot write THYST register: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void pct2075_of_parse_temperature(struct device *dev,
>> +					 u16 *out, const char *name)
>> +{
>> +	int ret;
>> +	s32 tmp;
>> +
>> +	ret = of_property_read_s32(dev->of_node, name, &tmp);
>> +	if (ret != 0)
>> +		return;
>> +
>> +	if (tmp < -55000 || tmp > 125000 || tmp % 500 != 0) {
>> +		dev_err(dev, "Unsupported value for %s", name);
>> +		return;
>> +	}
>> +
>> +	*out = ((u16) (tmp / 500)) << 7;
>> +}
>> +
>> +static const struct iio_info pct2075_info = {
>> +	.read_raw = pct2075_read_raw,
>> +};
>> +
>> +static int pct2075_probe(struct i2c_client *client,
>> +			 const struct i2c_device_id *id)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct pct2075_data *pct2075;
>> +	struct iio_dev *indio_dev;
>> +	u32 tmp;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*pct2075));
>> +	if (!indio_dev) {
>> +		dev_err(&client->dev, "Failed to allocate device\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	pct2075 = iio_priv(indio_dev);
>> +	i2c_set_clientdata(client, indio_dev);
>> +	pct2075->client = client;
>> +
>> +	indio_dev->dev.parent = dev;
>> +	indio_dev->name = id->name;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &pct2075_info;
>> +	indio_dev->channels = &pct2075_channel;
>> +	indio_dev->num_channels = 1;
>> +
>> +	pct2075->regulator = devm_regulator_get_optional(dev, "vcc");
>> +	if (IS_ERR(pct2075->regulator)) {
>> +		ret = PTR_ERR(pct2075->regulator);
>> +		if (ret == -EPROBE_DEFER)
>> +			return ret;
>> +
>> +		pct2075->regulator = NULL;
>> +	}
>> +
>> +	if (pct2075->regulator) {
>> +		ret = regulator_enable(pct2075->regulator);
>> +		if (ret < 0) {
>> +			dev_err(dev, "Cannot enable regulator: %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	/* Read hardware defaults */
>> +	ret = i2c_smbus_read_word_swapped(client, PCT2075_REG_TOS);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Cannot read TOS register: %d\n", ret);
>> +		return ret;
>> +	}
>> +	pct2075->reg_tos = ret;
>> +
>> +	ret = i2c_smbus_read_word_swapped(client, PCT2075_REG_THYST);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Cannot read THYST register: %d\n", ret);
>> +		return ret;
>> +	}
>> +	pct2075->reg_thyst = ret;
>> +
>> +	ret = i2c_smbus_read_byte_data(client, PCT2075_REG_TIDLE);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Cannot read TIDLE register: %d\n", ret);
>> +		return ret;
>> +	}
>> +	pct2075->reg_tidle = ret;
>> +
>> +	/* Parse DT properties */
>> +	ret = of_property_read_u32(dev->of_node, "nxp,os-fault-queue", &tmp);
>> +	if (ret == 0) {
>> +		switch (tmp) {
>> +		case 1:
>> +			pct2075->reg_conf |= PCT2075_CONF_OS_F_QUEUE(0);
>> +			break;
>> +		case 2:
>> +			pct2075->reg_conf |= PCT2075_CONF_OS_F_QUEUE(1);
>> +			break;
>> +		case 4:
>> +			pct2075->reg_conf |= PCT2075_CONF_OS_F_QUEUE(2);
>> +			break;
>> +		case 6:
>> +			pct2075->reg_conf |= PCT2075_CONF_OS_F_QUEUE(3);
>> +			break;
>> +		default:
>> +			dev_err(dev, "Unsupported value for nxp,os-fault-queue");
>> +		}
>> +	}
>> +
>> +	if (of_property_read_bool(dev->of_node, "nxp,os-active-high"))
>> +		pct2075->reg_conf |= PCT2075_CONF_OS_ACTIVE_HIGH;
>> +
>> +	if (of_property_read_bool(dev->of_node, "nxp,os-mode-interrupt"))
>> +		pct2075->reg_conf |= PCT2075_CONF_OS_COMP_INT;
>> +
>> +	ret = of_property_read_u32(dev->of_node, "nxp,sample-period-ms", &tmp);
>> +	if (ret == 0) {
>> +		if (tmp % 100 == 0 && tmp <= 3100)
>> +			pct2075->reg_tidle = tmp / 100;
>> +		else
>> +			dev_err(dev, "Unsupported value for nxp,sample-period-ms");
>> +	}
>> +
>> +	pct2075_of_parse_temperature(dev, &pct2075->reg_tos,
>> +				     "nxp,overtemperature-shutdown-millicelsius");
>> +	pct2075_of_parse_temperature(dev, &pct2075->reg_thyst,
>> +				     "nxp,hysteresis-millicelsius");
>> +
>> +	ret = pct2075_sync(pct2075);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	pm_runtime_disable(dev);
>> +	ret = pm_runtime_set_active(dev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	pm_runtime_enable(&client->dev);
>> +	pm_runtime_set_autosuspend_delay(dev, 10);
>> +	pm_runtime_use_autosuspend(dev);
>> +
>> +	return iio_device_register(indio_dev);
>> +}
>> +
>> +static int pct2075_remove(struct i2c_client *client)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> +	struct pct2075_data *pct2075 = iio_priv(indio_dev);
>> +	struct device *dev = &client->dev;
>> +
>> +	i2c_smbus_write_byte_data(client, PCT2075_REG_CONF,
>> +				  PCT2075_CONF_SHUTDOWN);
>> +
>> +	if (pct2075->regulator)
>> +		regulator_disable(pct2075->regulator);
>> +
>> +	iio_device_unregister(indio_dev);
>> +
>> +	pm_runtime_disable(dev);
>> +	pm_runtime_set_suspended(dev);
>> +	pm_runtime_put_noidle(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct i2c_device_id pct2075_id[] = {
>> +	{ "pct2075", 0 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, pct2075_id);
>> +
>> +static const struct of_device_id pct2075_of_match[] = {
>> +	{ .compatible = "nxp,pct2075" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, pct2075_of_match);
>> +
>> +static int __maybe_unused pct2075_pm_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	struct pct2075_data *pct2075 = iio_priv(indio_dev);
>> +
>> +	return i2c_smbus_write_byte_data(pct2075->client, PCT2075_REG_CONF,
>> +					 PCT2075_CONF_SHUTDOWN);
>> +}
>> +
>> +static int __maybe_unused pct2075_pm_resume(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	struct pct2075_data *pct2075 = iio_priv(indio_dev);
>> +
>> +	return pct2075_sync(pct2075);
>> +}
>> +
>> +static UNIVERSAL_DEV_PM_OPS(pct2075_pm_ops, pct2075_pm_suspend,
>> +			    pct2075_pm_resume, NULL);
>> +
>> +static struct i2c_driver pct2075_driver = {
>> +	.driver = {
>> +		.name	= "pct2075",
>> +		.of_match_table = pct2075_of_match,
>> +		.pm	= &pct2075_pm_ops,
>> +	},
>> +	.probe = pct2075_probe,
>> +	.remove = pct2075_remove,
>> +	.id_table = pct2075_id,
>> +};
>> +module_i2c_driver(pct2075_driver);
>> +
>> +MODULE_AUTHOR("Daniel Mack <daniel@zonque.org>");
>> +MODULE_DESCRIPTION("NXP PCT2075 temperature sensor driver");
>> +MODULE_LICENSE("GPL v2");
> 
> 
> 

