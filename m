Return-Path: <linux-iio+bounces-10444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B33D99A0E5
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 12:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA5F7B24F10
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 10:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65423212625;
	Fri, 11 Oct 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQ36qftg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91360212622;
	Fri, 11 Oct 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641430; cv=none; b=jukfQHLvlesk/X2gVeC2T+iinPimGhOU8RtYVw72MbSSl4SVb4iqY50anv4DfjERnDKykE5/CnO8N6nXIJQHjy9qxxCtviwyP8nLLJ6Y4kwx+GJqkMRwRQjMB71LBFwrCsTrJdrnEBFv3LvKEjzQPzRUdeRvSm+MM/5sJ5bm2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641430; c=relaxed/simple;
	bh=3RbFEEJnoKS/e7NOWTYtQJLCiaeAfK0OKuMjVXkA7BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaDc4A+1ZBr8f+/UiSSHyHyV+TqC9O4rmOfqdtJ0Ad13C3r9MBgC7cGjgsm5TeETOgXvg5Sm9qFItRYYZ/LBEAePxxC6HvQH/Lrs9x3EzKg8Ylm6FJXdDWbA+WJj3isNyNkHWOPoVXzuTxOq5lYFlCnqdrjs7CXZHbURO1WgFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQ36qftg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728641429; x=1760177429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3RbFEEJnoKS/e7NOWTYtQJLCiaeAfK0OKuMjVXkA7BA=;
  b=bQ36qftgHr048hxsOgCH84b3DZOp66qNpKUYnHTckQ/NFHgk7VA50KSj
   nXEmj6YBHNhNEEzAQpLclVgbtbi5uof6dgDyHUvv6Wtp5NFsboJ1ZRXM4
   5hx9lsjmNAOJ9exKtWwB1XrzaRXMSOEsqPLuNpD4pup+JEz+4PMDaRy5V
   CHM0Zml3mTKEhvUR5a4PM6HZD6EVLDVNbygQ3pkfwVOOKjwdKZgWIniCl
   LiCP5YH2GQMMykbpWbnqlBAyRl/4//RmqxICIiJzfTXiYrUQz62Og1wH/
   qPOfzIuYS6+RSifaW3hmx5A5YYgGAGJERondfjjtQ8iNeXHxfu/Lv1q09
   w==;
X-CSE-ConnectionGUID: J4RJlz2uSHeAY1+WqjmgBQ==
X-CSE-MsgGUID: z9KndGW/SP6A3pWThf9zlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="45547649"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="45547649"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:10:26 -0700
X-CSE-ConnectionGUID: M3WpYnsLRQmDT1wa9hEkBA==
X-CSE-MsgGUID: Lszo2Nq9QNCE6gtktpDaFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="76772806"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:10:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szCbE-00000001qxR-36js;
	Fri, 11 Oct 2024 13:10:20 +0300
Date: Fri, 11 Oct 2024 13:10:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: vamoirid <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/13] iio: chemical: bme680: add power management
Message-ID: <Zwj5jBm-_9_FX6ms@smile.fi.intel.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-9-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010210030.33309-9-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 11:00:25PM +0200, vamoirid wrote:
> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Add runtime power management to the device. To facilitate this, add also
> a struct dev * inside the bme680_data structure to have the device
> accesible from the data structure.

...

> --- a/drivers/iio/chemical/bme680.h
> +++ b/drivers/iio/chemical/bme680.h
> @@ -75,6 +75,7 @@
>  #define BME680_CALIB_RANGE_3_LEN               5
>  
>  extern const struct regmap_config bme680_regmap_config;
> +extern const struct dev_pm_ops bmp280_dev_pm_ops;

Is pm.h being included already in this header? Otherwise you need to add it.

...

>  	struct regmap *regmap;
>  	struct bme680_calib bme680;
>  	struct mutex lock; /* Protect multiple serial R/W ops to device. */
> +	struct device *dev;

Is it the same that you may get wia regmap_get_device()?

>  	u8 oversampling_temp;
>  	u8 oversampling_press;
>  	u8 oversampling_humid;

...

> +	/* Enable runtime PM */
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, BME680_STARTUP_TIME_US * 100);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_put(dev);

Can we use devm_pm_runtime_enable() for some of the above?

> +	ret = devm_add_action_or_reset(dev, bme680_pm_disable, dev);
> +	if (ret)
> +		return ret;

...

> +static int bme680_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bme680_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regulator_bulk_enable(BME680_NUM_SUPPLIES, data->supplies);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(BME680_STARTUP_TIME_US);
> +
> +	ret = bme680_chip_config(data);
> +	if (ret)
> +		return ret;

> +	ret = bme680_gas_config(data);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return bme680_gas_config(...);

> +}

...

> +EXPORT_RUNTIME_DEV_PM_OPS(bme680_dev_pm_ops, bme680_runtime_suspend,
> +			  bme680_runtime_resume, NULL);

You also need pm.h for the macro IIRC.

-- 
With Best Regards,
Andy Shevchenko



