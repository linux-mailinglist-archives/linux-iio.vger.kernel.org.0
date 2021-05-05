Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801A2373E5D
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 17:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhEEPUe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 11:20:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233206AbhEEPUd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 11:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620227976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i9+/SI9bfIZOMi4mYl2+8D9GvEvJDbWNlGJbD7Lpwj8=;
        b=dgut62RLx/yUIVdqs+bueL4t/M/Alic4gzXKHcgo+PZ5WnormxuOixP/bjI4eQkjvgDHND
        V6kY/afY8DEReD/uaZqJGv6tFUB2gDaMxqhZRhtc0u+5nDZEZXZ4/HGBSh//Ovdi5ZdfRy
        HXCCeTbmieSmATVuyVC3awJvK0Z2iKM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-uOWeWFmdPha94bRFWGyddw-1; Wed, 05 May 2021 11:19:35 -0400
X-MC-Unique: uOWeWFmdPha94bRFWGyddw-1
Received: by mail-ej1-f72.google.com with SMTP id w23-20020a1709061857b029039ea04b02fdso583920eje.22
        for <linux-iio@vger.kernel.org>; Wed, 05 May 2021 08:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i9+/SI9bfIZOMi4mYl2+8D9GvEvJDbWNlGJbD7Lpwj8=;
        b=cxao9mUCD17ulr+d9hT+xT010TE/vgeCp4G9fOFcvckZB/Nczd2WpywgguWQftmwNX
         kXwhIYUlMroLrfbe+83Y1I0lA2GXEG7/XpSEr0TmuK5HdhE7V6IT1ioKESSxaRoec9sw
         pbpgCyZSPdzZgJzrJiQgyduCck6s6a5s2DJED86M+yhW97/H+YJYElZ8j/KDamnxN+sI
         xuHzuaDtfPec/687tO1NKGN9WbTp9x8U2pNCl9/z7BMJb9jGpjzccxEZbiyvbSNoXtR0
         NOzySxXnjfevibOAhBIQ5ot5E+ogrZZT/Z61iPoOoDZlxpZ8JWYMhtMHMp8hxlgrGj5z
         Bwkw==
X-Gm-Message-State: AOAM530JBSP9acp7y4koAtYjNg3moOB7Zp/e1PQmCqm5cGZVawUp5Ubq
        GMz89K1taQt3S63bgpdBgUFiiXyHIqm8L9QysbfTPK9BroPr6JtjnQToloTjT5etM92HvgMAcyx
        bzUPvSFLp+qDjvI7U3r+K
X-Received: by 2002:a05:6402:c03:: with SMTP id co3mr32538030edb.133.1620227973212;
        Wed, 05 May 2021 08:19:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjGGeHQ9vmnmQDxg5lqz7wEOdbz3LdKGpDTxIsZiw1ioXyJ+Fb0quPGbmmpOxMmgPfGxOtkA==
X-Received: by 2002:a05:6402:c03:: with SMTP id co3mr32538005edb.133.1620227973013;
        Wed, 05 May 2021 08:19:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g8sm2954220ejt.25.2021.05.05.08.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 08:19:32 -0700 (PDT)
Subject: Re: [PATCH] iio: bme680_i2c: Make bme680_acpi_match depend on
 CONFIG_ACPI
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@denx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20210504174019.2134652-1-linux@roeck-us.net>
 <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
 <8f8b6f33-4308-bfda-2238-9a54e19c3f9f@roeck-us.net>
 <20210505093235.00007c38@Huawei.com> <20210505093438.00005238@Huawei.com>
 <CAHp75VezSD_TcbQ_OBZXPo-szTr-qwOT9oU+7h7W6nk65ZLBhA@mail.gmail.com>
 <22212bbc-1dc7-c7e7-1954-ebb911754246@redhat.com>
 <CAHp75Vf+2oVttGhAcpcw-ZsAXno01yuKWz0Xiti_7beHCR81ng@mail.gmail.com>
 <ede732cb-4a23-e5bc-6802-0280dc232876@redhat.com>
 <CAHp75VciMKfxPvKmY349327FcoUcUMeFnvqkniw2erCyb71BoQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3121ad81-1dc3-eace-a87c-47ebafa2d615@redhat.com>
Date:   Wed, 5 May 2021 17:19:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VciMKfxPvKmY349327FcoUcUMeFnvqkniw2erCyb71BoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/5/21 4:18 PM, Andy Shevchenko wrote:
> On Wed, May 5, 2021 at 5:11 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 5/5/21 3:53 PM, Andy Shevchenko wrote:
>>> On Wed, May 5, 2021 at 4:39 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>> On 5/5/21 3:22 PM, Andy Shevchenko wrote:
>>>>> On Wed, May 5, 2021 at 11:36 AM Jonathan Cameron
>>>>> <Jonathan.Cameron@huawei.com> wrote:
>>>>>> On Wed, 5 May 2021 09:32:35 +0100
>>>>>> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>>>>>>> On Tue, 4 May 2021 11:00:52 -0700
>>>>>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>
>>>>> +Cc: Paul (I hope you are related to coreboot somehow and can
>>>>> communicate this further), Pavel and Jacek (LED subsystem suffered
>>>>> with this as well), Hans, Rafael and linux-acpi@
>>>>>
>>>>>>> Dropping the ones we are fairly sure are spurious is even better!
>>>>>>
>>>>>> If I get bored I'll just do a scrub of all the instances of this that
>>>>>> you haven't already cleaned up.  It's worth noting that we do
>>>>>> know some highly suspicious looking entries are out there in the wild.
>>>>>
>>>>> I have counted ~60 users of acpi_device_id in IIO. Brief looking at
>>>>> the IDs themselves rings an alarm about half of them.
>>>>>
>>>>> So, here we may have a chicken and egg problem, i.e. somebody has been
>>>>> using (or used) fake IDs from Linux kernel in the real products. What
>>>>> I can consider as a course of action is the following:
>>>>> 1. Clean up (by removing as quickly as possible) the IDs that have no
>>>>> proof to be real from the Linux kernel sources (perhaps marked as
>>>>> stable material)
>>>>> 2. Notify ASWG / UEFI forum about all IDs that abuse ACPI
>>>>> specification and are in Linux kernel, so at least we can keep some
>>>>> kind of "reserved/do not use" list on the official level (Rafael?)
>>>>> 3. Do not accept any IDs without an evidence provided that they are
>>>>> being in use in the real products (this should be done on Linux
>>>>> maintainer level in all subsystems that accept drivers
>>>>
>>>> So my 2 cents on this are that we need to be very careful with
>>>> removing "bogus" ACPI-ids.
>>>>
>>>> A couple of examples from a quick check under drivers/iio/accel:
>>>>
>>>> drivers/iio/accel/bmc150-accel-i2c.c:
>>>>
>>>> static const struct i2c_device_id bmc150_accel_id[] = {
>>>>         {"bmc150_accel",        bmc150},
>>>>         {"bmi055_accel",        bmi055},
>>>>         {"bma255",              bma255},
>>>>         {"bma250e",             bma250e},
>>>>         {"bma222",              bma222},
>>>>         {"bma222e",             bma222e},
>>>>         {"bma280",              bma280},
>>>>         {}
>>>> };
>>>>
>>>> static const struct acpi_device_id bmc150_accel_acpi_match[] = {
>>>>         {"BSBA0150",    bmc150},
>>>>         {"BMC150A",     bmc150},
>>>>         {"BMI055A",     bmi055},
>>>>         {"BMA0255",     bma255},
>>>>         {"BMA250E",     bma250e},
>>>>         {"BMA222",      bma222},
>>>>         {"BMA222E",     bma222e},
>>>>         {"BMA0280",     bma280},
>>>>         {"BOSC0200"},
>>>>         { },
>>>> };
>>>>
>>>> With the exception of the  "BSBA0150" and "BOSC0200"
>>>> ids, these look like they were invented. But at least the
>>>> "BMA250E" one is actually being used! The other BMA###?
>>>> ones are probably fake, but given that the "BMA250E"
>>>> one is actually real ...
>>>>
>>>> drivers/iio/accel/bmc150-accel-spi.c
>>>>
>>>> This uses the same set of ACPI ids as bmc150-accel-i2c.c
>>>> minus the "BOSC0200" one. I'm not aware if these
>>>> being used in spi mode on any x86 devices, but again
>>>> I'm not 100% sure ...
>>>>
>>>> drivers/iio/accel/da280.c
>>>>
>>>> static const struct acpi_device_id da280_acpi_match[] = {
>>>>         {"MIRAACC", da280},
>>>>         {},
>>>> };
>>>> MODULE_DEVICE_TABLE(acpi, da280_acpi_match);
>>>>
>>>> This looks like a fake-id, but it was actually added
>>>> in a separate commit adding ACPI support because the
>>>> chip is used with this id on a Linx 820 Windows tablet.
>>>>
>>>> So figuring out of any ids are real or not is really tricky
>>>> and removing them if they are real will lead to regressions.
>>>>
>>>> So summarizing IMHO we need to be careful and not just
>>>> start removing a whole bunch of these...
>>>
>>> That's all true. However, I have a few hints on how to distinguish
>>> them (fake ones):
>>> 1. The ID has been added from day 1 with I2C or SPI ID table with just
>>> capitalized name
>>> 2. If there are a few drivers by the same author and at least one of
>>> the contributions has confirmed fake ID
>>> 3. The ID is single in the list and mimics the part number (capitalized form)
>>> 4. Google/DuckDuckGo/etc searches give no meaningful results
>>>
>>> Either combination of the above can be a good hint to at least be
>>> sceptical that it's being used
>> May I suggest for accelerometers to also grep for the id in
>> 60-sensors.hwdb from systemd ?  E.g. the BMA250E id can be found
>> there.
> 
> Right, it's a very good suggestion! It will definitely tell us what
> may not be removed even if we don't see any evidence otherwise.
> 
>>> So, Hans, as you already noticed, drivers with a long list of IDs or
>>> when ID added separately can be considered less fakish, but we really
>>> want evidence of the hardware that has it.
>>
>> If you want to move ahead with pruning some of these please Cc me
>> on the patches, then I'll check them against my collection of
>> Bay and Cherry Trail DSDTs, which are devices where these sensors
>> are often found.
> 
> Currently the scope is of
> AOS2315
> BME0680
> STK8312

Ok I cannot find any reference to those in the DSDT-s which I have,
nor in systemd's hwdb.

Regards,

Hans

