Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C1837710A
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 11:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhEHJsb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 May 2021 05:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229583AbhEHJsa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 May 2021 05:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620467249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dY53Nc61o60Wf+/qIK7zrnU7eZ4qBKGUvPeJZm3EV6A=;
        b=QPRGF7yWVl70AUb8HQ0oqvh/LuR055ud39rBnwi3TvgrrY4LUNFw1U9zjJL4y6lrrshTue
        a9tUtU4aHWfK2L9Q8OGP0wGqfJyHikNpr3aP8sErkINXY08vaePYGDPLJ4OfCK17xv4/sC
        Kv7tmBuBBOImP8aFaysGz3NUE2/5lSs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-4qlrRz7gPTSqdw2O-ksnyw-1; Sat, 08 May 2021 05:47:22 -0400
X-MC-Unique: 4qlrRz7gPTSqdw2O-ksnyw-1
Received: by mail-ej1-f72.google.com with SMTP id f7-20020a1709062c47b02903b82811ac02so102256ejh.20
        for <linux-iio@vger.kernel.org>; Sat, 08 May 2021 02:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dY53Nc61o60Wf+/qIK7zrnU7eZ4qBKGUvPeJZm3EV6A=;
        b=tytfnS2vw8Uwx2Np2UwfNTKrAT4fMRvJ1fSqXz5tCHVPzzToZDZqIN5cV+wsA8EBCT
         43zQo6GdPKGuqhOJQ8tq4jD+hPuXIAWActDa3p3kgX2rpiQSFTLPudGAT4OqbVbU4Lhm
         Bic80z8RPufUd/BDl5uObFIhhBbJMLic+dJdq1XDGcqIaBc/5H6TmSJk+aie8bv3fpiF
         +4tshwsXj67BKqL8uutqxyyGHNd7jYraSWjO9kvUuaZ60XBsRrU6hPXpoSSOEbmiOFIK
         8SxGf1gtEZyAnFnjmJEI1iJy0WtDMBvJwd7iqDKQMqqr+QeR+RxohNxDkD5mD2okTkZG
         iQ8A==
X-Gm-Message-State: AOAM5334eJmSX3o7JEloFrqjoP/bXeDtvdnoEQGjv4xvB1i7hNxnZzBg
        jm+F0L075HwMHdg3o8DL/2YCP+SAcS/LkNNziNhEKCJwdEoDyT9K22OkZtFNsBnuBKIh95Mw+JG
        fX9yJ/dGg+scFcUReKKwf
X-Received: by 2002:a17:906:bce7:: with SMTP id op7mr14525562ejb.398.1620467241399;
        Sat, 08 May 2021 02:47:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5g/ZxbF3Bn2THc67O9ehSeDI4fFZDU2mECrKYvoo2ZFwCec9D8uaMkTFhb/PHqSdRHT8mmQ==
X-Received: by 2002:a17:906:bce7:: with SMTP id op7mr14525551ejb.398.1620467241204;
        Sat, 08 May 2021 02:47:21 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id c8sm6070712edy.63.2021.05.08.02.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 02:47:20 -0700 (PDT)
Subject: Re: [PATCH v2] iio: bme680_i2c: Remove ACPI support
From:   Hans de Goede <hdegoede@redhat.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20210506034332.752263-1-linux@roeck-us.net>
 <20210507103154.00006763@Huawei.com> <20210508030936.GA3879276@roeck-us.net>
 <CAHp75Vfa3GT9bnimxw7EJsJyRF8HZP3PGsUNikSScuNiU4qArg@mail.gmail.com>
 <294dacb7-aef3-ede0-e46d-5c8fd91e9c17@redhat.com>
Message-ID: <0627cf17-c902-02a7-40d7-2f4b6fb4754e@redhat.com>
Date:   Sat, 8 May 2021 11:47:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <294dacb7-aef3-ede0-e46d-5c8fd91e9c17@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi again,

On 5/8/21 11:41 AM, Hans de Goede wrote:
> Hi,
> 
> On 5/8/21 9:48 AM, Andy Shevchenko wrote:
>>
>>
>> On Saturday, May 8, 2021, Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>> wrote:
>>
>>     On Fri, May 07, 2021 at 10:31:54AM +0100, Jonathan Cameron wrote:
>>     > On Wed,  5 May 2021 20:43:32 -0700
>>     > Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>> wrote:
>>     >
>>     > > With CONFIG_ACPI=n and -Werror, 0-day reports:
>>     > >
>>     > > drivers/iio/chemical/bme680_i2c.c:46:36: error:
>>     > >     'bme680_acpi_match' defined but not used
>>     > >
>>     > > Apparently BME0680 is not a valid ACPI ID. Remove it and with it
>>     > > ACPI support from the bme680_i2c driver.
>>     > >
>>     > > Reported-by: kernel test robot <lkp@intel.com <mailto:lkp@intel.com>>
>>     > > Cc: Andy Shevchenko <andy.shevchenko@gmail.com <mailto:andy.shevchenko@gmail.com>>
>>     > > Cc: Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>>
>>     > > Signed-off-by: Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>>
>>     >
>>     > A note for these is that I'll change the patch titles when applying.
>>     > We aren't removing ACPI support from the drivers, we are simply
>>     > removing the ACPI ID table entries.  For most of these PRP0001 magic
>>     > will work just fine with the OF table.  That's probably the
>>     > right way for small companies etc to use these in products without
>>     > having to jump through the hoops of getting an ACPI ID.
>>     >
>>
>>     Below is what Coccinelle tells me about ACPI IDs in drivers/iio.
>>     The script (tries) to do a prefix match of all ACPI IDs it finds against
>>     the PNP and ACPI ID databases from https://uefi.org/PNP_ACPI_Registry <https://uefi.org/PNP_ACPI_Registry>.
>>
>>     Andy, Hans, does that look about right ?
>>
>>
>>
>> The result looks nice for the first step!
>>  
>>
>>
>>     Next question is what to do with the mismatches and with false
>>     negatives such as:
>>
>>     drivers/iio/accel/stk8312.c
>>       STK8312: match (prefix) against STK (SANTAK CORP.)
>>     drivers/iio/light/isl29018.c
>>       ISL29018: match (prefix) against ISL (Isolation Systems)
>>       ISL29023: match (prefix) against ISL (Isolation Systems)
>>       ISL29035: match (prefix) against ISL (Isolation Systems)
>>     drivers/iio/gyro/bmg160_i2c.c
>>
>>
>>  
>>
>>       BMI055B: match (prefix) against BMI (Benson Medical Instruments Company)
>>       BMI088B: match (prefix) against BMI (Benson Medical Instruments Company)
>>
>>
>> These I think the real ones from the existing devices.
> 
> No that is wrong, these are Bosch sensors, so the BOSC0200 entry for
> the companion accelerometer is the only entry using the official company
> prefix. At least "BMA" ("BMA250E") and "BSG" ("BSG1160", "BSG2150") are
> also know to be used as prefixes for ACPI HIDs which are in active
> use for Bosch sensors :|
> 
> And Benson Medical Instruments Company has nothing to do with these
> sensors :|

p.s.

And there also is the Lenovo Yoga 300 11IBR convertible laptop which has
2 Bosch accelerometers, 1 in the display and 1 in the base/keyboard
described in a single ACPI "Device (ACC1) {}" ACPI fwnode (so not 1 fwnode
per sensor), and this single node to describe 2 separate I2C connected
ICs has a ACPI HID of "DUAL250E" (*), how is that for sticking to the HID
naming spec ?

I really have the feeling that the naming spec is not worth much more
then the paper it is written on, it is really really easy to find a ton
of examples out in the field which don't adhere to it.

Regards,

Hans



*) I recently got my hands on one of these and I still need to add support
for this to the kernel

