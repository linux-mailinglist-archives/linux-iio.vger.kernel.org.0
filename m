Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21E1229A14
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 16:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbgGVO3U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 10:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbgGVO3U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 10:29:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59720C0619DC;
        Wed, 22 Jul 2020 07:29:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so1366813pgf.0;
        Wed, 22 Jul 2020 07:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QOlF42W19oDFj6XPjZGPoKvTv1FeMYxOKHou6gHLWEw=;
        b=CzNQOltYanqlRB+ALpWnfsCw87+ELSMI3DJGPGBztSXhCSRSQiR/FVr60iGNRlJHIx
         dlLTE+wVIb8o2ucPKudOQ3Uk/SWoqrTiN5A49c1yg2xT2gIA9GnqAdKVMXGXbYLXvGjw
         BnVnPR4HXe/WcKQAJn/jfwHrd7ighS5xAikb9dmeIyfA6rKe56fiT5ZWawUL4zhOsa6m
         AXZFtnx6bVhSFEuR/b/yYgFx+r7f1WyJV/mSqqvXik8NqNLRBsUbGK1Q8U6k7aCqq0k5
         pZ4e9d16qCnkvMo2eSEAvDXtnGFnb9gsM6MayKIitg7R3VhUyTrDr3gj/bJZqqYoAEyl
         7xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QOlF42W19oDFj6XPjZGPoKvTv1FeMYxOKHou6gHLWEw=;
        b=TI2qn0hxu2C3hEtEHGieAyARNvHPm+0+C99fj8ETr0J/BauVFw9Usui/t21eNM9jqY
         D4MMlbJBPo7ryae4BohXsASHslzx0pKPTACrGcpnNJYFxG71HiomekPLBCyLzW0ABJwd
         77b4AQxKq3nh7byR1xfLQNIB8jh7xuRdNufBsYUHNkH/zLs3wSaNxsAHVsS/mRXWS68C
         grmrU+SX6jlUhN3tRWAipqnYyW+t/KjfOIQI1mKvw0srLcireV4zrhOJWUxD+gbQtagq
         ZvLFT+Oy7UKlu8QjvE+QO0agXzhFVEHJ6yLin4gJrKZXH9AgcTbbbvVX+3tKEYrXwA3U
         qKCQ==
X-Gm-Message-State: AOAM533Y9/XLnC/Gb2Be0/6W4+B0KIE4jxeRNI/udZfjBvwjSxZ6duxr
        sSSoyG65rtSOvZ+bjCRnrW1kI9KznRA=
X-Google-Smtp-Source: ABdhPJyruMb67Cnv54vcq2o7VVBTrimgwPYyQZCRBo2x/XGyBTN+wyyLTkZPi6844DrPGfeeuFjY9A==
X-Received: by 2002:a63:1f45:: with SMTP id q5mr139497pgm.240.1595428159589;
        Wed, 22 Jul 2020 07:29:19 -0700 (PDT)
Received: from ?IPv6:2409:4072:6418:58eb:d028:8959:a8a3:a7bc? ([2409:4072:6418:58eb:d028:8959:a8a3:a7bc])
        by smtp.gmail.com with ESMTPSA id c1sm154889pgi.52.2020.07.22.07.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 07:29:18 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] iio: gyro: Add driver support for ADXRS290
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        darius.berghe@analog.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20200721181926.27046-1-nish.malpani25@gmail.com>
 <CAHp75Vdr+Uo2uw3mzYP+LMRgp-eyi+YjG=O+wGVqyYx-+MRCaw@mail.gmail.com>
 <7ba8469a-dd8c-1686-6d26-e2a4cbfedce9@gmail.com>
 <CAHp75VdYVC9n7-2MH62J46N0p+sNSE9QVwonor5QfdnvL4hoLg@mail.gmail.com>
 <5cb55101-af5c-b6a2-d770-9717f8a463cc@gmail.com>
 <CAHp75Vc5e0HfVe04yzyfGC_qqhcPNnJOHXcADLfz+RKMuFBbcA@mail.gmail.com>
From:   Nishant Malpani <nish.malpani25@gmail.com>
Message-ID: <d0ec85cd-5913-491c-8543-21671f17c20f@gmail.com>
Date:   Wed, 22 Jul 2020 19:59:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc5e0HfVe04yzyfGC_qqhcPNnJOHXcADLfz+RKMuFBbcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 22/07/20 3:53 pm, Andy Shevchenko wrote:
> On Wed, Jul 22, 2020 at 12:40 PM Nishant Malpani
> <nish.malpani25@gmail.com> wrote:
>> On 22/07/20 3:08 am, Andy Shevchenko wrote:
>>> On Tue, Jul 21, 2020 at 11:35 PM Nishant Malpani
>>> <nish.malpani25@gmail.com> wrote:
>>>> On 22/07/20 1:16 am, Andy Shevchenko wrote:
> 
> ...
> 
>>> Can't you declare table as const int?
>>>
>> I'm not sure I understand you completely here; do you mean const int *?
>> So, an array of alternate integer and fractional parts? I suppose that's
>> possible but we'd be introducing unwanted complexity I feel - for
>> example, currently the index of the 3db frequency in the table is used
>> to directly map & set bits in the filter register corresponding to that
>> frequency but with the approach you share, we'd have to apply a
>> transformation (div by 2) to set the same bits in the filter register.
>> Do you think the added complexity justifies the removal of the casting?
> 
> It was a question. If you think it is too much, don't change :-)
>  > ...
> 
>>>>>> +       /* max transition time to measurement mode */
>>>>>> +       msleep_interruptible(ADXRS290_MAX_TRANSITION_TIME_MS);
>>>>>
>>>>> I'm not sure what the point of interruptible variant here?
>>>>>
>>>> I referred Documentation/timers/timers-howto.rst for this.
>>>> My reasoning was shaped to use the interruptible variant because the
>>>> transition settles in a time *less than* 100ms and since 100ms is quite
>>>> a huge time to sleep, it should be interrupted in case a signal arrives.
>>>
>>> This is probe of the device,
>>> What are the expectations here?
>>>
>> I fail to understand why this can't be used in the probe() but perhaps
>> in a routine to standby/resume. Could you please elaborate?
> 
> I didn't say it can not be used, what I'm asking is what are the
> expectations of the interruptible part here.
> In other words what is the benefit that makes you choose this over
> plain msleep().
> 
Oh, sorry for I misunderstood.

I cannot think of anything more to add to the reasoning that I explained 
earlier; in that case, I'll fall back to msleep() (in v3) unless someone 
else comes with a strong point in msleep_interruptible()'s favor.

With regards,
Nishant Malpani

