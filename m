Return-Path: <linux-iio+bounces-18319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEA0A94362
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 14:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3895344073E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457741D61BC;
	Sat, 19 Apr 2025 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OIhkpqzk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A61259C;
	Sat, 19 Apr 2025 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745065235; cv=none; b=V8CrxSLLgitu3N/nSy+WoO7RXkGjoi5E8+8ZdiwZ5+iYZcmrKlyFoxZvP+w1uxuin09oRZMMOnPSF9bFooxFNhPCg7XLvqGlzDgUPE/hUzD5FiIcgFDo933HO0sAZP/FUlFY6txuNUikd9sG0hSkwqFhaFS1KZVRi/taMblMD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745065235; c=relaxed/simple;
	bh=k1eZNuwC2LHTSQEjQN297uy9tACOqs64R9TYDYKLyv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu3xt1s8ST7a2orwiJ/Zk56KSx6/zQHUmNfc6aYNa8t10v+A0hHBbK8tHWRYT8CoufyaKrZ9Mj2TyCACSbdSEFyHSsA9yHk+Hgt8dyiwSLk5b5PIv6LjtQRbrp1im/i1TFwsQk0IzbIPiZIebKe4BfndLv83QOOffglyB2cJnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OIhkpqzk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745065231; x=1776601231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=k1eZNuwC2LHTSQEjQN297uy9tACOqs64R9TYDYKLyv8=;
  b=OIhkpqzk0mmhOTwFxXkJBeFe0TnHNpDrU9NgiPJA7qD8YRH1g2+5l3Gs
   2xZL//McDM3izmXTv1Xn1Y7qyx9/mD19uPrksVCBQsXt+uNa2gT+8ScYa
   tOgsq/yHZ0zcopi8QtsyfQdPG6IxzPfOsCzjfdSfLm1w17t5c72vaXrTQ
   DI2kglyVCXR3YxZPNpwyhgyGIBMfZhVaq+Y4BDdAqzKY9fkUmAQl9NwzE
   K6YXOVlvCj8qcAaCJ2x5N7XL++e8WCGfLQGqlDpIiusij3foPL8wozaSH
   aLD7sTsaOX5bmD5a0NAlxK+fURTKnduJ30vVgm8NFkw+9LPs4E0mtypqt
   Q==;
X-CSE-ConnectionGUID: IkLSpYxRSWKSFuOzxPrz4w==
X-CSE-MsgGUID: vBtvftlKQNOZooY0Wk6/9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="64207327"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="64207327"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 05:20:30 -0700
X-CSE-ConnectionGUID: yJT3TYcHS/aMM4Zywr3mBw==
X-CSE-MsgGUID: y2P5sHmDRauoh+/BKvKh3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="162371004"
Received: from lkp-server01.sh.intel.com (HELO 61e10e65ea0f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 19 Apr 2025 05:20:26 -0700
Received: from kbuild by 61e10e65ea0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u67BI-0003qf-19;
	Sat, 19 Apr 2025 12:20:24 +0000
Date: Sat, 19 Apr 2025 20:19:48 +0800
From: kernel test robot <lkp@intel.com>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>, gregkh@linuxfoundation.org,
	jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com, sonic.zhang@analog.com,
	vapier@gentoo.org
Cc: oe-kbuild-all@lists.linux.dev, gshahrouzi@gmail.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 5/5] staging: iio: adc: ad7816: Simplify channel
 validation using chip_info
Message-ID: <202504192012.ATXH4XfM-lkp@intel.com>
References: <fad83a7efb12c0f40dc2660cf9dd4c57422ecff9.1745007964.git.gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fad83a7efb12c0f40dc2660cf9dd4c57422ecff9.1745007964.git.gshahrouzi@gmail.com>

Hi Gabriel,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Gabriel-Shahrouzi/staging-iio-adc-ad7816-Allow-channel-7-for-all-devices/20250419-045531
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/fad83a7efb12c0f40dc2660cf9dd4c57422ecff9.1745007964.git.gshahrouzi%40gmail.com
patch subject: [PATCH v3 5/5] staging: iio: adc: ad7816: Simplify channel validation using chip_info
config: x86_64-buildonly-randconfig-003-20250419 (https://download.01.org/0day-ci/archive/20250419/202504192012.ATXH4XfM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250419/202504192012.ATXH4XfM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504192012.ATXH4XfM-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/staging/iio/adc/ad7816.c: In function 'ad7816_store_channel':
>> drivers/staging/iio/adc/ad7816.c:222:16: error: invalid storage class for function 'ad7816_show_value'
     222 | static ssize_t ad7816_show_value(struct device *dev,
         |                ^~~~~~~~~~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from drivers/staging/iio/adc/ad7816.c:10:
>> drivers/staging/iio/adc/ad7816.c:248:37: error: initializer element is not constant
     248 | static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
         |                                     ^~~~~~~~~~~~~~~~~
   include/linux/sysfs.h:233:19: note: in definition of macro '__ATTR'
     233 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/iio/sysfs.h:72:11: note: in expansion of macro 'IIO_ATTR'
      72 |         = IIO_ATTR(_name, _mode, _show, _store, _addr)
         |           ^~~~~~~~
   drivers/staging/iio/adc/ad7816.c:248:8: note: in expansion of macro 'IIO_DEVICE_ATTR'
     248 | static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
         |        ^~~~~~~~~~~~~~~
   drivers/staging/iio/adc/ad7816.c:248:37: note: (near initialization for 'iio_dev_attr_value.dev_attr.show')
     248 | static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
         |                                     ^~~~~~~~~~~~~~~~~
   include/linux/sysfs.h:233:19: note: in definition of macro '__ATTR'
     233 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/iio/sysfs.h:72:11: note: in expansion of macro 'IIO_ATTR'
      72 |         = IIO_ATTR(_name, _mode, _show, _store, _addr)
         |           ^~~~~~~~
   drivers/staging/iio/adc/ad7816.c:248:8: note: in expansion of macro 'IIO_DEVICE_ATTR'
     248 | static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
         |        ^~~~~~~~~~~~~~~
>> drivers/staging/iio/adc/ad7816.c:271:20: error: invalid storage class for function 'ad7816_event_handler'
     271 | static irqreturn_t ad7816_event_handler(int irq, void *private)
         |                    ^~~~~~~~~~~~~~~~~~~~
>> drivers/staging/iio/adc/ad7816.c:278:16: error: invalid storage class for function 'ad7816_show_oti'
     278 | static ssize_t ad7816_show_oti(struct device *dev,
         |                ^~~~~~~~~~~~~~~
>> drivers/staging/iio/adc/ad7816.c:298:23: error: invalid storage class for function 'ad7816_set_oti'
     298 | static inline ssize_t ad7816_set_oti(struct device *dev,
         |                       ^~~~~~~~~~~~~~
   drivers/staging/iio/adc/ad7816.c:340:24: error: initializer element is not constant
     340 |                        ad7816_show_oti, ad7816_set_oti, 0);
         |                        ^~~~~~~~~~~~~~~
   include/linux/sysfs.h:233:19: note: in definition of macro '__ATTR'
     233 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/iio/sysfs.h:72:11: note: in expansion of macro 'IIO_ATTR'
      72 |         = IIO_ATTR(_name, _mode, _show, _store, _addr)
         |           ^~~~~~~~
   drivers/staging/iio/adc/ad7816.c:339:8: note: in expansion of macro 'IIO_DEVICE_ATTR'
     339 | static IIO_DEVICE_ATTR(oti, 0644,
         |        ^~~~~~~~~~~~~~~
   drivers/staging/iio/adc/ad7816.c:340:24: note: (near initialization for 'iio_dev_attr_oti.dev_attr.show')
     340 |                        ad7816_show_oti, ad7816_set_oti, 0);
         |                        ^~~~~~~~~~~~~~~
   include/linux/sysfs.h:233:19: note: in definition of macro '__ATTR'
     233 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/iio/sysfs.h:72:11: note: in expansion of macro 'IIO_ATTR'
      72 |         = IIO_ATTR(_name, _mode, _show, _store, _addr)
         |           ^~~~~~~~
   drivers/staging/iio/adc/ad7816.c:339:8: note: in expansion of macro 'IIO_DEVICE_ATTR'
     339 | static IIO_DEVICE_ATTR(oti, 0644,
         |        ^~~~~~~~~~~~~~~
   drivers/staging/iio/adc/ad7816.c:340:41: error: initializer element is not constant
     340 |                        ad7816_show_oti, ad7816_set_oti, 0);
         |                                         ^~~~~~~~~~~~~~
   include/linux/sysfs.h:234:19: note: in definition of macro '__ATTR'
     234 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/iio/sysfs.h:72:11: note: in expansion of macro 'IIO_ATTR'
      72 |         = IIO_ATTR(_name, _mode, _show, _store, _addr)
         |           ^~~~~~~~
   drivers/staging/iio/adc/ad7816.c:339:8: note: in expansion of macro 'IIO_DEVICE_ATTR'
     339 | static IIO_DEVICE_ATTR(oti, 0644,
         |        ^~~~~~~~~~~~~~~
   drivers/staging/iio/adc/ad7816.c:340:41: note: (near initialization for 'iio_dev_attr_oti.dev_attr.store')
     340 |                        ad7816_show_oti, ad7816_set_oti, 0);
         |                                         ^~~~~~~~~~~~~~
   include/linux/sysfs.h:234:19: note: in definition of macro '__ATTR'
     234 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/iio/sysfs.h:72:11: note: in expansion of macro 'IIO_ATTR'
      72 |         = IIO_ATTR(_name, _mode, _show, _store, _addr)
         |           ^~~~~~~~
   drivers/staging/iio/adc/ad7816.c:339:8: note: in expansion of macro 'IIO_DEVICE_ATTR'
     339 | static IIO_DEVICE_ATTR(oti, 0644,
         |        ^~~~~~~~~~~~~~~
>> drivers/staging/iio/adc/ad7816.c:361:12: error: invalid storage class for function 'ad7816_probe'
     361 | static int ad7816_probe(struct spi_device *spi_dev)
         |            ^~~~~~~~~~~~
>> drivers/staging/iio/adc/ad7816.c:442:1: warning: 'alias' attribute ignored [-Wattributes]
     442 | MODULE_DEVICE_TABLE(of, ad7816_of_match);
         | ^~~~~~~~~~~~~~~~~~~
   drivers/staging/iio/adc/ad7816.c:451:1: warning: 'alias' attribute ignored [-Wattributes]
     451 | MODULE_DEVICE_TABLE(spi, ad7816_id);
         | ^~~~~~~~~~~~~~~~~~~
   drivers/staging/iio/adc/ad7816.c:458:18: error: initializer element is not constant
     458 |         .probe = ad7816_probe,
         |                  ^~~~~~~~~~~~
   drivers/staging/iio/adc/ad7816.c:458:18: note: (near initialization for 'ad7816_driver.probe')
   In file included from include/linux/device.h:32:
>> drivers/staging/iio/adc/ad7816.c:461:19: error: invalid storage class for function 'ad7816_driver_init'
     461 | module_spi_driver(ad7816_driver);
         |                   ^~~~~~~~~~~~~
   include/linux/device/driver.h:258:19: note: in definition of macro 'module_driver'
     258 | static int __init __driver##_init(void) \
         |                   ^~~~~~~~
   drivers/staging/iio/adc/ad7816.c:461:1: note: in expansion of macro 'module_spi_driver'
     461 | module_spi_driver(ad7816_driver);
         | ^~~~~~~~~~~~~~~~~
   In file included from include/linux/device/driver.h:21:
>> include/linux/module.h:131:49: error: invalid storage class for function '__inittest'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:262:1: note: in expansion of macro 'module_init'
     262 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/spi/spi.h:387:9: note: in expansion of macro 'module_driver'
     387 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~
   drivers/staging/iio/adc/ad7816.c:461:1: note: in expansion of macro 'module_spi_driver'
     461 | module_spi_driver(ad7816_driver);
         | ^~~~~~~~~~~~~~~~~
   drivers/staging/iio/adc/ad7816.c:461:1: warning: 'alias' attribute ignored [-Wattributes]
>> drivers/staging/iio/adc/ad7816.c:461:19: error: invalid storage class for function 'ad7816_driver_exit'
     461 | module_spi_driver(ad7816_driver);
         |                   ^~~~~~~~~~~~~
   include/linux/device/driver.h:263:20: note: in definition of macro 'module_driver'
     263 | static void __exit __driver##_exit(void) \
         |                    ^~~~~~~~
   drivers/staging/iio/adc/ad7816.c:461:1: note: in expansion of macro 'module_spi_driver'
     461 | module_spi_driver(ad7816_driver);
         | ^~~~~~~~~~~~~~~~~
>> include/linux/module.h:139:49: error: invalid storage class for function '__exittest'
     139 |         static inline exitcall_t __maybe_unused __exittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:267:1: note: in expansion of macro 'module_exit'
     267 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/spi/spi.h:387:9: note: in expansion of macro 'module_driver'
     387 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~
   drivers/staging/iio/adc/ad7816.c:461:1: note: in expansion of macro 'module_spi_driver'
     461 | module_spi_driver(ad7816_driver);
         | ^~~~~~~~~~~~~~~~~
   drivers/staging/iio/adc/ad7816.c:461:1: warning: 'alias' attribute ignored [-Wattributes]
>> drivers/staging/iio/adc/ad7816.c:465:1: error: expected declaration or statement at end of input
     465 | MODULE_LICENSE("GPL v2");
         | ^~~~~~~~~~~~~~
   drivers/staging/iio/adc/ad7816.c: At top level:
>> drivers/staging/iio/adc/ad7816.c:193:16: warning: 'ad7816_store_channel' defined but not used [-Wunused-function]
     193 | static ssize_t ad7816_store_channel(struct device *dev,
         |                ^~~~~~~~~~~~~~~~~~~~
--
         |                   ^~~~~
   include/linux/iio/sysfs.h:72:11: note: in expansion of macro 'IIO_ATTR'
      72 |         = IIO_ATTR(_name, _mode, _show, _store, _addr)
         |           ^~~~~~~~
   ad7816.c:248:8: note: in expansion of macro 'IIO_DEVICE_ATTR'
     248 | static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
         |        ^~~~~~~~~~~~~~~
   ad7816.c:248:37: note: (near initialization for 'iio_dev_attr_value.dev_attr.show')
     248 | static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
         |                                     ^~~~~~~~~~~~~~~~~
   include/linux/sysfs.h:233:19: note: in definition of macro '__ATTR'
     233 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/iio/sysfs.h:72:11: note: in expansion of macro 'IIO_ATTR'
      72 |         = IIO_ATTR(_name, _mode, _show, _store, _addr)
         |           ^~~~~~~~
   ad7816.c:248:8: note: in expansion of macro 'IIO_DEVICE_ATTR'
     248 | static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
         |        ^~~~~~~~~~~~~~~
   ad7816.c:271:20: error: invalid storage class for function 'ad7816_event_handler'
     271 | static irqreturn_t ad7816_event_handler(int irq, void *private)
         |                    ^~~~~~~~~~~~~~~~~~~~
   ad7816.c:278:16: error: invalid storage class for function 'ad7816_show_oti'
     278 | static ssize_t ad7816_show_oti(struct device *dev,
         |                ^~~~~~~~~~~~~~~
   ad7816.c:298:23: error: invalid storage class for function 'ad7816_set_oti'
     298 | static inline ssize_t ad7816_set_oti(struct device *dev,
         |                       ^~~~~~~~~~~~~~
   ad7816.c:340:24: error: initializer element is not constant
     340 |                        ad7816_show_oti, ad7816_set_oti, 0);
         |                        ^~~~~~~~~~~~~~~
   include/linux/sysfs.h:233:19: note: in definition of macro '__ATTR'
     233 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/iio/sysfs.h:72:11: note: in expansion of macro 'IIO_ATTR'
      72 |         = IIO_ATTR(_name, _mode, _show, _store, _addr)
         |           ^~~~~~~~
   ad7816.c:339:8: note: in expansion of macro 'IIO_DEVICE_ATTR'
     339 | static IIO_DEVICE_ATTR(oti, 0644,
         |        ^~~~~~~~~~~~~~~
   ad7816.c:340:24: note: (near initialization for 'iio_dev_attr_oti.dev_attr.show')
     340 |                        ad7816_show_oti, ad7816_set_oti, 0);
         |                        ^~~~~~~~~~~~~~~
   include/linux/sysfs.h:233:19: note: in definition of macro '__ATTR'
     233 |         .show   = _show,                                                \
         |                   ^~~~~
   include/linux/iio/sysfs.h:72:11: note: in expansion of macro 'IIO_ATTR'
      72 |         = IIO_ATTR(_name, _mode, _show, _store, _addr)
         |           ^~~~~~~~
   ad7816.c:339:8: note: in expansion of macro 'IIO_DEVICE_ATTR'
     339 | static IIO_DEVICE_ATTR(oti, 0644,
         |        ^~~~~~~~~~~~~~~
   ad7816.c:340:41: error: initializer element is not constant
     340 |                        ad7816_show_oti, ad7816_set_oti, 0);
         |                                         ^~~~~~~~~~~~~~
   include/linux/sysfs.h:234:19: note: in definition of macro '__ATTR'
     234 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/iio/sysfs.h:72:11: note: in expansion of macro 'IIO_ATTR'
      72 |         = IIO_ATTR(_name, _mode, _show, _store, _addr)
         |           ^~~~~~~~
   ad7816.c:339:8: note: in expansion of macro 'IIO_DEVICE_ATTR'
     339 | static IIO_DEVICE_ATTR(oti, 0644,
         |        ^~~~~~~~~~~~~~~
   ad7816.c:340:41: note: (near initialization for 'iio_dev_attr_oti.dev_attr.store')
     340 |                        ad7816_show_oti, ad7816_set_oti, 0);
         |                                         ^~~~~~~~~~~~~~
   include/linux/sysfs.h:234:19: note: in definition of macro '__ATTR'
     234 |         .store  = _store,                                               \
         |                   ^~~~~~
   include/linux/iio/sysfs.h:72:11: note: in expansion of macro 'IIO_ATTR'
      72 |         = IIO_ATTR(_name, _mode, _show, _store, _addr)
         |           ^~~~~~~~
   ad7816.c:339:8: note: in expansion of macro 'IIO_DEVICE_ATTR'
     339 | static IIO_DEVICE_ATTR(oti, 0644,
         |        ^~~~~~~~~~~~~~~
   ad7816.c:361:12: error: invalid storage class for function 'ad7816_probe'
     361 | static int ad7816_probe(struct spi_device *spi_dev)
         |            ^~~~~~~~~~~~
   ad7816.c:442:1: warning: 'alias' attribute ignored [-Wattributes]
     442 | MODULE_DEVICE_TABLE(of, ad7816_of_match);
         | ^~~~~~~~~~~~~~~~~~~
   ad7816.c:451:1: warning: 'alias' attribute ignored [-Wattributes]
     451 | MODULE_DEVICE_TABLE(spi, ad7816_id);
         | ^~~~~~~~~~~~~~~~~~~
   ad7816.c:458:18: error: initializer element is not constant
     458 |         .probe = ad7816_probe,
         |                  ^~~~~~~~~~~~
   ad7816.c:458:18: note: (near initialization for 'ad7816_driver.probe')
   In file included from include/linux/device.h:32:
   ad7816.c:461:19: error: invalid storage class for function 'ad7816_driver_init'
     461 | module_spi_driver(ad7816_driver);
         |                   ^~~~~~~~~~~~~
   include/linux/device/driver.h:258:19: note: in definition of macro 'module_driver'
     258 | static int __init __driver##_init(void) \
         |                   ^~~~~~~~
   ad7816.c:461:1: note: in expansion of macro 'module_spi_driver'
     461 | module_spi_driver(ad7816_driver);
         | ^~~~~~~~~~~~~~~~~
   In file included from include/linux/device/driver.h:21:
>> include/linux/module.h:131:49: error: invalid storage class for function '__inittest'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:262:1: note: in expansion of macro 'module_init'
     262 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/spi/spi.h:387:9: note: in expansion of macro 'module_driver'
     387 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~
   ad7816.c:461:1: note: in expansion of macro 'module_spi_driver'
     461 | module_spi_driver(ad7816_driver);
         | ^~~~~~~~~~~~~~~~~
   ad7816.c:461:1: warning: 'alias' attribute ignored [-Wattributes]
   ad7816.c:461:19: error: invalid storage class for function 'ad7816_driver_exit'
     461 | module_spi_driver(ad7816_driver);
         |                   ^~~~~~~~~~~~~
   include/linux/device/driver.h:263:20: note: in definition of macro 'module_driver'
     263 | static void __exit __driver##_exit(void) \
         |                    ^~~~~~~~
   ad7816.c:461:1: note: in expansion of macro 'module_spi_driver'
     461 | module_spi_driver(ad7816_driver);
         | ^~~~~~~~~~~~~~~~~
>> include/linux/module.h:139:49: error: invalid storage class for function '__exittest'
     139 |         static inline exitcall_t __maybe_unused __exittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:267:1: note: in expansion of macro 'module_exit'
     267 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/spi/spi.h:387:9: note: in expansion of macro 'module_driver'
     387 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~
   ad7816.c:461:1: note: in expansion of macro 'module_spi_driver'
     461 | module_spi_driver(ad7816_driver);
         | ^~~~~~~~~~~~~~~~~
   ad7816.c:461:1: warning: 'alias' attribute ignored [-Wattributes]
   ad7816.c:465:1: error: expected declaration or statement at end of input
     465 | MODULE_LICENSE("GPL v2");
         | ^~~~~~~~~~~~~~
   ad7816.c: At top level:
   ad7816.c:193:16: warning: 'ad7816_store_channel' defined but not used [-Wunused-function]
     193 | static ssize_t ad7816_store_channel(struct device *dev,
         |                ^~~~~~~~~~~~~~~~~~~~


vim +/ad7816_show_value +222 drivers/staging/iio/adc/ad7816.c

7924425db04a61 Sonic Zhang          2010-10-27  192  
7924425db04a61 Sonic Zhang          2010-10-27 @193  static ssize_t ad7816_store_channel(struct device *dev,
7924425db04a61 Sonic Zhang          2010-10-27  194  				    struct device_attribute *attr,
7924425db04a61 Sonic Zhang          2010-10-27  195  				    const char *buf,
7924425db04a61 Sonic Zhang          2010-10-27  196  				    size_t len)
7924425db04a61 Sonic Zhang          2010-10-27  197  {
62c5183971428a Lars-Peter Clausen   2012-05-12  198  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
c746f5c9c52e03 Gabriel Shahrouzi    2025-04-18  199  	struct ad7816_state *chip = iio_priv(indio_dev);
7924425db04a61 Sonic Zhang          2010-10-27  200  	unsigned long data;
7924425db04a61 Sonic Zhang          2010-10-27  201  	int ret;
7924425db04a61 Sonic Zhang          2010-10-27  202  
f86f83622fe2c4 Aida Mynzhasova      2013-05-07  203  	ret = kstrtoul(buf, 10, &data);
7924425db04a61 Sonic Zhang          2010-10-27  204  	if (ret)
f86f83622fe2c4 Aida Mynzhasova      2013-05-07  205  		return ret;
7924425db04a61 Sonic Zhang          2010-10-27  206  
563a61a6448851 Gabriel Shahrouzi    2025-04-18  207  	if (data > chip->chip_info->max_channels && data != AD7816_CS_MASK) {
7924425db04a61 Sonic Zhang          2010-10-27  208  		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
563a61a6448851 Gabriel Shahrouzi    2025-04-18  209  			data, chip->chip_info->name);
7924425db04a61 Sonic Zhang          2010-10-27  210  		return -EINVAL;
7924425db04a61 Sonic Zhang          2010-10-27  211  
7924425db04a61 Sonic Zhang          2010-10-27  212  	chip->channel_id = data;
7924425db04a61 Sonic Zhang          2010-10-27  213  
7924425db04a61 Sonic Zhang          2010-10-27  214  	return len;
7924425db04a61 Sonic Zhang          2010-10-27  215  }
7924425db04a61 Sonic Zhang          2010-10-27  216  
7f47d56c5b0500 Julián de Gortari    2017-01-23  217  static IIO_DEVICE_ATTR(channel, 0644,
7924425db04a61 Sonic Zhang          2010-10-27  218  		ad7816_show_channel,
7924425db04a61 Sonic Zhang          2010-10-27  219  		ad7816_store_channel,
7924425db04a61 Sonic Zhang          2010-10-27  220  		0);
7924425db04a61 Sonic Zhang          2010-10-27  221  
7924425db04a61 Sonic Zhang          2010-10-27 @222  static ssize_t ad7816_show_value(struct device *dev,
7924425db04a61 Sonic Zhang          2010-10-27  223  				 struct device_attribute *attr,
7924425db04a61 Sonic Zhang          2010-10-27  224  				 char *buf)
7924425db04a61 Sonic Zhang          2010-10-27  225  {
62c5183971428a Lars-Peter Clausen   2012-05-12  226  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
c746f5c9c52e03 Gabriel Shahrouzi    2025-04-18  227  	struct ad7816_state *chip = iio_priv(indio_dev);
7924425db04a61 Sonic Zhang          2010-10-27  228  	u16 data;
7924425db04a61 Sonic Zhang          2010-10-27  229  	s8 value;
7924425db04a61 Sonic Zhang          2010-10-27  230  	int ret;
7924425db04a61 Sonic Zhang          2010-10-27  231  
7924425db04a61 Sonic Zhang          2010-10-27  232  	ret = ad7816_spi_read(chip, &data);
7924425db04a61 Sonic Zhang          2010-10-27  233  	if (ret)
7924425db04a61 Sonic Zhang          2010-10-27  234  		return -EIO;
7924425db04a61 Sonic Zhang          2010-10-27  235  
7924425db04a61 Sonic Zhang          2010-10-27  236  	data >>= AD7816_VALUE_OFFSET;
7924425db04a61 Sonic Zhang          2010-10-27  237  
7924425db04a61 Sonic Zhang          2010-10-27  238  	if (chip->channel_id == 0) {
7924425db04a61 Sonic Zhang          2010-10-27  239  		value = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
7924425db04a61 Sonic Zhang          2010-10-27  240  		data &= AD7816_TEMP_FLOAT_MASK;
7924425db04a61 Sonic Zhang          2010-10-27  241  		if (value < 0)
e7c3d05459673d Payal Kshirsagar     2019-04-02  242  			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
7924425db04a61 Sonic Zhang          2010-10-27  243  		return sprintf(buf, "%d.%.2d\n", value, data * 25);
da96aecdc59d08 Vaishali Thakkar     2014-09-25  244  	}
7924425db04a61 Sonic Zhang          2010-10-27  245  	return sprintf(buf, "%u\n", data);
7924425db04a61 Sonic Zhang          2010-10-27  246  }
7924425db04a61 Sonic Zhang          2010-10-27  247  
7f47d56c5b0500 Julián de Gortari    2017-01-23 @248  static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
7924425db04a61 Sonic Zhang          2010-10-27  249  
7924425db04a61 Sonic Zhang          2010-10-27  250  static struct attribute *ad7816_attributes[] = {
7924425db04a61 Sonic Zhang          2010-10-27  251  	&iio_dev_attr_available_modes.dev_attr.attr,
7924425db04a61 Sonic Zhang          2010-10-27  252  	&iio_dev_attr_mode.dev_attr.attr,
7924425db04a61 Sonic Zhang          2010-10-27  253  	&iio_dev_attr_channel.dev_attr.attr,
7924425db04a61 Sonic Zhang          2010-10-27  254  	&iio_dev_attr_value.dev_attr.attr,
7924425db04a61 Sonic Zhang          2010-10-27  255  	NULL,
7924425db04a61 Sonic Zhang          2010-10-27  256  };
7924425db04a61 Sonic Zhang          2010-10-27  257  
7924425db04a61 Sonic Zhang          2010-10-27  258  static const struct attribute_group ad7816_attribute_group = {
7924425db04a61 Sonic Zhang          2010-10-27  259  	.attrs = ad7816_attributes,
7924425db04a61 Sonic Zhang          2010-10-27  260  };
7924425db04a61 Sonic Zhang          2010-10-27  261  
7924425db04a61 Sonic Zhang          2010-10-27  262  /*
7924425db04a61 Sonic Zhang          2010-10-27  263   * temperature bound events
7924425db04a61 Sonic Zhang          2010-10-27  264   */
7924425db04a61 Sonic Zhang          2010-10-27  265  
c4b14d99bbc93c Jonathan Cameron     2011-08-12  266  #define IIO_EVENT_CODE_AD7816_OTI IIO_UNMOD_EVENT_CODE(IIO_TEMP,	\
0bb8be643161ae Jonathan Cameron     2011-05-18  267  						       0,		\
0bb8be643161ae Jonathan Cameron     2011-05-18  268  						       IIO_EV_TYPE_THRESH, \
0bb8be643161ae Jonathan Cameron     2011-05-18  269  						       IIO_EV_DIR_FALLING)
7924425db04a61 Sonic Zhang          2010-10-27  270  
db9afe2fc0c59f Jonathan Cameron     2011-05-18 @271  static irqreturn_t ad7816_event_handler(int irq, void *private)
7924425db04a61 Sonic Zhang          2010-10-27  272  {
bc2b7dab629a51 Gregor Boirie        2016-03-09  273  	iio_push_event(private, IIO_EVENT_CODE_AD7816_OTI,
bd28425a307417 Arushi Singhal       2018-03-07  274  		       iio_get_time_ns(private));
db9afe2fc0c59f Jonathan Cameron     2011-05-18  275  	return IRQ_HANDLED;
7924425db04a61 Sonic Zhang          2010-10-27  276  }
7924425db04a61 Sonic Zhang          2010-10-27  277  
7924425db04a61 Sonic Zhang          2010-10-27 @278  static ssize_t ad7816_show_oti(struct device *dev,
7924425db04a61 Sonic Zhang          2010-10-27  279  			       struct device_attribute *attr,
7924425db04a61 Sonic Zhang          2010-10-27  280  			       char *buf)
7924425db04a61 Sonic Zhang          2010-10-27  281  {
62c5183971428a Lars-Peter Clausen   2012-05-12  282  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
c746f5c9c52e03 Gabriel Shahrouzi    2025-04-18  283  	struct ad7816_state *chip = iio_priv(indio_dev);
7924425db04a61 Sonic Zhang          2010-10-27  284  	int value;
7924425db04a61 Sonic Zhang          2010-10-27  285  
7924425db04a61 Sonic Zhang          2010-10-27  286  	if (chip->channel_id > AD7816_CS_MAX) {
7924425db04a61 Sonic Zhang          2010-10-27  287  		dev_err(dev, "Invalid oti channel id %d.\n", chip->channel_id);
7924425db04a61 Sonic Zhang          2010-10-27  288  		return -EINVAL;
7924425db04a61 Sonic Zhang          2010-10-27  289  	} else if (chip->channel_id == 0) {
7924425db04a61 Sonic Zhang          2010-10-27  290  		value = AD7816_BOUND_VALUE_MIN +
7924425db04a61 Sonic Zhang          2010-10-27  291  			(chip->oti_data[chip->channel_id] -
7924425db04a61 Sonic Zhang          2010-10-27  292  			AD7816_BOUND_VALUE_BASE);
7924425db04a61 Sonic Zhang          2010-10-27  293  		return sprintf(buf, "%d\n", value);
da96aecdc59d08 Vaishali Thakkar     2014-09-25  294  	}
7924425db04a61 Sonic Zhang          2010-10-27  295  	return sprintf(buf, "%u\n", chip->oti_data[chip->channel_id]);
7924425db04a61 Sonic Zhang          2010-10-27  296  }
7924425db04a61 Sonic Zhang          2010-10-27  297  
7924425db04a61 Sonic Zhang          2010-10-27 @298  static inline ssize_t ad7816_set_oti(struct device *dev,
7924425db04a61 Sonic Zhang          2010-10-27  299  				     struct device_attribute *attr,
7924425db04a61 Sonic Zhang          2010-10-27  300  				     const char *buf,
7924425db04a61 Sonic Zhang          2010-10-27  301  				     size_t len)
7924425db04a61 Sonic Zhang          2010-10-27  302  {
62c5183971428a Lars-Peter Clausen   2012-05-12  303  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
c746f5c9c52e03 Gabriel Shahrouzi    2025-04-18  304  	struct ad7816_state *chip = iio_priv(indio_dev);
7924425db04a61 Sonic Zhang          2010-10-27  305  	long value;
7924425db04a61 Sonic Zhang          2010-10-27  306  	u8 data;
7924425db04a61 Sonic Zhang          2010-10-27  307  	int ret;
7924425db04a61 Sonic Zhang          2010-10-27  308  
f86f83622fe2c4 Aida Mynzhasova      2013-05-07  309  	ret = kstrtol(buf, 10, &value);
f86f83622fe2c4 Aida Mynzhasova      2013-05-07  310  	if (ret)
f86f83622fe2c4 Aida Mynzhasova      2013-05-07  311  		return ret;
7924425db04a61 Sonic Zhang          2010-10-27  312  
7924425db04a61 Sonic Zhang          2010-10-27  313  	if (chip->channel_id > AD7816_CS_MAX) {
7924425db04a61 Sonic Zhang          2010-10-27  314  		dev_err(dev, "Invalid oti channel id %d.\n", chip->channel_id);
7924425db04a61 Sonic Zhang          2010-10-27  315  		return -EINVAL;
7924425db04a61 Sonic Zhang          2010-10-27  316  	} else if (chip->channel_id == 0) {
0fd736f9f4d2ae Amitoj Kaur Chawla   2016-02-16  317  		if (value < AD7816_BOUND_VALUE_MIN ||
7924425db04a61 Sonic Zhang          2010-10-27  318  		    value > AD7816_BOUND_VALUE_MAX)
7924425db04a61 Sonic Zhang          2010-10-27  319  			return -EINVAL;
7924425db04a61 Sonic Zhang          2010-10-27  320  
7924425db04a61 Sonic Zhang          2010-10-27  321  		data = (u8)(value - AD7816_BOUND_VALUE_MIN +
7924425db04a61 Sonic Zhang          2010-10-27  322  			AD7816_BOUND_VALUE_BASE);
7924425db04a61 Sonic Zhang          2010-10-27  323  	} else {
0fd736f9f4d2ae Amitoj Kaur Chawla   2016-02-16  324  		if (value < AD7816_BOUND_VALUE_BASE || value > 255)
7924425db04a61 Sonic Zhang          2010-10-27  325  			return -EINVAL;
7924425db04a61 Sonic Zhang          2010-10-27  326  
7924425db04a61 Sonic Zhang          2010-10-27  327  		data = (u8)value;
7924425db04a61 Sonic Zhang          2010-10-27  328  	}
7924425db04a61 Sonic Zhang          2010-10-27  329  
7924425db04a61 Sonic Zhang          2010-10-27  330  	ret = ad7816_spi_write(chip, data);
7924425db04a61 Sonic Zhang          2010-10-27  331  	if (ret)
7924425db04a61 Sonic Zhang          2010-10-27  332  		return -EIO;
7924425db04a61 Sonic Zhang          2010-10-27  333  
7924425db04a61 Sonic Zhang          2010-10-27  334  	chip->oti_data[chip->channel_id] = data;
7924425db04a61 Sonic Zhang          2010-10-27  335  
7924425db04a61 Sonic Zhang          2010-10-27  336  	return len;
7924425db04a61 Sonic Zhang          2010-10-27  337  }
7924425db04a61 Sonic Zhang          2010-10-27  338  
7f47d56c5b0500 Julián de Gortari    2017-01-23 @339  static IIO_DEVICE_ATTR(oti, 0644,
7924425db04a61 Sonic Zhang          2010-10-27  340  		       ad7816_show_oti, ad7816_set_oti, 0);
7924425db04a61 Sonic Zhang          2010-10-27  341  
7924425db04a61 Sonic Zhang          2010-10-27  342  static struct attribute *ad7816_event_attributes[] = {
db9afe2fc0c59f Jonathan Cameron     2011-05-18  343  	&iio_dev_attr_oti.dev_attr.attr,
7924425db04a61 Sonic Zhang          2010-10-27  344  	NULL,
7924425db04a61 Sonic Zhang          2010-10-27  345  };
7924425db04a61 Sonic Zhang          2010-10-27  346  
0fa90023f23ced Bhumika Goyal        2016-10-02  347  static const struct attribute_group ad7816_event_attribute_group = {
7924425db04a61 Sonic Zhang          2010-10-27  348  	.attrs = ad7816_event_attributes,
8e7d967244a8ee Jonathan Cameron     2011-08-30  349  	.name = "events",
7924425db04a61 Sonic Zhang          2010-10-27  350  };
7924425db04a61 Sonic Zhang          2010-10-27  351  
6fe8135fccd66a Jonathan Cameron     2011-05-18  352  static const struct iio_info ad7816_info = {
6fe8135fccd66a Jonathan Cameron     2011-05-18  353  	.attrs = &ad7816_attribute_group,
6fe8135fccd66a Jonathan Cameron     2011-05-18  354  	.event_attrs = &ad7816_event_attribute_group,
6fe8135fccd66a Jonathan Cameron     2011-05-18  355  };
6fe8135fccd66a Jonathan Cameron     2011-05-18  356  
7924425db04a61 Sonic Zhang          2010-10-27  357  /*
7924425db04a61 Sonic Zhang          2010-10-27  358   * device probe and remove
7924425db04a61 Sonic Zhang          2010-10-27  359   */
7924425db04a61 Sonic Zhang          2010-10-27  360  
4ae1c61ff2ba4f Bill Pemberton       2012-11-19 @361  static int ad7816_probe(struct spi_device *spi_dev)
7924425db04a61 Sonic Zhang          2010-10-27  362  {
c746f5c9c52e03 Gabriel Shahrouzi    2025-04-18  363  	struct ad7816_state *chip;
b0011d6dbae18a Jonathan Cameron     2011-06-27  364  	struct iio_dev *indio_dev;
fc79e5b62248ee Gabriel Shahrouzi    2025-04-18  365  	const struct ad7816_chip_info *info;
f1b753a0f866a8 Hardik Singh Rathore 2018-12-12  366  	int i, ret;
7924425db04a61 Sonic Zhang          2010-10-27  367  
e5bf4f5b7d95ff Sachin Kamat         2013-08-31  368  	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
e5bf4f5b7d95ff Sachin Kamat         2013-08-31  369  	if (!indio_dev)
e5bf4f5b7d95ff Sachin Kamat         2013-08-31  370  		return -ENOMEM;
b0011d6dbae18a Jonathan Cameron     2011-06-27  371  	chip = iio_priv(indio_dev);
7924425db04a61 Sonic Zhang          2010-10-27  372  	/* this is only used for device removal purposes */
b0011d6dbae18a Jonathan Cameron     2011-06-27  373  	dev_set_drvdata(&spi_dev->dev, indio_dev);
7924425db04a61 Sonic Zhang          2010-10-27  374  
fc79e5b62248ee Gabriel Shahrouzi    2025-04-18  375  	info = device_get_match_data(&spi_dev->dev);
fc79e5b62248ee Gabriel Shahrouzi    2025-04-18  376  	if (!info)
fc79e5b62248ee Gabriel Shahrouzi    2025-04-18  377  		return -ENODEV;
fc79e5b62248ee Gabriel Shahrouzi    2025-04-18  378  	chip->chip_info = info;
fc79e5b62248ee Gabriel Shahrouzi    2025-04-18  379  
7924425db04a61 Sonic Zhang          2010-10-27  380  	chip->spi_dev = spi_dev;
7924425db04a61 Sonic Zhang          2010-10-27  381  	for (i = 0; i <= AD7816_CS_MAX; i++)
7924425db04a61 Sonic Zhang          2010-10-27  382  		chip->oti_data[i] = 203;
073a391ca0352d Nishad Kamdar        2018-10-17  383  
72e3a5248da904 Nishad Kamdar        2018-11-09  384  	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
073a391ca0352d Nishad Kamdar        2018-10-17  385  	if (IS_ERR(chip->rdwr_pin)) {
073a391ca0352d Nishad Kamdar        2018-10-17  386  		ret = PTR_ERR(chip->rdwr_pin);
073a391ca0352d Nishad Kamdar        2018-10-17  387  		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
073a391ca0352d Nishad Kamdar        2018-10-17  388  			ret);
e5bf4f5b7d95ff Sachin Kamat         2013-08-31  389  		return ret;
7924425db04a61 Sonic Zhang          2010-10-27  390  	}
72e3a5248da904 Nishad Kamdar        2018-11-09  391  	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert",
72e3a5248da904 Nishad Kamdar        2018-11-09  392  					   GPIOD_OUT_HIGH);
073a391ca0352d Nishad Kamdar        2018-10-17  393  	if (IS_ERR(chip->convert_pin)) {
073a391ca0352d Nishad Kamdar        2018-10-17  394  		ret = PTR_ERR(chip->convert_pin);
073a391ca0352d Nishad Kamdar        2018-10-17  395  		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
073a391ca0352d Nishad Kamdar        2018-10-17  396  			ret);
e5bf4f5b7d95ff Sachin Kamat         2013-08-31  397  		return ret;
7924425db04a61 Sonic Zhang          2010-10-27  398  	}
fc79e5b62248ee Gabriel Shahrouzi    2025-04-18  399  	if (chip->chip_info == &ad7816_info_ad7816 || chip->chip_info == &ad7817_info_ad7817) {
06c77f564ddb6a Nishad Kamdar        2018-11-09  400  		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
06c77f564ddb6a Nishad Kamdar        2018-11-09  401  						GPIOD_IN);
073a391ca0352d Nishad Kamdar        2018-10-17  402  		if (IS_ERR(chip->busy_pin)) {
073a391ca0352d Nishad Kamdar        2018-10-17  403  			ret = PTR_ERR(chip->busy_pin);
073a391ca0352d Nishad Kamdar        2018-10-17  404  			dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
073a391ca0352d Nishad Kamdar        2018-10-17  405  				ret);
e5bf4f5b7d95ff Sachin Kamat         2013-08-31  406  			return ret;
7924425db04a61 Sonic Zhang          2010-10-27  407  		}
06c77f564ddb6a Nishad Kamdar        2018-11-09  408  	}
7924425db04a61 Sonic Zhang          2010-10-27  409  
fc79e5b62248ee Gabriel Shahrouzi    2025-04-18  410  	indio_dev->name = chip->chip_info->name;
b0011d6dbae18a Jonathan Cameron     2011-06-27  411  	indio_dev->info = &ad7816_info;
b0011d6dbae18a Jonathan Cameron     2011-06-27  412  	indio_dev->modes = INDIO_DIRECT_MODE;
7924425db04a61 Sonic Zhang          2010-10-27  413  
7924425db04a61 Sonic Zhang          2010-10-27  414  	if (spi_dev->irq) {
7924425db04a61 Sonic Zhang          2010-10-27  415  		/* Only low trigger is supported in ad7816/7/8 */
e5bf4f5b7d95ff Sachin Kamat         2013-08-31  416  		ret = devm_request_threaded_irq(&spi_dev->dev, spi_dev->irq,
db9afe2fc0c59f Jonathan Cameron     2011-05-18  417  						NULL,
db9afe2fc0c59f Jonathan Cameron     2011-05-18  418  						&ad7816_event_handler,
a91aff1c09fc41 Lars-Peter Clausen   2012-07-02  419  						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
b0011d6dbae18a Jonathan Cameron     2011-06-27  420  						indio_dev->name,
b0011d6dbae18a Jonathan Cameron     2011-06-27  421  						indio_dev);
7924425db04a61 Sonic Zhang          2010-10-27  422  		if (ret)
e5bf4f5b7d95ff Sachin Kamat         2013-08-31  423  			return ret;
7924425db04a61 Sonic Zhang          2010-10-27  424  	}
7924425db04a61 Sonic Zhang          2010-10-27  425  
5404dc77266e31 Sachin Kamat         2013-10-29  426  	ret = devm_iio_device_register(&spi_dev->dev, indio_dev);
26d25ae3f0d8ff Jonathan Cameron     2011-09-02  427  	if (ret)
e5bf4f5b7d95ff Sachin Kamat         2013-08-31  428  		return ret;
26d25ae3f0d8ff Jonathan Cameron     2011-09-02  429  
7924425db04a61 Sonic Zhang          2010-10-27  430  	dev_info(&spi_dev->dev, "%s temperature sensor and ADC registered.\n",
b0011d6dbae18a Jonathan Cameron     2011-06-27  431  		 indio_dev->name);
7924425db04a61 Sonic Zhang          2010-10-27  432  
7924425db04a61 Sonic Zhang          2010-10-27  433  	return 0;
7924425db04a61 Sonic Zhang          2010-10-27  434  }
7924425db04a61 Sonic Zhang          2010-10-27  435  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

