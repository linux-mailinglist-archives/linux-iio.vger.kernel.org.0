Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DA91585B3
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 23:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJWpl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 17:45:41 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:35966 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBJWpk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Feb 2020 17:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581374737; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ffqJXmf3Ce5NtIAL0hrW4y/tyjBbMnMNG97y0sXY1h0=;
        b=R00tW4LSRIGmC/mUv2LsknqmgZhEwWjFvI4tEUHrC2YipACSjCQ8ZkofuzTXNESW3eass7
        i/FtjFTSeXOf7Efqey/XExd22uZcArmam4md/BaY8sGVXCkS03gcAEVgPunKywfHm3DNIZ
        2xRXIk67AqZw5PYyyKoN3DcOFKx2GLU=
Date:   Mon, 10 Feb 2020 19:45:21 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 5/5] input: joystick: Add ADC attached joystick driver.
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1581374721.3.3@crapouillou.net>
In-Reply-To: <20200202145839.437cc176@archlinux>
References: <20200126161236.63631-1-contact@artur-rojek.eu>
        <20200126161236.63631-5-contact@artur-rojek.eu>
        <20200202145839.437cc176@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan, Rob,

The DT check does succeed here, as long as patch [2/5] is applied. I=20
believe Rob's automated test does not apply all patches and that's why=20
it fails here, as the DTS example includes a file that is added in=20
patch 2/5.

-Paul



Le dim., f=E9vr. 2, 2020 at 14:58, Jonathan Cameron=20
<jic23@jic23.retrosnub.co.uk> a =E9crit :
> On Sun, 26 Jan 2020 17:12:36 +0100
> Artur Rojek <contact@artur-rojek.eu> wrote:
>=20
>>  Add a driver for joystick devices connected to ADC controllers
>>  supporting the Industrial I/O subsystem.
>>=20
>>  Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>>  Tested-by: Paul Cercueil <paul@crapouillou.net>
>>  Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> This also looks good to me.  Just that dt patch to tidy up.
>=20
> Thanks,
>=20
> Jonathan
>=20
>>  ---
>>=20
>>   Changes:
>>=20
>>   v2: - sanity check supported channel format on probe,
>>       - rename adc_joystick_disable to a more sensible=20
>> adc_joystick_cleanup,
>>       - enforce correct axis order by checking the `reg` property of
>>         child nodes
>>=20
>>   drivers/input/joystick/Kconfig        |  10 ++
>>   drivers/input/joystick/Makefile       |   1 +
>>   drivers/input/joystick/adc-joystick.c | 245=20
>> ++++++++++++++++++++++++++
>>   3 files changed, 256 insertions(+)
>>   create mode 100644 drivers/input/joystick/adc-joystick.c
>>=20
>>  diff --git a/drivers/input/joystick/Kconfig=20
>> b/drivers/input/joystick/Kconfig
>>  index 940b744639c7..efbc20ec5099 100644
>>  --- a/drivers/input/joystick/Kconfig
>>  +++ b/drivers/input/joystick/Kconfig
>>  @@ -42,6 +42,16 @@ config JOYSTICK_A3D
>>   	  To compile this driver as a module, choose M here: the
>>   	  module will be called a3d.
>>=20
>>  +config JOYSTICK_ADC
>>  +	tristate "Simple joystick connected over ADC"
>>  +	depends on IIO
>>  +	select IIO_BUFFER_CB
>>  +	help
>>  +	  Say Y here if you have a simple joystick connected over ADC.
>>  +
>>  +	  To compile this driver as a module, choose M here: the
>>  +	  module will be called adc-joystick.
>>  +
>>   config JOYSTICK_ADI
>>   	tristate "Logitech ADI digital joysticks and gamepads"
>>   	select GAMEPORT
>>  diff --git a/drivers/input/joystick/Makefile=20
>> b/drivers/input/joystick/Makefile
>>  index 8656023f6ef5..58232b3057d3 100644
>>  --- a/drivers/input/joystick/Makefile
>>  +++ b/drivers/input/joystick/Makefile
>>  @@ -6,6 +6,7 @@
>>   # Each configuration option enables a list of files.
>>=20
>>   obj-$(CONFIG_JOYSTICK_A3D)		+=3D a3d.o
>>  +obj-$(CONFIG_JOYSTICK_ADC)		+=3D adc-joystick.o
>>   obj-$(CONFIG_JOYSTICK_ADI)		+=3D adi.o
>>   obj-$(CONFIG_JOYSTICK_AMIGA)		+=3D amijoy.o
>>   obj-$(CONFIG_JOYSTICK_AS5011)		+=3D as5011.o
>>  diff --git a/drivers/input/joystick/adc-joystick.c=20
>> b/drivers/input/joystick/adc-joystick.c
>>  new file mode 100644
>>  index 000000000000..9cb9896da26e
>>  --- /dev/null
>>  +++ b/drivers/input/joystick/adc-joystick.c
>>  @@ -0,0 +1,245 @@
>>  +// SPDX-License-Identifier: GPL-2.0
>>  +/*
>>  + * Input driver for joysticks connected over ADC.
>>  + * Copyright (c) 2019-2020 Artur Rojek <contact@artur-rojek.eu>
>>  + */
>>  +#include <linux/ctype.h>
>>  +#include <linux/input.h>
>>  +#include <linux/iio/iio.h>
>>  +#include <linux/iio/consumer.h>
>>  +#include <linux/module.h>
>>  +#include <linux/of.h>
>>  +#include <linux/platform_device.h>
>>  +#include <linux/property.h>
>>  +
>>  +struct adc_joystick_axis {
>>  +	u32 code;
>>  +	s32 range[2];
>>  +	s32 fuzz;
>>  +	s32 flat;
>>  +};
>>  +
>>  +struct adc_joystick {
>>  +	struct input_dev *input;
>>  +	struct iio_cb_buffer *buffer;
>>  +	struct adc_joystick_axis *axes;
>>  +	struct iio_channel *chans;
>>  +	int num_chans;
>>  +};
>>  +
>>  +static int adc_joystick_handle(const void *data, void *private)
>>  +{
>>  +	struct adc_joystick *joy =3D private;
>>  +	enum iio_endian endianness;
>>  +	int bytes, msb, val, i;
>>  +	bool sign;
>>  +
>>  +	bytes =3D joy->chans[0].channel->scan_type.storagebits >> 3;
>>  +
>>  +	for (i =3D 0; i < joy->num_chans; ++i) {
>>  +		endianness =3D joy->chans[i].channel->scan_type.endianness;
>>  +		msb =3D joy->chans[i].channel->scan_type.realbits - 1;
>>  +		sign =3D (tolower(joy->chans[i].channel->scan_type.sign) =3D=3D 's')=
;
>>  +
>>  +		switch (bytes) {
>>  +		case 1:
>>  +			val =3D ((const u8 *)data)[i];
>>  +			break;
>>  +		case 2:
>>  +			val =3D ((const u16 *)data)[i];
>>  +			if (endianness =3D=3D IIO_BE)
>>  +				val =3D be16_to_cpu(val);
>>  +			else if (endianness =3D=3D IIO_LE)
>>  +				val =3D le16_to_cpu(val);
>>  +			break;
>>  +		default:
>>  +			return -EINVAL;
>>  +		}
>>  +
>>  +		val >>=3D joy->chans[i].channel->scan_type.shift;
>>  +		if (sign)
>>  +			val =3D sign_extend32(val, msb);
>>  +		else
>>  +			val &=3D GENMASK(msb, 0);
>>  +		input_report_abs(joy->input, joy->axes[i].code, val);
>>  +	}
>>  +
>>  +	input_sync(joy->input);
>>  +
>>  +	return 0;
>>  +}
>>  +
>>  +static int adc_joystick_open(struct input_dev *dev)
>>  +{
>>  +	struct adc_joystick *joy =3D input_get_drvdata(dev);
>>  +	int ret;
>>  +
>>  +	ret =3D iio_channel_start_all_cb(joy->buffer);
>>  +	if (ret)
>>  +		dev_err(dev->dev.parent, "Unable to start callback buffer");
>>  +
>>  +	return ret;
>>  +}
>>  +
>>  +static void adc_joystick_close(struct input_dev *dev)
>>  +{
>>  +	struct adc_joystick *joy =3D input_get_drvdata(dev);
>>  +
>>  +	iio_channel_stop_all_cb(joy->buffer);
>>  +}
>>  +
>>  +static void adc_joystick_cleanup(void *data)
>>  +{
>>  +	iio_channel_release_all_cb(data);
>>  +}
>>  +
>>  +static int adc_joystick_set_axes(struct device *dev, struct=20
>> adc_joystick *joy)
>>  +{
>>  +	struct adc_joystick_axis *axes;
>>  +	struct fwnode_handle *child;
>>  +	int num_axes, ret, i;
>>  +
>>  +	num_axes =3D device_get_child_node_count(dev);
>>  +	if (!num_axes) {
>>  +		dev_err(dev, "Unable to find child nodes");
>>  +		return -EINVAL;
>>  +	}
>>  +
>>  +	if (num_axes !=3D joy->num_chans) {
>>  +		dev_err(dev, "Got %d child nodes for %d channels",
>>  +			num_axes, joy->num_chans);
>>  +		return -EINVAL;
>>  +	}
>>  +
>>  +	axes =3D devm_kmalloc_array(dev, num_axes, sizeof(*axes),=20
>> GFP_KERNEL);
>>  +	if (!axes)
>>  +		return -ENOMEM;
>>  +
>>  +	device_for_each_child_node(dev, child) {
>>  +		ret =3D fwnode_property_read_u32(child, "reg", &i);
>>  +		if (ret || i >=3D num_axes) {
>>  +			dev_err(dev, "reg invalid or missing");
>>  +			goto err;
>>  +		}
>>  +
>>  +		if (fwnode_property_read_u32(child, "linux,code",
>>  +					     &axes[i].code)) {
>>  +			dev_err(dev, "linux,code invalid or missing");
>>  +			goto err;
>>  +		}
>>  +
>>  +		if (fwnode_property_read_u32_array(child, "abs-range",
>>  +						   axes[i].range, 2)) {
>>  +			dev_err(dev, "abs-range invalid or missing");
>>  +			goto err;
>>  +		}
>>  +
>>  +		fwnode_property_read_u32(child, "abs-fuzz",
>>  +					 &axes[i].fuzz);
>>  +		fwnode_property_read_u32(child, "abs-flat",
>>  +					 &axes[i].flat);
>>  +
>>  +		input_set_abs_params(joy->input, axes[i].code,
>>  +				     axes[i].range[0], axes[i].range[1],
>>  +				     axes[i].fuzz,
>>  +				     axes[i].flat);
>>  +		input_set_capability(joy->input, EV_ABS, axes[i].code);
>>  +	}
>>  +
>>  +	joy->axes =3D axes;
>>  +
>>  +	return 0;
>>  +
>>  +err:
>>  +	fwnode_handle_put(child);
>>  +	return -EINVAL;
>>  +}
>>  +
>>  +static int adc_joystick_probe(struct platform_device *pdev)
>>  +{
>>  +	struct device *dev =3D &pdev->dev;
>>  +	struct adc_joystick *joy;
>>  +	struct input_dev *input;
>>  +	int bits, ret, i;
>>  +
>>  +	joy =3D devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
>>  +	if (!joy)
>>  +		return -ENOMEM;
>>  +
>>  +	joy->chans =3D devm_iio_channel_get_all(dev);
>>  +	if (IS_ERR(joy->chans)) {
>>  +		ret =3D PTR_ERR(joy->chans);
>>  +		if (ret !=3D -EPROBE_DEFER)
>>  +			dev_err(dev, "Unable to get IIO channels");
>>  +		return ret;
>>  +	}
>>  +
>>  +	/* Count how many channels we got. NULL terminated. */
>>  +	while (joy->chans[joy->num_chans].indio_dev)
>>  +		joy->num_chans++;
>>  +
>>  +	bits =3D joy->chans[0].channel->scan_type.storagebits;
>>  +	if (!bits || (bits >> 3) > 2) {
>>  +		dev_err(dev, "Unsupported channel storage size");
>>  +		return -EINVAL;
>>  +	}
>>  +	for (i =3D 1; i < joy->num_chans; ++i)
>>  +		if (joy->chans[i].channel->scan_type.storagebits !=3D bits) {
>>  +			dev_err(dev, "Channels must have equal storage size");
>>  +			return -EINVAL;
>>  +		}
>>  +
>>  +	input =3D devm_input_allocate_device(dev);
>>  +	if (!input) {
>>  +		dev_err(dev, "Unable to allocate input device");
>>  +		return -ENOMEM;
>>  +	}
>>  +
>>  +	joy->input =3D input;
>>  +	input->name =3D pdev->name;
>>  +	input->id.bustype =3D BUS_HOST;
>>  +	input->open =3D adc_joystick_open;
>>  +	input->close =3D adc_joystick_close;
>>  +
>>  +	ret =3D adc_joystick_set_axes(dev, joy);
>>  +	if (ret)
>>  +		return ret;
>>  +
>>  +	input_set_drvdata(input, joy);
>>  +	ret =3D input_register_device(input);
>>  +	if (ret) {
>>  +		dev_err(dev, "Unable to register input device: %d", ret);
>>  +		return ret;
>>  +	}
>>  +
>>  +	joy->buffer =3D iio_channel_get_all_cb(dev, adc_joystick_handle,=20
>> joy);
>>  +	if (IS_ERR(joy->buffer)) {
>>  +		dev_err(dev, "Unable to allocate callback buffer");
>>  +		return PTR_ERR(joy->buffer);
>>  +	}
>>  +
>>  +	ret =3D devm_add_action_or_reset(dev, adc_joystick_cleanup,=20
>> joy->buffer);
>>  +	if (ret)
>>  +		dev_err(dev, "Unable to add action");
>>  +
>>  +	return ret;
>>  +}
>>  +
>>  +static const struct of_device_id adc_joystick_of_match[] =3D {
>>  +	{ .compatible =3D "adc-joystick", },
>>  +	{ },
>>  +};
>>  +MODULE_DEVICE_TABLE(of, adc_joystick_of_match);
>>  +
>>  +static struct platform_driver adc_joystick_driver =3D {
>>  +	.driver =3D {
>>  +		.name =3D "adc-joystick",
>>  +		.of_match_table =3D of_match_ptr(adc_joystick_of_match),
>>  +	},
>>  +	.probe =3D adc_joystick_probe,
>>  +};
>>  +module_platform_driver(adc_joystick_driver);
>>  +
>>  +MODULE_DESCRIPTION("Input driver for joysticks connected over=20
>> ADC");
>>  +MODULE_AUTHOR("Artur Rojek <contact@artur-rojek.eu>");
>>  +MODULE_LICENSE("GPL");
>=20

=

