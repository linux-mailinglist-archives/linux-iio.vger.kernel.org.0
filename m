Return-Path: <linux-iio+bounces-20900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92504AE3C24
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 12:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6242418933AA
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 10:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85937239E99;
	Mon, 23 Jun 2025 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7gPq/Ad"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C023A566;
	Mon, 23 Jun 2025 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674159; cv=none; b=FQl/kWiTB4kh3zmWFb/z+0tq1fdVTP96VJg6q2Aq3xvx8c+tbaGS+ZuZIXV+yEZ2F3Av8jPaD5p0c9QkT8ouhJPvGfTwI/NSPZJMWmZ45kp/e7tSc0xomFJy+b4KA6QQMoWWKQxMlGfL/sE5r5V80WVc1tbHDfo5MRTARGEUqP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674159; c=relaxed/simple;
	bh=K6ejdeVWXNi1Joy2ps0u8ylB95bhYC8uYvSwet/9+BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WR4GJTDpWZfTXzGZQNRoH2oJwdpBr+zew1lNT/zIplt1BBEXCCYO/CpuRTJoC1LNXwatTx8SbdbhK+3BWCcXFBE4HeM6HghV3bnrYH7UOL/pu9M4XYBeGq+Vg7oO4NU/0wJJjQPZf/mIfLH+vlB8zOlwIWLPLUz5sNoxZL8o0FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7gPq/Ad; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750674158; x=1782210158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K6ejdeVWXNi1Joy2ps0u8ylB95bhYC8uYvSwet/9+BE=;
  b=a7gPq/AdOGVeoJAyfWTAhY3lWb27RHkgb9ARYAM4uGSBQepJUdr9D4Mx
   F9ZcPPB34bPdIoopiAZN8JmeOLzs3WswxHtJh6fnWScWjpH563yaJhCPl
   M5W8phRXrg3LtX8+oE+O1qh55nskrdPz1uAlpPEjIVSlF6zHQSAtqxr+v
   N8UBaaaf0JIqmwCjSaSFmQpNvmQKqT+tfFAr7iMUkocrVXagdUQc5f/QL
   jfewUipcTQ5Gp4T262dXub9ghmc/H4EL9rFAKjVh+yEVVB0441hGFDd5W
   lAZ2Hs96ecLtVP2OtJLNIsza095m17Ygi6YucRv5f/40cs1QSw5WxiKOj
   g==;
X-CSE-ConnectionGUID: 7Wut/jhIR92lJbJVNBbYWQ==
X-CSE-MsgGUID: 55iaybUMRKS5ibYLwXrYUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52845552"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52845552"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 03:22:38 -0700
X-CSE-ConnectionGUID: dT4HYpINQ0Kj6SeQmv7yIQ==
X-CSE-MsgGUID: zwKtq7p2QqG19IGXrl0TUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="151331475"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 23 Jun 2025 03:22:34 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTeJs-000Nwk-0T;
	Mon, 23 Jun 2025 10:22:32 +0000
Date: Mon, 23 Jun 2025 18:21:52 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 8/9] iio: adc: ad_sigma_delta: add SPI offload support
Message-ID: <202506231738.CgeNexV4-lkp@intel.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-8-0766f6297430@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-8-0766f6297430@baylibre.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d02f330b0c78bcf76643fbb7d3215a58b181f829]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-adc-ad_sigma_delta-sort-includes/20250621-063127
base:   d02f330b0c78bcf76643fbb7d3215a58b181f829
patch link:    https://lore.kernel.org/r/20250620-iio-adc-ad7173-add-spi-offload-support-v1-8-0766f6297430%40baylibre.com
patch subject: [PATCH 8/9] iio: adc: ad_sigma_delta: add SPI offload support
config: x86_64-buildonly-randconfig-004-20250621 (https://download.01.org/0day-ci/archive/20250623/202506231738.CgeNexV4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250623/202506231738.CgeNexV4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506231738.CgeNexV4-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: module ad_sigma_delta uses symbol devm_iio_dmaengine_buffer_setup_with_handle from namespace IIO_DMAENGINE_BUFFER, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

