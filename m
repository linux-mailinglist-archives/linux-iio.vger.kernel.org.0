Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A907251134E
	for <lists+linux-iio@lfdr.de>; Wed, 27 Apr 2022 10:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359348AbiD0IOs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Apr 2022 04:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359346AbiD0IOr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Apr 2022 04:14:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE4C25C5E;
        Wed, 27 Apr 2022 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651047097; x=1682583097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6eM5e62oXAvLaa18gkB8bzP55Ven4At3wrVREaGjxkI=;
  b=Qh7VFSIEpIlWRDmmZG4/Qez7fs7YAdUTtOSHuUfKIsmSp0TdlxMlnuJm
   5gPyPL9D2hGgiRoPZSdPR6EYQhPNmE5XnJAWSottnCvyLBLGdBZdfzdAn
   3uyrdp6nLpjub9cSNtadTuWMjNav4XK7iRRseItMJr0jiXcO5DRkWkSKR
   /522ZJV3fi88hoZ8znUP3LoNJyXgZlXXcScZ5GRdxLGHgT14K/1LXjnhc
   uz4T/ZJ8UApliZMC4dZ8DGZegXmvCzVyAubpOyFl8zvd7i2lb9ZuTXYvc
   XhB9WfhACzQTPCrFqZXVuN0WexDNwVeuYs1zB3dbuIfTk5n0zkP64H4hT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265381666"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="265381666"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 01:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="564976596"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Apr 2022 01:11:33 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njclo-0004VD-JD;
        Wed, 27 Apr 2022 08:11:32 +0000
Date:   Wed, 27 Apr 2022 16:10:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrea Merello <andrea.merello@gmail.com>, jic23@kernel.org,
        mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, lars@metafoo.de, robh+dt@kernel.org,
        andy.shevchenko@gmail.com, matt.ranostay@konsulko.com,
        ardeleanalex@gmail.com, jacopo@jmondi.org,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v5 12/14] iio: imu: add BNO055 serdev driver
Message-ID: <202204271554.EiuIRNPI-lkp@intel.com>
References: <20220426131102.23966-13-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426131102.23966-13-andrea.merello@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andrea,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master linux/master v5.18-rc4 next-20220426]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrea-Merello/Add-support-for-Bosch-BNO055-IMU/20220426-212132
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220427/202204271554.EiuIRNPI-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/675ca9cd13af45cc5943dd15caad5e866fd7c971
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andrea-Merello/Add-support-for-Bosch-BNO055-IMU/20220426-212132
        git checkout 675ca9cd13af45cc5943dd15caad5e866fd7c971
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[5]: *** No rule to make target 'drivers/iio/imu/bno055/bno055_ser_trace.o', needed by 'drivers/iio/imu/bno055/built-in.a'.
   make[5]: Target '__build' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
