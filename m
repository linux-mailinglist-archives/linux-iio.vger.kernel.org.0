Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E481ECE5F
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 13:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgFCL3y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 07:29:54 -0400
Received: from first.geanix.com ([116.203.34.67]:36242 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFCL3y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Jun 2020 07:29:54 -0400
Received: from [192.168.100.99] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id 2C2912120C35;
        Wed,  3 Jun 2020 11:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1591183791; bh=wBeM75o3LXSmgZFB4aEQiYoDWU9YesiU0wIFkA5czVk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jFJlLxmc4HaGkDsYES3AXnjFReCTAPQrAvpWr+8aI4Q3mmRdPfRtuzUCXdKxiSdDB
         TXcCXHARTPMEp+2zaTRlaBjwyOzeCFTD6fWfcf9/DCV7ZLNklLEr1viiTxtRGD6BZU
         J4vDFiAj5s6XZOXXmCmKzvzGA/BqwS6+5Z8f3BbExlmUQo4SbCheIwvh9b3Rbd9eHo
         5ZtsXKVywGgES198PeaQ0ygMhiUD6F6172myIfVrJlxyIS4ZhL7qVFmeYjiir5g8h/
         USlQoypqot0njyiL/dNxk9E1g+rSDV7j+WJXAirFjKihcvyBKVhgdyz8KK8a+eFRsI
         4/9bBuPYpuhNg==
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20200529085052.GC3198@localhost.localdomain>
 <08c824c2-dfb2-7a5c-b6fd-8258d6ce3808@geanix.com>
 <20200529121616.GD3198@localhost.localdomain>
 <26401237-5e3b-faf7-35c7-9d6e22f6d239@geanix.com>
 <b3363da1-033b-4afa-59cd-28328ec32066@geanix.com>
 <e9964fda-3b83-2e23-299a-7ab7d50529af@geanix.com>
 <20200603080619.GA544784@lore-desk.lan>
 <91165f5d-8cba-3ea2-67dc-99d65bce3d19@geanix.com>
 <20200603102841.GC544784@lore-desk.lan>
 <d3288925-0891-8c72-b0e7-2b71ff50e1d3@geanix.com>
 <20200603105105.GD544784@lore-desk.lan>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <a6716a15-abf9-3218-00b8-fb7f257e5649@geanix.com>
Date:   Wed, 3 Jun 2020 13:29:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603105105.GD544784@lore-desk.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on fdf6823a942a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 03/06/2020 12.51, Lorenzo Bianconi wrote:
>>>>
>>>> Hmm, suspend again for 15s.
>>>>
>>>> https://gist.github.com/sknsean/911ae4ae2e74ebe1e7eca1405c645ff1
>>>>
>>>> [  105.520634] PM: suspend exit
>>>> [  105.540206] ts_ref 1591097307780181385, ts 2861700000, sample_time
>>>> 1591097310641881385
>>>>
>>>> [  105.548416] ktime_get_real_ns: 1591097322928175385
>>>>
>>>> CLOCK_REALTIME isn't ready in the resume function. I think we need to link
>>>> it to CLOCK_BOOTTIME (Which ticking under suspend) instead.
>>>
>>> With latest patch it seems to me the time reported is now monotonic so it seems
>>> correct. What is the clocktype you set? you can check it in:
>>> /sys/bus/iio/devices/iio:device<x>/current_timestamp_clock
>>
>> default: realtime
>>
>> In the dump above the ktime_get_real_ns(first fifo dump after suspend) -
>> ts_ref + ts is = 12,286294 sec...
>>
>> /Sean
> 
> right. Could you please add to the dump log the ts_ref value in st_lsm6dsx_resume()
> just after iio_get_time_ns()?
> 
Sure,

[  173.849649] ktime_get_real_ns: 1591097391339190269

[  173.855244] ts_ref 1591097386868224810, ts 4488650000, sample_time 
1591097391356874810

[  173.855272] ktime_get_real_ns: 1591097391344812894

[  173.861256] PM: suspend devices took 0.080 seconds

[  173.875214] Disabling non-boot CPUs ...
[  173.887482] sensor->ts_ref[1] = 1591097391377130644

[  173.906546] PM: resume devices took 0.020 seconds

[  174.028152] OOM killer enabled.
[  174.031331] Restarting tasks ... done.
[  174.078636] PM: suspend exit
[  174.127877] ts_ref 1591097391377130644, ts 4531750000, sample_time 
1591097395908880644

[  174.136383] ktime_get_real_ns: 1591097405112347968

[  174.145841] ts_ref 1591097391377130644, ts 4570200000, sample_time 
1591097395947330644

[  174.154031] ktime_get_real_ns: 1591097405129995760

Missing 13,73 sec :(

If the CLOCK_REALTIME was updated in resume(), I think the first patch 
proposal was better.

/Sean
