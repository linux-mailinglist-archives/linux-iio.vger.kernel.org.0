Return-Path: <linux-iio+bounces-13895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D224A01549
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 15:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411873A1174
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 14:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CF01C3023;
	Sat,  4 Jan 2025 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxUkG+sI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCBF1B85C0;
	Sat,  4 Jan 2025 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736001168; cv=none; b=JqnlMYj6YoiQlNPURGlivcLCAnKl87UAMp8d95IyOHhSqV9NK2daSTuv0HKXs/vsrye+/GqEo7/WDjU4CohIPIbDvtSYxyJpNSnGiA1cID/QsYKy1n0/50wjf5zwcqEf2dLGZ0ArEyKIne0AbikTOqXcDCFSHYBbS+PrdAuYuwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736001168; c=relaxed/simple;
	bh=krl034N4LM+Mashdg37HEEbQlu1+NKbLEqyvvaE4uR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4E9vSPUgHmhaA60blp1MW3+99MCKVwj2TMP9GZSqED0/Z424AspTqk6RDaFSP5/UAxaeayJ+uN0VVZHe8W1mYKDVx0w69ueJCZg+1ZpBK6rYhMXE2+N8F9V0xm4c4B4CPjRm26kkAfYbAk4hgX6WXAwbjK2y0fZqqLtmuMl9YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxUkG+sI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2064C4CED2;
	Sat,  4 Jan 2025 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736001167;
	bh=krl034N4LM+Mashdg37HEEbQlu1+NKbLEqyvvaE4uR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qxUkG+sILaAksYN0RfJeO9bc0fH37BOuNC7AGN9gsWxel+lhFmgjPpT7C+9coao0n
	 HoomaYcN12p6MBLodNVISTfU9sHYJqFHQhP7KRyGBRKcFOflFjQJCUpxLUxV1NDmS9
	 Ga76zZjvTJlAnDAvowtCo1/S07qdi6Qd0S9qZ2jMAJvWPP0+uXeCS8mAO2BvHVLvKe
	 +GDbHlOr0s9NgGUW0j7zlOZwzL8xKKrR7ECKZ8VP5QmWF7mGiADOISAg8uv+jHfKQR
	 IUdzRDaxjwpu5poZqn000OdAAeBhyOpE3GjfW9EcOjjYuqeeVZeidco0IwkKYLZGR8
	 xUm4EE3dyZ0Ag==
Date: Sat, 4 Jan 2025 14:32:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: krzysztof.kozlowski@linaro.org, lars@metafoo.de, robh@kernel.org,
 conor+dt@kernel.org, andrej.skvortzov@gmail.com, neil.armstrong@linaro.org,
 danila@jiaxyga.com, icenowy@aosc.io, javier.carrasco.cruz@gmail.com,
 andy@kernel.org, megi@xff.cz, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: si7210: add driver for Si7210
Message-ID: <20250104143236.33e6ba3f@jic23-huawei>
In-Reply-To: <20241231132513.6944-3-apokusinski01@gmail.com>
References: <20241231132513.6944-1-apokusinski01@gmail.com>
	<20241231132513.6944-3-apokusinski01@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Dec 2024 14:25:13 +0100
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> Silicon Labs Si7210 is an I2C Hall effect magnetic position and
> temperature sensor. The driver supports the following functionalities:
> * reading the temperature measurements
> * reading the magnetic field measurements in a single-shot mode
> * choosing the magnetic field measurement scale (20 or 200 mT)
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
Hi Antoni

A few comments inline. Main one is that I 'think' the scale for the
temperature is off by 1000. I got a bit lost in the maths so may have
that wrong.

Jonathan

> diff --git a/drivers/iio/magnetometer/si7210.c b/drivers/iio/magnetometer/si7210.c
> new file mode 100644
> index 000000000000..3b9b5b9807fd
> --- /dev/null
> +++ b/drivers/iio/magnetometer/si7210.c
> @@ -0,0 +1,412 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Silicon Labs Si7210 Hall Effect sensor driver
> + *
> + * Copyright (c) 2024 Antoni Pokusinski <apokusinski01@gmail.com>
> + *
> + * Datasheet:
> + *  https://www.silabs.com/documents/public/data-sheets/si7210-datasheet.pdf
> + */
> +
> +#include <linux/module.h>

Order seems a bit random.  Probably better to just go alphabetical.

> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/regmap.h>
> +#include <linux/math64.h>
> +#include <linux/mutex.h>

> +struct si7210_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct mutex fetch_lock;
> +	struct mutex otp_lock;
Even though somewhat obvious, each lock needs a comment on what
data it is protecting.

For the otp_lock I'm not sure you even needed as it is only used
during probe.  If that weren't the case, can you safely overlap fetch
and otp?  Is it worth that distinction, if not is one lock enough?

> +	s8 temp_offset;
> +	s8 temp_gain;
> +	s8 scale_20_a[A_REGS_COUNT];
> +	s8 scale_200_a[A_REGS_COUNT];
> +	u8 curr_scale;
> +};
> +
> +static const struct iio_chan_spec si7210_channels[] = {
> +	{
> +		.type = IIO_MAGN,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	}
> +};
> +
> +static int si7210_fetch_measurement(struct si7210_data *data,
> +				    struct iio_chan_spec const *chan,
> +				    u8 buf[2])

See below. May be worth treating this as a __be16?
It is described in the datasheet as being made up of most significant
and least significant bytes so that seems a logic cleanup.

> +{
> +	u8 dspsigsel = chan->type == IIO_MAGN ? 0 : 1;
> +	int ret;
> +
> +	scoped_guard(mutex, &data->fetch_lock) {

As below. guard(mutex) better here to reduce indent a little and indicate the lock
is held for whole function.

> +		ret = regmap_update_bits(data->regmap, SI7210_REG_DSPSIGSEL,
> +					 SI7210_MASK_DSPSIGSEL, dspsigsel);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = regmap_update_bits(data->regmap, SI7210_REG_POWER_CTRL,
> +					 SI7210_MASK_ONEBURST | SI7210_MASK_STOP,
> +					 SI7210_MASK_ONEBURST & ~SI7210_MASK_STOP);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Read the contents of the registers containing the result: DSPSIGM, DSPSIGL */
> +		ret = regmap_bulk_read(data->regmap, SI7210_REG_DSPSIGM, buf, 2);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int si7210_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct si7210_data *data = iio_priv(indio_dev);
> +	long long tmp;
> +	u8 dspsig[2];
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = si7210_fetch_measurement(data, chan, dspsig);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ((dspsig[0] & 0x7F) << 8) + dspsig[1];

Very nearly a simple endian get. Probably better to treat it like
one anyway. *val = get_unaligned_be16(dpsig) & GENMASK(14, 0)

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		if (data->curr_scale == 20)
> +			*val2 = 1250;
> +		else /* data->curr_scale == 200 */
> +			*val2 = 12500;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = -16384;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = si7210_fetch_measurement(data, chan, dspsig);
> +		if (ret < 0)
> +			return ret;
> +
> +		tmp = ((dspsig[0] & 0x7F) << 5) + (dspsig[1] >> 3);

This may be appropriate as an endian read and FIELD_GET().  Perhaps not worth it
except that the type for the fetch_measurements could then be a __be16 rather than
what looks like unrelated u8 pair.

Given the docs have this a most and least significant bytes that seems to make
sense to me.

> +		tmp = (div_s64(-383 * tmp * tmp, 100) + (160940 * tmp - 279800000));
> +		tmp = (1 + (data->temp_gain >> 11)) * tmp + 62500 * data->temp_offset;
> +		tmp -= 732600;
This is form 0.222 * VDD, given you should have a regulator as per the binding feedback
you should be able to query that voltage.
> +
> +		*val = div_s64_rem(tmp, 1000000, val2);
> +
I think this is returning a value in degrees celsius?  IIO ABI matches older hwmon
on temperatures and is in milicelsius. (Documentation/ABI/testing/sysfs-bus-iio)

Please check other units match the aABI.

> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int si7210_set_scale(struct si7210_data *data, unsigned int scale)
> +{
> +	s8 *a_otp_values;
> +	int ret;
> +
> +	if (scale == 20)
> +		a_otp_values = data->scale_20_a;
> +	else if (scale == 200)
> +		a_otp_values = data->scale_200_a;
> +	else
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &data->fetch_lock) {
As below (though this one is a little less clear as it's mid way through the function).
I would just used guard()

> +		/* Write the registers 0xCA - 0xCC*/
> +		ret = regmap_bulk_write(data->regmap, SI7210_REG_A0, a_otp_values, 3);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Write the registers 0xCE - 0xD0*/
> +		ret = regmap_bulk_write(data->regmap, SI7210_REG_A3, &a_otp_values[3], 3);
> +		if (ret < 0)
> +			return ret;
> +
> +		data->curr_scale = scale;
> +	}
> +
> +	return 0;
> +}

> +static int si7210_read_otpreg_val(struct si7210_data *data, unsigned int otpreg, u8 *val)
> +{
> +	int ret;
> +	unsigned int otpdata;
> +
> +	scoped_guard(mutex, &data->otp_lock) {

As you hold the lock for the whole body, I would just use
	guard(mutex)(&datap->otp_lock);
as then the indent of the rest will be reduced, slightly improving readability.

> +		ret = regmap_write(data->regmap, SI7210_REG_OTP_ADDR, otpreg);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = regmap_update_bits(data->regmap, SI7210_REG_OTP_CTRL,
> +					 SI7210_MASK_OTP_READ_EN, SI7210_MASK_OTP_READ_EN);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = regmap_read(data->regmap, SI7210_REG_OTP_DATA, &otpdata);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = (u8)otpdata;
> +	}
> +
> +	return 0;
> +}
> +
> +static int si7210_device_wake(struct si7210_data *data)
> +{
> +	/* According to the datasheet, the primary method to wake up a device is
> +	 *  to send an empty write. However this is not feasible using current API so we
> +	 *  use the other method i.e. read a single byte. The device should respond with 0xFF
> +	 */
Comment syntax for IIO would make this
	/*
	 * According to the datasheet, the primary method to wake up a
	 * device is to send an empty write. However this is not feasible
	 * using current API so we use the other method i.e. read a single
	 * byte. The device should respond with 0xFF
	 */

> +
> +	int ret = 0;
> +
> +	ret = i2c_smbus_read_byte(data->client);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((u8)ret != 0xFF)

Why is the cast needed?

> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int si7210_device_init(struct si7210_data *data)
> +{
> +	int ret;
> +	unsigned int i;
> +
> +	ret = si7210_device_wake(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(1000, 1500);

fsleep() preferred.  It'll use slightly different range, but the aim of that
function is we never need to care what exactly is set and consider if the margin
is reasonable or not.

> +
> +	ret = si7210_read_otpreg_val(data, SI7210_OTPREG_TMP_GAIN, &data->temp_gain);
> +	if (ret < 0)
> +		return ret;
> +	ret = si7210_read_otpreg_val(data, SI7210_OTPREG_TMP_OFF, &data->temp_offset);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < A_REGS_COUNT; i++) {
> +		ret = si7210_read_otpreg_val(data, a20_otp_regs[i], &data->scale_20_a[i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	for (i = 0; i < A_REGS_COUNT; i++) {
> +		ret = si7210_read_otpreg_val(data, a200_otp_regs[i], &data->scale_200_a[i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = regmap_update_bits(data->regmap, SI7210_REG_ARAUTOINC,
> +				 SI7210_MASK_ARAUTOINC, SI7210_MASK_ARAUTOINC);
> +	if (ret < 0)
> +		return ret;
> +
> +	return si7210_set_scale(data, 20);
> +}
> +
> +static const struct iio_info si7210_info = {
> +	.read_raw = si7210_read_raw,
> +	.write_raw = si7210_write_raw,
> +};
> +
> +static int si7210_probe(struct i2c_client *client)
> +{
> +	struct si7210_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

Is this used?  If not don't set it.

> +	data->client = client;
> +
> +	mutex_init(&data->fetch_lock);
> +	mutex_init(&data->otp_lock);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &si7210_regmap_conf);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
> +				     "failed to register regmap\n");
> +
> +	indio_dev->name = dev_name(&client->dev);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &si7210_info;
> +	indio_dev->channels = si7210_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(si7210_channels);
> +
> +	ret = si7210_device_init(data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "device initialization failed\n");

Generally we try to keep the line length in IIO to traditional 80 chars
unless there is a good readability reason to do otherwise.  Here I'd wrap before
the message.

> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id si7210_id[] = {
> +	{ "si7210", 0 },

Trivial: No real point in setting the 0 explicitly.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, si7210_id);
> +
> +static const struct of_device_id si7210_dt_ids[] = {
> +	{ .compatible = "silabs,si7210" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, si7210_dt_ids);
> +
> +static struct i2c_driver si7210_driver = {
> +	.driver = {
> +		.name = "si7210",
> +		.of_match_table = si7210_dt_ids,
> +	},
> +	.probe		= si7210_probe,
> +	.id_table	= si7210_id,

Totally trivial but I'd not bother with tab alignment at all rather than mixing
using it and not here.
	.probe = si7120_probe, etc is fine and avoids mess of realigning in future
if something longer named turns up.

> +};
> +
> +module_i2c_driver(si7210_driver);
> +MODULE_AUTHOR("Antoni Pokusinski <apokusinski01@gmail.com>");
> +MODULE_DESCRIPTION("Silicon Labs Si7210 Hall Effect sensor I2C driver");
> +MODULE_LICENSE("Dual BSD/GPL");


