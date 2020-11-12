Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F5E2B0243
	for <lists+linux-iio@lfdr.de>; Thu, 12 Nov 2020 10:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgKLJuU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Nov 2020 04:50:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39330 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbgKLJuT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2020 04:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605174617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PtxnjSLOtg2WGHDNZpdP38be5tiMnWAe+aTxlrj8fy0=;
        b=JdDoMMsw9gtPlemZEvuCqe9F9h+ZlcGa18RfGYctdR6gl5z4Q31m2kMh/NLugmxLZ/cd/f
        cCj0IR2xi8f/mvL59T4gVqVQMMP6xnf66wEc13m6vcV49fJNktJ1dk9PIRElMu0ptOyFN/
        Lmv1O5H2KqpwHSNnmYJiKU9ZyRPhdic=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-65gHw66OPGOIJeYiR1TBfw-1; Thu, 12 Nov 2020 04:50:15 -0500
X-MC-Unique: 65gHw66OPGOIJeYiR1TBfw-1
Received: by mail-ej1-f69.google.com with SMTP id gr9so1627989ejb.19
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2020 01:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PtxnjSLOtg2WGHDNZpdP38be5tiMnWAe+aTxlrj8fy0=;
        b=H7s62FEAqlIwDZLLeMRqOYEtTu0fQpUhjVy28x6UeVP+jS59aC/xnxGjfK4FuBTxBw
         RQRaWOkScPIHH615TYEicLmAL8UIObbTnJdDj6J86s9WFoYvgtqNhzts4tdKOyk0JJAZ
         KEZ9dKgyh0+rljuuQIOWpXjwigYD8N4fjkK7ve3vD4dGyVsIrc1pDPGE70IH79OPdUW5
         0Og9afe9lKSQR9HPBpJ33gjlCzqVfXuS6vpwIqfGvNDqmOOMtpPTbPJ++Aicy5yp1WJ2
         ufclSZO4qPDErmv5JNo/Jp/sdl8C80f80a42D3kttm8B6mERusAI3nbXEsNUT3SRSjN/
         aASw==
X-Gm-Message-State: AOAM531HrikTBYNDzlI6ePgwdsYhSpi1xNhjaB4SgsI1Im4ymTjh01B2
        f5NDdJ5siaIQ3Ajqf+I9pVLWhSuPVDCHAFPkIdp/OKY71hDuZ6e+Lott7esuVBF2Om4okccEXBh
        BKO4zWZFrmorTac2SbGY2
X-Received: by 2002:a05:6402:1813:: with SMTP id g19mr4255886edy.105.1605174614387;
        Thu, 12 Nov 2020 01:50:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzidUxBmuZRcyzJJvnxIsic7KwZERKf4QL2v4s6OGPWebhvnkyW1kP6myShnRnbvGBMsr82WQ==
X-Received: by 2002:a05:6402:1813:: with SMTP id g19mr4255875edy.105.1605174614219;
        Thu, 12 Nov 2020 01:50:14 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id f13sm1873154ejf.42.2020.11.12.01.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 01:50:13 -0800 (PST)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3568c492-d9bd-c02d-4cbc-7f3eef605ef5@redhat.com>
Date:   Thu, 12 Nov 2020 10:50:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201112062348.GF1003057@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/12/20 7:23 AM, Dmitry Torokhov wrote:
> On Wed, Oct 07, 2020 at 11:51:05AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 10/7/20 10:36 AM, Jonathan Cameron wrote:
>>> On Mon, 5 Oct 2020 22:04:27 -0400
>>> Mark Pearson <markpearson@lenovo.com> wrote:
>>>
>>>> Adding Nitin, lead for this feature, to the thread
>>>
>>> +CC linux-input and Dmitry for reasons that will become clear below.
>>>>
>>>> On 2020-10-03 10:02 a.m., Hans de Goede wrote:
>>>>> Hi All,
>>>>>
>>>>> Modern laptops can have various sensors which are kinda
>>>>> like proximity sensors, but not really (they are more
>>>>> specific in which part of the laptop the user is
>>>>> proximate to).
>>>>>
>>>>> Specifically modern Thinkpad's have 2 readings which we
>>>>> want to export to userspace, and I'm wondering if we
>>>>> could use the IIO framework for this since these readings
>>>>> are in essence sensor readings:
>>>>>
>>>>> 1. These laptops have a sensor in the palm-rests to
>>>>> check if a user is physically proximate to the device's
>>>>> palm-rests. This info will be used by userspace for WWAN
>>>>> functionality to control the transmission level safely.
>>>>>
>>>>> A patch adding a thinkpad_acpi specific sysfs API for this
>>>>> is currently pending:
>>>>> https://patchwork.kernel.org/patch/11722127/
>>>>>
>>>>> But I'm wondering if it would not be better to use
>>>>> IIO to export this info.
>>>
>>> My first thought on this is it sounds more like a key than a sensor
>>> (simple proximity sensors fall into this category as well.)
> 
> [ sorry for sitting on this thread for so long ]
> 
> So I think the important question here is if we only ever want yes/no
> answer, or if we can consider adjusting behavior of the system based on
> the "closeness" of an object to the device, in which case I think IIO is
> more flexible.
> 
> FWIW in Chrome OS land we name IIO proximity sensors using a scheme
> "proximity-lte", "proximity-wifi", "proximity-wifi-left",
> "proximity-wifi-right", etc, and then userspace implements various
> policies (SAR, etc) based off it.

Interesting, so 2 questions:

1. So your encoding the location in the sensor's parent-device name
instead of using a new sysfs attribute for this ?

2. Do these sensors just give a boolean value atm, or do they already
report a range ?  IIRC one of the objections from the iio folks in
the Lenovo case was that booleans are not really a good fit for iio
(IIRC they also said we could still use iio for this).

Perhaps you can provide an URL to the kernel code implementing these ?

>> That is an interesting suggestion. Using the input/evdev API
>> would have some advantages such as being able to have a single
>> event node for all the proximity switches and then being able
>> to pass a fd to that from a privileged process to a non
>> privileged one, something which userspace already has
>> various infrastructure for.
> 
> I am not sure if multiplexing all proximity switches into one evdev node
> is that great option, as I am sure we'll soon have devices with 2x
> palmrest switches and being capable finely adjusting transmit power,
> etc.

Right, so going with iio, together with a naming scheme like used
on ChromeOS might indeed be more future proof (and make things
easier for running ChromeOS on non ChromeOS hardware and the other
way around).

Regards,

Hans

