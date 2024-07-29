Return-Path: <linux-iio+bounces-8036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C5C9401CD
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 01:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFF41F22651
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 23:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8622118F2FE;
	Mon, 29 Jul 2024 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbbRRWLH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B8018D4A4;
	Mon, 29 Jul 2024 23:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722296713; cv=none; b=kTkQSrs1WryvqV0+b1EPFPif4HAsKpmF7P/b8XaVuXO82QqDfNgHMuNwB7YXm6TR2aIid7EXOpzbgaYXwynMfqUtXCdb+fs68dfqNp5YkPthKOUIkAl+w+ACUvqv0K1sPi5w8z2L7tJaFMzS1iyuYvDJ/cb1ncw9v4Mm+rEsCWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722296713; c=relaxed/simple;
	bh=AuRppnQLBljgve0I1NuFGDOTtuOHQAs1Bt22RhFk3jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYVFyr384KYmXy1g7EJmu+f3oM7XDS0PmXUM64kDc164bOTGr7Jo6DIta9MSGkn6b8Q/y+RJI6TXY6PJidSy9A8H2ZVxIFGXsF1Y609GE9FnXFGnOzDfmCMSGlOeuCirMsBI9xJeEpM6ewXymsQuePOkSaCdrz0pm5ezHfWcma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EbbRRWLH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722296711; x=1753832711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AuRppnQLBljgve0I1NuFGDOTtuOHQAs1Bt22RhFk3jI=;
  b=EbbRRWLHgC+R9aqvaJ/zcVqBP7qGjfySSjgRZBpSTNwdHX/QMunjLlJS
   94Mj/wLJDBvOPW1Wn9zXZl+2rldlyP9sTI6vpK/54yzMbc7YYWURoDVQc
   HpNG8TmuQ7Nm413d/ul5f6UkNwPLmTurrK8u2Q+/sm7KEV6U1Ez1M1c0i
   z6S+sqpW51EjAfMR4zP+nbovyRTfNCETnhXoI0GRsx8zVDF9uT0htd6pf
   KDlNdT4oVdCCQyLDmSXkeb3+lLNMC8CEL1/q0IEBmHS6fkbutjV0oZsQ6
   23RKyCOgMfuse066lW3W6BtaXf3h4HJ3fwg8azF9TQj+MDp5xs/tvcZn2
   Q==;
X-CSE-ConnectionGUID: tIpiYyCFSoWrqJAMs5VyBw==
X-CSE-MsgGUID: K+5IKzwDQBisspiX7gb5tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="30673487"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="30673487"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 16:45:10 -0700
X-CSE-ConnectionGUID: g3ZSK36QS/6U0ax5POXPAA==
X-CSE-MsgGUID: SUhcYoZqSMGkWC1Q8OTqqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="85085308"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 29 Jul 2024 16:45:09 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYa38-000sC5-2w;
	Mon, 29 Jul 2024 23:45:06 +0000
Date: Tue, 30 Jul 2024 07:45:02 +0800
From: kernel test robot <lkp@intel.com>
To: Abhash Jha <abhashkumarjha123@gmail.com>, linux-iio@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	anshulusr@gmail.com, jic23@kernel.org, lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: Re: [PATCH v3 1/3] iio: light: ltr390: Add configurable gain and
 resolution
Message-ID: <202407300717.9WTaBkEv-lkp@intel.com>
References: <20240729115056.355466-2-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729115056.355466-2-abhashkumarjha123@gmail.com>

Hi Abhash,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.11-rc1 next-20240729]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhash-Jha/iio-light-ltr390-Add-configurable-gain-and-resolution/20240729-222433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240729115056.355466-2-abhashkumarjha123%40gmail.com
patch subject: [PATCH v3 1/3] iio: light: ltr390: Add configurable gain and resolution
config: i386-buildonly-randconfig-003-20240730 (https://download.01.org/0day-ci/archive/20240730/202407300717.9WTaBkEv-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240730/202407300717.9WTaBkEv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407300717.9WTaBkEv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/light/ltr390.c:171:6: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     171 |                                         LTR390_ALS_UVS_INT_TIME(idx));
         |                                         ^
   drivers/iio/light/ltr390.c:42:36: note: expanded from macro 'LTR390_ALS_UVS_INT_TIME'
      42 | #define LTR390_ALS_UVS_INT_TIME(x)      FIELD_PREP(LTR390_ALS_UVS_INT_TIME_MASK, (x))
         |                                         ^
   1 error generated.


vim +/FIELD_PREP +171 drivers/iio/light/ltr390.c

   158	
   159	static int ltr390_set_int_time(struct ltr390_data *data, int val)
   160	{
   161		int ret, idx;
   162	
   163		for (idx = 0; idx < ARRAY_SIZE(ltr390_int_time_map_us); idx++) {
   164			if (ltr390_int_time_map_us[idx] != val)
   165				continue;
   166	
   167			guard(mutex)(&data->lock);
   168			ret = regmap_update_bits(data->regmap,
   169						LTR390_ALS_UVS_MEAS_RATE,
   170						LTR390_ALS_UVS_INT_TIME_MASK,
 > 171						LTR390_ALS_UVS_INT_TIME(idx));
   172			if (ret)
   173				return ret;
   174	
   175			data->int_time_us = ltr390_int_time_map_us[idx];
   176			return 0;
   177		}
   178	
   179		return -EINVAL;
   180	}
   181	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

