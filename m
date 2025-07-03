Return-Path: <linux-iio+bounces-21307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37B5AF778A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 16:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2237BE02E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 14:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F322EAB70;
	Thu,  3 Jul 2025 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQOeZWYF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953ED1AAA1C;
	Thu,  3 Jul 2025 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552808; cv=none; b=KS2K8ZcvozuuiYTc+BbeuczzO13EVKNzgVC1H03GYLs0BHuEYRr5FclyhWV0tOBEMYk0mAUzwRjI/hYqyWINZFLOyBfHtTW8SocXRqs9BVJjSGbzW3v3DR9Zts30fUfwpibSIoAvcZ4//hV29ALHCahkVy9E0Z9t+2diLHq0kig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552808; c=relaxed/simple;
	bh=RIgS/Jsh67fz5myKGVmZisyLewVCaS2pTmhNc0MbXew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHS/JwCaPZlMYFNOWtxUMdPr4dhZaHn8aZHvvBeb4Z4Cb0jy5KQbrl2jquASHXmi+s8Wn5G9o2GDpUrmReNL4I3VK7omzawIl6S5xq+XlonMoc+WhDEek30LPbYNMBW0J3/BpQCj6obzFWD68u3wZ5Cktaoi1yjbuUPVAeKixSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQOeZWYF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751552806; x=1783088806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RIgS/Jsh67fz5myKGVmZisyLewVCaS2pTmhNc0MbXew=;
  b=QQOeZWYF6RguLIW4gh5C839y8b1YUfUBRozi1AqfVpCIW1MbNqNnY4Im
   c3cMYwJzInJSQV9kf1lsa+zQhhjwrsfG+a9CN74Ev4sFPnUOj+wwJ3Vlo
   OhjAUfSe0N4rgRdFDluP7Kq9B4vU6HoAyLUVKNYbEgz3NRtlP/lRkT/t9
   SuT8xVXObeMbpStaSvPtcfuykxrkfQ6XOIdKx6rT9Aqdl0z5sR3DB0n28
   dWRmIN3Jyzioh/IYSOTHqKcIV+XI5PL1BmbwoP/ENNQ+kEXrq/rScfcgn
   V8oOjZf6PpVhtacmXirJe/FSKC9ZT8f8kRjORw6txRodioT9Ra/sIMFAq
   Q==;
X-CSE-ConnectionGUID: px3kGsKURyO7r0fEArkctA==
X-CSE-MsgGUID: NcFd/Y2GTIyT+hfwbF3h3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64480271"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="64480271"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:26:45 -0700
X-CSE-ConnectionGUID: ZNRkCkVnS+eke8DNb2nZ4w==
X-CSE-MsgGUID: 2OX+pup0TWytaxUf/24E8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="158946531"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:26:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uXKtb-0000000CE7U-1PnL;
	Thu, 03 Jul 2025 17:26:39 +0300
Date: Thu, 3 Jul 2025 17:26:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v11 4/8] iio: accel: adxl345: add inactivity feature
Message-ID: <aGaTH6gVqHxn9Xct@smile.fi.intel.com>
References: <20250702230315.19297-1-l.rubusch@gmail.com>
 <20250702230315.19297-5-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702230315.19297-5-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 11:03:11PM +0000, Lothar Rubusch wrote:
> Add support for the sensor’s inactivity feature in the driver. When both
> activity and inactivity detection are enabled, the sensor sets a link bit
> that ties the two functions together. This also enables auto-sleep mode,
> allowing the sensor to automatically enter sleep state upon detecting
> inactivity.
> 
> Inactivity detection relies on a configurable threshold and a specified
> time period. If sensor measurements remain below the threshold for the
> defined duration, the sensor transitions to the inactivity state.
> 
> When an Output Data Rate (ODR) is set, the inactivity time period is
> automatically adjusted to a sensible default. Higher ODRs result in shorter
> inactivity timeouts, while lower ODRs allow longer durations-within
> reasonable upper and lower bounds. This is important because features like
> auto-sleep operate effectively only between 12.5 Hz and 400 Hz. These
> defaults are applied when the sample rate is modified, but users can
> override them by explicitly setting a custom inactivity timeout.
> 
> Similarly, configuring the g-range provides default threshold values for
> both activity and inactivity detection. These are implicit defaults meant
> to simplify configuration, but they can also be manually overridden as
> needed.

...

>  #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
>  #define ADXL345_REG_TAP_SUPPRESS	BIT(3)
>  #define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
> +#define ADXL345_REG_INACT_AXIS_MSK	GENMASK(2, 0)
> +#define ADXL345_POWER_CTL_INACT_MSK	(ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK)
>  
>  #define ADXL345_TAP_Z_EN		BIT(0)
>  #define ADXL345_TAP_Y_EN		BIT(1)
>  #define ADXL345_TAP_X_EN		BIT(2)
>  
> +#define ADXL345_INACT_Z_EN		BIT(0)
> +#define ADXL345_INACT_Y_EN		BIT(1)
> +#define ADXL345_INACT_X_EN		BIT(2)
> +#define ADXL345_INACT_XYZ_EN		(ADXL345_INACT_Z_EN | ADXL345_INACT_Y_EN | ADXL345_INACT_X_EN)
> +
>  #define ADXL345_ACT_Z_EN		BIT(4)
>  #define ADXL345_ACT_Y_EN		BIT(5)
>  #define ADXL345_ACT_X_EN		BIT(6)

Now it's even more mess. I am lost in understanding which bits/masks are from
the same offset and which are not.

...

> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_PERIOD),

Same comment about indentation style.

-- 
With Best Regards,
Andy Shevchenko



