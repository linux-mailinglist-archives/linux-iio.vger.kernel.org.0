Return-Path: <linux-iio+bounces-24085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC9EB5627B
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 20:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1210A562101
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 18:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C04E21257E;
	Sat, 13 Sep 2025 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSc4BL7q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA742DC796;
	Sat, 13 Sep 2025 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757787195; cv=none; b=bvayRde9GwuDPFnlP8rgsZ6807sc1LKSkBAVXG3leUYWlc8wpTuQ2vbduuVWgYG5esu0i+tfeLGouyTccF61+hKpNf9hVM9IZ2bTi59tVoBLMX0CozqA5vJZ9443cSOOCFw0Dl1BhEhigbLHdyurbNsLrVYlY6syIYdYEMzybzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757787195; c=relaxed/simple;
	bh=k7nNBspOXSSe/tLYVHuI4PsM5pE8ZoP9ghJYCBvc390=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpEOWiSo5znAOnS7VevZfmMlRiT2t2SNG4IzUryEzdgF3hDEkZFCJ4oKV8GuPOH3rEbEc8jtccv82tUjROSY/yEjUVw9HoFoYKWnxNxOAQS8zT86Og6j1qt2X7Pos+rCznj5vGcFm6O8zPIlDjRM09gWxXjpYM3HG+bJpbjW+08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSc4BL7q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757787192; x=1789323192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k7nNBspOXSSe/tLYVHuI4PsM5pE8ZoP9ghJYCBvc390=;
  b=cSc4BL7qs0G1RXh5lrjpte6G56uPllH97ikEbaINMwHyCov3XOwmj8RI
   eZGOP+I7/tNVuBl4iOB1YO2em8ArbOKPinYksjAbb2K2ERAYlrCwbP1Kd
   OObc4l0VTKvUndKdlyDZSaro0KGpGkzSEAM+CChcuOJDN97ej6tsIszLR
   VOUSSeztadpnuqQJWaH1ZcXLIcwk1o+CyyMlMAXjv5KtJNJ/rECeyEwQu
   BuuDX0GwzVOfsfvtazm3OldkPi6cN2N2saLJzJmdZ4qMw2HgbaLXgBNTK
   P/wJOOdX2tJyRQwrx3L3rpwaUxr9Ujfdt5SBH3seFgIfKzWSwgakse4Hg
   w==;
X-CSE-ConnectionGUID: LSbCQEpVTyiMIwy8gxaa2g==
X-CSE-MsgGUID: sU1nymnHRWeEDimJa4QRWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11552"; a="47670556"
X-IronPort-AV: E=Sophos;i="6.18,262,1751266800"; 
   d="scan'208";a="47670556"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 11:13:12 -0700
X-CSE-ConnectionGUID: vrRUZh2uStimY4r131L/pA==
X-CSE-MsgGUID: pM2BIAmMT+GPDoejCKmYAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,262,1751266800"; 
   d="scan'208";a="178576358"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 13 Sep 2025 11:13:08 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxUkD-0001l2-0a;
	Sat, 13 Sep 2025 18:13:05 +0000
Date: Sun, 14 Sep 2025 02:12:26 +0800
From: kernel test robot <lkp@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Petre Rodan <petre.rodan@subdimension.ro>
Subject: Re: [PATCH v3 15/18] iio: accel: bma220: add interrupt trigger
Message-ID: <202509140109.kB7kOKfZ-lkp@intel.com>
References: <20250913-b4-bma220_improvements-v3-15-0b97279b4e45@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-b4-bma220_improvements-v3-15-0b97279b4e45@subdimension.ro>

Hi Petre,

kernel test robot noticed the following build errors:

[auto build test ERROR on 661facba437e37c1685606825b9fd59be3f78771]

url:    https://github.com/intel-lab-lkp/linux/commits/Petre-Rodan/dt-bindings-iio-accel-bosch-bma220-cleanup-typo/20250913-234451
base:   661facba437e37c1685606825b9fd59be3f78771
patch link:    https://lore.kernel.org/r/20250913-b4-bma220_improvements-v3-15-0b97279b4e45%40subdimension.ro
patch subject: [PATCH v3 15/18] iio: accel: bma220: add interrupt trigger
config: x86_64-buildonly-randconfig-002-20250913 (https://download.01.org/0day-ci/archive/20250914/202509140109.kB7kOKfZ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250914/202509140109.kB7kOKfZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509140109.kB7kOKfZ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/linkage.h:7,
                    from arch/x86/include/asm/cache.h:5,
                    from include/vdso/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/iio/accel/bma220_core.c:12:
   drivers/iio/accel/bma220_core.c: In function 'bma220_irq_handler':
>> drivers/iio/accel/bma220_core.c:521:22: error: non-static declaration of 'bma220_common_probe' follows static declaration
     521 | EXPORT_SYMBOL_NS_GPL(bma220_common_probe, "IIO_BOSCH_BMA220");
         |                      ^~~~~~~~~~~~~~~~~~~
   include/linux/export.h:76:28: note: in definition of macro '__EXPORT_SYMBOL'
      76 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   drivers/iio/accel/bma220_core.c:521:1: note: in expansion of macro 'EXPORT_SYMBOL_NS_GPL'
     521 | EXPORT_SYMBOL_NS_GPL(bma220_common_probe, "IIO_BOSCH_BMA220");
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/iio/accel/bma220_core.c:457:5: note: previous definition of 'bma220_common_probe' with type 'int(struct device *, struct regmap *, int)'
     457 | int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
         |     ^~~~~~~~~~~~~~~~~~~
>> drivers/iio/accel/bma220_core.c:523:12: error: invalid storage class for function 'bma220_suspend'
     523 | static int bma220_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~
>> drivers/iio/accel/bma220_core.c:531:12: error: invalid storage class for function 'bma220_resume'
     531 | static int bma220_resume(struct device *dev)
         |            ^~~~~~~~~~~~~
>> drivers/iio/accel/bma220_core.c:538:29: error: extern declaration of 'bma220_pm_ops' follows declaration with no linkage
     538 | EXPORT_NS_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume,
         |                             ^~~~~~~~~~~~~
   include/linux/export.h:76:28: note: in definition of macro '__EXPORT_SYMBOL'
      76 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/pm.h:393:57: note: in expansion of macro '_EXPORT_PM_OPS'
     393 | #define _EXPORT_DEV_SLEEP_PM_OPS(name, license, ns)     _EXPORT_PM_OPS(name, license, ns)
         |                                                         ^~~~~~~~~~~~~~
   include/linux/pm.h:405:57: note: in expansion of macro '_EXPORT_DEV_SLEEP_PM_OPS'
     405 | #define EXPORT_NS_DEV_SLEEP_PM_OPS(name, ns)            _EXPORT_DEV_SLEEP_PM_OPS(name, "", #ns)
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:427:9: note: in expansion of macro 'EXPORT_NS_DEV_SLEEP_PM_OPS'
     427 |         EXPORT_NS_DEV_SLEEP_PM_OPS(name, ns) = { \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/accel/bma220_core.c:538:1: note: in expansion of macro 'EXPORT_NS_SIMPLE_DEV_PM_OPS'
     538 | EXPORT_NS_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:25:
   drivers/iio/accel/bma220_core.c:538:29: note: previous declaration of 'bma220_pm_ops' with type 'const struct dev_pm_ops'
     538 | EXPORT_NS_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume,
         |                             ^~~~~~~~~~~~~
   include/linux/pm.h:379:33: note: in definition of macro '_EXPORT_PM_OPS'
     379 |         const struct dev_pm_ops name;                                   \
         |                                 ^~~~
   include/linux/pm.h:405:57: note: in expansion of macro '_EXPORT_DEV_SLEEP_PM_OPS'
     405 | #define EXPORT_NS_DEV_SLEEP_PM_OPS(name, ns)            _EXPORT_DEV_SLEEP_PM_OPS(name, "", #ns)
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:427:9: note: in expansion of macro 'EXPORT_NS_DEV_SLEEP_PM_OPS'
     427 |         EXPORT_NS_DEV_SLEEP_PM_OPS(name, ns) = { \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/accel/bma220_core.c:538:1: note: in expansion of macro 'EXPORT_NS_SIMPLE_DEV_PM_OPS'
     538 | EXPORT_NS_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/accel/bma220_core.c:538:29: error: declaration of 'bma220_pm_ops' with no linkage follows extern declaration
     538 | EXPORT_NS_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume,
         |                             ^~~~~~~~~~~~~
   include/linux/pm.h:381:33: note: in definition of macro '_EXPORT_PM_OPS'
     381 |         const struct dev_pm_ops name
         |                                 ^~~~
   include/linux/pm.h:405:57: note: in expansion of macro '_EXPORT_DEV_SLEEP_PM_OPS'
     405 | #define EXPORT_NS_DEV_SLEEP_PM_OPS(name, ns)            _EXPORT_DEV_SLEEP_PM_OPS(name, "", #ns)
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:427:9: note: in expansion of macro 'EXPORT_NS_DEV_SLEEP_PM_OPS'
     427 |         EXPORT_NS_DEV_SLEEP_PM_OPS(name, ns) = { \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/accel/bma220_core.c:538:1: note: in expansion of macro 'EXPORT_NS_SIMPLE_DEV_PM_OPS'
     538 | EXPORT_NS_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/accel/bma220_core.c:538:29: note: previous declaration of 'bma220_pm_ops' with type 'const struct dev_pm_ops'
     538 | EXPORT_NS_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume,
         |                             ^~~~~~~~~~~~~
   include/linux/export.h:76:28: note: in definition of macro '__EXPORT_SYMBOL'
      76 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/pm.h:393:57: note: in expansion of macro '_EXPORT_PM_OPS'
     393 | #define _EXPORT_DEV_SLEEP_PM_OPS(name, license, ns)     _EXPORT_PM_OPS(name, license, ns)
         |                                                         ^~~~~~~~~~~~~~
   include/linux/pm.h:405:57: note: in expansion of macro '_EXPORT_DEV_SLEEP_PM_OPS'
     405 | #define EXPORT_NS_DEV_SLEEP_PM_OPS(name, ns)            _EXPORT_DEV_SLEEP_PM_OPS(name, "", #ns)
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:427:9: note: in expansion of macro 'EXPORT_NS_DEV_SLEEP_PM_OPS'
     427 |         EXPORT_NS_DEV_SLEEP_PM_OPS(name, ns) = { \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/accel/bma220_core.c:538:1: note: in expansion of macro 'EXPORT_NS_SIMPLE_DEV_PM_OPS'
     538 | EXPORT_NS_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/accel/bma220_core.c:543:1: error: expected declaration or statement at end of input
     543 | MODULE_LICENSE("GPL");
         | ^~~~~~~~~~~~~~
>> drivers/iio/accel/bma220_core.c:538:29: warning: unused variable 'bma220_pm_ops' [-Wunused-variable]
     538 | EXPORT_NS_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume,
         |                             ^~~~~~~~~~~~~
   include/linux/pm.h:381:33: note: in definition of macro '_EXPORT_PM_OPS'
     381 |         const struct dev_pm_ops name
         |                                 ^~~~
   include/linux/pm.h:405:57: note: in expansion of macro '_EXPORT_DEV_SLEEP_PM_OPS'
     405 | #define EXPORT_NS_DEV_SLEEP_PM_OPS(name, ns)            _EXPORT_DEV_SLEEP_PM_OPS(name, "", #ns)
         |                                                         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:427:9: note: in expansion of macro 'EXPORT_NS_DEV_SLEEP_PM_OPS'
     427 |         EXPORT_NS_DEV_SLEEP_PM_OPS(name, ns) = { \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/accel/bma220_core.c:538:1: note: in expansion of macro 'EXPORT_NS_SIMPLE_DEV_PM_OPS'
     538 | EXPORT_NS_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/bma220_common_probe +521 drivers/iio/accel/bma220_core.c

b019a92c1241f44 Petre Rodan 2025-09-13  456  
9216bea3069746d Petre Rodan 2025-09-13 @457  int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
e51403e66843c16 Petre Rodan 2025-09-13  458  {
e51403e66843c16 Petre Rodan 2025-09-13  459  	int ret;
e51403e66843c16 Petre Rodan 2025-09-13  460  	struct iio_dev *indio_dev;
e51403e66843c16 Petre Rodan 2025-09-13  461  	struct bma220_data *data;
e51403e66843c16 Petre Rodan 2025-09-13  462  
9216bea3069746d Petre Rodan 2025-09-13  463  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
e51403e66843c16 Petre Rodan 2025-09-13  464  	if (!indio_dev)
e51403e66843c16 Petre Rodan 2025-09-13  465  		return -ENOMEM;
e51403e66843c16 Petre Rodan 2025-09-13  466  
e51403e66843c16 Petre Rodan 2025-09-13  467  	data = iio_priv(indio_dev);
9216bea3069746d Petre Rodan 2025-09-13  468  	data->regmap = regmap;
9216bea3069746d Petre Rodan 2025-09-13  469  	data->dev = dev;
9216bea3069746d Petre Rodan 2025-09-13  470  
9216bea3069746d Petre Rodan 2025-09-13  471  	ret = bma220_init(data);
9216bea3069746d Petre Rodan 2025-09-13  472  	if (ret)
9216bea3069746d Petre Rodan 2025-09-13  473  		return ret;
9216bea3069746d Petre Rodan 2025-09-13  474  
9216bea3069746d Petre Rodan 2025-09-13  475  	ret = devm_mutex_init(dev, &data->lock);
9216bea3069746d Petre Rodan 2025-09-13  476  	if (ret)
9216bea3069746d Petre Rodan 2025-09-13  477  		return ret;
e51403e66843c16 Petre Rodan 2025-09-13  478  
e51403e66843c16 Petre Rodan 2025-09-13  479  	indio_dev->info = &bma220_info;
e51403e66843c16 Petre Rodan 2025-09-13  480  	indio_dev->name = BMA220_DEVICE_NAME;
e51403e66843c16 Petre Rodan 2025-09-13  481  	indio_dev->modes = INDIO_DIRECT_MODE;
e51403e66843c16 Petre Rodan 2025-09-13  482  	indio_dev->channels = bma220_channels;
e51403e66843c16 Petre Rodan 2025-09-13  483  	indio_dev->num_channels = ARRAY_SIZE(bma220_channels);
e51403e66843c16 Petre Rodan 2025-09-13  484  	indio_dev->available_scan_masks = bma220_accel_scan_masks;
e51403e66843c16 Petre Rodan 2025-09-13  485  
b019a92c1241f44 Petre Rodan 2025-09-13  486  	if (irq > 0) {
b019a92c1241f44 Petre Rodan 2025-09-13  487  		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
b019a92c1241f44 Petre Rodan 2025-09-13  488  						    indio_dev->name,
b019a92c1241f44 Petre Rodan 2025-09-13  489  						    iio_device_id(indio_dev));
b019a92c1241f44 Petre Rodan 2025-09-13  490  		if (!data->trig)
b019a92c1241f44 Petre Rodan 2025-09-13  491  			return -ENOMEM;
b019a92c1241f44 Petre Rodan 2025-09-13  492  
b019a92c1241f44 Petre Rodan 2025-09-13  493  		data->trig->ops = &bma220_trigger_ops;
b019a92c1241f44 Petre Rodan 2025-09-13  494  		iio_trigger_set_drvdata(data->trig, indio_dev);
b019a92c1241f44 Petre Rodan 2025-09-13  495  
b019a92c1241f44 Petre Rodan 2025-09-13  496  		ret = devm_iio_trigger_register(dev, data->trig);
b019a92c1241f44 Petre Rodan 2025-09-13  497  		if (ret)
b019a92c1241f44 Petre Rodan 2025-09-13  498  			return dev_err_probe(dev, ret,
b019a92c1241f44 Petre Rodan 2025-09-13  499  					     "iio trigger register fail\n");
b019a92c1241f44 Petre Rodan 2025-09-13  500  		indio_dev->trig = iio_trigger_get(data->trig);
b019a92c1241f44 Petre Rodan 2025-09-13  501  		ret = devm_request_threaded_irq(dev, irq, NULL,
b019a92c1241f44 Petre Rodan 2025-09-13  502  						&bma220_irq_handler,
b019a92c1241f44 Petre Rodan 2025-09-13  503  						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
b019a92c1241f44 Petre Rodan 2025-09-13  504  						indio_dev->name, indio_dev);
b019a92c1241f44 Petre Rodan 2025-09-13  505  		if (ret)
b019a92c1241f44 Petre Rodan 2025-09-13  506  			return dev_err_probe(dev, ret,
b019a92c1241f44 Petre Rodan 2025-09-13  507  					     "request irq %d failed\n", irq);
b019a92c1241f44 Petre Rodan 2025-09-13  508  	}
b019a92c1241f44 Petre Rodan 2025-09-13  509  
9216bea3069746d Petre Rodan 2025-09-13  510  	ret = devm_add_action_or_reset(dev, bma220_deinit, data);
e51403e66843c16 Petre Rodan 2025-09-13  511  	if (ret)
e51403e66843c16 Petre Rodan 2025-09-13  512  		return ret;
e51403e66843c16 Petre Rodan 2025-09-13  513  
d1258c485cdab0a Petre Rodan 2025-09-13  514  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
e51403e66843c16 Petre Rodan 2025-09-13  515  					      bma220_trigger_handler, NULL);
9216bea3069746d Petre Rodan 2025-09-13  516  	if (ret < 0)
9216bea3069746d Petre Rodan 2025-09-13  517  		dev_err_probe(dev, ret, "iio triggered buffer setup failed\n");
e51403e66843c16 Petre Rodan 2025-09-13  518  
9216bea3069746d Petre Rodan 2025-09-13  519  	return devm_iio_device_register(dev, indio_dev);
e51403e66843c16 Petre Rodan 2025-09-13  520  }
9216bea3069746d Petre Rodan 2025-09-13 @521  EXPORT_SYMBOL_NS_GPL(bma220_common_probe, "IIO_BOSCH_BMA220");
e51403e66843c16 Petre Rodan 2025-09-13  522  
e51403e66843c16 Petre Rodan 2025-09-13 @523  static int bma220_suspend(struct device *dev)
e51403e66843c16 Petre Rodan 2025-09-13  524  {
9216bea3069746d Petre Rodan 2025-09-13  525  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
9216bea3069746d Petre Rodan 2025-09-13  526  	struct bma220_data *data = iio_priv(indio_dev);
e51403e66843c16 Petre Rodan 2025-09-13  527  
9216bea3069746d Petre Rodan 2025-09-13  528  	return bma220_power(data, false);
e51403e66843c16 Petre Rodan 2025-09-13  529  }
e51403e66843c16 Petre Rodan 2025-09-13  530  
e51403e66843c16 Petre Rodan 2025-09-13 @531  static int bma220_resume(struct device *dev)
e51403e66843c16 Petre Rodan 2025-09-13  532  {
9216bea3069746d Petre Rodan 2025-09-13  533  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
9216bea3069746d Petre Rodan 2025-09-13  534  	struct bma220_data *data = iio_priv(indio_dev);
e51403e66843c16 Petre Rodan 2025-09-13  535  
9216bea3069746d Petre Rodan 2025-09-13  536  	return bma220_power(data, true);
e51403e66843c16 Petre Rodan 2025-09-13  537  }
e51403e66843c16 Petre Rodan 2025-09-13 @538  EXPORT_NS_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume,
e51403e66843c16 Petre Rodan 2025-09-13  539  			    IIO_BOSCH_BMA220);
e51403e66843c16 Petre Rodan 2025-09-13  540  
e51403e66843c16 Petre Rodan 2025-09-13  541  MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
e51403e66843c16 Petre Rodan 2025-09-13  542  MODULE_DESCRIPTION("BMA220 acceleration sensor driver");
e51403e66843c16 Petre Rodan 2025-09-13 @543  MODULE_LICENSE("GPL");

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

