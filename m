Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC09DEAE00
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2019 11:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfJaK5Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Oct 2019 06:57:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:54178 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbfJaK5U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 31 Oct 2019 06:57:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 03:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="204169799"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Oct 2019 03:57:15 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iQ88h-000HKK-Bl; Thu, 31 Oct 2019 18:57:15 +0800
Date:   Thu, 31 Oct 2019 18:56:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     kbuild-all@lists.01.org, jic23@kernel.org,
        devel@driverdev.osuosl.org, mark.rutland@arm.com, lars@metafoo.de,
        biabeniamin@outlook.com, Michael.Hennerich@analog.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
        robh+dt@kernel.org, Beniamin Bia <beniamin.bia@analog.com>,
        pmeerw@pmeerw.net, knaack.h@gmx.de, mchehab+samsung@kernel.org,
        paulmck@linux.ibm.com, Paul Cercueil <paul.cercueil@analog.com>
Subject: Re: [PATCH v2 2/4] iio: adc: ad7091r5: Add scale and external VREF
 support
Message-ID: <201910311822.8dBF4MQ7%lkp@intel.com>
References: <20191029162928.9720-2-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029162928.9720-2-beniamin.bia@analog.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Beniamin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on v5.4-rc5 next-20191030]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Beniamin-Bia/iio-adc-Add-support-for-AD7091R5-ADC/20191031-100114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/iio/adc/ad7091r-base.c:207:6: sparse: sparse: symbol 'ad7091r_remove' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
