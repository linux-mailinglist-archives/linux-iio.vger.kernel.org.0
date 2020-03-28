Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A68D1966D8
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 16:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgC1PLI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 11:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgC1PLH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 11:11:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB6D206F6;
        Sat, 28 Mar 2020 15:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585408266;
        bh=Fe9zhSwJ5QAs2Kb5+aXvc9U3TUB8eW3NdD3AmEeqjUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JlehlLGDkHC9uS1dT26jBLADc2pP3L+7hGTDcQB5j0feGRHO0cJ6yY+KdyUGjEUT0
         ppK/E3KTXrtIGbdXvleorkgpTwvcvkS2k8WTJXXa1JrqG1ck6A6d/wlitdKI9Ebi1h
         4U3KCHZW6r5NFh7JWoDIkATuqNW0JOsd27UzoL6o=
Date:   Sat, 28 Mar 2020 15:11:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
Message-ID: <20200328151102.4279cb42@archlinux>
In-Reply-To: <20200327104954.27829-3-i.mikhaylov@yadro.com>
References: <20200327104954.27829-1-i.mikhaylov@yadro.com>
        <20200327104954.27829-3-i.mikhaylov@yadro.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Mar 2020 13:49:54 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Proximity sensor driver based on light/vcnl4000.c code.
> For now supports only the single on-demand measurement.
> 
> The VCNL3020 is a fully integrated proximity sensor. Fully
> integrated means that the infrared emitter is included in the
> package. It has 16-bit resolution. It includes a signal
> processing IC and features standard I2C communication
> interface. It features an interrupt function.
> 
> Datasheet: http://www.vishay.com/docs/84150/vcnl3020.pdf
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
A few things inline.

I note Andy suggested a Datasheet tag, but has it actually been
standardised? 

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/Kconfig    |  11 ++
>  drivers/iio/proximity/Makefile   |   1 +
>  drivers/iio/proximity/vcnl3020.c | 232 +++++++++++++++++++++++++++++++
>  3 files changed, 244 insertions(+)
>  create mode 100644 drivers/iio/proximity/vcnl3020.c
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index d53601447da4..b8d2b17e60ac 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -112,6 +112,17 @@ config SRF08
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called srf08.
>  
> +config VCNL3020
> +	tristate "VCNL3020 proximity sensor"
> +	select REGMAP_I2C
> +	depends on I2C
> +	help
> +	  Say Y here if you want to build a driver for the Vishay VCNL3020
> +	  proximity sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called vcnl3020.
> +
>  config VL53L0X_I2C
>  	tristate "STMicroelectronics VL53L0X ToF ranger sensor (I2C)"
>  	depends on I2C
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index 0bb5f9de13d6..8245978ced30 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -12,5 +12,6 @@ obj-$(CONFIG_RFD77402)		+= rfd77402.o
>  obj-$(CONFIG_SRF04)		+= srf04.o
>  obj-$(CONFIG_SRF08)		+= srf08.o
>  obj-$(CONFIG_SX9500)		+= sx9500.o
> +obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
>  obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
>  
> diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
> new file mode 100644
> index 000000000000..fcde509238f9
> --- /dev/null
> +++ b/drivers/iio/proximity/vcnl3020.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Support for Vishay VCNL3020 proximity sensor on i2c bus.
> + * Based on Vishay VCNL4000 driver code.
> + *
> + * TODO: interrupts.

Those aren't in the binding doc and they should be.  
The binding documents the hardware, not what we've implemented support
for in the driver.

On that note its also worth documenting the vdd regulator in the binding
from the start, even if the driver currently assumes its always on.

Also a regulator for the LED probably makes sense as well.

> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define VCNL_DRV_NAME		"vcnl3020"
> +#define VCNL_REGMAP_NAME	"vcnl3020_regmap"
> +#define VCNL3020_PROD_ID	0x21
> +
> +#define VCNL_COMMAND		0x80 /* Command register */
> +#define VCNL_PROD_REV		0x81 /* Product ID and Revision ID */
> +#define VCNL_PROXIMITY_RATE	0x82 /* Rate of Proximity Measurement */
> +#define VCNL_LED_CURRENT	0x83 /* IR LED current for proximity mode */
> +#define VCNL_PS_RESULT_HI	0x87 /* Proximity result register, MSB */
> +#define VCNL_PS_RESULT_LO	0x88 /* Proximity result register, LSB */
> +#define VCNL_PS_ICR		0x89 /* Interrupt Control Register  */
> +
> +#define VCNL_PS_LO_THR_HI	0x8a /* High byte of low threshold value */
> +#define VCNL_PS_LO_THR_LO	0x8b /* Low byte of low threshold value */
> +#define VCNL_PS_HI_THR_HI	0x8c /* High byte of high threshold value */
> +#define VCNL_PS_HI_THR_LO	0x8d /* Low byte of high threshold value */
> +#define VCNL_ISR		0x8e /* Interrupt Status Register */
> +#define VCNL_PS_MOD_ADJ		0x8f /* Proximity Modulator Timing Adjustment */
> +
> +/* Bit masks for COMMAND register */
> +#define VCNL_PS_RDY		BIT(5) /* proximity data ready? */
> +#define VCNL_PS_OD		BIT(3) /* start on-demand proximity
> +					* measurement
> +					*/
> +
> +#define VCNL_ON_DEMAND_TIMEOUT_US	100000
> +#define VCNL_POLL_US			20000
> +
> +struct vcnl3020_data {
> +	struct regmap *regmap;
> +	struct device *dev;
> +	u8 rev;
> +	struct mutex lock;

All locks need documentation. What is this one protecting?
Looks like it protects against multiple concurrent samples being
triggered, but needs a bit of doc to say that.

> +};
> +
> +static int vcnl3020_init(struct vcnl3020_data *data)
> +{
> +	int rc;
> +	unsigned int reg;
> +	u32 led_current;
> +
> +	rc = device_property_read_u32(data->dev, "led-current", &led_current);

The presence of a firmware read (dt / acpi etc) means that the i2c id table
isn't actually useful for probing.

> +	if (rc) {
> +		dev_err(data->dev, "Couldn't get led current (%d)", rc);
> +		return rc;
> +	}
> +
> +	rc = regmap_read(data->regmap, VCNL_PROD_REV, &reg);
> +	if (rc) {
> +		dev_err(data->dev,
> +			"Error (%d) reading product revision", rc);
> +		return rc;
> +	}
> +
> +	if (reg != VCNL3020_PROD_ID) {
> +		dev_err(data->dev,
> +			"Product id (%x) did not match vcnl3020 (%x)", reg,
> +			VCNL3020_PROD_ID);
> +		return -ENODEV;
> +	} else {

As Andy said, this is main flow so the else isn't helpful.

> +		data->rev = reg;
> +		mutex_init(&data->lock);
> +	}
> +
> +	/* set led current */
> +	rc = regmap_write(data->regmap, VCNL_LED_CURRENT, led_current);
> +	if (rc)
> +		dev_err(data->dev, "Error (%d) setting LED current", rc);
> +
> +	return rc;
> +};
> +
> +static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
> +{
> +	int rc;
> +	unsigned int reg;
> +	unsigned int hi, lo;
> +
> +	mutex_lock(&data->lock);
> +
> +	rc = regmap_write(data->regmap, VCNL_COMMAND, VCNL_PS_OD);
> +	if (rc)
> +		goto err_unlock;
> +
> +	/* wait for data to become ready */
> +	rc = regmap_read_poll_timeout(data->regmap, VCNL_COMMAND, reg,
> +				      reg & VCNL_PS_RDY, VCNL_POLL_US,
> +				      VCNL_ON_DEMAND_TIMEOUT_US);
> +	if (rc) {
> +		dev_err(data->dev,
> +			"vcnl3020_measure() failed, data is not ready");

You don't actually know that.  Could be a different type of error.

> +		goto err_unlock;
> +	}
> +
> +	rc = regmap_read(data->regmap, VCNL_PS_RESULT_HI, &hi);
> +	if (rc)
> +		goto err_unlock;
> +	dev_dbg(data->dev, "result high byte 0x%x", hi);
> +
> +	rc = regmap_read(data->regmap, VCNL_PS_RESULT_LO, &lo);
> +	if (rc)
> +		goto err_unlock;

These are neigbouring registers.  Can you not get away with a bulk read?
The datasheet suggests the device does auto address incrementing.

If you do that, you can read directly into an __be16/__le16 (I haven't
checked which) and do an endian conversion to whatever the cpu is
using.

> +	dev_dbg(data->dev, "result low byte 0x%x", lo);

This doesn't feel like debug info that is likely to be of much use
now you've finished development.  I'd drop these.

> +	*val = (hi << 8) | lo;
> +
> +err_unlock:
> +	mutex_unlock(&data->lock);
> +
> +	return rc;
> +}
> +
> +static const struct iio_chan_spec vcnl3020_channels[] = {
> +	{
> +		.type = IIO_PROXIMITY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +};
> +
> +static int vcnl3020_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	int rc;
> +	struct vcnl3020_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			rc = vcnl3020_measure_proximity(data, val);
> +			if (rc)
> +				return rc;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info vcnl3020_info = {
> +	.read_raw = vcnl3020_read_raw,
> +};
> +
> +static const struct regmap_config vcnl3020_regmap_config = {
> +	.name		= VCNL_REGMAP_NAME,
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.max_register	= VCNL_PS_MOD_ADJ,
> +};
> +
> +static int vcnl3020_probe(struct i2c_client *client)
> +{
> +	struct vcnl3020_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int rc;
> +
> +	regmap = devm_regmap_init_i2c(client, &vcnl3020_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "regmap_init failed!");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->regmap = regmap;
> +	data->dev = &client->dev;
> +
> +	rc = vcnl3020_init(data);
> +	if (rc)
> +		return rc;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &vcnl3020_info;
> +	indio_dev->channels = vcnl3020_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(vcnl3020_channels);
> +	indio_dev->name = VCNL_DRV_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id vcnl3020_id[] = {
> +	{ "vcnl3020", 0 },
> +	{}
As noted above, you require properties that can't be passed
(I think) without DT hence this table doesn't add anything.
I would drop it.

> +};
> +MODULE_DEVICE_TABLE(i2c, vcnl3020_id);
> +
> +static const struct of_device_id vcnl3020_of_match[] = {
> +	{
> +		.compatible = "vishay,vcnl3020",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, vcnl3020_of_match);
> +
> +static struct i2c_driver vcnl3020_driver = {
> +	.driver = {
> +		.name   = VCNL_DRV_NAME,
> +		.of_match_table = vcnl3020_of_match,
> +	},
> +	.probe_new  = vcnl3020_probe,
> +	.id_table = vcnl3020_id,
> +};
> +module_i2c_driver(vcnl3020_driver);
> +
> +MODULE_AUTHOR("Ivan Mikhaylov <i.mikhaylov@yadro.com>");
> +MODULE_DESCRIPTION("Vishay VCNL3020 proximity sensor driver");
> +MODULE_LICENSE("GPL");

