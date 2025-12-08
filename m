Return-Path: <linux-iio+bounces-26953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6ADCAE26D
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 21:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFBC03002E87
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 20:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C252C21C7;
	Mon,  8 Dec 2025 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIb9Bdef"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71C26056D;
	Mon,  8 Dec 2025 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765225569; cv=none; b=erVytXTPdPC3VmWPSyon16GUs80dBxTVAUkKuUew0EBCAEEiX+YyXl/+/WsSrP7QYrU5m93AHNHHJaiMWFVF+C0ymcdWLpk6XR+1qZ32/DzqROoVkVfFh11RHuobJFXRbxzAZqwAayGr3wgJY3j7RRMV9gnl38GI4V5iyuZlW9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765225569; c=relaxed/simple;
	bh=GFsDdjBH+3WBvNxJ1bjVZFeNwHF6R8/HRz2C/3TebKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YF+Ged/6zmj4HDTCVc7QDV8uteOrbzvYu4efHfHImiBNzFpunjZOiP+l/dbxhn1Kt6ZvqfXyGWqm71wMU/1BC0hB5qYk/Pb5Xzlzv/Lvon0DIl81KBAAV6ENCMF20LrL1gJc8ke0kNzaxvgwqBxXzesOTkWSioiDt8FdYnaiv8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XIb9Bdef; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765225567; x=1796761567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GFsDdjBH+3WBvNxJ1bjVZFeNwHF6R8/HRz2C/3TebKk=;
  b=XIb9Bdef3IS3FkyWL44Vval6V56fEBCnxsV8dNmxvs09dQfgOuSSOFZP
   KdUQKaS1GHHE0GwsZ5vIUAwk3haYuy4IDrMWdRAxCiXrCuvSvUILvhgXf
   UQSmtU6QN8eUPImLToaIJGdz8tI5BKqUptbPSYot2w1uL8n91UV/yNTsM
   tw694rCJmeQBWS4aBz4tPt5WRg8Pj2xae9uAKRzuXbMCGy02w17HvtOvB
   800LlOcwHFSACEAFkA5vhJ2NNfrVh3QKtMjTfDsbzhtB5UWTvi4p8+PRe
   x0MEaZAzR/KGWtYbPR8YUuuPYCCusIvZrYl2iji3y8lRv+SIngPsVBcFj
   g==;
X-CSE-ConnectionGUID: ABALJOdISy2woWhcgt2Qng==
X-CSE-MsgGUID: 5xE4Enj8TxmD8NlCvwHKmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67060510"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="67060510"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 12:26:07 -0800
X-CSE-ConnectionGUID: lvFk6MJQTaavMyj6JP1rxg==
X-CSE-MsgGUID: lpvbeSYiTLGe8GWwwhDGBw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 08 Dec 2025 12:26:04 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSho1-000000000pF-3oGw;
	Mon, 08 Dec 2025 20:26:01 +0000
Date: Tue, 9 Dec 2025 04:25:09 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, wbg@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, s32@nxp.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 3/3] counter: Add STM based counter
Message-ID: <202512090408.Ju8SNkSq-lkp@intel.com>
References: <20251208030413.3117660-4-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208030413.3117660-4-daniel.lezcano@linaro.org>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.18 next-20251208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/counters-Reorder-the-Makefile/20251208-110937
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20251208030413.3117660-4-daniel.lezcano%40linaro.org
patch subject: [PATCH v1 3/3] counter: Add STM based counter
config: loongarch-randconfig-001-20251209 (https://download.01.org/0day-ci/archive/20251209/202512090408.Ju8SNkSq-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 6ec8c4351cfc1d0627d1633b02ea787bd29c77d8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251209/202512090408.Ju8SNkSq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512090408.Ju8SNkSq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/counter/nxp-stm-cnt.c:110:2: error: call to undeclared function 'FIELD_MODIFY'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     110 |         FIELD_MODIFY(STM_CR_CPS_MASK, &reg, prescaler);
         |         ^
>> drivers/counter/nxp-stm-cnt.c:119:9: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     119 |         return FIELD_GET(STM_CR_CPS_MASK, reg);
         |                ^
   drivers/counter/nxp-stm-cnt.c:128:11: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     128 |         return !!FIELD_GET(STM_CR_TEN, reg);
         |                  ^
   3 errors generated.


vim +/FIELD_MODIFY +110 drivers/counter/nxp-stm-cnt.c

   103	
   104	static void nxp_stm_cnt_set_prescaler(struct nxp_stm_cnt *stm_cnt, u8 prescaler)
   105	{
   106		u32 reg;
   107	
   108		reg = readl(STM_CR(stm_cnt->base));
   109	
 > 110		FIELD_MODIFY(STM_CR_CPS_MASK, &reg, prescaler);
   111	
   112		writel(reg, STM_CR(stm_cnt->base));
   113	}
   114	
   115	static u8 nxp_stm_cnt_get_prescaler(struct nxp_stm_cnt *stm_cnt)
   116	{
   117		u32 reg = readl(STM_CR(stm_cnt->base));
   118	
 > 119		return FIELD_GET(STM_CR_CPS_MASK, reg);
   120	}
   121	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

