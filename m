Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD8F381F8F
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 17:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhEPPz0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 11:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhEPPzZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 11:55:25 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6534C061573;
        Sun, 16 May 2021 08:54:10 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q10so3580413qkc.5;
        Sun, 16 May 2021 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=do6Cm8APv+yngie1sQsBq5KRiTBBBpKszxFMMG5fbqM=;
        b=pIDLCo5fC+Wedm1JnRGX3j85Gyi0F3ijqax/+aKan2ywxfJiykkE9OOxQUQlzaDLRH
         3xyNxyUodt+NHfKPs8B/Qa19s8hMzGXe2tM/KxYjOsg2wXb1nanrGOL32jd7wM/ZegP+
         zHDqxF4rWwqs7IetQbOHofrdxHf4B/RQAJBM4mG+OBsJDyZ9FapLk7GR1oLaZvOyVmUy
         PNtp9tzKpJJbdtEZX/7kQjNADMGuPgoxV3pYC606mn2qpXXpaaH2pTuiXROqphV/IgGP
         Tis3XeAy7KhecKWoNokSh/sZVpPdzjwthNLyppPSVL64bfiv/Z7pQVT8UUtOeEyonGr1
         Tviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=do6Cm8APv+yngie1sQsBq5KRiTBBBpKszxFMMG5fbqM=;
        b=GHVkKvbD1zKtn/0kMJD3Uxa92D39WeEXpcU05Vp9gfPjtjrU+zSjZObQsVcfTtnEPr
         PdlNJRqcgakulwwRPE9Rs5a+T0h2EwSY4W7YjaKQ78zLP/ylJKWdC4y8Db3kWE1M38zb
         5KCLOh/6hmue+k923IS27tpS2HV1Vs3UcghwPEmEp4eF+M8r48pAkSOhfijpi0QtZOoT
         W+rXk6DiraYHSalFVXJiwxX1oDQ4E5F5GoEC5fOA4KLb8HWIuu/JjkOfGGatOd6iFKNd
         lqXofsoQ3745hpMdeFQZzMbTKgteuOBPFuXbnln1zaQVQDFOwq602SocJ9Dln9tDo0Fx
         aW4Q==
X-Gm-Message-State: AOAM530ARy9/UsQo/uT/YSctaH42IJ32H+j+DP/YDG6TwdNt8wEc8kTM
        poQ63PY1TYecXiGm1yKGEQA=
X-Google-Smtp-Source: ABdhPJwGhDWd91jSoLaFcfzUjnxas0mEifDjuJQ5r227UxqeW4f96ffPscGb1vXmsfemILiVvFgf0g==
X-Received: by 2002:a05:620a:13fc:: with SMTP id h28mr30903115qkl.455.1621180449841;
        Sun, 16 May 2021 08:54:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 20sm9040874qks.64.2021.05.16.08.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 08:54:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [RFC PATCH v1 0/2] hwmon: (iio_hwmon) optionally force iio
 channel type
To:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     jdelvare@suse.com, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Peter Rosin <peda@axentia.se>
References: <20210516044315.116290-1-liambeguin@gmail.com>
 <20210516100631.7310a7bb@jic23-huawei> <CBEREZMZ2Z8U.13BH8G7RKPPL7@shaak>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e56146c5-2bff-3a6d-b54e-fd40993f82aa@roeck-us.net>
Date:   Sun, 16 May 2021 08:54:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CBEREZMZ2Z8U.13BH8G7RKPPL7@shaak>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/16/21 8:02 AM, Liam Beguin wrote:
> Hi Jonathan,
> 
> On Sun May 16, 2021 at 5:06 AM EDT, Jonathan Cameron wrote:
>> On Sun, 16 May 2021 00:43:13 -0400
>> Liam Beguin <liambeguin@gmail.com> wrote:
>>
>>> Add a devicetree binding to optionally force a different IIO channel
>>> type.
>>>
>>> This is useful in cases where ADC channels are connected to a circuit
>>> that represent another unit such as a temperature or a current.
>>>
>>> `channel-types` was chosen instead of `io-channel-types` as this is not
>>> part of the iio consumer bindings.
>>>
>>> In the current form, this patch does what it's intended to do:
>>> change the unit displayed by `sensors`, but feels like the wrong way to
>>> address the problem.
>>>
>>> Would it be possible to force the type of different IIO channels for
>>> this kind of use case with a devicetree binding from the IIO subsystem?
>>>
>>> It would be convenient to do it within the IIO subsystem to have the
>>> right unit there too.
>>>
>>> Thanks for your time,
>>> Liam
>>
>> Hi Liam,
>>
>> +CC Peter for AFE part.
>>
>> It's an interesting approach, but I would suggest we think about this
>> a different way.
>>
>> Whenever a channel is being used to measure something 'different' from
>> what it actually measures (e.g. a voltage ADC measuring a current) that
>> reflects their being some analog component involved.
>> If you look at drivers/iio/afe/iio-rescale.c you can see the approach
>> we currently use to handle this.
> 
> Many thanks for pointing out the AFE code. That look like what I was
> hoping to accomplish, but in a much better way.
> 
>>
>> Effectively what you add to devicetree is a consumer of the ADC channel
>> which in turn provides services to other devices. For this current case
>> it would be either a current-sense-amplifier or a current-sense-shunt
>> depending on what the analog front end looks like. We have to describe
>> the characteristics of that front end which isn't something that can
>> be done via a simple channel type.
>>
> 
> Understood. My original intention was to use sensors.conf to do the
> conversions and take into accounts those parameters.
> 
>> That afe consumer device can then provide services to another consumer
>> (e.g. iio-hwmon) which work for your usecase.
>>
>> The main limitation of this approach currently is you end up with
>> one device per channel. That could be improved upon if you have a
>> usecase
>> where it matters.
>>
>> I don't think we currently have an equivalent for temperature sensing
>> but it would be easy enough to do something similar.
> 
> Wonderful, thanks again for pointing out the AFE!
> 

Please don't reinvent the ntc_thermistor driver.

Thanks,
Guenter

> Liam
> 
>>
>> Jonathan
>>
>>
>>>
>>> Liam Beguin (2):
>>>    hwmon: (iio_hwmon) optionally force iio channel type
>>>    dt-bindings: hwmon: add iio-hwmon bindings
>>>
>>>   .../devicetree/bindings/hwmon/iio-hwmon.yaml  | 41 +++++++++++++++++++
>>>   drivers/hwmon/iio_hwmon.c                     |  2 +
>>>   2 files changed, 43 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
>>>
>>>
>>> base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
> 

