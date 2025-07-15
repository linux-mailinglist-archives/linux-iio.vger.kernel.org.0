Return-Path: <linux-iio+bounces-21667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D32FB05518
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 10:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093B71C2311B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2CB275B03;
	Tue, 15 Jul 2025 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EfIsCgMl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFA5274B30;
	Tue, 15 Jul 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568699; cv=none; b=eqQbyDIZDog2zGjtOlPo2ND3CUFt53gSfgKMdvU+9g1kg8MiUXbKhZKo2yQJNJKMlXeOayVyrrxBoPHnCS6oFEL2efRLOJjwBEatusBWEtqTzxZCs7GkCFUGqr+2HzofYKDudUSpfimz1Q5QwJwk/xH88+rEgQHJN816HYn+uSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568699; c=relaxed/simple;
	bh=Nh+T1sWifzpoY2nGPt4UImanntT5vXYtrPPpbRWdxvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfefaN5z2dg+/7/6Ug/svc//gWCtRMfPPoZkIn8NINusw/giLSLcueI9VOur3L8t8mMJ6+Ws314WBV8UQM7l+/tWhzrWSX9kszW3xdh7sR8yYaxXaSj6PrC535vpPXW0pE/5EGTfUzVm/w5FPwTjkB7xBp8HqfNb80NYhSB7tOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EfIsCgMl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752568698; x=1784104698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nh+T1sWifzpoY2nGPt4UImanntT5vXYtrPPpbRWdxvw=;
  b=EfIsCgMlEIggsM0Wtu3j4i1fbO/bshqGBTAWDlmDEKPvQzEQ6lWm94Ru
   7v7NEIPz+xi107ZtmIHwPfye1WHXUtLRYKLlUJJOreS4iKmwB47sPSEiV
   rKqXgYB7ZIZnHGPhfja0v/8wvN9JigBRD25HdSwM1mstzvg14pglVj6EP
   TuC31Bg1ZRoxYAd+nkGkwWHYbSWHEZIxqX0iQCHb2gavPqaHUYX14ZxJc
   G8GbCU7TRYmWZGL3Az3q/CjXuTK72cpuFYZ7mANhS2PZEnBKjGLCh+U6m
   w5RsjYg85HVUDewnXOeQxhJmXSO67KpprLweaUijnCHCH91E/YbMQQmYH
   Q==;
X-CSE-ConnectionGUID: v5pXkxQJRcqJhXI3apKk3A==
X-CSE-MsgGUID: lIRNpjKwQKq8Qd2u3YS5Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54933566"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54933566"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:38:14 -0700
X-CSE-ConnectionGUID: Oa8iB2v8TpOvBVeVdNZaxw==
X-CSE-MsgGUID: CtVePSSaQ1u1LNBfOTJxgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="161475412"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:38:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubbAu-0000000FbEo-1HiK;
	Tue, 15 Jul 2025 11:38:08 +0300
Date: Tue, 15 Jul 2025 11:38:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 5/7] hwmon: iio: Add helper function for creating
 attributes
Message-ID: <aHYTcAO7sHsyevDH@smile.fi.intel.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-6-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715012023.2050178-6-sean.anderson@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 14, 2025 at 09:20:21PM -0400, Sean Anderson wrote:
> Add a helper function to create attributes and initialize their fields.
> This reduces repetition when creating several attributes per channel.

...

> + * @num_attrs:          length of @attrs

Other lines use TABs.

...

> +static int add_device_attr(struct device *dev, struct iio_hwmon_state *st,

This should hint that this is managed:

add_device_managed_attr()

?

> +			   ssize_t (*show)(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf),
> +			   int i, const char *fmt, ...)

__printf() attribute is missing.

> +{
> +	struct sensor_device_attribute *a;
> +	va_list ap;
> +
> +	a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
> +	if (!a)
> +		return -ENOMEM;
> +
> +	sysfs_attr_init(&a->dev_attr.attr);
> +	va_start(ap, fmt);
> +	a->dev_attr.attr.name = devm_kvasprintf(dev, GFP_KERNEL, fmt, ap);
> +	va_end(ap);
> +	if (!a->dev_attr.attr.name)
> +		return -ENOMEM;
> +
> +	a->dev_attr.show = show;
> +	a->dev_attr.attr.mode = 0444;
> +	a->index = i;
> +
> +	st->attrs[st->num_attrs++] = &a->dev_attr.attr;
> +	return 0;
> +}

...

>  	struct device *dev = &pdev->dev;
>  	struct iio_hwmon_state *st;
> -	struct sensor_device_attribute *a;
> -	int ret, i, attr = 0;
> +	int ret, i;

Also move it a bit to make it more of a reversed xmas tree ordering?

>  	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1, power_i = 1;
>  	enum iio_chan_type type;
>  	struct iio_channel *channels;

-- 
With Best Regards,
Andy Shevchenko



