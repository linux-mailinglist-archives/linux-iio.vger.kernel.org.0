Return-Path: <linux-iio+bounces-7033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E46D91C6BA
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 21:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B341F25CCF
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 19:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B876410;
	Fri, 28 Jun 2024 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohIiPiSU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F451E4A4;
	Fri, 28 Jun 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603429; cv=none; b=OVOggLx7WlIIi7hSypU6dsf9n4deLkY3T1hX7I4oCn0W8QypcotBpCybyrD0nZLZvEyv/oozEPzXfT1C4R7qJHc5CWO0/5M0n4CkaURupFnOISC0cNuY/8EX5MdaK06Rr8UIbQe5IoJVftWoEB0w+XqVtrY+enwF0z4sQFNIndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603429; c=relaxed/simple;
	bh=A3DOGuzYQg8U7O96UunpvfXyOtdDzjeVCUlkWuncW+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtAMwxqhJXc00+zywZSfRf4oqWjDoMRLcoMXhQDiASqtM++wM+85pFdXvW47khJ7J5emxrvrQTR1C/92YnkNZwVGnPbLGXyj2tKtUoC7JlIkGKVcyLzt7ZzywlGqvzYL9COUW9jC1h+awZXYId77ovQJQHcoeS1qSX7DRZaR1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohIiPiSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFF7C116B1;
	Fri, 28 Jun 2024 19:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719603428;
	bh=A3DOGuzYQg8U7O96UunpvfXyOtdDzjeVCUlkWuncW+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ohIiPiSU4tSdulGljiqbSm6VLltX331DrPy8tAy3qR+NJk0CkHxooY/Y6HdRv1+x7
	 El5Ce3OMLhM4jrRiIPGDuGJzl2AIEwlMolZvnNj0MqDhY30sAcE25VPjJE8DGpqP+X
	 0zrKLXKjQloucC8/de1v0sbngIBWEOKUZ5cRrV79v6QjjBAnTpE5zrTMNl/FdiPbTO
	 vWRzurAVR3YzCa2DbLiY3oWg5EUHFYKP/J+Lx/eu+szVTtebpgjBUXPlO8zNLXPnoE
	 4ROl2FH+6Q8SJ72l6NYZ6bDyfFHOBK/O3xopibAw5KD3kuEHDOkOnqghoUdlr5AVzx
	 LTnfZAdO2YjBA==
Date: Fri, 28 Jun 2024 20:37:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mudit Sharma <muditsharma.info@gmail.com>
Cc: lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Ivan Orlov <ivan.orlov0322@gmail.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v6 2/2] iio: light: ROHM BH1745 colour sensor
Message-ID: <20240628203701.507c477c@jic23-huawei>
In-Reply-To: <20240625220328.558809-2-muditsharma.info@gmail.com>
References: <20240625220328.558809-1-muditsharma.info@gmail.com>
	<20240625220328.558809-2-muditsharma.info@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 23:03:26 +0100
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
Hi Mudit,

I'd failed on previous reviews to notice the odd trigger in here.
What is it, because it doesn't seem to be a dataready trigger as the device
doesn't seem to provide such an interrupt?

Various other comments inline.

Jonathan

> ---
> v5->v6:
> - Fix typo
> - Fix Indentation
> - Drop read in bh1745_set_trigger_state() as configuring all the value
> v4->v5:
> - Provide scale instead of HW gain
>   - Use GTS helpers
> - Code style fixes
> - Add check for part ID during probe
> - Always enable latch when enabling interrupt
> - Use devm_add_action_or_reset() and drop bh1745_remove() function
> - Drop custom DEVICE_ATTR and provide related read_avail and setup
>   interrupt source with event_config
> - Make buffer support independent of IRQ
> - Add power regulator handing with devm_regulator_get_enable()
> - Drop read and write wrappers and use regmap functions directly
> - Add MODULE_DEVICE_TABLE for of_device_id
> v3->v4:
> - Fix formatting:
>   - Remove redundant new line
>   - Use '0x' rather than '0X'
> v2->v3:
> - Squash commit for addition to MAINTAINERS
> - Fix code style for consistency:
>   - New line before last 'return'
>   - Use variable name 'value' instead of 'val' in
>     'bh1745_set_trigger_state()'
>   - Align function parameters to match parenthesis
>   - Avoid use of magic number
> - Use named enum instead of anonymous enum
> - Use 'guard(mutex)(&data->lock)' instead of 'mutex_lock()'
>   'mutex_unlock()'
> - Only initialize 'ret' and 'value' when necessary
> - Fix and optimize logic for `in_interrupt_latch_store()` 
> - Fix error handling in irq , trigger handlers and dev attribute for
>   latch
> v1->v2:
> - No changes
> 

> diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
> new file mode 100644
> index 000000000000..8412d5da3019
> --- /dev/null
> +++ b/drivers/iio/light/bh1745.c
> @@ -0,0 +1,931 @@

> +/* BH1745 config regs */
> +#define BH1745_SYS_CTRL 0x40
> +
> +#define BH1745_MODE_CTRL_1 0x41
> +#define BH1745_MODE_CTRL_2 0x42
> +#define BH1745_MODE_CTRL_3 0x44
> +
> +#define BH1745_INTR 0x60
> +#define BH1745_INTR_STATUS BIT(7)
> +
> +#define BH1745_PERSISTENCE 0x61
> +
> +#define BH1745_TH_LSB 0x62
> +#define BH1745_TH_MSB 0x63
> +
> +#define BH1745_TL_LSB 0x64
> +#define BH1745_TL_MSB 0x65
> +
> +#define BH1745_MANU_ID 0x92
> +
> +/* BH1745 output regs */
> +#define BH1745_RED_LSB 0x50
> +#define BH1745_RED_MSB 0x51
> +#define BH1745_GREEN_LSB 0x52
> +#define BH1745_GREEN_MSB 0x53
> +#define BH1745_BLUE_LSB 0x54
> +#define BH1745_BLUE_MSB 0x55
> +#define BH1745_CLEAR_LSB 0x56
> +#define BH1745_CLEAR_MSB 0x57
> +
> +#define BH1745_SW_RESET BIT(7)
> +#define BH1745_INT_RESET BIT(6)
> +
> +#define BH1745_MEASUREMENT_TIME_MASK GENMASK(2, 0)
These files should all be clearly associated with the register they are
in.  The current naming scheme doesn't make that connection clear.
I have no idea from these names for which register this will be ine.
> +
> +#define BH1745_RGBC_EN BIT(4)
> +
> +#define BH1745_ADC_GAIN_MASK GENMASK(1, 0)
> +
> +#define BH1745_INT_ENABLE BIT(0)
> +#define BH1745_INT_SIGNAL_ACTIVE BIT(7)
Same as INTR_STATUS above I think. 
> +
> +#define BH1745_INT_SIGNAL_LATCHED BIT(4)
> +
> +#define BH1745_INT_SOURCE_MASK GENMASK(3, 2)
These are related to the INTR register defined above
Move them up there adn rename them to match that naming scheme.

> +
> +#define BH1745_PART_ID 0x0B
> +#define BH1745_PART_ID_MASK GENMASK(5, 0)
> +
> +// From 16x max HW gain and 32x max integration time
/* */
> +#define BH1745_MAX_GAIN 512


> +
> +struct bh1745_data {
> +	/*
> +	 * Lock to prevent device setting update or read before related
> +	 * calculations or event push are completed
> +	 */
> +	struct mutex lock;
> +	struct regmap *regmap;
> +	struct i2c_client *client;
> +	struct iio_trigger *trig;
> +	struct iio_gts gts;
> +	u8 int_src;

I'd just read this back from the device (even though the regcache won't
help as it's a volatile register).

> +};

> +
> +static int bh1745_reset(struct bh1745_data *data)
> +{
> +	int ret;
> +	int value;
> +
> +	ret = regmap_read(data->regmap, BH1745_SYS_CTRL, &value);
> +	if (ret)
> +		return ret;
> +
> +	value |= (BH1745_SW_RESET | BH1745_INT_RESET);

regmap_set_bits()

check for other cases like this. Regmap has a rich set of read modify
write utility functions.


> +
> +	return regmap_write(data->regmap, BH1745_SYS_CTRL, value);
> +}


> +
> +static int bh1745_read_event_config(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	guard(mutex)(&data->lock);
> +
> +	return data->int_src;
As below. I would just read it back from the device to avoid storing
the state and anyone having to check that it is in sync when
reviewing the driver.

> +}
> +
> +static int bh1745_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir, int state)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	/*
> +	 * We do not update the interrupt source if 'state' value is '0' as
> +	 * there isn't a provision to not have an interrupt source at all.
> +	 */

There is an INT ENABLE field in the interrupt register on the datasheet google
found for me.  So why not use that?

> +	if (state == 1) {
> +		guard(mutex)(&data->lock);
> +		switch (chan->channel2) {
> +		case IIO_MOD_LIGHT_RED:
> +			ret = regmap_write_bits(data->regmap, BH1745_INTR,
> +						BH1745_INT_SOURCE_MASK,
> +						BH1745_INT_SOURCE_RED);
> +			if (ret)
> +				return ret;
> +
> +			data->int_src = BH1745_INT_SOURCE_RED;
Why cache it.  If anyone cares can you not read it back from the device?
That way you don't need to keep driver and device in sync by hand.

> +			break;
return 0;

No need to make the reader scroll down to find out nothing else happens. Same
in other cases.

> +
> +		case IIO_MOD_LIGHT_GREEN:
> +			ret = regmap_write_bits(data->regmap, BH1745_INTR,
> +						BH1745_INT_SOURCE_MASK,
> +						BH1745_INT_SOURCE_GREEN);
> +			if (ret)
> +				return ret;
> +
> +			data->int_src = BH1745_INT_SOURCE_GREEN;
> +			break;
> +
> +		case IIO_MOD_LIGHT_BLUE:
> +			ret = regmap_write_bits(data->regmap, BH1745_INTR,
> +						BH1745_INT_SOURCE_MASK,
> +						BH1745_INT_SOURCE_BLUE);
> +			if (ret)
> +				return ret;
> +
> +			data->int_src = BH1745_INT_SOURCE_BLUE;
> +			break;
> +
> +		case IIO_MOD_LIGHT_CLEAR:
> +			ret = regmap_write_bits(data->regmap, BH1745_INTR,
> +						BH1745_INT_SOURCE_MASK,
> +						BH1745_INT_SOURCE_CLEAR);
> +			if (ret)
> +				return ret;
> +
> +			data->int_src = BH1745_INT_SOURCE_CLEAR;
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}

> +static int bh1745_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	int value = 0;
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +
> +	if (state) {
> +		guard(mutex)(&data->lock);
> +		// Latch is always set when enabling interrupt

/* */ syntax for all comments in IIO other than the corner case of spdx
markings that sometimes need to c++ style

> +		value |= BH1745_INT_ENABLE |
> +			FIELD_PREP(BH1745_INT_SIGNAL_LATCHED, 1) |
> +			FIELD_PREP(BH1745_INT_SOURCE_MASK, data->int_src);
> +		return regmap_write(data->regmap, BH1745_INTR, value);
> +	}
> +
> +	return regmap_write(data->regmap, BH1745_INTR, value);
> +}
> +
> +static const struct iio_trigger_ops bh1745_trigger_ops = {
> +	.set_trigger_state = bh1745_set_trigger_state,
> +};
> +
> +static irqreturn_t bh1745_interrupt_handler(int interrupt, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	int ret;
> +	int value;
> +
> +	ret = regmap_read(data->regmap, BH1745_INTR, &value);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	if (value & BH1745_INTR_STATUS) {
> +		guard(mutex)(&data->lock);
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, data->int_src,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_EITHER),
> +			       iio_get_time_ns(indio_dev));

What is happening here.  You always push out the event and use that as
a trigger?  This is an unusual trigger if it's appropriate to use it for
one at all.  You've called it a dataready trigger but it is not obvious
that this device provides any such signal.

> +
> +		iio_trigger_poll_nested(data->trig);
> +
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +

> +
> +static int bh1745_setup_trigger(struct iio_dev *indio_dev, struct device *parent)
> +{
> +	struct bh1745_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +	int ret;
> +
> +	data->trig = devm_iio_trigger_alloc(parent, "%sdata-rdy-dev%d",
> +					    indio_dev->name,
> +					    iio_device_id(indio_dev));
> +	if (!data->trig)
> +		return -ENOMEM;
> +
> +	data->trig->ops = &bh1745_trigger_ops;
> +	iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +	ret = devm_iio_trigger_register(dev, data->trig);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Trigger registration failed\n");
> +
> +	ret = devm_iio_triggered_buffer_setup(parent, indio_dev, NULL,
> +					      bh1745_trigger_handler, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Triggered buffer setup failed\n");
> +
> +	if (data->client->irq) {

If you don't have an irq, how does the trigger registered above work?
That registration should be under this check as well so if you have no irq, you
don't register the trigger.  As it stands you have a trigger that will appear
to work but never fire.

> +		ret = devm_request_threaded_irq(dev, data->client->irq, NULL,
> +						bh1745_interrupt_handler,
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						"bh1745_interrupt", indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Request for IRQ failed\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int bh1745_init(struct bh1745_data *data)
> +{
> +	int ret;
> +	struct device *dev = &data->client->dev;
> +
> +	mutex_init(&data->lock);
> +	data->int_src = BH1745_INT_SOURCE_RED;
> +
> +	ret = devm_iio_init_iio_gts(dev, BH1745_MAX_GAIN, 0, bh1745_gain,
> +				    ARRAY_SIZE(bh1745_gain), bh1745_itimes,
> +				    ARRAY_SIZE(bh1745_itimes), &data->gts);
> +	if (ret)
> +		return ret;
> +
> +	ret = bh1745_reset(data);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to reset sensor\n");
> +		return ret;

return dev_err_probe() and no {} as it will be oen line.

> +	}
> +
> +	ret = bh1745_power_on(data);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to turn on sensor\n");
> +		return ret;
return dev_err_probe()

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
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable regulator\n");
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

I don't think you ever use this. If not no need to set it.

> +	data->client = client;
> +	indio_dev->info = &bh1745_info;
> +	indio_dev->name = "bh1745";
> +	indio_dev->channels = bh1745_channels;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = ARRAY_SIZE(bh1745_channels);
> +
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
> +	ret = bh1745_init(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, bh1745_power_off, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add action or reset\n");
> +
> +	ret = bh1745_setup_trigger(indio_dev, indio_dev->dev.parent);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register device\n");
> +		return ret;

return dev_err_probe().


> +	}
> +
> +	return 0;
> +}


