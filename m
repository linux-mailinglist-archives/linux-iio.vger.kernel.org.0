Return-Path: <linux-iio+bounces-8878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C4596452D
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 14:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E371F24504
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3F11B3741;
	Thu, 29 Aug 2024 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOKVHs2k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C971B3734;
	Thu, 29 Aug 2024 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935330; cv=none; b=gu8McjCuC2Y72Xcck38yx+IBdW5RkBm1HzinpzYbNljtnEWsoFlmBiRcM2KEnzpyDnskWeGO/Fn6jLB3X9EoBao0wlDj913sCRBcvQBRhX45Ha0gjTr5ea9Jgn50kUNu0tDAEZvCu3ewXVvYpiVawiZueB6GsDn9a4GdtwN2Qcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935330; c=relaxed/simple;
	bh=uFyDqbSSUEToSH8ps83mcK5RmVehkx0W0ax8lXFIm8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsJDsA8pTe/sK4ZDCWUcu/HirX4lN8SWAUtUH1WWfRnM3X4Ls8YdDomTZKv/PJ7YdNNVtsQnkJDyJPtDUlXqUhzhsefgNJZM4VcBhYB6v5ye7m2tbKF8b0sm4c4WdF0/EIjAzMD1Vcq46LV2/OelJQQRrRFPOFl8nG1BNfucTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOKVHs2k; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724935329; x=1756471329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uFyDqbSSUEToSH8ps83mcK5RmVehkx0W0ax8lXFIm8I=;
  b=bOKVHs2kJT8DPX3+tKR3SjkrzxHoj1SRozuYGbtkSjjIp3fXx2ahFKKc
   MWPoDMHr+OP75QucN5vzrdGQiJkbLSwJQdhU/nNShfWgbHyQNAtUZKtLK
   SqLRUidyiuYsHLwtbzejjqPSu70dGtCowRbnUpUP06FMW+/YITKKYRE9j
   VJrzYo//4JwBWFxDwSB8eCrX9Y59tTPvZC7C2wmA5xRzcgO6KhlP1BhDB
   Tv7WWiR5h/BydmGfSrpo1jIvZqfCfXDuLx5XR4rGBEUROE9iZ32E0ZHPl
   clupUP7qREXNAtX0DHd2UeHpph+1KZrF8UTlE3tIaRLRA+0X65/R8vm9M
   w==;
X-CSE-ConnectionGUID: I3u1ZsRFQKOAkbZoNHZsfA==
X-CSE-MsgGUID: ty/uRIfUQp+kwRG9GKstUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23097986"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23097986"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:42:08 -0700
X-CSE-ConnectionGUID: 190mgRs/Q22/X28t55szjg==
X-CSE-MsgGUID: WjAa+EHxQmaqnq/o5eUgQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="94363347"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:42:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjeTR-00000002zo8-3Clb;
	Thu, 29 Aug 2024 15:42:01 +0300
Date: Thu, 29 Aug 2024 15:42:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 7/7] iio: pressure: bmp280: Move bmp085 interrupt to
 new configuration
Message-ID: <ZtBsmSGWLhNe8_Zw@smile.fi.intel.com>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
 <20240828205128.92145-8-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828205128.92145-8-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 28, 2024 at 10:51:27PM +0200, Vasileios Amoiridis wrote:
> This commit intends to add the old BMP085 sensor to the new IRQ interface
> of the driver for consistence. No functional changes intended.
> 
> The BMP085 sensor is equivalent with the BMP180 with the only difference of
> BMP085 having an extra interrupt pin to inform about an End of Conversion.

...

> +static int bmp085_trigger_probe(struct iio_dev *indio_dev)
>  {
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +	struct device *dev = data->dev;
>  	unsigned long irq_trig;
> -	int ret;
> +	int ret, irq;
> +
> +	irq = fwnode_irq_get(dev_fwnode(data->dev), 0);

You have dev, use it!

> +	if (irq < 0)
> +		return dev_err_probe(data->dev, irq, "No interrupt found.\n");

Ditto!

-- 
With Best Regards,
Andy Shevchenko



