Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48026431181
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 09:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhJRHnW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 03:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhJRHnV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 03:43:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC41AC06161C;
        Mon, 18 Oct 2021 00:41:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a25so67323631edx.8;
        Mon, 18 Oct 2021 00:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvyc7lXYEn3ZHyaBahJODZ1u5FA0Z1xlS6IA6NF8Q1Q=;
        b=Vtm1lb1f6UKaT4L9gaV462C5J6tU0WmvwuSaV+Nm9HtR3mVpkPGb8xXZfVw/mfdoUc
         NPOmGUQrFMyUS+SJrziYwVqgoS43dN9cc9idt/Zf8MtU7mD0sjWYa/zZy706LwbUfU4z
         Pgfhvzn6gkQXFW2sADVbZMoufMACn16abUSTqg20Pwx9nrhTfG9RVCgrbnyInEmKJinV
         J4iOsnbche2HpSNGOLQAVgFOfzvmfZN5NpCuH/BGC+lYiSMr8glDFMrbXmdsOHmgRm7B
         X3qjX9vrumen4/cZD8lh2zGvlHK6ByeC1FAWr2PXLNZM7HivC4RNRznWQ7cITenQ92vG
         snBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvyc7lXYEn3ZHyaBahJODZ1u5FA0Z1xlS6IA6NF8Q1Q=;
        b=ZRnDt8SAdHmpcwR1L7uRkYt0fi1LXO6gmzpIbqknercXqodV99+F4GpnnWugBhPyVY
         Z7zHWoziaSKdvpENsLZM7x6R/hP3BJN7NXvIh6va5eTXjG7F1pvNaX5Q0DKG06XaWVqz
         kTXv3B66jZ7XqKOJNJDqhKpVnrRSsIuqJ2pZ3yzrhn75XgukildQ3vzDWCYw+y8qDj4G
         qCa8vxI/68Am9K+KYIAofF6Cv+iJ5YvA/d2eZTxKw5ecFpbKKrwr/lpZa9jCXAvTSDoE
         +IYwlSvHVcQl6a3ok+iNBDoK6gQ/5Bkt/fNZe43Uclnj27z/99aHcp9QpWNHrc6NUPcA
         xHeQ==
X-Gm-Message-State: AOAM530LvfGGaZBfqhfytFiPzQO7YJhE+46q//SwH8HLPFH6DcaxFRTL
        cJbjnsYCSH0WwwB7ZnB0R82KJc7zgpz7GrfkFrs=
X-Google-Smtp-Source: ABdhPJwq5/ieXR4Pnzr/MTiDtOPg8LoqM6nm/bL6cklXBPRW6C5fnicEeBXnLyHiUj0X5jOzSSdYDYjpxD5DXN3vjfI=
X-Received: by 2002:a50:e188:: with SMTP id k8mr43786153edl.119.1634542869041;
 Mon, 18 Oct 2021 00:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
 <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com> <20211017115843.2a872fbe@jic23-huawei>
In-Reply-To: <20211017115843.2a872fbe@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Oct 2021 10:40:33 +0300
Message-ID: <CAHp75Vct-AXnU7QQmdE7nyYZT-=n=p67COPLiiZTet7z7snL-g@mail.gmail.com>
Subject: Re: BMI160 accelerometer on AyaNeo tablet
To:     Jonathan Cameron <jic23@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+Cc: Hans

On Mon, Oct 18, 2021 at 6:41 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 16 Oct 2021 19:27:50 +0300
> Maxim Levitsky <maximlevitsky@gmail.com> wrote:
>
> >  BMI160: AYA NEA accelometer ID

accelerometer

> >     On AYA NEO, the accelerometer is BMI160 but it is exposed
> >     via ACPI as 10EC5280
> >
> >     Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>
> I guess it is hopelessly optimistic to hope that we could let someone
> at the supplier know that's a totally invalid ACPI id and that they
> should clean up their act.
>
> Curiously it looks like a valid PCI ID pair though for a realtek device.
>
> Ah well.  Applied to the iio-togreg branch of iio.git and pushed out
> as testing to see if 0-day can find any issues with it.

NAK. And I explain below why and how to make progress with it.

The commit message should contain at least the link to the DSDT and
official technical description of the platform. Besides that, it
should have a corresponding comment near to the ID in the code.

On top of that, in particular to this case, the ID is very valid from
the ACPI specification point of view, but in this case it's a
representation of the PCI ID 10ec:5280 which is Realtek owned. So, we
need to hear (okay in reasonable time) from Realtek (I believe they
are active in the Linux kernel) and that OEM.

I hardly believe that Realtek has issued a special ID from the range
where mostly PCIe ports or so are allocated, although it's possible.
We need proof.

What I believe is the case here is that OEMs are just quite diletants
in ACPI and firmware and they messed up with BIOS somehow that it
issued the ID for the device.
There are also two other possibilities: OEM stole the ID (deliberately
or accidentally), or the device is not just gyro, but something which
contains gyro.

As to the last paragraph, see above, we must see DSDT. Without it I
have a strong NAK.

P.S. Jonathan, please do not be so fast next time with ACPI IDs.

-- 
With Best Regards,
Andy Shevchenko
