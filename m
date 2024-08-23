Return-Path: <linux-iio+bounces-8739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F085A95D757
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 22:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771BF1F249E0
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDC619343C;
	Fri, 23 Aug 2024 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJ9Nbr7P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C5928DB3;
	Fri, 23 Aug 2024 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443597; cv=none; b=XhCwqpESlxW3tRNXJTZKIBGh/nW/KLVNI0A8kiJ0RuAf4aS+kw+5j9plZyJmXxgivS7C1pFvqmMy366Pzp4l26MyvMYUnKMzCzSI3T6FJSVbr1AZByynaM/zYhm+Iv8pgsVoLkI+scBlqoiS7OfM/B39DAG3qZSQ+LPWoVbPnLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443597; c=relaxed/simple;
	bh=0N/+OdRHwVHJ7GU6QpL4pavaIk5xnOqO0iuEgGvneG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZS/WBxjvBLC/LrvKRU3Ja+9Zj7Fe8NAP9dutCM5EqZ+D4AcT1B1RxdxT/eMNfUq+ACGTbsAWUq/jLFz00mJETTRH5tXv7x2MEkrY219w29L0jgrGVdWlpRqfCXEJ6zrxyCy27lXgG1NKRx9x8hsT7N2mokm6CjM1x4QOyyxvm1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJ9Nbr7P; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724443595; x=1755979595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0N/+OdRHwVHJ7GU6QpL4pavaIk5xnOqO0iuEgGvneG0=;
  b=FJ9Nbr7PqzyadimGHe1GuzgQXEztQM1DIQjgj5d7Pe3CQPAT1wcosPDV
   NCSWagO0BHdAzL7nMQQQxTGHDMQUpPDgbxb07S71J6vC6chRcsYmKZmdU
   Ko6qTwI0AnruAbUtcQEPe1S489VBMusbqmXBe0JuiZ/3yU3TUJmchfJ0e
   f6b5sTmOvFm5Ovu9Kl3cwh1TJe8aZojEMn9JiDZQgG3FhkLufi2d+7QRN
   3oHlhvdHTuY55VJB9T3xd71ARbteLyJjasooAJ9urOVZOi5yb+yxFjZsf
   0mNcEwQLdUhdbeLUpBp8/YfnWOP/GHFP0orkFovOG8iX9rzFVQfNnO9DD
   g==;
X-CSE-ConnectionGUID: 7XLLarPsSxCs9PsGwHELpQ==
X-CSE-MsgGUID: FQHaVp4xTouCCkXH1QmvEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="26728426"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="26728426"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 13:06:35 -0700
X-CSE-ConnectionGUID: ThwlKMkJRkePyuFIHj14Mg==
X-CSE-MsgGUID: OBMFCpiQST+XLzXTnXp1Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="92692956"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 13:06:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1shaYG-000000011A9-2WxM;
	Fri, 23 Aug 2024 23:06:28 +0300
Date: Fri, 23 Aug 2024 23:06:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <ZsjrxLlhmx-TzwXF@smile.fi.intel.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-7-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823181714.64545-7-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 23, 2024 at 08:17:13PM +0200, Vasileios Amoiridis wrote:
> The BMP3xx and BMP5xx sensors have an interrupt pin which can be used as
> a trigger for when there are data ready in the sensor for pick up.
> 
> This use case is used along with NORMAL_MODE in the sensor, which allows
> the sensor to do consecutive measurements depending on the ODR rate value.
> 
> The trigger pin can be configured to be open-drain or push-pull and either
> rising or falling edge.
> 
> No support is added yet for interrupts for FIFO, WATERMARK and out of range
> values.

...

> +static int __bmp280_trigger_probe(struct iio_dev *indio_dev,
> +				  const struct iio_trigger_ops *trigger_ops,
> +				  int (*int_config)(struct bmp280_data *data),

> +				  irqreturn_t (*irq_thread_handler)(int irq, void *p))

irq_handler_t

...

> +	fwnode = dev_fwnode(data->dev);
> +	if (!fwnode)
> +		return -ENODEV;

Why do you need this? The below will fail anyway.

> +	irq = fwnode_irq_get(fwnode, 0);
> +	if (!irq)

Are you sure this is correct check?

> +		return dev_err_probe(data->dev, -ENODEV,

Shadowed error code.

> +				     "No interrupt found.\n");

> +	desc = irq_get_irq_data(irq);
> +	if (!desc)
> +		return -EINVAL;

When may this fail?

> +	irq_type = irqd_get_trigger_type(desc);
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_RISING:
> +		data->trig_active_high = true;
> +		break;
> +	case IRQF_TRIGGER_FALLING:
> +		data->trig_active_high = false;
> +		break;
> +	default:
> +		return dev_err_probe(data->dev, -EINVAL,
> +				     "Invalid interrupt type specified.\n");
> +	}

> +	data->trig_open_drain = fwnode_property_read_bool(fwnode,
> +							  "int-open-drain");

Better

	data->trig_open_drain =
		fwnode_property_read_bool(fwnode, "int-open-drain");

...

> +static int bmp380_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +					     bool state)
> +{
> +	struct bmp280_data *data = iio_trigger_get_drvdata(trig);
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = regmap_update_bits(data->regmap, BMP380_REG_INT_CONTROL,
> +				 BMP380_INT_CTRL_DRDY_EN,
> +				 FIELD_PREP(BMP380_INT_CTRL_DRDY_EN,
> +					    state ? 1 : 0));

				 FIELD_PREP(BMP380_INT_CTRL_DRDY_EN, !!state));

? ( Even <= 80 characters)

> +	if (ret) {
> +		dev_err(data->dev, "Could not enable/disable interrupt\n");
> +		return ret;
> +	}
> +
> +	return 0;

	if (ret)
		dev_err(data->dev, "Could not enable/disable interrupt\n");

	return ret;

?

> +}

...

> +static int bmp380_int_config(struct bmp280_data *data)
> +{
> +	int ret, int_cfg = FIELD_PREP(BMP380_INT_CTRL_OPEN_DRAIN,
> +				      data->trig_open_drain) |
> +			   FIELD_PREP(BMP380_INT_CTRL_LEVEL,
> +				      data->trig_active_high);

Split these two variables and make the indentation better for int_cfg.

> +	ret = regmap_update_bits(data->regmap, BMP380_REG_INT_CONTROL,
> +				 BMP380_INT_CTRL_SETTINGS_MASK, int_cfg);
> +	if (ret) {
> +		dev_err(data->dev, "Could not set interrupt settings\n");

> +		return ret;
> +	}
> +
> +	return 0;

	return ret;

?

> +}

...

> +static int bmp580_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +					     bool state)
> +{
> +	struct bmp280_data *data = iio_trigger_get_drvdata(trig);
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = regmap_update_bits(data->regmap, BMP580_REG_INT_CONFIG,
> +				 BMP580_INT_CONFIG_INT_EN,

> +				 FIELD_PREP(BMP580_INT_CONFIG_INT_EN,
> +					    state ? 1 : 0));

!!state ?

> +	if (ret) {
> +		dev_err(data->dev, "Could not enable/disable interrupt\n");
> +		return ret;
> +	}
> +
> +	return 0;

	return ret;

?

> +}

...

> +static int bmp580_int_config(struct bmp280_data *data)

Same comments as per above.

...

> +	if (irq > 0) {
> +		if (chip_id == BMP180_CHIP_ID) {
> +			ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
> +			if (ret)
> +				return ret;
> +		}
> +		if (data->chip_info->trigger_probe) {
> +			ret = data->chip_info->trigger_probe(indio_dev);
> +			if (ret)
> +				return ret;
> +		}
>  	}

Can be

	if (irq > 0) {
		if (chip_id == BMP180_CHIP_ID)
			ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
		if (data->chip_info->trigger_probe)
			ret = data->chip_info->trigger_probe(indio_dev);
		if (ret)
			return ret;
	}

-- 
With Best Regards,
Andy Shevchenko



