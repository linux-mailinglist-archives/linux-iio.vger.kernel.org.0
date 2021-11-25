Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D8A45D87A
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 11:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354675AbhKYK5z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 05:57:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:22702 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349526AbhKYKzy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Nov 2021 05:55:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="321728672"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="321728672"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 02:51:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="457827367"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Nov 2021 02:51:33 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqCLk-0006F5-WE; Thu, 25 Nov 2021 10:51:33 +0000
Date:   Thu, 25 Nov 2021 18:51:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH] device property: Add fwnode_iomap()
Message-ID: <202111251817.YgUIj6sh-lkp@intel.com>
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
[also build test ERROR on driver-core/driver-core-testing linus/master v5.16-rc2 next-20211125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Anand-Ashok-Dumbre/device-property-Add-fwnode_iomap/20211116-014240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git debe436e77c72fcee804fb867f275e6d31aa999c
config: s390-randconfig-m031-20211115 (https://download.01.org/0day-ci/archive/20211125/202111251817.YgUIj6sh-lkp@intel.com/config)
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

   s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   idma64.c:(.text+0x463e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
   hidma.c:(.text+0x1cde): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: hidma.c:(.text+0x1da8): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/base/property.o: in function `fwnode_iomap':
>> property.c:(.text+0x4f34): undefined reference to `of_iomap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x19fc): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x1ad6): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x1bbe): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x1c18): undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0x371e): undefined reference to `iounmap'
   s390-linux-ld: drivers/firmware/google/coreboot_table.o: in function `coreboot_table_probe':
   coreboot_table.c:(.text+0x98e): undefined reference to `memremap'
   s390-linux-ld: coreboot_table.c:(.text+0xa46): undefined reference to `memunmap'
   s390-linux-ld: coreboot_table.c:(.text+0xad2): undefined reference to `memremap'
   s390-linux-ld: coreboot_table.c:(.text+0xc70): undefined reference to `memunmap'
   s390-linux-ld: drivers/firmware/google/memconsole-coreboot.o: in function `memconsole_probe':
   memconsole-coreboot.c:(.text+0x3be): undefined reference to `memremap'
   s390-linux-ld: memconsole-coreboot.c:(.text+0x47a): undefined reference to `devm_memremap'
   s390-linux-ld: memconsole-coreboot.c:(.text+0x4c4): undefined reference to `memunmap'
   s390-linux-ld: drivers/firmware/google/vpd.o: in function `vpd_section_destroy.isra.0':
   vpd.c:(.text+0xaee): undefined reference to `memunmap'
   s390-linux-ld: drivers/firmware/google/vpd.o: in function `vpd_section_init':
   vpd.c:(.text+0xcce): undefined reference to `memremap'
   s390-linux-ld: vpd.c:(.text+0x1178): undefined reference to `memunmap'
   s390-linux-ld: drivers/firmware/google/vpd.o: in function `vpd_sections_init':
   vpd.c:(.text+0x122e): undefined reference to `memremap'
   s390-linux-ld: vpd.c:(.text+0x12c4): undefined reference to `memunmap'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
