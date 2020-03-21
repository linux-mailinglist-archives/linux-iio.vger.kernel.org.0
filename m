Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9415918E3A4
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 19:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgCUS0l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 14:26:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43199 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgCUS0l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 14:26:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id f8so3953320plt.10;
        Sat, 21 Mar 2020 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q7P3d4bottmxnpPOnOchr0kX1G9VuQbjItV2DWo+ReI=;
        b=ck6e0qmrGP019nLsTNhKoxpxi5Hju4mUcMJmewHC4zXcbf8gTgVg0QapUB5ayqEw83
         dVG5fzCw/iCdfp9BbXvDnUbaIrPP0sUtirLggqjJ3bsPP3IFQJ0s1TnzXzhKes9IJlw3
         K0jrkLnwT8G220oscM12N/Em1SGwqEf07cnNWJqf2OPclVlK8HUmq4d4i8j2HfB9g4OA
         cyRVvRs0GrC5NQL52cs4UNEKWErvhLY5WoGZqhVMYQUgOrmlYMAobBZl8uUq330z2ZH/
         ZsZkokYanK69CuttpAySF6x17tBOJbIeHccEIDk83EZLV0FPMEpvnzbgsBjZPB8VCohp
         P8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q7P3d4bottmxnpPOnOchr0kX1G9VuQbjItV2DWo+ReI=;
        b=MifzuwpFwpNtxWe/CHpPVu8tDG9P7n/qChJ2+IotmFw2rraUsbZUhjv1uUUioQ/Kkf
         xmYA0osnhlcbDNDc8dIBnrbGvgrExTm4tVzWPECEqJFTLP4cwjQw4BsKNVzxsNdYVmvb
         dCeTDbjkgQaHmYEmkS06FJr1FNHs2mIN2eXNaGU4/Hu+z69+Y7c+Bs7wPwDD3e7DZcdY
         aIoRlEzpI1BN5/8rtDBn8Q1gVZGHyMkrmunJBKS+6hXDGK5K9JCXYhmdsSkCKd0eIWJ8
         oO2G9jstathu8+ZZG1JKo/jXF8bwyMfJKUEo1QdCIpXHZ1xAxV34EMMUQxrmDYodvJRo
         xnpQ==
X-Gm-Message-State: ANhLgQ0dKV1roUHONCKmgpiOUahgckiouQXBS7wHWrUY8h3wKMQ6cheq
        IwVjNLJuGE3XIxSdkNZw8UaOWkSG
X-Google-Smtp-Source: ADFU+vsE2wBajoWcVKTltv0mpxrIblb1XoCzJLo/RJrGumdhqJmVSQEDRqFR+jGDHc1jd9A1G2bj2w==
X-Received: by 2002:a17:902:7593:: with SMTP id j19mr14744776pll.55.1584815200085;
        Sat, 21 Mar 2020 11:26:40 -0700 (PDT)
Received: from ?IPv6:2409:4072:488:8b8b:892d:8d8:1a6c:acda? ([2409:4072:488:8b8b:892d:8d8:1a6c:acda])
        by smtp.gmail.com with ESMTPSA id w9sm9187583pfd.94.2020.03.21.11.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 11:26:39 -0700 (PDT)
Subject: Re: [PATCH] drivers: iio: Drop unnecessary explicit casting
To:     Joe Perches <joe@perches.com>, jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200318100754.25667-1-nish.malpani25@gmail.com>
 <a7778635620163cb6185192819a56ed44d76d4b0.camel@perches.com>
From:   Nishant Malpani <nish.malpani25@gmail.com>
Message-ID: <9aa90ffd-9574-d615-0bc0-f791e51b3be4@gmail.com>
Date:   Sat, 21 Mar 2020 23:56:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a7778635620163cb6185192819a56ed44d76d4b0.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 21/03/20 5:56 pm, Joe Perches wrote:
> On Wed, 2020-03-18 at 15:37 +0530, Nishant Malpani wrote:
>> Provide correct specifiers while printing error logs to discard the use
>> of unnecessary explicit casting.
> []
>> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
> []
>> @@ -21,8 +21,8 @@ static int kxsd9_i2c_probe(struct i2c_client *i2c,
>>   
>>   	regmap = devm_regmap_init_i2c(i2c, &config);
>>   	if (IS_ERR(regmap)) {
>> -		dev_err(&i2c->dev, "Failed to register i2c regmap %d\n",
>> -			(int)PTR_ERR(regmap));
>> +		dev_err(&i2c->dev, "Failed to register i2c regmap %ld\n",
>> +			PTR_ERR(regmap));
> 
> Another option would be to use %pe to print the error identifier
> and not the error number
> 
By 'error identifier' you mean the symbolic error name (as described in 
docs [1]), right? Yes, to me, it makes sense too, as it would be more 
"readable" during debugging. Jonathan, if you agree, do I send a 
patchset replacing with %pe specifier for all the drivers in consideration?

With regards,
Nishant Malpani

[1] 
https://www.kernel.org/doc/html/latest/core-api/printk-formats.html#error-pointers

> etc...
> 
> 
