Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C82D458311
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 12:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbhKULSL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Nov 2021 06:18:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234679AbhKULSK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 06:18:10 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED79B60E54;
        Sun, 21 Nov 2021 11:15:03 +0000 (UTC)
Date:   Sun, 21 Nov 2021 11:19:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Liam Beguin <liambeguin@gmail.com>, peda@axentia.se,
        lars@metafoo.de, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v9 10/14] iio: test: add basic tests for the iio-rescale
 driver
Message-ID: <20211121111958.3ed740dc@jic23-huawei>
In-Reply-To: <202111172344.tSkzL3S5-lkp@intel.com>
References: <20211115034334.1713050-11-liambeguin@gmail.com>
        <202111172344.tSkzL3S5-lkp@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 17 Nov 2021 23:03:24 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Liam,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on 2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1]
> 
> url:    https://github.com/0day-ci/linux/commits/Liam-Beguin/iio-afe-add-temperature-rescaling-support/20211115-114729
> base:   2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1
> config: nds32-randconfig-r003-20211115 (attached as .config)
> compiler: nds32le-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/bef63a2e36c2ceccc6f5954ab7e7cbb178c08fd8
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Liam-Beguin/iio-afe-add-temperature-rescaling-support/20211115-114729
>         git checkout bef63a2e36c2ceccc6f5954ab7e7cbb178c08fd8
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 

This one has me stumped.  The new tests have a depends on KUNIT and that should result in these
functions being built.
 
Anyone know what might have caused these?

Jonathan


> All errors (new ones prefixed by >>):
> 
>    nds32le-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_offset':
> >> iio-test-rescale.c:(.text+0x16): undefined reference to `kunit_kmalloc_array'
> >> nds32le-linux-ld: iio-test-rescale.c:(.text+0x1a): undefined reference to `kunit_kmalloc_array'
> >> nds32le-linux-ld: iio-test-rescale.c:(.text+0x80): undefined reference to `kunit_binary_assert_format'  
>    nds32le-linux-ld: iio-test-rescale.c:(.text+0x84): undefined reference to `kunit_binary_assert_format'
> >> nds32le-linux-ld: iio-test-rescale.c:(.text+0xe0): undefined reference to `kunit_do_assertion'  
>    nds32le-linux-ld: iio-test-rescale.c:(.text+0xe4): undefined reference to `kunit_do_assertion'
> >> nds32le-linux-ld: iio-test-rescale.c:(.text+0x104): undefined reference to `kunit_binary_str_assert_format'  
>    nds32le-linux-ld: iio-test-rescale.c:(.text+0x108): undefined reference to `kunit_binary_str_assert_format'
>    nds32le-linux-ld: iio-test-rescale.c:(.text+0x158): undefined reference to `kunit_do_assertion'
>    nds32le-linux-ld: iio-test-rescale.c:(.text+0x15c): undefined reference to `kunit_do_assertion'
>    nds32le-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_scale':
>    iio-test-rescale.c:(.text+0x236): undefined reference to `kunit_kmalloc_array'
>    nds32le-linux-ld: iio-test-rescale.c:(.text+0x23a): undefined reference to `kunit_kmalloc_array'
>    nds32le-linux-ld: iio-test-rescale.c:(.text+0x2d8): undefined reference to `kunit_binary_assert_format'
>    nds32le-linux-ld: iio-test-rescale.c:(.text+0x2dc): undefined reference to `kunit_binary_assert_format'
>    nds32le-linux-ld: iio-test-rescale.c:(.text+0x30a): undefined reference to `kunit_do_assertion'
>    nds32le-linux-ld: iio-test-rescale.c:(.text+0x30e): undefined reference to `kunit_do_assertion'
>    nds32le-linux-ld: iio-test-rescale.c:(.text+0x476): undefined reference to `kunit_do_assertion'
>    nds32le-linux-ld: iio-test-rescale.c:(.text+0x47a): undefined reference to `kunit_do_assertion'
>    nds32le-linux-ld: iio-test-rescale.c:(.text+0x4d8): undefined reference to `kunit_do_assertion'
>    nds32le-linux-ld: drivers/iio/test/iio-test-rescale.o:iio-test-rescale.c:(.text+0x4dc): more undefined references to `kunit_do_assertion' follow
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend':
>    (.text+0x330): undefined reference to `fb_set_suspend'
>    nds32le-linux-ld: (.text+0x334): undefined reference to `fb_set_suspend'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_resume_worker':
>    drm_fb_helper.c:(.text+0x35c): undefined reference to `fb_set_suspend'
>    nds32le-linux-ld: drm_fb_helper.c:(.text+0x360): undefined reference to `fb_set_suspend'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_unregister_fbi':
>    (.text+0x3c4): undefined reference to `unregister_framebuffer'
>    nds32le-linux-ld: (.text+0x3c8): undefined reference to `unregister_framebuffer'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_fini':
>    (.text+0x424): undefined reference to `fb_dealloc_cmap'
>    nds32le-linux-ld: (.text+0x428): undefined reference to `fb_dealloc_cmap'
>    nds32le-linux-ld: (.text+0x432): undefined reference to `framebuffer_release'
>    nds32le-linux-ld: (.text+0x436): undefined reference to `framebuffer_release'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_read':
>    (.text+0x4fc): undefined reference to `fb_sys_read'
>    nds32le-linux-ld: (.text+0x500): undefined reference to `fb_sys_read'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_alloc_fbi':
>    (.text+0xec2): undefined reference to `framebuffer_alloc'
>    nds32le-linux-ld: (.text+0xec6): undefined reference to `framebuffer_alloc'
>    nds32le-linux-ld: (.text+0xede): undefined reference to `fb_alloc_cmap'
>    nds32le-linux-ld: (.text+0xee2): undefined reference to `fb_alloc_cmap'
>    nds32le-linux-ld: (.text+0xf08): undefined reference to `fb_dealloc_cmap'
>    nds32le-linux-ld: (.text+0xf0c): undefined reference to `fb_dealloc_cmap'
>    nds32le-linux-ld: (.text+0xf2e): undefined reference to `framebuffer_release'
>    nds32le-linux-ld: (.text+0xf32): undefined reference to `framebuffer_release'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_generic_probe':
>    drm_fb_helper.c:(.text+0x102a): undefined reference to `fb_deferred_io_init'
>    nds32le-linux-ld: drm_fb_helper.c:(.text+0x102e): undefined reference to `fb_deferred_io_init'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `__drm_fb_helper_initial_config_and_unlock':
>    drm_fb_helper.c:(.text+0x1118): undefined reference to `register_framebuffer'
>    nds32le-linux-ld: drm_fb_helper.c:(.text+0x111c): undefined reference to `register_framebuffer'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend_unlocked':
>    (.text+0x1680): undefined reference to `fb_set_suspend'
>    nds32le-linux-ld: (.text+0x1684): undefined reference to `fb_set_suspend'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_write':
>    (.text+0x1b96): undefined reference to `fb_sys_write'
>    nds32le-linux-ld: (.text+0x1b9a): undefined reference to `fb_sys_write'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_fillrect':
>    (.text+0x1bdc): undefined reference to `sys_fillrect'
>    nds32le-linux-ld: (.text+0x1be0): undefined reference to `sys_fillrect'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_copyarea':
>    (.text+0x1c0c): undefined reference to `sys_copyarea'
>    nds32le-linux-ld: (.text+0x1c10): undefined reference to `sys_copyarea'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_imageblit':
>    (.text+0x1c3c): undefined reference to `sys_imageblit'
>    nds32le-linux-ld: (.text+0x1c40): undefined reference to `sys_imageblit'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_fillrect':
>    (.text+0x1c6c): undefined reference to `cfb_fillrect'
>    nds32le-linux-ld: (.text+0x1c70): undefined reference to `cfb_fillrect'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_copyarea':
>    (.text+0x1c9c): undefined reference to `cfb_copyarea'
>    nds32le-linux-ld: (.text+0x1ca0): undefined reference to `cfb_copyarea'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_imageblit':
>    (.text+0x1ccc): undefined reference to `cfb_imageblit'
>    nds32le-linux-ld: (.text+0x1cd0): undefined reference to `cfb_imageblit'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_copyarea':
>    drm_fb_helper.c:(.text+0x1f3e): undefined reference to `cfb_copyarea'
>    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1f42): undefined reference to `cfb_copyarea'
>    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1f4e): undefined reference to `sys_copyarea'
>    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1f52): undefined reference to `sys_copyarea'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_fillrect':
>    drm_fb_helper.c:(.text+0x1f8e): undefined reference to `cfb_fillrect'
>    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1f92): undefined reference to `cfb_fillrect'
>    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1f9e): undefined reference to `sys_fillrect'
>    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1fa2): undefined reference to `sys_fillrect'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_imageblit':
>    drm_fb_helper.c:(.text+0x1fde): undefined reference to `cfb_imageblit'
>    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1fe2): undefined reference to `cfb_imageblit'
>    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1fee): undefined reference to `sys_imageblit'
>    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1ff2): undefined reference to `sys_imageblit'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_cleanup':
>    drm_fb_helper.c:(.text+0x2040): undefined reference to `fb_deferred_io_cleanup'
>    nds32le-linux-ld: drm_fb_helper.c:(.text+0x2044): undefined reference to `fb_deferred_io_cleanup'
>    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_client_unregister':
>    drm_fb_helper.c:(.text+0x20dc): undefined reference to `unregister_framebuffer'
>    nds32le-linux-ld: drm_fb_helper.c:(.text+0x20e0): undefined reference to `unregister_framebuffer'
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

