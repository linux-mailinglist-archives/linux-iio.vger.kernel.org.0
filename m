Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C5A2B9660
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 16:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgKSPjU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Nov 2020 10:39:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37145 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727758AbgKSPjR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Nov 2020 10:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605800355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DoAe37z9hu1FPzzmCPBFQ69UVruif+/VKwGqbHZ90rc=;
        b=M9jKobv8Ge+YbJhXnUzNgSAjrgy/QWG9G7Ob4nNc4tZCFk7/gmpQ++1YaT3UM1RjiK20La
        1hn3Cq0sIPYVXIEqekGDNPU8t0GRwzw+oGZSJ1ilo/baDEKVQBkAmu1hzHOK3F+dCezrPV
        1iUW2FvLYDr1OcqeAQhzczNW4YoHpfY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-DVWMqzhwNG6My5dtuFM6GQ-1; Thu, 19 Nov 2020 10:39:11 -0500
X-MC-Unique: DVWMqzhwNG6My5dtuFM6GQ-1
Received: by mail-ed1-f69.google.com with SMTP id o11so2509063edq.5
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2020 07:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DoAe37z9hu1FPzzmCPBFQ69UVruif+/VKwGqbHZ90rc=;
        b=LxYX0cTv/1lFuJobgzisvwGxY/o54OMKw9CGzGPL2L197mfIwiShebRXbStjrBxDlc
         vIZi4ySmUXyqBTzKXyCy7i/MjIroZTmqLgvuQ36te/ZHkBqv8rS7AFM4tG3fA1OsduTk
         N4IWYgGS8/Xwi3HUxtQrIpw+Qa9NUs0jGGbbPKSJS/2+lXnFwl6flMHWLNB9DJL6ofJi
         4GsUFXFR9QIqt4+vbGqF+0Z6awASBtN//S/4b11sQrBdHuxRUlXq4LtvDcaGWZom5UL8
         UkEPTEu0w+q9ExLqO2nQOR0gcuYL7SLWmedGE2gW3RS3QCNlw3A8BlVhkUU4BQpT1tl4
         JyfA==
X-Gm-Message-State: AOAM533UoUAepGKPD19H6kZfkxLIDwz0TAh4ZsjNhF/2bSLFlb+odWa3
        iYwadYDjFKcMQZC5Rn/+xloT3b2qr62hZuOBeCBoo21c+y7mhbPrSRyNQKDxSS3JZkrm0SmFGuZ
        ujZ20nAU84YkIgKryuGMw
X-Received: by 2002:a17:906:17d1:: with SMTP id u17mr27918492eje.229.1605800349558;
        Thu, 19 Nov 2020 07:39:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfiB/zwWGB1az64zh8Y+EIgFR5kmqWHzMaHJKtOHPTjR3DvU2qIZUOodAjud5TEidxfwp3Lg==
X-Received: by 2002:a17:906:17d1:: with SMTP id u17mr27918471eje.229.1605800349271;
        Thu, 19 Nov 2020 07:39:09 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id h11sm15201457edl.16.2020.11.19.07.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 07:39:08 -0800 (PST)
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-iio@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Nitin Joshi1 <njoshi1@lenovo.com>, linux-input@vger.kernel.org
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
 <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
 <20201007083602.00006b7e@Huawei.com>
 <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
 <20201112062348.GF1003057@dtor-ws>
 <3568c492-d9bd-c02d-4cbc-7f3eef605ef5@redhat.com>
 <20201113065832.GD356503@dtor-ws>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6df00683-9508-3dd9-831e-9b343658287b@redhat.com>
Date:   Thu, 19 Nov 2020 16:39:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201113065832.GD356503@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/13/20 7:58 AM, Dmitry Torokhov wrote:
> On Thu, Nov 12, 2020 at 10:50:12AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 11/12/20 7:23 AM, Dmitry Torokhov wrote:
>>> On Wed, Oct 07, 2020 at 11:51:05AM +0200, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 10/7/20 10:36 AM, Jonathan Cameron wrote:
>>>>> On Mon, 5 Oct 2020 22:04:27 -0400
>>>>> Mark Pearson <markpearson@lenovo.com> wrote:
>>>>>
>>>>>> Adding Nitin, lead for this feature, to the thread
>>>>>
>>>>> +CC linux-input and Dmitry for reasons that will become clear below.
>>>>>>
>>>>>> On 2020-10-03 10:02 a.m., Hans de Goede wrote:
>>>>>>> Hi All,
>>>>>>>
>>>>>>> Modern laptops can have various sensors which are kinda
>>>>>>> like proximity sensors, but not really (they are more
>>>>>>> specific in which part of the laptop the user is
>>>>>>> proximate to).
>>>>>>>
>>>>>>> Specifically modern Thinkpad's have 2 readings which we
>>>>>>> want to export to userspace, and I'm wondering if we
>>>>>>> could use the IIO framework for this since these readings
>>>>>>> are in essence sensor readings:
>>>>>>>
>>>>>>> 1. These laptops have a sensor in the palm-rests to
>>>>>>> check if a user is physically proximate to the device's
>>>>>>> palm-rests. This info will be used by userspace for WWAN
>>>>>>> functionality to control the transmission level safely.
>>>>>>>
>>>>>>> A patch adding a thinkpad_acpi specific sysfs API for this
>>>>>>> is currently pending:
>>>>>>> https://patchwork.kernel.org/patch/11722127/
>>>>>>>
>>>>>>> But I'm wondering if it would not be better to use
>>>>>>> IIO to export this info.
>>>>>
>>>>> My first thought on this is it sounds more like a key than a sensor
>>>>> (simple proximity sensors fall into this category as well.)
>>>
>>> [ sorry for sitting on this thread for so long ]
>>>
>>> So I think the important question here is if we only ever want yes/no
>>> answer, or if we can consider adjusting behavior of the system based on
>>> the "closeness" of an object to the device, in which case I think IIO is
>>> more flexible.
>>>
>>> FWIW in Chrome OS land we name IIO proximity sensors using a scheme
>>> "proximity-lte", "proximity-wifi", "proximity-wifi-left",
>>> "proximity-wifi-right", etc, and then userspace implements various
>>> policies (SAR, etc) based off it.
>>
>> Interesting, so 2 questions:
>>
>> 1. So your encoding the location in the sensor's parent-device name
>> instead of using a new sysfs attribute for this ?
> 
> I think it depends on the kernel we use and architecture. On x86 I think
> we rely on udev, like this:
> 
> https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-nocturne/chromeos-base/chromeos-bsp-nocturne/files/udev/99-cros-sx-proximity.rules
> 
> DEVPATH=="*/pci0000:00/0000:00:15.1/*", SYMLINK+="proximity-wifi-right"
> DEVPATH=="*/pci0000:00/0000:00:19.1/*", SYMLINK+="proximity-wifi-left"
> ATTR{events/in_proximity1_USE_CS1_thresh_either_en}="1"

So that results in a symlink under /dev, right ? That seems like
it is not really compatible with how most modern userspace discovers
hw (through udev). Although I guess code using udev could still
lookup the symlink in the udev per device data, this just not feel
like a good way forward.

> On newer ARM we use "label" attribute in DTS:
> 
> arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> 
>         ap_sar_sensor: proximity@28 {
>                 compatible = "semtech,sx9310";
>                 reg = <0x28>;
>                 #io-channel-cells = <1>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&p_sensor_int_l>;
> 
>                 interrupt-parent = <&tlmm>;
>                 interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> 
>                 vdd-supply = <&pp3300_a>;
>                 svdd-supply = <&pp1800_prox>;
> 
>                 status = "disabled";
>                 label = "proximity-wifi";
>         };

Hmm, interesting. I did not know iio-devices could
have a label sysfs attribute (nor that that could be
set through device-tree). I was thinking about adding
an in_proximity_location sysfs attribute. But using
labels (and standardizing a set of label names) will
work nicely too.

I have no real preference for this either way, so
I guess we might as well go with labels to avoid
having any unnecessary discrepancies between ChromeOS
and whatever we do for the Thinkpad sensors.

Is there a know set of labels which ChromeOS is currently
using? If we are going to use labels for this it would
be good IMHO to define a set of standard labels for
this in say Documentation/ABI/testing/sysfs-bus-iio-labels.

>> 2. Do these sensors just give a boolean value atm, or do they already
>> report a range ?  IIRC one of the objections from the iio folks in
>> the Lenovo case was that booleans are not really a good fit for iio
>> (IIRC they also said we could still use iio for this).
> 
> One of the sensors we use is sx9310 that I believe can report range, but
> I think we configure them to trigger when a threshold is crossed.
> 
> Events are handled by our powerd:
> 
> https://chromium.googlesource.com/chromiumos/platform2/+/master/power_manager/powerd/system/sar_watcher.cc
> 
>>
>> Perhaps you can provide an URL to the kernel code implementing these ?
> 
> drivers/iio/proximity/sx9310.c

If I'm reading that correctly the it exports a raw "distance"
reading and a suggested threshold value for the code interpreting
the reading to use.

So that would be a bit different then the Thinkpad sensors, but
exporting just a 0-1 range for the in_proximity_raw value for the
Thinkpad case should not be a problem. Or we could just make it
repot 0 and 100 and export a fixed in_proximity_nearlevel of 50,
that would make the userspace API more like other proximity sensors.

Regards,

Hans




