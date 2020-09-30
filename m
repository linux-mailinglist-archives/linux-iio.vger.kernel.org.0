Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB7327E0C1
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 07:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgI3F6J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 01:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3F6I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 01:58:08 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD6AC061755;
        Tue, 29 Sep 2020 22:58:07 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a2so668342otr.11;
        Tue, 29 Sep 2020 22:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u/tscLGHZ4xccYrjqyEwupxAt5kBNN7tUlMMGV+ixMs=;
        b=u7pljynDPU40aN9yo5JU7cDXYY3oxdFJJFWREhUdTqvUzV7BApq41BPqO/4F8VR8F3
         J727/JHEMb+Vk3x5ERPibcO731LZakvfIkw29WOPsPMxQLRlID0edUoRJXMXSeFA1car
         QTcA/m4ZEuLH6yPBNlvt2PTp+SWjmK+sjbSg58tULY0XeScSSd54yHMLl1gaub6fZwmP
         CgA3FUCLXkEj+BP0ih4Fm+CCyT+muMM6u9SLmmpQUFJ572IRm9MlBqJvTH9Kb2tmWi8u
         Sbm+nZ2gU62jQOxmsoY5YIh4UKpECx39+uCf4wV/2szLOUFdWog2fxQ/K3LqGKjYn2YJ
         gH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u/tscLGHZ4xccYrjqyEwupxAt5kBNN7tUlMMGV+ixMs=;
        b=EpDarxsoH8+J2r9oygb4Fp1KLalSC+S3OTjDOMlarO5zlCMspasIHJm0RvC5c9QwLz
         GvQWs6V7piEI5TLF0LcpXwRuQbXutei1vpfI3XCXqHHNYKRbGrfIkyivXH0+CtvD6GID
         hx2sx3HqqsKZbng627q9oih1XPacKZNAy1g/sq24Ek1OuC16DddWARg3oMdLEU0qgEYT
         9hXm9Db2gWgglKo54l+E3+KO7ZMxAFDtRknXc9/dDvNqUHs6D93fEKLdL3blezNxLeva
         lBg1ly+0ZR0BcHA2AEvTN1W+HoehI2ZCuJbhXjGAQWyoMYIt9DbttiBFlUXT0ZDdxUzU
         mTMA==
X-Gm-Message-State: AOAM531Avd6NtoC6tF1i/r5IRo5zIFGMoMcjePzbEyU+UGc7de8vvWXB
        RYItqPsC3fdM1Osjkk2Howp/rJF9/izuldYjMkA=
X-Google-Smtp-Source: ABdhPJxTN9+cQqtSYl2wkOy8mrYevlokP0ZgooKhMGz9f30W339YoQNy4jof3fuSbWBKmnzb3qYrQZlJXARscUqw0jw=
X-Received: by 2002:a9d:50a:: with SMTP id 10mr524748otw.207.1601445486821;
 Tue, 29 Sep 2020 22:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200928131333.36646-1-mircea.caprioru@analog.com>
 <20200928131333.36646-4-mircea.caprioru@analog.com> <20200929171441.5b4ff8c8@archlinux>
In-Reply-To: <20200929171441.5b4ff8c8@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 30 Sep 2020 08:57:55 +0300
Message-ID: <CA+U=DsqDymuWht_H1z+TnTvcXbnuJ9tm45w4g_U6g=qWz+fGvQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] iio: adc: vf610_adc: Replace indio_dev->mlock with
 own device lock
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mircea Caprioru <mircea.caprioru@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 29, 2020 at 7:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 28 Sep 2020 16:13:32 +0300
> Mircea Caprioru <mircea.caprioru@analog.com> wrote:
>
> > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> >
> > As part of the general cleanup of indio_dev->mlock, this change replaces
> > it with a local lock on the device's state structure.
> >
> > This is part of a bigger cleanup.
> > Link: https://lore.kernel.org/linux-iio/CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com/
> >
> > Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
>
> There are more problems in the locking in here than just this one.
> See below.  The taking of mlock like this was what originally motivated
> the efforts to hide it away from drivers.
>
> In this particular case I don't think a local lock is the correct solution.
>
> Thanks,
>
> Jonathan
>
>
> > ---
> >  drivers/iio/adc/vf610_adc.c | 28 ++++++++++++++++++++--------
> >  1 file changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> > index 1d794cf3e3f1..b7d583993f0b 100644
> > --- a/drivers/iio/adc/vf610_adc.c
> > +++ b/drivers/iio/adc/vf610_adc.c
> > @@ -168,6 +168,15 @@ struct vf610_adc {
> >
> >       struct completion completion;
> >       u16 buffer[8];
>
> Side note.  That buffer isn't correctly aligned.  I'll add this one to
> my next series fixing those.
>
> > +     /*
> > +      * Lock to protect the device state during a potential concurrent
> > +      * read access from userspace. Reading a raw value requires a sequence
> > +      * of register writes, then a wait for a completion callback,
> > +      * and finally a register read, during which userspace could issue
> > +      * another read request. This lock protects a read access from
> > +      * ocurring before another one has finished.
> > +      */
> > +     struct mutex lock;
> >  };
> >
> >  static const u32 vf610_hw_avgs[] = { 1, 4, 8, 16, 32 };
> > @@ -464,11 +473,11 @@ static int vf610_set_conversion_mode(struct iio_dev *indio_dev,
> >  {
> >       struct vf610_adc *info = iio_priv(indio_dev);
> >
> > -     mutex_lock(&indio_dev->mlock);
> > +     mutex_lock(&info->lock);
> Hmm. So there is a bit of a question on what the locking here is doing.
> (see below for a different use of mlock).
>
> What it will do currently is to prevent the conversion mode changing whilst
> we are in buffered mode.  It will also protect against concurrent
> calls of this function.
>
> I would replace this with iio_device_claim_direct_mode() rather than a
> local lock.

This raises a new question: if there's any drivers that we missed [for
iio_device_claim_direct_mode()].
While I was aware of iio_device_claim_direct_mode(), I missed this
fact when pushing the mlock cleanup.

Oh well, I'll do a quick audit over the current drivers that were converted.
Hopefully I don't find anything :P

>
> >       info->adc_feature.conv_mode = mode;
> >       vf610_adc_calculate_rates(info);
> >       vf610_adc_hw_init(info);
> > -     mutex_unlock(&indio_dev->mlock);
> > +     mutex_unlock(&info->lock);
> >
> >       return 0;
> >  }
> > @@ -632,9 +641,9 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
> >       switch (mask) {
> >       case IIO_CHAN_INFO_RAW:
> >       case IIO_CHAN_INFO_PROCESSED:
> > -             mutex_lock(&indio_dev->mlock);
> > +             mutex_lock(&info->lock);
> >               if (iio_buffer_enabled(indio_dev)) {
> > -                     mutex_unlock(&indio_dev->mlock);
> > +                     mutex_unlock(&info->lock);
>
> Should be use iio_device_claim_direct_mode()
>
> mlock is being taken here to stop us entering buffered mode.
>
> Whilst I'd rather a driver didn't rely on internal details of
> IIO, it is rather fiddly to get the locking right when there is a completion
> going on, so I think here you are safe to do so.
>
> >                       return -EBUSY;
> >               }
> >
> > @@ -645,11 +654,11 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
> >               ret = wait_for_completion_interruptible_timeout
> >                               (&info->completion, VF610_ADC_TIMEOUT);
> >               if (ret == 0) {
> > -                     mutex_unlock(&indio_dev->mlock);
> > +                     mutex_unlock(&info->lock);
> >                       return -ETIMEDOUT;
> >               }
> >               if (ret < 0) {
> > -                     mutex_unlock(&indio_dev->mlock);
> > +                     mutex_unlock(&info->lock);
> >                       return ret;
> >               }
> >
> > @@ -668,11 +677,11 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
> >
> >                       break;
> >               default:
> > -                     mutex_unlock(&indio_dev->mlock);
> > +                     mutex_unlock(&info->lock);
> >                       return -EINVAL;
> >               }
> >
> > -             mutex_unlock(&indio_dev->mlock);
> > +             mutex_unlock(&info->lock);
> >               return IIO_VAL_INT;
> >
> >       case IIO_CHAN_INFO_SCALE:
> > @@ -807,6 +816,9 @@ static int vf610_adc_probe(struct platform_device *pdev)
> >       }
> >
> >       info = iio_priv(indio_dev);
> > +
> > +     mutex_init(&info->lock);
> > +
> >       info->dev = &pdev->dev;
> >
> >       info->regs = devm_platform_ioremap_resource(pdev, 0);
>
