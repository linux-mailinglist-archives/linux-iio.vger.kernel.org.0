Return-Path: <linux-iio+bounces-8037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F56940579
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 04:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAA21C20ED7
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 02:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173E31CD25;
	Tue, 30 Jul 2024 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKgPpC/L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1A33E8;
	Tue, 30 Jul 2024 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722307641; cv=none; b=EYQnXycGytFnmn2WGfUx/i5RhzMBVFSvh35e+86HyKRjca6VpSxgdFKx2wUunFtrYPEgHmBXLmVWD8/IlrA4t9qto0CgHRauJ2GtjIeJ4IWZMS9B9d20sZN4YUrKhcTVKZHbLvMf3DLe8J9Yr+wYjETuKslt9Kn9Fg2mgiMs8CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722307641; c=relaxed/simple;
	bh=Eb5ZLrQiJPsicVZOt5f75490c6Zl9TN1ZXNLj/IKqvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjEwuPtFYOGlh2MDeOC7R52ync+RUuxMOE9LnSGKTD2gIf2ZAQDNbvoof8DwwCdRxzPB+PFwvEAjFRTY+CpXByQFQjGRkn4XMcODVpK85w0ljBy92ud4ANEytoGkwgAruKRE9HGDQv5u8SP49ClbL0efae2R+rLN/fVuK82G3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKgPpC/L; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722307641; x=1753843641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Eb5ZLrQiJPsicVZOt5f75490c6Zl9TN1ZXNLj/IKqvo=;
  b=RKgPpC/LPQhmkoMCH52Kb07OA9a+J6tVrYizcL/9dvpNJi8mky+8rPE6
   Zyo8wxaH9OOEduvF1zLxg21i+yR1cSHM2ePEHKQHKEzlPhiS/ESiVreu8
   8TfLX5S9FsfexRPRSM3+hupUEX6EGtiXXAQpaagg1fsG077CsU7+8cgRU
   1WhL7ArkeQHlEgJw+hMc/R++D9RKv+RdloLhMgIfZ9nOij9quO5W3X6Wz
   uubQan6tN8/qZYMi8CP4EmVRof/+zmSWd268Col7asOSdyCuwRCMCIisD
   P9GdzCRNY6hcfRz1mh/kqDkjTm/kFge3eihnvSSHbO8gcQ8YqjJbxLzQJ
   g==;
X-CSE-ConnectionGUID: FebRrTVlQLa3iehytdtuug==
X-CSE-MsgGUID: 2+zaH20fQEqMv2TgEHU2NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="23891456"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="23891456"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 19:47:20 -0700
X-CSE-ConnectionGUID: 1rZfgZ2NRxWuAhJ5p8frCA==
X-CSE-MsgGUID: epZR2EaMSfeMyhD24lIyzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="54431576"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 29 Jul 2024 19:47:18 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYctP-000sOS-1z;
	Tue, 30 Jul 2024 02:47:15 +0000
Date: Tue, 30 Jul 2024 10:46:27 +0800
From: kernel test robot <lkp@intel.com>
To: Abhash Jha <abhashkumarjha123@gmail.com>, linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, anshulusr@gmail.com, jic23@kernel.org,
	lars@metafoo.de, linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: Re: [PATCH v3 1/3] iio: light: ltr390: Add configurable gain and
 resolution
Message-ID: <202407301035.KehnJ97o-lkp@intel.com>
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
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240730/202407301035.KehnJ97o-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240730/202407301035.KehnJ97o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407301035.KehnJ97o-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/light/ltr390.c: In function 'ltr390_set_int_time':
>> drivers/iio/light/ltr390.c:42:41: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
      42 | #define LTR390_ALS_UVS_INT_TIME(x)      FIELD_PREP(LTR390_ALS_UVS_INT_TIME_MASK, (x))
         |                                         ^~~~~~~~~~
   drivers/iio/light/ltr390.c:171:41: note: in expansion of macro 'LTR390_ALS_UVS_INT_TIME'
     171 |                                         LTR390_ALS_UVS_INT_TIME(idx));
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~


vim +/FIELD_PREP +42 drivers/iio/light/ltr390.c

    38	
    39	#define LTR390_PART_NUMBER_ID		0xb
    40	#define LTR390_ALS_UVS_GAIN_MASK	0x07
    41	#define LTR390_ALS_UVS_INT_TIME_MASK	0x70
  > 42	#define LTR390_ALS_UVS_INT_TIME(x)	FIELD_PREP(LTR390_ALS_UVS_INT_TIME_MASK, (x))
    43	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

