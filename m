Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E2945D84A
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 11:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346970AbhKYKgs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 05:36:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:16237 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354590AbhKYKer (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Nov 2021 05:34:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="235734550"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="235734550"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 02:31:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="554596918"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 25 Nov 2021 02:31:33 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqC2O-0006DO-8O; Thu, 25 Nov 2021 10:31:32 +0000
Date:   Thu, 25 Nov 2021 18:30:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH] device property: Add fwnode_iomap()
Message-ID: <202111251848.snM0nERG-lkp@intel.com>
References: <20211115173819.22778-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115173819.22778-1-anand.ashok.dumbre@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Anand,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on driver-core/driver-core-testing linus/master v5.16-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Anand-Ashok-Dumbre/device-property-Add-fwnode_iomap/20211116-014240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git debe436e77c72fcee804fb867f275e6d31aa999c
config: s390-randconfig-r005-20211115 (https://download.01.org/0day-ci/archive/20211125/202111251848.snM0nERG-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/057b01427afce16994b109c1f32a95bc46973e39
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Anand-Ashok-Dumbre/device-property-Add-fwnode_iomap/20211116-014240
        git checkout 057b01427afce16994b109c1f32a95bc46973e39
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
   coherent.c:(.text+0x128): undefined reference to `memremap'
   s390-linux-ld: coherent.c:(.text+0x31e): undefined reference to `memunmap'
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
   coherent.c:(.text+0xab6): undefined reference to `memunmap'
   s390-linux-ld: drivers/base/property.o: in function `fwnode_iomap':
>> (.text+0x1dfc): undefined reference to `of_iomap'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
