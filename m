Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C746CB88
	for <lists+linux-iio@lfdr.de>; Wed,  8 Dec 2021 04:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243848AbhLHD35 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Dec 2021 22:29:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:36822 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243839AbhLHD35 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 Dec 2021 22:29:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="298542677"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="298542677"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 19:26:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="462603579"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 07 Dec 2021 19:26:23 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1munb4-000NLE-Oc; Wed, 08 Dec 2021 03:26:22 +0000
Date:   Wed, 8 Dec 2021 11:26:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        lars@metafoo.de, swboyd@chromium.org
Cc:     kbuild-all@lists.01.org, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v5 3/5] iio: proximity: Add SX9324 support
Message-ID: <202112081125.pcOSkAMQ-lkp@intel.com>
References: <20211208004311.3098571-4-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208004311.3098571-4-gwendal@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on v5.16-rc4 next-20211207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Gwendal-Grignou/Expand-Semtech-SAR-Sensors-support/20211208-084635
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20211208/202112081125.pcOSkAMQ-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d02716a5c3a619239e594e6ba6af2ec38fd3de3d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Gwendal-Grignou/Expand-Semtech-SAR-Sensors-support/20211208-084635
        git checkout d02716a5c3a619239e594e6ba6af2ec38fd3de3d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/iio/proximity/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iio/proximity/sx9324.c: In function 'sx9324_phase_configuration_show':
>> drivers/iio/proximity/sx9324.c:166:16: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     166 |         int i, ret, pin_idx;
         |                ^~~
   At top level:
   drivers/iio/proximity/sx9324.c:871:36: warning: 'sx9324_acpi_match' defined but not used [-Wunused-const-variable=]
     871 | static const struct acpi_device_id sx9324_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~


vim +/ret +166 drivers/iio/proximity/sx9324.c

   158	
   159	static ssize_t sx9324_phase_configuration_show(struct iio_dev *indio_dev,
   160						       uintptr_t private,
   161						       const struct iio_chan_spec *chan,
   162						       char *buf)
   163	{
   164		struct sx_common_data *data = iio_priv(indio_dev);
   165		unsigned int val;
 > 166		int i, ret, pin_idx;
   167		size_t len = 0;
   168	
   169		ret = regmap_read(data->regmap, SX9324_REG_AFE_PH0 + chan->channel, &val);
   170	
   171		for (i = 0; i < SX9324_NUM_PINS; i++) {
   172			pin_idx = (val & SX9324_REG_AFE_PH0_PIN_MASK(i)) >> (2 * i);
   173			len += scnprintf(buf + len, PAGE_SIZE - len, "%s,",
   174					 sx9324_cs_pin_usage[pin_idx]);
   175		}
   176		buf[len - 1] = '\n';
   177		return len;
   178	}
   179	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
