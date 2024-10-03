Return-Path: <linux-iio+bounces-10013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE1498E913
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 06:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426761F24E4E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 04:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0242E419;
	Thu,  3 Oct 2024 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hH7l0EL4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8FD1EA80;
	Thu,  3 Oct 2024 04:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727929400; cv=none; b=JWd25g5FrxRq3pmj9rohpJwBCm6Fja0JcRDJVNyodEDQYR73C2T7R087qShenZ89ULrYWpGY3vhlekcNIood1TqOxtkbQvGfGXdZh2RRzKnvEe0kgkdwC+e3RxrPFA+gVtvBknxeG8BC2H0ixhR7qTxE6mfkQA4UczRXBzPsV8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727929400; c=relaxed/simple;
	bh=zRd2CcWCC7ef6bV6W+QqZcAsCTaa6T/p5q2sLrbjNpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYkapcrgn9ZksXS1cgr2yPLqtJHiq1MvLBISieaDPw/TMq113c6CqfW1I8QGw4xd3Nbxyv7nq/iKcAnzy4l4Ca9wSBERrXsIMU9YlMkXKjsFsPn696DFdf5Ql80Ak+94ykn3ZjtWqbc8U5GtuZZqPuMgjv0dLNBlN2+ncwKq/I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hH7l0EL4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727929397; x=1759465397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zRd2CcWCC7ef6bV6W+QqZcAsCTaa6T/p5q2sLrbjNpk=;
  b=hH7l0EL4v1kLF3UQv7jHvbgGwgn2KTXM9vXYF+u1iOnPIodkikKHDmsv
   kNiWYYOVTvXxcYt2ccI9lwuR1VkvHc3yg/Q7eQAoeqldm4s2Ya4MHLrjq
   QDAUlWh4G++uI1W28xrz3WSQpzaS40a7gxEHAW7FOls7ul5V72G8lLJWq
   SL4D/hlaLHOrzjsiABRRMs5CYHWj+ji4KyEP8FowLnKfG2rF6DkcsM2YV
   96xaJjJhZ/L18c69jOuenh0xnDv32FfHV41rgz0/MQfKnEjEqWudJqgys
   CjeXKIkyZ5tbzuXPt7ErSGmzn1JLiOz+0Pxzck5lcPKLP8t20Tl6CxmuC
   g==;
X-CSE-ConnectionGUID: Bn8YoISdR+qjEOtx6GkKzw==
X-CSE-MsgGUID: +F5ZYLOYQsOeXIlJS64cRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27290985"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27290985"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 21:23:16 -0700
X-CSE-ConnectionGUID: ncsuR5+GQZuqnFMbGU9wuA==
X-CSE-MsgGUID: UtoooITFTIKUYIJuDiYblA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="79072851"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 02 Oct 2024 21:23:13 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swDMt-000022-1Q;
	Thu, 03 Oct 2024 04:23:11 +0000
Date: Thu, 3 Oct 2024 12:23:07 +0800
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
Message-ID: <202410031215.IKHRIsat-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on 431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/cleanup-add-conditional-guard-helper/20241002-063209
base:   431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e
patch link:    https://lore.kernel.org/r/20241001-cleanup-if_not_cond_guard-v1-2-7753810b0f7a%40baylibre.com
patch subject: [PATCH 2/3] iio: adc: ad7380: use if_not_cond_guard for claim direct
config: x86_64-randconfig-011-20241003 (https://download.01.org/0day-ci/archive/20241003/202410031215.IKHRIsat-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241003/202410031215.IKHRIsat-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410031215.IKHRIsat-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ad7380.c:823:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
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
   <scratch space>:67:1: note: expanded from here
      67 | class_iio_claim_direct_try_t
         | ^
   drivers/iio/adc/ad7380.c:851:2: error: cannot jump from switch statement to this case label
     851 |         default:
         |         ^
   drivers/iio/adc/ad7380.c:823:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     823 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
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
   <scratch space>:65:1: note: expanded from here
      65 | __UNIQUE_ID_guard837
         | ^
   drivers/iio/adc/ad7380.c:847:2: error: cannot jump from switch statement to this case label
     847 |         case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
         |         ^
   drivers/iio/adc/ad7380.c:823:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     823 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
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
   <scratch space>:65:1: note: expanded from here
      65 | __UNIQUE_ID_guard837
         | ^
   drivers/iio/adc/ad7380.c:838:2: error: cannot jump from switch statement to this case label
     838 |         case IIO_CHAN_INFO_OFFSET:
         |         ^
   drivers/iio/adc/ad7380.c:823:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     823 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
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
   <scratch space>:65:1: note: expanded from here
      65 | __UNIQUE_ID_guard837
         | ^
   drivers/iio/adc/ad7380.c:827:2: error: cannot jump from switch statement to this case label
     827 |         case IIO_CHAN_INFO_SCALE:
         |         ^
   drivers/iio/adc/ad7380.c:823:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     823 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
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
   <scratch space>:65:1: note: expanded from here
      65 | __UNIQUE_ID_guard837
         | ^
   drivers/iio/adc/ad7380.c:935:2: error: cannot jump from switch statement to this case label
     935 |         default:


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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

