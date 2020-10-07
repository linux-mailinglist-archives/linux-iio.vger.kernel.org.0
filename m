Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77471286032
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 15:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgJGNcO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Oct 2020 09:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728380AbgJGNcO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Oct 2020 09:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602077532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYlyurNQSHJF3Pms/tfP+frOIv3X9rPgbfgurA+BpZ0=;
        b=hf+k2XwYW797dCO782do3TKAJ+IjS0kGBEXlUxKatC6EysOPBBFY/3kkrmvlrRAoTy7eAO
        ZGApHYfSg9YfODz7xLq3tJGNZm8zy7EojK7XvshX3z/+xNBsBniG+Vo4QMpNW4TPgO51sD
        5PIMFzBFHS6AHnet0TyAXjK98Pdaz2g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-xlHPf1USNumA5nZHOxCM3Q-1; Wed, 07 Oct 2020 09:32:10 -0400
X-MC-Unique: xlHPf1USNumA5nZHOxCM3Q-1
Received: by mail-ej1-f71.google.com with SMTP id z19so791808eja.10
        for <linux-iio@vger.kernel.org>; Wed, 07 Oct 2020 06:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YYlyurNQSHJF3Pms/tfP+frOIv3X9rPgbfgurA+BpZ0=;
        b=FPHoz20S7o638uMBU0r7K+AMiWudkpO9biRqnOcRPrJTaeJr2ldFZLFHx5GJuJGrws
         OHRPh0snBkpXJhquOpp+o9OHk/rlFV+IEekbAXmFNeOmlTci8pL+mis8yKvof9fU1ws3
         oZpA7NEBw5WnTG+M7mOjV9GR84/E/l57JJvt8snugvh7s/K8YRK03H623ZPAea/MbP1p
         mlZT4cfCDUC+1C7rm065SE+eRE9BximSu5GvTLHnLjbxZD12s+IcA2pNcY6o2Rb9Pku7
         ekcoLGxqlpAWMwjgoBEwZ7/BAePKLtDE4Wt7Ua8LWMdDSMoYE+E8z4DEDg6jv08K0GdC
         2q/A==
X-Gm-Message-State: AOAM530rq/uM8EvyVz+C3V5lOPy8HgAYdnyLiMe9X2umrmJCt3GJgK/0
        CnL8W5vd6bH9Kpq2a12UFepWTuD2npdZtyEYudab+mKj4A3k7ZfL/w2lUMsfno5Oz42KLy7xtK2
        GrFFaTJJ7qfwaEGpxk+jL
X-Received: by 2002:a17:906:1b11:: with SMTP id o17mr3538533ejg.67.1602077529512;
        Wed, 07 Oct 2020 06:32:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCyl/J4gCgm/20kLnlnmCddUMnHRyY0e/1DSIC+6hWfoNEpVlpvdKrLYeHsA7q9/eIJQhrmA==
X-Received: by 2002:a17:906:1b11:: with SMTP id o17mr3538508ejg.67.1602077529287;
        Wed, 07 Oct 2020 06:32:09 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v23sm1493773edq.86.2020.10.07.06.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 06:32:08 -0700 (PDT)
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
To:     Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     linux-iio@vger.kernel.org, Nitin Joshi1 <njoshi1@lenovo.com>,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
 <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
 <20201007083602.00006b7e@Huawei.com>
 <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
 <b400b6956270a2433373dd6cbdae3332aa683f4f.camel@hadess.net>
 <cadabe4d-7cce-281e-75fe-fcc2099848da@redhat.com>
 <5273a1de9db682cd41e58553fe57707c492a53b7.camel@hadess.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <272074b5-b28e-1b74-8574-3dc2d614269a@redhat.com>
Date:   Wed, 7 Oct 2020 15:32:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5273a1de9db682cd41e58553fe57707c492a53b7.camel@hadess.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 10/7/20 3:29 PM, Bastien Nocera wrote:
> On Wed, 2020-10-07 at 15:08 +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 10/7/20 1:35 PM, Bastien Nocera wrote:
>>> On Wed, 2020-10-07 at 11:51 +0200, Hans de Goede wrote:
>>>> <snip>
>>>>> Dmitry, any existing stuff like this in input?
>>>>
>>>> There already is a SW_FRONT_PROXIMITY defined in
>>>> input-event-codes.h, which I guess means detection if
>>>> someone is sitting in front of the screen. So we could add:
>>>>
>>>> SW_LAP_PROXIMITY
>>>> SW_PALMREST_PROXIMITY,
>>>>
>>>> And then we have a pretty decent API for this I think.
>>>
>>>   From the point of view of writing the consumer code for this API,
>>> it's
>>> rather a lot of pain to open the device node (hoping that it's the
>>> right one for what we need), getting the initial state, setting up
>>> masks to avoid being woken up for every little event, and parsing
>>> those
>>> events.
>>
>> There is not much difference with the iio sysfs API though, you would
>> also need to iterate over all the iio devices and test if they
>> are a proximity sensor (and read the new location sysfs file
>> discussed).
>>
>>> Where would the necessary bits of metadata for daemons to be able
>>> to
>>> find that those switches need to get added?
>>
>> evdev files export info on which events they can report. Not only
>> the types of events (EV_SW in this case) but also a bitmask for
>> which event-codes they can report within that type.
> 
> I know that, I've written enough of that type of code ;)
> 
> I meant a way to avoid having to go open each evdev, read its
> capabilities, and close them when it doesn't, and re-do that every time
> a new event device appears. In other words, can you please make sure
> there will be a udev property that we can use to enumerate and filter
> devices with those capabilities?

Ah I see, yes that should not be a problem since we already run
a helper on all new evdev-s anyways (assuming we go this route).

Regards,

Hans

