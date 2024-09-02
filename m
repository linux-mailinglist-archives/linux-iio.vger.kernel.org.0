Return-Path: <linux-iio+bounces-8986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B4296867E
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF181F23B19
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0231D618C;
	Mon,  2 Sep 2024 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNzhoOEx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8111D6194
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277455; cv=none; b=ZHB1uOmocfxzYvmblCfiqzKzypMogl8tb4ikrwginCRNQwE6jMXeWcXTqOxbB7wq/ldtLKpLfHyyY1RihK68/GemJfdIOwPXVM2IaYfzzpIt8Wb05RfT07FRZVrWgFUcS+YeNmRnrLfufFY4IvUXwGR4ZRqmI9yUEeOh2ttZXiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277455; c=relaxed/simple;
	bh=WtiJbV3TXUvvaD2BoG7kGsJIrjinNkauXl7dTHZJRE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+VZqveubUOUluBt7BA8ZqRqGQIp4+HcuQ2fXc84JG9LdVV4q3wlg7Ud8dsBJ4FQ6ltNtDykBlZEGu/hm8EWa2l494x2Xz89LBNN4JZCgsWeqNqXGUqlWtBJETu6PqBCb7q+UsqzMXPDPQx2fJKRn/oCXoIyeymaBGOH0skiz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNzhoOEx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725277453; x=1756813453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WtiJbV3TXUvvaD2BoG7kGsJIrjinNkauXl7dTHZJRE8=;
  b=QNzhoOExBcaeE+1/khCS4rLHYcQYZ5U8uyaBX9FbQ/UGv62HoYfMV5OP
   a8sCm0BRxLOSFDNiTIVeuzT9v1dvpw86WHU50MRaztAASq9P3LHzu7/jG
   kuRgWx77QFpu3isBz8If0CnRv53A7V9Q6dEWuYXRXlBt9Qw8c3PBxE6Xo
   qQBGRGI6gh+LfoMDrGtVKrs4etUlKg59bORkIhtEK8ogr5eRPre6zpZoi
   5k60Ft3DZqFaW+r2vYdx6XtUPacLJqKmCzrhvXgl2CQqcAe6NJrAlNhE/
   KBa76gCbzwxrjWmczooU6jp91nUkYhWDIJ6/5a0FBisxX6anBiCCf3zgj
   g==;
X-CSE-ConnectionGUID: zZYNlgOmQBKPv9iIAX4pdA==
X-CSE-MsgGUID: W3yEyJG4RfmdDfGeqKSH/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="34465754"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34465754"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:44:13 -0700
X-CSE-ConnectionGUID: Jeba7VDxQr+kQYY5sG9q1w==
X-CSE-MsgGUID: vDB8M5CXTSOmqQFBdFAQ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69453909"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:44:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl5Ta-00000004LUw-1eSa;
	Mon, 02 Sep 2024 14:44:06 +0300
Date: Mon, 2 Sep 2024 14:44:06 +0300
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
Subject: Re: [PATCH 04/15] iio: common: st: use irq_get_trigger_type()
Message-ID: <ZtWlBvNLUmR6HQZb@smile.fi.intel.com>
References: <20240901135950.797396-1-jic23@kernel.org>
 <20240901135950.797396-5-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901135950.797396-5-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Sep 01, 2024 at 02:59:39PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Use irq_get_trigger_type() to replace getting the irq data then the
> type in two steps.

...

> -	irq_trig = irqd_get_trigger_type(irq_get_irq_data(sdata->irq));
> +	irq_trig = irq_get_trigger_type(sdata->irq);

Usually I think the

	/* ...comment on flow... */
	foo = bar();
	...something with foo that is commented above...

is slightly better as after reading the comment we immediately see where the
foo comes from.

>  	/*
>  	 * If the IRQ is triggered on falling edge, we need to mark the
>  	 * interrupt as active low, if the hardware supports this.

But, it's not a big deal.

-- 
With Best Regards,
Andy Shevchenko



