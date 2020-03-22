Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E957318E586
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 01:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgCVAQ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 20:16:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:63640 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbgCVAQ1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 20:16:27 -0400
IronPort-SDR: wcI2rlbUTz4rNlbAT4D21XudTzVrQYWYD1iLtOO/3xHaFy4k6ZDbNHZiHQLh4Snpm/KihCf/mY
 2Z3s110vRtTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2020 17:16:27 -0700
IronPort-SDR: qwzcQufUQI4z65Jdn4vXGYJt8gFp7OQsXvVcgDwmkwKi6cTTxIKgRukxqCddyW5YAe6kgN3sIR
 jqfhYkV2Acrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,290,1580803200"; 
   d="scan'208";a="292245426"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Mar 2020 17:16:25 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jFoI0-00Br79-8M; Sun, 22 Mar 2020 02:16:28 +0200
Date:   Sun, 22 Mar 2020 02:16:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH v3] iio: accel: Add support for the Bosch-Sensortec BMI088
Message-ID: <20200322001628.GA2824675@smile.fi.intel.com>
References: <20200316073208.19715-1-mike.looijmans@topic.nl>
 <20200315120238.18c10af0@archlinux>
 <20200313140415.20266-1-mike.looijmans@topic.nl>
 <46bec9b8-28ee-6fd3-f615-2b8db43626aa@metafoo.de>
 <20200319154842.1950-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319154842.1950-1-mike.looijmans@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 19, 2020 at 04:48:42PM +0100, Mike Looijmans wrote:
> The BMI088 is a combined module with both accelerometer and gyroscope.
> This adds the accelerometer driver support for the SPI interface.
> The gyroscope part is already supported by the BMG160 driver.

...

> +#include <linux/acpi.h>

How this is being used?

...

> +EXPORT_SYMBOL_GPL(bmi088_regmap_conf);
> +
> +

Too many blank lines

...

> +#ifdef CONFIG_PM

Hmm... Why do you need this? Doesn't PM runtime have the stubs for !PM case?

> +#else
> +static int bmi088_accel_set_power_state(struct bmi088_accel_data *data,
> +	bool on)
> +{
> +	return 0;
> +}
> +#endif

...

> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CTRL,
> +				on_off ? 0x4 : 0x0);
> +	if (ret < 0) {

Why all these ' < 0'? I don't remember that regmap API returns positive numbers
from this type of calls.

...

> +
> +static int bmi088_accel_set_sample_freq(struct bmi088_accel_data *data, int val)
> +{
> +	unsigned int value = BMI088_ACCEL_MODE_ODR_1600;
> +	unsigned int freq = 1600;
> +	int ret;
> +
> +	if (val < 12 || val > 1600)
> +		return -EINVAL;

> +	while (freq > val && value > BMI088_ACCEL_MODE_ODR_12_5) {
> +		--value;
> +		freq >>= 1;
> +	}

You can use bit operations instead of loop.

> +	ret = regmap_update_bits(data->regmap, BMI088_ACCEL_REG_ACC_CONF,
> +				 0x0f, value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;

	return regmap_...(...);

> +}

...

> +static int bmi088_accel_get_temp(struct bmi088_accel_data *data, int *val)
> +{
> +	int ret;
> +	__s16 temp;
> +
> +	mutex_lock(&data->mutex);

> +	ret = regmap_bulk_read(data->regmap, BMI088_ACCEL_REG_TEMP,
> +			       &data->buffer, 2);

sizeof() ?

> +	temp = get_unaligned_be16(data->buffer);
> +
> +	mutex_unlock(&data->mutex);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = temp >> 5;
> +
> +	return IIO_VAL_INT;
> +}

...

> +static int bmi088_accel_get_axis(struct bmi088_accel_data *data,
> +				 struct iio_chan_spec const *chan,
> +				 int *val)
> +{
> +	int ret;

> +	__s16 raw_val;

s16 ?
Also applies to the rest.

> +	return IIO_VAL_INT;
> +}

...

> +static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  int val, int val2, long mask)
> +{
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&data->mutex);
> +		ret = bmi088_accel_set_sample_freq(data, val);
> +		mutex_unlock(&data->mutex);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +

> +	return ret;

Replace break with this?

> +}

...

> +static struct attribute *bmi088_accel_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,

> +	NULL,

Terminators are good w/o comma.

> +};

...

> +static const unsigned long bmi088_accel_scan_masks[] = {
> +				BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
> +				0};

Indentation issues.

> +
> +

Too many blank lines.

...

> +	/* Validate chip ID */
> +	for (i = 0; i < ARRAY_SIZE(bmi088_accel_chip_info_tbl); i++) {
> +		if (bmi088_accel_chip_info_tbl[i].chip_id == val) {
> +			data->chip_info = &bmi088_accel_chip_info_tbl[i];
> +			break;
> +		}
> +	}

> +

No need for this blank line.

> +	if (!data->chip_info) {

More usual pattern to check loop counter against array size.

> +		dev_err(dev, "Invalid chip %x\n", val);
> +		return -ENODEV;
> +	}

...

> +	/* Set Default Range */
> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_RANGE,
> +			   BMI088_ACCEL_RANGE_6G);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;

	return regmap_...();

...

> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to register iio device\n");
> +		return ret;
> +	}
> +
> +	return 0;

	if (ret)
		dev_err();
	return ret;

...

> +	ret = bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
> +	if (ret < 0)
> +		return -EAGAIN;

Is this error code dictated by PM runtime API?
Otherwise
	return bmi088_...();

> +
> +	return 0;

-- 
With Best Regards,
Andy Shevchenko


