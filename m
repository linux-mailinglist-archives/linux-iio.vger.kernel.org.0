Return-Path: <linux-iio+bounces-12909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933F09DF480
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 04:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D93162A71
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 03:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECE31EB39;
	Sun,  1 Dec 2024 03:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbPIGT6i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE4010A3E;
	Sun,  1 Dec 2024 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733023059; cv=none; b=KW3Hi1aaQFldEvy/QyX6Vf5habH/5U4hq+0beE3FKIcd6kSF8iOUFkynY0tSbLqRDFYzRkqPsWtc718Qilr0fuwP+d9ekFtlF1YrDdDm8Zo/FDHnDe2pxgub3oxSBLCKzc6HGTDiG6rpvq5KTMgau+hVMyVVGmNKdhHieIRNCfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733023059; c=relaxed/simple;
	bh=8ZWM1UzmI6V6bXywaSTwHDkGYM9wOeczaORCfASIHp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTWkT0/tP6FrAGbWBtAlHFRHMnYtCrA64rK0R0XKXXARbAJ++U5UEYo6aBi+z1TyHG112o1TSZW3Lbbys0B2ommg+RZoluqyzdbZm/j1TPvWalMGLQuDeT+WOORUURIFX5b5rKQmuOlhoG8R7oSJJaZRT8gqhrT1/uJxb8WchlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbPIGT6i; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733023058; x=1764559058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ZWM1UzmI6V6bXywaSTwHDkGYM9wOeczaORCfASIHp0=;
  b=JbPIGT6i3/42+bHr4m49Etg5HdiQ6d+ELas9TLu+ryHH+blXdpZF1yR0
   Seol0ImgDNX+A8X8jPHd4mspDaAz//A7EFv9/pYhhU+6X9AJjmMF3qeuM
   /LTxde6tVe/GtuX1FSy6tq1mSrR3lr76NxGFh+9mnQuaZTUZAT58GRJqC
   zi9CB8ojFoqDYSTX1AeWGF98yX0dZjb2OAg/aiLj10n9924MR6RGaNRgw
   ces3cHrztz/tBxHJwo0QKunBTQz/eWqEAMt/Si+nY1wiRG4E8sGu6rhdP
   s4UPxkIW4JvP5dEd+HbILUM8tTseaLzp0yImnFzQhnlMOL/lgetjLKbrS
   g==;
X-CSE-ConnectionGUID: 5Us/A+n7RDGx/xHu0BCukw==
X-CSE-MsgGUID: 9byGwM9SQR6BFkPRAa4GQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="43689094"
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="43689094"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 19:17:37 -0800
X-CSE-ConnectionGUID: 6hg/YWXCRTWIdGJ/fXIFnw==
X-CSE-MsgGUID: 0oA03bYlS0KlbrM3m5qW5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="97892803"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 30 Nov 2024 19:17:34 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHaSh-0001BV-1V;
	Sun, 01 Dec 2024 03:17:31 +0000
Date: Sun, 1 Dec 2024 11:15:56 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Kocialkowski <paulk@sys-base.io>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Kocialkowski <paulk@sys-base.io>
Subject: Re: [PATCH 2/2] iio: light: Add support for the AMS TCS3430 color
 sensor
Message-ID: <202412011132.uggaXWal-lkp@intel.com>
References: <20241130174239.3298414-2-paulk@sys-base.io>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130174239.3298414-2-paulk@sys-base.io>

Hi Paul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.12 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Kocialkowski/iio-light-Add-support-for-the-AMS-TCS3430-color-sensor/20241201-014517
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241130174239.3298414-2-paulk%40sys-base.io
patch subject: [PATCH 2/2] iio: light: Add support for the AMS TCS3430 color sensor
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20241201/202412011132.uggaXWal-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241201/202412011132.uggaXWal-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412011132.uggaXWal-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/light/tcs3430.c:7:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/iio/light/tcs3430.c:7:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/iio/light/tcs3430.c:7:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
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
   In file included from drivers/iio/light/tcs3430.c:7:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/light/tcs3430.c:134:27: warning: variable 'index' is uninitialized when used here [-Wuninitialized]
     134 |                 sensor->atime_available[index] = atime_us / USEC_PER_SEC;
         |                                         ^~~~~
   drivers/iio/light/tcs3430.c:128:20: note: initialize the variable 'index' to silence this warning
     128 |         unsigned int index;
         |                           ^
         |                            = 0
>> drivers/iio/light/tcs3430.c:565:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     565 |                 unsigned int scan_index;
         |                 ^
   drivers/iio/light/tcs3430.c:600:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     600 |                 unsigned int atime_us = state->atime_cycles *
         |                 ^
   drivers/iio/light/tcs3430.c:654:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     654 |                 unsigned int atime_us = value_first * USEC_PER_SEC +
         |                 ^
   drivers/iio/light/tcs3430.c:674:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     674 |                 unsigned int i;
         |                 ^
   18 warnings generated.


vim +/index +134 drivers/iio/light/tcs3430.c

   124	
   125	static void tcs3430_atime_available_setup(struct tcs3430_sensor *sensor)
   126	{
   127		unsigned int atime_us;
   128		unsigned int index;
   129		unsigned int i;
   130	
   131		for (i = 0; i < TCS3430_ATIME_CYCLES_MAX; i++) {
   132			atime_us = (i + 1) * TCS3430_ATIME_CYCLE_TIME_US;
   133	
 > 134			sensor->atime_available[index] = atime_us / USEC_PER_SEC;
   135			index++;
   136			sensor->atime_available[index] = atime_us % USEC_PER_SEC;
   137			index++;
   138		}
   139	}
   140	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

