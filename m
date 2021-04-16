Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA74361E7A
	for <lists+linux-iio@lfdr.de>; Fri, 16 Apr 2021 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbhDPLO0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Apr 2021 07:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235011AbhDPLO0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Apr 2021 07:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618571641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U6iFKEROnfIjkwh3ucQzYp2KHuQ6I5bdyLCRUR3ILGE=;
        b=CkhlwQpjLlgx8G55Q8cryqzcyFjwNCMIgq+xS31rcsZ2iRgJy3So0cqllVuWW82UZiylGK
        nrm7hSYVTdmGQ0t0SIhEc0C2JvF7lh/1S2m7CEdQ2JmhWJWdl0uYU3+uACFw4nEPQrHvPY
        j6uAxjboiK1Iiwq4Eia7AKvkCqXPg7E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-xxEuK_AyNnmKIUomTnL54A-1; Fri, 16 Apr 2021 07:13:59 -0400
X-MC-Unique: xxEuK_AyNnmKIUomTnL54A-1
Received: by mail-ej1-f69.google.com with SMTP id lf6-20020a1709071746b029037cee5e31c4so1904067ejc.13
        for <linux-iio@vger.kernel.org>; Fri, 16 Apr 2021 04:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U6iFKEROnfIjkwh3ucQzYp2KHuQ6I5bdyLCRUR3ILGE=;
        b=cQUtj5dewYNQusnPmyYMzkU4YvVhcsyQMSS5lViaL8hLxMQTJiFAO7ghD+ivHS01kD
         gu8yGj20STkCNDcfAQshReCbt6s3s5x4cEJcwMQiTyoV7+jYheD+LrUnbAKnFpqcy9Ua
         ZLDLTd1eY0UIDWYFFR3xzCMWr882YNYGJH4m1hza2zNMfWG70ByI1EW+OQqNMlCg4VYM
         0EBatA+Sh17x1A2szvHDqvDXEz8QiuH7QMVRNgY+ao9VummRdDK7RAODucmsFVvrbq+b
         tEfi1aqSVcDPghgTeubbLZ7awzwlLdW52KbkXc6uyz0aP/Dh6fN5ecHzOhN5V6wb5Rsp
         0nJA==
X-Gm-Message-State: AOAM5307GhCA8LYW6a5QjayI2CcfDz3aqxkvOesHgvcW6AJY1+2aaYvw
        rSYr+vva48eQIL4C8H/hVz4kNWq2heERtXYROgxAs99O6qEgFA+NGYFkuLbqFhaq+h1L9zqlEur
        IeOa1IefnGxHeH3CLLtUI
X-Received: by 2002:a05:6402:270e:: with SMTP id y14mr9367262edd.283.1618571638127;
        Fri, 16 Apr 2021 04:13:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHpxRwCcKBM4W+LhLKhcODXqiVdCaE8Jr9Ser9ZrVTWnWlBFul4wVw3VJIfMHLYAyaNl3kxA==
X-Received: by 2002:a05:6402:270e:: with SMTP id y14mr9367248edd.283.1618571637919;
        Fri, 16 Apr 2021 04:13:57 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id g20sm5190218edu.91.2021.04.16.04.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 04:13:57 -0700 (PDT)
Subject: Re: [PATCH v2 resend 1/2] iio: documentation: Document proximity
 sensor label use
To:     Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>
References: <20210405204224.18715-1-hdegoede@redhat.com>
 <20210405204224.18715-2-hdegoede@redhat.com>
 <fb8ada0ee326245bbf9c9db8a3bcfbbbccfed4a5.camel@hadess.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <78d53c41-35ab-d0aa-1c8b-a7f78bc481a0@redhat.com>
Date:   Fri, 16 Apr 2021 13:13:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <fb8ada0ee326245bbf9c9db8a3bcfbbbccfed4a5.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 4/16/21 12:45 PM, Bastien Nocera wrote:
> Hey,
> 
> On Mon, 2021-04-05 at 22:42 +0200, Hans de Goede wrote:
>> Add an entry to Documentation/ABI/testing/sysfs-bus-iio for
>> the new device label sysfs-attribute support.
>>
>> And document the standardized labels which may be used with proximity
>> sensors to hint userspace about the intended use of the sensor.
>>
>> Using labels to differentiate between the multiple proximity sensors
>> which a modern laptop/tablet may have was discussed in this thread:
>> https://lore.kernel.org/linux-iio/9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com/
>>
>> As mentioned there the "proximity-wifi*" labels are already being
>> used
>> in this manner on some chromebooks, see e.g.:
>> arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
>>
>> And the "proximity-palmrest" and "proximity-lap" labels are intended
>> to be used with the lap and palmrest sensors found in recent Lenovo
>> ThinkPad models.
>>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Mark Pearson <mpearson@lenovo.com>
>> Cc: Bastien Nocera <hadess@hadess.net>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> - Drop the too generic:
>>   What:           /sys/bus/iio/devices/iio:deviceX/in_*_label
>>   What:           /sys/bus/iio/devices/iio:deviceX/out_*_label
>>   lines from the newly added documentation, if/when we start
>>   using channel-labels with proximity sensors then those should
>>   get a separate in_proximityX_label documentation.
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio | 39
>> +++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
>> b/Documentation/ABI/testing/sysfs-bus-iio
>> index d957f5da5c04..7379e40d862d 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -33,6 +33,45 @@ Description:
>>                 Description of the physical chip / device for device
>> X.
>>                 Typically a part number.
>>  
>> +What:          /sys/bus/iio/devices/iio:deviceX/label
>> +KernelVersion: 5.8
>> +Contact:       linux-iio@vger.kernel.org
>> +Description:
>> +               Optional symbolic label for a device.
>> +               This is useful for userspace to be able to better
>> identify an
>> +               individual device.
>> +
>> +               The contents of the label are free-form, but there
>> are some
>> +               standardized uses:
>> +
>> +               For proximity sensors which give the proximity (of a
>> person) to
>> +               a certain wlan or wwan antenna the following
>> standardized labels
>> +               are used:
>> +
>> +               * "proximity-wifi"
>> +               * "proximity-lte"
>> +               * "proximity-wifi-lte"
>> +               * "proximity-wifi-left"
>> +               * "proximity-wifi-right"
> 
> Could we avoid having "lte" in the label names? Do we have a way to
> communicate that some of those labels are deprecated and should be
> avoided?
> 
> I would use "wwan" instead of "lte" here, and just mention "proximity-
> wifi-lte" as a synonym for "proximity-wifi-wwan".

the "lte" postfix is currently in use on ChromeOS, which is why
I chose it here. I'm fine with adding some text that new drivers
should use -wwan, although I wonder how this will work with
separate mmwave and normal 5g antennas as such keeping lte for
both 4g + regular 5g might actually be better and then the separate  
mmwave antennas can use a -mmwave postfix.

Dmitry IIRC you brought up the use of these labels in a previous
discussion. Do you have anything to add here ?  Is ChromeOS
already doing anything wrt SAR for mmwave antennas?

> 
>> +
>> +               These are used to indicate to userspace that these
>> proximity
>> +               sensors may be used to tune transmit power to ensure
>> that
>> +               Specific Absorption Rate (SAR) limits are honored.
>> +               The "-left" and "-right" labels are for devices with
>> multiple
>> +               antennas.
>> +
>> +               In some laptops/tablets the standardized proximity
>> sensor labels
>> +               instead indicate proximity to a specific part of the
>> device:
>> +
>> +               * "proximity-palmrest" indicates proximity to the
>> keyboard's palmrest
>> +               * "proximity-palmrest-left" indicates proximity to
>> the left part of the palmrest
>> +               * "proximity-palmrest-right" indicates proximity to
>> the right part of the palmrest
>> +               * "proximity-lap" indicates the device is being used
>> on someone's lap
>> +
>> +               Note "proximity-lap" is special in that its value may
>> be
>> +               calculated by firmware from other sensor readings,
>> rather then
>> +               being a raw sensor reading.
> 
> I don't think that this is needed. I would expect that this sensor
> would have a "0" minimum and "1" maximum value, which makes it clear
> that the sensor value is synthesised.

IIO typically exports real sensor readings, not these kind of
synthesized values so IMHO it is good to mention this in the docs.

> Maybe this special case should be mentioned (if that's needed), rather
> than pointing out that this particular sensor might be special (they
> could all be, depending on how the system is implemented after all).
> 
> Did you think about where you wanted the sensor's threshold to be
> exported? Still in udev/hwdb?

AFAIK the plan was for the driver to export this as a IIO sysfs
attribute, Documentation/ABI/testing/sysfs-bus-iio
already has:

What:           /sys/.../events/in_proximity0_thresh_falling_value
What:           /sys/.../events/in_proximity0_thresh_rising_value

Those are intended for the trigger interface, but IIRC I think the
plan was to also use these on a device without trigger support
to advertise the recommended threshold to be used by userspace.

Jonathan ?

Regards,

Hans






> 
> Cheers
> 
>> +
>>  What:          /sys/bus/iio/devices/iio:deviceX/current_timestamp_cl
>> ock
>>  KernelVersion: 4.5
>>  Contact:       linux-iio@vger.kernel.org
> 
> 

