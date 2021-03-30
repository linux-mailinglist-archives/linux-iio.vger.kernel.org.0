Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F376834E45C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Mar 2021 11:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhC3J1u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Mar 2021 05:27:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231809AbhC3J10 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Mar 2021 05:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617096444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9mUNFoBgvKejNWWOHHTAHNX5zgr1n+fd6f90oKKAof0=;
        b=iEJtXqmVl2Q/8USv7/pMvX9ajyW1xyKsWI3O4lV/Q5eJmT2fOGbh59tl+UlTZakkS6Jryj
        jSLIHvoOjfpBg1gyrvx+nohh9NicdQZWlq+3Im84tl5eztCP3VBqAl+ongW5Jijy8Il9VP
        z6qp/h4Sr/ysb3OKTfPGOiHCzyOL07w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-gcxUR28vMHywDwYzuQsweQ-1; Tue, 30 Mar 2021 05:27:13 -0400
X-MC-Unique: gcxUR28vMHywDwYzuQsweQ-1
Received: by mail-ed1-f70.google.com with SMTP id i19so9965070edy.18
        for <linux-iio@vger.kernel.org>; Tue, 30 Mar 2021 02:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9mUNFoBgvKejNWWOHHTAHNX5zgr1n+fd6f90oKKAof0=;
        b=BWKfX/OhgtX6g688XygUiiEN0f1IDhYpxTpmX4KQRPK0fQ6Whleyag0IY467j/WGlF
         Uvm6wZ0JNVFTdA4pNie6I30MtMYcumq186bczKv120pwCs6LlJH9iFhSFnvtHJW3adeK
         WQdIRwZW+Knr0TZQB9w6gKCld0wn9pjBljNAITvVOCFiOMIiBMaP8K0BM0L2BeeDhIqH
         JSYQAY/NrUPSVGAEDjNb3KYTBUQtD6E7PqHpDQgqjGQE1ASIjKs9ZVkKbwl0oYNY7utG
         Mw/fmGWQDTeiamdIMz7USaG7iy0aM5tKoI+n/s47ngjICVtoby8T0d80gyYQ9yMRdpym
         S6/Q==
X-Gm-Message-State: AOAM532wQ0IrCYYG6lMx1SGuHHv57YSdNOOss6EvDsPc7rBGI4jljB8e
        lTODqR0wNFcl+7N2z7wjFsZnHdfEaRqqY10nqWnGGPHHhsA+ddcAF+i41W6IcEgFgNYHPsIkS0K
        Wb1TiBSj3BJj7/Ud4cIxa
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr32824800edu.252.1617096432615;
        Tue, 30 Mar 2021 02:27:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJa7/AfDEMjCI4kCDrKzGtV1zyFKqjOaYQIcZKOvIA07ru1KGkgp3VWrScUVIV6ideXp/GPg==
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr32824782edu.252.1617096432425;
        Tue, 30 Mar 2021 02:27:12 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t14sm9718402ejc.121.2021.03.30.02.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 02:27:12 -0700 (PDT)
Subject: Re: [PATCH 00/10] platform/x86: toshiba_acpi: move acpi add/remove to
 device-managed routines
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>, coproscefalo@gmail.com,
        mgross@linux.intel.com, Jonathan Cameron <jic23@kernel.org>,
        linux@deviqon.com
References: <20210324125548.45983-1-aardelean@deviqon.com>
 <0fba6355-aaec-b214-cf12-1add08cfca38@redhat.com>
 <CA+U=Dsq-YDBzSEsRBsTOkzf=1yyfB4esTJMvc6rKWTPff=i1TQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f0b742d4-446b-95fd-5488-479c50e5d731@redhat.com>
Date:   Tue, 30 Mar 2021 11:27:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CA+U=Dsq-YDBzSEsRBsTOkzf=1yyfB4esTJMvc6rKWTPff=i1TQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 3/30/21 11:22 AM, Alexandru Ardelean wrote:
> On Tue, Mar 30, 2021 at 11:21 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Alexadru, Jonathan,
>>
>> On 3/24/21 1:55 PM, Alexandru Ardelean wrote:
>>> This changeset tries to do a conversion of the toshiba_acpi driver to use
>>> only device-managed routines. The driver registers as a singleton, so no
>>> more than one device can be registered at a time.
>>>
>>> My main intent here is to try to convert the iio_device_alloc() and
>>> iio_device_register() to their devm_ variants.
>>>
>>> Usually, when converting a registration call to device-managed variant, the
>>> init order must be preserved. And the deregistration order must be a mirror
>>> of the registration (in reverse order).
>>>
>>> This change tries to do that, by using devm_ variants where available and
>>> devm_add_action_or_reset() where this isn't possible.
>>> Some deregistration ordering is changed, because it wasn't exactly
>>> mirroring (in reverse) the init order.
>>>
>>> For the IIO subsystem, the toshiba_acpi driver is the only user of
>>> iio_device_alloc(). If this changeset is accepted (after discussion), I
>>> will propose to remove the iio_device_alloc() function.
>>>
>>> While I admit this may look like an overzealous effort to use devm_
>>> everywhere (in IIO at least), for me it's a fun/interesting excercise.
>>
>> Alexadru, thank you for the patches.
>>
>> Jonathan, thank you for the reviews.
>>
>> To be honest I'm currently inclined to not accept / merge these patches,
>> this is based on 2 assumptions from me, which might be wrong. let me explain.
>>
>> If I understand things correctly, the main reason for this rework of
>> the toshiba_acpi code is to move iio_device_alloc() and iio_device_register()
>> to their devm_ variants, converting the last users in the tree ?
> 
> yes
> well, we still have plenty of users iio_device_alloc() /
> iio_device_register() inside drivers/iio
> 
> but the toshipa_acpi driver is the more quirky user of these functions
> [treewide]
> 
> i wanted to jump on those simpler IIO cases, but i thought i would
> leave those to new contributors [for a while];
> the complexity of those conversions is good enough to get some people
> started to contribute changes that are a bit more useful than
> checkpatch fixes, comment fixes [etc];
> 
> [personally] i feel that these devm_ conversions are complex enough to
> maybe get people wanting to dig more into some kernel design stuff

I like how you think about onboarding new people.

>> This would allow these 2 iio functions to then be e.g. marked as static /
>> private helpers inside the iio core, so that all new users can only use
>> the devm_ versions. But if I'm reading Jonathan's reaction correctly then
>> Jonathan is not planning to do that because they might still be useful
>> in some cases.
>>
>> Jonathan have I correctly understood that you don't plan to make any
>> changes to the iio_device_alloc() and iio_device_register() functions
>> even if this gets merged ?
>>
>> Which brings me to my next assumption, Alexandru, I don't read anything
>> about testing anywhere. So I'm currently under the assumption that
>> you don't have any hardware using the toshiba_acpi driver and that this
>> is thus untested ?
> 
> yes, i don't have any hw to test this
> 
>>
>> The not being tested state is my main reason for not wanting to merge
>> this. The toshiba_acpi driver likely does not have a whole lot of users,
>> so the chances of someone running release candidates or even just the
>> latest kernels on hardware which uses it are small.  This means that if
>> we accidentally introduce a bug with this series it might not get caught
>> until say lots of people start upgrading to Ubuntu 22.04 which is
>> the first Ubuntu kernel with your changes; and then at least one of the
>> hit users needs to have the skills to find us and get in contact about that.
>>
>> TL;DR: we might break stuff and if we do it might be a long time until we
>> find out we did and then we have been shipping broken code for ages...
> 
> ack
> well, i don't insist in pushing this series;

Ok, lets park this series then for now, because IMHO it is just a tad
too complex to merge without it being tested (and without another
important reason like it being part of some larger cleanup / refactoring).

Regards,

Hans




>>> Alexandru Ardelean (10):
>>>   platform/x86: toshiba_acpi: bind life-time of toshiba_acpi_dev to
>>>     parent
>>>   platform/x86: toshiba_acpi: use devm_add_action_or_reset() for
>>>     singleton clear
>>>   platform/x86: toshiba_acpi: bind registration of miscdev object to
>>>     parent
>>>   platform/x86: toshiba_acpi: use device-managed functions for input
>>>     device
>>>   platform/x86: toshiba_acpi: register backlight with device-managed
>>>     variant
>>>   platform/x86: toshiba_acpi: use devm_led_classdev_register() for LEDs
>>>   platform/x86: toshiba_acpi: use device-managed functions for
>>>     accelerometer
>>>   platform/x86: toshiba_acpi: use device-managed for wwan_rfkill
>>>     management
>>>   platform/x86: toshiba_acpi: use device-managed for sysfs removal
>>>   platform/x86: toshiba_acpi: bind proc entries creation to parent
>>>
>>>  drivers/platform/x86/toshiba_acpi.c | 249 +++++++++++++++++-----------
>>>  1 file changed, 150 insertions(+), 99 deletions(-)
>>>
>>
> 

