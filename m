Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698BA1D936B
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 11:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgESJgm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 05:36:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57005 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726494AbgESJgm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 05:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589880999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zx1xwU2hx8pVoq/x6eR5o+QLPp4w7KqD0sx7jmQ5IaM=;
        b=UA+9/ui00kvgZrOKF8coaVFZFutm5nUR/Ihwc7yH7BeI7l5ljsiFmU+p2fkQ5b2AGOunT4
        Uw3o6y29yw3jw4aHHZjHtzSTygserRWfg4kV8S25tbUP29HgMXlVbuS+kPUj9eNkAmGDfn
        pay4oJpYoAqxv/rc/q9h7tDrdz4DXgA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-HfkRnMY3NiqzDx4zhfsinQ-1; Tue, 19 May 2020 05:36:38 -0400
X-MC-Unique: HfkRnMY3NiqzDx4zhfsinQ-1
Received: by mail-wm1-f69.google.com with SMTP id f62so1179981wme.3
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2020 02:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zx1xwU2hx8pVoq/x6eR5o+QLPp4w7KqD0sx7jmQ5IaM=;
        b=s7giafdhQDjWPMh3pTP5rPIuEZ1IqkcyrmdXxb+HVXsx6tQrK76HY0wjO+NkSdoSTg
         d6bB47AsfG8Hn2rsX7aKyX+GZ3JHYCQPmwUcwA01JM2p90nPMVBqLSN1CVWSlX7HqHSA
         v1Ftw5XnOkn2rl0HL3g4TEJUShEnSbHMEH24WIdMEdGa8OdBOJ2WPOyX5sHHgtMmdYJt
         8FaMEzVcBF5/87GjG3EGlZdqfF/o/W3GzyuuPAE5a2mQLxvMvRkbOEI4M9FYM87POt+9
         2JRaxge3OgN1ylc94ij2PU9uRbxjbXVy0LoZ4JK/K/KGSDnE52VkfOARiEHvUopaJ39t
         DCeQ==
X-Gm-Message-State: AOAM531djfkf4rC+fFIR7F894VggUGkGc42EMKFt+HOQGokXXkWRXhVj
        wENffnUDwAC/oFcLtcGdTnEYJyVVry/KUtLQ11KAPLdoB+b2BSl8jBqMutYkQlwherllzg2DKIY
        tQfRwMZ0fu1QKzihKJNdh
X-Received: by 2002:a1c:444:: with SMTP id 65mr4608060wme.21.1589880996787;
        Tue, 19 May 2020 02:36:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqcjizbgXFRvjt4WsCNNW18OC7P3zc0FNfH6PxsI9rxtfI7F0v+PkL9hUz5wI4ZZq7PkCtaQ==
X-Received: by 2002:a1c:444:: with SMTP id 65mr4608023wme.21.1589880996492;
        Tue, 19 May 2020 02:36:36 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id i6sm3566852wmb.41.2020.05.19.02.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 02:36:35 -0700 (PDT)
Subject: Re: [PATCHv2 0/7] Support inhibiting input devices
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-input@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com, Peter Hutterer <peter.hutterer@redhat.com>,
        Benjamin Tissoires <btissoir@redhat.com>
References: <20200506002746.GB89269@dtor-ws>
 <20200515164943.28480-1-andrzej.p@collabora.com>
 <842b95bb-8391-5806-fe65-be64b02de122@redhat.com>
 <e6030957-97dc-5b04-7855-bc14a78164c8@collabora.com>
 <6d9921fc-5c2f-beda-4dcd-66d6970a22fe@redhat.com>
 <09679de4-75d3-1f29-ec5f-8d42c84273dd@collabora.com>
 <f674ba4f-bd83-0877-c730-5dc6ea09ae4b@redhat.com>
 <2d224833-3a7e-bc7c-af15-1f803f466697@collabora.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <aa2ce2ab-e5bc-9cb4-8b53-c1ef9348b646@redhat.com>
Date:   Tue, 19 May 2020 11:36:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2d224833-3a7e-bc7c-af15-1f803f466697@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/19/20 11:02 AM, Andrzej Pietrasiewicz wrote:
> Hi Hans, Hi Dmitry,
> 
> W dniu 18.05.2020 o 16:23, Hans de Goede pisze:
>> Hi,
> 
> <snip>
> 
>>>>>>
>>>>>> So I wonder what this series actually adds for functionality for
>>>>>> userspace which can not already be achieved this way?
>>>>>>
>>>>>> I also noticed that you keep the device open (do not call the
>>>>>> input_device's close callback) when inhibited and just throw away
>>>>>
>>>>> I'm not sure if I understand you correctly, it is called:
>>>>>
>>>>> +static inline void input_stop(struct input_dev *dev)
>>>>> +{
>>>>> +    if (dev->poller)
>>>>> +        input_dev_poller_stop(dev->poller);
>>>>> +    if (dev->close)
>>>>> +        dev->close(dev);
>>>>>                  ^^^^^^^^^^^^^^^^
>>>>> +static int input_inhibit(struct input_dev *dev)
>>>>> +{
>>>>> +    int ret = 0;
>>>>> +
>>>>> +    mutex_lock(&dev->mutex);
>>>>> +
>>>>> +    if (dev->inhibited)
>>>>> +        goto out;
>>>>> +
>>>>> +    if (dev->users) {
>>>>> +        if (dev->inhibit) {
>>>>> +            ret = dev->inhibit(dev);
>>>>> +            if (ret)
>>>>> +                goto out;
>>>>> +        }
>>>>> +        input_stop(dev);
>>>>>                  ^^^^^^^^^^^^^^^^
>>>>>
>>>>> It will not be called when dev->users is zero, but if it is zero,
>>>>> then nobody has opened the device yet so there is nothing to close.
>>>>
>>>> Ah, I missed that.
>>>>
>>>> So if the device implements the inhibit call back then on
>>>> inhibit it will get both the inhibit and close callback called?
>>>>
>>>
>>> That's right. And conversely, upon uninhibit open() and uninhibit()
>>> callbacks will be invoked. Please note that just as with open()/close(),
>>> providing inhibit()/uninhibit() is optional.
>>
>> Ack.
>>
>>>> And what happens if the last user goes away and the device
>>>> is not inhibited?
>>>
>>> close() is called as usually.
>>
>> But not inhibit, hmm, see below.
>>
>>>> I'm trying to understand here what the difference between the 2
>>>> is / what the goal of having a separate inhibit callback ?
>>>>
>>>
>>> Drivers have very different ideas about what it means to suspend/resume
>>> and open/close. The optional inhibit/uninhibit callbacks are meant for
>>> the drivers to know that it is this particular action going on.
>>
>> So the inhibit() callback triggers the "suspend" behavior ?
>> But shouldn't drivers which are capable of suspending the device
>> always do so on close() ?
>>
>> Since your current proposal also calls close() on inhibit() I
>> really see little difference between an inhibit() and the last
>> user of the device closing it and IMHO unless there is a good
>> reason to actually differentiate the 2 it would be better
>> to only stick with the existing close() and in cases where
>> that does not put the device in a low-power mode yet, fix
>> the existing close() callback to do the low-power mode
>> setting instead of adding a new callback.
>>
>>> For inhibit() there's one more argument: close() does not return a value,
>>> so its meaning is "do some last cleanup" and as such it is not allowed
>>> to fail - whatever its effect is, we must deem it successful. inhibit()
>>> does return a value and so it is allowed to fail.
>>
>> Well, we could make close() return an error and at least in the inhibit()
>> case propagate that to userspace. I wonder if userspace is going to
>> do anything useful with that error though...
>>
>> In my experience errors during cleanup/shutdown are best logged
>> (using dev_err) and otherwise ignored, so that we try to clean up
>> as much possible. Unless the very first step of the shutdown process
>> fails the device is going to be in some twilight zone state anyways
>> at this point we might as well try to cleanup as much as possible.
> 
> What you say makes sense to me.
> @Dmitry?
> 
>>
>>> All in all, it is up to the drivers to decide which callback they
>>> provide. Based on my work so far I would say that there are tens
>>> of simple cases where open() and close() are sufficient, out of total
>>> ~400 users of input_allocate_device():
>>>
>>> $ git grep "input_allocate_device(" | grep -v ^Documentation | \
>>> cut -f1 -d: | sort | uniq | wc
>>>      390     390   13496
>>
>> So can you explain a bit more about the cases where only having
>> open/close is not sufficient?  So far I have the feeling that
>> those are all we need and that we really do not need separate
>> [un]inhibit callbacks.
> 
> My primary concern was not being able to propagate inhibit() error
> to userspace, and then if we have inhibit(), uninhibit() should be
> there for completeness. If propagating the error to userspace can
> be neglected then yes, it seems open/close should be sufficient,
> even more because the real meaning of "open" is "prepare the device
> for generating input events".
> 
> To validate the idea of not introducing inhibit()/uninhibit() callbacks
> to implement device inhibiting/uninhibiting let's look at
> drivers/input/mouse/elan_i2c_core.c (PATCH 7/7):
> 
> static int elan_inhibit(struct input_dev *input)
> {
> [...]
> 
>      ret = mutex_lock_interruptible(&data->sysfs_mutex);
>      if (ret)
>          return ret;
> 
>      disable_irq(client->irq);
> 
>      ret = elan_disable_power(data);
>      if (ret)
>          enable_irq(client->irq);
> [...]
> }
> 
> First, close() does not exist in this driver. Of course this can be
> fixed. Then it doesn't return a value. Then, if either taking the
> mutex or disabling the power fails, the close() is still deemed
> successful. Is it ok?

Note I also mentioned another solution for the error propagation,
which would require a big "flag day" commit adding "return 0"
to all existing close callbacks, but otherwise should work for your
purposes:

 > Well, we could make close() return an error and at least in the inhibit()
 > case propagate that to userspace. I wonder if userspace is going to
 > do anything useful with that error though...

And I guess we could log an error that close failed in the old close() path
where we cannot propagate the error.

Also why the mutex_lock_interruptible() ?  If you change that to
a normal mutex_lock() you loose one of the possible 2 error cases and
I doubt anyone is going to do a CTRL-C of the process doing the
inhibiting (or that that process starts a timer using a signal
to ensure the inhibit does not take to long or some such).

Regards,

Hans

