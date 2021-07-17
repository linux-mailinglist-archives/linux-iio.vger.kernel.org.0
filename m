Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFD83CC527
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 20:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhGQSHW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 14:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234554AbhGQSHV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 14:07:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36C986115C;
        Sat, 17 Jul 2021 18:04:21 +0000 (UTC)
Date:   Sat, 17 Jul 2021 19:06:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, kbuild-all@lists.01.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 08/15] iio: dac: ad5624r: Fix incorrect handling of an
 optional regulator.
Message-ID: <20210717190644.344cc0e3@jic23-huawei>
In-Reply-To: <202106280153.9GRid3YV-lkp@intel.com>
References: <20210627163244.1090296-9-jic23@kernel.org>
        <202106280153.9GRid3YV-lkp@intel.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Jun 2021 01:29:53 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Jonathan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on iio/togreg]
> [also build test ERROR on robh/for-next v5.13-rc7 next-20210625]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Jonathan-Cameron/dt-bindings-iio-dac-Add-most-missing-binding-documents/20210628-003216
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: nios2-randconfig-r001-20210627 (attached as .config)
> compiler: nios2-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/4f70da9b9819945461961ccdfbd87438ac8a9f89
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Jonathan-Cameron/dt-bindings-iio-dac-Add-most-missing-binding-documents/20210628-003216
>         git checkout 4f70da9b9819945461961ccdfbd87438ac8a9f89
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/iio/dac/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
Stray bracket.  Oops and now fixed in the patch I've applied.

Thanks!
Jonathan

> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/iio/dac/ad5624r_spi.c: In function 'ad5624r_probe':
> >> drivers/iio/dac/ad5624r_spi.c:296:12: error: invalid storage class for function 'ad5624r_remove'  
>      296 | static int ad5624r_remove(struct spi_device *spi)
>          |            ^~~~~~~~~~~~~~
> >> drivers/iio/dac/ad5624r_spi.c:296:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]  
>      296 | static int ad5624r_remove(struct spi_device *spi)
>          | ^~~~~~
> >> drivers/iio/dac/ad5624r_spi.c:324:12: error: initializer element is not constant  
>      324 |  .remove = ad5624r_remove,
>          |            ^~~~~~~~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:324:12: note: (near initialization for 'ad5624r_driver.remove')
>    drivers/iio/dac/ad5624r_spi.c:319:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>      319 | static struct spi_driver ad5624r_driver = {
>          | ^~~~~~
>    In file included from include/linux/device.h:32,
>                     from drivers/iio/dac/ad5624r_spi.c:10:
> >> drivers/iio/dac/ad5624r_spi.c:327:19: error: invalid storage class for function 'ad5624r_driver_init'  
>      327 | module_spi_driver(ad5624r_driver);
>          |                   ^~~~~~~~~~~~~~
>    include/linux/device/driver.h:259:19: note: in definition of macro 'module_driver'
>      259 | static int __init __driver##_init(void) \
>          |                   ^~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:327:1: note: in expansion of macro 'module_spi_driver'
>      327 | module_spi_driver(ad5624r_driver);
>          | ^~~~~~~~~~~~~~~~~
>    In file included from include/linux/printk.h:6,
>                     from include/linux/kernel.h:17,
>                     from include/linux/interrupt.h:6,
>                     from drivers/iio/dac/ad5624r_spi.c:8:
>    drivers/iio/dac/ad5624r_spi.c:327:19: error: initializer element is not constant
>      327 | module_spi_driver(ad5624r_driver);
>          |                   ^~~~~~~~~~~~~~
>    include/linux/init.h:250:41: note: in definition of macro '____define_initcall'
>      250 |   __attribute__((__section__(__sec))) = fn;
>          |                                         ^~
>    include/linux/init.h:260:2: note: in expansion of macro '__unique_initcall'
>      260 |  __unique_initcall(fn, id, __sec, __initcall_id(fn))
>          |  ^~~~~~~~~~~~~~~~~
>    include/linux/init.h:262:35: note: in expansion of macro '___define_initcall'
>      262 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
>          |                                   ^~~~~~~~~~~~~~~~~~
>    include/linux/init.h:291:30: note: in expansion of macro '__define_initcall'
>      291 | #define device_initcall(fn)  __define_initcall(fn, 6)
>          |                              ^~~~~~~~~~~~~~~~~
>    include/linux/init.h:296:24: note: in expansion of macro 'device_initcall'
>      296 | #define __initcall(fn) device_initcall(fn)
>          |                        ^~~~~~~~~~~~~~~
>    include/linux/module.h:87:24: note: in expansion of macro '__initcall'
>       87 | #define module_init(x) __initcall(x);
>          |                        ^~~~~~~~~~
>    include/linux/device/driver.h:263:1: note: in expansion of macro 'module_init'
>      263 | module_init(__driver##_init); \
>          | ^~~~~~~~~~~
>    include/linux/spi/spi.h:315:2: note: in expansion of macro 'module_driver'
>      315 |  module_driver(__spi_driver, spi_register_driver, \
>          |  ^~~~~~~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:327:1: note: in expansion of macro 'module_spi_driver'
>      327 | module_spi_driver(ad5624r_driver);
>          | ^~~~~~~~~~~~~~~~~
>    In file included from include/linux/device.h:32,
>                     from drivers/iio/dac/ad5624r_spi.c:10:
> >> drivers/iio/dac/ad5624r_spi.c:327:19: error: invalid storage class for function 'ad5624r_driver_exit'  
>      327 | module_spi_driver(ad5624r_driver);
>          |                   ^~~~~~~~~~~~~~
>    include/linux/device/driver.h:264:20: note: in definition of macro 'module_driver'
>      264 | static void __exit __driver##_exit(void) \
>          |                    ^~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:327:1: note: in expansion of macro 'module_spi_driver'
>      327 | module_spi_driver(ad5624r_driver);
>          | ^~~~~~~~~~~~~~~~~
> >> include/linux/device/driver.h:264:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]  
>      264 | static void __exit __driver##_exit(void) \
>          | ^~~~~~
>    include/linux/spi/spi.h:315:2: note: in expansion of macro 'module_driver'
>      315 |  module_driver(__spi_driver, spi_register_driver, \
>          |  ^~~~~~~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:327:1: note: in expansion of macro 'module_spi_driver'
>      327 | module_spi_driver(ad5624r_driver);
>          | ^~~~~~~~~~~~~~~~~
>    In file included from include/linux/printk.h:6,
>                     from include/linux/kernel.h:17,
>                     from include/linux/interrupt.h:6,
>                     from drivers/iio/dac/ad5624r_spi.c:8:
>    drivers/iio/dac/ad5624r_spi.c:327:19: error: initializer element is not constant
>      327 | module_spi_driver(ad5624r_driver);
>          |                   ^~~~~~~~~~~~~~
>    include/linux/init.h:299:50: note: in definition of macro '__exitcall'
>      299 |  static exitcall_t __exitcall_##fn __exit_call = fn
>          |                                                  ^~
>    include/linux/device/driver.h:268:1: note: in expansion of macro 'module_exit'
>      268 | module_exit(__driver##_exit);
>          | ^~~~~~~~~~~
>    include/linux/spi/spi.h:315:2: note: in expansion of macro 'module_driver'
>      315 |  module_driver(__spi_driver, spi_register_driver, \
>          |  ^~~~~~~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:327:1: note: in expansion of macro 'module_spi_driver'
>      327 | module_spi_driver(ad5624r_driver);
>          | ^~~~~~~~~~~~~~~~~
>    In file included from include/linux/module.h:21,
>                     from include/linux/bpf.h:19,
>                     from include/linux/bpf-cgroup.h:5,
>                     from include/linux/cgroup-defs.h:22,
>                     from include/linux/cgroup.h:28,
>                     from include/linux/memcontrol.h:13,
>                     from include/linux/swap.h:9,
>                     from include/linux/suspend.h:5,
>                     from include/linux/regulator/consumer.h:35,
>                     from drivers/iio/dac/ad5624r_spi.c:15:
>    include/linux/moduleparam.h:24:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>       24 |  static const char __UNIQUE_ID(name)[]      \
>          |  ^~~~~~
>    include/linux/module.h:165:32: note: in expansion of macro '__MODULE_INFO'
>      165 | #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
>          |                                ^~~~~~~~~~~~~
>    include/linux/module.h:235:32: note: in expansion of macro 'MODULE_INFO'
>      235 | #define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)
>          |                                ^~~~~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:329:1: note: in expansion of macro 'MODULE_AUTHOR'
>      329 | MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
>          | ^~~~~~~~~~~~~
> >> drivers/iio/dac/ad5624r_spi.c:331:1: error: expected declaration or statement at end of input  
>      331 | MODULE_LICENSE("GPL v2");
>          | ^~~~~~~~~~~~~~
>    At top level:
>    drivers/iio/dac/ad5624r_spi.c:222:12: warning: 'ad5624r_probe' defined but not used [-Wunused-function]
>      222 | static int ad5624r_probe(struct spi_device *spi)
>          |            ^~~~~~~~~~~~~
> 
> 
> vim +/ad5624r_remove +296 drivers/iio/dac/ad5624r_spi.c
> 
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  295  
> fc52692c49969e drivers/iio/dac/ad5624r_spi.c         Greg Kroah-Hartman 2012-12-21 @296  static int ad5624r_remove(struct spi_device *spi)
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  297  {
> 3ff242055b7b46 drivers/staging/iio/dac/ad5624r_spi.c Jonathan Cameron   2011-06-27  298  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> 3ff242055b7b46 drivers/staging/iio/dac/ad5624r_spi.c Jonathan Cameron   2011-06-27  299  	struct ad5624r_state *st = iio_priv(indio_dev);
> 3ff242055b7b46 drivers/staging/iio/dac/ad5624r_spi.c Jonathan Cameron   2011-06-27  300  
> d2fffd6c2fd60f drivers/staging/iio/dac/ad5624r_spi.c Jonathan Cameron   2011-10-14  301  	iio_device_unregister(indio_dev);
> 75238230cce22b drivers/iio/dac/ad5624r_spi.c         Sachin Kamat       2013-08-19  302  	if (!IS_ERR(st->reg))
> 26a54797c1b094 drivers/staging/iio/dac/ad5624r_spi.c Jonathan Cameron   2011-08-30  303  		regulator_disable(st->reg);
> 14f88f1b07e03b drivers/staging/iio/dac/ad5624r_spi.c Michael Hennerich  2011-03-09  304  
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  305  	return 0;
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  306  }
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  307  
> ece30c15921f94 drivers/staging/iio/dac/ad5624r_spi.c Michael Hennerich  2010-11-19  308  static const struct spi_device_id ad5624r_id[] = {
> 14f88f1b07e03b drivers/staging/iio/dac/ad5624r_spi.c Michael Hennerich  2011-03-09  309  	{"ad5624r3", ID_AD5624R3},
> 14f88f1b07e03b drivers/staging/iio/dac/ad5624r_spi.c Michael Hennerich  2011-03-09  310  	{"ad5644r3", ID_AD5644R3},
> 14f88f1b07e03b drivers/staging/iio/dac/ad5624r_spi.c Michael Hennerich  2011-03-09  311  	{"ad5664r3", ID_AD5664R3},
> 14f88f1b07e03b drivers/staging/iio/dac/ad5624r_spi.c Michael Hennerich  2011-03-09  312  	{"ad5624r5", ID_AD5624R5},
> 14f88f1b07e03b drivers/staging/iio/dac/ad5624r_spi.c Michael Hennerich  2011-03-09  313  	{"ad5644r5", ID_AD5644R5},
> 14f88f1b07e03b drivers/staging/iio/dac/ad5624r_spi.c Michael Hennerich  2011-03-09  314  	{"ad5664r5", ID_AD5664R5},
> ece30c15921f94 drivers/staging/iio/dac/ad5624r_spi.c Michael Hennerich  2010-11-19  315  	{}
> ece30c15921f94 drivers/staging/iio/dac/ad5624r_spi.c Michael Hennerich  2010-11-19  316  };
> 55e4390cb04e8b drivers/staging/iio/dac/ad5624r_spi.c Lars-Peter Clausen 2011-11-16  317  MODULE_DEVICE_TABLE(spi, ad5624r_id);
> ece30c15921f94 drivers/staging/iio/dac/ad5624r_spi.c Michael Hennerich  2010-11-19  318  
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  319  static struct spi_driver ad5624r_driver = {
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  320  	.driver = {
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  321  		   .name = "ad5624r",
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  322  		   },
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  323  	.probe = ad5624r_probe,
> fc52692c49969e drivers/iio/dac/ad5624r_spi.c         Greg Kroah-Hartman 2012-12-21 @324  	.remove = ad5624r_remove,
> ece30c15921f94 drivers/staging/iio/dac/ad5624r_spi.c Michael Hennerich  2010-11-19  325  	.id_table = ad5624r_id,
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  326  };
> ae6ae6fec3f7d6 drivers/staging/iio/dac/ad5624r_spi.c Lars-Peter Clausen 2011-11-16 @327  module_spi_driver(ad5624r_driver);
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  328  
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  329  MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  330  MODULE_DESCRIPTION("Analog Devices AD5624/44/64R DAC spi driver");
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27 @331  MODULE_LICENSE("GPL v2");
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

