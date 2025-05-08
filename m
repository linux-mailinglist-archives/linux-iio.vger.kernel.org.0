Return-Path: <linux-iio+bounces-19349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DD2AB042E
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 21:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD073502FA1
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA6328A720;
	Thu,  8 May 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SA+Z9q0p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714B21D5B6;
	Thu,  8 May 2025 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734291; cv=none; b=t68k5XYwuJI0L2v1+hDii6PGpejF+UM4JB1dyAvEm9794duob4yR6sMEAUbt9Hz2zMyLj1xF/5uEnMoGJ/oCT0h2wG9p6LwcIBpPuN5lOn52G7IiyKz58yBlP4hZc71TdKcdCE7Ri97TWXtrV/Tqk2c6Njxoim2hzHiSrRpOikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734291; c=relaxed/simple;
	bh=cX0ijYbAQ+RscVslDuBRhN2LzfDx/NyKdCWEk55yOYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjzHM2L1mTYV1n4TmJQWAamoxjEXEXRdwDdWZVk0F2Jea+ovXOubhf22XUdCDxbe3i3OfiDeCLBjtU4ZwAguRNlYhuxn3BFQ5J4U1Ht+fVcb3KiDKXlK33/HXWK8Ytsabb36oHwBjvKyHkHJFiAAFMainwvLNtlErMFfM2u9+uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SA+Z9q0p; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746734289; x=1778270289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cX0ijYbAQ+RscVslDuBRhN2LzfDx/NyKdCWEk55yOYA=;
  b=SA+Z9q0pwExhS2+j8Rg+ETmoYtYtV9SemQMEkGa7pyd3MTXXDVtu/wd0
   cHBvAXimu73a/0Uhjc5frZNr0TRmVZrxqufxCLIAsBRAvWu4KIQPVTDjj
   Es7e/SDRuXTsK/MTIL9rSfKzYiWaXHQE5UfvSNd5KOULW5z361BJVoVLk
   7dETlmGdQvQpQKWSjAqBMIZf/0HDP76ZwC/SFQArZ5x9PR1bpydj/NI7m
   rK018F61gw1zzS6yM7qspqS/tvZrqYfwuIRo2La03h2Ix+7086Iz7WVs8
   bL57s+TbtsgubOA0p7aLEVvHwb0K6sNCXAFLjofSQB3/ulxwmfSpMaRKD
   A==;
X-CSE-ConnectionGUID: 8gppIe6xTjWJC8NXLIzZnA==
X-CSE-MsgGUID: 57EqjIebTke+a5KN9+olhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73920285"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="73920285"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:58:08 -0700
X-CSE-ConnectionGUID: ys8CgkrtQ1iUZnAxSO2j/w==
X-CSE-MsgGUID: IFMB8yhiTTWjBiadaZrodg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="137392231"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:58:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uD7NZ-00000004DZJ-2Wxa;
	Thu, 08 May 2025 22:58:01 +0300
Date: Thu, 8 May 2025 22:58:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andreas Klinger <ak@it-klinger.de>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lars@metafoo.de,
	javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
	muditsharma.info@gmail.com, perdaniel.olsson@axis.com,
	emil.gedenryd@axis.com, mgonellabolduc@dimonoff.com,
	arthur.becker@sentec.com, clamor95@gmail.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <aB0MycGnGRxJT7Pd@smile.fi.intel.com>
References: <20250505202313.205522-1-ak@it-klinger.de>
 <20250505202313.205522-3-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505202313.205522-3-ak@it-klinger.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 05, 2025 at 10:23:12PM +0200, Andreas Klinger wrote:
> Add Vishay VEML6046X00 high accuracy RGBIR color sensor.
> 
> This sensor provides three colour (red, green and blue) as well as one
> infrared (IR) channel through I2C.
> 
> Support direct and buffered mode.
> 
> An optional interrupt for signaling green colour threshold underflow or
> overflow is not supported so far.

...

> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +#include <linux/pm_runtime.h>

+ blank line

and keep each group sorted.

There are missing inclusions as well.

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>

> +/* Bit masks for specific functionality */
> +#define VEML6046X00_CONF0_ON_0      BIT(0)
> +#define VEML6046X00_CONF0_INT       BIT(1)
> +#define VEML6046X00_CONF0_AF_TRIG   BIT(2)
> +#define VEML6046X00_CONF0_AF        BIT(3)
> +#define VEML6046X00_CONF0_IT        GENMASK(6, 4)
> +#define VEML6046X00_CONF1_CAL       BIT(0)
> +#define VEML6046X00_CONF1_PERS      GENMASK(2, 1)
> +#define VEML6046X00_CONF1_GAIN      GENMASK(4, 3)
> +#define VEML6046X00_CONF1_PD_D2     BIT(6)
> +#define VEML6046X00_CONF1_ON_1      BIT(7)
> +#define VEML6046X00_INT_TH_H        BIT(1)
> +#define VEML6046X00_INT_TH_L        BIT(2)
> +#define VEML6046X00_INT_DRDY        BIT(3)

+ bits.h

...

> +#define VEML6046X00_INT_MASK        (VEML6046X00_INT_TH_H | \
> +				VEML6046X00_INT_TH_L | VEML6046X00_INT_DRDY)

Better formatting is

#define VEML6046X00_INT_MASK						     \
	(VEML6046X00_INT_TH_H | VEML6046X00_INT_TH_L | VEML6046X00_INT_DRDY)


> +/* Autosuspend delay */
> +#define VEML6046X00_AUTOSUSPEND_MS  3000

(3 * MSEC_PER_SEC)

(will require time.h to be included)

...

> +struct veml6046x00_data {
> +	struct device *dev;
> +	struct regmap *regmap;

Isn't dev the same as in regmap?
Why to have both?

> +	struct iio_trigger *trig;
> +	struct veml6046x00_rf rf;
> +};

...

> +struct veml6046x00_scan_buf {
> +	__le16 chans[4];
> +	aligned_s64 timestamp;
> +};

This is only used in one function, move it there like other drivers do.

...

> + * Columns:
> + * x0.25 x0.33 x0.5 x0.66 x1 x2
> + * Rows:
> + * 3.125 6.25 12.5 25 50 100 200 400ms

Better to have these as comments

...

> +static const u32 veml6046x00_it_gains[][6][2] = {

Also indentation is wrong.

> +{{5, 376000}, {4,  72700}, {2, 688000}, {2,  36400}, {1, 344000}, {0, 672000}},

	/* 3.125 */
	{
		{ 5, 376000 },		/* 0.25 */
		{ 4,  72700 },
		...
	},


> +{{2, 688000}, {2,  36350}, {1, 344000}, {1,  18200}, {0, 672000}, {0, 336000}},
> +{{1, 344000}, {1,  18175}, {0, 672000}, {0, 509100}, {0, 336000}, {0, 168000}},
> +{{0, 672000}, {0, 509087}, {0, 336000}, {0, 254550}, {0, 168000}, {0,  84000}},
> +{{0, 336000}, {0, 254543}, {0, 168000}, {0, 127275}, {0,  84000}, {0,  42000}},
> +{{0, 168000}, {0, 127271}, {0,  84000}, {0,  63637}, {0,  42000}, {0,  21000}},
> +{{0,  84000}, {0,  63635}, {0,  42000}, {0,  31818}, {0,  21000}, {0,  10500}},
> +{{0,  42000}, {0,  31817}, {0,  21000}, {0,  15909}, {0,  10500}, {0,   5250}},
> +};

Yes, it will be much longer, but much easier to read and check.

...

> +static int veml6046x00_power_on(struct veml6046x00_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_clear_bits(data->regmap, VEML6046X00_REG_CONF0,
> +						VEML6046X00_CONF0_ON_0);

Wrong indentation. Same applies to more places in the code.

> +	if (ret) {
> +		dev_err(data->dev, "Failed to set bit for power on %d\n", ret);
> +		return ret;
> +	}
> +
> +	return regmap_clear_bits(data->regmap, VEML6046X00_REG_CONF1,
> +						VEML6046X00_CONF1_ON_1);
> +}

...

> +	/* register value is identical with index of array */
> +	if ((reg >= 0) && (reg < ARRAY_SIZE(veml6046x00_it)))
> +		return reg;
> +
> +	return -EINVAL;

Invert the conditional to check for errors.

...

> +static int veml6046x00_get_it_usec(struct veml6046x00_data *data, int *it_usec)
> +{
> +	int ret, reg;
> +
> +	ret = regmap_field_read(data->rf.it, &reg);
> +	if (ret)
> +		return ret;
> +
> +	if ((reg >= 0) && (reg < ARRAY_SIZE(veml6046x00_it)))
> +		*it_usec = veml6046x00_it[reg][1];

> +	else

Redundant. (See above how to fix)

> +		return -EINVAL;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}

...

> +static int veml6046x00_set_it(struct iio_dev *iio, int val, int val2)
> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	int i;

Why signed?

> +	for (i = 0; i < ARRAY_SIZE(veml6046x00_it); i++) {
> +		if ((veml6046x00_it[i][0] == val) &&
> +		    (veml6046x00_it[i][1] == val2))
> +			return regmap_field_write(data->rf.it, i);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int veml6046x00_get_val_gain_idx(struct veml6046x00_data *data, int val,
> +								int val2)
> +{
> +	int i;

Ditto. And so on...

> +	int it_idx;
> +
> +	it_idx = veml6046x00_get_it_index(data);
> +	if (it_idx < 0)
> +		return it_idx;
> +
> +	for (i = 0; i < ARRAY_SIZE(veml6046x00_it_gains[it_idx]); i++) {
> +		if ((veml6046x00_it_gains[it_idx][i][0] == val) &&
> +		    (veml6046x00_it_gains[it_idx][i][1] == val2)) {
> +			return i;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static int veml6046x00_wait_data_available(struct iio_dev *iio, int usecs)
> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	int ret, reg;
> +	int cnt = 2;
> +	int i;
> +
> +	for (i = 0; i < cnt; i++) {
> +		ret = regmap_read(data->regmap, VEML6046X00_REG_INT_H, &reg);
> +		if (ret) {
> +			dev_err(data->dev,
> +					"Failed to read interrupt register %d\n", ret);
> +			return -EIO;
> +		}
> +
> +		if (reg & VEML6046X00_INT_DRDY)
> +			return 1;

> +		if (i < cnt)

Always true, no?

> +			fsleep(usecs);
> +	}
> +
> +	return 0;
> +}

...

> +	/* integration time + 10 % to ensure completion */
> +	fsleep(it_usec + (it_usec / 10));

Unneeded parentheses.

...

> +	ret = veml6046x00_wait_data_available(iio, it_usec * 10);
> +	if (ret == 1) {
> +		dev_dbg(data->dev, "data ready\n");

> +	} else {

Redundant 'else'.

> +		dev_warn(data->dev, "no data ready ret: %d\n", ret);
> +		goto no_data;
> +	}

...

> +static irqreturn_t veml6046x00_trig_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio = pf->indio_dev;
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	int ret;
> +	struct veml6046x00_scan_buf scan;
> +
> +	memset(&scan, 0, sizeof(scan));
> +
> +	ret = regmap_bulk_read(data->regmap, VEML6046X00_REG_R_L, &scan.chans,
> +						sizeof(scan.chans));

Wrong indentation.

> +	if (ret)
> +		goto done;
> +
> +	iio_push_to_buffers_with_timestamp(iio, &scan, iio_get_time_ns(iio));
> +
> +done:
> +	iio_trigger_notify_done(iio->trig);
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int veml6046x00_validate_part_id(struct veml6046x00_data *data)
> +{
> +	int part_id, ret;
> +	__le16 reg;
> +
> +	ret = regmap_bulk_read(data->regmap, VEML6046X00_REG_ID_L, &reg, sizeof(reg));

Remove _L from the definitions for the registers that you access with bulk IO.

> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Failed to read ID\n");
> +
> +	part_id = le16_to_cpu(reg);
> +	if (part_id != 0x0001)
> +		dev_info(data->dev, "Unknown ID %#02x\n", part_id);
> +
> +	return 0;
> +}

...

> +static int veml6046x00_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct veml6046x00_data *data;
> +	struct iio_dev *iio;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &veml6046x00_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to set regmap\n");

One line.

> +	iio = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	data = iio_priv(iio);
> +	i2c_set_clientdata(i2c, iio);
> +	data->dev = dev;
> +	data->regmap = regmap;
> +
> +	ret = veml6046x00_regfield_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init regfield\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> +
> +	/* bring device in a known state and switch device on */
> +	ret = veml6046x00_setup_device(iio);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, veml6046x00_shutdown_action, data);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add shut down action\n");
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to activate PM runtime\n");
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable PM runtime\n");
> +
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_autosuspend_delay(dev, VEML6046X00_AUTOSUSPEND_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret = veml6046x00_validate_part_id(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to validate device ID\n");
> +
> +	iio->name = "veml6046x00";
> +	iio->channels = veml6046x00_channels;
> +	iio->num_channels = ARRAY_SIZE(veml6046x00_channels);
> +	iio->modes = INDIO_DIRECT_MODE;
> +
> +	iio->info = &veml6046x00_info_no_irq;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, iio, NULL,
> +					      veml6046x00_trig_handler,
> +					      &veml6046x00_buffer_setup_ops);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register triggered buffer");
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register iio device");
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



