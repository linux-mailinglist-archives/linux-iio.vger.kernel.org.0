Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AF3285C1A
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 11:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgJGJvN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Oct 2020 05:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727103AbgJGJvN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Oct 2020 05:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602064270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m958hudxx49m0O7P9c8/mOazvI4QqEIilIX/pUlyaVg=;
        b=FKreiwKCzrmFn763RL9UR9ejq+MhqJymPXzzQv10tct3ZXK6frCJJ14yfi04IP6fVadm3j
        b9ejzWAvwRXLlL43sSpNrKoDlqipbxJXBQmQvHKXnhi8B5BBT4TxfOzcWrhsEhf5NTp45X
        YpReJl47trY6F2CHXPjWgR5KcBQH1JU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-MveTAstLOYycztEbTXcdRA-1; Wed, 07 Oct 2020 05:51:09 -0400
X-MC-Unique: MveTAstLOYycztEbTXcdRA-1
Received: by mail-ed1-f72.google.com with SMTP id o24so668345edz.11
        for <linux-iio@vger.kernel.org>; Wed, 07 Oct 2020 02:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m958hudxx49m0O7P9c8/mOazvI4QqEIilIX/pUlyaVg=;
        b=RM3DQatxZb/ZeWGdwF7vRbfk5nn+297ZiCqgEwmhnU7vb6KgXGPHvlaYioGsorisgx
         8guRXoHvYAqbOUhX/qUf1oDrBE1nzdMCfUy0EpA7RNQ8FnF5Z701d5rb2WxFDwRoCIC9
         cvTujrFTAeS1iyp6SK69aN3zWoFCSNclKXEkC3gUpIPCWTcC5ZBz8umEaeTg5xQ546/C
         a0zX2bR1grnoJGLn8mxRz9byJAQltJL+YSGOHtBWk0iPzOPBeETcCDK5Are8/8eUdLF8
         tcvioc6IDC2CgPXzDePupu1JyNQ9r3eaiHORplR4orkgkK8uT2rKnUiJJkOgeMw5H4Ip
         //kg==
X-Gm-Message-State: AOAM530899CRH/F7wTAijZiVF7iEO+iO7z4zJ3huquIgVGaIYwx/Mh3N
        5FTR8R9Y9a1le3CJSI1CqyFAOyHOyOomDDk2STgiMhqNbvpcOBf7XHgrBW/lY/98eze2SraWw2M
        RMSdZOFYdO/ee1YwWl1Ut
X-Received: by 2002:a05:6402:5:: with SMTP id d5mr2582007edu.376.1602064267523;
        Wed, 07 Oct 2020 02:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9NJlEjarv3RRToDiEiyDmwC3/G6oLV+2ggZZc1Xjx2AMv4YfFGhdXAM+MslCGsi6SS3OVGg==
X-Received: by 2002:a05:6402:5:: with SMTP id d5mr2581988edu.376.1602064267235;
        Wed, 07 Oct 2020 02:51:07 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id m19sm1122931ejj.91.2020.10.07.02.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 02:51:06 -0700 (PDT)
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     linux-iio@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Nitin Joshi1 <njoshi1@lenovo.com>, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
 <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
 <20201007083602.00006b7e@Huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
Date:   Wed, 7 Oct 2020 11:51:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007083602.00006b7e@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 10/7/20 10:36 AM, Jonathan Cameron wrote:
> On Mon, 5 Oct 2020 22:04:27 -0400
> Mark Pearson <markpearson@lenovo.com> wrote:
> 
>> Adding Nitin, lead for this feature, to the thread
> 
> +CC linux-input and Dmitry for reasons that will become clear below.
>>
>> On 2020-10-03 10:02 a.m., Hans de Goede wrote:
>>> Hi All,
>>>
>>> Modern laptops can have various sensors which are kinda
>>> like proximity sensors, but not really (they are more
>>> specific in which part of the laptop the user is
>>> proximate to).
>>>
>>> Specifically modern Thinkpad's have 2 readings which we
>>> want to export to userspace, and I'm wondering if we
>>> could use the IIO framework for this since these readings
>>> are in essence sensor readings:
>>>
>>> 1. These laptops have a sensor in the palm-rests to
>>> check if a user is physically proximate to the device's
>>> palm-rests. This info will be used by userspace for WWAN
>>> functionality to control the transmission level safely.
>>>
>>> A patch adding a thinkpad_acpi specific sysfs API for this
>>> is currently pending:
>>> https://patchwork.kernel.org/patch/11722127/
>>>
>>> But I'm wondering if it would not be better to use
>>> IIO to export this info.
> 
> My first thought on this is it sounds more like a key than a sensor
> (simple proximity sensors fall into this category as well.)

That is an interesting suggestion. Using the input/evdev API
would have some advantages such as being able to have a single
event node for all the proximity switches and then being able
to pass a fd to that from a privileged process to a non
privileged one, something which userspace already has
various infrastructure for.

So yes this might indeed be better. Dmitry any thoughts on
this / objections against using the input/evdev API for this?

Note: s/key/switch/ in "sounds more like a key" above I guess.

> Dmitry, any existing stuff like this in input?

There already is a SW_FRONT_PROXIMITY defined in
input-event-codes.h, which I guess means detection if
someone is sitting in front of the screen. So we could add:

SW_LAP_PROXIMITY
SW_PALMREST_PROXIMITY,

And then we have a pretty decent API for this I think.

> If it does make sense to put it in IIO then rest of the questions
> obviously relevant.

Ack, thank you for your input.

Regards,

Hans





>>> 2. These laptops have something called lap-mode, which
>>> determines if the laptop's firmware thinks that it is on
>>> a users lap, or sitting on a table. This influences the
>>> max. allowed skin-temperature of the bottom of the laptop
>>> and thus influences thermal management.  Like the palm-rest
>>> snesors, this reading will likely also be used for
>>> controlling wireless transmission levels in the future.
>>>
>>> Note that AFAIK the lap_mode reading is not a single sensor
>>> reading, it is a value derived from a bunch of sensor readings,
>>> the raw values of which may or may not be available
>>> separately.
>>>
>>> So looking at existing IIO userspace API docs, focussing on
>>> proximity sensors I see:
>>>
>>> Documentation/ABI/testing/sysfs-bus-iio
>>> Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
>>>
>>> Where the latter seems to not really be relevant.
> 
> Indeed, that one is a very odd beast :) (lightning sensor)
> 
>>>
>>>   From the generic IO API doc, this bit is the most
>>> interesting:
>>>
>>> What:           /sys/.../iio:deviceX/in_proximity_raw
>>> What:           /sys/.../iio:deviceX/in_proximity_input
>>> What:           /sys/.../iio:deviceX/in_proximityY_raw
>>> KernelVersion:  3.4
>>> Contact:        linux-iio@vger.kernel.org
>>> Description:
>>>                   Proximity measurement indicating that some
>>>                   object is near the sensor, usually by observing
>>>                   reflectivity of infrared or ultrasound emitted.
>>>                   Often these sensors are unit less and as such conversion
>>>                   to SI units is not possible. Higher proximity measurements
>>>                   indicate closer objects, and vice versa. Units after
>>>                   application of scale and offset are meters.
>>>
>>> This seems to be a reasonable match for the Thinkpad sensors
>>> we are discussing here, although those report a simple
>>> 0/1 value.
> 
> Given this is a bit of computed estimate rather than a true reading, I wonder
> a bit if we should treat it as closer to an 'activity classification sensor'.
> 
> For those we use a percentage value to represent the output of some probabilistic
> classifier.  In reality all the versions we've had so far aren't that clever though
> so they only output 0 or 100%.  See in_activity_walking_input in the docs for
> example.
> 
>>>
>>> What is missing for the ThinkPad case is something like this:
>>>
>>> What:        /sys/.../iio:deviceX/proximity_sensor_location
>>> KernelVersion:  5.11
>>> Contact:        linux-iio@vger.kernel.org
>>> Description:
>>>           Specifies the location of the proximity sensor /
>>>           specifies proximity to what the sensor is measuring.
>>>           Reading this file returns a string describing this, valid values
>>>           for this string are: "screen", "lap", "palmrest"
>>>           Note the list of valid values may be extended in the
>>>           future.
>>>
>>> So what do you (IIO devs) think about this?
>>>
>>> Would adding a proximity_sensor_location attribute be a reasonable
>>> thing to do for this; and do you think that this would be a good idea ?
> 
> Absolutely fine.  There is precedence in cros_ec which has a generic
> location sysfs attribute (not associated with a particular channel though
> it is fine to do that as well). See Documentation/ABI/testing/sysfs-bus-iio-cros_ec
> We haven't moved it to the general docs because there is only one device
> providing it so far.  Hence we would move it with the introduction of
> this second device.
> 
>>>
>>> Regards,
>>>
>>> Hans
>>>    
> 
> 

