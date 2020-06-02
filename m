Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B24E1EC186
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 20:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgFBSCa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 14:02:30 -0400
Received: from first.geanix.com ([116.203.34.67]:34526 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgFBSCa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 2 Jun 2020 14:02:30 -0400
Received: from [192.168.100.99] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id ED6EC20C0945;
        Tue,  2 Jun 2020 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1591120948; bh=G6QXXi2S0P2IsKTMY2rdkG2HT44T1Wo2umXt6xQPSnM=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=KTZR3KvW79U0RkCySD4TP2q7jDv9C2KTLFAIk9lH0qBU1A1kMZ/Akzi/mxYZO3RCK
         kB7pSjLH7YYDM4qfNOLjCP29vsJ1BJsdZi4ng0PclxKDvdLJfLpdZJuc9bN+pZAltZ
         L8xz5KDdT+4KzpJdEoovCt6N37ciak7ZcsaIYigTeQ4Cpfn1I98/VpGJWvt4jhtfLZ
         5cKUT8fwRzFRx+Uad61qErIk4SQykElitl5DxK/CF/UsGlro/OuPPQ5cd4U5l4Vhg5
         vFu7Kua3UofwtVVUEZnEiq5ing+PJa2uF8+Y93VBG5NRYsDKQQkFkjsyoLgMcrEcQe
         pLIp3sS47B8VA==
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
From:   Sean Nyekjaer <sean@geanix.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <54cb146d-e54e-acae-e89c-075521b8e7dc@geanix.com>
 <20200528210711.GD5419@localhost.localdomain>
 <3c629741-43f1-3d3a-2b40-40ddfd773e86@geanix.com>
 <20200529074443.GA3198@localhost.localdomain>
 <5bb0fca9-97a4-4bad-1314-1f275ab632ff@geanix.com>
 <20200529085052.GC3198@localhost.localdomain>
 <08c824c2-dfb2-7a5c-b6fd-8258d6ce3808@geanix.com>
 <20200529121616.GD3198@localhost.localdomain>
 <26401237-5e3b-faf7-35c7-9d6e22f6d239@geanix.com>
 <b3363da1-033b-4afa-59cd-28328ec32066@geanix.com>
Message-ID: <e9964fda-3b83-2e23-299a-7ab7d50529af@geanix.com>
Date:   Tue, 2 Jun 2020 20:02:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <b3363da1-033b-4afa-59cd-28328ec32066@geanix.com>
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



On 02/06/2020 15.39, Sean Nyekjaer wrote:
>>> are these values from the hw FIFO? can you please add sensor->ts_ref 
>>> to the trace and
>>> a log into st_lsm6dsx_reset_hw_ts?
>>>
>>
>> Hi,
>>
>> This certainly looks weird,
>>
>> https://gist.github.com/sknsean/b32bae140008cf446a8fea58e305da47
>>
>> Seems like the ts_ref is updated and used but not read/used in 
>> userspace...
>>
>> /Sean
> 
> added to st_lsm6dsx_read_fifo :
> 
> printk("ts_ref %lld, ts %lld, sample_time %lld\n", acc_sensor->ts_ref, 
> ts, acc_sensor->ts_ref + ts);
> 
> https://gist.github.com/sknsean/3ad1e9e05cb0e2ef811a3c83492a1980
> 
> Suspend again was 15sec
> 
> /Sean

Hi,

Some more findings :)
https://gist.github.com/sknsean/d31e48b65515361309cd238dcf68600f

To me it looks like ktime_get_real_ns() isn't ready or updated when we 
are calling iio_get_time_ns().
If we look in the trace ktime_get_real_ns() it's ready when we are 
getting the first sample after suspend.

Running with this patch:
https://gist.github.com/sknsean/415d1b9c34f20db4419a0c61a58eb188
+
The first from this thread.

/Sean
