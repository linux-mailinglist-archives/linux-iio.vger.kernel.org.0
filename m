Return-Path: <linux-iio+bounces-18321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04298A94386
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 15:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E205417BAF0
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E461DB366;
	Sat, 19 Apr 2025 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6nmz5PP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF71D86C3;
	Sat, 19 Apr 2025 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745068357; cv=none; b=i1rE8v0cG3KkdkJ27KfHu4CzQHI9Ji5Q102iO2OlkC1qB8l1wPFwoMJPnshcVg+2culjqXsJfJmnfvHnMPC0St+hN+ScEOl00IaPkiy3siKVRQPIpYLqAdsejouzjC4x5Z9/Fi0Q8dMw8Zwse+OL0+7+Wg0zejpwqTvCQsbuTKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745068357; c=relaxed/simple;
	bh=wNUEvYQdkR8iidUtULYhZ4YeqQhyodx7Sc4KRntmMgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR9ZMi6wPiUBXwU183qegwsKYuYBPh7l2aw/bXRmsw4aUwBwKo1+1k4e0bxhbLScvrX8aooUfKTWne0GagywB0lZux/oWwfIvk53bujmS3YsIe2ez7dFBdwNhpc8Q4mtPk9lmtKcRXyimBE9ie58FQyk6fTme4pxAY5NBC3YTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6nmz5PP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745068355; x=1776604355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wNUEvYQdkR8iidUtULYhZ4YeqQhyodx7Sc4KRntmMgI=;
  b=g6nmz5PPuRwy+tIBWnl0NVNkP/l+60/mDS8f+EUJ6r/qlxXuBhs9hiYo
   1U2Yf9FKRIy1vPQn4581z8hj++6Jqyo2y1wyCxHMoqRUjg8bzT2NMQGbx
   x4msGlMrkBze5edhtjiDJL/jgM67VmbA7dj0PzoNwfkp/w34SDrkLPOp1
   DCxEIs61wNooI+fN9CvAcoAlICsl03O77coXr1xsVR1YNagq8+zseFc50
   3FR1pcZz4+HXd27uqRL7ZilC7ouE8eVQZU/T4iOoaKExTpHAhCYH6bYEx
   w6TSQYqRwsmTowzUREwUK7pnpnTmDkrE0OrgMl+dLHZgXLasrs3ybUhsP
   g==;
X-CSE-ConnectionGUID: rZd1pSJJSBuW1ysWXbHgeA==
X-CSE-MsgGUID: +kJLftkmTemW3mOrixTKgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="46802241"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="46802241"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 06:12:34 -0700
X-CSE-ConnectionGUID: qkt5/W5dQqah4B/5zxay2g==
X-CSE-MsgGUID: ezt3tp0PTEuWkKPVoflClg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="131630847"
Received: from lkp-server01.sh.intel.com (HELO 61e10e65ea0f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 19 Apr 2025 06:12:30 -0700
Received: from kbuild by 61e10e65ea0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u67zg-0003sX-0P;
	Sat, 19 Apr 2025 13:12:28 +0000
Date: Sat, 19 Apr 2025 21:11:59 +0800
From: kernel test robot <lkp@intel.com>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>, gregkh@linuxfoundation.org,
	jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com, sonic.zhang@analog.com,
	vapier@gentoo.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gshahrouzi@gmail.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 5/5] staging: iio: adc: ad7816: Simplify channel
 validation using chip_info
Message-ID: <202504192054.5XE1L0Lo-lkp@intel.com>
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
config: powerpc64-randconfig-003-20250419 (https://download.01.org/0day-ci/archive/20250419/202504192054.5XE1L0Lo-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250419/202504192054.5XE1L0Lo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504192054.5XE1L0Lo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/iio/adc/ad7816.c:225:1: error: function definition is not allowed here
     225 | {
         | ^
>> drivers/staging/iio/adc/ad7816.c:248:37: error: use of undeclared identifier 'ad7816_show_value'; did you mean 'ad7816_show_mode'?
     248 | static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
         |                                     ^~~~~~~~~~~~~~~~~
         |                                     ad7816_show_mode
   include/linux/iio/sysfs.h:72:27: note: expanded from macro 'IIO_DEVICE_ATTR'
      72 |         = IIO_ATTR(_name, _mode, _show, _store, _addr)
         |                                  ^
   include/linux/iio/sysfs.h:55:37: note: expanded from macro 'IIO_ATTR'
      55 |         { .dev_attr = __ATTR(_name, _mode, _show, _store),      \
         |                                            ^
   include/linux/sysfs.h:233:10: note: expanded from macro '__ATTR'
     233 |         .show   = _show,                                                \
         |                   ^
   drivers/staging/iio/adc/ad7816.c:137:16: note: 'ad7816_show_mode' declared here
     137 | static ssize_t ad7816_show_mode(struct device *dev,
         |                ^
   drivers/staging/iio/adc/ad7816.c:272:1: error: function definition is not allowed here
     272 | {
         | ^
   drivers/staging/iio/adc/ad7816.c:281:1: error: function definition is not allowed here
     281 | {
         | ^
   drivers/staging/iio/adc/ad7816.c:302:1: error: function definition is not allowed here
     302 | {
         | ^
>> drivers/staging/iio/adc/ad7816.c:340:10: error: use of undeclared identifier 'ad7816_show_oti'; did you mean 'ad7816_show_mode'?
     340 |                        ad7816_show_oti, ad7816_set_oti, 0);
         |                        ^~~~~~~~~~~~~~~
         |                        ad7816_show_mode
   include/linux/iio/sysfs.h:72:27: note: expanded from macro 'IIO_DEVICE_ATTR'
      72 |         = IIO_ATTR(_name, _mode, _show, _store, _addr)
         |                                  ^
   include/linux/iio/sysfs.h:55:37: note: expanded from macro 'IIO_ATTR'
      55 |         { .dev_attr = __ATTR(_name, _mode, _show, _store),      \
         |                                            ^
   include/linux/sysfs.h:233:10: note: expanded from macro '__ATTR'
     233 |         .show   = _show,                                                \
         |                   ^
   drivers/staging/iio/adc/ad7816.c:137:16: note: 'ad7816_show_mode' declared here
     137 | static ssize_t ad7816_show_mode(struct device *dev,
         |                ^
>> drivers/staging/iio/adc/ad7816.c:340:27: error: use of undeclared identifier 'ad7816_set_oti'
     340 |                        ad7816_show_oti, ad7816_set_oti, 0);
         |                                         ^
   drivers/staging/iio/adc/ad7816.c:362:1: error: function definition is not allowed here
     362 | {
         | ^
>> drivers/staging/iio/adc/ad7816.c:458:11: error: use of undeclared identifier 'ad7816_probe'; did you mean 'ad7816_driver'?
     458 |         .probe = ad7816_probe,
         |                  ^~~~~~~~~~~~
         |                  ad7816_driver
   drivers/staging/iio/adc/ad7816.c:453:26: note: 'ad7816_driver' declared here
     453 | static struct spi_driver ad7816_driver = {
         |                          ^
>> drivers/staging/iio/adc/ad7816.c:458:11: error: initializing 'int (*)(struct spi_device *)' with an expression of incompatible type 'struct spi_driver'
     458 |         .probe = ad7816_probe,
         |                  ^~~~~~~~~~~~
   drivers/staging/iio/adc/ad7816.c:461:1: error: function definition is not allowed here
     461 | module_spi_driver(ad7816_driver);
         | ^
   include/linux/spi/spi.h:387:2: note: expanded from macro 'module_spi_driver'
     387 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^
   include/linux/device/driver.h:258:41: note: expanded from macro 'module_driver'
     258 | static int __init __driver##_init(void) \
         |                                         ^
>> drivers/staging/iio/adc/ad7816.c:461:1: error: use of undeclared identifier 'ad7816_driver_init'; did you mean 'ad7816_driver'?
   include/linux/spi/spi.h:387:2: note: expanded from macro 'module_spi_driver'
     387 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^
   include/linux/device/driver.h:262:13: note: expanded from macro 'module_driver'
     262 | module_init(__driver##_init); \
         |             ^
   <scratch space>:91:1: note: expanded from here
      91 | ad7816_driver_init
         | ^
   drivers/staging/iio/adc/ad7816.c:453:26: note: 'ad7816_driver' declared here
     453 | static struct spi_driver ad7816_driver = {
         |                          ^
>> drivers/staging/iio/adc/ad7816.c:461:1: error: initializing 'initcall_t' (aka 'int (*)(void)') with an expression of incompatible type 'struct spi_driver'
     461 | module_spi_driver(ad7816_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spi/spi.h:387:2: note: expanded from macro 'module_spi_driver'
     387 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     388 |                         spi_unregister_driver)
         |                         ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:261:3: note: expanded from macro 'module_driver'
     261 | } \
         |   ^
     262 | module_init(__driver##_init); \
         |             ~~~~~~~~~~~~~~~
   include/linux/module.h:88:24: note: expanded from macro '\
   module_init'
      88 | #define module_init(x)  __initcall(x);
         |                         ^          ~
   note: (skipping 7 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:104:1: note: expanded from here
     104 | __initcall__kmod_ad7816__326_461_ad7816_driver_init6
         | ^
   include/linux/init.h:269:20: note: expanded from macro '____define_initcall'
     269 |         static initcall_t __name __used                         \
         |                           ^
     270 |                 __attribute__((__section__(__sec))) = fn;
         |                                                       ~~
   drivers/staging/iio/adc/ad7816.c:461:1: error: function definition is not allowed here
   include/linux/spi/spi.h:387:2: note: expanded from macro 'module_spi_driver'
     387 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^
   include/linux/device/driver.h:263:42: note: expanded from macro 'module_driver'
     263 | static void __exit __driver##_exit(void) \
         |                                          ^
>> drivers/staging/iio/adc/ad7816.c:461:1: error: use of undeclared identifier 'ad7816_driver_exit'; did you mean 'ad7816_driver'?
   include/linux/spi/spi.h:387:2: note: expanded from macro 'module_spi_driver'
     387 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^
   include/linux/device/driver.h:267:13: note: expanded from macro 'module_driver'
     267 | module_exit(__driver##_exit);
         |             ^
   <scratch space>:107:1: note: expanded from here
     107 | ad7816_driver_exit
         | ^
   drivers/staging/iio/adc/ad7816.c:453:26: note: 'ad7816_driver' declared here
     453 | static struct spi_driver ad7816_driver = {
         |                          ^
>> drivers/staging/iio/adc/ad7816.c:461:1: error: initializing 'exitcall_t' (aka 'void (*)(void)') with an expression of incompatible type 'struct spi_driver'
     461 | module_spi_driver(ad7816_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spi/spi.h:387:2: note: expanded from macro 'module_spi_driver'
     387 |         module_driver(__spi_driver, spi_register_driver, \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     388 |                         spi_unregister_driver)
         |                         ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:266:3: note: expanded from macro 'module_driver'
     266 | } \
         |   ^
     267 | module_exit(__driver##_exit);
         |             ~~~~~~~~~~~~~~~
   include/linux/module.h:100:24: note: expanded from macro '\
   module_exit'
     100 | #define module_exit(x)  __exitcall(x);
         |                         ^          ~
   include/linux/init.h:319:20: note: expanded from macro '__exitcall'
     319 |         static exitcall_t __exitcall_##fn __exit_call = fn
         |                           ^                             ~~
   <scratch space>:108:1: note: expanded from here
     108 | __exitcall_ad7816_driver_exit
         | ^
>> drivers/staging/iio/adc/ad7816.c:465:26: error: expected '}'
     465 | MODULE_LICENSE("GPL v2");
         |                          ^
   drivers/staging/iio/adc/ad7816.c:197:1: note: to match this '{'
     197 | {
         | ^
   17 errors generated.


vim +225 drivers/staging/iio/adc/ad7816.c

7924425db04a61 Sonic Zhang        2010-10-27  216  
7f47d56c5b0500 Julián de Gortari  2017-01-23  217  static IIO_DEVICE_ATTR(channel, 0644,
7924425db04a61 Sonic Zhang        2010-10-27  218  		ad7816_show_channel,
7924425db04a61 Sonic Zhang        2010-10-27  219  		ad7816_store_channel,
7924425db04a61 Sonic Zhang        2010-10-27  220  		0);
7924425db04a61 Sonic Zhang        2010-10-27  221  
7924425db04a61 Sonic Zhang        2010-10-27  222  static ssize_t ad7816_show_value(struct device *dev,
7924425db04a61 Sonic Zhang        2010-10-27  223  				 struct device_attribute *attr,
7924425db04a61 Sonic Zhang        2010-10-27  224  				 char *buf)
7924425db04a61 Sonic Zhang        2010-10-27 @225  {
62c5183971428a Lars-Peter Clausen 2012-05-12  226  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
c746f5c9c52e03 Gabriel Shahrouzi  2025-04-18  227  	struct ad7816_state *chip = iio_priv(indio_dev);
7924425db04a61 Sonic Zhang        2010-10-27  228  	u16 data;
7924425db04a61 Sonic Zhang        2010-10-27  229  	s8 value;
7924425db04a61 Sonic Zhang        2010-10-27  230  	int ret;
7924425db04a61 Sonic Zhang        2010-10-27  231  
7924425db04a61 Sonic Zhang        2010-10-27  232  	ret = ad7816_spi_read(chip, &data);
7924425db04a61 Sonic Zhang        2010-10-27  233  	if (ret)
7924425db04a61 Sonic Zhang        2010-10-27  234  		return -EIO;
7924425db04a61 Sonic Zhang        2010-10-27  235  
7924425db04a61 Sonic Zhang        2010-10-27  236  	data >>= AD7816_VALUE_OFFSET;
7924425db04a61 Sonic Zhang        2010-10-27  237  
7924425db04a61 Sonic Zhang        2010-10-27  238  	if (chip->channel_id == 0) {
7924425db04a61 Sonic Zhang        2010-10-27  239  		value = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
7924425db04a61 Sonic Zhang        2010-10-27  240  		data &= AD7816_TEMP_FLOAT_MASK;
7924425db04a61 Sonic Zhang        2010-10-27  241  		if (value < 0)
e7c3d05459673d Payal Kshirsagar   2019-04-02  242  			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
7924425db04a61 Sonic Zhang        2010-10-27  243  		return sprintf(buf, "%d.%.2d\n", value, data * 25);
da96aecdc59d08 Vaishali Thakkar   2014-09-25  244  	}
7924425db04a61 Sonic Zhang        2010-10-27  245  	return sprintf(buf, "%u\n", data);
7924425db04a61 Sonic Zhang        2010-10-27  246  }
7924425db04a61 Sonic Zhang        2010-10-27  247  
7f47d56c5b0500 Julián de Gortari  2017-01-23 @248  static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
7924425db04a61 Sonic Zhang        2010-10-27  249  
7924425db04a61 Sonic Zhang        2010-10-27  250  static struct attribute *ad7816_attributes[] = {
7924425db04a61 Sonic Zhang        2010-10-27  251  	&iio_dev_attr_available_modes.dev_attr.attr,
7924425db04a61 Sonic Zhang        2010-10-27  252  	&iio_dev_attr_mode.dev_attr.attr,
7924425db04a61 Sonic Zhang        2010-10-27  253  	&iio_dev_attr_channel.dev_attr.attr,
7924425db04a61 Sonic Zhang        2010-10-27  254  	&iio_dev_attr_value.dev_attr.attr,
7924425db04a61 Sonic Zhang        2010-10-27  255  	NULL,
7924425db04a61 Sonic Zhang        2010-10-27  256  };
7924425db04a61 Sonic Zhang        2010-10-27  257  
7924425db04a61 Sonic Zhang        2010-10-27  258  static const struct attribute_group ad7816_attribute_group = {
7924425db04a61 Sonic Zhang        2010-10-27  259  	.attrs = ad7816_attributes,
7924425db04a61 Sonic Zhang        2010-10-27  260  };
7924425db04a61 Sonic Zhang        2010-10-27  261  
7924425db04a61 Sonic Zhang        2010-10-27  262  /*
7924425db04a61 Sonic Zhang        2010-10-27  263   * temperature bound events
7924425db04a61 Sonic Zhang        2010-10-27  264   */
7924425db04a61 Sonic Zhang        2010-10-27  265  
c4b14d99bbc93c Jonathan Cameron   2011-08-12  266  #define IIO_EVENT_CODE_AD7816_OTI IIO_UNMOD_EVENT_CODE(IIO_TEMP,	\
0bb8be643161ae Jonathan Cameron   2011-05-18  267  						       0,		\
0bb8be643161ae Jonathan Cameron   2011-05-18  268  						       IIO_EV_TYPE_THRESH, \
0bb8be643161ae Jonathan Cameron   2011-05-18  269  						       IIO_EV_DIR_FALLING)
7924425db04a61 Sonic Zhang        2010-10-27  270  
db9afe2fc0c59f Jonathan Cameron   2011-05-18  271  static irqreturn_t ad7816_event_handler(int irq, void *private)
7924425db04a61 Sonic Zhang        2010-10-27  272  {
bc2b7dab629a51 Gregor Boirie      2016-03-09  273  	iio_push_event(private, IIO_EVENT_CODE_AD7816_OTI,
bd28425a307417 Arushi Singhal     2018-03-07  274  		       iio_get_time_ns(private));
db9afe2fc0c59f Jonathan Cameron   2011-05-18  275  	return IRQ_HANDLED;
7924425db04a61 Sonic Zhang        2010-10-27  276  }
7924425db04a61 Sonic Zhang        2010-10-27  277  
7924425db04a61 Sonic Zhang        2010-10-27  278  static ssize_t ad7816_show_oti(struct device *dev,
7924425db04a61 Sonic Zhang        2010-10-27  279  			       struct device_attribute *attr,
7924425db04a61 Sonic Zhang        2010-10-27  280  			       char *buf)
7924425db04a61 Sonic Zhang        2010-10-27  281  {
62c5183971428a Lars-Peter Clausen 2012-05-12  282  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
c746f5c9c52e03 Gabriel Shahrouzi  2025-04-18  283  	struct ad7816_state *chip = iio_priv(indio_dev);
7924425db04a61 Sonic Zhang        2010-10-27  284  	int value;
7924425db04a61 Sonic Zhang        2010-10-27  285  
7924425db04a61 Sonic Zhang        2010-10-27  286  	if (chip->channel_id > AD7816_CS_MAX) {
7924425db04a61 Sonic Zhang        2010-10-27  287  		dev_err(dev, "Invalid oti channel id %d.\n", chip->channel_id);
7924425db04a61 Sonic Zhang        2010-10-27  288  		return -EINVAL;
7924425db04a61 Sonic Zhang        2010-10-27  289  	} else if (chip->channel_id == 0) {
7924425db04a61 Sonic Zhang        2010-10-27  290  		value = AD7816_BOUND_VALUE_MIN +
7924425db04a61 Sonic Zhang        2010-10-27  291  			(chip->oti_data[chip->channel_id] -
7924425db04a61 Sonic Zhang        2010-10-27  292  			AD7816_BOUND_VALUE_BASE);
7924425db04a61 Sonic Zhang        2010-10-27  293  		return sprintf(buf, "%d\n", value);
da96aecdc59d08 Vaishali Thakkar   2014-09-25  294  	}
7924425db04a61 Sonic Zhang        2010-10-27  295  	return sprintf(buf, "%u\n", chip->oti_data[chip->channel_id]);
7924425db04a61 Sonic Zhang        2010-10-27  296  }
7924425db04a61 Sonic Zhang        2010-10-27  297  
7924425db04a61 Sonic Zhang        2010-10-27  298  static inline ssize_t ad7816_set_oti(struct device *dev,
7924425db04a61 Sonic Zhang        2010-10-27  299  				     struct device_attribute *attr,
7924425db04a61 Sonic Zhang        2010-10-27  300  				     const char *buf,
7924425db04a61 Sonic Zhang        2010-10-27  301  				     size_t len)
7924425db04a61 Sonic Zhang        2010-10-27  302  {
62c5183971428a Lars-Peter Clausen 2012-05-12  303  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
c746f5c9c52e03 Gabriel Shahrouzi  2025-04-18  304  	struct ad7816_state *chip = iio_priv(indio_dev);
7924425db04a61 Sonic Zhang        2010-10-27  305  	long value;
7924425db04a61 Sonic Zhang        2010-10-27  306  	u8 data;
7924425db04a61 Sonic Zhang        2010-10-27  307  	int ret;
7924425db04a61 Sonic Zhang        2010-10-27  308  
f86f83622fe2c4 Aida Mynzhasova    2013-05-07  309  	ret = kstrtol(buf, 10, &value);
f86f83622fe2c4 Aida Mynzhasova    2013-05-07  310  	if (ret)
f86f83622fe2c4 Aida Mynzhasova    2013-05-07  311  		return ret;
7924425db04a61 Sonic Zhang        2010-10-27  312  
7924425db04a61 Sonic Zhang        2010-10-27  313  	if (chip->channel_id > AD7816_CS_MAX) {
7924425db04a61 Sonic Zhang        2010-10-27  314  		dev_err(dev, "Invalid oti channel id %d.\n", chip->channel_id);
7924425db04a61 Sonic Zhang        2010-10-27  315  		return -EINVAL;
7924425db04a61 Sonic Zhang        2010-10-27  316  	} else if (chip->channel_id == 0) {
0fd736f9f4d2ae Amitoj Kaur Chawla 2016-02-16  317  		if (value < AD7816_BOUND_VALUE_MIN ||
7924425db04a61 Sonic Zhang        2010-10-27  318  		    value > AD7816_BOUND_VALUE_MAX)
7924425db04a61 Sonic Zhang        2010-10-27  319  			return -EINVAL;
7924425db04a61 Sonic Zhang        2010-10-27  320  
7924425db04a61 Sonic Zhang        2010-10-27  321  		data = (u8)(value - AD7816_BOUND_VALUE_MIN +
7924425db04a61 Sonic Zhang        2010-10-27  322  			AD7816_BOUND_VALUE_BASE);
7924425db04a61 Sonic Zhang        2010-10-27  323  	} else {
0fd736f9f4d2ae Amitoj Kaur Chawla 2016-02-16  324  		if (value < AD7816_BOUND_VALUE_BASE || value > 255)
7924425db04a61 Sonic Zhang        2010-10-27  325  			return -EINVAL;
7924425db04a61 Sonic Zhang        2010-10-27  326  
7924425db04a61 Sonic Zhang        2010-10-27  327  		data = (u8)value;
7924425db04a61 Sonic Zhang        2010-10-27  328  	}
7924425db04a61 Sonic Zhang        2010-10-27  329  
7924425db04a61 Sonic Zhang        2010-10-27  330  	ret = ad7816_spi_write(chip, data);
7924425db04a61 Sonic Zhang        2010-10-27  331  	if (ret)
7924425db04a61 Sonic Zhang        2010-10-27  332  		return -EIO;
7924425db04a61 Sonic Zhang        2010-10-27  333  
7924425db04a61 Sonic Zhang        2010-10-27  334  	chip->oti_data[chip->channel_id] = data;
7924425db04a61 Sonic Zhang        2010-10-27  335  
7924425db04a61 Sonic Zhang        2010-10-27  336  	return len;
7924425db04a61 Sonic Zhang        2010-10-27  337  }
7924425db04a61 Sonic Zhang        2010-10-27  338  
7f47d56c5b0500 Julián de Gortari  2017-01-23  339  static IIO_DEVICE_ATTR(oti, 0644,
7924425db04a61 Sonic Zhang        2010-10-27 @340  		       ad7816_show_oti, ad7816_set_oti, 0);
7924425db04a61 Sonic Zhang        2010-10-27  341  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

