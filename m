Return-Path: <linux-iio+bounces-19394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE985AB19BC
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6CE3B22A4
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57717236430;
	Fri,  9 May 2025 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2ss3g8H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A123506F;
	Fri,  9 May 2025 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806377; cv=none; b=NJF6dAWUJEuN+FESiWsSzZ0LTrCdHgINCJYRFcvthbvtjRFmnOvava+1/XQBK37IQ3V/qL0vHFokotFJP4gyhYbeE9B9MpriGbxRCUIKsyPxwGLu7aGHYv9+aXxqXzvzvn2+FnI78hZBZ0ZUekXtBmx36oPSCCSAjZ0K71la3Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806377; c=relaxed/simple;
	bh=h2kWVI9tPku6cxcG/rzSWHBGCF3nXiUEMtt00r6go0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrdfeJ+ONUQYSafRgvoo1SbAHoj4GQ2N6onA5JQ7fT6p9muBr/RVuFg1LMsN/Sl4i7QIU85tdMbVa89IxQgA2LWQvUr4RaL4tKi7PF4fKUe3YFS7iRivk8zy1MLOp/IfC2ZZEz8zOXgAGDJpQuVbDxVC6R0y9IN1Q5W5DjrUH2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2ss3g8H; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746806374; x=1778342374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h2kWVI9tPku6cxcG/rzSWHBGCF3nXiUEMtt00r6go0w=;
  b=V2ss3g8HM1hwJh+HQNsVHhiffCSVNTooXiiJOKE4D4k/q2KaGWJoSlUj
   GfSXoPm8SVp2qEhOjuk88thiKCMOTR8uDjCApTrswdH/UYJweFEP30AcM
   48xivPGla3uEGtTtZ/gP2xJ5x+1VuP3o4Ihv+VBiLKfecfm/qbd/e9m9W
   HDOOsDeL3mH2tLgCTLiQcnTKqmzZFBLISBRf5G2lZ6HMgUGVfcQKC7uoY
   sfmLD9xhh8XQCG5xyyFCFPUdZidh9Ir/t3+7ifddMaWbUeXCz2QnDR8wm
   1uoMTspIt83sCvBvWWmZoLLslW6Q4WnJvGi4Nu+BSM/5zJPpSaEtoInpj
   Q==;
X-CSE-ConnectionGUID: 0sO9tHZOQdeRAGf1vHtRJw==
X-CSE-MsgGUID: hdEHv5HkQ1iyAnB9EpTkoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48798427"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48798427"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 08:59:34 -0700
X-CSE-ConnectionGUID: i7oooTQ4SNm/ZdqJZ8mnvw==
X-CSE-MsgGUID: Ryji/geURwqLHOsw+Ct2PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="137043451"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 May 2025 08:59:29 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDQ8E-000CDb-35;
	Fri, 09 May 2025 15:59:26 +0000
Date: Fri, 9 May 2025 23:58:53 +0800
From: kernel test robot <lkp@intel.com>
To: Jianping.Shen@de.bosch.com, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dima.fedrau@gmail.com, marcelo.schmitt1@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christian.Lorenz3@de.bosch.com,
	Ulrike.Frauendorf@de.bosch.com, Kai.Dolde@de.bosch.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 3/3] iio: imu: smi330: Add driver
Message-ID: <202505092349.jx1FRafM-lkp@intel.com>
References: <20250505151641.52878-4-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505151641.52878-4-Jianping.Shen@de.bosch.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.15-rc5 next-20250509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jianping-Shen-de-bosch-com/docs-iio-imu-smi330-Add-ABI-documentation/20250505-232315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250505151641.52878-4-Jianping.Shen%40de.bosch.com
patch subject: [PATCH v1 3/3] iio: imu: smi330: Add driver
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250509/202505092349.jx1FRafM-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505092349.jx1FRafM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505092349.jx1FRafM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/imu/smi330/smi330_core.c:557:15: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     557 |                 reg_value = FIELD_PREP(mask, reg_value);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:561:15: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     561 |                 reg_value = FIELD_PREP(mask, reg_value);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:565:15: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     565 |                 reg_value = FIELD_PREP(mask, reg_value);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:569:15: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     569 |                 reg_value = FIELD_PREP(mask, reg_value);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:573:15: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     573 |                 reg_value = FIELD_PREP(mask, reg_value);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/iio/imu/smi330/smi330_core.c:1010:20: warning: result of comparison of constant 61292 with expression of type 's16' (aka 'short') is always true [-Wtautological-constant-out-of-range-compare]
    1010 |                           data_array[8] != SMI330_SC_ST_VALUE_8))) {
         |                           ~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:1009:20: warning: result of comparison of constant 65485 with expression of type 's16' (aka 'short') is always true [-Wtautological-constant-out-of-range-compare]
    1009 |                           data_array[7] != SMI330_SC_ST_VALUE_7 ||
         |                           ~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:1006:20: warning: result of comparison of constant 65519 with expression of type 's16' (aka 'short') is always true [-Wtautological-constant-out-of-range-compare]
    1006 |                           data_array[4] != SMI330_SC_ST_VALUE_4 ||
         |                           ~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:1004:20: warning: result of comparison of constant 37401 with expression of type 's16' (aka 'short') is always true [-Wtautological-constant-out-of-range-compare]
    1004 |                           data_array[1] != SMI330_SC_ST_VALUE_1 ||
         |                           ~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:1002:33: warning: result of comparison of constant 65512 with expression of type 's16' (aka 'short') is always true [-Wtautological-constant-out-of-range-compare]
    1002 |         if (ret == 0 && (data_array[3] != SMI330_SC_ST_VALUE_3 &&
         |                          ~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:1374:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
    1374 |                 val = FIELD_PREP(mask, val);
         |                       ^~~~~~~~~~~~~~~~~~~~~
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
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:1378:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
    1378 |                 val = FIELD_PREP(mask, val);
         |                       ^~~~~~~~~~~~~~~~~~~~~
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
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/iio/imu/smi330/smi330_core.c:2156:14: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((en_mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (en_mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
    2156 |                                 en_val = FIELD_PREP(en_mask, state);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:2160:14: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((en_mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (en_mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
    2160 |                                 en_val = FIELD_PREP(en_mask, state);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:2164:14: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((en_mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (en_mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
    2164 |                                 en_val = FIELD_PREP(en_mask, state);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/iio/imu/smi330/smi330_core.c:2170:14: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((int_mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (int_mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
    2170 |                         int_val = FIELD_PREP(int_mask, data->cfg.feat_irq);
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:2176:14: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((en_mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (en_mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
    2176 |                                 en_val = FIELD_PREP(en_mask, state);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:2180:14: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((en_mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (en_mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
    2180 |                                 en_val = FIELD_PREP(en_mask, state);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:2184:14: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((en_mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (en_mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
    2184 |                                 en_val = FIELD_PREP(en_mask, state);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
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
   include/linux/compiler_types.h:557:22: note: expanded from macro 'compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:545:23: note: expanded from macro '_compiletime_assert'
     545 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:537:9: note: expanded from macro '__compiletime_assert'
     537 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/iio/imu/smi330/smi330_core.c:2190:14: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((int_mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (int_mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]


vim +557 drivers/iio/imu/smi330/smi330_core.c

   524	
   525	static int smi330_set_sensor_config(struct smi330_data *data,
   526					    enum smi330_sensor sensor,
   527					    enum smi330_sensor_conf_select config,
   528					    int value, bool is_reg_value)
   529	{
   530		int ret, i, reg_value, mask;
   531		const struct smi330_sysfs_attr *attr;
   532	
   533		if (is_reg_value) {
   534			reg_value = value;
   535		} else {
   536			ret = smi330_get_sysfs_attr(config, sensor, &attr);
   537			if (ret)
   538				return ret;
   539	
   540			ret = -EINVAL;
   541			for (i = 0; i < attr->len; i++) {
   542				if (attr->vals[i] == value) {
   543					if (attr->type == IIO_VAL_INT)
   544						reg_value = attr->reg_vals[i];
   545					else
   546						reg_value = attr->reg_vals[i / 2];
   547					ret = 0;
   548				}
   549			}
   550			if (ret)
   551				return ret;
   552		}
   553	
   554		switch (config) {
   555		case SMI330_ODR:
   556			mask = SMI330_CFG_ODR_MASK;
 > 557			reg_value = FIELD_PREP(mask, reg_value);
   558			break;
   559		case SMI330_RANGE:
   560			mask = SMI330_CFG_RANGE_MASK;
   561			reg_value = FIELD_PREP(mask, reg_value);
   562			break;
   563		case SMI330_BW:
   564			mask = SMI330_CFG_BW_MASK;
   565			reg_value = FIELD_PREP(mask, reg_value);
   566			break;
   567		case SMI330_AVG_NUM:
   568			mask = SMI330_CFG_AVG_NUM_MASK;
   569			reg_value = FIELD_PREP(mask, reg_value);
   570			break;
   571		case SMI330_MODE:
   572			mask = SMI330_CFG_MODE_MASK;
   573			reg_value = FIELD_PREP(mask, reg_value);
   574			break;
   575		default:
   576			return -EINVAL;
   577		}
   578	
   579		return smi330_set_sensor_config_reg(data, sensor, mask, reg_value);
   580	}
   581	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

