Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8184D22D0
	for <lists+linux-iio@lfdr.de>; Tue,  8 Mar 2022 21:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbiCHUrk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Mar 2022 15:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiCHUrj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Mar 2022 15:47:39 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09223517D8;
        Tue,  8 Mar 2022 12:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646772402; x=1678308402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mq2TE7/iNaJLGgHDnK6IXV3Bcg5SS7VRlNtznKGbfqE=;
  b=FtAj/jIvACct9BU1N/VGAl3huQpTq7nAo1c9LKKidrqMThPMuCy2QJW1
   fPONFmeboixR7frSHzb4Tjdm6hPomwH6Jq6cVCviqecBAFMz/xyOQXen5
   AA9BLtOccIJzpoIkyYuDgwjE9Fv+cuZaFNzfUWBA6JIeKdrAo6oEmz7MU
   EslaJpS/u9qVddM55tVMc1X3KQqW4b4xrnS2IYwtqtOVG6OsN/5yA61xD
   dZtTKdiHAYCT3XeyolrjczZSXk5WcEBZcbYpWdnAw+mQOHNCzZGleiGM/
   mTNxvJgQ4T738oi64YUwDrmWf/1jennzsX704IxzlsHT6z/KnF6s/bEfE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="242253937"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="242253937"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 12:46:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="578140362"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2022 12:46:38 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRgj7-0001wW-DM; Tue, 08 Mar 2022 20:46:37 +0000
Date:   Wed, 9 Mar 2022 04:46:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, sumit.semwal@linaro.org,
        amit.pundir@linaro.org, john.stultz@linaro.org
Subject: Re: [PATCH v10 2/9] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Message-ID: <202203090452.rXtdakYR-lkp@intel.com>
References: <20220305021247.1020122-3-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305021247.1020122-3-caleb.connolly@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Caleb,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on jic23-iio/togreg lee-mfd/for-mfd-next linus/master v5.17-rc7 next-20220308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Caleb-Connolly/iio-adc-introduce-Qualcomm-SPMI-Round-Robin-ADC/20220307-134408
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: openrisc-randconfig-s032-20220307 (https://download.01.org/0day-ci/archive/20220309/202203090452.rXtdakYR-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/9b8935738dc1a30c2fdcacd300b6608a99da65a2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Caleb-Connolly/iio-adc-introduce-Qualcomm-SPMI-Round-Robin-ADC/20220307-134408
        git checkout 9b8935738dc1a30c2fdcacd300b6608a99da65a2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/mfd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/mfd/qcom-spmi-pmic.c: note: in included file:
>> include/linux/spmi.h:168:47: sparse: sparse: marked inline, but without a definition

vim +168 include/linux/spmi.h

5a86bf343976b9c Kenneth Heitke 2014-02-12  163  
5a86bf343976b9c Kenneth Heitke 2014-02-12  164  #define module_spmi_driver(__spmi_driver) \
5a86bf343976b9c Kenneth Heitke 2014-02-12  165  	module_driver(__spmi_driver, spmi_driver_register, \
5a86bf343976b9c Kenneth Heitke 2014-02-12  166  			spmi_driver_unregister)
5a86bf343976b9c Kenneth Heitke 2014-02-12  167  
e02739c92c567a4 Caleb Connolly 2022-03-05 @168  inline struct spmi_device *spmi_device_from_of(struct device_node *np);
5a86bf343976b9c Kenneth Heitke 2014-02-12  169  int spmi_register_read(struct spmi_device *sdev, u8 addr, u8 *buf);
5a86bf343976b9c Kenneth Heitke 2014-02-12  170  int spmi_ext_register_read(struct spmi_device *sdev, u8 addr, u8 *buf,
5a86bf343976b9c Kenneth Heitke 2014-02-12  171  			   size_t len);
5a86bf343976b9c Kenneth Heitke 2014-02-12  172  int spmi_ext_register_readl(struct spmi_device *sdev, u16 addr, u8 *buf,
5a86bf343976b9c Kenneth Heitke 2014-02-12  173  			    size_t len);
5a86bf343976b9c Kenneth Heitke 2014-02-12  174  int spmi_register_write(struct spmi_device *sdev, u8 addr, u8 data);
5a86bf343976b9c Kenneth Heitke 2014-02-12  175  int spmi_register_zero_write(struct spmi_device *sdev, u8 data);
5a86bf343976b9c Kenneth Heitke 2014-02-12  176  int spmi_ext_register_write(struct spmi_device *sdev, u8 addr,
5a86bf343976b9c Kenneth Heitke 2014-02-12  177  			    const u8 *buf, size_t len);
5a86bf343976b9c Kenneth Heitke 2014-02-12  178  int spmi_ext_register_writel(struct spmi_device *sdev, u16 addr,
5a86bf343976b9c Kenneth Heitke 2014-02-12  179  			     const u8 *buf, size_t len);
5a86bf343976b9c Kenneth Heitke 2014-02-12  180  int spmi_command_reset(struct spmi_device *sdev);
5a86bf343976b9c Kenneth Heitke 2014-02-12  181  int spmi_command_sleep(struct spmi_device *sdev);
5a86bf343976b9c Kenneth Heitke 2014-02-12  182  int spmi_command_wakeup(struct spmi_device *sdev);
5a86bf343976b9c Kenneth Heitke 2014-02-12  183  int spmi_command_shutdown(struct spmi_device *sdev);
5a86bf343976b9c Kenneth Heitke 2014-02-12  184  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
