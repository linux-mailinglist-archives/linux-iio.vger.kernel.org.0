Return-Path: <linux-iio+bounces-8988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA719968683
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A974B24B34
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B271D67AE;
	Mon,  2 Sep 2024 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0N/7uLS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603C13C9C7
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277562; cv=none; b=WCZ13yEgscCCYelQqZnNlIbjLmyYiLl+kcMchpSnQTsi9eG3Bb8eRExUyRvb1slc0J1gvkFDggm6QuVek/h7Kd9LHAcjqSd1IPLbm2UkDZIuy809burqZiV8TsCakui140NTSckXZjJ6FRkZnFvmT1sLJOi3uEvS8fIJdFCK63c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277562; c=relaxed/simple;
	bh=eU3aHBzuKlP2LUtE6DlmMZkPJDOQrZBv8W39nTrDT/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4omBHblM0nvCsPFqHcwIYS3yBjbg4eAdev9KxSffdqzFAacNahiVxE2vKtlZDh4rmEIvcG6LPeDG27dJ4jV/ii6SgkD6VkeO843UlYZUcjJv7Ijk+8j5PREL4pGsLNngmIn3w5ABko8YKr2mN01bqp7xYECSPYDXAG1Z/fiISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0N/7uLS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725277561; x=1756813561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eU3aHBzuKlP2LUtE6DlmMZkPJDOQrZBv8W39nTrDT/M=;
  b=a0N/7uLSF3ZLjdbCPfHDhqvTmSlGHs1f7cN8ARAIb+DXEzMr62/wNfEI
   JeWtLr4El/p0jkQQW2yzaxojSgai3CAU8o3t8sA+FJV9CC8lPhhRCo5TQ
   Vd0GBE+iHuGeIJQ8SPxbxFd/tYnFOsCogGDV45KImuyUiVcdYGzUyB202
   RqjZ4Z/IuMfu9oPSgq8dDtzXFFK2kCAfbxdNXwOOArsxwSx1MazpIco5L
   0yCuTjiPLqDNTH9I3zDMwV7oOIerPxyCa+ki0roIkunIjnuhAKEs1GgRK
   m3E0uX40aPhNVQXejsPi9cVc7zh8m2CX0lSRZpwtNiw00fwNUmOZpJ3Fy
   g==;
X-CSE-ConnectionGUID: xvn1E5u3SW6d59pzK9ppng==
X-CSE-MsgGUID: xMJ8jZ7jQ3q1nkIXxAyoaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23424599"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23424599"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:46:00 -0700
X-CSE-ConnectionGUID: FGjVAz4OStezceqdy9NT3A==
X-CSE-MsgGUID: fFmDP3UrSny69Jw0fQ5pOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="68974982"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:45:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl5VI-00000004LXB-1a8B;
	Mon, 02 Sep 2024 14:45:52 +0300
Date: Mon, 2 Sep 2024 14:45:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Sean Nyekjaer <sean@geanix.com>, Marek Vasut <marex@denx.de>,
	Denis Ciocca <denis.ciocca@st.com>,
	Rui Miguel Silva <rui.silva@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 08/15] iio: imu: bmi160: use irq_get_trigger_type()
Message-ID: <ZtWlcLfPyf-29kBJ@smile.fi.intel.com>
References: <20240901135950.797396-1-jic23@kernel.org>
 <20240901135950.797396-9-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901135950.797396-9-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Sep 01, 2024 at 02:59:43PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Use irq_get_trigger_type() to replace getting the irq data then the
> type in two steps.

...

>  {
> -	struct irq_data *desc;
> -	u32 irq_type;
>  	int ret;
> -
> -	desc = irq_get_irq_data(irq);
> -	if (!desc) {
> -		dev_err(&indio_dev->dev, "Could not find IRQ %d\n", irq);
> -		return -EINVAL;
> -	}
> -
> -	irq_type = irqd_get_trigger_type(desc);
> +	u32 irq_type = irq_get_trigger_type(irq);

Hmm... You broke the reversed xmas tree ordering.
Anyway, can we actually

>  	ret = bmi160_config_device_irq(indio_dev, irq_type, pin);

	ret = bmi160_config_device_irq(indio_dev, irq_get_trigger_type(irq), pin);

instead?

>  	if (ret)

-- 
With Best Regards,
Andy Shevchenko



