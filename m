Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53A83133BC
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 14:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhBHNwC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 08:52:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230384AbhBHNv5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 08:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612792230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yNPIoHnBY6HXYG4ADh2fKWto5IZcYeENv/QQ0n/pnTw=;
        b=jNQykoMH1r3kpnscS6Aw3RtULfHHHxtKigiNoRb7arOeF5p7LRfrTaUICNDTSMAN400rPl
        VkuauhAr/XnuP21Trqio9nhrMXc5PiUrh2H3gkPJQJaNHWOsnB9QLLKw1p04XP4psjulrk
        Gwqn2qaeMgKVdc9DtIMEjWQ59+7Dhw4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-R2KISg1KM5eWq4qu4FefVQ-1; Mon, 08 Feb 2021 08:50:29 -0500
X-MC-Unique: R2KISg1KM5eWq4qu4FefVQ-1
Received: by mail-ed1-f71.google.com with SMTP id bd22so13243126edb.4
        for <linux-iio@vger.kernel.org>; Mon, 08 Feb 2021 05:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yNPIoHnBY6HXYG4ADh2fKWto5IZcYeENv/QQ0n/pnTw=;
        b=XhyS7fXg0dL9nP73fSPowG67p8QBUbE0/+Xidpoex16Inb7OCBZeC9ICWDbKz8JUWB
         7C+Fkg3WRu8ShMFhDnm8SU71ANSPBshcYyJnXTqmT6oy7pD25N8DRXzM4e1zyqo2+/h2
         T4iYWyI8BeE/waF5O0wrBMIrywcp9d3Wj4RsI74GrGYyVw+AqN1EVs/yNDCpBpXt5KVB
         2ev5S3jHMoNnAUYCmvrMEdzYwHXedF2Xts7G9YdB0KkTDMsAA7XV+uWig+yFjpd5Oj4d
         IW6GzE6eAKPVyjUe6fSmlKIq0aXjDe2/4BrsWbTAlmmYXlNRxErJPnkz7IYh8uzXW2sG
         wkrg==
X-Gm-Message-State: AOAM532YF+wbVsp1gNHaKuGzn1P66Op1kh01HRtVSneC91LZqm13gI3N
        03YNQ3HsAogieLm7P5NZGDHSvpBJF5aWwIFRIy0z4wNPralDl0ouxZhJJXbwHgtsns23han9vOu
        2rDyyY9mC392pzs6PsRYk
X-Received: by 2002:a17:907:1b1f:: with SMTP id mp31mr16542665ejc.348.1612792227607;
        Mon, 08 Feb 2021 05:50:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzwM5czmo7ikJRAMH4nPm9ToFKx6w5odzT7x9ljUza982b0mGEdgSWzmvem5f3LTvyI41EzA==
X-Received: by 2002:a17:907:1b1f:: with SMTP id mp31mr16542630ejc.348.1612792227266;
        Mon, 08 Feb 2021 05:50:27 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f6sm5400461edm.15.2021.02.08.05.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 05:50:26 -0800 (PST)
Subject: Re: [PATCH 1/2] iio: documentation: Document proximity sensor label
 use
To:     Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-input@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>
References: <20210207123720.8357-1-hdegoede@redhat.com>
 <2b7a0374f4af5e2113c1d209246b506d7f42ae29.camel@hadess.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <676c9b71-ffc6-343e-f4ef-b0ec73fdb906@redhat.com>
Date:   Mon, 8 Feb 2021 14:50:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <2b7a0374f4af5e2113c1d209246b506d7f42ae29.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2/8/21 2:40 PM, Bastien Nocera wrote:
> On Sun, 2021-02-07 at 13:37 +0100, Hans de Goede wrote:
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
> 
> Both patches in the series look fine to me.

Thank you for checking.

> Is IIO the interface you plan on using to implement the lap detection
> for the thinkpad_acpi driver?

ATM both the lap detection and the palmrest proximity detection are
already available using thinkpad_acpi specific sysfs attributes:

[hans@x1 linux]$ cat /sys/bus/platform/devices/thinkpad_acpi/dytc_lapmode 
0
[hans@x1 linux]$ cat /sys/bus/platform/devices/thinkpad_acpi/palmsensor 
1

Which I think you are already aware of ?  These will not be going
anywhere since dropping these would be a userspace ABI break.

With that said, yes the plan is to extend the thinkpad_acpi driver
to also report lap / palmrest proximity through IIO using these labels.

With the idea being that if other drivers / vendor firmwares also will
export similar readings that those will then also use IIO with these
labels for this, so that there is one unified / driver independent
interface which userspace can use to get these readings.

> If so, don't forget to set the "nearlevel" property as well.

Ack, I'll make sure that you are on the Cc when the patches for this
get posted.

Regards,

Hans

