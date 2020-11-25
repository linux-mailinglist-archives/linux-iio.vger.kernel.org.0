Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2804C2C3ED3
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 12:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgKYLLk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 06:11:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728006AbgKYLLk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 06:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606302698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGlbGxHBtLRbYZvkSG0Ax7EZzRySn0MsRFteM7Gx2Wg=;
        b=WsMegJ8+C931qlLE8l+SxJZJru5ozWJ1ae/VOBOIaoj95pWY0ZkUslED7ZQZsYDMB+152J
        OywBaj1dbbKbJjyx2A0H0gm3EdrCB2D/otElrOMPmg7QcsyHIPI1z5WdEAQseJt6mAwMXu
        upYn4YQ9+GM12hSzHpEpTe4uRzU3nvI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-RhQ9qD39MeyZN0rCqmEXOg-1; Wed, 25 Nov 2020 06:11:37 -0500
X-MC-Unique: RhQ9qD39MeyZN0rCqmEXOg-1
Received: by mail-ed1-f70.google.com with SMTP id c23so516179edr.4
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 03:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FGlbGxHBtLRbYZvkSG0Ax7EZzRySn0MsRFteM7Gx2Wg=;
        b=tCZVIq6gNoxYhoB5VCUPa+Meep2rhW82MDKaDaJ+g8mDvhWGF5UjK+KwhlTFQ8vW+D
         zw2OEliXyHKgrep2dviFYWTSWsnLNPMnC9wXA9Lp2uIcTZhpXWFV8m+J9kR52O5G0E0G
         WRl+RzfUyYt5EQJj1emHOWqe/wjBttu4/G62I3nit2x12zz4cYoQPRPYXA1VBmqadoUg
         W9KeoT+Tgl7WDjow+sFB+UV4MXsj5kO3nQhGnru0hqvDu9A9Q4nJbasBfpQBtHDlcK89
         GNdSFEb84l7Zu5gR7KpRcILGFjhwNnEarY8Eu8cySF35+O7O/mu6zpW1v2KoF8SARNo+
         ZVyQ==
X-Gm-Message-State: AOAM531/Fl43eMTjNNPMRJV9kjQ2cBmE8ELcarPXwmO/RfYKFhF9eTBG
        vApkV0wsipTTZ7Cv58OqjTcj08HTiLv4eYj3N3D89AEg+a2WdIgBRdfzHZH5VvfSGAo4qVQjgJn
        EXh1VHzh/TupKTIMcNy0eKx+g6yw3CfkzKCu4Chs2oEMeohk28BqWeMC8zGKqpNV6IMLGRtmp
X-Received: by 2002:a17:906:ad85:: with SMTP id la5mr2687478ejb.423.1606302695438;
        Wed, 25 Nov 2020 03:11:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLESD/hc0TdN56KT2ZOsOXUCyIaMPyqp0nL8QUe3KTnaZeRRwysmWPTFkYs0uHnQfXt0epDw==
X-Received: by 2002:a17:906:ad85:: with SMTP id la5mr2687446ejb.423.1606302695108;
        Wed, 25 Nov 2020 03:11:35 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id g20sm1085726ejk.3.2020.11.25.03.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 03:11:34 -0800 (PST)
Subject: Re: [PATCH 2/3] iio: accel: bmc150: Check for a second ACPI device
 for BOSC0200
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20201125083618.10989-1-hdegoede@redhat.com>
 <20201125083618.10989-3-hdegoede@redhat.com>
 <CAHp75VcZQ1duxHnUTD9ewRhWxoHay8S6AQaEK3v3jJr+oQcbDw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ee0d26b1-ee54-0c2c-cd9f-40366e3b10d4@redhat.com>
Date:   Wed, 25 Nov 2020 12:11:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcZQ1duxHnUTD9ewRhWxoHay8S6AQaEK3v3jJr+oQcbDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/25/20 11:55 AM, Andy Shevchenko wrote:
> On Wed, Nov 25, 2020 at 10:37 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> From: Jeremy Cline <jeremy@jcline.org>
>>
>> Some BOSC0200 acpi_device-s describe two accelerometers in a single ACPI
>> device. Normally we would handle this by letting the special
>> drivers/platform/x86/i2c-multi-instantiate.c driver handle the BOSC0200
>> ACPI id and let it instantiate 2 bmc150_accel type i2c_client-s for us.
>>
>> But doing so changes the modalias for the first accelerometer
>> (which is already supported and used on many devices) from
>> acpi:BOSC0200 to i2c:bmc150_accel. The modalias is not only used
>> to load the driver, but is also used by hwdb matches in
>> /lib/udev/hwdb.d/60-sensor.hwdb which provide a mountmatrix to
>> userspace by setting the ACCEL_MOUNT_MATRIX udev property.
>>
>> Switching the handling of the BOSC0200 over to i2c-multi-instantiate.c
>> will break the hwdb matches causing the ACCEL_MOUNT_MATRIX udev prop
>> to no longer be set. So switching over to i2c-multi-instantiate.c is
>> not an option.
> 
> I'm wondering if we can meanwhile update hwdb to support
> i2c-multi-instantiate cases in the future and in a few years switch to
> it.

Even if we fix current hwdb entries to match on both, then there
is no guarantee newly added entries will also contain the new match.

Now with the code to get the matrix from the ACPI tables new entries
should happen less often, but I saw at least one model where the ACPI
provided matrix appears to be wrong (if the ACPI matrix was always
correct then breaking hwdb would not really be an issue).

So I don't think this is going to work and all in all it feels like
a lot of work for little gain.


>> Changes by Hans de Goede:
>> -Add explanation to the commit message why i2c-multi-instantiate.c
>>  cannot be used
>> -Also set the dev_name, fwnode and irq i2c_board_info struct members
>>  for the 2nd client
> 
> ...
> 
>> +       ret = bmc150_accel_core_probe(&client->dev, regmap, client->irq, name, block_supported);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /*
>> +        * Some BOSC0200 acpi_devices describe 2 accelerometers in a single ACPI
>> +        * device, try instantiating a second i2c_client for an I2cSerialBusV2
>> +        * ACPI resource with index 1. The !id check avoids recursion when
>> +        * bmc150_accel_probe() gets called for the second client.
>> +        */
> 
>> +       if (!id && adev && strcmp(acpi_device_hid(adev), "BOSC0200") == 0) {
> 
>> +               struct i2c_board_info board_info = {
>> +                       .type = "bmc150_accel",
>> +                       /* The 2nd accel sits in the base of 2-in-1s */
> 
>> +                       .dev_name = "BOSC0200:base",
> 
> Hmm... Can we use '.' (dot) rather than ':' (colon) to avoid confusion
> with ACPI device naming schema? (Or was it on purpose?)

So with the ':' the end result is:

[root@localhost ~]# cd /sys/bus/i2c/devices/
[root@localhost devices]# ls | cat
6-0050
i2c-0
i2c-1
i2c-2
i2c-3
i2c-4
i2c-5
i2c-6
i2c-BOSC0200:00
i2c-BOSC0200:base
i2c-WCOM50BD:00

Which looks nice and consistent, which is why I went with the ':'
and since base is not a number, there is no chance on conflicting with
ACPI device names (it does look somewhat like an ACPI device name, but
it is an ACPI enumerated device, so ...).

Anyways if there is a strong preference for changing this to a '.'
I would be happy to make this change.

> And this seems to be the only device in the system, second as this is
> not allowed as far as I understand. Right?

I don't understand what you are trying to say here, sorry.

> But theoretically I can
> create an ACPI SSDT with quite similar excerpt and sensor and
> enumerate it via ConfigFS (I understand that is quite unlikely).


> 
>> +                       .fwnode = client->dev.fwnode,
>> +                       .irq = -ENOENT,
>> +               };
>> +               struct i2c_client *second_dev;
>> +
>> +               second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
>> +               if (!IS_ERR(second_dev))
>> +                       bmc150_set_second_device(second_dev);
>> +       }
> 
> ...
> 
>>  static int bmc150_accel_remove(struct i2c_client *client)
>>  {
>> +       struct i2c_client *second_dev = bmc150_get_second_device(client);
> 
>> +       if (second_dev)
> 
> Redundant.

True, I will fix this for v2, once the ':' vs '.' thing is settled.

Regards,

Hans



> 
>> +               i2c_unregister_device(second_dev);
>> +
>>         return bmc150_accel_core_remove(&client->dev);
>>  }
> 

