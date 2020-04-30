Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CAC1BF5B4
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 12:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgD3Kjy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 06:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726413AbgD3Kjy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 06:39:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E294C035494;
        Thu, 30 Apr 2020 03:39:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d15so6276229wrx.3;
        Thu, 30 Apr 2020 03:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=m+chlPrQMdP5dXdx8tvxwWBw9YtWA0u5+Y75TJ+sgjc=;
        b=DEO30DXRjI9qe7OqYYAiRNHtlG5zLfzm7Y1JyOvMdwEQzGht2paggKoPuCmJjyKgJV
         e+jPeRtbuZrY/XJfqb9y+2zpvX9TmgLrUuES2zrcM4I8i7MAPEtf+W/l4cs8VE4xhA9o
         QlpROHnGv2QimMSkqYpQdOoJUl8qzE8DTcMydvi0QGn9GTU4p6rIjohZirkl9uQ+3whf
         r1xn3SAf6NqdhKQdX2a3ZdlpxhTtWwG3N2wbSA6ZykbizdiWlYOlSOKmt7c32HNYnytZ
         SFxWzd3ZKVr4fvn9obczDkGcSHmAikNFlhbsbHdfpfjzdj6CquRr6cXfoBOQvfmQYoS6
         AAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=m+chlPrQMdP5dXdx8tvxwWBw9YtWA0u5+Y75TJ+sgjc=;
        b=eXuZv8jOUnzaS4iVY+mkezcmXLVvSHjbbmJpsS4rWsaBDGK+fCDcHjK2XnNzh5Eq6d
         LeVMdZJsX/yja9fu6jBrpCtJYoSO4gBxIWkFltwl+N/YhPTbn16A/IbfyyyIcHhKr59Y
         2fuOaKOsPyHaWZOsbfs/HA9rwBFyj5a/xokwkIBqcy5lI+Za++UZL2t2bt3ETrzozEQg
         LZH8ThvxTfIbuXbLMRsCMm37MwNT9p0cEYbNPbdLddL9cfp0+T3j90iv7ZJpTstXOoHk
         1Bg+TDwuCsiaEzXPAIurePiyj9J4MVLc0UiPVq7v6eFnWFIs+NUHWKWzk7hnOG/2dygs
         ZCGQ==
X-Gm-Message-State: AGi0PuYcEdXz5G/KqX9IWgrvb7wjPhaOhWqh3ZxpxuMEQ0qBc+I7TVHF
        YBpmg59EEhZFpq/DzILiRGJE9tZ8
X-Google-Smtp-Source: APiQypLiSTqx0KQcnVM1ygQKcXZCjKbEZfa1vp0p40OC82kF6U5oyh0OQ+sb7bPOvGgT+TOg2khd1g==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr3253924wrx.345.1588243192502;
        Thu, 30 Apr 2020 03:39:52 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F6E9D.dip0.t-ipconnect.de. [91.63.110.157])
        by smtp.gmail.com with ESMTPSA id c20sm12353770wmd.36.2020.04.30.03.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 03:39:50 -0700 (PDT)
Subject: Re: [PATCH v9 2/6] mfd: mp2629: Add support for mps battery charger
From:   saravanan sekar <sravanhome@gmail.com>
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
 <6063ad6e-444c-b905-b858-d8f94d700748@gmail.com>
Message-ID: <4585179d-826b-6240-38a2-18fe757bc810@gmail.com>
Date:   Thu, 30 Apr 2020 12:39:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6063ad6e-444c-b905-b858-d8f94d700748@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

On 27/04/20 11:30 am, saravanan sekar wrote:
> Hi Lee,
>
> On 27/04/20 10:51 am, Lee Jones wrote:
>> On Fri, 24 Apr 2020, saravanan sekar wrote:
>>
>>> On 24/04/20 12:53 pm, Lee Jones wrote:
>>>> On Fri, 24 Apr 2020, saravanan sekar wrote:
>>>>
>>>>> Hi Lee,
>>>>>
>>>>> On 24/04/20 11:37 am, Lee Jones wrote:
>>>>>> On Fri, 24 Apr 2020, saravanan sekar wrote:
>>>>>>
>>>>>>> Hi Lee,
>>>>>>>
>>>>>>> On 24/04/20 9:18 am, Lee Jones wrote:
>>>>>>>> On Wed, 15 Apr 2020, Saravanan Sekar wrote:
>>>>>>>>
>>>>>>>>> mp2629 is a highly-integrated switching-mode battery charge 
>>>>>>>>> management
>>>>>>>>> device for single-cell Li-ion or Li-polymer battery.
>>>>>>>>>
>>>>>>>>> Add MFD core enables chip access for ADC driver for battery 
>>>>>>>>> readings,
>>>>>>>>> and a power supply battery-charger driver
>>>>>>>>>
>>>>>>>>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>>>>>>>>> ---
>>>>>>>>>      drivers/mfd/Kconfig        |  9 ++++
>>>>>>>>>      drivers/mfd/Makefile       |  2 +
>>>>>>>>>      drivers/mfd/mp2629.c       | 86 
>>>>>>>>> ++++++++++++++++++++++++++++++++++++++
>>>>>>>>>      include/linux/mfd/mp2629.h | 19 +++++++++
>>>>>>>>>      4 files changed, 116 insertions(+)
>>>>>>>>>      create mode 100644 drivers/mfd/mp2629.c
>>>>>>>>>      create mode 100644 include/linux/mfd/mp2629.h
>>>>>>>> How is this driver registered?
>>>>>>>>
>>>>>>>> Looks like it has device tree support.  Is there another way?
>>>>>>> Yes, only using device tree
>>>>>> Then how about using 'simple-mfd' and 'syscon'?
>>>>>>
>>>>>> Then you can omit this driver completely.
>>>>> The exception is to support for non device tree platform as well, 
>>>>> but I have
>>>>> tested only for ARM device tree platform.
>>>> Is that a reality though?
>>>>
>>>> How else do you see this realistically being registered?
>>>>
>>> I understand that acpi related device table are not covered here, 
>>> well I
>>> don't have to platform to test so.
>>> If you ask me to cover acpi related table, I can do but hard to test.
>> I don't know of any reasons why syscon can't be used by ACPI.
>>
>> Please try to solve this issue using 'simple-mfd' and 'syscon'.
> Well the simple-mfd and syscon topic recommended by you when Device 
> tree alone is used.
> I wounder still I receive review/improvements comments for this mfd 
> patch and also another
> to omit this driver using simple-mfd (rework the series).
> Confused, not sure which is valid and will be accepted at the end.

I had look into syscon, as far my understanding syscon is supported only 
for memory mapped IO. MP2629
device is over I2C bus, could you share your thought about syscon for 
this device?

Thanks,
Saravanan


