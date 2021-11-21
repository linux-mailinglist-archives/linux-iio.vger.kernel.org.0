Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA27458537
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 18:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbhKUREH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Nov 2021 12:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238243AbhKUREH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Nov 2021 12:04:07 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B8EC061574;
        Sun, 21 Nov 2021 09:01:01 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id s9so10801724qvk.12;
        Sun, 21 Nov 2021 09:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KVKeVqvg/ApiNDdJUzme5McRscnsPRuaYUkAW77wSrU=;
        b=EC+tOmSQTYbiM8GxNEKGwAYNEQT7ULUpueu+n1AI5gHFcoK9whqaWd74htXslRJEpW
         z0C1pL+mGTX9gQpLBLd4bRvWOGkG+WHmGCY1QM50LA/mdz6E7jevqFC2PzLLN+UdDxTc
         Gvtpvg86NC5DPHWkX6YJPbMj5pM0iQdFt67XHg6449iRusUAcBdBp8RhLmNXOV/DGT5q
         1bNXD18HwTISh8Kpy3y//SIsfj6thROtvpJucqaDUXv5ZGakIq+7pwc1bxHBDXc6Jcyj
         RIuYLIPZ8PJ4Vkpa5ozgqYIdtkzY+0yT6VN8LlZgHnVzlPo6FY3q0D2o2y1XKHss0dII
         287Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KVKeVqvg/ApiNDdJUzme5McRscnsPRuaYUkAW77wSrU=;
        b=zZ4Bzp5ugmd8/6qoCUY8GApgFtpHDC+m4hr9+FOVjVB3b3YR0ugbJ59lj/TQI8bjWK
         7Fgd1+gIkS0YvUObe9NL5kjthq2lkhBOQDxkWHtNl+T27t2okU0nFLOu6gwY8htVAVyn
         qotP14S7Ay45KL6HlLCZ3h9Zjppn55hKyHy3c9tPnH6RNsIq5k/6WDI2NmYkpDxOiQ8Y
         e/4Rn59STIJ0YvEHKdmaXV8tj1xWwE99K8N897tFHLVjIMyjwWS5simiXSHEq7EW/bmH
         a5AlyvxLhTkJE+yCLKXqTno4f9GkgMH8KRlPkWyyAz33kSbM9fKb8hmjmTb8p3dAvFbW
         99bg==
X-Gm-Message-State: AOAM530g3kraZFxUbxfwJLKNaGXsoXP7gkxjNmFiqc3uFlxp4Lfazr+J
        G/67l537riVarmzA2m6aaD4=
X-Google-Smtp-Source: ABdhPJzw2dIrZh2m/XonrGyX/J6dnSLBgKLsAQMeZmS+ngIGTLZcnF19b9vJwGMY9L55qAmQ6zy8wA==
X-Received: by 2002:a05:6214:2589:: with SMTP id fq9mr91860977qvb.38.1637514061033;
        Sun, 21 Nov 2021 09:01:01 -0800 (PST)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id i23sm3101803qkl.101.2021.11.21.09.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 09:01:00 -0800 (PST)
Date:   Sun, 21 Nov 2021 12:00:58 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, peda@axentia.se,
        lars@metafoo.de, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v9 10/14] iio: test: add basic tests for the iio-rescale
 driver
Message-ID: <YZp7SsdvQDr0WmDT@shaak>
References: <20211115034334.1713050-11-liambeguin@gmail.com>
 <202111172344.tSkzL3S5-lkp@intel.com>
 <20211121111958.3ed740dc@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211121111958.3ed740dc@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 21, 2021 at 11:19:58AM +0000, Jonathan Cameron wrote:
> On Wed, 17 Nov 2021 23:03:24 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Liam,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on 2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Liam-Beguin/iio-afe-add-temperature-rescaling-support/20211115-114729
> > base:   2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1
> > config: nds32-randconfig-r003-20211115 (attached as .config)
> > compiler: nds32le-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/0day-ci/linux/commit/bef63a2e36c2ceccc6f5954ab7e7cbb178c08fd8
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Liam-Beguin/iio-afe-add-temperature-rescaling-support/20211115-114729
> >         git checkout bef63a2e36c2ceccc6f5954ab7e7cbb178c08fd8
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> 
> This one has me stumped.  The new tests have a depends on KUNIT and that should result in these
> functions being built.
>  

I only took a quick look at this, but was quite puzzled too.
I'll try to find more time to investigate.

Cheers,
Liam

> Anyone know what might have caused these?
> 
> Jonathan
> 
> 
> > All errors (new ones prefixed by >>):
> > 
> >    nds32le-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_offset':
> > >> iio-test-rescale.c:(.text+0x16): undefined reference to `kunit_kmalloc_array'
> > >> nds32le-linux-ld: iio-test-rescale.c:(.text+0x1a): undefined reference to `kunit_kmalloc_array'
> > >> nds32le-linux-ld: iio-test-rescale.c:(.text+0x80): undefined reference to `kunit_binary_assert_format'  
> >    nds32le-linux-ld: iio-test-rescale.c:(.text+0x84): undefined reference to `kunit_binary_assert_format'
> > >> nds32le-linux-ld: iio-test-rescale.c:(.text+0xe0): undefined reference to `kunit_do_assertion'  
> >    nds32le-linux-ld: iio-test-rescale.c:(.text+0xe4): undefined reference to `kunit_do_assertion'
> > >> nds32le-linux-ld: iio-test-rescale.c:(.text+0x104): undefined reference to `kunit_binary_str_assert_format'  
> >    nds32le-linux-ld: iio-test-rescale.c:(.text+0x108): undefined reference to `kunit_binary_str_assert_format'
> >    nds32le-linux-ld: iio-test-rescale.c:(.text+0x158): undefined reference to `kunit_do_assertion'
> >    nds32le-linux-ld: iio-test-rescale.c:(.text+0x15c): undefined reference to `kunit_do_assertion'
> >    nds32le-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_scale':
> >    iio-test-rescale.c:(.text+0x236): undefined reference to `kunit_kmalloc_array'
> >    nds32le-linux-ld: iio-test-rescale.c:(.text+0x23a): undefined reference to `kunit_kmalloc_array'
> >    nds32le-linux-ld: iio-test-rescale.c:(.text+0x2d8): undefined reference to `kunit_binary_assert_format'
> >    nds32le-linux-ld: iio-test-rescale.c:(.text+0x2dc): undefined reference to `kunit_binary_assert_format'
> >    nds32le-linux-ld: iio-test-rescale.c:(.text+0x30a): undefined reference to `kunit_do_assertion'
> >    nds32le-linux-ld: iio-test-rescale.c:(.text+0x30e): undefined reference to `kunit_do_assertion'
> >    nds32le-linux-ld: iio-test-rescale.c:(.text+0x476): undefined reference to `kunit_do_assertion'
> >    nds32le-linux-ld: iio-test-rescale.c:(.text+0x47a): undefined reference to `kunit_do_assertion'
> >    nds32le-linux-ld: iio-test-rescale.c:(.text+0x4d8): undefined reference to `kunit_do_assertion'
> >    nds32le-linux-ld: drivers/iio/test/iio-test-rescale.o:iio-test-rescale.c:(.text+0x4dc): more undefined references to `kunit_do_assertion' follow
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend':
> >    (.text+0x330): undefined reference to `fb_set_suspend'
> >    nds32le-linux-ld: (.text+0x334): undefined reference to `fb_set_suspend'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_resume_worker':
> >    drm_fb_helper.c:(.text+0x35c): undefined reference to `fb_set_suspend'
> >    nds32le-linux-ld: drm_fb_helper.c:(.text+0x360): undefined reference to `fb_set_suspend'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_unregister_fbi':
> >    (.text+0x3c4): undefined reference to `unregister_framebuffer'
> >    nds32le-linux-ld: (.text+0x3c8): undefined reference to `unregister_framebuffer'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_fini':
> >    (.text+0x424): undefined reference to `fb_dealloc_cmap'
> >    nds32le-linux-ld: (.text+0x428): undefined reference to `fb_dealloc_cmap'
> >    nds32le-linux-ld: (.text+0x432): undefined reference to `framebuffer_release'
> >    nds32le-linux-ld: (.text+0x436): undefined reference to `framebuffer_release'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_read':
> >    (.text+0x4fc): undefined reference to `fb_sys_read'
> >    nds32le-linux-ld: (.text+0x500): undefined reference to `fb_sys_read'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_alloc_fbi':
> >    (.text+0xec2): undefined reference to `framebuffer_alloc'
> >    nds32le-linux-ld: (.text+0xec6): undefined reference to `framebuffer_alloc'
> >    nds32le-linux-ld: (.text+0xede): undefined reference to `fb_alloc_cmap'
> >    nds32le-linux-ld: (.text+0xee2): undefined reference to `fb_alloc_cmap'
> >    nds32le-linux-ld: (.text+0xf08): undefined reference to `fb_dealloc_cmap'
> >    nds32le-linux-ld: (.text+0xf0c): undefined reference to `fb_dealloc_cmap'
> >    nds32le-linux-ld: (.text+0xf2e): undefined reference to `framebuffer_release'
> >    nds32le-linux-ld: (.text+0xf32): undefined reference to `framebuffer_release'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_generic_probe':
> >    drm_fb_helper.c:(.text+0x102a): undefined reference to `fb_deferred_io_init'
> >    nds32le-linux-ld: drm_fb_helper.c:(.text+0x102e): undefined reference to `fb_deferred_io_init'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `__drm_fb_helper_initial_config_and_unlock':
> >    drm_fb_helper.c:(.text+0x1118): undefined reference to `register_framebuffer'
> >    nds32le-linux-ld: drm_fb_helper.c:(.text+0x111c): undefined reference to `register_framebuffer'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend_unlocked':
> >    (.text+0x1680): undefined reference to `fb_set_suspend'
> >    nds32le-linux-ld: (.text+0x1684): undefined reference to `fb_set_suspend'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_write':
> >    (.text+0x1b96): undefined reference to `fb_sys_write'
> >    nds32le-linux-ld: (.text+0x1b9a): undefined reference to `fb_sys_write'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_fillrect':
> >    (.text+0x1bdc): undefined reference to `sys_fillrect'
> >    nds32le-linux-ld: (.text+0x1be0): undefined reference to `sys_fillrect'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_copyarea':
> >    (.text+0x1c0c): undefined reference to `sys_copyarea'
> >    nds32le-linux-ld: (.text+0x1c10): undefined reference to `sys_copyarea'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_imageblit':
> >    (.text+0x1c3c): undefined reference to `sys_imageblit'
> >    nds32le-linux-ld: (.text+0x1c40): undefined reference to `sys_imageblit'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_fillrect':
> >    (.text+0x1c6c): undefined reference to `cfb_fillrect'
> >    nds32le-linux-ld: (.text+0x1c70): undefined reference to `cfb_fillrect'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_copyarea':
> >    (.text+0x1c9c): undefined reference to `cfb_copyarea'
> >    nds32le-linux-ld: (.text+0x1ca0): undefined reference to `cfb_copyarea'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_imageblit':
> >    (.text+0x1ccc): undefined reference to `cfb_imageblit'
> >    nds32le-linux-ld: (.text+0x1cd0): undefined reference to `cfb_imageblit'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_copyarea':
> >    drm_fb_helper.c:(.text+0x1f3e): undefined reference to `cfb_copyarea'
> >    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1f42): undefined reference to `cfb_copyarea'
> >    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1f4e): undefined reference to `sys_copyarea'
> >    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1f52): undefined reference to `sys_copyarea'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_fillrect':
> >    drm_fb_helper.c:(.text+0x1f8e): undefined reference to `cfb_fillrect'
> >    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1f92): undefined reference to `cfb_fillrect'
> >    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1f9e): undefined reference to `sys_fillrect'
> >    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1fa2): undefined reference to `sys_fillrect'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_imageblit':
> >    drm_fb_helper.c:(.text+0x1fde): undefined reference to `cfb_imageblit'
> >    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1fe2): undefined reference to `cfb_imageblit'
> >    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1fee): undefined reference to `sys_imageblit'
> >    nds32le-linux-ld: drm_fb_helper.c:(.text+0x1ff2): undefined reference to `sys_imageblit'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_cleanup':
> >    drm_fb_helper.c:(.text+0x2040): undefined reference to `fb_deferred_io_cleanup'
> >    nds32le-linux-ld: drm_fb_helper.c:(.text+0x2044): undefined reference to `fb_deferred_io_cleanup'
> >    nds32le-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_client_unregister':
> >    drm_fb_helper.c:(.text+0x20dc): undefined reference to `unregister_framebuffer'
> >    nds32le-linux-ld: drm_fb_helper.c:(.text+0x20e0): undefined reference to `unregister_framebuffer'
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
