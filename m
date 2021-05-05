Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0494F373D3C
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhEEOMh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 10:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233850AbhEEOM3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 10:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620223892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQvZQgbJYVjNUMrC5yEbwcKD1FSVeRaVFPfvoK5S8OE=;
        b=JF2mOHSVLBTNmIvzWS17wJpFA8e2rVF/GLrL0tpg6JrKY2caXPgo+AhwE8pbkqcDTho41Y
        aPU4ptK2LZI5K0VIASIq8PN6YAzYEswiXO28LYOHFgHi9XawjVnSPmbUXQmzdVPtJ4pVB3
        lPb/Xu8RAW8rzCDJkRXAGj3ZIK6UgKM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-pio1PNPTNLWc5_q3ujWQSg-1; Wed, 05 May 2021 10:11:31 -0400
X-MC-Unique: pio1PNPTNLWc5_q3ujWQSg-1
Received: by mail-ej1-f70.google.com with SMTP id yh1-20020a17090706e1b029038d0f848c7aso504398ejb.12
        for <linux-iio@vger.kernel.org>; Wed, 05 May 2021 07:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FQvZQgbJYVjNUMrC5yEbwcKD1FSVeRaVFPfvoK5S8OE=;
        b=PjhUdWU+T4oFQFOaJ4CBvY6j0jn8XnrOtcH9qwPMbmOdrenuvFM1pMRlIjo7BafFmH
         vM4lCOjnE4ODHI8WvlM/onayvlj70NnJ7u6E6c6/9JVgivFDYM7zLn6BxkjmI2L0oxVy
         umSRTJsWX32JIdaXb29nzGSgOJYPFFWHx4NzQVDuUlgtqPH4PaT/FF0YXeWo8luxr9Ku
         jgdiVoioUJvDb/tR5KuyK0ogfXjJ8OsDPMQBsMNFjGleL8xBjvU1gC/wKPwqkuieHIH6
         30zC5wej3+OHrewziIC5hH8t/ewIeJwy46lkMozr5QehGLZuPZAyqUtz/fOrSJyVrC+7
         Z5ng==
X-Gm-Message-State: AOAM531Wqp2dN/5w1leUx8/QsrLJi5hRRDSauQOgkK+WbdUeEOHWAQ+E
        mcS9UUjj5sdIl5/zEWWDjpW8tz10BQPgAhGlyUrpgAYArOFlHUFmxxcZfgjSa+vVFpaR8I6G+i8
        eX7W0eX8SAtCQXg+iqcn0
X-Received: by 2002:a17:906:edc7:: with SMTP id sb7mr27368204ejb.443.1620223889776;
        Wed, 05 May 2021 07:11:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8MzGe5WOM9n6If5c8KORI8UnzDZLTgFfHOt+sLMiazC9FX6E0uLoehKR0Ri+zTkuZtoPzXQ==
X-Received: by 2002:a17:906:edc7:: with SMTP id sb7mr27368174ejb.443.1620223889539;
        Wed, 05 May 2021 07:11:29 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g26sm2929567ejz.70.2021.05.05.07.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 07:11:29 -0700 (PDT)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ede732cb-4a23-e5bc-6802-0280dc232876@redhat.com>
Date:   Wed, 5 May 2021 16:04:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf+2oVttGhAcpcw-ZsAXno01yuKWz0Xiti_7beHCR81ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/5/21 3:53 PM, Andy Shevchenko wrote:
> On Wed, May 5, 2021 at 4:39 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 5/5/21 3:22 PM, Andy Shevchenko wrote:
>>> On Wed, May 5, 2021 at 11:36 AM Jonathan Cameron
>>> <Jonathan.Cameron@huawei.com> wrote:
>>>> On Wed, 5 May 2021 09:32:35 +0100
>>>> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>>>>> On Tue, 4 May 2021 11:00:52 -0700
>>>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> +Cc: Paul (I hope you are related to coreboot somehow and can
>>> communicate this further), Pavel and Jacek (LED subsystem suffered
>>> with this as well), Hans, Rafael and linux-acpi@
>>>
>>>>> Dropping the ones we are fairly sure are spurious is even better!
>>>>
>>>> If I get bored I'll just do a scrub of all the instances of this that
>>>> you haven't already cleaned up.  It's worth noting that we do
>>>> know some highly suspicious looking entries are out there in the wild.
>>>
>>> I have counted ~60 users of acpi_device_id in IIO. Brief looking at
>>> the IDs themselves rings an alarm about half of them.
>>>
>>> So, here we may have a chicken and egg problem, i.e. somebody has been
>>> using (or used) fake IDs from Linux kernel in the real products. What
>>> I can consider as a course of action is the following:
>>> 1. Clean up (by removing as quickly as possible) the IDs that have no
>>> proof to be real from the Linux kernel sources (perhaps marked as
>>> stable material)
>>> 2. Notify ASWG / UEFI forum about all IDs that abuse ACPI
>>> specification and are in Linux kernel, so at least we can keep some
>>> kind of "reserved/do not use" list on the official level (Rafael?)
>>> 3. Do not accept any IDs without an evidence provided that they are
>>> being in use in the real products (this should be done on Linux
>>> maintainer level in all subsystems that accept drivers
>>
>> So my 2 cents on this are that we need to be very careful with
>> removing "bogus" ACPI-ids.
>>
>> A couple of examples from a quick check under drivers/iio/accel:
>>
>> drivers/iio/accel/bmc150-accel-i2c.c:
>>
>> static const struct i2c_device_id bmc150_accel_id[] = {
>>         {"bmc150_accel",        bmc150},
>>         {"bmi055_accel",        bmi055},
>>         {"bma255",              bma255},
>>         {"bma250e",             bma250e},
>>         {"bma222",              bma222},
>>         {"bma222e",             bma222e},
>>         {"bma280",              bma280},
>>         {}
>> };
>>
>> static const struct acpi_device_id bmc150_accel_acpi_match[] = {
>>         {"BSBA0150",    bmc150},
>>         {"BMC150A",     bmc150},
>>         {"BMI055A",     bmi055},
>>         {"BMA0255",     bma255},
>>         {"BMA250E",     bma250e},
>>         {"BMA222",      bma222},
>>         {"BMA222E",     bma222e},
>>         {"BMA0280",     bma280},
>>         {"BOSC0200"},
>>         { },
>> };
>>
>> With the exception of the  "BSBA0150" and "BOSC0200"
>> ids, these look like they were invented. But at least the
>> "BMA250E" one is actually being used! The other BMA###?
>> ones are probably fake, but given that the "BMA250E"
>> one is actually real ...
>>
>> drivers/iio/accel/bmc150-accel-spi.c
>>
>> This uses the same set of ACPI ids as bmc150-accel-i2c.c
>> minus the "BOSC0200" one. I'm not aware if these
>> being used in spi mode on any x86 devices, but again
>> I'm not 100% sure ...
>>
>> drivers/iio/accel/da280.c
>>
>> static const struct acpi_device_id da280_acpi_match[] = {
>>         {"MIRAACC", da280},
>>         {},
>> };
>> MODULE_DEVICE_TABLE(acpi, da280_acpi_match);
>>
>> This looks like a fake-id, but it was actually added
>> in a separate commit adding ACPI support because the
>> chip is used with this id on a Linx 820 Windows tablet.
>>
>> So figuring out of any ids are real or not is really tricky
>> and removing them if they are real will lead to regressions.
>>
>> So summarizing IMHO we need to be careful and not just
>> start removing a whole bunch of these...
> 
> That's all true. However, I have a few hints on how to distinguish
> them (fake ones):
> 1. The ID has been added from day 1 with I2C or SPI ID table with just
> capitalized name
> 2. If there are a few drivers by the same author and at least one of
> the contributions has confirmed fake ID
> 3. The ID is single in the list and mimics the part number (capitalized form)
> 4. Google/DuckDuckGo/etc searches give no meaningful results
> 
> Either combination of the above can be a good hint to at least be
> sceptical that it's being used
May I suggest for accelerometers to also grep for the id in
60-sensors.hwdb from systemd ?  E.g. the BMA250E id can be found
there. 

> So, Hans, as you already noticed, drivers with a long list of IDs or
> when ID added separately can be considered less fakish, but we really
> want evidence of the hardware that has it.

If you want to move ahead with pruning some of these please Cc me
on the patches, then I'll check them against my collection of
Bay and Cherry Trail DSDTs, which are devices where these sensors
are often found.

Regards,

Hans

