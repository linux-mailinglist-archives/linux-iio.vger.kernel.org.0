Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A28682EF3
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 15:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjAaOOS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 09:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjAaOOR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 09:14:17 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F299ED9
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 06:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675174455; x=1706710455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LLm+B7o2NbM7XgOkUcBet+EORQHb3L9RG+5xl3oLqdE=;
  b=UyuTFziuSvhuoC1zIrUzFolndMUjQJal4N2yYPsYOWHWqVZSjWpAu52r
   6bcoG/37edSeUlNft0rZhOY7nfSixp5Gp2vxLM3IGn6kkBXCstDD7x8LZ
   wHzOJ+nuqzB9hI6EtjvU4UypO3/ACuKRJOdgd8eCrJbFMxti3G119Nd2I
   bRX1llrcrQvI9GKRUJkTvqFigm7yKvR5sWL4MQXaBq3AIw6zSLjOZarMx
   Z2hIeHEoSYI8j2JCV6xB0+33kFBFmvPh200fndIHorYngbizNfqAK5WXM
   t8hf4HJXuo8tcgy/qtxeT1G11HEBxtqTxhIG5rO71yAgIsmBRLjeVNXHQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="414065384"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="414065384"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 06:14:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="641989899"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="641989899"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 31 Jan 2023 06:14:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMrOm-000HiR-0D;
        Tue, 31 Jan 2023 16:14:12 +0200
Date:   Tue, 31 Jan 2023 16:14:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v3] iio: light: vcnl4000: Fix WARN_ON on uninitialized
 lock
Message-ID: <Y9kiM768ZSkuK+Mk@smile.fi.intel.com>
References: <20230131140109.2067577-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131140109.2067577-1-marten.lindahl@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 31, 2023 at 03:01:09PM +0100, Mårten Lindahl wrote:
> There are different init functions for the sensors in this driver in
> which only one initializes the generic vcnl4000_lock. With commit
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
> 
> Fix this by initializing the lock in the probe function instead of doing
> it in the chip specific init functions.

Fine now, thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: e21b5b1f2669 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
> 
> v3:
>  - Trimmed backtrace in commit message even more
>  - New line before mutex_init
> 
> v2:
>  - Trimmed backtrace in commit message
>  - Have 12 digit sha-1 id in Fixes tag
>  - Make the lock initialization in probe instead of in _init function
> 
>  drivers/iio/light/vcnl4000.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index cc1a2062e76d..69c5bc987e26 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -199,7 +199,6 @@ static int vcnl4000_init(struct vcnl4000_data *data)
>  
>  	data->rev = ret & 0xf;
>  	data->al_scale = 250000;
> -	mutex_init(&data->vcnl4000_lock);
>  
>  	return data->chip_spec->set_power_state(data, true);
>  };
> @@ -1197,6 +1196,8 @@ static int vcnl4000_probe(struct i2c_client *client)
>  	data->id = id->driver_data;
>  	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
>  
> +	mutex_init(&data->vcnl4000_lock);
> +
>  	ret = data->chip_spec->init(data);
>  	if (ret < 0)
>  		return ret;
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


