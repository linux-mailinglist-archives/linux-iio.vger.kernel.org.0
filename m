Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1502A2C520B
	for <lists+linux-iio@lfdr.de>; Thu, 26 Nov 2020 11:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbgKZKae (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Nov 2020 05:30:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727427AbgKZKad (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Nov 2020 05:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606386631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gmBEtLHpK3WFYus9ag1PvMif0JEi5rf9R4FrERMhRb8=;
        b=Akm40MK0mDMORG4+Dy7oBfn/uT2kbwzumidkuZ9E+i69FK93F08B/hlT6CSOZQL0Uk9JNf
        BqyH+S7HeX7vadAdw/5hdt6XevPf0clDhoXccmOJh6QPK+b16WXdmaAtm2t1aPN50HmZG+
        KF8Mtq9UYVhWGLOTvhmMsgKyPmUnUHs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-mB_mFA0WPIK1R74wsRV7dA-1; Thu, 26 Nov 2020 05:30:26 -0500
X-MC-Unique: mB_mFA0WPIK1R74wsRV7dA-1
Received: by mail-ej1-f69.google.com with SMTP id yc22so641693ejb.20
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2020 02:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gmBEtLHpK3WFYus9ag1PvMif0JEi5rf9R4FrERMhRb8=;
        b=MEV2BlgeYrJwxYWsmUxRLWV/msNfeP3MJ05ufI24vD36jvx04gWKccaaxgeCEwt6nT
         ELcKBlUZTVHaqGe2EI22vX7zwRg2P9TVMfGJh93Kw5QUOCsmGz7JDyPOFD5zT3NS3CFZ
         pEiyzB3N3CD6b6Tz4hAsTyCJ+Olg/Er7YZouulCRWB99aevcw7axCpCYk/LUtFbHztGq
         oyn33LbHG6qWWQF+j6vsYg8oJGEctsYtjRSQ2L14Lk9XzQrliNKJhXy2Sgyd9TtnJuGB
         m3QC9f066s3y/lIRpQMilJa0ZgxqmysZinh6iuJ5PwIY8QHhGABryvSUIclAPRFwNG14
         IUwg==
X-Gm-Message-State: AOAM532rgay2LqnCGOv1LnwdnqM/1cZoSveSz7Ly4X7CgUgpLiepOvQX
        XSUVkdpBPUP4L+ORkxXe0vSz2A9qZVq5HckZmueRVnytQ/lDjErA0fWy865/oLXJCi5mWWnJSBi
        6uhPh5W5AY0Tps1YnLxg5
X-Received: by 2002:a05:6402:491:: with SMTP id k17mr1899175edv.370.1606386625019;
        Thu, 26 Nov 2020 02:30:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx15BzesrKzYLqKbp7Db3yySqVJxfuwlZaDi+Ev1kHA9wWohm2SN+WVkZwIU8YgiRCslzVxFQ==
X-Received: by 2002:a05:6402:491:: with SMTP id k17mr1899151edv.370.1606386624785;
        Thu, 26 Nov 2020 02:30:24 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id pk19sm496616ejb.32.2020.11.26.02.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 02:30:23 -0800 (PST)
Subject: Re: [PATCH] iio: accel: kxcjk1013: Add tablet_mode sysfs file for
 exercising the KIOX010A ACPI DSM
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        russianneuromancer <russianneuromancer@ya.ru>
References: <20201125085444.11593-1-hdegoede@redhat.com>
 <20201125085444.11593-2-hdegoede@redhat.com>
 <CAHp75VfMxzO2Qx_t7mSv+Y_DEN8Y2KYw02No=y=VuBNACtj4zg@mail.gmail.com>
 <94522440-5842-4527-f14e-e02462272611@redhat.com>
 <20201125184824.2052d6aa@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1cf7d44c-832c-a62b-da4e-1df3a95610da@redhat.com>
Date:   Thu, 26 Nov 2020 11:30:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125184824.2052d6aa@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/25/20 7:48 PM, Jonathan Cameron wrote:
> On Wed, 25 Nov 2020 11:55:45 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi,
>>
>> On 11/25/20 11:34 AM, Andy Shevchenko wrote:
>>> On Wed, Nov 25, 2020 at 10:56 AM Hans de Goede <hdegoede@redhat.com> wrote:  
>>>>
>>>> Some 360 degree hinges (yoga) style 2-in-1 devices use 2 KXCJ91008-s
>>>> to allow the OS to determine the angle between the display and the base
>>>> of the device, so that the OS can determine if the 2-in-1 is in laptop
>>>> or in tablet-mode.
>>>>
>>>> On Windows both accelerometers are read by a special HingeAngleService
>>>> process; and this process calls a DSM (Device Specific Method) on the
>>>> ACPI KIOX010A device node for the sensor in the display, to let the
>>>> embedded-controller (EC) know about the mode so that it can disable the
>>>> kbd and touchpad to avoid spurious input while folded into tablet-mode.
>>>>
>>>> Currently the kxcjk1013 driver calls the DSM for this once at probe time
>>>> to ensure that the builtin kbd and touchpad work.
>>>>
>>>> But some users have expressed interest in using this functionality to
>>>> disable the kbd and touchpad when folded into tablet-mode as done under
>>>> Windows.
>>>>
>>>> Add a tablet_mode sysfs file so that users can control the kbd/touchpad
>>>> enable/disable functionality from user-space.  
> 
> Biggest thing missing here is documentation.
> 
> Documentation/ABI/testing/sysfs-bus-iio-kxcjk1013

Erm, as I explained in the cover letter this new sysfs attribute sits below

/sys/bus/i2c/devices/KIOX010A:00/

So thew new file is:

/sys/bus/i2c/devices/KIOX010A:00/tablet_mode

IOW it does NOT sit below:

/sys/bus/iio/devices/iio-device1

I did this deliberately so that it is in no way part of the IIO userspace-API
(where it does not belong).

I did have it as part of the IIO userspace API before, that is one of
the reasons why I wrote the:
"iio: core: Copy iio_info.attrs->is_visible into iio_dev_opaque.chan_attr_group.is_visible"

Patch so that I could only make it show up in the KIOX010A case without needing
to duplicate the structures describing the IIO channels. But just not putting
it in the IIO "namespace" at all seemed cleaner, so I eventually went with
that as solution.  And I still believe that having this under the i2c-device
rather then under the iio-device is the right thing to do, but I'm open to
changing that.

I guess I could still try to document it somewhere, but with the scheme
which I chose there really isn't a vert good place to document this...

> Unless this is documented somewhere else?  I've no idea if there is any
> precedence for this/

There is plenty of precedence for adhoc driver specific sysfs attributes
being added to the (parent) device, but these tend to not be documented
(which I must admit is kinda bad).

> 
>>>
>>> ...
>>>   
>>>> +       err = kiox010a_dsm(&data->client->dev,
>>>> +                          tablet_mode ? KIOX010A_SET_TABLET_MODE :
>>>> +                                        KIOX010A_SET_LAPTOP_MODE);  
>>>
>>> A nit. With temporary variable it may be slightly better to read, like:
>>>
>>>   int value;
>>>   ...
>>>   value = tablet_mode ? KIOX010A_SET_TABLET_MODE : KIOX010A_SET_LAPTOP_MODE);
>>>   err = kiox010a_dsm(&data->client->dev, value);  
>>
>> I'm fine with either solution, Jonathan let me know if you want a v2 with
>> Andy's suggestion implemented (assuming you are willing to take this at all).
> 
> Prefer Andy's suggestion slightly seeing as you are going around again to
> include some docs :)

Ok, I'll change this for v2 once we have the other bits figured out.

Regards,

Hans

