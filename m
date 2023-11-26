Return-Path: <linux-iio+bounces-390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB07F92EA
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 14:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCA85B20CB0
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BFCD28C;
	Sun, 26 Nov 2023 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuOfy3uM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0676EE4;
	Sun, 26 Nov 2023 05:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701007138; x=1732543138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SN94Lks4ftl2se1ieiieBfV6GGIAHmqi015IwlWk5JI=;
  b=AuOfy3uMNI4WoYfYQNj2c9jg5owiMmVEYkFbsv/6ZujQQpPxxHHbJCBv
   Ih6eujDhu5ab9QOnNm1FB969Q0id5ASpQYeaO3TUVsNjtlgoGoXy3hYB1
   0oNX8zHJl2movZrb68ISUTC6MkGdGTLHozUHFzfBnnNbPfaAjX5pHy58Q
   qmX68LG37qXKdt7ukC8K8ArIrA5iEbHbD36Sic+kpm6TqkIT37guPsmde
   rC8LIejPCHBFjz5XRuR4b+6qdKi25pbADtNLXl4/9wABLDEXVrCqUAaQv
   TVoj/gonkoCK3ikTeZsZemNl6rDKxeBHTNOfvMKefWWWWWiMnOJvmbLLk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="11264544"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="11264544"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 05:58:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="834091873"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="834091873"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Nov 2023 05:58:53 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r7Fet-0005DL-2Y;
	Sun, 26 Nov 2023 13:58:51 +0000
Date: Sun, 26 Nov 2023 21:58:37 +0800
From: kernel test robot <lkp@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series pressure sensors
Message-ID: <202311262123.aVuN3lZS-lkp@intel.com>
References: <20231126102721.15322-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126102721.15322-1-petre.rodan@subdimension.ro>

Hi Petre,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Petre-Rodan/iio-pressure-driver-for-Honeywell-HSC-SSC-series-pressure-sensors/20231126-182901
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231126102721.15322-1-petre.rodan%40subdimension.ro
patch subject: [PATCH v3 2/2] iio: pressure: driver for Honeywell HSC/SSC series pressure sensors
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231126/202311262123.aVuN3lZS-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231126/202311262123.aVuN3lZS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311262123.aVuN3lZS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/pressure/hsc030pa.c:48: warning: cannot understand function prototype: 'const struct hsc_func_spec hsc_func_spec[] = '
>> drivers/iio/pressure/hsc030pa.c:253: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * IIO ABI expects


vim +48 drivers/iio/pressure/hsc030pa.c

    41	
    42	/**
    43	 * function A: 10% - 90% of 2^14
    44	 * function B:  5% - 95% of 2^14
    45	 * function C:  5% - 85% of 2^14
    46	 * function F:  4% - 94% of 2^14
    47	 */
  > 48	static const struct hsc_func_spec hsc_func_spec[] = {
    49		[HSC_FUNCTION_A] = {.output_min = 1638, .output_max = 14746},
    50		[HSC_FUNCTION_B] = {.output_min =  819, .output_max = 15565},
    51		[HSC_FUNCTION_C] = {.output_min =  819, .output_max = 13926},
    52		[HSC_FUNCTION_F] = {.output_min =  655, .output_max = 15401},
    53	};
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

