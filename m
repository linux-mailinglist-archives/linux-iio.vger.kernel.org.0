Return-Path: <linux-iio+bounces-11922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B1E9BD0F3
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 16:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27A91F235C5
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 15:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4386738DD6;
	Tue,  5 Nov 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZ0Es/nR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5571D13E04B;
	Tue,  5 Nov 2024 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821659; cv=none; b=F8d76bRwerRFe96pYxHm9aoeXewcEvBUISajRKOIeFo8J51hLIJ8r3xDaGHp0UMGDnFM27hmIaoI/MC0nyQ4qgmw9TCyv5GGgf/uNHjcDbeTUiWZwsY45/43gagshDsUAjI5oyAFzvSmSe0nLAl8pP/v493/1IG9gKoBcJxyBEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821659; c=relaxed/simple;
	bh=RK+a6A7OJhSliI+dc93vxIpqpxPUysrYNTsq6eGPkbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/+7SoJ/gA15565/y0TtKzFhKaB2hIcoSyxTckCgK7r2qrR9Z30HWTy9ZOD2B5wHXnlbR336oR0djnYXkfZTSMRmaNmzcvzOKDDQSLJYc3HTvDl3CmwMILIKKgA+003iJXLBzZkleoV0UgMnlY0BKFDsIFw4Mi6BrLY6/e2Qu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZ0Es/nR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730821657; x=1762357657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RK+a6A7OJhSliI+dc93vxIpqpxPUysrYNTsq6eGPkbE=;
  b=UZ0Es/nR37Roqu4OfEHUvnptkmZkgxndVPZZ39MmmQfdVZ8m3Z99v1Mb
   qmXW+CmGbhakdIqIcmD3yMeLtTar3+sruokBo5Fw38SjmsG4ayJzPGivf
   MGjSwviJgeDlOpyH+z/5lSCDtx/1Qb+HdVChoiChZ3MzPtljCB/Kx1alu
   vFA/VNAfotkqDIr0I9MyPuBg/VkgLvLc59DkJBS+Pnn0/yQvYc/J38KF9
   HXQLcD7tZaLh3WBQZUpWtizjwWPgJAZIxW4HvQeDnShUeHIT3W4eAi278
   DuoRJyg8fhGaqVtPsomGdHYqsOncWexM/4OLnhbsg5q3PqUSyprYQPmxC
   g==;
X-CSE-ConnectionGUID: 5rOVg0r3RzC+5fKQxtadVA==
X-CSE-MsgGUID: e98PEvjLRfCKGqyLxWsKqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48038413"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48038413"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 07:47:37 -0800
X-CSE-ConnectionGUID: 1dCb6F6AQSqGZZ/Mf7P6HQ==
X-CSE-MsgGUID: U1Q2YT6kQbShsx2zs9E8vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84460427"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Nov 2024 07:47:34 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8LmG-000mBr-12;
	Tue, 05 Nov 2024 15:47:32 +0000
Date: Tue, 5 Nov 2024 23:47:31 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] iio: adc: vf610_adc: limit i.MX6SX's channel number
 to 4
Message-ID: <202411052345.gyJaM3h4-lkp@intel.com>
References: <20241104231200.2745342-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104231200.2745342-2-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on next-20241105]
[cannot apply to linus/master v6.12-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/iio-adc-vf610_adc-limit-i-MX6SX-s-channel-number-to-4/20241105-071339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241104231200.2745342-2-Frank.Li%40nxp.com
patch subject: [PATCH 2/2] iio: adc: vf610_adc: limit i.MX6SX's channel number to 4
config: x86_64-buildonly-randconfig-005-20241105 (https://download.01.org/0day-ci/archive/20241105/202411052345.gyJaM3h4-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241105/202411052345.gyJaM3h4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411052345.gyJaM3h4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/adc/vf610_adc.c:20:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/adc/vf610_adc.c:874:28: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'const void *' [-Wvoid-pointer-to-int-cast]
     874 |         indio_dev->num_channels = (u32)device_get_match_data(dev);
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +874 drivers/iio/adc/vf610_adc.c

   817	
   818	static int vf610_adc_probe(struct platform_device *pdev)
   819	{
   820		struct device *dev = &pdev->dev;
   821		struct vf610_adc *info;
   822		struct iio_dev *indio_dev;
   823		int irq;
   824		int ret;
   825	
   826		indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct vf610_adc));
   827		if (!indio_dev)
   828			return dev_err_probe(&pdev->dev, -ENOMEM, "Failed allocating iio device\n");
   829	
   830		info = iio_priv(indio_dev);
   831		info->dev = &pdev->dev;
   832	
   833		info->regs = devm_platform_ioremap_resource(pdev, 0);
   834		if (IS_ERR(info->regs))
   835			return PTR_ERR(info->regs);
   836	
   837		irq = platform_get_irq(pdev, 0);
   838		if (irq < 0)
   839			return irq;
   840	
   841		ret = devm_request_irq(info->dev, irq,
   842					vf610_adc_isr, 0,
   843					dev_name(&pdev->dev), indio_dev);
   844		if (ret < 0)
   845			dev_err_probe(&pdev->dev, ret, "failed requesting irq, irq = %d\n", irq);
   846	
   847		info->clk = devm_clk_get_enabled(&pdev->dev, "adc");
   848		if (IS_ERR(info->clk))
   849			return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
   850					     "failed getting clock, err = %ld\n",
   851					     PTR_ERR(info->clk));
   852	
   853		info->vref = devm_regulator_get(&pdev->dev, "vref");
   854		if (IS_ERR(info->vref))
   855			return PTR_ERR(info->vref);
   856	
   857		info->vref_uv = devm_regulator_get_enable_read_voltage(&pdev->dev, "vref");
   858		if (info->vref_uv < 0)
   859			return info->vref_uv;
   860	
   861		device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
   862	
   863		info->adc_feature.default_sample_time = DEFAULT_SAMPLE_TIME;
   864		device_property_read_u32(dev, "min-sample-time", &info->adc_feature.default_sample_time);
   865	
   866		platform_set_drvdata(pdev, indio_dev);
   867	
   868		init_completion(&info->completion);
   869	
   870		indio_dev->name = dev_name(&pdev->dev);
   871		indio_dev->info = &vf610_adc_iio_info;
   872		indio_dev->modes = INDIO_DIRECT_MODE;
   873		indio_dev->channels = vf610_adc_iio_channels;
 > 874		indio_dev->num_channels = (u32)device_get_match_data(dev);
   875	
   876		vf610_adc_cfg_init(info);
   877		vf610_adc_hw_init(info);
   878	
   879		ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev, &iio_pollfunc_store_time,
   880						      NULL, &iio_triggered_buffer_setup_ops);
   881		if (ret < 0)
   882			return dev_err_probe(&pdev->dev, ret, "Couldn't initialise the buffer\n");
   883	
   884		mutex_init(&info->lock);
   885	
   886		ret = devm_iio_device_register(&pdev->dev, indio_dev);
   887		if (ret)
   888			return dev_err_probe(&pdev->dev, ret, "Couldn't register the device.\n");
   889	
   890		return 0;
   891	}
   892	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

