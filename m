Return-Path: <linux-iio+bounces-12811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 019099DE888
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 15:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A139F2814E1
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D5770827;
	Fri, 29 Nov 2024 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKwAPGzY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5085522F11;
	Fri, 29 Nov 2024 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732890786; cv=none; b=Hp6i3R2pxF/JD3zieJLdJSRi4UHv6hbEP5P+qcbLoMzT/Vb6JaVaH1BX/16nA+ebo+HI57uksgg8nyGg5RNib6YzV29dPUowPYZOuE3AkRn7OyEW5y2nvgIcpMnvw/5vAmE7zS3xTv2AsWoYz2wIkuXokkzyqNtTfq6FGSD/tH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732890786; c=relaxed/simple;
	bh=aGePj3CE+a0I6TCzKfUqgDFGuS1dTrq84ngngdtKKng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8npmOpU0ocjbVIzgwj9XJXKo9z981evGIhty4A/UvtR5uBodHvkM4HSk+acs1hLil7UIWGlM+Q0YoI2mo5gjjN8YCzs02DknEuYmK0YeX6Oey9jGep4lYnK+F1VCA6qqpCXYKyb7TLrSpB/w/dUJO+HVC6s4rzahBxiaBc+Jgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKwAPGzY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732890785; x=1764426785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aGePj3CE+a0I6TCzKfUqgDFGuS1dTrq84ngngdtKKng=;
  b=CKwAPGzYQ9urewlwn3yvDBYEHPMaPvPdOhh3z22bn9dQv7TTJ0nzl/i6
   bmns5m4L/uXewnaB47XHWpn2DXTpgDkqKAIdirnc8m3IJULL+VaYtLr76
   7GUAcMjFDlAg49WXWZyvpsVZbtkTqrBN+xIDMZIe6oQGtoCGgimPnmNbA
   /3GwZoVgWzZhJ+V9NS7LCUhT/GzablBEHRXs8hneczOUxZDzNUIox5WzT
   Yq17f7hpIXxXL3p3N9z00Z516YsKVs12O0P92g7vHig6Vs8VZa8jrWh4O
   UYg7h0IVI/qJhXaK5iWvjPCBXvTaSHcGWILyLcLatPikgVdroRlkxBoYB
   A==;
X-CSE-ConnectionGUID: /OzmUocqTUiOeehIVSrnzw==
X-CSE-MsgGUID: 4Tsj6pTNS3+IFGg/4XKoIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="58534629"
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="58534629"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 06:33:04 -0800
X-CSE-ConnectionGUID: lz8MS0gdRke11032lSCs0w==
X-CSE-MsgGUID: nciqehnjSKmlPK93kyF/pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="97606207"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 06:33:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tH23H-00000002GLO-45X0;
	Fri, 29 Nov 2024 16:32:59 +0200
Date: Fri, 29 Nov 2024 16:32:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: chemical: bme680: add power management
Message-ID: <Z0nQm_HX326_xcSu@smile.fi.intel.com>
References: <20241128193246.24572-1-vassilisamir@gmail.com>
 <20241128193246.24572-4-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128193246.24572-4-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 28, 2024 at 08:32:46PM +0100, Vasileios Amoiridis wrote:
> Add runtime power management to the device.

...

> +	struct bme680_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	pm_runtime_get_sync(dev);
> +	ret = __bme680_read_raw(indio_dev, chan, val, val2, mask);

Does it make sense to read something if previous call failed?
Most likely you wanted to use


	ret = pm_runtime_resume_and_get(dev)
	if (ret)
		return ret;

	ret = __bme680_read_raw(indio_dev, chan, val, val2, mask);

> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;

...

> +static int bme680_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)

Ditto.

...

> +{
> +	struct bme680_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +
> +	pm_runtime_get_sync(dev);

No error check?

> +	return 0;
> +}


-- 
With Best Regards,
Andy Shevchenko



