Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362B22D996E
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 15:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408201AbgLNOGt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 09:06:49 -0500
Received: from vern.gendns.com ([98.142.107.122]:59930 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408137AbgLNOGj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Dec 2020 09:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QBGrpUgU2ejJwinC8l4W0WV7QBpZ7OttlICbwgRhOvQ=; b=uJOSjCAFww6cZqgwPOvp9Pd5Ia
        tZ5fMQLj7GW0MYnD1dpEcDphZa5F+bdTOPVcY5iO9OzUk77/tuyqTnirgssYqQDDcx95csU0EWbmX
        4yEbEZmyFVZxbutvPrWT1cVEPCKLw8lnApiq0OIPv4ipxGfjw5l32fvqK3pGL0ypP5O+dqk6HY8Aw
        MpLR2FdUL78hnAbI1STd3wi+L4DqkORhZymx4EnLdgb6SBL2txMfVqu9t1HdTc6g4xOFM8OOiet0G
        tUFmZOTviaUX6J2oWnr6uSGiNM0ItjBDgKMTwajv3sxuvg4Jt4m/RaPsyhItPb1B3vzjCtpwTsNoL
        WLfjFSLw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:50498 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kooTz-0008IW-2f; Mon, 14 Dec 2020 09:05:47 -0500
Subject: Re: [PATCH] counter:ti-eqep: remove floor
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
References: <20201214000927.1793062-1-david@lechnology.com>
 <X9dQeKy/Ol4d+3iM@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <88a5ed56-ac49-bf64-4d52-8ada6d3af4ef@lechnology.com>
Date:   Mon, 14 Dec 2020 08:05:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X9dQeKy/Ol4d+3iM@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/14/20 5:46 AM, William Breathitt Gray wrote:
> On Sun, Dec 13, 2020 at 06:09:27PM -0600, David Lechner wrote:
>> The hardware doesn't support this. QPOSINIT is an initialization value
>> that is triggered by other things. When the counter overflows, it
>> always wraps around to zero.
>>
>> Fixes: f213729f6796 "counter: new TI eQEP driver"
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
> Is the QPOSINIT preprocessor define needed at all anymore, or should it also be
> removed?

There are already many more defines for registers that are not
used, so I didn't remove it.

> 
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> 
>> ---
>>   drivers/counter/ti-eqep.c | 35 -----------------------------------
>>   1 file changed, 35 deletions(-)
>>
>> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
>> index a60aee1a1a29..65df9ef5b5bc 100644
>> --- a/drivers/counter/ti-eqep.c
>> +++ b/drivers/counter/ti-eqep.c
>> @@ -235,36 +235,6 @@ static ssize_t ti_eqep_position_ceiling_write(struct counter_device *counter,
>>   	return len;
>>   }
>>   
>> -static ssize_t ti_eqep_position_floor_read(struct counter_device *counter,
>> -					   struct counter_count *count,
>> -					   void *ext_priv, char *buf)
>> -{
>> -	struct ti_eqep_cnt *priv = counter->priv;
>> -	u32 qposinit;
>> -
>> -	regmap_read(priv->regmap32, QPOSINIT, &qposinit);
>> -
>> -	return sprintf(buf, "%u\n", qposinit);
>> -}
>> -
>> -static ssize_t ti_eqep_position_floor_write(struct counter_device *counter,
>> -					    struct counter_count *count,
>> -					    void *ext_priv, const char *buf,
>> -					    size_t len)
>> -{
>> -	struct ti_eqep_cnt *priv = counter->priv;
>> -	int err;
>> -	u32 res;
>> -
>> -	err = kstrtouint(buf, 0, &res);
>> -	if (err < 0)
>> -		return err;
>> -
>> -	regmap_write(priv->regmap32, QPOSINIT, res);
>> -
>> -	return len;
>> -}
>> -
>>   static ssize_t ti_eqep_position_enable_read(struct counter_device *counter,
>>   					    struct counter_count *count,
>>   					    void *ext_priv, char *buf)
>> @@ -301,11 +271,6 @@ static struct counter_count_ext ti_eqep_position_ext[] = {
>>   		.read	= ti_eqep_position_ceiling_read,
>>   		.write	= ti_eqep_position_ceiling_write,
>>   	},
>> -	{
>> -		.name	= "floor",
>> -		.read	= ti_eqep_position_floor_read,
>> -		.write	= ti_eqep_position_floor_write,
>> -	},
>>   	{
>>   		.name	= "enable",
>>   		.read	= ti_eqep_position_enable_read,
>> -- 
>> 2.25.1
>>

