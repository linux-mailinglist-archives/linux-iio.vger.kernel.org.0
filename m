Return-Path: <linux-iio+bounces-20588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 559BFAD8C66
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 14:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F583189B5BF
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 12:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2EC1D540;
	Fri, 13 Jun 2025 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNVyzyV4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC811A26B;
	Fri, 13 Jun 2025 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818697; cv=none; b=T6UoLRpsj8mnulo2js8VK9Lo5Pl7PMWdplYDHeEzb3JXGI36/HamyCpKIRzGWbjOV0tFzqy1fUxnVxLNm89qnKEMQINvPXsT+BvPtfZN5xKEu7MsPzDWLtEbpBcug94qLnPZBIS0qJZRrnc60SQFC3TqRZkq9K8aGQ6asWEtn0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818697; c=relaxed/simple;
	bh=GPw91za6IHfKe8r3RhbgSIhiZUxxRVY8xtdbMApddd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1zKNhp+x/bb1SViRFWMFRinfIyf18/s65axCmCKCgRjZHBvJNamZTlU/Gy5jKaa5+utO4A2jqXgzPjYT673rXjmw4OA58jBv1ymUQU0xz63hNiM8krwKTmos9RTPcasbdFiOt4Z3WUCGbjzFd4oPXG8C0XZilATN+0xQZ0SaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNVyzyV4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749818696; x=1781354696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GPw91za6IHfKe8r3RhbgSIhiZUxxRVY8xtdbMApddd0=;
  b=RNVyzyV4j9Y665yz0TVgB9C51tfe0GJo999N3v7IPno7hhifbKI4oZ+J
   wZTxIE9wqa5MH6OQsXHVyIMmnGY7kdK3oK+VHmai20xurLUakSdpFfDSs
   0c7/LyP2OOlLiMYaJcyopZUo9DMzGIAzYdvtbGsOSA59mwks7jdfn29ey
   DbYLC6t9BRQczpLfjXapZA30vC5h+h8un3k0fUBPG+XjoM8Xe3CJIDOkO
   SHQEYLBNKubnwqrOxBnTBHbm00ipqyirV4fTGkT6yJiLyhfm2tpOTlUn9
   8CF+UCgwTDfPeW20/pug/64IcWK69coZM6jTR4R19BaDMJEziQ/wxGkiP
   A==;
X-CSE-ConnectionGUID: lugpPHKuT8OXmc9qM2iEuA==
X-CSE-MsgGUID: 9hk6MY5vSvOwYinNvRYyzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="69611571"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="69611571"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 05:44:55 -0700
X-CSE-ConnectionGUID: taZWvf/qTdKq+JF+xbTCSQ==
X-CSE-MsgGUID: SlAOA12rRg6FJNB4yvqcBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="148291864"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 05:44:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uQ3m3-00000006FLN-2zqd;
	Fri, 13 Jun 2025 15:44:47 +0300
Date: Fri, 13 Jun 2025 15:44:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com,
	Pop Paul <paul.pop@analog.com>
Subject: Re: [PATCH v11 10/11] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <aEwdP9Tu4TvguUmI@smile.fi.intel.com>
References: <cover.1749569957.git.Jonathan.Santos@analog.com>
 <cd3b60c44847d5c35cecc4385bbda6533be6825e.1749569957.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd3b60c44847d5c35cecc4385bbda6533be6825e.1749569957.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 11, 2025 at 08:51:50AM -0300, Jonathan Santos wrote:
> Separate filter type and decimation rate from the sampling frequency
> attribute. The new filter type attribute enables sinc3, sinc3+rej60
> and wideband filters, which were previously unavailable.
> 
> Previously, combining decimation and MCLK divider in the sampling
> frequency obscured performance trade-offs. Lower MCLK divider
> settings increase power usage, while lower decimation rates reduce
> precision by decreasing averaging. By creating an oversampling
> attribute, which controls the decimation, users gain finer control
> over performance.
> 
> The addition of those attributes allows a wider range of sampling
> frequencies and more access to the device features. Sampling frequency
> table is updated after every digital filter parameter change.
> 
> Changes in the sampling frequency are not allowed anymore while in
> buffered mode.

...

> +	/*
> +	 * The SINC3_DEC_RATE value is a 13-bit value split across two
> +	 * registers: MSB [12:8] and LSB [7:0]. Prepare the 13-bit value using
> +	 * FIELD_PREP and store it with the right endianness in dec_rate_reg.

FIELD_PREP()

> +	 */

-- 
With Best Regards,
Andy Shevchenko



