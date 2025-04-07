Return-Path: <linux-iio+bounces-17741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5E8A7D95C
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FD817B84F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 09:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C39E23718D;
	Mon,  7 Apr 2025 09:15:44 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7E3237163
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017344; cv=none; b=BMfZ5OI5XjPzP5Erb2QwTvMzno4HROWqrl7yforzk61r9oirGgE7lhefFZMIakc+Oc689a7pGSsalpXu3iQAL/v/afNUOHvj/xPETMLWO8Fp+VjeH1paHkLAjjJf6yWfhB0B0epbCM1Xzd7naLH38Hk6VWTVzzbYAUCiJZ1CruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017344; c=relaxed/simple;
	bh=hb8pfCxz1z48BISeoGkX74uD01A1/uTTkQ7Vpzd6fek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqyea6JDJP58P+JdTYt8tpZ8ktEuDfDp8XN2Ki0UX/wh5nbr1qpvWzUXd+1SsjcSkLSTz60FkZl/8gqAbspsZLx8lbyqD3oSyo3FADx/+T55E0m3f+CAvPv6UuCaxbml4lP6mxj0rnA2SKPPD2ZTsdyI+v4648CHvasfbdBEEtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 4GVCJxiOQPS6ptKkX02NGA==
X-CSE-MsgGUID: VjV5n7BJSEaIs+zcmLzlpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="49045825"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="49045825"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:15:42 -0700
X-CSE-ConnectionGUID: CdDBU5fZSw+zg4zejpB5xA==
X-CSE-MsgGUID: G8XYQoMIRgmxF7zIPDU7dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="128830081"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:15:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1iZi-0000000A11w-232S;
	Mon, 07 Apr 2025 12:15:26 +0300
Date: Mon, 7 Apr 2025 12:15:26 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 04/20] iio: accel: adxl355: Make timestamp 64 bit
 aligned using aligned_s64
Message-ID: <Z_OXrmxVgcj0wcDX@smile.fi.intel.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
 <20250406172001.2167607-5-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406172001.2167607-5-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 06, 2025 at 06:19:45PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The IIO ABI requires 64 bit aligned timestamps. I this case insufficient

64-bit

In

> padding would have been added on architectures where an s64 is only
> 32 bit aligned.  Use aligned_s64 to enforce the correct alignment.

32-bit

-- 
With Best Regards,
Andy Shevchenko



