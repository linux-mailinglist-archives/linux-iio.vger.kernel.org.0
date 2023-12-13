Return-Path: <linux-iio+bounces-750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC46180A336
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 13:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE58D1C20A13
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 12:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AE01C694;
	Fri,  8 Dec 2023 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVnVUqtW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0C1985;
	Fri,  8 Dec 2023 04:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702038513; x=1733574513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=If8qLm6cpoDJFIWwu0cUf4BU9e2+2LBt0MRWIQsNk9c=;
  b=aVnVUqtWrHrDi44OxrYcgZWTiguHAt2kYxGxMqomIIvXVWctorisx/EV
   OxaqkvesBZDcfwtbd0jfZEHZCkuo7vfE0wsDwUk9mH+xxFCR5iCqoUHd6
   hpTjrpvVtNGrrxL7umLzfsJjiA4uk7t6iNftGCb71Ut8UXnyLyV1UdDhG
   0MHJL8r8umivHv9ocyPEVOXFBZEHq0G053jLpuxc408YuZSVXX4uXS6YW
   +zVWOMPw0PWaKWd3RVwOaGoPimTwBRtR4HHqMr6PfuULNEjQ3Tmv9Loam
   JF4hcgKQyYeNJJacv3WXkqQ2S7lhiiVYZUacqOPeOzWE+Kn3TUl8jPI1l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="391569982"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="391569982"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 04:28:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="775776705"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="775776705"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 08 Dec 2023 04:28:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBZxs-000Dio-1b;
	Fri, 08 Dec 2023 12:28:20 +0000
Date: Fri, 8 Dec 2023 20:28:03 +0800
From: kernel test robot <lkp@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
	joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	paul.cercueil@analog.com, Michael.Hennerich@analog.com,
	lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dan.carpenter@linaro.org, marcelo.schmitt1@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/13] iio: adc: ad7091r: Move chip init data to
 container struct
Message-ID: <202312082022.IOtnLeck-lkp@intel.com>
References: <f45d5dfde5fc2082ac1fcac18a4a3e9b4b941402.1701971344.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f45d5dfde5fc2082ac1fcac18a4a3e9b4b941402.1701971344.git.marcelo.schmitt1@gmail.com>

Hi Marcelo,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.7-rc4 next-20231208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/scripts-checkpatch-Add-__aligned-to-the-list-of-attribute-notes/20231208-063850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/f45d5dfde5fc2082ac1fcac18a4a3e9b4b941402.1701971344.git.marcelo.schmitt1%40gmail.com
patch subject: [PATCH v3 6/13] iio: adc: ad7091r: Move chip init data to container struct
config: arm-randconfig-002-20231208 (https://download.01.org/0day-ci/archive/20231208/202312082022.IOtnLeck-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231208/202312082022.IOtnLeck-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312082022.IOtnLeck-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/adc/ad7091r5.c:30:3: error: field designator 'name' does not refer to any field in type 'const struct ad7091r_chip_info'
           .name = "ad7091r-5",
            ^
   drivers/iio/adc/ad7091r5.c:37:3: error: field designator 'name' does not refer to any field in type 'const struct ad7091r_chip_info'
           .name = "ad7091r-5",
            ^
>> drivers/iio/adc/ad7091r5.c:59:14: error: initializer element is not a compile-time constant
           .irq_info = ad7091r5_chip_info_irq,
                       ^~~~~~~~~~~~~~~~~~~~~~
   3 errors generated.


vim +59 drivers/iio/adc/ad7091r5.c

    57	
    58	static struct ad7091r_init_info ad7091r5_init_info = {
  > 59		.irq_info = ad7091r5_chip_info_irq,
    60		.info_no_irq = ad7091r5_chip_info_noirq,
    61		.regmap_config = &ad7091r_regmap_config,
    62		.ad7091r_regmap_init = &ad7091r5_regmap_init
    63	};
    64	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

