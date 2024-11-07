Return-Path: <linux-iio+bounces-11954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E19BFAD6
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 01:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A1C1F22227
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 00:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358234400;
	Thu,  7 Nov 2024 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYiMxdQh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8321372;
	Thu,  7 Nov 2024 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730940050; cv=none; b=M3aMZEacnvZ2HmEF28Pfq4pBsEAPE8zjK7q6w+L74s/LimRf8UQ57c6VkbKnTp6vkpgD2Sijwn4eh58B2egaebbdvuoZlXR1P/5C/jCjH2L6jzTKgtg9lNcfwIwv8k+7KAniJLHCnIkbvSiNxq9TZ7M0q9R3HUgy+LEe29zb6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730940050; c=relaxed/simple;
	bh=wFExB3X0ZOVDOHsnzWaW9WtKIahdudkh2j75TXgIeiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3OA2kfy101DYWgaJ0PUZbgr1nfT3I3fPKf+Qi5nn9hQ3ddi0BhllJhhiGCzanQJEwXpeZ2wUfnEXRGch5HQfE9nL6yfOvabuqM6PGH0TgVmvKkT6sSTQD2slwDplJGwWb+nTnBagXQVU2JAjGui+spRQSP5uX9IFIVlgQv/Hik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYiMxdQh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730940048; x=1762476048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wFExB3X0ZOVDOHsnzWaW9WtKIahdudkh2j75TXgIeiA=;
  b=aYiMxdQhfSDhlTA/OyTXhzv7Zb2zHSYDe1HYrrToz0vmmnuWsQxjljxF
   Ha+Uvzv9L/lJ0r6fGnhoG0/AUHk+9pm1P4Tkbq9iNs2gl2vADj3Q8OuE+
   5+um8yI5Mg3/vU6WF3wWld7+zw/Vnrla9vhU/c7oNfuZx83ZLSvZpXbQd
   sB509LwqEgwp3EHqSWuM4EjSINhfC3LOjLeEG0tY68onOOx3OAW9AH8ds
   y/PCz3nd6cbw8VSN1h2lhY7EERGi2lkbg9IG5PkXw5M1nlBodm1uuLi4X
   xlGIbLJsCHEVoDDAUzvbuAmBsJaTYEWmMYksqA4n8Mk09UKvJJHQuqzX7
   A==;
X-CSE-ConnectionGUID: HdI2Ya97SQCdqNjzSFI0Hw==
X-CSE-MsgGUID: bRUa1HXFSSWe29cW8BXoKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30171982"
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="30171982"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 16:40:47 -0800
X-CSE-ConnectionGUID: j7Hm+BxMRTmoOEoqtc9Qkw==
X-CSE-MsgGUID: +ZZNKNylQkmR6qMd9uenrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="84799043"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Nov 2024 16:40:44 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8qZl-000pZq-2B;
	Thu, 07 Nov 2024 00:40:41 +0000
Date: Thu, 7 Nov 2024 08:39:56 +0800
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
Subject: Re: [PATCH v5 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <202411070820.GxSGRFR6-lkp@intel.com>
References: <20241106120036.986755-3-perdaniel.olsson@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106120036.986755-3-perdaniel.olsson@axis.com>

Hi Per-Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v6.12-rc6 next-20241106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Per-Daniel-Olsson/dt-bindings-iio-light-Document-TI-OPT4060-RGBW-sensor/20241106-200407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241106120036.986755-3-perdaniel.olsson%40axis.com
patch subject: [PATCH v5 2/2] iio: light: Add support for TI OPT4060 color sensor
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241107/202411070820.GxSGRFR6-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241107/202411070820.GxSGRFR6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411070820.GxSGRFR6-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/iio/light/opt4060.c:11:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
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
>> drivers/iio/light/opt4060.c:847:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     847 |                 u32 th_lo, th_hi;
         |                 ^
   drivers/iio/light/opt4060.c:884:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     884 |                 u32 th_lo, th_hi;
         |                 ^
>> drivers/iio/light/opt4060.c:977:24: error: incompatible function pointer types initializing 'int (*)(struct iio_dev *, const struct iio_chan_spec *, enum iio_event_type, enum iio_event_direction, bool)' (aka 'int (*)(struct iio_dev *, const struct iio_chan_spec *, enum iio_event_type, enum iio_event_direction, _Bool)') with an expression of type 'int (struct iio_dev *, const struct iio_chan_spec *, enum iio_event_type, enum iio_event_direction, int)' [-Wincompatible-function-pointer-types]
     977 |         .write_event_config = opt4060_write_event_config,
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~
   6 warnings and 1 error generated.


vim +977 drivers/iio/light/opt4060.c

   829	
   830	static int opt4060_read_event(struct iio_dev *indio_dev,
   831				      const struct iio_chan_spec *chan,
   832				      enum iio_event_type type,
   833				      enum iio_event_direction dir,
   834				      enum iio_event_info info,
   835				      int *val, int *val2)
   836	{
   837		int ret;
   838		struct opt4060_chip *chip = iio_priv(indio_dev);
   839	
   840		if (chan->type != IIO_INTENSITY)
   841			return -EINVAL;
   842		if (type != IIO_EV_TYPE_THRESH)
   843			return -EINVAL;
   844	
   845		switch (info) {
   846		case IIO_EV_INFO_VALUE:
 > 847			u32 th_lo, th_hi;
   848	
   849			ret = opt4060_get_thresholds(chip, &th_lo, &th_hi);
   850			if (ret)
   851				return ret;
   852			if (dir == IIO_EV_DIR_FALLING) {
   853				*val = th_lo;
   854				ret = IIO_VAL_INT;
   855			} else if (dir == IIO_EV_DIR_RISING) {
   856				*val = th_hi;
   857				ret = IIO_VAL_INT;
   858			}
   859			return ret;
   860		case IIO_EV_INFO_PERIOD:
   861			return opt4060_read_ev_period(chip, val, val2);
   862		default:
   863			return -EINVAL;
   864		}
   865	}
   866	
   867	static int opt4060_write_event(struct iio_dev *indio_dev,
   868				       const struct iio_chan_spec *chan,
   869				       enum iio_event_type type,
   870				       enum iio_event_direction dir,
   871				       enum iio_event_info info,
   872				       int val, int val2)
   873	{
   874		struct opt4060_chip *chip = iio_priv(indio_dev);
   875		int ret;
   876	
   877		if (chan->type != IIO_INTENSITY)
   878			return -EINVAL;
   879		if (type != IIO_EV_TYPE_THRESH)
   880			return -EINVAL;
   881	
   882		switch (info) {
   883		case IIO_EV_INFO_VALUE:
   884			u32 th_lo, th_hi;
   885	
   886			ret = opt4060_get_thresholds(chip, &th_lo, &th_hi);
   887			if (ret)
   888				return ret;
   889			if (dir == IIO_EV_DIR_FALLING)
   890				th_lo = val;
   891			else if (dir == IIO_EV_DIR_RISING)
   892				th_hi = val;
   893			return opt4060_set_thresholds(chip, th_lo, th_hi);
   894		case IIO_EV_INFO_PERIOD:
   895			return opt4060_write_ev_period(chip, val, val2);
   896		default:
   897			return -EINVAL;
   898		}
   899	}
   900	
   901	static int opt4060_read_event_config(struct iio_dev *indio_dev,
   902					     const struct iio_chan_spec *chan,
   903					     enum iio_event_type type,
   904					     enum iio_event_direction dir)
   905	{
   906		int ch_sel, ch_idx = chan->scan_index;
   907		struct opt4060_chip *chip = iio_priv(indio_dev);
   908		int ret;
   909	
   910		if (chan->type != IIO_INTENSITY)
   911			return -EINVAL;
   912		if (type != IIO_EV_TYPE_THRESH)
   913			return -EINVAL;
   914	
   915		ret = opt4060_get_channel_sel(chip, &ch_sel);
   916		if (ret)
   917			return ret;
   918	
   919		if (((dir == IIO_EV_DIR_FALLING) && chip->thresh_event_lo_active) ||
   920		    ((dir == IIO_EV_DIR_RISING) && chip->thresh_event_hi_active))
   921			return ch_sel == ch_idx;
   922	
   923		return ret;
   924	}
   925	
   926	static int opt4060_write_event_config(struct iio_dev *indio_dev,
   927					      const struct iio_chan_spec *chan,
   928					      enum iio_event_type type,
   929					      enum iio_event_direction dir, int state)
   930	{
   931		int ch_sel, ch_idx = chan->scan_index;
   932		struct opt4060_chip *chip = iio_priv(indio_dev);
   933		int ret;
   934	
   935		if (chan->type != IIO_INTENSITY)
   936			return -EINVAL;
   937		if (type != IIO_EV_TYPE_THRESH)
   938			return -EINVAL;
   939	
   940		ret = opt4060_get_channel_sel(chip, &ch_sel);
   941		if (ret)
   942			return ret;
   943	
   944		if (state) {
   945			/* Only one channel can be active at the same time */
   946			if ((chip->thresh_event_lo_active ||
   947				chip->thresh_event_hi_active) && (ch_idx != ch_sel))
   948				return -EBUSY;
   949			if (dir == IIO_EV_DIR_FALLING)
   950				chip->thresh_event_lo_active = true;
   951			else if (dir == IIO_EV_DIR_RISING)
   952				chip->thresh_event_hi_active = true;
   953			ret = opt4060_set_channel_sel(chip, ch_idx);
   954			if (ret)
   955				return ret;
   956		} else {
   957			if (ch_idx == ch_sel) {
   958				if (dir == IIO_EV_DIR_FALLING)
   959					chip->thresh_event_lo_active = false;
   960				else if (dir == IIO_EV_DIR_RISING)
   961					chip->thresh_event_hi_active = false;
   962			}
   963		}
   964	
   965		return opt4060_event_set_state(indio_dev, chip->thresh_event_hi_active |
   966					       chip->thresh_event_lo_active);
   967	}
   968	
   969	static const struct iio_info opt4060_info = {
   970		.read_raw = opt4060_read_raw,
   971		.write_raw = opt4060_write_raw,
   972		.write_raw_get_fmt = opt4060_write_raw_get_fmt,
   973		.read_avail = opt4060_read_available,
   974		.read_event_value = opt4060_read_event,
   975		.write_event_value = opt4060_write_event,
   976		.read_event_config = opt4060_read_event_config,
 > 977		.write_event_config = opt4060_write_event_config,
   978	};
   979	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

