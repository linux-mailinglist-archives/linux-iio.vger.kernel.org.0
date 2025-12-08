Return-Path: <linux-iio+bounces-26959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B55CAE6C3
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 00:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C40C3300D035
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 23:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE5F18D65C;
	Mon,  8 Dec 2025 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D55jLRHs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAA414F9D6;
	Mon,  8 Dec 2025 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765237523; cv=none; b=B50gKRolb3u2juRlHmGwVBoIka6bd4YnQnpIFT+yohlM+KEWQGAD8X8g9lHJXEKDLfNP5Kkv0L3Zy6giYpJp7ikARk/wgw2wU0oSVv6IZ7qsd/2IuL1lGXwDQT/CF3OeawWCZwOgqdc59jMWAP7NFA+a1FncILiqCcusj7gdxe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765237523; c=relaxed/simple;
	bh=bsJnXLBqpkHlxg3nJh0VQf4CSX1YHmXd2sgXfZ1QDBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKi+k9jCKttaLCZO5auZLSgC7mSEl0h0oRbA2F7hUUp3tv3YYS9WbWr2FWLjgm4AaZAB3xo9lqslJRanLwHe27ELQMgoYmjJ3m4DXN35cQwgYRr1Ud/c8fEEYtb10LLYstshDF48v2/lOc5B+HBQCMqnnkHnZBlz9iHTxgUMb8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D55jLRHs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765237522; x=1796773522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bsJnXLBqpkHlxg3nJh0VQf4CSX1YHmXd2sgXfZ1QDBA=;
  b=D55jLRHs8+hniZU6wBWgEpe8dB83MwDIoUIwYjdUoTi6dybriaHHHErN
   geXJqJQfy6ZI0txAFoaZ894asHE9N1NLmbJIkjxxH/yMwWSbCyeJ8+wA/
   1dDa5tqasJDEr2GG7w59Is6Bm9k2VY2GzS2oSKg9k4x/aQAF7j6LZ3uj3
   mmgLrdhf5BYxgdLV5pAu/FqXRYuM/+qlWYQwiWolPcfibvopfUej47XAj
   HeRbZ54WZ/ELxtF8x8C1EoqAlTl/Rd3y1fc0mgz3U1Mw46MYSji+rzZFo
   tm/01O5OBpT/P7IkidaVLFjNhP/rAXd9srNNNbed+88UhV+uFJ0scBn2z
   A==;
X-CSE-ConnectionGUID: hdKKXuQsQumrMvwEK+KCmA==
X-CSE-MsgGUID: PmVMX3agQxu6r9ZFhIL0ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="71034160"
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="71034160"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 15:45:21 -0800
X-CSE-ConnectionGUID: l/pU+BjHTLG7/Nstv/Ja0g==
X-CSE-MsgGUID: oCwZPB1/RD+SIn7cl858aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="219415352"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Dec 2025 15:45:18 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSkuq-000000000zF-0YjF;
	Mon, 08 Dec 2025 23:45:16 +0000
Date: Tue, 9 Dec 2025 07:45:14 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, wbg@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, s32@nxp.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 3/3] counter: Add STM based counter
Message-ID: <202512090758.GOPbQ2xm-lkp@intel.com>
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
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20251209/202512090758.GOPbQ2xm-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251209/202512090758.GOPbQ2xm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512090758.GOPbQ2xm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/counter/nxp-stm-cnt.c:303:32: warning: unused variable 'nxp_stm_cnt_pm_ops' [-Wunused-const-variable]
   static const struct dev_pm_ops nxp_stm_cnt_pm_ops = {
                                  ^
   1 warning generated.


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

