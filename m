Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E99B77BDE
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 22:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbfG0UpX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 16:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387841AbfG0UpX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 16:45:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 492C4208C0;
        Sat, 27 Jul 2019 20:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564260321;
        bh=A1PdOKszTAGl5fiZWpfKH86z55fMJaC6POxIAbJ4wG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wuGR9Kbx03H8c2eCPcN4QD00+s9wIgJwS8gT74lchSAgG2iq7pazt3eiCWWHEPQtJ
         YwrEiI22Hp7l/Oatc5MltaSi6leB/rQvibFy7YBCQ1FvnLRduq0nOfF7o4ImuiZt/U
         y1LbHgPLQ8LIXchNsfxouTpUOrfLT8WhCFi9SZ7I=
Date:   Sat, 27 Jul 2019 21:45:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: potentiometer: add a driver for Maxim 5432-5435
Message-ID: <20190727214517.165dcf0f@archlinux>
In-Reply-To: <20190723085324.11318-1-martin@kaiser.cx>
References: <20190721175915.27192-1-martin@kaiser.cx>
        <20190723085324.11318-1-martin@kaiser.cx>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Jul 2019 10:53:24 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> Add a driver for the Maxim Integrated MAX5432-MAX5435 family of digital
> potentiometers.
> 
> These potentiometers are connected via I2C and have 32 wiper positions.
> 
> Supported functionality
> - set the volatile wiper position
> - read the potentiometer scale
> 
> Datasheet:
> https://datasheets.maximintegrated.com/en/ds/MAX5432-MAX5435.pdf
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

A few trivials and I'm afraid you posted after I'd made the decision to only
accept new DT bindings for IIO in yaml format.  

Thanks,

Jonathan

> ---
> changes in v2
>  - use MAX5432_ prefix for all defines
>  - fix indentation
>  - convert void * to unsigned long, not to u32
>    (warning from kbuild test robot)
> 
>  .../bindings/iio/potentiometer/max5432.txt         |  21 ++++
>  drivers/iio/potentiometer/Kconfig                  |  11 ++
>  drivers/iio/potentiometer/Makefile                 |   1 +
>  drivers/iio/potentiometer/max5432.c                | 135 +++++++++++++++++++++
>  4 files changed, 168 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/max5432.txt
>  create mode 100644 drivers/iio/potentiometer/max5432.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/max5432.txt b/Documentation/devicetree/bindings/iio/potentiometer/max5432.txt
> new file mode 100644
> index 000000000000..6c6ce85e4c85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/max5432.txt

We have made the move to yaml for all new IIO related bindings.
Please convert this one over.  Also, all bindings should be in
separate patches and CC the devicetree binding maintainers and list.
This just makes them easier for them to pick out and review - shouldn't
be a problem here given it's really simple :)

> @@ -0,0 +1,21 @@
> +* Maxim Integrated MAX5432-MAX5435 Digital Potentiometers.
> +
> +The node for this driver must be a child node of an I2C controller, hence
> +all mandatory properties for your controller must be specified. See directory:
> +
> +    Documentation/devicetree/bindings/i2c
> +
> +for more details.
> +
> +Required properties:
> +- compatible: Must be one of the following, depending on the model:
> +    "maxim,max5432"
> +    "maxim,max5433"
> +    "maxim,max5434"
> +    "maxim,max5435"
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
> index 000000000000..95251e7c0c34
> --- /dev/null
> +++ b/drivers/iio/potentiometer/max5432.c
> @@ -0,0 +1,135 @@
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
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +/* All chip variants have 32 wiper positions. */
> +#define MAX5432_MAX_POS 31
> +
> +#define MAX5432_OHM_50K   (50  * 1000)
> +#define MAX5432_OHM_100K  (100 * 1000)
> +
> +/* Update the volatile (currently active) setting. */
> +#define MAX5432_CMD_VREG  0x11
> +
> +struct max5432_data {
> +	struct i2c_client *client;
> +	unsigned long ohm;
> +};
> +
> +static const struct iio_chan_spec max5432_channels[] = {
> +	{
> +		.type = IIO_RESISTANCE,
> +		.indexed = 1,
> +		.output = 1,
> +		.channel = 0,
> +		.address = MAX5432_CMD_VREG,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +	}
> +};
> +
> +static int max5432_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int *val, int *val2, long mask)
> +{
> +	struct max5432_data *data = iio_priv(indio_dev);
> +
> +	if (mask != IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
> +
> +	if (unlikely(data->ohm > INT_MAX))
> +		return -ERANGE;
> +
> +	*val = data->ohm;
> +	*val2 = MAX5432_MAX_POS;
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int max5432_write_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int val, int val2, long mask)
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

As below, break after "address," rather than the bracket.

> +}
> +
> +static const struct iio_info max5432_info = {
> +	.read_raw = max5432_read_raw,
> +	.write_raw = max5432_write_raw,
> +};
> +
> +static int max5432_probe(
> +		struct i2c_client *client, const struct i2c_device_id *id)

That formatting is rather non standard for kernel code.
I would break the line after "client," as it will still be well under 80
chars.

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
> +	data->ohm = (unsigned long)of_device_get_match_data(dev);
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
> +	{ .compatible = "maxim,max5432", .data = (void *)MAX5432_OHM_50K  },
> +	{ .compatible = "maxim,max5433", .data = (void *)MAX5432_OHM_100K },
> +	{ .compatible = "maxim,max5434", .data = (void *)MAX5432_OHM_50K  },
> +	{ .compatible = "maxim,max5435", .data = (void *)MAX5432_OHM_100K },
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

