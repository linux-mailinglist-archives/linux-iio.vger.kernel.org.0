Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434FE367593
	for <lists+linux-iio@lfdr.de>; Thu, 22 Apr 2021 01:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbhDUXLB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Apr 2021 19:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238526AbhDUXLB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Apr 2021 19:11:01 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7B6C06174A;
        Wed, 21 Apr 2021 16:10:27 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h36so15057846lfv.7;
        Wed, 21 Apr 2021 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MdCzV0EDoGgC2ew3GQSXQ5B7KN+U1mSab9WvYLEhRts=;
        b=pl4oYjhOAftazB/9sITfk1iSN1jI+Tbgt3oPmq8FXieVx+CUJ8a/icl7WXcibYGRm5
         K3zHH+o5OE+wfXH8D2SnGrfZr3qSg1UAJxorJj2DEtQthhe20q0Lk3uxrlkAyY3CDtku
         WyMrGAj05Q0RTH/USSvoByiS44JJOcDPGViNPaPdwO5wWwU0ZWWv45JRsWFd40SmKuN/
         9eMamf/pHa6Z6mDcM2jtqR1fsLW4YGZFPqSZYWQeSz8CL44PJ3Gz4cV54hXGdx6BfuLO
         ka8fGcEmBNJJmVK7TmCc9xl9PRf9DjFczZvw/oVl8VYpQzMKf3z6YFSh4EE0tl++i/VT
         Q7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MdCzV0EDoGgC2ew3GQSXQ5B7KN+U1mSab9WvYLEhRts=;
        b=GwGq6QBN1Z7/O2EX2ePPT6sBPWlYbKL7xW77sphzsrgvX/CJHRC7qjBvHGSOdt/mGc
         4JT+2EAG72NlPs0tetp7X+4/BKRe9Z7eBcyiyLTcfSfc5mIYDkAb0PgP0t89VXfYjNTd
         hhf+aIt3N7qQOhWa07iBP5Ll3ZGaDOEtE7KmquZxuCqaaT8h6DBthrRCjHLivuIrY2sT
         vYiStupAKGS84w4MVLEl/0RCRehz8330ziNPnjwvFc68cn3w8M1vBIZJiHwv0dTvbd79
         qL/lB+0fC5RXQGYMVWjTNahomaQskE6evJuz6UBFGh1uIlobgA340u5Bqubv4HNvDWyE
         TDNQ==
X-Gm-Message-State: AOAM532rqe8GA+gcUc0k+zTc4hGozUYyIqWdHIbiG27aRwv77nsTssT3
        L+LjdzELH4uxbw6GGaOvqo8=
X-Google-Smtp-Source: ABdhPJxlnecVwJWYit7WbL5Sd2k0wLtKx+r9exZHoGR69xB6PuxwSkqwmuzU56L+ExswwPyjYD3bDg==
X-Received: by 2002:ac2:51bc:: with SMTP id f28mr391365lfk.91.1619046625144;
        Wed, 21 Apr 2021 16:10:25 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-103.dynamic.spd-mgts.ru. [109.252.193.103])
        by smtp.googlemail.com with ESMTPSA id h5sm100385ljj.98.2021.04.21.16.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 16:10:24 -0700 (PDT)
Subject: Re: BUG: iio: mpu3050: Wrong temperature scale
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Nathan Royer <nroyer@invensense.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
References: <483ac17b-705a-38c3-54ee-7f0089262c03@gmail.com>
 <CACRpkdbEue3OLpU0L_SDAsxpLTY7aqRP5sOZ90pF=o-Yb0ot4Q@mail.gmail.com>
 <f2b7938f-12ea-529b-da5e-83c9c8074e1a@gmail.com>
 <CACRpkdbtnCoDdwJA9oi88NKStf5uhi72DgP_a=3Dpp_aT=kYNg@mail.gmail.com>
 <CAHp75VcEsrM+uYSLo2iEta7C8LQtg26iwQVFX1GUk1Gp5TPT7g@mail.gmail.com>
 <CAHp75Vckb-B=rLsZA3At2zU95No9SUvRo24xNodObZEv-UU81Q@mail.gmail.com>
 <b5a2ce37-b386-40b3-d9ad-6e77deda74e6@metafoo.de>
 <CACRpkdborNeVNQEq9vf9N_CCkKqpBN-0g0FE-oJws4zTrxnXvQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4c204f77-d560-43d3-c5d2-eced7a1124dc@gmail.com>
Date:   Thu, 22 Apr 2021 02:10:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdborNeVNQEq9vf9N_CCkKqpBN-0g0FE-oJws4zTrxnXvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

22.04.2021 02:02, Linus Walleij пишет:
> On Wed, Apr 21, 2021 at 10:00 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 4/21/21 9:41 PM, Andy Shevchenko wrote:
>>> On Wed, Apr 21, 2021 at 10:05 PM Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>> On Wed, Apr 21, 2021 at 1:14 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>> On Tue, Apr 20, 2021 at 11:26 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>>
>>>>>> I found a non-kernel example
>>>>>> which uses a similar equation [1], but in a different form. The main
>>>>>> difference is that the Arduino code interprets a raw temperature value
>>>>>> as a signed integer, while upstream assumes it's unsigned.
>>>>>>
>>>>>> [1]
>>>>>> https://github.com/blaisejarrett/Arduino-Lib.MPU3050/blob/master/MPU3050lib.cpp#L111
>>>>> Oh that's nice. Room temperature as mentioned is 20 deg C
>>>>> I think?
>>>>>
>>>>> The divide by 280 part seems coherent in all examples.
>>>>>
>>>>>> Still, even if assume that the raw temperature is a signed s16 value, it
>>>>>> gives us ~35C in a result, which should be off by ~10C.
>>>> Actually here [1] it says in chapter 3.1 that room temperature is 35°C.
>>>>
>>>> Range: -30°C .. +85°C
>>>> Sensitivity: 280 LSB/°C
>>>> Room temperature offset: 35°C = -13200 LSB
>>>>
>>>> [1]: https://www.cdiweb.com/datasheets/invensense/mpu-3000a.pdf
> 
> Oh nice find!
> 
>>> So, if I'm reading this and the register description right the value
>>> is in the range
>>> -32768..32767.
>>> -13200 defines 35°C
>>>
>>> 50000 as mentioned by Dmitry is actually -15536. So, it means that the
>>> more negative a value is the higher temperature is shown.
>>>
>>> Since it's linearized scale, now we can see that
>>>
>>> (13200 -15536)/280 + 35 gives us 26.66.
>>>
>>> Does it make sense?
>> (13200 + x)/280 + 35 = (23000 + x)/280, which is what is in the driver.
>> So the only bit missing is the cast to s16.
> 
> Yup there is the bug. (I am guilty.)
> 
> Dmitry will you test & send a patch?


I'll send the patch. Thank you all for yours help!
