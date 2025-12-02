Return-Path: <linux-iio+bounces-26626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3610EC9BBA3
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 15:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACDFE4E37E2
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205143218DD;
	Tue,  2 Dec 2025 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEFrmFxW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9EE3161B5;
	Tue,  2 Dec 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764684678; cv=none; b=eLNxawWVfyOUereT/45+0SMm4PamFPg49+25byGLg5scht6yDeFM52AyP4ZGPisU5OQXWlEq1BTZ68MALWi5bBrq5vb3ny0kFBOVPGU/Vb0kmQgHC4J9gBJCkSOJVHTax8FIY+r0c8s8zAYjM1u865dLDn8zFnj8Xlc3gQiq5dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764684678; c=relaxed/simple;
	bh=/B6WbBoTH6f4pT6ZKB3o/VuoPJYDi5yrAIlcbeqMgVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUrgAevNAG9AB1x6IQ90Z+/EA7ilcvrOGImfV14Ity+7D/21M9QQhMgAziphIbjbvAl6frHHnEl4zLsLJhcjZak2/YSyKf6bvK8vt1KogKYslL+pb32zrG3EtfNk0D8IRUOreTX+Ff39g9/63WsrItFn0ypQGje11G9tWjaJiVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEFrmFxW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764684677; x=1796220677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/B6WbBoTH6f4pT6ZKB3o/VuoPJYDi5yrAIlcbeqMgVQ=;
  b=WEFrmFxWxYt8xUL5RGAC7jT+nK8IniwwK2uHevwVXWVDnQ2IY+mWn6+h
   B9vtTvJ4tnQgUtpt3ijBbMl9PaTKv2gyvhe+WFHmv6j+rTR31yxFII6+P
   pzNpUubPxTxrHtZifXjs/Rxwnhth8Njf/T7J1WI8IyV3Y1k4z0Xbhl3dw
   5OR2KarufMA6vd0aICVd3xspk+dGui8NLwer8bHLaODtd8iZSFCNBK5Sl
   bWcCnVFDJoL6ZISoD9jOBZoY87M766rpB+bcxlBdC5+N4fzcGDfb0MBBk
   ba1A5pNjLfV/9tdVlln6HhxLQePT/sB7n+KffKF1lhejdJNjXSpKGWUH6
   A==;
X-CSE-ConnectionGUID: FNsXugWtTEuiu0Yn8WX82g==
X-CSE-MsgGUID: cNLzthrOQu+75nEsE+T+sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="70501198"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="70501198"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:11:16 -0800
X-CSE-ConnectionGUID: GPnznjbJSBCxdCNUcGTSVA==
X-CSE-MsgGUID: C/qCpkLmT1m2MK3ukpig3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; 
   d="scan'208";a="194059918"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 06:11:13 -0800
Date: Tue, 2 Dec 2025 16:11:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad9467: support write/read offset
Message-ID: <aS7zf3ZGVEdTrNvF@smile.fi.intel.com>
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
 <20251202-ad9434-fixes-v2-2-fa73d4eabbea@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-ad9434-fixes-v2-2-fa73d4eabbea@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 02, 2025 at 12:53:09PM +0000, Tomas Melin wrote:
> Support configuring output calibration value. Among the devices
> currently supported by this driver, this setting is specific to
> ad9434. The offset can be used to calibrate the output against
> a known input. The register is called offset, but the procedure
> is best mapped internally with calibbias operation.

...

>  static const struct iio_chan_spec ad9434_channels[] = {
> -	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_shared_by_type =
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +		BIT(IIO_CHAN_INFO_CALIBBIAS),

Wrong indentation.

> +		.info_mask_shared_by_type_available =
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_CALIBBIAS),

Ditto.

> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 12,
> +			.storagebits = 16,
> +		},
> +	},
>  };

I'm not sure about macro-less approach here, I think that we want more
consistency and hence before doing this change probably we want to clean up
the existing macro, then split it to two, and add another one here based on
the low-level, which was split in the previous clean up.

...

> +	return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
> +				AN877_ADC_TRANSFER_SYNC);

I would make it one line, despite on being 85 characters long.
But it's up to you and maintainers.

-- 
With Best Regards,
Andy Shevchenko



