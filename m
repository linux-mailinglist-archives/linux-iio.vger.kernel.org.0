Return-Path: <linux-iio+bounces-23697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A709FB434E4
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 10:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEF53A5EF1
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 08:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B66288C34;
	Thu,  4 Sep 2025 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYf4U2jH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC982A1D1;
	Thu,  4 Sep 2025 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972881; cv=none; b=J/8thEOo3x/0nvUYREfZyMlJ3hPZEyUCUlggHZxy89S6DLzZqNPVFXbTjTcqwGnA6IakqdEOmmLR81/dlG8nmrD0P3MW/ZADvTwuo4magkeeq/Yq0OgfInIrahWBnC2OsNMeNHVgozZDnFAd5X7WaiSRxnknfDMz+RMYsVFUx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972881; c=relaxed/simple;
	bh=wlwUBGaf2355vudJz1Ud10sFTnKCAwmGCbZ+bzsJSsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rsc3+JxJaQ8/vVx5RS6sg1yWvxbeFrcC1H2I1beKHQedrJBknZ3kpoRdmjFCvmmBFKEir2i6NQchgqrkP9JcjFw9CwFMusXW5kMHaEPpvUWm6km7D+PScXWN8XRAZj3/eq8SGFE1Jc+TTtj1jt1tclPlhIobGyKLEaOytfAhM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYf4U2jH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756972880; x=1788508880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wlwUBGaf2355vudJz1Ud10sFTnKCAwmGCbZ+bzsJSsc=;
  b=IYf4U2jHrjR4no7VnIJnx6qgrAvGJjr4fo4iS4ueVYR7Tzr3FZ6O5wpK
   Z5du6N8B+Fkeif8ug7iZWnxyj60S00po/7AwxJMOj3i0ST+sqTLIVWQPf
   Fx2W7WaamJGPKxZhiSS6fG//dC+HvL/J8PfBbTFowdst/RkMipNR8Jov9
   w64FzskmLLm+SRj+Fw46T85cxlh2ytIEnTPr1mau4S7AKmwS30+xeSZwe
   VvhQ1F6kY2IMLE4VihWF67SlCCvziwhz+ylMEpx5Qild64zE7HAFn3ZuG
   ZConCTBKpBEZoRv0bewRa5VLLtgqJvfRJgKciSPjrQaxSCn09lIuktCXg
   w==;
X-CSE-ConnectionGUID: h3KR6OkaRbiMBjeaHGPaCg==
X-CSE-MsgGUID: dbpEh5rTSD2cu8VZlLJQ/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="69566907"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="69566907"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 01:01:15 -0700
X-CSE-ConnectionGUID: zDeJhkXMQqeHsg/47czUHA==
X-CSE-MsgGUID: 8PRe9YUuStWQnak1m1x4Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="202669563"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 01:01:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uu4u5-0000000BChH-2WrO;
	Thu, 04 Sep 2025 11:01:09 +0300
Date: Thu, 4 Sep 2025 11:01:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: light: ltr390: Implement runtime PM support
Message-ID: <aLlHRYPC-bPLQe-N@smile.fi.intel.com>
References: <20250903112648.11972-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903112648.11972-1-akshayaj.lkd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 03, 2025 at 04:56:43PM +0530, Akshay Jindal wrote:
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
> +static int ltr390_do_read_raw(struct iio_dev *iio_device,
> +			struct iio_chan_spec const *chan, int *val,
> +			int *val2, long mask)

The new indentation is broken.

static int ltr390_do_read_raw(struct iio_dev *iio_device,
			      struct iio_chan_spec const *chan,
			      int *val, int *val2, long mask)

...

> +static int ltr390_read_raw(struct iio_dev *iio_device,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)

For example here it's okay.

...

> -static int ltr390_write_event_config(struct iio_dev *indio_dev,
> +static int ltr390_do_event_config(struct iio_dev *indio_dev,
>  				const struct iio_chan_spec *chan,
>  				enum iio_event_type type,
>  				enum iio_event_direction dir,

You forgot fixing an indentation of the parameters.

...

> +static int ltr390_write_event_config(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				bool state)

Broken indentation.

...

> +	int ret;
> +	struct ltr390_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +
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
> +	ret = ltr390_do_event_config(indio_dev, chan, type, dir, state);
> +
> +	if (!state && data->irq_enabled) {
> +		data->irq_enabled = false;
> +		pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	return ret;

I think we still can refactor this as following if _do_event_config() does not
have side-effects on irq_enabled field. (Otherwise that side-effect should be
documented.)

// we also assume indio_dev can be retrieved from data
_on_and_do_event_config()
{
	struct device *dev = &data->client->dev;
	int ret;

	ret = pm_runtime_resume_and_get(dev);
	if (ret < 0) {
		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
		return ret;
	}

	data->irq_enabled = true;

	return ltr390_do_event_config(indio_dev, chan, type, dir, state);
}

_do_event_config_and_off()
{
	struct device *dev = &data->client->dev;
	int ret;

	ret = ltr390_do_event_config(indio_dev, chan, type, dir, state);

	data->irq_enabled = false;
	pm_runtime_put_autosuspend(dev);

	return ret;
}

write_event_config()
{
	struct ltr390_data *data = iio_priv(indio_dev);

	guard(mutex)(&data->lock);

	if (state == data->irq_enabled)
		return ltr390_do_event_config(indio_dev, chan, type, dir, state);

	if (state)
		return _on_and_event_config(data, ...)
	else // yes, it's redundant, but for better coupling of these two branches
		return _event_config_and_off(data, ...)

}

But this is quite verbose, hence I leave it to you and others to decide if the
originally proposed code is better.

...

> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)

> +		return dev_err_probe(dev, ret,
> +				     "failed to enable runtime PM\n");

It's exactly one line of 80 characters!

...

> +	/* default value of irq_enabled is false*/

Missing space

> +	data->irq_enabled = false;

-- 
With Best Regards,
Andy Shevchenko



