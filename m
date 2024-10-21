Return-Path: <linux-iio+bounces-10836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A527A9A5C1C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 09:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC99D1C21D48
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 07:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5791CFED1;
	Mon, 21 Oct 2024 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tw7jSU+4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6704E1940A2
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494631; cv=none; b=H2+n4ci2Si/bnBI8QIJA1XnpD8WoalF16FQmDA/wWpHKitzL+SDCTZ+Z7R2e20VRmpO4xXLSKpcyEUTA7+FtKYAlQ+H37GHAkTzGMY2sXwg0r5Ab2tuq7JUdlP7myoThaErTLSRxp/aYrU7hiNEC1/pCNKSzp4fq2t6/zv4hiBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494631; c=relaxed/simple;
	bh=Mhce0Jn3Ru1+L+F4i8gVuRYX97fHynrPbb2wT8WYaO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uvjg9DL3/OFaFsxCMIpkd0ul0pArcPoc/89BHCYapQGAtVHaqwz0godVfbtWrfZ9nllLked57dl4YTiBd33X77hHbjh4una12C05P96MtlroFL0mqvVC5WKpozZkeZsOe4o8Ep5LOm25KDqMJSjGQZ5iYs6b/SGVzHPuzH6f0XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tw7jSU+4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729494630; x=1761030630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mhce0Jn3Ru1+L+F4i8gVuRYX97fHynrPbb2wT8WYaO0=;
  b=Tw7jSU+4r1YEHPvsTZvxMW8Tl+4nLJncN4XTmloIAWRg4Lvx5EVR/xYX
   o6jJcAb8R/YlN3xiOLwCH6ykxDTxtQ6knkJcL+b9pNkCypOh8yNgwO7N0
   4m3/BtCXPECa4hTVKWtD3bZuZYve6uXdSUQAW+XcPYQmC8SSyiTgsKTiK
   ho8nP+NVm2NqtPaWXHOT7RP+FLLhlIiDjTq37VLmBizsnOQOq6RnRjEWj
   xvNES78GAYfqNaS8ohLkDCJxpDADagPoM0Dh+1KmR64+zuzgWdqklPojc
   ibSehlGSGL7GdeHQldkOtMVLxWTGR7qT8BBc/NcHvXS0tXOphwGTHKAoB
   A==;
X-CSE-ConnectionGUID: Va8IHPChTNaxiX5AkUFLOA==
X-CSE-MsgGUID: R+qOr+SDRPmsXoEM1iz3jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="31825161"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="31825161"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 00:10:29 -0700
X-CSE-ConnectionGUID: QIr/F0naQ0SmonKgD0Qlyw==
X-CSE-MsgGUID: FVtIGyD4Rt6285FF044qrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79595395"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 00:10:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t2mYb-00000005PAN-1UXf;
	Mon, 21 Oct 2024 10:10:25 +0300
Date: Mon, 21 Oct 2024 10:10:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: accel: replace s64 __aligned(8) with aligned_s64
Message-ID: <ZxX-YXTOuYEb8AoY@smile.fi.intel.com>
References: <20241020180720.496327-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020180720.496327-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Oct 20, 2024 at 07:07:20PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> e4ca0e59c394 ("types: Complement the aligned types with signed 64-bit one")
> introduced aligned_s64. Use it for all IIO accelerometer drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> 
> I debated whether to split this up by driver by the time we've done all IIO
> drivers that will be a very large number of trivial patches.
> 
> The changes are minor enough that they shouldn't present much of a
> backporting challenge if needed for future fixes etc.
> 
> I'm find splitting them up if people prefer.
> Next on my list is to look at adding runtime checks that the buffers
> containing these timestamps are big enough but I want this out of the
> way first.

I agree on all your points.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



