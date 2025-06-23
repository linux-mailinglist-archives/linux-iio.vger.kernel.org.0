Return-Path: <linux-iio+bounces-20889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6359BAE3662
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 08:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EC416488D
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 06:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0651EEA5D;
	Mon, 23 Jun 2025 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgngnHFL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4218E1F;
	Mon, 23 Jun 2025 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661873; cv=none; b=m2bhRX359OFpJ7cTKjrB+CzAZKjPWCsw/5te3qs2/BmAYNNdHEGIWb1RlMYtcqfd4BEGIu/ntCK2LQFBflJKvgAF3Hj0QbPXFfMs8tDGmDgiPf5N88wPSH/JdeVTLqjc+xWV2UWuASURbqdUTwpAIoxFaFCXwFkwjJz52yTyw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661873; c=relaxed/simple;
	bh=nCOYStVDn/QLpiamVTaBCoFBS7vUHt5RwUh68OFIYOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkLLnNa6SuVsII1o3yn+DIqKltkCxxiGD8OUCKP7otVAeuoBBrN9S9PSoYOsLx8WqMC12bned/lYIMuGqjtPwE8iRROODW7/kWZ2ngvi9MKxBPZCkmzW4pk41UJsB331K1gXmg9g/p+SnxiZuJl3j1U/oCEXO5xlRes7bZK1fEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgngnHFL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750661872; x=1782197872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nCOYStVDn/QLpiamVTaBCoFBS7vUHt5RwUh68OFIYOE=;
  b=mgngnHFLWDO+FPA948i/3X1LoeQF8Ov/mWu8iEcsQ+l8SSB5NCKZk0Te
   +cJKzYik/rIvF0bju0V23o9F0sE6jpgAqlV+SnS727bQB0buFEAKT+MOZ
   Entt5000vk47puDJCAifHPHBO3fopFKTWFk4SMmyc/ezM5KNIqNvSr0mY
   QVQ5clxIRrusRL9IXGEFPDPA2xA9FIcxITfLz7aUPDYIDtBuUnHt2QEA0
   euQEUPy//WHCMjKoinsZJPpIvaXCRKhLF4XMNS+2oGcfZwRctnXn4WGef
   STlC+pOrUHzw28WsuELEzvijW41t432orHv4awqcqKdKNthC4Gp2WSK1l
   g==;
X-CSE-ConnectionGUID: 6g7vPuuBRySAwQDccdVU4g==
X-CSE-MsgGUID: Wid1REBSRxC+0841LvrYlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="40462500"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="40462500"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 23:57:51 -0700
X-CSE-ConnectionGUID: Kez78y6WTd+PYIxkJoywHg==
X-CSE-MsgGUID: qkXQ4/6pR5SDKnShzSzZsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="175111836"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 23:57:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTb7h-000000095Yo-4212;
	Mon, 23 Jun 2025 09:57:45 +0300
Date: Mon, 23 Jun 2025 09:57:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 5/9] iio: adc: ad_sigma_delta: use spi_optimize_message()
Message-ID: <aFj66Q_TmufwDhyW@smile.fi.intel.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
 <20250620-iio-adc-ad7173-add-spi-offload-support-v1-5-0766f6297430@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-5-0766f6297430@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 20, 2025 at 05:20:11PM -0500, David Lechner wrote:
> Use spi_optimize_message() to improve the performance of buffered reads.
> 
> By setting up the SPI message and pre-optimizing it in the buffer
> postenable callback, we can reduce overhead during each sample read.
> 
> A rough estimate shows that this reduced the CPU usage of the interrupt
> handler thread from 22% to 16% using an EVAL-AD4112ARDZ board on a
> DE10-Nano (measuring a single channel at the default 6.2 kHz sample
> rate).

...

>  	samples_buf_size += sizeof(int64_t);

Missed conversion in the second patch?

I have done search for these as

	git grep -n 'u?int[0-9][0-9]?_t' -- $FILE(s)


-- 
With Best Regards,
Andy Shevchenko



