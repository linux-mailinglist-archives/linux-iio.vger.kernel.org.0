Return-Path: <linux-iio+bounces-8985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7AD968679
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A712B24403
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8364E1D6195;
	Mon,  2 Sep 2024 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9/yiSaA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43811D47A8
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277348; cv=none; b=A8E8kfU43Xhml5+nj2gqdOMQ+ZlpWs3Gwch1ciPvo4RjANkTf1+bsRc662QvXULUAjG1UyvLzno8e7QfI40Z7LRgIUkiTdjT5ibQj+Ha5HnIjyZgjMScaF53dJiKE5m1hGz8d7Tr13Cdclz39kgFG0YQLhjLj67i5Rh35RPxUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277348; c=relaxed/simple;
	bh=BSLUZOYc/a2dEqR52zofY/Lq5kThip9ey9FAFxi+kCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXzENzqdBKsT6s8bpjp4r1KoFdsL0v+ZUQKvcb7cnNifb64yaLmCC/AeULGgoPIuMqHq87bxfzh9ozXDXNCO0eyaW+AcKXqBLjMW4BA5kePI1HhMDUr5AE+kqaHDPC4WhSWsVSeBsb+QM24p6UMXIBzJ9RkXlXqYGegB6MOZKbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9/yiSaA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725277347; x=1756813347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BSLUZOYc/a2dEqR52zofY/Lq5kThip9ey9FAFxi+kCI=;
  b=Y9/yiSaAmRInmkx67KPQAtnenLh3aqOK0gmGwyCHvKyw+Jcb8j53x0TR
   XJHb0wql64/qQ0I/I7KiCxSYgA2MjuweQkI421HFk7ulTbHfHk2vqZNtC
   3IJrJXOob+Sryz32PHDK+/3VjQt+juE475vkOwj3ZHVRgRkbpL3BKdSOj
   JvnfRDxagC4BM7Fp8tRnc7DrnCNdOBPVHy7tc+4hq8pgiw5ZW57ENc7KF
   PufANSOFPuF3jrxhzFJbHBck00VgFSwhluneF+cGq2VvYEV/dLu08Zj33
   AVJSVZvVWUyMY0H6Vno155KLOeQ3FJI1ymEXrbL86jech5M8S36yGq70c
   w==;
X-CSE-ConnectionGUID: SMrXnfNQQGSKZww2pTDeHw==
X-CSE-MsgGUID: 0EZ36xWFQJS89y4xgLRFgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="13329217"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="13329217"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:42:26 -0700
X-CSE-ConnectionGUID: xU7MdTm1SZ2R0g7Llq7weg==
X-CSE-MsgGUID: NkNHktC2RV67VP7d/7YHtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69208475"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:42:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl5Rr-00000004LSQ-3GmO;
	Mon, 02 Sep 2024 14:42:19 +0300
Date: Mon, 2 Sep 2024 14:42:19 +0300
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
Subject: Re: [PATCH 03/15] iio: adc: ti-ads1015: use irq_get_trigger_type()
Message-ID: <ZtWkm3zbfHiHgH_o@smile.fi.intel.com>
References: <20240901135950.797396-1-jic23@kernel.org>
 <20240901135950.797396-4-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901135950.797396-4-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Sep 01, 2024 at 02:59:38PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Use irq_get_trigger_type() to replace getting the irq data then the
> type in two steps.

...

>  		unsigned long irq_trig =
> -			irqd_get_trigger_type(irq_get_irq_data(client->irq));
> +			irq_get_trigger_type(client->irq);

Now a single line?

-- 
With Best Regards,
Andy Shevchenko



