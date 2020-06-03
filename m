Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66D51ECD22
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 12:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgFCKFR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 06:05:17 -0400
Received: from first.geanix.com ([116.203.34.67]:58028 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgFCKFQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Jun 2020 06:05:16 -0400
Received: from [192.168.100.99] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id EE3072120BC4;
        Wed,  3 Jun 2020 10:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1591178713; bh=2KBt6SkDNGYVuLGHF6gQxQy6vOmGcd5CwzDOrDlKhj4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WapZttPhqJPpOF1L0rmlHFDWQt3thKdsGvSLjyc3pHjHYixmoWr/Kg2rNAxowDv41
         LuNb/ZXz34VZGs9o2p2jUOBgNZgMaX9WTg56H0Msx3zo/ARgxSeLQn8Ha7nrrPsebd
         IrbVJSUNUGfkhFFZOkhdqwUzD6e64rtW7bMhtgsXX5KJabft8MUmrziw3P13o6nkyv
         TnPSqMF+PpyS4BKeFhZX82z7h87YUsmXie8h+AWXsVDp48AropWXsY3XYQ0j5NhuPL
         XX1x9jDM/2Sv9SpiBlr3qPE/T0xsvZvwCR8HlxpcSpKqo80iuC6+E++n7YNEZB/UQs
         X9DgleBCTW2+w==
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20200528210711.GD5419@localhost.localdomain>
 <3c629741-43f1-3d3a-2b40-40ddfd773e86@geanix.com>
 <20200529074443.GA3198@localhost.localdomain>
 <5bb0fca9-97a4-4bad-1314-1f275ab632ff@geanix.com>
 <20200529085052.GC3198@localhost.localdomain>
 <08c824c2-dfb2-7a5c-b6fd-8258d6ce3808@geanix.com>
 <20200529121616.GD3198@localhost.localdomain>
 <26401237-5e3b-faf7-35c7-9d6e22f6d239@geanix.com>
 <b3363da1-033b-4afa-59cd-28328ec32066@geanix.com>
 <e9964fda-3b83-2e23-299a-7ab7d50529af@geanix.com>
 <20200603080619.GA544784@lore-desk.lan>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <91165f5d-8cba-3ea2-67dc-99d65bce3d19@geanix.com>
Date:   Wed, 3 Jun 2020 12:05:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603080619.GA544784@lore-desk.lan>
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



On 03/06/2020 10.06, Lorenzo Bianconi wrote:
>>
>>
>> On 02/06/2020 15.39, Sean Nyekjaer wrote:
>>>>> are these values from the hw FIFO? can you please add
>>>>> sensor->ts_ref to the trace and
>>>>> a log into st_lsm6dsx_reset_hw_ts?
>>>>>
>>>>
>>>> Hi,
>>>>
>>>> This certainly looks weird,
>>>>
>>>> https://gist.github.com/sknsean/b32bae140008cf446a8fea58e305da47
>>>>
>>>> Seems like the ts_ref is updated and used but not read/used in
>>>> userspace...
>>>>
>>>> /Sean
>>>
>>> added to st_lsm6dsx_read_fifo :
>>>
>>> printk("ts_ref %lld, ts %lld, sample_time %lld\n", acc_sensor->ts_ref,
>>> ts, acc_sensor->ts_ref + ts);
>>>
>>> https://gist.github.com/sknsean/3ad1e9e05cb0e2ef811a3c83492a1980
>>>
>>> Suspend again was 15sec
>>>
>>> /Sean
>>
>> Hi,
>>
>> Some more findings :)
>> https://gist.github.com/sknsean/d31e48b65515361309cd238dcf68600f
>>
>> To me it looks like ktime_get_real_ns() isn't ready or updated when we are
>> calling iio_get_time_ns().
>> If we look in the trace ktime_get_real_ns() it's ready when we are getting
>> the first sample after suspend.
>>
>> Running with this patch:
>> https://gist.github.com/sknsean/415d1b9c34f20db4419a0c61a58eb188
>> +
>> The first from this thread.
>>
>> /Sean
> 
> Hi Sean,
> 
> looking at the logs I guess we should not reset the sensor hw ts. Could you
> please try the below patch?
> 
> Regards,
> Lorenzo
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 0b776cb91928..4f8a9bcee77b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2445,6 +2445,8 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
>   		if (!(hw->suspend_mask & BIT(sensor->id)))
>   			continue;
>   
> +		sensor->ts_ref = iio_get_time_ns(hw->iio_devs[i]);
> +
>   		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
>   		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
>   		    sensor->id == ST_LSM6DSX_ID_EXT2)
> 

Hmm, suspend again for 15s.

https://gist.github.com/sknsean/911ae4ae2e74ebe1e7eca1405c645ff1

[  105.520634] PM: suspend exit
[  105.540206] ts_ref 1591097307780181385, ts 2861700000, sample_time 
1591097310641881385

[  105.548416] ktime_get_real_ns: 1591097322928175385

CLOCK_REALTIME isn't ready in the resume function. I think we need to 
link it to CLOCK_BOOTTIME (Which ticking under suspend) instead.

/Sean
