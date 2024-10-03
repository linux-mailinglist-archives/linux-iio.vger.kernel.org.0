Return-Path: <linux-iio+bounces-10014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B8398E968
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 07:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA6B286D45
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 05:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE677770F5;
	Thu,  3 Oct 2024 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HA71iMKU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00627316E;
	Thu,  3 Oct 2024 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727933722; cv=none; b=C7OpzPYpYnov5dOuCXRvtRX+yQ9mHnRWi/iakUnWdrltEWVyZnW+GvNeB9vT3BUBgxsAT9F2ni3Ms1XbAJ5IsFcSFAFp2qBwDqRxYvtXntnAa/fK1hux878YQFQQGPVJcbKam+NHyZ2IOObX9gNRr1IEX3oCXjOHKjFm7Mtwqsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727933722; c=relaxed/simple;
	bh=XIbbkuqPYNfSqVfvKaGb+aFGY7GpI6S0tMl2JMRdoEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOObxdyTzItu7QqDk6Z1evfNTIT2ZArZRvZ56djk2lBN5IGLKneprwEIvs6vyINP+0yaHKJNCa4z79JXdw+gSNNs7XTie0wXSX9aoQOvYf5RM+53rCBkYyl6G5yTZRkghhGE2ooiKERq2mOQpFJ3gL8lH96E7IcfO9T24dkeTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HA71iMKU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727933721; x=1759469721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XIbbkuqPYNfSqVfvKaGb+aFGY7GpI6S0tMl2JMRdoEI=;
  b=HA71iMKUzvzdrOFwiGs2OqU+h4Yk+DzyZyQ1R0XU2AD6Xxwc/COkVvPX
   UDpFJG9KR80rk23F4yr5zTid83JcSGCfy7mW4EuPpNsjNRKu4EkpUKgXY
   VqRodwioRh6Myhug/OwdViI3pweMmowSP/dF1geHXjVHdnXAV5Z6fKJlg
   sFeLPJ5Xunz/7BaJ31yIybJpuxDHGD6dwyKxzjPJ25bJOe8FIqXs/a2jO
   oXzcPBHHdxsdx7u1zuvirkhkRJ8DWbTqGM8UZ2TlEDQNARI8xTm/j84ry
   qJh78LNAHlXgJLp3oHOi+pqEBNm/KNEKaxjSn/urIusq3tHjkAX2zj8nN
   A==;
X-CSE-ConnectionGUID: AlrJzG47Qha0MYRfFrSPOg==
X-CSE-MsgGUID: 7dJwYbs2RkC/OWU4pZx70w==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="37676200"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="37676200"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 22:35:21 -0700
X-CSE-ConnectionGUID: SFlOz1suSTyecNsQtAuHiw==
X-CSE-MsgGUID: Rz2ur3RTTlepYSnsok8afg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="73910176"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 02 Oct 2024 22:35:17 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swEUc-00005W-2f;
	Thu, 03 Oct 2024 05:35:14 +0000
Date: Thu, 3 Oct 2024 13:35:02 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-cxl@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 2/3] iio: adc: ad7380: use if_not_cond_guard for claim
 direct
Message-ID: <202410031253.vjAMDYuX-lkp@intel.com>
References: <20241001-cleanup-if_not_cond_guard-v1-2-7753810b0f7a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001-cleanup-if_not_cond_guard-v1-2-7753810b0f7a@baylibre.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on 431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/cleanup-add-conditional-guard-helper/20241002-063209
base:   431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e
patch link:    https://lore.kernel.org/r/20241001-cleanup-if_not_cond_guard-v1-2-7753810b0f7a%40baylibre.com
patch subject: [PATCH 2/3] iio: adc: ad7380: use if_not_cond_guard for claim direct
config: arm64-randconfig-001-20241003 (https://download.01.org/0day-ci/archive/20241003/202410031253.vjAMDYuX-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241003/202410031253.vjAMDYuX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410031253.vjAMDYuX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/ad7380.c:823:3: error: expected expression
     823 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                 ^
   include/linux/cleanup.h:316:2: note: expanded from macro 'if_not_cond_guard'
     316 |         __if_not_cond_guard(_name, __UNIQUE_ID(guard), args)
         |         ^
   include/linux/cleanup.h:312:2: note: expanded from macro '__if_not_cond_guard'
     312 |         CLASS(_name, _id)(args);                        \
         |         ^
   include/linux/cleanup.h:258:2: note: expanded from macro 'CLASS'
     258 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |         ^
   <scratch space>:81:1: note: expanded from here
      81 | class_iio_claim_direct_try_t
         | ^
   drivers/iio/adc/ad7380.c:823:3: error: use of undeclared identifier '__UNIQUE_ID_guard799'
   include/linux/cleanup.h:316:29: note: expanded from macro 'if_not_cond_guard'
     316 |         __if_not_cond_guard(_name, __UNIQUE_ID(guard), args)
         |                                    ^
   include/linux/compiler.h:189:29: note: expanded from macro '__UNIQUE_ID'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:79:1: note: expanded from here
      79 | __UNIQUE_ID_guard799
         | ^
>> drivers/iio/adc/ad7380.c:935:2: error: cannot jump from switch statement to this case label
     935 |         default:
         |         ^
   drivers/iio/adc/ad7380.c:911:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     911 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                 ^
   include/linux/cleanup.h:316:29: note: expanded from macro 'if_not_cond_guard'
     316 |         __if_not_cond_guard(_name, __UNIQUE_ID(guard), args)
         |                                    ^
   include/linux/compiler.h:189:29: note: expanded from macro '__UNIQUE_ID'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:90:1: note: expanded from here
      90 | __UNIQUE_ID_guard800
         | ^
   3 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]


vim +823 drivers/iio/adc/ad7380.c

   808	
   809	static int ad7380_read_raw(struct iio_dev *indio_dev,
   810				   struct iio_chan_spec const *chan,
   811				   int *val, int *val2, long info)
   812	{
   813		struct ad7380_state *st = iio_priv(indio_dev);
   814		const struct iio_scan_type *scan_type;
   815	
   816		scan_type = iio_get_current_scan_type(indio_dev, chan);
   817	
   818		if (IS_ERR(scan_type))
   819			return PTR_ERR(scan_type);
   820	
   821		switch (info) {
   822		case IIO_CHAN_INFO_RAW:
 > 823			if_not_cond_guard(iio_claim_direct_try, indio_dev)
   824				return -EBUSY;
   825	
   826			return ad7380_read_direct(st, chan->scan_index, scan_type, val);
   827		case IIO_CHAN_INFO_SCALE:
   828			/*
   829			 * According to the datasheet, the LSB size is:
   830			 *    * (2 × VREF) / 2^N, for differential chips
   831			 *    * VREF / 2^N, for pseudo-differential chips
   832			 * where N is the ADC resolution (i.e realbits)
   833			 */
   834			*val = st->vref_mv;
   835			*val2 = scan_type->realbits - chan->differential;
   836	
   837			return IIO_VAL_FRACTIONAL_LOG2;
   838		case IIO_CHAN_INFO_OFFSET:
   839			/*
   840			 * According to IIO ABI, offset is applied before scale,
   841			 * so offset is: vcm_mv / scale
   842			 */
   843			*val = st->vcm_mv[chan->channel] * (1 << scan_type->realbits)
   844				/ st->vref_mv;
   845	
   846			return IIO_VAL_INT;
   847		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
   848			*val = st->oversampling_ratio;
   849	
   850			return IIO_VAL_INT;
   851		default:
   852			return -EINVAL;
   853		}
   854	}
   855	
   856	static int ad7380_read_avail(struct iio_dev *indio_dev,
   857				     struct iio_chan_spec const *chan,
   858				     const int **vals, int *type, int *length,
   859				     long mask)
   860	{
   861		switch (mask) {
   862		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
   863			*vals = ad7380_oversampling_ratios;
   864			*length = ARRAY_SIZE(ad7380_oversampling_ratios);
   865			*type = IIO_VAL_INT;
   866	
   867			return IIO_AVAIL_LIST;
   868		default:
   869			return -EINVAL;
   870		}
   871	}
   872	
   873	/**
   874	 * ad7380_osr_to_regval - convert ratio to OSR register value
   875	 * @ratio: ratio to check
   876	 *
   877	 * Check if ratio is present in the list of available ratios and return the
   878	 * corresponding value that needs to be written to the register to select that
   879	 * ratio.
   880	 *
   881	 * Returns: register value (0 to 7) or -EINVAL if there is not an exact match
   882	 */
   883	static int ad7380_osr_to_regval(int ratio)
   884	{
   885		int i;
   886	
   887		for (i = 0; i < ARRAY_SIZE(ad7380_oversampling_ratios); i++) {
   888			if (ratio == ad7380_oversampling_ratios[i])
   889				return i;
   890		}
   891	
   892		return -EINVAL;
   893	}
   894	
   895	static int ad7380_write_raw(struct iio_dev *indio_dev,
   896				    struct iio_chan_spec const *chan, int val,
   897				    int val2, long mask)
   898	{
   899		struct ad7380_state *st = iio_priv(indio_dev);
   900		int ret, osr, boost;
   901	
   902		switch (mask) {
   903		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
   904			osr = ad7380_osr_to_regval(val);
   905			if (osr < 0)
   906				return osr;
   907	
   908			/* always enable resolution boost when oversampling is enabled */
   909			boost = osr > 0 ? 1 : 0;
   910	
   911			if_not_cond_guard(iio_claim_direct_try, indio_dev)
   912				return -EBUSY;
   913	
   914			ret = regmap_update_bits(st->regmap,
   915						 AD7380_REG_ADDR_CONFIG1,
   916						 AD7380_CONFIG1_OSR | AD7380_CONFIG1_RES,
   917						 FIELD_PREP(AD7380_CONFIG1_OSR, osr) |
   918						 FIELD_PREP(AD7380_CONFIG1_RES, boost));
   919	
   920			if (ret)
   921				return ret;
   922	
   923			st->oversampling_ratio = val;
   924			st->resolution_boost_enabled = boost;
   925	
   926			/*
   927			 * Perform a soft reset. This will flush the oversampling block
   928			 * and FIFO but will maintain the content of the configurable
   929			 * registers.
   930			 */
   931			return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
   932						  AD7380_CONFIG2_RESET,
   933						  FIELD_PREP(AD7380_CONFIG2_RESET,
   934							     AD7380_CONFIG2_RESET_SOFT));
 > 935		default:
   936			return -EINVAL;
   937		}
   938	}
   939	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

