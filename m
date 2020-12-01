Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BD52CA33A
	for <lists+linux-iio@lfdr.de>; Tue,  1 Dec 2020 13:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgLAM4a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Dec 2020 07:56:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726166AbgLAM43 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Dec 2020 07:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606827302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dY1ktGYQPbW9eQhTbpAumEkwdFVefb454G+9cbQinPo=;
        b=gwIcyLP83UW2aRKPMJ9kMHMpGUkMLtUWgSPz2CljvPSlIhE40ZfpHJwnVykZtplSTtbIZ7
        ZzicXvEYLgEPOpa6Oq+JWDoYsXVMJkLsYKDaqkbKkRdxi9i35m6LsqjPfUE2p2tDcL28dc
        h42XSe6qeifTx3WhiM1D5lr7Dqv4hVE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-qBGA2uRmNoW7hjDDSDI02Q-1; Tue, 01 Dec 2020 07:55:01 -0500
X-MC-Unique: qBGA2uRmNoW7hjDDSDI02Q-1
Received: by mail-ej1-f69.google.com with SMTP id f2so1175142ejx.22
        for <linux-iio@vger.kernel.org>; Tue, 01 Dec 2020 04:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dY1ktGYQPbW9eQhTbpAumEkwdFVefb454G+9cbQinPo=;
        b=qlJRVjG9wutfqSRrRyYUfBcwkrNyS12VRiy9eMMfjrQl5CczkxmFukMls5Ucve1Bx9
         vCThsUIWRhwCA5/+1+9utNXQZ2trMGJdas6QsuSrHl2cvdEG/kH0IDb5oZYw83wsf/GL
         Ys6NmGaQZDBuWNah+AMRcAxrZCLpwK9gaI5NVnqMNyvHI6gJLA+Ts0Zd3CmEMMAwq6Ue
         VmO5h1YsyLDGyrYEXggHCgf9L+1AqiwoApG6Z7G3+YBfkpIHiCyKVjpoxB8b9qXqJl+X
         ulI7zuLuigvcDYh/9exE60cq2UaBlTZSz3l9oPIO6HtliujeVql386MWXzk/xRnoKB45
         7bMQ==
X-Gm-Message-State: AOAM531WL8f2FQ1xqJp4bIVRUmIs3qds6B12LWsKny1pn6xvQ0NMmtz1
        eJ66otWSLwwhF5UxrxEBqRKH/6YZYmX+zsMtEy7RNvglvBjar6dXWLaesJuAVZbMGkQ3BrqmScb
        snE2rak0pWCqtYSuPWx1/CwAtoiFR+i3OgC1UhIZsB9Q9OhHLHJ12S1lR289ZYVKJPn4aTNQA
X-Received: by 2002:a17:906:13c5:: with SMTP id g5mr2845198ejc.125.1606827299648;
        Tue, 01 Dec 2020 04:54:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5HHDZQyHRvVg09utCRZ8x/ASD7S9WBsMcSHEL/7uXi+tMb95Um5X8JQzKQ/BEi2xXsVRYbA==
X-Received: by 2002:a17:906:13c5:: with SMTP id g5mr2845176ejc.125.1606827299388;
        Tue, 01 Dec 2020 04:54:59 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id mc25sm801991ejb.58.2020.12.01.04.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 04:54:58 -0800 (PST)
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
Message-ID: <fc211713-a98b-e79c-865d-0191117b8ede@redhat.com>
Date:   Tue, 1 Dec 2020 13:54:57 +0100
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
> 
> I'm slightly confused on how I ended up with a test .config that doesn't have CONFIG_ACPI
> but that's another story and handy on this occasion as we didn't have to wait for 0-day
> to notice this.
> 
> Please sanity check I didn't mess it up.

FWIW I decided to go the full mile and since I cherry-picked the final versions
of the patches (including the regulator changes) into my local tree anyway
I decided to spin it up on a Thinkpad Yoga 11e 4th gen which has the dual accelerometer
setup.

I'm happy to report that the final version of the patches work as advertised
there.

Regards,

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

