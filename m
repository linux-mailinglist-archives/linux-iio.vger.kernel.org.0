Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE60D156861
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2020 03:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgBICQT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Feb 2020 21:16:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39552 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgBICQS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2020 21:16:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so1357624plp.6
        for <linux-iio@vger.kernel.org>; Sat, 08 Feb 2020 18:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=YMpI+b9RK5TKGFR1AIolsJGEcZ+TBGpy0+0vs/aP9xo=;
        b=OGF7tH9ATuAyrNJoognanMKVHY5fQOTocIrCcqCno8U7xTO+J/Adlez2JGfJsypCLs
         VnhpItbOtWGwUhrQfebL16mBTiMM03udBhX3U2LZO1GgzQ9FqGXGsLEV0i2wd2slCY2r
         JB+X5WnyGfweG2AfgimSoad8qZaVWptc/qElI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=YMpI+b9RK5TKGFR1AIolsJGEcZ+TBGpy0+0vs/aP9xo=;
        b=FvPpSFaSFGCWD2mTW6TiwnAwlxdGpq9Rs7FJ5Vy4MW0wdaXwnZx98Yl4ga2fZb+7DJ
         T8BRlSGaE0mlGaYd8G7i7pDmux55rXJWhiBzt+Qq2VnMGKtAApZBdCgyzUKB3xp1o18k
         +CJHjdzEDPRteywW7sI7CfmJ922H1M5Nq8kAzedbYlgXbxtKb636gKfMiMvGvwC59dFb
         aC0ZEwkY5Yc9fLLeuXHU2uhOtyqWb4fZ4+1AaCdD01L/qmKdxu5ZgE24TN5zI7R2IQyx
         k1sC3FiIjt8L0hM1Kg1zpfPvVf/ttS2qyEhEAyQhXF+vY9iAhmTSMFnUm17iI73B/r/O
         EXVw==
X-Gm-Message-State: APjAAAXwoujJkqQG5YN6ckqhCsU2yV3TCQIv56Qb87j7ddt7M5yYAX0V
        dRdhPP3guqAyYbwSEQlgSx615nauhon/EA==
X-Google-Smtp-Source: APXvYqzUOCc2Z2UbQ02OtqhP2086ncLBf4hJlgzrSqdtTg7scTCjLySsgYbE2LgmeKaN2dinZZTj8g==
X-Received: by 2002:a17:902:462:: with SMTP id 89mr6388224ple.270.1581214576948;
        Sat, 08 Feb 2020 18:16:16 -0800 (PST)
Received: from ?IPv6:2607:fb90:8069:34d2:d9c6:52af:ebc5:2b0? ([2607:fb90:8069:34d2:d9c6:52af:ebc5:2b0])
        by smtp.gmail.com with ESMTPSA id r198sm8161063pfr.54.2020.02.08.18.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2020 18:16:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 1/3] iio: chemical: atlas-sensor: allow probe without interrupt line
Date:   Sat, 8 Feb 2020 18:16:15 -0800
Message-Id: <8E70519D-46F2-4318-A1C7-F180B0B37084@konsulko.com>
References: <09D15D9D-2EBD-4BFF-A5BA-FA0B25F0E750@konsulko.com>
Cc:     linux-iio@vger.kernel.org
In-Reply-To: <09D15D9D-2EBD-4BFF-A5BA-FA0B25F0E750@konsulko.com>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> On Feb 8, 2020, at 18:12, Matt Ranostay <matt.ranostay@konsulko.com> wrote=
:
>=20
> =EF=BB=BF
>=20
>>> On Feb 8, 2020, at 08:39, Jonathan Cameron <jic23@kernel.org> wrote:
>>>=20
>>> =EF=BB=BFOn Wed,  5 Feb 2020 22:13:30 -0800
>>> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>>>=20
>>> Sensors don't actually need a interrupt line to give valid readings,
>>> and can triggered with CONFIG_IIO_HRTIMER_TRIGGER as well. Remove
>>> the required check for interrupt, and continue along in the probe
>>> function.
>>=20
>> Basic aim is good, but if you don't have an interrupt doesn't make
>> sense to register the trigger either.
>>=20
>> The interrupt enable / disable is also tied up with the buffer whereas
>> it should probably be done via the trigger enable callback or am I
>> missing something?
>=20
> It was for allowing sysfs and hrtimer triggers. But just remembered most t=
hese sensors have a low refresh rate. I can go either way on having it or no=
t. Thoughts?
>=20
> - Matt
>=20
=20
Also issue one issue was fixed in v5 related to this.

- Matt
>=20
>>=20
>> Jonathan
>>=20
>>>=20
>>> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
>>> ---
>>> drivers/iio/chemical/atlas-sensor.c | 27 ++++++++++++---------------
>>> 1 file changed, 12 insertions(+), 15 deletions(-)
>>>=20
>>> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/=
atlas-sensor.c
>>> index 2f0a6fed2589..2e34c82cb65d 100644
>>> --- a/drivers/iio/chemical/atlas-sensor.c
>>> +++ b/drivers/iio/chemical/atlas-sensor.c
>>> @@ -572,11 +572,6 @@ static int atlas_probe(struct i2c_client *client,
>>>   if (ret)
>>>       return ret;
>>>=20
>>> -    if (client->irq <=3D 0) {
>>> -        dev_err(&client->dev, "no valid irq defined\n");
>>> -        return -EINVAL;
>>> -    }
>>> -
>>>   ret =3D chip->calibration(data);
>>>   if (ret)
>>>       return ret;
>>> @@ -596,16 +591,18 @@ static int atlas_probe(struct i2c_client *client,
>>>=20
>>>   init_irq_work(&data->work, atlas_work_handler);
>>>=20
>>> -    /* interrupt pin toggles on new conversion */
>>> -    ret =3D devm_request_threaded_irq(&client->dev, client->irq,
>>> -                    NULL, atlas_interrupt_handler,
>>> -                    IRQF_TRIGGER_RISING |
>>> -                    IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>>> -                    "atlas_irq",
>>> -                    indio_dev);
>>> -    if (ret) {
>>> -        dev_err(&client->dev, "request irq (%d) failed\n", client->irq)=
;
>>> -        goto unregister_buffer;
>>> +    if (client->irq <=3D 0) {
>>> +        /* interrupt pin toggles on new conversion */
>>> +        ret =3D devm_request_threaded_irq(&client->dev, client->irq,
>>> +                NULL, atlas_interrupt_handler,
>>> +                IRQF_TRIGGER_RISING |
>>> +                IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>>> +                "atlas_irq",
>>> +                indio_dev);
>>> +
>>> +        if (ret)
>>> +            dev_warn(&client->dev,
>>> +                "request irq (%d) failed\n", client->irq);
>>>   }
>>>=20
>>>   ret =3D atlas_set_powermode(data, 1);
>>=20
