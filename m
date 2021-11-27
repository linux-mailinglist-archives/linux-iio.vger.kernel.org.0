Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC7545FE5F
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 12:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbhK0MBH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 07:01:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:40271 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239167AbhK0L7G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Nov 2021 06:59:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="235994742"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="235994742"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 03:55:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="593743686"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Nov 2021 03:55:48 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqwJ1-0009S2-W1; Sat, 27 Nov 2021 11:55:47 +0000
Date:   Sat, 27 Nov 2021 19:54:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v11 1/5] device property: Add fwnode_iomap()
Message-ID: <202111271953.N5Nm1MIG-lkp@intel.com>
References: <20211124225407.17793-2-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124225407.17793-2-anand.ashok.dumbre@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Anand,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on xilinx-xlnx/master linux/master linus/master v5.16-rc2 next-20211126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Anand-Ashok-Dumbre/Add-Xilinx-AMS-Driver/20211125-065614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: s390-randconfig-r044-20211126 (https://download.01.org/0day-ci/archive/20211127/202111271953.N5Nm1MIG-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/b9acba7c202b47024781ea7a6f85b787df15f29b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Anand-Ashok-Dumbre/Add-Xilinx-AMS-Driver/20211125-065614
        git checkout b9acba7c202b47024781ea7a6f85b787df15f29b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
   coherent.c:(.text+0x6c): undefined reference to `memremap'
   s390-linux-ld: coherent.c:(.text+0x106): undefined reference to `memunmap'
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
   coherent.c:(.text+0x436): undefined reference to `memunmap'
   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x28): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0x1f4): undefined reference to `iounmap'
   s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   idma64.c:(.text+0x14cc): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_detach':
   main.c:(.text+0x8a): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0xd0): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_probe':
   main.c:(.text+0x258): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x30c): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x35e): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x3a0): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `config_ipwireless':
   main.c:(.text+0x5a0): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x5e0): undefined reference to `iounmap'
   s390-linux-ld: drivers/base/property.o: in function `fwnode_iomap':
>> property.c:(.text+0xf36): undefined reference to `of_iomap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arc_rimi_exit':
   arc-rimi.c:(.exit.text+0x34): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arcrimi_found':
   arc-rimi.c:(.init.text+0xce): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x14c): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x2b0): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x332): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x3f4): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `check_mirror':
   arc-rimi.c:(.text.unlikely+0x4e): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.text.unlikely+0x74): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/8390/pcnet_cs.o: in function `pcnet_release':
   pcnet_cs.c:(.text+0x6b8): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/8390/pcnet_cs.o: in function `setup_shmem_window':
   pcnet_cs.c:(.text+0xb44): undefined reference to `ioremap'
   s390-linux-ld: pcnet_cs.c:(.text+0xbd8): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/8390/pcnet_cs.o: in function `get_hwinfo':
   pcnet_cs.c:(.text+0x1558): undefined reference to `ioremap'
   s390-linux-ld: pcnet_cs.c:(.text+0x1656): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/xircom/xirc2ps_cs.o: in function `xirc2ps_release':
   xirc2ps_cs.c:(.text+0x518): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/xircom/xirc2ps_cs.o: in function `xirc2ps_config':
   xirc2ps_cs.c:(.text+0x1584): undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x5c6): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x5fc): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x62a): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x63c): undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0xf80): undefined reference to `iounmap'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
