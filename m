Return-Path: <linux-iio+bounces-26698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8278CC9FFCD
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 17:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51E433000B61
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79691334C36;
	Wed,  3 Dec 2025 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Na21dhxd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A35335BAD
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779057; cv=none; b=T37ncM9PgjrG0C9tEYunahkBy6S5aK/qs24rujj5LzUrRK+glOTla04v3xnrHnIwrIVgcHMlL/an3dJfTmu8OhSMyR8r7scwPck61Q4JRtICI3K09bWL1e+hVvIeKBZIaBSBJW7rzXysS/KjB5XLYF1d/iOcjKXzC7E+gFd5xhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779057; c=relaxed/simple;
	bh=V4YtWVmJnX3TMduvIUUPT7oTz/SHQERlUnBmeGRh0/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/y5pEm00NoCMkeog7Da5hyQzwhZ7H7tV50Zgx4zBy5kRJZj4Lm9nc+vncDCWXqMofOH0x0rmIxa8qI/KqUiPxgBDLj3wARp61r/kKhvndgUkVe2dP/MPBD+nzYqilJnZGHXp+RGXg9TC7J1p0wXi6EYUzp3R17Az+14I21qbas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Na21dhxd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764779040; x=1796315040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=V4YtWVmJnX3TMduvIUUPT7oTz/SHQERlUnBmeGRh0/I=;
  b=Na21dhxdYIUe3oOxpz9wMOpyqIG7TzprtLvWgCS+ZavXkdeYzb/AQJD2
   Z3Nq8PDqsbtnRgXrPAs5xcF2/NE8QCTMhXSsxGQjy8XSTMBC5Q0aclpUt
   25wEf8Ab4Zx6l0gbwfIZVG/gSYijqVxLuzkRN13GfTAP7WB6ByGvbrLL4
   Xv14+X+YB0f/2AdfpaoKwIJi+lQxwr4VUDiKKqBT3O2bKhSZHHtekHJP0
   +I3XFZd2BXfwPWFhqHU1u0yUAO7DNdz3ivF/o56KkyiQrFI7OnXG9Jd9e
   VmKjK06iiiI6vTVHhAvp5UXna0wK6XeZqy4cnHsFh1xLdgaxb5ApBRkoi
   w==;
X-CSE-ConnectionGUID: inmQby+HQMq2zGtuNitfDw==
X-CSE-MsgGUID: 279ZNmPATSqe5t+2JQb+tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84376981"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="84376981"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 08:24:00 -0800
X-CSE-ConnectionGUID: 3Z3HNfzOQfeP8i3tJzH+Pg==
X-CSE-MsgGUID: tm/36oJORKu+FbLCuDP06g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="225681302"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 08:23:58 -0800
Date: Wed, 3 Dec 2025 18:23:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 2/6] iio: buffer-dma: Use the cleanup.h API
Message-ID: <aTBkHIq-SL26fABN@smile.fi.intel.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
 <20251203-iio-dmabuf-improvs-v1-2-0e4907ce7322@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251203-iio-dmabuf-improvs-v1-2-0e4907ce7322@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 03, 2025 at 03:11:37PM +0000, Nuno Sá via B4 Relay wrote:

> Make use of the cleanup.h API for locks and memory allocation in order
> to simplify some code paths.

...

> -	struct iio_dma_buffer_block *block;
> -
> -	block = kzalloc(sizeof(*block), GFP_KERNEL);
> +	struct iio_dma_buffer_block *block __free(kfree) = kzalloc(sizeof(*block), GFP_KERNEL);
>  	if (!block)
>  		return NULL;

In another thread I believe you referred to the 80 rule.
Follow it then :-)

	struct iio_dma_buffer_block *block __free(kfree) =
		kzalloc(sizeof(*block), GFP_KERNEL);


-- 
With Best Regards,
Andy Shevchenko



