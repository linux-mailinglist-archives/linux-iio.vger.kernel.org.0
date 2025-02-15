Return-Path: <linux-iio+bounces-15551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B3EA36EB4
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 15:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9F0169789
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FB41B532F;
	Sat, 15 Feb 2025 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="Xs87Nwkz"
X-Original-To: linux-iio@vger.kernel.org
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2523CE;
	Sat, 15 Feb 2025 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.177.23.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739628780; cv=none; b=PBKgNqgY6Mb5zizKKv9UbCgA9fTNZf8Z22s4vk14yiAQpRtJAlBdaROEFl1KyqRdV/894DO/iyOF5/zKu3FQ4gTWXlvoKp8mA1kdZc3wyOa44aCUAr8hYimrFeG89CYCVOm68NpsOIGaaL+nc296Kvz69DfulsPp1QbOsVgbQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739628780; c=relaxed/simple;
	bh=U0xKFCEJrC+Mr4BS7xANqFJUU0XLRCKnekW93NrV92k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bn3Qww6tJtCoVEHgQH4YdgDjQTL2IxKJO8EJIqe5bzibWDWYrPvYch6dXWVqAZuTshzWnqgUVMDDar/dY+7N3AqUSOE5+VinL+PrdVt31RYC38LSc6IfRdWuMdJUyqWqgUb5Mb0ZLQKKTfwTggveaw6HUmvISL80sk08ulgVlN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=Xs87Nwkz; arc=none smtp.client-ip=89.177.23.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [10.0.0.200] (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id B23A41639E7;
	Sat, 15 Feb 2025 15:12:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1739628768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3dmO342TrNpWXsF7gNwCYRAYy784U9uDerJyfnmnQJ4=;
	b=Xs87NwkzfynHqyb+GEacuvtVFnNvD7IY7n+V1v/AKEXGsgGPAiHBUNwDncF9S30SnjAXyr
	5rOmcevj3Plmn8CobL4C5jxCiGIHtpRJXS7sCTOBroTCGOJw0ORozo/ZAYkNPDMhWNJKck
	Cdku8QeTFhrW/ITiLwvHN1glEs2sjgI=
Message-ID: <1597453a-31fc-49eb-8b69-efeb8805c67a@ixit.cz>
Date: Sat, 15 Feb 2025 15:12:46 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 2/3] iio: light: Add support for AL3000a illuminance
 sensor
To: Svyatoslav Ryhel <clamor95@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Emil Gedenryd <emil.gedenryd@axis.com>,
 Arthur Becker <arthur.becker@sentec.com>,
 Mudit Sharma <muditsharma.info@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250215103159.106343-1-clamor95@gmail.com>
 <20250215103159.106343-3-clamor95@gmail.com>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20250215103159.106343-3-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/02/2025 11:31, Svyatoslav Ryhel wrote:
> AL3000a is a simple I2C-based ambient light sensor, which is
> closely related to AL3010 and AL3320a, but has significantly
> different way of processing data generated by the sensor.
> 
> Tested-by: Robert Eckelmann <longnoserob@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   drivers/iio/light/Kconfig   |  10 ++
>   drivers/iio/light/Makefile  |   1 +
>   drivers/iio/light/al3000a.c | 221 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 232 insertions(+)
>   create mode 100644 drivers/iio/light/al3000a.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index e34e551eef3e..142f7f7ef0ec 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -43,6 +43,16 @@ config ADUX1020
>   	 To compile this driver as a module, choose M here: the
>   	 module will be called adux1020.
>   
> +config AL3000A
> +	tristate "AL3000a ambient light sensor"
> +	depends on I2C
> +	help
> +	  Say Y here if you want to build a driver for the Dyna Image AL3000a
> +	  ambient light sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called al3000a.
> +
>   config AL3010
>   	tristate "AL3010 ambient light sensor"
>   	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 11a4041b918a..17030a4cc340 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -7,6 +7,7 @@
>   obj-$(CONFIG_ACPI_ALS)		+= acpi-als.o
>   obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
>   obj-$(CONFIG_ADUX1020)		+= adux1020.o
> +obj-$(CONFIG_AL3000A)		+= al3000a.o
>   obj-$(CONFIG_AL3010)		+= al3010.o
>   obj-$(CONFIG_AL3320A)		+= al3320a.o
>   obj-$(CONFIG_APDS9300)		+= apds9300.o
> diff --git a/drivers/iio/light/al3000a.c b/drivers/iio/light/al3000a.c
> new file mode 100644
> index 000000000000..58d4336dd081
> --- /dev/null
> +++ b/drivers/iio/light/al3000a.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define AL3000A_DRV_NAME		"al3000a"
> +#define AL3000A_REG_SYSTEM		0x00
> +#define AL3000A_REG_DATA		0x05
> +
> +#define AL3000A_CONFIG_ENABLE		0x00
> +#define AL3000A_CONFIG_DISABLE		0x0b
> +#define AL3000A_CONFIG_RESET		0x0f
> +#define AL3000A_GAIN_MASK		GENMASK(5, 0)
> +
> +/*
> + * This are pre-calculated lux values based on possible output of sensor
> + * (range 0x00 - 0x3F)
> + */
> +static const u32 lux_table[] = {
> +	1, 1, 1, 2, 2, 2, 3, 4,					/* 0 - 7 */
> +	4, 5, 6, 7, 9, 11, 13, 16,				/* 8 - 15 */
> +	19, 22, 27, 32, 39, 46, 56, 67,				/* 16 - 23 */
> +	80, 96, 116, 139, 167, 200, 240, 289,			/* 24 - 31 */
> +	347, 416, 499, 600, 720, 864, 1037, 1245,		/* 32 - 39 */
> +	1495, 1795, 2155, 2587, 3105, 3728, 4475, 5373,		/* 40 - 47 */
> +	6450, 7743, 9296, 11160, 13397, 16084, 19309, 23180,	/* 48 - 55 */
> +	27828, 33408, 40107, 48148, 57803, 69393, 83306, 100000 /* 56 - 63 */
> +};
> +
> +static const struct regmap_config al3000a_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = AL3000A_REG_DATA,
> +};
> +
> +struct al3000a_data {
> +	struct regmap *regmap;
> +	struct regulator *vdd_supply;
> +};
> +
> +static const struct iio_chan_spec al3000a_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +
> +static int al3000a_set_pwr(struct al3000a_data *data, bool pwr)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	u8 val = pwr ? AL3000A_CONFIG_ENABLE : AL3000A_CONFIG_DISABLE;
> +	int ret;
> +
> +	if (pwr) {
> +		ret = regulator_enable(data->vdd_supply);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to enable vdd power supply\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, val);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to write system register\n");
> +		return ret;
> +	}
> +
> +	if (!pwr) {
> +		ret = regulator_disable(data->vdd_supply);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to disable vdd power supply\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void al3000a_set_pwr_off(void *_data)
> +{
> +	struct al3000a_data *data = _data;
> +
> +	al3000a_set_pwr(data, false);
> +}
> +
> +static int al3000a_init(struct al3000a_data *data)
> +{
> +	int ret;
> +
> +	ret = al3000a_set_pwr(data, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_RESET);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_ENABLE);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int al3000a_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct al3000a_data *data = iio_priv(indio_dev);
> +	int ret, gain;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(data->regmap, AL3000A_REG_DATA, &gain);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = lux_table[gain & AL3000A_GAIN_MASK];

Why did you chosen to do post-processing in the RAW channel instead 
doing it in INFO_SCALE (same as al3010 does)?

Except this, LGTM.

Documentation and DT patch:

Reviewed-by: David Heidelberg <david@ixit.cz>
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info al3000a_info = {
> +	.read_raw	= al3000a_read_raw,
> +};
> +
> +static int al3000a_probe(struct i2c_client *client)
> +{
> +	struct al3000a_data *data;
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &al3000a_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "cannot allocate regmap\n");
> +
> +	data->vdd_supply = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(data->vdd_supply))
> +		return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
> +				     "failed to get vdd regulator\n");
> +
> +	indio_dev->info = &al3000a_info;
> +	indio_dev->name = AL3000A_DRV_NAME;
> +	indio_dev->channels = al3000a_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(al3000a_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = al3000a_init(data);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to init ALS\n");
> +
> +	ret = devm_add_action_or_reset(dev, al3000a_set_pwr_off, data);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to add action\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static int al3000a_suspend(struct device *dev)
> +{
> +	struct al3000a_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	return al3000a_set_pwr(data, false);
> +}
> +
> +static int al3000a_resume(struct device *dev)
> +{
> +	struct al3000a_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	return al3000a_set_pwr(data, true);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(al3000a_pm_ops, al3000a_suspend, al3000a_resume);
> +
> +static const struct of_device_id al3000a_of_match[] = {
> +	{ .compatible = "dynaimage,al3000a" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, al3000a_of_match);
> +
> +static struct i2c_driver al3000a_driver = {
> +	.driver = {
> +		.name = AL3000A_DRV_NAME,
> +		.of_match_table = al3000a_of_match,
> +		.pm = pm_sleep_ptr(&al3000a_pm_ops),
> +	},
> +	.probe = al3000a_probe,
> +};
> +module_i2c_driver(al3000a_driver);
> +
> +MODULE_AUTHOR("Svyatolsav Ryhel <clamor95@gmail.com>");
> +MODULE_DESCRIPTION("al3000a Ambient Light Sensor driver");
> +MODULE_LICENSE("GPL");

-- 
David Heidelberg


