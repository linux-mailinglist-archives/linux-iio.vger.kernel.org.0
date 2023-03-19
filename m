Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22BB6C0573
	for <lists+linux-iio@lfdr.de>; Sun, 19 Mar 2023 22:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjCSVZ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Mar 2023 17:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCSVZZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2023 17:25:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B39513529;
        Sun, 19 Mar 2023 14:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679261124; x=1710797124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L03xG3XmXz3MyMO1JoMvMx28hZVkFt9QVmLsPGLzWIM=;
  b=Z2oVCbQXY1J8frpv+epo+EFSdu4p7euzLj88cPHjMrrtpyqCUkiMbBfX
   BOoIHz0kV9ydMf2gR4fXG/dNXyWk1aENSx4+cjwQjihy0rFNheAVN76sC
   k7ny1osdYEOkZf0Sqhhd7U49zHfztMYRHMZwJbLtljcKk8MUo8euzM4Fr
   kzA9kSF19EREYUGahgpMXQu0psIO2cg0KAviCbu9R3lGshe4rsYU3TjOn
   mSJJ3QjXBkOnQKByI5z3ABuNiIkwChrcgY3ubtqKfx1NBoSkaSqVbrfh7
   LGSrW9J5ujr2V0PbMjT219nPpzJE1+Kv/XUxI7+cBvrlGgMwIjTy7m5fK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="340080954"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="340080954"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 14:25:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="749866876"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="749866876"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Mar 2023 14:25:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pe0Wn-000Af4-0D;
        Sun, 19 Mar 2023 21:25:21 +0000
Date:   Mon, 20 Mar 2023 05:24:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Hepp <andrew.hepp@ahepp.dev>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Hepp <andrew.hepp@ahepp.dev>
Subject: Re: [PATCH 2/2] iio: temperature: Add MCP9600 thermocouple EMF
 converter
Message-ID: <202303200531.buTbR2TA-lkp@intel.com>
References: <20230319184728.49232-3-andrew.hepp@ahepp.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319184728.49232-3-andrew.hepp@ahepp.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andrew,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.3-rc2 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Hepp/dt-bindings-iio-Add-MCP9600-thermocouple-EMF-converter/20230320-024950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20230319184728.49232-3-andrew.hepp%40ahepp.dev
patch subject: [PATCH 2/2] iio: temperature: Add MCP9600 thermocouple EMF converter
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230320/202303200531.buTbR2TA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/dc26dd0d9cb47654a6910bf35d8531b90ae88ece
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andrew-Hepp/dt-bindings-iio-Add-MCP9600-thermocouple-EMF-converter/20230320-024950
        git checkout dc26dd0d9cb47654a6910bf35d8531b90ae88ece
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iio/temperature/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303200531.buTbR2TA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/temperature/mcp9600.c: In function 'mcp9600_read':
>> drivers/iio/temperature/mcp9600.c:51:16: warning: unused variable 'buf' [-Wunused-variable]
      51 |         __be16 buf;
         |                ^~~


vim +/buf +51 drivers/iio/temperature/mcp9600.c

    47	
    48	static int mcp9600_read(struct mcp9600_data *data,
    49				struct iio_chan_spec const *chan, int *val)
    50	{
  > 51		__be16 buf;
    52		int ret;
    53	
    54		mutex_lock(&data->read_lock);
    55		ret = i2c_smbus_read_word_swapped(data->client, chan->address);
    56		mutex_unlock(&data->read_lock);
    57	
    58		if (ret < 0)
    59			return ret;
    60		*val = ret;
    61	
    62		return 0;
    63	}
    64	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
