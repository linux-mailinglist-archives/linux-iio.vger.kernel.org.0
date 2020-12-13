Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8842D8E84
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 17:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgLMQJT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 11:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgLMQJM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Dec 2020 11:09:12 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8D4C0613CF;
        Sun, 13 Dec 2020 08:08:29 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id f16so13273697otl.11;
        Sun, 13 Dec 2020 08:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7c+h8u5gCzGNXc7lVcHRE0ITDLCulcoBpnsp2M9ePTE=;
        b=fPD2ilQskxA2J4dodmLpSyZVdO1YAHN2Vc6NZ4SLhsYPPgX0g6q0RSIe3iDESB9euk
         JsPXIWSrpVAZuwmjF8hhpH5zguo6Lt+w1jtYRGGw2UsxoClhrzDYh6LnYonCgIxTT6i4
         /XOWP0uThAf7rwekuxjqGG4xtSDnjZu4AbhJbC2fmKH6URoqkULiVlqT0TDPzp9SwoVb
         xHySlyQY89V3IELn4phaQwIIvk2r1QYDIyte2kiV/H25pLDj8RSITHH697t11PySng8R
         DbP2vX9k1/4xNiOoJrJ2YouNDtHOmFnoTiHneBTImjStHh6ODbakTUsQzNL03JSCtKWV
         cg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7c+h8u5gCzGNXc7lVcHRE0ITDLCulcoBpnsp2M9ePTE=;
        b=Y/RDFx9/aHuTOAVoUk43bmJlYvc0T97XEEKxZkMCxqK/mBLPxcPma7GOXpUPKdzkr6
         74VM5GlHdlujitUAVdv34QJyYa+AZT1QKa7wT3fsONNMsWVz1QAWgL7aI29657wRT/la
         YjyOa5epY4G83upHw1A5YiREuxcK/NMJBu6Y5bOK63cDYbavg8FctAbhz7fPPsOx75DS
         VehzVXSZ5vJnYEZJVZp9LsHKleaXEjk7WuyR+ToqYGd2seoDs20CDMP2gRyYRZCfmIpW
         rlwV7vF9kn7pQUnRG7IkhfQa3J+ZTbnZxYgAym3VGYNZiUT01zUNq2AHlMv67StFUxk3
         mzNQ==
X-Gm-Message-State: AOAM532a8CaR8jaBb4e1qOtMf2fVFMP6klF2CXaSwUNY8g3g4Y/MTpF1
        98KYPFqLBSlbottQycbAuprkq/uffmY=
X-Google-Smtp-Source: ABdhPJzzqEMOa8d6Zca0iFitxWoog7fith/4Oa1kFHqYMB0GQqCy3ADot3jmliCwMrnCzH2MrnCI3g==
X-Received: by 2002:a9d:4b03:: with SMTP id q3mr16488470otf.88.1607875708644;
        Sun, 13 Dec 2020 08:08:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x66sm3483849oig.56.2020.12.13.08.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Dec 2020 08:08:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: IIO Driver for TMP117 Temperature sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
References: <CANk7y0gAChikUBf-ap328YNQd4nrw63BiFH9dRLLDuZ0SnneMA@mail.gmail.com>
 <CA+U=Dsr=SCdSsbsbdY++NwD4xQjr6PZuoOqa_Ctq6ig+GuvO=w@mail.gmail.com>
 <dd7f7015-aed4-8628-0f23-e144fdacc9e7@roeck-us.net>
 <20201213151253.059e541c@archlinux>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <729575c9-317c-a2ae-9ded-8732f3cc481d@roeck-us.net>
Date:   Sun, 13 Dec 2020 08:08:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201213151253.059e541c@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/13/20 7:12 AM, Jonathan Cameron wrote:
> On Wed, 9 Dec 2020 11:48:40 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 12/9/20 12:11 AM, Alexandru Ardelean wrote:
>>> On Tue, Dec 8, 2020 at 6:10 PM Puranjay Mohan <puranjay12@gmail.com> wrote:  
>>>>
>>>> I have this TI's TMP117 sensor with me and I was thinking about writing an
>>>> IIO driver for it as a hobby project. Is the IIO subsystem the correct
>>>> place for this driver? if yes, can someone help me get started with this,
>>>> I haven't written an IIO driver before. I have this sensor and also a
>>>> raspberry pi with me for testing.  
>>>
>>> This could also fit into drivers/hwmon.
>>> Looking at the HWMON subsystem there are more TMP drivers there
>>> (TMP102/103/108/401/513).
>>> The first 3 seem a bit more similar to TMP117 (in terms of register map).
>>>   
>>
>> It would probably be better suited for hwmon (it has limit registers,
>> suggesting a common use as hardware monitoring device).
> It is a curious part.  I suspect TI based their design for a medical grade
> digital thermometer chip on an existing hwmon part.
> 
> The limit registers are very simple so could be supported by IIO.
> This sits somewhere in the middle of high end thermocouple chips which
> tend to be in IIO and typically lower accuracy / range hwmon parts.
> 
> It's in the fuzzy borderline region so I doubt anyone would raise strong
> objections to which subsystem it was in.  Guenter has fallen on the
> hwmon side of things and I'm fine with that.
> 

On the other side, it turns out that there is already tmp107 support
in iio, and tmp107 is pretty much the spi equivalent of the same chip.
So it really depends on the use case. If the user wants to use the iio
subsystem, I am fine with it. We just need to remind people that this
implies no or only limited hwmon support.

[ I really need to spend the time to write a hwmon->iio bridge.
  The iio->hwmon bridge is a bit limited - I have not been able to
  figure out how to support limit registers (or event values)
  and events, and I don't think it is possible. ]

Guenter

> Jonathan
> 
>>
>>> Let's see what others have to add.
>>> But, all-in-all whatever driver you end up writing, the easiest method
>>> is to copy an existing similar driver and extend it.
>>> Sometimes, a part can be added to an existing driver.
>>> At a quick scan through existing drivers, it doesn't look like TMP117
>>> is similar to existing drivers, so it may require a new driver
>>> altogether.  
>>
>> I don't see an immediate match either, but the tmp102 hwmon driver
>> might be a good start.
>>
>> Guenter
>>
>>> I may have missed something though.
>>>
>>> Thanks
>>> Alex
>>>   
>>>>
>>>> --
>>>> Thanks and Regards
>>>>
>>>> Yours Truly,
>>>>
>>>> Puranjay Mohan  
>>
> 

