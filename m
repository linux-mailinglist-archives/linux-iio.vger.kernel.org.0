Return-Path: <linux-iio+bounces-7740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2197E938181
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 15:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2659281738
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C9012F581;
	Sat, 20 Jul 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfQQtzax"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748653D0D0;
	Sat, 20 Jul 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721482902; cv=none; b=FfXozQCnizXnW/5pjIg7mGpWSsNhkUEFsdirGpXQj+gSDj+xSZfPEmHV8ahDqnMuf8J3kitcbq3Jfzh0I0eKWUxjSN0g/ZPvfY9FdL/kUcLAsfzIf03pyMbmGi7f8fmwOpE3p9DvJ/DW3QVDeQlkU+i5skY/aQYEXT/xeJ95EbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721482902; c=relaxed/simple;
	bh=xApXq3YmfH8vE1Zs7BhLfJVd4upponZo1zhYmDwEI8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzBIN2lih/C9kaTJtF5LmZQIGu5YdFNL0NnOe/iJGdcJ9UcsxW8cAUBrkIQb+L+UlHQ8Xk+MjKqWGek95mhyWrJ8o6yMbwPCcJjdM1IkqfDLpuMc7YN6KDU9oFvFX9GdcQJ4cRQXD/BkyOSWdsniOMyXE5Wg6xWiGIedPG0EIEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfQQtzax; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721482900; x=1753018900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xApXq3YmfH8vE1Zs7BhLfJVd4upponZo1zhYmDwEI8A=;
  b=nfQQtzaxuf3wOSkq2NfQZMRXh/A5pFEfT5NHPkYev7zSgBKYJcwOZiz8
   QgOH6DJAy+V84o300fvBp4zHbAPoTERGTaGjKsdbM/iahuclBcMgzCUN/
   X4Bb1Xo7eGPRilivp+YKhNNRzepKY4VrRBB33FxnSicLIwI08ajKgVfJy
   JqS/Tu5t4rc0FEveFwscaEZIRqlTQU5lbm/UiOFvRDbZRG9YyYo2Sgd3B
   kkCr2y3ekRHBPYTU2PhnXFIxmymTs0h3BDocye31HrzCjc/MFw5ESsseP
   EJ1VZ1UomWTKYz85/TUBDeE2HhaW3DVA3WupuIAos6UtzkPwoUOcA73dM
   Q==;
X-CSE-ConnectionGUID: DZQIbWljThmoHyxb4/xAmA==
X-CSE-MsgGUID: 2FRX5z1LR4aUoHyvmKGskQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11139"; a="36535099"
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="36535099"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 06:41:39 -0700
X-CSE-ConnectionGUID: d3sXdrzzRkmNWtPpjfhoww==
X-CSE-MsgGUID: qQ4djHPGT0qnkknKbDDnkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="51369678"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 20 Jul 2024 06:41:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVAL9-000jEw-0I;
	Sat, 20 Jul 2024 13:41:35 +0000
Date: Sat, 20 Jul 2024 21:40:38 +0800
From: kernel test robot <lkp@intel.com>
To: marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
	robh+dt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, marius.cristea@microchip.com
Subject: Re: [PATCH v1 2/2] iio: adc: adding support for PAC194X
Message-ID: <202407202146.evcwKAKb-lkp@intel.com>
References: <20240719173855.53261-3-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719173855.53261-3-marius.cristea@microchip.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.10 next-20240719]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/marius-cristea-microchip-com/dt-bindings-iio-adc-adding-support-for-PAC194X/20240720-014249
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240719173855.53261-3-marius.cristea%40microchip.com
patch subject: [PATCH v1 2/2] iio: adc: adding support for PAC194X
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240720/202407202146.evcwKAKb-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad154281230d83ee551e12d5be48bb956ef47ed3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240720/202407202146.evcwKAKb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407202146.evcwKAKb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/adc/pac1944.c:16:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2258:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/pac1944.c:1691:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1691 |         if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1692 |                        msecs_to_jiffies(PAC1944_MIN_POLLING_TIME_MS))) {
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/jiffies.h:128:2: note: expanded from macro 'time_after'
     128 |         (typecheck(unsigned long, a) && \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     129 |          typecheck(unsigned long, b) && \
         |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     130 |          ((long)((b) - (a)) < 0))
         |          ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/pac1944.c:1709:9: note: uninitialized use occurs here
    1709 |         return ret;
         |                ^~~
   drivers/iio/adc/pac1944.c:1691:2: note: remove the 'if' if its condition is always true
    1691 |         if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1692 |                        msecs_to_jiffies(PAC1944_MIN_POLLING_TIME_MS))) {
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/pac1944.c:1686:9: note: initialize the variable 'ret' to silence this warning
    1686 |         int ret;
         |                ^
         |                 = 0
   drivers/iio/adc/pac1944.c:2048:16: warning: variable 'idx' set but not used [-Wunused-but-set-variable]
    2048 |         int ch, i, j, idx;
         |                       ^
   7 warnings generated.


vim +1691 drivers/iio/adc/pac1944.c

  1683	
  1684	static int pac1944_retrieve_data(struct pac1944_chip_info *info, u32 wait_time)
  1685	{
  1686		int ret;
  1687		/*
  1688		 * Check if the minimal elapsed time has passed and if so,
  1689		 * re-read the chip, otherwise the cached info is just fine
  1690		 */
> 1691		if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
  1692			       msecs_to_jiffies(PAC1944_MIN_POLLING_TIME_MS))) {
  1693			/*
  1694			 * We need to re-read the chip values
  1695			 * call the pac1944_reg_snapshot
  1696			 */
  1697			ret = pac1944_reg_snapshot(info, true,
  1698						   PAC1944_REFRESH_REG_ADDR,
  1699						   wait_time);
  1700			/*
  1701			 * Re-schedule the work for the read registers timeout
  1702			 * (to prevent chip regs saturation)
  1703			 */
  1704			cancel_delayed_work_sync(&info->work_chip_rfsh);
  1705			schedule_delayed_work(&info->work_chip_rfsh,
  1706					      msecs_to_jiffies(PAC1944_MAX_RFSH_LIMIT_MS));
  1707		}
  1708	
  1709		return ret;
  1710	}
  1711	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

