Return-Path: <linux-iio+bounces-4975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 594548C3365
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 21:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C352C1F21784
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 19:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AEF200A0;
	Sat, 11 May 2024 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYRzmvOh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B1A1CD32;
	Sat, 11 May 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715455168; cv=none; b=PnNHQWwfVgbOLt003UJMlZZtZwmE33e/82eMGTTIop4Sgm7jHgc9aJk87ksIheuYEH92Haa6kAONXjeRWGVqyPBLRmOrOHFWeDl5EysDtsliqbQ2KulkqfTCYglwgK8y17RB1f5E2Oa/c6Wy+S3jlYvh5TBaehjLQh1tu1vkYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715455168; c=relaxed/simple;
	bh=ug8kG7vm46i4uryUsM1PUPUN/0WR3V4JrvDQBeosXkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJ1Q0vj+vk51XbiL68WDewkm3JW7QYZuyNrOJUqAZI246XXgWhrwY9bSFa5f/f0KGnxx2UjzAaynxTGg/GEZ5a6oFY5R3weuTvDwGLsGgl1d20tQ4A0gMksuzRzBjkLQQdejRbRVW2XdnZ58sr/lEpRoRbZ+DNldVnO1707ATRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYRzmvOh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715455167; x=1746991167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ug8kG7vm46i4uryUsM1PUPUN/0WR3V4JrvDQBeosXkw=;
  b=RYRzmvOhqnbidp/lhUrY2bdwnH7UMuUylON/BJPatSVa1PP4L1X8iA87
   +jAN+i5Nl3oU0RraSSSs3Q+NoPo1X/a/vp7TsLHz+MJ5rvBP3FIrjVhdA
   hZLTIYzfcLwZa1mdCFVNM6x/L0558CuAhSdsUd5rs8wV7+KXMw0E23aaK
   T/ojnApYAictns+C1u3MHhWudsfsQ1G8u/g8d72jkTHjBIjJyLE7/6V+o
   eVcPJyAPVc1jggjyz4T4ppkxRMizn7mlTfnYHO8s660C3F+mwK0K1RI6H
   90wcIz/8W4HRN6359i5gkgKDyJyEM9f1eC+95EYozl5vJ7hkYWW55xAL4
   g==;
X-CSE-ConnectionGUID: 95eCM2OZRT+9ah5JZNMnhQ==
X-CSE-MsgGUID: R/O5ZR6oQVS4mvkvrLlxug==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11285594"
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; 
   d="scan'208";a="11285594"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 12:19:25 -0700
X-CSE-ConnectionGUID: iCiQMfLtR+S1n6XUo40/3Q==
X-CSE-MsgGUID: Jj/IhAh9TFehPQYEUZXzGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; 
   d="scan'208";a="30342418"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 May 2024 12:19:22 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5sFa-0007l1-1I;
	Sat, 11 May 2024 19:19:18 +0000
Date: Sun, 12 May 2024 03:18:39 +0800
From: kernel test robot <lkp@intel.com>
To: Yasin Lee <yasin.lee.x@outlook.com>, jic23@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, lars@metafoo.de,
	swboyd@chromium.org, nuno.a@analog.com, andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor
 driver
Message-ID: <202405120331.GAhwezaB-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.9-rc7 next-20240510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/iio-proximity-hx9031as-Add-TYHX-HX9031AS-HX9023S-sensor-driver/20240510-173839
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN7PR12MB8101EDFA7F91A59761095A28A4E72%40SN7PR12MB8101.namprd12.prod.outlook.com
patch subject: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor driver
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240512/202405120331.GAhwezaB-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project b910bebc300dafb30569cecc3017b446ea8eafa0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240512/202405120331.GAhwezaB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405120331.GAhwezaB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/proximity/hx9031as.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/iio/proximity/hx9031as.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/iio/proximity/hx9031as.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/iio/proximity/hx9031as.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/proximity/hx9031as.c:1478:16: warning: stack frame size (1072) exceeds limit (1024) in 'hx9031as_dump_show' [-Wframe-larger-than]
    1478 | static ssize_t hx9031as_dump_show(struct file *file, char __user *user_buf, size_t count, loff_t *ppos)
         |                ^
   8 warnings generated.


vim +/hx9031as_dump_show +1478 drivers/iio/proximity/hx9031as.c

  1477	
> 1478	static ssize_t hx9031as_dump_show(struct file *file, char __user *user_buf, size_t count, loff_t *ppos)
  1479	{
  1480		int ret = -1;
  1481		uint8_t rx_buf[1] = {0};
  1482		char buf[BUF_SIZE * 2] = {0};
  1483		char *p = buf;
  1484		int ii = 0;
  1485	
  1486		for (ii = 0; ii < ARRAY_SIZE(hx9031as_reg_init_list); ii++) {
  1487			ret = hx9031as_read(hx9031as_reg_init_list[ii].addr, rx_buf, 1);
  1488			if (ret != 0)
  1489				PRINT_ERR("hx9031as_read failed\n");
  1490			PRINT_INF("0x%02X=0x%02X\n", hx9031as_reg_init_list[ii].addr, rx_buf[0]);
  1491			p += snprintf(p, PAGE_SIZE, "0x%02X=0x%02X\n", hx9031as_reg_init_list[ii].addr, rx_buf[0]);
  1492		}
  1493	
  1494		p += snprintf(p, PAGE_SIZE, "driver version:%s\n", HX9031AS_DRIVER_VER);
  1495	
  1496		return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
  1497	}
  1498	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

