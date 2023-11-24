Return-Path: <linux-iio+bounces-307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D927F6D48
	for <lists+linux-iio@lfdr.de>; Fri, 24 Nov 2023 08:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34DF281B61
	for <lists+linux-iio@lfdr.de>; Fri, 24 Nov 2023 07:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913FA9461;
	Fri, 24 Nov 2023 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qczo4Umt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E143DD67;
	Thu, 23 Nov 2023 23:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700812659; x=1732348659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DKmAQ2qYw1sLOGN0fetMZdbxePUZXL0fXN+bc7UmtX0=;
  b=Qczo4UmtJej1gVz+0q0h/oKX0j6wZgdHGqmi5piqeTrNqtZiTISiAMeT
   Y7HB3BbBQaDsYdi/ibo+nSeQRnKja3cnOLP+bTVZWhNviiTaMj77ss6lK
   0WpfYeuDApDFy4Bq8taXJyWM3FC5NrY2NHBjnxn2Mq9J1qxYtraHa0M3V
   i/UiwVcjbprAeOUaN6m8RKuFuR9AXgu/C4Zvc+ITPu/3LhpJarZ1nlULt
   9fyv+2smAJ5cuQabW/P6ri3PhpPDEnn6fNUOF01L3pyGySp2+o3UlzRaU
   1mzAVCdLU7i9qPx+64WAxPQOIOS+39fgptPWMYU08+u8QOlod7IXi0uF9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="395199304"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="395199304"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 23:57:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767393124"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="767393124"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2023 23:57:35 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6R49-0002F4-1m;
	Fri, 24 Nov 2023 07:57:33 +0000
Date: Fri, 24 Nov 2023 15:56:33 +0800
From: kernel test robot <lkp@intel.com>
To: Anshul Dalal <anshulusr@gmail.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Anshul Dalal <anshulusr@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 3/3] iio: chemical: add support for Aosong AGS02MA
Message-ID: <202311241129.HrMrED0B-lkp@intel.com>
References: <20231121095800.2180870-3-anshulusr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121095800.2180870-3-anshulusr@gmail.com>

Hi Anshul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshul-Dalal/dt-bindings-iio-chemical-add-aosong-ags02ma/20231121-180435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231121095800.2180870-3-anshulusr%40gmail.com
patch subject: [PATCH v3 3/3] iio: chemical: add support for Aosong AGS02MA
config: s390-randconfig-r081-20231123 (https://download.01.org/0day-ci/archive/20231124/202311241129.HrMrED0B-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241129.HrMrED0B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241129.HrMrED0B-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/chemical/ags02ma.c:150:34: warning: unused variable 'ags02ma_of_table' [-Wunused-const-variable]
     150 | static const struct of_device_id ags02ma_of_table[] = {
         |                                  ^
   1 warning generated.


vim +/ags02ma_of_table +150 drivers/iio/chemical/ags02ma.c

   149	
 > 150	static const struct of_device_id ags02ma_of_table[] = {
   151		{ .compatible = "aosong,ags02ma"},
   152		{ /* Sentinel */ }
   153	};
   154	MODULE_DEVICE_TABLE(of, ags02ma_of_table);
   155	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

