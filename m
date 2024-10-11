Return-Path: <linux-iio+bounces-10442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199CB99A0AD
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 12:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9531DB25A7A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F1420FABF;
	Fri, 11 Oct 2024 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+AFxo21"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14120C462;
	Fri, 11 Oct 2024 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640955; cv=none; b=skgyem2p5VSS+lxQdPsC9R7clvo/WYdhHTTS8XBWn3rgEiFR0nfJE8br2dnmK2U7n3wR0+0Kjre9dUEQBafK7TLoE6mdByAdTGGaJhpx1ONcV3FjMfGDBOMzmijEdxQJyeDmw031XPhzJA4GNJfmLMsEpclgKREIaSoAjO4X25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640955; c=relaxed/simple;
	bh=T0tmTAB1XyekMLgovaAbHec8vpXRNcZT0XgAyb1p2TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cn7DRm5Gp2u/IaSqWc4QPEJmax3O9f2UCJgyawRWeo/y5b/bSR7xBbZ0bAkRGZy/Sr+Rz+eNfOReI11WNj2LxLq9pFMH6rlg6/XtVTQjqLXdKhVUdRz/YTf8lpHZY3Xdi/0SCYS//YlVIlv2vgtwLq4OIyqQm+E3RWggTd33/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+AFxo21; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728640954; x=1760176954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T0tmTAB1XyekMLgovaAbHec8vpXRNcZT0XgAyb1p2TM=;
  b=l+AFxo21IgH2WLtnLvhzGiZbTPnl20lbBxjoL5xeTjM8BQDuRMVkOpQ6
   T7RJR2voJTvopM6fpaTJuXH6Fz7d9YOHm9RF1/sGgEEYmCiRb7noLv+om
   Gb72oWkYCOeVm4Qq0QtwQO2EeNjfE7SLvEayfsXWPNLBGbANe0v5fJc+c
   MGuPfvL1xixMYB6k7V+gSplfSfC6J1S2yFKxvlzAWaFnBqdnxif2m2vAT
   4jbkz73X8C2Qvt093FAjQwkCwTwmnO6KkaE1MPS6SuY2Q8MHMnhAIh5fP
   IE0mupS2/GNGrYEWGoOBZXw7oI0B7twCseeDhAMaXhPsGF+fhBL/loruw
   g==;
X-CSE-ConnectionGUID: 1beQBkOLQD6e1dvwtct2vA==
X-CSE-MsgGUID: /nvdlolfSmeFmG/SxKvYVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27980608"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="27980608"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:02:34 -0700
X-CSE-ConnectionGUID: dulfG7E0Szmu34coGVGl6g==
X-CSE-MsgGUID: ixduewCQSW6Wyc1oJbf2aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="77690291"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:02:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szCTc-00000001qq9-2GM6;
	Fri, 11 Oct 2024 13:02:28 +0300
Date: Fri, 11 Oct 2024 13:02:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: vamoirid <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/13] iio: chemical: bme680: refactorize set_mode()
 mode
Message-ID: <Zwj3tFd549K6ahbY@smile.fi.intel.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-6-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010210030.33309-6-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 11:00:22PM +0200, vamoirid wrote:
> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Refactorize the set_mode() function to use an external enum that
> describes the possible modes of the BME680 device instead of using
> true/false variables for selecting SLEEPING/FORCED mode.

...

> -	if (mode) {
> -		ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> -					BME680_MODE_MASK, BME680_MODE_FORCED);
> -		if (ret < 0)
> -			dev_err(dev, "failed to set forced mode\n");
> -
> -	} else {
> -		ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> -					BME680_MODE_MASK, BME680_MODE_SLEEP);
> -		if (ret < 0)
> -			dev_err(dev, "failed to set sleep mode\n");
> -
> +	switch (mode) {
> +	case BME680_SLEEP:
> +	case BME680_FORCED:
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
> +	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> +				BME680_MODE_MASK, mode);
> +	if (ret < 0)
> +		dev_err(dev, "failed to set ctrl_meas register\n");

This is an information loss. You shuld probably still have a value of mode to
be printed.

-- 
With Best Regards,
Andy Shevchenko



