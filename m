Return-Path: <linux-iio+bounces-11370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28849B1C24
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 05:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33BBEB215D4
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 04:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FFF2770B;
	Sun, 27 Oct 2024 04:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmyXI7I0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE9B2A1C9;
	Sun, 27 Oct 2024 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730003293; cv=none; b=WV2OQ1Xfa8cJ9cyYZ9ylgfgpchIdDxl8Mu8O9IZ+02FsvZvgJSo22UhP5I5a1UvsU9EcRtmo4H9ekuteVSPICZynQ8hUBrRBS4V88F+dpg9NMfOfAtliiYMPRZamxM+t4CBZsS/eNlcb8nrWuxz7deSSVl/Fyw2gNRLRGeyd7A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730003293; c=relaxed/simple;
	bh=S5z1ERvXpeJxLkMI4pFAGnwF3EQD1xNCXk1RPrpneXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhGVZkFcXU2LKb4ONrB+GAsRZ29hqM1nYosXTOwh7ORU4trdK6jTc+Y+OWcDfZvGIQkvkjVTgBqcj4qN5PJL8WbTdGtmnh49YoXLM6ekBfghc6xCHN2sJugsupFeXMd6QEF9r/zm62aTLOseedHS+e9l8nbJJ//7uUMLL9ohZx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmyXI7I0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730003291; x=1761539291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S5z1ERvXpeJxLkMI4pFAGnwF3EQD1xNCXk1RPrpneXE=;
  b=gmyXI7I0QIGQxd3yUrSTERYUUTMnG0ahtp8YI/0ZZw24JbS2dw3WnUzA
   pkn7V5nSe/JxDGFmhFNVZTl/y1jrMsAs4QEVVoxTDTfSzds7iVVcGH4Rm
   uakz4+57RjBMCHEfxHEpsmRX3LD3W/FF2TaxQ/Vi0ok3FQio+d7BTXuX+
   ehK4wm0W53l/DsS0rFNznjOBA0kiZJAlL0U8qKIWUY9nKx0Mjpwbr0PF3
   p+NAz5cwOnuBs2YqwufypcPpxc+ImsRxJO7Zw1rZvfw2pV6BY87iqIt5/
   aoGdjPUG6MGkKZNxR9rokLzC0xQfDapTBXO1NxLWowL2ioE5iAcctdTc4
   A==;
X-CSE-ConnectionGUID: Wl+DIG6lSPybFHoxHmj9eA==
X-CSE-MsgGUID: kjz0IyzoTPSF5o+6wEEmoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="17264213"
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="17264213"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 21:28:10 -0700
X-CSE-ConnectionGUID: dAJp7rJJTXqJcpv+Fv/wrQ==
X-CSE-MsgGUID: 1aXRmt+JQ52MfrTX0L+PpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="86050350"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 26 Oct 2024 21:28:08 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4usn-000aMC-2r;
	Sun, 27 Oct 2024 04:28:05 +0000
Date: Sun, 27 Oct 2024 12:27:10 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2] iio: adc: ad7380: use if_not_cond_guard for claim
 direct
Message-ID: <202410271218.9sti93hi-lkp@intel.com>
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
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20241027/202410271218.9sti93hi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241027/202410271218.9sti93hi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410271218.9sti93hi-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/adc/ad7380.c: In function 'ad7380_debugfs_reg_access':
>> drivers/iio/adc/ad7380.c:574:9: error: implicit declaration of function 'if_not_cond_guard' [-Werror=implicit-function-declaration]
     574 |         if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |         ^~~~~~~~~~~~~~~~~
>> drivers/iio/adc/ad7380.c:574:27: error: 'iio_claim_direct_try' undeclared (first use in this function); did you mean 'class_iio_claim_direct_try_t'?
     574 |         if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                           ^~~~~~~~~~~~~~~~~~~~
         |                           class_iio_claim_direct_try_t
   drivers/iio/adc/ad7380.c:574:27: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/iio/adc/ad7380.c:574:59: error: expected ';' before 'return'
     574 |         if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                                                           ^
         |                                                           ;
     575 |                 return -EBUSY;
         |                 ~~~~~~                                     
   drivers/iio/adc/ad7380.c: In function 'ad7380_read_raw':
   drivers/iio/adc/ad7380.c:823:35: error: 'iio_claim_direct_try' undeclared (first use in this function); did you mean 'class_iio_claim_direct_try_t'?
     823 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                                   ^~~~~~~~~~~~~~~~~~~~
         |                                   class_iio_claim_direct_try_t
   drivers/iio/adc/ad7380.c:823:67: error: expected ';' before 'return'
     823 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                                                                   ^
         |                                                                   ;
     824 |                         return -EBUSY;
         |                         ~~~~~~                                     
   drivers/iio/adc/ad7380.c: In function 'ad7380_write_raw':
   drivers/iio/adc/ad7380.c:912:35: error: 'iio_claim_direct_try' undeclared (first use in this function); did you mean 'class_iio_claim_direct_try_t'?
     912 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                                   ^~~~~~~~~~~~~~~~~~~~
         |                                   class_iio_claim_direct_try_t
   drivers/iio/adc/ad7380.c:912:67: error: expected ';' before 'return'
     912 |                 if_not_cond_guard(iio_claim_direct_try, indio_dev)
         |                                                                   ^
         |                                                                   ;
     913 |                         return -EBUSY;
         |                         ~~~~~~                                     
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=n] || GCC_PLUGINS [=y]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


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

