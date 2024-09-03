Return-Path: <linux-iio+bounces-9076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 254CB96A0C7
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 16:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A812B2643E
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8C913CF8E;
	Tue,  3 Sep 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="as3ak4Ua"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8CA1CA69B;
	Tue,  3 Sep 2024 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374183; cv=none; b=CErmFC4NOGzfUjfawEWPXEIqS6foxIf4S8jjRE/2awBfmGIKsil1Tefocaqv1Lzs0RCKUdMJc6ttkryet4YK4alIyAgE02PxnFFmaX2MVS5VlFfBJA+Y/FCFwaUP5T/I7oBcD41o3CDYmydxz7QD3QsaxIG1T1ahlPJuOrTYb5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374183; c=relaxed/simple;
	bh=L3d++NF7GGQmjzBQ/nJ21+8BA6gNGXIquAP/O/uoey4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD2X1zGfmifo4rmZcg0GEB6z08qXqyxUbvTb3Lz07/gecB6ZPj8JVLylajNFPcVwroH4tZnsblABcAUQKiH+TZn3v0UTn/417cgZbBVzSL+ozga1WLTkKTkeRVTdK2Y/qFZqLIZ8m1Co1vy2rJSURHo5WUR7z7tI2afoNqgY7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=as3ak4Ua; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725374183; x=1756910183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L3d++NF7GGQmjzBQ/nJ21+8BA6gNGXIquAP/O/uoey4=;
  b=as3ak4UatUU0Sw1hMCF3dDXOHo7bMJrQBMF4Kjg+WUANv3pOVnXc41GZ
   ozb039GVHNL8VYUhny4NX6etOaT0PxPixH437nD4CGgevCEGisSbJfEmV
   AYm3/DKIDMQOmBYwrPMotzYqVAVFrymmC/2c6xygPqRVGwGaadyQsEfV2
   MYPlGI1zwqMkZzPfvjKsRO3eugqs91thK37P7nIasV6M5JfsaIXz6gS8q
   T96oshs+gkbloxah88pe7dVNwgAGm6VfBVj/EPSbcy84exCSN88O70bz7
   XcvuyGm1wHRd9z9rzQxk64YfPLgMu3ASLKCmtxbY8d9b1Sr1Buzjc5GwJ
   w==;
X-CSE-ConnectionGUID: XoY1pK66TNSHUAVtE+Ijsg==
X-CSE-MsgGUID: e7Ftzcq7TgqeLXOehMcRvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="46503276"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="46503276"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:36:22 -0700
X-CSE-ConnectionGUID: C6pkwfu/Rsa8jOseirDcmA==
X-CSE-MsgGUID: /x162Ds3SfKmtavCPRkXgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="69791485"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:36:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slUdi-00000004jnj-0SQs;
	Tue, 03 Sep 2024 17:36:14 +0300
Date: Tue, 3 Sep 2024 17:36:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 6/7] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <Ztce3XuXZ-hxwU8h@smile.fi.intel.com>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
 <20240902184222.24874-7-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902184222.24874-7-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 02, 2024 at 08:42:21PM +0200, Vasileios Amoiridis wrote:
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
> +				  irq_handler_t irq_thread_handler)

Would it make sense (note, I do *not* know the correct answer!) to have
something like

struct foo {
	const struct iio_trigger_ops *trigger_ops;
	int (*int_config)(struct bmp280_data *data);
	irq_handler_t irq_thread_handler;
};

and pass it around?

Also int_config sounds non-related to interrupt, however it's about interrupt
pin, right? perhaps name it differently here?

E.g.,

	interrupt_pin_config

?

> +{
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +	struct device *dev = data->dev;
> +	struct fwnode_handle *fwnode;
> +	u32 irq_type;
> +	int ret, irq;
> +
> +	irq = fwnode_irq_get(dev_fwnode(dev), 0);
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "No interrupt found.\n");
> +
> +	irq_type = irq_get_trigger_type(irq);
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_RISING:
> +		data->trig_active_high = true;
> +		break;
> +	case IRQF_TRIGGER_FALLING:
> +		data->trig_active_high = false;
> +		break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL, "Invalid interrupt type specified.\n");
> +	}
> +
> +	data->trig_open_drain =
> +		fwnode_property_read_bool(fwnode, "int-open-drain");


Where do you initialise fwnode?

> +	ret = int_config(data);
> +	if (ret)
> +		return ret;
> +
> +	data->trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
> +					    indio_dev->name,
> +					    iio_device_id(indio_dev));
> +	if (!data->trig)
> +		return -ENOMEM;
> +
> +	data->trig->ops = trigger_ops;
> +	iio_trigger_set_drvdata(data->trig, data);
> +
> +	ret = devm_request_threaded_irq(data->dev, irq, NULL,
> +					irq_thread_handler, IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "request irq failed.\n");

IRQ

> +	ret = devm_iio_trigger_register(data->dev, data->trig);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "iio trigger register failed.\n");
> +
> +	indio_dev->trig = iio_trigger_get(data->trig);
> +
> +	return 0;
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
> +				 FIELD_PREP(BMP580_INT_CONFIG_INT_EN, !!state));
> +	if (ret)
> +		dev_err(data->dev,
> +			"Could not %s interrupt.\n", str_enable_disable(state));
> +	return ret;

Somewhere above (or in another patch) you used the style with 'return 0;' at
the end. Please, check the resulting code for the consistency and choose one
style for all.

> +}

-- 
With Best Regards,
Andy Shevchenko



