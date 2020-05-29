Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D961E7D37
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 14:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgE2M3e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 08:29:34 -0400
Received: from first.geanix.com ([116.203.34.67]:52664 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgE2M3d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 May 2020 08:29:33 -0400
Received: from [192.168.100.99] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id BE1ED2023DF5;
        Fri, 29 May 2020 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1590755370; bh=mupuMuyvjpAaSMtY6QgGFZq5vdtcHfuLa7bEJEkbtGg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Nm++LVF2RkLsFWmHCd/vEdiklK84V7Ud+Mwh7QROklmwXQjcC/6jNEP2kwjaYzxO8
         pMcV7G1uO8MeyQ3XqmC2pVUY52aO09aayFGYwuocQu+fj0VEbR9oL15atGG6JKQ9ms
         hCtSiai4/TY87yYTZJ+KZv2uTGYwwcXOtxuIhoQ7g4H5/kcicIVWFXPwRRfIq8R3mG
         OVic9mU+VdaNInF4lbKbl12gYU/Up7rx4IvtgLugtZ4srG07gvn0CzTJx7H8pY0Mv5
         67ZHXu58U+RjKzjW6YwsXyf/b2MJ2/8FWSJBufsrpA+G0WTZFHy6w+ARjjb9/e7m5g
         R33pS4FMklBOw==
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
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
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <4a4c7141-acbf-3a7d-3d0b-6c056c8f9ed8@geanix.com>
Date:   Fri, 29 May 2020 14:29:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529121616.GD3198@localhost.localdomain>
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



On 29/05/2020 14.16, Lorenzo Bianconi wrote:
> On May 29, Sean Nyekjaer wrote:
>>
>>>
>>> Ack, values seem properly updated, while values reported to the upserspace are
>>> using wrong value? could you please try to dump ts samples reading the hw queue
>>> after the resume?
>>>
>>> Regards,
>>> Lorenzo
>>>
>>
>> I have add the raw timestamps to the trace:
>> https://gist.github.com/sknsean/1eb3c074d6f2d134632582a4771322bb
>>
>> Both with and without the proposed patch :)
>>
>> /Sean
> 
> are these values from the hw FIFO? can you please add sensor->ts_ref to the trace and
> a log into st_lsm6dsx_reset_hw_ts?

The values are from the timestamp got when reading /dev/iio:deviceX.
Will add hw FIFO and ts_ref stamps to the trace next Tuesday

/Sean
