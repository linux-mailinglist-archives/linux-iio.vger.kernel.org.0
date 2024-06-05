Return-Path: <linux-iio+bounces-5877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC51C8FD91D
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 23:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96411C24094
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 21:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD55216DEA3;
	Wed,  5 Jun 2024 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKUlfAAA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9816D9A3;
	Wed,  5 Jun 2024 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623204; cv=none; b=FrR9CPxbIJtmMmGCObCcSs0e83zSqwEZYKH/LPQU7wTTO3u9aHKP04lHVKfeAQ9e4GqDtq+9ffVCCw/8KMLh2U325VyEsn0ZcRCNAE+pQq6mkm7CbClv66dQ6Ok93nTiockKwQoUSh+LJFzDXi+J23pN3YPujgwPstWe9Ohya1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623204; c=relaxed/simple;
	bh=GFWdiBrrALapFfZ9mZyw4LqzPHc2E/G8ZMpfRlbTgeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msB5GAfy7HJrDo7W9y69JFwwslekkzt64k20yGHgGGC/eeYrlOn39F+/VGdrdivrAVFrQle5IA702+E8JICmtQ2BWlyOOY7LY0lEd5DoeYjMUumT+DTKAP+tnUYEzPVIpkh6mUYKD5swFSZb9kiYfpaetwCXl8qBgO7EJWzVpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKUlfAAA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717623203; x=1749159203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GFWdiBrrALapFfZ9mZyw4LqzPHc2E/G8ZMpfRlbTgeI=;
  b=hKUlfAAAYs131IqoLjHakOXK3Trww3H5KvoIVCv1GfbLBYHN0pGTQ42z
   fo3x4YRjxHUzZ5cI91wP84r+dUl3xCjEyLyfdewe4gf4oIFDQHfQc7Jb4
   OAUAyZN7cZqWOtm2d3SK7tEbttGaL0UlU6XWv4pR1l+DzAKfqQA+J5Mqp
   Ft2+IoHkUJsWCWda1f5j9RqxixE3ngEgdx1HBjpY3tKglshrkv8jfntpa
   UZcAQ3dS91Q8d3VeNyZ488q/vcN+/4SXktk682yCLwZ6DHnFf+hdmKWs7
   qR5QtJFbQDeKQPy2LwF2LdTFg2olEa9ETdGxRlPfrL1Z2aOkVsuh24NUU
   Q==;
X-CSE-ConnectionGUID: a70VrjqbS7q980f7F0NeVg==
X-CSE-MsgGUID: /iLCsArbRPqROD31EVtsFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18082602"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="18082602"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 14:33:22 -0700
X-CSE-ConnectionGUID: hSukBW8YS7Cmbn8i22c/LA==
X-CSE-MsgGUID: BQua7tGaQOWACxECq10aZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="75204966"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 05 Jun 2024 14:33:18 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEyFv-0002HK-2q;
	Wed, 05 Jun 2024 21:33:15 +0000
Date: Thu, 6 Jun 2024 05:32:26 +0800
From: kernel test robot <lkp@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	marcelo.schmitt1@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: adc: Add support for AD4000
Message-ID: <202406060558.kJtbRid3-lkp@intel.com>
References: <e340f48324b0ea3afb1c715cb2fba184c27112a1.1717539384.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e340f48324b0ea3afb1c715cb2fba184c27112a1.1717539384.git.marcelo.schmitt@analog.com>

Hi Marcelo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on jic23-iio/togreg linus/master v6.10-rc2 next-20240605]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/spi-Add-SPI-mode-bit-for-MOSI-idle-state-configuration/20240605-231912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/e340f48324b0ea3afb1c715cb2fba184c27112a1.1717539384.git.marcelo.schmitt%40analog.com
patch subject: [PATCH v3 6/6] iio: adc: Add support for AD4000
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240606/202406060558.kJtbRid3-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240606/202406060558.kJtbRid3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406060558.kJtbRid3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/adc/ad4000.c:17:
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
   In file included from drivers/iio/adc/ad4000.c:17:
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
   In file included from drivers/iio/adc/ad4000.c:17:
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
   In file included from drivers/iio/adc/ad4000.c:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/iio/adc/ad4000.c:375:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     375 |         int ret;
         |             ^
>> drivers/iio/adc/ad4000.c:538:3: warning: variable 'reg_val' is uninitialized when used here [-Wuninitialized]
     538 |                 reg_val |= FIELD_PREP(AD4000_CFG_HIGHZ, 1);
         |                 ^~~~~~~
   drivers/iio/adc/ad4000.c:535:22: note: initialize the variable 'reg_val' to silence this warning
     535 |         unsigned int reg_val;
         |                             ^
         |                              = 0
   9 warnings generated.


vim +/reg_val +538 drivers/iio/adc/ad4000.c

   369	
   370	static int ad4000_single_conversion(struct iio_dev *indio_dev,
   371					    const struct iio_chan_spec *chan, int *val)
   372	{
   373		struct ad4000_state *st = iio_priv(indio_dev);
   374		u32 sample;
 > 375		int ret;
   376	
   377		ret = ad4000_convert_and_acquire(st);
   378	
   379		if (chan->scan_type.storagebits > 16)
   380			sample = be32_to_cpu(st->scan.data.sample_buf32);
   381		else
   382			sample = be16_to_cpu(st->scan.data.sample_buf16);
   383	
   384		switch (chan->scan_type.realbits) {
   385		case 16:
   386			break;
   387		case 18:
   388			sample = FIELD_GET(AD4000_18BIT_MSK, sample);
   389			break;
   390		case 20:
   391			sample = FIELD_GET(AD4000_20BIT_MSK, sample);
   392			break;
   393		default:
   394			return -EINVAL;
   395		}
   396	
   397		if (chan->scan_type.sign == 's')
   398			*val = sign_extend32(sample, chan->scan_type.realbits - 1);
   399	
   400		return IIO_VAL_INT;
   401	}
   402	
   403	static int ad4000_read_raw(struct iio_dev *indio_dev,
   404				   struct iio_chan_spec const *chan, int *val,
   405				   int *val2, long info)
   406	{
   407		struct ad4000_state *st = iio_priv(indio_dev);
   408	
   409		switch (info) {
   410		case IIO_CHAN_INFO_RAW:
   411			iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
   412				return ad4000_single_conversion(indio_dev, chan, val);
   413			unreachable();
   414		case IIO_CHAN_INFO_SCALE:
   415			*val = st->scale_tbl[st->span_comp][0];
   416			*val2 = st->scale_tbl[st->span_comp][1];
   417			return IIO_VAL_INT_PLUS_NANO;
   418		case IIO_CHAN_INFO_OFFSET:
   419			*val = 0;
   420			if (st->span_comp)
   421				*val = mult_frac(st->vref / 1000, 1, 10);
   422	
   423			return IIO_VAL_INT;
   424		default:
   425			return -EINVAL;
   426		}
   427	}
   428	
   429	static int ad4000_read_avail(struct iio_dev *indio_dev,
   430				     struct iio_chan_spec const *chan,
   431				     const int **vals, int *type, int *length,
   432				     long info)
   433	{
   434		struct ad4000_state *st = iio_priv(indio_dev);
   435	
   436		switch (info) {
   437		case IIO_CHAN_INFO_SCALE:
   438			*vals = (int *)st->scale_tbl;
   439			*length = 2 * 2;
   440			*type = IIO_VAL_INT_PLUS_NANO;
   441			return IIO_AVAIL_LIST;
   442		default:
   443			return -EINVAL;
   444		}
   445	}
   446	
   447	static int ad4000_write_raw_get_fmt(struct iio_dev *indio_dev,
   448					    struct iio_chan_spec const *chan, long mask)
   449	{
   450		switch (mask) {
   451		case IIO_CHAN_INFO_SCALE:
   452			return IIO_VAL_INT_PLUS_NANO;
   453		default:
   454			return IIO_VAL_INT_PLUS_MICRO;
   455		}
   456	}
   457	
   458	static int ad4000_write_raw(struct iio_dev *indio_dev,
   459				    struct iio_chan_spec const *chan, int val, int val2,
   460				    long mask)
   461	{
   462		struct ad4000_state *st = iio_priv(indio_dev);
   463		unsigned int reg_val;
   464		bool span_comp_en;
   465		int ret;
   466	
   467		switch (mask) {
   468		case IIO_CHAN_INFO_SCALE:
   469			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
   470				ret = ad4000_read_reg(st, &reg_val);
   471				if (ret < 0)
   472					return ret;
   473	
   474				span_comp_en = (val2 == st->scale_tbl[1][1]);
   475				reg_val &= ~AD4000_CFG_SPAN_COMP;
   476				reg_val |= FIELD_PREP(AD4000_CFG_SPAN_COMP, span_comp_en);
   477	
   478				ret = ad4000_write_reg(st, reg_val);
   479				if (ret < 0)
   480					return ret;
   481	
   482				st->span_comp = span_comp_en;
   483				return 0;
   484			}
   485			unreachable();
   486		default:
   487			return -EINVAL;
   488		}
   489	}
   490	
   491	static irqreturn_t ad4000_trigger_handler(int irq, void *p)
   492	{
   493		struct iio_poll_func *pf = p;
   494		struct iio_dev *indio_dev = pf->indio_dev;
   495		struct ad4000_state *st = iio_priv(indio_dev);
   496		int ret;
   497	
   498		ret = ad4000_convert_and_acquire(st);
   499		if (ret < 0)
   500			goto err_out;
   501	
   502		iio_push_to_buffers_with_timestamp(indio_dev, &st->scan,
   503						   iio_get_time_ns(indio_dev));
   504	
   505	err_out:
   506		iio_trigger_notify_done(indio_dev->trig);
   507		return IRQ_HANDLED;
   508	}
   509	
   510	static int ad4000_reg_access(struct iio_dev *indio_dev, unsigned int reg,
   511				     unsigned int writeval, unsigned int *readval)
   512	{
   513		struct ad4000_state *st = iio_priv(indio_dev);
   514		int ret;
   515	
   516		if (readval)
   517			ret = ad4000_read_reg(st, readval);
   518		else
   519			ret = ad4000_write_reg(st, writeval);
   520	
   521		return ret;
   522	}
   523	
   524	static const struct iio_info ad4000_info = {
   525		.read_raw = &ad4000_read_raw,
   526		.read_avail = &ad4000_read_avail,
   527		.write_raw = &ad4000_write_raw,
   528		.write_raw_get_fmt = &ad4000_write_raw_get_fmt,
   529		.debugfs_reg_access = &ad4000_reg_access,
   530	
   531	};
   532	
   533	static int ad4000_config(struct ad4000_state *st)
   534	{
   535		unsigned int reg_val;
   536	
   537		if (device_property_present(&st->spi->dev, "adi,high-z-input"))
 > 538			reg_val |= FIELD_PREP(AD4000_CFG_HIGHZ, 1);
   539	
   540		/*
   541		 * The ADC SDI pin might be connected to controller CS line in which
   542		 * case the write might fail. This, however, does not prevent the device
   543		 * from functioning even though in a configuration other than the
   544		 * requested one.
   545		 */
   546		return ad4000_write_reg(st, reg_val);
   547	}
   548	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

