Return-Path: <linux-iio+bounces-8992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9479686B1
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1779B1F2209B
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1721D6DD1;
	Mon,  2 Sep 2024 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fvx0nJX4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E550A1D6C73
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277917; cv=none; b=nd/DXkJazkQAH07CJK7t9pQTRmkGEGFROvJygk6w/tLzSNwZzn/evjturgvmfXQdzXrl+3VIHZvD+yzrRmtVGEHwTlGhzjNpW9YCP2QB+AXnPU/NUOYaRffzmKuU4c/xL1CrOG/17W7Hwl5dfFkfzEkHrHJw0cl4876wX/yjXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277917; c=relaxed/simple;
	bh=1NxKcmOmRQ74GSOljHPVJ8gTuSY0DG3rBLL/cfgy0ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4yd2QQt+ksfqM2Kn/5mh286ZM8NwvGOV2BCP3Ol1Yb+/fQ5JGoUfUN/cuquLook5ta/BpqMcOWvvyyKokW7KhW6a2rS3nz0JNQy2XL0KFurJMmAyB6SvPjBo19J7DtWyjaqk8XQGz21IDpmrM6tcIWy99AJV4Tctus5M6kgY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fvx0nJX4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725277916; x=1756813916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1NxKcmOmRQ74GSOljHPVJ8gTuSY0DG3rBLL/cfgy0ZI=;
  b=Fvx0nJX4XX+HbyXu/JyMzTFWoUeMO4xXIEDcRYKpc+KTYZZ0BQ7YV2Tq
   1yHysGBPT3V7KGOHYM81WHZVyWF6ty8gfndlba+jRzBoyksHubqfcuu24
   iglTzy2c0T3whnVbZ/MrokHQOolsuSUu5f9nSY1Rhm6I7kGKotahEEsnG
   jdrENVaQzGi6400k/dnX2hdQkSXOPBmKfrz1wxu3j+MDuvONViMbkMZLy
   0da8+AYU4rvEbHnQPn8ksVJMIpFw2kHRqodDz+WzniEe+7SGsLD+k+o9o
   0RpCbx7ecAou7hc9J/wFOEVSDh7/fQgFptSft4p6JeLLe8u+g7SfsQSiA
   A==;
X-CSE-ConnectionGUID: tm2b3l6tRJetsjoeICoNZA==
X-CSE-MsgGUID: 1l7iu1e3Tq+aE6+orLDV8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="46369415"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="46369415"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:49:12 -0700
X-CSE-ConnectionGUID: JQh17O8wRNyX6jLy2Cetbw==
X-CSE-MsgGUID: F88JHJRaQ1W4idcs2hyBHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64592292"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:48:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl5XL-00000004LZk-32Fr;
	Mon, 02 Sep 2024 14:47:59 +0300
Date: Mon, 2 Sep 2024 14:47:59 +0300
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
Subject: Re: [PATCH 13/15] iio: light: st_uvis25: use irq_get_trigger_type()
Message-ID: <ZtWl7zdWGwDHJfL3@smile.fi.intel.com>
References: <20240901135950.797396-1-jic23@kernel.org>
 <20240901135950.797396-14-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901135950.797396-14-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Sep 01, 2024 at 02:59:48PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Use irq_get_trigger_type() to replace getting the irq data then the
> type in two steps.

...

> -	irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
> +	irq_type = irq_get_trigger_type(hw->irq);

>  

No blank line?

>  	switch (irq_type) {
>  	case IRQF_TRIGGER_HIGH:

-- 
With Best Regards,
Andy Shevchenko



