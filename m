Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654921F55F9
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jun 2020 15:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgFJNlV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jun 2020 09:41:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36164 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFJNlU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jun 2020 09:41:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 4A6BC2A46E5
Subject: Re: [PATCH v4 0/7] Support inhibiting input devices
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        linux-input@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
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
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Collabora Kernel ML <kernel@collabora.com>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <964ca07a-3da5-101f-7edf-64bdeec98a4b@redhat.com>
 <CAJZ5v0hB2ra2K=dd9ZjVyy1V2b1PmFHm79uDO2HtHU1D_4YUbw@mail.gmail.com>
 <6136f26c-e090-e025-af55-4c5f3a6aec92@collabora.com>
 <3e61c9c1-b211-da9f-c55b-b44eb6522f2a@redhat.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <2d5fd063-66bc-c707-4041-84a17c0a7d04@collabora.com>
Date:   Wed, 10 Jun 2020 15:41:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3e61c9c1-b211-da9f-c55b-b44eb6522f2a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Hans,

W dniu 10.06.2020 o 15:21, Hans de Goede pisze:
> Hi,
> 
> On 6/10/20 3:12 PM, Andrzej Pietrasiewicz wrote:
>> Hi All,
>>
>> W dniu 10.06.2020 o 12:38, Rafael J. Wysocki pisze:
>>> On Wed, Jun 10, 2020 at 11:50 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi All,
>>>>
>>>> On 6/8/20 1:22 PM, Andrzej Pietrasiewicz wrote:
>>>>> This is a quick respin of v3, with just two small changes, please see
>>>>> the changelog below.
>>>>>
>>>>> Userspace might want to implement a policy to temporarily disregard input
>>>>> from certain devices.
>>>>>
>>>>> An example use case is a convertible laptop, whose keyboard can be folded
>>>>> under the screen to create tablet-like experience. The user then must hold
>>>>> the laptop in such a way that it is difficult to avoid pressing the keyboard
>>>>> keys. It is therefore desirable to temporarily disregard input from the
>>>>> keyboard, until it is folded back. This obviously is a policy which should
>>>>> be kept out of the kernel, but the kernel must provide suitable means to
>>>>> implement such a policy.
>>>>
>>>> First of all sorry to start a somewhat new discussion about this
>>>> while this patch set is also somewhat far along in the review process,
>>>> but I believe what I discuss below needs to be taken into account.
>>>>
>>>> Yesterday I have been looking into why an Asus T101HA would not stay
>>>> suspended when the LID is closed. The cause is that the USB HID multi-touch
>>>> touchpad in the base of the device starts sending events when the screen
>>>> gets close to the touchpad (so when the LID is fully closed) and these
>>>> events are causing a wakeup from suspend. HID multi-touch devices
>>>> do have a way to tell them to fully stop sending events, also disabling
>>>> the USB remote wakeup the device is doing. The question is when to tell
>>>> it to not send events though ...
>>>>
>>>> So now I've been thinking about how to fix this and I believe that there
>>>> is some interaction between this problem and this patch-set.
>>>>
>>>> The problem I'm seeing on the T101HA is about wakeups, so the question
>>>> which I want to discuss is:
>>>>
>>>> 1. How does inhibiting interact with enabling /
>>>> disabling the device as a wakeup source ?
>>>>
>>>> 2. Since we have now made inhibiting equal open/close how does open/close
>>>> interact with a device being a wakeup source ?
>>>>
>>>> And my own initial (to be discussed) answers to these questions:
>>>>
>>>> 1. It seems to me that when a device is inhibited it should not be a
>>>> wakeup source, so where possible a input-device-driver should disable
>>>> a device's wakeup capabilities on suspend if inhibited
>>>
>>> If "inhibit" means "do not generate any events going forward", then
>>> this must also cover wakeup events, so I agree.
>>
>> I agree, too.
>>
>>>
>>>> 2. This one is trickier I don't think we have really clearly specified
>>>> any behavior here. The default behavior of most drivers seems to be
>>>> using something like this in their suspend callback:
>>>>
>>>>           if (device_may_wakeup(dev))
>>>>                   enable_irq_wake(data->irq);
>>>>           else if (input->users)
>>>>                   foo_stop_receiving_events(data);
>>>>
>>>> Since this is what most drivers seem to do I believe we should keep
>>>> this as is and that we should just clearly document that if the
>>>> input_device has users (has been opened) or not does not matter
>>>> for its wakeup behavior.
>>>>
>>>> Combining these 2 answers leads to this new pseudo code template
>>>> for an input-device's suspend method:
>>>>
>>>>          /*
>>>>           * If inhibited we have already disabled events and
>>>>           * we do NOT want to setup the device as wake source.
>>>>           */
>>>>          if (input->inhibited)
>>>>                  return 0;
>>
>> Right, if a device is inhibited it shouldn't become a wakeup source,
>> because that would contradict the purpose of being inhibited.
> 
> Ack. Note I do think that we need to document this (and more
> in general the answer to both questions from above) clearly so
> that going forward if there are any questions about how this is
> supposed to work we can just point to the docs.
> 
> Can you do a follow-up patch, or include a patch in your next
> version which documents this (once we agree on what "this"
> exactly is) ?

Sure I can. Just need to know when "this" becomes stable enough ;)
If this series otherwise looks mature enough I would opt for a
follow-up patch.

> 
>>>>
>>>>           if (device_may_wakeup(dev))
>>>>                   enable_irq_wake(data->irq);
>>
>> What would it mean to become a wakeup source if there are no users,
>> or nobody has ever opened the device? There are no interested
>> input handlers (users) so what's the point of becoming a wakeup
>> source? Why would the system need to wake up?
> 
> Well this is what we have been doing so far, so arguably we
> need to keep doing it to avoid regressions / breaking our ABI.
> 
> Lets for example take a laptop, where when suspended the
> power-button is the only valid wakeup-source and this is
> running good old slackware with fvwm2 or windowmaker as
> "desktop environment", then likely no process will have
> the power-button input evdev node open.  Still we should
> wakeup the laptop on the power-button press, otherwise
> it will never wakeup.
> 

True, thanks for explaining.

> Note I agree with you that the way this works is not
> ideal, I just do not think that we can change it.
> 

Regards,

Andrzej
