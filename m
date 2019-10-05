Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F271ECCA3E
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 16:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfJEOII (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 10:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfJEOIH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 10:08:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E44A222C0;
        Sat,  5 Oct 2019 14:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570284485;
        bh=IjfiFXApxA4NKxq8lVKJhMXA4QYBbj/tM904Zqf1GFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dxFgUmwlN3afEfqEwRUA86MGTnXdoKlgef6+wJ0u97F1fxfSygv9oQln98L3HBktW
         KSsSN2+YPIMiqZ4xyhiY/QzlGZP/6EAk7LzfXi7ndYueC982W7lTdBoO9YqdKAgsfw
         br+b6wDWkH1ugZlHHYbSCP6qR7N+PQDTPlXKsM8U=
Date:   Sat, 5 Oct 2019 15:08:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hslester96@gmail.com, wsa+renesas@sang-engineering.com
Subject: Re: [RESEND PATCH v2 1/3] iio: light: add driver for veml6030
 ambient light sensor
Message-ID: <20191005150800.406626e2@archlinux>
In-Reply-To: <82095eb7eceea7e5a69fe0bf45959a8b57144b27.1569321085.git.gupt21@gmail.com>
References: <cover.1569321085.git.gupt21@gmail.com>
        <82095eb7eceea7e5a69fe0bf45959a8b57144b27.1569321085.git.gupt21@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Sep 2019 16:21:56 +0530
Rishi Gupta <gupt21@gmail.com> wrote:

> veml6030 is an ambient light sensor from Vishay semiconductors.
> It has 16-bit resolution, supports both ambient light measurement
> and white channel which is more responsive to wider wavelength
> spectrum. It has flexible power saving, integration time and
> gain options. Communication with host is over I2C.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>

Generally looks good. Various comments inline.

Jonathan

> ---
> Changes in v2:
> * Added comma after CH_WHITE in enum veml6030_chan so it can be extended
> * Removed .scan_type as driver doesn't use buffered mode
> * Removed iio_device_unregister() as kernel will take care of cleaning
> 
>  drivers/iio/light/Kconfig    |  11 +
>  drivers/iio/light/Makefile   |   1 +
>  drivers/iio/light/veml6030.c | 633 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 645 insertions(+)
>  create mode 100644 drivers/iio/light/veml6030.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 08d7e1e..e455cec 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -495,6 +495,17 @@ config VCNL4035
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called vcnl4035.
>  
> +config VEML6030
> +	tristate "VEML6030 ambient light sensor"
> +	select REGMAP_I2C
> +	depends on I2C
> +	help
> +	  Say Y here if you want to build a driver for the Vishay VEML6030
> +	  ambient light sensor (ALS).
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called veml6030.
> +
>  config VEML6070
>  	tristate "VEML6070 UV A light sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 00d1f9b..5e0c40b 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_TSL4531)		+= tsl4531.o
>  obj-$(CONFIG_US5182D)		+= us5182d.o
>  obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
>  obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
> +obj-$(CONFIG_VEML6030)		+= veml6030.o
>  obj-$(CONFIG_VEML6070)		+= veml6070.o
>  obj-$(CONFIG_VL6180)		+= vl6180.o
>  obj-$(CONFIG_ZOPT2201)		+= zopt2201.o
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> new file mode 100644
> index 0000000..3f6b2bd
> --- /dev/null
> +++ b/drivers/iio/light/veml6030.c
> @@ -0,0 +1,633 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * VEML6030 Ambient Light Sensor
> + *
> + * Copyright (c) 2019, Rishi Gupta <gupt21@gmail.com>
> + *
> + * Datasheet: https://www.vishay.com/docs/84366/veml6030.pdf
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +#include <linux/regmap.h>
> +#include <linux/mutex.h>
> +#include <linux/interrupt.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +
> +/* Device registers */
> +#define VEML6030_REG_ALS_CONF    0x00
> +#define VEML6030_REG_ALS_WH      0x01
> +#define VEML6030_REG_ALS_WL      0x02
> +#define VEML6030_REG_ALS_PSM     0x03
> +#define VEML6030_REG_ALS_DATA    0x04
> +#define VEML6030_REG_WHITE_DATA  0x05
> +#define VEML6030_REG_ALS_INT     0x06
> +
> +/* Bit masks for specific functionality */
> +#define VEML6030_ALS_IT       GENMASK(9, 6)
> +#define VEML6030_PSM          GENMASK(2, 1)
> +#define VEML6030_ALS_PERS     GENMASK(5, 4)
> +#define VEML6030_ALS_GAIN     GENMASK(12, 11)
> +#define VEML6030_PSM_EN       BIT(0)
> +#define VEML6030_INT_TH_LOW   BIT(15)
> +#define VEML6030_INT_TH_HIGH  BIT(14)
> +#define VEML6030_ALS_INT_EN   BIT(1)
> +#define VEML6030_ALS_SD       BIT(0)
> +
> +struct veml6030_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +};
> +
> +static IIO_CONST_ATTR_INT_TIME_AVAIL("0.025 0.05 0.1 0.2 0.4 0.8");
> +
> +static struct attribute *veml6030_attributes[] = {
> +	&iio_const_attr_integration_time_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group veml6030_attr_group = {
> +	.attrs = veml6030_attributes,
> +};
> +
> +/*
> + * Scale is 1/gain. Value 0.125 is ALS gain x (1/8), 0.25 is
> + * ALS gain x (1/4), 1.0 = ALS gain x 1 and 2.0 is ALS gain x 2.
> + */
> +static ssize_t veml6030_scale_available(struct iio_dev *indio_dev,
> +	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
> +{
> +	return sprintf(buf, "%s\n", "0.125 0.25 1.0 2.0");

These can be more easily done with const attributes as well.
For this one we also have the option of using the callbacks in conjunction
with the _available masks in the chan_spec to generate this automatically.

> +}
> +
> +/*
> + * Persistence = 1/2/4/8 x integration time
> + * Minimum time for which light readings must stay above configured
> + * threshold to assert interrupt.
> + */
> +static ssize_t veml6030_persistence_available(struct iio_dev *indio_dev,
> +	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
> +{
> +	return sprintf(buf, "%s\n", "1 2 4 8");
> +}
> +
> +/*
> + * Power saving modes supported.
> + * 1/2/3/4 corresponds to PSM modes 1/2/3/4 respectively.
> + */
> +static ssize_t veml6030_psm_available(struct iio_dev *indio_dev,
> +	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
> +{
> +	return sprintf(buf, "%s\n", "1 2 3 4");
> +}
> +
> +ssize_t veml6030_set_psm(struct iio_dev *indio_dev, uintptr_t priv,
> +			const struct iio_chan_spec *chan, const char *buf,
> +			size_t len)
> +{
> +	int ret;
> +	unsigned int val;
> +	struct veml6030_data *data = iio_priv(indio_dev);
> +
> +	ret = kstrtouint(buf, 0, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (val < 1 || val > 4)
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
> +				 VEML6030_PSM | VEML6030_PSM_EN, val - 1);
> +	if (ret) {
> +		dev_err(&data->client->dev,
> +				"can't update psm value %d\n", ret);
> +		return ret;
> +	}
> +
> +	return len;
> +}
> +
> +#define VEML6030_AVAIL(_name, _read) \
> +{ \
> +	.name = (_name "_available"), \
> +	.read = _read, \
> +	.shared = IIO_SEPARATE, \
> +}
> +
> +static const struct iio_chan_spec_ext_info veml6030_ext_info[] = {
> +	{
> +		.name = "psm",
> +		.write = veml6030_set_psm,
> +		.shared = IIO_SEPARATE,

Hmm. Power saving modes.  These normally correspond to something very
specific such as reduced accuracy of slow sampling rates.  A user
will have no idea how to set a magic mode 1 or mode 2 variable so
that should be avoided if possible.

Here it seems fairly directly connected to the fastest a reading can
be taken, which corresponds to samping_frequency (kind of anyway)
> +	},
> +	VEML6030_AVAIL("psm", veml6030_psm_available),
> +	VEML6030_AVAIL("scale", veml6030_scale_available),

The use of scale currently is a bit odd. It's the value that should be
applied to the raw sensor reading to get a value of illuminance in lux.
As before, name it fully to match the channel.  Side effect is that
will then be covered by generic docs so no need to add your own.

> +	VEML6030_AVAIL("period", veml6030_persistence_available),

As this events only exist for one type of channel, I'd give
them the full name to just put _period on the end of the one
generated by the events.  This is also only relevant to events
so should be in the events directory.

 
> +	{ },
> +};
> +
> +static const struct iio_event_spec veml6030_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +/*
> + * This is used to specify both scan index and numerical
> + * channel number in channel specifications.
> + */
> +enum veml6030_chan {
> +	CH_ALS,
> +	CH_WHITE,
> +};
> +
> +static const struct iio_chan_spec veml6030_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.channel = CH_ALS,
> +		.scan_index = CH_ALS,

You didn't get a reply on the previous version to your question on this.
scan_index is only used in buffered mode so you don't need it here.

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_SCALE),
> +		.event_spec = veml6030_event_spec,
> +		.num_event_specs = ARRAY_SIZE(veml6030_event_spec),

As mentioned below... With optional interrupts you want two versions
of this and pick one dependent on whether the interrupts are available
or not.  That way we don't expose interfaces that can't work.

> +		.ext_info = veml6030_ext_info,
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.channel = CH_WHITE,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_BOTH,
> +		.scan_index = CH_WHITE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> +	},
> +};
> +
> +static const struct regmap_config veml6030_regmap_config = {
> +	.name = "veml6030_regmap",
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = VEML6030_REG_ALS_INT,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +};
> +
> +static int veml6030_set_als_gain(struct iio_dev *indio_dev,
> +						int val, int val2)
> +{
> +	int ret, gain;
> +	struct veml6030_data *data = iio_priv(indio_dev);
> +
> +	if (val == 0 && val2 == 125000)
> +		gain = 0x02;
> +	else if (val == 0 && val2 == 250000)
> +		gain = 0x03;
> +	else if (val == 1 && val2 == 0)
> +		gain = 0x00;
> +	else if (val == 2 && val2 == 0)
> +		gain = 0x01;
> +	else
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
> +					VEML6030_ALS_GAIN, gain);
> +	if (ret) {
> +		dev_err(&data->client->dev,
> +				"can't set ALS gain %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int veml6030_set_als_persistence(struct iio_dev *indio_dev,
> +						int val, int val2)
> +{
> +	int ret;
> +	struct veml6030_data *data = iio_priv(indio_dev);
> +
> +	if (val < 0 || val > 8 || hweight8(val) != 1 || val2)
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
> +					VEML6030_ALS_PERS, val);
> +	if (ret) {
> +		dev_err(&data->client->dev,
> +				"can't set persistence value %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int veml6030_set_als_threshold(struct iio_dev *indio_dev,
> +						int val, int val2, int dir)
> +{
> +	int ret;
> +	struct veml6030_data *data = iio_priv(indio_dev);
> +
> +	if (val > 0xFFFF || val < 0 || val2)
> +		return -EINVAL;
> +
> +	if (dir == IIO_EV_DIR_RISING) {
> +		ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, val);
> +		if (ret)
> +			dev_err(&data->client->dev,
> +					"can't set high threshold %d\n", ret);
> +	} else {
> +		ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, val);
> +		if (ret)
> +			dev_err(&data->client->dev,
> +					"can't set low threshold %d\n", ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int veml6030_set_integration_time(struct iio_dev *indio_dev,
> +						int val, int val2)
> +{
> +	int ret, int_time;
> +	struct veml6030_data *data = iio_priv(indio_dev);
> +
> +	if (val)
> +		return -EINVAL;
> +
> +	switch (val2) {
> +	case 25000:
> +		int_time = 12;
> +		break;
> +	case 50000:
> +		int_time = 8;
> +		break;
> +	case 100000:
> +		int_time = 0;
> +		break;
> +	case 200000:
> +		int_time = 1;
> +		break;
> +	case 400000:
> +		int_time = 2;
> +		break;
> +	case 800000:
> +		int_time = 3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
> +					VEML6030_ALS_IT, int_time);
> +	if (ret) {
> +		dev_err(&data->client->dev,
> +				"can't update integration time %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Light reading in lux is obtained by multiplying a constant
> + * specified in appnote 84367 in the lux calculation table
> + * to the raw reading.

If it's an actual constant then we should provide SCALE to allow
userspace to apply it.

> + */
> +static int veml6030_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	int ret, rdval;
> +	struct veml6030_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = regmap_read(regmap, VEML6030_REG_ALS_DATA, &rdval);
> +			if (ret < 0) {
> +				dev_err(&data->client->dev, "can't read ALS data\n");
> +				return ret;
> +			}
> +			*val = rdval;
> +			return IIO_VAL_INT;
> +		case IIO_INTENSITY:
> +			ret = regmap_read(regmap, VEML6030_REG_WHITE_DATA, &rdval);
> +			if (ret < 0) {
> +				dev_err(&data->client->dev, "can't read white data\n");
> +				return ret;
> +			}
> +			*val = rdval;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int veml6030_write_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int val, int val2, long mask)
> +{
> +	switch (mask) {

You should be able to read either of these back as well so would expect
to see the code for that in read_raw.

> +	case IIO_CHAN_INFO_INT_TIME:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			return veml6030_set_integration_time(indio_dev, val, val2);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			return veml6030_set_als_gain(indio_dev, val, val2);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int veml6030_write_thresh(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan, enum iio_event_type type,
> +		enum iio_event_direction dir, enum iio_event_info info,
> +		int val, int val2)
> +{
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		return veml6030_set_als_threshold(indio_dev, val, val2, dir);
> +	case IIO_EV_INFO_PERIOD:
> +		return veml6030_set_als_persistence(indio_dev, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int veml6030_write_interrupt_config(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan, enum iio_event_type type,
> +		enum iio_event_direction dir, int state)
> +{
> +	int ret;
> +	struct veml6030_data *data = iio_priv(indio_dev);
> +
> +	if (!data->client->irq || state < 0 || state > 1)

So shouldn't be possible to get here if you don't have an irq.
Also, fairly sure it can't pass you anything other than 0 or 1.

See below for what you should change so you can't get here if
no interrupt.

> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
> +					VEML6030_ALS_INT_EN, state);
> +	if (ret) {
> +		dev_err(&data->client->dev,
> +				"can't enable threshold interrupt %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_info veml6030_info = {
> +	.read_raw  = veml6030_read_raw,
> +	.write_raw = veml6030_write_raw,
> +	.write_event_value	= veml6030_write_thresh,
> +	.write_event_config	= veml6030_write_interrupt_config,
> +	.attrs = &veml6030_attr_group,
> +};
> +
> +static irqreturn_t veml6030_event_handler(int irq, void *private)
> +{
> +	int ret, reg, evtdir;
> +	struct iio_dev *indio_dev = private;
> +	struct veml6030_data *data = iio_priv(indio_dev);
> +
> +	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &reg);
> +	if (ret) {
> +		dev_err(&data->client->dev,
> +				"can't enable interrupt status %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	/* Spurious interrupt handling */
> +	if (!(reg & (VEML6030_INT_TH_HIGH | VEML6030_INT_TH_LOW)))

If it's spurious, return IRQ_NONE;  That will allow the core kernel
spurious interrupt handling to know it's going on and take measures
as appropriate to block what is probably broken hardware.

> +		return IRQ_HANDLED;
> +
> +	if (reg & VEML6030_INT_TH_HIGH)
> +		evtdir = IIO_EV_DIR_RISING;
> +	else
> +		evtdir = IIO_EV_DIR_FALLING;
> +
> +	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
> +					0, IIO_EV_TYPE_THRESH, evtdir),
> +					iio_get_time_ns(indio_dev));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Corresponding to 1200 ms as refresh time, set ALS gain to
> + * ALS gain x 2, integration time to 200 ms and PSM to mode 2.
> + * Set persistence to 1 x integration time, and the threashold
> + * interrupt disabled by default.
> + */
> +static int veml6030_hw_init(struct iio_dev *indio_dev)
> +{
> +	int ret, val;
> +	struct veml6030_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +
> +	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF, 0x850);

I assume this is the call we 'unwind' when we call the stuff in remove.
So add the devm_add_action_or_reset after this so that we will have
correct handling for errors later in this function.

> +	if (ret) {
> +		dev_err(&client->dev, "can't setup ALS configs %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Wait 4 ms to let processor & oscillator start correctly */
> +	usleep_range(3990, 4000);
> +
> +	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
> +				 VEML6030_PSM | VEML6030_PSM_EN, 0x03);
> +	if (ret) {
> +		dev_err(&client->dev, "can't setup defaults for PSM %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
> +	if (ret) {
> +		dev_err(&client->dev, "can't read high threshold %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
> +	if (ret) {
> +		dev_err(&client->dev, "can't read low threshold %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Clear stale interrupt status bits if any during start */
> +	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"can't read ALS interrupt status %d\n", ret);
> +		return ret;

Drop the return ret.. See below. I'm lazy so won't comment on any more of htese.

> +	}
> +
> +	return ret;
> +}
> +
> +static int veml6030_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct veml6030_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&client->dev, "i2c adapter doesn't support plain i2c\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	regmap = devm_regmap_init_i2c(client, &veml6030_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "can't setup regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	data->regmap = regmap;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &veml6030_info;
> +	indio_dev->name = "veml6030";
> +	indio_dev->channels = veml6030_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(veml6030_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	if (client->irq) {

If interrupts are optional, you need to provide a separate chan_spec array
that doesn't define the events.  We simply don't want the interface to appear
if we can't support it.

> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL, veml6030_event_handler,
> +						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +						"veml6030", indio_dev);
> +		if (ret < 0) {
> +			dev_err(&client->dev,
> +					"irq %d request failed\n", client->irq);
> +			return ret;
> +		}
> +	}
> +
> +	ret = veml6030_hw_init(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);

If this fails I think we should be doing the same stuff as in remove
to turn the device off?  Note that the devm_add_action_or_reset
method suggested below will avoid the need to do that manually.

> +}
> +
> +static int veml6030_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct veml6030_data *data = iio_priv(indio_dev);
> +
> +	regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
> +				 VEML6030_ALS_SD, 0x01);

This gets run before the userspace interfaces are removed when
devm management clears up the devm_iio_device_register.

This we have a nasty race where the device is off by userspace
calls can still come in.

Probably a case of calling devm_add_action_or_reset at appropriate
place in probe to ensure that everything occurs in the right order.
Then you can just git rid of the remove function entirely.

> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
There is a general move away from using ifdef CONFIG_PM in
favour of marking these functions
__maybe_unused.

Ends up simpler and tends to reduce the number of esoteric
build issues.

> +static int veml6030_runtime_suspend(struct device *dev)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct veml6030_data *data = iio_priv(indio_dev);
> +
> +	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
> +				 VEML6030_ALS_SD, 0x01);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +				"can't suspend veml6030 light sensor\n");
> +		return ret;

Drop this return ret, the one below does the same thing and one
of the static analysers will fire on this and we'll get a 'fix'
fairly quickly if we don't do it now ;)

> +	}
> +
> +	return ret;
> +}
> +
> +static int veml6030_runtime_resume(struct device *dev)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct veml6030_data *data = iio_priv(indio_dev);
> +
> +	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
> +				 VEML6030_ALS_SD, 0x00);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +				"can't resume veml6030 light sensor\n");
> +		return ret;

Drop the return ret here. The one below will do the same thing.

> +	}
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops veml6030_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(veml6030_runtime_suspend,
> +				veml6030_runtime_resume, NULL)
> +};
> +#endif
> +
> +static const struct of_device_id veml6030_of_match[] = {
> +	{ .compatible = "vishay,veml6030" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, veml6030_of_match);
> +
> +static const struct i2c_device_id veml6030_id[] = {
> +	{ "veml6030", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, veml6030_id);
> +
> +static struct i2c_driver veml6030_driver = {
> +	.driver = {
> +		.name = "veml6030",
> +		.of_match_table = of_match_ptr(veml6030_of_match),

Don't use of_match_ptr.  Since we now have the magic PRP001
ACPI device type which uses the device tree match, we should
ensure it's always visible.

> +#ifdef CONFIG_PM
> +		.pm = &veml6030_pm_ops,

If you use the __maybe_unused stuff above and assign it without
the ifdef it should be fine (and cleaner code).

> +#endif
> +	},
> +	.probe = veml6030_probe,
> +	.remove = veml6030_remove,
> +	.id_table = veml6030_id,
> +};
> +module_i2c_driver(veml6030_driver);
> +
> +MODULE_AUTHOR("Rishi Gupta <gupt21@gmail.com>");
> +MODULE_DESCRIPTION("VEML6030 Ambient Light Sensor");
> +MODULE_LICENSE("GPL v2");

