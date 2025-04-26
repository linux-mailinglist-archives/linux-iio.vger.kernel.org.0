Return-Path: <linux-iio+bounces-18680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A67BA9DA56
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 13:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC0B9278F6
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 11:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A92253A5;
	Sat, 26 Apr 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gny7DTUd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28A52F88;
	Sat, 26 Apr 2025 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745665728; cv=none; b=qIMysLBWErXFE1TwPR3yJ0zIfHfVNj7U1ToIWUH0cHWp0o9hblPqN5jYP1+4taVaGU9VvvmDe/fwIw/z+tsyMHAu/MxcVbw2JAUjj3B+PAVnIoeYYcmadNYFiQE3aeTm0AH2GCqgDpSRrqkqDqsHsa/2RaRv+5YkNOWJjV9bRZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745665728; c=relaxed/simple;
	bh=iiQNaDvW4LjVWIXvZYp2/8K3XPw0po73DAih4wVfu58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVgvkW1auzIIFoZcepTr45KlDkBvvBWGjwTns+f8T+s50wEO0nGOXEo9OAQjOyihoM26u6FxWaCkKEbb/6FVc2k0tEYzKckccwLPHVb8rpMbK6xxLEbFGHcamydqHgiQdPC6zSgXiJ/xjWLj/tW3bgzTIN4vsAU74VOupj3mkjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gny7DTUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95B6C4CEE2;
	Sat, 26 Apr 2025 11:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745665727;
	bh=iiQNaDvW4LjVWIXvZYp2/8K3XPw0po73DAih4wVfu58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gny7DTUdfMPImGJ+nQR2UvAXQIcW61b7ltdaOcbc4FxQa5pwQWTA5frPcaSc2HDx3
	 5EXf056lEWqXftrWS5H70P1RsrCrgSPBcZyFxBL90AnZA2Auf8IW8HQ8Qzl1NB3nKK
	 X4ZXm2YAa2MnjCSwhYQ4plFAktsMJG0nZDc46pAGVA+Di7slXzYHP2UCSsGmMGr0Jg
	 sX6ec/UjWvU/3hLFrBE+tMIdMfAcZ+siF1vG9mtGbkFyoAB3dOGC0+Ts+KXgG9k531
	 krGorUcbpGI/I/06rypBG6vAyMeoevAztpNluDzmlpQuIHxLWcCOuqoIBI2F4+y1kQ
	 rtzznQdxvX6/A==
Date: Sat, 26 Apr 2025 12:08:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: surajsonawane0215@gmail.com
Cc: lars@metafoo.de, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: chemical: Add driver for Sharp GP2Y1010AU0F
 dust sensor
Message-ID: <20250426120841.249aabc9@jic23-huawei>
In-Reply-To: <20250425221214.50255-1-surajsonawane0215@gmail.com>
References: <20250425221214.50255-1-surajsonawane0215@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Apr 2025 03:42:14 +0530
surajsonawane0215@gmail.com wrote:

> From: Suraj Sonawane <surajsonawane0215@gmail.com>
> 
> Implement support for the Sharp GP2Y1010AU0F optical dust sensor which
> measures particulate matter concentration using infrared scattering. The
> sensor requires precise 280us LED pulses with ADC sampling at 200us after
> LED activation.
> 
> The driver provides:
> - Raw voltage readings through IIO interface
> - Hardware-agnostic operation via GPIO and IIO ADC interfaces
> - Power management through regulator framework
> - Device Tree binding support
> 
> Device operation:
> 1. Activate IR LED for 280us
> 2. Wait 40us after LED activation
> 3. Sample analog output at 200us (peak sensitivity)
> 4. Convert voltage to dust density via calibration parameters
> 
> Tested on BeagleBone Black with:
> - P8_12 (GPIO_44) for LED control
> - P9_39 (AIN0) for analog output
> 
> Datasheet:
> https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2y1010au_appl_e.pdf

As in patch 1, make this part of the tags block.

> 
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>

Various comments inline.  Interesting new type of sensor, so I think
we need a new channel type.  Trying to make that general is always the
challenge, but currently density looks appropriate to me.

Jonathan

> ---
>  MAINTAINERS                     |   7 ++
>  drivers/iio/chemical/Kconfig    |  12 +++
>  drivers/iio/chemical/Makefile   |   1 +
>  drivers/iio/chemical/gp2y1010.c | 183 ++++++++++++++++++++++++++++++++
>  4 files changed, 203 insertions(+)
>  create mode 100644 drivers/iio/chemical/gp2y1010.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f31aeb6b4..54e0f67e0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21974,6 +21974,13 @@ F:	drivers/iio/chemical/sps30.c
>  F:	drivers/iio/chemical/sps30_i2c.c
>  F:	drivers/iio/chemical/sps30_serial.c
>  
> +SHARP GP2Y1010AU0F DUST SENSOR DRIVER
> +M:	Suraj Sonawane <surajsonawane0215@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml
> +F:	drivers/iio/chemical/gp2y1010.c
> +
>  SERIAL DEVICE BUS
>  M:	Rob Herring <robh@kernel.org>
>  L:	linux-serial@vger.kernel.org
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index 330fe0af9..119c6e6d8 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -100,6 +100,18 @@ config ENS160_SPI
>  	tristate
>  	select REGMAP_SPI
>  
> +config GP2Y1010AU0F
> +	tristate "Sharp GP2Y1010AU0F optical dust sensor"
> +	depends on IIO
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER

Not seeing any buffered support in here so these seem unnecessary.
For a device like this I'd be very surprised if there was any reason to add it!

> +	help
> +	  Say Y here to build support for Sharp GP2Y1010AU0F optical dust sensor
> +	  that measures particulate matter concentration in air.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called gp2y1010au0f.
> +
>  config IAQCORE
>  	tristate "AMS iAQ-Core VOC sensors"
>  	depends on I2C
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index 4866db06b..296bbc0d0 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_ENS160) += ens160_core.o
>  obj-$(CONFIG_ENS160_I2C) += ens160_i2c.o
>  obj-$(CONFIG_ENS160_SPI) += ens160_spi.o
>  obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
> +obj-$(CONFIG_GP2Y1010AU0F) += gp2y1010.o

Alphabetical order by config name.

>  obj-$(CONFIG_PMS7003) += pms7003.o
>  obj-$(CONFIG_SCD30_CORE) += scd30_core.o
>  obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
> diff --git a/drivers/iio/chemical/gp2y1010.c b/drivers/iio/chemical/gp2y1010.c
> new file mode 100644
> index 000000000..19c09e0e3
> --- /dev/null
> +++ b/drivers/iio/chemical/gp2y1010.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Suraj Sonawane <surajsonawane0215@gmail.com>
> + *
> + * Sharp GP2Y1010AU0F Dust Sensor Driver
> + *
> + * Datasheet:
> + * https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2y1010au_appl_e.pdf
> + *
This blank line doesn't add anything so drop it.

> + */
> +
> +#include <linux/module.h>

Alphabetical order preferred in IIO.

> +#include <linux/init.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

This only applies if there is custom userspace ABI.

> +#include <linux/iio/consumer.h>
> +#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of.h>

Why?  I'm not (correctly) seeing an of specific alls in here.

> +#include <linux/platform_device.h>
> +#include <linux/err.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/delay.h>
> +
> +#define GP2Y1010_LED_PULSE_US    280  /* LED on-time (280us) */
> +#define GP2Y1010_SAMPLE_DELAY_US  40  /* Wait 40us after LED on */
> +#define GP2Y1010_MEASUREMENT_US  200  /* Measure 200us after LED on */
> +
> +struct gp2y1010_data {
> +	struct gpio_desc *led_gpio;
> +	struct iio_dev *indio_dev;

As below. We shouldn't need to get to the indio_dev from here.
Everything should go the other way (iio_priv(indio_dev) to get to this).

> +	struct iio_channel *adc_chan;
> +	struct regulator *vdd;
> +	int v_clean;  /* Calibration: voltage in clean air (mV) */
> +};
> +
> +static int gp2y1010_power_on(struct gp2y1010_data *data)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(data->vdd);
> +	if (ret) {
> +		dev_err(&data->indio_dev->dev, "Failed to enable vdd regulator\n");

Generally we'd use the pdev->dev for error messages not the IIO one because the
resulting name print is normally easier to use.

> +		return ret;
> +	}
See below.  I don't currently see the usefulness for this manual
enabling /disabling code.
> +
> +	udelay(100); /* Short delay for regulator stability */
> +	return 0;
> +}
> +
> +static void gp2y1010_power_off(struct gp2y1010_data *data)
> +{
> +	regulator_disable(data->vdd);
> +}
> +
> +static int gp2y1010_read_raw(struct iio_dev *indio_dev,
> +							 struct iio_chan_spec const *chan,
> +							 int *val, int *val2, long mask)
> +{
> +	struct gp2y1010_data *data = iio_priv(indio_dev);
> +	int ret, voltage_mv;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +    /* Turn on LED */
Kind of obvious so not sure the comment helps.
> +	gpiod_set_value(data->led_gpio, 1);
> +
> +    /* Wait 40us (datasheet: delay after LED on) */
> +	udelay(GP2Y1010_SAMPLE_DELAY_US);
> +
> +    /* Read ADC at 200us (peak sensitivity) */
> +	udelay(GP2Y1010_MEASUREMENT_US - GP2Y1010_SAMPLE_DELAY_US);

Why not a single delay of the total time?

> +	ret = iio_read_channel_processed(data->adc_chan, &voltage_mv);
	gpiod_set_value(data->led_gpio, 0);
	if (ret < 0 ) {
...

as then you can avoid turning the led off in both good and bad paths
via separate calls.

> +	if (ret < 0) {
> +		gpiod_set_value(data->led_gpio, 0);
> +		return ret;
> +	}
> +
> +    /* Turn off LED (total pulse width = 280us) */

This comment is useful because of the provided time information
so keep this one.

> +	gpiod_set_value(data->led_gpio, 0);
> +
> +    /* Store raw voltage (for debugging) */

Why is it for debugging?  This is ultimately what we pass to userspace.

> +	*val = voltage_mv;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static const struct iio_info gp2y1010_info = {
> +	.read_raw = gp2y1010_read_raw,
> +};
> +
> +static const struct iio_chan_spec gp2y1010_channels[] = {
> +	{
> +		.type = IIO_VOLTAGE,

Whilst you are measuring a voltage the real thing being measured is
about dust.  There is a graph in the datasheet of voltage vs dust density
in mg/m^3  So I think this needs a new channel type.  Probably
IIO_DENSITY with base units of g / m^3 

in this case without per sensor calibration I doubt we can get
to a processed value but we can still have a raw channel of
IIO_DENSITY type.

Remember to add Docs to Documentation/ABI/testing/sysfs-bus-iio for
the new density type.



> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.extend_name = "dust",
extend_name is a terrible old design decision that we more or less never
use in new drivers because it makes for a hard ABI for userspace code to parse.

Instead provide the get_label() callback if this is useful.

> +	},
> +};
> +
> +static int gp2y1010_probe(struct platform_device *pdev)
> +{
> +	struct gp2y1010_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
Quite a lot of references to &pdev->dev so I would have a local
variable
	struct device *dev = &pdev->dev;

that will shorten a lot of lines a little bit.

> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->indio_dev = indio_dev;

This is usually not a great sign.   Generally it means that you have passed
data to some callback where you should have passed the iio_dev and used
iio_priv() to get to data.  We should not be seeing the linkages in both
directions.


> +	data->v_clean = 900;  /* Default calibration (adjust per sensor) */

If you need to adjust this per sensor, how do we do it?

> +
> +	/* Get LED GPIO */

This code is self explanatory.  Comments that don't add a lot of value tend
to just pad out code and provide places for future disagreements between docs
and code as a driver evolves.  So generally we just don't have this sort
of comment.

> +	data->led_gpio = devm_gpiod_get(&pdev->dev, "led", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->led_gpio))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->led_gpio),
> +							"Failed to get LED GPIO\n");
> +
> +    /* Get regulator */
Likewise.  Self explanatory.
> +	data->vdd = devm_regulator_get(&pdev->dev, "vdd");

No need to keep hold of vdd for now (you may need it later if you do
runtime pm or similar) so can use
	ret = devm_regulator_get_enabled(dev, "vdd);
	if (ret)
		return ret;

	udelay(100); /* Short delay for regulator stability */

and drop the need to power it down explicitly.

> +	if (IS_ERR(data->vdd))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->vdd),
> +							"Failed to get regulator\n");
> +
> +    /* Power on sensor */
> +	ret = gp2y1010_power_on(data);
> +	if (ret)
> +		return ret;
As below
	ret = devm_add_action_or_reset(&pdev->dev, new_power_off_callback, data);
	if (ret)
		return ret;

however becomes irrelevant if you make changes suggested above.
> +
> +    /* Get ADC channel */
> +	data->adc_chan = devm_iio_channel_get(&pdev->dev, "dust");
> +	if (IS_ERR(data->adc_chan)) {
> +		gp2y1010_power_off(data);
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->adc_chan),
> +							"Failed to get ADC channel\n");
> +	}
> +
> +	/* Setup IIO device */
> +	indio_dev->name = "gp2y1010";
> +	indio_dev->info = &gp2y1010_info;
> +	indio_dev->channels = gp2y1010_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(gp2y1010_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret) {
> +		gp2y1010_power_off(data);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void gp2y1010_remove(struct platform_device *pdev)
> +{
> +	struct gp2y1010_data *data = platform_get_drvdata(pdev);
> +
> +	gp2y1010_power_off(data);
Use a devm_add_action_or_reset() with a custom callback to power this down.

As things currently stand, you are mixing devm cleanup and manual
cleanup which means that we remove the userspace interfaces after
turning the power off. That's generally a path to weird bug reports!

> +}
> +
> +static const struct of_device_id gp2y1010_of_match[] = {
> +	{ .compatible = "sharp,gp2y1010au0f", },
> +	{}
We have standardized in IIO on a space between brackets on terminators like
this 
	{ }
No particular reason for that choice beyond wanting to pick one or the other
style!

> +};
> +MODULE_DEVICE_TABLE(of, gp2y1010_of_match);
> +
> +static struct platform_driver gp2y1010_driver = {
> +	.driver = {
> +		.name = "gp2y1010",
> +		.of_match_table = gp2y1010_of_match,
> +	},
> +	.probe = gp2y1010_probe,
> +	.remove = gp2y1010_remove,
> +};
> +
> +module_platform_driver(gp2y1010_driver);
> +
> +MODULE_AUTHOR("Suraj Sonawane <surajsonawane0215@gmail.com>");
> +MODULE_DESCRIPTION("Sharp GP2Y1010AU0F Dust Sensor Driver");
> +MODULE_LICENSE("GPL");


