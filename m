Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDCD7B6F99
	for <lists+linux-iio@lfdr.de>; Tue,  3 Oct 2023 19:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbjJCRVb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Oct 2023 13:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjJCRVb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Oct 2023 13:21:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2830FAF;
        Tue,  3 Oct 2023 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696353688; x=1727889688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m63g1gNKTI5G9AU4v2NJZq6BCzlj3PUdfIwwcDby6Lw=;
  b=ck3ZCIV1DatqvkrvnXDkHXq5pr1n55t/SYVaw9RyJ2iiDrCkUKLAwQOb
   fOlHW6/TywcL2hZ6cpr6Q3TvrXP10xcFKNkYHnSz4WFHYBnUS0q+/RS64
   ysnlgBqM/w5QZekztE2dVwz8tDraWehKJVc2wGDBKbb+cIpk37my6ECyE
   KnetZftX/HiCn9IG/i0fodJNjERJKcIaYJTwuOTOK8wrmwDbnb10kfmmk
   WQ8OxM7bX4nv0S7BIAfHV9RYx4419o3sS7eBC3iZoNJ0ksJvvdPBf9/pk
   YxF1ens8wRl1C6wkTOARum7LJg1NIWLhUjvWXXoM6spt1jrPaC7aEvxJQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="469212695"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="469212695"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 10:21:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="780386287"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="780386287"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 03 Oct 2023 10:21:23 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnj5F-0007jp-0c;
        Tue, 03 Oct 2023 17:21:21 +0000
Date:   Wed, 4 Oct 2023 01:21:03 +0800
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
Subject: Re: [PATCH v3 23/27] staging: iio: resolver: ad2s1210: convert DOS
 overrange threshold to event attr
Message-ID: <202310040023.rI6mfueI-lkp@intel.com>
References: <20230929-ad2s1210-mainline-v3-23-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929-ad2s1210-mainline-v3-23-fa4364281745@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20230929-ad2s1210-mainline-v3-23-fa4364281745%40baylibre.com
patch subject: [PATCH v3 23/27] staging: iio: resolver: ad2s1210: convert DOS overrange threshold to event attr
config: i386-randconfig-062-20231003 (https://download.01.org/0day-ci/archive/20231004/202310040023.rI6mfueI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231004/202310040023.rI6mfueI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310040023.rI6mfueI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/staging/iio/resolver/ad2s1210.c:899:1: sparse: sparse: symbol 'iio_const_attr_in_phase0_mag_value_available' was not declared. Should it be static?
   drivers/staging/iio/resolver/ad2s1210.c:904:1: sparse: sparse: symbol 'iio_const_attr_in_altvoltage0_thresh_falling_value_available' was not declared. Should it be static?
>> drivers/staging/iio/resolver/ad2s1210.c:905:1: sparse: sparse: symbol 'iio_const_attr_in_altvoltage0_thresh_rising_value_available' was not declared. Should it be static?
   drivers/staging/iio/resolver/ad2s1210.c:906:1: sparse: sparse: symbol 'iio_dev_attr_in_angl1_thresh_rising_value_available' was not declared. Should it be static?
   drivers/staging/iio/resolver/ad2s1210.c:907:1: sparse: sparse: symbol 'iio_dev_attr_in_angl1_thresh_rising_hysteresis_available' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
