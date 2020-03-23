Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5248418F3AD
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 12:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgCWLbX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 07:31:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:61095 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbgCWLbX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 07:31:23 -0400
IronPort-SDR: Bta/wWckJXfzKOj7hPpRt69BwS/7R3l2zwfx+yKyYUik6vhDRP96K8liB1WvOmTjCnkUU/u5Yd
 LL0tG57QTmTA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 04:31:20 -0700
IronPort-SDR: Wjyvv2Kx0BWtgkP7c9TIRKr+sa/KSa8eKsyGCJUbpPjeG+jc/4iC7MQTGgAJ/FesABeV3zVnE4
 0kNB+Pl+ilaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,296,1580803200"; 
   d="scan'208";a="246167057"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2020 04:31:18 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jGLIe-00CE0U-H1; Mon, 23 Mar 2020 13:31:20 +0200
Date:   Mon, 23 Mar 2020 13:31:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH v4] iio: accel: Add support for the Bosch-Sensortec BMI088
Message-ID: <20200323113120.GI1922688@smile.fi.intel.com>
References: <20200323092830.29708-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323092830.29708-1-mike.looijmans@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 23, 2020 at 10:28:30AM +0100, Mike Looijmans wrote:
> The BMI088 is a combined module with both accelerometer and gyroscope.
> This adds the accelerometer driver support for the SPI interface.
> The gyroscope part is already supported by the BMG160 driver.


Thank you, the comment about shared buffer given to v3 still applies.
Also see below.

...

> +enum bmi088_accel_axis {
> +	AXIS_X,
> +	AXIS_Y,
> +	AXIS_Z,

> +	AXIS_MAX,

If it's a terminator entry, comma is not needed.

> +};

...

> +/* Available ODR (output data rates) in Hz */
> +enum bmi088_odr_modes {
> +	BMI088_ACCEL_MODE_ODR_12_5 = 0x5,
> +	BMI088_ACCEL_MODE_ODR_25 = 0x6,
> +	BMI088_ACCEL_MODE_ODR_50 = 0x7,
> +	BMI088_ACCEL_MODE_ODR_100 = 0x8,
> +	BMI088_ACCEL_MODE_ODR_200 = 0x9,
> +	BMI088_ACCEL_MODE_ODR_400 = 0xa,
> +	BMI088_ACCEL_MODE_ODR_800 = 0xb,
> +	BMI088_ACCEL_MODE_ODR_1600 = 0xc,
> +};

I'm wondering if you need this enum at all? Only 3 out of 8 are in use, and 25
of them can be still derived from the 12.5 one.

Maybe replace with comment and ranges?

(But it's up to you, I have no strong opinion here)

...

> +static int bmi088_accel_set_power_state(struct bmi088_accel_data *data, bool on)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	if (on) {
> +		ret = pm_runtime_get_sync(dev);

		if (ret < 0)
			pm_runtime_put_noidle(dev);

See below.

> +	} else {
> +		pm_runtime_mark_last_busy(dev);
> +		ret = pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	if (ret < 0) {
> +		dev_err(dev, "Failed: %s(%d)\n", __func__, on);

> +		if (on)
> +			pm_runtime_put_noidle(dev);

Perhaps refactor as above?

In this case it maybe simple...

> +
> +		return ret;
> +	}
> +
> +	return 0;

...like this

	if (ret < 0)
		dev_err(dev, "Failed: %s(%d)\n", __func__, on);

	return ret < 0 ? ret : 0;

(I guess compiler is clever enough to avoid condition twice, but again, I have
 no strong opinion)

> +}

...

> +static int bmi088_accel_enable(struct bmi088_accel_data *data, bool on_off)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +

> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CTRL,
> +			   on_off ? 0x4 : 0x0);

I think

	u32 val = on_off ? 0x4 : 0x0;
	...
	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CTRL, val);

will look better.


> +	if (ret) {
> +		dev_err(dev, "Error writing ACC_PWR_CTRL reg\n");
> +		return ret;
> +	}

> +	return 0;
> +}
> +
> +/* In suspend mode, only the accelerometer is powered down. */
> +static int bmi088_accel_set_mode(struct bmi088_accel_data *data,
> +				enum bmi088_power_modes mode)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CONF,
> +			   mode == BMI088_ACCEL_MODE_SUSPEND ? 0x3 : 0x0);

Ditto.

> +	if (ret) {
> +		dev_err(dev, "Error writing ACCEL_PWR_CONF reg\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}

...

> +static int bmi088_accel_set_bw(struct bmi088_accel_data *data,
> +				enum bmi088_odr_modes odr_mode,
> +				enum bmi088_osr_modes osr_mode)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +	u8 value = (osr_mode << 4) | (odr_mode & 0xF);

_MASK (GENMASK() + _SHIFT? (See also below)

	u8 value = (osr_mode << _SHIFT) | (odr_mode & _MASK);
	int ret;

(note reverse xmas tree ordering)

> +
> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_CONF, value);
> +	if (ret) {
> +		dev_err(dev, "Error writing ACCEL_PWR_CONF reg\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmi088_accel_get_sample_freq(struct bmi088_accel_data *data,
> +					int* val, int *val2)
> +{
> +	unsigned int value;
> +	int ret;

> +	value &= 0xf; /* ODR in lower 4 bits */

_MASK? See above.

> +	if (value == BMI088_ACCEL_MODE_ODR_12_5) {
> +		*val = 12;
> +		*val2 = 500000;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +	} else {
> +		*val = 25 << (value - BMI088_ACCEL_MODE_ODR_25);
> +		*val2 = 0;
> +		ret = IIO_VAL_INT;
> +	}
> +
> +	return ret;
> +}

...

> +
> +static int bmi088_accel_set_sample_freq(struct bmi088_accel_data *data, int val)
> +{
> +	unsigned int value = BMI088_ACCEL_MODE_ODR_1600;
> +
> +	if (val < 12 || val > 1600)
> +		return -EINVAL;
> +

> +	value = fls(val) + (BMI088_ACCEL_MODE_ODR_12_5 - 4);

Wouldn't be

	value = fls(val) + 1;

more obvious? Or, perhaps,

	roundup_pow_of_two()

?

> +	return regmap_update_bits(data->regmap, BMI088_ACCEL_REG_ACC_CONF,
> +				  0x0f, value);

_MASK ?

> +}

> +	if (ret)
> +		return ret;
> +

> +	*val = temp >> 5;

Magic shift.

...

> +	s16 raw_val;

> +	ret = regmap_bulk_read(data->regmap,
> +			       BMI088_ACCEL_AXIS_TO_REG(chan->scan_index),
> +			       data->buffer, 2);
> +	raw_val = get_unaligned_le16(data->buffer);


I'm wondering if you can simple use le16_to_cpu()? I guess that buffer is
always aligned and since you access it always by even addresses, it implies
aligned access. Applies to other places as well.

...

> +		case IIO_ACCEL:

> +		{

Why do you need block?

> +			ret = regmap_read(data->regmap,
> +					  BMI088_ACCEL_REG_ACC_RANGE, val);
> +			if (ret)
> +				return ret;
> +

> +			*val2 =  15 - (*val & 0x3);

Extra spaces.

> +			*val = 3 * 980;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		}
> +		default:
> +			return -EINVAL;
> +		}

...

> +static const unsigned long bmi088_accel_scan_masks[] = {
> +	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
> +	0

+ comma or is it agreed value for termination the list?

> +};

...


> +	usleep_range(BMI088_ACCEL_MAX_STARTUP_TIME_MS * 1000,
> +		BMI088_ACCEL_MAX_STARTUP_TIME_MS * 1000 * 2);

	unsigned long /* or what is used */ sleep = BMI088_ACCEL_MAX_STARTUP_TIME_MS * USEC_PER_MSEC;
	...
	usleep_range(sleep, 2 * sleep);

?

...

> +	addr[0] |= 0x80; /* bit7 = RW = '1' */

BIT(7) ?

...

> +static const struct spi_device_id bmi088_accel_id[] = {

> +	{"bmi088_accel", 0},

', 0' part is not needed.

> +	{}
> +};



> +++ b/drivers/iio/accel/bmi088-accel.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef BMI088_ACCEL_H
> +#define BMI088_ACCEL_H
> +
> +extern const struct regmap_config bmi088_regmap_conf;
> +extern const struct dev_pm_ops bmi088_accel_pm_ops;

Do you need extern?

> +int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
> +			    const char *name, bool block_supported);
> +int bmi088_accel_core_remove(struct device *dev);

This needs

#include <linux/types.h>

struct device;
struct regmap;

-- 
With Best Regards,
Andy Shevchenko


