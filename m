Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047841EBABD
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 13:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgFBLsL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 07:48:11 -0400
Received: from first.geanix.com ([116.203.34.67]:49238 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgFBLsL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 2 Jun 2020 07:48:11 -0400
Received: from [192.168.64.147] (unknown [85.191.123.149])
        by first.geanix.com (Postfix) with ESMTPSA id 26A3920C04DC;
        Tue,  2 Jun 2020 11:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1591098488; bh=BUXEimB7o+Xb6gNtJmCZG20iSO7KZwIl+53kLlaB5/4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XlvHJzIdhRcJaKePF2ivpyU59bpAUw0yuM1LsOK93G9aaDshDtYj+HcEIV33qRNQH
         UPEqpOqeqt4mTyhDRaa+6GtkquKefZ4uBGR2FNEVh0QZiHaRQgnGD2l3djB0BHlJ8C
         vLi+z6dgPZ7x4a5PBAXu2me2bDCamoW2+Shy3xqA7rYpOYj5P6ngJHK3XaKk3ZtTmy
         cLy+P194K55siNEdt7OTNdO8K+yh88juHDWtBcfKL2C/MdCVisrrIiwW6sN/egMiEd
         J6MJopIbRgGIqVYJA+LLNmnStgUwP07hY7DBU7nMTAqbehn36UWmBqgJlVyPWcvQhw
         Cqcj3X279kZ5g==
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
Message-ID: <26401237-5e3b-faf7-35c7-9d6e22f6d239@geanix.com>
Date:   Tue, 2 Jun 2020 13:48:07 +0200
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
> 

Hi,

This certainly looks weird,

https://gist.github.com/sknsean/b32bae140008cf446a8fea58e305da47

Seems like the ts_ref is updated and used but not read/used in userspace...

/Sean
