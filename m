Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A3C3821FA
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 01:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhEPXMP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 19:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhEPXMP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 19:12:15 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D826CC061573;
        Sun, 16 May 2021 16:10:59 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id j11so3653855qtn.12;
        Sun, 16 May 2021 16:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PoY+EuPlWoGo2pcajMw8QY1wd4IJBhLEmq5qQl8UIlk=;
        b=HNPSwjPV1ofyklqh8xCLJFvlt9IWr3JBO8NPXTO4JEY8BPbL3EyxDk3gMVcxlAGtVq
         D8NnnuyFduSPHiGegwkVOEKI9VGYlaCw7rNeN2Izyx/csYUyzRAGhNPwenbj0GGiNa+V
         7IyJPjfTVHWm3rXJC7knBkZFcsOp9IpN3+ZnZkW3cV/i3V7N1m0itvxFqUrLh1TxYuce
         hwsB7sKuI3ZFiVE8FGV3hJ2V5ySjamIWEOGG7ZaxyVOE4CudJWZ3xOQ26FUvRgmF+trU
         lOZRMPypL/IXOEyIFFF58RgaBiSLlEGn9/7eEvIX7orRLoKrCIRipbbOndhZdcMNCoNn
         SEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PoY+EuPlWoGo2pcajMw8QY1wd4IJBhLEmq5qQl8UIlk=;
        b=BWanz5h+h/1FWD/irRvsFmzO372yVpJ15Ibjnb1pKBwCpd2XWkuGQENL+wdfw6CJvf
         uxjxtaQ4kdp+VhRe72DkTdz4CnpwFstId4NwRpwjS0nAHaE22uGeJv2wfOimnuItm6AG
         r6cWEiXzLaks26AJ4VqjEX1N5pa5YztDfQ7SohSajDbY1QxaEJevT/r/MwnGzV4NDRQl
         Dimj6KglodrwELXgYuCJIkn0FX/FArmmb/D3FTL6Gs2EfULz+2SFfeg/xhlmtWRVJ4qw
         5LBgK7CsnM0mYWJxS8XGuakmL6tBntAMIeGzuzNg8YE3SmplXONqN0xEA1EHBx8snPbd
         lq5A==
X-Gm-Message-State: AOAM533mltN/f80vSBDQlbDAqtlXB6CnhvpuVNS0Lu1Mqo7VxH0WJJk6
        EUJscj+ExDpYN72CN/ccVp0=
X-Google-Smtp-Source: ABdhPJytrgXGlxQ817LtCB14QZcajUBcsKrWFjZeIqu9SNrIcSQsEIJo8QwRX6I8yeno1D70KmEemg==
X-Received: by 2002:ac8:4698:: with SMTP id g24mr5664517qto.112.1621206659083;
        Sun, 16 May 2021 16:10:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 7sm10375052qtu.38.2021.05.16.16.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 16:10:58 -0700 (PDT)
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
 <e56146c5-2bff-3a6d-b54e-fd40993f82aa@roeck-us.net>
 <20210516172618.2d7ad168@jic23-huawei> <CBEVHCPHGJJD.2IDUUG1RPDF64@shaak>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d99331c5-b3d6-5e87-3a3d-8cf2817dea11@roeck-us.net>
Date:   Sun, 16 May 2021 16:10:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CBEVHCPHGJJD.2IDUUG1RPDF64@shaak>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/16/21 11:14 AM, Liam Beguin wrote:
> On Sun May 16, 2021 at 12:26 PM EDT, Jonathan Cameron wrote:
>> On Sun, 16 May 2021 08:54:06 -0700
>> Guenter Roeck <linux@roeck-us.net> wrote:
>>
>>> On 5/16/21 8:02 AM, Liam Beguin wrote:
>>>> Hi Jonathan,
>>>>
>>>> On Sun May 16, 2021 at 5:06 AM EDT, Jonathan Cameron wrote:
>>>>> On Sun, 16 May 2021 00:43:13 -0400
>>>>> Liam Beguin <liambeguin@gmail.com> wrote:
>>>>>   
>>>>>> Add a devicetree binding to optionally force a different IIO channel
>>>>>> type.
>>>>>>
>>>>>> This is useful in cases where ADC channels are connected to a circuit
>>>>>> that represent another unit such as a temperature or a current.
>>>>>>
>>>>>> `channel-types` was chosen instead of `io-channel-types` as this is not
>>>>>> part of the iio consumer bindings.
>>>>>>
>>>>>> In the current form, this patch does what it's intended to do:
>>>>>> change the unit displayed by `sensors`, but feels like the wrong way to
>>>>>> address the problem.
>>>>>>
>>>>>> Would it be possible to force the type of different IIO channels for
>>>>>> this kind of use case with a devicetree binding from the IIO subsystem?
>>>>>>
>>>>>> It would be convenient to do it within the IIO subsystem to have the
>>>>>> right unit there too.
>>>>>>
>>>>>> Thanks for your time,
>>>>>> Liam
>>>>>
>>>>> Hi Liam,
>>>>>
>>>>> +CC Peter for AFE part.
>>>>>
>>>>> It's an interesting approach, but I would suggest we think about this
>>>>> a different way.
>>>>>
>>>>> Whenever a channel is being used to measure something 'different' from
>>>>> what it actually measures (e.g. a voltage ADC measuring a current) that
>>>>> reflects their being some analog component involved.
>>>>> If you look at drivers/iio/afe/iio-rescale.c you can see the approach
>>>>> we currently use to handle this.
>>>>
>>>> Many thanks for pointing out the AFE code. That look like what I was
>>>> hoping to accomplish, but in a much better way.
>>>>    
>>>>>
>>>>> Effectively what you add to devicetree is a consumer of the ADC channel
>>>>> which in turn provides services to other devices. For this current case
>>>>> it would be either a current-sense-amplifier or a current-sense-shunt
>>>>> depending on what the analog front end looks like. We have to describe
>>>>> the characteristics of that front end which isn't something that can
>>>>> be done via a simple channel type.
>>>>>   
>>>>
>>>> Understood. My original intention was to use sensors.conf to do the
>>>> conversions and take into accounts those parameters.
>>>>    
>>>>> That afe consumer device can then provide services to another consumer
>>>>> (e.g. iio-hwmon) which work for your usecase.
>>>>>
>>>>> The main limitation of this approach currently is you end up with
>>>>> one device per channel. That could be improved upon if you have a
>>>>> usecase
>>>>> where it matters.
>>>>>
>>>>> I don't think we currently have an equivalent for temperature sensing
>>>>> but it would be easy enough to do something similar.
>>>>
>>>> Wonderful, thanks again for pointing out the AFE!
>>>>    
>>>
>>> Please don't reinvent the ntc_thermistor driver.
> 
>> Agreed, I'd forgotten it existed :( Had a feeling we'd solved that
>> problem before
>> but couldn't remember the name of the driver.
>>
>> The afe driver already deals with current / voltage scaling and
>> conversion
>> for common analog circuits. Potential dividers, current shunts etc, but
>> they
>> are all the linear cases IIRC.
>>
>> ntc_thermistor deals with the much more complex job of dealing with a
>> thermistor.
> 
> I agree, no need to reinvent this.
> 
> Like Jonathan said, the ntc_thermistor driver seems to handle much more
> complex cases. Where would be the best place to add support for PT100
> and PT1000? iio-rescale?
> 

Those sensors don't seem to be even useful for hardware monitoring, so
if they are linear (and it looks like that that the case) iio would be
a better place.

Guenter
