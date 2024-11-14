Return-Path: <linux-iio+bounces-12237-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBC29C840F
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 08:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D869284434
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 07:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BA71F472D;
	Thu, 14 Nov 2024 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWzq816e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7B163;
	Thu, 14 Nov 2024 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569828; cv=none; b=dNyNSkC8PytPWDUQ28/FPfCWIrNWhNE+NCVykPnE18n2YwQEZnlRnJSmD+9YmDe0WUm+x7QYvRivDIhjkrGeVFhLfRfsYJ3OnXqlxWRjZDkGHL5NLSWkJKCryvdY/Ir7j2MWM5lFFZl6MNeTDSILXHXl5MwQ0vwnlYRsBcmaKrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569828; c=relaxed/simple;
	bh=kOb2ZYhLdcrt1/fmMbUCYgTRegwUoDmTiVsCsnAKezo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eguN2m533fkQ4imrohO9iP7rpecBaIUC8ztgqU2bf7RTBAelr9JRkYGZVG0hO2FzOGuwV1s+PHmqiLTY4kypTTuq4NS3aZ7mzPpC++tkDvlF4woReYYczwfPI22HuBh4BflehH+HvStjuunJbhB03LiEfHNaPPz2LQJRGllDkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWzq816e; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731569826; x=1763105826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kOb2ZYhLdcrt1/fmMbUCYgTRegwUoDmTiVsCsnAKezo=;
  b=FWzq816eE5WIoF9nDNlP6i949aeydRXCin3+B6Q2Y5YKMaZ/sMCSQQLW
   6PrX3nhLmFJqRqiUSE22yoOwKyeMz4lAR9voB7w208Sifqo5dop9K022A
   fCWiQY36Gj5SKZJ2Pi9F3EUCzklz00KGBN+h9e8Px3i+5l7ypXh9Thwba
   fzhg9UYqddLgMDIQJ9htDJGm+3f/u7cosN+KvnF+V9A+Q1jVdmxcFihnV
   PUfxmbr00sWxjtFr9jdae9A9CFcC5aSDawgnFSiHswItsD73LgIaXcMb4
   aekQH0gR/l23J3pVWcZQcgb639t1ibmCd0feuOS4d/Ym5HWwCtTVoYp/z
   w==;
X-CSE-ConnectionGUID: aOVBqoU4QOmmoiIGaMsVzg==
X-CSE-MsgGUID: bbTByMGwSnCYUXMHhthH7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="30901576"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="30901576"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 23:37:05 -0800
X-CSE-ConnectionGUID: x7vsDg8DR/+0mjqnT6TiPg==
X-CSE-MsgGUID: jfLzm6z/S9yFSOX6eaLqkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="93059751"
Received: from lkp-server01.sh.intel.com (HELO 8eed2ac03994) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 13 Nov 2024 23:37:01 -0800
Received: from kbuild by 8eed2ac03994 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBUPS-00005j-30;
	Thu, 14 Nov 2024 07:36:58 +0000
Date: Thu, 14 Nov 2024 15:36:22 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 4/5] hwmon: tmp108: Add support for I3C device
Message-ID: <202411141530.qTxjCzf7-lkp@intel.com>
References: <20241111-p3t1085-v3-4-bff511550aad@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-p3t1085-v3-4-bff511550aad@nxp.com>

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on 74741a050b79d31d8d2eeee12c77736596d0a6b2]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dt-bindings-hwmon-ti-tmp108-Add-nxp-p3t1085-compatible-string/20241112-013721
base:   74741a050b79d31d8d2eeee12c77736596d0a6b2
patch link:    https://lore.kernel.org/r/20241111-p3t1085-v3-4-bff511550aad%40nxp.com
patch subject: [PATCH v3 4/5] hwmon: tmp108: Add support for I3C device
config: arc-randconfig-001-20241114 (https://download.01.org/0day-ci/archive/20241114/202411141530.qTxjCzf7-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411141530.qTxjCzf7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411141530.qTxjCzf7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from drivers/hwmon/tmp108.c:8:
>> include/linux/module.h:131:49: error: redefinition of '__inittest'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:262:1: note: in expansion of macro 'module_init'
     262 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/i3c/device.h:233:9: note: in expansion of macro 'module_driver'
     233 |         module_driver(__drv, i3c_driver_register, i3c_driver_unregister)
         |         ^~~~~~~~~~~~~
   drivers/hwmon/tmp108.c:473:1: note: in expansion of macro 'module_i3c_driver'
     473 | module_i3c_driver(p3t1085_driver);
         | ^~~~~~~~~~~~~~~~~
   include/linux/module.h:131:49: note: previous definition of '__inittest' with type 'int (*(void))(void)'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:262:1: note: in expansion of macro 'module_init'
     262 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/i2c.h:965:9: note: in expansion of macro 'module_driver'
     965 |         module_driver(__i2c_driver, i2c_add_driver, \
         |         ^~~~~~~~~~~~~
   drivers/hwmon/tmp108.c:444:1: note: in expansion of macro 'module_i2c_driver'
     444 | module_i2c_driver(tmp108_driver);
         | ^~~~~~~~~~~~~~~~~
>> include/linux/module.h:133:13: error: redefinition of 'init_module'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/device/driver.h:262:1: note: in expansion of macro 'module_init'
     262 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/i3c/device.h:233:9: note: in expansion of macro 'module_driver'
     233 |         module_driver(__drv, i3c_driver_register, i3c_driver_unregister)
         |         ^~~~~~~~~~~~~
   drivers/hwmon/tmp108.c:473:1: note: in expansion of macro 'module_i3c_driver'
     473 | module_i3c_driver(p3t1085_driver);
         | ^~~~~~~~~~~~~~~~~
   include/linux/module.h:133:13: note: previous definition of 'init_module' with type 'int(void)'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/device/driver.h:262:1: note: in expansion of macro 'module_init'
     262 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/i2c.h:965:9: note: in expansion of macro 'module_driver'
     965 |         module_driver(__i2c_driver, i2c_add_driver, \
         |         ^~~~~~~~~~~~~
   drivers/hwmon/tmp108.c:444:1: note: in expansion of macro 'module_i2c_driver'
     444 | module_i2c_driver(tmp108_driver);
         | ^~~~~~~~~~~~~~~~~
>> include/linux/module.h:139:49: error: redefinition of '__exittest'
     139 |         static inline exitcall_t __maybe_unused __exittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:267:1: note: in expansion of macro 'module_exit'
     267 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/i3c/device.h:233:9: note: in expansion of macro 'module_driver'
     233 |         module_driver(__drv, i3c_driver_register, i3c_driver_unregister)
         |         ^~~~~~~~~~~~~
   drivers/hwmon/tmp108.c:473:1: note: in expansion of macro 'module_i3c_driver'
     473 | module_i3c_driver(p3t1085_driver);
         | ^~~~~~~~~~~~~~~~~
   include/linux/module.h:139:49: note: previous definition of '__exittest' with type 'void (*(void))(void)'
     139 |         static inline exitcall_t __maybe_unused __exittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:267:1: note: in expansion of macro 'module_exit'
     267 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/i2c.h:965:9: note: in expansion of macro 'module_driver'
     965 |         module_driver(__i2c_driver, i2c_add_driver, \
         |         ^~~~~~~~~~~~~
   drivers/hwmon/tmp108.c:444:1: note: in expansion of macro 'module_i2c_driver'
     444 | module_i2c_driver(tmp108_driver);
         | ^~~~~~~~~~~~~~~~~
>> include/linux/module.h:141:14: error: redefinition of 'cleanup_module'
     141 |         void cleanup_module(void) __copy(exitfn)                \
         |              ^~~~~~~~~~~~~~
   include/linux/device/driver.h:267:1: note: in expansion of macro 'module_exit'
     267 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/i3c/device.h:233:9: note: in expansion of macro 'module_driver'
     233 |         module_driver(__drv, i3c_driver_register, i3c_driver_unregister)
         |         ^~~~~~~~~~~~~
   drivers/hwmon/tmp108.c:473:1: note: in expansion of macro 'module_i3c_driver'
     473 | module_i3c_driver(p3t1085_driver);
         | ^~~~~~~~~~~~~~~~~
   include/linux/module.h:141:14: note: previous definition of 'cleanup_module' with type 'void(void)'
     141 |         void cleanup_module(void) __copy(exitfn)                \
         |              ^~~~~~~~~~~~~~
   include/linux/device/driver.h:267:1: note: in expansion of macro 'module_exit'
     267 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/i2c.h:965:9: note: in expansion of macro 'module_driver'
     965 |         module_driver(__i2c_driver, i2c_add_driver, \
         |         ^~~~~~~~~~~~~
   drivers/hwmon/tmp108.c:444:1: note: in expansion of macro 'module_i2c_driver'
     444 | module_i2c_driver(tmp108_driver);
         | ^~~~~~~~~~~~~~~~~


vim +/__inittest +131 include/linux/module.h

0fd972a7d91d6e1 Paul Gortmaker 2015-05-01  128  
0fd972a7d91d6e1 Paul Gortmaker 2015-05-01  129  /* Each module must use one module_init(). */
0fd972a7d91d6e1 Paul Gortmaker 2015-05-01  130  #define module_init(initfn)					\
1f318a8bafcfba9 Arnd Bergmann  2017-02-01 @131  	static inline initcall_t __maybe_unused __inittest(void)		\
0fd972a7d91d6e1 Paul Gortmaker 2015-05-01  132  	{ return initfn; }					\
cf68fffb66d60d9 Sami Tolvanen  2021-04-08 @133  	int init_module(void) __copy(initfn)			\
cf68fffb66d60d9 Sami Tolvanen  2021-04-08  134  		__attribute__((alias(#initfn)));		\
92efda8eb15295a Sami Tolvanen  2022-09-08  135  	___ADDRESSABLE(init_module, __initdata);
0fd972a7d91d6e1 Paul Gortmaker 2015-05-01  136  
0fd972a7d91d6e1 Paul Gortmaker 2015-05-01  137  /* This is only required if you want to be unloadable. */
0fd972a7d91d6e1 Paul Gortmaker 2015-05-01  138  #define module_exit(exitfn)					\
1f318a8bafcfba9 Arnd Bergmann  2017-02-01 @139  	static inline exitcall_t __maybe_unused __exittest(void)		\
0fd972a7d91d6e1 Paul Gortmaker 2015-05-01  140  	{ return exitfn; }					\
cf68fffb66d60d9 Sami Tolvanen  2021-04-08 @141  	void cleanup_module(void) __copy(exitfn)		\
cf68fffb66d60d9 Sami Tolvanen  2021-04-08  142  		__attribute__((alias(#exitfn)));		\
92efda8eb15295a Sami Tolvanen  2022-09-08  143  	___ADDRESSABLE(cleanup_module, __exitdata);
0fd972a7d91d6e1 Paul Gortmaker 2015-05-01  144  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

