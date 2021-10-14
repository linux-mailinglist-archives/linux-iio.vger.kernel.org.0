Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EEE42D4B1
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 10:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhJNIWp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Oct 2021 04:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230010AbhJNIWo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Oct 2021 04:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634199640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3w7eqEeIgw3Ia32urFoj+WNGzCCaXj1QmEFIPhfgcAU=;
        b=O1CP49m2NRySJZfgx3OLRpqJxLFYbSJq71o7lOjLsKh2/Q/PPkIhPMxhKCq/9ZVjFg0Lfo
        V5mMXRT/tRPiWIsdo4TzeXDE3i5kIPcKZvXDjj1KCYN8C/eNVSGPFLJKsJILvWZQkACmp4
        q0Ea4yIom17DlxA4B7IgSy9UY4P0iE8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-TUb6jawNM8KV2JUb-49oUg-1; Thu, 14 Oct 2021 04:20:36 -0400
X-MC-Unique: TUb6jawNM8KV2JUb-49oUg-1
Received: by mail-ed1-f72.google.com with SMTP id l10-20020a056402230a00b003db6977b694so4468326eda.23
        for <linux-iio@vger.kernel.org>; Thu, 14 Oct 2021 01:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3w7eqEeIgw3Ia32urFoj+WNGzCCaXj1QmEFIPhfgcAU=;
        b=kcz+mtRH0u/87ehjh0KsixXrd+o5gs1WjuX+1gouZQ5t5BlIE6dAwEKwEOBKqM3sKP
         +gq/8vt9hmZEjzvDc6MYS5V41yfr4Vsw8Gxzo0eyADV+naEwf76P3Y08lR7EDG3u3xoi
         TZG+uo5bqLrwhjZUD/CN8PQWCWKHFj5oOFR3gJofMlaMw17fS8AspoKR0sI3G2WdRLNt
         fjI/9YPuBMUp65dyulyTaUSIrO/SlXNBVf/+mIE495giwinPDERQrGpBEkF2MHdtkUDs
         aWjnfi90d9/MlP0arfILDDp2fB3YZSoHJz/uTnVLNlXY+B/1tBzUvq8Kkc8uLLOO9VEU
         IKyA==
X-Gm-Message-State: AOAM531ZFDK+ZxlSL5cJvrMFuCfXNkl2GhYdqpL40Vg9RHstadM4A8CQ
        zr1OgcLWgYyk4yegpbywh4yY6oZowx5FnsMbdX3wg5AjTmDL1iqq9rCsfCPM+s3X1hDRFhcgcpJ
        /lQscTM5Vva9ErealSSpA
X-Received: by 2002:a17:906:7c4f:: with SMTP id g15mr1986712ejp.373.1634199635734;
        Thu, 14 Oct 2021 01:20:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ/yUyAY5+oLZfeZT36vqeG4laaBllFBim5CmgaOeq8paHr5vHxI/UVJ6rhjgL1uBj4rghbA==
X-Received: by 2002:a17:906:7c4f:: with SMTP id g15mr1986691ejp.373.1634199635532;
        Thu, 14 Oct 2021 01:20:35 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s3sm1355877ejm.49.2021.10.14.01.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 01:20:35 -0700 (PDT)
Subject: Re: [PATCH] iio: accel: kxcjk-1013: Fix possible memory leak in probe
 and remove
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, jic23@kernel.org,
        andriy.shevchenko@linux.intel.com, ddvlad@gmail.com
References: <20211014035338.3750416-1-yangyingliang@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1a3a5582-51b0-4c58-ad6a-a58025054128@redhat.com>
Date:   Thu, 14 Oct 2021 10:20:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211014035338.3750416-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 10/14/21 5:53 AM, Yang Yingliang wrote:
> When ACPI type is ACPI_SMO8500, the data->dready_trig will not be set, the
> memory allocated by iio_triggered_buffer_setup() will not be freed, and cause
> memory leak as follows:
> 
> unreferenced object 0xffff888009551400 (size 512):
>   comm "i2c-SMO8500-125", pid 911, jiffies 4294911787 (age 83.852s)
>   hex dump (first 32 bytes):
>     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 20 e2 e5 c0 ff ff ff ff  ........ .......
>   backtrace:
>     [<0000000041ce75ee>] kmem_cache_alloc_trace+0x16d/0x360
>     [<000000000aeb17b0>] iio_kfifo_allocate+0x41/0x130 [kfifo_buf]
>     [<000000004b40c1f5>] iio_triggered_buffer_setup_ext+0x2c/0x210 [industrialio_triggered_buffer]
>     [<000000004375b15f>] kxcjk1013_probe+0x10c3/0x1d81 [kxcjk_1013]
>     [<0000000020115b9a>] i2c_device_probe+0xa31/0xbe0
>     [<00000000d9f581a6>] really_probe+0x299/0xc30
>     [<00000000c6c16cde>] __driver_probe_device+0x357/0x500
>     [<00000000909852a1>] driver_probe_device+0x4e/0x140
>     [<000000008419ba53>] __device_attach_driver+0x257/0x340
>     [<00000000533bb466>] bus_for_each_drv+0x166/0x1e0
>     [<000000005bf45d75>] __device_attach+0x272/0x420
>     [<0000000075220311>] bus_probe_device+0x1eb/0x2a0
>     [<0000000015587e85>] device_add+0xbf0/0x1f90
>     [<0000000086901b9e>] i2c_new_client_device+0x622/0xb20
>     [<000000000865ca18>] new_device_store+0x1fa/0x420
>     [<0000000059a3d183>] dev_attr_store+0x58/0x80
> 
> Fix it by remove data->dready_trig condition in probe and remove.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: a25691c1f967 ("iio: accel: kxcjk1013: allow using an external trigger")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Hmm, wouldn't the right fix be to also move the
iio_triggered_buffer_setup() call to inside the:

	if (client->irq > 0 && data->acpi_type != ACPI_SMO8500) {
	}

block ?

Jonathan (jic23) can you take a look at this, to me it seems that having
a triggered buffer allocated without any triggers is not useful ?

Regards,

Hans



> ---
>  drivers/iio/accel/kxcjk-1013.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index a51fdd3c9b5b..24c9387c2968 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1595,8 +1595,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
>  	return 0;
>  
>  err_buffer_cleanup:
> -	if (data->dready_trig)
> -		iio_triggered_buffer_cleanup(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  err_trigger_unregister:
>  	if (data->dready_trig)
>  		iio_trigger_unregister(data->dready_trig);
> @@ -1618,8 +1617,8 @@ static int kxcjk1013_remove(struct i2c_client *client)
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
>  
> +	iio_triggered_buffer_cleanup(indio_dev);
>  	if (data->dready_trig) {
> -		iio_triggered_buffer_cleanup(indio_dev);
>  		iio_trigger_unregister(data->dready_trig);
>  		iio_trigger_unregister(data->motion_trig);
>  	}
> 

