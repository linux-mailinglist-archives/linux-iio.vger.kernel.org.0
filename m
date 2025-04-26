Return-Path: <linux-iio+bounces-18713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C236FA9DCE2
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 21:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FDD465FAF
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 19:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8981B4140;
	Sat, 26 Apr 2025 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frwqe0Gj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B92701C4;
	Sat, 26 Apr 2025 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745694935; cv=none; b=e0pvM8+J+lyJ+Ank5WpwvmG/lNOwmX7peNBidpF89KlS8hlmv2g+zCZco/N10tYjG0PF4bXvaULxQ3LWxQtHHt7WUDaooyadEw9pt0J6mgtRQBxcIjvUMmMp5PRv8Nnza2oU57MlbcgR98kNR8u6Q3C+neTcy5OrTd3GXF/2Zx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745694935; c=relaxed/simple;
	bh=brOk3A6MPbfofZsQC9PM6kvZwS6E7KFFlMtFDrx1zJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIBgOFXzPXt3Wr1QqPmW/ZUe8S2oYoq42ossg6mMdv+TmOfinAm+0P0ltF3w2UIgwWJ3w/Fv+/tGfuWAe8FPF7OOpoTBkup+oiy7cgfN/s75FGebGQVf7PJFuigPuZGDW1bDDlPz7VB9rj9F+mstyFcncaz78k4h2Mncq4hIdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frwqe0Gj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745694933; x=1777230933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=brOk3A6MPbfofZsQC9PM6kvZwS6E7KFFlMtFDrx1zJQ=;
  b=frwqe0GjJbZhaoJrpsquC6+9hmJlNgQ66mH0i8huhOG4ZshdyERfd12L
   esQ9OtMb+3e63riTg6872nxjHaYc3DzuAl/d9iI8J5VG5yPbwFJXF4LQx
   A0i3vMx12lOx+ZkfKc0O0m/wVCGTBnTjrtR6e6L8YZ5B0HK9KEnH3Jpwy
   ATrVh5kV2vdRA5QMnSW+fpdrwuE8x5V6dnQb+hY0xp9LZu05RPKZH3p9a
   osL/F9y0MBzBpp8C3Z5g+KbR0ulLt8UDQuY1BTyTT8G0WaygbN9GnxLpH
   JdWWoVDnF+cdVn6U0Xa9f1HsgO4VISGozgwUlWMdX0qcPsiVKTTsnUO5s
   A==;
X-CSE-ConnectionGUID: BJl1FCuPQEmf1SnLZmiebQ==
X-CSE-MsgGUID: fpalePb0Q3Wa0wR5uYWIaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="46445891"
X-IronPort-AV: E=Sophos;i="6.15,242,1739865600"; 
   d="scan'208";a="46445891"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 12:15:33 -0700
X-CSE-ConnectionGUID: gokFKn95S0S6quEt4GqBow==
X-CSE-MsgGUID: tawfhFxxRKmiVUC6cgQZOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,242,1739865600"; 
   d="scan'208";a="133477669"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 26 Apr 2025 12:15:29 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8kzn-0005xV-1e;
	Sat, 26 Apr 2025 19:15:27 +0000
Date: Sun, 27 Apr 2025 03:15:26 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
Message-ID: <202504270311.4lppXI1u-lkp@intel.com>
References: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-1-f12df1bff248@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-1-f12df1bff248@baylibre.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on aff301f37e220970c2f301b5c65a8bfedf52058e]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-introduce-IIO_DECLARE_BUFFER_WITH_TS-macros/20250426-051240
base:   aff301f37e220970c2f301b5c65a8bfedf52058e
patch link:    https://lore.kernel.org/r/20250425-iio-introduce-iio_declare_buffer_with_ts-v3-1-f12df1bff248%40baylibre.com
patch subject: [PATCH v3 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
config: openrisc-randconfig-r053-20250427 (https://download.01.org/0day-ci/archive/20250427/202504270311.4lppXI1u-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250427/202504270311.4lppXI1u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504270311.4lppXI1u-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/kobject.h:19,
                    from include/linux/cdev.h:5,
                    from drivers/iio/industrialio-core.c:13:
>> include/linux/build_bug.h:78:41: error: static assertion failed: "macros above assume that IIO_DMA_MINALIGN also ensures s64 timestamp alignment"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/iio/iio.h:815:1: note: in expansion of macro 'static_assert'
     815 | static_assert(IIO_DMA_MINALIGN % sizeof(s64) == 0,
         | ^~~~~~~~~~~~~


vim +78 include/linux/build_bug.h

bc6245e5efd70c Ian Abbott       2017-07-10  60  
6bab69c65013be Rasmus Villemoes 2019-03-07  61  /**
6bab69c65013be Rasmus Villemoes 2019-03-07  62   * static_assert - check integer constant expression at build time
6bab69c65013be Rasmus Villemoes 2019-03-07  63   *
6bab69c65013be Rasmus Villemoes 2019-03-07  64   * static_assert() is a wrapper for the C11 _Static_assert, with a
6bab69c65013be Rasmus Villemoes 2019-03-07  65   * little macro magic to make the message optional (defaulting to the
6bab69c65013be Rasmus Villemoes 2019-03-07  66   * stringification of the tested expression).
6bab69c65013be Rasmus Villemoes 2019-03-07  67   *
6bab69c65013be Rasmus Villemoes 2019-03-07  68   * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
6bab69c65013be Rasmus Villemoes 2019-03-07  69   * scope, but requires the expression to be an integer constant
6bab69c65013be Rasmus Villemoes 2019-03-07  70   * expression (i.e., it is not enough that __builtin_constant_p() is
6bab69c65013be Rasmus Villemoes 2019-03-07  71   * true for expr).
6bab69c65013be Rasmus Villemoes 2019-03-07  72   *
6bab69c65013be Rasmus Villemoes 2019-03-07  73   * Also note that BUILD_BUG_ON() fails the build if the condition is
6bab69c65013be Rasmus Villemoes 2019-03-07  74   * true, while static_assert() fails the build if the expression is
6bab69c65013be Rasmus Villemoes 2019-03-07  75   * false.
6bab69c65013be Rasmus Villemoes 2019-03-07  76   */
6bab69c65013be Rasmus Villemoes 2019-03-07  77  #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
6bab69c65013be Rasmus Villemoes 2019-03-07 @78  #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
6bab69c65013be Rasmus Villemoes 2019-03-07  79  
07a368b3f55a79 Maxim Levitsky   2022-10-25  80  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

