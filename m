Return-Path: <linux-iio+bounces-17748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADC8A7D9AD
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148ED188AFE5
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 09:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D9E19F495;
	Mon,  7 Apr 2025 09:30:50 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67C146588
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018250; cv=none; b=BlLW6Cwo6y8UA8mr7PMZaRnto18lcMTyASgRUNvLGztRcnPgAbsEbMzPPllgm+iboydze2Jo82A0l2ISfbQP6lQcuYj7b34oq1frstI6PSO+2LboRT6rKZoFJgDw9waJnRDda/T+qk4RDhlgB2IDRE9z7gSTzW9QpArFHpXFmfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018250; c=relaxed/simple;
	bh=udcS0e5TUIzBrnNBu+rPd2qpMboO+zU7ry4c10De7xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvMklp/GJiVXJBozVYLGig86ZL+WWN5dbNsMbbA4WVx8K/JB70ulJBXHWqCfLSM9klC6y7TnMxheeIfQZrFGthPqIagZpBHAxz5jtzKWQRvwQmt4EoBUUlMxv7wuQ5sdpf8jD9JYONbrwtf/5crB+tdotQ7/iS2cKtBLb0DiDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: F0XC8CUoTfKsumPgZaZh8A==
X-CSE-MsgGUID: gYczMqW0RaOMmOAjgcppYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45282672"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45282672"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:30:48 -0700
X-CSE-ConnectionGUID: jTa43AxuRTeLf9acBpxVJA==
X-CSE-MsgGUID: eJBL04z6Q+KMXJi6SwWKEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="158887327"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:30:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1ioW-0000000A1Fj-1Hkc;
	Mon, 07 Apr 2025 12:30:44 +0300
Date: Mon, 7 Apr 2025 12:30:44 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 09/20] iio: adc: Use iio_push_to_buffers_with_ts() to
 provide length for runtime checks.
Message-ID: <Z_ObRMx7p9GVf1sV@smile.fi.intel.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
 <20250406172001.2167607-10-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406172001.2167607-10-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 06, 2025 at 06:19:50PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This new function allows us to perform debug checks in the helper to ensure
> that the overrun does not occur.  Use it in all the simple cases where
> either a static buffer or a structure is used in the drivers.

...

> -	iio_push_to_buffers_with_timestamp(indio_dev, &chip->scan, time);
> +	iio_push_to_buffers_with_ts(indio_dev, &chip->scan, sizeof(chip->scan),
> +				    time);

I think readability is better when this occupies a single line.

...

> +	iio_push_to_buffers_with_ts(indio_dev, priv->buffer,
> +				    sizeof(priv->buffer), pf->timestamp);

Isn't it enough room for one parameter on the previous line?

...

> +			iio_push_to_buffers_with_ts(indio_dev,
> +						    &info->scan,

In all other places you put these two on one line.

> +						    sizeof(info->scan),
> +						    iio_get_time_ns(indio_dev));

-- 
With Best Regards,
Andy Shevchenko



