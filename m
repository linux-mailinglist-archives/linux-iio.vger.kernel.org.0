Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F847291891
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 19:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgJRRRB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 13:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgJRRRA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 13:17:00 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66744C061755
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 10:17:00 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id n6so10164174ioc.12
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2020 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWtLc/tNEdINtzZjjThWS6Vpo7qgkp7EiP1jjZAyPlM=;
        b=WvemCXb+CWug9wB16mmYK5NYVzodouwwv6s6swcEKrBZ7Ve5tL2yeO74JIep4OqVFo
         g93heqyMzpjhBxjrwF5anOltXs8XKNky4QZXjls8v5/I8g81B+SFdEwlcmhOqFjp1S4h
         d2Ivvf8Vc31y6sLyJcRV6pLHQpIjZQfkJlN/W3S7k8/arbYqGau1rApB5UjgCybQb9O8
         vsKO/LlmpirEuaU8ep7BaySvAvlbKpI36Buur3UjR3crHkow6bZEHKVPr9qbvkajWCuF
         eCd1ko3rX0dES8eTPmxe3bHXCDwekM/yK1zefpDoPexSNdigdHpd0ff5Y/s0cOd/E9sb
         wwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWtLc/tNEdINtzZjjThWS6Vpo7qgkp7EiP1jjZAyPlM=;
        b=lJ1jwXIpUInq4q2QlIieQbI6BDF6yqLCCL8sWZSNrsQcBOFUj1yQBrDak1R41+KY7J
         24UOnBafdUDuECrESXaDUBk4YITHGfVHzABHgC6UNoaiHq7ekaC+k2ad7X8npF/sb9pA
         ms+8eWGH/KKsw6B9UiTPcVx5nsQkq5RnmbmmA8ayOSUx5Fbgg4ngiQ1wboFrj4qrslbK
         1QDn+7KkBd3J6N5cH+f/mSCNTA+TZhe9i5xWSA/c7617uhkSbah+yGD+dMDk1tHSmhEq
         H6AFml9Vjvo4X2E9MH07gbPGfiaKwmPhoqWqaW62R+AfYbKzgdvscoPzoYPBJba4gZE1
         Mupg==
X-Gm-Message-State: AOAM532abJu3CvJ/AlWNZ4N6lZzv/YaGy7uPovjMq53FllTf3R+SMHHi
        9Frl3cPxEThCP0k/Vn6oYdK1ch2kgbeKG6m8DEPuMQ==
X-Google-Smtp-Source: ABdhPJySpPX6QHf8ywX5RJ59cJxtxN4flpJfHh60Dbv2+K/D4L/YTKvNUh1kczQNHlWM2AMorORa3eoSTXALlwNfhsY=
X-Received: by 2002:a5e:c112:: with SMTP id v18mr8532136iol.195.1603041419699;
 Sun, 18 Oct 2020 10:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201012194618.2170970-1-fparent@baylibre.com>
 <61fe6278-a628-820c-6bbd-eeac51b1e7c3@gmail.com> <20201018110738.36e3de38@archlinux>
In-Reply-To: <20201018110738.36e3de38@archlinux>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Sun, 18 Oct 2020 19:16:49 +0200
Message-ID: <CAOwMV_xxfJqUieArCE-dDS-fy65vGQhcbMwsGqrTFs4-XA0p2Q@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: mediatek: fix unset field
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-iio@vger.kernel.org, chun-hung.wu@mediatek.com,
        alexandru.ardelean@analog.com, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sun, Oct 18, 2020 at 12:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 13 Oct 2020 17:37:12 +0200
> Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
> > On 12/10/2020 21:46, Fabien Parent wrote:
> > > dev_comp field is used in a couple of places but it is never set. This
> > > results in kernel oops when dereferencing a NULL pointer. Set the
> > > `dev_comp` field correctly in the probe function.
> > >
> > > Fixes: 6d97024dce23 ("iio: adc: mediatek: mt6577-auxadc, add mt6765 support")
> > >
> > > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> >
> > Ouch.
> >
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> >
> > > ---
> > >   drivers/iio/adc/mt6577_auxadc.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> > > index ac415cb089cd..7bd48377cd79 100644
> > > --- a/drivers/iio/adc/mt6577_auxadc.c
> > > +++ b/drivers/iio/adc/mt6577_auxadc.c
> > > @@ -276,6 +276,8 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
> > >             goto err_disable_clk;
> > >     }
> > >
> > > +   adc_dev->dev_comp = of_device_get_match_data(&pdev->dev);
> > > +
>
> Could we switch this to device_get_match_data(&pdev->dev)?
>
> Whilst is unlikely this driver will used in a platform using ACPI, there
> is nothing inside the driver itself preventing this (which is good as no
> reason to do so!)   My main motivation for this is to reduce the chances
> of cut and paste of the of_* functions in future driver.
>
> Also switch the headers to linux/property.h and linux/mod_devicetable.h
> to more tightly reflect what we are using in the driver.

I applied these changes in v2.

>
> Thanks,
>
> Jonathan
>
> > >     mutex_init(&adc_dev->lock);
> > >
> > >     mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
> > >
>
