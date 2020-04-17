Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F5B1AE7AA
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 23:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgDQVfe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 17:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725873AbgDQVfe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 17:35:34 -0400
Received: from ns.pmeerw.net (ns.pmeerw.net [IPv6:2001:1b60:2:23:1033:103:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9DCC061A0C
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2020 14:35:34 -0700 (PDT)
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id E8B0BE01FA; Fri, 17 Apr 2020 23:35:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1587159331; bh=n+DqsaDXHZxOdIpFr9h00l4C7n45G6/qwut5x8nocIA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=WfzHp47HQ4ZgfHbEu3/MY7JgjLIg4DANKdv3MO5ST3Puq0ZfWPnGmKGGOMlPMBIBS
         Pct5RKfqUcut5LeoFuCVkmxrHpx5JCaKBN0M91GGf4OJvypagu5YcMFaVSzSEGSWPI
         KQZFdPrndtYDcwXrLZNbp7SM0QQOxWOsPTkXzF4w=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id A78A6E01A3;
        Fri, 17 Apr 2020 23:35:31 +0200 (CEST)
Date:   Fri, 17 Apr 2020 23:35:31 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v9 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
In-Reply-To: <20200417182053.22213-3-i.mikhaylov@yadro.com>
Message-ID: <alpine.DEB.2.21.2004172332530.13042@vps.pmeerw.net>
References: <20200417182053.22213-1-i.mikhaylov@yadro.com> <20200417182053.22213-3-i.mikhaylov@yadro.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Apr 2020, Ivan Mikhaylov wrote:

some minor comments below

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
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/proximity/Kconfig    |  11 ++
>  drivers/iio/proximity/Makefile   |   1 +
>  drivers/iio/proximity/vcnl3020.c | 235 +++++++++++++++++++++++++++++++
>  3 files changed, 247 insertions(+)
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
> index 000000000000..59e1f59a3ed2
> --- /dev/null
> +++ b/drivers/iio/proximity/vcnl3020.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Support for Vishay VCNL3020 proximity sensor on i2c bus.
> + * Based on Vishay VCNL4000 driver code.
> + *
> + * TODO: interrupts.
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
> +#define VCNL3020_PROD_ID	0x21
> +
> +#define VCNL_COMMAND		0x80 /* Command register */
> +#define VCNL_PROD_REV		0x81 /* Product ID and Revision ID */
> +#define VCNL_PROXIMITY_RATE	0x82 /* Rate of Proximity Measurement */
> +#define VCNL_LED_CURRENT	0x83 /* IR LED current for proximity mode */
> +#define VCNL_PS_RESULT_HI	0x87 /* Proximity result register, MSB */
> +#define VCNL_PS_RESULT_LO	0x88 /* Proximity result register, LSB */
> +#define VCNL_PS_ICR		0x89 /* Interrupt Control Register  */

remove one space before */

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
> +/**
> + * struct vcnl3020_data - vcnl3020 specific data.
> + * @regmap:	device register map.
> + * @dev:	vcnl3020 device.
> + * @rev:	revision id.
> + * @lock:	lock for protecting access to device hardware registers.
> + */
> +struct vcnl3020_data {
> +	struct regmap *regmap;
> +	struct device *dev;
> +	u8 rev;
> +	struct mutex lock;
> +};
> +
> +static int vcnl3020_get_and_apply_property(struct vcnl3020_data *data,
> +					   const char *prop, u32 reg)
> +{
> +	int rc;
> +	u32 val;
> +
> +	rc = device_property_read_u32(data->dev, prop, &val);
> +	if (rc)
> +		return 0;
> +
> +	rc = regmap_write(data->regmap, reg, val);
> +	if (rc) {
> +		dev_err(data->dev, "Error (%d) setting property (%s)",

dev_err() needs \n (here and elsewhere)

> +			rc, prop);
> +	}
> +
> +	return rc;
> +}
> +
> +static int vcnl3020_init(struct vcnl3020_data *data)
> +{
> +	int rc;
> +	unsigned int reg;
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
> +	}
> +
> +	data->rev = reg;
> +	mutex_init(&data->lock);
> +
> +	return vcnl3020_get_and_apply_property(data,
> +					       "vishay,led-current-microamp",
> +					       VCNL_LED_CURRENT);
> +};
> +
> +static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
> +{
> +	int rc;
> +	unsigned int reg;
> +	__be16 res;
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
> +			"Error (%d) reading vcnl3020 command register", rc);
> +		goto err_unlock;
> +	}
> +
> +	/* high & low result bytes read */
> +	rc = regmap_bulk_read(data->regmap, VCNL_PS_RESULT_HI, &res,
> +			      sizeof(res));
> +	if (rc)
> +		goto err_unlock;
> +
> +	*val = be16_to_cpu(res);
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

there is only one channel, check not needed

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
> +	indio_dev->name = "vcnl3020";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
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
> +		.name   = "vcnl3020",
> +		.of_match_table = vcnl3020_of_match,
> +	},
> +	.probe_new  = vcnl3020_probe,
> +};
> +module_i2c_driver(vcnl3020_driver);
> +
> +MODULE_AUTHOR("Ivan Mikhaylov <i.mikhaylov@yadro.com>");
> +MODULE_DESCRIPTION("Vishay VCNL3020 proximity sensor driver");
> +MODULE_LICENSE("GPL");
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
