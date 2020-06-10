Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0666F1F559F
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jun 2020 15:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgFJNVp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jun 2020 09:21:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30357 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729231AbgFJNVm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jun 2020 09:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591795299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlplkVPrHKzwqp9XQ8hCr9mQJfW4CL7+sK6OIcyqTu0=;
        b=OK9UHL2ffAS72Nbj0b8qBJBNeTQ1LcPiXVmkpfMDmuVZdJoyer7s0wQP+NYs+pONmg8jZo
        NUGzCQRWVYJRc9EkbBDJAuYBsUOh3L+Lq2FkQi6ieV9QrZ/of0Gg3BNGcndQhKX0oEvEzp
        9pBMksGm5Oe8MGq1j/RS0rnNoYmv5Jo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-GSfAgsOWOeaXJVqGJyWyRQ-1; Wed, 10 Jun 2020 09:21:38 -0400
X-MC-Unique: GSfAgsOWOeaXJVqGJyWyRQ-1
Received: by mail-ej1-f69.google.com with SMTP id i17so1100710ejb.9
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2020 06:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DlplkVPrHKzwqp9XQ8hCr9mQJfW4CL7+sK6OIcyqTu0=;
        b=DNtJXPw9pzUcqc1/gsVQD6dWMH5m0EdjQYzdrr97WLE9zZJpUPwyK/3t5Az8Z05mT8
         QP13TaJ2PMMqXik41zZdSGKE0nOw3m7Nr+N1aCVl3w82/949TrCcj0p9Win0xQkDvwFi
         EgAXbHBoSb+CQOU08aiHVb2MfiifD1p87VrvBd+l3PTpS/KJW060jT+ijZ2znOYxwWR9
         7l1K4qVXJCjWnCsfITFO2RomqXroVzRHkHGmJ6HkOmhm/F1Se+tpLMBjlzVekOoh5llS
         SXdWnx/6lJxgh77Pv3Q7Wuk3qNSZLQQ8IjiEbpW6s1P5cDtMI2NHZooPlnbsGv9a4GPL
         8GCw==
X-Gm-Message-State: AOAM533gemK8AqFos/1JPO0E0OyBQClE9oEjcMXGP5lI1HrovSsSTbD0
        dhwHuNVm7ZaZKY3H4PuxI/AJMFKCfmoWDD+t3esP5TJuxMfhh96wZHEitfo32uyh4j0BD+ZlpZU
        DyONX3Q02AGX76FXr+syS
X-Received: by 2002:a50:bf0e:: with SMTP id f14mr2520520edk.37.1591795296914;
        Wed, 10 Jun 2020 06:21:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3Kk79EA+wXpXk6yhNsxocbwWxoup7cqkJV7mK6aQdCYbcNsTWoysAMZWDcdRtd0q1XzbZ6w==
X-Received: by 2002:a50:bf0e:: with SMTP id f14mr2520475edk.37.1591795296587;
        Wed, 10 Jun 2020 06:21:36 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id l8sm15626086ejz.52.2020.06.10.06.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 06:21:35 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] Support inhibiting input devices
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3e61c9c1-b211-da9f-c55b-b44eb6522f2a@redhat.com>
Date:   Wed, 10 Jun 2020 15:21:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6136f26c-e090-e025-af55-4c5f3a6aec92@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 6/10/20 3:12 PM, Andrzej Pietrasiewicz wrote:
> Hi All,
> 
> W dniu 10.06.2020 o 12:38, Rafael J. Wysocki pisze:
>> On Wed, Jun 10, 2020 at 11:50 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi All,
>>>
>>> On 6/8/20 1:22 PM, Andrzej Pietrasiewicz wrote:
>>>> This is a quick respin of v3, with just two small changes, please see
>>>> the changelog below.
>>>>
>>>> Userspace might want to implement a policy to temporarily disregard input
>>>> from certain devices.
>>>>
>>>> An example use case is a convertible laptop, whose keyboard can be folded
>>>> under the screen to create tablet-like experience. The user then must hold
>>>> the laptop in such a way that it is difficult to avoid pressing the keyboard
>>>> keys. It is therefore desirable to temporarily disregard input from the
>>>> keyboard, until it is folded back. This obviously is a policy which should
>>>> be kept out of the kernel, but the kernel must provide suitable means to
>>>> implement such a policy.
>>>
>>> First of all sorry to start a somewhat new discussion about this
>>> while this patch set is also somewhat far along in the review process,
>>> but I believe what I discuss below needs to be taken into account.
>>>
>>> Yesterday I have been looking into why an Asus T101HA would not stay
>>> suspended when the LID is closed. The cause is that the USB HID multi-touch
>>> touchpad in the base of the device starts sending events when the screen
>>> gets close to the touchpad (so when the LID is fully closed) and these
>>> events are causing a wakeup from suspend. HID multi-touch devices
>>> do have a way to tell them to fully stop sending events, also disabling
>>> the USB remote wakeup the device is doing. The question is when to tell
>>> it to not send events though ...
>>>
>>> So now I've been thinking about how to fix this and I believe that there
>>> is some interaction between this problem and this patch-set.
>>>
>>> The problem I'm seeing on the T101HA is about wakeups, so the question
>>> which I want to discuss is:
>>>
>>> 1. How does inhibiting interact with enabling /
>>> disabling the device as a wakeup source ?
>>>
>>> 2. Since we have now made inhibiting equal open/close how does open/close
>>> interact with a device being a wakeup source ?
>>>
>>> And my own initial (to be discussed) answers to these questions:
>>>
>>> 1. It seems to me that when a device is inhibited it should not be a
>>> wakeup source, so where possible a input-device-driver should disable
>>> a device's wakeup capabilities on suspend if inhibited
>>
>> If "inhibit" means "do not generate any events going forward", then
>> this must also cover wakeup events, so I agree.
> 
> I agree, too.
> 
>>
>>> 2. This one is trickier I don't think we have really clearly specified
>>> any behavior here. The default behavior of most drivers seems to be
>>> using something like this in their suspend callback:
>>>
>>>           if (device_may_wakeup(dev))
>>>                   enable_irq_wake(data->irq);
>>>           else if (input->users)
>>>                   foo_stop_receiving_events(data);
>>>
>>> Since this is what most drivers seem to do I believe we should keep
>>> this as is and that we should just clearly document that if the
>>> input_device has users (has been opened) or not does not matter
>>> for its wakeup behavior.
>>>
>>> Combining these 2 answers leads to this new pseudo code template
>>> for an input-device's suspend method:
>>>
>>>          /*
>>>           * If inhibited we have already disabled events and
>>>           * we do NOT want to setup the device as wake source.
>>>           */
>>>          if (input->inhibited)
>>>                  return 0;
> 
> Right, if a device is inhibited it shouldn't become a wakeup source,
> because that would contradict the purpose of being inhibited.

Ack. Note I do think that we need to document this (and more
in general the answer to both questions from above) clearly so
that going forward if there are any questions about how this is
supposed to work we can just point to the docs.

Can you do a follow-up patch, or include a patch in your next
version which documents this (once we agree on what "this"
exactly is) ?

>>>
>>>           if (device_may_wakeup(dev))
>>>                   enable_irq_wake(data->irq);
> 
> What would it mean to become a wakeup source if there are no users,
> or nobody has ever opened the device? There are no interested
> input handlers (users) so what's the point of becoming a wakeup
> source? Why would the system need to wake up?

Well this is what we have been doing so far, so arguably we
need to keep doing it to avoid regressions / breaking our ABI.

Lets for example take a laptop, where when suspended the
power-button is the only valid wakeup-source and this is
running good old slackware with fvwm2 or windowmaker as
"desktop environment", then likely no process will have
the power-button input evdev node open.  Still we should
wakeup the laptop on the power-button press, otherwise
it will never wakeup.

Note I agree with you that the way this works is not
ideal, I just do not think that we can change it.

>>>           else if (input->users)
>>>                   foo_stop_receiving_events(data);
>>>
>>> ###

<snip>

Regards,

Hans

