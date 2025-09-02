Return-Path: <linux-iio+bounces-23636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66CCB40136
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 14:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164811770DA
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 12:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012D12D593B;
	Tue,  2 Sep 2025 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJEXki9K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442522D47FD;
	Tue,  2 Sep 2025 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817280; cv=none; b=gGcDieBxnrOvr90YNYQRmQHTsNDmZ3az9mtpfyQSTz1oDCnNc3kObL5Gm8XEshtD+BBZj/Ma3Tvz7JEnbbcF5Q5o2AAV7UMfS+3qCMpEUV8LeCiysjOxJzNTyTvQur79BFyujcTfshoOM5EdYwg+KZCkPeObNSzum4FaTtAcGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817280; c=relaxed/simple;
	bh=Kpa+Tue6cWwu0ubpWnl7iNvs6jWo/rXsL77LDSyUY58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBlpAZrf/1hOU1nlk35dtJC04xMTMklpD38MlMpCuDraTlC7IGR6A+JX6WO48lcXlDXt75BJyzMWrxZBJcvFmvxFxsiAyt0W185uc34Lv6VAUPurgwIbcAbKoc2XHAlM0EgtvfgL85++K5zDWzMEk6L0MDGyaevYsYoHrPozSnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJEXki9K; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756817279; x=1788353279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kpa+Tue6cWwu0ubpWnl7iNvs6jWo/rXsL77LDSyUY58=;
  b=GJEXki9KPsMDHx5EH9QAw1mDnIvGRVf6s6hVUyHTu3vDtiq6a3q6+zBQ
   IjQdCOiYcHYw4/+is+gAIGZAIlUu0VaZ5iCInW8wKo7AcCK/jesK0h9dX
   +PmjoMNwCCVVOien1nzrdsUJACAEyzlqtWIpi70J/uGLUUgop180g0/Cq
   Kz/m1x42mNwd6JUEog0dE3SAdq7q76ewOsN4lHhrofwIdxGWcbqQAnera
   SVBeQfrSS0/E+h+zU6kwwc+itWVO9UhJn4pP1DTirq8wU1hqALZYvim2v
   aImv9uJ7aLZVzl97OSkeeh7YZ2GW/hbjumhwr8+h/2naIaF8HwiWO8QLo
   w==;
X-CSE-ConnectionGUID: 5q+FacOlSTeFdgOBZq2EuQ==
X-CSE-MsgGUID: TVs3ppmQTfOHgyhHgC7fNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59154434"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59154434"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 05:47:58 -0700
X-CSE-ConnectionGUID: 1I3nBDPWRwWpfGQS2oXKgw==
X-CSE-MsgGUID: u8BSr4fyQG+xfSrLRH2RhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="175631961"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 05:47:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utQQS-0000000AhBo-1lM6;
	Tue, 02 Sep 2025 15:47:52 +0300
Date: Tue, 2 Sep 2025 15:47:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: dimitri.fedrau@liebherr.com
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chris Lesiak <chris.lesiak@licorbio.com>
Subject: Re: [PATCH v2 2/2] iio: humditiy: hdc3020: fix units for thresholds
 and hysteresis
Message-ID: <aLbneKXFd7Nc711T@smile.fi.intel.com>
References: <20250901-hdc3020-units-fix-v2-0-082038a15917@liebherr.com>
 <20250901-hdc3020-units-fix-v2-2-082038a15917@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901-hdc3020-units-fix-v2-2-082038a15917@liebherr.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 01, 2025 at 07:51:59PM +0200, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> According to the ABI the units after application of scale and offset are
> milli degree celsius for temperature thresholds and milli percent for
> relative humidity thresholds. Currently the resulting units are degree
> celsius for temperature thresholds and hysteresis and percent for relative
> humidity thresholds and hysteresis. Change scale factor to fix this issue.

...

>  	/*
> -	 * Get the temperature threshold from 9 LSBs, shift them to get
> -	 * the truncated temperature threshold representation and
> -	 * calculate the threshold according to the formula in the
> -	 * datasheet. Result is degree celsius scaled by 65535.
> +	 * Get the temperature threshold from 9 LSBs, shift them to get the
> +	 * truncated temperature threshold representation and calculate the
> +	 * threshold according to the formula in the datasheet and additionally

Replace "formula in the datasheet" by explicit formula

> +	 * scale by HDC3020_THRESH_FRACTION to avoid precision loss when
> +	 * calculating threshold and hysteresis values.
>  	 */
>  	temp = FIELD_GET(HDC3020_THRESH_TEMP_MASK, thresh) <<
>  	       HDC3020_THRESH_TEMP_TRUNC_SHIFT;
>  
> -	return -2949075 + (175 * temp);
> +	return -589815 + (35 * temp);

TBH, I prefer to have the proper units be mentioned in the comment along with

	return -2949075 / 5 + ((175 / 5) * temp);

5 itself can be a definition

#define ..._PRE_SCALE	5

and used everywhere.

...

>  	/*
>  	 * Get the humidity threshold from 7 MSBs, shift them to get the
>  	 * truncated humidity threshold representation and calculate the
> -	 * threshold according to the formula in the datasheet. Result is
> -	 * percent scaled by 65535.
> +	 * threshold according to the formula in the datasheet and additionally
> +	 * scale by HDC3020_THRESH_FRACTION to avoid precision loss when
> +	 * calculating threshold and hysteresis values.
>  	 */

Ditto. "percent scaled by ..." is much better to understand.

>  	hum = FIELD_GET(HDC3020_THRESH_HUM_MASK, thresh) <<
>  	      HDC3020_THRESH_HUM_TRUNC_SHIFT;
>  
> -	return hum * 100;
> +	return hum * 20;
>  }

-- 
With Best Regards,
Andy Shevchenko



