Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131C11F751F
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jun 2020 10:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgFLIO2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Jun 2020 04:14:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26974 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726403AbgFLIOZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jun 2020 04:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591949662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V2zTglIal5OiHZJ8iFKvfCqf75RWAmlyagUCe+VaIC8=;
        b=DLDXQE/cUsVonjowdMcKOEQskFwqehdLz9weAcJRMxctaaWkEuGbxiFnPIeq/Pr4r4f+Xu
        kvs3vKB8pwN6rFCavMPEIxOsfyhgHIyHH1NF1wN7WZMEIumTuMchSi23W2t3iNfQo/NFC8
        moP9//Hvto5eMHJSvVAws8x+Z1tJTXI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-iitakAciPymIW-ATUkce6A-1; Fri, 12 Jun 2020 04:14:21 -0400
X-MC-Unique: iitakAciPymIW-ATUkce6A-1
Received: by mail-ed1-f72.google.com with SMTP id f13so2585198edv.11
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2020 01:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V2zTglIal5OiHZJ8iFKvfCqf75RWAmlyagUCe+VaIC8=;
        b=bofUiaX0wVlhvY47KG17CSaubiFcQJaqjL/OC1IRD1GyMuMbVNAzMSpsPddAlRiRsJ
         4dQXZWSFRh8I8y9Mma3Z+T0qyW0XcQgdFWZlofBvaZV2SyctPoqau94kBLChLeQnR2bY
         K6xxDj8HTVMkUGYVja7ekSsJ335oUuT/VHaAz3SyMOxLtqMwAso8FHKHcaQm5enSkeoL
         mHECEAvgF+7EeQX6zURV/kdFG5Knrpvry/bDdXdaMP4weDCffS4zizXZop6KME7hL4Xw
         adtl5t3LSENsMbty6fjU65wdZLBXVW4UPzl2a4Vpe76B397pe19/tEc68Jbbr4vJWMCu
         p9mg==
X-Gm-Message-State: AOAM532OpXp7+asWbfSz7DpRg483PgA+2MZBA+i6AN1vyTlBcHegwEcv
        YYUnyrAuvj0CjEOM5xoyBZhqwadLub3jqMAgVXZHdVoKSZYuDooEXUtYXyP2a4fDw+UixcBSfAC
        ugrGKzj8/TxcWLclaTEyX
X-Received: by 2002:a17:907:209b:: with SMTP id pv27mr11743719ejb.146.1591949659892;
        Fri, 12 Jun 2020 01:14:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBAHer5t4lrLm+vMdTXed6gLDbil+57VlZQwx847llFMXVqLhRHTvWPje2pJt4EUELeeQ+uA==
X-Received: by 2002:a17:907:209b:: with SMTP id pv27mr11743678ejb.146.1591949659541;
        Fri, 12 Jun 2020 01:14:19 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id h1sm2725555edz.88.2020.06.12.01.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 01:14:18 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] Support inhibiting input devices
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Linux PM <linux-pm@vger.kernel.org>,
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
 <20200610182836.GA248110@dtor-ws>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2e4bd050-117c-cc5f-8cf0-055b5304717f@redhat.com>
Date:   Fri, 12 Jun 2020 10:14:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610182836.GA248110@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 6/10/20 8:28 PM, Dmitry Torokhov wrote:
> On Wed, Jun 10, 2020 at 12:38:30PM +0200, Rafael J. Wysocki wrote:
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
> 
> One should not affect the other.
> 
>>>
>>> 2. Since we have now made inhibiting equal open/close how does open/close
>>> interact with a device being a wakeup source ?
> 
> One did not affect another, and it should not.
> 
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
> Why? These are separate concepts. Do we disable wake on lan when
> bringing network interface down? Do we update power/wakeup when device
> is inhibited? Do we restore it afterwards? Do we un-inhibit if we
> reenable wakeup after device is inhibited? Do we return error? How?
> 
> Inhibit works on logical level, i.e. if I have several input interfaces
> on the same hardware device, I cam inhibit one leaving others intact.
> This does not mean that the device should stop generating wakeup events.
> We can't even guarantee this for composite devices.

After thinking more about this I believe you are right and we should
keep these as 2 separate, completely independent settings.

Especially since the wakeup setting typically is a setting of the
parent device, where as the inhibit is done on the actual input-dev.

###

Some quick background info on my original thoughts here, as mentioned
I started thinking about this because of spurious wakeups from suspend
when the lid of an asus t101ha is "touching" its touchpad. The HID
multi-touch protocol has a setting where we can ask the device to
stop sending events. So even though the kbd + touchpad are a
single composite USB device, we can disable wakeup (in a way)
for just the touchpad at the hid-multitouch level.

So I was thinking maybe adding a separate wakeup setting to the
input device itself for this. But thinking more about it, when
the lid is closed we can just disable wakeup on the entire USB
device, since the keyboard is covered by the lid too.

And then on suspend the hid-multitouch driver can detect that its
parent (or parents parent in the case of USB) has wakeup disabled
and also tell the device to stop scanning for fingers to save some
power.

We probably also need a close and open callbacks add the HID-driver
level, so that if there are no touchpad users we can also use
the same option to put the HID multi-touch device in a low power mode
where it does not scan for fingers.

<snip>

>>> A different, but related issue is how to make devices actually use the
>>> new inhibit support on the builtin keyboard + touchpad when say the lid
>>> is closed.   Arguably this is an userspace problem, but it is a tricky
>>> one. Currently on most modern Linux distributions suspend-on-lid-close
>>> is handled by systemd-logind and most modern desktop-environments are
>>> happy to have logind handle this for them.
>>>
>>> But most knowledge about input devices and e.g. heurisitics to decide
>>> if a touchpad is internal or external are part of libinput. Now we could
>>> have libinput use the new inhibit support (1), but then when the lid
>>> closes we get race between whatever process is using libinput trying
>>> to inhibit the touchpad (which must be done before to suspend to disable
>>> it as wakeup source) and logind trying to suspend the system.
>>>
>>> One solution here would be to move the setting of the inhibit sysfs
>>> attr into logind, but that requires adding a whole bunch of extra
>>> knowledge to logind which does not really belong there IMHO.
> 
> You do not need to push the knowledge into logind, you just need to
> communicate to logind what devices can be wakeup sources and which ones
> should not. Chrome OS uses udev tags/properties for that.

True, I did not think of doing the tag thingie + letting logind do
the inhibit on LID close based on that. logind could also disable
wakeup (to save power while suspended) on devices which are tagged
for it to do that (should probably be a separate tag from the
inhibit tag).

>>> I've been thinking a bit about this and to me it seems that the kernel
>>> is in the ideal position to automatically inhibit some devices when
>>> some EV_SW transitions from 0->1 (and uninhibit again on 1->0). The
>>> issue here is to chose on which devices to enable this. I believe
>>> that the auto inhibit on some switches mechanism is best done inside
>>> the kernel (disabled by default) and then we can have a sysfs
>>> attr called auto_inhibit_ev_sw_mask which can be set to e.g.
>>> (1 << SW_LID) to make the kernel auto-inhibit the input-device whenever
>>> the lid is closed, or to ((1 << SW_LID) | (1 << SW_TABLET_MODE)) to
>>> inhibit both when the lid is closed or when switched to tablet mode.
> 
> This is a policy and should be kept out of the kernel. Yes, we had it
> implemented with rfkill input handler, but it caused quite a few issues.
> As far as I know it is not being used anymore and we should not try with
> SW_LID->inhibit either.
> 
> I know it is faster to patch the kernel than to roll out proper
> userspace because everyone updates kernel regularly, but it does not
> mean it is the right solution.

Agreed, I just could not come up with a clean userspace solution, but
using udev+hwdb to set a tag for logind instead of having the write
to a new auto_inhibit_ev_sw_mask will work nicely.

So I think this is all resolved now (or at least we have a plan for it).

Regards,

Hans

