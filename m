Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53BF45EC18
	for <lists+linux-iio@lfdr.de>; Fri, 26 Nov 2021 12:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhKZLEn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Nov 2021 06:04:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:37427 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230057AbhKZLCm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 26 Nov 2021 06:02:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="259550783"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="259550783"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 02:57:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="457631759"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Nov 2021 02:57:26 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqYuy-0007zi-Vu; Fri, 26 Nov 2021 10:57:24 +0000
Date:   Fri, 26 Nov 2021 18:56:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     kbuild-all@lists.01.org, demonsingur@gmail.com,
        cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v4 3/3] iio: addac: add AD74413R driver
Message-ID: <202111261848.357oHcvz-lkp@intel.com>
References: <20211125131422.50657-4-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125131422.50657-4-demonsingur@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Cosmin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v5.16-rc2 next-20211126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Cosmin-Tanislav/Add-AD74413R-driver/20211125-212256
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20211126/202111261848.357oHcvz-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fc77dddb39ba26db2e5f66817f9e12dc3191659d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Cosmin-Tanislav/Add-AD74413R-driver/20211125-212256
        git checkout fc77dddb39ba26db2e5f66817f9e12dc3191659d
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iio/addac/ad74413r.c: In function 'ad74413r_range_to_voltage_offset_raw':
>> drivers/iio/addac/ad74413r.c:586:24: warning: overflow in conversion from 'long unsigned int' to 'int' changes value from '18446744073709486081' to '-65535' [-Woverflow]
     586 |                 *val = -AD74413R_ADC_RESULT_MAX;
         |                        ^
   drivers/iio/addac/ad74413r.c:589:24: warning: overflow in conversion from 'long unsigned int' to 'int' changes value from '9223372036854743040' to '-32768' [-Woverflow]
     589 |                 *val = -AD74413R_ADC_RESULT_MAX / 2;
         |                        ^


vim +586 drivers/iio/addac/ad74413r.c

   576	
   577	static int ad74413r_range_to_voltage_offset_raw(struct ad74413r_state *st,
   578							unsigned int range, int *val)
   579	{
   580		switch (range) {
   581		case AD74413R_ADC_RANGE_10V:
   582		case AD74413R_ADC_RANGE_2P5V_EXT_POW:
   583			*val = 0;
   584			return 0;
   585		case AD74413R_ADC_RANGE_2P5V_INT_POW:
 > 586			*val = -AD74413R_ADC_RESULT_MAX;
   587			return 0;
   588		case AD74413R_ADC_RANGE_5V_BI_DIR:
   589			*val = -AD74413R_ADC_RESULT_MAX / 2;
   590			return 0;
   591		default:
   592			dev_err(st->dev, "ADC range invalid\n");
   593			return -EINVAL;
   594		}
   595	}
   596	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
