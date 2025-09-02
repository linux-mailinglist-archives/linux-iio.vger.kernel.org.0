Return-Path: <linux-iio+bounces-23638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A54C1B401C8
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 15:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BCB3A9AD1
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 12:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA3B2DAFA1;
	Tue,  2 Sep 2025 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0xL2ga0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BE72D4811;
	Tue,  2 Sep 2025 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817853; cv=none; b=Vi89FQ2FsUDc2SH4KvAuE+6j+goFM5wHkqPzdhltZf4kAX5zylv3OjJx9bBaWWV/iDMyZeAABJJXI3Fs5qACi7J/2Yzde8+VjmYxtH6xDmbyPaaC4I2fP9BM7q4dxgHJFHOfhOOw61mMR9iLTLxz1bRvms0Po9Dh2/u4mgzZesc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817853; c=relaxed/simple;
	bh=Ux70OlBfDVC0AXjbuaeye71og6QPGzazXgM2HPOosLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlvA8CFcIqD/QOPsUVT626I3Tt7V9eCHKZN+ZKVunDO7SH3igIfYcpq7N8z4+ygzzFkNpyBcartgsTprn8VrfiXQxD+2UYbv9KWbIS8fk1ZnJJFiY5KUwbIouLYp3OLsgTzkPegjXJlW+tYouhoyy+Yh4gfRZX1o8SMjrmp+RxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0xL2ga0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756817851; x=1788353851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ux70OlBfDVC0AXjbuaeye71og6QPGzazXgM2HPOosLY=;
  b=g0xL2ga0Q5ej5Wg/8pndNFGOk1Dp+2Bpa/8Wf1bMU38uHxro1klX4p9e
   hZC0keUjDZqCLEVZNgJBc/2Gld2RrRmUcxlPw7lVDafc/jEBMZV+HMidF
   mvZBovtr+2UYUpPeeu4RzCjABgHu6TNoA34tlI0KDcxpDXpaXXAHgd0pe
   g6Prc4E7YVzJMq9ROcgLlX8f7H5qjc14HFzxFjMjPQQ2g6hNdIuTczwVW
   sugodGcTdHttfnhUrKr0dVWrpxtgpl91kkqDaJP9Gr5dghN3+Waa4WA8y
   jg036JlOLW+/6lZLSI2anjm4e21tgzZo4eQOE+AwxGU1lVDorEWn+YS5y
   Q==;
X-CSE-ConnectionGUID: zd7ua96iRQawo1ZL/h8sQw==
X-CSE-MsgGUID: msoN6+l2T8Waq8DsrmmzAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="59026239"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="59026239"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 05:57:30 -0700
X-CSE-ConnectionGUID: 2F68qreySbSGmYPNjfiS1Q==
X-CSE-MsgGUID: P8mmQwg1RpifYb4gruurbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171158072"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 05:57:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utQZg-0000000AhHp-4383;
	Tue, 02 Sep 2025 15:57:24 +0300
Date: Tue, 2 Sep 2025 15:57:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: light: ltr390: Implement runtime PM support
Message-ID: <aLbptFRh9ZvAVfLn@smile.fi.intel.com>
References: <20250901184238.34335-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250901184238.34335-1-akshayaj.lkd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 02, 2025 at 12:12:36AM +0530, Akshay Jindal wrote:
> Implement runtime power management for the LTR390 sensor. The device
> autosuspends after 1s of idle time, reducing current consumption from
> 100 µA in active mode to 1 µA in standby mode as per the datasheet.
> 
> Ensure that interrupts continue to be delivered with runtime PM.
> Since the LTR390 cannot be used as a wakeup source during runtime
> suspend, therefore increment the runtime PM refcount when enabling
> events and decrement it when disabling events or powering down.
> This prevents event loss while still allowing power savings when IRQs
> are unused.

...

> -static int ltr390_read_raw(struct iio_dev *iio_device,
> -			   struct iio_chan_spec const *chan, int *val,
> -			   int *val2, long mask)
> +
> +static int __ltr390_read_raw(struct iio_dev *iio_device,
> +			struct iio_chan_spec const *chan, int *val,
> +			int *val2, long mask)

Can we avoid using leading __ (double underscore)? Better name is
ltr390_read_raw_no_pm(). But you may find even better one.

...

> -static int ltr390_write_event_config(struct iio_dev *indio_dev,
> +static int __ltr390_write_event_config(struct iio_dev *indio_dev,

Ditto.

...

> +static int ltr390_write_event_config(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				bool state)
> +{
> +	int ret;
> +	struct ltr390_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;

^^^ (1) for the reference below.

> +	guard(mutex)(&data->lock);
> +
> +	if (state && !data->irq_enabled) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0) {
> +			dev_err(dev, "runtime PM failed to resume: %d\n", ret);
> +			return ret;
> +		}
> +		data->irq_enabled = true;
> +	}
> +
> +	ret = __ltr390_write_event_config(indio_dev, chan, type, dir, state);
> +
> +	if (!state && data->irq_enabled) {
> +		data->irq_enabled = false;
> +		pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	return ret;
> +}

...

>  	/* Ensure that power off and interrupts are disabled */
> -	if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
> -				LTR390_LS_INT_EN) < 0)
> -		dev_err(&data->client->dev, "failed to disable interrupts\n");
> +	if (data->irq_enabled) {
> +		if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
> +					LTR390_LS_INT_EN) < 0)

Wrong indentation, hard to read line, either one line, or do better. Actually
why not assign it to ret? The above not only simple style issue, but also makes
readability much harder as the semantics of '0' is completely hidden. This style
is discouraged.

> +			dev_err(&data->client->dev,
> +					"failed to disable interrupts\n");

Why not doing (1) here as well and with that

			dev_err(dev, "failed to disable interrupts\n");

besides the fact of wrong indentation.

> +		data->irq_enabled = false;
> +
> +		pm_runtime_put_autosuspend(&data->client->dev);
> +	}

...

> +static int ltr390_pm_init(struct ltr390_data *data)
> +{
> +	int ret;
> +	struct device *dev = &data->client->dev;
> +
> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +					"failed to enable runtime PM\n");

Something wrong with your editor or so, please check and make proper
indentation _everywhere_ (in your changes).

> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> +	pm_runtime_use_autosuspend(dev);
> +	return 0;
> +}

...

> +static int ltr390_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ltr390_data *data = iio_priv(indio_dev);
> +
> +	return regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL,
> +				LTR390_SENSOR_ENABLE);

I would make it one line despite being 87 character long.

> +}
> +
> +static int ltr390_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ltr390_data *data = iio_priv(indio_dev);
> +
> +	return regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
> +				LTR390_SENSOR_ENABLE);

Ditto. (Here it's even shorter)

> +}

-- 
With Best Regards,
Andy Shevchenko



