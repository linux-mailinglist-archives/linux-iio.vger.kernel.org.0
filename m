Return-Path: <linux-iio+bounces-22566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6655CB208F2
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 14:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B8518A2EF7
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2232D780D;
	Mon, 11 Aug 2025 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQyzVyqZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39E2D3EDF
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915830; cv=none; b=r/tCJUKL81ELXev3K2zXpZQEVO9+YEWNbE1GZ5HKh0RpJgXG4W2cDHcle4CpZxPatdHn7zkBVaZWWXVH04VmFydH5TJANjw10YCSRJRa+DDcwTLfcNEliX7qH1EMjhvRnvrq4oopzJleyS6fI0a9WON76EzA4K4YlHBkdhdVbmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915830; c=relaxed/simple;
	bh=KZWnvKQP+VJwdoBvwmtmNEoneeQmZPFEzBQGMTxeQTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UR+ZW/+WMZuD+4wDONhM+ki77ATXxXenPVQ6I7zphG+HBjkrvSzsYAkfsd6FhLpvX4zbiVpw3+0bVmszaGsxeE99lAY1WFeXGp0lYYHp/YLQ8nW/Cqi8yCseVqMVQkbo+mn3OiBhFNxAYR73STETu2DFHXplwxBAtm7knLmEcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQyzVyqZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754915829; x=1786451829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KZWnvKQP+VJwdoBvwmtmNEoneeQmZPFEzBQGMTxeQTQ=;
  b=nQyzVyqZjM3utYMRVdIiHdZ+gk+hXZ/FjlIzbbFbC1EpYaeu3lo8cq1J
   83G/0iO9/Jz10I29R2Wdvidb0eH2YuGywwhxvgsMW5CouYA3hj4umpSrG
   m2XbH+xaTtIfhkfwhZtNLpwFsl/yUAgF6VAetWl2lAkFNRpFI1WLwYhWT
   XBTyXDFVOat0aB51jXmc6uSgJ7evISWgRJUSw5q1huZbWNfmdu/lL3if8
   Yu5bbOgTCUvJ82wr/XKh+9BxjIEW7Z+orTYRWtVd/rDp0mO4/AU353cfH
   XvmSeygozRcx/mHMGTVTjrYuSkCzdDIM8YZo7GXLFLbx5rXUmEQsfa04H
   Q==;
X-CSE-ConnectionGUID: keV3Nh9BRG2zWG/tx7uv9w==
X-CSE-MsgGUID: UY2znJg/Tp+DPuVZbNSP7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57087944"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57087944"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 05:37:08 -0700
X-CSE-ConnectionGUID: 1axpHxHiS8ShY0Hl/TyX9A==
X-CSE-MsgGUID: eeIlwJMtQPerygwUvJmuyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166706579"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 05:37:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ulRlv-000000052TU-3u5D;
	Mon, 11 Aug 2025 15:37:03 +0300
Date: Mon, 11 Aug 2025 15:37:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: Improve iio_read_channel_processed_scale()
 precision
Message-ID: <aJnj7w5aJ3B-AGGD@smile.fi.intel.com>
References: <20250727210639.196351-1-hansg@kernel.org>
 <20250727210639.196351-2-hansg@kernel.org>
 <de1b173b-d6fa-4ebf-a399-262c035ecef8@baylibre.com>
 <73d5746d-a9fb-40c2-9ad2-bcf970683284@kernel.org>
 <7810b341-1216-4fe4-8c05-17acb00430c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7810b341-1216-4fe4-8c05-17acb00430c7@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 10, 2025 at 11:12:24PM +0200, Hans de Goede wrote:
> On 10-Aug-25 9:25 PM, Hans de Goede wrote:
> > On 29-Jul-25 7:26 PM, David Lechner wrote:
> >> On 7/27/25 4:06 PM, Hans de Goede wrote:

...

> +		switch (scale_type) {
> +		case IIO_VAL_INT_PLUS_MICRO: denominator = 1000000LL; break;
> +		case IIO_VAL_INT_PLUS_NANO: denominator = 1000000000LL; break;

(s64)MICRO
(s64)NANO
?

> +		}


...

> +	ret = iio_multiply_value(processed, raw64 * scale,
> +				 scale_type, scale_val, scale_val2);
> +	if (ret < 0)
> +		return ret;
>  
>  	return 0;

Simply return iio_...(...); ?

...

> +int iio_multiply_value(int *result, s64 multiplier,
> +		       unsigned int type, int val, int val2);

There is room for type in the previous line.


-- 
With Best Regards,
Andy Shevchenko



