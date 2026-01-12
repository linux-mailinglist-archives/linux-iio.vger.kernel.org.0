Return-Path: <linux-iio+bounces-27630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8151D10D90
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 08:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C86D300FF94
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 07:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB1232142F;
	Mon, 12 Jan 2026 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYngNzDS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CFC2E62DA
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768202601; cv=none; b=CM/TjdfqLgEbUWxaXwB0g7RlCH6PQ0/mXn9DjjbBZq1/rDAOoxqtDhbZtEnGc7jwiFDXerNF9xgdZG6A23y9RC1DBssIFLEBNf8GWtIUNYqEjRgXGxqZMn5xoe4vkmNFjfqvGUBoHgZFN74awZVBujgj2qboNTFUB/EGEYDX2SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768202601; c=relaxed/simple;
	bh=Hn0BMuJYvAMVhoLdsIEH2PUlk8geHofEwLYRWEDhopg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmfPDVQaojuE3BSvm7VtjgeSi9IKofUeDvskXSZiXAtkNeOOr8cc/wh5fXnHei8jlJxMeM5BO8BqIjTSQ5iMgmWa84ptleKUcN+hxhmyKKuvVSbH5EtyNPerjHfLJ0CMZM8wiKGNRt6gSLAu0CXWexTLCl4tRF45EVBXHDZg+qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYngNzDS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768202599; x=1799738599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hn0BMuJYvAMVhoLdsIEH2PUlk8geHofEwLYRWEDhopg=;
  b=DYngNzDSUUcGWTBjJvZE4Kgw3IuUa6efij8U856ptRohjyqLjp6Q3cZf
   MZqrAevDpGhF8CwCfU5yb9u5FDZfWOjpKfNjGQnTp/gEptkqJ6HtjhUkE
   6GYmGp5FdPf8W+EcNjyJLF+GhjXPCnFeI+jWeIu2lsUwmtk34YgB1k/3O
   ilpKyK2YnUV5IsB5dFBnwdtikxA2RzFUrOBnVl4WFBrLHVS2t9f9ydedT
   ERlr9GM/pjmpLXazQaqcioYx/JI/3vj+sRjpFPbay/wZ26RvTw7uzIpUk
   vsWbQgfJQuU8QfJH8VORJ7slbjNKGlVcZ4ApqfhDsi22+rDMzXFILHYny
   A==;
X-CSE-ConnectionGUID: 3tFSvuiWQOSyaU1wzB81pQ==
X-CSE-MsgGUID: xMUzkeOIStSAYakcehSEdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69386727"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69386727"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 23:23:19 -0800
X-CSE-ConnectionGUID: ygKgSe6iSJGng59ovTFcfw==
X-CSE-MsgGUID: wAUvqxnEQl+lqaYlZvMpdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204090578"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 23:23:17 -0800
Date: Mon, 12 Jan 2026 09:23:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Jonathan Santos <Jonathan.Santos@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: adc: ad7768-1: Select GPIOLIB
Message-ID: <aWShYv4G2oFHh4Fm@smile.fi.intel.com>
References: <20260111165528.284067-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111165528.284067-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jan 11, 2026 at 04:55:28PM +0000, Jonathan Cameron wrote:

Thanks for fixing this, my comment below.

> This driver provides a gpio chip a some related functions are not
> stubbed if GPIOLIB is not built.
> 
>    hppa-linux-ld: drivers/iio/adc/ad7768-1.o: in function `ad7768_gpio_get':
> >> drivers/iio/adc/ad7768-1.c:420: undefined reference to `gpiochip_get_data'
>    hppa-linux-ld: drivers/iio/adc/ad7768-1.o: in function `ad7768_gpio_set':
>    drivers/iio/adc/ad7768-1.c:453: undefined reference to `gpiochip_get_data'
>    hppa-linux-ld: drivers/iio/adc/ad7768-1.o: in function `ad7768_gpio_init':
> >> drivers/iio/adc/ad7768-1.c:498: undefined reference to `devm_gpiochip_add_data_with_key'
>    hppa-linux-ld: drivers/iio/adc/ad7768-1.o: in function `ad7768_gpio_direction_input':
>    drivers/iio/adc/ad7768-1.c:387: undefined reference to `gpiochip_get_data'
>    hppa-linux-ld: drivers/iio/adc/ad7768-1.o: in function `ad7768_gpio_direction_output':
>    drivers/iio/adc/ad7768-1.c:404: undefined reference to `gpiochip_get_data'

We don't need these many strings, the important ones only would be enough, like

  ad7768-1.c:420: undefined reference to `gpiochip_get_data'
  ad7768-1.c:498: undefined reference to `devm_gpiochip_add_data_with_key'

(and also no need to have a full path in this case, we can always read an email
 from the LKP below).

> Fixes: ("d569ae0f052e iio: adc: ad7768-1: Add GPIO controller support")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512271235.WwAmAbOa-lkp@intel.com/
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

-- 
With Best Regards,
Andy Shevchenko



