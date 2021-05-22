Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB0238D719
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 21:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhEVTEY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 15:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231376AbhEVTEY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 May 2021 15:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621710178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYdRGNdgyQ77jFt5KAhRgCs8M38rfYVJr2I7i5lsq3I=;
        b=B1BKaAE0hARA06Uuy6vGsi0TxDPcoKT4gQzABpmtJC9aPRZcoACYjosRJ0Kbp7+PTv2Zys
        Lv93e41iOpOWqCTa1brMrPgqgk4vIB/FVO2WrDVbZ/2yv2USDMzDvTC9vMlBmp7bpa5Isi
        Y+UHi6iBa2QyGhUyYqr4dVYhiPK0IcM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-kWdaYi1yNN-EhRRQiwPeEg-1; Sat, 22 May 2021 15:02:55 -0400
X-MC-Unique: kWdaYi1yNN-EhRRQiwPeEg-1
Received: by mail-ed1-f69.google.com with SMTP id ba15-20020a0564021acfb029038d3b33d7ffso10582799edb.23
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 12:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JYdRGNdgyQ77jFt5KAhRgCs8M38rfYVJr2I7i5lsq3I=;
        b=MdArY1nNNqPaX1zqDgacUSjjYYgyPSn1zgqHBKUDzkxV4LCS2Kcq6LgN5to0dqjh98
         OB7reCHVefTVrbG2jSSuOGkBU/x3uG8Md7N9OoJIohpiUnXTaOiItj6R7NNRe2vjy4ia
         cq6qM5A8xqbZcTlk1r8FFC09re8YrtNnZv5uttT0QxQEKiUL3QUxiU1aKbXK/h+EQDI7
         Gdfj4F+L2XPR4Ozl4JqTA7pQSUGryoU/28ikbWxN7S2avM8ygB87ypfogRkM3yeJ+nCq
         2ipP9a8uF+pmklErguaU3/LLalsYml6mdFy1J3/o9BmDqXLmrWFdbHoL6GLgCaz/UPBk
         lezA==
X-Gm-Message-State: AOAM531lPcXHc6MW/btBxAvTvYnmAyMOfY4whsAIDGiHc/wOE/L5lr3J
        ETXd/sEv8YzLHvqH4JnX5mhjRLpCNyrx6UU/wxuMnB1dWBpnElW2x/mWwbTbSZJPL6SI69O9+Z3
        lMACyAY+lX6aB+WJZQs6U
X-Received: by 2002:a17:906:6ad0:: with SMTP id q16mr16329334ejs.286.1621710174295;
        Sat, 22 May 2021 12:02:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4kOKPXYvDMx5F7qSOWZORnK/15eAZYq6RX3yuds6Pp+SOA1erE7zFy/wnOWcgm79SqSVgMA==
X-Received: by 2002:a17:906:6ad0:: with SMTP id q16mr16329321ejs.286.1621710174151;
        Sat, 22 May 2021 12:02:54 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r2sm5603281ejc.78.2021.05.22.12.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 12:02:53 -0700 (PDT)
Subject: Re: [PATCH 7/8] iio: accel: bmc150: Add support for DUAL250E ACPI DSM
 for setting the hinge angle
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20210521171418.393871-1-hdegoede@redhat.com>
 <20210521171418.393871-8-hdegoede@redhat.com>
 <CAHp75VdAC9nP5EyCCMZ41vmSsZoV8gPOMxOkY=U4gVm5dQAXCg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c53e13fc-d12d-aa5c-ba06-757fc58d2f1f@redhat.com>
Date:   Sat, 22 May 2021 21:02:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VdAC9nP5EyCCMZ41vmSsZoV8gPOMxOkY=U4gVm5dQAXCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/22/21 8:21 PM, Andy Shevchenko wrote:
> On Fri, May 21, 2021 at 11:22 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Some 360 degree hinges (yoga) style 2-in-1 devices use 2 bmc150 accels
>> to allow the OS to determine the angle between the display and the base
>> of the device, so that the OS can determine if the 2-in-1 is in laptop
>> or in tablet-mode.
>>
>> On Windows both accelerometers are read (polled) by a special service
>> and this service calls the DSM (Device Specific Method), which in turn
>> translates the angles to one of laptop/tablet/tent/stand mode and then
>> notifies the EC about the new mode and the EC then enables or disables
>> the builtin keyboard and touchpad based in the mode.
>>
>> When the 2-in-1 is powered-on or resumed folded in tablet mode the
>> EC senses this independent of the DSM by using a HALL effect sensor
>> which senses that the keyboard has been folded away behind the display.
>>
>> At power-on or resume the EC disables the keyboard based on this and
>> the only way to get the keyboard to work after this is to call the
>> DSM to re-enable it.
>>
>> Call the DSM on probe() and resume() to fix the keyboard not working
>> when powered-on / resumed in tablet-mode.
>>
>> This patch was developed and tested on a Lenovo Yoga 300-IBR.
> 
> ...
> 
>> +       if (strcmp(acpi_device_hid(adev), "DUAL250E"))
> 
> Can we use like in the other case in this series the acpi_dev_hid_uid_match() ?

I agree that that would be more consistent, I'll fix this for 2.


> Because it's actually what you are doing here and it may be better to
> see the same approach for this HID done in different places in the
> code to recognize what it is about.
> 
>> +               return false;
> 
> ...
> 
>> +       /*
>> +        * The EC must see a change for it to re-enable the kbd, so first set the
>> +        * angle to 270° (tent/stand mode) and then change it to 90° (laptop mode).
>> +        */
>> +       if (!bmc150_acpi_set_angle_dsm(client, 0, 270))
>> +               return false;
> 
>> +       /* The EC needs some time to notice the angle being changed */
>> +       msleep(100);
> 
> I feel that you conducted a research and answer to the following will
> be no, but...
> 
> Do we have any means of polling something (embedded controller / ASL /
> etc) to actually see the ACK for the action?

Nope, there is nothing to poll and I tried shorter time-outs and that
lead to the EC sometimes not seeing the change.

> 
>> +       return bmc150_acpi_set_angle_dsm(client, 0, 90);
> 
> ...
> 
>> +       schedule_delayed_work(&data->resume_work, msecs_to_jiffies(1000));
> 
> Isn't it the same as 1 * HZ ?

Yes, but this makes it clearer that the delay is 1 second, IMHO using n * HZ
is harder to read / reason about then having the delay right there in msecs.
This also means less churn if it needs to change to a different amount of msecs
later.

Regards,

Hans

