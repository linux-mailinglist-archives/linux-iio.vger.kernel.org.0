Return-Path: <linux-iio+bounces-15288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC14A2F7AA
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 19:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80943188A69D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 18:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513582586D2;
	Mon, 10 Feb 2025 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuH9vNyp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5D257AF7;
	Mon, 10 Feb 2025 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739213046; cv=none; b=RXXTebJiXAwiyK5h9lNPYjWVseXDh48PG9CtRdBxou7BcrwCWHyNUSY/z3Fu7tnqaOspHMldjevqanoGdMnIgGEXvV1a63/G+nj2kZGEaf0UBEXmRjK3ueNLqbcKPPmU2xbQp84fgWitVeLd/PLfhZaOqIuValuwfcjwEnxXUWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739213046; c=relaxed/simple;
	bh=F/oLFAsAG4O3sgYtk2OCtyqCA7pKAu0hVAyFxYmR1LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0cdf6vgK/KDhNSxrDsjhRXY/LgHIyUtwaJlIgrjgPmbx9RS4GOsP9JrsCWp49ImN4pHbdSv7vaKoq3mhRGDt+Cbw2qR/tECy3MJ3H8UCbMYHBCiVoy5gUBhKmd8H/HlkCjgCqU0JzmXQF+/kKAdBTrZsvi8NYNWLljc7/q+Q3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AuH9vNyp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739213044; x=1770749044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F/oLFAsAG4O3sgYtk2OCtyqCA7pKAu0hVAyFxYmR1LI=;
  b=AuH9vNypspWPmFDQfFMZJshgiUeszyOAPkjsZPc+QeK2X6BpANF3wSeT
   4Yxhg9FxGG6pDWBX+okPzp92ppahN9cYMHP02ITYPZr9WEVqdkjjX1obY
   fIeYJq4U4F3nDCqrKFjp0mc9YoyvS8jjVvJzUR4r/HJ9JYQu2v2N+s63N
   n38Kyii1jL5B/uq8qNIsLythEfPq59GU9Ml4d03llwT9TV3fGOg0GH9Pp
   hOdKw94PNUdmwO8KMndH1dhqIpW0MhbbuMZlh5FeTLr/qkRu+wHxwFuiE
   AQJuNO2W2i0k/9bHiOAbtkNWiFfO2n/RZ/sDc0Rq8U9GJeY1IgyPLPZvZ
   w==;
X-CSE-ConnectionGUID: Zw3wK6DgSACfTTNCIPPv2w==
X-CSE-MsgGUID: RK3AUgDpRB++mWYQyO2phA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="50446546"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="50446546"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 10:44:03 -0800
X-CSE-ConnectionGUID: 9rYFJW/PQUKsazG2Bj+83w==
X-CSE-MsgGUID: fCjjHb5vSfyS3GeQ/UtrLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="117352813"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Feb 2025 10:43:59 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thYlA-0013Ct-2b;
	Mon, 10 Feb 2025 18:43:56 +0000
Date: Tue, 11 Feb 2025 02:43:26 +0800
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
Message-ID: <202502110256.ZtYROQTy-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on a1e062ab4a1f19bb0e94093ef90ab9a74f1f7744]

url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/driver-core-Split-devres-APIs-to-device-devres-h/20250210-145732
base:   a1e062ab4a1f19bb0e94093ef90ab9a74f1f7744
patch link:    https://lore.kernel.org/r/20250210064906.2181867-2-raag.jadav%40intel.com
patch subject: [PATCH v4 01/20] driver core: Split devres APIs to device/devres.h
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20250211/202502110256.ZtYROQTy-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250211/202502110256.ZtYROQTy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502110256.ZtYROQTy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/input/input.c:14:
   In file included from include/linux/input/mt.h:11:
   In file included from include/linux/input.h:19:
   In file included from include/linux/device.h:31:
   In file included from include/linux/device/devres.h:7:
   In file included from include/linux/io.h:14:
   In file included from arch/powerpc/include/asm/io.h:274:
>> arch/powerpc/include/asm/eeh.h:304:45: warning: declaration of 'struct iommu_group' will not be visible outside of this function [-Wvisibility]
   struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
                                               ^
   1 warning generated.
--
   In file included from drivers/input/touchscreen/mms114.c:10:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:31:
   In file included from include/linux/device/devres.h:7:
   In file included from include/linux/io.h:14:
   In file included from arch/powerpc/include/asm/io.h:274:
>> arch/powerpc/include/asm/eeh.h:304:45: warning: declaration of 'struct iommu_group' will not be visible outside of this function [-Wvisibility]
   struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
                                               ^
   drivers/input/touchscreen/mms114.c:507:15: warning: cast to smaller integer type 'enum mms_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
           data->type = (enum mms_type)match_data;
                        ^~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.
--
   In file included from drivers/input/touchscreen/wdt87xx_i2c.c:12:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:31:
   In file included from include/linux/device/devres.h:7:
   In file included from include/linux/io.h:14:
   In file included from arch/powerpc/include/asm/io.h:274:
>> arch/powerpc/include/asm/eeh.h:304:45: warning: declaration of 'struct iommu_group' will not be visible outside of this function [-Wvisibility]
   struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
                                               ^
   drivers/input/touchscreen/wdt87xx_i2c.c:1156:36: warning: unused variable 'wdt87xx_acpi_id' [-Wunused-const-variable]
   static const struct acpi_device_id wdt87xx_acpi_id[] = {
                                      ^
   2 warnings generated.


vim +304 arch/powerpc/include/asm/eeh.h

55037d176107c3 arch/powerpc/include/asm/eeh.h Gavin Shan        2012-09-07  292  
c44e4ccadaca58 arch/powerpc/include/asm/eeh.h Sam Bobroff       2019-08-16  293  void eeh_show_enabled(void);
d125aedb404204 arch/powerpc/include/asm/eeh.h Oliver O'Halloran 2020-09-18  294  int __init eeh_init(struct eeh_ops *ops);
3e938052fb7655 arch/powerpc/include/asm/eeh.h Gavin Shan        2014-09-30  295  int eeh_check_failure(const volatile void __iomem *token);
f8f7d63fd96ead arch/powerpc/include/asm/eeh.h Gavin Shan        2012-09-07  296  int eeh_dev_check_failure(struct eeh_dev *edev);
685a0bc00abcf1 arch/powerpc/include/asm/eeh.h Sam Bobroff       2019-08-16  297  void eeh_addr_cache_init(void);
e86350f70a02e5 arch/powerpc/include/asm/eeh.h Oliver O'Halloran 2020-03-06  298  void eeh_probe_device(struct pci_dev *pdev);
807a827d4e7455 arch/powerpc/include/asm/eeh.h Gavin Shan        2013-07-24  299  void eeh_remove_device(struct pci_dev *);
188fdea69fa91d arch/powerpc/include/asm/eeh.h Sam Bobroff       2018-11-29  300  int eeh_unfreeze_pe(struct eeh_pe *pe);
5cfb20b96f624e arch/powerpc/include/asm/eeh.h Gavin Shan        2014-09-30  301  int eeh_pe_reset_and_recover(struct eeh_pe *pe);
212d16cdca2d0f arch/powerpc/include/asm/eeh.h Gavin Shan        2014-06-10  302  int eeh_dev_open(struct pci_dev *pdev);
212d16cdca2d0f arch/powerpc/include/asm/eeh.h Gavin Shan        2014-06-10  303  void eeh_dev_release(struct pci_dev *pdev);
212d16cdca2d0f arch/powerpc/include/asm/eeh.h Gavin Shan        2014-06-10 @304  struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
212d16cdca2d0f arch/powerpc/include/asm/eeh.h Gavin Shan        2014-06-10  305  int eeh_pe_set_option(struct eeh_pe *pe, int option);
212d16cdca2d0f arch/powerpc/include/asm/eeh.h Gavin Shan        2014-06-10  306  int eeh_pe_get_state(struct eeh_pe *pe);
1ef52073fd25ea arch/powerpc/include/asm/eeh.h Sam Bobroff       2018-11-29  307  int eeh_pe_reset(struct eeh_pe *pe, int option, bool include_passed);
212d16cdca2d0f arch/powerpc/include/asm/eeh.h Gavin Shan        2014-06-10  308  int eeh_pe_configure(struct eeh_pe *pe);
ec33d36e5ab5d5 arch/powerpc/include/asm/eeh.h Gavin Shan        2015-03-26  309  int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
ec33d36e5ab5d5 arch/powerpc/include/asm/eeh.h Gavin Shan        2015-03-26  310  		      unsigned long addr, unsigned long mask);
b0e2b828dfca64 arch/powerpc/include/asm/eeh.h Narayana Murty N  2024-09-09  311  int eeh_pe_inject_mmio_error(struct pci_dev *pdev);
e2a296eeaa3444 include/asm-powerpc/eeh.h      Linas Vepstas     2005-11-03  312  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

