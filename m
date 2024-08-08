Return-Path: <linux-iio+bounces-8322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B5494B956
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 10:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B21928278D
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 08:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77734189B94;
	Thu,  8 Aug 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HayDAs1J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8757D189914;
	Thu,  8 Aug 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107203; cv=none; b=pn4o8qJkA/KdK4+CZ1n9F13xn9ip0TY47HJJJy+08YqNPYpu5cF9IIUH42xzUIV0w5LiknalQBkkIh+uRLgGDwuIQby9hg6X3Go4VD4cHnYr4RB0Q8Skdp4fySJK/HrinWAialt7LfyKSkvMrp6EAAQYG5miMLjgeu+R0GPVpbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107203; c=relaxed/simple;
	bh=gQ1tJG9N6SvPT5+hu2o4fz+MI6OXlvuYXLedjN+ULio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKrkQdMFj7mLHngMXlBd/48+5EUkdvsx0AGIBa1Q70ab8SiDYW/uB3QRzn7EDFO+/jdyiZORVz3QnvW87Ib2Ew/3wr/ECjLq2GBEZK2c4DP/9adkN2M4iG76ZOoSLp/v5BtxL+7fPZu6Ho8MP4gYdiWzlYGTBSnf4ioqN0eFE60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HayDAs1J; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723107201; x=1754643201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gQ1tJG9N6SvPT5+hu2o4fz+MI6OXlvuYXLedjN+ULio=;
  b=HayDAs1J22ups1xivwEVSufYN9embfSuepnwfYz4Qi8Vj52+GToBn97W
   Mk8KCpt1J+UjdzhmzbD6hgz0dNYhzb4mKhGLrKWAUOFN1QwcPDnHTMbLQ
   uxzrn6YoyjiAB6j1lvEzUuqKWdMJA+KPHeVdEaJIGCZUpAPyvInab9mrh
   J/bYe6rF953MUf/AFPDI0PNP6pT8Vjp9KAn0SqNZE+l5B7Jo32dgJUT2R
   0FMxm08Tj9SwXOKvd/XrIqMKkM7N4ZEhiV+/z8lUedCldIk/FsL40XvKR
   z6VpnDVXRYKSTJg+oTXLo09dhq8Ul9IfmcvriSXk3mFHu3ART07dz7tdm
   A==;
X-CSE-ConnectionGUID: XWzo/u/fRNmnFY3sT2TbtA==
X-CSE-MsgGUID: MS+sLhYOQCCuJoyOSKymMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32610876"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="32610876"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 01:53:21 -0700
X-CSE-ConnectionGUID: GzCMqjNDT/Odyx2wNMB5QA==
X-CSE-MsgGUID: kjhLbdQFSwSXwsFjXeNwww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="56836211"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 08 Aug 2024 01:53:18 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbytF-000641-2C;
	Thu, 08 Aug 2024 08:53:05 +0000
Date: Thu, 8 Aug 2024 16:52:09 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad4695: implement triggered buffer
Message-ID: <202408081623.ua9EBfoZ-lkp@intel.com>
References: <20240807-iio-adc-ad4695-buffered-read-v1-1-bdafc39b2283@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-iio-adc-ad4695-buffered-read-v1-1-bdafc39b2283@baylibre.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7cad163c39cb642ed587d3eeb37a5637ee02740f]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-adc-ad4695-implement-triggered-buffer/20240808-063333
base:   7cad163c39cb642ed587d3eeb37a5637ee02740f
patch link:    https://lore.kernel.org/r/20240807-iio-adc-ad4695-buffered-read-v1-1-bdafc39b2283%40baylibre.com
patch subject: [PATCH 1/2] iio: adc: ad4695: implement triggered buffer
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240808/202408081623.ua9EBfoZ-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 408d82d352eb98e2d0a804c66d359cd7a49228fe)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408081623.ua9EBfoZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408081623.ua9EBfoZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/adc/ad4695.c:24:
   In file included from include/linux/iio/triggered_buffer.h:6:
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
   In file included from drivers/iio/adc/ad4695.c:24:
   In file included from include/linux/iio/triggered_buffer.h:6:
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
   In file included from drivers/iio/adc/ad4695.c:24:
   In file included from include/linux/iio/triggered_buffer.h:6:
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
   In file included from drivers/iio/adc/ad4695.c:28:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/adc/ad4695.c:454:8: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     454 |         val = FIELD_PREP(mask, temp_chan_en ? 1 : 0);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
      73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      74 |                                  _pfx "type of reg too small for mask"); \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   8 warnings generated.


vim +454 drivers/iio/adc/ad4695.c

   373	
   374	static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
   375	{
   376		struct ad4695_state *st = iio_priv(indio_dev);
   377		struct spi_transfer *xfer;
   378		u8 temp_chan_bit = st->chip_info->num_voltage_inputs;
   379		bool temp_chan_en = false;
   380		u32 reg, mask, val, bit, num_xfer, num_slots;
   381		int ret;
   382	
   383		/*
   384		 * We are using the advanced sequencer since it is the only way to read
   385		 * multiple channels that allows individual configuration of each
   386		 * voltage input channel. Slot 0 in the advanced sequencer is used to
   387		 * account for the gap between trigger polls - we don't read data from
   388		 * this slot. Each enabled voltage channel is assigned a slot starting
   389		 * with slot 1.
   390		 */
   391		num_slots = 1;
   392	
   393		memset(st->buf_read_xfer, 0, sizeof(st->buf_read_xfer));
   394	
   395		/* First xfer is only to trigger conversion of slot 1, so no rx. */
   396		xfer = &st->buf_read_xfer[0];
   397		xfer->cs_change = 1;
   398		xfer->delay.value = AD4695_T_CNVL_NS;
   399		xfer->delay.unit = SPI_DELAY_UNIT_NSECS;
   400		xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
   401		xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
   402		num_xfer = 1;
   403	
   404		iio_for_each_active_channel(indio_dev, bit) {
   405			xfer = &st->buf_read_xfer[num_xfer];
   406			xfer->bits_per_word = 16;
   407			xfer->rx_buf = &st->buf[(num_xfer - 1) * 2];
   408			xfer->len = 2;
   409			xfer->cs_change = 1;
   410			xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
   411			xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
   412	
   413			if (bit == temp_chan_bit) {
   414				temp_chan_en = true;
   415			} else {
   416				reg = AD4695_REG_AS_SLOT(num_slots);
   417				val = FIELD_PREP(AD4695_REG_AS_SLOT_INX, bit);
   418	
   419				ret = regmap_write(st->regmap, reg, val);
   420				if (ret)
   421					return ret;
   422	
   423				num_slots++;
   424			}
   425	
   426			num_xfer++;
   427		}
   428	
   429		/*
   430		 * Don't keep CS asserted after last xfer. Also triggers conversion of
   431		 * slot 0.
   432		 */
   433		xfer->cs_change = 0;
   434	
   435		/**
   436		 * The advanced sequencer requires that at least 2 slots are enabled.
   437		 * Since slot 0 is always used for other purposes, we need only 1
   438		 * enabled voltage channel to meet this requirement. This error will
   439		 * only happen if only the temperature channel is enabled.
   440		 */
   441		if (num_slots < 2) {
   442			dev_err_ratelimited(&indio_dev->dev,
   443				"Buffered read requires at least 1 voltage channel enabled\n");
   444			return -EINVAL;
   445		}
   446	
   447		/*
   448		 * Temperature channel isn't included in the sequence, but rather
   449		 * controlled by setting a bit in the TEMP_CTRL register.
   450		 */
   451	
   452		reg = AD4695_REG_TEMP_CTRL;
   453		mask = AD4695_REG_TEMP_CTRL_TEMP_EN;
 > 454		val = FIELD_PREP(mask, temp_chan_en ? 1 : 0);
   455	
   456		ret = regmap_update_bits(st->regmap, reg, mask, val);
   457		if (ret)
   458			return ret;
   459	
   460		spi_message_init_with_transfers(&st->buf_read_msg, st->buf_read_xfer,
   461						num_xfer);
   462	
   463		ret = spi_optimize_message(st->spi, &st->buf_read_msg);
   464		if (ret)
   465			return ret;
   466	
   467		/* This triggers conversion of slot 0. */
   468		ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
   469		if (ret) {
   470			spi_unoptimize_message(&st->buf_read_msg);
   471			return ret;
   472		}
   473	
   474		return 0;
   475	}
   476	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

