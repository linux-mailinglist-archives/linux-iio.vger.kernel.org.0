Return-Path: <linux-iio+bounces-19236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D0EAADC97
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 12:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0594A7B2A57
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 10:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF75213E6A;
	Wed,  7 May 2025 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7yHaTlF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197D220E315;
	Wed,  7 May 2025 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746614181; cv=none; b=dFzRlOEI/eUvlL7+gFZ3V/TqnNcSDxKnrf24bxgduAinPM31wHsI1YvcxqBGgwC0yqt/+1zBxxQwO+vJ8IN6n+HaejSNASwdjg+OiNTIny+AjBuSN8baqV/TBR4/LlvQZc9ttCNHeTZY9IzHZoX2Y3Fi/dhhhcl5By7WkjGO+8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746614181; c=relaxed/simple;
	bh=+5rZG+/VNvfdN+SHsJYoUKfRt7JTdAwPzAikCSXr6rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXxCw/D5WGAiYfH1Bdz771IL8uLOYbVZ7vTvA0asBn7Yah8bH/HS4VI52PJgHUJIyjaqOina2dtF5X0QRBYlvyfldBTtbkt6lJKB/vaZP9cRasGeEipBUIuy9JwUUtJ45satdGq4laKsQ7S4eC7+fKKjtPXFkXzF4RCBvCIDJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7yHaTlF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746614180; x=1778150180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+5rZG+/VNvfdN+SHsJYoUKfRt7JTdAwPzAikCSXr6rI=;
  b=A7yHaTlFJPOjxiXlyqlKiz3+BEGpm3ngTJuLye3f/CAmkeSOt+9iXJXt
   9Wrc09xzRQACBy5EufYXRVqEdjNK4zRCztRnvsRBRoMmRdYs+IGSgjIE2
   cUNA3DGclmMqj7MINadk13IL/1jRp+id3dmqyPpvh2ECcGADmt/tDGg4B
   fcW/NFNAOLuadXUx0Qosp1OzX6/hz4JZoTP9LyyLlqx0G4RzPLOqNH77D
   RDS5GOS1dkaiX9KuuOUymnhipxhuA7G60ZlGrZOo6paDnWD5UsnJhYS0M
   t6JCGn+gqFXEq3TncE3CtLHXZUqepLmYCMZ9opbaqEAk1hEZdksow+RnG
   Q==;
X-CSE-ConnectionGUID: jXR5ZQGIT4O8qPH9YJG9eQ==
X-CSE-MsgGUID: nSYXjon/SO2BO7X/zD/Hhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="58965685"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="58965685"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 03:36:18 -0700
X-CSE-ConnectionGUID: S2v7VjctTiub4ml4VA950Q==
X-CSE-MsgGUID: RPf2npvlQL6qW5gqzv/DGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="135630664"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 07 May 2025 03:36:15 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCc8L-0007c5-16;
	Wed, 07 May 2025 10:36:13 +0000
Date: Wed, 7 May 2025 18:35:45 +0800
From: kernel test robot <lkp@intel.com>
To: Gustavo Silva <gustavograzs@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gustavo Silva <gustavograzs@gmail.com>
Subject: Re: [PATCH 1/3] iio: imu: bmi270: add channel for step counter
Message-ID: <202505071850.e6YE0Jm9-lkp@intel.com>
References: <20250424-bmi270-events-v1-1-a6c722673e5f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-bmi270-events-v1-1-a6c722673e5f@gmail.com>

Hi Gustavo,

kernel test robot noticed the following build errors:

[auto build test ERROR on b475195fecc79a1a6e7fb0846aaaab0a1a4cb2e6]

url:    https://github.com/intel-lab-lkp/linux/commits/Gustavo-Silva/iio-imu-bmi270-add-channel-for-step-counter/20250425-081720
base:   b475195fecc79a1a6e7fb0846aaaab0a1a4cb2e6
patch link:    https://lore.kernel.org/r/20250424-bmi270-events-v1-1-a6c722673e5f%40gmail.com
patch subject: [PATCH 1/3] iio: imu: bmi270: add channel for step counter
config: csky-randconfig-r071-20250426 (https://download.01.org/0day-ci/archive/20250507/202505071850.e6YE0Jm9-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250507/202505071850.e6YE0Jm9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505071850.e6YE0Jm9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'bmi270_update_feature_reg',
       inlined from 'bmi270_enable_steps' at drivers/iio/imu/bmi270/bmi270_core.c:361:8,
       inlined from 'bmi270_write_raw' at drivers/iio/imu/bmi270/bmi270_core.c:707:10:
>> include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_399' declared with attribute error: BUILD_BUG failed
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:538:25: note: in definition of macro '__compiletime_assert'
     538 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:557:9: note: in expansion of macro '_compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
         |                     ^~~~~~~~~~~~~~~~
   arch/csky/include/asm/cmpxchg.h:151:17: note: in expansion of macro 'BUILD_BUG'
     151 |                 BUILD_BUG();                                    \
         |                 ^~~~~~~~~
   arch/csky/include/asm/cmpxchg.h:157:10: note: in expansion of macro '__cmpxchg'
     157 |         (__cmpxchg((ptr), (o), (n), sizeof(*(ptr))))
         |          ^~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
         |                ^~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~
   include/linux/bitops.h:367:19: note: in expansion of macro 'try_cmpxchg'
     367 |         } while (!try_cmpxchg(ptr, &old__, new__));             \
         |                   ^~~~~~~~~~~
   drivers/iio/imu/bmi270/bmi270_core.c:348:9: note: in expansion of macro 'set_mask_bits'
     348 |         set_mask_bits(&reg_val, mask, val);
         |         ^~~~~~~~~~~~~
   In function 'bmi270_update_feature_reg',
       inlined from 'bmi270_write_raw' at drivers/iio/imu/bmi270/bmi270_core.c:715:10:
>> include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_399' declared with attribute error: BUILD_BUG failed
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:538:25: note: in definition of macro '__compiletime_assert'
     538 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:557:9: note: in expansion of macro '_compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
         |                     ^~~~~~~~~~~~~~~~
   arch/csky/include/asm/cmpxchg.h:151:17: note: in expansion of macro 'BUILD_BUG'
     151 |                 BUILD_BUG();                                    \
         |                 ^~~~~~~~~
   arch/csky/include/asm/cmpxchg.h:157:10: note: in expansion of macro '__cmpxchg'
     157 |         (__cmpxchg((ptr), (o), (n), sizeof(*(ptr))))
         |          ^~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:192:16: note: in expansion of macro 'raw_cmpxchg'
     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
         |                ^~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:4880:9: note: in expansion of macro 'raw_try_cmpxchg'
    4880 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~
   include/linux/bitops.h:367:19: note: in expansion of macro 'try_cmpxchg'
     367 |         } while (!try_cmpxchg(ptr, &old__, new__));             \
         |                   ^~~~~~~~~~~
   drivers/iio/imu/bmi270/bmi270_core.c:348:9: note: in expansion of macro 'set_mask_bits'
     348 |         set_mask_bits(&reg_val, mask, val);
         |         ^~~~~~~~~~~~~


vim +/__compiletime_assert_399 +557 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  543  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  544  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  545  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  546  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  547  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  548   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  549   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  550   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  551   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  552   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  553   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  554   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  555   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  556  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @557  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  558  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

