Return-Path: <linux-iio+bounces-11952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A91699BF9D5
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 00:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA661C21AF0
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A26820CCFA;
	Wed,  6 Nov 2024 23:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YF3HkRMz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826F1917D7;
	Wed,  6 Nov 2024 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935005; cv=none; b=g0XnUZRbss17laEnYyD8hIJ9zYu00InrGL1aNQPaW5G66VjVlVoeF1rfJfglwRJR3yR2tQNgApDx9oRBVrwJM+YAoWBttNlcB3IF0lwLhMAkpi7QbAdXJLgNucFdyz6eyT63t2xucvTEzHYYzQXXOKNuoc1S3d4cxLBsRB2RDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935005; c=relaxed/simple;
	bh=8t4OEcNHJDzTfLCGQpw/anttTxd3p+Oa+vM7lHiVVxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfiWuiFNABTf28i8qMBs5mXLYxtcPd0y51DkQd1Iqsgt9bjv1OfTuTk1L1FgTWEV0sCDtJ6e5oj4SgrWasGZeJqAxM7uLsFerXWAMHY8vODW4xHlifqfVZzjNgYuPrh2lZXOGE6z7k4o6P7fQ70TGyeWVuarJs6efgkde50TYks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YF3HkRMz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730935003; x=1762471003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8t4OEcNHJDzTfLCGQpw/anttTxd3p+Oa+vM7lHiVVxw=;
  b=YF3HkRMzSNnOub6CbVSh3wAwP9Irfz3CmSvoTUsUdAzXmC1M+rGwEX4k
   Sc7+xrsJGgPq/IQHQnE/kpxmYDZSgs0jGVis7+JhRvYz/D7dFP4H625u5
   ltQQfTPJj/MJJ7zgdypMVUGUH/wOM8pABMXVWVwwoLVsFGGKPO5TPiRpM
   5zoZyngJAvm+UoqaWtgQrIszzvZmLMF58PeuMdCZ/9rgaYrtJvMbEToMc
   bXrFpXOVSLFdE2kWcr3d3sW0ivw5JklzFjwKmHTsS+pRFF2P+2jCENtAp
   XcSuxo+pRLhW15A2ZKDPvVvRe4noBWY7gcMhV1gQVWx5Y5CS0KBp5SFGE
   A==;
X-CSE-ConnectionGUID: sQiz/yTlT2WlsAczZsEIkg==
X-CSE-MsgGUID: eFTXd2zrTDiM4ahKlxiCsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="42162654"
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="42162654"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 15:16:43 -0800
X-CSE-ConnectionGUID: gJdqCi98T0+DMt2pX58LyQ==
X-CSE-MsgGUID: IQVfLupFSiW0UjsM/h+pIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="115608972"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 06 Nov 2024 15:16:40 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8pGP-000pWO-38;
	Wed, 06 Nov 2024 23:16:37 +0000
Date: Thu, 7 Nov 2024 07:16:15 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/2] iio: adc: vf610_adc: use devm_* and
 dev_err_probe() to simple code
Message-ID: <202411070633.NIrO7Ert-lkp@intel.com>
References: <20241105160822.2761261-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105160822.2761261-1-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on next-20241106]
[cannot apply to linus/master v6.12-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/iio-adc-vf610_adc-limit-i-MX6SX-s-channel-number-to-4/20241106-001101
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241105160822.2761261-1-Frank.Li%40nxp.com
patch subject: [PATCH v2 1/2] iio: adc: vf610_adc: use devm_* and dev_err_probe() to simple code
config: i386-randconfig-141-20241107 (https://download.01.org/0day-ci/archive/20241107/202411070633.NIrO7Ert-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411070633.NIrO7Ert-lkp@intel.com/

smatch warnings:
drivers/iio/adc/vf610_adc.c:857 vf610_adc_probe() warn: unsigned 'info->vref_uv' is never less than zero.

vim +857 drivers/iio/adc/vf610_adc.c

   816	
   817	static int vf610_adc_probe(struct platform_device *pdev)
   818	{
   819		struct device *dev = &pdev->dev;
   820		struct vf610_adc *info;
   821		struct iio_dev *indio_dev;
   822		int irq;
   823		int ret;
   824	
   825		indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct vf610_adc));
   826		if (!indio_dev)
   827			return dev_err_probe(&pdev->dev, -ENOMEM, "Failed allocating iio device\n");
   828	
   829		info = iio_priv(indio_dev);
   830		info->dev = &pdev->dev;
   831	
   832		info->regs = devm_platform_ioremap_resource(pdev, 0);
   833		if (IS_ERR(info->regs))
   834			return PTR_ERR(info->regs);
   835	
   836		irq = platform_get_irq(pdev, 0);
   837		if (irq < 0)
   838			return irq;
   839	
   840		ret = devm_request_irq(info->dev, irq,
   841					vf610_adc_isr, 0,
   842					dev_name(&pdev->dev), indio_dev);
   843		if (ret < 0)
   844			dev_err_probe(&pdev->dev, ret, "failed requesting irq, irq = %d\n", irq);
   845	
   846		info->clk = devm_clk_get_enabled(&pdev->dev, "adc");
   847		if (IS_ERR(info->clk))
   848			return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
   849					     "failed getting clock, err = %ld\n",
   850					     PTR_ERR(info->clk));
   851	
   852		info->vref = devm_regulator_get(&pdev->dev, "vref");
   853		if (IS_ERR(info->vref))
   854			return PTR_ERR(info->vref);
   855	
   856		info->vref_uv = devm_regulator_get_enable_read_voltage(&pdev->dev, "vref");
 > 857		if (info->vref_uv < 0)
   858			return info->vref_uv;
   859	
   860		device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
   861	
   862		info->adc_feature.default_sample_time = DEFAULT_SAMPLE_TIME;
   863		device_property_read_u32(dev, "min-sample-time", &info->adc_feature.default_sample_time);
   864	
   865		platform_set_drvdata(pdev, indio_dev);
   866	
   867		init_completion(&info->completion);
   868	
   869		indio_dev->name = dev_name(&pdev->dev);
   870		indio_dev->info = &vf610_adc_iio_info;
   871		indio_dev->modes = INDIO_DIRECT_MODE;
   872		indio_dev->channels = vf610_adc_iio_channels;
   873		indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
   874	
   875		vf610_adc_cfg_init(info);
   876		vf610_adc_hw_init(info);
   877	
   878		ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev, &iio_pollfunc_store_time,
   879						      NULL, &iio_triggered_buffer_setup_ops);
   880		if (ret < 0)
   881			return dev_err_probe(&pdev->dev, ret, "Couldn't initialise the buffer\n");
   882	
   883		mutex_init(&info->lock);
   884	
   885		ret = devm_iio_device_register(&pdev->dev, indio_dev);
   886		if (ret)
   887			return dev_err_probe(&pdev->dev, ret, "Couldn't register the device.\n");
   888	
   889		return 0;
   890	}
   891	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

