Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB745B28E
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 04:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhKXDVk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 22:21:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:36879 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230274AbhKXDVj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 22:21:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="215901864"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="215901864"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 19:18:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="607046314"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 23 Nov 2021 19:18:28 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpinj-0004EP-FQ; Wed, 24 Nov 2021 03:18:27 +0000
Date:   Wed, 24 Nov 2021 11:18:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH v2 2/4] iio:filter:admv8818: add support for ADMV8818
Message-ID: <202111241151.J9kfWWOf-lkp@intel.com>
References: <20211123133900.133027-2-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123133900.133027-2-antoniu.miclaus@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Antoniu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on v5.16-rc2 next-20211123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Antoniu-Miclaus/iio-add-filter-subfolder/20211123-214053
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211124/202111241151.J9kfWWOf-lkp@intel.com/config.gz)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/5785226a8e5139d7275a8213a19c4e8479eca28b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Antoniu-Miclaus/iio-add-filter-subfolder/20211123-214053
        git checkout 5785226a8e5139d7275a8213a19c4e8479eca28b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/filter/admv8818.c:469:74: error: macro "IIO_ENUM_AVAILABLE" passed 3 arguments, but takes just 2
     469 |  IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_ALL, &admv8818_mode_enum),
         |                                                                          ^
   In file included from drivers/iio/filter/admv8818.c:14:
   include/linux/iio/iio.h:111: note: macro "IIO_ENUM_AVAILABLE" defined here
     111 | #define IIO_ENUM_AVAILABLE(_name, _e) \
         | 
>> drivers/iio/filter/admv8818.c:469:2: error: 'IIO_ENUM_AVAILABLE' undeclared here (not in a function)
     469 |  IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_ALL, &admv8818_mode_enum),
         |  ^~~~~~~~~~~~~~~~~~


vim +/IIO_ENUM_AVAILABLE +469 drivers/iio/filter/admv8818.c

   466	
   467	static const struct iio_chan_spec_ext_info admv8818_ext_info[] = {
   468		IIO_ENUM("filter_mode", IIO_SHARED_BY_ALL, &admv8818_mode_enum),
 > 469		IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_ALL, &admv8818_mode_enum),
   470		{ },
   471	};
   472	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
