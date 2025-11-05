Return-Path: <linux-iio+bounces-25919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BE7C3648D
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 16:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175961A217AC
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569C333291B;
	Wed,  5 Nov 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+oL1EAo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D07332917;
	Wed,  5 Nov 2025 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355471; cv=none; b=mPzyc9DC73KPh/T6MY1HLOe6BcTxdxVcaPNw//PdP9JZiHwBuDtIOXKIXSzN1qKndXm1Hj1yJWIy7S964ICBArPMYfap+bNAOo9G2w7Bvx2Rr4Sk4FLxeT7Xv89pBi0j873moTspZx4Vm/Pl09AhwfSMS/QwoSH9XVqWKPxMKjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355471; c=relaxed/simple;
	bh=MfZhBVTlFRrSk30PCYslzy6b+4QV03SpIdNGJxCgc2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioeJpPBdFTaB994Om6n6rYlXZzrmVwBMFTcR1JK+Aoowz9MkaDTz+2ZsqyxhkB2qKx+Xt7aAtDd6Ov7vKh9QCh/oZLDSvaaF5iby3IW2EtgvM/slrvv0fPFp9T9B2PlmJ0HubwfbWE2A5FscS9MiV2Wyi0E92T2lypyylERMkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+oL1EAo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762355469; x=1793891469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MfZhBVTlFRrSk30PCYslzy6b+4QV03SpIdNGJxCgc2E=;
  b=e+oL1EAoV/UAYkMqBcrxX+aQ6jzTIKquEVeK4e4mUe9DCzQxCccuUkFc
   2+hxBis6wJHhyPzSaN64IkABCwgSXiCrRh1WGpz1N4Hnrxj14SArZe2wa
   ys1LWJjS8Kngfl+h3hDGwP0wzuFoysZENXSI7mRZ1S5kZGYazWo4cIymn
   YeohGO14Bi/7NA6tlthdUkef7I4YVMSoO7RiARWwMkV1pqGkAgArD1+0N
   SqpLsiRTuoscrNDIRc+d9Mv/BN9cF/2yCNFh4t7aqAN22uC5gHV00z5J1
   wu70s1fU5fv+p8ET37HzHZLfSkME3Hz+f4Yd3pjIjyu1pMxPZ2Oiaw3iG
   A==;
X-CSE-ConnectionGUID: 1C9T4QUMR9KcvYCbr2w1Tg==
X-CSE-MsgGUID: tb87mGoPQKugwYWJlkjeZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64386929"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64386929"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:11:09 -0800
X-CSE-ConnectionGUID: JzDi8kVsSz26hXCiHF1DFQ==
X-CSE-MsgGUID: lmj9NxLWR2S6UzIHjuhhrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187774857"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:11:05 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGfA4-00000005oyc-3rDG;
	Wed, 05 Nov 2025 17:11:00 +0200
Date: Wed, 5 Nov 2025 17:11:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	ramona.gradinariu@analog.com, antoniu.miclaus@analog.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH 2/2] iio: accel: adxl380: add support for ADXL318 and
 ADXL319
Message-ID: <aQtpBGJ0WyWbsQ1Q@smile.fi.intel.com>
References: <2b8fc2ea006d06660c83f1e9e1ccfc865803dafb.1762281527.git.Jonathan.Santos@analog.com>
 <7d990c72acca31b2fe6c7685fd13ef5284c7646f.1762281527.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d990c72acca31b2fe6c7685fd13ef5284c7646f.1762281527.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 09:40:34AM -0300, Jonathan Santos wrote:
> The ADXL318 and ADXL319 are low noise density, low power, 3-axis
> accelerometers based on ADXL380 and ADXL382, respectively. The main
> difference between the new parts and the existing ones are the absence
> of interrupts and events like tap detection, activity/inactivity, and
> free-fall detection.
> 
> Other differences in the new parts are fewer power modes, basically
> allowing only idle and measurement modes, and the removal of the 12-bit
> SAR ADC path for the 3-axis signals (known as lower signal chain),
> being excluisive for the temperature sensor in the ADXL318/319.

...

> struct adxl380_chip_info {

>  	const int samp_freq_tbl[3];
>  	const int temp_offset;
>  	const u16 chip_id;
> +	const struct iio_info *info;
> +	const bool has_low_power;
>  };

You can save a few bytes here. Please, run `pahole` to see ways to improve
the layout.

Other than that, LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



