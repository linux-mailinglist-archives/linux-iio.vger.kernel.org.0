Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5748834B6F5
	for <lists+linux-iio@lfdr.de>; Sat, 27 Mar 2021 13:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhC0MAd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Mar 2021 08:00:33 -0400
Received: from www381.your-server.de ([78.46.137.84]:56354 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhC0MAc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Mar 2021 08:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=s1goAPAplOPdUwSEaDXuQq8i9y7Vcci3VV9X+Qrmtdg=; b=G/2Aw1tF1pTgqVIqkTwaLQd5ZA
        0zf2Busvs+2WJxM072QsXE6fEGWH6KtegT/tmN2VCyh8YniRCAvWdE3lo93ZaYbLmyqN7bKUKusOD
        Q8k6c+OxsZ6VWtnB+K0VaDEppJJMvbLeM4tNSc+FH7I/9co5AgRXYwBcFYbK7P5b55QRrJdrgD+hS
        z42fLQeoVVNxAyl04Q/YoFFDEHb04uWYpD+5gGmlLarwOZaa7KDj4KIK3cIWJeVeStYwhNKm2vtGz
        YB/8ynS8uffXixxq0v9bX8Xu/EQyGVc36j1l0f7LG0L1TGolsVhH7xnFGLni/A06+/9j/A3+QD9Sf
        DI3Wx8aQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lQ7c3-000Bfi-LC; Sat, 27 Mar 2021 13:00:20 +0100
Received: from [2001:a61:2aba:2d01:224:d7ff:fe9f:8154]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lQ7c3-0009ot-Es; Sat, 27 Mar 2021 13:00:19 +0100
Subject: Re: [PATCH v6 20/24] iio: buffer: add ioctl() to support opening
 extra buffers for IIO device
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "zzzzArdelean, zzzzAlexandru" <alexandru.Ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-21-alexandru.ardelean@analog.com>
 <877ca331-1a56-1bd3-6637-482bbf060ba9@metafoo.de>
 <20210228143429.00001f01@Huawei.com>
 <5f9070a5-2c3d-f185-1981-10ec768dbb4a@metafoo.de>
 <20210228172753.0000568c@Huawei.com>
 <CA+U=Dsqs_B3=6FSS0dmGsRUKwD826Qy250OXzyp5mBFHt4t6MQ@mail.gmail.com>
 <CY4PR03MB2631CF5082542DBF3F109E08996C9@CY4PR03MB2631.namprd03.prod.outlook.com>
 <20210320174100.6808ad36@jic23-huawei> <20210321173713.2691e0bb@jic23-huawei>
 <CA+U=DsouJuVyUThPO_p9MNt5ziWHdU2RhuGQLWgOBML6wFPWhA@mail.gmail.com>
 <20210323113426.000037d1@Huawei.com>
 <CA+U=DspJkK=sqy=va7mds0cOfJrS3nEd3-pymjztuYYNaG8vPA@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <77db0332-4fd1-fb5f-8c22-10653139f3e7@metafoo.de>
Date:   Sat, 27 Mar 2021 13:00:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CA+U=DspJkK=sqy=va7mds0cOfJrS3nEd3-pymjztuYYNaG8vPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26121/Fri Mar 26 12:11:03 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/24/21 10:10 AM, Alexandru Ardelean wrote:
> On Tue, Mar 23, 2021 at 1:35 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
>>
[..]
>>>
>>> Continuing a bit with the original IIO buffer ioctl(), I talked to
>>> Lars a bit over IRC.
>>> And there was an idea/suggestion to maybe use a struct to pass more
>>> information to the buffer FD.
>>>
>>> So, right now the ioctl() just returns an FD.
>>> Would it be worth to extend this to a struct?
>>> What I'm worried about is that it opens the discussion to add more
>>> stuff to that struct.
>>>
>>> so now, it would be:
>>>
>>> struct iio_buffer_ioctl_data {
>>>              __u32 fd;
>>>              __u32 flags;   // flags for the new FD, which maybe we
>>> could also pass via fcntl()
>>> }
>>>
>>> anything else that we would need?
>>
>> I have a vague recollection that is is almost always worth adding
>> some padding to such ioctl data coming out of the kernel.  Gives
>> flexibility to safely add more stuff later without userspace
>> failing to allocate enough space etc.
>>
>> I'm curious though, because this feels backwards. I'd expect the
>> flags to be more useful passed into the ioctl? i.e. request
>> a non blocking FD?  Might want to mirror that back again of course.
> 

The struct can be used for both. Passing flags and buffer number in and fd out.

> Personally, I don't know.
> I don't have any experiences on this.
> 
> So, then I'll do a change to this ioctl() to use a struct.
> We can probably add some reserved space?
> 
> struct iio_buffer_ioctl_data {
>              __u32 fd;
>              __u32 flags;
>              __u32 reserved1;
>              __u32 reserved2;
> }

What to make sure of when using reserved fields is to check that they are 0. 
And reject the ioctl if they are not. This is the only way to ensure that old 
applications will continue to work if the struct is updated.

> 
> Lars was giving me some articles about ioctls.
> One idea was to maybe consider making them multiples of 64 bits.
> 
> But reading through one of the docs here:
>       https://www.kernel.org/doc/html/latest/driver-api/ioctl.html#interface-versions
> it discourages to do interface versions.
> 
> But I guess if we plan ahead with some reserved space, it might be
> somewhat fine.
> 
> I'm still a little green on this stuff.
> 
>>
