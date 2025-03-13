Return-Path: <linux-iio+bounces-16749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CCBA5E91C
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 01:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5185C7A4239
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 00:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36511C695;
	Thu, 13 Mar 2025 00:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgKpskD5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E05D101E6;
	Thu, 13 Mar 2025 00:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741827142; cv=none; b=cOBnz5iooO5B47bwuyI6GemUXRB0llpAxlUPv2DN67cd3Mzdxu6aasSpsNKnawMfj/PiHol/n1yItFksEuZEX176PK6aDwz8JLwdOaySanBWpt2t372hifEYn4u1PUqmf31vcs4DrIrSIiALvwfLaRuiXecFrTXpBOvWg1rJS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741827142; c=relaxed/simple;
	bh=WmgE3mwmQdlO+tJxWDxYF+fgylLCl5zX1PvcrMW/G+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WA5UH6tPHmsvJwJliMf9v5ukxLek9b3eCxeJ1dkXnZANNyPY/YtTRAPjFo8+b5IXICEL+1HQlEAAb3YFNtndcAdZm1mCdG3v260vkC+aNR7GFLkM8XlHol+3P2oqdSa7bnd2np0r7VWbaND+prYPAPeiZCu8FxqBKrFzUzJF0uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgKpskD5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741827141; x=1773363141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WmgE3mwmQdlO+tJxWDxYF+fgylLCl5zX1PvcrMW/G+M=;
  b=DgKpskD5gtxsa4CSUlB8g50CToZF+5N9xC+q+9LyiDlEQyk/wd4Gs+wh
   VSxg/lCGp2qfcVW2yAu5bpQu44GjIkHA16qOKUCFZtSdyE4JBm3PBzyYM
   OMDQbE0SiyzopdTQ1wmkE8sfTOshDiNwZvqA4NxIv/IqtilJsCp2KZXOz
   r3Gfc2PS2JF4PmkXpAh2s5DQIIcOZpNDVTB53KbEJ7a4mAjjwda9Z3KH3
   o4f/fNSNHm+d6myr0W8XCCzMmCH2nnHxxt+ikmvKmAeQragQBQoKmR9cQ
   vobDusf1GKDIiBgsLrlmvxcO9I4EEKizjgF3FuNkhovVWPl4E2+nXCreN
   Q==;
X-CSE-ConnectionGUID: PuhME4s9Q4O5LdSRw4TWEw==
X-CSE-MsgGUID: ijN9pUyTSlWR5polzQSlcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="30517887"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="30517887"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 17:52:18 -0700
X-CSE-ConnectionGUID: c94EXzykSymV5SW8g6m6hA==
X-CSE-MsgGUID: AizRmDsHTleapSphFvbl5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="124963132"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 12 Mar 2025 17:52:16 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsWo2-00091I-2a;
	Thu, 13 Mar 2025 00:52:14 +0000
Date: Thu, 13 Mar 2025 08:51:18 +0800
From: kernel test robot <lkp@intel.com>
To: Suraj Patil <surajpatil522@gmail.com>, jic23@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Suraj Patil <surajpatil522@gmail.com>
Subject: Re: [PATCH] iio: industrialio-trigger: Fix typos in comments
Message-ID: <202503130826.WiaC6K1E-lkp@intel.com>
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
config: csky-randconfig-002-20250313 (https://download.01.org/0day-ci/archive/20250313/202503130826.WiaC6K1E-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503130826.WiaC6K1E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503130826.WiaC6K1E-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/industrialio-trigger.c: In function 'iio_reenable_work_fn':
>> drivers/iio/industrialio-trigger.c:165:18: error: 'const struct iio_trigger_ops' has no member named 're'
     165 |         trig->ops->re-enable(trig);
         |                  ^~
>> drivers/iio/industrialio-trigger.c:165:23: error: implicit declaration of function 'enable'; did you mean 'enable_nmi'? [-Wimplicit-function-declaration]
     165 |         trig->ops->re-enable(trig);
         |                       ^~~~~~
         |                       enable_nmi
   drivers/iio/industrialio-trigger.c: In function 'iio_trigger_notify_done_atomic':
   drivers/iio/industrialio-trigger.c:185:22: error: 'const struct iio_trigger_ops' has no member named 're'
     185 |             trig->ops->re-enable)
         |                      ^~
>> drivers/iio/industrialio-trigger.c:185:27: error: 'enable' undeclared (first use in this function)
     185 |             trig->ops->re-enable)
         |                           ^~~~~~
   drivers/iio/industrialio-trigger.c:185:27: note: each undeclared identifier is reported only once for each function it appears in
   drivers/iio/industrialio-trigger.c: In function 'iio_trigger_notify_done':
   drivers/iio/industrialio-trigger.c:246:22: error: 'const struct iio_trigger_ops' has no member named 're'
     246 |             trig->ops->re-enable)
         |                      ^~
   drivers/iio/industrialio-trigger.c:246:27: error: 'enable' undeclared (first use in this function)
     246 |             trig->ops->re-enable)
         |                           ^~~~~~
   drivers/iio/industrialio-trigger.c:247:26: error: 'const struct iio_trigger_ops' has no member named 're'
     247 |                 trig->ops->re-enable(trig);
         |                          ^~


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

