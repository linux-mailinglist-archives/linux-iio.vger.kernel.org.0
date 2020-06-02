Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5581EBD37
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 15:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgFBNjP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 09:39:15 -0400
Received: from first.geanix.com ([116.203.34.67]:55816 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgFBNjP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 2 Jun 2020 09:39:15 -0400
Received: from [192.168.64.147] (unknown [85.191.123.149])
        by first.geanix.com (Postfix) with ESMTPSA id 972EC20C0A1C;
        Tue,  2 Jun 2020 13:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1591105152; bh=gr6DXtNuaamDCNqNtayKiIWVL51hke69JV5atEVP3AA=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=jTO8+la6uWtzf3542kA0UoNSKHxnJTMF1vVGszB0JtHJYm1D055QH9YOGY7kwWE1v
         zDOsoZMnsP/OOEtN/seUPEKJlNuDgvKxVl1gtrue2LmMTjO7Qs3Tj1xDjgqFWERMLX
         3HBRQIa9k+MMSKk4WefA8UOP1GX/Y9CXrSeAyqPjGuwE8CTsQvU1DhDeQUT1cP95XJ
         mrj3NWM+5XFuv/aX8+KHA5PJ7vyefQAk8Hr7A2iEp/IR1zNUW0FxsdnNKbYI/YONvO
         CwaUqUlI9WKROMS5qrmqtpvAha5plICNhhnnx+5fwMVQQhjKa8qL08cGvsqor0dctU
         /vEv2hnmMsaUg==
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
Message-ID: <b3363da1-033b-4afa-59cd-28328ec32066@geanix.com>
Date:   Tue, 2 Jun 2020 15:39:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <26401237-5e3b-faf7-35c7-9d6e22f6d239@geanix.com>
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

>> are these values from the hw FIFO? can you please add sensor->ts_ref 
>> to the trace and
>> a log into st_lsm6dsx_reset_hw_ts?
>>
> 
> Hi,
> 
> This certainly looks weird,
> 
> https://gist.github.com/sknsean/b32bae140008cf446a8fea58e305da47
> 
> Seems like the ts_ref is updated and used but not read/used in userspace...
> 
> /Sean

added to st_lsm6dsx_read_fifo :

printk("ts_ref %lld, ts %lld, sample_time %lld\n", acc_sensor->ts_ref, 
ts, acc_sensor->ts_ref + ts);

https://gist.github.com/sknsean/3ad1e9e05cb0e2ef811a3c83492a1980

Suspend again was 15sec

/Sean
