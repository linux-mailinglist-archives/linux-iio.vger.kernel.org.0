Return-Path: <linux-iio+bounces-26416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AA4C7FEA4
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 11:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3986341627
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCAF2517AA;
	Mon, 24 Nov 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYgLdkmC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16C81D555;
	Mon, 24 Nov 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980401; cv=none; b=s2slUH2fEqDliR/7LN8dZwspI+TuVYdAv++HRIUJiwbmBYJ9DLtxcq3EjJRgE6oN/QX2MXpeXFKGgjd8YcWFrNvcjqJ6kPFwqD2L94whKcomBsDesAhWS99eIoOJQUYLlxjANGCnmi5amtwlCGMdka8vwJokU6tZac96uX+o9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980401; c=relaxed/simple;
	bh=HNVb1N1/RPjWqxX1WO4WpghVU8NPAOP2ZybpahlmGFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVtWNv31mWDgtffcGbVAjA11F72mpBKzlCuKSfrwsaYM1+Yp3vaE9sSN1DnVhL8/Rmv+pAtx8+2KMN41EctZEI/4THP1XaNpvi6WaFxmQGW5/c3S1ujWxEI25WovBfCKfqgXT/MrpNENY+QGJexxXUboRiDsnZVLF/1nKxlD9TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYgLdkmC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763980400; x=1795516400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HNVb1N1/RPjWqxX1WO4WpghVU8NPAOP2ZybpahlmGFI=;
  b=LYgLdkmCp+C7tgT/NQDNFiJXwYtzm4O3SSBqaMlVfB7uMq9GCwO1X9VS
   RkTm2ywKb8HayuPjt26fLj7mDtHed5VDP3LX/KH83GSghIyDOkqetvV/A
   ZLZl6yHgCSKPLayYPrDOCfwTxRG+mJ0YWyprsHegsIrONnMLkB/XK4Xkw
   IpJJBq5XmG+N8LRdJZK/7fl7yQmvOOnotjfLtnWOaMsu+EsoIFqmVVmmy
   kIMcBfaHDLi7XO7Zps+4Fg/mHH9axuTOnoaUsZlz1B3JGdJoB5kOTwsE0
   Q+bBBOP9SyiKU5nqnH8eEE8uAy4dGhXePA1B4LE3PCAb/5CpeEGl7gSCJ
   g==;
X-CSE-ConnectionGUID: tHGKGyNkSsaLKR2cdC51JQ==
X-CSE-MsgGUID: 3V5QjeRVSBG8YpYgGyiDLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="83590567"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="83590567"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 02:33:19 -0800
X-CSE-ConnectionGUID: 9WyeEq98S/mqJJOFd4PHPA==
X-CSE-MsgGUID: MbV6DTrPQrWPF0mx8AuiAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="196468300"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 02:33:15 -0800
Date: Mon, 24 Nov 2025 12:33:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 7/9] iio: adc: ad4062: Add IIO Events support
Message-ID: <aSQ0aM2u49qzIZDm@smile.fi.intel.com>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-7-a375609afbb7@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-staging-ad4062-v2-7-a375609afbb7@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 24, 2025 at 10:18:06AM +0100, Jorge Marques wrote:
> Adds support for IIO Events. Optionally, gp0 is assigned as Threshold
> Either signal, if not present, fallback to an I3C IBI with the same
> role.

...

> +static ssize_t ad4062_events_frequency_store(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ad4062_state *st = iio_priv(indio_dev);
> +	int val, ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +	if (st->wait_event) {
> +		ret = -EBUSY;
> +		goto out_release;
> +	}
> +
> +	ret = kstrtoint(buf, 10, &val);
> +	if (ret < 0)
> +		goto out_release;
> +
> +	st->events_frequency = find_closest_descending(val, ad4062_conversion_freqs,
> +						       ARRAY_SIZE(ad4062_conversion_freqs));
> +	ret = 0;
> +
> +out_release:
> +	iio_device_release_direct(indio_dev);
> +	return ret ? ret : len;

	return ret ?: len;

> +}

...

> +static IIO_DEVICE_ATTR(sampling_frequency, 0644, ad4062_events_frequency_show,
> +		       ad4062_events_frequency_store, 0);

IIO_DEVICE_ATTR_RW()

...

>  {
>  	struct ad4062_state *st = i3cdev_get_drvdata(i3cdev);
>  
> -	if (iio_buffer_enabled(st->indio_dev))
> -		iio_trigger_poll_nested(st->trigger);
> -	else
> -		complete(&st->completion);
> +	if (st->wait_event) {
> +		iio_push_event(st->indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_EITHER),
> +			       iio_get_time_ns(st->indio_dev));
> +	} else {
> +		if (iio_buffer_enabled(st->indio_dev))
> +			iio_trigger_poll_nested(st->trigger);
> +		else
> +			complete(&st->completion);
> +	}

Less ping-pong:ish if you simply add a new code.

	if (st->wait_event) {
		iio_push_event(st->indio_dev,
			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
						    IIO_EV_TYPE_THRESH,
						    IIO_EV_DIR_EITHER),
			       iio_get_time_ns(st->indio_dev));

		return;
	}

>  }

...

> +static int ad4062_monitor_mode_enable(struct ad4062_state *st, bool enable)
> +{
> +	int ret = 0;

Unneeded assignment.

> +	if (!enable) {
> +		pm_runtime_put_autosuspend(&st->i3cdev->dev);
> +		return 0;
> +	}

Just split to two functions and drop parameter 'enable',

> +	ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
> +	ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4062_conversion_frequency_set(st, st->events_frequency);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4062_set_operation_mode(st, AD4062_MONITOR_MODE);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_get_noresume(&st->i3cdev->dev);
> +	return 0;
> +}

...

> +static int ad4062_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     bool state)
> +{
> +	struct ad4062_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +	if (st->wait_event == state) {
> +		ret = 0;
> +		goto out_release;
> +	}
> +
> +	ret = ad4062_monitor_mode_enable(st, state);
> +	if (!ret)
> +		st->wait_event = state;

Please use regular patter to check for errors first.

	if (st->wait_event == state)
		ret = 0;
	else
		ret = ad4062_monitor_mode_enable(st, state);
	if (ret)
		goto out_release;

	st->wait_event = state;

Always think about readability first and then about size of the source code.

> +out_release:
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +}

...

> +static int ad4062_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info, int *val,
> +				   int *val2)
> +{
> +	struct ad4062_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +	if (st->wait_event) {
> +		ret = -EBUSY;
> +		goto out_release;
> +	}
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		ret = __ad4062_read_event_info_value(st, dir, val);
> +		break;
> +	case IIO_EV_INFO_HYSTERESIS:
> +		ret = __ad4062_read_event_info_hysteresis(st, dir, val);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +out_release:
> +	iio_device_release_direct(indio_dev);
> +	return ret ? ret : IIO_VAL_INT;

	return ret ?: IIO_VAL_INT;

> +}

...

> +static int __ad4062_write_event_info_value(struct ad4062_state *st,
> +					   enum iio_event_direction dir, int val)
> +{
> +	u8 reg;
> +
> +	if (val > 2047 || val < -2048)
> +		return -EINVAL;

There was already magic '11', perhaps define it and use there and here?

#define x11	11 // needs a good name

	if (val > BIT(x11) || val < -BIT(x11))

> +	if (dir == IIO_EV_DIR_RISING)
> +		reg = AD4062_REG_MAX_LIMIT;
> +	else
> +		reg = AD4062_REG_MIN_LIMIT;
> +	put_unaligned_be16(val, st->buf.bytes);
> +
> +	return regmap_bulk_write(st->regmap, reg, &st->buf.be16,
> +				 sizeof(st->buf.be16));
> +}

-- 
With Best Regards,
Andy Shevchenko



