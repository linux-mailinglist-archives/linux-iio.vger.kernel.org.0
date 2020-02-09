Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61AF15685D
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2020 03:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBICMG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Feb 2020 21:12:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43102 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgBICMG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2020 21:12:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id p11so1346401plq.10
        for <linux-iio@vger.kernel.org>; Sat, 08 Feb 2020 18:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=NQm3tBlQmE/dtGkc6VWDmwgm9DYExgTTEv71VFPKodU=;
        b=prSlBcPuFJtXNyN+yExhUhvJ0vstJM+lPyEK7T0waEDQoH87Yz+RNFJMDlNkicNnQ1
         cNl9RRaYD2J6dgzQjZUmugBFMmXIe2QYzd9SUQJHL8kmwxCJAtczBFtmr2hpZin0xoli
         0rZ7XRqyBomjavM8Sh/P1+7EoOUw26IEpTN4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=NQm3tBlQmE/dtGkc6VWDmwgm9DYExgTTEv71VFPKodU=;
        b=JDP5Z/h0rMxCdtDiRpf0zlUrF/xYDTrplbzZIUz2DbzLeg5rYqiwZKrr8IgVfADdqa
         BZVhHjxuz84A6SKFGcVAKzv9rq3zry3cL74+edISDYBhAVdIbwi7TjvUPSPnLKKR3CzB
         g0onENr6IzYkBq3VYs7hSoGquzrOZBbRvoco9tC47cZ5tPCuVJHSFvzyIkIxer3CEJPX
         rOBBi+OMkPo4Sta0USkcQQEwQOtpsbpma5OoXrPzBuHO81kKvd34Dlea4fdw9fEfmxfa
         QBkFJQCB2MJtqAQszIFjb/X7Ko0hmmFH+LJ/jUvlV2AJtOGFSW5TVrAMWwPZxyrdgIdS
         EFyA==
X-Gm-Message-State: APjAAAV75qTfuYwHEbLqQ+fE1KzZdk3DpYu0kTlArjFeH/5UpTRR6+QH
        35RlwoympK5O7JElN0owTABNWlmZm0NjCw==
X-Google-Smtp-Source: APXvYqyJm+5uYbqWfNv4vVPjYcLq468EYbaaVdFJxHWNf5EKsC1F0QA2MbcsrcA/W1nCP3iLKpJDXQ==
X-Received: by 2002:a17:90a:b318:: with SMTP id d24mr13740018pjr.142.1581214325552;
        Sat, 08 Feb 2020 18:12:05 -0800 (PST)
Received: from ?IPv6:2607:fb90:8069:34d2:d9c6:52af:ebc5:2b0? ([2607:fb90:8069:34d2:d9c6:52af:ebc5:2b0])
        by smtp.gmail.com with ESMTPSA id g9sm7684911pfm.150.2020.02.08.18.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2020 18:12:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 1/3] iio: chemical: atlas-sensor: allow probe without interrupt line
Date:   Sat, 8 Feb 2020 18:12:03 -0800
Message-Id: <09D15D9D-2EBD-4BFF-A5BA-FA0B25F0E750@konsulko.com>
References: <20200208163943.098ba614@archlinux>
Cc:     linux-iio@vger.kernel.org
In-Reply-To: <20200208163943.098ba614@archlinux>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> On Feb 8, 2020, at 08:39, Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> =EF=BB=BFOn Wed,  5 Feb 2020 22:13:30 -0800
> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>=20
>> Sensors don't actually need a interrupt line to give valid readings,
>> and can triggered with CONFIG_IIO_HRTIMER_TRIGGER as well. Remove
>> the required check for interrupt, and continue along in the probe
>> function.
>=20
> Basic aim is good, but if you don't have an interrupt doesn't make
> sense to register the trigger either.
>=20
> The interrupt enable / disable is also tied up with the buffer whereas
> it should probably be done via the trigger enable callback or am I
> missing something?
=20
It was for allowing sysfs and hrtimer triggers. But just remembered most the=
se sensors have a low refresh rate. I can go either way on having it or not.=
 Thoughts?

- Matt


>=20
> Jonathan
>=20
>>=20
>> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
>> ---
>> drivers/iio/chemical/atlas-sensor.c | 27 ++++++++++++---------------
>> 1 file changed, 12 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/a=
tlas-sensor.c
>> index 2f0a6fed2589..2e34c82cb65d 100644
>> --- a/drivers/iio/chemical/atlas-sensor.c
>> +++ b/drivers/iio/chemical/atlas-sensor.c
>> @@ -572,11 +572,6 @@ static int atlas_probe(struct i2c_client *client,
>>    if (ret)
>>        return ret;
>>=20
>> -    if (client->irq <=3D 0) {
>> -        dev_err(&client->dev, "no valid irq defined\n");
>> -        return -EINVAL;
>> -    }
>> -
>>    ret =3D chip->calibration(data);
>>    if (ret)
>>        return ret;
>> @@ -596,16 +591,18 @@ static int atlas_probe(struct i2c_client *client,
>>=20
>>    init_irq_work(&data->work, atlas_work_handler);
>>=20
>> -    /* interrupt pin toggles on new conversion */
>> -    ret =3D devm_request_threaded_irq(&client->dev, client->irq,
>> -                    NULL, atlas_interrupt_handler,
>> -                    IRQF_TRIGGER_RISING |
>> -                    IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> -                    "atlas_irq",
>> -                    indio_dev);
>> -    if (ret) {
>> -        dev_err(&client->dev, "request irq (%d) failed\n", client->irq);=

>> -        goto unregister_buffer;
>> +    if (client->irq <=3D 0) {
>> +        /* interrupt pin toggles on new conversion */
>> +        ret =3D devm_request_threaded_irq(&client->dev, client->irq,
>> +                NULL, atlas_interrupt_handler,
>> +                IRQF_TRIGGER_RISING |
>> +                IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +                "atlas_irq",
>> +                indio_dev);
>> +
>> +        if (ret)
>> +            dev_warn(&client->dev,
>> +                "request irq (%d) failed\n", client->irq);
>>    }
>>=20
>>    ret =3D atlas_set_powermode(data, 1);
>=20
