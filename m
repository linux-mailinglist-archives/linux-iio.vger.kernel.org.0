Return-Path: <linux-iio+bounces-16762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95066A5E996
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 02:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165BB3B4BDC
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 01:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CD177104;
	Thu, 13 Mar 2025 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Syi7TJYo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83B8FC0B;
	Thu, 13 Mar 2025 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741830829; cv=none; b=RxteCJM2k6ko5RbMxvgvDLWYakvPN5ovklUgMljFC8U1QJ1auHBDyti2qvsH2k4hjKEvKC0M15TRBGIjUimvetqvH2N3YwzLAVHD/Y2pOnUFqfYbesw94jHfd55Vl7JybH0sSU2spUgTkFN3Nyi6H0A+b77kx4O4bBgNXgYY+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741830829; c=relaxed/simple;
	bh=4nColgqOELuFgHL1IbFS/S4uTy/GrD5r3pOic4ag7/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWnt6Dh1cEtnoBvkeAlravubPiNhNo/H9o71DGoBb6EFDPm86/c+i0zYaT4I69dzyttdZuy0U1LC+9Hst4jDhyn3ab/aENoqBvK2JA8Rnk+3q3r6csRI80eGHFVNFkMVchuXuYXJrW/Vl8z4eaWVvcLHC+RQ/YMUYmSYYA8ZblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Syi7TJYo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741830827; x=1773366827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4nColgqOELuFgHL1IbFS/S4uTy/GrD5r3pOic4ag7/U=;
  b=Syi7TJYoaF1eJfa2LDnY38l73MqrenpAgZcNZILeFXM2MsdDmuug+O/u
   PH0MZEsPsM3TWGbhNUap9+NT6Kf4FHdec3GEmi/XRXQDW1rkWlIK6/ClD
   1dfviF/eRaDb7812tAJ3PyVHiJSGc40f4L8L4UhXZPLUjB5+jPvvT3lMR
   hpvWQTHE+cj5nvHwcWw84AIvVXh5ku+QfS+yj5pJ49xLeOsNBKwsARjL1
   Mt9XMZ3i7CynrQphwJqlF2EpkTn81MQ3dnCgNhm6R6JCr02pTvTf9xfFp
   kynbLqQ2jWPEdqCcqFnGW3ka2ywxON7gsxS57LO4oNJs52BNpolC6sX1Z
   Q==;
X-CSE-ConnectionGUID: svluWkbnRj69bLQf9k0pvw==
X-CSE-MsgGUID: 9qi9Ha2ARkWnMMNuSsw+Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="60331361"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="60331361"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 18:53:47 -0700
X-CSE-ConnectionGUID: veBJ0OhYR4iCo23Ckye1gQ==
X-CSE-MsgGUID: GFEQRz2SQi6MtH5yyB4OYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="124971853"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 12 Mar 2025 18:53:45 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsXlL-00092i-29;
	Thu, 13 Mar 2025 01:53:34 +0000
Date: Thu, 13 Mar 2025 09:53:08 +0800
From: kernel test robot <lkp@intel.com>
To: Suraj Patil <surajpatil522@gmail.com>, jic23@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Suraj Patil <surajpatil522@gmail.com>
Subject: Re: [PATCH] iio: industrialio-trigger: Fix typos in comments
Message-ID: <202503130901.12r9Jl8B-lkp@intel.com>
References: <20250311155927.467523-1-surajpatil522@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311155927.467523-1-surajpatil522@gmail.com>

Hi Suraj,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.14-rc6 next-20250312]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Suraj-Patil/iio-industrialio-trigger-Fix-typos-in-comments/20250312-000420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250311155927.467523-1-surajpatil522%40gmail.com
patch subject: [PATCH] iio: industrialio-trigger: Fix typos in comments
config: hexagon-randconfig-002-20250313 (https://download.01.org/0day-ci/archive/20250313/202503130901.12r9Jl8B-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project e15545cad8297ec7555f26e5ae74a9f0511203e7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503130901.12r9Jl8B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503130901.12r9Jl8B-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/industrialio-trigger.c:165:13: error: no member named 're' in 'struct iio_trigger_ops'
     165 |         trig->ops->re-enable(trig);
         |         ~~~~~~~~~  ^
>> drivers/iio/industrialio-trigger.c:165:16: error: call to undeclared function 'enable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     165 |         trig->ops->re-enable(trig);
         |                       ^
   drivers/iio/industrialio-trigger.c:185:17: error: no member named 're' in 'struct iio_trigger_ops'
     185 |             trig->ops->re-enable)
         |             ~~~~~~~~~  ^
>> drivers/iio/industrialio-trigger.c:185:20: error: use of undeclared identifier 'enable'
     185 |             trig->ops->re-enable)
         |                           ^
   drivers/iio/industrialio-trigger.c:246:17: error: no member named 're' in 'struct iio_trigger_ops'
     246 |             trig->ops->re-enable)
         |             ~~~~~~~~~  ^
   drivers/iio/industrialio-trigger.c:246:20: error: use of undeclared identifier 'enable'
     246 |             trig->ops->re-enable)
         |                           ^
   drivers/iio/industrialio-trigger.c:247:14: error: no member named 're' in 'struct iio_trigger_ops'
     247 |                 trig->ops->re-enable(trig);
         |                 ~~~~~~~~~  ^
   drivers/iio/industrialio-trigger.c:247:17: error: call to undeclared function 'enable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     247 |                 trig->ops->re-enable(trig);
         |                               ^
   8 errors generated.


vim +165 drivers/iio/industrialio-trigger.c

   155	
   156	static void iio_reenable_work_fn(struct work_struct *work)
   157	{
   158		struct iio_trigger *trig = container_of(work, struct iio_trigger,
   159							reenable_work);
   160	
   161		/*
   162		 * This 'might' occur after the trigger state is set to disabled -
   163		 * in that case the driver should skip reenabling.
   164		 */
 > 165		trig->ops->re-enable(trig);
   166	}
   167	
   168	/*
   169	 * In general, re-enable callbacks may need to sleep and this path is
   170	 * not performance sensitive, so just queue up a work item
   171	 * to reneable the trigger for us.
   172	 *
   173	 * Races that can cause this.
   174	 * 1) A handler occurs entirely in interrupt context so the counter
   175	 *    the final decrement is still in this interrupt.
   176	 * 2) The trigger has been removed, but one last interrupt gets through.
   177	 *
   178	 * For (1) we must call re-enable, but not in atomic context.
   179	 * For (2) it should be safe to call reenanble, if drivers never blindly
   180	 * re-enable after state is off.
   181	 */
   182	static void iio_trigger_notify_done_atomic(struct iio_trigger *trig)
   183	{
   184		if (atomic_dec_and_test(&trig->use_count) && trig->ops &&
 > 185		    trig->ops->re-enable)
   186			schedule_work(&trig->reenable_work);
   187	}
   188	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

