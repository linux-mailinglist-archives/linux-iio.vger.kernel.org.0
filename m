Return-Path: <linux-iio+bounces-7872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D5693BAD8
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 04:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB821C208DE
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 02:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317BA10A03;
	Thu, 25 Jul 2024 02:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X88QKeSE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440ED380;
	Thu, 25 Jul 2024 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721874776; cv=none; b=vGYAi00aToycA09SX/zHjtf67wvODpW5Vbyeg6PcrzqKgcY2lEUdLkYwxEIsFg44VQ90yn/nA7awFSL8+FIxX6r7xFNkoA3dyK8tAmlsG48Pv+F50v0TX+/I/UXpv1cWthyIZ5dUJ/eY2U4aIuxX+Ad7SYGLHunSBTWdYYACIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721874776; c=relaxed/simple;
	bh=MTAF3tHhSQ+iilx/KM0XPg93Ee6bItA5QT/jXwf2gUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVC14dKM5HwmYcw8Qw/50EMvKu7Dh4X5yPPZh4qYwwQGJRZjStS23EFDyqpi3nxl9oqcW6y+KuARyH0ZMi/+faXtuU9j6ZHlclSs7NmX2zsAMoJ89ESTAHr67U/FFMjdFRy3+lOLd3NFvGDIIqm9Wbj/XCC7Dx/YWk3No1vfaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X88QKeSE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721874773; x=1753410773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MTAF3tHhSQ+iilx/KM0XPg93Ee6bItA5QT/jXwf2gUc=;
  b=X88QKeSEbp8Sq/ghWE4UW+Za+abWZEIF2CdOlr1hIuwQmsl2TYPxcWJW
   KTBRRKF5n21uXeNWjEhiBGVoILeDwOYnWa1bB5CCQ3FBr0LqzZncv8gV8
   XuRCvSG6xJhoGQ2UTvybyMQtYSgxGu7t+NjE0yaWTGOaguEBGJZGMk9CG
   3rYYTcgYhETZIoLBTPETEMbTZ5KWaAFo0T5JNnYeEhNDjfyoENfPrBWMs
   Wxn4Lu23l+/Bi2x7lETh1kRw6bVsTMQgqaECi7VAmXasc7qDolnLSCNA2
   58yyVl5kieK2v6o0MyidgRIDVDN/gZ5VLZFczzBw22r+4IxSZcg32Gs/r
   w==;
X-CSE-ConnectionGUID: /G9LiGIkQU23ACdpNPCVPQ==
X-CSE-MsgGUID: tHUDYS2mSQelvnNIEbGB/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="45013475"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="45013475"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 19:32:51 -0700
X-CSE-ConnectionGUID: kupUx1grTya+rJrtkMTegw==
X-CSE-MsgGUID: RpkdS/1HS1+lEdIdex7VVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52692595"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 24 Jul 2024 19:32:46 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWoHb-000ngC-33;
	Thu, 25 Jul 2024 02:32:43 +0000
Date: Thu, 25 Jul 2024 10:32:23 +0800
From: kernel test robot <lkp@intel.com>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <202407251042.LUZ78skF-lkp@intel.com>
References: <20240724155517.12470-5-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724155517.12470-5-ramona.nechita@analog.com>

Hi Ramona,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.10 next-20240724]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Alexandra-Nechita/dt-bindings-iio-adc-add-a7779-doc/20240725-000001
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240724155517.12470-5-ramona.nechita%40analog.com
patch subject: [PATCH v4 3/3] drivers: iio: adc: add support for ad777x family
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240725/202407251042.LUZ78skF-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240725/202407251042.LUZ78skF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407251042.LUZ78skF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/ad7779.c:420:5: warning: unused variable 'low' [-Wunused-variable]
     420 |         u8 low, mid, high;
         |            ^~~
   drivers/iio/adc/ad7779.c:420:10: warning: unused variable 'mid' [-Wunused-variable]
     420 |         u8 low, mid, high;
         |                 ^~~
   drivers/iio/adc/ad7779.c:420:15: warning: unused variable 'high' [-Wunused-variable]
     420 |         u8 low, mid, high;
         |                      ^~~~
   drivers/iio/adc/ad7779.c:445:5: warning: variable 'msb' set but not used [-Wunused-but-set-variable]
     445 |         u8 msb, mid, lsb;
         |            ^
   drivers/iio/adc/ad7779.c:445:10: warning: variable 'mid' set but not used [-Wunused-but-set-variable]
     445 |         u8 msb, mid, lsb;
         |                 ^
   drivers/iio/adc/ad7779.c:445:15: warning: variable 'lsb' set but not used [-Wunused-but-set-variable]
     445 |         u8 msb, mid, lsb;
         |                      ^
   drivers/iio/adc/ad7779.c:475:6: warning: unused variable 'ret' [-Wunused-variable]
     475 |         int ret;
         |             ^~~
>> drivers/iio/adc/ad7779.c:779:35: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     779 |                 return dev_err_probe(&spi->dev, ret,
         |                                                 ^~~
   drivers/iio/adc/ad7779.c:766:9: note: initialize the variable 'ret' to silence this warning
     766 |         int ret;
         |                ^
         |                 = 0
   8 warnings generated.


vim +/ret +779 drivers/iio/adc/ad7779.c

   760	
   761	static int ad7779_probe(struct spi_device *spi)
   762	{
   763		struct iio_dev *indio_dev;
   764		struct ad7779_state *st;
   765		struct gpio_desc *reset_gpio, *start_gpio;
   766		int ret;
   767	
   768		indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
   769		if (!indio_dev)
   770			return -ENOMEM;
   771	
   772		st = iio_priv(indio_dev);
   773	
   774		st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
   775		if (IS_ERR(st->mclk))
   776			return PTR_ERR(st->mclk);
   777	
   778		if (!spi->irq)
 > 779			return dev_err_probe(&spi->dev, ret,
   780					     "DRDY irq not present\n"); 
   781	
   782		reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);
   783		if (IS_ERR(reset_gpio))
   784			return PTR_ERR(reset_gpio);
   785	
   786		start_gpio = devm_gpiod_get(&spi->dev, "start", GPIOD_OUT_HIGH);
   787		if (IS_ERR(start_gpio))
   788			return PTR_ERR(start_gpio);
   789	
   790		crc8_populate_msb(ad7779_crc8_table, AD7779_CRC8_POLY);
   791		st->spi = spi;
   792	
   793		st->chip_info = spi_get_device_match_data(spi);
   794		if (!st->chip_info)
   795			return -ENODEV;
   796	
   797		ret = ad7779_reset(indio_dev, start_gpio);
   798		if (ret)
   799			return ret;
   800	
   801		ad7779_powerup(st, start_gpio);
   802		if (ret)
   803			return ret;
   804	
   805		indio_dev->name = st->chip_info->name;
   806		indio_dev->info = &ad7779_info;
   807		indio_dev->modes = INDIO_DIRECT_MODE;
   808		indio_dev->channels = st->chip_info->channels;
   809		indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
   810	
   811		st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
   812						  		indio_dev->name, iio_device_id(indio_dev));
   813		if (!st->trig)
   814			return -ENOMEM;
   815	
   816		st->trig->ops= &ad7779_trigger_ops;
   817		st->trig->dev.parent = &spi->dev;
   818	
   819		iio_trigger_set_drvdata(st->trig, st);
   820	
   821		ret = devm_request_irq(&spi->dev, spi->irq,
   822							   iio_trigger_generic_data_rdy_poll,
   823							   IRQF_ONESHOT | IRQF_NO_AUTOEN,
   824							   indio_dev->name, st->trig);
   825		if (ret)
   826			return dev_err_probe(&spi->dev, ret, "request irq %d failed\n",
   827					     st->spi->irq);
   828	
   829		ret = devm_iio_trigger_register(&spi->dev, st->trig);
   830		if (ret)
   831			return ret;
   832	
   833		indio_dev->trig = iio_trigger_get(st->trig);
   834	
   835		init_completion(&st->completion);
   836	
   837		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
   838											  &iio_pollfunc_store_time,
   839											  &ad7779_trigger_handler,
   840											  &ad7779_buffer_setup_ops);
   841		if (ret)
   842			return ret;
   843	
   844		ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
   845					    AD7779_DCLK_CLK_DIV_MSK,
   846					    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
   847		if (ret)
   848			return ret;
   849	
   850		return devm_iio_device_register(&spi->dev, indio_dev);
   851	}
   852	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

