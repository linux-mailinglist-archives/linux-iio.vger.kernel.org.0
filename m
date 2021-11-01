Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3039B441435
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 08:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhKAHdR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 03:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhKAHdR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 03:33:17 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C121C061714
        for <linux-iio@vger.kernel.org>; Mon,  1 Nov 2021 00:30:44 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id k1so2214380ilo.7
        for <linux-iio@vger.kernel.org>; Mon, 01 Nov 2021 00:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xU2cXrqOXyOLtBq5BiTmyyx5wFqXZ6uaNrFpZguPuls=;
        b=PmAggCQW4Is+Gf1CvDphSCwX8vn7rqQVeCr1swRo76GvL2Vf+FQzQy6V5n6IiFZ5el
         WY92PqSm8h+BVbkVjVSkQ5gJlm+hTsNB5VBNtKKSmETma+5eQLTeyIgm8zMEfuPHGwQw
         iHBkshnO7tFECY4IsPoRSWZUxpG7+NUGgw4CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xU2cXrqOXyOLtBq5BiTmyyx5wFqXZ6uaNrFpZguPuls=;
        b=LGBUizbsmgcHM18F3upn/SKN0kwG2WIeFfkeOd82JRW1O1IEtgb5HbPuG8QzWAdwh3
         qMmjxp0bhgtqy9ilitVCOM1a9y1H0e6M1QT2gKEjGmBvZ+SIh5f1DhdFjzelRIo+SBQ8
         OghajuEC8hySap+YbMico1ZHA+s1ZUAjiRtyYvjjDVoX6lJ1tsOrHcas9sNfo97j3y12
         iUw2nmJ/GAOPJJnkGM5j4WZZXgCMRkwGjRP5N668nfxnXultKuDSmCoXqWOnIkTtuwV1
         KX7lnqacWQYf+8cPGbLVh5oEB+UgL+V8/L0zqNlLqLSIMINxnRiG0L0Z7P3XU7nN9S0h
         OTmw==
X-Gm-Message-State: AOAM530ks2zCNvPcUxBs2m+g8Xm7TI3awFgUJjJp0jhzIKPBn5k2dOjq
        WA66VMhFdfh2Ec0hNorJsEbo2jgmiz29YZbV2AQ+4Q==
X-Google-Smtp-Source: ABdhPJzj7jw2CWZieRQMFAUYeMRN8lPJ63qhtoxTIyGN7ItUQr0LnilAhXWwJt1aLq+pY2yDL5MoVTaLCBs1NdEqGl0=
X-Received: by 2002:a05:6e02:17cf:: with SMTP id z15mr18935755ilu.214.1635751843476;
 Mon, 01 Nov 2021 00:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211030111827.1494139-1-gwendal@chromium.org>
 <20211030111827.1494139-2-gwendal@chromium.org> <c71a2781-f5f6-0725-dbdf-aaa823883be1@metafoo.de>
 <20211030170903.68b7e561@jic23-huawei>
In-Reply-To: <20211030170903.68b7e561@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 1 Nov 2021 00:30:31 -0700
Message-ID: <CAPUE2ut-iWNmJEqUEwW=7sb-aqoTLNV-uL6=t3SNQRyQT6ePRg@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: Use .realbits to extend a small signed integer
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, swboyd@chromium.org,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 30, 2021 at 9:04 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 30 Oct 2021 13:35:19 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> > On 10/30/21 1:18 PM, Gwendal Grignou wrote:
> > > When calling sign_extend32() on a channel, use its .realbit information
> > > to limit the number of bits to process, instead of a constant.
> > >
> > > Changed only simple sign_extend32() calls, when .realbits was defined in
> > > the same file. Use 'grep -r sign_extend32 $(grep -lr realbits drivers/iio/)'
> > > to locate the files.
> > >
> > > Some files were not processed:
> > > gyro/fxas21002c_core.c : function parameter changes needed.
> > > health/max30102.c: Incomplete channel definition.
> > > health/max30100.c
> >
> > I think this is good work, but it seems a bit out of place in this
> > series. I think it will be easier to get this reviewed and merged if it
> > is submitted independently. It might make sense to only have the sx9310
> > changes as part of this series and send the other ones as a separate patch.
When moving code to sx9310, I notice we were using constants instead
of realbits, and I look at how other driver deal with bit information.
> >
> > What's also missing in the commit description is the motivation for
> > this. The generated code will be a bit more complex, so there needs to
> > be a good justification. E.g. having a single source of truth for this
> > data and avoiding accidental mistakes.
That's the idea, I will update the commit accordingly.
> >
> > The patch also uses `shift` were applicable, which is not mentioned in
> > the commit dscription.
>
> Be careful.  I have seen devices (with FIFOs) where the realbits doesn't
> necessarily match with a separate read path used for polled reads.
>
> It is an option for the sca3000 for example but that's carrying a hack where
> ignore that and rely on some coincidental data alignment to pretend realbits
> is 13 when it's actually 11.
I see the hack in sca3000_ring_int_process(). The driver reconciles
the FIFO and raw data access by presenting elements as carrying 13
bits of information, assuming the 2 LSB are 0.
Given user space should get the same data when reading using the _raw
attributes or the buffer, given libiio use scan_type information to
process buffer data, (see libiio iio_channel_convert())
it makes sense for the kernel to always use scan_type as well when
presenting the _raw attributes.
>
> Still in general it's a reasonable change but agree with Lars, separate series
> please.
Will do.
>
> >
> >
> > > [...]
> > > diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> > > index 1eb9e7b29e050..355854f0f59d2 100644
> > > --- a/drivers/iio/pressure/mpl3115.c
> > > +++ b/drivers/iio/pressure/mpl3115.c
> > > @@ -74,7 +74,7 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
> > >                         int *val, int *val2, long mask)
> > >   {
> > >     struct mpl3115_data *data = iio_priv(indio_dev);
> > > -   __be32 tmp = 0;
> > > +   __be16 tmp = 0;
> > >     int ret;
> > The be32 to be16 change might warrant its own patch. This is definitely
> > changing the behavior of the driver. And I don't think it is correct the
> > way its done. For the pressure data it is reading 3 bytes, which will
> > cause a stack overflow.
You're right, it is wrong as is. Resent in a separate patch.
> > >
> > >     switch (mask) {
> > > @@ -96,7 +96,7 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
> > >                     mutex_unlock(&data->lock);
> > >                     if (ret < 0)
> > >                             break;
> > > -                   *val = be32_to_cpu(tmp) >> 12;
> > > +                   *val = be32_to_cpu(tmp) >> chan->scan_type.shift;
> > >                     ret = IIO_VAL_INT;
> > >                     break;
> > >             case IIO_TEMP: /* in 0.0625 celsius / LSB */
> > > @@ -111,7 +111,8 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
> > >                     mutex_unlock(&data->lock);
> > >                     if (ret < 0)
> > >                             break;
> > > -                   *val = sign_extend32(be32_to_cpu(tmp) >> 20, 11);
> > > +                   *val = sign_extend32(be16_to_cpu(tmp) >> chan->scan_type.shift,
> > > +                                        chan->scan_type.realbits - 1);
> > >                     ret = IIO_VAL_INT;
> > >                     break;
> > >             default:
> >
>
Thanks for the prompt reviews and the feedback,

Gwendal.
