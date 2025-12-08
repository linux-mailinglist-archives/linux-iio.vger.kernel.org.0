Return-Path: <linux-iio+bounces-26958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42378CAE39E
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 22:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48C5730214FA
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 21:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA3F2DC344;
	Mon,  8 Dec 2025 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEwEqMgb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D21724A047;
	Mon,  8 Dec 2025 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765229413; cv=none; b=XEiy5rroyEX3HpU0nCaSoIiUIkNKTh5hJS8Fo/h78RKtBIwhQTntRpoEqnaLtFLR7jgoAznniqw5KqgCCtpDY2fu/wKrBOQm5qtcKRbr9O2E+m+FWZ7d1BvGqW8lCK0uIrp5lLBJ3Bcl0WQgcdB4NoIbV1QTQdJVN5f+C4J2bxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765229413; c=relaxed/simple;
	bh=HrjzLvC+rPXSF5CT4geqsmM15ozAG2X6RjLKAQmniig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8IkXprr3KgUJv5PLpe2yfHuJvPwK/c9GEMsUeAE+cXYixQZlWtkG354IzUOpP09q5QZT+qxjQVv0vNG6OyrmB9AUtLp6TxRNeco0eNlxbwvmZ7dhE3FSyuoaEkdHo9yEE1c15OMPo34tCmjcncYMTDQMd/Gxbn+EzOwWnzMSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEwEqMgb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765229411; x=1796765411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HrjzLvC+rPXSF5CT4geqsmM15ozAG2X6RjLKAQmniig=;
  b=hEwEqMgbv9ziqkK095voeC3L7kVx5v1uPEDSMuDsh2cwopP+I/MUjiUp
   HRwTenfkyLmM2RE9K39SRADBAcMZuT95AjN+TcpMkYeDO12SZtrZIMS4I
   9bfPIK2ZX7Ae6k9IHR5CtLzQ4bOknHvYlBFLrk6545kR7hGvZ7b3jJ1cp
   rSQpf1d1WWu5OGHZYaRv/7Uw+xKuDddwecXcHIZbqXlhW6rn3/18WDOP5
   uc87NMZBli2EVsMgVW31Su7c3FC94KJerFUjhGnoip+x67LdX4E5MTQO2
   4AS9fA5/k0v4l3yoW+4iTcykXh+IyLvN+Nm0yMyr+26kTrz+ED/1h8F1T
   g==;
X-CSE-ConnectionGUID: Q/oBALeDRuyH36LZ7ROSTQ==
X-CSE-MsgGUID: yaf8IBk9SIyitfz6FemBqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="71025140"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="71025140"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 13:30:11 -0800
X-CSE-ConnectionGUID: t/R10licQVWIqhAw8hUzFA==
X-CSE-MsgGUID: B4qNeXyzSemlYnL8YwXv+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="196061363"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 08 Dec 2025 13:30:08 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSio1-000000000sL-2hW5;
	Mon, 08 Dec 2025 21:30:05 +0000
Date: Tue, 9 Dec 2025 05:29:24 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, wbg@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, s32@nxp.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 3/3] counter: Add STM based counter
Message-ID: <202512090533.JQEqVYW8-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.18 next-20251208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/counters-Reorder-the-Makefile/20251208-110937
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20251208030413.3117660-4-daniel.lezcano%40linaro.org
patch subject: [PATCH v1 3/3] counter: Add STM based counter
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20251209/202512090533.JQEqVYW8-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251209/202512090533.JQEqVYW8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512090533.JQEqVYW8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/counter/nxp-stm-cnt.c: In function 'nxp_stm_cnt_set_prescaler':
   drivers/counter/nxp-stm-cnt.c:110:9: error: implicit declaration of function 'FIELD_MODIFY' [-Wimplicit-function-declaration]
     110 |         FIELD_MODIFY(STM_CR_CPS_MASK, &reg, prescaler);
         |         ^~~~~~~~~~~~
   drivers/counter/nxp-stm-cnt.c: In function 'nxp_stm_cnt_get_prescaler':
   drivers/counter/nxp-stm-cnt.c:119:16: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     119 |         return FIELD_GET(STM_CR_CPS_MASK, reg);
         |                ^~~~~~~~~
   drivers/counter/nxp-stm-cnt.c: At top level:
>> drivers/counter/nxp-stm-cnt.c:303:32: warning: 'nxp_stm_cnt_pm_ops' defined but not used [-Wunused-const-variable=]
     303 | static const struct dev_pm_ops nxp_stm_cnt_pm_ops = {
         |                                ^~~~~~~~~~~~~~~~~~


vim +/nxp_stm_cnt_pm_ops +303 drivers/counter/nxp-stm-cnt.c

   302	
 > 303	static const struct dev_pm_ops nxp_stm_cnt_pm_ops = {
   304		.suspend = nxp_stm_cnt_suspend,
   305		.resume  = nxp_stm_cnt_resume,
   306	};
   307	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

