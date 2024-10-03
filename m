Return-Path: <linux-iio+bounces-10102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E68498FA66
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 01:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DA01F2339E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BE91CCED6;
	Thu,  3 Oct 2024 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bSl0982C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680891CEAC5;
	Thu,  3 Oct 2024 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998021; cv=none; b=bouB5oD5I4nHsZkIEnWraLmn7b2r1N2h+swGsnP8Jq91M3zF1cXG6uLCfW5QFiGvKEdh4VUh0tObSxtT6hlqOzCMfKvjAvLD8G4fL/9cyoGRIMbupypblBVEaE6BDxBUYQbbljN3b/FXBXxxmNSX/1a6y9QenbJW0HAz8I7iSzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998021; c=relaxed/simple;
	bh=aNlxrPz0Onakv+a4ZcnpY+rxavPhtRRm8WsJdwPsDgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUbtx2F6XYSlIK0QQtTss8uM4/W7GrQxn3CipTwndjOh254GqklkXY7y+FWympkR8BjJ0LN5HC7aIJV+EbWCiP7PzESuJvtb9EAZNXt+Hf7x04Q6aJnSQsphxdDB88q00IdwgbWNm8y1aKjwJwBhElvVZ13pcCc8BHDnEh+BRpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bSl0982C; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727998019; x=1759534019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aNlxrPz0Onakv+a4ZcnpY+rxavPhtRRm8WsJdwPsDgo=;
  b=bSl0982CBvcnuzGN27Nc05SqfMkCCAkdrtj/5pV+EN1GiMxd6Eko3ckS
   xdnk8Ip3uRQUgjb2tphxECvZavzLLTCTlOYe5BpeLMeh6KvN8VaXhfvMT
   MktCw8WIaalyRLiUuICDfa34qnMtNxh1nsWD0iZR19XF2/RbppGs46uQN
   9CGFeE33RWbO1XROBD2pJsGR9p3GcXhsPWP+rHVaf54QvEUWPZhWwjfLC
   1292p3KRgG04r2c9uqaSs1pjHyaFupibucG+g4ChzzgvJfMSWe7c7uPnM
   dhBnqbSjTGoxjNQcQ4et/2ihsqc3lv3whjULEGGu7pQTBMa7XbVmrjdM5
   w==;
X-CSE-ConnectionGUID: MmgWpA35SK+Mp7iPcPKKZg==
X-CSE-MsgGUID: A1pgneFtQ9usjEarPtImIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="30093306"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="30093306"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 16:26:58 -0700
X-CSE-ConnectionGUID: LElRzrFPRa6ZbF9H3ISchQ==
X-CSE-MsgGUID: tOPdkfXHRvads+9kbySsMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="79360364"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 03 Oct 2024 16:26:55 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swVDh-000116-25;
	Thu, 03 Oct 2024 23:26:53 +0000
Date: Fri, 4 Oct 2024 07:26:42 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH] iio: core: make iio_device_claim_direct_mode()
 __must_check
Message-ID: <202410040721.upAHwZJm-lkp@intel.com>
References: <20241002-iio-must-check-claim-direct-v1-1-ab94ce728731@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-iio-must-check-claim-direct-v1-1-ab94ce728731@baylibre.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-core-make-iio_device_claim_direct_mode-__must_check/20241002-233644
base:   431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e
patch link:    https://lore.kernel.org/r/20241002-iio-must-check-claim-direct-v1-1-ab94ce728731%40baylibre.com
patch subject: [PATCH] iio: core: make iio_device_claim_direct_mode() __must_check
config: arm-randconfig-001-20241004 (https://download.01.org/0day-ci/archive/20241004/202410040721.upAHwZJm-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project fef3566a25ff0e34fb87339ba5e13eca17cec00f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410040721.upAHwZJm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410040721.upAHwZJm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/pressure/bmp280-regmap.c:6:
   In file included from drivers/iio/pressure/bmp280.h:5:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/iio/pressure/bmp280-regmap.c:6:
   In file included from drivers/iio/pressure/bmp280.h:7:
>> include/linux/iio/iio.h:669:50: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
     669 | DEFINE_GUARD(iio_claim_direct, struct iio_dev *, iio_device_claim_direct_mode(_T),
         |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~
   include/linux/cleanup.h:291:54: note: expanded from macro 'DEFINE_GUARD'
     291 |         DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
         |                                                             ^~~~~
   include/linux/cleanup.h:248:13: note: expanded from macro 'DEFINE_CLASS'
     248 | { _type t = _init; return t; }
         |             ^~~~~
   2 warnings generated.
--
   In file included from drivers/iio/pressure/ms5611_core.c:14:
>> include/linux/iio/iio.h:669:50: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
     669 | DEFINE_GUARD(iio_claim_direct, struct iio_dev *, iio_device_claim_direct_mode(_T),
         |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~
   include/linux/cleanup.h:291:54: note: expanded from macro 'DEFINE_GUARD'
     291 |         DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
         |                                                             ^~~~~
   include/linux/cleanup.h:248:13: note: expanded from macro 'DEFINE_CLASS'
     248 | { _type t = _init; return t; }
         |             ^~~~~
   In file included from drivers/iio/pressure/ms5611_core.c:16:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   2 warnings generated.
--
   In file included from drivers/iio/pressure/mpl115.c:11:
>> include/linux/iio/iio.h:669:50: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
     669 | DEFINE_GUARD(iio_claim_direct, struct iio_dev *, iio_device_claim_direct_mode(_T),
         |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~
   include/linux/cleanup.h:291:54: note: expanded from macro 'DEFINE_GUARD'
     291 |         DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
         |                                                             ^~~~~
   include/linux/cleanup.h:248:13: note: expanded from macro 'DEFINE_CLASS'
     248 | { _type t = _init; return t; }
         |             ^~~~~
   1 warning generated.


vim +/warn_unused_result +669 include/linux/iio/iio.h

1dae0cb79ceacb Jonathan Cameron 2024-01-28  664  
1dae0cb79ceacb Jonathan Cameron 2024-01-28  665  /*
1dae0cb79ceacb Jonathan Cameron 2024-01-28  666   * This autocleanup logic is normally used via
1dae0cb79ceacb Jonathan Cameron 2024-01-28  667   * iio_device_claim_direct_scoped().
1dae0cb79ceacb Jonathan Cameron 2024-01-28  668   */
1dae0cb79ceacb Jonathan Cameron 2024-01-28 @669  DEFINE_GUARD(iio_claim_direct, struct iio_dev *, iio_device_claim_direct_mode(_T),
1dae0cb79ceacb Jonathan Cameron 2024-01-28  670  	     iio_device_release_direct_mode(_T))
1dae0cb79ceacb Jonathan Cameron 2024-01-28  671  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

