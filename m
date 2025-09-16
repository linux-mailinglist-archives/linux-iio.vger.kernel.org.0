Return-Path: <linux-iio+bounces-24146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74B7B59209
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 11:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9C94807F1
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 09:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C477629B20A;
	Tue, 16 Sep 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O63yaBrm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7D299A82;
	Tue, 16 Sep 2025 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014565; cv=none; b=dVyrBsRUla9PLhLxHQ9IvY3NtTm6Ml8m2Ecdjow0bu1mha/zWzJJ2st/vzoS7n23LPQXTz2JAc7YMLsKc0f0RXrysgJC3smuNS4hh9mdtCP8uEXmd1kmWggSD6MTSp4IYf0nHMWgzW9/shFDNRq4IxWzQFwUwr8wl2vhpK5ZejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014565; c=relaxed/simple;
	bh=GU4KHC9G6ZbI3IWbB/6C6WJ0fK0KNyhvBM6JeUjN1rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+43Lq6lXDvd+0+GP75TuUls2YFOB7jKFvulJAG1HMi0Dl5vV1zcgCzJnuAGHn5bA0jnltNwBYHvBn4FMTCrW8w25MZQ89kPTITup+eLI2AwR3mQQD05NUfx5Rg6Ry4ClEnHCIrOj7Kff98Wz2WBQviFKVKE9oH8MYW69iK7dyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O63yaBrm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758014564; x=1789550564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GU4KHC9G6ZbI3IWbB/6C6WJ0fK0KNyhvBM6JeUjN1rQ=;
  b=O63yaBrmd1MAnskx7zpI+lonTgOI5IcWE17mVg+HnwSZ32iWE2C+k7XG
   +c4+cUUX16NmrDYe7SajsCxp7tSH5zTHIz+wSKM0Tbvr/QOaqrG/CVWl1
   GCnELVbdnewexmuUXcyj+Sa8DjalEQ7x+q6++C3hWVRmMclvTwkwsSUTs
   rcm1aeCbjVOk0bcoHe1BwwfOjZWqISCi301MDYYocBFlcJ4gjBMmFnDr5
   KtJlMLYxWEvHFLItGUwlqPEdXcJCkr7OznnpWfFbQGuYJgFBMG8oHfD49
   uCcyHnDnJM0rRQB58KHNcoWZPxn4IWKoazh8V4LwcI2hLgW3TNNLc3lRq
   w==;
X-CSE-ConnectionGUID: kKMg5SEGTgiunpAlKm5xlg==
X-CSE-MsgGUID: zVyr2gagQ6et3nAmU3eExA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="62925429"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="62925429"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 02:22:43 -0700
X-CSE-ConnectionGUID: clR37wjuSYC+wHFH7tfVwg==
X-CSE-MsgGUID: gB+xLLfbTgiTNZrjjyddgg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2025 02:22:41 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyRtW-00009H-2R;
	Tue, 16 Sep 2025 09:22:38 +0000
Date: Tue, 16 Sep 2025 17:21:40 +0800
From: kernel test robot <lkp@intel.com>
To: Lakshay Piplani <lakshay.piplani@nxp.com>, wbg@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, vikash.bansal@nxp.com,
	priyanka.jain@nxp.com, shashank.rebbapragada@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: Re: [PATCH 2/2] counter: nxp-pcf85363-stopwatch: Add driver for NXP
 PCF85263/PCF85363 stopwatch
Message-ID: <202509161703.0ADG0iw4-lkp@intel.com>
References: <20250915071415.1956219-2-lakshay.piplani@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915071415.1956219-2-lakshay.piplani@nxp.com>

Hi Lakshay,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.17-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lakshay-Piplani/counter-nxp-pcf85363-stopwatch-Add-driver-for-NXP-PCF85263-PCF85363-stopwatch/20250915-152227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250915071415.1956219-2-lakshay.piplani%40nxp.com
patch subject: [PATCH 2/2] counter: nxp-pcf85363-stopwatch: Add driver for NXP PCF85263/PCF85363 stopwatch
config: sparc-randconfig-r121-20250916 (https://download.01.org/0day-ci/archive/20250916/202509161703.0ADG0iw4-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250916/202509161703.0ADG0iw4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509161703.0ADG0iw4-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc-linux-ld: drivers/counter/nxp-pcf85363-stopwatch.o: in function `pcf85363_counter_write':
>> nxp-pcf85363-stopwatch.c:(.text+0x418): undefined reference to `__umoddi3'
>> sparc-linux-ld: nxp-pcf85363-stopwatch.c:(.text+0x444): undefined reference to `__umoddi3'
   sparc-linux-ld: nxp-pcf85363-stopwatch.c:(.text+0x474): undefined reference to `__umoddi3'
   sparc-linux-ld: nxp-pcf85363-stopwatch.c:(.text+0x4a4): undefined reference to `__umoddi3'
   sparc-linux-ld: nxp-pcf85363-stopwatch.c:(.text+0x4d4): undefined reference to `__umoddi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

