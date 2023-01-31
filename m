Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F85682C9B
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 13:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjAaMeA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 07:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjAaMd7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 07:33:59 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F67367D7
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 04:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675168438; x=1706704438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=betIC65HqEH69taQ1gvEBw2hesfSBhnfJorML4KmNwQ=;
  b=bIX4PM2l8BSV3v2eO/QP3Aa+BoZcx2/3eOaCthSHDsE/F3G2aVD1O/BZ
   X6NB8OynIqkjJoa0odhh9ZEAwMupZ1yzXGxOHwFEIb1goU+sZHptnr4ZS
   qJJ7KMfePxgxBhwqjDXoiL1ElHoiM0MemD9MeqKg6yjtJwqtlHLGU8xEb
   tu9PRScNOqmcLn3jFfVHtyKmBQwO6zwTiBR96xo67BbmoQnulJhxFPaxF
   cSIiL2Ysh5cdW1BSljYLo7BajACvfH8Zgsgms0iYsMkBVNm4ojIEwhjAI
   6kWaZWNUHbB0+SfYvDZYgl0Ci0hWIukIarMYPjsGKEgImoNrp3LVwAzEN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="390189864"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="390189864"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:33:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657854668"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="657854668"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 31 Jan 2023 04:33:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMppi-000FRP-21;
        Tue, 31 Jan 2023 14:33:54 +0200
Date:   Tue, 31 Jan 2023 14:33:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2] iio: light: vcnl4000: Fix WARN_ON on uninitialized
 lock
Message-ID: <Y9kKsv7OJ1KoImjJ@smile.fi.intel.com>
References: <20230131102951.2012021-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131102951.2012021-1-marten.lindahl@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 31, 2023 at 11:29:51AM +0100, Mårten Lindahl wrote:
> There are different init functions for the sensors in this driver in
> which only one initialize the generic vcnl4000_lock. With commit

initializes ?

> e21b5b1f2669 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
> the vcnl4040 sensor started to depend on the lock, but it was missed to
> initialize it in vcnl4040's init function. This has not been visible
> until we run lockdep on it:
> 
>   DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>   at kernel/locking/mutex.c:575 __mutex_lock+0x4f8/0x890
>   Call trace:
>   __mutex_lock
>   mutex_lock_nested
>   vcnl4200_set_power_state
>   vcnl4200_init
>   vcnl4000_probe
>   i2c_device_probe
>   really_probe
>   __driver_probe_device
>   driver_probe_device
>   __driver_attach
>   bus_for_each_dev
>   driver_attach
>   bus_add_driver
>   driver_register
>   i2c_register_driver
>   vcnl4000_driver_init

E.g. the following can be cut without losing significance of the data
(see below as well).

>   do_one_initcall
>   do_init_module
>   load_module
>   __do_sys_finit_module

> Fix this by initializing the lock in the probe function instead of doing
> it in the chip specific init functions.
> 
> Fixes: e21b5b1f2669 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
> 
> v2:
>  - Trimmed backtrace in commit message

Not enough, please try harder. The ideal is to have ~3-5 lines of traceback.

>  - Have 12 digit sha-1 id in Fixes tag
>  - Make the lock initialization in probe instead of in _init function

...

>  	data->client = client;
>  	data->id = id->driver_data;
>  	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];

+ Blank line.

> +	mutex_init(&data->vcnl4000_lock);
>  
>  	ret = data->chip_spec->init(data);
>  	if (ret < 0)

-- 
With Best Regards,
Andy Shevchenko


