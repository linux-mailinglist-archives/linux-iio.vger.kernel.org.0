Return-Path: <linux-iio+bounces-5520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DCF8D59FC
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 07:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132C91C23C5C
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 05:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4077A702;
	Fri, 31 May 2024 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQNSC2r1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6A1CD3C;
	Fri, 31 May 2024 05:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717134524; cv=none; b=osBfqUJT4/xERAgM/7kysF61jVuKEq25CNeHfrNXSiuYQuNxH0GISxf/LfjhTqyLHCmrE780TM2FfJ9pTHTsdVAzHspVWzhFxDrYEAn+IWzggEBpvmBHCx1BmCpAuqfDCdQCKKhVt+lngo4K7DjthPo+MzyKWdQ7f27hsGSNYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717134524; c=relaxed/simple;
	bh=GSYHW0e477rQxa1VvjbRStBZ0wEwBEhVvmhQZuAfotk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8Jp6Jh1h4qaji6OSNJEhkHPBp801gQBELGQC2X64DdEGvYsxVSiuGW+uXOXNaH1ENk1LK2eFhO/hNI0mzZARqLrS6PPUFlDRSxR+u5QgaGS1HCYr07IjxwdsQWnB/oAvzquzrGF587hw03I8BP+/tj02b0NTGzFN67DIut6pgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQNSC2r1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717134521; x=1748670521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GSYHW0e477rQxa1VvjbRStBZ0wEwBEhVvmhQZuAfotk=;
  b=IQNSC2r1xlzaa5QDMWuZ5Clrs21Iq8Q1vBoZe/vi0ytxEgUM9lENtMjK
   14X+mpcwRoKLrQZtOCwb3/NvuBtPmia1/Fqc17VS02/cNV4vnKyonC2kh
   f1BEkYphY+wE1dxeBBFAsgwR+vpkHc9CA2qlwYYJ534zD0QGMi0rwfcci
   nUoWNZkxLpttVd3BIW52lIs9VPJpsX7R1zYyxy6fbfdvTvceQNf1zycWx
   z/p28SfT7zNskyJXMWamSC9bdY4InoJWvO4utx5xg/SYKqflzrVRKAyGO
   L129Ayn/eK5f1zrChKMG8IUN5urvqPq+DFz8l24L0m4L8vRibExwYLYq4
   A==;
X-CSE-ConnectionGUID: cQ0WW6EQTieRyrUJLzR+bA==
X-CSE-MsgGUID: 8UWllD1oSGC8hEltWY0MQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="16611012"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="16611012"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 22:48:41 -0700
X-CSE-ConnectionGUID: E0KUiHj2TOur9Gq8noPTCA==
X-CSE-MsgGUID: s2wJYRV4QdOIqWYzlRSpkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36092149"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 30 May 2024 22:48:38 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCv7z-000Gah-1c;
	Fri, 31 May 2024 05:48:35 +0000
Date: Fri, 31 May 2024 13:48:00 +0800
From: kernel test robot <lkp@intel.com>
To: Yasin Lee <yasin.lee.x@outlook.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lars@metafoo.de, swboyd@chromium.org,
	nuno.a@analog.com, andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor
 driver
Message-ID: <202405311323.ITmSo5vY-lkp@intel.com>
References: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>

Hi Yasin,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.10-rc1 next-20240529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/iio-proximity-hx9031as-Add-TYHX-HX9031AS-HX9023S-sensor-driver/20240529-170200
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN7PR12MB8101EDFA7F91A59761095A28A4E72%40SN7PR12MB8101.namprd12.prod.outlook.com
patch subject: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor driver
config: arm-randconfig-r132-20240531 (https://download.01.org/0day-ci/archive/20240531/202405311323.ITmSo5vY-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce: (https://download.01.org/0day-ci/archive/20240531/202405311323.ITmSo5vY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405311323.ITmSo5vY-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __aeabi_uldivmod
   >>> referenced by hx9031as.c
   >>>               drivers/iio/proximity/hx9031as.o:(hx9031as_write_raw) in archive vmlinux.a
   >>> did you mean: __aeabi_uidivmod
   >>> defined in: arch/arm/lib/lib.a(lib1funcs.o)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

