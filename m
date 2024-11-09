Return-Path: <linux-iio+bounces-12082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4DB9C2DD6
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 15:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A767E1C20D47
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F352F197A92;
	Sat,  9 Nov 2024 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbslrb+k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501C155322;
	Sat,  9 Nov 2024 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731163487; cv=none; b=IyqOkKQzF5QHyUgU9x0iEnz7t/sK1pjEE5Z6RZ6bETUI3cCGivA+/WhUFTiFh+GYOGShb8qeHIvVpJhzKokxV5xy9MgqVPOcObs+vMIENMNDHAmwARrcIKlnMj3dtiv1WapTSfFzFAwdrMVt+0oo8l2+U4GbJAE1ktqgZ+Wz70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731163487; c=relaxed/simple;
	bh=weSm0YjYu27aKnLWXNTkSsfDtVn2MLb2C0lRPRWOg8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5ahO1vNi3Xi4pEnaGAfuPMdNmljiUI64XcRN6JmtPHaLkRLPjVp9Y+y+clTAgJtI4ItbuPIlYc/r7tkxcG1EGzFeHH6GqJNYXH0g1EVaF2Nay0v1NnMqcTyFZT5eQDnVYKP9/5bsx09TwKbI/Jto/U1uTUAu6eQ6ZKB6vW+I0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbslrb+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09594C4CED2;
	Sat,  9 Nov 2024 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731163487;
	bh=weSm0YjYu27aKnLWXNTkSsfDtVn2MLb2C0lRPRWOg8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pbslrb+kTQlwJK6bP7byxrN2O2mB3WGD4Xdy3HCkndKW1I0GjjFyxRUfV/Hr5xDXK
	 fDm7gwORHdcyDCi1d/LMILegcpWbPzgdGea13R1mLscaaeAgIfD3sV+C/yl/+e7EYr
	 JkGbvTIWqim9l7OBTwrxWw/X0odnclUysx3Pwz1XitXaDlOSDzHWWUpyeO/gqNoS0Q
	 zeRXKZbvqC54Xoh3NaqU/M/aJz4oKCdD4C1Be1j1WWQhW40XoFjlhMfrQvncJKlf+y
	 lIoSd7NUzlUNyO8Nud62OFD0gNBY00PhdjPOqCpVAzYwOCtCk+J2TANGjNLNKL4Vuz
	 LDeXprXmqu7gQ==
Date: Sat, 9 Nov 2024 14:44:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Per-Daniel Olsson <perdaniel.olsson@axis.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, rickard.andersson@axis.com, kernel@axis.com
Subject: Re: [PATCH v5 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <20241109144438.575249df@jic23-huawei>
In-Reply-To: <202411070820.GxSGRFR6-lkp@intel.com>
References: <20241106120036.986755-3-perdaniel.olsson@axis.com>
	<202411070820.GxSGRFR6-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 08:39:56 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Per-Daniel,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on jic23-iio/togreg]
> [also build test ERROR on robh/for-next linus/master v6.12-rc6 next-20241106]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Per-Daniel-Olsson/dt-bindings-iio-light-Document-TI-OPT4060-RGBW-sensor/20241106-200407
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20241106120036.986755-3-perdaniel.olsson%40axis.com
> patch subject: [PATCH v5 2/2] iio: light: Add support for TI OPT4060 color sensor
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241107/202411070820.GxSGRFR6-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241107/202411070820.GxSGRFR6-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411070820.GxSGRFR6-lkp@intel.com/

As you have probably realized, your series crossed with a change of parameter type.

If there is nothing else to warrant a respin I can fix this up whilst applying.

Jonathan

> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from drivers/iio/light/opt4060.c:11:
>    In file included from include/linux/i2c.h:19:
>    In file included from include/linux/regulator/consumer.h:35:
>    In file included from include/linux/suspend.h:5:
>    In file included from include/linux/swap.h:9:
>    In file included from include/linux/memcontrol.h:21:
>    In file included from include/linux/mm.h:2213:
>    include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      505 |                            item];
>          |                            ~~~~
>    include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      512 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
>    include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      525 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/iio/light/opt4060.c:847:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]  
>      847 |                 u32 th_lo, th_hi;
>          |                 ^
>    drivers/iio/light/opt4060.c:884:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
>      884 |                 u32 th_lo, th_hi;
>          |                 ^
> >> drivers/iio/light/opt4060.c:977:24: error: incompatible function pointer types initializing 'int (*)(struct iio_dev *, const struct iio_chan_spec *, enum iio_event_type, enum iio_event_direction, bool)' (aka 'int (*)(struct iio_dev *, const struct iio_chan_spec *, enum iio_event_type, enum iio_event_direction, _Bool)') with an expression of type 'int (struct iio_dev *, const struct iio_chan_spec *, enum iio_event_type, enum iio_event_direction, int)' [-Wincompatible-function-pointer-types]  
>      977 |         .write_event_config = opt4060_write_event_config,
>          |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    6 warnings and 1 error generated.
> 
> 
> vim +977 drivers/iio/light/opt4060.c
> 
>    829	
>    830	static int opt4060_read_event(struct iio_dev *indio_dev,
>    831				      const struct iio_chan_spec *chan,
>    832				      enum iio_event_type type,
>    833				      enum iio_event_direction dir,
>    834				      enum iio_event_info info,
>    835				      int *val, int *val2)
>    836	{
>    837		int ret;
>    838		struct opt4060_chip *chip = iio_priv(indio_dev);
>    839	
>    840		if (chan->type != IIO_INTENSITY)
>    841			return -EINVAL;
>    842		if (type != IIO_EV_TYPE_THRESH)
>    843			return -EINVAL;
>    844	
>    845		switch (info) {
>    846		case IIO_EV_INFO_VALUE:
>  > 847			u32 th_lo, th_hi;  
>    848	
>    849			ret = opt4060_get_thresholds(chip, &th_lo, &th_hi);
>    850			if (ret)
>    851				return ret;
>    852			if (dir == IIO_EV_DIR_FALLING) {
>    853				*val = th_lo;
>    854				ret = IIO_VAL_INT;
>    855			} else if (dir == IIO_EV_DIR_RISING) {
>    856				*val = th_hi;
>    857				ret = IIO_VAL_INT;
>    858			}
>    859			return ret;
>    860		case IIO_EV_INFO_PERIOD:
>    861			return opt4060_read_ev_period(chip, val, val2);
>    862		default:
>    863			return -EINVAL;
>    864		}
>    865	}
>    866	
>    867	static int opt4060_write_event(struct iio_dev *indio_dev,
>    868				       const struct iio_chan_spec *chan,
>    869				       enum iio_event_type type,
>    870				       enum iio_event_direction dir,
>    871				       enum iio_event_info info,
>    872				       int val, int val2)
>    873	{
>    874		struct opt4060_chip *chip = iio_priv(indio_dev);
>    875		int ret;
>    876	
>    877		if (chan->type != IIO_INTENSITY)
>    878			return -EINVAL;
>    879		if (type != IIO_EV_TYPE_THRESH)
>    880			return -EINVAL;
>    881	
>    882		switch (info) {
>    883		case IIO_EV_INFO_VALUE:
>    884			u32 th_lo, th_hi;
>    885	
>    886			ret = opt4060_get_thresholds(chip, &th_lo, &th_hi);
>    887			if (ret)
>    888				return ret;
>    889			if (dir == IIO_EV_DIR_FALLING)
>    890				th_lo = val;
>    891			else if (dir == IIO_EV_DIR_RISING)
>    892				th_hi = val;
>    893			return opt4060_set_thresholds(chip, th_lo, th_hi);
>    894		case IIO_EV_INFO_PERIOD:
>    895			return opt4060_write_ev_period(chip, val, val2);
>    896		default:
>    897			return -EINVAL;
>    898		}
>    899	}
>    900	
>    901	static int opt4060_read_event_config(struct iio_dev *indio_dev,
>    902					     const struct iio_chan_spec *chan,
>    903					     enum iio_event_type type,
>    904					     enum iio_event_direction dir)
>    905	{
>    906		int ch_sel, ch_idx = chan->scan_index;
>    907		struct opt4060_chip *chip = iio_priv(indio_dev);
>    908		int ret;
>    909	
>    910		if (chan->type != IIO_INTENSITY)
>    911			return -EINVAL;
>    912		if (type != IIO_EV_TYPE_THRESH)
>    913			return -EINVAL;
>    914	
>    915		ret = opt4060_get_channel_sel(chip, &ch_sel);
>    916		if (ret)
>    917			return ret;
>    918	
>    919		if (((dir == IIO_EV_DIR_FALLING) && chip->thresh_event_lo_active) ||
>    920		    ((dir == IIO_EV_DIR_RISING) && chip->thresh_event_hi_active))
>    921			return ch_sel == ch_idx;
>    922	
>    923		return ret;
>    924	}
>    925	
>    926	static int opt4060_write_event_config(struct iio_dev *indio_dev,
>    927					      const struct iio_chan_spec *chan,
>    928					      enum iio_event_type type,
>    929					      enum iio_event_direction dir, int state)
>    930	{
>    931		int ch_sel, ch_idx = chan->scan_index;
>    932		struct opt4060_chip *chip = iio_priv(indio_dev);
>    933		int ret;
>    934	
>    935		if (chan->type != IIO_INTENSITY)
>    936			return -EINVAL;
>    937		if (type != IIO_EV_TYPE_THRESH)
>    938			return -EINVAL;
>    939	
>    940		ret = opt4060_get_channel_sel(chip, &ch_sel);
>    941		if (ret)
>    942			return ret;
>    943	
>    944		if (state) {
>    945			/* Only one channel can be active at the same time */
>    946			if ((chip->thresh_event_lo_active ||
>    947				chip->thresh_event_hi_active) && (ch_idx != ch_sel))
>    948				return -EBUSY;
>    949			if (dir == IIO_EV_DIR_FALLING)
>    950				chip->thresh_event_lo_active = true;
>    951			else if (dir == IIO_EV_DIR_RISING)
>    952				chip->thresh_event_hi_active = true;
>    953			ret = opt4060_set_channel_sel(chip, ch_idx);
>    954			if (ret)
>    955				return ret;
>    956		} else {
>    957			if (ch_idx == ch_sel) {
>    958				if (dir == IIO_EV_DIR_FALLING)
>    959					chip->thresh_event_lo_active = false;
>    960				else if (dir == IIO_EV_DIR_RISING)
>    961					chip->thresh_event_hi_active = false;
>    962			}
>    963		}
>    964	
>    965		return opt4060_event_set_state(indio_dev, chip->thresh_event_hi_active |
>    966					       chip->thresh_event_lo_active);
>    967	}
>    968	
>    969	static const struct iio_info opt4060_info = {
>    970		.read_raw = opt4060_read_raw,
>    971		.write_raw = opt4060_write_raw,
>    972		.write_raw_get_fmt = opt4060_write_raw_get_fmt,
>    973		.read_avail = opt4060_read_available,
>    974		.read_event_value = opt4060_read_event,
>    975		.write_event_value = opt4060_write_event,
>    976		.read_event_config = opt4060_read_event_config,
>  > 977		.write_event_config = opt4060_write_event_config,  
>    978	};
>    979	
> 


