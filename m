Return-Path: <linux-iio+bounces-17796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1985A7F2E4
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 04:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8E51899665
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 02:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BDB253B54;
	Tue,  8 Apr 2025 02:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNf3kdCg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435D722DFA0;
	Tue,  8 Apr 2025 02:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081160; cv=none; b=O39FtWRGo9VHRSaqWNelT6viT/I4e1QC3xZoRxs1LO5dQJJC5852K6t19mprmVsAAOrs7BUT62GrTX8M+yn+4/E1ijF0YS7ZexBKV69UEiLUxBGq84AJPPVzlSgHwJwHgEE6MdaU5wP89BK102RzMF30WT2XI3AqZ7BzUeqFVrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081160; c=relaxed/simple;
	bh=s5UvaaQU++0RLXjgEI2GKm/wDBAYbl0mU881Km1qpJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhM7C3kv84u0CXU2afnM052Os3mMd+7CLtv14Mrf8IoN68GnJDbTXreKUWpnQP1OejKbjzF4JfLxsUbnFi+AAmqecrF4CfMfqwbsIJWHrbsECGiHUZ/QwoxeaSG946DYx2FfMMguP/mpWkC+hC1wATQRaY1vh5yTstyWEPgQikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNf3kdCg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744081158; x=1775617158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s5UvaaQU++0RLXjgEI2GKm/wDBAYbl0mU881Km1qpJA=;
  b=GNf3kdCga9/3Zcz8ZK1EJa0gi3YLfZdad1pzNwBceJX2DsYLt26WFtAV
   HaKsPb642fC6b8UOiFFVU2sb0+LTRryHvUQN2sYZqlnxC+KkWTjM4NHT5
   dUiwt96Y0WrTkicEjf3OaBF2uFvatPFXO80ciu99aqJOg5rJ03Yi3Ibif
   NpO/I4BIi1FEGPO2oARmVJocx783Fp2Kf5JAnQFbOAvAOVzR7J5VyytKQ
   oCaDbn/VXGRAuqGiJm6fFwMbgDxHY1q95itO9QGRTCjIRJuoXMtmwgoQ8
   iSX9uIhynUy7mqrVCRaIz5tKTxqRUmFARLEYhydZil7MULX+fmp4G3iBE
   g==;
X-CSE-ConnectionGUID: VgNGTmrUSRyoQ3ciEI9nzg==
X-CSE-MsgGUID: vgMqGLj9QKCd4s4CGl7kgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56158595"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="56158595"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 19:59:17 -0700
X-CSE-ConnectionGUID: +drIKI8YSFGqj37RFQiu4Q==
X-CSE-MsgGUID: AgtK3GGeSzKSgWJxFNcOYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="133104686"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 07 Apr 2025 19:59:13 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1zB9-00043T-0Y;
	Tue, 08 Apr 2025 02:59:11 +0000
Date: Tue, 8 Apr 2025 10:58:54 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/7] iio: dac: ad5592r: use lock guards
Message-ID: <202504081058.aukPDkTg-lkp@intel.com>
References: <20250407-gpiochip-set-rv-iio-v1-2-8431b003a145@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-gpiochip-set-rv-iio-v1-2-8431b003a145@linaro.org>

Hi Bartosz,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0af2f6be1b4281385b618cb86ad946eded089ac8]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/iio-dac-ad5592r-destroy-mutexes-in-detach-paths/20250407-152721
base:   0af2f6be1b4281385b618cb86ad946eded089ac8
patch link:    https://lore.kernel.org/r/20250407-gpiochip-set-rv-iio-v1-2-8431b003a145%40linaro.org
patch subject: [PATCH 2/7] iio: dac: ad5592r: use lock guards
config: arm-randconfig-001-20250408 (https://download.01.org/0day-ci/archive/20250408/202504081058.aukPDkTg-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 92c93f5286b9ff33f27ff694d2dc33da1c07afdd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250408/202504081058.aukPDkTg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504081058.aukPDkTg-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/dac/ad5592r-base.c:350:2: error: cannot jump from switch statement to this case label
     350 |         default:
         |         ^
   drivers/iio/dac/ad5592r-base.c:303:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     303 |                 guard(mutex)(&st->lock);
         |                 ^
   include/linux/cleanup.h:319:15: note: expanded from macro 'guard'
     319 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:166:29: note: expanded from macro '__UNIQUE_ID'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:104:1: note: expanded from here
     104 | __UNIQUE_ID_guard492
         | ^
   drivers/iio/dac/ad5592r-base.c:308:2: error: cannot jump from switch statement to this case label
     308 |         case IIO_CHAN_INFO_SCALE:
         |         ^
   drivers/iio/dac/ad5592r-base.c:303:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     303 |                 guard(mutex)(&st->lock);
         |                 ^
   include/linux/cleanup.h:319:15: note: expanded from macro 'guard'
     319 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:166:29: note: expanded from macro '__UNIQUE_ID'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:104:1: note: expanded from here
     104 | __UNIQUE_ID_guard492
         | ^
   drivers/iio/dac/ad5592r-base.c:427:2: error: cannot jump from switch statement to this case label
     427 |         default:
         |         ^
   drivers/iio/dac/ad5592r-base.c:419:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     419 |                 guard(mutex)(&st->lock);
         |                 ^
   include/linux/cleanup.h:319:15: note: expanded from macro 'guard'
     319 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:166:29: note: expanded from macro '__UNIQUE_ID'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:169:1: note: expanded from here
     169 | __UNIQUE_ID_guard497
         | ^
   3 errors generated.


vim +350 drivers/iio/dac/ad5592r-base.c

56ca9db862bf3d7 Paul Cercueil       2016-04-05  287  
56ca9db862bf3d7 Paul Cercueil       2016-04-05  288  static int ad5592r_write_raw(struct iio_dev *iio_dev,
56ca9db862bf3d7 Paul Cercueil       2016-04-05  289  	struct iio_chan_spec const *chan, int val, int val2, long mask)
56ca9db862bf3d7 Paul Cercueil       2016-04-05  290  {
56ca9db862bf3d7 Paul Cercueil       2016-04-05  291  	struct ad5592r_state *st = iio_priv(iio_dev);
56ca9db862bf3d7 Paul Cercueil       2016-04-05  292  	int ret;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  293  
56ca9db862bf3d7 Paul Cercueil       2016-04-05  294  	switch (mask) {
56ca9db862bf3d7 Paul Cercueil       2016-04-05  295  	case IIO_CHAN_INFO_RAW:
56ca9db862bf3d7 Paul Cercueil       2016-04-05  296  
56ca9db862bf3d7 Paul Cercueil       2016-04-05  297  		if (val >= (1 << chan->scan_type.realbits) || val < 0)
56ca9db862bf3d7 Paul Cercueil       2016-04-05  298  			return -EINVAL;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  299  
56ca9db862bf3d7 Paul Cercueil       2016-04-05  300  		if (!chan->output)
56ca9db862bf3d7 Paul Cercueil       2016-04-05  301  			return -EINVAL;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  302  
299c6ede9f0343c Bartosz Golaszewski 2025-04-07  303  		guard(mutex)(&st->lock);
56ca9db862bf3d7 Paul Cercueil       2016-04-05  304  		ret = st->ops->write_dac(st, chan->channel, val);
56ca9db862bf3d7 Paul Cercueil       2016-04-05  305  		if (!ret)
56ca9db862bf3d7 Paul Cercueil       2016-04-05  306  			st->cached_dac[chan->channel] = val;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  307  		return ret;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  308  	case IIO_CHAN_INFO_SCALE:
56ca9db862bf3d7 Paul Cercueil       2016-04-05  309  		if (chan->type == IIO_VOLTAGE) {
56ca9db862bf3d7 Paul Cercueil       2016-04-05  310  			bool gain;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  311  
56ca9db862bf3d7 Paul Cercueil       2016-04-05  312  			if (val == st->scale_avail[0][0] &&
56ca9db862bf3d7 Paul Cercueil       2016-04-05  313  				val2 == st->scale_avail[0][1])
56ca9db862bf3d7 Paul Cercueil       2016-04-05  314  				gain = false;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  315  			else if (val == st->scale_avail[1][0] &&
56ca9db862bf3d7 Paul Cercueil       2016-04-05  316  				 val2 == st->scale_avail[1][1])
56ca9db862bf3d7 Paul Cercueil       2016-04-05  317  				gain = true;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  318  			else
56ca9db862bf3d7 Paul Cercueil       2016-04-05  319  				return -EINVAL;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  320  
299c6ede9f0343c Bartosz Golaszewski 2025-04-07  321  			guard(mutex)(&st->lock);
56ca9db862bf3d7 Paul Cercueil       2016-04-05  322  
56ca9db862bf3d7 Paul Cercueil       2016-04-05  323  			ret = st->ops->reg_read(st, AD5592R_REG_CTRL,
56ca9db862bf3d7 Paul Cercueil       2016-04-05  324  						&st->cached_gp_ctrl);
56ca9db862bf3d7 Paul Cercueil       2016-04-05  325  			if (ret < 0) {
33c53cbf8f7bc8d Sergiu Cuciurean    2020-05-20  326  				mutex_unlock(&st->lock);
56ca9db862bf3d7 Paul Cercueil       2016-04-05  327  				return ret;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  328  			}
56ca9db862bf3d7 Paul Cercueil       2016-04-05  329  
56ca9db862bf3d7 Paul Cercueil       2016-04-05  330  			if (chan->output) {
56ca9db862bf3d7 Paul Cercueil       2016-04-05  331  				if (gain)
56ca9db862bf3d7 Paul Cercueil       2016-04-05  332  					st->cached_gp_ctrl |=
56ca9db862bf3d7 Paul Cercueil       2016-04-05  333  						AD5592R_REG_CTRL_DAC_RANGE;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  334  				else
56ca9db862bf3d7 Paul Cercueil       2016-04-05  335  					st->cached_gp_ctrl &=
56ca9db862bf3d7 Paul Cercueil       2016-04-05  336  						~AD5592R_REG_CTRL_DAC_RANGE;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  337  			} else {
56ca9db862bf3d7 Paul Cercueil       2016-04-05  338  				if (gain)
56ca9db862bf3d7 Paul Cercueil       2016-04-05  339  					st->cached_gp_ctrl |=
56ca9db862bf3d7 Paul Cercueil       2016-04-05  340  						AD5592R_REG_CTRL_ADC_RANGE;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  341  				else
56ca9db862bf3d7 Paul Cercueil       2016-04-05  342  					st->cached_gp_ctrl &=
56ca9db862bf3d7 Paul Cercueil       2016-04-05  343  						~AD5592R_REG_CTRL_ADC_RANGE;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  344  			}
56ca9db862bf3d7 Paul Cercueil       2016-04-05  345  
299c6ede9f0343c Bartosz Golaszewski 2025-04-07  346  			return st->ops->reg_write(st, AD5592R_REG_CTRL,
56ca9db862bf3d7 Paul Cercueil       2016-04-05  347  						  st->cached_gp_ctrl);
56ca9db862bf3d7 Paul Cercueil       2016-04-05  348  		}
56ca9db862bf3d7 Paul Cercueil       2016-04-05  349  		break;
56ca9db862bf3d7 Paul Cercueil       2016-04-05 @350  	default:
56ca9db862bf3d7 Paul Cercueil       2016-04-05  351  		return -EINVAL;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  352  	}
56ca9db862bf3d7 Paul Cercueil       2016-04-05  353  
56ca9db862bf3d7 Paul Cercueil       2016-04-05  354  	return 0;
56ca9db862bf3d7 Paul Cercueil       2016-04-05  355  }
56ca9db862bf3d7 Paul Cercueil       2016-04-05  356  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

