Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513142C3E8D
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 11:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgKYKzx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 05:55:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbgKYKzw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 05:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606301750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+8x7XE97QW3n9DknNbLk/Arhz4XAVQVyo6aAqj2cUOQ=;
        b=C0OUw4Ib/M+oh25ZtQesC0GF9HdkcCRelo3KzCa0jy1BgKv8AgFjGIlzB+0MzLfJRcfgMf
        rJYFO6wxj5u7RzZnlm8mXUOYrmXLLWLoJ9MP6AbKnernLwHqgbR7sh4vl8Enexj6bYis9Q
        Fon3Ian9HEOnpIjA4TFp0zAsPgi1LQo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-CtKuyWG6PBevgLdeiToqzA-1; Wed, 25 Nov 2020 05:55:48 -0500
X-MC-Unique: CtKuyWG6PBevgLdeiToqzA-1
Received: by mail-ed1-f72.google.com with SMTP id c23so498267edr.4
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 02:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+8x7XE97QW3n9DknNbLk/Arhz4XAVQVyo6aAqj2cUOQ=;
        b=Fxlt3gyvcyfG4wZhTgubuLhKpa0FCRVAJfh6WZ1NUvNV/3Igy0heALXPgpCCv+yzY2
         wrGInX8Zg9M4mf/5x7AF5RyoL9bJ3eU6A5lbt7C369ElcHbqJpf4o15MxJBWFr2kdW3W
         hhChKFhNQ6SwF3nZJXGtDVcExofj8rVsIHJHdFcGYWUh4eTsBvJTwNBiVPZb9lVK/qeJ
         rTB0Cqg7w217Wve5Jh+26seb0IiXAJ9u8nRDwBHNGpG8/1UoM6nmEPEnPAxjexC8mY1f
         mlpi9njLoiJodDIzhfOYApEWycR9qAtiW9JCqsKHv8NsVG4ecRrrstUrqMKPabk09She
         WhUg==
X-Gm-Message-State: AOAM533bgY1efIGt7n1BbaRWO4a4Fm6Nnw11MW7ochKGpjz/kyfTjR6C
        FdN9+MLAjnIxt+JLe3+5BB7plm3AsQ3V7yg4+qwzXoVu3Zaa+TwrW0x/HjXy7uBXojI2IblcEDr
        l+LUK0k5w1g2ejPxx+1Nc
X-Received: by 2002:a17:906:4057:: with SMTP id y23mr2404480ejj.299.1606301747427;
        Wed, 25 Nov 2020 02:55:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYFuP3Pc3WXUpTeH+Jh1woi00wR+bUfoU/Lzxg2Gt6pIQWgqF5G3JWqzTmGTmr0AAtde7T6Q==
X-Received: by 2002:a17:906:4057:: with SMTP id y23mr2404469ejj.299.1606301747214;
        Wed, 25 Nov 2020 02:55:47 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id n15sm1049205eje.112.2020.11.25.02.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 02:55:46 -0800 (PST)
Subject: Re: [PATCH] iio: accel: kxcjk1013: Add tablet_mode sysfs file for
 exercising the KIOX010A ACPI DSM
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        russianneuromancer <russianneuromancer@ya.ru>
References: <20201125085444.11593-1-hdegoede@redhat.com>
 <20201125085444.11593-2-hdegoede@redhat.com>
 <CAHp75VfMxzO2Qx_t7mSv+Y_DEN8Y2KYw02No=y=VuBNACtj4zg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <94522440-5842-4527-f14e-e02462272611@redhat.com>
Date:   Wed, 25 Nov 2020 11:55:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfMxzO2Qx_t7mSv+Y_DEN8Y2KYw02No=y=VuBNACtj4zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/25/20 11:34 AM, Andy Shevchenko wrote:
> On Wed, Nov 25, 2020 at 10:56 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Some 360 degree hinges (yoga) style 2-in-1 devices use 2 KXCJ91008-s
>> to allow the OS to determine the angle between the display and the base
>> of the device, so that the OS can determine if the 2-in-1 is in laptop
>> or in tablet-mode.
>>
>> On Windows both accelerometers are read by a special HingeAngleService
>> process; and this process calls a DSM (Device Specific Method) on the
>> ACPI KIOX010A device node for the sensor in the display, to let the
>> embedded-controller (EC) know about the mode so that it can disable the
>> kbd and touchpad to avoid spurious input while folded into tablet-mode.
>>
>> Currently the kxcjk1013 driver calls the DSM for this once at probe time
>> to ensure that the builtin kbd and touchpad work.
>>
>> But some users have expressed interest in using this functionality to
>> disable the kbd and touchpad when folded into tablet-mode as done under
>> Windows.
>>
>> Add a tablet_mode sysfs file so that users can control the kbd/touchpad
>> enable/disable functionality from user-space.
> 
> ...
> 
>> +       err = kiox010a_dsm(&data->client->dev,
>> +                          tablet_mode ? KIOX010A_SET_TABLET_MODE :
>> +                                        KIOX010A_SET_LAPTOP_MODE);
> 
> A nit. With temporary variable it may be slightly better to read, like:
> 
>   int value;
>   ...
>   value = tablet_mode ? KIOX010A_SET_TABLET_MODE : KIOX010A_SET_LAPTOP_MODE);
>   err = kiox010a_dsm(&data->client->dev, value);

I'm fine with either solution, Jonathan let me know if you want a v2 with
Andy's suggestion implemented (assuming you are willing to take this at all).

> 
>> +       if (err)
>> +               return err;
> 
> ...
> 
>> +               ret = devm_device_add_group(&data->client->dev, &tablet_mode_attrs_group);
>> +               if (ret < 0)
>> +                       dev_warn(&data->client->dev, "Error creating tablet_mode sysfs attribute\n");
> 
> devm is a beast (sometimes). Just to make sure that on removal you
> won't have situation when attribute is still there while data it's
> accessing to are already gone or garbage.

The main data struct is also devm managed and allocated earlier, so this is not an issue
here.

Regards,

Hans

