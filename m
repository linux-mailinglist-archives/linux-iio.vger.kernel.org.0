Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770552C44AE
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 17:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgKYQJe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 11:09:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730574AbgKYQJe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 11:09:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606320572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHYdPIovLkmPO4nKtqEy0tAMVRaa0MnW4LxUB63INxY=;
        b=JakcIB2njYaQCaa2B0B3QD1ghCsa9twJrCne7f8To09AEmjSsjGT3hZFRn+CdZSISIZPRQ
        laPMD7R1Aa3/Up/v4YwNXEzq/xbvJBStT8LWCzHT+qq81yYxjCAzaB8Ww2LNG1ekL1Uo3t
        pwb4TTWElT4ftRccmBMHFWK13nMX7NE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-12kReQ2sMS2G_J60v-wxOg-1; Wed, 25 Nov 2020 11:09:30 -0500
X-MC-Unique: 12kReQ2sMS2G_J60v-wxOg-1
Received: by mail-ed1-f72.google.com with SMTP id n25so1225960edr.20
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 08:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pHYdPIovLkmPO4nKtqEy0tAMVRaa0MnW4LxUB63INxY=;
        b=ppMZLLYifrOa5Uo1SgM7kcg35MXYp3NVwyzB+DLgFfoVSDtsB1k1RKiJkDBj67eCVB
         mBse/EiU/KfGQQ4Y4/IzDUxUjMQ4N9be1RI3yC2m5jossVAxWXeak0MktW7TLhHIzVAt
         HOB1fNx8GIPzEdvebcXpD0L8wMYdR5Nxok9rPw5DW8GW47l5PYn9R4DuSe3/zAqbIqu6
         QRCHwlRpa4QN/33kAApXwXbidY16HyjSBH1r+m0wp96RzOLt10cg2MOAUjW54B+13B9+
         YhbUkVPd12jyx7H98vbT3qJnFUYVsbvcP/9Ns6NRclFeegmDkvBiKmJrYtQa/Nn2buCm
         bqtQ==
X-Gm-Message-State: AOAM532CkOPBM+oPybtN6JQ8UjyBCY99Hy5UYKBenDMqqjsgRkKOYBa1
        S+/LEr2uroCHhdaUFF/kESjX3sDLV3a5mCnS53bk3KOEsetMM7zGK2Sv3EKD2saXuoIR8eDVfrC
        p9twhBNnD0/z/LA3dH+c1TJD0tGqMA1NIGSQ5aj8RJWfYmWWnbGNRJCF6eAovEk0kQRsyezms
X-Received: by 2002:a17:906:7190:: with SMTP id h16mr3641999ejk.221.1606320569123;
        Wed, 25 Nov 2020 08:09:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSaFPtKB52+YSI1pkmoy+H3QpehVWnjjRBNHyFFKQ2dP9e41SHC/gfe35Ey1VWM0X7x4Nzhw==
X-Received: by 2002:a17:906:7190:: with SMTP id h16mr3641973ejk.221.1606320568845;
        Wed, 25 Nov 2020 08:09:28 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id g15sm989350edj.49.2020.11.25.08.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 08:09:27 -0800 (PST)
Subject: Re: [PATCH 2/3] iio: accel: bmc150: Check for a second ACPI device
 for BOSC0200
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20201125083618.10989-1-hdegoede@redhat.com>
 <20201125083618.10989-3-hdegoede@redhat.com>
 <CAHp75VcZQ1duxHnUTD9ewRhWxoHay8S6AQaEK3v3jJr+oQcbDw@mail.gmail.com>
 <ee0d26b1-ee54-0c2c-cd9f-40366e3b10d4@redhat.com>
 <CAHp75Vc7v4z=VkaopsfXoJfFMxt9GxS6iofjNvOcUQrauKhDXA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9f0f2060-24cf-cc7b-9089-9f5c8e024e39@redhat.com>
Date:   Wed, 25 Nov 2020 17:09:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc7v4z=VkaopsfXoJfFMxt9GxS6iofjNvOcUQrauKhDXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/25/20 12:20 PM, Andy Shevchenko wrote:
> On Wed, Nov 25, 2020 at 1:11 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 11/25/20 11:55 AM, Andy Shevchenko wrote:
>>> On Wed, Nov 25, 2020 at 10:37 AM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> ...
> 
>>> I'm wondering if we can meanwhile update hwdb to support
>>> i2c-multi-instantiate cases in the future and in a few years switch to
>>> it.
>>
>> Even if we fix current hwdb entries to match on both, then there
>> is no guarantee newly added entries will also contain the new match.
>>
>> Now with the code to get the matrix from the ACPI tables new entries
>> should happen less often, but I saw at least one model where the ACPI
>> provided matrix appears to be wrong (if the ACPI matrix was always
>> correct then breaking hwdb would not really be an issue).
>>
>> So I don't think this is going to work and all in all it feels like
>> a lot of work for little gain.
> 
> Okay!
> 
> ...
> 
>>>> +                       .dev_name = "BOSC0200:base",
>>>
>>> Hmm... Can we use '.' (dot) rather than ':' (colon) to avoid confusion
>>> with ACPI device naming schema? (Or was it on purpose?)
>>
>> So with the ':' the end result is:
>>
>> [root@localhost ~]# cd /sys/bus/i2c/devices/
>> [root@localhost devices]# ls | cat
>> 6-0050
>> i2c-0
>> i2c-1
>> i2c-2
>> i2c-3
>> i2c-4
>> i2c-5
>> i2c-6
>> i2c-BOSC0200:00
>> i2c-BOSC0200:base
>> i2c-WCOM50BD:00
>>
>> Which looks nice and consistent, which is why I went with the ':'
>> and since base is not a number, there is no chance on conflicting with
>> ACPI device names (it does look somewhat like an ACPI device name, but
>> it is an ACPI enumerated device, so ...).
> 
> I see. So this was made on purpose.
> 
>> Anyways if there is a strong preference for changing this to a '.'
>> I would be happy to make this change.
> 
> No strong preferences from my side.
> 
>>> And this seems to be the only device in the system, second as this is
>>> not allowed as far as I understand. Right?
>>
>> I don't understand what you are trying to say here, sorry.
>>
>>> But theoretically I can
>>> create an ACPI SSDT with quite similar excerpt and sensor and
>>> enumerate it via ConfigFS (I understand that is quite unlikely).
> 
> What if you have two devices with the same ID and both have two
> I2cSerialBusV2() resources? Second one can't be instantiated because
> 'base' is already here.
> Making it like i2c-BOSC0200:00.base would be much better in my opinion.

Ah I see, that is a somewhat valid point. But I really never expect
there to be 2 ACPI devices with a BOSC0200 hw-id, while also specifying
more then 1 i2c-client per node. That would just be all kinds of messed-up.

Thinking about this I think that getting a WARN_ON (and thus a bug report)
about a duplicate kobject-name when this happens would actually be good,
because then we need to figure out what the beep is going on on that
system. Note that other then triggering a WARN_ON the second
i2c_acpi_new_device will simply fail in this very unlikely scenario
(I know because I triggered this by accident while working on the patch).

Since in a way getting this WARN_ON is actually good (lets us know about
completely unexpected circumstances) and that making the name dynamic
as you suggest requires a bit of extra code I would actually prefer to
keep this as. Please let me know if that is ok with you.

Regards,

Hans

