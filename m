Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B50E36747B
	for <lists+linux-iio@lfdr.de>; Wed, 21 Apr 2021 22:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbhDUU6z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Apr 2021 16:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbhDUU6z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Apr 2021 16:58:55 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D205C06174A;
        Wed, 21 Apr 2021 13:58:20 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a1so49309554ljp.2;
        Wed, 21 Apr 2021 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HbjyALLYT9sc4ltzHbyvFrQq0il4AdDcmjIqRRdwAcg=;
        b=JC4S4AeHQz+8tvq0dKWeCwyFl4AglL83Ha1TC5CiNL8zURhrmL/Ym9y3VD2bHKflDl
         3wT/+06zNZJBmopz7lqjc9wftqHaWu+1u8JGHF5ikLiKM2jfoocZcNstd0E0PqHTtc9a
         RjWTKWexDoTIXYUIkDoZmHJm4KrMehSHSTvbdirJs8l9yG4fmXTrCLEeZuGFa5fC7hgO
         VvW2Fycr44EPe1SW34Bsv/ROlsppm8V4CvVxocL//QQ60OgxlgTiPW6C5vE8WE49LBoW
         Fjb2akZP3c4mXkk8Q2Xvt9CxUl1lYMRoCZXn9NTQkeDgZWNIotuAaMUEKuecXIcEK/hy
         mxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HbjyALLYT9sc4ltzHbyvFrQq0il4AdDcmjIqRRdwAcg=;
        b=r/zegBTTfhN9d3rkae0k/fHzMZJ8Hx+odJLAAi/kY6J+Cbazrehn4USOda1ptX99JB
         wJU7k+tfZSQ0uYezx0h88lwrOpZSTDeDoxPljRHn2ZA6oyn3DNJ03/8JNw+Z/tYXge0h
         mV1D81VzApmnQe3lpVS0nX+v1g4oZIdgmvUGjT2gNRsrZsXbN6ZGjqUNhdECCZnMA1Ea
         qId4nrZuSu31qqgG2HQBJ/vwCS8v1ta/0OFZSry0ZrF48bi2br/F8pil5jVpq81ZHP07
         FepHh7uJ5Rc58xrjnkpmZ8KRcM9kS5WmWJiM5xJRrSxj6js0xrrVN9PduISJomcKCapK
         /j0Q==
X-Gm-Message-State: AOAM530Hj9VL6laamksLfX+immFDJ7iXSDXJjeBBfZUHuyI1qRcCK5pa
        LGEWeHoNR8HO0jdGxP5q/YNC1E+ZC98=
X-Google-Smtp-Source: ABdhPJwWffQ74QyHL/EUXvvs7iEVOZjmTLuLf2YV7vbh+hKaUXslKziidpXcBtFx7FBT7TonYudAiA==
X-Received: by 2002:a2e:6a05:: with SMTP id f5mr102861ljc.23.1619038698931;
        Wed, 21 Apr 2021 13:58:18 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-103.dynamic.spd-mgts.ru. [109.252.193.103])
        by smtp.googlemail.com with ESMTPSA id b10sm66928ljr.109.2021.04.21.13.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 13:58:18 -0700 (PDT)
Subject: Re: BUG: iio: mpu3050: Wrong temperature scale
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
References: <483ac17b-705a-38c3-54ee-7f0089262c03@gmail.com>
 <CACRpkdbEue3OLpU0L_SDAsxpLTY7aqRP5sOZ90pF=o-Yb0ot4Q@mail.gmail.com>
 <f2b7938f-12ea-529b-da5e-83c9c8074e1a@gmail.com>
 <CACRpkdbtnCoDdwJA9oi88NKStf5uhi72DgP_a=3Dpp_aT=kYNg@mail.gmail.com>
 <CAHp75VcEsrM+uYSLo2iEta7C8LQtg26iwQVFX1GUk1Gp5TPT7g@mail.gmail.com>
 <CAHp75Vckb-B=rLsZA3At2zU95No9SUvRo24xNodObZEv-UU81Q@mail.gmail.com>
 <b5a2ce37-b386-40b3-d9ad-6e77deda74e6@metafoo.de>
 <CAHp75VdY2NXJJGkT=so847wjxS3iCrsiZsvBR-V68XVM7HeRyw@mail.gmail.com>
 <CAHp75VczPd5kNBTD+LroYnVo31azYHBD8RZdy9RaQEK3KvObHQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <af175b05-e37f-f9b3-cfd9-8bf48add3e99@gmail.com>
Date:   Wed, 21 Apr 2021 23:58:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VczPd5kNBTD+LroYnVo31azYHBD8RZdy9RaQEK3KvObHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

21.04.2021 23:04, Andy Shevchenko пишет:
> On Wed, Apr 21, 2021 at 11:02 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>
>> On Wed, Apr 21, 2021 at 11:00 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> On 4/21/21 9:41 PM, Andy Shevchenko wrote:
>>>> On Wed, Apr 21, 2021 at 10:05 PM Andy Shevchenko
>>>> <andy.shevchenko@gmail.com> wrote:
>>>>> On Wed, Apr 21, 2021 at 1:14 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>>> On Tue, Apr 20, 2021 at 11:26 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>>>
>>>>>>> I found a non-kernel example
>>>>>>> which uses a similar equation [1], but in a different form. The main
>>>>>>> difference is that the Arduino code interprets a raw temperature value
>>>>>>> as a signed integer, while upstream assumes it's unsigned.
>>>>>>>
>>>>>>> [1]
>>>>>>> https://github.com/blaisejarrett/Arduino-Lib.MPU3050/blob/master/MPU3050lib.cpp#L111
>>>>>> Oh that's nice. Room temperature as mentioned is 20 deg C
>>>>>> I think?
>>>>>>
>>>>>> The divide by 280 part seems coherent in all examples.
>>>>>>
>>>>>>> Still, even if assume that the raw temperature is a signed s16 value, it
>>>>>>> gives us ~35C in a result, which should be off by ~10C.
>>>>> Actually here [1] it says in chapter 3.1 that room temperature is 35°C.
>>>>>
>>>>> Range: -30°C .. +85°C
>>>>> Sensitivity: 280 LSB/°C
>>>>> Room temperature offset: 35°C = -13200 LSB
>>>>>
>>>>> [1]: https://www.cdiweb.com/datasheets/invensense/mpu-3000a.pdf
>>>>
>>>> So, if I'm reading this and the register description right the value
>>>> is in the range
>>>> -32768..32767.
>>>> -13200 defines 35°C
>>>>
>>>> 50000 as mentioned by Dmitry is actually -15536. So, it means that the
>>>> more negative a value is the higher temperature is shown.
>>>>
>>>> Since it's linearized scale, now we can see that
>>>>
>>>> (13200 -15536)/280 + 35 gives us 26.66.
>>>>
>>>> Does it make sense?
>>> (13200 + x)/280 + 35 = (23000 + x)/280, which is what is in the driver.
>>> So the only bit missing is the cast to s16.
>>
>> Cool! So, that cast needs a very good comment then :-)
> 
> "will need" (since it's not yet in upstream)
> 
> 

The exact value I'm getting is 52144, which is -13392 and gives us 35C.
I see that the datasheet says it should be a temperature of the sensor
die, so maybe it's a correct value, although it means that it's warm as
much as ARM CPU core, which is questionable to me whether it's a correct
value.
