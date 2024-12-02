Return-Path: <linux-iio+bounces-12975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F4B9E0C71
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 20:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D9F16574C
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5051DED5F;
	Mon,  2 Dec 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmRMb4C6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7961D1DE8B5;
	Mon,  2 Dec 2024 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168625; cv=none; b=VlK0wmFD4OjgET5co/JXWnj2bzIp4WiN0cHGxdMJOMMuymXg/+OhDe+gxSOu58DLDk9/Y2IcRxLfH3QAfbRK9q3hXAXKOd62xlkp+BHESvdWZtWM6AEGDx+fQCqruOHkSWxXq1u9shdYBHEsJxGU2HRCWuvT1K5gkUd2GIk0eUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168625; c=relaxed/simple;
	bh=Ev011DgW8W9MCWNU5NPGdfZIORicMYHVTOg67mjfIiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awsY55p2t0tJ93+5WSI9C4wnu5aB3OVMmAJ5s2VO011Gj/vkLRQqz+VMWw0mbR7SyIdKOhAuOiJaoGRjC39hbH5DTWb2PdRFy5CHhpPfGF/a5jKCYS/pvSFD5CEa2ZV/cyGaBIogm4ePIvMreIju9xiBquzhS8uSqWkfP/L+n7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmRMb4C6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733168623; x=1764704623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ev011DgW8W9MCWNU5NPGdfZIORicMYHVTOg67mjfIiI=;
  b=BmRMb4C68jtrziOWgrLsxhWPVGVXydvnB3IxS14TYS3iE6Qri2ZBMnul
   MIpfT9EQmrfzyPL2lgE2d6gGpmvQupRBL5NNdnrzFClCCvs+VVh9OjKdg
   jZZgi470RfnHuIucXgOZ74iDefLnwqEzz7ikBwnhZuM1+wyyZfh0No4vD
   rTufLL3q+VVcERAs9Z4umqsP/SSm+UScFp+1twiI3LCuCpz2Iup7LnUbL
   GfvRfIFrSkPZD3dVK3lSSORebBRnGZYgRN4R+0j2CSZ+FIhFrqoER6NrQ
   TF9QY0+wH6PnEa7zztkoTqRznsP0pRdhHrBcAIXZCZW/DoyiLm0zer7SD
   w==;
X-CSE-ConnectionGUID: 1BflyPW9Q6umbcF5z+m9+g==
X-CSE-MsgGUID: C7v/Bh58RMC/LGkhk5nvAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32715924"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="32715924"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 11:43:42 -0800
X-CSE-ConnectionGUID: AmLX83pYQ8+pom7c4eLXrg==
X-CSE-MsgGUID: L46xZO5RQCqIHzcbr6uyxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="94033550"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 11:43:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tICKW-00000003EYs-3zVm;
	Mon, 02 Dec 2024 21:43:36 +0200
Date: Mon, 2 Dec 2024 21:43:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, u.kleine-koenig@pengutronix.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: chemical: bme680: add power management
Message-ID: <Z04N6GUSL2H0zt6_@smile.fi.intel.com>
References: <20241202192341.33187-1-vassilisamir@gmail.com>
 <20241202192341.33187-4-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202192341.33187-4-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 02, 2024 at 08:23:41PM +0100, Vasileios Amoiridis wrote:
> Add runtime power management to the device.

...

> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = __bme680_read_raw(indio_dev, chan, val, val2, mask);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);

Side note: as long as idle method is not defined (NULL) the above dance is
already taken into account in the regular put.

...

> +static int bme680_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct bme680_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;

> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Either this is broken (if the above can return positive codes), or can be
replaced with direct return:

	return pm_...

(but I believe it's the former and you wanted something like if (ret < 0)
 there).

> +}

-- 
With Best Regards,
Andy Shevchenko



