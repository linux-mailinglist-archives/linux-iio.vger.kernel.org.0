Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA622CA2A0
	for <lists+linux-iio@lfdr.de>; Tue,  1 Dec 2020 13:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgLAMY1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Dec 2020 07:24:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728349AbgLAMY0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Dec 2020 07:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606825379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nzMJ4YJJYVmEa05xZ9YTXS1BAzz1en7JR38KykIbv5c=;
        b=e0Kw5Xeekj8l0c0sCnlmlHvipG6jHY1ctvhH+T158KUVO9aftonoO+h66yp5368X/Fl5mi
        vrgPGSRUNV1hHJ1OTaxyqnv9DHdOw4FJQVvjtjYEgkuD2PXnje5phTstuBxASeVEU+D8v7
        NC/Nw/OaeZI9chDD+HLkxyPz4/WIU/U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-0eszcR4cORmIqictDZZN-Q-1; Tue, 01 Dec 2020 07:22:58 -0500
X-MC-Unique: 0eszcR4cORmIqictDZZN-Q-1
Received: by mail-ej1-f69.google.com with SMTP id lz20so1137483ejb.13
        for <linux-iio@vger.kernel.org>; Tue, 01 Dec 2020 04:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nzMJ4YJJYVmEa05xZ9YTXS1BAzz1en7JR38KykIbv5c=;
        b=qHjFY9l79cvzDLnQGqsc8APPatxkQknBmAu8gcJ8Cn0kUZTLnnC7lEaiBPZUuDhzTP
         NneVuDGeon/0veR65hryUhsFZfSnhoPtu83haYBzlAuVfASe7Wl82AHofIqdhgtgt37h
         eTGsFfqfmeFHraztYeHqkOrSSe2PtGGkCbg/U2W/9cBa11yVXxhCrRYSCXyf7o0OhvM+
         8ikcbgNkyX7qZV0i59KBd2dGsuuZ0fwcw9D5slVfcyz3F1p7YxIk80AxQ5mW3yJeq7Ri
         P4FyZ3ibowdmMg+Q6ERnzByVGVB9esJYuFcbqSDj3kOatGtU2GiiJX5gvx4E+OZm3+nF
         l8kA==
X-Gm-Message-State: AOAM5310U/gwq4h38MUYd9A4/vfZ+8n8fiqPSQ0u2RqM2Kjru7RT4JnV
        A6zHESeej45ogOnbkpcgxGqnSlAoFJiaJp/CQN3bZHPTHLHS6EfXLohtRkX3Nh/duz/Suv0FS9T
        5nU8/iGlgjZNq/FvkReDPSOOIQk7zZX/VmXKKwOX7Mh0xg1DaTPl/sfKSgcsL1n94eeObf/Hh
X-Received: by 2002:a17:907:20a6:: with SMTP id pw6mr2790946ejb.73.1606825376941;
        Tue, 01 Dec 2020 04:22:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfgqiKDv/lnv1gfixXiQOXEZHoUOhpbkIilmrZ/cm3xuvivt1Zp93AxhQ03Xm/5qFpTt2Wdg==
X-Received: by 2002:a17:907:20a6:: with SMTP id pw6mr2790891ejb.73.1606825376159;
        Tue, 01 Dec 2020 04:22:56 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id e11sm755445ejz.94.2020.12.01.04.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 04:22:55 -0800 (PST)
Subject: Re: [PATCH v2 1/3] iio: accel: bmc150: Removed unused
 bmc150_accel_dat irq member
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20201130141954.339805-1-hdegoede@redhat.com>
 <CAHp75Vd2Jhep0z7i3_5jnvsnMN2zyudCRM6YNy_neCd6_ydSvw@mail.gmail.com>
 <20201130204536.71d67c07@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0ed3fc11-2de7-716d-d2c2-d6ba00d3aa73@redhat.com>
Date:   Tue, 1 Dec 2020 13:22:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130204536.71d67c07@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/30/20 9:46 PM, Jonathan Cameron wrote:
> On Mon, 30 Nov 2020 16:32:21 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
>> On Mon, Nov 30, 2020 at 4:20 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> The bmc150_accel_dat struct irq member is only ever used inside
>>> bmc150_accel_core_probe, drop it and just use the function argument
>>> directly.  
>>
>> FWIW, for all three
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> This crossed with a series adding regulator control to this driver, but I'm fairly
> sure that won't cause any problems so I've dealt with the fuzz and applied it anyway.
> 
> However...
> 
> drivers/iio/accel/bmc150-accel-i2c.c: In function ‘bmc150_accel_probe’:
> drivers/iio/accel/bmc150-accel-i2c.c:55:28: error: implicit declaration of function ‘acpi_device_hid’; did you mean ‘dmi_device_id’? [-Werror=implicit-function-declarati
> on]                                                                                                                                                                      
>    55 |  if (!id && adev && strcmp(acpi_device_hid(adev), "BOSC0200") == 0) {
>       |                            ^~~~~~~~~~~~~~~            
>       |                            dmi_device_id
> drivers/iio/accel/bmc150-accel-i2c.c:55:28: warning: passing argument 1 of ‘strcmp’ makes pointer from integer without a cast [-Wint-conversion]
>    55 |  if (!id && adev && strcmp(acpi_device_hid(adev), "BOSC0200") == 0) {
>       |                            ^~~~~~~~~~~~~~~~~~~~~
>       |                            |
>       |                            int
> 
> 
> I've added #ifdef CONFIG_ACPI around the relevant block and shuffled around assignment of
> adev + added a __maybe_unused marking to it.  Perhaps I should have pulled that block
> out into another function but it seemed more trouble than it was worth.

Thanks, the fixed up version looks good.

And sorry for not catching this myself, some of the ACPI functions are stubbed
when CONFIG_ACPI is not set and I was relying on this here. But I missed acpi_device_hid()
not being stubbed.

I was aware I was using some unstubbed things in patch 3/3 so that already had the #if CONFIG_ACPI.

> Please sanity check I didn't mess it up.

Done, I'll also add the final version to my local tree so that its get tested
when I spin that up on one of the affected devices.

> Series applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to see what else we missed.

Thanks & Regards,

Hans



>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>  drivers/iio/accel/bmc150-accel-core.c | 7 ++-----
>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
>>> index 48435865fdaf..088716d55855 100644
>>> --- a/drivers/iio/accel/bmc150-accel-core.c
>>> +++ b/drivers/iio/accel/bmc150-accel-core.c
>>> @@ -183,7 +183,6 @@ enum bmc150_accel_trigger_id {
>>>
>>>  struct bmc150_accel_data {
>>>         struct regmap *regmap;
>>> -       int irq;
>>>         struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
>>>         struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
>>>         struct mutex mutex;
>>> @@ -1568,7 +1567,6 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>>>
>>>         data = iio_priv(indio_dev);
>>>         dev_set_drvdata(dev, indio_dev);
>>> -       data->irq = irq;
>>>
>>>         data->regmap = regmap;
>>>
>>> @@ -1599,9 +1597,8 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>>>                 return ret;
>>>         }
>>>
>>> -       if (data->irq > 0) {
>>> -               ret = devm_request_threaded_irq(
>>> -                                               dev, data->irq,
>>> +       if (irq > 0) {
>>> +               ret = devm_request_threaded_irq(dev, irq,
>>>                                                 bmc150_accel_irq_handler,
>>>                                                 bmc150_accel_irq_thread_handler,
>>>                                                 IRQF_TRIGGER_RISING,
>>> --
>>> 2.28.0
>>>  
>>
>>
> 

