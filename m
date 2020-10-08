Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D49286F03
	for <lists+linux-iio@lfdr.de>; Thu,  8 Oct 2020 09:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgJHHKZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Oct 2020 03:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40211 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbgJHHKZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Oct 2020 03:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602141024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SX5UG7zGIzMe4tA1Jccg+gS8miA3mGapOr9ZUMpfB14=;
        b=fvNlf6JZ9fbdOW/3oQ2jwI9Rq75UB/cFjhDzZvsIoEwLO2WvQ/TLV6keZLEghOK6l+wqgO
        MrylnP+oIA9Xn8cCYIABcz82lJ4pj68/Z4LeauR9xu18MelBVCrRjjomHWAdMP1UjR1gUF
        FCcSrr5PKjDjctocawueZKEjQ59uMAE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-vfzRHlTRMAyi1KGLyWlcOQ-1; Thu, 08 Oct 2020 03:10:22 -0400
X-MC-Unique: vfzRHlTRMAyi1KGLyWlcOQ-1
Received: by mail-ed1-f70.google.com with SMTP id n19so1822679eds.8
        for <linux-iio@vger.kernel.org>; Thu, 08 Oct 2020 00:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SX5UG7zGIzMe4tA1Jccg+gS8miA3mGapOr9ZUMpfB14=;
        b=feX94m8i/VdH5lSm9ZMPNf0D1WdUSjtlg4uqmVfQcFZUcUxN9RHS6IEXUu1orkHvMO
         iH6JZNyseu9WQsZInj6wk7lLvTP6PadahfVzCViP31ogt7qgyZ2W1gTEAHc5nZXf4zwg
         296bZLJ0gFDpPdgvLhagkQHbj7tdprwtGbCHs7uCXanhXiok6EeT79ghg0VKt3KpJmOe
         Qz/T64LKu6TRUdHI7ywIKsh5MHht5I75H9OdUehlJGbioj6in9GXLhDWKx+ID87aMYL8
         AaMsI2Lj6BDG0VouGEpEU0GH3ZW/CZhswP4PHcb1h8dDpbhPYkyn9ZLYKS5HE+bMcT0h
         +9qg==
X-Gm-Message-State: AOAM531FIMxtw0OVsRV8Q5oNY3JjECHoGp4/Q756JeCBC3QI877LmxJy
        d9o33oHCnxb7a+6wP/GMCQZm8kva1s2qhCoT464LghG4ofDDsaqZQWSuFc1gr+CjRL/FKuGDk+J
        ujFBY3fcFB9JMPA85ajT0
X-Received: by 2002:a50:ef0e:: with SMTP id m14mr7503800eds.5.1602141020935;
        Thu, 08 Oct 2020 00:10:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyB1klR20qsslQUJLaw02T0uqMrQljFTB8RV/i3/781a1Zl05V3aSnIYJy01X6wjkNQy5qm2w==
X-Received: by 2002:a50:ef0e:: with SMTP id m14mr7503779eds.5.1602141020689;
        Thu, 08 Oct 2020 00:10:20 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id i14sm3385412ejp.2.2020.10.08.00.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 00:10:20 -0700 (PDT)
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-iio@vger.kernel.org, Nitin Joshi1 <njoshi1@lenovo.com>,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
 <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
 <20201007083602.00006b7e@Huawei.com>
 <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
 <b400b6956270a2433373dd6cbdae3332aa683f4f.camel@hadess.net>
 <cadabe4d-7cce-281e-75fe-fcc2099848da@redhat.com>
 <5273a1de9db682cd41e58553fe57707c492a53b7.camel@hadess.net>
 <272074b5-b28e-1b74-8574-3dc2d614269a@redhat.com>
 <20201008001424.GA3713@labundy.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9893a32c-02c8-f00c-7f00-6287d55043ab@redhat.com>
Date:   Thu, 8 Oct 2020 09:10:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008001424.GA3713@labundy.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 10/8/20 2:14 AM, Jeff LaBundy wrote:
> Hi all,
> 
> On Wed, Oct 07, 2020 at 03:32:07PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 10/7/20 3:29 PM, Bastien Nocera wrote:
>>> On Wed, 2020-10-07 at 15:08 +0200, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 10/7/20 1:35 PM, Bastien Nocera wrote:
>>>>> On Wed, 2020-10-07 at 11:51 +0200, Hans de Goede wrote:
>>>>>> <snip>
>>>>>>> Dmitry, any existing stuff like this in input?
> 
> It seems we are talking about "specific absorption rate" (SAR) type
> devices that signal the WLAN controller to reduce transmitted power
> while a user is nearby.

Yes and no. At least the lap-mode detection (laptop on someones
lap rather then sitting on a table) is currently used by the
embedded-controller for thermal management decisions, basically
when on someones lap the configurable TPD of the CPU is set lower
to keep the laptop's bottom skin temperate < 45 degrees Celsius
(I think it is 45 but the exact number does not matter).

The lap-mode info is currently exported with a thinkpad_acpi specific
sysfs attribute with the idea that userspace could potentially use
this to indicate to the user that turbo clocks will be lower
because of this.

With upcoming WLAN cards with configurable transmit power,
this will also be used as what you call a SAR device.

AFAIK the palmrest case is mostly a SAR device.

Note I'm explaining the alternative lap-mode use-case to make
sure everyone is on the same page. I completely agree with the
gist of your email :)

> I just wanted to chime in and confirm that we do have at least one
> precedent for these being in input (keyboard/iqs62x-keys) and not
> iio so I agree with Jonathan here. My argument is that we want to
> signal binary events (user grabbed onto or let go of the handset)
> rather than deliver continuous data.

I was curious what keycode you are using for this, but I see
that the keycodes come from devicetree, so I guess I should
just ask: what keycode are you using for this ?

> The example I've shown reports events as keycodes since some of the
> events it can express represent momentary conditions. In hindsight,
> however, an argument can be made to express some of this information
> as a switch (user is or is not near the device) and the new event
> codes proposed here seem like a step in the right direction.

I'm glad that you like the new proposed switch event-codes.

Regards,

Hans

