Return-Path: <linux-iio+bounces-19951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA5FAC4456
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 22:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC793BB4F5
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 20:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3D82147EF;
	Mon, 26 May 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYafQDSF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C84A2D;
	Mon, 26 May 2025 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748290645; cv=none; b=B86kXIyFDNOclMt872fNJp13s/tAhei341pKaD2ULNAGMqiLscI6a8HO0PM0t6FS1aDehPQmyLvNOGrUVQYxuYX2lO/dyGILc9SdMKOn2r3amp8ZYs2jePA7NfDSKuJKKFl+BqRmS2QHTE9/z5EwU1WyOPS2+xfsaGr6SRTFZjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748290645; c=relaxed/simple;
	bh=asyUI+XBAjTTn5aIz570w+CLhYVZDDjXtNaTiCjJ1PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E//x8hBQQvRxFh4t/DYst4DBN6JFnbhTs6GnSf4IwinfsoRx5vg2DvD7JnPvijLxwvw3fvfmNLw526ndB4mKQAa7Tx21eBEC9MwPjBqZMFgKy/9iZYOK/W+ZyHxWr/yN6LjM5w2es5kQvmaNowboQpB9yQkdzl4fZPrbfNQcHL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYafQDSF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748290643; x=1779826643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=asyUI+XBAjTTn5aIz570w+CLhYVZDDjXtNaTiCjJ1PE=;
  b=mYafQDSFCbVbmUdwiWmGnD8bqMPY/t5cJXyXvUjxlxHqV22eKrQjuNDT
   qORyuVlcClHGAtFqnNrwDh6xHN1Vzz0aIappwFCXGdtk/9L3AdQplnZgR
   Y0quw15VNxpN9HW0+NhWyUgpYHLmpI6vi+KPPaTJdPeCOZuX7nJG/kVFi
   xtQO8XrsiM90Ntc7S+BnbSRwY95eD58Tke1WU/3ShjwImPX/+SOeeLYWY
   RapceQtEl+az0j90wxgpoufqlLL90gbLJvMxfM3B/KlNwLRMBNvutMKgQ
   hJQXiPV/XzAMUOMrdvbaVXuThe+94y03qqjCrIxN7xQSBnxL4OEsC2pVw
   Q==;
X-CSE-ConnectionGUID: q+GFVgBPRTO/j2oeyXi5NA==
X-CSE-MsgGUID: JtCzTA68RMqnAQtrtPvXaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50426738"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="50426738"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 13:17:23 -0700
X-CSE-ConnectionGUID: FoyiOD5fT1mi3PlP5Mmjwg==
X-CSE-MsgGUID: OmxTiagrRPuJnDgjcW2WOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="173390243"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 13:17:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uJeG4-00000000yX0-15mK;
	Mon, 26 May 2025 23:17:16 +0300
Date: Mon, 26 May 2025 23:17:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andreas Klinger <ak@it-klinger.de>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lars@metafoo.de,
	javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
	arthur.becker@sentec.com, perdaniel.olsson@axis.com,
	mgonellabolduc@dimonoff.com, muditsharma.info@gmail.com,
	clamor95@gmail.com, emil.gedenryd@axis.com,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <aDTMSwhodZQLzZ4q@smile.fi.intel.com>
References: <20250526085041.9197-1-ak@it-klinger.de>
 <20250526085041.9197-3-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526085041.9197-3-ak@it-klinger.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 26, 2025 at 10:50:40AM +0200, Andreas Klinger wrote:
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

+ array_size.h

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>

+ dev_printk.h
+ err.h

> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>

You also want mod_devicetable.h.

> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +#include <linux/units.h>

+ blank line

+ asm/byteorder.h

...

> +#define VEML6046X00_REG_DATA(ch)    (VEML6046X00_REG_R_L + (ch))

Dead code / leftover. Even if you want to keep it for documentation purposes
it's not fine as it uses undefined constant.

...

> +/**
> + * struct veml6046x00_data - Private data of driver.
> + * @regmap:	Regmap definition of sensor.
> + * @trig:	Industrial-IO trigger.
> + * @rf:		Regmap field of configuration.
> + */
> +struct veml6046x00_data {
> +	struct regmap *regmap;
> +	struct iio_trigger *trig;
> +	struct veml6046x00_rf rf;

Does pahole agree on the choice of the layout?

> +};

...

> +/**
> + * struct veml6046x00_gain_pd - Translation of gain and photodiode size (PD).
> + * @gain_sen:	Gain used in the sensor as described in the datasheet of the
> + *		sensor
> + * @pd:		Photodiode size in the sensor
> + *
> + * This is the translation table from the gain used in the driver (and also used
> + * by the userspace interface in sysfs) to the gain and PD used in the sensor
> + * hardware.
> + *
> + * There are six gain values visible to the user (0.25 .. 2) which translate to
> + * two different gains in the sensor hardware (x0.5 .. x2) and two PD (1/2 and
> + * 2/2). Theoretical are there eight combinations, but gain values 0.5 and 1 are
> + * doubled and therefore the combination with the larger PD (2/2) is taken as
> + * more photodiode cells are supposed to deliver a more precise result.
> + */
> +struct veml6046x00_gain_pd {
> +	int gain_sen;
> +	int pd;

Why are they signed? I haven't found justification in the above description
(did I missed it?).

> +};

...

> +static int veml6046x00_get_gain_idx(struct veml6046x00_data *data)
> +{
> +	int ret, i;

Why is 'i' signed? Same to other similar cases (more than 1).

> +	unsigned int reg, reg_gain, reg_pd;
> +
> +	ret = regmap_read(data->regmap, VEML6046X00_REG_CONF1, &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg_gain = FIELD_GET(VEML6046X00_CONF1_GAIN, reg);
> +	reg_pd = reg & VEML6046X00_CONF1_PD_D2;
> +
> +	for (i = 0; i < ARRAY_SIZE(veml6046x00_gain_pd); i++) {
> +		if ((veml6046x00_gain_pd[i].gain_sen == reg_gain) &&
> +		    (veml6046x00_gain_pd[i].pd == reg_pd)) {
> +			return i;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static int veml6046x00_wait_data_available(struct iio_dev *iio, int usecs)

Can usecs be negative? What would be the meaning?

> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret, i, cnt = 2;
> +	u8 reg[2];
> +
> +	for (i = 0; i < cnt; i++) {
> +		/*
> +		 * Note from the vendor, but not explicitly in the datasheet: we
> +		 * should always read both registers together

Missing period at the end.

> +		 */
> +		ret = regmap_bulk_read(data->regmap, VEML6046X00_REG_INT,
> +				       &reg, sizeof(reg));
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed to read interrupt register %d\n", ret);
> +			return -EIO;
> +		}
> +
> +		if (reg[1] & VEML6046X00_INT_DRDY)
> +			return 1;

> +		if (i < (cnt - 1))
> +			fsleep(usecs);

This for-loop for cnt=2 seems an overkill. Why not to have a helper and call it twice?

	call_helper();
	fsleep();
	call_helper();

?

> +	}
> +
> +	return 0;
> +}

...

> +	ret = veml6046x00_wait_data_available(iio, it_usec * 4);
> +	if (ret < 0)
> +		return ret;

> +	else if (ret == 0)

Redundant 'else'

> +		return -EAGAIN;

...

> +	ret = regmap_field_write(data->rf.trig, 0);
> +	if (ret) {
> +		dev_err(dev, "Failed to set trigger %d\n", ret);
> +		return ret;
> +	}

> +	return pm_runtime_resume_and_get(dev);

Shouldn't you unroll the above settings somehow? If it's okay, perhaps a
comment here?

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

Can be made one line.

> +	iio = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	data = iio_priv(iio);

> +	i2c_set_clientdata(i2c, iio);

Hmm... I do not see how it's being used. Can you elaborate?

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



