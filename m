Return-Path: <linux-iio+bounces-14215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061CCA0AA3C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038C316656F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3261B87F1;
	Sun, 12 Jan 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATVqQuhi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC601B3948;
	Sun, 12 Jan 2025 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736693685; cv=none; b=U+/wKVQ111k+WNTmiikHcQRHEYaNUSeuQ7tI/dfoXK5eU2JSBFWK6JShL/wRHOioNocLmNYq+6LVAt6pq2tAMNtOiPnrLU8onBCkE+FowsmtlzWatYs6ikkKXaQIXGtlGLqqbdYNwz2pLbZCHLdwOuuAO34J0kgMII9Z7gNiR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736693685; c=relaxed/simple;
	bh=SogzWzOfPnfubygeHqBxtJ3VhCumFs8JTueGakiYli8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0Boihos6Ux4HsmnT+Ajxez8AvMnpvcEoyYhCvpzvWkbNSxvc8qjnIVUA8mlYB+0/ZiWvVJjSTTpbhoAGRe6IBF0OU3f+hH1C+MqVbp0CDzziCh+OjlN1jwECZU0saBR0jNWt5BtTN2Qr8tH6EvenP15lAQzkLtwV3v23h8y9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATVqQuhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5B5C4CEDF;
	Sun, 12 Jan 2025 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736693684;
	bh=SogzWzOfPnfubygeHqBxtJ3VhCumFs8JTueGakiYli8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ATVqQuhiQ8EQgIql/hTldoGcxtaXZomSwBRawODJwjB8vDyHOD+YhDNsay/0dXFOM
	 UZrr4g2qP7JX0QFFhpfl21xIkOIT6j30ysesmYGJ/S1lm+T5R2s721dbm5zwel5X9c
	 nr4Vjera0rx/jDtXti3yARxk6MEofTn5p5qBb0t6fbjbFP7EuUz11IW4pjpYxpq/Ps
	 Bo5pW3Dw1gdmhx91xKK60I8JhM+bpEOJW8fHxQhnTjKa3ED/cfyNYwAf1HwtrxiB81
	 /FeYN7/bD7yKih+JpAzuIFXoFtYatPiBEg7kB0XxDa1zG1r1f7CIfcmA6MP4o56HqD
	 /pBAtUt3ml8dA==
Date: Sun, 12 Jan 2025 14:54:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrej.skvortzov@gmail.com, neil.armstrong@linaro.org,
 icenowy@aosc.io, megi@xff.cz, danila@jiaxyga.com,
 javier.carrasco.cruz@gmail.com, andy@kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: magnetometer: si7210: add driver for Si7210
Message-ID: <20250112145439.2624b22e@jic23-huawei>
In-Reply-To: <20250112104453.45673-3-apokusinski01@gmail.com>
References: <20250112104453.45673-1-apokusinski01@gmail.com>
	<20250112104453.45673-3-apokusinski01@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 11:44:53 +0100
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> Silicon Labs Si7210 is an I2C Hall effect magnetic position and
> temperature sensor. The driver supports the following functionalities:
> * reading the temperature measurements
> * reading the magnetic field measurements in a single-shot mode
> * choosing the magnetic field measurement scale (20 or 200 mT)
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
Hi Antoni,

Some issues in the endian handling as your fix for the build bot
warnings is backwards I think.
A few other comments inline.

Jonathan

> diff --git a/drivers/iio/magnetometer/si7210.c b/drivers/iio/magnetometer/si7210.c
> new file mode 100644
> index 000000000000..107312d127e6
> --- /dev/null
> +++ b/drivers/iio/magnetometer/si7210.c
> @@ -0,0 +1,428 @@
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
> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/math64.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

At lease linux/mod_devicetable.h is missing here.
we  more or less go by include what you use in kernel drivers so
you should make minimal assumptions about what includes what.
There are a few headers that are subsections of a wider interface
where that isn't necessary but for most things should be here.


> +static const struct iio_chan_spec si7210_channels[] = {
> +	{
> +		.type = IIO_MAGN,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> +	},
> +	{

Slight preference for more compact
	}, {


> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	}
> +};
> +
> +static int si7210_fetch_measurement(struct si7210_data *data,
> +				    struct iio_chan_spec const *chan,
> +				    __be16 *buf)
> +{
> +	u8 dspsigsel = chan->type == IIO_MAGN ? 0 : 1;
> +	int ret, result;
> +
> +	guard(mutex)(&data->fetch_lock);
> +
> +	ret = regmap_update_bits(data->regmap, SI7210_REG_DSPSIGSEL,
> +				 SI7210_MASK_DSPSIGSEL, dspsigsel);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_update_bits(data->regmap, SI7210_REG_POWER_CTRL,
> +				 SI7210_MASK_ONEBURST | SI7210_MASK_STOP,
> +				 SI7210_MASK_ONEBURST & ~SI7210_MASK_STOP);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Read the contents of the registers containing the result: DSPSIGM, DSPSIGL */
> +	ret = regmap_bulk_read(data->regmap, SI7210_REG_DSPSIGM, &result, 2);
use sizeof to replace that 2.

> +	if (ret < 0)
> +		return ret;
> +
> +	*buf = cpu_to_be16(result);

You've lost me.  The regmap bulk will load in 'an order'. Not sure whether thant
is big endian or little endian here, but it's definitely not CPU endian.
I 'think' you can read directly into buf.  Must be a wrong endian conversion
somewhere though as on typical le system you are currently reversing the bytes
here and at the callsite.

However, I think what you actually want is
static int si7210_fetch_measurement(struct si7210_data *data,
				    struct iio_chan_spec const *chan,
				    u16 *buf)
	__be16 result;
...


	ret = regmap_bulk_read(..., &result, sizeof(result));
...
	*buf = be16_to_cpu(result);





> +
> +	return 0;
> +}
> +
> +static int si7210_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct si7210_data *data = iio_priv(indio_dev);
> +	long long temp;
> +	__be16 dspsig;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = si7210_fetch_measurement(data, chan, &dspsig);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = dspsig & GENMASK(14, 0);
It is big endian. You can't do this and expect to hit the right bits.
More to the point you can't set val to the big endian anyway so markings
are wrong somewhere.

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
> +		ret = si7210_fetch_measurement(data, chan, &dspsig);
> +		if (ret < 0)
> +			return ret;
> +
Big endian, You can't do any of this safely. Convert it to cpu endian (e.g. u16)
first.
> +		temp = FIELD_GET(GENMASK(14, 3), dspsig);
> +		temp = div_s64(-383 * temp * temp, 100) + 160940 * temp - 279800000;
> +		temp = (1 + (data->temp_gain / 2048)) * temp + (1000000 / 16) * data->temp_offset;
> +
> +		ret = regulator_get_voltage(data->vdd);
> +		if (ret < 0)
> +			return ret;
> +
> +		temp -= 222 * div_s64(ret, 1000);
> +
> +		*val = div_s64(temp, 1000);
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
...

> +static int si7210_device_wake(struct si7210_data *data)
> +{
> +	/*
> +	 * According to the datasheet, the primary method to wake up a
> +	 * device is to send an empty write. However this is not feasible
> +	 * using current API so we use the other method i.e. read a single
> +	 * byte. The device should respond with 0xFF.
> +	 */
> +
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte(data->client);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret != 0xFF)
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
> +	fsleep(1000);
> +
> +	ret = si7210_read_otpreg_val(data, SI7210_OTPREG_TMP_GAIN, &data->temp_gain);
> +	if (ret < 0)
> +		return ret;

Blank line here and similar places where you have a call / check result pair before
doing something more or less unrelated.

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
>

