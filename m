Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167B31D92E0
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 11:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgESJDK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 05:03:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49894 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESJDI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 05:03:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 7A8D02A1ED2
Subject: Re: [PATCHv2 0/7] Support inhibiting input devices
To:     Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <2d224833-3a7e-bc7c-af15-1f803f466697@collabora.com>
Date:   Tue, 19 May 2020 11:02:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f674ba4f-bd83-0877-c730-5dc6ea09ae4b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Hans, Hi Dmitry,

W dniu 18.05.2020 o 16:23, Hans de Goede pisze:
> Hi,

<snip>

>>>>>
>>>>> So I wonder what this series actually adds for functionality for
>>>>> userspace which can not already be achieved this way?
>>>>>
>>>>> I also noticed that you keep the device open (do not call the
>>>>> input_device's close callback) when inhibited and just throw away
>>>>
>>>> I'm not sure if I understand you correctly, it is called:
>>>>
>>>> +static inline void input_stop(struct input_dev *dev)
>>>> +{
>>>> +    if (dev->poller)
>>>> +        input_dev_poller_stop(dev->poller);
>>>> +    if (dev->close)
>>>> +        dev->close(dev);
>>>>                  ^^^^^^^^^^^^^^^^
>>>> +static int input_inhibit(struct input_dev *dev)
>>>> +{
>>>> +    int ret = 0;
>>>> +
>>>> +    mutex_lock(&dev->mutex);
>>>> +
>>>> +    if (dev->inhibited)
>>>> +        goto out;
>>>> +
>>>> +    if (dev->users) {
>>>> +        if (dev->inhibit) {
>>>> +            ret = dev->inhibit(dev);
>>>> +            if (ret)
>>>> +                goto out;
>>>> +        }
>>>> +        input_stop(dev);
>>>>                  ^^^^^^^^^^^^^^^^
>>>>
>>>> It will not be called when dev->users is zero, but if it is zero,
>>>> then nobody has opened the device yet so there is nothing to close.
>>>
>>> Ah, I missed that.
>>>
>>> So if the device implements the inhibit call back then on
>>> inhibit it will get both the inhibit and close callback called?
>>>
>>
>> That's right. And conversely, upon uninhibit open() and uninhibit()
>> callbacks will be invoked. Please note that just as with open()/close(),
>> providing inhibit()/uninhibit() is optional.
> 
> Ack.
> 
>>> And what happens if the last user goes away and the device
>>> is not inhibited?
>>
>> close() is called as usually.
> 
> But not inhibit, hmm, see below.
> 
>>> I'm trying to understand here what the difference between the 2
>>> is / what the goal of having a separate inhibit callback ?
>>>
>>
>> Drivers have very different ideas about what it means to suspend/resume
>> and open/close. The optional inhibit/uninhibit callbacks are meant for
>> the drivers to know that it is this particular action going on.
> 
> So the inhibit() callback triggers the "suspend" behavior ?
> But shouldn't drivers which are capable of suspending the device
> always do so on close() ?
> 
> Since your current proposal also calls close() on inhibit() I
> really see little difference between an inhibit() and the last
> user of the device closing it and IMHO unless there is a good
> reason to actually differentiate the 2 it would be better
> to only stick with the existing close() and in cases where
> that does not put the device in a low-power mode yet, fix
> the existing close() callback to do the low-power mode
> setting instead of adding a new callback.
> 
>> For inhibit() there's one more argument: close() does not return a value,
>> so its meaning is "do some last cleanup" and as such it is not allowed
>> to fail - whatever its effect is, we must deem it successful. inhibit()
>> does return a value and so it is allowed to fail.
> 
> Well, we could make close() return an error and at least in the inhibit()
> case propagate that to userspace. I wonder if userspace is going to
> do anything useful with that error though...
> 
> In my experience errors during cleanup/shutdown are best logged
> (using dev_err) and otherwise ignored, so that we try to clean up
> as much possible. Unless the very first step of the shutdown process
> fails the device is going to be in some twilight zone state anyways
> at this point we might as well try to cleanup as much as possible.

What you say makes sense to me.
@Dmitry?

> 
>> All in all, it is up to the drivers to decide which callback they
>> provide. Based on my work so far I would say that there are tens
>> of simple cases where open() and close() are sufficient, out of total
>> ~400 users of input_allocate_device():
>>
>> $ git grep "input_allocate_device(" | grep -v ^Documentation | \
>> cut -f1 -d: | sort | uniq | wc
>>      390     390   13496
> 
> So can you explain a bit more about the cases where only having
> open/close is not sufficient?  So far I have the feeling that
> those are all we need and that we really do not need separate
> [un]inhibit callbacks.

My primary concern was not being able to propagate inhibit() error
to userspace, and then if we have inhibit(), uninhibit() should be
there for completeness. If propagating the error to userspace can
be neglected then yes, it seems open/close should be sufficient,
even more because the real meaning of "open" is "prepare the device
for generating input events".

To validate the idea of not introducing inhibit()/uninhibit() callbacks
to implement device inhibiting/uninhibiting let's look at
drivers/input/mouse/elan_i2c_core.c (PATCH 7/7):

static int elan_inhibit(struct input_dev *input)
{
[...]

	ret = mutex_lock_interruptible(&data->sysfs_mutex);
	if (ret)
		return ret;

	disable_irq(client->irq);

	ret = elan_disable_power(data);
	if (ret)
		enable_irq(client->irq);
[...]
}

First, close() does not exist in this driver. Of course this can be
fixed. Then it doesn't return a value. Then, if either taking the
mutex or disabling the power fails, the close() is still deemed
successful. Is it ok?
@Dmitry?

Regards,

Andrzej
