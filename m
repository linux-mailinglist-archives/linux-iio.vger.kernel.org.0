Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6A245CC3D
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 19:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350760AbhKXSl1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Nov 2021 13:41:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:5871 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243530AbhKXSl1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Nov 2021 13:41:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="321580174"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="321580174"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 10:37:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="650486810"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2021 10:37:04 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpx8c-0005CO-IY; Wed, 24 Nov 2021 18:36:58 +0000
Date:   Thu, 25 Nov 2021 02:36:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liam Beguin <liambeguin@gmail.com>, peda@axentia.se,
        jic23@kernel.org, lars@metafoo.de
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v9 10/14] iio: test: add basic tests for the iio-rescale
 driver
Message-ID: <202111250238.lNOwhSKW-lkp@intel.com>
References: <20211115034334.1713050-11-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115034334.1713050-11-liambeguin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Liam,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1]

url:    https://github.com/0day-ci/linux/commits/Liam-Beguin/iio-afe-add-temperature-rescaling-support/20211115-114729
base:   2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1
config: openrisc-randconfig-c003-20211115 (https://download.01.org/0day-ci/archive/20211125/202111250238.lNOwhSKW-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/bef63a2e36c2ceccc6f5954ab7e7cbb178c08fd8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Liam-Beguin/iio-afe-add-temperature-rescaling-support/20211115-114729
        git checkout bef63a2e36c2ceccc6f5954ab7e7cbb178c08fd8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend':
   (.text+0x46c): undefined reference to `fb_set_suspend'
   (.text+0x46c): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `fb_set_suspend'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_resume_worker':
   drm_fb_helper.c:(.text+0x4d8): undefined reference to `fb_set_suspend'
   drm_fb_helper.c:(.text+0x4d8): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `fb_set_suspend'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_unregister_fbi':
   (.text+0x76c): undefined reference to `unregister_framebuffer'
   (.text+0x76c): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `unregister_framebuffer'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_fini':
   (.text+0x878): undefined reference to `framebuffer_release'
   (.text+0x878): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `framebuffer_release'
   or1k-linux-ld: (.text+0x9f0): undefined reference to `fb_dealloc_cmap'
   (.text+0x9f0): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `fb_dealloc_cmap'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_read':
   (.text+0xa40): undefined reference to `fb_sys_read'
   (.text+0xa40): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `fb_sys_read'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_alloc_fbi':
   (.text+0x25e8): undefined reference to `framebuffer_alloc'
   (.text+0x25e8): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `framebuffer_alloc'
   or1k-linux-ld: (.text+0x2620): undefined reference to `fb_alloc_cmap'
   (.text+0x2620): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `fb_alloc_cmap'
   or1k-linux-ld: (.text+0x2648): undefined reference to `framebuffer_release'
   (.text+0x2648): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `framebuffer_release'
   or1k-linux-ld: (.text+0x2788): undefined reference to `fb_dealloc_cmap'
   (.text+0x2788): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `fb_dealloc_cmap'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `__drm_fb_helper_initial_config_and_unlock':
   drm_fb_helper.c:(.text+0x2854): undefined reference to `register_framebuffer'
   drm_fb_helper.c:(.text+0x2854): additional relocation overflows omitted from the output
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend_unlocked':
   (.text+0x37a8): undefined reference to `fb_set_suspend'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_generic_probe':
   drm_fb_helper.c:(.text+0x45c4): undefined reference to `fb_deferred_io_init'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_imageblit':
   (.text+0x4bd4): undefined reference to `cfb_imageblit'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_copyarea':
   (.text+0x4c54): undefined reference to `cfb_copyarea'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_fillrect':
   (.text+0x4cd4): undefined reference to `cfb_fillrect'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_imageblit':
   (.text+0x4d54): undefined reference to `sys_imageblit'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_copyarea':
   (.text+0x4dd4): undefined reference to `sys_copyarea'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_fillrect':
   (.text+0x4e54): undefined reference to `sys_fillrect'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_write':
   (.text+0x4ecc): undefined reference to `fb_sys_write'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_fillrect':
   drm_fb_helper.c:(.text+0x5108): undefined reference to `cfb_fillrect'
   or1k-linux-ld: drm_fb_helper.c:(.text+0x5148): undefined reference to `sys_fillrect'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_imageblit':
   drm_fb_helper.c:(.text+0x51c8): undefined reference to `cfb_imageblit'
   or1k-linux-ld: drm_fb_helper.c:(.text+0x5208): undefined reference to `sys_imageblit'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_copyarea':
   drm_fb_helper.c:(.text+0x5288): undefined reference to `cfb_copyarea'
   or1k-linux-ld: drm_fb_helper.c:(.text+0x52c8): undefined reference to `sys_copyarea'
   or1k-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_cleanup':
   drm_fb_helper.c:(.text+0x5570): undefined reference to `fb_deferred_io_cleanup'
   or1k-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_offset':
   iio-test-rescale.c:(.text+0x34): undefined reference to `kunit_kmalloc_array'
>> or1k-linux-ld: iio-test-rescale.c:(.text+0xc4): undefined reference to `kunit_binary_assert_format'
   or1k-linux-ld: iio-test-rescale.c:(.text+0xc8): undefined reference to `kunit_binary_assert_format'
>> or1k-linux-ld: iio-test-rescale.c:(.text+0x12c): undefined reference to `kunit_do_assertion'
>> or1k-linux-ld: iio-test-rescale.c:(.text+0x148): undefined reference to `kunit_binary_str_assert_format'
   or1k-linux-ld: iio-test-rescale.c:(.text+0x14c): undefined reference to `kunit_binary_str_assert_format'
   or1k-linux-ld: iio-test-rescale.c:(.text+0x1b0): undefined reference to `kunit_do_assertion'
   or1k-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_scale':
   iio-test-rescale.c:(.text+0x380): undefined reference to `kunit_kmalloc_array'
   or1k-linux-ld: iio-test-rescale.c:(.text+0x420): undefined reference to `kunit_binary_assert_format'
   or1k-linux-ld: iio-test-rescale.c:(.text+0x440): undefined reference to `kunit_binary_assert_format'
   or1k-linux-ld: iio-test-rescale.c:(.text+0x470): undefined reference to `kunit_do_assertion'
   or1k-linux-ld: iio-test-rescale.c:(.text+0x6bc): undefined reference to `kunit_do_assertion'
   or1k-linux-ld: iio-test-rescale.c:(.text+0x730): undefined reference to `kunit_do_assertion'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
