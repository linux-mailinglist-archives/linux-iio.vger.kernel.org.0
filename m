Return-Path: <linux-iio+bounces-8829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 449B696135E
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 17:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2A91C22B7C
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAC51C93B6;
	Tue, 27 Aug 2024 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CrJU1w2g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5939D1A0711;
	Tue, 27 Aug 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774043; cv=none; b=JMuigd2PWRraXt2gtEwHafzDtDM+pPjLdthl9SKmoiTWlybk0yIyQlImQlWIKnvTcReDUvK0Z+4e0u2tUJlic8Pji6wwltgM1TZKzYXgzhsGqOuIpoM+nyy8S6CdkJVeAQjUvi8Rj9f+UTiyIv5OjnKACMeC4pBKjAkLGQ/jqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774043; c=relaxed/simple;
	bh=Fvkl/HshbSj4eecN8jd5uO8Of8Nsl2RaNPyYrH+NU98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLl+q8iI3YZGVwYe2yVidg/O0p8dv1Qt1f4E7ydLvm/0TzeTTLkYndS7wKxZXfKdrAEyQswBnUS715QT3d7N7Ym4ZXEKGsI94FrtXIoCx1B482vbeLoiLW4lt2t50zUKrAtAR7spqXfx/XqSH/zaN6gs+I0IxwIaJaCcrdw247s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CrJU1w2g; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724774040; x=1756310040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fvkl/HshbSj4eecN8jd5uO8Of8Nsl2RaNPyYrH+NU98=;
  b=CrJU1w2gUv/AMXbi+ypCBWNhWfUSVu/iaBAS+OkkfyxK6RG9huiWLt89
   Ec3qvBPcv6eOFiHHC8K56qRlPM91dwhxl2H0ih0P1Ri+5kebJEo71zU/I
   ghR+7H7X8ndfAdbO7kTCJ4s0MzbHhSIPCIQ8uhhgdwv7C+qzPHemw3pfV
   uPgY9HDJoYFJI952863KtGn521OiPzulOA8zsT5+qXejjFUFl7esmi3yT
   va4NZC7vTG10AsUSNXO6qAVtx9RQwJy380PnpbNtInIucIkdS7nvPFS/j
   V36ung5thKTO09Bm8jzIqj47nuSZLw63FZ7U4ZOn+/55oNeVE+bXPD1K4
   g==;
X-CSE-ConnectionGUID: DVi8a+/FQzKCP8ZT4kK2Dg==
X-CSE-MsgGUID: 5Egzr6UKTgWjbXrgWzvelA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="26162263"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="26162263"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 08:53:59 -0700
X-CSE-ConnectionGUID: 7en32UcdRvyPAIk6Mvu/tw==
X-CSE-MsgGUID: SE7aMuQ/Suipu7lrMymA2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67607600"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 27 Aug 2024 08:53:56 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siyW2-000Jmw-1i;
	Tue, 27 Aug 2024 15:53:54 +0000
Date: Tue, 27 Aug 2024 23:53:07 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 2/2] iio: imu: st_lsm6dsx: Remove useless dev_fwnode()
 calls
Message-ID: <202408272326.NVkKclXF-lkp@intel.com>
References: <20240826212344.866928-3-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826212344.866928-3-andy.shevchenko@gmail.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.11-rc5 next-20240827]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/iio-imu-st_lsm6dsx-Use-iio_read_acpi_mount_matrix-helper/20240827-052617
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240826212344.866928-3-andy.shevchenko%40gmail.com
patch subject: [PATCH v1 2/2] iio: imu: st_lsm6dsx: Remove useless dev_fwnode() calls
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240827/202408272326.NVkKclXF-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408272326.NVkKclXF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408272326.NVkKclXF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:75:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2228:
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
   In file included from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:84:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:84:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:84:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:2137:55: error: incompatible integer to pointer conversion passing 'int' to parameter of type 'u32 *' (aka 'unsigned int *') [-Wint-conversion]
    2137 |         if (device_property_read_u32(dev, "st,drdy-int-pin", drdy_pin) < 0) {
         |                                                              ^~~~~~~~
   include/linux/property.h:229:36: note: passing argument to parameter 'val' here
     229 |                                            const char *propname, u32 *val)
         |                                                                       ^
   17 warnings and 1 error generated.


vim +2137 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c

  2129	
  2130	static int
  2131	st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
  2132				const struct st_lsm6dsx_reg **drdy_reg)
  2133	{
  2134		struct device *dev = hw->dev;
  2135		int err = 0, drdy_pin;
  2136	
> 2137		if (device_property_read_u32(dev, "st,drdy-int-pin", drdy_pin) < 0) {
  2138			struct st_sensors_platform_data *pdata;
  2139	
  2140			pdata = (struct st_sensors_platform_data *)dev->platform_data;
  2141			drdy_pin = pdata ? pdata->drdy_int_pin : 1;
  2142		}
  2143	
  2144		switch (drdy_pin) {
  2145		case 1:
  2146			hw->irq_routing = &hw->settings->irq_config.irq1_func;
  2147			*drdy_reg = &hw->settings->irq_config.irq1;
  2148			break;
  2149		case 2:
  2150			hw->irq_routing = &hw->settings->irq_config.irq2_func;
  2151			*drdy_reg = &hw->settings->irq_config.irq2;
  2152			break;
  2153		default:
  2154			dev_err(hw->dev, "unsupported data ready pin\n");
  2155			err = -EINVAL;
  2156			break;
  2157		}
  2158	
  2159		return err;
  2160	}
  2161	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

