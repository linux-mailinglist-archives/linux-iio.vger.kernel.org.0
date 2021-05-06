Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1814D3750E3
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 10:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhEFIbO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 04:31:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232944AbhEFIbO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 04:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620289816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JRKbW/sCgPPWfrkPLI5ab6dF91rPfojdvFAM5kCKO64=;
        b=FV9+SC/TLaNZ9V0PhKPyHjBSoaKQE6jxN4ircRE5IJxMv5lfyk/gbMjYTRtcerl8U8lC6C
        upeRM3wcKTkGU286h6TkJ9sNHVMUwuK4ssoszAeHO7mjXu8u0hNlgdp9TS+P48jnyatUoq
        VE4nFrve0JdL0dq919NCllSp/yunpXk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-7RfYpjcWMbmbTuue4pvzYQ-1; Thu, 06 May 2021 04:30:14 -0400
X-MC-Unique: 7RfYpjcWMbmbTuue4pvzYQ-1
Received: by mail-ed1-f72.google.com with SMTP id y19-20020a0564022713b029038a9f36060dso2252503edd.4
        for <linux-iio@vger.kernel.org>; Thu, 06 May 2021 01:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JRKbW/sCgPPWfrkPLI5ab6dF91rPfojdvFAM5kCKO64=;
        b=FyHGDJkK9pitvymuynsVQsW0vuGH/f7WbZtLbO/Zbo1rehnPvlhctu4QmfNDVsoM17
         S+3x3kLpHuCRiZ1u2hUvLMVfJofwQWNs7XKCYKHJ5rip5pUtY4MUQZ225qkCZdHkF2SS
         kl7wW/Lv4/KLnSMe/reHscCLzFgcQSlU2sWJfrdU+oH1PrwHUgeeH5s7ZEJWNQlUFb6n
         S+TaM1x9tlkbYA1IRWb/bIcLnAbCJzW2YW6dbWko8gWpCsySdPU4SjJtH01k7Z/V5IND
         qbOTKH8Qh5Xdx3geGeJkss20wv0zj4NQdvic9IvhA9hKNgR9yHYq/25UxmhJ9Yn5SPBx
         F9XQ==
X-Gm-Message-State: AOAM5311xgK+jJfXKuG+dd1zrFUqFODyV3Z9WTPDX7kOh4axaLlgXgaF
        l2BUMLJRPZPP8QsWVyRwxL9Tx5gkO9cq75Vdg1OgZ9nv8qUqO4py6sHPlBtw1dru71S5ey/6QTb
        RxGa1Mmd3OzGYBAUiuYDa
X-Received: by 2002:a17:907:7216:: with SMTP id dr22mr3131475ejc.185.1620289813000;
        Thu, 06 May 2021 01:30:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaTJLRRAe4z6xxP1wNQ3FfUihWzvJu3i6TGt4G0aTcNF32m7/5tO+Y7AeF4ilAxH6schuy5g==
X-Received: by 2002:a17:907:7216:: with SMTP id dr22mr3131456ejc.185.1620289812828;
        Thu, 06 May 2021 01:30:12 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id um2sm939292ejb.4.2021.05.06.01.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 01:30:12 -0700 (PDT)
Subject: Re: [PATCH] iio:accel:stk8312: Remove ACPI support
To:     Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20210506035659.765109-1-linux@roeck-us.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8d6a5c4e-f81a-51c2-cd7f-4a9e9895c8c1@redhat.com>
Date:   Thu, 6 May 2021 10:30:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506035659.765109-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/6/21 5:56 AM, Guenter Roeck wrote:
> With CONFIG_ACPI=n, W=1 and -Werror, 0-day reports:
> 
> drivers/iio/accel/stk8312.c:644:36: error:
> 	'stk8312_acpi_id' defined but not used
> 
> Apparently STK8312 is not a valid ACPI ID. Remove it and with it
> ACPI support from the stk8312 driver.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> There is another patch pending which makes whitespace changes in struct
> acpi_device_id stk8312_acpi_id. This will result in a conflict if this
> patch is applied. In that patch, it is claimed that the driver would
> possibly only be used based on its ACPI ID (even though that ACPI device
> ID is not official).
> Link: https://patchwork.kernel.org/project/linux-iio/patch/20210401144226.225928-1-jic23@kernel.org/
> I can not determine if that claim has any truth in it. Still, it appears
> that the device ID is not an official device ID.  
> 
>  drivers/iio/accel/stk8312.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index 157d8faefb9e..2fc30cfe1457 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -7,7 +7,6 @@
>   * IIO driver for STK8312; 7-bit I2C address: 0x3D.
>   */
>  
> -#include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -640,18 +639,10 @@ static const struct i2c_device_id stk8312_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, stk8312_i2c_id);
>  
> -static const struct acpi_device_id stk8312_acpi_id[] = {
> -	{"STK8312", 0},
> -	{}
> -};
> -
> -MODULE_DEVICE_TABLE(acpi, stk8312_acpi_id);
> -
>  static struct i2c_driver stk8312_driver = {
>  	.driver = {
>  		.name = STK8312_DRIVER_NAME,
>  		.pm = STK8312_PM_OPS,
> -		.acpi_match_table = ACPI_PTR(stk8312_acpi_id),
>  	},
>  	.probe =            stk8312_probe,
>  	.remove =           stk8312_remove,
> 

