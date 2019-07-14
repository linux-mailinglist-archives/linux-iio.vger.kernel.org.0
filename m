Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD69E6801B
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 18:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfGNQQl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 12:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbfGNQQl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 12:16:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3431B205F4;
        Sun, 14 Jul 2019 16:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563120998;
        bh=yBJVh+E5YYHCPpZY7HCjQKmsqWO0peQMZRZseXigG8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wgevIff67qtEUqE5RJcTQEDCR8t964BESwM13lTEGWtMS9JWcfo8HAOFEOHhjcU5G
         jIulrPOcT3FS/OTk6YtHRYV7sXYpnLmIcKdaeCzmPCwIuLCOor8p+YIzdBSvihSxz0
         H/dJFs8+D/9EvCYp5VAP8nrMqwlxJX7wlz4OK2TM=
Date:   Sun, 14 Jul 2019 17:16:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dirk Eibach <eibach@gdsys.de>
Subject: Re: [PATCH] hwmon: Remove ads1015 driver
Message-ID: <20190714171634.197944fc@archlinux>
In-Reply-To: <1562004758-13025-1-git-send-email-linux@roeck-us.net>
References: <1562004758-13025-1-git-send-email-linux@roeck-us.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  1 Jul 2019 11:12:38 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> A driver for ADS1015 with more functionality is available in the iio
> subsystem.
> 
> Remove the hwmon driver as duplicate. If the chip is used for hardware
> monitoring, the iio->hwmon bridge should be used.
> 
> Cc: Dirk Eibach <eibach@gdsys.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

On the basis I agree with the concept of dropping this driver:

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for tidying this up.

Jonathan

> ---
> Current plan is to queue this removal for v5.4 (not v5.3) in the hwmon
> tree.
> 
>  .../devicetree/bindings/hwmon/ads1015.txt          |  73 -----
>  .../devicetree/bindings/iio/adc/ads1015.txt        |  73 +++++
>  Documentation/hwmon/ads1015.rst                    |  90 ------
>  Documentation/hwmon/index.rst                      |   1 -
>  MAINTAINERS                                        |   8 -
>  drivers/hwmon/Kconfig                              |  10 -
>  drivers/hwmon/Makefile                             |   1 -
>  drivers/hwmon/ads1015.c                            | 324 ---------------------
>  drivers/iio/adc/Kconfig                            |   2 +-
>  9 files changed, 74 insertions(+), 508 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/ads1015.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ads1015.txt
>  delete mode 100644 Documentation/hwmon/ads1015.rst
>  delete mode 100644 drivers/hwmon/ads1015.c
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ads1015.txt b/Documentation/devicetree/bindings/hwmon/ads1015.txt
> deleted file mode 100644
> index 918a507d1159..000000000000
> --- a/Documentation/devicetree/bindings/hwmon/ads1015.txt
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -ADS1015 (I2C)
> -
> -This device is a 12-bit A-D converter with 4 inputs.
> -
> -The inputs can be used single ended or in certain differential combinations.
> -
> -For configuration all possible combinations are mapped to 8 channels:
> -  0: Voltage over AIN0 and AIN1.
> -  1: Voltage over AIN0 and AIN3.
> -  2: Voltage over AIN1 and AIN3.
> -  3: Voltage over AIN2 and AIN3.
> -  4: Voltage over AIN0 and GND.
> -  5: Voltage over AIN1 and GND.
> -  6: Voltage over AIN2 and GND.
> -  7: Voltage over AIN3 and GND.
> -
> -Each channel can be configured individually:
> - - pga is the programmable gain amplifier (values are full scale)
> -    0: +/- 6.144 V
> -    1: +/- 4.096 V
> -    2: +/- 2.048 V (default)
> -    3: +/- 1.024 V
> -    4: +/- 0.512 V
> -    5: +/- 0.256 V
> - - data_rate in samples per second
> -    0: 128
> -    1: 250
> -    2: 490
> -    3: 920
> -    4: 1600 (default)
> -    5: 2400
> -    6: 3300
> -
> -1) The /ads1015 node
> -
> -  Required properties:
> -
> -   - compatible : must be "ti,ads1015"
> -   - reg : I2C bus address of the device
> -   - #address-cells : must be <1>
> -   - #size-cells : must be <0>
> -
> -  The node contains child nodes for each channel that the platform uses.
> -
> -  Example ADS1015 node:
> -
> -    ads1015@49 {
> -	    compatible = "ti,ads1015";
> -	    reg = <0x49>;
> -	    #address-cells = <1>;
> -	    #size-cells = <0>;
> -
> -	    [ child node definitions... ]
> -    }
> -
> -2) channel nodes
> -
> -  Required properties:
> -
> -   - reg : the channel number
> -
> -  Optional properties:
> -
> -   - ti,gain : the programmable gain amplifier setting
> -   - ti,datarate : the converter data rate
> -
> -  Example ADS1015 channel node:
> -
> -    channel@4 {
> -	    reg = <4>;
> -	    ti,gain = <3>;
> -	    ti,datarate = <5>;
> -    };
> diff --git a/Documentation/devicetree/bindings/iio/adc/ads1015.txt b/Documentation/devicetree/bindings/iio/adc/ads1015.txt
> new file mode 100644
> index 000000000000..918a507d1159
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ads1015.txt
> @@ -0,0 +1,73 @@
> +ADS1015 (I2C)
> +
> +This device is a 12-bit A-D converter with 4 inputs.
> +
> +The inputs can be used single ended or in certain differential combinations.
> +
> +For configuration all possible combinations are mapped to 8 channels:
> +  0: Voltage over AIN0 and AIN1.
> +  1: Voltage over AIN0 and AIN3.
> +  2: Voltage over AIN1 and AIN3.
> +  3: Voltage over AIN2 and AIN3.
> +  4: Voltage over AIN0 and GND.
> +  5: Voltage over AIN1 and GND.
> +  6: Voltage over AIN2 and GND.
> +  7: Voltage over AIN3 and GND.
> +
> +Each channel can be configured individually:
> + - pga is the programmable gain amplifier (values are full scale)
> +    0: +/- 6.144 V
> +    1: +/- 4.096 V
> +    2: +/- 2.048 V (default)
> +    3: +/- 1.024 V
> +    4: +/- 0.512 V
> +    5: +/- 0.256 V
> + - data_rate in samples per second
> +    0: 128
> +    1: 250
> +    2: 490
> +    3: 920
> +    4: 1600 (default)
> +    5: 2400
> +    6: 3300
> +
> +1) The /ads1015 node
> +
> +  Required properties:
> +
> +   - compatible : must be "ti,ads1015"
> +   - reg : I2C bus address of the device
> +   - #address-cells : must be <1>
> +   - #size-cells : must be <0>
> +
> +  The node contains child nodes for each channel that the platform uses.
> +
> +  Example ADS1015 node:
> +
> +    ads1015@49 {
> +	    compatible = "ti,ads1015";
> +	    reg = <0x49>;
> +	    #address-cells = <1>;
> +	    #size-cells = <0>;
> +
> +	    [ child node definitions... ]
> +    }
> +
> +2) channel nodes
> +
> +  Required properties:
> +
> +   - reg : the channel number
> +
> +  Optional properties:
> +
> +   - ti,gain : the programmable gain amplifier setting
> +   - ti,datarate : the converter data rate
> +
> +  Example ADS1015 channel node:
> +
> +    channel@4 {
> +	    reg = <4>;
> +	    ti,gain = <3>;
> +	    ti,datarate = <5>;
> +    };
> diff --git a/Documentation/hwmon/ads1015.rst b/Documentation/hwmon/ads1015.rst
> deleted file mode 100644
> index e0951c4e57bb..000000000000
> --- a/Documentation/hwmon/ads1015.rst
> +++ /dev/null
> @@ -1,90 +0,0 @@
> -Kernel driver ads1015
> -=====================
> -
> -Supported chips:
> -
> -  * Texas Instruments ADS1015
> -
> -    Prefix: 'ads1015'
> -
> -    Datasheet: Publicly available at the Texas Instruments website:
> -
> -	       http://focus.ti.com/lit/ds/symlink/ads1015.pdf
> -
> -  * Texas Instruments ADS1115
> -
> -    Prefix: 'ads1115'
> -
> -    Datasheet: Publicly available at the Texas Instruments website:
> -
> -	       http://focus.ti.com/lit/ds/symlink/ads1115.pdf
> -
> -Authors:
> -	Dirk Eibach, Guntermann & Drunck GmbH <eibach@gdsys.de>
> -
> -Description
> ------------
> -
> -This driver implements support for the Texas Instruments ADS1015/ADS1115.
> -
> -This device is a 12/16-bit A-D converter with 4 inputs.
> -
> -The inputs can be used single ended or in certain differential combinations.
> -
> -The inputs can be made available by 8 sysfs input files in0_input - in7_input:
> -
> -  - in0: Voltage over AIN0 and AIN1.
> -  - in1: Voltage over AIN0 and AIN3.
> -  - in2: Voltage over AIN1 and AIN3.
> -  - in3: Voltage over AIN2 and AIN3.
> -  - in4: Voltage over AIN0 and GND.
> -  - in5: Voltage over AIN1 and GND.
> -  - in6: Voltage over AIN2 and GND.
> -  - in7: Voltage over AIN3 and GND.
> -
> -Which inputs are available can be configured using platform data or devicetree.
> -
> -By default all inputs are exported.
> -
> -Platform Data
> --------------
> -
> -In linux/platform_data/ads1015.h platform data is defined, channel_data contains
> -configuration data for the used input combinations:
> -
> -- pga is the programmable gain amplifier (values are full scale)
> -
> -    - 0: +/- 6.144 V
> -    - 1: +/- 4.096 V
> -    - 2: +/- 2.048 V
> -    - 3: +/- 1.024 V
> -    - 4: +/- 0.512 V
> -    - 5: +/- 0.256 V
> -
> -- data_rate in samples per second
> -
> -    - 0: 128
> -    - 1: 250
> -    - 2: 490
> -    - 3: 920
> -    - 4: 1600
> -    - 5: 2400
> -    - 6: 3300
> -
> -Example::
> -
> -  struct ads1015_platform_data data = {
> -	.channel_data = {
> -		[2] = { .enabled = true, .pga = 1, .data_rate = 0 },
> -		[4] = { .enabled = true, .pga = 4, .data_rate = 5 },
> -	}
> -  };
> -
> -In this case only in2_input (FS +/- 4.096 V, 128 SPS) and in4_input
> -(FS +/- 0.512 V, 2400 SPS) would be created.
> -
> -Devicetree
> -----------
> -
> -Configuration is also possible via devicetree:
> -Documentation/devicetree/bindings/hwmon/ads1015.txt
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index ee090e51653a..1d301d0e6f4d 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -30,7 +30,6 @@ Hardware Monitoring Kernel Drivers
>     adm1031
>     adm1275
>     adm9240
> -   ads1015
>     ads7828
>     adt7410
>     adt7411
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 01a52fc964da..11744a3735f0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -517,14 +517,6 @@ W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/video/backlight/adp8860_bl.c
>  
> -ADS1015 HARDWARE MONITOR DRIVER
> -M:	Dirk Eibach <eibach@gdsys.de>
> -L:	linux-hwmon@vger.kernel.org
> -S:	Maintained
> -F:	Documentation/hwmon/ads1015.rst
> -F:	drivers/hwmon/ads1015.c
> -F:	include/linux/platform_data/ads1015.h
> -
>  ADT746X FAN DRIVER
>  M:	Colin Leroy <colin@colino.net>
>  S:	Maintained
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 650dd71f9724..76cd0647ee2c 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1570,16 +1570,6 @@ config SENSORS_ADC128D818
>  	  This driver can also be built as a module. If so, the module
>  	  will be called adc128d818.
>  
> -config SENSORS_ADS1015
> -	tristate "Texas Instruments ADS1015"
> -	depends on I2C
> -	help
> -	  If you say yes here you get support for Texas Instruments
> -	  ADS1015/ADS1115 12/16-bit 4-input ADC device.
> -
> -	  This driver can also be built as a module. If so, the module
> -	  will be called ads1015.
> -
>  config SENSORS_ADS7828
>  	tristate "Texas Instruments ADS7828 and compatibles"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 8db472ea04f0..6a52a964038b 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -35,7 +35,6 @@ obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
>  obj-$(CONFIG_SENSORS_ADM1029)	+= adm1029.o
>  obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
>  obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
> -obj-$(CONFIG_SENSORS_ADS1015)	+= ads1015.o
>  obj-$(CONFIG_SENSORS_ADS7828)	+= ads7828.o
>  obj-$(CONFIG_SENSORS_ADS7871)	+= ads7871.o
>  obj-$(CONFIG_SENSORS_ADT7X10)	+= adt7x10.o
> diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
> deleted file mode 100644
> index 3727a3762eb8..000000000000
> --- a/drivers/hwmon/ads1015.c
> +++ /dev/null
> @@ -1,324 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * ads1015.c - lm_sensors driver for ads1015 12-bit 4-input ADC
> - * (C) Copyright 2010
> - * Dirk Eibach, Guntermann & Drunck GmbH <eibach@gdsys.de>
> - *
> - * Based on the ads7828 driver by Steve Hardy.
> - *
> - * Datasheet available at: http://focus.ti.com/lit/ds/symlink/ads1015.pdf
> - */
> -
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/slab.h>
> -#include <linux/delay.h>
> -#include <linux/i2c.h>
> -#include <linux/hwmon.h>
> -#include <linux/hwmon-sysfs.h>
> -#include <linux/err.h>
> -#include <linux/mutex.h>
> -#include <linux/of_device.h>
> -#include <linux/of.h>
> -
> -#include <linux/platform_data/ads1015.h>
> -
> -/* ADS1015 registers */
> -enum {
> -	ADS1015_CONVERSION = 0,
> -	ADS1015_CONFIG = 1,
> -};
> -
> -/* PGA fullscale voltages in mV */
> -static const unsigned int fullscale_table[8] = {
> -	6144, 4096, 2048, 1024, 512, 256, 256, 256 };
> -
> -/* Data rates in samples per second */
> -static const unsigned int data_rate_table_1015[8] = {
> -	128, 250, 490, 920, 1600, 2400, 3300, 3300
> -};
> -
> -static const unsigned int data_rate_table_1115[8] = {
> -	8, 16, 32, 64, 128, 250, 475, 860
> -};
> -
> -#define ADS1015_DEFAULT_CHANNELS 0xff
> -#define ADS1015_DEFAULT_PGA 2
> -#define ADS1015_DEFAULT_DATA_RATE 4
> -
> -enum ads1015_chips {
> -	ads1015,
> -	ads1115,
> -};
> -
> -struct ads1015_data {
> -	struct device *hwmon_dev;
> -	struct mutex update_lock; /* mutex protect updates */
> -	struct ads1015_channel_data channel_data[ADS1015_CHANNELS];
> -	enum ads1015_chips id;
> -};
> -
> -static int ads1015_read_adc(struct i2c_client *client, unsigned int channel)
> -{
> -	u16 config;
> -	struct ads1015_data *data = i2c_get_clientdata(client);
> -	unsigned int pga = data->channel_data[channel].pga;
> -	unsigned int data_rate = data->channel_data[channel].data_rate;
> -	unsigned int conversion_time_ms;
> -	const unsigned int * const rate_table = data->id == ads1115 ?
> -		data_rate_table_1115 : data_rate_table_1015;
> -	int res;
> -
> -	mutex_lock(&data->update_lock);
> -
> -	/* get channel parameters */
> -	res = i2c_smbus_read_word_swapped(client, ADS1015_CONFIG);
> -	if (res < 0)
> -		goto err_unlock;
> -	config = res;
> -	conversion_time_ms = DIV_ROUND_UP(1000, rate_table[data_rate]);
> -
> -	/* setup and start single conversion */
> -	config &= 0x001f;
> -	config |= (1 << 15) | (1 << 8);
> -	config |= (channel & 0x0007) << 12;
> -	config |= (pga & 0x0007) << 9;
> -	config |= (data_rate & 0x0007) << 5;
> -
> -	res = i2c_smbus_write_word_swapped(client, ADS1015_CONFIG, config);
> -	if (res < 0)
> -		goto err_unlock;
> -
> -	/* wait until conversion finished */
> -	msleep(conversion_time_ms);
> -	res = i2c_smbus_read_word_swapped(client, ADS1015_CONFIG);
> -	if (res < 0)
> -		goto err_unlock;
> -	config = res;
> -	if (!(config & (1 << 15))) {
> -		/* conversion not finished in time */
> -		res = -EIO;
> -		goto err_unlock;
> -	}
> -
> -	res = i2c_smbus_read_word_swapped(client, ADS1015_CONVERSION);
> -
> -err_unlock:
> -	mutex_unlock(&data->update_lock);
> -	return res;
> -}
> -
> -static int ads1015_reg_to_mv(struct i2c_client *client, unsigned int channel,
> -			     s16 reg)
> -{
> -	struct ads1015_data *data = i2c_get_clientdata(client);
> -	unsigned int pga = data->channel_data[channel].pga;
> -	int fullscale = fullscale_table[pga];
> -	const int mask = data->id == ads1115 ? 0x7fff : 0x7ff0;
> -
> -	return DIV_ROUND_CLOSEST(reg * fullscale, mask);
> -}
> -
> -/* sysfs callback function */
> -static ssize_t in_show(struct device *dev, struct device_attribute *da,
> -		       char *buf)
> -{
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	int res;
> -	int index = attr->index;
> -
> -	res = ads1015_read_adc(client, index);
> -	if (res < 0)
> -		return res;
> -
> -	return sprintf(buf, "%d\n", ads1015_reg_to_mv(client, index, res));
> -}
> -
> -static const struct sensor_device_attribute ads1015_in[] = {
> -	SENSOR_ATTR_RO(in0_input, in, 0),
> -	SENSOR_ATTR_RO(in1_input, in, 1),
> -	SENSOR_ATTR_RO(in2_input, in, 2),
> -	SENSOR_ATTR_RO(in3_input, in, 3),
> -	SENSOR_ATTR_RO(in4_input, in, 4),
> -	SENSOR_ATTR_RO(in5_input, in, 5),
> -	SENSOR_ATTR_RO(in6_input, in, 6),
> -	SENSOR_ATTR_RO(in7_input, in, 7),
> -};
> -
> -/*
> - * Driver interface
> - */
> -
> -static int ads1015_remove(struct i2c_client *client)
> -{
> -	struct ads1015_data *data = i2c_get_clientdata(client);
> -	int k;
> -
> -	hwmon_device_unregister(data->hwmon_dev);
> -	for (k = 0; k < ADS1015_CHANNELS; ++k)
> -		device_remove_file(&client->dev, &ads1015_in[k].dev_attr);
> -	return 0;
> -}
> -
> -#ifdef CONFIG_OF
> -static int ads1015_get_channels_config_of(struct i2c_client *client)
> -{
> -	struct ads1015_data *data = i2c_get_clientdata(client);
> -	struct device_node *node;
> -
> -	if (!client->dev.of_node
> -	    || !of_get_next_child(client->dev.of_node, NULL))
> -		return -EINVAL;
> -
> -	for_each_child_of_node(client->dev.of_node, node) {
> -		u32 pval;
> -		unsigned int channel;
> -		unsigned int pga = ADS1015_DEFAULT_PGA;
> -		unsigned int data_rate = ADS1015_DEFAULT_DATA_RATE;
> -
> -		if (of_property_read_u32(node, "reg", &pval)) {
> -			dev_err(&client->dev, "invalid reg on %pOF\n", node);
> -			continue;
> -		}
> -
> -		channel = pval;
> -		if (channel >= ADS1015_CHANNELS) {
> -			dev_err(&client->dev,
> -				"invalid channel index %d on %pOF\n",
> -				channel, node);
> -			continue;
> -		}
> -
> -		if (!of_property_read_u32(node, "ti,gain", &pval)) {
> -			pga = pval;
> -			if (pga > 6) {
> -				dev_err(&client->dev, "invalid gain on %pOF\n",
> -					node);
> -				return -EINVAL;
> -			}
> -		}
> -
> -		if (!of_property_read_u32(node, "ti,datarate", &pval)) {
> -			data_rate = pval;
> -			if (data_rate > 7) {
> -				dev_err(&client->dev,
> -					"invalid data_rate on %pOF\n", node);
> -				return -EINVAL;
> -			}
> -		}
> -
> -		data->channel_data[channel].enabled = true;
> -		data->channel_data[channel].pga = pga;
> -		data->channel_data[channel].data_rate = data_rate;
> -	}
> -
> -	return 0;
> -}
> -#endif
> -
> -static void ads1015_get_channels_config(struct i2c_client *client)
> -{
> -	unsigned int k;
> -	struct ads1015_data *data = i2c_get_clientdata(client);
> -	struct ads1015_platform_data *pdata = dev_get_platdata(&client->dev);
> -
> -	/* prefer platform data */
> -	if (pdata) {
> -		memcpy(data->channel_data, pdata->channel_data,
> -		       sizeof(data->channel_data));
> -		return;
> -	}
> -
> -#ifdef CONFIG_OF
> -	if (!ads1015_get_channels_config_of(client))
> -		return;
> -#endif
> -
> -	/* fallback on default configuration */
> -	for (k = 0; k < ADS1015_CHANNELS; ++k) {
> -		data->channel_data[k].enabled = true;
> -		data->channel_data[k].pga = ADS1015_DEFAULT_PGA;
> -		data->channel_data[k].data_rate = ADS1015_DEFAULT_DATA_RATE;
> -	}
> -}
> -
> -static int ads1015_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> -{
> -	struct ads1015_data *data;
> -	int err;
> -	unsigned int k;
> -
> -	data = devm_kzalloc(&client->dev, sizeof(struct ads1015_data),
> -			    GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> -
> -	if (client->dev.of_node)
> -		data->id = (enum ads1015_chips)
> -			of_device_get_match_data(&client->dev);
> -	else
> -		data->id = id->driver_data;
> -	i2c_set_clientdata(client, data);
> -	mutex_init(&data->update_lock);
> -
> -	/* build sysfs attribute group */
> -	ads1015_get_channels_config(client);
> -	for (k = 0; k < ADS1015_CHANNELS; ++k) {
> -		if (!data->channel_data[k].enabled)
> -			continue;
> -		err = device_create_file(&client->dev, &ads1015_in[k].dev_attr);
> -		if (err)
> -			goto exit_remove;
> -	}
> -
> -	data->hwmon_dev = hwmon_device_register(&client->dev);
> -	if (IS_ERR(data->hwmon_dev)) {
> -		err = PTR_ERR(data->hwmon_dev);
> -		goto exit_remove;
> -	}
> -
> -	return 0;
> -
> -exit_remove:
> -	for (k = 0; k < ADS1015_CHANNELS; ++k)
> -		device_remove_file(&client->dev, &ads1015_in[k].dev_attr);
> -	return err;
> -}
> -
> -static const struct i2c_device_id ads1015_id[] = {
> -	{ "ads1015",  ads1015},
> -	{ "ads1115",  ads1115},
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(i2c, ads1015_id);
> -
> -static const struct of_device_id __maybe_unused ads1015_of_match[] = {
> -	{
> -		.compatible = "ti,ads1015",
> -		.data = (void *)ads1015
> -	},
> -	{
> -		.compatible = "ti,ads1115",
> -		.data = (void *)ads1115
> -	},
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, ads1015_of_match);
> -
> -static struct i2c_driver ads1015_driver = {
> -	.driver = {
> -		.name = "ads1015",
> -		.of_match_table = of_match_ptr(ads1015_of_match),
> -	},
> -	.probe = ads1015_probe,
> -	.remove = ads1015_remove,
> -	.id_table = ads1015_id,
> -};
> -
> -module_i2c_driver(ads1015_driver);
> -
> -MODULE_AUTHOR("Dirk Eibach <eibach@gdsys.de>");
> -MODULE_DESCRIPTION("ADS1015 driver");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f96a7702b020..47d073006a13 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -958,7 +958,7 @@ config TI_ADC161S626
>  
>  config TI_ADS1015
>  	tristate "Texas Instruments ADS1015 ADC"
> -	depends on I2C && !SENSORS_ADS1015
> +	depends on I2C
>  	select REGMAP_I2C
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER

