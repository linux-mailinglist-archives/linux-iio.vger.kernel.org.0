Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1303E34CE46
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 12:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhC2KxV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 06:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhC2Kww (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 06:52:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F867C061574;
        Mon, 29 Mar 2021 03:52:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso4979045pjh.2;
        Mon, 29 Mar 2021 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xrN3y8SFuswUEy9SstpaTFpKn84sjynD3sgeMPr3kys=;
        b=eOj/2SP4af+P3Nh5IKpHWMieBOCJ8HibDTBjFSBNTgLz6Opk7mcXcSJfzKo5YoaGdS
         7rR1VdkTkVr9X7csKPcVMD2Eh+ksQeQEvsadqK48acBROtg/XzFjMmN1ZNAfLAz2SNo9
         NjGUZaMkmwPlmyjMOGogBCY9NVA46XhTs4BkVnOoYgcQgySKFW9kTC8RL1s9SvcoD3dO
         B/+55lSSg/fmuX/w0aPqFhkF76qabjYB9H0tcWkSHhs/3pIISDzhOAK45LHAFGY7ZulS
         9MjdQm4bDgwoxo0XZ80WffcHpEqP6Gfl7oWq02sG0C9jOq94aLVuwXkT+ay674wDIFlO
         RNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xrN3y8SFuswUEy9SstpaTFpKn84sjynD3sgeMPr3kys=;
        b=Cf040NIHc0hyl2QToIN8xkw51jj6ShbDrt/yOPcEO/jJuV7/RW1TG7SqyJnG1Wmhcf
         EBAuB8kGKgbvI64X+98R9V/Y58BmhbQyLB3OGuG1J+tTCa7YJPRa2qQbj/B8Y2iCBEl2
         ZsgdFDrFjHa1F4w1ajgJC6TZHqI02LqvCZXhGYuVSt09Ll+BF7pbkisap3+vlpWT3wEZ
         NYU4iF+9ee3wMK+d7kMicncfF6akHtmRhcdN+nXcAz/YpBhuvCIc4IpLDaxHQDrFHT1w
         ih2WusPQ2WmYIRCDn4Qh8Bb6mVGsO+pqpAc+baX1jmWCYLPU2ywTH2HMupbO6qbwFAJc
         OIkQ==
X-Gm-Message-State: AOAM530VqFiTTd+1MxKQSHrJVz0Bo1bx0IrSpxVK8S8ZznyGUeCRdhaa
        6uUt7jHmX5Qi3dxt5Nnn+npaRo9go1Wd+8Hf/L8=
X-Google-Smtp-Source: ABdhPJzmMjAr0Aw18HLpbxH+HNqlRRkm1Xnyf0R376212BmMML35Y/+VCDVF9sBiu+dd6CORmiiDgWqGsCyjFx5f/8M=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr26954806pjx.181.1617015171450;
 Mon, 29 Mar 2021 03:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210328180124.8762-1-dmugil2000@gmail.com> <CAHp75Vdv4zAsn_v1TaUcYgY_PpQrfhfGNsc8=QTbPY=oFN_xbA@mail.gmail.com>
In-Reply-To: <CAHp75Vdv4zAsn_v1TaUcYgY_PpQrfhfGNsc8=QTbPY=oFN_xbA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Mar 2021 13:52:35 +0300
Message-ID: <CAHp75VdS=Px4MdhA5mzzqaQEsMs3ur76m+tYb1inVqBFfu_CRA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: da280: Drop unnecessarily used braces
To:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+Cc: Hans (just for your opinion)

On Sun, Mar 28, 2021 at 10:40 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sunday, March 28, 2021, Mugilraj Dhavachelvan <dmugil2000@gmail.com> w=
rote:
>>
>> As per linux kernel coding style braces are not needed for single
>> statement.
>> Checkpatch
>> warning: braces {} are not necessary for any arm of this statement
>> 128: FILE: drivers/iio/accel/da280.c:128:
>>
>
> While it=E2=80=99s the correct patch, I would rather recommend making the=
 driver non-ACPI centric. I.e.:
> - replace that custom function by device_get_match_data() call
>
> - replace that condition by something like
> type =3D device_get_match_data();
>
> - drop ACPI_PTR()
>
> - replace acpi.h by mod_devicetable.h and property.h
>
> - convert to use ->probe_new()
>
>
>  Everything, except the last one is in one patch, the last one is another=
 patch.
>
>
>
>> Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
>> ---
>>  drivers/iio/accel/da280.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
>> index 227bea2d738b..31f290ae4386 100644
>> --- a/drivers/iio/accel/da280.c
>> +++ b/drivers/iio/accel/da280.c
>> @@ -125,11 +125,10 @@ static int da280_probe(struct i2c_client *client,
>>         indio_dev->modes =3D INDIO_DIRECT_MODE;
>>         indio_dev->channels =3D da280_channels;
>>
>> -       if (ACPI_HANDLE(&client->dev)) {
>> +       if (ACPI_HANDLE(&client->dev))
>>                 chip =3D da280_match_acpi_device(&client->dev);
>> -       } else {
>> +       else
>>                 chip =3D id->driver_data;
>> -       }
>>
>>         if (chip =3D=3D da226) {
>>                 indio_dev->name =3D "da226";

--=20
With Best Regards,
Andy Shevchenko
