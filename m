Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E691B7297
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 13:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgDXLET (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 07:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXLET (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 07:04:19 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83B7C09B045;
        Fri, 24 Apr 2020 04:04:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r26so10244199wmh.0;
        Fri, 24 Apr 2020 04:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pSOVyhJdj4/fesT2qqzK0Np8GTqrHNI33Mksdh6I9is=;
        b=CBZkq8evVAGoOEqAFjE0Yw1Qod8hlCixV9ZxFdQIDDOxeg0NMXhUFys2PJwNiESJks
         gtujferhpVA3N8quSElD1e+Qu0W/DR3O+Zqqn37pz1SQdqiuYrl7xmS6FY2vEMSiOApH
         sNiAUthJyIQLwnNR5dY5c07k6cczUXi3aWbdQRK6RyBUIzWQ4nhPDiN9UD2tYmEWCUUd
         j55cx/CU4lMVq8d09/i7kb3/LIHJ0x2EKGuOU0nE4JozKQyz91LTall5kouq5VPU1rTb
         vKtJB1M9u/XpykgGegyIsXtpdGl9TvBnZX3utA9zgmFYFY/SvmEzyICX4g0+ThvZ9nd2
         NuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pSOVyhJdj4/fesT2qqzK0Np8GTqrHNI33Mksdh6I9is=;
        b=Ho3zFduNmK+dVCGOw1+Ta4fY275xDr6x7BsJgjtFLlxwYzetXe7EAA6OgxmWvE6gQC
         diTaZ8/QObpaqGTYoM6OjNxrYa64uu3xlRB5J0ZEUZo8dkITcbY705n69UfAwpoHRvzm
         MXIs9R1qII1I9eA+BwHSw3t7Gtxm6uTCHZEQVezPGly6rag4YQkgYq34Bw9kYgMYcRtw
         UodU1mFxFNlgQ4k1yfRzIZaj1IO5dnXwU+KVF4YAm2Pz1Fp1MO+HY1K08/jfcCichPMm
         om/shPxtWP1Q9g6j6IlGsCnmQoh/1eEXd7AIWNzeseOuayd6bC/Yv2uMvVLq78o2nJx7
         rx8Q==
X-Gm-Message-State: AGi0Pubk6cB21uXDKtJh4UeIpzGCcCSOajgLt2rigsuoPgaVIZiXnZjU
        12hqY5mA/pdZUOAdoAGlJquppWdB
X-Google-Smtp-Source: APiQypKYFh/VVcHW+Hup5NEuDU+N96SQyCNkFXOgRyZDJr5xEkCbpbjZRQ/sMPWE8quO9pC2/0Ittw==
X-Received: by 2002:a1c:e302:: with SMTP id a2mr9205500wmh.96.1587726257036;
        Fri, 24 Apr 2020 04:04:17 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F694A.dip0.t-ipconnect.de. [91.63.105.74])
        by smtp.gmail.com with ESMTPSA id h10sm7676274wrq.33.2020.04.24.04.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 04:04:16 -0700 (PDT)
Subject: Re: [PATCH v9 2/6] mfd: mp2629: Add support for mps battery charger
To:     Lee Jones <lee.jones@linaro.org>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200415162030.16414-1-sravanhome@gmail.com>
 <20200415162030.16414-3-sravanhome@gmail.com> <20200424071822.GM3612@dell>
 <8ff17d07-8030-fcfe-8d8a-3011e4077778@gmail.com> <20200424093720.GA3542@dell>
 <864eb6ad-a605-c0a0-c3e7-23c0c70f5ede@gmail.com> <20200424105319.GD8414@dell>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <c62cd5f2-6d82-0a2a-5ee5-a3e99e188a05@gmail.com>
Date:   Fri, 24 Apr 2020 13:04:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424105319.GD8414@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 24/04/20 12:53 pm, Lee Jones wrote:
> On Fri, 24 Apr 2020, saravanan sekar wrote:
>
>> Hi Lee,
>>
>> On 24/04/20 11:37 am, Lee Jones wrote:
>>> On Fri, 24 Apr 2020, saravanan sekar wrote:
>>>
>>>> Hi Lee,
>>>>
>>>> On 24/04/20 9:18 am, Lee Jones wrote:
>>>>> On Wed, 15 Apr 2020, Saravanan Sekar wrote:
>>>>>
>>>>>> mp2629 is a highly-integrated switching-mode battery charge management
>>>>>> device for single-cell Li-ion or Li-polymer battery.
>>>>>>
>>>>>> Add MFD core enables chip access for ADC driver for battery readings,
>>>>>> and a power supply battery-charger driver
>>>>>>
>>>>>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>>>>>> ---
>>>>>>     drivers/mfd/Kconfig        |  9 ++++
>>>>>>     drivers/mfd/Makefile       |  2 +
>>>>>>     drivers/mfd/mp2629.c       | 86 ++++++++++++++++++++++++++++++++++++++
>>>>>>     include/linux/mfd/mp2629.h | 19 +++++++++
>>>>>>     4 files changed, 116 insertions(+)
>>>>>>     create mode 100644 drivers/mfd/mp2629.c
>>>>>>     create mode 100644 include/linux/mfd/mp2629.h
>>>>> How is this driver registered?
>>>>>
>>>>> Looks like it has device tree support.  Is there another way?
>>>> Yes, only using device tree
>>> Then how about using 'simple-mfd' and 'syscon'?
>>>
>>> Then you can omit this driver completely.
>> The exception is to support for non device tree platform as well, but I have
>> tested only for ARM device tree platform.
> Is that a reality though?
>
> How else do you see this realistically being registered?
>
I understand that acpi related device table are not covered here, well I 
don't have to platform to test so.
If you ask me to cover acpi related table, I can do but hard to test.
>>>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>>>> index 3c547ed575e6..85be799795aa 100644
>>>>>> --- a/drivers/mfd/Kconfig
>>>>>> +++ b/drivers/mfd/Kconfig
>>>>>> @@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
>>>>>>     	help
>>>>>>     	  Select this if your MC13xxx is connected via an I2C bus.
>>>>>> +config MFD_MP2629
>>>>>> +	tristate "Monolithic power system MP2629 ADC and Battery charger"
>>>>>> +	depends on I2C
>>>>>> +	select REGMAP_I2C
>>>>>> +	help
>>>>>> +	  Select this option to enable support for monolithic power system
>>>>>> +	  battery charger. This provides ADC, thermal, battery charger power
>>>>>> +	  management functions on the systems.
