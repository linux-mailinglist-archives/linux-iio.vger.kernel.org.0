Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 135EE14FDAF
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 15:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgBBO6o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 09:58:44 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:40160 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgBBO6o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Feb 2020 09:58:44 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 6E77A9E7A20;
        Sun,  2 Feb 2020 14:58:41 +0000 (GMT)
Date:   Sun, 2 Feb 2020 14:58:39 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] input: joystick: Add ADC attached joystick
 driver.
Message-ID: <20200202145839.437cc176@archlinux>
In-Reply-To: <20200126161236.63631-5-contact@artur-rojek.eu>
References: <20200126161236.63631-1-contact@artur-rojek.eu>
        <20200126161236.63631-5-contact@artur-rojek.eu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Jan 2020 17:12:36 +0100
Artur Rojek <contact@artur-rojek.eu> wrote:

> Add a driver for joystick devices connected to ADC controllers
> supporting the Industrial I/O subsystem.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This also looks good to me.  Just that dt patch to tidy up.

Thanks,

Jonathan

> ---
> 
>  Changes:
> 
>  v2: - sanity check supported channel format on probe,
>      - rename adc_joystick_disable to a more sensible adc_joystick_cleanup, 
>      - enforce correct axis order by checking the `reg` property of
>        child nodes
> 
>  drivers/input/joystick/Kconfig        |  10 ++
>  drivers/input/joystick/Makefile       |   1 +
>  drivers/input/joystick/adc-joystick.c | 245 ++++++++++++++++++++++++++
>  3 files changed, 256 insertions(+)
>  create mode 100644 drivers/input/joystick/adc-joystick.c
> 
> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
> index 940b744639c7..efbc20ec5099 100644
> --- a/drivers/input/joystick/Kconfig
> +++ b/drivers/input/joystick/Kconfig
> @@ -42,6 +42,16 @@ config JOYSTICK_A3D
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called a3d.
>  
> +config JOYSTICK_ADC
> +	tristate "Simple joystick connected over ADC"
> +	depends on IIO
> +	select IIO_BUFFER_CB
> +	help
> +	  Say Y here if you have a simple joystick connected over ADC.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adc-joystick.
> +
>  config JOYSTICK_ADI
>  	tristate "Logitech ADI digital joysticks and gamepads"
>  	select GAMEPORT
> diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
> index 8656023f6ef5..58232b3057d3 100644
> --- a/drivers/input/joystick/Makefile
> +++ b/drivers/input/joystick/Makefile
> @@ -6,6 +6,7 @@
>  # Each configuration option enables a list of files.
>  
>  obj-$(CONFIG_JOYSTICK_A3D)		+= a3d.o
> +obj-$(CONFIG_JOYSTICK_ADC)		+= adc-joystick.o
>  obj-$(CONFIG_JOYSTICK_ADI)		+= adi.o
>  obj-$(CONFIG_JOYSTICK_AMIGA)		+= amijoy.o
>  obj-$(CONFIG_JOYSTICK_AS5011)		+= as5011.o
> diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
> new file mode 100644
> index 000000000000..9cb9896da26e
> --- /dev/null
> +++ b/drivers/input/joystick/adc-joystick.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Input driver for joysticks connected over ADC.
> + * Copyright (c) 2019-2020 Artur Rojek <contact@artur-rojek.eu>
> + */
> +#include <linux/ctype.h>
> +#include <linux/input.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +struct adc_joystick_axis {
> +	u32 code;
> +	s32 range[2];
> +	s32 fuzz;
> +	s32 flat;
> +};
> +
> +struct adc_joystick {
> +	struct input_dev *input;
> +	struct iio_cb_buffer *buffer;
> +	struct adc_joystick_axis *axes;
> +	struct iio_channel *chans;
> +	int num_chans;
> +};
> +
> +static int adc_joystick_handle(const void *data, void *private)
> +{
> +	struct adc_joystick *joy = private;
> +	enum iio_endian endianness;
> +	int bytes, msb, val, i;
> +	bool sign;
> +
> +	bytes = joy->chans[0].channel->scan_type.storagebits >> 3;
> +
> +	for (i = 0; i < joy->num_chans; ++i) {
> +		endianness = joy->chans[i].channel->scan_type.endianness;
> +		msb = joy->chans[i].channel->scan_type.realbits - 1;
> +		sign = (tolower(joy->chans[i].channel->scan_type.sign) == 's');
> +
> +		switch (bytes) {
> +		case 1:
> +			val = ((const u8 *)data)[i];
> +			break;
> +		case 2:
> +			val = ((const u16 *)data)[i];
> +			if (endianness == IIO_BE)
> +				val = be16_to_cpu(val);
> +			else if (endianness == IIO_LE)
> +				val = le16_to_cpu(val);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		val >>= joy->chans[i].channel->scan_type.shift;
> +		if (sign)
> +			val = sign_extend32(val, msb);
> +		else
> +			val &= GENMASK(msb, 0);
> +		input_report_abs(joy->input, joy->axes[i].code, val);
> +	}
> +
> +	input_sync(joy->input);
> +
> +	return 0;
> +}
> +
> +static int adc_joystick_open(struct input_dev *dev)
> +{
> +	struct adc_joystick *joy = input_get_drvdata(dev);
> +	int ret;
> +
> +	ret = iio_channel_start_all_cb(joy->buffer);
> +	if (ret)
> +		dev_err(dev->dev.parent, "Unable to start callback buffer");
> +
> +	return ret;
> +}
> +
> +static void adc_joystick_close(struct input_dev *dev)
> +{
> +	struct adc_joystick *joy = input_get_drvdata(dev);
> +
> +	iio_channel_stop_all_cb(joy->buffer);
> +}
> +
> +static void adc_joystick_cleanup(void *data)
> +{
> +	iio_channel_release_all_cb(data);
> +}
> +
> +static int adc_joystick_set_axes(struct device *dev, struct adc_joystick *joy)
> +{
> +	struct adc_joystick_axis *axes;
> +	struct fwnode_handle *child;
> +	int num_axes, ret, i;
> +
> +	num_axes = device_get_child_node_count(dev);
> +	if (!num_axes) {
> +		dev_err(dev, "Unable to find child nodes");
> +		return -EINVAL;
> +	}
> +
> +	if (num_axes != joy->num_chans) {
> +		dev_err(dev, "Got %d child nodes for %d channels",
> +			num_axes, joy->num_chans);
> +		return -EINVAL;
> +	}
> +
> +	axes = devm_kmalloc_array(dev, num_axes, sizeof(*axes), GFP_KERNEL);
> +	if (!axes)
> +		return -ENOMEM;
> +
> +	device_for_each_child_node(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &i);
> +		if (ret || i >= num_axes) {
> +			dev_err(dev, "reg invalid or missing");
> +			goto err;
> +		}
> +
> +		if (fwnode_property_read_u32(child, "linux,code",
> +					     &axes[i].code)) {
> +			dev_err(dev, "linux,code invalid or missing");
> +			goto err;
> +		}
> +
> +		if (fwnode_property_read_u32_array(child, "abs-range",
> +						   axes[i].range, 2)) {
> +			dev_err(dev, "abs-range invalid or missing");
> +			goto err;
> +		}
> +
> +		fwnode_property_read_u32(child, "abs-fuzz",
> +					 &axes[i].fuzz);
> +		fwnode_property_read_u32(child, "abs-flat",
> +					 &axes[i].flat);
> +
> +		input_set_abs_params(joy->input, axes[i].code,
> +				     axes[i].range[0], axes[i].range[1],
> +				     axes[i].fuzz,
> +				     axes[i].flat);
> +		input_set_capability(joy->input, EV_ABS, axes[i].code);
> +	}
> +
> +	joy->axes = axes;
> +
> +	return 0;
> +
> +err:
> +	fwnode_handle_put(child);
> +	return -EINVAL;
> +}
> +
> +static int adc_joystick_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct adc_joystick *joy;
> +	struct input_dev *input;
> +	int bits, ret, i;
> +
> +	joy = devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
> +	if (!joy)
> +		return -ENOMEM;
> +
> +	joy->chans = devm_iio_channel_get_all(dev);
> +	if (IS_ERR(joy->chans)) {
> +		ret = PTR_ERR(joy->chans);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Unable to get IIO channels");
> +		return ret;
> +	}
> +
> +	/* Count how many channels we got. NULL terminated. */
> +	while (joy->chans[joy->num_chans].indio_dev)
> +		joy->num_chans++;
> +
> +	bits = joy->chans[0].channel->scan_type.storagebits;
> +	if (!bits || (bits >> 3) > 2) {
> +		dev_err(dev, "Unsupported channel storage size");
> +		return -EINVAL;
> +	}
> +	for (i = 1; i < joy->num_chans; ++i)
> +		if (joy->chans[i].channel->scan_type.storagebits != bits) {
> +			dev_err(dev, "Channels must have equal storage size");
> +			return -EINVAL;
> +		}
> +
> +	input = devm_input_allocate_device(dev);
> +	if (!input) {
> +		dev_err(dev, "Unable to allocate input device");
> +		return -ENOMEM;
> +	}
> +
> +	joy->input = input;
> +	input->name = pdev->name;
> +	input->id.bustype = BUS_HOST;
> +	input->open = adc_joystick_open;
> +	input->close = adc_joystick_close;
> +
> +	ret = adc_joystick_set_axes(dev, joy);
> +	if (ret)
> +		return ret;
> +
> +	input_set_drvdata(input, joy);
> +	ret = input_register_device(input);
> +	if (ret) {
> +		dev_err(dev, "Unable to register input device: %d", ret);
> +		return ret;
> +	}
> +
> +	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
> +	if (IS_ERR(joy->buffer)) {
> +		dev_err(dev, "Unable to allocate callback buffer");
> +		return PTR_ERR(joy->buffer);
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, adc_joystick_cleanup, joy->buffer);
> +	if (ret)
> +		dev_err(dev, "Unable to add action");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id adc_joystick_of_match[] = {
> +	{ .compatible = "adc-joystick", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, adc_joystick_of_match);
> +
> +static struct platform_driver adc_joystick_driver = {
> +	.driver = {
> +		.name = "adc-joystick",
> +		.of_match_table = of_match_ptr(adc_joystick_of_match),
> +	},
> +	.probe = adc_joystick_probe,
> +};
> +module_platform_driver(adc_joystick_driver);
> +
> +MODULE_DESCRIPTION("Input driver for joysticks connected over ADC");
> +MODULE_AUTHOR("Artur Rojek <contact@artur-rojek.eu>");
> +MODULE_LICENSE("GPL");

