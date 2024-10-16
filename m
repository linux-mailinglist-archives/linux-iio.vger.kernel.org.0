Return-Path: <linux-iio+bounces-10656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401849A07F4
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 13:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED28F285259
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 11:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B785207208;
	Wed, 16 Oct 2024 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c86G6YB7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E820605B;
	Wed, 16 Oct 2024 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076474; cv=none; b=j3kXJXUM/OkihiGD2aEn/PDlN2uzP88EkE1N6jovMeS677k1Nq0mDSF6ko64hV1RD8pTyGNwJ6uK1TkgdvFn9Ke3KXyrsKWXCiRMWTblceVJo+KxKso2DwR2pykDOmkscbMS7ZuS0S0p5AtyU1y/W4o78T44jDb1EuWG+/Zea1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076474; c=relaxed/simple;
	bh=egoYzhX+UACWenoTpdhK0zSBTuLvjaL2MI+7rxM3Rsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiGe5ybtdritEx75ZdWNuVA/0lJoRNt1NppeUoLW6XyaVO4hVX3uxIz+Wv++NDPeEn+B7gcEWsLuJDEZAtsVzAZsZN64lkEe0WkgAag1T+VIS/6zkKa+u1TVVrqFln6p2p9BUaIaBW33rN2H8KW1TXw3H7gI0O5D9ogAu1yj5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c86G6YB7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729076472; x=1760612472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=egoYzhX+UACWenoTpdhK0zSBTuLvjaL2MI+7rxM3Rsk=;
  b=c86G6YB70/zTq8HIDHffKptTCw64tW9Xg4I+FO7NvtXkIZwK9iypxihJ
   i6LZl20uBSzrh55u5Eefq3H+VxzpW+yC8t6srtgUBW48Bw8M9R8uiitbZ
   BcYMd4ug4kRA3VF4iWlKb9ce11HwC8N+gur79/Dqov6JiqQlgi/tGGAvi
   ng0rhY+Fs+xjwRPzDrwPAfQY0pvT5wEAcP86dMioW8VBN1gV/ANW94yYw
   PseBDYzZM3IK0VaCrlLLGyS2inV5VTRLkqaI9FJoNrypky4TJ++caq5/e
   pRtLcm2Od/GfNruHGR9+1dwEJtOEvoHETtHswKKIjphL/nGyH10A5hyav
   Q==;
X-CSE-ConnectionGUID: 0kh9pEfAR9qWRMTSfQ19Vg==
X-CSE-MsgGUID: tr3NxVi4QBSEIeEq9L0J3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45989993"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45989993"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 04:01:12 -0700
X-CSE-ConnectionGUID: 2+JvtSVmRFaN5iVox+zBBQ==
X-CSE-MsgGUID: 8aadeP2QQNGPIDuoQaQXdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="78253910"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Oct 2024 04:01:08 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t11m6-000KoE-0y;
	Wed, 16 Oct 2024 11:01:06 +0000
Date: Wed, 16 Oct 2024 19:00:37 +0800
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
Subject: Re: [PATCH v3 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <202410161852.GepOULQn-lkp@intel.com>
References: <20241015143713.2017626-3-perdaniel.olsson@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015143713.2017626-3-perdaniel.olsson@axis.com>

Hi Per-Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on eca631b8fe808748d7585059c4307005ca5c5820]

url:    https://github.com/intel-lab-lkp/linux/commits/Per-Daniel-Olsson/dt-bindings-iio-light-Document-TI-OPT4060-RGBW-sensor/20241015-224128
base:   eca631b8fe808748d7585059c4307005ca5c5820
patch link:    https://lore.kernel.org/r/20241015143713.2017626-3-perdaniel.olsson%40axis.com
patch subject: [PATCH v3 2/2] iio: light: Add support for TI OPT4060 color sensor
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241016/202410161852.GepOULQn-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bfe84f7085d82d06d61c632a7bad1e692fd159e4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410161852.GepOULQn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410161852.GepOULQn-lkp@intel.com/

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
>> drivers/iio/light/opt4060.c:836:2: warning: label at end of compound statement is a C23 extension [-Wc23-extensions]
     836 |         }
         |         ^
   8 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +836 drivers/iio/light/opt4060.c

   807	
   808	static int opt4060_write_event(struct iio_dev *indio_dev,
   809				       const struct iio_chan_spec *chan,
   810				       enum iio_event_type type,
   811				       enum iio_event_direction dir,
   812				       enum iio_event_info info,
   813				       int val, int val2)
   814	{
   815		struct opt4060_chip *chip = iio_priv(indio_dev);
   816	
   817		switch (info) {
   818		case IIO_EV_INFO_VALUE:
   819			if (chan->type == IIO_INTENSITY && type == IIO_EV_TYPE_THRESH) {
   820				u32 th_lo, th_hi;
   821	
   822				if (opt4060_get_thresholds(chip, &th_lo, &th_hi))
   823					return -EFAULT;
   824				if (dir == IIO_EV_DIR_FALLING)
   825					th_lo = val;
   826				else if (dir == IIO_EV_DIR_RISING)
   827					th_hi = val;
   828				if (opt4060_set_thresholds(chip, th_lo, th_hi))
   829					return -EFAULT;
   830				return 0;
   831			}
   832			break;
   833		case IIO_EV_INFO_PERIOD:
   834			return opt4060_write_ev_period(chip, val, val2);
   835		default:
 > 836		}
   837		return -EINVAL;
   838	}
   839	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

