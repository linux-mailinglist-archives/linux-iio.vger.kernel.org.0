Return-Path: <linux-iio+bounces-21821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D78F5B0C38D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B46A1884FBF
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 11:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292CB2BF006;
	Mon, 21 Jul 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6rxNg3e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2A2BE65C;
	Mon, 21 Jul 2025 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098226; cv=none; b=DfaosuMBSjYg46cpc04I3wVDeTdR9B/53owSyYMYRAgXWiI9sT8lXXd7G6xcMwZHPZChWu1gl5e3rXRFKRf5wt6YjdTIuirqw5su3+Y185C8+grcGg2FQWt1wiuN2Gk1dj4NASCLHpJjkeXCQBpHEmrggvtWOnioM9X2iCGLR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098226; c=relaxed/simple;
	bh=E7JZML/DSqmAeDiUgFD6FwOcerC7aKGgGd+21Y5vB1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M73c4VJ9PlnxO3w9MwyhNWla5fuIDoIW8QYaxQxjj+mBZ1PeY31nKKEJxSsdgzOX3lDqwS2wzlSqDDvPcD2V5l0tCtdwQrPNFmpJsxKHtuzGwrYe/o94M08+T92SAx044Vj6auNPxb1yPyUU2UPzw3kiosE1u+qu8rOwJGXROi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6rxNg3e; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753098226; x=1784634226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E7JZML/DSqmAeDiUgFD6FwOcerC7aKGgGd+21Y5vB1s=;
  b=U6rxNg3eFFS1voeOYn+0Jo+1HIOMA6dGXFkjiVEz79WzHbxKchq6+tke
   95dJad54jqzwCEUeMzjIgXooZZa5dLd8YimMIGGPSOdL3s3NnbQJ0OfI2
   7aSG3yBMKUc0cybScTjeaJqMJmH9Cw5Vcw3wfCfh7nvYJsa30vK2uscxs
   G3MpIIFo0J1U5vD7LW7m7F26OW72HOTni5IHyAv+xEjnxeewhsQeq+ECL
   +OdL1qVa+HlkQGtDzwmAimRFxwgTe2bb6y8h/VvlBDM0nY4nmm54mJ7Ko
   hzigw9573NtFCETVBsvbsfQdMta4wU+S6UGWdXJmkIBTYrRo063AqxH6a
   Q==;
X-CSE-ConnectionGUID: bWi7SvFIR1WmKUdC9beN1A==
X-CSE-MsgGUID: s3liG3FDQAiLSFAyTCYldw==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55190282"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55190282"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:43:46 -0700
X-CSE-ConnectionGUID: l2EnZGPbRCuKAMgQuiGhtw==
X-CSE-MsgGUID: +eSs64p/REmGNdBWbYIJgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="158878641"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:43:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1udovj-0000000HKRU-0mAT;
	Mon, 21 Jul 2025 14:43:39 +0300
Date: Mon, 21 Jul 2025 14:43:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, dan.carpenter@linaro.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, Markus.Elfring@web.de,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 1/1] iio: adc: ad4170-4: Correctly update filter_fs
 after filter type change
Message-ID: <aH4n6kMQAN1zZP_V@smile.fi.intel.com>
References: <1c354ff9f41ff964a66ece44b0d356e0bda3d210.1753024756.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c354ff9f41ff964a66ece44b0d356e0bda3d210.1753024756.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 20, 2025 at 12:37:24PM -0300, Marcelo Schmitt wrote:
> Previously, the driver was directly using the filter type value to update
> the filter frequency (filter_fs) configuration. That caused the driver to
> switch to the lowest filter_fs configuration (highest sampling frequency)
> on every update to the filter type. Correct the filter_fs collateral update
> by clamping it to the range of supported values instead of mistakenly
> using the filter type to update the filter_fs.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/linux-iio/c6e54942-5b42-484b-be53-9d4606fd25c4@sabinyo.mountain/

You mean Closes: here?

> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Fixes: 8ab7434734cd ("iio: adc: ad4170-4: Add digital filter and sample frequency config support")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

-- 
With Best Regards,
Andy Shevchenko



