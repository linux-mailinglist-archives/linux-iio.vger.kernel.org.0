Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1999C2FBC4
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2019 14:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfE3MzN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 May 2019 08:55:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43114 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfE3MzM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 May 2019 08:55:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id c6so3909635pfa.10;
        Thu, 30 May 2019 05:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FsYmLFyZ+cOvAquul4hkXB/72YOvPq1DCzrK7znbTxM=;
        b=Rx5hyfjk+uWq/607WL1QsPm/vvl4zKShzgeUTcbOcCKZ3DjwIj2TVS+INRlEQE4esO
         gEyhwXt1uahJSVRtDqNrlUeLZMg/cWuhw9yDz/6wYzgpAzL9T8IMLenTHpcySFLpGi57
         g7648n5Uzh5Z47Ff6WBH63Fi/zjtNYAPJy9+cEdUeQ6YQVH8fZyYvXjeiI5maNENdk6R
         9YvGQpddjtok3eAwtJ9M9KASkizcNp/N5+0ibxbH14wXANZAgH4OSATOozNbhITRKyCT
         KDDm+GM2IBt1XV98amHipkbG5QpnNyrNxqI/N2XtAKiSChg6dUhVLkIg96tkSypx2Bnz
         50jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FsYmLFyZ+cOvAquul4hkXB/72YOvPq1DCzrK7znbTxM=;
        b=ifBStyJCq6tsVrqCfcwLZV8dONe+0uC36/psXUoQZRiLl61tz28yLI/w2nZYreh7Z+
         nnLuSQU8SglqOWaE2RuwIssDMv1iYlRrH4UIjGGrSLYF54TtxNVntqappMXYV3UD3WR1
         NNJr/CY3cWJRW58z5gNqq6ltMHj3t5MeqWXmaI2tOP8GD9xs6U58s8fBtYMpn2KzdmXS
         WWP8vDCZf0B6JZLZGXygAwMpZbclX2UZEYvBaw6HMtOD5tYQ5OJ6023Cm7p5Pl4z18R4
         D8dXmW1KXhS96koHBgu4qaRQ5BILQj9D8Yq6OVs3+vmPcINPXKTTrB79F+gMUtaEBIeN
         soeA==
X-Gm-Message-State: APjAAAVFSM771/vhxQ8XPtR3DDa+l5RtZqVvm9/xzekU7aI4SdkdqVss
        ZmDObsGAj5WMz2TV2cdyZa8=
X-Google-Smtp-Source: APXvYqzwJO3j5JAKhNPaqy6jHsYezXtKoQOmDkmAsxCk0eq3ACz4DHHN2Esn0qkwiNG8I/crT+GzbA==
X-Received: by 2002:a63:360c:: with SMTP id d12mr3501641pga.285.1559220911754;
        Thu, 30 May 2019 05:55:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e20sm1280245pfi.35.2019.05.30.05.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 05:55:11 -0700 (PDT)
Date:   Thu, 30 May 2019 05:55:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: Add ads1000/ads1100 voltage ADCs driver
Message-ID: <20190530125510.GA26072@roeck-us.net>
References: <20190514225810.12591-1-fancer.lancer@gmail.com>
 <20190514225810.12591-3-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514225810.12591-3-fancer.lancer@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Wed, May 15, 2019 at 01:58:09AM +0300, Serge Semin wrote:
> These are simple Texas Instruments ADC working over i2c-interface with
> just one differential input and with configurable 12-16 bits resolution.
> Sample rate is fixed to 128 for ads1000 and can vary from 8 to 128 for
> ads1100. Vdd value reference value must be supplied so to properly
> translate the sampled code to the real voltage. All of these configs are
> implemented in the device drivers for hwmon subsystem. The next dts
> properties should be specified to comply the device platform setup:
>  - vdd-supply - voltage regulator connected to the Vdd pin of the device
>  - ti,gain - programmable gain amplifier
>  - ti,datarate - converter data rate
>  - ti,voltage-divider - possible resistors-base external divider
> See bindings documentation file for details.
> 
> Even though these devices seem more like ads1015 series, they
> in fact pretty much different. First of all ads1000/ads1100 got less
> capabilities: just one port, no configurations of digital comparator, no
> input multi-channel multiplexer, smaller PGA and data-rate ranges.
> In addition they haven't got internal voltage reference, but instead
> are created to use Vdd pin voltage. Finally the output code value is
> provided in different format. As a result it was much easier for
> development and for future support to create a separate driver.
> 

This chicp doesn't have any real hardware monitoring characteristics
(no limit registers). It seems to be better suited to be implemented
as iio driver. If it is used as hardware monitor, the iio-hwmon bridge
should work just fine.

Jonathan, what do you think ?

Thanks,
Guenter

> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  MAINTAINERS                           |   8 +
>  drivers/hwmon/Kconfig                 |  10 +
>  drivers/hwmon/Makefile                |   1 +
>  drivers/hwmon/ads1000.c               | 320 ++++++++++++++++++++++++++
>  include/linux/platform_data/ads1000.h |  20 ++
>  5 files changed, 359 insertions(+)
>  create mode 100644 drivers/hwmon/ads1000.c
>  create mode 100644 include/linux/platform_data/ads1000.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ce573aaa04df..5c3a8107ef1a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -517,6 +517,14 @@ W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/video/backlight/adp8860_bl.c
>  
> +ADS1000 HARDWARE MONITOR DRIVER
> +M:	Serge Semin <fancer.lancer@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/ads1000.rst
> +F:	drivers/hwmon/ads1000.c
> +F:	include/linux/platform_data/ads1000.h
> +
>  ADS1015 HARDWARE MONITOR DRIVER
>  M:	Dirk Eibach <eibach@gdsys.de>
>  L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 1915a18b537b..a1220cc48f2f 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1569,6 +1569,16 @@ config SENSORS_ADC128D818
>  	  This driver can also be built as a module. If so, the module
>  	  will be called adc128d818.
>  
> +config SENSORS_ADS1000
> +	tristate "Texas Instruments ADS1000"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Texas Instruments
> +	  ADS1000/ADS1100 12-16-bit single channel ADC device.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called ads1000.
> +
>  config SENSORS_ADS1015
>  	tristate "Texas Instruments ADS1015"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 8db472ea04f0..2cd82f6c651e 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
>  obj-$(CONFIG_SENSORS_ADM1029)	+= adm1029.o
>  obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
>  obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
> +obj-$(CONFIG_SENSORS_ADS1000)	+= ads1000.o
>  obj-$(CONFIG_SENSORS_ADS1015)	+= ads1015.o
>  obj-$(CONFIG_SENSORS_ADS7828)	+= ads7828.o
>  obj-$(CONFIG_SENSORS_ADS7871)	+= ads7871.o
> diff --git a/drivers/hwmon/ads1000.c b/drivers/hwmon/ads1000.c
> new file mode 100644
> index 000000000000..a88b738f56bd
> --- /dev/null
> +++ b/drivers/hwmon/ads1000.c
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for ADS1000/ADS1100 12-16-bit ADC
> + *
> + * Copyright (C) 2019 T-platforms JSC (fancer.lancer@gmail.com)
> + *
> + * Based on the ads1015 driver by Dirk Eibach.
> + *
> + * Datasheet available at: http://focus.ti.com/lit/ds/symlink/ads1000.pdf
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_data/ads1000.h>
> +
> +/* Data rates scale table */
> +static const unsigned int scale_table[4] = {
> +	2048, 8192, 16384, 32768
> +};
> +
> +/* Minimal data rates in samples per second */
> +static const unsigned int data_rate_table[4] = {
> +	100, 25, 12, 5
> +};
> +
> +#define ADS1000_DEFAULT_PGA 0
> +#define ADS1000_DEFAULT_DATA_RATE 0
> +#define ADS1000_DEFAULT_R1_DIVIDER 0
> +#define ADS1000_DEFAULT_R2_DIVIDER 0
> +
> +enum ads1000_chips {
> +	ads1000,
> +	ads1100,
> +};
> +
> +struct ads1000 {
> +	struct device *hwmon_dev;
> +	struct mutex update_lock;
> +	struct i2c_client *client;
> +	struct ads1000_platform_data data;
> +	enum ads1000_chips id;
> +};
> +
> +static inline int ads1000_enable_vdd(struct ads1000 *priv)
> +{
> +	return regulator_enable(priv->data.vdd);
> +}
> +
> +static inline int ads1000_get_vdd(struct ads1000 *priv)
> +{
> +	return regulator_get_voltage(priv->data.vdd);
> +}
> +
> +static int ads1000_read_adc(struct ads1000 *priv)
> +{
> +	struct i2c_client *client = priv->client;
> +	unsigned int delay_ms;
> +	u8 data[3] = {0};
> +	int res;
> +
> +	mutex_lock(&priv->update_lock);
> +
> +	delay_ms = DIV_ROUND_UP(1000, data_rate_table[priv->data.data_rate]);
> +
> +	/* setup and start single conversion */
> +	data[2] |= (1 << 7) | (1 << 4);
> +	data[2] |= priv->data.pga;
> +	data[2] |= priv->data.data_rate << 2;
> +
> +	res = i2c_master_send(client, &data[2], 1);
> +	if (res < 0)
> +		goto err_unlock;
> +
> +	/* wait until conversion finished */
> +	msleep(delay_ms);
> +	res = i2c_master_recv(client, data, 3);
> +	if (res < 0)
> +		goto err_unlock;
> +
> +	if (data[2] & (1 << 7)) {
> +		res = -EIO;
> +		goto err_unlock;
> +	}
> +
> +	res = ((u16)data[0] << 8) | data[1];
> +
> +err_unlock:
> +	mutex_unlock(&priv->update_lock);
> +
> +	return res;
> +}
> +
> +static int ads1000_reg_to_mv(struct ads1000 *priv, s16 reg)
> +{
> +	unsigned int *divider = priv->data.divider;
> +	int voltage = ads1000_get_vdd(priv);
> +	int gain = 1 << priv->data.pga;
> +	int c = 0;
> +
> +	voltage = reg*DIV_ROUND_CLOSEST(voltage, 1000);
> +	gain = gain*scale_table[priv->data.data_rate];
> +	voltage = DIV_ROUND_CLOSEST(voltage, gain);
> +
> +	if (divider[0] && divider[1]) {
> +		c = divider[0]*voltage;
> +		c = DIV_ROUND_CLOSEST(c, (int)divider[1]);
> +	}
> +
> +	return voltage + c;
> +}
> +
> +static ssize_t show_in(struct device *dev, struct device_attribute *da,
> +		       char *buf)
> +{
> +	struct ads1000 *priv = dev_get_drvdata(dev);
> +	int res;
> +
> +	res = ads1000_read_adc(priv);
> +	if (res < 0)
> +		return res;
> +
> +	return sprintf(buf, "%d\n", ads1000_reg_to_mv(priv, res));
> +}
> +
> +static SENSOR_DEVICE_ATTR(in0_input, 0444, show_in, NULL, 0);
> +
> +static struct attribute *ads1000_attrs[] = {
> +	&sensor_dev_attr_in0_input.dev_attr.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(ads1000);
> +
> +static struct ads1000 *ads1000_create_priv(struct i2c_client *client,
> +					   const struct i2c_device_id *id)
> +{
> +	struct ads1000 *priv;
> +
> +	priv = devm_kzalloc(&client->dev, sizeof(struct ads1000),
> +			    GFP_KERNEL);
> +	if (!priv)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (client->dev.of_node)
> +		priv->id = (enum ads1000_chips)
> +			of_device_get_match_data(&client->dev);
> +	else
> +		priv->id = id->driver_data;
> +
> +	i2c_set_clientdata(client, priv);
> +	priv->client = client;
> +	mutex_init(&priv->update_lock);
> +
> +	return priv;
> +}
> +
> +#ifdef CONFIG_OF
> +static int ads1000_get_config_of(struct ads1000 *priv)
> +{
> +	struct i2c_client *client = priv->client;
> +	struct device_node *node = client->dev.of_node;
> +	u32 divider[2];
> +	u32 val;
> +
> +	if (!node)
> +		return -EINVAL;
> +
> +	if (!of_property_read_u32(node, "ti,gain", &val))
> +		priv->data.pga = val;
> +
> +	if (!of_property_read_u32(node, "ti,datarate", &val))
> +		priv->data.data_rate = val;
> +
> +	if (!of_property_read_u32_array(node, "ti,voltage-divider",
> +					divider, 2)) {
> +		priv->data.divider[0] = divider[0];
> +		priv->data.divider[1] = divider[1];
> +	}
> +
> +	priv->data.vdd = devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(priv->data.vdd))
> +		return PTR_ERR(priv->data.vdd);
> +
> +	return 0;
> +}
> +#endif
> +
> +static int ads1000_get_config(struct ads1000 *priv)
> +{
> +	struct i2c_client *client = priv->client;
> +	struct ads1000_platform_data *pdata = dev_get_platdata(&client->dev);
> +
> +	priv->data.pga = ADS1000_DEFAULT_PGA;
> +	priv->data.data_rate = ADS1000_DEFAULT_DATA_RATE;
> +	priv->data.divider[0] = ADS1000_DEFAULT_R1_DIVIDER;
> +	priv->data.divider[1] = ADS1000_DEFAULT_R2_DIVIDER;
> +
> +	/* prefer platform data */
> +	if (pdata) {
> +		memcpy(&priv->data, pdata, sizeof(priv->data));
> +	} else {
> +#ifdef CONFIG_OF
> +		int ret;
> +
> +		ret = ads1000_get_config_of(priv);
> +		if (ret)
> +			return ret;
> +#endif
> +	}
> +
> +	if (!priv->data.vdd) {
> +		dev_err(&client->dev, "No VDD regulator\n");
> +		return -EINVAL;
> +	}
> +
> +	if (priv->data.pga > 4) {
> +		dev_err(&client->dev, "Invalid gain, using default\n");
> +		priv->data.pga = ADS1000_DEFAULT_PGA;
> +	}
> +
> +	if (priv->data.data_rate > 4) {
> +		dev_err(&client->dev, "Invalid datarate, using default\n");
> +		priv->data.data_rate = ADS1000_DEFAULT_DATA_RATE;
> +	}
> +
> +	if (priv->id == ads1000 && priv->data.data_rate != 0) {
> +		dev_warn(&client->dev, "ADC data rate can be 128SPS only\n");
> +		priv->data.data_rate = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ads1000_set_config(struct ads1000 *priv)
> +{
> +	u8 data = 0;
> +	int ret;
> +
> +	/* disable continuous conversion */
> +	data |= (1 << 4);
> +	data |= priv->data.pga;
> +	data |= priv->data.data_rate << 2;
> +
> +	ret = i2c_master_send(priv->client, &data, 1);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int ads1000_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct ads1000 *priv;
> +	int ret;
> +
> +	priv = ads1000_create_priv(client, id);
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
> +
> +	ret = ads1000_get_config(priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1000_enable_vdd(priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1000_set_config(priv);
> +	if (ret)
> +		return ret;
> +
> +	priv->hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
> +				client->name, priv, ads1000_groups);
> +	if (IS_ERR(priv->hwmon_dev))
> +		return PTR_ERR(priv->hwmon_dev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ads1000_id[] = {
> +	{ "ads1000",  ads1000},
> +	{ "ads1100",  ads1100},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ads1000_id);
> +
> +static const struct of_device_id ads1000_of_match[] = {
> +	{
> +		.compatible = "ti,ads1000",
> +		.data = (void *)ads1000
> +	},
> +	{
> +		.compatible = "ti,ads1100",
> +		.data = (void *)ads1100
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ads1000_of_match);
> +
> +static struct i2c_driver ads1000_driver = {
> +	.driver = {
> +		.name = "ads1000",
> +		.of_match_table = of_match_ptr(ads1000_of_match),
> +	},
> +	.probe = ads1000_probe,
> +	.id_table = ads1000_id,
> +};
> +module_i2c_driver(ads1000_driver);
> +
> +MODULE_AUTHOR("Serge Semin <fancer.lancer@gmail.com>");
> +MODULE_DESCRIPTION("ADS1000 driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/platform_data/ads1000.h b/include/linux/platform_data/ads1000.h
> new file mode 100644
> index 000000000000..979670483537
> --- /dev/null
> +++ b/include/linux/platform_data/ads1000.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Platform Data for ADS1000/ADS1100 12-16-bit ADC
> + *
> + * Copyright (C) 2019 T-platforms JSC (fancer.lancer@gmail.com)
> + */
> +
> +#ifndef LINUX_ADS1000_H
> +#define LINUX_ADS1000_H
> +
> +#include <linux/regulator/consumer.h>
> +
> +struct ads1000_platform_data {
> +	unsigned int pga;
> +	unsigned int data_rate;
> +	struct regulator *vdd;
> +	unsigned int divider[2];
> +};
> +
> +#endif /* LINUX_ADS1000_H */
