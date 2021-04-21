Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00D43673E7
	for <lists+linux-iio@lfdr.de>; Wed, 21 Apr 2021 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245597AbhDUUA6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Apr 2021 16:00:58 -0400
Received: from www381.your-server.de ([78.46.137.84]:43904 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbhDUUA5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Apr 2021 16:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=yt70wR24IFvvxPRHHqNJYfo+rlOehQs+hl0UuMrdIUw=; b=UKYaeUrVOsbtJyT4RDME2ixy+y
        MM8Iblj/3FdDkK/vGZLJ0dr/mPsm1XJlkn3ldDDM9n53Uem+FyoE2jp0LeRj4oTCidXFK8l/Xxnl9
        /xTWzTbmZnwQxoo0yBfNawbULL9hRmq4hEvPBC4un72CHSRKm9qvCTpSR146VB9wUm0EhF+uu209m
        EwZ0ipm9hlNSzN8zdc6FOo3IWuC0Gy8GvwEA59bZrkTf6c8douPur6BU9d7ePReVBXP+AnFswRuHb
        127L9G7agYVKVAGuD3VJAgl+5YHn9oUzvjLNnUOaVKKiD6UvyOd96D4ABubO1WZuQ4t/3Uaxk0Z1P
        e9eNIdEg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lZJ1J-000GXC-3t; Wed, 21 Apr 2021 22:00:21 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lZJ1I-000RA3-Qk; Wed, 21 Apr 2021 22:00:20 +0200
Subject: Re: BUG: iio: mpu3050: Wrong temperature scale
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
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
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b5a2ce37-b386-40b3-d9ad-6e77deda74e6@metafoo.de>
Date:   Wed, 21 Apr 2021 22:00:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vckb-B=rLsZA3At2zU95No9SUvRo24xNodObZEv-UU81Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26147/Wed Apr 21 13:06:05 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/21/21 9:41 PM, Andy Shevchenko wrote:
> On Wed, Apr 21, 2021 at 10:05 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Wed, Apr 21, 2021 at 1:14 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Tue, Apr 20, 2021 at 11:26 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>
>>>> I found a non-kernel example
>>>> which uses a similar equation [1], but in a different form. The main
>>>> difference is that the Arduino code interprets a raw temperature value
>>>> as a signed integer, while upstream assumes it's unsigned.
>>>>
>>>> [1]
>>>> https://github.com/blaisejarrett/Arduino-Lib.MPU3050/blob/master/MPU3050lib.cpp#L111
>>> Oh that's nice. Room temperature as mentioned is 20 deg C
>>> I think?
>>>
>>> The divide by 280 part seems coherent in all examples.
>>>
>>>> Still, even if assume that the raw temperature is a signed s16 value, it
>>>> gives us ~35C in a result, which should be off by ~10C.
>> Actually here [1] it says in chapter 3.1 that room temperature is 35°C.
>>
>> Range: -30°C .. +85°C
>> Sensitivity: 280 LSB/°C
>> Room temperature offset: 35°C = -13200 LSB
>>
>> [1]: https://www.cdiweb.com/datasheets/invensense/mpu-3000a.pdf
>
> So, if I'm reading this and the register description right the value
> is in the range
> -32768..32767.
> -13200 defines 35°C
>
> 50000 as mentioned by Dmitry is actually -15536. So, it means that the
> more negative a value is the higher temperature is shown.
>
> Since it's linearized scale, now we can see that
>
> (13200 -15536)/280 + 35 gives us 26.66.
>
> Does it make sense?
(13200 + x)/280 + 35 = (23000 + x)/280, which is what is in the driver. 
So the only bit missing is the cast to s16.


