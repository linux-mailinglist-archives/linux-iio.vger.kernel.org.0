Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD4448F8AE
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 19:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiAOSPd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 13:15:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:57563 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231278AbiAOSPd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Jan 2022 13:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642270533; x=1673806533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kIwoazCFR7DJjHKdzbRi05ynIhAGB8XqO7nxwNlhL54=;
  b=b5zriw5W1W2KkLDQbfj1imo/xsWR8vk+/XDRJr93PgN6K6Yc1u/gYvlF
   zoaHEDAO3zfOi3E4p2TJNdzTThMnAUckefGwbR0NpiRk71hZRv9zkrb3W
   I/AKRfFHIz1cSDmQRU4o0wR9ld3EC/yZ8WFypXrbWISZYTFJ0JMhzvH+0
   CrBdld4UItqX2WRvFY4DhUVqEdGOx43V+KyxJVB80H5f1nRcmJBOg7wDW
   pYV2W14nQNJvlgns4TkMpE9E3wECWGys6fAd+njlTgMswl7yF+S+5R3wa
   9J5TJPcwopyx5VlXkQT1r/KrDBY8vK4uDTo526wl46iinV+/m8qq+uNnG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="268801627"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="268801627"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 10:15:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="476139453"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Jan 2022 10:15:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8naM-000ABy-6P; Sat, 15 Jan 2022 18:15:30 +0000
Date:   Sun, 16 Jan 2022 02:15:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 1/3] iio: dac: add support for ltc2688
Message-ID: <202201160237.Mxs5GYw3-lkp@intel.com>
References: <20220115092705.491-2-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115092705.491-2-nuno.sa@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi "Nuno,

I love your patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v5.16 next-20220115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nuno-S/Add-support-for-LTC2688/20220115-172930
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220116/202201160237.Mxs5GYw3-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d91bcc420e0c6077053e559f676fa4ae76114ba5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nuno-S/Add-support-for-LTC2688/20220115-172930
        git checkout d91bcc420e0c6077053e559f676fa4ae76114ba5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/dac/ltc2688.c:590:18: error: initialization of 'ssize_t (*)(struct iio_dev *, uintptr_t,  const struct iio_chan_spec *, const char *, size_t)' {aka 'long int (*)(struct iio_dev *, long unsigned int,  const struct iio_chan_spec *, const char *, long unsigned int)'} from incompatible pointer type 'int (*)(struct iio_dev *, uintptr_t,  const struct iio_chan_spec *, const char *, size_t)' {aka 'int (*)(struct iio_dev *, long unsigned int,  const struct iio_chan_spec *, const char *, long unsigned int)'} [-Werror=incompatible-pointer-types]
     590 |         .write = (_write),                                              \
         |                  ^
   drivers/iio/dac/ltc2688.c:604:9: note: in expansion of macro 'LTC2688_CHAN_EXT_INFO'
     604 |         LTC2688_CHAN_EXT_INFO("toggle_en", LTC2688_CMD_TOGGLE_DITHER_EN,
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:590:18: note: (near initialization for 'ltc2688_toggle_sym_ext_info[2].write')
     590 |         .write = (_write),                                              \
         |                  ^
   drivers/iio/dac/ltc2688.c:604:9: note: in expansion of macro 'LTC2688_CHAN_EXT_INFO'
     604 |         LTC2688_CHAN_EXT_INFO("toggle_en", LTC2688_CMD_TOGGLE_DITHER_EN,
         |         ^~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/dac/ltc2688.c:590:18: error: initialization of 'ssize_t (*)(struct iio_dev *, uintptr_t,  const struct iio_chan_spec *, const char *, size_t)' {aka 'long int (*)(struct iio_dev *, long unsigned int,  const struct iio_chan_spec *, const char *, long unsigned int)'} from incompatible pointer type 'int (*)(struct iio_dev *, uintptr_t,  const struct iio_chan_spec *, const char *, size_t)' {aka 'int (*)(struct iio_dev *, long unsigned int,  const struct iio_chan_spec *, const char *, long unsigned int)'} [-Werror=incompatible-pointer-types]
     590 |         .write = (_write),                                              \
         |                  ^
   drivers/iio/dac/ltc2688.c:619:9: note: in expansion of macro 'LTC2688_CHAN_EXT_INFO'
     619 |         LTC2688_CHAN_EXT_INFO("toggle_en", LTC2688_CMD_TOGGLE_DITHER_EN,
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:590:18: note: (near initialization for 'ltc2688_toggle_ext_info[2].write')
     590 |         .write = (_write),                                              \
         |                  ^
   drivers/iio/dac/ltc2688.c:619:9: note: in expansion of macro 'LTC2688_CHAN_EXT_INFO'
     619 |         LTC2688_CHAN_EXT_INFO("toggle_en", LTC2688_CMD_TOGGLE_DITHER_EN,
         |         ^~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/dac/ltc2688.c:590:18: error: initialization of 'ssize_t (*)(struct iio_dev *, uintptr_t,  const struct iio_chan_spec *, const char *, size_t)' {aka 'long int (*)(struct iio_dev *, long unsigned int,  const struct iio_chan_spec *, const char *, long unsigned int)'} from incompatible pointer type 'int (*)(struct iio_dev *, uintptr_t,  const struct iio_chan_spec *, const char *, size_t)' {aka 'int (*)(struct iio_dev *, long unsigned int,  const struct iio_chan_spec *, const char *, long unsigned int)'} [-Werror=incompatible-pointer-types]
     590 |         .write = (_write),                                              \
         |                  ^
   drivers/iio/dac/ltc2688.c:639:9: note: in expansion of macro 'LTC2688_CHAN_EXT_INFO'
     639 |         LTC2688_CHAN_EXT_INFO("dither_frequency", 0, IIO_SEPARATE,
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:590:18: note: (near initialization for 'ltc2688_dither_ext_info[3].write')
     590 |         .write = (_write),                                              \
         |                  ^
   drivers/iio/dac/ltc2688.c:639:9: note: in expansion of macro 'LTC2688_CHAN_EXT_INFO'
     639 |         LTC2688_CHAN_EXT_INFO("dither_frequency", 0, IIO_SEPARATE,
         |         ^~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/dac/ltc2688.c:590:18: error: initialization of 'ssize_t (*)(struct iio_dev *, uintptr_t,  const struct iio_chan_spec *, const char *, size_t)' {aka 'long int (*)(struct iio_dev *, long unsigned int,  const struct iio_chan_spec *, const char *, long unsigned int)'} from incompatible pointer type 'int (*)(struct iio_dev *, uintptr_t,  const struct iio_chan_spec *, const char *, size_t)' {aka 'int (*)(struct iio_dev *, long unsigned int,  const struct iio_chan_spec *, const char *, long unsigned int)'} [-Werror=incompatible-pointer-types]
     590 |         .write = (_write),                                              \
         |                  ^
   drivers/iio/dac/ltc2688.c:641:9: note: in expansion of macro 'LTC2688_CHAN_EXT_INFO'
     641 |         LTC2688_CHAN_EXT_INFO("dither_frequency_available",
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:590:18: note: (near initialization for 'ltc2688_dither_ext_info[4].write')
     590 |         .write = (_write),                                              \
         |                  ^
   drivers/iio/dac/ltc2688.c:641:9: note: in expansion of macro 'LTC2688_CHAN_EXT_INFO'
     641 |         LTC2688_CHAN_EXT_INFO("dither_frequency_available",
         |         ^~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/dac/ltc2688.c:590:18: error: initialization of 'ssize_t (*)(struct iio_dev *, uintptr_t,  const struct iio_chan_spec *, const char *, size_t)' {aka 'long int (*)(struct iio_dev *, long unsigned int,  const struct iio_chan_spec *, const char *, long unsigned int)'} from incompatible pointer type 'int (*)(struct iio_dev *, uintptr_t,  const struct iio_chan_spec *, const char *, size_t)' {aka 'int (*)(struct iio_dev *, long unsigned int,  const struct iio_chan_spec *, const char *, long unsigned int)'} [-Werror=incompatible-pointer-types]
     590 |         .write = (_write),                                              \
         |                  ^
   drivers/iio/dac/ltc2688.c:647:9: note: in expansion of macro 'LTC2688_CHAN_EXT_INFO'
     647 |         LTC2688_CHAN_EXT_INFO("dither_en", LTC2688_CMD_TOGGLE_DITHER_EN,
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:590:18: note: (near initialization for 'ltc2688_dither_ext_info[7].write')
     590 |         .write = (_write),                                              \
         |                  ^
   drivers/iio/dac/ltc2688.c:647:9: note: in expansion of macro 'LTC2688_CHAN_EXT_INFO'
     647 |         LTC2688_CHAN_EXT_INFO("dither_en", LTC2688_CMD_TOGGLE_DITHER_EN,
         |         ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +590 drivers/iio/dac/ltc2688.c

   586	
   587	#define LTC2688_CHAN_EXT_INFO(_name, _what, _shared, _read, _write) {	\
   588		.name = _name,							\
   589		.read = (_read),						\
 > 590		.write = (_write),						\
   591		.private = (_what),						\
   592		.shared = (_shared),						\
   593	}
   594	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
