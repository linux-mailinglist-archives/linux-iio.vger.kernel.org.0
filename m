Return-Path: <linux-iio+bounces-15613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D53A37795
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 21:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D7C3B07B8
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 20:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC481A3162;
	Sun, 16 Feb 2025 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PneFxjW7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7963D154C05;
	Sun, 16 Feb 2025 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739739538; cv=none; b=nHpChTijdqVEXcl837scXLqpe3QGPWyHrkwROfVHcccD/JY41dOYyiArjD2wyhoNO6ItNFLvNjHJ/oEttUplSJH+OyRsFvHXYqwBzFrAdUBI8zIf2XmSyatQszrc06pJZfttuI5teYX9spYI6aONJ2X4N8Qwe610UCJc0K+hZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739739538; c=relaxed/simple;
	bh=S3PLRZCBViuwEVgtI8Y/b/sq5CTkF6q0/2O9vDspRTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+3RR7aqjW3WGmx6qageHBhyhyAp4CnS2vcMe5DOMUrGo50EV8EOPedpVFKpAe4de6Z7dWRoSFVMbQwBdNWsim5uby+BxXtIVRJnRq68o/7Cr0ZrndDHP1NNrdEQ6j4Q4sFbexcDOY8yrveJOs069HF3lftz1IA65rFaLs5I10I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PneFxjW7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739739537; x=1771275537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S3PLRZCBViuwEVgtI8Y/b/sq5CTkF6q0/2O9vDspRTA=;
  b=PneFxjW7iPXzXbzbWWx0pZVb/ScJaIis9m2s+lOFdLAkCY06ZBS5BWQw
   gAYkH47Q2tWd/UeIPCG/VDjwyTa8F5eUmptHRQMuUaRv1Na6yCJfGg67u
   tRT8/M8YtPcrfvyGAypJGHdVFOZGZeKt+OQs2pIaTzXmsVQO2BuxJVQDO
   N12afhKcOJbLbn0wfY9iwCQRoeIZgic8gS+xdvJ1Sj2NxoTTi6DPqqOk6
   z6RDLpkgpzMFM6IDSOuGnzE1rdPR8710pQD1exjsELZEEzpY7EJXTBTfC
   57yQxGaWZDVS00Ngz2zuG/qtp1IsMd0ZzXczlNWcS3bLB+TQBFcDgm1uW
   w==;
X-CSE-ConnectionGUID: zfbVxKilSkKhipRbsAdd4Q==
X-CSE-MsgGUID: vOSMKtN8QAC5OSCIkoHcog==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40289832"
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="40289832"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 12:58:56 -0800
X-CSE-ConnectionGUID: GvXoOAg7S1GLL3c3ryG3Jw==
X-CSE-MsgGUID: 3dHvYRUnRxO9SxcJg8DXhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="113921158"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Feb 2025 12:58:50 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjliy-001CD5-2Q;
	Sun, 16 Feb 2025 20:58:48 +0000
Date: Mon, 17 Feb 2025 04:57:48 +0800
From: kernel test robot <lkp@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: light: Add support for AL3000a illuminance
 sensor
Message-ID: <202502170433.E6JuboR5-lkp@intel.com>
References: <20250216162721.124834-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216162721.124834-3-clamor95@gmail.com>

Hi Svyatoslav,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.14-rc2 next-20250214]
[cannot apply to jic23-iio/togreg]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/dt-bindings-iio-light-al3010-add-al3000a-support/20250217-002927
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250216162721.124834-3-clamor95%40gmail.com
patch subject: [PATCH v3 2/3] iio: light: Add support for AL3000a illuminance sensor
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250217/202502170433.E6JuboR5-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250217/202502170433.E6JuboR5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502170433.E6JuboR5-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/light/al3000a.c:4:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/light/al3000a.c:202:26: error: use of undeclared identifier 'al3010_id'; did you mean 'al3000a_id'?
     202 | MODULE_DEVICE_TABLE(i2c, al3010_id);
         |                          ^~~~~~~~~
         |                          al3000a_id
   include/linux/module.h:250:15: note: expanded from macro 'MODULE_DEVICE_TABLE'
     250 | extern typeof(name) __mod_device_table__##type##__##name                \
         |               ^
   drivers/iio/light/al3000a.c:198:35: note: 'al3000a_id' declared here
     198 | static const struct i2c_device_id al3000a_id[] = {
         |                                   ^
   3 warnings and 1 error generated.


vim +202 drivers/iio/light/al3000a.c

   197	
   198	static const struct i2c_device_id al3000a_id[] = {
   199		{"al3000a", },
   200		{}
   201	};
 > 202	MODULE_DEVICE_TABLE(i2c, al3010_id);
   203	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

