Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3A615D656
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 12:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbgBNLMN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 06:12:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40881 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728865AbgBNLMN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2020 06:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581678731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBkJ6kyoxKiH31C8ZTN4hED9LVBPPseIz9N2/FKfF1M=;
        b=LSVckGI9Bf+yfg5+WqzeLeLwP1pcZOt4+e8quNDvWX1rYmLtC1PB0grQTtDIACDjH3ejW3
        8Dj1TvHRmexR0JP0d/wWDm4SneCb9ex5VP3dH/ei8OoLvksko1VE91XSo8OZ1ot9fl5rT8
        Y3e26vxKMbt20p+uL5RSlpHtbRzLU0M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-6l499beAOcC4ck8Fz4pvMg-1; Fri, 14 Feb 2020 06:12:06 -0500
X-MC-Unique: 6l499beAOcC4ck8Fz4pvMg-1
Received: by mail-wr1-f69.google.com with SMTP id c6so3819195wrm.18
        for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2020 03:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nBkJ6kyoxKiH31C8ZTN4hED9LVBPPseIz9N2/FKfF1M=;
        b=UH0TEnTsWPXzmdkrtQyNU9C1VD6O+6cLP55vej0MfBtGOPWLfBMA/6nQXFsSron/1q
         cl9jetjRmBovPdLYqS+84+FubEqXAeSeRpFe8NlT7rOunurqlvAY9KgYfTGcpyqtFNnB
         cU0jP1Ft2BvwuJdviAFfs4hvN8x/WbpoS5Q11RdpZ7VuRyf7LcpbaP0BTYQ1ZKTOMjvN
         Lh/rfYvHUKPo2lJ6GKqTGo2ElnOusG4Ex0FT/Ze763b4wtUc0gmIntmhl0f3G8UFw1FQ
         hv+Ic6DmoaIBu+GLMHS0CMtxvhIRgdefQOD5u/3KdhME3+PPCdrGZ2KyVEYdpiGTll39
         ZQEQ==
X-Gm-Message-State: APjAAAUkVrD/ujN7885oLn9eQLgHzVj7qRZIroklmbwrAo45iEOECbc/
        ei18NiaWvY6183NjwQ3W2PMVvSHw8uZfnNJG/+93h33vf/zBGVpRKY6VQa+549YUVwvnUouLRmZ
        ghITxtANpRdULfVs0/rqC
X-Received: by 2002:adf:f986:: with SMTP id f6mr3661867wrr.182.1581678725058;
        Fri, 14 Feb 2020 03:12:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxgBdY0nmrgGd5UUedT9UtUjS4mbwJ6nsA0CuQMGz6O3mufawejjglrVBFt78ao/D+vk6TCWQ==
X-Received: by 2002:adf:f986:: with SMTP id f6mr3661308wrr.182.1581678717659;
        Fri, 14 Feb 2020 03:11:57 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id u4sm6520237wrt.37.2020.02.14.03.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 03:11:56 -0800 (PST)
Subject: Re: [PATCH v3 0/5] SFH: Add Support for AMD Sensor Fusion Hub
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Sandeep Singh <Sandeep.Singh@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Shyam-sundar.S-k@amd.com
References: <1581476197-25854-1-git-send-email-Sandeep.Singh@amd.com>
 <1ce6f591-1e8b-8291-7f18-48876fd70e10@redhat.com>
 <CAO-hwJJkWkpApB-i0tHxEb0BeWcMpFLwSsOWKKdzGKnJEbHA_A@mail.gmail.com>
 <719b929927ce76dd7dda3a48319b5798aced591a.camel@linux.intel.com>
 <7a9b6f51-ef50-9078-325c-28e8cd17c182@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a4362e76-6d35-2efe-dbda-f90d9a9c29c0@redhat.com>
Date:   Fri, 14 Feb 2020 12:11:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7a9b6f51-ef50-9078-325c-28e8cd17c182@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2/14/20 11:04 AM, Shah, Nehal-bakulchandra wrote:
> Hi
> 
> On 2/14/2020 10:10 AM, Srinivas Pandruvada wrote:
>> On Thu, 2020-02-13 at 15:56 +0100, Benjamin Tissoires wrote:
>>> Hi,
>>>
>>> On Wed, Feb 12, 2020 at 3:45 PM Hans de Goede <hdegoede@redhat.com>
>>> wrote:
>>>> Hi,
>>>>
>>>> On 2/12/20 3:56 AM, Sandeep Singh wrote:
>>>>> From: Sandeep Singh <sandeep.singh@amd.com>
>>>>>
>>>>> AMD SFH(Sensor Fusion Hub) is HID based driver.SFH FW
>>>>> is part of MP2 processor (MP2 which is an ARM® Cortex-M4
>>>>> core based co-processor to x86) and it runs on MP2 where
>>>>> in driver resides on X86.The driver functionalities are
>>>>> divided  into three parts:-
>>>>>
>>>>> 1: amd-mp2-pcie:-       This module will communicate with MP2 FW
>>>>> and
>>>>>                           provide that data into DRAM.
>>>>> 2: Client driver :-     This part for driver will use dram data
>>>>> and
>>>>>                           convert that data into HID format based
>>>>> on
>>>>>                           HID reports.
>>>>> 3: Transport driver :-  This part of driver will communicate with
>>>>>                           HID core. Communication between devices
>>>>> and
>>>>>                           HID core is mostly done via HID reports
>>>>>
>>>>> In terms of architecture it is much more reassembles like
>>>>> ISH(Intel Integrated Sensor Hub). However the major difference
>>>>> is all the hid reports are generated as part of kernel driver.
>>>>> AMD SFH driver taken reference from ISH in terms of
>>>>> design and functionalities at fewer location.
>>>>>
>>>>> AMD sensor fusion Hub is part of a SOC 17h family based
>>>>> platforms.
>>>>> The solution is working well on several OEM products.
>>>>> AMD SFH uses HID over PCIe bus.
>>>> I started looking at this patch because of the phoronix' news item
>>>> on it.
>>>>
>>>> First of all I want to say that it is great that AMD is working on
>>>> getting the Sensor Fusion Hub supported on Linux and that you are
>>>> working on a driver for this.
> Thanks for the valuable input.
>>> But, I've taken a quick look, mainly at the
>>> "[PATCH v3 5/5] SFH: Create HID report to Enable support of AMD
>>> sensor fusion Hub (SFH)"
>>> patch.
>>>
>>> AFAIK with the Intel ISH the sensor-hub itself is actually
>>> providing
>>> HID descriptors and HID input reports.
>>>
>>> Looking at the AMD code, that does not seem to be the case, it
>>> seems
>>> the values come directly from the AMD sensor-hub without being in
>>> any
>>> HID specific form, e.g.:
>>>
>>> +u8 get_input_report(int sensor_idx, int report_id,
>>> +                   u8 *input_report, u32 *sensor_virt_addr)
>>> +{
>>> +       u8 report_size = 0;
>>> +       struct accel3_input_report acc_input;
>>> +       struct gyro_input_report gyro_input;
>>> +       struct magno_input_report magno_input;
>>> +       struct als_input_report als_input;
>>> +
>>> +       if (!sensor_virt_addr || !input_report)
>>> +               return report_size;
>>> +
>>> +       switch (sensor_idx) {
>>> +       case ACCEL_IDX: /* accel */
>>> +               acc_input.common_property.report_id = report_id;
>>> +               acc_input.common_property.sensor_state =
>>> +                                       HID_USAGE_SENSOR_STATE_READ
>>> Y_ENUM;
>>> +               acc_input.common_property.event_type =
>>> +                               HID_USAGE_SENSOR_EVENT_DATA_UPDATED
>>> _ENUM;
>>> +               acc_input.in_accel_x_value =
>>> (int)sensor_virt_addr[0] /
>>> +                                               AMD_SFH_FIRMWARE_MU
>>> LTIPLIER;
>>> +               acc_input.in_accel_y_value =
>>> (int)sensor_virt_addr[1] /
>>> +                                               AMD_SFH_FIRMWARE_MU
>>> LTIPLIER;
>>> +               acc_input.in_accel_z_value
>>> =  (int)sensor_virt_addr[2] /
>>> +                                               AMD_SFH_FIRMWARE_MU
>>> LTIPLIER;
>>> +               memcpy(input_report, &acc_input,
>>> sizeof(acc_input));
>>> +               report_size = sizeof(acc_input);
>>> +               break;
>>>
>>> And the descriptors are hardcoded in the driver so as to fake a HID
>>> device.
>>>
>>> So going through the HID subsystem seems like an unnecessary
>>> detour,
>>> which just makes things needlessly complex and harder to debug
>>> (and extend).
>>>
>>> The HID devices which the current patch-set is creating ultimately
>>> will result in a number of devices being created under
>>>
>>> /sys/bus/iio/devices
>>>
>>> And this are the devices which userspace uses to get the sensor
>>> data.
>>>
>>> IMHO instead of going through the HID subsys the AMD Sensor Fusion
>>> Hub
>>> driver should simply register 4 (*) iio-devices itself and directly
>>> pass the data through at the iio subsys level rather then going the
>>> long way around by creating a fake HID device which then gets
>>> attached to by the hid-sensor driver to ultimately create the same
>>> iio-devices.
>>>
>>> There are examples of e.g. various iio accel drivers under:
>>> drivers/iio/accel/ you could start with a simple driver supporting
>>> just the accelerometer bits and then extend things from there.
>>>
>>> Benjamin, Jiri, Jonathan, what is your take on this?
>>> Hard to say without knowing AMD roadmap for that. If they intend to
>>> have an ISH-like approach in the end with reports and descriptors
>>> provided by the firmwares, then it makes sense to keep this
>>> architecture for the first revision of devices.
>>> If not, then yes, this is probably overkill compared to what needs to
>>> be done.
>>>
>> I suggested this approach to follow something like Chrome-OS EC based
>> hub, but looks like in longer run this may come from firmware. That's
>> why they may have decided.
>>
>> Thanks,
>> Srinivas
>>   
>>
>>> Sandeep, can you explain to us why you think using HID is the best
>>> way?
>>>
>>> On a side note, I don't necessarily like patch 4/5 with the debugfs
>>> interface. It's adding a kernel API for no gain, and we should
>>> already
>>> have the debug API available in the various subsystems involved.
>>>
>>> Cheers,
>>> Benjamin
> 
> Yes today, the  HID Reports are getting generated in driver. But, we would like to have HID based driver as we may go for HID based firmware in future . Hence keeping that in mind current AMD SFH design.
> 
> So, kindly consider our design w.r.t HID for this patch series.

If the plan is to move to using HID in the future and the HID maintainers
(Benjamin and Jiri) are ok with the current approach then I'm fine with the current approach too.

Regards,

Hans

