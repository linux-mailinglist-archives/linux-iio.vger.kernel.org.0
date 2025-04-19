Return-Path: <linux-iio+bounces-18335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1306BA9448C
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 18:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E553A9E02
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 16:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDED1DE8A2;
	Sat, 19 Apr 2025 16:20:50 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421E4502B;
	Sat, 19 Apr 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745079650; cv=none; b=kpGoiQ7bfVj5AfS3Y5qT9rmSHeGNxMyFw7AFMJnQQKkYkansDGtgN5Ftzu9ErjB0mma5uRWMEmiBdXX1Dccd6dJROJcNkqKSYwSM1t7HFaa5L8xn0MjCCWfKqoM6TwP12s54zxbZKZaikhHsXYGAS9t3lhuIlBcRvu4yiJk6RAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745079650; c=relaxed/simple;
	bh=9VlWTDgbXwprvMZuQnLXoYNqKZRatBbI/APmoj3LvkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFMBr609yUW0xRkqXYp9PPQtSG9bbGumEag0C/4n/BU1udEc0jniZEyfYU7lWSgrelhAUYuy8/GkIYltUWeCtYnaSIsz99kV6b8bXxf7aHWamrx94+0Lvh4hYbkDK0S7qRs+eT5WmXUgHXIzu5s6X9hU5CuADNvaQTfM8mxz67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: JYM97LKhRL+v6Oy0BWQf+w==
X-CSE-MsgGUID: LLPboQ75SXaQ96rvzSY+yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="58059433"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="58059433"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 09:20:48 -0700
X-CSE-ConnectionGUID: 7zpHiYaITHWLi92VVSgaqg==
X-CSE-MsgGUID: +SdfXRRQRuG421oi2qrcmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="135448124"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 09:20:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u6Avr-0000000DrZk-1bdG;
	Sat, 19 Apr 2025 19:20:43 +0300
Date: Sat, 19 Apr 2025 19:20:43 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: amplifiers: ada4250: clean up ada4250_init()
Message-ID: <aAPNWxyCI2kw1LhY@smile.fi.intel.com>
References: <20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v2-1-1bf9b033aaf5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v2-1-1bf9b033aaf5@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 18, 2025 at 03:37:54PM -0500, David Lechner wrote:
> There are a few opportunities to simplify the code in ada4250_init():
> * Replace local spi variable with dev since spi is not used directly.
> * Drop the data variable and use chip_id directly with the regmap bulk
>   read (__aligned() and initialization of the data variable were
>   unnecessary).
> * Don't use get_unaligned_le16() when not needed.
> * Use dev_err_probe() instead of dev_err() and return.

Sorry, but while a good one, this needs a split, at least to three:
1) __le16 type and linked changes;
2) dev_err_probe();
3) the rest...

-- 
With Best Regards,
Andy Shevchenko



