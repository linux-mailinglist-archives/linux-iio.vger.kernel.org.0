Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B911B9FEA
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 11:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgD0Jat (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726855AbgD0Jas (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 05:30:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A848DC0610D5;
        Mon, 27 Apr 2020 02:30:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x18so19659521wrq.2;
        Mon, 27 Apr 2020 02:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gGhrm05lBeDufcAvIkVNnCglslvfHPRc0gSDutuQja0=;
        b=GeeRUujz4O7iJXAC8HLyUVXX+fqUvCukRLH6iXhKfJ4GPhfu9aBtAYH1uRlM07CaFI
         K2z2zCmurdZT4Gt0kBRIqSg9dbINfKY4mXnmRSLLSqpF19GWbjtXXqtCtuWOSrhlbscD
         3LFxjeVRZ6z8x1AcL8UIiEeKy6BKD2S9olqstUN7pJN0BKSozWQO+eiD+lmoM4g/NUPb
         qRK7HeqGazO3IkwbCPa975iDleur20Sti0/48AFit1sDMD3trUZ3ht21mRGBiV8TXQv+
         ruo4tqJCKC2nrM+eAkXosU5a1RzbK4Clc3jVOdCEm6NdcGts8EJM/G2hUmmmK9BlvvMN
         pDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gGhrm05lBeDufcAvIkVNnCglslvfHPRc0gSDutuQja0=;
        b=VmLF7qORXYhnFrHIx2ijtL5ehw2XvbgG8eyG+B10HWttsDkvHfR5bIoFh+WN6SzeCS
         Pr//raT6VOpq0GErxiHLx1MJQzBULteb3+zjhN0s+Fs8NhqGy4mcJ/owO7YCKxBZgSE4
         h/9XqUL+AcBFCkhdB10p3O984Gipd/VCGjzrODrgMnx2F586WHqgk6W3D8r4cvjy5Q6d
         va0/dGatjBLn5uRTHqpoiHqo4TUmPadiYDuD9hDGSJr3fv6MCSFYpRJXOHOe3HdsCP9o
         2cM8mxp22bsVKzNqrP+mUrLIgAlGeyKC6SFl5PyXjJubYYxzD56Z4zp6jnIWAe5rM+Xi
         YrIw==
X-Gm-Message-State: AGi0Puag6X0sLyZWhK218dr/5X4NaUrQRZMRg8glAKj9wIyfXPAbiU0U
        DrKhALpOdlTAa/Qij3TfiEZ3qn7+
X-Google-Smtp-Source: APiQypJo+llHo9YUkCbnIuHUB0aRrp3ZNC/vsVhKFFyb2jPux13yVg6PBP+g/CAWQ7gKyt42+xooXA==
X-Received: by 2002:a5d:4292:: with SMTP id k18mr25168842wrq.137.1587979845950;
        Mon, 27 Apr 2020 02:30:45 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F6E10.dip0.t-ipconnect.de. [91.63.110.16])
        by smtp.gmail.com with ESMTPSA id h16sm22954922wrw.36.2020.04.27.02.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 02:30:44 -0700 (PDT)
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
 <c62cd5f2-6d82-0a2a-5ee5-a3e99e188a05@gmail.com> <20200427085149.GF3559@dell>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <6063ad6e-444c-b905-b858-d8f94d700748@gmail.com>
Date:   Mon, 27 Apr 2020 11:30:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427085149.GF3559@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

On 27/04/20 10:51 am, Lee Jones wrote:
> On Fri, 24 Apr 2020, saravanan sekar wrote:
>
>> On 24/04/20 12:53 pm, Lee Jones wrote:
>>> On Fri, 24 Apr 2020, saravanan sekar wrote:
>>>
>>>> Hi Lee,
>>>>
>>>> On 24/04/20 11:37 am, Lee Jones wrote:
>>>>> On Fri, 24 Apr 2020, saravanan sekar wrote:
>>>>>
>>>>>> Hi Lee,
>>>>>>
>>>>>> On 24/04/20 9:18 am, Lee Jones wrote:
>>>>>>> On Wed, 15 Apr 2020, Saravanan Sekar wrote:
>>>>>>>
>>>>>>>> mp2629 is a highly-integrated switching-mode battery charge management
>>>>>>>> device for single-cell Li-ion or Li-polymer battery.
>>>>>>>>
>>>>>>>> Add MFD core enables chip access for ADC driver for battery readings,
>>>>>>>> and a power supply battery-charger driver
>>>>>>>>
>>>>>>>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>>>>>>>> ---
>>>>>>>>      drivers/mfd/Kconfig        |  9 ++++
>>>>>>>>      drivers/mfd/Makefile       |  2 +
>>>>>>>>      drivers/mfd/mp2629.c       | 86 ++++++++++++++++++++++++++++++++++++++
>>>>>>>>      include/linux/mfd/mp2629.h | 19 +++++++++
>>>>>>>>      4 files changed, 116 insertions(+)
>>>>>>>>      create mode 100644 drivers/mfd/mp2629.c
>>>>>>>>      create mode 100644 include/linux/mfd/mp2629.h
>>>>>>> How is this driver registered?
>>>>>>>
>>>>>>> Looks like it has device tree support.  Is there another way?
>>>>>> Yes, only using device tree
>>>>> Then how about using 'simple-mfd' and 'syscon'?
>>>>>
>>>>> Then you can omit this driver completely.
>>>> The exception is to support for non device tree platform as well, but I have
>>>> tested only for ARM device tree platform.
>>> Is that a reality though?
>>>
>>> How else do you see this realistically being registered?
>>>
>> I understand that acpi related device table are not covered here, well I
>> don't have to platform to test so.
>> If you ask me to cover acpi related table, I can do but hard to test.
> I don't know of any reasons why syscon can't be used by ACPI.
>
> Please try to solve this issue using 'simple-mfd' and 'syscon'.
Well the simple-mfd and syscon topic recommended by you when Device tree 
alone is used.
I wounder still I receive review/improvements comments for this mfd 
patch and also another
to omit this driver using simple-mfd (rework the series).
Confused, not sure which is valid and will be accepted at the end.
>
>>>>>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>>>>>> index 3c547ed575e6..85be799795aa 100644
>>>>>>>> --- a/drivers/mfd/Kconfig
>>>>>>>> +++ b/drivers/mfd/Kconfig
>>>>>>>> @@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
>>>>>>>>      	help
>>>>>>>>      	  Select this if your MC13xxx is connected via an I2C bus.
>>>>>>>> +config MFD_MP2629
>>>>>>>> +	tristate "Monolithic power system MP2629 ADC and Battery charger"
>>>>>>>> +	depends on I2C
>>>>>>>> +	select REGMAP_I2C
>>>>>>>> +	help
>>>>>>>> +	  Select this option to enable support for monolithic power system
>>>>>>>> +	  battery charger. This provides ADC, thermal, battery charger power
>>>>>>>> +	  management functions on the systems.
