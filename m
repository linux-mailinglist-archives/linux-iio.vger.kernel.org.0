Return-Path: <linux-iio+bounces-11916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E52449BCE52
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 14:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A25528369E
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50F61D79B6;
	Tue,  5 Nov 2024 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+PDJR+D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9A11D45EA;
	Tue,  5 Nov 2024 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730814815; cv=none; b=m7uiY64G1S/OoOuRthSaUzwZ1hXKeYcyHUy45XrDuzSQ2Zc59QlYMz9rOyySdl30+Hjxj2EOBmjxpsCFLk3JJ7NucdNs3JTrkc3gVjniBSt7XsrSwHHO/VgSL6HqK6ocbrOAqs6UptmVbfvtUOOpC6h9rTtAYWbNECc31IS3aHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730814815; c=relaxed/simple;
	bh=bcHiwJs4IVlRBeorVrw2V8nVNqnrV5jvY/5NCJVZP4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW2LU9iWI1UaN29Q6Oo+ONCVEZSRIPcrXThPHGr7tdKvVag0MoJeP549eEzW7Jo8wnbdkK40Lv3bnmV8lvMD6CCy1aqorlHeuj2kneQer0qw1hYXle4hgg2xpoulvmJcAA1oNAc1WWGXS69dBAndsqsN6igbEby2cT04mj/11lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+PDJR+D; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730814814; x=1762350814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bcHiwJs4IVlRBeorVrw2V8nVNqnrV5jvY/5NCJVZP4M=;
  b=h+PDJR+DEpgR9bEXFr80BoM3DHHLaQOPE1k0GGukmowfP3t1z4AMeqFe
   3GQCnDwKT4yQI46jQcGhrvpRq/JbFI89PhHK4cmfdS1Ozlkdz68jjZI0f
   jomiScOmh36MsSQbkh6LCadqzAS7DCf220Fb8meb8GC7j9UQgeeqe5EpI
   JQTDOu9Ww5/2RH6/vizILxfPRTg5lMnjZ9VXFK+ElMFmSQOKtsFvzwNzH
   T1cKVzydpyxbCs45Pw7Cze1ky61ck/y84+wAOR1ZAEf3BUxtVRAJutIC8
   HDQFRvujj/E3u77EO9UqtTIFc7i4+lQo+oj6fmJ8NPGy5/7CwMtu0p3E/
   w==;
X-CSE-ConnectionGUID: 6Sg8RzZhTNSsOPihAEQSyg==
X-CSE-MsgGUID: AAvvZ5DTSV6H9DNO/+UiVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30671884"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="30671884"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 05:53:33 -0800
X-CSE-ConnectionGUID: nIOTDAXsRuyN3p9bBGhYVA==
X-CSE-MsgGUID: 1C04mx9KRXCAsYVq1kdfnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84361458"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Nov 2024 05:53:32 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8Jzt-000m6l-06;
	Tue, 05 Nov 2024 13:53:29 +0000
Date: Tue, 5 Nov 2024 21:53:25 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] iio: adc: vf610_adc: limit i.MX6SX's channel number
 to 4
Message-ID: <202411052136.jstxD0iJ-lkp@intel.com>
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
config: alpha-randconfig-r072-20241105 (https://download.01.org/0day-ci/archive/20241105/202411052136.jstxD0iJ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241105/202411052136.jstxD0iJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411052136.jstxD0iJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/vf610_adc.c: In function 'vf610_adc_probe':
>> drivers/iio/adc/vf610_adc.c:874:35: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     874 |         indio_dev->num_channels = (u32)device_get_match_data(dev);
         |                                   ^


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

