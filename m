Return-Path: <linux-iio+bounces-2769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0AC85A2CE
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 13:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB83B280D75
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 12:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6F52D045;
	Mon, 19 Feb 2024 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDHPVxu5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD3B2C856
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344240; cv=none; b=Z4wtZPGZNmAQXKc9lUjJerI/Bay9+1GuudL0Hf4f+n/jlPuHm3G1vmIxZUw975So1TFIH9Nkf/gmOHKmbImsyS9C7P8kp7XHc90EpJA38YdahyFAxh3AjRDKPnz/Gc3u7dr8t5WpSV2xTGO1trWNeYg9UMO6qVa2Akcxfr7bRFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344240; c=relaxed/simple;
	bh=H99UJNLH6G5g2sVZzZ9RCC7P2S0oe2PfqUjebE73+PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thTpeWqjEg90NZK0zL9sZDVPCtrsjv9CqTqcCbq2sAbH9lPBe6Vr4glk/kD8Vu2A1fdnuKQjk1c/+2QbDfTW0C6k4WC9CJfAAEEH34h6vKnKebIdp6lqjqW/hHG7VCgzSXWIgZkHDphy8jrjRHhhU52M/8WjAwqAKODbMl+6/f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDHPVxu5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708344239; x=1739880239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H99UJNLH6G5g2sVZzZ9RCC7P2S0oe2PfqUjebE73+PM=;
  b=PDHPVxu5KA1xaffUASkigJ6pihxMmO67w+5mInh+7bPdAxZieQDkL8Ie
   ds2g/PBUEHENEjsv1U4RWq3xVtKAWiym9yz/p8iLlab3DsgF3NwN1WQG4
   rrKQC0QFCHH90qBeizOF7Fb8V3C8Mj0m7AoF/mleSRZIuu9uRV0IC/THO
   UN/VPIIZjx60TR68TZR6BOg265FG2cqm+6uj5mqDGpyLpXA8ZLaiOkIiJ
   wgwmrLYvTug8EGA4kgVyQ8l9uYea7afqgpTzvp6uA0c8lZSx2MLR6kJBe
   BXkrjk3NWvxhN9094b2n+ingtL9xWhkp8DpuAcLZVTzQokIps62ENBeoK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="5380748"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="5380748"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:03:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912863900"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912863900"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:03:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc2NF-00000005oWe-0Iv1;
	Mon, 19 Feb 2024 14:03:53 +0200
Date: Mon, 19 Feb 2024 14:03:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Haibo Chen <haibo.chen@nxp.com>, Sean Nyekjaer <sean@geanix.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 7/8] iio: accel: fxls8962af: Switch from of specific to
 fwnode based properties.
Message-ID: <ZdNDqCTrOeisqYkQ@smile.fi.intel.com>
References: <20240218172731.1023367-1-jic23@kernel.org>
 <20240218172731.1023367-8-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218172731.1023367-8-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 18, 2024 at 05:27:30PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Only the irq was retrieved using an of specific accessor. Switch to the
> fwnode equivalent and adjust headers. Also include missing mod_devicetable.h
> and irq.h.

...

> -static void fxls8962af_get_irq(struct device_node *of_node,
> +static void fxls8962af_get_irq(struct device *dev,
>  			       enum fxls8962af_int_pin *pin)

Now it seems perfectly 80 on one line.


-- 
With Best Regards,
Andy Shevchenko



