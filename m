Return-Path: <linux-iio+bounces-18331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70263A94435
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 17:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B88216E678
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 15:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607791C2DB2;
	Sat, 19 Apr 2025 15:39:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE11BE4E;
	Sat, 19 Apr 2025 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745077162; cv=none; b=eVQzleIg+p3qBY8t4x1MkLUxPLfK8/acnY+JbR66EdqpThZRR03S0NeVmbevTJPSaJesCbiFx9klvfKBs739c0W2NDfPc9QKQ8dNOqxJM4FZioHoZnRA7cg2oChRL5qbakhgfFUFWre39ejwMpbSJL1ivgW4YtSNVV/rMj9wGrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745077162; c=relaxed/simple;
	bh=KJwC/q34WQ1vVn3FqzfPmsnC1UiX1DRtv3w74U3sF38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBuWWI295sR7relKE/TAw9NW8XW64QpTUimSp+h59t/j3HhjGhwZb1spKuk+t2qbfEFAK6eU163s1viY3PRDIA+99mhLqz7ll46D94OFZF/kTTq1vOxzRorLvhljCX7ASaIPnv/E4qUQnqD9ljPiO8+THZQhN3sc5RSNuXUH6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: ZtV6g4ZeSJK6Vx+kE+d8kw==
X-CSE-MsgGUID: VXtycfjEQFOCIyuisC2jSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="46807087"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="46807087"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 08:39:20 -0700
X-CSE-ConnectionGUID: mJinMyU7QSKkPKdJZu9csw==
X-CSE-MsgGUID: s6yPo9JDRFyuV/ylYCA+UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="154518124"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 08:39:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u6AHj-0000000Dqz1-1I9a;
	Sat, 19 Apr 2025 18:39:15 +0300
Date: Sat, 19 Apr 2025 18:39:14 +0300
From: Andy Shevchenko <andy@kernel.org>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: imu: inv_icm42600: add WoM support
Message-ID: <aAPDovuee7hoY1PS@smile.fi.intel.com>
References: <20250418-losd-3-inv-icm42600-add-wom-support-v3-0-7a180af02bfe@tdk.com>
 <20250418-losd-3-inv-icm42600-add-wom-support-v3-1-7a180af02bfe@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250418-losd-3-inv-icm42600-add-wom-support-v3-1-7a180af02bfe@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 18, 2025 at 06:19:02PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add WoM as accel roc rising x|y|z event.

...

> +static unsigned int inv_icm42600_accel_convert_roc_to_wom(uint64_t roc,
> +							  int accel_hz, int accel_uhz)
> +{
> +	/* 1000/256mg per LSB converted in µm/s² */
> +	const unsigned int convert = (1000U * 9807U) / 256U;

Wondering if KILO (or MILLI?) is a good suit here...

> +	uint64_t value;
> +	uint64_t freq_uhz;
> +
> +	/* return 0 only if roc is 0 */
> +	if (roc == 0)
> +		return 0;
> +
> +	freq_uhz = (uint64_t)accel_hz * MICRO + (uint64_t)accel_uhz;
> +	value = div64_u64(roc * MICRO, freq_uhz * (uint64_t)convert);
> +
> +	/* limit value to 8 bits and prevent 0 */
> +	return clamp(value, 1, 255);
> +}
> +
> +static uint64_t inv_icm42600_accel_convert_wom_to_roc(unsigned int threshold,
> +						      int accel_hz, int accel_uhz)
> +{
> +	/* 1000/256mg per LSB converted in µm/s² */
> +	const unsigned int convert = (1000U * 9807U) / 256U;

Ditto.

> +	uint64_t value;
> +	uint64_t freq_uhz;
> +
> +	value = threshold * convert;
> +	freq_uhz = (uint64_t)accel_hz * MICRO + (uint64_t)accel_uhz;
> +
> +	/* compute the differential by multiplying by the frequency */
> +	return div_u64(value * freq_uhz, MICRO);
> +}

...

> +static int inv_icm42600_accel_disable_wom(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *pdev = regmap_get_device(st->map);
> +	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
> +	unsigned int sleep_ms = 0;
> +	int ret;
> +
> +	scoped_guard(mutex, &st->lock) {

> +		st->apex.wom.enable = false;
> +		st->apex.on--;

Hmm... Even if the below fails we consider it successful? Why?

> +		ret = inv_icm42600_disable_wom(st);
> +		if (ret)
> +			break;
> +		/* turn off accel sensor if not used */
> +		if (!st->apex.on && !iio_buffer_enabled(indio_dev)) {
> +			conf.mode = INV_ICM42600_SENSOR_MODE_OFF;
> +			ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_ms);
> +			if (ret)
> +				break;
> +		}
> +	}
> +
> +	if (sleep_ms)
> +		msleep(sleep_ms);
> +	pm_runtime_mark_last_busy(pdev);
> +	pm_runtime_put_autosuspend(pdev);
> +
> +	return ret;
> +}

...

> +static int inv_icm42600_accel_read_event_config(struct iio_dev *indio_dev,
> +						const struct iio_chan_spec *chan,
> +						enum iio_event_type type,
> +						enum iio_event_direction dir)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* handle WoM (roc rising) event */
> +	if (type == IIO_EV_TYPE_ROC && dir == IIO_EV_DIR_RISING)
> +		return st->apex.wom.enable ? 1 : 0;

Invert conditional as below?

> +	return -EINVAL;
> +}
> +
> +static int inv_icm42600_accel_write_event_config(struct iio_dev *indio_dev,
> +						 const struct iio_chan_spec *chan,
> +						 enum iio_event_type type,
> +						 enum iio_event_direction dir,
> +						 bool state)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +
> +	/* handle only WoM (roc rising) event */
> +	if (type != IIO_EV_TYPE_ROC || dir != IIO_EV_DIR_RISING)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &st->lock) {
> +		if (st->apex.wom.enable == state)
> +			return 0;
> +	}
> +
> +	if (state)
> +		return inv_icm42600_accel_enable_wom(indio_dev);
> +	else
> +		return inv_icm42600_accel_disable_wom(indio_dev);
> +}

...

> +static int inv_icm42600_accel_write_event_value(struct iio_dev *indio_dev,
> +						const struct iio_chan_spec *chan,
> +						enum iio_event_type type,
> +						enum iio_event_direction dir,
> +						enum iio_event_info info,
> +						int val, int val2)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	uint64_t value;
> +	unsigned int accel_hz, accel_uhz;
> +	int ret;
> +
> +	/* handle only WoM (roc rising) event value */
> +	if (type != IIO_EV_TYPE_ROC || dir != IIO_EV_DIR_RISING || val < 0 || val2 < 0)
> +		return -EINVAL;

Hmm... I think that splitting this will be logically better, as we see the
type/dir conditionals in many functions, and values checks only
exceptionally.

	if (type != IIO_EV_TYPE_ROC || dir != IIO_EV_DIR_RISING)
		return -EINVAL;

	if (val < 0 || val2 < 0)
		return -EINVAL;

> +	value = (uint64_t)val * MICRO + (uint64_t)val2;
> +	pm_runtime_get_sync(dev);
> +	scoped_guard(mutex, &st->lock) {
> +		ret = inv_icm42600_accel_read_odr(st, &accel_hz, &accel_uhz);
> +		if (ret >= 0)
> +			ret = inv_icm42600_accel_set_wom_threshold(st, value,
> +								   accel_hz, accel_uhz);
> +	}
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko



