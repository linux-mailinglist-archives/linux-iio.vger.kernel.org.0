Return-Path: <linux-iio+bounces-23464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A59B3CCD7
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB56E7A93D2
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1C427A133;
	Sat, 30 Aug 2025 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdP3c489"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F22B17A316;
	Sat, 30 Aug 2025 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756570754; cv=none; b=Q00Q0H+GRGNA/7l6PYjzaKervEpxbqrxuqcQAotHkCkCIiuM7CHIcBae7SSqXoBgUsxNPkpOvz81lIzReavotKcHjf2MSe6Q9cBhwAGZjmP9AmNKzj6xRfaFYdcLHV0xLGpeuiZmJNi7i9rDeqLhegI18GUa+2TY9lDiFWWxKKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756570754; c=relaxed/simple;
	bh=u0xtd7PoJg0IlvT7dHfA3KGBTUF/8ylII6urJtEs5Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbvetFRjs9Uv1JQZRgR4s26NASBOlKt3cHhEwvmf2znCykYuYctG1/I/VfIEW7Lrq0wCw9tlrRrMyiLDVRJKaN61zCnuHGA8wV1X2UjIkF/1Zo1Q+/AgU8RJu0jfFEMOWK+SxncM9JJc6miP5fPzjLzHSSLhTkzg4hvbESNhmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdP3c489; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C30C4CEEB;
	Sat, 30 Aug 2025 16:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756570753;
	bh=u0xtd7PoJg0IlvT7dHfA3KGBTUF/8ylII6urJtEs5Z8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OdP3c4893vimCRqDyhHr8dhvk1maOddjmzmym7VoWoGEEeTj2UuNUW6WbLGsSLiXD
	 gyULaFKDLz7FuoSctY51yOhh/f46J8U6vAtPlzgJ/u9L6O2j1VBugRquavJbGnJN4B
	 D2MKLYWWdfaMVlNyhsuSXeqVIXkz2+sSwsZWR7KJFZ/2DU59hGwQSG5x3IwcQfBSlG
	 FzVS+vBW2VyY/q+xnILVl+Hyi/wISKYSKKVtkO7WjNoayUruNII2TvXNaOTAFbHqlF
	 4HQS8C1Yf7YeMYV7fQdDvZ/lqMSuPBVqu/oHc9d+704uI3kaI7qNh3CAoBeZE6D/Dk
	 VNt6coWkU/4jQ==
Date: Sat, 30 Aug 2025 17:19:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <20250830171905.28274239@jic23-huawei>
In-Reply-To: <20250829-tlv493d-sensor-v6_16-rc5-v5-1-746e73bc6c11@gmail.com>
References: <20250829-tlv493d-sensor-v6_16-rc5-v5-0-746e73bc6c11@gmail.com>
	<20250829-tlv493d-sensor-v6_16-rc5-v5-1-746e73bc6c11@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 08:23:42 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> applications includes joysticks, control elements (white goods,
> multifunction knops), or electric meters (anti tampering) and any
> other application that requires accurate angular measurements at
> low power consumptions.
> 
> The Sensor is configured over I2C, and as part of Sensor measurement
> data it provides 3-Axis magnetic fields and temperature core measurement.
> 
> The driver supports raw value read and buffered input via external trigger
> to allow streaming values with the same sensing timestamp.
> 
> While the sensor has an interrupt pin multiplexed with an I2C SCL pin.
> But for bus configurations interrupt(INT) is not recommended, unless timing
> constraints between I2C data transfers and interrupt pulses are monitored
> and aligned.
> 
> The Sensor's I2C register map and mode information is described in product
> User Manual [1].
> 
> Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf [1]
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>

Hi Dixit,

A few trivial formatting related things inline.  I'd just have tweaked these
whilst applying but we need to have a v6 for the dt-binding/maintainers stuff
anyway so please tidy these up as well.

Thanks,

Jonathan


> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
> index 9297723a97d8..dfe970fcacb8 100644
> --- a/drivers/iio/magnetometer/Makefile
> +++ b/drivers/iio/magnetometer/Makefile
> @@ -23,6 +23,8 @@ st_magn-$(CONFIG_IIO_BUFFER) += st_magn_buffer.o
>  obj-$(CONFIG_IIO_ST_MAGN_I2C_3AXIS) += st_magn_i2c.o
>  obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) += st_magn_spi.o
>  
> +obj-$(CONFIG_INFINEON_TLV493D)		+= tlv493d.o
> +
>  obj-$(CONFIG_SENSORS_HMC5843)		+= hmc5843_core.o
>  obj-$(CONFIG_SENSORS_HMC5843_I2C)	+= hmc5843_i2c.o
>  obj-$(CONFIG_SENSORS_HMC5843_SPI)	+= hmc5843_spi.o
> diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetometer/tlv493d.c
> new file mode 100644
> index 000000000000..b723eaac1d9e
> --- /dev/null
> +++ b/drivers/iio/magnetometer/tlv493d.c
> @@ -0,0 +1,533 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/**

This isn't kernel doc format. Headers descriptions like this normally aren't
so /* not /** is appropriate. I haven't checked but I'd expect the kernel-doc
script to have warned about that if run on this file

> + * Driver for the Infineon TLV493D Low-Power 3D Magnetic Sensor
> + *
> + * Copyright (C) 2025 Dixit Parmar <dixitparmar19@gmail.com>
> + */
> +/*
> + * Different mode has different measurement sampling time, this time is
> + * used in deriving the sleep and timeout while reading the data from
> + * sensor in polling.
> + * Power-down mode: No measurement.
> + * Fast mode: Freq:3.3 KHz. Measurement time:305 usec.
> + * Low-power mode: Freq:100 Hz. Measurement time:10 msec.
> + * Ultra low-power mode: Freq:10 Hz. Measurement time:100 msec.
> + * Master controlled mode: Freq:3.3 Khz. Measurement time:305 usec.
> + */
> +static const u32 tlv493d_sample_rate_us[] = {
> +	[TLV493D_OP_MODE_POWERDOWN] = 0,
> +	[TLV493D_OP_MODE_FAST] = 305,
> +	[TLV493D_OP_MODE_LOWPOWER] = 10 * USEC_PER_MSEC,
> +	[TLV493D_OP_MODE_ULTRA_LOWPOWER] = 100 * USEC_PER_MSEC,
> +	[TLV493D_OP_MODE_MASTERCONTROLLED] = 305,
> +};
> +
> +static int tlv493d_write_all_regs(struct tlv493d_data *data)
> +{
> +	int ret;
> +	struct device *dev = &data->client->dev;
> +
> +	ret = i2c_master_send(data->client, data->wr_regs, ARRAY_SIZE(data->wr_regs));
> +	if (ret < 0) {
> +		dev_err(dev, "i2c write registers failed, error: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}


> +static int tlv493d_get_measurements(struct tlv493d_data *data, s16 *x, s16 *y,
> +				    s16 *z, s16 *t)
> +{
> +	u8 buff[7] = {};
> +	int err, ret;
> +	struct device *dev = &data->client->dev;
> +	u32 sleep_us = tlv493d_sample_rate_us[data->mode];
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Poll until data is valid,

. rather than , given next line is a new sentence.

> +	 * For a valid data TLV493D_TEMP_CHANNEL bit of TLV493D_RD_REG_TEMP
> +	 * should be set to 0. The sampling time depends on the sensor mode.
> +	 * Poll 3x the time of the sampling time.
> +	 */
> +	ret = read_poll_timeout(i2c_master_recv, err,
> +			err || !FIELD_GET(TLV493D_TEMP_CHANNEL,
> +			buff[TLV493D_RD_REG_TEMP]),

If you are going to split the FIELD_GET between parameters you must
align the second line of parameters after the (  otherwise this is
unnecessarily hard to read.

	ret = read_poll_timeout(i2c_master_recv, err,
		err || !FIELD_GET(TLV493D_TEMP_CHANNEL,	buff[TLV493D_RD_REG_TEMP]),
		sleep_us, 3 * sleep_us, false, data->client, buff,
		ARRAY_SIZE(buff));

Is a better way to format this.  Once we aren't aligning with the opening
bracket of read_poll_timeout because of the very long line, a single tab of
indent of the second line is enough.  Don't worry about going a little over 80 chars
here as it really hurts readability to split that FIELD_PREP() up.


> +	if (ret) {
> +		dev_err(dev, "i2c read poll timeout, error:%d\n", ret);
> +		goto out_put_autosuspend;
> +	}
> +	if (err < 0) {
> +		dev_err(dev, "i2c read data failed, error:%d\n", err);
> +		ret = err;
> +		goto out_put_autosuspend;
> +	}
> +
> +	*x = tlv493d_get_channel_data(buff, TLV493D_AXIS_X);
> +	*y = tlv493d_get_channel_data(buff, TLV493D_AXIS_Y);
> +	*z = tlv493d_get_channel_data(buff, TLV493D_AXIS_Z);
> +	*t = tlv493d_get_channel_data(buff, TLV493D_TEMPERATURE);
> +
> +out_put_autosuspend:
> +	pm_runtime_put_autosuspend(dev);
> +	return ret;
> +}


> +static int tlv493d_read_raw(struct iio_dev *indio_dev,
> +			const struct iio_chan_spec *chan, int *val,
> +			int *val2, long mask)
> +{
> +	struct tlv493d_data *data = iio_priv(indio_dev);
> +	s16 x, y, z, t;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = tlv493d_get_measurements(data, &x, &y, &z, &t);
> +		if (ret)
> +			return ret;
> +
> +		/* Return raw values for requested channel */

Not return in the C meaning of it, and that comment doesn't
really add anything, so I'd just drop it.

> +		switch (chan->address) {
> +		case TLV493D_AXIS_X:
> +			*val = x;
> +			return IIO_VAL_INT;
> +		case TLV493D_AXIS_Y:
> +			*val = y;
> +			return IIO_VAL_INT;
> +		case TLV493D_AXIS_Z:
> +			*val = z;
> +			return IIO_VAL_INT;
> +		case TLV493D_TEMPERATURE:
> +			*val = t;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}


> +static int tlv493d_probe(struct i2c_client *client)
> +{

> +	indio_dev->info = &tlv493d_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = client->name;
> +	indio_dev->channels = tlv493d_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tlv493d_channels);
> +	indio_dev->available_scan_masks = tlv493d_scan_masks;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +				iio_pollfunc_store_time,
> +				tlv493d_trigger_handler,
> +				NULL);

If you align later lines of parameters with the start of the 1st
paramater, e.g. after the ( then this is still under 80 chars.

Given that is generally the preferred style where possible (in IIO
anyway) please do that here.

Jonathan

