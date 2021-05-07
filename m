Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB4C37663C
	for <lists+linux-iio@lfdr.de>; Fri,  7 May 2021 15:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhEGNfn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 May 2021 09:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbhEGNfm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 May 2021 09:35:42 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3BDC061574;
        Fri,  7 May 2021 06:34:40 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id u48-20020a4a97330000b02901fa060b8066so1974098ooi.8;
        Fri, 07 May 2021 06:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rSwV1abiHwYQxyZpaOTUg0r4TBMXE5DrMeEgSz835H4=;
        b=hcGnvHHCVlpUenkLBj4fu/Npe9kGddavG2Zwxuv8oTzVTD/GM/ISnnanC6Z83i1F4X
         6EmaFmErpGB0lpXU6rSM+hRi1HHY0ZN0leKX9y657SpfSpnyhh7Sp1i72Nqf68Ej7HVS
         LlTwGOvByh/K2zQBlJAld11xMFm8TcBHQSbB81Rl/5U4+NAD0iKlMcdcIE/U3FNRLvFq
         mxUdNWfzeHXh+22/uKT6j3og9rmOWT4JGG1TaYOSbmoIUozRL9zdFeRrPb5g0O0I12VF
         YySImfDqI5j9QjyKZg6azcrkxJ7S+gHbI55ajEm6a3UIgaNj52nmvEHn5LPqVrRI/rKL
         k07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rSwV1abiHwYQxyZpaOTUg0r4TBMXE5DrMeEgSz835H4=;
        b=hNWi984exRWBJUIMxjiaKKwx4m3YYGsmZDt5aLHti6oeYZVPR+Tm5lguRffO1m5aXA
         be+3uZKWtbke7cLzei2mnSX4fk2uIt9yWTcH5nPWVN5eFcCKY0dvjnUd9Hxy+jUNdY3r
         igre2Z9SccUPye89wHLr2yJYq3hUa39464HhZ8/WH3TOt7nhcTuM5zeXOlfQGM7sGk+k
         p23AI7ba5sMj9/Sz5fCAJoz39ckQdV/OVFFm2mTrYZfiX5ofH18oE/V1KACDjNl8SZUu
         TJrBgHzgCSAScWN7KqH7dNIXR6dKblwEVgFlY5dZdzsDUPSgEVwjy90WdyvVMQqTX0sA
         cTrA==
X-Gm-Message-State: AOAM533QqiLRUXgnKCoFcx2lrCpIteJv9SC2WbnMAlmGfIVGAFipg0F+
        CedU9e2gETVadNGzUhWwyig=
X-Google-Smtp-Source: ABdhPJwiL+MLZwoT8SpWsM8oxXlpGI3tVew0cpbUgI+/btRlyyK1T9V0MQAhWTEWJLH2nylOo3tjcw==
X-Received: by 2002:a4a:e965:: with SMTP id i5mr7718698ooe.59.1620394476966;
        Fri, 07 May 2021 06:34:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 2sm695901ota.67.2021.05.07.06.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 06:34:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] iio: bme680_i2c: Remove ACPI support
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20210506034332.752263-1-linux@roeck-us.net>
 <20210507103154.00006763@Huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d966a55e-65e0-cbb0-6c4e-4339f577b18e@roeck-us.net>
Date:   Fri, 7 May 2021 06:34:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210507103154.00006763@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/7/21 2:31 AM, Jonathan Cameron wrote:
> On Wed,  5 May 2021 20:43:32 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> With CONFIG_ACPI=n and -Werror, 0-day reports:
>>
>> drivers/iio/chemical/bme680_i2c.c:46:36: error:
>> 	'bme680_acpi_match' defined but not used
>>
>> Apparently BME0680 is not a valid ACPI ID. Remove it and with it
>> ACPI support from the bme680_i2c driver.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> A note for these is that I'll change the patch titles when applying.
> We aren't removing ACPI support from the drivers, we are simply
> removing the ACPI ID table entries.  For most of these PRP0001 magic
> will work just fine with the OF table.  That's probably the
> right way for small companies etc to use these in products without
> having to jump through the hoops of getting an ACPI ID.
> 

Ok, no problem. I'll keep that in mind if I hit any others.

Thanks,
Guenter
