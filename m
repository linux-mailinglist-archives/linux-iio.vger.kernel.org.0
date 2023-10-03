Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243297B7257
	for <lists+linux-iio@lfdr.de>; Tue,  3 Oct 2023 22:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjJCUJP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Oct 2023 16:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjJCUJO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Oct 2023 16:09:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71610AB;
        Tue,  3 Oct 2023 13:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696363751; x=1727899751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m1jzLPKVwohtVS0OdopZyn0iGeijh4uOxRMQpSXsukI=;
  b=OL4v7ZHnqM2jcCNwXqroGe921w6x+WdJTD4WvPtfY8ZrXdyflfoXFQBQ
   8HNkE4SMZx2EAMQzIoHYsuYVPeK26H5Pjaw7I/VTfSJXDpP4yIavEkHaF
   eKcWzQ54Exo+VlSMWD+rn/z9Cibc74X0t1M7LtlXjs8+MJtpAeqfw3xQN
   zpDkkQK3W2MRZhfGTfWky+GJLf1qNL9H7ck2bFM2u/MViC5a0glYlBcUN
   a2YRxm9UY+sM0uudWQWQ2rGJvpYoudjRaVerxoB487lFk+9213WFfYLhn
   Oy2p7/v6StF0SOOcRR8cRtP5KrXGoeO1IoK/jFghupLe4CmQrQ3yIdWin
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="386840389"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="386840389"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 13:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841494545"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="841494545"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Oct 2023 13:09:07 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnlhY-0008t2-0L;
        Tue, 03 Oct 2023 20:09:04 +0000
Date:   Wed, 4 Oct 2023 04:08:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 24/27] staging: iio: resolver: ad2s1210: convert DOS
 mismatch threshold to event attr
Message-ID: <202310040309.rX4s31l7-lkp@intel.com>
References: <20230929-ad2s1210-mainline-v3-24-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929-ad2s1210-mainline-v3-24-fa4364281745@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5e99f692d4e32e3250ab18d511894ca797407aec]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/dt-bindings-iio-resolver-add-devicetree-bindings-for-ad2s1210/20230930-014031
base:   5e99f692d4e32e3250ab18d511894ca797407aec
patch link:    https://lore.kernel.org/r/20230929-ad2s1210-mainline-v3-24-fa4364281745%40baylibre.com
patch subject: [PATCH v3 24/27] staging: iio: resolver: ad2s1210: convert DOS mismatch threshold to event attr
config: i386-randconfig-062-20231003 (https://download.01.org/0day-ci/archive/20231004/202310040309.rX4s31l7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231004/202310040309.rX4s31l7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310040309.rX4s31l7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/staging/iio/resolver/ad2s1210.c:901:1: sparse: sparse: symbol 'iio_const_attr_in_phase0_mag_value_available' was not declared. Should it be static?
   drivers/staging/iio/resolver/ad2s1210.c:906:1: sparse: sparse: symbol 'iio_const_attr_in_altvoltage0_thresh_falling_value_available' was not declared. Should it be static?
   drivers/staging/iio/resolver/ad2s1210.c:907:1: sparse: sparse: symbol 'iio_const_attr_in_altvoltage0_thresh_rising_value_available' was not declared. Should it be static?
>> drivers/staging/iio/resolver/ad2s1210.c:908:1: sparse: sparse: symbol 'iio_const_attr_in_altvoltage0_mag_value_available' was not declared. Should it be static?
   drivers/staging/iio/resolver/ad2s1210.c:909:1: sparse: sparse: symbol 'iio_dev_attr_in_angl1_thresh_rising_value_available' was not declared. Should it be static?
   drivers/staging/iio/resolver/ad2s1210.c:910:1: sparse: sparse: symbol 'iio_dev_attr_in_angl1_thresh_rising_hysteresis_available' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
