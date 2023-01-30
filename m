Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8B1680E68
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 14:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjA3NEW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 30 Jan 2023 08:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjA3NEW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 08:04:22 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646731724
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 05:04:21 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P57b04r1yz6H7MZ;
        Mon, 30 Jan 2023 21:00:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 13:04:19 +0000
Date:   Mon, 30 Jan 2023 13:04:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     =?ISO-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH] iio: light: vcnl4000: Fix WARN_ON on uninitialized lock
Message-ID: <20230130130418.000013ce@Huawei.com>
In-Reply-To: <20230130093742.838577-1-marten.lindahl@axis.com>
References: <20230130093742.838577-1-marten.lindahl@axis.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Jan 2023 10:37:42 +0100
Mårten Lindahl <marten.lindahl@axis.com> wrote:

> There are different init functions for the sensors in this driver in
> which only one initialize the generic vcnl4000_lock. With commit
> e21b5b1f2 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
> the vcnl4040 sensor started to depend on the lock, but it was missed to
> initialize it in vcnl4040's init function. This has not been visible
> until we run lockdep on it:
> 
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
> 
> Fix this by adding mutex_init on the lock in the init function used for
> vcnl4040.
> 
> Fixes: e21b5b1f2 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>

Perhaps better to pull the lock out of the device specific setup?


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

