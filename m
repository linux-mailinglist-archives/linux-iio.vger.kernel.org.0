Return-Path: <linux-iio+bounces-11366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F979B1AFD
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 23:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB87C28241A
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 21:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F4217E017;
	Sat, 26 Oct 2024 21:18:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDF2161
	for <linux-iio@vger.kernel.org>; Sat, 26 Oct 2024 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729977497; cv=none; b=PNY4Bl6H7gnj8xKqODwidZp+I9ZYbgZkmTi0i9l9smcJvYQ9hhpbNQ0lkGiqpIo+PzCXlOiCRsJHz55CpUAASYrn1+aMlMDsjaxDWZndj6CMmnUnKr3pXTscHXrfV8S8QrSVIvj3bJaphroUj6WD6qcKrkdBfuNeFYctdsaMwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729977497; c=relaxed/simple;
	bh=M1FIJtbMp9XTyhiX8Qr3cAi6OQrW7iFIhRDlMg/oDa0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4RpvUq/rWphJKDZlc6AKWBU4KwRL3uAuGsuzAWC6oJzNS/VTGS0yhl59K3GJs99LhLrzKgwaAIvpPDiuL7u7FcXSkXBG0keN26Oo+LbxkxBchZNgJqkqmFQhzxKLeE8NRjM+5uBHtWgjfFp/pEV3ABMGyj2snV/iOl28usIwDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-75.elisa-laajakaista.fi [88.113.24.75])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id c58833d2-93df-11ef-886f-005056bdd08f;
	Sun, 27 Oct 2024 00:17:57 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 27 Oct 2024 00:17:57 +0300
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: magnetometer: add Allegro MicroSystems
 ALS31300 3-D Linear Hall Effect driver
Message-ID: <Zx1chYp4FRyG8fKM@surfacebook.localdomain>
References: <20241021-topic-input-upstream-als31300-v2-0-36a4278a528e@linaro.org>
 <20241021-topic-input-upstream-als31300-v2-3-36a4278a528e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-topic-input-upstream-als31300-v2-3-36a4278a528e@linaro.org>

Mon, Oct 21, 2024 at 02:38:55PM +0200, Neil Armstrong kirjoitti:
> The Allegro MicroSystems ALS31300 is a 3-D Linear Hall Effect Sensor
> mainly used for 3D head-on motion sensing applications.
> 
> The device is configured over I2C, and as part of the Sensor data the
> temperature core is also provided.
> 
> While the device provides an IRQ gpio, it depends on a configuration
> programmed into the internal EEPROM, thus only the default mode is
> supported and buffered input via trigger is also supported to allow
> streaming values with the same sensing timestamp.
> 
> The device can be configured with different sensitivities in factory,
> but the sensitivity value used to calculate value into the Gauss
> unit is not available from registers, thus the sensitivity is provided
> by the compatible/device-id string which is based on the part number
> as described in the datasheet page 2.

...

Some headers are missing...

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>

+ pm.h

> +#include <linux/pm_runtime.h>

> +#include <linux/regulator/consumer.h>

+ types.h

...

> +#define ALS31300_DATA_X_GET(b)		\
> +		sign_extend32(FIELD_GET(ALS31300_VOL_MSB_X_AXIS, b[0]) << 4 | \
> +			      FIELD_GET(ALS31300_VOL_LSB_X_AXIS, b[1]), 11)
> +#define ALS31300_DATA_Y_GET(b)		\
> +		sign_extend32(FIELD_GET(ALS31300_VOL_MSB_Y_AXIS, b[0]) << 4 | \
> +			      FIELD_GET(ALS31300_VOL_LSB_Y_AXIS, b[1]), 11)
> +#define ALS31300_DATA_Z_GET(b)		\
> +		sign_extend32(FIELD_GET(ALS31300_VOL_MSB_Z_AXIS, b[0]) << 4 | \
> +			      FIELD_GET(ALS31300_VOL_LSB_Z_AXIS, b[1]), 11)
> +#define ALS31300_TEMPERATURE_GET(b)	\
> +		(FIELD_GET(ALS31300_VOL_MSB_TEMPERATURE, b[0]) << 6 | \
> +		 FIELD_GET(ALS31300_VOL_LSB_TEMPERATURE, b[1]))

These and in the code seems like you make a home grown endianes conversion.
I suppose all of them have to be __beXX with the respective masks that cover
all the bits.

> +static int als31300_get_measure(struct als31300_data *data,
> +				u16 *t, s16 *x, s16 *y, s16 *z)
> +{
> +	unsigned int count = 0;
> +	u32 buf[2];

Shouldn't this be __be64 buf?

> +	int ret;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret)
> +		return ret;

> +	/* Max update rate is 2KHz, wait up to 1ms */
> +	while (count < 50) {
> +		/* Read Data */
> +		ret = regmap_bulk_read(data->map, ALS31300_VOL_MSB, buf, 2);

At bare minimum ARRAY_SIZE(), but see above, I think it should use the respective type.

> +		if (ret) {
> +			dev_err(data->dev, "read data failed, error %d\n", ret);
> +			goto out;
> +		}
> +
> +		/* Check if data is valid, happens right after getting out of sleep mode */
> +		if (FIELD_GET(ALS31300_VOL_MSB_NEW_DATA, buf[0]))
> +			break;
> +
> +		usleep_range(10, 20);
> +		++count;
> +	}
> +
> +	if (count >= 50) {
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}

This one of the longest variant of implementing

	do {
		...
	} while (!FIELD_GET(...) && --count)

But you also may consider something from iopoll.h (I don't remember if we have
regmap_read_poll_timeout() for bulk transfers.

> +	*t = ALS31300_TEMPERATURE_GET(buf);
> +	*x = ALS31300_DATA_X_GET(buf);
> +	*y = ALS31300_DATA_Y_GET(buf);
> +	*z = ALS31300_DATA_Z_GET(buf);
> +
> +out:
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_autosuspend(data->dev);

Last discussion with Rafael on the topic of the above puts a question mark to
all these cases when runtime PM idle callback has not been implemented.

Shouldn't this be simply 

	pm_runtime_put(data->dev);

?

> +	return ret;
> +}

...

> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			/*
> +			 * Fractional part of:
> +			 *         1000 * 302 * (value - 1708)
> +			 * temp = ----------------------------
> +			 *             4096
> +			 * to convert temperature in millicelcius
> +			 */
> +			*val = 1000 * 302;

MILLI from units.h ?

> +			*val2 = 4096;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_MAGN:
> +			/*
> +			 * Devices are configured in factory
> +			 * with different sensitivities:
> +			 * - 500 GAUSS <-> 4 LSB/Gauss
> +			 * - 1000 GAUSS <-> 2 LSB/Gauss
> +			 * - 2000 GAUSS <-> 1 LSB/Gauss
> +			 * with translates by a division of the returned
> +			 * value to get Gauss value.
> +			 * The sensisitivity cannot be read at runtime
> +			 * so the value depends on the model compatible
> +			 * or device id.
> +			 */
> +			*val = 1;
> +			*val2 = data->variant_info->sensitivity;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}

...

> +	struct {
> +		u16 temperature;
> +		s16 channels[3];
> +		aligned_s64 timestamp;
> +	} __packed scan;

Why __packed?

...

> +static int als31300_set_operating_mode(struct als31300_data *data,
> +				       unsigned int val)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(data->map, ALS31300_VOL_MODE,
> +				 ALS31300_VOL_MODE_SLEEP, val);
> +	if (ret) {
> +		dev_err(data->dev, "failed to set operating mode (%pe)\n", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	/* The time it takes to exit sleep mode is equivalent to Power-On Delay Time */
> +	if (val == ALS31300_VOL_MODE_ACTIVE_MODE)
> +		usleep_range(600, 650);
> +
> +	return ret;

	return 0;

> +}

...

> +static int als31300_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct als31300_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->dev = dev;
> +	i2c_set_clientdata(i2c, indio_dev);

> +	mutex_init(&data->mutex);

Why not devm_mutex_init()? How does this being cleaned up?

> +	data->variant_info = i2c_get_match_data(i2c);
> +	if (!data->variant_info)
> +		return -EINVAL;
> +
> +	data->map = devm_regmap_init_i2c(i2c, &als31300_regmap_config);
> +	if (IS_ERR(data->map))
> +		return dev_err_probe(dev, PTR_ERR(data->map),
> +				     "failed to allocate register map\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vcc");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable regulator\n");
> +
> +	ret = als31300_set_operating_mode(data, ALS31300_VOL_MODE_ACTIVE_MODE);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to power on device\n");
> +
> +	ret = devm_add_action_or_reset(dev, als31300_power_down, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add powerdown action\n");
> +
> +	indio_dev->info = &als31300_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = i2c->name;
> +	indio_dev->channels = als31300_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(als31300_channels);
> +	indio_dev->available_scan_masks = als31300_scan_masks;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      als31300_trigger_handler,
> +					      &als31300_setup_ops);
> +	if (ret < 0) {
> +		dev_err(dev, "iio triggered buffer setup failed\n");
> +		return ret;

Why not return dev_err_probe(...);

> +	}
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 200);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "device register failed\n");
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



