Return-Path: <linux-iio+bounces-15300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F4115A2FC1F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 22:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E98B166DDE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 21:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B476524C695;
	Mon, 10 Feb 2025 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEfCDIaq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B8426462C;
	Mon, 10 Feb 2025 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739223320; cv=none; b=GCO7QfKRmRG60DnffvX1QsDUoiihAuzz6pDMJYHrHHCoRAlRqLJY5JkhRh2tte8TEryQcy+3E9Q/zsi+RjDDDh8vUn9BkPsIdJV0w09UiWqtaX1e8zQOQnGwzmT59CrOm/CruZDmbZq2iiDFZgmMcfimy7y8KnZ47AW6hnHMUa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739223320; c=relaxed/simple;
	bh=H7RSqJLsURJtj4e0K5zWf3Vea8L8TxbXHl2Kl4kO0KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSwiadaxd3SJRx+bcKK5AJXUeKLLxVj6c+E1moPZkYtv/3BqPWMmHXvB7+WQUUa3u8WgYPfudmoDS3eHynrdGLrRlzka1nFAo8EXC1wqleA8OEvO1SScwRDi0HqK/1HrTx6v97wdo5a/iMQph+5At4UIc8P/+L37GYpamDxMgpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEfCDIaq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739223318; x=1770759318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H7RSqJLsURJtj4e0K5zWf3Vea8L8TxbXHl2Kl4kO0KA=;
  b=UEfCDIaq5sj1xixvHWxVUpohvY1cMJb3+GYJ10xZcgL3DUGuqOcr9YRu
   UXDuTH22JewcOlI7yf38f3oeX2R7kPAANkdeGdY4kYuJumVo0TEHIKbpl
   8vAkNg/JM8/UOz6hqcd97GmIcYtbnRYrYmZ2hjk+kW+OmW61xxDau97ho
   iebU6qS6qoUwDnLLMTdCTfY0OY1b2TSAcESupitZQGxKrqtj1haomyDdh
   GqRYPb32vAHFQth8vuAi1qRPtE84NVxCh/gjghVndU9pqVLlg2Ap0vsPG
   xVLg2Pe8grgyn6ZJ+ATRga0EnuK8xZRgU5ZH6UZRI3EDPxzGwl9RFiDVp
   A==;
X-CSE-ConnectionGUID: jtk2WAk+R+aNd0UzDRV87w==
X-CSE-MsgGUID: vSmdpoXdSxyCD/2BvkiLGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="50812055"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="50812055"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 13:35:17 -0800
X-CSE-ConnectionGUID: glPiKZtjRjS9g6fzlCmivQ==
X-CSE-MsgGUID: heVC2K6PRKyNOw3v7yoCeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117515530"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 13:35:12 -0800
Date: Mon, 10 Feb 2025 23:35:09 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, rafael@kernel.org,
	linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
	dmitry.torokhov@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
	sre@kernel.org, jic23@kernel.org, przemyslaw.kitszel@intel.com,
	oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 01/20] driver core: Split devres APIs to
 device/devres.h
Message-ID: <Z6pxDTUE60CKwHlE@black.fi.intel.com>
References: <20250210064906.2181867-2-raag.jadav@intel.com>
 <202502102201.zLWaJC6V-lkp@intel.com>
 <Z6oZ9dnYrlp5djiQ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6oZ9dnYrlp5djiQ@smile.fi.intel.com>

On Mon, Feb 10, 2025 at 05:23:33PM +0200, Andy Shevchenko wrote:
> +Cc: Arnd
> 
> On Mon, Feb 10, 2025 at 10:30:28PM +0800, kernel test robot wrote:
> > Hi Raag,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on a1e062ab4a1f19bb0e94093ef90ab9a74f1f7744]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/driver-core-Split-devres-APIs-to-device-devres-h/20250210-145732
> > base:   a1e062ab4a1f19bb0e94093ef90ab9a74f1f7744
> > patch link:    https://lore.kernel.org/r/20250210064906.2181867-2-raag.jadav%40intel.com
> > patch subject: [PATCH v4 01/20] driver core: Split devres APIs to device/devres.h
> > config: powerpc64-randconfig-002-20250210 (https://download.01.org/0day-ci/archive/20250210/202502102201.zLWaJC6V-lkp@intel.com/config)
> > compiler: powerpc64-linux-gcc (GCC) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250210/202502102201.zLWaJC6V-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202502102201.zLWaJC6V-lkp@intel.com/
> > 
> > All error/warnings (new ones prefixed by >>):
> 
> TBH I have no quick idea how to address this. It seems that io.h includes device.h
> for no reason (but I haven't checked that carefully). OTOH, we need only
> IOMEM_IS_ERR() definition which can simply be moved from io.h to err.h as the
> former includes the latter and the definition depends only on compiler_types.h.

I atleast managed to build this after dropping device.h from asm/io.h however
eeh.h is just something else.

Raag

> Arnd?
> 
> >    In file included from include/linux/device/devres.h:7,
> >                     from include/linux/device.h:31,
> >                     from arch/powerpc/include/asm/io.h:22,
> >                     from include/linux/scatterlist.h:9,
> >                     from crypto/rsassa-pkcs1.c:11:
> >    include/linux/io.h: In function 'pci_remap_cfgspace':
> >    include/linux/io.h:106:16: error: implicit declaration of function 'ioremap_np' [-Wimplicit-function-declaration]
> >      106 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
> >          |                ^~~~~~~~~~
> >    include/linux/io.h:106:44: error: implicit declaration of function 'ioremap' [-Wimplicit-function-declaration]
> >      106 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
> >          |                                            ^~~~~~~
> >    include/linux/io.h:106:42: error: returning 'int' from a function with return type 'void *' makes pointer from integer without a cast [-Wint-conversion]
> >      106 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
> >          |                ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
> >    arch/powerpc/include/asm/io.h: At top level:
> > >> arch/powerpc/include/asm/io.h:885:22: error: conflicting types for 'ioremap'; have 'void *(phys_addr_t,  long unsigned int)' {aka 'void *(long long unsigned int,  long unsigned int)'}
> >      885 | extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
> >          |                      ^~~~~~~
> >    include/linux/io.h:106:44: note: previous implicit declaration of 'ioremap' with type 'int()'
> >      106 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
> >          |                                            ^~~~~~~
> >    In file included from include/asm-generic/io.h:17,
> >                     from arch/powerpc/include/asm/io.h:1031:
> > >> include/asm-generic/iomap.h:106:20: error: conflicting types for 'ioremap_np'; have 'void *(phys_addr_t,  size_t)' {aka 'void *(long long unsigned int,  long unsigned int)'}
> >      106 | #define ioremap_np ioremap_np
> >          |                    ^~~~~~~~~~
> >    include/asm-generic/iomap.h:107:29: note: in expansion of macro 'ioremap_np'
> >      107 | static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)
> >          |                             ^~~~~~~~~~
> >    include/linux/io.h:106:16: note: previous implicit declaration of 'ioremap_np' with type 'int()'
> >      106 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
> >          |                ^~~~~~~~~~
> > --
> >    In file included from arch/powerpc/include/asm/io.h:274,
> >                     from include/linux/io.h:14,
> >                     from include/linux/device/devres.h:7,
> >                     from include/linux/device.h:31,
> >                     from include/linux/acpi.h:14,
> >                     from include/linux/i2c.h:13,
> >                     from drivers/input/touchscreen/ili210x.c:5:
> > >> arch/powerpc/include/asm/eeh.h:304:45: warning: 'struct iommu_group' declared inside parameter list will not be visible outside of this definition or declaration
> >      304 | struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
> >          |                                             ^~~~~~~~~~~
> > --
> >    In file included from arch/powerpc/include/asm/io.h:274,
> >                     from include/linux/io.h:14,
> >                     from include/linux/device/devres.h:7,
> >                     from include/linux/device.h:31,
> >                     from include/linux/input.h:19,
> >                     from drivers/input/touchscreen/touchright.c:17:
> > >> arch/powerpc/include/asm/eeh.h:304:45: warning: 'struct iommu_group' declared inside parameter list will not be visible outside of this definition or declaration
> >      304 | struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
> >          |                                             ^~~~~~~~~~~
> >    drivers/input/touchscreen/touchright.c: In function 'tr_connect':
> >    drivers/input/touchscreen/touchright.c:114:49: warning: '/input0' directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
> >      114 |         snprintf(tr->phys, sizeof(tr->phys), "%s/input0", serio->phys);
> >          |                                                 ^~~~~~~
> >    drivers/input/touchscreen/touchright.c:114:9: note: 'snprintf' output between 8 and 39 bytes into a destination of size 32
> >      114 |         snprintf(tr->phys, sizeof(tr->phys), "%s/input0", serio->phys);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > --
> >    In file included from arch/powerpc/include/asm/io.h:274,
> >                     from include/linux/io.h:14,
> >                     from include/linux/device/devres.h:7,
> >                     from include/linux/device.h:31,
> >                     from include/linux/input.h:19,
> >                     from drivers/input/touchscreen/penmount.c:17:
> > >> arch/powerpc/include/asm/eeh.h:304:45: warning: 'struct iommu_group' declared inside parameter list will not be visible outside of this definition or declaration
> >      304 | struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
> >          |                                             ^~~~~~~~~~~
> >    drivers/input/touchscreen/penmount.c: In function 'pm_connect':
> >    drivers/input/touchscreen/penmount.c:211:49: warning: '/input0' directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
> >      211 |         snprintf(pm->phys, sizeof(pm->phys), "%s/input0", serio->phys);
> >          |                                                 ^~~~~~~
> >    drivers/input/touchscreen/penmount.c:211:9: note: 'snprintf' output between 8 and 39 bytes into a destination of size 32
> >      211 |         snprintf(pm->phys, sizeof(pm->phys), "%s/input0", serio->phys);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > --
> >    In file included from arch/powerpc/include/asm/io.h:274,
> >                     from include/linux/io.h:14,
> >                     from include/linux/device/devres.h:7,
> >                     from include/linux/device.h:31,
> >                     from include/linux/input.h:19,
> >                     from drivers/input/touchscreen/inexio.c:19:
> > >> arch/powerpc/include/asm/eeh.h:304:45: warning: 'struct iommu_group' declared inside parameter list will not be visible outside of this definition or declaration
> >      304 | struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
> >          |                                             ^~~~~~~~~~~
> >    drivers/input/touchscreen/inexio.c: In function 'inexio_connect':
> >    drivers/input/touchscreen/inexio.c:126:59: warning: '/input0' directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
> >      126 |         snprintf(pinexio->phys, sizeof(pinexio->phys), "%s/input0", serio->phys);
> >          |                                                           ^~~~~~~
> >    drivers/input/touchscreen/inexio.c:126:9: note: 'snprintf' output between 8 and 39 bytes into a destination of size 32
> >      126 |         snprintf(pinexio->phys, sizeof(pinexio->phys), "%s/input0", serio->phys);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > --
> >    In file included from arch/powerpc/include/asm/io.h:274,
> >                     from include/linux/io.h:14,
> >                     from include/linux/device/devres.h:7,
> >                     from include/linux/device.h:31,
> >                     from include/linux/input.h:19,
> >                     from drivers/input/touchscreen/touchwin.c:24:
> > >> arch/powerpc/include/asm/eeh.h:304:45: warning: 'struct iommu_group' declared inside parameter list will not be visible outside of this definition or declaration
> >      304 | struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
> >          |                                             ^~~~~~~~~~~
> >    drivers/input/touchscreen/touchwin.c: In function 'tw_connect':
> >    drivers/input/touchscreen/touchwin.c:121:49: warning: '/input0' directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
> >      121 |         snprintf(tw->phys, sizeof(tw->phys), "%s/input0", serio->phys);
> >          |                                                 ^~~~~~~
> >    drivers/input/touchscreen/touchwin.c:121:9: note: 'snprintf' output between 8 and 39 bytes into a destination of size 32
> >      121 |         snprintf(tw->phys, sizeof(tw->phys), "%s/input0", serio->phys);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > --
> >    In file included from arch/powerpc/include/asm/io.h:274,
> >                     from include/linux/io.h:14,
> >                     from include/linux/device/devres.h:7,
> >                     from include/linux/device.h:31,
> >                     from include/linux/input.h:19,
> >                     from drivers/input/touchscreen/hampshire.c:19:
> > >> arch/powerpc/include/asm/eeh.h:304:45: warning: 'struct iommu_group' declared inside parameter list will not be visible outside of this definition or declaration
> >      304 | struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
> >          |                                             ^~~~~~~~~~~
> >    drivers/input/touchscreen/hampshire.c: In function 'hampshire_connect':
> >    drivers/input/touchscreen/hampshire.c:122:21: warning: '/input0' directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
> >      122 |                  "%s/input0", serio->phys);
> >          |                     ^~~~~~~
> >    drivers/input/touchscreen/hampshire.c:121:9: note: 'snprintf' output between 8 and 39 bytes into a destination of size 32
> >      121 |         snprintf(phampshire->phys, sizeof(phampshire->phys),
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      122 |                  "%s/input0", serio->phys);
> >          |                  ~~~~~~~~~~~~~~~~~~~~~~~~~
> > --
> >    In file included from arch/powerpc/include/asm/io.h:274,
> >                     from include/linux/io.h:14,
> >                     from include/linux/device/devres.h:7,
> >                     from include/linux/device.h:31,
> >                     from include/linux/input.h:19,
> >                     from drivers/input/touchscreen/tsc40.c:12:
> > >> arch/powerpc/include/asm/eeh.h:304:45: warning: 'struct iommu_group' declared inside parameter list will not be visible outside of this definition or declaration
> >      304 | struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
> >          |                                             ^~~~~~~~~~~
> >    drivers/input/touchscreen/tsc40.c: In function 'tsc_connect':
> >    drivers/input/touchscreen/tsc40.c:95:53: warning: '/input0' directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
> >       95 |         snprintf(ptsc->phys, sizeof(ptsc->phys), "%s/input0", serio->phys);
> >          |                                                     ^~~~~~~
> >    drivers/input/touchscreen/tsc40.c:95:9: note: 'snprintf' output between 8 and 39 bytes into a destination of size 32
> >       95 |         snprintf(ptsc->phys, sizeof(ptsc->phys), "%s/input0", serio->phys);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > --
> >    In file included from arch/powerpc/include/asm/io.h:274,
> >                     from include/linux/io.h:14,
> >                     from include/linux/device/devres.h:7,
> >                     from include/linux/device.h:31,
> >                     from include/linux/input.h:19,
> >                     from drivers/input/touchscreen/dynapro.c:20:
> > >> arch/powerpc/include/asm/eeh.h:304:45: warning: 'struct iommu_group' declared inside parameter list will not be visible outside of this definition or declaration
> >      304 | struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
> >          |                                             ^~~~~~~~~~~
> >    drivers/input/touchscreen/dynapro.c: In function 'dynapro_connect':
> >    drivers/input/touchscreen/dynapro.c:123:21: warning: '/input0' directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
> >      123 |                  "%s/input0", serio->phys);
> >          |                     ^~~~~~~
> >    drivers/input/touchscreen/dynapro.c:122:9: note: 'snprintf' output between 8 and 39 bytes into a destination of size 32
> >      122 |         snprintf(pdynapro->phys, sizeof(pdynapro->phys),
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      123 |                  "%s/input0", serio->phys);
> >          |                  ~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > 
> > vim +885 arch/powerpc/include/asm/io.h
> > 
> > ^1da177e4c3f415 include/asm-ppc64/io.h        Linus Torvalds         2005-04-16  853  
> > ^1da177e4c3f415 include/asm-ppc64/io.h        Linus Torvalds         2005-04-16  854  /**
> > ^1da177e4c3f415 include/asm-ppc64/io.h        Linus Torvalds         2005-04-16  855   * ioremap     -   map bus memory into CPU space
> > ^1da177e4c3f415 include/asm-ppc64/io.h        Linus Torvalds         2005-04-16  856   * @address:   bus address of the memory
> > ^1da177e4c3f415 include/asm-ppc64/io.h        Linus Torvalds         2005-04-16  857   * @size:      size of the resource to map
> > ^1da177e4c3f415 include/asm-ppc64/io.h        Linus Torvalds         2005-04-16  858   *
> > ^1da177e4c3f415 include/asm-ppc64/io.h        Linus Torvalds         2005-04-16  859   * ioremap performs a platform specific sequence of operations to
> > ^1da177e4c3f415 include/asm-ppc64/io.h        Linus Torvalds         2005-04-16  860   * make bus memory CPU accessible via the readb/readw/readl/writeb/
> > ^1da177e4c3f415 include/asm-ppc64/io.h        Linus Torvalds         2005-04-16  861   * writew/writel functions and the other mmio helpers. The returned
> > ^1da177e4c3f415 include/asm-ppc64/io.h        Linus Torvalds         2005-04-16  862   * address is not guaranteed to be usable directly as a virtual
> > ^1da177e4c3f415 include/asm-ppc64/io.h        Linus Torvalds         2005-04-16  863   * address.
> > 4cb3cee03d558fd include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-11  864   *
> > 4cb3cee03d558fd include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-11  865   * We provide a few variations of it:
> > 4cb3cee03d558fd include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-11  866   *
> > 4cb3cee03d558fd include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-11  867   * * ioremap is the standard one and provides non-cacheable guarded mappings
> > 4cb3cee03d558fd include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-11  868   *   and can be hooked by the platform via ppc_md
> > 4cb3cee03d558fd include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-11  869   *
> > 40f1ce7fb7e8b5d arch/powerpc/include/asm/io.h Anton Blanchard        2011-05-08  870   * * ioremap_prot allows to specify the page flags as an argument and can
> > 40f1ce7fb7e8b5d arch/powerpc/include/asm/io.h Anton Blanchard        2011-05-08  871   *   also be hooked by the platform via ppc_md.
> > 4cb3cee03d558fd include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-11  872   *
> > be135f40899cb33 arch/powerpc/include/asm/io.h Anton Blanchard        2011-05-08  873   * * ioremap_wc enables write combining
> > be135f40899cb33 arch/powerpc/include/asm/io.h Anton Blanchard        2011-05-08  874   *
> > 86c391bd5f47101 arch/powerpc/include/asm/io.h Christophe Leroy       2018-10-09  875   * * ioremap_wt enables write through
> > 86c391bd5f47101 arch/powerpc/include/asm/io.h Christophe Leroy       2018-10-09  876   *
> > 86c391bd5f47101 arch/powerpc/include/asm/io.h Christophe Leroy       2018-10-09  877   * * ioremap_coherent maps coherent cached memory
> > 86c391bd5f47101 arch/powerpc/include/asm/io.h Christophe Leroy       2018-10-09  878   *
> > 4cb3cee03d558fd include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-11  879   * * iounmap undoes such a mapping and can be hooked
> > 4cb3cee03d558fd include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-11  880   *
> > 1cdab55d8a8313f arch/powerpc/include/asm/io.h Benjamin Herrenschmidt 2009-02-22  881   * * __ioremap_caller is the same as above but takes an explicit caller
> > 1cdab55d8a8313f arch/powerpc/include/asm/io.h Benjamin Herrenschmidt 2009-02-22  882   *   reference rather than using __builtin_return_address(0)
> > 1cdab55d8a8313f arch/powerpc/include/asm/io.h Benjamin Herrenschmidt 2009-02-22  883   *
> > ^1da177e4c3f415 include/asm-ppc64/io.h        Linus Torvalds         2005-04-16  884   */
> > 68a64357d15ae4f include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-13 @885  extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
> > 8d05554dca2af6a arch/powerpc/include/asm/io.h Christophe Leroy       2023-07-06  886  #define ioremap ioremap
> > 8d05554dca2af6a arch/powerpc/include/asm/io.h Christophe Leroy       2023-07-06  887  #define ioremap_prot ioremap_prot
> > be135f40899cb33 arch/powerpc/include/asm/io.h Anton Blanchard        2011-05-08  888  extern void __iomem *ioremap_wc(phys_addr_t address, unsigned long size);
> > 894fa235eb4ca0b arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  889  #define ioremap_wc ioremap_wc
> > 894fa235eb4ca0b arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  890  
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

