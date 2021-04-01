Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E954351AB3
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbhDASCo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 14:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbhDAR5R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 13:57:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE56C0D9424;
        Thu,  1 Apr 2021 07:53:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id v10so1654569pfn.5;
        Thu, 01 Apr 2021 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S8v12+xvw38bIlezrR3XZMbu9iWBOqwBPhWL+2JH5Uc=;
        b=Dyqaw1+fyqUfg5bx0s7dFljkCV8PaVIz36dJtCnis6d0JE98H+gWGEiJkpxzAu72t5
         7wx0QmLOv6AMm0/1H50UY2mhotoAXpVBh6TjlUbhRDghDYIvd4Na88BsYOU/MfjiG/Ek
         5L9NUBnbr0HDgBFpjCwPCjneRQQqWMFxfdBdAOUbbkWGh50YlaxYeyrpcBppDZxPfLju
         7W5/5wDngGZi9dfnVSeMQtKWEkaIJVTGbtbo9z+RiPBI2tP2AG9Lmg2iFXLV7/mlHJpP
         BdQnus19uPbIqKC78aExwLAg091o5q+nisiOXbINw42FSWQE+dz2viABp1CuUiFcQbbV
         QNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S8v12+xvw38bIlezrR3XZMbu9iWBOqwBPhWL+2JH5Uc=;
        b=Z2EEFRlRaxyJjpEDPgbwcpPGf79rKZ+dkUxR09P7igo4/zPaRSZ8ZE7DkTnnW+xoyn
         nT9TSiVra1gutF6KT2paqnplhpdCB3t4nqSQfU1nUvyPKcIj6D0/Bb2BePIgyYWG+25R
         3oTtIBniU7qSdN6/iFyukMHbqk5FD5nme49uf2QoTbz0l2KTjmkkSC44sDh46wd42n4v
         a0qLR+eh6HL9XiJKfxrXQlt8oDSgUeJe1gq3Gxm46NADfPqC32pirK8Jhkn1w/7auoVz
         7gbPEfRJTH4wBgTKkor29QVPOu/STCaipTrgq3C47R/4vHN7mrtwp4YLNVsUHf+L/WSd
         CCrg==
X-Gm-Message-State: AOAM533CrZt/KvlcNgh369tUdh25Wk8PAve6Q0GGDBLZS45PHSr0gy+b
        BbMOnf1PyABJO9M23bDF7M67wJHxUjEWh1xF
X-Google-Smtp-Source: ABdhPJzu44h9Fj7Ot3tFgyse9/w8XDAsDQQFWBiJsD/anxTnTfRamR8LuuoBNBHgcCRNKdUOVvGHZw==
X-Received: by 2002:a63:1a47:: with SMTP id a7mr7729388pgm.437.1617288782443;
        Thu, 01 Apr 2021 07:53:02 -0700 (PDT)
Received: from ?IPv6:2409:4072:6307:8389:a773:d07f:cd55:994a? ([2409:4072:6307:8389:a773:d07f:cd55:994a])
        by smtp.gmail.com with ESMTPSA id s19sm5825401pfh.168.2021.04.01.07.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 07:53:01 -0700 (PDT)
Subject: Re: [PATCH] iio: adc: bcm_iproc_adc: Use %s and __func__
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210401062517.28832-1-dmugil2000@gmail.com>
 <CAHp75VfgL0KW0fetgE3NuBb4itMK1oY+yLmr1xDYkn390hCscg@mail.gmail.com>
 <20210401113015.00006b70@Huawei.com>
From:   Mugilraj D <dmugil2000@gmail.com>
Message-ID: <a2ac91a9-54e3-2525-1e7e-00a26d3393e3@gmail.com>
Date:   Thu, 1 Apr 2021 20:22:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210401113015.00006b70@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 01/04/21 4:00 pm, Jonathan Cameron wrote:
> On Thu, 1 Apr 2021 12:24:50 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
>> On Thu, Apr 1, 2021 at 9:27 AM Mugilraj Dhavachelvan
>> <dmugil2000@gmail.com> wrote:
>>>
>>> Change function's name to %s and __func__ to fix checkpatch.pl errors.  
>>
>> No, just drop the __func__ completely. First of all, we have a device
>> name, and uniqueness of the messages in the driver should guarantee
>> easy findings. Second, specific to _dbg() variants, with enabled
>> Dynamic Debug it can be chosen at run time!
>>
>> I recommend going through all drivers and drop __func__ near to
>> dev_dbg() and pr_debug().
>>
> 
> Agreed.  Though beware that some maintainers will count this
> as noise and get grumpy.
> 
> I'm fine with such patches for IIO.

Sorry for the noise. I just seen the docs about dynamic debug.
So, if we use dev_dbg("log_msg") it will print statement like
filename:lineno [module]func flag log_msg, If I get it correctly.
And no need of specifying __func__ in dev_dbg() and dp_dbg() right!!

Jonathan do you have any TODO's?

> 
> Jonathan
> 
