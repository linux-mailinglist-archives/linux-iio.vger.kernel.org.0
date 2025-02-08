Return-Path: <linux-iio+bounces-15167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D106BA2D6CE
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 16:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D6C3A29B2
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B213248172;
	Sat,  8 Feb 2025 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ1gGTXV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91A198E81;
	Sat,  8 Feb 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739027135; cv=none; b=Wz1bM6SxiqVn8sKevIkxRQBwueVuKEP5NHhHNyJObMDNzOId3ad0cJZZDKV+Ry7Gppe/kMu8P0fYBnZDHc1NUmg7qpLZGqUQdAsGyxz9QJ3/UPY/5aq9UEe3fxUOzsxq5/rlqps7VZvT8GQeYPd2CTsqoKBayLKTnvktxJTT0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739027135; c=relaxed/simple;
	bh=ixUc0ZH0loarblII9jtcqxL/zg34VJKoLNw8v9ev/qo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTo6580jwJbkF6tRPmBBo3+jEJrA6KrZXBHYo2AUh+ndfN0xaggIIAJO53i0fi7nqA3H6BAf41QfLg8m/lyLpt9UyhzwuFV7q/Vh2C4YG13dVGlfOBtg+9E1TooyPhEsMbO8uu+9uwJHkTQUvwV8Ix65ErU+TYLxccaDQWrDS48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ1gGTXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46014C4CED6;
	Sat,  8 Feb 2025 15:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739027134;
	bh=ixUc0ZH0loarblII9jtcqxL/zg34VJKoLNw8v9ev/qo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dQ1gGTXVs9kYjULKHBPcoFp32cfIjoHSRlSczlFm1KE22/bBAbw+swMrHmfDpiuSu
	 v48Ct0SlFcl3jwh9GGmejbnKLuaoHSO7xHN9pJ7UUiz4NC9akiJMKlRhVwTehpcQ0r
	 9V/qDK4ddiOqJzbkVe9PvmI2cwwvAeIp3CrBHUr2tLOQgtBG6qmobv2mhSO9VPiJet
	 Mr82dI5JpelihXWRDoTt/GUvJ7QpbD5gtvk5ArHNXTTl0I0TsSEuzbyIur1jr9Q2EE
	 D20l6uVyT3c8J28rK2o99zDxaC5HPgcmfTkv2jiOHZhWU4qZ8KU/qKS28XhysVFRHV
	 Od2EOnlyWFEqA==
Date: Sat, 8 Feb 2025 15:05:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tobias Sperling via B4 Relay
 <devnull+tobias.sperling.softing.com@kernel.org>
Cc: tobias.sperling@softing.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Message-ID: <20250208150526.10ee8f1c@jic23-huawei>
In-Reply-To: <20250206-adc_ml-v3-2-1d0bd3483aa2@softing.com>
References: <20250206-adc_ml-v3-0-1d0bd3483aa2@softing.com>
	<20250206-adc_ml-v3-2-1d0bd3483aa2@softing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Feb 2025 16:41:49 +0100
Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org> wrote:

> From: Tobias Sperling <tobias.sperling@softing.com>
> 
> Add driver for ADS7128 and ADS7138 12-bit, 8-channel analog-to-digital
> converters. These ADCs have a wide operating range and a wide feature
> set. Communication is based on the I2C interface.
> ADS7128 differs in the addition of further hardware features, like a
> root-mean-square (RMS) and a zero-crossing-detect (ZCD) module.
> 
> Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>

Hi Tobias,

Minor comments below and one question about power management

Thanks,

Jonathan


> diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..16d9ae7426522ddad62fd78ac6138aab6ab41101
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads7138.c
> @@ -0,0 +1,746 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * ADS7138 - Texas Instruments Analog-to-Digital Converter
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/unaligned.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +
> +/* AVDD (VREF) operating range in millivolts */

Generally a bad idea to use wild cards.  They go wrong far too often
as manufacturers love to make other uses of the product codes they cover.
Just pick a device that these values apply to and use that name
throughout.  Given driver name I'd just call these all ADS7138
unless they don't apply to that chip.
We've been bitten by this wild card thing too often in the past!

> +#define ADS71x8_AVDD_MV_MIN		2350


Good perhaps to have a comment on what the two sides of this are
and why it is structure like this.

> +static const int ads71x8_samp_freqs_bits[2][26] = {
> +	{
> +		163, 244, 326, 488, 651, 977, 1302, 1953,
> +		2604, 3906, 5208, 7813, 10417, 15625, 20833, 31250,
> +		41667, 62500, 83333, 125000, 166667, 250000, 333333, 500000,
> +		666667, 1000000
> +	}, {
> +		0x1f, 0x1e, 0x1d, 0x1c, 0x1b, 0x1a, 0x19, 0x18,
> +		0x17, 0x16, 0x15, 0x14, 0x13, 0x12, 0x11, 0x10,
> +		/* Here is a hole, due to duplicate frequencies */
> +		0x09, 0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02,
> +		0x01, 0x00
> +	}
> +};


> +static int ads71x8_i2c_write(const struct i2c_client *client, u8 reg, u8 value)
> +{
> +	return ads71x8_i2c_write_block(client, reg, &value, sizeof(value));

Maybe this should use the single register write (figure 35) rather than bulk one?
It makes no real difference though other than different opcode.

> +}
> +
> +static int ads71x8_i2c_setclear_bit(const struct i2c_client *client, u8 reg,
> +				    u8 bits, u8 opcode)

> +{
> +	u8 buf[3] = { opcode, reg, bits };
> +	int ret;
> +
> +	ret = i2c_master_send(client, buf, ARRAY_SIZE(buf));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != ARRAY_SIZE(buf))
> +		return -EIO;
> +
> +	return 0;
> +}

Whilst this is currently just used for setclear_bit, it is slightly more general
so maybe the name should reflect that it could be used for single register
writes for instance.  Naming is hard though and I can't immediately think
what name covers this combination.  

> +
> +static int ads71x8_read_event(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      enum iio_event_type type,
> +			      enum iio_event_direction dir,
> +			      enum iio_event_info info, int *val, int *val2)
> +{
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +	u8 reg, values[2];
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		reg = (dir == IIO_EV_DIR_RISING) ?
> +				ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel) :
> +				ADS71x8_REG_LOW_TH_CNT_CH(chan->channel);
> +		ret = ads71x8_i2c_read_block(data->client, reg, values,
> +					     ARRAY_SIZE(values));
> +		if (ret)
> +			return ret;
> +
> +		*val = ((values[1] << 4) | (values[0] >> 4));
> +		return IIO_VAL_INT;
> +	case IIO_EV_INFO_HYSTERESIS:
> +		ret = ads71x8_i2c_read(data->client,
> +				       ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel));
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = (ret & ~ADS71x8_THRESHOLD_LSB_MASK);

Brackets don't add much, so drop them in cases like this.

> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ads71x8_write_event(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info, int val, int val2)
> +{
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +	u8 reg, values[2];
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE: {
> +		if (val >= BIT(12) || val < 0)
> +			return -EINVAL;
> +
> +		reg = (dir == IIO_EV_DIR_RISING) ?
> +				ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel) :

For these cases indent by just one tab more than the line above.

> +				ADS71x8_REG_LOW_TH_CNT_CH(chan->channel);
> +
> +		guard(mutex)(&data->lock);
> +		ret = ads71x8_i2c_read(data->client, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		values[0] = ret & ~ADS71x8_THRESHOLD_LSB_MASK;
> +		values[0] |= FIELD_PREP(ADS71x8_THRESHOLD_LSB_MASK, val);
> +		values[1] = (val >> 4);
> +		return ads71x8_i2c_write_block(data->client, reg, values,
> +					       ARRAY_SIZE(values));
> +	}
> +	case IIO_EV_INFO_HYSTERESIS: {
> +		if (val >= BIT(4) || val < 0)
> +			return -EINVAL;
> +
> +		reg = ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel);
> +
> +		guard(mutex)(&data->lock);
> +		ret = ads71x8_i2c_read(data->client, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		values[0] = val & ~ADS71x8_THRESHOLD_LSB_MASK;
> +		values[0] |= FIELD_PREP(ADS71x8_THRESHOLD_LSB_MASK, ret >> 4);
> +		return ads71x8_i2c_write(data->client, reg, values[0]);
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}



> +static irqreturn_t ads71x8_event_handler(int irq, void *priv)
> +{
> +	struct iio_dev *indio_dev = priv;
> +	struct ads71x8_data *data = iio_priv(indio_dev);
> +	u8 i, events_high, events_low;
> +	u64 code;
> +	int ret;
> +
> +	/* Check if interrupt was trigger by us */
> +	ret = ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_FLAG);
> +	if (ret <= 0)
> +		return IRQ_NONE;
> +
> +	ret = ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_HIGH_FLAG);
> +	if (ret < 0) {
> +		dev_warn(&data->client->dev,

I would add a local
	struct device *dev = &data->client->dev;
given it's used a few times.

> +			 "Failed to read event high flags: %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +	events_high = ret;
> +
> +	ret = ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_LOW_FLAG);
> +	if (ret < 0) {
> +		dev_warn(&data->client->dev,
> +			 "Failed to read event low flags: %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +	events_low = ret;
> +
> +	for (i = 0; i < data->chip_data->channel_num; i++) {
> +		if (events_high & BIT(i)) {
> +			code = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING);
> +			iio_push_event(indio_dev, code,
> +				       iio_get_time_ns(indio_dev));
> +		}
> +		if (events_low & BIT(i)) {
> +			code = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_FALLING);
> +			iio_push_event(indio_dev, code,
> +				       iio_get_time_ns(indio_dev));
> +		}
> +	}
> +
> +	/* Try to clear all interrupt flags */
> +	ret = ads71x8_i2c_write(data->client, ADS71x8_REG_EVENT_HIGH_FLAG, 0xFF);
> +	if (ret)
> +		dev_warn(&data->client->dev,
> +			 "Failed to clear event high flags: %d\n", ret);
> +
> +	ret = ads71x8_i2c_write(data->client, ADS71x8_REG_EVENT_LOW_FLAG, 0xFF);
> +	if (ret)
> +		dev_warn(&data->client->dev,
> +			 "Failed to clear event low flags: %d\n", ret);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ads71x8_set_conv_mode(struct ads71x8_data *data,
> +				 enum ads71x8_modes mode)
> +{
> +	if (mode == ADS71x8_MODE_AUTO)
> +		return ads71x8_i2c_set_bit(data->client, ADS71x8_REG_OPMODE_CFG,
> +					   ADS71x8_OPMODE_CFG_CONV_MODE);
> +	return ads71x8_i2c_clear_bit(data->client, ADS71x8_REG_OPMODE_CFG,
> +				     ADS71x8_OPMODE_CFG_CONV_MODE);
> +}
> +
> +static int ads7138_init_hw(struct ads71x8_data *data)
> +{
> +	int ret;
> +
> +	data->vref_regu = devm_regulator_get_optional(&data->client->dev, "avdd");

avdd isn't optional. We need the power!  As such I'd not paper over the lack
of it being available.  To avoid weird effects on reading the scale later,
you may want to do a read here so that we can error out if a stub regulator
has been provided.


> +	if (IS_ERR(data->vref_regu))
> +		data->vref_regu = NULL;
> +
> +	/* Reset the chip to get a defined starting configuration */
> +	ret = ads71x8_i2c_set_bit(data->client, ADS71x8_REG_GENERAL_CFG,
> +				  ADS71x8_GENERAL_CFG_RST);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads71x8_set_conv_mode(data, ADS71x8_MODE_AUTO);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable statistics and digital window comparator */
> +	ret = ads71x8_i2c_set_bit(data->client, ADS71x8_REG_GENERAL_CFG,
> +				  (ADS71x8_GENERAL_CFG_STATS_EN |
> +				   ADS71x8_GENERAL_CFG_DWC_EN));

The inner brackets don't add much to readability so I'd be tempted to drop them.

> +	if (ret)
> +		return ret;
> +
> +	/* Enable all channels for auto sequencing */
> +	ret = ads71x8_i2c_set_bit(data->client, ADS71x8_REG_AUTO_SEQ_CH_SEL, 0xFF);
> +	if (ret)
> +		return ret;
> +
> +	/* Set auto sequence mode and start sequencing */
> +	return ads71x8_i2c_set_bit(data->client, ADS71x8_REG_SEQUENCE_CFG,
> +				   (ADS71x8_SEQUENCE_CFG_SEQ_START |
> +				    ADS71x8_SEQUENCE_CFG_SEQ_MODE));
> +}
> +
> +static int ads71x8_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct ads71x8_data *data;
> +	int ret = 0;

Value not used so drop setting it here.

> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	data->chip_data = i2c_get_match_data(client);
> +	if (!data->chip_data)
> +		return -ENODEV;
> +
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = data->chip_data->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ads71x8_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ads71x8_channels);
> +	indio_dev->info = &ti_ads71x8_info;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	if (client->irq > 0) {
> +		ret = devm_request_threaded_irq(dev, client->irq,
> +						NULL, ads71x8_event_handler,
> +						IRQF_TRIGGER_LOW |
> +						IRQF_ONESHOT | IRQF_SHARED,
> +						client->name, indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = ads7138_init_hw(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize device\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register iio device\n");
> +
> +	return 0;
> +}

> +
> +static const struct dev_pm_ops ads71x8_pm_ops = {
> +	RUNTIME_PM_OPS(ads71x8_runtime_suspend, ads71x8_runtime_resume, NULL)

Given it's likely that the runtime pm ops are better than nothing in
suspend and resume cases as well could we make this
DEFINE_RUNTIME_PM_OPS() which uses the runtime ops for those
cases as well?


> +};

