Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8FC1CDC4C
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 15:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgEKN6I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 09:58:08 -0400
Received: from www381.your-server.de ([78.46.137.84]:53476 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbgEKN6H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 May 2020 09:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=No2f5Smp3GbnzqLRvMbPPPhjw0H+cM11eeZ98PnOg+U=; b=IupyqNtDxFLIEcY8GLnncia2JZ
        EkXsyjfLq8i7LXy2tEBBndaIzHL1XUIlIItywQK3Io4qOglCb3uxBCambCh+zw3Bk0OcWxzstNvyE
        gHwmFluyMmjdJnQMVv4UTiFXf3gH/5mA3IXsOTDj9eBmCF/Sb2ULPnPOIe35weHJGIDV+L96kLpQd
        LqFaJ6nZwlTQVteZkvHo4NPfUJeYSZGLMIF9azWj8yGpLgPKAGaBOZ2Dm6lHwAM4HbeydBtWStxnL
        5QnYzb+S9qCAYQ6bKH2sWE40qhV9SxJjsZ/tlXF6LrtQhJQYpzyQsnOfWkNXoVuKoCTtLgYzhMPzs
        WVCDevmA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jY8wU-0008Qr-Hq; Mon, 11 May 2020 15:58:02 +0200
Received: from [82.135.66.51] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jY8wU-000RCZ-9o; Mon, 11 May 2020 15:58:02 +0200
Subject: Re: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
 <a9a47e84-b933-cca6-dcfb-d97a51c8bdd4@metafoo.de>
 <20200510110958.29046a18@archlinux>
 <8c5d9ef5ed4ea9037c5459daa2044d1cd7c5db7a.camel@analog.com>
 <c88b17c3-a9d6-e755-04e8-bc9f225e2a3b@metafoo.de>
 <554fe46f0cdd1cafb313f534c0edd93f5686b806.camel@analog.com>
 <7d2c8174e345bf8e241d48de65066d2606143503.camel@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <9ae7e69b-f4ce-dd2b-d70b-2aac66b19814@metafoo.de>
Date:   Mon, 11 May 2020 15:58:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7d2c8174e345bf8e241d48de65066d2606143503.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25809/Mon May 11 14:16:55 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/11/20 3:24 PM, Ardelean, Alexandru wrote:
> On Mon, 2020-05-11 at 13:03 +0000, Ardelean, Alexandru wrote:
>> [External]
>>
>> On Mon, 2020-05-11 at 12:37 +0200, Lars-Peter Clausen wrote:
>>> [External]
>>>
>>> On 5/11/20 12:33 PM, Ardelean, Alexandru wrote:
>>>> On Sun, 2020-05-10 at 11:09 +0100, Jonathan Cameron wrote:
>>>>> [External]
>>>>>
>>>>> On Sat, 9 May 2020 10:52:14 +0200
>>>>> Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>>>
>>>>>> On 5/8/20 3:53 PM, Alexandru Ardelean wrote:
>>>>>>> [...]
>>>>>>> What I don't like, is that iio:device3 has iio:buffer3:0 (to 3).
>>>>>>> This is because the 'buffer->dev.parent = &indio_dev->dev'.
>>>>>>> But I do feel this is correct.
>>>>>>> So, now I don't know whether to leave it like that or symlink to
>>>>>>> shorter
>>>>>>> versions like 'iio:buffer3:Y' -> 'iio:device3/bufferY'.
>>>>>>> The reason for naming the IIO buffer devices to 'iio:bufferX:Y' is
>>>>>>> mostly to make the names unique. It would have looked weird to do
>>>>>>> '/dev/buffer1' if I would have named the buffer devices 'bufferX'.
>>>>>>>
>>>>>>> So, now I'm thinking of whether all this is acceptable.
>>>>>>> Or what is acceptable?
>>>>>>> Should I symlink 'iio:device3/iio:buffer3:0' ->
>>>>>>> 'iio:device3/buffer0'?
>>>>>>> What else should I consider moving forward?
>>>>>>> What means forward?
>>>>>>> Where did I leave my beer?
>>>>>> Looking at how the /dev/ devices are named I think we can provide a
>>>>>> name
>>>>>> that is different from the dev_name() of the device. Have a look at
>>>>>> device_get_devnode() in drivers/base/core.c. We should be able to
>>>>>> provide the name for the chardev through the devnode() callback.
>>>>>>
>>>>>> While we are at this, do we want to move the new devices into an iio
>>>>>> subfolder? So iio/buffer0:0 instead of iio:buffer0:0?
>>>>> Possibly on the folder.  I can't for the life of me remember why I
>>>>> decided
>>>>> not to do that the first time around - I'll leave it at the
>>>>> mysterious "it may turn out to be harder than you'd think..."
>>>>> Hopefully not ;)
>>>> I was also thinking about the /dev/iio subfolder while doing this.
>>>> I can copy that from /dev/input
>>>> They seem to do it already.
>>>> I don't know how difficult it would be. But it looks like a good
>>>> precedent.
>>> All you have to do is return "iio/..." from the devnode() callback.
>> I admit I did not look closely into drivers/input/input.c before mentioning
>> this
>> as as good precedent.
>>
>> But, I looks like /dev/inpput is a class.
>> While IIO devices are a bus_type devices.
>> Should we start implementing an IIO class? or?
> What I should have highlighted [before] with this, is that there is no devnode()
> callback for the bus_type [type].
But there is one in device_type :)
