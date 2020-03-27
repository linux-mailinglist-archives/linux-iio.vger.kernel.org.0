Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4BA19573C
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 13:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0MkL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 08:40:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40293 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgC0MkK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 08:40:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id u10so11220071wro.7;
        Fri, 27 Mar 2020 05:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jZHFiWax8vCvFZJl+Fo54qpkUa4Crpp6F75KMLPAOl8=;
        b=gSh1gE1Yz3lU4ivwfNB+k/+ydo1wN4UNR3yIdL5Ae311j2ZRONhSmKEL4Ky00zVO6B
         p0vDv3LMBMBcX+xF5JsE9FFLEdyuayAuxuq0YpBOgAmb3raaqn7Z8whvwmG9vrtg69Sw
         JVrflaT1O86knx4zu6XIU0Eejx4mYm0i972UKLIL5VLuZXn8iDwOYswPEm8ujRc18Gem
         xh/lXLvIGELQEAt8HWpSbDCq3Hg0FdLZTIL8+ioEaz1HZFt2on+nOGfEP9waji/lI16u
         4MrrS89SWr5I8WQSRdQhEJlofDB46HDpTZksPP+H3HyWxr39RjXJM+14IMsqgzjwNtsl
         wbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jZHFiWax8vCvFZJl+Fo54qpkUa4Crpp6F75KMLPAOl8=;
        b=hL/ey5hkDXc9vilE5RKInTrY1OmAai/Dvpyt7deZpbb7UIZpvSzWk0k3pPQIja3qZq
         xJcVLCXd87sMXmkYHgKlOdPRdUlv8r30+nQ4q08vY8DfBjblR72i6A7JZOOGWnKaD2P2
         I40TVky28tfoL++YazOXfhDuYOqTcunWr8qXzk8ojV9fKfy5lrhWX0IZnhM0dzbIgT32
         tu9G3Mha8he8sgVc4qqTt6X/xcNc3g+b2OMedx1A+XuUH97dvivD3FQOVMNWWTtfoBZj
         EYE1/NJZjF6b7chGPXCMulk/96R8R20/OXhun8genCNX/FbLZ1YEjV1skISDoQiU0V6X
         gPnA==
X-Gm-Message-State: ANhLgQ1gExEibaFXYCZB1xTCkg9p5N+CVZ5EvqA3b4DCuu8nKAomUwTU
        liguFai9tfkTeDA/7jJkHIQ=
X-Google-Smtp-Source: ADFU+vvKWziGHlMdvcuetUGwCoGi7eYH0NZ0+lmcZX0O4k6SAr9Vh6MW+2Mw+lx2eY1oQlgBl03rlQ==
X-Received: by 2002:adf:ab12:: with SMTP id q18mr15276713wrc.148.1585312808970;
        Fri, 27 Mar 2020 05:40:08 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F6E13.dip0.t-ipconnect.de. [91.63.110.19])
        by smtp.gmail.com with ESMTPSA id u131sm8292883wmg.41.2020.03.27.05.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 05:40:08 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] mfd: mp2629: Add support for mps battery charger
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        andriy.shevchenko@linux.intel.com
References: <20200322224626.13160-1-sravanhome@gmail.com>
 <20200322224626.13160-3-sravanhome@gmail.com> <20200327075541.GF603801@dell>
 <a6098b6a-2b2f-5279-f9fc-85201b9aabde@gmail.com> <20200327102221.GA3383@dell>
 <a679aba5-4cfb-1b6c-8cb0-dab3a644f3e7@gmail.com> <20200327112523.GC3383@dell>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <45f68c40-8e50-e0a2-a89a-b5a164d6b75c@gmail.com>
Date:   Fri, 27 Mar 2020 13:40:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200327112523.GC3383@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee, Andy

On 27/03/20 12:25 pm, Lee Jones wrote:
> On Fri, 27 Mar 2020, saravanan sekar wrote:
>> On 27/03/20 11:22 am, Lee Jones wrote:
>>> Saravanan, Jonathan,
>>>
>>> On Fri, 27 Mar 2020, saravanan sekar wrote:
>>>> On 27/03/20 8:55 am, Lee Jones wrote:
>>>>> On Sun, 22 Mar 2020, Saravanan Sekar wrote:
>>>>>
>>>>>> mp2629 is a highly-integrated switching-mode battery charge management
>>>>>> device for single-cell Li-ion or Li-polymer battery.
>>>>>>
>>>>>> Add MFD core enables chip access for ADC driver for battery readings,
>>>>>> and a power supply battery-charger driver
>>>>>>
>>>>>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>>>>>> ---
>>>>>>     drivers/mfd/Kconfig        |   9 +++
>>>>>>     drivers/mfd/Makefile       |   2 +
>>>>>>     drivers/mfd/mp2629.c       | 116 +++++++++++++++++++++++++++++++++++++
>>>>>>     include/linux/mfd/mp2629.h |  22 +++++++
>>>>>>     4 files changed, 149 insertions(+)
>>>>>>     create mode 100644 drivers/mfd/mp2629.c
>>>>>>     create mode 100644 include/linux/mfd/mp2629.h
> [...]
>
>>>>>> +#ifndef __MP2629_H__
>>>>>> +#define __MP2629_H__
>>>>>> +
>>>>>> +#include <linux/types.h>
>>>>>> +
>>>>>> +struct device;
>>>>>> +struct regmap;
>>>>> Why not just add the includes?
>>>> Some more shared enum added in ADC driver
>>> Sorry?
>> I misunderstood your previous question that you are asking to remove this
>> mp2629.h file
>>
>> "No user here. (Hint: Use forward declaration of struct device instead)" -
>> review comments on V1 from Andy Shevchenko.
>> So remove the includes
> So Andy has reviewed, but you still don't have him on Cc?
Sorry one of his hint made me removed him in CC unknowingly.

"For the future, hint:
         scripts/get_maintainer.pl --git --git-min-percent=67 ..."

My fault, added him in CC

> How are we meant to continue the discussion?
>
> As a general rule I'm not a fan of forward declarations.
>
> I think they should be avoided if at all possible.
Ok will add includes
>>>>>> +struct mp2629_info {
>>>>>> +	struct device *dev;
>>>>>> +	struct regmap *regmap;
>>>>>> +};
>>>>>> +
>>>>>> +#endif
