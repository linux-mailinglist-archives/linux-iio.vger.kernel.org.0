Return-Path: <linux-iio+bounces-11117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F23B9AE5B7
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5451F24CEF
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAF31D6DA1;
	Thu, 24 Oct 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vlwfnii9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD6A1D172B;
	Thu, 24 Oct 2024 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775304; cv=none; b=Ph9hbsFQCLs4wn1LVbUIon9SnuxzH9lITA05BJCLr15MhoEPZJ6jP06kCKJXPrIY4aoLWRslkJ8SEnapMntRPaIQpZe/DJov62i6uDZV4CTpIjr7VKuJiF4dMFZQWHHkb7+fgZUrzGxuwy1gZHK9fm5I//OFHNAaVKeL6jClsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775304; c=relaxed/simple;
	bh=EQnbbhpNIa6zDMOk34a2lVBWAg6GcWCIWLGiU/MLnAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbBVYuwrrGXeAVrDKX0ncYv2F19mzhPaoN0e4GkKXg7FcZilnRIsmi4yi14y6yncO6QiYLOn+Z0NFo/E9IY6epWiO/wqeVQEdRABn/7EId6ziLoF020GvsLBB3uGkbuL56TYgkLh1a0QPDm9CCn+P4R0NVhR9WMUgxQZRJY3X64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vlwfnii9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729775303; x=1761311303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EQnbbhpNIa6zDMOk34a2lVBWAg6GcWCIWLGiU/MLnAA=;
  b=Vlwfnii9n3aq+0d7l8qjW8rBmm/9/Dyi91hh//kN83no5mrz7IMg2ky9
   Z/jOc4MKyiTZOiUmQlkdxfeR10FAvGSlLiz+JZvUnqgAP+WGVs3bV/Odv
   Yhs2z+fAE55qdAxsrd7ofCt4kU++gpBVZh3j2KYCgnnIT/IMPXO7iAVqU
   aDjD8/tPWgcsfSt1aptdDYtSZLHAQ8Hzwz2XcXeA0DLrK0Ymkz9XtnbuJ
   ofdSiTO2XIlNwvCgBuc2IcOmIiDAjqu5Pg7yADEEmyLNpzQ5I4S4T9gRt
   4uqrDk5wsw7jUBFZT04YkKe91Abyra5dy5AxK803VPT8szg0B76nBsSUe
   w==;
X-CSE-ConnectionGUID: gvPCsKBWSQGNkUYrpdPHTw==
X-CSE-MsgGUID: SvWu3XtzSwSi+hUuLja75g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29565894"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29565894"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:08:22 -0700
X-CSE-ConnectionGUID: hzJvD565T+6gUWdyqxwJZw==
X-CSE-MsgGUID: sR9tmcbHSu2l63fjDKddbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85371588"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:08:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t3xZY-00000006a67-1pCv;
	Thu, 24 Oct 2024 16:08:16 +0300
Date: Thu, 24 Oct 2024 16:08:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 00/13] iio: Clean up acpi_match_device() use cases
Message-ID: <ZxpGwOcreTRCdEgR@smile.fi.intel.com>
References: <20241024130424.3818291-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024130424.3818291-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 24, 2024 at 03:36:05PM +0300, Andy Shevchenko wrote:
> There are current uses of acpi_match_device():
> - as strange way of checking if the device was enumerated via ACPI
> - as a way to get IIO device name as ACPI device instance name
> - as above with accompanying driver data
> 
> Deduplicate its use by providing two new helper functions in IIO ACPI
> library and update the rest accordingly.
> 
> This also includes a rework of previously sent ltr501 patch.

> In v2:
> - collected tags (Hans, Jean-Baptiste)
> - updated SoB chain in patch 4

Heck, I forgot to address the main comment by Jonathan! Sorry for the noise,
I will send a v3 later today.

-- 
With Best Regards,
Andy Shevchenko



