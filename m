Return-Path: <linux-iio+bounces-15262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C17A2EF42
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 15:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DF01636F3
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E0C233D72;
	Mon, 10 Feb 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfH7h3o/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F73233126;
	Mon, 10 Feb 2025 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196572; cv=none; b=Iv0tM/wKqOCqaAPvM6/Y1oJaAupnmoxXOenZcgwRep1hRLwlS+JPxG15GsfGDGWYTZ35RkX9McBeiC1prQeaMq6IEYcSB+MbR3laL1VipyoF6C6kqoIGaQof18lqCxzpwejC45cU3JEhKwoF0PuoFV+6+ZJP700ynwtCwb5rzYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196572; c=relaxed/simple;
	bh=RSJHSeUykncMmWA9ukvup+xfsW+60QnBx5gLQnMN9s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WITRGbv5uvTGZEv9tWyxNedGxBdikMw6NPRE8PPgzIx1Lh6cCFky8ZUVrWvYY4QoC2FBIGDf/PQgK5bn4iNEtM6q0GFq3yeSP30yS7BYrdjLs6hcM7nxi6p71wFAlARvjrjsPlXB8SWlY5mTtV3f3f2YMdHdohUsBg/hdPhb6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfH7h3o/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739196571; x=1770732571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RSJHSeUykncMmWA9ukvup+xfsW+60QnBx5gLQnMN9s8=;
  b=nfH7h3o/it8x81p0PiR86bc0oaXV43ohYPo8SRcuOletF7TdYQGSbswY
   rZryLF1i0VpXgY+LqSRT8hv5ebMYHZfbW9+I9d1Y4bAXW7mlcM/LUHCDH
   8xuZAhBxLVa22YajRG3wMGrhIsH+meXiJpVb7lHgivZbQGv1Y8UWNTUqU
   dkV5lGoJu4BglarK5t7UMMkuSVkf/EKFB7fD/eAIFLQjJg4V3F5DGCo3U
   x8+6UKCI/hTgXj4WP+6OmxdXd+fBZExnBO390doXQpp3RZ6jnC/V83jpN
   Hgf7A5W/ExwFh7BG90ayc6Ym+gbb54YzjV82UmWsanrqDAMG5rGhzY6t+
   w==;
X-CSE-ConnectionGUID: eO6MFeVQTPq66FHNDkn9oQ==
X-CSE-MsgGUID: mO3JrCCkT0ODKjO1GqY4gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39012595"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39012595"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 06:09:30 -0800
X-CSE-ConnectionGUID: O5WsGvLGTVGQ7i8p3P/9Aw==
X-CSE-MsgGUID: wJB6oeoBTRyy3NjF1mo6DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="143065127"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Feb 2025 06:09:26 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thUTS-0012rN-2A;
	Mon, 10 Feb 2025 14:09:22 +0000
Date: Mon, 10 Feb 2025 22:08:28 +0800
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
Subject: Re: [PATCH v4 01/20] driver core: Split devres APIs to
 device/devres.h
Message-ID: <202502102137.SA3rtuTB-lkp@intel.com>
References: <20250210064906.2181867-2-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210064906.2181867-2-raag.jadav@intel.com>

Hi Raag,

kernel test robot noticed the following build errors:

[auto build test ERROR on a1e062ab4a1f19bb0e94093ef90ab9a74f1f7744]

url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/driver-core-Split-devres-APIs-to-device-devres-h/20250210-145732
base:   a1e062ab4a1f19bb0e94093ef90ab9a74f1f7744
patch link:    https://lore.kernel.org/r/20250210064906.2181867-2-raag.jadav%40intel.com
patch subject: [PATCH v4 01/20] driver core: Split devres APIs to device/devres.h
config: powerpc-randconfig-003-20250210 (https://download.01.org/0day-ci/archive/20250210/202502102137.SA3rtuTB-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250210/202502102137.SA3rtuTB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502102137.SA3rtuTB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device/devres.h:7,
                    from include/linux/device.h:31,
                    from arch/powerpc/include/asm/io.h:22,
                    from drivers/video/fbdev/sis/init.h:64,
                    from drivers/video/fbdev/sis/init.c:59:
   include/linux/io.h: In function 'pci_remap_cfgspace':
>> include/linux/io.h:106:16: error: implicit declaration of function 'ioremap_np' [-Wimplicit-function-declaration]
     106 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
         |                ^~~~~~~~~~
>> include/linux/io.h:106:44: error: implicit declaration of function 'ioremap' [-Wimplicit-function-declaration]
     106 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
         |                                            ^~~~~~~
>> include/linux/io.h:106:42: error: returning 'int' from a function with return type 'void *' makes pointer from integer without a cast [-Wint-conversion]
     106 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h: At top level:
>> arch/powerpc/include/asm/io.h:885:22: error: conflicting types for 'ioremap'; have 'void *(phys_addr_t,  long unsigned int)' {aka 'void *(unsigned int,  long unsigned int)'}
     885 | extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
         |                      ^~~~~~~
   include/linux/io.h:106:44: note: previous implicit declaration of 'ioremap' with type 'int()'
     106 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
         |                                            ^~~~~~~
   In file included from arch/powerpc/include/asm/io.h:1031:
>> include/asm-generic/io.h:1161:20: error: conflicting types for 'ioremap_np'; have 'void *(phys_addr_t,  size_t)' {aka 'void *(unsigned int,  unsigned int)'}
    1161 | #define ioremap_np ioremap_np
         |                    ^~~~~~~~~~
   include/asm-generic/io.h:1162:29: note: in expansion of macro 'ioremap_np'
    1162 | static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)
         |                             ^~~~~~~~~~
   include/linux/io.h:106:16: note: previous implicit declaration of 'ioremap_np' with type 'int()'
     106 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
         |                ^~~~~~~~~~
--
   In file included from include/linux/device/devres.h:7,
                    from include/linux/device.h:31,
                    from arch/powerpc/include/asm/io.h:22,
                    from drivers/video/fbdev/sis/init301.h:64,
                    from drivers/video/fbdev/sis/init301.c:72:
   include/linux/io.h: In function 'pci_remap_cfgspace':
>> include/linux/io.h:106:16: error: implicit declaration of function 'ioremap_np' [-Wimplicit-function-declaration]
     106 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
         |                ^~~~~~~~~~
>> include/linux/io.h:106:44: error: implicit declaration of function 'ioremap' [-Wimplicit-function-declaration]
     106 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
         |                                            ^~~~~~~
>> include/linux/io.h:106:42: error: returning 'int' from a function with return type 'void *' makes pointer from integer without a cast [-Wint-conversion]
     106 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h: At top level:
>> arch/powerpc/include/asm/io.h:885:22: error: conflicting types for 'ioremap'; have 'void *(phys_addr_t,  long unsigned int)' {aka 'void *(unsigned int,  long unsigned int)'}
     885 | extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
         |                      ^~~~~~~
   include/linux/io.h:106:44: note: previous implicit declaration of 'ioremap' with type 'int()'
     106 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
         |                                            ^~~~~~~
   In file included from arch/powerpc/include/asm/io.h:1031:
>> include/asm-generic/io.h:1161:20: error: conflicting types for 'ioremap_np'; have 'void *(phys_addr_t,  size_t)' {aka 'void *(unsigned int,  unsigned int)'}
    1161 | #define ioremap_np ioremap_np
         |                    ^~~~~~~~~~
   include/asm-generic/io.h:1162:29: note: in expansion of macro 'ioremap_np'
    1162 | static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)
         |                             ^~~~~~~~~~
   include/linux/io.h:106:16: note: previous implicit declaration of 'ioremap_np' with type 'int()'
     106 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
         |                ^~~~~~~~~~
   drivers/video/fbdev/sis/init301.c: In function 'SiS_SetCRT2ModeRegs':
   drivers/video/fbdev/sis/init301.c:2687:24: warning: variable 'modeflag' set but not used [-Wunused-but-set-variable]
    2687 |   unsigned short i, j, modeflag, tempah=0;
         |                        ^~~~~~~~
   drivers/video/fbdev/sis/init301.c: In function 'SiS_SetGroup1':
   drivers/video/fbdev/sis/init301.c:6233:52: warning: variable 'resinfo' set but not used [-Wunused-but-set-variable]
    6233 |   unsigned short  pushbx=0, CRT1Index=0, modeflag, resinfo=0;
         |                                                    ^~~~~~~


vim +/ioremap_np +106 include/linux/io.h

7d3dcf26a6559f Christoph Hellwig 2015-08-10   84  
4d312ac057da57 Arnd Bergmann     2023-05-16   85  /* architectures can override this */
4d312ac057da57 Arnd Bergmann     2023-05-16   86  pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
4d312ac057da57 Arnd Bergmann     2023-05-16   87  					unsigned long size, pgprot_t prot);
4d312ac057da57 Arnd Bergmann     2023-05-16   88  
4d312ac057da57 Arnd Bergmann     2023-05-16   89  
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19   90  #ifdef CONFIG_PCI
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19   91  /*
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19   92   * The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
b10eb2d50911f9 Hector Martin     2021-03-25   93   * Posting") mandate non-posted configuration transactions. This default
b10eb2d50911f9 Hector Martin     2021-03-25   94   * implementation attempts to use the ioremap_np() API to provide this
b10eb2d50911f9 Hector Martin     2021-03-25   95   * on arches that support it, and falls back to ioremap() on those that
b10eb2d50911f9 Hector Martin     2021-03-25   96   * don't. Overriding this function is deprecated; arches that properly
b10eb2d50911f9 Hector Martin     2021-03-25   97   * support non-posted accesses should implement ioremap_np() instead, which
b10eb2d50911f9 Hector Martin     2021-03-25   98   * this default implementation can then use to return mappings compliant with
b10eb2d50911f9 Hector Martin     2021-03-25   99   * the PCI specification.
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  100   */
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  101  #ifndef pci_remap_cfgspace
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  102  #define pci_remap_cfgspace pci_remap_cfgspace
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  103  static inline void __iomem *pci_remap_cfgspace(phys_addr_t offset,
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  104  					       size_t size)
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  105  {
b10eb2d50911f9 Hector Martin     2021-03-25 @106  	return ioremap_np(offset, size) ?: ioremap(offset, size);
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  107  }
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  108  #endif
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  109  #endif
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  110  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

