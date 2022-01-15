Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F35648F739
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 15:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiAOOCG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 09:02:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:3557 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbiAOOCF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Jan 2022 09:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642255325; x=1673791325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S1BGAySqzj1O102qKDK+UWk5VK9SRGhwJpNELfl5im8=;
  b=ded+AlAIMPBPuA/JVkvmrh8i/IInUGjeDn6/GBI97KIbMiPBM1cXcZrr
   OrOT3+z7K3Xc7LgIzGMorJ52YXqObRS3JqfHprQrZ+ZEowmfR6S2stJHQ
   EOYQSp36MbcwCWnlqbM8Nu64eXGw3SY0urP1BGBKFU4Tw3ktR7ZhEuzSG
   lVM2l52d9LjwxODeNgHbVm5P0hGkXl+DG5Tt7dIpFBWHw5wG9fw75Ndwr
   bDCmpZZ91KCqietHG+LaCHJMReaQJ1yDGBCH6PadwIlwOJO1NxOzM1C6y
   mZZzmMS/6jP9nCFU6miyGB2EHwSupNWxDztcFlLgWp8d3tsEA8qksqxif
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="241973668"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="241973668"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 06:02:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="559818760"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Jan 2022 06:02:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8jd3-0009rE-Ml; Sat, 15 Jan 2022 14:02:01 +0000
Date:   Sat, 15 Jan 2022 22:01:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 1/3] iio: dac: add support for ltc2688
Message-ID: <202201152138.RqRoWKHf-lkp@intel.com>
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
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220115/202201152138.RqRoWKHf-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 650fc40b6d8d9a5869b4fca525d5f237b0ee2803)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/d91bcc420e0c6077053e559f676fa4ae76114ba5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nuno-S/Add-support-for-LTC2688/20220115-172930
        git checkout d91bcc420e0c6077053e559f676fa4ae76114ba5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/iio/dac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/dac/ltc2688.c:604:2: error: incompatible function pointer types initializing 'ssize_t (*)(struct iio_dev *, uintptr_t, const struct iio_chan_spec *, const char *, size_t)' (aka 'long (*)(struct iio_dev *, unsigned long, const struct iio_chan_spec *, const char *, unsigned long)') with an expression of type 'int (struct iio_dev *, uintptr_t, const struct iio_chan_spec *, const char *, size_t)' (aka 'int (struct iio_dev *, unsigned long, const struct iio_chan_spec *, const char *, unsigned long)') [-Werror,-Wincompatible-function-pointer-types]
           LTC2688_CHAN_EXT_INFO("toggle_en", LTC2688_CMD_TOGGLE_DITHER_EN,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:590:11: note: expanded from macro 'LTC2688_CHAN_EXT_INFO'
           .write = (_write),                                              \
                    ^~~~~~~~
   drivers/iio/dac/ltc2688.c:619:2: error: incompatible function pointer types initializing 'ssize_t (*)(struct iio_dev *, uintptr_t, const struct iio_chan_spec *, const char *, size_t)' (aka 'long (*)(struct iio_dev *, unsigned long, const struct iio_chan_spec *, const char *, unsigned long)') with an expression of type 'int (struct iio_dev *, uintptr_t, const struct iio_chan_spec *, const char *, size_t)' (aka 'int (struct iio_dev *, unsigned long, const struct iio_chan_spec *, const char *, unsigned long)') [-Werror,-Wincompatible-function-pointer-types]
           LTC2688_CHAN_EXT_INFO("toggle_en", LTC2688_CMD_TOGGLE_DITHER_EN,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:590:11: note: expanded from macro 'LTC2688_CHAN_EXT_INFO'
           .write = (_write),                                              \
                    ^~~~~~~~
   drivers/iio/dac/ltc2688.c:639:2: error: incompatible function pointer types initializing 'ssize_t (*)(struct iio_dev *, uintptr_t, const struct iio_chan_spec *, const char *, size_t)' (aka 'long (*)(struct iio_dev *, unsigned long, const struct iio_chan_spec *, const char *, unsigned long)') with an expression of type 'int (struct iio_dev *, uintptr_t, const struct iio_chan_spec *, const char *, size_t)' (aka 'int (struct iio_dev *, unsigned long, const struct iio_chan_spec *, const char *, unsigned long)') [-Werror,-Wincompatible-function-pointer-types]
           LTC2688_CHAN_EXT_INFO("dither_frequency", 0, IIO_SEPARATE,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:590:11: note: expanded from macro 'LTC2688_CHAN_EXT_INFO'
           .write = (_write),                                              \
                    ^~~~~~~~
   drivers/iio/dac/ltc2688.c:641:2: error: incompatible function pointer types initializing 'ssize_t (*)(struct iio_dev *, uintptr_t, const struct iio_chan_spec *, const char *, size_t)' (aka 'long (*)(struct iio_dev *, unsigned long, const struct iio_chan_spec *, const char *, unsigned long)') with an expression of type 'int (struct iio_dev *, uintptr_t, const struct iio_chan_spec *, const char *, size_t)' (aka 'int (struct iio_dev *, unsigned long, const struct iio_chan_spec *, const char *, unsigned long)') [-Werror,-Wincompatible-function-pointer-types]
           LTC2688_CHAN_EXT_INFO("dither_frequency_available",
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:590:11: note: expanded from macro 'LTC2688_CHAN_EXT_INFO'
           .write = (_write),                                              \
                    ^~~~~~~~
   drivers/iio/dac/ltc2688.c:647:2: error: incompatible function pointer types initializing 'ssize_t (*)(struct iio_dev *, uintptr_t, const struct iio_chan_spec *, const char *, size_t)' (aka 'long (*)(struct iio_dev *, unsigned long, const struct iio_chan_spec *, const char *, unsigned long)') with an expression of type 'int (struct iio_dev *, uintptr_t, const struct iio_chan_spec *, const char *, size_t)' (aka 'int (struct iio_dev *, unsigned long, const struct iio_chan_spec *, const char *, unsigned long)') [-Werror,-Wincompatible-function-pointer-types]
           LTC2688_CHAN_EXT_INFO("dither_en", LTC2688_CMD_TOGGLE_DITHER_EN,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/dac/ltc2688.c:590:11: note: expanded from macro 'LTC2688_CHAN_EXT_INFO'
           .write = (_write),                                              \
                    ^~~~~~~~
   5 errors generated.


vim +604 drivers/iio/dac/ltc2688.c

   594	
   595	/*
   596	 * For toggle mode we only expose the symbol attr (sw_toggle) in case a TGPx is
   597	 * not provided in dts.
   598	 */
   599	static const struct iio_chan_spec_ext_info ltc2688_toggle_sym_ext_info[] = {
   600		LTC2688_CHAN_EXT_INFO("raw0", LTC2688_INPUT_A, IIO_SEPARATE,
   601				      ltc2688_dac_input_read, ltc2688_dac_input_write),
   602		LTC2688_CHAN_EXT_INFO("raw1", LTC2688_INPUT_B, IIO_SEPARATE,
   603				      ltc2688_dac_input_read, ltc2688_dac_input_write),
 > 604		LTC2688_CHAN_EXT_INFO("toggle_en", LTC2688_CMD_TOGGLE_DITHER_EN,
   605				      IIO_SEPARATE, ltc2688_reg_bool_get,
   606				      ltc2688_dither_toggle_set),
   607		LTC2688_CHAN_EXT_INFO("powerdown", LTC2688_CMD_POWERDOWN, IIO_SEPARATE,
   608				      ltc2688_reg_bool_get, ltc2688_reg_bool_set),
   609		LTC2688_CHAN_EXT_INFO("symbol", LTC2688_CMD_SW_TOGGLE, IIO_SEPARATE,
   610				      ltc2688_reg_bool_get, ltc2688_reg_bool_set),
   611		{}
   612	};
   613	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
