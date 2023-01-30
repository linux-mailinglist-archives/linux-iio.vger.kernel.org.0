Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B245B680DE4
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 13:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjA3MjS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 07:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbjA3MjR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 07:39:17 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D35EC4A
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 04:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675082356; x=1706618356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m2zCmkvwWEOGMOXWQX8qZkTe8gLorF6v8MrO+t6BYxY=;
  b=kgnz9cklRVXvNwHiXQdfAqjcsuuEw1DhAyBYSAyOebZ+V/mIhutQN5rn
   F7VjgDg0Q/cqvt5Rg6NQopIPvOs6MaUJlGAI4YDboUfbIL6V98CziPlht
   PhdSk1hUOUxEBvNGCigdN5ybe/hQJKRDL6onbZPX1RBCkGvXYeUenVdHy
   8JXear5CDM9NJ1zdeEae54IaabSSOyePwupd9gTW7vGRd9HZgeYSC1qRH
   6Z8JYY+8NUzGvvkEo8BH3Hm7FZhN+0/6d/aMQEAjry0HO0/OMBg1yhiQl
   w3heGW6AalQ/Vgb7eEcrxx5HQwnCsiEZF5IF93CQN6APVj+FYASgwKGKJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="327563497"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="327563497"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:39:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="696382741"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="696382741"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 30 Jan 2023 04:39:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMTRI-00HLgM-2G;
        Mon, 30 Jan 2023 14:39:12 +0200
Date:   Mon, 30 Jan 2023 14:39:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] iio: light: vcnl4000: Fix WARN_ON on uninitialized lock
Message-ID: <Y9e6cGDYxkrTtQtC@smile.fi.intel.com>
References: <20230130093742.838577-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230130093742.838577-1-marten.lindahl@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 30, 2023 at 10:37:42AM +0100, Mårten Lindahl wrote:
> There are different init functions for the sensors in this driver in
> which only one initialize the generic vcnl4000_lock. With commit
> e21b5b1f2 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
> the vcnl4040 sensor started to depend on the lock, but it was missed to
> initialize it in vcnl4040's init function. This has not been visible
> until we run lockdep on it:

>   DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>   WARNING: CPU: 1 PID: 8800 at kernel/locking/mutex.c:575 __mutex_lock+0x4f8/0x890
>   ...
>   Call trace:
>    __mutex_lock
>    mutex_lock_nested
>    vcnl4200_set_power_state
>    vcnl4200_init
>    vcnl4000_probe
>    i2c_device_probe
>    really_probe
>    __driver_probe_device
>    driver_probe_device
>    __driver_attach
>    bus_for_each_dev
>    driver_attach
>    bus_add_driver
>    driver_register
>    i2c_register_driver
>    vcnl4000_driver_init
>    do_one_initcall
>    do_init_module
>    load_module
>    __do_sys_finit_module
>    ...

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages

Otherwise looks good to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fix this by adding mutex_init on the lock in the init function used for
> vcnl4040.
> 
> Fixes: e21b5b1f2 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
>  drivers/iio/light/vcnl4000.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index cc1a2062e76d..a8a9fc3b1a02 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -316,6 +316,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  	}
>  	mutex_init(&data->vcnl4200_al.lock);
>  	mutex_init(&data->vcnl4200_ps.lock);
> +	mutex_init(&data->vcnl4000_lock);
>  
>  	ret = data->chip_spec->set_power_state(data, true);
>  	if (ret < 0)
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


