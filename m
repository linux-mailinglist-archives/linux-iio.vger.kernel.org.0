Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FB7682D0B
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 13:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjAaMxY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 07:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjAaMxX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 07:53:23 -0500
X-Greylist: delayed 385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Jan 2023 04:53:21 PST
Received: from out-220.mta1.migadu.com (out-220.mta1.migadu.com [IPv6:2001:41d0:203:375::dc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9B04C0C0
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 04:53:21 -0800 (PST)
Date:   Tue, 31 Jan 2023 20:46:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675169212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yvPOSVrO4hyRM75U3SVFrwfhdckqIPTpAUtg39DNR/c=;
        b=E0/kIhKjZDnfH/NvNmr3LHLVLn4xc8+WIrPc9QjCsozFBRlng9gnfResr+dIzlxoB7YgUS
        HQbg/JzeyaOXUjTKq8lTIpn/NFSZZ7dx08185NsZFN8J2ZkClsQmaJc9BSUabKAOzLypIg
        tceqkVwhAr9QVd83YOKcPponE4dK9eI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     =?utf-8?Q?M=C3=A5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2] iio: light: vcnl4000: Fix WARN_ON on uninitialized
 lock
Message-ID: <Y9kNuPlRBVCnCHFb@chq-MS-7D45>
References: <20230131102951.2012021-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131102951.2012021-1-marten.lindahl@axis.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 31 1月 23 11:29:51, Mårten Lindahl wrote:
> There are different init functions for the sensors in this driver in
> which only one initialize the generic vcnl4000_lock. With commit
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
>   do_one_initcall
>   do_init_module
>   load_module
>   __do_sys_finit_module
> 
> Fix this by initializing the lock in the probe function instead of doing
> it in the chip specific init functions.
> 
> Fixes: e21b5b1f2669 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
> 
> v2:
>  - Trimmed backtrace in commit message
>  - Have 12 digit sha-1 id in Fixes tag
>  - Make the lock initialization in probe instead of in _init function
> 
>  drivers/iio/light/vcnl4000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index b5d398228289..caa2fff9f486 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -208,7 +208,6 @@ static int vcnl4000_init(struct vcnl4000_data *data)
>  
>  	data->rev = ret & 0xf;
>  	data->al_scale = 250000;
> -	mutex_init(&data->vcnl4000_lock);
>  
>  	return data->chip_spec->set_power_state(data, true);
>  };
> @@ -1366,6 +1365,7 @@ static int vcnl4000_probe(struct i2c_client *client,
>  	data->client = client;
>  	data->id = id->driver_data;
>  	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
> +	mutex_init(&data->vcnl4000_lock);
>  
>  	ret = data->chip_spec->init(data);
>  	if (ret < 0)
Why not add mutex_init(&data->vcnl4000_lock) in vcnl4200_init.
like this

@@ -330,6 +330,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
        }
        mutex_init(&data->vcnl4200_al.lock);
        mutex_init(&data->vcnl4200_ps.lock);
+       mutex_init(&data->vcnl4000_lock);

        ret = data->chip_spec->set_power_state(data, true);
        if (ret < 0)

Perfer adding mutex_init to vcnl4200_init.
> -- 
> 2.30.2
> 
