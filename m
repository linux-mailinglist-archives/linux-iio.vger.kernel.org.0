Return-Path: <linux-iio+bounces-6147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB866902221
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 14:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD11281CAF
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4496A8120D;
	Mon, 10 Jun 2024 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEkQgnft"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676CC7FBA1;
	Mon, 10 Jun 2024 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024203; cv=none; b=LwN4B1xYmzpu+oZt/UC35W8T7VKcUPFI/nHjPpO3t18krvgAdJfmFtw0f2dIdbyvDF32mMAwMd4bH3wkR+hvLVCX56aFes490r3RwmtaKpQhCOLcpgLRA22rJUfUjsXDcFchUlCaRRrXhpobIcKs87cQ7DM/RyqcFoihkKv8bDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024203; c=relaxed/simple;
	bh=2xYY/lQ1+aSL2j5RQQW3O4t0aAxsC6agFkFzSR1LvTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuTVrmrf+B3WIPpN1Kgv1X0CKE3ewnqAxOphBdJUR19lwcqqiYnonvBleRhCHKStAWMBHAyTuDmtAZEcMCjJgPa4JsemOW2mcjH5CeFrqs4/G5RDRQHErOKwvWZnH49NyavIA6QDf/N18uqUNrjwQAbjBE9QDQhD31ziOgycYH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEkQgnft; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718024202; x=1749560202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2xYY/lQ1+aSL2j5RQQW3O4t0aAxsC6agFkFzSR1LvTI=;
  b=YEkQgnft+x9dTys5ujSYLNUdNDeNDBCKrkVZtNa8PWyTqX/e0wIG6HzX
   n7X1UBDi6b5JN4uydocnSEaBDrzcQFtkOVQAiZ8VAA1xD6aeAlOBgeEJd
   mGTOCXQVv8TNvdxxYS8FUt88UZwavQe1qO9CFOOPGzKeFoHnbJgs6pJh4
   smX9DGSFVeEDCA/HyQbIgG7JO3Y/hEptFW/tFS6KDcVHA22Oalu1AQnj5
   sFaJjomyjWmX3vDQ2+sZuDPvA4obw/32iQb6MKjjEVmmmecfTaCWAJ/1j
   XhCUisCIQNB1AOgQPznzB0Y5Ccqu1JZ1BOWwERy05BBF1BOthJf3YzBGM
   w==;
X-CSE-ConnectionGUID: 6Zjs/YNgSNOxp8SItcYbyQ==
X-CSE-MsgGUID: M5w7oE5zRbm7d5RLgTi9yw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14517439"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14517439"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 05:56:41 -0700
X-CSE-ConnectionGUID: nZFaa1IzS7CZXv2Fm7+Zkg==
X-CSE-MsgGUID: zQt3uDrvSmiPQhaLSra/dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="38971919"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Jun 2024 05:56:39 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGeZg-00029B-2M;
	Mon, 10 Jun 2024 12:56:36 +0000
Date: Mon, 10 Jun 2024 20:55:51 +0800
From: kernel test robot <lkp@intel.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: bu27034: Add a read only HWARDWAREGAIN
Message-ID: <202406102012.s3Qrfbm7-lkp@intel.com>
References: <5e88c7b7b0389c6c011f15e05e065791f7561cf5.1718013518.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e88c7b7b0389c6c011f15e05e065791f7561cf5.1718013518.git.mazziesaccount@gmail.com>

Hi Matti,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0]

url:    https://github.com/intel-lab-lkp/linux/commits/Matti-Vaittinen/bu27034-ROHM-BU27034NUC-to-BU27034ANUC/20240610-180426
base:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
patch link:    https://lore.kernel.org/r/5e88c7b7b0389c6c011f15e05e065791f7561cf5.1718013518.git.mazziesaccount%40gmail.com
patch subject: [PATCH 2/2] iio: bu27034: Add a read only HWARDWAREGAIN
config: i386-buildonly-randconfig-002-20240610 (https://download.01.org/0day-ci/archive/20240610/202406102012.s3Qrfbm7-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240610/202406102012.s3Qrfbm7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406102012.s3Qrfbm7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from drivers/iio/light/rohm-bu27034.c:10:
   drivers/iio/light/rohm-bu27034.c: In function 'bu27034_write_raw_get_fmt':
>> include/linux/dev_printk.h:138:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
     137 |         ({                                                              \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     138 |                 if (0)                                                  \
         |                 ~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     140 |         })
         |         ~~          
   include/linux/dev_printk.h:171:9: note: in expansion of macro 'dev_no_printk'
     171 |         dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~
   drivers/iio/light/rohm-bu27034.c:1055:17: note: in expansion of macro 'dev_dbg'
    1055 |                 dev_dbg(data->dev,
         |                 ^~~~~~~
   drivers/iio/light/rohm-bu27034.c:1057:9: note: here
    1057 |         default:
         |         ^~~~~~~


vim +138 include/linux/dev_printk.h

af628aae8640c2 Greg Kroah-Hartman 2019-12-09   99  
ad7d61f159db73 Chris Down         2021-06-15  100  /*
ad7d61f159db73 Chris Down         2021-06-15  101   * Need to take variadic arguments even though we don't use them, as dev_fmt()
ad7d61f159db73 Chris Down         2021-06-15  102   * may only just have been expanded and may result in multiple arguments.
ad7d61f159db73 Chris Down         2021-06-15  103   */
ad7d61f159db73 Chris Down         2021-06-15  104  #define dev_printk_index_emit(level, fmt, ...) \
ad7d61f159db73 Chris Down         2021-06-15  105  	printk_index_subsys_emit("%s %s: ", level, fmt)
ad7d61f159db73 Chris Down         2021-06-15  106  
ad7d61f159db73 Chris Down         2021-06-15  107  #define dev_printk_index_wrap(_p_func, level, dev, fmt, ...)		\
ad7d61f159db73 Chris Down         2021-06-15  108  	({								\
ad7d61f159db73 Chris Down         2021-06-15  109  		dev_printk_index_emit(level, fmt);			\
ad7d61f159db73 Chris Down         2021-06-15  110  		_p_func(dev, fmt, ##__VA_ARGS__);			\
ad7d61f159db73 Chris Down         2021-06-15  111  	})
ad7d61f159db73 Chris Down         2021-06-15  112  
ad7d61f159db73 Chris Down         2021-06-15  113  /*
ad7d61f159db73 Chris Down         2021-06-15  114   * Some callsites directly call dev_printk rather than going through the
ad7d61f159db73 Chris Down         2021-06-15  115   * dev_<level> infrastructure, so we need to emit here as well as inside those
ad7d61f159db73 Chris Down         2021-06-15  116   * level-specific macros. Only one index entry will be produced, either way,
ad7d61f159db73 Chris Down         2021-06-15  117   * since dev_printk's `fmt` isn't known at compile time if going through the
ad7d61f159db73 Chris Down         2021-06-15  118   * dev_<level> macros.
ad7d61f159db73 Chris Down         2021-06-15  119   *
ad7d61f159db73 Chris Down         2021-06-15  120   * dev_fmt() isn't called for dev_printk when used directly, as it's used by
ad7d61f159db73 Chris Down         2021-06-15  121   * the dev_<level> macros internally which already have dev_fmt() processed.
ad7d61f159db73 Chris Down         2021-06-15  122   *
ad7d61f159db73 Chris Down         2021-06-15  123   * We also can't use dev_printk_index_wrap directly, because we have a separate
ad7d61f159db73 Chris Down         2021-06-15  124   * level to process.
ad7d61f159db73 Chris Down         2021-06-15  125   */
ad7d61f159db73 Chris Down         2021-06-15  126  #define dev_printk(level, dev, fmt, ...)				\
ad7d61f159db73 Chris Down         2021-06-15  127  	({								\
ad7d61f159db73 Chris Down         2021-06-15  128  		dev_printk_index_emit(level, fmt);			\
ad7d61f159db73 Chris Down         2021-06-15  129  		_dev_printk(level, dev, fmt, ##__VA_ARGS__);		\
ad7d61f159db73 Chris Down         2021-06-15  130  	})
ad7d61f159db73 Chris Down         2021-06-15  131  
c26ec799042a38 Geert Uytterhoeven 2024-02-28  132  /*
c26ec799042a38 Geert Uytterhoeven 2024-02-28  133   * Dummy dev_printk for disabled debugging statements to use whilst maintaining
c26ec799042a38 Geert Uytterhoeven 2024-02-28  134   * gcc's format checking.
c26ec799042a38 Geert Uytterhoeven 2024-02-28  135   */
c26ec799042a38 Geert Uytterhoeven 2024-02-28  136  #define dev_no_printk(level, dev, fmt, ...)				\
c26ec799042a38 Geert Uytterhoeven 2024-02-28  137  	({								\
c26ec799042a38 Geert Uytterhoeven 2024-02-28 @138  		if (0)							\
c26ec799042a38 Geert Uytterhoeven 2024-02-28  139  			_dev_printk(level, dev, fmt, ##__VA_ARGS__);	\
c26ec799042a38 Geert Uytterhoeven 2024-02-28  140  	})
c26ec799042a38 Geert Uytterhoeven 2024-02-28  141  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

