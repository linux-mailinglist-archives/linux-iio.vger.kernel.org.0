Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B417156B9A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2020 17:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBIQr4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Feb 2020 11:47:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:19230 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgBIQr4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Feb 2020 11:47:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 08:47:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,422,1574150400"; 
   d="scan'208";a="431374169"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Feb 2020 08:47:52 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j0pkO-000Hkh-2o; Mon, 10 Feb 2020 00:47:52 +0800
Date:   Mon, 10 Feb 2020 00:47:28 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Daniel Campello <campello@chromium.org>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2] iio: Add SEMTECH SX9310/9311 sensor driver
Message-ID: <202002100001.BwAzqv0v%lkp@intel.com>
References: <20200206121647.1.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206121647.1.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on linux/master linus/master v5.5 next-20200207]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Daniel-Campello/iio-Add-SEMTECH-SX9310-9311-sensor-driver/20200209-180706
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-162-g98276e61-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/iio/proximity/sx9310.c:184:9: sparse: sparse: Using plain integer as NULL pointer
   drivers/iio/proximity/sx9310.c:185:9: sparse: sparse: Using plain integer as NULL pointer
   drivers/iio/proximity/sx9310.c:186:9: sparse: sparse: Using plain integer as NULL pointer

vim +184 drivers/iio/proximity/sx9310.c

   162	
   163	#define SX9310_CHANNEL(idx, name)					 \
   164		{								 \
   165			.type = IIO_PROXIMITY,					 \
   166			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		 \
   167			.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
   168			.indexed = 1,						 \
   169			.channel = idx,						 \
   170			.extend_name = name,					 \
   171			.address = SX9310_REG_DIFF_MSB,				 \
   172			.event_spec = sx9310_events,				 \
   173			.num_event_specs = ARRAY_SIZE(sx9310_events),		 \
   174			.scan_index = idx,					 \
   175			.scan_type = {						 \
   176				.sign = 's',					 \
   177				.realbits = 12,					 \
   178				.storagebits = 16,				 \
   179				.endianness = IIO_BE,				 \
   180			},							 \
   181		}
   182	
   183	static const struct iio_chan_spec sx9310_channels[] = {
 > 184		SX9310_CHANNEL(0, 0),		/* CS0 */
   185		SX9310_CHANNEL(1, 0),		/* CS1 */
   186		SX9310_CHANNEL(2, 0),		/* CS2 */
   187		SX9310_CHANNEL(3, "COMB"),	/* COMB */
   188	
   189		IIO_CHAN_SOFT_TIMESTAMP(4),
   190	};
   191	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
