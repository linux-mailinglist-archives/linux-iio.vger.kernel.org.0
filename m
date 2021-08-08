Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01713E3AC0
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 16:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhHHOS3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 8 Aug 2021 10:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231493AbhHHOS3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 10:18:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74D9761019;
        Sun,  8 Aug 2021 14:18:06 +0000 (UTC)
Date:   Sun, 8 Aug 2021 15:20:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jiri Kosina <trivial@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: Re: [PATCH v2 2/2] iio: chemical: Add driver support for sgp40
Message-ID: <20210808152056.506da07a@jic23-huawei>
In-Reply-To: <20210804154641.GA3237@arbad>
References: <20210804154641.GA3237@arbad>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 4 Aug 2021 17:46:42 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> sgp40 is a gas sensor used for measuring the air quality.
> 
> This driver is reading the raw resistance value which can be passed to
> an userspace algorithm for further calculation.
> 
> The raw value is also used to calculate an estimated absolute voc index
> in the range from 0 to 500. For this purpose the raw_mean value of the
> resistance for which the index value is 250 might be set up as a
> calibration step. This can be done with in_resistance_calibbias.
> 
> Compensation of relative humidity and temperature is supported and can
> be used by writing to output values of out_humidityrelative_raw and
> out_temp_raw.
> 
> There is a predecesor sensor type (sgp30) already existing. This driver
> module was not extended because the new sensor is quite different in its
> i2c telegrams.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Hi Andreas,

Along with the 0-day build warnings email, there were some additional
things in here that I've tweaked (including some whitespace at end of
lines).  As it's all minor stuff I've applied the patches and made
the changes I wanted to see.

Printk issue resolved using the %zu format and other tweaks as mentioned
below,

Please take a look and check I haven't messed anything up.

Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to take another poke at it.

Thanks,

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-chemical-sgp40  |  31 ++
>  MAINTAINERS                                   |   6 +
>  drivers/iio/chemical/Kconfig                  |  11 +
>  drivers/iio/chemical/Makefile                 |   1 +
>  drivers/iio/chemical/sgp40.c                  | 372 ++++++++++++++++++
>  5 files changed, 421 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
>  create mode 100644 drivers/iio/chemical/sgp40.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40 b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
> new file mode 100644
> index 000000000000..469a7c00fad4
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
> @@ -0,0 +1,31 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_temp_raw
> +Date:		August 2021
> +KernelVersion:	5.15
> +Contact:	Andreas Klinger <ak@it-klinger.de>
> +Description:
> +		Set the temperature. This value is sent to the sensor for
> +		temperature compensation.
> +		Default value: 25000 (25 °C)
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_humidityrelative_raw
> +Date:		August 2021
> +KernelVersion:	5.15
> +Contact:	Andreas Klinger <ak@it-klinger.de>
> +Description:
> +		Set the relative humidity. This value is sent to the sensor for
> +		humidity compensation.
> +		Default value: 50000 (50 % relative humidity)
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_resistance_calibbias

This may bite us in future.   A 'limitation' or deliberate restriction
of the ABI docs format is we can't have repeats.   Right now, these three
are unique to this file, so we are fine.  It seems unlikely they will
remain so long term.   When we move them to a unified location it becomes
harder to maintain the level of detail you have here.

Still, a problem for another day.

> +Date:		August 2021
> +KernelVersion:	5.15
> +Contact:	Andreas Klinger <ak@it-klinger.de>
> +Description:
> +		Set the bias value for the resistance which is used for
> +		calculation of in_concentration_input as follows:
> +
> +		x = (in_resistance_raw - in_resistance_calibbias) * 0.65
> +
> +		in_concentration_input = 500 / (1 + e^x)
> +
> +		Default value: 30000
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 19135a9d778e..60f5e57ef385 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16707,6 +16707,12 @@ F:	drivers/iio/chemical/scd30_core.c
>  F:	drivers/iio/chemical/scd30_i2c.c
>  F:	drivers/iio/chemical/scd30_serial.c
>  
> +SENSIRION SGP40 GAS SENSOR DRIVER
> +M:	Andreas Klinger <ak@it-klinger.de>
> +S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
> +F:	drivers/iio/chemical/sgp40.c
> +
>  SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
>  M:	Tomasz Duszynski <tduszyns@gmail.com>
>  S:	Maintained
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index a4920646e9be..c03667e62732 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -131,6 +131,17 @@ config SENSIRION_SGP30
>  	  To compile this driver as module, choose M here: the
>  	  module will be called sgp30.
>  
> +config SENSIRION_SGP40
> +	tristate "Sensirion SGP40 gas sensor"
> +	depends on I2C
> +	select CRC8
> +	help
> +	  Say Y here to build I2C interface to support Sensirion SGP40 gas
> +	  sensor
> +
> +	  To compile this driver as module, choose M here: the
> +	  module will be called sgp40.
> +
>  config SPS30
>  	tristate
>  	select IIO_BUFFER
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index 4898690cc155..d07af581f234 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_SCD30_CORE) += scd30_core.o
>  obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
>  obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
>  obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
> +obj-$(CONFIG_SENSIRION_SGP40)	+= sgp40.o
>  obj-$(CONFIG_SPS30) += sps30.o
>  obj-$(CONFIG_SPS30_I2C) += sps30_i2c.o
>  obj-$(CONFIG_SPS30_SERIAL) += sps30_serial.o
> diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
> new file mode 100644
> index 000000000000..fdbe75b56873
> --- /dev/null
> +++ b/drivers/iio/chemical/sgp40.c
> @@ -0,0 +1,372 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * sgp40.c - Support for Sensirion SGP40 Gas Sensor
> + *
> + * Copyright (C) 2021 Andreas Klinger <ak@it-klinger.de>
> + *
> + * I2C slave address: 0x59
> + *
> + * Datasheet can be found here:
> + * https://www.sensirion.com/file/datasheet_sgp40
> + *
> + * There are two functionalities supported:
> + *
> + * 1) read raw logarithmic resistance value from sensor
> + *    --> useful to pass it to the algorithm of the sensor vendor for
> + *    measuring deteriorations and improvements of air quality.
> + *
> + * 2) calculate an estimated absolute voc index (0 - 500 index points) for
> + *    measuring the air quality.
> + *    For this purpose the value of the resistance for which the voc index
> + *    will be 250 can be set up using calibbias.
> + *
> + * Compensation values of relative humidity and temperature can be set up
> + * by writing to the out values of temp and humidityrelative.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
Not used.

> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/i2c.h>
> +#include <linux/crc8.h>

If no reason to have other orderings, alphabetical preferred.

> +
> +/*
> + * floating point calculation of voc is done as integer
> + * where numbers are multiplied by 1 << SGP40_CALC_POWER
> + */
> +#define SGP40_CALC_POWER	14
> +
> +#define SGP40_CRC8_POLYNOMIAL	0x31
> +#define SGP40_CRC8_INIT		0xff
> +
> +DECLARE_CRC8_TABLE(sgp40_crc8_table);
> +
> +struct sgp40_data {
> +	struct device		*dev;
> +	struct i2c_client	*client;
> +	int			rht;
> +	int			temp;
> +	int			res_calibbias;
> +	struct mutex		lock;

Locks should always have documentation of what their scope is.

> +};
> +
> +struct sgp40_tg_measure {
> +	u8	command[2];
> +	__be16	rht_ticks;
> +	u8	rht_crc;
> +	__be16	temp_ticks;
> +	u8	temp_crc;
> +} __packed;
> +
> +struct sgp40_tg_result {
> +	__be16	res_ticks;
> +	u8	res_crc;
> +} __packed;
> +
> +static const struct iio_chan_spec sgp40_channels[] = {
> +	{
> +		.type = IIO_CONCENTRATION,
> +		.channel2 = IIO_MOD_VOC,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
> +	{
> +		.type = IIO_RESISTANCE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_CALIBBIAS),
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.output = 1,
> +	},
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.output = 1,
> +	},
> +};
> +
> +/*
> + * taylor approximation of e^x:
> + * y = 1 + x + x^2 / 2 + x^3 / 6 + x^4 / 24 + ... + x^n / n!
> + *
> + * Because we are calculating x real value multiplied by 2^power we get
> + * an additional 2^power^n to divide for every element. For a reasonable
> + * precision this would overflow after a few iterations. Therefore we
> + * divide the x^n part whenever its about to overflow (xmax).
> + */
> +
> +static u32 sgp40_exp(int exp, u32 power, u32 rounds)
> +{
> +        u32 x, y, xp;
> +        u32 factorial, divider, xmax;
> +        int sign = 1;
> +	int i; 
> +
> +        if (exp == 0) 
> +                return 1 << power;
> +        else if (exp < 0) {
> +                sign = -1;
> +                exp *= -1;
> +        }
> +
> +        xmax = 0x7FFFFFFF / exp;
> +        x = exp;
> +        xp = 1; 
> +        factorial = 1; 
> +        y = 1 << power;
> +        divider = 0; 
> +
> +        for (i = 1; i <= rounds; i++) {
> +                xp *= x; 
> +                factorial *= i; 
> +                y += (xp >> divider) / factorial;
> +                divider += power;
> +                /* divide when next multiplication would overflow */
> +                if (xp >= xmax) {
> +                        xp >>= power;
> +                        divider -= power;
> +                }
> +        }
> +   
> +        if (sign == -1)
> +                return (1 << (power * 2)) / y; 
> +        else
> +                return y; 
> +}
> +
> +static int sgp40_calc_voc(struct sgp40_data *data, u16 resistance_raw, int *voc)
> +{
> +	int x;
> +	u32 exp = 0;
> +
> +	/* we calculate as a multiple of 16384 (2^14) */
> +	mutex_lock(&data->lock);
> +	x = ((int)resistance_raw - data->res_calibbias) * 106;
> +	mutex_unlock(&data->lock);
> +
> +	/* voc = 500 / (1 + e^x) */
> +	exp = sgp40_exp(x, SGP40_CALC_POWER, 18);
> +	*voc = 500 * ((1 << (SGP40_CALC_POWER * 2)) / ((1<<SGP40_CALC_POWER) + exp));
> +
> +	dev_dbg(data->dev, "raw: %d res_calibbias: %d x: %d exp: %d voc: %d\n",
> +				resistance_raw, data->res_calibbias, x, exp, *voc);
> +
> +	return 0;
> +}
> +
> +static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance_raw)
> +{
> +	int ret;
> +	struct i2c_client *client = data->client;
> +	u32 ticks;
> +	u16 ticks16;
> +	u8 crc;
> +	struct sgp40_tg_measure tg = {.command = {0x26, 0x0F}};
> +	struct sgp40_tg_result tgres;
> +
> +	mutex_lock(&data->lock);
> +	
> +	ticks = (data->rht / 10) * 65535 / 10000;
> +	ticks16 = (u16)clamp(ticks, 0u, 65535u); /* clamp between 0 .. 100 %rH */
> +	tg.rht_ticks = cpu_to_be16(ticks16);
> +	tg.rht_crc = crc8(sgp40_crc8_table, (u8 *)&tg.rht_ticks, 2, SGP40_CRC8_INIT);
> +
> +	ticks = ((data->temp + 45000) / 10 ) * 65535 / 17500;
> +	ticks16 = (u16)clamp(ticks, 0u, 65535u); /* clamp between -45 .. +130 °C */
> +	tg.temp_ticks = cpu_to_be16(ticks16);
> +	tg.temp_crc = crc8(sgp40_crc8_table, (u8 *)&tg.temp_ticks, 2, SGP40_CRC8_INIT);
> +
> +	mutex_unlock(&data->lock);
> +
> +	ret = i2c_master_send(client, (const char *)&tg, sizeof(tg));
> +	if (ret != sizeof(tg)) {
> +		dev_warn(data->dev, "i2c_master_send ret: %d sizeof: %d\n", ret, sizeof(tg));
> +		return -EIO;
> +	}
> +	msleep(30);
> +
> +	ret = i2c_master_recv(client, (u8 *)&tgres, sizeof(tgres));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(tgres)) {
> +		dev_warn(data->dev, "i2c_master_recv ret: %d sizeof: %d\n", ret, sizeof(tgres));
> +		return -EIO;
> +	}
> +
> +	crc = crc8(sgp40_crc8_table, (u8 *)&tgres.res_ticks, 2, SGP40_CRC8_INIT);
> +	if (crc != tgres.res_crc) {
> +		dev_err(data->dev, "CRC error while measure-raw\n");
> +		return -EIO;
> +	}
> +
> +	*resistance_raw = be16_to_cpu(tgres.res_ticks);
> +
> +	return 0;
> +}
> +
> +static int sgp40_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan, int *val,
> +			int *val2, long mask)
> +{
> +	struct sgp40_data *data = iio_priv(indio_dev);
> +	int ret, voc;
> +	u16 resistance_raw;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_RESISTANCE:
> +			ret = sgp40_measure_resistance_raw(data, &resistance_raw);
> +			if (ret)
> +				return ret;
> +			*val = resistance_raw;
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			mutex_lock(&data->lock);
> +			*val = data->temp;
> +			mutex_unlock(&data->lock);
> +			return IIO_VAL_INT;
> +		case IIO_HUMIDITYRELATIVE:
> +			mutex_lock(&data->lock);
> +			*val = data->rht;
> +			mutex_unlock(&data->lock);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = sgp40_measure_resistance_raw(data, &resistance_raw);
> +		if (ret)
> +			return ret;

Nitpick:  I find it more readable to have a blank link after cases
like this where you have a function, followed by an error check block.

> +		ret = sgp40_calc_voc(data, resistance_raw, &voc);
> +		if (ret)
> +			return ret;
> +		*val = voc / (1 << SGP40_CALC_POWER);
> +		/*
> +		 * calculation should fit into integer, where:
> +		 * voc <= (500 * 2^SGP40_CALC_POWER) = 8192000
> +		 * (with SGP40_CALC_POWER = 14)
> +		 */
> +		*val2 = ((voc % (1 << SGP40_CALC_POWER)) * 244) / (1 << (SGP40_CALC_POWER - 12));
> +		dev_dbg(data->dev, "voc: %d val: %d.%06d\n", voc, *val, *val2);
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		mutex_lock(&data->lock);
> +		*val = data->res_calibbias;
> +		mutex_unlock(&data->lock);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int sgp40_write_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan, int val,
> +			int val2, long mask)
> +{
> +	struct sgp40_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			if ((val < -45000) || (val > 130000))
> +				return -EINVAL;
> +			mutex_lock(&data->lock);
> +			data->temp = val;
> +			mutex_unlock(&data->lock);
> +			return 0;
> +		case IIO_HUMIDITYRELATIVE:
> +			if ((val < 0) || (val > 100000))
> +				return -EINVAL;
> +			mutex_lock(&data->lock);
> +			data->rht = val;
> +			mutex_unlock(&data->lock);
> +			return 0;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if ((val < 20000) || (val > 52768))
> +			return -EINVAL;
> +		mutex_lock(&data->lock);
> +		data->res_calibbias = val;
> +		mutex_unlock(&data->lock);
> +		return 0;
> +	}
> +	return -EINVAL;

Trivial, but I'd put the return as a default: in the switch to make
it explicit that any other case is not valid at that level
(rather than down here).

> +}
> +
> +static const struct iio_info sgp40_info = {
> +	.read_raw	= sgp40_read_raw,
> +	.write_raw	= sgp40_write_raw,
> +};
> +
> +static int sgp40_probe(struct i2c_client *client,
> +		     const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct sgp40_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	data->dev = dev;
> +
> +	crc8_populate_msb(sgp40_crc8_table, SGP40_CRC8_POLYNOMIAL);
> +
> +	mutex_init(&data->lock);
> +
> +	/* set default values */
> +	data->rht = 50000;		/* 50 % */
> +	data->temp = 25000;		/* 25 °C */
> +	data->res_calibbias = 30000;	/* resistance raw value for voc index of 250 */
> +
> +	indio_dev->info = &sgp40_info;
> +	indio_dev->name = id->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = sgp40_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(sgp40_channels);
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		dev_err(dev, "failed to register iio device\n");
> +
> +	return ret;
> +}
> +
> +static const struct i2c_device_id sgp40_id[] = {
> +	{ "sgp40" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, sgp40_id);
> +
> +static const struct of_device_id sgp40_dt_ids[] = {
> +	{ .compatible = "sensirion,sgp40" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, sgp40_dt_ids);
> +
> +static struct i2c_driver sgp40_driver = {
> +	.driver = {
> +		.name = "sgp40",
> +		.of_match_table = sgp40_dt_ids,
> +	},
> +	.probe = sgp40_probe,
> +	.id_table = sgp40_id,
> +};
> +module_i2c_driver(sgp40_driver);
> +
> +MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> +MODULE_DESCRIPTION("Sensirion SGP40 gas sensor");
> +MODULE_LICENSE("GPL v2");

