Return-Path: <linux-iio+bounces-17886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC6EA82CDC
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 18:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46FB1B6396F
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 16:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA2226FDA8;
	Wed,  9 Apr 2025 16:52:19 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FFF26FD9E;
	Wed,  9 Apr 2025 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217539; cv=none; b=iPog1bDB9Vrzp/x8uO5PFg89JvAdUsJ6QPDJn160A/PNNVWetTRaA+StgfCWIXmQKfd4PGPVcUBixSDS7men146QpGLXz4dWjTEYT6pGqa0IHUZM0X4NkWMRZdETFelexNDBUbI28JX9nZWssje0IMbENto5DLr8RP0FtdyT1F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217539; c=relaxed/simple;
	bh=bvwQ472L379Yq6v8SYt72rXOtmKMPW+jU4BhUm1qzrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIMGINKvAZApqjjZpMQj2m6aODwwKOpRiKHamkkc2gNG5qe5uNFBiRq+gUBsMquC7h0RPwmL/54pyFjomzAxxHp6AFgS+eIEoUc6hp+F4ZvU5iE4a+Sf4WgyThqfjH6ztS2F5FEiNTOf459nHS8mY06KecnIqpiPSAmGyjY48bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: /fh3//y/Rsqyh0G2paCC3A==
X-CSE-MsgGUID: CG8aIYwiSz+cm2o5r8X0dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56370682"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56370682"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:51:53 -0700
X-CSE-ConnectionGUID: NlDWNtcXRfe/Sj85aIJBLA==
X-CSE-MsgGUID: QpQVxbbOTb+b3VLV6FuErg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="128617519"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:51:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u2YeS-0000000Anf9-2y49;
	Wed, 09 Apr 2025 19:51:48 +0300
Date: Wed, 9 Apr 2025 19:51:48 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/2] iio: dac: adi-axi-dac: use unique bus free check
Message-ID: <Z_alpFoaQQUlWdfo@smile.fi.intel.com>
References: <20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8ca0@baylibre.com>
 <20250409-ad3552r-fix-bus-read-v2-2-34d3b21e8ca0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-ad3552r-fix-bus-read-v2-2-34d3b21e8ca0@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 11:16:55AM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Use a unique function for the bus free check by polling, to reduce
> duplicated code. An error is always thrown in case of timeout.

...

> +static int axi_dac_wait_bus_free(struct axi_dac_state *st)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS_REG, val,
> +		FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, val) == -1, 10,
> +		100 * KILO);

Same comment as in the previous patch. Okay, it seems more than in the single
case. Perhaps to change that as well here?

> +	if (ret == -ETIMEDOUT)
> +		dev_err(st->dev, "AXI bus timeout\n");

Why do you need this? The error code will go to the user space at the end? If
yes, it will be enough to have it printed there, no?

> +	return ret;
> +}


-- 
With Best Regards,
Andy Shevchenko



