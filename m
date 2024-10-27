Return-Path: <linux-iio+bounces-11371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC4C9B1C36
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 06:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85791F21917
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 05:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F376533981;
	Sun, 27 Oct 2024 05:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqAEl84s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF929CE8;
	Sun, 27 Oct 2024 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730005815; cv=none; b=tqO4CMQAvEoDDwb8R8hNwf2mqeDxk5CLY3cbM7ZpH88hYwqybW6OoSK6C9dBws6GKG9DSTtqV6hwR8wB4n88cX5ETwwfId3y2JJmsKWtcbw7wWJRuhWuBZDVeg/HQwHI9xYubCdB1EcXUCKb2dPykSZ4BGfJErAe6V2mWTHlPpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730005815; c=relaxed/simple;
	bh=SWeLyCKZ3my3ZuW9ckkJgeuwnpPSvITLtLoBuJ2Wan4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0FH0E5nWM/mV75t4Q9CEP1IsztClxqZHVl15TypJyfuZ/3j9GJwmp6agc9rOIB2SVczTGtCaA9LQtabvO7XjmH+cSOzGdc0QluMyuBgcfBl7g8Y25m/MTZ3r2nGFshlyHxe1S/D4iXWItCl+jDyqEqR+v6svDgrkwXyOOpLflk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqAEl84s; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730005814; x=1761541814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SWeLyCKZ3my3ZuW9ckkJgeuwnpPSvITLtLoBuJ2Wan4=;
  b=ZqAEl84s2Tetn4snyuWEL5f5ZJ4nv2PQMBi8aQTf43TwS/wR1CRn9epv
   EBqcHQsFqqv80hvbbU3YpCEZC7vZi6ANTdRSX2NgLcsXKdN0SUjJ0V6oF
   fikFpkRTWluZBGeRIMK8ZLsJRc45E3wvThMoQQ4EpfH4pSJ0H//lBIVff
   /9G7zQVMOx5Ags8nqnNlZa63gmRG3VcrKK6RTnnNB+GyKwuKL9GNfUj6E
   +D5s3i/kaw63W9pgyDwxWrGKz3k3iogYe8QubCiGo7j2BxxUE1dBeNuOa
   V94obUIRxCZ+qOPL2PWueV0ADsjcazD/y0uFmO/X7H9K8M/M0kL92E6xH
   w==;
X-CSE-ConnectionGUID: X97Cyzf3QemnOY5lgRgeKw==
X-CSE-MsgGUID: Ogoq9itoT9SCR9WsDngspQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47091811"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47091811"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 22:10:13 -0700
X-CSE-ConnectionGUID: sIjJOROGQPS5rEdqt2fkjA==
X-CSE-MsgGUID: p/7Y7y2DSMmOlQJC41YLug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="118766793"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Oct 2024 22:10:10 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4vXU-000aO2-0C;
	Sun, 27 Oct 2024 05:10:08 +0000
Date: Sun, 27 Oct 2024 13:09:16 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2] iio: adc: ad7380: use if_not_cond_guard for claim
 direct
Message-ID: <202410271212.2EFjrzX0-lkp@intel.com>
References: <20241024-cleanup-if_not_cond_guard-v2-1-1bef98c9fd2e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-cleanup-if_not_cond_guard-v2-1-1bef98c9fd2e@baylibre.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on 431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-adc-ad7380-use-if_not_cond_guard-for-claim-direct/20241025-001415
base:   431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e
patch link:    https://lore.kernel.org/r/20241024-cleanup-if_not_cond_guard-v2-1-1bef98c9fd2e%40baylibre.com
patch subject: [PATCH v2] iio: adc: ad7380: use if_not_cond_guard for claim direct
config: arm-randconfig-001-20241027 (https://download.01.org/0day-ci/archive/20241027/202410271212.2EFjrzX0-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241027/202410271212.2EFjrzX0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410271212.2EFjrzX0-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/adc/ad7380.c:27:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/adc/ad7380.c:574:2: error: call to undeclared function 'if_not_cond_guard'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     574 |         if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |         ^
>> drivers/iio/adc/ad7380.c:574:52: error: expected ';' after expression
     574 |         if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                                                           ^
         |                                                           ;
>> drivers/iio/adc/ad7380.c:574:20: error: use of undeclared identifier 'iio_claim_direct_try'
     574 |         if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                           ^
   drivers/iio/adc/ad7380.c:823:3: error: call to undeclared function 'if_not_cond_guard'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     823 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                 ^
   drivers/iio/adc/ad7380.c:823:53: error: expected ';' after expression
     823 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                                                                   ^
         |                                                                   ;
   drivers/iio/adc/ad7380.c:823:21: error: use of undeclared identifier 'iio_claim_direct_try'
     823 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                                   ^
   drivers/iio/adc/ad7380.c:912:3: error: call to undeclared function 'if_not_cond_guard'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     912 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                 ^
   drivers/iio/adc/ad7380.c:912:53: error: expected ';' after expression
     912 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                                                                   ^
         |                                                                   ;
   drivers/iio/adc/ad7380.c:912:21: error: use of undeclared identifier 'iio_claim_direct_try'
     912 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                                   ^
   1 warning and 9 errors generated.


vim +/if_not_cond_guard +574 drivers/iio/adc/ad7380.c

   568	
   569	static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
   570					     u32 writeval, u32 *readval)
   571	{
   572		struct ad7380_state *st = iio_priv(indio_dev);
   573	
 > 574		if_not_cond_guard(iio_claim_direct_try, indio_dev)
   575			return -EBUSY;
   576	
   577		if (readval)
   578			return regmap_read(st->regmap, reg, readval);
   579	
   580		return regmap_write(st->regmap, reg, writeval);
   581	}
   582	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

