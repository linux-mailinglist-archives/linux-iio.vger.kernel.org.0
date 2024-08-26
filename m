Return-Path: <linux-iio+bounces-8804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBE695F2C2
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 15:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F6F1C21D4D
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A36187868;
	Mon, 26 Aug 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXrKgXJK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFF36F31E;
	Mon, 26 Aug 2024 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678412; cv=none; b=N45YzDI0PVx2jnX7P2gBbyodCViORpbzjbf6LJgCtV0duUKVc1KrMxsTMERrJgB+WkeKdPvUGPKU9Dbd7O6cA44DLafEYM3Z7elxxbu2xl75TQ/gyvyjyu/VQSgC6q7HZsr96qhBh05c5orhV972Hr/gq0E6w5kw6cHt9tiQNhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678412; c=relaxed/simple;
	bh=E/nqc4BLdLsFKqzhu3d2msnxyG42N32dKLB28MAm2Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faoWh3LcXAyL/MjsQ2v0YC6eNTzwAxYpjmduszF3PyQqQ5UzBGPxSD7I1sQiUZ5F7AhKN1n4ysEj557sJxSn4CvwfkjKVOB5mRGGCn9seVnvjKJxxzZ2MZRx+eHBhGChpFvh0y9LSEsRep4+WyJ3LSgHbt81mJ6F1CHLO6k2NyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXrKgXJK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724678410; x=1756214410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E/nqc4BLdLsFKqzhu3d2msnxyG42N32dKLB28MAm2Ck=;
  b=gXrKgXJKn2+hXYH/FbQqW/e4KLW+b9IE7qY4tUwfPAk6DjEWLkemJfsl
   qlW/Rez83RLLz7YgkI5X0bQdplVIgE6QT3yIZNB5dhSwkA2C22PJWswto
   kp5x5xYi4TnfHdFxHCHmHLoYV1ir/pv3tiyiIQIzPpMVQE7isLcX49k3C
   gSUTQWFNinfMTcRz0t+i38gD8rj7FIXzYjyzw5RiO1Z9SNpPCPn9ci6iB
   NfcE32hcs2YK9JacM9I9nSq/XdyChSNBsrMTdzqTE9RR9BxQk/NBdaOXh
   AFSjFFJ5CW1skYKnHbBPuBl2+g39LKLgnBqMDDlCZFsYB7ZHQeJrEH7qs
   A==;
X-CSE-ConnectionGUID: 6RF1c5i9Tym+NhFGOle5uw==
X-CSE-MsgGUID: 2ehrpcDzRmydzvYVkrq7wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23266499"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="23266499"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 06:20:09 -0700
X-CSE-ConnectionGUID: Di3szpdjS/yXVeNlb//s2A==
X-CSE-MsgGUID: vsJrk7u9TFSCMSkXYA39Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="93233608"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Aug 2024 06:20:05 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siZdb-000H78-0b;
	Mon, 26 Aug 2024 13:20:03 +0000
Date: Mon, 26 Aug 2024 21:19:16 +0800
From: kernel test robot <lkp@intel.com>
To: wangshuaijie@awinic.com, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	kees@kernel.org, gustavoars@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	wangshuaijie@awinic.com, liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V8 2/2] iio: proximity: aw96103: Add support for
 aw96103/aw96105 proximity sensor
Message-ID: <202408262043.ZgqewPIH-lkp@intel.com>
References: <20240823094947.3511730-3-wangshuaijie@awinic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823094947.3511730-3-wangshuaijie@awinic.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on b78b25f69a1dfa79798f684ad34707b1da10a48f]

url:    https://github.com/intel-lab-lkp/linux/commits/wangshuaijie-awinic-com/dt-bindings-iio-aw96103-Add-bindings-for-aw96103-aw96105-sensor/20240826-130421
base:   b78b25f69a1dfa79798f684ad34707b1da10a48f
patch link:    https://lore.kernel.org/r/20240823094947.3511730-3-wangshuaijie%40awinic.com
patch subject: [PATCH V8 2/2] iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240826/202408262043.ZgqewPIH-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408262043.ZgqewPIH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408262043.ZgqewPIH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/proximity/aw96103.c:13:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:503:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     503 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     504 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:510:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     510 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     511 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:523:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     523 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     524 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/iio/proximity/aw96103.c:18:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
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
   In file included from drivers/iio/proximity/aw96103.c:18:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
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
   In file included from drivers/iio/proximity/aw96103.c:18:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
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
>> drivers/iio/proximity/aw96103.c:806:21: error: assigning to 'struct aw_chip_info *' from 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     806 |         aw96103->chip_info = i2c_get_match_data(i2c);
         |                            ^ ~~~~~~~~~~~~~~~~~~~~~~~
   16 warnings and 1 error generated.


vim +806 drivers/iio/proximity/aw96103.c

   793	
   794	static int aw96103_i2c_probe(struct i2c_client *i2c)
   795	{
   796		struct iio_dev *aw_iio_dev;
   797		struct aw96103 *aw96103;
   798		int ret;
   799	
   800		aw_iio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*aw96103));
   801		if (!aw_iio_dev)
   802			return -ENOMEM;
   803	
   804		aw96103 = iio_priv(aw_iio_dev);
   805		aw96103->dev = &i2c->dev;
 > 806		aw96103->chip_info = i2c_get_match_data(i2c);
   807		aw96103->max_channels = aw96103->chip_info->num_channels;
   808	
   809		aw96103->regmap = devm_regmap_init_i2c(i2c, &aw96103_regmap_confg);
   810		if (IS_ERR(aw96103->regmap))
   811			return PTR_ERR(aw96103->regmap);
   812	
   813		ret = devm_regulator_get_enable(aw96103->dev, "vcc");
   814		if (ret < 0)
   815			return ret;
   816	
   817		ret = aw96103_read_chipid(aw96103);
   818		if (ret)
   819			return ret;
   820	
   821		ret = aw96103_sw_reset(aw96103);
   822		if (ret)
   823			return ret;
   824	
   825		ret = aw96103_wait_chip_init(aw96103);
   826		if (ret)
   827			return ret;
   828	
   829		ret = request_firmware_nowait(THIS_MODULE, true, "aw96103_0.bin",
   830					      aw96103->dev, GFP_KERNEL, aw96103,
   831					      aw96103_cfg_update);
   832		if (ret)
   833			return ret;
   834	
   835		ret = aw96103_interrupt_init(aw_iio_dev, i2c);
   836		if (ret)
   837			return ret;
   838		aw_iio_dev->modes = INDIO_DIRECT_MODE;
   839		aw_iio_dev->num_channels = aw96103->chip_info->num_channels;
   840		aw_iio_dev->channels = aw96103->chip_info->channels;
   841		aw_iio_dev->info = &iio_info;
   842		aw_iio_dev->name = aw96103->chip_info->name;
   843		aw_iio_dev->dev.parent = aw96103->dev;
   844	
   845		return devm_iio_device_register(aw96103->dev, aw_iio_dev);
   846	}
   847	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

