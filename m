Return-Path: <linux-iio+bounces-20894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3705AE39ED
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 11:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB6316BCBF
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474582376FF;
	Mon, 23 Jun 2025 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yby7p2wu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1FF2367CF;
	Mon, 23 Jun 2025 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670703; cv=none; b=cOE0tWsKBlJS7/FUZwgLPNET36f+OGIrTkrEWKuzE/A3y8scFEs31R2tuD6U10y5a4njmAaE8bjxT3S+8j/l4pjPKne/SrBzH4z9l+8djlvLQly6xydtYKv2h+Ty8aiHAh0lnin+NM8qlBgt7xaMNL7QjQ/iWM1tcx0P9v8R+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670703; c=relaxed/simple;
	bh=Ggee8f6F0frfCKXRsvTw3cnGg40txmMCsgO5DeKU+pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrqqVlD77ySlSHRDoUNVS0Odxa9b4cBEg4Bs4PeV+NyDIwyKjURJr9o1ecOUkZbIAUswbg9C+xQDZ6FGooglp5GMVXKUANZ2xanKIwcawxwBghB0nfCcBOfHxJ3ElfcNEfu9EozqjXzkOC7PvHoensEaWstOitUwMSrZnUWzs28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yby7p2wu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750670701; x=1782206701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ggee8f6F0frfCKXRsvTw3cnGg40txmMCsgO5DeKU+pQ=;
  b=Yby7p2wuo9JWD5g/BkK7SBLkG4pjaIlS8qb0VxcyoXSQZy6OFx43JXQr
   z4oI1NBjas5JsPT/+fiZqNmQHosb7fZ4v8C41wWQuZe1X/nHT0Cs0+4u7
   wGJjlXrR87t3H7jTzHfTDNuXSf+qauhnxTV5QFRngRDCcYrMnET+6SKen
   JhLYoI82SyxRdVQcXf/y/Lt2OHIsEw4wqdUIth1N6/T4vbVFegQvOfrzo
   gWZLVr2rik59jE0x3PsDgBuxcOZ4uNqqprQPCbw3G2nyp4MfvF1P8oPAb
   WVNFNw23TEVd9QW0oRyG+i6DmNJI/ydBAqd/+DsFSoa8vP8/w6ABBJOkC
   w==;
X-CSE-ConnectionGUID: kr88jhILTL6ddz5iYpPfQQ==
X-CSE-MsgGUID: DksU0uVVSbqgjngYo3Y/fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="64301350"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="64301350"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 02:25:00 -0700
X-CSE-ConnectionGUID: /8wK24XaQBWNJz5k8eORqg==
X-CSE-MsgGUID: 7ySY7qyzRBS23f3jwIsJ6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="152065477"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 02:24:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uTdQ5-000000097Zo-3rAz;
	Mon, 23 Jun 2025 12:24:53 +0300
Date: Mon, 23 Jun 2025 12:24:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v10 1/7] iio: accel: adxl345: simplify interrupt mapping
Message-ID: <aFkdZVD4j31QZ0eD@smile.fi.intel.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
 <20250622155010.164451-2-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622155010.164451-2-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 22, 2025 at 03:50:04PM +0000, Lothar Rubusch wrote:
> Refactor the sensor interrupt mapping by utilizing regmap_assign_bits(),
> which accepts a boolean value directly. Introduce a helper function to
> streamline the identification of the configured interrupt line pin. Also,
> use identifiers from units.h to represent the full 8-bit register when
> setting bits.
> 
> This is a purely refactoring change and does not affect functionality.

> +static int _get_int_line(struct device *dev, int *irq)

Oh, I should have been clear, I meant the suffix of the name, one still needs
a namespace for this: adxl345_get_int_line().

With that fixed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



