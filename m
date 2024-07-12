Return-Path: <linux-iio+bounces-7575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F79893021D
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 00:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C9D283222
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FB361FD7;
	Fri, 12 Jul 2024 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkME25JV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1EB2E646;
	Fri, 12 Jul 2024 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720822993; cv=none; b=u1DHyDIAzlCueDdW4rM5WKkdAFD0owWPUeMO426neau9vm60Y/lvuxlWSsCaEtFFT8DcQJqpTPv2rzNvza8J/+Q9TjfH81iB4hRG/dR3MoQcLiREBLOwmmCGKjtXWV4nUSPjj6/u5QDIJdVIYODnc34aDKw08AVoLagjsUp6s+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720822993; c=relaxed/simple;
	bh=K6N5CSC4H/en2ay5Qoh+pUoG1uPZKGk6EcbBsHokIc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSlNXLtinaRyFeQ1oPTYbmTnAyLoSPqCVRJk6rpuFZ4cmqJYPeF0JpS6u+nR0XOWEeWfpul5L1XLJtkwxLU5k5V2vuPPXzXE2Ue69AfuNwOaSuC95sRe+guvViKh0awOwaI9pHeT/QhfhROOpiSXF/twVxdTEf2Um7puEGCw7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkME25JV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720822992; x=1752358992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K6N5CSC4H/en2ay5Qoh+pUoG1uPZKGk6EcbBsHokIc0=;
  b=MkME25JVKQYYvINaQMcnlPVQG6Zn+FkAFo/81xRfvw2BfeJr8KlA73NG
   vmBpk8aakgJeFupyJa2DWLLgiGWPvmFSoyQaMBTg3jRKLU7bbtUXR9aUq
   /H1f2OyRE3Vrv8iPj3I9Es/Z2V4EXnKKp3pBALUSCaEHsPb0SHwrz8oM0
   5OUGLWYOLpY1WAI2zfNSEqsMvt67EHnfQvJtIhx7d0SX04aap45DOUj23
   3PKeTTvd4l4I6ZMZMxESGpp40zhuTd95xOKLEoq8LUrQ5VMADIPCzVQQL
   nzo7hZyJOwTZB8DAz6tKKSrJWbhqj45phVc5JV7uYS3lDvMO12hSZWOWD
   w==;
X-CSE-ConnectionGUID: w2b0lBJXThCFLNtQ4KJmDw==
X-CSE-MsgGUID: t8AppLoVTZCisyAnlGaCMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="22098626"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="22098626"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:23:11 -0700
X-CSE-ConnectionGUID: tJ4W7IPiT8efceDp4IVijw==
X-CSE-MsgGUID: t0g6glJhRtifbom/d/AWLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="53871737"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 Jul 2024 15:22:57 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSOfA-000bN6-0Q;
	Fri, 12 Jul 2024 22:22:48 +0000
Date: Sat, 13 Jul 2024 06:22:43 +0800
From: kernel test robot <lkp@intel.com>
To: wangshuaijie@awinic.com, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	waqar.hameed@axis.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	wangshuaijie@awinic.com, liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V3 2/2] Add support for Awinic proximity sensor
Message-ID: <202407130649.s20WgzXd-lkp@intel.com>
References: <20240712113200.2468249-3-wangshuaijie@awinic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712113200.2468249-3-wangshuaijie@awinic.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 43db1e03c086ed20cc75808d3f45e780ec4ca26e]

url:    https://github.com/intel-lab-lkp/linux/commits/wangshuaijie-awinic-com/dt-bindings-iio-Add-YAML-to-Awinic-proximity-sensor/20240712-194024
base:   43db1e03c086ed20cc75808d3f45e780ec4ca26e
patch link:    https://lore.kernel.org/r/20240712113200.2468249-3-wangshuaijie%40awinic.com
patch subject: [PATCH V3 2/2] Add support for Awinic proximity sensor
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240713/202407130649.s20WgzXd-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240713/202407130649.s20WgzXd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407130649.s20WgzXd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/proximity/aw9610x.c:9:
   In file included from drivers/iio/proximity/aw_sar.h:4:
   In file included from drivers/iio/proximity/aw_sar_type.h:5:
   In file included from drivers/iio/proximity/aw_sar_comm_interface.h:6:
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
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/iio/proximity/aw9610x.c:9:
   In file included from drivers/iio/proximity/aw_sar.h:4:
   In file included from drivers/iio/proximity/aw_sar_type.h:5:
   In file included from drivers/iio/proximity/aw_sar_comm_interface.h:6:
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
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/iio/proximity/aw9610x.c:9:
   In file included from drivers/iio/proximity/aw_sar.h:4:
   In file included from drivers/iio/proximity/aw_sar_type.h:5:
   In file included from drivers/iio/proximity/aw_sar_comm_interface.h:6:
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
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/iio/proximity/aw9610x.c:9:
   In file included from drivers/iio/proximity/aw_sar.h:4:
   In file included from drivers/iio/proximity/aw_sar_type.h:5:
   In file included from drivers/iio/proximity/aw_sar_comm_interface.h:6:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2258:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/proximity/aw9610x.c:709:16: warning: stack frame size (1432) exceeds limit (1024) in 'aw9610x_awrw_set' [-Wframe-larger-than]
     709 | static ssize_t aw9610x_awrw_set(void *data, const char *buf, size_t count)
         |                ^
   8 warnings generated.


vim +/aw9610x_awrw_set +709 drivers/iio/proximity/aw9610x.c

   708	
 > 709	static ssize_t aw9610x_awrw_set(void *data, const char *buf, size_t count)
   710	{
   711		struct aw_sar *p_sar = (struct aw_sar *)data;
   712		struct aw9610x *aw9610x = (struct aw9610x *)p_sar->priv_data;
   713		unsigned int datatype[3] = { 0 };
   714	
   715		if (sscanf(buf, "%u %u %u", &datatype[0], &datatype[1], &datatype[2]) == 3) {
   716			aw9610x->aw_i2c_package.addr_bytes = (unsigned char)datatype[0];
   717			aw9610x->aw_i2c_package.data_bytes = (unsigned char)datatype[1];
   718			aw9610x->aw_i2c_package.reg_num = (unsigned char)datatype[2];
   719	
   720			aw9610x_addrblock_load(p_sar, buf);
   721			if (count > 7 + 5 * aw9610x->aw_i2c_package.addr_bytes)
   722				aw9610x_datablock_load(p_sar, buf);
   723		}
   724	
   725		return count;
   726	}
   727	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

