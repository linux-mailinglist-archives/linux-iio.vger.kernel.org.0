Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A1533A504
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 14:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhCNNcd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 09:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhCNNcF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Mar 2021 09:32:05 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51A6C061574;
        Sun, 14 Mar 2021 06:32:04 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w34so17812731pga.8;
        Sun, 14 Mar 2021 06:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0kaE6kR4sHjhM9c/eCT2OCIGFKX0WfzwQmhXTp4l0yk=;
        b=Oj4eQCSCXi+pMIuc/L/u8CyDXsSj0mAKWIg5c2FKYS6nYF8nWaVkVgZzefPS4I1+8a
         m1/uftwnBHRt7tUGk8ZqRjASEED42c5+jr7ai/DvYh/GWOnosPSEcbjb0C5QPcv6ZdP1
         GA93kGkm0992aaPNlcXaOx9TxKqa2fBakUudZBYJnlg32mogL4u+MVbT91eBYd/gMdyr
         o8H6gGArW2ntHxV+vmujmfx2kscTvbLt6q21KpMHk5gtNIATp2vX0wwh0ef32etcnIZb
         A3ZlyviU77EqD/Csm4Yo6i9GAANX+2y35OCp7pooJA/gILzZ2aiRliXL+cbEKC+OUkTI
         6b2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0kaE6kR4sHjhM9c/eCT2OCIGFKX0WfzwQmhXTp4l0yk=;
        b=KpZH9aF0uZ8cjI9WpXX6l+liuL1ug5DV2FAacY5ZeWs85RoaNvS2IXbEjs01Vodo7z
         daR5bxSEQdE0LZWh+ya53D2JMgU/vEFUMIqZNewIgZw1bGc8Z4WdQkQaciRJp6tn9ODH
         H1f9OmjGvLCvUVaE42lx4V6a/g5knrrhLvq650X8LpXa+oeVblWnwaLtQiC2v6MQn/4w
         xN40Bs9sQTeNDZlERgewGsKmjIeFWuuPNfnCJMBA8QjsXDGItbUNEbv8L/aNnazL7pY3
         esKno1ysr/1aQ6QGT9eb7P5cCzXksjxDNGDbU5gYVf3XlMHKjKDq2b81DV8az5bXkpPh
         zKuA==
X-Gm-Message-State: AOAM533RocoVbYNio18gggGDE3brDnkHyYN/VCJU9uvFQYsbq3sBv0Kd
        R+pi0idWuIOjEc2eUzlnW53OZfjG7IcO8dVT
X-Google-Smtp-Source: ABdhPJxAk4LPUCxSr9evQo1pqAxgDmqUqp7JlzR67F0hseQOmldo6562Vct7ntSR8GLjkt0VOSDiIg==
X-Received: by 2002:a63:792:: with SMTP id 140mr19484997pgh.200.1615728722496;
        Sun, 14 Mar 2021 06:32:02 -0700 (PDT)
Received: from ?IPv6:2409:4072:61a:47fe:8a78:6024:43:5d7c? ([2409:4072:61a:47fe:8a78:6024:43:5d7c])
        by smtp.gmail.com with ESMTPSA id g18sm10765056pfb.178.2021.03.14.06.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Mar 2021 06:32:01 -0700 (PDT)
Subject: Re: [PATCH] iio:dac:max517: Use devm_iio_device_register()
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210314093356.10609-1-dmugil2000@gmail.com>
 <CA+U=DspBephozOheNQYBX9jG6bdwm4FeOTF_9tEggOWNvTQ32Q@mail.gmail.com>
From:   Mugilraj D <dmugil2000@gmail.com>
Message-ID: <12cabd69-fcb4-2e01-3a48-c4327e839d3a@gmail.com>
Date:   Sun, 14 Mar 2021 19:01:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+U=DspBephozOheNQYBX9jG6bdwm4FeOTF_9tEggOWNvTQ32Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 14/03/21 4:37 pm, Alexandru Ardelean wrote:
> On Sun, Mar 14, 2021 at 11:34 AM Mugilraj Dhavachelvan
> <dmugil2000@gmail.com> wrote:
>>
>> Use devm_iio_device_register() to avoid remove function and
>> drop explicit call to iio_device_unregister().
>>
>> Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
>> ---
>>  drivers/iio/dac/max517.c | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
>> index 7e01838ef4d0..5f72f126162d 100644
>> --- a/drivers/iio/dac/max517.c
>> +++ b/drivers/iio/dac/max517.c
>> @@ -189,13 +189,7 @@ static int max517_probe(struct i2c_client *client,
>>                         data->vref_mv[chan] = platform_data->vref_mv[chan];
>>         }
>>
>> -       return iio_device_register(indio_dev);
>> -}
>> -
> 
> In this case you can also remove the line with
>      i2c_set_clientdata(client, indio_dev);
> 
> A lot of times, when functions like i2c_get_clientdata() get removed,
> the i2c_set_clientdata() function becomes useless.
> i.e. it stores some data that will never be used in the lifetime of the driver.
> 
> It isn't always the case that you can do that; so, some care must be
> taken to avoid special cases.
> But in this case, you can remove the i2c_set_clientdata() call.
> 
Ack, I'll send that in a while. I should send with [V2] tag right.
> 
>> -static int max517_remove(struct i2c_client *client)
>> -{
>> -       iio_device_unregister(i2c_get_clientdata(client));
>> -       return 0;
>> +       return devm_iio_device_register(&client->dev, indio_dev);
>>  }
>>
>>  static const struct i2c_device_id max517_id[] = {
>> @@ -214,7 +208,6 @@ static struct i2c_driver max517_driver = {
>>                 .pm     = &max517_pm_ops,
>>         },
>>         .probe          = max517_probe,
>> -       .remove         = max517_remove,
>>         .id_table       = max517_id,
>>  };
>>  module_i2c_driver(max517_driver);
>> --
>> 2.25.1
>>
