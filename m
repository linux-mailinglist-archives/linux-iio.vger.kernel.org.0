Return-Path: <linux-iio+bounces-25729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB48AC24649
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 11:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08D518879D7
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA115337108;
	Fri, 31 Oct 2025 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOHff1DU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CBF336EEE;
	Fri, 31 Oct 2025 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905629; cv=none; b=UUwtqxpZTLRbRsEhvU62uIqOOtBdXEKXUvGFwNgSunm4tRCu8E60vFugls/VmAVbsdbMA9YNlOpqhsgZYorvo/1UV5rc3D8zM/SPKJODJxqtJujwUqL4WoqF3esMDcA2YEE3pBTO2PP15EwsAxkE0rD9y99MVMm5ibRsuZ5bss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905629; c=relaxed/simple;
	bh=j1jjnwDIh5t39z7XcYR7u4oLR3Jy9sTKHizlMRr8z+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1bnxyl/+rUi74iTzW6WKMpg1rdd6f5syUuyuW6KyrwkePTQVT4nLvbYMtt7bUzloBaO8y//MwGByJxmRN4OFS3Dc64Mlzra0YPMGjpcQr+imNfktPcXDJpvYVUXQx0FEkMJp0fbUGtz2IxuDFleP31mvg9dloyLzhzT2FkdNMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOHff1DU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761905628; x=1793441628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j1jjnwDIh5t39z7XcYR7u4oLR3Jy9sTKHizlMRr8z+Q=;
  b=FOHff1DU7eqQzM3eVWvaR9wlyR5udglSetKcU4pweRMw8v8XIrAG9QKs
   dUOo4IFs3dvASFOnGDEbU01961ZjgmF/h1UeBQ57ewOEd6tOWt9iFt2lE
   8dPcC/LscyhD9i6MlEOncTtBzafwluOr1FPCEKil7kdPWjaxpJ/Gql8Y4
   xcuRZATdwxyR4s3wljQ36+LtIvFdJW9VDZ+jdKOkPYbdbmwxRiETTyP70
   q7ZdSao1QJMct56pmjLp6Lag1DfcYU1wwoo922SdaVNIG7RE2eW2LHtph
   EgW/TO2zaVL7PEHgoRtxKzbsqlo9p79uhdEDCEdaUoGvQPSW9sWnHsttu
   g==;
X-CSE-ConnectionGUID: pWe0dcH8R1++Gki+HxlovQ==
X-CSE-MsgGUID: PykOsH5TTHCocq3HWus+mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64163390"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="64163390"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 03:13:46 -0700
X-CSE-ConnectionGUID: XtNKVTXjR/6tWVY+YomUTA==
X-CSE-MsgGUID: j445RgFrTFeePPFGCO4Utg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="190551159"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 03:13:44 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEm8a-00000004EWX-0pWz;
	Fri, 31 Oct 2025 12:13:40 +0200
Date: Fri, 31 Oct 2025 12:13:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, gastmaier@gmail.com
Subject: Re: [PATCH] iio: accel: Change adxl345 depend to negate adxl35x
Message-ID: <aQSL0wCr56zr5Y35@smile.fi.intel.com>
References: <20251031-adxl345-allow-adxl34x-mod-v1-1-cd65749ba89c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031-adxl345-allow-adxl34x-mod-v1-1-cd65749ba89c@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 11:05:08AM +0100, Jorge Marques wrote:
> Change 'depends on INPUT_ADXL34X=n' to '!(INPUT_ADXL34X)' to allow both
> drivers to be compiled as modules. The user then can use the blacklist
> to block loading one.

> ---
> There are two drivers for the compatible:
> 
> - adi,adxl345
> 
> * IIO: 
>   drivers/iio/accel/adxl345_core.c
>   drivers/iio/accel/adxl345_spi.c
>   drivers/iio/accel/adxl345_i2c.c
> * Inputs:
>   drivers/input/misc/adxl34x-spi.c
>   drivers/input/misc/adxl34x-i2c.c
> 
> To disallows both being complied, the depends INPUT_ADXL34X=n
> was added to ADXL345 symbols. However, it should be possible to compile
> both as modules, then blacklist one of them in the /etc/modprobe.d/blacklist.conf
> file. This patch changes the rule to !(INPUT_ADXL34X) to allow both as
> modules, but still disallow INPUT_ADXL34X to be built-in and ADXL345 as
> module.
> 
> The following compatibles are not shared between both drivers:
> 
> * IIO:
>   adi,adxl375 spi/i2c
> * Inputs:
>   adi,adxl34x i2c

I like the idea, but I think this needs to be clearly stated in the Kconfig
help for both symbols. So user will _know_ that in such a case it's their
responsibility of properly made choice. On top of that you might want to
investigate existing DTS in the kernel and see if some of the choices may be
made at the platform / CPU level.

-- 
With Best Regards,
Andy Shevchenko



