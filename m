Return-Path: <linux-iio+bounces-9087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA5E96A633
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 20:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238DD1F24D56
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 18:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE249190047;
	Tue,  3 Sep 2024 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMnnm3Zl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AA218DF78;
	Tue,  3 Sep 2024 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386971; cv=none; b=AXwTirv+qDHpRQ7TCLP4PI9xuT8bS9LY63pqcqJ44/+0l9QEF4IOqyzq0uXJ2+PgwZyybPrbReWZgKwm3gfI67+Pmt/Y8KUnAgfm27naRxJI/FqiAhCGROLwLzBhBfUqYZdDXBj2+4ky9mLnnuWSLW5ofCNG80ssVLmUnRq67P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386971; c=relaxed/simple;
	bh=1/wa6dmOiQR2kuGnKHwGR3pQ3U7BTwDOhzLIzse3DPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=up8z06GR+Xc+FmssusoCCFx4zl6D1mpwlgs8LhOGJeSgXLbpwd9gXoJiBCTCGf3ZnK2eUU3YmRPPdZ+jVZAZjjaEf/oLNVyWRQ5Gev7tH2HqKMvmYKsG8ZEo3xx+G1qSiJf9hgDDNdpdtuhohQRMmlV9hwWGp+I8+zTvMtv1/kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMnnm3Zl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725386971; x=1756922971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1/wa6dmOiQR2kuGnKHwGR3pQ3U7BTwDOhzLIzse3DPM=;
  b=lMnnm3Zlby4poQJjI8GceK9wFUi218pIJxHDi7ihmZtguqs0KhxPxcPi
   Vxmi+pYKx0d28DjbMyd7+9ev0rEbK9qCNPlsIVOKgGlyU4naTYG9371FH
   LPCrHV5/UX60SZJ/W9jJa8d93vK2WXyVFUHFdvWGsFrIeXb7SuHikX4v3
   zboupbLYYs5NoEA4nMxIhcF62v8CHoDKjtlkAlZLpslXyws5vlby5pVmm
   n58KGeJZQhRYJ/cdEpAJdZ7OdEcEvOpsaIQCz0G/fiKtBtcvpamdF2+ZQ
   QhxV3nd7ZT4OGqaWwpsoUDgZxyUZrTuzuM+dXACvl86GhQqIqWoE+vvGT
   g==;
X-CSE-ConnectionGUID: 4ACzHa1eQe6c6yVhzHFFWA==
X-CSE-MsgGUID: 7ZOHaDWwSRWhLiKhjwx4TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23571444"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="23571444"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:09:30 -0700
X-CSE-ConnectionGUID: z7Nx9V2KTfeoEKSgqH5d2g==
X-CSE-MsgGUID: jlzMR6hsSoCPu7drFJwQRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="69616555"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:09:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slXy0-00000004ngi-2Pk5;
	Tue, 03 Sep 2024 21:09:24 +0300
Date: Tue, 3 Sep 2024 21:09:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v2 2/3] iio: imu: st_lsm6dsx: Use aligned data type for
 timestamp
Message-ID: <ZtdQ1JsSlUxehQkm@smile.fi.intel.com>
References: <20240903180218.3640501-1-andriy.shevchenko@linux.intel.com>
 <20240903180218.3640501-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903180218.3640501-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 03, 2024 at 08:59:05PM +0300, Andy Shevchenko wrote:
> Use __aligned_s64 for the timestamp field.

Oh, heck. I forgot to change the commit message...

...

> -	/* Ensure natural alignment of buffer elements */

...and for some reason this haven't been updated to be not removed.

I have updated locally, but will wait for other comments, maybe it's the only
problem and Jonathan can fix whilst applying.

-- 
With Best Regards,
Andy Shevchenko



