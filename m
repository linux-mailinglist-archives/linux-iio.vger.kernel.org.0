Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA4B6A508A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Feb 2023 02:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjB1BOR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Feb 2023 20:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjB1BOP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2023 20:14:15 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FF0F941;
        Mon, 27 Feb 2023 17:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677546854; x=1709082854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4UKwAIo3ykTG6MDrcG32IpOsot6nPS5XUQ9f4DsWH3c=;
  b=cWj7tr02ghsrhVoaSVPHZ79dHeidP7o4ryqnf2JWcm1aQnLmlX1lBnF6
   nqvNr/b1yI5+QLymmz3O39YdWL0uChlJNz2nhdSEz+5rxpC9aKZth4rmj
   +BCKnBVpevt0lfG06hdd928eg1m/nUKJFaKl34Q0DveKZm6WG9bK8Uyuu
   YYsHZrPRkie3cjx2qXNzA0Xo/ZuFDPGVBzNtyVutUq8LG1peavsdH1iDI
   4AOGFxJQRMv1Xbtn+uz6boqjpdv+14pebvWspPvBuAHrQHjBigg8YPOzg
   KI9V2sghmW3H50UjBDLZpn1Xk/Vzmxn9e6V0K9k7MG+jNjXWNd2ylH86o
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="398793102"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="398793102"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 17:14:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="667267732"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="667267732"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Feb 2023 17:14:11 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWoZG-0004xR-2G;
        Tue, 28 Feb 2023 01:14:10 +0000
Date:   Tue, 28 Feb 2023 09:13:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>, puranjay12@gmail.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v5 4/5] iio: temperature: tmp117: add TI TMP116 support
Message-ID: <202302280821.OXqGp2Tq-lkp@intel.com>
References: <20230227211230.165073-5-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227211230.165073-5-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Marco,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v6.2]
[cannot apply to jic23-iio/togreg linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marco-Felsch/dt-bindings-iio-ti-tmp117-fix-documentation-link/20230228-051305
patch link:    https://lore.kernel.org/r/20230227211230.165073-5-m.felsch%40pengutronix.de
patch subject: [PATCH v5 4/5] iio: temperature: tmp117: add TI TMP116 support
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230228/202302280821.OXqGp2Tq-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/424113d7fdc257200d20da2991242a4050c04cb3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Marco-Felsch/dt-bindings-iio-ti-tmp117-fix-documentation-link/20230228-051305
        git checkout 424113d7fdc257200d20da2991242a4050c04cb3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/iio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302280821.OXqGp2Tq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/temperature/tmp117.c:111:2: error: expected '}' before ';' token
     111 | };
         |  ^
   drivers/iio/temperature/tmp117.c:106:55: note: to match this '{'
     106 | static const struct iio_chan_spec tmp117_channels[] = {
         |                                                       ^
   drivers/iio/temperature/tmp117.c:106:35: warning: 'tmp117_channels' defined but not used [-Wunused-const-variable=]
     106 | static const struct iio_chan_spec tmp117_channels[] = {
         |                                   ^~~~~~~~~~~~~~~
   drivers/iio/temperature/tmp117.c:85:12: warning: 'tmp117_write_raw' defined but not used [-Wunused-function]
      85 | static int tmp117_write_raw(struct iio_dev *indio_dev,
         |            ^~~~~~~~~~~~~~~~
   drivers/iio/temperature/tmp117.c:45:12: warning: 'tmp117_read_raw' defined but not used [-Wunused-function]
      45 | static int tmp117_read_raw(struct iio_dev *indio_dev,
         |            ^~~~~~~~~~~~~~~


vim +111 drivers/iio/temperature/tmp117.c

   105	
   106	static const struct iio_chan_spec tmp117_channels[] = {
   107		{
   108			.type = IIO_TEMP,
   109			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
   110				BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_SCALE),
 > 111	};
   112	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
