Return-Path: <linux-iio+bounces-7393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5652B9297AF
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 13:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D021F20FFD
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 11:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706721BF37;
	Sun,  7 Jul 2024 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpXkwqLx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276DD6FC1;
	Sun,  7 Jul 2024 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720352768; cv=none; b=BMsP366e9gpOkD0ln3uCjEtJQxYjmlDYQ5M5jWe4l2T2mI0Iw3xl3ZE4vKsoWQ/goIwmQfn6xUEPVkEFhIbohxsraQL8uwdwjvEC8AL7foWvhc6nrzzSaC2D9Gwu0UgEIJSwsS8m8yyyRwCM1gVUbdIN4osVuIBgRWXTZYurL7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720352768; c=relaxed/simple;
	bh=fddJUVbh+3VJtVjfwYziuOrBdU+wNLdu0RxajVU3JVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CscKHcBVAKQKhRxbE+cdPhyDxTHyPF+oozzlv1PEFL9Zr5/MlQLRhBO/ykDVxNUAUgd31MMbJqRnTTKALf2ARCE+mzll+oBTvGy1g7UQVTTUIlvt36FGR0jA9n9sPbDkcacZz8Ls6Nirn1qUnU7dYIVOAQm4tng9W7RtHI5fBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpXkwqLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA646C3277B;
	Sun,  7 Jul 2024 11:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720352767;
	bh=fddJUVbh+3VJtVjfwYziuOrBdU+wNLdu0RxajVU3JVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tpXkwqLxyRtQcpNpullQFw8ZhLN4paBzDS3cYBP9VBT3ZCiSlemcK7xIu9em8bsD6
	 6xHzvoQnmC34L6dT6qJJFOYNgerfxg2Jmw22EqwPA2vj9JMeDedCWJYYuriyqrvVm0
	 Ku7DnPD/rfsCqh/D3vag90B8acnvHH9VxfzO/7FsdDcxqLEbqo5XK/XEB18IYGkS6o
	 FtJ1ljmuWynzZKQoMUDzpGnP2iNrloYroWDsK8CflZ8FCYEGN65/DBzrZdpR3AhddF
	 67Y+8QKJGhabldYs1VBkY6JJSLHdagxzcu9o2OpbzaqKZaGZptFhGAsy5l6WCvOpqZ
	 agOkdtYjB4LRA==
Date: Sun, 7 Jul 2024 12:46:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mudit Sharma <muditsharma.info@gmail.com>
Cc: lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, linux-kernel@vger.kernel.org, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Ivan Orlov
 <ivan.orlov0322@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v7 2/2] iio: light: ROHM BH1745 colour sensor
Message-ID: <20240707124600.5b52452e@jic23-huawei>
In-Reply-To: <20240705220018.414771-2-muditsharma.info@gmail.com>
References: <20240705220018.414771-1-muditsharma.info@gmail.com>
	<20240705220018.414771-2-muditsharma.info@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jul 2024 22:59:08 +0100
Mudit Sharma <muditsharma.info@gmail.com> wrote:

> Add support for BH1745, which is an I2C colour sensor with red, green,
> blue and clear channels. It has a programmable active low interrupt
> pin. Interrupt occurs when the signal from the selected interrupt
> source channel crosses set interrupt threshold high or low level.
> 
> Interrupt source for the device can be configured by enabling the
> corresponding event. Interrupt latch is always enabled when setting
> up interrupt.
> 
> Add myself as the maintainer for this driver in MAINTAINERS.
> 
> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
> Reviewed-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

One ordering bug introduced in this version + some minor other
comments.  I'd like Matti to check the GTS stuff though as I still
find it hard to get my head around!

Jonathan

> diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
> new file mode 100644
> index 000000000000..82677bc39158
> --- /dev/null
> +++ b/drivers/iio/light/bh1745.c
> @@ -0,0 +1,877 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ROHM BH1745 digital colour sensor driver
> + *
> + * Copyright (C) Mudit Sharma <muditsharma.info@gmail.com>
> + *
> + * 7-bit I2C slave addresses:
> + *  0x38 (ADDR pin low)
> + *  0x39 (ADDR pin high)
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/util_macros.h>
> +#include <linux/iio/events.h>
> +#include <linux/regmap.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/iio-gts-helper.h>
> +
> +/* BH1745 configuration registers */
> +
> +/* System control */
> +#define BH1745_SYS_CTRL 0x40
> +#define BH1745_SW_RESET BIT(7)
> +#define BH1745_INTR_RESET BIT(6)
> +#define BH1745_PART_ID_MASK GENMASK(5, 0)
> +#define BH1745_PART_ID 0x0B
> +
> +/* Mode control 1 */
> +#define BH1745_MODE_CTRL_1 0x41
> +#define BH1745_MEASUREMENT_TIME_MASK GENMASK(2, 0)
> +
> +/* Mode control 2 */
> +#define BH1745_MODE_CTRL_2 0x42
> +#define BH1745_RGBC_EN BIT(4)
> +#define BH1745_ADC_GAIN_MASK GENMASK(1, 0)
Name the fields so it's obvious what register they are in.
#define BH1745_CTRL2_RGBC_EN 
etc

Then it is much easier to check this set of defines against the datasheet
once and then see inline if register fields are being written to the
correct registers etc.

> +
> +static const struct iio_itime_sel_mul bh1745_itimes[] = {
> +	GAIN_SCALE_ITIME_US(5120000, BH1745_MEASUREMENT_TIME_5120MS, 32),
> +	GAIN_SCALE_ITIME_US(2560000, BH1745_MEASUREMENT_TIME_2560MS, 16),
> +	GAIN_SCALE_ITIME_US(1280000, BH1745_MEASUREMENT_TIME_1280MS, 8),
> +	GAIN_SCALE_ITIME_US(640000, BH1745_MEASUREMENT_TIME_640MS, 4),
> +	GAIN_SCALE_ITIME_US(320000, BH1745_MEASUREMENT_TIME_320MS, 2),
> +	GAIN_SCALE_ITIME_US(160000, BH1745_MEASUREMENT_TIME_160MS, 1),
> +};
> +
> +struct bh1745_data {
> +	/* Lock to prevent device setting update or read before

	/*
	 * Lock

is the comment syntax used in IIO (and most, not not all :(, of the rest of the kernel)

> +	 * related calculations are completed
> +	 */
> +	struct mutex lock;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct iio_trigger *trig;
> +	struct iio_gts gts;
> +	int irq;
> +};

> +
> +static int bh1745_get_int_time(struct bh1745_data *data, int *val)
> +{
> +	int ret;
> +	int int_time;
> +
> +	ret = regmap_read(data->regmap, BH1745_MODE_CTRL_1, &int_time);
Trivial but as a general rule, more readable to not change the
meaning of a variable during a function.  Here it starts out as the
register value then becomes the field.

Better to use 2 local variables to make the difference clear.
The compiler can do the same thing in either case anyway (use same storage
or different storage) so we might as well go for readability.

There are other similar cases that would be nice to clean up
> +	if (ret)
> +		return ret;
> +
> +	int_time = FIELD_GET(BH1745_MEASUREMENT_TIME_MASK, int_time);
> +	ret = iio_gts_find_int_time_by_sel(&data->gts, int_time);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = ret;
> +
> +	return 0;
> +}

> +static int bh1745_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	guard(mutex)(&data->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return bh1745_set_scale(data, val, val2);
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		return bh1745_set_int_time(data, val, val2);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bh1745_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan,
> +				      long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT;

If you are forcing the type for scale to be integer, why
does bh1745_set_scale() take val2?  That will always be zero.

> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}




> +
> +static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	struct {
> +		u16 chans[4];
> +		s64 timestamp __aligned(8);
> +	} scan;
> +	u16 value;
> +	int ret;
> +	int i, j = 0;
Prefer that you don't mix variable declarations that set up a value with those
that don't as in general it hurts readability.

	int ret, i;
	int j = 0;

> +
> +	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
> +		ret = regmap_bulk_read(data->regmap, BH1745_RED_LSB + 2 * i, &value, 2);
> +		if (ret)
> +			goto err;
> +		scan.chans[j++] = value;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
> +
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int bh1745_setup_triggered_buffer(struct iio_dev *indio_dev, struct device *parent)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	struct device *dev = data->dev;
> +	int ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(parent, indio_dev, NULL,
> +					      bh1745_trigger_handler, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Triggered buffer setup failed\n");
> +
> +	if (data->irq) {
> +		ret = devm_request_threaded_irq(dev, data->irq, NULL,
> +						bh1745_interrupt_handler,
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
Type of interrupt is a question for firmware - not the driver.
Should only have IRQF_ONESHOT in here.

Note we have this wrong in a lot of old drivers, but can't fix them as we have
no way to know if there is a broken firmware out there on a board where the
driver overriding it is the only way it works.  However, that doesn't mean
to say we will introduce new cases!

> +						"bh1745_interrupt", indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Request for IRQ failed\n");
> +	}
> +
> +	return 0;
> +}

> +
> +static int bh1745_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	int part_id;
> +	struct bh1745_data *data;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &client->dev;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	indio_dev->info = &bh1745_info;
> +	indio_dev->name = "bh1745";
> +	indio_dev->channels = bh1745_channels;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = ARRAY_SIZE(bh1745_channels);
> +	data = iio_priv(indio_dev);
> +	data->dev = &client->dev;
> +	data->irq = client->irq;

Pass the irq directly to the function that needs it as a pameter.
There is very rarely a  reason to keep a copy of it after probe()
and there doesn't seem to be one here.

> +	data->regmap = devm_regmap_init_i2c(client, &bh1745_regmap);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "Failed to initialize Regmap\n");
> +
> +	ret = regmap_read(data->regmap, BH1745_SYS_CTRL, &part_id);
> +	if (ret)
> +		return ret;
> +
> +	part_id = FIELD_GET(BH1745_PART_ID_MASK, part_id);
> +	if (part_id != BH1745_PART_ID)
> +		dev_warn(dev, "Unknown part ID 0x%x\n", part_id);
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable regulator\n");
> +
> +	ret = bh1745_init(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = bh1745_setup_triggered_buffer(indio_dev, indio_dev->dev.parent);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, bh1745_power_off, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add action or reset\n");

This block must be immediately after bh1745_init() block above.  It's undoing
an action in there.  As you have it here and error from bh1745_setup_triggered_buffer()
will result in the device being left turned on.

A better solution that would prevent this getting broken again would be to move it
into the bh1745_init() function. 
That would put it right next to the power_on call and make everything more obviously
correct.



> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register device\n");
> +
> +	return 0;
> +}

