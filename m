Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C21F2B7F
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jun 2020 02:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbgFIAQB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 20:16:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:19508 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732892AbgFIAPW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Jun 2020 20:15:22 -0400
IronPort-SDR: Z2XkLtwfSAslRmJZ3d7rk5/cuWRpnInUN2YW9JdmQAnTlxopkWLsYG7782hdQ2ihYXF0fr7ldQ
 ha3w3KEol9iA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 17:15:22 -0700
IronPort-SDR: qbPVQki+36XgabtS5oHGJy8ZtNY2h1ErJWojOu92iiJpE6H/FNYnEEV0Zuwe6ir3rSdGZ7lwNE
 vQhFwRYuYNtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,489,1583222400"; 
   d="scan'208";a="418227405"
Received: from lkp-server01.sh.intel.com (HELO 12d5c0ac8e64) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Jun 2020 17:15:20 -0700
Received: from kbuild by 12d5c0ac8e64 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jiRvD-00001V-Fz; Tue, 09 Jun 2020 00:15:19 +0000
Date:   Tue, 9 Jun 2020 04:18:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, jic23@kernel.org,
        andy.shevchenko@gmail.com, pmeerw@pmeerw.net,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: Re: [PATCH v5 1/4] iio: chemical: scd30: add core driver
Message-ID: <202006090426.ENCJHJ1n%lkp@intel.com>
References: <20200607175812.95777-2-tomasz.duszynski@octakon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607175812.95777-2-tomasz.duszynski@octakon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Tomasz,

I love your patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on robh/for-next linux/master v5.7]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Tomasz-Duszynski/Add-support-for-SCD30-sensor/20200608-020304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/iio/chemical/scd30_core.c:93:31: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
        sign = float32 & BIT(31) ? -1 : 1,
                                 ^

vim +93 drivers/iio/chemical/scd30_core.c

    87	
    88	/* simplified float to fixed point conversion with a scaling factor of 0.01 */
    89	static int scd30_float_to_fp(int float32)
    90	{
    91		int fraction, shift,
    92		    mantissa = float32 & GENMASK(22, 0),
  > 93		    sign = float32 & BIT(31) ? -1 : 1,
    94		    exp = (float32 & ~BIT(31)) >> 23;
    95	
    96		/* special case 0 */
    97		if (!exp && !mantissa)
    98			return 0;
    99	
   100		exp -= 127;
   101		if (exp < 0) {
   102			exp = -exp;
   103			/* return values ranging from 1 to 99 */
   104			return sign * ((((BIT(23) + mantissa) * 100) >> 23) >> exp);
   105		}
   106	
   107		/* return values starting at 100 */
   108		shift = 23 - exp;
   109		float32 = BIT(exp) + (mantissa >> shift);
   110		fraction = mantissa & GENMASK(shift - 1, 0);
   111	
   112		return sign * (float32 * 100 + ((fraction * 100) >> shift));
   113	}
   114	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
