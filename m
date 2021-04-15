Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C423F360427
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 10:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhDOIUs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 04:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhDOIUr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 04:20:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3516C061574
        for <linux-iio@vger.kernel.org>; Thu, 15 Apr 2021 01:20:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so13949652pji.5
        for <linux-iio@vger.kernel.org>; Thu, 15 Apr 2021 01:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5TxEKY/oiLNJxlC2tQtj/whqVrZyf6XAKgtMawzWbY=;
        b=ZWxeMl/OyM9aGvgmt9AM2fTEgFRq3VNNpZ9Yo5nPLqWMRJfVLIwt6B5kkkgofWH476
         7LLcW2U1cLntCEFncTyh8+HHcJAtS+r9T60Xbx281Kl6NiXF/Z66L5iHYND+XJAgf0QC
         9sLRHR1mCWrnjh0yjdkYJ3PNYpYx87jMRKYRREtDaHpG1hw11FXKcfuBXVfCb8IIznHE
         MdeAVzX4LmFc5HopozBEt4oFO+VGTEZnfZBWrB3TQhIDCvNgJbtwslRZTlFwRhhlsVBi
         P4mfj5bJDHsr0FTWm5tKg6Vokvp26GodItgWrbHv9H5fL+z4DgJMnYjjdttvsr/N/qPd
         w/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5TxEKY/oiLNJxlC2tQtj/whqVrZyf6XAKgtMawzWbY=;
        b=n5Xy+v1PCm9OvtRMImkYbplN1HuAPJBO+3YfHkjmAS5+kJzVReI3dAJPqf1RzE2dAe
         SHtx6DGUNvoSLuccqV0c5KZxifvN2KWKss8urFwiezEbtRfLvVZmAhkzSk+IEQl2x/Xn
         +8YeWMkYFpxq7YlWK2QPShuDdmvE15+AKYG+hTbpDmmV3wLp+pCwiA09uhAVJ5bSQ4u0
         H7KdqWB9zVuV5n2KHUlLCVovnvgH8oaiK0oSmcQoO9fSjU2Jr0z7J/AmMFg9N2XGtgB3
         Mw/8tACuAs1GrMsKnyI5EOoe5MKjWhdY3X05+f33a3yKlxqOVdkVRZX5kzPHjUJBviAB
         2row==
X-Gm-Message-State: AOAM533hBMvYpP3rD7eTMIjB0xRsWT7kjj0MhTTagEhgma7fTcD7TOa2
        wJk1BD+0ufqQYaaSy0w64aeOl0RQtewOAqy180Q=
X-Google-Smtp-Source: ABdhPJwiI7r/gwrBU+J3GvwhsKLp/S77KpzT6+85e0tqHmlJB0A7HebcvTuNgzjctfWSh0mkDKGG4gcUdP0q/ok6D70=
X-Received: by 2002:a17:90a:ae10:: with SMTP id t16mr2719047pjq.86.1618474822508;
 Thu, 15 Apr 2021 01:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210413112105.69458-1-nuno.sa@analog.com> <20210413112105.69458-8-nuno.sa@analog.com>
 <CA+U=DsrBUFcwkO900StwY8-8W9fn3z+LZOaJ7YR=9qBQsFi_2w@mail.gmail.com> <CY4PR03MB311236A292933D2C89CB9B53994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
In-Reply-To: <CY4PR03MB311236A292933D2C89CB9B53994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 15 Apr 2021 11:20:10 +0300
Message-ID: <CA+U=Dsr1RF7XNvQ9s77vGERXbmdY4PKGbymXYtZpmoarN+DN7Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: adis_buffer: update device page after changing it
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 15, 2021 at 10:58 AM Sa, Nuno <Nuno.Sa@analog.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Alexandru Ardelean <ardeleanalex@gmail.com>
> > Sent: Wednesday, April 14, 2021 9:39 AM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > <jic23@kernel.org>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> > <lars@metafoo.de>
> > Subject: Re: [PATCH 7/7] iio: adis_buffer: update device page after
> > changing it
> >
> > [External]
> >
> > On Tue, Apr 13, 2021 at 5:45 PM Nuno Sa <nuno.sa@analog.com>
> > wrote:
> > >
> > > With commit 41f2770a07e0 ("iio: adis_buffer: don't push data to
> > buffers on
> > > failure"), we return if 'spi_sync()' fails which would leave
> > > 'adis->current_page' in an incoherent state. Hence, set this variable
> > > right after we change the device page.
> > >
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > >  drivers/iio/imu/adis_buffer.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iio/imu/adis_buffer.c
> > b/drivers/iio/imu/adis_buffer.c
> > > index 73790b71102b..aa37981c28f1 100644
> > > --- a/drivers/iio/imu/adis_buffer.c
> > > +++ b/drivers/iio/imu/adis_buffer.c
> > > @@ -142,6 +142,8 @@ static irqreturn_t adis_trigger_handler(int irq,
> > void *p)
> > >                                 dev_err(&adis->spi->dev, "Failed to change device
> > page: %d\n", ret);
> > >                                 goto irq_done;
> > >                         }
> > > +
> > > +                       adis->current_page = 0;
> >
> > If the above spi_write() fails, this adis->current_page isn't reset.
> > Maybe reset this as the first thing in this if block?
> >
>
> If the 'spi_write()' fails it means that we could not change to page0,
> so we should not update the current_page...

ack
