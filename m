Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E8F18E4C6
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 22:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCUVX4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 17:23:56 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34285 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgCUVX4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 17:23:56 -0400
Received: by mail-pj1-f65.google.com with SMTP id q16so4518266pje.1;
        Sat, 21 Mar 2020 14:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vJAB8piyycoPneEfsaa7KCnqSfhPKUeLOEoPQN14swc=;
        b=eOjzr0vWeVYbLJxeZeCZ7zZj6ahsW/SWsg8TFUBPvb22esVK/pDcmYAC8+SPflvN6J
         vsiyZzIQuTj98IEAU9wx83dyPQKJqoJrnsqdaqRGEdA40RNDjqXVmCkO5qTMmENjB2bf
         W9MVxV5K8CcMwDkNdTVwodeGvNZzyM7Kyz4qQOvynAnsDSFIpZnaNe1m4SxTt5JdStmS
         /sTLOpJ+ClBf2hsDilm9CuqnUW0h4ry24BBv5MJtrhAwimXXeVq4yDm2Y2/ANibqx22z
         j2Us4XohOj+HyjCQSpjGrifCEVc8P3BtkYTMc1nW7BAN09yjwn5RgcyLDZvVhtF7J4Qc
         q7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vJAB8piyycoPneEfsaa7KCnqSfhPKUeLOEoPQN14swc=;
        b=p7OrGfr9+KxwB/lv/In6JJI8xiTmYeiNEF75rIogVH1srRexwdG88YByFM0usGmJf2
         8t5eQqKnGuYdlRfQmDPPxBnuNRKkHUq8o53SJa92E82ger7YchSFksXGte6mncBsNr57
         t+zzIUUncQplovBAXlvc6ge6Ark3yZyyGTmFZgKcFc04lL2OdjbG8AR15p6cImF2oeGy
         hFjGzMvhIFv2HnlanKig8rLyRu1cZau4QjqnFWK5DlwZe/Fm7q4V1BScg7HG4qbWo66o
         EIlaU9mZvIX58qiSAyyW7yrIkojC9rD6MjeY3bo2MEUgE9wL8/IX6kYJkEVl6lWDpONE
         1a6w==
X-Gm-Message-State: ANhLgQ0rXXIfNgG5Ol3QIvFr9OzyUTUVpCM2LYzD5Qfmn029qQ+FX1cU
        52nvVCxl65TVyjyB+nVuGZfMzKgFb48=
X-Google-Smtp-Source: ADFU+vsiVFHLSphfxXT5KJ4Jzwcim+J6te4uTxR8XrMo07U/FIeoLUCVrHH7Qn2SU05FTvIWCCpReA==
X-Received: by 2002:a17:90a:7184:: with SMTP id i4mr5517749pjk.40.1584825834969;
        Sat, 21 Mar 2020 14:23:54 -0700 (PDT)
Received: from ?IPv6:2409:4072:488:8b8b:892d:8d8:1a6c:acda? ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id a10sm2232031pfi.16.2020.03.21.14.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 14:23:54 -0700 (PDT)
Subject: Re: [PATCH 01/13] iio: accel: kxsd9: Use suitable format specifier
To:     Joe Perches <joe@perches.com>, jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200321210204.18106-1-nish.malpani25@gmail.com>
 <20200321210204.18106-2-nish.malpani25@gmail.com>
 <e7188ce191ab1dfb06db0346f45e20829df63c70.camel@perches.com>
From:   Nishant Malpani <nish.malpani25@gmail.com>
Message-ID: <e4612596-babb-aa0f-aafe-dd3f69393b47@gmail.com>
Date:   Sun, 22 Mar 2020 02:53:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e7188ce191ab1dfb06db0346f45e20829df63c70.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 22/03/20 2:39 am, Joe Perches wrote:
> On Sun, 2020-03-22 at 02:31 +0530, Nishant Malpani wrote:
>> Provide more suitable format specifiers while printing error logs.
>> Discards the use of unnecessary explicit casting and prints symbolic
>> error name which might prove to be convenient during debugging.
> 
> 
> 'Use suitable format specifier' is obscure and not specific.
> 
> All the subjects should likely be something like
> 
> [PATCH] subsystem: Use vsprintf extension %pe for symbolic error name
> 
Agreed. I was just skeptical about that previously because the commit 
subject line's length was going way beyond 50 chars. I do get your point 
though; I'll send in a v2!

> 
>> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
> []
>> @@ -21,8 +21,8 @@ static int kxsd9_i2c_probe(struct i2c_client *i2c,
>>   
>>   	regmap = devm_regmap_init_i2c(i2c, &config);
>>   	if (IS_ERR(regmap)) {
>> -		dev_err(&i2c->dev, "Failed to register i2c regmap %d\n",
>> -			(int)PTR_ERR(regmap));
>> +		dev_err(&i2c->dev, "Failed to register i2c regmap %pe\n",
>> +			regmap;
> 
> And this could use a separator between regmap and errname like
> 
> 		dev_err(&i2c->dev, "Failed to register i2c regmap: %pe\n",
> or
> 		dev_err(&i2c->dev, "Failed to register i2c regmap - %pe\n",
> 
> 

Yes, I had thought of this but was too timid to ask, thinking it was 
perhaps there for legacy reasons :P

I'll add a separator in v2. Thanks for reviewing!

With regards,
Nishant Malpani
