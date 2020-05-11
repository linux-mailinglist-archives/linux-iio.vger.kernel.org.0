Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CF41CD6AD
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 12:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgEKKiD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 06:38:03 -0400
Received: from www381.your-server.de ([78.46.137.84]:37078 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgEKKiD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 May 2020 06:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E7nGXJbtt/k5x9QUqlVuoKuVtxO6ANKMbKDzRQDuE/U=; b=kvjPeIRqkktKS1wOItSxOcBzpN
        SAlHDVlSLbcndI9YbOafxoj9cY1bD5gpv8CEvK1CsMVzFAQm9tyM3FeuKB3rfUsyqxdYpNbuD/eYS
        NAQzJ+5qcu4CVimTpCGpUpMUeTIOAc6ue21HUKZiuj/9cqV0L3cz5+5UhiRPnpVFYASOaIw57cIrb
        uUMY/HSLuAToVTVkuZ71CbkX/Pk4qna4fUvFyDLOlWzjVrY4bJOVhdmZXQhH9LwupptMJU0bOIAzw
        ILGDQmi4Jif2mUkQL3mLRuzIeQNXHcnY2DhdikXb7MYDEgI5OnGFdBjfZW618X3wWVtCveG7UumIF
        jH9m538Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jY5or-00013Q-A7; Mon, 11 May 2020 12:37:57 +0200
Received: from [82.135.66.51] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jY5or-000Kt0-1x; Mon, 11 May 2020 12:37:57 +0200
Subject: Re: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
 <a9a47e84-b933-cca6-dcfb-d97a51c8bdd4@metafoo.de>
 <20200510110958.29046a18@archlinux>
 <8c5d9ef5ed4ea9037c5459daa2044d1cd7c5db7a.camel@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c88b17c3-a9d6-e755-04e8-bc9f225e2a3b@metafoo.de>
Date:   Mon, 11 May 2020 12:37:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8c5d9ef5ed4ea9037c5459daa2044d1cd7c5db7a.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25808/Sun May 10 14:11:51 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/11/20 12:33 PM, Ardelean, Alexandru wrote:
> On Sun, 2020-05-10 at 11:09 +0100, Jonathan Cameron wrote:
>> [External]
>>
>> On Sat, 9 May 2020 10:52:14 +0200
>> Lars-Peter Clausen <lars@metafoo.de> wrote:
>>
>>> On 5/8/20 3:53 PM, Alexandru Ardelean wrote:
>>>> [...]
>>>> What I don't like, is that iio:device3 has iio:buffer3:0 (to 3).
>>>> This is because the 'buffer->dev.parent = &indio_dev->dev'.
>>>> But I do feel this is correct.
>>>> So, now I don't know whether to leave it like that or symlink to shorter
>>>> versions like 'iio:buffer3:Y' -> 'iio:device3/bufferY'.
>>>> The reason for naming the IIO buffer devices to 'iio:bufferX:Y' is
>>>> mostly to make the names unique. It would have looked weird to do
>>>> '/dev/buffer1' if I would have named the buffer devices 'bufferX'.
>>>>
>>>> So, now I'm thinking of whether all this is acceptable.
>>>> Or what is acceptable?
>>>> Should I symlink 'iio:device3/iio:buffer3:0' -> 'iio:device3/buffer0'?
>>>> What else should I consider moving forward?
>>>> What means forward?
>>>> Where did I leave my beer?
>>> Looking at how the /dev/ devices are named I think we can provide a name
>>> that is different from the dev_name() of the device. Have a look at
>>> device_get_devnode() in drivers/base/core.c. We should be able to
>>> provide the name for the chardev through the devnode() callback.
>>>
>>> While we are at this, do we want to move the new devices into an iio
>>> subfolder? So iio/buffer0:0 instead of iio:buffer0:0?
>> Possibly on the folder.  I can't for the life of me remember why I decided
>> not to do that the first time around - I'll leave it at the
>> mysterious "it may turn out to be harder than you'd think..."
>> Hopefully not ;)
> I was also thinking about the /dev/iio subfolder while doing this.
> I can copy that from /dev/input
> They seem to do it already.
> I don't know how difficult it would be. But it looks like a good precedent.

All you have to do is return "iio/..." from the devnode() callback.

>
> My concern regarding going to use stuff from core [like device_get_devnode()] is
> that it seems to bypass some layers of kernel.
> If I do 'git grep device_get_devnode', I get:
>
> drivers/base/core.c:            name = device_get_devnode(dev, &mode, &uid,
> &gid, &tmp);
> drivers/base/core.c: * device_get_devnode - path of device node file
> drivers/base/core.c:const char *device_get_devnode(struct device *dev,
> drivers/base/devtmpfs.c:        req.name = device_get_devnode(dev, &req.mode,
> &req.uid, &req.gid, &tmp);
> drivers/base/devtmpfs.c:        req.name = device_get_devnode(dev, NULL, NULL,
> NULL, &tmp);
> include/linux/device.h:extern const char *device_get_devnode(struct device *dev,
> (END)
>
> So, basically, most uses of device_get_devnode() are in core code, and I feel
> that this may be sanctioned somewhere by some core people, if I do it.
> I could be wrong, but if you disagree, I'll take your word for it.
You are not supposed to use the function itself, you should implement 
the devnode() callback for the IIO bus, which is then used by the core 
device_get_devnode() function.

