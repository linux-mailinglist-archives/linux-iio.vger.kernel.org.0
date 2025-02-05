Return-Path: <linux-iio+bounces-15047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF93A29637
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 17:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E5A188335F
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151DE1D9A79;
	Wed,  5 Feb 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eeqnleog"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAEA1B6CE3;
	Wed,  5 Feb 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772835; cv=none; b=WNA0WuGznMlBDtGB1rXGQD8+8hCzcORkCztD4EBTo5BFWsc3yeROF4E6isn2B6tMyDPJjaOZIcC44w9/NMpoNtsW5S5WtlHQRr5L8KzlByLBE1cDRSJ7qkzv8UwFkcdsabZFJroTk1ody2qUrojLKSl0MVVZCHytHkZ7lxpNuH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772835; c=relaxed/simple;
	bh=kMFmV0IehhGOWygBpPpcYAxC51tino8AxCfonOIIqPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTgzFOc9o5Dg6L1uxKHvjzDoQOhbi/yr60KMOAEa+eWCEgVImqMhiFjjaplewsZDexRNEgEOq83ftR7/DECNQCPIahv2W4jI6/wTDpcdS2QbBjog18vpvfxTpwW8z3T7BpGp9kTMegObK95FTl8qNS7Uv3mugHMABMmLD3GdzbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eeqnleog; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738772834; x=1770308834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kMFmV0IehhGOWygBpPpcYAxC51tino8AxCfonOIIqPg=;
  b=Eeqnleoga2Q45nQL2sqOaTSNja4TMC9NsI+qCIFls3KckGk7fEl9z/NM
   YOsS3l7q/Utwv//buxi4lpAYNDtxjTp/Qdveq16dJ7b0x3rE/wk2i4Fhc
   z5a5xQx51ufWySFuIa5SyRdQ1vOtSd1lWMCdM2cp1l8vZXGEez+34QKue
   txXhfdXh+/+H4Uh9JtK8snweAmPakPF8A9bRI1+8X00oqZcAv0VLRYiwn
   8cGI+lJ/pRW5JmmJb+q1g7NAoS80XqgMwPm6zanUZJMSKuv+gmaMj5Gty
   LafXZXlTjQfsxOtYL/Jujo7Ylbyw3D1ZYurWYkFTJSsajHxwqMDQdTBnb
   A==;
X-CSE-ConnectionGUID: kpJ8X0gtQSKq8lmrFLY5Og==
X-CSE-MsgGUID: PzcyMN75Q+OplXhhPIN2xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39245291"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="39245291"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 08:27:13 -0800
X-CSE-ConnectionGUID: F55qeeNmQcmnG0H6IgCGsQ==
X-CSE-MsgGUID: N9UgH9j7TG2lpT+LvpkA3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="115994605"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2025 08:27:09 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tfiF1-000vmJ-0I;
	Wed, 05 Feb 2025 16:27:07 +0000
Date: Thu, 6 Feb 2025 00:27:03 +0800
From: kernel test robot <lkp@intel.com>
To: Raag Jadav <raag.jadav@intel.com>, gregkh@linuxfoundation.org,
	rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
	dmitry.torokhov@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
	sre@kernel.org, jic23@kernel.org, przemyslaw.kitszel@intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org, Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v3 01/20] driver core: Split devres APIs to
 device/devres.h
Message-ID: <202502060025.XJwUub6I-lkp@intel.com>
References: <20250203080902.1864382-2-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203080902.1864382-2-raag.jadav@intel.com>

Hi Raag,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2014c95afecee3e76ca4a56956a936e23283f05b]

url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/driver-core-Split-devres-APIs-to-device-devres-h/20250203-161554
base:   2014c95afecee3e76ca4a56956a936e23283f05b
patch link:    https://lore.kernel.org/r/20250203080902.1864382-2-raag.jadav%40intel.com
patch subject: [PATCH v3 01/20] driver core: Split devres APIs to device/devres.h
config: um-randconfig-r112-20250205 (https://download.01.org/0day-ci/archive/20250206/202502060025.XJwUub6I-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 355d0b186f178668b103068537e517f3d52ad639)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250206/202502060025.XJwUub6I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502060025.XJwUub6I-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/pcs/pcs-xpcs-plat.c: note: in included file (through include/linux/device.h):
>> include/linux/device/devres.h:106:23: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   include/linux/device/devres.h:106:23: sparse:     expected void [noderef] __iomem *
   include/linux/device/devres.h:106:23: sparse:     got void *

vim +106 include/linux/device/devres.h

   102	
   103	static inline
   104	void __iomem *devm_ioremap_resource(struct device *dev, const struct resource *res)
   105	{
 > 106		return ERR_PTR(-EINVAL);
   107	}
   108	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

