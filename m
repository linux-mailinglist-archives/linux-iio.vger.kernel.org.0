Return-Path: <linux-iio+bounces-20255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFF6ACFDA2
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 09:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB0A178904
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 07:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21190283FE4;
	Fri,  6 Jun 2025 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aoFf50Xs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372B47FD;
	Fri,  6 Jun 2025 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749195807; cv=none; b=UpgPt1gTNGBDbmu1G6OiguLwo3DimuanL6iBDVnips1LI/FlOxLLoOYAY/4u2LE6rNngUIBfRMoA7OJr+QShZ2vyHkPY/uILIfTZ6Y9ZZp4j7cHDG+8DgqLhowFRlckqoUFt8qlweStMCBbRXbyZ6x1xmTbPOOovnE2eRKSI16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749195807; c=relaxed/simple;
	bh=pL+c8rM/f0Lmikugk0/0+1Z85wAvi81Ttm6NT/gOM2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8jJrlQgOGbnoDIcZ2gn4y8F9I0RxI3MIYTVc08ZH8bghGm0Cx2QflVJst4sqi9lCRTnyDGvO9hz96+0vpPPTkdh0GkkWZLjyz/aZoro0facbEvWRGi+PTJTowv30aMS69IQ7Z9d8+5QDuLJtDuTYg7uHzuAdJI0iBTsmx7Yn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aoFf50Xs; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749195806; x=1780731806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pL+c8rM/f0Lmikugk0/0+1Z85wAvi81Ttm6NT/gOM2o=;
  b=aoFf50XslGqvB/dRaPY+KIIbAK9Em6OVmcTJZr3xdnMIJux0b4fyeGvA
   syY+bO25SpHkca1YyDernCexVr+IV3qu28Z77MRe4aKusjfgB/FtNVO52
   Q06fPUzEOBhCDZy7pparTn9OflVCs3HjrBsrW4kFj/ZssiMuqNxloyG+b
   Jn8okWkbQoY5+o6n46FaSSLg/KYcLArBk0NN21clFUcvlwlhHvHbfMDEx
   Km1EJCT1dgrh0qdtFwEdyGPbfF0XRvH3/zEIG6HSNiz3/HmDELyYMebm3
   cCCA9qESDT4aMNn8rWM/jOS95H0fhp+Vn+QW9UxCIlMwiBj0jMhIizgeq
   g==;
X-CSE-ConnectionGUID: 9fTli2ysQYWVh8glriz0Lw==
X-CSE-MsgGUID: m575OFcyTmCJT6TNTJK1zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="54998663"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="54998663"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 00:43:25 -0700
X-CSE-ConnectionGUID: 5e6Dzf6nT42rRraoqgprKg==
X-CSE-MsgGUID: 24/8OSH8Q6OToOAibQGDZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="146716524"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 06 Jun 2025 00:43:22 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNRjU-0004p7-0G;
	Fri, 06 Jun 2025 07:43:20 +0000
Date: Fri, 6 Jun 2025 15:43:01 +0800
From: kernel test robot <lkp@intel.com>
To: Gustavo Silva <gustavograzs@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gustavo Silva <gustavograzs@gmail.com>
Subject: Re: [PATCH v2 1/3] iio: imu: bmi270: add channel for step counter
Message-ID: <202506061501.4kluId3d-lkp@intel.com>
References: <20250605-bmi270-events-v2-1-8b2c07d0c213@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-bmi270-events-v2-1-8b2c07d0c213@gmail.com>

Hi Gustavo,

kernel test robot noticed the following build errors:

[auto build test ERROR on b475195fecc79a1a6e7fb0846aaaab0a1a4cb2e6]

url:    https://github.com/intel-lab-lkp/linux/commits/Gustavo-Silva/iio-imu-bmi270-add-channel-for-step-counter/20250606-061020
base:   b475195fecc79a1a6e7fb0846aaaab0a1a4cb2e6
patch link:    https://lore.kernel.org/r/20250605-bmi270-events-v2-1-8b2c07d0c213%40gmail.com
patch subject: [PATCH v2 1/3] iio: imu: bmi270: add channel for step counter
config: sh-randconfig-002-20250606 (https://download.01.org/0day-ci/archive/20250606/202506061501.4kluId3d-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250606/202506061501.4kluId3d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506061501.4kluId3d-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/tests/slub_kunit.o
>> ERROR: modpost: "__cmpxchg_called_with_bad_pointer" [drivers/iio/imu/bmi270/bmi270_core.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

