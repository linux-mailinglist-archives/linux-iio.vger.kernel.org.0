Return-Path: <linux-iio+bounces-310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB507F7068
	for <lists+linux-iio@lfdr.de>; Fri, 24 Nov 2023 10:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E091F20EFD
	for <lists+linux-iio@lfdr.de>; Fri, 24 Nov 2023 09:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CF617754;
	Fri, 24 Nov 2023 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJje4ZPg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C2B10E7;
	Fri, 24 Nov 2023 01:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700819354; x=1732355354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OP/cCaco1RCdcFyVZXX4kd8okOpF/N7a+QQ1IHCxz4g=;
  b=QJje4ZPgWRfH4tBmM0aI8W9DANEpRFfyuRWrXJTUejnj2DIi99Ll1fUc
   St+yqSx8vvn7SMnysBF6bANalEyHZKI9K137P2FTbn8MMEnRcvK8WaXiJ
   ki348KT4gzwyEuWsgFvbBXPctufXWIPZ6LhODrzvlJDnFLUP7QyDuvCYi
   K/4yS/2JPehGUCowp7FsE9Lh3gQQRHo8P4JtBOqINiRpIr+Wa4RSWO6NV
   dpWDKVplItVw2AkgTfM3OmkAHybDGjTiUT9KxeiyCsFZ7Z2OY8z1H/bf6
   RzA4GxSPIKbSfA63bA6OPwzBp85ttcartvf1QkE4F22GTSP42YrWHokzZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="423534658"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="423534658"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:49:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="717327111"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="717327111"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Nov 2023 01:49:08 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6So6-0002LA-0K;
	Fri, 24 Nov 2023 09:49:06 +0000
Date: Fri, 24 Nov 2023 17:49:02 +0800
From: kernel test robot <lkp@intel.com>
To: mitrutzceclan <mitrutzceclan@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
	linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v6 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <202311241251.qDeS0ZtB-lkp@intel.com>
References: <20231123152331.5751-2-user@HYB-hhAwRlzzMZb>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123152331.5751-2-user@HYB-hhAwRlzzMZb>

Hi mitrutzceclan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/mitrutzceclan/iio-adc-ad7173-add-AD7173-driver/20231123-233012
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231123152331.5751-2-user%40HYB-hhAwRlzzMZb
patch subject: [PATCH v6 2/2] iio: adc: ad7173: add AD7173 driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231124/202311241251.qDeS0ZtB-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241251.qDeS0ZtB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241251.qDeS0ZtB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ad7173.c:329:22: warning: variable 'offset' set but not used [-Wunused-but-set-variable]
           ptrdiff_t cmp_size, offset;
                               ^
   1 warning generated.


vim +/offset +329 drivers/iio/adc/ad7173.c

   324	
   325	static struct ad7173_channel_config *
   326	ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *cfg)
   327	{
   328		struct ad7173_channel_config *cfg_aux;
 > 329		ptrdiff_t cmp_size, offset;
   330		int i;
   331	
   332		offset = offsetofend(struct ad7173_channel_config, live);
   333		cmp_size = sizeof_field(struct ad7173_channel_config, config_props);
   334	
   335		for (i = 0; i < st->num_channels; i++) {
   336			cfg_aux = &st->channels[i].cfg;
   337	
   338			if (cfg_aux->live &&
   339			    !memcmp(&cfg->bipolar, &cfg_aux->bipolar, cmp_size))
   340				return cfg_aux;
   341		}
   342		return NULL;
   343	}
   344	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

