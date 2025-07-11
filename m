Return-Path: <linux-iio+bounces-21577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D90CB02218
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 18:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043D8164804
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D915D2EF64A;
	Fri, 11 Jul 2025 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SihlU3lV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A07A2EF29A;
	Fri, 11 Jul 2025 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252181; cv=none; b=iIcrmJYCzR3X3ZoyuN00gC2U192C7CyuES3b5su7NomYhS4+ZCUKFUr9GTQE+YRy2xB37166WZIhCZVtcO0VsrmfGYMx+ilIoKlfJZG604UjRTtn6JYsTROh2b5uj93KbEMCN1fmLbQzHs97MgBRJ6vGBNG9CwXS0c79OC2RF4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252181; c=relaxed/simple;
	bh=V18VHNC3dz0yIznCjQKV/OQqEvw9YzkaO4pU/94mC70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTsXjfhSFbiDMhdx15Sf9ymYbndVXu5mB/MvGz8RdYkYIq28D3WuEHgMg1D+W6ZIq3z+oOPFp0/JQCRHOkjbOTtT6X9pzc1YfmIAo5b5iKL+BI41mMT637rT8Z+Afkcv0Ad51my5n50RFeSj/tkSo9lDR3aD06OgcDs6IHHj9GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SihlU3lV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752252180; x=1783788180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V18VHNC3dz0yIznCjQKV/OQqEvw9YzkaO4pU/94mC70=;
  b=SihlU3lVE/YXN4sijzQI27VjYCb6IpI4+e+xB/+QH5CxNSEqBNoxJjs6
   XgLznNpGbvMCveP/Ix+clPEcBEjjBrvrDPuDH4UgCVvTbuux/of23Dw+C
   Rj5TJlmZP0qsO3UtLFCWqfJun1nyH2+jW4TRsmWNHsjMwrvwATVEkeCT+
   4Qwas9VXIoJ8FRpomRNwYmsZVxygaqhZqnqsiaJwhRIygTAWrNyqJukQy
   QWmFgjKZ4cjd2KuAa8GCVQ1ol7KkF0tcq6qgnOP2c+NYU9ObYuISCpU19
   0crXlxGVyvg2vwmGt/8qz12i9EOd4b5cewmifXXc1v++mpqoiiwZfOKTq
   g==;
X-CSE-ConnectionGUID: QFZl3M1BT5e+aoGwJ9FtlQ==
X-CSE-MsgGUID: uzzii3WMQ3yp4QPkHPhzRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53664522"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="53664522"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:43:00 -0700
X-CSE-ConnectionGUID: G5WucEtgSVWfK0ZfYKYguA==
X-CSE-MsgGUID: QpwSBHPeTwKZItswR0+t5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156039743"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:42:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uaGpr-0000000EaLf-0yrX;
	Fri, 11 Jul 2025 19:42:55 +0300
Date: Fri, 11 Jul 2025 19:42:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx_common: use stack allocated buffer
 for scan data
Message-ID: <aHE_DjbYzyW7CL10@smile.fi.intel.com>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-5-v1-1-4209f54e010f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711-iio-use-more-iio_declare_buffer_with_ts-5-v1-1-4209f54e010f@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 10:55:07AM -0500, David Lechner wrote:
> Use IIO_DECLARE_BUFFER_WITH_TS() to declare a stack allocated buffer
> in sx_common_trigger_handler(). Since the scan buffer isn't used outside
> of this function and doesn't need to be DMA-safe, it doesn't need to be
> in struct sx_common_data.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



