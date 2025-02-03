Return-Path: <linux-iio+bounces-14895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FE3A25656
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 10:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16353AA0C9
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFBA20100D;
	Mon,  3 Feb 2025 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5hclTXt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415211FFC57;
	Mon,  3 Feb 2025 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576378; cv=none; b=RkA/ExFcK9WBELGODPB2hpOL1TEzVnEx2TTmqh+twXKL+CCvNaW04KrQyjdzieXT5gCId8fCLFbZwVENSoKa+mdcivenRtc8xZam+5jhsKeIkaGK4W0E7mKNaNDidzGQzrVVETH5wImPTx23+I7RsHbJ4e5JhvRYtY+wWOoOqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576378; c=relaxed/simple;
	bh=IwEB0X9EljviHZkyF5ykgt1FPvUDJvDoPYZhkdLnirI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=On1vcTO9MBaJ9SaI59gtU9PCppzvv3tY81GX0JeRnXaPZT6z0h7cP4o5QfSsr5L0dWGLK2Sc6bm43qx9DS5+FUr84rVqhbmlEpZ4vW13GuzMUl20+GcIEW0XJuPa2kuVfHa4Viv1+bKvD3J2jKK/LRVGf6cvnPy+3/b+w2kmrEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5hclTXt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738576378; x=1770112378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IwEB0X9EljviHZkyF5ykgt1FPvUDJvDoPYZhkdLnirI=;
  b=i5hclTXtpuLEQC8UEqH1O8zNiCE0CFv6idBr9fOdD++bi7zYdDsUD8Y0
   f9zLY3pTXmcJNGFhY5sJnnDFty6FSm9sBLuOMFEyLgcejMWx5tTfJvUQS
   sXSE3mPj5A0c3Mtt+Qn63OBFwVMxasJ3DTNZYTMCpNsttKqEFwcDAj0wi
   o2t5XI9YP7/AxJD7JSPWVfxjaMdhynu9EkhebtCeFP5bie07mhcdIKtgT
   EcxRG3dOi58fRdTCpBcg7RJ/etek3gVmXCmOGqvAoJ7mmE/xFndyKOHMa
   en86OiF2jpzJs757Civ2d45CvobpXdb7DNyBGCVckE1r3frNzPUWcf+ww
   g==;
X-CSE-ConnectionGUID: fjQH/n1sSCGAeWyAt24Wow==
X-CSE-MsgGUID: J+GxMgnHTbe0MwTsjpTrLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39162950"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39162950"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:52:57 -0800
X-CSE-ConnectionGUID: 1pCxlRJFTwqNO0HyrOBzyg==
X-CSE-MsgGUID: 4Wfyl2TjTjS112fF6SSpvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="115254034"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:52:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tet8M-00000007n2F-0ius;
	Mon, 03 Feb 2025 11:52:50 +0200
Date: Mon, 3 Feb 2025 11:52:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
	jic23@kernel.org, przemyslaw.kitszel@intel.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 17/20] ASoC: tlv320dac33: use devm_kmemdup_array()
Message-ID: <Z6CR8Yo0k4jNdjZJ@smile.fi.intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
 <20250203080902.1864382-18-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203080902.1864382-18-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 03, 2025 at 01:38:59PM +0530, Raag Jadav wrote:
> Convert to use devm_kmemdup_array() which is more robust.

...

> -	dac33->reg_cache = devm_kmemdup(&client->dev,
> -					dac33_reg,
> -					ARRAY_SIZE(dac33_reg) * sizeof(u8),
> -					GFP_KERNEL);
> +	dac33->reg_cache = devm_kmemdup_array(&client->dev, dac33_reg, ARRAY_SIZE(dac33_reg),
> +					      sizeof(u8), GFP_KERNEL);

sizeof(*dac33->reg_cache) ?

>  	if (!dac33->reg_cache)
>  		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko



