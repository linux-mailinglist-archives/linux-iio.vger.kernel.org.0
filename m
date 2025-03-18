Return-Path: <linux-iio+bounces-17010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC73A66CDB
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 08:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E02D3AE524
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 07:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECAA1F4CBD;
	Tue, 18 Mar 2025 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QlX5DoxL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20FB1EF39B;
	Tue, 18 Mar 2025 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284439; cv=none; b=tAWMH8kQ80X67VpM17as20wVgyj7P8d312wL2n3nvv3OUbHc4vutSDS0d5xqKixGqf2bYoAgR0EoFpvnb5BqJBBvEmq4qx7iFyG2ZO9hT416Yu/coT1dlUOnqNoik/ZGYdcnwk7gs9uso2e4+MkT3jrzJawQY9rw8m/5+8U1e6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284439; c=relaxed/simple;
	bh=mLpG53z/+xYRI+C6koH5UavmowUagfMKoYxc/VnZjA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIkeq3Acbd//l9vSIhovlshAWj9guEa1p5MvgCPiTD80DX5sEPAF6lbsdyTfB4nyTRVQZ4q6O64CmpIFmsoEXCEHYPy4Xxz6LqKidEAAUf69pMuwIq5Nm0vQYr9TdgZ22HIVz0o1dPUTC6WqApwbwA81ScCRJyOeeeM39Vua/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QlX5DoxL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742284438; x=1773820438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mLpG53z/+xYRI+C6koH5UavmowUagfMKoYxc/VnZjA4=;
  b=QlX5DoxLAJBR4K22jNCY+qiBxe7UtnjVu5Dc6RhNGnYq1eg+brbkOUN5
   2HFNMFziRjrSfSiB8QJG96cNZPrjISQqxj3plvvqwYfjyp9pZZwqLVcHI
   2gBubQR1gWbmf2SjIoVy16688ifjqQeoYrJl+c0y1h7t+7iRPybR6wTpT
   TlryU9CLlmBFVICwpjxS73byYqidCkhispebYuEbxaOXOI/1UIZBAA6th
   6hREYxopHptMBTdkYxH5nTWoSdKGlpIIfrBgGE8l45CkheoNbQBOkgYnc
   CK1Sh5JHjnq8fpBtGMFyockoTOfPGeYkcEby19RLfI8NZBS5s9FzVRSF6
   w==;
X-CSE-ConnectionGUID: fWGAZXcLS2qNUu95AGN7jQ==
X-CSE-MsgGUID: JioroM82RrmflDRZBdYUSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43541650"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43541650"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 00:53:54 -0700
X-CSE-ConnectionGUID: grYtw6pDRzqsPrdhUg2U4w==
X-CSE-MsgGUID: Uo8I6aSzQF6FxPM0Zx+8ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="122123923"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 18 Mar 2025 00:53:51 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuRll-000DY0-0U;
	Tue, 18 Mar 2025 07:53:49 +0000
Date: Tue, 18 Mar 2025 15:53:24 +0800
From: kernel test robot <lkp@intel.com>
To: marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, krzk+dt@kernel.org, conor+dt@kernel.org,
	oskar.andero@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	marius.cristea@microchip.com
Subject: Re: [PATCH v2 2/2] iio: adc: adding support for PAC194X
Message-ID: <202503181545.znULdV4G-lkp@intel.com>
References: <20250317090803.30003-3-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317090803.30003-3-marius.cristea@microchip.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 577a66e2e634f712384c57a98f504c44ea4b47da]

url:    https://github.com/intel-lab-lkp/linux/commits/marius-cristea-microchip-com/dt-bindings-iio-adc-adding-support-for-PAC194X/20250317-171150
base:   577a66e2e634f712384c57a98f504c44ea4b47da
patch link:    https://lore.kernel.org/r/20250317090803.30003-3-marius.cristea%40microchip.com
patch subject: [PATCH v2 2/2] iio: adc: adding support for PAC194X
config: riscv-randconfig-r072-20250318 (https://download.01.org/0day-ci/archive/20250318/202503181545.znULdV4G-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 87916f8c32ebd8e284091db9b70339df57fd1e90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250318/202503181545.znULdV4G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503181545.znULdV4G-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/adc/pac1944.c:20:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:22:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2223:
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
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/pac1944.c:1689:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1689 |         if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1690 |                        msecs_to_jiffies(PAC1944_MIN_POLLING_TIME_MS))) {
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/jiffies.h:128:2: note: expanded from macro 'time_after'
     128 |         (typecheck(unsigned long, a) && \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     129 |          typecheck(unsigned long, b) && \
         |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     130 |          ((long)((b) - (a)) < 0))
         |          ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/pac1944.c:1707:9: note: uninitialized use occurs here
    1707 |         return ret;
         |                ^~~
   drivers/iio/adc/pac1944.c:1689:2: note: remove the 'if' if its condition is always true
    1689 |         if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1690 |                        msecs_to_jiffies(PAC1944_MIN_POLLING_TIME_MS))) {
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/pac1944.c:1683:9: note: initialize the variable 'ret' to silence this warning
    1683 |         int ret;
         |                ^
         |                 = 0
   5 warnings generated.


vim +1689 drivers/iio/adc/pac1944.c

  1680	
  1681	static int pac1944_retrieve_data(struct pac1944_chip_info *info, u32 wait_time)
  1682	{
  1683		int ret;
  1684	
  1685		/*
  1686		 * Check if the minimal elapsed time has passed and if so,
  1687		 * re-read the chip, otherwise the cached info is just fine
  1688		 */
> 1689		if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
  1690			       msecs_to_jiffies(PAC1944_MIN_POLLING_TIME_MS))) {
  1691			/*
  1692			 * We need to re-read the chip values
  1693			 * call the pac1944_reg_snapshot
  1694			 */
  1695			ret = pac1944_reg_snapshot(info, true,
  1696						   PAC1944_REFRESH_REG_ADDR,
  1697						   wait_time);
  1698			/*
  1699			 * Re-schedule the work for the read registers timeout
  1700			 * (to prevent chip regs saturation)
  1701			 */
  1702			cancel_delayed_work_sync(&info->work_chip_rfsh);
  1703			schedule_delayed_work(&info->work_chip_rfsh,
  1704					      msecs_to_jiffies(PAC1944_MAX_RFSH_LIMIT_MS));
  1705		}
  1706	
  1707		return ret;
  1708	}
  1709	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

