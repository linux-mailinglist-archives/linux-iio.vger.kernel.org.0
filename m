Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704296F5A6
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2019 22:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfGUUsG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jul 2019 16:48:06 -0400
Received: from ns.pmeerw.net ([84.19.176.117]:57634 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbfGUUsG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jul 2019 16:48:06 -0400
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id B533BE054E; Sun, 21 Jul 2019 22:48:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1563742083; bh=1bbfPRmrtFTOoJQYyQIxRHsMVgsD8LqVnMXdLlnz5Fs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BGx2IactVOaq95xcU0mz84kI9Dz+rs3AM8FgRp5HYVs9ms9hgg0pmHpWKHLM9wLYY
         Wa18G7ibForMB2pnvHFrUZZFWCVauik4GJvOxiSBNjSHUzGKunKjd7sx0rEtTKB4In
         Dx0DPrWggVWbh9sHMQgU0bfunISGO5m8QPUEeL9w=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 7F331E0184;
        Sun, 21 Jul 2019 22:48:03 +0200 (CEST)
Date:   Sun, 21 Jul 2019 22:48:03 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Martin Kaiser <martin@kaiser.cx>
cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: potentiometer: add a driver for Maxim 5432-5435
In-Reply-To: <20190721175915.27192-1-martin@kaiser.cx>
Message-ID: <alpine.DEB.2.21.1907212242370.9148@vps.pmeerw.net>
References: <20190721175915.27192-1-martin@kaiser.cx>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 21 Jul 2019, Martin Kaiser wrote:

> Add a driver for the Maxim Integrated MAX5432-MAX5435 family of digital
> potentiometers.
> 
> These potentiometers are connected via I2C and have 32 wiper positions.
> 
> Supported functionality
> - set the volatile wiper position
> - read the potentiometer scale

please see some minor comment below
 
> Datasheet:
> https://datasheets.maximintegrated.com/en/ds/MAX5432-MAX5435.pdf
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  .../bindings/iio/potentiometer/max5432.txt         |  22 ++++
>  drivers/iio/potentiometer/Kconfig                  |  11 ++
>  drivers/iio/potentiometer/Makefile                 |   1 +
>  drivers/iio/potentiometer/max5432.c                | 131 +++++++++++++++++++++
>  4 files changed, 165 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/max5432.txt
>  create mode 100644 drivers/iio/potentiometer/max5432.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/max5432.txt b/Documentation/devicetree/bindings/iio/potentiometer/max5432.txt
> new file mode 100644
> index 000000000000..89ccc8fc7df1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/max5432.txt
> @@ -0,0 +1,22 @@
> +* Maxim Integrated MAX5432-MAX5435 Digital Potentiometers.
> +
> +The node for this driver must be a child node of an I2C controller, hence
> +all mandatory properties for your controller must be specified. See directory:
> +
> +        Documentation/devicetree/bindings/i2c
> +
> +for more details.
> +
> +Required properties:
> +	- compatible:  	Must be one of the following, depending on the
> +			model:
> +			"maxim,max5432"
> +			"maxim,max5433"
> +			"maxim,max5434"
> +			"maxim,max5435"
> +
> +Example:
> +max5434@28 {
> +	compatible = "maxim,max5434";
> +	reg = <0x28>;
> +};
> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> index ebc7c72a5e36..4cac0173db8b 100644
> --- a/drivers/iio/potentiometer/Kconfig
> +++ b/drivers/iio/potentiometer/Kconfig
> @@ -26,6 +26,17 @@ config DS1803
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ds1803.
>  
> +config MAX5432
> +	tristate "Maxim MAX5432-MAX5435 Digital Potentiometer driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the Maxim
> +	  MAX5432, MAX5433, MAX5434 and MAX5435 digital
> +	  potentiometer chips.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called max5432.
> +
>  config MAX5481
>  	tristate "Maxim MAX5481-MAX5484 Digital Potentiometer driver"
>  	depends on SPI
> diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
> index 8ff55138cf12..091adf3cdd0b 100644
> --- a/drivers/iio/potentiometer/Makefile
> +++ b/drivers/iio/potentiometer/Makefile
> @@ -6,6 +6,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD5272) += ad5272.o
>  obj-$(CONFIG_DS1803) += ds1803.o
> +obj-$(CONFIG_MAX5432) += max5432.o
>  obj-$(CONFIG_MAX5481) += max5481.o
>  obj-$(CONFIG_MAX5487) += max5487.o
>  obj-$(CONFIG_MCP4018) += mcp4018.o
> diff --git a/drivers/iio/potentiometer/max5432.c b/drivers/iio/potentiometer/max5432.c
> new file mode 100644
> index 000000000000..959883297fb5
> --- /dev/null
> +++ b/drivers/iio/potentiometer/max5432.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Maxim Integrated MAX5432-MAX5435 digital potentiometer driver
> + * Copyright (C) 2019 Martin Kaiser <martin@kaiser.cx>
> + *
> + * Datasheet:
> + * https://datasheets.maximintegrated.com/en/ds/MAX5432-MAX5435.pdf
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +/* All chip variants have 32 wiper positions. */
> +#define MAX5432_MAX_POS 31
> +
> +#define OHM_50K   (50  * 1000)
> +#define OHM_100K  (100 * 1000)

MAX5432_ prefix please

> +
> +/* Update the volatile (currently active) setting. */
> +#define CMD_VREG  0x11

MAX5432_ prefix please

> +
> +struct max5432_data {
> +	struct i2c_client *client;
> +	u32 ohm;
> +};
> +
> +static const struct iio_chan_spec max5432_channels[] = {
> +	{
> +		.type = IIO_RESISTANCE,
> +		.indexed = 1,
> +		.output = 1,
> +		.channel = 0,
> +		.address = CMD_VREG,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +	}
> +};
> +
> +static int max5432_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct max5432_data *data = iio_priv(indio_dev);
> +
> +	if (mask != IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
> +
> +	*val = data->ohm;
> +	*val2 = MAX5432_MAX_POS;
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int max5432_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct max5432_data *data = iio_priv(indio_dev);
> +	u8 data_byte;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	if (val < 0 || val > MAX5432_MAX_POS)
> +		return -EINVAL;
> +
> +	if (val2 != 0)
> +		return -EINVAL;
> +
> +	/* Wiper position is in bits D7-D3. (D2-D0 are don't care bits.) */
> +	data_byte = val << 3;
> +	return i2c_smbus_write_byte_data(
> +			data->client, chan->address, data_byte);
> +}
> +
> +static const struct iio_info max5432_info = {
> +	.read_raw = max5432_read_raw,
> +	.write_raw = max5432_write_raw,
> +};
> +
> +static int max5432_probe(
> +		struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct max5432_data *data;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct max5432_data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	data->ohm = (u32)of_device_get_match_data(dev);
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &max5432_info;
> +	indio_dev->channels = max5432_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max5432_channels);
> +	indio_dev->name = client->name;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id max5432_dt_ids[] = {
> +	{ .compatible = "maxim,max5432", .data = (void *)OHM_50K  },
> +	{ .compatible = "maxim,max5433", .data = (void *)OHM_100K },
> +	{ .compatible = "maxim,max5434", .data = (void *)OHM_50K  },
> +	{ .compatible = "maxim,max5435", .data = (void *)OHM_100K },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, max5432_dt_ids);
> +
> +static struct i2c_driver max5432_driver = {
> +	.driver = {
> +		.name = "max5432",
> +		.of_match_table = of_match_ptr(max5432_dt_ids),
> +	},
> +	.probe = max5432_probe,
> +};
> +
> +module_i2c_driver(max5432_driver);
> +
> +MODULE_AUTHOR("Martin Kaiser <martin@kaiser.cx>");
> +MODULE_DESCRIPTION("max5432-max5435 digital potentiometers");
> +MODULE_LICENSE("GPL v2");
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
