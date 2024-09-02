Return-Path: <linux-iio+bounces-8994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2468B9686CE
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A05AB25ABA
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD5C1D6C73;
	Mon,  2 Sep 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avMDgd/3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CAA1D6DC3
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278120; cv=none; b=pZS2bU6iTFQJq92CZHkaFdDsCS1XbMhQfMf7H2YEeTykoqe43WWLM4G2M6iLcWmgI3XTqTGbGEOdsDi0fTUJfknBtywuQ0nmZNcks46bzv1usifXTPTqeSS9L4igBzEUrr136HFy8rslRDH+z06UIk49QYg5onzxV9abGlF3oys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278120; c=relaxed/simple;
	bh=H443R+FJPgvK3fmz2xAoehhGGbEadeYMb7ZSrpFtmws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRnatfBgUJ0puIVwD9vXxnWmzRa4HlN1Is6mqa9A0uQMM+VdBrsss+a7YyMDmugefjAfDhM++MOTXE0ebn4vwlLy6VjYhNGDYujMRWWAOzoAXxnQSjb8qeRlmGCJD75zChku716SL9cA5uF5tsibPg/xfqTeU8jBBPp/JsyGTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avMDgd/3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725278119; x=1756814119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H443R+FJPgvK3fmz2xAoehhGGbEadeYMb7ZSrpFtmws=;
  b=avMDgd/3HAc4epCEyerkl996H6DM8JgAaGmZSBVc8EHeQY8JCLOqTfry
   hlcfiO62LWGhV88p560pAs+EWnBO2yTnmczzeG7RS8kHaCx9AhuV8ChMy
   scytlgwjXcNJ+F7wdKnJSrgk0KO75v3TJnvNi8PsmdpYjfOqvRWNHe8nV
   BJA71M5uZOnAkBSq7jLJrkJy81WXsv3BMNFKUqSbhnNnFxxvow7aQ0yOH
   oz/Gq3ZwV0HAZREREeYXnZGQI/YrQMkdnMGAy0APEAm7gPs7kah8ZaO5J
   UyG/k1NWJoFr2MiZkSrghLWtRos9nU93b9XDYkcO2PZUQPplFhpVzCRGA
   w==;
X-CSE-ConnectionGUID: uYOlzNPdTXWn6rAx+sDxeA==
X-CSE-MsgGUID: expiqbPNTqKlpBWFs8m62w==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="26758740"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="26758740"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:48:54 -0700
X-CSE-ConnectionGUID: wYZFMe6ORqS7DX2nW5ymJw==
X-CSE-MsgGUID: ikjaDE9iSSOfz7TlEmtVMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="102042647"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:46:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl5W4-00000004LXz-1CuX;
	Mon, 02 Sep 2024 14:46:40 +0300
Date: Mon, 2 Sep 2024 14:46:40 +0300
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
Subject: Re: [PATCH 06/15] iio: gyro: mpu3050: use irq_get_trigger_type()
Message-ID: <ZtWloABJOwC5KEos@smile.fi.intel.com>
References: <20240901135950.797396-1-jic23@kernel.org>
 <20240901135950.797396-7-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901135950.797396-7-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Sep 01, 2024 at 02:59:41PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Use irq_get_trigger_type() to replace getting the irq data then the
> type in two steps.

...

> -	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
> +	irq_trig = irq_get_trigger_type(irq);

Same remark about comment vs. assignment.

>  	/*
>  	 * Configure the interrupt generator hardware to supply whatever
>  	 * the interrupt is configured for, edges low/high level low/high,

-- 
With Best Regards,
Andy Shevchenko



