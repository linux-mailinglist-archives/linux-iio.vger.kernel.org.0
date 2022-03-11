Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C144D60B1
	for <lists+linux-iio@lfdr.de>; Fri, 11 Mar 2022 12:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiCKLe6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Mar 2022 06:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiCKLe5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Mar 2022 06:34:57 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366CBBBE3A
        for <linux-iio@vger.kernel.org>; Fri, 11 Mar 2022 03:33:53 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6B0BA83282;
        Fri, 11 Mar 2022 12:33:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1646998430;
        bh=uIGqzCRE2RJ9/x1/Nw+c1d0yjrXrbZwVyXY8llXFRx8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JCngCBNmLf9BN70eWH0If6Ose5BPfYX3FKZe0YAs0MzD0HaEu8ZMZoJFpaF054zyO
         0SQtHkIz4gDGmm9mwpr2Ebv9fT2lraSd8WEZa4UfOPwGv/BBNM7+5wReJkd81Ck4Ca
         NfpSt/twBSVwAaWQ6EUi5GzR/4T0ZRnYCHlQKcQZruaLoKgJFMIf4XSFzoO0hP/9Eo
         jzEZwLvlQ6U9uaV1nl5yTML426/Zi3soZwBD6ERKVBNNVn3oVTuMmh5oVSbF3Mt7Cj
         gFcNt33bm5tbdjuHmthfFLi84+fIqSd7tKfaNv02pNVZuQspT2ysbwOHbzTd0YMjcy
         AGnCY/5luH5tQ==
Message-ID: <1504edf0-5773-781a-1a4f-056f57dfbf15@denx.de>
Date:   Fri, 11 Mar 2022 12:33:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 4/6] iio: adc: ti-ads1015: Deduplicate channel macros
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220310003402.490478-1-marex@denx.de>
 <20220310003402.490478-4-marex@denx.de> <YioKZ6EZvYHOOFMe@smile.fi.intel.com>
 <082e1654-74b7-aed2-4915-f8dd304540d6@denx.de>
 <CAHp75VfDv5CE0cDSBDeMeWj4ub1JV9o-jPpqhLvwnmmN+=WJ0Q@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAHp75VfDv5CE0cDSBDeMeWj4ub1JV9o-jPpqhLvwnmmN+=WJ0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/11/22 12:29, Andy Shevchenko wrote:
> On Fri, Mar 11, 2022 at 1:55 AM Marek Vasut <marex@denx.de> wrote:
>> On 3/10/22 15:25, Andy Shevchenko wrote:
>>> On Thu, Mar 10, 2022 at 01:34:00AM +0100, Marek Vasut wrote:
> 
> ...
> 
>>>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>> Cc: Daniel Baluta <daniel.baluta@nxp.com>
>>>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>
>>> You may consider using --cc parameter in `git send-email` to avoid this noise
>>> in the commit messages.
>>
>> This is deliberate so I can keep track of who to CC on which patch.
> 
> You may add the Link tag to lore (which `b4` tool can do
> automatically), so you can always access the email from the archives
> and track this down. No need to have this in each of the commit
> messages.

This is used by git-send-email to put the right people on Cc, not by Lore.

> ...
> 
>>>> -            .realbits = 12,                                 \
>>>> +            .realbits = (_realbits),                        \
>>>>               .storagebits = 16,                              \
>>>
>>> This seems inconsistent a bit. What if the next chip wants to have more than
>>> 16 bits in realbits?
>>
>> When such a chip exists, this can be parametrized as well.
> 
> Yes, My point is that it's error prone.

Won't IIO core warn if realbits > storagebits ?

> ...
> 
>>> I see two options:
>>> 1) add static assert to make sure realbits <= storagebits;
>>
>> Does static_assert work in array of structures (I don't think it does) ?
> 
> You can check, but IIRC some of the macros have it. Don't remember the
> details, though.

I already checked before replying, hence my question, as I didn't find a 
way to make it work.
