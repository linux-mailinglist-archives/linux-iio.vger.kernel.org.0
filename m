Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B9822952A
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 11:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgGVJkO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 05:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGVJkN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 05:40:13 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C41C0619DC;
        Wed, 22 Jul 2020 02:40:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 8so898990pjj.1;
        Wed, 22 Jul 2020 02:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BTqwNESkYaInlEDNf57EMyqM2P7fZXzlbKUeW0yvUD4=;
        b=o4iNIqmLE3FMfgb+OrQxj1Mvl7e5Ktc/ApMTal4syItnYfN0BAe2XnpaUzhm0rM0k/
         XF1Q2fnTdqMsgjbVIP/xo53gFE1AJYhE5Eo8og5XjkOhmuR9h9egGUwT4ECUIIBG13ZS
         As+Cd5uLnkVzWNsqBTWaHQivC+6Vj7wZdg15/11Sh3S/aoVPw4ktv5ekYAcuEHsCIsfx
         qsYTU3fjpLaJGJOxz4tfEic4/iu8d9kIG/tgkhP3ozEwJyJ+YapN6sygf1Pg9MGeDKcb
         UmcFjl+6MH0IkTRQ5ItaxJh/2iuq1N3ACESAfcFIoCE6AN1qOA3ghtea5XYGqQhDHvN0
         2LRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BTqwNESkYaInlEDNf57EMyqM2P7fZXzlbKUeW0yvUD4=;
        b=gTZTmvCWVfqjAQ9QmfqA8dG3oA8tsGyngIXp9qxVNL2AexNUtbDaNPXbOIP4IfW66B
         pmtoT+W7VCBShE6nTHZNsnR/tjR329VaFonV0E2Krvq+iXX4UjYS+imajZ96F4kn8DOm
         v9ooAkwAZIAEunHPZFe1m+GhvTqZRvdhJXHPPFmvccvSXSroxqSLm/e0vHAI5os94sFh
         x9xNzPY+JVPxvNGnPG8dWu6coONl5H1tmIhaYsDICaFm6LgCpvq5o2Ujyv3OKONnPNaR
         dzpGueLt1zbrXzMO12PfRY+vlBUzFiLbLsA2wu5MNSsLoVaWETHon7zkinHXPWf30vXj
         V2Ww==
X-Gm-Message-State: AOAM530zZ/TaVmudAUY8HCWRmX35T4RGsYBAOvx3udTxjFPx7YdEmC4B
        bsRgmI6FanGb+WD5Xh6KfvS1mmgTYsQ=
X-Google-Smtp-Source: ABdhPJwA3Tif2dJS3Jcbh7lrpxlRuo7QjIrMiXPTHfBnLUzHEC1t1fuB4Qd3JlCqC057HkVnUJsnuA==
X-Received: by 2002:a17:902:7790:: with SMTP id o16mr23785608pll.299.1595410812927;
        Wed, 22 Jul 2020 02:40:12 -0700 (PDT)
Received: from ?IPv6:2409:4072:6418:58eb:d028:8959:a8a3:a7bc? ([2409:4072:6418:58eb:d028:8959:a8a3:a7bc])
        by smtp.gmail.com with ESMTPSA id g5sm5959977pjl.31.2020.07.22.02.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 02:40:12 -0700 (PDT)
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
From:   Nishant Malpani <nish.malpani25@gmail.com>
Message-ID: <5cb55101-af5c-b6a2-d770-9717f8a463cc@gmail.com>
Date:   Wed, 22 Jul 2020 15:10:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdYVC9n7-2MH62J46N0p+sNSE9QVwonor5QfdnvL4hoLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 22/07/20 3:08 am, Andy Shevchenko wrote:
> On Tue, Jul 21, 2020 at 11:35 PM Nishant Malpani
> <nish.malpani25@gmail.com> wrote:
>> On 22/07/20 1:16 am, Andy Shevchenko wrote:
>>> On Tue, Jul 21, 2020 at 9:20 PM Nishant Malpani
>>> <nish.malpani25@gmail.com> wrote:
> 
> ...
> 
>>>> +               *vals = (const int *)adxrs290_lpf_3db_freq_tbl;
>>>
>>> Why casting?
>>>
>> adxrs290_lpf_3db_freq_tbl is of type (int *)[2], right? Without the
>> casting, an incompatible-pointer-type error is thrown.
>>
>>> ...
>>>
>>>> +               *vals = (const int *)adxrs290_hpf_3db_freq_tbl;
>>>
>>> Ditto.
>>>
>> See above comment.
> 
> Can't you declare table as const int?
> 
I'm not sure I understand you completely here; do you mean const int *? 
So, an array of alternate integer and fractional parts? I suppose that's 
possible but we'd be introducing unwanted complexity I feel - for 
example, currently the index of the 3db frequency in the table is used 
to directly map & set bits in the filter register corresponding to that 
frequency but with the approach you share, we'd have to apply a 
transformation (div by 2) to set the same bits in the filter register. 
Do you think the added complexity justifies the removal of the casting?

> ...
> 
>>>> +       /* max transition time to measurement mode */
>>>> +       msleep_interruptible(ADXRS290_MAX_TRANSITION_TIME_MS);
>>>
>>> I'm not sure what the point of interruptible variant here?
>>>
>> I referred Documentation/timers/timers-howto.rst for this.
>> My reasoning was shaped to use the interruptible variant because the
>> transition settles in a time *less than* 100ms and since 100ms is quite
>> a huge time to sleep, it should be interrupted in case a signal arrives.
> 
> This is probe of the device,
> What are the expectations here?
> 
I fail to understand why this can't be used in the probe() but perhaps 
in a routine to standby/resume. Could you please elaborate?

With regards,
Nishant Malpani
