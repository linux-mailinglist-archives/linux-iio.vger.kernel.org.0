Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAE13E926D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2019 22:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfJ2V61 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Oct 2019 17:58:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40559 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbfJ2V61 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2019 17:58:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id f4so5710369lfk.7;
        Tue, 29 Oct 2019 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UO6breZIX8wufz2DetE33SaJQBNJUnFXRb083pTIPVM=;
        b=loewWdgjtq+zmaGLulYqSZ7GE8rNdvpHmVbC3FU3RXnABnH6uK7Kt1cG3htvZ1mb54
         llqibIQrV9wl8uagBrs+tSjXewoig5sfnBI1kJrhfOXhGLXB3q60tOMRQG+N8qgAfvU6
         SmnkIkE4x6xmRGmXhGvU7S/r1Sj6hIkm4M+K8M2268mPUgLe0VirRnO5DBXnmRL74A65
         WESpHxlpXmMMnCiMvK18i54iUBil8E2TSWMvEM48DT8oS1ix4XrcizcQTNoqrYsg8iJc
         Dhj2N0Q96Pslg2WcCe7EQmCjd3ipn0WIOGjjyEuQfaYyAVhp5ElJT+hVDvDevk2kCdjN
         Nvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UO6breZIX8wufz2DetE33SaJQBNJUnFXRb083pTIPVM=;
        b=hyuqdo1gt4qVJu1uIprLJZt97qp8WU5cvFceiWQ/I0w7KW4dQMWi/9P2HFecMUwPA4
         kXSPaXeHdF2O+yRHX6rVmRk5U0sCcF+1CJqsNM/HTkdJpy9UDbaxQ/FTFAZypjx+Nt7G
         1osGE+NxHxlHLajd8Cu/F2pb8CdrvBuSfVqhDYJhGOjUjU5TRHTPphcujZ/TW7ML6zP/
         XoP+97vSIWAVWs7aXhubpnX1956HcC5MyWjNvfO0eJ0wVlqEE3cPRx22ppQRU0aEOHcH
         Ong1uKhIaA1AV5BQOn3rD/tjkV3UvS1q5a6w5yd6mu7BDRbws8x0l9PY6FzUIN1bsg6J
         pazQ==
X-Gm-Message-State: APjAAAUp22hEh/bNW1DA7PfVRryPkaIn0Mde74+vQzr48t9Te1K1CIis
        33qfzR1vk+qPF19OqCZWz7vfQrfu20cHtIEo/Je+aN9h
X-Google-Smtp-Source: APXvYqx5/KHIfGSp7upif3CSUTqa8+IOLkKx8NdUhTGkUIzVZH+otQ6dcbMU/jNlMKFhGlhL4+u9FeOGbykQTe9i2mM=
X-Received: by 2002:a05:6512:409:: with SMTP id u9mr3860895lfk.0.1572386304531;
 Tue, 29 Oct 2019 14:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191023082634.18195-1-alexandru.ardelean@analog.com> <20191027165651.1da18263@archlinux>
In-Reply-To: <20191027165651.1da18263@archlinux>
From:   Jack Andersen <jackoalan@gmail.com>
Date:   Tue, 29 Oct 2019 11:58:16 -1000
Message-ID: <CAPHBK3a-EQVZzF-LZC-jNCinF3i09PRG7ZA+hporMr5JvFpDtQ@mail.gmail.com>
Subject: Re: [PATCH] iio: dln2-adc: fix iio_triggered_buffer_postenable() position
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These changes look fine to me as well.

I no longer have access to a DLN2 for empirical testing, but since this is
mainly integration improvements with the IIO side of things, it shouldn't make
a difference for the hardware.



On Sun, 27 Oct 2019 at 06:56, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 23 Oct 2019 11:26:34 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > The iio_triggered_buffer_postenable() hook should be called first to
> > attach the poll function. The iio_triggered_buffer_predisable() hook is
> > called last (as is it should).
> >
> > This change moves iio_triggered_buffer_postenable() to be called first. It
> > adds iio_triggered_buffer_predisable() on the error paths of the postenable
> > hook.
> > For the predisable hook, some code-paths have been changed to make sure
> > that the iio_triggered_buffer_predisable() hook gets called in case there
> > is an error before it.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> +CC Jack who wrote the driver.
>
> Looks fine to me, but I always like these to sit for a while and ideally get
> review from the authors / maintainers of the drivers.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/adc/dln2-adc.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> > index 5fa78c273a25..65c7c9329b1c 100644
> > --- a/drivers/iio/adc/dln2-adc.c
> > +++ b/drivers/iio/adc/dln2-adc.c
> > @@ -524,6 +524,10 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
> >       u16 conflict;
> >       unsigned int trigger_chan;
> >
> > +     ret = iio_triggered_buffer_postenable(indio_dev);
> > +     if (ret)
> > +             return ret;
> > +
> >       mutex_lock(&dln2->mutex);
> >
> >       /* Enable ADC */
> > @@ -537,6 +541,7 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
> >                               (int)conflict);
> >                       ret = -EBUSY;
> >               }
> > +             iio_triggered_buffer_predisable(indio_dev);
> >               return ret;
> >       }
> >
> > @@ -550,6 +555,7 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
> >               mutex_unlock(&dln2->mutex);
> >               if (ret < 0) {
> >                       dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> > +                     iio_triggered_buffer_predisable(indio_dev);
> >                       return ret;
> >               }
> >       } else {
> > @@ -557,12 +563,12 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
> >               mutex_unlock(&dln2->mutex);
> >       }
> >
> > -     return iio_triggered_buffer_postenable(indio_dev);
> > +     return 0;
> >  }
> >
> >  static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
> >  {
> > -     int ret;
> > +     int ret, ret2;
> >       struct dln2_adc *dln2 = iio_priv(indio_dev);
> >
> >       mutex_lock(&dln2->mutex);
> > @@ -577,12 +583,14 @@ static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
> >       ret = dln2_adc_set_port_enabled(dln2, false, NULL);
> >
> >       mutex_unlock(&dln2->mutex);
> > -     if (ret < 0) {
> > +     if (ret < 0)
> >               dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> > -             return ret;
> > -     }
> >
> > -     return iio_triggered_buffer_predisable(indio_dev);
> > +     ret2 = iio_triggered_buffer_predisable(indio_dev);
> > +     if (ret == 0)
> > +             ret = ret2;
> > +
> > +     return ret;
> >  }
> >
> >  static const struct iio_buffer_setup_ops dln2_adc_buffer_setup_ops = {
>
