Return-Path: <linux-iio+bounces-12340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0009D0221
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 06:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C823B252FD
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 05:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B641D52B;
	Sun, 17 Nov 2024 05:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8G/VTsB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F731DDE9;
	Sun, 17 Nov 2024 05:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731821883; cv=none; b=pL4yc/EjhqodK0esSIL2ZlLzaOJk0ZZftxN7qmv7vXt8GaL4FlwnyXBH6IUOVS/eNpw1OTYemxJ0fUzXh7hhupXviBKwULWGb4WWxAfbKSZvj7ckRbZAEeAFrvOUJ8XUVbWS9fP5scD4VpGcMEnNqwRW4WihclKUVKJSbh4w+Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731821883; c=relaxed/simple;
	bh=8LMoSl2RyEDo9ou0rCvdh+RywoMHpQOH3If+sT69ZaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2Ll+siOxWGGs4l2D50ANI4qmAHs79Sh8ioxrLnMyckcpDAf2RAIHiUVy/m/odjb3L0rLxljl6cxZgyQbuezG0vIvVp+lU9VkCgyyaIN7RDAxxMYPlIR1ksoItQKcFBlbccJyoQ6dBPm61fGFsk1R/mqNJS5cYrWEOZzpLcBbn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8G/VTsB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731821882; x=1763357882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8LMoSl2RyEDo9ou0rCvdh+RywoMHpQOH3If+sT69ZaY=;
  b=c8G/VTsBpS7ANPsxkF7s719GPj/BEtw2ucIBSuqtYFbTspvQM0OtFDwU
   Pyk1XC3qjy2OBv0aAssjq7Q21TSsKcHWyaNDzYJ4ftK4JSRo5fNtj8Qst
   1dULm1Mi4eomNgrKi1UM7QcHfgRlI3mSGSnq7Zxb1I4G4ov/4vQH9ZPHr
   Wxe3u0rIhohP3we1EvaXtILAUIZxaPY9ZZh6nplvfGzizSGf2Zzk5FTZ4
   4kKOfsd7HZ9AZjTOzowZ28N1cETBl9GRvsu0Sv1wvBmLOLLoyNTnSyWoq
   bcJnQKAp3U0kK5k0yyP8oSY6yCw48ZhSWHui7mK1e2lhf+GuVqxFS2UoU
   g==;
X-CSE-ConnectionGUID: lkbuK66mThyhtu6qQWRdlw==
X-CSE-MsgGUID: JJeAnhTsTWWUSE9NLoxO+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="42424048"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="42424048"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 21:38:01 -0800
X-CSE-ConnectionGUID: MCOlMmGLTKinxmdGGNLcug==
X-CSE-MsgGUID: paix2ESYQdGQd1QEFhN6Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="93950823"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Nov 2024 21:37:58 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCXyu-0001ZR-0m;
	Sun, 17 Nov 2024 05:37:56 +0000
Date: Sun, 17 Nov 2024 13:37:41 +0800
From: kernel test robot <lkp@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH 06/22] iio: accel: adxl345: add function to switch
 measuring
Message-ID: <202411171333.4V4FcJFa-lkp@intel.com>
References: <20241114231002.98595-7-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114231002.98595-7-l.rubusch@gmail.com>

Hi Lothar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.12-rc7 next-20241115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lothar-Rubusch/iio-accel-adxl345-fix-comment-on-probe/20241115-190245
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241114231002.98595-7-l.rubusch%40gmail.com
patch subject: [PATCH 06/22] iio: accel: adxl345: add function to switch measuring
config: arm-randconfig-002-20241117 (https://download.01.org/0day-ci/archive/20241117/202411171333.4V4FcJFa-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171333.4V4FcJFa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171333.4V4FcJFa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/accel/adxl345_core.c:142: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * For lowest power operation, standby mode can be used. In standby mode,


vim +142 drivers/iio/accel/adxl345_core.c

   140	
   141	/**
 > 142	 * For lowest power operation, standby mode can be used. In standby mode,
   143	 * current consumption is supposed to be reduced to 0.1uA (typical). In this
   144	 * mode no measurements are made. Placing the device into standby mode
   145	 * preserves the contents of FIFO.
   146	 *
   147	 * Unloading the driver puts the device in standby mode (measuring off).
   148	 *
   149	 * @st: The device data.
   150	 * @en: Enable measurements, else standby mode.
   151	 */
   152	static int adxl345_set_measure_en(struct adxl34x_state *st, bool en)
   153	{
   154		unsigned int val = 0;
   155		int ret;
   156	
   157		val = (en) ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
   158		ret = regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
   159		if (ret)
   160			return -EINVAL;
   161	
   162		return 0;
   163	}
   164	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

