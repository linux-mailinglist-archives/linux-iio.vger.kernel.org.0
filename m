Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113F31ED09B
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 15:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgFCNPk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 09:15:40 -0400
Received: from first.geanix.com ([116.203.34.67]:40410 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgFCNPj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Jun 2020 09:15:39 -0400
Received: from [192.168.100.99] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id 3FB172120C4D;
        Wed,  3 Jun 2020 13:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1591190136; bh=c/OytaP6lqhrg1ogDmQ3TQzHHhxp//5MU/M+XMcMlmw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Gbdce+4KltOmo7Z2eQjgvLGpQJ7NeJEEFqESBhsbdyLPgq0yHvQ4d7h0lr3qiyp8/
         oAPKNEt1a4CgEziV/Zj0N13ZLZpzYX3DpvVDGcQCn9ZqlaUSFwwmYxxwG63EkymeDG
         wh+FgJ+p+xY8qzzTqhOLK7rp0AEabdOOw5N4OWLSbeiX5dhqiMzKThHSqDHpxwQTTv
         fTb7aL9k6T1yT4/bI5nJmibXZuGb/TR6MujnVT/LbVu4/zB5qsjqe+KlaTpEo5MXqF
         97CxBclZ7gwK8d1VF5wuHoJ74Qlj0Nx7DxpxEldXADv8nhEiNM2Jsu+ArdVTt0E+Cd
         a025CJ/NsStbA==
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <b3363da1-033b-4afa-59cd-28328ec32066@geanix.com>
 <e9964fda-3b83-2e23-299a-7ab7d50529af@geanix.com>
 <20200603080619.GA544784@lore-desk.lan>
 <91165f5d-8cba-3ea2-67dc-99d65bce3d19@geanix.com>
 <20200603102841.GC544784@lore-desk.lan>
 <d3288925-0891-8c72-b0e7-2b71ff50e1d3@geanix.com>
 <20200603105105.GD544784@lore-desk.lan>
 <a6716a15-abf9-3218-00b8-fb7f257e5649@geanix.com>
 <20200603121227.GE544784@lore-desk.lan>
 <55fb09cf-76ab-0c42-7283-0836838f2deb@geanix.com>
 <20200603125630.GF544784@lore-desk.lan>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <2d60c115-a634-c25f-b50b-38f13cac6229@geanix.com>
Date:   Wed, 3 Jun 2020 15:15:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603125630.GF544784@lore-desk.lan>
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



On 03/06/2020 14.56, Lorenzo Bianconi wrote:
>>
>>
>> On 03/06/2020 14.12, Lorenzo Bianconi wrote:
>>>>
>>>>
>>>> On 03/06/2020 12.51, Lorenzo Bianconi wrote:
>>>>>>>>
>>>>>>>> Hmm, suspend again for 15s.
>>>>>>>>
>>>>>>>> https://gist.github.com/sknsean/911ae4ae2e74ebe1e7eca1405c645ff1
>>>>>>>>
>>>>>>>> [  105.520634] PM: suspend exit
>>>>>>>> [  105.540206] ts_ref 1591097307780181385, ts 2861700000, sample_time
>>>>>>>> 1591097310641881385
>>>>>>>>
>>>>>>>> [  105.548416] ktime_get_real_ns: 1591097322928175385
>>>>>>>>
>>>>>>>> CLOCK_REALTIME isn't ready in the resume function. I think we need to link
>>>>>>>> it to CLOCK_BOOTTIME (Which ticking under suspend) instead.
>>>>>>>
>>>>>>> With latest patch it seems to me the time reported is now monotonic so it seems
>>>>>>> correct. What is the clocktype you set? you can check it in:
>>>>>>> /sys/bus/iio/devices/iio:device<x>/current_timestamp_clock
>>>>>>
>>>>>> default: realtime
>>>>>>
>>>>>> In the dump above the ktime_get_real_ns(first fifo dump after suspend) -
>>>>>> ts_ref + ts is = 12,286294 sec...
>>>>>>
>>>>>> /Sean
>>>>>
>>>>> right. Could you please add to the dump log the ts_ref value in st_lsm6dsx_resume()
>>>>> just after iio_get_time_ns()?
>>>>>
>>>> Sure,
>>>>
>>>> [  173.849649] ktime_get_real_ns: 1591097391339190269
>>>>
>>>> [  173.855244] ts_ref 1591097386868224810, ts 4488650000, sample_time
>>>> 1591097391356874810
>>>>
>>>> [  173.855272] ktime_get_real_ns: 1591097391344812894
>>>>
>>>> [  173.861256] PM: suspend devices took 0.080 seconds
>>>>
>>>> [  173.875214] Disabling non-boot CPUs ...
>>>> [  173.887482] sensor->ts_ref[1] = 1591097391377130644
>>>>
>>>> [  173.906546] PM: resume devices took 0.020 seconds
>>>>
>>>> [  174.028152] OOM killer enabled.
>>>> [  174.031331] Restarting tasks ... done.
>>>> [  174.078636] PM: suspend exit
>>>> [  174.127877] ts_ref 1591097391377130644, ts 4531750000, sample_time
>>>> 1591097395908880644
>>>>
>>>> [  174.136383] ktime_get_real_ns: 1591097405112347968
>>>>
>>>> [  174.145841] ts_ref 1591097391377130644, ts 4570200000, sample_time
>>>> 1591097395947330644
>>>>
>>>> [  174.154031] ktime_get_real_ns: 1591097405129995760
>>>>
>>>> Missing 13,73 sec :(
>>>>
>>>> If the CLOCK_REALTIME was updated in resume(), I think the first patch
>>>> proposal was better.
>>>
>>> Can you please try to use CLOCK_BOOTTIME instead?
>>>
>>
>> With CLOCK_BOOTTIME and only the ts_ref reset.
>>
>> [ 4978.971598] ts_ref 4987298377539, ts 19975950000, sample_time
>> 5007274327539
>>
>> [ 4978.971618] ktime_get_real_ns: 1591102209947858582
>> [ 4978.974386] ts_ref 4987298377539, ts 20014375000, sample_time
>> 5007312752539
>>
>> [ 4978.974408] ktime_get_real_ns: 1591102209950647832
>> [ 4978.977333] ts_ref 4987298377539, ts 20052825000, sample_time
>> 5007351202539
>>
>> [ 4978.977355] ktime_get_real_ns: 1591102209953595374
>> [ 4978.980179] ts_ref 4987298377539, ts 20091250000, sample_time
>> 5007389627539
>>
>> [ 4978.980199] ktime_get_real_ns: 1591102209956438707
>> [ 4979.002747] ts_ref 4987298377539, ts 20129700000, sample_time
>> 5007428077539
>>
>> [ 4979.002893] ktime_get_real_ns: 1591102209979130499
>> [ 4979.009099] PM: suspend devices took 0.070 seconds
>>
>> [ 4979.022969] Disabling non-boot CPUs ...
>> [ 4979.035611] sensor->ts_ref[1] = 5007372366999
>> [ 4979.056233] PM: resume devices took 0.030 seconds
>> [ 4979.157652] OOM killer enabled.
>> [ 4979.160828] Restarting tasks ... done.
>> [ 4979.203811] PM: suspend exit
>> [ 4979.272383] ts_ref 5007372366999, ts 20171250000, sample_time
>> 5027543616999
>>
>> [ 4979.279816] ktime_get_real_ns: 1591102224105489426
>> [ 4979.288129] ts_ref 5007372366999, ts 20209700000, sample_time
>> 5027582066999
>>
>> [ 4979.295147] ktime_get_real_ns: 1591102224120826134
>> [ 4979.303178] ts_ref 5007372366999, ts 20248125000, sample_time
>> 5027620491999
>>
>> [ 4979.310393] ktime_get_real_ns: 1591102224136066468
>> [ 4979.318377] ts_ref 5007372366999, ts 20286575000, sample_time
>> 5027658941999
>>
>> [ 4979.325395] ktime_get_real_ns: 1591102224151074634
>>
>> /Sean
> 
> Looking at the timestamps it seems to me the suspend lasts for ~20s, is it
> correct? Anyway I agree with you I think we need to use my first patch. Can you
> please give it a whirl with CLOCK_BOOTIME?

With boottime, and the first patch.

The suspend command is:
echo 0 > /sys/class/rtc/rtc0/wakealarm && echo +15 > 
/sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state

So I would expect the suspend time to be less than 15 sec.

[ 6537.865508] ts_ref 6585250169306, ts 8625925000, sample_time 
6593876094306

[ 6537.865536] ktime_get_real_ns: 1591103796485022099

[ 6537.871552] PM: suspend devices took 0.080 seconds

[ 6537.885280] Disabling non-boot CPUs ...

[ 6537.899371] st_lsm6dsx_resume_fifo

[ 6537.899402] Before[0]: 1591103787879280639

[ 6537.899422] Before[1]: 6585250169306

[ 6537.900217] st_lsm6dsx_reset_hw_ts

[ 6537.900259] ktime_get_real_ns: 1591103796519856474, ktime_get_ns: 
6537884499736, ktime_get_raw_ns: 6537884504487

[ 6537.900292] ktime_get_real_ns: 1591103796519893224, ktime_get_ns: 
6537884536486, ktime_get_raw_ns: 6537884539029

[ 6537.900310] After[0]: 1591103796519853599

[ 6537.900328] After[1]: 6593880296516

[ 6537.900356] ktime_get_real_ns: 1591103796519957140, ktime_get_ns: 
6537884601902, ktime_get_raw_ns: 6537884604445

[ 6537.918836] PM: resume devices took 0.030 seconds

[ 6538.080211] OOM killer enabled.

[ 6538.083390] Restarting tasks ... done.

[ 6538.136320] ts_ref 6593880296516, ts 38050000, sample_time 6593918346516

[ 6538.143076] ktime_get_real_ns: 1591103810106102968

[ 6538.149991] PM: suspend exit

[ 6538.155039] ts_ref 6593880296516, ts 76500000, sample_time 6593956796516

[ 6538.162015] ktime_get_real_ns: 1591103810125036385

/Sean
