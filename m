Return-Path: <linux-iio+bounces-26675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 968E3C9F04D
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 13:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB38D348688
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 12:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CFF20468E;
	Wed,  3 Dec 2025 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BbqyF9Z6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA2C381C4;
	Wed,  3 Dec 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764766124; cv=none; b=tEhq1RHYF69OnuPJr+3FWvrFLylI0OXWWvz656+kLwQ9n++oeixERJ38YbQZcO6178rT8pBISXIDmtUkoUuIuEs/XUem7TqLCDYaTc8ssc+SSYTK1YwCfLlIdCmrDjGCpBE1vv06f6e5740Y4FXqH2VukxkwFs2M2iFdpvg9vnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764766124; c=relaxed/simple;
	bh=syewof47MsH2g49Of75yxcWAs8YQcZprEM1Gcxb2X18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTzuBtFUOr3q+qfwRmY5iVqKdS/FTg9Mnwb4P59rqCDo04aYNW1GaG9/g8P4+lIQ2DHl7zWjrqrERwjtHyw88whbOz/HAPUjDaaJBD85LtpZTtFh/+/qRdrKVUoWbxNtEE9RXfuSvrdDJQZDXq7LFsc2no9liNwHPxvHX9cCO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BbqyF9Z6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764766122; x=1796302122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=syewof47MsH2g49Of75yxcWAs8YQcZprEM1Gcxb2X18=;
  b=BbqyF9Z6EspMsjl9Cr4B04tt4o3eFFwITk2pn5e5Tv6t2SVaKjOg/a+6
   WkDKoNWdBA8d0HYeBnUKZEfleKNMQnsLJpOquK7fl/SjTZkVhyoEE1SXa
   cQdd/vWXnay+HMQYLxDUo3JNpPLJzJf4ahPy22IrHO3ye2X/QfxD9c1X5
   WqB79qLZONwX7H+ofPljJ8ivwH2kCOttryJtRz/6jt3s8c7RxVpGFLjFd
   0yg4lPf6PeFr40ZKek1KKZ1HS0WGGmvpzinBiB284fQ7Cjwx133M0GcW6
   HSdBEYMvp/Z5G95UW/UBLfnqWrQ+wWRFAEZU7VsuHnAyhU4RVRaN/eFf5
   Q==;
X-CSE-ConnectionGUID: LiTmk1NsSsqm6ItXCFCSXw==
X-CSE-MsgGUID: IOQwLklOTqOr8OxuNE1Fsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="70607500"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="70607500"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 04:48:41 -0800
X-CSE-ConnectionGUID: wxBNESYQS1auwqG/ZV2apw==
X-CSE-MsgGUID: 9kK+3tSdSy6UipPHpcKUyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="194482640"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 04:48:38 -0800
Date: Wed, 3 Dec 2025 14:48:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad9467: add support for ad9211
Message-ID: <aTAxo5sM90vwgxTT@smile.fi.intel.com>
References: <20251203-add-ad9211-v1-0-170e97e6df11@vaisala.com>
 <20251203-add-ad9211-v1-2-170e97e6df11@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203-add-ad9211-v1-2-170e97e6df11@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 03, 2025 at 12:20:34PM +0000, Tomas Melin wrote:
> The AD9211 is a 10-bit monolithic sampling analog-to-digital
> converter optimized for high performance, low power, and ease
> of use. The product operates at up to a 300 MSPS conversion
> rate and is optimized for outstanding dynamic performance
> in wideband carrier and broadband systems.
> 
> The scale table implemented here is not an exact match with the
> datasheet as the table presented there is missing some information.
> The reference presents these values as being linear,
> but that does not add up. There is information missing in the table.
> Implemented scale table matches values at the middle and at the ends,
> smoothing the curve towards middle and end.
> Impact on end result from deviation in scale factor affects only software
> using it for scaling. All the possible hw-settings are also available with
> this implementation.

> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf

> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>

...

> +static const struct ad9467_chip_info ad9211_chip_tbl = {
> +	.name = "ad9211",
> +	.id = CHIPID_AD9211,
> +	.max_rate = 300000000UL,

It's too many 0:s. Less error prone is to write it as

	300 * HZ_PER_MHZ

> +	.scale_table = ad9211_scale_table,
> +	.num_scales = ARRAY_SIZE(ad9211_scale_table),
> +	.channels = ad9211_channels,
> +	.num_channels = ARRAY_SIZE(ad9211_channels),
> +	.test_points = AD9647_MAX_TEST_POINTS,
> +	.test_mask = GENMASK(AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE,
> +			     AN877_ADC_TESTMODE_OFF),
> +	.test_mask_len = AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE + 1,
> +	.default_output_mode = AD9211_DEF_OUTPUT_MODE,
> +	.vref_mask = AD9211_REG_VREF_MASK,
> +	.has_dco = true,
> +};

-- 
With Best Regards,
Andy Shevchenko



