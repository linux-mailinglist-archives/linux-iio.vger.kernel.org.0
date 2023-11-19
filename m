Return-Path: <linux-iio+bounces-170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E927F0741
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 16:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7206B1C2080C
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 15:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B320112B72;
	Sun, 19 Nov 2023 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgOGRqvA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89F11C92;
	Sun, 19 Nov 2023 15:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F78C433C8;
	Sun, 19 Nov 2023 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700409269;
	bh=w0TBwbMybQUEpvIlvhdb0ILVSRAMgdc9gIP02JnbPZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SgOGRqvAJmW1nmRDb//FhkZRV3DRA8Hf2B926dT7bNR6Yem/k2JgiWKYJ7gYIWyyw
	 6ZmAoVVFrU6xUaRfX2IK/NcpOijMrcoLmZVg9cTvL1oy0Qq5N7Bg6tcCvK6PoKRxAn
	 xDyDzoo7Pv95iijFsDDAUVVxg05OkUPJsj55RXVV0H4Psy0rVpD8mhQlmxlSqwapQb
	 i1VHZEH62gLYc7ixi79gp/oPdSH77B8ZJlNsJUM4wfgKICWjsR+EcFCPyxrlzqOYNf
	 D2nSiqHnjRX7J8+CGuWfcr7KtG3N2QW8x9T9Uj+Ln8jV71NQV1wpBfd/SrtrnCZWIH
	 e1NcIyQrnnOvg==
Date: Sun, 19 Nov 2023 15:54:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Alexander Stein
 <alexander.stein@ew.tq-group.com>, Andre Werner
 <andre.werner@systec-electronic.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@denx.de>,
 Guenter Roeck <linux@roeck-us.net>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Naresh Solanki
 <naresh.solanki@9elements.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Rob Herring <robh+dt@kernel.org>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>, Vincent Tremblay
 <vincent@vtremblay.dev>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <20231119155419.3b1da82d@jic23-huawei>
In-Reply-To: <20231118000614.186558-2-marex@denx.de>
References: <20231118000614.186558-1-marex@denx.de>
	<20231118000614.186558-2-marex@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Nov 2023 01:06:10 +0100
Marek Vasut <marex@denx.de> wrote:

> The ISL76682 is very basic ALS which only supports ALS or IR mode
> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> other fancy functionality.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Hi Marek

A few comments inline,

Jonathan

>  drivers/iio/light/Kconfig    |   8 +
>  drivers/iio/light/Makefile   |   1 +
>  drivers/iio/light/isl76682.c | 336 +++++++++++++++++++++++++++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 drivers/iio/light/isl76682.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 45edba797e4c7..124c45f509754 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -252,6 +252,14 @@ config ISL29125
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called isl29125.
>  
> +config ISL76682
> +	tristate "Intersil ISL76682 Light Sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Provides driver for the Intersil's ISL76682 device. This driver
> +	  supports the sysfs interface to get the ALS and IR intensity.
> +
One of the bots tends to moan about short descriptions + it can be useful
to let someone know the module name. Hence I'd add the usual boilerplate description
for that here.

> diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
> new file mode 100644
> index 0000000000000..64ec8b8fe71ee
> --- /dev/null
> +++ b/drivers/iio/light/isl76682.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * IIO driver for the light sensor ISL76682.
> + * ISL76682 is Ambient Light Sensor
> + *
> + * Copyright (c) 2023 Marek Vasut <marex@denx.de>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

After changes below, this sysfs.h include should not be needed.

> +
> +#define ISL76682_REG_COMMAND			0x00
> +
> +#define ISL76682_COMMAND_EN			BIT(7)
> +#define ISL76682_COMMAND_MODE_CONTINUOUS	BIT(6)
> +#define ISL76682_COMMAND_LIGHT_IR		BIT(5)
> +
> +#define ISL76682_COMMAND_RANGE_LUX_1K		0
> +#define ISL76682_COMMAND_RANGE_LUX_4K		(1 << 0)
> +#define ISL76682_COMMAND_RANGE_LUX_16K		(2 << 0)
> +#define ISL76682_COMMAND_RANGE_LUX_64K		(3 << 0)
As you are writing these into a field with a mask, 0, 1, 2, 3 should
be fine as the shift is done by FIELD_PREP()

> +#define ISL76682_COMMAND_RANGE_LUX_MASK		GENMASK(1, 0)

> +struct isl76682_chip {
> +	struct mutex			lock;
A lock needs a comment on what scope it covers.  Be as specific as you can
as you need to distinguish it from the locks in regmap or the underlying bus code.
> +	struct regmap			*regmap;
> +	u8				range;
> +	u8				command;
> +};

> +static int isl76682_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct isl76682_chip *chip = iio_priv(indio_dev);
> +	u8 range;
> +
> +	if (chan->type != IIO_LIGHT)
> +		return -EINVAL;
> +
> +	if (mask != IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
> +
> +	if (val != 0)
> +		return -EINVAL;
> +
> +	if (chan->type == IIO_LIGHT) {
> +		if (val2 == 15000)		/* 0.015 ... 1000 lux */

As below, I'd prefer these to be lookups in the same table used for read_avail()
callback.

> +			range = ISL76682_COMMAND_RANGE_LUX_1K;
> +		else if (val2 == 60000)		/* 0.060 ... 4000 lux */
> +			range = ISL76682_COMMAND_RANGE_LUX_4K;
> +		else if (val2 == 240000)	/* 0.240 ... 16000 lux */
> +			range = ISL76682_COMMAND_RANGE_LUX_16K;
> +		else if (val2 == 960000)	/* 0.960 ... 64000 lux */
> +			range = ISL76682_COMMAND_RANGE_LUX_64K;
> +		else
> +			return -EINVAL;
> +	} else if (chan->type == IIO_INTENSITY) {
> +		if (val2 == 10500)		/* 0.0105 .. 1000 lux */
> +			range = ISL76682_COMMAND_RANGE_LUX_1K;
> +		else if (val2 == 42000)		/* 0.042 ... 4000 lux */
> +			range = ISL76682_COMMAND_RANGE_LUX_4K;
> +		else if (val2 == 168000)	/* 0.168 ... 16000 lux */
> +			range = ISL76682_COMMAND_RANGE_LUX_16K;
> +		else if (val2 == 673000)	/* 0.673 ... 64000 lux */
> +			range = ISL76682_COMMAND_RANGE_LUX_64K;
> +		else
> +			return -EINVAL;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&chip->lock);

scoped_guard(mutex, &chip->lock); or guard(mutex)(&chip->lock);
nice here as well.

> +	chip->range = range;
> +	mutex_unlock(&chip->lock);
> +
> +	return 0;
> +}
> +
> +static int isl76682_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct isl76682_chip *chip = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	mutex_lock(&chip->lock);
guard(mutex)(&chip->lock);

Will allow you to make direct returns instead of breaking to where the
unlock is, generally simplifying the code flow.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = isl76682_get(chip, false, val);
> +			break;
> +		case IIO_INTENSITY:
> +			ret = isl76682_get(chip, true, val);
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (ret < 0)
> +			break;
> +
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			if (chip->range == ISL76682_COMMAND_RANGE_LUX_1K)
> +				*val2 = 15000;
> +			else if (chip->range == ISL76682_COMMAND_RANGE_LUX_4K)
> +				*val2 = 60000;
> +			else if (chip->range == ISL76682_COMMAND_RANGE_LUX_16K)
> +				*val2 = 240000;
> +			else if (chip->range == ISL76682_COMMAND_RANGE_LUX_64K)
> +				*val2 = 960000;
> +			else
> +				break;
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +			break;
> +		case IIO_INTENSITY:
> +			if (chip->range == ISL76682_COMMAND_RANGE_LUX_1K)
> +				*val2 = 10500;
> +			else if (chip->range == ISL76682_COMMAND_RANGE_LUX_4K)
> +				*val2 = 42000;
> +			else if (chip->range == ISL76682_COMMAND_RANGE_LUX_16K)
> +				*val2 = 168000;
> +			else if (chip->range == ISL76682_COMMAND_RANGE_LUX_64K)
> +				*val2 = 673000;
> +			else
> +				break;
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	mutex_unlock(&chip->lock);
> +
> +	return ret;
> +}
> +
> +static IIO_CONST_ATTR(in_illuminance_scale_available, "0.015 0.06 0.24 0.96");
> +static IIO_CONST_ATTR(in_intensity_scale_available, "0.0105 0.042 0.168 0.673");
> +static IIO_CONST_ATTR(integration_time_available, "0.090");	/* 90 ms */
> +
> +static struct attribute *isl76682_attributes[] = {
> +	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
> +	&iio_const_attr_in_intensity_scale_available.dev_attr.attr,
> +	&iio_const_attr_integration_time_available.dev_attr.attr,
Please use the read_avail() callback and matching bitmaps for these.
Doing them with custom attributes is something we are trying to move away
from as it prevents any sensible in kernel access to the values and tends
to end up with duplication of data (and potential inconsistencies)
given you also have to match against the values.

There are lots of older drivers that predate that callback being added
that we haven't converted over yet.

> +	NULL,
> +};
> +

...

> +static void isl76682_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct isl76682_chip *chip = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	isl76682_clear_configure_reg(chip);

Use a devm_add_action_or_reset() call with a custom callback to unwind this
automatically... As they you can use devm_iio_device_register() and
get rid of the need for any remove function at all.

I am a little curious as to why it needs to be called here as it doesn't obviously
match a call in probe that is being unwound.  As such a comment on 'why' would
also be good.


> +}
> +



