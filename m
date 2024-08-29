Return-Path: <linux-iio+bounces-8877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEF8964520
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FDA28AC32
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943791AE845;
	Thu, 29 Aug 2024 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rmto/kos"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B344C1AD410;
	Thu, 29 Aug 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935244; cv=none; b=UKiAefiExuO1WT0uUIhT5rFKXve9m5o4yszEz/k64J1IEZk0/ifWdKF4lBt7092VDCUrB+T/awF+mcrYlq3STHzgphe/N8PS4N/67Vkbxv0d9l/c6DiSmVusMfsQ+7QQ52q4/AfB6kjiberGvebqou/5+6FNUFra0oADAerBM4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935244; c=relaxed/simple;
	bh=wmAiMv8iFX2iP9iqdAASYAK9Od2cxK6C9fjvHe/Y1hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOG/VtDTfVTFviEb/5Fl/ag/QpRdT/7lhbdu1NQGpC8nrpzjF1et9Vskv6hKTw0ABqWLon+/cQMQk6oa8v2GOe5OWiOM6MSpJXZG0PbuDRKflnDLJm8WwoEX/SPdblAzmUDRECxtqNLcfoZqpSs7lq/dRO9+I5i++06fqXMM3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rmto/kos; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724935243; x=1756471243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wmAiMv8iFX2iP9iqdAASYAK9Od2cxK6C9fjvHe/Y1hg=;
  b=Rmto/kosu2Cf8DLLBDtiLJAe10RObVDH6hGdES4cmRAHHRVpD6zgxHXr
   GlAtl83ZFSi+zVUokwy6cxP41Q2jZZYyyKpAJVI8aDdKqjB1ZUjWKqsZh
   09iYEzQcqPHuPJuYfuRzFX0CHLBeLwbGXXAMVvne74mF4Ny9gOj6Jq1RG
   E7b6MrDDzbgM1Q5xqUKWxZWv0YB85q54nO3bWs8z9JAX5zWGgeRxko27e
   BJWq1Co9JII2Am20JxzziSLuC6T6i/O4ywAbYTUo/2zsSs25w+stUTxiv
   8LOOtqYxbVWPvXSA3kMhnvbCDS8Dxw5O9ugrT7Rq8AWdIOmWtiKNQqUfl
   g==;
X-CSE-ConnectionGUID: uDcfz38WS1Ghwhk5atyJ+w==
X-CSE-MsgGUID: YU1SC9SDRZSP65ofPsydPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23097877"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23097877"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:40:42 -0700
X-CSE-ConnectionGUID: uGnejs3eQe2GpvIOVeqVEw==
X-CSE-MsgGUID: pZm0N95LQ9C+rizzCk9fXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="67707488"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:40:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjeS3-00000002zmk-0hlp;
	Thu, 29 Aug 2024 15:40:35 +0300
Date: Thu, 29 Aug 2024 15:40:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 6/7] iio: pressure: bmp280: Add data ready trigger
 support
Message-ID: <ZtBsQg_JIcY4F-0h@smile.fi.intel.com>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
 <20240828205128.92145-7-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828205128.92145-7-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 28, 2024 at 10:51:26PM +0200, Vasileios Amoiridis wrote:
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

> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-core.c | 231 ++++++++++++++++++++++++++++-
>  drivers/iio/pressure/bmp280.h      |  21 +++
>  2 files changed, 250 insertions(+), 2 deletions(-)

...

> +static int __bmp280_trigger_probe(struct iio_dev *indio_dev,
> +				  const struct iio_trigger_ops *trigger_ops,
> +				  int (*int_config)(struct bmp280_data *data),
> +				  irq_handler_t irq_thread_handler)
> +{
> +	struct bmp280_data *data = iio_priv(indio_dev);

With

	struct device *dev = data->dev;

you may shorten some lines below and collapse a few.

> +	struct fwnode_handle *fwnode;
> +	int ret, irq, irq_type;

Why irq_type is signed?

Also try to make that returned variable is closer to the end of the definition
block. And it might be worth to follow reversed xmas tree order (longer lines
first).

> +	struct irq_data *desc;
> +
> +	irq = fwnode_irq_get(dev_fwnode(data->dev), 0);
> +	if (irq < 0)
> +		return dev_err_probe(data->dev, irq, "No interrupt found.\n");
> +
> +	desc = irq_get_irq_data(irq);
> +	irq_type = irqd_get_trigger_type(desc);

So, altogether it may be written as

	irq_type = irqd_get_trigger_type(irq_get_irq_data(irq));

And looking further, we have a helper for that:
irq_get_trigger_type(). Why not use it?

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
> +
> +	data->trig_open_drain =
> +		fwnode_property_read_bool(fwnode, "int-open-drain");
> +
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
> +		return dev_err_probe(data->dev, ret, "request irq failed.\n");
> +
> +	ret = devm_iio_trigger_register(data->dev, data->trig);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "iio trigger register failed.\n");
> +
> +	indio_dev->trig = iio_trigger_get(data->trig);
> +
> +	return 0;
> +}

...

> +static int bmp380_int_config(struct bmp280_data *data)
> +{
> +	int pin_drive_cfg = FIELD_PREP(BMP380_INT_CTRL_OPEN_DRAIN,
> +				       data->trig_open_drain);
> +	int pin_level_cfg = FIELD_PREP(BMP380_INT_CTRL_LEVEL,
> +				       data->trig_active_high);
> +	int ret, int_cfg = pin_drive_cfg | pin_level_cfg;
> +
> +	ret = regmap_update_bits(data->regmap, BMP380_REG_INT_CONTROL,
> +				 BMP380_INT_CTRL_SETTINGS_MASK, int_cfg);
> +	if (ret) {
> +		dev_err(data->dev, "Could not set interrupt settings\n");

> +		return ret;
> +	}
> +
> +	return ret;

One of them is redundant or the last one should be return 0, but why not just
leave one of them?

> +}

...

> +static int bmp580_int_config(struct bmp280_data *data)
> +{
> +	int ret, int_cfg = FIELD_PREP(BMP580_INT_CONFIG_OPEN_DRAIN,
> +				      data->trig_open_drain) |
> +			   FIELD_PREP(BMP580_INT_CONFIG_LEVEL,
> +				      data->trig_active_high);
> +
> +	ret = regmap_update_bits(data->regmap, BMP580_REG_INT_CONFIG,
> +				 BMP580_INT_CONFIG_MASK, int_cfg);
> +	if (ret) {
> +		dev_err(data->dev, "Could not set interrupt settings\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_set_bits(data->regmap, BMP580_REG_INT_SOURCE,
> +			      BMP580_INT_SOURCE_DRDY);
> +	if (ret) {
> +		dev_err(data->dev, "Could not set interrupt source\n");
> +		return ret;
> +	}
> +
> +	return 0;

So far you have three different styles in the same patch for this!
Choose one and be consistent with it.

> +}

...

> +	int (*trigger_probe)(struct iio_dev *indio_dev);
>  	irqreturn_t (*trigger_handler)(int irq, void *p);

Yeah, at some point this can be changed to

	irq_handler_t trigger_handler;

-- 
With Best Regards,
Andy Shevchenko



