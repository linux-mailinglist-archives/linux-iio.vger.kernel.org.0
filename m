Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7557631A4E1
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 20:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhBLTAU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 14:00:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229558AbhBLTAT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 14:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613156331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/KTzitd76L29CAg2OFoBrXIEqtJOlYZ8tiqpRKCJ4c=;
        b=PpM8tMIC5ArogyeQdMZ8FaZZbOw4yQWSeSdvdjGSvZqeg6kdMfomtu9MhvRsYaMrW5dLbG
        i1YSy+hCXXAl7BbPGd8/NvsKyE0o1UuGKSCxxwkwL21aJU8REjjudCHqjTslxPhFe0hiq4
        T88rrzuyFi63Mr4K1Ps4khHtL5gcjso=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-lK4Jn7BHNpqR_OZEUFaoRA-1; Fri, 12 Feb 2021 13:58:50 -0500
X-MC-Unique: lK4Jn7BHNpqR_OZEUFaoRA-1
Received: by mail-ej1-f70.google.com with SMTP id hx26so355113ejc.3
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 10:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J/KTzitd76L29CAg2OFoBrXIEqtJOlYZ8tiqpRKCJ4c=;
        b=oQCu4OnxHxfURU7gwKiLTI3UCDHTzSacf70mxZQ5F0rRiuzaVM8qrtgadu2784Z8NN
         UxQNdUOmDZIqTtTC7MoIAqp+cTbLaStyy22VJjtC7l4eKoIIK6UG/9i2f59uWm+vsQE1
         MoOup+J4FcwC+JblqEoFV9hoMVm2/mLyLARiQ0ngv2tdziIwx04MLjWox3AHlFiDN0Hz
         zdnlqbeCGplqRZkwuvoE1GGKhfuCywdzmOvjIopRBs9aV492WfNP1gV4bRFt/iFpu3a7
         58hW6E7eCKAz6rc2NccIPQgj9Mz/NPYtnFFKUS0A3iRBVdUWJIlBZBcIxgyV6HTronDH
         7/+A==
X-Gm-Message-State: AOAM530B/QhCtWYoEed/U1sgSIgXUYeoFGI9IB2HOy298lyvj7+7ROmd
        LJxNiiIuqMNv4tD49D3zQT0vRRQAgr6b39xeIUFaFPhvm0h3JLo3K2EPUWS1u1xIPKA4RuXjZhd
        AZ9AWPIHwITLkeEWkR19Z
X-Received: by 2002:a17:906:199a:: with SMTP id g26mr4403394ejd.485.1613156328886;
        Fri, 12 Feb 2021 10:58:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhHUxE/XR+MmyiA64roharOSdGR6Y3l3KzZy3GfoMNJmVwRFtUe5GtarMoDmXh6kFT/qExpQ==
X-Received: by 2002:a17:906:199a:: with SMTP id g26mr4403373ejd.485.1613156328601;
        Fri, 12 Feb 2021 10:58:48 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id z65sm6311599ede.80.2021.02.12.10.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 10:58:48 -0800 (PST)
Subject: Re: [PATCH 1/2] iio: documentation: Document proximity sensor label
 use
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-input@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>
References: <20210207123720.8357-1-hdegoede@redhat.com>
 <20210212184617.5bad8172@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <10c7f469-9bb4-3e1d-88f8-6b25071a5ea9@redhat.com>
Date:   Fri, 12 Feb 2021 19:58:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212184617.5bad8172@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2/12/21 7:46 PM, Jonathan Cameron wrote:
> On Sun,  7 Feb 2021 13:37:19 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Add an entry to Documentation/ABI/testing/sysfs-bus-iio for
>> the new device and channel label sysfs-attribute support.
>>
>> And document the standardized labels which may be used with proximity
>> sensors to hint userspace about the intended use of the sensor.
>>
>> Using labels to differentiate between the multiple proximity sensors
>> which a modern laptop/tablet may have was discussed in this thread:
>> https://lore.kernel.org/linux-iio/9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com/
>>
>> As mentioned the "proximity-wifi*" labels are already being used in
>> this manner on some chromebooks, see e.g.:
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
>>  Documentation/ABI/testing/sysfs-bus-iio | 41 +++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index 35289d47d6cb..f2f090f8bd2f 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -33,6 +33,47 @@ Description:
>>  		Description of the physical chip / device for device X.
>>  		Typically a part number.
>>  
>> +What:		/sys/bus/iio/devices/iio:deviceX/label
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_*_label
>> +What:		/sys/bus/iio/devices/iio:deviceX/out_*_label
> 
> I was a bit in two minds about this from an organizational point of view.
> 1) Whether to separate the general label where position tends to make sense
>    from the channel labels.  May be something we want to do in future but we can probably
>    let that go for now.
> 2) Whether to allow such broad wild cards for the channels.
>    Whilst in theory any channel can have a label we normally only document ABI
>    that actually exists (mostly to know what we might break if we change anything :)
>    Still I can't see any way we can change this without breakage so in this
>    one case let's let the broad wild card go in.
> 
> This comes unstuck on the fact it overlaps with existing more specific Docs.
> 
> So can you pull the channel part out of here for v2.
> /sys/bus/iio/devices/iio:deviceX/in_voltageY_label
> /sys/bus/iio/devices/iio:deviceX/in_anglY_label

The problem is that these labels may either be used on a whole device,
which is certainly the case with the accelerometers in patch 2/2 where
the x y and z channels obviously all are either "accel-base" or
"accel-display".

Where as for proximity sensors the labels could be either applied at the
device level, or at a channel level.

The existing chromebook proximity usage is applying a label for this
at the device level.

This does mean that atm all users of this are using device-level labels;
and maybe I'm reading too much in your request. I guess that for now
I can just drop these lines for v2 :

What:		/sys/bus/iio/devices/iio:deviceX/in_*_label
What:		/sys/bus/iio/devices/iio:deviceX/out_*_label

Is that what you have in mind ?

Or do you want me to split this up in a proximity sensor case and an
accel case, and group both cases together with other proximity / accel
sensor attributes ?

Regards,

Hans




> Jonathan
>> +KernelVersion:	5.8
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Optional symbolic label for a device or a channel.
>> +		This is useful for userspace to be able to better identify an
>> +		individual device or channel.
>> +
>> +		The contents of the label are free-form, but there are some
>> +		standardized uses:
>> +
>> +		For proximity sensors which give the proximity (of a person) to
>> +		a certain wlan or wwan antenna the following standardized labels
>> +		are used:
>> +
>> +		* "proximity-wifi"
>> +		* "proximity-lte"
>> +		* "proximity-wifi-lte"
>> +		* "proximity-wifi-left"
>> +		* "proximity-wifi-right"
>> +
>> +		These are used to indicate to userspace that these proximity
>> +		sensors may be used to tune transmit power to ensure that
>> +		Specific Absorption Rate (SAR) limits are honored.
>> +		The "-left" and "-right" labels are for devices with multiple
>> +		antennas.
>> +
>> +		In some laptops/tablets the standardized proximity sensor labels
>> +		instead	indicate proximity to a specific part of the device:
>> +
>> +		* "proximity-palmrest" indicates proximity to the keyboard's palmrest
>> +		* "proximity-palmrest-left" indicates proximity to the left part of the palmrest
>> +		* "proximity-palmrest-right" indicates proximity to the right part of the palmrest
>> +		* "proximity-lap" indicates the device is being used on someone's lap
>> +
>> +		Note "proximity-lap" is special in that its value may be
>> +		calculated by firmware from other sensor readings, rather then
>> +		being a raw sensor reading.
>> +
>>  What:		/sys/bus/iio/devices/iio:deviceX/current_timestamp_clock
>>  KernelVersion:	4.5
>>  Contact:	linux-iio@vger.kernel.org
> 

