Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B376571D
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2019 14:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfGKMkT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Jul 2019 08:40:19 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:35012 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbfGKMkT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 11 Jul 2019 08:40:19 -0400
Received: from [192.168.178.170] (pD95EF75A.dip0.t-ipconnect.de [217.94.247.90])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 068F1292152;
        Thu, 11 Jul 2019 12:36:52 +0000 (UTC)
Subject: Re: [PATCH 2/2] iio: add driver for PCT2075 temperature sensor
To:     Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Jean Delvare <jdelvare@suse.com>
References: <20190701180158.9463-1-daniel@zonque.org>
 <20190701180158.9463-2-daniel@zonque.org>
 <20190707135449.000010b9@huawei.com>
 <5e3904a6-07d9-dc79-6799-c775174c65d0@roeck-us.net>
From:   Daniel Mack <daniel@zonque.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel@zonque.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1b556e89-ab32-163c-04f4-a20c46a157ca@zonque.org>
Date:   Thu, 11 Jul 2019 14:40:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5e3904a6-07d9-dc79-6799-c775174c65d0@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Guenter,
Hi Jonathan,

Thanks for pointing this out. I wasn't aware of the similarity between
this device and the LM75. I'll respin this a patch for hwmon then.


Best regards,
Daniel


On 8/7/2019 5:49 AM, Guenter Roeck wrote:
> On 7/7/19 5:54 AM, Jonathan Cameron wrote:
>>
>> +CC Jean and Guenter (the hwmon maintainers)
>>
>> On Mon, 1 Jul 2019 20:01:58 +0200
>> Daniel Mack <daniel@zonque.org> wrote:
>>
>>> This patch adds a driver for NXP PCT2075 temperature sensors, connected
>>> via I2C.
>>>
>>> The datasheet for this part is here:
>>>
>>>   https://www.nxp.com/docs/en/data-sheet/PCT2075.pdf
>>>
>>> All hardware configuration options are accessible via DT properites.
>>>
>>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>> Hi Daniel,
>>
>> My main concern with this one is whether IIO is the most suitable place to
>> put the driver.  Whilst the iio-hwmon bridge can be used to allow
>> a generic temperature sensor with an IIO driver to be used for hardware
>> monitoring, some devices are designed for that application so should
>> just be given hwmon drivers in the first place.
>>
>> What made you propose an IIO driver for this one?
>>
>> "I2C-bus Fm+, 1C accuracy, digital temperature sensor and
>> thermal watchdog" definitely sounds like a hardware monitoring device.
>>
>> Note that the temp sensors in IIO fall into a few existing categories
>> 1) Temperatures sensors that are definitely not commonly used for hardware
>> monitoring. This includes things like non contact infrared thermal sensors.
>> 2) Temperature sensors that form part of device that includes other sensors
>> or ADC channels that aren't meant for hardware monitoring (perhaps an
>> air pressure sensor).
>> 3) A few odd corner cases where the interface is the same as a part with
>> other non hmwon channels, but that part isn't present for a particular
>> part (these are rare!)
>>
> 
> On top of that, unless I am missing something, the chip is compatible with
> lm75. Extending the existing lm75 hwmon driver should only require a few
> lines of code. Writing a duplicate of the lm75 driver in iio really doesn't
> make sense to me, an even less less so under some pretty much unknown name.
> 
> Guenter
> 
>> Sorry for the slow response, I'm traveling at the moment.
>>
>> Jonathan
>>
>>> ---
>>>   drivers/iio/temperature/Kconfig   |  11 ++
>>>   drivers/iio/temperature/Makefile  |   1 +
>>>   drivers/iio/temperature/pct2075.c | 307 ++++++++++++++++++++++++++++++
>>>   3 files changed, 319 insertions(+)
>>>   create mode 100644 drivers/iio/temperature/pct2075.c
>>>
>>> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
>>> index c185cbee25c7..20aeb4c764b7 100644
>>> --- a/drivers/iio/temperature/Kconfig
>>> +++ b/drivers/iio/temperature/Kconfig
>>> @@ -55,6 +55,17 @@ config MLX90632
>>>   	  This driver can also be built as a module. If so, the module will
>>>   	  be called mlx90632.
>>>   
>>> +config PCT2075
>>> +	tristate "NXP PCT2075 temperature sensor"
>>> +	depends on I2C
>>> +	help
>>> +	  If you say yes here you get support for the NXP
>>> +	  NCP2075 I2C connected Fm+ digital temperature sensor and
>>> +	  thermal watchdog.
>>> +
>>> +	  This driver can also be built as a module. If so, the module will
>>> +	  be called pct2075.
>>> +
>>>   config TMP006
>>>   	tristate "TMP006 infrared thermopile sensor"
>>>   	depends on I2C
>>> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
>>> index baca4776ca0d..7fad51b8be4f 100644
>>> --- a/drivers/iio/temperature/Makefile
>>> +++ b/drivers/iio/temperature/Makefile
>>> @@ -8,6 +8,7 @@ obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
>>>   obj-$(CONFIG_MAX31856) += max31856.o
>>>   obj-$(CONFIG_MLX90614) += mlx90614.o
>>>   obj-$(CONFIG_MLX90632) += mlx90632.o
>>> +obj-$(CONFIG_PCT2075) += pct2075.o
>>>   obj-$(CONFIG_TMP006) += tmp006.o
>>>   obj-$(CONFIG_TMP007) += tmp007.o
>>>   obj-$(CONFIG_TSYS01) += tsys01.o
>>> diff --git a/drivers/iio/temperature/pct2075.c b/drivers/iio/temperature/pct2075.c
>>> new file mode 100644
>>> index 000000000000..e2a092079905
>>> --- /dev/null
>>> +++ b/drivers/iio/temperature/pct2075.c
>>> @@ -0,0 +1,307 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/i2c.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/sysfs.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/regulator/consumer.h>
>>> +
>>> +#define PCT2075_REG_CONF	1
>>> +#define		PCT2075_CONF_OS_F_QUEUE(val) (((val) & 0x3) << 3)
>>> +#define		PCT2075_CONF_OS_ACTIVE_HIGH	BIT(2)
>>> +#define		PCT2075_CONF_OS_COMP_INT	BIT(1)
>>> +#define		PCT2075_CONF_SHUTDOWN		BIT(0)
>>> +
>>> +#define PCT2075_REG_TEMP	0
>>> +#define PCT2075_REG_THYST	2
>>> +#define PCT2075_REG_TOS		3
>>> +#define PCT2075_REG_TIDLE	4
>>> +
>>> +struct pct2075_data {
>>> +	struct i2c_client *client;
>>> +	struct regulator *regulator;
>>> +	u8 reg_conf;
>>> +	u8 reg_tidle;
>>> +	u16 reg_thyst;
>>> +	u16 reg_tos;
>>> +};
>>> +
>>> +static const struct iio_chan_spec pct2075_channel = {
>>> +	.type = IIO_TEMP,
>>> +	.channel = IIO_MOD_TEMP_AMBIENT,
>>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>>> +};
>>> +
>>> +static int pct2075_read_raw(struct iio_dev *indio_dev,
>>> +			    struct iio_chan_spec const *chan,
>>> +			    int *val,
>>> +			    int *val2,
>>> +			    long mask)
>>> +{
>>> +	struct pct2075_data *pct2075 = iio_priv(indio_dev);
>>> +	int ret, v;
>>> +
>>> +	ret = i2c_smbus_read_word_swapped(pct2075->client,
>>> +					  PCT2075_REG_TEMP);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	v = sign_extend32(ret >> 5, 10) * 125;
>>> +	*val = v / 1000;
>>> +	*val2 = (v % 1000) * 1000;
>>> +
>>> +	return IIO_VAL_INT_PLUS_MICRO;
>>> +}
>>> +
>>> +static int pct2075_sync(struct pct2075_data *pct2075)
>>> +{
>>> +	struct i2c_client *client = pct2075->client;
>>> +	struct device *dev = &client->dev;
>>> +	int ret;
>>> +
>>> +	ret = i2c_smbus_write_byte_data(client, PCT2075_REG_CONF,
>>> +					pct2075->reg_conf);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "Cannot write CONF register: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = i2c_smbus_write_byte_data(client, PCT2075_REG_TIDLE,
>>> +					pct2075->reg_tidle);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "Cannot write TIDLE register: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = i2c_smbus_write_word_swapped(client, PCT2075_REG_TOS,
>>> +					   pct2075->reg_tos);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "Cannot write TOS register: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = i2c_smbus_write_word_swapped(client, PCT2075_REG_THYST,
>>> +					   pct2075->reg_thyst);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "Cannot write THYST register: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void pct2075_of_parse_temperature(struct device *dev,
>>> +					 u16 *out, const char *name)
>>> +{
>>> +	int ret;
>>> +	s32 tmp;
>>> +
>>> +	ret = of_property_read_s32(dev->of_node, name, &tmp);
>>> +	if (ret != 0)
>>> +		return;
>>> +
>>> +	if (tmp < -55000 || tmp > 125000 || tmp % 500 != 0) {
>>> +		dev_err(dev, "Unsupported value for %s", name);
>>> +		return;
>>> +	}
>>> +
>>> +	*out = ((u16) (tmp / 500)) << 7;
>>> +}
>>> +
>>> +static const struct iio_info pct2075_info = {
>>> +	.read_raw = pct2075_read_raw,
>>> +};
>>> +
>>> +static int pct2075_probe(struct i2c_client *client,
>>> +			 const struct i2c_device_id *id)
>>> +{
>>> +	struct device *dev = &client->dev;
>>> +	struct pct2075_data *pct2075;
>>> +	struct iio_dev *indio_dev;
>>> +	u32 tmp;
>>> +	int ret;
>>> +
>>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*pct2075));
>>> +	if (!indio_dev) {
>>> +		dev_err(&client->dev, "Failed to allocate device\n");
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	pct2075 = iio_priv(indio_dev);
>>> +	i2c_set_clientdata(client, indio_dev);
>>> +	pct2075->client = client;
>>> +
>>> +	indio_dev->dev.parent = dev;
>>> +	indio_dev->name = id->name;
>>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>>> +	indio_dev->info = &pct2075_info;
>>> +	indio_dev->channels = &pct2075_channel;
>>> +	indio_dev->num_channels = 1;
>>> +
>>> +	pct2075->regulator = devm_regulator_get_optional(dev, "vcc");
>>> +	if (IS_ERR(pct2075->regulator)) {
>>> +		ret = PTR_ERR(pct2075->regulator);
>>> +		if (ret == -EPROBE_DEFER)
>>> +			return ret;
>>> +
>>> +		pct2075->regulator = NULL;
>>> +	}
>>> +
>>> +	if (pct2075->regulator) {
>>> +		ret = regulator_enable(pct2075->regulator);
>>> +		if (ret < 0) {
>>> +			dev_err(dev, "Cannot enable regulator: %d\n", ret);
>>> +			return ret;
>>> +		}
>>> +	}
>>> +
>>> +	/* Read hardware defaults */
>>> +	ret = i2c_smbus_read_word_swapped(client, PCT2075_REG_TOS);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "Cannot read TOS register: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +	pct2075->reg_tos = ret;
>>> +
>>> +	ret = i2c_smbus_read_word_swapped(client, PCT2075_REG_THYST);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "Cannot read THYST register: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +	pct2075->reg_thyst = ret;
>>> +
>>> +	ret = i2c_smbus_read_byte_data(client, PCT2075_REG_TIDLE);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "Cannot read TIDLE register: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +	pct2075->reg_tidle = ret;
>>> +
>>> +	/* Parse DT properties */
>>> +	ret = of_property_read_u32(dev->of_node, "nxp,os-fault-queue", &tmp);
>>> +	if (ret == 0) {
>>> +		switch (tmp) {
>>> +		case 1:
>>> +			pct2075->reg_conf |= PCT2075_CONF_OS_F_QUEUE(0);
>>> +			break;
>>> +		case 2:
>>> +			pct2075->reg_conf |= PCT2075_CONF_OS_F_QUEUE(1);
>>> +			break;
>>> +		case 4:
>>> +			pct2075->reg_conf |= PCT2075_CONF_OS_F_QUEUE(2);
>>> +			break;
>>> +		case 6:
>>> +			pct2075->reg_conf |= PCT2075_CONF_OS_F_QUEUE(3);
>>> +			break;
>>> +		default:
>>> +			dev_err(dev, "Unsupported value for nxp,os-fault-queue");
>>> +		}
>>> +	}
>>> +
>>> +	if (of_property_read_bool(dev->of_node, "nxp,os-active-high"))
>>> +		pct2075->reg_conf |= PCT2075_CONF_OS_ACTIVE_HIGH;
>>> +
>>> +	if (of_property_read_bool(dev->of_node, "nxp,os-mode-interrupt"))
>>> +		pct2075->reg_conf |= PCT2075_CONF_OS_COMP_INT;
>>> +
>>> +	ret = of_property_read_u32(dev->of_node, "nxp,sample-period-ms", &tmp);
>>> +	if (ret == 0) {
>>> +		if (tmp % 100 == 0 && tmp <= 3100)
>>> +			pct2075->reg_tidle = tmp / 100;
>>> +		else
>>> +			dev_err(dev, "Unsupported value for nxp,sample-period-ms");
>>> +	}
>>> +
>>> +	pct2075_of_parse_temperature(dev, &pct2075->reg_tos,
>>> +				     "nxp,overtemperature-shutdown-millicelsius");
>>> +	pct2075_of_parse_temperature(dev, &pct2075->reg_thyst,
>>> +				     "nxp,hysteresis-millicelsius");
>>> +
>>> +	ret = pct2075_sync(pct2075);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	pm_runtime_disable(dev);
>>> +	ret = pm_runtime_set_active(dev);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	pm_runtime_enable(&client->dev);
>>> +	pm_runtime_set_autosuspend_delay(dev, 10);
>>> +	pm_runtime_use_autosuspend(dev);
>>> +
>>> +	return iio_device_register(indio_dev);
>>> +}
>>> +
>>> +static int pct2075_remove(struct i2c_client *client)
>>> +{
>>> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>> +	struct pct2075_data *pct2075 = iio_priv(indio_dev);
>>> +	struct device *dev = &client->dev;
>>> +
>>> +	i2c_smbus_write_byte_data(client, PCT2075_REG_CONF,
>>> +				  PCT2075_CONF_SHUTDOWN);
>>> +
>>> +	if (pct2075->regulator)
>>> +		regulator_disable(pct2075->regulator);
>>> +
>>> +	iio_device_unregister(indio_dev);
>>> +
>>> +	pm_runtime_disable(dev);
>>> +	pm_runtime_set_suspended(dev);
>>> +	pm_runtime_put_noidle(dev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct i2c_device_id pct2075_id[] = {
>>> +	{ "pct2075", 0 },
>>> +	{ }
>>> +};
>>> +MODULE_DEVICE_TABLE(i2c, pct2075_id);
>>> +
>>> +static const struct of_device_id pct2075_of_match[] = {
>>> +	{ .compatible = "nxp,pct2075" },
>>> +	{ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, pct2075_of_match);
>>> +
>>> +static int __maybe_unused pct2075_pm_suspend(struct device *dev)
>>> +{
>>> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>>> +	struct pct2075_data *pct2075 = iio_priv(indio_dev);
>>> +
>>> +	return i2c_smbus_write_byte_data(pct2075->client, PCT2075_REG_CONF,
>>> +					 PCT2075_CONF_SHUTDOWN);
>>> +}
>>> +
>>> +static int __maybe_unused pct2075_pm_resume(struct device *dev)
>>> +{
>>> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>>> +	struct pct2075_data *pct2075 = iio_priv(indio_dev);
>>> +
>>> +	return pct2075_sync(pct2075);
>>> +}
>>> +
>>> +static UNIVERSAL_DEV_PM_OPS(pct2075_pm_ops, pct2075_pm_suspend,
>>> +			    pct2075_pm_resume, NULL);
>>> +
>>> +static struct i2c_driver pct2075_driver = {
>>> +	.driver = {
>>> +		.name	= "pct2075",
>>> +		.of_match_table = pct2075_of_match,
>>> +		.pm	= &pct2075_pm_ops,
>>> +	},
>>> +	.probe = pct2075_probe,
>>> +	.remove = pct2075_remove,
>>> +	.id_table = pct2075_id,
>>> +};
>>> +module_i2c_driver(pct2075_driver);
>>> +
>>> +MODULE_AUTHOR("Daniel Mack <daniel@zonque.org>");
>>> +MODULE_DESCRIPTION("NXP PCT2075 temperature sensor driver");
>>> +MODULE_LICENSE("GPL v2");
>>
>>
>>
> 

