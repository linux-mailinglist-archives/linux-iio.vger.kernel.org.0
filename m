Return-Path: <linux-iio+bounces-23052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6253FB2DEC5
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 16:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8113A7B7F
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D55264A60;
	Wed, 20 Aug 2025 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f95pVk7Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4825725F798;
	Wed, 20 Aug 2025 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698927; cv=none; b=bjgBAGL9Wrn7OhhpxZOgrAawIBi5qS7e4EhUSRZkc+96GXwHEp16VM/9vEMwANCQJqETgjwnqtv03Ed8g8IbxfUNZgxzeLFoCD8UjP9jwTwKZhb0B5IReCuyoquyQ1VFd1XHqLpjcqcQPFbTILPt5kO9MnKcKGAw3WOME65pLRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698927; c=relaxed/simple;
	bh=JT5fbIVV1PlEoEDLWiwgYr8s80d/+idcn0bSCX/C5nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6RwudUWcwCxUP72n9rVg30vtHAxN77ZCdI+7ghA+iupKmSU2OMJEHVQjHjATB35458hLoA2bw6nYC2j6mpNbBHz1pIIUWQYCVMJE0HE707/MCWiEaVNDzha96PC3Blern9DiIvvgTX6E+uNcSr8elUDhc3mRUVzLXxQsQDMNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f95pVk7Y; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755698925; x=1787234925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JT5fbIVV1PlEoEDLWiwgYr8s80d/+idcn0bSCX/C5nY=;
  b=f95pVk7Y+6jRPU2SGazMPWXDusuHPwOz5a76D/cbEoa/QY90e/xX0wGf
   0D8PkmYOtzBBUVzv7nC1hXvSMue4fVVay6E6jux4/gimzXRAjm19/z/PG
   gzi25B1K2sSLdi/GFlc2sFN6Uokc3bilnZghcawpaWJN6wkf7wIQAmyLv
   nxBuVv/EW+ujlm2NaacPQ3wmgPITeIVqD/NlxEg0GkIGCOKuaaqyQNVCg
   w4kdGrJbX/BQ5ATlPQrVP7PR/u0gY3yQs4W5tB3wY6bJbYXt+ns8AtmQY
   2m50bVXf+AacDZDXOw7pnWCqYCQ7YAg6R3GD1frVK3drCy1kHVtF9KoEb
   g==;
X-CSE-ConnectionGUID: G6bRY8WsT2upuifvneCUng==
X-CSE-MsgGUID: K33i+kYDRn65r5zJ10pbXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="56993727"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="56993727"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:08:44 -0700
X-CSE-ConnectionGUID: SeH5IhflSRCaaeLwBTO8Vg==
X-CSE-MsgGUID: giXJZ4SGTdGwXKJkP5U4mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="205298112"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:08:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uojUU-00000006x8G-2L6R;
	Wed, 20 Aug 2025 17:08:38 +0300
Date: Wed, 20 Aug 2025 17:08:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <aKXW5pGiN18DyIZ7@smile.fi.intel.com>
References: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
 <20250814-tlv493d-sensor-v6_16-rc5-v4-1-81b82805aae0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250814-tlv493d-sensor-v6_16-rc5-v4-1-81b82805aae0@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 14, 2025 at 08:23:43AM +0530, Dixit Parmar wrote:
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

I haven't got the ordering rules here and in Kconfig. Can it be alphabetical?

...

> +enum tlv493d_channels {
> +	TLV493D_AXIS_X,
> +	TLV493D_AXIS_Y,
> +	TLV493D_AXIS_Z,
> +	TLV493D_TEMPERATURE
> +};
> +
> +enum tlv493d_op_mode {
> +	TLV493D_OP_MODE_POWERDOWN,
> +	TLV493D_OP_MODE_FAST,
> +	TLV493D_OP_MODE_LOWPOWER,
> +	TLV493D_OP_MODE_ULTRA_LOWPOWER,
> +	TLV493D_OP_MODE_MASTERCONTROLLED
> +};

+ trailing commas in both cases as discussed in the other email.

...

> +static const u32 tlv493d_sample_rate_us[] = {
> +	[TLV493D_OP_MODE_POWERDOWN] = 0,
> +	[TLV493D_OP_MODE_FAST] = 305,
> +	[TLV493D_OP_MODE_LOWPOWER] = 10000,
> +	[TLV493D_OP_MODE_ULTRA_LOWPOWER] = 100000,

Perhaps
	10 * USEC_PER_MSEC
	100 * USEC_PER_MSEC

respectively?

> +	[TLV493D_OP_MODE_MASTERCONTROLLED] = 305

+ Trailing comma.

> +};

...

> +static s16 tlv493d_get_channel_data(u8 *b, enum tlv493d_channels ch)
> +{
> +	u16 val;
> +
> +	switch (ch) {
> +	case TLV493D_AXIS_X:
> +		val = FIELD_GET(TLV493D_BX_MAG_X_AXIS_MSB, b[TLV493D_RD_REG_BX]) << 4 |
> +			FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> 4;

Wrong indentation, make both 'F':s to be in the same column.

> +		break;
> +	case TLV493D_AXIS_Y:
> +		val = FIELD_GET(TLV493D_BY_MAG_Y_AXIS_MSB, b[TLV493D_RD_REG_BY]) << 4 |
> +			FIELD_GET(TLV493D_BX2_MAG_Y_AXIS_LSB, b[TLV493D_RD_REG_BX2]);
> +		break;
> +	case TLV493D_AXIS_Z:
> +		val = FIELD_GET(TLV493D_BZ_MAG_Z_AXIS_MSB, b[TLV493D_RD_REG_BZ]) << 4 |
> +			FIELD_GET(TLV493D_BZ2_MAG_Z_AXIS_LSB, b[TLV493D_RD_REG_BZ2]);
> +		break;
> +	case TLV493D_TEMPERATURE:
> +		val = FIELD_GET(TLV493D_TEMP_TEMP_MSB, b[TLV493D_RD_REG_TEMP]) << 8 |
> +			FIELD_GET(TLV493D_TEMP2_TEMP_LSB, b[TLV493D_RD_REG_TEMP2]);
> +		break;
> +	}

Ditto for all of the above.

> +	return sign_extend32(val, 11);
> +}

...

> +static int tlv493d_get_measurements(struct tlv493d_data *data, s16 *x, s16 *y,
> +				s16 *z, s16 *t)

Indentation issue. Please, check fully the code for such issues.

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
> +	 * For a valid data TLV493D_TEMP_CHANNEL bit of TLV493D_RD_REG_TEMP should be set to 0.
> +	 * The sampling time depends on the sensor mode. poll 3x the time of the sampling time.
> +	 */
> +	ret = read_poll_timeout(i2c_master_recv, err, err ||
> +			FIELD_GET(TLV493D_TEMP_CHANNEL, buff[TLV493D_RD_REG_TEMP]) == 0,

Please, resplit logically, i.e leave the condition on the single line.
Also to make it shorter you can use '!' instead of ' == 0'.

> +			sleep_us, 3 * sleep_us, false, data->client, buff,
> +			ARRAY_SIZE(buff));
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

...

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

Just wondering if you have tested for negative coordinates, does it propagate
correctly?

> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_MAGN:
> +			/*
> +			 * Magnetic field scale: 0.0098 mTesla (i.e. 9.8 µT)
> +			 * Magnetic field in Gauss: mT * 10 = 0.098.
> +			 */
> +			*val = 98;
> +			*val2 = 1000;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_TEMP:
> +			/*
> +			 * Temperature scale: 1.1 °C per LSB, expressed as 1100 m°C
> +			 * Returned as integer for IIO core to apply:
> +			 * temp = (raw + offset) * scale
> +			 */
> +			*val = 1100;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			/*
> +			 * Temperature offset includes sensor-specific raw offset
> +			 * plus compensation for +25°C bias in formula.
> +			 * offset = -raw_offset + (25000 / 1100)
> +			 * -340 + 22.72 = -317.28
> +			 */
> +			*val = -31728;
> +			*val2 = 100;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	default:
> +		return -EINVAL;
> +	}

...

> +static irqreturn_t tlv493d_trigger_handler(int irq, void *ptr)
> +{
> +	int ret;
> +	s16 x, y, z, t;
> +	struct iio_poll_func *pf = ptr;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct tlv493d_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +	struct {
> +		s16 channels[3];
> +		s16 temperature;
> +		aligned_s64 timestamp;
> +	} scan;
> +
> +	ret = tlv493d_get_measurements(data, &x, &y, &z, &t);
> +	if (ret) {
> +		dev_err(dev, "failed to read sensor data\n");
> +		goto out_trigger_notify;
> +	}
> +
> +	scan.channels[0] = x;
> +	scan.channels[1] = y;
> +	scan.channels[2] = z;
> +	scan.temperature = t;
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +				pf->timestamp);

Interestingly that you have used 100 limit and suddenly don't do it here
and maybe elsewhere. Why inconsistent style? Please, go through the whole
file and make sure the style is consistent in all of the aspects:
- C style used
- comments style (one-line and multi-line)
- indentation
- etc.

> +out_trigger_notify:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

...

> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +				iio_pollfunc_store_time,
> +				tlv493d_trigger_handler,
> +				NULL);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "iio triggered buffer setup failed\n");
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret < 0)
> +		return ret;

For each of 'ret < 0' please double check that this is indeed required.
Otherwise, use common style for all standard cases, i.e.

	if (ret)

-- 
With Best Regards,
Andy Shevchenko



