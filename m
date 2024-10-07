Return-Path: <linux-iio+bounces-10261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C98992504
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 08:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098AB2834B8
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 06:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0A115B12F;
	Mon,  7 Oct 2024 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AceIlWT7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16214C5BA;
	Mon,  7 Oct 2024 06:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728283180; cv=none; b=ELR8ItrLOb/UCXfHz8Vv+269bpIje8bPQzUdBSZcLPDGwndKJXz69qwDDZ6RGNAGJWoYYb7bZIa7rf6kZUuyTsJKE/h6CRkff3iUfUMWadU05sCviCrs5sBWVI+YAM+WGhrpWkrd4DNxmrcTR8suohGXFdfGJFC+z6XTJSdpYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728283180; c=relaxed/simple;
	bh=YbBFZkPeegye9VkAtGQ/c94oqahowfu2r81nZFLLOKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bznuPtSrNaJ4t1rnEFmq1OJZQOWDcKNkCAdOdBpeB5pgI74drRqmNWYq6RtbYK6Zygb6ZKZaLaJFn3ZFd46WCkXjopkCAQXEesSE7AhRNKug00Xs7gtK4aQ7QPf91854aQKBVxYrDXBEYvbQrjntSYjiUi+WtZXxQlrugVRpBIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AceIlWT7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728283178; x=1759819178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YbBFZkPeegye9VkAtGQ/c94oqahowfu2r81nZFLLOKY=;
  b=AceIlWT7FUcRl8nWFPAq3Ei19nR0nxRAUdI+0q3Nizm6BJnsUTGe7cga
   7hUgfaE/nLQ60kRVOriy4DDzJn7+uCUCR5GipGWEBrY4UPFD0KiMJIOCW
   ENQywP5wp10OYtwMWaqod1xdgagwFYTm595Qn2aXs5EeTTYqel25ZeCZH
   f5b40899qZs8MjwJqRZDxYE6aVpOuNuskHC89uLibjEV+p1I1jxPhIyEP
   7OB16KPOXw48v9JkDTwry9+m1jSSifuogvoVCf93hbpNt+Qdif0D6GmQe
   FU0vi1M3k7uUPkkcz8zScN3CnmbeMZVvwjym1SSxe/95zO8L764Q6Atvv
   A==;
X-CSE-ConnectionGUID: 046HB9tZR+m3oaPTwjOwHQ==
X-CSE-MsgGUID: libr6Q88Qp+T+D0fK5PiXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38024623"
X-IronPort-AV: E=Sophos;i="6.11,183,1725346800"; 
   d="scan'208";a="38024623"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2024 23:39:37 -0700
X-CSE-ConnectionGUID: 30PtBwgiTmu5zhSIOMX8Aw==
X-CSE-MsgGUID: Z9xG+7q9RpC7DVdDFsVm4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,183,1725346800"; 
   d="scan'208";a="80202507"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Oct 2024 23:39:33 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxhP1-0004gC-0f;
	Mon, 07 Oct 2024 06:39:31 +0000
Date: Mon, 7 Oct 2024 14:38:36 +0800
From: kernel test robot <lkp@intel.com>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, rickard.andersson@axis.com,
	kernel@axis.com, Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: Re: [PATCH v2 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <202410071407.8Vp5xp85-lkp@intel.com>
References: <20241005165119.3549472-3-perdaniel.olsson@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005165119.3549472-3-perdaniel.olsson@axis.com>

Hi Per-Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0c559323bbaabee7346c12e74b497e283aaafef5]

url:    https://github.com/intel-lab-lkp/linux/commits/Per-Daniel-Olsson/dt-bindings-iio-light-Document-TI-OPT4060-RGBW-sensor/20241006-005244
base:   0c559323bbaabee7346c12e74b497e283aaafef5
patch link:    https://lore.kernel.org/r/20241005165119.3549472-3-perdaniel.olsson%40axis.com
patch subject: [PATCH v2 2/2] iio: light: Add support for TI OPT4060 color sensor
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20241007/202410071407.8Vp5xp85-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project fef3566a25ff0e34fb87339ba5e13eca17cec00f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241007/202410071407.8Vp5xp85-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410071407.8Vp5xp85-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/light/opt4060.c:11:
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
   In file included from drivers/iio/light/opt4060.c:11:
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
   In file included from drivers/iio/light/opt4060.c:11:
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
   In file included from drivers/iio/light/opt4060.c:11:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/light/opt4060.c:1026:8: warning: variable 'chan' is uninitialized when used here [-Wuninitialized]
    1026 |                                                         chan,
         |                                                         ^~~~
   include/linux/iio/events.h:54:51: note: expanded from macro 'IIO_UNMOD_EVENT_CODE'
      54 |         IIO_EVENT_CODE(chan_type, 0, 0, direction, type, number, 0, 0)
         |                                                          ^~~~~~
   include/linux/iio/events.h:29:9: note: expanded from macro 'IIO_EVENT_CODE'
      29 |          ((u16)chan))
         |                ^~~~
   drivers/iio/light/opt4060.c:994:15: note: initialize the variable 'chan' to silence this warning
     994 |         int ret, chan, dummy;
         |                      ^
         |                       = 0
   14 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/chan +1026 drivers/iio/light/opt4060.c

   989	
   990	static irqreturn_t opt4060_irq_thread(int irq, void *private)
   991	{
   992		struct iio_dev *idev = private;
   993		struct opt4060_chip *chip = iio_priv(idev);
   994		int ret, chan, dummy;
   995		unsigned int int_res;
   996	
   997		ret = regmap_read(chip->regmap, OPT4060_RES_CTRL, &int_res);
   998		if (ret < 0) {
   999			dev_err(chip->dev, "Failed to read interrupt reasons.\n");
  1000			return IRQ_NONE;
  1001		}
  1002	
  1003		if (!chip->data_trigger_active) {
  1004			/* Only trigger interrupts on thresholds */
  1005			ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_THRESHOLD);
  1006			if (ret) {
  1007				dev_err(chip->dev, "Failed to set interrupt state\n");
  1008				return IRQ_NONE;
  1009			}
  1010		}
  1011	
  1012		/* Read OPT4060_CTRL to clear interrupt */
  1013		ret = regmap_read(chip->regmap, OPT4060_CTRL, &dummy);
  1014		if (ret < 0) {
  1015			dev_err(chip->dev, "Failed to clear interrupt\n");
  1016			return IRQ_NONE;
  1017		}
  1018	
  1019		/* Handle events */
  1020		if (int_res & (OPT4060_RES_CTRL_FLAG_H | OPT4060_RES_CTRL_FLAG_L)) {
  1021			u64 code;
  1022	
  1023			/* Check if the interrupt is from the lower threshold */
  1024			if (int_res & OPT4060_RES_CTRL_FLAG_L) {
  1025				code = IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> 1026								chan,
  1027								IIO_EV_TYPE_THRESH,
  1028								IIO_EV_DIR_FALLING);
  1029				iio_push_event(idev, code,
  1030						iio_get_time_ns(idev));
  1031			}
  1032			/* Check if the interrupt is from the upper threshold */
  1033			if (int_res & OPT4060_RES_CTRL_FLAG_H) {
  1034				code = IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
  1035								chan,
  1036								IIO_EV_TYPE_THRESH,
  1037								IIO_EV_DIR_RISING);
  1038				iio_push_event(idev, code,
  1039						iio_get_time_ns(idev));
  1040			}
  1041			/* Handle threshold triggers */
  1042			if (chip->threshold_trigger_active && iio_buffer_enabled(idev))
  1043				iio_trigger_poll_nested(chip->threshold_trig);
  1044		}
  1045	
  1046		/* Handle conversion ready */
  1047		if (int_res & OPT4060_RES_CTRL_CONV_READY) {
  1048			/* Signal completion for potentially waiting reads */
  1049			complete(&chip->completion);
  1050	
  1051			/* Handle data ready triggers */
  1052			if (chip->data_trigger_active && iio_buffer_enabled(idev))
  1053				iio_trigger_poll_nested(chip->data_trig);
  1054		}
  1055		return IRQ_HANDLED;
  1056	}
  1057	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

